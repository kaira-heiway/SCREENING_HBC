table 50395 "Last Send Interface Values FND"
{
    // Heilite Navision Old Id - 50209

    // HEI.01 HB1986 - CHG2095257 IBM NANDIS01 16.03.2021 - Maximo Unit Cost interface Redesign
    //   # New table created to store the data of Maximo Unit cost sent to Maximo from Heilite

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "Last Send Interface Values" to "Last Send Interface Values FND"
    // BC Upgrade PATELP08<<
    
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Interface Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Send Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Unit Of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Zone Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Direct Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Sync. Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Item Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Gen Prod Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "CMG Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        "Sync. Date" := CURRENTDATETIME;
    end;
}

