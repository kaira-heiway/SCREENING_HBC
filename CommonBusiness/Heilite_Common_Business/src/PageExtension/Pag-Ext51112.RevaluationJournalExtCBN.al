pageextension 51112 RevaluationJournalExtCBN extends "Revaluation Journal"
{
    // version NAVW110.0,QXL9.00.001,DITW110.00.11,HEI.01
    // DITW15.00.00.24 DDR 25/09/2008 Added Drink-it Tax Item Charges functionnalities
    //                             Added columns
    //                                 "Collapse/Expand","Due Tax",
    //                                 "Line No." (not editable)
    //                                 "Item Charge No." (editale only if internal tax)
    //                                 "Amount" (not editable)
    //                             Added menus
    //                                 "Insert Item Charges" into button "Functions"
    //                                 "Exppand/Collapse" into button "Line"
    //                                 "Expand All" into button "Line"
    //                                 "Collapse" into button "Line"
    //                             Added functions
    //                                 InsertExtendedCharges()
    //                                 UpdateFields()
    //                                 DoExpandCollapse()
    //                                 DoExpandAll()
    //                                 DoCollapseAll()
    //                                 UpdateFormatField()
    //                                 UpdateExpandStatus()
    // DITW16.00.00.01 DDR 12/01/2008 Removed OnLookup trigger of "Item No."
    // DITW15.00.00.33 DDR 08/05/2009 Added field "Duty Suspended"
    // DITW15.00.00.34 DDR 15/06/2009 Changed function UpdateFormatField()
    // DITW15.00.00.35 DDR 19/09/2009 issue 775 Bugfix to create new record (lost journal template name?)
    //                 29/01/2010 issue 1054 Added fields
    //                                 "AAD No. Series","ADD No.",
    //                                 "Tariff No.","item DTax Group Code","Company Tax Registration No."
    // DITW15.00.00.37 DDR 20/05/2010 issue 1081 Added fields "Physical Location Group Code"
    //                 02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                 Added parmater et return value for function ReadExpansionStatus()
    //                                 Remove functions FormTotalingField()
    //                                 Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //             DDR 30/07/2010           Remove OnFormat() field "Item No."
    //             CEL 13/08/2010           Modification RTC buttons
    //             DDR 20/01/2011 DIT-715 #50 RTC bugfix trigger OnModifyTrigger' test to call function ActionInsertAutoBlankLine()
    // DITW15.00.00.38-PRODW14.00.00.17 DDR 14/12/2010 issue 1127 Bugfix don't show Lot column if item tracking line is not required (Produ
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                         Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                         Modified "Item Charge No." as non-editable (function UpdateFields)
    //                                         Removed/Moved CaptionML control23
    // DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50 RTC Page functionnalities
    //                                         Added/Moved OnNewRecord trigger into TriggerOnNewRecord() function
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                         Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                         Modified order position RTC buttons
    //                                             contol1102601007 RTCNewLine
    //                                             contol1102601008 RTCDeleteLine
    //                                             contol1102601009 RTCDleteAllLines
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                             Added to insert first line automatically
    //                                             Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 DDR 26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                 26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194 Bugfix to insert the first <blank> line while opening the empty journal
    //                                         Bugfix RTC to call the c/al when OpenedFromBatch variable is true
    //                 03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                         Modified OnAssistEdit trigger field "No."

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.00.02 DDR 17/12/2013 DIT-770 #214 : Stopped New Line Creation on Open Journal
    // DITW17.10.03 DDR 07/04/2014 DIT-770 #559 (old DIT-770 214) Bugfix standard Expand-Collapse (ShowAsTree property) workaround
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1189 Multisite - Added field "Responsibility Center"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Added fields Strength (Calculated.), Strength (Revalued), Unit Volume (Calculated), Unit Volume (Revalued)
    //                                     Bugfix Expand-Collapse ribbon button position
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Remove "New Volume HL (Reval)"
    // DITW19.00.08 DDR 09/12/2016 BL#10443 Added fiels "Scrap Quantity"
    // DITW19.00.08A VSC 05/01/2017 BL#10443 Remove Alcohol Balance functionality
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.11 AKH 05/10/2017 NRQ#36842 Removed field "Gen. Bus. Posting Group"
    // DITW110.00.12 MSF 04/05/2018 NRQ#55899 Resp. centre with Phys. Location group and Location code gives conflict - part 3

    // HEI.01 CHG2187702 SAHAL01 18.09.2023 Revaluation journal items in error
    // # Added New Field - Post To (Include,Skip)
    // # Added Code


    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the name of the journal batch.', FRA = 'Spécifie le nom de la feuille.';
        }

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Posting Date")
        {
            Editable = true;//BC Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the journal line.', FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille.';
        }
        modify("Document No.")
        {
            Editable = true;//BC Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number referring to the customer or vendor numbering system with whom you are trading items on this journal line.', FRA = 'Spécifie un numéro de document qui se réfère au programme de numérotation du client ou du fournisseur avec lequel vous traitez pour les articles de cette ligne feuille.';
        }
        modify("Item No.")
        {
            Editable = true;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the number of the item on the journal line.', FRA = 'Spécifie le numéro de l''article de la ligne feuille.';

            //Unsupported feature: Change Editable on ""Item No."(Control 8)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item on the journal line.', FRA = 'Spécifie une description de l''article sur la ligne feuille.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Location Code")
        {
            Editable = true;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the code for the inventory location where the item on the journal line will be registered.', FRA = 'Spécifie le code du magasin où l''article de la ligne feuille sera enregistré.';

            //Unsupported feature: Change Editable on ""Location Code"(Control 37)". Please convert manually.

        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies the code for the salesperson or purchaser who is linked to the sale or purchase on the journal line.', FRA = 'Spécifie le code du vendeur ou de l''acheteur lié à la vente ou à l''achat de la ligne feuille.';
        }
        modify(Quantity)
        {
            Editable = true;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the number of units of the item to be included on the journal line.', FRA = 'Spécifie le nombre d''unités de l''article à inclure sur la ligne feuille.';

            //Unsupported feature: Change Editable on "Quantity(Control 12)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the code if you have filled in the Sales Unit of Measure field on the item card.', FRA = 'Spécifie le code si vous avez renseigné le champ Unité de vente de la fiche article.';
        }
        modify(Amount)
        {
            Editable = true;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the line''s net amount.', FRA = 'Spécifie le montant net de la ligne.';

            //Unsupported feature: Change SourceExpr on "Amount(Control 16)". Please convert manually.


            //Unsupported feature: Change Editable on "Amount(Control 16)". Please convert manually.


            //Unsupported feature: Change Name on "Amount(Control 16)". Please convert manually.

        }
        modify("Unit Cost (Calculated)")
        {
            ToolTipML = ENU = 'Specifies the current unit cost of this item before revaluation.', FRA = 'Indique le coût unitaire actuel de cet article avant réévaluation.';
        }
        modify("Inventory Value (Calculated)")
        {
            ToolTipML = ENU = 'Specifies the calculated inventory value of the item at the specified posting date.', FRA = 'Indique la valeur stock calculée de l''article à la date comptabilisation indiquée.';
        }
        modify("Unit Cost (Revalued)")
        {
            ToolTipML = ENU = 'Specifies the revalued unit cost of this item.', FRA = 'Spécifie le coût unitaire réévalué de cet article.';
        }
        modify("Inventory Value (Revalued)")
        {
            ToolTipML = ENU = 'Specifies the new inventory value.', FRA = 'Indique la nouvelle valeur stock.';
        }
        modify("Applies-to Entry")
        {
            ToolTipML = ENU = 'Specifies if the quantity in the item journal line should be applied to an already-posted document.', FRA = 'Spécifie si la quantité dans la ligne feuille article doit être lettrée dans un document déjà validé.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code that applies to the journal line.', FRA = 'Spécifie le code pays/région qui s''applique à la ligne feuille.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that will be inserted on the journal lines.', FRA = 'Spécifie le code motif qui va être inséré dans les lignes feuille.';
        }
        modify("Item Description")
        {
            CaptionML = ENU = 'Item Description', FRA = 'Description article';
        }
        modify(ItemDescription)
        {
            ToolTipML = ENU = 'Specifies a description of the journal batch.', FRA = 'Indique une description de la feuille.';
        }

        //Unsupported feature: CodeInsertion on ""Posting Date"(Control 2)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        PostingDateOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Item No."(Control 8)". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
        if AssistEditItemTreeview("Item No.") then begin
          // validate trigger
          ItemJnlMgt.GetItem("Item No.",ItemDescription);
          ShowShortcutDimCode(ShortcutDimCode);
          // aftervalidate trigger
          CurrPage.UPDATE(true);
        end else
          CurrPage.UPDATE(false);
        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
        */
        //end;


        //Unsupported feature: CodeModification on ""Item No."(Control 8).OnValidate". Please convert manually.

        //trigger "(Control 8)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemJnlMgt.GetItem("Item No.",ItemDescription);
        ShowShortcutDimCode(ShortcutDimCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ItemJnlMgt.GetItem("Item No.",ItemDescription);
        ShowShortcutDimCode(ShortcutDimCode);
          ItemNoOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 63)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;
        // modify("Gen. Bus. Posting Group")
        // {
        //     Visible = false;
        // }


        //Unsupported feature: CodeInsertion on ""Unit of Measure Code"(Control 67)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitofMeasureCodeOnAfterValida;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit Amount"(Control 16)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitAmountOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit Cost (Revalued)"(Control 49)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitCostRevaluedOnAfterValidat;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Inventory Value (Revalued)"(Control 85)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        InventoryValueRevaluedOnAfterV;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Applies-to Entry"(Control 20)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        AppliestoEntryOnAfterValidate;
        */
        //end;
        addfirst(Control1)
        {
            // BC Upgrade Priya >> DrinkIT code and fields are commented
            // field("Has Item Charge";Rec."Has Item Charge")
            // {
            //     BlankZero = true;
            // }
            // field(Collapse;Rec.Collapse)
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(true);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }
            // BC Upgrade Priya << DrinkIT code and fields are commented
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the journal line.';
            }
        }
        addafter("Document No.")
        {
            // field("Gen. Bus. Posting Group";Rec."Gen. Bus. Posting Group")
            // {
            // }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
            }
        }
        addafter("Item No.")
        {
            field("Post To"; Rec."Post To FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Post To field.';
            }
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
            field("Item Charge No."; Rec."Item Charge No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Charge No. field.';
                // Editable = "Item Charge No.Editable";
                // Enabled = "Item Charge No.Enable";
                // Visible = false;

                // trigger OnValidate();
                // begin
                //     ItemChargeNoOnAfterValidate;
                // end;
            }
        }

        // BC Upgrade Priya >> DrinkIT code and fields are commented
        // addafter("Shortcut Dimension 2 Code")
        // {
        //     field("Responsibility Center";Rec."Responsibility Center")
        //     {
        //         Editable = true;
        //         Visible = false;
        //     }
        //     field("Physical Location Group Code";Rec."Physical Location Group Code")
        //     {
        //         Editable = true;
        //         Visible = false;
        //     }
        // }

        // addafter(Amount)
        // {
        //     field(Amount;Rec.Amount)
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field(RTCTotalLine;GetTotalingLine(1,FIELDNO(Amount),true))
        //     {
        //         AutoFormatType = 1;
        //         BlankZero = true;
        //         CaptionML = ENU='Total Amount',
        //                     FRA='Montant total';
        //         Description = 'DITW17.10.02B DIT-770 #541';
        //         Editable = false;
        //         QuickEntry = false;
        //     }
        // }

        // addafter("Inventory Value (Revalued)")
        // {
        //     field("Due Tax";Rec."Due Tax")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Duty Suspended";Rec."Duty Suspended")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Item DTax Group Code";Rec."Item DTax Group Code")
        //     {
        //         Editable = "Item DTax Group CodeEditable";
        //         Visible = false;
        //     }
        //     field("Company Tax Registration No.";Rec."Company Tax Registration No.")
        //     {
        //         Editable = CompanyTaxRegistrationNoEditab;
        //         Visible = false;
        //     }
        //     field("Tariff No.";Rec."Tariff No.")
        //     {
        //         Editable = "Tariff No.Editable";
        //         Visible = false;
        //     }
        //     field("AAD No. Series";Rec."AAD No. Series")
        //     {
        //         Editable = "AAD No. SeriesEditable";
        //         Visible = false;
        //     }
        //     field("AAD No.";Rec."AAD No.")
        //     {
        //         Editable = "AAD No.Editable";
        //         Visible = false;
        //     }
        //     field("Unit Volume HL (Calculated)";Rec."Unit Volume HL (Calculated)")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Quantity (Brewing Base) Calcd.";Rec."Quantity (Brewing Base) Calcd.")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }
        // BC Upgrade Priya << DrinkIT code and fields are commented
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("&Item")
        {
            CaptionML = ENU = '&Item', FRA = 'Arti&cle';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
            ToolTipML = ENU = 'View the item card for the item in the current journal line.', FRA = 'Affichez la fiche article pour l''article de la ligne feuille actuelle.';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';
        }
        modify("Value Entries")
        {
            CaptionML = ENU = 'Value Entries', FRA = 'Écritures valeur';
            ToolTipML = ENU = 'Show value entries for the item in the current journal line.', FRA = 'Affichez les écritures valeur pour l''article de la ligne feuille actuelle.';
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
            ToolTipML = ENU = 'Show how the inventory level of an item develops over time according to the bill of materials level that you select.', FRA = 'Affichez la manière dont se développe le niveau de stock d''un article dans le temps en fonction du niveau de nomenclature que vous sélectionnez.';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
            ToolTipML = ENU = 'View how the inventory level of an item develops over time according to the bill of materials level that you select.', FRA = 'Affichez la manière dont se développe le niveau de stock d''un article dans le temps en fonction du niveau de nomenclature que vous sélectionnez.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Calculate Inventory Value - Test")
        {
            CaptionML = ENU = 'Calculate Inventory Value - Test', FRA = 'Calculer valeur du stock - Test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify("Calculate Inventory Value")
        {
            CaptionML = ENU = 'Calculate Inventory Value', FRA = 'Calculer valeur stock';
            ToolTipML = ENU = 'Calculate the inventory value for posting date that you specify.', FRA = 'Calculez la valeur du stock pour la date comptabilisation spécifiée.';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        //Bc Upgrade Kamnay01 commented this and moved in DTW ext for FDD Revaluation Journal Error Log>>
        // modify("P&ost")
        // {
        //     CaptionML = ENU = 'P&ost', FRA = '&Valider';
        //     ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
        //     trigger OnAfterAction()
        //     var
        //         InventorySetupL: Record "Inventory Setup";
        //         RevJnlErrorLogL: Record "Revaluation Journal Error Log";
        //         HeineBCUpgrade: Codeunit "Heineken BC Upgrade";
        //     Begin
        //         //HEI.01>>
        //         IF InventorySetupL.GET() THEN BEGIN
        //             IF InventorySetupL."Activate Rev. Jnl. Error Log" THEN BEGIN
        //                 CLEARLASTERROR();
        //                 RevJnlErrorLogL.DELETEALL(FALSE);
        //                 HeineBCUpgrade.ValidateRevJnlError(Rec);// BC Upgrade Priya << Created function in 53499 codeunit.
        //             end;
        //         end;
        //     end;
        //     //HEI.01<<
        // }
        //Bc Upgrade Kamnay01 commented this and moved in DTW ext for FDD Revaluation Journal Error Log<<
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
        }
    }



    //Unsupported feature: CodeInsertion on ""P&ost"(Action 34).OnAction". Please convert manually.

    //trigger (Variable: InventorySetupL)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on ""P&ost"(Action 34).OnAction". Please convert manually.

    //trigger OnAction();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",Rec);
    CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
    CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.01>>
    if InventorySetupL.GET then begin
      if InventorySetupL."Activate Rev. Jnl. Error Log" then begin
        CLEARLASTERROR;
        RevJnlErrorLogL.DELETEALL(false);
        ItemJnlPostBatchL.ValidateRevJnlError(Rec);
      end;
    end;
    //HEI.01<<
    JnlFilterApplied.COPYFILTERS(Rec); //<<DITW17.00.02 DDR 17/12/2013 DIT-770 #214
    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",Rec);
    CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
    //<<DITW17.00.02 DDR 17/12/2013 DIT-770 #214 - DITW17.10.03 DDR 07/04/2014 DIT-770 #559
    if FINDFIRST then;
    Rec := xRec;
    //>>DITW17.00.02 DDR DIT-770 #214 - DITW17.10.03 DDR DIT-770 #559
    CurrPage.UPDATE(false);
    */
    //end;


    //Unsupported feature: CodeModification on ""Post and &Print"(Action 35).OnAction". Please convert manually.

    //trigger OnAction();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print",Rec);
    CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
    CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print",Rec);
    CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
    //<<DITW17.00.02 DDR 17/12/2013 DIT-770 #214 - DITW17.10.03 DDR 07/04/2014 DIT-770 #559
    if FINDFIRST then;
    Rec := xRec;
    //>>DITW17.00.02 DDR DIT-770 #214 - DITW17.10.03 DDR DIT-770 #559
    CurrPage.UPDATE(false);
    */
    //end;

    // BC Upgrade Priya >> DrinkIT code commented.
    // addfirst("&Line")
    // {
    //     action("New Line")
    //     {
    //         CaptionML = ENU='New Line',
    //                     FRA='Nouvelle ligne';
    //         Description = 'DITW16.00.00.37 DIT-715 #1';
    //         Image = NewDocument;
    //         ShortCutKey = 'Ctrl+F3';
    //         Visible = false;

    //         trigger OnAction();
    //         var
    //             ItemJournalLine : Record "Item Journal Line";
    //         begin

    //             // <<DITW16.00.00.37 DIT-715 #1
    //             if Rec.FINDLAST then;

    //             ItemJournalLine := Rec;

    //             Rec.INIT;
    //             Rec.SetUpNewLine(ItemJournalLine);
    //             CLEAR(ShortcutDimCode);
    //             Rec."Line No." := Rec."Line No." + 10000;
    //             Rec.INSERT;

    //             CurrPage.UPDATE(false);
    //             // >>DITW16.00.00.37 DIT-715 #1
    //         end;
    //     }
    //     separator(Separator1102601000)
    //     {
    //     }
    // }
    // BC Upgrade Priya << DrinkIT code commented.

    // BC Upgrade Priya >> DrinkIT code commented.
    // addfirst(ActionContainer1900000004)
    // {
    //     group(ActionGroup1100910011)
    //     {
    //         action("+ Expand")
    //         {
    //             CaptionML = ENU='+ Expand',
    //                         FRA='+ Développer';
    //             Enabled = (NOT ExpandLines);
    //             Image = ViewDetails;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             Visible = (NOT ExpandLines) OR ShowButtonsCE;

    //             trigger OnAction();
    //             begin
    //                 // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //                 ExpandLines := true;
    //                 CurrPage.UPDATE(true);
    //                 // >>DITW17.10.03 DDR DIT-770 #541
    //             end;
    //         }
    //         action("- Collapse")
    //         {
    //             CaptionML = ENU='- Collapse',
    //                         FRA='- Réduire';
    //             Enabled = ExpandLines;
    //             Image = ViewDetails;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             Visible = ExpandLines OR ShowButtonsCE;

    //             trigger OnAction();
    //             begin
    //                 // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //                 ExpandLines := false;
    //                 CurrPage.UPDATE(true);
    //                 // >>DITW17.10.03 DDR DIT-770 #541
    //             end;
    //         }
    //     }
    // }
    // BC Upgrade Priya << DrinkIT code commented.

    // BC Upgrade Priya >> DrinkIT code commented.
    // addafter("Calculate Inventory Value")
    // {
    //     separator(Separator1100083008)
    //     {
    //     }
    //     action("&Insert Item Charges")
    //     {
    //         CaptionML = ENU='&Insert Item Charges',
    //                     FRA='&Inserer Frais Annexes';
    //         Image = TaxSetup;
    //         ShortCutKey = 'Ctrl+Y';

    //         trigger OnAction();
    //         begin
    //             // <<DITW15.00.00.24 DDR 25/09/2008
    //             InsertExtendedCharges(true);
    //         end;
    //     }
    // }
    // BC Upgrade Priya << DrinkIT code commented.


    // var
    //     InventorySetupL: Record "Inventory Setup";
    //     RevJnlErrorLogL: Record "Revaluation Journal Error Log";
    // ItemJnlPostBatchL: Codeunit "Item Jnl.-Post Batch";


    //Unsupported feature: PropertyModification on "Text001(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=To make sure that all items are adjusted before you start the revaluation, you should run the %1 batch job first.\Do you want to continue with the revaluation?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=To make sure that all items are adjusted before you start the revaluation, you should run the %1 batch job first.\Do you want to continue with the revaluation?;FRA=Pour vous assurer que tous les articles sont ajustés avant de lancer la réévaluation, vous devez d'abord exécuter le traitement par lots %1.\Voulez-vous poursuivre la réévaluation ?;
    //Variable type has not been exported.

    // var
    //     xRecRef: RecordRef;
    //     
    //     "Item No.Editable": Boolean;
    //     
    //     "Item Charge No.Editable": Boolean;
    //     
    //     QuantityEditable: Boolean;
    //     
    //     "Unit AmountEditable": Boolean;
    //     
    //     "AAD No.Editable": Boolean;
    //     
    //     "AAD No. SeriesEditable": Boolean;
    //     
    //     "Item DTax Group CodeEditable": Boolean;
    //     
    //     CompanyTaxRegistrationNoEditab: Boolean;
    //     
    //     "Tariff No.Editable": Boolean;
    //     
    //     "Item Charge No.Enable": Boolean;
    //     JnlFilterApplied: Record "Item Journal Line";
    //     
    //     ExpandLines: Boolean;
    //     
    //     ShowButtonsCE: Boolean;
    //     IndentLine: Integer;
    //    // UserSetupMgt: Codeunit "User Setup Management";
    //     
    //     GlobalTax1ValueEditable: Boolean;
    //     
    //     GlobalTax2ValueEditable: Boolean;
    // //QualitySetup : Record "Quality Setup"; // BC Upgrade Priya << DrinkIT code commented.
    //QualityManagement : Codeunit "Quality Management"; // BC Upgrade Priya << DrinkIT code commented.


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemJnlMgt.GetItem("Item No.",ItemDescription);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemJnlMgt.GetItem("Item No.",ItemDescription);
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
    SETFILTER("Resp. Center Table Filter",
      UserSetupMgt.GetRespCenterFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserSetupMgt.GetRespPhysLocationFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserSetupMgt.GetRespLocationFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1189
    // <<DITW15.00.00.24 DDR 25/09/2008
    UpdateFields();
    // >>DITW15.00.00.24 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //var
    //  ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
    // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    exit(TriggerOnDeleteRecord());
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(FIND(Which));
    exit(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    "Item Charge No.Enable" := true;
    "Tariff No.Editable" := true;
    CompanyTaxRegistrationNoEditab := true;
    "Item DTax Group CodeEditable" := true;
    "AAD No.Editable" := true;
    "Item Charge No.Editable" := true;
    "Item No.Editable" := true;
    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    GlobalTax1ValueEditable := true;
    GlobalTax2ValueEditable := true;
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetUpNewLine(xRec);
    CLEAR(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    IndentLine := 0;
    if not ISEMPTY then
      InitLineNo(ExpandLines,BelowxRec);
    // >>DITW17.10.03 DDR DIT-770 #541
    SetUpNewLine(xRec);
    CLEAR(ShortcutDimCode);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNextRecord". Please convert manually.

    //trigger OnNextRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(NEXT(Steps));
    exit(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsOpenedFromBatch then begin
      CurrentJnlBatchName := "Journal Batch Name";
      ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
      exit;
    end;
    ItemJnlMgt.TemplateSelection(PAGE::"Revaluation Journal",3,false,Rec,JnlSelected);
    if not JnlSelected then
      ERROR('');

    ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
      // to run all custom C/AL into this trigger
      //EXIT;
    //end;
    end else begin
    // >>DITW16.00.00.40 DDR DIT-715 #194
      ItemJnlMgt.TemplateSelection(PAGE::"Revaluation Journal",3,false,Rec,JnlSelected);
      if not JnlSelected then
        ERROR('');
    // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
    end;
    // >>DITW16.00.00.40 DDR DIT-715 #194

    ///DITW18.00.06 DDR 25/02/2015 DIT-770 #1189-DITW110.00.12 MSF 04/05/2018 NRQ#55899

    ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
    // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    // <<DITW17.00.01 DDR 12/03/2013 DIT-770 #001
    if "Journal Template Name" = '' then
      "Journal Template Name" := GETRANGEMAX("Journal Template Name");
    if "Journal Batch Name" = '' then
      "Journal Batch Name" := GETRANGEMAX("Journal Batch Name");
    // >>DITW17.00.01 DDR DIT-770 #001

    if not ISEMPTY then
      FINDLAST;
    //xRec.COPY(Rec);
    // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := false;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;

    // BC Upgrade Priya >> DrinkIT procedure commented.
    // procedure InsertExtendedCharges(FromHeader : Boolean);
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if InsertChargeLines(FromHeader) then
    //       CurrPage.UPDATE(true);
    // end;

    // local procedure UpdateFields();
    // var
    //     CollapsedLine : Boolean;
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008 - DITW15.00.00.38 DDR 16/07/2010 #1194
    //     // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    //     CollapsedLine := not ExpandLines;
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     "Item No.Editable" := FormEditableField(FIELDNO("Item No."));
    //     // <<DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1
    //       "Item Charge No.Editable" := false;
    //       "Item Charge No.Enable" := false;
    //     //"Item Charge No.Editable" := FormEditableField(FIELDNO("Item Charge No."));
    //     // >>DITW16.00.00.38 DDR DIT-715 #1
    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Unit AmountEditable" := FormEditableField(FIELDNO("Unit Amount")) and not CollapsedLine;
    //     // <<DITW15.00.00.37 DDR 29/01/2010
    //     "AAD No.Editable" := FormEditableField(FIELDNO("AAD No."));
    //     "AAD No. SeriesEditable" := FormEditableField(FIELDNO("AAD No. Series"));
    //     "Item DTax Group CodeEditable" := FormEditableField(FIELDNO("Item DTax Group Code"));
    //     CompanyTaxRegistrationNoEditab := FormEditableField(FIELDNO("Company Tax Registration No."));
    //     "Tariff No.Editable" := FormEditableField(FIELDNO("Tariff No."));
    //     // >>DITW15.00.00.37 DDR
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code") and not "Is Item Charge";
    //     GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code") and not "Is Item Charge";
    //     // >>DITW19.00.08 DDR BL#10443
    // end;
    // BC Upgrade Priya << DrinkIT procedure commented.
    procedure TriggerOnDeleteRecord(): Boolean;
    var
    // ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
        // COMMIT;
        // if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
        //   exit(false);
        // // <<QXL9.00.001 DAT 23/03/2016
        // if QualitySetup.READPERMISSION then begin
        //   if not QualityManagement.DeleteItemJnlLineConfirm(Rec) then
        //     exit(false);
        // end;
        // // >>QXL9.00.001 DAT 23/03/2016
        // ReserveItemJnlLine.DeleteLine(Rec);
        // // <<QXL9.00.001 DAT 23/03/2016
        // if QualitySetup.READPERMISSION then
        //   QualityManagement.DeleteItemJnlLine(Rec);
        // // >>QXL9.00.001 DAT 23/03/2016
        // BC Upgrade Priya << DrinkIT code commented.

        exit(true);
    end;

    procedure TriggerOnNewRecord(BelowxRec: Boolean): Boolean;
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
        // INIT;
        // // >>DITW16.00.00.38 DDR DIT-715 #50

        // // <<DITW15.00.00.35 DDR 19/10/2009
        // FILTERGROUP(2);
        // if GETFILTER("Journal Template Name") <> '' then
        //   "Journal Template Name" := GETFILTER("Journal Template Name");
        // if GETFILTER("Journal Batch Name") <> '' then
        //   "Journal Batch Name" := GETFILTER("Journal Batch Name");
        // FILTERGROUP(0);
        // // >>DITW15.00.00.35 DDR

        // SetUpNewLine(xRec);
        // CLEAR(ShortcutDimCode);

        // // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
        // exit(true);
        // // >>DITW16.00.00.38 DDR DIT-715 #50
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    local procedure PostingDateOnAfterValidate();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // if "Line No." <> 0 then
        //   CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya >> DrinkIT code commented.
    end;

    local procedure ItemNoOnAfterValidate();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    local procedure ItemChargeNoOnAfterValidate();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    local procedure VariantCodeOnAfterValidate();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // if "Line No." <> 0 then
        //   CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    local procedure LocationCodeOnAfterValidate();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // if "Line No." <> 0 then
        //   CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    local procedure UnitofMeasureCodeOnAfterValida();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // if "Line No." <> 0 then
        //   CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    local procedure UnitAmountOnAfterValidate();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // if xRec."Unit Amount" <> "Unit Amount" then
        //   CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    local procedure UnitCostRevaluedOnAfterValidat();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // if "Line No." <> 0 then
        //   CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    local procedure InventoryValueRevaluedOnAfterV();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // if "Line No." <> 0 then
        //   CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    local procedure AppliestoEntryOnAfterValidate();
    begin
        // BC Upgrade Priya >> DrinkIT code commented.
        // // <<DITW15.00.00.24 DDR 25/09/2008
        // if "Line No." <> 0 then
        //   CurrPage.UPDATE(true);
        // // >>DITW15.00.00.24 DDR
        // BC Upgrade Priya << DrinkIT code commented.
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

