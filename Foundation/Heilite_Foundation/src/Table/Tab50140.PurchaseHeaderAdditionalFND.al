table 50140 "Purchase Header Additional FND"
{
    // version NRQ157810,HEI.30

    // HEI.01 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # New Table created to extend Standard Table 38 - Purchase Header
    // FINXL11.00 HBA 03/05/2018 NRQ#69018: Added field 2029618 "IC Document" (Boolean)
    // HEI.02 FDD- HT821 IBM SHANKJ03 11.02.2020
    //   #New field added Maximo status
    // HEI.03 CHG2038388 FDD-HB1005 IBM GUNERE01 17.02.2020 # "Shopping Card No." field added
    // HEI.04 CHG2048419 FDD-HB1138 IBM SHANKJ03 02.04.2020
    //   # Added new Fields Mail sent, Mail sent Date Time
    // HEI.05 FDD HT1136 CHG2055070 IBM Shankj03 16.06.2020
    //   # Added new field "License code"
    // HEI.06 CHG2027215 FDD-HB858 IBM SHANKJ03 24.01.2020
    //    # New Field Added "House Number"
    // NRQ#157810 MSF 23/09/2020 Merge DIT PBI NRQ#34181 (partial Merge only for purchase)
    // HEI.08 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //   # New field created: 50020 - Special Order No.
    // HEI.09 CHG2081323 HB1619 IBM.GUNERE01 20.01.2021 # Limit PO field added
    // HEI.10 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields created: 50022 - LSR Order No
    // HEI.11 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # Import Identifier field added
    // HEI.12 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # New field added - 50024 - Exp Physical Del Date(Imp) - Date
    //   # New field added - 50025 - TO Reference - Code - 20
    // HEI.13 FDD-HB2174 CHG2104952 IBM NANDIS01 09.07.2021 Ibecor - PO API
    //   # New fields created from ID - 50027 to 50047 and 50049 to 50054
    // HEI.14 FDD-HT2159 - CHG2105031 IBM NASTAA02 04.08.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field created: 50048 - Region Code
    // HEI.15 CHG2121745 IBM BHATTA09 13.08.2021
    //   # New Option 'PendClose' added in "Maximo Status" option field
    // HEI.16 CHG2121745 IBM BHATTA09 24.08.2021
    //   # New Field created: 50055 - Shopping Card Creation Date
    // HEI.17 CHG2103752 IBM BHATTA09 07.09.2021
    //   # New Option PendClose added in Maximo Status field
    // HEI.18 FDD-HB2155 CHG2128694 IBM NANDIS01 28.10.2021 WMS PO
    //   # New field added - "WMS Export"
    // HEI.19 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New field added - ID - 50057 - Arrival Date Destination Port - Date
    // HEI.20 FDD-HB2174 CHG2129099 IBM NANDIS01 02.03.2022 Ibecor integration interface INT03 and INT04
    //   # Field length of field - "Tracking Information" extended to 250 from 30
    // HEI.21 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # New field "Astro Unique ID" (ID - 50058) added
    // HEI.22 CHG2155847 HB2821 IBM NANDIS01 26.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # field changed from "Astro Unique ID" (ID - 50058) to Astro WMS PO(Boolean)
    // HEI.23 CHG2167376 HB3082 NORRIQ KOROLA04 11.11.2022
    //   # Bank Reference Number,Bank who issued the License - fields created
    //   # License Expiration Date,CoD/CoC Number - fields created
    // HEI.24 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields created - "License Required" (ID-50063- Boolean) and "Credit Info Required" (ID-50064- Boolean)
    // HEI.25 CHG2177512 IBM NANDIS01 07.02.2023 - HB3207 Maintaining the reversal on Item change POs
    //   # PO Deletion will depend on new field created - "Deletion From Doc Shipping" (ID - 50065, Type - Boolean)
    // HEI.26 CHG2214459 IBM SRIVAS07 01.08.2023 - to amend the logic to get the license Number from the dimension license code
    //   # New fields created - "License Name" (ID-50066- Text[50])
    // HEI.27 CHG2210794 SAHAL01 08.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50076 - Zycus Order Line No.
    //                         50077 - Zycus Version No.
    // HEI.28 CHG2210794 SAHAL01 26.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 50078 - PO Type Code
    //                         50079 - PO Processing Type Code
    //                         50081 - PO Transaction Interface Zycus
    //                         50085 - Posted PO Transaction Zycus
    // HEI.29 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Removed New Fields: 50076 - Zycus Order Line No.
    //                         50077 - Zycus Version No.
    //                         50079 - PO Processing Type Code
    //   # Modified Fields Name: 50078 - Zycus PO Type Code
    //                           50085 - Processed PO Transaction Zycus
    //   # Modified Fields Properties.
    // HEI.30 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Modified Field Name: 50078 - Zycus GR UUID
    //   # Created New Fields: 50079 - Zycus GR Cancel UUID
    //                         50082 - GR Transaction Interface Zycus
    //                         50086 - Processed GR Transaction Zycus
    // BC Upgrade SHUKLP03 >> Added in interface ext.
    // HEI.10 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields created: 50022 - LSR Order No
    // HEI.13 FDD-HB2174 CHG2104952 IBM NANDIS01 09.07.2021 Ibecor - PO API
    //   # New fields created from ID - 50027 to 50047 and 50049 to 50054
    // HEI.15 CHG2121745 IBM BHATTA09 13.08.2021
    //   # New Option 'PendClose' added in "Maximo Status" option field
    // HEI.17 CHG2103752 IBM BHATTA09 07.09.2021
    //   # New Option PendClose added in Maximo Status field
    // HEI.18 FDD-HB2155 CHG2128694 IBM NANDIS01 28.10.2021 WMS PO
    //   # New field added - "WMS Export"
    // HEI.19 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New field added - ID - 50057 - Arrival Date Destination Port - Date
    // HEI.20 FDD-HB2174 CHG2129099 IBM NANDIS01 02.03.2022 Ibecor integration interface INT03 and INT04
    //   # Field length of field - "Tracking Information" extended to 250 from 30
    // HEI.24 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields created - "License Required" (ID-50063- Boolean) and "Credit Info Required" (ID-50064- Boolean)
    // HEI.27 CHG2210794 SAHAL01 08.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50076 - Zycus Order Line No.
    //                         50077 - Zycus Version No.
    // HEI.28 CHG2210794 SAHAL01 26.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 50078 - PO Type Code
    //                         50079 - PO Processing Type Code
    //                         50081 - PO Transaction Interface Zycus
    //                         50085 - Posted PO Transaction Zycus
    // HEI.29 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Removed New Fields: 50076 - Zycus Order Line No.
    //                         50077 - Zycus Version No.
    //                         50079 - PO Processing Type Code
    //   # Modified Fields Name: 50078 - Zycus PO Type Code
    //                           50085 - Processed PO Transaction Zycus
    //   # Modified Fields Properties.
    // HEI.30 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Modified Field Name: 50078 - Zycus GR UUID
    //   # Created New Fields: 50079 - Zycus GR Cancel UUID
    //                         50082 - GR Transaction Interface Zycus
    //                         50086 - Processed GR Transaction Zycus
    // BC Upgrade SHUKLP03 << Added in interface ext.
    Caption = 'Purchase Header Additional';

    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")//BCUpgrade sharmp16--PurchaseProcesstestchanges
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            Editable = false;
            // OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',//BCUpgrade sharmp16--PurchaseProcesstestchanges
            //                   FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';//BCUpgrade sharmp16--PurchaseProcesstestchanges
            // OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";//BCUpgrade sharmp16--PurchaseProcesstestchanges
        }
        field(3; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        FRA = 'N°';
            Editable = false;
        }
        field(50000; "PQ Approver"; Code[50])
        {
            Caption = 'PQ Approver';
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50001; "House Number"; Code[10])
        {
            Caption = 'House Number';
            Description = 'HEI.06';
        }
        // BC Upgrade SHUKLP03 >> Added field in Interface Ext
        // field(50002; "Maximo Status"; Option)
        // {
        //     Description = 'HEI.02,HEI.17';
        //     OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval",PendClose;
        // }
        // BC Upgrade SHUKLP03 << Added field in Interface Ext
        field(50003; "Shopping Card No."; Code[10])
        {
            Description = 'HEI.03';
        }
        field(50004; "License Code"; Code[20])
        {
            Description = 'HEI.05';
        }
        field(50017; "Mail Sent"; Boolean)
        {
            Description = 'HEI.04';
        }
        field(50018; "IC Order No."; Code[20])
        {
            Description = 'HEI.07';
            Editable = false;
        }
        field(50019; "Mail Sent Date Time"; DateTime)
        {
            Description = 'HEI.04';
        }
        field(50020; "Special Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            Editable = false;
        }
        field(50021; "Limit PO"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
        }
        // BC Upgrade SHUKLP03 >> Added fields in Interface Ext
        // field(50022; "LSR Order No"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.10';
        //     Editable = false;
        // }
        // BC Upgrade SHUKLP03 << Added fields in Interface Ext
        field(50023; "Import Identifier"; Boolean)
        {
            Caption = 'Import Identifier';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            Editable = false;
        }
        field(50024; "Exp Physical Del Date(Imp)"; Date)
        {
            Caption = 'Expected Physical Delivery Date(Imp)';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
        }
        field(50025; "TO Reference"; Code[20])
        {
            CalcFormula = Lookup("Purchase Line"."TO Reference FND" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No."),
                                                                       "TO Reference FND" = FILTER(<> '')));//BC UPGRADE SHARMP16 -- PO Process changes
            Description = 'HEI.12';
            Editable = false;
            FieldClass = FlowField;
        }
        // BC Upgrade SHUKLP03 - Moved to interface ext >>
        // field(50027; "Expected Date Departure"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50028; "Departure Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50029; "Date Orig. Docs Sent"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50030; "Date Copy Docs Sent"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50031; "Order Form To Supplier Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50032; "Expected Date to Ex Works"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50035; "Vessel Name"; Text[50])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50036; "Expected Date Arrival"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50037; "B/L-AWB"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50038; "Shipment Description"; Text[50])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50039; "Order No."; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50040; "Tracking Information"; Text[250])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13,HEI.20';
        //     Editable = false;
        // }
        // field(50041; "Reference SDV"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50042; "Date Receipt Docs Supplier"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50043; "Date Receipt Docs Forwarder"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50044; "Volume in m3"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50045; "Nbr cont. 20 feet"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50046; "Nbr cont. 40 feet"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // field(50047; "PFI Document No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        //     Editable = false;
        // }
        // BC Upgrade SHUKLP03 - Moved to interface ext <<
        field(50048; "Region Code"; Code[20])
        {
            Caption = 'Region Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.14';
            TableRelation = Location;
        }
        // BC Upgrade SHUKLP03 >> Added fields in Interface Ext
        // field(50049; "Credit Number"; Text[30])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        // }
        // field(50050; "Credit Amount Of supplier"; Decimal)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        // }
        // field(50051; "Credit Validity Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        // }
        // field(50052; "Last Date Of Shipment"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        // }
        // field(50053; "Bank Who Issued Credit"; Text[50])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        // }
        // field(50054; "Ibecor Dossier No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.13';
        // }
        // BC Upgrade SHUKLP03 << Added fields in Interface Ext
        field(50055; "Shopping Card Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.15';
        }
        // BC Upgrade SHUKLP03 >> Added fields in Interface Ext
        // field(50056; "WMS Export"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.18';
        // }

        // field(50057; "Arrival Date Destination Port"; Date)
        // {
        //     Caption = 'Arrival Date In Port of Destination';
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.19';
        // }
        // BC Upgrade SHUKLP03 << Added fields in Interface Ext
        field(50058; "Astro WMS PO"; Boolean)
        {
            Caption = 'Astro WMS PO';
            DataClassification = ToBeClassified;
            Description = 'HEI.21';
            Editable = false;
        }
        field(50059; "Bank Reference Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.23';
        }
        field(50060; "Bank who issued the License"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.23';
        }
        field(50061; "License Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.23';
        }
        field(50062; "CoD/CoC Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.23';
        }
        // BC Upgrade SHUKLP03 >> Added fields in Interface Ext
        // field(50063; "License Required"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.24';
        // }
        // field(50064; "Credit Info Required"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.24';
        // }
        // BC Upgrade SHUKLP03 << Added fields in Interface Ext
        field(50065; "Deletion From Doc Shipping"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.25';
        }
        field(50066; "License Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.26';
        }
        // BC Upgrade SHUKLP03 << Added fields in Interface Ext
        // field(50075; "Zycus Order No."; Code[20])
        // {
        //     Caption = 'Zycus Order No.';
        //     Description = 'HEI.27,HEI.29';
        //     Editable = false;
        // }
        // field(50078; "Zycus GR UUID"; Text[50])
        // {
        //     Caption = 'Zycus GR UUID';
        //     Description = 'HEI.28,HEI.29,HEI.30';
        //     Editable = false;
        // }
        // field(50079; "Zycus GR Cancel UUID"; Text[50])
        // {
        //     Caption = 'Zycus GR Cancel UUID';
        //     Description = 'HEI.30';
        //     Editable = false;
        // }
        // field(50081; "PO Transaction Interface Zycus"; Code[20])
        // {
        //     Caption = 'PO Transaction Interface Zycus';
        //     Description = 'HEI.28,HEI.29';
        //     Editable = false;
        //     //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
        // }
        // field(50082; "GR Transaction Interface Zycus"; Code[20])
        // {
        //     Caption = 'GR Transaction Interface Zycus';
        //     Description = 'HEI.30';
        //     Editable = false;
        //     //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
        // }
        // field(50085; "Processed PO Transaction Zycus"; Boolean)
        // {
        //     Caption = 'Processed PO Transaction Zycus';
        //     Description = 'HEI.28,HEI.29';
        //     Editable = false;
        // }
        // field(50086; "Processed GR Transaction Zycus"; Boolean)
        // {
        //     Caption = 'Processed GR Transaction Zycus';
        //     Description = 'HEI.30';
        //     Editable = false;
        // }
        // BC Upgrade SHUKLP03 << Added fields in Interface Ext
        ////BC UPGRADE Comment Drink-IT fields begin<<
        // field(2013635;"Split Deposit on Invoice";Boolean)
        // {
        //     // CalcFormula = Exist("Purchase Line" WHERE ("Document Type"=FIELD("Document Type"),
        //     //                                            "Document No."=FIELD("No."),
        //     //                                            "Split Deposit on Invoice"=CONST(true)));//BC UPGRADE Comment becuase Purchase Line is not used yet
        //     Caption = 'Split Deposit on Invoice (Entries)';
        //     Description = 'DITW110.00.11 NRQ#34181';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013640;"Deposit Vendor Invoice No.";Code[35])
        // {
        //     Caption = 'Deposit Vendor Invoice No.';
        //     Description = 'DITW110.00.11 NRQ#34181';
        // }
        // field(2013641;"Deposit Vendor Cr. Memo No.";Code[35])
        // {
        //     Caption = 'Deposit Vendor Cr. Memo No.';
        //     Description = 'DITW110.00.11 NRQ#34181';
        // }
        // field(2029618;"IC Document";Boolean)
        // {
        //     Caption = 'IC Document';
        //     Description = 'Description=FINXL11.00';
        // }
        //BC UPGRADE Comment Drink-IT fields end<<
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
    //grec_GeneralInterfaceSetup: Record "General Interface Setup";
    //grec_InterfaceSetup: Record "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
    //  InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
    // InterfaceEntryHeaderOut: Record "Interface Entry Header";
    //OutboundInterface: Record "Outbound Interface INT";
    //InterfaceSetup: Record "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
}