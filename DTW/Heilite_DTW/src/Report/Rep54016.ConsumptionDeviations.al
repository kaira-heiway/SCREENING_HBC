report 54016 "Consumption Deviations"
{
    // version NAVW110.0,HEI.01

    // HEI.01 FDD-HT620 IBM BULIMC01 13.07.2019 #new report created for deviation from target consumption range

    //------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 01.02.2025 #Updated RDLCLayout Property. 
    //BC Upgrade KAPOOV01 01.02.2025 #Old Report ID is 50319.

    DefaultLayout = RDLC;
    //RDLCLayout = './Consumption Deviations.rdlc'; //BC Upgrade KAPOOV01

    Caption = 'Consumption Deviations';
    PreviewMode = PrintLayout;
    ApplicationArea = All;  //BC Upgrade KAPOOV01
    UsageCategory = ReportsAndAnalysis;  //BC Upgrade KAPOOV01
    RDLCLayout = '.\src\ReportsLayout\Consumption Deviations.rdl'; //BC Upgrade KAPOOV01-> Add layout path and change layout extension rdlc to rdl

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.") WHERE(Status = FILTER(Released | Finished));
            PrintOnlyIfDetail = true;
            RequestFilterFields = Status, "Location Code", "Zone Code FND";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(Status_ProdOrder; Status)
            {
                IncludeCaption = false;
            }
            column(No_ProdOrder; "No.")
            {
                IncludeCaption = true;
            }
            column(Desc_ProdOrder; Description)
            {
                IncludeCaption = true;
            }
            column(DueDate_ProdOrder; FORMAT("Due Date"))
            {
            }
            column(ShortageListCaption; ShortageListCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(NeededQtyCaption; NeededQtyCaptionLbl)
            {
            }
            column(CompItemScheduledNeedQtyCaption; CompItemScheduledNeedQtyCaptionLbl)
            {
            }
            column(CompItemInventoryCaption; CompItemInventoryCaptionLbl)
            {
            }
            column(RemainingQtyBaseCaption; RemainingQtyBaseCaptionLbl)
            {
            }
            column(RemQtyBaseCaption; RemQtyBaseCaptionLbl)
            {
            }
            column(ReceiptQtyCaption; ReceiptQtyCaptionLbl)
            {
            }
            column(QtyonPurchOrderCaption; QtyonPurchOrderCaptionLbl)
            {
            }
            column(QtyonSalesOrderCaption; QtyonSalesOrderCaptionLbl)
            {
            }
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.") WHERE("Finished Quantity" = FILTER(<> 0));
                PrintOnlyIfDetail = true;
                column(ProdOrderNo_ProdOrderLine; "Prod. Order Line"."Prod. Order No.")
                {
                }
                column(ItemNo_ProdOrderLine; "Prod. Order Line"."Item No.")
                {
                }
                column(Description_ProdOrderLine; "Prod. Order Line".Description)
                {
                }
                column(LineNo_ProdOrderLine; "Line No.")
                {
                }
                column(UnitofMeasureCode_ProdOrderLine; "Prod. Order Line"."Unit of Measure Code")
                {
                }
                column(PostingDateProd_ValueEntry; FORMAT(ValueEntry."Posting Date"))
                {
                }
                column(UserIDProd_ValueEntry; ValueEntry."User ID")
                {
                }
                column(RemainingQuantity_ProdOrderLine; "Prod. Order Line"."Remaining Quantity")
                {
                }
                column(Quantity_ProdOrderLine; "Prod. Order Line".Quantity)
                {
                }
                dataitem("Prod. Order Component"; "Prod. Order Component")
                {
                    DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("Prod. Order No."), "Prod. Order Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                    column(ItemNo_ProdOrderComponent; "Prod. Order Component"."Item No.")
                    {
                    }
                    column(Description_ProdOrderComponent; "Prod. Order Component".Description)
                    {
                    }
                    column(UnitofMeasureCode_ProdOrderComponent; "Prod. Order Component"."Unit of Measure Code")
                    {
                    }
                    column(ExpectedQuantity_ProdOrderComponent; ROUND("Prod. Order Component"."Quantity per" * "Prod. Order Line"."Finished Quantity", 0.02))
                    {
                    }
                    column(RemainingQuantity_ProdOrderComponent; "Prod. Order Component"."Remaining Quantity")
                    {
                    }
                    column(CompItemInventory; CompItem.Inventory)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                 //   column(CompItemSchdldNeedQty; CompItem."Scheduled Need (Qty.)") //BC Upgrade GUNREM01 -Commenetd field removed by Microsoft
                                      column(CompItemSchdldNeedQty; CompItem."Qty. on Component Lines") //BC Upgrade GUNREM01 -Added field to replace removed field by Microsoft

                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(NeededQuantity; NeededQty)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(ItemNo_ProdOrderComp; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(CompItemInvRemQtyBase; QtyOnHandAfterProd)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Desc_ProdOrderComp; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(CompItemSchdldRcptQty; CompItem."Scheduled Receipt (Qty.)")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(CompItemQtyonPurchOrder; CompItem."Qty. on Purch. Order")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(CompItemQtyonSalesOrder; CompItem."Qty. on Sales Order")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(RemQtyBase_ProdOrderComp; RemainingQty)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(PostingDate_ValueEntry; FORMAT(ValueEntry."Posting Date"))
                    {
                    }
                    column(UserID_ValueEntry; ValueEntry."User ID")
                    {
                    }
                    column(MinValue; MinValue)
                    {
                    }
                    column(MaxValue; MaxValue)
                    {
                    }
                    column(LocationCode; Location.Code)
                    {
                    }
                    column(tolerance; Location."Consump. Tolerance Limit % FND")
                    {
                    }
                    column(TotalItems; TotalItems)
                    {
                    }

                    trigger OnAfterGetRecord();
                    var
                        TempProdOrderLine: Record "Prod. Order Line" temporary;
                        TempProdOrderComp: Record "Prod. Order Component" temporary;
                    begin
                        CLEAR(ValueEntry."Posting Date");
                        CLEAR(ValueEntry."User ID");
                        CLEAR(TotalItems);
                        CLEAR(ExpectedQty);


                        ValueEntry.SETRANGE("Order Type", ValueEntry."Order Type"::Production);
                        ValueEntry.SETRANGE("Order No.", "Prod. Order Line"."Prod. Order No.");
                        ValueEntry.SETRANGE("Item No.", "Prod. Order Line"."Item No.");
                        if ValueEntry.FINDFIRST() then;


                        if PostingDate <> '' then begin
                            ValueEntry.SETFILTER("Posting Date", PostingDate);
                            if not ValueEntry.FINDFIRST() then
                                CurrReport.SKIP();
                        end;


                        if (StartDate <> 0D) or (EndDate <> 0D) then begin
                            ValueEntry.SETRANGE("Posting Date", StartDate, EndDate);
                            if not ValueEntry.FINDFIRST() then
                                CurrReport.SKIP()
                        end;

                        ItemLedgerEntry.RESET();
                        ItemLedgerEntry.SETRANGE("Order No.", "Prod. Order No.");
                        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                        ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                        if ItemLedgerEntry.FINDSET() then
                            repeat
                                TotalItems += ItemLedgerEntry.Quantity;
                            until ItemLedgerEntry.NEXT() = 0;


                        Location.SETRANGE(Code, "Location Code");
                        if Location.FINDFIRST() then begin
                            // MinValue := ABS("Expected Quantity") - ((Location."Consump. Tolerance Limit %" / 100) * ABS("Expected Quantity"));
                            //MaxValue := ABS("Expected Quantity") + ((Location."Consump. Tolerance Limit %" / 100) * ABS("Expected Quantity"));
                            MinValue := (1 - Location."Consump. Tolerance Limit % FND" / 100) * (ABS("Prod. Order Line"."Finished Quantity") * ABS("Prod. Order Component"."Quantity per"));
                            MaxValue := (1 + Location."Consump. Tolerance Limit % FND" / 100) * (ABS("Prod. Order Line"."Finished Quantity") * ABS("Prod. Order Component"."Quantity per"));
                            if (ABS(TotalItems) >= ABS(MinValue)) and (ABS(TotalItems) <= ABS(MaxValue)) then
                                CurrReport.SKIP();
                        end else
                            CurrReport.SKIP();
                    end;
                }
            }
        }
    }

    requestpage
    {
        Caption = 'Consumption Deviations';
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(PostingDate; PostingDate)
                {
                    Caption = 'Posting Date';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        label(Status_ProdOrderCaption; ENU = 'Status',
                                      FRA = 'Statut')
        ProdOderNoCaption = 'Prod. Order No.'; ItemNoCaption = 'Item No. (Produced)'; ItemDescriptionCaption = 'Item Description (Produced)'; ItemNoConsCaption = 'Item No. (Consumed)'; ItemDescConsCaption = 'Item Description (Consumed)'; UoMCaption = 'UoM'; ExpectedQtyCaption = 'Expected Qty.'; QtyOutofRange = 'Qty. out of Target Range'; PostingDateCaption = 'Posting Date'; UserIDCaption = 'User ID';
    }

    trigger OnPreReport();
    begin
        if (StartDate <> 0D) and (EndDate = 0D) then
            EndDate := TODAY;
    end;

    var
        CompItem: Record Item;
        RemainingQty: Decimal;
        NeededQty: Decimal;
        QtyOnHandAfterProd: Decimal;
        ShortageListCaptionLbl: TextConst ENU = 'Shortage List', FRA = 'Liste des ruptures';
        PageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        NeededQtyCaptionLbl: TextConst ENU = 'Needed Quantity', FRA = 'Quantité nécessaire';
        CompItemScheduledNeedQtyCaptionLbl: TextConst ENU = 'Scheduled Need', FRA = 'Besoin planifié';
        CompItemInventoryCaptionLbl: TextConst ENU = 'Quantity on Hand', FRA = 'Quantité disponible';
        RemainingQtyBaseCaptionLbl: TextConst ENU = 'Qty. on Hand after Production', FRA = 'Stock physique après production';
        RemQtyBaseCaptionLbl: TextConst ENU = 'Remaining Qty. (Base)', FRA = 'Quantité restante (base)';
        ReceiptQtyCaptionLbl: TextConst ENU = 'Scheduled Receipt', FRA = 'Réception planifiée';
        QtyonPurchOrderCaptionLbl: TextConst ENU = 'Qty. on Purch. Order', FRA = 'Qté sur commande achat';
        QtyonSalesOrderCaptionLbl: TextConst ENU = 'Qty. on Sales Order', FRA = 'Qté sur commande vente';
        ReportTitle: Label 'Consumption Deviations';
        ValueEntry: Record "Value Entry";
        StartDate: Date;
        EndDate: Date;
        MinValue: Decimal;
        MaxValue: Decimal;
        Location: Record Location;
        TxtDate: Text;
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalItems: Decimal;
        PostingDate: Text;
        ExpectedQty: Decimal;

    local procedure FormatTextDateFilter(TxtDate: Text);
    begin
    end;
}

