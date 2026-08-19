xmlport 55004 "Export FA G/L Journal LR"
{
    //Bc Upgrade YADAVM09 Migrated 2018 to bc.
    //Bc Upgrade YADAVM09 old id is 50137.

    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;


    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'FAJnl';
                fieldelement(AccNo; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(PostingDate; "Gen. Journal Line"."Posting Date")
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
                fieldelement(BalAccNo; "Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(Amount; "Gen. Journal Line".Amount)
                {
                }
                textelement(mvmttype)
                {
                    XmlName = 'MVMTType';
                }
                textelement(ccccode)
                {
                    XmlName = 'CCCCode';
                }
                fieldelement(FAPostingDate; "Gen. Journal Line"."FA Posting Date")
                {
                }
                fieldelement(FAPostingType; "Gen. Journal Line"."FA Posting Type")
                {
                }
                fieldelement(DeprCode; "Gen. Journal Line"."Depreciation Book Code")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if DimSetEntryTmp.GET("Gen. Journal Line"."Dimension Set ID", 'MVMT') then
                        MVMTType := DimSetEntryTmp."Dimension Value Code"
                    else
                        MVMTType := '';

                    if DimSetEntryTmp.GET("Gen. Journal Line"."Dimension Set ID", 'CCC') then
                        CCCCode := DimSetEntryTmp."Dimension Value Code"
                    else
                        CCCCode := '';
                end;

                trigger OnPreXmlItem();
                begin
                    "Gen. Journal Line".SETRANGE("Gen. Journal Line"."Journal Template Name", JnlTemplName);
                    "Gen. Journal Line".SETRANGE("Gen. Journal Line"."Journal Batch Name", BatchName);
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
            }
        }

        actions
        {
        }
    }

    var
        DimSetEntryTmp: Record "Dimension Set Entry";
        GenJnlTemplate: Record "Gen. Journal Template";
        JnlTemplName: Code[10];
        BatchName: Code[10];
        GenJournalBatch: Record "Gen. Journal Batch";
}

