namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

pageextension 58020 PurchOrderArchiveAddInterfaExt extends "Purch Order Archive Add CBN"
{
    // HEI.03 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.04 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus

    layout
    {
        addafter("Region Code")
        {
            field("Zycus Order No."; Rec."Zycus Order No. INT")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Editable = false;
                ToolTip = 'Specifies the value of the Zycus Order No. field.';
            }
            field("PO Transaction Interface Zycus"; Rec."PO Trans. Interf. Zycus INT")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Editable = false;
                ToolTip = 'Specifies the value of the PO Transaction Interface Zycus field.';
            }
            field("Processed PO Transaction Zycus"; Rec."Processed PO Trans. Zycus INT")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Editable = false;
                ToolTip = 'Specifies the value of the Processed PO Transaction Zycus field.';
            }
            field("Zycus GR UUID"; Rec."Zycus GR UUID INT")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Editable = false;
                ToolTip = 'Specifies the value of the Zycus GR UUID field.';
            }
            field("Zycus GR Cancel UUID"; Rec."Zycus GR Cancel UUID INT")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Editable = false;
                ToolTip = 'Specifies the value of the Zycus GR Cancel UUID field.';
            }
            field("GR Transaction Interface Zycus"; Rec."GR Trans. Interf. Zycus INT")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Editable = false;
                ToolTip = 'Specifies the value of the GR Transaction Interface Zycus field.';
            }
            field("Processed GR Transaction Zycus"; Rec."Processed GR Trans. Zycus INT")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Editable = false;
                ToolTip = 'Specifies the value of the Processed GR Transaction Zycus field.';
            }

        }
    }
}
