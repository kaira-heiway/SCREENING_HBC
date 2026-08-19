tableextension 50221 PaymentExportDataExtFND extends "Payment Export Data"
{

    //   HEI.01 PURGAP05 IBM LAZARE02 31.07.2017 # Extend Recipient Address to 60

    // BC Upgrade KUMARS145 Table Ext.
    // BC Upgrade KUMARS145 Recipient Address has a length of 100 in BC.

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Data Exch Entry No.")
        {
            CaptionML = ENU = 'Data Exch Entry No.', FRA = 'N° écriture échange données';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Data Exch. Line Def Code")
        {
            CaptionML = ENU = 'Data Exch. Line Def Code', FRA = 'Code déf. ligne échange données';
        }
        modify("General Journal Template")
        {
            CaptionML = ENU = 'General Journal Template', FRA = 'Modèle feuille comptabilité';
        }
        modify("General Journal Batch Name")
        {
            CaptionML = ENU = 'General Journal Batch Name', FRA = 'Nom feuille comptabilité';
        }
        modify("General Journal Line No.")
        {
            CaptionML = ENU = 'General Journal Line No.', FRA = 'N° ligne feuille comptabilité';
        }
        modify("Sender Bank Name - Data Conv.")
        {
            CaptionML = ENU = 'Sender Bank Name - Data Conv.', FRA = 'Nom banque émetteur - Conv. données';
        }
        modify("Sender Bank Name")
        {
            CaptionML = ENU = 'Sender Bank Name', FRA = 'Nom banque émetteur';
        }
        modify("Sender Bank Account Code")
        {
            CaptionML = ENU = 'Sender Bank Account Code', FRA = 'Code cpte bancaire émetteur';
        }
        modify("Sender Bank Account No.")
        {
            CaptionML = ENU = 'Sender Bank Account No.', FRA = 'N° cpte bancaire émetteur';
        }
        modify("Sender Bank Account Currency")
        {
            CaptionML = ENU = 'Sender Bank Account Currency', FRA = 'Devise compte bancaire émetteur';
        }
        modify("Sender Bank Country/Region")
        {
            CaptionML = ENU = 'Sender Bank Country/Region', FRA = 'Pays/région banque émetteur';
        }
        modify("Sender Bank BIC")
        {
            CaptionML = ENU = 'Sender Bank BIC', FRA = 'BIC banque émetteur';
        }
        modify("Sender Bank Clearing Std.")
        {
            CaptionML = ENU = 'Sender Bank Clearing Std.', FRA = 'Std compensation bancaire émetteur';
        }
        modify("Sender Bank Clearing Code")
        {
            CaptionML = ENU = 'Sender Bank Clearing Code', FRA = 'Code compensation bancaire émetteur';
        }
        modify("Sender Bank Address")
        {
            CaptionML = ENU = 'Sender Bank Address', FRA = 'Adresse banque émetteur';
        }
        modify("Sender Bank City")
        {
            CaptionML = ENU = 'Sender Bank City', FRA = 'Ville banque émetteur';
        }
        modify("Sender Bank Post Code")
        {
            CaptionML = ENU = 'Sender Bank Post Code', FRA = 'Code postal banque émetteur';
        }
        modify("Recipient Name")
        {
            CaptionML = ENU = 'Recipient Name', FRA = 'Nom destinataire';
        }
        modify("Recipient Address")
        {
            //Unsupported feature: Change Data type on ""Recipient Address"(Field 41)". Please convert manually.
            CaptionML = ENU = 'Recipient Address', FRA = 'Adresse destinataire';
        }
        modify("Recipient City")
        {
            CaptionML = ENU = 'Recipient City', FRA = 'Ville destinataire';
        }
        modify("Recipient Post Code")
        {
            CaptionML = ENU = 'Recipient Post Code', FRA = 'Code postal destinataire';
        }
        modify("Recipient Country/Region Code")
        {
            CaptionML = ENU = 'Recipient Country/Region Code', FRA = 'Code pays/région destinataire';
        }
        modify("Recipient Email Address")
        {
            CaptionML = ENU = 'Recipient Email Address', FRA = 'Adresse messagerie destinataire';
        }
        modify("Recipient ID")
        {
            CaptionML = ENU = 'Recipient ID', FRA = 'ID destinataire';
        }
        modify("Recipient Bank Clearing Std.")
        {
            CaptionML = ENU = 'Recipient Bank Clearing Std.', FRA = 'Std compensation bancaire destinataire';
        }
        modify("Recipient Bank Clearing Code")
        {
            CaptionML = ENU = 'Recipient Bank Clearing Code', FRA = 'Code compensation bancaire destinataire';
        }
        modify("Recipient Reg. No.")
        {
            CaptionML = ENU = 'Recipient Reg. No.', FRA = 'N° enreg. destinataire';
        }
        modify("Recipient Acc. No.")
        {
            CaptionML = ENU = 'Recipient Acc. No.', FRA = 'N° cpte destinataire';
        }
        modify("Recipient Bank Acc. No.")
        {
            CaptionML = ENU = 'Recipient Bank Acc. No.', FRA = 'N° cpte bancaire destinataire';
        }
        modify("Recipient Bank BIC")
        {
            CaptionML = ENU = 'Recipient Bank BIC', FRA = 'BIC banque destinataire';
        }
        modify("Recipient Bank Name")
        {
            CaptionML = ENU = 'Recipient Bank Name', FRA = 'Nom banque destinataire';
        }
        modify("Recipient Bank Address")
        {
            CaptionML = ENU = 'Recipient Bank Address', FRA = 'Adresse banque destinataire';
        }
        modify("Recipient Bank City")
        {
            CaptionML = ENU = 'Recipient Bank City', FRA = 'Ville banque destinataire';
        }
        modify("Recipient Bank Country/Region")
        {
            CaptionML = ENU = 'Recipient Bank Country/Region', FRA = 'Pays/région banque destinataire';
        }
        modify("Recipient Creditor No.")
        {
            CaptionML = ENU = 'Recipient Creditor No.', FRA = 'N° créditeur destinataire';
        }
        modify("Recipient Bank Post Code")
        {
            CaptionML = ENU = 'Recipient Bank Post Code', FRA = 'Code postal banque destinataire';
        }
        modify("Message Type")
        {
            CaptionML = ENU = 'Message Type', FRA = 'Type communication';
        }
        modify("Letter to Sender")
        {
            CaptionML = ENU = 'Letter to Sender', FRA = 'Lettre à l''émetteur';
        }
        modify("Recipient Acknowledgement")
        {
            CaptionML = ENU = 'Recipient Acknowledgement', FRA = 'Approbation destinataire';
        }
        modify("Short Advice")
        {
            CaptionML = ENU = 'Short Advice', FRA = 'Avis bref';
        }
        modify("Message to Recipient 1")
        {
            CaptionML = ENU = 'Message to Recipient 1', FRA = 'Message au destinataire 1';
        }
        modify("Message to Recipient 2")
        {
            CaptionML = ENU = 'Message to Recipient 2', FRA = 'Message au destinataire 2';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Transfer Date")
        {
            CaptionML = ENU = 'Transfer Date', FRA = 'Date transfert';
        }
        modify("Transfer Type")
        {
            CaptionML = ENU = 'Transfer Type', FRA = 'Type transfert';
        }
        modify("Payment Type")
        {
            CaptionML = ENU = 'Payment Type', FRA = 'Type de règlement';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Recipient Reference")
        {
            CaptionML = ENU = 'Recipient Reference', FRA = 'Référence destinataire';
        }
        modify("Payment Reference")
        {
            CaptionML = ENU = 'Payment Reference', FRA = 'Référence paiement';
        }
        modify("Invoice Amount")
        {
            CaptionML = ENU = 'Invoice Amount', FRA = 'Montant facture';
        }
        modify("Invoice Date")
        {
            CaptionML = ENU = 'Invoice Date', FRA = 'Date facture';
        }
        modify("Recipient County")
        {
            CaptionML = ENU = 'Recipient County', FRA = 'Région destinataire';
        }
        modify("Recipient Bank County")
        {
            CaptionML = ENU = 'Recipient Bank County', FRA = 'Région banque destinataire';
        }
        modify("Sender Bank County")
        {
            CaptionML = ENU = 'Sender Bank County', FRA = 'Région banque émetteur';
        }
        modify("Payment Information ID")
        {
            CaptionML = ENU = 'Payment Information ID', FRA = 'ID informations paiement';
        }
        modify("End-to-End ID")
        {
            CaptionML = ENU = 'End-to-End ID', FRA = 'ID bout en bout';
        }
        modify("Message ID")
        {
            CaptionML = ENU = 'Message ID', FRA = 'ID message';
        }
        modify("SEPA Instruction Priority")
        {
            CaptionML = ENU = 'SEPA Instruction Priority', FRA = 'Priorité instruction SEPA';
            OptionCaptionML = ENU = 'NORMAL,HIGH', FRA = 'NORMALE,HAUTE';
        }
        modify("SEPA Instruction Priority Text")
        {
            CaptionML = ENU = 'SEPA Instruction Priority Text', FRA = 'Texte priorité instruction SEPA';
        }
        modify("SEPA Payment Method")
        {
            CaptionML = ENU = 'SEPA Payment Method', FRA = 'Mode de règlement SEPA';
            OptionCaptionML = ENU = 'CHK,TRF,TRA', FRA = 'CHK,TRF,TRA';
        }
        modify("SEPA Payment Method Text")
        {
            CaptionML = ENU = 'SEPA Payment Method Text', FRA = 'Texte mode de règlement SEPA';
        }
        modify("SEPA Batch Booking")
        {
            CaptionML = ENU = 'SEPA Batch Booking', FRA = 'Réservation lot SEPA';
        }
        modify("SEPA Charge Bearer")
        {
            CaptionML = ENU = 'SEPA Charge Bearer', FRA = 'Personne prenant en charge les frais SEPA';
            OptionCaptionML = ENU = 'DEBT,CRED,SHAR,SLEV', FRA = 'DEBT,CRED,SHAR,SLEV';
        }
        modify("SEPA Charge Bearer Text")
        {
            CaptionML = ENU = 'SEPA Charge Bearer Text', FRA = 'Texte personne prenant en charge les frais SEPA';
        }
        modify("SEPA Direct Debit Mandate ID")
        {
            CaptionML = ENU = 'SEPA Direct Debit Mandate ID', FRA = 'ID mandat de domiciliation européenne SEPA';
        }
        modify("SEPA Direct Debit Seq. Type")
        {
            CaptionML = ENU = 'SEPA Direct Debit Seq. Type', FRA = 'Type encaiss. domiciliation européenne SEPA';
            OptionCaptionML = ENU = 'One Off,First,Recurring,Last', FRA = 'Unique,Premier,Récurrent,Dernier';
        }
        modify("SEPA Direct Debit Seq. Text")
        {
            CaptionML = ENU = 'SEPA Direct Debit Seq. Text', FRA = 'Texte encaiss. domiciliation européenne SEPA';
        }
        modify("SEPA DD Mandate Signed Date")
        {
            CaptionML = ENU = 'SEPA DD Mandate Signed Date', FRA = 'Date signature mandat domic. europ. SEPA';
        }
        modify("SEPA Partner Type")
        {
            CaptionML = ENU = 'SEPA Partner Type', FRA = 'Type partenaire SEPA';
            //OptionCaptionML = ENU = ' ,Company,Person', FRA = ' ,Société,Personne';
        }
        modify("SEPA Partner Type Text")
        {
            CaptionML = ENU = 'SEPA Partner Type Text', FRA = 'Texte type partenaire SEPA';
        }
        modify("Importing Code")
        {
            CaptionML = ENU = 'Importing Code', FRA = 'Importation code';
        }
        modify("Importing Date")
        {
            CaptionML = ENU = 'Importing Date', FRA = 'Importation date';
        }
        modify("Importing Description")
        {
            CaptionML = ENU = 'Importing Description', FRA = 'Importation libellé';
        }
        modify("Costs Distribution")
        {
            CaptionML = ENU = 'Costs Distribution', FRA = 'Distribution des coûts';
        }
        modify("Message Structure")
        {
            CaptionML = ENU = 'Message Structure', FRA = 'Structure message';
        }
        modify("Own Address Info.")
        {
            CaptionML = ENU = 'Own Address Info.', FRA = 'Info adresse personnelle';
        }
        modify("Creditor No.")
        {
            CaptionML = ENU = 'Creditor No.', FRA = 'N° créditeur';
        }
        modify("Transit No.")
        {
            CaptionML = ENU = 'Transit No.', FRA = 'N° interne';
        }
        modify("Applies-to Ext. Doc. No.")
        {
            CaptionML = ENU = 'Applies-to Ext. Doc. No.', FRA = 'N° ligne doc. ext. lettrage';
        }
        modify("Format Command")
        {
            CaptionML = ENU = 'Format Command', FRA = 'Commande Mettre en forme';
        }
        modify("Format Remittance Info Type")
        {
            CaptionML = ENU = 'Format Remittance Info Type', FRA = 'Mettre en forme type info remise';
        }
        modify("Format Payment Type")
        {
            CaptionML = ENU = 'Format Payment Type', FRA = 'Mettre en forme mode paiement';
        }
        modify("Format Expense Code")
        {
            CaptionML = ENU = 'Format Expense Code', FRA = 'Mettre en forme code dépense';
        }
        modify("Format Text Code")
        {
            CaptionML = ENU = 'Format Text Code', FRA = 'Mettre en forme code texte';
        }
        modify("Format Form Type")
        {
            CaptionML = ENU = 'Format Form Type', FRA = 'Mettre en forme type formulaire';
        }
    }
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
}

