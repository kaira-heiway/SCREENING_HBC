table 50208 "Shipping Cost Allocation FND"
{
    // version HEI.14

    // HEI.01 CHG2095415 IBM BULIMC01 22.02.2021#new table created to store all the info related to Shipping cost
    // HEI.02 CHG2130188 IBM BULIMC01 13/10/2021
    //   #new fields added: "Distrtibution Type", "Reversed", "Parent Line No."
    //   #CalcFormula property updated for the next fields:
    //     #"ST Transfers per SKU/Lot"
    //     #"ST Gen. Overh. per SKU/Lot"
    //     #"ST Whse. Overh. per SKU/Lot"
    //     #"ST Whse. Hand. per SKU/Lot"
    // HEI.03 CHG2132177 BULIMC01 IBM 06/05/2022 # new fields added marked with hei.03
    //   #field ID48 and fieldID49 changed to FlowFields
    //   #new secondary key added for the flowfields created to T50215
    //   #DecimalPlaces updated for all decimal fields
    // HEI.04 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //   #new fields added marked with HEI.04
    // HEI.05 HB2618 - CHG2132177 IBM NASTAA02 12.05.2022 # C2S - Own Fleet Logistic Cost
    //   # Changed the Name for Field 136 from "Distance per Drop Allocation Own Fleet" to "Distance Allocation Own Fleet"
    // HEI.06 CHG2162842 IBM SAMANR01 05/07/202022 #C2S optimazation
    //   # New secondary key "Posting Date,Destination Type,Only RPM Transportation,Source Document,Item Category Code" introduce
    // HEI.07 CHG2162842 IBM SAMANR01 07/07/202022 #C2S optimazation
    //   # New fields start with "T_" created
    // HEI.08 CHG2169207 IBM SISUM01 22/08/2022 #change formula for following flowfields: Period RPM Unit Cost Customer,Period RPM Unit Cost Transfer
    //   # New field marked with HEI.08
    // HEI.09 CHG2169207 IBM SISUM01 06/09/2022 #change formula for following flowfields:
    //   #Period RPM Unit Cost Transfer
    //   #Period RPM Gen. Overh. IT
    //   #Period RPM Whse. Overh. IT
    //   #Period RPM Whse. Handl. IT
    // HEI.10 CHG2169207 IBM SISUM01 13/09/2022 #change formula for following flowfields:
    //   #Period RPM Gen. Overh. Cust.
    //   #Period RPM Whse. Overh. Cust.
    //   #Period RPM Whse. Handl. Cust.
    // HEI.11 CHG2178734 IBM SISUM01 07/11/2022 #add new field with ID 38
    //   #add to SIFT, field Item Category Code
    // HEI.12 CHG2178734 IBM SISUM01 10/11/2022 #for ID fields 96,98,100,102,104,106 remove filter Own Fleet,replace Lookup with sum and replace the filed that is sumup
    //   # add new key Posting Date,Item No.,Source Document,Lot No. & Destination No.,Lot No. & Location Code,Item Category Code,Distribution Type,IT Cost Is Calc
    // HEI.13 CHG2167931 IBM SISUM01 22/11/2022 #add new fields with description HEI.13
    // HEI.14 CHG2175297 IBM SISUM01 25/04/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #create global function FindByNo

    Caption = 'Shipping Cost Allocation';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Lot No. & Destination No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Source Document"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Sales Order,Sales Return Order,Outbound Transfer,Sales Invoice,Sales Credit Memo';
            OptionMembers = ,"Sales Order","Sales Return Order","Outbound Transfer","Sales Invoice","Sales Credit Memo";
        }
        field(7; "Source No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Source Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(10; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(14; "Quantity (Base UoM)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(15; "Posted Source Document"; Option)
        {
            Caption = 'Posted Source Document';
            DataClassification = ToBeClassified;
            OptionCaption = '" ,Posted Sales Invoice,Posted Return Receipt,Posted Sales Credit Memo,Posted Shipment,Posted Transfer Shipment"';
            OptionMembers = " ","Posted Sales Invoice","Posted Return Receipt","Posted Sales Credit Memo","Posted Shipment","Posted Transfer Shipment";
        }
        field(16; "Posted Source Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Destination Type"; Option)
        {
            CaptionML = ENU = 'Destination Type',
                        FRA = 'Type destination';
            Editable = false;
            OptionCaptionML = ENU = ' ,Customer,Vendor,Location',
                              FRA = ' ,Client,Fournisseur,Magasin';
            OptionMembers = " ",Customer,Vendor,Location;
        }
        field(19; "Destination No."; Code[20])
        {
            Caption = 'Destination No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Destination Type" = CONST(Customer)) Customer."No."
            else IF ("Destination Type" = CONST(Vendor)) Vendor."No."
            else IF ("Destination Type" = CONST(Location)) Location.Code;
        }
        field(20; "Total Shipping Cost Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Net Weight (Kg)"; Decimal)
        {
            Caption = 'Net Weight (Kg)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(22; "Total Net Weight (Kg)"; Decimal)
        {
            Caption = 'Total Net Weight (Kg)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(23; "Lot No. & Location Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Unit of Measure Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(32; "No. of Pallets"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(33; "Picking Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Warehouse Handling"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(35; "Warehouse Overheads"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(36; "General Overheads"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(37; "Primary Allocated Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(38; "IT Cost Is Calc"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(40; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Period Date"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Period Picking Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Period Net Weight (Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Period G/L Cost Whse. Handling"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Period G/L Cost Whse. Overhead"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Period G/L Cost Gen. Overheads"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Only RPM Transportation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Period RPM Unit Cost Customer"; Decimal)
        {
            CalcFormula = Sum("RPM - SKU Relationship FND"."RPM Unit Cost Sold Cust." where("Period Date" = FIELD("Period Date"),
                                                                                         "Customer No." = FIELD("Destination No."),
                                                                                         "Linked Item No." = FIELD("Item No.")));
            Caption = 'Period RPM Unit Cost per Linked Item No. & Customer No.';
            Description = 'HEI.04';
            FieldClass = FlowField;
        }
        field(49; "Period RPM Unit Cost Transfer"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."Period RPM Unit Cost Transfer" where("Period Date" = FIELD("Period Date"),
                                                                                              "Linked Item No." = FIELD("Item No.")));
            Caption = 'Period RPM Unit Cost per Linked Item No. - Internal Transfers';
            Description = 'HEI.04,HEI.09';
            FieldClass = FlowField;
        }
        field(53; "RPM SO"; Decimal)
        {
        }
        field(54; "RPM ST"; Decimal)
        {
        }
        field(56; "Item Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Unit Cost-General Overheads ST"; Decimal)
        {
            Caption = 'Cumulative Unit Cost-General Overheads ST';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(58; "Unit Cost-Whse. Handling ST"; Decimal)
        {
            Caption = 'Cumulative Unit Cost-Warehouse Handling ST';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(59; "Unit Cost-Whse. Overhead ST"; Decimal)
        {
            Caption = 'Cumulative Unit Cost-Warehouse Overhead ST';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(60; "Avg. Cost-General Overheads ST"; Decimal)
        {
            Caption = 'Average Cost-General Overheads ST';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(61; "Avg. Cost-Whse. Handling ST"; Decimal)
        {
            Caption = 'Average Cost-Warehouse Handling ST';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(62; "Avg. Cost-Whse. Overhead ST"; Decimal)
        {
            Caption = 'Average Cost-Warehouse Overhead ST';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(63; "IT Cost-General Overheads ST"; Decimal)
        {
            Caption = 'IT Cost-General Overheads ST';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(64; "IT Cost-Whse. Handling ST"; Decimal)
        {
            Caption = 'IT Cost-Whse. Handling ST';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(65; "IT Cost-Whse. Overhead ST"; Decimal)
        {
            Caption = 'IT Cost-Whse. Overhead ST';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(69; "Originial Lot & Location Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Unit Cost-General Overheads SO"; Decimal)
        {
            CalcFormula = Lookup("Shipping Cost Allocation FND"."Unit Cost-General Overheads ST" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                                    "Period Date" = FIELD("Period Date"),
                                                                                                    "Item No." = FIELD("Item No."),
                                                                                                    "Lot No. & Destination No." = FIELD("Lot No. & Location Code")));
            FieldClass = FlowField;
        }
        field(71; "Unit Cost-Whse. Handling SO"; Decimal)
        {
            CalcFormula = Lookup("Shipping Cost Allocation FND"."Unit Cost-Whse. Handling ST" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                                 "Period Date" = FIELD("Period Date"),
                                                                                                 "Item No." = FIELD("Item No."),
                                                                                                 "Lot No. & Destination No." = FIELD("Lot No. & Location Code")));
            DecimalPlaces = 2 : 5;
            FieldClass = FlowField;
        }
        field(72; "Unit Cost-Whse. Overhead SO"; Decimal)
        {
            CalcFormula = Lookup("Shipping Cost Allocation FND"."Unit Cost-Whse. Overhead ST" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                                 "Period Date" = FIELD("Period Date"),
                                                                                                 "Item No." = FIELD("Item No."),
                                                                                                 "Lot No. & Destination No." = FIELD("Lot No. & Location Code")));
            DecimalPlaces = 2 : 5;
            FieldClass = FlowField;
        }
        field(79; "Unit Cost-Internal Transfer ST"; Decimal)
        {
            Caption = 'Cumulative Unit Cost-Internal Transfer';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(80; "Avg. Cost-Internal Transfer ST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(81; "IT Cost-Internal Transfer ST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(82; "Unit Cost-Internal Transfer SO"; Decimal)
        {
            CalcFormula = Lookup("Shipping Cost Allocation FND"."Unit Cost-Internal Transfer ST" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                                    "Period Date" = FIELD("Period Date"),
                                                                                                    "Item No." = FIELD("Item No."),
                                                                                                    "Lot No. & Destination No." = FIELD("Lot No. & Location Code")));
            DecimalPlaces = 2 : 5;
            FieldClass = FlowField;
        }
        field(83; "Shipping Agent Code"; Code[10])
        {
            CaptionML = ENU = 'Shipping Agent Code',
                        FRA = 'Code transporteur';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }
        field(84; "Shipping Agent Service Code"; Code[10])
        {
            CaptionML = ENU = 'Shipping Agent Service Code',
                        FRA = 'Code prestation transporteur';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(85; Route; Code[20])
        {
            Caption = 'Route';
            DataClassification = ToBeClassified;
            TableRelation = Route107FDW;
        }
        field(86; "Route Planning No."; Code[20])
        {
            Caption = 'Route Planning No.';
            DataClassification = ToBeClassified;
            TableRelation = RoutePlanningWork107FDW;
        }
        field(87; "Quantity HL"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Initial Origin ST"; Code[20])
        {
            FieldClass = Normal;
        }
        field(89; "Initial Origin SO"; Code[20])
        {
            CalcFormula = Lookup("Shipping Cost Allocation FND"."Initial Origin ST" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                       "Period Date" = FIELD("Period Date"),
                                                                                       "Item No." = FIELD("Item No."),
                                                                                       "Lot No. & Destination No." = FIELD("Lot No. & Location Code")));
            Caption = 'Initial Origin';
            FieldClass = FlowField;
        }
        field(90; "Period G/L Cost Delivery Cust."; Decimal)
        {
            Caption = 'Period G/L Cost Delivery to Customer';
            DataClassification = ToBeClassified;
        }
        field(91; "General Overheads ST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(92; "Warehouse Overheads ST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(93; "Warehouse Handling ST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(94; "Internal Transfer ST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
        }
        field(95; "Period Net Weight SKU/Lot"; Decimal)
        {
            Caption = 'Period Net Weight per SKU/Lot No. in Location/Destination';
            DataClassification = ToBeClassified;
        }
        field(96; "ST Period Net Weight SKU/Lot"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Allocation FND"."Net Weight (Kg)" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                  "Period Date" = FIELD("Period Date"),
                                                                                  "Item No." = FIELD("Item No."),
                                                                                  "Lot No." = FIELD("Lot No."),
                                                                                  "Destination No." = FIELD("Location Code")));
            Caption = 'ST Period Net Weight per SKU/Lot No. from ST Destination';
            FieldClass = FlowField;
        }
        field(97; "Period Transfers per SKU/Lot"; Decimal)
        {
            Caption = '"Period Internal Transfers per SKU/Lot No. "';
            DataClassification = ToBeClassified;
        }
        field(98; "ST Transfers per SKU/Lot"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Allocation FND"."Primary Allocated Amount" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                           "Period Date" = FIELD("Period Date"),
                                                                                           "Item No." = FIELD("Item No."),
                                                                                           "Lot No." = FIELD("Lot No."),
                                                                                           "Destination No." = FIELD("Location Code"),
                                                                                           "Distribution Type" = FIELD("Distribution Type")));
            Caption = '"ST Period Internal Transfers per SKU/Lot No. "';
            FieldClass = FlowField;
        }
        field(99; "Period Gen. Overh. per SKU/Lot"; Decimal)
        {
            Caption = '"Period General Overheads per SKU/Lot No. "';
            DataClassification = ToBeClassified;
        }
        field(100; "ST Gen. Overh. per SKU/Lot"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Allocation FND"."General Overheads" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                    "Period Date" = FIELD("Period Date"),
                                                                                    "Item No." = FIELD("Item No."),
                                                                                    "Lot No." = FIELD("Lot No."),
                                                                                    "Destination No." = FIELD("Location Code"),
                                                                                    "Distribution Type" = FIELD("Distribution Type")));
            Caption = '"ST Period General Overheads per SKU/Lot No. "';
            FieldClass = FlowField;
        }
        field(101; "Period Whs. Overh. per SKU/Lot"; Decimal)
        {
            Caption = '"Period Warehouse Overheads per SKU/Lot No. "';
            DataClassification = ToBeClassified;
        }
        field(102; "ST Whse. Overh. per SKU/Lot"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Allocation FND"."Warehouse Overheads" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                      "Period Date" = FIELD("Period Date"),
                                                                                      "Item No." = FIELD("Item No."),
                                                                                      "Lot No." = FIELD("Lot No."),
                                                                                      "Destination No." = FIELD("Location Code"),
                                                                                      "Distribution Type" = FIELD("Distribution Type")));
            Caption = '"ST Period Warehouse Overheads per SKU/Lot No. "';
            FieldClass = FlowField;
        }
        field(103; "Period Whse. Hand. per SKU/Lot"; Decimal)
        {
            Caption = '"Period Warehouse Handling per SKU/Lot No. "';
            DataClassification = ToBeClassified;
        }
        field(104; "ST Whse. Hand. per SKU/Lot"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Allocation FND"."Warehouse Handling" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                     "Period Date" = FIELD("Period Date"),
                                                                                     "Item No." = FIELD("Item No."),
                                                                                     "Lot No." = FIELD("Lot No."),
                                                                                     "Destination No." = FIELD("Location Code"),
                                                                                     "Distribution Type" = FIELD("Distribution Type")));
            Caption = '"ST Period Warehouse Handling per SKU/Lot No. "';
            FieldClass = FlowField;
        }
        field(105; "Period Picking Factor SKU/Lot"; Decimal)
        {
            Caption = 'Period Picking Factor per SKU/Lot No. in Location/Destination';
            DataClassification = ToBeClassified;
        }
        field(106; "ST Period Pick. Factor SKU/Lot"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Allocation FND"."Picking Factor" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                 "Period Date" = FIELD("Period Date"),
                                                                                 "Item No." = FIELD("Item No."),
                                                                                 "Lot No." = FIELD("Lot No."),
                                                                                 "Destination No." = FIELD("Location Code")));
            Caption = 'ST Period Picking Factor per SKU/Lot No. from ST Destination';
            FieldClass = FlowField;
        }
        field(107; "Distribution Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            OptionMembers = Total,Primary,Secondary;
        }
        field(124; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(125; "Parent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(127; "Tree Level"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(128; "Own Fleet"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(129; "Period G/L Cost Own Fleet"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(130; Distance; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(131; "Period Distance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(132; "No. of Drops"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(133; "Period Drop Counts"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(134; "Weight Allocation Own Fleet"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(135; "No. of Drops All. Own Fleet"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(136; "Distance Allocation Own Fleet"; Decimal)
        {
            Caption = 'Distance Allocation Own Fleet';
            DataClassification = ToBeClassified;
            Description = 'HEI.03,HEI.05';
        }
        field(137; "Gen. Overheads RPM SO"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.04';
        }
        field(138; "Gen. Overheads RPM ST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.04';
        }
        field(139; "Whse. Overheads RPM SO"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.04';
        }
        field(140; "Whse. Overheads RPM ST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.04';
        }
        field(141; "Whse. Handling RPM SO"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.04';
        }
        field(142; "Whse. Handling RPM ST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 5;
            Description = 'HEI.04';
        }
        field(143; "Period RPM Gen. Overh. Cust."; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."Period RPM Gen. Overh. Cust." where("Period Date" = FIELD("Period Date"),
                                                                                             "Linked Item No." = FIELD("Item No."),
                                                                                             "Customer No." = FIELD("Destination No."),
                                                                                             "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'Period RPM Gen. Overheads Unit Cost per Linked Item No. & Customer No.';
            Description = 'HEI.04,HEI.10';
            FieldClass = FlowField;
        }
        field(144; "Period RPM Gen. Overh. IT"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."Period RPM Gen. Overh. IT" where("Period Date" = FIELD("Period Date"),
                                                                                          "Linked Item No." = FIELD("Item No."),
                                                                                          "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'Period RPM Gen. Overheads Unit Cost per Linked Item No._Internal Transfers';
            Description = 'HEI.04,HEI.09';
            FieldClass = FlowField;
        }
        field(145; "Period RPM Whse. Overh. Cust."; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."Period RPM Whse. Overh. Cust." where("Period Date" = FIELD("Period Date"),
                                                                                              "Linked Item No." = FIELD("Item No."),
                                                                                              "Customer No." = FIELD("Destination No."),
                                                                                              "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'Period RPM Whse Overheads Unit Cost per Linked Item No. & Customer No.';
            Description = 'HEI.04,HEI.10';
            FieldClass = FlowField;
        }
        field(146; "Period RPM Whse. Overh. IT"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."Period RPM Whse. Overh. IT" where("Period Date" = FIELD("Period Date"),
                                                                                           "Linked Item No." = FIELD("Item No."),
                                                                                           "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'Period RPM Whse Overheads Unit Cost per Linked Item No._Internal Transfers';
            Description = 'HEI.04,HEI.09';
            FieldClass = FlowField;
        }
        field(147; "Period RPM Whse. Handl. Cust."; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."Period RPM Whse. Handl. Cust." where("Period Date" = FIELD("Period Date"),
                                                                                              "Linked Item No." = FIELD("Item No."),
                                                                                              "Customer No." = FIELD("Destination No."),
                                                                                              "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No.';
            Description = 'HEI.04,HEI.10';
            FieldClass = FlowField;
        }
        field(148; "Period RPM Whse. Handl. IT"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."Period RPM Whse. Handl. IT" where("Period Date" = FIELD("Period Date"),
                                                                                           "Linked Item No." = FIELD("Item No."),
                                                                                           "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers';
            Description = 'HEI.04,HEI.09';
            FieldClass = FlowField;
        }
        field(150; "T_ST Gen. Overh. per SKU/Lot"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(151; "T_ST Period Net Weight SKU/Lot"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(152; "T_ST Period Pick Factr SKU/Lot"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(153; "T_ST Transfers per SKU/Lot"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(154; "T_ST Whse. Hand. per SKU/Lot"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(155; "T_ST Whse. Overh. per SKU/Lot"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(156; "T_Unit Cst Genl Overheads SO"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(157; "T_Unit Cst Intl Transfer SO"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(158; "T_Unit Cost-Whse. Handling SO"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(159; "T_Unit Cost-Whse. Overhead SO"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(160; "T_Prd RPM Unit Cost Customer"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(161; "T_Prd RPM Unit Cost Transfer"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(162; "T_Prd RPM Gen. Overh. Cust."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(163; "T_Prd RPM Gen. Overh. IT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(164; "T_Prd RPM Whse. Handl. Cust."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(165; "T_Prd RPM Whse. Handl. IT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(166; "T_Prd RPM Whse. Overh. Cust."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(167; "T_Prd RPM Whse. Overh. IT"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        field(168; "Processing Date"; Date)
        {
            Caption = 'Processing Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(169; "OVE Warehouse Handling"; Decimal)
        {
            Caption = 'OVE Warehouse Handling';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(170; "OVE Whse. Hand. ST"; Decimal)
        {
            Caption = 'OVE Warehouse Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(171; "TRP Warehouse Handling"; Decimal)
        {
            Caption = 'TRP Warehouse Handling';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(172; "TRP Whse. Hand. ST"; Decimal)
        {
            Caption = 'TRP Warehouse Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(173; "FIX Warehouse Handling"; Decimal)
        {
            Caption = 'FIX Warehouse Handling';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(174; "FIX Whse. Hand. ST"; Decimal)
        {
            Caption = 'FIX Warehouse Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(175; "OVE Prd G/L Whse Hand Cost"; Decimal)
        {
            Caption = 'OVE Period G/L Cost Whse. Handling';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(176; "TRP Prd G/L Whse Hand Cost"; Decimal)
        {
            Caption = 'TRP Period G/L Cost Whse. Handling';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(177; "FIX Prd G/L Whse Hand Cost"; Decimal)
        {
            Caption = 'FIX Period G/L Cost Whse. Handling';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(178; "OVE Avg. Cost-Whse. Handl. ST"; Decimal)
        {
            Caption = 'OVE Average Cost-Warehouse Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(179; "TRP Avg. Cost-Whse. Handl. ST"; Decimal)
        {
            Caption = 'TRP Average Cost-Warehouse Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(180; "FIX Avg. Cost-Whse. Handl. ST"; Decimal)
        {
            Caption = 'FIX Average Cost-Warehouse Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(181; "OVE IT Cost-Whse. Handling ST"; Decimal)
        {
            Caption = 'OVE IT Cost-Whse. Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(182; "TRP IT Cost-Whse. Handling ST"; Decimal)
        {
            Caption = 'TRP IT Cost-Whse. Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(183; "FIX IT Cost-Whse. Handling ST"; Decimal)
        {
            Caption = 'FIX IT Cost-Whse. Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(184; "OVE Unit Cost-Whse. Handl. ST"; Decimal)
        {
            Caption = 'OVE Cumulative Unit Cost-Warehouse Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(185; "TRP Unit Cost-Whse. Handl. ST"; Decimal)
        {
            Caption = 'TRP Cumulative Unit Cost-Warehouse Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(186; "FIX Unit Cost-Whse. Handl. ST"; Decimal)
        {
            Caption = 'FIX Cumulative Unit Cost-Warehouse Handling ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(187; "OVE Unit Cost-Whse. Handl. SO"; Decimal)
        {
            CalcFormula = Lookup("Shipping Cost Allocation FND"."OVE Unit Cost-Whse. Handl. ST" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                                   "Period Date" = FIELD("Period Date"),
                                                                                                   "Item No." = FIELD("Item No."),
                                                                                                   "Lot No. & Destination No." = FIELD("Lot No. & Location Code")));
            Caption = 'OVE Unit Cost-Whse. Handling SO';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(188; "TRP Unit Cost-Whse. Handl. SO"; Decimal)
        {
            CalcFormula = Lookup("Shipping Cost Allocation FND"."TRP Unit Cost-Whse. Handl. ST" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                                   "Period Date" = FIELD("Period Date"),
                                                                                                   "Item No." = FIELD("Item No."),
                                                                                                   "Lot No. & Destination No." = FIELD("Lot No. & Location Code")));
            Caption = 'TRP Unit Cost-Whse. Handling SO';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(189; "FIX Unit Cost-Whse. Handl. SO"; Decimal)
        {
            CalcFormula = Lookup("Shipping Cost Allocation FND"."FIX Unit Cost-Whse. Handl. ST" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                                   "Period Date" = FIELD("Period Date"),
                                                                                                   "Item No." = FIELD("Item No."),
                                                                                                   "Lot No. & Destination No." = FIELD("Lot No. & Location Code")));
            Caption = 'FIX Unit Cost-Whse. Handling SO';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(190; "OVE Prd. Whse. Hand. SKU/Lot"; Decimal)
        {
            Caption = '"OVE Period Warehouse Handling per SKU/Lot No. "';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(191; "TRP Prd. Whse. Hand. SKU/Lot"; Decimal)
        {
            Caption = 'TRP Period Warehouse Handling per SKU/Lot No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(192; "FIX Prd. Whse. Hand. SKU/Lot"; Decimal)
        {
            Caption = 'FIX Period Warehouse Handling per SKU/Lot No.';
            DecimalPlaces = 2 : 5;
            Description = 'HEI.13';
        }
        field(193; "OVE ST Whse. Hand. SKU/Lot"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Allocation FND"."OVE Warehouse Handling" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                         "Period Date" = FIELD("Period Date"),
                                                                                         "Item No." = FIELD("Item No."),
                                                                                         "Lot No." = FIELD("Lot No."),
                                                                                         "Destination No." = FIELD("Location Code"),
                                                                                         "Distribution Type" = FIELD("Distribution Type")));
            Caption = 'OVE ST Period Warehouse Handling per SKU/Lot No.';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(194; "TRP ST Whse. Hand. SKU/Lot"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Allocation FND"."TRP Warehouse Handling" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                         "Period Date" = FIELD("Period Date"),
                                                                                         "Item No." = FIELD("Item No."),
                                                                                         "Lot No." = FIELD("Lot No."),
                                                                                         "Destination No." = FIELD("Location Code"),
                                                                                         "Distribution Type" = FIELD("Distribution Type")));
            Caption = 'TRP ST Period Warehouse Handling per SKU/Lot No.';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(195; "FIX ST Whse. Hand. SKU/Lot"; Decimal)
        {
            CalcFormula = Sum("Shipping Cost Allocation FND"."FIX Warehouse Handling" where("Source Document" = FILTER("Outbound Transfer"),
                                                                                         "Period Date" = FIELD("Period Date"),
                                                                                         "Item No." = FIELD("Item No."),
                                                                                         "Lot No." = FIELD("Lot No."),
                                                                                         "Destination No." = FIELD("Location Code"),
                                                                                         "Distribution Type" = FIELD("Distribution Type")));
            Caption = 'FIX ST Period Warehouse Handling per SKU/Lot No';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(196; "OVE Prd. RPM Whse. Handl. Cust"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."OVE Prd. RPM Whse. Handl. Cust" where("Period Date" = FIELD("Period Date"),
                                                                                               "Linked Item No." = FIELD("Item No."),
                                                                                               "Customer No." = FIELD("Destination No."),
                                                                                               "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'OVE Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No.';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(197; "TRP Prd. RPM Whse. Handl. Cust"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."TRP Prd. RPM Whse. Handl. Cust" where("Period Date" = FIELD("Period Date"),
                                                                                               "Linked Item No." = FIELD("Item No."),
                                                                                               "Customer No." = FIELD("Destination No."),
                                                                                               "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'TRP Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No.';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(198; "FIX Prd. RPM Whse. Handl. Cust"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."FIX Prd. RPM Whse. Handl. Cust" where("Period Date" = FIELD("Period Date"),
                                                                                               "Linked Item No." = FIELD("Item No."),
                                                                                               "Customer No." = FIELD("Destination No."),
                                                                                               "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'FIX Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No.';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(199; "OVE Whse. Handling RPM SO"; Decimal)
        {
            Caption = 'OVE Whse. Handling RPM SO';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(200; "TRP Whse. Handling RPM SO"; Decimal)
        {
            Caption = 'TRP Whse. Handling RPM SO';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(201; "FIX Whse. Handling RPM SO"; Decimal)
        {
            Caption = 'FIX Whse. Handling RPM SO';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(202; "OVE Prd. RPM Whse. Handl. IT"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."OVE Prd. RPM Whse. Handl. IT" where("Period Date" = FIELD("Period Date"),
                                                                                             "Linked Item No." = FIELD("Item No."),
                                                                                             "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'OVE Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(203; "TRP Prd. RPM Whse. Handl. IT"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."TRP Prd. RPM Whse. Handl. IT" where("Period Date" = FIELD("Period Date"),
                                                                                             "Linked Item No." = FIELD("Item No."),
                                                                                             "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'TRP Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(204; "FIX Prd. RPM Whse. Handl. IT"; Decimal)
        {
            CalcFormula = Max("RPM - SKU Relationship FND"."FIX Prd. RPM Whse. Handl. IT" where("Period Date" = FIELD("Period Date"),
                                                                                             "Linked Item No." = FIELD("Item No."),
                                                                                             "Own Fleet" = FIELD("Own Fleet")));
            Caption = 'FIX Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers';
            Description = 'HEI.13';
            FieldClass = FlowField;
        }
        field(205; "OVE Whse. Handling RPM ST"; Decimal)
        {
            Caption = 'OVE Whse. Handling RPM ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(206; "TRP Whse. Handling RPM ST"; Decimal)
        {
            Caption = 'TRP Whse. Handling RPM ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(207; "FIX Whse. Handling RPM ST"; Decimal)
        {
            Caption = 'FIX Whse. Handling RPM ST';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
        }
        field(208; "Posted Whse. Shipment No."; Code[20])
        {
            Caption = 'Posted Whse. Shipment No.';
            DataClassification = ToBeClassified;
        }
        field(209; "Posted Whse. Receipt No."; Code[20])
        {
            Caption = 'Posted Whse. Receipt No.';
            DataClassification = ToBeClassified;
        }
        //POENAB02, 06.08.2026, BCUP0-247>>
        field(210; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
            DataClassification = ToBeClassified;
        }
        //POENAB02, 06.08.2026, BCUP0-247<<        
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Posting Date", "Destination Type", "Only RPM Transportation")
        {
        }
        key(Key3; "Parent Line No.")
        {
        }
        key(Key4; "Posting Date", "Destination Type", "Distribution Type")
        {
        }
        key(Key5; "Period Date", "Item No.", "Destination No.", "Own Fleet")
        {
        }
        key(Key6; "Posting Date", "Destination Type", "Only RPM Transportation", "Source Document", "Item Category Code")
        {
        }
        key(Key7; "Posting Date", "Destination Type", "Own Fleet", "Source Document", "Only RPM Transportation", "Distribution Type", "Item Category Code")
        {
            SumIndexFields = "Net Weight (Kg)", "Picking Factor";
        }
        key(Key8; "No.", "Item Category Code")
        {
        }
        key(Key9; "Posting Date", "Item No.", "Source Document", "Lot No. & Destination No.", "Lot No. & Location Code", "Item Category Code", "Distribution Type", "IT Cost Is Calc")
        {
        }
    }

    fieldgroups
    {
    }

    procedure ShowDimensions();
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "No."));
    end;

    procedure ShowDocument();
    var
        PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
        PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnShipmentHeader: Record "Return Shipment Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        TransferReceiptHeader: Record "Transfer Receipt Header";
    begin
        if PostedWhseShipmentHeader.GET("No.") then
            PAGE.RUN(PAGE::"Posted Whse. Shipment", PostedWhseShipmentHeader)
        else if PostedWhseReceiptHeader.GET("No.") then
            PAGE.RUN(PAGE::"Posted Whse. Receipt", PostedWhseReceiptHeader);
    end;

    procedure FindByNo(DocNo: Code[20]): Boolean;
    var
        ShippingCostAlloc: Record "Shipping Cost Allocation FND";
        IsFound: Boolean;
    begin
        //HEI.14>>
        ShippingCostAlloc.SETRANGE("No.", DocNo);
        if ShippingCostAlloc.FINDFIRST() then
            IsFound := true;
        exit(IsFound);
        //HEI.14<<
    end;
}

