page 58082 "Purch. Cr. Memo Additional"
{
    // version HEI.03,HEI.04

    // HEI.01 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # New Page created to store Purchase Additional Fields
    // HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "Region Code"
    // HEI.03 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.04 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus

    Caption = 'Purchase Credit Memo Additional';
    SourceTable = "Purch. Cr. Memo Hdr. Add FND";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            // Caption = '<Control55001>';
            group(General)
            {
            }
            field("PQ Approver"; Rec."PQ Approver")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the PQ Approver field.';
            }
            field("Region Code"; Rec."Region Code")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Region Code field.';
            }
            // BC Upgrade MISHRS14 >>
            // Added FND in field Rec.
            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Zycus Order No. field.';
            }
            field("PO Transaction Interface Zycus"; rec."PO Trans. Interf. Zycus FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the PO Transaction Interface Zycus field.';
            }
            field("Processed PO Transaction Zycus"; rec."Procsd. PO Trans. Zycus FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Processed PO Transaction Zycus field.';
            }
            field("Zycus GR UUID"; Rec."Zycus GR UUID FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Zycus GR UUID field.';
            }
            field("Zycus GR Cancel UUID"; Rec."Zycus GR Cancel UUID FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Zycus GR Cancel UUID field.';
            }
            field("GR Transaction Interface Zycus"; rec."GR Trans. Interf. Zycus FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the GR Transaction Interface Zycus field.';
            }
            field("Processed GR Transaction Zycus"; rec."Procsd. GR Trans. Zycus FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Processed GR Transaction Zycus field.';
            }
            // BC Upgrade MISHRS14 <<
        }
    }

    actions
    {
    }
}

