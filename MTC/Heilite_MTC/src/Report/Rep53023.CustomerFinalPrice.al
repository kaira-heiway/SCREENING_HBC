report 53023 "Customer Final Price"
{
    // version HEI.02

    // HEI.01 FDD OTCGAP044 IBM HORTOC01 21.07.2017
    //   # new report
    // 
    // HEI.02 FDD OTCGAP044 IBM POENAB01 04.08.2017
    //   # modified "PrintOnlyIfDetail" property for "Sales Header" dataitem

    // BC Upgrade RAHUL>>
    // 1. Added ApplicationArea = All property at report level for BC visibility.
    //    Old: ApplicationArea property not defined at report level.
    //    New: ApplicationArea = All added at report level.
    // 2. Added UsageCategory = ReportsAndAnalysis property at report level for BC search.
    //    Old: UsageCategory not defined at report level.
    //    New: UsageCategory = ReportsAndAnalysis added at report level.
    // 3. Blocked deprecated Sales Price Calc. Mgt. campaign price function.
    //    Old: CampaignUnitPriceExclVAT := SalesPriceCalcMgt.FindCampaignSalesPrice("Sales Header", "Sales Line");
    //    New: Function call commented out because FindCampaignSalesPrice is removed/not available in upgraded BC.
    // 4. Blocked Drink-IT / legacy Item Charge Type dataset column.
    //    Old: column(ItemChargeType_SalesLine; FORMAT("Sales Line"."Item Charge Type"))
    //    New: Column commented out because field "Item Charge Type" is not available in standard BC.
    // 5. Blocked legacy discount calculation logic based on SalesLine."Item Charge Type".
    //    Old: Used attached Sales Lines with Type = Charge(Item) / G/L Account and "Item Charge Type" = Discount to derive:
    //         - ItemChargeDiscPrice, ItemChargeDiscAmount
    //         - GlAccDiscPrice, GlAccDiscAmount
    //    New: Entire block commented out due to missing DIT field "Item Charge Type" in upgraded BC.
    // 6. Blocked ShowDetailsLine condition based on "Item Charge Type".
    //    Old: if "Sales Line"."Item Charge Type" <> " " then ShowDetailsLine := true else false;
    //    New: Logic commented out and defaulted ShowDetailsLine := false to keep report compiling.
    // 7. No other functional logic changed in pricing calculations.
    //    Old: UnitFinalPriceExclVAT / InclVAT and FinalPrice calculations based on Unit Price, Discount Amount, VAT%.
    //    New: Same calculations retained with blocked legacy dependencies.
    // 8. Report upgrade reference.
    //    Old Report ID: 50009
    //    New: Upgraded for BC with ApplicationArea/UsageCategory compliance and legacy function/field blocks.
    // BC Upgrade RAHUL<<

    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory

    RDLCLayout = '.\src\ReportsLayout\Customer Final Price.rdl';
    DefaultLayout = RDLC;
    Caption = 'Customer Final Price';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Name_CompanyInfo; CompanyInformation.Name)
            {
            }
            column(CustomerNameLBL; CustomerNameLBL)
            {
            }
            column(CustomerNoLBL; CustomerNoLBL)
            {
            }
            column(OrderNoLBL; OrderNoLBL)
            {
            }
            column(ItemNoLBL; ItemNoLBL)
            {
            }
            column(ItemDescriptionLBL; ItemDescriptionLBL)
            {
            }
            column(QuantityLBL; QuantityLBL)
            {
            }
            column(UOMLBL; UOMLBL)
            {
            }
            column(SKUPriceLBL; SKUPriceLBL)
            {
            }
            column(CampaignPriceLBL; CampaignPriceLBL)
            {
            }
            column(UnitDiscAmountLBL; UnitDiscAmountLBL)
            {
            }
            column(UnitFinalPriceExclVatLBL; UnitFinalPriceExclVatLBL)
            {
            }
            column(UnitPriceInclVatLBL; UnitPriceInclVatLBL)
            {
            }
            column(DiscAmountLBL; DiscAmountLBL)
            {
            }
            column(FinalPriceExclVatLBL; FinalPriceExclVatLBL)
            {
            }
            column(FinalPriceInclVatLBL; FinalPriceInclVatLBL)
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(SellToCustNo_SaleaHeader; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(SellToCustName_SalesHeader; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(DateTime; CURRENTDATETIME)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE(Type = FILTER(Item));
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                }
                column(UOM_SalesLine; "Sales Line"."Unit of Measure Code")
                {
                }
                column(SkuUnitPriceExclVAT; SkuUnitPriceExclVAT)
                {
                }
                column(CampaignUnitPriceExclVAT; CampaignUnitPriceExclVAT)
                {
                }
                column(UnitDiscAmountExclVAT; UnitDiscAmountExclVAT)
                {
                }
                // column(ItemChargeType_SalesLine; FORMAT("Sales Line"."Item Charge Type"))//BC Upgrade RAHUL Blocking DIT Field Colomn("Sales Line"."Item Charge Type")
                // {
                // }
                column(ShowDetailsLine; ShowDetailsLine)
                {
                }
                column(UnitFinalPriceExclVAT; UnitFinalPriceExclVAT)
                {
                }
                column(UnitFinalPriceInclVAT; UnitFinalPriceInclVAT)
                {
                }
                column(DiscountAmountExclVAT; DiscountAmountExclVAT)
                {
                }
                column(FinalPriceExclVAT; FinalPriceExclVAT)
                {
                }
                column(FinalPriceinclVAT; FinalPriceinclVAT)
                {
                }
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(SalesPriceCalcMgt);
                    CLEAR(CampaignUnitPriceExclVAT);
                    // CampaignUnitPriceExclVAT := SalesPriceCalcMgt.FindCampaignSalesPrice("Sales Header", "Sales Line"); //BC Upgrade RAHUL Blocking due to Function Removal
                    if (CampaignUnitPriceExclVAT <> 0) and (CampaignUnitPriceExclVAT = "Sales Line"."Unit Price") then begin
                        SkuUnitPriceExclVAT := 0
                    end else begin
                        SkuUnitPriceExclVAT := "Sales Line"."Unit Price";
                        CampaignUnitPriceExclVAT := 0;
                    end;
                    CLEAR(LineDiscPrice);
                    if "Sales Line"."Line Discount Amount" <> 0 then
                        LineDiscPrice := ROUND(("Sales Line"."Line Discount Amount" / "Sales Line".Quantity), GeneralLedgerSetup."Unit-Amount Rounding Precision", '>');
                    CLEAR(ItemChargeDiscPrice);
                    CLEAR(ItemChargeDiscAmount);
                    CLEAR(GlAccDiscPrice);
                    CLEAR(GlAccDiscAmount);
                    // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
                    // SalesLine.RESET();
                    // SalesLine.SETRANGE("Document Type", "Sales Line"."Document Type");
                    // SalesLine.SETRANGE("Document No.", "Sales Line"."Document No.");
                    // SalesLine.SETRANGE("Attached to Line No.", "Sales Line"."Line No.");
                    // if SalesLine.FINDSET() then
                    //     repeat
                    // if (SalesLine.Type = SalesLine.Type::"Charge (Item)") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
                    //     ItemChargeDiscPrice := SalesLine."Unit Price";
                    //     ItemChargeDiscAmount := SalesLine."Line Amount" * -1;
                    // end;
                    // if (SalesLine.Type = SalesLine.Type::"G/L Account") and (SalesLine."Item Charge Type" = SalesLine."Item Charge Type"::Discount) then begin
                    //     GlAccDiscPrice := SalesLine."Unit Price";
                    //     GlAccDiscAmount := SalesLine."Line Amount" * -1;
                    // end;
                    // until SalesLine.NEXT() = 0;
                    // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<
                    UnitDiscAmountExclVAT := LineDiscPrice + ItemChargeDiscPrice + GlAccDiscPrice;

                    // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")>>
                    // if "Sales Line"."Item Charge Type" <> "Sales Line"."Item Charge Type"::" " then
                    //     ShowDetailsLine := true
                    // else
                    // BC Upgrade RAHUL Blocking DIT Field(SalesLine."Item Charge Type")<<
                    ShowDetailsLine := false;
                    CLEAR(UnitFinalPriceExclVAT);
                    CLEAR(UnitFinalPriceInclVAT);
                    CLEAR(DiscountAmountExclVAT);
                    CLEAR(FinalPriceExclVAT);
                    CLEAR(FinalPriceinclVAT);
                    UnitFinalPriceExclVAT := (CampaignUnitPriceExclVAT + SkuUnitPriceExclVAT) - UnitDiscAmountExclVAT;
                    UnitFinalPriceInclVAT := ROUND(UnitFinalPriceExclVAT + (UnitFinalPriceExclVAT * ("Sales Line"."VAT %" / 100)), GeneralLedgerSetup."Unit-Amount Rounding Precision", '>');

                    DiscountAmountExclVAT := "Sales Line"."Line Discount Amount" + ItemChargeDiscAmount + GlAccDiscAmount;

                    FinalPriceExclVAT := UnitFinalPriceExclVAT * "Sales Line".Quantity;
                    FinalPriceinclVAT := ROUND(FinalPriceExclVAT + (FinalPriceExclVAT * ("Sales Line"."VAT %" / 100)), GeneralLedgerSetup."Unit-Amount Rounding Precision", '>');
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //"Sales Header".TESTFIELD(Status,"Sales Header".Status::Released);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CompanyInformation.GET();
        GeneralLedgerSetup.GET();
    end;

    var
        CompanyInformation: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        ShowDetailsLine: Boolean;
        CampaignUnitPriceExclVAT: Decimal;
        DiscountAmountExclVAT: Decimal;
        FinalPriceExclVAT: Decimal;
        FinalPriceinclVAT: Decimal;
        GlAccDiscAmount: Decimal;
        GlAccDiscPrice: Decimal;
        ItemChargeDiscAmount: Decimal;
        ItemChargeDiscPrice: Decimal;
        LineDiscPrice: Decimal;
        SkuUnitPriceExclVAT: Decimal;
        UnitDiscAmountExclVAT: Decimal;
        UnitFinalPriceExclVAT: Decimal;
        UnitFinalPriceInclVAT: Decimal;
        CampaignPriceLBL: Label 'Campaign Unit Price Excl .VAT';
        CustomerNameLBL: Label 'Customer Name';
        CustomerNoLBL: Label 'Customer No.';
        DiscAmountLBL: Label 'Discount Amount Excl. VAT';
        FinalPriceExclVatLBL: Label 'Final Price Excl. VAT';
        FinalPriceInclVatLBL: Label 'Final Price Incl. VAT';
        ItemDescriptionLBL: Label 'Item Description';
        ItemNoLBL: Label 'Item No.';
        OrderNoLBL: Label 'Order No.';
        QuantityLBL: Label 'Quantity';
        SKUPriceLBL: Label 'SKU Unit Price Excl. VAT';
        UnitDiscAmountLBL: Label 'Unit Discount Amount Excl. VAT';
        UnitFinalPriceExclVatLBL: Label 'Unit Final Price Excl. VAT';
        UnitPriceInclVatLBL: Label 'Unit Final Price Incl. VAT';
        UOMLBL: Label 'UOM';
}

