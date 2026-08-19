tableextension 50037 CheckLedgerEntryExtFND extends "Check Ledger Entry"
{
    // version NAVW110.0,DITW110.00.09,HEI.01
    //     FINXL9.00.001 DAT 25/02/2016 : Extend field Description from 50 -> 80 chars

    // DITW17.00.02 SR 10/09/2013 DIT-770 #137 : Add options 'Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back' to "Document Type"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.02 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.03 HEI.05 CHG2052196 IBM.PANDES01 08.06.2020
    //   # Added Fields Approval status, Requester ID and Requester Date.

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Bank Account No.")
        {
            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';
        }
        modify("Bank Account Ledger Entry No.")
        {
            CaptionML = ENU = 'Bank Account Ledger Entry No.', FRA = 'N° écriture comptable compte bancaire';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 5)". Please convert manually.


            //Unsupported feature: Change Description on ""Document Type"(Field 5)". Please convert manually.

        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Check Date")
        {
            CaptionML = ENU = 'Check Date', FRA = 'Date chèque';
        }
        modify("Check No.")
        {
            CaptionML = ENU = 'Check No.', FRA = 'N° chèque';
        }
        modify("Check Type")
        {
            CaptionML = ENU = 'Check Type', FRA = 'Type chèque';
            OptionCaptionML = ENU = 'Total Check,Partial Check', FRA = 'Total,Partiel';
        }
        modify("Bank Payment Type")
        {
            CaptionML = ENU = 'Bank Payment Type', FRA = 'Mode émission paiement';
            //OptionCaptionML = ENU = ' ,Computer Check,Manual Check', FRA = ' ,Informatique,Manuel';
        }
        modify("Entry Status")
        {
            CaptionML = ENU = 'Entry Status', FRA = 'Etat du chèque';
            OptionCaptionML = ENU = ',Printed,Voided,Posted,Financially Voided,Test Print', FRA = ',Imprimé,Annulé,Enregistré,Annulé financièrement,Impression test';
        }
        modify("Original Entry Status")
        {
            CaptionML = ENU = 'Original Entry Status', FRA = 'Etat initial de l''écriture';
            OptionCaptionML = ENU = ' ,Printed,Voided,Posted,Financially Voided', FRA = ' ,Imprimé,Annulé,Enregistré,Annulé financièrement';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            // OptionCaptionML = ENU = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset', FRA = 'Général,Client,Fournisseur,Banque,Immobilisation';
        }
        modify("Bal. Account No.")
        {

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 16)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify(Open)
        {
            CaptionML = ENU = 'Open', FRA = 'Ouvert';
        }
        modify("Statement Status")
        {
            CaptionML = ENU = 'Statement Status', FRA = 'Etat du relevé';
            OptionCaptionML = ENU = 'Open,Bank Acc. Entry Applied,Check Entry Applied,Closed', FRA = 'Ouvert,Rapproché sur compte bancaire,Rapproché sur compte chèque,Fermé';
        }
        modify("Statement No.")
        {

            //Unsupported feature: Change TableRelation on ""Statement No."(Field 19)". Please convert manually.

            CaptionML = ENU = 'Statement No.', FRA = 'N° relevé';
        }
        modify("Statement Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Statement Line No."(Field 20)". Please convert manually.

            CaptionML = ENU = 'Statement Line No.', FRA = 'N° ligne relevé';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("Data Exch. Entry No.")
        {
            CaptionML = ENU = 'Data Exch. Entry No.', FRA = 'N° écriture échange données';
        }
        modify("Data Exch. Voided Entry No.")
        {
            CaptionML = ENU = 'Data Exch. Voided Entry No.', FRA = 'N° écriture échange données annulé';
        }
        modify("Positive Pay Exported")
        {
            CaptionML = ENU = 'Positive Pay Exported', FRA = 'Positive Pay exporté';
        }
        //BC Upgrade POENAB02 >>
        /*
        modify("Record ID to Print")
        {
            CaptionML = ENU = 'Record ID to Print', FRA = 'ID d''enregistrement à imprimer';
        }        
        */
        modify("Print Gen Jnl Line SystemId")
        {
            CaptionML = ENU = 'SystemId to Print', FRA = 'ID de système à imprimer';
        }
        //BC Upgrade POENAB02 <<
        field(50000; "WHT Amount FND"; Decimal)
        {
            Caption = 'WHT Amount';
            Description = 'HEI.01';
        }
        field(50001; "Approval Status FND"; Option)
        {
            Description = 'HEI.03';
            Caption = 'Approval Status';
            OptionMembers = " ","Awaiting approval",Approved,Rejected;
        }
        field(50002; "Requester ID FND"; Code[50])
        {
            Description = 'HEI.03';
            Caption = 'Requester ID';
        }
        field(50003; "Request Date FND"; Date)
        {
            Description = 'HEI.03';
            Caption = 'Request Date';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "NothingToExportErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NothingToExportErr : ENU=There is nothing to export.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NothingToExportErr : ENU=There is nothing to export.;FRA=Il n'y a rien à exporter.;
    //Variable type has not been exported.
}

