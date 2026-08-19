tableextension 50112 WorkCenterExtFND extends "Work Center"
{
    //   MANXL7.00.001 DAT 05/03/2014 #16: Work-machine-center load - Added fields Planning, Bottleneck

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 DDR 29/09/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields
    //                                                        2014410 Scrap Code
    //                                                        2014411 Max Scrap %

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //     HEI.01 FDD- GAPID-001 NAIKH01 :
    //   # Added a new Fiels "Partial Output"
    // HEI.02 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 06.09.2017
    //   Added new fields
    // HEI.03 FDD-PRDGAP004 - Automatic Batch Number Generation , 10.09.2017 IBM.NAIKH01
    //   # Added new fields "Batch sequential number"
    // HEI.04 CHG2135085 SAHAL01      24.03.2022
    //   # Modified Fields Name from - Estimated Water Waste to Other Variable Expenses
    //                               - Estimated Maintenance to Production Fix Expenses
    //   # Added CaptionML in these Fields Estimated Energy and Estimated Water Consumption
    //   # Added Code and Updated DecimalPlaces
    // HEI.05 CHG2213896 PRASAA03 25/07/2023 calculation issue in work center page
    //   # Added CompareValues function in Direct unit cost field.

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Search Name")
        {
            CaptionML = ENU = 'Search Name', FRA = 'Nom de recherche';
        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify("Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
        }
        modify(City)
        {

            //Unsupported feature: Change TableRelation on "City(Field 8)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';
        }
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Alternate Work Center")
        {
            CaptionML = ENU = 'Alternate Work Center', FRA = 'Centre de remplacement';
        }
        modify("Work Center Group Code")
        {
            CaptionML = ENU = 'Work Center Group Code', FRA = 'Code groupe centres de charge';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Subcontractor No.")
        {
            CaptionML = ENU = 'Subcontractor No.', FRA = 'N° sous-traitant';
        }
        modify("Direct Unit Cost")
        {
            CaptionML = ENU = 'Direct Unit Cost', FRA = 'Coût unitaire direct';

            //Unsupported feature: Change DecimalPlaces on ""Direct Unit Cost"(Field 19)". Please convert manually.
            //---BC Upgrade KAMNAY01>>
            trigger OnAfterValidate()
            begin
                //HEI.05>>
                CompareValues();
                //HEI.05<<
            end;
            //---BC Upgrade KAMNAY01<<
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
            //---BC Upgrade KAMNAY01>>
            trigger OnAfterValidate()
            begin
                //HEI.05>>
                CompareValues();
                //HEI.05<<
            end;
            //---BC Upgrade KAMNAY01<<
        }
        modify("Queue Time")
        {
            CaptionML = ENU = 'Queue Time', FRA = 'File d''attente';
        }
        modify("Queue Time Unit of Meas. Code")
        {
            CaptionML = ENU = 'Queue Time Unit of Meas. Code', FRA = 'Unité file d''attente';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 27)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify(Capacity)
        {
            CaptionML = ENU = 'Capacity', FRA = 'Capacité';
        }
        modify(Efficiency)
        {
            CaptionML = ENU = 'Efficiency', FRA = 'Rendement';
        }
        modify("Maximum Efficiency")
        {
            CaptionML = ENU = 'Maximum Efficiency', FRA = 'Rendement maximum';
        }
        modify("Minimum Efficiency")
        {
            CaptionML = ENU = 'Minimum Efficiency', FRA = 'Rendement minimum';
        }
        modify("Calendar Rounding Precision")
        {
            CaptionML = ENU = 'Calendar Rounding Precision', FRA = 'Précision arrondi calendrier';
        }
        modify("Simulation Type")
        {
            CaptionML = ENU = 'Simulation Type', FRA = 'Mode de replanification';
            OptionCaptionML = ENU = 'Moves,Moves When Necessary,Critical', FRA = 'Déplacer,Déplacer si nécessaire,Critique';
        }
        modify("Shop Calendar Code")
        {
            CaptionML = ENU = 'Shop Calendar Code', FRA = 'Code calendrier usine';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Work Shift Filter")
        {
            CaptionML = ENU = 'Work Shift Filter', FRA = 'Filtre équipe';
        }
        modify("Capacity (Total)")
        {

            //Unsupported feature: Change CalcFormula on ""Capacity (Total)"(Field 41)". Please convert manually.

            CaptionML = ENU = 'Capacity (Total)', FRA = 'Capacité (totale)';
        }
        modify("Capacity (Effective)")
        {

            //Unsupported feature: Change CalcFormula on ""Capacity (Effective)"(Field 42)". Please convert manually.

            CaptionML = ENU = 'Capacity (Effective)', FRA = 'Capacité (réelle)';
        }
        modify("Prod. Order Need (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Prod. Order Need (Qty.)"(Field 44)". Please convert manually.

            CaptionML = ENU = 'Prod. Order Need (Qty.)', FRA = 'Charge O.F. (qté)';
        }
        modify("Prod. Order Need Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Prod. Order Need Amount"(Field 45)". Please convert manually.

            CaptionML = ENU = 'Prod. Order Need Amount', FRA = 'Charge O.F.';
        }
        modify("Prod. Order Status Filter")
        {
            CaptionML = ENU = 'Prod. Order Status Filter', FRA = 'Filtre statut O.F.';
           // OptionCaptionML = ENU = 'Simulated,Planned,Firm Planned,Released,Finished', FRA = 'Simulé,Planifié,Planifié ferme,Lancé,Terminé';
        }
        modify("Unit Cost Calculation")
        {
            CaptionML = ENU = 'Unit Cost Calculation', FRA = 'Unité de coût';
           // OptionCaptionML = ENU = 'Time,Units', FRA = 'Temps,Quantité';
        }
        modify("Specific Unit Cost")
        {
            CaptionML = ENU = 'Specific Unit Cost', FRA = 'Coût unitaire spécifique';
        }
        modify("Consolidated Calendar")
        {
            CaptionML = ENU = 'Consolidated Calendar', FRA = 'Calendrier consolidé';
        }
        modify("Flushing Method")
        {
            CaptionML = ENU = 'Flushing Method', FRA = 'Méthode consommation';
           // OptionCaptionML = ENU = 'Manual,Forward,Backward', FRA = 'Manuelle,Pré-déduction,Post-déduction';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 84)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 7300)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Open Shop Floor Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Open Shop Floor Bin Code"(Field 7301)". Please convert manually.

            CaptionML = ENU = 'Open Shop Floor Bin Code', FRA = 'Code empl. atelier ouvert';
        }
        modify("To-Production Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""To-Production Bin Code"(Field 7302)". Please convert manually.

            CaptionML = ENU = 'To-Production Bin Code', FRA = 'Code empl. des consommations';
        }
        modify("From-Production Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""From-Production Bin Code"(Field 7303)". Please convert manually.

            CaptionML = ENU = 'From-Production Bin Code', FRA = 'Code empl. après production';
        }

        //Unsupported feature: CodeModification on "City(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Work Center Group Code"(Field 14).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Work Center Group Code" = xRec."Work Center Group Code" THEN
          EXIT;

        CalendarEntry.SETCURRENTKEY("Work Center No.");
        CalendarEntry.SETRANGE("Work Center No.","No.");
        IF NOT CalendarEntry.FIND('-') THEN
          EXIT;

        IF CurrFieldNo <> 0 THEN
          IF NOT CONFIRM(Text001,FALSE,FIELDCAPTION("Work Center Group Code"))
          THEN BEGIN
            "Work Center Group Code" := xRec."Work Center Group Code";
            EXIT;
          end;

        Window.OPEN(
          Text002 +
          Text003 +
          Text004 +
          Text006);

        // Capacity Calendar
        EntryCounter := 0;
        NoOfRecords := CalendarEntry.COUNT;
        IF CalendarEntry.FIND('-') THEN
          REPEAT
            EntryCounter := EntryCounter + 1;
            Window.UPDATE(1,EntryCounter);
            Window.UPDATE(2,ROUND(EntryCounter / NoOfRecords * 10000,1));
            CalendarEntry."Work Center Group Code" := "Work Center Group Code";
            CalendarEntry.MODIFY;
          UNTIL CalendarEntry.NEXT = 0;

        // Capacity Absence
        EntryCounter := 0;
        CalAbsentEntry.SETCURRENTKEY("Work Center No.");
        CalAbsentEntry.SETRANGE("Work Center No.","No.");
        NoOfRecords := CalAbsentEntry.COUNT;
        IF CalAbsentEntry.FIND('-') THEN
          REPEAT
            EntryCounter := EntryCounter + 1;
            Window.UPDATE(3,EntryCounter);
            Window.UPDATE(4,ROUND(EntryCounter / NoOfRecords * 10000,1));
            CalAbsentEntry."Work Center Group Code" := "Work Center Group Code";
            CalAbsentEntry.MODIFY;
          UNTIL CalAbsentEntry.NEXT = 0;

        EntryCounter := 0;

        ProdOrderCapNeedEntry.SETCURRENTKEY("Work Center No.");
        ProdOrderCapNeedEntry.SETRANGE("Work Center No.","No.");
        NoOfRecords := ProdOrderCapNeedEntry.COUNT;
        IF ProdOrderCapNeedEntry.FIND('-') THEN
          REPEAT
            EntryCounter := EntryCounter + 1;
            Window.UPDATE(7,EntryCounter);
            Window.UPDATE(8,ROUND(EntryCounter / NoOfRecords * 10000,1));
            ProdOrderCapNeedEntry."Work Center Group Code" := "Work Center Group Code";
            ProdOrderCapNeedEntry.MODIFY;
          UNTIL ProdOrderCapNeedEntry.NEXT = 0;

        MODIFY;

        RtngLine.SETCURRENTKEY("Work Center No.");
        RtngLine.SETRANGE("Work Center No.","No.");
        RtngLine.MODIFYALL("Work Center Group Code","Work Center Group Code");

        PlanningRtngLine.SETCURRENTKEY("Work Center No.");
        PlanningRtngLine.SETRANGE("Work Center No.","No.");
        PlanningRtngLine.MODIFYALL("Work Center Group Code","Work Center Group Code");

        ProdOrderRtngLine.SETCURRENTKEY("Work Center No.");
        ProdOrderRtngLine.SETRANGE("Work Center No.","No.");
        ProdOrderRtngLine.MODIFYALL("Work Center Group Code","Work Center Group Code");

        Window.CLOSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Work Center Group Code" = xRec."Work Center Group Code" then
          exit;
        #3..5
        if not CalendarEntry.FIND('-') then
          exit;

        if CurrFieldNo <> 0 then
          if not CONFIRM(Text001,false,FIELDCAPTION("Work Center Group Code"))
          then begin
            "Work Center Group Code" := xRec."Work Center Group Code";
            exit;
          end;
        #15..24
        if CalendarEntry.FIND('-') then
          repeat
        #27..31
          until CalendarEntry.NEXT = 0;
        #33..38
        if CalAbsentEntry.FIND('-') then
          repeat
        #41..45
          until CalAbsentEntry.NEXT = 0;
        #47..52
        if ProdOrderCapNeedEntry.FIND('-') then
          repeat
        #55..59
          until ProdOrderCapNeedEntry.NEXT = 0;
        #61..76
        */
        //end;


        //Unsupported feature: CodeModification on ""Direct Unit Cost"(Field 19).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Indirect Cost %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Indirect Cost %");
        //HEI.05>>
        CompareValues;
        //HEI.05<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetGLSetup;
        "Direct Unit Cost" :=
          ROUND(("Unit Cost" - "Overhead Rate") / (1 + "Indirect Cost %" / 100),
            GLSetup."Unit-Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        //HEI.05>>
        CompareValues;
        //HEI.05<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unit of Measure Code" = xRec."Unit of Measure Code" THEN
          EXIT;

        CALCFIELDS("Prod. Order Need (Qty.)");
        IF "Prod. Order Need (Qty.)" <> 0 THEN
          ERROR(Text007,FIELDCAPTION("Unit of Measure Code"));

        IF xRec."Unit of Measure Code" <> '' THEN
          IF CurrFieldNo <> 0 THEN
            IF NOT CONFIRM(Text001,FALSE,FIELDCAPTION("Unit of Measure Code"))
            THEN BEGIN
              "Unit of Measure Code" := xRec."Unit of Measure Code";
              EXIT;
            end;

        Window.OPEN(
          Text008 +
          Text009);

        MODIFY;

        // Capacity Calendar
        EntryCounter := 0;
        CalendarEntry.SETCURRENTKEY("Work Center No.");
        CalendarEntry.SETRANGE("Work Center No.","No.");
        NoOfRecords := CalendarEntry.COUNT;
        IF CalendarEntry.FIND('-') THEN
          REPEAT
            EntryCounter := EntryCounter + 1;
            Window.UPDATE(1,EntryCounter);
            Window.UPDATE(2,ROUND(EntryCounter / NoOfRecords * 10000,1));
            CalendarEntry.VALIDATE("Ending Time");
            CalendarEntry.MODIFY;
          UNTIL CalendarEntry.NEXT = 0;

        Window.CLOSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Unit of Measure Code" = xRec."Unit of Measure Code" then
          exit;

        CALCFIELDS("Prod. Order Need (Qty.)");
        if "Prod. Order Need (Qty.)" <> 0 then
          ERROR(Text007,FIELDCAPTION("Unit of Measure Code"));

        if xRec."Unit of Measure Code" <> '' then
          if CurrFieldNo <> 0 then
            if not CONFIRM(Text001,false,FIELDCAPTION("Unit of Measure Code"))
            then begin
              "Unit of Measure Code" := xRec."Unit of Measure Code";
              exit;
            end;
        #15..26
        if CalendarEntry.FIND('-') then
          repeat
        #29..33
          until CalendarEntry.NEXT = 0;

        Window.CLOSE;
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 7300).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Location Code" <> xRec."Location Code" THEN BEGIN
          IF "Location Code" <> '' THEN BEGIN
            Location.GET("Location Code");
            WhseIntegrationMgt.CheckLocationCode(Location,DATABASE::"Work Center","No.");
          end;

          IF "Open Shop Floor Bin Code" <> '' THEN BEGIN
            IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
              VALIDATE("Open Shop Floor Bin Code",'')
            else
              TESTFIELD("Open Shop Floor Bin Code",'');
          end;
          IF "To-Production Bin Code" <> '' THEN BEGIN
            IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
              VALIDATE("To-Production Bin Code",'')
            else
              TESTFIELD("To-Production Bin Code",'');
          end;
          IF "From-Production Bin Code" <> '' THEN BEGIN
            IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
              VALIDATE("From-Production Bin Code",'')
            else
              TESTFIELD("From-Production Bin Code",'');
          end;
          MachineCenter.SETCURRENTKEY("Work Center No.");
          MachineCenter.SETRANGE("Work Center No.","No.");
          IF MachineCenter.findset(TRUE) THEN
            REPEAT
              MachineCenter."Location Code" := "Location Code";
              IF MachineCenter."Open Shop Floor Bin Code" <> '' THEN BEGIN
                IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
                  MachineCenter.VALIDATE("Open Shop Floor Bin Code",'')
                else
                  MachineCenter.TESTFIELD("Open Shop Floor Bin Code",'');
              end;
              IF MachineCenter."To-Production Bin Code" <> '' THEN BEGIN
                IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
                  MachineCenter.VALIDATE("To-Production Bin Code",'')
                else
                  MachineCenter.TESTFIELD("To-Production Bin Code",'');
              end;
              IF MachineCenter."From-Production Bin Code" <> '' THEN BEGIN
                IF ConfirmAutoRemovalOfBinCode(AutoUpdate) THEN
                  MachineCenter.VALIDATE("From-Production Bin Code",'')
                else
                  MachineCenter.TESTFIELD("From-Production Bin Code",'');
              end;
              MachineCenter.MODIFY(TRUE);
            UNTIL MachineCenter.NEXT = 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Location Code" <> xRec."Location Code" then begin
          if "Location Code" <> '' then begin
            Location.GET("Location Code");
            WhseIntegrationMgt.CheckLocationCode(Location,DATABASE::"Work Center","No.");
          end;

          if "Open Shop Floor Bin Code" <> '' then begin
            if ConfirmAutoRemovalOfBinCode(AutoUpdate) then
              VALIDATE("Open Shop Floor Bin Code",'')
            else
              TESTFIELD("Open Shop Floor Bin Code",'');
          end;
          if "To-Production Bin Code" <> '' then begin
            if ConfirmAutoRemovalOfBinCode(AutoUpdate) then
              VALIDATE("To-Production Bin Code",'')
            else
              TESTFIELD("To-Production Bin Code",'');
          end;
          if "From-Production Bin Code" <> '' then begin
            if ConfirmAutoRemovalOfBinCode(AutoUpdate) then
              VALIDATE("From-Production Bin Code",'')
            else
              TESTFIELD("From-Production Bin Code",'');
          end;
          MachineCenter.SETCURRENTKEY("Work Center No.");
          MachineCenter.SETRANGE("Work Center No.","No.");
          if MachineCenter.findset(true) then
            repeat
              MachineCenter."Location Code" := "Location Code";
              if MachineCenter."Open Shop Floor Bin Code" <> '' then begin
                if ConfirmAutoRemovalOfBinCode(AutoUpdate) then
                  MachineCenter.VALIDATE("Open Shop Floor Bin Code",'')
                else
                  MachineCenter.TESTFIELD("Open Shop Floor Bin Code",'');
              end;
              if MachineCenter."To-Production Bin Code" <> '' then begin
                if ConfirmAutoRemovalOfBinCode(AutoUpdate) then
                  MachineCenter.VALIDATE("To-Production Bin Code",'')
                else
                  MachineCenter.TESTFIELD("To-Production Bin Code",'');
              end;
              if MachineCenter."From-Production Bin Code" <> '' then begin
                if ConfirmAutoRemovalOfBinCode(AutoUpdate) then
                  MachineCenter.VALIDATE("From-Production Bin Code",'')
                else
                  MachineCenter.TESTFIELD("From-Production Bin Code",'');
              end;
              MachineCenter.MODIFY(true);
            until MachineCenter.NEXT = 0;
        end;
        */
        //end;
        field(50000; "Partial Output FND"; Boolean)
        {
            caption ='Partial Output';
            Description = 'FDD-GAPID 001';
        }
        field(50001; "Batch sequential number FND"; Code[10])
        {
            caption ='Batch sequential number';
            Description = 'PRDGAP004';
            TableRelation = "No. Series";
        }
        field(50002; "Estimated Energy FND"; Decimal)
        {
            Caption = 'Estimated Energy';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02,HEI.04';

            trigger OnValidate();
            begin
                //HEI.04>>
                CompareValues();
                //HEI.04<<
            end;
        }
        field(50003; "Estimated Water Consmp. FND"; Decimal)
        {
            Caption = 'Estimated Water Consumption';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02,HEI.04';

            trigger OnValidate();
            begin
                //HEI.04>>
                CompareValues();
                //HEI.04<<
            end;
        }
        field(50004; "Other Variable Expenses FND"; Decimal)
        {
            Caption = 'Other Variable Expenses';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02,HEI.04';

            trigger OnValidate();
            begin
                //HEI.04>>
                CompareValues();
                //HEI.04<<
            end;
        }
        field(50005; "Production Fix Expenses FND"; Decimal)
        {
            Caption = 'Production Fix Expenses';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02,HEI.04';

            trigger OnValidate();
            begin
                //HEI.04>>
                CompareValues();
                //HEI.04<<
            end;
        }
        //---BC Upgrade KAMNAY01>>
        // field(2014410; "Scrap Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Scrap Code',
        //                 FRA = 'Code rebut';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = Scrap;
        // }
        // field(2014411; "Max. Scrap %"; Decimal)
        // {
        //     CaptionML = ENU = 'Max Scrap %',
        //                 FRA = '% Rebut MAx';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW19.00.08 BL#10443';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2036301; Planning; Decimal)
        // {
        //     CaptionML = ENU = 'Planning Coëfficient',
        //                 FRA = 'Coéfficient plannification';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'MANXL7.00.001';
        // }
        // field(2036302; Bottleneck; Boolean)
        // {
        //     CaptionML = ENU = 'Bottleneck',
        //                 FRA = 'Goulot d''étranglement';
        //     Description = 'MANXL7.00.001';
        // }
        //---BC Upgrade KAMNAY01<<
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CapLedgEntry.SETRANGE("Work Center No.","No.");
    IF NOT CapLedgEntry.ISEMPTY THEN
      ERROR(Text010,TABLECAPTION,"No.",CapLedgEntry.TABLECAPTION);

    StdCostWksh.RESET;
    StdCostWksh.SETRANGE(Type,StdCostWksh.Type::"Work Center");
    StdCostWksh.SETRANGE("No.","No.");
    IF NOT StdCostWksh.ISEMPTY THEN
      ERROR(Text010,TABLECAPTION,"No.",StdCostWksh.TABLECAPTION);

    CalendarEntry.SETCURRENTKEY("Capacity Type","No.");
    #12..22
    MfgCommentLine.DELETEALL;

    ProdOrderRtngLine.SETRANGE("Work Center No.","No.");
    IF NOT ProdOrderRtngLine.ISEMPTY THEN
      ERROR(Text000);

    DimMgt.DeleteDefaultDim(DATABASE::"Work Center","No.");

    VALIDATE("Location Code",''); // to clean up the default bins
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CapLedgEntry.SETRANGE("Work Center No.","No.");
    if not CapLedgEntry.ISEMPTY then
    #3..7
    if not StdCostWksh.ISEMPTY then
    #9..25
    if not ProdOrderRtngLine.ISEMPTY then
    #27..31
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MfgSetup.GET;
    IF "No." = '' THEN BEGIN
      MfgSetup.TESTFIELD("Work Center Nos.");
      NoSeriesMgt.InitSeries(MfgSetup."Work Center Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;
    DimMgt.UpdateDefaultDim(
      DATABASE::"Work Center","No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    MfgSetup.GET;
    if "No." = '' then begin
      MfgSetup.TESTFIELD("Work Center Nos.");
      NoSeriesMgt.InitSeries(MfgSetup."Work Center Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;
    #6..8
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=The Work Center is being used on production orders.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=The Work Center is being used on production orders.;FRA=Ce centre de charge est utilisé dans des ordres de fabrication.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Do you want to change %1?;FRA=Souhaitez-vous modifier la valeur du champ %1?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Work Center Group Code is changed...\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Work Center Group Code is changed...\\;FRA=Modification du code centre de charge en cours... \\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Calendar Entry    #1###### @2@@@@@@@@@@@@@\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Calendar Entry    #1###### @2@@@@@@@@@@@@@\;FRA=Ecriture calendrier  #1###### @2@@@@@@@@@@@@@\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Calendar Absent.  #3###### @4@@@@@@@@@@@@@\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Calendar Absent.  #3###### @4@@@@@@@@@@@@@\;FRA=Indispo. calendrier  #3###### @4@@@@@@@@@@@@@\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=Prod. Order Need  #7###### @8@@@@@@@@@@@@@;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=Prod. Order Need  #7###### @8@@@@@@@@@@@@@;FRA=Besoin O.F.          #7###### @8@@@@@@@@@@@@@;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=%1 cannot be changed for scheduled work centers.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=%1 cannot be changed for scheduled work centers.;FRA=%1 ne peut être modifié(e) pour les centres de charge planifiés.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Capacity Unit of Time is corrected on\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=Capacity Unit of Time is corrected on\\;FRA=L'unité de capacité de temps est corrigée sur\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=Calendar Entry    #1###### @2@@@@@@@@@@@@@;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=Calendar Entry    #1###### @2@@@@@@@@@@@@@;FRA=Ecriture calendrier  #1###### @2@@@@@@@@@@@@@;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : @@@="%1 = Table caption; %2 = Field Value; %3 = Table Caption";ENU=You cannot delete %1 %2 because there is at least one %3 associated with it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : @@@="%1 = Table caption; %2 = Field Value; %3 = Table Caption";ENU=You cannot delete %1 %2 because there is at least one %3 associated with it.;FRA=Vous ne pouvez pas supprimer %1 %2 car il existe au moins un %3 qui lui est associé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1025)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=If you change the %1, then all bin codes on the %2 and related %3 will be removed. Are you sure that you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=If you change the %1, then all bin codes on the %2 and related %3 will be removed. Are you sure that you want to continue?;FRA=Si vous modifiez le %1, alors tous les codes emplacement sur le %2 et le %3 associé seront supprimés. Útes-vous sûr de vouloir continuer ?;
    //Variable type has not been exported.

    //---BC Upgrade KAMNAY01>>
    local procedure CompareValues()
    var
        DirectUnitCostL: Decimal;
        SumValueL: Decimal;
        Text000L: label 'Sum %1 of these values %2, %3, %4 and %5 should be same with %6 %7.';

    begin
        //HEI.04>>
        IF ("Estimated Energy FND" <> 0) AND ("Estimated Water Consmp. FND" <> 0) AND
          ("Other Variable Expenses FND" <> 0) AND ("Production Fix Expenses FND" <> 0) THEN BEGIN
            SumValueL := ROUND(("Estimated Energy FND" + "Estimated Water Consmp. FND" +
              "Other Variable Expenses FND" + "Production Fix Expenses FND"), 0.00001, '=');
            DirectUnitCostL := ROUND("Direct Unit Cost", 0.00001, '=');
            IF SumValueL <> DirectUnitCostL THEN
                ERROR(Text000L, SumValueL, FIELDCAPTION("Estimated Energy FND"), FIELDCAPTION("Estimated Water Consmp. FND"),
                  FIELDCAPTION("Other Variable Expenses FND"), FIELDCAPTION("Production Fix Expenses FND"),
                    FIELDCAPTION("Direct Unit Cost"), DirectUnitCostL);
        end;
        //HEI.04<<
    end;
    //---BC Upgrade KAMNAY01<<
}

