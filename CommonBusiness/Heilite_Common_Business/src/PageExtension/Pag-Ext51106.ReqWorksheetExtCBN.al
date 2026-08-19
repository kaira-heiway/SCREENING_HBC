pageextension 51106 ReqWorksheetExtCBN extends "Req. Worksheet"
{
    // version NAVW110.0.00.15052,FINXL10.00,MANXL7.00.001,DITW110.00.10,HEI.07
    //FINXL7.00.001 RBE 20/03/2013 : Item description extend from 30 -> 80 chars
    //MANXL7.00.001 DAT 26/02/2014 #8: Calculate Simplified Plan
    //MANXL7.00.001 DAT 05/03/2014 #17: Added fields "Blanket Order No.","Blanket Order Line No."
    //FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."
    //DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    //DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    //DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new fields 2014080..2014092
    //HEI.01 FDD-PRDGAP061 - Planning nonBOM items v0.2,  IBM.NAIKH01 - 08.01.2019
    //# Added New Fields "SRM Contract No." and "SRM Contract Line No."
    //# Added code on the field "Blanket Order No." - OnLookup
    //# Created a new function "GetBlanketOrderNoOnLookUp"
    //HEI.02 CHG2119830 IBM NANDIS01 25.04.2022 Implement S&OP Core Purchase Requisition Interface
    //# Location code and UOM Filter added to open contract page
    //# Direct unit cost and location will be fetched from contract
    //HEI.03 CHG2119830 IBM NANDIS01 17.06.2022 Implement S&OP Core Purchase Requisition Interface
    //# Direct unit cost will be fetched from contract at time of changing contract no
    //HEI.04 CHG2119830 IBM NANDIS01 27.06.2022 Implement S&OP Core Purchase Requisition Interface
    //# Direct unit cost calucation was coming wrong due to blank value of currency code
    //HEI.05 CHG2119830 IBM NANDIS01 09.06.2023 Implement S&OP Core Purchase Requisition Interface
    //# Vendor Name field shown after Vendor No
    //HEI.06 CHG2261624 IBM SRIVAS07 12.08.2024 # S&OP Fit import purchase requisitions-Development
    //# Code added to GetBlanketOrderNoOnLookUp()
    //HEI.07 CHG2261624 SAHAL01 14.10.2024 S&OP Fit import purchase requisitions
    //# Added Code


    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            ToolTipML = ENU = 'Specifies the name of the record.', FRA = 'Spécifie le nom de l''enregistrement.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of requisition worksheet line you are creating.', FRA = 'Spécifie le type de ligne de la demande achat que vous créez.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger account or item to be entered on the line.', FRA = 'Spécifie le numéro du compte général ou de l''article à entrer dans cette ligne.';
        }
        modify("Action Message")
        {
            ToolTipML = ENU = 'Specifies an action to take to rebalance the demand-supply situation.', FRA = 'Spécifie une action à effectuer pour rééquilibrer la situation offre/demande.';
        }
        modify("Accept Action Message")
        {
            ToolTipML = ENU = 'Specifies whether to accept the action message proposed for the line.', FRA = 'Spécifie s''il faut accepter le message d''action proposé pour la ligne.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies text that describes the entry.', FRA = 'Spécifie un texte qui décrit l''écriture.';
        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies additional text describing the entry, or a remark about the requisition worksheet line.', FRA = 'Spécifie plus de texte pour décrire l''écriture ou une remarque sur la ligne demande achat.';
        }
        modify("Transfer-from Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location that the item will be transferred from.', FRA = 'Spécifie le code du magasin à partir duquel l''article est transféré.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies a code for an inventory location where the items that are being ordered will be registered.', FRA = 'Spécifie un code pour le magasin où les articles qui sont commandés sont enregistrés.';
        }
        modify("Original Quantity")
        {
            ToolTipML = ENU = 'Specifies the quantity stated on the production or purchase order, when an action message proposes to change the quantity on an order.', FRA = 'Spécifie la quantité indiquée sur l''ordre de fabrication ou la commande achat lorsqu''un message d''action propose de modifier la quantité d''une commande.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item.', FRA = 'Spécifie le nombre d''unités de l''article.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code used to determine the unit price.', FRA = 'Spécifie le code unité de mesure à utiliser utilisé pour déterminer le prix unitaire.';
        }
        modify("Direct Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the direct unit cost of this item.', FRA = 'Spécifie le coût unitaire direct de cet article.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code for the requisition lines.', FRA = 'Spécifie le code de devise pour les lignes demande.';
        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the discount percentage used to calculate the purchase line discount.', FRA = 'Spécifie le pourcentage remise utilisé pour calculer la remise ligne achat.';
        }
        modify("Original Due Date")
        {
            ToolTipML = ENU = 'Specifies the due date stated on the production or purchase order, when an action message proposes to reschedule an order.', FRA = 'Spécifie la date d''échéance indiquée sur l''ordre de fabrication ou la commande achat lorsqu''un message d''action propose de replanifier une commande.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the date when you can expect to receive the items.', FRA = 'Spécifie la date à laquelle vous pouvez recevoir les articles.';
        }
        modify("Order Date")
        {
            ToolTipML = ENU = 'Specifies the order date that will apply to the requisition worksheet line.', FRA = 'Spécifie la date de commande qui s''applique à la ligne demande achat.';
        }
        modify("Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor who will ship the items in the purchase order.', FRA = 'Spécifie le numéro du fournisseur qui livre les articles de la commande achat.';
        }
        modify("Vendor Item No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s item number for this item.', FRA = 'Spécifie le numéro d''article du fournisseur pour cet article.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code linked to the relevant vendor''s order address.', FRA = 'Spécifie le code adresse commande lié à l''adresse de commande du fournisseur concerné.';
        }
        modify("Sell-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer for whom the purchase line items will be ordered, if the line is a drop shipment.', FRA = 'Spécifie le numéro du client pour lequel les articles de la ligne achat sont commandés si la ligne est une livraison directe.';
        }
        modify("Ship-to Code")
        {
            ToolTipML = ENU = 'Specifies the ship-to code for the customer for which the purchase line items will be ordered, if the line is a drop shipment.', FRA = 'Spécifie le code destinataire du client pour lequel les articles de la ligne achat sont commandés si la ligne est une livraison directe.';
        }
        modify("Prod. Order No.")
        {
            ToolTipML = ENU = 'Specifies a value when you calculate the production order.', FRA = 'Spécifie une valeur lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Requester ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is ordering the items on the line.', FRA = 'Spécifie l''ID de l''utilisateur qui commande les articles sur la ligne.';
        }
        modify(Confirmed)
        {
            ToolTipML = ENU = 'Specifies whether the items on the line have been approved for purchase.', FRA = 'Spécifie si les articles de la ligne ont été approuvés pour l''achat.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Ref. Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the relevant production or purchase order.', FRA = 'Indique le numéro de l''ordre de fabrication ou de la commande achat approprié.';
        }
        modify("Ref. Order Type")
        {
            ToolTipML = ENU = 'Specifies whether the order is a purchase order, a production order, or a transfer order.', FRA = 'Indique si la commande est une commande achat, un ordre de fabrication ou un ordre de transfert.';
        }
        modify("Replenishment System")
        {
            ToolTipML = ENU = 'Specifies which kind of order to use to create replenishment orders and order proposals.', FRA = 'Spécifie le type de commande à utiliser pour créer des commandes réapprovisionnement et des propositions de commandes.';
        }
        modify("Ref. Line No.")
        {
            ToolTipML = ENU = 'Specifies the number of the purchase or production order line.', FRA = 'Indique le numéro de la ligne commande achat ou de la ligne O.F.';
        }
        modify("Planning Flexibility")
        {
            ToolTipML = ENU = 'Specifies whether the supply, represented by the requisition worksheet line, is considered by the planning system, when calculating action messages.', FRA = 'Spécifie si l''approvisionnement représenté par la ligne demande achat est pris en compte par le système de planification lors du calcul des messages d''action.';
        }
        modify("Blanket Purch. Order Exists")
        {
            ToolTipML = ENU = 'Specifies if a blanket purchase order exists for the item on the requisition line.', FRA = 'Indique si une commande ouverte achat existe pour l''article sur la ligne demande achat.';
        }
        modify(Control1902759801)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify(Description2)
        {
            ToolTipML = ENU = 'Specifies an additional part of the worksheet description.', FRA = 'Spécifie un complément à la description de la feuille de calcul.';
        }
        modify("Buy-from Vendor Name")
        {
            CaptionML = ENU = 'Buy-from Vendor Name', FRA = 'Nom du fournisseur';
        }
        modify(BuyFromVendorName)
        {
            CaptionML = ENU = 'Buy-from Vendor Name', FRA = 'Nom du fournisseur';
            ToolTipML = ENU = 'Specifies the vendor according to the values in the Document No. and Document Type fields.', FRA = 'Spécifie le fournisseur selon les valeurs dans les champs N° document et Type document.';
        }
        //BC Upgrade Priya>> Drink IT
        //addafter("No.")
        //{
        //    field("Cross-Reference No.";"Cross-Reference No.")
        //    {
        //    }
        //}
        //addafter("Accept Action Message")
        //{
        //    field("Blanket Order No.";"Blanket Order No.")
        //    {
        //        Description = 'MANXL7.00.001';

        //        trigger OnLookup(Text : Text) : Boolean;
        //        begin
        //            GetBlanketOrderNoOnLookUp();  //HEI.01
        //        end;
        //    }
        //    field("Blanket Order Line No.";"Blanket Order Line No.")
        //    {
        //        BlankZero = true;
        //        Description = 'MANXL7.00.001';
        //    }
        //}
        addafter("Vendor No.")
        {
            field("Vendor Name"; Rec."Vendor Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }
        }
        //BC Upgrade Priya>> - Drink IT
        //addafter("Blanket Purch. Order Exists")
        //{
        //    field("Minimum Order Quantity"; "Minimum Order Quantity")
        //    {
        //        Visible = false;
        //    }
        //    field("Safety Stock Quantity"; "Safety Stock Quantity")
        //    {
        //        Visible = false;
        //    }
        //    field("Order Multiple"; "Order Multiple")
        //    {
        //        Visible = false;
        //    }
        //    field(Inventory; Inventory)
        //    {
        //        Visible = false;
        //    }
        //    field("Qty. on Purch. Order"; "Qty. on Purch. Order")
        //    {
        //        Visible = false;
        //    }
        //    field("Qty. on Sales Order"; "Qty. on Sales Order")
        //    {
        //        Visible = false;
        //    }
        //    field("Qty. on Assembly Order"; "Qty. on Assembly Order")
        //   {
        //        Visible = false;
        //    }
        //    field("Qty. on Asm. Component"; "Qty. on Asm. Component")
        //    {
        //        Visible = false;
        //    }
        //    field("Qty. on Job Order"; "Qty. on Job Order")
        //    {
        //        Visible = false;
        //    }
        //    field("Qty. in Transit"; "Qty. in Transit")
        //    {
        //        Visible = false;
        //    }
        //    field("Qty. on Service Order"; "Qty. on Service Order")
        //    {
        //        Visible = false;
        //    }
        //    field("Qty. on Sales Blanket Order"; "Qty. on Sales Blanket Order")
        //    {
        //        Visible = false;
        //    }
        //    field("Proposed Qty."; "Proposed Qty.")
        //    {
        //        Visible = false;
        //    }
        //    field("SRM Contract No."; "SRM Contract No.")
        //    {
        //        Editable = false;
        //    }
        //    field("SRM Contract Line No."; "SRM Contract Line No.")
        //    {
        //        Editable = false;
        //    }
        //} //BC Upgrade Priya<<  Drink IT
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View or change detailed information about the item or resource.', FRA = 'Affichez ou modifiez des informations détaillées sur l''article ou la ressource.';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by', FRA = 'Disponibilité article par';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
            ToolTipML = ENU = 'View how the actual and projected inventory level of an item will develop over time according to supply and demand events.', FRA = 'Affichez le développement du niveau de stock réel et prévisionnel d''un article dans le temps en fonction des événements de l''offre et de la demande.';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', FRA = 'Période';
            ToolTipML = ENU = 'Show the actual and projected quantity of an item over time according to a specified time interval, such as by day, week or month.', FRA = 'Affiche la quantité réelle et prévisionnelle d''un article dans le temps en fonction d''un intervalle de temps donné, par exemple par jour, par semaine ou par mois.';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant', FRA = 'Variante';
            ToolTipML = ENU = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.', FRA = 'Affichez ou modifiez les variantes article. Au lieu de créer chaque couleur pour un article en tant qu''article séparé, vous pouvez spécifier les différentes couleurs comme variantes de l''article.';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location', FRA = 'Magasin';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
            ToolTipML = ENU = 'View how the inventory level of an item develops over time according to the bill of materials level that you select.', FRA = 'Affichez la manière dont se développe le niveau de stock d''un article dans le temps en fonction du niveau de nomenclature que vous sélectionnez.';
        }
        //BC Upgrade Priya>> Timeline action is not found in Business central base page.
        //modify(Timeline)
        //{
        //    CaptionML = ENU = 'Timeline', FRA = 'Chronologie';
        //    ToolTipML = ENU = 'Get a graphical view of an item''s projected inventory based on future supply and demand events, with or without planning suggestions. The result is a graphical representation of the inventory profile.', FRA = 'Affichez une vue graphique du stock prévisionnel d''un article en fonction des prochains événements d''offre et de demande, avec ou sans propositions de planning. Le résultat est une représentation graphique du profil stock.';
        //} //BC Upgrade Priya<< Timeline action is not found in Business central base page.
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(CalculatePlan)
        {
            CaptionML = ENU = 'Calculate Plan', FRA = 'Calculer planning';
            ToolTipML = ENU = 'Use a batch job to help you calculate a supply plan for items and stockkeeping units that have the Replenishment System field set to Purchase or Transfer.', FRA = 'Utilisez un traitement par lots pour calculer un plan d''approvisionnement pour les articles et pour le point de stock dont le système réapprovisionnement est paramétré sur Achat ou sur Transfert.';
        }
        modify("Drop Shipment")
        {
            CaptionML = ENU = 'Drop Shipment', FRA = 'Livraison directe';
        }
        modify("Get &Sales Orders")
        {
            CaptionML = ENU = 'Get &Sales Orders', FRA = 'Extraire &commandes vente';
            ToolTipML = ENU = 'Copy sales lines to the requisition worksheet. You can use the batch job to create requisition worksheet proposal lines from sales lines for drop shipments or special orders.', FRA = 'Copiez les lignes vente dans une demande achat. Vous pouvez utiliser le traitement par lots pour créer des lignes proposition de demande achat à partir des lignes vente pour des livraisons directes ou des commandes spéciales.';
        }
        modify("Sales &Order")
        {
            CaptionML = ENU = 'Sales &Order', FRA = 'Commande &vente';
            ToolTipML = ENU = 'Create a new sales order for an item that is shipped directly from the vendor to the customer. The Drop Shipment check box must be selected on the sales order line, and the Vendor No. field must be filled on the item card.', FRA = 'Créez une commande vente pour un article qui est livré directement du fournisseur au client. La case à cocher Livraison directe doit être sélectionnée sur la ligne commande vente et le champ N° fournisseur doit être renseigné sur la fiche article.';
        }
        modify("Special Order")
        {
            CaptionML = ENU = 'Special Order', FRA = 'Commande spéciale';
        }
        modify(Action53)
        {
            CaptionML = ENU = 'Get &Sales Orders', FRA = 'Extraire &commandes vente';
            ToolTipML = ENU = 'Copy sales lines to the requisition worksheet. You can use the batch job to create requisition worksheet proposal lines from sales lines for drop shipments or special orders.', FRA = 'Copiez les lignes vente dans une demande achat. Vous pouvez utiliser le traitement par lots pour créer des lignes proposition de demande achat à partir des lignes vente pour des livraisons directes ou des commandes spéciales.';
        }
        modify(Action75)
        {
            CaptionML = ENU = 'Sales &Order', FRA = 'Commande &vente';
            ToolTipML = ENU = 'Create a new sales order for an item that is shipped directly from the vendor to the customer. The Drop Shipment check box must be selected on the sales order line, and the Vendor No. field must be filled on the item card.', FRA = 'Créez une commande vente pour un article qui est livré directement du fournisseur au client. La case à cocher Livraison directe doit être sélectionnée sur la ligne commande vente et le champ N° fournisseur doit être renseigné sur la fiche article.';
        }
        modify(Reserve)
        {
            CaptionML = ENU = '&Reserve', FRA = '&Réserver';
            ToolTipML = ENU = 'Reserve one or more units of the item on the job planning line, either from inventory or from incoming supply.', FRA = 'Réservez une ou plusieurs unités de l''article dans la ligne planning projet, soit à partir du stock, soit à partir de l''approvisionnement entrant.';
        }
        modify(CarryOutActionMessage)
        {
            CaptionML = ENU = 'Carry &Out Action Message', FRA = '&Traiter messages d''action';
            ToolTipML = ENU = 'Use a batch job to help you create actual supply orders from the order proposals.', FRA = 'Utilisez un traitement par lots pour créer des ordres d''approvisionnement réels à partir des propositions d''ordre.';
        }
        modify("Order Tracking")
        {
            CaptionML = ENU = 'Order Tracking', FRA = 'Chaînage';
        }
        modify("Order &Tracking")
        {
            CaptionML = ENU = 'Order &Tracking', FRA = '&Chaînage';
            ToolTipML = ENU = 'Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.', FRA = 'Suit la connexion d''un approvisionnement selon sa demande correspondante. Ceci peut vous aider à trouver la demande d''origine qui a créé un ordre de production ou un bon de commande spécifique.';
        }
        modify("Inventory Availability")
        {
            CaptionML = ENU = 'Inventory Availability', FRA = 'Disponibilité articles';
            ToolTipML = ENU = 'View a list of the individual items'' inventory and much other information about them: quantity on sales order, quantity on purchase order, back orders from vendors, minimum inventory, and whether there is a reorder. The list can be used, for example, as the basis for deciding when to purchase items.', FRA = 'Affichez la liste de la quantité disponible de chacun des articles et de nombreuses autres informations les concernant : la quantité sur commande vente, la quantité sur commande achat, les commandes en attente des fournisseurs, la quantité minimum disponible, et s''il y a une recommande. Cette liste peut être utilisée, par exemple, pour décider du moment où il faut acheter des articles.';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            ToolTipML = ENU = 'View the status of the worksheet.', FRA = 'Affichez l''état de la feuille.';
        }
        modify("Inventory - Availability Plan")
        {
            CaptionML = ENU = 'Inventory - Availability Plan', FRA = 'Stocks : Échéancier des dispo.';
            ToolTipML = ENU = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.', FRA = 'Affichez la liste des quantités de chaque article présent dans les commandes client, les commandes achat et les ordres de transfert, ainsi que la quantité disponible en stock. La liste est divisée en colonnes couvrant six périodes déterminées par des dates de début et de fin, ainsi que les périodes précédentes et suivantes. Cette liste est très pratique pour prévoir les achats destinés au stock.';
        }
        modify("Inventory Order Details")
        {
            CaptionML = ENU = 'Inventory Order Details', FRA = 'Commandes vente en cours';
            ToolTipML = ENU = 'View a list of the orders that have not yet been shipped or received and the items in the orders. It shows the order number, customer''s name, shipment date, order quantity, quantity on back order, outstanding quantity and unit price, as well as possible discount percentage and amount. The quantity on back order and outstanding quantity and amount are totaled for each item. The list can be used to find out whether there are currently shipment problems or any can be expected.', FRA = 'Affichez la liste des commandes qui n''ont pas encore été livrées ni réceptionnées, ainsi que les articles commandés. Il indique le numéro de commande, le nom du client, la date d''expédition, la quantité commandée, la quantité sur commande en attente, la quantité ouverte et le prix unitaire, ainsi que le pourcentage de remise possible et son montant. La quantité sur commande en attente, la quantité ouverte et le montant sont totalisés pour chaque article. Cette liste peut être utilisée pour visualiser s''il y a des problèmes de livraison ou s''il risque d''y en avoir.';
        }
        modify("Inventory Purchase Orders")
        {
            CaptionML = ENU = 'Inventory Purchase Orders', FRA = 'Commandes achat en cours';
        }

        //BC Upgrade Priya >> Actions created by DrinkIT 
        //addafter(CalculatePlan)
        //{
        //    action("Calculate Simplified Plan")
        //    {
        //        CaptionML = ENU = 'Calculate Simplified Plan',
        //                    FRA = 'Calculer plan simplifié';
        //        Description = 'MANXL7.00.001';
        //        Ellipsis = true;
        //        Image = CalculatePlan;
        //        Promoted = true;
        //        PromotedCategory = Process;
        //        PromotedIsBig = true;

        //        trigger OnAction();
        //        var
        //            lrepCalculateSimplifiedPlan: Report "Calc. Simpl. Plan - Req. Wksh.";
        //        begin
        //            //<<MANXL7.00.001 RBE 20/03/2013
        //            lrepCalculateSimplifiedPlan.SetTemplAndWorksheet("Worksheet Template Name", "Journal Batch Name");
        //            lrepCalculateSimplifiedPlan.RUNMODAL;
        //            CLEAR(lrepCalculateSimplifiedPlan);
        //            //>>MANXL7.00.001 RBE 20/03/2013
        //        end;
        //    }
        //} //BC Upgrade Priya << DrinkIT Code
    }

    //BC Upgrade Priya << Drink IT fields are used in above function and this procedure is called on DrinkIT created field "Blanket Order No.".
    // local procedure GetBlanketOrderNoOnLookUp();
    // var
    //    PurchaseLine: Record "Purchase Line";
    //    PurchLine: Record "Purchase Line";
    //    QtyOnOrders: Decimal;
    //    tempPurchaseLine: Record "Purchase Line" temporary;
    // begin
    //    //<<HEI.01
    //    PurchaseLine.RESET;
    //    //HEI.07>>
    //    PurchaseLine.SETCURRENTKEY("Document Type", "No.", "Block Line Ordering", "Unit of Measure Code", "Location Code");
    //    //HEI.07<<
    //    PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::"Blanket Order");
    //    PurchaseLine.SETRANGE("No.", Rec."No.");
    //    PurchaseLine.SETRANGE("Block Line Ordering", PurchaseLine."Block Line Ordering"::" ");
    //    //HEI.07>>
    //    PurchaseLine.SETRANGE("Unit of Measure Code", Rec."Unit of Measure Code");
    //    PurchaseLine.SETFILTER("Location Code", '%1|%2', '', Rec."Location Code");
    //    //HEI.07<<
    //    PurchaseLine.CALCFIELDS("Valid From", "Valid To");
    //    PurchaseLine.SETFILTER("Valid From", '<=%1', Rec."Due Date");
    //    //PurchaseLine.SETFILTER("Valid To",'>=%1',"Due Date");
    //    //HEI.07>>
    //    //PurchaseLine.SETFILTER("Valid To",'>=%1|=%2',"Due Date",0D);
    //    PurchaseLine.SETFILTER("Valid To", '%1|>=%2', 0D, WORKDATE);
    //    //HEI.07<<
    //    //PurchaseLine.SETRANGE("Location Code","Location Code");  //NAIKH01 March 6th
    //    //HEI.07>>
    //    //HEI.02>>
    //    //PurchaseLine.SETFILTER("Location Code",'%1|%2',"Location Code",'');
    //    //PurchaseLine.SETRANGE("Unit of Measure Code","Unit of Measure Code");
    //    //HEI.02<<
    //    //IF PurchaseLine.findset THEN BEGIN
    //    if PurchaseLine.findset(false) then begin
    //        //HEI.07<<
    //        repeat
    //            //HEI.07>>
    //            CLEAR(QtyOnOrders);
    //            PurchLine.RESET;
    //            PurchLine.SETCURRENTKEY("Document Type", "No.", "Blanket Order No.");
    //            //HEI.07<<
    //            PurchLine.SETFILTER("Document Type", '%1|%2', PurchLine."Document Type"::Order, PurchLine."Document Type"::"Return Order");
    //            PurchLine.SETRANGE("No.", PurchaseLine."No.");
    //            PurchLine.SETRANGE("Blanket Order No.", PurchaseLine."Document No.");
    //            //HEI.07>>
    //            //IF PurchLine.findset THEN
    //            if PurchLine.findset(false) then begin
    //                //HEI.07<<
    //                repeat
    //                    if PurchLine."Document Type" = PurchLine."Document Type"::Order then
    //                        QtyOnOrders := QtyOnOrders + PurchLine."Outstanding Qty. (Base)"
    //                    else
    //                        if PurchLine."Document Type" = PurchLine."Document Type"::"Return Order" then
    //                            QtyOnOrders := QtyOnOrders - PurchLine."Outstanding Qty. (Base)"
    //                until PurchLine.NEXT = 0;
    //                //HEI.07>>
    //            end;
    //           //HEI.07<<
    //            if Rec.Quantity < (PurchaseLine."Outstanding Qty. (Base)" - QtyOnOrders) then begin
    //                tempPurchaseLine.INIT;
    //                tempPurchaseLine.COPY(PurchaseLine);
    //                tempPurchaseLine.INSERT;
    //            end;
    //        until PurchaseLine.NEXT = 0;
    //    end;
    //    if PAGE.RUNMODAL(0, tempPurchaseLine) = ACTION::LookupOK then begin
    //        "Blanket Order No." := tempPurchaseLine."Document No.";
    //        "Blanket Order Line No." := tempPurchaseLine."Line No.";
    //        //HEI.06>>
    //        //"Vendor No." := tempPurchaseLine."Buy-from Vendor No.";
    //        //"Currency Code" := tempPurchaseLine."Currency Code";//HEI.04
    //        Rec.VALIDATE("Vendor No.", tempPurchaseLine."Buy-from Vendor No.");
    //        Rec.VALIDATE("Currency Code", tempPurchaseLine."Currency Code");
    //        //HEI.06<<
    //        //HEI.02>>
    //        //HEI.03>>
    //        //"Direct Unit Cost" := tempPurchaseLine."Direct Unit Cost";
    //        UpdatePricefromBlanketOrder(Rec);
    //        //HEI.03<<
    //        //"Currency Code" := tempPurchaseLine."Currency Code";//HEI.04
    //        //HEI.02<<
    //    end;

    //    tempPurchaseLine.DELETEALL;
    //    //HEI.01>>
    // end;

    // local procedure UpdatePricefromBlanketOrder(var RequisitionLine: Record "Requisition Line");
    // var
    //    PurchaseLinePrice: Record "Purchase Line Price";
    //    Item: Record Item;
    // begin
    //    //HEI.03>>
    //    PurchaseLinePrice.RESET;
    //    PurchaseLinePrice.SETRANGE(PurchaseLinePrice."Document Type", PurchaseLinePrice."Document Type"::"Blanket Order");
    //    PurchaseLinePrice.SETRANGE("Document No.", RequisitionLine."Blanket Order No.");
    //    PurchaseLinePrice.SETRANGE("Document Line No.", RequisitionLine."Blanket Order Line No.");
    //    PurchaseLinePrice.SETFILTER("Location Code", '%1|%2', RequisitionLine."Location Code", '');
    //    PurchaseLinePrice.SETFILTER("Starting Date", '..%1', RequisitionLine."Order Date");
    //    PurchaseLinePrice.SETFILTER("Ending Date", '%1|>=%2', 0D, RequisitionLine."Order Date");
    //    PurchaseLinePrice.SETRANGE("Currency Code", RequisitionLine."Currency Code");
    //    PurchaseLinePrice.SETFILTER("Minimum Quantity", '<=%1', RequisitionLine.Quantity);
    //    PurchaseLinePrice.SETFILTER("Unit of Measure Code", '%1|%2', RequisitionLine."Unit of Measure Code", '');
    //    if PurchaseLinePrice.FINDFIRST then begin
    //        RequisitionLine."Direct Unit Cost" := PurchaseLinePrice."Direct Unit Cost";
    //    end else begin
    //        if Item.GET(RequisitionLine."No.") then begin
    //            RequisitionLine."Direct Unit Cost" := Item."Last Direct Cost";
    //        end;
    //    end;
    //    //HEI.03<<
    // end; //BC Upgrade Priya << Drink IT fields are used in above function and this procedure is called on DrinkIT created field "Blanket Order No.".

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

