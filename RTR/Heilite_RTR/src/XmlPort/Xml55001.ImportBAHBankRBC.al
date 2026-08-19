xmlport 55001 "Import BAH Bank RBC"
{
    // version OK

    // SOICAD import Panama Bank Trans

    // BC Upgrade KUMARR78 >>
    // Object: XMLport 50034 "Import BAH Bank RBC"
    // 1. Removed validation of obsolete field in Business Central.
    //    Old:
    //         - BankAccReconciliationLine.VALIDATE(Type,
    //           BankAccReconciliationLine.Type::"Bank Account Ledger Entry");
    //         - Field "Type" existed in older NAV version.
    //
    //    New:
    //         - Validation line commented as field "Type" is no longer available
    //           in table "Bank Acc. Reconciliation Line" in Business Central.
    // 2. Added ApplicationArea property to request page field.
    //    Old:
    //         - Request page field "Date Format" did not have ApplicationArea.
    //
    //    New:
    //         - ApplicationArea = All; added to the field.
    // BC Upgrade KUMARR78 <<
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
                    BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                    TransDate: Date;
                    Amt: Decimal;
                    "----": Integer;
                    Day: Integer;
                    i: Integer;
                    Month: Integer;
                    NextLineNo: Integer;
                    Year: Integer;
                    ImportCol: array[10] of Text;
                begin
                    LineNo += 1;
                    if LineNo < 2 then
                        currXMLport.Skip();
                    for i := 1 to 7 do begin
                        ImportCol[i] := GetString(i, ImportLine);
                    end;
                    BankAccReconciliationLine.SetRange("Statement Type", ToBankAccReconciliation."Statement Type");
                    BankAccReconciliationLine.SetRange("Bank Account No.", ToBankAccReconciliation."Bank Account No.");
                    BankAccReconciliationLine.SetRange("Statement No.", ToBankAccReconciliation."Statement No.");
                    if BankAccReconciliationLine.FindLast() then
                        NextLineNo := BankAccReconciliationLine."Statement Line No." + 10000
                    else
                        NextLineNo := 10000;
                    //<<NAIKH01
                    if Option = 1 then begin
                        Evaluate(Month, GetStringForDate(1, ImportCol[3]));
                        Evaluate(Day, GetStringForDate(2, ImportCol[3]));
                        Evaluate(Year, GetStringForDate(3, ImportCol[3]));
                    end;

                    if Option = 2 then begin
                        Evaluate(Year, GetStringForDate(1, ImportCol[3]));
                        Evaluate(Month, GetStringForDate(2, ImportCol[3]));
                        Evaluate(Day, GetStringForDate(3, ImportCol[3]));
                    end;

                    TransDate := DMY2Date(Day, Month, Year);
                    Evaluate(Amt, ImportCol[7], 9);
                    Clear(BankAccReconciliationLine);
                    BankAccReconciliationLine.Init();
                    BankAccReconciliationLine."Statement Type" := ToBankAccReconciliation."Statement Type";
                    BankAccReconciliationLine."Bank Account No." := ToBankAccReconciliation."Bank Account No.";
                    BankAccReconciliationLine."Statement No." := ToBankAccReconciliation."Statement No.";
                    BankAccReconciliationLine."Statement Line No." := NextLineNo;
                    BankAccReconciliationLine.Insert(true);
                    BankAccReconciliationLine.Validate("Transaction Date", TransDate);
                    // BankAccReconciliationLine.VALIDATE(Type, BankAccReconciliationLine.Type::"Bank Account Ledger Entry"); //BC UPGRADE KUMARR78 Field No longer Avaiable in BC.
                    if Amt <> 0 then
                        BankAccReconciliationLine.Validate("Statement Amount", Amt);
                    BankAccReconciliationLine.Validate("Transaction Text", ImportCol[4] + ImportCol[5]);
                    BankAccReconciliationLine.Modify(true);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(filters)
                {
                    field(Date1; DateOption)
                    {
                        ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                        Caption = 'Date Format';
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
        Option: Integer;
        DateOption: Option "MM/DD/YYYY","YYYY/MM/DD";

    procedure SetTemplate(var BankAccReconciliationSrc: Record "Bank Acc. Reconciliation");
    begin
        ToBankAccReconciliation := BankAccReconciliationSrc;
    end;

    procedure GetString(Number: Integer; String: Text): Text[200];
    var
        TAB: Char;
        EndPos: Integer;
        i: Integer;
        SubString: Text[200];
    begin
        TAB := ',';
        i := 1;
        while i <= Number do begin
            i += 1;
            EndPos := StrPos(String, Format(TAB));
            if EndPos > 0 then begin
                SubString := CopyStr(String, 1, EndPos - 1);
                String := DelStr(String, 1, EndPos);
            end else
                SubString := String;
        end;
        exit(SubString);
    end;

    procedure GetStringForDate(Number: Integer; String: Text): Text[200];
    var
        TAB: Char;
        EndPos: Integer;
        i: Integer;
        SubString: Text[200];
    begin
        TAB := '/';
        i := 1;
        while i <= Number do begin
            i += 1;
            EndPos := StrPos(String, Format(TAB));
            if EndPos > 0 then begin
                SubString := CopyStr(String, 1, EndPos - 1);
                String := DelStr(String, 1, EndPos);
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

