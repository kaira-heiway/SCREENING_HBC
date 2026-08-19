page 58010 "Server Instance Details"
{
    // Heilite Navision Old Id - 50166
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 04.07.2018 # New page for Interface Common Framework

    // BC Upgrade MISHRS14 >>
    // Changed table name from "Server Instance Detail" to "Server Instance Detail FND" as it moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<


    Caption = 'Server Instance Details';
    Editable = false;
    PageType = List;
    SourceTable = "Server Instance Detail FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Server Computer Name"; Rec."Server Computer Name")
                {
                    ToolTip = 'Specifies the value of the Server Computer Name field.';
                }
                field("Server Instance Name"; Rec."Server Instance Name")
                {
                    ToolTip = 'Specifies the value of the Server Instance Name field.';
                }
                field("Environment Code"; Rec."Environment Code")
                {
                    ToolTip = 'Specifies the value of the Environment Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

