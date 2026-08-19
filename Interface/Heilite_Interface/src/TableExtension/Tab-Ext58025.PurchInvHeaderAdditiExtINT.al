namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

tableextension 58025 "PurchInvHeaderAdditiExt_INT" extends "Purch. Inv. Header Add FND"
{
    // HEI.02 FDD- HT821 IBM SHANKJ03 11.02.2020
    //   #New field added Maximo status
    // NRQ#157810 MSF 23/09/2020 Merge DIT PBI NRQ#34181 (partial Merge only for purchase)
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


    fields
    {
        field(50002; "Maximo Status INT"; Option)
        {
            Caption = 'Maximo Status';
            Description = 'HEI.02';
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        }
        field(50003; "Shopping Card No. INT"; Code[10])
        {
            Caption = 'Shopping Card No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
        }
        field(50022; "LSR Order No INT"; Code[20])
        {
            Caption = 'LSR Order No';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Editable = false;
        }
        field(50027; "Expected Date Departure INT"; Date)
        {
            Caption = 'Expected Date Departure';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50028; "Departure Date INT"; Date)
        {
            Caption = 'Departure Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50029; "Date Orig. Docs Sent INT"; Date)
        {
            Caption = 'Date Orig. Docs Sent';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50030; "Date Copy Docs Sent INT"; Date)
        {
            Caption = 'Date Copy Docs Sent';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50031; "Order Form To Suppl. Date INT"; Date)
        {
            Caption = 'Order Form To Supplier Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50032; "Expected Date to Ex Works INT"; Date)
        {
            Caption = 'Expected Date to Ex Works';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50035; "Vessel Name INT"; Text[50])
        {
            Caption = 'Vessel Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50036; "Expected Date Arrival INT"; Date)
        {
            Caption = 'Expected Date Arrival';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50037; "B/L-AWB INT"; Text[30])
        {
            Caption = 'B/L-AWB';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50038; "Shipment Description INT"; Text[50])
        {
            Caption = 'Shipment Description';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50039; "Order No. INT"; Text[30])
        {
            Caption = 'Order No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50040; "Tracking Information INT"; Text[250])
        {
            Caption = 'Tracking Information';
            DataClassification = ToBeClassified;
            Description = 'HEI.04,HEI.08';
            Editable = false;
        }
        field(50041; "Reference SDV INT"; Text[30])
        {
            Caption = 'Reference SDV';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50042; "Date Receipt Docs Supplier INT"; Date)
        {
            Caption = 'Date Receipt Docs Supplier';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50043; "Date Receipt Docs Forwarde INT"; Date)
        {
            Caption = 'Date Receipt Docs Forwarder';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50044; "Volume in m3 INT"; Text[30])
        {
            Caption = 'Volume in m3';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50045; "Nbr cont. 20 feet INT"; Text[30])
        {
            Caption = 'Nbr cont. 20 feet';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50046; "Nbr cont. 40 feet INT"; Text[30])
        {
            Caption = 'Nbr cont. 40 feet';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50047; "PFI Document No. INT"; Code[20])
        {
            Caption = 'PFI Document No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50049; "Credit Number INT"; Text[30])
        {
            Caption = 'Credit Number';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50050; "Credit Amount Of supplier INT"; Decimal)
        {
            Caption = 'Credit Amount Of supplier';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50051; "Credit Validity Date INT"; Date)
        {
            Caption = 'Credit Validity Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50052; "Last Date Of Shipment INT"; Date)
        {
            Caption = 'Last Date Of Shipment';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50053; "Bank Who Issued Credit INT"; Text[50])
        {
            Caption = 'Bank Who Issued Credit';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50054; "Ibecor Dossier No. INT"; Code[20])
        {
            Caption = 'Ibecor Dossier No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50056; "WMS Export INT"; Boolean)
        {
            Caption = 'WMS Export';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(50057; "Arrival Date Destin. Port INT"; Date)
        {
            Caption = 'Arrival Date In Port of Destination';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(50063; "License Required INT"; Boolean)
        {
            Caption = 'License Required';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(50064; "Credit Info Required INT"; Boolean)
        {
            Caption = 'Credit Info Required';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(50075; "Zycus Order No. INT"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.13,HEI.14';
            Editable = false;
        }
        field(50078; "Zycus GR UUID INT"; Text[50])
        {
            Caption = 'Zycus GR UUID';
            Description = 'HEI.14,HEI.15';
            Editable = false;
        }
        field(50079; "Zycus GR Cancel UUID INT"; Text[50])
        {
            Caption = 'Zycus GR Cancel UUID';
            Description = 'HEI.15';
            Editable = false;
        }
        field(50081; "PO Trans. Interf. Zycus INT"; Code[20])
        {
            Caption = 'PO Transaction Interface Zycus';
            Description = 'HEI.14';
            Editable = false;
            TableRelation = "Interface Setup INT";
        }
        field(50082; "GR Trans. Interf. Zycus INT"; Code[20])
        {
            Caption = 'GR Transaction Interface Zycus';
            Description = 'HEI.15';
            Editable = false;
            TableRelation = "Interface Setup INT";
        }
        field(50085; "Processed PO Trans. Zycus INT"; Boolean)
        {
            Caption = 'Processed PO Transaction Zycus';
            Description = 'HEI.14';
            Editable = false;
        }
        field(50086; "Processed GR Trans. Zycus INT"; Boolean)
        {
            Caption = 'Processed GR Transaction Zycus';
            Description = 'HEI.15';
            Editable = false;
        }
    }
}
