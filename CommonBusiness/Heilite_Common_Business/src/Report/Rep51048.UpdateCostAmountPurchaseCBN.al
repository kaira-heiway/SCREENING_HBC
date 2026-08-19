report 51048 "Update Cost Amt Purchase CBN"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 04.09.2019 # Actual Product Costing
    //  # New Report created to updated Cost Amount (Purchase)

    Caption = 'Update Cost Amount Purchase';
    Permissions = TableData "Value Entry" = rm;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Document Type" = FILTER("Purchase Receipt" | "Purchase Return Shipment" | "Purchase Invoice" | "Purchase Credit Memo"));
            RequestFilterFields = "Document Type", "Document No.";

            trigger OnAfterGetRecord();
            var
                PurchRcptLine: Record "Purch. Rcpt. Line";
                PurchInvLine: Record "Purch. Inv. Line";
                ReturnShipmentLine: Record "Return Shipment Line";
                PurchCrMemoLine: Record "Purch. Cr. Memo Line";
                Item: Record Item;
            begin
                Item.GET("Value Entry"."Item No.");

                if "Document Type" = "Document Type"::"Purchase Receipt" then begin
                    PurchRcptLine.SETRANGE("Document No.", "Document No.");
                    PurchRcptLine.SETRANGE("Posting Date", "Posting Date");
                    PurchRcptLine.SETRANGE("Line No.", "Document Line No.");
                    if PurchRcptLine.FINDFIRST() then begin
                        if not Item."Inventory Value Zero" then
                            "Cost Amount (Purchase) FND" := PurchRcptLine."Unit Cost (LCY)" * "Item Ledger Entry Quantity"
                        else
                            "Cost Amount (Purchase) FND" := 0;
                        MODIFY();
                        LinesUpdated += 1;
                    end;
                end else
                    if "Document Type" = "Document Type"::"Purchase Return Shipment" then begin
                        ReturnShipmentLine.SETRANGE("Document No.", "Document No.");
                        ReturnShipmentLine.SETRANGE("Posting Date", "Posting Date");
                        ReturnShipmentLine.SETRANGE("Line No.", "Document Line No.");
                        if ReturnShipmentLine.FINDFIRST() then begin
                            if not Item."Inventory Value Zero" then
                                "Cost Amount (Purchase) FND" := ReturnShipmentLine."Unit Cost (LCY)" * "Item Ledger Entry Quantity"
                            else
                                "Cost Amount (Purchase) FND" := 0;
                            MODIFY();
                            LinesUpdated += 1;
                        end;
                    end else
                        if "Document Type" = "Document Type"::"Purchase Invoice" then begin
                            PurchInvLine.SETRANGE("Document No.", "Document No.");
                            PurchInvLine.SETRANGE("Posting Date", "Posting Date");
                            PurchInvLine.SETRANGE("Line No.", "Document Line No.");
                            if PurchInvLine.FINDFIRST() then begin
                                if not Item."Inventory Value Zero" and ("Entry Type" = "Entry Type"::"Direct Cost") then
                                    "Cost Amount (Purchase) FND" := PurchInvLine."Unit Cost (LCY)" * PurchInvLine.Quantity * (-1)
                                else
                                    "Cost Amount (Purchase) FND" := 0;
                                MODIFY();
                                LinesUpdated += 1;
                            end;
                        end else
                            if ("Document Type" = "Document Type"::"Purchase Credit Memo") then begin
                                PurchCrMemoLine.SETRANGE("Document No.", "Document No.");
                                PurchCrMemoLine.SETRANGE("Posting Date", "Posting Date");
                                PurchCrMemoLine.SETRANGE("Line No.", "Document Line No.");
                                if PurchCrMemoLine.FINDFIRST() then begin
                                    if not Item."Inventory Value Zero" and ("Entry Type" = "Entry Type"::"Direct Cost") then
                                        "Cost Amount (Purchase) FND" := PurchCrMemoLine."Unit Cost (LCY)" * PurchInvLine.Quantity * (-1)
                                    else
                                        "Cost Amount (Purchase) FND" := 0;
                                    MODIFY();
                                    LinesUpdated += 1;
                                end;
                            end;
            end;

            trigger OnPreDataItem();
            begin
                LinesUpdated := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        //MESSAGE(TotalLinesUpdatedMsg,LinesUpdated); //HEI.02
    end;

    var
        LinesUpdated: Integer;
        TotalLinesUpdatedMsg: Label '%1 lines were updated.';
}

