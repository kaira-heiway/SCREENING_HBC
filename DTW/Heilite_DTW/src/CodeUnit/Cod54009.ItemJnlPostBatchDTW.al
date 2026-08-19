namespace BC_DTWLocal.BC_DTWLocal;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.Period;
using Microsoft.Inventory.Costing;
using Microsoft.Warehouse.Journal;
using Microsoft.Foundation.NoSeries;
using Microsoft.Warehouse.Ledger;
using Microsoft.Inventory.Posting;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Inventory.Ledger;
using System.Security.User;
using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Setup;

codeunit 54009 "Item Jnl.-Post Batch _DTW"
{
    //BC Upgrade Kamnay01 Created this new Cu for Revaluation Journal error log. FDD- FDD-DTW-031
    //BC Upgrade SHUKLP03 >> CodeUnit 23

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 26.10.2018 # Counterpoint Interface
    // # Code added to avoid increase of Batch Code depending on setup => Subscribe event "OnBeforeHandleNonRecurringLine" added whole code after "OnBeforeHandleNonRecurringLine" event from procedure "HandleNonRecurringLine"
    // made ISHandled boolean true and also added event publishers OnBeforeIncrBatchName, OnHandleNonRecurringLineOnAfterCopyItemJnlLine3, OnHandleNonRecurringLineOnBeforeSetItemJnlBatchName,
    // OnHandleNonRecurringLineOnAfterItemJnlLineModify and OnHandleNonRecurringLineOnInsertNewLine.

    // HEI.02 CHG2119178 IBM.AS 30.06.2021 => BC Upgrade SHUKLP03 << Event is not found on procedure CheckItemAvailability to add code of HEI.02.
    // # HeiLite Base Stability Changes for Posting functions at JOB NAS
    // # Adding GUIAllowed function added in Functions CheckItemAvailability() for JOB Execution to avoid any manual intervention

    // HEI.03 CHG2154339 HB2904 NORRIQ KOROLA04 27.07.2022
    // # Subscribed event "OnAfterCheckJnlLine" to add new condition to the function CheckLines()

    // HEI.04 CHG2154339 HB2904 NORRIQ KOROLA04 11.08.2022
    // # Subscribed event "OnAfterCheckJnlLine" to add condition to check is empty Reason Code changed for Scrap Code

    // HEI.05 CHG2180069 PRASAA03 22.06.2023 Limiting selection fixing issues coming out of UAT
    // # Subscribed event "OnAfterCheckJnlLine" to add scrap code validation for Positive adjustment.

    // HEI.06 CHG2187702 SAHAL01 12.10.2023 Revaluation journal items in error
    // # Added Custom procedures ValidateRevJnlError, GetItemJnlLine and InsertRevJnlErrorLog
    // # Subscribed events OnPostLinesOnAfterPostLine OnBeforeRaiseExceedLengthError, OnBeforePostLines, OnAfterCopyRegNos, OnAfterCheckJnlLine,
    // OnBeforeOnPostLinesOnBeforePostLineUpdateItemTracking and OnBeforeItemJournalPostSumLine
    // # PostLine code is not added because PostLine base procedure is removed from business central.

    // HEI.07 CHG2187702 PRASAA03 30.10.2023 Revaluation journal items in error
    // # Added Code for dimension issue in Custom procedures ValidateRevJnlError.

    // HEI.08 CHG2187702 PRASAA03 06.12.2023 Revaluation journal items in error
    // # Added Code for Posting setup and latest entries error message in Custom procedures ValidateRevJnlError.

    // HEI.09 CHG2187702 PRASAA03 21.12.2023 Revaluation journal items in error
    // # Added Code for latest entries error message in Custom procedures ValidateRevJnlError and InsertRevJnlErrorLog


    var

        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        ItemLedgEntry: Record "Item Ledger Entry";
        WhseEntry: Record "Warehouse Entry";
        ItemReg: Record "Item Register";
        WhseReg: Record "Warehouse Register";
        GLSetup: Record "General Ledger Setup";
        InvtSetup: Record "Inventory Setup";
        AccountingPeriod: Record "Accounting Period";
        NoSeries: Record "No. Series";
        Location: Record Location;
        ItemJnlCheckLine: Codeunit "Item Jnl.-Check Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        NoSeriesMgt: Codeunit "No. Series";
        NoSeriesMgt2: Codeunit "No. Series";
        WMSMgmt: Codeunit "WMS Management";
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
        InvtAdjmt: Codeunit "Inventory Adjustment";
        Window: Dialog;
        ItemRegNo: Integer;
        WhseRegNo: Integer;
        StartLineNo: Integer;
        Day: Integer;
        Week: Integer;
        Month: Integer;
        MonthText: Text[30];
        NoOfRecords: Integer;
        LineCount: Integer;
        LastDocNo: Code[20];
        LastDocNo2: Code[20];
        LastPostedDocNo: Code[20];
        NoOfPostingNoSeries: Integer;
        PostingNoSeriesNo: Integer;
        WhseTransaction: Boolean;
        PhysInvtCount: Boolean;

        SystemAllowedSSCC: Boolean;

        ItemJnlLineError: Record "Item Journal Line";
        CreateLog: Boolean;
        GeneralPostingSetup: Record "General Posting Setup";
        DefaultDimension: Record "Default Dimension";
        DimensionSetEntry: Record "Dimension Set Entry";

    procedure ValidateRevJnlError(VAR ItemJournalLine: Record "Item Journal Line")
    var

        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
        ItemJnlLineL: Record "Item Journal Line";
        LocationL: Record Location;
        ZoneL: Record Zone;
        BinL: Record Bin;
        UserSetupL: Record "User Setup";
        ItemL: Record Item;
        ErrorTextL: Text[250];
        ItemLedgEntry4: Record "Item Ledger Entry";
        PostingDate: Date;
        IncludeExpectedCost: Boolean;
        ItemLedgEntry5: Record "Item Ledger Entry";
        ItemJnlLineLTemp: Record "Item Journal Line";
        Remainder: Decimal;
        RemQuantity: Decimal;
        RemAmountToDistribute: Decimal;
        DistributeCosts: Boolean;
        IsLastEntry: Boolean;
        Text008: TextConst ENU = 'There are new postings made in the period you want to revalue item no. %1.\', FRA = 'De nouvelles validations ont été faites durant la période pour laquelle vous souhaitez réévaluer larticle n° %1.\';
        Text009: Textconst ENU = 'You must calculate the inventory value again.', FRA = 'Vous devez calculer à nouveau la valeur du stock.';
        Text010L: TextConst ENU = '%1 cannot be left blank for %2 %3 and %4 %5.';
        Text011L: TextConst ENU = ' %1 %2 is not found in %3 for %4 %5 and %6 %7.';
        Text012L: TextConst ENU = ' %1 must not be as %2 in %3 for %4 %5 and %6 %7.';
        Text013L: TextConst ENU = ' Dimension code %1 must have a value.';
        Text014L: TextConst ENU = ' Setup for Combination Gen. Business Posting Group - %1 and Gen. Product Posting Group - %2 is not available.';
    Begin
        //HEI.06>>
        IF InventorySetupL.GET() THEN BEGIN
            IF InventorySetupL."Activate Rev.Jnl.Error Log FND" THEN BEGIN
                ItemJnlLineL.COPYFILTERS(ItemJournalLine);
                IF ItemJnlTemplateL.GET(ItemJournalLine."Journal Template Name") THEN BEGIN
                    IF ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation THEN BEGIN
                        IF ItemJnlLineL.FINDSET(FALSE) THEN BEGIN
                            REPEAT
                                IF ItemJnlLineL."Location Code" = '' THEN BEGIN
                                    ErrorTextL := COPYSTR(STRSUBSTNO(Text010L, ItemJnlLineL.FIELDCAPTION("Location Code"),
                                      ItemJnlLineL.FIELDCAPTION("Document No."), ItemJnlLineL."Document No.",
                                        ItemJnlLineL.FIELDCAPTION("Line No."), ItemJnlLineL."Line No."), 1, 250);
                                    InsertRevJnlErrorLog(ItemJnlLineL, ErrorTextL);
                                    CLEAR(ErrorTextL);
                                END ELSE
                                    IF NOT LocationL.GET(ItemJnlLineL."Location Code") THEN BEGIN
                                        ErrorTextL := COPYSTR(STRSUBSTNO(Text011L, ItemJnlLineL.FIELDCAPTION("Location Code"),
                                          ItemJnlLineL."Location Code", LocationL.TABLECAPTION,
                                            ItemJnlLineL.FIELDCAPTION("Document No."), ItemJnlLineL."Document No.",
                                              ItemJnlLineL.FIELDCAPTION("Line No."), ItemJnlLineL."Line No."), 1, 250);
                                        InsertRevJnlErrorLog(ItemJnlLineL, ErrorTextL);
                                        CLEAR(ErrorTextL);
                                    END;

                                IF ItemJnlLineL."Item No." = '' THEN BEGIN
                                    ErrorTextL := COPYSTR(STRSUBSTNO(Text010L, ItemJnlLineL.FIELDCAPTION("Item No."),
                                      ItemJnlLineL.FIELDCAPTION("Document No."), ItemJnlLineL."Document No.",
                                        ItemJnlLineL.FIELDCAPTION("Line No."), ItemJnlLineL."Line No."), 1, 250);
                                    InsertRevJnlErrorLog(ItemJnlLineL, ErrorTextL);
                                    CLEAR(ErrorTextL);
                                END ELSE
                                    IF NOT ItemL.GET(ItemJnlLineL."Item No.") THEN BEGIN
                                        ErrorTextL := COPYSTR(STRSUBSTNO(Text011L, ItemJnlLineL.FIELDCAPTION("Item No."),
                                          ItemJnlLineL."Item No.", ItemL.TABLECAPTION,
                                            ItemJnlLineL.FIELDCAPTION("Document No."), ItemJnlLineL."Document No.",
                                              ItemJnlLineL.FIELDCAPTION("Line No."), ItemJnlLineL."Line No."), 1, 250);
                                        InsertRevJnlErrorLog(ItemJnlLineL, ErrorTextL);
                                        CLEAR(ErrorTextL);
                                    END ELSE BEGIN
                                        IF ItemL.Blocked THEN BEGIN
                                            ErrorTextL := COPYSTR(STRSUBSTNO(Text012L, ItemL.FIELDCAPTION(Blocked),
                                              FORMAT(ItemL.Blocked), ItemL.TABLECAPTION,
                                                ItemJnlLineL.FIELDCAPTION("Document No."), ItemJnlLineL."Document No.",
                                                  ItemJnlLineL.FIELDCAPTION("Line No."), ItemJnlLineL."Line No."), 1, 250);
                                            InsertRevJnlErrorLog(ItemJnlLineL, ErrorTextL);
                                            CLEAR(ErrorTextL);
                                        END;
                                    END;
                                //HEI.07>>
                                //HEI.08>>
                                //GeneralPostingSetup.GET(ItemJnlLineL."Gen. Bus. Posting Group",ItemJnlLineL."Gen. Prod. Posting Group");
                                IF GeneralPostingSetup.GET(ItemJnlLineL."Gen. Bus. Posting Group", ItemJnlLineL."Gen. Prod. Posting Group") THEN BEGIN
                                    //HEI.08<<
                                    IF GeneralPostingSetup."Inventory Adjmt. Account" <> '' THEN BEGIN
                                        DefaultDimension.RESET();
                                        DefaultDimension.SETRANGE("Table ID", 15);
                                        DefaultDimension.SETRANGE("No.", GeneralPostingSetup."Inventory Adjmt. Account");
                                        DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
                                        IF DefaultDimension.FINDSET(FALSE) THEN
                                            REPEAT
                                                DimensionSetEntry.RESET();
                                                DimensionSetEntry.SETRANGE("Dimension Set ID", ItemJnlLineL."Dimension Set ID");
                                                DimensionSetEntry.SETRANGE("Dimension Code", DefaultDimension."Dimension Code");
                                                IF NOT DimensionSetEntry.FINDFIRST() THEN BEGIN
                                                    ErrorTextL := COPYSTR(STRSUBSTNO(Text013L, DefaultDimension."Dimension Code"), 1, 250);
                                                    InsertRevJnlErrorLog(ItemJnlLineL, ErrorTextL);
                                                    CLEAR(ErrorTextL);
                                                END;
                                            UNTIL DefaultDimension.NEXT() = 0;
                                    END;
                                    //HEI.07<<
                                    //HEI.08>>
                                END ELSE BEGIN
                                    ErrorTextL := COPYSTR(STRSUBSTNO(Text014L, ItemJnlLineL."Gen. Bus. Posting Group", ItemJnlLineL."Gen. Prod. Posting Group"), 1, 250);
                                    InsertRevJnlErrorLog(ItemJnlLineL, ErrorTextL);
                                    CLEAR(ErrorTextL);
                                END;
                                //HEI.09>>
                                ItemL.GET(ItemJournalLine."Item No.");
                                IncludeExpectedCost := (ItemL."Costing Method" = ItemL."Costing Method"::Standard) AND
                                  (ItemJournalLine."Inventory Value Per" <> ItemJournalLine."Inventory Value Per"::" ");
                                ItemLedgEntry4.RESET();
                                ItemLedgEntry4.SETCURRENTKEY("Item No.", Positive, "Location Code", "Variant Code");
                                ItemLedgEntry4.SETRANGE("Item No.", ItemJnlLine."Item No.");
                                ItemLedgEntry4.SETRANGE(Positive, TRUE);
                                PostingDate := ItemJnlLine."Posting Date";

                                IF (ItemJournalLine."Location Code" <> '') OR
                                    (ItemJournalLine."Inventory Value Per" IN
                                    [ItemJournalLine."Inventory Value Per"::Location,
                                      ItemJournalLine."Inventory Value Per"::"Location and Variant"])
                                THEN
                                    ItemLedgEntry4.SETRANGE("Location Code", ItemJnlLine."Location Code");
                                IF (ItemJnlLine."Variant Code" <> '') OR
                                    (ItemJournalLine."Inventory Value Per" IN
                                    [ItemJnlLine."Inventory Value Per"::Variant,
                                      ItemJournalLine."Inventory Value Per"::"Location and Variant"])
                                THEN
                                    ItemLedgEntry4.SETRANGE("Variant Code", ItemJnlLine."Variant Code");
                                IF ItemLedgEntry4.FINDSET(FALSE) THEN
                                    REPEAT
                                        IF IncludeEntryInCalc(ItemLedgEntry4, PostingDate, IncludeExpectedCost) THEN BEGIN
                                            ItemLedgEntry5 := ItemLedgEntry4;

                                            ItemJournalLine."Entry Type" := ItemLedgEntry4."Entry Type";
                                            ItemJournalLine.Quantity :=
                                              ItemLedgEntry4.CalculateRemQuantity(ItemLedgEntry4."Entry No.", ItemJnlLine."Posting Date");

                                            ItemJournalLine."Quantity (Base)" := ItemJournalLine.Quantity;
                                            ItemJournalLine."Invoiced Quantity" := ItemJournalLine.Quantity;
                                            ItemJournalLine."Invoiced Qty. (Base)" := ItemJournalLine.Quantity;
                                            ItemJournalLine."Location Code" := ItemLedgEntry4."Location Code";
                                            ItemJournalLine."Variant Code" := ItemLedgEntry4."Variant Code";
                                            ItemJournalLine."Applies-to Entry" := ItemLedgEntry4."Entry No.";
                                            ItemJournalLine."Source No." := ItemLedgEntry4."Source No.";
                                            ItemJournalLine."Order Type" := ItemLedgEntry4."Order Type";
                                            ItemJournalLine."Order No." := ItemLedgEntry4."Order No.";
                                            ItemJournalLine."Order Line No." := ItemLedgEntry4."Order Line No.";

                                            IF ItemJournalLine.Quantity <> 0 THEN BEGIN
                                                ItemJournalLine.Amount :=
                                                  ItemJnlLine."Inventory Value (Revalued)" * ItemJournalLine.Quantity /
                                                  ItemJnlLine.Quantity -
                                                  ROUND(
                                                    ItemLedgEntry4.CalculateRemInventoryValue(
                                                      ItemLedgEntry4."Entry No.", ItemLedgEntry4.Quantity, ItemJournalLine.Quantity,
                                                      IncludeExpectedCost AND NOT ItemLedgEntry4."Completely Invoiced", PostingDate),
                                                    GLSetup."Amount Rounding Precision") + Remainder;

                                                RemQuantity := RemQuantity - ItemJournalLine.Quantity;

                                                IF RemQuantity = 0 THEN BEGIN
                                                    IF ItemLedgEntry4.NEXT() > 0 THEN
                                                        REPEAT
                                                            IF IncludeEntryInCalc(ItemLedgEntry4, PostingDate, IncludeExpectedCost) THEN BEGIN
                                                                RemQuantity := ItemLedgEntry4.CalculateRemQuantity(ItemLedgEntry4."Entry No.", ItemJnlLine."Posting Date");
                                                                IF RemQuantity > 0 THEN
                                                                    ERROR(Text008 + Text009, ItemJournalLine."Item No.");
                                                            END;
                                                        UNTIL ItemLedgEntry4.NEXT() = 0;

                                                    ItemJournalLine.Amount := RemAmountToDistribute;
                                                    DistributeCosts := FALSE;
                                                END ELSE BEGIN
                                                    REPEAT
                                                        IsLastEntry := ItemLedgEntry4.NEXT() = 0;
                                                    UNTIL IncludeEntryInCalc(ItemLedgEntry4, PostingDate, IncludeExpectedCost) OR IsLastEntry;
                                                    IF IsLastEntry OR (RemQuantity < 0) THEN
                                                        ERROR(Text008 + Text009, ItemJournalLine."Item No.");
                                                    Remainder := ItemJournalLine.Amount - ROUND(ItemJournalLine.Amount, GLSetup."Amount Rounding Precision");
                                                    ItemJournalLine.Amount := ROUND(ItemJournalLine.Amount, GLSetup."Amount Rounding Precision");
                                                    RemAmountToDistribute := RemAmountToDistribute - ItemJournalLine.Amount;
                                                END;
                                                ItemJournalLine."Unit Cost" := ItemJournalLine.Amount / ItemJournalLine.Quantity;

                                                IF ItemJournalLine.Amount <> 0 THEN BEGIN
                                                    IF IncludeExpectedCost AND NOT ItemLedgEntry5."Completely Invoiced" THEN BEGIN
                                                        ItemJournalLine."Applied Amount" := ROUND(
                                                            ItemJournalLine.Amount * (ItemLedgEntry5.Quantity - ItemLedgEntry5."Invoiced Quantity") /
                                                            ItemLedgEntry5.Quantity,
                                                            GLSetup."Amount Rounding Precision");
                                                    END ELSE
                                                        ItemJournalLine."Applied Amount" := 0;
                                                    ItemJnlPostLine.RunWithCheck(ItemJournalLine);
                                                END;
                                            END ELSE BEGIN
                                                REPEAT
                                                    IsLastEntry := ItemLedgEntry4.NEXT() = 0;
                                                UNTIL IncludeEntryInCalc(ItemLedgEntry4, PostingDate, IncludeExpectedCost) OR IsLastEntry;
                                                IF IsLastEntry THEN
                                                    ERROR(Text008 + Text009, ItemJournalLine."Item No.");
                                                //BC Upgrade Kamnay01 
                                            END;
                                        END ELSE
                                            DistributeCosts := ItemLedgEntry4.NEXT() <> 0;
                                    UNTIL NOT DistributeCosts;

                            //HEI.09<<
                            //HEI.08<<
                            UNTIL ItemJnlLineL.NEXT() = 0;
                        END;
                    END;
                END;
            END;
        END;
    END;

    //HEI.06<<

    //BC Upgrade Kamnay01 comented wrong event subscriber and wrong parameter>>
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforeRaiseExceedLengthError, '', false, false)]
    // local procedure OnBeforeRaiseExceedLengthError_23()

    // begin

    //         GetItemJnlLine(ItemJournalLine);
    //     end;

    // end;
    //BC Upgrade Kamnay01 comented wrong event subscriber and wrong parameter<<

    //BC Upgrade Kamnay01 added this correct event 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforeCode, '', false, false)]
    local procedure "Item Jnl.-Post Batch_OnBeforeCode"(var ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        GetItemJnlLine(ItemJournalLine);
    end;
    //BC Upgrade Kamnay01 added this correct event 


    // BC Upgrade Kamnay01 Comment priya code becuase she not used the correct function of event 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforePostLines, '', false, false)]
    // local procedure OnBeforePostLines_23(var ItemJournalLine: Record "Item Journal Line")
    // var
    //     ItemJnlLineError: Record "Item Journal Line";
    //     ErrorTextL: Text[250];

    // begin
    //     //HEI.06>>
    //     IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
    //         ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
    //         InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
    //     END;
    //     CLEAR(ErrorTextL);
    //     IF CreateLog THEN BEGIN
    //         ItemJnlLine.SETRANGE("Post To", ItemJournalLine."Post To"::Include);
    //     END;
    //     //HEI.06<<
    // end;
    // BC Upgrade Kamnay01 Comment priya code becuase she not used the correct function of event 

    //BC Upgrade Kamnay01 corrected 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforePostLines, '', false, false)]
    local procedure "Item Jnl.-Post Batch_OnBeforePostLines"(var ItemJournalLine: Record "Item Journal Line"; var ItemRegNo: Integer; var WhseRegNo: Integer)
    var
        ErrorTextL: Text[250];
    begin
        //HEI.06>>
        IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
            ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
            InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
        END;
        CLEAR(ErrorTextL);
        IF CreateLog THEN BEGIN
            ItemJnlLine.SETRANGE("Post To FND", ItemJournalLine."Post To FND"::Include);
        END;
        //HEI.06<<
    end;
    //BC Upgrade Kamnay01 corrected 


    //BC Upgrade Kamnay01 comment priya code becuse in function there is no parameters 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnAfterCopyRegNos, '', false, false)]
    // local procedure OnAfterCopyRegNos_23()
    // begin
    //     //HEI.06>>
    //     IF CreateLog THEN BEGIN
    //         ItemJnlLine.SETRANGE("Post To", ItemJnlLine."Post To"::Include);
    //     END;
    //     //HEI.06<<
    // end;
    //BC Upgrade Kamnay01 comment priya code because in finction there is no parameter

    //BC Upgrade Kamnay01 correct this added stant parameter 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnAfterCopyRegNos, '', false, false)]
    local procedure "Item Jnl.-Post Batch_OnAfterCopyRegNos"(var ItemJournalLine: Record "Item Journal Line"; var ItemRegNo: Integer; var WhseRegNo: Integer)
    begin
        //HEI.06>>
        IF CreateLog THEN BEGIN
            ItemJournalLine.SETRANGE("Post To FND", ItemJnlLine."Post To FND"::Include);
        END;
        //HEI.06<<
    end;
    //BC Upgrade Kamnay01 correct this added stant parameter 


    //BC Upgrade Kamnay01 comment priya code because in finction there is no parameter
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnAfterCheckJnlLine, '', false, false)]
    // local procedure OnAfterCheckJnlLine_23(var ItemJournalLine: Record "Item Journal Line")
    // var
    //     ErrorTextL: Text[250];
    //     InventorySetup: Record "Inventory Setup";
    //     Text011: TextConst ENU = 'Scrap Code cannot be Blank for the Transaction %1, Line No. %2.';
    // begin
    //     //HEI.06>>
    //     IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
    //         ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
    //         InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
    //     END;
    //     CLEAR(ErrorTextL);
    //     //HEI.06<<
    // end;
    //BC Upgrade Kamnay01 comment priya code because in finction there is no parameter


    //BC Upgrade Kamnay01 correct this added stant parameter 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnAfterCheckJnlLine, '', false, false)]
    local procedure "Item Jnl.-Post Batch_OnAfterCheckJnlLine"(var ItemJournalLine: Record "Item Journal Line"; CommitIsSuppressed: Boolean)
    var
        ErrorTextL: Text[250];
    begin
        //HEI.06>>
        IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
            ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
            InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
        END;
        CLEAR(ErrorTextL);
        //HEI.06<<
    end;
    //BC Upgrade Kamnay01 correct this added stant parameter 


    //BC Upgrade Kamnay01 comment priya code because in finction there is no parameter
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforeOnPostLinesOnBeforePostLineUpdateItemTracking, '', false, false)]
    // local procedure OnBeforeOnPostLinesOnBeforePostLineUpdateItemTracking_23(var ItemJnlLine: Record "Item Journal Line")
    // begin
    //     //HEI.06>>
    //     IF CreateLog THEN BEGIN
    //         ItemJnlLine.SETRANGE("Post To", ItemJnlLine."Post To"::Include);
    //         IF ItemJnlLine.ISEMPTY THEN
    //             EXIT;
    //     END;
    //     //HEI.06<<
    // end;
    //BC Upgrade Kamnay01 comment priya code because in finction there is no parameter

    //BC Upgrade Kamnay01 correct this added stant parameter 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforeOnPostLinesOnBeforePostLineUpdateItemTracking, '', false, false)]
    local procedure "Item Jnl.-Post Batch_OnBeforeOnPostLinesOnBeforePostLineUpdateItemTracking"(var ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        //HEI.06>>
        IF CreateLog THEN BEGIN
            ItemJnlLine.SETRANGE("Post To FND", ItemJnlLine."Post To FND"::Include);
            IF ItemJnlLine.ISEMPTY THEN
                EXIT;
        END;
        //HEI.06<< 
    end;
    //BC Upgrade Kamnay01 correct this added stant parameter 

    //BC Upgrade Kamnay01 comment priya code because in finction there is no parameter
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnPostLinesOnAfterPostLine, '', false, false)]
    // local procedure OnPostLinesOnAfterPostLine_23(var ItemJournalLine: Record "Item Journal Line")
    // var
    //     ItemJnlLine2: Record "Item Journal Line";
    //     ErrorTextL: Text[250];
    // begin
    //     //HEI.06>>
    //     IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
    //         ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
    //         InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
    //     END;
    //     CLEAR(ErrorTextL);
    //     //HEI.06<<
    //     //ItemJnlLine2.SETRANGE("Attached to Line No.",ItemJournalLine."Line No."); // BC Upgrade SHUKLP03 << Code commented because dependency on DrinkIT field "Attached to Line No.".
    //     //HEI.06>>
    //     IF CreateLog THEN BEGIN
    //         ItemJournalLine.SETRANGE("Post To", ItemJournalLine."Post To"::Include);
    //     END;
    //     //HEI.06<<
    //     //HEI.06>>
    //     IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
    //         ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
    //         InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
    //     END;
    //     CLEAR(ErrorTextL);
    //     //HEI.06<<
    // end;
    //BC Upgrade Kamnay01 comment priya code because in finction there is no parameter



    //BC Upgrade Kamnay01 correct this added stant parameter 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnPostLinesOnAfterPostLine, '', false, false)]
    local procedure "Item Jnl.-Post Batch_OnPostLinesOnAfterPostLine"(var ItemJournalLine: Record "Item Journal Line"; var SuppressCommit: Boolean)

    var
        ErrorTextL: Text[250];
    begin
        //HEI.06>>
        IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
            ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
            InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
        END;
        CLEAR(ErrorTextL);
        //HEI.06<<
        //ItemJnlLine2.SETRANGE("Attached to Line No.",ItemJournalLine."Line No."); // BC Upgrade SHUKLP03 << Code commented because dependency on DrinkIT field "Attached to Line No.".
        //HEI.06>>
        IF CreateLog THEN BEGIN
            ItemJournalLine.SETRANGE("Post To FND", ItemJournalLine."Post To FND"::Include);
        END;
        //HEI.06<<
        //HEI.06>>
        IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
            ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
            InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
        END;
        CLEAR(ErrorTextL);
        //HEI.06<<
    end;
    //BC Upgrade Kamnay01 correct this added stant parameter 



    [IntegrationEvent(false, false)]
    local procedure OnBeforeIncrBatchName(var ItemJournalLine: Record "Item Journal Line"; var IncrBatchName: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandleNonRecurringLineOnAfterCopyItemJnlLine3(var ItemJournalLine: Record "Item Journal Line"; var ItemJournalLine3: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandleNonRecurringLineOnBeforeSetItemJnlBatchName(ItemJnlTemplate: Record "Item Journal Template"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandleNonRecurringLineOnAfterItemJnlLineModify(var ItemJournalLine: Record "Item Journal Line");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandleNonRecurringLineOnInsertNewLine(var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    //BC Upgrade Kamnay01 comment priya code because in finction there is no parameter
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforeItemJournalPostSumLine, '', false, false)]
    // local procedure OnBeforeItemJournalPostSumLine_23()
    // begin
    //     //HEI.06>>
    //     IF CreateLog THEN BEGIN
    //         IF ItemJnlLine."Post To" = ItemJnlLine."Post To"::Skip THEN
    //             EXIT;
    //     END;
    //     //HEI.06<<
    // end;
    //BC Upgrade Kamnay01 comment priya code because in finction there is no parameter



    //BC Upgrade Kamnay01 correct this added stant parameter 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnBeforeItemJournalPostSumLine, '', false, false)]
    local procedure "Item Jnl.-Post Batch_OnBeforeItemJournalPostSumLine"(var ItemJnlLine: Record "Item Journal Line"; var ItemJnlLine4: Record "Item Journal Line"; var LineCount: Integer; WindowIsOpen: Boolean; var Window: Dialog; NoOfRecords: Integer; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var IsHandled: Boolean)
    begin
        //HEI.06>>
        IF CreateLog THEN BEGIN
            IF ItemJnlLine4."Post To FND" = ItemJnlLine."Post To FND"::Skip THEN
                EXIT;
        END;
        //HEI.06<<
    end;
    //BC Upgrade Kamnay01 correct this added stant parameter 


    procedure GetItemJnlLine(VAR ItemJournalLine: Record "Item Journal Line")
    var
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
    begin
        //HEI.06>>
        CLEAR(ItemJnlLineError);
        CLEAR(CreateLog);
        IF InventorySetupL.GET() THEN BEGIN
            IF InventorySetupL."Activate Rev.Jnl.Error Log FND" THEN BEGIN
                IF ItemJnlTemplateL.GET(ItemJournalLine."Journal Template Name") THEN BEGIN
                    IF ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation THEN BEGIN
                        ItemJnlLineError.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                        ItemJnlLineError.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        ItemJnlLineError.SETRANGE("Line No.", ItemJournalLine."Line No.");
                        IF ItemJnlLineError.FINDFIRST() THEN;
                        CreateLog := TRUE;
                    END;
                END;
            END;
        END;
        //HEI.06<<
    end;

    procedure InsertRevJnlErrorLog(VAR ItemJournalLine: Record "Item Journal Line"; VAR ErrorText: Text[250])
    var
        RevJnlErrorLogL: Record "Revaluation Jrnl Error Log FND";
    begin
        //HEI.06>>
        RevJnlErrorLogL.INIT();
        RevJnlErrorLogL."Posting Date" := ItemJournalLine."Posting Date";
        RevJnlErrorLogL."Journal Template Name" := ItemJournalLine."Journal Template Name";
        RevJnlErrorLogL."Journal Batch Name" := ItemJournalLine."Journal Batch Name";
        RevJnlErrorLogL."Line No." := ItemJournalLine."Line No.";
        RevJnlErrorLogL."Item Ledger Entry No." := ItemJournalLine."Applies-to Entry";
        RevJnlErrorLogL."Error Message" := ErrorText;
        RevJnlErrorLogL."Document Type" := ItemJournalLine."Document Type".AsInteger();
        RevJnlErrorLogL."Document No." := ItemJournalLine."Document No.";
        RevJnlErrorLogL."Document Line No." := ItemJournalLine."Document Line No.";
        RevJnlErrorLogL."Document Date" := ItemJournalLine."Document Date";
        RevJnlErrorLogL."Order Type" := ItemJournalLine."Order Type".AsInteger();
        RevJnlErrorLogL."Order No." := ItemJournalLine."Order No.";
        RevJnlErrorLogL."Order Line No." := ItemJournalLine."Order Line No.";
        RevJnlErrorLogL."Location Code" := ItemJournalLine."Location Code";
        RevJnlErrorLogL."Zone Code" := ItemJournalLine."Zone Code FND";
        RevJnlErrorLogL."Bin Code" := ItemJournalLine."Bin Code";
        RevJnlErrorLogL."Item No." := ItemJournalLine."Item No.";
        RevJnlErrorLogL.Quantity := ItemJournalLine.Quantity;
        RevJnlErrorLogL.INSERT(FALSE);

        ItemJournalLine."Post To FND" := ItemJournalLine."Post To FND"::Skip;
        ItemJournalLine.MODIFY(FALSE);
        //COMMIT;//HEI.09
        CLEARLASTERROR();
        //HEI.06<<
    end;

    local procedure IncludeEntryInCalc(ItemLedgEntry: Record "Item Ledger Entry"; PostingDate: Date; IncludeExpectedCost: Boolean): Boolean
    begin
        if IncludeExpectedCost then
            exit(ItemLedgEntry."Posting Date" in [0D .. PostingDate]);
        exit(ItemLedgEntry."Completely Invoiced" and (ItemLedgEntry."Last Invoice Date" in [0D .. PostingDate]));
    end;
    //BC Upgrade SHUKLP03 << CodeUnit 23
}
