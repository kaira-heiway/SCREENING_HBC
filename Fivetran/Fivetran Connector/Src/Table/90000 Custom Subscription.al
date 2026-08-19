table 90000 "Custom Subscription"
{
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; id; Guid)
        {
            caption = 'Id';
        }
        field(2; url; Text[200])
        {
            caption = 'URL';
        }
        field(3; recordsDeleted; BigInteger)
        {
            caption = 'Records Deleted';
        }
        field(4; companyId; Text[200])
        {
            caption = 'Company ID';
        }
        field(5; tableId; Integer)
        {
            caption = 'Table ID';
        }
    }
    trigger OnInsert()
    begin
        id := System.CreateGuid();
    end;
}
