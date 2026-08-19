page 58073 "Zycus Special Character"
{
    // Heilite Navision Old Id - 50647

    // version HEI.01

    // HEI.01 CHG2210794 SAHAL01 02.04.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Page: 50647 - Zycus Special Character

    Caption = 'Zycus Special Character';
    PageType = List;
    SourceTable = "Zycus Special Character INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Zycus Restricted Special Char"; Rec."Zycus Restricted Special Char")
                {
                    ToolTip = 'Specifies the value of the Zycus Restricted Special Character field.';
                }
                field("Special Char Description"; Rec."Special Char Description")
                {
                    ToolTip = 'Specifies the value of the Special Char Description field.';
                }
                field("Replaced by Char"; Rec."Replaced by Char")
                {
                    ToolTip = 'Specifies the value of the Replaced by Character field.';
                }
                field("Replaced by Char Description"; Rec."Replaced by Char Description")
                {
                    ToolTip = 'Specifies the value of the Replaced by Char Description field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Last Time Modified field.';
                }
                field("Last Modified By User"; Rec."Last Modified By User")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Last Modified By User field.';
                }
            }
        }
    }

    actions
    {
    }
}

