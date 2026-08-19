pageextension 53033 OrderProcessorRoleCenterExt extends "Order Processor Role Center"
{
    // version NAVW110.0,MANXL7.00,TEMXL10.0,DITW110.00.08

    //     MANXL7.00.001 WSA 12/08/2014 : Added report Goods Shipped/Received not inv. , Added page Sales Order Book

    // DITW16.00.00.39 DDR 01/09/2011 DIT-715 #139 Added menus
    //                                               Home\Contacts
    // DITW16.00.00.40 DDR 17/04/2012 DIT-715 #247 Sponsoring & Events functionnality
    //                                             Added menus
    //                                               Home\Sales Return Planning
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 : Added menu Posted Documents\Invoice List
    // DITW17.10.05 MSF 14/10/2014 DIT-770 #831 Change ID of Page 2014360  to 2035418
    // DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL10.0 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 15.06.20 CHG2056363 IBM.AK, Added Page-Sales Inventory in Actions
    // HEI.02 CHG2119213 IBM BHATTA09 02.08.2021
    //   # My Item and Report Inbox removed
    //   # ListPart Page Quick Access added

    //Bc Upgrade YADAVM09 Drink it Field Commented.
    layout
    {

        //Unsupported feature: Change Name on "Control1901377608(Control 1901377608)". Please convert manually.

        modify(Control1905989608)
        {
            Visible = false;
        }
        modify(Control21)
        {
            Visible = false;
        }
        // addafter(Control4)
        // {
        //     part(Control55001; "Quick Access")
        //     {
        //     }
        // }  //Bc Upgrade YADAVM09  Only Related to one chnage request.
    }
    actions
    {

        modify(SalesOrders)
        {
            CaptionML = ENU = 'Sales Orders', FRA = 'Commandes vente';
            ToolTipML = ENU = 'Open the list of sales orders where you can sell items and services.', FRA = 'Ouvrez la liste des commandes vente où vous pouvez vendre des articles et des services.';
        }
        modify(SalesOrdersShptNotInv)
        {
            CaptionML = ENU = 'Shipped Not Invoiced', FRA = 'Livré non facturé';
            ToolTipML = ENU = 'View sales that are shipped but not yet invoiced.', FRA = 'Affichez les ventes qui sont expédiées, mais pas encore facturées.';
        }
        modify(SalesOrdersComplShtNotInv)
        {
            CaptionML = ENU = 'Completely Shipped Not Invoiced', FRA = 'Complètement livré non facturé';
            ToolTipML = ENU = 'View sales documents that are fully shipped but not fully invoiced.', FRA = 'Affichez les documents vente qui sont intégralement expédiés, mais pas totalement facturés.';
        }

        modify("Sales Quotes")
        {
            CaptionML = ENU = 'Sales Quotes', FRA = 'Devis';
            ToolTipML = ENU = 'Open the list of sales quotes where you offer items or services to customers.', FRA = 'Ouvrez la liste des devis où vous proposez des articles ou des services aux clients.';
        }
        modify("Blanket Sales Orders")
        {
            CaptionML = ENU = 'Blanket Sales Orders', FRA = 'Commandes ouvertes vente';
        }
        modify("Sales Invoices")
        {
            CaptionML = ENU = 'Sales Invoices', FRA = 'Factures vente';
            ToolTipML = ENU = 'Open the list of sales invoices where you can invoice items or services.', FRA = 'Ouvrez la liste des factures vente où vous pouvez facturer des articles ou des services.';
        }
        modify("Sales Return Orders")
        {
            CaptionML = ENU = 'Sales Return Orders', FRA = 'Retours vente';
        }
        modify("Sales Credit Memos")
        {
            CaptionML = ENU = 'Sales Credit Memos', FRA = 'Avoirs vente';
            ToolTipML = ENU = 'Open the list of sales credit memos where you can revert posted sales invoices.', FRA = 'Ouvrez la liste des avoirs vente où vous pouvez annuler les factures vente validées.';
        }
        modify(Items)
        {
            CaptionML = ENU = 'Items', FRA = 'Articles';
            ToolTipML = ENU = 'Open the list of items that you trade in.', FRA = 'Ouvrez la liste des articles que vous commercialisez.';
        }
        modify(Customers)
        {
            CaptionML = ENU = 'Customers', FRA = 'Clients';
            ToolTipML = ENU = 'Open the list of customers.', FRA = 'Ouvrez la liste des clients.';
        }
        modify("Item Journals")
        {
            CaptionML = ENU = 'Item Journals', FRA = 'Feuilles article';
            ToolTipML = ENU = 'Open a list of journals where you can adjust the physical quantity of items on inventory.', FRA = 'Ouvrez une liste de feuilles où vous pouvez ajuster la quantité physique des articles en stock.';
        }
        modify(SalesJournals)
        {
            CaptionML = ENU = 'Sales Journals', FRA = 'Feuilles vente';
            ToolTipML = ENU = 'Open the list of sales journals where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.', FRA = 'Ouvrez la liste des feuilles vente où vous pouvez valider par groupe les transactions vente vers les comptes généraux, bancaires, client, fournisseur et immobilisations.';
        }
        modify(CashReceiptJournals)
        {
            CaptionML = ENU = 'Cash Receipt Journals', FRA = 'Feuilles règlement';
            ToolTipML = ENU = 'Register received payments by applying them to the related customer, vendor, or bank ledger entries.', FRA = 'Enregistrez les paiements reçus en les lettrant avec les écritures comptables bancaires, fournisseur ou client concernées.';
        }
        modify("Posted Documents")
        {
            CaptionML = ENU = 'Posted Documents', FRA = 'Documents validés';
            ToolTipML = ENU = 'View history for sales, shipments, and inventory.', FRA = 'Affichez l''historique des ventes, des expéditions et du stock.';
        }
        modify("Posted Sales Shipments")
        {
            CaptionML = ENU = 'Posted Sales Shipments', FRA = 'Expéditions vente enregistrées';
            ToolTipML = ENU = 'View the posted sales shipments.', FRA = 'Affichez les expéditions vente validées.';
        }
        modify("Posted Sales Invoices")
        {
            CaptionML = ENU = 'Posted Sales Invoices', FRA = 'Factures vente enregistrées';
            ToolTipML = ENU = 'View the posted sales invoices.', FRA = 'Affichez les factures vente validées.';
        }
        modify("Posted Return Receipts")
        {
            CaptionML = ENU = 'Posted Return Receipts', FRA = 'Réceptions retour enregistrées';
        }
        modify("Posted Sales Credit Memos")
        {
            CaptionML = ENU = 'Posted Sales Credit Memos', FRA = 'Avoirs vente enregistrés';
            ToolTipML = ENU = 'View the posted sales credit memos.', FRA = 'Affichez les avoirs vente validés.';
        }
        modify("Posted Purchase Receipts")
        {
            CaptionML = ENU = 'Posted Purchase Receipts', FRA = 'Réceptions achat enregistrées';
        }
        modify("Posted Purchase Invoices")
        {
            CaptionML = ENU = 'Posted Purchase Invoices', FRA = 'Factures achat enregistrées';
            ToolTipML = ENU = 'View the posted purchase invoices.', FRA = 'Affichez les factures achat enregistrées.';
        }

        modify("Sales &Quote")
        {
            CaptionML = ENU = 'Sales &Quote', FRA = '&Devis';
            ToolTipML = ENU = 'Offer items or services to a customer.', FRA = 'Proposez des articles ou des services à un client.';
        }
        modify("Sales &Invoice")
        {
            CaptionML = ENU = 'Sales &Invoice', FRA = 'Fac&ture vente';
            ToolTipML = ENU = 'Create a new invoice for items or services. Invoice quantities cannot be posted partially.', FRA = 'Créez une facture pour des articles ou des services. Il est impossible de valider partiellement les quantités facturées.';
        }
        modify("Sales &Order")
        {
            CaptionML = ENU = 'Sales &Order', FRA = '&Commande vente';
            ToolTipML = ENU = 'Create a new sales order for items or services that require partial posting.', FRA = 'Créez une commande vente pour les articles ou les services nécessitant une validation partielle.';
        }
        modify("Sales &Return Order")
        {
            CaptionML = ENU = 'Sales &Return Order', FRA = '&Retour vente';
        }
        modify("Sales &Credit Memo")
        {
            CaptionML = ENU = 'Sales &Credit Memo', FRA = '&Avoir vente';
            ToolTipML = ENU = 'Create a new sales credit memo to revert a posted sales invoice.', FRA = 'Créez un avoir vente pour annuler une facture vente validée.';
        }
        modify(Tasks)
        {
            CaptionML = ENU = 'Tasks', FRA = 'Tâches';
        }
        modify("Sales &Journal")
        {
            CaptionML = ENU = 'Sales &Journal', FRA = 'Feuille ven&te';
            ToolTipML = ENU = 'Open a sales journal where you can batch post sales transactions to G/L, bank, customer, vendor and fixed assets accounts.', FRA = 'Ouvrez une feuille vente où vous pouvez valider par groupe les transactions vente vers les comptes généraux, bancaires, client, fournisseur et immobilisations.';
        }
        modify("Sales Price &Worksheet")
        {
            CaptionML = ENU = 'Sales Price &Worksheet', FRA = 'Feuille pri&x vente';
        }

        modify("&Prices")
        {
            CaptionML = ENU = '&Prices', FRA = 'Pri&x';
            ToolTipML = ENU = 'Set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Paramétrez des prix différents pour les articles que vous vendez au client. Un prix article est automatiquement affecté sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        }
        modify("&Line Discounts")
        {
            CaptionML = ENU = '&Line Discounts', FRA = '&Remises ligne';
            ToolTipML = ENU = 'Set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Paramétrez des remises différentes pour les articles que vous vendez au client. Une remise article est automatiquement affectée sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        }
        modify(Reports)
        {
            CaptionML = ENU = 'Reports', FRA = 'États';
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
        }
        modify("Customer - &Order Summary")
        {
            CaptionML = ENU = 'Customer - &Order Summary', FRA = 'Clients : &Liste des commandes';
            ToolTipML = ENU = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.', FRA = 'Affichez la quantité pas encore expédiée pour chaque client sur 3 périodes de 30 jours, chacune commençant à une date sélectionnée. Il contient également des colonnes avec les commandes à livrer avant et après les 3 périodes et une colonne avec le détail de la commande totale de chaque client. Cet état sert à analyser le volume de vente attendu d''une société.';
        }
        modify("Customer - &Top 10 List")
        {
            CaptionML = ENU = 'Customer - &Top 10 List', FRA = 'Clien&ts : Palmarès';
            ToolTipML = ENU = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.', FRA = 'Affichez les clients qui achètent le plus ou qui doivent le plus d''argent au cours d''une période sélectionnée. Seuls les clients qui ont des achats pour cette période ou un solde à la fin de la période seront inclus.';
        }
        modify("Customer/&Item Sales")
        {
            CaptionML = ENU = 'Customer/&Item Sales', FRA = 'Client/&Ventes d''articles';
            ToolTipML = ENU = 'View a list of item sales for each customer during a selected time period. The report contains information on quantity, sales amount, profit, and possible discounts. It can be used, for example, to analyze a company''s customer groups.', FRA = 'Affichez une liste des ventes article de chaque client pendant la période choisie. L''état donne des informations sur la quantité, le montant des ventes, la marge et les remises possibles. Il peut servir, par exemple, à l''analyse des groupes clients d''une société.';
        }

        modify("Salesperson - Sales &Statistics")
        {
            CaptionML = ENU = 'Salesperson - Sales &Statistics', FRA = 'Vendeurs : &Statistiques ventes';
            ToolTipML = ENU = 'View amounts for sales, profit, invoice discount, and payment discount, as well as profit percentage, for each salesperson for a selected period. The report also shows the adjusted profit and adjusted profit percentage, which reflect any changes to the original costs of the items in the sales.', FRA = 'Affichez les montants des ventes, de la marge, de la remise facture et de l''escompte, ainsi que le pourcentage marge sur vente, pour chaque vendeur et pour la période sélectionnée. L''état indique également le profit ajusté et le pourcentage marge ajustée, qui reflètent tous les changements des coûts d''origine des articles des ventes.';
        }
        modify("Price &List")
        {
            CaptionML = ENU = 'Price &List', FRA = '&Liste des prix';
            ToolTipML = ENU = 'View a list of your items and their prices, for example, to send to customers. You can create the list for specific customers, campaigns, currencies, or other criteria.', FRA = 'Affichez une liste de vos articles ainsi que leur prix à envoyer, par exemple, aux clients. Vous pouvez créer la liste pour des clients, des campagnes ou des devises spécifiques ou encore pour d''autres critères.';
        }
        modify("Inventory - Sales &Back Orders")
        {
            CaptionML = ENU = 'Inventory - Sales &Back Orders', FRA = 'Stocks : Commandes &à livrer';
            ToolTipML = ENU = 'View a list with the order lines whose shipment date has been exceeded. The following information is shown for the individual orders for each item: number, customer name, customer''s telephone number, shipment date, order quantity and quantity on back order. The report also shows whether there are other items for the customer on back order.', FRA = 'Affichez une liste qui comprend les lignes commande dont la date d''expédition est dépassée. Les informations suivantes sont données pour chaque article d''une commande : numéro, nom du client, numéro de téléphone du client, date d''expédition, quantité commandée et quantité sur commande en attente. L''état indique aussi s''il y a d''autres articles en commande en attente pour le client.';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("Navi&gate")
        {
            CaptionML = ENU = 'Navi&gate', FRA = 'Navi&guer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
        addafter(CashReceiptJournals)
        {
            action(Contacts)
            {
                CaptionML = ENU = 'Contacts',
                            FRA = 'Contacts';
                Description = 'DIT-715 #139';
                ApplicationArea = All; //Bc Upgrade YADAVM09<<
                RunObject = Page "Contact List";
            }
        }
        // addafter("Posted Purchase Invoices")
        // {
        //     action("Invoice List")
        //     {
        //         CaptionML = ENU='Invoice List',
        //                     FRA='Liste des factures';
        //         Description = 'DITW17.10.05  #761';
        //         RunObject = Page "Invoice List";
        //     }
        // } //Bc Upgrade YADAVM09 Drink it Object<<
        addafter("Sales &Order")
        {
            action(" SKU Sales Inventory")
            {
                ApplicationArea = Basic, Suite;
                Caption = '" SKU Sales Inventory"';
                Description = 'HEI.01';
                Image = Item;
                RunObject = Page "SKU Sales Inventory CBN";
                ToolTip = '" SKU Sales Inventory"';
            }
            // action("Sales Order Book")
            // {
            //     CaptionML = ENU='Sales Order Book',
            //                 FRA='Liste d''ordres de vente';
            //     Description = 'MANXL7.00.001';
            //     RunObject = Page "Sales Order Book";
            // } //Bc Upgrade YADAVM09 Drink it page<<
        }
        // addafter("Inventory - Sales &Back Orders")
        // {
        //     action("Goods Shipped/Received Not Invoiced")
        //     {
        //         CaptionML = ENU = 'Goods Shipped/Received Not Invoiced',
        //                     FRA = 'Marchandises expédiées / reçus pas facturés';
        //         Description = 'MANXL7.00.001';
        //         Image = Report2;
        //         RunObject = Report "Goods received/shipm. not inv.";
        //     }
        // } //Bc Upgrade YADAVM09 Drink it report<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

