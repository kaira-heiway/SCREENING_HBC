xmlport 55008 "Import BAH Bank CITI"
{
    //BC Upgrade GUNREM01 Old ID-50032
    // version OK

    // SOICAD import Panama Bank Trans

    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    // Format = FixedText; //BC Upgrade GUNREM01 blocked
    Format = VariableText; //BC Upgrade GUNREM01 added 
    PreserveWhiteSpace = true;
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
                    Width = 1000;
                }

                trigger OnAfterInsertRecord();
                var
                    i: Integer;
                    NextLineNo: Integer;
                    "----": Integer;
                    TransDate: Date;
                    Amt: Decimal;
                    Year: Integer;
                    Month: Integer;
                    Day: Integer;
                    BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                    DC: Text;
                begin
                    LineNo += 1;

                    for i := 19 to 23 do begin
                        ImportCol[i] := GetString(i, ImportLine);
                    end;

                    if ImportCol[19] <> '' then begin
                        EVALUATE(Year, COPYSTR(ImportCol[19], 7, 4));
                        EVALUATE(Month, COPYSTR(ImportCol[19], 1, 2));
                        EVALUATE(Day, COPYSTR(ImportCol[19], 4, 2));
                        TransDate := DMY2DATE(Day, Month, Year);
                    end;

                    if ImportCol[20] <> '' then
                        EVALUATE(Amt, ImportCol[20]);

                    if (ImportCol[19] = '') and (ImportCol[20] = '') and (ImportCol[22] = '') and (ImportCol[23] = '') then
                        currXMLport.SKIP;

                    BankAccReconciliationLine.RESET;
                    BankAccReconciliationLine.SETRANGE("Statement Type", ToBankAccReconciliation."Statement Type");
                    BankAccReconciliationLine.SETRANGE("Bank Account No.", ToBankAccReconciliation."Bank Account No.");
                    BankAccReconciliationLine.SETRANGE("Statement No.", ToBankAccReconciliation."Statement No.");
                    if BankAccReconciliationLine.FINDLAST then
                        NextLineNo := BankAccReconciliationLine."Statement Line No." + 10000
                    else
                        NextLineNo := 10000;

                    CLEAR(BankAccReconciliationLine);
                    BankAccReconciliationLine.INIT;
                    BankAccReconciliationLine."Statement Type" := ToBankAccReconciliation."Statement Type";
                    BankAccReconciliationLine."Bank Account No." := ToBankAccReconciliation."Bank Account No.";
                    BankAccReconciliationLine."Statement No." := ToBankAccReconciliation."Statement No.";
                    BankAccReconciliationLine."Statement Line No." := NextLineNo;
                    BankAccReconciliationLine.INSERT(true);

                    BankAccReconciliationLine.VALIDATE("Transaction Date", TransDate);
                    // BankAccReconciliationLine.VALIDATE(Type, BankAccReconciliationLine.Type::"Bank Account Ledger Entry");//BC Upgrade GUNREM01 Blocked-Type field is missing
                    BankAccReconciliationLine.VALIDATE(Description, ImportCol[22]);
                    BankAccReconciliationLine."Additional Transaction Info" := ImportCol[23];
                    BankAccReconciliationLine.VALIDATE("Statement Amount", Amt);

                    BankAccReconciliationLine.MODIFY(true);
                    /*
                    MESSAGE(ImportCol[1]);
                    MESSAGE(ImportCol[2]);
                    MESSAGE(ImportCol[3]);
                    MESSAGE(ImportCol[4]);
                    MESSAGE(ImportCol[5]);
                    MESSAGE(ImportCol[6]);
                    MESSAGE(ImportCol[7]);
                    MESSAGE(ImportCol[8]);
                    MESSAGE(ImportCol[9]);
                    MESSAGE(ImportCol[10]);
                    */

                    /*
                    WHILE STRPOS(ImportLine,TxtSep) > 0 DO
                      ImportLine := DELSTR(ImportLine,STRPOS(ImportLine,TxtSep)) + '^' + COPYSTR(ImportLine,STRPOS(ImportLine,TxtSep) + STRLEN(TxtSep));
                    LineNo += 1;
                    ERROR(ImportLine);
                    */
                    /*
                    IF LineNo < 2 THEN
                      currXMLport.SKIP;
                    
                    IF COPYSTR(ImportLine,1,2) <> '03' THEN
                      currXMLport.SKIP;
                    BankAccReconciliationLine.SETRANGE("Statement Type",ToBankAccReconciliation."Statement Type");
                    BankAccReconciliationLine.SETRANGE("Bank Account No.",ToBankAccReconciliation."Bank Account No.");
                    BankAccReconciliationLine.SETRANGE("Statement No.",ToBankAccReconciliation."Statement No.");
                    IF BankAccReconciliationLine.FINDLAST THEN
                      NextLineNo := BankAccReconciliationLine."Statement Line No." + 10000
                    ELSE
                      NextLineNo := 10000;
                    //03  18/06/25008      1894510C     9296926566845
                    EVALUATE(Month,COPYSTR(ImportLine,8,2));
                    EVALUATE(Day,COPYSTR(ImportLine,11,2));
                    EVALUATE(Year,'20' + COPYSTR(ImportLine,5,2));
                    TransDate := DMY2DATE(Day,Month,Year);
                    EVALUATE(Amt,COPYSTR(ImportLine,16,13));
                    DC := COPYSTR(ImportLine,29,1);
                    CLEAR(BankAccReconciliationLine);
                    BankAccReconciliationLine.INIT;
                    BankAccReconciliationLine."Statement Type" := ToBankAccReconciliation."Statement Type";
                    BankAccReconciliationLine."Bank Account No." := ToBankAccReconciliation."Bank Account No.";
                    BankAccReconciliationLine."Statement No." := ToBankAccReconciliation."Statement No.";
                    BankAccReconciliationLine."Statement Line No." := NextLineNo;
                    BankAccReconciliationLine.INSERT(TRUE);
                    BankAccReconciliationLine.VALIDATE("Transaction Date",TransDate);
                    BankAccReconciliationLine.VALIDATE(Type,BankAccReconciliationLine.Type::"Bank Account Ledger Entry");
                    IF Amt <> 0 THEN BEGIN
                      IF DC = 'D' THEN
                        BankAccReconciliationLine.VALIDATE("Statement Amount",Amt);
                      IF DC = 'C' THEN
                        BankAccReconciliationLine.VALIDATE("Statement Amount",-Amt);
                    END;
                    BankAccReconciliationLine.MODIFY(TRUE);
                    */

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
        TxtSep: Label '" """';
        ImportCol: array[25] of Text;
        i: Integer;
        Str: Text;
        Where: Text;
        Which: Text;

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
        //TAB := ',';
        i := 1;
        while i <= Number do begin
            i += 1;
            //  EndPos := STRPOS(String,FORMAT(TAB));
            EndPos := STRPOS(String, FORMAT(TxtSep));
            if EndPos > 0 then begin
                SubString := COPYSTR(String, 1, EndPos - 1);
                String := DELSTR(String, 1, EndPos);
            end else
                SubString := String;
        end;

        Where := '<>';
        Which := '"';

        SubString := DELCHR(SubString, Where, Which);
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

