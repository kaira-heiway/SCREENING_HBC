

tableextension 58024 "PurchaseHeaderAdditExt_INT" extends "Purchase Header Additional FND"
{
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




    fields
    {
        field(50002; "Maximo Status INT"; Option)
        {
            Caption = 'Maximo Status';
            Description = 'HEI.02,HEI.17';
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval",PendClose;
        }
        field(50022; "LSR Order No INT"; Code[20])
        {
            Caption = 'LSR Order No';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            Editable = false;
        }
        field(50027; "Expected Date Departure INT"; Date)
        {
            Caption = 'Expected Departure Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50028; "Departure Date INT"; Date)
        {
            Caption = 'Departure Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50029; "Date Orig. Docs Sent INT"; Date)
        {
            Caption = 'Date Orig. Docs Sent';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50030; "Date Copy Docs Sent INT"; Date)
        {
            Caption = 'Date Copy Docs Sent';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50031; "Order FormTo Supplier Date INT"; Date)
        {
            Caption = 'Order Form To Supplier Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50032; "Expected Date to Ex Works INT"; Date)
        {
            Caption = 'Expected Date to Ex Works';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50035; "Vessel Name INT"; Text[50])
        {
            Caption = 'Vessel Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50036; "Expected Date Arrival INT"; Date)
        {
            Caption = 'Expected Date Arrival';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50037; "B/L-AWB INT"; Text[30])
        {
            Caption = 'B/L-AWB';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50038; "Shipment Description INT"; Text[50])
        {
            Caption = 'Shipment Description';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50039; "Order No. INT"; Text[30])
        {
            Caption = 'Order No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50040; "Tracking Information INT"; Text[250])
        {
            Caption = 'Tracking Information';
            DataClassification = ToBeClassified;
            Description = 'HEI.13,HEI.20';
            Editable = false;
        }
        field(50041; "Reference SDV INT"; Text[30])
        {
            Caption = 'Reference SDV';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50042; "Date Receipt Docs Supplier INT"; Date)
        {
            Caption = 'Date Receipt Docs Supplier';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50043; "Date ReceiptDocs Forwarder INT"; Date)
        {
            Caption = 'Date Receipt Docs Forwarder';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50044; "Volume in m3 INT"; Text[30])
        {
            Caption = 'Volume in m3';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50045; "Nbr cont. 20 feet INT"; Text[30])
        {
            Caption = 'Nbr cont. 20 feet';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50046; "Nbr cont. 40 feet INT"; Text[30])
        {
            Caption = 'Nbr cont. 40 feet';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50047; "PFI Document No. INT"; Code[20])
        {
            Caption = 'PFI Document No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            Editable = false;
        }
        field(50049; "Credit Number INT"; Text[30])
        {
            Caption = 'Credit Number';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(50050; "Credit Amount Of supplier INT"; Decimal)
        {
            Caption = 'Credit Amount Of supplier';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(50051; "Credit Validity Date INT"; Date)
        {
            Caption = 'Credit Validity Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(50052; "Last Date Of Shipment INT"; Date)
        {
            Caption = 'Last Date Of Shipment';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(50053; "Bank Who Issued Credit INT"; Text[50])
        {
            Caption = 'Bank Who Issued Credit';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(50054; "Ibecor Dossier No. INT"; Code[20])
        {
            Caption = 'Ibecor Dossier No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(50056; "WMS Export INT"; Boolean)
        {
            Caption = 'WMS Export';
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
        }
        field(50057; "Arrival Date Dest. Port INT"; Date)
        {
            Caption = 'Arrival Date In Port of Destination';
            DataClassification = ToBeClassified;
            Description = 'HEI.19';
        }
        field(50063; "License Required INT"; Boolean)
        {
            Caption = 'License Required';
            DataClassification = ToBeClassified;
            Description = 'HEI.24';
        }
        field(50064; "Credit Info Required INT"; Boolean)
        {
            Caption = 'Credit Info Required';
            DataClassification = ToBeClassified;
            Description = 'HEI.24';
        }
        field(50075; "Zycus Order No. INT"; Code[20])
        {
            Caption = 'Zycus Order No.';
            Description = 'HEI.27,HEI.29';
            Editable = false;
        }
        field(50078; "Zycus GR UUID INT"; Text[50])
        {
            Caption = 'Zycus GR UUID';
            Description = 'HEI.28,HEI.29,HEI.30';
            Editable = false;
        }
        field(50079; "Zycus GR Cancel UUID INT"; Text[50])
        {
            Caption = 'Zycus GR Cancel UUID';
            Description = 'HEI.30';
            Editable = false;
        }
        field(50081; "PO Transaction Intf. Zycus INT"; Code[20])
        {
            Caption = 'PO Transaction Interface Zycus';
            Description = 'HEI.28,HEI.29';
            Editable = false;
            TableRelation = "Interface Setup INT";
        }
        field(50082; "GR Transaction Intf Zycus INT"; Code[20])
        {
            Caption = 'GR Transaction Interface Zycus';
            Description = 'HEI.30';
            Editable = false;
            TableRelation = "Interface Setup INT";
        }
        field(50085; "Processed PO Trans. Zycus INT"; Boolean)
        {
            Caption = 'Processed PO Transaction Zycus';
            Description = 'HEI.28,HEI.29';
            Editable = false;
        }
        field(50086; "Processed GR Trans. Zycus INT"; Boolean)
        {
            Caption = 'Processed GR Transaction Zycus';
            Description = 'HEI.30';
            Editable = false;
        }
    }

    var
        PurchQttoOrd: Codeunit "Purch.-Quote to Order";
        grec_GeneralInterfaceSetup: Record "General Interface Setup INT";
        grec_InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceSetup: Record "Interface Setup INT";

}
