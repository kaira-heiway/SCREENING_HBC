page 50336 "Purchase Additional"
{
    // version HEI.12,HEI.13

    // HEI.01 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # New Page created to store Purchase Additional Fields
    // HEI.02 FDD-HT657 IBM NASTAA02 27.02.2020 # Ethiopia Intercompany Automation
    //   # New Field added: "IC Document"
    // 
    // HEI.04 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //   # new field added: IC Order No.
    // HEI.05 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //   # New field added: Special Order No.
    // HEI.06 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # LSR Order No added
    // HEI.07 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # Field shown - "Import Identifier", "TO Reference" and "Exp Physical Del Date(Imp)"
    // HEI.08 FDD-HB2174 CHG2104952 IBM NANDIS01 09.07.2021 Ibecor - PO API
    //   # New field - "PFI Document No."
    // HEI.09 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "Region Code"
    // HEI.10 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # New field "Astro Unique ID" shown
    // HEI.11 CHG2155847 HB2821 IBM NANDIS01 28.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Compilation error fixed by readding field "Astro WMS PO"
    // BC Upgrade SHUKLP03 >> Added in the interface ext.
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
    // BC Upgrade SHUKLP03 << Added in the interface ext.
    // HEI.12 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.13 CHG2210794 SAHAL01 30.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus

    Caption = 'Purchase Additional';
    SourceTable = "Purchase Header Additional FND";
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {

            group(General)
            {
            }
            field("PQ Approver"; Rec."PQ Approver")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the PQ Approver field.';
            }
            /*//BC Upgrade Manisha Drink it field code commented
            field("IC Document"; "IC Document")
            {
                Editable = false;
            }
            *///BC Upgrade Manisha Drink it field code commented
            field("IC Order No."; Rec."IC Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IC Order No. field.';
            }
            field("Special Order No."; Rec."Special Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Special Order No. field.';
            }
            // BC Upgrade SHUKLP03 >> Added in the interface ext.
            // field("LSR Order No"; Rec."LSR Order No")
            // {
            // }
            // BC Upgrade SHUKLP03 << Added in the interface ext.
            field("Import Identifier"; Rec."Import Identifier")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Import Identifier field.';
            }
            field("TO Reference"; Rec."TO Reference")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TO Reference field.';
            }
            field("Expctd Physical Delvry Date(Imp)"; Rec."Exp Physical Del Date(Imp)")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Expected Physical Delivery Date(Imp) field.';
            }
            // BC Upgrade SHUKLP03 >> Added in the interface ext.
            // field("PFI Document No."; Rec."PFI Document No.")
            // {
            // }
            // BC Upgrade SHUKLP03 << Added in the interface ext.
            field("Region Code"; Rec."Region Code")
            {
                ToolTip = 'Specifies the value of the Region Code field.';
                ApplicationArea = All;
            }
            //BC Upgrade Manisha Astro field code commented>>
            // field("Astro WMS PO"; Rec."Astro WMS PO")
            // {
            // }
            //  //BC Upgrade Manisha Astro field code commented<<
            //BC Upgrade Manisha Astro field code commented>>
            // field("Astro WMS PO"; Rec."Astro WMS PO")
            // {
            // }
            //  //BC Upgrade Manisha Astro field code commented<<

            // BC Upgrade SHUKLP03 >> Added in the interface ext.
            // field("Zycus Order No."; Rec."Zycus Order No.")
            // {
            //     Editable = false;
            // }
            // field("PO Transaction Interface Zycus"; Rec."PO Transaction Interface Zycus")
            // {
            //     Editable = false;
            // }
            // field("Processed PO Transaction Zycus"; Rec."Processed PO Transaction Zycus")
            // {
            //     Editable = false;
            // }
            // field("Zycus GR UUID"; Rec."Zycus GR UUID")
            // {
            //     Editable = false;
            // }
            // field("Zycus GR Cancel UUID"; Rec."Zycus GR Cancel UUID")
            // {
            //     Editable = false;
            // }
            // field("GR Transaction Interface Zycus"; Rec."GR Transaction Interface Zycus")
            // {
            //     Editable = false;
            // }
            // field("Processed GR Transaction Zycus"; Rec."Processed GR Transaction Zycus")
            // {
            //     Editable = false;
            // }
            // BC Upgrade SHUKLP03 << Added in the interface ext.
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }

    var
        DimValRec: Record "Dimension Value";
        GenLedSetRec: Record "General Ledger Setup";
        DimValPage: Page "Dimension Values";
        DimValue: Code[10];
        Text000: Label 'Please select the dimension for License Dimension in General Ledger Setup';
}

