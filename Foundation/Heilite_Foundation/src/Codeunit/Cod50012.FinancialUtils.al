codeunit 50012 "Financial-Utils"
{
    // version HEI.55

    // #HEI.01 FDD RTRGAP057 IBM HORTOC01 29.07.2017
    //   # New function ChangeFaIndicator
    // 
    // #HEI.02 FDD RTRGAP051 IBM SOICAD01 29.07.2017
    //   # New function CheckAccountNo
    // 
    // HEI.03 FDD RTRGAP057 IBM POENAB01 14.08.2017
    //   # add new function to check/change Fa. Indicator: CheckFAPostingGroup
    // 
    // HEI.04 FDD RTRGAP057 IBM HORTOC01 29.07.2017
    //   # Setup dimension cost center
    // HEI.05 FDD-SLSGAP001 IBM POENAB01 28.08.2017 # MDM Customer Card
    //   # New function PopulateFieldList.s
    // 
    // HEI.06 FDD-SLSGAP001 IBM NASTAA02 15.09.2017 # MDM Customer Card
    //   # Inserted value in the new Field created "TableID" in function "PopulateFieldList"
    // HEI.07 DefectID 813 IBM HORTOC01 27.10.2017
    //   # Setup dimension capex
    // HEI.08 DefectID 1358 IBM HORTOC01 11.01.2018
    //   # setup dimension
    // HEI.09 PTPGAP085 - IBM HORTOC01 20.03.2018
    //   # new code
    // HEI.10 DefectID 1846 IBM ISYED01 05.04.2018
    //   # When I try a capex dimension creation  - Error message appears if the string > 30
    // HEI.11 FDD PTPGAP084 IBM POSTOI01 23.04.2018
    //   # create new subscribers for Customer Bank Account and Vendor Bank Account tables
    // HEI.12 Defect-3621 # BPM CAPEX - BudGet name headers IBM ISYED01 12.18.2018
    //   # Added code to fill the Dimension value to column header.
    // HEI.16 FDD_CHG2008438 Create CONCAT dimension when adding FA
    //   #Added trigger to table Fixed Asset oninsert
    // HEI.18 CHG2034492 Local Display
    //   # new function suscribed UpdateCustomFieldsGLe to codeunit Codeunit Gen. Jnl.-Post Line
    //   # new function suscribe Get_AccNo2 to OnAfterValidate record in table 81
    // HEI.20 CHG2052196 IBM.PANDES01 15.06.2020
    //  # Added code related to Void check workflow.
    // HEI.21 CHG2076345 IBM.AB 31.08.2020
    //  # Removed HEI.15(done by Shweta Saxena) and HEI.20(done by Catalina Bulimar) as they are not present in Q and
    //    they were causing the issue described in INC2979579
    // HEI.22 CHG2085094 IBM.AB 28.10.2020
    // commented as a workaRound for INC3136909
    // HEI.23 BULIMC01 IBM 05/11/2020 - new subscribers created to automatically update the Dim Hierarchy
    //     #OnAfterModifyT352,OnAfterDeleteT352,OnAfterInsertT352
    // HEI.23 BULIMC01 IBM 05/11/2020 - new subscribers created to automatically update the Dim Hierarchy
    //     #OnAfterModifyT352,OnAfterDeleteT352,OnAfterInsertT352
    // HEI.24 CHG2088988 IBM SHANKJ03 10.11.2020
    //   #FAOnInsertTrigger modified commented old code & new code added
    // HEI.25 CHG2088940 BULIMC01 IBM 23/11/2020 #bug fix - code added to the function "InsertDimFromSourceCodeDim"
    // HEI.26 FDD-HT1330 IBM BULIMC01 08.02.2021#new dimension added to GL entry for Haiti - "Maison des Vins"
    // HEI.27  IBM BULIMC01 19/02/2021 #uncommented HEI.22 changes in order for Column Header to be filled in
    // HEI.28 CHG2003450 IBM.GUNERE01 17.02.2021 # funcs. modified OnSensitiveVendorValidate.
    // HEI.29 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Code written for Sales Post optimizaiton
    //   # Replace FindSet with FindSet(false,false) in Function InsertDimFromSourceCodeDim() & CheckEbf()
    //   # Added SetCurrentKey() in Function InsertDimFromSourceCodeDim()
    // HEI.30 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Subscribers created: OnAfterInsertVATEntry, OnAfterValidateSalesLineQuantity, OnAfterValidateSalesLineUoM, OnAfterValidateSalesLineVATProdPostGr,
    //     OnBeforeReleaseSalesHeader,  OnBeforePostSalesHeader, OnAfterReleaseSalesHeader, OnAfterInsertGLEntry, OnAfterInsertCLEEntry
    // HEI.31 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Subscribers created
    //   # Added Permissions for TableData Value Entry=rimd
    // HEI.33 INC3807811 - CHG2133559  IBM NASTAA02 04.11.2021 #CAD calculation on PQ for Maximo
    //   # Additional CAD lines should be added just on Invoices / Cr Memos
    // HEI.32 FDD-HB2373 - CHG2123486 IBM NANDIS01 24.09.2021 - Development - CMG mandatory on FA card
    //   # Code added for FA Card Dimension updation
    // 
    // HEI.34 INC3923616 - CHG2143523 IBM SURYAS01 21-01-2022 - Code Fix to avoid creation of new line for "CAD account" if there is no VAT calculation
    //   #Code added in function InsertAdditionalCADLine
    // HEI.35 IBM BULIMC01 INC4051602-CHG2153886 13.04.2022#add permissions to GL Entry Table,VAT Entry and Cust. Ledger Entry
    //    #to avoid Errors coming from functions "UpdateCustomFieldsGLe","OnAfterInsertVATEntry" and "OnAfterInsertCLEEntry"
    // HEI.36 INC4081126 IBM SHIVAS05 28.04.2022 - Give permission to this object to Delete insert Modify the VLE
    // HEI.37 CHG2160321 IBM SISUM01 26/01/2023 #New function to insert a specific comb (Dimension Code, Source Code) from Source Dimension Code: InsertDimByDimCodeSrcCodeFromSourceDimCode
    //   #New function to Get dimensions with mandatory code Error: GetDimValuePostingWithErr
    // HEI.38 CHG2171687 IBM SISUM01 06/03/2023 #change the filter value on Ebf Combination
    // HEI.39 CHG2171687 IBM SISUM01 15/03/2023 #bug fix
    // HEI.40 CHG2170300 HB3129 - IBM SRIVAS07 26/04/2023 #Block editing of dimensions during PO Invoice Processing
    //   #New function OnBeforeSendPurchaseOrderApprovalRequest(), for Purhcase Order EBF Combination Checking
    // HEI.41 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite
    //   #create global function CheckSkipDimCombForSales
    // HEI.42 CHG2198895 IBM YADAVM09 16/05/2023 HB3411 Fixed asset mass upload Error.
    //   # Block code in Function T5600OnAfterValidateCMGCode that is deleting the CMG Code
    // HEI.43 CHG2171687 IBM SISUM01 19/05/2023 HB3907 EBF Matrix
    //   #test if New EBF version is enable
    // HEI.44 CHG2170300 HB3129 IBM SRIVAS07 27/06/23 - Development - Block editing of dimensions during PO Invoice Processing
    //   # Code added in OnBeforeSendPurchaseOrderApprovalRequest()
    // HEI.45 CHG2131424 IBM YADAVM09 10/08/2023 HB2520 Dimension Validation HeiLite
    //   #Code add to fix bug CheckSkipDimCombForSales
    // HEI.46 CHG2217488 IBM SISUM01 24/08/2023 Corrections to be done for CHG2160321-HB2942
    //   #Code add to fix the bug in function InsertDim2SkipDimCheck4SrcCodeWithSkip and GetDimValuePostingWithMandErr
    // HEI.47 CHG2187702 SAHAL01 18.09.2023 Revaluation journal items in Error
    //   # Added Code
    // HEI.48 CHG2224401 HB3624 YADAVM09 09.02.2024 Health and Security Levy Tax
    //   # New Function Created
    //                           #OnAfterValidatePurchLineNo
    //                           #OnBeforeupdateAmountPurchLine
    //                           #OnBeforeInsertPurchaseReceiptLineForLevyTax
    //                           #OnBeforePurchInvlineInsertForLevyTax
    //                           #InitFromLevyTaxEntries
    //                           #OnBeforeInsertPurchCRMemoForLevyTax
    //                           #OnBeforeInsertShipmentForLevyTax
    //                           #OnAfterCopyPurchaseDocument
    //                           #InitFromLevyTaxEntriesPurchCrMemo
    //                           #OnAfterInsertValueEntry
    // HEI.49 CHG2231326 HB3599 YADAVM09 IBM 08.02.2024 # Restrict users to connect or disconnect RTR journal templates from the Workflow approval on Opco level.
    //   # New function Added #OnBeforeOpenEventConditions
    //   # Updadated event function Again
    // HEI.51  CHG2236692 IBM SISUM01 25.02.2024 HB3717_Development to perform revaluation for AR/AP
    //   #Add code to function OnAfterInsertGLEntry
    //  HEI.50 CHG2224401 HB3624 YADAVM09 09.02.2024 Health and Security Levy Tax
    //   # Code Added in Function #OnAfterCopyPurchaseDocument
    //   # New Function Created #OnAfterInsertValueEntry
    //    HEI.52 CHG2224401 HB3624 YADAVM09 01.04.2024 Health and Security Levy Tax
    //   # Code Added in function#OnAfterValidatePurchLineNo
    //                           #OnBeforeupdateAmountPurchLine
    //                           #OnBeforeInsertPurchaseReceiptLineForLevyTax
    //                           #OnBeforePurchInvlineInsertForLevyTax
    //                           #InitFromLevyTaxEntries
    //                           #OnBeforeInsertPurchCRMemoForLevyTax
    //                           #OnBeforeInsertShipmentForLevyTax
    //                           #OnAfterCopyPurchaseDocument
    //                           #InitFromLevyTaxEntriesPurchCrMemo
    //                           #OnAfterInsertValueEntry
    // New Function Created      #OnAfterValidatePurchlineHspostingGroup
    // HEI.53 CHG2246792 IBM POENAB02 24.04.2024 Move EBF Matrix dimension Validation to Check Lines of Gen .Journal
    //   # New function CheckEbfJournalLine
    // HEI.54 CHG2258324 IBM POENAB02 03.07.2024 No access to apply payment in the system in dollar currency
    //   # Added permissions for table 50258 G/L Entry Additional
    // HEI.55 CHG2255994 IBM KAPOOV01 04.07.2024 P&L Close 2022 in Production Environment
    //   # Added new code to skip EBF Matrix Validation.

    // BC Upgrade POENAB02, 26.02.2026, Gap/Fit correction for "Setting Workflow for FA and General Journal"

    // BC UPGRADE PATELS08 >>
    // # In InsertCADValueEntry procedure definiton, Changed the AccType parameter from Option to Enum to avoid implicit converison as it can lead to runtime issue.
    // BC UPGRADE PATELS08 <<

    //POENAB02, 08.07.2026, Update GL Entry with "MR Code"

    Permissions = TableData "G/L Entry" = rimd,
                  TableData "Cust. Ledger Entry" = rimd,
                  TableData "Vendor Ledger Entry" = rimd,
                  TableData "VAT Entry" = rimd,
                  TableData "Check Ledger Entry" = imd,
                  TableData "Value Entry" = rimd,
                  TableData "G/L Entry Additional FND" = rimd;

    trigger OnRun();
    begin
        UpdateCostAccHier();
    end;

    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GLSetup: Record "General Ledger Setup";
        ItemJnlLineError: Record "Item Journal Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        CreateLog: Boolean;
        GLSetupRetreived: Boolean;
        Text001: Label 'Maximum size of account number is 8';
        Text011: Label 'Combination of account %1 with dimension %2 is not allowed.';
        Text012: Label 'Are you sure you want to post combination of account %1 with dimension %2';
        TextSensitiveBlock: Label 'Sensitive Workflow Block is activated for customer %1! No change allowed for %2!';
        TxtBudGet: Label 'BudGet';
        TxtFilter: Label '''%1''';
        TxtFormula: Label '100*(%1/%2-1)';
        TxtNetChange: Label 'Net Change';
        TxtVariance: Label 'Variance';

    procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line");
    var
        VendorBankAccount: Record "Vendor Bank Account";
    begin
        if GenJournalLine."Vendor Bank Account FND" <> '' then
            VendorBankAccount.Get(VendorLedgerEntry."Vendor No.", GenJournalLine."Vendor Bank Account FND");
        VendorLedgerEntry."Vendor Bank Account FND" := GenJournalLine."Vendor Bank Account FND";
        //HEI.09>>
        VendorLedgerEntry."On Hold Date FND" := GenJournalLine."On Hold Date FND";
        VendorLedgerEntry."On Hold UserId FND" := GenJournalLine."On Hold UserId FND";
        //HEI.09<<
    end;

    procedure OnBeforeInsertGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry");
    var
        DimSetEntry: Record "Dimension Set Entry";
        ItemJnlLineL: Record "Item Journal Line";
        GLAccount: Record "G/L Account"; //POENAB02, 08.07.2026
    begin
        //HEI.47>>
        if GenJournalLine."Rev. Jnl. Error Log FND" then
            if ItemJnlLineL.Get(GenJournalLine."Item Journal Template Name FND", GenJournalLine."Item Journal Batch Name FND",
              GenJournalLine."Item Journal Line No. FND") then
                GetItemJnlLine(ItemJnlLineL);
        //HEI.47<<
        InsertDimFromSourceCodeDim(GenJournalLine, GLEntry);
        //HEI.55>>
        if GenJournalBatch.Get(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name") then begin
            if (GenJournalBatch."Dim. Comb. Not Appl. FND" = false) then
                CheckEbf(GLEntry);
        end
        else
            //HEI.55<<
            CheckEbf(GLEntry);
        //HEI.08>>
        if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account" then
            InsertDimFromDimensionValue(GenJournalLine, GLEntry);
        //HEI.08<<
        //HEI.26<<
        GLSetup.Get();
        if GLSetup."Maison des Vins Dim. Code FND" <> '' then
            if DimSetEntry.Get(GLEntry."Dimension Set ID", GLSetup."Maison des Vins Dim. Code FND") then
                GLEntry."Maison des Vins Value Code FND" := DimSetEntry."Dimension Value Code";
        //HEI.26>>
        //POENAB02, 08.07.2026>>
        if GLAccount.Get(GLEntry."G/L Account No.") then
            GLEntry."MR Code FND" := GLAccount."MR Code FND";
        //POENAB02, 08.07.2026<<        
    end;

    local procedure InsertDimFromSourceCodeDim(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry");
    var
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        SourceCodeDimension: Record "Source Code Dimension FND";
        DimensionManagement: Codeunit DimensionManagement;
    begin
        GetGLSetup(); //HEI.25
        SourceCodeDimension.SetRange("GL Account No.", GLEntry."G/L Account No.");
        SourceCodeDimension.SetRange("Source Code", GLEntry."Source Code");
        //<<HEI.29
        //IF SourceCodeDimension.FindSet THEN BEGIN
        if SourceCodeDimension.FindSet(false) then begin
            //>>HEI.29
            if GLEntry."Dimension Set ID" <> 0 then begin
                DimSetEntry.SetRange("Dimension Set ID", GLEntry."Dimension Set ID");
                //<<HEI.29
                //IF DimSetEntry.FindSet THEN REPEAT
                if DimSetEntry.FindSet(false) then
                    repeat
                        //>>HEI.29
                        TempDimSetEntry."Dimension Code" := DimSetEntry."Dimension Code";
                        TempDimSetEntry."Dimension Value Code" := DimSetEntry."Dimension Value Code";
                        TempDimSetEntry."Dimension Value ID" := DimSetEntry."Dimension Value ID";
                        TempDimSetEntry.Insert();
                    until DimSetEntry.Next() = 0;
            end;

            repeat
                Clear(TempDimSetEntry);
                TempDimSetEntry.SetRange("Dimension Code", SourceCodeDimension."Dimension Code");
                TempDimSetEntry.DeleteAll();
                Clear(TempDimSetEntry);
                TempDimSetEntry."Dimension Code" := SourceCodeDimension."Dimension Code";
                TempDimSetEntry."Dimension Value Code" := SourceCodeDimension."Dimension Value Code";
                TempDimSetEntry."Dimension Value ID" := SourceCodeDimension."Dimension Value ID";
                TempDimSetEntry.Insert();
                if SourceCodeDimension."Dimension Code" = GLSetup."Global Dimension 1 Code" then
                    GLEntry."Global Dimension 1 Code" := SourceCodeDimension."Dimension Value Code";
                if SourceCodeDimension."Dimension Code" = GLSetup."Global Dimension 2 Code" then
                    GLEntry."Global Dimension 2 Code" := SourceCodeDimension."Dimension Value Code";
            until SourceCodeDimension.Next() = 0;
            GLEntry."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
        end;
    end;

    procedure MaintainCapexDim(DimCode: Code[20]);
    var
        ColumnLayout: Record "Column Layout";
        DimValue: Record "Dimension Value";
        FinancialReport: Record "Financial Report";
        BudGetsLineNo: Code[50];
        LedgersLineNo: Code[50];
        DimNo: Integer;
        LineNo: Integer;
        NoOfDim: Integer;
    begin
        GetGLSetup();
        if GLSetup."Capex Dimension Code FND" = '' then
            exit;
        if GLSetup."Capex Dimension Code FND" <> DimCode then
            exit;
        if GLSetup."Capex Reference BudGet FND" = '' then
            exit;
        if GLSetup."Capex Acc. Schedule Name FND" = '' then
            exit;
        // BC Upgrade POENAB02 >>
        //AccScheduleName.Get(GLSetup."Capex Acc. Schedule Name");
        //AccScheduleName.TestField("Default Column Layout");
        //ColumnLayout.SetRange("Column Layout Name", AccScheduleName."Default Column Layout");
        FinancialReport.Get(GLSetup."Capex Acc. Schedule Name FND");
        FinancialReport.TestField("Financial Report Column Group");
        ColumnLayout.SetRange("Column Layout Name", FinancialReport."Financial Report Column Group");
        // BC Upgrade POENAB02 <<
        ColumnLayout.DeleteAll(true);

        DimNo := 0;
        NoOfDim := 0;
        DimValue.SetRange("Dimension Code", GLSetup."Capex Dimension Code FND");
        NoOfDim := DimValue.Count;
        if DimValue.FindSet() then
            repeat
                LineNo := DimNo * 10000 * 3 + 10000;
                LedgersLineNo := 'L' + Format(LineNo);
                Clear(ColumnLayout);
                // BC Upgrade POENAB02 >>
                //InitColumnLayout(ColumnLayout, AccScheduleName."Default Column Layout", LineNo, DimValue.Code, TxtNetChange);
                InitColumnLayout(ColumnLayout, FinancialReport."Financial Report Column Group", LineNo, DimValue.Code, TxtNetChange);
                // BC Upgrade POENAB02 <<
                ColumnLayout.Insert(true);
                LineNo += 10000;
                BudGetsLineNo := 'L' + Format(LineNo);
                Clear(ColumnLayout);
                // BC Upgrade POENAB02 >>
                //InitColumnLayout(ColumnLayout, AccScheduleName."Default Column Layout", LineNo, DimValue.Code, TxtBudGet);
                InitColumnLayout(ColumnLayout, FinancialReport."Financial Report Column Group", LineNo, DimValue.Code, TxtBudGet);
                // BC Upgrade POENAB02 <<
                ColumnLayout."Ledger Entry Type" := ColumnLayout."Ledger Entry Type"::"BudGet Entries";
                ColumnLayout.Insert(true);
                LineNo += 10000;
                Clear(ColumnLayout);
                // BC Upgrade POENAB02 >>
                //InitColumnLayout(ColumnLayout, AccScheduleName."Default Column Layout", LineNo, DimValue.Code, TxtVariance);
                InitColumnLayout(ColumnLayout, FinancialReport."Financial Report Column Group", LineNo, DimValue.Code, TxtVariance);
                // BC Upgrade POENAB02 <<
                ColumnLayout."Column Type" := ColumnLayout."Column Type"::Formula;
                ColumnLayout.Formula := StrSubstNo(TxtFormula, LedgersLineNo, BudGetsLineNo);
                ColumnLayout.Insert(true);
                LineNo += 10000;
                DimNo += 1;
            until DimValue.Next() = 0;
    end;

    local procedure GetGLSetup();
    begin
        if not GLSetupRetreived then begin
            GLSetup.Get();
            GLSetupRetreived := true;
        end;
    end;

    local procedure InitColumnLayout(var ColumnLayout: Record "Column Layout"; ColumnLayoutName: Code[50]; LineNo: Integer; DimValueCode: Code[20]; HeaderText: Text[50]);
    begin
        ColumnLayout.Init();
        ColumnLayout."Column Layout Name" := ColumnLayoutName;
        ColumnLayout."Line No." := LineNo;
        ColumnLayout."Column No." := 'L' + Format(LineNo);
        //HEI.10>>
        //ColumnLayout."Column Header" := StrSubstNo(HeaderText,DimValueCode); //OLD CODE
        //HEI.12>>
        //ColumnLayout."Column Header" := CopySTR(StrSubstNo(HeaderText,DimValueCode),30);//oldcode
        ColumnLayout."Column Header" := HeaderText + ' ' + DimValueCode;//HEI.22 (commented as a workaRound for INC3136909)
        //HEI.12<<
        //HEI.10<<
        ColumnLayout."Dimension 1 Totaling" := StrSubstNo(TxtFilter, DimValueCode);
    end;

    procedure ReverseDetailedAdjmt(var GLEntry: Record "G/L Entry");
    var
        SourceCodeSetup: Record "Source Code Setup";
    begin
        //with GLEntry do begin // BC Upgrade POENAB02 - commented, as the "with" command is going to be deprecated in the future
        SourceCodeSetup.Get();
        if GLEntry."Source Code" <> SourceCodeSetup."Exchange Rate Adjmt." then
            exit;
        // end; // BC Upgrade POENAB02
    end;

    procedure ChangeFaIndicator(var FixedAsset: Record "Fixed Asset");
    var
        DefaultDimension: Record "Default Dimension";
        DepreciationBook: Record "Depreciation Book";
        FADepreciationBook: Record "FA Depreciation Book";
        GeneralLedgerSetup: Record "General Ledger Setup";
        BlockedAccountExists: Boolean;
        ExistCostCenterDim: Boolean;
        StatusChanged: Boolean;
        NoOfDefaultDepreBook: Integer;
        NoOfFaDeprBook: Integer;
    begin
        //HEI.01>>
        GeneralLedgerSetup.Get();//HEI.04
        GeneralLedgerSetup.TestField("Cost Center Dimension Code FND");//HEI.04
        GeneralLedgerSetup.TestField("Capex Dimension Code FND");//HEI.07
        StatusChanged := false;
        Clear(NoOfDefaultDepreBook);
        Clear(NoOfFaDeprBook);
        ExistCostCenterDim := false;
        if (FixedAsset."Vendor No." = '') or (FixedAsset."Serial No." = '') or (FixedAsset."Responsible Employee" = '') then begin
            FixedAsset."Asset Indicator FND" := FixedAsset."Asset Indicator FND"::"1";
            StatusChanged := true;
        end else begin
            FixedAsset."Asset Indicator FND" := FixedAsset."Asset Indicator FND"::OK;
            StatusChanged := true;
        end;

        DepreciationBook.Reset();
        DepreciationBook.SetRange("Default Depr. Book FND", true);
        NoOfDefaultDepreBook := DepreciationBook.Count;

        FADepreciationBook.Reset();
        FADepreciationBook.SetRange("FA No.", FixedAsset."No.");
        NoOfFaDeprBook := FADepreciationBook.Count;
        //IF DefaultDimension.Get(5600,FixedAsset."No.",'CC') THEN
        //IF DefaultDimension.Get(5600,FixedAsset."No.",GeneralLedgerSetup."Cost Center Dimension Code") THEN//HEI.04////HEI.07>>
        //HEI.07>>
        DefaultDimension.Reset();
        DefaultDimension.SetRange("Table ID", 5600);
        DefaultDimension.SetRange("No.", FixedAsset."No.");
        DefaultDimension.SetFilter("Dimension Code", '%1|%2', GeneralLedgerSetup."Cost Center Dimension Code FND", GeneralLedgerSetup."Capex Dimension Code FND");
        if DefaultDimension.Count = 2 then
            ExistCostCenterDim := true;
        //HEI.07<<
        //HEI.03>>
        BlockedAccountExists := CheckFAPostingGroup(FixedAsset."FA Posting Group");
        //HEI.03<<

        //HEI.03>>
        //IF (FixedAsset.Blocked = TRUE) OR (NoOfFaDeprBook <> NoOfDefaultDepreBook) OR (ExistCostCenterDim = FALSE) THEN BEGIN
        if (FixedAsset.Blocked = true) or (NoOfFaDeprBook <> NoOfDefaultDepreBook) or (ExistCostCenterDim = false) or (BlockedAccountExists = true) then begin
            //HEI.03<<
            StatusChanged := true;
            FixedAsset."Asset Indicator FND" := FixedAsset."Asset Indicator FND"::"2";
        end else
            if StatusChanged = false then begin
                FixedAsset."Asset Indicator FND" := FixedAsset."Asset Indicator FND"::OK;
                StatusChanged := true;
            end;

        ///IF StatusChanged  = TRUE THEN
         // FixedAsset.Modify(TRUE);
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Table, 15, 'OnAfterValidateEvent', 'No.', false, false)]
    procedure CheckAccountNo(var Rec: Record "G/L Account"; var xRec: Record "G/L Account"; CurrFieldNo: Integer);
    begin
        //HEI.02>>
        if StrLen(Rec."No.") <> 8 then
            Error(Text001);
        //HEI.02<<
    end;

    local procedure CheckFAPostingGroup(FAPostingGroupCode: Code[10]): Boolean;
    var
        lFAPostingGroup: Record "FA Posting Group";
        lGLAccount: Record "G/L Account";
    begin
        //<<HEI.03
        if lFAPostingGroup.Get(FAPostingGroupCode) then begin
            if lFAPostingGroup."Acquisition Cost Account" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Acquisition Cost Account") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Accum. Depreciation Account" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Accum. Depreciation Account") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Write-Down Account" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Write-Down Account") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Appreciation Account" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Appreciation Account") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Custom 1 Account" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Custom 1 Account") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Custom 2 Account" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Custom 2 Account") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Acq. Cost Acc. on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Acq. Cost Acc. on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Accum. Depr. Acc. on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Accum. Depr. Acc. on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Write-Down Acc. on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Write-Down Acc. on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Appreciation Acc. on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Appreciation Acc. on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Custom 1 Account on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Custom 1 Account on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Custom 2 Account on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Custom 2 Account on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Gains Acc. on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Gains Acc. on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Losses Acc. on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Losses Acc. on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Book Val. Acc. on Disp. (Gain)" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Book Val. Acc. on Disp. (Gain)") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Sales Acc. on Disp. (Gain)" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Sales Acc. on Disp. (Gain)") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Write-Down Bal. Acc. on Disp." <> '' then
                if lGLAccount.Get(lFAPostingGroup."Write-Down Bal. Acc. on Disp.") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Apprec. Bal. Acc. on Disp." <> '' then
                if lGLAccount.Get(lFAPostingGroup."Apprec. Bal. Acc. on Disp.") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Custom 1 Bal. Acc. on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Custom 1 Bal. Acc. on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Custom 2 Bal. Acc. on Disposal" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Custom 2 Bal. Acc. on Disposal") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Maintenance Expense Account" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Maintenance Expense Account") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Maintenance Bal. Acc." <> '' then
                if lGLAccount.Get(lFAPostingGroup."Maintenance Bal. Acc.") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Acquisition Cost Bal. Acc." <> '' then
                if lGLAccount.Get(lFAPostingGroup."Acquisition Cost Bal. Acc.") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Depreciation Expense Acc." <> '' then
                if lGLAccount.Get(lFAPostingGroup."Depreciation Expense Acc.") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Write-Down Expense Acc." <> '' then
                if lGLAccount.Get(lFAPostingGroup."Write-Down Expense Acc.") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Appreciation Bal. Account" <> '' then
                if lGLAccount.Get(lFAPostingGroup."Appreciation Bal. Account") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Custom 1 Expense Acc." <> '' then
                if lGLAccount.Get(lFAPostingGroup."Custom 1 Expense Acc.") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Custom 2 Expense Acc." <> '' then
                if lGLAccount.Get(lFAPostingGroup."Custom 2 Expense Acc.") then
                    if lGLAccount.Blocked = true then
                        exit(true);
            if lFAPostingGroup."Sales Bal. Acc." <> '' then
                if lGLAccount.Get(lFAPostingGroup."Sales Bal. Acc.") then
                    if lGLAccount.Blocked = true then
                        exit(true);
        end;
        exit(false);
        //>>HEI.03
    end;

    procedure PopulateFieldList();
    var
        FieldsVirtual: Record "Field";
        MDMCustomerFields: Record "MDM Customer Fields FND";
    begin
        //<<HEI.05
        if MDMCustomerFields.FindFirst() then
            MDMCustomerFields.DeleteAll();

        FieldsVirtual.Reset();
        FieldsVirtual.SetFilter(TableNo, '%1|%2', 18, 50072);
        if FieldsVirtual.FindSet(false) then
            repeat
                //>>HEI.06
                MDMCustomerFields.Validate("Table ID", FieldsVirtual.TableNo);
                MDMCustomerFields.Validate("Field ID", FieldsVirtual."No.");
                MDMCustomerFields.Insert();
                //<<HEI.06
                if FieldsVirtual.TableNo = 18 then
                    MDMCustomerFields.Validate(TableNo, MDMCustomerFields.TableNo::Cust);
                if FieldsVirtual.TableNo = 50072 then
                    MDMCustomerFields.Validate(TableNo, MDMCustomerFields.TableNo::"Cust. Attributes");
                MDMCustomerFields.Modify();
            until FieldsVirtual.Next() = 0;
        //>>HEI.05
    end;

    [EventSubscriber(ObjectType::Table, 349, 'OnAfterInsertEvent', '', false, false)]
    local procedure CapexMantain1(var Rec: Record "Dimension Value"; RunTrigger: Boolean);
    begin
        if Rec.IsTemporary then
            exit;
        MaintainCapexDim(Rec."Dimension Code");
    end;

    [EventSubscriber(ObjectType::Table, 349, 'OnAfterModifyEvent', '', false, false)]
    local procedure CapexMantain2(var Rec: Record "Dimension Value"; var xRec: Record "Dimension Value"; RunTrigger: Boolean);
    begin
        if Rec.IsTemporary then
            exit;
        MaintainCapexDim(Rec."Dimension Code");
    end;

    local procedure CheckEbf(var GLEntry: Record "G/L Entry");
    var
        DimSetEntry: Record "Dimension Set Entry";
        EbfCombination: Record "Ebf Combination FND";
        StartPosNoDigits: array[4] of Integer;
        FilterOperator: Text;
        ErrorTextL: Text[250];
    begin
        //HEI.38>>
        GetEBFFilterPattern(StartPosNoDigits, FilterOperator);
        //HEI.38<<

        DimSetEntry.SetRange("Dimension Set ID", GLEntry."Dimension Set ID");
        //<<HEI.29
        //IF DimSetEntry.FindSet THEN REPEAT
        if DimSetEntry.FindSet(false) then
            repeat
                //>>HEI.29
                Clear(EbfCombination);

                if (GLEntry."G/L Account No." <> '') and (DimSetEntry."Dimension Value Code" <> '') then begin //HEI.38
                                                                                                               //<<HEI.29
                    EbfCombination.SetCurrentKey("GL Account No.", "Dimension Code", "Dimension Value Code");
                    //>>HEI.29

                    if EbfCombination.CheckNewEBFMatrixIsActive() then begin //HEI.43
                                                                             //HEI.38>>
                                                                             //EbfCombination.SetRange("GL Account No.",GLEntry."G/L Account No.");
                        EbfCombination.SetFilter("GL Account No.", CopyStr(GLEntry."G/L Account No.", StartPosNoDigits[1], StartPosNoDigits[2]) + FilterOperator);
                        //HEI.38<<

                        EbfCombination.SetRange("Dimension Code", DimSetEntry."Dimension Code");

                        //HEI.38>>
                        //EbfCombination.SetRange("Dimension Value Code",DimSetEntry."Dimension Value Code");
                        EbfCombination.SetFilter("Dimension Value Code", FilterOperator + CopyStr(DimSetEntry."Dimension Value Code", StartPosNoDigits[3], StartPosNoDigits[4]) + FilterOperator);
                        //HEI.38<<

                        //HEI.43>>
                    end else begin
                        EbfCombination.SetRange("GL Account No.", GLEntry."G/L Account No.");
                        EbfCombination.SetRange("Dimension Code", DimSetEntry."Dimension Code");
                        EbfCombination.SetRange("Dimension Value Code", DimSetEntry."Dimension Value Code");
                    end;
                    //HEI.43<<

                    if EbfCombination.FindFirst() then begin
                        if EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed" then
                            //HEI.47>>
                            if CreateLog then begin
                                ErrorTextL := CopyStr(StrSubstNo(Text011, GLEntry."G/L Account No.",
                                  DimSetEntry."Dimension Value Code"), 1, 250);
                                //ItemJnlPostBatchL.Insert()RevJnlErrorLog(ItemJnlLineError, ErrorTextL);  // BC Upgrade NANDIS03 - Temporary blocked for compilation
                                Clear(ErrorTextL);
                            end else
                                //HEI.47<<
                                Error(Text011, GLEntry."G/L Account No.", DimSetEntry."Dimension Value Code");
                        if GuiAllowed then
                            if EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Allowed with Warn" then
                                if not Confirm(StrSubstNo(Text012, GLEntry."G/L Account No.", DimSetEntry."Dimension Value Code")) then
                                    Error('');
                    end;
                end; //HEI.38
            until DimSetEntry.Next() = 0;
    end;

    local procedure UpdateCostAccHier();
    var
        BrandDimHier: Record "Brand Dim Hierarchy FND";
        Customer: Record Customer;
        CustomerHierarchy: Record "Customer Hierarchy FND";
        DefaultDim: Record "Default Dimension";
        Item: Record Item;
        BusSeg: Code[20];
        Channel: Code[20];
        Dim1: Code[20];
        Dim2: Code[20];
        Dim3: Code[20];
        Dim4: Code[20];
        ServiceZone: Code[20];
    begin
        GLSetup.Get();
        GLSetup.TestField("SKU Dimension Code FND");
        GLSetup.TestField("Brand Dimension Code FND");
        GLSetup.TestField("Customer Dimension Code FND");
        GLSetup.TestField("Line ext Dimension Code FND");
        GLSetup.TestField("Primary Pack Type Dim FND");
        GLSetup.TestField("Business Type Dim Code FND");

        BrandDimHier.DeleteAll();
        if Item.FindSet(false) then //FindSet
            repeat
                Dim1 := '';
                Dim2 := '';
                Dim3 := '';
                Dim4 := '';
                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Item);
                DefaultDim.SetRange("No.", Item."No.");
                DefaultDim.SetRange("Dimension Code", GLSetup."Brand Dimension Code FND");
                if DefaultDim.FindFirst() then
                    Dim1 := DefaultDim."Dimension Value Code";

                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Item);
                DefaultDim.SetRange("No.", Item."No.");
                DefaultDim.SetRange("Dimension Code", GLSetup."Line ext Dimension Code FND");
                if DefaultDim.FindFirst() then
                    Dim2 := DefaultDim."Dimension Value Code";

                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Item);
                DefaultDim.SetRange("No.", Item."No.");
                DefaultDim.SetRange("Dimension Code", GLSetup."Primary Pack Type Dim FND");
                if DefaultDim.FindFirst() then
                    Dim3 := DefaultDim."Dimension Value Code";


                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Item);
                DefaultDim.SetRange("No.", Item."No.");
                DefaultDim.SetRange("Dimension Code", GLSetup."Primary Pack Type Dim FND");
                if DefaultDim.FindFirst() then
                    Dim4 := DefaultDim."Dimension Value Code";
                if (Dim1 <> '') and (Dim2 <> '') and (Dim3 <> '') and (Dim4 <> '') then begin
                    Clear(BrandDimHier);
                    BrandDimHier."Dimension Level 1 Code" := GLSetup."Brand Dimension Code FND";
                    BrandDimHier."Dimension Level 1 Value Code" := Dim1;
                    BrandDimHier."Dimension Level 2 Code" := GLSetup."Line ext Dimension Code FND";
                    BrandDimHier."Dimension Level 2 Value Code" := Dim2;
                    BrandDimHier."Dimension Level 3 Code" := GLSetup."Primary Pack Type Dim FND";
                    BrandDimHier."Dimension Level 3 Value Code" := Dim3;
                    BrandDimHier."Item No." := Item."No.";
                    if BrandDimHier.Insert() then;
                end;
            until Item.Next() = 0;

        //BusSeg := 'BUSINESS SEGMENT';
        BusSeg := GLSetup."Business Type Dim Code FND";
        ServiceZone := 'SERVICE ZONE';
        Channel := 'CHANNEL';
        CustomerHierarchy.DeleteAll();
        ;
        if Customer.FindSet(false) then
            repeat
                Dim1 := '';
                Dim2 := '';
                Dim3 := '';
                Dim4 := '';
                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Customer);
                DefaultDim.SetRange("No.", Customer."No.");
                DefaultDim.SetRange("Dimension Code", BusSeg);
                if DefaultDim.FindFirst() then
                    Dim1 := DefaultDim."Dimension Value Code";

                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Customer);
                DefaultDim.SetRange("No.", Customer."No.");
                DefaultDim.SetRange("Dimension Code", ServiceZone);
                if DefaultDim.FindFirst() then
                    Dim2 := DefaultDim."Dimension Value Code";

                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Customer);
                DefaultDim.SetRange("No.", Customer."No.");
                DefaultDim.SetRange("Dimension Code", Channel);
                if DefaultDim.FindFirst() then
                    Dim3 := DefaultDim."Dimension Value Code";

                if (Dim1 <> '') and (Dim2 <> '') and (Dim3 <> '') then begin
                    Clear(CustomerHierarchy);
                    CustomerHierarchy."Dimension Level 1 Code" := BusSeg;
                    CustomerHierarchy."Dimension Level 1 Value Code" := Dim1;
                    CustomerHierarchy."Dimension Level 2 Code" := ServiceZone;
                    CustomerHierarchy."Dimension Level 2 Value Code" := Dim2;
                    CustomerHierarchy."Dimension Level 3 Code" := Channel;
                    CustomerHierarchy."Dimension Level 3 Value Code" := Dim3;
                    CustomerHierarchy."Customer No." := Customer."No.";
                    if CustomerHierarchy.Insert() then;
                end;
            until Customer.Next() = 0;
    end;

    procedure InsertGLLinePrep(var PurchaseHeader: Record "Purchase Header");
    var
        PaymentMethod: Record "Payment Method";
        PurchLine: Record "Purchase Line";
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
    begin
        if PurchaseHeader."Buy-from Vendor No." = '' then
            exit;
        PurchaseHeader.Validate("Prepayment %", 100);

        PurchaseHeader.Modify(true);
        PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchLine.SetRange(Type, PurchLine.Type::"G/L Account");
        PurchLine.SetFilter(Quantity, '%1', 1);
        if PurchLine.FindFirst() then
            exit;
        Vendor.Get(PurchaseHeader."Buy-from Vendor No.");
        Vendor.TestField("Vendor Posting Group");
        VendorPostingGroup.Get(Vendor."Vendor Posting Group");
        VendorPostingGroup.TestField("Prepayment Request Account FND");

        Vendor.TestField("Payment Method Code");
        PaymentMethod.Get(Vendor."Payment Method Code");
        if PaymentMethod."Mandatory Bank details FND" then
            Vendor.TestField("Preferred Bank Account Code");
        Clear(PurchLine);
        PurchLine.Init();
        PurchLine."Document Type" := PurchaseHeader."Document Type";
        PurchLine."Document No." := PurchaseHeader."No.";
        PurchLine.Insert(true);
        PurchLine.Validate("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
        PurchLine.Validate(Type, PurchLine.Type::"G/L Account");
        PurchLine.Validate("No.", VendorPostingGroup."Prepayment Request Account FND");
        PurchLine.Validate(Quantity, 1);
        PurchLine.Modify(true);
    end;

    local procedure InsertDimFromDimensionValue(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry");
    var
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        TempDimensionSetEntry2: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";
        DimensionManagement: Codeunit DimensionManagement;
    begin
        //HEI.08>>
        GLSetup.Get();
        GLSetup.TestField("Cost Center Dimension Code FND");
        if GLEntry."Dimension Set ID" <> 0 then begin
            DimensionManagement.GetDimensionSet(TempDimensionSetEntry, GLEntry."Dimension Set ID");
            TempDimensionSetEntry.Reset();
            TempDimensionSetEntry.SetRange("Dimension Code", GLSetup."Cost Center Dimension Code FND");
            if TempDimensionSetEntry.FindFirst() then begin
                DimensionValue.Get(TempDimensionSetEntry."Dimension Code", TempDimensionSetEntry."Dimension Value Code");
                if DimensionValue."Linked Dimension Code FND" <> '' then begin
                    DimensionValue.TestField("Linked Dime. Value Code FND");
                    TempDimensionSetEntry.Reset();
                    TempDimensionSetEntry.SetRange("Dimension Code", DimensionValue."Linked Dimension Code FND");
                    if not TempDimensionSetEntry.FindFirst() then begin
                        DimensionManagement.GetDimensionSet(TempDimensionSetEntry2, GLEntry."Dimension Set ID");
                        TempDimensionSetEntry2."Dimension Code" := DimensionValue."Linked Dimension Code FND";
                        TempDimensionSetEntry2."Dimension Value Code" := DimensionValue."Linked Dime. Value Code FND";
                        TempDimensionSetEntry2.Insert();
                        GLEntry."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry2);
                    end;
                end;
            end;
        end;
        //HEI.08<<
    end;

    [EventSubscriber(ObjectType::Table, 287, 'OnBeforeValidateEvent', 'Bank Account No.', false, false)]
    local procedure OnSensitiveCustBankAccNoValidate(var Rec: Record "Customer Bank Account"; var xRec: Record "Customer Bank Account"; CurrFieldNo: Integer);
    var
        Customer: Record Customer;
    begin
        //HEI.11
        if Customer.Get(Rec."Customer No.") then
            if Customer."Sensitive Workflow Block FND" then;
        //Error(TextSensitiveBlock, Customer.Name, Rec.FIELDCAPTION(Rec."Bank Account No.")); // HEI.28
    end;

    [EventSubscriber(ObjectType::Table, 287, 'OnBeforeValidateEvent', 'Bank Branch No.', false, false)]
    local procedure OnSensitiveCustBankBranchNoValidate(var Rec: Record "Customer Bank Account"; var xRec: Record "Customer Bank Account"; CurrFieldNo: Integer);
    var
        Customer: Record Customer;
    begin
        //HEI.11
        if Customer.Get(Rec."Customer No.") then
            if Customer."Sensitive Workflow Block FND" then;
        //Error(TextSensitiveBlock, Customer.Name, Rec.FIELDCAPTION(Rec."Bank Branch No.")); // HEI.28
    end;

    [EventSubscriber(ObjectType::Table, 287, 'OnBeforeValidateEvent', 'IBAN', false, false)]
    local procedure OnSensitiveCustIBANValidate(var Rec: Record "Customer Bank Account"; var xRec: Record "Customer Bank Account"; CurrFieldNo: Integer);
    var
        Customer: Record Customer;
    begin
        //HEI.11
        if Customer.Get(Rec."Customer No.") then
            if Customer."Sensitive Workflow Block FND" then
                Error(TextSensitiveBlock, Customer.Name, Rec.FieldCaption(Rec.IBAN));
    end;

    [EventSubscriber(ObjectType::Table, 288, 'OnBeforeValidateEvent', 'Bank Account No.', false, false)]
    local procedure OnSensitiveVendBankAccNoValidate(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account"; CurrFieldNo: Integer);
    var
        Vendor: Record Vendor;
    begin
        //HEI.11
        if Vendor.Get(Rec."Vendor No.") then
            if Vendor."Sensitive Workflow Block FND" then;
        //Error(TextSensitiveBlock, Vendor.Name, Rec.FIELDCAPTION(Rec."Bank Account No.")); // HEI.28
    end;

    [EventSubscriber(ObjectType::Table, 288, 'OnBeforeValidateEvent', 'Bank Branch No.', false, false)]
    local procedure OnSensitiveVendBankBranchNoValidate(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account"; CurrFieldNo: Integer);
    var
        Vendor: Record Vendor;
    begin
        //HEI.11
        if Vendor.Get(Rec."Vendor No.") then
            if Vendor."Sensitive Workflow Block FND" then;
        //Error(TextSensitiveBlock, Vendor.Name, Rec.FIELDCAPTION(Rec."Bank Branch No."));
    end;

    // BC Upgrade POENAB02 >>
    // The below function was moved to Codeunit 51005 "Heineken FA Events", due to the fact
    // that it belongs to interfaces    
    // [EventSubscriber(ObjectType::Table, 5600, 'OnAfterInsertEvent', '', false, false)]
    // local procedure FAOnInsertTrigger(var Rec: Record "Fixed Asset"; RunTrigger: Boolean);
    // var
    //     GeneralInterfaceSetup: Record "General Interface Setup";
    //     DimensionValue: Record "Dimension Value";
    //     DefaultDimension: Record "Default Dimension";
    //     DimensionValue_1: Record "Dimension Value";
    //     DefaultDimension_1: Record "Default Dimension";
    //     FARec: Record "Fixed Asset";
    //     DimCode: Code[20];
    //     DimDesc: Text;
    // begin
    //     //HEI.16
    //     GeneralInterfaceSetup.Get();
    //     DimensionValue.Init();
    //     DimensionValue.Validate("Dimension Code", GeneralInterfaceSetup."Project Dimension Code");
    //     DimensionValue.Validate(Code, Rec."No.");
    //     DimensionValue.Validate(Name, Rec."No.");
    //     DimensionValue.Insert();//(TRUE);

    //     DefaultDimension.Init();
    //     DefaultDimension.Validate("Table ID", 5600);
    //     DefaultDimension.Validate("No.", Rec."No.");
    //     DefaultDimension.Validate("Dimension Code", GeneralInterfaceSetup."Project Dimension Code");
    //     DefaultDimension.Validate("Dimension Value Code", Rec."No.");
    //     //HEI.19 >>
    //     DimCode := Rec."No.";
    //     //HEI.19 <<
    //     DefaultDimension.Insert();//T(TRUE);
    //                               //HEI.19 >>
    //                               //HEI.24 >>
    //                               /*
    //                               //FARec.Reset;
    //                               //IF FARec.Get(Rec."No.") THEN BEGIN
    //                                 DimensionValue.Reset;
    //                                 IF DimensionValue.Get(GeneralInterfaceSetup."Project Dimension Code",DimCode) THEN BEGIN
    //                                   //FARec.Description := DimensionValue.Name;
    //                                   //FARec.Modify;
    //                                  Rec.Description := DimensionValue.Name;
    //                                  Rec.Modify;
    //                               //HEI.19 <<
    //                              end;
    //                              */
    //                               //HEI.24<<
    //                               //HEI.16
    // end;
    // BC Upgrade POENAB02 <<

    [EventSubscriber(ObjectType::Table, 288, 'OnBeforeValidateEvent', 'IBAN', false, false)]
    local procedure OnSensitiveVendIBANValidate(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account"; CurrFieldNo: Integer);
    var
        Vendor: Record Vendor;
    begin
        //HEI.11
        if Vendor.Get(Rec."Vendor No.") then
            if Vendor."Sensitive Workflow Block FND" then;
        //Error(TextSensitiveBlock,  Vendor.Name, Rec.FIELDCAPTION(Rec.IBAN));
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInsertGlobalGLEntry', '', false, false)]
    local procedure UpdateCustomFieldsGLe(var GLEntry: Record "G/L Entry");
    var
        GLAcc: Record "G/L Account";
    begin
        //HEI.18>>
        GLAcc.Reset();
        if GLAcc.Get(GLEntry."G/L Account No.") then begin
            GLEntry."No. 2 FND" := GLAcc."No. 2";
            GLEntry.Modify();
            GLEntry.Get(GLEntry."Entry No.");
        end;
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterValidateEvent', 'Account No.', false, false)]
    procedure Get_AccNo2(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer);
    var
        Banks: Record "Bank Account";
        BPG: Record "Bank Account Posting Group";
        Customers: Record Customer;
        CPG: Record "Customer Posting Group";
        GLA: Record "G/L Account";
        GPS: Record "General Posting Setup";
        Vendors: Record Vendor;
        VPG: Record "Vendor Posting Group";
        GLAccNo: Code[20];
    begin
        //HEI.18>>
        if CurrFieldNo in [4, 11] then begin
            case Rec."Account Type" of
                Rec."Account Type"::"G/L Account":
                    GLAccNo := Rec."Account No.";
                Rec."Account Type"::"Bank Account":
                    begin
                        if Banks.Get(Rec."Account No.") then
                            // BC Upgrade POENAB02 >>
                            //if BPG.Get(Banks."Bank Acc. Posting Group") then GLAccNo := BPG."G/L Bank Account No.";
                            if BPG.Get(Banks."Bank Acc. Posting Group") then GLAccNo := BPG."G/L Account No.";
                        // BC Upgrade POENAB02 <<
                    end;
                //end;
                Rec."Account Type"::Customer:
                    begin
                        if Customers.Get(Rec."Account No.") then begin
                            if CPG.Get(Customers."Customer Posting Group") then GLAccNo := CPG."Receivables Account";
                        end;
                    end;
                Rec."Account Type"::Vendor:
                    begin
                        if Vendors.Get(Rec."Account No.") then begin
                            if VPG.Get(Vendors."Vendor Posting Group") then GLAccNo := VPG."Payables Account";
                        end;
                    end;
            end;
            if StrLen(GLAccNo) > 0 then begin
                if GLA.Get(GLAccNo) then Rec."G/L Acc. No. 2 FND" := GLA."No. 2";
            end else
                Clear(Rec."G/L Acc. No. 2 FND");
            // Rec.Modify;
        end;
        //HEI.18<<
    end;

    [EventSubscriber(ObjectType::Table, 352, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyT352(var Rec: Record "Default Dimension"; var xRec: Record "Default Dimension"; RunTrigger: Boolean);
    var
        BrandDimHier: Record "Brand Dim Hierarchy FND";
        // CustomerHierarchy: Record "Customer Hierarchy";
        // BrandDimHier: Record "Brand Dim Hierarchy";
        CustomerHierarchy: Record "Customer Hierarchy FND";
        DefaultDim: Record "Default Dimension";
        FixedAsset: Record "Fixed Asset";
        Dim1: Code[20];
        Dim2: Code[20];
        Dim3: Code[20];
    begin
        //HEI.23<<
        GLSetup.Get();
        GLSetup.TestField("Brand Dimension Code FND");
        GLSetup.TestField("Line ext Dimension Code FND");
        GLSetup.TestField("Primary Pack Type Dim FND");
        GLSetup.TestField("Business Type Dim Code FND");

        //update Brand Dim Hierarchy
        if Rec."Table ID" = DATABASE::Item then begin
            Clear(DefaultDim);
            DefaultDim.SetRange("Table ID", DATABASE::Item);
            DefaultDim.SetRange("No.", Rec."No.");
            DefaultDim.SetRange("Dimension Code", GLSetup."Brand Dimension Code FND");
            if DefaultDim.FindFirst() then
                Dim1 := DefaultDim."Dimension Value Code";

            Clear(DefaultDim);
            DefaultDim.SetRange("Table ID", DATABASE::Item);
            DefaultDim.SetRange("No.", Rec."No.");
            DefaultDim.SetRange("Dimension Code", GLSetup."Line ext Dimension Code FND");
            if DefaultDim.FindFirst() then
                Dim2 := DefaultDim."Dimension Value Code";

            Clear(DefaultDim);
            DefaultDim.SetRange("Table ID", DATABASE::Item);
            DefaultDim.SetRange("No.", Rec."No.");
            DefaultDim.SetRange("Dimension Code", GLSetup."Primary Pack Type Dim FND");
            if DefaultDim.FindFirst() then
                Dim3 := DefaultDim."Dimension Value Code";

            BrandDimHier.Reset();
            BrandDimHier.SetRange("Item No.", Rec."No.");
            if BrandDimHier.FindFirst() then
                BrandDimHier.Delete();

            if (Dim1 <> '') and (Dim2 <> '') and (Dim3 <> '') then begin
                Clear(BrandDimHier);
                BrandDimHier."Dimension Level 1 Code" := GLSetup."Brand Dimension Code FND";
                BrandDimHier."Dimension Level 1 Value Code" := Dim1;
                BrandDimHier."Dimension Level 2 Code" := GLSetup."Line ext Dimension Code FND";
                BrandDimHier."Dimension Level 2 Value Code" := Dim2;
                BrandDimHier."Dimension Level 3 Code" := GLSetup."Primary Pack Type Dim FND";
                BrandDimHier."Dimension Level 3 Value Code" := Dim3;
                BrandDimHier."Item No." := Rec."No.";
                if BrandDimHier.Insert() then;
            end;
        end;

        //update Customer Dim Hierarchy
        if Rec."Table ID" = DATABASE::Customer then begin
            Clear(DefaultDim);
            DefaultDim.SetRange("Table ID", DATABASE::Customer);
            DefaultDim.SetRange("No.", Rec."No.");
            DefaultDim.SetRange("Dimension Code", GLSetup."Business Type Dim Code FND");
            if DefaultDim.FindFirst() then
                Dim1 := DefaultDim."Dimension Value Code";

            Clear(DefaultDim);
            DefaultDim.SetRange("Table ID", DATABASE::Customer);
            DefaultDim.SetRange("No.", Rec."No.");
            DefaultDim.SetRange("Dimension Code", 'SERVICE ZONE');
            if DefaultDim.FindFirst() then
                Dim2 := DefaultDim."Dimension Value Code";

            Clear(DefaultDim);
            DefaultDim.SetRange("Table ID", DATABASE::Customer);
            DefaultDim.SetRange("No.", Rec."No.");
            DefaultDim.SetRange("Dimension Code", 'CHANNEL');
            if DefaultDim.FindFirst() then
                Dim3 := DefaultDim."Dimension Value Code";

            CustomerHierarchy.Reset();
            CustomerHierarchy.SetRange("Customer No.", Rec."No.");
            if CustomerHierarchy.FindFirst() then
                CustomerHierarchy.Delete();

            if (Dim1 <> '') and (Dim2 <> '') and (Dim3 <> '') then begin
                CustomerHierarchy."Dimension Level 1 Code" := GLSetup."Business Type Dim Code FND";
                CustomerHierarchy."Dimension Level 1 Value Code" := Dim1;
                CustomerHierarchy."Dimension Level 2 Code" := 'SERVICE ZONE';
                CustomerHierarchy."Dimension Level 2 Value Code" := Dim2;
                CustomerHierarchy."Dimension Level 3 Code" := 'CHANNEL';
                CustomerHierarchy."Dimension Level 3 Value Code" := Dim3;
                CustomerHierarchy."Customer No." := Rec."No.";
                if CustomerHierarchy.Insert() then;
            end;
        end;
        //HEI.23<<

        //HEI.32>>
        if Rec."Table ID" = DATABASE::"Fixed Asset" then begin
            if Rec."Dimension Value Code" = xRec."Dimension Value Code" then
                exit;
            if (Rec."Dimension Code" = GLSetup."CMG Dimension Code FND") then
                if DefaultDim.Get(DATABASE::"Fixed Asset", Rec."No.", GLSetup."CMG Dimension Code FND") then
                    if FixedAsset.Get(Rec."No.") then begin
                        FixedAsset."CMG code FND" := Rec."Dimension Value Code";
                        FixedAsset.Modify();
                    end;
        end;
        //HEI.32<<
    end;
    //BC Upgrade SHARMP16 CAD BEGIN<<
    [EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchHeaderRecalcCAD(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        VATPostingSetup: Record "VAT Posting Setup";
        NewCADAmount: Decimal;
    begin
        //HEI.51 >> Recompute CAD Amount after Release so UpdateVATOnLines cannot leave it blank
        if PurchaseHeader.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if PurchaseHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(PurchaseHeader."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter("VAT %", '<>%1', 0);
        if PurchaseLine.FindSet(true) then
            repeat
                if VATPostingSetup.Get(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group") and
                   (VATPostingSetup."CAD % FND" <> 0) and (PurchaseLine.Quantity <> 0)
                then begin
                    NewCADAmount := Round((VATPostingSetup."CAD % FND" / 100) * ((PurchaseLine."VAT %" / 100) * PurchaseLine."VAT Base Amount"), Currency."Amount Rounding Precision");
                    if PurchaseLine."CAD Amount FND" <> NewCADAmount then begin
                        PurchaseLine."CAD Amount FND" := NewCADAmount;
                        PurchaseLine.Modify();
                        LinesWereModified := true;
                    end;
                end;
            until PurchaseLine.Next() = 0;
        //HEI.51 <<
    end;//BC Upgrade SHARMP16 CAD END>>

    [EventSubscriber(ObjectType::Table, 352, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteT352(var Rec: Record "Default Dimension"; RunTrigger: Boolean);
    var

        BrandDimHier: Record "Brand Dim Hierarchy FND";
        // CustomerHierarchy: Record "Customer Hierarchy";

        // BrandDimHier: Record "Brand Dim Hierarchy";
        CustomerHierarchy: Record "Customer Hierarchy FND";

        DefaultDim: Record "Default Dimension";
        FixedAsset: Record "Fixed Asset";

    begin
        //HEI.23<<
        GLSetup.Get();
        if Rec."Table ID" = DATABASE::Customer then begin
            if Rec."Dimension Code" in [GLSetup."Business Type Dim Code FND", 'SERVICE ZONE', 'CHANNEL'] then begin
                CustomerHierarchy.Reset();
                CustomerHierarchy.SetRange("Customer No.", Rec."No.");
                if CustomerHierarchy.FindFirst() then
                    CustomerHierarchy.Delete();
            end;
        end else if Rec."Table ID" = DATABASE::Item then
                if Rec."Dimension Code" in [GLSetup."Brand Dimension Code FND", GLSetup."Line ext Dimension Code FND", GLSetup."Primary Pack Type Dim FND"] then begin
                    BrandDimHier.Reset();
                    BrandDimHier.SetRange("Item No.", Rec."No.");
                    if BrandDimHier.FindFirst() then
                        BrandDimHier.Delete();
                end;
        //HEI.23<<

        //HEI.32>>
        if Rec."Table ID" = DATABASE::"Fixed Asset" then
            if (Rec."Dimension Code" = GLSetup."CMG Dimension Code FND") then
                if DefaultDim.Get(DATABASE::"Fixed Asset", Rec."No.", GLSetup."CMG Dimension Code FND") then begin
                    if FixedAsset.Get(Rec."No.") then begin
                        FixedAsset."CMG code FND" := Rec."Dimension Value Code";
                        FixedAsset.Modify();
                    end;
                end else
                    if FixedAsset.Get(Rec."No.") then begin
                        FixedAsset."CMG code FND" := '';
                        FixedAsset.Modify();
                    end;
        //HEI.32<<
    end;

    [EventSubscriber(ObjectType::Table, 352, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertT352(var Rec: Record "Default Dimension"; RunTrigger: Boolean);
    var

        BrandDimHier: Record "Brand Dim Hierarchy FND";
        // CustomerHierarchy: Record "Customer Hierarchy";

        // BrandDimHier: Record "Brand Dim Hierarchy";
        CustomerHierarchy: Record "Customer Hierarchy FND";

        DefaultDim: Record "Default Dimension";
        FixedAsset: Record "Fixed Asset";
        Dim1: Code[20];
        Dim2: Code[20];
        Dim3: Code[20];

    begin
        //HEI.23<<
        GLSetup.Get();

        //update Customer DIm Hierarchy
        if Rec."Table ID" = DATABASE::Customer then
            if Rec."Dimension Code" in [GLSetup."Business Type Dim Code FND", 'SERVICE ZONE', 'CHANNEL'] then begin
                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Customer);
                DefaultDim.SetRange("No.", Rec."No.");
                DefaultDim.SetRange("Dimension Code", GLSetup."Business Type Dim Code FND");
                if DefaultDim.FindFirst() then
                    Dim1 := DefaultDim."Dimension Value Code";

                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Customer);
                DefaultDim.SetRange("No.", Rec."No.");
                DefaultDim.SetRange("Dimension Code", 'SERVICE ZONE');
                if DefaultDim.FindFirst() then
                    Dim2 := DefaultDim."Dimension Value Code";

                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Customer);
                DefaultDim.SetRange("No.", Rec."No.");
                DefaultDim.SetRange("Dimension Code", 'CHANNEL');
                if DefaultDim.FindFirst() then
                    Dim3 := DefaultDim."Dimension Value Code";

                if (Dim1 <> '') and (Dim2 <> '') and (Dim3 <> '') then begin
                    CustomerHierarchy."Dimension Level 1 Code" := GLSetup."Business Type Dim Code FND";
                    CustomerHierarchy."Dimension Level 1 Value Code" := Dim1;
                    CustomerHierarchy."Dimension Level 2 Code" := 'SERVICE ZONE';
                    CustomerHierarchy."Dimension Level 2 Value Code" := Dim2;
                    CustomerHierarchy."Dimension Level 3 Code" := 'CHANNEL';
                    CustomerHierarchy."Dimension Level 3 Value Code" := Dim3;
                    CustomerHierarchy."Customer No." := Rec."No.";
                    if CustomerHierarchy.Insert() then;
                end;
            end;

        if Rec."Table ID" = DATABASE::Item then
            if Rec."Dimension Code" in [GLSetup."Brand Dimension Code FND", GLSetup."Line ext Dimension Code FND", GLSetup."Primary Pack Type Dim FND"] then begin
                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Item);
                DefaultDim.SetRange("No.", Rec."No.");
                DefaultDim.SetRange("Dimension Code", GLSetup."Brand Dimension Code FND");
                if DefaultDim.FindFirst() then
                    Dim1 := DefaultDim."Dimension Value Code";

                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Item);
                DefaultDim.SetRange("No.", Rec."No.");
                DefaultDim.SetRange("Dimension Code", GLSetup."Line ext Dimension Code FND");
                if DefaultDim.FindFirst() then
                    Dim2 := DefaultDim."Dimension Value Code";

                Clear(DefaultDim);
                DefaultDim.SetRange("Table ID", DATABASE::Item);
                DefaultDim.SetRange("No.", Rec."No.");
                DefaultDim.SetRange("Dimension Code", GLSetup."Primary Pack Type Dim FND");
                if DefaultDim.FindFirst() then
                    Dim3 := DefaultDim."Dimension Value Code";

                if (Dim1 <> '') and (Dim2 <> '') and (Dim3 <> '') then begin
                    Clear(BrandDimHier);
                    BrandDimHier."Dimension Level 1 Code" := GLSetup."Brand Dimension Code FND";
                    BrandDimHier."Dimension Level 1 Value Code" := Dim1;
                    BrandDimHier."Dimension Level 2 Code" := GLSetup."Line ext Dimension Code FND";
                    BrandDimHier."Dimension Level 2 Value Code" := Dim2;
                    BrandDimHier."Dimension Level 3 Code" := GLSetup."Primary Pack Type Dim FND";
                    BrandDimHier."Dimension Level 3 Value Code" := Dim3;
                    BrandDimHier."Item No." := Rec."No.";
                    if BrandDimHier.Insert() then;
                end;
            end;
        //HEI.23<<

        //HEI.32>>
        if Rec."Table ID" = DATABASE::"Fixed Asset" then
            if (Rec."Dimension Code" = GLSetup."CMG Dimension Code FND") then
                if DefaultDim.Get(DATABASE::"Fixed Asset", Rec."No.", GLSetup."CMG Dimension Code FND") then begin
                    if FixedAsset.Get(Rec."No.") then begin
                        if (FixedAsset."CMG code FND" <> '') then
                            exit
                        else if (Rec."Dimension Value Code" <> '') then begin
                            FixedAsset."CMG code FND" := Rec."Dimension Value Code";
                            FixedAsset.Modify();
                        end;
                    end;
                end;
        //HEI.32<<  // BC Upgrade NANDIS03 - Blocked only to compile
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnApproveApprovalRequest', '', false, false)]
    local procedure OnApproveApprovalRequestPaymentJournal(var ApprovalEntry: Record "Approval Entry");
    var
        Rec_CheckLE: Record "Check Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine_1: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        WorkflowRule: Record "Workflow Rule";
        CheckManagement: Codeunit CheckManagement;
        RecID: RecordID;
        RecRef: RecordRef;
        DocumentNo: FieldRef;
        EntryNo: FieldRef;
        JBatchName: FieldRef;
        JTemplateName: FieldRef;
        LineNo: FieldRef;
        VendNo: FieldRef;
        Modified: Boolean;
        Test: Boolean;
        DocumentNoInt: Integer;
        LineNo1: Integer;
    begin
        //HEI.20
        RecID := ApprovalEntry."Record ID to Approve";
        if RecID.TableNo = DATABASE::"Gen. Journal Line" then begin
            RecRef := RecID.GetRecord();
            JTemplateName := RecRef.Field(1);
            JBatchName := RecRef.Field(51);
            LineNo := RecRef.Field(2);
            Test := Evaluate(LineNo1, Format(LineNo));
            GenJournalLine.SetRange("Journal Batch Name", Format(JBatchName));
            GenJournalLine.SetRange("Journal Template Name", Format(JTemplateName));
            GenJournalLine.SetRange("Line No.", LineNo1);
            if GenJournalLine.FindFirst() then begin
                CheckManagement.VoidCheck(GenJournalLine);
                //GenJournalLine."Check Printed" := FALSE;
                //GenJournalLine."HNK Check No." := '';
                //GenJournalLine.Modify;
            end;
            GenJournalLine_1.Reset();
            GenJournalLine_1.SetRange("Journal Batch Name", FORMAT(JBatchName));
            GenJournalLine_1.SetRange("Journal Template Name", FORMAT(JTemplateName));
            GenJournalLine_1.SetRange("Line No.", LineNo1);
            if GenJournalLine_1.FindFirst() then begin
                GenJournalLine_1."Check Printed" := false;
                GenJournalLine_1."HNK Check No. FND" := '';
                GenJournalLine_1.Modify();
            end;
        end;
        /*
        IF RecID.TABLENO = DATABASE::"Check Ledger Entry" THEN BEGIN
              RecRef := RecID.GetRECORD;
              EntryNo := RecRef.FIELD(1);
              Test := EVALUATE(DocumentNoInt,FORMAT(EntryNo));
              Rec_CheckLE.Reset;
              Rec_CheckLE.SetRange("Entry No.",DocumentNoInt);
              IF Rec_CheckLE.FindFirst() THEN BEGIN
                 COMMIT;
                 //CheckManagement.FinancialVoidCheck(Rec_CheckLE);
               end;

   
          end;*/
        //HEI.20

    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequestcheckledgerentry(var ApprovalEntry: Record "Approval Entry");
    var
        Rec_CheckLE: Record "Check Ledger Entry";
        RecID: RecordID;
        RecRef: RecordRef;
        EntryNo: FieldRef;
        Test: Boolean;
        DocumentNoInt: Integer;
    begin
        //HEI.20
        RecID := ApprovalEntry."Record ID to Approve";
        if RecID.TableNo = DATABASE::"Check Ledger Entry" then begin
            RecRef := RecID.GetRecord();
            EntryNo := RecRef.Field(1);
            Test := Evaluate(DocumentNoInt, Format(EntryNo));
            Rec_CheckLE.Reset();
            Rec_CheckLE.SetRange("Entry No.", DocumentNoInt);
            if Rec_CheckLE.FindFirst() then begin
                Rec_CheckLE."Approval Status FND" := Rec_CheckLE."Approval Status FND"::Rejected;
                Rec_CheckLE.Modify(true);
            end;

        end;
        //HEI.20
    end;

    [EventSubscriber(ObjectType::Table, 254, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertVATEntry(var Rec: Record "VAT Entry"; RunTrigger: Boolean);
    var
        PurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
        PurchInvHeaderAdditional: Record "Purch. Inv. Header Add FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //HEI.30>>
        if Rec.IsTemporary then
            exit;

        SalesReceivablesSetup.Get();
        PurchasesPayablesSetup.Get(); //HEI.31

        //Insert Location Code
        if SalesReceivablesSetup."Mandatory Loc. on Header FND" then begin
            if SalesInvoiceHeader.Get(Rec."Document No.") then begin
                Rec."Location Code FND" := SalesInvoiceHeader."Location Code";
                Rec.Modify();
            end;

            if SalesCrMemoHeader.Get(Rec."Document No.") then begin
                Rec."Location Code FND" := SalesCrMemoHeader."Location Code";
                Rec.Modify();
            end;
        end;

        //HEI.31>>
        if PurchasesPayablesSetup."Mandatory Region on Header FND" then begin
            if PurchInvHeaderAdditional.Get(Rec."Document No.") then begin
                Rec."Region Code FND" := PurchInvHeaderAdditional."Region Code";
                Rec.Modify();
            end;

            if PurchCrMemoHdrAddition.Get(Rec."Document No.") then begin
                Rec."Region Code FND" := PurchCrMemoHdrAddition."Region Code";
                Rec.Modify();
            end;
        end;
        //     //HEI.31<<
        //     //HEI.30<<
    end;

    procedure InsertSalesCADEntry(VATEntry: Record "VAT Entry"; CADAmount: Decimal);
    var
        CADEntry: Record "CAD Entry FND";
        CADEntry2: Record "CAD Entry FND";
        GeneralLedgerSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        NextEntryNo: Integer;
    begin
        //HEI.30>>
        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not VATPostingSetup.Get(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group") then
            exit;

        if VATPostingSetup."CAD % FND" = 0 then
            exit;

        //CAD Entry No.
        if CADEntry2.FindLast() then
            NextEntryNo := CADEntry2."Entry No." + 1
        else
            NextEntryNo := 1;

        //Type = Sale
        if VATEntry.Type = VATEntry.Type::Sale then begin
            if VATPostingSetup."Sales CAD Account FND" = '' then
                exit;


            CADEntry.Init();
            CADEntry."Entry No." := NextEntryNo;
            CADEntry."Posting Date" := VATEntry."Posting Date";
            CADEntry."Document Type" := VATEntry."Document Type";
            CADEntry."Document No." := VATEntry."Document No.";
            CADEntry.Type := VATEntry.Type;
            CADEntry."Sell-to / Buy-from No." := VATEntry."Bill-to/Pay-to No.";
            CADEntry."VAT Bus. Posting Group" := VATEntry."VAT Bus. Posting Group";
            CADEntry."VAT Prod. Posting Group" := VATEntry."VAT Prod. Posting Group";
            CADEntry."External Document No." := VATEntry."External Document No.";
            CADEntry."Source Code" := VATEntry."Source Code";
            CADEntry."Reason Code" := VATEntry."Reason Code";
            CADEntry."Transaction No." := VATEntry."Transaction No.";
            CADEntry."Location Code" := VATEntry."Location Code FND";

            CADEntry."CAD %" := VATPostingSetup."CAD % FND";
            CADEntry."Account No." := VATPostingSetup."Sales CAD Account FND";
            CADEntry."User ID" := UserId;

            //Base = VAT Amount
            CADEntry.Base := VATEntry.Amount;

            //Amount Exc. VAT
            CADEntry."Amount Excl. VAT" := VATEntry.Base;

            //CAD Amount
            if VATEntry.Amount <> 0 then
                CADEntry."CAD Amount" := CADAmount;

            //Amount Incl. CAD = Amount Incl. VAT + CAD
            CADEntry."Amount Including CAD" := VATEntry.Base + VATEntry.Amount + CADEntry."CAD Amount";

            CADEntry.Insert();
        end;
        //HEI.30<<
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure OnAfterValidateSalesLineQuantity(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        VATPostingSetup: Record "VAT Posting Setup";
        VATPostingSetup2: Record "VAT Posting Setup";
    begin
        //HEI.30>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            exit;

        if (VATPostingSetup."CAD % FND" = 0) or (VATPostingSetup."Sales CAD Account FND" = '') then
            exit;

        if Rec.Quantity = 0 then
            Rec."CAD Amount FND" := 0;

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        // BC Upgrade POENAB02 >>
        //below code is commented due to the fact that is calling SalesLine."Free Item",
        //a field that is belonging to Aptean extension. In HeiLite the field was having
        //ID 2013826
        /* if Rec."VAT %" <> 0 then begin
            if Rec."Free Item" //AND Rec."Allow VAT Calculation (Free)"
            then begin
                if Rec."VAT Base Amount" <> 0 then
                    Rec."CAD Amount FND" := Round(Rec."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                else
                    Rec."CAD Amount FND" := Round((Rec."Unit Price" * Rec.Quantity * Rec."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
            end else begin
                Rec."Amount Including VAT" := Round(Rec.Amount + Rec."VAT Base Amount" * Rec."VAT %" / 100, Currency."Amount Rounding Precision");
                Rec."CAD Amount FND" := Round((Rec."Amount Including VAT" - Rec."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                Rec."Amount Including VAT" := Rec."Amount Including VAT" + Rec."CAD Amount FND";
            end;
            Rec.Validate("Outstanding Amount", Rec."Amount Including VAT");

            if Rec.Type = Rec.Type::Item then begin
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."Document No.");
                SalesLine.SetRange("Attached to Line No.", Rec."Line No.");
                SalesLine.SetFilter("VAT %", '<>%1', 0);
                if SalesLine.FindSet(true) then
                    repeat
                        if not VATPostingSetup2.Get(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") then
                            exit;

                        if (VATPostingSetup2."CAD %" = 0) or (VATPostingSetup2."Sales CAD Account" = '') then
                            exit;

                        if SalesLine.Quantity = 0 then
                            SalesLine."CAD Amount FND" := 0
                        else begin
                            if SalesLine."Free Item" //AND SalesLine."Allow VAT Calculation (Free)"
                            then begin
                                if SalesLine."VAT Base Amount" <> 0 then
                                    SalesLine."CAD Amount FND" := Round(SalesLine."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                                else
                                    SalesLine."CAD Amount FND" := Round((SalesLine."Unit Price" * SalesLine.Quantity * SalesLine."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                            end else begin
                                SalesLine."Amount Including VAT" := Round(SalesLine.Amount + SalesLine."VAT Base Amount" * SalesLine."VAT %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."CAD Amount FND" := Round((SalesLine."Amount Including VAT" - SalesLine."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."Amount Including VAT" := SalesLine."Amount Including VAT" + SalesLine."CAD Amount FND";
                            end;
                            SalesLine.Validate("Outstanding Amount", SalesLine."Amount Including VAT");
                        end;
                        SalesLine.Modify();
                    until SalesLine.Next() = 0;
            end;
        end; */
        // BC Upgrade POENAB02 <<
        //HEI.30<<
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Unit of Measure Code', false, false)]
    local procedure OnAfterValidateSalesLineUoM(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        VATPostingSetup: Record "VAT Posting Setup";
        VATPostingSetup2: Record "VAT Posting Setup";
    begin
        //HEI.30>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            exit;

        if (VATPostingSetup."CAD % FND" = 0) or (VATPostingSetup."Sales CAD Account FND" = '') then
            exit;

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        // BC Upgrade POENAB02 >>
        //below code is commented due to the fact that is calling SalesLine."Free Item",
        //a field that is belonging to Aptean extension. In HeiLite the field was having
        //ID 2013826
        /* if ((xRec."Amount Including VAT" - xRec.Amount) <> (Rec."Amount Including VAT" - Rec.Amount)) and
          (Rec."Amount Including VAT" - Rec.Amount <> 0)
        then begin
            if Rec."Free Item" //AND Rec."Allow VAT Calculation (Free)"
            then begin
                if Rec."VAT Base Amount" <> 0 then
                    Rec."CAD Amount FND" := Round(Rec."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                else
                    Rec."CAD Amount FND" := Round((Rec."Unit Price" * Rec.Quantity * Rec."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
            end else begin
                Rec."Amount Including VAT" := Round(Rec.Amount + Rec."VAT Base Amount" * Rec."VAT %" / 100, Currency."Amount Rounding Precision");
                Rec."CAD Amount FND" := Round((Rec."Amount Including VAT" - Rec."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                Rec."Amount Including VAT" := Rec."Amount Including VAT" + Rec."CAD Amount FND";
            end;
            Rec.Validate("Outstanding Amount", Rec."Amount Including VAT");

            if Rec.Type = Rec.Type::Item then begin
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."Document No.");
                SalesLine.SetRange("Attached to Line No.", Rec."Line No.");
                SalesLine.SetFilter("VAT %", '<>%1', 0);
                if SalesLine.FindSet(true) then
                    repeat
                        if not VATPostingSetup2.Get(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") then
                            exit;

                        if (VATPostingSetup2."CAD %" = 0) or (VATPostingSetup2."Sales CAD Account" = '') then
                            exit;

                        if SalesLine.Quantity = 0 then
                            SalesLine."CAD Amount FND" := 0
                        else begin
                            if SalesLine."Free Item" //AND SalesLine."Allow VAT Calculation (Free)"
                            then begin
                                if SalesLine."VAT Base Amount" <> 0 then
                                    SalesLine."CAD Amount FND" := Round(SalesLine."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                                else
                                    SalesLine."CAD Amount FND" := Round((SalesLine."Unit Price" * SalesLine.Quantity * SalesLine."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                            end else begin
                                SalesLine."Amount Including VAT" := Round(SalesLine.Amount + SalesLine."VAT Base Amount" * SalesLine."VAT %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."CAD Amount FND" := Round((SalesLine."Amount Including VAT" - SalesLine."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."Amount Including VAT" := SalesLine."Amount Including VAT" + SalesLine."CAD Amount FND";
                            end;
                            SalesLine.Validate("Outstanding Amount", SalesLine."Amount Including VAT");
                        end;
                        SalesLine.Modify();
                    until SalesLine.Next() = 0;
            end;
        end; */
        // BC Upgrade POENAB02 <<
        //HEI.30<<
    end;

    // BC Upgrade POENAB02 >>
    //below code is commented due to the fact that is calling SalesLine."Free Item",
    //and SalesLine. "Free Reason Code".
    //The fields are belonging to Aptean extension.
    /* [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Free Reason Code', false, false)]
    local procedure OnAfterValidateSalesLineFreeReasonCode(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    var
        VATPostingSetup: Record "VAT Posting Setup";
        VATPostingSetup2: Record "VAT Posting Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        SalesLine: Record "Sales Line";
    begin
        //HEI.30>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD" then
            exit;

        if not VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            exit;

        if (VATPostingSetup."CAD %" = 0) or (VATPostingSetup."Sales CAD Account" = '') then
            exit;

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        if Rec.Quantity = 0 then
            Rec."CAD Amount FND" := 0;

        if Rec."VAT %" <> 0 then begin
            if Rec."Free Item" //AND Rec."Allow VAT Calculation (Free)"
            then begin
                if Rec."VAT Base Amount" <> 0 then
                    Rec."CAD Amount FND" := Round(Rec."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                else
                    Rec."CAD Amount FND" := Round((Rec."Unit Price" * Rec.Quantity * Rec."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
            end else begin
                Rec."Amount Including VAT" := Round(Rec.Amount + Rec."VAT Base Amount" * Rec."VAT %" / 100, Currency."Amount Rounding Precision");
                Rec."CAD Amount FND" := Round((Rec."Amount Including VAT" - Rec."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                Rec."Amount Including VAT" := Rec."Amount Including VAT" + Rec."CAD Amount FND";
            end;
            Rec.Validate("Outstanding Amount", Rec."Amount Including VAT");

            if Rec.Type = Rec.Type::Item then begin
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."Document No.");
                SalesLine.SetRange("Attached to Line No.", Rec."Line No.");
                SalesLine.SetFilter("VAT %", '<>%1', 0);
                if SalesLine.FindSet(true) then
                    repeat
                        if not VATPostingSetup2.Get(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") then
                            exit;

                        if (VATPostingSetup2."CAD %" = 0) or (VATPostingSetup2."Sales CAD Account" = '') then
                            exit;

                        if SalesLine.Quantity = 0 then
                            SalesLine."CAD Amount FND" := 0
                        else begin
                            if SalesLine."Free Item" //AND SalesLine."Allow VAT Calculation (Free)"
                            then begin
                                if SalesLine."VAT Base Amount" <> 0 then
                                    SalesLine."CAD Amount FND" := Round(SalesLine."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                                else
                                    SalesLine."CAD Amount FND" := Round((SalesLine."Unit Price" * SalesLine.Quantity * SalesLine."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                            end else begin
                                SalesLine."Amount Including VAT" := Round(SalesLine.Amount + SalesLine."VAT Base Amount" * SalesLine."VAT %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."CAD Amount FND" := Round((SalesLine."Amount Including VAT" - SalesLine."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."Amount Including VAT" := SalesLine."Amount Including VAT" + SalesLine."CAD Amount FND";
                            end;
                            SalesLine.Validate("Outstanding Amount", SalesLine."Amount Including VAT");
                        end;
                        SalesLine.Modify();
                    until SalesLine.Next() = 0;
            end;
        end;
        //HEI.30<<  
    end; */
    // BC Upgrade POENAB02 <<

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'VAT Prod. Posting Group', false, false)]
    local procedure OnAfterValidateSalesLineVATProdPostGr(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        VATPostingSetup: Record "VAT Posting Setup";
        VATPostingSetup2: Record "VAT Posting Setup";
    begin
        //HEI.30>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            exit;

        if (VATPostingSetup."CAD % FND" = 0) or (VATPostingSetup."Sales CAD Account FND" = '') then begin
            if Rec."CAD Amount FND" <> 0 then
                Rec."CAD Amount FND" := 0;
            exit;
        end;

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
        // BC Upgrade POENAB02 >>
        //below code is commented due to the fact that is calling SalesLine."Free Item"
        //Field is belonging to Aptean extension.
        /* 
                if ((xRec."Amount Including VAT" - xRec.Amount) <> (Rec."Amount Including VAT" - Rec.Amount)) and
                  (Rec."Amount Including VAT" - Rec.Amount <> 0)
                then begin
                    if Rec."Free Item" //AND Rec."Allow VAT Calculation (Free)"
                    then begin
                        if Rec."VAT Base Amount" <> 0 then
                            Rec."CAD Amount FND" := Round(Rec."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                        else
                            Rec."CAD Amount FND" := Round((Rec."Unit Price" * Rec.Quantity * Rec."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                    end else begin
                        Rec."Amount Including VAT" := Round(Rec.Amount + Rec."VAT Base Amount" * Rec."VAT %" / 100, Currency."Amount Rounding Precision");
                        Rec."CAD Amount FND" := Round((Rec."Amount Including VAT" - Rec."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                        Rec."Amount Including VAT" := Rec."Amount Including VAT" + Rec."CAD Amount FND";
                    end;
                    Rec.Validate("Outstanding Amount", Rec."Amount Including VAT");

                    if Rec.Type = Rec.Type::Item then begin
                        SalesLine.SetRange("Document Type", Rec."Document Type");
                        SalesLine.SetRange("Document No.", Rec."Document No.");
                        SalesLine.SetRange("Attached to Line No.", Rec."Line No.");
                        SalesLine.SetFilter("VAT %", '<>%1', 0);
                        if SalesLine.FindSet(true) then
                            repeat
                                if not VATPostingSetup2.Get(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") then
                                    exit;

                                if (VATPostingSetup2."CAD %" = 0) or (VATPostingSetup2."Sales CAD Account" = '') then
                                    exit;

                                if SalesLine.Quantity = 0 then
                                    SalesLine."CAD Amount FND" := 0
                                else begin
                                    if SalesLine."Free Item" //AND SalesLine."Allow VAT Calculation (Free)"
                                    then begin
                                        if SalesLine."VAT Base Amount" <> 0 then
                                            SalesLine."CAD Amount FND" := Round(SalesLine."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                                        else
                                            SalesLine."CAD Amount FND" := Round((SalesLine."Unit Price" * SalesLine.Quantity * SalesLine."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                                    end else begin
                                        SalesLine."Amount Including VAT" := Round(SalesLine.Amount + SalesLine."VAT Base Amount" * SalesLine."VAT %" / 100, Currency."Amount Rounding Precision");
                                        SalesLine."CAD Amount FND" := Round((SalesLine."Amount Including VAT" - SalesLine."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                                        SalesLine."Amount Including VAT" := SalesLine."Amount Including VAT" + SalesLine."CAD Amount FND";
                                    end;
                                    SalesLine.Validate("Outstanding Amount", SalesLine."Amount Including VAT");
                                end;
                                SalesLine.Modify();
                            until SalesLine.Next() = 0;
                    end;
                end;
                */
        // BC Upgrade POENAB02 <<            
        //HEI.30<<
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Unit Price', false, false)]
    local procedure OnAfterValidateSalesLineUnitPrice(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        VATPostingSetup: Record "VAT Posting Setup";
        VATPostingSetup2: Record "VAT Posting Setup";
    begin
        //HEI.30>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            exit;

        if (VATPostingSetup."CAD % FND" = 0) or (VATPostingSetup."Sales CAD Account FND" = '') then
            exit;

        if Rec.Quantity = 0 then
            Rec."CAD Amount FND" := 0;

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        // BC Upgrade POENAB02 >>
        //below code is commented due to the fact that is calling SalesLine."Free Item"
        //Field is belonging to Aptean extension.
        /* 
        if Rec."VAT %" <> 0 then begin
            if Rec."Free Item" //AND Rec."Allow VAT Calculation (Free)"
            then begin
                if Rec."VAT Base Amount" <> 0 then
                    Rec."CAD Amount FND" := Round(Rec."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                else
                    Rec."CAD Amount FND" := Round((Rec."Unit Price" * Rec.Quantity * Rec."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
            end else begin
                Rec."Amount Including VAT" := Round(Rec.Amount + Rec."VAT Base Amount" * Rec."VAT %" / 100, Currency."Amount Rounding Precision");
                Rec."CAD Amount FND" := Round((Rec."Amount Including VAT" - Rec."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                Rec."Amount Including VAT" := Rec."Amount Including VAT" + Rec."CAD Amount FND";
            end;
            Rec.Validate("Outstanding Amount", Rec."Amount Including VAT");

            if Rec.Type = Rec.Type::Item then begin
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."Document No.");
                SalesLine.SetRange("Attached to Line No.", Rec."Line No.");
                SalesLine.SetFilter("VAT %", '<>%1', 0);
                if SalesLine.FindSet(true) then
                    repeat
                        if not VATPostingSetup2.Get(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") then
                            exit;

                        if (VATPostingSetup2."CAD %" = 0) or (VATPostingSetup2."Sales CAD Account" = '') then
                            exit;

                        if SalesLine.Quantity = 0 then
                            SalesLine."CAD Amount FND" := 0
                        else begin
                            if SalesLine."Free Item" //AND SalesLine."Allow VAT Calculation (Free)"
                            then begin
                                if SalesLine."VAT Base Amount" <> 0 then
                                    SalesLine."CAD Amount FND" := Round(SalesLine."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                                else
                                    SalesLine."CAD Amount FND" := Round((SalesLine."Unit Price" * SalesLine.Quantity * SalesLine."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                            end else begin
                                SalesLine."Amount Including VAT" := Round(SalesLine.Amount + SalesLine."VAT Base Amount" * SalesLine."VAT %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."CAD Amount FND" := Round((SalesLine."Amount Including VAT" - SalesLine."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."Amount Including VAT" := SalesLine."Amount Including VAT" + SalesLine."CAD Amount FND";
                            end;
                            SalesLine.Validate("Outstanding Amount", SalesLine."Amount Including VAT");
                        end;

                        SalesLine.Modify();
                    until SalesLine.Next() = 0;
            end;

        end;
        */
        // BC Upgrade POENAB02 <<    
        //HEI.30<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesHeader(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        //HEI.30>>
        if SalesHeader.IsTemporary then
            exit;

        SalesReceivablesSetup.Get();
        if SalesReceivablesSetup."Mandatory Loc. on Header FND" then
            SalesHeader.TestField("Location Code");
        //HEI.30<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesHeader(var SalesHeader: Record "Sales Header");
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        //HEI.30>>
        if SalesHeader.IsTemporary then
            exit;

        SalesReceivablesSetup.Get();
        if SalesReceivablesSetup."Mandatory Loc. on Header FND" then
            SalesHeader.TestField("Location Code");
        //HEI.30<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseSalesHeader(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        //HEI.30>>
        GeneralLedgerSetup.Get();
        if SalesHeader.IsTemporary then
            exit;

        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if SalesHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(SalesHeader."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        // BC Upgrade POENAB02 >>
        //below code is commented due to the fact that is calling SalesLine."Free Item"
        //Field is belonging to Aptean extension.
        /*
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet(true) then
            repeat
                if VATPostingSetup.Get(SalesLine."VAT Bus. Posting Group", SalesLine."VAT Prod. Posting Group") then
                    if (VATPostingSetup."CAD %" <> 0) or (VATPostingSetup."Sales CAD Account" <> '') then
                        if SalesLine."VAT %" <> 0 then begin
                            if SalesLine."Free Item" //AND SalesLine."Allow VAT Calculation (Free)"
                            then begin
                                if SalesLine."VAT Base Amount" <> 0 then
                                    SalesLine."CAD Amount FND" := Round(SalesLine."VAT Base Amount" * VATPostingSetup."VAT %" / 100 * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision")
                                else
                                    SalesLine."CAD Amount FND" := Round((SalesLine."Unit Price" * SalesLine.Quantity * SalesLine."VAT %" / 100) * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                            end else begin
                                SalesLine."Amount Including VAT" := Round(SalesLine.Amount + SalesLine."VAT Base Amount" * SalesLine."VAT %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."CAD Amount FND" := Round((SalesLine."Amount Including VAT" - SalesLine."VAT Base Amount") * VATPostingSetup."CAD %" / 100, Currency."Amount Rounding Precision");
                                SalesLine."Amount Including VAT" := SalesLine."Amount Including VAT" + SalesLine."CAD Amount FND";
                            end;
                            SalesLine.Validate("Outstanding Amount", SalesLine."Amount Including VAT");
                            SalesLine.Modify();
                        end;
            until SalesLine.Next() = 0;
        */
        // BC Upgrade POENAB02 <<
        //HEI.30<<
    end;

    [EventSubscriber(ObjectType::Table, 17, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertGLEntry(var Rec: Record "G/L Entry"; RunTrigger: Boolean);
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        DldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        GLEntryAdditional: Record "G/L Entry Additional FND";
        PurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
        PurchInvHeaderAdditional: Record "Purch. Inv. Header Add FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        VendLedgEntry: Record "Vendor Ledger Entry";
        DCVLedgerEntryNo: Integer;
    begin
        //HEI.30>>
        SalesReceivablesSetup.Get();
        if SalesReceivablesSetup."Mandatory Loc. on Header FND" then begin
            if SalesInvoiceHeader.Get(Rec."Document No.") then begin
                Rec."Location Code FND" := SalesInvoiceHeader."Location Code";
                Rec.Modify();
            end;

            if SalesCrMemoHeader.Get(Rec."Document No.") then begin
                Rec."Location Code FND" := SalesCrMemoHeader."Location Code";
                Rec.Modify();
            end;
        end;
        //HEI.30<<

        //HEI.31>>
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Mandatory Region on Header FND" and (Rec."Region Code FND" = '') then begin
            if PurchInvHeaderAdditional.Get(Rec."Document No.") then begin
                Rec."Region Code FND" := PurchInvHeaderAdditional."Region Code";
                Rec.Modify();
            end;

            if PurchCrMemoHdrAddition.Get(Rec."Document No.") then begin
                Rec."Region Code FND" := PurchCrMemoHdrAddition."Region Code";
                Rec.Modify();
            end;
        end;
        //HEI.31<<

        //HEI.51>>
        if (Rec."CV Detailed Entry No. FND" <> 0) then begin
            GLEntryAdditional.Init();
            ;
            GLEntryAdditional."G/L Entry No." := Rec."Entry No.";
            case Rec."Adj. Exchange Rate Type FND" of
                2: //Customer
                    begin
                        if (DldCustLedgEntry.Get(Rec."CV Detailed Entry No. FND")) then begin
                            GLEntryAdditional."CV No." := DldCustLedgEntry."Customer No.";
                            if CustLedgerEntry.Get(DldCustLedgEntry."Cust. Ledger Entry No.") then
                                GLEntryAdditional."Document No." := CustLedgerEntry."Document No.";
                            if GLEntryAdditional.Insert() then;
                        end else begin
                            if Evaluate(DCVLedgerEntryNo, Rec."Additional Description FND") then begin
                                if CustLedgerEntry.Get(DCVLedgerEntryNo) then begin
                                    GLEntryAdditional."CV No." := CustLedgerEntry."Customer No.";
                                    GLEntryAdditional."Document No." := CustLedgerEntry."Document No.";
                                    if GLEntryAdditional.Insert() then;
                                    Rec."Additional Description FND" := '';//Reset value
                                    Rec.Modify();
                                end;
                            end;
                        end;
                    end;
                3: //Vendor
                    begin
                        if (DldVendLedgEntry.Get(Rec."CV Detailed Entry No. FND")) then begin
                            GLEntryAdditional."CV No." := DldVendLedgEntry."Vendor No.";
                            if VendLedgEntry.Get(DldVendLedgEntry."Vendor Ledger Entry No.") then
                                GLEntryAdditional."Document No." := VendLedgEntry."Document No.";
                            if GLEntryAdditional.Insert() then;
                        end else begin
                            if Evaluate(DCVLedgerEntryNo, Rec."Additional Description FND") then begin
                                if VendLedgEntry.Get(DCVLedgerEntryNo) then begin
                                    GLEntryAdditional."CV No." := VendLedgEntry."Vendor No.";
                                    GLEntryAdditional."Document No." := VendLedgEntry."Document No.";
                                    if GLEntryAdditional.Insert() then;
                                    Rec."Additional Description FND" := '';//Reset value
                                    Rec.Modify();
                                end;
                            end;
                        end;
                    end;
            end;
        end;
        //HEI.51<<
    end;

    [EventSubscriber(ObjectType::Table, 21, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertCLEEntry(var Rec: Record "Cust. Ledger Entry"; RunTrigger: Boolean);
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //HEI.30>>
        SalesReceivablesSetup.Get();
        if SalesReceivablesSetup."Mandatory Loc. on Header FND" then begin
            if SalesInvoiceHeader.Get(Rec."Document No.") then begin
                Rec."Location Code FND" := SalesInvoiceHeader."Location Code";
                Rec.Modify();
            end;

            if SalesCrMemoHeader.Get(Rec."Document No.") then begin
                Rec."Location Code FND" := SalesCrMemoHeader."Location Code";
                Rec.Modify();
            end;
        end;
        //HEI.30<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure OnAfterValidatePurchLineQuantity(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            exit;

        if (VATPostingSetup."CAD % FND" = 0) then
            exit;

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        if Rec.Quantity = 0 then
            Rec."CAD Amount FND" := 0;

        if Rec."VAT %" <> 0 then begin
            Rec."CAD Amount FND" := Round((VATPostingSetup."CAD % FND" / 100) * ((Rec."VAT %" / 100) * Rec."VAT Base Amount"), Currency."Amount Rounding Precision");
            //InsertCADAmountLine(Rec); //HEI.33
            if (CurrFieldNo <> 0) and not Rec.IsTemporary and (Rec."Line No." <> 0) then
                if Rec.Modify() then;   // persist the computed CAD Amount //BC Upgrade SHARMP16 CAD
        end;
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Unit of Measure Code', false, false)]
    local procedure OnAfterValidatePurchLineUoM(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            exit;

        if (VATPostingSetup."CAD % FND" = 0) then
            exit;

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        if ((xRec."Amount Including VAT" - xRec.Amount) <> (Rec."Amount Including VAT" - Rec.Amount)) and
          (Rec."Amount Including VAT" - Rec.Amount <> 0)
        then
            Rec."CAD Amount FND" := Round((VATPostingSetup."CAD % FND" / 100) * ((Rec."VAT %" / 100) * Rec."VAT Base Amount"), Currency."Amount Rounding Precision");
        //InsertCADAmountLine(Rec); //HEI.33
        if (CurrFieldNo <> 0) and not Rec.IsTemporary and (Rec."Line No." <> 0) then
            if Rec.Modify() then;   // persist the computed CAD Amount //BC Upgrade SHARMP16 CAD
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Direct Unit Cost', false, false)]
    local procedure OnAfterValidatePurchLineDirectUnitCost(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            exit;

        if (VATPostingSetup."CAD % FND" = 0) then
            exit;

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        if Rec.Quantity = 0 then
            Rec."CAD Amount FND" := 0;

        if Rec."VAT %" <> 0 then begin
            Rec."CAD Amount FND" := Round((VATPostingSetup."CAD % FND" / 100) * ((Rec."VAT %" / 100) * Rec."VAT Base Amount"), Currency."Amount Rounding Precision");
            //InsertCADAmountLine(Rec); //HEI.33
            if (CurrFieldNo <> 0) and not Rec.IsTemporary and (Rec."Line No." <> 0) then
                if Rec.Modify() then;   // persist the computed CAD Amount //BC Upgrade SHARMP16 CAD
        end;
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'VAT Prod. Posting Group', false, false)]
    local procedure OnAfterValidatePurchLineVATProdPostGr(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then
            exit;

        if (VATPostingSetup."CAD % FND" = 0) then begin
            if Rec."CAD Amount FND" <> 0 then
                Rec."CAD Amount FND" := 0;
            exit;
        end;

        if Rec."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(Rec."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        if ((xRec."Amount Including VAT" - xRec.Amount) <> (Rec."Amount Including VAT" - Rec.Amount)) and
          (Rec."Amount Including VAT" - Rec.Amount <> 0)
        then begin
            Rec."CAD Amount FND" := Round((VATPostingSetup."CAD % FND" / 100) * ((Rec."VAT %" / 100) * Rec."VAT Base Amount"), Currency."Amount Rounding Precision");
            //InsertCADAmountLine(Rec); //HEI.33
            if (CurrFieldNo <> 0) and not Rec.IsTemporary and (Rec."Line No." <> 0) then
                if Rec.Modify() then;   // persist the computed CAD Amount //BC Upgrade SHARMP16 CAD
        end;
        //HEI.31<<
    end;

    procedure OnAfterReleasePurchHeaderBeforePost(var PurchaseHeader: Record "Purchase Header");
    var
        CompanyInformation: Record "Company Information";
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        VATPostingSetup: Record "VAT Posting Setup";
        Vendor: Record Vendor;
    begin
        //HEI.31>>
        if PurchaseHeader.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"]) then
            exit;

        CompanyInformation.Get();
        Vendor.Get(PurchaseHeader."Buy-from Vendor No.");
        if CompanyInformation."Country/Region Code" = Vendor."Country/Region Code" then
            exit;

        if PurchaseHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(PurchaseHeader."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        //PurchaseLine.SetFilter(Type,'%1|%2',PurchaseLine.Type::Item,PurchaseLine.Type::"Charge (Item)");
        PurchaseLine.SetRange(Type, PurchaseLine.Type::"Charge (Item)");
        PurchaseLine.SetFilter("CAD Amount FND", '<>%1', 0);
        if PurchaseLine.FindSet(true) then begin
            repeat
                VATPostingSetup.Get(PurchaseLine."VAT Bus. Posting Group", PurchaseLine."VAT Prod. Posting Group");
                if PurchaseLine."VAT %" <> 0 then begin
                    PurchaseLine.Amount := Round(PurchaseLine.Amount + PurchaseLine."CAD Amount FND", Currency."Amount Rounding Precision");
                    PurchaseLine."Amount Including VAT" := Round(PurchaseLine."Amount Including VAT" + PurchaseLine."CAD Amount FND", Currency."Amount Rounding Precision");
                    PurchaseLine.Validate("Outstanding Amount", PurchaseLine."Amount Including VAT");
                    PurchaseLine.Modify();
                end;
            until PurchaseLine.Next() = 0;

            PurchaseHeader.CalcFields("Amount Including VAT");
        end;
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure OnAfterValidateLocationCodePurch(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        LAmount: Decimal;
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;
        // //HEI.48>>
        // PurchasesPayablesSetup.Get();

        // if PurchasesPayablesSetup."H&S Levy Tax FND" then
        //     if Rec."Document Type" = Rec."Document Type"::Invoice then begin
        //         PurchaseLine.Reset();
        //         PurchaseLine.SetRange("Document No.", Rec."No.");
        //         PurchaseLine.SetFilter("H&S Levy Tax % FND", '<>%1', 0);
        //         PurchaseLine.SetRange("Receipt No.", '');
        //         if PurchaseLine.FindSet(true) then
        //             repeat
        //                 LAmount := PurchaseLine."Total Amount Excl VAT/H&S FND" + PurchaseLine."H&S Levy Tax Amount FND";
        //                 if PurchaseLine."Line Amount" <> LAmount then
        //                     PurchaseLine."Line Amount" := PurchaseLine."Line Amount" + PurchaseLine."H&S Levy Tax Amount FND";
        //                 PurchaseLine.Modify();
        //             until PurchaseLine.Next() = 0;
        //     end;
        // //HEI.48<<//Bc Upgrade YADAVM09 code added in Heineken Custom codeunit<<
        PurchasesPayablesSetup.Get();
        if not PurchasesPayablesSetup."Mandatory Region on Header FND" then
            exit;

        if PurchaseHeaderAdditional.Get(Rec."Document Type", Rec."No.") then begin
            PurchaseHeaderAdditional."Region Code" := Rec."Location Code";
            PurchaseHeaderAdditional.Modify();
        end;
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertSRMPurchLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;

        PurchasesPayablesSetup.Get();
        if not PurchasesPayablesSetup."Mandatory Region on Header FND" then
            exit;

        PurchaseHeader.Get(Rec."Document Type", Rec."Document No.");
        if PurchaseHeader."SRM Order No. FND" <> '' then
            if PurchaseHeaderAdditional.Get(Rec."Document Type", Rec."Document No.") then begin
                PurchaseHeaderAdditional."Region Code" := Rec."Location Code";
                PurchaseHeaderAdditional.Modify();
            end;
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure OnAfterValidateLocationCodeSRMPurch(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;

        PurchasesPayablesSetup.Get();
        if not PurchasesPayablesSetup."Mandatory Region on Header FND" then
            exit;

        PurchaseHeader.Get(Rec."Document Type", Rec."Document No.");
        if PurchaseHeader."SRM Order No. FND" <> '' then
            if PurchaseHeaderAdditional.Get(Rec."Document Type", Rec."Document No.") then begin
                PurchaseHeaderAdditional."Region Code" := Rec."Location Code";
                PurchaseHeaderAdditional.Modify();
            end;
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure OnBeforeReleasePurchaseHeader(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.31>>
        if PurchaseHeader.IsTemporary then
            exit;

        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Mandatory Region on Header FND" then
            if PurchaseHeaderAdditional.Get(PurchaseHeader."Document Type", PurchaseHeader."No.") then
                PurchaseHeaderAdditional.TestField("Region Code");
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseHeader(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.31>>
        if PurchaseHeader.IsTemporary then
            exit;

        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Mandatory Region on Header FND" then
            if PurchaseHeaderAdditional.Get(PurchaseHeader."Document Type", PurchaseHeader."No.") then
                PurchaseHeaderAdditional.TestField("Region Code");
        //HEI.31<<
    end;

    procedure CreateCADVarianceValueEntry(PurchaseHeader: Record "Purchase Header"; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]);
    var
        CompanyInfo: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Item: Record Item;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        ValueEntry: Record "Value Entry";
        Vendor: Record Vendor;
        IsForeignVendor: Boolean;
        LastValueEntryNo: Integer;
    begin
        //HEI.31>>
        if PurchaseHeader.IsTemporary then
            exit;

        CompanyInfo.Get();
        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if ValueEntry.FindLast() then
            LastValueEntryNo := ValueEntry."Entry No.";

        if PurchInvHdrNo <> '' then begin
            PurchInvHeader.Get(PurchInvHdrNo);
            Vendor.Get(PurchInvHeader."Buy-from Vendor No.");
            IsForeignVendor := CompanyInfo."Country/Region Code" <> Vendor."Country/Region Code";
            PurchInvLine.SetRange("Document No.", PurchInvHdrNo);
            PurchInvLine.SetFilter("CAD Amount FND", '<>%1', 0);
            if IsForeignVendor then
                PurchInvLine.SetRange(Type, PurchInvLine.Type::Item)
            else
                PurchInvLine.SetFilter(Type, '%1|%2', PurchInvLine.Type::Item, PurchInvLine.Type::"Charge (Item)");
            if PurchInvLine.FindSet() then
                repeat
                    if Item.Get(PurchInvLine."No.") then;
                    if not Item."Inventory Value Zero" then begin
                        LastValueEntryNo += 1;
                        InsertCADValueEntry(LastValueEntryNo,
                                            PurchInvHeader."Posting Date",
                                            PurchInvHeader."Document Date",
                                            PurchInvHdrNo,
                                            PurchInvHeader."Vendor Invoice No.",
                                            PurchInvHeader."Buy-from Vendor No.",
                                            PurchInvLine."Location Code",
                                            PurchInvLine."Dimension Set ID",
                                            PurchInvLine."Gen. Bus. Posting Group",
                                            PurchInvLine."Gen. Prod. Posting Group",
                                            PurchInvLine."Line No.",
                                            PurchInvLine.Type,
                                            PurchInvLine."No.",
                                            -PurchInvLine."CAD Amount FND",
                                            PurchInvLine.Quantity);
                    end;
                until PurchInvLine.Next() = 0;
        end;

        if PurchCrMemoHdrNo <> '' then begin
            PurchCrMemoHdr.Get(PurchCrMemoHdrNo);
            Vendor.Get(PurchCrMemoHdr."Buy-from Vendor No.");
            IsForeignVendor := CompanyInfo."Country/Region Code" <> Vendor."Country/Region Code";
            PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdrNo);
            PurchCrMemoLine.SetFilter("CAD Amount FND", '<>%1', 0);
            if IsForeignVendor then
                PurchCrMemoLine.SetRange(Type, PurchCrMemoLine.Type::Item)
            else
                PurchCrMemoLine.SetFilter(Type, '%1|%2', PurchCrMemoLine.Type::Item, PurchCrMemoLine.Type::"Charge (Item)");
            if PurchCrMemoLine.FindSet(false) then
                repeat
                    if Item.Get(PurchInvLine."No.") then;
                    if not Item."Inventory Value Zero" then begin
                        LastValueEntryNo += 1;
                        InsertCADValueEntry(LastValueEntryNo,
                                            PurchCrMemoHdr."Posting Date",
                                            PurchCrMemoHdr."Document Date",
                                            PurchCrMemoHdrNo,
                                            PurchCrMemoHdr."Vendor Cr. Memo No.",
                                            PurchCrMemoHdr."Buy-from Vendor No.",
                                            PurchCrMemoLine."Location Code",
                                            PurchCrMemoLine."Dimension Set ID",
                                            PurchCrMemoLine."Gen. Bus. Posting Group",
                                            PurchCrMemoLine."Gen. Prod. Posting Group",
                                            PurchCrMemoLine."Line No.",
                                            PurchCrMemoLine.Type,
                                            PurchCrMemoLine."No.",
                                            -PurchCrMemoLine."CAD Amount FND",
                                            -PurchCrMemoLine.Quantity);
                    end;
                until PurchCrMemoLine.Next() = 0;
        end;
        //HEI.31<<
    end;

    // BC UPGRADE PATELS08 >> # Changed Data Type of AccType parameter to Enum Purchase Line Type from Option
    // local procedure InsertCADValueEntry(EntryNo: Integer; PostingDate: Date; DocDate: Date; DocumentNo: Code[20]; ExternalDocNo: Code[20]; VendorNo: Code[20]; LocationCode: Code[10]; DimensionSetID: Integer; GenBusPostGr: Code[10]; GenProdPostGr: Code[10]; LineNo: Integer; AccType: Option " ","G/L Account",Item,,"Fixed Asset","Charge (Item)"; ItemNo: Code[20]; CADAmount: Decimal; ValuedQty: Decimal);
    local procedure InsertCADValueEntry(EntryNo: Integer; PostingDate: Date; DocDate: Date; DocumentNo: Code[20]; ExternalDocNo: Code[20]; VendorNo: Code[20]; LocationCode: Code[10]; DimensionSetID: Integer; GenBusPostGr: Code[10]; GenProdPostGr: Code[10]; LineNo: Integer; AccType: Enum "Purchase Line Type"; ItemNo: Code[20]; CADAmount: Decimal; ValuedQty: Decimal);
    // BC UPGRADE PATELS08 <<
    var
        Item: Record Item;
        SourceCodeSetup: Record "Source Code Setup";
        ValueEntry: Record "Value Entry";
        ValueEntry2: Record "Value Entry";
        ValueEntry3: Record "Value Entry";
    begin
        //HEI.31<<
        //with ValueEntry do begin
        ValueEntry.Init();
        ValueEntry."Entry No." := EntryNo;
        ValueEntry.Validate("Posting Date", PostingDate);
        ValueEntry.Validate("Document Date", DocDate);
        ValueEntry.Validate("Document No.", DocumentNo);
        ValueEntry.Validate("External Document No.", ExternalDocNo);
        ValueEntry.Validate("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Purchase);
        ValueEntry.Validate("Source Type", ValueEntry."Source Type"::Vendor);
        ValueEntry.Validate("Source No.", VendorNo);
        ValueEntry.Validate("Location Code", LocationCode);
        ValueEntry.Validate("Gen. Bus. Posting Group", GenBusPostGr);
        ValueEntry.Validate("Gen. Prod. Posting Group", GenProdPostGr);
        ValueEntry.Validate("Dimension Set ID", DimensionSetID);
        ValueEntry.Validate("User ID", UserId);
        ValueEntry.Validate("Valuation Date", WorkDate());
        ValueEntry.Validate("Document Line No.", LineNo);
        if ValuedQty > 0 then
            ValueEntry.Validate("Document Type", ValueEntry."Document Type"::"Purchase Invoice")
        else
            ValueEntry.Validate("Document Type", ValueEntry."Document Type"::"Purchase Credit Memo");
        ValueEntry.Validate("Valued Quantity", ValuedQty);
        SourceCodeSetup.Get();
        ValueEntry.Validate("Source Code", SourceCodeSetup.Purchases);
        //Validate("Item Charge Value", ABS(CADAmount));  // BC Upgrade NANDIS03 - Blocked only to compile the codeunit

        if AccType = AccType::Item then begin
            ValueEntry.Validate("Item No.", ItemNo);
            Item.Get(ItemNo);
        end;
        if AccType = AccType::"Charge (Item)" then
            ValueEntry.Validate("Item Charge No.", ItemNo);

        if Item."Costing Method" = Item."Costing Method"::Average then begin
            ValueEntry.Validate("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
            ValueEntry.Validate("Variance Type", ValueEntry."Variance Type"::" ");
            ValueEntry.Validate("Cost Amount (Actual)", ABS(CADAmount));
            ValueEntry.Validate("Cost Posted to G/L", ABS(CADAmount));
            ValueEntry.Validate("Cost per Unit", ABS(CADAmount / ValuedQty));
            ValueEntry.Validate("Purchase Amount (Actual)", ABS(CADAmount));
        end else begin
            ValueEntry.Validate("Entry Type", ValueEntry."Entry Type"::Variance);
            ValueEntry.Validate("Variance Type", ValueEntry."Variance Type"::Purchase);
            ValueEntry.Validate("Cost Amount (Actual)", CADAmount);
            ValueEntry.Validate("Cost Posted to G/L", CADAmount);
            ValueEntry.Validate("Cost per Unit", CADAmount / ValuedQty);
        end;

        //Find Item Ledger Entry No.
        ValueEntry2.SetRange("Document Type", ValueEntry."Document Type");
        ValueEntry2.SetRange("Document No.", DocumentNo);
        if AccType = AccType::Item then
            ValueEntry2.SetRange("Item No.", ItemNo);
        if AccType = AccType::"Charge (Item)" then
            ValueEntry2.SetRange("Item Charge No.", ItemNo);
        if ValueEntry2.FindFirst() then begin
            //"Item Ledger Entry Source Type" := ValueEntry2."Item Ledger Entry Source Type";  // BC Upgrade NANDIS03 - Blocked only to compile the codeunit
            ValueEntry."Item Ledger Entry No." := ValueEntry2."Item Ledger Entry No.";
            ValueEntry."Zone Code FND" := ValueEntry2."Zone Code FND";
            ValueEntry."Bin Code FND" := ValueEntry2."Bin Code FND";
            ValueEntry."Inventory Posting Group" := ValueEntry2."Inventory Posting Group";
            // "Src. Deposit Group Code" := ValueEntry2."Src. Deposit Group Code";
            // "Source Posting Group" := ValueEntry2."Source Posting Group";
            // Inventoriable := ValueEntry2.Inventoriable;
            // "Unit of Measure Code" := ValueEntry2."Unit of Measure Code";
            // "Initial Entry Due Date" := ValueEntry2."Initial Entry Due Date";
            // "Strength Spec. Code" := ValueEntry2."Strength Spec. Code";
            // "Tax Date" := ValueEntry2."Tax Date";
            // "Qty. per Unit of Measure" := ValueEntry2."Qty. per Unit of Measure";
            // "Last Price Calculated Date" := ValueEntry2."Last Price Calculated Date";  // BC Upgrade NANDIS03 - Blocked only to compile the codeunit
        end;

        //Update Value Entry for Direct Cost
        ValueEntry3.Reset();
        ValueEntry3.SetRange("Entry Type", ValueEntry3."Entry Type"::"Direct Cost");
        ValueEntry3.SetRange("Document Type", ValueEntry."Document Type");
        ValueEntry3.SetRange("Document No.", ValueEntry."Document No.");
        if AccType = AccType::Item then
            ValueEntry3.SetRange("Item No.", ItemNo);
        if AccType = AccType::"Charge (Item)" then
            ValueEntry3.SetRange("Item Charge No.", ItemNo);
        if ValueEntry3.FindFirst() then begin
            ValueEntry3."Cost Amount (Actual)" := ValueEntry3."Cost Amount (Actual)" + ABS(CADAmount);
            ValueEntry3."Cost Posted to G/L" := ValueEntry3."Cost Amount (Actual)";
            ValueEntry3."Purchase Amount (Actual)" := ValueEntry3."Cost Amount (Actual)";
            ValueEntry3."Purchase Amount (Expected)" := -ValueEntry3."Cost Amount (Actual)";
            ValueEntry3."Cost per Unit" := ValueEntry3."Cost Amount (Actual)" / ValuedQty;
            ValueEntry3.Modify();
        end;

        ValueEntry.Insert(true);
        //end;
        //HEI.31>>
    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertVLEEntry(var Rec: Record "Vendor Ledger Entry"; RunTrigger: Boolean);
    var
        PurchCrMemoHdrAddition: Record "Purch. Cr. Memo Hdr. Add FND";
        PurchInvHeaderAdditional: Record "Purch. Inv. Header Add FND";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.31>>
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Mandatory Region on Header FND" then begin
            if PurchInvHeaderAdditional.Get(Rec."Document No.") then begin
                Rec."Region Code FND" := PurchInvHeaderAdditional."Region Code";
                Rec.Modify();
            end;

            if PurchCrMemoHdrAddition.Get(Rec."Document No.") then begin
                Rec."Region Code FND" := PurchCrMemoHdrAddition."Region Code";
                Rec.Modify();
            end;
        end;
        //HEI.31<<
    end;

    procedure InsertCADAmountLine(Rec: Record "Purchase Line");
    var
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
        PurchaseLine3: Record "Purchase Line";
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        NextLineNo: Integer;
    begin
        //HEI.31>>
        GeneralLedgerSetup.Get();

        CompanyInformation.Get();
        Vendor.Get(Rec."Buy-from Vendor No.");

        if Rec.Type in [Rec.Type::" ", Rec.Type::"Charge (Item)", Rec.Type::Item] then
            exit;

        if Rec."CAD Amount FND" = 0 then
            exit;

        PurchaseLine2.Reset();
        PurchaseLine2.SetRange("Document Type", Rec."Document Type");
        PurchaseLine2.SetRange("Document No.", Rec."Document No.");
        PurchaseLine2.SetFilter(Type, '<>%1&<>%2', PurchaseLine2.Type::"Charge (Item)", PurchaseLine2.Type::" ");
        if PurchaseLine2.FindLast() then
            NextLineNo := PurchaseLine2."Line No." + 10000
        else
            NextLineNo := 10000;

        if Rec."Line No." = NextLineNo then
            NextLineNo := Rec."Line No." + 10000;

        PurchaseLine3.Reset();
        PurchaseLine3.SetRange("Document Type", Rec."Document Type");
        PurchaseLine3.SetRange("Document No.", Rec."Document No.");
        PurchaseLine3.SetRange("CAD Attached to Line No. FND", Rec."Line No.");
        if PurchaseLine3.FindFirst() then begin
            if PurchaseLine3."Direct Unit Cost" <> Rec."CAD Amount FND" then begin
                PurchaseLine3.Validate("Direct Unit Cost", Rec."CAD Amount FND");
                PurchaseLine3.Modify();
            end;
        end else
            if (not (Rec."Document Type" in [Rec."Document Type"::Invoice, Rec."Document Type"::"Credit Memo"]) and ((Rec."Receipt No." <> '') or (Rec."Return Shipment No." <> ''))) or
               (Rec."Document Type" in [Rec."Document Type"::Order, Rec."Document Type"::"Return Order"]) or
               ((Rec."Document Type" in [Rec."Document Type"::Invoice, Rec."Document Type"::"Credit Memo"]) and ((Rec."Receipt No." = '') and (Rec."Return Shipment No." = '')))
            then begin
                PurchaseLine.Init();
                PurchaseLine.Copy(Rec);
                PurchaseLine."Line No." := NextLineNo;
                PurchaseLine."CAD Attached to Line No. FND" := Rec."Line No.";
                PurchaseLine."CAD Amount FND" := 0;
                //IF PurchaseLine.Type = PurchaseLine.Type::"G/L Account" THEN
                //PurchaseLine."No." := '';

                if Rec.Type = Rec.Type::"G/L Account" then
                    if Vendor."Country/Region Code" <> CompanyInformation."Country/Region Code" then
                        if GeneralLedgerSetup."Enable WHT FND" then
                            if WHTPostingSetup.Get(Rec."WHT Business Posting Group FND", Rec."WHT Product Posting Group FND") and (WHTPostingSetup."WHT %" <> 0) then begin
                                WHTPostingSetup.TestField("CAD Account");
                                PurchaseLine."No." := WHTPostingSetup."CAD Account";
                            end;

                //VendorPostingGroup.Get(Vendor."Vendor Posting Group");
                //IF PurchaseLine."No." = '' THEN
                //PurchaseLine."No." := VendorPostingGroup."CAD Account";

                if StrLen(Rec.Description) + 4 > 50 then
                    PurchaseLine.Description := DelStr(Rec.Description, StrLen(Rec.Description) - 3) + '_CAD'
                else
                    PurchaseLine.Description := Rec.Description + '_CAD';
                PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
                PurchaseLine.Validate(Quantity, 1);
                PurchaseLine.Validate("Direct Unit Cost", Rec."CAD Amount FND");
                PurchaseLine.Insert();
            end;
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeletePurchLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        Vendor: Record Vendor;
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if Rec."CAD Amount FND" = 0 then
            exit;

        CompanyInformation.Get();
        Vendor.Get(Rec."Buy-from Vendor No.");
        if Vendor."Country/Region Code" <> CompanyInformation."Country/Region Code" then
            exit;

        if Rec.Type <> Rec.Type::"G/L Account" then
            exit;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", Rec."Document Type");
        PurchaseLine.SetRange("Document No.", Rec."Document No.");
        PurchaseLine.SetRange("CAD Attached to Line No. FND", Rec."Line No.");
        if PurchaseLine.FindFirst() then
            PurchaseLine.Delete();
        //HEI.31<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeletePurchCADLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        CADLineDeleteErr: Label 'CAD Line cannot be Deleted.';
    begin
        //HEI.31>>
        if Rec.IsTemporary then
            exit;

        GeneralLedgerSetup.Get();
        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if PurchaseLine.Get(Rec."Document Type", Rec."Document No.", Rec."CAD Attached to Line No. FND") then
            if Rec."CAD Attached to Line No. FND" <> 0 then
                Error(CADLineDeleteErr);
        //HEI.31<<
    end;

    procedure UpdatePurchaseHeaderAdditional(PurchaseHeader: Record "Purchase Header");
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseHeaderAdditional2: Record "Purchase Header Additional FND";
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //HEI.31>>
        PurchasesPayablesSetup.Get();
        if not PurchasesPayablesSetup."Mandatory Region on Header FND" then
            exit;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter("Order No.", '<>%1', '');
        if PurchaseLine.FindFirst() then begin
            PurchaseHeaderAdditional2.SetRange("No.", PurchaseLine."Order No.");
            PurchaseHeaderAdditional2.SetFilter("Region Code", '<>%1', '');
            if PurchaseHeaderAdditional2.FindFirst() then
                if PurchaseHeaderAdditional.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
                    PurchaseHeaderAdditional."Region Code" := PurchaseHeaderAdditional2."Region Code";
                    PurchaseHeaderAdditional.Modify();
                end;
        end;
        //HEI.31<<
    end;

    procedure InsertAdditionalCADLine(PurchaseHeader: Record "Purchase Header");
    var
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
        PurchaseLine3: Record "Purchase Line";
        PurchaseLine4: Record "Purchase Line";
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
        WHTPostingSetup: Record "WHT Posting Setup FND";
        NextLineNo: Integer;
    begin
        //HEI.33>>
        GeneralLedgerSetup.Get();
        CompanyInformation.Get();
        Vendor.Get(PurchaseHeader."Buy-from Vendor No.");


        if not GeneralLedgerSetup."Enable CAD FND" then
            exit;

        if not (PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Credit Memo"]) then
            exit;

        PurchaseLine4.Reset();
        PurchaseLine4.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine4.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine4.SetRange("CAD Attached to Line No. FND", 0);
        PurchaseLine4.SetFilter(Type, '%1|%2', PurchaseLine4.Type::"G/L Account", PurchaseLine4.Type::"Fixed Asset");
        //HEI.34>>
        PurchaseLine4.SetFilter("VAT %", '<>%1', 0);
        PurchaseLine4.SetFilter("CAD Amount FND", '<>%1', 0);
        //HEI.34<<
        if PurchaseLine4.FindSet() then
            repeat
                //Setup Next Line No.
                PurchaseLine2.Reset();
                PurchaseLine2.SetRange("Document Type", PurchaseHeader."Document Type");
                PurchaseLine2.SetRange("Document No.", PurchaseHeader."No.");
                PurchaseLine2.SetFilter(Type, '<>%1&<>%2', PurchaseLine2.Type::"Charge (Item)", PurchaseLine2.Type::" ");
                if PurchaseLine2.FindLast() then
                    NextLineNo := PurchaseLine2."Line No." + 10000
                else
                    NextLineNo := 10000;
                if PurchaseLine4."Line No." = NextLineNo then
                    NextLineNo := PurchaseLine4."Line No." + 10000;

                //Insert CAD Line
                PurchaseLine.Init();
                PurchaseLine.Copy(PurchaseLine4);
                PurchaseLine."Line No." := NextLineNo;
                PurchaseLine."CAD Attached to Line No. FND" := PurchaseLine4."Line No.";
                PurchaseLine."CAD Amount FND" := 0;
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then begin
                    PurchaseLine."Receipt No." := '';
                    PurchaseLine."Receipt Line No." := 0;
                end else if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then begin
                    PurchaseLine."Return Shipment No." := '';
                    PurchaseLine."Return Shipment Line No." := 0;
                end;

                if PurchaseLine4.Type = PurchaseLine4.Type::"G/L Account" then
                    if Vendor."Country/Region Code" <> CompanyInformation."Country/Region Code" then
                        if GeneralLedgerSetup."Enable WHT FND" then begin
                            if WHTPostingSetup.Get(PurchaseLine4."WHT Business Posting Group FND", PurchaseLine4."WHT Product Posting Group FND") and
                               (WHTPostingSetup."WHT %" <> 0)
                            then begin
                                WHTPostingSetup.TestField("CAD Account");
                                PurchaseLine."No." := WHTPostingSetup."CAD Account";
                            end;
                        end;

                if StrLen(PurchaseLine4.Description) + 4 > 50 then
                    PurchaseLine.Description := DelStr(PurchaseLine4.Description, StrLen(PurchaseLine4.Description) - 3) + '_CAD'
                else
                    PurchaseLine.Description := PurchaseLine4.Description + '_CAD';
                PurchaseLine.Validate("VAT Prod. Posting Group", 'NO_VAT');
                PurchaseLine.Validate(Quantity, 1);
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then begin
                    PurchaseLine.Validate("Qty. to Receive", 1);
                    PurchaseLine."Quantity Received" := 1;
                end else if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then begin
                    PurchaseLine.Validate("Return Qty. to Ship", 1);
                    PurchaseLine."Return Qty. Shipped" := 1;
                end;
                PurchaseLine.Validate("Direct Unit Cost", PurchaseLine4."CAD Amount FND");
                PurchaseLine.Insert();
            until PurchaseLine4.Next() = 0;
        //HEI.33<<
    end;

    [EventSubscriber(ObjectType::Table, 5600, 'OnAfterValidateEvent', 'CMG code FND', false, false)]
    procedure T5600OnAfterValidateCMGCode(var Rec: Record "Fixed Asset"; var xRec: Record "Fixed Asset"; CurrFieldNo: Integer);
    var
        DefaultDim: Record "Default Dimension";
        DefaultDim1: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
    begin
        //>>HEI.32
        if Rec.IsTemporary then exit;
        GLSetup.Get();
        if Rec."CMG code FND" <> xRec."CMG code FND" then begin
            DefaultDim.Reset();
            DefaultDim.SetRange("Table ID", DATABASE::"Fixed Asset");
            DefaultDim.SetRange("No.", Rec."No.");
            DefaultDim.SetRange("Dimension Code", GLSetup."CMG Dimension Code FND");
            if not DefaultDim.FindFirst() then begin
                DefaultDim.Init();
                DefaultDim.Validate("Table ID", DATABASE::"Fixed Asset");
                DefaultDim.Validate("No.", Rec."No.");
                DefaultDim.Validate("Dimension Code", GLSetup."CMG Dimension Code FND");
                DefaultDim.Validate("Dimension Value Code", Rec."CMG code FND");
                Rec.Modify();
                if DefaultDim.Insert() then;
            end else
                if DefaultDim1.Get(DefaultDim."Table ID", DefaultDim."No.", DefaultDim."Dimension Code") then begin
                    DefaultDim1.Validate("Dimension Value Code", Rec."CMG code FND");
                    DefaultDim1.Modify();
                end;
            //end else BEGIN//HEI.42
            //IF DefaultDim.Get(DATABASE::"Fixed Asset",Rec."No.",GLSetup."CMG Dimension Code FND") THEN//HEI.42
            //  DefaultDim.Delete;//HEI.42
        end;
        //<<HEI.32
    end;

    procedure InsertDim2SkipDimCheck4SrcCodeWithSkip(var GenJournalLine: Record "Gen. Journal Line"; GLAccNo: Code[20]);
    var
        TempDimension: Record Dimension temporary;
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        SourceCode: Record "Source Code";
        SourceCodeDimension: Record "Source Code Dimension FND";
        DimensionManagement: Codeunit DimensionManagement;
        insertDim: Boolean;
        TableID: Integer;
        TxtSourceCodeDimSetup: Label 'Source Code Dimension Setup for G/L Account %1 Source Code %2 Dimension %3 is missing.';
    begin
        //HEI.37>>
        if SourceCode.Get(GenJournalLine."Source Code") and SourceCode."Skip Dimension Control FND" then
            //HEI.46>>
            if (not
                  ((GLAccNo = GenJournalLine."Account No.") and
                   (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account")) or
                  ((GLAccNo = GenJournalLine."Bal. Account No.") and
                   (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"G/L Account")))
                then begin
                Clear(TempDimension);
                Clear(TempDimSetEntry);
                //HEI.46<<

                TableID := DATABASE::"G/L Account";
                GetDimValuePostingWithMandErr(TableID, GLAccNo, GenJournalLine."Dimension Set ID", TempDimension);
                TempDimension.SetFilter(Code, '<>%1', '');//HEI.46
                if TempDimension.FindSet(false) then begin
                    //HEI.46>>
                    if GenJournalLine."Dimension Set ID" <> 0 then begin
                        DimSetEntry.SetRange("Dimension Set ID", GenJournalLine."Dimension Set ID");
                        if DimSetEntry.FindSet(false) then
                            repeat
                                TempDimSetEntry."Dimension Code" := DimSetEntry."Dimension Code";
                                TempDimSetEntry."Dimension Value Code" := DimSetEntry."Dimension Value Code";
                                TempDimSetEntry."Dimension Value ID" := DimSetEntry."Dimension Value ID";
                                TempDimSetEntry.Insert();
                            until DimSetEntry.Next() = 0;
                    end;
                    //HEI.46<<

                    repeat
                        SourceCodeDimension.SetRange("GL Account No.", GLAccNo);
                        SourceCodeDimension.SetRange("Source Code", GenJournalLine."Source Code");
                        SourceCodeDimension.SetRange("Dimension Code", TempDimension.Code);
                        if SourceCodeDimension.FindFirst() then begin
                            TempDimSetEntry."Dimension Code" := SourceCodeDimension."Dimension Code";
                            TempDimSetEntry."Dimension Value Code" := SourceCodeDimension."Dimension Value Code";
                            TempDimSetEntry."Dimension Value ID" := SourceCodeDimension."Dimension Value ID";
                            if TempDimSetEntry.Insert() then;
                            //HEI.46>>
                            //GenJournalLine."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
                            insertDim := true;
                            //HEI.46<<
                        end else
                            Error(StrSubstNo(TxtSourceCodeDimSetup, GLAccNo, GenJournalLine."Source Code", TempDimension.Code));
                    until TempDimension.Next() = 0;
                    //HEI.46>>
                    if insertDim then
                        GenJournalLine."Dimension Set ID" := DimensionManagement.GetDimensionSetID(TempDimSetEntry);
                end;
            end;
        //HEI.46<<
        //HEI.37<<
    end;

    local procedure GetDimValuePostingWithMandErr(TableID: Integer; No: Code[20]; DimSetID: Integer; var TempDimension: Record Dimension temporary);
    var
        DefaultDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        DimMgt: Codeunit DimensionManagement;
        i: Integer;
        j: Integer;
        NoFilter: array[2] of Text[250];
    begin
        //HEI.37>>
        //DefaultDim.SetFilter("Value Posting",'<>%1',DefaultDim."Value Posting"::" "); HEI.46
        DimSetEntry.Reset();
        DimSetEntry.SetRange("Dimension Set ID", DimSetID);
        DefaultDim.Reset();
        DefaultDim.SetRange("Table ID", TableID);
        DefaultDim.SetRange("No.", No);
        //HEI.46>>
        //IF DefaultDim.FindSet THEN
        DefaultDim.SetFilter("Value Posting", '<>%1', DefaultDim."Value Posting"::" ");
        if DefaultDim.FindSet(false) then
            //HEI.46<<
            repeat
                DimSetEntry.SetRange("Dimension Code", DefaultDim."Dimension Code");
                case DefaultDim."Value Posting" of
                    DefaultDim."Value Posting"::"Code Mandatory":
                        //HEI.46>>
                        //IF NOT DimSetEntry.FindFirst() OR (DimSetEntry."Dimension Value Code" = '') THEN BEGIN
                        if (not DimSetEntry.FindFirst()) or (DimSetEntry."Dimension Value Code" = '') then begin
                            //HEI.46<<
                            TempDimension.Code := DefaultDim."Dimension Code";
                            if TempDimension.Insert() then;
                        end;
                end;
            until DefaultDim.Next() = 0;
        //HEI.37<<
    end;

    procedure GetEBFFilterPattern(var StartPosNoDigits: array[4] of Integer; var FilterOperator: Text);
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
    begin
        //HEI.38>>
        GeneralOpCoSetup.Get();

        //HEI.39>>
        /*
        IF GeneralOpCoSetup."EBF SCOA Range Digit Nos." = 0 THEN
              StartPosNoDigits[1] := 1
            else
              StartPosNoDigits[1] := GeneralOpCoSetup."EBF SCOA Range Digit Nos.";

   
        */
        if GeneralOpCoSetup."EBF SCOA Range Start Position" = 0 then
            StartPosNoDigits[1] := 1
        else
            StartPosNoDigits[1] := GeneralOpCoSetup."EBF SCOA Range Start Position";
        //HEI.39<<

        if GeneralOpCoSetup."EBF SCOA Range Digit Nos." = 0 then
            StartPosNoDigits[2] := 5
        else
            StartPosNoDigits[2] := GeneralOpCoSetup."EBF SCOA Range Digit Nos.";

        if GeneralOpCoSetup."EBF Dim Filter Start Position" = 0 then
            StartPosNoDigits[3] := 3
        else
            StartPosNoDigits[3] := GeneralOpCoSetup."EBF Dim Filter Start Position";

        if GeneralOpCoSetup."EBF Dim Filter Digit Nos." = 0 then
            StartPosNoDigits[4] := 4
        else
            StartPosNoDigits[4] := GeneralOpCoSetup."EBF Dim Filter Digit Nos.";

        if GeneralOpCoSetup."EBF Operator Filter" = '' then
            FilterOperator := '*'
        else
            FilterOperator := GeneralOpCoSetup."EBF Operator Filter";
        //HEI.38<<

    end;

    procedure OnBeforeSendPurchaseOrderApprovalRequest(var PurchaseHeader: Record "Purchase Header");
    var
        DimSetEntry: Record "Dimension Set Entry";
        EbfCombination: Record "Ebf Combination FND";
        PurchasesLine: Record "Purchase Line";
        StartPosNoDigits: array[4] of Integer;
        FilterOperator: Text;
    begin
        //HEI.40>>
        GetEBFFilterPattern(StartPosNoDigits, FilterOperator);

        PurchasesLine.Reset();
        PurchasesLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchasesLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchasesLine.SetRange(Type, PurchasesLine.Type::"G/L Account");
        if PurchasesLine.FindSet(false) then
            repeat
                DimSetEntry.SetRange("Dimension Set ID", PurchasesLine."Dimension Set ID");
                if DimSetEntry.FindSet(false) then
                    repeat
                        Clear(EbfCombination);
                        //HEI.44>>
                        if (PurchasesLine."No." <> '') and (DimSetEntry."Dimension Value Code" <> '') then begin
                            EbfCombination.SetCurrentKey("GL Account No.", "Dimension Code", "Dimension Value Code");
                            if EbfCombination.CheckNewEBFMatrixIsActive() then begin
                                EbfCombination.SetFilter("GL Account No.", CopySTR(PurchasesLine."No.", StartPosNoDigits[1], StartPosNoDigits[2]) + FilterOperator);
                                EbfCombination.SetRange("Dimension Code", DimSetEntry."Dimension Code");
                                EbfCombination.SetFilter("Dimension Value Code", FilterOperator + CopySTR(DimSetEntry."Dimension Value Code", StartPosNoDigits[3], StartPosNoDigits[4]) + FilterOperator);
                            end else begin
                                EbfCombination.SetRange("GL Account No.", PurchasesLine."No.");
                                EbfCombination.SetRange("Dimension Code", DimSetEntry."Dimension Code");
                                EbfCombination.SetRange("Dimension Value Code", DimSetEntry."Dimension Value Code");
                            end;
                            //HEI.44<<
                            if EbfCombination.FindFirst() then begin
                                if EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed" then
                                    Error(Text011, PurchasesLine."No.", DimSetEntry."Dimension Value Code");
                                if GuiAllowed then
                                    if EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Allowed with Warn" then
                                        if not Confirm(StrSubstNo(Text012, PurchasesLine."No.", DimSetEntry."Dimension Value Code")) then
                                            Error('');
                            end;
                        end;
                    until DimSetEntry.Next() = 0;
            until PurchasesLine.Next() = 0;
        //HEI.40<<
    end;

    procedure CheckSkipDimCombForSales(SourceCode: Code[20]; CreatedBySourceCode: Code[10]): Boolean;
    var
        SalesSetup: Record "Sales & Receivables Setup";
        salesHeader: Record "Sales Invoice Header";
        SourceCodeSetup: Record "Source Code Setup";
        SalesEntry: Boolean;
    begin
        //HEI.45
        if salesHeader.Get(SourceCode) then
            SalesEntry := true;
        //HEI.45
        //HEI.41>>
        SalesSetup.Get();
        SourceCodeSetup.Get();
        if ((SourceCodeSetup.Sales = SourceCode) or (SourceCodeSetup.Sales = CreatedBySourceCode) or (SalesEntry = true)) and (SalesSetup."Dim. Comb. Not Appl. FND") then//HEI.45
            exit(true)
        else
            exit(false);
        //HEI.41<<
    end;

    procedure GetItemJnlLine(var ItemJournalLine: Record "Item Journal Line");
    var
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
    begin
        //HEI.47>>
        Clear(ItemJnlLineError);
        Clear(CreateLog);
        if InventorySetupL.Get() then
            if InventorySetupL."Activate Rev.Jnl.Error Log FND" then
                if ItemJnlTemplateL.Get(ItemJournalLine."Journal Template Name") then
                    if ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation then begin
                        ItemJnlLineError.SetRange("Journal Template Name", ItemJournalLine."Journal Template Name");
                        ItemJnlLineError.SetRange("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        ItemJnlLineError.SetRange("Line No.", ItemJournalLine."Line No.");
                        if ItemJnlLineError.FindFirst() then;
                        CreateLog := true;
                    end;
        //HEI.47<<
    end;

    procedure CheckEbfJournalLine(var GenJournalLine: Record "Gen. Journal Line");
    var
        DimSetEntry: Record "Dimension Set Entry";
        EbfCombination: Record "Ebf Combination FND";
        lFADepreciationBook: Record "FA Depreciation Book";
        lFAPostingGroup: Record "FA Posting Group";
        lGLAcc: Code[20];
        StartPosNoDigits: array[4] of Integer;
        FilterOperator: Text;
        ErrorTextL: Text[250];
    begin
        //HEI.53>>
        lGLAcc := '';

        if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account" then
            lGLAcc := GenJournalLine."Account No.";

        if (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Fixed Asset") then begin
            lFADepreciationBook.Reset();
            if lFADepreciationBook.Get(GenJournalLine."Account No.", GenJournalLine."Depreciation Book Code") then
                if lFAPostingGroup.Get(lFADepreciationBook."FA Posting Group") then
                    lGLAcc := lFAPostingGroup."Accum. Depreciation Account";
        end;

        GetEBFFilterPattern(StartPosNoDigits, FilterOperator);

        DimSetEntry.SetRange("Dimension Set ID", GenJournalLine."Dimension Set ID");
        if DimSetEntry.FindSet(false) then
            repeat
                Clear(EbfCombination);

                if (lGLAcc <> '') and (DimSetEntry."Dimension Value Code" <> '') then begin
                    EbfCombination.SetCurrentKey("GL Account No.", "Dimension Code", "Dimension Value Code");

                    if EbfCombination.CheckNewEBFMatrixIsActive() then begin
                        EbfCombination.SetFilter("GL Account No.", CopySTR(lGLAcc, StartPosNoDigits[1], StartPosNoDigits[2]) + FilterOperator);
                        EbfCombination.SetRange("Dimension Code", DimSetEntry."Dimension Code");
                        EbfCombination.SetFilter("Dimension Value Code", FilterOperator + CopySTR(DimSetEntry."Dimension Value Code", StartPosNoDigits[3], StartPosNoDigits[4]) + FilterOperator);
                    end else begin
                        EbfCombination.SetRange("GL Account No.", lGLAcc);
                        EbfCombination.SetRange("Dimension Code", DimSetEntry."Dimension Code");
                        EbfCombination.SetRange("Dimension Value Code", DimSetEntry."Dimension Value Code");
                    end;

                    if EbfCombination.FindFirst() then begin
                        if EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Not Allowed" then
                            if CreateLog then begin
                                ErrorTextL := CopySTR(StrSubstNo(Text011, lGLAcc,
                                  DimSetEntry."Dimension Value Code"), 1, 250);
                                //ItemJnlPostBatchL.Insert()RevJnlErrorLog(ItemJnlLineError, ErrorTextL);  // BC Upgrade NANDIS03 - Blocked only to compile the codeunit
                                Clear(ErrorTextL);
                            end else
                                Error(Text011, lGLAcc, DimSetEntry."Dimension Value Code");
                        if GuiAllowed then
                            if EbfCombination."Combination Restriction" = EbfCombination."Combination Restriction"::"Allowed with Warn" then
                                if not Confirm(StrSubstNo(Text012, lGLAcc, DimSetEntry."Dimension Value Code")) then
                                    Error('');
                    end;
                end;
            until DimSetEntry.Next() = 0;
        //HEI.53<<
    end;
    //Bc Upgrade YADAVM09 Code added in Levy custom Codeunit>>

    // [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    // local procedure OnAfterValidatePurchLineNo(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    // var
    //     FixedAsset: Record "Fixed Asset";
    //     GLAcc: Record "G/L Account";
    //     HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
    //     Item: Record Item;
    //     PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    //     Text50000: Label 'Levy posting setup must have a value for %1.';
    // begin
    //     //HEI.48>>
    //     if Rec.IsTemporary then
    //         exit;

    //     PurchasesPayablesSetup.Get();
    //     if not PurchasesPayablesSetup."H&S Levy Tax FND" then
    //         exit;
    //     if Rec.Type = Rec.Type::"G/L Account" then begin
    //         GLAcc.Get(Rec."No.");
    //         if HSTaxPostingSetup.Get(GLAcc."H&S Levy Tax Posting Group FND") then begin
    //             Rec."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
    //             Rec."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
    //         end;
    //     end;

    //     if Rec.Type = Rec.Type::Item then begin
    //         Item.Get(Rec."No.");
    //         if HSTaxPostingSetup.Get(Item."H&S Levy Tax Posting Group FND") then begin
    //             Rec."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
    //             Rec."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
    //         end;
    //     end;

    //     if Rec.Type = Rec.Type::"Fixed Asset" then begin
    //         FixedAsset.Get(Rec."No.");
    //         if HSTaxPostingSetup.Get(FixedAsset."H&S Levy Tax Posting Group FND") then begin
    //             Rec."H&S Levy Tax % FND" := HSTaxPostingSetup."H&S Tax %";
    //             Rec."HS Posting Group FND" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
    //         end;
    //     end;
    //     //HEI.48<<
    // end;
    //Bc Upgrade YADAVM09 Code added in Levy custom Codeunit<<

    // BC Upgrade POENAB02 >>
    // OnBeforeUpdateAmount event does not exists in "Purchase Line"
    //Functionality belongs to Levy Tax and needs to be redesigned
    /*
    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeUpdateAmount', '', false, false)]
    local procedure OnBeforeupdateAmountPurchLine(var Rec: Record "Purchase Line");
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Currency: Record Currency;
    begin
        //HEI.48>>
        PurchasesPayablesSetup.Get();
        Clear(Rec."H&S Levy Tax Amount");
        Clear(Rec."Total Amount Excl VAT/H&S");
        if (Rec."Document Type" = Rec."Document Type"::Invoice) or (Rec."Document Type" = Rec."Document Type"::"Credit Memo") then begin
            if PurchasesPayablesSetup."H&S Levy Tax" then
                if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"G/L Account") or (Rec.Type = Rec.Type::"Fixed Asset") then
                    if Rec."HS Posting Group" <> '' then //HEI.52
                        Rec.Validate("H&S Levy Tax Amount", Round(Rec."H&S Levy Tax Amount", Currency."Amount Rounding Precision") + Round(((Rec."Direct Unit Cost" * Rec.Quantity - Rec."Line Discount Amount") * Rec."H&S Levy Tax %") / 100, Currency."Amount Rounding Precision"));

            if Rec."Line Discount %" <> 0 then
                Rec."Total Amount Excl VAT/H&S" := Round(Rec."Direct Unit Cost" * Rec.Quantity, Currency."Amount Rounding Precision") - Rec."Line Discount Amount" - Round(Rec."H&S Levy Tax Amount");

            if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"G/L Account") or (Rec.Type = Rec.Type::"Fixed Asset") then
                if (Rec."HS Posting Group" <> '') then //HEI.52
                    Rec."Total Amount Excl VAT/H&S" := Round(Rec."Direct Unit Cost" * Rec.Quantity + Rec."H&S Levy Tax Amount", Currency."Amount Rounding Precision") - Round(Rec."H&S Levy Tax Amount") - Rec."Line Discount Amount";
        end;

        if Rec."HS Posting Group" <> '' then//HEI.52
            if (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"G/L Account") or (Rec.Type = Rec.Type::"Fixed Asset") then
                Rec."Line Amount" :=
                 Round((Rec.Quantity * Rec."Direct Unit Cost" + Rec."H&S Levy Tax Amount"), Currency."Amount Rounding Precision") - Rec."Line Discount Amount";
        //HEI.48<<
    end;
    */
    // BC Upgrade POENAB02 <<


    // BC Upgrade POENAB02 >>
    // OnBeforeInsertReceiptlineforLevyTax event does not exists in "Purch. Rcpt. Line"
    // Functionality belongs to Levy Tax and needs to be redesigned
    /*     
    [EventSubscriber(ObjectType::Table, 121, 'OnBeforeInsertReceiptlineforLevyTax', '', false, false)]
    local procedure OnBeforeInsertPurchaseReceiptLineForLevyTax(var PurchLine: Record "Purchase Line");
    var
        GLAccount: Record "G/L Account";
        Item: Record Item;
        FixedAsset: Record "Fixed Asset";
        HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
    begin
        //HEI.48>>
        if (PurchLine."Document Type" = PurchLine."Document Type"::Invoice) or (PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") then begin
            PurchasesPayablesSetup.Get;
            if PurchasesPayablesSetup."H&S Levy Tax" then begin
                if PurchLine.Type = PurchLine.Type::"G/L Account" then
                    if GLAccount.Get(PurchLine."No.") then
                        if HSTaxPostingSetup.Get(GLAccount."H&S Levy Tax Posting Group") then
                            PurchLine."H&S Levy Tax %" := HSTaxPostingSetup."H&S Tax %";
                PurchLine."HS Posting Group" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
            end;

            if PurchasesPayablesSetup."H&S Levy Tax" then begin
                if PurchLine.Type = PurchLine.Type::Item then
                    if Item.Get(PurchLine."No.") then
                        if HSTaxPostingSetup.Get(Item."H&S Levy Tax Posting Group") then
                            PurchLine."H&S Levy Tax %" := HSTaxPostingSetup."H&S Tax %";
                PurchLine."HS Posting Group" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
            end;
            if PurchasesPayablesSetup."H&S Levy Tax" then begin
                if PurchLine.Type = PurchLine.Type::"Fixed Asset" then
                    if FixedAsset.Get(PurchLine."No.") then
                        if HSTaxPostingSetup.Get(FixedAsset."H&S Levy Tax Posting Group") then
                            PurchLine."H&S Levy Tax %" := HSTaxPostingSetup."H&S Tax %";
                PurchLine."HS Posting Group" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
            end;
            PurchLine."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S";
            PurchLine."HS Posting Group" := PurchLine."HS Posting Group";//HEI.52
            PurchLine."Line Amount" := Round(PurchLine."Line Amount" * HSTaxPostingSetup."H&S Tax %" / 100);
            PurchLine.Amount := Round(PurchLine."Line Amount" * HSTaxPostingSetup."H&S Tax %" / 100);
        end;
        //HEI.48<<
    end;
    */
    // BC Upgrade POENAB02 <<


    // BC Upgrade POENAB02 >>
    // OnBeforePurchInvlineInsertForLevyTax event does not exists in "Purch. Inv. Line"
    // Functionality belongs to Levy Tax and needs to be redesigned
    /*
    [EventSubscriber(ObjectType::Table, 123, 'OnBeforePurchInvlineInsertForLevyTax', '', false, false)]
    local procedure OnBeforePurchInvlineInsertForLevyTax(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchLine: Record "Purchase Line"; var PurchInvLine: Record "Purch. Inv. Line");
    begin
        //HEI.48>>
        if (PurchLine."Document Type" = PurchLine."Document Type"::Invoice) or (PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") then begin
            PurchasesPayablesSetup.Get();
            if PurchasesPayablesSetup."H&S Levy Tax" then
                if PurchLine."H&S Levy Tax %" <> 0 then begin
                    PurchInvLine."H&S Levy Tax %" := PurchLine."H&S Levy Tax %";
                    PurchInvLine."HS Posting Group" := PurchLine."HS Posting Group";//HEI.52
                    PurchInvLine."H&S Levy Tax Amount" := PurchLine."H&S Levy Tax Amount";
                    PurchInvLine."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S";
                    PurchInvLine."VAT Base Amount" := PurchLine."Line Amount" + PurchLine."H&S Levy Tax Amount";
                    PurchInvLine."Line Amount" := PurchLine."Line Amount" + PurchLine."H&S Levy Tax Amount";
                    PurchInvLine.Amount := PurchLine.Amount + PurchLine."H&S Levy Tax Amount";
                    PurchInvLine."Amount Including VAT" := PurchLine."Amount Including VAT" + PurchLine."H&S Levy Tax Amount";
                    InitFromLevyTaxEntries(PurchInvHeader, PurchLine, PurchInvLine);//HEI.50
                end;
        end;
        //HEI.48<<
    end;
    */
    // BC Upgrade POENAB02 <<

    // procedure InitFromLevyTaxEntries(PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; PurchInvLine: Record "Purch. Inv. Line");
    // var
    //     LevyTaxEntries: Record "Levy Tax Entries FND";
    //     NextLeavyTaxEntryNo: Integer;
    // begin
    //     //HEI.48>>
    //     LevyTaxEntries.LockTable();
    //     ;
    //     if PurchLine.Type <> PurchLine.Type::" " then begin
    //         LevyTaxEntries.Reset();
    //         if LevyTaxEntries.FindLast() then
    //             NextLeavyTaxEntryNo := LevyTaxEntries."Entry No." + 1
    //         else
    //             NextLeavyTaxEntryNo := 1;
    //         LevyTaxEntries.Init();
    //         LevyTaxEntries."Entry No." := NextLeavyTaxEntryNo;
    //         LevyTaxEntries."Transaction Type" := LevyTaxEntries."Transaction Type"::Invoice;//HEI.50
    //         LevyTaxEntries."Doc. No." := PurchInvHeader."No.";
    //         LevyTaxEntries."Unit of Measure" := PurchLine."Unit of Measure Code";
    //         LevyTaxEntries."Posting Date" := PurchInvHeader."Posting Date";
    //         LevyTaxEntries."Doc. Date" := PurchInvHeader."Document Date";
    //         LevyTaxEntries."Vendor No." := PurchInvHeader."Buy-from Vendor No.";
    //         LevyTaxEntries."Vendor Name" := PurchInvHeader."Buy-from Vendor Name";
    //         LevyTaxEntries."Line No." := PurchInvLine."Line No.";//HEI.50
    //         LevyTaxEntries."HS Posting Group" := PurchInvLine."HS Posting Group FND";//HEI.52
    //         LevyTaxEntries.Type := PurchLine.Type;
    //         LevyTaxEntries."No." := PurchLine."No.";
    //         LevyTaxEntries.Description := PurchLine.Description;
    //         LevyTaxEntries.Location := PurchLine."Location Code";
    //         LevyTaxEntries.Zone := PurchLine."Zone Code FND";
    //         LevyTaxEntries.Bin := PurchLine."Bin Code";
    //         LevyTaxEntries.Quantity := PurchLine.Quantity;
    //         LevyTaxEntries."Direct Unit Cost Exl. VAT" := PurchLine."Direct Unit Cost";
    //         LevyTaxEntries."Line Amount Excl. VAT" := PurchLine."Line Amount";
    //         LevyTaxEntries."H&S Levy Tax %" := PurchLine."H&S Levy Tax % FND";
    //         LevyTaxEntries."H&S Levy Tax Amount" := PurchLine."H&S Levy Tax Amount FND";
    //         LevyTaxEntries."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S FND";
    //         LevyTaxEntries."Discount %" := PurchLine."Line Discount %";
    //         LevyTaxEntries."Discount Line Amt Excl. VAT" := PurchLine."Line Discount Amount";
    //         LevyTaxEntries."Creation Date" := Today;
    //         LevyTaxEntries."User ID" := UserId;
    //         LevyTaxEntries."Inv Credit Memo No." := PurchInvHeader."Vendor Order No.";
    //         LevyTaxEntries."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S FND";
    //         LevyTaxEntries.Insert();
    //     end;
    //     //HEI.48<<
    // end;//Bc Upgrade YADAVM09 function added in Levy Custom codeunit<<


    // BC Upgrade POENAB02 >>
    // OnBeforeInsertPurchCRMemoForLevyTax event does not exists in "Purch. Cr. Memo Line"
    // Functionality belongs to Levy Tax and needs to be redesigned
    /* 
    [EventSubscriber(ObjectType::Table, 125, 'OnBeforeInsertPurchCRMemoForLevyTax', '', false, false)]
    local procedure OnBeforeInsertPurchCRMemoForLevyTax(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLine: Record "Purchase Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line");
    begin
        //HEI.48>>
        if (PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") then begin
            PurchasesPayablesSetup.Get();
            if PurchasesPayablesSetup."H&S Levy Tax" then
                if PurchLine."H&S Levy Tax %" <> 0 then begin
                    PurchCrMemoLine."H&S Levy Tax %" := PurchLine."H&S Levy Tax %";
                    PurchCrMemoLine."HS Posting Group" := PurchLine."HS Posting Group";//HEI.52
                    PurchCrMemoLine."H&S Levy Tax Amount" := PurchLine."H&S Levy Tax Amount";
                    PurchCrMemoLine."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S";
                    PurchCrMemoLine."Line Amount" := PurchLine."Line Amount" + PurchLine."H&S Levy Tax Amount";
                    PurchCrMemoLine.Amount := PurchLine.Amount + PurchLine."H&S Levy Tax Amount";
                    PurchCrMemoLine."Amount Including VAT" := PurchLine."Amount Including VAT" + PurchLine."H&S Levy Tax Amount";
                    InitFromLevyTaxEntriesPurchCrMemo(PurchCrMemoHdr, PurchLine, PurchCrMemoLine);//HEI.50
                end;
        end;
        //HEI.48<<
    end; 
    */
    // BC Upgrade POENAB02 <<


    // BC Upgrade POENAB02 >>
    // OnBeforeInsertShipmentForLevyTax event does not exists in "Return Shipment Line"
    // Functionality belongs to Levy Tax and needs to be redesigned
    /*
    [EventSubscriber(ObjectType::Table, 6651, 'OnBeforeInsertShipmentForLevyTax', '', false, false)]
    local procedure OnBeforeInsertShipmentForLevyTax(var PurchLine: Record "Purchase Line");
    var
        GLAccount: Record "G/L Account";
        Item: Record Item;
        FixedAsset: Record "Fixed Asset";
        HSTaxPostingSetup: Record "H&S Tax Posting Setup FND";
    begin
        //HEI.48>>
        if (PurchLine."Document Type" = PurchLine."Document Type"::Invoice) or (PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") then begin
            PurchasesPayablesSetup.Get();
            if PurchasesPayablesSetup."H&S Levy Tax" then
                if PurchLine."H&S Levy Tax %" <> 0 then begin
                    if PurchLine.Type = PurchLine.Type::"G/L Account" then
                        if GLAccount.Get(PurchLine."No.") then
                            if HSTaxPostingSetup.Get(GLAccount."H&S Levy Tax Posting Group") then
                                PurchLine."H&S Levy Tax %" := HSTaxPostingSetup."H&S Tax %";
                    PurchLine."HS Posting Group" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
                end;

            if PurchasesPayablesSetup."H&S Levy Tax" then
                if PurchLine."H&S Levy Tax %" <> 0 then begin
                    if PurchLine.Type = PurchLine.Type::Item then
                        if Item.Get(PurchLine."No.") then
                            if HSTaxPostingSetup.Get(Item."H&S Levy Tax Posting Group") then
                                PurchLine."H&S Levy Tax %" := HSTaxPostingSetup."H&S Tax %";
                    PurchLine."HS Posting Group" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
                end;

            if PurchasesPayablesSetup."H&S Levy Tax" then
                if PurchLine."H&S Levy Tax %" <> 0 then begin
                    if PurchLine.Type = PurchLine.Type::"Fixed Asset" then
                        if FixedAsset.Get(PurchLine."No.") then
                            if HSTaxPostingSetup.Get(FixedAsset."H&S Levy Tax Posting Group") then
                                PurchLine."H&S Levy Tax %" := HSTaxPostingSetup."H&S Tax %";
                    PurchLine."HS Posting Group" := HSTaxPostingSetup."H&S Tax Posting Group";//HEI.52
                end;

            if PurchLine."H&S Levy Tax %" <> 0 then begin
                PurchLine."H&S Levy Tax Amount" := Round(PurchLine."Line Amount" * PurchLine."H&S Levy Tax %" / 100);
                PurchLine."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S";
                PurchLine."HS Posting Group" := PurchLine."HS Posting Group";//HEI.52
                PurchLine."Line Amount" := Round(PurchLine."Line Amount" + PurchLine."H&S Levy Tax Amount");
                PurchLine."Total Amount Excl VAT/H&S" := PurchLine."Line Amount" - PurchLine."H&S Levy Tax Amount";
                PurchLine.Amount := PurchLine.Amount + PurchLine."H&S Levy Tax Amount";
                PurchLine."Amount Including VAT" := PurchLine."Amount Including VAT" + PurchLine."H&S Levy Tax Amount";
            end;
        end;
        //HEI.48<<
    end;
    */
    // BC Upgrade POENAB02 <<

    //Bc Upgrade YADAVM09 Code added in Levy custom codeunit>>
    // [EventSubscriber(ObjectType::Codeunit, 6620, 'OnAfterCopyPurchaseDocument', '', false, false)]
    // local procedure OnAfterCopyPurchaseDocument(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToPurchaseHeader: Record "Purchase Header");
    // var
    //     PurchaseLine: Record "Purchase Line";
    //     LAAmountC: Decimal;
    //     LAmountI: Decimal;
    // begin

    //     //HEI.48>>
    //     Clear(LAmountI);
    //     Clear(LAAmountC);
    //     PurchaseLine.Reset();
    //     PurchaseLine.SetRange("Document No.", ToPurchaseHeader."No.");
    //     PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
    //     PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
    //     PurchaseLine.SetFilter("H&S Levy Tax % FND", '<>%1', 0);
    //     if PurchaseLine.FindSet(true) then
    //         repeat
    //             LAmountI := PurchaseLine."Total Amount Excl VAT/H&S FND" + PurchaseLine."H&S Levy Tax Amount FND";
    //             if PurchaseLine."Line Amount" <> LAmountI then
    //                 PurchaseLine."Line Amount" := PurchaseLine."Line Amount" + PurchaseLine."H&S Levy Tax Amount FND";
    //             PurchaseLine."HS Posting Group FND" := PurchaseLine."HS Posting Group FND";//HEI.52
    //             PurchaseLine.Modify();
    //         until PurchaseLine.Next() = 0;

    //     PurchaseLine.Reset();
    //     PurchaseLine.SetRange("Document No.", ToPurchaseHeader."No.");
    //     PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Credit Memo");
    //     PurchaseLine.SetFilter("H&S Levy Tax % FND", '<>%1', 0);
    //     if PurchaseLine.FindSet(true) then
    //         repeat
    //             LAAmountC := PurchaseLine."Total Amount Excl VAT/H&S FND" + PurchaseLine."H&S Levy Tax Amount FND";
    //             if PurchaseLine."Line Amount" <> LAAmountC then
    //                 PurchaseLine."Line Amount" := PurchaseLine."Line Amount" + PurchaseLine."H&S Levy Tax Amount FND";
    //             PurchaseLine."HS Posting Group FND" := PurchaseLine."HS Posting Group FND";//HEI.52
    //             PurchaseLine.Modify();
    //         until PurchaseLine.Next() = 0;
    //     //HEI.48<<
    // end;


    // procedure InitFromLevyTaxEntriesPurchCrMemo(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchLine: Record "Purchase Line"; PurchCrMemoLine: Record "Purch. Cr. Memo Line");
    // var
    //     LevyTaxEntries: Record "Levy Tax Entries FND";
    //     NextLeavyTaxEntryNo: Integer;
    // begin
    //     //HEI.48>>
    //     LevyTaxEntries.LockTable();
    //     if PurchLine.Type <> PurchLine.Type::" " then begin
    //         LevyTaxEntries.Reset();
    //         if LevyTaxEntries.FindLast() then
    //             NextLeavyTaxEntryNo := LevyTaxEntries."Entry No." + 1
    //         else
    //             NextLeavyTaxEntryNo := 1;
    //         LevyTaxEntries.Init();
    //         LevyTaxEntries."Entry No." := NextLeavyTaxEntryNo;
    //         LevyTaxEntries."Transaction Type" := LevyTaxEntries."Transaction Type"::"Credit Memo";//HEI.50
    //         LevyTaxEntries."Doc. No." := PurchCrMemoHdr."No.";
    //         LevyTaxEntries."Unit of Measure" := PurchLine."Unit of Measure Code";
    //         LevyTaxEntries."Posting Date" := PurchCrMemoHdr."Posting Date";
    //         LevyTaxEntries."Doc. Date" := PurchCrMemoHdr."Document Date";
    //         LevyTaxEntries."Vendor No." := PurchCrMemoHdr."Buy-from Vendor No.";
    //         LevyTaxEntries."Vendor Name" := PurchCrMemoHdr."Buy-from Vendor Name";
    //         LevyTaxEntries."Line No." := PurchCrMemoLine."Line No.";//HEI.50
    //         LevyTaxEntries."HS Posting Group" := PurchLine."HS Posting Group FND";//HEI.52
    //         LevyTaxEntries.Type := PurchLine.Type;
    //         LevyTaxEntries."No." := PurchLine."No.";
    //         LevyTaxEntries.Description := PurchLine.Description;
    //         LevyTaxEntries.Location := PurchLine."Location Code";
    //         LevyTaxEntries.Zone := PurchLine."Zone Code FND";
    //         LevyTaxEntries.Bin := PurchLine."Bin Code";
    //         LevyTaxEntries.Quantity := PurchLine.Quantity;
    //         LevyTaxEntries."Direct Unit Cost Exl. VAT" := PurchLine."Direct Unit Cost";
    //         LevyTaxEntries."Line Amount Excl. VAT" := PurchLine."Line Amount";
    //         LevyTaxEntries."H&S Levy Tax %" := PurchLine."H&S Levy Tax % FND";
    //         LevyTaxEntries."H&S Levy Tax Amount" := PurchLine."H&S Levy Tax Amount FND";
    //         LevyTaxEntries."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S FND";
    //         LevyTaxEntries."Discount %" := PurchLine."Line Discount %";
    //         LevyTaxEntries."Discount Line Amt Excl. VAT" := PurchLine."Line Discount Amount";
    //         LevyTaxEntries."Creation Date" := Today;
    //         LevyTaxEntries."User ID" := UserId;
    //         LevyTaxEntries."Inv Credit Memo No." := PurchCrMemoHdr."Vendor Cr. Memo No.";
    //         LevyTaxEntries."Total Amount Excl VAT/H&S" := PurchLine."Total Amount Excl VAT/H&S FND";
    //         LevyTaxEntries.Insert();
    //     end;
    //     //HEI.48<<
    // end;//Bc Upgrade YADAVM09 Code added in Levy custom codeunit<<

    // BC Upgrade POENAB02 >>
    // OnBeforeOpenEventConditions event does not exists in "Workflow Step Buffer"
    // Functionality needs to be redesigned
    // # Restrict users to connect or disconnect RTR journal templates from the Workflow approval
    /*
    [EventSubscriber(ObjectType::Table, 1507, 'OnBeforeOpenEventConditions', '', false, false)]
    local procedure OnBeforeOpenEventConditions(Workflow: Record Workflow);
    var
        UserSetup: Record "User Setup";
        Text50000: Label 'You are not authorized to Modify the Workflow %1 with user %2.';
    begin
        //HEI.49
        if Workflow.Category = 'FI-RTR' then
            if UserSetup.Get(UserId) then
                if not UserSetup."Restrict RtR Workflow Users" then
                    Error(Text50000, Workflow.Code, UserId);
        //HEI.49
    end;
    */

    // POENAB02, 26.02.2026 >>
    //[EventSubscriber(ObjectType::Table, database::"Workflow Step Buffer", OnAfterModifyEvent, '', false, false)]
    [EventSubscriber(ObjectType::Table, database::"Workflow Step Buffer", OnAfterModifyEvent, '', false, false)]
    local procedure OnBeforeModifyEvent(var Rec: Record "Workflow Step Buffer"; var xRec: Record "Workflow Step Buffer");
    var
        UserSetup: Record "User Setup";
        Workflow: Record Workflow;
        lText50000: Label 'You are not authorized to Modify the Workflow %1 with user %2.';
    begin
        if (Rec.Indent <> xRec.Indent) or (Rec."Event Description" <> xRec."Event Description") or
            (Rec.Condition <> xRec.Condition) or (Rec."Response Description" <> xRec."Response Description") or
            (Rec."Event Step ID" <> xRec."Event Step ID") or (Rec."Response Step ID" <> xRec."Response Step ID") or
            (Rec."Workflow Code" <> xRec."Workflow Code") or (Rec."Parent Event Step ID" <> xRec."Parent Event Step ID") or
            (Rec."Previous Workflow Step ID" <> xRec."Previous Workflow Step ID") or (Rec."Response Description Style" <> xRec."Response Description Style") or
            (Rec."Entry Point" <> xRec."Entry Point") or (Rec."Sequence No." <> xRec."Sequence No.") or
            (Rec."Next Step Description" <> xRec."Next Step Description") then
            if Workflow.Get(Rec."Workflow Code") then
                if Workflow.Category = 'FI-RTR' then begin
                    if UserSetup.Get(UserId) then
                        if not UserSetup."Restrict RtR Work Users FND" then
                            Error(lText50000, Workflow.Code, UserId);
                    if not UserSetup.Get(UserId) then
                        Error(lText50000, Workflow.Code, UserId);
                end;
    end;
    // POENAB02, 26.02.2026 <<  
    // BC Upgrade POENAB02 <<
    //Bc Upgrade YADAVM09 Code added in Levy custom codeunit>>
    // [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInsertValueEntry', '', false, false)]
    // local procedure OnAfterInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line");
    // var
    //     LevyTaxEntries: Record "Levy Tax Entries FND";
    // begin
    //     //HEI.50>>
    //     LevyTaxEntries.Reset();
    //     LevyTaxEntries.SetRange("Doc. No.", ValueEntry."Document No.");
    //     LevyTaxEntries.SetRange("Line No.", ValueEntry."Line No. FND");
    //     if LevyTaxEntries.FindFirst() then begin
    //         LevyTaxEntries."Value Entry No." := ValueEntry."Entry No.";
    //         LevyTaxEntries."ILE Entry No." := ValueEntry."Item Ledger Entry No.";
    //         LevyTaxEntries.Modify();
    //     end;
    //     //HEI.50<<
    // end;

    // [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'HS Posting Group FND', false, false)]
    // local procedure OnAfterValidatePurchlineHspostingGroup(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    // var
    //     HSTaxPostingsetup: Record "H&S Tax Posting Setup FND";
    // begin
    //     //HEI.52
    //     if (Rec.Type = Rec.Type::"G/L Account") or (Rec.Type = Rec.Type::Item) or (Rec.Type = Rec.Type::"Fixed Asset") then
    //         if HSTaxPostingsetup.Get(Rec."HS Posting Group FND") then
    //             Rec."H&S Levy Tax % FND" := HSTaxPostingsetup."H&S Tax %";
    //     Rec.UpdateAmounts();
    //     //HEI.52
    // end;
    //Bc Upgrade YADAVM09 Code added in Levy custom codeunit<<
}

