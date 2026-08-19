table 50234 "RPM-SKU Relationship Arch FND"
{
    // version HEI.06

    // HEI.01 CHG2095415 IBM BULIMC01 22.02.2021#new table created to store all the info related to Shipping cost
    // HEI.02 CHG2130188 IBM BULIMC01 13/04/2022#new fields added
    // HEI.03 CHG2152809 IBM BULIMC01 15/04/2022#new fields added:
    // HEI.04 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //   #the archive table sync with the original one(T50215)
    // HEI.05 CHG2169207 IBM SISUM01 19/08/2022#new fields added marked with HEI.05
    // HEI.06 CHG2167931 IBM SISUM01 19/11/2022 #add new fields with description HEI.06

    Caption = 'RPM - SKU Relationship Archive';
    DrillDownPageID = "RPM - SKU Relationship Archive";
    LookupPageID = "RPM - SKU Relationship Archive";

    fields
    {
        field(2; "Period Start Date"; Date)
        {
        }
        field(3; "Period End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "RPM Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where("No." = FIELD("RPM Item No."));
        }
        field(5; "Item Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(6; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Linked Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item where("No." = FIELD("Linked Item No."));
        }
        field(8; "Period Alloc. Amount Customer"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Primary Allocated Amount" where("Period Date" = FIELD("Period Date"),
                                                                                        "Source Document" = CONST("Sales Return Order"),
                                                                                        "Only RPM Transportation" = CONST(true),
                                                                                        "Destination Type" = CONST(Customer),
                                                                                        "Destination No." = FIELD("Customer No."),
                                                                                        "Item No." = FIELD("RPM Item No."),
                                                                                        "Own Fleet" = FIELD("Own Fleet"),
                                                                                        "Distribution Type" = CONST(Total)));
            Caption = 'Period Primary Allocated Amount Customer';
            FieldClass = FlowField;
        }
        field(9; "Period Alloc. Amount Transfer"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Primary Allocated Amount" where("Period Date" = FIELD("Period Date"),
                                                                                        "Only RPM Transportation" = CONST(true),
                                                                                        "Destination Type" = CONST(Location),
                                                                                        "Item No." = FIELD("RPM Item No."),
                                                                                        "Own Fleet" = FIELD("Own Fleet"),
                                                                                        "Distribution Type" = CONST(Total)));
            Caption = 'Period Primary Allocated Amount Internal Transfers';
            FieldClass = FlowField;
        }
        field(10; "Period Net Weight Customer"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Net Weight (Kg)" where("Period Date" = FIELD("Period Date"),
                                                                               "Only RPM Transportation" = CONST(false),
                                                                               "Destination Type" = CONST(Customer),
                                                                               "Destination No." = FIELD("Customer No."),
                                                                               "Item No." = FIELD("Linked Item No."),
                                                                               "Own Fleet" = FIELD("Own Fleet"),
                                                                               "Distribution Type" = CONST(Total)));
            Caption = 'Period Net Weight (Kg)-Linked Item No. & Customer No.';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(11; "Period Net Weight Linked Item"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Net Weight (Kg)" where("Period Date" = FIELD("Period Date"),
                                                                               "Only RPM Transportation" = CONST(false),
                                                                               "Destination Type" = CONST(Customer),
                                                                               "Item No." = FIELD("Linked Item No."),
                                                                               "Own Fleet" = FIELD("Own Fleet"),
                                                                               "Distribution Type" = CONST(Total)));
            Caption = 'Period Net Weight (Kg)-Linked Item No.';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(12; "Period RPM Unit Cost Customer"; Decimal)
        {
            Caption = 'Period RPM Unit Cost per Linked Item No. & Customer No.';
        }
        field(13; "Period RPM Unit Cost Transfer"; Decimal)
        {
            Caption = 'Period RPM Unit Cost per Linked Item No.-Internal Transfers';
            DataClassification = ToBeClassified;
        }
        field(15; "Primary Alloc. Amount Customer"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Primary Allocated Amount" where("Period Date" = FIELD("Period Date"),
                                                                                        "Source Document" = CONST("Sales Return Order"),
                                                                                        "Only RPM Transportation" = CONST(true),
                                                                                        "Destination Type" = CONST(Customer),
                                                                                        "Destination No." = FIELD("Customer No."),
                                                                                        "Item No." = FIELD("RPM Item No."),
                                                                                        "Own Fleet" = FIELD("Own Fleet"),
                                                                                        "Distribution Type" = CONST(Primary)));
            Caption = 'Primary Period Primary Allocated Amount Customer';
            FieldClass = FlowField;
        }
        field(16; "Second. Alloc. Amount Customer"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Primary Allocated Amount" where("Period Date" = FIELD("Period Date"),
                                                                                        "Source Document" = CONST("Sales Return Order"),
                                                                                        "Only RPM Transportation" = CONST(true),
                                                                                        "Destination Type" = CONST(Customer),
                                                                                        "Destination No." = FIELD("Customer No."),
                                                                                        "Item No." = FIELD("RPM Item No."),
                                                                                        "Own Fleet" = FIELD("Own Fleet"),
                                                                                        "Distribution Type" = CONST(Secondary)));
            Caption = 'Secondary Period Primary Allocated Amount Customer';
            FieldClass = FlowField;
        }
        field(17; "Primary Alloc. Amount Transfer"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Primary Allocated Amount" where("Period Date" = FIELD("Period Date"),
                                                                                        "Only RPM Transportation" = CONST(true),
                                                                                        "Destination Type" = CONST(Location),
                                                                                        "Item No." = FIELD("RPM Item No."),
                                                                                        "Own Fleet" = FIELD("Own Fleet"),
                                                                                        "Distribution Type" = CONST(Primary)));
            Caption = 'Primary Period Primary Allocated Amount Internal Transfers';
            FieldClass = FlowField;
        }
        field(18; "Second. Alloc. Amount Transfer"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Primary Allocated Amount" where("Period Date" = FIELD("Period Date"),
                                                                                        "Only RPM Transportation" = CONST(true),
                                                                                        "Destination Type" = CONST(Location),
                                                                                        "Item No." = FIELD("RPM Item No."),
                                                                                        "Own Fleet" = FIELD("Own Fleet"),
                                                                                        "Distribution Type" = CONST(Secondary)));
            Caption = 'Secondary Period Primary Allocated Amount Internal Transfers';
            FieldClass = FlowField;
        }
        field(19; "Primary RPM Unit Cost Customer"; Decimal)
        {
            Caption = 'Primary Period RPM Unit Cost per Linked Item No.  Customer No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Second. RPM Unit Cost Customer"; Decimal)
        {
            Caption = 'Secondary Period RPM Unit Cost per Linked Item No.  Customer No.';
            DataClassification = ToBeClassified;
        }
        field(21; "Primary RPM Unit Cost Transfer"; Decimal)
        {
            Caption = 'Primary Period RPM Unit Cost per Linked Item No.-Internal Transfers';
            DataClassification = ToBeClassified;
        }
        field(22; "Second. RPM Unit Cost Transfer"; Decimal)
        {
            Caption = 'Secondary Period RPM Unit Cost per Linked Item No.-Internal Transfers';
            DataClassification = ToBeClassified;
        }
        field(23; "Own Fleet"; Boolean)
        {
            Description = 'HEI.04';
        }
        field(24; "Period Date"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(25; "Period Gen. Overheads Cust."; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."General Overheads" where("Destination Type" = CONST(Customer),
                                                                                 "Source Document" = CONST("Sales Return Order"),
                                                                                 "Only RPM Transportation" = CONST(true),
                                                                                 "Period Date" = FIELD("Period Date"),
                                                                                 "Item No." = FIELD("RPM Item No."),
                                                                                 "Destination No." = FIELD("Customer No."),
                                                                                 "Own Fleet" = FIELD("Own Fleet"),
                                                                                 "Distribution Type" = CONST(Total)));
            Caption = 'Period General Overheads RPM & Customer';
            Description = 'HEI.04';
            FieldClass = FlowField;
        }
        field(26; "Period Whse. Overheads Cust."; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Warehouse Overheads" where("Destination Type" = CONST(Customer),
                                                                                   "Source Document" = CONST("Sales Return Order"),
                                                                                   "Only RPM Transportation" = CONST(true),
                                                                                   "Period Date" = FIELD("Period Date"),
                                                                                   "Item No." = FIELD("RPM Item No."),
                                                                                   "Destination No." = FIELD("Customer No."),
                                                                                   "Own Fleet" = FIELD("Own Fleet"),
                                                                                   "Distribution Type" = CONST(Total)));
            Caption = 'Period Warehouse Overheads RPM & Customer';
            Description = 'HEI.04';
            FieldClass = FlowField;
        }
        field(27; "Period Whse. Handling Cust."; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Warehouse Handling" where("Destination Type" = CONST(Customer),
                                                                                  "Source Document" = CONST("Sales Return Order"),
                                                                                  "Only RPM Transportation" = CONST(true),
                                                                                  "Period Date" = FIELD("Period Date"),
                                                                                  "Item No." = FIELD("RPM Item No."),
                                                                                  "Destination No." = FIELD("Customer No."),
                                                                                  "Own Fleet" = FIELD("Own Fleet"),
                                                                                  "Distribution Type" = CONST(Total)));
            Caption = 'Period Warehouse Handling RPM & Customer';
            Description = 'HEI.04';
            FieldClass = FlowField;
        }
        field(28; "Period Picking Factor Cust."; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Picking Factor" where("Period Date" = FIELD("Period Date"),
                                                                              "Only RPM Transportation" = CONST(false),
                                                                              "Destination Type" = CONST(Customer),
                                                                              "Destination No." = FIELD("Customer No."),
                                                                              "Item No." = FIELD("Linked Item No."),
                                                                              "Own Fleet" = FIELD("Own Fleet"),
                                                                              "Distribution Type" = CONST(Total)));
            Caption = 'Period Picking Factor Linked Item No. & Customer No.';
            DecimalPlaces = 0 : 0;
            Description = 'HEI.04';
            FieldClass = FlowField;
        }
        field(29; "Period Pick. Fact. Linked Item"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Picking Factor" where("Period Date" = FIELD("Period Date"),
                                                                              "Only RPM Transportation" = CONST(false),
                                                                              "Destination Type" = CONST(Customer),
                                                                              "Item No." = FIELD("Linked Item No."),
                                                                              "Own Fleet" = FIELD("Own Fleet"),
                                                                              "Distribution Type" = CONST(Total)));
            Caption = 'Period Picking Factor Linked Item No.';
            Description = 'HEI.04';
            FieldClass = FlowField;
        }
        field(30; "Period RPM Gen. Overh. Cust."; Decimal)
        {
            Caption = 'Period RPM Gen. Overheads Unit Cost per Linked Item No. & Customer No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(31; "Period RPM Gen. Overh. IT"; Decimal)
        {
            Caption = 'Period RPM Gen. Overheads Unit Cost per Linked Item No._Internal Transfers';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(32; "Period RPM Whse. Overh. Cust."; Decimal)
        {
            Caption = 'Period RPM Whse Overheads Unit Cost per Linked Item No. & Customer No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(33; "Period RPM Whse. Overh. IT"; Decimal)
        {
            Caption = 'Period RPM Whse Overheads Unit Cost per Linked Item No._Internal Transfers';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(34; "Period RPM Whse. Handl. Cust."; Decimal)
        {
            Caption = 'Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(35; "Period RPM Whse. Handl. IT"; Decimal)
        {
            Caption = 'Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(36; "Period Gen. Overheads IT"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."General Overheads" where("Period Date" = FIELD("Period Date"),
                                                                                 "Destination Type" = CONST(Location),
                                                                                 "Only RPM Transportation" = CONST(true),
                                                                                 "Item No." = FIELD("RPM Item No."),
                                                                                 "Own Fleet" = FIELD("Own Fleet"),
                                                                                 "Distribution Type" = CONST(Total)));
            Caption = 'Period General Overheads RPM Internal Transfers';
            Description = 'HEI.04';
            FieldClass = FlowField;
        }
        field(37; "Period Whse. Overheads IT"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Warehouse Overheads" where("Period Date" = FIELD("Period Date"),
                                                                                   "Destination Type" = CONST(Location),
                                                                                   "Only RPM Transportation" = CONST(true),
                                                                                   "Item No." = FIELD("RPM Item No."),
                                                                                   "Own Fleet" = FIELD("Own Fleet"),
                                                                                   "Distribution Type" = CONST(Total)));
            Caption = 'Period Warehouse Overheads RPM Internal Transfers';
            Description = 'HEI.04';
            FieldClass = FlowField;
        }
        field(38; "Period Whse. Handling IT"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."Warehouse Handling" where("Period Date" = FIELD("Period Date"),
                                                                                  "Destination Type" = CONST(Location),
                                                                                  "Only RPM Transportation" = CONST(true),
                                                                                  "Item No." = FIELD("RPM Item No."),
                                                                                  "Own Fleet" = FIELD("Own Fleet"),
                                                                                  "Distribution Type" = CONST(Total)));
            Caption = 'Period Warehouse Handling RPM Internal Transfers';
            Description = 'HEI.04';
            FieldClass = FlowField;
        }
        field(39; "Period Net Weight Sold Cust."; Decimal)
        {
            Caption = 'Period Net Weight Sold Per RPM & Customer No.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(40; "Period Net Weight Transf."; Decimal)
        {
            Caption = 'Period Net Weight Transferred per RPM';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(41; "RPM Unit Cost Sold Cust."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(42; "RPM Unit Cost Transferred"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(43; "Period Pick. Factor Sold Cust."; Decimal)
        {
            Caption = '"Period Picking Factor Sold per RPM & Customer No. "';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(44; "Period Pick. Factor Transf."; Decimal)
        {
            Caption = 'Period Picking Factor Transferred per RPM';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(45; "RPM Whse. Hand Unit Cost Cust."; Decimal)
        {
            Caption = 'RPM Whse Handling Unit Cost Sold by RPM & Customer No';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(46; "RPM Whse. Hand Unit Cost T."; Decimal)
        {
            Caption = 'RPM Whse. Handling Unit Cost Transferred';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(47; "RPM Gen. Over. Unit Cost Cust."; Decimal)
        {
            Caption = 'RPM Gen. Overheads Unit Cost Sold by RPM & Customer No.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(48; "RPM Gen. Over. Unit Cost T"; Decimal)
        {
            Caption = 'RPM Gen. Overheads Unit Cost Transferred';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(49; "RPM Whse. Over. Unit Cost Cust"; Decimal)
        {
            Caption = 'RPM Whse Overheads Unit Cost Sold by RPM & Customer No.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(50; "RPM Whse. Over. Unit Cost T"; Decimal)
        {
            Caption = 'RPM Whse. Overheads Unit Cost Transferred';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
        }
        field(51; "Processing Date"; Date)
        {
            Caption = 'Processing Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(52; "OVE Prd. RPM Whse. Handl. Cust"; Decimal)
        {
            Caption = 'OVE Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(53; "FIX Prd. RPM Whse. Handl. Cust"; Decimal)
        {
            Caption = 'FIX Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(54; "TRP Prd. RPM Whse. Handl. Cust"; Decimal)
        {
            Caption = 'TRP Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(55; "OVE Prd. RPM Whse. Handl. IT"; Decimal)
        {
            Caption = 'OVE Period RPM Whse Handling Unit Cost per Linked Item No._Internal TransfersWhse. Hand. ST Trans. Exp.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(56; "TRP Prd. RPM Whse. Handl. IT"; Decimal)
        {
            Caption = 'TRP Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(57; "FIX Prd. RPM Whse. Handl. IT"; Decimal)
        {
            Caption = 'FIX Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(58; "OVE RPM Whs H Unit Cost Cust"; Decimal)
        {
            Caption = 'OVE RPM Whse Handling Unit Cost Sold by RPM & Customer No';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(59; "TRP RPM Whs H Unit Cost Cust"; Decimal)
        {
            Caption = 'TRP RPM Whse Handling Unit Cost Sold by RPM & Customer No';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(60; "FIX RPM Whs H Unit Cost Cust"; Decimal)
        {
            Caption = 'FIX RPM Whse Handling Unit Cost Sold by RPM & Customer No';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(61; "OVE RPM Whse. H Unit Cost T"; Decimal)
        {
            Caption = 'OVE RPM Whse. Handling Unit Cost Transferred';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(62; "TRP RPM Whse. H Unit Cost T"; Decimal)
        {
            Caption = 'TRP RPM Whse. Handling Unit Cost Transferred';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
        }
        field(63; "FIX RPM Whse. H Unit Cost T"; Decimal)
        {
            Caption = 'FIX RPM Whse. Handling Unit Cost Transferred';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(64; "OVE Prd Whse. Handling Cust."; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."OVE Warehouse Handling" where("Destination Type" = CONST(Customer),
                                                                                      "Source Document" = CONST("Sales Return Order"),
                                                                                      "Only RPM Transportation" = CONST(true),
                                                                                      "Period Date" = FIELD("Period Date"),
                                                                                      "Item No." = FIELD("RPM Item No."),
                                                                                      "Destination No." = FIELD("Customer No."),
                                                                                      "Own Fleet" = FIELD("Own Fleet"),
                                                                                      "Distribution Type" = CONST(Total)));
            Caption = 'OVE Period Warehouse Handling RPM & Customer';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
            FieldClass = FlowField;
        }
        field(65; "TRP Prd Whse. Handling Cust."; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."TRP Warehouse Handling" where("Destination Type" = CONST(Customer),
                                                                                      "Source Document" = CONST("Sales Return Order"),
                                                                                      "Only RPM Transportation" = CONST(true),
                                                                                      "Period Date" = FIELD("Period Date"),
                                                                                      "Item No." = FIELD("RPM Item No."),
                                                                                      "Destination No." = FIELD("Customer No."),
                                                                                      "Own Fleet" = FIELD("Own Fleet"),
                                                                                      "Distribution Type" = CONST(Total)));
            Caption = 'TRP Period Warehouse Handling RPM & Customer';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
            FieldClass = FlowField;
        }
        field(66; "FIX Prd Whse. Handling Cust."; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."FIX Warehouse Handling" where("Destination Type" = CONST(Customer),
                                                                                      "Source Document" = CONST("Sales Return Order"),
                                                                                      "Only RPM Transportation" = CONST(true),
                                                                                      "Period Date" = FIELD("Period Date"),
                                                                                      "Item No." = FIELD("RPM Item No."),
                                                                                      "Destination No." = FIELD("Customer No."),
                                                                                      "Own Fleet" = FIELD("Own Fleet"),
                                                                                      "Distribution Type" = CONST(Total)));
            Caption = 'FIX Period Warehouse Handling RPM & Customer';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
            FieldClass = FlowField;
        }
        field(67; "OVE Period Whse. Handling IT"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."OVE Warehouse Handling" where("Period Date" = FIELD("Period Date"),
                                                                                      "Destination Type" = CONST(Location),
                                                                                      "Only RPM Transportation" = CONST(true),
                                                                                      "Item No." = FIELD("RPM Item No."),
                                                                                      "Own Fleet" = FIELD("Own Fleet"),
                                                                                      "Distribution Type" = CONST(Total)));
            Caption = 'OVE Period Warehouse Handling RPM Internal Transfers';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
            FieldClass = FlowField;
        }
        field(68; "TRP Period Whse. Handling IT"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."TRP Warehouse Handling" where("Period Date" = FIELD("Period Date"),
                                                                                      "Destination Type" = CONST(Location),
                                                                                      "Only RPM Transportation" = CONST(true),
                                                                                      "Item No." = FIELD("RPM Item No."),
                                                                                      "Own Fleet" = FIELD("Own Fleet"),
                                                                                      "Distribution Type" = CONST(Total)));
            Caption = 'TRP Period Warehouse Handling RPM Internal Transfers';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
            FieldClass = FlowField;
        }
        field(69; "FIX Period Whse. Handling IT"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Archive FND"."FIX Warehouse Handling" where("Period Date" = FIELD("Period Date"),
                                                                                      "Destination Type" = CONST(Location),
                                                                                      "Only RPM Transportation" = CONST(true),
                                                                                      "Item No." = FIELD("RPM Item No."),
                                                                                      "Own Fleet" = FIELD("Own Fleet"),
                                                                                      "Distribution Type" = CONST(Total)));
            Caption = 'FIX Period Warehouse Handling RPM Internal Transfers';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.06';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Period Start Date", "Period End Date", "RPM Item No.", "Linked Item No.", "Customer No.")
        {
        }
        key(Key2; "Period Date", "RPM Item No.", "Customer No.", "Own Fleet")
        {
        }
    }

    fieldgroups
    {
    }
}

