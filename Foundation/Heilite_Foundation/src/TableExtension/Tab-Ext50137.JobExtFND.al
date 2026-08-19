tableextension 50137 JobExtFND extends Job
{
    //   HEI.01 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    // # Increased "Bill-to Address" and "Bill-to Address 2" fields length from 50 to 60 characters
    // # Increased "Bill-to City" field length from 30 to 35 characters

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Search Description")
        {
            CaptionML = ENU = 'Search Description', FRA = 'Désignation de recherche';

        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Bill-to Customer No.', FRA = 'N° client facturé';
        }
        modify("Creation Date")
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Ending Date")
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            //OptionCaptionML = ENU = 'Planning,Quote,Open,Completed', FRA = 'Planning,Devis,Ouvert,Réalisé';
        }
        modify("Person Responsible")
        {
            CaptionML = ENU = 'Person Responsible', FRA = 'Responsable';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 21)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 22)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Job Posting Group")
        {
            CaptionML = ENU = 'Job Posting Group', FRA = 'Groupe compta. projet';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
            //OptionCaptionML = ENU = ' ,Posting,All', FRA = ' ,Validation,Tout';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 30)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Customer Disc. Group")
        {
            CaptionML = ENU = 'Customer Disc. Group', FRA = 'Groupe rem. client';
        }
        modify("Customer Price Group")
        {
            CaptionML = ENU = 'Customer Price Group', FRA = 'Groupe prix client';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Scheduled Res. Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""Scheduled Res. Qty."(Field 49)". Please convert manually.

            CaptionML = ENU = 'Scheduled Res. Qty.', FRA = 'Qté ress. planifiée';
        }
        modify("Resource Filter")
        {
            CaptionML = ENU = 'Resource Filter', FRA = 'Filtre ressource';
        }
        modify("Posting Date Filter")
        {
            CaptionML = ENU = 'Posting Date Filter', FRA = 'Filtre date comptabilisation';
        }
        modify("Resource Gr. Filter")
        {
            CaptionML = ENU = 'Resource Gr. Filter', FRA = 'Filtre gpe ressources';
        }
        modify("Scheduled Res. Gr. Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""Scheduled Res. Gr. Qty."(Field 56)". Please convert manually.

            CaptionML = ENU = 'Scheduled Res. Gr. Qty.', FRA = 'Qté gpe ressources planifiées';
        }
        //---BC Upgrade KAMNAY01<<--  Field is not present in BC
        // modify(Picture)
        // {
        //     CaptionML = ENU = 'Picture', FRA = 'illustration';
        // }
        //---BC Upgrade KAMNAY01>> Field is not present in BC
        modify("Bill-to Name")
        {
            CaptionML = ENU = 'Bill-to Name', FRA = 'Nom client facturé';
        }
        modify("Bill-to Address")
        {

            //Unsupported feature: Change Data type on ""Bill-to Address"(Field 59)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address', FRA = 'Adresse facturation';

            //Unsupported feature: Change Description on ""Bill-to Address"(Field 59)". Please convert manually.

        }
        modify("Bill-to Address 2")
        {

            //Unsupported feature: Change Data type on ""Bill-to Address 2"(Field 60)". Please convert manually.

            CaptionML = ENU = 'Bill-to Address 2', FRA = 'Adresse facturation 2';

            //Unsupported feature: Change Description on ""Bill-to Address 2"(Field 60)". Please convert manually.

        }
        modify("Bill-to City")
        {

            //Unsupported feature: Change Data type on ""Bill-to City"(Field 61)". Please convert manually.


            //Unsupported feature: Change TableRelation on ""Bill-to City"(Field 61)". Please convert manually.

            CaptionML = ENU = 'Bill-to City', FRA = 'Ville facturation';

            //Unsupported feature: Change Description on ""Bill-to City"(Field 61)". Please convert manually.

        }
        modify("Bill-to County")
        {
            CaptionML = ENU = 'Bill-to County', FRA = 'Région facturation';
        }
        modify("Bill-to Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Bill-to Post Code"(Field 64)". Please convert manually.

            CaptionML = ENU = 'Bill-to Post Code', FRA = 'Code postal facturation';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Bill-to Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Bill-to Country/Region Code"(Field 67)". Please convert manually.

            CaptionML = ENU = 'Bill-to Country/Region Code', FRA = 'Code pays/région facturation';
        }
        modify("Bill-to Name 2")
        {
            CaptionML = ENU = 'Bill-to Name 2', FRA = 'Nom client facturé 2';
        }
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
            // OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
        }
        modify(Image)
        {
            CaptionML = ENU = 'Image', FRA = 'Image';
        }
        modify("WIP Method")
        {

            //Unsupported feature: Change TableRelation on ""WIP Method"(Field 1000)". Please convert manually.

            CaptionML = ENU = 'WIP Method', FRA = 'Méthode TEC';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Bill-to Contact No.', FRA = 'N° contact facturation';
        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Bill-to Contact', FRA = 'Contact facturation';
        }
        modify("Planning Date Filter")
        {
            CaptionML = ENU = 'Planning Date Filter', FRA = 'Filtre date planning';
        }
        modify("Total WIP Cost Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Total WIP Cost Amount"(Field 1005)". Please convert manually.

            CaptionML = ENU = 'Total WIP Cost Amount', FRA = 'Montant coût TEC total';
        }
        modify("Total WIP Cost G/L Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Total WIP Cost G/L Amount"(Field 1006)". Please convert manually.

            CaptionML = ENU = 'Total WIP Cost G/L Amount', FRA = 'Montant compta. coût TEC total';
        }
        modify("WIP Entries Exist")
        {

            //Unsupported feature: Change CalcFormula on ""WIP Entries Exist"(Field 1007)". Please convert manually.

            CaptionML = ENU = 'WIP Entries Exist', FRA = 'Des écritures TEC existent';
        }
        modify("WIP Posting Date")
        {
            CaptionML = ENU = 'WIP Posting Date', FRA = 'Date comptabilisation TEC';
        }
        modify("WIP G/L Posting Date")
        {

            //Unsupported feature: Change CalcFormula on ""WIP G/L Posting Date"(Field 1009)". Please convert manually.

            CaptionML = ENU = 'WIP G/L Posting Date', FRA = 'Date comptabilisation compta. TEC';
        }
        modify("Invoice Currency Code")
        {
            CaptionML = ENU = 'Invoice Currency Code', FRA = 'Code devise facture';
        }
        modify("Exch. Calculation (Cost)")
        {
            CaptionML = ENU = 'Exch. Calculation (Cost)', FRA = 'Calcul change (coût)';
            OptionCaptionML = ENU = 'Fixed FCY,Fixed LCY', FRA = 'DE fixe,DS fixe';
        }
        modify("Exch. Calculation (Price)")
        {
            CaptionML = ENU = 'Exch. Calculation (Price)', FRA = 'Calcul change (prix)';
            OptionCaptionML = ENU = 'Fixed FCY,Fixed LCY', FRA = 'DE fixe,DS fixe';
        }
        modify("Allow Schedule/Contract Lines")
        {
            CaptionML = ENU = 'Allow Budget/Billable Lines', FRA = 'Autoriser lignes Budget/Facturable';
        }
        modify(Complete)
        {
            CaptionML = ENU = 'Complete', FRA = 'Totale';
        }
        modify("Recog. Sales Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Recog. Sales Amount"(Field 1017)". Please convert manually.

            CaptionML = ENU = 'Recog. Sales Amount', FRA = 'Montant vente récep.';
        }
        modify("Recog. Sales G/L Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Recog. Sales G/L Amount"(Field 1018)". Please convert manually.

            CaptionML = ENU = 'Recog. Sales G/L Amount', FRA = 'Montant compta. vente récep.';
        }
        modify("Recog. Costs Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Recog. Costs Amount"(Field 1019)". Please convert manually.

            CaptionML = ENU = 'Recog. Costs Amount', FRA = 'Montant coûts récep.';
        }
        modify("Recog. Costs G/L Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Recog. Costs G/L Amount"(Field 1020)". Please convert manually.

            CaptionML = ENU = 'Recog. Costs G/L Amount', FRA = 'Montant compta coûts récep.';
        }
        modify("Total WIP Sales Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Total WIP Sales Amount"(Field 1021)". Please convert manually.

            CaptionML = ENU = 'Total WIP Sales Amount', FRA = 'Montant vente TEC total';
        }
        modify("Total WIP Sales G/L Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Total WIP Sales G/L Amount"(Field 1022)". Please convert manually.

            CaptionML = ENU = 'Total WIP Sales G/L Amount', FRA = 'Montant compta. vente TEC total';
        }
        modify("WIP Completion Calculated")
        {

            //Unsupported feature: Change CalcFormula on ""WIP Completion Calculated"(Field 1023)". Please convert manually.

            CaptionML = ENU = 'WIP Completion Calculated', FRA = 'Avancement calc. TEC';
        }
        modify("Next Invoice Date")
        {

            //Unsupported feature: Change CalcFormula on ""Next Invoice Date"(Field 1024)". Please convert manually.

            CaptionML = ENU = 'Next Invoice Date', FRA = 'Proch. date facturation';
        }
        modify("Apply Usage Link")
        {
            CaptionML = ENU = 'Apply Usage Link', FRA = 'Appliquer le lien d''utilisation';
        }
        modify("WIP Warnings")
        {

            //Unsupported feature: Change CalcFormula on ""WIP Warnings"(Field 1026)". Please convert manually.

            CaptionML = ENU = 'WIP Warnings', FRA = 'Avertissements TEC';
        }
        modify("WIP Posting Method")
        {
            CaptionML = ENU = 'WIP Posting Method', FRA = 'Méthode de comptabilisation TEC';
            OptionCaptionML = ENU = 'Per Job,Per Job Ledger Entry', FRA = 'Par projet,Par écriture comptable projet';
        }
        modify("Applied Costs G/L Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Applied Costs G/L Amount"(Field 1028)". Please convert manually.

            CaptionML = ENU = 'Applied Costs G/L Amount', FRA = 'Montant compta. coûts appliqué';
        }
        modify("Applied Sales G/L Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Applied Sales G/L Amount"(Field 1029)". Please convert manually.

            CaptionML = ENU = 'Applied Sales G/L Amount', FRA = 'Montant compta. vente appliqué';
        }
        modify("Calc. Recog. Sales Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Calc. Recog. Sales Amount"(Field 1030)". Please convert manually.

            CaptionML = ENU = 'Calc. Recog. Sales Amount', FRA = 'Montant vente récep. calc.';
        }
        modify("Calc. Recog. Costs Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Calc. Recog. Costs Amount"(Field 1031)". Please convert manually.

            CaptionML = ENU = 'Calc. Recog. Costs Amount', FRA = 'Montant coûts récep. calc.';
        }
        modify("Calc. Recog. Sales G/L Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Calc. Recog. Sales G/L Amount"(Field 1032)". Please convert manually.

            CaptionML = ENU = 'Calc. Recog. Sales G/L Amount', FRA = 'Montant compta. vente récep. calc.';
        }
        modify("Calc. Recog. Costs G/L Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Calc. Recog. Costs G/L Amount"(Field 1033)". Please convert manually.

            CaptionML = ENU = 'Calc. Recog. Costs G/L Amount', FRA = 'Montant compta. coûts récep. calc.';
        }
        modify("WIP Completion Posted")
        {

            //Unsupported feature: Change CalcFormula on ""WIP Completion Posted"(Field 1034)". Please convert manually.

            CaptionML = ENU = 'WIP Completion Posted', FRA = 'Achèvement TEC validé';
        }
        modify("Over Budget")
        {
            CaptionML = ENU = 'Over Budget', FRA = 'Dépassement du budget';
        }
        modify("Project Manager")
        {
            CaptionML = ENU = 'Project Manager', FRA = 'Chef de projet';
        }

        //Unsupported feature: CodeModification on ""No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          JobsSetup.GET;
          NoSeriesMgt.TestManual(JobsSetup."Job Nos.");
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on "Description(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Search Description" = UPPERCASE(xRec.Description)) OR ("Search Description" = '') THEN
          "Search Description" := Description;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Search Description" = UPPERCASE(xRec.Description)) or ("Search Description" = '') then
          "Search Description" := Description;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Customer No."(Field 5).OnValidate". Please convert manually.

        //trigger "(Field 5)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Bill-to Customer No." = '') OR ("Bill-to Customer No." <> xRec."Bill-to Customer No.") THEN
          IF JobLedgEntryExist OR JobPlanningLineExist THEN
            ERROR(AssociatedEntriesExistErr,FIELDCAPTION("Bill-to Customer No."),TABLECAPTION);
        UpdateCust;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Bill-to Customer No." = '') or ("Bill-to Customer No." <> xRec."Bill-to Customer No.") then
          if JobLedgEntryExist or JobPlanningLineExist then
            ERROR(AssociatedEntriesExistErr,FIELDCAPTION("Bill-to Customer No."),TABLECAPTION);
        UpdateCust;
        */
        //end;


        //Unsupported feature: CodeModification on "Status(Field 19).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec.Status <> Status THEN BEGIN
          IF Status = Status::Completed THEN BEGIN
            VALIDATE(Complete,TRUE);
            GET("No.");
            Status := Status::Completed;
            Complete := TRUE;
            MODIFY;
          end;
          IF xRec.Status = xRec.Status::Completed THEN BEGIN
            IF DIALOG.CONFIRM(StatusChangeQst) THEN
              VALIDATE(Complete,FALSE)
            else
              Status := xRec.Status;
          end;
          JobPlanningLine.SETCURRENTKEY("Job No.");
          JobPlanningLine.SETRANGE("Job No.","No.");
          JobPlanningLine.MODIFYALL(Status,Status);

          MODIFY;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec.Status <> Status then begin
          if Status = Status::Completed then begin
            VALIDATE(Complete,true);
            GET("No.");
            Status := Status::Completed;
            Complete := true;
            MODIFY;
          end;
          if xRec.Status = xRec.Status::Completed then begin
            if DIALOG.CONFIRM(StatusChangeQst) then
              VALIDATE(Complete,false)
            else
              Status := xRec.Status;
          end;
        #15..19
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to City"(Field 61).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Post Code"(Field 64).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(
          "Bill-to City","Bill-to Post Code","Bill-to County","Bill-to Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""WIP Method"(Field 1000).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "WIP Posting Method" = "WIP Posting Method"::"Per Job Ledger Entry" THEN BEGIN
          JobWIPMethod.GET("WIP Method");
          IF NOT JobWIPMethod."WIP Cost" THEN
            ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Cost"));
          IF NOT JobWIPMethod."WIP Sales" THEN
            ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Sales"));
        end;

        JobTask.SETRANGE("Job No.","No.");
        JobTask.SETRANGE("WIP-Total",JobTask."WIP-Total"::Total);
        IF JobTask.FINDFIRST THEN
          IF CONFIRM(WIPMethodQst,TRUE,JobTask.FIELDCAPTION("WIP Method"),JobTask.TABLECAPTION,JobTask."WIP-Total") THEN
            JobTask.MODIFYALL("WIP Method","WIP Method",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "WIP Posting Method" = "WIP Posting Method"::"Per Job Ledger Entry" then begin
          JobWIPMethod.GET("WIP Method");
          if not JobWIPMethod."WIP Cost" then
            ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Cost"));
          if not JobWIPMethod."WIP Sales" then
            ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Sales"));
        end;
        #8..10
        if JobTask.FINDFIRST then
          if CONFIRM(WIPMethodQst,true,JobTask.FIELDCAPTION("WIP Method"),JobTask.TABLECAPTION,JobTask."WIP-Total") then
            JobTask.MODIFYALL("WIP Method","WIP Method",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Code"(Field 1001).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Currency Code" <> xRec."Currency Code" THEN
          IF NOT JobLedgEntryExist THEN BEGIN
            CurrencyUpdatePlanningLines;
            CurrencyUpdatePurchLines;
          end else
            ERROR(AssociatedEntriesExistErr,FIELDCAPTION("Currency Code"),TABLECAPTION);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Currency Code" <> xRec."Currency Code" then
          if not JobLedgEntryExist then begin
            CurrencyUpdatePlanningLines;
            CurrencyUpdatePurchLines;
          end else
            ERROR(AssociatedEntriesExistErr,FIELDCAPTION("Currency Code"),TABLECAPTION);
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Contact No."(Field 1002).OnLookup". Please convert manually.

        //trigger "(Field 1002)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Bill-to Customer No." <> '') AND Cont.GET("Bill-to Contact No.") THEN
          Cont.SETRANGE("Company No.",Cont."Company No.")
        else
          IF Cust.GET("Bill-to Customer No.") THEN BEGIN
            ContBusinessRelation.RESET;
            ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
            ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
            ContBusinessRelation.SETRANGE("No.","Bill-to Customer No.");
            IF ContBusinessRelation.FINDFIRST THEN
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.");
          end else
            Cont.SETFILTER("Company No.",'<>''''');

        IF "Bill-to Contact No." <> '' THEN
          IF Cont.GET("Bill-to Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          xRec := Rec;
          VALIDATE("Bill-to Contact No.",Cont."No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Bill-to Customer No." <> '') and Cont.GET("Bill-to Contact No.") then
          Cont.SETRANGE("Company No.",Cont."Company No.")
        else
          if Cust.GET("Bill-to Customer No.") then begin
        #5..8
            if ContBusinessRelation.FINDFIRST then
              Cont.SETRANGE("Company No.",ContBusinessRelation."Contact No.");
          end else
            Cont.SETFILTER("Company No.",'<>''''');

        if "Bill-to Contact No." <> '' then
          if Cont.GET("Bill-to Contact No.") then ;
        if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then begin
          xRec := Rec;
          VALIDATE("Bill-to Contact No.",Cont."No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bill-to Contact No."(Field 1002).OnValidate". Please convert manually.

        //trigger "(Field 1002)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Bill-to Contact No." <> xRec."Bill-to Contact No.") AND
           (xRec."Bill-to Contact No." <> '')
        THEN
          IF ("Bill-to Contact No." = '') AND ("Bill-to Customer No." = '') THEN BEGIN
            INIT;
            "No. Series" := xRec."No. Series";
            VALIDATE(Description,xRec.Description);
          end;

        IF ("Bill-to Customer No." <> '') AND ("Bill-to Contact No." <> '') THEN BEGIN
          Cont.GET("Bill-to Contact No.");
          ContBusinessRelation.RESET;
          ContBusinessRelation.SETCURRENTKEY("Link to Table","No.");
          ContBusinessRelation.SETRANGE("Link to Table",ContBusinessRelation."Link to Table"::Customer);
          ContBusinessRelation.SETRANGE("No.","Bill-to Customer No.");
          IF ContBusinessRelation.FINDFIRST THEN
            IF ContBusinessRelation."Contact No." <> Cont."Company No." THEN
              ERROR(ContactBusRelDiffCompErr,Cont."No.",Cont.Name,"Bill-to Customer No.");
        end;
        UpdateBillToCust("Bill-to Contact No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Bill-to Contact No." <> xRec."Bill-to Contact No.") and
           (xRec."Bill-to Contact No." <> '')
        then
          if ("Bill-to Contact No." = '') and ("Bill-to Customer No." = '') then begin
        #5..7
          end;

        if ("Bill-to Customer No." <> '') and ("Bill-to Contact No." <> '') then begin
        #11..15
          if ContBusinessRelation.FINDFIRST then
            if ContBusinessRelation."Contact No." <> Cont."Company No." then
              ERROR(ContactBusRelDiffCompErr,Cont."No.",Cont.Name,"Bill-to Customer No.");
        end;
        UpdateBillToCust("Bill-to Contact No.");
        */
        //end;


        //Unsupported feature: CodeModification on "Complete(Field 1015).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Complete <> xRec.Complete THEN
          ChangeJobCompletionStatus;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Complete <> xRec.Complete then
          ChangeJobCompletionStatus;
        */
        //end;


        //Unsupported feature: CodeModification on ""Apply Usage Link"(Field 1025).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Apply Usage Link" THEN BEGIN
          JobLedgerEntry.SETCURRENTKEY("Job No.");
          JobLedgerEntry.SETRANGE("Job No.","No.");
          JobLedgerEntry.SETRANGE("Entry Type",JobLedgerEntry."Entry Type"::Usage);
          IF JobLedgerEntry.FINDFIRST THEN BEGIN
            JobUsageLink.SETRANGE("Entry No.",JobLedgerEntry."Entry No.");
            IF JobUsageLink.ISEMPTY THEN
              ERROR(ApplyUsageLinkErr,TABLECAPTION);
          end;

          JobPlanningLine.SETCURRENTKEY("Job No.");
          JobPlanningLine.SETRANGE("Job No.","No.");
          JobPlanningLine.SETRANGE("Schedule Line",TRUE);
          IF JobPlanningLine.findset THEN
            REPEAT
              JobPlanningLine.VALIDATE("Usage Link",TRUE);
              IF JobPlanningLine."Planning Date" = 0D THEN
                JobPlanningLine.VALIDATE("Planning Date",WORKDATE);
              JobPlanningLine.MODIFY(TRUE);
            UNTIL JobPlanningLine.NEXT = 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Apply Usage Link" then begin
        #2..4
          if JobLedgerEntry.FINDFIRST then begin
            JobUsageLink.SETRANGE("Entry No.",JobLedgerEntry."Entry No.");
            if JobUsageLink.ISEMPTY then
              ERROR(ApplyUsageLinkErr,TABLECAPTION);
          end;
        #10..12
          JobPlanningLine.SETRANGE("Schedule Line",true);
          if JobPlanningLine.findset then
            repeat
              JobPlanningLine.VALIDATE("Usage Link",true);
              if JobPlanningLine."Planning Date" = 0D then
                JobPlanningLine.VALIDATE("Planning Date",WORKDATE);
              JobPlanningLine.MODIFY(true);
            until JobPlanningLine.NEXT = 0;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""WIP Posting Method"(Field 1027).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."WIP Posting Method" = "WIP Posting Method"::"Per Job Ledger Entry" THEN BEGIN
          JobLedgerEntry.SETRANGE("Job No.","No.");
          JobLedgerEntry.SETFILTER("Amt. Posted to G/L",'<>%1',0);
          IF NOT JobLedgerEntry.ISEMPTY THEN
            ERROR(WIPAlreadyPostedErr,FIELDCAPTION("WIP Posting Method"),xRec."WIP Posting Method");
        end;

        JobWIPEntry.SETRANGE("Job No.","No.");
        IF NOT JobWIPEntry.ISEMPTY THEN
          ERROR(WIPAlreadyAssociatedErr,FIELDCAPTION("WIP Posting Method"));

        IF "WIP Posting Method" = "WIP Posting Method"::"Per Job Ledger Entry" THEN BEGIN
          JobWIPMethod.GET("WIP Method");
          IF NOT JobWIPMethod."WIP Cost" THEN
            ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Cost"));
          IF NOT JobWIPMethod."WIP Sales" THEN
            ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Sales"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."WIP Posting Method" = "WIP Posting Method"::"Per Job Ledger Entry" then begin
          JobLedgerEntry.SETRANGE("Job No.","No.");
          JobLedgerEntry.SETFILTER("Amt. Posted to G/L",'<>%1',0);
          if not JobLedgerEntry.ISEMPTY then
            ERROR(WIPAlreadyPostedErr,FIELDCAPTION("WIP Posting Method"),xRec."WIP Posting Method");
        end;

        JobWIPEntry.SETRANGE("Job No.","No.");
        if not JobWIPEntry.ISEMPTY then
          ERROR(WIPAlreadyAssociatedErr,FIELDCAPTION("WIP Posting Method"));

        if "WIP Posting Method" = "WIP Posting Method"::"Per Job Ledger Entry" then begin
          JobWIPMethod.GET("WIP Method");
          if not JobWIPMethod."WIP Cost" then
            ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Cost"));
          if not JobWIPMethod."WIP Sales" then
            ERROR(WIPPostMethodErr,FIELDCAPTION("WIP Posting Method"),FIELDCAPTION("WIP Method"),JobWIPMethod.FIELDCAPTION("WIP Sales"));
        end;
        */
        //end;
        //---BC Upgrade KAMNAY01>> No tag found in Heilite
        field(50000; "Test OMA 1 FND"; Code[10])
        {
            caption = 'Test OMA 1';
        }
        field(50001; "Test OMA 2 FND"; Code[10])
        {
            caption = 'Test OMA 2';
        }
        //---BC Upgrade KAMNAY01<< No tag found in Heilite
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MoveEntries.MoveJobEntries(Rec);

    JobTask.SETCURRENTKEY("Job No.");
    JobTask.SETRANGE("Job No.","No.");
    JobTask.DELETEALL(TRUE);

    JobResPrice.SETRANGE("Job No.","No.");
    JobResPrice.DELETEALL;
    #9..18

    DimMgt.DeleteDefaultDim(DATABASE::Job,"No.");

    IF "Project Manager" <> '' THEN
      RemoveFromMyJobs;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    JobTask.DELETEALL(true);
    #6..21
    if "Project Manager" <> '' then
      RemoveFromMyJobs;
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JobsSetup.GET;

    IF "No." = '' THEN BEGIN
      JobsSetup.TESTFIELD("Job Nos.");
      NoSeriesMgt.InitSeries(JobsSetup."Job Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    IF GETFILTER("Bill-to Customer No.") <> '' THEN
      IF GETRANGEMIN("Bill-to Customer No.") = GETRANGEMAX("Bill-to Customer No.") THEN
        VALIDATE("Bill-to Customer No.",GETRANGEMIN("Bill-to Customer No."));

    IF NOT "Apply Usage Link" THEN
      VALIDATE("Apply Usage Link",JobsSetup."Apply Usage Link by Default");
    IF NOT "Allow Schedule/Contract Lines" THEN
      VALIDATE("Allow Schedule/Contract Lines",JobsSetup."Allow Sched/Contract Lines Def");
    IF "WIP Method" = '' THEN
      VALIDATE("WIP Method",JobsSetup."Default WIP Method");
    IF "Job Posting Group" = '' THEN
      VALIDATE("Job Posting Group",JobsSetup."Default Job Posting Group");
    VALIDATE("WIP Posting Method",JobsSetup."Default WIP Posting Method");

    DimMgt.UpdateDefaultDim(
      DATABASE::Job,"No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    InitWIPFields;

    "Creation Date" := TODAY;
    "Last Date Modified" := "Creation Date";

    IF ("Project Manager" <> '') AND (Status = Status::Open) THEN
      AddToMyJobs("Project Manager");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    JobsSetup.GET;

    if "No." = '' then begin
      JobsSetup.TESTFIELD("Job Nos.");
      NoSeriesMgt.InitSeries(JobsSetup."Job Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    if GETFILTER("Bill-to Customer No.") <> '' then
      if GETRANGEMIN("Bill-to Customer No.") = GETRANGEMAX("Bill-to Customer No.") then
        VALIDATE("Bill-to Customer No.",GETRANGEMIN("Bill-to Customer No."));

    if not "Apply Usage Link" then
      VALIDATE("Apply Usage Link",JobsSetup."Apply Usage Link by Default");
    if not "Allow Schedule/Contract Lines" then
      VALIDATE("Allow Schedule/Contract Lines",JobsSetup."Allow Sched/Contract Lines Def");
    if "WIP Method" = '' then
      VALIDATE("WIP Method",JobsSetup."Default WIP Method");
    if "Job Posting Group" = '' then
    #19..29
    if ("Project Manager" <> '') and (Status = Status::Open) then
      AddToMyJobs("Project Manager");
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF (("Project Manager" = '') AND (xRec."Project Manager" <> '')) OR (Status <> Status::Open) THEN
      RemoveFromMyJobs;

    IF ("Project Manager" <> '') AND (xRec."Project Manager" <> "Project Manager") THEN
      IF Status = Status::Open THEN
        AddToMyJobs("Project Manager");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    if (("Project Manager" = '') and (xRec."Project Manager" <> '')) or (Status <> Status::Open) then
      RemoveFromMyJobs;

    if ("Project Manager" <> '') and (xRec."Project Manager" <> "Project Manager") then
      if Status = Status::Open then
        AddToMyJobs("Project Manager");
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "AssociatedEntriesExistErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AssociatedEntriesExistErr : @@@="%1 = Name of field used in the error; %2 = The name of the Job table";ENU=You cannot change %1 because one or more entries are associated with this %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AssociatedEntriesExistErr : @@@="%1 = Name of field used in the error; %2 = The name of the Job table";ENU=You cannot change %1 because one or more entries are associated with this %2.;FRA=Vous ne pouvez pas modifier %1 car une ou plusieurs écritures sont associées à cet élément %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "StatusChangeQst(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //StatusChangeQst : ENU=This will delete any unposted WIP entries for this job and allow you to reverse the completion postings for this job.\\Do you wish to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //StatusChangeQst : ENU=This will delete any unposted WIP entries for this job and allow you to reverse the completion postings for this job.\\Do you wish to continue?;FRA=Les écritures TEC non validées pour ce projet seront supprimées et vous pourrez annuler ses validations d'achèvement.\\Souhaitez-vous continuer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ContactBusRelDiffCompErr(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ContactBusRelDiffCompErr : @@@="%1 = The contact number; %2 = The contact's name; %3 = The Bill-To Customer Number associated with this job";ENU=Contact %1 %2 is related to a different company than customer %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ContactBusRelDiffCompErr : @@@="%1 = The contact number; %2 = The contact's name; %3 = The Bill-To Customer Number associated with this job";ENU=Contact %1 %2 is related to a different company than customer %3.;FRA=Le contact %1 %2 est associé à une société différente de celle du client %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ContactBusRelErr(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ContactBusRelErr : @@@="%1 = The contact number; %2 = The contact's name; %3 = The Bill-To Customer Number associated with this job";ENU=Contact %1 %2 is not related to customer %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ContactBusRelErr : @@@="%1 = The contact number; %2 = The contact's name; %3 = The Bill-To Customer Number associated with this job";ENU=Contact %1 %2 is not related to customer %3.;FRA=Le contact %1 %2 n'est pas associé au client %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ContactBusRelMissingErr(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ContactBusRelMissingErr : @@@="%1 = The contact number; %2 = The contact's name";ENU=Contact %1 %2 is not related to a customer.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ContactBusRelMissingErr : @@@="%1 = The contact number; %2 = The contact's name";ENU=Contact %1 %2 is not related to a customer.;FRA=Le contact %1 %2 n'est associé à aucun client.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TestBlockedErr(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TestBlockedErr : @@@="%1 = The Job table name; %2 = The Job number; %3 = The value of the Blocked field";ENU=%1 %2 must not be blocked with type %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TestBlockedErr : @@@="%1 = The Job table name; %2 = The Job number; %3 = The value of the Blocked field";ENU=%1 %2 must not be blocked with type %3.;FRA=Le %1 %2 ne doit pas être bloqué avec le type %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ReverseCompletionEntriesMsg(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReverseCompletionEntriesMsg : @@@="%1 = The name of the Job Post WIP to G/L report";ENU=You must run the %1 function to reverse the completion entries that have already been posted for this job.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReverseCompletionEntriesMsg : @@@="%1 = The name of the Job Post WIP to G/L report";ENU=You must run the %1 function to reverse the completion entries that have already been posted for this job.;FRA=Vous devez exécuter la fonction %1 pour annuler les écritures d'achèvement déjà validées pour ce projet.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnlineMapMsg(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnlineMapMsg : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnlineMapMsg : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;FRA=Avant de pouvoir utiliser Online Map, vous devez compléter la fenêtre Configuration Online Map.\Consultez la section Configuration d'Online Map dans l'Aide.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CheckDateErr(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CheckDateErr : @@@="%1 = The job's starting date; %2 = The job's ending date";ENU=%1 must be equal to or earlier than %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CheckDateErr : @@@="%1 = The job's starting date; %2 = The job's ending date";ENU=%1 must be equal to or earlier than %2.;FRA=La date de %1 doit être identique ou antérieure à %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BlockedCustErr(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BlockedCustErr : @@@="%1 = The Bill-to Customer No. field name; %2 = The job's Bill-to Customer No. value; %3 = The Customer table name; %4 = The Blocked field name; %5 = The job's customer's Blocked value";ENU=You cannot set %1 to %2, as this %3 has set %4 to %5.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BlockedCustErr : @@@="%1 = The Bill-to Customer No. field name; %2 = The job's Bill-to Customer No. value; %3 = The Customer table name; %4 = The Blocked field name; %5 = The job's customer's Blocked value";ENU=You cannot set %1 to %2, as this %3 has set %4 to %5.;FRA=Impossible de définir %1 sur %2 car ce %3 a défini %4 sur %5.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ApplyUsageLinkErr(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ApplyUsageLinkErr : @@@="%1 = The name of the Job table";ENU=A usage link cannot be enabled for the entire %1 because usage without the usage link already has been posted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ApplyUsageLinkErr : @@@="%1 = The name of the Job table";ENU=A usage link cannot be enabled for the entire %1 because usage without the usage link already has been posted.;FRA=Un lien d'utilisation ne peut pas être activé pour l'intégralité de %1 car une utilisation sans lien d'utilisation a déjà été validée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "WIPMethodQst(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //WIPMethodQst : @@@="%1 = The WIP Method field name; %2 = The name of the Job Task table; %3 = The current job task's WIP Total type";ENU=Do you want to set the %1 on every %2 of type %3?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WIPMethodQst : @@@="%1 = The WIP Method field name; %2 = The name of the Job Task table; %3 = The current job task's WIP Total type";ENU=Do you want to set the %1 on every %2 of type %3?;FRA=Souhaitez-vous définir le %1 sur chaque %2 de type %3 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "WIPAlreadyPostedErr(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //WIPAlreadyPostedErr : @@@="%1 = The name of the WIP Posting Method field; %2 = The previous WIP Posting Method value of this job";ENU=%1 must be %2 because job WIP general ledger entries already were posted with this setting.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WIPAlreadyPostedErr : @@@="%1 = The name of the WIP Posting Method field; %2 = The previous WIP Posting Method value of this job";ENU=%1 must be %2 because job WIP general ledger entries already were posted with this setting.;FRA=%1 doit être %2 car les écritures comptables TEC projet ont déjà été validées avec cette configuration.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "WIPAlreadyAssociatedErr(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //WIPAlreadyAssociatedErr : @@@="%1 = The name of the WIP Posting Method field";ENU=%1 cannot be modified because the job has associated job WIP entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WIPAlreadyAssociatedErr : @@@="%1 = The name of the WIP Posting Method field";ENU=%1 cannot be modified because the job has associated job WIP entries.;FRA=%1 ne peut pas être modifié car le projet est lié à des écritures TEC projet.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "WIPPostMethodErr(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //WIPPostMethodErr : @@@="%1 = The name of the WIP Posting Method field; %2 = The name of the WIP Method field; %3 = The field caption represented by the value of this job's WIP method";ENU=The selected %1 requires the %2 to have %3 enabled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WIPPostMethodErr : @@@="%1 = The name of the WIP Posting Method field; %2 = The name of the WIP Method field; %3 = The field caption represented by the value of this job's WIP method";ENU=The selected %1 requires the %2 to have %3 enabled.;FRA=Le %1 sélectionné nécessite que le %3 de %2 soit activé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "EndingDateChangedMsg(Variable 1025)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //EndingDateChangedMsg : @@@="%1 = The name of the Ending Date field; %2 = This job's Ending Date value";ENU=%1 is set to %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //EndingDateChangedMsg : @@@="%1 = The name of the Ending Date field; %2 = This job's Ending Date value";ENU=%1 is set to %2.;FRA=L'%1 est paramétrée sur %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UpdateJobTaskDimQst(Variable 1026)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UpdateJobTaskDimQst : ENU=You have changed a dimension.\\Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdateJobTaskDimQst : ENU=You have changed a dimension.\\Do you want to update the lines?;FRA=Vous avez modifié un axe analytique.\\Voulez-vous mettre à jour les lignes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DocTxt(Variable 1027)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DocTxt : ENU=Job Quote;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocTxt : ENU=Job Quote;FRA=Devis projet;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RunWIPFunctionsQst(Variable 1028)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RunWIPFunctionsQst : @@@="%1 = The name of the Job Calculate WIP report";ENU=You must run the %1 function to create completion entries for this job. \Do you want to run this function now?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RunWIPFunctionsQst : @@@="%1 = The name of the Job Calculate WIP report";ENU=You must run the %1 function to create completion entries for this job. \Do you want to run this function now?;FRA=Vous devez exécuter la fonction %1 pour créer les écritures d'achèvement pour ce projet. \Souhaitez-vous exécuter cette fonction maintenant ?;
    //Variable type has not been exported.
}

