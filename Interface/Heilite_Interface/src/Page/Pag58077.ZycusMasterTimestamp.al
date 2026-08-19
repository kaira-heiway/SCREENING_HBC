page 58077 "Zycus Master Timestamp"
{
    // Heilite Navision Old Id - 50651

    // version HEI.02

    // HEI.01 CHG2210794 MAJUMS03 22.01.2024 Zycus - BASE HL Integration Master Vendor and GL Account (*RLPPD)
    //   # Created New Page: 50651 - Zycus Master Timestamp
    // 
    // HEI.02 CHG2210794 MAJUMS03 16.05.2024 Zycus - Zycus -BASE HL Integration - Vendor development finetuning
    //   # Field added Last Change Datetime in the Page

    Editable = false;
    PageType = List;
    SourceTable = "Zycus Master Timestamp FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Last Local Change Datetime"; Rec."Last Local Change Datetime")
                {
                    ToolTip = 'Specifies the value of the Last Local Change Datetime field.';
                }
                field("Last Change Datetime"; Rec."Last Change Datetime")
                {
                    ToolTip = 'Specifies the value of the Last Change Datetime field.';
                }
                field(Deleted; Rec.Deleted)
                {
                    ToolTip = 'Specifies the value of the Deleted field.';
                }
            }
        }
    }

    actions
    {
    }
}

