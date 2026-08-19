xmlport 55002 "Export Vend. Open Entries BASE"
{
    //Bc Upgrade YADAVM09 Migrated 2018 to bc.
    //Bc Upgrade YADAVM09 old id is -50123.

    Direction = Export;
    //Encoding = UTF8;//Bc Upgrade YADAVM09<<
    FieldSeparator = '|';
    Format = VariableText;
    Permissions = TableData "Gen. Journal Line" = r;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'GenJnlLine';
                SourceTableView = WHERE("Journal Template Name" = CONST('MIGRATION'), "Journal Batch Name" = CONST('MIGR_AP'));
                fieldelement(AccNo; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(DocType; "Gen. Journal Line"."Document Type")
                {
                }
                fieldelement(DocNo; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(Desc; "Gen. Journal Line".Description)
                {
                }
                fieldelement(CurrCode; "Gen. Journal Line"."Currency Code")
                {
                }
                fieldelement(Amt; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(CurrFactor; "Gen. Journal Line"."Currency Factor")
                {
                }
                fieldelement(DueDate; "Gen. Journal Line"."Due Date")
                {
                }
                fieldelement(DocDate; "Gen. Journal Line"."Document Date")
                {
                }
                fieldelement(ExtDocNo; "Gen. Journal Line"."External Document No.")
                {
                }
                fieldelement(RemAmtLCY; "Gen. Journal Line"."Amount (LCY)")
                {
                }
                fieldelement(BalAccNo; "Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(BalAccType; "Gen. Journal Line"."Bal. Account Type")
                {
                }
                fieldelement(Prepayment; "Gen. Journal Line".Prepayment)
                {
                }
                fieldelement(PaymentMethodCode; "Gen. Journal Line"."Payment Method Code")
                {
                }
                fieldelement(OnHold; "Gen. Journal Line"."On Hold")
                {
                }
                fieldelement(VendBankAcc; "Gen. Journal Line"."Vendor Bank Account FND")
                {
                }
                fieldelement(ReasonCode; "Gen. Journal Line"."Reason Code")
                {
                }
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
                field(JnlTemplName; JnlTemplName)
                {
                    Caption = 'Gen. Journal Template';
                    TableRelation = "Gen. Journal Template".Name;
                    ToolTip = 'Please select Gen Journal Template';//Bc Upgrade YADAVM09<<
                    ApplicationArea = all;//Bc Upgrade YADAVM09<<
                }
                field(BatchName; BatchName)
                {
                    Caption = 'Gen. Journal Batch';
                    ToolTip = 'Please select Gen Journal Template';//Bc Upgrade YADAVM09<<
                    ApplicationArea = all;//Bc Upgrade YADAVM09<<
                }
            }
        }

        actions
        {
        }
    }

    var

        GenJournalBatch: Record "Gen. Journal Batch";
        JnlTemplName: Code[20];
        BatchName: Code[20];
}

