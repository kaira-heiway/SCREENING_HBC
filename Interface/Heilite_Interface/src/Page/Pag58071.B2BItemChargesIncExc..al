page 58071 "B2B Item Charges Inc./Exc."
{
    // Heilite Navision Old Id - 50512

    // version HEI.01

    // HEI.01 CHG2174235 IBM COSTES04 22.03.2023 Interface Order Simulation
    //   # new object for DOT order simulation

    // BC Upgrade PATELP08>>
    // Changed name of table from "B2B Item Charges Inc./Exc." to "B2B Item Charges Inc./Exc. FND"
    // BC Upgrade PATELP08<<

    PageType = List;
    SourceTable = "B2B Item Charges Inc./Exc. FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Charge No."; Rec."Item Charge No.")
                {
                    ToolTip = 'Specifies the value of the Item Charge No. field.';
                }
                field("Exclude from Total Amount"; Rec."Exclude from Total Amount")
                {
                    ToolTip = 'Specifies the value of the Exclude from Total Amount field.';
                }
                field("Exclude from List Price"; Rec."Exclude from List Price")
                {
                    ToolTip = 'Specifies the value of the Exclude from List Price field.';
                }
                field("Include in Transport Amount"; Rec."Include in Transport Amount")
                {
                    ToolTip = 'Specifies the value of the Include in Transport Amount field.';
                }
            }
        }
    }

    actions
    {
    }
}

