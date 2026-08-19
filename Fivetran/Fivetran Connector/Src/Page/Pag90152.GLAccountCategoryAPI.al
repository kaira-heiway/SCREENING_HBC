page 90152 "G_L Account Category API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'G/L Account Category';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'G/L Account Category';
    EntitySetCaption = 'G/L Account Category';
    EntityName = 'gLAccountCategory';
    EntitySetName = 'gLAccountCategory';
    SourceTable = "G/L Account Category";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(parentEntryNo; Rec."Parent Entry No.")
                {
                    Caption = 'Parent Entry No.';
                }
                field(siblingSequenceNo; Rec."Sibling Sequence No.")
                {
                    Caption = 'Sibling Sequence No.';
                }
                field(presentationOrder; Rec."Presentation Order")
                {
                    Caption = 'Presentation Order';
                }
                field(indentation; Rec.Indentation)
                {
                    Caption = 'Indentation';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(accountCategory; Rec."Account Category")
                {
                    Caption = 'Account Category';
                }
                field(incomeBalance; Rec."Income/Balance")
                {
                    Caption = 'Income/Balance';
                }
                field(additionalReportDefinition; Rec."Additional Report Definition")
                {
                    Caption = 'Additional Report Definition';
                }
                field(systemGenerated; Rec."System Generated")
                {
                    Caption = 'System Generated';
                }
            }
        }
    }
}
