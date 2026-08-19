report 58035 "SL BalanceMergeExtract Cadency"
{
    // version HEI.08

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 22.02.2019
    //   # Created new processonly Report
    // HEI.02 CHG2171515 IBM POENAB02 07.09.2022 Trintech Cadency - Company Code ID instead of Legal Entity Code
    //   # Modified code
    // HEI.04 CHG2228096 IBM KAPOOV01 16.05.2024 Balance Extract Cadency & SL BalanceMergeExtract Cadency execution times
    //   # Modified Triggers:OnPostReport(),OnPreReport(),Item - OnPreDataItem(),Item - OnAfterGetRecord()
    //   # Added new global variable :tempVE
    //   # Defined below DataItemLink property for DataItem :Item
    //     Inventory Posting Group=FIELD(Invt. Posting Group Code)
    // HEI.06 CHG2228096 IBM KAPOOV01 03.10.2024 Balance Extract Cadency & SL BalanceMergeExtract Cadency execution times
    //   # Commented HEI.04, as it is no longer required.
    //   # Modified Triggers:Vendor Posting Group - OnAfterGetRecord(),Customer Posting Group - OnAfterGetRecord()
    //   # Removed DataItemLink Property for DataItem: Item as it was added in HEI.04
    //     Old Value: Inventory Posting Group=FIELD(Invt. Posting Group Code)
    //     New Value: Blank.
    // HEI.08 CHG2278058 POENAB02 10.12.2024 Vendors and Customers subledger balances extraction from HL to Cadency
    //   # Modified logic for calculating values for Customer Posting Group and Vendor Posting Group
    //   # Modified Customer Posting Group - OnAfterGetRecord and Vendor Posting Group - OnAfterGetRecord
    // HEI.07 CHG2262655 SAHAL01 29.11.2024 Automatic data export for control purposes
    //   # Added Code

    // BC Upgrade POENAB02: Original (HeiLite) report id 50247

    // BC Upgrade POENAB02, 03.03.2026, gap "Cadency, SL Balance Merge Extract, Vendor Posting Group and Customer Posting Group filters"
    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Cadency Value Buffer" to "Cadency Value Buffer FND".
    // BC UPGRADE PATELS08 <<


    // BC Upgrade MISHRS14 >>
    // Changed table name to "Cadency Data FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<


    // BC Upgrade PATELP08>>
    // Changed name of table from "Cadency Data Archive" to "Cadency Data Archive FND"
    // BC Upgrade PATELP08<<


    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Customer Posting Group"; "Customer Posting Group")
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord();
            var
                CustPostingGroupCode: Code[10];
                DtlCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
            begin
                TotalAmtLCY := 0;

                //HEI.08>>
                /*
                CLEAR(CLEntry);
                CLEntry.RESET;//HEI.06
                CLEntry.SETRANGE("Posting Date",PrevMonthFirstDay,PrevMonthLastDay);
                CLEntry.SETRANGE("Customer Posting Group","Customer Posting Group".Code);
                //HEI.06>>
                CLEntry.SETAUTOCALCFIELDS("Amount (LCY)");
                IF CLEntry.FINDSET(FALSE,FALSE) THEN
                //HEI.06<<
                //IF CLEntry.FINDSET THEN  //HEI.06 Commented
                  REPEAT
                    //CLEntry.CALCFIELDS("Amount (LCY)");//HEI.06 Commented
                    TotalAmtLCY += CLEntry."Amount (LCY)";
                  UNTIL CLEntry.NEXT = 0;
                
                CLEntry.SETAUTOCALCFIELDS();//HEI.06
                */

                CustPostingGroupCode := "Customer Posting Group".Code;
                DtlCustLedgEntry.Reset();
                //with DtlCustLedgEntry do begin
                // BC Upgrade POENAB02 >>
                // Commented the below line, as it is an Aptean field
                // DtlCustLedgEntry.SETRANGE("Customer Posting Group", CustPostingGroupCode);
                // BC Upgrade POENAB02 <<
                // BC Upgrade POENAB02, 03.03.2026 >>                
               // DtlCustLedgEntry.SetRange("Customer Posting Group 101FDW", CustPostingGroupCode);
                // BC Upgrade POENAB02 <<
                DtlCustLedgEntry.SetRange("Posting Date", PrevMonthFirstDay, PrevMonthLastDay);
                DtlCustLedgEntry.CalcSums("Amount (LCY)");
                TotalAmtLCY += DtlCustLedgEntry."Amount (LCY)";
                //end;
                //HEI.08<<

                if bufferTab.Get("Customer Posting Group"."Receivables Account") then begin
                    bufferTab.Amount += TotalAmtLCY;
                    bufferTab.Modify();
                end else begin
                    Clear(bufferTab);
                    bufferTab."G/L Account" := "Customer Posting Group"."Receivables Account";
                    bufferTab.Amount := TotalAmtLCY;
                    bufferTab.Insert();
                end;

            end;
        }
        dataitem("Vendor Posting Group"; "Vendor Posting Group")
        {
            DataItemTableView = SORTING(Code);

            trigger OnAfterGetRecord();
            var
                DtlVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                VendorPostingGroupCode: Code[10];
            begin
                TotalAmtLCY := 0;

                //HEI.08>>
                /*
                CLEAR(VLEntry);
                VLEntry.RESET;//HEI.06
                VLEntry.SETRANGE("Posting Date",PrevMonthFirstDay,PrevMonthLastDay);
                VLEntry.SETRANGE("Vendor Posting Group","Vendor Posting Group".Code);
                //HEI.06>>
                VLEntry.SETAUTOCALCFIELDS("Amount (LCY)");
                IF VLEntry.FINDSET(FALSE,FALSE) THEN
                //HEI.06<<
                //IF VLEntry.FINDSET THEN  //HEI.06 Commented
                  REPEAT
                    //VLEntry.CALCFIELDS("Amount (LCY)");//HEI.06 Commented
                    TotalAmtLCY += VLEntry."Amount (LCY)";
                  UNTIL VLEntry.NEXT = 0;
                VLEntry.SETAUTOCALCFIELDS();//HEI.06
                */

                VendorPostingGroupCode := "Vendor Posting Group".Code;
                DtlVendLedgEntry.Reset();
                //with DtlVendLedgEntry do begin
                // BC Upgrade POENAB02 >>
                // Commented the below line, as it is an Aptean field
                // SETRANGE("Vendor Posting Group", VendorPostingGroupCode);
                // BC Upgrade POENAB02 <<
                // BC Upgrade POENAB02, 03.03.2026 >>
               // DtlVendLedgEntry.SetRange("Vendor Posting Group 101FDW", VendorPostingGroupCode);
                // BC Upgrade POENAB02 <<
                DtlVendLedgEntry.SetRange("Posting Date", PrevMonthFirstDay, PrevMonthLastDay);
                DtlVendLedgEntry.CalcSums("Amount (LCY)");
                TotalAmtLCY += DtlVendLedgEntry."Amount (LCY)";
                //end;
                //HEI.08<<

                if bufferTab.Get("Vendor Posting Group"."Payables Account") then begin
                    bufferTab.Amount += TotalAmtLCY;
                    bufferTab.Modify();
                end else begin
                    Clear(bufferTab);
                    bufferTab."G/L Account" := "Vendor Posting Group"."Payables Account";
                    bufferTab.Amount := TotalAmtLCY;
                    bufferTab.Insert();
                end;

            end;
        }
        dataitem("Inventory Posting Group"; "Inventory Posting Group")
        {
            DataItemTableView = SORTING(Code);
            dataitem("Inventory Posting Setup"; "Inventory Posting Setup")
            {
                DataItemLink = "Invt. Posting Group Code" = FIELD(Code);
                DataItemTableView = SORTING("Location Code", "Invt. Posting Group Code");
                dataitem(Item; Item)
                {
                    DataItemTableView = SORTING("Inventory Posting Group");

                    trigger OnAfterGetRecord();
                    var
                        tempVECostAmountActual: Decimal;
                        tempVECostAmountExpected: Decimal;
                    begin
                        Clear(ValueEntry);
                        ValueEntry.SetCurrentKey("Item No.", "Document No.", "Posting Date", "Location Code");
                        ValueEntry.SetRange("Item No.", Item."No.");
                        ValueEntry.SetRange("Posting Date", PrevMonthFirstDay, PrevMonthLastDay);
                        ValueEntry.SetFilter("Location Code", Item.GetFilter("Location Filter"));

                        ValueEntry.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");

                        if bufferTab.Get("Inventory Posting Setup"."Inventory Account") then begin
                            bufferTab.Amount += ValueEntry."Cost Amount (Actual)";
                            bufferTab.Modify();
                        end else begin
                            Clear(bufferTab);
                            bufferTab."G/L Account" := "Inventory Posting Setup"."Inventory Account";
                            bufferTab.Amount := ValueEntry."Cost Amount (Actual)";
                            bufferTab.Insert();
                        end;

                        if bufferTab.Get("Inventory Posting Setup"."Inventory Account (Interim)") then begin
                            bufferTab.Amount += ValueEntry."Cost Amount (Expected)";
                            bufferTab.Modify();
                        end else begin
                            Clear(bufferTab);
                            bufferTab."G/L Account" := "Inventory Posting Setup"."Inventory Account (Interim)";
                            bufferTab.Amount := ValueEntry."Cost Amount (Expected)";
                            bufferTab.Insert();
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        Item.SetRange("Inventory Posting Group", "Inventory Posting Setup"."Invt. Posting Group Code"); //HEI.04//HEI.06 Uncomment old code
                        Item.SetRange("Location Filter", "Inventory Posting Setup"."Location Code");
                    end;
                }
            }
        }
        dataitem("FA Posting Group"; "FA Posting Group")
        {
            DataItemTableView = SORTING(Code) ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                DepreciationBook: Record "Depreciation Book";
            begin
                //Smart SM 310317
                DepreciationBook.Reset();
                if DepreciationBook.FindFirst() then begin
                    repeat
                        if DepreciationBook."G/L Integration - Acq. Cost" then begin
                            //END Smart SM 310317

                            Clear(FALedgerEntry);
                            //FALedgerEntry.SETCURRENTKEY();
                            FALedgerEntry.SetRange("FA Posting Group", "FA Posting Group".Code);
                            //Smart SM 150317
                            //OLD FALedgerEntry.SETRANGE("FA Posting Date",PrevMonthFirstDay,PrevMonthLastDay);
                            FALedgerEntry.SetRange("Posting Date", PrevMonthFirstDay, PrevMonthLastDay);
                            //END Smart SM 150317
                            //Smart SM 310317
                            FALedgerEntry.SetRange("Depreciation Book Code", DepreciationBook.Code);
                            //END Smart SM 310317
                            FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                            FALedgerEntry.CalcSums("Amount (LCY)");

                            if bufferTab.Get("FA Posting Group"."Acquisition Cost Account") then begin
                                bufferTab.Amount += FALedgerEntry."Amount (LCY)";
                                bufferTab.Modify();
                            end else begin
                                Clear(bufferTab);
                                bufferTab."G/L Account" := "FA Posting Group"."Acquisition Cost Account";
                                bufferTab.Amount := FALedgerEntry."Amount (LCY)";
                                bufferTab.Insert();
                            end;
                            //Smart SM 310317
                        end;
                        if DepreciationBook."G/L Integration - Depreciation" then begin
                            //END Smart SM 310317
                            FALedgerEntry.SetRange("FA Posting Type", FALedgerEntry."FA Posting Type"::Depreciation);
                            //Smart SM 310317
                            FALedgerEntry.SetRange("Depreciation Book Code", DepreciationBook.Code);
                            //END Smart SM 310317
                            FALedgerEntry.CalcSums("Amount (LCY)");

                            if bufferTab.Get("FA Posting Group"."Accum. Depreciation Account") then begin
                                bufferTab.Amount += FALedgerEntry."Amount (LCY)";
                                bufferTab.Modify();
                            end else begin
                                Clear(bufferTab);
                                bufferTab."G/L Account" := "FA Posting Group"."Accum. Depreciation Account";
                                bufferTab.Amount := FALedgerEntry."Amount (LCY)";
                                bufferTab.Insert();
                            end;
                            //Smart SM 310317
                        end;
                    until DepreciationBook.Next() = 0;
                end;
                //END Smart SM 310317
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1100710001)
                {
                    field(Period; Period)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;
                        ToolTip = 'Select the period for which the data needs to be extracted.';
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

    trigger OnInitReport();
    begin
        //>>HEI:CHG0248757:1:1 13/10/19 IBM.AS
        //CadencyUserSetup.CheckAuthorization(80117,CurrReport.OBJECTID(TRUE));  NAIKH01 New
        //<<HEI:CHG0248757:1:1 13/10/19 IBM.AS

        //Smart SM 150317
        //CurrReport.USEREQUESTPAGE := GUIALLOWED ;
        //END Smart SM 150317

        CompanyInfo.Get();
        GLSetup.Get();
        //HEI.02>>
        //CompanyInfo.TESTFIELD("Legal Entity Code");
        GeneralInterfaceSetup.Get();
        GeneralInterfaceSetup.TestField("Company Code ID");
        //HEI.02<<
        GLSetup.TestField("Cadency Temporary Path FND");
    end;

    trigger OnPostReport();
    var
        TrintechInterfaceSetupL: Record "Trintech Interface Setup INT";
    begin
        //HEI.06>>
        //HEI.04>>
        /*CLEAR(tempVE);
        tempVE.DELETEALL();*/
        //HEI.04<<
        //HEI.06<<

        bufferTab.SetCurrentKey(bufferTab."G/L Account");
        if bufferTab.Find('-') then
            repeat
                Skip_Loop := false;
                //Smart 22/08/17
                //OLD IF GLAccount.GET(bufferTab."G/L Account") AND (bufferTab."G/L Account" <> '') THEN BEGIN
                if GLAccount.Get(bufferTab."G/L Account") and (bufferTab."G/L Account" <> '') and (not ((bufferTab.Amount = 0) and (GLAccount.Blocked = true))) then begin
                    //END Smart 22/08/17

                    //<< NAIKH01 Skip the GLAccount which are not posted
                    GLEntry.Reset();
                    GLEntry.SetRange("G/L Account No.", bufferTab."G/L Account");
                    if GLEntry.IsEmpty then
                        Skip_Loop := true;

                    if not Skip_Loop then begin
                        //<< NAIKH01

                        CadencyData.Init();
                        CadencyData."Entry No." := EntryNo;
                        CadencyData."File Type" := CadencyData."File Type"::SLBAL;

                        //HEI.02>>
                        //CadencyData."Company Name" := COPYSTR(DELCHR(CompanyInfo."Legal Entity Code",'=','!|@|#|$|%/,_- '),1,10);
                        CadencyData."Company Name" := CopyStr(DelChr(GeneralInterfaceSetup."Company Code ID", '=', '!|@|#|$|%/,_- '), 1, 10);
                        //HEI.02<<
                        CadencyData."G/L Account No." := CopyStr(DelChr(bufferTab."G/L Account", '=', '!|@|#|$|%/,_-'), 1, 8);
                        CadencyData."G/L Account Name" := CopyStr(DelChr(GLAccount.Name, '=', '!|@|#|$|%/_-,'), 1, 50);
                        CadencyData.CCY1Code := CopyStr('EUR', 1, 5);
                        CadencyData.CCY1SubLedger := 0.0; //CopyStr('0.00',1,5)+FORMAT(TAB);
                        CadencyData.CCY2Code := CopyStr(GLSetup."LCY Code", 1, 5);
                        CadencyData.CCY2SubLedger := bufferTab.Amount; // CopyStr(DelChr(FORMAT(bufferTab.Amount),'=',','),1,20)+FORMAT(TAB);
                        Evaluate(Period1, CopyStr(Format(Date2DMY(PrevMonthLastDay, 2)), 1, 2));
                        CadencyData.Period := Period1;
                        Evaluate(Year1, CopyStr(Format(Date2DMY(PrevMonthLastDay, 3)), 1, 4));
                        CadencyData.Year := Year1;
                        CadencyData."Execution Date" := Today;
                        CadencyData.Insert();

                        Cnt += 1;
                        TotalAmt += bufferTab.Amount;

                        EntryNo := EntryNo + 1;
                    end;
                end;
            until bufferTab.Next() = 0;

        CadencyData.Reset();
        CadencyData.SetRange("File Type", CadencyData."File Type"::SLBAL);
        //HEI.06>>
        /*IF CadencyData.FINDSET THEN
          REPEAT
            CadencyData."Total Count" := Cnt;
            CadencyData."Total Amount" := TotalAmt;
            CadencyData.MODIFY;
          UNTIL CadencyData.NEXT =0;*/
        //HEI.06<<
        //HEI.06>>
        //BEGIN
        CadencyData.ModifyAll("Total Count", Cnt);
        CadencyData.ModifyAll("Total Amount", TotalAmt);
        //END;
        //HEI.06<<
        //FleCIL1.CLOSE;
        /* //NAIKH01 NEw
        IF GUIALLOWED THEN
        //>>HEI:CHG0248757:1:1 13/10/19 IBM.AS
          BEGIN
            CadencyUserRegister.InsertCadencyUserRegister(80117);
            MESSAGE(Text014);
          END;
        //<<HEI:CHG0248757:1:1 13/10/19 IBM.AS
        */ //NAIKH01 New

        //HEI.07>>
        if not CadencyData.IsEmpty then begin
            TrintechInterfaceSetupL.Get();
            TrintechInterfaceSetupL."Last SLBAL Completion Date" := Today;
            TrintechInterfaceSetupL.Modify(false);
        end;
        //HEI.07<<

    end;

    trigger OnPreReport();
    var
        qSLVE: Query "SL Candency VE";
        tVEEntryNo: Integer;
    begin
        bufferTab.DeleteAll();
        Cnt := 0;
        if GlobalLanguage <> 1036 then begin
            if Period = Period::"Period-1" then begin
                PreviousMonth := CalcDate('-1M', Today);
                PrevMonthLastDay := CalcDate('CM', PreviousMonth);
            end else begin
                PreviousMonth := CalcDate('-2M', Today);
                PrevMonthLastDay := CalcDate('CM', PreviousMonth);
            end;
        end else begin
            if Period = Period::"Period-1" then begin
                PreviousMonth := CalcDate('-1M', Today);
                PrevMonthLastDay := CalcDate('FM', PreviousMonth);
            end else begin
                PreviousMonth := CalcDate('-2M', Today);
                PrevMonthLastDay := CalcDate('FM', PreviousMonth);
            end;

        end;

        PrevMonthFirstDay := 0D;  //start date always open

        /*
        //NAIKH01 26
        PreviousMonth := CALCDATE('-2M',TODAY);
        //StartDate:= CALCDATE('-CM', PreviouMonth);
        PrevMonthLastDay:= CALCDATE('CM', PreviousMonth);
        */

        //HEI.02>>
        //CompName := COPYSTR(DELCHR(CompanyInfo."Legal Entity Code",'=','!|@|#|$|%/.,_- '),1,15);
        CompName := CopyStr(DelChr(GeneralInterfaceSetup."Company Code ID", '=', '!|@|#|$|%/.,_- '), 1, 15);
        //HEI.02<<

        GetEntryNo(); //NAIKH01 New


        TrintechInterfaceSetup.Get();
        InterfaceSetup.Get(TrintechInterfaceSetup.GLTRAN);
        if not InterfaceSetup.Enabled then
            CurrReport.Quit();

        // Remove the existing line from cadency Table and move it to Cadency Archive Table
        CadencyData.Reset();
        CadencyData.SetRange("File Type", CadencyData."File Type"::SLBAL);
        if CadencyData.FindSet() then
            repeat

                CadencyDataArchive.Init();
                CadencyDataArchive.TransferFields(CadencyData);
                CadencyDataArchive."Date Archived" := Today;
                CadencyDataArchive.Insert();

                RecCadencyData.Get(CadencyData."Entry No.");
                RecCadencyData.Delete();

            until CadencyData.Next() = 0;
        //
        //HEI.06>>
        //HEI.04>>
        /*qSLVE.SETRANGE(qSLVE.Posting_Date,PrevMonthFirstDay,PrevMonthLastDay);
        qSLVE.OPEN();
        tVEEntryNo:=0;
        
        WHILE qSLVE.READ DO BEGIN
        
            tVEEntryNo:=tVEEntryNo+1;
        
            tempVE.INIT();
            tempVE."Entry No.":=tVEEntryNo;
            tempVE."Item No.":=qSLVE.Item_No;
            tempVE."Location Code":=qSLVE.Location_Code;
            tempVE."Cost Amount (Actual)":=qSLVE.Sum_Cost_Amount_Actual;
            tempVE."Cost Amount (Expected)":=qSLVE.Sum_Cost_Amount_Expected;
            tempVE.INSERT(FALSE);
        END;
        
        qSLVE.CLOSE();
        
        CLEAR(tempVE);
        CLEAR(ValueEntry);
        ValueEntry.SETAUTOCALCFIELDS();
        ValueEntry.SETRANGE("Posting Date",PrevMonthFirstDay,PrevMonthLastDay);
        
        IF ValueEntry.FINDSET(FALSE,FALSE) THEN REPEAT
            tempVE.INIT();
            tempVE.TRANSFERFIELDS(ValueEntry);
            tempVE.INSERT(FALSE);
        UNTIL ValueEntry.NEXT=0;
        //HEI.04<<
        */
        //HEI.06<<

    end;

    var
        GLAccount: Record "G/L Account";
        CompanyInfo: Record "Company Information";
        FromFile: Text[1024];
        GLSetup: Record "General Ledger Setup";
        Cnt: Integer;
        FileName: Text[1024];
        CompName: Text;
        PrevMonthLastDay: Date;
        PrevMonthFirstDay: Date;
        FilePath: Label 'SLBAL_';
        //Delimeter: ;
        Text001: Label 'Company';
        Text002: Label 'G/L Account No.';
        Text003: Label 'G/L Account Name';
        Text004: Label 'CCY1Code';
        Text005: Label 'CCY1SubLedger';
        Text006: Label 'CCY2Code';
        Text007: Label 'CCY2SubLedger';
        Text008: Label 'Period';
        Text009: Label 'Year';
        Text014: Label 'File exported successfully';
        bufferTab: Record "Cadency Value Buffer FND" temporary;
        TotalAmt: Decimal;
        Period: Option "Period-1","Period-2";
        ValueEntry: Record "Value Entry";
        GLEntry: Record "G/L Entry";
        CLEntry: Record "Cust. Ledger Entry";
        VLEntry: Record "Vendor Ledger Entry";
        TotalAmtLCY: Decimal;
        PreviousMonth: Date;
        FALedgerEntry: Record "FA Ledger Entry";
        CadencyData: Record "Cadency Data FND";
        EntryNo: Integer;
        Period1: Integer;
        Year1: Integer;

        // CadencyDataArchive: Record "Cadency Data Archive";
        RecCadencyData: Record "Cadency Data FND";

        CadencyDataArchive: Record "Cadency Data Archive FND";
        // RecCadencyData: Record "Cadency Data";

        TrintechInterfaceSetup: Record "Trintech Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        Skip_Loop: Boolean;
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        StartDate: Date;
        tempVE: Record "Value Entry" temporary;

    local procedure GetEntryNo();
    begin
        CadencyData.Reset();
        if CadencyData.FindLast() then
            EntryNo := CadencyData."Entry No." + 1
        else
            EntryNo := 1;
    end;
}

