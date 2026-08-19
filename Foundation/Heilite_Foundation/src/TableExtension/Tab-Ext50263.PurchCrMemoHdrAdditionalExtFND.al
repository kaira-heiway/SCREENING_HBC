namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

tableextension 50263 PurchCrMemoHdrAdditionalExtFND extends "Purch. Cr. Memo Hdr. Add FND"
{
    // HEI.02 FDD- HT821 IBM SHANKJ03 11.02.2020
    //   #New field added Maximo status
    // HEI.04 FDD-HB2174 CHG2104952 IBM NANDIS01 09.07.2021 Ibecor - PO API
    //   # New fields created from ID - 50027 to 50047 and 50049 to 50054
    // HEI.05 FDD-HB2155 CHG2128694 IBM NANDIS01 28.10.2021 WMS PO
    //   # New field added - "WMS Export"
    // HEI.07 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New field added - ID - 50057 - Arrival Date Destination Port - Date
    // HEI.08 FDD-HB2174 CHG2129099 IBM NANDIS01 02.03.2022 Ibecor integration interface INT03 and INT04
    //   # Field length of field - "Tracking Information" extended to 250 from 30
    // HEI.11 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields created - "License Required" (ID-50063- Boolean) and "Credit Info Required" (ID-50064- Boolean)
    // HEI.12 CHG2190299 FDD-HB3316 IBM NANDIS01 26.07.2023 # POSM eshop SRM- HL interface
    //   # Added new field "Shopping Card No."(id - 50003, Code[10])
    // HEI.13 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Fields: 50075 - Zycus Order No.
    //                         50078 - Zycus PO Type Code
    //                         50081 - PO Transaction Interface Zycus
    //                         50085 - Processed PO Transaction Zycus
    // HEI.14 CHG2210794 SAHAL01 15.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Modified Field Name: 50078 - Zycus GR UUID
    //   # Created New Fields: 50079 - Zycus GR Cancel UUID
    //                         50082 - GR Transaction Interface Zycus
    //                         50086 - Processed GR Transaction Zycus

    fields
    {
        field(50002; "Maximo Status FND"; Option)
        {
            Caption = 'Maximo Status';
            Description = 'HEI.02';
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        }
        field(50003; "Shopping Card No. FND"; Code[10])
        {
            Caption = 'Shopping Card No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
        }
        field(50027; "Expected Date Departure FND"; Date)
        {
            Caption = 'Expected Date Departure';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50028; "Departure Date FND"; Date)
        {
            Caption = 'Departure Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50029; "Date Orig. Docs Sent FND"; Date)
        {
            Caption = 'Date Orig. Docs Sent';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50030; "Date Copy Docs Sent FND"; Date)
        {
            Caption = 'Date Copy Docs Sent';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50031; "Ord. Frm To Suppl. Date FND"; Date)
        {
            Caption = 'Order Form To Supplier Date FND';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50032; "Expected Date to Ex Works FND"; Date)
        {
            Caption = 'Expected Date to Ex Works';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50035; "Vessel Name FND"; Text[50])
        {
            Caption = 'Vessel Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50036; "Expected Date Arrival FND"; Date)
        {
            Caption = 'Expected Date Arrival';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50037; "B/L-AWB FND"; Text[30])
        {
            Caption = 'B/L-AWB';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50038; "Shipment Description FND"; Text[50])
        {
            Caption = 'Shipment Description';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50039; "Order No. FND"; Text[30])
        {
            Caption = 'Order No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50040; "Tracking Information FND"; Text[250])
        {
            Caption = 'Tracking Information';
            DataClassification = ToBeClassified;
            Description = 'HEI.04,HEI.08';
            Editable = false;
        }
        field(50041; "Reference SDV FND"; Text[30])
        {
            Caption = 'Reference SDV';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50042; "Date Receipt Docs Supplier FND"; Date)
        {
            Caption = '';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50043; "Date Rcpt Docs Forwarder FND"; Date)
        {
            Caption = 'Date Receipt Docs Forwarder FND';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50044; "Volume in m3 FND"; Text[30])
        {
            Caption = 'Volume in m3';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50045; "Nbr cont. 20 feet FND"; Text[30])
        {
            Caption = 'Nbr cont. 20 feet';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50046; "Nbr cont. 40 feet FND"; Text[30])
        {
            Caption = 'Nbr cont. 40 feet';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50047; "PFI Document No. FND"; Code[20])
        {
            Caption = 'PFI Document No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50049; "Credit Number FND"; Text[30])
        {
            Caption = 'Credit Number';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50050; "Credit Amount Of supplier FND"; Decimal)
        {
            Caption = 'Credit Amount Of supplier';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50051; "Credit Validity Date FND"; Date)
        {
            Caption = 'Credit Validity Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50052; "Last Date Of Shipment FND"; Date)
        {
            Caption = 'Last Date Of Shipment';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50053; "Bank Who Issued Credit FND"; Text[50])
        {
            Caption = 'Bank Who Issued Credit';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50054; "Ibecor Dossier No. FND"; Code[20])
        {
            Caption = 'Ibecor Dossier No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50056; "WMS Export FND"; Boolean)
        {
            Caption = 'WMS Export';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(50057; "Arrival Date Dest. Port FND"; Date)
        {
            Caption = 'Arrival Date In Port of Destination';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(50063; "License Required FND"; Boolean)
        {
            Caption = 'License Required';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(50064; "Credit Info Required FND"; Boolean)
        {
            Caption = 'Credit Info Required';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(50075; "Zycus Order No. FND"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.13';
            Editable = false;
        }
        field(50078; "Zycus GR UUID FND"; Text[50])
        {
            Caption = 'Zycus GR UUID';
            Description = 'HEI.13,HEI.14';
            Editable = false;
        }
        field(50079; "Zycus GR Cancel UUID FND"; Text[50])
        {
            Caption = 'Zycus GR Cancel UUID';
            Description = 'HEI.14';
            Editable = false;
        }
        field(50081; "PO Trans. Interf. Zycus FND"; Code[20])
        {
            Caption = 'PO Transaction Interface Zycus';
            Description = 'HEI.13';
            Editable = false;
            //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
        }
        field(50082; "GR Trans. Interf. Zycus FND"; Code[20])
        {
            Caption = 'GR Transaction Interface Zycus';
            Description = 'HEI.14';
            Editable = false;
            //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension
        }
        field(50085; "Procsd. PO Trans. Zycus FND"; Boolean)
        {
            Caption = 'Processed PO Transaction Zycus';
            Description = 'HEI.13';
            Editable = false;
        }
        field(50086; "Procsd. GR Trans. Zycus FND"; Boolean)
        {
            Caption = 'Processed GR Transaction Zycus';
            Description = 'HEI.14';
            Editable = false;
        }

    }
}
