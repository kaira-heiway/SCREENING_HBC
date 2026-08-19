page 51068 "JQ Log Entries_Auto Sales CBN"
{
    // version HEI.01,HEI.02
    // HEI.01 CHG2010375 IBM.LS 21.01.2020
    //   # New Page created: 50270 - JQ Log Entries_Auto Sales
    //   # Code added.
    // HEI.02 CHG2010375 IBM.LS 12.02.2020
    //   # New Field added: "JQ Logistics Mail Sent"
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in Report.
    // 2. Comment GetErrorMessage beause not found in BC.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    CaptionML = ENU = 'Job Queue Log Entries_Auto Sales',
                FRA = 'Écritures journal file d''attente des travaux';
    Editable = false;
    PageType = List;
    SourceTable = "Job Queue Log Entry";
    SourceTableView = SORTING("Start Date/Time", ID)
                      ORDER(Descending)
                      WHERE("Object Type to Run" = CONST(Codeunit),
                            "Object ID to Run" = CONST(88));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the status of the running of the job queue entry in a log.',
                                FRA = 'Spécifie le statut de l''exécution de l''écriture file d''attente des travaux dans un journal.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the ID of the user who inserted the job in the job queue.',
                                FRA = 'Spécifie le code utilisateur de la personne qui a inséré le projet dans la file d''attente des travaux.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a description of the job queue entry in the log.',
                                FRA = 'Spécifie une description de l''écriture file d''attente des travaux dans le journal.';
                }
                field("Send Document"; Rec."Send Document FND")
                {
                    ApplicationArea = All;
                }
                field("JQ Posted"; Rec."JQ Posted FND")
                {
                    ApplicationArea = All;
                }
                field("JQ Logistics Mail Sent"; Rec."JQ Logistics Mail Sent FND")
                {
                    ApplicationArea = All;
                }
                field("JQ Mail Sent"; Rec."JQ Mail Sent FND")
                {
                    ApplicationArea = All;
                }
                field("JQ Printed"; Rec."JQ Printed FND")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type FND")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No. FND")
                {
                    ApplicationArea = All;
                }
                field("Posted Document No."; Rec."Posted Document No. FND")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade BHARDA11 >> ----Obsolet in BC
                // field(GetErrorMessage; Rec.GetErrorMessage)
                // {
                //     ApplicationArea = Basic, Suite;
                //     CaptionML = ENU = 'Error Message',
                //                 FRA = 'Message d''erreur';
                //     ToolTipML = ENU = 'Specifies an error that occurred in the job queue.',
                //                 FRA = 'Spécifie une erreur qui s''est produite dans la file d''attente des travaux.';

                //     trigger OnAssistEdit();
                //     begin
                //         Rec.ShowErrorMessage();
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Obsolet in BC
                // BC Upgrade SHUKLP03 >> ----OTC008 Test Script
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Error Message',
                                FRA = 'Message d''erreur';
                    ToolTipML = ENU = 'Specifies an error that occurred in the job queue.',
                                FRA = 'Spécifie une erreur qui s''est produite dans la file d''attente des travaux.';

                }
                // BC Upgrade SHUKLP03 << ----OTC008 Test Script

                field("Start Date/Time"; Rec."Start Date/Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date and time when the job was started.',
                                FRA = 'Spécifie la date et l''heure auxquelles le projet a commencé.';
                }
                field(Duration; Rec.Duration)
                {
                    CaptionML = ENU = 'Duration',
                                FRA = 'Durée';
                }
                field("Object Type to Run"; Rec."Object Type to Run")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the type of the object that is to be run for the job.',
                                FRA = 'Spécifie le type de l''objet à exécuter pour le projet.';
                }
                field("Object ID to Run"; Rec."Object ID to Run")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the ID of the object that is to be run for the job.',
                                FRA = 'Spécifie l''ID de l''objet à exécuter pour le projet.';
                }
                field("Object Caption to Run"; Rec."Object Caption to Run")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the name or caption of the object that was run for the job.',
                                FRA = 'Spécifie le nom ou la légende de l''objet exécuté pour le projet.';
                }
                field("Notification Sent"; Rec."Notification Sent FND")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            // CaptionML = ENU='Delete Log Entries',
            //             FRA='Supprimer les écritures journal';


            action("Show Error Message")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Show Error Message',
                            FRA = 'Afficher le message d''erreur';
                Image = Error;
                ToolTipML = ENU = 'Show the error message that has stopped the entry.',
                            FRA = 'Affichez le message d''erreur qui a interrompu l''écriture.';

                trigger OnAction();
                begin
                    Rec.ShowErrorMessage();
                end;
            }
            action(SetStatusToError)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Set Status to Error',
                            FRA = 'Définir le Statut sur Erreur';
                Image = DefaultFault;
                ToolTipML = ENU = 'Change the status of the entry.',
                            FRA = 'Modifiez le statut de l''écriture.';

                trigger OnAction();
                begin
                    if CONFIRM(JobQueueEntryRunningQst, false) then
                        Rec.MarkAsError();
                end;
            }
        }
    }

    trigger OnOpenPage();
    var
        JOBQueueEntry: Record "Job Queue Entry";
    begin
        //HEI.01>>
        // BC Upgrade SHUKLP03 >> TESTSCRIPT OTC008
        if Rec.FindSet() then
            repeat
                JOBQueueEntry.SETRANGE(ID, Rec.ID);
                if JOBQueueEntry.FINDFIRST() then
                    If JOBQueueEntry."Error Message" <> '' then begin
                        Rec."Error Message" := JOBQueueEntry."Error Message";
                        Rec.Status := Rec.Status::Error;
                        Rec.Modify();
                    end;
            until Rec.Next() = 0;

        // BC Upgrade SHUKLP03 << TESTSCRIPT OTC008
        //HEI.01<<
    end;

    var
        JobQueueEntryRunningQst: TextConst DEU = 'Dieser Posten der Aufgabenwarteschlange wird möglicherweise noch ausgeführt. Wenn Sie den Status jetzt auf "Fehler" setzen, wird er möglicherweise im Hintergrund weiter ausgeführt. Möchten Sie den Status wirklich auf "Fehler" setzen?', ENU = 'This job queue entry may be still running. If you set the status to Error, it may keep running in the background. Are you sure you want to set the status to Error?';
}

