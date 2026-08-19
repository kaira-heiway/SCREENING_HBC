xmlport 55007 "Import BAH Bank BNS"
{
    //BC Upgrade GUNREM01 Old ID-50031
    // version HEI.02

    // HEI.01 PBA RTRGAP06 Bahamas Bank statement Import, IBM.NAIKH01, 30.01.2019
    //   #Created new XML POrt based on the new file format
    // HEI.02 Bugfixing BA IBM NASTAA02 08.04.2019 # Bugfixing Bahamas
    //   # Debit and Credit need to have the opposite sign in Bank Acc. Reconciliation Line

    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'DataImp';
                UseTemporary = true;
                textelement(ImportLine)
                {
                }

                trigger OnAfterInsertRecord();
                var
                    ImportCol: array[10] of Text;
                    i: Integer;
                    NextLineNo: Integer;
                    "----": Integer;
                    TransDate: Date;
                    Amt: Decimal;
                    Year: Integer;
                    Month: Integer;
                    Day: Integer;
                    BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                    DrAmt: Decimal;
                    CrAmt: Decimal;
                    Desc: Text[500];
                begin
                    LineNo += 1;
                    if LineNo = 1 then
                        currXMLport.SKIP;
                    for i := 1 to 6 do begin
                        ImportCol[i] := GetString(i, ImportLine);
                    end;
                    BankAccReconciliationLine.SETRANGE("Statement Type", ToBankAccReconciliation."Statement Type");
                    BankAccReconciliationLine.SETRANGE("Bank Account No.", ToBankAccReconciliation."Bank Account No.");
                    BankAccReconciliationLine.SETRANGE("Statement No.", ToBankAccReconciliation."Statement No.");
                    if BankAccReconciliationLine.FINDLAST then
                        NextLineNo := BankAccReconciliationLine."Statement Line No." + 10000
                    else
                        NextLineNo := 10000;
                    //<<NAIKH01
                    //IF Option = 1 THEN BEGIN
                    EVALUATE(Month, GetStringForDate(1, ImportCol[1]));
                    EVALUATE(Day, GetStringForDate(2, ImportCol[1]));
                    EVALUATE(Year, GetStringForDate(3, ImportCol[1]));

                    TransDate := DMY2DATE(Day, Month, Year);
                    if ImportCol[3] <> '' then
                        EVALUATE(CrAmt, ImportCol[3]);
                    if ImportCol[4] <> '' then
                        EVALUATE(DrAmt, ImportCol[4]);

                    Desc := DELCHR(ImportCol[6], '<>', '"');
                    Desc := COPYSTR(Desc, 1, 50); //NAIKh01

                    CLEAR(BankAccReconciliationLine);
                    BankAccReconciliationLine.INIT;
                    BankAccReconciliationLine."Statement Type" := ToBankAccReconciliation."Statement Type";
                    BankAccReconciliationLine."Bank Account No." := ToBankAccReconciliation."Bank Account No.";
                    BankAccReconciliationLine."Statement No." := ToBankAccReconciliation."Statement No.";
                    BankAccReconciliationLine."Statement Line No." := NextLineNo;
                    BankAccReconciliationLine.INSERT(true);
                    BankAccReconciliationLine.VALIDATE("Transaction Date", TransDate);
                    BankAccReconciliationLine.VALIDATE("Transaction ID", ImportCol[2]);
                    if ImportCol[3] <> '' then
                        //HEI.02>>
                        //BankAccReconciliationLine.VALIDATE("Statement Amount",CrAmt);
                        BankAccReconciliationLine.VALIDATE("Statement Amount", -CrAmt);
                    //HEI.02<<
                    if ImportCol[4] <> '' then
                        //HEI.02>>
                        //BankAccReconciliationLine.VALIDATE("Statement Amount",-DrAmt);
                        BankAccReconciliationLine.VALIDATE("Statement Amount", DrAmt);
                    //HEI.02<<
                    BankAccReconciliationLine.VALIDATE("Transaction Text", ImportCol[5]);
                    BankAccReconciliationLine.VALIDATE(Description, Desc);
                    //BankAccReconciliationLine.VALIDATE(Type,BankAccReconciliationLine.Type::"Bank Account Ledger Entry");
                    BankAccReconciliationLine.MODIFY(true);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control55001)
                {
                    field(Date1; DateOption)
                    {
                        Caption = 'Date Format';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    var
        ToBankAccReconciliation: Record "Bank Acc. Reconciliation";
        LineNo: Integer;
        DateOption: Option "MM/DD/YYYY","YYYY/MM/DD";
        Option: Integer;

    procedure SetTemplate(var BankAccReconciliationSrc: Record "Bank Acc. Reconciliation");
    begin
        ToBankAccReconciliation := BankAccReconciliationSrc;
    end;

    procedure GetString(Number: Integer; String: Text): Text[200];
    var
        i: Integer;
        EndPos: Integer;
        SubString: Text[200];
        TAB: Char;
    begin
        TAB := ',';
        i := 1;
        while i <= Number do begin
            i += 1;
            EndPos := STRPOS(String, FORMAT(TAB));
            if EndPos > 0 then begin
                SubString := COPYSTR(String, 1, EndPos - 1);
                String := DELSTR(String, 1, EndPos);
            end else
                SubString := String;
        end;
        exit(SubString);
    end;

    procedure GetStringForDate(Number: Integer; String: Text): Text[200];
    var
        i: Integer;
        EndPos: Integer;
        SubString: Text[200];
        TAB: Char;
    begin
        TAB := '/';
        i := 1;
        while i <= Number do begin
            i += 1;
            EndPos := STRPOS(String, FORMAT(TAB));
            if EndPos > 0 then begin
                SubString := COPYSTR(String, 1, EndPos - 1);
                String := DELSTR(String, 1, EndPos);
            end else
                SubString := String;
        end;
        exit(SubString);
    end;

    procedure SetDateFormat(OP: Integer);
    begin
        Option := OP;
    end;
}

