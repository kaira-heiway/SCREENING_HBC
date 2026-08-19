page 52000 "BRC Bottle recycle Center List"
{
    // BC Upgrade Kamnay01 Original(Heilite) page id 50237

    // version HEI.01

    // 
    // HEI.01 PURGAP11 IBM LAZARE02 04.09.2017
    //  # New fields for SRM integration: SRM Contract Type, SRM Contract No., Channel, Target Value Currency, Target Value Amount, Valid From, Valid To, Shipment Method Location
    // 
    // HEI.02 FDD-PURGAPINT005 IBM NASTAA02 28.09.2017 # Purchase Order Layout Template Procurement
    //   # Print button should be enabled just when "SRM Order No." is empty
    // HEI.03 SoicaD filtering by doc subtype
    // 
    // HEI.04 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM NAIKH01 16.10.2018
    //   # Created a new Page Copy of Page 9307 - Purchase Order List
    //   # Added new Field "BRC Purchase Order"

    //**********************************************************************************************************************************************************************
    //BC UPGRADE PATHAA02 30.10.25 Done
    //1.Commented HEI.03 on OpenPage() because of dependency on DIT table-2014473(DocumentSubtypeCodeSetup)
    //2. Commented-Action-action("&Shipping Agent Notice")-->Dependency with DIT Function- PrintPurchHeaderAgentNotice()
    //3. Commented code on OnAfterGetRecord()-ShowShortcutUomValue-DIT
    //4. For Action-Approvals, Routed to new Function from (ApprovalEntries.SetFilters) to (ApprovalEntries.SetRecordFilters)
    //5. Commented DIT Fields.
    //6. SRM Interface Fields found.

    // BC UPGRADE PATELS08 >>
    // # In action Statistics 'Rec.OpenPurchaseOrderStatistics()' is marked for removal. Thus instead directly running page using runobject.
    // BC UPGRADE PATELS08 >>

    // BC Upgrade SHUKLP03 >> Added document subtype code.

    CaptionML = ENU = 'Purchase Orders',
                FRA = 'Commandes achat';
    CardPageID = "BRC Bottle recycle Center Card";
    DataCaptionFields = "Document Type", "Buy-from Vendor No.";
    Editable = false;
    PageType = List;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Request Approval,Print',
                                 FRA = 'Nouveau,Traiter,Déclarer,Demander une approbation,Imprimer';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = CONST(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the number of the purchase document.',
                                FRA = 'Spécifie le numéro du document achat.';
                }
                field(Status; Rec.Status)
                {
                    ToolTipML = ENU = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.',
                                FRA = 'Spécifie si l''enregistrement est ouvert, en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTipML = ENU = 'Specifies the number of the vendor you buy from.',
                                FRA = 'Spécifie le numéro du fournisseur auprès duquel vous effectuez vos achats.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTipML = ENU = 'Specifies the order address code linked to the relevant vendor''s order address.',
                                FRA = 'Spécifie le code adresse commande lié à l''adresse de commande du fournisseur concerné.';
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the name of the vendor who delivers the items.',
                                FRA = 'Spécifie le nom du fournisseur qui livre les articles.';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ToolTipML = ENU = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).',
                                FRA = 'Spécifie le numéro d''identification d''un accord de compensation. Ce numéro est parfois appelé numéro d''autorisation de retour de matériel (RMA).';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTipML = ENU = 'Specifies the postal code of the address.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTipML = ENU = 'Specifies the name of the person to contact about shipment of the item from this vendor.',
                                FRA = 'Spécifie le nom de la personne à contacter à propos de l''expédition de l''article chez le fournisseur.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTipML = ENU = 'Specifies the vendor who is sending the invoice.',
                                FRA = 'Spécifie le fournisseur envoyant la facture.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTipML = ENU = 'Specifies the name of the vendor sending the invoice.',
                                FRA = 'Spécifie le nom du fournisseur envoyant la facture.';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTipML = ENU = 'Specifies the postal code of the address.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTipML = ENU = 'Specifies the name of the person to contact about an invoice from this vendor.',
                                FRA = 'Spécifie le nom de la personne à contacter au sujet d''une facture émise par ce fournisseur.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTipML = ENU = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.',
                                FRA = 'Spécifie un code destinataire si vous souhaitez utiliser une adresse destinataire différente de celle automatiquement renseignée.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTipML = ENU = 'Specifies the name of the company at the address to which you want the items to be shipped.',
                                FRA = 'Spécifie le nom de la société située à l''adresse à laquelle vous voulez faire livrer les articles.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTipML = ENU = 'Specifies the postal code of the address.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTipML = ENU = 'Specifies the name of a contact person for the address where the items should be shipped.',
                                FRA = 'Spécifie le nom d''une personne contact pour l''adresse à laquelle les articles doivent être livrés.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the date when the posting of the purchase document will be recorded.',
                                FRA = 'Spécifie la date à laquelle la validation du document achat sera validée.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.',
                                FRA = 'Spécifie le code pour Raccourci axe 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.',
                                FRA = 'Spécifie le code pour Raccourci axe 2.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Visible = false;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
                }
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Visible = false;
                // } BC UPGRADE PATHAA02 DIT F-2014410
                field("Location Code"; Rec."Location Code")
                {
                    ToolTipML = ENU = 'Specifies a code for the location where you want the items to be placed when they are received.',
                                FRA = 'Spécifie un code pour le magasin dans lequel vous souhaitez que les articles soient stockés lorsqu''ils sont réceptionnés.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies which purchaser is assigned to the vendor.',
                                FRA = 'Spécifie l''acheteur affecté au fournisseur.';
                    Visible = false;
                }
                // field("Requester ID";Rec."Requester ID")
                // {
                //     Description = 'DITW17.00.02 DIT-770 #144';
                //     Visible = false;
                // } BC UPGRADE PATHAA02

                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.',
                                FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code of the currency of the amounts on the purchase lines.',
                                FRA = 'Spécifie le code de la devise des montants figurant sur les lignes achat.';
                    Visible = false;
                }
                // field("Disc.Promo. Order Calculated"; Rec."Disc.Promo. Order Calculated")
                // {
                //     Visible = false;
                // } // BC UPGRADE PATHAA02-F2013797
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the date of the vendor''s invoice.',
                                FRA = 'Spécifie la date de la facture du fournisseur.';
                }
                // field("Campaign No."; "Campaign No.")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // } // BC UPGRADE PATHAA02

                // field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // } //BC UPGRADE PATHAA02

                // field("Expected Receipt Date"; "Expected Receipt Date")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // } // BC UPGRADE PATHAA02
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.',
                                FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de l''escompte sur le document achat.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies when the purchase invoice is due for payment.',
                                FRA = 'Spécifie la date à laquelle la facture achat doit être payée.';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTipML = ENU = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.',
                                FRA = 'Spécifie le pourcentage escompte accordé si le paiement est effectué au plus tard à la date saisie dans le champ Date d''escompte.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies how payment for the purchase document must be submitted.',
                                FRA = 'Spécifie la manière dont le paiement du document achat doit être réalisé.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTipML = ENU = 'Specifies the code that represents the shipment method for this purchase.',
                                FRA = 'Spécifie le code qui représente les conditions de livraison de cet achat.';
                    Visible = false;
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.',
                                FRA = 'Spécifie la date à laquelle vous souhaitez que le fournisseur livre les articles à l''adresse destinataire. La valeur du champ est utilisée pour calculer la date limite de commande garantissant la livraison des articles à la date de réception demandée. Si vous ne souhaitez pas indiquer une date de livraison, vous pouvez laisser ce champ vide.';
                    Visible = false;
                }
                //BC UPGRADE PATHAA02 DIT fields>>
                // field("Shipping Agent Code"; Rec."Shipping Agent Code")
                // {
                //     Visible = false;
                // }//F-2014075

                // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                // {
                //     Visible = false;
                // }//F-2014076


                // field(Distance; Rec.Distance)
                // {
                //     Visible = false;
                // } //-F2014087
                // field("Truck Code"; "Truck Code")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Driver Code"; "Driver Code")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Shipping Charge Per"; "Shipping Charge Per")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Maximum Weight"; Rec."Maximum Weight")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Maximum Cubage"; Rec."Maximum Cubage")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Total Weight"; Rec."Total Weight")
                // {
                //     Visible = false;
                // }
                // field("Total Cubage"; Rec."Total Cubage")
                // {
                //     Visible = false;
                // }
                // field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassUom(1);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassUom(2);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassUom(3);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Link Purch. Document Type"; "Link Purch. Document Type")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Link Purch. Document No."; "Link Purch. Document No.")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Fiscal Representative No."; "Fiscal Representative No.")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Vendor Tax Registration No."; "Vendor Tax Registration No.")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Vendor Tax Warehouse Ref."; "Vendor Tax Warehouse Ref.")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                //BC UPGRADE PATHAA02<<
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the status of a job queue entry that handles the posting of purchase orders.',
                                FRA = 'Spécifie le statut d''une écriture file d''attente des travaux qui gère la validation des commandes achat.';
                    Visible = JobQueueActive;
                }
                //BC UPGRADE PATHAA02-DIT fields>>
                // field("Sundry Vendor"; Rec."Sundry Vendor")
                // {
                //     Editable = false;
                //     Visible = false;
                // }//F2014420
                // field("Last changed User ID"; Rec."Last changed User ID")
                // {
                //     Editable = false;
                // }//F-2029615
                // field("Last changed Date/time"; Rec."Last changed Date/time")
                // {
                //     Editable = false;
                // }//F-2029616
                ////BC UPGRADE PATHAA02<<
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the sum of the amounts in the Amount field on the associated purchase lines.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the sum of amounts, including VAT, on all the lines in the document. This will include invoice discounts.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field(Channel; Rec."Channel FND")
                {
                    ToolTip = 'Specifies the value of the Channel field.';
                }
                field("Target Value Currency"; Rec."Target Value Currency FND")
                {
                    ToolTip = 'Specifies the value of the Target Value Currency field.';
                }
                field("Target Value Amount"; Rec."Target Value Amount FND")
                {
                    ToolTip = 'Specifies the value of the Target Value Amount field.';
                }
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                    Visible = false;
                }//BC UPGRADE SHUKLP03 <<
                field(Receive; Rec.Receive)
                {
                    ToolTip = 'Specifies the value of the Receive field.';
                }
                field("BRC Purchase Order"; Rec."BRC Purchase Order FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the BRC Purchase Order field.';
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                CaptionML = ENU = 'O&rder',
                            FRA = 'C&ommande';
                Image = "Order";
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Statistics)
                {
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    // BC Upgrade PATELS08 >> # 'Rec.OpenPurchaseOrderStatistics()' is marked for removal. Thus instead directly running page using runobject.
                    RunObject = Page "Purchase Order Statistics";
                    RunPageOnRec = true;
                    trigger OnAction();
                    begin
                        // Rec.OpenPurchaseOrderStatistics();
                    end;
                    // BC Upgrade PATELS08 <<
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Approvals',
                                FRA = 'Approbations';
                    Image = Approvals;
                    ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.',
                                FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //BC UPGRADE PATHAA02>>
                        //ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        //BC UPGRADE PATHAA02 30.10.25<<
                        ApprovalEntries.RUN();
                    end;
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'Executes the Co&mments action.';
                }
                // action("Shipping Costs")
                // {
                //     CaptionML = ENU = 'Shipping Costs',
                //                 FRA = 'Coûts transport';
                //     Image = Costs;
                //     RunObject = Page "Document Shipping Cost";
                //     RunPageLink = "Source Type" = CONST(38),
                //                   "Source No." = FIELD("No."),
                //                   "Sub Type" = FIELD("Document Type");
                // } //BC UPGRADE PATHAA02-P2014096
            }
            group(Documents)
            {
                CaptionML = ENU = 'Documents',
                            FRA = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Receipts',
                                FRA = 'Réceptions';
                    Image = PostedReceipts;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'Executes the Receipts action.';
                }
                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Invoices',
                                FRA = 'Factures';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'Executes the PostedPurchaseInvoices action.';
                }
                action(PostedPurchasePrepmtInvoices)
                {
                    CaptionML = ENU = 'Prepa&yment Invoices',
                                FRA = 'Factures acom&pte';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'Executes the PostedPurchasePrepmtInvoices action.';
                }
                action("Prepayment Credi&t Memos")
                {
                    CaptionML = ENU = 'Prepayment Credi&t Memos',
                                FRA = 'A&voirs acompte';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'Executes the Prepayment Credi&t Memos action.';
                }
                separator(Separator1102601037)
                {
                }
            }
            group(Warehouse)
            {
                CaptionML = ENU = 'Warehouse',
                            FRA = 'Entrepôt';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    CaptionML = ENU = 'In&vt. Put-away/Pick Lines',
                                FRA = 'Lignes prélè&v./rangement stock';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ToolTip = 'Executes the In&vt. Put-away/Pick Lines action.';
                }
                action("Whse. Receipt Lines")
                {
                    CaptionML = ENU = 'Whse. Receipt Lines',
                                FRA = 'Lignes réception entrep.';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'Executes the Whse. Receipt Lines action.';
                }
                separator(Separator1102601040)
                {
                }
            }
        }
        area(processing)
        {
            group(ActionGroup9)
            {
                CaptionML = ENU = 'Print',
                            FRA = 'Imprimer';
                Image = Print;
                action(Print)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = '&Print',
                                FRA = '&Imprimer';
                    Ellipsis = true;
                    Enabled = PrintEnabled;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTipML = ENU = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.',
                                FRA = 'Préparez-vous à imprimer le document. La fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';
                    Visible = false;

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                        PurchaseHeader.PrintRecords(true);
                    end;
                }
                action(Send)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Send',
                                FRA = 'Envoyer';
                    Ellipsis = true;
                    Image = SendToMultiple;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTipML = ENU = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.',
                                FRA = 'Préparez-vous à envoyer le document en fonction du profil d''envoi du fournisseur, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                        PurchaseHeader.SendRecords();
                    end;
                }
            }
            group(ActionGroup10)
            {
                CaptionML = ENU = 'Release',
                            FRA = 'Lancer';
                Image = ReleaseDoc;
                action(Release)
                {
                    CaptionML = ENU = 'Re&lease',
                                FRA = '&Lancer';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Release action.';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Re&open',
                                FRA = 'R&ouvrir';
                    Image = ReOpen;
                    ShortCutKey = 'Ctrl+F10';
                    ToolTip = 'Executes the Reopen action.';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Separator1102601023)
                {
                }
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                Image = "Action";
                action("Send IC Purchase Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    CaptionML = ENU = 'Send IC Purchase Order',
                                FRA = 'Envoyer commande achat IC';
                    Image = IntercompanyOrder;
                    ToolTip = 'Executes the Send IC Purchase Order action.';

                    trigger OnAction();
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                            ICInOutboxMgt.SendPurchDoc(Rec, false);
                    end;
                }
            }
            group("Request Approval")
            {
                CaptionML = ENU = 'Request Approval',
                            FRA = 'Approbation demande achat';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Send A&pproval Request',
                                FRA = 'Envoyer demande d''a&pprobation';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Send an approval request.',
                                FRA = 'Envoyez une demande d''approbation.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Cancel Approval Re&quest',
                                FRA = 'Annuler demande d''appro&bation';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
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
            group(ActionGroup12)
            {
                CaptionML = ENU = 'Warehouse',
                            FRA = 'Entrepôt';
                Image = Warehouse;
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    CaptionML = ENU = 'Create &Whse. Receipt',
                                FRA = 'Créer &réception entrepôt';
                    Image = NewReceipt;
                    ToolTip = 'Executes the Create &Whse. Receipt action.';

                    trigger OnAction();
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    CaptionML = ENU = 'Create Inventor&y Put-away/Pick',
                                FRA = 'Créer prélèv./rangement stoc&k';
                    Ellipsis = true;
                    Image = CreatePutawayPick;
                    ToolTip = 'Executes the Create Inventor&y Put-away/Pick action.';

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
                separator(Separator1102601017)
                {
                }
            }
            group("P&osting")
            {
                CaptionML = ENU = 'P&osting',
                            FRA = '&Validation';
                Image = Post;
                action(TestReport)
                {
                    CaptionML = ENU = 'Test Report',
                                FRA = 'Impression test';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'Executes the TestReport action.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'P&ost',
                                FRA = '&Valider';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the Post action.';

                    trigger OnAction();
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Preview Posting',
                                FRA = 'Aperçu compta.';
                    Image = ViewPostedOrder;
                    ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.',
                                FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';

                    trigger OnAction();
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Post and &Print',
                                FRA = 'Valider et i&mprimer';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Executes the PostAndPrint action.';

                    trigger OnAction();
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    CaptionML = ENU = 'Post &Batch',
                                FRA = 'Valider par l&ot';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the PostBatch action.';

                    trigger OnAction();
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Remove From Job Queue',
                                FRA = 'Supprimer de la file d''attente des travaux';
                    Image = RemoveLine;
                    Visible = JobQueueActive;
                    ToolTip = 'Executes the RemoveFromJobQueue action.';

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
            group("&Print")
            {
                CaptionML = ENU = '&Print',
                            FRA = '&Imprimer';
                action("&Order")
                {
                    CaptionML = ENU = '&Order',
                                FRA = '&Commande';
                    Image = Print;
                    ToolTip = 'Executes the &Order action.';

                    trigger OnAction();
                    var
                        DocPrint: Codeunit "Document-Print";
                    begin
                        //? DITW110.00.08 DDR 02/01/2017 NRQ#0 TO BE REPLACED (don't use codeunit229 Document-Print)

                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        DocPrint.PrintPurchHeader(Rec);
                        // >>DITW16.00.00.40 DDR DIT-715 #197
                    end;
                }

                // action("&Shipping Agent Notice")
                // {
                //     CaptionML = ENU = '&Shipping Agent Notice',
                //                 FRA = '&Mention du transporteur';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         DocPrint: Codeunit "Document-Print";
                //     begin
                //         //? DITW110.00.08 DDR 02/01/2017 NRQ#0 TO BE REPLACED (don't use codeunit229 Document-Print)

                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         DocPrint.PrintPurchHeaderAgentNotice(Rec);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // } BC UPGRADE PATHAA02-30-10-25

                action("BRC Daily Intake")
                {
                    Caption = 'BRC Daily Intake';
                    Image = Print;
                    ToolTip = 'Executes the BRC Daily Intake action.';

                    trigger OnAction();
                    begin
                        GeneralOpCoSetup.GET();
                        GeneralOpCoSetup.TESTFIELD("BRC Location Code");

                        PurchaseHeader.RESET();
                        PurchaseHeader.SETRANGE("Location Code", GeneralOpCoSetup."BRC Location Code");
                        //PurchaseHeader.SETRANGE(Status,PurchaseHeader.Status::"Pending Approval"); //NAIKH01 New
                        if PurchaseHeader.FINDFIRST() then
                            REPORT.RUNMODAL(50193, true, false, PurchaseHeader);
                    end;
                }
                action("BRC Posted Purch Receipt")
                {
                    Caption = 'BRC Posted Purch Receipt';
                    Image = Print;
                    ToolTip = 'Executes the BRC Posted Purch Receipt action.';

                    trigger OnAction();
                    begin
                        GeneralOpCoSetup.GET();
                        GeneralOpCoSetup.TESTFIELD("BRC Location Code");

                        PurchRcptHeader.RESET();
                        PurchRcptHeader.SETRANGE("Location Code", GeneralOpCoSetup."BRC Location Code");
                        if PurchRcptHeader.FINDFIRST() then
                            REPORT.RUNMODAL(50194, true, false, PurchRcptHeader);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

        //>>HEI.01
        PrintEnabled := Rec."SRM Order No. FND" = '';
        //<<HEI.01

        /*
        //NAIKH01
        GeneralOpCoSetup.GET;
        GeneralOpCoSetup.TESTFIELD("Local Vendor type");
        
        Vendor.Reset;
        Vendor.SETRANGE("No.","Buy-from Vendor No.");
        Vendor.SETRANGE("Local Vendor Type",GeneralOpCoSetup."Local Vendor type");
        IF Vendor.FINDFIRST THEN
          SETRANGE("Buy-from Vendor No.",Vendor."No.");
        */

    end;

    trigger OnAfterGetRecord();
    begin
        //BC UPGRADE PATHAA02>>
        //     // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        //     ShowShortcutUomValue(ShortcutQtyUomValue);
        //     // >>DITW16.00.00.40 DDR DIT-715 #244
        //BC UPGRADE PATHAA02<<
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        exit(Rec.FIND(Which) and ShowHeader());
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    var
        NewStepCount: Integer;
    begin
        repeat
            NewStepCount := Rec.NEXT(Steps);
        until (NewStepCount = 0) or ShowHeader();

        exit(NewStepCount);
    end;

    trigger OnOpenPage();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";//BC UPGRADE SHUKLP03 
    begin
        Rec.SetSecurityFilterOnRespCenter();

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive();

        Rec.CopyBuyFromVendorFilter();

        //BC UPGRADE SHUKLP03 >>
        //HEI03 SOICAD>>
        DocumentSubtypeCodeSetup.GET();
        DocumentSubtypeCodeSetup.TESTFIELD("Purchase - General"); //T2014473
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Document Subtype Code FND", '%1|%2', '', DocumentSubtypeCodeSetup."Purchase - General");
        Rec.FILTERGROUP(0);
        //HEI03 SOICAD<<
        //BC UPGRADE SHUKLP03 <<

        //HEI.04
        GeneralOpCoSetup.GET();
        GeneralOpCoSetup.TESTFIELD("BRC Location Code");
        /*
        GeneralOpCoSetup.TESTFIELD("Local Vendor type");
        
        Vendor.Reset;
        Vendor.SETRANGE("No.","Buy-from Vendor No.");
        Vendor.SETRANGE("Local Vendor Type",GeneralOpCoSetup."Local Vendor type");
        IF Vendor.FINDFIRST THEN BEGIN
          SETRANGE("Buy-from Vendor No.",Vendor."No.");
          SETRANGE("Location Code",GeneralOpCoSetup."BRC Location Code");
            END;
        
        */
        //FILTERGROUP(2);
        Rec.SETRANGE(Rec."Location Code", GeneralOpCoSetup."BRC Location Code");
        //FILTERGROUP(0);

    end;

    var
        ReportPrint: Codeunit "Test Report-Print";

        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        SkipLinesWithoutVAT: Boolean;
        ShortcutQtyUomValue: array[3] of Decimal;
        PrintEnabled: Boolean;
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        Vendor: Record Vendor;
        PurchaseHeader: Record "Purchase Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    procedure SkipShowingLinesWithoutVAT();
    begin
        SkipLinesWithoutVAT := true;
    end;

    local procedure ShowHeader(): Boolean;
    var
        CashFlowManagement: Codeunit "Cash Flow Management";
    begin
        if not SkipLinesWithoutVAT then
            exit(true);

        exit(CashFlowManagement.GetTaxAmountFromPurchaseOrder(Rec) <> 0);
    end;
}

