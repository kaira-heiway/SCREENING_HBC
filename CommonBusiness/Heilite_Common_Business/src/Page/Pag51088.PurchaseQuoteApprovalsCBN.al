page 51088 "Purchase Quote Approvals CBN"
{
    // version NAVW110.0,DITW111.00.13A

    // HEI.01 CHG2088708 IBM PANDES01 15-12-2020
    //  # New page created Purchase Quote Approvals
    //----------------------------------------------------------------------------------
    //BC upgrade SHARMP16-- Commented Drink-IT code and related fields.

    CaptionML = ENU = 'Approval Entries',
                FRA = 'Écritures approbation';
    Editable = false;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Approval Entry";
    SourceTableView = sorting("Record ID to Approve", "Workflow Step Instance ID", "Sequence No.")
                      ORDER(Ascending);
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Overdue; Overdue)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Overdue',
                                FRA = 'Échu';
                    Editable = false;
                    ToolTipML = ENU = 'Specifies that the approval is overdue.',
                                FRA = 'Spécifie que l''approbation est arrivée à échéance.';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTipML = ENU = 'This field is used internally.',
                                FRA = 'Ce champ est utilisé en interne.';
                    Visible = false;
                }
                field("Limit Type"; Rec."Limit Type")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the type of limit that applies to the approval template:',
                                FRA = 'Spécifie le type de limite applicable au modèle d''approbation :';
                }
                field("Approval Type"; Rec."Approval Type")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies which approvers apply to this approval template:',
                                FRA = 'Spécifie les approbateurs qui s''appliquent à ce modèle d''approbation :';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTipML = ENU = 'Specifies the type of document that an approval entry has been created for. Approval entries can be created for six different types of sales or purchase documents:',
                                FRA = 'Spécifie le type de document pour lequel une écriture approbation a été créée. Les écritures approbation peuvent être créées pour six différents types de documents vente ou achat :';
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTipML = ENU = 'Specifies the document number copied from the relevant sales or purchase document, such as a purchase order or a sales quote.',
                                FRA = 'Spécifie le numéro du document copié depuis le document vente ou achat approprié, tel qu''une commande achat ou un devis.';
                    Visible = false;
                }
                field(RecordIDText; RecordIDText)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'To Approve',
                                FRA = 'ž approuver';
                    ToolTipML = ENU = 'Specifies the record that you are requested to approve.',
                                FRA = 'Spécifie l''enregistrement que vous devez approuver.';
                }
                field(Details; Rec.RecordDetails())
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the value of the RecordDetails() field.';
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the order of approvers when an approval workflow involves more than one approver.',
                                FRA = 'Spécifie l''ordre des approbateurs lorsqu''un flux de travail approbation implique plusieurs approbateurs.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the approval status for the entry:',
                                FRA = 'Spécifie le statut d''approbation pour l''écriture :';
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the ID of the user who sent the approval request for the document to be approved.',
                                FRA = 'Spécifie le code de l''utilisateur qui a envoyé la demande d''approbation pour le document à approuver.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code for the salesperson or purchaser that was in the document to be approved. It is not a mandatory field, but is useful if a salesperson or a purchaser responsible for the customer/vendor needs to approve the document before it is processed.',
                                FRA = 'Spécifie le code du vendeur ou de l''acheteur dans le document à approuver. Il n''est pas obligatoire, mais il est utile si un vendeur ou un acheteur responsable pour le client/fournisseur doit approuver le document avant qu''il ne soit traité.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the ID of the user who must approve the document (the Approver).',
                                FRA = 'Spécifie le code de l''utilisateur qui doit approuver le document (l''Approbateur).';
                }
                field("Pending Approvals"; Rec."Pending Approvals")
                {
                    ToolTip = 'Specifies the value of the Pending Approvals field.';
                }
                // field(Substitute; Rec.Substitute)
                // {
                //     DrillDown = false;
                //     Lookup = false;
                // }//BC Upgrade SHARMP16 Drink-IT fields
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code of the currency of the amounts on the sales or purchase lines.',
                                FRA = 'Spécifie le code de la devise des montants des lignes vente ou achat.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the total amount (excl. VAT) on the document awaiting approval. The amount is stated in the local currency.',
                                FRA = 'Spécifie le montant total (hors TVA) du document en attente d''approbation. Le montant est exprimé dans la devise société.';
                }
                // field("Deposit Amount (LCY)"; Rec."Deposit Amount (LCY)")
                // {
                // }//BC Upgrade SHARMP16 Drink-IT field
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                    ApplicationArea = Suite;
                    Description = 'NRQ#55906';
                    ToolTipML = ENU = 'Specifies the remaining credit (in LCY) that exists for the customer.',
                                FRA = 'Spécifie le crédit restant (en DS) qui existe pour le client.';
                }
                // field("Avail. Deposit Limit (LCY)"; Rec."Avail. Deposit Limit (LCY)")
                // {
                // }//BC Upgrade SHARMP16 Drink-IT field
                // field("Overdue Balance"; Rec."Overdue Balance")
                // {
                //     ApplicationArea = Suite;
                // }//BC Upgrade SHARMP16 Drink-IT field
                // field("Overdue Period"; Rec."Overdue Period")
                // {
                //     ApplicationArea = Suite;
                //     Visible = false;
                // }//BC Upgrade SHARMP16 Drink-IT field
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the date and the time that the document was sent for approval.',
                                FRA = 'Spécifie la date et l''heure auxquelles le document a été envoyé pour approbation.';
                }
                // field("W.Date-Time Sent for Approval"; Rec."W.Date-Time Sent for Approval")
                // {
                //     ApplicationArea = Suite;
                //     Visible = false;
                // }//BC Upgrade SHARMP16 Drink-IT field
                // field("Initiated By User ID"; Rec."Initiated By User ID")
                // {
                //     ApplicationArea = Suite;
                // }//BC Upgrade SHARMP16 Drink-IT field
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the date when the approval entry was last modified. If, for example, the document approval is canceled, this field will be updated accordingly.',
                                FRA = 'Spécifie la date à laquelle l''écriture approbation a été modifiée pour la dernière fois. Si l''approbation du document est annulée, ce champ est mis à jour en conséquence.';
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the ID of the user who last modified the approval entry. If, for example, the document approval is canceled, this field will be updated accordingly.',
                                FRA = 'Spécifie l''ID de l''utilisateur qui a modifié l''écriture approbation pour la dernière fois. Si l''approbation du document est annulée, ce champ est mis à jour en conséquence.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies whether there are comments relating to the approval of the record. If you want to read the comments, choose the field to open the Approval Comment Sheet window.',
                                FRA = 'Indique s''il existe des commentaires relatifs à l''approbation de l''enregistrement. Pour lire les commentaires, choisissez le champ pour ouvrir la fenêtre Feuille de commentaires d''approbation.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies when the record must be approved, by one or more approvers.',
                                FRA = 'Indique la date à laquelle l''enregistrement doit être approuvé et par qui.';
                }
                // field("Automatic Entry"; Rec."Automatic Entry")
                // {
                //     ApplicationArea = Suite;
                //     Visible = false;
                // }//BC Upgrade SHARMP16 Drink-IT field
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
            }
        }
        area(factboxes)
        {
            part(Change; "Workflow Change List FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                UpdatePropagation = SubPart;
                Visible = ShowChangeFactBox;
            }
            systempart(Control5; Links)
            {
                Visible = false;
            }
            systempart(Control4; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                CaptionML = ENU = '&Show',
                            FRA = '&Afficher';
                Image = View;
                action("Record")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Record',
                                FRA = 'Enregistrement';
                    Enabled = ShowRecCommentsEnabled;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTipML = ENU = 'Open the document, journal line, or card that the approval request is for.',
                                FRA = 'Ouvrez le document, la ligne feuille ou la fiche pour laquelle l''approbation est demandée.';

                    trigger OnAction();
                    begin
                        rec.ShowRecord();
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Comments',
                                FRA = 'Commentaires';
                    Enabled = ShowRecCommentsEnabled;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTipML = ENU = 'View or add comments.',
                                FRA = 'Affichez ou ajoutez des commentaires.';

                    trigger OnAction();
                    var
                        //  ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                    begin
                        RecRef.GET(rec."Record ID to Approve");
                        //    ApprovalsMgmt.GetApprovalComment(RecRef);
                    end;
                }
                action("O&verdue Entries")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'O&verdue Entries',
                                FRA = 'Écritures é&chues';
                    Image = OverdueEntries;
                    ToolTipML = ENU = 'View approval requests that are overdue.',
                                FRA = 'Affichez les demandes d''approbation qui sont échues.';

                    trigger OnAction();
                    begin
                        rec.SETFILTER(Status, '%1|%2', rec.Status::Created, rec.Status::Open);
                        rec.SETFILTER("Due Date", '<%1', TODAY);
                    end;
                }
                action("Approved Entries")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approved Entries';
                    Image = Approval;
                    ToolTip = 'Executes the Approved Entries action.';

                    trigger OnAction();
                    begin
                        // <<DITW111.00.13A DDR 23/07/2019 NRQ#103941
                        // SETRANGE(Status);
                        // SETRANGE("Due Date");
                        // SETRANGE("Automatic Entry", false);//BC Upgrade SHARMP16 Drink-IT field
                        // >>DITW111.00.13A DDR NRQ#103941
                    end;
                }
                action("All Entries")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'All Entries',
                                FRA = 'Toutes les écritures';
                    Image = Entries;
                    ToolTipML = ENU = 'View all approval entries.',
                                FRA = 'Affichez toutes les écritures d''approbation.';

                    trigger OnAction();
                    begin
                        rec.SETRANGE(Status);
                        rec.SETRANGE("Due Date");
                        // <<DITW111.00.13A DDR 23/07/2019 NRQ#103941
                        //SETRANGE("Automatic Entry");//BC Upgrade SHARMP16 Drink-IT field
                        // >>DITW111.00.13A DDR NRQ#103941
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Delegate")
            {
                AccessByPermission = TableData "Approval Entry" = M;
                ApplicationArea = Suite;
                CaptionML = ENU = '&Delegate',
                            FRA = '&Déléguer';
                Enabled = DelegateEnable;
                Image = Delegate;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTipML = ENU = 'Delegate the approval request to another approver that has been set up as your substitute approver.',
                            FRA = 'Déléguez la demande d''approbation à un autre approbateur défini comme remplaçant.';

                trigger OnAction();
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    var
        RecRef: RecordRef;
    begin
        ShowChangeFactBox := CurrPage.Change.PAGE.SetFilterFromApprovalEntry(Rec);
        DelegateEnable := rec.CanCurrentUserEdit();
        ShowRecCommentsEnabled := RecRef.GET(rec."Record ID to Approve");

        // <<DITW15.00.00.32 DDR 23/03/2009 - DITW15.00.00.33 DDR 07/05/2009
        ////BC Upgrade SHARMP16 Drink-IT field  begin>>
        // ApproveEnable :=
        //   (Status = Status::Open) and
        //   (USERID = "Approver ID") and
        //   ((("Approver Avail. Cr.Limit (LCY)" + "Approver Avail Dp Limit (LCY)") >= 0) or
        //    ("Limit Type" <> "Limit Type"::"Approval Limits") or
        //    (Usersetup."Unlimited Sales Approval" and ("Limit Type" = "Limit Type"::"Approval Limits")) or
        //    (Usersetup."Unlimited Purchase Approval" and ("Limit Type" = "Limit Type"::"Approval Limits")) or
        //    (Usersetup."Unlimited Request Approval" and ("Limit Type" = "Limit Type"::"Request Limits")) or
        //    (Usersetup."Unlimited Cr. Limit Customer" and ("Limit Type" = "Limit Type"::"Credit Limits")));
        //BC Upgrade SHARMP16 Drink-IT field end<<
        // >>DITW15.00.00.33 DDR
    end;

    trigger OnAfterGetRecord();
    begin
        // <<DITW15.00.00.32 DDR 26/03/2009
        //Overdue := Overdue::" ";
        // Overdue := false;
        // // >>DITW15.00.00.32 DDR
        // if FormatField(Rec) then
        //     // <<DITW15.00.00.32 DDR 26/03/2009
        //     //Overdue := Overdue::Yes;
        //     Overdue := true;//Bc Upgrade SHARMP16-- Drink-IT code
        // >>DITW15.00.00.32 DDR

        RecordIDText := FORMAT(rec."Record ID to Approve", 0, 1);
    end;

    trigger OnInit();
    begin
        // <<DITW15.00.00.34 DDR 04/06/2009
        // ApproveEnable := true;//Bc Upgrade SHARMP16-- Drink-IT code
        // >>DITW15.00.00.34 DDR
    end;

    trigger OnOpenPage();
    begin
        if Usersetup.GET(USERID) then
            rec.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
        ///MarkAllWhereUserisApproverOrSender;
        // <<DITW111.00.13A DDR 23/07/2019 NRQ#103941
        // rec.FILTERGROUP(0);
        // rec.SETRANGE("Automatic Entry", false);//BC Upgrade SHARMP16 Drink-IT field
        // >>DITW111.00.13A DDR NRQ#103941
    end;

    var
        Usersetup: Record "User Setup";

        ApproveEnable: Boolean;
        DelegateEnable: Boolean;
        Overdue: Boolean;
        ShowChangeFactBox: Boolean;
        ShowRecCommentsEnabled: Boolean;
        _Overdue: Option Yes," ";
        RecordIDText: Text;

    procedure Setfilters(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentNo: Code[20]);
    begin
        if TableId <> 0 then begin
            rec.FILTERGROUP(2);
            rec.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
            rec.SETRANGE("Table ID", TableId);
            rec.SETRANGE("Document Type", DocumentType);
            if DocumentNo <> '' then
                rec.SETRANGE("Document No.", DocumentNo);
            rec.FILTERGROUP(0);
        end;
    end;

    local procedure FormatField(ApprovalEntry: Record "Approval Entry"): Boolean;
    begin
        if rec.Status in [rec.Status::Created, rec.Status::Open] then begin
            if ApprovalEntry."Due Date" < TODAY then
                exit(true);

            exit(false);
        end;
    end;

    procedure CalledFrom();
    begin
        // <<DITW15.00.00.32 DDR 26/03/2009
        //Overdue := Overdue::" ";
        Overdue := true;
        // >>DITW15.00.00.32 DDR
    end;
}

