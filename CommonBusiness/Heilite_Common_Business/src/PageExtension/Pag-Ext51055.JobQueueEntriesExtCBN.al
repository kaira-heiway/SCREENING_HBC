pageextension 51055 JobQueueEntriesExtCBN extends "Job Queue Entries"
{
    // version NAVW110.0

    layout
    {
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of the job queue entry. When you create a job queue entry, its status is set to On Hold. You can set the status to Ready and back to On Hold. Otherwise, status information in this field is updated automatically.', FRA = 'Spécifie le statut de l''écriture file d''attente des travaux. Lorsque vous créez une écriture file d''attente des travaux, son statut est défini sur En attente. Vous pouvez définir le statut sur Prêt et revenir à En attente. Sinon, les informations sur le statut dans ce champ sont mises à jour automatiquement.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the user ID of the user who has inserted the job queue entry in the queue.', FRA = 'Spécifie le code utilisateur de la personne qui a inséré l''écriture file d''attente des travaux dans la file d''attente.';
        }
        modify("Object Type to Run")
        {
            ToolTipML = ENU = 'Specifies the type of the object, report or codeunit, that is to be run for the job queue entry. After you specify a type, you then select an object ID of that type in the Object ID to Run field.', FRA = 'Spécifie le type de l''objet, de l''état ou du codeunit qui doit être exécuté pour l''écriture file d''attente des travaux. Après avoir indiqué un type, vous devez sélectionner un ID objet de ce type dans le champ ID objet à exécuter.';
        }
        modify("Object ID to Run")
        {
            ToolTipML = ENU = 'Specifies the ID of the object that is to be run for this job. You can select an ID that is of the object type that you have specified in the Object Type to Run field.', FRA = 'Spécifie l''ID de l''objet qui doit être exécuté pour ce projet. L''ID peut être le type d''objet que vous avez spécifié dans le champ Type d''objet à exécuter.';
        }
        modify("Object Caption to Run")
        {
            ToolTipML = ENU = 'Specifies the name of the object that is selected in the Object ID to Run field.', FRA = 'Spécifie le nom de l''objet sélectionné dans le champ ID objet à exécuter.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the job queue entry. You can edit and update the description on the job queue entry card. The description is also displayed in the Job Queue Entries window, but it cannot be updated there. You can enter a maximum of 50 characters, both numbers and letters.', FRA = 'Spécifie une description de l''écriture file d''attente des travaux. Vous pouvez modifier et mettre à jour la description dans la carte écriture file d''attente des travaux. La description s''affiche également dans la fenêtre Écriture file d''attente des travaux, mais il est impossible de l''y modifier. Vous pouvez saisir 50 caractères maximum (chiffres et lettres).';
        }
        modify("Job Queue Category Code")
        {
            ToolTipML = ENU = 'Specifies the code of the job queue category to which the job queue entry belongs. Choose the field to select a code from the list.', FRA = 'Spécifie le code de la catégorie de la file d''attente des travaux à laquelle l''écriture file d''attente des travaux appartient. Choisissez le champ pour sélectionnez un code dans la liste.';
        }
        modify("User Session Started")
        {
            ToolTipML = ENU = 'Specifies the date and time that a user session started.', FRA = 'Spécifie la date et l''heure auxquelles une session utilisateur a démarré.';
        }
        modify("Parameter String")
        {
            ToolTipML = ENU = 'Specifies a text string that is used as a parameter by the job queue when it is run.', FRA = 'Spécifie une chaîne de caractères utilisée comme paramètre par la file d''attente des travaux lors de son exécution.';
        }
        modify("Earliest Start Date/Time")
        {
            ToolTipML = ENU = 'Specifies the earliest date and time when the job queue entry should be run.', FRA = 'Spécifie les premières date et heure auxquelles l''écriture file d''attente des travaux devrait être exécutée.';
        }
        modify(Scheduled)
        {
            ToolTipML = ENU = 'Specifies the assigned priority of a job queue entry. You can use priority to determine the order in which job queue entries are run.', FRA = 'Spécifie la priorité affectée d''une écriture file d''attente des travaux. Vous pouvez utiliser la priorité pour déterminer l''ordre dans lequel des écritures file d''attente des travaux sont exécutées.';
        }
        modify("Recurring Job")
        {
            ToolTipML = ENU = 'Specifies if the job queue entry is recurring. If the Recurring Job check box is selected, then the job queue entry is recurring. If the check box is cleared, the job queue entry is not recurring. After you specify that a job queue entry is a recurring one, you must specify on which days of the week the job queue entry is to run. Optionally, you can also specify a time of day for the job to run and how many minutes should elapse between runs.', FRA = 'Spécifie si l''écriture file d''attente des travaux est récurrente. Si la case à cocher Projet récurrent est sélectionnée, l''écriture file d''attente des travaux est récurrente. Dans le cas contraire, l''écriture file d''attente des travaux n''est pas récurrente. Après avoir spécifié qu''une écriture file d''attente des travaux est récurrente, vous devez indiquer les jours pendant lesquels l''écriture file d''attente des travaux doit être exécutée. Vous avez également la possibilité de spécifier une heure à laquelle le projet doit être exécuté et le nombre de minutes devant s''écouler entre deux exécutions.';
        }
        modify("No. of Minutes between Runs")
        {
            ToolTipML = ENU = 'Specifies the minimum number of minutes that are to elapse between runs of a job queue entry. This field only has meaning if the job queue entry is set to be a recurring job.', FRA = 'Spécifie le nombre minimum de minutes devant s''écouler entre deux exécutions d''une écriture file d''attente des travaux. Ce champ n''a de sens que si l''écriture file d''attente des travaux est définie comme projet récurrent.';
        }
        modify("Run on Mondays")
        {
            ToolTipML = ENU = 'Specifies that the job queue entry runs on Mondays.', FRA = 'Indique que l''écriture file d''attente des travaux est exécutée tous les lundis.';
        }
        modify("Run on Tuesdays")
        {
            ToolTipML = ENU = 'Specifies that the job queue entry runs on Tuesdays.', FRA = 'Indique que l''écriture file d''attente des travaux est exécutée tous les mardis.';
        }
        modify("Run on Wednesdays")
        {
            ToolTipML = ENU = 'Specifies that the job queue entry runs on Wednesdays.', FRA = 'Indique que l''écriture file d''attente des travaux est exécutée tous les mercredis.';
        }
        modify("Run on Thursdays")
        {
            ToolTipML = ENU = 'Specifies that the job queue entry runs on Thursdays.', FRA = 'Indique que l''écriture file d''attente des travaux est exécutée tous les jeudis.';
        }
        modify("Run on Fridays")
        {
            ToolTipML = ENU = 'Specifies that the job queue entry runs on Fridays.', FRA = 'Indique que l''écriture file d''attente des travaux est exécutées tous les vendredis.';
        }
        modify("Run on Saturdays")
        {
            ToolTipML = ENU = 'Specifies that the job queue entry runs on Saturdays.', FRA = 'Indique que l''écriture file d''attente des travaux est exécutée tous les samedis.';
        }
        modify("Run on Sundays")
        {
            ToolTipML = ENU = 'Specifies that the job queue entry runs on Sundays.', FRA = 'Indique que l''écriture file d''attente des travaux est exécutée tous les dimanches.';
        }
        modify("Starting Time")
        {
            ToolTipML = ENU = 'Specifies the earliest time of the day that the recurring job queue entry is to be run.', FRA = 'Spécifie la première heure à laquelle l''écriture file d''attente des travaux récurrents doit être exécutée.';
        }
        modify("Ending Time")
        {
            ToolTipML = ENU = 'Specifies the latest time of the day that the recurring job queue entry is to be run.', FRA = 'Spécifie la dernière heure à laquelle l''écriture file d''attente des travaux récurrents doit être exécutée.';
        }
    }
    actions
    {
        modify("Job &Queue")
        {
            CaptionML = ENU = 'Job &Queue', FRA = '&File d''attente des travaux';
        }
        modify(ResetStatus)
        {
            CaptionML = ENU = 'Set Status to Ready', FRA = 'Définir le statut sur Prêt';
            ToolTipML = ENU = 'Change the status of the selected entry.', FRA = 'Modifiez le statut de l''écriture sélectionnée.';
        }
        modify(Suspend)
        {
            CaptionML = ENU = 'Set On Hold', FRA = 'Mettre en attente';
            ToolTipML = ENU = 'Change the status of the selected entry.', FRA = 'Modifiez le statut de l''écriture sélectionnée.';
        }
        modify(ShowError)
        {
            CaptionML = ENU = 'Show Error', FRA = 'Afficher erreur';
            ToolTipML = ENU = 'Show the error message that has stopped the entry.', FRA = 'Affichez le message d''erreur qui a interrompu l''écriture.';
        }
        modify(Restart)
        {
            CaptionML = ENU = 'Restart', FRA = 'Redémarrer';
            ToolTipML = ENU = 'Stop and start the selected entry.', FRA = 'Interrompez et démarrez l''écriture sélectionnée.';
        }
        // modify(ActionGroup15)
        // {
        //     CaptionML = ENU = 'Job &Queue', FRA = '&File d''attente des travaux';
        // }  // BC Upgrade NANDIS03
        modify(LogEntries)
        {
            CaptionML = ENU = 'Log Entries', FRA = 'Écritures journal';
            ToolTipML = ENU = 'View the job queue log entries.', FRA = 'Affichez les écritures de la file d''attente des travaux.';
        }
        modify(ShowRecord)
        {
            CaptionML = ENU = 'Show Record', FRA = 'Afficher enregistrement';
            ToolTipML = ENU = 'Show the record for the selected entry.', FRA = 'Affichez l''enregistrement de l''écriture sélectionnée.';
        }
        addafter(ShowRecord)
        {
            // action(RemoveError)
            // {
            //     ApplicationArea = Basic, Suite;
            //     CaptionML = DEU = 'Fehlgeschlagene Elemente entfernen',
            //                 ENU = 'Remove Failed Entries';
            //     Image = Delete;
            //     ToolTipML = DEU = 'Löscht die Aufgabenwarteschlangenposten, die fehlgeschlagen sind.',
            //                 ENU = 'Deletes the job queue entries that have failed.';

            //     trigger OnAction();
            //     begin
            //         RemoveFailedJobs;
            //     end;
            // }  // BC Upgrade NANDIS03
        }
    }


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UserDoesNotExist := FALSE;
    IF "User ID" = USERID THEN
      EXIT;
    IF User.ISEMPTY THEN
      EXIT;
    User.SETRANGE("User Name","User ID");
    UserDoesNotExist := User.ISEMPTY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UserDoesNotExist := false;
    if "User ID" = USERID then
      exit;
    if User.ISEMPTY then
      exit;
    User.SETRANGE("User Name","User ID");
    UserDoesNotExist := User.ISEMPTY;
    */
    //end;

    local procedure RemoveFailedJobs();
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.SETRANGE(Status, JobQueueEntry.Status::Error);
        JobQueueEntry.SETRANGE("Recurring Job", false);
        if not JobQueueEntry.ISEMPTY then
            JobQueueEntry.DELETEALL();
    end;

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

