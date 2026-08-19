page 51026 "Rejected NPO Invoices CBN"
{
    // version HEI.01

    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" (Visible FALSE)
    // DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // 
    // 
    // HEI.01 FDD-PTPGAP013 01.08.2017 IBM.PATHAA02
    // #Created new page for Payment Status Rejected filter and Doc subtype code-NPO

    //BC UPGRADE SHIKHD02>>
    //1. Added Usage Category = Lists 
    //2. In actions -> area(Processing) removed warning, blocked group(Navigation) and added group(NavigationG) to avoid reserved area name conflict
    //BC UPGRADE SHIKHD02<<

    Caption = 'Rejected NPO Invoices';
    CardPageID = "Posted Purchase Invoice";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Correct,Navigation';
    RefreshOnActivate = true;
    SourceTable = "Purch. Inv. Header";
    ApplicationArea = All;
    UsageCategory = Lists; //BC UPGRADE SHIKHD02<<

    //BC UPGARDE VAMSIU01 >>
    SourceTableView = sorting("Posting Date")
                      ORDER(Descending)
                      where("Payment Status FND" = FILTER("Payment Rejected"),
                            "Document Subtype Code FND" = CONST('NPO'));
    //BC UPGARDE VAMSIU01 <<


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posted invoice number.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ToolTip = 'Specifies the number of the vendor that you bought the items from.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the order address code used in the invoice.';
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    ToolTip = 'Specifies the name of the vendor who shipped the items.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code used to calculate the amounts on the invoice.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total, in the currency of the invoice, of the amounts on all the invoice lines.';

                    trigger OnDrillDown();
                    begin
                        Rec.SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice", Rec)
                    end;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total, in the currency of the invoice, of the amounts on all the invoice lines - including VAT.';

                    trigger OnDrillDown();
                    begin
                        Rec.SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Purchase Invoice", Rec)
                    end;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact at the vendor who shipped the items.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor who you received the invoice from.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor who you received the invoice from.';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you should contact at the vendor who you received the invoice from.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the shipment of the sales order that is linked to the purchase order for drop shipment from the vendor to a customer.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the company at the address to which the items were shipped.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of a contact person at the address that the items were shipped to.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date the purchase header was posted.';
                    Visible = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies which purchaser is associated with the invoice.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for the dimension value associated with the invoice.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for the dimension value associated with the invoice.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code for the location where the items are registered.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the invoice has been printed.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the purchase document was created.';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the code to use to find the payment terms that apply to the purchase header.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields on the purchase header.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the method of payment for payments to vendors.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the code that represents the shipment method for this invoice.';
                    Visible = false;
                }
                // BC Upgrade VAMSIU01 >>
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                // BC Upgrade VAMSIU01 >>

                field("Payment Status"; Rec."Payment Status FND")
                {
                    OptionCaption = 'Pending Review,Payment Approved,Payment Rejected';
                    ToolTip = 'Specifies the value of the Payment Status field.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the amount that remains to be paid for the posted purchase invoice.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the posted purchase invoice is paid. The check box will also be selected if a credit memo for the remaining amount has been applied.';
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = NOT Rec.Cancelled;
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = Rec.Cancelled;
                    ToolTip = 'Specifies if the posted purchase invoice has been either corrected or canceled.';

                    trigger OnDrillDown();
                    begin
                        Rec.ShowCorrectiveCreditMemo();
                    end;
                }
                field(Corrective; Rec.Corrective)
                {
                    ApplicationArea = Basic, Suite;
                    HideValue = NOT Rec.Corrective;
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = Rec.Corrective;
                    ToolTip = 'Specifies if the posted purchase invoice is a corrective document.';

                    trigger OnDrillDown();
                    begin
                        Rec.ShowCancelledCreditMemo();
                    end;
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = NOT IsOfficeAddin;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Invoice Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Invoice"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action(IncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    Caption = 'Incoming Document';
                    Image = Document;
                    ToolTip = 'Executes the Incoming Document action.';

                    trigger OnAction();
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
                    end;
                }
            }
        }
        area(processing)
        {
            //BC UPGRADE SHIKHD02>>
            //blocked group(Navigation) and added group(NavigationG) as "Navigation" is a reserved area name in BC 
            //group(Navigation)
            group(NavigationG)
            //BC UPGRADE SHIKHD02<<
            {
                Caption = 'Navigation';
                Image = Invoice;
                action(Vendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the selected posted purchase document.';
                }
                action(ShowCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Canceled/Corrective Credit Memo';
                    Enabled = Rec.Cancelled OR Rec.Corrective;
                    Image = CreditMemo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ToolTip = 'Open the posted purchase credit memo that was created when you canceled the posted purchase invoice. If the posted purchase invoice is the result of a canceled purchase credit memo, then canceled purchase credit memo will open.';

                    trigger OnAction();
                    begin
                        Rec.ShowCanceledOrCorrCrMemo();
                    end;
                }
                action(Navigate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Navigate';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Scope = Repeater;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected posted purchase document.';
                    Visible = NOT IsOfficeAddin;

                    trigger OnAction();
                    begin
                        Rec.Navigate();
                    end;
                }
            }
            group(Correct)
            {
                Caption = 'Correct';
                action(CorrectInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Correct';
                    Image = Undo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ToolTip = 'Reverse this posted invoice and automatically create a new invoice with the same information that you can correct before posting. This posted invoice will automatically be canceled.';

                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Correct PstdPurchInv (Yes/No)", Rec);
                    end;
                }
                action(CancelInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ToolTip = 'Create and post a purchase credit memo that reverses this posted purchase invoice. This posted purchase invoice will be canceled.';

                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Cancel PstdPurchInv (Yes/No)", Rec);
                    end;
                }
                action(CreateCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Corrective Credit Memo';
                    Image = CreateCreditMemo;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Scope = Repeater;
                    ToolTip = 'Create a credit memo for this posted invoice that you complete and post manually to reverse the posted invoice.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                        CorrectPostedPurchInvoice: Codeunit "Correct Posted Purch. Invoice";
                    begin
                        CorrectPostedPurchInvoice.CreateCreditMemoCopyDocument(Rec, PurchaseHeader);
                        PAGE.RUN(PAGE::"Purchase Credit Memo", PurchaseHeader);
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                Visible = NOT IsOfficeAddin;

                trigger OnAction();
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
                    PurchInvHeader := Rec;
                    //>> DITW18.00.07 AKH DIT-770 #1508
                    CurrPage.SETSELECTIONFILTER(PurchInvHeader);
                    PurchInvHeader.PrintRecords(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage();
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        Rec.SetSecurityFilterOnRespCenter();
        if Rec.FINDFIRST() then;
        IsOfficeAddin := OfficeMgt.IsAvailable();
    end;

    var
        IsOfficeAddin: Boolean;
}

