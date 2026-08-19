pageextension 51057 JobQueueLogEntriesExtCBN extends "Job Queue Log Entries"
{
    // version NAVW110.0,HEI.02
    //     HEI.01 FDD-GAPID001 IBM LAZARE02 05.10.2017 # New field "Notification Sent" used to manage job queue entries in error state
    // HEI.02 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    //   # Add field "Entry No."
    layout
    {
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of the running of the job queue entry in a log.', FRA = 'Spécifie le statut de l''exécution de l''écriture file d''attente des travaux dans un journal.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who inserted the job in the job queue.', FRA = 'Spécifie le code utilisateur de la personne qui a inséré le projet dans la file d''attente des travaux.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the job queue entry in the log.', FRA = 'Spécifie une description de l''écriture file d''attente des travaux dans le journal.';
        }
        modify("Object Type to Run")
        {
            ToolTipML = ENU = 'Specifies the type of the object that is to be run for the job.', FRA = 'Spécifie le type de l''objet à exécuter pour le projet.';
        }
        modify("Object ID to Run")
        {
            ToolTipML = ENU = 'Specifies the ID of the object that is to be run for the job.', FRA = 'Spécifie l''ID de l''objet à exécuter pour le projet.';
        }
        modify("Object Caption to Run")
        {
            ToolTipML = ENU = 'Specifies the name or caption of the object that was run for the job.', FRA = 'Spécifie le nom ou la légende de l''objet exécuté pour le projet.';
        }
        modify("Start Date/Time")
        {
            ToolTipML = ENU = 'Specifies the date and time when the job was started.', FRA = 'Spécifie la date et l''heure auxquelles le projet a commencé.';
        }
        modify(Duration)
        {
            CaptionML = ENU = 'Duration', FRA = 'Durée';
        }
        modify("End Date/Time")
        {
            ToolTipML = ENU = 'Specifies the date and time when the job ended.', FRA = 'Spécifie la date et l''heure auxquelles le projet a fini.';
        }
        // modify(GetErrorMessage)
        // {
        //     CaptionML = ENU = 'Error Message', FRA = 'Message d''erreur';
        //     ToolTipML = ENU = 'Specifies an error that occurred in the job queue.', FRA = 'Spécifie une erreur qui s''est produite dans la file d''attente des travaux.';
        // }
        // modify("Processed by User ID")
        // {
        //     ToolTipML = ENU = 'Specifies the user ID of the job queue entry processor. The user ID comes from the job queue entry card.', FRA = 'Spécifie le code utilisateur de la personne qui a traité l''écriture file d''attente des travaux. Le code utilisateur est issu de la carte de l''écriture file d''attente des travaux.';
        // }  // BC Upgrade NANDIS03
        modify("Job Queue Category Code")
        {
            ToolTipML = ENU = 'Specifies the category code for the entry in the job queue log.', FRA = 'Spécifie un code catégorie pour l''écriture dans le journal de la file d''attente des travaux.';
        }
        addfirst(Control1)
        {
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Entry No. field.';
            }
        }
        addafter("Job Queue Category Code")
        {
            field("Notification Sent"; Rec."Notification Sent FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Notification Sent field.';
            }
        }
    }
    actions
    {
        // modify("Delete Log Entries")
        // {
        //     CaptionML = ENU = 'Delete Log Entries', FRA = 'Supprimer les écritures journal';
        // }  // BC Upgrade NANDIS03
        modify(Delete7days)
        {
            CaptionML = ENU = 'Delete Entries Older Than 7 Days', FRA = 'Supprimer les écritures datant de plus de 7 jours';
            ToolTipML = ENU = 'Clear the list of log entries that are older than 7 days.', FRA = 'Effacez la liste des écritures du journal de plus de 7 jours.';
        }
        modify(Delete0days)
        {
            CaptionML = ENU = 'Delete All Entries', FRA = 'Supprimer toutes les écritures';
            ToolTipML = ENU = 'Clear the list of all log entries.', FRA = 'Effacez la liste de toutes les écritures du journal.';
        }
        modify("Show Error Message")
        {
            CaptionML = ENU = 'Show Error Message', FRA = 'Afficher le message d''erreur';
            ToolTipML = ENU = 'Show the error message that has stopped the entry.', FRA = 'Affichez le message d''erreur qui a interrompu l''écriture.';
        }
        modify(SetStatusToError)
        {
            CaptionML = ENU = 'Set Status to Error', FRA = 'Définir le Statut sur Erreur';
            ToolTipML = ENU = 'Change the status of the entry.', FRA = 'Modifiez le statut de l''écriture.';
        }


        //Unsupported feature: CodeModification on "SetStatusToError(Action 18).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CONFIRM(JobQueueEntryRunningQst,FALSE) THEN
          MarkAsError;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CONFIRM(JobQueueEntryRunningQst,false) then
          MarkAsError;
        */
        //end;
    }


    //Unsupported feature: PropertyModification on "JobQueueEntryRunningQst(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //JobQueueEntryRunningQst : ENU=This job queue entry may be still running. If you set the status to Error, it may keep running in the background. Are you sure you want to set the status to Error?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //JobQueueEntryRunningQst : ENU=This job queue entry may be still running. If you set the status to Error, it may keep running in the background. Are you sure you want to set the status to Error?;FRA=Cette écriture file d'attente des travaux est peut-être toujours en cours d'exécution. Si vous définissez son statut sur Erreur, elle peut continuer à s'exécuter en arrière-plan. Voulez-vous vraiment définir son statut sur Erreur ?;
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FINDFIRST THEN;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if FINDFIRST then;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

