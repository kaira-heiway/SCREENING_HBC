pageextension 51069 DocumentSendingProfileExtCBN extends "Document Sending Profile"
{
    //    HEI.01 FDD-LB-GAPLOG04 IBM NASTAA02 25.07.2018 # Order Confirmation Almaza, Proforma Invoice and Export Invoice
    //   # New Fields added: "Std Text Code Proforma Inv F", "Std Text Code Export Inv F",
    //     "Std Text Code Proforma Inv H", "Std Text Code Export Inv H", "Bank"
    //   # Fasttab created "Drink-It"
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code to identify the document sending method in the system.', FRA = 'Spécifie un code permettant d''identifier la méthode d''envoi du document dans le système.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the document sending format.', FRA = 'Spécifie le format d''envoi du document.';
        }
        modify(Default)
        {
            ToolTipML = ENU = 'Specifies if this document sending method will be used as the default method for all customers.', FRA = 'Spécifie si cette méthode d''envoi de document sera utilisée comme méthode par défaut pour tous les clients.';
        }
        modify("Sending Options")
        {
            CaptionML = ENU = 'Sending Options', FRA = 'Options d''envoi';
        }
        modify(Printer)
        {
            ToolTipML = ENU = 'Specifies if and how the document is printed when you choose the Post and Send button. If you choose the Yes (Prompt for Settings) option, the document is printed according to settings that you must make on the printer setup dialog.', FRA = 'Spécifie si et comment le document est imprimé lorsque vous choisissez le bouton Valider et envoyer. Si vous sélectionnez l''option Oui (Afficher une invite pour le réglage des paramètres), le document est imprimé en fonction des réglages que vous devez apporter dans la boîte de dialogue de configuration de l''imprimante.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies if and how the document is attached as a PDF file to an email to the involved customer when you choose the Post and Send button. If you choose the Yes (Prompt for Settings) option, the document is attached to an email according to settings that you must make in the Send Email window.', FRA = 'Spécifie si et comment le document est joint en tant que fichier PDF dans un e-mail pour le client concerné lorsque vous choisissez le bouton Valider et envoyer. Si vous sélectionnez l''option Oui (Afficher une invite pour le réglage des paramètres), le document est joint dans un e-mail en fonction des réglages que vous devez apporter dans la fenêtre Envoyer e-mail.';
        }
        modify("E-Mail Format")
        {
            CaptionML = ENU = 'Format', FRA = 'Format';
        }
        modify(Disk)
        {
            ToolTipML = ENU = 'Specify if the document is saved as a PDF file when you choose the Post and Send button.', FRA = 'Spécifiez si le document est enregistré au format PDF lorsque vous sélectionnez le bouton Valider et envoyer.';
        }
        modify("Disk Format")
        {
            CaptionML = ENU = 'Format', FRA = 'Format';
        }
        modify("Electronic Document")
        {
            ToolTipML = ENU = 'Specifies if the document is sent as an electronic document that the customer can import into their system when you choose the Post and Send button. To use this option, you must also fill the Electronic Format field. Alternatively, the file can be saved to disk.', FRA = 'Spécifie si le document est envoyé sous un format électronique que le client peut importer dans son système lorsque vous choisissez le bouton Valider et envoyer. Pour utiliser cette option, vous devez également renseigner le champ Format électronique. Le fichier peut sinon être enregistré sur un disque.';
        }
        modify("Electronic Format")
        {
            CaptionML = ENU = 'Format', FRA = 'Format';
            ToolTipML = ENU = 'Specifies which format to use for electronic document sending. You must fill this field if you selected the Silent option in the Electronic Document field.', FRA = 'Spécifie quel format utiliser pour l''envoi de document électronique. Vous devez renseigner ce champ si vous avez sélectionné l''option de silence dans le champ Document électronique.';
        }
        addafter("Sending Options")
        {
            group(DrinkIt)
            {
                Caption = 'Drink-It';
                field("Std Text Code Proforma Inv F"; Rec."Std Text CodeProformaInv F FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Std Text Code Proforma Inv Footer field.';
                }
                field("Std Text Code Export Inv F"; Rec."Std Text Code Export Inv F FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Std Text Code Export Inv Footer field.';
                }
                field("Std Text Code Proforma Inv H"; Rec."Std Text CodeProformaInv H FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Std Text Code Proforma Inv Header field.';
                }
                field("Std Text Code Export Inv H"; Rec."Std Text Code Export Inv H FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Std Text Code Export Inv Header field.';
                }
                field(Bank; Rec."Bank FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Bank field.';
                }
            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

