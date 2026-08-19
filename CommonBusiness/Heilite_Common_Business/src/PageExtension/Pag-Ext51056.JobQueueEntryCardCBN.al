pageextension 51056 JobQueueEntryCardExtCBN extends "Job Queue Entry Card"
{
    // version NAVW110.0,HEI.03
    // HEI.01 FDD-GAPID001 IBM LAZARE02 05.10.2017 # New fields used to manage job queue entries in error state in the new tab Notification
    // HEI.02 CHG2106712 SAMANR01 19.04.2020
    //   # New field added  "Notify Email ID" under Notification Tab
    // HEI.03 IBM SAMANR01 12.05.2023 CHG2204329 Email Validation on JOB Q & Interfaces
    //   # Add code for email validation

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
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
        modify("Parameter String")
        {
            ToolTipML = ENU = 'Specifies a text string that is used as a parameter by the job queue when it is run.', FRA = 'Spécifie une chaîne de caractères utilisée comme paramètre par la file d''attente des travaux lors de son exécution.';
        }
        modify("Job Queue Category Code")
        {
            ToolTipML = ENU = 'Specifies the code of the job queue category to which the job queue entry belongs. Choose the field to select a code from the list.', FRA = 'Spécifie le code de la catégorie de la file d''attente des travaux à laquelle l''écriture file d''attente des travaux appartient. Choisissez le champ pour sélectionnez un code dans la liste.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the user ID of the user who has inserted the job queue entry in the queue.', FRA = 'Spécifie le code utilisateur de la personne qui a inséré l''écriture file d''attente des travaux dans la file d''attente.';
        }
        modify("Maximum No. of Attempts to Run")
        {
            ToolTipML = ENU = 'Specifies how many times a job queue task should be rerun after a job queue fails to run. This is useful for situations in which a task might be unresponsive. For example, a task might be unresponsive because it depends on an external resource that is not always available.', FRA = 'Indique combien de fois une tâche de file d''attente des travaux doit être à nouveau exécutée après l''échec de l''exécution d''une file d''attente des travaux. Ceci est utile lorsqu''une tâche pourrait ne pas être disponible. Ce pourrait être le cas si une tâche dépend d''une ressource externe qui n''est pas toujours disponible.';
        }
        modify("Last Ready State")
        {
            ToolTipML = ENU = 'Specifies the date and time when the job queue entry was last set to Ready and sent to the job queue.', FRA = 'Indique la date et l''heure les plus récentes auxquelles l''écriture file d''attente des travaux a été définie sur Prête et envoyée dans la file d''attente des travaux.';
        }
        modify("Earliest Start Date/Time")
        {
            ToolTipML = ENU = 'Specifies the earliest date and time when the job queue entry should be run.', FRA = 'Spécifie les premières date et heure auxquelles l''écriture file d''attente des travaux devrait être exécutée.';
        }
        modify("Expiration Date/Time")
        {
            ToolTipML = ENU = 'Specifies the date and time when the job queue entry is to expire, after which the job queue entry will not be run.', FRA = 'Indique la date et l''heure auxquelles l''écriture file d''attente des travaux doit expirer, après quoi l''écriture file d''attente des travaux ne sera pas exécutée.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of the job queue entry. When you create a job queue entry, its status is set to On Hold. You can set the status to Ready and back to On Hold. Otherwise, status information in this field is updated automatically.', FRA = 'Spécifie le statut de l''écriture file d''attente des travaux. Lorsque vous créez une écriture file d''attente des travaux, son statut est défini sur En attente. Vous pouvez définir le statut sur Prêt et revenir à En attente. Sinon, les informations sur le statut dans ce champ sont mises à jour automatiquement.';
        }
        modify("Report Parameters")
        {
            CaptionML = ENU = 'Report Parameters', FRA = 'Paramètres état';
        }
        modify("Report Request Page Options")
        {
            ToolTipML = ENU = 'Specifies whether options on the report request page have been set for scheduled report job. If the check box is selected, then options have been set for the scheduled report.', FRA = 'Indique si des options de la page demande d''état ont été définies pour une tâche d''état planifié. La case à cocher sélectionnée indique que des options ont été définies pour l''état planifié.';
        }
        modify("Report Output Type")
        {
            ToolTipML = ENU = 'Specifies the output of the scheduled report.', FRA = 'Spécifie la sortie de l''état planifié.';
        }
        modify("Printer Name")
        {
            ToolTipML = ENU = 'Specifies the printer to use to print the scheduled report.', FRA = 'Spécifie l''imprimante à utiliser pour imprimer l''état planifié.';
        }
        modify(Recurrence)
        {
            CaptionML = ENU = 'Recurrence', FRA = 'Répétition';
        }
        modify("Recurring Job")
        {
            ToolTipML = ENU = 'Specifies if the job queue entry is recurring. If the Recurring Job check box is selected, then the job queue entry is recurring. If the check box is cleared, the job queue entry is not recurring. After you specify that a job queue entry is a recurring one, you must specify on which days of the week the job queue entry is to run. Optionally, you can also specify a time of day for the job to run and how many minutes should elapse between runs.', FRA = 'Spécifie si l''écriture file d''attente des travaux est récurrente. Si la case à cocher Projet récurrent est sélectionnée, l''écriture file d''attente des travaux est récurrente. Dans le cas contraire, l''écriture file d''attente des travaux n''est pas récurrente. Après avoir spécifié qu''une écriture file d''attente des travaux est récurrente, vous devez indiquer les jours pendant lesquels l''écriture file d''attente des travaux doit être exécutée. Vous avez également la possibilité de spécifier une heure à laquelle le projet doit être exécuté et le nombre de minutes devant s''écouler entre deux exécutions.';
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
        modify("No. of Minutes between Runs")
        {
            ToolTipML = ENU = 'Specifies the minimum number of minutes that are to elapse between runs of a job queue entry. This field only has meaning if the job queue entry is set to be a recurring job.', FRA = 'Spécifie le nombre minimum de minutes devant s''écouler entre deux exécutions d''une écriture file d''attente des travaux. Ce champ n''a de sens que si l''écriture file d''attente des travaux est définie comme projet récurrent.';
        }
        addafter(Recurrence)
        {
            group(Notification)
            {
                Caption = 'Notification';
                field("No. of Minutes To Force Reset"; Rec."No. of Min. To Force Reset FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Minutes To Force Reset field.';
                }
                field("No. of Minutes To Notify"; Rec."No. of Minutes To Notify FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Minutes To Notify field.';
                }
                field("Notified Time"; Rec."Notified Time FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notified Time field.';
                }
                field("Notify Email ID"; Rec."Notify Email ID FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notify Email ID field.';

                    trigger OnValidate();
                    var
                        SendEmailConfirmation: Codeunit "Send Email Confirmation CBN";
                    begin
                        //HEI.03>>
                        SendEmailConfirmation.ValidateEmailAddresses(Rec."Notify Email ID FND", true);
                        //HEI.03<<
                    end;
                }
            }
        }
    }
    actions
    {
        modify("Job &Queue")
        {
            CaptionML = ENU = 'Job &Queue', FRA = '&File d''attente des travaux';
        }
        modify("Set Status to Ready")
        {
            CaptionML = ENU = 'Set Status to Ready', FRA = 'Définir le statut sur Prêt';
            ToolTipML = ENU = 'Change the status of the entry.', FRA = 'Modifiez le statut de l''écriture.';
            // BC Upgrade NANDIS03 >>
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                //HEI.04>>
                Rec."No. of Attempts to Reset FND" := 0;
                Rec.MODIFY();
                //HEI.04<<
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Set On Hold")
        {
            CaptionML = ENU = 'Set On Hold', FRA = 'Mettre en attente';
            ToolTipML = ENU = 'Change the status of the entry.', FRA = 'Modifiez le statut de l''écriture.';
        }
        modify("Show Error")
        {
            CaptionML = ENU = 'Show Error', FRA = 'Afficher erreur';
            ToolTipML = ENU = 'Show the error message that has stopped the entry.', FRA = 'Affichez le message d''erreur qui a interrompu l''écriture.';
        }
        modify(Restart)
        {
            CaptionML = ENU = 'Restart', FRA = 'Redémarrer';
            ToolTipML = ENU = 'Stop and start the entry.', FRA = 'Interrompez et démarrez l''écriture.';
            // BC Upgrade NANDIS03 >>
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                //HEI.04>>
                Rec."No. of Attempts to Reset FND" := 0;
                Rec.MODIFY();
                //HEI.04<<
            end;
            // BC Upgrade NANDIS03 <<
        }
        // modify(ActionGroup12)
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
            ToolTipML = ENU = 'Show the record for the entry.', FRA = 'Affichez l''enregistrement de l''écriture.';
        }
        modify(ReportRequestPage)
        {
            CaptionML = ENU = 'Report Request Page', FRA = 'Page requête état';
            ToolTipML = ENU = 'Show the request page for the entry. If the entry is set up to run a processing-only report, the request page is blank.', FRA = 'Affichez la page de demande pour l''écriture. Si l''écriture est définie comme devant exécuter un état à des fins de traitement uniquement, la page de demande est vide.';
        }
    }


    //Unsupported feature: PropertyModification on "ChooseSetOnHoldMsg(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ChooseSetOnHoldMsg : ENU=To edit the job queue entry, you must first choose the Set On Hold action.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChooseSetOnHoldMsg : ENU=To edit the job queue entry, you must first choose the Set On Hold action.;FRA=Pour modifier l'écriture de file d'attente des travaux, vous devez tout d'abord choisir l'action Mettre en attente.;
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT ((Status = Status::Error) OR (Status = Status::"On Hold")) THEN BEGIN
      IF "Earliest Start Date/Time" - CURRENTDATETIME < 2 * 60 * 1000 THEN
        MESSAGE(ChooseSetOnHoldMsg);
    end
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not ((Status = Status::Error) or (Status = Status::"On Hold")) then begin
      if "Earliest Start Date/Time" - CURRENTDATETIME < 2 * 60 * 1000 then
        MESSAGE(ChooseSetOnHoldMsg);
    end
    */
    //end;


    //Unsupported feature: CodeModification on "GetChooseSetOnHoldMsg(PROCEDURE 9)". Please convert manually.

    //procedure GetChooseSetOnHoldMsg();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EXIT(ChooseSetOnHoldMsg);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    exit(ChooseSetOnHoldMsg);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

