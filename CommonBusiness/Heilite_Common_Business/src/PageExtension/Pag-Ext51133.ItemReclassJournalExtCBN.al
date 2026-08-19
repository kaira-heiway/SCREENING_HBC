pageextension 51133 ItemReclassJournalExtCBN extends "Item Reclass. Journal"
{
    // version NAVW110.0,FINXL7.00.001,MANXL7.00.001,QXL9.00.001,DITW110.00.11

    // HEI.01 CHG2138109 IBM.LS      22.02.2022
    // # Created New Function - GetBatchName
    //*************************************************************************************
    //  BC UPGRADE PATHAA02-06-11-25-Done
    //DIT--> var, funcions, actions commented
    //HEI.01 function-GetBatchName added

    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the name of the journal batch of the item journal.', FRA = 'Spécifie le nom de la feuille article.';
        }

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the item journal line.', FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille article.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("Item No.")
        {
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
            ToolTipML = ENU = 'Specifies the dimension value code that the item journal line is linked to.', FRA = 'Spécifie le code section analytique qui est lié à cette ligne feuille article.';
        }
        modify("New Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the new dimension value code that will link to the items on the journal line.', FRA = 'Spécifie le nouveau code section analytique qui lie aux différents éléments de la ligne feuille.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the item journal line is linked to.', FRA = 'Spécifie le code section analytique qui est lié à cette ligne feuille article.';
        }
        modify("New Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the new dimension value code that will link to the items on the journal line.', FRA = 'Spécifie le nouveau code section analytique qui lie aux différents éléments de la ligne feuille.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the inventory location where the item on the journal line will be registered.', FRA = 'Spécifie le code du magasin où l''article de la ligne feuille sera enregistré.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies a bin code for the item.', FRA = 'Spécifie un code emplacement pour l''article.';
            //BC Upgrade PATHAA02>> HEI.01 CODE ADDED FOR LOOKUP TRIGGER
            trigger OnLookup(VAR Text: Text): Boolean
            var
                myInt: Integer;
            begin
                Rec.LookupBin();
            end;
            //BC Upgrade PATHAA02<< HEI.01 CODE ADDED FOR LOOKUP TRIGGER
            //Unsupported feature: Change Lookup on ""Bin Code"(Control 4)". Please convert manually.


            //Unsupported feature: Change TableRelation on ""Bin Code"(Control 4)". Please convert manually.


            //Unsupported feature: Change LookupPageID on ""Bin Code"(Control 4)". Please convert manually.

        }
        modify("New Location Code")
        {
            ToolTipML = ENU = 'Specifies the new location to link the items on this journal line.', FRA = 'Spécifie le nouveau magasin à lier aux éléments de cette ligne feuille.';
        }
        modify("New Bin Code")
        {
            ToolTipML = ENU = 'Specifies the new bin code to link to the items on this journal line.', FRA = 'Spécifie le nouveau code emplacement à lier aux éléments de cette ligne feuille.';

            //Unsupported feature: Change TableRelation on ""New Bin Code"(Control 45)". Please convert manually.

            //BC Upgrade GUNREM01 Added >>
            trigger OnLookup(VAR Text: Text): Boolean
            var
                myInt: Integer;
            begin
                Rec.LookupBin1();
            end;

        }
        modify("Salespers./Purch. Code")
        {
            ToolTipML = ENU = 'Specifies the code for the salesperson or purchaser who is linked to the sale or purchase on the journal line.', FRA = 'Spécifie le code du vendeur ou de l''acheteur lié à la vente ou à l''achat de la ligne feuille.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general business posting group that will be used when you post the entry on the item journal line.', FRA = 'Spécifie le code du groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille article.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general product posting group that will be used for this item when you post the entry on the item journal line.', FRA = 'Spécifie le code groupe comptabilisation produit qui est utilisé pour cet article lorsque vous validez l''écriture de la ligne feuille article.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the number of units of the item to be included on the journal line.', FRA = 'Spécifie le nombre d''unités de l''article à inclure sur la ligne feuille.';

            //Unsupported feature: Change Editable on "Quantity(Control 12)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the code if you have filled in the Sales Unit of Measure field on the item card.', FRA = 'Spécifie le code si vous avez renseigné le champ Unité de vente de la fiche article.';
        }
        modify("Unit Amount")
        {
            ToolTipML = ENU = 'Specifies the price of one unit of the item on the journal line.', FRA = 'Spécifie le prix d''une unité de l''article sur la ligne feuille.';

            //Unsupported feature: Change Editable on ""Unit Amount"(Control 14)". Please convert manually.

        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the line''s net amount.', FRA = 'Spécifie le montant net de la ligne.';

            //Unsupported feature: Change Editable on "Amount(Control 16)". Please convert manually.

        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the item indirect cost.', FRA = 'Spécifie le coût indirect de l''article.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';

            //Unsupported feature: Change Editable on ""Unit Cost"(Control 18)". Please convert manually.

        }
        modify("Applies-to Entry")
        {
            ToolTipML = ENU = 'Specifies if the quantity in the item journal line should be applied to an already-posted document.', FRA = 'Spécifie si la quantité dans la ligne feuille article doit être lettrée dans un document déjà validé.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code that will be inserted on the journal lines.', FRA = 'Spécifie le code motif qui va être inséré dans les lignes feuille.';
        }
        modify("Item Description")
        {
            CaptionML = ENU = 'Item Description', FRA = 'Description article';
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
          ShowNewShortcutDimCode(NewShortcutDimCode);
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
        ShowNewShortcutDimCode(NewShortcutDimCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
          ItemNoOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 27)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Control 37).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WMSManagement.CheckItemJnlLineLocation(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        WMSManagement.CheckItemJnlLineLocation(Rec,xRec);
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1189
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Bin Code"(Control 4)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        LookupBin;//HEI.01
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Bin Code"(Control 4)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        BinCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""New Location Code"(Control 39).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WMSManagement.CheckItemJnlLineLocation(Rec,xRec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        WMSManagement.CheckItemJnlLineLocation(Rec,xRec);
        NewLocationCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""New Bin Code"(Control 45)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        NewBinCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on "Quantity(Control 12)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QuantityOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on "Amount(Control 16)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        AmountOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit Cost"(Control 18)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitCostOnAfterValidate;
        */
        //end;

        //BC UPGRADE PATHAA02-comented-DIT>>
        // addfirst(Control1)
        // {
        //     field("Has Item Charge"; "Has Item Charge")
        //     {
        //         BlankZero = true;
        //     }
        //     field(Collapse; Collapse)
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.37 DDR 19/01/2010
        //             CurrPage.UPDATE(true);
        //             // >>DITW15.00.00.37 DDR
        //         end;
        //     }
        //     field("Line No."; "Line No.")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }
        // addafter("Item No.")
        // {
        //     field("Item Charge No."; "Item Charge No.")
        //     {
        //         Editable = "Item Charge No.Editable";
        //         Enabled = "Item Charge No.Enable";
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             ItemChargeNoOnAfterValidate;
        //         end;
        //     }
        // }
        // addafter("NewShortcutDimCode[8]")
        // {
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        //             if "Responsibility Center" <> xRec."Responsibility Center" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1189
        //         end;
        //     }
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Visible = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1189
        //         end;
        //     }
        // }
        // addafter("Location Code")
        // {
        //     field(Reverse; Reverse)
        //     {
        //         Description = 'DITW19.00.08A BL#10443';
        //         Visible = false;
        //     }
        // }
        // addafter("Bin Code")
        // {
        //     field(LotNo; LotNoText)
        //     {
        //         CaptionML = ENU = 'Lot No.',
        //                     FRA = 'N° lot';
        //         Editable = false;
        //         Style = Attention;
        //         StyleExpr = LotNocolor;
        //         Visible = false;

        //         trigger OnLookup(Text: Text): Boolean;
        //         begin
        //             //<<QXL9.00.001 DAT 23/03/2016
        //             OpenItemTrackingLines(true);
        //             if QualitySetup.READPERMISSION and ("Item Charge No." = '') then begin
        //                 QualityManagement.GetItemJnlLineLotNos2(Rec, LotNo, NewLotNo);
        //                 // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //                 CurrPage.UPDATE;
        //                 // >>DITW19.00.08 DDR BL#10443
        //             end;
        //             //>>QXL9.00.001 DAT 23/03/2016
        //         end;
        //     }
        //     field("New Phys. Location Group Code"; "New Phys. Location Group Code")
        //     {
        //         Visible = false;
        //     }
        // }
        // addafter("New Bin Code")
        // {
        //     field(NewLotNo; NewLotNoText)
        //     {
        //         CaptionML = ENU = 'New Lot No.',
        //                     FRA = 'Nouveau n° lot';
        //         Editable = false;
        //         Style = Attention;
        //         StyleExpr = NewLotNocolor;
        //         Visible = false;

        //         trigger OnLookup(Text: Text): Boolean;
        //         begin
        //             //<<QXL9.00.001 DAT 23/03/2016
        //             OpenItemTrackingLines(true);
        //             if QualitySetup.READPERMISSION and ("Item Charge No." = '') then begin
        //                 QualityManagement.GetItemJnlLineLotNos2(Rec, LotNo, NewLotNo);
        //             end;
        //             //>>QXL9.00.001 DAT 23/03/2016
        //         end;
        //     }
        //     field(NoOfQualityTests; NoOfQualityTests)
        //     {
        //         Caption = 'No. of Quaility Test';
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             //<< QXL10.01 VSC 03/10/2017 NRQ#33079
        //             ShowQualityTests;
        //             //>> QXL10.01 VSC NRQ#33079
        //         end;
        //     }
        // }
        // addafter(Quantity)
        // {
        //     field("Reserved Quantity"; "Reserved Quantity")
        //     {
        //         Description = 'FINXL7.00.001';
        //         Visible = false;
        //     }
        // }
        // addafter(Amount)
        // {
        //     field("Zone Code"; "Zone Code")
        //     {
        //     }
        //  
        //BC Upgrade GUNREM01 Added >>
        // modify("New Bin Code")
        // {
        //     trigger OnLookup(VAR Text: Text): Boolean
        //     var
        //         myInt: Integer;
        //     begin
        //         Rec.LookupBin1();
        //     end;
        // }
        addafter("New Location Code")
        {
            field("New Zone Code"; Rec."New Zone Code FND")
            {
                ApplicationArea = all;
            }
        }
        //BC Upgrade GUNREM01 Added <<
        //     field(RTCTotalLine; GetTotalingLine(1, FIELDNO(Amount), true))
        //     {
        //         AutoFormatType = 1;
        //         BlankZero = true;
        //         CaptionML = ENU = 'Total Amount',
        //                     FRA = 'Montant total';
        //         Description = 'DITW17.10.02B DIT-770 #541';
        //         Editable = false;
        //         QuickEntry = false;
        //     }
        // }
        // addafter("Unit Cost")
        // {
        //     field("Due Tax"; "Due Tax")
        //     {
        //         Visible = false;
        //     }
        //     field("Duty Suspended"; "Duty Suspended")
        //     {
        //         Visible = false;
        //     }
        //     field("Item DTax Group Code"; "Item DTax Group Code")
        //     {
        //         Editable = "Item DTax Group CodeEditable";
        //         Visible = false;
        //     }
        //     field("Company Tax Registration No."; "Company Tax Registration No.")
        //     {
        //         Editable = CompanyTaxRegistrationNoEditab;
        //         Visible = false;
        //     }
        //     field("Strength Spec. Code"; "Strength Spec. Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("AverageStrengthReserv(FIELDNO(""Strength Spec. Value""))"; AverageStrengthReserv(FIELDNO("Strength Spec. Value")))
        //     {
        //         AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
        //         AutoFormatType = 2013664;
        //         CaptionClass = GetTaxSpecCaption(1, FIELDNO("Strength Spec. Value"));
        //         CaptionML = ENU = 'Strength Spec. Value',
        //                     FRA = 'Valeur contrainte spécification';
        //         Editable = false;
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             // <<DITW19.00.08 DDR 20/10/2016 BL#10443
        //             DrilldownReservEntryVS(FIELDNO("Strength Spec. Value"));
        //         end;
        //     }
        //     field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("SumVolStrengthReserv(FIELDNO(""Vol-Strength Spec. Value""))"; SumVolStrengthReserv(FIELDNO("Vol-Strength Spec. Value")))
        //     {
        //         AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
        //         AutoFormatType = 2013664;
        //         CaptionClass = GetTaxSpecCaption(1, FIELDNO("Vol-Strength Spec. Value"));
        //         CaptionML = ENU = 'Vol-Strength Spec. Value',
        //                     FRA = 'Valeur spécification contrainte volume';
        //         Editable = false;
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             // <<DITW19.00.08 DDR 20/10/2016 BL#10443
        //             DrilldownReservEntryVS(FIELDNO("Vol-Strength Spec. Value"));
        //         end;
        //     }
        //     field("AverageStrengthReserv(FIELDNO(""New Strength Spec. Value""))"; AverageStrengthReserv(FIELDNO("New Strength Spec. Value")))
        //     {
        //         AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("New Strength Spec. Value"));
        //         AutoFormatType = 2013664;
        //         CaptionClass = GetTaxSpecCaption(1, FIELDNO("New Strength Spec. Value"));
        //         CaptionML = ENU = 'New Strength Spec. Value',
        //                     FRA = 'Nouvelle valeur spécification contrainte';
        //         Editable = false;
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             // <<DITW19.00.08 DDR 20/10/2016 BL#10443
        //             DrilldownReservEntryVS(FIELDNO("New Strength Spec. Value"));
        //         end;
        //     }
        //     field("SumVolStrengthReserv(FIELDNO(""New Vol-Strength Spec. Value""))"; SumVolStrengthReserv(FIELDNO("New Vol-Strength Spec. Value")))
        //     {
        //         AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("New Vol-Strength Spec. Value"));
        //         AutoFormatType = 2013664;
        //         CaptionClass = GetTaxSpecCaption(1, FIELDNO("New Vol-Strength Spec. Value"));
        //         CaptionML = ENU = 'New Vol-Strength Spec. Value',
        //                     FRA = 'Nouvelle valeur spécification contrainte volume';
        //         Editable = false;
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             // <<DITW19.00.08 DDR 20/10/2016 BL#10443
        //             DrilldownReservEntryVS(FIELDNO("New Vol-Strength Spec. Value"));
        //         end;
        //     }
        //     field("Unit Volume HL"; "Unit Volume HL")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Quantity (Brewing Base)"; "Quantity (Brewing Base)")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Tariff No."; "Tariff No.")
        //     {
        //         Editable = "Tariff No.Editable";
        //         Visible = false;
        //     }
        //     field("AAD No. Series"; "AAD No. Series")
        //     {
        //         Editable = "AAD No. SeriesEditable";
        //         Visible = false;
        //     }
        //     field("AAD No."; "AAD No.")
        //     {
        //         Editable = "AAD No.Editable";
        //         Visible = false;
        //     }
        // }
        // addafter("Reason Code")
        // {
        //     field("Scrap Code"; "Scrap Code")
        //     {
        //         Visible = false;

        //         trigger OnAssistEdit();
        //         begin
        //             // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //             OpenLossBreakdownLines;
        //             CurrPage.UPDATE;
        //             // >>DITW19.00.08 DDR BL#10443
        //         end;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //             if "Line No." <> 0 then
        //                 CurrPage.UPDATE(true);
        //         end;
        //     }
        //     field("Scrap Quantity"; "Scrap Quantity")
        //     {
        //         Visible = false;

        //         trigger OnAssistEdit();
        //         begin
        //             // <<DITW19.00.08 DDR 09/12/2016 BL#10443
        //             OpenLossBreakdownLines;
        //             CurrPage.UPDATE;
        //             // >>DITW19.00.08 DDR BL#10443
        //         end;
        //     }
        //     field("Exist Loss Breakdown"; "Exist Loss Breakdown")
        //     {
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //             OpenLossBreakdownLines;
        //             CurrPage.UPDATE;
        //             // >>DITW19.00.08 DDR BL#10443
        //         end;
        //     }
        //     field("Work Order No."; "Work Order No.")
        //     {
        //         Description = 'DIT-715 #457';
        //         Visible = false;
        //     }
        // }
        //BC UPGRADE PATHAA02-comented-DIT<<

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
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
        }
        modify("Bin Contents")
        {
            CaptionML = ENU = 'Bin Contents', FRA = 'Contenu emplacement';
        }
        modify("&Item")
        {
            CaptionML = ENU = '&Item', FRA = 'Arti&cle';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
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
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("E&xplode BOM")
        {
            CaptionML = ENU = 'E&xplode BOM', FRA = '&Eclater nomenclature';
        }
        modify("Get Bin Content")
        {
            CaptionML = ENU = 'Get Bin Content', FRA = 'Extraire contenu emplacement';
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
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }


        //Unsupported feature: CodeModification on "Post(Action 34).OnAction". Please convert manually.

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

        //BC UPGRADE PATHAA02-comented-DIT>>
        // addfirst("&Line")
        // {
        //     action("New Line")
        //     {
        //         CaptionML = ENU = 'New Line',
        //                     FRA = 'Nouvelle ligne';
        //         Description = 'DITW16.00.00.37 DIT-715 #1';
        //         Image = NewDocument;
        //         ShortCutKey = 'Ctrl+F3';
        //         Visible = false;

        //         trigger OnAction();
        //         var
        //             ItemJournalLine: Record "Item Journal Line";
        //         begin
        //             // <<DITW16.00.00.37 DIT-715 #1
        //             if FINDLAST then;

        //             ItemJournalLine := Rec;

        //             INIT;
        //             SetUpNewLine(ItemJournalLine);
        //             CLEAR(ShortcutDimCode);
        //             "Line No." := "Line No." + 10000;
        //             INSERT(true);

        //             CurrPage.UPDATE(false);
        //             // <<DITW16.00.00.37 DIT-715 #1
        //         end;
        //     }
        //     separator(Separator1100083204)
        //     {
        //     }
        // }
        // addafter(Dimensions)
        // {
        //     separator(Separator1100283033)
        //     {
        //     }
        // }
        // addafter("Item &Tracking Lines")
        // {
        //     action("SSCC Tracking Lines")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Lines',
        //                     FRA = 'Lignes Traçabilité SSCC';
        //         Description = '#1429';
        //         Image = ItemTrackingLines;

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 22/12/2011 #1429 - 02/02/2012 #1429
        //             OpenSSCCTrackingLines(true);
        //         end;
        //     }
        // }
        // addafter("Bin Contents")
        // {
        //     separator(Separator2035090)
        //     {
        //     }
        //     action("Quality Tests")
        //     {
        //         CaptionML = ENU = 'Quality Tests',
        //                     FRA = 'Tests qualité';
        //         Description = 'QXL9.00.001';
        //         Image = TaskQualityMeasure;
        //         RunObject = Page "Quality Test List";
        //         RunPageLink = "Source Type" = CONST(83),
        //                       "Source Subtype" = FIELD("Entry Type"),
        //                       "Source ID" = FIELD("Journal Template Name"),
        //                       "Source Batch Name" = FIELD("Journal Batch Name"),
        //                       "Source Ref. No." = FIELD("Line No."),
        //                       "Item No." = FIELD("Item No.");
        //     }
        //     action("&Losses")
        //     {
        //         CaptionML = ENU = '&Losses',
        //                     FRA = '&Pretes';
        //         Image = GainLossEntries;

        //         trigger OnAction();
        //         begin
        //             // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //             OpenLossBreakdownLines;
        //             CurrPage.UPDATE;
        //             // >>DITW19.00.08 DDR BL#10443
        //         end;
        //     }
        // }
        // addfirst(ActionContainer1900000004)
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
        //             ExpandLines := false;
        //             CurrPage.UPDATE(true);
        //             // >>DITW17.10.03 DDR DIT-770 #541
        //         end;
        //     }
        // }
        // addafter("Get Bin Content")
        // {
        //     separator(Separator1100083008)
        //     {
        //     }
        //     action("&Insert Item Charges")
        //     {
        //         CaptionML = ENU = '&Insert Item Charges',
        //                     FRA = '&Inserer Frais Annexes';
        //         Image = TaxSetup;
        //         ShortCutKey = 'Ctrl+Y';

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.24 DDR 25/09/2008
        //             InsertExtendedCharges(true);
        //         end;
        //     }
        //     separator(Separator2036301)
        //     {
        //     }
        //     action("Calculate Production Picking")
        //     {
        //         CaptionML = ENU = 'Calculate Production Picking',
        //                     FRA = 'Calculer enlèvements production';
        //         Description = 'MANXL7.00.001';
        //         Image = Calculate;

        //         trigger OnAction();
        //         var
        //             lrepCalcProdPicking: Report "Calculate Production Picking";
        //         begin
        //             //<<MANXL7.00.001 DAT 26/02/2014 #7
        //             lrepCalcProdPicking.InitializeItemJournalLine(Rec);
        //             lrepCalcProdPicking.RUNMODAL;
        //             CurrPage.UPDATE(false);
        //             //>>MANXL7.00.001 DAT 26/02/2014 #7
        //         end;
        //     }
        //     action("Calculate Item Strength Revaluation")
        //     {
        //         CaptionML = ENU = 'Calculate Item Strength Revaluation',
        //                     FRA = 'Calculer contrainte article Réévaluation';
        //         Image = Calculate;

        //         trigger OnAction();
        //         var
        //             CalcItemStrengthReclass: Report "Calculate ItemStrength Reclass";
        //         begin
        //             // <<DITW19.00.08 DDR 14/11/2016 BL#10443
        //             CalcItemStrengthReclass.InitializeItemJournalLine(Rec);
        //             CalcItemStrengthReclass.RUNMODAL;
        //             CurrPage.UPDATE(false);
        //         end;
        //     }
        //}//BC UPGRADE PATHAA02-comented-DIT<<
    }


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU="1,2,3,New ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU="1,2,3,New ";FRA="1,2,3,Nouveau ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU="1,2,4,New ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU="1,2,4,New ";FRA="1,2,4,Nouveau ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU="1,2,5,New ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU="1,2,5,New ";FRA="1,2,5,Nouveau ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU="1,2,6,New ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU="1,2,6,New ";FRA="1,2,6,Nouveau ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU="1,2,7,New ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU="1,2,7,New ";FRA="1,2,7,Nouveau ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU="1,2,8,New ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU="1,2,8,New ";FRA="1,2,8,Nouveau ";
    //Variable type has not been exported.

    //BC UPGRADE PATHAA02-comented-DIT>>
    // var
    // xRecRef: RecordRef;
    // QualitySetup: Record "Quality Setup";
    // QualityManagement: Codeunit "Quality Management";
    // LotNo: Code[20];
    // NewLotNo: Code[20];
    // NewSessionID: Guid;
    // ClearGUID: Guid;
    // 
    // LotNocolor: Boolean;
    // 
    // LotNoText: Text[1024];
    // 
    // NewLotNocolor: Boolean;
    // 
    // NewLotNoText: Text[1024];
    // 
    // "Item No.Editable": Boolean;
    // 
    // "Item Charge No.Editable": Boolean;
    // 
    // QuantityEditable: Boolean;
    // 
    // "Unit AmountEditable": Boolean;
    // 
    // AmountEditable: Boolean;
    // 
    // "Unit CostEditable": Boolean;
    // 
    // "AAD No.Editable": Boolean;
    // 
    // "AAD No. SeriesEditable": Boolean;
    // 
    // "Item DTax Group CodeEditable": Boolean;
    // 
    // CompanyTaxRegistrationNoEditab: Boolean;
    // 
    // "Tariff No.Editable": Boolean;
    // 
    // "Item Charge No.Enable": Boolean;
    // 
    // ExpandLines: Boolean;
    // 
    // ShowButtonsCE: Boolean;
    // IndentLine: Integer;
    // UserSetupMgt: Codeunit "User Setup Management";
    // 
    // GlobalTax1ValueEditable: Boolean;
    // 
    // GlobalTax2ValueEditable: Boolean;
    //BC UPGRADE PATHAA02-comented-DIT<<



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
    ShowNewShortcutDimCode(NewShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    ShowShortcutDimCode(ShortcutDimCode);
    ShowNewShortcutDimCode(NewShortcutDimCode);
    //<<QXL9.00.001 DAT 23/03/2016
    if QualitySetup.READPERMISSION and ("Item Charge No." = '') then begin
      QualityManagement.GetItemJnlLineLotNo2(Rec,LotNo,NewLotNo);
      "Session ID" := NewSessionID;
    end else begin
      LotNo := '';
      NewLotNo := '';
    end;

    LotNoText := FORMAT(LotNo);
    LotNoTextOnFormat(LotNoText);
    NewLotNoText := FORMAT(NewLotNo);
    NewLotNoTextOnFormat(NewLotNoText);
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    COMMIT;
    if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
      exit(false);
    ReserveItemJnlLine.DeleteLine(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
    //COMMIT;
    //IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
    //  EXIT(FALSE);
    //ReserveItemJnlLine.DeleteLine(Rec);
    // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    exit(TriggerOnDeleteRecord());
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    "Item Charge No.Enable" := true;
    "Tariff No.Editable" := true;
    CompanyTaxRegistrationNoEditab := true;
    "Item DTax Group CodeEditable" := true;
    "AAD No.Editable" := true;
    "Unit CostEditable" := true;
    AmountEditable := true;
    "Unit AmountEditable" := true;
    QuantityEditable := true;
    "Item Charge No.Editable" := true;
    "Item No.Editable" := true;
    // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
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
    CLEAR(NewShortcutDimCode);
    "Entry Type" := "Entry Type"::Transfer;
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
    // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    //SetUpNewLine(xRec);
    //CLEAR(ShortcutDimCode);
    //CLEAR(NewShortcutDimCode);
    //"Entry Type" := "Entry Type"::Transfer;
    // Move to function TriggerOnNewRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    TriggerOnNewRecord(BelowxRec);
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
    ItemJnlMgt.TemplateSelection(PAGE::"Item Reclass. Journal",1,false,Rec,JnlSelected);
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
      ItemJnlMgt.TemplateSelection(PAGE::"Item Reclass. Journal",1,false,Rec,JnlSelected);
      if not JnlSelected then
        ERROR('');
      ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
    // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
    end;
    // >>DITW16.00.00.40 DDR DIT-715 #194

    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189-DITW110.00.12 MSF 04/05/2018 NRQ#55899
    FILTERGROUP(2);
    SETFILTER("Responsibility Center",UserSetupMgt.GetInventoryTextFilter);
    FILTERGROUP(0);
    // >>DITW18.00.06 DDR DIT-770 #1189-DITW110.00.12 MSF 04/05/2018 NRQ#55899

    // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    if "Session ID" = ClearGUID then
      NewSessionID := CREATEGUID;
    // >>DITW15.00.00.35 PRODW14.00.00.08.14
    // <<DITW17.00.01 DDR 12/03/2013 DIT-770 #001
    if "Journal Template Name" = '' then
      "Journal Template Name" := GETRANGEMAX("Journal Template Name");
    if "Journal Batch Name" = '' then
      "Journal Batch Name" := GETRANGEMAX("Journal Batch Name");
    // >>DITW17.00.01 DDR DIT-770 #001
    // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    if not ISEMPTY then
      FINDLAST;
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := false;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;

    //BC UPGRADE PATHAA02-comented-DIT>>
    // procedure InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if InsertChargeLines(FromHeader) then
    //         CurrPage.UPDATE(true);
    // end;

    // local procedure UpdateFields();
    // var
    //     CollapsedLine: Boolean;
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008 - DITW15.00.00.38 DDR 16/07/2010 #1194
    //     // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    //     CollapsedLine := not ExpandLines;
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     "Item No.Editable" := FormEditableField(FIELDNO("Item No."));
    //     // <<DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 - DITW17.00.01 DDR 10/12/2012 DIT-770 #001
    //     "Item Charge No.Editable" := false;
    //     "Item Charge No.Enable" := false;
    //     // >>DITW16.00.00.38 DDR DIT-715 #1
    //     QuantityEditable := FormEditableField(FIELDNO(Quantity));
    //     "Unit AmountEditable" := FormEditableField(FIELDNO("Unit Amount")) and not CollapsedLine;
    //     AmountEditable := FormEditableField(FIELDNO(Amount)) and not CollapsedLine;
    //     "Unit CostEditable" := FormEditableField(FIELDNO("Unit Cost")) and not CollapsedLine;
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

    // procedure TriggerOnDeleteRecord(): Boolean;
    // var
    //     ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    // begin
    //     // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
    //     COMMIT;
    //     if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
    //         exit(false);
    //     // <<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION then begin
    //         if not QualityManagement.DeleteItemJnlLineConfirm(Rec) then
    //             exit(false);
    //     end;
    //     // >>QXL9.00.001 DAT 23/03/2016
    //     ReserveItemJnlLine.DeleteLine(Rec);
    //     // <<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION then
    //         QualityManagement.DeleteItemJnlLine(Rec);
    //     // >>QXL9.00.001 DAT 23/03/2016

    //     exit(true);
    // end;

    // procedure TriggerOnNewRecord(BelowxRec: Boolean): Boolean;
    // begin
    //     // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    //     INIT;
    //     // >>DITW16.00.00.38 DDR DIT-715 #50
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     LotNoText := '';
    //     // >>DITW19.00.08 DDR BL#10443
    //     // <<DITW15.00.00.35 DDR 19/10/2009
    //     FILTERGROUP(2);
    //     if GETFILTER("Journal Template Name") <> '' then
    //         "Journal Template Name" := GETFILTER("Journal Template Name");
    //     if GETFILTER("Journal Batch Name") <> '' then
    //         "Journal Batch Name" := GETFILTER("Journal Batch Name");
    //     FILTERGROUP(0);
    //     // >>DITW15.00.00.35 DDR

    //     SetUpNewLine(xRec);
    //     CLEAR(ShortcutDimCode);
    //     CLEAR(NewShortcutDimCode);
    //     "Entry Type" := "Entry Type"::Transfer;
    //     // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //     LotNo := '';
    //     NewLotNo := '';
    //     "Session ID" := NewSessionID;
    //     // >>DITW15.00.00.35 PRODW14.00.00.08.14

    //     // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    //     exit(true);
    //     // >>DITW16.00.00.38 DDR DIT-715 #50
    // end;

    // local procedure PostingDateOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if "Line No." <> 0 then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure ItemNoOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure ItemChargeNoOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure VariantCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if "Line No." <> 0 then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure LocationCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if "Line No." <> 0 then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure BinCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if "Line No." <> 0 then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure NewLocationCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if "Line No." <> 0 then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure NewBinCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if "Line No." <> 0 then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure QuantityOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if "Line No." <> 0 then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure AmountOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if xRec.Amount <> Amount then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure UnitCostOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.24 DDR 25/09/2008
    //     if xRec."Unit Cost" <> "Unit Cost" then
    //         CurrPage.UPDATE(true);
    //     // >>DITW15.00.00.24 DDR
    // end;

    // local procedure LotNoTextOnFormat(var Text: Text[1024]);
    // begin
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     if ((Quantity = 0) and ("Output Quantity" = 0)) or ("Item Charge No." <> '') or ("Item No." = '') then begin
    //         LotNocolor := false;
    //         Text := '';
    //         exit;
    //     end;
    //     // >>DITW19.00.08 DDR BL#10443
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION and ("Item Charge No." = '') then begin
    //         LotNocolor := QualityManagement.IsRequired(Text);
    //     end;
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // local procedure NewLotNoTextOnFormat(var Text: Text[1024]);
    // begin
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     if ((Quantity = 0) and ("Output Quantity" = 0)) or ("Item Charge No." <> '') or ("Item No." = '') then begin
    //         LotNocolor := false;
    //         Text := '';
    //         exit;
    //     end;
    //     // >>DITW19.00.08 DDR BL#10443
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION and ("Item Charge No." = '') then begin
    //         NewLotNocolor := QualityManagement.IsRequired(Text);
    //     end;
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;
    //BC UPGRADE PATHAA02-comented-DIT<<

    //BC UPGRADE PATHAA02->>
    procedure GetBatchName(TemplateName: Code[10]; BatchName: Code[10]);
    begin
        //HEI.01>>
        Rec."Journal Template Name" := TemplateName;
        Rec."Journal Batch Name" := BatchName;
        //HEI.01<<
    end;
    //BC UPGRADE PATHAA02<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

