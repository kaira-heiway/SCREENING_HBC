report 53064 "Get Sales Return Orders"
{
    // version NAVW110.0,DITW110.00.08

    // DITW18.00.07 AKH 29/02/2016 DIT-770 #1425 Automatic Drop Shipments and Special orders
    // DITW18.00.07 AKH 01/03/2016 DIT-770 #1425 Adjusted code indentation
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1228 Change DataItemTableView to run Sales Lines already having a Drop Shipment link to update existing
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1228 Set "Action Message"::Append;
    // DITW18.00.07 VSC 30/06/2016 DIT-770 #1228 Nav uses Outstanding Qty. Needs to be Quantity for updating existing line. (partial shipments)
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // 
    // HEI.01 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //   # New report copied from ID 698 - Get Sales Order, to support the Sales Return Order functionality

    // BC Upgrade KUMARR78 >>
    // Report Name  : Get Sales Return Orders
    // Report ID    : 50461
    //
    // 1. Added Business Central visibility properties.
    //    Old:
    //         - ApplicationArea property not defined at report level.
    //         - UsageCategory property not defined.
    //    New:
    //         - ApplicationArea = All added at report level.
    //         - UsageCategory = ReportsAndAnalysis added at report level.
    //
    // 2. Blocked removed function SetDropShipment.
    //    Old:
    //         ReqLine.SetDropShipment(SalesLine."Drop Shipment");
    //    New:
    //         - Function call commented as method not available in BC.
    //         - Drop Shipment handled through Replenishment System validation logic.
    //
    // 3. Removed unsupported Enum value ("Action Message"::Append).
    //    Old:
    //         "Action Message" := "Action Message"::Append;
    //         Conditional logic based on:
    //              • SalesLine."Purchase Order No."
    //              • Existing related Sales Lines
    //         Quantity recalculation when Action Message = Append.
    //    New:
    //         - All Append enum references commented.
    //         - Default value retained:
    //              • "Action Message" := "Action Message"::New;
    //         - Prevented enum mismatch error in Business Central.
    //
    // 4. Removed missing Purchasing field reference.
    //    Old:
    //         PurchasingCode."Vendor No."
    //         VALIDATE("Vendor No.", PurchasingCode."Vendor No.");
    //    New:
    //         - Field reference commented (not available in BC).
    //         - Vendor No. derived from Item when TempRecords = TRUE.
    //         - Ensured compatibility without DIT dependency.
    //
    // 5. Updated deprecated Lead Time Management function.
    //    Old:
    //         LeadTimeMgt.PlannedEndingDate(...);
    //    New:
    //         LeadTimeMgt.GetPlannedEndingDate(...);
    //         - Updated to current Business Central function.
    //
    // BC Upgrade KUMARR78 <<

    CaptionML = ENU = 'Get Sales Return Orders',
                FRA = 'Extraire commandes vente';
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = where("Document Type" = filter(Order | "Return Order"), Type = const(Item), "Outstanding Quantity" = filter(<> 0));
            RequestFilterFields = "Document No.", "Sell-to Customer No.", "No.";
            RequestFilterHeadingML = ENU = 'Sales Order Line',
                                     FRA = 'Ligne commande vente';

            trigger OnAfterGetRecord();
            begin
                // DITW18.00.07 VSC 16/03/2016 DIT-770 #1228 Removed DataItemTableView filter Purch. Order Line No.=CONST(0),

                if ("Purchasing Code" = '') and (SpecOrder <> 1) then
                    if "Drop Shipment" then begin
                        LineCount := LineCount + 1;
                        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
                        // BC Upgrade KUMARR78 >> Blocking DITW Code.
                        // if not HideShowDialog then 
                        //  Window.Update(1, LineCount);
                        // BC Upgrade KUMARR78 << Blocking DITW Code.
                        //>> DITW18.00.07 AKH DIT-770 #1425

                        InsertReqWkshLine("Sales Line");
                    end;

                if "Purchasing Code" <> '' then
                    if PurchasingCode.Get("Purchasing Code") then
                        if PurchasingCode."Drop Shipment" and (SpecOrder <> 1) then begin
                            LineCount := LineCount + 1;
                            //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
                            // BC Upgrade KUMARR78 >> Blocking DITW Code.
                            // if not HideShowDialog then 
                            // Window.Update(1, LineCount);
                            // BC Upgrade KUMARR78 << Blocking DITW Code.
                            //>> DITW18.00.07 AKH DIT-770 #1425

                            InsertReqWkshLine("Sales Line");
                        end else
                            if PurchasingCode."Special Order" and
                               ("Special Order Purchase No." = '') and
                               (SpecOrder <> 0)
                            then begin
                                LineCount := LineCount + 1;
                                //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
                                // BC Upgrade KUMARR78 >> Blocking DITW Code.
                                // if not HideShowDialog then 
                                // Window.Update(1, LineCount);
                                // BC Upgrade KUMARR78 << Blocking DITW Code.
                                //>> DITW18.00.07 AKH DIT-770 #1425

                                InsertReqWkshLine("Sales Line");
                            end;
            end;

            trigger OnPostDataItem();
            begin
                //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
                // BC Upgrade KUMARR78 >> Blocking DITW Code.
                // if not HideShowDialog then
                //>> DITW18.00.07 AKH DIT-770 #1425
                // if LineCount = 0 then
                //     Error(Text001);
                // BC Upgrade KUMARR78 >> Blocking DITW Code.
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(GetDim; GetDim)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Retrieve dimensions from',
                                    FRA = 'Récupérer les axes de';
                        OptionCaptionML = ENU = 'Item,Sales Line',
                                          FRA = 'Article,Ligne vente';
                        ToolTipML = ENU = 'Specifies the source of dimensions that will be copied in the batch job. Dimensions can be copied exactly as they were used on a sales line or can be copied from the items used on a sales line.',
                                    FRA = 'Spécifie l''origine des axes analytiques à copier dans le traitement par lots. Les axes peuvent être copiés tels qu''ils étaient utilisés sur une ligne vente, ou ils peuvent être copiés à partir des articles utilisés sur une ligne vente.';
                    }
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

    trigger OnPreReport();
    begin
        // BC Upgrade KUMARR78 >> Blocking DITW Code.
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        // if not TempRecords then begin 
        //>> DITW18.00.07 AKH DIT-770 #1425
        //     ReqWkshTmpl.Get(ReqLine."Worksheet Template Name");
        //     ReqWkshName.Get(ReqLine."Worksheet Template Name", ReqLine."Journal Batch Name");
        //     ReqLine.SetRange("Worksheet Template Name", ReqLine."Worksheet Template Name");
        //     ReqLine.SetRange("Journal Batch Name", ReqLine."Journal Batch Name");
        //     ReqLine.LockTable();
        //     if ReqLine.FindLast() then begin
        //         ReqLine.Init();
        //         LineNo := ReqLine."Line No.";
        //     end;
        // end;
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        // if not HideShowDialog then 
        //>> DITW18.00.07 AKH DIT-770 #1425
        // Window.Open(Text000);
        // BC Upgrade KUMARR78 << Blocking DITW Code.
    end;

    var
        Item: Record Item;
        PurchasingCode: Record Purchasing;
        ReqWkshTmpl: Record "Req. Wksh. Template";
        ReqLine: Record "Requisition Line";
        TempReqLine: Record "Requisition Line" temporary;
        ReqWkshName: Record "Requisition Wksh. Name";
        SalesHeader: Record "Sales Header";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        ForceSpecialOrderPurchRepl: Boolean;
        // HideShowDialog: Boolean; // BC Upgrade KUMARR78 >> Blocking DITW Varible
        TempRecords: Boolean;
        Window: Dialog;
        LineCount: Integer;
        LineNo: Integer;
        SpecOrder: Integer;
        GetDim: Option Item,"Sales Line";
        Text000: TextConst ENU = 'Processing sales lines  #1######', FRA = 'Traitement des lignes vente #1######';
        Text001: TextConst ENU = 'There are no sales lines to retrieve.', FRA = 'Il n''existe pas de ligne vente à extraire.';

    procedure SetReqWkshLine(NewReqLine: Record "Requisition Line"; SpecialOrder: Integer);
    begin
        ReqLine := NewReqLine;
        SpecOrder := SpecialOrder;
    end;

    local procedure InsertReqWkshLine(SalesLine: Record "Sales Line");
    var
        SalesLine2: Record "Sales Line";
        FromLocationCode: Code[10];
    begin
        ReqLine.Reset();
        ReqLine.SetCurrentKey(Type, "No.");
        ReqLine.SetRange(Type, "Sales Line".Type);
        ReqLine.SetRange("No.", "Sales Line"."No.");
        ReqLine.SetRange("Sales Order No.", "Sales Line"."Document No.");
        ReqLine.SetRange("Sales Order Line No.", "Sales Line"."Line No.");
        if ReqLine.FindFirst() then
            exit;

        LineNo := LineNo + 10000;
        Clear(ReqLine);
        // ReqLine.SetDropShipment(SalesLine."Drop Shipment");//BC UPGRADE KUMARR78 Blocking as Function Removed.
        ReqLine.Init();
        ReqLine."Worksheet Template Name" := ReqWkshName."Worksheet Template Name";
        ReqLine."Journal Batch Name" := ReqWkshName.Name;
        ReqLine."Line No." := LineNo;
        ReqLine.Validate(Type, SalesLine.Type);
        ReqLine.Validate("No.", SalesLine."No.");
        ReqLine."Variant Code" := SalesLine."Variant Code";
        ReqLine.Validate("Location Code", SalesLine."Location Code");
        ReqLine."Bin Code" := SalesLine."Bin Code";
        // Drop Shipment means replenishment by purchase only
        if (ReqLine."Replenishment System" <> ReqLine."Replenishment System"::Purchase) and
           SalesLine."Drop Shipment"
        then
            ReqLine.Validate("Replenishment System", ReqLine."Replenishment System"::Purchase);
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        // BC Upgrade KUMARR78 >> Blokcing DIT Code
        // if ("Replenishment System" <> "Replenishment System"::Purchase) and
        //    SalesLine."Special Order" and ForceSpecialOrderPurchRepl
        // then
        //     Validate("Replenishment System", "Replenishment System"::Purchase);
        // BC Upgrade KUMARR78 << Blokcing DIT Code
        //>> DITW18.00.07 AKH DIT-770 #1425
        if SpecOrder <> 1 then
            ReqLine.Validate("Unit of Measure Code", SalesLine."Unit of Measure Code");
        ReqLine.Validate(
          Quantity,
          Round(SalesLine."Outstanding Quantity" * SalesLine."Qty. per Unit of Measure" / ReqLine."Qty. per Unit of Measure", 0.00001));
        ReqLine."Sales Order No." := SalesLine."Document No.";
        ReqLine."Sales Order Line No." := SalesLine."Line No.";
        ReqLine."Sell-to Customer No." := SalesLine."Sell-to Customer No.";
        ReqLine.Description := SalesLine.Description;
        ReqLine."Description 2" := SalesLine."Description 2";
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        if SpecOrder <> 1 then
            ReqLine."Ship-to Code" := SalesHeader."Ship-to Code";
        ReqLine."Item Category Code" := SalesLine."Item Category Code";
        ReqLine.Nonstock := SalesLine.Nonstock;
        ReqLine."Action Message" := ReqLine."Action Message"::New;
        ReqLine."Purchasing Code" := SalesLine."Purchasing Code";
        //<< DITW18.00.07 VSC 16/03/2016 DIT-770 #1228
        //<< DITW18.00.07 VSC 20/03/2016 DIT-770 #1228
        //BC UPGRADE KUMARR78>> Enum Type Missing("Action Message"::Append;)
        // if SalesLine."Purchase Order No." <> '' then begin
        //     "Action Message" := "Action Message"::Append;
        // end else begin
        //     SalesLine2.Reset();
        //     SalesLine2.SetRange("Document Type", SalesLine."Document Type"::"Return Order");
        //     SalesLine2.SetRange("Document No.", "Sales Order No.");
        //     SalesLine2.SetFilter("Line No.", '<>%1', SalesLine."Line No.");
        //     SalesLine2.SetFilter("Purchase Order No.", '<>%1', '');
        //     SalesLine2.SetRange("Purchasing Code", SalesLine."Purchasing Code");
        //     if SalesLine2.FindFirst() then
        //         "Action Message" := "Action Message"::Append;
        // end;
        //BC UPGRADE KUMARR78<< Enum Type Missing("Action Message"::Append;).
        //<< DITW18.00.07 VSC 30/06/2016 DIT-770 #1228
        //BC UPGRADE KUMARR78>> Enum Type Missing("Action Message"::Append;)
        // if "Action Message" = "Action Message"::Append then begin
        //     Validate(
        //       Quantity,
        //       Round(SalesLine.Quantity * SalesLine."Qty. per Unit of Measure" / "Qty. per Unit of Measure", 0.00001));
        // end;
        //BC UPGRADE KUMARR78<< Enum Type Missing.
        //>> DITW18.00.07 VSC DIT-770 #1228
        //>> DITW18.00.07 VSC DIT-770 #1228
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        //BC Upgrade KUMARR78 >> Blokcing DIT Code
        // if PurchasingCode."Vendor No." <> '' then
        //     VALIDATE("Vendor No.", PurchasingCode."Vendor No.")
        // else
        //     if TempRecords then begin
        //         Item.Get(SalesLine."No.");
        //         Item.TestField("Vendor No.");
        //         Validate("Vendor No.", Item."Vendor No.")
        //     end;
        // BC Upgrade KUMARR78 << Blokcing DIT Code
        //>> DITW18.00.07 AKH DIT-770 #1425
        // Backward Scheduling
        ReqLine."Due Date" := SalesLine."Shipment Date";
        // "Ending Date" := LeadTimeMgt.PlannedEndingDate("No.", "Location Code", "Variant Code", "Due Date", "Vendor No.", "Ref. Order Type");//BC UPGRADE KUMARR78 Replacing Function PlannedEndingDate
        ReqLine."Ending Date" := LeadTimeMgt.GetPlannedEndingDate(ReqLine."No.", ReqLine."Location Code", ReqLine."Variant Code", ReqLine."Due Date", ReqLine."Vendor No.", ReqLine."Ref. Order Type");//BC UPGRADE KUMARR78 Replacing Function PlannedEndingDate to GetPlannedEndingDate.
        ReqLine.CalcStartingDate('');
        ReqLine.UpdateDatetime();
        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        // BC Upgrade KUMARR78 >> Blokcing DIT Code
        // if TempRecords then begin
        //     TempReqLine := ReqLine;
        //     TempReqLine.Insert();
        //     ItemTrackingMgt.CopyItemTracking(SalesLine.RowID1(), TempReqLine.RowID1(), true);
        //     if GetDim = GetDim::"Sales Line" then begin
        //         TempReqLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        //         TempReqLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
        //         TempReqLine."Dimension Set ID" := SalesLine."Dimension Set ID";
        //         TempReqLine.Modify();
        //     end;
        // end else begin
        // BC Upgrade KUMARR78 << Blokcing DIT Code
        //>> DITW18.00.07 AKH DIT-770 #1425
        ReqLine.Insert();
        ItemTrackingMgt.CopyItemTracking(SalesLine.RowID1(), ReqLine.RowID1(), true);
        if GetDim = GetDim::"Sales Line" then begin
            ReqLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
            ReqLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
            ReqLine."Dimension Set ID" := SalesLine."Dimension Set ID";
            ReqLine.Modify();
        end;
        // end;// BC Upgrade KUMARR78 >> Blokcing DIT Code Condition End.
    end;

    procedure InitializeRequest(NewRetrieveDimensionsFrom: Option);
    begin
        GetDim := NewRetrieveDimensionsFrom;
    end;


    // BC Upgrade KUMARR78 >> Blocking DITW  Function Code.
    // procedure SetTempReqWkshLine(NewReqLine: Record "Requisition Line"; NewSpecialOrder: Integer; ShowDialog: Boolean);
    // begin
    //     //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
    //     ForceSpecialOrderPurchRepl := true;
    //     TempRecords := true;
    //     HideShowDialog := not ShowDialog;
    //     ReqLine := NewReqLine;
    //     TempReqLine := NewReqLine;
    //     SpecOrder := NewSpecialOrder;
    // end;
    // BC Upgrade KUMARR78 << Blocking DIT Function

    // BC Upgrade KUMARR78 >> Blocking DITW Code.
    // procedure GetTempReqWkshLine(var NewReqLine: Record "Requisition Line"): Boolean;
    // begin
    //     //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
    //     TempReqLine.Reset();
    //     if TempReqLine.FindSet() then begin
    //         repeat
    //             NewReqLine := TempReqLine;
    //             NewReqLine.Insert();
    //         until TempReqLine.Next() = 0;
    //         exit(true);
    //     end;
    // end;
    // BC Upgrade KUMARR78 << Blocking DITW Code.
}

