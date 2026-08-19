pageextension 51201 SalesOrderStatisticsExtCBN extends "Sales Order Statistics"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    //  DITW15.00.00.35 DDR 22/06/2009 Added Statistic Drink-it tab
    //                                  Using (available) flowfilters
    //                                  Added functions
    //                                    SetVATSpecificationCharge(),DrillDownChargeLines(),SetVatChargeTextHeader()
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 AT 30/01/2014 DIT-770 #263 :Tab Drink-IT - added "Total amount without Deposit"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-OTCGAP063 IBM.NAIKH01 06/07/2017 -Block Invoice Discount Amount and Percentage value on the Sales Order
    //     # Changed the Editable property of field "TotalSalesLine[1]."Inv. Discount Amount" from "DynamicEditable" to False
    //     # Changed the Editable property of field "TotalSalesLine[2]."Inv. Discount Amount" from "DynamicEditable" to False
    //     # Changed the Editable property of field "TotalSalesLine[3]."Inv. Discount Amount" from "DynamicEditable" to False

    //   HEI.02 FDD-XXXXXX001 IBM POSTOI01 11.01.2018
    //     # New variables : TotalAmount3 (decinmal) and WHTManagement (codeunit)
    //     # New field shown in the page designer: WHT Amount (variable TotalAmount3)
    //     # RefreshOnAfterGetRecord modified : add procedure to calculate TotalAmount3
    //   HEI.03 FDD-CHG2025588_HB826 BULIMC01 IBM 23/10/2019 #new field added in General tab: "Total excl. Deposit"
    //   HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //     # New Field 'CAD Amount' created
    //     # New Global Variable 'CADAmount' created
    //     # Code added on 'OnAfterGetRecord' trigger

    //BC Upgrade GUNREM01 Commented Drink-IT Code 
    //HEI.02 -BC Upgrade GUNREM01 subscribed event to update totalamount3 -codeunit Cod50283.HeinekenPageCu  OnAfterCalculateTotalAmounts
    // HEI.04 - BC Upgrade GUNREM01 For now putting this code commented because CAD functionality is running only in CONGO opco.
    // BC Upgrade BHARDA11 >>
    // 1. I created a separate function because there was some CAD amount–related code inside RefreshOnAfterGetRecord function, where certain variables (such as CADAmount) were being assigned values and used at the page level.
    // 2. If I had implemented this logic through an event subscriber, I wouldn’t have been able to use those values properly.Therefore, I created a dedicated function so that I can call and reuse this logic wherever the original function is being used.
    // 3. There are some CAD Amount and HEI Code in UpdateHeaderInfo function but there is no event found for access the VATAmountLine variable , also in that code CADAmount is a global variable and it is  using in page field. So if we tring to do this via codeunit or event it is not possible. */
    // BC Upgrade BHARDA11 <<
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("InvDiscountAmount_General")
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies the invoice discount amount for the sales document.', FRA = 'Spécifie le montant de la remise facture du document de vente.';
            Editable = false; //BC Upgrade GUNREM01 added
            //Unsupported feature: Change Editable on ""InvDiscountAmount_General"(Control 30)". Please convert manually.

        }
        modify(VATAmount)
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
            ToolTipML = ENU = 'Specifies the total VAT amount that has been calculated for all the lines in the sales document.', FRA = 'Spécifie le montant total de la TVA qui a été calculée pour toutes les lignes du document vente.';
        }
        modify("TotalSalesLineLCY[1].Amount")
        {
            CaptionML = ENU = 'Sales (LCY)', FRA = 'Ventes DS';
            ToolTipML = ENU = 'Specifies your total sales turnover in the fiscal year. It is calculated from amounts excluding VAT on all completed and open sales invoices and credit memos.', FRA = 'Spécifie votre rotation totale des ventes au cours de l''exercice comptable. Il est calculé à partir des montants HT sur toutes les factures vente et avoirs terminés et ouverts.';
        }
        modify("ProfitLCY[1]")
        {
            CaptionML = ENU = 'Original Profit (LCY)', FRA = 'Marge initiale DS';
            ToolTipML = ENU = 'Specifies the original profit that was associated with the sales when they were originally posted.', FRA = 'Spécifie la marge initiale qui a été associée aux ventes lors de leur validation initiale.';
        }
        modify("AdjProfitLCY[1]")
        {
            CaptionML = ENU = 'Adjusted Profit (LCY)', FRA = 'Marge ajustée DS';
            ToolTipML = ENU = 'Specifies the profit, taking into consideration changes in the purchase prices of the goods.', FRA = 'Spécifie la marge, en tenant compte des modifications apportées aux prix d''achat des biens.';
        }
        modify("ProfitPct[1]")
        {
            CaptionML = ENU = 'Original Profit %', FRA = '% marge initiale';
            ToolTipML = ENU = 'Specifies the original percentage of profit that was associated with the sales when they were originally posted.', FRA = 'Spécifie le pourcentage initial de marge qui a été associé aux ventes lors de leur validation initiale.';
        }
        modify("AdjProfitPct[1]")
        {
            CaptionML = ENU = 'Adjusted Profit %', FRA = '% marge ajustée';
            ToolTipML = ENU = 'Specifies the percentage of profit for all sales, taking into account changes that occurred in the purchase prices of the goods.', FRA = 'Spécifie le pourcentage de marge de toutes les ventes, en tenant compte des modifications apportées aux prix d''achat des biens.';
        }
        modify("TotalSalesLine[1].Quantity")
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
            ToolTipML = ENU = 'Specifies the total quantity of G/L account entries, items, and/or resources in the sales document. If the amount is rounded, because the Invoice Rounding check box is selected in the Sales & Receivables Setup window, this field will contain the quantity of items in the sales document plus one.', FRA = 'Spécifie la quantité totale des écritures comptables, article ou ressources du document vente. Si le montant est arrondi parce que la case à cocher Arrondi facture de la table Paramètres ventes est activée, ce champ indique la quantité d''articles du document vente, plus un.';
        }
        modify("TotalSalesLine[1].""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
            ToolTipML = ENU = 'Specifies the total number of parcels in the sales document.', FRA = 'Spécifie le nombre total de colis du document vente.';
        }
        modify("TotalSalesLine[1].""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            ToolTipML = ENU = 'Specifies the total net weight of the items in the sales document.', FRA = 'Spécifie le poids net total des articles du document vente.';
        }
        modify("TotalSalesLine[1].""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
            ToolTipML = ENU = 'Specifies the total gross weight of the items in the sales document.', FRA = 'Spécifie le poids brut total des articles du document vente.';
        }
        modify("TotalSalesLine[1].""Unit Volume""")
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
            ToolTipML = ENU = 'Specifies the total volume of the items in the sales document.', FRA = 'Spécifie le volume total des articles du document vente.';
        }
        modify("TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            CaptionML = ENU = 'Original Cost (LCY)', FRA = 'Coût initial DS';
            ToolTipML = ENU = 'Specifies the total cost, in LCY, of the G/L account entries, items, and/or resources in the sales document. The cost is calculated as unit cost x quantity of the items or resources.', FRA = 'Spécifie le coût total, en devise société, des écritures comptables, article ou ressources du document vente. Le coût est calculé comme suit : coût unitaire x quantité des articles ou des ressources.';
        }
        modify("TotalAdjCostLCY[1]")
        {
            CaptionML = ENU = 'Adjusted Cost (LCY)', FRA = 'Coût ajusté DS';
            ToolTipML = ENU = 'Specifies the total cost, in LCY, of the items in the sales document, adjusted for any changes in the original costs of these items. If this field contains zero, it means that there were no entries to calculate, possibly because of date compression or because the adjustment batch job has not yet been run.', FRA = 'Spécifie le coût total, en devise société, des articles figurant dans le document vente, ajusté en fonction des modifications apportées au coût initial de ces articles. Si la valeur du champ est zéro, cela signifie qu''il n''y a pas eu d''écritures à calculer, probablement en raison d''une compression ou parce que le traitement par lot de l''ajustement n''a pas encore été exécuté.';
        }
        modify("TotalAdjCostLCY[1] - TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            CaptionML = ENU = 'Cost Adjmt. Amount (LCY)', FRA = 'Montant ajust. coût DS';
            ToolTipML = ENU = 'Specifies the difference between the original cost and the total adjusted cost of the items in the sales document.', FRA = 'Spécifie la différence entre le coût initial et le coût total ajusté des articles figurant dans le document vente.';
        }
        modify("NoOfVATLines_General")
        {
            CaptionML = ENU = 'No. of VAT Lines', FRA = 'Nombre de lignes TVA';
            ToolTipML = ENU = 'Specifies the number of lines on the sales order that have VAT amounts.', FRA = 'Spécifie le nombre de lignes sur la commande vente qui a des montants de TVA.';

        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }
        modify("InvDiscountAmount_Invoicing")
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies the invoice discount amount for the sales document.', FRA = 'Spécifie le montant de la remise facture du document de vente.';
            Editable = false; //BC Upgrade GUNREM01 added
            //Unsupported feature: Change Editable on ""InvDiscountAmount_Invoicing"(Control 51)". Please convert manually.

        }
        modify("TotalSalesLineLCY[2].Amount")
        {
            CaptionML = ENU = 'Sales (LCY)', FRA = 'Ventes DS';
            ToolTipML = ENU = 'Specifies your total sales turnover in the fiscal year. It is calculated from amounts excluding VAT on all completed and open sales invoices and credit memos.', FRA = 'Spécifie votre rotation totale des ventes au cours de l''exercice comptable. Il est calculé à partir des montants HT sur toutes les factures vente et avoirs terminés et ouverts.';
        }
        modify("ProfitLCY[2]")
        {
            CaptionML = ENU = 'Original Profit (LCY)', FRA = 'Marge initiale DS';
            ToolTipML = ENU = 'Specifies the original profit that was associated with the sales when they were originally posted.', FRA = 'Spécifie la marge initiale qui a été associée aux ventes lors de leur validation initiale.';
        }
        modify("AdjProfitLCY[2]")
        {
            CaptionML = ENU = 'Adjusted Profit (LCY)', FRA = 'Marge ajustée DS';
            ToolTipML = ENU = 'Specifies the profit, taking into consideration changes in the purchase prices of the goods.', FRA = 'Spécifie la marge, en tenant compte des modifications apportées aux prix d''achat des biens.';
        }
        modify("ProfitPct[2]")
        {
            CaptionML = ENU = 'Original Profit %', FRA = '% marge initiale';
            ToolTipML = ENU = 'Specifies the original percentage of profit that was associated with the sales when they were originally posted.', FRA = 'Spécifie le pourcentage initial de marge qui a été associé aux ventes lors de leur validation initiale.';
        }
        modify("AdjProfitPct[2]")
        {
            CaptionML = ENU = 'Adjusted Profit %', FRA = '% marge ajustée';
            ToolTipML = ENU = 'Specifies the percentage of profit for all sales, taking into account changes that occurred in the purchase prices of the goods.', FRA = 'Spécifie le pourcentage de marge de toutes les ventes, en tenant compte des modifications apportées aux prix d''achat des biens.';
        }
        modify("TotalSalesLine[2].Quantity")
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
            ToolTipML = ENU = 'Specifies the total quantity of G/L account entries, items, and/or resources in the sales document. If the amount is rounded, because the Invoice Rounding check box is selected in the Sales & Receivables Setup window, this field will contain the quantity of items in the sales document plus one.', FRA = 'Spécifie la quantité totale des écritures comptables, article ou ressources du document vente. Si le montant est arrondi parce que la case à cocher Arrondi facture de la table Paramètres ventes est activée, ce champ indique la quantité d''articles du document vente, plus un.';
        }
        modify("TotalSalesLine[2].""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
            ToolTipML = ENU = 'Specifies the total number of parcels in the sales document.', FRA = 'Spécifie le nombre total de colis du document vente.';
        }
        modify("TotalSalesLine[2].""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            ToolTipML = ENU = 'Specifies the total net weight of the items in the sales document.', FRA = 'Spécifie le poids net total des articles du document vente.';
        }
        modify("TotalSalesLine[2].""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
            ToolTipML = ENU = 'Specifies the total gross weight of the items in the sales document.', FRA = 'Spécifie le poids brut total des articles du document vente.';
        }
        modify("TotalSalesLine[2].""Unit Volume""")
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
            ToolTipML = ENU = 'Specifies the total volume of the items in the sales document.', FRA = 'Spécifie le volume total des articles du document vente.';
        }
        modify("TotalSalesLineLCY[2].""Unit Cost (LCY)""")
        {
            CaptionML = ENU = 'Original Cost (LCY)', FRA = 'Coût initial DS';
            ToolTipML = ENU = 'Specifies the total cost, in LCY, of the G/L account entries, items, and/or resources in the sales document. The cost is calculated as unit cost x quantity of the items or resources.', FRA = 'Spécifie le coût total, en devise société, des écritures comptables, article ou ressources du document vente. Le coût est calculé comme suit : coût unitaire x quantité des articles ou des ressources.';
        }
        modify("TotalAdjCostLCY[2]")
        {
            CaptionML = ENU = 'Adjusted Cost (LCY)', FRA = 'Coût ajusté DS';
            ToolTipML = ENU = 'Specifies the total cost, in LCY, of the items in the sales document, adjusted for any changes in the original costs of these items. If this field contains zero, it means that there were no entries to calculate, possibly because of date compression or because the adjustment batch job has not yet been run.', FRA = 'Spécifie le coût total, en devise société, des articles figurant dans le document vente, ajusté en fonction des modifications apportées au coût initial de ces articles. Si la valeur du champ est zéro, cela signifie qu''il n''y a pas eu d''écritures à calculer, probablement en raison d''une compression ou parce que le traitement par lot de l''ajustement n''a pas encore été exécuté.';
        }
        modify("TotalAdjCostLCY[2] - TotalSalesLineLCY[2].""Unit Cost (LCY)""")
        {
            CaptionML = ENU = 'Cost Adjmt. Amount (LCY)', FRA = 'Montant ajust. coût DS';
            ToolTipML = ENU = 'Specifies the difference between the original cost and the total adjusted cost of the items in the sales document.', FRA = 'Spécifie la différence entre le coût initial et le coût total ajusté des articles figurant dans le document vente.';
        }
        modify("NoOfVATLines_Invoicing")
        {
            CaptionML = ENU = 'No. of VAT Lines', FRA = 'Nombre de lignes TVA';
            ToolTipML = ENU = 'Specifies the number of lines on the sales order that have VAT amounts.', FRA = 'Spécifie le nombre de lignes sur la commande vente qui a des montants de TVA.';
            // BC Upgrade BHARDA11 >>  ----Enable CAD Amount Functionality
            trigger OnDrillDown()
            begin
                RefreshOnAfterGetRecordCADAmount();
            end;
            // BC Upgrade BHARDA11 << ----Enable CAD Amount Functionality
        }
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }
        modify("TotalSalesLine[3].""Inv. Discount Amount""")
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
            ToolTipML = ENU = 'Specifies the invoice discount amount for the sales document.', FRA = 'Spécifie le montant de la remise facture du document de vente.';
            Editable = false;
        }
        modify("TotalSalesLineLCY[3].Amount")
        {
            CaptionML = ENU = 'Sales (LCY)', FRA = 'Ventes DS';
            ToolTipML = ENU = 'Specifies your total sales turnover in the fiscal year. It is calculated from amounts excluding VAT on all completed and open sales invoices and credit memos.', FRA = 'Spécifie votre rotation totale des ventes au cours de l''exercice comptable. Il est calculé à partir des montants HT sur toutes les factures vente et avoirs terminés et ouverts.';
        }
        modify("TotalSalesLineLCY[3].""Unit Cost (LCY)""")
        {
            CaptionML = ENU = 'Cost (LCY)', FRA = 'Coût DS';
            ToolTipML = ENU = 'Specifies the total cost of the sales order.', FRA = 'Spécifie le coût total de la commande vente.';
        }
        modify("ProfitLCY[3]")
        {
            CaptionML = ENU = 'Profit (LCY)', FRA = 'Marge DS';
            ToolTipML = ENU = 'Specifies the total profit of the sales order.', FRA = 'Spécifie la marge totale de la commande vente.';
        }
        modify("ProfitPct[3]")
        {
            CaptionML = ENU = 'Profit %', FRA = '% marge sur vente';
            ToolTipML = ENU = 'Specifies the total profit of the sales order expressed as a percentage of the total amount.', FRA = 'Spécifie la marge totale de la commande vente exprimée en pourcentage du montant total.';
        }
        modify("TotalSalesLine[3].Quantity")
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
            ToolTipML = ENU = 'Specifies the total quantity of G/L account entries, items, and/or resources in the sales document. If the amount is rounded, because the Invoice Rounding check box is selected in the Sales & Receivables Setup window, this field will contain the quantity of items in the sales document plus one.', FRA = 'Spécifie la quantité totale des écritures comptables, article ou ressources du document vente. Si le montant est arrondi parce que la case à cocher Arrondi facture de la table Paramètres ventes est activée, ce champ indique la quantité d''articles du document vente, plus un.';
        }
        modify("TotalSalesLine[3].""Units per Parcel""")
        {
            CaptionML = ENU = 'Parcels', FRA = 'Colis';
            ToolTipML = ENU = 'Specifies the total number of parcels in the sales document.', FRA = 'Spécifie le nombre total de colis du document vente.';
        }
        modify("TotalSalesLine[3].""Net Weight""")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            ToolTipML = ENU = 'Specifies the total net weight of the items in the sales document.', FRA = 'Spécifie le poids net total des articles du document vente.';
        }
        modify("TotalSalesLine[3].""Gross Weight""")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
            ToolTipML = ENU = 'Specifies the total gross weight of the items in the sales document.', FRA = 'Spécifie le poids brut total des articles du document vente.';
        }
        modify("TotalSalesLine[3].""Unit Volume""")
        {
            CaptionML = ENU = 'Volume', FRA = 'Volume';
            ToolTipML = ENU = 'Specifies the total volume of the items in the sales document.', FRA = 'Spécifie le volume total des articles du document vente.';
        }
        modify("TempVATAmountLine3.COUNT")
        {
            CaptionML = ENU = 'No. of VAT Lines', FRA = 'Nombre de lignes TVA';
            ToolTipML = ENU = 'Specifies the number of lines on the sales order that have VAT amounts.', FRA = 'Spécifie le nombre de lignes sur la commande vente qui a des montants de TVA.';
        }
        modify(Prepayment)
        {
            CaptionML = ENU = 'Prepayment', FRA = 'Acompte';
        }
        modify(PrepmtVATAmount)
        {
            CaptionML = ENU = 'Prepayment Amount Invoiced', FRA = 'Montant acompte facturé';
        }
        modify(PrepmtInvPct)
        {
            CaptionML = ENU = 'Invoiced % of Prepayment Amt.', FRA = '% facturé du montant acompte';
            ToolTipML = ENU = 'Indicates Invoiced Percentage of Prepayment Amt.', FRA = 'Indique le pourcentage facturé du montant acompte.';
        }
        modify(PrepmtDeductedPct)
        {
            CaptionML = ENU = 'Deducted % of Prepayment Amt. to Deduct', FRA = '% déduit du montant acompte à déduire';
            ToolTipML = ENU = 'Specifies the deducted percentage of the prepayment amount to deduct.', FRA = 'Spécifie le pourcentage déduit du montant acompte à déduire.';
        }
        modify("TempVATAmountLine4.COUNT")
        {
            CaptionML = ENU = 'No. of VAT Lines', FRA = 'Nombre de lignes TVA';
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
                Caption = 'CAD Amount';
                Editable = false;
                Visible = EnableCAD;
                ToolTip = 'Specifies the value of the CAD Amount field.';
                ApplicationArea = All;
            }
        }
        addafter("TotalAmount2[1]")
        {
            field("<TotalAmount3>"; TotalAmount3)
            {
                CaptionML = ENU = 'WHT Amount',
                            ESP = 'Importe WHT',
                            FRA = 'Montant WHT';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TotalAmount3 field.';
            }
        }
        addafter("NoOfVATLines_General")
        {
            field("Total excl. Deposit"; TotalAmount2[1] - TotalSalesLineCharge[1, 2]."Line Amount")
            {
                Caption = 'Total excl. Deposit';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total excl. Deposit field.';
            }
        }


        //BC Upgrade GUNREM01 Commented >> Drink-IT Group
        /* addafter(Customer)
         {
             group("Drink-It")
                 {
                     CaptionML = ENU = 'Drink-It',
                                 FRA = 'Drink-It';
                     fixed(Control1905194801)
                     {
                         group(" ")
                         {
                             Caption = '" "';
                             field("LCaptionClassTranslate(Text002,false)"; LCaptionClassTranslate(Text002, false))
                             {
                                 Editable = false;
                             }
                             field("TotalSalesLineCharge[1,1].""Line Amount"""; TotalSalesLineCharge[1, 1]."Line Amount")
                             {
                                 AutoFormatExpression = Rec."Currency Code";
                                 AutoFormatType = 1;
                                 CaptionML = ENU = 'Tax',
                                             FRA = 'Taxes';
                                 Editable = false;

                                 trigger OnDrillDown();
                                 begin
                                     DrillDownChargeLines(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Tax, FIELDNO(Amount));
                                 end;
                             }
                             field("TotalSalesLineCharge[1,2].""Line Amount"""; TotalSalesLineCharge[1, 2]."Line Amount")
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 CaptionML = ENU = 'Deposit',
                                             FRA = 'Consigne';
                                 Editable = false;

                                 trigger OnDrillDown();
                                 begin
                                     DrillDownChargeLines(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Deposit, FIELDNO(Amount));
                                 end;
                             }
                             field("TotalSalesLineCharge[1,3].""Line Amount"""; TotalSalesLineCharge[1, 3]."Line Amount")
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 CaptionML = ENU = 'Discount/ Charge',
                                             FRA = 'Remise / Frais';
                                 Editable = false;

                                 trigger OnDrillDown();
                                 begin
                                     DrillDownChargeLines(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Discount, FIELDNO(Amount));
                                 end;
                             }
                             field("TotalSalesLineCharge[1,4].""Line Amount"""; TotalSalesLineCharge[1, 4]."Line Amount")
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 CaptionML = ENU = 'Promotion',
                                             FRA = 'Promotion';
                                 Editable = false;

                                 trigger OnDrillDown();
                                 begin
                                     DrillDownChargeLines(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Promotion, FIELDNO(Amount));
                                 end;
                             }
                             field("TotalSalesLineCharge[1,6].""Line Amount"""; TotalSalesLineCharge[1, 6]."Line Amount")
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 CaptionML = ENU = 'Shipping Cost',
                                             FRA = 'Coût transport';
                                 Editable = false;

                                 trigger OnDrillDown();
                                 begin
                                     DrillDownChargeLines(ActiveTab::General, SalesHeader."Item Charge Type Filter"::"Shipping Cost", FIELDNO(Amount));
                                 end;
                             }
                             field("TotalSalesLine[1].""Line Amount""-TotalSalesLineCharge[1,2].""Line Amount"""; TotalSalesLine[1]."Line Amount" - TotalSalesLineCharge[1, 2]."Line Amount")
                             {
                                 CaptionML = ENU = 'Total Amt Without Deposit',
                                             FRA = 'Montant total sans consigne';
                             }
                         }
                         group(Control1906459001)
                         {
                             Caption = '" "';
                             field(VATAmountTxt; Text010)
                             {
                                 Editable = false;
                                 Visible = VATAmountTxtVisible;
                             }
                             field("VATAmountCharge[1,1]"; VATAmountCharge[1, 1])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                             field("VATAmountCharge[1,2]"; VATAmountCharge[1, 2])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                             field("VATAmountCharge[1,3]"; VATAmountCharge[1, 3])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                             field("VATAmountCharge[1,4]"; VATAmountCharge[1, 4])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                             field("VATAmountCharge[1,6]"; VATAmountCharge[1, 6])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                         }
                         group(Control1905691301)
                         {
                             Caption = '" "';
                             field("LCaptionClassTranslate(Text001,true)"; LCaptionClassTranslate(Text001, true))
                             {
                                 Editable = false;
                             }
                             field("TotalAmountCharge2[1,1]"; TotalAmountCharge2[1, 1])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                             field("TotalAmountCharge2[1,2]"; TotalAmountCharge2[1, 2])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                             field("TotalAmountCharge2[1,3]"; TotalAmountCharge2[1, 3])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                             field("TotalAmountCharge2[1,4]"; TotalAmountCharge2[1, 4])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                             field("TotalAmountCharge2[1,6]"; TotalAmountCharge2[1, 6])
                             {
                                 AutoFormatExpression = "Currency Code";
                                 AutoFormatType = 1;
                                 Editable = false;
                             }
                         }
                     }
                 }
             }
             */ //BC Upgrade GUNREM01 Commented << Drink-IT Group
    }

    var
        GeneralLedgerSetup: Record "General Ledger Setup";

    var
        SalesLine2: Record "Sales Line";


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
    //Text005 : ENU=You cannot change the invoice discount because a customer invoice discount with the code %1 exists.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot change the invoice discount because a customer invoice discount with the code %1 exists.;FRA=Vous ne pouvez pas modifier la remise facture car il existe une remise facture client avec le code %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1033)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=Prepmt. Amount;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=Prepmt. Amount;FRA=Montant acompte;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1041)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=Prepmt. Amt. Invoiced;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=Prepmt. Amt. Invoiced;FRA=Mnt acompte facturé;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1042)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Prepmt. Amt. Deducted;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=Prepmt. Amt. Deducted;FRA=Montant acompte déduit;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1043)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=Prepmt. Amt. to Deduct;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=Prepmt. Amt. to Deduct;FRA=Montant acompte à déduire;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "UpdateInvDiscountQst(Variable 1056)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UpdateInvDiscountQst : ENU=There are one or more invoiced lines.\Do you want to update the invoice discount?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdateInvDiscountQst : ENU=There are one or more invoiced lines.\Do you want to update the invoice discount?;FRA=Il existe une ou plusieurs lignes expédiées.\Voulez-vous mettre à jour la remise facture ?;
    //Variable type has not been exported.


    var
        //BC Upgrade GUNREM01 Added
        ActiveTab: Option General,Invoicing,Shipping,Prepayment;//BC Upgrade GUNREM01 Added 
        PrevTab: Option General,Invoicing,Shipping,Prepayment;
        //BC Upgrade GUNREM01 Added
        PrevRec: Record "Sales Header" temporary;
        SalesHeader: Record "Sales Header";
        TempVATAmountLineCharge1: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge2: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge3: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge4: Record "VAT Amount Line" temporary;
        TempVATAmountLineCharge6: Record "VAT Amount Line" temporary;
        TotalSalesLineCharge: array[3, 6] of Record "Sales Line";
        TotalSalesLineChargeLCY: array[3, 6] of Record "Sales Line";
        VATAmountCharge: array[3, 6] of Decimal;
        VATAmountTextCharge: array[3, 6] of Text[30];
        VATAmountTextChargeHeader: Text[30];
        TotalAmountCharge1: array[3, 6] of Decimal;
        TotalAmountCharge2: array[3, 6] of Decimal;
        j: Integer;
        ActiveSubTab: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        Text010: TextConst ENU = 'VAT Amount', FRA = 'Montant TVA';

        VATAmountTxtVisible: Boolean;
        TotalAmount3: Decimal;
        WHTManagement: Codeunit WHTManagement;
        CADAmount: Decimal;
        EnableCAD: Boolean;
    // BC Upgrade BHARDA11 >>
    trigger OnAfterGetRecord()
    begin
        RefreshOnAfterGetRecordCADAmount();
    end;

    trigger OnOpenPage()
    begin
        //HEI.04>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.04<<
    end;
    // BC Upgrade BHARAD11 <<

    // BC Upgrade BHARDA11 >> ----I created a separate function because there was some CAD amount–related code inside RefreshOnAfterGetRecord function, where certain variables (such as CADAmount) were being assigned values and used at the page level.
    /* If I had implemented this logic through an event subscriber, I wouldn’t have been able to use those values properly.

Therefore, I created a dedicated function so that I can call and reuse this logic wherever the original function is being used. */
    local procedure RefreshOnAfterGetRecordCADAmount()
    begin
        //HEI.04>>
        IF EnableCAD THEN BEGIN
            SalesLine2.RESET;
            SalesLine2.SETRANGE("Document Type", Rec."Document Type");
            SalesLine2.SETRANGE("Document No.", Rec."No.");
            IF SalesLine2.FINDSET THEN
                REPEAT
                    CADAmount += SalesLine2."CAD Amount FND";
                UNTIL SalesLine2.NEXT = 0;
        END;
        //HEI.04<<
    end;
    // BC Upgrade BHARDA11 >>
    /* There are some CAD Amount and HEI Code in UpdateHeaderInfo function but there is no event found for access the VATAmountLine variable , also in that code CADAmount is a global variable and it is  using in page field. So if we tring to do this via codeunit or event it is not possible. */
    // BC Upgrade BHARDA11 <<
    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.
    //trigger (Variable: GeneralLedgerSetup)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesSetup.GET;
    AllowInvDisc := not (SalesSetup."Calc. Inv. Discount" and CustInvDiscRecExists("Invoice Disc. Code"));
    AllowVATDifference :=
      SalesSetup."Allow VAT Difference" and
      not ("Document Type" in ["Document Type"::Quote,"Document Type"::"Blanket Order"]);
    VATLinesFormIsEditable := AllowVATDifference or AllowInvDisc;
    CurrPage.EDITABLE := VATLinesFormIsEditable;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.37 DIT-715 #1
    VATAmountTxtVisible := true;
    // >>DITW16.00.00.37 DIT-715 #1
    #1..7

    //HEI.04>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.04<<
    */
    //end;

    // procedure SalesLine2();
    // begin
    // end;


    //Unsupported feature: CodeModification on "RefreshOnAfterGetRecord(PROCEDURE 10)". Please convert manually.

    //procedure RefreshOnAfterGetRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.CAPTION(STRSUBSTNO(Text000,"Document Type"));

    if PrevNo = "No." then
      exit;
    PrevNo := "No.";
    FILTERGROUP(2);
    SETRANGE("No.",PrevNo);
    FILTERGROUP(0);

    CLEAR(SalesLine);
    CLEAR(TotalSalesLine);
    CLEAR(TotalSalesLineLCY);

    for i := 1 to 3 do begin
      TempSalesLine.DELETEALL;
      CLEAR(TempSalesLine);
      CLEAR(SalesPost);
      SalesPost.GetSalesLines(Rec,TempSalesLine,i - 1);
      CLEAR(SalesPost);
    #20..29
        Rec,TempSalesLine,i - 1,TotalSalesLine[i],TotalSalesLineLCY[i],
        VATAmount[i],VATAmountText[i],ProfitLCY[i],ProfitPct[i],TotalAdjCostLCY[i]);

      if i = 3 then
        TotalAdjCostLCY[i] := TotalSalesLineLCY[i]."Unit Cost (LCY)";

    #36..45
        TotalAmount2[i] := TotalSalesLine[i]."Amount Including VAT";
      end;
    end;
    TempSalesLine.DELETEALL;
    CLEAR(TempSalesLine);
    SalesPostPrepayments.GetSalesLines(Rec,0,TempSalesLine);
    #52..84
    PrevTab := -1;

    UpdateHeaderInfo(2,TempVATAmountLine2);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.CAPTION(STRSUBSTNO(Text000,"Document Type"));

    // <<DITW15.00.00.35 DDR 22/06/2009
    // IF PrevNo = "No." THEN
    if (PrevRec.GETFILTERS() = GETFILTERS()) and
      (PrevNo = "No.")
    then
    // >>DITW15.00.00.35 DDR
      exit;
    PrevNo := "No.";
    // <<DITW15.00.00.35 DDR 22/06/2009
    PrevRec.COPY(Rec);
    SalesHeader := Rec;
    // >>DITW15.00.00.35 DDR
    #6..12
    // <<DITW15.00.00.35 DDR 22/06/2009
    CLEAR(TotalSalesLineCharge);
    CLEAR(TotalSalesLineChargeLCY);
    // >>DITW15.00.00.35 DDR

    for i := 1 to 3 do begin
      // <<DITW15.00.00.35 DDR 22/06/2009
      CLEAR(TempSalesLine);
      // >>DITW15.00.00.35 DDR
      TempSalesLine.DELETEALL;
      // <<DITW15.00.00.35 DDR 22/06/2009
      //CLEAR(TempSalesLine);
      // >>DITW15.00.00.35 DDR
    #17..32
      // <<DITW15.00.00.35 DDR 22/06/2009
      with SalesLine do
        for "Item Charge Type" := "Item Charge Type"::Tax to "Item Charge Type"::ShippingCost do begin
          SalesHeader.SETRANGE("Item Charge Type Filter","Item Charge Type");
          TempSalesLine.RESET;
          TempSalesLine.SETRANGE("Item Charge Type","Item Charge Type");
          if i = 1 then begin
            case "Item Charge Type" of
              "Item Charge Type"::Tax:
                SalesLine.CalcChargeVATAmountLines(SalesHeader,TempSalesLine,TempVATAmountLineCharge1);
              "Item Charge Type"::Deposit:
                SalesLine.CalcChargeVATAmountLines(SalesHeader,TempSalesLine,TempVATAmountLineCharge2);
              "Item Charge Type"::Discount:
                SalesLine.CalcChargeVATAmountLines(SalesHeader,TempSalesLine,TempVATAmountLineCharge3);
              "Item Charge Type"::Promotion:
                 SalesLine.CalcChargeVATAmountLines(SalesHeader,TempSalesLine,TempVATAmountLineCharge4);
              "Item Charge Type"::ShippingCost:
                SalesLine.CalcChargeVATAmountLines(SalesHeader,TempSalesLine,TempVATAmountLineCharge6);
            end;
          end;
          EVALUATE(j,FORMAT("Item Charge Type",0,2));
          CLEAR(SalesPost);
          SalesPost.SumChargeSalesLinesTemp(
            SalesHeader,TempSalesLine,i - 1,TotalSalesLineCharge[i,j],TotalSalesLineChargeLCY[i,j],
            VATAmountCharge[i,j],VATAmountTextCharge[i,j]);

          if "Prices Including VAT" then begin
            TotalAmountCharge2[i,j] := TotalSalesLineCharge[i,j].Amount;
            TotalAmountCharge1[i,j] := TotalAmountCharge2[i,j] + VATAmountCharge[i,j];
            TotalSalesLineCharge[i,j]."Line Amount" := TotalAmountCharge1[i,j] + TotalSalesLineCharge[i,j]."Inv. Discount Amount";
          end else begin
            TotalAmountCharge1[i,j] := TotalSalesLineCharge[i,j].Amount;
            TotalAmountCharge2[i,j] := TotalSalesLineCharge[i,j]."Amount Including VAT";
          end;
        end;
      CLEAR(TempSalesLine);
      CLEAR(SalesLine);
      // >>DITW15.00.00.35 DDR

    #33..48

    //>>HEI.02 FDD-XXXXXX001
    TotalAmount3 := WHTManagement.StatisticsCalcWHTAmount(37, Rec."No.", Rec."Document Type");
    //>>HEI.02 FDD-XXXXXX001

    //HEI.04>>
    if EnableCAD then begin
      SalesLine2.RESET;
      SalesLine2.SETRANGE("Document Type","Document Type");
      SalesLine2.SETRANGE("Document No.","No.");
      if SalesLine2.FINDSET then
        repeat
          CADAmount += SalesLine2."CAD Amount";
        until SalesLine2.NEXT = 0;
    end;
    //HEI.04<<

    #49..87
    */
    //end;


    //Unsupported feature: CodeModification on "UpdateHeaderInfo(PROCEDURE 5)". Please convert manually.

    //procedure UpdateHeaderInfo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TotalSalesLine[IndexNo]."Inv. Discount Amount" := VATAmountLine.GetTotalInvDiscAmount;
    TotalAmount1[IndexNo] :=
      TotalSalesLine[IndexNo]."Line Amount" - TotalSalesLine[IndexNo]."Inv. Discount Amount";
    VATAmount[IndexNo] := VATAmountLine.GetTotalVATAmount;
    if "Prices Including VAT" then begin
      TotalAmount1[IndexNo] := VATAmountLine.GetTotalAmountInclVAT;
      TotalAmount2[IndexNo] := TotalAmount1[IndexNo] - VATAmount[IndexNo];
      TotalSalesLine[IndexNo]."Line Amount" :=
        TotalAmount1[IndexNo] + TotalSalesLine[IndexNo]."Inv. Discount Amount";
    end else
      TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo];

    if "Prices Including VAT" then
      TotalSalesLineLCY[IndexNo].Amount := TotalAmount2[IndexNo]
    #15..34
      AdjProfitPct[IndexNo] := 0
    else
      AdjProfitPct[IndexNo] := ROUND(100 * AdjProfitLCY[IndexNo] / TotalSalesLineLCY[IndexNo].Amount,0.01);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    //HEI.04>>
    if EnableCAD and (IndexNo = 1) then
      CADAmount := VATAmountLine.GetTotalCADAmount;
    //HEI.04<<
    if "Prices Including VAT" then begin
      TotalAmount1[IndexNo] := VATAmountLine.GetTotalAmountInclVAT;
      //HEI.04>>
      if EnableCAD and (IndexNo = 1) then
        TotalAmount2[IndexNo] := TotalAmount1[IndexNo] - VATAmount[IndexNo] - CADAmount
      else
      //HEI.04<<
        TotalAmount2[IndexNo] := TotalAmount1[IndexNo] - VATAmount[IndexNo];
    #8..10
      //HEI.04>>
      if EnableCAD and (IndexNo = 1) then
        TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo] + CADAmount
      else
      //HEI.04<<
        TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo];
    #12..37
    */
    //end;
    //BC Upgrade GUNREM01 Commented >> Drink-IT code
    /*  local procedure SetVATSpecificationCharge(QtyType: Option General,Invoicing,Shipping,Prepayment; ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost");
      begin
          // <<DITW15.00.00.35 DDR 22/06/2009
          //IF NOT SubformIsReady THEN
          //  EXIT;

          CurrPage.UPDATE;
          PrevTab := 1000 + ActiveTab;
          ActiveTab := 1000 + QtyType;
          ActiveSubTab := ItemChargeType;

          case QtyType of
              QtyType::General:
                  begin
                      //CurrPAGE.Subform.PAGE.EDITABLE := FALSE;
                      case ItemChargeType of
                          ItemChargeType::Tax:
                              VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge1);
                          ItemChargeType::Deposit:
                              VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge2);
                          ItemChargeType::Discount:
                              VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge3);
                          ItemChargeType::Promotion:
                              VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge4);
                          ItemChargeType::"Shipping Cost":
                              VATLinesForm.SetTempVATAmountLine(TempVATAmountLineCharge6);
                      end;

                      VATLinesForm.InitGlobals(
                        "Currency Code", AllowVATDifference, false,
                        "Prices Including VAT", AllowInvDisc, "VAT Base Discount %");
                  end;
              QtyType::Invoicing:
                  ;
              QtyType::Shipping:
                  ;
              QtyType::Prepayment:
                  ;
          end;

          SetVatChargeTextHeader(ItemChargeType);
      end;
  */
    //BC Upgrade GUNREM01 Commented << Drink-IT code
    //BC Upgrade GUNREM01 Commented >> Drink-IT code

    /* local procedure DrillDownChargeLines(QtyType: Option General,Invoicing,Shipping,Prepayment; ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost"; FieldNumber: Integer);
     var
         ItemChargeAmtBuf: Record "Item Charge Amount Buffer" temporary;
         VATAmountLineBuf: Record "VAT Amount Line" temporary;
         SalesLine: Record "Sales Line";
         SalesLineBuf: Record "Sales Line" temporary;
     begin
         // <<DITW15.00.00.35 DDR 22/06/2009
         CLEAR(SalesHeader);
         SalesHeader := Rec;
         CLEAR(SalesPost);
         SalesHeader.SETRANGE("Item Charge Type Filter", ItemChargeType);
         SalesPost.GetSalesLines(SalesHeader, SalesLineBuf, QtyType);
         SalesHeader.SETRANGE("Item Charge Type Filter");

         CLEAR(SalesPost);
         CLEAR(SalesLine);
         // always on 0
         SalesLine.CalcVATAmountLines(0, SalesHeader, SalesLineBuf, VATAmountLineBuf);

         if SalesLineBuf.FINDFIRST then
             repeat
                 ItemChargeAmtBuf.SalesTransferfields(SalesLineBuf);
                 ItemChargeAmtBuf.InsertAsGroup(false);
             until SalesLineBuf.NEXT = 0;

         PAGE.RUN(0, ItemChargeAmtBuf);
     end;
 */     //BC Upgrade GUNREM01 Commented << Drink-IT code

    //BC Upgrade GUNREM01 Commented >> Drink-IT code
    /* procedure SetVatChargeTextHeader(ItemChargeType: Option " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost");
     begin
         // <<DITW15.00.00.35 DDR 22/06/2009
         EVALUATE(j, FORMAT(ItemChargeType, 0, 2));
         VATAmountTextChargeHeader := VATAmountTextCharge[1, j];
     end;
     */  //BC Upgrade GUNREM01 Commented << Drink-IT code

    //BC Upgrade GUNREM01 Commented >> Drink-IT code
    /*  procedure LCaptionClassTranslate(CaptionText: Text[102]; ReverseCaption: Boolean): Text[1024];
      var
          AppMgt: Codeunit ApplicationManagement;
          LgCode: Integer;
          CaptionTextTranslate: Text[100];
      begin
          CaptionTextTranslate := GetCaptionClass(CaptionText, ReverseCaption);
          LgCode := GLOBALLANGUAGE;
          exit(AppMgt.CaptionClassTranslate(LgCode, CaptionTextTranslate))
      end;
      */
    //BC Upgrade GUNREM01 Commented << Drink-IT code
    //BC Upgrade GUNREM01 >> Commented Drink-IT Code
    /* local procedure TotalSalesLineCharge1441LineAm();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Tax);
     end;

     local procedure VATAmountCharge1441OnActivate();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Tax);
     end;

     local procedure TotalAmountCharge21441OnActiva();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Tax);
     end;

     local procedure TotalSalesLineCharge1442LineAm();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Deposit);
     end;

     local procedure VATAmountCharge1442OnActivate();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Deposit);
     end;

     local procedure TotalAmountCharge21442OnActiva();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Deposit);
     end;

     local procedure TotalSalesLineCharge1443LineAm();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Discount);
     end;

     local procedure VATAmountCharge1443OnActivate();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Discount);
     end;

     local procedure TotalAmountCharge21443OnActiva();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Discount);
     end;

     local procedure TotalSalesLineCharge1444LineAm();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Promotion);
     end;

     local procedure VATAmountCharge1444OnActivate();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Promotion);
     end;

     local procedure TotalAmountCharge21444OnActiva();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Promotion);
     end;

     local procedure TotalAmountCharge21446OnActiva();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Promotion);
     end;

     local procedure VATAmountCharge1446OnActivate();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Promotion);
     end;

     local procedure TotalSalesLineCharge1446LineAm();
     begin
         SetVATSpecificationCharge(ActiveTab::General, SalesHeader."Item Charge Type Filter"::Promotion);
     end;
     */
    //BC Upgrade GUNREM01 << Commented Drink-IT Code

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

