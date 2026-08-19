xmlport 55003 "Export GL Open Entries BASE"
{
    // version done
    //Bc Upgrade YADAVM09 Migrated 2018 to bc.
    //Bc Upgrade YADAVM09 old id is 50135.

    Direction = Export;
    FieldSeparator = '|';
    Format = VariableText;
    Permissions = TableData "Dimension Set Entry" = rimd;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'GenJnlLine';
                fieldelement(AccountNo; "Gen. Journal Line"."Account No.")
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
                fieldelement(Description; "Gen. Journal Line".Description)
                {
                }
                fieldelement(BalAccNo; "Gen. Journal Line"."Bal. Account No.")
                {
                }
                fieldelement(CurrCode; "Gen. Journal Line"."Currency Code")
                {
                }
                fieldelement(RemainingAmt; "Gen. Journal Line"."Amount (LCY)")
                {
                }
                fieldelement(SourceCode; "Gen. Journal Line"."Source Code")
                {
                }
                fieldelement(ExtDocNo; "Gen. Journal Line"."External Document No.")
                {
                }
                fieldelement(DocDate; "Gen. Journal Line"."Document Date")
                {
                }
                fieldelement(Amount; "Gen. Journal Line"."Amount (LCY)")
                {
                }
                fieldelement(DimSetID; "Gen. Journal Line"."Dimension Set ID")
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

                trigger OnAfterGetRecord();
                begin
                    if DimSetEntryTmp.GET("Gen. Journal Line"."Dimension Set ID", Dimcode1) then
                        Dim1ValueCode := DimSetEntryTmp."Dimension Value Code"
                    else
                        Dim1ValueCode := '';

                    if DimSetEntryTmp.GET("Gen. Journal Line"."Dimension Set ID", Dimcode2) then
                        Dim2ValueCode := DimSetEntryTmp."Dimension Value Code"
                    else
                        Dim2ValueCode := '';

                    if DimSetEntryTmp.GET("Gen. Journal Line"."Dimension Set ID", Dimcode3) then
                        Dim3ValueCode := DimSetEntryTmp."Dimension Value Code"
                    else
                        Dim3ValueCode := '';

                    if DimSetEntryTmp.GET("Gen. Journal Line"."Dimension Set ID", Dimcode4) then
                        Dim4ValueCode := DimSetEntryTmp."Dimension Value Code"
                    else
                        Dim4ValueCode := '';

                    if DimSetEntryTmp.GET("Gen. Journal Line"."Dimension Set ID", Dimcode5) then
                        Dim5ValueCode := DimSetEntryTmp."Dimension Value Code"
                    else
                        Dim5ValueCode := '';

                    if DimSetEntryTmp.GET("Gen. Journal Line"."Dimension Set ID", Dimcode6) then
                        Dim6ValueCode := DimSetEntryTmp."Dimension Value Code"
                    else
                        Dim6ValueCode := '';
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
                field(Dimcode1; Dimcode1)
                {
                    Caption = 'Dim code 1';
                    TableRelation = Dimension.Code;
                    ToolTip = 'Please select Dimension code1';//Bc Upgrade YADAVM09<<
                    ApplicationArea = all;//Bc Upgrade YADAVM09<<
                }
                field(Dimcode2; Dimcode2)
                {
                    Caption = 'Dim Code 2';
                    TableRelation = Dimension.Code;
                    ToolTip = 'Please select dimension code2';//Bc Upgrade YADAVM09<<
                    ApplicationArea = all;//Bc Upgrade YADAVM09<<
                }
                field(Dimcode3; Dimcode3)
                {
                    Caption = 'Dim code 3';
                    TableRelation = Dimension.Code;
                    ToolTip = 'Please select dimension code3';//Bc Upgrade YADAVM09<<
                    ApplicationArea = all;//Bc Upgrade YADAVM09<<
                }
                field(Dimcode4; Dimcode4)
                {
                    Caption = 'Dim Code 4';
                    TableRelation = Dimension.Code;
                    ToolTip = 'Please select dimension code4';//Bc Upgrade YADAVM09<<
                    ApplicationArea = all;//Bc Upgrade YADAVM09<<
                }
                field(Dimcode5; Dimcode5)
                {
                    Caption = 'Dim code 5';
                    TableRelation = Dimension.Code;
                    ToolTip = 'Please select dimension code5';//Bc Upgrade YADAVM09<<
                    ApplicationArea = all;//Bc Upgrade YADAVM09<<
                }
                field(Dimcode6; Dimcode6)
                {
                    Caption = 'Dim Code 6';
                    TableRelation = Dimension.Code;
                    ToolTip = 'Please select dimension code6';//Bc Upgrade YADAVM09<<
                    ApplicationArea = all;//Bc Upgrade YADAVM09<<
                }
            }
        }

        actions
        {
        }
    }

    var
        DimensionSetEntry: Record "Dimension Set Entry";
        JnlTemplName: Code[20];
        BatchName: Code[20];
        GenJournalBatch: Record "Gen. Journal Batch";
        DimSetEntryTmp: Record "Dimension Set Entry";
        DimMgt: Codeunit DimensionManagement;
        Dimcode1: Code[20];
        Dimcode2: Code[20];
        Dimcode3: Code[20];
        Dimcode4: Code[20];
        Dimcode5: Code[10];
        Dimcode6: Code[20];
}

