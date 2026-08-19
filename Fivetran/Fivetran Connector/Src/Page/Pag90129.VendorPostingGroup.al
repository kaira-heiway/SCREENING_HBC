page 90129 "Vendor Posting Group API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Vendor Posting Group';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Vendor Posting Group';
    EntitySetCaption = 'Vendor Posting Group';
    EntityName = 'vendorPostingGroup';
    EntitySetName = 'vendorPostingGroup';
    SourceTable = "Vendor Posting Group";
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
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(payablesAccount; Rec."Payables Account")
                {
                    Caption = 'Payables Account';
                }
            }
        }
    }
}
