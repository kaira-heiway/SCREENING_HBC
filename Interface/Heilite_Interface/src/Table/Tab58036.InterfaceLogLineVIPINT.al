table 58036 "Interface Log Line VIP INT"
{
    // Heilite Navision Old Id - 50164
    // version HEI.22

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Table created
    // 
    // HEI.02 FDD-HT604 GAVANM01 IBM 05.12.2019 #new fields added
    // HEI.03 FDD-HT604 BULIMC01 IBM 06.12.2019 #new fields added
    // HEI.04 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    //   # New field added : 30 - Expected Delivery Date
    // HEI.05 CHG2043663 IBM GAVANM01 29.01.2020 # WMS integration Heilite BASE and Reflex
    //   # New fields added :  564 - Item Shorctcut Dim5
    //                         565 - Item Dim. Value Code5
    // HEI.07 CHG2068423 IBM KUMARN15 01.07.2020
    //     # New fields added 71 - Direct Unit Cost Multiplier
    // HEI.08 FDD-HB899 - CHG2044703 IBM GAVANM01 13.12.2020 # New POS System Required for OPCO
    //   # increase the length of field 550, 551, 552
    //   # fields added, range ID 600-631
    // HEI.09 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added: 150 - External Document No.
    // HEI.10 CHG2095187 IBM SAXENA03 08.02.2021
    //   # Code written for Paraller Request
    //   # Replaced DataExch. record table with DataExch.VIP
    //   # Replaced DataExch. record table with DataExch.VIP in field 500 in RelatedTable.
    // HEI.11 CHG2115040 HB2342 IBM GAVANM01 16.08.2021 #SEM Customer Integration
    //   # New Fields created: 632 - External ID created for SEM Interface
    //                         633 - Salesperson Code
    //                         634 - Salesperson Name
    //                         635 - Service Zone Code
    //                         636 - Service Zone Description
    //                         637 - Sales Routes
    //                         638 - Sales Routes Description
    //                         639 - Business Segment Name
    //                         640 - Bus. Org. Segment Name
    //                         641 - Customer Type NameText
    //                         642 - Customer Subtype NameText
    //                         643 - Local Cust. Subtype Name
    //                         644 - Outlet Classification Name
    // HEI.12 CHG2129985 IBM.LS      21.02.2022
    //   # Created New Fields: 110 - Planned Quantity
    //                         111 - Quantity (Full Pallet)
    //                         112 - Quantity (Full/Partial Pallet)
    //                         113 - EAN
    //                         114 - Ccc Code
    //                         115 - Gross Weight of Pallet in KG
    //                         116 - Shelf Life
    //                         117 - Batch No. (Lot No.)
    //                         118 - Production Date
    //                         119 - Best Before Date
    //   # Added CaptionML for above fields
    // HEI.13 CHG2129985 IBM.LS      04.03.2022
    //   # Modified Shelf Life field datatype from Date to Text
    // HEI.14 CHG2147859 SAHAL01 07.09.2022
    //   # Created New Fields: 120 - Best Before Handled
    //                         121 - Part Group-1
    //                         122 - Part Group-2
    // HEI.15 CHG2149734 SAHAL01 25.08.2022
    //   # Created New Fields: 100 - Prod. Order Status
    //                         101 - Prod. Order No.
    //                         102 - Prod. Order Line No.
    //                         103 - Zone Code
    //                         104 - Bin Code
    //                         105 - Due Date
    //                         106 - Starting Date
    //                         107 - Starting Time
    //                         108 - Ending Date
    //                         109 - Ending Time
    //                         125 - Work Center No.
    //                         129 - Starting Date-Time
    //                         130 - Ending Date-Time
    //                         135 - Prod. Order Comp. Line No.
    //                         136 - Prod. Order Comp. No.
    //                         137 - Prod. Order Comp. Description
    //                         138 - Prod. Order Comp. Location
    //                         139 - Prod. Order Comp. Zone Code
    //                         140 - Prod. Order Comp. Bin Code
    //                         141 - Prod. Order Comp. Quantity
    // HEI.16 CHG2154367 SAHAL01 12.09.2022
    //   # Created New Field: 149 - Quality Status
    // HEI.17 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
    //   # Removed TableRelation of New Field: 135 - Prod. Order Comp. Line No.
    //   # Modified ValidateTableRelation of New Field: 125 - Work Center No.
    //   # Modified TableRelation of New Field: 136 - Prod. Order Comp. No.
    // HEI.18 CHG2178366-HB3189 IBM SOICAD02 22.11.2022 Customer Masterdata interface to DOT change
    //   #New field Customer Promotion
    // HEI.19 CHG2154372 SAHAL01 02.12.2022 Astro - I/F Inventory Management - BalanceChange
    //   # Modified TableRelation of New Field: 101 - Prod. Order No.
    // HEI.20 CHG2210794 SAHAL01 17.01.2024 Zycus - BASE HL Integration Master Dimension
    //   # Text Length increased from 80 to 100 for this  Field: 558 - E-mail
    // HEI.21 CHG2210794 SAHAL01 11.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Fields: 160 - Action Code
    //                         163 - External Order No.
    //                         164 - External Order Line No.
    //                         166 - Global No.
    //                         167 - Fixed Asset No.
    //                         168 - Currency Code 2
    //                         169 - Item Charge Value
    //                         170 - Direct Unit Cost
    //                         171 - Direct Unit Cost 2
    //                         172 - CMG Code
    //                         173 - Expected Receipt Date
    //                         174 - Delivery Finalized
    //                         175 - Ship-to Code
    //                         176 - Ship-to City
    //                         177 - Ship-to Post Code
    //                         178 - Ship-to Country/Region Code
    // HEI.22 CHG2210794 SAHAL01 24.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Modified Field length of Fixed Asset No. from 10 to 20.

    Caption = 'Interface Log Line VIP';

    fields
    {
        field(1; "Header Entry No."; Integer)
        {
            Caption = 'Header Entry No.';
            NotBlank = true;
            TableRelation = "Interface Log Header VIP INT";
        }
        field(2; "Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Entry No.';
        }
        field(3; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = '" ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)"';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST(Resource)) Resource
            ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF (Type = CONST("Charge (Item)")) "Item Charge";
            ValidateTableRelation = false;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(11; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(12; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            ValidateTableRelation = false;
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            ValidateTableRelation = false;
        }
        field(14; "Unit Amount"; Decimal)
        {
            Caption = 'Unit Amount';
            DecimalPlaces = 2 : 5;
        }
        field(15; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DecimalPlaces = 2 : 2;
        }
        field(16; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
        }
        field(17; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
        }
        field(27; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(30; "Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
            Description = 'HEI.04';
        }
        field(36; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output,,,,,,Payment,Payout';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output",,,,,,Payment,Payout;
        }
        field(51; "Legal Entity"; Code[10])
        {
            Caption = 'Legal Entity';
        }
        field(54; Blocked; Boolean)
        {
            Caption = 'Blocked';

            trigger OnValidate();
            var
                Lbln_Allowed: Boolean;
            begin
            end;
        }
        field(61; "External Contract No."; Code[10])
        {
            Caption = 'External Contract No.';
        }
        field(62; "External Contract Line No."; Code[10])
        {
            Caption = 'External Contract Line No.';
        }
        field(65; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(71; "Direct Unit Cost Multiplier"; Decimal)
        {
            Caption = 'Direct Unit Cost Multiplier';
            Description = 'HEI.07';
        }
        field(91; Notes; BLOB)
        {
            Caption = 'Notes';
        }
        field(97; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            ValidateTableRelation = false;
        }
        field(99; "Amount Incl. VAT"; Decimal)
        {
        }
        field(100; "Prod. Order Status"; Option)
        {
            Caption = 'Prod. Order Status';
            Description = 'HEI.15';
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
        }
        field(101; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Description = 'HEI.15,HEI.19';
            TableRelation = "Production Order"."No.";
            ValidateTableRelation = false;
        }
        field(102; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            Description = 'HEI.15';
        }
        field(103; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.15';
            TableRelation = Zone.Code;
        }
        field(104; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'HEI.15';
            TableRelation = Bin.Code;
        }
        field(105; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Description = 'HEI.15';
        }
        field(106; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            Description = 'HEI.15';
        }
        field(107; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            Description = 'HEI.15';
        }
        field(108; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            Description = 'HEI.15';
        }
        field(109; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            Description = 'HEI.15';
        }
        field(110; "Planned Quantity"; Decimal)
        {
            Caption = 'Planned Quantity';
            Description = 'HEI.12';
        }
        field(111; "Quantity (Full Pallet)"; Decimal)
        {
            Caption = 'Quantity (Full Pallet)';
            Description = 'HEI.12';
        }
        field(112; "Quantity (Full/Partial Pallet)"; Decimal)
        {
            Caption = 'Quantity (Full/Partial Pallet)';
            Description = 'HEI.12';
        }
        field(113; EAN; Code[20])
        {
            Caption = 'EAN';
            Description = 'HEI.12';
        }
        field(114; "Ccc Code"; Code[20])
        {
            Caption = 'Ccc Code';
            Description = 'HEI.12';
        }
        field(115; "Gross Weight of Pallet in KG"; Decimal)
        {
            Caption = 'Gross Weight of Pallet in KG';
            Description = 'HEI.12';
        }
        field(116; "Shelf Life"; Text[30])
        {
            Caption = 'Shelf Life';
            Description = 'HEI.12,HEI.13';
        }
        field(117; "Batch No. (Lot No.)"; Code[20])
        {
            Caption = 'Batch No. (Lot No.)';
            Description = 'HEI.12';
        }
        field(118; "Production Date"; Date)
        {
            Caption = 'Production Date';
            Description = 'HEI.12';
        }
        field(119; "Best Before Date"; Date)
        {
            Caption = 'Best Before Date';
            Description = 'HEI.12';
        }
        field(120; "Best Before Handled"; Integer)
        {
            Caption = 'Best Before Handled';
            Description = 'HEI.14';
        }
        field(121; "Part Group-1"; Option)
        {
            Caption = 'Part Group-1';
            Description = 'HEI.14';
            OptionCaption = '" ,FP,PM,BM,RPM"';
            OptionMembers = " ",FP,PM,BM,RPM;
        }
        field(122; "Part Group-2"; Code[20])
        {
            Caption = 'Part Group-2';
            Description = 'HEI.14';
        }
        field(125; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            Description = 'HEI.15,HEI.17';
            TableRelation = "Work Center";
            ValidateTableRelation = false;
        }
        field(129; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
            Description = 'HEI.15';
        }
        field(130; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';
            Description = 'HEI.15';
        }
        field(135; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            Description = 'HEI.15,HEI.17';
        }
        field(136; "Prod. Order Comp. No."; Code[20])
        {
            Caption = 'Prod. Order Comp. No.';
            Description = 'HEI.15,HEI.17';
            TableRelation = Item;
            ValidateTableRelation = false;
        }
        field(137; "Prod. Order Comp. Description"; Text[50])
        {
            Caption = 'Prod. Order Comp. Description';
            Description = 'HEI.15';
        }
        field(138; "Prod. Order Comp. Location"; Code[10])
        {
            Caption = 'Prod. Order Comp. Location Code';
            Description = 'HEI.15';
            TableRelation = Location;
        }
        field(139; "Prod. Order Comp. Zone Code"; Code[10])
        {
            Caption = 'Prod. Order Comp. Zone Code';
            Description = 'HEI.15';
            TableRelation = Zone.Code;
        }
        field(140; "Prod. Order Comp. Bin Code"; Code[20])
        {
            Caption = 'Prod. Order Comp. Bin Code';
            Description = 'HEI.15';
            TableRelation = Bin.Code;
        }
        field(141; "Prod. Order Comp. Quantity"; Decimal)
        {
            Caption = 'Prod. Order Comp. Quantity';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.15';
        }
        field(149; "Quality Status"; Option)
        {
            Caption = 'Quality Status';
            Description = 'HEI.16';
            OptionCaption = 'Quality Hold,Unrestricted,Blocked';
            OptionMembers = "Quality Hold",Unrestricted,Blocked;
        }
        field(150; "External Document No."; Code[35])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
        }
        field(160; "Action Code"; Code[2])
        {
            Caption = 'Action Code';
            Description = 'HEI.21';
        }
        field(163; "External Order No."; Code[20])
        {
            Caption = 'External Order No.';
            Description = 'HEI.21';
        }
        field(164; "External Order Line No."; Integer)
        {
            Caption = 'External Order Line No.';
            Description = 'HEI.21';
        }
        field(166; "Global No."; Code[20])
        {
            Caption = 'Global No.';
            Description = 'HEI.21';
        }
        field(167; "Fixed Asset No."; Code[20])
        {
            Caption = 'Fixed Asset No.';
            Description = 'HEI.21,HEI.22';
        }
        field(168; "Currency Code 2"; Code[10])
        {
            Caption = 'Currency Code 2';
            Description = 'HEI.21';
            TableRelation = Currency;
            ValidateTableRelation = false;
        }
        field(169; "Item Charge Value"; Decimal)
        {
            Caption = 'Item Charge Value';
            Description = 'HEI.21';
        }
        field(170; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
            Description = 'HEI.21';
        }
        field(171; "Direct Unit Cost 2"; Decimal)
        {
            Caption = 'Direct Unit Cost 2';
            Description = 'HEI.21';
        }
        field(172; "CMG Code"; Code[20])
        {
            Caption = 'CMG Code';
            Description = 'HEI.21';
        }
        field(173; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            Description = 'HEI.21';
        }
        field(174; "Delivery Finalized"; Boolean)
        {
            Caption = 'Delivery Finalized';
            Description = 'HEI.21';
        }
        field(175; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Description = 'HEI.21';
            TableRelation = "Ship-to Address".Code;
            ValidateTableRelation = false;
        }
        field(176; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            Description = 'HEI.21';
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code".City
            ELSE IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            ValidateTableRelation = false;
        }
        field(177; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            Description = 'HEI.21';
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code"
            ELSE IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            ValidateTableRelation = false;
        }
        field(178; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            Description = 'HEI.21';
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(201; "Message ID"; Code[35])
        {
            Caption = 'Message ID';
        }
        field(210; "Severity Code"; Code[10])
        {
            Caption = 'Severity Code';
        }
        field(211; "Log Message"; Text[200])
        {
            Caption = 'Log Message';
        }
        field(220; "Message Code"; Code[20])
        {
            Caption = 'Message Code';
        }
        field(221; "Message Type"; Code[20])
        {
            Caption = 'Message Type';
        }
        field(222; "Message Class"; Code[20])
        {
            Caption = 'Message Class';
        }
        field(300; "Sync. Date"; DateTime)
        {
            CalcFormula = Lookup("Interface Log Header VIP INT"."Sync. Date" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Synchronize Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(305; "Source Type"; Integer)
        {
            CalcFormula = Lookup("Interface Log Header VIP INT"."Source Type" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Source Type';
            Editable = false;
            FieldClass = FlowField;
        }
        field(307; "Source No."; Code[20])
        {
            CalcFormula = Lookup("Interface Log Header VIP INT"."Source No." WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Source No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(308; "Source Status"; Option)
        {
            CalcFormula = Lookup("Interface Log Header VIP INT"."Source Status" WHERE("Entry No." = FIELD("Header Entry No.")));
            Caption = 'Source Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(500; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.';
            //TableRelation = "Data Exch. VIP";
            TableRelation = "Data Exch.";//BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch.>>
        }
        field(513; "Item Code"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(514; "Item Designation"; Text[50])
        {
            Description = 'HEI.02';
        }
        field(515; "Traceability Code"; Code[10])
        {
            Description = 'HEI.02';
        }
        field(516; "Item UOM in Reflex 1st"; Code[10])
        {
            Description = 'HEI.02';
        }
        field(517; "Item UOM in Reflex 2rd"; Code[10])
        {
            Description = 'HEI.02';
        }
        field(518; "Item UOM in Reflex 3rd"; Code[10])
        {
            Description = 'HEI.02';
        }
        field(519; "Cross-Ref. No. Reflex 1st"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(520; "Cross-Ref. No. Reflex 2rd"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(521; "Cross-Ref. No. Reflex 3rd"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(522; "Cross Ref Desc. Reflex 1st"; Text[50])
        {
            Description = 'HEI.02';
        }
        field(523; "Cross Ref Desc. Reflex 2rd"; Text[50])
        {
            Description = 'HEI.02';
        }
        field(524; "Cross Ref Desc. Reflex 3rd"; Text[50])
        {
            Description = 'HEI.02';
        }
        field(525; "Reflex Ref. UOM Reflex 2rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(526; "Reflex Ref. UOM Reflex 3rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(527; "Length Reflex 1st"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(528; "Length Reflex 2rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(529; "Length Reflex 3rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(530; "Width Reflex 1st"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(531; "Width Reflex 2rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(532; "Width Reflex 3rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(533; "Height Reflex 1st"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(534; "Height Reflex 2rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(535; "Height Reflex 3rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(536; "Weight Reflex 1st"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(537; "Weight Reflex 2rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(538; "Weight Reflex 3rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(539; "Net Weight Reflex 1st"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(540; "Net Weight Reflex 2rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(541; "Net Weight Reflex 3rd"; Decimal)
        {
            Description = 'HEI.02';
        }
        field(542; "Item Shorctcut Dim1"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(543; "Item Dim. Value Code1"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(544; "Item Shorctcut Dim2"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(545; "Item Dim. Value Code2"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(546; "Item Shorctcut Dim6"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(547; "Item Dim. Value Code6"; Code[20])
        {
            Description = 'HEI.02';
        }
        field(548; "Customer Code"; Code[20])
        {
            Description = 'HEI.03';
        }
        field(549; Name; Text[30])
        {
            Description = 'HEI.03';
        }
        field(550; "Name 2"; Text[50])
        {
            Description = 'HEI.03,HEI.08';
        }
        field(551; Address; Text[60])
        {
            Description = 'HEI.03,HEI.08';
        }
        field(552; "Address 2"; Text[60])
        {
            Description = 'HEI.03,HEI.08';
        }
        field(553; "Post Code"; Code[20])
        {
            Description = 'HEI.03';
        }
        field(554; City; Text[35])
        {
            Description = 'HEI.03';
        }
        field(555; "Country Code"; Code[10])
        {
            Description = 'HEI.03';
        }
        field(556; "Country Name"; Text[50])
        {
            Description = 'HEI.03';
        }
        field(557; "Phone No."; Text[30])
        {
            Description = 'HEI.03';
        }
        field(558; "E-mail"; Text[100])
        {
            Description = 'HEI.03,HEI.20';
        }
        field(559; Route; Code[10])
        {
            Description = 'HEI.03';
        }
        field(560; Flag; Text[10])
        {
            Description = 'HEI.02';
        }
        field(561; "Ship-to Address Key No."; Code[10])
        {
            Description = 'HEI.03';
        }
        field(562; Classification; Code[10])
        {
            Description = 'HEI.03';
        }
        field(563; "Require 2 Drivers"; Boolean)
        {
            Description = 'HEI.03';
        }
        field(564; "Item Shorctcut Dim5"; Code[20])
        {
            Description = 'HEI.05';
        }
        field(565; "Item Dim. Value Code5"; Code[20])
        {
            Description = 'HEI.05';
        }
        field(600; "Search Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(601; "Cust/Vend. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(602; "Gen. Bus. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(603; "VAT Bus. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(604; "Payment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(605; "Shipment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(606; "VAT Registration No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(607; Contact; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(608; "Telex No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(609; "Pay-to Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(610; "Fax No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(611; "Home Page"; Text[80])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(612; "No. 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(613; "Base UOM"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(614; "Qty per Base UOM"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(615; "EAN for Base UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(616; "Item Type"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(617; "Inventory Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(618; "Costing Method"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(619; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(620; "Standard Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(621; "Inventory Value Zero"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(622; "Rounding Precision"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(623; "Sales UOM"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(624; "Qty per Sales UOM"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(625; "EAN for Sales UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(626; "Purch. UOM"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(627; "Qty per Purch. UOM"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(628; "EAN for Purch. UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(629; "Item Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(630; "Product Group Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(631; "Block reason"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(632; "External ID"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(633; "Salesperson Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(634; "Salesperson Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(635; "Service Zone Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(636; "Service Zone Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(637; "Sales Routes"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(638; "Sales Routes Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(639; "Business Segment Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(640; "Bus. Org. Segment Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(641; "Customer Type Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(642; "Customer Subtype Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(643; "Local Cust. Subtype Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(644; "Outlet Classification Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
        }
        field(650; "Customer Promotion"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
        }
    }

    keys
    {
        key(Key1; "Header Entry No.", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        BlobIsEmpty: Label 'The entry does not contain any description data.';

    procedure ShowNotes();
    var
        //TempBlob: Record TempBlob;  // BC Upgrade NANDIS03 - TempBlob Record is obsolete
        TempBlob: Codeunit "Temp Blob";  // BC Upgrade NANDIS03 - Temp Blob CU is introduced
        FileManagement: Codeunit "File Management";
        InStr: InStream;
        OutStr: OutStream;
    begin
        if Notes.HASVALUE then begin
            CALCFIELDS(Notes);
            Notes.CREATEINSTREAM(InStr);
            // TempBlob.Blob.CREATEOUTSTREAM(OutStr);  // BC Upgrade NANDIS03 - Blocked the line
            TempBlob.CreateOutStream(OutStr);  // BC Upgrade NANDIS03 - Opened the line
            COPYSTREAM(OutStr, InStr);
            FileManagement.BLOBExport(TempBlob, '.txt', true);
        end else
            MESSAGE(BlobIsEmpty);
    end;
}

