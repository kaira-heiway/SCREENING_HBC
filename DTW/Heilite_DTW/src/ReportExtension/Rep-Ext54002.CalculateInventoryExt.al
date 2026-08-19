namespace HeinekenGeneral.HeinekenGeneral;

using Microsoft.Inventory.Counting.Journal;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Ledger;

reportextension 54002 "CalculateInventoryExt" extends "Calculate Inventory"
{


    // HEI.02 CHG2026978 KUMARN15 14.10.2019
    // # Code change in function InsertItemJnlLine
    // FCE01 07072020 INC2938943/CHG2071092 Changed the key of DataItem ItemLEdger Entries:
    //              - SORTING(Item No.,Location Code,Open,Variant Code,Unit of Measure Code,Lot No.,Serial No.)
    // FCE02 08072020 INC2938943/CHG2071092 Added possiobility to filter per zone from the Warehouse Entry Dataitem

    // HEI.05 CHG2060990 IBM BULIMC01  25.06.2020 #update CCC Code with the value from Bin
    // HEI.06 CHG2145896 IBM BHATTA09  19.07.2022 #update CCC Code with the value from SKU if CCC is missing in Bin
    // HEI.07 CHG2145896 IBM Yadavm05  12.01.2023 #Rollback CCC Code with the value from SKU if CCC is missing in Bin
    // HEI.08 CHG2222964 SAHAL01 05.10.2023 Physical inventory journal too slow
    // # Added and Commented Code to improve performance
    // # Changed the Change No. from CHG2210924 (SC) to CHG2222964 (CC)
    // HEI.09 CHG2222964 IBM PATHAA02/Mimikos 21.11.2023 Physical inventory journal too slow
    // # Code Optimisation to Improve performance
    // # Removed Item Charges Functions as they are not needed and not used in the HeiLite
    // #Process dialog for the Buffer entries
    // HEI.10 CHG2222964 IBM PATHAA02/Mimikos 27.11.2023 Physical inventory journal too slow
    // # Code Optimisation to Improve performance using Queries
    // # Changes done in Functions UpdateBuffer, RetrieveBuffer, ItemBinLocationIsCalculated (On paramenters and data fetched from Query)
    // HEI.11 CHG2222964 IBM PATHAA02/Mimikos 29.11.2023 #Physical inventory journal too slow
    // # Use of SETFILTER instead of SETRANGE
    // HEI.12 CHG2222964 IBM PATHAA02/Mimikos 05.12.2023 Physical inventory journal too slow
    // # Code Optimisation to Improve performance (fixing old bug)
    // HEI.13 CHG2234148 IBM PRASAA03/Mimikos 05.01.2024 Calucalte Inventory within Phys. Inventory Journal does not take filters into account
    // # Code Optimisation to Improve performance (fixing old bug)
    // HEI.14 CHG2234148 IBM PATHAA02/Mimikos 10.01.2024 Calucalte Inventory within Phys. Inventory Journal does not take filters into account
    // # Code Optimisation to Improve performance (fixing old bug)

    // BC Upgrade MISHRS14 >>
    // Created this report extension for Report- 790 "Calculate Inventory"
    // Added HEI.02 tag in CU-50280 subscribed event for OnInsertItemJnlLineOnAfterValidateLocationCode in procedure InsertItemJnLineProcedure.
    // Added HEI.05 tag in CU-50280 subscribed event for OnInsertItemJnlLineOnAfterUpdateDimensionSetID in procedure OnInsertItemJnlLineOnAfterUpdateDimensionSetIDProcedure
    // HEI.06 tag is blocked for now and HEI.07 tag is there in HEI.05 in event in CodeUnit rest are blocked
    // Added HEI.08 tag in OnPostReport.
    // HEI.08 tag present in dataset -Item "OnPreDataItem" trigger and procedure - "InsertItemJnlLine", "InsertQuantityOnHandBuffer", "TransferDim", "CalcWhseQty", "UpdateBuffer", "UpdateQuantityOnHandBuffer", "CalcPhysInvQtyAndInsertItemJnlLine", "CreateDimFromItemDefault", "InsertDim" cannot be modified because its present in Base Report of "Calculate Inventory" by Microsoft.
    // HEI.09 tag present in procedure - "Warehouse Entry - OnPreDataItem" trigger, "InsertItemJnlLine", cannot be modified because its present in Base Report of "Calculate Inventory" by Microsoft.
    // Added HEI.09 tag in CU-50280 subscribed event for OnAfterWhseEntrySetFilters in procedure OnAfterWhseEntrySetFiltersProcedure.
    // Added HEI.09 tag in dataset -Item "OnBeforePostDataItem" trigger.
    // Added HEI.10 tag in OnPostReport trigger.
    // Added HEI.10 tag in Dataset - "Item Ledger Entry" in OnAfterPreDataItem trigger.
    // HEI.10 tag present in procedure - "UpdateBuffer", "RetrieveBuffer", "ItemBinLocationIsCalculated", cannot be modified because its present in Base Report of "Calculate Inventory" by Microsoft.
    // Added HEI.11 tag in Dataset - "Item Ledger Entry" in OnAfterPreDataItem trigger.
    // Added HEI.12 tag in Dataset - "Item Ledger Entry" in OnAfterPreDataItem trigger.
    // Added HEI.13 tag in Dataset - "Item Ledger Entry" in OnAfterPreDataItem trigger.
    // Added HEI.14 tag in Dataset - "Item Ledger Entry" in OnAfterPreDataItem trigger.
    // Added HEI.14 tag in OnPostReport trigger.
    // Added OnBeforePostDataItem - for Item
    // Added OnBeforePreDataItem - for Warehouse Entry
    // Added OnAfterPreDataItem - for Item Ledger Entry
    // Added OnPostReport trigger
    // Removed false from FINDSET to remove warning
    // BC Upgrade MISHRS14 <<

    dataset
    {
        modify(Item)
        {
            trigger OnBeforePostDataItem()
            var
                Window: Dialog;
                Text006: Label 'Processing Buffer Entry: #1####### Total Buffer Entries(approx.): #2#######';
                I: Integer;
                TotalEntries: Integer;
                QuantityOnHandBuffer: Record "Inventory Buffer";

            begin
                //HEI.09<<
                IF NOT HideValidationDialog THEN BEGIN
                    Window.CLOSE();
                    Window.OPEN(Text006);
                    I := 0;
                END;
                //HEI.09>>

                //HEI.08>>
                TotalEntries := QuantityOnHandBuffer.COUNT; //HEI.09
                IF FINDSET(FALSE) THEN BEGIN
                    //HEI.08<<

                    REPEAT

                        //HEI.09<<
                        IF NOT HideValidationDialog THEN BEGIN
                            I := I + 1;
                            Window.UPDATE(1, FORMAT(I));
                            Window.UPDATE(2, FORMAT(TotalEntries));
                        END;
                    //HEI.09>>

                    UNTIL NEXT = 0;

                    DELETEALL;
                END;

                //HEI.09<<
                IF NOT HideValidationDialog THEN BEGIN
                    Window.CLOSE();
                END;
                //HEI.09>>
            end;
        }

        //Used OnBeforePreDataItem trigger because PreDataItem is not recognised in BC now.
        modify("Warehouse Entry")
        {
            trigger OnBeforePreDataItem()
            begin
                CurrReport.Skip(); //HEI.09
            end;
        }

        modify("Item Ledger Entry")
        {
            trigger OnAfterPreDataItem()
            var
                qILEInventory: Query "ILE Calculate Inventory CBN";
                ItemVariant: Record "Item Variant";
                ByBin: Boolean;
                ExecuteLoop: Boolean;
                InsertTempSKU: Boolean;
                qWHEInventory: Query "WHE Calculate Inventory";
                ProccessingStep: Integer;
                ProccessingEntry: Integer; // Global VariableS
                Window: Dialog;
                ByLotSerial: Boolean;
                QuantityOnHandBuffer: Record "Inventory Buffer";
            begin

                //HEI.10<<
                ProccessingStep := 0;

                qILEInventory.SETRANGE(qILEInventory.Item_No, Item."No.");
                qILEInventory.SETFILTER(qILEInventory.Location_Code, Item.GETFILTER("Location Filter")); //HEI.11

                IF Item.GETFILTER("Date Filter") <> '' THEN BEGIN //HEI.12
                    qILEInventory.SETFILTER(qILEInventory.Posting_Date, Item.GETFILTER("Date Filter")); //HEI.12
                END;


                qILEInventory.OPEN;
                WHILE qILEInventory.READ DO BEGIN
                    ProccessingEntry := ProccessingEntry + 1;
                    ProccessingStep := ProccessingStep + 1;
                    IF ProccessingStep > 100 THEN BEGIN
                        IF NOT HideValidationDialog THEN BEGIN
                            Window.UPDATE(2, FORMAT(ProccessingEntry));
                            ProccessingStep := 0;
                        END;
                    END;

                    IF NOT GetLocation(qILEInventory.Location_Code) THEN BEGIN //HEI.12
                        CurrReport.SKIP;
                    END;
                    qWHEInventory.SETRANGE(qWHEInventory.Location_Code, qILEInventory.Location_Code);
                    // qWHEInventory.SETRANGE(qWHEInventory.Bin_Code,qILEInventory.Bin_Code); //HEI.12
                    IF Item.GETFILTER("Bin Filter") <> '' THEN BEGIN //HEI.12
                        qWHEInventory.SETRANGE(qWHEInventory.Bin_Code, Item.GETFILTER("Bin Filter")); //HEI.12
                    END; //HEI.12
                    qWHEInventory.SETRANGE(qWHEInventory.Item_No, Item."No.");
                    qWHEInventory.SETRANGE(qWHEInventory.Lot_No, qILEInventory.Lot_No);

                    IF qILEInventory.Serial_No <> '' THEN BEGIN
                        qWHEInventory.SETRANGE(qWHEInventory.Serial_No, qILEInventory.Serial_No);
                    END;

                    IF qILEInventory.Variant_Code <> '' THEN BEGIN
                        qWHEInventory.SETRANGE(qWHEInventory.Variant_Code, qILEInventory.Variant_Code);
                    END;

                    IF ("Warehouse Entry".GETFILTER("Warehouse Entry"."Zone Code") <> '') THEN BEGIN
                        qWHEInventory.SETFILTER(qWHEInventory.Zone_Code, "Warehouse Entry".GETFILTER("Warehouse Entry"."Zone Code")); //HEI.12
                    END;

                    IF Item.GETFILTER("Date Filter") <> '' THEN BEGIN //HEI.12
                        qWHEInventory.SETFILTER(qWHEInventory.Registering_Date, Item.GETFILTER("Date Filter"));
                    END;

                    //HEI.13>>
                    IF NOT ZeroQty THEN BEGIN
                        qWHEInventory.SETFILTER(qWHEInventory.Sum_Qty_Base, '<>%1', 0);
                    END;
                    //HEI.13<<

                    qWHEInventory.OPEN;
                    WHILE qWHEInventory.READ DO BEGIN
                        IF (ByLotSerial = TRUE) THEN BEGIN //HEI.14
                            QuantityOnHandBuffer.INIT();
                            QuantityOnHandBuffer."Item No." := qWHEInventory.Item_No;
                            QuantityOnHandBuffer."Variant Code" := qWHEInventory.Variant_Code;
                            QuantityOnHandBuffer."Dimension Entry No." := ProccessingEntry;
                            QuantityOnHandBuffer."Location Code" := qWHEInventory.Location_Code;
                            QuantityOnHandBuffer."Bin Code" := qWHEInventory.Bin_Code;
                            QuantityOnHandBuffer."Lot No." := qWHEInventory.Lot_No;
                            QuantityOnHandBuffer."Serial No." := qWHEInventory.Serial_No;
                            QuantityOnHandBuffer.Quantity := qWHEInventory.Sum_Qty_Base;
                            QuantityOnHandBuffer.INSERT(FALSE);
                            //HEI.14<<
                        END ELSE BEGIN
                            QuantityOnHandBuffer.RESET();
                            QuantityOnHandBuffer.SETRANGE("Item No.", qWHEInventory.Item_No);
                            QuantityOnHandBuffer.SETRANGE("Location Code", qWHEInventory.Location_Code);
                            QuantityOnHandBuffer.SETRANGE("Bin Code", qWHEInventory.Bin_Code);

                            IF QuantityOnHandBuffer.FINDFIRST() THEN BEGIN
                                QuantityOnHandBuffer.Quantity := QuantityOnHandBuffer.Quantity + qWHEInventory.Sum_Qty_Base;
                                QuantityOnHandBuffer.MODIFY(FALSE);
                            END ELSE BEGIN
                                QuantityOnHandBuffer.INIT();
                                QuantityOnHandBuffer."Item No." := qWHEInventory.Item_No;
                                QuantityOnHandBuffer."Dimension Entry No." := ProccessingEntry;
                                QuantityOnHandBuffer."Location Code" := qWHEInventory.Location_Code;
                                QuantityOnHandBuffer."Bin Code" := qWHEInventory.Bin_Code;
                                QuantityOnHandBuffer.Quantity := qWHEInventory.Sum_Qty_Base;
                                QuantityOnHandBuffer.INSERT(FALSE);
                            END;

                        END;
                        //HEI.14>>
                    END;
                    qWHEInventory.CLOSE();

                END; //HEI.12

                qILEInventory.CLOSE();

                //HEI.10>> 
            end;
        }
    }


    trigger OnPostReport()
    var
        Item2: Record "Item";
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItem: Record Item temporary;
        ItemJnlLine2: Record "Item Journal Line";
        // ItemJnlLine: Record "Item Journal Line";
        recItemSKU: Record "Stockkeeping Unit";
        Window: Dialog;
        Step: Integer;
        TotalNonInvItems: Integer;
        NextLineNo: Integer;
        // PostingDate: Date;
        // NextDocNo: Code[20];
        // HideValidationDialog: Boolean;
        NoMovement: Boolean;
        Text005: Label 'Processing...';
        "Line No.": Integer;
        "Journal Template Name": Code[10];
        "Journal Batch Name": Code[10];
        "Location Code": Code[10];
        "Posting Date": Date;
        "Phys. Inventory": Boolean;
        "Entry Type": Option;

    begin
        // <<PRODW14.00.00.08.12 DDR 14/05/2009
        // -- CITQLT1.00 002 -- Begin

        //HEI.10<<
        IF NOT HideValidationDialog THEN BEGIN
            Window.OPEN(Text005);
        END;
        IF NoMovement THEN BEGIN
            //HEI.10>>

            //HEI.08>>
            //IF Item2.FIND('-') THEN REPEAT
            IF Item2.FINDSET(FALSE) THEN
                REPEAT
                    //HEI.08<<
                    ItemLedgEntry.RESET;
                    //HEI.08>>
                    ItemLedgEntry.SETCURRENTKEY("Item No.");
                    //HEI.08<<
                    ItemLedgEntry.SETRANGE("Item No.", Item2."No.");
                    //HEI.08>>
                    //IF NOT ItemLedgEntry.FIND('-') THEN BEGIN
                    IF ItemLedgEntry.ISEMPTY THEN BEGIN
                        //HEI.08<<
                        TempItem.INIT;
                        TempItem."No." := Item2."No.";
                        //HEI.08>>
                        //TempItem.INSERT;
                        TempItem.INSERT(FALSE);
                        //HEI.08<<
                    END;
                UNTIL Item2.NEXT = 0;

            //HEI.08>>
            //IF TempItem.FIND('-') THEN REPEAT

            IF TempItem.FINDSET(FALSE) THEN
                REPEAT
                    //HEI.08<<
                    //HEI.10<<
                    Step := Step + 1;
                    TotalNonInvItems := TotalNonInvItems + 1;
                    IF (Step > 50) THEN BEGIN
                        IF NOT HideValidationDialog THEN BEGIN
                            Window.UPDATE(1, TotalNonInvItems);
                            Step := 0;
                        END;
                    END;
                    //HEI.10>>

                    NextLineNo := NextLineNo + 10000;
                    //WITH ItemJnlLine2 DO BEGIN
                    ItemJnlLine2.INIT;
                    //HEI.14<<
                    recItemSKU.RESET();
                    recItemSKU.SETFILTER("Item No.", TempItem."No.");
                    recItemSKU.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
                    IF recItemSKU.FINDSET(FALSE) THEN BEGIN
                        //HEI.14>>
                        "Line No." := NextLineNo;
                        "Journal Template Name" := ItemJnlLine."Journal Template Name";
                        "Journal Batch Name" := ItemJnlLine."Journal Batch Name";
                        "Location Code" := recItemSKU."Location Code"; //HEI.14
                        ItemJnlLine2.VALIDATE("Posting Date", PostingDate);
                        ItemJnlLine2.VALIDATE("Entry Type", ItemJnlLine2."Entry Type"::"Positive Adjmt.");
                        ItemJnlLine2.VALIDATE("Document No.", NextDocNo);
                        ItemJnlLine2.VALIDATE("Item No.", TempItem."No.");
                        "Phys. Inventory" := TRUE;
                        //HEI.08>>
                        //INSERT(TRUE);
                        ItemJnlLine2.INSERT(FALSE);
                        //HEI.14<<
                    END ELSE BEGIN

                        "Line No." := NextLineNo;
                        "Journal Template Name" := ItemJnlLine."Journal Template Name";
                        "Journal Batch Name" := ItemJnlLine."Journal Batch Name";
                        //"Location Code":=recItemSKU."Location Code";
                        ItemJnlLine2.VALIDATE("Posting Date", PostingDate);
                        ItemJnlLine2.VALIDATE("Entry Type", ItemJnlLine2."Entry Type"::"Positive Adjmt.");
                        ItemJnlLine2.VALIDATE("Document No.", NextDocNo);
                        ItemJnlLine2.VALIDATE("Item No.", TempItem."No.");
                        "Phys. Inventory" := TRUE;
                        //HEI.08>>
                        //INSERT(TRUE);
                        ItemJnlLine2.INSERT(FALSE);
                    END;
                //HEI.14>>
                //HEI.08<<
                //END;
                UNTIL TempItem.NEXT = 0;
        END;
        // ++ CITQLT1.00 002 ++ End
        // >>PRODW14.00.00.08.12
        //HEI.10<<
        IF NOT HideValidationDialog THEN BEGIN
            Window.CLOSE
        END;
        //HEI.10>>
    end;

}
