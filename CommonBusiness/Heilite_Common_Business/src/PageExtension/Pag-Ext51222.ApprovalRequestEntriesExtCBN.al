pageextension 51222 ApprovalRequestEntriesExtCBN extends "Approval Request Entries"
{
    // version NAVW110.0,DITW110.00.08


    //   DITW15.00.00.32 DDR 17/03/2009 Added columns
    //                                   "Avail. Deposit Limit (LCY)"
    //                                   "Approver Avail. Cr.Limit (LCY)","Approver Avail Dp Limit (LCY)"
    //   DITW15.00.00.34 DDR 04/06/2009 Added SourceTableView property form

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW111.00.13A DDR 02/07/2019 NRQ#103938 Add field "Initiated By User ID"
    //   DITW111.00.13A DDR 19/07/2019 NRQ#103938 Add (NRQ#55906) field "Entry No.";"Overdue Balance","Overdue Period"
    //   DITW111.00.13A DDR 26/07/2019 NRQ#103941 Add field "W.Date-Time Sent for Approval"
    //   HEI.01 CHG2069321 GAVANM01 IBM 13.10.2020 #PowerApps Integration
    //     # New fields added: "Request Sent";"Response Received"
    //**************************************************//
    //BC UPGRADE SIVA //
    //1.HEI.01 Added fields on Page layout "Request Sent";"Response Received".
    //2 Commented Drink IT fields.
    
    // BC Upgrade MISHRS14 >>
    // HEI.02 CHG2336029 SS40 17.03.2026 # Workflow Approval Functionality for Stock Adjustments
    // # Added table filter "233" in "SourceTableView" Page Properties
    // SourceTableView is a property that can only be defined on the original Page object, not on a pageextension so not added here in code.
    // BC Upgrade MISHRS14 <<
    
    layout
    {
        modify(Overdue)
        {
            CaptionML = ENU = 'Overdue', FRA = 'Échu';
            ToolTipML = ENU = 'Specifies that the approval is overdue.', FRA = 'Spécifie que l''approbation est arrivée à échéance.';
        }
        modify("Table ID")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
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
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the approval status for the entry:', FRA = 'Spécifie le statut d''approbation pour l''écriture :';
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
        modify("Available Credit Limit (LCY)")
        {
            ToolTipML = ENU = 'Specifies the remaining credit (in LCY) that exists for the customer.', FRA = 'Spécifie le crédit restant (en DS) qui existe pour le client.';
        }
        //BC UPGRADE SIVA >> Drink IT fields 
        // addafter("Sequence No.")
        // {
        //     field("Initiated By User ID"; Rec."Initiated By User ID")
        //     {
        //         ApplicationArea = Suite;
        //     }
        // }
        // addafter("Date-Time Sent for Approval")
        // {
        //     field("W.Date-Time Sent for Approval"; Rec."W.Date-Time Sent for Approval")
        //     {
        //         ApplicationArea = Suite;
        //         Visible = false;
        //     }
        // }
        //BC UPGRADE SIVA << Drink IT fields 
        addafter("Available Credit Limit (LCY)")
        {
            //BC UPGRADE SIVA << Drink IT fields 
            // field("Approver Avail. Cr.Limit (LCY)"; Rec."Approver Avail. Cr.Limit (LCY)")
            // {
            //     ApplicationArea = all;
            // }
            // field(Substitute; Rec.Substitute)
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Response Received';
            // }
            // field("Approver Avail Dp Limit (LCY)"; Rec."Approver Avail Dp Limit (LCY)")
            // {
            //     ApplicationArea = all;
            // }
            // field("Overdue Balance"; Rec."Overdue Balance")
            // {
            //     ApplicationArea = Suite;
            //     Visible = false;
            // }
            // field("Overdue Period"; Rec."Overdue Period")
            // {
            //     ApplicationArea = Suite;
            //     Visible = false;
            //     ToolTip = 'Response Received';
            // }
            // field("Automatic Entry"; Rec."Automatic Entry")
            // {
            //     ApplicationArea = Suite;
            //     Visible = false;
            //     ToolTip = 'Response Received';
            // }
            //BC UPGRADE SIVA >> Drink IT fields 
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = Suite;
                ToolTip = 'Response Received';
            }
            field("Request Sent"; Rec."Request Sent FND")
            {
                ApplicationArea = all;
                ToolTip = 'Response Received';
            }
            field("Response Received"; Rec."Response Received FND")
            {
                ToolTip = 'Response Received';
                ApplicationArea = all;

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
            CaptionML = ENU = '&Delegate', FRA = '&Déléguer';
            ToolTipML = ENU = 'Delegate the approval request to another approver that has been set up as your substitute approver.', FRA = 'Déléguez la demande d''approbation à un autre approbateur défini comme remplaçant.';
        }


        //Unsupported feature: CodeModification on ""All Entries"(Action 40).OnAction". Please convert manually.

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
        //BC UPGRADE SIVA >> Drink IT code
        // addafter("O&verdue Entries")
        // {
        //     action("Approved Entries")
        //     {
        //         ApplicationArea = Suite;
        //         Caption = 'Approved Entries';
        //         Image = Approval;

        //         trigger OnAction();
        //         begin
        //             // <<DITW111.00.13A DDR 23/07/2019 NRQ#103941
        //             SETRANGE(Status);
        //             SETRANGE("Due Date");
        //             SETRANGE("Automatic Entry", false);
        //             // >>DITW111.00.13A DDR NRQ#103941
        //         end;
        //     }
        // }
        //BC UPGRADE SIVA << Drink IT code
    }


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Usersetup.GET(USERID) then
      if not Usersetup."Approval Administrator" then begin
        FILTERGROUP(2);
    #4..7

    SETRANGE(Status);
    SETRANGE("Due Date");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    // <<DITW111.00.13A DDR 23/07/2019 NRQ#103941
    SETRANGE("Automatic Entry",false);
    // >>DITW111.00.13A DDR NRQ#103941
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

