xmlport 55009 "Import BAH Bank BOB"
{
    //BC Upgrade GUNREM01 Old ID-50033

    // SOICAD import Panama Bank Trans

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
                textelement(PostingDate)
                {
                }
                textelement(Reference)
                {
                }
                textelement(Transaction)
                {
                }
                textelement(DescriptionT)
                {
                }
                textelement(Debit)
                {
                }
                textelement(Credit)
                {
                }
                textelement(SaldoCapital)
                {
                }

                trigger OnAfterInsertRecord();
                var
                    DebitAmount: Decimal;
                    CreditAmount: Decimal;
                    TransDate: Date;
                    BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
                    LineNo: Integer;
                    Year: Integer;
                    Month: Integer;
                    Day: Integer;
                begin

                    if not FirstLine then begin
                        if EVALUATE(DebitAmount, DELCHR(Debit, '=', ','), 9) then;
                        if EVALUATE(CreditAmount, DELCHR(Credit, '=', ','), 9) then;

                        BankAccReconciliationLine.SETRANGE("Statement Type", ToBankAccReconciliationLine."Statement Type");
                        BankAccReconciliationLine.SETRANGE("Bank Account No.", ToBankAccReconciliationLine."Bank Account No.");
                        BankAccReconciliationLine.SETRANGE("Statement No.", ToBankAccReconciliationLine."Statement No.");
                        if BankAccReconciliationLine.FINDLAST then
                            LineNo := BankAccReconciliationLine."Statement Line No." + 10000
                        else
                            LineNo := 10000;
                        CLEAR(BankAccReconciliationLine);
                        BankAccReconciliationLine."Statement Type" := ToBankAccReconciliationLine."Statement Type";
                        BankAccReconciliationLine."Bank Account No." := ToBankAccReconciliationLine."Bank Account No.";
                        BankAccReconciliationLine."Statement No." := ToBankAccReconciliationLine."Statement No.";
                        BankAccReconciliationLine."Statement Line No." := LineNo;
                        EVALUATE(Year, COPYSTR(PostingDate, 7, 4));
                        EVALUATE(Month, COPYSTR(PostingDate, 4, 2));
                        EVALUATE(Day, COPYSTR(PostingDate, 1, 2));
                        TransDate := DMY2DATE(Day, Month, Year);
                        BankAccReconciliationLine.VALIDATE("Transaction Date", TransDate);
                        BankAccReconciliationLine.VALIDATE("Transaction Text", Reference);
                        if DebitAmount <> 0 then
                            BankAccReconciliationLine.VALIDATE("Statement Amount", DebitAmount);
                        if CreditAmount <> 0 then
                            BankAccReconciliationLine.VALIDATE("Statement Amount", -CreditAmount);
                        BankAccReconciliationLine.INSERT(true);
                    end;
                    FirstLine := false;
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

    trigger OnInitXmlPort();
    begin
        FirstLine := true;
    end;

    var
        ToBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        FirstLine: Boolean;

    procedure SetTemplate(var BankAccReconciliationLineSrc: Record "Bank Acc. Reconciliation Line");
    begin
        ToBankAccReconciliationLine := BankAccReconciliationLineSrc;
        FirstLine := true;
    end;
}

