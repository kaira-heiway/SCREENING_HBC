pageextension 52004 PurchaseStatisticsExt extends "Purchase Statistics"
{
    /* 
    HEI.01 FDD-XXXXXX001 IBM POSTOI01 11.01.2018
  # New variables : TotalAmount3 (decinmal) and WHTManagement (codeunit)
  # New field shown in the page designer: WHT Amount (variable TotalAmount3)
  # OnAfterGetRecord modified : add procedure to calculate TotalAmount3
HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
  # New Field 'CAD Amount' created
  # Code added on 'OnOpenPage' and on 'OnAfterGetRecord' triggers
HEI.03 CHG2224401 HB3624 YADAVM09 02.02.2024 Health and Security Levy Tax
 #New Field Added #H&S Levy Tax Amount
     */
    // version NAVW110.0,DITW110.00.08,HEI.03
    // BC Upgrade BHARDA11 >>
    // 1. Add applicationArea property in fields.
    // 2. Add Hei code in onopenpage trigger and onaftergetrecord trigger.
    // 3. Remove drink-It Group and functions (SetVATSpecificationCharge,DrillDownChargeLines,SetVatChargeTextHeader,LCaptionClassTranslate,VATAmountOnActivate,TotalAmount2OnActivate,TotalAmount1OnActivate,TotalPurchLineInvDiscountAmoun,TotalPurchLineCharge1LineAmoun,VATAmountCharge1OnActivate,TotalAmountCharge21OnActivate,TotalPurchLineCharge2LineAmoun,VATAmountCharge2OnActivate,TotalAmountCharge22OnActivate,TotalPurchLineCharge3LineAmoun,VATAmountCharge3OnActivate,TotalAmountCharge23OnActivate,TotalPurchLineCharge4LineAmoun,VATAmountCharge4OnActivate,TotalAmountCharge24OnActivate)
    // 4. custom code in function UpdateHeaderInfo it is still pending
    /* The UpdateHeaderInfo function, which is a base function, contains code related to the CAD amount. In this function, the value is being assigned to a global variable CADAmount, and this variable is being used at the page level. */
    /* However, this approach is not possible through an event subscriber. Therefore, we created a separate function named UpdateHeaderInfoCadAmount. The CAD amount logic has been moved into this new function. */
    /* Now, I have called this function in four different places because, directly or indirectly, the functions that are being triggered in those triggers internally call the UpdateHeaderInfo function. */
    // BC Upgrade BHARDA11 <<
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
            ToolTipML = ENU = 'Specifies the net amount of all the lines in the purchase document.', FRA = 'Spécifie le montant net de toutes les lignes du document achat.';
            CaptionClass = GetCaptionClass(Text001, FALSE);
        }
        modify(InvDiscountAmount)
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies the invoice discount amount for the purchase document.', FRA = 'Spécifie le montant de la remise facture du document achat.';
            // BC Upgrade BHARDA11 >>
            trigger OnAfterValidate()
            begin
                UpdateHeaderInfoCadAmount();
            end;
            // BC Upgrade BHARDA11 <<
        }
        modify(TotalAmount1)
        {
            CaptionML = ENU = 'Total', FRA = 'Total';
            ToolTipML = ENU = 'Specifies the total amount less any invoice discount amount and excluding VAT for the purchase document.', FRA = 'Spécifie le montant total hors taxes et sans remise facture du document achat.';
            CaptionClass = GetCaptionClass(Text002, FALSE);
            // BC Upgrade BHARDA11 >>
            trigger OnAfterValidate()
            begin
                UpdateHeaderInfoCadAmount();
            end;
            // BC Upgrade BHARAD11 <<
        }
        modify(VATAmount)
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
            ToolTipML = ENU = 'Specifies the total VAT amount that has been calculated for all the lines in the purchase document.', FRA = 'Spécifie le montant total de la TVA qui a été calculée pour toutes les lignes du document achat.';
        }
        modify(TotalAmount2)
        {
            CaptionML = ENU = 'Total Incl. VAT', FRA = 'Total TTC';
            ToolTipML = ENU = 'Specifies the total amount including VAT that will be posted to the vendor''s account for all the lines in the purchase document. This is the amount that you owe the vendor based on this purchase document. If the document is a credit memo, it is the amount that the vendor owes you.', FRA = 'Spécifie le montant total TTC, qui est validé sur le compte du fournisseur pour toutes les lignes du document achat. Il s''agit du montant que vous devez au fournisseur si vous vous référez à ce document achat. Si le document est un avoir, ce montant est celui que le fournisseur vous doit.';
            CaptionClass = GetCaptionClass(Text002, TRUE);
        }
        modify("TotalPurchLineLCY.Amount")
        {
            CaptionML = ENU = 'Purchase (LCY)', FRA = 'Achats DS';
            ToolTipML = ENU = 'Specifies your total purchases. It is calculated from amounts excluding VAT on all completed and open purchase invoices and credit memos.', FRA = 'Spécifie le total de vos achats. Il est calculé à partir des montants HT sur toutes les factures et avoirs achats terminés et ouverts.';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
            ToolTipML = ENU = 'Specifies the total quantity of G/L account entries, items, and/or resources in the purchase document.', FRA = 'Spécifie la quantité totale des écritures comptables, article ou ressources du document achat.';
        }
        modify("TotalPurchLine.""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
            ToolTipML = ENU = 'Specifies the total number of parcels in the purchase document.', FRA = 'Spécifie le nombre total de colis du document achat.';
        }
        modify("TotalPurchLine.""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            ToolTipML = ENU = 'Specifies the total net weight of the items in the purchase document.', FRA = 'Spécifie le poids net total des articles du document achat.';
        }
        modify("TotalPurchLine.""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
            ToolTipML = ENU = 'Specifies the total gross weight of the items in the purchase document.', FRA = 'Spécifie le poids brut total des articles du document achat.';
        }
        modify("TotalPurchLine.""Unit Volume""")
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
            ToolTipML = ENU = 'Specifies the total volume of the items in the purchase document.', FRA = 'Spécifie le volume total des articles du document achat.';
        }

        //Unsupported feature: Change PagePartID on "SubForm(Control 5)". Please convert manually.

        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
        }
        modify("Vend.""Balance (LCY)""")
        {
            CaptionML = ENU = 'Balance (LCY)', FRA = 'Solde DS';
            ToolTipML = ENU = 'Specifies the balance on the vendor''s account.', FRA = 'Spécifie le solde du compte fournisseur.';
        }

        addafter(VATAmount)
        {
            // BC Upgrade BHARDA11 >> 
            field(CADAmount; CADAmount)
            {
                ApplicationArea = All;
                Caption = 'CAD Amount';
                Editable = false;
                Visible = EnableCAD;
            }
            // BC Upgrade BHARDA11 << 
            field(Leavyamount; Leavyamount)
            {
                ApplicationArea = All;
                Caption = 'Leavyamount';
                Editable = false;
                Visible = EnableLevy;
            }
        }
        addafter(TotalAmount2)
        {
            field("<TotalAmount3>"; TotalAmount3)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'WHT Amount',
                            ESP = 'Importe WHT',
                            FRA = 'Montant WHT';
                Editable = false;
            }
        }
        addafter(Vendor)
        {
            group("Drink-It")
            {
                CaptionML = ENU = 'Drink-It',
                            FRA = 'Drink-It';
                // fixed()
                // {
                //     group(" ")
                //     {
                //         Caption = '" "';
                //         field(LCaptionClassTranslate(Text002,FALSE);LCaptionClassTranslate(Text002,FALSE))
                //         {
                //             Editable = false;
                //         }
                //         field(TotalPurchLineCharge[1]."Line Amount";TotalPurchLineCharge[1]."Line Amount")
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             CaptionML = ENU='Tax',
                //                         FRA='Taxes';
                //             Editable = false;

                //             trigger OnDrillDown();
                //             begin
                //                 DrillDownChargeLines(PurchHeader."Item Charge Type Filter"::Tax,FIELDNO(Amount));
                //             end;
                //         }
                //         field(TotalPurchLineCharge[2]."Line Amount";TotalPurchLineCharge[2]."Line Amount")
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             CaptionML = ENU='Deposit',
                //                         FRA='Consigne';
                //             Editable = false;

                //             trigger OnDrillDown();
                //             begin
                //                 DrillDownChargeLines(PurchHeader."Item Charge Type Filter"::Deposit,FIELDNO(Amount));
                //             end;
                //         }
                //         field(TotalPurchLineCharge[3]."Line Amount";TotalPurchLineCharge[3]."Line Amount")
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             CaptionML = ENU='Discount/ Charge',
                //                         FRA='Remise / Frais';
                //             Editable = false;

                //             trigger OnDrillDown();
                //             begin
                //                 DrillDownChargeLines(PurchHeader."Item Charge Type Filter"::Discount,FIELDNO(Amount));
                //             end;
                //         }
                //         field(TotalPurchLineCharge[4]."Line Amount";TotalPurchLineCharge[4]."Line Amount")
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             CaptionML = ENU='Promotion',
                //                         FRA='Promotion';
                //             Editable = false;

                //             trigger OnDrillDown();
                //             begin
                //                 DrillDownChargeLines(PurchHeader."Item Charge Type Filter"::Promotion,FIELDNO(Amount));
                //             end;
                //         }
                //     }
                //     group(" ")
                //     {
                //         Caption = '" "';
                //         field(VATAmountTxt;Text006)
                //         {
                //             Editable = false;
                //             Visible = VATAmountTxtVisible;
                //         }
                //         field(VATAmountCharge[1];VATAmountCharge[1])
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             Editable = false;
                //         }
                //         field(VATAmountCharge[2];VATAmountCharge[2])
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             Editable = false;
                //         }
                //         field(VATAmountCharge[3];VATAmountCharge[3])
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             Editable = false;
                //         }
                //         field(VATAmountCharge[4];VATAmountCharge[4])
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             Editable = false;
                //         }
                //     }
                //     group(" ")
                //     {
                //         Caption = '" "';
                //         field(LCaptionClassTranslate(Text001,TRUE);LCaptionClassTranslate(Text001,TRUE))
                //         {
                //             Editable = false;
                //         }
                //         field(TotalAmountCharge2[1];TotalAmountCharge2[1])
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             Editable = false;
                //         }
                //         field(TotalAmountCharge2[2];TotalAmountCharge2[2])
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             Editable = false;
                //         }
                //         field(TotalAmountCharge2[3];TotalAmountCharge2[3])
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             Editable = false;
                //         }
                //         field(TotalAmountCharge2[4];TotalAmountCharge2[4])
                //         {
                //             AutoFormatExpression = "Currency Code";
                //             AutoFormatType = 1;
                //             Editable = false;
                //         }
                //     }
                // }
            }
        }
    }


    var

        PurchaseLine: Record "Purchase Line";


    // BC Upgrade BHARDA11 >> ---Drink-IT Functions(SetVATSpecificationCharge,DrillDownChargeLines,SetVatChargeTextHeader,LCaptionClassTranslate,VATAmountOnActivate,TotalAmount2OnActivate,TotalAmount1OnActivate,TotalPurchLineInvDiscountAmoun,TotalPurchLineCharge1LineAmoun,VATAmountCharge1OnActivate,TotalAmountCharge21OnActivate,TotalPurchLineCharge2LineAmoun,VATAmountCharge2OnActivate,TotalAmountCharge22OnActivate,TotalPurchLineCharge3LineAmoun,VATAmountCharge3OnActivate,TotalAmountCharge23OnActivate,TotalPurchLineCharge4LineAmoun,VATAmountCharge4OnActivate,TotalAmountCharge24OnActivate)
    // local procedure SetVATSpecificationCharge(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost");
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     CASE ItemChargeType OF
    //         ItemChargeType::Tax:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge1);
    //         ItemChargeType::Deposit:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge2);
    //         ItemChargeType::Discount:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge3);
    //         ItemChargeType::Promotion:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge4);
    //     END;

    //     SetVatChargeTextHeader(ItemChargeType);

    //     CurrPage.SubForm.PAGE.InitGlobals(
    //       "Currency Code", AllowVATDifference, FALSE,
    //       "Prices Including VAT", AllowInvDisc, "VAT Base Discount %");
    // end;

    // local procedure DrillDownChargeLines(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost"; FieldNumber: Integer);
    // var
    //     ItemChargeAmtBuf: Record 2014415 temporary; 
    //     VATAmountLineBuf: Record "VAT Amount Line" temporary;
    //     PurchLine: Record "Purchase Line";
    //     PurchLineBuf: Record "Purchase Line" temporary;
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     CLEAR(PurchHeader);
    //     PurchHeader := Rec;
    //     CLEAR(PurchPost);
    //     PurchHeader.SETRANGE("Item Charge Type Filter", ItemChargeType);
    //     PurchPost.GetPurchLines(PurchHeader, PurchLineBuf, 0);
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
    // var
    //     j: Integer;
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     EVALUATE(j, FORMAT(ItemChargeType, 0, 2));
    //     VATAmountTextChargeHeader := VATAmountTextCharge[j];
    // end;

    // procedure LCaptionClassTranslate(CaptionText : Text[102];ReverseCaption : Boolean) : Text[1024];
    // var
    //     AppMgt : Codeunit "1";
    //     LgCode : Integer;
    //     CaptionTextTranslate : Text[100];
    // begin
    //     // <<DITW16.00.00.37 DIT-715 #1
    //     CaptionTextTranslate:= GetCaptionClass(CaptionText,ReverseCaption);
    //     LgCode := GLOBALLANGUAGE;
    //     EXIT(AppMgt.CaptionClassTranslate(LgCode,CaptionTextTranslate))
    //     // >>DITW16.00.00.37 DIT-715 #1
    // end;

    // local procedure VATAmountOnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification();
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure TotalAmount2OnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification();
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure TotalAmount1OnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification();
    //     // >>DITW15.00.00.35 DDR
    //     CurrPage.UPDATE;
    // end;

    // local procedure TotalPurchLineInvDiscountAmoun();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification();
    //     // >>DITW15.00.00.35 DDR
    //     CurrPage.UPDATE;
    // end;

    // local procedure TotalPurchLineCharge1LineAmoun();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure VATAmountCharge1OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalAmountCharge21OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalPurchLineCharge2LineAmoun();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure VATAmountCharge2OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure TotalAmountCharge22OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure TotalPurchLineCharge3LineAmoun();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure VATAmountCharge3OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalAmountCharge23OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalPurchLineCharge4LineAmoun();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure VATAmountCharge4OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalAmountCharge24OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchHeader."Item Charge Type Filter"::Promotion);
    // end;
    // BC Upgrade BHARDA11 << ---Drink-IT Functions(LCaptionClassTranslate,VATAmountOnActivate,TotalAmount2OnActivate,TotalAmount1OnActivate,TotalPurchLineInvDiscountAmoun,TotalPurchLineCharge1LineAmoun,VATAmountCharge1OnActivate,TotalAmountCharge21OnActivate,TotalPurchLineCharge2LineAmoun,VATAmountCharge2OnActivate,TotalAmountCharge22OnActivate,TotalPurchLineCharge3LineAmoun,VATAmountCharge3OnActivate,TotalAmountCharge23OnActivate,TotalPurchLineCharge4LineAmoun,VATAmountCharge4OnActivate,TotalAmountCharge24OnActivate)

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    var
        PurchSetup: Record "Purchases & Payables Setup";
        WHTManagement: Codeunit WHTManagement;
        TotalAmount3, Leavyamount : Decimal;
        EnableLevy: Boolean;
        Text001: Label 'Amount';
        Text002: Label 'Total';
        GeneralLedgerSetup: Record "General Ledger Setup";
        EnableCAD: Boolean;
        CADAmount: Decimal;

    trigger OnOpenPage()
    begin
        // BC Upgrade BHARDA11 >> 
        // //HEI.02>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.02<<
        // BC Upgrade BHARDA11 << 

        //HEI.03>>
        PurchSetup.GET();
        EnableLevy := PurchSetup."H&S Levy Tax FND";
        //HEI.03<<
    end;

    trigger OnAfterGetRecord()
    begin
        //>>HEI.01 FDD-XXXXXX001
        TotalAmount3 := WHTManagement.StatisticsCalcWHTAmount(39, Rec."No.", Rec."Document Type".AsInteger());
        //<<HEI.01 FDD-XXXXXX001
        //HEI.02>>
        // BC Upgrade BHARDA11 >> 
        IF EnableCAD THEN BEGIN
            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
            PurchaseLine.SETRANGE("Document No.", Rec."No.");
            IF PurchaseLine.FINDSET THEN
                REPEAT
                    CADAmount += PurchaseLine."CAD Amount FND";
                UNTIL PurchaseLine.NEXT = 0;
        END;
        // BC Upgrade BHARDA11 << 
        //HEI.02<<
        //HEI.03>>
        IF EnableLevy THEN BEGIN
            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
            PurchaseLine.SETRANGE("Document No.", Rec."No.");
            IF PurchaseLine.FINDSET(FALSE) THEN
                REPEAT
                    Leavyamount += ROUND(PurchaseLine."H&S Levy Tax Amount FND");
                UNTIL PurchaseLine.NEXT = 0;
        END;
        //HEI.03<<
    end;
    // BC Upgrade BHARDA11 >>
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        UpdateHeaderInfoCadAmount();
    end;
    // BC Upgrade BHARDA11 <<
    // BC Upgrade BHARDA11 >>
    /* The UpdateHeaderInfo function, which is a base function, contains code related to the CAD amount. In this function, the value is being assigned to a global variable CADAmount, and this variable is being used at the page level. */
    /* However, this approach is not possible through an event subscriber. Therefore, we created a separate function named UpdateHeaderInfoCadAmount. The CAD amount logic has been moved into this new function. */
    /* Now, I have called this function in four different places because, directly or indirectly, the functions that are being triggered in those triggers internally call the UpdateHeaderInfo function. */
    local procedure UpdateHeaderInfoCadAmount()
    begin
        CurrPage.SubForm.PAGE.GetTempVATAmountLine(TempVATAmountLine);
        IF TempVATAmountLine.GetAnyLineModified THEN
            CADAmount := TempVATAmountLine.GetTotalCADAmount; //HEI.02
    end;
    // BC Upgrade BHARDA11 <<
}

