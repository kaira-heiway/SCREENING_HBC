pageextension 51123 ApprovalEntriesExtCBN extends "Approval Entries"
{
    //     DITW15.00.00.32 DDR 26/03/2009 Added columns
    //                                 "Approver Avail. Cr.Limit (LCY)","Substitue"
    //                                 "Deposit Amount (LCY)","Avail. Deposit Limit (LCY)",
    //                                 "Approver Avail Dp Limit (LCY)"
    //                                Block the Approve button with Approver Available limits
    //                                Convert global variable 'Overdue' (option -> boolean)
    // DITW15.00.00.33 DDR 07/05/2009 Bugfix enable/disable 'Approve' button
    // DITW15.00.00.34 DDR 04/06/2009 Added filter to show only sales & purchase tables
    // DITW15.00.00.37 DDR 18/01/2010 issue 1042 SQL-NAV Conflict Case-Sensitive USERID
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0010.1
    //                             added extended approval
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW111.00.13 MSF 18/09/2018 NRQ#55906 Remove Fields "Approver Avail Dp Limit (LCY)"
    //                                                      "Approver Avail. Cr.Limit (LCY)"
    // DITW111.00.13A DDR 02/07/2019 NRQ#103938 Add field "Initiated By User ID"
    // DITW111.00.13A DDR 19/07/2019 NRQ#103938 Add (NRQ#55906) field "Entry No.";"Overdue Balance","Overdue Period"
    // DITW111.00.13A DDR 23/07/2019 NRQ#103941 Add "Approved Entries" ribbon-button
    // DITW111.00.13A DDR 26/07/2019 NRQ#103941 Add field "W.Date-Time Sent for Approval"
    // HEI.01 CHG2069321 GAVANM01 IBM 13.10.2020 #PowerApps Integration
    //   # New fields added: "Request Sent";"Response Received"
    // HEI.02 CHG2049056 IBM.LS      08.07.2021
    //   # Added Field - Workflow Step Instance ID
    // HEI.03 RITM2738652 IBM NANDIS01 01.11.2021 # StP Automation Test Script
    //   #Added Read permission on Delegate button's property - AccessByPermission
    // HEI.04 CHG2172864 IBM NANDIS01 09.09.2022 # Workflow - Delegate function
    //   # Taking HEI.03(RITM2738652) to production against this corrective chnage; No code changes in this tag

    layout
    {
        modify(Overdue)
        {
            CaptionML = ENU = 'Overdue', FRA = 'Échu';
            ToolTipML = ENU = 'Specifies that the approval is overdue.', FRA = 'Spécifie que l''approbation est arrivée à échéance.';

            //Unsupported feature: Change ImplicitType on "Overdue(Control 40)". Please convert manually.

        }
        modify("Table ID")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Limit Type")
        {
            ToolTipML = ENU = 'Specifies the type of limit that applies to the approval template:', FRA = 'Spécifie le type de limite applicable au modèle d''approbation :';
        }
        modify("Approval Type")
        {
            ToolTipML = ENU = 'Specifies which approvers apply to this approval template:', FRA = 'Spécifie les approbateurs qui s''appliquent à ce modèle d''approbation :';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the type of document that an approval entry has been created for. Approval entries can be created for six different types of sales or purchase documents:', FRA = 'Spécifie le type de document pour lequel une écriture approbation a été créée. Les écritures approbation peuvent être créées pour six différents types de documents vente ou achat :';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number copied from the relevant sales or purchase document, such as a purchase order or a sales quote.', FRA = 'Spécifie le numéro du document copié depuis le document vente ou achat approprié, tel qu''une commande achat ou un devis.';
        }
        modify(RecordIDText)
        {
            CaptionML = ENU = 'To Approve', FRA = 'ž approuver';
            ToolTipML = ENU = 'Specifies the record that you are requested to approve.', FRA = 'Spécifie l''enregistrement que vous devez approuver.';
        }
        modify("Sequence No.")
        {
            ToolTipML = ENU = 'Specifies the order of approvers when an approval workflow involves more than one approver.', FRA = 'Spécifie l''ordre des approbateurs lorsqu''un flux de travail approbation implique plusieurs approbateurs.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the approval status for the entry:', FRA = 'Spécifie le statut d''approbation pour l''écriture :';
        }
        modify("Sender ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who sent the approval request for the document to be approved.', FRA = 'Spécifie le code de l''utilisateur qui a envoyé la demande d''approbation pour le document à approuver.';
        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies the code for the salesperson or purchaser that was in the document to be approved. It is not a mandatory field, but is useful if a salesperson or a purchaser responsible for the customer/vendor needs to approve the document before it is processed.', FRA = 'Spécifie le code du vendeur ou de l''acheteur dans le document à approuver. Il n''est pas obligatoire, mais il est utile si un vendeur ou un acheteur responsable pour le client/fournisseur doit approuver le document avant qu''il ne soit traité.';
        }
        modify("Approver ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who must approve the document (the Approver).', FRA = 'Spécifie le code de l''utilisateur qui doit approuver le document (l''Approbateur).';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the code of the currency of the amounts on the sales or purchase lines.', FRA = 'Spécifie le code de la devise des montants des lignes vente ou achat.';
        }
        modify("Amount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the total amount (excl. VAT) on the document awaiting approval. The amount is stated in the local currency.', FRA = 'Spécifie le montant total (hors TVA) du document en attente d''approbation. Le montant est exprimé dans la devise société.';
        }
        modify("Available Credit Limit (LCY)")
        {
            ToolTipML = ENU = 'Specifies the remaining credit (in LCY) that exists for the customer.', FRA = 'Spécifie le crédit restant (en DS) qui existe pour le client.';

            //Unsupported feature: Change Description on ""Available Credit Limit (LCY)"(Control 47)". Please convert manually.

        }
        modify("Date-Time Sent for Approval")
        {
            ToolTipML = ENU = 'Specifies the date and the time that the document was sent for approval.', FRA = 'Spécifie la date et l''heure auxquelles le document a été envoyé pour approbation.';
        }
        modify("Last Date-Time Modified")
        {
            ToolTipML = ENU = 'Specifies the date when the approval entry was last modified. If, for example, the document approval is canceled, this field will be updated accordingly.', FRA = 'Spécifie la date à laquelle l''écriture approbation a été modifiée pour la dernière fois. Si l''approbation du document est annulée, ce champ est mis à jour en conséquence.';
        }
        modify("Last Modified By User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who last modified the approval entry. If, for example, the document approval is canceled, this field will be updated accordingly.', FRA = 'Spécifie l''ID de l''utilisateur qui a modifié l''écriture approbation pour la dernière fois. Si l''approbation du document est annulée, ce champ est mis à jour en conséquence.';
        }
        modify(Comment)
        {
            ToolTipML = ENU = 'Specifies whether there are comments relating to the approval of the record. If you want to read the comments, choose the field to open the Approval Comment Sheet window.', FRA = 'Indique s''il existe des commentaires relatifs à l''approbation de l''enregistrement. Pour lire les commentaires, choisissez le champ pour ouvrir la fenêtre Feuille de commentaires d''approbation.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the record must be approved, by one or more approvers.', FRA = 'Indique la date à laquelle l''enregistrement doit être approuvé et par qui.';
        }
        //BC Upgrade SHARMP16 - commented Drink-IT field begin>>>>
        // addafter("Approver ID")
        // {
        //     field("Pending Approvals"; Rec."Pending Approvals")
        //     {
        //     }
        //     field(Substitute; Rec.Substitute)
        //     {
        //         DrillDown = false;
        //         Lookup = false;
        //     }
        // }
        // addafter("Amount (LCY)")
        // {
        //     field("Deposit Amount (LCY)"; Rec."Deposit Amount (LCY)")
        //     {
        //     }
        // }
        // addafter("Available Credit Limit (LCY)")
        // {
        //     field("Avail. Deposit Limit (LCY)"; Rec."Avail. Deposit Limit (LCY)")
        //     {
        //     }
        //     field("Overdue Balance"; Rec."Overdue Balance")
        //     {
        //         ApplicationArea = Suite;
        //     }
        //     field("Overdue Period"; Rec."Overdue Period")
        //     {
        //         ApplicationArea = Suite;
        //         Visible = false;
        //     }
        // }
        // addafter("Date-Time Sent for Approval")
        // {
        //     field("W.Date-Time Sent for Approval"; Rec."W.Date-Time Sent for Approval")
        //     {
        //         ApplicationArea = Suite;
        //         Visible = false;
        //     }
        //     field("Initiated By User ID"; Rec."Initiated By User ID")
        //     {
        //         ApplicationArea = Suite;
        //     }
        // }
        //BC Upgrade SHARMP16 - commented Drink-IT field end<<<<
        addafter("Due Date")
        {
            // field("Automatic Entry"; Rec."Automatic Entry")
            // {
            //     ApplicationArea = Suite;
            //     Visible = false;
            // }//BC Upgrade SHARMP16 commented Drink-IT field
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = basic, Suite;
                ToolTip = 'Specifies the value of the Entry No. field.';
            }
            field("Workflow Step Instance ID"; Rec."Workflow Step Instance ID")
            {
                ApplicationArea = basic, Suite;
                ToolTip = 'Specifies the value of the Workflow Step Instance ID field.';
            }
            field("Request Sent"; Rec."Request Sent FND")
            {
                ApplicationArea = basic, Suite;
                ToolTip = 'Specifies the value of the Request Sent field.';
            }
            field("Response Received"; Rec."Response Received FND")
            {
                ApplicationArea = basic, Suite;
                ToolTip = 'Specifies the value of the Response Received field.';
            }
        }
    }
    actions
    {
        modify("&Show")
        {
            CaptionML = ENU = '&Show', FRA = '&Afficher';
        }
        modify("Record")
        {
            CaptionML = ENU = 'Record', FRA = 'Enregistrement';
            ToolTipML = ENU = 'Open the document, journal line, or card that the approval request is for.', FRA = 'Ouvrez le document, la ligne feuille ou la fiche pour laquelle l''approbation est demandée.';
        }
        modify(Comments)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
            ToolTipML = ENU = 'View or add comments.', FRA = 'Affichez ou ajoutez des commentaires.';
        }
        modify("O&verdue Entries")
        {
            CaptionML = ENU = 'O&verdue Entries', FRA = 'Écritures é&chues';
            ToolTipML = ENU = 'View approval requests that are overdue.', FRA = 'Affichez les demandes d''approbation qui sont échues.';
        }
        modify("All Entries")
        {
            CaptionML = ENU = 'All Entries', FRA = 'Toutes les écritures';
            ToolTipML = ENU = 'View all approval entries.', FRA = 'Affichez toutes les écritures d''approbation.';
        }
        modify("&Delegate")
        {

            //Unsupported feature: Change AccessByPermission on ""&Delegate"(Action 35)". Please convert manually.

            CaptionML = ENU = '&Delegate', FRA = '&Déléguer';
            ToolTipML = ENU = 'Delegate the approval request to another approver that has been set up as your substitute approver.', FRA = 'Déléguez la demande d''approbation à un autre approbateur défini comme remplaçant.';
        }


        //Unsupported feature: CodeModification on ""All Entries"(Action 50).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SETRANGE(Status);
        SETRANGE("Due Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SETRANGE(Status);
        SETRANGE("Due Date");
        // <<DITW111.00.13A DDR 23/07/2019 NRQ#103941
        SETRANGE("Automatic Entry");
        // >>DITW111.00.13A DDR NRQ#103941
        */
        //end;

        addafter("O&verdue Entries")
        {
            action("Approved Entries")
            {
                ApplicationArea = Suite;
                Caption = 'Approved Entries';
                Image = Approval;
                ToolTip = 'Executes the Approved Entries action.';

                trigger OnAction();
                begin
                    // <<DITW111.00.13A DDR 23/07/2019 NRQ#103941
                    // Rec.SETRANGE(Status);//BC Upgrade SHARMP16 Drink-IT code.
                    // Rec.SETRANGE("Due Date");//BC Upgrade SHARMP16 Drink-IT field code.
                    //rec.SETRANGE("Automatic Entry", false);//BC Upgrade SHARMP16 Drink-IT field used.
                    // >>DITW111.00.13A DDR NRQ#103941
                end;
            }
        }
    }


    //Unsupported feature: PropertyModification on "Overdue(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Overdue : Option;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Overdue : Boolean;
    //Variable type has not been exported.

    var
        _Overdue: Option Yes," ";

    var

        ApproveEnable: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowChangeFactBox := CurrPage.Change.PAGE.SetFilterFromApprovalEntry(Rec);
    DelegateEnable := CanCurrentUserEdit;
    ShowRecCommentsEnabled := RecRef.GET("Record ID to Approve");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3

    // <<DITW15.00.00.32 DDR 23/03/2009 - DITW15.00.00.33 DDR 07/05/2009
    ApproveEnable :=
      (Status = Status::Open) and
      (USERID = "Approver ID") and
      ((("Approver Avail. Cr.Limit (LCY)"+"Approver Avail Dp Limit (LCY)") >= 0) or
       ("Limit Type" <> "Limit Type"::"Approval Limits") or
       (Usersetup."Unlimited Sales Approval" and ("Limit Type" = "Limit Type"::"Approval Limits")) or
       (Usersetup."Unlimited Purchase Approval" and ("Limit Type"= "Limit Type"::"Approval Limits")) or
       (Usersetup."Unlimited Request Approval" and ("Limit Type" = "Limit Type"::"Request Limits")) or
       (Usersetup."Unlimited Cr. Limit Customer" and ("Limit Type" = "Limit Type"::"Credit Limits")));
    // >>DITW15.00.00.33 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Overdue := Overdue::" ";
    if FormatField(Rec) then
      Overdue := Overdue::Yes;

    RecordIDText := FORMAT("Record ID to Approve",0,1);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.32 DDR 26/03/2009
    //Overdue := Overdue::" ";
    Overdue := false;
    // >>DITW15.00.00.32 DDR
    if FormatField(Rec) then
      // <<DITW15.00.00.32 DDR 26/03/2009
      //Overdue := Overdue::Yes;
      Overdue := true;
      // >>DITW15.00.00.32 DDR

    RecordIDText := FORMAT("Record ID to Approve",0,1);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.34 DDR 04/06/2009
    ApproveEnable := true;
    // >>DITW15.00.00.34 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Usersetup.GET(USERID) then
      SETCURRENTKEY("Table ID","Document Type","Document No.");
    MarkAllWhereUserisApproverOrSender;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW111.00.13A DDR 23/07/2019 NRQ#103941
    FILTERGROUP(0);
    SETRANGE("Automatic Entry",false);
    // >>DITW111.00.13A DDR NRQ#103941
    */
    //end;


    //Unsupported feature: CodeModification on "CalledFrom(PROCEDURE 3)". Please convert manually.

    //procedure CalledFrom();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Overdue := Overdue::" ";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.32 DDR 26/03/2009
    //Overdue := Overdue::" ";
    Overdue := true;
    // >>DITW15.00.00.32 DDR
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

