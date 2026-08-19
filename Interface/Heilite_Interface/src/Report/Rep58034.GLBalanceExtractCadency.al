report 58034 "GL Balance Extract Cadency"
{
    // version HEI.04

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 21.02.2019
    //   # Created new processonly Report
    // 
    // Remove the Cadency Transaction Export=CONST(Yes),Direct Posting=CONST(No)) from the DataItemTableView
    // 
    // HEI.02 CHG2171515 IBM POENAB02 07.09.2022 Trintech Cadency - Company Code ID instead of Legal Entity Code
    //   # Modified code
    // 
    // HEI.03 CHG2228096 IBM KAPOOV01 03.10.2024 Balance Extract Cadency & SL BalanceMergeExtract Cadency execution times
    //   # OnPostReport(), G/L Account - OnPreDataItem(),G/L Account - OnAfterGetRecord()
    // HEI.04 CHG2262655 SAHAL01 09.12.2024 Automatic data export for control purposes
    //   # Added Code

    // BC Upgrade POENAB02: Original (HeiLite) report id 50246


    // BC Upgrade MISHRS14 >>
    // Changed table name to "Cadency Data FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<


    // BC Upgrade PATELP08>>
    // Changed name of table from "Cadency Data Archive" to "Cadency Data Archive FND"
    // BC Upgrade PATELP08<<


    Permissions = TableData "G/L Account" = rimd,
                  TableData "G/L Entry" = rimd;
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            CalcFields = "Balance at Date", "Credit Amount", "Debit Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
            DataItemTableView = WHERE("Account Type" = CONST(Posting), "Income/Balance" = FILTER("Balance Sheet"), Blocked = CONST(false));

            trigger OnAfterGetRecord();
            var
                LastGLEntryNo: Integer;
            begin
                //<< NAIKH01 New Skip the Non Posted GL Account
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", "No.");
                if GLEntry.IsEmpty() then
                    CurrReport.Skip();
                //<< NAIKH01

                CreditAmtLocalCurr := 0;
                DebitAmtLocalCurr := 0;
                CreditAmtReportCurr := 0;
                DebitAmtReportCurr := 0;
                Cnt := 0;
                Cnt1 := 0;

                CadencyData.Init();
                CadencyData."Entry No." := EntryNo;
                CadencyData."File Type" := CadencyData."File Type"::GLBAL;

                //HEI.02>>
                //CadencyData."Company Name" := COPYSTR(DELCHR(CompanyInfo."Legal Entity Code",'=','!|@|#|$|%/,_-. '),1,15); //1
                CadencyData."Company Name" := CopyStr(DelChr(GeneralInterfaceSetup."Company Code ID", '=', '!|@|#|$|%/,_-. '), 1, 15); //1
                //HEI.02<<
                CadencyData."G/L Account No." := CopyStr(DelChr("G/L Account"."No.", '=', '!|@|#|$|%/,_-'), 1, 8); //2
                CadencyData."G/L Account Name" := CopyStr(DelChr("G/L Account".Name, '=', '!|@|#|$|%/,_-'), 1, 50); //3
                CadencyData.CCY1Code := 'EUR'; //4
                CadencyData.CCY1GLEndBalance := 0.0;//5
                CadencyData.CCY2Code := CopyStr(GenLegSetup."LCY Code", 1, 5);//6
                CadencyData.CCY2GLEndBalance := "G/L Account"."Balance at Date";  // CopyStr(DelChr(Format("G/L Account"."Balance at Date"),'=','!|@|#|$|%/,'),1,20);//7

                //HEI.03>>
                //LastGLEntryNo := 0;
                TempGLEntry.Reset();
                TempGLEntry.SetRange(TempGLEntry."G/L Account No.", "G/L Account"."No.");//HEI.03
                if TempGLEntry.FindSet() then
                    repeat
                        CreditAmtLocalCurr += TempGLEntry."Credit Amount";
                        DebitAmtLocalCurr += TempGLEntry."Debit Amount";
                        CreditAmtReportCurr += TempGLEntry."Add.-Currency Credit Amount";
                        DebitAmtReportCurr += TempGLEntry."Add.-Currency Debit Amount";
                        CCY3Amt1 += TempGLEntry.Amount;
                        CurrCode1 := TempGLEntry."Currency Code FND";
                    /*  IF (LastGLEntryNo< TempGLEntry."Transaction No.") THEN BEGIN
                         LastGLEntryNo := TempGLEntry."Transaction No.";
                      END;*/
                    until TempGLEntry.Next() = 0;
                GLEntry.Reset();
                GLEntry.SetRange(GLEntry."G/L Account No.", "G/L Account"."No.");
                GLEntry.SetRange(GLEntry."Posting Date", StartDate, EndDate);
                Cnt := GLEntry.Count;

                //HEI.03<<

                //HEI.03>>
                /*
                GLEntry.RESET;
                GLEntry.SETRANGE(GLEntry."G/L Account No.","No.");
                GLEntry.SETRANGE(GLEntry."Posting Date",StartDate,EndDate);
                IF GLEntry.FINDSET THEN REPEAT
                
                   CreditAmtLocalCurr += GLEntry."Credit Amount";
                   DebitAmtLocalCurr += GLEntry."Debit Amount";
                   CreditAmtReportCurr += GLEntry."Add.-Currency Credit Amount";
                   DebitAmtReportCurr += GLEntry."Add.-Currency Debit Amount";
                   CCY3Amt1 += GLEntry.Amount;
                   CurrCode1 := GLEntry."Currency Code";
                   Cnt +=1;
                UNTIL GLEntry.NEXT =0;
                *///Commented Code.
                  //HEI.03<<
                BnkAccLedEntry.Reset();
                //HEI.03>>
                //BnkAccLedEntry.SETRANGE(BnkAccLedEntry."Entry No.",GLEntry."Entry No."); //Commented code HEI.03
                //BnkAccLedEntry.SETRANGE(BnkAccLedEntry."Entry No.",LastGLEntryNo);
                BnkAccLedEntry.SetRange(BnkAccLedEntry."Entry No.", TempGLEntry."Entry No.");

                //HEI.03<<
                BnkAccLedEntry.SetRange(BnkAccLedEntry."Posting Date", StartDate, EndDate);
                if BnkAccLedEntry.FindSet() then
                    repeat
                        BLECredit += BnkAccLedEntry."Credit Amount";
                        BLEDebit += BnkAccLedEntry."Debit Amount";
                        CCY3Amt2 += BnkAccLedEntry.Amount;
                        CurrCode2 := BnkAccLedEntry."Currency Code";
                        Cnt1 += 1;
                    until BnkAccLedEntry.Next() = 0;


                // CCY3Code
                if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::" " then
                    CadencyData.CCY3Code := ''  //8
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"Bank Ledger Entry" then
                    CadencyData.CCY3Code := CopyStr(DelChr(Format(CurrCode2), '=', '!|@|#|$|%/,'), 1, 20)//8
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"G/L Entry" then
                    CadencyData.CCY3Code := CopyStr(DelChr(Format(CurrCode1), '=', '!|@|#|$|%/,'), 1, 20);//8


                // CCY3GLEndBalance
                if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::" " then
                    CadencyData.CCY3GLEndBalance := '' // 0.0  NAIKH01
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"Bank Ledger Entry" then begin
                    if CCY3Amt2 <> 0 then
                        CadencyData.CCY3GLEndBalance := Format(CCY3Amt2)   // COPYSTR(DELCHR(FORMAT(CCY3Amt2),'=','!|@|#|$|%/,'),1,20)
                    else
                        CadencyData.CCY3GLEndBalance := ''
                end
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"G/L Entry" then begin
                    if CCY3Amt1 <> 0 then
                        CadencyData.CCY3GLEndBalance := Format(CCY3Amt1) // COPYSTR(DELCHR(FORMAT(CCY3Amt1),'=','!|@|#|$|%/,'),1,20); //9
                    else
                        CadencyData.CCY3GLEndBalance := ''
                end;


                Evaluate(Period1, (CopyStr(Format(Date2DMY(EndDate, 2)), 1, 2)));
                CadencyData.Period := Period1;  //COPYSTR(FORMAT(DATE2DMY(EndDate,2)),1,2); //10

                Evaluate(Year1, (CopyStr(Format(Date2DMY(EndDate, 3)), 1, 4)));
                CadencyData.Year := Year1; //11

                CadencyData.CCY1NetDebits := DebitAmtReportCurr; //  COPYSTR(DELCHR(FORMAT(DebitAmtReportCurr),'=','!|@|#|$|%/,'),1,20) + FORMAT(TAB);  // CCY1NetDebits //12
                CadencyData.CCY2NetDebits := DebitAmtLocalCurr; // COPYSTR(DELCHR(FORMAT(DebitAmtLocalCurr),'=','!|@|#|$|%/,'),1,20) + FORMAT(TAB);   // CCY2NetDebits//13

                // CCY3 NetDebits
                if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::" " then
                    CadencyData.CCY3NetDebits := 0.0
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"Bank Ledger Entry" then
                    CadencyData.CCY3NetDebits := BLEDebit //  COPYSTR(DELCHR(FORMAT(BLEDebit),'=','!|@|#|$|%/,'),1,20) + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"G/L Entry" then
                    CadencyData.CCY3NetDebits := DebitAmtLocalCurr; //  COPYSTR(DELCHR(FORMAT(DebitAmtLocalCurr),'=','!|@|#|$|%/,'),1,20) + FORMAT(TAB); //14

                CadencyData.CCY1NetCredits := CreditAmtReportCurr; // COPYSTR(DELCHR(FORMAT(CreditAmtReportCurr),'=','!|@|#|$|%/,'),1,20) + FORMAT(TAB); // CCY1NetCredits //15
                CadencyData.CCY2NetCredits := CreditAmtLocalCurr; // COPYSTR(DELCHR(FORMAT(CreditAmtLocalCurr),'=','!|@|#|$|%/,'),1,20) + FORMAT(TAB);  // CCY2NetCredits //16

                //  CCY3 NetCredits
                if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::" " then
                    CadencyData.CCY3NetCredits := 0.0
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"Bank Ledger Entry" then
                    CadencyData.CCY3NetCredits := BLECredit //  COPYSTR(DELCHR(FORMAT(BLECredit),'=','!|@|#|$|%/,'),1,20) + FORMAT(TAB)
                else if "G/L Account"."Cadency Bank Export FND" = "G/L Account"."Cadency Bank Export FND"::"G/L Entry" then
                    CadencyData.CCY3NetCredits := CreditAmtLocalCurr; // COPYSTR(DELCHR(FORMAT(CreditAmtLocalCurr),'=','!|@|#|$|%/,'),1,20) + FORMAT(TAB);  //17

                CadencyData.CCY1TransCount := Cnt; // + FORMAT(TAB);  //CCY1TransCount  //18
                CadencyData.CCY2TransCount := Cnt; // + FORMAT(TAB);  //CCY2TransCount//19
                CadencyData.CCY3TransCount := Cnt1;  //CCY3TransCount  //20

                CadencyData."Execution Date" := Today;

                CadencyData.Insert();

                EntryNo := EntryNo + 1;

            end;

            trigger OnPreDataItem();
            begin
                //NAIKH01 26
                /*
                PreviouMonth := CALCDATE('-2M',TODAY);
                StartDate:= CALCDATE('-CM', PreviouMonth);
                EndDate:= CALCDATE('CM', PreviouMonth);
                */
                "G/L Account".SetFilter("No.", '<%1', '79000000'); //Adrian new - hardcode filter as requested by Erwin 30.03.16
                "G/L Account".SetRange("G/L Account"."Date Filter", StartDate, EndDate);

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
                        ApplicationArea = All;
                        ToolTip = 'Select the period for which the data needs to be extracted';
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
        //CadencyUserSetup.CheckAuthorization(80116,CurrReport.OBJECTID(TRUE));  //NAIKH01 new
        //<<HEI:CHG0248757:1:1 13/10/19 IBM.AS

        CompanyInfo.Get();
        GenLegSetup.Get();
        //HEI.02>>
        //CompanyInfo.TESTFIELD("Legal Entity Code");
        GeneralInterfaceSetup.Get();
        GeneralInterfaceSetup.TestField("Company Code ID");
        //HEI.02<<
    end;

    trigger OnPostReport();
    var
        TrintechInterfaceSetupL: Record "Trintech Interface Setup INT";
    begin
        /*  NAIKH01 New
        IF GUIALLOWED THEN
        //>>HEI:CHG0248757:1:1 13/10/19 IBM.AS
          BEGIN
            CadencyUserRegister.InsertCadencyUserRegister(80116);
            MESSAGE(Text019);
          END;
        //<<HEI:CHG0248757:1:1 13/10/19 IBM.AS
        */ //NAIKH01 New

        //HEI.04>>
        if not CadencyData.IsEmpty then begin
            TrintechInterfaceSetupL.Get();
            TrintechInterfaceSetupL."Last GLBAL Completion Date" := Today;
            TrintechInterfaceSetupL.Modify(false);
        end;
        //HEI.04<<

        //HEI.03>>
        TempGLEntry.DeleteAll();
        Clear(TempGLEntry);
        //HEI.03<<

    end;

    trigger OnPreReport();
    var
        GLCadencyQuery: Query "GL Candency GLE";
        TGLEntryNo: Integer;
    begin
        if GlobalLanguage <> 1036 then begin
            if Period = Period::"Period-1" then begin
                PreviouMonth := CalcDate('-1M', Today);
                StartDate := CalcDate('-CM', PreviouMonth);
                EndDate := CalcDate('CM', PreviouMonth);
            end else begin
                PreviouMonth := CalcDate('-2M', Today);
                StartDate := CalcDate('-CM', PreviouMonth);
                EndDate := CalcDate('CM', PreviouMonth);
            end;
        end else begin
            if Period = Period::"Period-1" then begin
                PreviouMonth := CalcDate('-1M', Today);
                StartDate := CalcDate('-FM', PreviouMonth);
                EndDate := CalcDate('FM', PreviouMonth);
            end else begin
                PreviouMonth := CalcDate('-2M', Today);
                StartDate := CalcDate('-FM', PreviouMonth);
                EndDate := CalcDate('FM', PreviouMonth);
            end;
        end;

        GetEntryNo();

        TrintechInterfaceSetup.Get();
        InterfaceSetup.Get(TrintechInterfaceSetup.GLTRAN);
        if not InterfaceSetup.Enabled then
            CurrReport.Quit();

        // Remove the existing line from cadency Table and move it to Cadency Archive Table
        CadencyData.Reset();
        CadencyData.SetRange("File Type", CadencyData."File Type"::GLBAL);
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
        //HEI.03>>
        Clear(TempGLEntry);
        GLCadencyQuery.SetRange(GLCadencyQuery.Posting_Date, StartDate, EndDate);
        GLCadencyQuery.SetFilter(GLCadencyQuery.G_L_Account_No, '<%1', '79000000');
        GLCadencyQuery.Open();
        TGLEntryNo := 0;

        while GLCadencyQuery.Read() do begin

            TGLEntryNo := TGLEntryNo + 1;

            TempGLEntry.Init();
            //TempGLEntry."Entry No." := TGLEntryNo;
            TempGLEntry."Transaction No." := GLCadencyQuery.Max_Entry_No;
            TempGLEntry."G/L Account No." := GLCadencyQuery.G_L_Account_No;
            TempGLEntry."Credit Amount" := GLCadencyQuery.Sum_Credit_Amount;
            TempGLEntry."Debit Amount" := GLCadencyQuery.Sum_Debit_Amount;
            TempGLEntry."Add.-Currency Credit Amount" := GLCadencyQuery.Sum_Add_Currency_Credit_Amount;
            TempGLEntry."Add.-Currency Debit Amount" := GLCadencyQuery.Sum_Add_Currency_Debit_Amount;
            TempGLEntry.Amount := GLCadencyQuery.Sum_Amount;
            TempGLEntry."Currency Code FND" := GLCadencyQuery.Currency_Code;
            TempGLEntry."Entry No." := GLCadencyQuery.Max_Entry_No;
            TempGLEntry.Insert(false);
        end;

        GLCadencyQuery.Close();
        //HEI.03<<
    end;

    var
        GLEntry: Record "G/L Entry";
        CompanyInfo: Record "Company Information";
        FromFile: Text[1024];
        GenLegSetup: Record "General Ledger Setup";
        Cnt: Integer;
        FilePath: Label 'GLBAL_';
        Delimeter: Label ',';
        FileName: Text[1024];
        Text001: Label 'CompanyName';
        Text002: Label 'G/LAccountNo.';
        Text003: Label 'G/LName';
        Text004: Label 'CCY1Code';
        Text005: Label 'CCY1GLEndBalance';
        Text006: Label 'CCY2Code';
        Text007: Label 'CCY2GLEndBalance';
        Text020: Label 'CCY3Code';
        Text021: Label 'CCY3GLEndBalance';
        Text008: Label 'Period';
        Text009: Label 'Year';
        Text010: Label 'CCY1NetDebits';
        Text011: Label 'CCY2NetDebits';
        Text012: Label 'CCY3NetDebits';
        Text013: Label 'CCY1NetCredits';
        Text014: Label 'CCY2NetCredits';
        TotalAmt: Decimal;
        PostDate: Text;
        MonthBefore: Date;
        CreditAmtLocalCurr: Decimal;
        DebitAmtLocalCurr: Decimal;
        Text015: Label 'CCY3NetCredits';
        Text016: Label 'CCY1TransCount';
        Text017: Label 'CCY2TransCount';
        CreditAmtReportCurr: Decimal;
        DebitAmtReportCurr: Decimal;
        Period: Option "Period-1","Period-2";
        StartDate: Date;
        EndDate: Date;
        Lastyear: Date;
        BnkAccLedEntry: Record "Bank Account Ledger Entry";
        BLECredit: Decimal;
        BLEDebit: Decimal;
        Cnt1: Integer;
        Text018: Label 'CCY3TransCount';
        Text019: Label 'File exported successfully';
        CCY3Amt1: Decimal;
        CCY3Amt2: Decimal;
        CurrCode1: Code[20];
        CurrCode2: Code[20];
        PreviouMonth: Date;
        CadencyData: Record "Cadency Data FND";
        Period1: Integer;
        Year1: Integer;
        EntryNo: Integer;

        // CadencyDataArchive: Record "Cadency Data Archive";
        RecCadencyData: Record "Cadency Data FND";

        CadencyDataArchive: Record "Cadency Data Archive FND";
        // RecCadencyData: Record "Cadency Data";

        TrintechInterfaceSetup: Record "Trintech Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempGLEntry: Record "G/L Entry" temporary;

    local procedure GetEntryNo();
    begin
        CadencyData.Reset();
        CadencyData.SetAutoCalcFields();   //HEI.03
        if CadencyData.FindLast() then
            EntryNo := CadencyData."Entry No." + 1
        else
            EntryNo := 1;
    end;
}

