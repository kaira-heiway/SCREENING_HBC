namespace fivetran.fivetran;

page 90123 "Maximo Item Category Filter"
{

    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'customEndpoints';
    EntityCaption = 'Maximo Item Category Filter';
    EntitySetCaption = 'Maximo Item Category Filter';
    EntityName = 'MaximoItemCategoryFilter';
    EntitySetName = 'MaximoItemCategoryFilter';
    SourceTable = "Maximo Item Category Flter INT";
    DelayedInsert = true;
    Editable = false;
    DataAccessIntent = ReadOnly;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(cmg_code; Rec."CMG Code")
                {

                }
                field(gen__prod__posting_group; Rec."Gen. Prod. Posting Group")
                {

                }
                field(item_category; Rec."Item Category")
                {

                }

            }
        }
    }
}
