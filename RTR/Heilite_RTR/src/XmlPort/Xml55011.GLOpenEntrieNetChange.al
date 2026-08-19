xmlport 55011 "GL Open Entrie Net Change"
{
    // BC Upgrade SHUKLP03 >> Nav old id - 50113.

    Direction = Import;
    FieldDelimiter = '<>';
    FieldSeparator = '|';
    Format = VariableText;
    Permissions = TableData "Dimension Set Entry" = rimd;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(GLEntries)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Import';
                UseTemporary = true;
                textelement(AccountNo)
                {
                }
                textelement(PostingDate1)
                {
                }
                textelement(DocNo)
                {
                }
                textelement(Description)
                {
                }
                textelement(Dim1ValueCode)
                {
                }
                textelement(Dim2ValueCode)
                {
                }
                textelement(Dim3ValueCode)
                {
                }
                textelement(Dim4ValueCode)
                {
                }
                textelement(Dim5ValueCode)
                {
                }
                textelement(Dim6ValueCode)
                {
                }
                textelement(Dim7ValueCode)
                {
                }
                textelement(Dim8ValueCode)
                {
                }
                textelement(Dim9ValueCode)
                {
                }
                textelement(Dim10ValueCode)
                {
                }
                textelement(Dim11ValueCode)
                {
                }
                textelement(Dim12ValueCode)
                {
                }
                textelement(Dim13ValueCode)
                {
                }
                textelement(Dim14ValueCode)
                {
                }
                textelement(Dim15ValueCode)
                {
                }
                textelement(Amount)
                {
                }
                textelement(ExtDocNo)
                {
                }

                trigger OnAfterInsertRecord();
                begin
                    if (JnlTemplName <> '') and (AccountNo <> '') then begin

                        if LineNo2 = 0 then begin
                            GenJnlLine.SETRANGE("Journal Template Name", CleanData(JnlTemplName));
                            GenJnlLine.SETRANGE("Journal Batch Name", CleanData(BatchName));
                            if GenJnlLine.FINDLAST then
                                LineNo2 := GenJnlLine."Line No."
                            else
                                LineNo2 := 0;
                            GenJnlLine.RESET;
                        end;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := CleanData(JnlTemplName);
                        GenJnlLine."Journal Batch Name" := CleanData(BatchName);
                        LineNo2 += 10;
                        GenJnlLine."Line No." := LineNo2;
                        GenJnlLine.VALIDATE("System-Created Entry", true);
                        GenJnlTemplate.GET(JnlTemplName);
                        GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                        GenJnlLine.VALIDATE("System-Created Entry", true);
                        GenJnlLine.VALIDATE("Account No.", AccountNo);
                        GenJnlLine.VALIDATE("Posting Date", ConvertString2Date(PostingDate1));
                        GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");
                        //GenJnlLine.VALIDATE("Bal. Account No.",BalAccTxt);
                        GenJnlLine."Document No." := DocNo;
                        GenJnlLine.VALIDATE("External Document No.", DocNo);
                        GenJnlLine.Description := COPYSTR(Description, 1, 50);
                        GenJnlLine.Quantity := 1;
                        if Amount = '' then
                            Amount := '0';
                        if AmFormatInNAV and (DecFormat = DecFormat::Comma) then
                            Amount := Convert2AmFormat(Amount);
                        if (not AmFormatInNAV) and (DecFormat = DecFormat::Dot) then
                            Amount := Convert2EurFormat(Amount);
                        EVALUATE(GenJnlLine.Amount, Amount);
                        GenJnlLine.VALIDATE(Amount);

                        GenJnlLine."Dimension Set ID" := 0;

                        intRecords += 1;
                        GenJnlLine.INSERT(true);
                        GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                        GenJnlLine."Gen. Bus. Posting Group" := '';
                        GenJnlLine."Gen. Prod. Posting Group" := '';
                        GenJnlLine."VAT Bus. Posting Group" := '';
                        GenJnlLine."VAT Prod. Posting Group" := '';
                        GenJnlLine."Bal. Gen. Bus. Posting Group" := '';
                        GenJnlLine."Bal. Gen. Prod. Posting Group" := '';
                        GenJnlLine."Bal. VAT Bus. Posting Group" := '';
                        GenJnlLine."Bal. VAT Prod. Posting Group" := '';
                        GeneralLedgerSetup.GET;
                        GeneralLedgerSetup.TESTFIELD("OPCO Dimension Code FND");
                        GeneralLedgerSetup.TESTFIELD("Capex Dimension Code FND");
                        GeneralLedgerSetup.TESTFIELD("Cost Center Dimension Code FND");
                        GeneralLedgerSetup.TESTFIELD("Shortcut Dimension 3 Code");

                        DimAdded := false;
                        DimSetEntryTmp.RESET;
                        DimSetEntryTmp.DELETEALL;

                        if (Dim1ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode1);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim1ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;
                        if (Dim2ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode2);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim2ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim3ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode3);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim3ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim4ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode4);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim4ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim5ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode5);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim5ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim6ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode6);
                            if Dim6ValueCode = '6' then
                                Dim6ValueCode := '06';
                            if Dim6ValueCode = '2' then
                                Dim6ValueCode := '02';
                            if Dim6ValueCode = '4' then
                                Dim6ValueCode := '04';
                            if Dim6ValueCode = '5' then
                                Dim6ValueCode := '05';
                            if Dim6ValueCode = '7' then
                                Dim6ValueCode := '07';
                            if Dim6ValueCode = '8' then
                                Dim6ValueCode := '08';
                            if Dim6ValueCode = '9' then
                                Dim6ValueCode := '09';
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim6ValueCode);
                            CLEAR(Dim6ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim7ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode7);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim7ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim8ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode8);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim8ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim9ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode9);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim9ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim10ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode10);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim10ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim11ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode11);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim11ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim12ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode12);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim12ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim13ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode13);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim13ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim14ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode14);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim14ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if (Dim15ValueCode <> '') then begin
                            DimSetEntryTmp.VALIDATE("Dimension Code", Dimcode15);
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", Dim15ValueCode);
                            DimSetEntryTmp.INSERT(true);
                            DimAdded := true;
                        end;

                        if DimAdded then begin
                            GenJnlLine.VALIDATE("Dimension Set ID", DimensionManagement.GetDimensionSetID(DimSetEntryTmp));
                        end;

                        GenJnlLine.VALIDATE("External Document No.", ExtDocNo);

                        GenJnlLine.MODIFY;
                    end;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Date Format in csv file"; DateFormat)
                {
                    ApplicationArea = All;
                }
                field("Decimal Format in csv file"; DecFormat)
                {
                    ApplicationArea = All;
                }
                field(JnlTemplName; JnlTemplName)
                {
                    Caption = 'Gen. Journal Template';
                    TableRelation = "Gen. Journal Template".Name;
                    ApplicationArea = All;
                }
                field(BatchName; BatchName)
                {
                    Caption = 'Gen. Journal Batch';
                    ApplicationArea = All;
                }
                field(PostingDate; PostingDate)
                {
                    Caption = 'Posting Date';
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Dimcode1; Dimcode1)
                {
                    Caption = 'Dim code 1';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode2; Dimcode2)
                {
                    Caption = 'Dim Code 2';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode3; Dimcode3)
                {
                    Caption = 'Dim code 3';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode4; Dimcode4)
                {
                    Caption = 'Dim Code 4';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode5; Dimcode5)
                {
                    Caption = 'Dim Code 5';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode6; Dimcode6)
                {
                    Caption = 'Dim Code 6';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode7; Dimcode7)
                {
                    Caption = 'Dim Code 7';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode8; Dimcode8)
                {
                    Caption = 'Dim Code 8';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode9; Dimcode9)
                {
                    Caption = 'Dim Code 9';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode10; Dimcode10)
                {
                    Caption = 'Dim Code 10';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode11; Dimcode11)
                {
                    Caption = 'Dim Code 11';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode12; Dimcode12)
                {
                    Caption = 'Dim Code 12';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode13; Dimcode13)
                {
                    Caption = 'Dim Code 13';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode14; Dimcode14)
                {
                    Caption = 'Dim Code 14';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field(Dimcode15; Dimcode15)
                {
                    Caption = 'Dim Code 15';
                    TableRelation = Dimension.Code;
                    ApplicationArea = All;
                }
                field("Recurring Journal"; RecurringJnl)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort();
    begin
        MESSAGE(STRSUBSTNO('%1 General Journal Lines have been inserted in %2 %3', intRecords, CleanData(JnlTemplName), CleanData(BatchName)));
    end;

    trigger OnPreXmlPort();
    begin
        GenSetup.GET;
        LineNo2 := 0;
    end;

    var
        GLAccount: Record "G/L Account";
        GenJnlLine: Record "Gen. Journal Line";
        DimSetEntryTmp: Record "Dimension Set Entry" temporary;
        GenSetup: Record "General Ledger Setup";
        DefDim: Record "Default Dimension";
        DimMgt: Codeunit DimensionManagement;
        DimAdded: Boolean;
        dimvalue: Record "Dimension Value";
        intRecords: Integer;
        LineNo2: Integer;
        DecFormat: Option Comma,Dot;
        DateFormat: Option "DD/MM/YY","MM/DD/YY";
        CLIENCode: Code[20];
        CODECLIENTSCode: Code[20];
        CSEGMCode: Code[20];
        CSTATUSCode: Code[20];
        I1PRODUCTCode: Code[20];
        I3PRIMPACKTYPECode: Code[20];
        I4PACKSIZECode: Code[20];
        I5SECPACKSIZECode: Code[20];
        I6RETONEWAYCode: Code[20];
        MOVTYPECode: Code[20];
        PERSONCode: Code[20];
        REGIONCode: Code[20];
        SKUCode: Code[20];
        WRITEOFFCode: Code[20];
        GenJnlTemplate: Record "Gen. Journal Template";
        JnlTemplName: Code[10];
        BatchName: Code[10];
        GenJournalBatch: Record "Gen. Journal Batch";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionManagement: Codeunit DimensionManagement;
        PostingDate: Date;
        DimensionValue: Record "Dimension Value";
        Dimcode1: Code[20];
        Dimcode2: Code[20];
        Dimcode3: Code[20];
        Dimcode4: Code[20];
        RecurringJnl: Boolean;
        Dimcode5: Code[20];
        Dimcode6: Code[20];
        Dimcode7: Code[20];
        Dimcode8: Code[20];
        Dimcode9: Code[20];
        Dimcode10: Code[20];
        Dimcode11: Code[20];
        Dimcode12: Code[20];
        Dimcode13: Code[20];
        Dimcode14: Code[20];
        Dimcode15: Code[20];

    procedure AmFormatInNAV(): Boolean;
    var
        TestDec: Decimal;
        Test: Text[30];
    begin
        TestDec := 1000;
        Test := FORMAT(TestDec);
        if STRPOS(Test, ',') = 2 then //American format in nav
            exit(true)
        else
            exit(false);
    end;

    procedure Convert2EurFormat(DecInText: Text[30]): Text[30];
    var
        TestDec: Decimal;
        Test: Text[30];
    begin
        //Convert american amount format before importing
        DecInText := DELCHR(DecInText, '=', ',');
        exit(CONVERTSTR(DecInText, '.', ','));
    end;

    procedure Convert2AmFormat(DecInText: Text[30]): Text[30];
    var
        TestDec: Decimal;
        Test: Text[30];
    begin
        //Convert european amount format before importing
        DecInText := DELCHR(DecInText, '=', '.');
        exit(CONVERTSTR(DecInText, ',', '.'));
    end;

    procedure ConvertString2Date(StringDate: Text[250]): Date;
    var
        DateValue: Date;
        YearInt: Integer;
        MonthInt: Integer;
        DayInt: Integer;
    begin
        if StringDate <> '' then begin
            if DateFormat = DateFormat::"DD/MM/YY" then begin
                EVALUATE(DayInt, COPYSTR(StringDate, 1, 2));
                EVALUATE(MonthInt, COPYSTR(StringDate, 4, 2));
            end else begin
                EVALUATE(MonthInt, COPYSTR(StringDate, 1, 2));
                EVALUATE(DayInt, COPYSTR(StringDate, 4, 2));
            end;
            if STRLEN(StringDate) = 10 then
                EVALUATE(YearInt, COPYSTR(StringDate, 7, 4))
            else
                EVALUATE(YearInt, '20' + COPYSTR(StringDate, 7, 2));

            if EVALUATE(DateValue, FORMAT(DMY2DATE(DayInt, MonthInt, YearInt))) then
                exit(DateValue);
        end;
    end;

    procedure CleanData(OldValue: Text): Text;
    begin
        exit(DELCHR(OldValue, '=', 'ï»¿'));
    end;
}

