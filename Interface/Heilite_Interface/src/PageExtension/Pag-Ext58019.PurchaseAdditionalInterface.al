namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

pageextension 58019 PurchaseAdditionalInterfaceExt extends "Purchase Additional"
{
    // HEI.06 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # LSR Order No added
    // HEI.08 FDD-HB2174 CHG2104952 IBM NANDIS01 09.07.2021 Ibecor - PO API
    //   # New field - "PFI Document No."
    // HEI.12 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.13 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus

    layout
    {
        addafter("Special Order No.")
        {
            field("LSR Order No"; Rec."LSR Order No INT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LSR Order No field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the LSR Order No field.';

            }
            field("PFI Document No. INT"; Rec."PFI Document No. INT")
            {
                ApplicationArea = All;
                Caption = 'PFI Document No.';
                ToolTip = 'Specifies the value of the PFI Document No. field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the PFI Document No. field.';


            }
            field("Zycus Order No."; Rec."Zycus Order No. INT")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Editable = false;
                ToolTip = 'Specifies the value of the Zycus Order No. field.';
            }
            field("PO Transaction Interface Zycus"; Rec."PO Transaction Intf. Zycus INT")
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
            field("GR Transaction Interface Zycus"; Rec."GR Transaction Intf Zycus INT")
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
