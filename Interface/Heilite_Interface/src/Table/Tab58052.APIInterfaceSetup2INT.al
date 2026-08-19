table 58052 "API Interface Setup2 INT"
{
    // Heilite Navision Old Id - 50187
    // version HEI.07

    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New table created
    // HEI.02 FDD-HB1268 - CHG2068666 IBM NASTAA02 07.12.2020 # DMS Integration Ivory Coast
    //   # New Fields created: 20 - API Payment Interface
    //                         21 - Cash Journal Template
    //                         22 - Cash Journal Batch
    // HEI.03 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Deleted Fields: "Order Value Validation" and "Order Val. Tolerance Amt"
    // HEI.04 FDD-HB1234 - CHG2053453 IBM NASTAA02 08.03.2021 # B2B Order Status
    //   # New Fields created: 30 - API Order Status
    //                         31 - API Order Status Not Interface
    // HEI.05 FDD-HB899 - CHG2093869 IBM NASTAA02 16.03.2021 # LSR - Transfer and Stock
    //   # New Field created: 40 - API Stock Image Interface
    // HEI.06 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    //    #Add field:  8 SRO DelayAttempt Process (sec)
    //    #Add field:  9 Run No.of Batch ReProcessEntry
    // HEI.07 CHG2188870 DEBUSD01 08.02.2023 Sales Order API Performance change flow
    //    #Add field: 10 API Job Queue Category Code

    // BC Upgrade SHUKLP03 >> Added table relation of document subtype.

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "SO/SRO Interface Request"; Code[20])
        {
            Caption = 'SO/SRO Interface Request';
            TableRelation = "Interface Setup INT";
        }
        field(3; "Default Document Subtype Code"; Code[10])
        {
            Caption = 'Default Document Subtype Code';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Sales | "Fin.Contract"));  // BC Upgrade NANDIS03
        }
        field(4; "Reprocess Count"; Integer)
        {
            Caption = 'Re-process Count (Max. Attempts)';
            MinValue = 0;
        }
        field(7; "Automatic Release/SendApproval"; Boolean)
        {
            Caption = 'Automatic Release/SendApproval';
        }
        field(8; "SRO AttemptDelay Process (sec)"; Integer)
        {
            Caption = 'SRO Attempt Delay to Process (sec.)';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            MinValue = -1;
        }
        field(9; "Run BatchReProcess No.of Entry"; Integer)
        {
            Caption = 'Batch Re-process Run No. of Records';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            MinValue = 0;
        }
        field(10; "API Job Queue Category Code"; Code[10])
        {
            Caption = 'API Job Queue Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            TableRelation = "Job Queue Category";
        }
        field(20; "API Payment Interface"; Code[20])
        {
            Caption = 'API Payment Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Interface Setup INT";
        }
        field(21; "Cash Journal Template"; Code[10])
        {
            Caption = 'Cash Journal Template';
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Template";
        }
        field(22; "Cash Journal Batch"; Code[10])
        {
            Caption = 'Cash Journal Batch';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Cash Journal Template"));
        }
        field(30; "API Order Status Interface"; Code[20])
        {
            Caption = 'API Order Status Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(31; "API Order Status Not Interface"; Code[20])
        {
            Caption = 'API Order Status Notification Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            TableRelation = "Interface Setup INT";
        }
        field(40; "API Stock Image Interface"; Code[20])
        {
            Caption = 'API Stock Image Interface';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
            TableRelation = "Interface Setup INT";
        }
        field(41; "Gift Reason Code"; Code[20])
        {
            Caption = 'Gift Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code".Code where("Sales 101FDW" = const(true), "Free Line Discount 105FDW" = filter('Sales' | 'Both'));
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

