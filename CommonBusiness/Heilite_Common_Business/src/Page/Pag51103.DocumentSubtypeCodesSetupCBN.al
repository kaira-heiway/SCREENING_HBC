page 51103 "DocSubtypeCodeSetupCBN"
{

    // BC Upgrade BHANDS01 >> 2 Mar 2026 => Created Page

    CaptionML = ENU = 'Document Subtype Codes Setup',
                FRA = 'Paramétres code sous-type document';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Doc Subtype Code Setup FND";

    layout
    {
        area(content)
        {
            group(Sales)
            {
                CaptionML = ENU = 'Sales',
                            FRA = 'Ventes';
                field("Sales - General"; Rec."Sales - General")
                {
                }
                field("Sales - Periodic Discounts"; Rec."Sales - Periodic Discounts")
                {
                }
                field("Std Sales Return Order RPM"; Rec."Std Sales Return Order RPM")
                {
                }
                field("Std Sales Order(Inc.FreeGoods)"; Rec."Std Sales Order(Inc.FreeGoods)")
                {
                }
                field("Credit Memo-Qty Correction"; Rec."Credit Memo-Qty Correction")
                {
                }
                field("CreditMemo-PriceCorr(Negative)"; Rec."CreditMemo-PriceCorr(Negative)")
                {
                }
                field("CreditMemo-PriceCorr(Positive)"; Rec."CreditMemo-PriceCorr(Positive)")
                {
                }
                field("Sundry Sales Order Stock"; Rec."Sundry Sales Order Stock")
                {
                }
                field("Sundry Sales Order Non Stock"; Rec."Sundry Sales Order Non Stock")
                {
                }
                field("Debit Memo- Reinvoice Recharge"; Rec."Debit Memo- Reinvoice Recharge")
                {
                }
                field("Standard Sales Return Order"; Rec."Standard Sales Return Order")
                {
                }
                field("CTS Order"; Rec."CTS Order")
                {
                }
                field("Default Sales Order"; Rec."Default Sales Order")
                {
                }
                field("Order Generated from Quote"; Rec."Order Generated from Quote")
                {
                }
            }
            group(Purchase)
            {
                CaptionML = ENU = 'Purchase',
                            FRA = 'Achat';
                field("Purchase - General"; Rec."Purchase - General")
                {
                }
                field("Purchase - Periodic Discounts"; Rec."Purchase - Periodic Discounts")
                {
                }
            }

            group(Inventory)
            {
                CaptionML = ENU = 'Inventory',
                            FRA = 'Stocks';
                field("Transfer - General"; Rec."Transfer - General")
                {
                }
            }

        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.RESET;
        if not Rec.GET then begin
            Rec.INIT;
            Rec.INSERT;
        end;
    end;
}

