page 58075 "Zycus PO Line Type Mapping"
{
    // Heilite Navision Old Id - 50649

    // version HEI.01

    // HEI.01 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Page: 50649 - Zycus PO Line Type Mapping

    Caption = 'Zycus PO Line Type Mapping';
    PageType = List;
    SourceTable = "Zycus PO Line Type Mapping INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PO Line Type Code"; Rec."PO Line Type Code")
                {
                    ToolTip = 'Specifies the value of the PO Line Type Code field.';
                }
                field("Line Type"; Rec."Line Type")
                {
                    ToolTip = 'Specifies the value of the Line Type field.';
                }
                field("CCC Marked"; Rec."CCC Marked")
                {
                    ToolTip = 'Specifies the value of the CCC Marked field.';
                }
                field("CONCAT Marked"; Rec."CONCAT Marked")
                {
                    ToolTip = 'Specifies the value of the CONCAT Marked field.';
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

