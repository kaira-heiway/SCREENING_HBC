page 90000 "API Custom Subscription"
{
    PageType = API;
    ApplicationArea = All;
    SourceTable = "Custom Subscription";
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'webhook';
    EntityName = 'customSubscription';
    EntitySetName = 'customSubscriptions';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    Extensible = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(id; Rec.id) { }
                field(url; Rec.url) { }
                field(recordsDeleted; Rec.recordsDeleted) { }
                field(tableId; Rec.tableId) { }
                field(companyId; Rec.companyId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
                field(systemId; Rec.SystemId) { }

            }
        }
    }
}
