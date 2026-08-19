report 58033 "GL TransactionsExtract Cadency"
{
    // version HEI.04

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 21.02.2019
    //   # Created new processonly Report
    // HEI.02 CHG2171515 IBM POENAB02 07.09.2022 Trintech Cadency - Company Code ID instead of Legal Entity Code
    //   # Modified code
    // HEI.03 CHG2228096 IBM KAPOOV01 13.09.2024 Balance Extract Cadency & SL BalanceMergeExtract Cadency execution times
    //   # OnPostReport(), G/L Account - OnPreDataItem(),G/L Account - OnAfterGetRecord()
    // HEI.04 CHG2262655 SAHAL01 09.12.2024 Automatic data export for control purposes
    //   # Added Code

    // BC Upgrade POENAB02: Original (HeiLite) report id 50245


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
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Cadency Transaction Export FND" = FILTER(true), "Income/Balance" = CONST("Balance Sheet"));

            trigger OnAfterGetRecord();
            begin
                //HEI.03>>
                TempGLEntry.Reset();
                TempGLEntry.SetRange(TempGLEntry."G/L Account No.", "No.");
                if TempGLEntry.FindSet() then
                    repeat

                        CadencyData.Init();
                        CadencyData."Entry No." := EntryNo;
                        CadencyData."Header Info" := HeaderInfo;

                        CadencyData."File Type" := CadencyData."File Type"::GLTRAN;

                        //CadencyData."Company Name" := COPYSTR(DELCHR(CompanyInfo."Legal Entity Code",'=','!|@|#|$|%/,_- '),1,10);  //1
                        CadencyData."Company Name" := tCompanyName;
                        CadencyData."G/L Account No." := TempGLEntry."G/L Account No.";
                        CadencyData.EffectiveDate := EndDate; //3

                        if TempGLEntry."Posting Date" <> 0D then
                            CadencyData.Date1 := TempGLEntry."Posting Date"
                        else
                            CadencyData.Date1 := 0D; //4

                        CadencyData.CCY2Code := tCCY2Code;  //5
                        CadencyData.CCY2Amount := TempGLEntry."Remaining Amount FND";  //6//COPYSTR(DELCHR(FORMAT(GLEntry."Remaining Amount"),'=','!|@|#|$|%/,'),1,20);  //6

                        if TempGLEntry."Document No." <> '' then
                            CadencyData."Document No." := CopyStr(TempGLEntry."Document No.", 1, 20)  //7
                        else
                            CadencyData."Document No." := ''; //7

                        if TempGLEntry.Description <> '' then begin
                            CadencyData.Description := TempGLEntry.Description;
                        end else
                            CadencyData.Description := '';//8

                        if TempGLEntry."Document Type" <> TempGLEntry."Document Type"::" " then
                            CadencyData."Document Type" := TempGLEntry."Document Type".AsInteger() //9
                        else
                            CadencyData."Document Type" := TempGLEntry."Document Type"::" ".AsInteger();//9

                        if TempGLEntry."External Document No." <> '' then
                            CadencyData."External Document No." := TempGLEntry."External Document No."   //10
                        else
                            CadencyData."External Document No." := '';

                        if TempGLEntry."Source No." <> '' then
                            CadencyData."Customer No." := TempGLEntry."Source No." //11
                        else
                            CadencyData."Customer No." := '';

                        if TempGLEntry."User ID" <> '' then begin
                            CadencyData."User ID" := TempGLEntry."User ID"  //12
                        end
                        else begin
                            GLRegister.SetFilter(GLRegister."From Entry No.", '<%1', TempGLEntry."Entry No.");
                            GLRegister.SetFilter(GLRegister."To Entry No.", '>%1', TempGLEntry."Entry No.");
                            if GLRegister.FindSet() then
                                CadencyData."User ID" := CopyStr(Format(GLRegister."User ID"), 1, 25);  //12
                        end;

                        Cnt += 1;
                        TotalAmt += TempGLEntry."Remaining Amount FND";

                        CadencyData."Execution Date" := Today;

                        CadencyData.Insert();

                        EntryNo := EntryNo + 1;

                    until TempGLEntry.Next() = 0;

                //HEI.03<<
                /*
                PreviouMonth := CALCDATE('-2M',TODAY);
                StartDate:= CALCDATE('-CM', PreviouMonth);
                EndDate:= CALCDATE('CM', PreviouMonth);
                */
                //HEI.03>>
                /*
                GLEntry.RESET;
                GLEntry.SETRANGE(GLEntry."G/L Account No.","No.");
                GLEntry.SETRANGE(GLEntry."Posting Date",StartDate,EndDate);
                
                GLEntry.SETRANGE(GLEntry.Open,TRUE);
                IF GLEntry.FINDSET THEN REPEAT
                
                    CadencyData.INIT;
                    CadencyData."Entry No." := EntryNo;
                    CadencyData."Header Info" := HeaderInfo;
                
                    CadencyData."File Type" := CadencyData."File Type"::GLTRAN;
                
                    //HEI.02>>
                    //CadencyData."Company Name" := COPYSTR(DELCHR(CompanyInfo."Legal Entity Code",'=','!|@|#|$|%/,_- '),1,10);  //1
                    CadencyData."Company Name" := COPYSTR(DELCHR(GeneralInterfaceSetup."Company Code ID",'=','!|@|#|$|%/,_- '),1,10);  //1
                    //HEI.02<<
                    CadencyData."G/L Account No." := COPYSTR(DELCHR(GLEntry."G/L Account No.",'=','!|@|#|$|%/,_- '),1,8);  //2
                    CadencyData.EffectiveDate := EndDate; //3
                
                    IF GLEntry."Posting Date" <> 0D THEN
                     CadencyData.Date1 := GLEntry."Posting Date"
                    ELSE
                      CadencyData.Date1 :=0D; //4
                
                    CadencyData.CCY2Code := COPYSTR(GenLegSetup."LCY Code",1,5);  //5
                    CadencyData.CCY2Amount := GLEntry."Remaining Amount";  //6//COPYSTR(DELCHR(FORMAT(GLEntry."Remaining Amount"),'=','!|@|#|$|%/,'),1,20);  //6
                
                    IF GLEntry."Document No." <> '' THEN
                     CadencyData."Document No." :=COPYSTR(GLEntry."Document No.",1,20)  //7
                    ELSE
                      CadencyData."Document No." :=''; //7
                
                    IF GLEntry.Description <> '' THEN BEGIN
                      Desc := COPYSTR(DELCHR(FORMAT(GLEntry.Description),'=','!|@|#|$|%/,_-'),1,50); //8
                      CadencyData.Description := DELCHR(Desc,'=',FORMAT(Tab))
                    END ELSE
                      CadencyData.Description :='' ;//8
                
                    IF GLEntry."Document Type" <> GLEntry."Document Type"::" " THEN
                      CadencyData."Document Type" := GLEntry."Document Type" //9
                    ELSE
                      CadencyData."Document Type" := GLEntry."Document Type"::" ";//9
                
                    IF GLEntry."External Document No." <> '' THEN
                      CadencyData."External Document No." :=COPYSTR(GLEntry."External Document No.",1,20)   //10
                    ELSE
                      CadencyData."External Document No." :='';
                
                    IF GLEntry."Source No." <> '' THEN
                      CadencyData."Customer No." :=COPYSTR(GLEntry."Source No.",1,25)//11
                    ELSE
                      CadencyData."Customer No."  :='';
                
                    IF GLEntry."User ID" <> '' THEN BEGIN
                        CadencyData."User ID" :=COPYSTR(FORMAT(GLEntry."User ID"),1,25)  //12
                    END
                    ELSE BEGIN
                        GLRegister.SETFILTER(GLRegister."From Entry No.",'<%1',GLEntry."Entry No.");
                        GLRegister.SETFILTER(GLRegister."To Entry No.",'>%1',GLEntry."Entry No.");
                        IF GLRegister.FINDSET THEN
                           CadencyData."User ID" := COPYSTR(FORMAT(GLRegister."User ID"),1,25);  //12
                    END;
                
                    Cnt+=1;
                    TotalAmt += GLEntry."Remaining Amount";
                
                    CadencyData."Execution Date" :=TODAY;
                
                    CadencyData.INSERT;
                
                    EntryNo :=EntryNo+1;
                
                UNTIL GLEntry.NEXT=0;
                *///Commented Code.
                  //HEI.03<<

            end;

            trigger OnPostDataItem();
            begin
                CadencyData.Reset();
                CadencyData.SetRange("File Type", CadencyData."File Type"::GLTRAN);
                if CadencyData.FindSet() then
                    repeat
                        CadencyData."Total Count" := Cnt;
                        CadencyData."Total Amount" := TotalAmt;
                        CadencyData.Modify();
                    until CadencyData.Next() = 0;
            end;

            trigger OnPreDataItem();
            var
                queryGLEntries: Query "GL Cadency Transactions";
                TGLEntryNo: Integer;
            begin
                //HEI.02>>
                //HeaderInfo:=(COPYSTR(DELCHR(CompanyInfo."Legal Entity Code",'=','!|@|#|$|%/.,_- '),1,8)+Day+Mnt+Yr);
                HeaderInfo := (CopyStr(DelChr(GeneralInterfaceSetup."Company Code ID", '=', '!|@|#|$|%/.,_- '), 1, 8) + Day + Mnt + Yr);
                //HEI.02<<
                GetEntryNo();  //NAIKh01 New

                // Remove the existing line from cadency Table and move it to Cadency Archive Table
                CadencyData.Reset();
                CadencyData.SetRange("File Type", CadencyData."File Type"::GLTRAN);
                if CadencyData.FindSet() then
                    repeat

                        CadencyDataArchive.Init();
                        ;
                        CadencyDataArchive.TransferFields(CadencyData);
                        CadencyDataArchive."Date Archived" := Today;
                        CadencyDataArchive.Insert();

                        RecCadencyData.Get(CadencyData."Entry No.");
                        RecCadencyData.Delete();

                    until CadencyData.Next() = 0;
                //
                //HEI.03>>
                Clear(TempGLEntry);
                queryGLEntries.SetRange(queryGLEntries.Posting_Date, StartDate, EndDate);
                queryGLEntries.Open();
                TGLEntryNo := 0;

                while queryGLEntries.Read() do begin

                    TGLEntryNo := TGLEntryNo + 1;

                    TempGLEntry.Init();
                    TempGLEntry."Entry No." := queryGLEntries.Entry_No;
                    TempGLEntry."G/L Account No." := CopyStr(DelChr(queryGLEntries.G_L_Account_No, '=', '!|@|#|$|%/,_- '), 1, 8);  //2
                    TempGLEntry."Posting Date" := queryGLEntries.Posting_Date;
                    TempGLEntry."Remaining Amount FND" := queryGLEntries.Remaining_Amount;
                    TempGLEntry."Document No." := queryGLEntries.Document_No;
                    TempGLEntry.Description := CopyStr(DelChr(Format(DelChr(queryGLEntries.Description, '=', Format(Tab))), '=', '!|@|#|$|%/,_-'), 1, 50); //8
                    TempGLEntry."Document Type" := queryGLEntries.Document_Type;
                    TempGLEntry."External Document No." := CopyStr(queryGLEntries.External_Document_No, 1, 20);
                    TempGLEntry."Source No." := CopyStr(queryGLEntries.Source_No, 1, 25);
                    TempGLEntry."User ID" := CopyStr(Format(queryGLEntries.User_ID), 1, 25);
                    TempGLEntry.Insert(false);
                end;

                queryGLEntries.Close();

                tCompanyName := CopyStr(DelChr(GeneralInterfaceSetup."Company Code ID", '=', '!|@|#|$|%/,_- '), 1, 10);
                tCCY2Code := CopyStr(GenLegSetup."LCY Code", 1, 5)
                //HEI.03<<
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
                    field(OpenPeriod; OpenPeriod)
                    {
                        Caption = 'Open Start Date';
                        ApplicationArea = All;
                        ToolTip = 'Select the Open Start Date.';
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
        //CadencyUserSetup.CheckAuthorization(80110,CurrReport.OBJECTID(TRUE)); //NAIKH01 New
        //<<HEI:CHG0248757:1:1 13/10/19 IBM.AS

        CurrReport.UseRequestPage := GuiAllowed;

        CompanyInfo.Get();
        GenLegSetup.Get();
        //HEI.02>>
        //CompanyInfo.TESTFIELD("Legal Entity Code");
        GeneralInterfaceSetup.Get();
        GeneralInterfaceSetup.TestField("Company Code ID");
        //HEI.02<<
        Tab := 9;
    end;

    trigger OnPostReport();
    var
        TrintechInterfaceSetupL: Record "Trintech Interface Setup INT";
    begin
        /*  //NAIKH01 New
        IF GUIALLOWED THEN
        //>>HEI:CHG0248757:1:1 13/10/19 IBM.AS
          BEGIN
            CadencyUserRegister.InsertCadencyUserRegister(80110);
            MESSAGE(Text014);
          END;
        //<<HEI:CHG0248757:1:1 13/10/19 IBM.AS
        */  //NAIKh01 New

        //HEI.04>>
        if not CadencyData.IsEmpty then begin
            TrintechInterfaceSetupL.Get();
            TrintechInterfaceSetupL."Last GLTRAN Completion Date" := Today;
            TrintechInterfaceSetupL.Modify(false);
        end;
        //HEI.04<<

        //HEI.03>>
        Clear(TempGLEntry);
        TempGLEntry.DeleteAll();
        //HEI.03<<

    end;

    trigger OnPreReport();
    begin
        if GlobalLanguage <> 1036 then begin
            if OpenPeriod then begin
                StartDate := 0D;
                PreviouMonth := CalcDate('-1M', Today);
            end else begin
                PreviouMonth := CalcDate('-1M', Today);
                StartDate := CalcDate('-CM', PreviouMonth);
            end;
            EndDate := CalcDate('CM', PreviouMonth);
        end else begin
            if OpenPeriod then begin
                StartDate := 0D;
                PreviouMonth := CalcDate('-1M', Today);
            end else begin
                PreviouMonth := CalcDate('-1M', Today);
                StartDate := CalcDate('-FM', PreviouMonth);
            end;
            EndDate := CalcDate('FM', PreviouMonth);
        end;
        Day := CopyStr(Format(Date2DMY(EndDate, 1)), 1, 2);
        Mnt := CopyStr(Format(Date2DMY(EndDate, 2)), 1, 2);
        Yr := CopyStr(Format(Date2DMY(EndDate, 3)), 1, 4);

        TrintechInterfaceSetup.Get();
        InterfaceSetup.Get(TrintechInterfaceSetup.GLTRAN);
        if not InterfaceSetup.Enabled then
            CurrReport.Quit();
    end;

    var
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        CompanyInfo: Record "Company Information";
        GenLegSetup: Record "General Ledger Setup";
        Cnt: Integer;
        FilePath: Label 'GLTRAN_';
        Delimeter: Label ',';
        Text001: Label 'Company';
        Text002: Label 'G/L Account No.';
        Text003: Label 'EffectiveDate';
        Text004: Label 'Date1';
        Text005: Label 'CCY2Code';
        Text006: Label 'CCY2Amount';
        Text007: Label 'Document No';
        Text008: Label 'Description';
        Text009: Label 'Document Type';
        Text010: Label 'External Document No.';
        Text011: Label 'Customer No';
        Text012: Label 'User ID';
        Text013: Label 'FOOTER';
        TotalAmt: Decimal;
        StartDate: Date;
        EndDate: Date;
        Text014: Label 'File exported successfully';
        GLRegister: Record "G/L Register";
        Day: Text;
        Mnt: Text;
        Yr: Text;
        OpenPeriod: Boolean;
        PreviouMonth: Date;
        StartDate1: Date;
        EndDate1: Date;
        CadencyData: Record "Cadency Data FND";
        HeaderInfo: Text[50];
        EntryNo: Integer;

        // CadencyDataArchive: Record "Cadency Data Archive";
        RecCadencyData: Record "Cadency Data FND";

        CadencyDataArchive: Record "Cadency Data Archive FND";
        // RecCadencyData: Record "Cadency Data";

        TrintechInterfaceSetup: Record "Trintech Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        Tab: Char;
        Desc: Text[50];
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        TempGLEntry: Record "G/L Entry" temporary;
        tCompanyName: Text[250];
        tCCY2Code: Text[250];

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

