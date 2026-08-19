page 50365 "Common Customer Numbers"
{
    // HEI.01 FDD-HT788 IBM BULIMC01 13.10.2019# new page created for Customer code sharing

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Common Customer Numbers FND";
    ApplicationArea = ALl;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Company ID"; Rec."Company ID")
                {
                    ToolTip = 'Specifies the value of the Company ID field.';
                }
                field("Global ID"; Rec."Global ID")
                {
                    ToolTip = 'Specifies the value of the Global ID field.';
                }
                field("Local ID"; Rec."Local ID")
                {
                    ToolTip = 'Specifies the value of the Local ID field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
            }
        }
    }

    actions
    {
    }
}

