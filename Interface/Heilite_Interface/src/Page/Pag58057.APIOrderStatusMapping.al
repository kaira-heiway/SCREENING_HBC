page 58057 "API Order Status Mapping"
{
    // Heilite Navision Old Id - 50442

    // version HEI.01

    // HEI.01 FDD-HB1234 - CHG2053453 IBM NASTAA02 15.02.2021 # B2B Order Status
    //   # New Page created for B2B Interfaces

    // BC Upgrade MISHRS14 >>
    // Changed table name to "API Order Status Mapping FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Caption = 'API Order Status Mapping';
    PageType = List;
    SourceTable = "API Order Status Mapping FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Source; Rec.Source)
                {
                    ToolTip = 'Specifies the value of the Source field.';
                }
                field("Status Field 1"; Rec."Status Field 1")
                {
                    ToolTip = 'Specifies the value of the Status Field 1 field.';
                }
                field("Status Field 2"; Rec."Status Field 2")
                {
                    ToolTip = 'Specifies the value of the Status Field 2 field.';
                }
                field(Message; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Message field.';
                }
            }
        }
    }

    actions
    {
    }
}

