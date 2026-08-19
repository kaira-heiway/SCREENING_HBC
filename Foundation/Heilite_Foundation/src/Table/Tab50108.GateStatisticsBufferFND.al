table 50108 "Gate Statistics Buffer FND"
{
    // version HEI.02

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Table Created for Gate Entry
    // HEI:EDD151:1:1 17/08/11 NJ
    //   # Added new field 80000 'Location Code' [Code 20]
    // 
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Table 80053 - Gate Statistics Buffer from HEI2.0
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"

    DrillDownPageID = "Gate Entry Line Lists";
    LookupPageID = "Gate Entry Line Lists";

    fields
    {
        field(1; "Gate Entry Document No."; Code[20])
        {
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(5; "Unit Of Measure Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Unit of Measure".Code;
        }
        field(7; "Quantity on Arrival"; Decimal)
        {
            CalcFormula = Sum("Gate Entry Line FND"."Quantity on Arrival" where("Gate Entry Document No." = FIELD("Gate Entry Document No."),
                                                                             "Unit Of Measure Code" = FIELD("Unit Of Measure Code"),
                                                                             "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Quantity on Departure"; Decimal)
        {
            CalcFormula = Sum("Gate Entry Line FND"."Quantity on Departure" where("Gate Entry Document No." = FIELD("Gate Entry Document No."),
                                                                               "Unit Of Measure Code" = FIELD("Unit Of Measure Code"),
                                                                               "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Posted Quantity Inbound"; Decimal)
        {
            CalcFormula = Sum("Gate Entry Line FND"."Posted Quantity Inbound" where("Gate Entry Document No." = FIELD("Gate Entry Document No."),
                                                                                 "Unit Of Measure Code" = FIELD("Unit Of Measure Code"),
                                                                                 "Location Code" = FIELD("Location Code")));
            Caption = 'Posted Quantity Inbound';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Posted Quantity Outbound"; Decimal)
        {
            CalcFormula = Sum("Gate Entry Line FND"."Posted Quantity Outbound" where("Gate Entry Document No." = FIELD("Gate Entry Document No."),
                                                                                  "Unit Of Measure Code" = FIELD("Unit Of Measure Code"),
                                                                                  "Location Code" = FIELD("Location Code")));
            Caption = 'Posted Quantity Outbound';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Net Change 1"; Decimal)
        {
            Editable = false;
        }
        field(12; "Net Change 2"; Decimal)
        {
            Editable = false;
        }
        field(13; Deviation; Decimal)
        {
            Editable = false;
        }
        field(80000; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Location Code';
            TableRelation = Location;
        }
        field(80001; "Zone Code"; Code[10])
        {
            Description = 'HEI.02';
            TableRelation = Zone.Code;
        }
    }

    keys
    {
        key(Key1; "Gate Entry Document No.", "Unit Of Measure Code", "Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        WhseSetup: Record "Warehouse Setup";
}

