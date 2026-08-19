page 58015 "Counterpoint Interface Setup"
{
    // Heilite Navision Old Id - 50245

    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 19.10.2018 # Counterpoint Interface
    //   # New Page created to setup the Counterpoint Interface

    Caption = 'Counterpoint Interface Setup';
    PageType = Card;
    SourceTable = "Counterpoint Interf. Stp INT";
    ApplicationArea = All; // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    layout
    {
        area(content)
        {
            group(Interfaces)
            {
                Caption = 'Counterpoint Interfaces';
                field("Sales Interface"; Rec."Sales Interface")
                {
                    ToolTip = 'Specifies the value of the Sales Interface field.';
                }
                field("Payouts Interface"; Rec."Payouts Interface")
                {
                    ToolTip = 'Specifies the value of the Payouts Interface field.';
                }
                field("Payments Interface"; Rec."Payments Interface")
                {
                    ToolTip = 'Specifies the value of the Payments Interface field.';
                }
                field("Stock Adjustments Interface"; Rec."Stock Adjustments Interface")
                {
                    ToolTip = 'Specifies the value of the Stock Adjustments Interface field.';
                }
                field("Stock Transfers Interface"; Rec."Stock Transfers Interface")
                {
                    ToolTip = 'Specifies the value of the Stock Transfers Interface field.';
                }
                field("Receipts Non Core Interface"; Rec."Receipts Non Core Interface")
                {
                    ToolTip = 'Specifies the value of the Receipts Non-Core Interface field.';
                }
                field("RTV Non Core Interface"; Rec."RTV Non Core Interface")
                {
                    ToolTip = 'Specifies the value of the RTV Non-Core Interface field.';
                }
            }
            group("Counterpoint Interface Setup INT")
            {
                Caption = 'General';
                field("Burns House CP No."; Rec."Burns House CP No.")
                {
                    ToolTip = 'Specifies the value of the Burns House CP No. field.';
                }
                field("Sales Excise Tax"; Rec."Sales Excise Tax")
                {
                    ToolTip = 'Specifies the value of the Sales Excise Tax field.';
                }
                field("Loyalty Sales Reduction TPR"; Rec."Loyalty Sales Reduction TPR")
                {
                    ToolTip = 'Specifies the value of the Loyalty Sales Reduction TPR field.';
                }
                field("Loyalty Deferred Revenue"; Rec."Loyalty Deferred Revenue")
                {
                    ToolTip = 'Specifies the value of the Loyalty Deferred Revenue field.';
                }
                field("TopUp Accrued Liabilities"; Rec."TopUp Accrued Liabilities")
                {
                    ToolTip = 'Specifies the value of the Top-Up Accrued Liabilities field.';
                }
                field("TopUp Account"; Rec."TopUp Account")
                {
                    ToolTip = 'Specifies the value of the Top-Up Account field.';
                }
                field("TopUp Acc. Liability %"; Rec."TopUp Acc. Liability %")
                {
                    ToolTip = 'Specifies the value of the Top-Up Acc. Liability % field.';
                }
                field("Other Expenses"; Rec."Other Expenses")
                {
                    ToolTip = 'Specifies the value of the Other Expenses field.';
                }
                field("Sales Gen. Journal Template"; Rec."Sales Gen. Journal Template")
                {
                    ToolTip = 'Specifies the value of the Sales - Gen. Journal Template field.';
                }
                field("Sales Gen. Journal Batch"; Rec."Sales Gen. Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Sales - Gen. Journal Batch field.';
                }
                field("Sales VAT Code"; Rec."Sales VAT Code")
                {
                    ToolTip = 'Specifies the value of the Sales VAT Code field.';
                }
                field("Sales No VAT Code"; Rec."Sales No VAT Code")
                {
                    ToolTip = 'Specifies the value of the Sales No VAT Code field.';
                }
                field("Payments Gen. Jnl Template"; Rec."Payments Gen. Jnl Template")
                {
                    ToolTip = 'Specifies the value of the Payments - Gen. Journal Template field.';
                }
                field("Payments Gen. Jnl Batch"; Rec."Payments Gen. Jnl Batch")
                {
                    ToolTip = 'Specifies the value of the Payments - Gen. Journal Batch field.';
                }
                field("Payouts Gen. Journal Template"; Rec."Payouts Gen. Journal Template")
                {
                    ToolTip = 'Specifies the value of the Payouts - Gen. Journal Template field.';
                }
                field("Payouts Gen. Journal Batch"; Rec."Payouts Gen. Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Payouts-Gen. Journal Batch field.';
                }
                field("COGS Item Journal Template"; Rec."COGS Item Journal Template")
                {
                    ToolTip = 'Specifies the value of the COGS - Item Journal Template field.';
                }
                field("COGS Item Journal Batch"; Rec."COGS Item Journal Batch")
                {
                    ToolTip = 'Specifies the value of the COGS - Item Journal Batch field.';
                }
                field("Stock Adjst Item Jnl Template"; Rec."Stock Adjst Item Jnl Template")
                {
                    ToolTip = 'Specifies the value of the Stock Adjst - Item Journal Template field.';
                }
                field("Stock Adjst Item Jnl Batch"; Rec."Stock Adjst Item Jnl Batch")
                {
                    ToolTip = 'Specifies the value of the Stock Adjst - Item Journal Batch field.';
                }
                field("Stock Transf Item Jnl Template"; Rec."Stock Transf Item Jnl Template")
                {
                    ToolTip = 'Specifies the value of the Stock Transfer - Item Journall Template field.';
                }
                field("Stock Transf Item Jnl Batch"; Rec."Stock Transf Item Jnl Batch")
                {
                    ToolTip = 'Specifies the value of the Stock Transfer - Item Journal Batch field.';
                }
                field("PO Receipts Item Jnl Template"; Rec."PO Receipts Item Jnl Template")
                {
                    ToolTip = 'Specifies the value of the Purch. Order Receipts - Item Journal Template field.';
                }
                field("PO Receipts Item Jnl Batch"; Rec."PO Receipts Item Jnl Batch")
                {
                    ToolTip = 'Specifies the value of the PO Receipts-Item Journal Batch field.';
                }
                field("RTV Item Jnl Template"; Rec."RTV Item Jnl Template")
                {
                    ToolTip = 'Specifies the value of the RTV - Item Journal Template field.';
                }
                field("RTV Item Jnl Batch"; Rec."RTV Item Jnl Batch")
                {
                    ToolTip = 'Specifies the value of the RTV - Item Journall Batch field.';
                }
                field("Item UoM Retail"; Rec."Item UoM Retail")
                {
                    ToolTip = 'Specifies the value of the Item UoM Retail field.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ToolTip = 'Specifies the value of the Zone Code field.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
                }
                field("Fixed Lot No."; Rec."Fixed Lot No.")
                {
                    ToolTip = 'Specifies the value of the Fixed Lot No. field.';
                }
                field("Investment Level Dimension"; Rec."Investment Level Dimension")
                {
                    ToolTip = 'Specifies the value of the Investment Level Dimension field.';
                }
                field("Investment Level Dim Value"; Rec."Investment Level Dim Value")
                {
                    ToolTip = 'Specifies the value of the Investment Level Dim Value field.';
                }
            }
        }
    }

    actions
    {
    }
}

