page 58023 "BVM Interface Setup"
{
    // Heilite Navision Old Id - 50266

    // HEI.01 FDD-HT1139A IBM NASTAA02 12.05.2020 # DRC - BVM Interface

    //   # New Page created to store BVM Interface Setup

    Caption = 'BVM Interface Setup';
    PageType = Card;
    SourceTable = "BVM Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account Group Filter"; Rec."Account Group Filter")
                {
                    ToolTip = 'Specifies the value of the Account Group Filter field.';
                }
                field("Item Category Code Filter"; Rec."Item Category Code Filter")
                {
                    ToolTip = 'Specifies the value of the Item Category Code Filter field.';
                }
                field("Company Prefix"; Rec."Company Prefix")
                {
                    ToolTip = 'Specifies the value of the Company Prefix field.';
                }
            }
            group("Interface Setup")
            {
                field("BVM Customer Interface Code"; Rec."BVM Customer Interface Code")
                {
                    ToolTip = 'Specifies the value of the BVM Customer Interface Code field.';
                }
                field("BVM Item Interface Code"; Rec."BVM Item Interface Code")
                {
                    ToolTip = 'Specifies the value of the BVM Item Interface Code field.';
                }
                field("BVM Delivery Interface Code"; Rec."BVM Delivery Interface Code")
                {
                    ToolTip = 'Specifies the value of the BVM Delivery Interface Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

