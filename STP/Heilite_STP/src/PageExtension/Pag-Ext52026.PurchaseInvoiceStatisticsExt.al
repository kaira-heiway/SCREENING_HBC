pageextension 52026 PurchaseInvoiceStatisticsExt extends "Purchase Invoice Statistics"
{
    // version NAVW110.0,DITW110.00.08

    // DITW15.00.00.19 DDR 13/06/2008 Added Amount fields (like Invoice statistics)
    //   DITW15.00.00.35 DDR 22/06/2009 Added Statistic Drink-it tab
    //                                  Using (available) flowfilters
    //                                  Added functions
    //                                    SetVATSpecification(),SetVATSpecificationCharge(),
    //                                    DrillDownChargeLines(),SetVatChargeTextHeader()
    //   DITW15.00.00.36 DDR 18/12/2009 issue 989 Bugfix OnActivate first control/first tab
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field 'CAD Amount' created
    //     # Code added on 'OnOpenPage' and on 'OnAfterGetRecord' triggers
    //***********************************************//
    //BC UPGRADE SIVA //
    //2.Commented drink it fields & code.


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("VendAmount + InvDiscAmount")
        {

            //Unsupported feature: Change Level on ""VendAmount + InvDiscAmount"(Control 2)". Please convert manually.

            CaptionML = ENU = 'Amount', FRA = 'Montant';
            ToolTipML = ENU = 'Specifies the net amount of all the lines in the purchase document.', FRA = 'Spécifie le montant net de toutes les lignes du document achat.';
        }
        modify(InvDiscAmount)
        {

            //Unsupported feature: Change Level on "InvDiscAmount(Control 6)". Please convert manually.

            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies the invoice discount amount for the purchase document.', FRA = 'Spécifie le montant de la remise facture du document achat.';
        }
        modify(VendAmount)
        {

            //Unsupported feature: Change Level on "VendAmount(Control 12)". Please convert manually.

            CaptionML = ENU = 'Total', FRA = 'Total';
            ToolTipML = ENU = 'Specifies the total amount, less any invoice discount amount, and excluding VAT for the purchase document.', FRA = 'Spécifie le montant total hors taxes et sans remise facture du document achat.';
        }
        modify(VATAmount)
        {

            //Unsupported feature: Change Level on "VATAmount(Control 16)". Please convert manually.

            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
            ToolTipML = ENU = 'Specifies the total VAT amount that has been calculated for all the lines in the purchase document.', FRA = 'Spécifie le montant total de la TVA qui a été calculée pour toutes les lignes du document achat.';
        }
        modify(AmountInclVAT)
        {

            //Unsupported feature: Change Level on "AmountInclVAT(Control 20)". Please convert manually.

            CaptionML = ENU = 'Total Incl. VAT', FRA = 'Total TTC';
            ToolTipML = ENU = 'Specifies the total amount, including VAT, that will be posted to the vendor''s account for all the lines in the purchase document.', FRA = 'Spécifie le montant total TTC qui est validé sur le compte du fournisseur pour toutes les lignes du document achat.';
        }
        modify(AmountLCY)
        {

            //Unsupported feature: Change Level on "AmountLCY(Control 26)". Please convert manually.

            CaptionML = ENU = 'Purchase (LCY)', FRA = 'Achats DS';
            ToolTipML = ENU = 'Specifies your total purchases.', FRA = 'Spécifie le total de vos achats.';
        }
        modify(LineQty)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
            ToolTipML = ENU = 'Specifies the total quantity of G/L account entries, items and/or resources in the purchase document.', FRA = 'Spécifie la quantité totale des écritures comptables, des articles et/ou des ressources du document achat.';
        }
        modify(TotalParcels)
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
            ToolTipML = ENU = 'Specifies the total number of parcels in the purchase document.', FRA = 'Spécifie le nombre total de colis du document achat.';
        }
        modify(TotalNetWeight)
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            ToolTipML = ENU = 'Specifies the total net weight of the items in the purchase document.', FRA = 'Spécifie le poids net total des articles du document achat.';
        }
        modify(TotalGrossWeight)
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
            ToolTipML = ENU = 'Specifies the total gross weight of the items in the purchase document.', FRA = 'Spécifie le poids brut total des articles du document achat.';
        }
        modify(TotalVolume)
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
            ToolTipML = ENU = 'Specifies the total volume of the items in the purchase document.', FRA = 'Spécifie le volume total des articles du document achat.';
        }
        modify(Vendor)
        {
            CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
        }
        modify("Vend.""Balance (LCY)""")
        {
            CaptionML = ENU = 'Balance (LCY)', FRA = 'Solde DS';
            ToolTipML = ENU = 'Specifies the balance in LCY on the vendor''s account.', FRA = 'Spécifie le solde en DS du compte fournisseur.';
        }
        addfirst(General)
        {
            group(Control1100083001)
            {
            }
        }
        //BC UPGRADE SIVA >> CADFIELD
        addafter(VATAmount)
        {
            field(CADAmount; CADAmount)
            {
                ApplicationArea = All;
                Caption = 'CAD Amount';
                Editable = false;
                Visible = EnableCAD;
            }
        }
        //BC UPGRADE SIVA << CADFIELD

        addafter(AmountInclVAT)
        {
            field(WHTAmount; WHTAmount)
            {
                ApplicationArea = all;
                ToolTip = 'WHT Amount';
                Caption = 'WHT Amount';
            }
        }
        addafter(Vendor)
        {
            //BC UPGRADE SIVA >> Drink IT Group
            // group("Drink-It")
            // {
            //     CaptionML = ENU = 'Drink-It',
            //                 FRA = 'Drink-It';
            //     fixed(Control1901565001)
            //     {
            //         group(Amount)
            //         {
            //             CaptionML = ENU = 'Amount',
            //                         FRA = 'Montant';
            //             field(Text002; Text002)
            //             {
            //                 Editable = false;
            //                 Visible = false;
            //             }
            //             field("TotalPurchInvLineCharge[1].""Line Amount"""; TotalPurchInvLineCharge[1]."Line Amount")
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Tax',
            //                             FRA = 'Taxes';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchInvHeader."Item Charge Type Filter"::Tax, FIELDNO(Amount));
            //                 end;
            //             }
            //             field("TotalPurchInvLineCharge[2].""Line Amount"""; TotalPurchInvLineCharge[2]."Line Amount")
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Deposit',
            //                             FRA = 'Consigne';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchInvHeader."Item Charge Type Filter"::Deposit, FIELDNO(Amount));
            //                 end;
            //             }
            //             field("TotalPurchInvLineCharge[3].""Line Amount"""; TotalPurchInvLineCharge[3]."Line Amount")
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Discount/ Charge',
            //                             FRA = 'Remise / Frais';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchInvHeader."Item Charge Type Filter"::Discount, FIELDNO(Amount));
            //                 end;
            //             }
            //             field("TotalPurchInvLineCharge[4].""Line Amount"""; TotalPurchInvLineCharge[4]."Line Amount")
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Promotion',
            //                             FRA = 'Promotion';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchInvHeader."Item Charge Type Filter"::Promotion, FIELDNO(Amount));
            //                 end;
            //             }
            //             field("TotalPurchInvLineCharge[6].""Line Amount"""; TotalPurchInvLineCharge[6]."Line Amount")
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Shipping Cost',
            //                             FRA = 'Coût transport';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchInvHeader."Item Charge Type Filter"::"Shipping Cost", FIELDNO(Amount));
            //                 end;
            //             }
            //         }
            //         group("VAT Amount")
            //         {
            //             CaptionML = ENU = 'VAT Amount',
            //                         FRA = 'Montant TVA';
            //             field(Control1100083026; Text002)
            //             {
            //                 Editable = false;
            //                 Visible = false;
            //             }
            //             field("VATAmountCharge[1]"; VATAmountCharge[1])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'VAT Amount',
            //                             FRA = 'Montant TVA';
            //                 Editable = false;
            //             }
            //             field("VATAmountCharge[2]"; VATAmountCharge[2])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'VAT Amount',
            //                             FRA = 'Montant TVA';
            //                 Editable = false;
            //             }
            //             field("VATAmountCharge[3]"; VATAmountCharge[3])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'VAT Amount',
            //                             FRA = 'Montant TVA';
            //                 Editable = false;
            //             }
            //             field("VATAmountCharge[4]"; VATAmountCharge[4])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'VAT Amount',
            //                             FRA = 'Montant TVA';
            //                 Editable = false;
            //             }
            //             field("VATAmountCharge[6]"; VATAmountCharge[6])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'VAT Amount',
            //                             FRA = 'Montant TVA';
            //                 Editable = false;
            //             }
            //         }
            //         group("Total Incl. VAT")
            //         {
            //             CaptionML = ENU = 'Total Incl. VAT',
            //                         FRA = 'Total TTC';
            //             field(Control1100083028; Text002)
            //             {
            //                 Editable = false;
            //                 Visible = false;
            //             }
            //             field("TotalAmountCharge2[1]"; TotalAmountCharge2[1])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Total Incl. VAT',
            //                             FRA = 'Total TTC';
            //                 Editable = false;
            //             }
            //             field("TotalAmountCharge2[2]"; TotalAmountCharge2[2])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 Editable = false;
            //             }
            //             field("TotalAmountCharge2[3]"; TotalAmountCharge2[3])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 Editable = false;
            //             }
            //             field("TotalAmountCharge2[4]"; TotalAmountCharge2[4])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 Editable = false;
            //             }
            //             field("TotalAmountCharge2[6]"; TotalAmountCharge2[6])
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 Editable = false;
            //             }
            //         }
            //     }
            // }
            //BC UPGRADE SIVA << Drink IT Group
        }
    }

    var
        TempPurchInvLine: Record "Purch. Inv. Line" temporary;
        WHTEntry: Record "WHT Entry FND";
        PurchInvLine2: Record "Purch. Inv. Line";
        VPS: Record "VAT Posting Setup";
        rcVat: Decimal;
        PurchInvLine: Record "Purch. Inv. Line";


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=VAT Amount;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=VAT Amount;FRA=Montant TVA;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=%1% VAT;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=%1% VAT;FRA=TVA %1%;
    //Variable type has not been exported.

    var
        PurchInvHeader: Record "Purch. Inv. Header";
        TempVATAmountLineCharge1: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge2: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge3: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge4: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge6: Record "VAT Amount Line" temporary;
        TotalPurchInvLineCharge: array[6] of Record "Purch. Inv. Line";
        TotalPurchInvLineChargeLCY: array[6] of Record "Purch. Inv. Line";
        VATAmountCharge: array[6] of Decimal;
        VATAmountTextCharge: array[6] of Text[30];
        VATAmountTextChargeHeader: Text[30];
        TotalAmountCharge1: array[6] of Decimal;
        TotalAmountCharge2: array[6] of Decimal;
        j: Integer;
        ActiveTab: Option General,Vendor,,,,,"Drink-It";
        ActiveSubTab: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        SubformIsReady: Boolean;
        Text002: TextConst ENU = 'Placeholder', FRA = 'Paramètre substituable';
        WHTAmount: Decimal;
        CADAmount: Decimal;
        EnableCAD: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW15.00.00.35 DDR 22/06/2009
    if xRec."No." <> "No." then begin
      if ActiveTab = ActiveTab::"Drink-It" then
        SetVATSpecificationCharge(ActiveSubTab)
      else
        SetVATSpecification(ActiveTab);
    end;
    // >>DITW15.00.00.35 DDR
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger (Variable: TempPurchInvLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEARALL;

    if "Currency Code" = '' then
      Currency.InitRoundingPrecision
    #5..26
          else
            VATPercentage := -1;
      until PurchInvLine.NEXT = 0;
    VATAmount := AmountInclVAT - VendAmount;
    InvDiscAmount := ROUND(InvDiscAmount,Currency."Amount Rounding Precision");

    #33..52
      CLEAR(Vend);
    Vend.CALCFIELDS("Balance (LCY)");

    PurchInvLine.CalcVATAmountLines(Rec,TempVATAmountLine);
    CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLine);
    CurrPage.SubForm.PAGE.InitGlobals("Currency Code",false,false,false,false,"VAT Base Discount %");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.35 DDR 22/06/2009
    // CLEARALL;
    CLEAR(VendAmount);
    CLEAR(AmountInclVAT);
    CLEAR(InvDiscAmount);
    CLEAR(TotalNetWeight);
    CLEAR(TotalGrossWeight);
    CLEAR(TotalVolume);
    CLEAR(TotalParcels);
    CLEAR(LineQty);
    // >>DITW15.00.00.35 DDR
    #2..29
    //soicad>>
    WHTEntry.SETCURRENTKEY("Document No.");
    WHTEntry.SETRANGE("Document No.","No.");
    if WHTEntry.FINDSET then
      repeat
        WHTAmount += WHTEntry.Amount;
      until WHTEntry.NEXT = 0;
    //soicad<<
    // <<DITW15.00.00.35 DDR 22/06/2009
    GetPurchInvLines(TempPurchInvLine);
    with PurchInvLine do
      for "Item Charge Type" := "Item Charge Type"::Tax to "Item Charge Type"::ShippingCost do begin
        CLEAR(PurchInvHeader);
        PurchInvHeader := Rec;
        PurchInvHeader.SETRANGE("Item Charge Type Filter","Item Charge Type");
        TempPurchInvLine.RESET;
        TempPurchInvLine.SETRANGE("Item Charge Type","Item Charge Type");
        case "Item Charge Type" of
          "Item Charge Type"::Tax:
            PurchInvLine.CalcVATAmountLinesTemp(PurchInvHeader,TempPurchInvLine,TempVATAmountLineCharge1);
          "Item Charge Type"::Deposit:
            PurchInvLine.CalcVATAmountLinesTemp(PurchInvHeader,TempPurchInvLine,TempVATAmountLineCharge2);
          "Item Charge Type"::Discount:
            PurchInvLine.CalcVATAmountLinesTemp(PurchInvHeader,TempPurchInvLine,TempVATAmountLineCharge3);
          "Item Charge Type"::Promotion:
             PurchInvLine.CalcVATAmountLinesTemp(PurchInvHeader,TempPurchInvLine,TempVATAmountLineCharge4);
          "Item Charge Type"::ShippingCost:
             PurchInvLine.CalcVATAmountLinesTemp(PurchInvHeader,TempPurchInvLine,TempVATAmountLineCharge6);
        end;
        EVALUATE(j,FORMAT("Item Charge Type",0,2));
        PurchInvHeader.SumPurchInvLinesTemp(
          TempPurchInvLine,TotalPurchInvLineCharge[j],TotalPurchInvLineChargeLCY[j],
          VATAmountCharge[j],VATAmountTextCharge[j]);

        if "Prices Including VAT" then begin
          TotalAmountCharge2[j] := TotalPurchInvLineCharge[j].Amount;
          TotalAmountCharge1[j] := TotalAmountCharge2[j] + VATAmountCharge[j];
          TotalPurchInvLineCharge[j]."Line Amount" := TotalAmountCharge1[j] + TotalPurchInvLineCharge[j]."Inv. Discount Amount";
        end else begin
          TotalAmountCharge1[j] := TotalPurchInvLineCharge[j].Amount;
          TotalAmountCharge2[j] := TotalPurchInvLineCharge[j]."Amount Including VAT";
        end;
      end;
    CLEAR(TempPurchInvLine);
    CLEAR(PurchInvLine);
    // >>DITW15.00.00.35 DDR

    //HEI.01>>
    if EnableCAD then begin
      CALCFIELDS("CAD Amount");
      CADAmount := "CAD Amount";
    end;
    //HEI.01<<
    #30..55
    // <<DITW15.00.00.35 DDR 22/06/2009
    #56..58
    // <<DITW15.00.00.35 DDR 22/06/2009
    // moved call Subform
    SubformIsReady := true;
    // >>DITW15.00.00.35 DDR
    //soicad>>
    PurchInvLine2.SETRANGE("Document No.","No.");
    PurchInvLine2.SETRANGE("VAT Calculation Type",PurchInvLine2."VAT Calculation Type"::"Reverse Charge VAT");
    if PurchInvLine2.FINDSET then repeat
      if VPS.GET(PurchInvLine2."VAT Bus. Posting Group",PurchInvLine2."VAT Prod. Posting Group") then
        if VPS."Reverse Charge VAT %" <> 0 then
          rcVat := PurchInvLine2.Amount * (VPS."Reverse Charge VAT %"/100) * (VPS."VAT %"/100);
    until PurchInvLine2.NEXT = 0;
    VATAmount += rcVat;
    AmountInclVAT += rcVat;
    //soicad<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    trigger OnOpenPage();
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //BC UPGRADE SIVA >>CADFIELD   
        //HEI.01>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.01<<
        //BC UPGRADE SIVA <<CADFIELD

    end;

    trigger OnAfterGetRecord()
    begin
        //BC UPGRADE SIVA >> CADFIELD
        //HEI.01>>
        if EnableCAD then begin
            Rec.CALCFIELDS("CAD Amount FND");
            CADAmount := Rec."CAD Amount FND";
        end;
        //HEI.01<<
        //BC UPGRADE SIVA << CADFIELD
        //BC Upgrade SIVA >>
        //soicad>>
        WHTEntry.SETCURRENTKEY("Document No.");
        WHTEntry.SETRANGE("Document No.", Rec."No.");
        if WHTEntry.FINDSET then
            repeat
                WHTAmount += WHTEntry.Amount;
            until WHTEntry.NEXT = 0;
        //soicad<<
        //BC Upgrade SIVA <<
    end;
    //BC UPGRADE SIVA >> Drink IT code  
    // local procedure SetVATSpecification(SelectedActiveTab: Option General,Vendor,,,,,"Drink-It");
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     if not SubformIsReady then
    //         exit;

    //     ActiveTab := SelectedActiveTab;
    //     PurchInvLine.CalcVATAmountLines(Rec, TempVATAmountLine);
    //     CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLine);
    //     CurrPage.SubForm.PAGE.InitGlobals("Currency Code", false, false, false, false, "VAT Base Discount %");
    // end;

    // local procedure SetVATSpecificationCharge(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,ShippingCost);
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     if not SubformIsReady then
    //         exit;

    //     ActiveTab := ActiveTab::"Drink-It";

    //     case ItemChargeType of
    //         ItemChargeType::Tax:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge1);
    //         ItemChargeType::Deposit:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge2);
    //         ItemChargeType::Discount:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge3);
    //         ItemChargeType::Promotion:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge4);
    //         ItemChargeType::ShippingCost:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge6);
    //     end;

    //     ActiveSubTab := ItemChargeType;
    //     CurrPage.SubForm.PAGE.InitGlobals("Currency Code", false, false, false, false, "VAT Base Discount %");
    //     SetVatChargeTextHeader(ItemChargeType);
    // end;

    // local procedure DrillDownChargeLines(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion; FieldNumber: Integer);
    // var
    //     ItemChargeAmtBuf: Record "Item Charge Amount Buffer" temporary;
    //     VATAmountLineBuf: Record "VAT Amount Line" temporary;
    //     PurchInvLine: Record "Purch. Inv. Line";
    //     PurchInvLineBuf: Record "Purch. Inv. Line" temporary;
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     CLEAR(PurchInvHeader);
    //     PurchInvHeader := Rec;
    //     PurchInvHeader.SETRANGE("Item Charge Type Filter", ItemChargeType);
    //     PurchInvHeader.GetPurchInvLines(PurchInvLineBuf);
    //     PurchInvHeader.SETRANGE("Item Charge Type Filter");

    //     CLEAR(PurchInvLine);
    //     // always on 0
    //     PurchInvLine.CalcVATAmountLinesTemp(PurchInvHeader, PurchInvLineBuf, VATAmountLineBuf);

    //     if PurchInvLineBuf.FINDFIRST then
    //         repeat
    //             ItemChargeAmtBuf.PurchInvTransferfields(PurchInvHeader, PurchInvLineBuf);
    //             ItemChargeAmtBuf.InsertAsGroup(false);
    //         until PurchInvLineBuf.NEXT = 0;

    //     PAGE.RUN(0, ItemChargeAmtBuf);
    // end;

    // procedure SetVatChargeTextHeader(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion);
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     ActiveSubTab := ItemChargeType;
    //     EVALUATE(j, FORMAT(ItemChargeType, 0, 2));
    //     VATAmountTextChargeHeader := VATAmountTextCharge[j];
    // end;

    // local procedure InvDiscAmountOnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification(ActiveTab::General);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure VendAmountOnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification(ActiveTab::General);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure VATAmountOnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification(ActiveTab::General);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure AmountInclVATOnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification(ActiveTab::General);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure VendBalanceLCYOnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification(ActiveTab::Vendor);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure TotalAmountCharge26OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalAmountCharge24OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalAmountCharge23OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalAmountCharge22OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure VATAmountCharge6OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure VATAmountCharge4OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure VATAmountCharge3OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure VATAmountCharge2OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure VATAmountCharge1OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalAmountCharge21OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalPurchInvLineCharge6LineAm();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalPurchInvLineCharge4LineAm();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalPurchInvLineCharge3LineAm();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalPurchInvLineCharge2LineAm();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure TotalPurchInvLineCharge1LineAm();
    // begin
    //     SetVATSpecificationCharge(PurchInvHeader."Item Charge Type Filter"::Tax);
    // end;
    //BC UPGRADE SIVA << Drink IT code  
    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

