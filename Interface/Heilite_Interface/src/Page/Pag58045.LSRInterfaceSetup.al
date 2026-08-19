page 58045 "LSR Interface Setup"
{
    // Heilite Navision Old Id - 50388

    // version HEI.09

    // HEI.01 FDD-HB899 - CHG2044703 IBM GAVANM01 13.12.2020 # New POS System Required for OPCO
    //   # New Page created for LSR Interfaces
    // HEI.02 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New Group created: "LSR Sales and Payments"
    //   # New field added: "Fixed Lot No."
    // HEI.03 FDD-HB899 - CHG2093868 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New Group created: "LSR Purchase"
    //   # New fields added: PO Inbound Interface, PO Outbound Interface, PR Interface, Order Nos., Payout Interface,
    //                       Quote Nos., Payouts Gen. Journal Template, Payouts Gen. Journal Batch
    // HEI.04 FDD-HB899 - CHG2093869 IBM NASTAA02 23.02.2021 # LSR - Transfer and Stock
    //   # New Groups created: 'LSR Transfers' and'LSR Stock'
    //   # New Fields added: "Transfer Shipment Interface", "Transfer Receipt Interface", "Transfer Receipt Interface Out", "Stock Adjustment Interface",
    //     "Stock Image Interface", "Item Reclass. Jnl. Template", "Item Reclass. Jnl. Batch", "LSR Central Locations"
    // HEI.05 CHG2093869 GAVANM01 05.03.2021 #Transfer and Stock adjustments interfaces Bahamas LS Retail
    //   # new fields added: Transfer Order Interface, Transfer Order Del. Interface, Transfer Shipment Out. Interf.
    // HEI.06 HB3459 CHG2213859 IBM COSTES04 15.09.2023 LSR- Customer Ledger entries apply matching entries- Dev
    //   # New field  Source System Identifier
    // HEI.07 CHG2216722 IBM SISUM01 03.10.2023  Request for email functionality for Transfer Order Creation
    //   # Add the new fields (Id 103 to 106) to LSR Transfers group
    //   # Add new action: Transfers Email Id
    // HEI.08 CHG2227143 IBM COSTE04 14.03.2024 Item Reclass to Support LSR Integrations
    //   # New field added Item Reclass Tracking Code
    // HEI.09 CHG2290087 IBM COSTE04 02.04.2025-HB3894-Payouts Posting from LSR
    //   # Add Balance account from setup

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Manage,Process,Filters';
    SourceTable = "LSR Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Enable LSR Interface"; Rec."Enable LSR Interface")
                {
                    ToolTip = 'Specifies the value of the Enable LSR Interface field.';
                }
                field("Source System Identifier"; Rec."Source System Identifier")
                {
                    ToolTip = 'Specifies the value of the Source System Identifier field.';
                }
            }
            group("LSR Master data")
            {
                field("LSR Item Interface"; Rec."LSR Item Interface")
                {
                    ToolTip = 'Specifies the value of the LSR Item Interface field.';
                }
                field("LSR Customer Interface"; Rec."LSR Customer Interface")
                {
                    ToolTip = 'Specifies the value of the LSR Customer Interface field.';
                }
                field("LSR Vendor Interface"; Rec."LSR Vendor Interface")
                {
                    ToolTip = 'Specifies the value of the LSR Vendor Interface field.';
                }
                field("Item Category Filter"; Rec."Item Category Filter")
                {
                    ToolTip = 'Specifies the value of the Item Category to be Included field.';
                }
                field("Customer Acc Group Filter"; Rec."Customer Acc Group Filter")
                {
                    ToolTip = 'Specifies the value of the Customer Account groups to be Included field.';
                }
                field("Vendor Acc Group Filter"; Rec."Vendor Acc Group Filter")
                {
                    ToolTip = 'Specifies the value of the Vendor Account groups to be Included field.';
                }
            }
            group("LSR Sales and Payments")
            {
                field("Fixed Lot No."; Rec."Fixed Lot No.")
                {
                    ToolTip = 'Specifies the value of the Fixed Lot No. field.';
                }
            }
            group("LSR Purchase")
            {
                field("PO Inbound Interface"; Rec."PO Inbound Interface")
                {
                    ToolTip = 'Specifies the value of the PO Inbound Interface field.';
                }
                field("PO Outbound Interface"; Rec."PO Outbound Interface")
                {
                    ToolTip = 'Specifies the value of the PO Outbound Interface field.';
                }
                field("PR Interface"; Rec."PR Interface")
                {
                    ToolTip = 'Specifies the value of the PR Interface field.';
                }
                field("Payout Interface"; Rec."Payout Interface")
                {
                    ToolTip = 'Specifies the value of the Payout Interface field.';
                }
                field("Order Nos."; Rec."Order Nos.")
                {
                    ToolTip = 'Specifies the value of the Order Nos. field.';
                }
                field("Quote Nos."; Rec."Quote Nos.")
                {
                    ToolTip = 'Specifies the value of the Quote Nos. field.';
                }
                field("Payouts Gen. Journal Template"; Rec."Payouts Gen. Journal Template")
                {
                    ToolTip = 'Specifies the value of the Payouts - Gen. Journal Template field.';
                }
                field("Payouts Gen. Journal Batch"; Rec."Payouts Gen. Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Payouts-Gen. Journal Batch field.';
                }
                field("Payouts Payment Method"; Rec."Payouts Payment Method")
                {
                    ToolTip = 'Specifies the value of the Payouts Payment Method field.';
                }
            }
            group("LSR Transfers")
            {
                Caption = 'LSR Transfers';
                field("Transfer Order Interface"; Rec."Transfer Order Interface")
                {
                    ToolTip = 'Specifies the value of the Transfer Order Interface field.';
                }
                field("Transfer Order Del. Interface"; Rec."Transfer Order Del. Interface")
                {
                    ToolTip = 'Specifies the value of the Transfer Order Deletion Interface field.';
                }
                field("Transfer Shipment Interface"; Rec."Transfer Shipment Interface")
                {
                    ToolTip = 'Specifies the value of the Transfer Shipment Interface field.';
                }
                field("Transfer Shipment Out. Interf."; Rec."Transfer Shipment Out. Interf.")
                {
                    ToolTip = 'Specifies the value of the Transfer Shipment Outbound Interface field.';
                }
                field("Transfer Receipt Interface"; Rec."Transfer Receipt Interface")
                {
                    ToolTip = 'Specifies the value of the Transfer Receipt Interface field.';
                }
                field("Transfer Receipt Interface Out"; Rec."Transfer Receipt Interface Out")
                {
                    ToolTip = 'Specifies the value of the Transfer Receipt Interface Outbound field.';
                }
                field("Item Reclass. Jnl. Template"; Rec."Item Reclass. Jnl. Template")
                {
                    ToolTip = 'Specifies the value of the Item Reclassification Journal Template field.';
                }
                field("Item Reclass. Jnl. Batch"; Rec."Item Reclass. Jnl. Batch")
                {
                    ToolTip = 'Specifies the value of the Item Reclassification Journal Batch field.';
                }
                field("Item Reclass. Tracking Code"; Rec."Item Reclass. Tracking Code")
                {
                    ToolTip = 'Specifies the value of the Item Reclass. Tracking Code field.';
                }
                field("Enable Email LSR-TO"; Rec."Enable Email LSR-TO")
                {
                    ToolTip = 'Specifies the value of the Enable Email LSR-TO field.';
                }
                field("Enable Email LSR-TS-OUT"; Rec."Enable Email LSR-TS-OUT")
                {
                    ToolTip = 'Specifies the value of the Enable Email LSR-TS-OUT field.';
                }
                field("Body Email LSR-TO"; Rec."Body Email LSR-TO")
                {
                    ToolTip = 'Specifies the value of the Body Email LSR-TO field.';
                }
                field("Body Email LSR-TS-OUT"; Rec."Body Email LSR-TS-OUT")
                {
                    ToolTip = 'Specifies the value of the Body Email LSR-TS-OUT field.';
                }
            }
            group("LSR Stock")
            {
                Caption = 'LSR Stock';
                field("Stock Adjustment Interface"; Rec."Stock Adjustment Interface")
                {
                    ToolTip = 'Specifies the value of the Stock Adjustment Interface field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // Caption = 'Options';  // BC Upgrade NANDIS03
            action("Items Included/Excluded")
            {
                Caption = 'Items Included/Excluded';
                Image = Item;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Items Included/Excluded action.';

                trigger OnAction();
                begin
                    LSRMasterIncl_ExclPage.SetType(0); //Item
                    LSRMasterIncl_ExclPage.RUNMODAL();
                    CLEAR(LSRMasterIncl_ExclPage);
                end;
            }
            action("Customers Included/Excluded")
            {
                Caption = 'Customers Included/Excluded';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Customers Included/Excluded action.';

                trigger OnAction();
                begin
                    LSRMasterIncl_ExclPage.SetType(1); //Customer
                    LSRMasterIncl_ExclPage.RUNMODAL();
                    CLEAR(LSRMasterIncl_ExclPage);
                end;
            }
            action("Vendors Included/Excluded")
            {
                Caption = 'Vendors Included/Excluded';
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Vendors Included/Excluded action.';

                trigger OnAction();
                begin
                    LSRMasterIncl_ExclPage.SetType(2); //Vendor
                    LSRMasterIncl_ExclPage.RUNMODAL();
                    CLEAR(LSRMasterIncl_ExclPage);
                end;
            }
            action("Transfers Email id")
            {
                Caption = 'Transfers Email id';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "LSR Transfers Email Id Setup";
                ToolTip = 'Executes the Transfers Email id action.';
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.GET() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
    end;

    var
        LSRMasterIncl_ExclPage: Page "LSR Master Included/Excluded";
}

