tableextension 50178 IssuedReminderHeaderExtFND extends "Issued Reminder Header"
{
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7

    // HEI.01 FDD-SLSGAP001 IBM LAZARE02 29.05.2018 # MDM Customer Card
    //   # Increased "Address" and "Address 2" fields length from 50 to 60 characters
    //   # Increased "City" field length from 30 to 35 characters
    // HEI.02 CHG2000416 IBM.AB 06.06.2019
    //   # New field Mail Sent is added
    // version NAVW110.0.00.16585,DITW110.00.08,HEI.01

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';

        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {

            //Unsupported feature: Change Data type on "Address(Field 5)". Please convert manually.

            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change Description on "Address(Field 5)". Please convert manually.

        }
        modify("Address 2")
        {

            //Unsupported feature: Change Data type on ""Address 2"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change Description on ""Address 2"(Field 6)". Please convert manually.

        }
        modify("Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(City)
        {

            //Unsupported feature: Change Data type on "City(Field 8)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change Description on "City(Field 8)". Please convert manually.

        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("Country/Region Code")
        {
            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify(Contact)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Your Reference")
        {
            CaptionML = ENU = 'Your Reference', FRA = 'Votre référence';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Customer Posting Group")
        {
            CaptionML = ENU = 'Customer Posting Group', FRA = 'Groupe compta. client';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Date d''échéance';
        }
        modify("Reminder Terms Code")
        {
            CaptionML = ENU = 'Reminder Terms Code', FRA = 'Code condition relance';
        }
        modify("Fin. Charge Terms Code")
        {
            CaptionML = ENU = 'Fin. Charge Terms Code', FRA = 'Code condition intérêts';
        }
        modify("Interest Posted")
        {
            CaptionML = ENU = 'Interest Posted', FRA = 'Intérêts calculés';
        }
        modify("Additional Fee Posted")
        {
            CaptionML = ENU = 'Additional Fee Posted', FRA = 'Frais supplémentaires calculés';
        }
        modify("Reminder Level")
        {
            CaptionML = ENU = 'Reminder Level', FRA = 'Niveau relance';
        }
        modify("Posting Description")
        {
            CaptionML = ENU = 'Posting Description', FRA = 'Libellé écriture';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Remaining Amount")
        {
            CaptionML = ENU = 'Remaining Amount', FRA = 'Montant ouvert';
        }
        modify("Interest Amount")
        {
            CaptionML = ENU = 'Interest Amount', FRA = 'Montant intérêts';
        }
        modify("Additional Fee")
        {
            CaptionML = ENU = 'Additional Fee', FRA = 'Frais supplémentaires';
        }
        modify("VAT Amount")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("No. Printed")
        {
            CaptionML = ENU = 'No. Printed', FRA = 'Nbre impressions';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Pre-Assigned No. Series")
        {
            CaptionML = ENU = 'Pre-Assigned No. Series', FRA = 'Souche de n° pré-attribués';
        }
        modify("Pre-Assigned No.")
        {
            CaptionML = ENU = 'Pre-Assigned No.', FRA = 'N° pré-attribués';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("Add. Fee per Line")
        {
            CaptionML = ENU = 'Add. Fee per Line', FRA = 'Frais supplémentaires par ligne';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        field(50000; "Mail Sent FND"; Boolean)
        {
            Caption = 'Mail Sent';
            Description = 'HEI.02';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "ReminderTxt(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReminderTxt : ENU=Issued Reminder;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReminderTxt : ENU=Issued Reminder;FRA=Relances émises;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SuppresSendDialogQst(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SuppresSendDialogQst : ENU=Do you want to suppress send dialog?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SuppresSendDialogQst : ENU=Do you want to suppress send dialog?;FRA=Souhaitez-vous supprimer la boîte de dialogue d'envoi ?;
    //Variable type has not been exported.
}

