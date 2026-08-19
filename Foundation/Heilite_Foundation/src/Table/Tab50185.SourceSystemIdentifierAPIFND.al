table 50185 "Source Sys Identifier API FND"
{
    // version HEI.08

    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New table created
    // HEI.02 FDD-HT678 IBM NASTAA02 09.11.2020 # DMS / DDE Integration
    //   # New field created: 10 - Use Default S. Order Nos
    // HEI.03 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New Fields created: 5 - Order Value Validation
    //                         6 - Order Val. Tolerance Amt
    //                         11 - Recalculate Sales Prices
    //                         12 - Automatic SO Posting
    //                         13 - G/L Difference Account
    //                         14 - Post Diff to G/L Account
    //                         15 - Use Location - Dim Mapping
    //                         20 - Automatic Payment Posting
    // HEI.04 FDD-HB1234 - CHG2053453 IBM NASTAA02 11.03.2021 # B2B Order Status
    //   # New Fields created: 25 - Stop Sales RO Status
    //                         26 - Enable SO Notifications
    // HEI.05 HB2469 - CHG2122312 IBM NASTAA02 17.11.2021 # Payment API with B2B DOT Interface into HL
    //   # New Field created: 21 - Disable Default Pay Doc. No.
    // HEI.06 HB2427 - CHG2121928 IBM NASTAA02 20.11.2021 # B2B Invoice API
    //   # New Fields created: 40 - Enable Invoicing
    // HEI.07 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    // HEI.08 CHG2174235 COSTES04 11.07.2023 Prices and Taxes
    //   # New field Stop Sales Quote Status

    Caption = 'Source System Identifier API';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "Source System Identifier API";
    LookupPageID = "Source System Identifier API";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Order Value Validation"; Boolean)
        {
            Caption = 'Order Value Validation';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(6; "Order Val. Tolerance Amt"; Decimal)
        {
            Caption = 'Order Value Validation Buffer Amount (+/-)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.03';
            MinValue = 0;
        }
        field(10; "Use Default S. Order Nos"; Boolean)
        {
            Caption = 'Use Default Sales Order No. Series';
            Description = 'HEI.02';
        }
        field(11; "Apply Sales Condit Interface"; Boolean)
        {
            Caption = 'Apply Sales Conditions from the Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(12; "Automatic SO Posting"; Boolean)
        {
            Caption = 'Automatic Sales Order Posting';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(13; "G/L Difference Account"; Code[20])
        {
            Caption = 'G/L Difference Account';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "G/L Account";
        }
        field(14; "Post Diff to G/L Account"; Boolean)
        {
            Caption = 'Post Difference to G/L Account';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(15; "Use Location - Dim Mapping"; Boolean)
        {
            Caption = 'Use Location - Dimension Mapping';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(20; "Automatic Payment Posting"; Boolean)
        {
            Caption = 'Automatic Payment Posting';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(21; "Disable Default Pay Doc. No."; Boolean)
        {
            Caption = 'Disable Default Payment Document No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(25; "Stop Sales RO Status"; Boolean)
        {
            Caption = 'Stop Sales Return Order Status';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(26; "Enable SO Notifications"; Boolean)
        {
            Caption = 'Enable Sales Order Notifications';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(40; "Enable Invoicing"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(41; "Execute Checking"; Boolean)
        {
            Caption = 'Execute Checking SO/SRO';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(50; "Skip Sales Quote Status"; Boolean)
        {
            Caption = 'Skip Sales Quote Status';
            DataClassification = CustomerContent;
            Description = 'HEI.08';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

