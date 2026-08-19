page 58032 "Maraki Supress Values"
{
    // Heilite Navision Old Id - 50340

    // version HEI.01

    // HEI.01 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Page created for Maraki Supress Values

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Maraki Suppress Values" to "Maraki Suppress Values FND"
    // BC UPGRADE PATELS08 <<

    PageType = List;
    SourceTable = "Maraki Suppress Values FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}

