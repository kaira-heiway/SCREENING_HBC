report 52021 "Update QtyAssigned forCItem PO"
{
    // version HEI.03

    // HEI.01 CHG2234724 CC-INC4993784 IBM MAJUMS03 22.04.2024 # Why PO# PO00003074 in Bukavu tenant is not deleted in the system | PRB2008630
    //   # Update "Qty. Assigned", "Qty. to Assign" and "Amount to Assign" for Charge Items in Item Charge Assignment (Purch) Table for which
    //   PO is fully Recieved, Invoiced and Delivery Finalized = TRUE but "Quantity Invoiced" <> "Qty. to Assign". Please check RCA Document for
    //   details against PRB2008630. Validation is avoided here. This process will be not exposed to any User using MenuSite, it will be run via
    //   Job Queue as per need after checking the POs by StP Team which are requested by OPCO against any Approved RFF+.
    // 
    // HEI.02 CHG2250264 CC-INC5162123 IBM MAJUMS03 07.05.2024 # Source document combination qty to be Assigned on PO Shipping Cost.
    //   # Modifucation for Checking Quantity Invoiced <> (Qty. to Assign" + "Qty. Assigned) instead of comparing it with only Quantity Invoiced
    //   <> Qty. to Assign to incorporate update Item Charge Assignment for Purchase Lines under one PO. Also handling the rounding issue of Qty.
    //   to Assign.
    // 
    // HEI.03 CHG2250264 CC-INC5162123 IBM MAJUMS03 05.06.2024 # Source document combination qty to be Assigned on PO Shipping Cost.
    //   # Previously the Qty Assigned only run for those POs where Type for all lines of the PO must be Charge (Item)  and Delivery Finalized
    //   must be TRUE for all PO Lines. But as per discussion with DRC OPCO, this checked are removed, now this process will run only for Type
    //   Charge (Item) and Delivery Finalized = TRUE PO Lines under any PO.

    //-------------------------------------------------------------------------------------------------------------

    //BC Upgrade KAPOOV01  >>
    // 1. Add layout path and Change extension RDLC to RDL.
    // 2. Add ApplicationArea and UsageCategory property in Report.
    // 3. Old Report ID- 50600.
    // 4. Commented DRINK-IT table variable-PostedDocShpCost->"Posted Document Shipping Cost".
    //BC Upgrade KAPOOV01  <<

    DefaultLayout = RDLC;
    //RDLCLayout = './Update QtyAssigned forCItem PO.rdlc'; //BC Upgrade KAPOOV01 Commented
    RDLCLayout = '.\src\ReportsLayout\Update QtyAssigned forCItem PO.rdl'; //BC Upgrade KAPOOV01-> Add layout path and change layout extension rdlc to rdl

    Permissions = TableData "Purchase Header" = r,
                  TableData "Purchase Line" = r,
                  TableData "Item Charge Assignment (Purch)" = rm;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = FILTER(Order));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                PurchLine.RESET();
                PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Order);
                PurchLine.SETRANGE(PurchLine."Document No.", "Purchase Header"."No.");
                //HEI.03>>
                PurchLine.SETRANGE(PurchLine.Type, PurchLine.Type::"Charge (Item)");
                PurchLine.SETRANGE(PurchLine."Delivery Finalized FND", true);
                //HEI.03<<
                PurchLine.SETAUTOCALCFIELDS(PurchLine."Qty. to Assign", PurchLine."Qty. Assigned");
                if PurchLine.FINDFIRST() then begin
                    repeat
                        //HEI.03>>
                        /*
                        IF NOT (PurchLine.Type IN [PurchLine.Type::"Charge (Item)"]) THEN
                          Flag := TRUE;
                        IF NOT PurchLine."Delivery Finalized" THEN
                          Flag := TRUE;
                        */
                        //HEI.03<<
                        if PurchLine."Quantity Received" <> PurchLine."Quantity Invoiced" then
                            Flag := true;
                        //PurchLine.CALCFIELDS(PurchLine."Qty. to Assign"); //HEI.02
                        //IF PurchLine."Quantity Invoiced" <> PurchLine."Qty. to Assign" THEN //HEI.02
                        //HEI.02>>
                        EVALUATE(RoundOfPrecisionDeci, RoundOfPrecision);
                        if RoundingEnabled then begin
                            if PurchLine."Quantity Invoiced" <> ROUND((PurchLine."Qty. to Assign" + PurchLine."Qty. Assigned"), RoundOfPrecisionDeci, '=') then
                                Flag := true;
                        end else begin
                            if PurchLine."Quantity Invoiced" <> (PurchLine."Qty. to Assign" + PurchLine."Qty. Assigned") then
                                Flag := true;
                        end;
                        //HEI.02<<
                        if Flag then
                            ERROR(EText001, PurchLine."Line No.");

                    until PurchLine.NEXT() = 0;
                end;

                PurchLine.RESET();
                PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Order);
                PurchLine.SETRANGE(PurchLine."Document No.", "Purchase Header"."No.");
                PurchLine.SETRANGE(PurchLine.Type, PurchLine.Type::"Charge (Item)");
                PurchLine.SETRANGE(PurchLine."Delivery Finalized FND", true);
                PurchLine.SETAUTOCALCFIELDS(PurchLine."Qty. Assigned"); //HEI.02
                if PurchLine.FINDFIRST() then begin
                    repeat
                        //PurchLine.CALCFIELDS(PurchLine."Qty. Assigned"); //HEI.02
                        if ((PurchLine."Quantity Received" = PurchLine."Quantity Invoiced") and (PurchLine."Qty. Assigned" <> PurchLine."Quantity Invoiced")) then begin
                            ItemChargeAssignment.RESET();
                            ItemChargeAssignment.SETRANGE("Document Type", PurchLine."Document Type");
                            ItemChargeAssignment.SETRANGE("Document No.", PurchLine."Document No.");
                            ItemChargeAssignment.SETRANGE("Document Line No.", PurchLine."Line No.");
                            if ItemChargeAssignment.FINDFIRST() then
                                repeat
                                    if ItemChargeAssignment."Qty. to Assign" > 0 then begin
                                        //HEI.02>>
                                        if RoundingEnabled then
                                            ItemChargeAssignment."Qty. Assigned" := ROUND(ItemChargeAssignment."Qty. to Assign", RoundOfPrecisionDeci, '=')
                                        else
                                            //HEI.02<<
                                            ItemChargeAssignment."Qty. Assigned" := ItemChargeAssignment."Qty. to Assign";
                                        ItemChargeAssignment."Qty. to Assign" := 0;
                                        ItemChargeAssignment."Amount to Assign" := 0;
                                        ItemChargeAssignment.MODIFY(true);
                                    end;
                                until ItemChargeAssignment.NEXT() = 0;
                        end;
                    until PurchLine.NEXT() = 0;
                end;
                //<<HEI.01

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(RoundingEnabled; RoundingEnabled)
                {
                    Caption = 'Rounding Enabled';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        if RoundingEnabled then
                            RoundOfPrecision := '0.00001'
                        else
                            RoundOfPrecision := '';
                        //HEI.02<<
                    end;
                }
                field(RoundingofPrecision; RoundOfPrecision)
                {
                    Caption = 'Rounding of Precision';
                    ApplicationArea = All;
                    //DecimalPlaces = 0 : 9;  //BC Upgrade KAPOOV01 "The property 'DecimalPlaces' can only be used if the field's type is 'Decimal'."
                }
                field(Label; Text001)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchLine: Record "Purchase Line";
        Flag: Boolean;
        EText001: TextConst ENU = 'PO either has PO Line other than Type=Charge Item or Quantity Recieved <> Qunatity Invoiced or Qunatity Invoiced <> Qty to Assign + Qty Assigned for Puchase Line # %1.';
        //PostedDocShpCost : Record "Posted Document Shipping Cost";  //BC Upgrade KAPOOV01 Drink-IT
        ItemChargeAssignment: Record "Item Charge Assignment (Purch)";
        RoundingEnabled: Boolean;
        RoundOfPrecision: Text;
        RoundOfPrecisionDeci: Decimal;
        Text001: Label 'Rounding Precision Example: 0.1,0.01... 0.000000001';
}

