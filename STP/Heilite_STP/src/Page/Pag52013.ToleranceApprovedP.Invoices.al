page 52013 "Tolerance Approved P. Invoices"
{
    // BC Upgrade KAPOOV01 Original(Heilite) page id 50382

    // version HEI.01

    // HEI.01 CHG2221624 HB3614 IBM SRIVAS07 10.04.2024 # Block Payment for Invoices with Price Difference higher than the tolerance
    //   # New page for Tolerance Approval

    //--------------------------------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 25.11.2025 #Commented-INDATASET property of varJobQueueActive.
    //BC Upgrade KAPOOV01 25.11.2025 #Updated Factbox Name and corrected Subpagelink Syntax to resolve Compilation errors.
    //BC Upgrade KAPOOV01 25.11.2025 #Updated RunPageLink Property for action- Co&mments to correct syntax and resolve Compilation errors >>
    //BC Upgrade KAPOOV01 25.11.2025 #Commented Setfilters function on ApprovalEntries, cannot use Setfilters on Pages in BC & applied reqiured filters on Record.
    //BC Upgrade KAPOOV01 25.11.2025 #Commented Drink-IT fields.
    //BC Upgrade KAPOOV01 25.11.2025 #Added new code for IsFoundationEnabled function as this function is not available in ApplicationAreaSetup table in BC.
    //BC Upgrade KAPOOV01 25.11.2025 #Added Factbox Name for-VendorDetailsFactbox and corrected Subpagelink Syntax  to resolve Compilation errors.
    //BC Upgrade KAPOOV01 25.11.2025 #Updated action name from Post to Post_Action as Local Procedure with name-Post defined on this page.
    //BC Upgrade KAPOOV01 25.11.2025 #Updated action group from Release to Release_Grp as another action with name-Release is defined on this page.

    CaptionML = ENU = 'Tolerance Approved Purchase Invoices',
                FRA = 'Factures d''achat approuvées par tolérance';
    CardPageID = "Purchase Invoice";
    DataCaptionFields = "Buy-from Vendor No.";
    Editable = false;
    PageType = List;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Invoice,Posting,Request Approval',
                                 FRA = 'Nouveau,Traitement,État,Facture,Comptabilisation,Approbation demande achat';
    RefreshOnActivate = true;
    //BC Upgrade KAPOOV01>>
    //SourceTable = Table38; //BC Upgrade KAPOOV01 Commented to resolve Compilation errors.
    SourceTable = "Purchase Header";
    //BC Upgrade KAPOOV01<<
    //BC Upgrade KAPOOV01 to resolve Compilation errors >>
    //SourceTableView = WHERE(Document Type=CONST(Invoice), //BC Upgrade KAPOOV01 Commented
    SourceTableView = WHERE("Document Type" = CONST(Invoice),
    //BC Upgrade KAPOOV01 to resolve Compilation errors <<
                            Status = CONST(Released));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors.>>
            //repeater()  //Commented
            repeater(Group)
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors.>>
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.',
                                FRA = 'Spécifie le numéro du document achat. Le champ n''est visible que si vous n''avez défini aucune souche de numéros pour ce type de document achat, ou si le champ N° manuels est sélectionné pour la souche de numéros.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the number of the vendor that you buy from. When you enter the number, several other fields on the document are filled from the vendor card. You can change the vendor number as long as you have not posted the document.',
                                FRA = 'Spécifie le numéro du fournisseur auprès duquel vous effectuez vos achats. Lorsque vous renseignez ce champ, la plupart des autres champs du document sont remplis à partir de la fiche fournisseur. Vous pouvez changer le numéro du fournisseur tant que vous n''avez pas validé le document.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the order address code linked to the relevant vendor''s order address.',
                                FRA = 'Spécifie le code adresse commande lié à l''adresse de commande du fournisseur concerné.';
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the name of the vendor who delivers the items.',
                                FRA = 'Spécifie le nom du fournisseur qui livre les articles.';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).',
                                FRA = 'Spécifie le numéro d''identification d''un accord de compensation. Ce numéro est parfois appelé numéro d''autorisation de retour de matériel (RMA).';
                    Visible = false;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the postal code of the address.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the name of the person to contact about shipment of the item from this vendor.',
                                FRA = 'Spécifie le nom de la personne à contacter à propos de l''expédition de l''article chez le fournisseur.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the vendor who is sending the invoice.',
                                FRA = 'Spécifie le fournisseur envoyant la facture.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the name of the vendor sending the invoice.',
                                FRA = 'Spécifie le nom du fournisseur envoyant la facture.';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the postal code of the address.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the name of the person to contact about an invoice from this vendor.',
                                FRA = 'Spécifie le nom de la personne à contacter au sujet d''une facture émise par ce fournisseur.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.',
                                FRA = 'Spécifie un code destinataire si vous souhaitez utiliser une adresse destinataire différente de celle automatiquement renseignée.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the name of the company at the address to which you want the items to be shipped.',
                                FRA = 'Spécifie le nom de la société située à l''adresse à laquelle vous voulez faire livrer les articles.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the postal code of the address.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the name of a contact person for the address where the items should be shipped.',
                                FRA = 'Spécifie le nom d''une personne contact pour l''adresse à laquelle les articles doivent être livrés.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the date when the posting of the purchase document will be recorded.',
                                FRA = 'Spécifie la date à laquelle la validation du document achat sera validée.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the dimension value code associated with the purchase header.',
                                FRA = 'Spécifie le code de la section analytique associée à l''en-tête achat.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the dimension value code associated with the purchase header.',
                                FRA = 'Spécifie le code de la section analytique associée à l''en-tête achat.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                //BC Upgrade KAPOOV01 Drink-IT>>
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                //BC Upgrade KAPOOV01 Drink-IT<<
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies a code for the location where you want the items to be placed when they are received.',
                                FRA = 'Spécifie un code pour le magasin dans lequel vous souhaitez que les articles soient stockés lorsqu''ils sont réceptionnés.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies which purchaser is assigned to the vendor.',
                                FRA = 'Spécifie l''acheteur affecté au fournisseur.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.',
                                FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the code of the currency of the amounts on the purchase lines.',
                                FRA = 'Spécifie le code de la devise des montants figurant sur les lignes achat.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the date of the vendor''s invoice.',
                                FRA = 'Spécifie la date de la facture du fournisseur.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.',
                                FRA = 'Spécifie si l''enregistrement est ouvert, en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.',
                                FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de l''escompte sur le document achat.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies when the invoice is due.',
                                FRA = 'Spécifie la date d''échéance de la facture.';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.',
                                FRA = 'Spécifie le pourcentage escompte accordé si le paiement est effectué au plus tard à la date saisie dans le champ Date d''escompte.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies how payment for the purchase document must be submitted.',
                                FRA = 'Spécifie la manière dont le paiement du document achat doit être réalisé.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the code that represents the shipment method for this purchase.',
                                FRA = 'Spécifie le code qui représente les conditions de livraison de cet achat.';
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the date to have the vendor deliver your order to the ship-to address.',
                                FRA = 'Indique la date à laquelle le fournisseur doit livrer votre commande à l''adresse destinataire.';
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the status of a job queue entry that handles the posting of purchase orders.',
                                FRA = 'Spécifie le statut d''une écriture file d''attente des travaux qui gère la validation des commandes achat.';
                    Visible = JobQueueActive;
                }
                //BC Upgrade VAMSIU01 Drink-IT>>
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                //BC Upgrade VAMSIU01 Drink-IT<<
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the sum of the amounts in the Amount field on the associated purchase lines.',
                                FRA = 'Spécifie la somme des montants du champ Montant sur les lignes achat associées.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Doc. Amount VAT"; Rec."Doc. Amount VAT")
                {
                    ApplicationArea = All;
                }
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(RUID; Rec."RUID FND")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; 193)
            {
                ApplicationArea = All;
                ShowFilter = false;
            }
            //BC Upgrade KAPOOV01 Updated Factbox Name and corrected Subpagelink Syntax to resolve Compilation errors >>
            // part(; 9093)
            // {
            //     SubPageLink = No.=FIELD(Buy-from Vendor No.),
            //                   Date Filter=FIELD(Date Filter);
            // }

            part(VendorDetailsFactbox; 9093)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                  "Date Filter" = FIELD("Date Filter");
            }
            //BC Upgrade KAPOOV01 Updated Factbox Name and corrected Subpagelink Syntax to resolve Compilation errors <<

            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors >>
            //systempart(; Links) //Commented
            systempart(RecordLinks; Links)
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors <<
            {
                ApplicationArea = Notes;
                Visible = false;
            }
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors >>
            //systempart(; Notes) //Commented
            systempart(Notes; Notes)
            //BC Upgrade KAPOOV01 to correct syntax and resolve Compilation errors <<
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                CaptionML = ENU = '&Invoice',
                            FRA = 'Fa&cture';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader();
                        COMMIT();
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    //BC Upgrade KAPOOV01 updated RunPageLink Property for action- Co&mments to correct syntax and resolve Compilation errors >>
                    // RunPageLink = Document Type=FIELD(Document Type),  //BC Upgrade KAPOOV01 Commented
                    //               No.=FIELD(No.),                      //BC Upgrade KAPOOV01 Commented
                    //               Document Line No.=CONST(0);          //BC Upgrade KAPOOV01 Commented
                    RunPageLink = "Document Type" = FIELD("Document Type"),
              "No." = FIELD("No."),
              "Document Line No." = CONST(0);
                    //BC Upgrade KAPOOV01 updated RunPageLink Property for action- Co&mments to correct syntax and resolve Compilation errors <<
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 348 = R;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
            }
        }
        area(processing)
        {
            group(Invoice)
            {
                CaptionML = ENU = 'Invoice',
                            FRA = 'Facture';
                action(Approvals)
                {
                    AccessByPermission = TableData 454 = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Approvals',
                                FRA = 'Approbations';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.',
                                FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';

                    trigger OnAction();
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalEntries: Page "Approval entries";
                    begin
                        //BC Upgrade KAPOOV01 Commented Setfilters function on ApprovalEntries, cannot use Setfilters on Pages in BC & applied reqiured filters on Record >>
                        //ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No."); //BC Upgrade KAPOOV01 Commented Setfilters.
                        ApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
                        ApprovalEntry.SetRange("Table ID", DATABASE::"Purchase Header");
                        ApprovalEntry.SetRange("Document Type", Rec."Document Type");
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        //BC Upgrade KAPOOV01 Commented Setfilters function on ApprovalEntries, cannot use Setfilters on Pages in BC & applied reqiured filters on Record <<
                        ApprovalEntries.Run();

                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Vendor',
                                FRA = 'Fournisseur';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                    ToolTipML = ENU = 'View or edit detailed information about the vendor on the selected purchase document.',
                                FRA = 'Affichez ou modifiez des informations détaillées concernant le fournisseur sur le document achat sélectionné.';
                }
            }
            //BC Upgrade KAPOOV01 Updated action group from Release to Release_Grp as another action with name-Release is defined on this page >>
            //group(Release)
            group(Release_Grp)
            //BC Upgrade KAPOOV01 Updated action group from Release to Release_Grp as another action with name-Release is defined on this page <<
            {
                CaptionML = ENU = 'Release',
                            FRA = 'Lancer';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Re&lease',
                                FRA = '&Lancer';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Re&open',
                                FRA = 'R&ouvrir';
                    Image = ReOpen;

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                CaptionML = ENU = 'Request Approval',
                            FRA = 'Approbation demande achat';
                Image = "Action";
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Send A&pproval Request',
                                FRA = 'Envoyer demande d''a&pprobation';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Send an approval request.',
                                FRA = 'Envoyez une demande d''approbation.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Cancel Approval Re&quest',
                                FRA = 'Annuler demande d''appro&bation';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Cancel the approval request.',
                                FRA = 'Annulez la demande d''approbation.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                CaptionML = ENU = 'P&osting',
                            FRA = '&Validation';
                Image = Post;
                //BC Upgrade KAPOOV01 changed action name from Post to Post_Action as Local Procedure with name-Post defined on this page >>
                //action(Post) //Commented- Local Procedure with name-Post defined on this page
                action(Post_Action)
                //BC Upgrade KAPOOV01 changed action name from Post to Post_Action as Local Procedure with name-Post defined on this page <<
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'P&ost',
                                FRA = '&Valider';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';
                    ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.',
                                FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';

                    trigger OnAction();
                    begin
                        VerifyTotal();
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Preview Posting',
                                FRA = 'Aperçu compta.';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.',
                                FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';

                    trigger OnAction();
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Test Report',
                                FRA = 'Impression test';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.',
                                FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Post and &Print',
                                FRA = 'Valider et i&mprimer';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction();
                    begin
                        VerifyTotal();
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Post &Batch',
                                FRA = 'Valider par l&ot';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        VerifyTotal();
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Remove From Job Queue',
                                FRA = 'Supprimer de la file d''attente des travaux';
                    Image = RemoveLine;
                    ToolTipML = ENU = 'Remove the scheduled processing of this record from the job queue.',
                                FRA = 'Supprimez le traitement planifié de cet enregistrement à partir de la file d''attente des travaux.';
                    Visible = JobQueueActive;

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive();

        Rec.CopyBuyFromVendorFilter();
    end;

    var
        ReportPrint: Codeunit "Test Report-Print";
        //[InDataSet] //BC Upgrade KAPOOV01
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenPostedPurchaseInvQst: TextConst ENU = 'The invoice has been posted and moved to the Posted Purchase Invoice list.\\Do you want to open the posted invoice?', FRA = 'La facture a été validée et déplacée dans la liste des factures achat enregistrées.\\Souhaitez-vous ouvrir la facture validée ?';
        CanCancelApprovalForRecord: Boolean;
        TotalsMismatchErr: TextConst ENU = 'The invoice cannot be posted because the total is different from the total on the related incoming document.', FRA = 'Impossible de valider la facture car le total est différent du total sur le document entrant associé.';

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure Post(PostingCodeunitID: Integer);
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    //AppAreaMgt: Codeunit "Application Area Mgmt.";  //BC Upgrade KAPOOV01 Commented
    begin
        //BC Upgrade KAPOOV01 IsFoundationEnabled function not found in ApplicationAreaSetup Table.>>
        //IF ApplicationAreaSetup.IsFoundationEnabled THEN  //BC Upgrade KAPOOV01 Commented
        IF (ApplicationAreaSetup.Basic OR ApplicationAreaSetup.Suite) then
            //BC Upgrade KAPOOV01 IsFoundationEnabled function not found in ApplicationAreaSetup Table.<<
            LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);
        //BC Upgrade KAPOOV01 IsFoundationEnabled function not found in ApplicationAreaSetup Table.>>
        //IF ApplicationAreaSetup.IsFoundationEnabled THEN  //BC Upgrade KAPOOV01 Commented
        IF (ApplicationAreaSetup.Basic OR ApplicationAreaSetup.Suite) then
            //BC Upgrade KAPOOV01 IsFoundationEnabled function not found in ApplicationAreaSetup Table.<<
            ShowPostedConfirmationMessage();
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        PurchInvHeader.SETFILTER(PurchInvHeader."Pre-Assigned No.", Rec."No.");
        IF PurchInvHeader.FINDFIRST() THEN
            IF DIALOG.CONFIRM(OpenPostedPurchaseInvQst, FALSE) THEN
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
    end;

    local procedure VerifyTotal();
    begin
        IF NOT Rec.IsTotalValid() THEN
            ERROR(TotalsMismatchErr);
    end;
}

