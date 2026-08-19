tableextension 50174 ReminderLineExtFND extends "Reminder Line"
{
    // DITW17.10.05 AKH 10/02/2015 DIT-770 #1224 Updated Option Field "Document Type"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP030 IBM ISYED01 04/07/2017
    //   # added code to update reason code on reminder lines on entry no trigger.
    // HEI.02 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.03 INC3970482 - CHG2146826 IBM NASTAA02 15.02.2022 # Reminder Letter gives error when tested with automated scripts on Algeria
    //   # Increased length of Field 'Disputed Reason code' from 10 to 20
    // version NAVW110.0,DITW110.00.08,HEI.03
    //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 13-11-2025 #HEI.01 custom code on-Entry No. - OnValidate() trigger  so for this Event subscribed-OnAfterCopyFromCustLedgEntry in Heineken Table Cu.
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
        modify("Applies-to Document Type")
        {
            CaptionML = ENU = 'Applies-to Document Type', FRA = 'Type document lettrage';
            //OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement';
        }
        modify("Applies-to Document No.")
        {
            CaptionML = ENU = 'Applies-to Document No.', FRA = 'N° document lettrage';
        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = 'Écriture système';
        }

        //Unsupported feature: CodeModification on ""Entry No."(Field 5).OnValidate". Please convert manually.

        //trigger "(Field 5)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::"Customer Ledger Entry");
        GetReminderHeader;
        CustLedgEntry.GET("Entry No.");
        #4..17
        "Original Amount" := CustLedgEntry.Amount;
        "Remaining Amount" := CustLedgEntry."Remaining Amount";
        "No. of Reminders" := GetNoOfReminderForCustLedgEntry("Entry No.");

        CalcFinChrg;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..20
        //HEI.01>>
        DisputeCase.SETRANGE(DisputeCase."Cust. Ledger Entry No.","Entry No.");
        DisputeCase.SETRANGE(DisputeCase.Status,DisputeCase.Status::Open);
        if DisputeCase.FINDFIRST then
          "Disputed Reason code" := DisputeCase."Reason Code";
        //HEI.01>>

        CalcFinChrg;
        */
        //end;
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
            Editable = false;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "MustBeSameErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MustBeSameErr : ENU=The %1 on the %2 and the %3 must be the same.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MustBeSameErr : ENU=The %1 on the %2 and the %3 must be the same.;FRA=Le %1 du %2 et du %3 doivent être identiques.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "MustBeErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MustBeErr : ENU=%1 must be %2 or %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MustBeErr : ENU=%1 must be %2 or %3.;FRA=%1 doit être %2 ou %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "NoOpenEntriesErr(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NoOpenEntriesErr : @@@="%1 = Table name, %2 = Document Type, %3 = Document No.";ENU=There is no open %1 with %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoOpenEntriesErr : @@@="%1 = Table name, %2 = Document Type, %3 = Document No.";ENU=There is no open %1 with %2 %3.;FRA=Il n'existe aucun(e) %1 ouvert(e) avec %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "EntryNotOverdueErr(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //EntryNotOverdueErr : @@@="%1 = Document Type, %2 = Document No., %3 = Table name";ENU=%1 %2 in %3 is not overdue.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //EntryNotOverdueErr : @@@="%1 = Document Type, %2 = Document No., %3 = Table name";ENU=%1 %2 in %3 is not overdue.;FRA=%1 %2 dans %3 n'est pas échu.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "LineFeeAlreadyIssuedErr(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //LineFeeAlreadyIssuedErr : @@@="%1 = Document TYpe, %2 = Document No, %3 = Level number";ENU=The line fee for %1 %2 on reminder level %3 has already been issued.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LineFeeAlreadyIssuedErr : @@@="%1 = Document TYpe, %2 = Document No, %3 = Level number";ENU=The line fee for %1 %2 on reminder level %3 has already been issued.;FRA=Les frais ligne pour %1 %2 sur le niveau relance %3 ont déjà été émis.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "MustBePositiveErr(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MustBePositiveErr : ENU=%1 must be positive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MustBePositiveErr : ENU=%1 must be positive.;FRA=%1 doit être positif/ve.;
    //Variable type has not been exported.

    var
        DisputeCase: Record "Dispute Case FND";
}

