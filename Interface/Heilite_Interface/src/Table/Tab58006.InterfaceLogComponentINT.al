table 58006 "Interface Log Component INT"
{
    // Heilite Navision Old Id - 50006
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New table for Interface Common Framework

    Caption = 'Interface Log Component';

    fields
    {
        field(1; "Header Entry No."; Integer)
        {
            Caption = 'Header Entry No.';
            TableRelation = "Interface Entry Header INT";
        }
        field(2; "Line Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Line Entry No.';
            TableRelation = "Interface Entry Line INT"."Entry No." WHERE("Header Entry No." = FIELD("Header Entry No."));
        }
        field(3; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));

            trigger OnLookup();
            var
                TempAllObjWithCaption: Record AllObjWithCaption temporary;
            begin
            end;

            trigger OnValidate();
            var
                TempAllObjWithCaption: Record AllObjWithCaption temporary;
            begin
            end;
        }
        field(4; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(5; "Value Code"; Code[20])
        {
            Caption = 'Value Code';
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table ID")));
            Caption = 'Table Caption';
            FieldClass = FlowField;
        }
        field(10; "Approver ID"; Code[50])
        {
            Caption = 'Approver ID';
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.LookupUserID("Approver ID");  // BC Upgrade NANDIS03
                UserMgt.DisplayUserInformation("Approver ID");  // BC Upgrade NANDIS03
            end;
        }
        field(11; "Approver Name"; Text[80])
        {
            Caption = 'Approver Name';
        }
        field(20; "Table Is Master Data"; Boolean)
        {
            Caption = 'Table Is Master Data';
        }
        field(75; "Type ID"; Code[10])
        {
            Caption = 'Type ID';
        }
        field(80; "Price Starting Date"; Date)
        {
            Caption = 'Price Starting Date';
        }
        field(81; "Price Ending Date"; Date)
        {
            Caption = 'Price Ending Date';
        }
        field(82; "Price Location Code"; Code[10])
        {
            Caption = 'Price Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            ValidateTableRelation = false;
        }
        field(90; "Price Currency Code"; Code[10])
        {
            Caption = 'Price Currency Code';
            TableRelation = Currency;
            ValidateTableRelation = false;
        }
        field(91; "Price UoM Code"; Code[10])
        {
            Caption = 'Price UoM Code';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(92; "Price Direct Unit Cost Multip."; Decimal)
        {
            Caption = 'Price Direct Unit Cost Multip.';
        }
        field(93; "Price Direct Cost Per Multip."; Decimal)
        {
            Caption = 'Price Direct Cost Per Multip.';
        }
        field(103; "Scale Minimum Quantity"; Decimal)
        {
            Caption = 'Scale Minimum Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(104; "Scale Unit of Measure Code"; Code[10])
        {
            Caption = 'Scale Unit of Measure Code';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(105; "Scale Currency Code"; Code[10])
        {
            Caption = 'Scale Currency Code';
            TableRelation = Currency;
            ValidateTableRelation = false;
        }
        field(106; "Scale Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Scale Direct Unit Cost';
            MinValue = 0;
        }
        field(107; "Scale Direct Unit Cost Multip."; Decimal)
        {
            Caption = 'Scale Direct Unit Cost Multip.';
        }
        field(108; "Scale Direct Cost Per Multip."; Decimal)
        {
            Caption = 'Scale Direct Cost Per Multip.';
        }
        field(109; "Scale Rate UoM Code"; Code[10])
        {
            Caption = 'Scale Rate UoM Code';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(500; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.';
            TableRelation = "Data Exch.";
        }
    }

    keys
    {
        key(Key1; "Header Entry No.", "Line Entry No.", "Table ID", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

