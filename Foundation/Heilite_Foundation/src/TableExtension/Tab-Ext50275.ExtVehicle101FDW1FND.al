tableextension 50275 "Ext Vehicle101FDW1 FND" extends Vehicle101FDW
{
    //BC UPGRADE KUMARR78 FDD-MTC-007<<
    fields
    {
        field(50000; "Status FND"; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Gate Entry",Maintenance,Blocked;
        }
    }
    //BC UPGRADE KUMARR78 FDD-MTC-007>>
}
