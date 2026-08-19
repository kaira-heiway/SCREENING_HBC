pageextension 53021 SalesOrderListExt extends "Sales Order List"
{
    // version NAVW110.0.00.15052,FINXL14.00.15,DITW110.00.11,HEI.03
    //BC UPGRADE SIVA Old Page ID 9305

    // FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"

    //   DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Upgrade
    //                                                Added menu into 'Print' button
    //                                                  'Order Confirmation (Packing)'
    //                                                  'Test AAD Document'
    //                                                  'Packing List'
    //                       20/02/2012 DIT-715 #244
    //                                  Added shortcut (warehouse) fields
    //                                    Control1100079000 Shortcut Unit of Measure1 Code
    //                                    Control1100079001 Shortcut Unit of Measure2 Code
    //                                    Control1100079002 Shortcut Unit of Measure3 Code
    //                                  Added Standard Global Dimension Lookup (see from 53 as reference)
    //                       20/02/2012 DIT-715 #244 Added/Moved columns
    //   DITW16.00.00.43 DDR 13/05/2013 DIT-715 #606 Added fields  "Document Status"

    //   DITW17.00.02 DDR 13/05/2013 DIT-715 #606

    //   DITW17.00.02 AT  03/10/2013 DIT-770 #183
    //                    Added fields Invoice Method & Invoice Period
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields "Responsibility Center","Physical Location Group Code"
    //   DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    //   DITW17.10.05 MSF 08/08/14 DIT-770 #795 : Min. HL Volume and Min. UOM warning in order intake - PART3
    //                                            Added  Field "Total Eq. UOM Quantity"
    //   DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added Field 2014100 "Trailer Code"
    //   DITW18.00.07 AKH 07/01/2016 DIT-770 #1806 Added fields: "Sell-to Customer Name 2", Address, "Address 2", "Sell-to City" (Visible FALSE)
    //   DITW18.00.07 KJB 18/02/2016 DIT-770 #1042 Add menu to open Sales Comment Sheet
    //   DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Customer"
    //   DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Add Action to Shipping Cost Page + Removed old Shipping Costs fields
    //   DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    //   DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 Removed ation Sales Comment Sheet
    //   DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Added filters to print "Pick Instruction"
    //                                             Updated ShowShortcutUomValue function
    //   DITW19.00.08 VSC 05/12/2016 BL#10330 (DIT-770 #2122) Re index options Report Usage

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.08 DDR 03/02/2017 NRQ#20678 upgrade Usage optionstring
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    //   DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    //   DITW110.00.11 MSF 28/12/2017 NRQ#9570 DIT Sales approval for Credit limit

    //   HEI.04 FDD-KDDOTCGAP003 IBM ISYED01 10.10.2017
    //     # code added to release function
    //   HEI.02 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
    //     # Code added on Post Actions to post the Sales Order and the Sales Return Order which are linked
    //   HEI.03 RFC-CHG0255777 IBM.LS 19.01.2019
    //     # Code added to call "ValidateCustomerMinValue" function.
    //   DITW111.00.13 MSF 03/09/2018 NRQ#55906 Sales Approval Workflow for Overdue and deposit limit
    //   DITW111.00.13A MSF 02/05/2019 NRQ#103938 Added visibility for Action Send Approval
    //   DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                                 Added Field "Disable DIT Disc. Prom."
    //   HEI.05 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    //   HEI.06 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019 - #new field EDI order
    //   FINXL11.00 HBA 03/05/2018 NRQ#69018: Added Action "Auto. Send IC Order"
    //   HEI.07 FDD-HB1111 IBM NASTAA02 26.02.2020 # Adding Fields to existing Tables - Sales Reports enhancements
    //     # New Fields added: "Created By", "Creation Date/Time", "Order Date"
    //     # Made Fields: "Posting Date" and "Shipment Date" visible
    //   HEI.08 CHG2046145 IBM.GAVANM01 16.03.2020 # Sales Order Status Addition
    //     # New field added : 50051 - "Approval Status"
    //   HEI.09 CHG2026335 HT653 IBM GAVANM01 27.03.2020 #FDD_La Reunion_EDI_EDI Order
    //     # remove EDI Order field
    //   HEI.11 INC2840509 IBM NASTAA02 13.05.2020 # Sales Order Approval Issue - ETH
    //     # Changed code on "Release" function
    //     # Used same functions from Sales Order Card
    //   FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    //   HEI.12 CHG2065153 IBM KUMARN15 23.06.2020
    //     # Added field "Source System Identifier"
    //   HEI.13 FDD-HB899 - CHG2093015 IBM NASTAA02  19.01.2021 # LSR - Sales And Payments
    //     # Code added on "Create &Whse. Shipment" Action
    //   HEI.14 CHG2084621 HB1742 IBM GAVANM01 23.03.2021 - Sales Quotes functionality
    //     # add field Quote No.
    //   HEI.16 HB2487 CHG2123592 IBM MAJUMS03 # Cash Application where 92% of Customer pay in advance
    //     # Code added on Page Actions

    //********************************//
    //BC UPGRADE SIVA 20/01/2026 
    // SUMMARY OF CHANGES:
    //1.HEI.04 While converting the page, the lower-version code is not coming correctly manually added in the page extension Release action.
    //2.HEI.02 the procedure PostOrderAndReturnOrderLinked() logic  is linked to Drink it fields Link Sales Document No.","Shipment status hence
    //and after start Post routines but here we can use Standard Actions calling same posting routine codeunits.
    //3.HEI.03 the lower-version code is not coming correctly manually added in the page extension Release action. 
    //4.HEI.05,HEI.07 Drink it Fields are commented. 
    //5.HEI.13>> Added Custom code in "Create &Whse. Shipment"_Action trigger before action and remain code is as same base 
    //can use base action.
    //6.SendApprovalRequest() action can use base app code.   
    //7.HEI.14 Quote No field in newer version already there
    //8.HEI.16 Added code from navision function. 
    //9.Base Release action property set as hide due to custom code is not supported. Added new release action
    //for custom code with same properties and name will be diffrent. 

    // BC Upgrade SHUKLP03 >> Added document subtype field and it's code.

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the sales document.', FRA = 'Spécifie le numéro du document vente.';
        }
        modify("Sell-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer who will receive the products and be billed by default.', FRA = 'Spécifie le numéro du client qui va recevoir les produits et être facturé par défaut.';
        }
        modify("Sell-to Customer Name")
        {
            ToolTipML = ENU = 'Specifies the name of the customer who will receive the products and be billed by default.', FRA = 'Spécifie le nom du client qui recevra les produits et sera facturé par défaut.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies the number that the customer uses in their own system to refer to this sales document.', FRA = 'Spécifie le numéro que le client doit utiliser dans son propre système pour faire référence à ce document vente.';
        }
        modify("Sell-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Sell-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Sell-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person to contact at the customer.', FRA = 'Spécifie le nom de la personne à contacter chez le client.';
        }
        modify("Bill-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the customer to whom you will send the sales invoice when this customer is different from the sell-to customer.', FRA = 'Spécifie le nom du client auquel vous envoyez la facture vente, si ce client diffère de celui auquel vous vendez.';
        }
        modify("Bill-to Name")
        {
            ToolTipML = ENU = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.', FRA = 'Spécifie le nom du client auquel vous envoyez la facture vente, s''il diffère du client auquel vous vendez.';
        }
        modify("Bill-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Bill-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Bill-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.', FRA = 'Spécifie le nom de la personne que vous devez contacter chez le client auquel vous envoyez la facture.';
        }
        modify("Ship-to Code")
        {
            ToolTipML = ENU = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.', FRA = 'Spécifie le code d''une adresse de livraison différente de l''adresse du client, qui est entrée par défaut.';
        }
        modify("Ship-to Name")
        {
            ToolTipML = ENU = 'Specifies the name that products on the sales document will be shipped to.', FRA = 'Spécifie le nom auquel les produits mentionnés sur le document vente seront expédiés.';
        }
        modify("Ship-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Ship-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Ship-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the contact person at the address that products will be shipped to.', FRA = 'Spécifie le nom du contact à l''adresse à laquelle ces produits seront expédiés.';
        }
        modify("Posting Date")
        {
            Description = 'HEI.07';
            ApplicationArea = All;
            ToolTipML = ENU = 'Specifies the date when the posting of the sales document will be recorded.', FRA = 'Spécifie la date à laquelle la validation du document vente sera validée.';
            Visible = true;

            //Unsupported feature: Change Description on ""Posting Date"(Control 139)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';

            trigger OnLookup(var Text: Text): Boolean
            begin
                //BC UPGRADE SIVA >> Drink IT code
                // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
                // DimMgt.LookupDimValueCodeNoUpdate(1);
                //BC UPGRADE SIVA << Drink IT code
            end;

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';

            trigger OnLookup(var Text: Text): Boolean
            begin
                //BC UPGRADE SIVA >> Drink IT code
                // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
                // DimMgt.LookupDimValueCodeNoUpdate(2);
                //BC UPGRADE SIVA << Drink IT code
            end;

        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.', FRA = 'Spécifie le magasin à partir duquel les articles de stock doivent être expédiés par défaut au client figurant sur le document vente.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies the name of the salesperson who is assigned to the customer.', FRA = 'Spécifie le nom du vendeur affecté au client.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency of amounts on the sales document.', FRA = 'Spécifie la devise des montants sur le document vente.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on which you created the sales document.', FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
        }
        modify("Requested Delivery Date")
        {
            ToolTipML = ENU = 'Specifies the date that the customer has asked for the order to be delivered.', FRA = 'Spécifie la date à laquelle le client a demandé à être livré.';
        }
        modify("Campaign No.")
        {
            ToolTipML = ENU = 'Specifies the campaign number the document is linked to.', FRA = 'Spécifie le numéro de campagne auquel le document est lié.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.', FRA = 'Spécifie si le document est ouvert, est en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.', FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de la remise sur le document de vente.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies when the sales invoice must be paid.', FRA = 'Spécifie la date à laquelle la facture vente doit être payée.';
        }
        modify("Payment Discount %")
        {
            ToolTipML = ENU = 'Specifies the payment discount percentage that is granted if the customer pays on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.', FRA = 'Spécifie le pourcentage d''escompte possible qui est accordé si le client paye à la date entrée dans le champ Date d''escompte, ou de manière anticipée. Le pourcentage remise est spécifié dans le champ Code condition paiement.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies how items on the sales document are shipped to the customer.', FRA = 'Spécifie le mode d''expédition au client des articles figurant sur le document vente.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Shipping Agent Service Code")
        {
            ToolTipML = ENU = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';
        }
        modify("Shipment Date")
        {
            Description = 'HEI.07';
            ToolTipML = ENU = 'Specifies the date you expect to ship items on the sales document.', FRA = 'Spécifie la date à laquelle vous pensez expédier les articles indiqués sur le document vente.';
            Visible = true;

            //Unsupported feature: Change Description on ""Shipment Date"(Control 1102601031)". Please convert manually.

        }
        modify("Shipping Advice")
        {
            ToolTipML = ENU = 'Specifies if the customer accepts partial shipment of orders.', FRA = 'Spécifie si le client accepte l''expédition partielle des commandes.';
        }
        modify("Completely Shipped")
        {
            ToolTipML = ENU = 'Specifies whether all the items on the order have been shipped or, in the case of inbound items, completely received.', FRA = 'Indique si tous les articles de la commande ont été expédiés ou, dans le cas d''articles entrants, intégralement réceptionnés.';
        }
        modify("Job Queue Status")
        {
            ToolTipML = ENU = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.', FRA = 'Spécifie le statut d''une écriture file d''attente des travaux ou d''une tâche qui gère la validation des commandes vente.';
        }

        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 139)". Please convert manually.


        //Unsupported feature: CodeInsertion on ""Shortcut Dimension 1 Code"(Control 121)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        DimMgt.LookupDimValueCodeNoUpdate(1);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shortcut Dimension 2 Code"(Control 119)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        DimMgt.LookupDimValueCodeNoUpdate(2);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Shipment Date"(Control 1102601031)". Please convert manually.

        addafter("No.")
        {
            //BC UPGRADE SHUKLP03 >> Added field
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = ALL;
            }
            //BC UPGRADE SHUKLP03 << Added field
        }
        addafter("Sell-to Customer Name")
        {
            field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Sell-to Address"; Rec."Sell-to Address")
            {
                ToolTip = 'Specifies the Sell-to Address';
                ApplicationArea = all;
                Visible = false;
            }
            field("Sell-to Address 2"; Rec."Sell-to Address 2")
            {
                ToolTip = 'Specifies the Sell-to Address2';
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Sell-to Post Code")
        {
            field("Sell-to City"; Rec."Sell-to City")
            {
                ToolTip = 'Specifies the Sell-to City';
                ApplicationArea = all;
                Visible = false;
            }

        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ToolTip = 'Specifies Responsibility Center';
                ApplicationArea = all;
                Visible = false;
            }
            //BC UPGRADE SIVA >> Drink IT field
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     ToolTip = 
            //     ApplicationArea = all;
            //     Visible = false;
            // }
            //BC UPGRADE SIVA<< Drink IT field
        }
        addafter(Status)
        {
            field("Approval Status"; Rec."Approval Status FND")
            {
                ToolTip = 'Approval Status';
                ApplicationArea = all;
            }
            //BC UPGRADE SIVA>>Drink IT field
            // field("Shipment status"; Rec."Shipment status")
            // {
            //     ApplicationArea = all;
            // }
            //BC UPGRADE SIVA Drink IT field
        }
        addafter("Shipping Agent Code")
        {
            field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
            {
                ToolTip = 'Shipped Not Invoiced';
                ApplicationArea = all;
            }
        }
        addafter("Completely Shipped")
        {
            //BC UPGRADE SIVA>> Drink IT fields
            // field(Shipped; Rec.Shipped)
            // {
            // }
            // field(Ship; Rec.Ship)
            // {
            // }
            // field(Invoice; Rec.Invoice)
            // {
            // }
            // field("Late Order Shipping"; Rec."Late Order Shipping")
            // {
            // }
            // field(Distance; Rec.Distance)
            // {
            //     Visible = false;
            // }
            // field("Delivery Order"; Rec."Delivery Order")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Invoice Method"; Rec."Invoice Method")
            // {
            //     Visible = false;
            // }
            // field("Invoice Period"; Rec."Invoice Period")
            // {
            //     Visible = false;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Trailer Code"; Rec."Trailer Code")
            // {
            //     Visible = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Driver 2 Code"; Rec."Driver 2 Code")
            // {
            //     Visible = false;
            // }
            // field(Route; Rec.Route)
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Route Planning No."; Rec."Route Planning No.")
            // {
            //     Visible = false;
            // }
            // field("Shipping Charge Per"; Rec."Shipping Charge Per")
            // {
            //     Visible = false;
            // }
            // field("Picking Type"; Rec."Picking Type")
            // {
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
            // field("Total Weight (Base)"; Rec."Total Weight (Base)")
            // {
            //     Visible = false;
            // }
            // field("Total Weight"; Rec."Total Weight")
            // {
            //     Visible = false;
            // }
            // field("Total Cubage (Base)"; Rec."Total Cubage (Base)")
            // {
            //     Visible = false;
            // }
            // field("Total Cubage"; Rec."Total Cubage")
            // {
            //     Visible = false;
            // }
            // field("Total HL Cubage"; Rec."Total HL Cubage")
            // {
            //     Visible = false;
            // }
            // field("Total Eq. UOM Quantity"; Rec."Total Eq. UOM Quantity")
            // {
            //     Visible = false;
            // }
            //     field("ShortcutQtyUomBase[1]"; ShortcutQtyUomBase[1])
            //     {
            //         BlankZero = true;
            //         CaptionClass = GetCaptionClassShortcutUom(1, 0);
            //         DecimalPlaces = 0 : 5;
            //         Description = 'DIT-715 #244';
            //         Editable = false;
            //         Visible = false;
            //     }
            //     field("ShortcutQtyUomBase[2]"; ShortcutQtyUomBase[2])
            //     {
            //         BlankZero = true;
            //         CaptionClass = GetCaptionClassShortcutUom(2, 0);
            //         DecimalPlaces = 0 : 5;
            //         Description = 'DIT-715 #244';
            //         Editable = false;
            //         Visible = false;
            //     }
            //     field("ShortcutQtyUomBase[3]"; ShortcutQtyUomBase[3])
            //     {
            //         BlankZero = true;
            //         CaptionClass = GetCaptionClassShortcutUom(3, 0);
            //         DecimalPlaces = 0 : 5;
            //         Description = 'DIT-715 #244';
            //         Editable = false;
            //         Visible = false;
            //     }
            //     field("ShortcutQtyUomOutstd[1]"; ShortcutQtyUomOutstd[1])
            //     {
            //         BlankZero = true;
            //         CaptionClass = GetCaptionClassShortcutUom(1, 1);
            //         DecimalPlaces = 0 : 5;
            //         Description = 'DIT-770 #1488';
            //         Editable = false;
            //         Visible = false;
            //     }
            //     field("ShortcutQtyUomOutstd[2]"; ShortcutQtyUomOutstd[2])
            //     {
            //         BlankZero = true;
            //         CaptionClass = GetCaptionClassShortcutUom(2, 1);
            //         DecimalPlaces = 0 : 5;
            //         Description = 'DIT-770 #1488';
            //         Editable = false;
            //         Visible = false;
            //     }
            //     field("ShortcutQtyUomOutstd[3]"; ShortcutQtyUomOutstd[3])
            //     {
            //         BlankZero = true;
            //         CaptionClass = GetCaptionClassShortcutUom(3, 1);
            //         DecimalPlaces = 0 : 5;
            //         Description = 'DIT-770 #1488';
            //         Editable = false;
            //         Visible = false;
            //     }
            //     field("Link Sales Document Type"; "Link Sales Document Type")
            //     {
            //         Visible = false;
            //     }
            //     field("Link Sales Document No."; "Link Sales Document No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Building No."; "Building No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Fiscal Representative No."; "Fiscal Representative No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Customer Tax Registration No."; "Customer Tax Registration No.")
            //     {
            //         Description = 'DIT-715 #244';
            //         Visible = false;
            //     }
            //     field("Customer Tax Warehouse Ref."; "Customer Tax Warehouse Ref.")
            //     {
            //         Visible = false;
            //     }
            // }
            // addafter("Job Queue Status")
            // {
            //     field("Sundry Customer"; "Sundry Customer")
            //     {
            //         Editable = false;
            //         Visible = false;
            //     }
            // field("Last changed User ID"; Rec."Last changed User ID")
            // {
            // }
            // field("Last changed Date/time"; Rec."Last changed Date/time")
            // {
            // }
            //BC UPGRADE SIVA>> Drink IT fields

        }
        addafter("Amount Including VAT")
        {
            //BC UPGRADE SIVA<< Drink IT fields 
            //  field("Disable DIT Disc. Prom."; Rec."Disable DIT Disc. Prom.")
            //  {
            //      Visible = false;
            //  }
            // field("Load No."; Rec."Load No.")
            // {
            //     Visible = false;
            // }
            // field("Sequence No."; Rec."Sequence No.")
            // {
            //     Visible = false;
            // }
            // field("Created By"; Rec."Created By")
            // {
            //     Description = 'HEI.07';
            // }
            // field("Creation Date/Time"; Rec."Creation Date/Time")
            // {
            //     Description = 'HEI.07';
            // }
            //BC UPGRADE SIVA <<Drink IT fields
            //BC UPGRADE SIVA<< Drink IT fields //Fields are there Base page layout hence no need 
            // field("Quote No."; Rec."Quote No.")
            // {
            //     Description = 'HEI.14';
            // }
            // field("Order Date"; Rec."Order Date")
            // {
            //     Description = 'HEI.07';
            // }
            //BC UPGRADE SIVA>> Drink IT fields

            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ToolTip = 'Specifies Source System Identifier';
                ApplicationArea = all;
            }


        }
    }
    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = 'C&ommande';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        //BC UPGRADE SIVA >> The statistics action will be replaced with the SalesOrderStatistics action newer version
        //modify(Statistics)
        // {
        //  CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        // }
        //BC UPGRADE SIVA<<
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify("S&hipments")
        {
            CaptionML = ENU = 'S&hipments', FRA = 'E&xpéditions';
            ToolTipML = ENU = 'View the history of posted sales shipments that have been posted for the document.', FRA = 'Affichez l''historique des expositions vente validées qui ont été enregistrées pour le document.';
        }
        modify(PostedSalesInvoices)
        {
            CaptionML = ENU = 'Invoices', FRA = 'Factures';
            ToolTipML = ENU = 'View the history of posted sales invoices that have been posted for the document.', FRA = 'Affichez l''historique des factures vente validées qui ont été enregistrées pour le document.';
        }
        modify(PostedSalesPrepmtInvoices)
        {
            CaptionML = ENU = 'Prepa&yment Invoices', FRA = 'Factures acom&pte';
        }
        modify("Prepayment Credi&t Memos")
        {
            CaptionML = ENU = 'Prepayment Credi&t Memos', FRA = 'A&voirs acompte';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }

        modify("Warehouse Shipment Lines")
        {
            CaptionML = ENU = 'Whse. Shipment Lines', FRA = 'Lignes expédition entrepôt';
        }

        modify("In&vt. Put-away/Pick Lines")
        {
            CaptionML = ENU = 'In&vt. Put-away/Pick Lines', FRA = 'Lignes prélè&v./rangement stock';
        }
        modify(ActionGroupCRM)
        {
            CaptionML = ENU = 'Dynamics CRM', FRA = 'Dynamics CRM';
        }
        modify(CRMGoToSalesOrderListInNAV)
        {
            CaptionML = ENU = 'Sales Order List', FRA = 'Liste des commandes vente';
            ToolTipML = ENU = 'Open the Dynamics CRM Sales Order List page in Dynamics NAV', FRA = 'Ouvrez la page Liste des commandes vente Dynamics CRM dans Dynamics NAV.';
        }

        modify(Action12)
        {
            CaptionML = ENU = 'Release', FRA = 'Lancer';

        }
        //BC UPGRADE SIVA>> //Set property Base action _Visible_False due to custom code is not supported. 
        modify(Release)
        {
            //CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
            Visible = false;
        }
        //BC UPGRADE SIVA<<
        //BC UPGRADE SIVA>> // Added New action for custom code     
        addafter(Release)
        {
            action(ReleaseHei)
            {
                ApplicationArea = all;
                Caption = 'Re&lease';
                Image = ReleaseDoc;
                ShortCutKey = 'Ctrl+F9';
                ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                trigger OnAction()
                var
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                    PrepaymentMgt: Codeunit "Prepayment Mgt.";
                begin
                    //HEI.11>>
                    CompanyInfo.GET();

                    Rec.CheckForLinkSalesDocument(Rec);
                    //BC UPGRADE SIVA>> Drink IT Code  
                    // IF Rec."Sundry Customer" THEN
                    //     Rec.TestSundryMandatoryFields();
                    // BC UPHRADE SIVA<< Drink IT Code 
                    //HEI.11<<

                    HeinekenGlobal.CheckCustLimitBeforeReleaseSO(Rec); //HEI.16

                    //>HEI.04>>
                    HeinekenGlobal.CheckPCVNBalance(Rec);
                    //>HEI.04>>

                    //HEI.11>>
                    IF NOT CheckAvailability() THEN
                        EXIT;

                    //BC UPGRADE SIVA >> Drink IT code (DocStatusRelease) 
                    //ReleaseSalesDoc.PerformManualRelease(Rec);
                    // IF NOT CompanyInfo."Enable French Localization" THEN
                    //     ReleaseSalesDoc.DocStatusRelease(xRec, Rec);

                    // IF CompanyInfo."Enable French Localization" THEN BEGIN
                    //     IF PrepaymentMgt.TestSalesPrepayment(Rec) THEN
                    //         ERROR(STRSUBSTNO(Text10800, Rec."Document Type", Rec."No."));

                    //     IF PrepaymentMgt.TestSalesPayment(Rec) THEN BEGIN
                    //         IF NOT CONFIRM(STRSUBSTNO(Text10801, "Document Type", "No.")) THEN
                    //             EXIT;
                    //         Rec.Status := Rec.Status::"Pending Prepayment";
                    //         Rec.MODIFY();
                    //         CurrPage.UPDATE();
                    //     END ELSE
                    //         ReleaseSalesDoc.DocStatusRelease(xRec, Rec);
                    // END;
                    //BC UPGRADE SIVA<<Drink IT code

                    Rec.UpdateFreeReasonCodeDimensions();
                    //HEI.11<<

                    //HEI.03>>
                    //Removed Begin_End below, No need for after if condition one statement 
                    IF (Rec.Status <> xRec.Status) AND (Rec.Status = Rec.Status::Released) THEN
                        Rec.ValidateCustomerMinValue(Rec);
                    //HEI.03<<
                end;

            }


        }
        //BC UPGRADE SIVA <<
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
            ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.', FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';
            // ShortCutKey = Ctrl+F10;
        }

        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Pla&nning")
        {
            CaptionML = ENU = 'Pla&nning', FRA = 'Plan&ning';
        }
        modify("Order &Promising")
        {
            CaptionML = ENU = 'Order &Promising', FRA = 'Pro&messe de livraison';
        }
        modify("Send IC Sales Order Cnfmn.")
        {
            CaptionML = ENU = 'Send IC Sales Order Cnfmn.', FRA = 'Confirmation envoi commande vente IC';

            //Unsupported feature: Change Description on ""Send IC Sales Order Cnfmn."(Action 1102601053)". Please convert manually.


            //Unsupported feature: Change Visible on ""Send IC Sales Order Cnfmn."(Action 1102601053)". Please convert manually.

        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';

            //Unsupported feature: Change Description on "SendApprovalRequest(Action 1102601046)". Please convert manually.


            //Unsupported feature: Change Visible on "SendApprovalRequest(Action 1102601046)". Please convert manually.

        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify(Action3)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away/Pick', FRA = 'Créer prélèv./rangement stoc&k';
        }
        modify("Create &Warehouse Shipment")
        {
            CaptionML = ENU = 'Create &Whse. Shipment', FRA = 'Créer e&xpédition entrepôt';
            trigger OnBeforeAction()
            var
            begin
                //HEI.13>>
                IF SourceSystemIdentifierAPI.GET(Rec."Source System Identifier FND") THEN
                    IF SourceSystemIdentifierAPI."Automatic SO Posting" THEN
                        ERROR(CantModifyOrderErr, Rec."Source System Identifier FND");
                //HEI.13<<
                HeinekenGlobal.CheckCustLimitBeforeReleaseSO(Rec); //HEI.16
            end;
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';

        }
        modify(PostAndSend)
        {
            CaptionML = ENU = 'Post and Send', FRA = 'Valider et envoyer';
            ToolTipML = ENU = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.', FRA = 'Finalisez et préparez-vous à envoyer le document en fonction du profil d''envoi du client, comme en pièce jointe d''un e-mail par exemple. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';

        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify("Post &Batch")
        {
            CaptionML = ENU = 'Post &Batch', FRA = 'Valider par l&ot';
        }
        modify("Remove From Job Queue")
        {
            CaptionML = ENU = 'Remove From Job Queue', FRA = 'Supprimer de la file d''attente des travaux';
            ToolTipML = ENU = 'Remove the scheduled processing of this record from the job queue.', FRA = 'Supprimez le traitement planifié de cet enregistrement à partir de la file d''attente des travaux.';
        }
        modify("Preview Posting")
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify("Work Order")
        {
            CaptionML = ENU = 'Work Order', FRA = 'Ordre de fabrication';
        }
        modify("Pick Instruction")
        {
            CaptionML = ENU = 'Pick Instruction', FRA = 'Instruction prélèvement';
        }
        modify("&Order Confirmation")
        {
            CaptionML = ENU = '&Order Confirmation', FRA = '&Confirmation de commande';
        }
        modify("Email Confirmation")
        {
            CaptionML = ENU = 'Email Confirmation', FRA = 'Envoyer confirmation par e-mail';
            ToolTipML = ENU = 'Send an order confirmation by email. The Send Email window opens prefilled for the customer so you can add or change information before you send the email.', FRA = 'Envoyez une confirmation de commande par e-mail. La fenêtre Envoyer e-mail s''ouvre pré-remplie pour le client afin que vous puissiez ajouter ou modifier des informations avant d''envoyer l''e-mail.';
        }
        modify("Print Confirmation")
        {
            CaptionML = ENU = 'Print Confirmation', FRA = 'Imprimer confirmation';
            ToolTipML = ENU = 'Print an order confirmation. A report request window opens where you can specify what to include on the print-out.', FRA = 'Imprimez une confirmation commande. Une fenêtre de sélection de l''état s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        modify("Sales Reservation Avail.")
        {
            CaptionML = ENU = 'Sales Reservation Avail.', FRA = 'Dispo. réservation vente';
        }


        //Unsupported feature: CodeModification on "Release(Action 1102601049).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleaseSalesDoc.PerformManualRelease(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.11>>
        CompanyInfo.GET;

        CheckForLinkSalesDocument(Rec);

        if "Sundry Customer" then
          TestSundryMandatoryFields();
        //HEI.11<<

        HeinekenGlobal.CheckCustLimitBeforeReleaseSO(Rec); //HEI.16

        //>HEI.04>>
        HeinekenGlobal.CheckPCVNBalance(Rec);
        //>HEI.04>>

        //HEI.11>>
        if not CheckAvailability then
          exit;

        //ReleaseSalesDoc.PerformManualRelease(Rec);
        if not CompanyInfo."Enable French Localization" then
          ReleaseSalesDoc.DocStatusRelease(xRec,Rec);

        if CompanyInfo."Enable French Localization" then
          begin
            if PrepaymentMgt.TestSalesPrepayment(Rec) then
              ERROR(STRSUBSTNO(Text10800,"Document Type","No."));

            if PrepaymentMgt.TestSalesPayment(Rec) then begin
              if not CONFIRM(STRSUBSTNO(Text10801,"Document Type","No.")) then
                exit;
              Status := Status::"Pending Prepayment";
              MODIFY;
              CurrPage.UPDATE;
            end else
              ReleaseSalesDoc.DocStatusRelease(xRec,Rec);
          end;

        UpdateFreeReasonCodeDimensions;
        //HEI.11<<

        //HEI.03>>
        if (Status <> xRec.Status) and (Status = Status::Released) then begin
          ValidateCustomerMinValue(Rec);
        end;
        //HEI.03<<
        */
        //end;


        //Unsupported feature: CodeModification on "SendApprovalRequest(Action 1102601046).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
          ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        HeinekenGlobal.CheckCustLimitBeforeReleaseSO(Rec); //HEI.16

        ///DITW110.00.11 MSF 28/12/2017 NRQ#9570-DITW111.00.13 MSF 03/09/2018 NRQ#55906
        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
          ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Create &Whse. Shipment"(Action 1102601043).OnAction". Please convert manually.

        //trigger  Shipment"(Action 1102601043)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

        if not FIND('=><') then
          INIT;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.13>>
        if SourceSystemIdentifierAPI.GET("Source System Identifier") then
          if SourceSystemIdentifierAPI."Automatic SO Posting" then
            ERROR(CantModifyOrderErr,"Source System Identifier");
        //HEI.13<<

        HeinekenGlobal.CheckCustLimitBeforeReleaseSO(Rec); //HEI.16

        #1..4
        */
        //end;


        //Unsupported feature: CodeModification on "Post(Action 1102601003).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostOrderAndReturnOrderLinked(Rec); //HEI.02
        Post(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;


        //Unsupported feature: CodeModification on "PostAndSend(Action 25).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post and Send");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostOrderAndReturnOrderLinked(Rec); //HEI.02
        Post(CODEUNIT::"Sales-Post and Send");
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Pick Instruction"(Action 7).OnAction". Please convert manually.

        //trigger (Variable: SalesHeader)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Pick Instruction"(Action 7).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DocPrint.PrintSalesOrder(Rec,Usage::"Pick Instruction");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //DocPrint.PrintSalesOrder(Rec,Usage::"Pick Instruction");
        // <<DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
        SalesHeader := Rec;
        SalesHeader.SETRECFILTER;
        SalesHeader.SETRANGE("Shipment Date","Shipment Date");
        DocPrint.PrintSalesOrder(SalesHeader,Usage::"Pick Instruction");
        // >>DITW18.00.07 DDR DIT-770 #1488
        */
        //end;
        addafter("Co&mments")
        {
            //BC UPGRADE SIVA >> Drink IT Actions & linked to Drink IT fields
            // action("&Sales comments")
            // {
            //     CaptionML = ENU = '&Sales comments',
            //                 FRA = '&Commentaires Vente';
            //     Image = ViewComments;
            //     RunObject = Page "Sales Comment Sheet";
            //     RunPageLink = "Document Type" = FIELD("Document Type"),
            //                   "No." = FIELD("No."),
            //                   "Document Line No." = CONST(0),
            //                   "Sales Order" = CONST(true);
            //     ShortCutKey = 'Ctrl+B';
            // }
            // action("Shipping Costs")
            // {
            //     CaptionML = ENU = 'Shipping Costs',
            //                 FRA = 'Coûts transport';
            //     Image = Costs;
            //     RunObject = Page "Document Shipping Cost";
            //     RunPageLink = "Source Type" = CONST(36),
            //                   "Source No." = FIELD("No."),
            //                   "Sub Type" = FIELD("Document Type");
            // }
            //BC UPGRADE SIVA << Drink IT Actions & linked to Drink IT fields
        }
        addafter("Send IC Sales Order Cnfmn.")
        {
            //BC UPGRADE SIVA >> Drink IT code   
            // action(AutoSendICOrder)
            // {
            //     Caption = 'Auto. Send IC Order';
            //     Description = 'NRQ69018-FINXL14.00.15 MSF 13/05/2020 NRQ#117628';
            //     Image = Intercompany;
            //     Visible = NOT VisibleSendIC;

            //     trigger OnAction();
            //     begin
            //<<FINXL11.00 HBA 03/05/2018 NRQ#69018
            //         cduICWebservice.fctCopyICDocument("Document Type", "No.", 'SALES');
            //>>FINXL11.00 HBA 03/05/2018 NRQ#69018
            //     end;
            // }
            //BC UPGRADE SIVA<< Drink IT code
        }
        addfirst("&Print")
        {
            //BC UPGRADE SIVA >> Drink IT code
            // action("Order Confirmation (Packing)")
            // {
            //     CaptionML = ENU = 'Order Confirmation (Packing)',
            //                 FRA = 'Confirmation de commande (Emballage)';
            //     Image = Print;

            //     trigger OnAction();
            //     begin
            // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         DocPrint.PrintSalesHeaderPacking(Rec);
            // >>DITW16.00.00.40 DDR DIT-715 #197
            //     end;
            // }
            //BC UPGRADE SIVA << Drink IT code
        }
        //BC UPGRADE SIVA >> Drink IT Code
        // addafter("Pick Instruction")
        // {
        //     separator(Separator1100076002)
        //     {
        //     }

        // action("Packing List")
        // {
        //     CaptionML = ENU = 'Packing List',
        //                 FRA = 'Liste emballage';
        //     Image = Print;

        //     trigger OnAction();
        //     var
        //         SalesHeaderRecL: Record "Sales Header";
        //     begin
        //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //         SalesHeaderRecL.SETRANGE("Document Type", "Document Type");
        //         SalesHeaderRecL.SETRANGE("No.", "No.");
        //         REPORT.RUN(REPORT::"Packing List", true, false, SalesHeaderRecL);
        //         // >>DITW16.00.00.40 DDR DIT-715 #197
        //     end;
        // }
        // separator(Separator1100710010)
        // {
        // }
        // action("Test AAD Document")
        // {
        //     CaptionML = ENU = 'Test AAD Document',
        //                 FRA = 'Tester document AAD';
        //     Image = Print;

        //     trigger OnAction();
        //     begin
        //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //         DocPrint.PrintSalesHeaderAAD(Rec);
        //         // >>DITW16.00.00.40 DDR DIT-715 #197
        //     end;
        // }

        //   } //BC UPGRADE SIVA << Drink IT Code
    }


    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";

        //var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";

        //var
        SalesHeader: Record "Sales Header";


        //Unsupported feature: PropertyModification on "Usage(Variable 1001)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Usage : "Order Confirmation","Work Order","Pick Instruction";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Usage : "Order Confirmation","Work Order","Pick Instruction",,,,,,,,,,"Order Picking","Picking List","Shipping List","Order Shipment","Combined Picking","Load List","Shipment Specif.","Return Control",,,,,,,,,,,,,,,,,,,,"Pro-forma";
        //Variable type has not been exported.

        //var
        //cduICWebservice: Codeunit "IC Web Service"; //BC UPGRADE SIVA Drink IT CU2029636
        DimMgt: Codeunit DimensionManagement;
        ShortcutQtyUomBase: array[3] of Decimal;
        ShortcutQtyUomOutstd: array[3] of Decimal;
        VisibleSendApproval: Boolean;
        HeinekenGlobal: Codeunit "Heineken Global";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        docsubtypecodesetup: Record "Doc Subtype Code Setup FND";
        ReleaseSelectedVisible: Boolean;
        CompanyInfo: Record "Company Information";
        Text10800: TextConst ENU = 'There are unposted prepayment amounts on the document of type %1 with the number %2.', FRA = 'Il existe des montants acompte non validés sur le document de type %1 portant le numéro %2.';
        Text10801: TextConst ENU = 'There are unpaid prepayment invoices related to the document of type %1 with the number %2.', FRA = 'Il existe des factures d''acompte impayées liées au document de type %1 portant le numéro %2.';
        VisibleSendIC: Boolean;
        CantModifyOrderErr: Label 'You can not modify an Order sent by %1.';


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlVisibility;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetControlVisibility;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

    //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    VisibleSendIC := not IsAutoSendDocEnabled ;
    //>>FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244 - DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
    ShowShortcutUomValue(ShortcutQtyUomBase,ShortcutQtyUomOutstd,2);
    // >>DITW16.00.00.40 DDR DIT-715 #244 - DITW18.00.07 DDR DIT-770 #1488
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    trigger OnOpenPage();
    begin
        //BC UPGRADE SIVA >> Drink IT code 
        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1190
        //IF UserMgt.GetSalesFilter <> '' THEN BEGIN
        // if UserMgt.GetSalesTextFilter <> '' then begin
        //     FILTERGROUP(2);
        //     //SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
        //     SETFILTER("Responsibility Center", UserMgt.GetSalesTextFilter);
        //     FILTERGROUP(0);
        // end;
        // >>DITW18.00.06 DDR DIT-770 #1190
        //#6..13

        // BC Upgrade SHUKLP03 >> Added code for Document Subtype field.
        //HEI.01 PATHAA02>>
        if docsubtypecodesetup.GET then begin
            docsubtypecodesetup.TESTFIELD(docsubtypecodesetup."Sales - General");
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Document Subtype Code FND", docsubtypecodesetup."Sales - General");
            Rec.FILTERGROUP(0);
        end;
        //PATHAA02<<
        // BC Upgrade SHUKLP03 << Added code for Document Subtype field.

        //<<DITW111.00.13A MSF 02/05/2019 NRQ#103938
        //SalesSetup.GET();
        //VisibleSendApproval := not SalesSetup."Automatic Document Approval";
        //>>DITW111.00.13A MSF 02/05/2019 NRQ#103938
        //BC UPGRADE SIVA<< Drink IT Code
    end;

    local procedure CheckAvailability(): Boolean;
    var
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesLines: Record "Sales Line";
        ItemsNotAvailable: Text;
        Text001: Label 'The following items have an available inventory lower than the entered quantity:\%1\Do you want to continue?';
        SalesSetup: Record "Sales & Receivables Setup";
        ItemStockWarning: Record Item;
    begin
        //HEI.11>>
        SalesSetup.GET();
        if not SalesSetup."Item availability FND" then
            exit(true);

        ItemsNotAvailable := '';
        SalesLines.RESET();
        SalesLines.SETRANGE("Document Type", Rec."Document Type");
        SalesLines.SETRANGE("Document No.", Rec."No.");
        SalesLines.SETRANGE(Type, SalesLines.Type::Item);
        SalesLines.SETFILTER(Quantity, '<>%1', 0);
        SalesLines.SETFILTER("Attached to Line No.", '=%1', 0);
        if SalesLines.FINDFIRST() then
            repeat
                if ItemStockWarning.GET(SalesLines."No.") and
                  ((ItemStockWarning."Stockout Warning" = ItemStockWarning."Stockout Warning"::Yes) or (ItemStockWarning."Stockout Warning" = ItemStockWarning."Stockout Warning"::Default) and SalesSetup."Stockout Warning") then
                    if SalesInfoPaneMgt.CalcAvailability(SalesLines) < 0 then
                        ItemsNotAvailable += SalesLines."No." + ' ';
            until SalesLines.NEXT() = 0;

        if ItemsNotAvailable <> '' then begin
            if not CONFIRM(Text001, true, ItemsNotAvailable) then
                exit(false);
        end;
        exit(true);
        //HEI.11<<
    end;

    local procedure Postsubmit(PostingCodeunitID: Integer);
    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    BEGIN
        //IF ApplicationAreaSetup.IsFoundationEnabled THEN //BC UPGRADE SIVA Microsoft No need to check
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        CurrPage.UPDATE(FALSE);
    END;


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}
