pageextension 53029 SalesStatisticsExt extends "Sales Statistics"
{
    // version NAVW110.0,DITW110.00.08

    //     DITW15.00.00.35 DDR 22/06/2009 Added Statistic Drink-it tab
    //                                Using (available) flowfilters
    //                                Added functions
    //                                  SetVATSpecificationCharge(),DrillDownChargeLines(),SetVatChargeTextHeader()
    // DITW15.00.00.36 DDR 18/12/2009 issue 989 Bugfix OnActivate first control/first tab
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 FDD-XXXXXX001 IBM POSTOI01 11.01.2018
    //   # New variables : TotalAmount3 (decinmal) and WHTManagement (codeunit)
    //   # New field shown in the page designer: WHT Amount (variable TotalAmount3)
    //   # OnAfterGetRecord modified : add procedure to calculate TotalAmount3
    // HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Field 'CAD Amount' created
    //   # New Global Variable 'CADAmount' created
    //   # Code added on 'OnAfterGetRecord' trigger

    //Bc Upgrade YADAVM09 Drink it field commented.
    // BC Upgrade BHARDA11 >>---Unblock CAD Amount Functionality
    //There were CAD Amount–related customizations inside the UpdateHeaderInfo function, so we created a new function to handle that logic separately.
    // The purpose of creating the new function UpdateHeaderInfoCADAmount() was that the CADAmount variable used inside the function is also used in a layout field. This was not possible to achieve through an event subscriber.
    // Now, we will call this new function UpdateHeaderInfoCADAmount() under the same conditions wherever UpdateHeaderInfo was previously being called.
    // The reason for this approach is that UpdateHeaderInfo was not being called directly in the OnAfterGetRecord trigger; instead, it was called inside other functions. Those functions themselves were triggered either on OnAfterGetRecord or on a field’s OnValidate trigger.
    // Therefore, we have implemented the new function in the OnAfterGetRecord trigger with the appropriate conditions so that the output remains the same as before.
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
            ToolTipML = ENU = 'Specifies the net amount of all the lines in the sales document.', FRA = 'Spécifie le montant net de toutes les lignes du document vente.';
        }
        modify(InvDiscountAmount)
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies the invoice discount amount for the sales document.', FRA = 'Spécifie le montant de la remise facture du document de vente.';
        }
        modify(TotalAmount1)
        {
            CaptionML = ENU = 'Total', FRA = 'Total';
            ToolTipML = ENU = 'Specifies the total amount less any invoice discount amount and excluding VAT for the sales document.', FRA = 'Spécifie le montant total hors taxes et sans remise facture du document de vente.';
        }
        modify(VATAmount)
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
            ToolTipML = ENU = 'Specifies the total VAT amount that has been calculated for all the lines in the sales document.', FRA = 'Spécifie le montant total de la TVA qui a été calculée pour toutes les lignes du document vente.';
        }
        modify(TotalAmount2)
        {
            CaptionML = ENU = 'Total Incl. VAT', FRA = 'Total TTC';
            ToolTipML = ENU = 'Specifies the total amount including VAT that will be posted to the customer''s account for all the lines in the sales document. This is the amount that the customer owes based on this sales document. If the document is a credit memo, it is the amount that you owe to the customer.', FRA = 'Spécifie le montant total TTC, qui est validé sur le compte du client pour toutes les lignes du document vente. C''est le montant dû par le client si vous vous référez à ce document vente. (Si le document est un avoir, ce montant est celui que vous devez au client).';
        }
        modify("TotalSalesLineLCY.Amount")
        {
            CaptionML = ENU = 'Sales (LCY)', FRA = 'Ventes DS';
            ToolTipML = ENU = 'Specifies your total sales turnover in the fiscal year. It is calculated from amounts excluding VAT on all completed and open sales invoices and credit memos.', FRA = 'Spécifie votre rotation totale des ventes au cours de l''exercice comptable. Il est calculé à partir des montants HT sur toutes les factures vente et avoirs terminés et ouverts.';
        }
        modify(ProfitLCY)
        {
            CaptionML = ENU = 'Original Profit (LCY)', FRA = 'Marge initiale DS';
            ToolTipML = ENU = 'Specifies the original profit that was associated with the sales when they were originally posted.', FRA = 'Spécifie la marge initiale qui a été associée aux ventes lors de leur validation initiale.';
        }
        modify(AdjProfitLCY)
        {
            CaptionML = ENU = 'Adjusted Profit (LCY)', FRA = 'Marge ajustée DS';
            ToolTipML = ENU = 'Specifies the profit, taking into consideration changes in the purchase prices of the goods.', FRA = 'Spécifie la marge, en tenant compte des modifications apportées aux prix d''achat des biens.';
        }
        modify(ProfitPct)
        {
            CaptionML = ENU = 'Original Profit %', FRA = '% marge initiale';
            ToolTipML = ENU = 'Specifies the original percentage of profit that was associated with the sales when they were originally posted.', FRA = 'Spécifie le pourcentage initial de marge qui a été associé aux ventes lors de leur validation initiale.';
        }
        modify(AdjProfitPct)
        {
            CaptionML = ENU = 'Adjusted Profit %', FRA = '% marge ajustée';
            ToolTipML = ENU = 'Specifies the percentage of profit for all sales, taking into account changes that occurred in the purchase prices of the goods.', FRA = 'Spécifie le pourcentage de marge de toutes les ventes, en tenant compte des modifications apportées aux prix d''achat des biens.';
        }
        modify("TotalSalesLine.Quantity")
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
            ToolTipML = ENU = 'Specifies the total quantity of G/L account entries, items, and/or resources in the sales document. If the amount is rounded, because the Invoice Rounding check box is selected in the Sales & Receivables Setup window, this field will contain the quantity of items in the sales document plus one.', FRA = 'Spécifie la quantité totale des écritures comptables, article ou ressources du document vente. Si le montant est arrondi parce que la case à cocher Arrondi facture de la table Paramètres ventes est activée, ce champ indique la quantité d''articles du document vente, plus un.';
        }
        modify("TotalSalesLine.""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
            ToolTipML = ENU = 'Specifies the total number of parcels in the sales document.', FRA = 'Spécifie le nombre total de colis du document vente.';
        }
        modify("TotalSalesLine.""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            ToolTipML = ENU = 'Specifies the total net weight of the items in the sales document.', FRA = 'Spécifie le poids net total des articles du document vente.';
        }
        modify("TotalSalesLine.""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
            ToolTipML = ENU = 'Specifies the total gross weight of the items in the sales document.', FRA = 'Spécifie le poids brut total des articles du document vente.';
        }
        modify("TotalSalesLine.""Unit Volume""")
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
            ToolTipML = ENU = 'Specifies the total volume of the items in the sales document.', FRA = 'Spécifie le volume total des articles du document vente.';
        }
        modify("TotalSalesLineLCY.""Unit Cost (LCY)""")
        {
            CaptionML = ENU = 'Original Cost (LCY)', FRA = 'Coût initial DS';
            ToolTipML = ENU = 'Specifies the total cost, in LCY, of the G/L account entries, items, and/or resources in the sales document. The cost is calculated as unit cost x quantity of the items or resources.', FRA = 'Spécifie le coût total, en devise société, des écritures comptables, article ou ressources du document vente. Le coût est calculé comme suit : coût unitaire x quantité des articles ou des ressources.';
        }
        modify(TotalAdjCostLCY)
        {
            CaptionML = ENU = 'Adjusted Cost (LCY)', FRA = 'Coût ajusté DS';
            ToolTipML = ENU = 'Specifies the total cost, in LCY, of the items in the sales document, adjusted for any changes in the original costs of these items. If this field contains zero, it means that there were no entries to calculate, possibly because of date compression or because the adjustment batch job has not yet been run.', FRA = 'Spécifie le coût total, en devise société, des articles figurant dans le document vente, ajusté en fonction des modifications apportées au coût initial de ces articles. Si la valeur du champ est zéro, cela signifie qu''il n''y a pas eu d''écritures à calculer, probablement en raison d''une compression ou parce que le traitement par lot de l''ajustement n''a pas encore été exécuté.';
        }
        modify("TotalAdjCostLCY - TotalSalesLineLCY.""Unit Cost (LCY)""")
        {
            CaptionML = ENU = 'Cost Adjmt. Amount (LCY)', FRA = 'Montant ajust. coût DS';
            ToolTipML = ENU = 'Specifies the difference between the original cost and the total adjusted cost of the items in the sales document.', FRA = 'Spécifie la différence entre le coût initial et le coût total ajusté des articles figurant dans le document vente.';
        }
        modify(Customer)
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
        }
        modify("Cust.""Balance (LCY)""")
        {
            CaptionML = ENU = 'Balance (LCY)', FRA = 'Solde DS';
            ToolTipML = ENU = 'Specifies the balance on the customer''s account.', FRA = 'Spécifie le solde du compte client.';
        }
        modify("Cust.""Credit Limit (LCY)""")
        {
            CaptionML = ENU = 'Credit Limit (LCY)', FRA = 'Crédit autorisé DS';
            ToolTipML = ENU = 'Specifies the credit limit of the customer that you created the sales document for.', FRA = 'Spécifie le crédit autorisé du client pour qui le document vente a été créé.';
        }
        modify(CreditLimitLCYExpendedPct)
        {
            CaptionML = ENU = 'Expended % of Credit Limit (LCY)', FRA = '% crédit autorisé étendu DS';
            ToolTipML = ENU = 'Specifies the expended percentage of the credit limit in (LCY).', FRA = 'Spécifie le pourcentage étendu de la limite de crédit (en DS).';
        }
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

        addafter(TotalAmount2)
        {
            field("<TotalAmount3>"; TotalAmount3)
            {
                CaptionML = ENU = 'WHT Amount',
                            ESP = 'Importe WHT',
                            FRA = 'Montant WHT';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(Customer)
        {
            group("Drink-It")
            {
                CaptionML = ENU = 'Drink-It',
                            FRA = 'Drink-It';
                fixed(Control1902989901)
                {
                    //Bc Upgrade YADAVM09 Drink it fields>>
                    //group(" ")
                    //{
                    //     Caption = '" "';
                    //     field("LCaptionClassTranslate(Text002,false)"; LCaptionClassTranslate(Text002, false))
                    //     {
                    //         Editable = false;
                    //     }

                    // field("TotalSalesLineCharge[1].""Line Amount"""; TotalSalesLineCharge[1]."Line Amount")
                    // {
                    //     AutoFormatExpression = Rec."Currency Code";
                    //     AutoFormatType = 1;
                    //     CaptionML = ENU = 'Tax',
                    //                 FRA = 'Taxes';
                    //     Editable = false;

                    //     trigger OnDrillDown();
                    //     begin
                    //         DrillDownChargeLines(SalesHeader."Item Charge Type Filter"::Tax, FIELDNO(Amount));
                    //     end;
                    // }
                    // field("TotalSalesLineCharge[2].""Line Amount"""; TotalSalesLineCharge[2]."Line Amount")
                    // {
                    //     AutoFormatExpression = Rec."Currency Code";
                    //     AutoFormatType = 1;
                    //     CaptionML = ENU = 'Deposit',
                    //                 FRA = 'Consigne';
                    //     Editable = false;

                    //     trigger OnDrillDown();
                    //     begin
                    //         DrillDownChargeLines(SalesHeader."Item Charge Type Filter"::Deposit, FIELDNO(Amount));
                    //     end;
                    // }
                    // field("TotalSalesLineCharge[3].""Line Amount"""; TotalSalesLineCharge[3]."Line Amount")
                    // {
                    //     AutoFormatExpression = "Currency Code";
                    //     AutoFormatType = 1;
                    //     CaptionML = ENU = 'Discount/ Charge',
                    //                 FRA = 'Remise / Frais';
                    //     Editable = false;

                    //     trigger OnDrillDown();
                    //     begin
                    //         DrillDownChargeLines(SalesHeader."Item Charge Type Filter"::Discount, FIELDNO(Amount));
                    //     end;
                    // }
                    // field("TotalSalesLineCharge[4].""Line Amount"""; TotalSalesLineCharge[4]."Line Amount")
                    // {
                    //     AutoFormatExpression = Rec."Currency Code";
                    //     AutoFormatType = 1;
                    //     CaptionML = ENU = 'Promotion',
                    //                 FRA = 'Promotion';
                    //     Editable = false;

                    //     trigger OnDrillDown();
                    //     begin
                    //         DrillDownChargeLines(SalesHeader."Item Charge Type Filter"::Promotion, FIELDNO(Rec.Amount));
                    //     end;
                    // }
                    // }//Bc Upgrade YADAVM09 Drink it field<<
                    group(Control1906369401)
                    {
                        Caption = '" "';
                        field(VATAmountTxt; Text006)
                        {
                            Editable = false;
                            Visible = VATAmountTxtVisible;
                            ApplicationArea = All;
                        }
                        field("VATAmountCharge[1]"; VATAmountCharge[1])
                        {
                            AutoFormatExpression = Rec."Currency Code";
                            AutoFormatType = 1;
                            CaptionClass = FORMAT(VATAmountTextChargeHeader);
                            Editable = false;
                            ApplicationArea = All;
                        }
                        field("VATAmountCharge[2]"; VATAmountCharge[2])
                        {
                            AutoFormatExpression = Rec."Currency Code";
                            AutoFormatType = 1;
                            Editable = false;
                            ApplicationArea = All;
                        }
                        field("VATAmountCharge[3]"; VATAmountCharge[3])
                        {
                            AutoFormatExpression = Rec."Currency Code";
                            AutoFormatType = 1;
                            Editable = false;
                            ApplicationArea = All;
                        }
                        field("VATAmountCharge[4]"; VATAmountCharge[4])
                        {
                            AutoFormatExpression = Rec."Currency Code";
                            AutoFormatType = 1;
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1904583801)
                    {
                        Caption = '" "';
                        //Bc Upgrade YADAVM09 Drink it function>>
                        // field("LCaptionClassTranslate(Text001,true)"; LCaptionClassTranslate(Text001, true))
                        // {
                        //     Editable = false;
                        // }//Bc Upgrade YADAVM09 Drink it function<<
                        field("TotalAmountCharge2[1]"; TotalAmountCharge2[1])
                        {
                            AutoFormatExpression = Rec."Currency Code";
                            AutoFormatType = 1;
                            Editable = false;
                            ApplicationArea = All;
                        }
                        field("TotalAmountCharge2[2]"; TotalAmountCharge2[2])
                        {
                            AutoFormatExpression = Rec."Currency Code";
                            AutoFormatType = 1;
                            Editable = false;
                            ApplicationArea = All;
                        }
                        field("TotalAmountCharge2[3]"; TotalAmountCharge2[3])
                        {
                            AutoFormatExpression = Rec."Currency Code";
                            AutoFormatType = 1;
                            Editable = false;
                            ApplicationArea = All;
                        }
                        field("TotalAmountCharge2[4]"; TotalAmountCharge2[4])
                        {
                            AutoFormatExpression = Rec."Currency Code";
                            AutoFormatType = 1;
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }

    var
        j: Integer;
        SalesLine2: Record "Sales Line";

    var
        GeneralLedgerSetup: Record "General Ledger Setup";


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Sales %1 Statistics;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Sales %1 Statistics;FRA=Statistiques %1 vente;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Total;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Total;FRA=Total;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Amount;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Amount;FRA=Montant;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=%1 must not be 0.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=%1 must not be 0.;FRA=%1 ne doit pas être 0.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=%1 must not be greater than %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=%1 must not be greater than %2.;FRA=%1 ne doit pas être supérieur(e) à %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : @@@=You cannot change the invoice discount because there is a Cust. Invoice Disc. record for Invoice Disc. Code 30000.;ENU=You cannot change the invoice discount because there is a %1 record for %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : @@@=You cannot change the invoice discount because there is a Cust. Invoice Disc. record for Invoice Disc. Code 30000.;ENU=You cannot change the invoice discount because there is a %1 record for %2 %3.;FRA=Vous ne pouvez pas modifier la remise facture car il existe un enregistrement %1 pour %2 %3.;
    //Variable type has not been exported.

    var
        PrevRec: Record "Sales Header" temporary;
        SalesHeader: Record "Sales Header";
        TempVATAmountLineCharge1: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge2: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge3: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge4: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge6: Record "VAT Amount Line" temporary;
        TotalSalesLineCharge: array[6] of Record "Sales Line";
        TotalSalesLineChargeLCY: array[6] of Record "Sales Line";
        VATAmountCharge: array[6] of Decimal;
        VATAmountTextCharge: array[6] of Text[30];
        VATAmountTextChargeHeader: Text[30];
        TotalAmountCharge1: array[6] of Decimal;
        TotalAmountCharge2: array[6] of Decimal;
        Text006: TextConst ENU = 'VAT Amount', FRA = 'Montant TVA';
        VATAmountTxtVisible: Boolean;
        TotalAmount3: Decimal;
        WHTManagement: Codeunit WHTManagement;
        //Amount: Decimal;//BC Upgrade YADAVM09 out of Scope CAD Functionality
        EnableCAD: Boolean;
        CADAmount: Decimal;
    // BC Upgrade BHARDA11 >> ----There were CAD Amount–related customizations inside the UpdateHeaderInfo function, so we created a new function to handle that logic separately.
    // The purpose of creating the new function UpdateHeaderInfoCADAmount() was that the CADAmount variable used inside the function is also used in a layout field. This was not possible to achieve through an event subscriber.
    // Now, we will call this new function UpdateHeaderInfoCADAmount() under the same conditions wherever UpdateHeaderInfo was previously being called.
    // The reason for this approach is that UpdateHeaderInfo was not being called directly in the OnAfterGetRecord trigger; instead, it was called inside other functions. Those functions themselves were triggered either on OnAfterGetRecord or on a field’s OnValidate trigger.
    // Therefore, we have implemented the new function in the OnAfterGetRecord trigger with the appropriate conditions so that the output remains the same as before.
    local procedure UpdateHeaderInfoCADAmount()
    begin
        CurrPage.SubForm.PAGE.GetTempVATAmountLine(TempVATAmountLine);
        CADAmount := TempVATAmountLine.GetTotalCADAmount; //HEI.02
    end;
    // BC Upgrade BHARDA11 <<


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger (Variable: j)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    var
        SalesLine2: Record "Sales Line";
    begin
        //>>HEI.01 FDD-XXXXXX001
        TotalAmount3 := WHTManagement.StatisticsCalcWHTAmount(37, Rec."No.", Rec."Document Type".AsInteger());
        //<<HEI.01 FDD-XXXXXX001

        // BC Upgrade BHARDA11 >> 
        //HEI.02>>
        IF EnableCAD THEN BEGIN
            SalesLine2.SETRANGE("Document Type", Rec."Document Type");
            SalesLine2.SETRANGE("Document No.", Rec."No.");
            IF SalesLine2.FINDSET() THEN
                REPEAT
                    CADAmount += SalesLine2."CAD Amount FND";
                UNTIL SalesLine2.NEXT() = 0;
        END;
        //HEI.02<< 
        // BC Upgrade BHARDA11 << 
        // BC Upgrade BHARDA11 >> ---There are some CAD Amount related code under function UpdateHeaderInfo. For that code we are creating a new function UpdateHeaderInfoCADAmount and call that function.
        CurrPage.SubForm.PAGE.GetTempVATAmountLine(TempVATAmountLine);
        IF TempVATAmountLine.GetAnyLineModified THEN
            UpdateHeaderInfoCADAmount();
        // BC Upgrade BHARAD11 << ---There are some CAD Amount related code under function UpdateHeaderInfo. For that code we are creating a new function UpdateHeaderInfoCADAmount and call that function.
    end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.CAPTION(STRSUBSTNO(Text000,"Document Type"));
    // <<DITW15.00.00.35 DDR 22/06/2009
    // IF PrevNo = "No." THEN
    if (PrevNo = "No.") and (PrevRec.GETFILTERS() = GETFILTERS()) then begin
    // >>DITW15.00.00.35 DDR
    #3..6
    // <<DITW15.00.00.35 DDR 22/06/2009
    PrevRec.COPY(Rec);
    SalesHeader := Rec;
    // >>DITW15.00.00.35 DDR
    #7..13
    // <<DITW15.00.00.35 DDR 22/06/2009
    CLEAR(TotalSalesLineCharge);
    CLEAR(TotalSalesLineChargeLCY);
    // >>DITW15.00.00.35 DDR
    #14..20
      // <<DITW15.00.00.35 DDR 22/06/2009
      with SalesLine do
        for "Item Charge Type" := "Item Charge Type"::Tax to "Item Charge Type"::ShippingCost do begin
          SalesHeader.SETRANGE("Item Charge Type Filter","Item Charge Type");
          TempSalesLine.RESET;
          TempSalesLine.SETRANGE("Item Charge Type","Item Charge Type");
          case "Item Charge Type" of
            "Item Charge Type"::Tax:
              SalesLine.CalcChargeVATAmountLines(SalesHeader,TempSalesLine,TempVATAmountLineCharge1);
            "Item Charge Type"::Deposit:
              SalesLine.CalcChargeVATAmountLines(SalesHeader,TempSalesLine,TempVATAmountLineCharge2);
            "Item Charge Type"::Discount:
              SalesLine.CalcChargeVATAmountLines(SalesHeader,TempSalesLine,TempVATAmountLineCharge3);
            "Item Charge Type"::Promotion:
               SalesLine.CalcChargeVATAmountLines(SalesHeader,TempSalesLine,TempVATAmountLineCharge4);
          end;
          EVALUATE(j,FORMAT("Item Charge Type",0,2));
          CLEAR(SalesPost);
          SalesPost.SumChargeSalesLinesTemp(
            SalesHeader,TempSalesLine,0,TotalSalesLineCharge[j],TotalSalesLineChargeLCY[j],
            VATAmountCharge[j],VATAmountTextCharge[j]);

          if "Prices Including VAT" then begin
            TotalAmountCharge2[j] := TotalSalesLineCharge[j].Amount;
            TotalAmountCharge1[j] := TotalAmountCharge2[j] + VATAmountCharge[j];
            TotalSalesLineCharge[j]."Line Amount" := TotalAmountCharge1[j] + TotalSalesLineCharge[j]."Inv. Discount Amount";
          end else begin
            TotalAmountCharge1[j] := TotalSalesLineCharge[j].Amount;
            TotalAmountCharge2[j] := TotalSalesLineCharge[j]."Amount Including VAT";
          end;
        end;
      CLEAR(TempSalesLine);
      CLEAR(SalesLine);
      // >>DITW15.00.00.35 DDR

    #21..33
    //>>HEI.01 FDD-XXXXXX001
    TotalAmount3 := WHTManagement.StatisticsCalcWHTAmount(37, Rec."No.", Rec."Document Type");
    //<<HEI.01 FDD-XXXXXX001

    #34..51

    //HEI.02>>
    if EnableCAD then begin
      CADAmount := 0;
      SalesLine2.SETRANGE("Document Type","Document Type");
      SalesLine2.SETRANGE("Document No.","No.");
      if SalesLine2.FINDSET then
        repeat
          CADAmount += SalesLine2."CAD Amount";
        until SalesLine2.NEXT = 0;
    end;
    //HEI.02<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger (Variable: GeneralLedgerSetup)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    // BC Upgrade BHARDA11 >> 
    trigger OnOpenPage();
    begin
        //HEI.02>>
        GeneralLedgerSetup.GET;
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.02<<
    end;
    // BC Upgrade BHARDA11 <<
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.37 DIT-715 #1
    VATAmountTxtVisible := true;
    // >>DITW16.00.00.37 DIT-715 #1
    #1..9

    //HEI.02>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.02<<
    */
    //end;


    //Unsupported feature: CodeModification on "UpdateHeaderInfo(PROCEDURE 5)". Please convert manually.

    //procedure UpdateHeaderInfo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalSalesLine."Inv. Discount Amount" := TempVATAmountLine.GetTotalInvDiscAmount;
    TotalAmount1 :=
      TotalSalesLine."Line Amount" - TotalSalesLine."Inv. Discount Amount";
    VATAmount := TempVATAmountLine.GetTotalVATAmount;
    if "Prices Including VAT" then begin
      TotalAmount1 := TempVATAmountLine.GetTotalAmountInclVAT;
      TotalAmount2 := TotalAmount1 - VATAmount;
      TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
    end else
      TotalAmount2 := TotalAmount1 + VATAmount;

    if "Prices Including VAT" then
      TotalSalesLineLCY.Amount := TotalAmount2
    #14..35
      AdjProfitPct := 0
    else
      AdjProfitPct := ROUND(100 * AdjProfitLCY / TotalSalesLineLCY.Amount,0.01);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    CADAmount := TempVATAmountLine.GetTotalCADAmount; //HEI.02
    #5..9
      //HEI.02>>
      //TotalAmount2 := TotalAmount1 + VATAmount;
      TotalAmount2 := TotalAmount1 + VATAmount + CADAmount;
      //HEI.02<<
    #11..38
    */
    //end;

    //Bc Upgrade YADAVM09 Drink it function>>
    // local procedure SetVATSpecificationCharge(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost");
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     case ItemChargeType of
    //         ItemChargeType::Tax:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge1);
    //         ItemChargeType::Deposit:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge2);
    //         ItemChargeType::Discount:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge3);
    //         ItemChargeType::Promotion:
    //             CurrPage.SubForm.PAGE.SetTempVATAmountLine(TempVATAmountLineCharge4);
    //     end;

    //     SetVatChargeTextHeader(ItemChargeType);

    //     CurrPage.SubForm.PAGE.InitGlobals(
    //       Rec."Currency Code", AllowVATDifference, false,
    //       Rec."Prices Including VAT", AllowInvDisc, Rec."VAT Base Discount %");
    // end;


    // local procedure DrillDownChargeLines(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost"; FieldNumber: Integer);
    // var
    //     ItemChargeAmtBuf: Record "Item Charge Amount Buffer" temporary;
    //     VATAmountLineBuf: Record "VAT Amount Line" temporary;
    //     SalesLine: Record "Sales Line";
    //     SalesLineBuf: Record "Sales Line" temporary;
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     CLEAR(SalesHeader);
    //     SalesHeader := Rec;
    //     CLEAR(SalesPost);
    //     SalesHeader.SETRANGE("Item Charge Type Filter", ItemChargeType);
    //     SalesPost.GetSalesLines(SalesHeader, SalesLineBuf, 0);
    //     SalesHeader.SETRANGE("Item Charge Type Filter");

    //     CLEAR(SalesPost);
    //     CLEAR(SalesLine);
    //     // always on 0
    //     SalesLine.CalcVATAmountLines(0, SalesHeader, SalesLineBuf, VATAmountLineBuf);

    //     if SalesLineBuf.FINDFIRST then
    //         repeat
    //             ItemChargeAmtBuf.SalesTransferfields(SalesLineBuf);
    //             ItemChargeAmtBuf.InsertAsGroup(false);
    //         until SalesLineBuf.NEXT = 0;

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

    // local procedure LCaptionClassTranslate(CaptionText: Text[102]; ReverseCaption: Boolean): Text[1024];
    // var
    //     AppMgt: Codeunit ApplicationManagement;
    //     LgCode: Integer;
    //     CaptionTextTranslate: Text[100];
    // begin
    //     // <<DITW16.00.00.37 DIT-715 #1
    //     CaptionTextTranslate := GetCaptionClass(CaptionText, ReverseCaption);
    //     LgCode := GLOBALLANGUAGE;
    //     exit(AppMgt.CaptionClassTranslate(LgCode, CaptionTextTranslate))
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

    // local procedure TotalSalesLineInvDiscountAmoun();
    // begin
    //     // <<DITW15.00.00.35 DDR 22/06/2009
    //     SetVATSpecification();
    //     // >>DITW15.00.00.35 DDR
    //     CurrPage.UPDATE;
    // end;//Bc Upgrade YADAVM09 Dependency on Drink it function<<

    // local procedure TotalSalesLineCharge1LineAmoun();//Bc Upgrade YADAVM09 Dependency on Drink it field"Item Charge Type Filter">>
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure VATAmountCharge1OnActivate();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalAmountCharge21OnActivate();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Tax);
    // end;

    // local procedure TotalSalesLineCharge2LineAmoun();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure VATAmountCharge2OnActivate();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure TotalAmountCharge22OnActivate();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Deposit);
    // end;

    // local procedure TotalSalesLineCharge3LineAmoun();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure VATAmountCharge3OnActivate();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalAmountCharge23OnActivate();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Discount);
    // end;

    // local procedure TotalSalesLineCharge4LineAmoun();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure VATAmountCharge4OnActivate();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Promotion);
    // end;

    // local procedure TotalAmountCharge24OnActivate();
    // begin
    //     SetVATSpecificationCharge(SalesHeader."Item Charge Type Filter"::Promotion);
    // end;//Bc Upgrade YADAVM09 Dependency on Drink it field<<


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



}

