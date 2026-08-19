tableextension 50166 ApprovalEntryExtFND extends "Approval Entry"
{
    //     DITW15.00.00.32 DDR 26/03/2009 Added fields
    //                                  70021 Deposit Amount
    //                                  70024 Deposit Amount (LCY)
    //                                  70027 Avail. Deposit Limit (LCY)
    //                                  70032 Approver Avail. Cr.Limit (LCY)
    //                                  70033 Approver Avail Dp Limit (LCY)
    //                                  70090 Substitute (flowfield)
    // DITW15.00.00.33 DDR 08/05/2009 Added fields
    //                                  2014451 Substitue
    //                     04/06/2009 Added fields
    //                                  2013815 Reference Line No.
    //                                Added optionstring for field "Document Type"
    //                                Added key
    //                                  "Table ID,Document Type,Document No.,Reference Line No.,Sequence No."
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 MVN 02/10/2015 DIT-770 #1524 Added Option "Deposit Limits" to Field19 "Limit Type"
    // DITW18.00.06A DDR 23/11/2015 DIT-770 #1714 Added option "Overdue Limits" to Field19 "Limit Type"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 28/12/2017 NRQ#9570 Added Option To Field Approval type

    // DITW111.00.13 MSF 03/09/2018 NRQ#55906 Sales Approval Workflow for Overdue and deposit limit
    //                                  Added Option To Approval Type : Approver (Deposit limit),Approver (Overdue Limit)
    //                                  Added fields 2014447 Overdue Balance
    //                                               2014447 OverDue Period
    // DITW111.00.13 MSF 18/09/2018 NRQ#55906 change caption Available Approver Deposit Credit Limit (LCY) ==> Avail. Deposit Limit (LCY)

    // HEI.01 FDD PTPGAP084 IBM POSTOI01 19.04.2018
    //   # add new code on RecordDetails function
    // HEI.02 FDD-PURGAP027 IBM NASTAA02 04.06.2019 # Maximo POs approval flow
    //   # New Field 50000 - "PQ Approver" created to store the PQ Approver
    // DITW111.00.13A DDR 02/07/2019 NRQ#103938 Add field 2014410 Initiated By User ID
    // DITW111.00.13A DDR 19/07/2019 NRQ#103938 Add description tag
    // DITW111.00.13A DDR 23/07/2019 NRQ#103941 Add field 2014411 Automatic Entry
    // DITW111.00.13A DDR 26/07/2019 NRQ#103941 Add field 2014412 W.Date-Time Sent for Approval
    // DITW114.00.15 DDR 25/06/2020 NRQ#149486 Add key "Table ID,Document Type,Document No.,Status"
    // HEI.03 CHG2069321 GAVANM01 IBM 13.10.2020 #PowerApps Integration
    //   # New fields added: 50001 - "Request Sent"; 50002 - "Response Received"
    fields
    {
        modify("Table ID")
        {
            CaptionML = ENU = 'Table ID', FRA = 'ID table';
        }
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,,,,,,,,,,Discount,Promotion', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour,,,,,,,,,,Remise,Promotion';

            //Unsupported feature: Change OptionString on ""Document Type"(Field 2)". Please convert manually.


            //Unsupported feature: Change Description on ""Document Type"(Field 2)". Please convert manually.

        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Sequence No.")
        {
            CaptionML = ENU = 'Sequence No.', FRA = 'N° séq.';
        }
        modify("Approval Code")
        {
            CaptionML = ENU = 'Approval Code', FRA = 'Code approbation';
        }
        modify("Sender ID")
        {
            CaptionML = ENU = 'Sender ID', FRA = 'ID émetteur';
        }
        modify("Salespers./Purch. Code")
        {
            CaptionML = ENU = 'Salespers./Purch. Code', FRA = 'Code vendeur/acheteur';
        }
        modify("Approver ID")
        {
            CaptionML = ENU = 'Approver ID', FRA = 'ID approbateur';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            //OptionCaptionML = ENU = 'Created,Open,Canceled,Rejected,Approved', FRA = 'Créé,Ouvert,Annulé,Rejeté,Approuvé';
        }
        modify("Date-Time Sent for Approval")
        {
            CaptionML = ENU = 'Date-Time Sent for Approval', FRA = 'Date-heure envoi pour approbation';
        }
        modify("Last Date-Time Modified")
        {
            CaptionML = ENU = 'Last Date-Time Modified', FRA = 'Date-heure dernière modification';
        }
        modify("Last Modified By User ID")
        {
            CaptionML = ENU = 'Last Modified By User ID', FRA = 'Dernière modification par ID utilisateur';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Date d''échéance';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Amount (LCY)")
        {
            CaptionML = ENU = 'Amount (LCY)', FRA = 'Montant DS';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Approval Type")
        {
            CaptionML = ENU = 'Approval Type', FRA = 'Type approbation';
            //OptionCaptionML = ENU = 'Workflow User Group,Sales Pers./Purchaser,Approver,,,,,,Approver (Credit limit),Approver (Deposit limit),Approver (Overdue Limit)', FRA = 'Groupe d''utilisateurs du flux de travail,Vendeur/Acheteur,Approbateur,,,,,,Approver (Credit limit),Approver (Deposit limit),Approver (Overdue Limit)';

            //Unsupported feature: Change OptionString on ""Approval Type"(Field 18)". Please convert manually.


            //Unsupported feature: Change Description on ""Approval Type"(Field 18)". Please convert manually.

        }
        modify("Limit Type")
        {
            CaptionML = ENU = 'Limit Type', FRA = 'Type limite';
            //OptionCaptionML = ENU = 'Approval Limits,Credit Limits,Request Limits,No Limits,Deposit Limits,Overdue Limits', FRA = 'Limites approbation,Limites crédit,Limites demande,Aucune limite,Limites Consigne,Limites Echues';

            //Unsupported feature: Change OptionString on ""Limit Type"(Field 19)". Please convert manually.


            //Unsupported feature: Change Description on ""Limit Type"(Field 19)". Please convert manually.

        }
        modify("Available Credit Limit (LCY)")
        {
            CaptionML = ENU = 'Available Credit Limit (LCY)', FRA = 'Limite crédit disponible DS';
        }
        modify("Pending Approvals")
        {
            CaptionML = ENU = 'Pending Approvals', FRA = 'Approbations en attente';
        }
        modify("Record ID to Approve")
        {
            CaptionML = ENU = 'Record ID to Approve', FRA = 'ID d''enregistrement à approuver';
        }
        modify("Delegation Date Formula")
        {
            CaptionML = ENU = 'Delegation Date Formula', FRA = 'Formule date délégation';
        }
        modify("Number of Approved Requests")
        {
            CaptionML = ENU = 'Number of Approved Requests', FRA = 'Nombre de demandes approuvées';
        }
        modify("Number of Rejected Requests")
        {
            CaptionML = ENU = 'Number of Rejected Requests', FRA = 'Nombre de demandes rejetées';
        }
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Workflow Step Instance ID")
        {
            CaptionML = ENU = 'Workflow Step Instance ID', FRA = 'ID instance d''étape de flux de travail';
        }
        modify("Related to Change")
        {
            CaptionML = ENU = 'Related to Change', FRA = 'Modification liée';
        }

        //Unsupported feature: CodeModification on "Status(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if (xRec.Status = Status::Created) and (Status = Status::Open) then
          "Date-Time Sent for Approval" := CREATEDATETIME(TODAY,TIME);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec.Status = Status::Created) and (Status = Status::Open) then
          "Date-Time Sent for Approval" := CREATEDATETIME(TODAY,TIME);
        // <<DITW111.00.13A DDR 26/07/2019 NRQ#103941
        if (xRec.Status = Status::Created) and (Status = Status::Open) then
          "W.Date-Time Sent for Approval" := CREATEDATETIME(WORKDATE,TIME);
        // >>DITW111.00.13A DDR NRQ#103941
        */
        //end;
        field(50000; "PQ Approver FND"; Code[50])
        {
            Caption = 'PQ Approver';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50001; "Request Sent FND"; Boolean)
        {
            Caption = 'Request Sent';
            Description = 'HEI.03';
            Editable = false;
        }
        field(50002; "Response Received FND"; Boolean)
        {
            Caption = 'Response Received';
            Description = 'HEI.03';
            Editable = false;
        }

        //BC UPgrade SHARMP16 begin>> Commented Drink-IT fields.
        // field(2013624;"Deposit Amount";Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Deposit Amount',
        //                 FRA='Montant consigne';
        //     Description = 'DITW15.00.00.32 DDR';
        // }
        // field(2013625;"Deposit Amount (LCY)";Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU='Deposit Amount (LCY)',
        //                 FRA='Montant de la caution DS';
        //     Description = 'DITW15.00.00.32 DDR';
        // }
        // field(2013626;"Approver Avail Dp Limit (LCY)";Decimal)
        // {
        //     CaptionML = ENU='Available Approver Deposit Limit (LCY)',
        //                 FRA='Limite de crédit consigne disponible par approbateur DS';
        //     Description = 'DITW15.00.00.32 DDR-NRQ#55906';
        // }
        // field(2013627;"Avail. Deposit Limit (LCY)";Decimal)
        // {
        //     CaptionML = ENU='Available Deposit Limit (LCY)',
        //                 FRA='Limite de crédit consigne disponible DS';
        //     Description = 'DITW15.00.00.32 DDR-NRQ#55906';
        // }
        // field(2013815;"Reference Line No.";Integer)
        // {
        //     CaptionML = ENU='Reference Line No.',
        //                 FRA='N° de ligne référence';
        //     Description = 'DITW15.00.00.34';
        // }
        // field(2014410;"Initiated By User ID";Code[50])
        // {
        //     Caption = 'Initiated By User ID';
        //     Description = 'DITW111.00.13A NRQ#103938';
        //     TableRelation = User."User Name";
        //     //This property is currently not supported
        //     //TestTableRelation = false;

        //     trigger OnLookup();
        //     begin
        //         UserMgt.LookupUserID("Initiated By User ID");
        //     end;
        // }
        // field(2014411;"Automatic Entry";Boolean)
        // {
        //     Caption = 'Automatic Entry';
        //     Description = 'DITW111.00.13A NRQ#103941';
        // }
        // field(2014412;"W.Date-Time Sent for Approval";DateTime)
        // {
        //     Caption = 'Date-Time (Workdate) Sent for Approval';
        //     Description = 'DITW111.00.13A NRQ#103941';
        // }
        // field(2014445;"Approver Avail. Cr.Limit (LCY)";Decimal)
        // {
        //     CaptionML = ENU='Available Approver Credit Limit (LCY)',
        //                 FRA='Limite de crédit disponible par approbateur DS';
        //     Description = 'DITW15.00.00.32 DDR';
        // }
        // field(2014446;Substitute;Code[50])
        // {
        //     CalcFormula = Lookup("User Setup".Substitute WHERE ("User ID"=FIELD("Approver ID")));
        //     CaptionML = ENU='Substitute',
        //                 FRA='Remplaçant';
        //     Description = 'DITW15.00.00.33 DDR';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "User Setup";
        // }
        // field(2014447;"Overdue Balance";Decimal)
        // {
        //     Caption = 'OverDue Balance';
        //     Description = 'NRQ#55906';
        // }
        // field(2014448;"Overdue Period";Date)
        // {
        //     Caption = 'Overdue Period';
        //     Description = 'NRQ#55906';
        // }
        //BC UPgrade SHARMP16 end<< Commented Drink-IT fields.
    }
    keys
    {
        //BC Upgrade SHARMP16 Commented Keys becuase of Drink-It fields used in Keys begin>>
        // key(Key1; "Table ID", "Document Type", "Document No.", "Reference Line No.", "Sequence No.")
        // {
        // }
        // key(Key2; "Table ID", "Document Type", "Document No.", Status)
        // {
        // }
        //BC Upgrade SHARMP16 Commented Keys becuase of Drink-It fields used in Keys end<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        WorkflowRule: Record "Workflow Rule";
        WorkStepArgument: Record "Workflow Step Argument";
        WorkStepInstance: Record "Workflow Step Instance";


    //Unsupported feature: PropertyModification on "RecNotExistTxt(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RecNotExistTxt : ENU=The record does not exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RecNotExistTxt : ENU=The record does not exist.;FRA=L'enregistrement n'existe pas.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ChangeRecordDetailsTxt(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ChangeRecordDetailsTxt : @@@="Prefix = Record information %1 = field caption %2 = old value %3 = new value. Example: Customer 123455; Credit Limit changed from 100.00 to 200.00";ENU="; %1 changed from %2 to %3";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChangeRecordDetailsTxt : @@@="Prefix = Record information %1 = field caption %2 = old value %3 = new value. Example: Customer 123455; Credit Limit changed from 100.00 to 200.00";ENU="; %1 changed from %2 to %3";FRA="; %1 modifié de %2 en %3";
    //Variable type has not been exported.
}

