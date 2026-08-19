namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

tableextension 50272 PurchRcptHeaderAddExtFND extends "Purch. Rcpt. Header Add FND"
{
    // HEI.02 FDD- HT821 IBM SHANKJ03 11.02.2020
    //   #New field added Maximo status
    // HEI.03 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields created: 50022 - LSR Order No
    // HEI.04 FDD-HB2174 CHG2104952 IBM NANDIS01 09.07.2021 Ibecor - PO API
    //   # New fields created from ID - 50027 to 50047 AND 50049 to 50054
    // HEI.06 FDD-HB2155 CHG2128694 IBM NANDIS01 28.10.2021 WMS PO
    //   # New field added - "WMS Export"
    // HEI.07 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New field added - ID - 50057 - Arrival Date Destination Port - Date
    // HEI.08 FDD-HB2174 CHG2129099 IBM NANDIS01 02.03.2022 Ibecor integration interface INT03 and INT04
    //   # Field length of field - "Tracking Information" extended to 250 from 30
    // HEI.11 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields created - "License Required" (ID-50063- Boolean) and "Credit Info Required" (ID-50064- Boolean)
    // HEI.12 CHG2190299 FDD-HB3316 IBM NANDIS01 26.07.2023 # POSM eshop SRM- HL interface
    //   # Added new field "Shopping Card No."(id - 50003, Code[10])
    // HEI.13 CHG2210794 SAHAL01 19.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50076 - Zycus Order Line No.
    //                         50077 - Zycus Version No.
    // HEI.14 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Removed New Fields: 50076 - Zycus Order Line No.
    //                         50077 - Zycus Version No.
    //   # Created New Fields: 50078 - Zycus PO Type Code
    //                         50081 - PO Transaction Interface Zycus
    //                         50085 - Processed PO Transaction Zycus
    //   # Modified Fields Properties.
    // HEI.15 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Modified Field Name: 50078 - Zycus GR UUID
    //   # Created New Fields: 50079 - Zycus GR Cancel UUID
    //                         50082 - GR Transaction Interface Zycus
    //                         50086 - Processed GR Transaction Zycus

    // Bc Upgrade PATELP08>>
    // Changes table ext name from "PurchRcptHeaderAdditionalInExt" to "PurchRcptHeaderAddInExt"
    // Bc upgeade PATELP08<<

    fields
    {
        field(50002; "Maximo Status FND"; Option)
        {
            Description = 'HEI.02';
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
            Caption = 'Maximo Status';
        }
        field(50003; "Shopping Card No. FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
            Caption = 'Shopping Card No.';
        }
        field(50022; "LSR Order No FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
            Caption = 'LSR Order No';
        }
        field(50027; "Expected Date Departure FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Expected Date Departure';
        }
        field(50028; "Departure Date FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Departure Date';
        }
        field(50029; "Date Orig. Docs Sent FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Date Orig. Docs Sent';
        }
        field(50030; "Date Copy Docs Sent FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Date Copy Docs Sent';
        }
        field(50031; "Ord. Frm To Suppl. Date FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Order Form To Supplier Date';
        }
        field(50032; "Expected Date to Ex Works FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Expected Date to Ex Works';
        }
        field(50035; "Vessel Name FND"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Vessel Name';
        }
        field(50036; "Expected Date Arrival FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Expected Date Arrival';
        }
        field(50037; "B/L-AWB FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'B/L-AWB';
        }
        field(50038; "Shipment Description FND"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Shipment Description';
        }
        field(50039; "Order No. FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Order No.';
        }
        field(50040; "Tracking Information FND"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04,HEI.08';
            Editable = false;
            Caption = 'Tracking Information';
        }
        field(50041; "Reference SDV FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Reference SDV';
        }
        field(50042; "Date Receipt Docs Supplier FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Date Receipt Docs Supplier';
        }
        field(50043; "Date Rcpt Docs Forwarder FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Date Receipt Docs Forwarder';
        }
        field(50044; "Volume in m3 FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Volume in m3';
        }
        field(50045; "Nbr cont. 20 feet FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Nbr cont. 20 feet';
        }

        field(50046; "Nbr cont. 40 feet FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'Nbr cont. 40 feet';
        }
        field(50047; "PFI Document No. FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
            Caption = 'PFI Document No.';
        }
        field(50049; "Credit Number FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'Credit Number';
        }
        field(50050; "Credit Amount Of supplier FND"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'Credit Amount Of supplier';
        }
        field(50051; "Credit Validity Date FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'Credit Validity Date';
        }
        field(50052; "Last Date Of Shipment FND"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'Last Date Of Shipment';
        }
        field(50053; "Bank Who Issued Credit FND"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'Bank Who Issued Credit';
        }
        field(50054; "Ibecor Dossier No. FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'Ibecor Dossier No.';
        }
        field(50056; "WMS Export FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            Caption = 'WMS Export';
        }
        field(50057; "Arrival Date Dest. Port FND"; Date)
        {
            Caption = 'Arrival Date In Port of Destination';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(50063; "License Required FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            Caption = 'License Required';
        }
        field(50064; "Credit Info Required FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            Caption = 'Credit Info Required';
        }
        field(50075; "Zycus Order No. FND"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.13,HEI.14';
            Editable = false;
        }
        field(50078; "Zycus GR UUID FND"; Text[50])
        {
            Caption = 'Zycus GR UUID';
            Description = 'HEI.14,HEI.15';
            Editable = false;
        }
        field(50079; "Zycus GR Cancel UUID FND"; Text[50])
        {
            Caption = 'Zycus GR Cancel UUID';
            Description = 'HEI.15';
            Editable = false;
        }
        field(50081; "PO Trans. Interf. Zycus FND"; Code[20])
        {
            Caption = 'PO Transaction Interface Zycus';
            Description = 'HEI.14';
            Editable = false;
            //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
        }
        field(50082; "GR Trans. Interf. Zycus FND"; Code[20])
        {
            Caption = 'GR Transaction Interface Zycus';
            Description = 'HEI.15';
            Editable = false;
            //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
        }
        field(50085; "Procsd. PO Trans. Zycus FND"; Boolean)
        {
            Caption = 'Processed PO Transaction Zycus';
            Description = 'HEI.14';
            Editable = false;
        }
        field(50086; "Procsd. GR Trans. Zycus FND"; Boolean)
        {
            Caption = 'Processed GR Transaction Zycus';
            Description = 'HEI.15';
            Editable = false;
        }

    }
}

