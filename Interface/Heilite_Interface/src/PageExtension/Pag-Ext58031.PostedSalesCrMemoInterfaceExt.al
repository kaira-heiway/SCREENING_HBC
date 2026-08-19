// namespace INTERFACES.INTERFACES;

// using Microsoft.Sales.History;

pageextension 58031 PostedSalesCrMemoInterfaceExt extends "Posted Sales Credit Memo"
/* 
DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
IPLXL9.00.001 IMI 10/06/2015 : Added Interface export
 HEI.04 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
      # New Field added: "Suppress POS Interface"
       HEI.09 CHG2065153 IBM KUMARN15 23.06.2020
      # Added field "Source System Identifier"
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
        addafter("User ID")
        {
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Date")
        {
            field("Suppress POS Interface"; Rec."Suppress POS Interface FND")
            {
                ApplicationArea = All;
            }

        }
        addafter("EU 3-Party Trade")
        {
            field("Fiscal Printer Status"; Rec."Fiscal Printer Status FND")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Customization
            // action("Interface Export ")
            // {
            //     ApplicationArea = All;
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

            //         lrecPartnerMessage.SETRANGE("Message Code", 'SALESCREDITMEMO');
            //         lrecPartnerMessage.SETRANGE("Interface Partner Code", lrecCustomer."Interface Partner");

            //         lrptInitOutbox.SETTABLEVIEW(lrecPartnerMessage);
            //         lrptInitOutbox.USEREQUESTPAGE(FALSE);
            //         lrptInitOutbox.fctSetParameters(loptDocumentType::"Sales Credit Memo", "No.");
            //         lrptInitOutbox.RUNMODAL;
            //         //>>IPLXL9.00.001 IMI 10/06/2015
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customization
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
            //         EBMInterfaceManagement: Codeunit "EBM Interface Management"; //50064
            //     begin
            //         //HEI.03>>
            //         EBMInterfaceManagement.ManualSalesCrMemoPosting(Rec);
            //         //HEI.03>>
            //     end;
            // }
            // BC Upgrade BHARAD11 <<----EBM Interface is out of scope
            action("Send To EBMS")
            {
                ApplicationArea = All;
                Caption = 'Send to EBMS';
                Image = SendTo;

                trigger OnAction();
                var
                    EBMSInterface: Codeunit "EBMS Interface Management";
                begin
                    EBMSInterface.ManualSalesCrMemoPosting(Rec);//HEI.11//HEI.12
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
                    //HEI.04>>
                    MarakiInterfaceManagement.ManualSalesCrMemoPosting(Rec);
                    //HEI.04>>
                end;
            }
        }
        addafter(Approvals)
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
            //     RunPageLink = "Document Type" = CONST("Credit Memo"),
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
                RunPageLink = "Document Type" = CONST("Credit Memo"),
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
                RunPageLink = "Document Type" = CONST("Credit Memo"),
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
            //     RunObject = Page "PAC Interface Document Status";// 50285;
            //     RunPageLink = "Document Type"=CONST("Sales Credit Memo"),
            //                   "Document No."=FIELD("No.");
            //     RunPageView = SORTING("Document Type","Document No.")
            //                   ORDER(Ascending);
            // }
            // BC Upgrade BHARDA11 << ----PAC Interface is out of scope

        }
    }
}
