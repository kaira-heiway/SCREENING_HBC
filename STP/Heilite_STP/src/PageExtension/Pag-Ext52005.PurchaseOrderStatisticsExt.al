pageextension 52005 PurchaseOrderStatisticsExt extends "Purchase Order Statistics"
{
    // version NAVW110.0,DITW110.00.08
    /* 
     # New variables : TotalAmount3 (decinmal) and WHTManagement (codeunit)
  # New field shown in the page designer: WHT Amount (variable TotalAmount3)
  # RefreshOnAfterGetRecord modified : add procedure to calculate TotalAmount3
HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
  # New Field 'CAD Amount' created
  # Code added on 'OnOpenPage' and on 'OnAfterGetRecord' triggers
     */
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in fields.
    // 2. Remove Drink-IT Group and Functions(SetVATSpecificationCharge,DrillDownChargeLines,SetVatChargeTextHeader,LCaptionClassTranslate,TotalPurchLineCharge1441LineAm,VATAmountCharge1441OnActivate,TotalAmountCharge21441OnActiva,TotalPurchLineCharge1442LineAm,VATAmountCharge1442OnActivate,TotalAmountCharge21442OnActiva,TotalPurchLineCharge1443LineAm,VATAmountCharge1443OnActivate,TotalAmountCharge21443OnActiva,TotalPurchLineCharge1444LineAm,VATAmountCharge1444OnActivate,TotalAmountCharge21444OnActiva,TotalAmountCharge21446OnActiva,VATAmountCharge1446OnActivate,TotalPurchLineCharge1446LineAm)
    // 3. we have some customize code on function RefreshOnAfterGetRecord. Add the code in all placess where the function is call because in custom code global variable assign some values and that variable add in the page as field
    /* The UpdateHeaderInfo function, which is a base function, contains code related to the CAD amount. In this function, the value is being assigned to a global variable CADAmount, and this variable is being used at the page level. */
    /* However, this approach is not possible through an event subscriber. Therefore, we created a separate function named UpdateHeaderInfoCadAmount. The CAD amount logic has been moved into this new function. */
    /* This function was being used in the OnDrillDown trigger of two fields(NoOfVATLines_GeneralNoOfVATLines_Invoicing), with parameter 1 and 2. I have now manually called the function there with the respective parameters. */

    // BC Upgrade BHARDA11 <<
    layout
    {

        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify(LineAmountGeneral)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
            CaptionClass = GetCaptionClass(Text002, FALSE);
        }
        modify("InvDiscountAmount_General")
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
        }
        modify("Total_General")
        {
            CaptionML = ENU = 'Total', FRA = 'Total';
            CaptionClass = GetCaptionClass(Text001, FALSE);
        }
        modify("VATAmount[1]")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("TotalInclVAT_General")
        {
            CaptionML = ENU = 'Total Incl. VAT', FRA = 'Total TTC';
            CaptionClass = GetCaptionClass(Text001, TRUE);
        }
        modify("TotalPurchLineLCY[1].Amount")
        {
            CaptionML = ENU = 'Purchase (LCY)', FRA = 'Achats DS';
        }
        modify("Quantity_General")
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("TotalPurchLine[1].""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
        }
        modify("TotalPurchLine[1].""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify("TotalPurchLine[1].""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
        }
        modify("TotalPurchLine[1].""Unit Volume""")
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
        }
        modify("NoOfVATLines_General")
        {

            //Unsupported feature: Change DrillDown on ""NoOfVATLines_General"(Control 40)". Please convert manually.

            CaptionML = ENU = 'No. of VAT Lines', FRA = 'Nombre de lignes TVA';
            // BC Upgrade BHARAD11 >>
            trigger OnDrillDown()
            begin
                VATLinesForm.GetTempVATAmountLine(TempVATAmountLine1);
                UpdateHeaderInfoCADAmount(1, TempVATAmountLine1);

            end;
            // BC Upgrade BHARAD11 <<
        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }
        modify("TotalPurchLine[2].""Line Amount""")
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
            CaptionClass = GetCaptionClass(Text002, FALSE);
        }
        // BC Upgrade BHARDA11 >> ----Not Found
        // modify("TotalPurchLine[2].""Inv. Discount Amount""")
        // {
        //     CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
        // }
        // BC Upgrade BHARDA11 >> ----Not Found
        modify("Total_Invoicing")
        {
            CaptionML = ENU = 'Total', FRA = 'Total';
            CaptionClass = GetCaptionClass(Text001, FALSE);
        }
        modify("VATAmount_Invoicing")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("TotalInclVAT_Invoicing")
        {
            CaptionML = ENU = 'Total Incl. VAT', FRA = 'Total TTC';
            CaptionClass = GetCaptionClass(Text001, TRUE);
        }
        modify("TotalPurchLineLCY[2].Amount")
        {
            CaptionML = ENU = 'Purchase (LCY)', FRA = 'Achats DS';
        }
        modify("Quantity_Invoicing")
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("TotalPurchLine[2].""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
        }
        modify("TotalPurchLine[2].""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify("TotalPurchLine[2].""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
        }
        modify("TotalPurchLine[2].""Unit Volume""")
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
        }
        modify("NoOfVATLines_Invoicing")
        {

            //Unsupported feature: Change DrillDown on ""NoOfVATLines_Invoicing"(Control 64)". Please convert manually.

            CaptionML = ENU = 'No. of VAT Lines', FRA = 'Nombre de lignes TVA';
            // BC Upgrade BHARDA11 >> This code was originally written inside a function(RefreshOnAfterGetRecord). In Business Central, we cannot modify the base application code without using an event subscriber. Additionally, this logic was using a global variable, which cannot be accessed directly from a codeunit. Therefore, we implemented this code at all the places where the function RefreshOnAfterGetRecord was being called.
            trigger OnDrillDown()
            var

            begin
                //>>HEI.01 FDD-XXXXXX001
                TotalAmount3 := WHTManagement.StatisticsCalcWHTAmount(39, Rec."No.", Rec."Document Type".AsInteger());
                //<<HEI.01 FDD-XXXXXX001
                // BC Upgrade BHARDA11 >>  --- this code is under the function RefreshOnAfterGetRecord
                //HEI.02>>
                if EnableCAD then begin
                    PurchaseLine.RESET();
                    PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseLine.SETRANGE("Document No.", Rec."No.");
                    if PurchaseLine.FINDSET() then
                        repeat
                            CADAmount += PurchaseLine."CAD Amount FND";
                        until PurchaseLine.NEXT() = 0;
                end;
                //HEI.02<<
                // BC Upgrade BHARDA11 <<  --- this code is under the function RefreshOnAfterGetRecord
                // BC Upgrade BHARDA11 >>
                VATLinesForm.GetTempVATAmountLine(TempVATAmountLine2);
                UpdateHeaderInfoCADAmount(2, TempVATAmountLine2);
                // BC Upgrade BHARDA11 <<
            end;
            // BC Upgrade BHARDA11 <<  This code was originally written inside a function(RefreshOnAfterGetRecord). In Business Central, we cannot modify the base application code without using an event subscriber. Additionally, this logic was using a global variable, which cannot be accessed directly from a codeunit. Therefore, we implemented this code at all the places where the function RefreshOnAfterGetRecord was being called.
        }
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }
        modify("TotalPurchLine[3].""Line Amount""")
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
            CaptionClass = GetCaptionClass(Text002, FALSE);
        }
        modify("TotalPurchLine[3].""Inv. Discount Amount""")
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
        }
        modify("TotalAmount1[3]")
        {
            CaptionML = ENU = 'Total', FRA = 'Total';
            CaptionClass = GetCaptionClass(Text001, FALSE);
        }
        modify("VATAmount[3]")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("TotalInclVAT_Shipping")
        {
            CaptionML = ENU = 'Total Incl. VAT', FRA = 'Total TTC';
            CaptionClass = GetCaptionClass(Text001, TRUE);
        }
        modify("TotalPurchLineLCY[3].Amount")
        {
            CaptionML = ENU = 'Purchase (LCY)', FRA = 'Achats DS';
        }
        modify("Quantity_Shipping")
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("TotalPurchLine[3].""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
        }
        modify("TotalPurchLine[3].""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify("TotalPurchLine[3].""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
        }
        modify("TotalPurchLine[3].""Unit Volume""")
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
        }
        modify("TempVATAmountLine3.COUNT")
        {

            //Unsupported feature: Change DrillDown on ""TempVATAmountLine3.COUNT"(Control 88)". Please convert manually.

            CaptionML = ENU = 'No. of VAT Lines', FRA = 'Nombre de lignes TVA';
        }
        modify(Prepayment)
        {
            CaptionML = ENU = 'Prepayment', FRA = 'Acompte';
        }
        modify(PrepmtTotalAmount)
        {
            CaptionClass = GetCaptionClass(Text006, FALSE);
        }
        modify(PrepmtVATAmount)
        {
            CaptionML = ENU = 'Prepayment Amount Invoiced', FRA = 'Montant acompte facturé';
        }
        modify(PrepmtTotalAmount2)
        {
            CaptionML = ENU = 'Prepmt. Amount Invoiced', FRA = 'Montant acompte facturé';
            CaptionClass = GetCaptionClass(Text006, TRUE);
        }
        modify("TotalPurchLine[1].""Prepmt. Amt. Inv.""")
        {
            CaptionClass = GetCaptionClass(Text007, FALSE);
        }
        modify(PrepmtInvPct)
        {
            CaptionML = ENU = 'Invoiced % of Prepayment Amt.', FRA = '% facturé du montant acompte';
            ToolTipML = ENU = 'Specifies the invoiced percentage of the prepayment amount.', FRA = 'Spécifie le pourcentage facturé du montant acompte.';
        }
        modify("TotalPurchLine[1].""Prepmt Amt Deducted""")
        {
            CaptionClass = GetCaptionClass(Text008, FALSE);
        }
        modify(PrepmtDeductedPct)
        {
            CaptionML = ENU = 'Deducted % of Prepayment Amt. to Deduct', FRA = '% déduit du montant acompte à déduire';
            ToolTipML = ENU = 'Specifies the deducted percentage of the prepayment amount to deduct.', FRA = 'Spécifie le pourcentage déduit du montant acompte à déduire.';
        }
        modify("TotalPurchLine[1].""Prepmt Amt to Deduct""")
        {
            CaptionClass = GetCaptionClass(Text009, FALSE);
        }
        modify("TempVATAmountLine4.COUNT")
        {

            //Unsupported feature: Change DrillDown on ""TempVATAmountLine4.COUNT"(Control 90)". Please convert manually.

            CaptionML = ENU = 'No. of VAT Lines', FRA = 'Nombre de lignes TVA';
        }
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
        }
        modify("Vend.""Balance (LCY)""")
        {
            CaptionML = ENU = 'Balance (LCY)', FRA = 'Solde DS';
        }

        addafter("VATAmount[1]")
        {
            // BC Upgrade BHARDA11 >> 
            field(CADAmount; CADAmount)
            {
                ApplicationArea = aLL;
                Caption = 'CAD Amount';
                Editable = false;
                Visible = EnableCAD;
            }
            // BC Upgrade BHARDA11 << 

        }
        addafter("TotalInclVAT_General")
        {
            field("<TotalAmount3>"; TotalAmount3)
            {
                ApplicationArea = aLL;
                CaptionML = ENU = 'WHT Amount',
                            ESP = 'Importe WHT',
                            FRA = 'Montant WHT';
                Editable = false;
            }
        }
        // BC Upgrade BHARDA11 >> ----drink-IT Group
        // addafter(Vendor)
        // {
        //     group("Drink-It")
        //     {
        //         CaptionML = ENU='Drink-It',
        //                     FRA='Drink-It';
        //         fixed()
        //         {
        //             group(" ")
        //             {
        //                 Caption = '" "';
        //                 field(LCaptionClassTranslate(Text002,FALSE);LCaptionClassTranslate(Text002,FALSE))
        //                 {
        //                     Editable = false;
        //                 }
        //                 field(TotalPurchLineCharge[1,1]."Line Amount";TotalPurchLineCharge[1,1]."Line Amount")
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     CaptionML = ENU='Tax',
        //                                 FRA='Taxes';
        //                     Editable = false;

        //                     trigger OnDrillDown();
        //                     begin
        //                         DrillDownChargeLines(ActiveTab::General,PurchHeader."Item Charge Type Filter"::Tax,FIELDNO(Amount));
        //                     end;
        //                 }
        //                 field(TotalPurchLineCharge[1,2]."Line Amount";TotalPurchLineCharge[1,2]."Line Amount")
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     CaptionML = ENU='Deposit',
        //                                 FRA='Consigne';
        //                     Editable = false;

        //                     trigger OnDrillDown();
        //                     begin
        //                         DrillDownChargeLines(ActiveTab::General,PurchHeader."Item Charge Type Filter"::Deposit,FIELDNO(Amount));
        //                     end;
        //                 }
        //                 field(TotalPurchLineCharge[1,3]."Line Amount";TotalPurchLineCharge[1,3]."Line Amount")
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     CaptionML = ENU='Discount/ Charge',
        //                                 FRA='Remise / Frais';
        //                     Editable = false;

        //                     trigger OnDrillDown();
        //                     begin
        //                         DrillDownChargeLines(ActiveTab::General,PurchHeader."Item Charge Type Filter"::Discount,FIELDNO(Amount));
        //                     end;
        //                 }
        //                 field(TotalPurchLineCharge[1,4]."Line Amount";TotalPurchLineCharge[1,4]."Line Amount")
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     CaptionML = ENU='Promotion',
        //                                 FRA='Promotion';
        //                     Editable = false;

        //                     trigger OnDrillDown();
        //                     begin
        //                         DrillDownChargeLines(ActiveTab::General,PurchHeader."Item Charge Type Filter"::Promotion,FIELDNO(Amount));
        //                     end;
        //                 }
        //                 field(TotalPurchLineCharge[1,6]."Line Amount";TotalPurchLineCharge[1,6]."Line Amount")
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     CaptionML = ENU='Shipping Cost',
        //                                 FRA='Coût transport';
        //                     Editable = false;

        //                     trigger OnDrillDown();
        //                     begin
        //                         DrillDownChargeLines(ActiveTab::General,PurchHeader."Item Charge Type Filter"::ShippingCost,FIELDNO(Amount));
        //                     end;
        //                 }
        //             }
        //             group(" ")
        //             {
        //                 Caption = '" "';
        //                 field(VATAmountTxt;Text010)
        //                 {
        //                     Editable = false;
        //                     Visible = VATAmountTxtVisible;
        //                 }
        //                 field(VATAmountCharge[1,1];VATAmountCharge[1,1])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //                 field(VATAmountCharge[1,2];VATAmountCharge[1,2])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //                 field(VATAmountCharge[1,3];VATAmountCharge[1,3])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //                 field(VATAmountCharge[1,4];VATAmountCharge[1,4])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //                 field(VATAmountCharge[1,6];VATAmountCharge[1,6])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //             }
        //             group(" ")
        //             {
        //                 Caption = '" "';
        //                 field(LCaptionClassTranslate(Text001,TRUE);LCaptionClassTranslate(Text001,TRUE))
        //                 {
        //                     Editable = false;
        //                 }
        //                 field(TotalAmountCharge2[1,1];TotalAmountCharge2[1,1])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //                 field(TotalAmountCharge2[1,2];TotalAmountCharge2[1,2])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //                 field(TotalAmountCharge2[1,3];TotalAmountCharge2[1,3])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //                 field(TotalAmountCharge2[1,4];TotalAmountCharge2[1,4])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //                 field(TotalAmountCharge2[1,6];TotalAmountCharge2[1,6])
        //                 {
        //                     AutoFormatExpression = "Currency Code";
        //                     AutoFormatType = 1;
        //                     Editable = false;
        //                 }
        //             }
        //         }
        //     }
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Group
    }

    var

        // PrevRec: Record "Purchase Header" temporary;
        // PurchHeader: Record "Purchase Header";
        // TempVATAmountLineCharge1: Record "VAT Amount Line" temporary;
        // TempVATAmountLineCharge2: Record "VAT Amount Line" temporary;
        // TempVATAmountLineCharge3: Record "VAT Amount Line" temporary;
        // TempVATAmountLineCharge4: Record "VAT Amount Line" temporary;
        // TempVATAmountLineCharge6: Record "VAT Amount Line" temporary;
        // TotalPurchLineCharge: array[3, 6] of Record "Purchase Line";
        // TotalPurchLineChargeLCY: array[3, 6] of Record "Purchase Line";
        // VATAmountCharge: array[3, 6] of Decimal;
        // VATAmountTextCharge: array[3, 6] of Text[30];
        // VATAmountTextChargeHeader: Text[30];
        // TotalAmountCharge1: array[3, 6] of Decimal;
        // TotalAmountCharge2: array[3, 6] of Decimal;
        // j: Integer;
        // ActiveSubTab: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        // Text010: TextConst ENU = 'VAT Amount', FRA = 'Montant TVA';
        // [InDataSet]
        // VATAmountTxtVisible: Boolean;
        TotalAmount3: Integer;
        WHTManagement: Codeunit WHTManagement;

        Text001: Label 'Total';
        Text002: Label 'Amount';

        Text006: LABEL 'Prepmt. Amount';
        Text007: Label 'Prepmt. Amt. Invoiced';
        Text008: Label 'Prepmt. Amt. Deducted';
        Text009: Label 'Prepmt. Amt. to Deduct';
        PurchaseLine: Record "Purchase Line";
        EnableCAD: Boolean;
        CADAmount: Decimal;
        GeneralLedgerSetup: Record "General Ledger Setup";
        VATLinesForm: Page "VAT Amount Lines";
        TempVATAmountLine1, TempVATAmountLine2 : Record "VAT Amount Line" temporary;
    // BC Upgrade BHARDA11 >> ----Drink-IT Functions(SetVATSpecificationCharge,DrillDownChargeLines,SetVatChargeTextHeader,LCaptionClassTranslate,TotalPurchLineCharge1441LineAm,VATAmountCharge1441OnActivate,TotalAmountCharge21441OnActiva,TotalPurchLineCharge1442LineAm,VATAmountCharge1442OnActivate,TotalAmountCharge21442OnActiva,TotalPurchLineCharge1443LineAm,VATAmountCharge1443OnActivate,TotalAmountCharge21443OnActiva,TotalPurchLineCharge1444LineAm,VATAmountCharge1444OnActivate,TotalAmountCharge21444OnActiva,TotalAmountCharge21446OnActiva,VATAmountCharge1446OnActivate,TotalPurchLineCharge1446LineAm)

    // local procedure SetVATSpecificationCharge(QtyType: Option General,Invoicing,Shipping,Prepayment; ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost");
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     //IF NOT SubformIsReady THEN
    //     //  EXIT;

    //     CurrPage.UPDATE;
    //     PrevTab := 1000 + ActiveTab;
    //     ActiveTab := 1000 + QtyType;
    //     ActiveSubTab := ItemChargeType;

    //     CASE QtyType OF
    //         QtyType::General:
    //             BEGIN
    //                 //CurrPAGE.Subform.PAGE.EDITABLE := FALSE;
    //                 CASE ItemChargeType OF
    //                     ItemChargeType::Tax:
    //                         VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge1);
    //                     ItemChargeType::Deposit:
    //                         VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge2);
    //                     ItemChargeType::Discount:
    //                         VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge3);
    //                     ItemChargeType::Promotion:
    //                         VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge4);
    //                     ItemChargeType::"Shipping Cost":
    //                         VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge6);
    //                 END;

    //                 VATLinesForm.InitGlobals(
    //                    "Currency Code", AllowVATDifference, FALSE,
    //                    "Prices Including VAT", AllowInvDisc, "VAT Base Discount %");
    //             END;
    //         QtyType::Invoicing:
    //             ;
    //         QtyType::Shipping:
    //             ;
    //         QtyType::Prepayment:
    //             ;
    //     END;

    //     SetVatChargeTextHeader(ItemChargeType);
    // end;

    // local procedure DrillDownChargeLines(QtyType: Option General,Invoicing,Shipping,Prepayment; ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost"; FieldNumber: Integer);
    // var
    //     ItemChargeAmtBuf: Record "2014415" temporary;
    //     VATAmountLineBuf: Record "290" temporary;
    //     PurchLine: Record "39";
    //     PurchLineBuf: Record "39" temporary;
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     CLEAR(PurchHeader);
    //     PurchHeader := Rec;
    //     CLEAR(PurchPost);
    //     PurchHeader.SETRANGE("Item Charge Type Filter", ItemChargeType);
    //     PurchPost.GetPurchLines(PurchHeader, PurchLineBuf, QtyType);
    //     PurchHeader.SETRANGE("Item Charge Type Filter");

    //     CLEAR(PurchPost);
    //     CLEAR(PurchLine);
    //     // always on 0
    //     PurchLine.CalcVATAmountLines(0, PurchHeader, PurchLineBuf, VATAmountLineBuf);

    //     IF PurchLineBuf.FINDFIRST THEN
    //         REPEAT
    //             ItemChargeAmtBuf.PurchTransferfields(PurchLineBuf);
    //             ItemChargeAmtBuf.InsertAsGroup(FALSE);
    //         UNTIL PurchLineBuf.NEXT = 0;

    //     PAGE.RUN(0, ItemChargeAmtBuf);
    // end;

    // procedure SetVatChargeTextHeader(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost");
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     EVALUATE(j, FORMAT(ItemChargeType, 0, 2));
    //     VATAmountTextChargeHeader := VATAmountTextCharge[1, j];
    // end;

    // procedure LCaptionClassTranslate(CaptionText: Text[102]; ReverseCaption: Boolean): Text[1024];
    // var
    //     AppMgt: Codeunit "1";
    //     LgCode: Integer;
    //     CaptionTextTranslate: Text[100];
    // begin
    //     CaptionTextTranslate := GetCaptionClass(CaptionText, ReverseCaption);
    //     LgCode := GLOBALLANGUAGE;
    //     EXIT(AppMgt.CaptionClassTranslate(LgCode, CaptionTextTranslate))
    // end;

    // local procedure TotalPurchLineCharge1441LineAm();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure VATAmountCharge1441OnActivate();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalAmountCharge21441OnActiva();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalPurchLineCharge1442LineAm();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure VATAmountCharge1442OnActivate();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure TotalAmountCharge21442OnActiva();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure TotalPurchLineCharge1443LineAm();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure VATAmountCharge1443OnActivate();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalAmountCharge21443OnActiva();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalPurchLineCharge1444LineAm();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure VATAmountCharge1444OnActivate();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalAmountCharge21444OnActiva();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalAmountCharge21446OnActiva();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure VATAmountCharge1446OnActivate();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalPurchLineCharge1446LineAm();
    // begin
    //     SetVATSpecificationCharge(ActiveTab::General, PurchHeader."Item Charge Type Filter"::Promotion);
    // end;
    // BC Upgrade BHARDA11 << ----Drink-IT Functions(SetVATSpecificationCharge,DrillDownChargeLines,SetVatChargeTextHeader,LCaptionClassTranslate,TotalPurchLineCharge1441LineAm,VATAmountCharge1441OnActivate,TotalAmountCharge21441OnActiva,TotalPurchLineCharge1442LineAm,VATAmountCharge1442OnActivate,TotalAmountCharge21442OnActiva,TotalPurchLineCharge1443LineAm,VATAmountCharge1443OnActivate,TotalAmountCharge21443OnActiva,TotalPurchLineCharge1444LineAm,VATAmountCharge1444OnActivate,TotalAmountCharge21444OnActiva,TotalAmountCharge21446OnActiva,VATAmountCharge1446OnActivate,TotalPurchLineCharge1446LineAm)
    // BC Upgrade BHARDA11 >> 
    trigger OnOpenPage()
    begin
        // HEI.02>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        // HEI.02<<

    end;
    // BC Upgrade BHARDA11 << 

    trigger OnAfterGetRecord()
    begin
        // BC Upgrade BHARDA11 >> ----This code was originally written inside a function(RefreshOnAfterGetRecord). In Business Central, we cannot modify the base application code without using an event subscriber. Additionally, this logic was using a global variable, which cannot be accessed directly from a codeunit. Therefore, we implemented this code at all the places where the function RefreshOnAfterGetRecord was being called.
        //>>HEI.01 FDD-XXXXXX001
        TotalAmount3 := WHTManagement.StatisticsCalcWHTAmount(39, Rec."No.", Rec."Document Type".AsInteger());
        //<<HEI.01 FDD-XXXXXX001
        // BC Upgrade BHARDA11 >> --- this code is under the function RefreshOnAfterGetRecord.
        //HEI.02>>
        if EnableCAD then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
            PurchaseLine.SETRANGE("Document No.", Rec."No.");
            if PurchaseLine.FINDSET() then
                repeat
                    CADAmount += PurchaseLine."CAD Amount FND";
                until PurchaseLine.NEXT() = 0;
        end;
        // BC Upgrade BHARDA11 << --- this code is under the function RefreshOnAfterGetRecord
        //HEI.02<<
        // BC Upgrade BHARDA11 << ----
        // BC Upgrade BHARDA11 >> --- This code was originally written inside a function(RefreshOnAfterGetRecord). In Business Central, we cannot modify the base application code without using an event subscriber. Additionally, this logic was using a global variable, which cannot be accessed directly from a codeunit. Therefore, we implemented this code at all the places where the function RefreshOnAfterGetRecord was being called.
        VATLinesForm.GetTempVATAmountLine(TempVATAmountLine2);
        UpdateHeaderInfoCADAmount(2, TempVATAmountLine2);
        // BC Upgrade BHARDA11 << ----This code was originally written inside a function(RefreshOnAfterGetRecord). In Business Central, we cannot modify the base application code without using an event subscriber. Additionally, this logic was using a global variable, which cannot be accessed directly from a codeunit. Therefore, we implemented this code at all the places where the function RefreshOnAfterGetRecord was being called.
    end;
    // BC Upgrade BHARAD11 >> 
    /* The UpdateHeaderInfo function, which is a base function, contains code related to the CAD amount. In this function, the value is being assigned to a global variable CADAmount, and this variable is being used at the page level. */
    /* However, this approach is not possible through an event subscriber. Therefore, we created a separate function named UpdateHeaderInfoCadAmount. The CAD amount logic has been moved into this new function. */
    /* This function was being used in the OnDrillDown trigger of two fields(NoOfVATLines_GeneralNoOfVATLines_Invoicing), with parameter 1 and 2. I have now manually called the function there with the respective parameters. */
    local procedure UpdateHeaderInfoCADAmount(IndexNo: Integer; VAR VATAmountLine: Record "VAT Amount Line")
    begin
        //HEI.02>>
        IF EnableCAD AND (IndexNo = 1) THEN
            CADAmount := VATAmountLine.GetTotalCADAmount;
        //HEI.02<<
    end;
    // BC Upgrade BHARDA11 <<

}

