table 50365 "C2S Reconciliation FND"
{
    // version HEI.05

    // HEI.01 HB2761 IBM BULIMC01 13/04/2022#new table created in order to show the figures for C2s Reconcilation
    // HEI.02 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //   #new fields added marked with HEI.02
    // HEI.03 CHG2169207 IBM SISUM01 15/08/2022 #add to Description field, option: RPM Internal Transfer
    // HEI.04 CHG2175297 IBM SISUM01 30/03/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #change Description options and add fields marked with HEI.04
    // HEI.05 CHG2175297 IBM SISUM01 25/04/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #add new option values for Description field: Line26

    // BC Upgrade KUMARS145 Nav ID Table 50237 "C2S Reconciliation FND"

    fields
    {
        field(1; Description; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            Editable = false;
            OptionCaption = 'Line1,Line2,Line3,Line4,Line5,Line6,Line7,Line8,Line9,Line10,Line11,Line12,Line13,Line14,Line15,Line16,Line17,Line18,Line19,Line20,Line21,Line22,Line23,Line24,Line25,Line26,Line27,line28,Line29,Line30,Line31,Line32,Line33,Line34,Line35,Line36,Line37,Line38,Line39,Line40,Line41,Line42,Line43,Line44,Line45,Line46,Line47,Line48,Line49,Line50,Line51,Line52,Line53,Line54,Line55,Line56,Line57,Line58,Line59,Line60,Line61,Line62,Line63,Line64,Line65,Line66';
            OptionMembers = Line1,Line2,Line3,Line4,Line5,Line6,Line7,Line8,Line9,Line10,Line11,Line12,Line13,Line14,Line15,Line16,Line17,Line18,Line19,Line20,Line21,Line22,Line23,Line24,Line25,Line26,Line27,line28,Line29,Line30,Line31,Line32,Line33,Line34,Line35,Line36,Line37,Line38,Line39,Line40,Line41,Line42,Line43,Line44,Line45,Line46,Line47,Line48,Line49,Line50,Line51,Line52,Line53,Line54,Line55,Line56,Line57,Line58,Line59,Line60,Line61,Line62,Line63,Line64,Line65,Line66;
        }
        field(2; Total; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Allocated; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Unallocated; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Reversed Entries"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Shipment of non FG"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Missing Shipments"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Period Date"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Total 3rd Party"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(10; "Allocated 3rd Party"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(11; "Unallocated 3rd Party"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(12; "Total Own Fleet"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(13; "Allocated Own Fleet"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(14; "Unallocated Own Fleet"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(15; "Total Gen. Overh. 3rd P."; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Gen. Overheads 3rd Party';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(16; "Allocated Gen. Overh. 3rd P."; Decimal)
        {
            BlankZero = true;
            Caption = 'Allocated Gen. Overheads 3rd Party';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(17; "Unallocated Gen. Overh. 3rd P."; Decimal)
        {
            BlankZero = true;
            Caption = 'Unallocated Gen. Overheads 3rd Party';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(18; "Total Gen. Overh. OwnF."; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Gen. Overheads Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(19; "Allocated Gen. Overh. OwnF."; Decimal)
        {
            BlankZero = true;
            Caption = 'Allocated Gen. Overheads Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(20; "Unallocated Gen. Overh. OwnF."; Decimal)
        {
            BlankZero = true;
            Caption = 'Unallocated Gen. Overheads Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(21; "Total Gen. Overh."; Decimal)
        {
            BlankZero = true;
            Caption = 'Total General Overheads';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(22; "Allocated Gen. Overh."; Decimal)
        {
            BlankZero = true;
            Caption = 'Allocated General Overheads';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(23; "Unallocated Gen. Overh."; Decimal)
        {
            BlankZero = true;
            Caption = 'Unallocated General Overheads';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(24; "Total Whse. Overh. 3rd P."; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Whse. Overheads 3rd Party';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(25; "Allocated Whse. Overh. 3rd P."; Decimal)
        {
            BlankZero = true;
            Caption = 'Allocated Whse. Overheads 3rd Party';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(26; "Unallocated Whs. Overh. 3rd P."; Decimal)
        {
            BlankZero = true;
            Caption = 'Unallocated Whse. Overheads 3rd Party';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(27; "Total Whse. Overh. OwnF."; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Whse. Overheads Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(28; "Allocated Whse. Overh. OwnF."; Decimal)
        {
            BlankZero = true;
            Caption = 'Allocated Whse. Overheads Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(29; "Unallocated Whse. Overh. OwnF."; Decimal)
        {
            BlankZero = true;
            Caption = 'Unallocated Whse. Overheads Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(30; "Total Whse. Overh."; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Warehouse Overheads';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(31; "Allocated Whse. Overh."; Decimal)
        {
            BlankZero = true;
            Caption = 'Allocated Warehouse Overheads';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(32; "Unallocated Whse. Overh."; Decimal)
        {
            BlankZero = true;
            Caption = 'Unallocated Warehouse Overheads';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(33; "Total Whse. Handl. 3rd P."; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Whse. Handling 3rd Party';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(34; "Allocated Whse. Handl. 3rd P."; Decimal)
        {
            BlankZero = true;
            Caption = 'Allocated Whse. Handling 3rd Party';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(35; "Unallocated Whs. Handl. 3rd P."; Decimal)
        {
            BlankZero = true;
            Caption = 'Unallocated Whs. Handling 3rd Party';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(36; "Total Whse. Handl. OwnF."; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Whse. Handling Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(37; "Allocated Whse. Handl. OwnF."; Decimal)
        {
            BlankZero = true;
            Caption = 'Allocated Whse. Handling Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(38; "Unallocated Whse. Handl. OwnF."; Decimal)
        {
            BlankZero = true;
            Caption = 'Unallocated Whse. Handling Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(39; "Total Whse. Handl."; Decimal)
        {
            BlankZero = true;
            Caption = 'Total Warehouse Handling';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(40; "Allocated Whse. Handl."; Decimal)
        {
            BlankZero = true;
            Caption = 'Allocated Warehouse Handling';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(41; "Unallocated Whse. Handl."; Decimal)
        {
            BlankZero = true;
            Caption = 'Unallocated Warehouse Handling';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(42; "Block Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(43; "Line Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
    }

    keys
    {
        key(Key1; Description)
        {
        }
    }

    fieldgroups
    {
    }
}

