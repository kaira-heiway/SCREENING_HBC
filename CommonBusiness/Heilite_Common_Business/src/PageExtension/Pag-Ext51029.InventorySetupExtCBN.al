pageextension 51029 InventorySetupExtCBN extends "Inventory Setup"
{
    // version NAVW110.0,FINXL10.01,DITW110.00.11,HEI.16

    // BC Upgrade MISHRS14 >>
    // Blocked OptionCaptionML line in - modify(Average Cost Calc. Type) as its enum so OptionCaptionML not required.
    // Blocked OptionCaptionML line in - modify(Average Cost Period) as its enum so OptionCaptionML not required.
    // BC Upgrade MISHRS14 <<

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Automatic Cost Posting")
        {
            ToolTipML = ENU = 'Specifies that the Automatic Cost Posting function is used.', FRA = 'Spécifie que la fonction Compta. coûts automatique est utilisée.';
        }
        modify("Expected Cost Posting to G/L")
        {
            ToolTipML = ENU = 'Specifies the ability to post expected costs to interim accounts in the general ledger.', FRA = 'Indique qu''il est possible de valider des coûts prévus sur des états intermédiaires dans la comptabilité.';
        }
        modify("Automatic Cost Adjustment")
        {
            ToolTipML = ENU = 'Specifies whether to adjust for any cost changes when you post inventory transactions.', FRA = 'Indique s''il faut ajuster toute modification de coûts quand vous validez des mouvements de stock.';
        }
        modify("Average Cost Calc. Type")
        {
            ToolTipML = ENU = 'Specifies information about the method that the program uses to calculate average cost.', FRA = 'Spécifie les informations sur la méthode que le programme utilise pour calculer le coût moyen.';

            // BC Upgrade MISHRS14 >>
            // Blocked below line as modify(Average Cost Calc. Type) is enum so OptionCaptionML not required.
            //OptionCaptionML = ENU = ',Item,Item & Location & Variant', FRA = ',Article,Article & Magasin & Variante';
            // BC Upgrade MISHRS14 <<

        }
        modify("Average Cost Period")
        {
            ToolTipML = ENU = 'Specifies the period of time used to calculate the weighted average cost of items that apply the average costing method.', FRA = 'Spécifie la période utilisée pour calculer le coût moyen pondéré des articles qui appliquent la méthode évaluation stock moyen.';

            // BC Upgrade MISHRS14 >>
            // Blocked below line as modify(Average Cost Period) is enum so OptionCaptionML not required.
            //OptionCaptionML = ENU = ',Day,Week,Month,,,Accounting Period', FRA = ',Jour,Semaine,Mois,,,Période comptable';
            // BC Upgrade MISHRS14 <<

        }
        modify("Copy Comments Order to Shpt.")
        {
            ToolTipML = ENU = 'Specifies that you want the program to copy the comments entered on the transfer order to the transfer shipment.', FRA = 'Spécifie que vous souhaitez que le programme copie sur l''expédition transfert les commentaires saisis sur l''ordre de transfert.';
        }
        modify("Copy Comments Order to Rcpt.")
        {
            ToolTipML = ENU = 'Specifies that you want the program to copy the comments entered on the transfer order to the transfer receipt.', FRA = 'Spécifie que vous souhaitez que le programme copie sur la réception transfert les commentaires saisis sur l''ordre de transfert.';
        }
        modify("Outbound Whse. Handling Time")
        {
            ToolTipML = ENU = 'Specifies a date formula for the outbound warehouse handling time for your company in general.', FRA = 'Spécifie une formule de date pour le délai désenlogement pour l''ensemble de votre société.';
        }
        modify("Inbound Whse. Handling Time")
        {
            ToolTipML = ENU = 'Specifies a date formula for the inbound warehouse handling time for your company in general.', FRA = 'Spécifie une formule de date pour le délai enlogement pour l''ensemble de votre société.';
        }
        modify("Prevent Negative Inventory")
        {
            ToolTipML = ENU = 'Specifies if you can post transactions that will bring inventory levels below zero.', FRA = 'Indique si vous pouvez valider des transactions qui entraîneront des niveaux de stock négatifs.';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location', FRA = 'Magasin';
        }
        modify("Location Mandatory")
        {
            ToolTipML = ENU = 'Specifies whether items must have a location code in order to be posted.', FRA = 'Spécifie si les articles doivent avoir un code magasin pour pouvoir être validés.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        }
        modify("Item Group Dimension Code")
        {
            ToolTipML = ENU = 'Specifies the dimension code that you want to use for product groups in analysis reports.', FRA = 'Spécifie le code axe à utiliser pour les groupes produits dans des rapports d''analyse.';
        }
        modify(Numbering)
        {
            CaptionML = ENU = 'Numbering', FRA = 'Numérotation';
        }
        modify("Item Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to items.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros aux articles.';
        }
        modify("Nonstock Item Nos.")
        {
            CaptionML = ENU = 'Non-stock Item Nos.', FRA = 'N° article non stocké';
            ToolTipML = ENU = 'Specifies the number series that is used for nonstock items.', FRA = 'Spécifie la souche de numéros qui est utilisée pour les articles non stockés.';
        }
        modify("Transfer Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that the program uses to assign numbers to transfer orders.', FRA = 'Spécifie le code de la souche de numéros utilisé par le programme pour affecter des numéros aux ordres de transfert.';
        }
        modify("Posted Transfer Shpt. Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that the program uses to assign numbers to posted transfer shipments.', FRA = 'Spécifie le code de la souche de numéros utilisé par le programme pour affecter des numéros aux expéditions transfert validées.';
        }
        modify("Posted Transfer Rcpt. Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to posted transfer receipt documents.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros aux documents de réception transfert validés.';
        }
        modify("Inventory Put-away Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to assign numbers to inventory put-always.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros aux rangements stock.';
        }
        modify("Posted Invt. Put-away Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to assign numbers to posted inventory put-always.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros aux rangements stock validés.';
        }
        modify("Inventory Pick Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to assign numbers to inventory picks.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros aux prélèvements stock.';
        }
        modify("Posted Invt. Pick Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to assign numbers to posted inventory picks.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros aux prélèvements stock validés.';
        }
        modify("Inventory Movement Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code used to assign numbers to inventory movements.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros aux mouvements de stock.';
        }
        modify("Registered Invt. Movement Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to assign numbers to registered inventory movements.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros aux mouvements de stock enregistrés.';
        }
        modify("Internal Movement Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code used to assign numbers to internal movements.', FRA = 'Spécifie le code souche de numéros qui est utilisé pour affecter des numéros aux mouvements internes.';
        }
        // addafter("Prevent Negative Inventory")
        // {
        //     field("Allow WIP Acc. from component";"Allow WIP Acc. from component")
        //     {
        //     }
        //     field("Check Trsf.Header Dimensions";"Check Trsf.Header Dimensions")
        //     {
        //     }
        // }  // BC Upgrade NANDIS03
        addafter(Numbering)
        {
            // group("Drink-It")
            // {
            //     CaptionML = ENU = 'Drink-It',
            //                 FRA = 'Drink-It';
            //     field("Item Treeview Method"; "Item Treeview Method")
            //     {
            //     }
            //     field("Volume Unit of Measure Code"; "Volume Unit of Measure Code")
            //     {
            //     }
            //     field("DTax per Group Mandatory"; "DTax per Group Mandatory")
            //     {
            //     }
            //     field("Stockout Warning (Relation)"; "Stockout Warning (Relation)")
            //     {
            //     }
            //     field("Stockout Type (Relation)"; "Stockout Type (Relation)")
            //     {
            //     }
            //     field(Pallet; Pallet)
            //     {
            //     }
            //     field("Autom. Deposit Posting"; "Autom. Deposit Posting")
            //     {
            //     }
            //     field("Expected Deposit Posting to GL"; "Expected Deposit Posting to GL")
            //     {
            //     }
            //     field("Autoblock Item On Changes"; "Autoblock Item On Changes")
            //     {
            //     }
            //     field("Autoblock Item On  Dimension"; "Autoblock Item On  Dimension")
            //     {
            //     }
            //     field("Auto Adjust Lot Track. Qty"; "Auto Adjust Lot Track. Qty")
            //     {
            //     }
            //     field("Default Route"; "Default Route")
            //     {
            //     }
            //     field("Route Mandatory"; "Route Mandatory")
            //     {
            //     }
            //     group("AAD Documents")
            //     {
            //         CaptionML = ENU = 'AAD Documents',
            //                     FRA = 'Copies DAA';
            //         field("Def. AAD Responsible No."; "Def. AAD Responsible No.")
            //         {
            //         }
            //         field("Def. Std. Text Code (Area 23)"; "Def. Std. Text Code (Area 23)")
            //         {
            //         }
            //         field("Def. Transport Time"; "Def. Transport Time")
            //         {
            //         }
            //         field("Def. Other Details Transport"; "Def. Other Details Transport")
            //         {
            //         }
            //         field("Def. Tax Spec. Code"; "Def. Tax Spec. Code")
            //         {
            //         }
            //         field("Def. Tax Spec.2 Code"; "Def. Tax Spec.2 Code")
            //         {
            //         }
            //     }
            //     group(Transport)
            //     {
            //         CaptionML = ENU = 'Transport',
            //                     FRA = 'Transport';
            //         field("Min. Volume Warning"; "Min. Volume Warning")
            //         {
            //         }
            //         field("Min. Weight Warning"; "Min. Weight Warning")
            //         {
            //         }
            //         field("Max. Volume Warning"; "Max. Volume Warning")
            //         {
            //         }
            //         field("Max. Weight Warning"; "Max. Weight Warning")
            //         {
            //         }
            //     }
            // }  // BC Upgrade NANDIS03
            // group(Application)
            // {
            //     Caption = 'Application';
            //     field("Item Auto Dimension Code"; "Item Auto Dimension Code")
            //     {
            //     }
            // }  // BC Upgrade NANDIS03
            group("Actual Cost Calculation DTW")
            {
                field("Raw & Pack Mat Item Cat Code"; Rec."Raw Pack Mat Item Cat Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Raw and Packaging Materials Item Category Code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Raw and Packaging Materials Item Category Code field.';

                }
                field("Semi Finish Prod Item Cat Code"; Rec."SemiFinish ProdItemCatCode FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semi-finished Products Item Category Code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Semi-finished Products Item Category Code field.';

                }
                field("Finished Goods Item Cat Code"; Rec."Finished Goods ItemCatCode FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Finished Goods Item Category Code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Finished Goods Item Category Code field.';

                }
                field("Costing Method"; Rec."Costing Method FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Costing Method field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Costing Method field.';

                }
                field("Planning Unit of Measure"; Rec."Planning Unit of Measure FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planning Unit of Measure field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Planning Unit of Measure field.';

                }
                field("Adj. Cost. Error Notif. Email"; Rec."Adj. Cost. Err Notif.Email FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Adj. Cost. Error Notif. Email field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Adj. Cost. Error Notif. Email field.';

                }
            }
            group("COGS Allocation")
            {
                field("Raw Materials Item Cat. Code"; Rec."Raw Materials Item CatCode FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Raw Materials Item Category Code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Raw Materials Item Category Code field.';

                }
                field("Pack. Materials Item Cat. Code"; Rec."Pack. Material ItemCatCode FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Packaging Materials Item Category Code field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Packaging Materials Item Category Code field.';

                }
                field("COGS Costing Method"; Rec."COGS Costing Method FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Costing Method field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Costing Method field.';

                }
                field("COGS Allocation Calc. based on"; Rec."COGS Allocation Calc.based FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the COGS Allocation Calculation based on field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the COGS Allocation Calculation based on field.';

                }
                field("Fnished Pdct. produced Inv.Pos"; Rec."Finish Pdct.prod. Inv.Pos FND")
                {
                    ApplicationArea = All;  // BC Upgrade NANDIS03
                    Lookup = true;
                    ToolTip = 'Specifies the value of the Finished Products Produced - Inventory Posting Group field.';
                }
                field("pdct. Bought  Resale Inv. Pos"; Rec."pdct. BoughtResale Inv.Pos FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Products Bought for Resale Inv. Pos field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Products Bought for Resale Inv. Pos field.';

                }
            }
            group("PPV Allocation")
            {
                Caption = 'PPV Allocation';
                field("PPV Gen. Journal Template"; Rec."PPV Gen. Journal Template FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PPV Gen. Journal Template field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the PPV Gen. Journal Template field.';

                }
                field("PPV Gen. Journal Batch"; Rec."PPV Gen. Journal Batch FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PPV Gen. Journal Batch field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the PPV Gen. Journal Batch field.';

                }
                field("Exclude Inventory Value Zero"; Rec."Exclude Invent. Val. Zero FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exclude Inventory Value Zero equal True Items field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Exclude Inventory Value Zero equal True Items field.';

                }
            }
        }
        addafter("Prevent Negative Inventory")
        {
            field("Packing Property Code"; Rec."Packing Property Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packing Property Code field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Packing Property Code field.';

            }
            field("Active Best Before Date"; Rec."Active Best Before Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Activate Expiry Notification field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Activate Expiry Notification field.';

            }
            field("Prevent Phys Invt Jnl Fraction"; Rec."Prevent PhysInvt.Jnl Frac. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prevent Phys Invt Jnl Fraction field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Prevent Phys Invt Jnl Fraction field.';

            }
            field("Lots skipped"; Rec."Lots skipped FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Lots skipped field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Lots skipped field.';

            }
            field("CMG Code for Empty Bin"; Rec."CMG Code for Empty Bin FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CMG Code for Empty Bin field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the CMG Code for Empty Bin field.';

            }
            field("Activate Unit Cost Warning Msg"; Rec."Activate UnitCost Warn.Msg FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Activate Missing Unit Cost Warning Message field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Activate Missing Unit Cost Warning Message field.';

            }
            field("Exclude CMG Dimension Value"; Rec."Exclude CMG Dime. Value FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exclude CMG Dimension Value field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Exclude CMG Dimension Value field.';

            }
            field("SCRAP Jnl. Template"; Rec."SCRAP Jnl. Template FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SCRAP Jnl. Template field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the SCRAP Jnl. Template field.';

            }
            field("Activate Rev. Jnl. Error Log"; Rec."Activate Rev.Jnl.Error Log FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Activate Revaluation Jnl. Error Log field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Activate Revaluation Jnl. Error Log field.';

            }
        }
        //PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
        addlast(Numbering)
        {
            group("Quality Inspection Codes")
            {
                field("Quality On Hold"; Rec."Quality On Hold FND")
                {
                    ApplicationArea = All;
                }
                field("Quality Unrestricted"; Rec."Quality Unrestricted FND")
                {
                    ApplicationArea = All;
                }
                field("Quality Blocked"; Rec."Quality Blocked FND")
                {
                    ApplicationArea = All;
                }
            }
        }
        //PATHAA2 GAP014_DTW, IBM GAP DTW 43<<
    }
    actions
    {
        modify("Inventory Periods")
        {
            CaptionML = ENU = 'Inventory Periods', FRA = 'Périodes inventaire';
            ToolTipML = ENU = 'Set up periods in combinations with your accounting periods that define when you can post transactions that affect the value of your item inventory. When you close an inventory period, you cannot post any changes to the inventory value, either expected or actual value, before the ending date of the inventory period.', FRA = 'Paramétrez des périodes en combinaison avec vos périodes comptables qui définissent le moment où vous pouvez valider les transactions qui affectent la valeur de votre stock d''articles. Lorsque vous clôturez une période inventaire, vous ne pouvez valider aucune modification apportée à la valeur du stock (valeur escomptée ou réelle) avant la date de fin de la période inventaire.';
        }
        modify("Units of Measure")
        {
            CaptionML = ENU = 'Units of Measure', FRA = 'Unités';
            ToolTipML = ENU = 'Set up the units of measure, such as PSC or HOUR, that you can select from in the Item Units of Measure window that you access from the item card.', FRA = 'Paramétrez les unités de mesure parmi lesquelles opérer votre sélection, par exemple PIØCE ou HEURE, dans la fenêtre Unités article à laquelle vous accédez à partir de la fiche article.';
        }
        modify("Item Discount Groups")
        {
            CaptionML = ENU = 'Item Discount Groups', FRA = 'Groupes remises article';
            ToolTipML = ENU = 'Set up discount group codes that you can use as criteria when you define special discounts on a customer, vendor, or item card.', FRA = 'Paramétrez des codes groupes remises que vous pouvez utiliser comme critères lorsque vous définissez des remises spéciales sur une fiche client, fournisseur ou article.';
        }
        modify(Posting)
        {
            CaptionML = ENU = 'Posting', FRA = 'Validation';
        }
        modify("Inventory Posting Setup")
        {
            CaptionML = ENU = 'Inventory Posting Setup', FRA = 'Paramètres compta. stock';
            ToolTipML = ENU = 'Set up links between inventory posting groups, inventory locations, and general ledger accounts to define where transactions for inventory items are recorded in the general ledger.', FRA = 'Paramétrez des liens entre des groupes comptabilisation stock, des magasins et des comptes généraux afin de définir l''emplacement d''enregistrement dans la comptabilité des transactions pour les articles en stock.';
        }
        modify("Inventory Posting Groups")
        {
            CaptionML = ENU = 'Inventory Posting Groups', FRA = 'Groupes compta. stock';
            ToolTipML = ENU = 'Set up the posting groups that you assign to item cards to link business transactions made for the item with an inventory account in the general ledger to group amounts for that item type.', FRA = 'Paramétrez les groupes comptabilisation que vous affectez aux fiches articles pour lier les transactions commerciales effectuées pour l''article à un compte stock dans la comptabilité afin de regrouper les montants de ce type d''article.';
        }
        modify("Journal Templates")
        {
            CaptionML = ENU = 'Journal Templates', FRA = 'Modèles feuille';
        }
        modify("Item Journal Templates")
        {
            CaptionML = ENU = 'Item Journal Templates', FRA = 'Modèles feuille article';
            ToolTipML = ENU = 'Set up number series and reason codes in the journals that you use for inventory adjustment. By using different templates you can design windows with different layouts and you can assign trace codes, number series, and reports to each template.', FRA = 'Paramétrez des souches de numéros et des codes motif dans les feuilles que vous utilisez pour l''ajustement du stock. En utilisant différents modèles, vous pouvez créer des fenêtres d''aspects différents et vous pouvez affecter des codes suivi, des souches de numéros et des états à chaque modèle.';
        }
    }


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

