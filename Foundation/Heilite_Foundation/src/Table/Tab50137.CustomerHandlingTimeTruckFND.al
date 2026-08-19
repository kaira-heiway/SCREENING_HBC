table 50137 "Cust  Handling Time Truck FND"
{
    // HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new table

    // BC Upgrade BHARDA11
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(2; "Unloading Time  Fixed"; Integer)
        {
            Caption = 'Unloading Time  Fixed';
        }
        field(3; "Unloading Time Variable"; Decimal)
        {
            Caption = 'Unloading Time Variable';
        }
        field(4; "Loading Time Fixed"; Integer)
        {
            Caption = 'Loading Time Fixed';
        }
        field(5; "Loading Time Variable"; Decimal)
        {
            Caption = 'Loading Time Variable';
        }
        field(6; "Truck Type Allowed 1"; Boolean)
        {
            Caption = 'Nickerie';
        }
        field(7; "Truck Type Allowed 2"; Boolean)
        {
            Caption = 'Brokopondo';
        }
        field(8; "Truck Type Allowed 3"; Boolean)
        {
            Caption = 'Parbo Klein';
        }
        field(9; "Truck Type Allowed 4"; Boolean)
        {
            Caption = 'Marowijne';
        }
        field(10; "Truck Type Allowed 5"; Boolean)
        {
            Caption = 'Parbo Groot';
        }
        field(11; "Truck Type Allowed 6"; Boolean)
        {
            Caption = 'Smalle Wegen';
        }
        field(12; "Truck Type Allowed 7"; Boolean)
        {
            Caption = 'Truck Type Allowed 7';
        }
        field(13; "Truck Type Allowed 8"; Boolean)
        {
            Caption = 'Truck Type Allowed 8';
        }
        field(14; "Truck Type Allowed 9"; Boolean)
        {
            Caption = 'Truck Type Allowed 9';
        }
        field(15; "Truck Type Allowed 10"; Boolean)
        {
            CaptionML = ENU = 'Truck Type Allowed 10',
                        EUQ = 'Truck Type Allowed 10';
        }
    }

    keys
    {
        key(Key1; "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }
}

