tableextension 50069 JobQueueEntryExtFND extends "Job Queue Entry"
{
    // version NAVW110.0,HEI.08
    // HEI.02 CHG2010375 IBM.LS 23.01.2020
    //   # New Field created: 50004 - "Send Document"
    //   # New Field created: 50005 - "Document Type"
    //   # New Field created: 50006 - "Document No."
    //   # New Field created: 50007 - "JQ Posted"
    //   # New Field created: 50008 - "JQ Mail Sent"
    //   # New Field created: 50009 - "JQ Printed"
    //   # New Field created: 50010 - "Posted Document No."
    //   # Code added
    // HEI.03 CHG2010375 IBM.LS 12.02.2020
    //   # New Field created: 50011 - "JQ Logistics Mail Sent"
    //   # Code added
    // HEI.04 CHG2106712 SAMANR01 19.04.2020
    //   # New field created: 50012 - "Notify Email ID"
    // HEI.05 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    //   # New field: 50013 Delete Log Entry on Success
    // HEI.06 CHG2188870 DEBUSD01 06.02.2023 Sales Order API Performance change flow
    //   # Remove field: 50013 Delete Log Entry on Success
    // HEI.07 CHG2202438 SAMANR01 26.04.2023 NAS Task scheduler is not stop session after the Reset of the job
    //   # Add code for kill the SQL session if in progress job put on-hold
    // HEI.08 CHG2202438 SAMANR01 05.05.2023 NAS Task scheduler is not stop session after the Reset of the job
    //         # Add code for kill the SQL session if in progress job put on-hold with powershell runner
    // HEI.09 IBM COSTES04 17.01.2025 CHG2279679-HB4118-Automatic restart of deadlock errors for auto billing
    //   # New fields added:  No. of Attempts to Reset
    // BC Upgrade NANDIS03 - Function InsertLogEntry is not available here, subscribed the event of table 472 and HEI.02 can be found in CU 60000
    // BC Upgrade PATELP08 >>
    // changes datatype of field 50005"Document Type" from option to Enum "Sales Document Type".
    // blocking OptionCaptionMl property in modify("Report Output Type") as it can only be used in option datatype and this is Enum.
    // Blocking procedure "FinalizeLogEntry" as Table 'Job Queue Entry' already defines a method called 'FinalizeLogEntry' with the same parameter types in 'Base Application by Microsoft so this is duplicate.
    // BC Upgrade PATELP08 <<
    fields
    {
        modify(ID)
        {
            CaptionML = ENU = 'ID', FRA = 'ID';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify(XML)
        {
            CaptionML = ENU = 'XML', FRA = 'XML';
        }
        modify("Last Ready State")
        {
            CaptionML = ENU = 'Last Ready State', FRA = 'Dernier état prêt';
        }
        modify("Expiration Date/Time")
        {
            CaptionML = ENU = 'Expiration Date/Time', FRA = 'Date/heure expiration';
        }
        modify("Earliest Start Date/Time")
        {
            CaptionML = ENU = 'Earliest Start Date/Time', FRA = 'Date/heure début au plus tôt';
        }
        modify("Object Type to Run")
        {
            CaptionML = ENU = 'Object Type to Run', FRA = 'Type objet à exécuter';
            OptionCaptionML = ENU = ',,,Report,,Codeunit', FRA = ',,,Report,,Codeunit';
        }
        modify("Object ID to Run")
        {

            //Unsupported feature: Change TableRelation on ""Object ID to Run"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Object ID to Run', FRA = 'ID objet à exécuter';
        }
        modify("Object Caption to Run")
        {

            //Unsupported feature: Change CalcFormula on ""Object Caption to Run"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Object Caption to Run', FRA = 'Légende de l''objet à exécuter';
        }
        modify("Report Output Type")
        {
            CaptionML = ENU = 'Report Output Type', FRA = 'Type sortie état';
            // BC Upgrade PATELP08 >> blocking OptionCaptionMl property as it can only be used in option datatype and this is Enum.
            //OptionCaptionML = ENU = 'PDF,Word,Excel,Print,None (Processing only)', FRA = 'PDF,Word,Excel,Impression,Aucun (Traitement uniquement)';
            // BC Upgrade PATELP08 <<
        }
        modify("Maximum No. of Attempts to Run")
        {
            CaptionML = ENU = 'Maximum No. of Attempts to Run', FRA = 'Nbre max. tentatives d''exécution';
        }
        modify("No. of Attempts to Run")
        {
            CaptionML = ENU = 'No. of Attempts to Run', FRA = 'Nbre max. de tentatives d''exécution';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            OptionCaptionML = ENU = 'Ready,In Process,Error,On Hold,Finished', FRA = 'Prêt,En cours,Erreur,En attente,Terminé';
        }
        // modify(Priority)
        // {
        //     CaptionML = ENU = 'Priority', FRA = 'Priorité';
        // }  // BC Upgrade NANDIS03
        modify("Record ID to Process")
        {
            CaptionML = ENU = 'Record ID to Process', FRA = 'ID d''enregistrement à traiter';
        }
        modify("Parameter String")
        {
            CaptionML = ENU = 'Parameter String', FRA = 'Chaîne de paramètre';
        }
        modify("Recurring Job")
        {
            CaptionML = ENU = 'Recurring Job', FRA = 'Projet récurrent';
        }
        modify("No. of Minutes between Runs")
        {
            CaptionML = ENU = 'No. of Minutes between Runs', FRA = 'Nbre minutes entre les exécutions';
        }
        modify("Run on Mondays")
        {
            CaptionML = ENU = 'Run on Mondays', FRA = 'Exécuter le lundi';
        }
        modify("Run on Tuesdays")
        {
            CaptionML = ENU = 'Run on Tuesdays', FRA = 'Exécuter le mardi';
        }
        modify("Run on Wednesdays")
        {
            CaptionML = ENU = 'Run on Wednesdays', FRA = 'Exécuter le mercredi';
        }
        modify("Run on Thursdays")
        {
            CaptionML = ENU = 'Run on Thursdays', FRA = 'Exécuter le jeudi';
        }
        modify("Run on Fridays")
        {
            CaptionML = ENU = 'Run on Fridays', FRA = 'Exécuter le vendredi';
        }
        modify("Run on Saturdays")
        {
            CaptionML = ENU = 'Run on Saturdays', FRA = 'Exécuter le samedi';
        }
        modify("Run on Sundays")
        {
            CaptionML = ENU = 'Run on Sundays', FRA = 'Exécuter le dimanche';
        }
        modify("Starting Time")
        {
            CaptionML = ENU = 'Starting Time', FRA = 'Heure début';
        }
        modify("Ending Time")
        {
            CaptionML = ENU = 'Ending Time', FRA = 'Heure fin';
        }
        modify("Reference Starting Time")
        {
            CaptionML = ENU = 'Reference Starting Time', FRA = 'Heure de début de référence';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify("Run in User Session")
        {
            CaptionML = ENU = 'Run in User Session', FRA = 'Exécuter dans la session utilisateur';
        }
        modify("User Session ID")
        {
            CaptionML = ENU = 'User Session ID', FRA = 'ID session utilisateur';
        }
        modify("Job Queue Category Code")
        {
            CaptionML = ENU = 'Job Queue Category Code', FRA = 'Code catégorie de la file d''attente des travaux';
        }
        modify("Error Message")
        {
            CaptionML = ENU = 'Error Message', FRA = 'Message d''erreur';
        }
        // modify("Error Message 2")
        // {
        //     CaptionML = ENU = 'Error Message 2', FRA = 'Message d''erreur 2';
        // }
        // modify("Error Message 3")
        // {
        //     CaptionML = ENU = 'Error Message 3', FRA = 'Message d''erreur 3';
        // }
        // modify("Error Message 4")
        // {
        //     CaptionML = ENU = 'Error Message 4', FRA = 'Message d''erreur 4';
        // }  // BC Upgrade NANDIS03
        modify("User Service Instance ID")
        {
            CaptionML = ENU = 'User Service Instance ID', FRA = 'ID instance service utilisateur';
        }
        modify("User Session Started")
        {
            CaptionML = ENU = 'User Session Started', FRA = 'Session utilisateur démarrée';
        }
        // modify("Timeout (sec.)")
        // {
        //     CaptionML = ENU = 'Timeout (sec.)', FRA = 'Délai d''expiration (sec.)';
        // }  // BC Upgrade NANDIS03
        modify("Notify On Success")
        {
            CaptionML = ENU = 'Notify On Success', FRA = 'Notification si réussite';
        }
        modify("User Language ID")
        {
            CaptionML = ENU = 'User Language ID', FRA = 'ID langue utilisateur';
        }
        modify("Printer Name")
        {
            CaptionML = ENU = 'Printer Name', FRA = 'Nom de l''imprimante';
        }
        modify("Report Request Page Options")
        {
            CaptionML = ENU = 'Report Request Page Options', FRA = 'Options page requête état';
        }
        modify("Rerun Delay (sec.)")
        {
            CaptionML = ENU = 'Rerun Delay (sec.)', FRA = 'Délai de réexécution (sec.)';
        }
        modify("System Task ID")
        {
            CaptionML = ENU = 'System Task ID', FRA = 'ID de tâche système';
        }
        modify(Scheduled)
        {

            //Unsupported feature: Change CalcFormula on "Scheduled(Field 49)". Please convert manually.

            CaptionML = ENU = 'Scheduled', FRA = 'Planifié(e)';
        }

        //Unsupported feature: CodeModification on ""Earliest Start Date/Time"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckStartAndExpirationDateTime;
        IF "Earliest Start Date/Time" <> xRec."Earliest Start Date/Time" THEN
          Reschedule;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckStartAndExpirationDateTime;
        if "Earliest Start Date/Time" <> xRec."Earliest Start Date/Time" then
          Reschedule;
        */
        //end;


        //Unsupported feature: CodeModification on ""Object Type to Run"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Object Type to Run" <> xRec."Object Type to Run" THEN
          VALIDATE("Object ID to Run",0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Object Type to Run" <> xRec."Object Type to Run" then
          VALIDATE("Object ID to Run",0);
        */
        //end;


        //Unsupported feature: CodeModification on ""Object ID to Run"(Field 8).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF LookupObjectID(NewObjectID) THEN
          VALIDATE("Object ID to Run",NewObjectID);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if LookupObjectID(NewObjectID) then
          VALIDATE("Object ID to Run",NewObjectID);
        */
        //end;


        //Unsupported feature: CodeModification on ""Object ID to Run"(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Object ID to Run" <> xRec."Object ID to Run" THEN BEGIN
          CLEAR(XML);
          CLEAR(Description);
          CLEAR("Parameter String");
          CLEAR("Report Request Page Options");
        end;
        IF "Object ID to Run" = 0 THEN
          EXIT;
        IF Object.GET("Object Type to Run",'',"Object ID to Run") THEN
          Object.TESTFIELD(Compiled);

        CALCFIELDS("Object Caption to Run");
        IF Description = '' THEN
          Description := GetDefaultDescription;

        IF "Object Type to Run" <> "Object Type to Run"::Report THEN
          EXIT;
        IF REPORT.DEFAULTLAYOUT("Object ID to Run") = DEFAULTLAYOUT::None THEN // Processing-only
          "Report Output Type" := "Report Output Type"::"None (Processing only)"
        else BEGIN
          "Report Output Type" := "Report Output Type"::PDF;
          IF REPORT.DEFAULTLAYOUT("Object ID to Run") = DEFAULTLAYOUT::Word THEN
            "Report Output Type" := "Report Output Type"::Word;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Object ID to Run" <> xRec."Object ID to Run" then begin
        #2..5
        end;
        if "Object ID to Run" = 0 then
          exit;
        if Object.GET("Object Type to Run",'',"Object ID to Run") then
        #10..12
        if Description = '' then
          Description := GetDefaultDescription;

        if "Object Type to Run" <> "Object Type to Run"::Report then
          exit;
        if REPORT.DEFAULTLAYOUT("Object ID to Run") = DEFAULTLAYOUT::None then // Processing-only
          "Report Output Type" := "Report Output Type"::"None (Processing only)"
        else begin
          "Report Output Type" := "Report Output Type"::PDF;
          if REPORT.DEFAULTLAYOUT("Object ID to Run") = DEFAULTLAYOUT::Word then
            "Report Output Type" := "Report Output Type"::Word;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Report Output Type"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Object Type to Run","Object Type to Run"::Report);

        IF REPORT.DEFAULTLAYOUT("Object ID to Run") = DEFAULTLAYOUT::None THEN // Processing-only
          TESTFIELD("Report Output Type","Report Output Type"::"None (Processing only)")
        else BEGIN
          IF "Report Output Type" = "Report Output Type"::"None (Processing only)" THEN
            FIELDERROR("Report Output Type");
          IF ReportLayoutSelection.HasCustomLayout("Object ID to Run") = 2 THEN // Word layout
            IF NOT ("Report Output Type" IN ["Report Output Type"::Print,"Report Output Type"::Word]) THEN
              FIELDERROR("Report Output Type");
        end;
        IF "Report Output Type" = "Report Output Type"::Print THEN BEGIN
          IF PermissionManager.SoftwareAsAService THEN BEGIN
            "Report Output Type" := "Report Output Type"::PDF;
            MESSAGE(NoPrintOnSaaSMsg);
          end else
            "Printer Name" := InitServerPrinterTable.FindClosestMatchToClientDefaultPrinter("Object ID to Run");
        end else
          "Printer Name" := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Object Type to Run","Object Type to Run"::Report);

        if REPORT.DEFAULTLAYOUT("Object ID to Run") = DEFAULTLAYOUT::None then // Processing-only
          TESTFIELD("Report Output Type","Report Output Type"::"None (Processing only)")
        else begin
          if "Report Output Type" = "Report Output Type"::"None (Processing only)" then
            FIELDERROR("Report Output Type");
          if ReportLayoutSelection.HasCustomLayout("Object ID to Run") = 2 then // Word layout
            if not ("Report Output Type" in ["Report Output Type"::Print,"Report Output Type"::Word]) then
              FIELDERROR("Report Output Type");
        end;
        if "Report Output Type" = "Report Output Type"::Print then begin
          if PermissionManager.SoftwareAsAService then begin
            "Report Output Type" := "Report Output Type"::PDF;
            MESSAGE(NoPrintOnSaaSMsg);
          end else
            "Printer Name" := InitServerPrinterTable.FindClosestMatchToClientDefaultPrinter("Object ID to Run");
        end else
          "Printer Name" := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Time"(Field 26).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Recurring Job");
        IF "Starting Time" = 0T THEN
          "Reference Starting Time" := 0DT
        else
          "Reference Starting Time" := CREATEDATETIME(010100D,"Starting Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Recurring Job");
        if "Starting Time" = 000000T then
          "Reference Starting Time" := 0DT
        else
          "Reference Starting Time" := CREATEDATETIME(20000101D,"Starting Time");
        */
        //end;


        //Unsupported feature: CodeModification on ""Printer Name"(Field 45).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ServerPrinters.SetSelectedPrinterName("Printer Name");
        IF ServerPrinters.RUNMODAL = ACTION::OK THEN BEGIN
          ServerPrinters.GETRECORD(Printer);
          "Printer Name" := Printer.ID;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ServerPrinters.SetSelectedPrinterName("Printer Name");
        if ServerPrinters.RUNMODAL = ACTION::OK then begin
          ServerPrinters.GETRECORD(Printer);
          "Printer Name" := Printer.ID;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Printer Name"(Field 45).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Report Output Type","Report Output Type"::Print);
        IF "Printer Name" = '' THEN
          EXIT;
        InitServerPrinterTable.ValidatePrinterName("Printer Name");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Report Output Type","Report Output Type"::Print);
        if "Printer Name" = '' then
          exit;
        InitServerPrinterTable.ValidatePrinterName("Printer Name");
        */
        //end;


        //Unsupported feature: CodeModification on ""Report Request Page Options"(Field 46).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Report Request Page Options" THEN
          RunReportRequestPage
        else BEGIN
          CLEAR(XML);
          MESSAGE(RequestPagesOptionsDeletedMsg);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Report Request Page Options" then
          RunReportRequestPage
        else begin
          CLEAR(XML);
          MESSAGE(RequestPagesOptionsDeletedMsg);
          "User ID" := USERID;
        end;
        */
        //end;
        field(50000; "No. of Min. To Force Reset FND"; Integer)
        {
            Caption = 'No. of Minutes To Force Reset';
            Description = 'HEI.01';
        }
        field(50001; "No. of Minutes To Notify FND"; Integer)
        {
            Caption = 'No. of Minutes To Notify';
            Description = 'HEI.01';
        }
        field(50002; "Notified Time FND"; DateTime)
        {
            Caption = 'Notified Time';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50004; "Send Document FND"; Option)
        {
            CaptionML = ENU = 'Send Document',
                        FRA = 'Envoyer Document';
            Description = 'HEI.02';
            Editable = false;
            OptionCaptionML = ENU = ' ,Mail,Print,Mail & Print',
                              FRA = ' ,E-Mail,Imprimer,E-Mail & Imprimer';
            OptionMembers = " ",Mail,Print,"Mail & Print";
        }
        // BC Upgrade PATELP08 >> changes datatype of field 50005"Document Type" from option to Enum "Sales Document Type".
        // field(50005; "Document Type"; Option)
        // {
        //     CaptionML = ENU = 'Document Type',
        //                 FRA = 'Type document';
        //     Description = 'HEI.02';
        //     Editable = false;
        //     OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
        //                       FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        //     OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        // }
        field(50005; "Document Type FND"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            Description = 'HEI.02';
            Editable = false;
        }
        // BC Upgrade PATELP08 <<
        field(50006; "Document No. FND"; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        FRA = 'N°';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50007; "JQ Posted FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'JQ Queue Posted';
            Editable = false;
        }
        field(50008; "JQ Mail Sent FND"; Boolean)
        {
            Description = 'HEI.02';
            Editable = false;
            Caption = 'JQ Queue Mail Sent';
        }
        field(50009; "JQ Printed FND"; Boolean)
        {
            Description = 'HEI.02';
            Editable = false;
            Caption = 'JQ Queue Printed';
        }
        field(50010; "Posted Document No. FND"; Code[20])
        {
            Description = 'HEI.02';
            Caption = 'Posted Document No.';
            Editable = false;
            TableRelation = IF ("JQ Posted FND" = CONST(true),
                                "Document Type FND" = FILTER(Order | Invoice)) "Sales Invoice Header"
            else IF ("JQ Posted FND" = CONST(true),
                                         "Document Type FND" = FILTER("Credit Memo" | "Return Order")) "Sales Cr.Memo Header";
        }
        field(50011; "JQ Logistics Mail Sent FND"; Boolean)
        {
            Description = 'HEI.03';
            Caption = 'JQ Logistics Mail Sent';
            Editable = false;
        }
        field(50012; "Notify Email ID FND"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'Notify Email ID';
        }
        field(50013; "JOB TenantID FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            Caption = 'JOB Tenant ID';
        }
        field(50014; "JOB ServiceInstanceName FND"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            Caption = 'JOB Service Instance Name';
        }
        field(50015; "JOB Server Name FND"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            Caption = 'JOB Server Name';
        }
        // BC Upgrade NANDIS03 >>
        field(50017; "No. of Attempts to Reset FND"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            Caption = 'No. of Attempts to Reset';
        }
        // BC Upgrade NANDIS03 <<
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Status = Status::"In Process" THEN
      ERROR(CannotDeleteEntryErr,Status);
    CancelTask("System Task ID");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Status = Status::"In Process" then
      ERROR(CannotDeleteEntryErr,Status);
    CancelTask;
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ISNULLGUID(ID) THEN
      ID := CREATEGUID;
    "Last Ready State" := CURRENTDATETIME;
    "User Language ID" := GLOBALLANGUAGE;
    "User ID" := USERID;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ISNULLGUID(ID) then
      ID := CREATEGUID;
    SetDefaultValues(true);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger (Variable: RunParametersChanged)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetDefaultValues;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RunParametersChanged := AreRunParametersChanged;
    if RunParametersChanged then
      Reschedule;
    SetDefaultValues(RunParametersChanged);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        RunParametersChanged: Boolean;

    // var
    //     TextMgt: Codeunit TextManagement;  // BC Upgrade NANDIS03

    // var
    //     TextMgt: Codeunit TextManagement;  // BC Upgrade NANDIS03

    var
        ScheduledTask: Record "Scheduled Task";

    var
        recActiveSessions: Record "Active Session";
        TempSessionID: Integer;
        TempServerInstanceName: Text;
        TempServerName: Text;
        TempTenantID: Text;

    var
        OldParams: Text;


    //Unsupported feature: PropertyModification on "NoErrMsg(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoErrMsg : ENU=There is no error message.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoErrMsg : ENU=There is no error message.;FRA=Absence de message d'erreur.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotDeleteEntryErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotDeleteEntryErr : @@@=%1 is a status value, such as Success or Error.;ENU=You cannot delete an entry that has status %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotDeleteEntryErr : @@@=%1 is a status value, such as Success or Error.;ENU=You cannot delete an entry that has status %1.;FRA=Vous ne pouvez pas supprimer une écriture dont le statut est %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ScheduledForPostingMsg(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ScheduledForPostingMsg : @@@="%1=a date, %2 = a user.";ENU=Scheduled for posting on %1 by %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ScheduledForPostingMsg : @@@="%1=a date, %2 = a user.";ENU=Scheduled for posting on %1 by %2.;FRA=Programmé pour validation le %1 par %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NoRecordErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoRecordErr : ENU=No record is associated with the job queue entry.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoRecordErr : ENU=No record is associated with the job queue entry.;FRA=Aucun enregistrement n'est associé à l'écriture de file d'attente des travaux.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RequestPagesOptionsDeletedMsg(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RequestPagesOptionsDeletedMsg : ENU=You have cleared the report parameters. Select the check box in the field to show the report request page again.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RequestPagesOptionsDeletedMsg : ENU=You have cleared the report parameters. Select the check box in the field to show the report request page again.;FRA=Vous avez effacé les paramètres de l'état. Activez le champ pour afficher à nouveau la page de sélection de l'état.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ExpiresBeforeStartErr(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ExpiresBeforeStartErr : @@@="%1 = Expiration Date, %2=Start date";ENU=%1 must be later than %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ExpiresBeforeStartErr : @@@="%1 = Expiration Date, %2=Start date";ENU=%1 must be later than %2.;FRA=%1 doit être postérieur(e) à %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UserSessionJobsCannotBeRecurringErr(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UserSessionJobsCannotBeRecurringErr : ENU=You cannot set up recurring user session job queue entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UserSessionJobsCannotBeRecurringErr : ENU=You cannot set up recurring user session job queue entries.;FRA=Vous ne pouvez pas paramétrer la récurrence des écritures file projets de session utilisateur.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NoPrintOnSaaSMsg(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoPrintOnSaaSMsg : ENU=You cannot select a printer from this online product. Instead, save as PDF, or another format, which you can print later.\\The output type has been set to PDF.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoPrintOnSaaSMsg : ENU=You cannot select a printer from this online product. Instead, save as PDF, or another format, which you can print later.\\The output type has been set to PDF.;FRA=Vous ne pouvez pas sélectionner une imprimante à partir de ce produit en ligne. Au lieu de cela, enregistrez en tant que PDF ou un autre format, que vous pourrez imprimer ultérieurement.\\Le type de sortie a été défini sur PDF.;
    //Variable type has not been exported.

    // BC Upgrade NANDIS03 >>
    // local procedure StopSessionPS(iTenantID: Text; iSessionID: Text; iServerInstance: Text; iServerName: Text)
    // var
    //     Created: Boolean;
    //     LogOut: Boolean;
    //     recServer: Record Server;
    //     recDatabase: Record Database;
    //     recMyActiveSession: Record "Active Session";

    // begin
    //     //HEI.08>>
    //     recMyActiveSession.SETRANGE("Session ID", SESSIONID);
    //     IF recMyActiveSession.FINDFIRST() THEN BEGIN
    //         IF (UPPERCASE(recMyActiveSession."Server Computer Name") = UPPERCASE(Rec."JOB Server Name")) THEN BEGIN
    //             PowerShellRunner := PowerShellRunner.CreateInSandbox;
    //             PowerShellRunner.WriteEventOnError := TRUE;
    //             PowerShellRunner.ImportModule('C:\scripts\heilite-ops\NAV.ps1');
    //             PowerShellRunner.AddCommand('Remove-NAVServerSession');
    //             PowerShellRunner.AddParameter('Tenant', iTenantID);
    //             PowerShellRunner.AddParameter('SessionId', iSessionID);
    //             PowerShellRunner.AddParameter('ServerInstance', iServerInstance);
    //             PowerShellRunner.AddParameter('Force');
    //             PowerShellRunner.BeginInvoke;
    //             REPEAT
    //                 SLEEP(1000);
    //             UNTIL PowerShellRunner.IsCompleted;
    //         end else BEGIN
    //             PowerShellRunner := PowerShellRunner.CreateInSandbox;
    //             PowerShellRunner.WriteEventOnError := TRUE;
    //             PowerShellRunner.ImportModule('C:\scripts\heilite-ops\Remove-RemoteNAVServerSession.ps1');
    //             PowerShellRunner.AddCommand('Remove-RemoteNAVServerSession');
    //             PowerShellRunner.AddParameter('iServername', iServerName);
    //             PowerShellRunner.AddParameter('iSessionId', iSessionID);
    //             PowerShellRunner.AddParameter('iServerInstance', iServerInstance);
    //             PowerShellRunner.AddParameter('iTenant', iTenantID);
    //             PowerShellRunner.BeginInvoke;
    //             REPEAT
    //                 SLEEP(1000);
    //             UNTIL PowerShellRunner.IsCompleted;
    //         end;
    //     end;
    //     CLEAR(PowerShellRunner);
    //     //HEI.08<<
    // end;
    // BC Upgrade PATELP08 >> Blocking this procedure as Table 'Job Queue Entry' already defines a method called 'FinalizeLogEntry' with the same parameter types in 'Base Application by Microsoft so this is duplicate.
    // procedure FinalizeLogEntry(JobQueueLogEntry: Record "Job Queue Log Entry")
    // var
    //     myInt: Integer;
    // begin

    // end;
    // BC Upgrade PATELP08 <<
    // BC Upgrade NANDIS03 <<

}

