pageextension 51191 StockkeepingUnitCardExtCBN extends "Stockkeeping Unit Card"
{   // DITW18.00.06 MSF 03/02/2015 DIT-770 #1182 Added Fields : Added Fields 2014410 "Production BOM No."
    //                                                                       2014411 "Routing No."
    //                                                                       2014412 "Scrap %"
    // DITW18.00.06 MSF 16/02/2015 DIT-770 #1185 Added Action Calculate Standrad cost for Assembly & Production
    //                  20/02/2015 DIT-770 #1185 Added Field "Overhead Rate" & "Indirect Cost %"
    // DITW18.00.07 VSC 31/03/2015 DIT-770 #1668 Move Field Inventory before "Qty. on Purch. Order." Like on the item card

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 SFI 20/06/2017 BL#15657 (DIT-770 #934) Added new field "Qty. on Sales Blanket Order", "Backorder Type"
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New field
    //                                         2013637 Deposit Value
    // DITW110.00.11 VSC 26/09/2017 NRQ#30577 Merge - QXL10.01 VSC 26/09/2017 NRQ#38341 : Multisite – Quality tracking per Location

    // HEI.01 FDD–PRDGAP043 IBM LAZARE02 30.06.2017
    //   # New field Plant-Specific Material Status

    // HEI.02 FDD-OTCGAP065 IBM.HORTOC01 11.07.2017
    //   # New Field SKU Type

    // HEI.03 FDD PRDGAP038 IBM COSTES02 07.08.2017 Added new fields : Quantity Quality Hold,Quantity Unrestricted (Pass),Quantity Blocked (Fail)

    // HEI.04 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 05.09.2017
    //   # New function
    // HEI.05 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # check field RPM Solution
    // HEI.06 FDD-KDD0TC001 IBM HORTOC01 02.10.2017
    //   # check fields
    // HEI.07 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Field added: "Available Inv. (Whse)"
    // HEI.08 IBM BHATTA09 CHG2123219 21.11.2021
    //  # New Field "CCC Dimension Code" added

    //-----------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 05.12.2025 # Added code on Trigger OnQueryClosePage for HEI.06 customization.
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the item number to which the SKU applies.', FRA = 'Spécifie le numéro de l''article auquel s''applique le point de stock.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description from the Item Card.', FRA = 'Spécifie la description de la fiche article.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code (for example, the warehouse or distribution center) to which the SKU applies.', FRA = 'Spécifie le code magasin (par exemple, l''entrepôt ou le centre de distribution) auquel s''applique le point de stock.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify("Assembly BOM")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Shelf No.")
        {
            ToolTipML = ENU = 'Specifies where to find the SKU in the warehouse.', FRA = 'Spécifie où trouver le point de stock dans l''entrepôt.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the SKU card was last modified.', FRA = 'Spécifie la date à laquelle la fiche point de stock a été modifiée pour la dernière fois.';
        }
        modify("Qty. on Purch. Order")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Qty. on Prod. Order")
        {
            ToolTipML = ENU = 'Specifies how many item units have been planned for production, which is how many units are on outstanding production order lines.', FRA = 'Spécifie le nombre d''unités article ayant été planifiées pour la production, c''est-à-dire le nombre d''unités en attente sur des lignes d''ordres de fabrication.';
        }
        modify("Qty. in Transit")
        {
            ToolTipML = ENU = 'Specifies the quantity of the SKUs in transit. These items have been shipped, but not yet received.', FRA = 'Spécifie la quantité de points de stock en transit. Ces articles ont été expédiés mais pas encore réceptionnés.';
        }
        modify("Qty. on Component Lines")
        {
            ToolTipML = ENU = 'Specifies how many item units are needed for production, which is how many units remain on outstanding production order component lists.', FRA = 'Spécifie le nombre d''unités article nécessaires à la fabrication, c''est-à-dire le nombre d''unités en attente sur des listes composant O.F. ouvertes.';
        }
        modify("Qty. on Sales Order")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Qty. on Service Order")
        {
            ToolTipML = ENU = 'Specifies how many item units are reserved for service orders, which is how many units are listed on outstanding service order lines.', FRA = 'Spécifie le nombre d''unités article réservées pour des commandes service, c''est-à-dire le nombre d''unités qui sont répertoriées sur des lignes commande service en attente.';
        }
        modify(Inventory)
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Qty. on Job Order")
        {
            ToolTipML = ENU = 'Specifies how many units of the item are allocated to jobs, meaning listed on outstanding job planning lines.', FRA = 'Spécifie le nombre d''unités de l''article alloué aux projets, à savoir mentionné sur des lignes planning projet ouvertes.';
        }
        modify("Qty. on Assembly Order")
        {
            ToolTipML = ENU = 'Specifies how many units of the SKU are allocated to assembly orders, which is how many are listed on outstanding assembly order headers.', FRA = 'Spécifie le nombre d''unités du point de stock qui sont affectées aux ordres d''assemblage, à savoir le nombre répertorié dans les en-têtes ordre d''assemblage en attente.';
        }
        modify("Qty. on Asm. Component")
        {
            ToolTipML = ENU = 'Specifies how many item units are allocated as assembly components, which is how many units are on outstanding assembly order lines.', FRA = 'Spécifie le nombre d''unités article allouées en tant que composants d''assemblage, à savoir le nombre d''unités répertoriées dans les lignes ordre d''assemblage en attente.';
        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }
        modify("Standard Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost that is used as standard cost for this SKU.', FRA = 'Spécifie le coût unitaire utilisé comme coût standard pour ce point de stock.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the cost per unit of this SKU.', FRA = 'Spécifie le coût par unité de ce point de stock.';
        }
        modify("Last Direct Cost")
        {
            ToolTipML = ENU = 'Specifies the most recent direct unit cost that was paid for the SKUs.', FRA = 'Indique le dernier coût direct payé pour les points de stock.';
        }
        modify(Replenishment)
        {
            CaptionML = ENU = 'Replenishment', FRA = 'Réapprovisionnement';
        }
        modify("Replenishment System")
        {
            ToolTipML = ENU = 'Specifies the type of supply order that is created by the planning system when the SKU needs to be replenished.', FRA = 'Spécifie le type de commande approvisionnement créée par le système de planification lorsque le point de stock doit être réapprovisionné.';
        }
        modify("Lead Time Calculation")
        {
            ToolTipML = ENU = 'Specifies a date formula for the amount of time it takes to replenish the item.', FRA = 'Spécifie une formule date pour le délai nécessaire au réapprovisionnement de l''article.';
        }
        modify(Purchase)
        {
            CaptionML = ENU = 'Purchase', FRA = 'Achat';
        }
        modify("Vendor No.")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Vendor Item No.")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify(Transfer)
        {
            CaptionML = ENU = 'Transfer', FRA = 'Transfert';
        }
        modify("Transfer-from Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location from which you usually receive transfer items.', FRA = 'Indique le code du magasin duquel vous recevez les articles de transfert.';
        }
        modify(Production)
        {
            CaptionML = ENU = 'Production', FRA = 'Fabrication';
        }
        modify("Manufacturing Policy")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Flushing Method")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Components at Location")
        {
            ToolTipML = ENU = 'Specifies the inventory location from where the production order components are to be taken when producing this SKU.', FRA = 'Spécifie l''emplacement du stock à partir duquel les composants d''ordres de fabrication doivent être utilisés lors de la fabrication de ce point de stock.';
        }
        modify("Lot Size")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify(Assembly)
        {
            CaptionML = ENU = 'Assembly', FRA = 'Assemblage';
        }
        modify("Assembly Policy")
        {
            ToolTipML = ENU = 'Specifies which default order flow is used to supply this SKU by assembly.', FRA = 'Spécifie le flux de commandes par défaut utilisé pour fournir ce point de stock par assemblage.';
        }
        modify(Planning)
        {
            CaptionML = ENU = 'Planning', FRA = 'Planning';
        }
        modify("Reordering Policy")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Dampener Period")
        {
            ToolTipML = ENU = 'Specifies a period of time during which you do not want the planning system to propose to reschedule existing supply orders forward.', FRA = 'Spécifie la période pendant laquelle vous ne souhaitez pas que le système de planification propose de replanifier les commandes approvisionnement existantes en aval.';
        }
        modify("Dampener Quantity")
        {
            ToolTipML = ENU = 'Defines a dampener quantity to block insignificant change suggestions, if the quantity by which the supply would change is lower than the dampener quantity.', FRA = 'Définit une quantité tampon pour bloquer les propositions de modification non significatives, si la quantité en fonction de laquelle l''approvisionnement change est inférieure à la quantité tampon.';
        }
        modify("Safety Lead Time")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Safety Stock Quantity")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Lot-for-Lot Parameters")
        {
            CaptionML = ENU = 'Lot-for-Lot Parameters', FRA = 'Paramètres Lot pour lot';
        }
        modify("Include Inventory")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Lot Accumulation Period")
        {
            ToolTipML = ENU = 'Defines a period in which multiple demands are accumulated into one supply order, when you use the Lot-for-Lot reordering policy.', FRA = 'Définit une période pendant laquelle plusieurs demandes sont cumulées en une commande d''approvisionnement, lorsque vous utilisez la méthode de réapprovisionnement Lot pour lot.';
        }
        modify("Rescheduling Period")
        {
            ToolTipML = ENU = 'Defines a period within which any suggestion to change a supply date always consists of a Reschedule action and never a Cancel + New action.', FRA = 'Définit une période pendant laquelle toute suggestion visant à modifier une date d''approvisionnement est toujours constituée d''une action Replanifier et jamais d''une action Annuler + Nouveau.';
        }
        modify("Reorder-Point Parameters")
        {
            CaptionML = ENU = 'Reorder-Point Parameters', FRA = 'Paramètres Point de commande';
        }
        modify("Reorder Point")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Reorder Quantity")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Maximum Inventory")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Overflow Level")
        {
            ToolTipML = ENU = 'Specifies a quantity you allow projected inventory to exceed the reorder point before the system suggests to decrease existing supply orders.', FRA = 'Spécifie une quantité que vous autorisez le stock prévisionnel à dépasser dans le point de commande avant que le système suggère de limiter les commandes approvisionnement existantes.';
        }
        modify("Time Bucket")
        {
            ToolTipML = ENU = 'Specifies a time period for the recurring planning horizon of the SKU when you use Fixed Reorder Qty. or Maximum Qty. reordering policies.', FRA = 'Spécifie une période de temps pour l''horizon de planification récurrent du point de stock lorsque vous utilisez la méthode de réapprovisionnement Qté fixe de commande. ou Qté maximum.';
        }
        modify("Order Modifiers")
        {
            CaptionML = ENU = 'Order Modifiers', FRA = 'Modificateur ordre';
        }
        modify("Minimum Order Quantity")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Maximum Order Quantity")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        modify("Order Multiple")
        {
            ToolTipML = ENU = 'Specifies for the SKU, the same as the field does on the item card.', FRA = 'Spécifie le point de stock, le même que celui indiqué par le champ sur la feuille article.';
        }
        //modify(Warehouse)//BC Upgrade KAPOOV01
        modify(Control1907509201)//BC Upgrade KAPOOV01
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Special Equipment Code")
        {
            ToolTipML = ENU = 'Specifies the code of the equipment that you need to use when working with the SKU.', FRA = 'Indique le code équipement que vous devez utiliser lorsque vous travaillez avec le point de stock.';
        }
        modify("Put-away Template Code")
        {
            ToolTipML = ENU = 'Specifies the put-away template that the program uses when it performs a put-away for the SKU.', FRA = 'Indique le modèle rangement utilisé par le programme lorsqu''il effectue un rangement pour le point de stock.';
        }
        modify("Put-away Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the code of the unit of measure that the program uses when it performs a put-away for the SKU.', FRA = 'Indique le code de l''unité employée par le programme pour effectuer un rangement pour le point de stock.';
        }
        modify("Phys Invt Counting Period Code")
        {
            ToolTipML = ENU = 'Specifies the code of the counting period that indicates how often you want to count the SKU in a physical inventory.', FRA = 'Spécifie le code de la période d''inventaire qui indique la fréquence d''inventaire du point de stock lors d''un inventaire physique.';
        }
        modify("Last Phys. Invt. Date")
        {
            ToolTipML = ENU = 'Specifies the date on which you last posted the results of a physical inventory for the SKU to the item ledger.', FRA = 'Spécifie la date de la dernière validation des résultats de l''inventaire physique d''un point de stock dans l''écriture article.';
        }
        modify("Last Counting Period Update")
        {
            ToolTipML = ENU = 'Specifies the last date on which you calculated the counting period.', FRA = 'Spécifie la dernière date à laquelle vous avez calculé la période d''inventaire.';
        }
        modify("Use Cross-Docking")
        {
            ToolTipML = ENU = 'Specifies if the SKU can be cross-docked.', FRA = 'Spécifie si ce point de stock peut être transbordé.';
        }
        addafter("Variant Code")
        {
            field("Plant-Specific Material Status"; Rec."Plant Spec.Material Status FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Plant-Specific Material Status field.';
                // BC Upgrade KAPOOV01                ToolTip = 'Specifies the value of the Plant-Specific Material Status field.';

            }
        }
        addafter("Assembly BOM")
        {
            field("SKU Type"; Rec."SKU Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subtype Code field.';
                // BC Upgrade KAPOOV01                ToolTip = 'Specifies the value of the Subtype Code field.';

            }
        }

        //BC Upgrade GUNREM01 >> added DIT Field 
        addafter("Last Date Modified")
        {
            field(Blocked; Rec."Blocked FND")
            {
                ApplicationArea = all;
            }
        }//BC Upgrade GUNREM01 << added DIT Field 
         //PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
        addafter(Blocked)
        {
            field("Quality Standard No."; Rec."Quality Standard No. FND")
            {
                ApplicationArea = All;
            }
            field("Quarantine Posting Policy"; Rec."Quarantine Posting Policy FND")
            {
                ApplicationArea = All;
            }

        }
        //PATHAA02 GAP014_DTW, IBM GAP DTW 43<<
        addafter(Inventory)
        {
            field("Available Inv. (Whse)"; Rec."Available Inv. (Whse) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';
                // BC Upgrade KAPOOV01                ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';

            }
        }
        addafter("Qty. on Asm. Component")
        {
            // field("Qty. on Sales Blanket Order"; "Qty. on Sales Blanket Order")
            // {
            // }//BC Upgrade KAPOOV01 Drink-it
            field("Quantity Quality Hold"; Rec."Quantity Quality Hold FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Quality Hold (Quarantine) field.';
                // BC Upgrade KAPOOV01                                                                                                                                                                      ToolTip = 'Specifies the value of the Quantity Quality Hold (Quarantine) field.';

            }
            field("Quantity Unrestricted (Pass)"; Rec."Quantity Unrestricted Pass FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Unrestricted (Pass) field.';
                // BC Upgrade KAPOOV01                ToolTip = 'Specifies the value of the Quantity Unrestricted (Pass) field.';

            }
            field("Quantity Blocked (Fail)"; Rec."Quantity Blocked (Fail) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity Blocked (Fail) field.';
                // BC Upgrade KAPOOV01                ToolTip = 'Specifies the value of the Quantity Blocked (Fail) field.';

            }
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Type field.';
                // BC Upgrade KAPOOV01                ToolTip = 'Specifies the value of the Item Type field.';

            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Solution field.';
                // BC Upgrade KAPOOV01                ToolTip = 'Specifies the value of the RPM Solution field.';

            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RPM Type field.';
                // BC Upgrade KAPOOV01                ToolTip = 'Specifies the value of the RPM Type field.';

            }
            field("CCC Dim. Code"; Rec."CCC Dim. Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CCC Dim. Code field.';
                // BC Upgrade KAPOOV01                ToolTip = 'Specifies the value of the CCC Dim. Code field.';

            }
        }
        //BC Upgrade KAPOOV01 Drink-it<<
        // addafter("Last Direct Cost")
        // {
        //     field("Overhead Rate"; "Overhead Rate")
        //     {
        //     }
        //     field("Indirect Cost %"; "Indirect Cost %")
        //     {
        //     }
        // }
        // addafter("Lot Size")
        // {
        //     field("Routing No."; "Routing No.")
        //     {
        //     }
        //     field("Production BOM No."; "Production BOM No.")
        //     {
        //     }
        //     field("Scrap %"; "Scrap %")
        //     {
        //     }
        // }
        // addafter(Warehouse)
        // {
        //     group(Quality)
        //     {
        //         Caption = 'Quality';
        //         Description = 'QXL10.01 NRQ#38341';
        //         field("Quality Standard No."; "Quality Standard No.")
        //         {
        //             Description = 'QXL10.01 NRQ#38341';
        //         }
        //         field("Quarantine Posting Policy"; "Quarantine Posting Policy")
        //         {
        //             Description = 'QXL10.01 NRQ#38341';
        //         }
        //     }
        //     group("Drink-IT")
        //     {
        //         Caption = 'Drink-IT';
        //         Description = 'DITW110.00.10 BL#15657';
        //         field("Backorder Type"; "Backorder Type")
        //         {
        //             Caption = 'Backorder Type';
        //         }
        //         field("Deposit Value"; "Deposit Value")
        //         {
        //         }
        //     }
        // }//BC Upgrade KAPOOV01 Drink-it
        moveafter("Last Date Modified"; Inventory)
    }
    actions
    {
        modify("&Item")
        {
            CaptionML = ENU = '&Item', FRA = 'Arti&cle';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify(Action89)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("&Picture")
        {
            CaptionML = ENU = '&Picture', FRA = '&Image';
        }
        modify("&Units of Measure")
        {
            CaptionML = ENU = '&Units of Measure', FRA = '&Unités';
        }
        modify("Va&riants")
        {
            CaptionML = ENU = 'Va&riants', FRA = '&Variantes';
        }
        modify(Translations)
        {
            CaptionML = ENU = 'Translations', FRA = 'Traductions';
        }
        modify("E&xtended Texts")
        {
            CaptionML = ENU = 'E&xtended Texts', FRA = 'Te&xtes étendus';
        }
        modify("&SKU")
        {
            CaptionML = ENU = '&SKU', FRA = '&Pt de stock';
        }
        //modify(ActionGroup92)//BC Upgrade KAPOOV01
        modify(Action92)//BC Upgrade KAPOOV01
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Entry Statistics")
        {
            CaptionML = ENU = 'Entry Statistics', FRA = 'Statistiques écritures';
        }
        modify("T&urnover")
        {
            CaptionML = ENU = 'T&urnover', FRA = '&Rotation';
        }
        modify("&Item Availability by")
        {
            CaptionML = ENU = '&Item Availability by', FRA = '&Disponibilité article par';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', FRA = 'Période';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
        }
        // modify(Timeline)
        // {
        //     CaptionML = ENU = 'Timeline', FRA = 'Chronologie';
        // }//BC Upgrade KAPOOV01 Action-Timeline not found in base page.
        modify(Action124)
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("E&ntries")
        {
            CaptionML = ENU = 'E&ntries', FRA = 'É&critures';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
        }
        modify("&Reservation Entries")
        {
            CaptionML = ENU = '&Reservation Entries', FRA = 'Écritures &réservation';
        }
        modify("&Phys. Inventory Ledger Entries")
        {
            CaptionML = ENU = '&Phys. Inventory Ledger Entries', FRA = 'Écritures comptables &inventaire';
        }
        modify("&Value Entries")
        {
            CaptionML = ENU = '&Value Entries', FRA = 'Écritures &valeur';
        }
        modify("Item &Tracking Entries")
        {
            CaptionML = ENU = 'Item &Tracking Entries', FRA = 'Ecritures &traçabilité';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("&Bin Contents")
        {
            CaptionML = ENU = '&Bin Contents', FRA = 'C&ontenu emplacement';
        }
        modify(New)
        {
            CaptionML = ENU = 'New', FRA = 'Nouveau';
        }
        modify(NewItem)
        {
            CaptionML = ENU = 'New Item', FRA = 'Nouvel article';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("C&alculate Counting Period")
        {
            CaptionML = ENU = 'C&alculate Counting Period', FRA = 'C&alculer période d''inventaire';
        }
        addafter(Action124)
        {
            group("Assemb&ly")
            {
                CaptionML = ENU = 'Assemb&ly',
                            FRA = 'Assemb&lage';
                Image = AssemblyBOM;
                //BC Upgrade KAPOOV01 Drink-it>>
                // action("Calc. Stan&dard Cost")
                // {
                //     CaptionML = ENU = 'Calc. Stan&dard Cost',
                //                 FRA = 'C&alculer coût standard';
                //     Image = CalculateCost;

                //     trigger OnAction();
                //     begin
                //         // << DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
                //         CLEAR(CalculateStdCost);
                //         CalculateStdCost.CalcSKU("Item No.", "Location Code", "Variant Code", true, false);
                //         // >> DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
                //     end;
                // }
                //BC Upgrade KAPOOV01 Drink-it<<
                action(Structure)
                {
                    Caption = 'Structure';
                    Image = Hierarchy;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Structure action.';


                    trigger OnAction();
                    var
                        BOMStructure: Page "BOM Structure";
                    begin
                        //HEI.05>>
                        BOMStructure.InitItemSKU(Rec);
                        BOMStructure.SetParam(true);
                        BOMStructure.RUN();
                        //HEI.05<<
                    end;
                }
            }

            //BC Upgrade KAPOOV01 Drink-it>>
            // group(Production)
            // {
            //     CaptionML = ENU = 'Production',
            //                 FRA = 'Fabrication';
            //     Image = Production;
            //     action(Action1100710003)
            //     {
            //         CaptionML = ENU = 'Calc. Stan&dard Cost',
            //                     FRA = 'C&alculer coût standard';
            //         Image = CalculateCost;

            //         trigger OnAction();
            //         begin
            //             // << DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
            //             CLEAR(CalculateStdCost);
            //             CalculateStdCost.CalcSKU("Item No.", "Location Code", "Variant Code", false, false);
            //             // >> DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
            //         end;
            //     }
            // }
            //BC Upgrade KAPOOV01 Drink-it<<
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        //HEI.06>>
        // {
        // IF ("Item No." <> '') AND ("Location Code" <> '') THEN BEGIN
        //             IF "Item Type" = "Item Type"::"RPM Related" THEN BEGIN
        //                 TESTFIELD("RPM Solution");
        //                 TESTFIELD("RPM Type");
        //             END ELSE BEGIN
        //                 TESTFIELD("RPM Solution", "RPM Solution"::" ");
        //                 TESTFIELD("RPM Type", '');
        //             END;
        //         END;
        // }
        //HEI.06<<
    end;


    var
        myInt: Integer;


    var
        CalculateStdCost: Codeunit "Calculate Standard Cost";


    //Unsupported feature: CodeInsertion on "OnQueryClosePage". Please convert manually.

    //trigger OnQueryClosePage(CloseAction : Action) : Boolean;
    //begin
    /*
    //HEI.06>>
    {
    IF ("Item No." <> '') AND ("Location Code" <> '') THEN BEGIN
      IF "Item Type" = "Item Type"::"RPM Related" THEN BEGIN
        TESTFIELD("RPM Solution");
        TESTFIELD("RPM Type");
      END ELSE BEGIN
        TESTFIELD("RPM Solution","RPM Solution"::" ");
        TESTFIELD("RPM Type",'');
      END;
    END;
    }
    //HEI.06<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

