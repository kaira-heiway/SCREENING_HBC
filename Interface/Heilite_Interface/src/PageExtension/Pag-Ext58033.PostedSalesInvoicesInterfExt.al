// namespace INTERFACES.INTERFACES;

// using Microsoft.Sales.History;
// BC Upgrade BHARDA11 >>
// 1. Add ApplicationArea Property in fields.
// 2. Remove PAC Interface is out of scope
// BC Upgrade BHARDA11 <<

pageextension 58033 PostedSalesInvoicesInterfExt extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Invoice Receipt No.")
        {
            field("Fiscal Printer Status"; Rec."Fiscal Printer Status FND")
            {
                ApplicationArea = All;
            }
            field("Suppress POS Interface"; Rec."Suppress POS Interface FND")
            {
                ApplicationArea = All;
            }
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(IncomingDoc)
        {
            // BC Upgrade BHARAD11 >>----EBM Interface is out of scope
            // action("EBM Details")
            // {
            //     ApplicationArea = All;
            //     Caption = 'EBM Details';
            //     Image = ItemInvoice;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "EBM Invoice Details";
            //     RunPageLink = "Document Type" = CONST(Invoice),
            //                   "Document No." = FIELD("No.");
            // }
            // BC Upgrade BHARAD11 <<----EBM Interface is out of scope
            action("EBMS Details")
            {
                ApplicationArea = All;
                Caption = 'EBMS Details';
                Image = GiroPlus;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "EBMS Document Status";
                RunPageLink = "Document Type" = CONST(Invoice),
                              "Document No." = FIELD("No.");
                RunPageView = SORTING("Document Type", "Document No.")
                              ORDER(Ascending);
            }
            action("Maraki Details")
            {
                ApplicationArea = All;
                Caption = 'Maraki Details';
                Image = ItemInvoice;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Maraki Details";
                RunPageLink = "Document Type" = CONST(Invoice),
                              "Document No." = FIELD("No.");
            }
            // BC Upgrade BHARDA11 >> ----PAC Interface is out of scope
            // action("PAC Details")
            // {
            //     ApplicationArea = All;
            //     Caption = 'PAC Details';
            //     Image = GiroPlus;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;
            //     RunObject = Page 50285;
            //     RunPageLink = "Document Type" = CONST("Sales Invoice"),
            //                   "Document No." = FIELD("No.");
            //     RunPageView = SORTING("Document Type", "Document No.")
            //                   ORDER(Ascending);
            // }
            // BC Upgrade BHARDA11 << ----PAC Interface is out of scope
        }
        addafter(ActivityLog)
        {
            // BC Upgrade BHARAD11 >>----EBM Interface is out of scope
            // action(SendToEBM)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Send to EBM';
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction();
            //     var
            //         EBMInterfaceManagement: Codeunit "EBM Interface Management";
            //     begin
            //         //HEI.03>>
            //         EBMInterfaceManagement.ManualSalesInvoicePosting(Rec);
            //         //HEI.03>>
            //     end;
            // }
            // BC Upgrade BHARAD11 <<----EBM Interface is out of scope
            action("Send To EBMS")
            {
                ApplicationArea = All;
                Caption = 'Send to EBMS';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    EBMSInterface: Codeunit "EBMS Interface Management";
                begin
                    EBMSInterface.ProcessSalesInvoicePosting(Rec);//HEI.12 single
                end;
            }
            // BC Upgrade BHARDA11 >> ----PAC Interface is out of scope
            // action("Send To PAC")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Send to PAC';
            //     Image = SendTo;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction();
            //     var
            //         PACElectronicInvoiceMgt: Codeunit "PAC Electronic Invoice Mgt.";
            //     begin
            //         PACElectronicInvoiceMgt.ManualSalesInvoicePosting(Rec);//HEI.14
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----PAC Interface is out of scope
            action(SendToMaraki)
            {
                ApplicationArea = All;
                Caption = 'Send to Maraki';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    MarakiInterfaceManagement: Codeunit "Maraki Interface Management";
                begin
                    //HEI.06>>
                    MarakiInterfaceManagement.ManualSalesInvoicePosting(Rec);
                    //HEI.06>>
                end;
            }
        }
    }
}
