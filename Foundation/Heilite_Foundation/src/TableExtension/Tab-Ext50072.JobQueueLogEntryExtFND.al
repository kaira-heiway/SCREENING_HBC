tableextension 50072 JobQueueLogEntryExtFND extends "Job Queue Log Entry"
{
    // version NAVW110.0,FINXL9.00.000.01,HEI.01
    // FINXL9.00.001 MTR 14/09/2016 : Added key for "Object ID to Run"
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1

    // HEI.01 FDD-GAPID001 IBM LAZARE02 05.10.2017 # New fields used to manage job queue entries in error state
    // HEI.02 CHG2010375 IBM.LS 21.01.2020
    //   # New Field created: 50001 - "Send Document"
    //   # New Field created: 50002 - "JQ Posted"
    //   # New Field created: 50003 - "JQ Mail Sent"
    //   # New Field created: 50004 - "JQ Printed"
    //   # New Field created: 50005 - "Document Type"
    //   # New Field created: 50006 - "Document No."
    //   # New Field created: 50007 - "Posted Document No."
    // HEI.03 CHG2010375 IBM.LS 12.02.2020
    //   # New Field created: 50008 - "JQ Logistics Mail Sent"
    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify(ID)
        {
            CaptionML = ENU = 'ID', FRA = 'ID';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Start Date/Time")
        {
            CaptionML = ENU = 'Start Date/Time', FRA = 'Date/heure début';
        }
        modify("End Date/Time")
        {
            CaptionML = ENU = 'End Date/Time', FRA = 'Date/heure fin';
        }
        modify("Object Type to Run")
        {
            CaptionML = ENU = 'Object Type to Run', FRA = 'Type objet à exécuter';
            OptionCaptionML = ENU = ',,,Report,,Codeunit', FRA = ',,,Report,,Codeunit';
        }
        modify("Object ID to Run")
        {
            CaptionML = ENU = 'Object ID to Run', FRA = 'ID objet à exécuter';
        }
        modify("Object Caption to Run")
        {

            //Unsupported feature: Change CalcFormula on ""Object Caption to Run"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Object Caption to Run', FRA = 'Légende de l''objet à exécuter';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            OptionCaptionML = ENU = 'Success,In Process,Error', FRA = 'Succès,En cours,Erreur';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
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
        // }
        // modify("Processed by User ID")
        // {
        //     CaptionML = ENU = 'Processed by User ID', FRA = 'Traité par Code utilisateur';
        // }  // BC Upgrade NANDIS03
        modify("Job Queue Category Code")
        {
            CaptionML = ENU = 'Job Queue Category Code', FRA = 'Code catégorie de la file d''attente des travaux';
        }
        field(50000; "Notification Sent FND"; Boolean)
        {
            Caption = 'Notification Sent';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50001; "Send Document FND"; Option)
        {
            CaptionML = ENU = 'Send Document',
                        FRA = 'Envoyer Document';
            Description = 'HEI.02';
            Editable = false;
            OptionCaptionML = ENU = ' ,Mail,Print,Mail & Print',
                              FRA = ' ,E-Mail,Imprimer,E-Mail & Imprimer';
            OptionMembers = " ",Mail,Print,"Mail & Print";
        }
        field(50002; "JQ Posted FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'JQ Posted';
            Editable = false;
        }
        field(50003; "JQ Mail Sent FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'JQ Mail Sent';
            Editable = false;
        }
        field(50004; "JQ Printed FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'JQ Printed';
            Editable = false;
        }
        field(50005; "Document Type FND"; Enum "Sales Document Type")
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            Description = 'HEI.02';
            Editable = false;
            // OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
            //                   FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
            // OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50006; "Document No. FND"; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        FRA = 'N°';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50007; "Posted Document No. FND"; Code[20])
        {
            Description = 'HEI.02';
            Caption = 'Posted Document No.';
            Editable = false;
            TableRelation = IF ("JQ Posted FND" = CONST(true),
                                "Document Type FND" = FILTER(Order | Invoice)) "Sales Invoice Header"
            else IF ("JQ Posted FND" = CONST(true),
                                         "Document Type FND" = FILTER("Credit Memo" | "Return Order")) "Sales Cr.Memo Header";
        }
        field(50008; "JQ Logistics Mail Sent FND"; Boolean)
        {
            Description = 'HEI.03';
            Caption = 'JQ Logistics Mail Sent';
            Editable = false;
        }
    }
    keys
    {
        // key(Key1; "Object ID to Run")
        // {
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    // var
    //     TextMgt: Codeunit TextManagement;  // BC Upgrade NANDIS03

    // var
    //     TextMgt: Codeunit TextManagement;  // BC Upgrade NANDIS03


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=There is no error message.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=There is no error message.;FRA=Absence de message d'erreur.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Are you sure that you want to delete job queue log entries?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Are you sure that you want to delete job queue log entries?;FRA=Voulez-vous vraiment supprimer les écritures du journal de la file d'attente des travaux ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Marked as Error by %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Marked as Error by %1.;FRA=Marqué comme erreur par %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Only entries with status In Progress can be marked as Error.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Only entries with status In Progress can be marked as Error.;FRA=Seules les écritures dont le statut est En cours peuvent être marquées comme Erreur.;
    //Variable type has not been exported.
}

