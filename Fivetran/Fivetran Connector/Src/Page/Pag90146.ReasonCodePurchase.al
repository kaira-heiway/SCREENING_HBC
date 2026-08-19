page 90146 "Reason Code Purchase API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'customEndpoints';
    ApplicationArea = All;
    Caption = 'Reason Code Purchase';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Reason Code Purchase';
    EntitySetCaption = 'Reason Code Purchase';
    EntityName = 'reasonCodePurchase';
    EntitySetName = 'reasonCodePurchase';
    SourceTable = "Reason Code_Purchase FND";
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
                field(code; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }

            }
        }
    }
}
