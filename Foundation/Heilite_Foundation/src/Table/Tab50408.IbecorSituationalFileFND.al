table 50408 "Ibecor Situational File FND"
{
    // Heilite Navision Old Id - 80079
    // version HEI.03

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 20.07.2021 Ibecor - PO API
    //   # New Table created
    // HEI.02 FDD-HB2174 CHG2129099 IBM NANDIS01 22.02.2022 Ibecor integration interface INT03 and INT04
    //   # New field added - ID - 34 - Arrival Date Destination Port - Data Type - Date
    // HEI.03 CHG2290079_HB4228_StP_Report CHOUDS08 24.02.2025 for Ibecor- Heilite Integration INT04- shipment update II V
    //   # New field added - ID - 35 - Update Date & Time - Data Type - DateTime

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Ibecor Situational File FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<


    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Shipment No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Expected Date Departure"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Departure Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Date Orig. Docs Sent"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Date Copy Docs Sent"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Date Orig. CRF Sent"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Date Copy CRF Sent"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Date Orig. B/L Sent"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Date Copy B/L Sent"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Vessel Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Expected Date Arrival"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "B/L-AWB"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Shipment Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Order No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Tracking Information"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Reference SDV"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Date Receipt Docs Supplier"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Date Receipt Docs Forwarder"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Volume in m3"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Nbr cont. 20 feet"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; "Nbr cont. 40 feet"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Shipment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Registered,Current;
        }
        field(33; "Dossier Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Arrival Date Destination Port"; Date)
        {
            Caption = 'Arrival Date In Port of Destination';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(35; "Update Date & Time"; DateTime)
        {
            Caption = 'Update Date & Time';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "Order No.", "Shipment No.", "Shipment Type")
        {
        }
    }

    fieldgroups
    {
    }
}

