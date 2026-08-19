// namespace INTERFACES.INTERFACES;

// using Microsoft.Sales.History;

pageextension 58029 PostedSalesInvoiceInterfaceExt extends "Posted Sales Invoice"
/* 
HEI.03 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New field EBM Status and new actions Send to EBM, EBM Details for EBM interface
HEI.05 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
  # New Field added: "Suppress POS Interface"
 */
// BC Upgrade BHARDA11 >>
// 1.Add Interface fields in this extension and remove from MTC Extension.
// 2. Add ApplicationArea Property in the fields and Action.
// 3. Remove Drink-IT Fields related code.
// 4. Remove PAC Interface is out of scope
// BC Upgrade BHARDA11 <<
{
    layout
    {
        addlast("Invoice Details")
        {
            field("Fiscal Printer Status"; Rec."Fiscal Printer Status FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Due Date")
        {

            field("Suppress POS Interface"; Rec."Suppress POS Interface FND")
            {
                ApplicationArea = All;
            }
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = All;
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Caption = 'Created Date/Time';
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            // BC Upgrade BHARDA11 >> ---_Drink-IT Customization
            // action("Interface Export ")
            // {
            //     CaptionML = ENU = 'Interface Export ',
            //                 FRA = 'Exporter interface ';
            //     Description = 'IPLXL9.00.001';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;

            //     trigger OnAction();
            //     var
            //         lcduExportStandard: Codeunit "2030016";
            //         lrptInitOutbox: Report "2030014";
            //         lrecPartnerMessage: Record "2030012";
            //         lrecCustomer: Record "18";
            //         loptDocumentType: Option Custom,"Sales Order","Sales Return Order","Pick Confirmation","Ship Confirmation","Receipt Confirmation","Put Away Confirmation","Purchase Invoice","Sales Invoice",Payment,"Inventory Report","Purchase Cr.Memo","Pick Request","Put Away Request","Sales Credit Memo";
            //     begin
            //         //<<IPLXL9.00.001 IMI 10/06/2015
            //         //lcduExportStandard.fctExportInvoice(Rec);
            //         lrecCustomer.GET("Bill-to Customer No.");

            //         lrecPartnerMessage.SETRANGE("Message Code", 'SALESINVOICE');
            //         lrecPartnerMessage.SETRANGE("Interface Partner Code", lrecCustomer."Interface Partner");

            //         lrptInitOutbox.SETTABLEVIEW(lrecPartnerMessage);
            //         lrptInitOutbox.USEREQUESTPAGE(FALSE);
            //         lrptInitOutbox.fctSetParameters(loptDocumentType::"Sales Invoice", "No.");
            //         lrptInitOutbox.RUNMODAL;
            //         //>>IPLXL9.00.001 IMI 10/06/2015
            //     end;

            // }
            // BC Upgrade BHARDA11 >> ---_Drink-IT Customization

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
            //         EBMInterfaceManagement: Codeunit "EBM Interface Management"; // 50064
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
                    EBMSInterface.ProcessSalesInvoicePosting(Rec);//HEI.15 single
                end;
            }
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
                    //HEI.05>>
                    MarakiInterfaceManagement.ManualSalesInvoicePosting(Rec);
                    //HEI.05>>
                end;
            }
        }
        addafter(ChangePaymentService)
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
                // RunPageLink = "Document Type" = CONST(Invoice),
                //               "Document No." = FIELD("No."); // BC Upgrade BHARDA11 -Temp Blocked


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
            //     RunObject = Page "PAC Interface Document Status";
            //     RunPageView = SORTING("Document Type", "Document No.")
            //                   ORDER(Ascending);
            //     RunPageLink = "Document Type" = CONST("Sales Invoice"),
            //                   "Document No." = FIELD("No.");

            // }
            // BC Upgrade BHARDA11 << ----PAC Interface is out of scope

        }
    }
}
