namespace BC_DTWLocal.BC_DTWLocal;
using ALProject.ALProject;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Journal;
using Microsoft.Projects.Project.Job;
using Microsoft.CRM.Campaign;
using Microsoft.CRM.Team;
using Microsoft.Inventory.Setup;
using Microsoft.Finance.GeneralLedger.Journal;

codeunit 54011 "Gen. Jnl.-Check Line_DTW"
//BC Upgrade Kamnay01 Created this new Cu for Revaluation Journal error log. FDD- FDD-DTW-031 

// DITW15.00.00.31 DDR 18/02/2009 Added reversing test with "Allow Reverse Document Amount"

// DITW15.00.00.35 DDR 28/08/2009 Added checking field "Contract Group Code" when apply to document is activated

//                     02/10/2009 issue 792 Added to check dimension value posting with (Sell-to) Customer

//                     10/05/2010 issue 857 Updated function CheckContractGroup() to check if mandatory or not

//                                          Bugfix missing checking the Contract group for vendor entries

// DITW16.00.00.41 AHU 07/08/2012 DIT-715 #327 Added to check dimension fields "Building no.","Service contract no."

//                                             Added to check G/L Account field "DIT Sub-Contract Posting Type"

//                 AHU 16/08/2012 DIT-715 #327 Bugfix to check G/L Account field "DIT Sub-Contract Posting Type"

//                 AHU 27/08/2012 DIT-715 #327 Bugfix to check G/L Account field "DIT Sub-Contract Posting Type"

//                 AHU 31/08/2012 DIT-715 #327 Removed check  G/L Account field "DIT Sub-Contract Posting Type"

// DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added GL Setup field "Appln. per Source reference"

//                                             Added functions CheckContractNo()

//                                             Added functions CheckItemChargeType()

// DITW16.00.00.43 DDR 14/08/2013 DIT-715 #678 Added check using Sales setup field "Excl. Deposit Payment Discount"

// DITW17.00.02 DDR 19/08/2013 DIT-715 #678 merge

// DITW17.00.02 SR 08/10/2013 DIT-770 #135 : New code Added to Allow Negative & Positive Posting in Document Type "Loan Pay Out", "Loan Pay Back","Bank Reverse","Bank Charges".

// DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

// DITW17.10.03 MSF 08/04/2014 DIT-770 #340 : Variable Customer Posting group - Sub Contract type extensions Issue continuing issue 163

// DITW17.10.05 YHE 20/08/2014 DIT-770 #756 Create Functions (fctCheckDITContractInvoicePeriod)

// DITW17.10.05 WSA 04/02/2015 DIT-770 #1210 Added code to fix check dim on sell-to bill-to (buy from,pay-to)

// DITW17.10.05 WSA 05/02/2015 DIT-770 #1210 Modified code to check dim in purch doc.

// DITW18.00 MSF 27/04/2015 DIT-770 #1363 Fix upgrade tag

// DITW18.00.06 MSF 09/07/2015 DIT-770 #501 Blocking message "Invoice x already exists" when posting - Case: activate split deposit

//                                          Added parameter to function CheckSalesDocNoIsNotUsed

//                                                                      CheckPurchDocNoIsNotUsed

// DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract

//                                           Added field 2014319  "Financial Contract No."

//                                           Rename Caption Contract No. by Service contract No.

//                                           Change ID of field Contract Type to Foundation layer 2035393

//                                           Added blank Option to Contract Type

// DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Various adjustments

// DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

// DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

// DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7

// DITW110.00.12A MSF 05/07/2018 NRQ#75686 Impossible to post payment if document type payment and item charge type deposit

// HEI.01 FDD RTRGAP021 IBM COSTES02 01.08.2017 Remove checking new fiscal year in accounting period

// HEI.02 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new function

// HEI.03 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM

//   # New function CheckRPMDamageLossLine created

// HEI.04 DefectID 911 IBM HORTOC01 07.11.2017 - new function

// HEI.05 FDD-KDD0TC007 IBM NAIKH01 15.11.2017

//   # NEw Function Added "CheckFFESecurityPaymentLine"

// HEI.06 FDD PTPGAP078 IBM POSTOI01 26.05.2018

//   # Bank Payment Type validation should be active only for "Source Code" <> "Source Code Setup"."Payment Journal Tree"

// HEI.07 FDD-CHG2022328 IBM POENAB02 07.07.2019 # External document No. duplication in journal

//   #Code added in RunCheck

// HEI.08 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing

//   # New code

// HEI.09 CHG2040699 IBM POSTOI01 14.01.2020 Ivory Coast - WHT at the moment of payment

//   # New function: CheckWHTAppliedInvPostingGroups(GenJnlLine)

//   # new global constant Text013

// HEI.10 FDD-CD-HT1350 IBM BULIMC01 16.07.2020 #check if the field "Related Sales Order No." is filled in

// HEI.11 FDD-HB1609 CHG2074002 IBM BULIMC01 09.11.2020 #check if the entries for Free Goods Accounting have already been posted

// HEI.12 CHG2126534 IBM BHATTA09 15.09.2021

// # Code change to bypass the WHT validation for specific users

// HEI.13 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite

//   # Code change to skip dimension validation only for Sales documents if on setup is true the skip

// HEI.14 CHG2131424 IBM YADAVM09 10/08/2023 HB2520 Dimension Validation HeiLite

//   # Code change to skip dimension validation only for Sales Invoice

// HEI.15 CHG2187702 SAHAL01 13.10.2023 Revaluation journal items in error

//   # Removed Code

// HEI.16 CHG2187702 PRASAA03 21.12.2023 Revaluation journal items in error

//   # Dimension combination error handled for Rev jour items.

// HEI.17 CHG2255994 IBM KAPOOV01 04.07.2024 P&L Close 2022 in Production Environment

//   # Added code to Skip Dimension combination error.

// HEI.18 CHG2262950 IBM KAPOOV01 06.08.2024 The system allows postings on P&L account without CC Dimension

//   # Modified function-CheckDimensions(GenJnlLine : Record "Gen. Journal Line")

{
    var

        ItemJnlLineError: Record "Item Journal Line";
        CreateLog: Boolean;
        GenJournalBatch: Record "Gen. Journal Batch";
        Cu23: Codeunit "Item Jnl.-Post Batch _DTW";
        Text011: Label 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';

        Text012: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Heineken BC Upgrade", OnBeforeCheckDimensions, '', false, false)]
    local procedure "Heineken BC Upgrade_OnBeforeCheckDimensions"(var Sender: Codeunit "Heineken BC Upgrade"; var GenJnlLine: Record "Gen. Journal Line"; var CheckDone: Boolean)

    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        FinancialUtils: Codeunit "Financial-Utils";
        InitialDimSetID: Integer;
        SourceCodeDimension: Record "Source Code Dimension FND";
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimensionManagement: Codeunit DimensionManagement;
        DimMgt: Codeunit DimensionManagement;

    begin
        IF NOT FinancialUtils.CheckSkipDimCombForSales(GenJnlLine."Document No.", GenJnlLine."Created By Source Code FND") THEN BEGIN //HEI.14
                                                                                                                                  //HEI.17>>
                                                                                                                                  //HEI.18>>
                                                                                                                                  //IF GenJournalBatch.GET(GenJnlLine."Journal Template Name",GenJnlLine."Journal Batch Name") THEN
            IF GenJournalBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") THEN BEGIN
                //HEI.18<<
                IF (GenJournalBatch."Dim. Comb. Not Appl. FND" = FALSE) THEN
                    //HEI.17<<
                    //HEI.18<<
                    if not DimMgt.CheckDimIDComb(GenJnlLine."Dimension Set ID") then
                        // GenJnlCheckLine.ThrowGenJnlLineError(GenJnlLine, Text011, DimMgt.GetDimCombErr()); // BC Upgrade SHUKLP03 << Created a new local procedure to add HEI code and also this global procedure is not in used for other objects.
                        ThrowGenJnlLineErrorLocal(GenJnlLine, Text011, DimMgt.GetDimCombErr());
            END
            ELSE
                //HEI.18<<
                if not DimMgt.CheckDimIDComb(GenJnlLine."Dimension Set ID") then
                    // GenJnlCheckLine.ThrowGenJnlLineError(GenJnlLine, Text011, DimMgt.GetDimCombErr()); // BC Upgrade SHUKLP03 << Created a new local procedure to add HEI code and also this global procedure is not in used for other objects.
                    ThrowGenJnlLineErrorLocal(GenJnlLine, Text011, DimMgt.GetDimCombErr());
        END; //HEI.13

        TableID[1] := DimMgt.TypeToTableID1(GenJnlLine."Account Type".AsInteger());
        No[1] := GenJnlLine."Account No.";
        TableID[2] := DimMgt.TypeToTableID1(GenJnlLine."Bal. Account Type".AsInteger());
        No[2] := GenJnlLine."Bal. Account No.";
        TableID[3] := Database::Job;
        No[3] := GenJnlLine."Job No.";
        TableID[4] := Database::"Salesperson/Purchaser";
        No[4] := GenJnlLine."Salespers./Purch. Code";
        TableID[5] := Database::Campaign;
        No[5] := GenJnlLine."Campaign No.";
        //soicad>>
        InitialDimSetID := GenJnlLine."Dimension Set ID";

        IF InitialDimSetID <> 0 THEN BEGIN
            DimSetEntry.SETRANGE("Dimension Set ID", GenJnlLine."Dimension Set ID");
            IF DimSetEntry.FINDSET THEN
                REPEAT
                    TempDimSetEntry."Dimension Code" := DimSetEntry."Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := DimSetEntry."Dimension Value Code";
                    TempDimSetEntry."Dimension Value ID" := DimSetEntry."Dimension Value ID";
                    TempDimSetEntry.INSERT;
                UNTIL DimSetEntry.NEXT = 0;
        END;
        IF (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account") AND (GenJnlLine."Account No." <> '') THEN BEGIN
            SourceCodeDimension.SETRANGE("GL Account No.", GenJnlLine."Account No.");
            SourceCodeDimension.SETRANGE("Source Code", GenJnlLine."Source Code");
            IF SourceCodeDimension.FINDSET THEN
                REPEAT
                    CLEAR(TempDimSetEntry);
                    TempDimSetEntry."Dimension Code" := SourceCodeDimension."Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := SourceCodeDimension."Dimension Value Code";
                    TempDimSetEntry."Dimension Value ID" := SourceCodeDimension."Dimension Value ID";
                    IF TempDimSetEntry.INSERT THEN;
                UNTIL SourceCodeDimension.NEXT = 0;
        END;
        IF (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"G/L Account") AND (GenJnlLine."Bal. Account No." <> '') THEN BEGIN
            SourceCodeDimension.SETRANGE("GL Account No.", GenJnlLine."Bal. Account No.");
            SourceCodeDimension.SETRANGE("Source Code", GenJnlLine."Source Code");
            IF SourceCodeDimension.FINDSET THEN
                REPEAT
                    CLEAR(TempDimSetEntry);
                    TempDimSetEntry."Dimension Code" := SourceCodeDimension."Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := SourceCodeDimension."Dimension Value Code";
                    TempDimSetEntry."Dimension Value ID" := SourceCodeDimension."Dimension Value ID";
                    IF TempDimSetEntry.INSERT THEN;
                UNTIL SourceCodeDimension.NEXT = 0;
        END;
        GenJnlLine."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
        //soicad<<
        //HEI.17>>
        //HEI.18>>
        //IF GenJournalBatch.GET(GenJnlLine."Journal Template Name",GenJnlLine."Journal Batch Name") THEN
        IF GenJournalBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name") THEN BEGIN
            //HEI.18<<
            IF (GenJournalBatch."Dim. Comb. Not Appl. FND" = FALSE) THEN
                //HEI.17<<
                //HEI.18>>
                IF NOT DimMgt.CheckDimValuePosting(TableID, No, GenJnlLine."Dimension Set ID") THEN
                    // GenJnlCheckLine.ThrowGenJnlLineError(GenJnlLine, Text012, DimMgt.GetDimValuePostingErr); // BC Upgrade SHUKLP03 << Created a new local procedure to add HEI code and also this global procedure is not in used for other objects.
                    ThrowGenJnlLineErrorLocal(GenJnlLine, Text012, DimMgt.GetDimValuePostingErr);
        END
        ELSE begin
            //HEI.18<<
            CheckDone := false;
            //OnCheckDimensionsOnAfterAssignDimTableIDs(GenJnlLine, TableID, No, CheckDone); //check

            if not CheckDone then
                if not DimMgt.CheckDimValuePosting(TableID, No, GenJnlLine."Dimension Set ID") then
                    //GenJnlCheckLine.ThrowGenJnlLineError(GenJnlLine, Text012, DimMgt.GetDimValuePostingErr()); // BC Upgrade SHUKLP03 << Created a new local procedure to add HEI code and also this global procedure is not in used for other objects.
                    ThrowGenJnlLineErrorLocal(GenJnlLine, Text012, DimMgt.GetDimValuePostingErr());
        end;
        GenJnlLine."Dimension Set ID" := InitialDimSetID;//soicad single
        CheckDone := true;
    end;




    local procedure ThrowGenJnlLineErrorLocal(GenJournalLine: Record "Gen. Journal Line"; ErrorTemplate: Text; ErrorText: Text)
    var
        ItemJnlLineL: Record "Item Journal Line";
        ErrorTextL: Text[250];
    // ItemJnlPostBatchL: Codeunit "Item Jnl.-Post Batch";  // BC Upgrade SHUKLP03 << Code moved to Cu23
    //Cu23: Codeunit "Heineken BC Upgrade"; // BC Upgrade SHUKLP03 << 
    begin

        //HEI.16>>
        IF GenJournalLine."Rev. Jnl. Error Log FND" THEN BEGIN
            IF ItemJnlLineL.GET(GenJournalLine."Item Journal Template Name FND", GenJournalLine."Item Journal Batch Name FND", GenJournalLine."Item Journal Line No. FND") THEN BEGIN
                GetItemJnlLine11(ItemJnlLineL);
                IF NOT CheckRevJnlErrorLog(ItemJnlLineL) THEN BEGIN
                    ErrorTextL := COPYSTR(STRSUBSTNO(ErrorTemplate,
                      GenJournalLine.TABLECAPTION, GenJournalLine."Item Journal Template Name FND", GenJournalLine."Item Journal Batch Name FND", GenJournalLine."Item Journal Line No. FND",
                      ErrorText), 1, 250);
                    //ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL); // BC Upgrade SHUKLP03 << Code moved to Cu23  
                    Cu23.InsertRevJnlErrorLog(ItemJnlLineL, ErrorTextL); // BC Upgrade SHUKLP03 <<  //BC Upgrade Kamnay01  change the parameter Item journal lime
                END;
            END;
        END ELSE BEGIN
            //HEI.16<<
            IF GenJournalLine."Line No." <> 0 THEN
                ERROR(
                  ErrorTemplate,
                  GenJournalLine.TABLECAPTION, GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name", GenJournalLine."Line No.",
                  ErrorText);

            ERROR(ErrorText);
            //HEI.16
        end;
    end;


    procedure GetItemJnlLine11(VAR ItemJournalLine: Record "Item Journal Line")
    var
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
        ItemJnlLineError: Record "Item Journal Line";
        CreateLog: Boolean;
    begin
        //HEI.16>>
        CLEAR(ItemJnlLineError);
        CLEAR(CreateLog);
        IF InventorySetupL.GET THEN BEGIN
            IF InventorySetupL."Activate Rev.Jnl.Error Log FND" THEN BEGIN
                IF ItemJnlTemplateL.GET(ItemJournalLine."Journal Template Name") THEN BEGIN
                    IF ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation THEN BEGIN
                        ItemJnlLineError.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                        ItemJnlLineError.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        ItemJnlLineError.SETRANGE("Line No.", ItemJournalLine."Line No.");
                        IF ItemJnlLineError.FINDFIRST THEN;
                        CreateLog := TRUE;
                    END;
                END;
            END;
        END;
        //HEI.16<<
    end;

    procedure CheckRevJnlErrorLog(ItemJournalLine: Record "Item Journal Line"): Boolean
    var
        RevJnlErrorLogL: Record "Revaluation Jrnl Error Log FND";
    begin
        //HEI.16>>
        RevJnlErrorLogL.RESET;
        RevJnlErrorLogL.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
        RevJnlErrorLogL.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
        RevJnlErrorLogL.SETRANGE("Line No.", ItemJournalLine."Line No.");
        IF RevJnlErrorLogL.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
        //HEI.16<<
    end;


}

