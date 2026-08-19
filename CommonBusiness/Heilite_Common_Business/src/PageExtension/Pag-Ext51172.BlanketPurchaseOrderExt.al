pageextension 51172 BlanketPurchaseOrderExtCBN extends "Blanket Purchase Order"
{
    //     DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    // DITW15.00.00.39 DDR 19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  call function SetDisableRefreshLines() before each report
    //                                                  (don't use the <RunObject> property)

    // FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)

    // MANXL7.00.001 DAT 26/02/2014 #17: Added field "Valid Until"

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0105.1
    //                             copied release and reopen functionality from purchase invoice.
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4

    // HEI.01 HLSRM02 IBM LAZARE02 27.07.2017
    //   #New fields for SRM integration on new tab SRM

    // HEI.02 HLSRM02 IBM LAZARE02 12.10.2017
    //   # Set header tabs as not editable
    //   # Change PurchLines subpage to Page 50162
    //   # New fasttab Call-Off

    // HEI.03 HLSRM02 IBM LAZARE02 24.11.2017
    //   # New action "Make Return Order"
    // HEI.04 RFC-CHG0246348 IBM.SS 16.01.2019
    //   #Field added for Item category
    //   #field Purch Reason Code displayed on General Tab
    //   #Code added to make Purch. Reason Code Mandatory
    // HEI.05 FDD-Ethiopia_Prepayment HT628 03.07.2019
    //   # new tab Prepayment
    //   # add new fields to tab Prepayment :
    //     "Prepayment %"
    //     "Compress Prepayment"
    //     "Prepmt. Payment Terms Code"
    //     "Prepmt. Payment Discount %"
    //   # new global variable ActivePrepayment IncludeInDataset = true
    //   # new code in OnAfterGetCurrentRecord
    //   # change the Editable property for the above prepayment fields
    // HEI.07 CHG2046174 IBM Shankj03
    //   # Field added "Lead Time Calculation.

    // HEI.08 CHG2083110 IBM NANDIS01 13.10.2020 - Sty Buyer unable to add prepayment term in Blanket Purchase Order
    //   # Move the code against HE.05 as it was missed in A and P
    // HEI.09 CHG2122948 IBM BHATTA09 30.08.2021
    //   # Code added to bypass hardcoded 'Super' in case of manual work
    //--------------------------------------------------------------------------------------------------
    //BC Upgrade SHARMP16-- Inerface code related shifted to interface Ext
    //>>HEI.09-- shufted to Interface Ext

    layout
    {
        modify(PurchLines)
        {
            Visible = false;
            Enabled = false;

        }//BC Upgrade SHARMP16-- remove the base page and add the custom page same as NAV
        modify(General)
        {
            CaptionML = ENU = 'General', ESP = 'General', FRA = 'Général';

            //Unsupported feature: Change Editable on "General(Control 1)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.', ESP = 'Especifica el número del documento de compra. El campo solo se muestra si no se configuró una serie numérica para el tipo de documento de compra o si se selecciona el campo Numeración manual para la serie numérica.';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Vendor', ESP = 'Proveedor', FRA = 'Fournisseur';
            ToolTipML = ENU = 'Specifies the name of the vendor who sends the items. The field is filled automatically when you fill the Buy-from Vendor No. field.', ESP = 'Especifica el nombre del proveedor que envía los artículos. El campo se rellena de manera automática al rellenar el campo Compra a-N.º proveedor.';
        }
        modify("Buy-from")
        {
            CaptionML = ENU = 'Buy-from', ESP = 'Dirección de compra', FRA = 'Fournisseur';
        }
        modify("Buy-from Address")
        {
            CaptionML = ENU = 'Address', ESP = 'Dirección', FRA = 'Adresse';
            ToolTipML = ENU = 'Specifies the address of the vendor who ships the items.', ESP = 'Especifica la dirección del proveedor que envía los artículos.';
        }
        modify("Buy-from Address 2")
        {
            CaptionML = ENU = 'Address 2', ESP = 'Dirección 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 91)". Please convert manually.

            ToolTipML = ENU = 'Specifies additional address information.', ESP = 'Especifica información adicional de la dirección.';
        }
        modify("Buy-from Post Code")
        {
            CaptionML = ENU = 'ZIP Code', ESP = 'Código postal', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', ESP = 'Especifica el código postal.';
        }
        modify("Buy-from City")
        {
            CaptionML = ENU = 'City', ESP = 'Población', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 93)". Please convert manually.

            ToolTipML = ENU = 'Specifies the city of the vendor who ships the items.', ESP = 'Especifica el municipio/ciudad del proveedor que envía los artículos.';
        }
        modify("Buy-from Contact No.")
        {
            CaptionML = ENU = 'Contact No.', ESP = 'Nº contacto', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of your contact at the vendor.', ESP = 'Especifica el número de su contacto en el proveedor.';
        }
        modify("Buy-from Contact")
        {
            CaptionML = ENU = 'Contact', ESP = 'Contacto', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact about shipment of the item from this vendor.', ESP = 'Especifica el nombre de la persona con quien contactarse acerca del envío del artículo de este proveedor.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the vendor created the purchase document.', ESP = 'Especifica la fecha en que el proveedor creó el documento de compra.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields.', ESP = 'Especifica el vencimiento de la factura. El programa calcula la fecha en función de los campos Cód. términos pago y Fecha de documento.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code linked to the relevant vendor''s order address.', ESP = 'Especifica el código de dirección del pedido vinculado a la dirección de pedido del proveedor correspondiente.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is assigned to the vendor.', ESP = 'Especifica el comprador asignado al proveedor.';
        }
        modify("Campaign No.")
        {
            ToolTipML = ENU = 'Specifies the campaign number the document is linked to.', ESP = 'Especifica el número de la campaña a la que está vinculado el documento.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.', ESP = 'Especifica el código del centro de responsabilidad asociado al usuario, la empresa o el proveedor.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', ESP = 'Especifica el id. del usuario responsable del documento.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.', ESP = 'Especifica si el registro está abierto, en espera de aprobación, facturado para anticipo o ha pasado a la etapa siguiente de procesamiento.';

            //Unsupported feature: Change Visible on "Status(Control 124)". Please convert manually.

        }

        //Unsupported feature: Change PagePartID on "PurchLines(Control 60)". Please convert manually.

        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', ESP = 'Detalles factura', FRA = 'Détails facture';

            //Unsupported feature: Change Editable on ""Invoice Details"(Control 1905885101)". Please convert manually.

        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code for amounts on the purchase lines.', ESP = 'Especifica el código de divisa para los importes de las líneas de compra.';
        }
        modify("Expected Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date you expect to receive the items on the purchase document.', ESP = 'Especifica la fecha en la que espera recibir los artículos del documento de compra.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.', ESP = 'Especifica una fórmula que calcula la fecha de vencimiento del pago, la fecha del descuento por pronto pago y el importe de descuento por pronto pago en el documento de compra.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies how payment for the purchase document must be submitted, such as bank transfer or check.', ESP = 'Especifica cómo debe enviarse el pago para el documento de compra, por ejemplo, un cheque o una transferencia bancaria.';
        }
        modify("Transaction Type")
        {
            ToolTipML = ENU = 'Specifies the number for the transaction type, for the purpose of reporting to INTRASTAT.', ESP = 'Especifica el número del tipo de transacción con el fin de notificar a INTRASTAT.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the purchase header.', ESP = 'Especifica el código del valor de dimensión asociado a la cabecera de compra.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code associated with the purchase header.', ESP = 'Especifica el código del valor de dimensión asociado a la cabecera de compra.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.', ESP = 'Especifica el porcentaje de descuento por pronto pago concedido si el pago se realiza en la fecha (o antes de ella) especificada en el campo Fecha dto. P.P.';
        }
        modify("Pmt. Discount Date")
        {
            ToolTipML = ENU = 'Specifies the last date on which you can pay the invoice and still receive a payment discount.', ESP = 'Especifica la última fecha en la que se puede pagar la factura y recibir un descuento por pronto pago.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies a code for the location where you want the items to be placed when they are received.', ESP = 'Especifica el código de almacén donde quiere que se guarden los productos recibidos.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the code that represents the shipment method for this purchase.', ESP = 'Especifica el código que representa el método de envío de esta compra.';
        }
        modify("On Hold")
        {
            ToolTipML = ENU = 'Specifies if the posted invoice will be included in the payment suggestion.', ESP = 'Especifica si la factura registrada se incluirá o no en la propuesta de pago.';
        }
        modify("Shipping and Payment")
        {
            CaptionML = ENU = 'Shipping and Payment', ESP = 'Envío y pago', FRA = 'Expédition et paiement';

            //Unsupported feature: Change Editable on ""Shipping and Payment"(Control 1906801201)". Please convert manually.

        }
        modify("Ship-to")
        {
            CaptionML = ENU = 'Ship-to', ESP = 'Dirección de envío', FRA = 'Destinataire';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', ESP = 'Nombre', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.', ESP = 'Especifica el nombre de la empresa que consta en la dirección a la que desea enviar los artículos del pedido de compra.';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', ESP = 'Dirección', FRA = 'Adresse';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 44)". Please convert manually.

            ToolTipML = ENU = 'Specifies the address that you want the items in the purchase order to be shipped to.', ESP = 'Especifica la dirección donde quiere enviar los artículos del pedido de compra.';
        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', ESP = 'Dirección 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 46)". Please convert manually.

            ToolTipML = ENU = 'Specifies additional address information.', ESP = 'Especifica información adicional de la dirección.';
        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'ZIP Code', ESP = 'Código postal', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', ESP = 'Especifica el código postal.';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', ESP = 'Población', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 48)". Please convert manually.

            ToolTipML = ENU = 'Specifies the city the items in the purchase order will be shipped to.', ESP = 'Especifica el municipio/ciudad donde se enviarán los artículos del pedido de compra.';
        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', ESP = 'Contacto', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.', ESP = 'Especifica el nombre de la persona de contacto correspondiente a la dirección a la que deben enviarse los artículos del pedido de compra.';
        }
        modify("Pay-to")
        {
            CaptionML = ENU = 'Pay-to', ESP = 'Dirección pago', FRA = 'Paiement';
        }
        modify("Pay-to Name")
        {
            CaptionML = ENU = 'Name', ESP = 'Nombre', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the vendor sending the invoice.', ESP = 'Especifica el nombre del proveedor que envía la factura.';
        }
        modify("Pay-to Address")
        {
            CaptionML = ENU = 'Address', ESP = 'Dirección', FRA = 'Adresse';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 26)". Please convert manually.

            ToolTipML = ENU = 'Specifies the address of the vendor sending the invoice.', ESP = 'Especifica la dirección del proveedor que envía la factura.';
        }
        modify("Pay-to Address 2")
        {
            CaptionML = ENU = 'Address 2', ESP = 'Dirección 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 28)". Please convert manually.

            ToolTipML = ENU = 'Specifies additional address information.', ESP = 'Especifica información adicional de la dirección.';
        }
        modify("Pay-to Post Code")
        {
            CaptionML = ENU = 'ZIP Code', ESP = 'Código postal', FRA = 'Code postal';
            ToolTipML = ENU = 'Specifies the postal code.', ESP = 'Especifica el código postal.';
        }
        modify("Pay-to City")
        {
            CaptionML = ENU = 'City', ESP = 'Población', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 30)". Please convert manually.

            ToolTipML = ENU = 'Specifies the city of the vendor sending the invoice.', ESP = 'Especifica el municipio/ciudad del proveedor que envía la factura.';
        }
        modify("Pay-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', ESP = 'Nº contacto', FRA = 'N° contact';
            ToolTipML = ENU = 'Specifies the number of the contact who sends the invoice.', ESP = 'Especifica el número del contacto que envía la factura.';
        }
        modify("Pay-to Contact")
        {
            CaptionML = ENU = 'Contact', ESP = 'Contacto', FRA = 'Contact';
            ToolTipML = ENU = 'Specifies the name of the person to contact about an invoice from this vendor.', ESP = 'Especifica el nombre de la persona con quien contactarse acerca de cualquier factura procedente de este proveedor.';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', ESP = 'Comercio exterior', FRA = 'International';

            //Unsupported feature: Change Editable on ""Foreign Trade"(Control 1907468901)". Please convert manually.

        }
        modify("Transaction Specification")
        {
            ToolTipML = ENU = 'Specifies a code for the purchase header''s transaction specification here.', ESP = 'Especifica un código de especificación de transacción de la cabecera de compra.';
        }
        modify("Transport Method")
        {
            ToolTipML = ENU = 'Specifies the code for the transport method to be used with this purchase header.', ESP = 'Especifica el código del método de transporte que se va a usar en esta cabecera de compra.';
        }
        modify("Entry Point")
        {
            ToolTipML = ENU = 'Specifies the code of the port of entry where the items pass into your country/region.', ESP = 'Especifica el código de puerto o el aeropuerto de descarga por el que los artículos entrarán al país o a la región.';
        }
        modify("Area")
        {
            ToolTipML = ENU = 'Specifies the code for the area of the vendor''s address.', ESP = 'Especifica el código de área de la dirección del proveedor.';
        }
        //BC Upgrade SHARMP16 BEGIN<<-- remove the base page and add the custom page same as NAV
        addafter(General)
        {
            part(PurchLines1; "Blanket Purch.Ord Subform2 CBN")
            {
                ApplicationArea = all;
                Editable = true;
                Enabled = true;
                SubPageLink = "Document No." = field("No."),
                      "Document Type" = field("Document Type");
                UpdatePropagation = Both;
            }
        }
        //BC Upgrade SHARMP16 END>>- remove the base page and add the custom page same as NAV

        // BC Upgrade BHARDA11 >> -- FDD STP 009
        addafter("Order Date")
        {
            field("Created By IBM"; Rec."Created By IBM FND")
            {
                ApplicationArea = All;

            }
            field("Creation Date/Time IBM"; Rec."Creation Date/Time IBM FND")
            {
                ApplicationArea = All;
            }
            field("Last Changed User ID IBM"; Rec."Last Changed User ID IBM FND")
            {
                ApplicationArea = All;
            }
            field("Last Changed Date/Time IBM"; Rec."Last Changed Date/Time IBM FND")
            {
                ApplicationArea = All;
            }
        }
        // BC Upgrade BHARDA11 << -- FDD STP 009

        //Unsupported feature: CodeInsertion on ""Document Date"(Control 49)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
        CurrPage.UPDATE(true);
        // >>DITW17.00.01 DDR DIT-770 #001
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Order Date"(Control 14)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
        CurrPage.UPDATE(true);
        // >>DITW17.00.01 DDR DIT-770 #001
        */
        //end;
        addafter("No.")
        {
            // field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
            // {
            // }//BC Upgrade SHARMP16--already defined in Base
        }
        addafter("Document Date")
        {
            // field("Tax Date"; Rec."Tax Date")
            // {

            //     trigger OnValidate();
            //     begin
            //         // <<DITW17.00.01 DDR 21/03/2013 DIT-770 #001
            //         CurrPage.UPDATE(true);
            //         // >>DITW17.00.01 DDR DIT-770 #001
            //     end;
            // }//BC Upgrade SHARMP16-- DRINK-IT fields
        }
        addafter(Status)
        {
            // field("Linked Customer No."; Rec."Linked Customer No.")
            // {
            //     Importance = Additional;
            // }//BC Upgrade SHARMP16-- DRINK-IT fields
            // field("Valid Until"; Rec."Valid Until")
            // {
            //     Description = 'MANXL7.00.001';
            // }//BC Upgrade SHARMP16-- DRINK-IT fields
            field("Purch. Reason Code"; Rec."Purch. Reason Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Purch. Reason Code field.';
            }
            group("Call-off")
            {
                Caption = 'Call-off';
                field("Consumption Date"; Rec."Consumption Date FND")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Consumption Date field.';
                }
            }
        }
        addafter("Expected Receipt Date")
        {
            field("Lead Time Calculation"; Rec."Lead Time Calculation")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
            }
        }
        addafter("Ship-to")
        {
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Importance = Additional;
            //     QuickEntry = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
            //             CurrPage.UPDATE(true);
            //         // >>DITW18.00.06 DDR DIT-770 #1191
            //     end;
            // }//BC Upgrade SHARMP16-- DRINK-IT fields
        }
        addafter("Foreign Trade")
        {
            group(Prepayment)
            {
                Caption = 'Prepayment';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = all;
                    Editable = ActivePrepayment;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for purchase.';
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    ToolTip = 'Specifies that prepayments on the purchase order are combined if they have the same general ledger account for prepayments or the same dimensions.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = all;
                    Enabled = ActivePrepayment;
                    ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the purchase document.';
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = all;
                    Enabled = ActivePrepayment;
                    ToolTip = 'Specifies the payment discount percent granted on the prepayment if the vendor pays on or before the date entered in the Prepmt. Pmt. Discount Date field.';
                }
            }
            //BC upgrade SHARMP16 BEGIN>>--- Interface related fields
            // group(SRM)
            // {
            //     Caption = 'SRM';
            //     Editable = BlanketOrderEditable;
            //     field("SRM Contract No."; Rec."SRM Contract No.")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("SRM Contract Name"; Rec."SRM Contract Name")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("SRM Contract Type"; Rec."SRM Contract Type")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("Shipment Method Location"; Rec."Shipment Method Location")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("Valid From"; Rec."Valid From")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("Valid To"; Rec."Valid To")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field(Channel; Rec.Channel)
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("Target Value Amount"; Rec."Target Value Amount")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("Blanket Order No."; Rec."Blanket Order No.")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field(Closed; Rec.Closed)
            //     {
            //         ApplicationArea = all;
            //     }
            // }
            //BC upgrade SHARMP16 end<<--- Interface related fields
        }
    }
    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', ESP = '&Pedido', FRA = '&Commande';
        }

        modify(Card)
        {
            CaptionML = ENU = 'Card', ESP = 'Ficha', FRA = 'Fiche';
            ToolTipML = ENU = 'View or edit detailed information about the vendor on the purchase document.', ESP = 'View or edit detailed information about the vendor on the purchase document.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', ESP = 'C&omentarios', FRA = 'Co&mmentaires';
            ToolTipML = ENU = 'View or add notes about the blank purchase order.', ESP = 'Permite ver o agregar notas acerca del pedido de compra en blanco.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', ESP = 'Dimensiones', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', ESP = 'Permite ver o editar dimensiones, como el área, el proyecto o el departamento, que pueden asignarse a los documentos de venta y compra para distribuir costes y analizar el historial de transacciones.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', ESP = 'Aprobaciones', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', ESP = 'Permite ver una lista de los registros en espera de aprobación. Por ejemplo, puede ver quién ha solicitado la aprobación del registro, cuándo se envió y la fecha de vencimiento de la aprobación.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', ESP = 'Aprobación', FRA = 'Approbation';
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', ESP = 'Aprobar', FRA = 'Approuver';
            ToolTipML = ENU = 'Approve the requested changes.', ESP = 'Permite aprobar los cambios solicitados.';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', ESP = 'Rechazar', FRA = 'Rejeter';
            ToolTipML = ENU = 'Reject the approval request.', ESP = 'Rechaza la solicitud de aprobación.';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', ESP = 'Delegar', FRA = 'Déléguer';
            ToolTipML = ENU = 'Delegate the approval to a substitute approver.', ESP = 'Delega la aprobación a un aprobador sustituto.';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', ESP = 'Comentarios', FRA = 'Commentaires';
            ToolTipML = ENU = 'View or add comments.', ESP = 'Permite ver o agregar comentarios.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', ESP = 'Acci&ones', FRA = 'Fonction&s';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount', ESP = 'Calcular dto. en la &factura', FRA = 'C&alculer remise facture';
            ToolTipML = ENU = 'Calculate the invoice discount for the entire purchase invoice.', ESP = 'Calcula el descuento en factura para la toda la factura de compra.';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document', ESP = 'Copiar líneas', FRA = 'Copier document';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', ESP = 'Lan&zar', FRA = '&Lancer';

            //Unsupported feature: Change Description on "Release(Action 126)". Please convert manually.

        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', ESP = '&Volver a abrir', FRA = 'R&ouvrir';
            ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed', ESP = 'Permite volver a abrir el documento para cambiarlo una vez que se haya aprobado. Los documentos aprobados tienen el estado Lanzado y se deben abrir para poder cambiarlos.', FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';


            //Unsupported feature: Change Description on "Reopen(Action 127)". Please convert manually.

        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', ESP = 'Aprobación solic.', FRA = 'Approbation demande achat';

            //Unsupported feature: Change Description on ""Request Approval"(Action 19)". Please convert manually.


            //Unsupported feature: Change Image on ""Request Approval"(Action 19)". Please convert manually.

        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', ESP = 'Enviar solicitud a&probación', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', ESP = 'Envía una solicitud de aprobación.';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', ESP = '&Cancelar solicitud aprobación', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', ESP = 'Permite cancelar la solicitud de aprobación.';
        }
        modify(MakeOrder)
        {
            CaptionML = ENU = 'Make &Order', ESP = '&Convertir en pedido', FRA = '&Créer commande';
            ToolTipML = ENU = 'Convert the blank purchase order to a purchase order.', ESP = 'Permite convertir un pedido de compra en blanco en un pedido de compra.';
        }
        modify(Print)
        {
            CaptionML = ENU = '&Print', ESP = '&Imprimir', FRA = '&Imprimer';
        }


        //Unsupported feature: CodeModification on "Release(Action 126).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleasePurchDoc.PerformManualRelease(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
        //ReleasePurchDoc.PerformManualRelease(Rec);
        CurrPage.UPDATE(true);
        ReleasePurchDoc.DocStatusRelease(xRec,Rec);
        CurrPage.UPDATE;
        //>>DITW17.00.02 TEC1 DIT-770 #144
        */
        //end;


        //Unsupported feature: CodeModification on "Reopen(Action 127).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleasePurchDoc.PerformManualReopen(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>>DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
        //ReleasePurchDoc.PerformManualReopen(Rec);
        ReleasePurchDoc.DocStatusOpen(xRec,Rec);
        CurrPage.UPDATE;
        //<<DITW17.00.02 TEC1 DIT-770 #144
        */
        //end;


        //Unsupported feature: CodeModification on "Print(Action 82).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DocPrint.PrintPurchHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchLines.PAGE.SetDisableRefreshLines(true);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        DocPrint.PrintPurchHeader(Rec);
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchLines.PAGE.SetDisableRefreshLines(false);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;
        addafter(MakeOrder)
        {
            action(MakeReturnOrder)
            {
                Caption = 'Make Return Order';
                Image = ReturnOrder;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                ToolTip = 'Executes the Make Return Order action.';
                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //HEI.04>>
                    if PurchSetup.GET() then begin
                        PurchaseLine.SETRANGE("Document No.", rec."No.");
                        PurchaseLine.SETFILTER("Document Type", '%1', rec."Document Type"::"Blanket Order");
                        PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
                        PurchaseLine.SETFILTER("Item Category Code", PurchSetup."Item Category FND");
                        PurchaseLine.SETFILTER("Qty. to Return FND", '>%1', 0);
                        if not PurchaseLine.FINDFIRST() then
                            ItemCategoryBool := false
                        else
                            ItemCategoryBool := true;
                        if ItemCategoryBool then begin
                            //IF "SRM Order No." <> '' THEN
                            rec.TESTFIELD("Purch. Reason Code FND");
                        end;
                    end;
                    //HEI.04<<

                    //HEI.03>>
                    if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                        CODEUNIT.RUN(CODEUNIT::"Blnkt Purch Ord.toRet. Y/N CBN", Rec);
                    //HEI.03<<
                end;
            }
        }
    }

    var
        // InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";//BC Upgrade SHARMP16-- Interface var
        PurchaseLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        ArchiveManagement: Codeunit ArchiveManagement;

        ActivePrepayment: Boolean;
        BlanketOrderEditable: Boolean;
        ItemCategoryBool: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserMgt.GetRespPhysLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(1,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1191

    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);

    //HEI.02>>
    //BlanketOrderEditable := InterfaceFrameworkMgt.CheckPermissionSet(USERID,'',TRUE);//old code//HEI.09
    //>>HEI.09
    if not GUIALLOWED then
      BlanketOrderEditable := InterfaceFrameworkMgt.CheckPermissionSet(USERID,'',true);
    //<<HEI.09
    //HEI.02<<

    //>>HEI.08
    //>>HEI.05
    if UserSetup.GET(USERID) then
      if UserSetup."Allow Mod Prepay.Condt. BO" then
        ActivePrepayment := true
      else
        ActivePrepayment := false;
    //<<HEI.05
    //<<HEI.08
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    //>>HEI.09
    BlanketOrderEditable := true;
    //<<HEI.09
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if UserMgt.GetPurchasesFilter <> '' then begin
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    end;

    SetDocNoVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
    //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
    if UserMgt.GetPurchasesTextFilter <> '' then begin
      FILTERGROUP(2);
      //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
      SETFILTER("Responsibility Center",UserMgt.GetPurchasesTextFilter);
      FILTERGROUP(0);
    end;
    // >>DITW18.00.06 DDR DIT-770 #1191

    SetDocNoVisible;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    //BC Upgrade SHARMP16 BEGIN>>--Custom Code

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin


        //>>HEI.05
        IF UserSetup.GET(USERID) THEN
            IF UserSetup."Allow Mod Prepay.Condt. BO FND" THEN
                ActivePrepayment := TRUE
            else
                ActivePrepayment := FALSE;
        //<<HEI.05

    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //>>HEI.09
        BlanketOrderEditable := TRUE;
        //<<HEI.09
    end;
    //BC Upgrade SHARMP16 end<<--Custom Code
}

