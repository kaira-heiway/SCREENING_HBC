xmlport 55010 "Import BAH Bank FCIB"
{
    // version HEI.02

    // SOICAD import Panama Bank Trans
    // HEI.02 Bugfixing BA IBM NASTAA02 08.04.2019 # Bugfixing Bahamas
    //   # Debit and Credit need to have the opposite sign in Bank Acc. Reconciliation Line

    // BC Upgrade SHUKLP03 >> 
    // Blocked Type field because this is not used in BC anymore and has been removed from the table.
    // Nav old id 50035.
    // BC Upgrade SHUKLP03 <<

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
                    DebitAmount: Decimal;
                    CreditAmount: Decimal;
                    TransDate: Date;
                    Year: Integer;
                    Month: Integer;
                    Day: Integer;
                    BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                begin
                    LineNo += 1;
                    if LineNo < 5 then
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
                    /*
                    EVALUATE(Year,COPYSTR(ImportCol[1],7,4));
                    EVALUATE(Month,COPYSTR(ImportCol[1],4,2));
                    EVALUATE(Day,COPYSTR(ImportCol[1],1,2));
                    TransDate := DMY2DATE(Day,Month,Year);
                    */
                    EVALUATE(Year, GetStringForDate(3, ImportCol[1]));
                    EVALUATE(Month, GetStringForDate(2, ImportCol[1]));
                    EVALUATE(Day, GetStringForDate(1, ImportCol[1]));

                    TransDate := DMY2DATE(Day, Month, Year);

                    EVALUATE(DebitAmount, ImportCol[4], 9);
                    EVALUATE(CreditAmount, ImportCol[5], 9);
                    CLEAR(BankAccReconciliationLine);
                    BankAccReconciliationLine.INIT;
                    BankAccReconciliationLine."Statement Type" := ToBankAccReconciliation."Statement Type";
                    BankAccReconciliationLine."Bank Account No." := ToBankAccReconciliation."Bank Account No.";
                    BankAccReconciliationLine."Statement No." := ToBankAccReconciliation."Statement No.";
                    BankAccReconciliationLine."Statement Line No." := NextLineNo;
                    BankAccReconciliationLine.INSERT(true);
                    BankAccReconciliationLine.VALIDATE("Transaction Date", TransDate);
                    // BankAccReconciliationLine.VALIDATE(Type, BankAccReconciliationLine.Type::"Bank Account Ledger Entry");  // BC Upgrade SHUKLP03 << Blocked because Type field is not used in BC anymore and has been removed from the table.
                    if DebitAmount <> 0 then
                        //HEI.02>>
                        //BankAccReconciliationLine.VALIDATE("Statement Amount",DebitAmount);
                        BankAccReconciliationLine.VALIDATE("Statement Amount", -DebitAmount);
                    //HEI.02<<
                    if CreditAmount <> 0 then
                        //HEI.02>>
                        //BankAccReconciliationLine.VALIDATE("Statement Amount",-CreditAmount);
                        BankAccReconciliationLine.VALIDATE("Statement Amount", CreditAmount);
                    //HEI.02<<
                    BankAccReconciliationLine.VALIDATE("Transaction Text", ImportCol[2] + ImportCol[3]);
                    BankAccReconciliationLine.MODIFY(true);

                end;
            }
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

    var
        ToBankAccReconciliation: Record "Bank Acc. Reconciliation";
        LineNo: Integer;

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
}

