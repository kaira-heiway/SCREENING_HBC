page 51031 "Outstanding Purchase Order CBN"
{
    // version HEI.04

    // HEI.01 Defect 920 IBM.NAIKH01 21.12.2017
    //   # Created a New page to show all the outstandinng PO.
    // 
    // HEI.02 Defect 920 IBM.NAIKH01 16.01.2018
    //   # Modified the Page with comments form Sevtalana
    // 
    // HEI.03  CHG2167378 HB3072 NORRIQ KOROLA04 12.10.2022
    //   #Page field were replaced: "Requester No." -> "Requesters No.",
    //    "Document Date" -> "Header Document Date"
    //   #"Header Created By" - field added
    // 
    // HEI.04  CHG2167378 HB3072 NORRIQ KOROLA04 17.10.2022
    //   #fields places were changed

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Request Approval,Print',
                                 ESP = 'Nuevo,Procesar,Informar,Solicitar aprobación,Imprimir',
                                 FRA = 'Nouveau,Traiter,Déclarer,Demander une approbation,Imprimer';
    RefreshOnActivate = true;
    SourceTable = "Purchase Line";
    SourceTableView = ORDER(Ascending)
                      where("Outstanding Quantity" = FILTER(<> 0),
                            "Delivery Finalized FND" = CONST(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; rec."Document No.")
                {
                    CaptionML = ENU = 'No.',
                                FRA = 'N° document';
                    ToolTip = 'Specifies the document number.';
                }
                field("PurchHdr.Status"; PurchHdr.Status)
                {
                    Caption = 'Status';
                    ToolTipML = ENU = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.',
                                ESP = 'Especifica si el registro está abierto, en espera de aprobación, facturado para prepago o ha pasado a la etapa siguiente de procesamiento.',
                                FRA = 'Spécifie si l''enregistrement est ouvert, en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    CaptionML = ENU = 'Buy-from Vendor No.',
                                FRA = 'N° fournisseur';
                    ToolTipML = ENU = 'Specifies the number of the vendor you buy from.',
                                ESP = 'Especifica el número del proveedor a quien se le compra.',
                                FRA = 'Spécifie le numéro du fournisseur auprès duquel vous effectuez vos achats.';
                }
                field("PurchHdr.""Order Address Code"""; PurchHdr."Order Address Code")
                {
                    Caption = 'Order Address Code';
                    ToolTipML = ENU = 'Specifies the order address code linked to the relevant vendor''s order address.',
                                ESP = 'Especifica el código de dirección del pedido vinculado a la dirección de pedido del proveedor correspondiente.',
                                FRA = 'Spécifie le code adresse commande lié à l''adresse de commande du fournisseur concerné.';
                    Visible = false;
                }
                field("PurchHdr.""Buy-from Vendor Name"""; PurchHdr."Buy-from Vendor Name")
                {
                    ApplicationArea = Suite;
                    Caption = 'Buy-from Vendor Name';
                    ToolTipML = ENU = 'Specifies the name of the vendor who delivers the items.',
                                ESP = 'Permite especificar el nombre del proveedor que envió los productos.',
                                FRA = 'Spécifie le nom du fournisseur qui livre les articles.';
                }
                field("<Vendor Authorization No.>"; PurchHdr."Vendor Authorization No.")
                {
                    Caption = 'Vendor Authorization No.';
                    ToolTipML = ENU = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).',
                                ESP = 'Especifica el número de identificación del acuerdo de compensación, a veces denominado Número RMA (Autorización de devolución de materiales).',
                                FRA = 'Spécifie le numéro d''identification d''un accord de compensation. Ce numéro est parfois appelé numéro d''autorisation de retour de matériel (RMA).';
                }
                field("PurchHdr.""Buy-from Post Code"""; PurchHdr."Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code';
                    ToolTipML = ENU = 'Specifies the ZIP code of the address.',
                                ESP = 'Especifica el código postal de la dirección.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("PurchHdr.""Buy-from Country/Region Code"""; PurchHdr."Buy-from Country/Region Code")
                {
                    Caption = 'Buy-from Country/Region Code';
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                ESP = 'Especifica el código de país o región de la dirección.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("PurchHdr.""Buy-from Contact"""; PurchHdr."Buy-from Contact")
                {
                    Caption = 'Buy-from Contact';
                    ToolTipML = ENU = 'Specifies the name of the person to contact about shipment of the item from this vendor.',
                                ESP = 'Especifica el nombre de la persona con la que debe contactar para tratar acerca del envío del producto de este proveedor.',
                                FRA = 'Spécifie le nom de la personne à contacter à propos de l''expédition de l''article chez le fournisseur.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    CaptionML = ENU = 'Pay-to Vendor No.',
                                FRA = 'N° fournisseur à payer';
                    ToolTipML = ENU = 'Specifies the vendor who is sending the invoice.',
                                ESP = 'Especifica el proveedor que envía la factura.',
                                FRA = 'Spécifie le fournisseur envoyant la facture.';
                    Visible = false;
                }
                field("PurchHdr.""Pay-to Name"""; PurchHdr."Pay-to Name")
                {
                    Caption = 'Pay-to Name';
                    ToolTipML = ENU = 'Specifies the name of the vendor sending the invoice.',
                                ESP = 'Especifica el nombre del proveedor que envía la factura.',
                                FRA = 'Spécifie le nom du fournisseur envoyant la facture.';
                    Visible = false;
                }
                field("PurchHdr.""Pay-to Post Code"""; PurchHdr."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code';
                    ToolTipML = ENU = 'Specifies the ZIP code of the address.',
                                ESP = 'Especifica el código postal de la dirección.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("PurchHdr.""Pay-to Country/Region Code"""; PurchHdr."Pay-to Country/Region Code")
                {
                    Caption = 'Pay-to Country/Region Code';
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                ESP = 'Especifica el código de país o región de la dirección.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("PurchHdr.""Pay-to Contact"""; PurchHdr."Pay-to Contact")
                {
                    Caption = 'Pay-to Contact';
                    ToolTipML = ENU = 'Specifies the name of the person to contact about an invoice from this vendor.',
                                ESP = 'Especifica el nombre de la persona con la que debe contactar para tratar acerca de cualquier factura procedente de este proveedor.',
                                FRA = 'Spécifie le nom de la personne à contacter au sujet d''une facture émise par ce fournisseur.';
                    Visible = false;
                }
                field("PurchHdr.""Ship-to Code"""; PurchHdr."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                    ToolTipML = ENU = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.',
                                ESP = 'Especifica un código de envío si desea una dirección de envío diferente a la que se ha introducido automáticamente.',
                                FRA = 'Spécifie un code destinataire si vous souhaitez utiliser une adresse destinataire différente de celle automatiquement renseignée.';
                    Visible = false;
                }
                field("PurchHdr.""Ship-to Name"""; PurchHdr."Ship-to Name")
                {
                    Caption = 'Ship-to Name';
                    ToolTipML = ENU = 'Specifies the name of the company at the address to which you want the items to be shipped.',
                                ESP = 'Especifica el nombre de la empresa que consta en la dirección a la que quiere enviar los productos.',
                                FRA = 'Spécifie le nom de la société située à l''adresse à laquelle vous voulez faire livrer les articles.';
                    Visible = false;
                }
                field("PurchHdr.""Ship-to Post Code"""; PurchHdr."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code';
                    ToolTipML = ENU = 'Specifies the ZIP code of the address.',
                                ESP = 'Especifica el código postal de la dirección.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("PurchHdr.""Ship-to Country/Region Code"""; PurchHdr."Ship-to Country/Region Code")
                {
                    Caption = 'Ship-to Country/Region Code';
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                ESP = 'Especifica el código de país o región de la dirección.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("PurchHdr.""Ship-to Contact"""; PurchHdr."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact';
                    ToolTipML = ENU = 'Specifies the name of a contact person for the address where the items should be shipped.',
                                ESP = 'Especifica el nombre de una persona de contacto en la dirección a la que deben enviarse los productos.',
                                FRA = 'Spécifie le nom d''une personne contact pour l''adresse à laquelle les articles doivent être livrés.';
                    Visible = false;
                }
                field("PurchHdr.""Posting Date"""; PurchHdr."Posting Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posting Date';
                    ToolTipML = ENU = 'Specifies the date when the posting of the purchase document will be recorded.',
                                ESP = 'Especifica la fecha en que se registrará el registro del documento de compra.',
                                FRA = 'Spécifie la date à laquelle la validation du document achat sera validée.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.',
                                ESP = 'Especifica el código de la dimensión del acceso directo 1.',
                                FRA = 'Spécifie le code pour Raccourci axe 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.',
                                ESP = 'Especifica el código de la dimensión del acceso directo 2.',
                                FRA = 'Spécifie le code pour Raccourci axe 2.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    CaptionML = ENU = 'Responsibility Center',
                                FRA = 'Centre de gestion';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                /* //BC Upgrade Manisha Drink it code commented>>
                field("Physical Location Group Code";Rec."Physical Location Group Code")
                {
                    CaptionML = ENU='Physical Location Group Code',
                                FRA='Code groupe magasin réel';
                    Visible = false;
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field("Location Code"; Rec."Location Code")
                {
                    CaptionML = ENU = 'Location Code',
                                FRA = 'Code magasin';
                    ToolTipML = ENU = 'Specifies a code for the location where you want the items to be placed when they are received.',
                                ESP = 'Especifica el código de almacén donde quiere que se guarden los productos recibidos.',
                                FRA = 'Spécifie un code pour le magasin dans lequel vous souhaitez que les articles soient stockés lorsqu''ils sont réceptionnés.';
                }
                field("PurchHdr.""Purchaser Code"""; PurchHdr."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchaser Code';
                    ToolTipML = ENU = 'Specifies which purchaser is assigned to the vendor.',
                                ESP = 'Especifica el comprador asignado al proveedor.',
                                FRA = 'Spécifie l''acheteur affecté au fournisseur.';
                    Visible = false;
                }
                field("PurchHdr.""Assigned User ID"""; PurchHdr."Assigned User ID")
                {
                    Caption = 'Assigned User ID';
                    ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.',
                                ESP = 'Especifica el id. del usuario responsable del documento.',
                                FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
                }
                field("Requesters ID"; Rec."Requesters ID FND")
                {
                    CaptionML = ENU = 'Requester ID',
                                FRA = 'ID demandeur';
                    Description = 'DITW17.00.02 DIT-770 #144';
                    ToolTip = 'Specifies the value of the Requesters ID field.';
                }
                field("Header Created By"; Rec."Header Created By FND")
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Header Document Date"; Rec."Header Document Date FND")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Document Date',
                                FRA = 'Date document';
                    ToolTipML = ENU = 'Specifies the date of the vendor''s invoice.',
                                ESP = 'Especifica la fecha de la factura del proveedor.',
                                FRA = 'Spécifie la date de la facture du fournisseur.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Currency Code',
                                FRA = 'Code devise';
                    ToolTipML = ENU = 'Specifies the code of the currency of the amounts on the purchase lines.',
                                ESP = 'Especifica el código de divisa de los importes de las líneas de compra.',
                                FRA = 'Spécifie le code de la devise des montants figurant sur les lignes achat.';
                    Visible = false;
                }
                /* //BC Upgrade Manisha Drink it code commented>>

                field("Disc.Promo. Order Calculated"; Rec."Disc.Promo. Order Calculated")
                {
                    CaptionML = ENU = 'Disc.Promo. Order Calculated',
                                FRA = 'Remise-Promotion cmde. calculé';
                    Visible = false;
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field("PurchHdr.""Campaign No."""; PurchHdr."Campaign No.")
                {
                    Caption = 'Campaign No.';
                    Description = 'DIT-715 #244';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Campaign No. field.';
                }
                field("PurchHdr.""Applies-to Doc. Type"""; PurchHdr."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                    Description = 'DIT-715 #244';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    CaptionML = ENU = 'Expected Receipt Date',
                                FRA = 'Date réception prévue';
                    Description = 'DIT-715 #244';
                    Visible = false;
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse.';
                }
                field("PurchHdr.""Payment Terms Code"""; PurchHdr."Payment Terms Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Payment Terms Code';
                    ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.',
                                ESP = 'Especifica una fórmula que calcula la fecha de vencimiento del pago, la fecha del descuento por pronto pago y el importe de descuento por pronto pago en el documento de compra.',
                                FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de l''escompte sur le document achat.';
                    Visible = false;
                }
                field("PurchHdr.""Due Date"""; PurchHdr."Due Date")
                {
                    ApplicationArea = Suite;
                    Caption = 'Due Date';
                    ToolTipML = ENU = 'Specifies when the purchase invoice is due for payment.',
                                ESP = 'Permite especificar la fecha de vencimiento del pago de la factura de compra.',
                                FRA = 'Spécifie la date à laquelle la facture achat doit être payée.';
                    Visible = false;
                }
                field("PurchHdr.""Payment Discount %"""; PurchHdr."Payment Discount %")
                {
                    Caption = 'Payment Discount %';
                    ToolTipML = ENU = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.',
                                ESP = 'Especifica el porcentaje de descuento por pronto pago concedido si el pago se realiza en o antes de la fecha especificada en el campo Fecha dto. P.P.',
                                FRA = 'Spécifie le pourcentage escompte accordé si le paiement est effectué au plus tard à la date saisie dans le champ Date d''escompte.';
                    Visible = false;
                }
                field("PurchHdr.""Payment Method Code"""; PurchHdr."Payment Method Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Payment Method Code';
                    ToolTipML = ENU = 'Specifies how payment for the purchase document must be submitted.',
                                ESP = 'Especifica cómo debe enviarse el pago del documento de compra.',
                                FRA = 'Spécifie la manière dont le paiement du document achat doit être réalisé.';
                    Visible = false;
                }
                field("PurchHdr.""Shipment Method Code"""; PurchHdr."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                    ToolTipML = ENU = 'Specifies the code that represents the shipment method for this purchase.',
                                ESP = 'Especifica el código que representa las condiciones de envío de esta compra.',
                                FRA = 'Spécifie le code qui représente les conditions de livraison de cet achat.';
                    Visible = false;
                }
                field("PurchHdr.""Shipment Method Location"""; PurchHdr."Shipment Method Location FND")
                {
                    Caption = 'Shipment Method Location';
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Requested Receipt Date',
                                FRA = 'Date réception demandée';
                    ToolTipML = ENU = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.',
                                ESP = 'Permite especificar la fecha en la desea que el proveedor envíe el pedido a la dirección de envío. El valor del campo se usa para calcular la última fecha en la que puede solicitar los productos de forma que se envíen en la fecha de recepción solicitada. Si no necesita que se produzca el envío en una fecha específica, puede dejar el campo en blanco.',
                                FRA = 'Spécifie la date à laquelle vous souhaitez que le fournisseur livre les articles à l''adresse destinataire. La valeur du champ est utilisée pour calculer la date limite de commande garantissant la livraison des articles à la date de réception demandée. Si vous ne souhaitez pas indiquer une date de livraison, vous pouvez laisser ce champ vide.';
                    Visible = false;
                }
                /* //BC Upgrade Manisha Drink it code commented>>

                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    CaptionML = ENU = 'Shipping Agent Code',
                                FRA = 'Code transporteur';
                    Visible = false;
                }
                

                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    CaptionML = ENU = 'Shipping Agent Service Code',
                                FRA = 'Code prestation transporteur';
                    Visible = false;
                }
                
                field(Distance; Rec.Distance)
                {
                    CaptionML = ENU = 'Distance',
                                FRA = 'Distance';
                    Visible = false;
                }
                field("PurchHdr.""Truck Code"""; PurchHdr."Truck Code")
                {
                    Caption = 'Truck Code';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("PurchHdr.""Driver Code"""; PurchHdr."Driver Code")
                {
                    Caption = 'Driver Code';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Shipping Charge Per"; "Shipping Charge Per")
                {
                    CaptionML = ENU = 'Shipping Charge Per',
                                FRA = 'Frais transport par';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("PurchHdr.""Maximum Weight"""; PurchHdr."Maximum Weight")
                {
                    Caption = 'Maximum Weight';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("PurchHdr.""Maximum Cubage"""; PurchHdr."Maximum Cubage")
                {
                    Caption = 'Maximum Cubage';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                
                field("PurchHdr.""Total Weight"""; PurchHdr."Total Weight")
                {
                    Caption = 'Total Weight';
                    Visible = false;
                }
                field("PurchHdr.""Total Cubage"""; PurchHdr."Total Cubage")
                {
                    Caption = 'Total Cubage';
                    Visible = false;
                }
                field("PurchHdr.""Link Purch. Document Type"""; PurchHdr."Link Purch. Document Type")
                {
                    Caption = 'Link Purch. Document Type';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("PurchHdr.""Link Purch. Document No."""; PurchHdr."Link Purch. Document No.")
                {
                    Caption = 'Link Purch. Document No.';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("PurchHdr.""Fiscal Representative No."""; PurchHdr."Fiscal Representative No.")
                {
                    Caption = 'Fiscal Representative No.';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("PurchHdr.""Vendor Tax Registration No."""; PurchHdr."Vendor Tax Registration No.")
                {
                    Caption = 'Vendor Tax Registration No.';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("PurchHdr.""Vendor Tax Warehouse Ref."""; PurchHdr."Vendor Tax Warehouse Ref.")
                {
                    Caption = 'Vendor Tax Warehouse Ref.';
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                
                field("PurchHdr.""Sundry Vendor"""; PurchHdr."Sundry Vendor")
                {
                    Caption = 'Sundry Vendor';
                    Editable = false;
                    Visible = false;
                }
                field("PurchHdr.""Last changed User ID"""; PurchHdr."Last changed User ID")
                {
                    Caption = 'Last changed User ID';
                    Editable = false;
                }
                */ //BC Upgrade Manisha Drink it code commented<<
                field("Last Changed Date/Time"; rec."Last Changed Date/Time FND")
                {
                    Caption = 'Last Changed Date/Time';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Last Changed Date/Time field.';
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Amount',
                                FRA = 'Montant';
                    ToolTip = 'Specifies the sum of amounts in the Line Amount field on the purchase order lines.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Amount Including VAT',
                                FRA = 'Montant TTC';
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    Caption = 'SRM Contract Type';
                    ToolTip = 'Specifies the value of the SRM Contract Type field.';
                }
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    Caption = 'SRM Contract No.';
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    Caption = 'SRM Order No.';
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    Caption = 'Valid From';
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    Caption = 'Valid To';
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field("PurchHdr.Channel"; PurchHdr."Channel FND")
                {
                    Caption = 'Channel';
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
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the line type.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item or service on the line.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies information in addition to the description.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the name of the unit of measure for the item, such as 1 bottle or 1 piece.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item that will be specified on the line.';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ToolTip = 'Specifies how many units on the order line have not yet been received.';
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ToolTip = 'Specifies the quantity that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ToolTip = 'Specifies the quantity of items that remains to be received.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the direct cost of one item unit.';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ToolTip = 'Specifies the unit cost of the item on the line.';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ToolTip = 'Specifies the value of the VAT % field.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ToolTip = 'Specifies the line discount percentage that is valid for the item on the line.';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ToolTip = 'Specifies the amount of the line discount that will be granted on the purchase line.';
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ToolTip = 'Specifies the price for one unit of the item.';
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ToolTip = 'Specifies the value of the Outstanding Amount field.';
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Qty. Rcd. Not Invoiced field.';
                }
                field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
                {
                    ToolTip = 'Specifies the value of the Amt. Rcd. Not Invoiced field.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as received.';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as invoiced.';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.';
                }
                field("Outstanding Amount (LCY)"; Rec."Outstanding Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Outstanding Amount (LCY) field.';
                }
                field("Amt. Rcd. Not Invoiced (LCY)"; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    ToolTip = 'Specifies the value of the Amt. Rcd. Not Invoiced (LCY) field.';
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ToolTip = 'Specifies how many item units on this line have been reserved.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies a bin code for the item.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the unit of measure code that is valid for the purchase line.';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ToolTip = 'Specifies the value of the Quantity (Base) field.';
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    ToolTip = 'Specifies the outstanding quantity expressed in the base units of measure.';
                }
                field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. to Invoice (Base) field.';
                }
                field("Qty. to Receive (Base)"; Rec."Qty. to Receive (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. to Receive (Base) field.';
                }
                field("Qty. Rcd. Not Invoiced (Base)"; Rec."Qty. Rcd. Not Invoiced (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. Rcd. Not Invoiced (Base) field.';
                }
                field("Qty. Received (Base)"; Rec."Qty. Received (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. Received (Base) field.';
                }
                field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
                {
                    ToolTip = 'Specifies the value of the Qty. Invoiced (Base) field.';
                }
                field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
                {
                    ToolTip = 'Specifies the reserved quantity of the item expressed in base units of measure.';
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ToolTip = 'Specifies the FA posting date if you have selected Fixed Asset in the Type field for this line.';
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ToolTip = 'Specifies the FA posting type if you have selected Fixed Asset in the Type field for this line.';
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ToolTip = 'Specifies the quantity of the item charge that will be assigned when you post this line.';
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ToolTip = 'Specifies how much of the item charge that has been assigned.';
                }
                field("CMG Code"; Rec."CMG Code FND")
                {
                    ToolTip = 'Specifies the value of the CMG Code field.';
                }
                field("Delivery Finalized"; Rec."Delivery Finalized FND")
                {
                    ToolTip = 'Specifies the value of the Delivery Finalized field.';
                }
                field("Remaining Amount"; Rec."Remaining Amount FND")
                {
                    ToolTip = 'Specifies the value of the Remaining Amount field.';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ToolTip = 'Specifies the value of the Routing No. field.';
                }
                field(Finished; Rec.Finished)
                {
                    ToolTip = 'Specifies that any related service or operation is finished.';
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
            part(Control50077; "Vendor Details FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
            }
            systempart(Control50076; Links)
            {
                Visible = false;
            }
            systempart(Control50073; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            //caption = 'Action';//BC Upgrade Manisha Caption can't be action
            action("Edit Outstanding PO")
            {
                Image = Edit;
                RunObject = Page "Purchase Order";
                RunPageLink = "No." = FIELD("Document No."),
                              "Document Type" = FILTER(Order);
                ShortCutKey = 'Return';
                ToolTip = 'Executes the Edit Outstanding PO action.';
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean;
    var
        PurchaseOrders: Record "Purchase Line";
    begin
        //HEI.01>>
        if Rec.FIND(Which) then begin
            PurchaseOrders := Rec;
            while true do begin
                if OKToShowRecord() then
                    exit(true);
                if Rec.NEXT(1) = 0 then begin
                    Rec := PurchaseOrders;
                    if Rec.FIND(Which) then
                        while true do begin
                            if OKToShowRecord() then
                                exit(true);
                            if Rec.NEXT(-1) = 0 then
                                exit(false);
                        end;
                end;
            end;
        end;
        exit(false);
        //HEI.01<<
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    var
        PurchaseOrders: Record "Purchase Line";
        NextSteps: Integer;
        RealSteps: Integer;
    begin
        //HEI.01>>
        if Steps = 0 then
            exit;

        PurchaseOrders := Rec;
        repeat
            NextSteps := Rec.NEXT(Steps / ABS(Steps));
            if OKToShowRecord() then begin
                RealSteps := RealSteps + NextSteps;
                PurchaseOrders := Rec;
            end;
        until (NextSteps = 0) or (RealSteps = Steps);
        Rec := PurchaseOrders;
        Rec.FIND();
        exit(RealSteps);
        //HEI.01<<
    end;

    trigger OnOpenPage();
    begin
        //HEI.01>>
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Document Type", Rec."Document Type"::Order);
        //SETRANGE(Status,Status::Released);  HEI.02
        Rec.FILTERGROUP(0);
        //HEI.01<<
    end;

    var
        PurchHdr: Record "Purchase Header";
        Flag: Boolean;

    local procedure OKToShowRecord(): Boolean;
    begin
        //<<HEI.02
        PurchHdr.SETRANGE("Document Type", Rec."Document Type");
        PurchHdr.SETRANGE("No.", Rec."Document No.");
        PurchHdr.SETRANGE(PurchHdr.Status, PurchHdr.Status::Released);
        if PurchHdr.findset() then
            Flag := true
        else
            Flag := false;

        exit(Flag);

        //>> HEI.02
    end;
}

