page 58078 "Zycus GL Rule Map"
{
    // Heilite Navision Old Id - 50652

    // version HEI.02

    // HEI.01 CHG2210794 MAJUMS03 06.06.2024 Zycus - BASE HL Integration - CMG Rule Map
    //   # Created New Page: 50652 - Zycus GL Rule Map.
    // HEI.02 CHG2278614 SHARMP16 15.01.2025 E2E test for Zycus HL integration - G/L Rule map
    //   # Add new field on Page: Account Type.

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Zycus GL Rule Map FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Editable = false;
    PageType = List;
    SourceTable = "Zycus GL Rule Map FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("CMG Code"; Rec."CMG Code")
                {
                    ToolTip = 'Specifies the value of the CMG Code field.';
                }
                field("CTP Code"; Rec."CTP Code")
                {
                    ToolTip = 'Specifies the value of the CTP Code field.';
                }
                field("CCC Code"; Rec."CCC Code")
                {
                    ToolTip = 'Specifies the value of the CCC Code field.';
                }
                field("GL Account"; Rec."GL Account")
                {
                    ToolTip = 'Specifies the value of the GL Account field.';
                }
                field("Allowed With Warning"; Rec."Allowed With Warning")
                {
                    ToolTip = 'Specifies the value of the Allowed With Warning field.';
                }
                field("Purchase Type"; Rec."Purchase Type")
                {
                    ToolTip = 'Specifies the value of the Purchase Type field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("DateTime Stamp"; Rec."DateTime Stamp")
                {
                    ToolTip = 'Specifies the value of the DateTime Stamp field.';
                }
                field("CCC Dim Filter"; Rec."CCC Dim Filter")
                {
                    ToolTip = 'Specifies the value of the CCC Dim Filter field.';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field(Inserted; Rec.Inserted)
                {
                    ToolTip = 'Specifies the value of the Inserted field.';
                }
                field(Modified; Rec.Modified)
                {
                    ToolTip = 'Specifies the value of the Modified field.';
                }
                field(Deleted; Rec.Deleted)
                {
                    ToolTip = 'Specifies the value of the Deleted field.';
                }
                field("Current Log Code"; Rec."Current Log Code")
                {
                    ToolTip = 'Specifies the value of the Current Log Code field.';
                }
                field("Old Log Code"; Rec."Old Log Code")
                {
                    ToolTip = 'Specifies the value of the Old Log Code field.';
                }
                field("Last Local Change Datetime"; Rec."Last Local Change Datetime")
                {
                    ToolTip = 'Specifies the value of the Last Local Change Datetime field.';
                }
            }
        }
    }

    actions
    {
    }
}

