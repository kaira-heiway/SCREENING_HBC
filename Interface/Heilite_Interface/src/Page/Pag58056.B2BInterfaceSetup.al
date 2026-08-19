page 58056 "B2B Interface Setup"
{
    // Heilite Navision Old Id - 50441
    // version HEI.09

    // HEI.01 FDD-HB1234 - CHG2053453 IBM NASTAA02 15.02.2021 # B2B Order Status
    //   # New Page created for B2B Interfaces
    // HEI.02 FDD-HB1281 - CHG2056937 IBM NASTAA02 12.04.2021 # B2B Pricing Interface
    //   # New Group "Pricing Interface" created
    //   # New Field "B2B Pricing Interface Code" added
    //   # New Page Action created: "B2B Customers Included/Excluded"
    // HEI.03 INC3510045 - CHG2112803 IBM NASTAA02 02.06.2021 # HeiLite to B2B pricing the file generated is very big and can't be sent via Boomi or Solace
    //   # Deleted Field 25 - Customer Acc. Group Included
    //   # New Fields added: "Split Pricing File", and "No of Customers per File"
    // HEI.04 FDD-HB1281 - CHG2056937 IBM NASTAA02 04.10.2021 # B2B Pricing Interface
    //   # New Field added: "Skip Multi Currency Prices"
    // HEI.05 HB2427 - CHG2121928 IBM NASTAA02 20.11.2021 # B2B Invoice API
    //   # New Group created: "Invoice / Credit Memo Interface"
    //   # New Fields added: "Send all Invoices and Cr Memos", "B2B Invoice /Cr Memo Interface"
    // HEI.06 HB2024 - CHG2137488 IBM NASTAA02 06.01.2022 # B2B Credit Limit
    //   # New Group created: "Credit Limit Interface"
    //   # New Field added: "B2B Credit Limit Interface"
    // HEI.07 CHG2056939 DEBUSD01 17.10.2022 #Promotion Interface b2b
    //   # New field : 100 - B2B Promotion Interface
    // HEI.08 CHG2174122 HB3137 BHANDS01 12.01.2023 # Control for which UOM prices sent to B2B
    //   # Added New Page in Actions
    // HEI.09 CHG2174235 IBM COSTES04 20.03.2023 Interface Order Simulation
    //   # New field "Order Simulation Interface"
    //   # New action Item charges included/excluded

    Caption = 'B2B Interface Setup';
    PageType = Card;
    SourceTable = "B2B Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Enable B2B Interfaces"; Rec."Enable B2B Interfaces")
                {
                    ToolTip = 'Specifies the value of the Enable B2B Interfaces field.';
                }
                field("Pick-up Shipment Method"; Rec."Pick-up Shipment Method")
                {
                    ToolTip = 'Specifies the value of the Pick-up Shipment Method field.';
                }
            }
            group("Pricing Interface")
            {
                field("B2B Pricing Interface Code"; Rec."B2B Pricing Interface Code")
                {
                    ToolTip = 'Specifies the value of the B2B Pricing Interface Code field.';
                }
                field("Run Sales Gross Net Price Rep"; Rec."Run Sales Gross Net Price Rep")
                {
                    ToolTip = 'Specifies the value of the Run Sales Gross Net Price Report only for Selected Customers field.';
                }
                field("Split Pricing File"; Rec."Split Pricing File")
                {
                    ToolTip = 'Specifies the value of the Split Pricing File field.';

                    trigger OnValidate();
                    begin
                        //HEI.03>>
                        if not Rec."Split Pricing File" then
                            Rec."No of Customers per File" := 0;
                        //HEI.03<<
                    end;
                }
                field("No of Customers per File"; Rec."No of Customers per File")
                {
                    Editable = Rec."Split Pricing File";
                    ToolTip = 'Specifies the value of the No of Customers Sent per File field.';
                }
                field("Skip Multi Currency Prices"; Rec."Skip Multi Currency Prices")
                {
                    ToolTip = 'Specifies the value of the Skip Multi Currency Prices field.';
                }
            }
            group("Invoice / Credit Memo Interface")
            {
                field("Send all Invoices and Cr Memos"; Rec."Send all Invoices and Cr Memos")
                {
                    ToolTip = 'Specifies the value of the Send all Invoices and Credit Memos field.';
                }
                field("B2B Invoice /Cr Memo Interface"; Rec."B2B Invoice /Cr Memo Interface")
                {
                    ToolTip = 'Specifies the value of the B2B Invoice /Credit Memo Interface field.';
                }
            }
            group("Credit Limit Interface")
            {
                field("B2B Credit Limit Interface"; Rec."B2B Credit Limit Interface")
                {
                    ToolTip = 'Specifies the value of the B2B Credit Limit Interface field.';
                }
            }
            group("Promotion Interface")
            {
                field("B2B Promotion Interface"; Rec."B2B Promotion Interface")
                {
                    ToolTip = 'Specifies the value of the B2B Promotion Interface field.';
                }
            }
            group("Order Simulation")
            {
                field("Order Simulation Interface"; Rec."Order Simulation Interface")
                {
                    ToolTip = 'Specifies the value of the Order Simulation Interface field.';
                }
                field("Default Souce System Ident."; Rec."Default Souce System Ident.")
                {
                    ToolTip = 'Specifies the value of the Default Source System Identifier field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            // Caption = 'Options';  // BC Upgrade NANDIS03
            action("Customers Included/Excluded")
            {
                Caption = 'Customers Included/Excluded';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "B2B Customer Included/Excluded";
                ToolTip = 'Executes the Customers Included/Excluded action.';
            }
            action("B2B Item Units of Measure")
            {
                Caption = 'B2B Item Units of Measure';
                Image = UnitOfMeasure;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "B2B Item Units of Measure";
                ToolTip = 'Executes the B2B Item Units of Measure action.';
            }
            action("Item Charges Included/Excluded")
            {
                Caption = 'Item Charges Included/Excluded';
                Image = ItemCosts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "B2B Item Charges Inc./Exc.";
                ToolTip = 'Executes the Item Charges Included/Excluded action.';
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

