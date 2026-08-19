tableextension 50103 WarehouseSetupExtFND extends "Warehouse Setup"
{
    // DITW15.00.00.21 DDR 20/06/2008 Added fields
    //                                  2014070 Copy Shipment Method Code
    //                                  2014071 Copy Shipping Agent Code
    //                                  2014072 Copy Ship. Agent Service Code
    //                                  2014073 Copy Shipment Date
    // DITW15.00.00.25 DDR 17/10/2008 Added fields
    //                                  2014074 Copy Truck/Driver Code
    // DITW15.00.00.29 DDR 19/12/2008 Added fields
    //                                  2014091 Copy Distance
    // DITW15.00.00.34 DDR 10/06/2009 Added fields
    //                                  2014088 Create Whse. Per Source Doc.
    //                                Added function IsCopySourceValue()
    // DITW15.00.00.35 DDR 19/08/2009 issue 771 Bugfix to set default value for field "Copy Distance"
    //                     21/08/2009 issue 626 Renamed optionstring caption for field "Create Whse. Header"
    // DITW15.00.00.35 DDR 07/10/2009 issue 516 Added fields
    //                                  2014095 Whse. Doc. per Phys. Location
    // DITW15.00.00.38 DDR 21/12/2010 issue 1146 Added fields
    //                                  2014451 Auto.Release Transfer on Whse.
    // DITW15.00.00.39 DDR 12/04/2011 issue 1314 Added check Warehouse employees while modifying field "Whse. Doc. per Phys. Locati
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                  2014107 Default Route
    //                     08/02/2012 issue 1002 Added fields
    //                                  2014066 Copy Route
    //                     13/02/2012 DIT-715 #244
    //                                Added fields
    //                                  2014069 Shortcut Unit of Measure1 Code
    //                                  2014089 Shortcut Unit of Measure2 Code
    //                                  2014093 Shortcut Unit of Measure3 Code
    //                                Added functions ExistShortuctUomCodes(),GetShortcutShptUomCode(),GetShortcutUomCaption()

    // DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added fields
    //                                               2014560 Copy Vessel Info. Code
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #95
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Field Copy Route planning Code
    //                                                    Copy Driver/Driver 2 Code
    //                                        Rename Field Copy Truck/Driver --> Copy Truck/Trailer
    // DITW110.00.11 MSF 02/10/2017 NRQ#16082 Remove Filed Default Route
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 Added field Show Item Track. Alert on Shpt
    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Field created: 50002 - Request Order Nos.
    // HEI.02 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Fields created: 50003 - Gate Entry Nos.
    //                         50004 - Gate Entry Weight Tolerance %
    //                         50005 - Allow Collect Lines
    //                         50006 - Auto Insert Qty. Collected Lin
    // HEI.03 FDD-BA-LOGGAP03 IBM NASTAA02 01.10.2018 # Sales Invoice Layout
    //   # New Field created: 50007 - Shortcut Unit of Measure2 Filter
    // HEI.05 Defect #3416 IBM NASTAA02 07.11.2018 # Sales Invoice Layout - Cosmetic adjustments
    //   # New Field created: 50009 - "Shortcut Unit of Measure4 Code"
    // HEI.06 FDD-HT658 IBM.GUNERE01 28.10.2019 # "Doc. Shipping Cost Creation" field added
    // HEI.07 FDD-HT1075 CHG2039144 IBM.GUNERE01 13.01.2020 # Field ID : 50011 Ask Ship. Info on Second Rcpt. added
    //                                                        "Doc. Shipping Cost Creation" field option strings modified
    // HEI.08 FDD-HB503 IBM NASTAA02 31.03.2020 # Post & Print
    //   # New Field created: 50012 - "Enable Post and Print based on Location"
    // HEI.09 CHG2095415 IBM BULIMC01 22.03.2021#new fields added for Cost To Serve setup:
    //   #50013-"Net Weight Unit of Measure"
    //   #50014-"Picking Unit of Measure"
    //   #50015-"NonPallet Coeficient"
    // HEI.10 CHG2141694 BULIMC01 IBM 21/02/2021#new fields added:
    //   #50017 - "Job Queue Run Pre-Close Date"
    //   #50018 - "Job Queue Run Close Date"
    //   #50019 - "Additional Days for December"
    //   #50020 - "Report ID for Job Queue"
    //   #50021 - "Report Name for Job Queue"
    //   #50022 - "Job Q. Pre-Run Close Date Dec."
    //   #50023 - "C2S Base Calendar Code"
    // HEI.11 CHG2135085 SAHAL01      24.03.2022
    //   # Created New Fields: 50031 - COGS JobQ Run Pre-Close Date
    //                         50032 - COGS JobQ Run Close Date
    // HEI.12 IBM CHG2132673 BULIMC01 13/04/2022 C2S Allocation - new fields added:
    //     #50033 - "SCOA Financial Statement Version"
    //     #50034 - "SCOA Financial Statement Opt."
    // HEI.13 INC4122240 - CHG2159877 IBM NASTAA02 27/05/2022 # Please stop sending C2S allocation for previous periods to archived table
    //   # New Field created: 50035 - C2S COGS Job Queue Cat Code
    // HEI.14 CHG2162842 IBM SAMANR01 20/06/202022 #C2S optimazation & archiving
    //   # New field created: 50036 - Archive JQ Date Calculation & add code on validate
    // HEI.15 CHG2193789/INC4544076 IBM PRASAA03 22/02/202023 Mandatory before a TO is posted, but also modifiable in case the lead time is exceeded
    //   # New field created: 50037 - Select Ship & Rcpt Date in TO
    // HEI.16 CHG2253923 IBM POENAB02 21.11.2024 HB3943 Stock in transit - enablement of updating standard cost
    //   # New fields:
    //     50036 "StockInTransLogRetention(Days)"
    //     50037 "Enable Stock in Trans. Funct"
    // HEI.17 CHG2278211 IBM PATHAA02 16/12/2024 Deletion of Obsolete Heilite TOs
    //   # New Field:50358 "Transfer Order Shipping Date"
    // HEI.18 CHG2278211 IBM KAMNAY01 18/12/2024 Deletion of Obsolete Heilite TOs
    //   # New Field:50359 "Exclude Location Filter"
    // version NAVW18.00,DITW110.00.11,HEI.18
    //BC Upgrade PATHAA02 - HEI.10 and HEI.14 commented(Fn-CalcNextWorkingDate is having fuctions called which are DIT customised)
    // due to dependecy on DIT (showCheckCustomizedDateStatus)

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Whse. Receipt Nos.")
        {
            CaptionML = ENU = 'Whse. Receipt Nos.', FRA = 'N° réception entrep.';
        }
        modify("Whse. Put-away Nos.")
        {
            CaptionML = ENU = 'Whse. Put-away Nos.', FRA = 'N° rangement entrep.';
        }
        modify("Whse. Pick Nos.")
        {
            CaptionML = ENU = 'Whse. Pick Nos.', FRA = 'N° prélèvement entrep.';
        }
        modify("Whse. Ship Nos.")
        {
            CaptionML = ENU = 'Whse. Ship Nos.', FRA = 'N° expédition entrep.';
        }
        modify("Registered Whse. Pick Nos.")
        {
            CaptionML = ENU = 'Registered Whse. Pick Nos.', FRA = 'N° prélèvement entrep. enreg.';
        }
        modify("Registered Whse. Put-away Nos.")
        {
            CaptionML = ENU = 'Registered Whse. Put-away Nos.', FRA = 'N° rangement entrep. enreg.';
        }
        modify("Require Receive")
        {
            CaptionML = ENU = 'Require Receive', FRA = 'Réception requise';
        }
        modify("Require Put-away")
        {
            CaptionML = ENU = 'Require Put-away', FRA = 'Rangement requis';
        }
        modify("Require Pick")
        {
            CaptionML = ENU = 'Require Pick', FRA = 'Prélèvement requis';
        }
        modify("Require Shipment")
        {
            CaptionML = ENU = 'Require Shipment', FRA = 'Expédition requise';
        }
        /*  modify("Last Whse. Posting Ref. No.")
         {
             CaptionML = ENU = 'Last Whse. Posting Ref. No.', FRA = 'N° réf. dern. validation entrepôt';
         } */ //MARKED FOR REMOVAL BCUPG
        modify("Receipt Posting Policy")
        {
            CaptionML = ENU = 'Receipt Posting Policy', FRA = 'Mode validation réception';
            OptionCaptionML = ENU = 'Posting errors are not processed,Stop and show the first posting error', FRA = 'Erreurs de validation non traitées,Arrêt et affichage de la 1ère erreur de validation';
        }
        modify("Shipment Posting Policy")
        {
            CaptionML = ENU = 'Shipment Posting Policy', FRA = 'Mode validation expédition';
            OptionCaptionML = ENU = 'Posting errors are not processed,Stop and show the first posting error', FRA = 'Erreurs de validation non traitées,Arrêt et affichage de la 1ère erreur de validation';
        }
        modify("Posted Whse. Receipt Nos.")
        {
            CaptionML = ENU = 'Posted Whse. Receipt Nos.', FRA = 'N° réceptions entrep. enreg.';
        }
        modify("Posted Whse. Shipment Nos.")
        {
            CaptionML = ENU = 'Posted Whse. Shipment Nos.', FRA = 'N° expéditions entrep. enreg.';
        }
        modify("Whse. Internal Put-away Nos.")
        {
            CaptionML = ENU = 'Whse. Internal Put-away Nos.', FRA = 'N° rangements internes entrep.';
        }
        modify("Whse. Internal Pick Nos.")
        {
            CaptionML = ENU = 'Whse. Internal Pick Nos.', FRA = 'N° prélèvements internes entrep.';
        }
        modify("Whse. Movement Nos.")
        {
            CaptionML = ENU = 'Whse. Movement Nos.', FRA = 'N° mouvements entrep.';
        }
        modify("Registered Whse. Movement Nos.")
        {
            CaptionML = ENU = 'Registered Whse. Movement Nos.', FRA = 'N° mouvement entrep. enreg.';
        }

        //Unsupported feature: CodeModification on ""Require Receive"(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Require Receive" THEN
          "Require Put-away" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Require Receive" then
          "Require Put-away" := false;
        */
        //end;


        //Unsupported feature: CodeModification on ""Require Put-away"(Field 14).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Require Put-away" THEN
          "Require Receive" := TRUE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Require Put-away" then
          "Require Receive" := true;
        */
        //end;


        //Unsupported feature: CodeModification on ""Require Pick"(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Require Pick" THEN
          "Require Shipment" := TRUE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Require Pick" then
          "Require Shipment" := true;
        */
        //end;


        //Unsupported feature: CodeModification on ""Require Shipment"(Field 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Require Shipment" THEN
          "Require Pick" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Require Shipment" then
          "Require Pick" := false;
        */
        //end;
        field(50000; "Print Delivery Note FND"; Boolean)
        {
            caption = 'Print Delivery Note';
            Description = 'LOGGAP07';
        }
        field(50001; "Delivery Note Pay Terms FND"; Code[10])
        {
            caption = 'Delivery Note Pay Terms';
            Description = 'LOGGAP07';
            TableRelation = "Payment Terms".Code;
        }
        field(50002; "Request Order Nos. FND"; Code[10])
        {
            AccessByPermission = TableData "Transfer Header" = R;
            Caption = 'Request Order Nos.';
            Description = 'HEI.01';
            TableRelation = "No. Series";
        }
        field(50003; "Gate Entry Nos. FND"; Code[10])
        {
            Caption = 'Gate Entry Nos.';
            Description = 'HEI.02';
            TableRelation = "No. Series";
        }
        field(50004; "Gate Entry Weight Tole % FND"; Decimal)
        {
            Caption = 'Gate Entry Weight Tolerance %';
            Description = 'HEI.02';
        }
        field(50005; "Allow Collect Lines FND"; Boolean)
        {
            caption = 'Allow Collect Lines';
            Description = 'HEI.02';
        }
        field(50006; "Auto Insert Qty.CollectLin FND"; Boolean)
        {
            caption = 'Auto Insert Qty. Collected Lin';
            Description = 'HEI.02';
        }
        field(50007; "Short Unit of Meas2 Filt FND"; Text[100])
        {
            Caption = 'Shortcut Unit of Measure2 Filter';
            Description = 'HEi.03';

            trigger OnLookup();
            var
                UnitofMeasure: Record "Unit of Measure";
                ShortcutUoMFilter: Text[100];
            begin
                //HEI.03>>
                if PAGE.RUNMODAL(209, UnitofMeasure) = ACTION::LookupOK then
                    ShortcutUoMFilter := UnitofMeasure.Code;
                if ShortcutUoMFilter <> '' then
                    "Short Unit of Meas2 Filt FND" := ShortcutUoMFilter;
                //HEI.03<<
            end;
        }
        field(50009; "Shortcut Unit of Meas4Code FND"; Code[10])
        {
            CaptionML = ENU = 'Shortcut Qty per Unit of Measure 4 Code',
                        FRA = 'Code raccourci Quantité par unité 1';
            Description = 'HEI.05';
            TableRelation = "Unit of Measure";
        }
        field(50010; "Doc. Ship Cost Creation FND"; Option)
        {
            caption = 'Doc. Shipping Cost Creation';
            Description = 'HEI.07';
            OptionCaption = '" ,Transfer-From Location,Transfer-To Location"';
            OptionMembers = " ","Transfer-From Location","Transfer-To Location";
        }
        field(50011; "Ask Ship. Info on SecRcpt. FND"; Boolean)
        {
            Caption = 'Ask Confirmation Shipping Information On Second Receipt';
            Description = 'HEI.07';
        }
        field(50012; "Enable Post & Print on Loc FND"; Boolean)
        {
            Caption = 'Enable Post and Print based on Location';
            Description = 'HEI.08';
        }
        field(50013; "Net Weight UoM (Kg) FND"; Code[10])
        {
            Caption = 'Net Weight UoM (Kg)';
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            TableRelation = "Unit of Measure";
        }
        field(50014; "Net Weight UoM (G) FND"; Code[10])
        {
            Caption = 'Net Weight UoM (G)';
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            TableRelation = "Unit of Measure";
        }
        field(50016; "Picking Coeff. Non-Pallet FND"; Decimal)
        {
            Caption = 'Picking Coefficient for Non-Pallet';
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
        }
        field(50017; "Job Queue Run PreCloseDate FND"; DateFormula)
        {
            Caption = 'Job Queue Run Pre-Close Date Calculation';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            //BC Upgrade PATHAA02 >>
            // trigger OnValidate();
            // begin
            //     //HEI.10<<
            //     C2SRunningCalendar.RESET;
            //     C2SRunningCalendar.SETFILTER(Name, '<>%1', Text001);
            //     if C2SRunningCalendar.findset then
            //         repeat
            //             C2SRunningCalendar."Automatic Run Pre-Close Date" := CalendarMgt.CalcNextWorkingDate(Rec."Job Queue Run Pre-Close Date", C2SRunningCalendar."Ending Date", "C2S Base Calendar Code");
            //             C2SRunningCalendar.MODIFY;
            //         until C2SRunningCalendar.NEXT = 0;
            //     //HEI.10>>
            // end;
            //BC Upgrade PATHAA02 <<-Dependency on DIT
        }
        field(50018; "Job Queue Run Close Date FND"; DateFormula)
        {
            Caption = 'Job Queue Run Close Date Calculation';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            // BC Upgrade PATHAA02 >>-Dependency on DIT
            // trigger OnValidate();
            // begin
            //     //HEI.10<<
            //     C2SRunningCalendar.RESET;
            //     C2SRunningCalendar.SETFILTER(Name, '<>%1', Text001);
            //     if C2SRunningCalendar.findset then
            //         repeat
            //             C2SRunningCalendar."Automatic Run Close Date" := CalendarMgt.CalcNextWorkingDate(Rec."Job Queue Run Close Date", C2SRunningCalendar."Ending Date", "C2S Base Calendar Code");
            //             C2SRunningCalendar.MODIFY;
            //         until C2SRunningCalendar.NEXT = 0;
            //     //HEI.10>>
            // end;
            // BC Upgrade PATHAA02 <<-Dependency on DIT

        }
        field(50019; "Job Que RunCloseDate Dec. FND"; DateFormula)
        {
            Caption = 'Job Queue Run Close Date Calculation December';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';

            // BC Upgrade PATHAA02 >>-Dependency on DIT
            // trigger OnValidate();
            // begin
            //     //HEI.10<<
            //     C2SRunningCalendar.RESET;
            //     C2SRunningCalendar.SETRANGE(Name, Text001);
            //     if C2SRunningCalendar.findset then
            //         repeat
            //             C2SRunningCalendar."Automatic Run Close Date" := CalendarMgt.CalcNextWorkingDate(Rec."Job Queue Run Close Date Dec.", C2SRunningCalendar."Ending Date", "C2S Base Calendar Code");
            //             C2SRunningCalendar.MODIFY;
            //         until C2SRunningCalendar.NEXT = 0;
            //     //HEI.10>>
            // end;
            // BC Upgrade PATHAA02 <<-Dependency on DIT

        }
        field(50020; "Report ID for Job Queue FND"; Integer)
        {
            caption = 'Report ID for Job Queue';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = CONST(Report));
        }
        field(50021; "Report Name for Job Queue FND"; Text[249])
        {
            caption = 'Report Name for Job Queue';
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" where("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Report ID for Job Queue FND")));
            Description = 'HEI.10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; "Job Q. Run PreCloseDt Dec. FND"; DateFormula)
        {
            Caption = 'Job Queue Run Pre-Close Date Calculation December';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            // BC Upgrade PATHAA02 >>-Dependency on DIT
            // trigger OnValidate();
            // begin
            //     //HEI.10<<
            //     C2SRunningCalendar.RESET;
            //     C2SRunningCalendar.SETRANGE(Name, Text001);
            //     if C2SRunningCalendar.findset then
            //         repeat
            //             C2SRunningCalendar."Automatic Run Pre-Close Date" := CalendarMgt.CalcNextWorkingDate(Rec."Job Q. Run Pre-Close Date Dec.", C2SRunningCalendar."Ending Date", "C2S Base Calendar Code");
            //             C2SRunningCalendar.MODIFY;
            //         until C2SRunningCalendar.NEXT = 0;
            //     //HEI.10>>
            // end;
            // BC Upgrade PATHAA02 <<-Dependency on DIT
        }
        field(50023; "C2S Base Calendar Code FND"; Code[10])
        {
            CaptionML = ENU = 'C2S Base Calendar Code',
                        FRA = 'C2S Code calendrier principal';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
            TableRelation = "Base Calendar";
        }
        field(50031; "COGS JobQ Run PreCloseDt FND"; DateFormula)
        {
            Caption = 'COGS Job Queue Run Pre-Close Date Calculation';
            Description = 'HEI.11';
        }
        field(50032; "COGS JobQ Run Close Date FND"; DateFormula)
        {
            Caption = 'COGS Job Queue Run Close Date Calculation';
            Description = 'HEI.11';
        }
        field(50033; "SCOA Financial Statement FND"; Text[100])
        {
            Caption = 'SCOA Financial Statement Version';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
            Editable = false;
        }
        field(50034; "SCOA Financial State Opt. FND"; Option)
        {
            Caption = 'SCOA Financial Statement Version Options';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
            OptionCaption = '" ,Local,Heineken,Common"';
            OptionMembers = " ","Local",Heineken,Common;
        }
        field(50035; "C2S COGS Job Que Cat Code FND"; Code[20])
        {
            Caption = 'C2S / COGS Allocation Job Queue Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.13';
            TableRelation = "Job Queue Category";
        }
        field(50036; "StockInTransLogRetention FND"; DateFormula)
        {
            Caption = 'Stock In Transit - Log Retention';
            DataClassification = ToBeClassified;
            Description = 'HEI.16';
        }
        field(50037; "En Stock in Trans. Funct FND"; Boolean)
        {
            Caption = 'Enable Stock In Transit Functionality';
            DataClassification = ToBeClassified;
            Description = 'HEI.16';
        }
        field(50356; "Archive JQ Date Calc FND"; DateFormula)
        {
            Caption = 'Archive Job Queue Date Calculation';
            DataClassification = ToBeClassified;
            Description = 'HEI.14';
            // BC Upgrade PATHAA02 >>-Dependency on DIT
            // trigger OnValidate();
            // begin
            //     //HEI.14<<
            //     C2SRunningCalendar.RESET;
            //     if C2SRunningCalendar.findset(false) then
            //         repeat
            //             C2SRunningCalendar."Automatic Run Archive Date" := CalendarMgt.CalcNextWorkingDate(Rec."Archive JQ Date Calculation", C2SRunningCalendar."Ending Date", "C2S Base Calendar Code");
            //             C2SRunningCalendar.MODIFY;
            //         until C2SRunningCalendar.NEXT = 0;
            //     //HEI.14>>
            // end;
            // BC Upgrade PATHAA02 <<-Dependency on DIT        
        }
        field(50358; "Transfer Order Ship Date FND"; Text[30])
        {
            Caption = 'Transfer Order Shipping Date';
            DataClassification = ToBeClassified;
            Description = 'HEI.17';
        }
        field(50359; "Exclude Location Filter FND"; Text[30])
        {
            Caption = 'Exclude Location Filter for TO Deletion';
            DataClassification = ToBeClassified;
            Description = 'HEI.18';
        }

        //BC Upgrade PATHAA02 >>
        // field(2014066;"Copy Route Code";Boolean)
        // {
        //     CaptionML = ENU='Copy Route Code',
        //                 FRA='Copier Code Route';
        //     Description = 'DITW15.00.00.40 #1002';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.40 DDR 08/02/2012 #1002
        //         if not IsCopySourceValue() then
        //           "Create Whse. Header" := "Create Whse. Header"::Standard;
        //     end;
        // }
        // field(2014067;"Copy Route Planning Code";Boolean)
        // {
        //     Caption = 'Copy Route Planning Code';
        //     Description = 'NRQ#16082';

        //     trigger OnValidate();
        //     begin
        //         //<<DITW110.00.11 MSF 13/09/2017 NRQ#16082
        //         if "Copy Route Planning Code" then
        //         "Copy Route Code" := "Copy Route Planning Code" ;
        //         if not IsCopySourceValue() then
        //           "Create Whse. Header" := "Create Whse. Header"::Standard;
        //     end;
        // }
        // field(2014069;"Shortcut Unit of Measure1 Code";Code[10])
        // {
        //     CaptionML = ENU='Shortcut Qty per Unit of Measure 1 Code',
        //                 FRA='Code raccourci Quantité par unité 1';
        //     Description = 'DIT-715 #244';
        //     TableRelation = "Unit of Measure";
        // }
        // field(2014070;"Copy Shipment Method Code";Boolean)
        // {
        //     CaptionML = ENU='Copy Shipment Method Code',
        //                 FRA='Copie Code condition livraison';
        //     Description = 'DITW15.00.00.21';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW15.00.00.25 DDR 17/10/2008 - DITW15.00.00.34 DDR 10/06/2009
        //         if not IsCopySourceValue() then
        //           "Create Whse. Header" := "Create Whse. Header"::Standard;
        //     end;
        // }
        // field(2014071;"Copy Shipping Agent Code";Boolean)
        // {
        //     CaptionML = ENU='Copy Shipping Agent Code',
        //                 FRA='Copie Code transporteur';
        //     Description = 'DITW15.00.00.21';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW15.00.00.25 DDR 17/10/2008 - DITW15.00.00.34 DDR 10/06/2009
        //         if not IsCopySourceValue() then
        //           "Create Whse. Header" := "Create Whse. Header"::Standard;
        //     end;
        // }
        // field(2014072;"Copy Ship. Agent Service Code";Boolean)
        // {
        //     CaptionML = ENU='Copy Ship. Agent Service Code',
        //                 FRA='Copie Code prestation transporteur';
        //     Description = 'DITW15.00.00.21';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW15.00.00.25 DDR 17/10/2008 - DITW15.00.00.34 DDR 10/06/2009
        //         "Copy Distance" := "Copy Ship. Agent Service Code";
        //         if not IsCopySourceValue() then
        //           "Create Whse. Header" := "Create Whse. Header"::Standard;
        //     end;
        // }
        // field(2014073;"Copy Shipment Date";Boolean)
        // {
        //     CaptionML = ENU='Copy Shipment Date',
        //                 FRA='Copie Date de préparation';
        //     Description = 'DITW15.00.00.21';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW15.00.00.25 DDR 17/10/2008 - DITW15.00.00.34 DDR 10/06/2009
        //         if not IsCopySourceValue() then
        //           "Create Whse. Header" := "Create Whse. Header"::Standard;
        //     end;
        // }
        // field(2014074;"Copy Truck/Trailer Code";Boolean)
        // {
        //     CaptionML = ENU='Copy Truck/Trailer Code',
        //                 FRA='Copier code Camion/Chauffeur';
        //     Description = 'DITW15.00.00.25 - NRQ#16082';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW15.00.00.25 DDR 17/10/2008 - DITW15.00.00.34 DDR 10/06/2009
        //         if not IsCopySourceValue() then
        //           "Create Whse. Header" := "Create Whse. Header"::Standard;
        //     end;
        // }
        // field(2014075;"Copy Driver/Driver 2 Code";Boolean)
        // {
        //     Caption = 'Copy Driver/Driver 2 Code';
        //     Description = 'NRQ#16082';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW15.00.00.25 DDR 17/10/2008 - DITW15.00.00.34 DDR 10/06/2009
        //         if not IsCopySourceValue() then
        //           "Create Whse. Header" := "Create Whse. Header"::Standard;
        //     end;
        // }
        // field(2014088;"Create Whse. Header";Option)
        // {
        //     CaptionML = ENU='Create Warehouse Header',
        //                 FRA='Créer entête magasin';
        //     Description = 'DITW15.00.00.25-.34';
        //     OptionCaptionML = ENU='Standard,Per Source Document,Per Copied Values',
        //                       FRA='Standard,Par Document Source,Par valeurs copiées';
        //     OptionMembers = Standard,HeaderPerSource,HeaderPerValue;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.34 DDR 10/06/2009
        //         "Copy Shipment Method Code" := ("Create Whse. Header" <> "Create Whse. Header"::Standard);
        //         "Copy Shipping Agent Code" := ("Create Whse. Header" <> "Create Whse. Header"::Standard);
        //         "Copy Ship. Agent Service Code" := ("Create Whse. Header" <> "Create Whse. Header"::Standard);
        //         "Copy Shipment Date" := ("Create Whse. Header" <> "Create Whse. Header"::Standard);
        //         "Copy Truck/Trailer Code" := ("Create Whse. Header" <> "Create Whse. Header"::Standard);
        //         // <<DITW16.00.00.40 DDR 08/02/2012 #1002
        //         "Copy Route Code" := ("Create Whse. Header" <> "Create Whse. Header"::Standard);
        //         // >>DITW16.00.00.40 DDR #1002
        //         // <<DITW15.00.00.35 DDR 19/08/2009
        //         "Copy Distance" := ("Create Whse. Header" = "Create Whse. Header"::HeaderPerSource);
        //         // >>DITW15.00.00.35 DDR
        //         // >>DITW15.00.00.34 DDR
        //         /// DITW17.00.02 DIT-770 #95 - 28/08/2013 DIT-770 #178
        //         //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //         "Copy Route Planning Code" := ("Create Whse. Header" <> "Create Whse. Header"::Standard);
        //         "Copy Driver/Driver 2 Code" := ("Create Whse. Header" <> "Create Whse. Header"::Standard);
        //         //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //     end;
        // }
        // field(2014089;"Shortcut Unit of Measure2 Code";Code[10])
        // {
        //     CaptionML = ENU='Shortcut Qty per Unit of Measure 2 Code',
        //                 FRA='Code raccourci Quantité par unité 2';
        //     Description = 'DIT-715 #244';
        //     TableRelation = "Unit of Measure";
        // }
        // field(2014091;"Copy Distance";Boolean)
        // {
        //     CaptionML = ENU='Copy Distance',
        //                 FRA='Copier Distance';
        //     Description = 'DITW15.00.00.29';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW15.00.00.25 DDR 17/10/2008 - DITW15.00.00.34 DDR 10/06/2009
        //         if not IsCopySourceValue() then
        //           "Create Whse. Header" := "Create Whse. Header"::Standard;
        //     end;
        // }
        // field(2014093;"Shortcut Unit of Measure3 Code";Code[10])
        // {
        //     CaptionML = ENU='Shortcut Qty per Unit of Measure 3 Code',
        //                 FRA='Code raccourci Quantité par unité 3';
        //     Description = 'DIT-715 #244';
        //     TableRelation = "Unit of Measure";
        // }
        // field(2014095;"Whse. Doc. per Phys. Location";Boolean)
        // {
        //     CaptionML = ENU='Whse. Document per Physical Group Location',
        //                 FRA='E&xpédition magasin par groupe physique magasin';
        //     Description = 'DITW15.00.00.35';

        //     trigger OnValidate();
        //     var
        //         WhseEmployee : Record "Warehouse Employee";
        //     begin
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1314
        //         WhseEmployee.SETCURRENTKEY("Physical Location Group Code");
        //         if "Whse. Doc. per Phys. Location" then begin
        //           WhseEmployee.SETRANGE("Physical Location Group Code",'');
        //           if not WhseEmployee.ISEMPTY then
        //             MESSAGE(Text2014061,FIELDCAPTION("Whse. Doc. per Phys. Location"));
        //         end else begin
        //           WhseEmployee.SETFILTER("Physical Location Group Code",'<>%1','');
        //           if not WhseEmployee.ISEMPTY then
        //             ERROR(Text2014060,FIELDCAPTION("Whse. Doc. per Phys. Location"));
        //         end;
        //         // >>DITW15.00.00.39 DDR DIT-712 #1314
        //     end;
        // }
        // field(2014096;"Calc. Short. Qty per UOM1 Code";Option)
        // {
        //     Caption = 'Calc. Shortcut Qty per UOM1 Code';
        //     Description = 'DITW111.00.13A MSF 07/05/2019 NRQ#109275';
        //     OptionCaption = 'Item UOM Codes,Source Line UOM Code';
        //     OptionMembers = "Item UOM Codes","Source Line UOM Code";
        // }
        // field(2014097;"Calc. Short. Qty per UOM2 Code";Option)
        // {
        //     Caption = 'Calc. Shortcut Qty per UOM2 Code';
        //     Description = 'DITW111.00.13A MSF 07/05/2019 NRQ#109275';
        //     OptionCaption = 'Item UOM Codes,Source Line UOM Code';
        //     OptionMembers = "Item UOM Codes","Source Line UOM Code";
        // }
        // field(2014098;"Calc. Short. Qty per UOM3 Code";Option)
        // {
        //     Caption = 'Calc. Shortcut Qty per UOM3 Code';
        //     Description = 'DITW111.00.13A MSF 07/05/2019 NRQ#109275';
        //     OptionCaption = 'Item UOM Codes,Source Line UOM Code';
        //     OptionMembers = "Item UOM Codes","Source Line UOM Code";
        // }
        // field(2014414;"Show Item Track. Alert on Shpt";Boolean)
        // {
        //     Caption = 'Show Item Tracking Alert on Shipment';
        //     Description = 'NRQ#94671';
        // }
        // field(2014451;"Auto.Release Transfer on Whse.";Boolean)
        // {
        //     CaptionML = ENU='Automatic Release Transfer Order on Create Whse. document',
        //                 FRA='Lancer Ordre de transfer automatique avec document magasin';
        //     Description = 'DITW15.00.00.38 #1146';
        // }
        //BC Upgrade PATHAA02 <<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        C2SRunningCalendar: Record "C2S/COGS Running Calendar FND";
        CalendarMgt: Codeunit "Calendar Management";
        Text001: Label 'December';
        Text2014060: TextConst ENU = 'You cannot change the contents of the %1 field because there is at least one warehouse employee using a physical location.', FRA = 'Vous ne pouvez pas modifier le contenu du champ %1 car il existe au moins encore un magasinier utilisant ce magasin physique.';
        Text2014061: TextConst ENU = 'You have modified the %1 field. Note that you must update the existing warehouse employees manually.', FRA = 'Vous avez modifié le champ %1. Attention, vous devez mettre manuellement à jour les maganisiers existants.';
}

