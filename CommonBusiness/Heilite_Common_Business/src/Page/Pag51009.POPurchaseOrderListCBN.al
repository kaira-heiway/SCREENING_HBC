page 51009 "PO Purchase Order List CBN"
{
    // version NAVW110.0.00.15052,FINXL10.00,DITW110.00.09,HEI.14

    // FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"
    // 
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Upgrade
    //                                              Convert Control55 Print -> Menu
    //                                              Added 'Shipping Agent Notice' menu into 'Print' button
    //                     20/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                     17/02/2012 DIT-715 #244 Added/Moved columns
    // 
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0012.2
    //                             Added field "Requester ID"
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Responsibility Center","Physical Location Group Code"
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Vendor"
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Add Action to Shipping Cost Page + Removed old Shipping Costs fields
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // 
    // HEI.01 PTPGAP064 IBM HORTOC01 12.07.2017
    //   # New page based on standard page 9307
    // HEI.02 RFC-CHG0249183 IBM.LS 30.11.2018
    //   # Added code to call "SendEmailPurchaseOrder" function. Code commented here and added in Codeunit-415.
    //   # Added fields - "BRC Purchase Order" and "SRM Order No.".
    // HEI.03 CHG0255725 IBM GAVANM01 18.04.2019
    //   # Added field 'Payment User'
    // HEI.04 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Removed Field "Payment User"
    //   # Created new Page Action "Purchase Additional"
    // HEI.05 FDD-CHG2013470 IBM PATHAA02 17.06.2019
    //   # Added new Field 'Your Reference'
    // HEI.06 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // HEI.07 FDD-HT657 IBM NASTAA02 27.02.2020 # Ethiopia Intercompany Automation
    //   # New Field added: "IC Document"
    //   # Code added on OnAfterGetRecord trigger
    // HEI.08 CHG2081091 IBM SHANKJ03  01.10.2020
    //   # new field added Mail sent & Mail sent date time
    // HEI.09 CHG2083064 IBM.GUNERE01  21.10.2020 # Mail Sent, Mail sent date time fields set to editable false
    // HEI.10 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added in General tab: LSR Order No
    // HEI.11 FDD-HB2482 CHG2123206 IBM NANDIS01 03.11.2021 - Improvement of multiple HeiLite reports for StP  Procurement users
    //   # Added "Created By" field in the page
    //   # Added Limit PO in the page
    // HEI.12 CHG2121745 IBM BHATTA09 25.11.2021 - SRM - SC fields to be added in HL
    //   # Added "Shopping card No." field in the page
    //   # Added "Shopping Card Creation Date" in the page
    // HEI.13 CHG2251877 MAJUMS03 05.07.2024 Warehouse Receipt Lines creation issue
    //   # Code added under OnValidate() Trigger of "Delivery Finalized" field to proper update of "Warehouse Rcpt/Shpt No." of Warehouse Request to fix
    //   the bug related to "Delivery Finalized" field in Purchase Line table and "Warehouse Rcpt/Shpt No." of Warehouse Request table. Code written on
    //   Page level to update "Warehouse Rcpt/Shpt No." of Warehouse Request table before triggering the function under Codeunit and to avoid COMMIT.
    //   # TableData Warehouse Request=rm Permission added.
    // HEI.14 CHG2251877 MAJUMS03 11.07.2024 Warehouse Receipt Lines creation issue
    //   # Code modified.
    //   # TableData Warehouse Request=rm Permission is modified as Warehouse Request=rimd.
    // BC Upgrade SHUKLP03 >> Added field "LSR Order No." in the interface ext.

    // BC Upgrade MISHRS14 >>
    // Blocked OpenPurchaseOrderStatistics on OnActiontrigger of Statistics action due to warning
    // BC Upgrade MISHRS14 << 

    Caption = 'PO Purchase Orders';
    CardPageID = "PO Purchase Order CBN";
    DataCaptionFields = "Document Type", "Buy-from Vendor No.";
    Editable = false;
    PageType = List;
    Permissions = TableData "Warehouse Request" = rimd;
    PromotedActionCategories = 'New,Process,Report,Request Approval,Print';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = CONST(Order));
    ApplicationArea = All;
    UsageCategory = Lists; //BC UPGRADE ATHUKUS01 FDDSTP_007 

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the purchase document.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor you buy from.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the vendor who delivers the items.';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ToolTip = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).';
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
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the vendor who is sending the invoice.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor sending the invoice.';
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
                    ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the company at the address to which you want the items to be shipped.';
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
                    ToolTip = 'Specifies the name of a contact person for the address where the items should be shipped.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Visible = false;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
                }
                /* //BC Upgrade Manisha Drink it field commented>>

                field("Physical Location Group Code"; "Physical Location Group Code")
                {
                    Visible = false;
                }
                */ //BC Upgrade Manisha Drink it field commented<<

                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = false;
                }
                /* //BC Upgrade Manisha Drink it Field commented>>
                field("Requester ID";Rec."Requester ID")
                {
                    Description = 'DITW17.00.02 DIT-770 #144';
                    Visible = false;
                }
                */ //BC Upgrade Manisha Drink it Field commented<<

                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code of the currency of the amounts on the purchase lines.';
                    Visible = false;
                }
                /* //BC Upgrade Manisha Drink it code commented>>

                field("Disc.Promo. Order Calculated"; "Disc.Promo. Order Calculated")
                {
                    Visible = false;
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date of the vendor''s invoice.';
                }
                field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
                {
                    ApplicationArea = ALL;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                    ToolTip = 'Specifies the campaign number the document is linked to.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                    ToolTip = 'You can use this field when you post the purchase header, to have the program apply it to a document that has already been posted. In this case, enter here the type of document that you want it to be applied to.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                    ToolTip = 'Specifies the date you expect to receive the items on the purchase document.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies when the purchase invoice is due for payment.';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies how payment for the purchase document must be submitted.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the code that represents the shipment method for this purchase.';
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.';
                    Visible = false;
                }
                /* //BC Upgrade Manisha Drink it field commented>>

                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    Visible = false;
                }
                field(Distance; Distance)
                {
                    Visible = false;
                }
                field("Truck Code"; "Truck Code")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Driver Code"; "Driver Code")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Shipping Charge Per"; "Shipping Charge Per")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Maximum Weight"; "Maximum Weight")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Maximum Cubage"; "Maximum Cubage")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Total Weight"; "Total Weight")
                {
                    Visible = false;
                }
                field("Total Cubage"; "Total Cubage")
                {
                    Visible = false;
                }
                field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
                {
                    BlankZero = true;
                    CaptionClass = GetCaptionClassUom(1);
                    DecimalPlaces = 0 : 5;
                    Description = 'DIT-715 #244';
                    Editable = false;
                    Visible = false;
                }
                field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
                {
                    BlankZero = true;
                    CaptionClass = GetCaptionClassUom(2);
                    DecimalPlaces = 0 : 5;
                    Description = 'DIT-715 #244';
                    Editable = false;
                    Visible = false;
                }
                field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
                {
                    BlankZero = true;
                    CaptionClass = GetCaptionClassUom(3);
                    DecimalPlaces = 0 : 5;
                    Description = 'DIT-715 #244';
                    Editable = false;
                    Visible = false;
                }
                field("Link Purch. Document Type"; "Link Purch. Document Type")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Link Purch. Document No."; "Link Purch. Document No.")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Fiscal Representative No."; "Fiscal Representative No.")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Vendor Tax Registration No."; "Vendor Tax Registration No.")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                field("Vendor Tax Warehouse Ref."; "Vendor Tax Warehouse Ref.")
                {
                    Description = 'DIT-715 #244';
                    Visible = false;
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                    Visible = JobQueueActive;
                }
                /* //BC Upgrade Manisha Drink it code commented>>

                field("Sundry Vendor"; Rec."Sundry Vendor")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Last changed User ID"; Rec."Last changed User ID")
                {
                    Editable = false;
                }
                field("Last changed Date/time"; "Last changed Date/time")
                {
                    Editable = false;
                }
                */ //BC Upgrade Manisha Drink it code commented<<

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Total Excl. VAT',
                                FRA = 'Montant';
                    ToolTip = 'Specifies the sum of the amounts in the Amount field on the associated purchase lines.';
                }
                field("""Amount Including VAT""-Amount"; Rec."Amount Including VAT" - Rec.Amount)
                {
                    Caption = 'Total VAT';
                    ToolTip = 'Specifies the value of the Total VAT field.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Total Incl. VAT',
                                FRA = 'Montant TTC';
                    ToolTip = 'Specifies the sum of amounts, including VAT, on all the lines in the document. This will include invoice discounts.';
                }
                field("BRC Purchase Order"; Rec."BRC Purchase Order FND")
                {
                    ToolTip = 'Specifies the value of the BRC Purchase Order field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the vendor''s reference.';
                }
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
                }
                /* //BC Upgrade Manisha Drink it code commented>>

                field("Created By"; rec."Created By")
                {
                }               

                field("IC Document"; PurchaseHeaderAdditional."IC Document")
                {
                    Description = 'HEI.07';
                    Editable = false;
                }
                */ //BC Upgrade Manisha Drink it code commented<<
                field("Mail Sent"; PurchaseHeaderAdditional."Mail Sent")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Mail Sent field.';
                }
                field("Mail Sent Date Time"; PurchaseHeaderAdditional."Mail Sent Date Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Mail Sent Date Time field.';
                }
                // BC Upgrade SHUKLP03 >> Added in interface ext.
                // field("LSR Order No."; PurchaseHeaderAdditional."LSR Order No")
                // {
                // }
                // BC Upgrade SHUKLP03 << Added in interface ext.
                field("PurchaseHeaderAdditional.""Limit PO"""; PurchaseHeaderAdditional."Limit PO")
                {
                    Caption = 'Limit PO';
                    ToolTip = 'Specifies the value of the Limit PO field.';
                }
                field("Shopping Card No."; Rec."Shopping Card No. FND")
                {
                    ToolTip = 'Specifies the value of the Shopping Card No. field.';
                }
                field("PurchaseHeaderAdditional.""Shopping Card Creation Date"""; PurchaseHeaderAdditional."Shopping Card Creation Date")
                {
                    Caption = 'Shopping Card Creation Date';
                    ToolTip = 'Specifies the value of the Shopping Card Creation Date field.';
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
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
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    // BC Upgrade MISHRS14 >>
                    // Blocked OpenPurchaseOrderStatistics due to warning
                    trigger OnAction();
                    begin
                        //Rec.OpenPurchaseOrderStatistics();
                    end;

                    // BC Upgrade MISHRS14 <<
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");//BC Upgrade Manisha COmmented as function name change in BC
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'Executes the Co&mments action.';
                }
                /* //BC Upgrade Manisha Drink it Page Document Shipping Cost code commented>>

                action("Shipping Costs")
                {
                    Caption = 'Shipping Costs';
                    Image = Costs;
                    RunObject = Page "Document Shipping Cost";
                    RunPageLink = "Source Type" = CONST(38),
                                  "Source No." = FIELD("No."),
                                  "Sub Type" = FIELD("Document Type");
                }
                */ //BC Upgrade Manisha Drink it Page code commented<<

                action("Purchase Additional")
                {
                    Caption = 'Purchase Additional';
                    Image = Purchase;
                    RunObject = Page "Purchase Additional";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Purchase Additional action.';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = Suite;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = sorting("Order No.");
                    ToolTip = 'Executes the Receipts action.';
                }
                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = sorting("Order No.");
                    ToolTip = 'Executes the Invoices action.';
                }
                action(PostedPurchasePrepmtInvoices)
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'Executes the Prepa&yment Invoices action.';
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = sorting("Prepayment Order No.");
                    ToolTip = 'Executes the Prepayment Credi&t Memos action.';
                }
                separator(Separator1102601037)
                {
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = sorting("Source Document", "Source No.", "Location Code");
                    ToolTip = 'Executes the In&vt. Put-away/Pick Lines action.';
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),  // BC Upgrade MISHRS14 >> As Source Subtype is option and Document type is as told by Saikat leave the warning
                                  "Source No." = FIELD("No.");
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'Executes the Whse. Receipt Lines action.';
                }
                separator(Separator1102601040)
                {
                }
            }
        }
        area(processing)
        {
            group(ActionGroup9)
            {
                Caption = 'Print';
                Image = Print;
                action(Print)
                {
                    ApplicationArea = Suite;
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                        PurchaseHeader.PrintRecords(true);
                    end;
                }
                action(Send)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send';
                    Ellipsis = true;
                    Image = SendToMultiple;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                        PurchaseHeader.SendRecords();
                    end;
                }
            }
            group(ActionGroup10)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Re&lease action.';

                    trigger OnAction();
                    var
                        PurchasesPayablesSetupL: Record "Purchases & Payables Setup";
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ShortCutKey = 'Ctrl+F10';
                    ToolTip = 'Executes the Re&open action.';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Separator1102601023)
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Send IC Purchase Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Purchase Order';
                    Image = IntercompanyOrder;
                    ToolTip = 'Executes the Send IC Purchase Order action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                            ICInOutboxMgt.SendPurchDoc(Rec, false);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group(ActionGroup12)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;
                    ToolTip = 'Executes the Create &Whse. Receipt action.';

                    trigger OnAction();
                    var
                        WHRcptHdr: Record "Warehouse Receipt Header";
                        WHRequest: Record "Warehouse Request";
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        /* //BC Upgrade Manisha Drink it code commented>>
                        //HEI.13>>
                        if WHRequest.GET(WHRequest.Type::Inbound, Rec."Location Code", DATABASE::"Purchase Line", WHRequest."Source Subtype"::"1", Rec."No.") then begin
                            if WHRequest."Warehouse Rcpt/Shpt No." <> '' then begin
                                //IF WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") THEN BEGIN //HEI.14
                                if not WHRcptHdr.GET(WHRequest."Warehouse Rcpt/Shpt No.") then begin //HEI.14
                                    WHRequest."Warehouse Rcpt/Shpt No." := '';
                                    WHRequest.MODIFY;
                                end;
                            end;
                        end;
                        //HEI.13<<
                        */ //BC Upgrade Manisha Drink it code commented<<

                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;
                    ToolTip = 'Executes the Create Inventor&y Put-away/Pick action.';

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
                separator(Separator1102601017)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(TestReport)
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'Executes the Test Report action.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the P&ost action.';

                    trigger OnAction();
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction();
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = Suite;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Executes the Post and &Print action.';

                    trigger OnAction();
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Post &Batch action.';

                    trigger OnAction();
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = Suite;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueActive;
                    ToolTip = 'Executes the Remove From Job Queue action.';

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("&Order")
                {
                    Caption = '&Order';
                    Enabled = false;
                    Image = Print;
                    ToolTip = 'Executes the &Order action.';

                    trigger OnAction();
                    var
                        DocPrint: Codeunit "Document-Print";
                    begin
                        //? DITW110.00.08 DDR 02/01/2017 NRQ#0 TO BE REPLACED (don't use codeunit229 Document-Print)

                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        DocPrint.PrintPurchHeader(Rec);
                        // >>DITW16.00.00.40 DDR DIT-715 #197
                    end;
                }
                action("&Shipping Agent Notice")
                {
                    Caption = '&Shipping Agent Notice';
                    Image = Print;
                    ToolTip = 'Executes the &Shipping Agent Notice action.';

                    trigger OnAction();
                    var
                        DocPrint: Codeunit "Document-Print";
                    begin
                        //? DITW110.00.08 DDR 02/01/2017 NRQ#0 TO BE REPLACED (don't use codeunit229 Document-Print)

                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        //DocPrint.PrintPurchHeaderAgentNotice(Rec);//BC Upgrade Manisha Drink it code Commented
                        // >>DITW16.00.00.40 DDR DIT-715 #197
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnAfterGetRecord();
    begin
        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        // ShowShortcutUomValue(ShortcutQtyUomValue);//BC Upgrade Manisha Drink it code Commented
        // >>DITW16.00.00.40 DDR DIT-715 #244

        if PurchaseHeaderAdditional.GET(Rec."Document Type", Rec."No.") then; //HEI.07
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        exit(Rec.FIND(Which) and ShowHeader());
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    var
        NewStepCount: Integer;
    begin
        repeat
            NewStepCount := Rec.NEXT(Steps);
        until (NewStepCount = 0) or ShowHeader();

        exit(NewStepCount);
    end;

    trigger OnOpenPage();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive();

        Rec.CopyBuyFromVendorFilter();

        //HEI.01>>
        PurchasesPayablesSetup.GET;
        PurchasesPayablesSetup.TESTFIELD("PO Subtype Code FND");
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Document Subtype Code FND", PurchasesPayablesSetup."PO Subtype Code FND");//BC UPGRADE VAMSIU01 - Added.
        Rec.FILTERGROUP(0);
        //HEI.01<<

    end;

    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        ReportPrint: Codeunit "Test Report-Print";
        CanCancelApprovalForRecord: Boolean;

        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        SkipLinesWithoutVAT: Boolean;
        ShortcutQtyUomValue: array[3] of Decimal;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    procedure SkipShowingLinesWithoutVAT();
    begin
        SkipLinesWithoutVAT := true;
    end;

    local procedure ShowHeader(): Boolean;
    var
        CashFlowManagement: Codeunit "Cash Flow Management";
    begin
        if not SkipLinesWithoutVAT then
            exit(true);

        exit(CashFlowManagement.GetTaxAmountFromPurchaseOrder(Rec) <> 0);
    end;
}

