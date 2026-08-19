pageextension 51226 IssuedReminderListExtCBN extends "Issued Reminder List"
{
    // version NAVW110.0
    //     # Issue 440 HEILITE BASE IBM ISYED01 10/10/2017
    //   # added "User Id" to the page.
    // HEI.01 RFC-CHG2000416 IBM.LS 30.07.2019
    //   # Added code to Print Dunning Letters based on Reminder Level.
    // HEI.03 FDD-HT1203 IBM KUMARN15 27.05.2020
    //   # Hidden property change for action Print Dunning Letter

    // BC Upgrade SHUKLP03 >> Added application area, action and oninit code of Nav moved to onopenpage trigger.

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the issued reminder number.', FRA = 'Spécifie le numéro de relance émise.';
        }
        modify("Customer No.")
        {
            ToolTipML = ENU = 'Specifies the customer number the reminder is for.', FRA = 'Spécifie le numéro du client à qui s''adresse la relance.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the customer the reminder is for.', FRA = 'Spécifie le nom du client à qui s''adresse la relance.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code of the issued reminder.', FRA = 'Spécifie le code devise de la relance émise.';
        }
        modify("Remaining Amount")
        {
            ToolTipML = ENU = 'Specifies the total of the remaining amounts on the reminder lines.', FRA = 'Spécifie le total des montants ouverts sur les lignes relance.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the reminder has been printed.', FRA = 'Spécifie combien de fois la relance a été imprimée.';
        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify(City)
        {
            ToolTipML = ENU = 'Specifies the city name of the customer the reminder is for.', FRA = 'Spécifie le nom de la ville du client à qui s''adresse la relance.';

            //Unsupported feature: Change ImplicitType on "City(Control 14)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the reminder.', FRA = 'Spécifie le code section analytique associée à la relance.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the reminder.', FRA = 'Spécifie le code section analytique associée à la relance.';
        }
        addafter("Post Code")
        {
            field("Reminder Level"; Rec."Reminder Level")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            field("Mail Sent"; Rec."Mail Sent FND")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("&Reminder")
        {
            CaptionML = ENU = '&Reminder', FRA = '&Relance';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("C&ustomer")
        {
            CaptionML = ENU = 'C&ustomer', FRA = '&Client';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            ToolTipML = ENU = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.', FRA = 'Préparez-vous à imprimer le document. La fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        modify("Send by &Email")
        {
            CaptionML = ENU = 'Send by &Email', FRA = 'Envoyer par &e-mail';
            ToolTipML = ENU = 'Prepare to send the document by email. The Send Email window opens prefilled for the customer where you can add or change information before you send the email.', FRA = 'Préparez-vous à envoyer le document par e-mail. La fenêtre Envoyer e-mail s''ouvre préremplie pour le client pour que vous puissiez ajouter ou modifier des informations avant d''envoyer l''e-mail.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
        modify("Reminder Nos.")
        {
            CaptionML = ENU = 'Reminder Nos.', FRA = 'N° relance';
        }
        modify("Customer - Balance to Date")
        {
            CaptionML = ENU = 'Customer - Balance to Date', FRA = 'Clients : Écritures ouvertes';
        }
        modify("Customer - Detail Trial Bal.")
        {
            CaptionML = ENU = 'Customer - Detail Trial Bal.', FRA = 'Clients : Grand livre client';
        }
        addfirst(processing)
        {
            action("&Print Dunning Letter")
            {
                CaptionML = ENU = '&Print Dunning Letter',
                            FRA = '&Imprimer';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTipML = ENU = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.',
                            FRA = 'Préparez-vous à imprimer le document. La fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
                Visible = ShowPrintDunningLetter;
                ApplicationArea = All;

                trigger OnAction();
                var
                    IssuedReminderHeaderL: Record "Issued Reminder Header";
                    DunningLetter1: Report "Dunning Letter 1";
                    DunningLetter2: Report "Dunning Letter 2";
                    DunningLetter3: Report "Dunning Letter 3";
                begin
                    //HEI.01>>
                    CurrPage.SETSELECTIONFILTER(IssuedReminderHeaderL);
                    IssuedReminderHeaderL.SETRANGE("No.", Rec."No.");
                    if IssuedReminderHeaderL.FIND('-') then begin
                        if IssuedReminderHeaderL."Reminder Level" = 1 then begin
                            DunningLetter1.SETTABLEVIEW(IssuedReminderHeaderL);
                            DunningLetter1.RUNMODAL;
                        end;

                        if IssuedReminderHeaderL."Reminder Level" = 2 then begin
                            DunningLetter2.SETTABLEVIEW(IssuedReminderHeaderL);
                            DunningLetter2.RUNMODAL;
                        end;

                        if IssuedReminderHeaderL."Reminder Level" = 3 then begin
                            DunningLetter3.SETTABLEVIEW(IssuedReminderHeaderL);
                            DunningLetter3.RUNMODAL;
                        end;
                    end;
                    //HEI.01<<
                end;
            }
        }
    }

    var
        ShowPrintDunningLetter: Boolean;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";

    trigger OnOpenPage()
    var
    begin
        //<< HEI.03
        SalesReceivablesSetup.GET;
        ShowPrintDunningLetter := NOT SalesReceivablesSetup."Skip Custom Reminder Logic FND";
        //>> HEI.03
    end;



}

