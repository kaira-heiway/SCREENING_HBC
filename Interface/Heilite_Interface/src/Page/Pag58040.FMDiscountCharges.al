page 58040 "FM Discount Charges"
{
    // Heilite Navision Old Id - 50375

    // version HEI.01

    // HEI.01 FDD-HT610 IBM NASTAA02 11.12.2019 # La Reunion Futur Master
    //   # New Page created to store Legacy Futur Master Discount Charges

    Caption = 'FM Discount Charges';
    PageType = List;
    SourceTable = "FM Discount Charges FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Charge No."; Rec."Item Charge No.")
                {
                    ToolTip = 'Specifies the value of the Item Charge No. field.';
                }
            }
        }
    }

    actions
    {
    }
}

