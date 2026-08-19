table 50144 "Purchase Header Arch Addit FND"
{
    // version HEI.16

    // HEI.01 FDD- HT821 IBM SHANKJ03 11.02.2020
    //   #New field added Maximo status
    // HEI.03 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields created: 50022 - LSR Order No
    // HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field created: 50048 - Region Code
    // HEI.05 FDD-HB2174 CHG2104952 IBM NANDIS01 09.07.2021 Ibecor - PO API
    //   # New fields created from ID - 50027 to 50047 and 50049 to 50054
    // HEI.06 CHG2121745 IBM BHATTA09 23.08.2021
    //   # New Field created: 50055 - Shopping Card Creation Date
    // HEI.09 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New field added - ID - 50057 - Arrival Date Destination Port - Date
    // HEI.07 FDD-HB2482 CHG2123206 IBM NANDIS01 03.11.2021 - Improvement of multiple HeiLite reports for StP  Procurement users
    //   # New Field created: 50021 - Limit PO
    // HEI.08 FDD-HB2155 CHG2128694 IBM NANDIS01 28.10.2021 WMS PO
    //   # New field added - "WMS Export"
    // HEI.10 FDD-HB2174 CHG2129099 IBM NANDIS01 02.03.2022 Ibecor integration interface INT03 and INT04
    //   # Field length of field - "Tracking Information" extended to 250 from 30
    // HEI.11 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # New field "Astro Unique ID" (ID - 50058) added
    // HEI.12 CHG2155847 HB2821 IBM NANDIS01 26.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # field changed from "Astro Unique ID" (ID - 50058) to Astro WMS PO(Boolean)
    // HEI.13 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields created - "License Required" (ID-50063- Boolean) and "Credit Info Required" (ID-50064- Boolean)
    // HEI.14 CHG2190299 FDD-HB3316 IBM NANDIS01 26.07.2023 # POSM eshop SRM- HL interface
    //   # Added new field "Shopping Card No."(id - 50003, Code[10])
    // HEI.15 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50078 - Zycus PO Type Code
    //                         50081 - PO Transaction Interface Zycus
    //                         50085 - Processed PO Transaction Zycus
    // HEI.16 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Modified Field Name: 50078 - Zycus GR UUID
    //   # Created New Fields: 50079 - Zycus GR Cancel UUID
    //                         50082 - GR Transaction Interface Zycus
    //                         50086 - Processed GR Transaction Zycus
    // BC Upgrade SHUKLP03 >> Added in interface Ext.
    // HEI.06 CHG2121745 IBM BHATTA09 23.08.2021
    //   # New Field created: 50055 - Shopping Card Creation Date
    // HEI.01 FDD- HT821 IBM SHANKJ03 11.02.2020
    //   #New field added Maximo status
    // HEI.03 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields created: 50022 - LSR Order No
    // HEI.05 FDD-HB2174 CHG2104952 IBM NANDIS01 09.07.2021 Ibecor - PO API
    //   # New fields created from ID - 50027 to 50047 and 50049 to 50054
    // HEI.09 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New field added - ID - 50057 - Arrival Date Destination Port - Date
    // HEI.08 FDD-HB2155 CHG2128694 IBM NANDIS01 28.10.2021 WMS PO
    //   # New field added - "WMS Export"
    // HEI.10 FDD-HB2174 CHG2129099 IBM NANDIS01 02.03.2022 Ibecor integration interface INT03 and INT04
    //   # Field length of field - "Tracking Information" extended to 250 from 30
    // HEI.13 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields created - "License Required" (ID-50063- Boolean) and "Credit Info Required" (ID-50064- Boolean)
    // HEI.14 CHG2190299 FDD-HB3316 IBM NANDIS01 26.07.2023 # POSM eshop SRM- HL interface
    //   # Added new field "Shopping Card No."(id - 50003, Code[10])
    // HEI.15 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50078 - Zycus PO Type Code
    //                         50081 - PO Transaction Interface Zycus
    //                         50085 - Processed PO Transaction Zycus
    // HEI.16 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Modified Field Name: 50078 - Zycus GR UUID
    //   # Created New Fields: 50079 - Zycus GR Cancel UUID
    //                         50082 - GR Transaction Interface Zycus
    //                         50086 - Processed GR Transaction Zycus
    // BC Upgrade SHUKLP03 << Added in interface Ext.
    Caption = 'Purchase Header Archive Additional';

    fields
    {
        field(1; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
                              FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        FRA = 'N°';
        }
        field(5047; "Version No."; Integer)
        {
            CaptionML = ENU = 'Version No.',
                        FRA = 'N° version';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            CaptionML = ENU = 'Doc. No. Occurrence',
                        FRA = 'Occurrence n° doc.';
        }
        field(50000; "PQ Approver"; Code[50])
        {
            Caption = 'PQ Approver';
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        // BC Upgrade SHUKLP03 >> Added in interface Ext.
        // field(50002; "Maximo Status"; Option)
        // {
        //     Description = 'HEI.01';
        //     OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        // }
        // field(50003; "Shopping Card No."; Code[10])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.14';
        // }
        // BC Upgrade SHUKLP03 << Added in interface Ext.
        field(50021; "Limit PO"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        // field(50022; "LSR Order No"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.03';
        //     Editable = false;
        // }
        // field(50027; "Expected Date Departure"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50028; "Departure Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50029; "Date Orig. Docs Sent"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50030; "Date Copy Docs Sent"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50031; "Order Form To Supplier Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50032; "Expected Date to Ex Works"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50035; "Vessel Name"; Text[50])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50036; "Expected Date Arrival"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50037; "B/L-AWB"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50038; "Shipment Description"; Text[50])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50039; "Order No."; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50040; "Tracking Information"; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05,HEI.10';
        //     Editable = false;
        // }
        // field(50041; "Reference SDV"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50042; "Date Receipt Docs Supplier"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50043; "Date Receipt Docs Forwarder"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50044; "Volume in m3"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50045; "Nbr cont. 20 feet"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50046; "Nbr cont. 40 feet"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // field(50047; "PFI Document No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        field(50048; "Region Code"; Code[20])
        {
            Caption = 'Region Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = Location;
        }
        // BC Upgrade SHUKLP03 >> Added in interface Ext.
        // field(50049; "Credit Number"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        // }
        // field(50050; "Credit Amount Of supplier"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        // }
        // field(50051; "Credit Validity Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        // }
        // field(50052; "Last Date Of Shipment"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        // }
        // field(50053; "Bank Who Issued Credit"; Text[50])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        // }
        // field(50054; "Ibecor Dossier No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.05';
        // }

        // field(50055; "Shopping Card Creation Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.06';
        // }

        // BC Upgrade SHUKLP03 >> Added in interface Ext.
        // field(50056; "WMS Export"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.08';
        // }
        // field(50057; "Arrival Date Destination Port"; Date)
        // {
        //     Caption = 'Arrival Date In Port of Destination';
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.09';
        // }
        // BC Upgrade SHUKLP03 << Added in interface Ext.

        // BC Upgrade SHUKLP03 >> Blocked Astro field.
        // field(50058; "Astro WMS PO"; Boolean)
        // {
        //     Caption = 'Astro WMS PO';
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.12';
        //     Editable = false;
        // }
        // BC Upgrade SHUKLP03 << Blocked Astro field.

        // BC Upgrade SHUKLP03 >> Added in interface Ext.
        // field(50063; "License Required"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        // }
        // field(50064; "Credit Info Required"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        // }
        // field(50075; "Zycus Order No."; Code[20])
        // {
        //     Caption = 'Zycus Order No.';
        //     Description = 'HEI.15';
        //     Editable = false;
        // }
        // field(50078; "Zycus GR UUID"; Text[50])
        // {
        //     Caption = 'Zycus GR UUID';
        //     Description = 'HEI.15,HEI.16';
        //     Editable = false;
        // }
        // field(50079; "Zycus GR Cancel UUID"; Text[50])
        // {
        //     Caption = 'Zycus GR Cancel UUID';
        //     Description = 'HEI.16';
        //     Editable = false;
        // }
        // field(50081; "PO Transaction Interface Zycus"; Code[20])
        // {
        //     Caption = 'PO Transaction Interface Zycus';
        //     Description = 'HEI.15';
        //     Editable = false;
        //     //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
        // }
        // field(50082; "GR Transaction Interface Zycus"; Code[20])
        // {
        //     Caption = 'GR Transaction Interface Zycus';
        //     Description = 'HEI.16';
        //     Editable = false;
        //     //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
        // }
        // field(50085; "Processed PO Transaction Zycus"; Boolean)
        // {
        //     Caption = 'Processed PO Transaction Zycus';
        //     Description = 'HEI.15';
        //     Editable = false;
        // }
        // field(50086; "Processed GR Transaction Zycus"; Boolean)
        // {
        //     Caption = 'Processed GR Transaction Zycus';
        //     Description = 'HEI.16';
        //     Editable = false;
        // }
        // BC Upgrade SHUKLP03 << Added in interface Ext.

    }

    keys
    {
        key(Key1; "Document Type", "No.", "Doc. No. Occurrence", "Version No.")
        {
        }
    }

    fieldgroups
    {
    }
}

