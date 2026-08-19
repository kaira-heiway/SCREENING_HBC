tableextension 50175 IssuedReminderLineExtFND extends "Issued Reminder Line"
{
    // DITW17.10.05 AKH 10/02/2015 DIT-770 #1224 Updated Option Field "Document Type
    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP030 IBM ISYED01 04/07/2017
    //   #Added feilds Disputed, Disputed Reason code.
    // HEI.02 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.03 INC3970482 - CHG2146826 IBM NASTAA02 15.02.2022 # Reminder Letter gives error when tested with automated scripts on Algeria
    //   # Increased length of Field 'Disputed Reason code' from 10 to 20
    // version NAVW19.00,DITW18.00,HEI.03

    fields
    {
        modify("Reminder No.")
        {
            CaptionML = ENU = 'Reminder No.', FRA = 'N° relance';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Attached to Line No.")
        {
            CaptionML = ENU = 'Attached to Line No.', FRA = 'Attaché à la ligne n°';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = ' ,G/L Account,Customer Ledger Entry,Line Fee', FRA = ' ,Compte général,Écriture comptable client,Frais ligne';
        }
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("No. of Reminders")
        {
            CaptionML = ENU = 'No. of Reminders', FRA = 'Nombre de relances';
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
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 10)". Please convert manually.


            //Unsupported feature: Change Description on ""Document Type"(Field 10)". Please convert manually.

        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Original Amount")
        {
            CaptionML = ENU = 'Original Amount', FRA = 'Montant initial';
        }
        modify("Remaining Amount")
        {
            CaptionML = ENU = 'Remaining Amount', FRA = 'Montant ouvert';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Interest Rate")
        {
            CaptionML = ENU = 'Interest Rate', FRA = 'Taux d''intérêt';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
        }
        modify("VAT Calculation Type")
        {
            CaptionML = ENU = 'VAT Calculation Type', FRA = 'Mode calcul TVA';
            //OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("VAT Amount")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("VAT Identifier")
        {
            CaptionML = ENU = 'VAT Identifier', FRA = 'Identifiant TVA';
        }
        modify("Line Type")
        {
            CaptionML = ENU = 'Line Type', FRA = 'Type ligne';
            //OptionCaptionML = ENU = 'Reminder Line,Not Due,Beginning Text,Ending Text,Rounding,On Hold,Additional Fee,Line Fee', FRA = 'Ligne relance,Non échu,Texte début,Texte fin,Arrondi,En attente,Frais supplémentaires,Frais ligne';
        }
        modify("VAT Clause Code")
        {
            CaptionML = ENU = 'VAT Clause Code', FRA = 'Code clause TVA';
        }
        modify("Applies-To Document Type")
        {
            CaptionML = ENU = 'Applies-To Document Type', FRA = 'Type document lettrage';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
        }
        modify("Applies-To Document No.")
        {
            CaptionML = ENU = 'Applies-To Document No.', FRA = 'N° document lettrage';
        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = 'Écriture système';
        }
        field(50001; "Disputed FND"; Boolean)
        {
            Caption = 'Disputed';
            CalcFormula = Exist("Dispute Case FND" where("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                      Status = CONST(Open)));
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Disputed Reason code FND"; Code[20])
        {
            Caption = 'Disputed Reason code';
            Description = 'HEI.01,HEI.03';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        DisputeCase: Record "Dispute Case FND";
}

