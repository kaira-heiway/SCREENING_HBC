pageextension 52025 PurchaseReceiptStatisticsExt extends "Purchase Receipt Statistics"
{
    // version NAVW16.00,DITW18.00
    // DITW15.00.00.19 DDR 13/06/2008 Added Amount fields (like Invoice statistics)
    //   DITW15.00.00.35 DDR 22/06/2009 Added Statistic Drink-it tab
    //                                  Using (available) flowfilters
    //                                  Added functions
    //                                    SetVATSpecification(),SetVATSpecificationCharge(),
    //                                    DrillDownChargeLines(),SetVatChargeTextHeader()
    //   DITW15.00.00.36 DDR 18/12/2009 issue 989 Bugfix OnActivate first control/first tab
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
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
        modify(LineQty)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify(TotalParcels)
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
        }
        modify(TotalNetWeight)
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify(TotalGrossWeight)
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
        }
        modify(TotalVolume)
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
        }
        addfirst(General)
        {
            group(Control1100083001)
            {
                field("VendAmount + InvDiscAmount"; VendAmount + InvDiscAmount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Amount';
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Amount',
                                FRA = 'Montant';
                }
                field(InvDiscAmount; InvDiscAmount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Inv. Discount Amount';
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Inv. Discount Amount',
                                FRA = 'Montant remise facture';
                }
                field(VendAmount; VendAmount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Total';
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Total',
                                FRA = 'Total';
                }
                field(VATAmount; VATAmount)
                {
                    ToolTip = 'VAT Amount';
                    ApplicationArea = all;
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT(VATAmountText);
                    CaptionML = ENU = 'VAT Amount',
                                FRA = 'Montant TVA';
                }
                //BC UPGRADE SIVA >> CADFIELD
                field(CADAmount; CADAmount)
                {
                    ApplicationArea = All;
                    Caption = 'CAD Amount';
                    Editable = false;
                    Visible = EnableCAD;
                }
                //BC UPGRADE SIVA << CADFIELD
                field(AmountInclVAT; AmountInclVAT)
                {
                    ApplicationArea = all;
                    ToolTip = 'Total Incl. VAT';
                    AutoFormatExpression = Rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Total Incl. VAT',
                                FRA = 'Total TTC';
                }
                field(AmountLCY; AmountLCY)
                {
                    ApplicationArea = all;
                    ToolTip = 'Purchase (LCY)';
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Purchase (LCY)',
                                FRA = 'Achats DS';
                }
            }
        }
        addafter(General)
        {
            part(SubForm; "VAT Specification Subform")
            {
                ApplicationArea = all;
                Editable = false;
            }
            group(Vendor)
            {
                CaptionML = ENU = 'Vendor',
                            FRA = 'Fournisseur';
                field("Vend.Balance (LCY)"; Vend."Balance (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Balance (LCY)';
                    AutoFormatType = 1;
                    CaptionML = ENU = 'Balance (LCY)',
                                FRA = 'Solde DS';
                }
            }
            //BC UPGRADE SIVA >> Drink IT Code
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
            //                 ToolTip = 'Placeholder';
            //                 ApplicationArea = all;
            //                 Editable = false;
            //                 Visible = false;
            //             }
            //             field(TotalPurchRcptLineCharge[1]."Line Amount"; TotalPurchRcptLineCharge[1]."Line Amount")
            //             {
            //                 ApplicationArea =all;
            //                 AutoFormatExpression = REc."Currency Code";
            //                 AutoFormatType = 1;

            //                 ToolTip  ='Tax';
            //                 CaptionML = ENU = 'Tax',
            //                             FRA = 'Taxes';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchRcptHeader."Item Charge Type Filter"::Tax, FIELDNO(Amount));
            //                 end;
            //             }
            //             field("TotalPurchRcptLineCharge[2].""Line Amount"""; TotalPurchRcptLineCharge[2]."Line Amount")
            //             {
            //                 ApplicationArea =all;
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Deposit',
            //                             FRA = 'Consigne';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchRcptHeader."Item Charge Type Filter"::Deposit, FIELDNO(Amount));
            //                 end;
            //             }
            //             field("TotalPurchRcptLineCharge[3].""Line Amount"""; TotalPurchRcptLineCharge[3]."Line Amount")
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Discount/ Charge',
            //                             FRA = 'Remise / Frais';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchRcptHeader."Item Charge Type Filter"::Discount, FIELDNO(Amount));
            //                 end;
            //             }
            //             field("TotalPurchRcptLineCharge[4].""Line Amount"""; TotalPurchRcptLineCharge[4]."Line Amount")
            //             {
            //                 AutoFormatExpression = "Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Promotion',
            //                             FRA = 'Promotion';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchRcptHeader."Item Charge Type Filter"::Promotion, FIELDNO(Amount));
            //                 end;
            //             }
            //             field("TotalPurchRcptLineCharge[6].""Line Amount"""; TotalPurchRcptLineCharge[6]."Line Amount")
            //             {
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Shipping Cost',
            //                             FRA = 'Coût transport';
            //                 Editable = false;

            //                 trigger OnDrillDown();
            //                 begin
            //                     DrillDownChargeLines(PurchRcptHeader."Item Charge Type Filter"::ShippingCost, FIELDNO(Amount));
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
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'VAT Amount',
            //                             FRA = 'Montant TVA';
            //                 Editable = false;
            //             }
            //             field("VATAmountCharge[2]"; VATAmountCharge[2])
            //             {
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'VAT Amount',
            //                             FRA = 'Montant TVA';
            //                 Editable = false;
            //             }
            //             field("VATAmountCharge[3]"; VATAmountCharge[3])
            //             {
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'VAT Amount',
            //                             FRA = 'Montant TVA';
            //                 Editable = false;
            //             }
            //             field("VATAmountCharge[4]"; VATAmountCharge[4])
            //             {
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'VAT Amount',
            //                             FRA = 'Montant TVA';
            //                 Editable = false;
            //             }
            //             field("VATAmountCharge[6]"; VATAmountCharge[6])
            //             {
            //                 AutoFormatExpression = Rec."Currency Code";
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
            //                 ApplicationArea =all;
            //                 Editable = false;
            //                 Visible = false;
            //             }
            //             field("TotalAmountCharge2[1]"; TotalAmountCharge2[1])
            //             {
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 CaptionML = ENU = 'Total Incl. VAT',
            //                             FRA = 'Total TTC';
            //                 Editable = false;
            //             }
            //             field("TotalAmountCharge2[2]"; TotalAmountCharge2[2])
            //             {
            //                 ApplicationArea =all;
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 Editable = false;
            //             }
            //             field("TotalAmountCharge2[3]"; TotalAmountCharge2[3])
            //             {
            //                 ApplicationArea =all;
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 Editable = false;
            //             }
            //             field("TotalAmountCharge2[4]"; TotalAmountCharge2[4])
            //             {
            //                 ApplicationArea =all;
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 Editable = false;
            //             }
            //             field("TotalAmountCharge2[6]"; TotalAmountCharge2[6])
            //             {
            //                 ApplicationArea =all;
            //                 AutoFormatExpression = Rec."Currency Code";
            //                 AutoFormatType = 1;
            //                 Editable = false;
            //             }
            //         }
            //     }
            // }
            //BC UPGRADE SIVA << Drink IT Code
        }
    }

    var
        TempPurchRcptLine: Record "Purch. Rcpt. Line" temporary;
        PurchRcptLine: Record "Purch. Rcpt. Line";
        Vend: Record Vendor;

    var
        Text000: TextConst ENU = 'VAT Amount', FRA = 'Montant TVA';
        Text001: TextConst ENU = '%1% VAT', FRA = 'TVA %1%';
        CurrExchRate: Record "Currency Exchange Rate";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        Currency: Record Currency;
        VendAmount: Decimal;
        AmountInclVAT: Decimal;
        InvDiscAmount: Decimal;
        AmountLCY: Decimal;
        VATAmount: Decimal;
        VATPercentage: Decimal;
        VATAmountText: Text[30];
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        TempVATAmountLineCharge1: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge2: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge3: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge4: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge6: Record "VAT Amount Line" temporary;
        TotalPurchRcptLineCharge: array[6] of Record "Purch. Rcpt. Line";
        TotalPurchRcptLineChargeLCY: array[6] of Record "Purch. Rcpt. Line";
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

    //trigger (Variable: TempPurchRcptLine)();
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

    PurchRcptLine.SETRANGE("Document No.","No.");

    if PurchRcptLine.FIND('-') then
      repeat
        LineQty := LineQty + PurchRcptLine.Quantity;
        TotalNetWeight := TotalNetWeight + (PurchRcptLine.Quantity * PurchRcptLine."Net Weight");
        TotalGrossWeight := TotalGrossWeight + (PurchRcptLine.Quantity * PurchRcptLine."Gross Weight");
        TotalVolume := TotalVolume + (PurchRcptLine.Quantity * PurchRcptLine."Unit Volume");
        if PurchRcptLine."Units per Parcel" > 0 then
          TotalParcels := TotalParcels + ROUND(PurchRcptLine.Quantity / PurchRcptLine."Units per Parcel",1,'>');
      until PurchRcptLine.NEXT = 0;
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

    // <<DITW15.00.00.21 DDR 13/06/2008
    if "Currency Code" = '' then
      Currency.InitRoundingPrecision
    else
      Currency.GET("Currency Code");
    // >>DITW15.00.00.21 DDR
    #2..6
        // <<DITW15.00.00.21 DDR 13/06/2008
        VendAmount := VendAmount + PurchRcptLine.Amount;
        AmountInclVAT := AmountInclVAT + PurchRcptLine."Amount Including VAT";
        if "Prices Including VAT" then
          InvDiscAmount := InvDiscAmount + PurchRcptLine."Inv. Discount Amount" / (1 + PurchRcptLine."VAT %" / 100)
        else
          InvDiscAmount := InvDiscAmount + PurchRcptLine."Inv. Discount Amount";
        // >>DITW15.00.00.21 DDR
    #7..12
        // <<DITW15.00.00.21 DDR 13/06/2008
        if PurchRcptLine."VAT %" <> VATPercentage then
          if VATPercentage = 0 then
            VATPercentage := PurchRcptLine."VAT %"
          else
            VATPercentage := -1;
      until PurchRcptLine.NEXT = 0;

    // <<DITW15.00.00.35 DDR 22/06/2009
    GetPurchRcptLines(TempPurchRcptLine);
    with PurchRcptLine do
      for "Item Charge Type" := "Item Charge Type"::Tax to "Item Charge Type"::ShippingCost do begin
        CLEAR(PurchRcptHeader);
        PurchRcptHeader := Rec;
        PurchRcptHeader.SETRANGE("Item Charge Type Filter","Item Charge Type");
        TempPurchRcptLine.RESET;
        TempPurchRcptLine.SETRANGE("Item Charge Type","Item Charge Type");
        case "Item Charge Type" of
          "Item Charge Type"::Tax:
            PurchRcptLine.CalcVATAmountLinesTemp(PurchRcptHeader,TempPurchRcptLine,TempVATAmountLineCharge1);
          "Item Charge Type"::Deposit:
            PurchRcptLine.CalcVATAmountLinesTemp(PurchRcptHeader,TempPurchRcptLine,TempVATAmountLineCharge2);
          "Item Charge Type"::Discount:
            PurchRcptLine.CalcVATAmountLinesTemp(PurchRcptHeader,TempPurchRcptLine,TempVATAmountLineCharge3);
          "Item Charge Type"::Promotion:
             PurchRcptLine.CalcVATAmountLinesTemp(PurchRcptHeader,TempPurchRcptLine,TempVATAmountLineCharge4);
          "Item Charge Type"::ShippingCost:
             PurchRcptLine.CalcVATAmountLinesTemp(PurchRcptHeader,TempPurchRcptLine,TempVATAmountLineCharge6);
        end;
        EVALUATE(j,FORMAT("Item Charge Type",0,2));
        PurchRcptHeader.SumPurchRcptLinesTemp(
          TempPurchRcptLine,TotalPurchRcptLineCharge[j],TotalPurchRcptLineChargeLCY[j],
          VATAmountCharge[j],VATAmountTextCharge[j]);

        if "Prices Including VAT" then begin
          TotalAmountCharge2[j] := TotalPurchRcptLineCharge[j].Amount;
          TotalAmountCharge1[j] := TotalAmountCharge2[j] + VATAmountCharge[j];
          TotalPurchRcptLineCharge[j]."Line Amount" := TotalAmountCharge1[j] + TotalPurchRcptLineCharge[j]."Inv. Discount Amount";
        end else begin
          TotalAmountCharge1[j] := TotalPurchRcptLineCharge[j].Amount;
          TotalAmountCharge2[j] := TotalPurchRcptLineCharge[j]."Amount Including VAT";
        end;
      end;
    CLEAR(TempPurchRcptLine);
    CLEAR(PurchRcptLine);
    // >>DITW15.00.00.35 DDR

    //HEI.01>>
    if EnableCAD then begin
      PurchRcptLine.SETRANGE("Document No.","No.");
      PurchRcptLine.CALCSUMS("CAD Amount");
      CADAmount := PurchRcptLine."CAD Amount";
    end;
    //HEI.01<<
    VATAmount := AmountInclVAT - VendAmount;
    InvDiscAmount := ROUND(InvDiscAmount,Currency."Amount Rounding Precision");

    if VATPercentage <= 0 then
      VATAmountText := Text000
    else
      VATAmountText := STRSUBSTNO(Text001,VATPercentage);

    if "Currency Code" = '' then
      AmountLCY := VendAmount
    else
      AmountLCY :=
        CurrExchRate.ExchangeAmtFCYToLCY(
          WORKDATE,"Currency Code",VendAmount,"Currency Factor");

    if not Vend.GET("Pay-to Vendor No.") then
      CLEAR(Vend);
    Vend.CALCFIELDS("Balance (LCY)");

    // <<DITW15.00.00.35 DDR 22/06/2009
     PurchRcptLine.CalcVATAmountLines(Rec,TempVATAmountLine);
     CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLine);
     CurrPage.SubForm.PAGE.InitGlobals("Currency Code",false,false,false,false,"VAT Base Discount %");
    // moved call Subform
    SubformIsReady := true;
    // >>DITW15.00.00.35 DDR
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
            PurchRcptLine.SETRANGE("Document No.", Rec."No.");
            PurchRcptLine.CALCSUMS("CAD Amount FND");
            CADAmount := PurchRcptLine."CAD Amount FND";
        end;
        //HEI.01<<
        //BC UPGRADE SIVA << CADFIELD

    end;

    //BC UPGRADE SIVA >> Drink IT code  
    // local procedure SetVATSpecification(SelectedActiveTab: Option General,Vendor,,,,,"Drink-It");
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     if not SubformIsReady then
    //         exit;

    //     ActiveTab := SelectedActiveTab;
    //     PurchRcptLine.CalcVATAmountLines(Rec, TempVATAmountLine);
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
    //     PurchRcptLine: Record "Purch. Rcpt. Line";
    //     PurchRcptLineBuf: Record "Purch. Rcpt. Line" temporary;
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     CLEAR(PurchRcptHeader);
    //     PurchRcptHeader := Rec;
    //     PurchRcptHeader.SETRANGE("Item Charge Type Filter", ItemChargeType);
    //     PurchRcptHeader.GetPurchRcptLines(PurchRcptLineBuf);
    //     PurchRcptHeader.SETRANGE("Item Charge Type Filter");

    //     CLEAR(PurchRcptLine);
    //     // always on 0
    //     PurchRcptLine.CalcVATAmountLinesTemp(PurchRcptHeader, PurchRcptLineBuf, VATAmountLineBuf);

    //     if PurchRcptLineBuf.FINDFIRST then
    //         repeat
    //             ItemChargeAmtBuf.PurchRcptTransferfields(PurchRcptLineBuf);
    //             ItemChargeAmtBuf.InsertAsGroup(false);
    //         until PurchRcptLineBuf.NEXT = 0;

    //     PAGE.RUN(0, ItemChargeAmtBuf);
    // end;

    // procedure SetVatChargeTextHeader(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion);
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     ActiveSubTab := ItemChargeType;
    //     EVALUATE(j, FORMAT(ItemChargeType, 0, 2));
    //     VATAmountTextChargeHeader := VATAmountTextCharge[j];
    // end;

    // local procedure AmountInclVATOnActivate();
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

    // local procedure VendAmountOnActivate();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification(ActiveTab::General);
    //     // >>DITW15.00.00.35 DDR
    // end;

    // local procedure InvDiscAmountOnActivate();
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

    // local procedure TotalAmountCharge21OnActivate();
    // begin
    //     Rec.SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalAmountCharge22OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure TotalAmountCharge23OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalAmountCharge24OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalAmountCharge26OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure VATAmountCharge6OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure VATAmountCharge4OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure VATAmountCharge3OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure VATAmountCharge2OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure VATAmountCharge1OnActivate();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalPurchRcptLineCharge1LineA();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalPurchRcptLineCharge2LineA();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure TotalPurchRcptLineCharge3LineA();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalPurchRcptLineCharge4LineA();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalPurchRcptLineCharge6LineA();
    // begin
    //     SetVATSpecificationCharge(PurchRcptHeader."Item Charge Type Filter"::Promotion);
    // end;
    //BC UPGRADE SIVA << Drink IT code 

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

