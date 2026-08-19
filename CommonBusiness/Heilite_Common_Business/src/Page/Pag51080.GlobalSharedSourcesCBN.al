page 51080 "Global Shared Sources CBN"
{
    // version HEI.01

    // HEI.01 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # Page created
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # Page created
    // HEI.03 FDD-HT923 CHG2034529 IBM GUNERE01 07.11.2019 # Blocked field added

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    //BC Upgrade KAPOOV01 Modified SourceTable Property of Page to remove compilation errors >>
    //SourceTable = Table50155;  //BC Upgrade KAPOOV01 Commented
    SourceTable = "Global Shared Source FND";
    //BC Upgrade KAPOOV01 Modified SourceTable Property of Page to remove compilation errors <<
    ApplicationArea = All;   //BC Upgrade KAPOOV01
    UsageCategory = Lists;   //BC Upgrade KAPOOV01

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Global ID"; Rec."Global ID")
                {
                    ApplicationArea = All;
                }
                field("Local ID"; Rec."Local ID")
                {
                    ApplicationArea = All;
                }
                field("Company ID"; Rec."Company ID")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

