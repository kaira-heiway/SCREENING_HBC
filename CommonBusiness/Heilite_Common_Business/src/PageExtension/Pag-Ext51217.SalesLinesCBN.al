pageextension 51217 SalesLinesExtCBN extends "Sales Lines"
{
    // version NAVW110.0,DITW110.00.10
    //     DITW15.00.00.36 DDR 06/11/2009 issue 777 Added columns
    // DITW15.00.00.37 DDR 28/05/2010 issue 480 Added Expand/Collapse functions
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    //                 DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    // DITW15.00.00.38 DDR 17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    // DITW16.00.00.40 DDR 03/04/2012 DIT-715 #243 Loyalty functionnality
    //                                Added fields "Allow Loyalty","unit point","Points Qty. (Base)","Loyalty Unit Cost (LCY)"
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after ""Shipping Charge Per"" field
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW17.10.05 WSA 05/11/2014 Added Loyalty Fields
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Unit Price"
    // DITW18.00.07 AKH 10/05/2016 DIT-770 #1346 Added field "Delivery Time (sec.)"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 YHE 30/06/2017 NRQ#13598 Remove DIT fileds ID.2035392-"Sell-to Customer Name", ID.2035391-"External Document No."
    // DITW113.00.15 DDR 04/10/2019 NRQ#10495 Rename Loyalty 'Cost' -> 'Amount' (all fields)

    // HEI.01 FDD-HB1111 IBM NASTAA02 26.02.2020 # Adding Fields to existing Tables - Sales Reports enhancements
    //   # New Fields added: "Quantity Invoiced" and "Quantity Shipped"
    // HEI.02 CHG2094005 IBM SAMANR01 12.02.2021
    //   # Add field “Qty. to Ship" and "Qty. to Ship (Base) (5418)”

    //Bc Upgrade YADAVM09 page id is 516.


    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the type of document that you are about to create.', FRA = 'Spécifie le type de document que vous allez créer.';

            //Unsupported feature: Change Editable on ""Document Type"(Control 2)". Please convert manually.

        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number.', FRA = 'Spécifie le numéro du document.';

            //Unsupported feature: Change Editable on ""Document No."(Control 4)". Please convert manually.

        }
        modify("Sell-to Customer No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer to whom the items in the sales order will be shipped.', FRA = 'Spécifie le numéro du client à qui les articles de la commande vente seront expédiés.';

            //Unsupported feature: Change Editable on ""Sell-to Customer No."(Control 8)". Please convert manually.

        }
        modify("Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number.', FRA = 'Spécifie le numéro de ligne.';

            //Unsupported feature: Change Editable on ""Line No."(Control 6)". Please convert manually.

        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of entity that will be posted for this sales line, such as Item, Resource, or G/L Account. The type that you enter in this field determines what you can select in the No. field.', FRA = 'Spécifie le type d''entité qui sera validé pour cette ligne vente, par exemple Article, Ressource ou Compte général. Le type que vous saisissez dans ce champ détermine ce que vous pouvez sélectionner dans le champ N°.';

            //Unsupported feature: Change Editable on "Type(Control 10)". Please convert manually.

        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''une ressource, d''un coût supplémentaire ou d''une immobilisation, selon ce que vous avez sélectionné dans le champ Type.';

            //Unsupported feature: Change Editable on ""No."(Control 12)". Please convert manually.

        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';

            //Unsupported feature: Change Editable on ""Variant Code"(Control 40)". Please convert manually.

        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.', FRA = 'Spécifie une description de l''entrée qui est basée sur le contenu des champs Type et N°.';

            //Unsupported feature: Change Editable on "Description(Control 14)". Please convert manually.

        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.', FRA = 'Spécifie le magasin stock dans lequel les articles vendus devraient être pris et où la baisse de stock doit être enregistrée.';

            //Unsupported feature: Change Editable on ""Location Code"(Control 31)". Please convert manually.

        }
        modify(Reserve)
        {
            ToolTipML = ENU = 'Specifies whether a reservation can be made for items on this line.', FRA = 'Spécifie s''il est possible de réserver des articles sur cette ligne.';

            //Unsupported feature: Change Editable on "Reserve(Control 24)". Please convert manually.

        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies how many units are being sold.', FRA = 'Spécifie le nombre d''unités vendues.';

            //Unsupported feature: Change Editable on "Quantity(Control 52)". Please convert manually.

        }
        modify("Reserved Qty. (Base)")
        {
            ToolTipML = ENU = 'Specifies the value in the Reserved Quantity field, expressed in the base unit of measure.', FRA = 'Spécifie la valeur dans le champ Quantité réservée, exprimée en unité de base.';

            //Unsupported feature: Change Editable on ""Reserved Qty. (Base)"(Control 18)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure that is used to determine the value in the Unit Price field on the sales line.', FRA = 'Spécifie l''unité de mesure utilisée pour déterminer la valeur dans le champ Prix unitaire de la ligne vente.';

            //Unsupported feature: Change Editable on ""Unit of Measure Code"(Control 28)". Please convert manually.

        }
        modify("Line Amount")
        {
            ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.', FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';

            //Unsupported feature: Change AutoFormatType on ""Line Amount"(Control 54)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Line Amount"(Control 54)". Please convert manually.


            //Unsupported feature: Change Editable on ""Line Amount"(Control 54)". Please convert manually.

        }
        modify("Job No.")
        {
            ToolTipML = ENU = 'Specifies the job number that the sales line is linked to.', FRA = 'Spécifie le numéro de la tâche à laquelle la ligne vente est liée.';

            //Unsupported feature: Change Editable on ""Job No."(Control 50)". Please convert manually.

        }
        modify("Work Type Code")
        {
            ToolTipML = ENU = 'Belongs to the Job application area.', FRA = 'Appartient au domaine d''application Projets.';

            //Unsupported feature: Change Editable on ""Work Type Code"(Control 38)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the sale.', FRA = 'Spécifie le code section analytique lié à la vente.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 1 Code"(Control 34)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the sale.', FRA = 'Spécifie le code section analytique lié à la vente.';

            //Unsupported feature: Change Editable on ""Shortcut Dimension 2 Code"(Control 36)". Please convert manually.

        }

        //Unsupported feature: Change Editable on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.


        //Unsupported feature: Change Editable on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.

        modify("Shipment Date")
        {
            ToolTipML = ENU = 'Specifies the date that the items on the line are in inventory and available to be picked.', FRA = 'Spécifie la date à laquelle les articles de la ligne sont en stock et disponibles pour le prélèvement.';

            //Unsupported feature: Change Editable on ""Shipment Date"(Control 26)". Please convert manually.

        }
        modify("Outstanding Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units on the order line have not yet been shipped.', FRA = 'Spécifie le nombre d''unités de la ligne commande qui n''ont pas encore été expédiées.';

            //Unsupported feature: Change Editable on ""Outstanding Quantity"(Control 16)". Please convert manually.

        }
        // addfirst(Control1)//Bc Upgrade YADAVM09 Drink it field>>
        // {
        //     field("Has Item Charge"; Rec."Has Item Charge")
        //     {
        //         BlankZero = true;
        //     }
        //     field(Collapse; Rec.Collapse)
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.37 DDR 19/01/2010
        //             CurrPage.UPDATE(true);
        //             // >>DITW15.00.00.37 DDR
        //         end;
        //     }
        // }
        // addafter(Description)
        // {
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // } 
        // addafter("Location Code")
        // {
        //     field("Location Group Code"; Rec."Location Group Code")
        //     {
        //         Editable = false;
        //     }
        // }
        // addafter("Line Amount")
        // {
        //     field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Unit Price"), true))
        //     {
        //         AutoFormatExpression = "Currency Code";
        //         AutoFormatType = 2;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014411);
        //         CaptionML = ENU = 'Total Unit Price',
        //                     FRA = 'Total prix unitaire';
        //         Description = 'DITW17.10.05 DIT-770 #988';
        //         Editable = false;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
        //     {
        //         AutoFormatExpression = "Currency Code";
        //         AutoFormatType = 1;
        //         BlankZero = true;
        //         CaptionClass = GetCaptionClassVar(PageText2014410);
        //         CaptionML = ENU = 'Total Line Amount',
        //                     FRA = 'Montant total ligne';
        //         Description = 'DITW17.10.02B DIT-770 #541';
        //         Editable = false;
        //         QuickEntry = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        addafter("Outstanding Quantity")
        {
            //Bc Upgrade YADAVM09 Drink it field>>
            //     field("Item DDeposit Group Code"; "Item DDeposit Group Code")
            //     {
            //         Editable = false;
            //     }
            //     field("GetTrackingItemNo()"; GetTrackingItemNo())
            //     {
            //         CaptionML = ENU = 'Tracking Item No. (Item Charge)',
            //                     FRA = 'N° article traçable (Frais annexes)';
            //         DrillDownPageID = "Item List";
            //         Editable = false;
            //         LookupPageID = "Item List";
            //         TableRelation = IF ("Item Charge Type" = CONST(Tax)) Item WHERE("No." = FIELD("Tax Item No."))
            //         ELSE IF ("Item Charge Type" = CONST(Deposit)) Item WHERE("No." = FIELD("Empty Goods Item No."));

            //         trigger OnLookup(Text: Text): Boolean;
            //         begin
            //             // <<DITW15.00.00.38 DDR 17/12/2010 #703
            //             Text := GetTrackingItemNo();
            //             LookupItemNo(Text);
            //             exit(false);
            //         end;
            //     }
            // field("Item Charge Quantity per"; "Rec.Item Charge Quantity per")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Item DTax Group Code"; Rec."Item DTax Group Code")
            // {
            //     Editable = false;
            // }
            // field("Company Tax Registration No."; Rec."Company Tax Registration No.")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Tariff No."; "Tariff No.")
            // {
            //     Editable = false;
            // }
            // field("AAD No. Series"; "AAD No. Series")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("AAD No."; "AAD No.")
            // {
            //     Editable = false;
            // }
            // field("Customer DDisc. Group Code"; "Customer DDisc. Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Item DDisc. Group Code"; "Item DDisc. Group Code")
            // {
            //     Editable = false;
            // }
            // field("Customer DPromo. Group Code"; "Customer DPromo. Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Item DPromo. Group Code"; "Item DPromo. Group Code")
            // {
            //     Editable = false;
            // }
            // field("Free Item Posting Type"; Rec."Free Item Posting Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Free Item"; Rec."Free Item")
            // {
            //     Editable = false;
            // }
            // field("Free Calculation Type"; Rec."Free Calculation Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Allow Loyalty"; Rec."Allow Loyalty")
            // {
            //     Description = 'DIT715 #243';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Unit Point"; "Loyalty Unit Point")
            // {
            //     Description = 'DIT715 #243';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Points Qty. (Base)"; "Loyalty Points Qty. (Base)")
            // {
            //     Description = 'DIT715 #243';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Loyalty Unit Amount (LCY)"; "Loyalty Unit Amount (LCY)")
            // {
            //     Description = 'DIT715 #243';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Shipping Agent Code"; "Shipping Agent Code")
            // {
            //     Editable = false;
            // }
            // field("Shipping Agent Service Code"; "Shipping Agent Service Code")
            // {
            //     Editable = false;
            // }
            // field(Distance; Rec.Distance)
            // {
            //     Editable = false;
            // }
            // field(Weight; Rec.Weight)
            // {
            //     Editable = false;
            // }
            // field(Cubage; Cubage)
            // {
            //     Editable = false;
            // }
            // field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
            // {
            // }
            // field("Shipping Charge Per"; Rec."Shipping Charge Per")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Outstanding Amount"; Rec."Outstanding Amount")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field("Unit Volume HL"; Rec."Unit Volume HL")
            // {
            // }//Bc Upgrade YADAVM09 Drink it field
            field("Blanket Order No."; Rec."Blanket Order No.")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Blanket Order Line No."; Rec."Blanket Order Line No.")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            //BC UpGrade YADAVM09 Drink it field>>
            // field("Loyalty Point Type"; Rec."Loyalty Point Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Unit Amount"; Rec."Loyalty Unit Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Amount Type"; Rec."Loyalty Amount Type")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Outstanding Amount"; Rec."Loyalty Outstanding Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Outstd. Amount (LCY)"; Rec."Loyalty Outstd. Amount (LCY)")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Amount"; Rec."Loyalty Amount")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }
            // field("Loyalty Amount (LCY)"; Rec."Loyalty Amount (LCY)")
            // {
            //     Description = 'DITW17.10.05 DIT-770 #185';
            //     Visible = false;
            // }//BC Upgrade YADAVM09 Drink it field<<
            field("Quantity Invoiced"; Rec."Quantity Invoiced")
            {
                Description = 'HEI.01';
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            field("Quantity Shipped"; Rec."Quantity Shipped")
            {
                Description = 'HEI.01';
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
            // field("Qty. to Ship"; Rec."Qty. to Ship")
            // {
            // }//Bc Upgrade YADAVM09 Drink it field<<
            field("Qty. to Ship (Base)"; Rec."Qty. to Ship (Base)")
            {
                ApplicationArea = all;//Bc Upgrade YADAVM09
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Show Document")
        {
            CaptionML = ENU = 'Show Document', FRA = 'Afficher document';
            ToolTipML = ENU = 'Open the document that the selected line exists on.', FRA = 'Ouvrez le document sur lequel la ligne sélectionnée existe.';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries', FRA = 'Écritures réservation';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
        }
        //Bc Upgrade YADAVM09 Drink it CAtion Commented>>
        // addfirst("&Line")
        // {
        //     action("+ Expand")
        //     {
        //         CaptionML = ENU = '+ Expand',
        //                     FRA = '+ Développer';
        //         Enabled = (NOT ExpandLines);
        //         Image = ViewDetails;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
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
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         Visible = ExpandLines OR ShowButtonsCE;

        //         trigger OnAction();
        //         begin
        //             // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //             ExpandLines := GETFILTER("Attached to Line No.") <> '';
        //             CurrPage.UPDATE(true);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it CAtion Commented<<
    }

    var
        TempRecOpenFilters: Record "Sales Line" temporary;
        IsOpenPage: Boolean;
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Unit Price', FRA = 'Total prix unitaire';
        // BC Upgrade MISHRS14 >>
        // Blocked InDataSet to remove warning
        //[InDataSet]
        ExpandLines: Boolean;
        //[InDataSet]
        // BC Upgrade MISHRS14 <<
        ShowButtonsCE: Boolean;
        IndentLine: Integer;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    // 
    // ShowShortcutDimCode(ShortcutDimCode);
    // 
    // //end;
    // //>>>> MODIFIED CODE:
    // //begin
    // 
    // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    // IndentLine := IndentRecordDIT(ExpandLines);
    // // >>DITW17.10.03 DDR DIT-770 #541
    // ShowShortcutDimCode(ShortcutDimCode);
    // 
    //end;


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    // /*
    // // <<DITW16.00.00.37 DIT-715 #1 - DDR DIT717 #13
    // if IsOpenPage then begin
    //   COPY(TempRecOpenFilters);
    //   IsOpenPage := false;
    // end;
    // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    // //EXIT(FIND(Which));
    // exit(FindRecordDIT(Which,ExpandLines));
    // // >>DITW17.10.03 DDR DIT-770 #541
    // // >>DITW16.00.00.37 DIT-715 #13
    // */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    // /*
    // CLEAR(ShortcutDimCode);
    // */
    // //end;
    // //>>>> MODIFIED CODE:
    // //begin
    // /*
    // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    // IndentLine := 0;
    // if not ISEMPTY then
    //   InitLineNo(ExpandLines,BelowxRec);
    // // >>DITW17.10.03 DDR DIT-770 #541
    // CLEAR(ShortcutDimCode);
    // */
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


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    // /*
    // // <<DITW16.00.00.37 DDR DIT717 #13
    // TempRecOpenFilters.COPY(Rec);
    // IsOpenPage := true;
    // // >>DITW16.00.00.37 DDR DIT717 #13
    // // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    // ExpandLines := GETFILTER("Attached to Line No.") <> '';
    // ShowButtonsCE := IsShowButtonsCEDIT();
    // // >>DITW17.10.03 DDR DIT-770 #541
    // */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

