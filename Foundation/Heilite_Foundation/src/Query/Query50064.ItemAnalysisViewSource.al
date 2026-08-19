
query 50064 "Item Analysis View Source Cust"
{
    //Bc Upgrade YADAVM09 New Query created for base Query 7150(Item Analysis View Source) to adjust custom code.

    Caption = 'Item Analysis View Source';

    elements
    {
        dataitem(ItemAnalysisView; "Item Analysis View")
        {
            filter(AnalysisArea; "Analysis Area")
            {
            }
            filter(AnalysisViewCode; "Code")
            {
            }
            dataitem(ValueEntry; "Value Entry")
            {
                SqlJoinType = CrossJoin;
                filter(EntryNo; "Entry No.")
                {
                }
                column(ItemNo; "Item No.")
                {
                }
                column(SourceType; "Source Type")
                {
                }
                column(SourceNo; "Source No.")
                {
                }
                column(EntryType; "Entry Type")
                {
                }
                column(ItemLedgerEntryType; "Item Ledger Entry Type")
                {
                }
                column(ItemLedgerEntryNo; "Item Ledger Entry No.")
                {
                }
                column(ItemChargeNo; "Item Charge No.")
                {
                }
                column(LocationCode; "Location Code")
                {
                }
                column(PostingDate; "Posting Date")
                {
                }
                column(DimensionSetID; "Dimension Set ID")
                {
                }
                column(ILEQuantity; "Item Ledger Entry Quantity")
                {
                    Method = Sum;
                }
                column(InvoicedQuantity; "Invoiced Quantity")
                {
                    Method = Sum;
                }
                column(SalesAmountActual; "Sales Amount (Actual)")
                {
                    Method = Sum;
                }
                column(SalesAmountExpected; "Sales Amount (Expected)")
                {
                    Method = Sum;
                }
                column(CostAmountActual; "Cost Amount (Actual)")
                {
                    Method = Sum;
                }
                column(CostAmountNonInvtbl; "Cost Amount (Non-Invtbl.)")
                {
                    Method = Sum;
                }
                column(CostAmountExpected; "Cost Amount (Expected)")
                {
                    Method = Sum;
                }
                //Bc Upgrade YADAVM09BCUP0-167>>
                dataitem(ItemLedgerEntry; "Item Ledger Entry")
                {
                    DataItemLink = "Entry No." = ValueEntry."Item Ledger Entry No.";

                    column(Volume1; "Volume 1 101FDW")
                    {

                    }
                    column(Volume2; "Volume 2 101FDW")
                    {

                    }
                    column(Net_Weight_1_101FDW; "Net Weight 1 101FDW")
                    {

                    }
                    column(Net_Weight_2_101FDW; "Net Weight 2 101FDW")
                    {

                    }
                    column(Gross_Weight_1_101FDW; "Gross Weight 1 101FDW")
                    {

                    }
                    column(Gross_Weight_2_101FDW; "Gross Weight 2 101FDW")
                    {

                    }

                    //Bc Upgrade YADAVM09 BCUP0-167<<
                    dataitem(DimSet1; "Dimension Set Entry")
                    {
                        DataItemLink = "Dimension Set ID" = ValueEntry."Dimension Set ID", "Dimension Code" = ItemAnalysisView."Dimension 1 Code";
                        column(DimVal1; "Dimension Value Code")
                        {
                        }
                        dataitem(DimSet2; "Dimension Set Entry")
                        {
                            DataItemLink = "Dimension Set ID" = ValueEntry."Dimension Set ID", "Dimension Code" = ItemAnalysisView."Dimension 2 Code";
                            column(DimVal2; "Dimension Value Code")
                            {
                            }
                            dataitem(DimSet3; "Dimension Set Entry")
                            {
                                DataItemLink = "Dimension Set ID" = ValueEntry."Dimension Set ID", "Dimension Code" = ItemAnalysisView."Dimension 3 Code";
                                column(DimVal3; "Dimension Value Code")
                                {
                                }
                                //BC Upgrade YADAVM09-- Added
                                dataitem(DimSet4; "Dimension Set Entry")
                                {
                                    DataItemLink = "Dimension Set ID" = ValueEntry."Dimension Set ID", "Dimension Code" = ItemAnalysisView."Shortcut 1 Code FND";
                                    column(DimVal4; "Dimension Value Code")
                                    {
                                    }
                                    dataitem(DimSet5; "Dimension Set Entry")
                                    {
                                        DataItemLink = "Dimension Set ID" = ValueEntry."Dimension Set ID", "Dimension Code" = ItemAnalysisView."Shortcut 2 Code FND";
                                        column(DimVal5; "Dimension Value Code")
                                        {
                                        }
                                    }
                                }
                                //BC Upgrade YADAVM09-- Added
                            }
                        }
                    }
                }
            }
        }
    }
}

