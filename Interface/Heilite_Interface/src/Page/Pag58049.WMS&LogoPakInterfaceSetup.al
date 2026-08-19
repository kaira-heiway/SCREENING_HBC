page 58049 "WMS & LogoPak Interface Setup"
{
    // Heilite Navision Old Id - 50411

    // version HEI.12

    // HEI.01 CHG2043663 FDD-HT318 BULIMC01 IBM 4.12.2019 #new page created for WMS Interface
    // HEI.02 CHG2043663 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    //   # New fields added
    //     # 20Sales Order InterfaceCode20
    //     # 21Warehouse Shipment InterfaceCode20
    //     # 22Sales Order Deletion InterfaceCode20
    //     # 23Post Inb. Shipment InterfaceOption
    //     # 24Email ErrorsText50
    //     # 25Email SubjectText50
    // HEI.03 CHG2043663 FDD-HT604 IBM GAVANM01 13.01.2020 # WMS integration Heilite BASE and Reflex
    //   # new tab Transfer Order
    //   # New fields added in Transfer Order tab: TO Interface, TO Interface Purchase, TO Deletion Interface, Location on REFLEX
    // HEI.04 CHG2043663 FDD-HT604 IBM GAVANM01 18.01.2020 # WMS integration Heilite BASE and Reflex
    //   # New fields added in Transfer Order tab: Warehouse TS Interface, Post Inb. TS Interface, Email Errors TS, Email Subject TS
    // HEI.05 CHG2043663 FDD-HT604 IBM GAVANM01 18.01.2020 # WMS Transfer Receipt
    //   # New field added in Transfer tab: Warehouse RE Interface
    // HEI.06 CHG2043663 FDD-HT604 IBM.COSTES02 09.12.2019 # WMS integration Heilite BASE and Reflex
    //   # New fields added
    //     # 40Stock Adjustment Template
    //     # 41Stock Adjustment Batch
    //     # 42Stock Adjustment Interface
    //     # 50Warehouse Movement Interface
    // HEI.07 CHG2077574 IBM GAVANM01 04.09.2020 # WMS Integration
    //   # new action added "WMS Items Included/Excluded"
    //   # page property changed PromotedActionCategoriesML
    // HEI.08 CHG2129985 SAHAL01      14.04.2022
    //   # Added New Tab - LogoPak
    //   # Added New Fields - Activate LogoPak Interface
    //                      - Prod. Order Interface
    //                      - Prod. Order Output Interface
    //                      - Prod. Order Output Template
    //                      - Prod. Order Output Batch
    //   # Changed Page Name from "WMS Interface Setup" to "WMS & LogoPak Interface Setup"
    // HEI.09 CHG2128692 HB2155 IBM GAVANM01 10.11.2021 # WMS Interface Sales Return
    //   # New fields added: - SRO Interface, SRO Deletion Interface
    // HEI.10 FDD-HB2155 CHG2128694 IBM NANDIS01 10.11.2021 WMS PO
    //   # "Warehouse RE Interface" added in Sales Order & Sales Return Order TAB - named "Warehouse RE Interfaces PO"
    //   # New TAB created - Purchase Order and below fields added in that TAB
    //                       "Purchase Order Interface", "Purchase Order Deletion Interface", WMS RE Interface, Email Errors, Email Subject
    // HEI.11 CHG2107450 HB2156 IBM BHANDS01 23.03.2022 # WMS Phase 2 - Transportation costs
    //   # Added new field "Enable New WMS TC"
    // HEI.12 CHG2184595 IBM COSTES04 31.03.2023 Prioritization Sales Orders
    //   # Add new action for WMS Source System Identifier

    Caption = 'WMS & LogoPak Interface Setup';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Manage,Process,Report,Filters';
    SourceTable = "WMS Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group("WMS Master Interfaces")
            {
                field("WMS Integration"; Rec."WMS Integration")
                {
                    ToolTip = 'Specifies the value of the WMS Integration field.';
                }
                field("Item Category"; Rec."Item Category")
                {
                    ToolTip = 'Specifies the value of the Item Category To Be Included field.';
                }
                field("Customer Account Groups"; Rec."Customer Account Groups")
                {
                    ToolTip = 'Specifies the value of the Customer Account Groups To Be Included field.';
                }
                field("Customer Request Interface"; Rec."Customer Request Interface")
                {
                    ToolTip = 'Specifies the value of the Customer Request Interface field.';
                }
                field("Customer Response Interface"; Rec."WMS Customer Interface")
                {
                    ToolTip = 'Specifies the value of the WMS Customer Interface field.';
                }
                field("Item Request Interface"; Rec."Item Request Interface")
                {
                    ToolTip = 'Specifies the value of the Item Request Interface field.';
                }
                field("Item Response Interface"; Rec."WMS Item Interface")
                {
                    ToolTip = 'Specifies the value of the WMS Item Interface field.';
                }
                field("Reflex 1st OUM"; Rec."Reflex 1st OUM")
                {
                    Caption = 'Reflex 1st UOM';
                    ToolTip = 'Specifies the value of the Reflex 1st UOM field.';
                }
                field("Reflex 2rd OUM"; Rec."Reflex 2rd OUM")
                {
                    Caption = 'Reflex 2nd UOM';
                    ToolTip = 'Specifies the value of the Reflex 2nd UOM field.';
                }
                field("Reflex 3rd OUM"; Rec."Reflex 3rd OUM")
                {
                    Caption = 'Reflex 3rd UOM';
                    ToolTip = 'Specifies the value of the Reflex 3rd UOM field.';
                }
                field("Starting Modified Date"; Rec."Starting Modified Date")
                {
                    ToolTip = 'Specifies the value of the Starting Modified Date field.';
                }
            }
            group("Sales Order and Sales Return Order")
            {
                Caption = 'Sales Order and Sales Return Order';
                field("Sales Order Interface"; Rec."Sales Order Interface")
                {
                    ToolTip = 'Specifies the value of the Sales Order Interface field.';
                }
                field("Enable New WMS TC"; Rec."Enable New WMS TC")
                {
                    ToolTip = 'Specifies the value of the Enable New WMS TC field.';
                }
                field("Warehouse Shipment Interface"; Rec."Warehouse Shipment Interface")
                {
                    ToolTip = 'Specifies the value of the Warehouse Shipment Interface field.';
                }
                field("Sales Order Deletion Interface"; Rec."Sales Order Deletion Interface")
                {
                    ToolTip = 'Specifies the value of the Sales Order Deletion Interface field.';
                }
                field("Warehouse Receipts Interfaces PO"; Rec."Warehouse RE Interface")
                {
                    Caption = 'Warehouse Receipts Interfaces PO';
                    ToolTip = 'Specifies the value of the Warehouse Receipts Interfaces PO field.';
                }
                group(Control55040)
                {
                    field("SRO Interface"; Rec."SRO Interface")
                    {
                        ToolTip = 'Specifies the value of the Sales Return Order Interface field.';
                    }
                    field("SRO Deletion Interface"; Rec."SRO Deletion Interface")
                    {
                        ToolTip = 'Specifies the value of the Sales Return Order Deletion Interface field.';
                    }
                }
                field("Post Inb. Shipment Interface"; Rec."Post Inb. Shipment Interface")
                {
                    ToolTip = 'Specifies the value of the Post Inb. Shipment Interface field.';
                }
                field("Email Errors"; Rec."Email Errors")
                {
                    ToolTip = 'Specifies the value of the Email Errors field.';
                }
                field("Email Subject"; Rec."Email Subject")
                {
                    ToolTip = 'Specifies the value of the Email Subject field.';
                }
            }
            group("Transfer Order")
            {
                Caption = 'Transfer Order';
                field("TO Interface"; Rec."TO Interface")
                {
                    ToolTip = 'Specifies the value of the Transfer Order Interface Sales field.';
                }
                field("TO Interface Purchase"; Rec."TO Interface Purchase")
                {
                    ToolTip = 'Specifies the value of the Transfer Order Interface Purchase field.';
                }
                field("TO Deletion Interface"; Rec."TO Deletion Interface")
                {
                    ToolTip = 'Specifies the value of the Transfer Order Deletion Interface field.';
                }
                field("Location on REFLEX"; Rec."Location on REFLEX")
                {
                    ToolTip = 'Specifies the value of the Location on REFLEX field.';
                }
                field("Warehouse TS Interface"; Rec."Warehouse TS Interface")
                {
                    ToolTip = 'Specifies the value of the Warehouse Shipment Interface field.';
                }
                field("Post Inb. TS Interface"; Rec."Post Inb. TS Interface")
                {
                    ToolTip = 'Specifies the value of the Post Inb. Shipment Interface field.';
                }
                field("Warehouse RE Interface"; Rec."Warehouse RE Interface")
                {
                    ToolTip = 'Specifies the value of the Warehouse Receipt Interface field.';
                }
                field("Email Errors TS"; Rec."Email Errors TS")
                {
                    ToolTip = 'Specifies the value of the Email Errors field.';
                }
                field("Email Subject TS"; Rec."Email Subject TS")
                {
                    ToolTip = 'Specifies the value of the Email Subject field.';
                }
            }
            group("Stock Adjustment")
            {
                Caption = 'Stock Adjustment';
                field("Stock Adjustment Template"; Rec."Stock Adjustment Template")
                {
                    ToolTip = 'Specifies the value of the Stock Adjustment Template field.';
                }
                field("Stock Adjustment Batch"; Rec."Stock Adjustment Batch")
                {
                    ToolTip = 'Specifies the value of the Stock Adjustment Batch field.';
                }
                field("Stock Adjustment Interface"; Rec."Stock Adjustment Interface")
                {
                    ToolTip = 'Specifies the value of the Stock Adjustment Interface field.';
                }
                field("Warehouse Movement Interface"; Rec."Warehouse Movement Interface")
                {
                    ToolTip = 'Specifies the value of the Warehouse Movement Interface field.';
                }
            }
            group("Purchase Order")
            {
                Caption = 'Purchase Order';
                field("Purchase Order Interface"; Rec."Purchase Order Interface")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Interface field.';
                }
                field("Warehouse Receipt Interface PO"; Rec."Warehouse RE Interface")
                {
                    Caption = 'Warehouse Receipt Interface PO';
                    ToolTip = 'Specifies the value of the Warehouse Receipt Interface PO field.';
                }
                field("Purchase Order Del Interface"; Rec."Purchase Order Del Interface")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Deletion Interface field.';
                }
                field("Email Errors PO"; Rec."Email Errors PO")
                {
                    ToolTip = 'Specifies the value of the Email Errors PO field.';
                }
                field("Email Subject PO"; Rec."Email Subject PO")
                {
                    ToolTip = 'Specifies the value of the Email Subject PO field.';
                }
            }
            group(LogoPak)
            {
                Caption = 'LogoPak';
                field("Activate LogoPak Interface"; Rec."Activate LogoPak Interface")
                {
                    ToolTip = 'Specifies the value of the Activate LogoPak Interface field.';
                }
                field("Prod. Order Interface"; Rec."Prod. Order Interface")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Interface field.';
                }
                field("Prod. Order Output Interface"; Rec."Prod. Order Output Interface")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Output Interface field.';
                }
                field("Prod. Order Output Template"; Rec."Prod. Order Output Template")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Output Template field.';
                }
                field("Prod. Order Output Batch"; Rec."Prod. Order Output Batch")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Output Batch field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("WMS Items Included/Excluded")
            {
                Image = "Filter";
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "WMS Items Included/Excluded";
                ToolTip = 'Executes the WMS Items Included/Excluded action.';
            }
            action("WMS Source System Identifier")
            {
                Caption = 'WMS Source System Identifier';
                Image = SourceDocLine;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "WMS Source System Identifier";
                ToolTip = 'Executes the WMS Source System Identifier action.';
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
}

