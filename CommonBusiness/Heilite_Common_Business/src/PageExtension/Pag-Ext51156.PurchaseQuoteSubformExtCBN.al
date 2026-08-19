pageextension 51156 PurchaseQuoteSubformExtCBN extends "Purchase Quote Subform"
{
    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 02/01/2007 Added column "Line No." (not editable)
    //                                Bugfix AutoSplitKey process on new record with Collapse/Expand functionnality
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 10/01/2008 Bugfix using F8 on new line
    //                                Change property HorzAlign=Right for collapsed total fields (line amount)
    //                                Added parameter BlankZero for function UpdateFormatField()
    //                                Remove ProcessTaxItemCharge();ProcessUpdateUnitPrice();InsertTaxItemCharge();
    // DITW15.00.00.01 DDR 23/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                Added field "Collapse"
    //                                Bugfix Refresh columns
    //                                Added function UpdateExpandStatus
    //                                Change function UpdateFields for Discount & Promotion
    // DITW15.00.00.01 DDR 19/03/2008 move function InsertExtendedCharges()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 26/03/2008 Remove (move into function) confirm message from function InsertExtendedCharges()
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                Updated function into InsertExtendedCharges()
    //                     31/07/2008 Move NewRecord() function into OnNewRecord trigger
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    //                 DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                Added function FormTotalingField()
    // DITW15.00.00.37 DDR 26/01/2009 issue 939 Performance SQL error call function into OnModify() trigger
    // DITW15.00.00.37 DDR 11/05/2010 issue 1061 Added field "Physical Location Group Code"
    //                     01/06/2010 issue 959 Added field "AAD No."
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    //                     17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                     27/01/2011 issue 1259 Added update() on field "Cross-Reference No."
    //                                           Added non-editable when item is (free) item charge
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                             Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                             Modified order position RTC buttons
    //                                               contol1102601007 RTCNewLine
    //                                               contol1102601008 RTCDeleteLine
    //                                               contol1102601009 RTCDleteAllLines
    //                     15/03/2011 issue 1217 (DIT711 163) Added EMCS fields
    //                                               "ARC No.","SAD No."
    //                     15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                     16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 DDR 26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."
    // DITW16.00.00.41 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             added approved prod group + approved line amount
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'IndentationControls' field1 Group Repeater
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center"
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackUnitPriceItem()
    // HEI.01 FDD-PRDGAP031 IBM PATHAA02 09.11.2017
    // #Code on OnAfterGetRecord
    // HEI.02 Defect#818 14/12/2017 IBM.CHAUHB01 Added fields "Machine Reference Number"
    // HEI.03 FDD_Ethiopia_Tolerance field for SPOT PO  Overdelivery_V0.1_HT630 IBM HORTOC01 28.06.2019 # new field added "Tolerance Received Over %"
    // HEI.04 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name - fields added
    //--------------------------------------BC Upgrade SHARMP16 Custom code--------------------
    //BC upgrade SHARMP16 Interface related fields shifted to Interface EXT

    layout
    {
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the line type.', FRA = 'Spécifie le type de ligne.';
            Enabled = TypeEnable;

            //Unsupported feature: Change Editable on "Type(Control 2)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify(Nonstock)
        {
            ToolTipML = ENU = 'Specifies that this item is a nonstock item.', FRA = 'Spécifie que cet article est non stocké.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code for the VAT product posting group of the item or general ledger account on this line.', FRA = 'Spécifie le code du groupe comptabilisation produit TVA de l''article ou du compte général de la ligne.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry, depending on what you chose in the Type field.', FRA = 'Spécifie une description de l''écriture, en fonction de ce que vous choisissez dans le champ Type.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location where the items on the line will be located.', FRA = 'Spécifie le code du magasin où sont stockés les articles de la ligne.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item that will be specified on the line.', FRA = 'Spécifie le nombre d''unités de l''article qui seront spécifiées sur la ligne.';
            //Enabled = QuantityEnable;//BCUpgrade sharmp16--Purchaseprocesstestchanges

            //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code that is valid for the purchase line.', FRA = 'Spécifie le code unité valable pour la ligne achat.';
        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the name of the unit of measure for the item, such as 1 bottle or 1 piece.', FRA = 'Spécifie le nom de l''unité de l''article, par exemple, 1 bouteille ou 1 pièce.';
        }
        modify("Direct Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the direct cost of one item unit.', FRA = 'Spécifie le coût direct d''une unité d''article.';

            //Unsupported feature: Change Editable on ""Direct Unit Cost"(Control 12)". Please convert manually.

        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the item''s indirect cost percentage.', FRA = 'Spécifie le pourcentage de coût indirect de l''article.';
        }
        modify("Unit Cost (LCY)")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';
        }
        modify("Unit Price (LCY)")
        {
            ToolTipML = ENU = 'Specifies the price for one unit of the item.', FRA = 'Spécifie le prix unitaire de l''article.';
            Enabled = "Unit Price (LCY)Enable";
        }
        modify("Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount (excluding the invoice discount amount) of the line, in the currency of the purchase document.', FRA = 'Spécifie le montant net (excluant le montant remise facture) de la ligne, dans la devise du document achat.';
            Enabled = "Line AmountEnable";

            //Unsupported feature: Change Editable on ""Line Amount"(Control 30)". Please convert manually.

        }
        modify("Line Discount %")
        {
            ToolTipML = ENU = 'Specifies the line discount percentage that is valid for the item on the line.', FRA = 'Spécifie le pourcentage de remise ligne valable pour l''article de la ligne.';
        }
        modify("Line Discount Amount")
        {
            ToolTipML = ENU = 'Specifies the amount of the line discount that will be granted on the purchase line.', FRA = 'Spécifie le montant de la remise ligne qui est accordée sur la ligne achat.';
        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies whether the invoice line is included when the invoice discount is calculated.', FRA = 'Spécifie si la ligne facture est incluse lors du calcul de la remise facture.';
        }
        modify("Allow Item Charge Assignment")
        {
            ToolTipML = ENU = 'Specifies that you can assign item charges to this line.', FRA = 'Spécifie que vous pouvez affecter des frais annexes à cette ligne.';
        }
        modify("Qty. to Assign")
        {
            ToolTipML = ENU = 'Specifies the quantity of the item charge that will be assigned when you post this line.', FRA = 'Spécifie la quantité de frais annexes qui sera affectée lorsque vous validez cette ligne.';
        }
        modify("Qty. Assigned")
        {
            ToolTipML = ENU = 'Specifies how much of the item charge that has been assigned.', FRA = 'Spécifie les frais annexes qui ont été affectés.';
        }
        modify("Prod. Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production order that the purchase order was created for.', FRA = 'Spécifie le numéro de l''O.F. pour lequel la commande achat a été créée.';
        }
        modify("Blanket Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the blanket order line from which this purchase line originates.', FRA = 'Spécifie le numéro de ligne de la ligne de la commande ouverte qui est à l''origine de cette ligne achat.';
        }
        modify("Appl.-to Item Entry")
        {
            ToolTipML = ENU = 'Specifies the item ledger entry number the line should be applied to.', FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle la ligne doit être lettrée.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the purchase.', FRA = 'Spécifie le code section analytique lié à l''achat.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the purchase.', FRA = 'Spécifie le code section analytique lié à l''achat.';
        }
        modify("Invoice Discount Amount")
        {
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field.', FRA = 'Spécifie un montant de remise qui est déduit de la valeur indiquée dans le champ Total TTC.';
        }
        modify("Invoice Disc. Pct.")
        {
            CaptionML = ENU = 'Invoice Discount %', FRA = '% remise facture';
            ToolTipML = ENU = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.', FRA = 'Indique un pourcentage de remise qui est accordé si les critères que vous avez paramétrés pour le client sont réunis.';
        }
        modify("Total Amount Excl. VAT")
        {
            CaptionML = ENU = 'Total Amount Excl. VAT', FRA = 'Montant total HT';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document, minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant ligne HT sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }
        modify("Total VAT Amount")
        {
            CaptionML = ENU = 'Total VAT', FRA = 'Total TVA';
            ToolTipML = ENU = 'Specifies the sum of VAT amounts on all lines in the document.', FRA = 'Spécifie la somme des montants de TVA sur toutes les lignes du document.';
        }
        modify("Total Amount Incl. VAT")
        {
            CaptionML = ENU = 'Total Amount Incl. VAT', FRA = 'Montant total TTC';
            ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document, minus any discount amount in the Invoice Discount Amount field.', FRA = 'Spécifie la somme de la valeur du champ Montant TTC sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
        }

        //Unsupported feature: CodeModification on "Type(Control 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoOnAfterValidate;
        if xRec."No." <> '' then
          RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TypeOnAfterValidate;
        #1..3
        */
        //end;


        //Unsupported feature: CodeInsertion on ""No."(Control 4)". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
        if AssistEditItemTreeview("No.") then begin
          // validate trigger
          ShowShortcutDimCode(ShortcutDimCode);
          // aftervalidate trigger
          CurrPage.UPDATE(true);
        end else
          CurrPage.UPDATE(false);
        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Control 4).OnValidate". Please convert manually.

        //trigger "(Control 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        NoOnAfterValidate;

        if xRec."No." <> '' then
          RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
        if not ("No.Editable" or "No.Enable") then begin
          "No." := xRec."No.";
          exit;
        end;
        // >>DITW17.10.03 DDR DIT-770 #541
        #1..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Cross-Reference No."(Control 36).OnLookup". Please convert manually.

        //trigger "(Control 36)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        InsertExtendedText(false);
        NoOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        //InsertExtendedText(FALSE);
        // >>DITW15.00.00.38 DDR #1259
        NoOnAfterValidate;
        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        CurrPage.UPDATE;
        // >>DITW15.00.00.38 DDR #1259
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 20)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 62)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        if xRec."Location Code" <> "Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1191
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Control 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        QuantityOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Control 24).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        UnitofMeasureCodeOnAfterValida;
        */
        //end;


        //Unsupported feature: CodeModification on ""Direct Unit Cost"(Control 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        DirectUnitCostOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Amount"(Control 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        LineAmountOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount %"(Control 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        LineDiscount37OnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount Amount"(Control 50).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        LineDiscountAmountOnAfterValid;
        */
        //end;
        modify("Blanket Order No.")
        {
            Visible = false;
        }

        //Unsupported feature: PropertyDeletion on ""Blanket Order Line No."(Control 34)". Please convert manually.

        addfirst(Control1)
        {
            // field("Has Item Charge"; Rec."Has Item Charge")
            // {
            //     BlankZero = true;
            //     QuickEntry = false;
            // }//BC Upgrade SHARMP16-- Drink-IT field.
            // field(Collapse; Rec.Collapse)
            // {
            //     QuickEntry = false;
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(true);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }//BC Upgrade SHARMP16-- Drink-IT field.
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
                QuickEntry = false;
                Visible = false;
                ToolTip = 'Specifies the line''s number.';
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            // field("GetTrackingItemNo()"; Rec.GetTrackingItemNo())
            // {
            //     CaptionML = ENU = 'Tracking Item No. (Item Charge)',
            //                 FRA = 'N° article traçable (Frais annexes)';
            //     DrillDownPageID = "Item List";
            //     Editable = false;
            //     LookupPageID = "Item List";
            //     TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item where("No." = FIELD("Tax Item No."))
            //     else IF ("Item Charge Type" = CONST(Deposit)) Item where("No." = FIELD("Empty Goods Item No."));
            //     Visible = false;

            //     trigger OnLookup(Text: Text): Boolean;
            //     begin
            //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
            //         Text := GetTrackingItemNo();
            //         LookupItemNo(Text);
            //         exit(false);
            //     end;
            // }//BC Upgrade SHARMP16-- Drink-IT code.
        }
        addafter(Description)
        {
            // field("Description 2"; Rec."Description 2")
            // {
            //     Description = 'DIT-715 #393';
            //     Visible = false;
            // }//BC Upgrade SHARMP16-- already defined in base.
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the Responsibility Center field.';

                trigger OnValidate();
                begin
                    // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                    // if rec."Responsibility Center" <> xRec."Responsibility Center" then
                    //     CurrPage.UPDATE(true);
                    // // >>DITW18.00.06 DDR DIT-770 #1191//BC Upgrade SHARMP16-- Drink-IT code.
                end;
            }
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
            //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
            //             CurrPage.UPDATE(true);
            //         // >>DITW18.00.06 DDR DIT-770 #1191
            //     end;
            // }//BC Upgrade SHARMP16-- Drink-IT field.
        }
        addafter("Line Amount")
        {
            // field("Approved Line Amount"; Rec."Approved Line Amount")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #144';
            //     Visible = false;
            // }
            // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
            // {
            //     AutoFormatExpression = "Currency Code";
            //     AutoFormatType = 2;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014411);
            //     CaptionML = ENU = 'Total Direct Unit Cost',
            //                 FRA = 'Total coût unitaire directe';
            //     Description = 'DITW17.10.05 DIT-770 #988';
            //     Editable = false;
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
            // {
            //     AutoFormatExpression = "Currency Code";
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            //     QuickEntry = false;
            // }//BC Upgrade SHARMP16-- Drink-IT field.
        }
        addafter("Prod. Order No.")
        {
            field("Tolerance Received Over %"; Rec."Tolerance Received Over % FND")
            {
                ApplicationArea = all;
                Description = 'HEI.03';
                Editable = ToleranceReceivedOverEditable;
                ToolTip = 'Specifies the value of the Tolerance Received Over % field.';
            }
        }
        addafter("Blanket Order Line No.")
        {
            field("Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Requested Receipt Date field.';
            }
            // field("Expected Receipt Date"; Rec."Expected Receipt Date")
            // {
            // }
        }
        addafter("Appl.-to Item Entry")
        {
            //BC Upgrade SHARMP16 BEGIN>>-- DRINK-IT fields
            // field("AAD No."; Rec."AAD No.")
            // {
            //     Visible = false;
            // }
            // field("ARC No."; Rec."ARC No.")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Visible = false;
            // }
            // field("SAD No."; Rec."SAD No.")
            // {
            //     Description = 'DITW15.00.00.38 #1217';
            //     Visible = false;
            // }
            // field("Packaging Type Code"; Rec."Packaging Type Code")
            // {
            //     Visible = false;
            // }
            // field("Free Item"; Rec."Free Item")
            // {

            //     trigger OnValidate();
            //     begin
            //         FreeItemOnAfterValidate;
            //     end;
            // }
            // field("Allow VAT Calculation (Free)"; Rec."Allow VAT Calculation (Free)")
            // {
            //     Description = 'DITW16.00.00.40 DIT-715 #172';
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         AllowVATCalculationFreeOnAfter;
            //     end;
            // }
            // field("Free Item Posting Type"; Rec."Free Item Posting Type")
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         FreeItemPostingTypeOnAfterVali;
            //     end;
            // }
            // field("Linked Customer No."; Rec."Linked Customer No.")
            // {
            //     Visible = false;
            // }
            //BC Upgrade SHARMP16 end<<-- DRINK-IT fields
        }
        addafter("Qty. Assigned")//BC Upgrade SHARMP16 Purchprocesschanges
        {
            // field("App. Prod. Posting Group"; Rec."App. Prod. Posting Group")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #144';
            //     Visible = false;
            // }       //BC Upgrade SHARMP16 BEGIN>>-- DRINK-IT fields

            //BC Upgrade SHARMP16 BEGIN>>--------Interface related fields
            // field("Maximo Requisition No."; Rec."Maximo Requisition No.")
            // {
            //     ApplicationArea = all;
            // }
            // field("Maximo Requisition Line No."; Rec."Maximo Requisition Line No.")
            // {
            //     ApplicationArea = all;
            // }
            //BC Upgrade SHARMP16 end<<--------Interface related fields

            field("Machine Reference Number"; Rec."Machine Reference Number FND")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the Machine Reference Number field.';
            }
            field("Tolerance Received Under %"; Rec."Tolerance Received Under % FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Tolerance Received Under % field.';
            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the SPL Code field.';
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the SPL Name field.';
            }
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM', FRA = '&Eclater nomenclature';
        }
        modify("Insert &Ext. Texts")
        {
            CaptionML = ENU = 'Insert &Ext. Texts', FRA = 'Insérer te&xtes étendus';
        }
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by', FRA = 'Disponibilité article par';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', FRA = 'Période';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant', FRA = 'Variante';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location', FRA = 'Magasin';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        //BC Upgrade SHARMP16 BEGIN>>-- DRINK-IT actions

        // addfirst(ActionContainer1900000004)
        // {
        //     action("+ Expand")
        //     {
        //         CaptionML = ENU = '+ Expand',
        //                     FRA = '+ Développer';
        //         Enabled = (NOT ExpandLines);
        //         Image = ViewDetails;
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = Process;
        //         //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedIsBig = true;
        //         Visible = (NOT ExpandLines) OR ShowButtonsCE;

        //         trigger OnAction();
        //         begin
        //             // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //             ExpandLines := true;
        //             CurrPage.UPDATE(true);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        //     action("- Collapse")
        //     {
        //         CaptionML = ENU = '- Collapse',
        //                     FRA = '- Réduire';
        //         Enabled = ExpandLines;
        //         Image = ViewDetails;
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = Process;
        //         //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedIsBig = true;
        //         Visible = ExpandLines OR ShowButtonsCE;

        //         trigger OnAction();
        //         begin
        //             // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //             ExpandLines := false;
        //             CurrPage.UPDATE(true);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        // }
        //BC Upgrade SHARMP16 end<<-- DRINK-IT actions   

        addafter("Insert &Ext. Texts")
        {
            // action("Insert Item Char&ges")
            // {
            //     CaptionML = ENU = 'Insert Item Char&ges',
            //                 FRA = 'Insérer frais annexe';
            //     ShortCutKey = 'Ctrl+Y';

            //     trigger OnAction();
            //     begin
            //         //This functionality was copied from page #49. Unsupported part was commented. Please check it.
            //         /*CurrPage.PurchLines.PAGE.*/
            //         _InsertExtendedCharges(true);

            //     end;
            // }//BC Upgrade SHARMP16-- Drink-IT code.
        }
    }

    var
        UserMgt: Codeunit "User Setup Management";
        xRecRef: RecordRef;

        "Cross-Reference No.Editable": Boolean;

        "Direct Unit CostEditable": Boolean;
        // QualitySetup: Record "Quality Setup";
        // QualityManagement: Codeunit "Quality Management";
        EditableDesc: Boolean;

        ExpandLines: Boolean;

        "Line AmountEditable": Boolean;

        "Line AmountEnable": Boolean;

        "No.Editable": Boolean;

        "No.Enable": Boolean;

        QuantityEditable: Boolean;

        QuantityEnable: Boolean;

        ShowButtonsCE: Boolean;
        ToleranceReceivedOverEditable: Boolean;

        TypeEditable: Boolean;

        TypeEnable: Boolean;

        "Unit Price (LCY)Enable": Boolean;
        IndentLine: Integer;
        //cduAppMgt: Codeunit ApplicationManagement;
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateEditableOnRow;
    if PurchHeader.GET("Document Type","Document No.") then;

    DocumentTotals.PurchaseUpdateTotalsControls(Rec,TotalPurchaseHeader,TotalPurchaseLine,RefreshMessageEnabled,
      TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,VATAmount);
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

    #1..5

    // <<DITW15.00.00.01 DDR 18/12/2007
    // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
    UpdateFields();
    // >>DITW15.00.00.01 DDR 18/12/2007
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    CLEAR(DocumentTotals);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    ShowShortcutDimCode(ShortcutDimCode);
    CLEAR(DocumentTotals);

    //HEI.01 PATHAA02 07.11.2017>>
    if Type <> Type::Item then
      EditableDesc:= true
    else
      EditableDesc:= false;
    //PATHAA02 07.11.2017<<

    //HEI.03>>
    if (Type = Type::Item) then
      ToleranceReceivedOverEditable := true;
    //HEI.03<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if (Quantity <> 0) and ItemExists("No.") then begin
      COMMIT;
      if not ReservePurchLine.DeleteLineConfirm(Rec) then
        exit(false);
      ReservePurchLine.DeleteLine(Rec);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
    //IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    //  COMMIT;
    //  IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
    //    EXIT(FALSE);
    //  ReservePurchLine.DeleteLine(Rec);
    //end;
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
    exit(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.01 DDR 18/12/2007
    "Line AmountEnable" := true;
    "Unit Price (LCY)Enable" := true;
    QuantityEnable := true;
    "No.Enable" := true;
    TypeEnable := true;
    "Line AmountEditable" := true;
    "Direct Unit CostEditable" := true;
    QuantityEditable := true;
    "Cross-Reference No.Editable" := true;
    "No.Editable" := true;
    TypeEditable := true;
    // >>DITW15.00.00.01 DDR 18/12/2007
    ToleranceReceivedOverEditable := false;//HEI.03
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitType;
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
    InitType;
    CLEAR(ShortcutDimCode);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNextRecord". Please convert manually.

    //trigger OnNextRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    exit(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := false;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeModification on "NoOnAfterValidate(PROCEDURE 19066594)". Please convert manually.

    //procedure NoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateEditableOnRow;
    InsertExtendedText(false);
    if (Type = Type::"Charge (Item)") and ("No." <> xRec."No.") and
       (xRec."No." <> '')
    then
      CurrPage.SAVERECORD;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateEditableOnRow;
    // <<DITW15.00.00.36 DDR 25/11/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
    if (Type <> Type::Item) and not "Is Item Charge" then
    // >>DITW15.00.00.36 DDR - DITW15.00.00.38 DDR #1291
      InsertExtendedText(false);
    #3..6
    // <<DITW15.00.00.23 DDR 30/07/2008
    CurrPage.UPDATE;
    // >>DITW15.00.00.23 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "CrossReferenceNoOnAfterValidat(PROCEDURE 19048248)". Please convert manually.

    //procedure CrossReferenceNoOnAfterValidat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InsertExtendedText(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //InsertExtendedText(FALSE);
    CurrPage.UPDATE;
    // >>DITW15.00.00.38 DDR #1259
    */
    //end;
    //BC Upgrade SHARMP16 BEGIN>>-- DRINK-IT procedures
    // procedure _InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     if InsertChargeLines(FromHeader) then
    //         UpdateForm(true);
    //     // >>DITW15.00.00.23 DDR
    // end;

    // procedure InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    //     if InsertChargeLines(FromHeader) then
    //         UpdateForm(true);
    //     // >>DITW15.00.00.23 DDR
    // end;
    //BC Upgrade SHARMP16 BEGIN>>-- DRINK-IT procedures
    // local procedure UpdateFields();
    // var
    //     CollapsedLine: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR 15/02/2008 - DITW15.00.00.38 DDR 16/07/2010 #1194
    //     // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    //     CollapsedLine := not ExpandLines;
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     // <<DITW17.10.03 DDR 09/07/2014 DIT-770 #541
    //     CALCFIELDS("Has Item Charge");
    //     CollapsedLine := CollapsedLine and "Has Item Charge";
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     TypeEditable := FormEditableField(FIELDNO(Type));
    //     "No.Editable" := FormEditableField(FIELDNO("No."));
    //     // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //     "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No."));
    //     // >>DITW15.00.00.38 DDR #1259

    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Direct Unit CostEditable" := FormEditableField(FIELDNO("Direct Unit Cost")) and not CollapsedLine;
    //     "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

    //     // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //     TypeEnable := FormEditableField(FIELDNO(Type));
    //     "No.Enable" := FormEditableField(FIELDNO("No."));
    //     QuantityEnable := FormEditableField(FIELDNO(Quantity));
    //     "Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
    //     "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    //     // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    // end;

    // procedure NewLine();
    // var
    //     PurchLine: Record "Purchase Line";
    // begin
    //     // <<DITW16.00.00.37 DIT-715 #1
    //     if rec.FINDLAST then;
    //     PurchLine := Rec;
    //     rec.INIT;
    //     rec."Document Type" := PurchLine."Document Type";
    //     rec."Document No." := PurchLine."Document No.";
    //     rec."Line No." := PurchLine."Line No." + 10000;
    //     rec.INSERT(true);
    //     CurrPage.UPDATE(false);
    //     // >>DITW16.00.00.37 DIT-715 #1
    // end;

    // procedure DeleteLine();
    // begin
    //     // <<DITW16.00.00.37 DIT-715 #1
    //     rec.DELETE(true);
    //     CurrPage.UPDATE(false);
    //     // >>DITW16.00.00.37 DIT-715 #1
    // end;

    // procedure TriggerOnDeleteRecord(): Boolean;
    // var
    //     ReservePurchLine: Codeunit "Purch. Line-Reserve";
    //     TempRec: Record "Purchase Line" temporary;
    // begin
    //     // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
    //     if (rec.Quantity <> 0) and ItemExists("No.") then begin
    //         COMMIT;
    //         if not ReservePurchLine.DeleteLineConfirm(Rec) then
    //             exit(false);
    //         // <<QXL9.00.001 DAT 23/03/2016
    //         if QualitySetup.READPERMISSION then begin
    //             if not QualityManagement.DeletePurchLineConfirm(Rec) then
    //                 exit(false);
    //         end;
    //         // >>QXL9.00.001 DAT 23/03/2016
    //         ReservePurchLine.DeleteLine(Rec);
    //         // <<QXL9.00.001 DAT 23/03/2016
    //         if QualitySetup.READPERMISSION then
    //             QualityManagement.DeletePurchLine(Rec);
    //         // >>QXL9.00.001 DAT 23/03/2016
    //     end;

    //     // <<DITW15.00.00.36 DDR 23/11/2009
    //     if "Is Item Charge" and "ItemCharge Incl. Price" then begin
    //         DELETE(true);
    //         TempRec := Rec;
    //         TempRec."Direct Unit Cost" := 0;
    //         TempRec."Line Amount" := 0;
    //         TempRec."Line Discount Amount" := 0;
    //         // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
    //         TempRec.CalcBackDirectCostItem();
    //         // >>DITW110.00.11 DDR NRQ#24875
    //         exit(false);
    //     end;
    //     // >>DITW15.00.00.36 DDR
    //     exit(true);
    // end;

    // local procedure TypeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 15/01/2008
    //     if rec.Type <> xRec.Type then
    //         CurrPage.UPDATE;
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure VariantCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        (xRec."Variant Code" <> "Variant Code")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LocationCodeOnAfterValidate();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        not UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure QuantityOnAfterValidate();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        (Quantity <> xRec.Quantity) and
    //        not UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure UnitofMeasureCodeOnAfterValida();
    // var
    //     UpdateIsDone: Boolean;
    // begin
    //     // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Type = Type::Item) and
    //        not UpdateIsDone
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure DirectUnitCostOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Direct Unit Cost" <> xRec."Direct Unit Cost")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineAmountOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Line Amount" <> xRec."Line Amount")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscount37OnAfterValidate();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Line Discount %" <> xRec."Line Discount %")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscountAmountOnAfterValid();
    // begin
    //     // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Type = Type::Item) and
    //        ("Line Discount Amount" <> xRec."Line Discount Amount")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.01 DDR
    // end;

    // local procedure FreeItemOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if (Type = Type::Item) and
    //        (xRec."Free Item" <> "Free Item")
    //     then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;
    //BC Upgrade SHARMP16 end<<-- DRINK-IT procedures
    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;
    //BC Upgrade SHARMP16 BEGIN>>-- DRINK-IT procedures
    // local procedure FreeItemPostingTypeOnAfterVali();
    // begin
    //     // <<DITW15.00.00.35 DDR 25/06/2009
    //     if Type = Type::Item then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.35 DDR
    // end;
    //BC Upgrade SHARMP16 end<<-- DRINK-IT procedures
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    //BC Upgrade SHARMP16 BEGIN<< -------- Custom code
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //HEI.01 PATHAA02 07.11.2017>>
        IF rec.Type <> rec.Type::Item THEN
            EditableDesc := TRUE
        else
            EditableDesc := FALSE;
        //PATHAA02 07.11.2017<<

        //HEI.03>>
        IF (rec.Type = rec.Type::Item) THEN
            ToleranceReceivedOverEditable := TRUE;
        //HEI.03<<

    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        ToleranceReceivedOverEditable := FALSE;//HEI.03
    end;
    //BC Upgrade SHARMP16 end<< -------- Custom code
}

