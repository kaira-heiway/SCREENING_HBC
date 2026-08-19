page 53030 "CTS Order List"
{
    // version NAVW110.0.00.15052,FINXL10.00,DITW110.00.11,HEI.01

    // FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"
    // 
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Upgrade
    //                                              Added menu into 'Print' button
    //                                                'Order Confirmation (Packing)'
    //                                                'Test AAD Document'
    //                                                'Packing List'
    //                     20/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    //                     20/02/2012 DIT-715 #244 Added/Moved columns
    // DITW16.00.00.43 DDR 13/05/2013 DIT-715 #606 Added fields  "Document Status"
    // 
    // DITW17.00.02 DDR 13/05/2013 DIT-715 #606
    // 
    // DITW17.00.02 AT  03/10/2013 DIT-770 #183
    //                  Added fields Invoice Method & Invoice Period
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields "Responsibility Center","Physical Location Group Code"
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.05 MSF 08/08/14 DIT-770 #795 : Min. HL Volume and Min. UOM warning in order intake - PART3
    //                                          Added  Field "Total Eq. UOM Quantity"
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added Field 2014100 "Trailer Code"
    // DITW18.00.07 AKH 07/01/2016 DIT-770 #1806 Added fields: "Sell-to Customer Name 2", Address, "Address 2", "Sell-to City" (Visible FALSE)
    // DITW18.00.07 KJB 18/02/2016 DIT-770 #1042 Add menu to open Sales Comment Sheet
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Customer"
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Add Action to Shipping Cost Page + Removed old Shipping Costs fields
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 Removed ation Sales Comment Sheet
    // DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Added filters to print "Pick Instruction"
    //                                           Updated ShowShortcutUomValue function
    // DITW19.00.08 VSC 05/12/2016 BL#10330 (DIT-770 #2122) Re index options Report Usage
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 03/02/2017 NRQ#20678 upgrade Usage optionstring
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.11 MSF 28/12/2017 NRQ#9570 DIT Sales approval for Credit limit
    // 
    // HEI.04 FDD-KDDOTCGAP003 IBM ISYED01 10.10.2017
    //   # code added to release function
    // 
    // HEI.02 FDD-KDD0TC005 IBM NASTAA02 9.11.2017 # RPM Billing and Reporting
    //   # Code added on Post Actions to post the Sales Order and the Sales Return Order which are linked
    // 
    // HEI.03 SLSGAP021 IBM LAZARE02 31.08.2018
    //   # Default subtype code to CTS
    // HEI.04 CHG2046145 IBM.GAVANM01 16.03.2020 # Sales Order Status Addition
    //   # New field added : 50051 - "Approval Status"
    // BC Upgrade BHARDA11 >>
    /* 
   1. Old Page ID - 50211. 
   2. Removed Drink-IT related fields: 
   - "Document Subtype Code"
   - "DIT Sub-Contract Type"
   - "Sales Routes"
   - "Distance"
   - "Truck Code"
   - "Trailer Code"
   - "Truck Zone"
   - "Driver Code"
   - "Driver 2 Code"
   - "Require 2 Drivers"
   - "Ship-to Address Key No."
   - "Route"
   - "Route Planning No."
   - "Delivery Sequence"
   - "Shipping Charge Per"
   - "Maximum Weight"
   - "Maximum Cubage"
   - "Total Weight (Base)"
   - "Total Weight"
   - "Total Cubage (Base)"
   - "Total Cubage"
   - "Total HL Cubage (Base)"
   - "Total HL Cubage"
   - "Total Eq. UOM Quantity (Base)"
   - "Total Eq. UOM Quantity"
   - "Delivery Time 1 From"
   - "Delivery Time 1 To"
   - "Delivery Time 2 From"
   - "Delivery Time 2 To"
   - "Customer Delivery Type"
   - "Delivery Time (sec.)"
   - "Transport Mode"
   - "Contract Type"
   - "DIT Sub-Contract Type"
   - "Service Contract No."
   - "Financial Contract No."
   - "Contract Group Code"
   - "Invoice List Customer No."
   - "Invoice Method"
   - "Invoice Period"
   - "Sundry Customer"
   - "Last changed User ID"
   - "Last changed Date/time"
   - "Suggested Return Item"
   - "Physical Location Group Code"
   - "Whse. Shipment No. (First)"
   - "Whse. Shipment Status (First)"
   - "Return Location Code"
   - "Shipment Date Formula"
   - "Shipment Time"
   - "Submission Type"
3. Removed Drink-IT related actions:
   - "Comments - Transport Mode"
   - "Show N-owm activities"
   - "Return control"
   - "Process backorder lines"
   - "Get Pre-Promotion Order Alert"
   - "Get Delayed Discount"
   - "Update Order"
   - "Sales Item History"
   - "Calculate Recycle Charges"
   - "Returned Items"
   - "Suggest Return Items"
   - "Register Route Shipment entries"
   - "Send e-AAD Request"
   - "Send e-Cancelling Request"
   - "RPM Balance Accounting"
   - "Change Shipping status"
   - "Order Shipment"
  4. Add ApplicationArea Property in all fields and actions.
  5. Comment code "ApplicationAreaSetup.IsFoundationEnabled" because IsFoundationEnabled is missing in "Application AreacSetup" table.
    */
    // BC Upgrade BHARDA11 <<

    //BC UPGRADE SHIKHD02>>
    //Blocked obsolete OpenSalesOrderStatistics method and replaced it with RunObject = Page "Sales Order Statistics" as the BC recommended replacement, OnAction() trigger blocked as no longer needed in action(Statistics) under actions -> area(navigation) -> group("O&rder").
    //Checked on-prem and no functional change was observed after the replacement.
    //BC UPGRADE SHIKHD02<<

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added

    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'CTS Order List';
    CardPageID = "CTS Order";
    DataCaptionFields = "Document Type", "Sell-to Customer No.";
    Editable = false;
    PageType = List;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Request Approval,Order',
                                 FRA = 'Nouveau,Traiter,Déclarer,Demander une approbation,Commander';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the number of the sales document.',
                                FRA = 'Spécifie le numéro du document vente.';
                }
                // BC Upgrade SHUKLP03 >> Added Field("Document Subtype Code")
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade SHUKLP03 << Added Field("Document Subtype Code")
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the number of the customer who will receive the products and be billed by default.',
                                FRA = 'Spécifie le numéro du client qui va recevoir les produits et être facturé par défaut.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the name of the customer who will receive the products and be billed by default.',
                                FRA = 'Spécifie le nom du client qui recevra les produits et sera facturé par défaut.';
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the number that the customer uses in their own system to refer to this sales document.',
                                FRA = 'Spécifie le numéro que le client doit utiliser dans son propre système pour faire référence à ce document vente.';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the postal code of the address.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the name of the person to contact at the customer.',
                                FRA = 'Spécifie le nom de la personne à contacter chez le client.';
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the customer to whom you will send the sales invoice when this customer is different from the sell-to customer.',
                                FRA = 'Spécifie le nom du client auquel vous envoyez la facture vente, si ce client diffère de celui auquel vous vendez.';
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.',
                                FRA = 'Spécifie le nom du client auquel vous envoyez la facture vente, s''il diffère du client auquel vous vendez.';
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the postal code of the address.',
                                FRA = 'Spécifie le code postal de l''adresse.';
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the country/region code of the address.',
                                FRA = 'Spécifie le code pays/la région de l''adresse.';
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.',
                                FRA = 'Spécifie le nom de la personne que vous devez contacter chez le client auquel vous envoyez la facture.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.',
                                FRA = 'Spécifie le code d''une adresse de livraison différente de l''adresse du client, qui est entrée par défaut.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the name that products on the sales document will be shipped to.',
                                FRA = 'Spécifie le nom auquel les produits mentionnés sur le document vente seront expédiés.';
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
                    ToolTipML = ENU = 'Specifies the name of the contact person at the address that products will be shipped to.',
                                FRA = 'Spécifie le nom du contact à l''adresse à laquelle ces produits seront expédiés.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date when the posting of the sales document will be recorded.',
                                FRA = 'Spécifie la date à laquelle la validation du document vente sera validée.';
                    Visible = false;
                }
                // BC Upgrade BHARAD11 >> ----Drink-IT Customization
                // field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                // {
                //     ApplicationArea = Suite;
                //     ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.',
                //                 FRA = 'Spécifie le code pour Raccourci axe 1.';
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean;
                //     begin
                //         // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
                //         DimMgt.LookupDimValueCodeNoUpdate(1);
                //     end;
                // }
                // field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                // {
                //     ApplicationArea = Suite;
                //     ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.',
                //                 FRA = 'Spécifie le code pour Raccourci axe 2.';
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean;
                //     begin
                //         // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
                //         DimMgt.LookupDimValueCodeNoUpdate(2);
                //     end;
                // }
                // BC Upgrade BHARAD11 << ----Drink-IT Customization
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Physical Location Group Code")
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Physical Location Group Code")
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.',
                                FRA = 'Spécifie le magasin à partir duquel les articles de stock doivent être expédiés par défaut au client figurant sur le document vente.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the name of the salesperson who is assigned to the customer.',
                                FRA = 'Spécifie le nom du vendeur affecté au client.';
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
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the currency of amounts on the sales document.',
                                FRA = 'Spécifie la devise des montants sur le document vente.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date on which you created the sales document.',
                                FRA = 'Spécifie la date à laquelle vous avez créé le document vente.';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date that the customer has asked for the order to be delivered.',
                                FRA = 'Spécifie la date à laquelle le client a demandé à être livré.';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the campaign number the document is linked to.',
                                FRA = 'Spécifie le numéro de campagne auquel le document est lié.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.',
                                FRA = 'Spécifie si le document est ouvert, est en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
                }
                field("Approval Status"; Rec."Approval Status FND")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Shipment status")
                // field("Shipment status"; Rec."Shipment status")
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Shipment status")
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.',
                                FRA = 'Spécifie une formule qui calcule la date d''échéance du paiement, la date d''escompte et le montant de la remise sur le document de vente.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies when the sales invoice must be paid.',
                                FRA = 'Spécifie la date à laquelle la facture vente doit être payée.';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the payment discount percentage that is granted if the customer pays on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.',
                                FRA = 'Spécifie le pourcentage d''escompte possible qui est accordé si le client paye à la date entrée dans le champ Date d''escompte, ou de manière anticipée. Le pourcentage remise est spécifié dans le champ Code condition paiement.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies how items on the sales document are shipped to the customer.',
                                FRA = 'Spécifie le mode d''expédition au client des articles figurant sur le document vente.';
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.',
                                FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
                    Visible = false;
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.',
                                FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
                    Visible = false;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the shipping agent''s package number.',
                                FRA = 'Spécifie le numéro récépissé du transporteur.';
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the date you expect to ship items on the sales document.',
                                FRA = 'Spécifie la date à laquelle vous pensez expédier les articles indiqués sur le document vente.';
                    Visible = false;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies if the customer accepts partial shipment of orders.',
                                FRA = 'Spécifie si le client accepte l''expédition partielle des commandes.';
                    Visible = false;
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies whether all the items on the order have been shipped or, in the case of inbound items, completely received.',
                                FRA = 'Indique si tous les articles de la commande ont été expédiés ou, dans le cas d''articles entrants, intégralement réceptionnés.';
                }
                field(Shipped; Rec.Shipped)
                {
                    ApplicationArea = All;
                }
                field(Ship; Rec.Ship)
                {
                    ApplicationArea = All;
                }
                field(Invoice; Rec.Invoice)
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Distance", "Delivery Order", "Invoice Method", "Invoice Period", "Truck Code", "Trailer Code", "Driver Code", "Driver 2 Code", "Route", "Route Planning No.", "Shipping Charge Per", "Picking Type", "Maximum Weight", "Maximum Cubage", "Total Weight (Base)", "Total Weight", "Total Cubage (Base)", "Total Cubage", "Total HL Cubage", "Total Eq. UOM Quantity")
                // field(Distance; Rec.Distance)
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Delivery Order"; Rec."Delivery Order")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Invoice Method"; Rec."Invoice Method")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Invoice Period"; Rec."Invoice Period")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Truck Code"; Rec."Truck Code")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Trailer Code"; Rec."Trailer Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Driver Code"; Rec."Driver Code")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Driver 2 Code"; Rec."Driver 2 Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field(Route; Rec.Route)
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Route Planning No."; Rec."Route Planning No.")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Shipping Charge Per"; Rec."Shipping Charge Per")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Picking Type"; Rec."Picking Type")
                // {
                //     ApplicationArea = All;
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
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Total Weight"; Rec."Total Weight")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Total Cubage (Base)"; Rec."Total Cubage (Base)")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Total Cubage"; Rec."Total Cubage")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Total HL Cubage"; Rec."Total HL Cubage")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Total Eq. UOM Quantity"; Rec."Total Eq. UOM Quantity")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Distance", "Delivery Order", "Invoice Method", "Invoice Period", "Truck Code", "Trailer Code", "Driver Code", "Driver 2 Code", "Route", "Route Planning No.", "Shipping Charge Per", "Picking Type", "Maximum Weight", "Maximum Cubage", "Total Weight (Base)", "Total Weight", "Total Cubage (Base)", "Total Cubage", "Total HL Cubage", "Total Eq. UOM Quantity")
                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // field(ShortcutQtyUomBase[1];ShortcutQtyUomBase[1])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(1,0);
                //     DecimalPlaces = 0:5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field(ShortcutQtyUomBase[2];ShortcutQtyUomBase[2])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(2,0);
                //     DecimalPlaces = 0:5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field(ShortcutQtyUomBase[3];ShortcutQtyUomBase[3])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(3,0);
                //     DecimalPlaces = 0:5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field(ShortcutQtyUomOutstd[1];ShortcutQtyUomOutstd[1])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(1,1);
                //     DecimalPlaces = 0:5;
                //     Description = 'DIT-770 #1488';
                //     Editable = false;
                //     Visible = false;
                // }
                // field(ShortcutQtyUomOutstd[2];ShortcutQtyUomOutstd[2])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(2,1);
                //     DecimalPlaces = 0:5;
                //     Description = 'DIT-770 #1488';
                //     Editable = false;
                //     Visible = false;
                // }
                // field(ShortcutQtyUomOutstd[3];ShortcutQtyUomOutstd[3])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(3,1);
                //     DecimalPlaces = 0:5;
                //     Description = 'DIT-770 #1488';
                //     Editable = false;
                //     Visible = false;
                // }
                // BC Upgrade BHARAD11 << ----Drink-IT Customization
                // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Link Sales Document Type", "Link Sales Document No.", "Building No.", "Fiscal Representative No.", "Customer Tax Registration No.", "Customer Tax Warehouse Ref.")
                // field("Link Sales Document Type"; Rec."Link Sales Document Type")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Link Sales Document No."; Rec."Link Sales Document No.")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Building No."; Rec."Building No.")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // field("Customer Tax Registration No."; Rec."Customer Tax Registration No.")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Customer Tax Warehouse Ref."; Rec."Customer Tax Warehouse Ref.")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Fields("Link Sales Document Type", "Link Sales Document No.", "Building No.", "Fiscal Representative No.", "Customer Tax Registration No.", "Customer Tax Warehouse Ref.")
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.',
                                FRA = 'Spécifie le statut d''une écriture file d''attente des travaux ou d''une tâche qui gère la validation des commandes vente.';
                    Visible = JobQueueActive;
                }
                // BC Upgrade BHARAD11 >> ----Drink-IT Fields("Sundry Customer", "Last changed User ID", "Last changed Date/time")
                // field("Sundry Customer"; Rec."Sundry Customer")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Last changed User ID"; Rec."Last changed User ID")
                // {
                //     ApplicationArea = All;
                // }
                // field("Last changed Date/time"; Rec."Last changed Date/time")
                // {
                //     ApplicationArea = All;
                // }
                // BC Upgrade BHARAD11 << ----Drink-IT Fields("Sundry Customer", "Last changed User ID", "Last changed Date/time")

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    //BC UPGRADE SHIKHD02>>
                    //Blocked obsolete OpenSalesOrderStatistics method and replaced it with RunObject = Page "Sales Order Statistics" as the BC recommended replacement; OnAction() trigger blocked as no longer needed
                    //checked on-prem and no functional change was observed after the replacement
                    RunObject = Page "Sales Order Statistics";
                    // trigger OnAction();
                    // begin
                    //     Rec.OpenSalesOrderStatistics;
                    // end;
                    //BC UPGRADE SHIKHD02<<
                }
                action(Approvals)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Approvals',
                                FRA = 'Approbations';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.',
                                FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry"; // BC Upgrade BHARAD11 :: Added.
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No."); // BC Upgrade BHARDA11 ::Blocked
                        // BC Upgrade BHARDA11 >> ----Added
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", 36);
                        ApprovalEntry.SetRange("Document Type", Rec."Document Type");
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        // BC Upgrade BHARDA11 << ----Added
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action("&Sales comments")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = '&Sales comments',
                                FRA = '&Commentaires Vente';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    //   "Sales Order" = CONST(true); // BC Upgrade BHARDA11 ----Drink-IT Field("Sales Order")
                    ShortCutKey = 'Ctrl+B';
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Page(2014096)
                // action("Shipping Costs")
                // {
                //     ApplicationArea = All;
                //     CaptionML = ENU = 'Shipping Costs',
                //                 FRA = 'Coûts transport';
                //     Image = Costs;
                //     RunObject = Page 2014096;
                //     RunPageLink = Source Type=CONST(36),
                //                   Source No.=FIELD(No.),
                //                   Sub Type=FIELD(Document Type);
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Page(2014096)
            }
            group(Documents)
            {
                CaptionML = ENU = 'Documents',
                            FRA = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'S&hipments',
                                FRA = 'E&xpéditions';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTipML = ENU = 'View the history of posted sales shipments that have been posted for the document.',
                                FRA = 'Affichez l''historique des expositions vente validées qui ont été enregistrées pour le document.';
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Invoices',
                                FRA = 'Factures';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTipML = ENU = 'View the history of posted sales invoices that have been posted for the document.',
                                FRA = 'Affichez l''historique des factures vente validées qui ont été enregistrées pour le document.';
                }
                action(PostedSalesPrepmtInvoices)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Prepa&yment Invoices',
                                FRA = 'Factures acom&pte';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Prepayment Credi&t Memos',
                                FRA = 'A&voirs acompte';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
            }
            group(Warehouse)
            {
                CaptionML = ENU = 'Warehouse',
                            FRA = 'Entrepôt';
                Image = Warehouse;
                action("Whse. Shipment Lines")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Whse. Shipment Lines',
                                FRA = 'Lignes expédition entrepôt';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'In&vt. Put-away/Pick Lines',
                                FRA = 'Lignes prélè&v./rangement stock';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
            }
            group(ActionGroupCRM)
            {
                CaptionML = ENU = 'Dynamics CRM',
                            FRA = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToSalesOrderListInNAV)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Sales Order List',
                                FRA = 'Liste des commandes vente';
                    Enabled = CRMIntegrationEnabled;
                    Image = "Order";
                    ToolTipML = ENU = 'Open the Dynamics CRM Sales Order List page in Dynamics NAV',
                                FRA = 'Ouvrez la page Liste des commandes vente Dynamics CRM dans Dynamics NAV.';
                    Visible = CRMIntegrationEnabled;

                    trigger OnAction();
                    var
                        CRMSalesorder: Record "CRM Salesorder";
                    begin
                        PAGE.RUN(PAGE::"CRM Sales Order List", CRMSalesorder);
                    end;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                CaptionML = ENU = 'Release',
                            FRA = 'Lancer';
                Image = ReleaseDoc;
                action(Release1)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Re&lease',
                                FRA = '&Lancer';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        //>HEI.04>>
                        HeinekenGlobal.CheckPCVNBalance(Rec);
                        //>HEI.04>>
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Re&open',
                                FRA = 'R&ouvrir';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F10';
                    ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.',
                                FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                Image = "Action";
                action("Pla&nning")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Pla&nning',
                                FRA = 'Plan&ning';
                    Image = Planning;

                    trigger OnAction();
                    var
                        SalesOrderPlanningForm: Page "Sales Order Planning";
                    begin
                        SalesOrderPlanningForm.SetSalesOrder(Rec."No.");
                        SalesOrderPlanningForm.RUNMODAL;
                    end;
                }
                action("Order &Promising")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Order Promising Line" = R;
                    CaptionML = ENU = 'Order &Promising',
                                FRA = 'Pro&messe de livraison';
                    Image = OrderPromising;

                    trigger OnAction();
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "IC G/L Account" = R;
                    CaptionML = ENU = 'Send IC Sales Order Cnfmn.',
                                FRA = 'Confirmation envoi commande vente IC';
                    Image = IntercompanyOrder;

                    trigger OnAction();
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                            ICInOutboxMgt.SendSalesDoc(Rec, FALSE);
                    end;
                }
            }
            group("Request Approval")
            {
                CaptionML = ENU = 'Request Approval',
                            FRA = 'Approbation demande achat';
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
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
                        //<<DITW110.00.11 MSF 28/12/2017 NRQ#9570
                        //VALIDATE("To Check Credit Limit Amount",ApprovalsMgmt.CreateToCheckCreditlimitAmount("To Check Credit Limit Amount","To Check Credit Limit Amount",Rec));
                        CurrPage.SAVERECORD;
                        //>>DITW110.00.11 MSF 28/12/2017 NRQ#9570
                        IF ApprovalsMgmt.CheckSalesApprovalPossible(Rec) THEN
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
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
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Cancel the approval request.',
                                FRA = 'Annulez la demande d''approbation.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            group(Warehouse1)
            {
                CaptionML = ENU = 'Warehouse',
                            FRA = 'Entrepôt';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    CaptionML = ENU = 'Create Inventor&y Put-away/Pick',
                                FRA = 'Créer prélèv./rangement stoc&k';
                    Ellipsis = true;
                    Image = CreatePutawayPick;

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT();
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Warehouse Shipment Header" = R;
                    CaptionML = ENU = 'Create &Whse. Shipment',
                                FRA = 'Créer e&xpédition entrepôt';
                    Image = NewShipment;

                    trigger OnAction();
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT();
                    end;
                }
            }
            group("P&osting")
            {
                CaptionML = ENU = 'P&osting',
                            FRA = '&Validation';
                Image = Post;
                action(Post1)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'P&ost',
                                FRA = '&Valider';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.',
                                FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';

                    trigger OnAction();
                    begin
                        Rec.PostOrderAndReturnOrderLinked(Rec); //HEI.02
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Post and Send',
                                FRA = 'Valider et envoyer';
                    Ellipsis = true;
                    Image = PostMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTipML = ENU = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.',
                                FRA = 'Finalisez et préparez-vous à envoyer le document en fonction du profil d''envoi du client, comme en pièce jointe d''un e-mail par exemple. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';

                    trigger OnAction();
                    begin
                        Rec.PostOrderAndReturnOrderLinked(Rec); //HEI.02
                        Post(CODEUNIT::"Sales-Post and Send");
                    end;
                }
                action("Test Report")
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
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post &Batch")
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
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
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
                action("Preview Posting")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Preview Posting',
                                FRA = 'Aperçu compta.';
                    Image = ViewPostedOrder;
                    ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.',
                                FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';

                    trigger OnAction();
                    begin
                        ShowPreview
                    end;
                }
            }
            group("&Print")
            {
                CaptionML = ENU = '&Print',
                            FRA = '&Imprimer';
                Image = Print;
                // BC Upgrade BHARAD11 >> ----Drink-IT Customization
                // action("Order Confirmation (Packing)")
                // {
                //     ApplicationArea = All;
                //     CaptionML = ENU = 'Order Confirmation (Packing)',
                //                 FRA = 'Confirmation de commande (Emballage)';
                //     Image = Print;

                //     trigger OnAction();
                //     begin
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         DocPrint.PrintSalesHeaderPacking(Rec);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // }
                // BC Upgrade BHARAD11 << ----Drink-IT Customization
                action("Work Order")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Work Order',
                                FRA = 'Ordre de fabrication';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction();
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                // BC Upgrade BHARAD11 >> ----Drink-IT Customization
                // action("Pick Instruction")
                // {
                //     ApplicationArea = All;
                //     CaptionML = ENU = 'Pick Instruction',
                //                 FRA = 'Instruction prélèvement';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         SalesHeader: Record "Sales Header";
                //     begin
                //         //DocPrint.PrintSalesOrder(Rec,Usage::"Pick Instruction");
                //         // <<DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
                //         SalesHeader := Rec;
                //         SalesHeader.SETRECFILTER;
                //         SalesHeader.SETRANGE("Shipment Date", "Shipment Date");
                //         DocPrint.PrintSalesOrder(SalesHeader, Usage::"Pick Instruction");
                //         // >>DITW18.00.07 DDR DIT-770 #1488
                //     end;
                // }
                // separator(Gen)
                // {
                // }

                // action("Packing List")
                // {
                //     ApplicationArea = All;
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
                //         REPORT.RUN(REPORT::"Packing List", TRUE, FALSE, SalesHeaderRecL);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // }
                separator(Gen2)
                {
                }
                // BC Upgrade BHARAD11 >> ----Drink-IT Customization
                // action("Test AAD Document")
                // {
                //     ApplicationArea = All;
                //     CaptionML = ENU = 'Test AAD Document',
                //                 FRA = 'Tester document AAD';
                //     Image = Print;

                //     trigger OnAction();
                //     begin
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         // DocPrint.PrintSalesHeaderAAD(Rec); // BC Upgrade BHARDA11 ----Drink-IT Code
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // }
                // BC Upgrade BHARAD11 << ----Drink-IT Customization
            }
            group("&Order Confirmation")
            {
                CaptionML = ENU = '&Order Confirmation',
                            FRA = '&Confirmation de commande';
                Image = Email;
                action("Email Confirmation")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Email Confirmation',
                                FRA = 'Envoyer confirmation par e-mail';
                    Ellipsis = true;
                    Image = Email;
                    ToolTipML = ENU = 'Send an order confirmation by email. The Send Email window opens prefilled for the customer so you can add or change information before you send the email.',
                                FRA = 'Envoyez une confirmation de commande par e-mail. La fenêtre Envoyer e-mail s''ouvre pré-remplie pour le client afin que vous puissiez ajouter ou modifier des informations avant d''envoyer l''e-mail.';

                    trigger OnAction();
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                action("Print Confirmation")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Print Confirmation',
                                FRA = 'Imprimer confirmation';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTipML = ENU = 'Print an order confirmation. A report request window opens where you can specify what to include on the print-out.',
                                FRA = 'Imprimez une confirmation commande. Une fenêtre de sélection de l''état s''ouvre et vous permet d''indiquer les éléments à imprimer.';
                    Visible = NOT IsOfficeAddin;

                    trigger OnAction();
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Sales Reservation Avail.',
                            FRA = 'Dispo. réservation vente';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Reservation Avail.";
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlVisibility;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnAfterGetRecord();
    begin
        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244 - DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
        // ShowShortcutUomValue(ShortcutQtyUomBase, ShortcutQtyUomOutstd, 2); // BC Upgrade BHARDA11 ----Drink-IT Code
        // >>DITW16.00.00.40 DDR DIT-715 #244 - DITW18.00.07 DDR DIT-770 #1488
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        EXIT(Rec.FIND(Which) AND ShowHeader);
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    var
        NewStepCount: Integer;
    begin
        REPEAT
            NewStepCount := Rec.NEXT(Steps);
        UNTIL (NewStepCount = 0) OR ShowHeader;

        EXIT(NewStepCount);
    end;

    trigger OnOpenPage();
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
    begin
        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1190
        //IF UserMgt.GetSalesFilter <> '' THEN BEGIN
        // BC Upgrade BHARDA11 >> ---_Drink-IT Code
        // IF UserMgt.GetSalesTextFilter <> '' THEN BEGIN
        //     FILTERGROUP(2);
        //     //SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
        //     SETFILTER("Responsibility Center", UserMgt.GetSalesTextFilter);
        //     FILTERGROUP(0);
        // END;
        // BC Upgrade BHARDA11 << ---_Drink-IT Code

        // >>DITW18.00.06 DDR DIT-770 #1190

        Rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);

        JobQueueActive := SalesSetup.JobQueueActive();
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        IsOfficeAddin := OfficeMgt.IsAvailable();

        Rec.CopySellToCustomerFilter();

        //HEI.01 SHUKLP03>>
        //BC Upgrade SHUKLP03 >> added code.
        IF DocSubtypeCodeSetup.GET() THEN BEGIN
            DocSubtypeCodeSetup.TESTFIELD(DocSubtypeCodeSetup."CTS Order");
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Document Subtype Code FND", DocSubtypeCodeSetup."CTS Order");
            Rec.FILTERGROUP(0);
        END;
        // BC Upgrade SHUKLP03 << added code.
        //PATHAA02<<
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction",,,,,,,,,,"Order Picking","Picking List","Shipping List","Order Shipment","Combined Picking","Load List","Shipment Specif.","Return Control",,,,,,,,,,,,,,,,,,,,"Pro-forma";
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        SkipLinesWithoutVAT: Boolean;
        DimMgt: Codeunit DimensionManagement;
        ShortcutQtyUomBase: array[3] of Decimal;
        ShortcutQtyUomOutstd: array[3] of Decimal;
        HeinekenGlobal: Codeunit "Heineken Global";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DocSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; // BC Upgrade SHUKLP03 

    procedure ShowPreview();
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RECORDID);
    end;

    local procedure Post(PostingCodeunitID: Integer);
    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        // BC Upgrade BHARDA11 >> ---IsFoundationEnabled is not found in "Application Area Setup" Table
        // IF ApplicationAreaSetup.IsFoundationEnabled THEN
        //     LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
        // BC Upgrade BHARDA11 << ---IsFoundationEnabled is not found in "Application Area Setup" Table

        Rec.SendToPosting(PostingCodeunitID);

        CurrPage.UPDATE(FALSE);
    end;

    procedure SkipShowingLinesWithoutVAT();
    begin
        SkipLinesWithoutVAT := TRUE;
    end;

    local procedure ShowHeader(): Boolean;
    var
        CashFlowManagement: Codeunit "Cash Flow Management";
    begin
        IF NOT SkipLinesWithoutVAT THEN
            EXIT(TRUE);

        EXIT(CashFlowManagement.GetTaxAmountFromSalesOrder(Rec) <> 0);
    end;
}

