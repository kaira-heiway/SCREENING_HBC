page 51076 "Purch Order Archive Add CBN"
{
    // version HEI.03,HEI.04

    // HEI.01 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # New Page created to store Purchase Additional Fields
    // HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "Region Code"
    // BC Upgrade SHUKLP03 >> Added in interface ext.
    // HEI.03 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.04 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus
    // BC Upgrade SHUKLP03 << Added in interface ext.
    Caption = 'Purchase Order Archive Additional';
    SourceTable = "Purchase Header Arch Addit FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {

            group(General)
            {
            }
            field("PQ Approver"; Rec."PQ Approver")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PQ Approver field.';
            }
            field("Region Code"; Rec."Region Code")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Region Code field.';
            }
            // BC Upgrade SHUKLP03 >> Added in interface ext.
            // field("Zycus Order No."; Rec."Zycus Order No.")
            // {
            //     ApplicationArea = All; // BC Upgrade SHUKLP03 <<
            //     Editable = false;
            // }
            // field("PO Transaction Interface Zycus"; Rec."PO Transaction Interface Zycus")
            // {
            //     ApplicationArea = All; // BC Upgrade SHUKLP03 <<
            //     Editable = false;
            // }
            // field("Processed PO Transaction Zycus"; Rec."Processed PO Transaction Zycus")
            // {
            //     ApplicationArea = All; // BC Upgrade SHUKLP03 <<
            //     Editable = false;
            // }
            // field("Zycus GR UUID"; Rec."Zycus GR UUID")
            // {
            //     ApplicationArea = All; // BC Upgrade SHUKLP03 <<
            //     Editable = false;
            // }
            // field("Zycus GR Cancel UUID"; Rec."Zycus GR Cancel UUID")
            // {
            //     ApplicationArea = All; // BC Upgrade SHUKLP03 <<
            //     Editable = false;
            // }
            // field("GR Transaction Interface Zycus"; Rec."GR Transaction Interface Zycus")
            // {
            //     ApplicationArea = All; // BC Upgrade SHUKLP03 <<
            //     Editable = false;
            // }
            // field("Processed GR Transaction Zycus"; Rec."Processed GR Transaction Zycus")
            // {
            //     ApplicationArea = All; // BC Upgrade SHUKLP03 <<
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 << Added in interface ext.

        }
    }

    actions
    {
    }
}

