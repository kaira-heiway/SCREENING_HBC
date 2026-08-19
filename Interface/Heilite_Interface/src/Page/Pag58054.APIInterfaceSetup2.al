page 58054 "API Interface Setup2"
{
    // Heilite Navision Old Id - 50422

    // version HEI.02,HEI.03,HEI.08

    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # New page created
    // HEI.02 FDD-HB1268 - CHG2068666 IBM NASTAA02 07.12.2020 # DMS Integration Ivory Coast
    //   # New Fields added: "API Payment Interface", "Cash Journal Template" and "Cash Journal Batch"
    //   # New tab created: "Payment"
    // HEI.03 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Deleted Fields: "Order Value Validation" and "Order Val. Tolerance Amt"
    //   # New Page Action created: "Cash Receipt Balance GL Accounts"
    // HEI.04 FDD-HB1234 - CHG2053453 IBM NASTAA02 08.03.2021 # B2B Order Status
    //   # New Group created: "Order Status"
    //   # New Fields added: "API Order Status" and "API Order Status Not Interface"
    //   # New Page Action created: "APIOrderStatusMapping"
    // HEI.05 FDD-HB899 - CHG2093869 IBM NASTAA02 16.03.2021 # LSR - Transfer and Stock
    //   # New Group created: "Stock Image"
    //   # New Field added: "API Stock Image Interface"
    // HEI.06 CHG2160095 IBM GHOSHS05 21.07.22 -BASE-DDE driver payment integration
    //   # New Action DMS Cash Receipt Balance GL Acc. Added
    // HEI.07 CHG2188870 DEBUSD01 03.02.2023 Sales Order API Performance change flow
    //   # Add field "SRO AttemptDelay Process (sec)"
    //   # Add field "Run BatchReProcess No.of Entry"
    // HEI.08 CHG2188870 DEBUSD01 08.02.2023 Sales Order API Performance change flow
    //   # Add field "API Job Queue Category Code"

    Caption = 'API Interface Setup';
    PageType = Card;
    SourceTable = "API Interface Setup2 INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Sales Order and Sales Return Order';
                field("SO/SRO Interface Request"; Rec."SO/SRO Interface Request")
                {
                    ToolTip = 'Specifies the value of the SO/SRO Interface Request field.';
                }
                field(Rec; Rec."Gift Reason Code")
                {

                }
                field("Default Document Subtype Code"; Rec."Default Document Subtype Code")
                {
                    ToolTip = 'Specifies the value of the Default Document Subtype Code field.';
                }
                field("Automatic Release/SendApproval"; Rec."Automatic Release/SendApproval")
                {
                    ToolTip = 'Specifies the value of the Automatic Release/SendApproval field.';
                }
                field("Reprocess Count"; Rec."Reprocess Count")
                {
                    ToolTip = 'Specifies the value of the Re-process Count (Max. Attempts) field.';
                }
                field("SRO AttemptDelay Process (sec)"; Rec."SRO AttemptDelay Process (sec)")
                {
                    ToolTip = 'Time in seconds (-1 skip the process)';
                }
                field("Run BatchReProcess No.of Entry"; Rec."Run BatchReProcess No.of Entry")
                {
                    ToolTip = 'Specifies the value of the Batch Re-process Run No. of Records field.';
                }
                field("API Job Queue Category Code"; Rec."API Job Queue Category Code")
                {
                    ToolTip = 'Specifies the value of the API Job Queue Category Code field.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("API Payment Interface"; Rec."API Payment Interface")
                {
                    ToolTip = 'Specifies the value of the API Payment Interface field.';
                }
                field("Cash Journal Template"; Rec."Cash Journal Template")
                {
                    ToolTip = 'Specifies the value of the Cash Journal Template field.';
                }
                field("Cash Journal Batch"; Rec."Cash Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Cash Journal Batch field.';
                }
            }
            group("Order Status")
            {
                Caption = 'Order Status';
                field("API Order Status Interface"; Rec."API Order Status Interface")
                {
                    ToolTip = 'Specifies the value of the API Order Status Interface field.';
                }
                field("API Order Status Not Interface"; Rec."API Order Status Not Interface")
                {
                    ToolTip = 'Specifies the value of the API Order Status Notification Interface field.';
                }
            }
            group("Stock Image")
            {
                Caption = 'Stock Image';
                field("API Stock Image Interface"; Rec."API Stock Image Interface")
                {
                    ToolTip = 'Specifies the value of the API Stock Image Interface field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            //Caption = 'Options';  // BC Upgrade NANDIS03
            action("Cash Receipt Balance GL Accounts")
            {
                Caption = 'Cash Receipt Balance G/L Accounts';
                Image = CashReceiptJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Cash Rcpt Bal G/L Account";
                ToolTip = 'Executes the Cash Receipt Balance G/L Accounts action.';
            }
            action(APIOrderStatusMapping)
            {
                Caption = 'API Order Status Mapping';
                Description = 'HEI.04';
                Image = MapSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "API Order Status Mapping";
                ToolTip = 'Executes the API Order Status Mapping action.';
            }
            action("DMS Cash Receipt Balance GL Acc.")
            {
                Caption = 'DMS Cash Receipt Balance GL Acc.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DMS Cash Rcpt Bal G/L Account";
                ToolTip = 'Executes the DMS Cash Receipt Balance GL Acc. action.';
            }
        }
    }

    trigger OnOpenPage();
    begin
        rec.RESET();
        if not rec.GET() then begin
            rec.INIT();
            rec.INSERT();
        end;
    end;
}

