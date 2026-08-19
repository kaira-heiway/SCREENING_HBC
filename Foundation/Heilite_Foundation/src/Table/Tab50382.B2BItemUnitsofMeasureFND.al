table 50382 "B2B Item Units of Measure FND"
{
    // Heilite Navision Old Id - 50194
    // version HEI.01

    // HEI.01 CHG2174122 HB3137 BHANDS01 13.02.2023 # Control for which UOM prices sent to B2B
    //   # New table created

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "B2B Item Units of Measure" to "B2B Item Units of Measure FND"
    // BC Upgrade PATELP08<<

    fields
    {
        field(1; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.',
                        FRA = 'N° article';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Code"; Code[10])
        {
            CaptionML = ENU = 'Code',
                        FRA = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Unit of Measure";
        }
        field(3; "B2B UOM"; Boolean)
        {
            Caption = 'B2B UOM';
            DataClassification = ToBeClassified;
        }
        field(4; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
        }
        field(5; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

