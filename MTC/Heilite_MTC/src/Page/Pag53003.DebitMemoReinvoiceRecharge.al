page 53003 "DebitMemo Reinvoice Recharge"
{
    // version HEI.01
    //BC UPGRADE SIVA Old Page ID 50136 
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" (Visible FALSE)
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // 
    // HEI.01 #RFC-FDD-OTCGAP051 18.01.18-new list page created from standard sales invoice list
    //        # Code written on OnOpenPage()

    //************************************************//
    // BC UPGRADE SIVA 9/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 Commented Code related to Drink IT T2014473.
    //2.Drink IT Fields/Actions/Code are commented
    //5.Used SetRecordFilters instead of SetFilters in Action Approvals OnAction trigger.
    //6.Rename from Post to PostSubmit to avoid conflict with action Post
    //************************************************//

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added

    Caption = 'DebitMemo Reivoice Recharge';
    CardPageID = "Sales Invoice";
    DataCaptionFields = "Sell-to Customer No.";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Release,Posting,Invoice,Request Approval',
                                 ESP = 'Nuevo,Procesar,Informar,Lanzar,Registrar,Factura,Solicitar aprobación',
                                 FRA = 'Nouveau,Traitement,État,Lancer,Comptabilisation,Facture,Demande d''approbation';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST(Invoice));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the number of the sales document.',
                                ESP = 'Especifica el número del documento de venta.',
                                FRA = 'Spécifie le numéro du document vente.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTipML = ENU = 'Specifies the number of the customer who will receive the products and be billed by default.',
                                ESP = 'Especifica el número del cliente que recibirá los productos y al que se facturará de forma predeterminada.',
                                FRA = 'Spécifie le numéro du client qui va recevoir les produits et être facturé par défaut.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the name of the customer who will receive the products and be billed by default.',
                                ESP = 'Especifica el nombre del cliente que recibirá los productos y al que se facturará de forma predeterminada.',
                                FRA = 'Spécifie le nom du client qui recevra les produits et sera facturé par défaut.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTipML = ENU = 'Specifies the number that the customer uses in their own system to refer to this sales document.',
                                ESP = 'Especifica el número que usa el cliente en su propio sistema para hacer referencia a este documento de venta.',
                                FRA = 'Spécifie le numéro que le client doit utiliser dans son propre système pour faire référence à ce document vente.';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTipML = ENU = 'Specifies the ZIP code of the address.',
                                ESP = 'Especifica el código postal de la dirección.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                ESP = 'Especifica el código de país o región de la dirección.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the name of the person to contact at the customer that the items were sold to.',
                                ESP = 'Especifica el nombre de la persona con la que contacta cuando debe comunicarse con el cliente al que se enviaron los artículos.',
                                FRA = 'Spécifie le nom de la personne à contacter chez le client à qui les articles ont été vendus.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTipML = ENU = 'Specifies the customer to whom you will send the sales invoice when this customer is different from the sell-to customer.',
                                ESP = 'Especifica el cliente al que se enviará la factura de venta, cuando este es distinto del cliente al que se realiza la venta.',
                                FRA = 'Spécifie le nom du client auquel vous envoyez la facture vente, si ce client diffère de celui auquel vous vendez.';
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTipML = ENU = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.',
                                ESP = 'Especifica el cliente al que se enviará la factura de venta, cuando es distinto del cliente al que se realiza la venta.',
                                FRA = 'Spécifie le nom du client auquel vous envoyez la facture vente, s''il diffère du client auquel vous vendez.';
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTipML = ENU = 'Specifies the ZIP code of the address.',
                                ESP = 'Especifica el código postal de la dirección.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                ESP = 'Especifica el código de país o región de la dirección.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTipML = ENU = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.',
                                ESP = 'Especifica el nombre de la persona con quien contactarse cuando es necesario comunicarse con el cliente al que se enviará la factura.',
                                FRA = 'Spécifie le nom de la personne que vous devez contacter chez le client auquel vous envoyez la facture.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTipML = ENU = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.',
                                ESP = 'Especifica el código para otra dirección de envío distinta a la propia dirección del cliente, que se especifica de forma predeterminada.',
                                FRA = 'Spécifie le code d''une adresse de livraison différente de l''adresse du client, qui est entrée par défaut.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTipML = ENU = 'Specifies the name that products on the sales document will be shipped to.',
                                ESP = 'Especifica el nombre al que se enviarán los productos en el documento de venta.',
                                FRA = 'Spécifie le nom auquel les produits mentionnés sur le document vente seront expédiés.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTipML = ENU = 'Specifies the ZIP code of the address.',
                                ESP = 'Especifica el código postal de la dirección.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                ESP = 'Especifica el código de país o región de la dirección.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTipML = ENU = 'Specifies the name of the contact person at the address that products will be shipped to.',
                                ESP = 'Especifica el nombre de la persona de contacto que consta en la dirección a la que se enviarán los productos.',
                                FRA = 'Spécifie le nom du contact à l''adresse à laquelle ces produits seront expédiés.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date when the posting of the sales document will be recorded.',
                                ESP = 'Especifica la fecha en que se registrará el registro del documento de venta.',
                                FRA = 'Spécifie la date à laquelle la validation du document vente sera validée.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTipML = ENU = 'Specifies the dimension value code associated with the sales header.',
                                ESP = 'Especifica el código del valor de dimensión asociado a la cabecera de ventas.',
                                FRA = 'Spécifie le code section analytique associée à l''en-tête vente.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTipML = ENU = 'Specifies the dimension value code associated with the sales header.',
                                ESP = 'Especifica el código del valor de dimensión asociado a la cabecera de ventas.',
                                FRA = 'Spécifie le code section analytique associée à l''en-tête vente.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {

                    Editable = false;
                    Visible = false;
                }
                //BC UPGRADE SIVA >>Drink IT field
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                //BC UPGRADE SIVA <<Drink IT field
                field("Location Code"; Rec."Location Code")
                {
                    ToolTipML = ENU = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.',
                                ESP = 'Especifica la ubicación desde la que se envían de forma predeterminada los productos de inventario al cliente en el documento de venta.',
                                FRA = 'Spécifie le magasin à partir duquel les articles de stock doivent être expédiés par défaut au client figurant sur le document vente.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ToolTipML = ENU = 'Specifies the name of the sales person who is assigned to the customer.',
                                ESP = 'Especifica el nombre de vendedor asignado al cliente.',
                                FRA = 'Spécifie le nom du vendeur affecté au client.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.',
                                ESP = 'Especifica el id. del usuario responsable del documento.',
                                FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTipML = ENU = 'Specifies the currency of amounts on the sales document.',
                                ESP = 'Especifica la divisa de los importes en el documento de venta.',
                                FRA = 'Spécifie la devise des montants sur le document vente.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTipML = ENU = 'Specifies the date when you created the sales document.',
                                ESP = 'Especifica la fecha en la que se creó el documento de venta.',
                                FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTipML = ENU = 'Specifies the number of the campaign that the document is linked to.',
                                ESP = 'Especifica el número de la campaña a la que está vinculado el documento.',
                                FRA = 'Spécifie le numéro de campagne auquel le document est lié.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTipML = ENU = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.',
                                ESP = 'Especifica si el documento está pendiente, en espera de aprobación, facturado para prepago o ha pasado a la etapa siguiente de procesamiento.',
                                FRA = 'Spécifie si le document est ouvert, est en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.',
                                ESP = 'Especifica una fórmula que calcula la fecha de vencimiento del pago, la fecha del descuento por pronto pago y el importe de descuento por pronto pago en el documento de compra.',
                                FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de l''escompte sur le document achat.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies when the sales invoice must be paid.',
                                ESP = 'Especifica cuándo se debe pagar la factura de venta.',
                                FRA = 'Spécifie la date à laquelle la facture vente doit être payée.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTipML = ENU = 'Specifies the payment discount percentage granted if the customer pays on or before the date entered in the Pmt. Discount Date field.',
                                ESP = 'Especifica el porcentaje de descuento por pronto pago concedido si el cliente paga en o antes de la fecha introducida en el campo Fecha dto. P.P.',
                                FRA = 'Spécifie le pourcentage escompte accordé si le client paie au plus tard à la date saisie dans le champ Date d''escompte.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTipML = ENU = 'Specifies how items on the sales document are shipped to the customer.',
                                ESP = 'Especifica la manera en que los productos del documento de venta se envían al cliente.',
                                FRA = 'Spécifie le mode d''expédition au client des articles figurant sur le document vente.';
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.',
                                ESP = 'Especifica el transportista que se usa para transportar los productos del documento de venta al cliente.',
                                FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.',
                                ESP = 'Especifica el servicio de transportista que se usa para transportar los productos del documento de venta al cliente.',
                                FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
                    Visible = false;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the shipping agent''s package number.',
                                ESP = 'Especifica el número de paquete del transportista.',
                                FRA = 'Spécifie le numéro récépissé du transporteur.';
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTipML = ENU = 'Specifies the date you expect to ship items on the sales document.',
                                ESP = 'Especifica la fecha en la que se prevé enviar los productos en el documento de venta.',
                                FRA = 'Spécifie la date à laquelle vous pensez expédier les articles indiqués sur le document vente.';
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.',
                                ESP = 'Especifica el estado de un movimiento de la cola de proyectos o de una tarea que controla el registro de los pedidos de venta.',
                                FRA = 'Spécifie le statut d''une écriture file d''attente des travaux ou d''une tâche qui gère la validation des commandes vente.';
                    Visible = JobQueueActive;

                }
                //BC UPGRADE SHUKLP03 >> Added field
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                //BC UPGRADE SHUKLP03 << Added field
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the sum of amounts in the Line Amount field on the sales order lines. It is used to calculate the invoice discount of the sales order.',
                                ESP = 'Especifica la suma de los importes del campo Importe línea que consta en las líneas del pedido de venta. Se usa para calcular el descuento en factura del pedido de venta.',
                                FRA = 'Spécifie la somme des montants du champ Montant ligne sur les lignes commande vente. Il est utilisé pour calculer la remise facture de la commande vente.';
                }
            }
        }
        area(factboxes)
        {
            part(Control1902018507; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = false;
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
            group("&Invoice")
            {
                CaptionML = ENU = '&Invoice',
                            ESP = '&Factura',
                            FRA = 'Fa&cture';
                Image = Invoice;
                action(Statistics)
                {
                    CaptionML = ENU = 'Statistics',
                                ESP = 'Estadísticas',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'F7';
                    ToolTipML = ENU = 'View statistical information, such as the value of posted entries, for the record.',
                                ESP = 'Permite ver información estadística del registro, como el valor de los movimientos registrados.';

                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader();
                        COMMIT();
                        PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                ESP = 'Co&mentarios',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTipML = ENU = 'View or add notes about the sales invoice.',
                                ESP = 'Permite ver o agregar notas acerca de la factura de venta.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    CaptionML = ENU = 'Dimensions',
                                ESP = 'Dimensiones',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                ESP = 'Permite ver o editar dimensiones, como el área, el proyecto o el departamento, que pueden asignarse a los documentos de venta y compra para distribuir costes y analizar el historial de transacciones.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Approvals',
                                ESP = 'Aprobaciones',
                                FRA = 'Approbations';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.',
                                ESP = 'Permite ver una lista de los registros en espera de aprobación. Por ejemplo, puede ver quién ha solicitado la aprobación del registro, cuándo se envió y la fecha de vencimiento de la aprobación.',
                                FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN();
                    end;
                }
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Customer',
                                ESP = 'Cliente',
                                FRA = 'Client';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                    ToolTipML = ENU = 'View or edit detailed information about the customer on the selected sales document.',
                                ESP = 'Permite ver o editar la información detallada sobre el cliente en el documento de venta seleccionado.',
                                FRA = 'Affichez ou modifiez des informations détaillées concernant le client sur le document vente sélectionné.';
                }
            }
        }
        area(processing)
        {
            group(Invoice)
            {
                CaptionML = ENU = '&Invoice',
                            ESP = '&Factura',
                            FRA = '&Facture';
                Image = Invoice;
            }
            group(Release)
            {
                CaptionML = ENU = 'Release',
                            ESP = 'Lanzar',
                            FRA = 'Lancer';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    CaptionML = ENU = 'Re&lease',
                                ESP = 'Lan&zar',
                                FRA = '&Lancer';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    CaptionML = ENU = 'Re&open',
                                ESP = '&Volver a abrir',
                                FRA = 'R&ouvrir';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.',
                                ESP = 'Permite volver a abrir el documento para cambiarlo una vez que se haya aprobado. Los documentos aprobados tienen el estado Lanzado y se deben abrir para poder cambiarlos.';

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                CaptionML = ENU = 'Request Approval',
                            ESP = 'Aprobación solic.',
                            FRA = 'Approbation demande achat';
                Image = "Action";
                action(SendApprovalRequest)
                {
                    CaptionML = ENU = 'Send A&pproval Request',
                                ESP = 'Enviar solicitud a&probación',
                                FRA = 'Envoyer demande d''a&pprobation';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Send an approval request.',
                                ESP = 'Envía una solicitud de aprobación.',
                                FRA = 'Envoyez une demande d''approbation.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    CaptionML = ENU = 'Cancel Approval Re&quest',
                                ESP = '&Cancelar solicitud aprobación',
                                FRA = 'Annuler demande d''appro&bation';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Cancel the approval request.',
                                ESP = 'Cancela la solicitud de aprobación.',
                                FRA = 'Annulez la demande d''approbation.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                CaptionML = ENU = 'P&osting',
                            ESP = 'R&egistro',
                            FRA = '&Validation';
                Image = Post;
                action("Test Report")
                {
                    CaptionML = ENU = 'Test Report',
                                ESP = 'Informe prueba',
                                FRA = 'Impression test';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.',
                                ESP = 'Permite ver un informe de prueba para poder encontrar y corregir cualquier error antes de proceder al registro propiamente dicho del diario o el documento.',
                                FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'P&ost',
                                ESP = 'R&egistrar',
                                FRA = '&Valider';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';
                    ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.',
                                ESP = 'Permite finalizar el documento o el diario registrando los importes y las cantidades en las cuentas relacionadas de los libros de la empresa.',
                                FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';

                    trigger OnAction();
                    begin
                        Postsubmit(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Post &Batch")
                {
                    CaptionML = ENU = 'Post &Batch',
                                ESP = 'Registrar por &lotes',
                                FRA = 'Valider par l&ot';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction();
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Post and &Send',
                                ESP = 'Registrar y &enviar',
                                FRA = 'Valider et en&voyer';
                    Ellipsis = true;
                    Image = PostSendTo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.',
                                ESP = 'Permite finalizar y preparar el documento para enviarlo según el perfil que cuenta con las preferencias de envío del cliente, por ejemplo, adjunto en un correo electrónico. La ventana "Enviar documento a" se abre primero para que se pueda confirmar o seleccionar un perfil de envío.',
                                FRA = 'Finalisez et préparez-vous à envoyer le document en fonction du profil d''envoi du client, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';

                    trigger OnAction();
                    begin
                        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
                        Rec.SendToPosting(CODEUNIT::"Sales-Post and Send");
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Remove From Job Queue',
                                ESP = 'Quitar de cola de proyecto',
                                FRA = 'Supprimer de la file d''attente des travaux';
                    Image = RemoveLine;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;
                    ToolTipML = ENU = 'Remove the scheduled processing of this record from the job queue.',
                                ESP = 'Permite quitar el procesamiento programado de este registro de la cola de proyectos.',
                                FRA = 'Supprimez le traitement planifié de cet enregistrement à partir de la file d''attente des travaux.';
                    Visible = JobQueueActive;

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                action(Preview)
                {
                    CaptionML = ENU = 'Preview Posting',
                                ESP = 'Vista previa de registro',
                                FRA = 'Aperçu compta.';
                    Image = ViewPostedOrder;
                    ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.',
                                ESP = 'Permite revisar los diferentes tipos de movimientos que se crearán al registrar el documento o el diario.',
                                FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';

                    trigger OnAction();
                    begin
                        ShowPreview;
                    end;
                }
            }
        }
        area(reporting)
        {
            group(Reports)
            {
                CaptionML = ENU = 'Reports',
                            ESP = 'Informes',
                            FRA = 'États';
                Image = "Report";
                group(FinanceReports)
                {
                    CaptionML = ENU = 'Finance Reports',
                                ESP = 'Informes financieros',
                                FRA = 'États financiers';
                    Image = "Report";
                    action("Report Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Statement',
                                    ESP = 'Extracto',
                                    FRA = 'Relevé';
                        Image = "Report";
                        ToolTipML = ENU = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.',
                                    ESP = 'Permite ver una lista de transacciones del cliente en un período seleccionado, por ejemplo, para enviar al cliente al cierre de un período contable. También permite ver todos los saldos vencidos, sea cual sea el período especificado, o bien elegir que se incluya un rango de antigüedad.',
                                    FRA = 'Affichez une liste des transactions d''un client pour une période sélectionnée, par exemple, à envoyer au client à la clôture d''une période comptable. Vous pouvez choisir d''afficher tous les soldes échus, sans tenir compte de la période spécifiée, ou d''inclure un cumul date.';

                        trigger OnAction();
                        var
                            Customer: Record Customer;
                        begin
                            CODEUNIT.RUN(CODEUNIT::"Customer Layout - Statement", Customer);
                        end;
                    }
                    action("Customer - Balance to Date")
                    {
                        CaptionML = ENU = 'Customer - Balance to Date',
                                    ESP = 'Cliente - Saldo por fechas',
                                    FRA = 'Clients : Écritures ouvertes';
                        Image = "Report";
                        RunObject = Report "Customer - Balance to Date";
                        ToolTipML = ENU = 'View, print, or save customers'' balances on a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.',
                                    ESP = 'Permite ver, imprimir o guardar los saldos de los clientes en una fecha determinada. Puede usar el informe para extraer el ingreso total de ventas al cierre de un período contable o un ejercicio.',
                                    FRA = 'Affichez, imprimez ou enregistrez le solde des clients à une certaine date. Vous pouvez utiliser l''état pour extraire vos revenus de vente totaux à la clôture d''une période ou d''un exercice comptable.';
                    }
                    action("Customer - Trial Balance")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Customer - Trial Balance',
                                    ESP = 'Cliente - Balance sumas y saldos',
                                    FRA = 'Clients : Balance';
                        Image = "Report";
                        RunObject = Report "Customer - Trial Balance";
                        ToolTipML = ENU = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.',
                                    ESP = 'Permite ver el saldo inicial y final de los clientes con movimientos durante un período especificado. El informe se puede utilizar para comprobar que el saldo de un grupo contable de cliente es igual al saldo de la cuenta de contable correspondiente en una fecha determinada.',
                                    FRA = 'Affichez le solde d''ouverture et final pour les clients présentant des écritures au cours d''une période spécifiée. L''état peut être utilisé pour vérifier que le solde pour un groupe comptabilisation client est égal à celui du compte général correspondant à une certaine date.';
                    }
                    action("Customer - Detail Trial Bal.")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Customer - Detail Trial Bal.',
                                    ESP = 'Cliente - Movimientos',
                                    FRA = 'Clients : Grand livre client';
                        Image = "Report";
                        RunObject = Report "Customer - Detail Trial Bal.";
                        ToolTipML = ENU = 'View the balance for customers with balances on a specified date. For example, the report can be used at the close of an accounting period or for an audit.',
                                    ESP = 'Permite ver el saldo de los clientes que tienen saldos en una fecha determinada. Por ejemplo, el informe puede usarse al cierre de un período contable o para una auditoría.',
                                    FRA = 'Affichez le solde des clients présentant des soldes à une date donnée. Par exemple, l''état peut être utilisé lors de la clôture d''une période comptable ou pour un audit.';
                    }
                    action("Customer - Summary Aging")
                    {
                        CaptionML = ENU = 'Customer - Summary Aging',
                                    FRA = 'Clients : Échéancier';
                        Image = "Report";
                        RunObject = Report "Customer - Summary Aging";
                        ToolTipML = ENU = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.',
                                    FRA = 'Affichez, imprimez ou enregistrez un résumé des totaux dus de chaque client, divisé en trois périodes. Cet état sert à décider quand émettre des relances, à évaluer la solvabilité d''un client ou à préparer des analyses de liquidités.';
                    }
                    action("Customer - Detailed Aging")
                    {
                        CaptionML = ENU = 'Customer - Detailed Aging',
                                    FRA = 'Client - Écritures échues';
                        Image = "Report";
                        RunObject = Report "Customer Detailed Aging";
                        ToolTipML = ENU = 'View, print, or save a detailed list of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.',
                                    FRA = 'Affichez, imprimez ou enregistrez une liste détaillée des totaux dus de chaque client, divisée en trois périodes. Cet état sert à décider quand émettre des relances, à évaluer la solvabilité d''un client ou à préparer des analyses de liquidités.';
                    }
                    action("Aged Accounts Receivable")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Aged Accounts Receivable',
                                    ESP = 'Antigüedad cobros',
                                    FRA = 'Comptabilité client âgée';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Receivable";
                        ToolTipML = ENU = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.',
                                    ESP = 'Permite ver un resumen del vencimiento de los pagos o los pagos vencidos de los clientes, divididos en cuatro periodos. Es necesario especificar la fecha a partir de la cual se desea calcular la antigüedad y la duración del periodo para el que cada columna contendrá datos.',
                                    FRA = 'Affichez un aperçu des dates d''échéance des paiements dus au client, divisé en quatre périodes. Vous devez spécifier la date à partir de laquelle vous souhaitez que le cumul soit calculé et la durée de la période pour laquelle chaque colonne contiendra des données.';
                    }
                    action("Customer - Payment Receipt")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Customer - Payment Receipt',
                                    ESP = 'Clientes - Pagos recibidos',
                                    FRA = 'Reçu paiement client';
                        Image = "Report";
                        RunObject = Report "Customer - Payment Receipt";
                        ToolTipML = ENU = 'View a document showing which customer ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the customer.',
                                    ESP = 'Permite ver un documento que muestra los movimientos de cliente en los que se liquidó un pago. Este informe puede usarse como albarán de pago para enviar al cliente.',
                                    FRA = 'Affichez un document présentant les écritures comptables client avec lesquelles un paiement a été lettré. Cet état peut être utilisé comme reçu de paiement à envoyer au client.';
                    }
                }
                group(SalesReports)
                {
                    CaptionML = ENU = 'Sales Reports',
                                ESP = 'Informes de ventas',
                                FRA = 'États vente';
                    Image = "Report";
                    action("Customer - Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Customer - Top 10 List',
                                    ESP = 'Cliente - Listado 10 mejores',
                                    FRA = 'Clients : Palmarès';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTipML = ENU = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.',
                                    ESP = 'Permite ver los clientes que más compran o que más deben en un período seleccionado. Solo se incluirán los clientes que hayan comprado durante el período seleccionado o que tengan algún saldo al final de este.',
                                    FRA = 'Affichez les clients qui achètent le plus ou qui doivent le plus d''argent au cours d''une période sélectionnée. Seuls les clients qui ont des achats pour cette période ou un solde à la fin de la période seront inclus.';
                    }
                    action("Customer - Sales List")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Customer - Sales List',
                                    ESP = 'Lista ventas - cliente',
                                    FRA = 'Clients : Liste des ventes';
                        Image = "Report";
                        RunObject = Report "Customer - Sales List";
                        ToolTipML = ENU = 'View customer sales in a period, for example, to report sales activity to customs and tax authorities.',
                                    ESP = 'Permite ver las ventas a clientes en un período, por ejemplo, para informar de la actividad de ventas a las autoridades fiscales y aduaneras.',
                                    FRA = 'Affichez les ventes client au cours d''une période, par exemple, pour signaler une activité vente aux autorités douanières et fiscales.';
                    }
                    action("Sales Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Sales Statistics',
                                    ESP = 'Estadísticas ventas',
                                    FRA = 'Statistiques vente';
                        Image = "Report";
                        RunObject = Report "Sales Statistics";
                        ToolTipML = ENU = 'View the customer''s total cost, sale, and profit over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted cost, sales, profit, invoice discount, payment discount, and profit percentage in three adjustable periods.',
                                    ESP = 'Permite ver el total de costes, ventas y beneficios del cliente a lo largo del tiempo para analizar las tendencias de ganancias. Este informe muestra importes originales y actualizados de costes, ventas, beneficios, descuentos en factura, descuentos por pronto pago y porcentaje de beneficio durante tres períodos ajustables.',
                                    FRA = 'Affichez le coût total, les ventes et la marge à long terme du client, par exemple, pour analyser les tendances bénéficiaires. L''état affiche les montants des coûts originaux et ajustés, des ventes, de la marge, de la remise facture et de l''escompte, ainsi que le pourcentage marge sur vente au cours de trois périodes sélectionnables.';
                    }
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
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();
        JobQueueActive := SalesSetup.JobQueueActive();

        Rec.CopySellToCustomerFilter();

        //BC UPGRADE SHUKLP03 >> Added code
        //HEI.01>>
        //PATHAA02>>
        if docsubtypecodesetup.GET() then begin
            docsubtypecodesetup.TESTFIELD("Debit Memo- Reinvoice Recharge");
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Document Subtype Code FND", docsubtypecodesetup."Debit Memo- Reinvoice Recharge");
            Rec.FILTERGROUP(0);
            //PATHAA02<<
            // end;
            //BC UPGRADE SHUKLP03 << Added code
        end;
    end;

    var
        DummyApplicationAreaSetup: Record "Application Area Setup";
        ReportPrint: Codeunit "Test Report-Print";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenPostedSalesInvQst: TextConst ENU = 'The invoice has been posted and moved to the Posted Sales Invoice list.\\Do you want to open the posted invoice?', ESP = 'La factura se registró y se movió a la lista de facturas de venta registradas.\\¿Desea abrir la factura registrada?', FRA = 'La facture a été validée et déplacée dans la liste des factures vente enregistrées.\\Souhaitez-vous ouvrir la facture validée ?';
        CanCancelApprovalForRecord: Boolean;
        docsubtypecodesetup: Record "Doc Subtype Code Setup FND";

    procedure ShowPreview();
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure Postsubmit(PostingCodeunitID: Integer);
    var
        PreAssignedNo: Code[20];
    begin
        //if DummyApplicationAreaSetup.IsFoundationEnabled then begin //BC UPGRADE SIVA Microsoft removed the check
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
        PreAssignedNo := Rec."No.";
        //end;

        Rec.SendToPosting(PostingCodeunitID);

        //if DummyApplicationAreaSetup.IsFoundationEnabled then //BC UPGRADE SIVA Microsoft removed the check
        ShowPostedConfirmationMessage(PreAssignedNo);
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20]);
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.SETRANGE("Pre-Assigned No.", PreAssignedNo);
        if SalesInvoiceHeader.FINDFIRST() then
            if DIALOG.CONFIRM(OpenPostedSalesInvQst, false) then
                PAGE.RUN(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
    end;
}

