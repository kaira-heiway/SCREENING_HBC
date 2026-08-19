page 58081 "Purch. Rcpt. Additional"
{
    // version HEI.05,HEI.06

    // HEI.01 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # New Page created to store Purchase Additional Fields
    // HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "Region Code"
    // HEI.03 CHG2190299 FDD-HB3316 IBM NANDIS01 26.07.2023 # POSM eshop SRM- HL interface
    //   # new field "Shopping Card No." shown
    // HEI.04 CHG2190299 FDD-HB3316 IBM NANDIS01 04.08.2023 # POSM eshop SRM- HL interface
    //   # made "Shopping Card No." field uneditable
    // HEI.05 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.06 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus
    //BC Upgrade GUNREM01 added this page in inerface ext this page is related to (Maximo HEI.01) 

    Caption = 'Purchase Receipt Additional';
    SourceTable = "Purch. Rcpt. Header Add FND";
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
            field("Shopping Card No."; Rec."Shopping Card No. FND")
            {
                Editable = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shopping Card No. field.';
            }
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
            field("Processed PO Transaction Zycus"; rec."PO Trans. Interf. Zycus FND")
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
        }
    }

    actions
    {
    }
}

