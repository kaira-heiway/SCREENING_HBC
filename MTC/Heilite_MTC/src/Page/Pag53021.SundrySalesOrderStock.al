page 53021 "Sundry Sales Order Stock"
{
    // version HEI.02
    //BC UPGRADE SIVA Old Page ID 50152
    // FINXL8.00.001 BSA 10/06/2015 #85 : Added Field "Last changed User ID", "Last changed Date/time"
    // 
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Upgrade
    //                                              Added menu into 'Print' button
    //                                                'Order Confirmation (Packing)'
    //                                                'Test AAD Document'
    //                                                'Packing List'
    //                     20/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    //                     20/02/2012 DIT-715 #244 Added/Moved columns
    // DITW16.00.00.43 DDR 13/05/2013 DIT-715 #606 Added fields  "Document Status"
    // 
    // DITW17.00.02 DDR 13/05/2013 DIT-715 #606
    // 
    // DITW17.00.02 AT  03/10/2013 DIT-770 #183
    //                  Added fields Invoice Method & Invoice Period
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields "Responsibility Center","Physical Location Group Code"
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.05 MSF 08/08/14 DIT-770 #795 : Min. HL Volume and Min. UOM warning in order intake - PART3
    //                                          Added  Field "Total Eq. UOM Quantity"
    // DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added Field 2014100 "Trailer Code"
    // DITW18.00.07 AKH 07/01/2016 DIT-770 #1806 Added fields: "Sell-to Customer Name 2", Address, "Address 2", "Sell-to City" (Visible FALSE)
    // DITW18.00.07 KJB 18/02/2016 DIT-770 #1042 Add menu to open Sales Comment Sheet
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Customer"
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Add Action to Shipping Cost Page + Removed old Shipping Costs fields
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 Removed ation Sales Comment Sheet
    // DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Added filters to print "Pick Instruction"
    //                                           Updated ShowShortcutUomValue function
    // DITW19.00.08 VSC 05/12/2016 BL#10330 (DIT-770 #2122) Re index options Report Usage
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 03/02/2017 NRQ#20678 upgrade Usage optionstring
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 IBM PATHAA02 FDD-OTCGAP051 18.01.18
    // # New list Page created from Standard
    // # Code written on Onopenpage to filter
    // HEI.03 CHG2046145 IBM.GAVANM01 16.03.2020 # Sales Order Status Addition
    //   # New field added : 50051 - "Approval Status"

    //************************************************//
    // BC UPGRADE SIVA 16/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 Drink IT code commented & Logic is linked to Field 2014421_"Document Subtype Code"
    //2.Commented Drint it code ,fields  and actions
    //************************************************// 

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added

    Caption = 'Sundry Sales Order Stock';
    CardPageID = "Sales Order";
    DataCaptionFields = "Document Type", "Sell-to Customer No.";
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Request Approval,Order';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST(Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the sales document.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer who will receive the products and be billed by default.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    Visible = false;
                }
                //BC UPGRADE SHUKLP03 >> Added Field
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                //BC UPGRADE SHUKLP03 >> Added Field
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'Specifies the address where products on the sales document will be shipped to.';
                    Visible = false;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Specifies the address where products on the sales document will be shipped to.';
                    Visible = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'Specifies the city of the address.';
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact at the customer.';
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ToolTip = 'Specifies the customer to whom you will send the sales invoice when this customer is different from the sell-to customer.';
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ToolTip = 'Specifies the customer to whom you will send the sales invoice, when different from the customer that you are selling to.';
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ToolTip = 'Specifies the name of the person you should contact at the customer who you are sending the invoice to.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
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
                    ToolTip = 'Specifies the name of the contact person at the address that products will be shipped to.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
                        // DimMgt.LookupDimValueCodeNoUpdate(1); BC UPGRADE SIVA
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
                        //DimMgt.LookupDimValueCodeNoUpdate(2);BC UPGRDE SIVA
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the responsibility center that is responsible for the document.';
                    Visible = false;
                }
                //BC UPGRADE SIVA >> Drink IT Field
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Visible = false;
                // }
                //BC UPGRADE SIVA >> Drink IT Field
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the currency of amounts on the sales document.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date on which you created the sales document.';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the campaign number the document is linked to.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                }
                field("Approval Status"; Rec."Approval Status FND")
                {
                    ToolTip = 'Indicates the approval status of the sales order.';
                }
                //BC UPGRADE SIVA >> Drink IT Field
                // field("Shipment status"; Rec."Shipment status")
                // {
                // }
                //BC UPGRADE SIVA << Drink IT Field
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the sales invoice must be paid.';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment discount percentage that is granted if the customer pays on or before the date entered in the Pmt. Discount Date field. The discount percentage is specified in the Payment Terms Code field.';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how items on the sales document are shipped to the customer.';
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.';
                    Visible = false;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the shipping agent''s package number.';
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies the date you expect to ship items on the sales document.';
                    Visible = false;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ToolTip = 'Specifies if the customer accepts partial shipment of orders.';
                    Visible = false;
                }
                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether all the items on the order have been shipped or, in the case of inbound items, completely received.';
                }
                //BC UPGRADE SIVA >> Drink IT Fields
                // field(Distance; Rec.Distance)
                // {
                //     Visible = false;
                // }
                // field("Delivery Order"; Rec."Delivery Order")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Invoice Method"; Rec."Invoice Method")
                // {
                //     Visible = false;
                // }
                // field("Invoice Period"; Rec."Invoice Period")
                // {
                //     Visible = false;
                // }
                // field("Truck Code"; Rec."Truck Code")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Trailer Code"; Rec."Trailer Code")
                // {
                //     Visible = false;
                // }
                // field("Driver Code"; Rec."Driver Code")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Driver 2 Code"; Rec."Driver 2 Code")
                // {
                //     Visible = false;
                // }
                // field(Route; Rec.Route)
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Route Planning No."; Rec."Route Planning No.")
                // {
                //     Visible = false;
                // }
                // field("Shipping Charge Per"; Rec."Shipping Charge Per")
                // {
                //     Visible = false;
                // }
                // field("Picking Type"; Rec."Picking Type")
                // {
                //     Visible = false;
                // }
                // field("Maximum Weight"; Rec."Maximum Weight")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Maximum Cubage"; Rec."Maximum Cubage")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Total Weight (Base)"; Rec."Total Weight (Base)")
                // {
                //     Visible = false;
                // }
                // field("Total Weight"; Rec."Total Weight")
                // {
                //     Visible = false;
                // }
                // field("Total Cubage (Base)"; Rec."Total Cubage (Base)")
                // {
                //     Visible = false;
                // }
                // field("Total Cubage"; Rec."Total Cubage")
                // {
                //     Visible = false;
                // }
                // field("Total HL Cubage"; Rec."Total HL Cubage")
                // {
                //     Visible = false;
                // }
                // field("Total Eq. UOM Quantity"; Rec."Total Eq. UOM Quantity")
                // {
                //     Visible = false;
                // }
                // field("ShortcutQtyUomBase[1]"; Rec.ShortcutQtyUomBase[1])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(1, 0);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ShortcutQtyUomBase[2]"; ShortcutQtyUomBase[2])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(2, 0);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ShortcutQtyUomBase[3]"; ShortcutQtyUomBase[3])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(3, 0);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ShortcutQtyUomOutstd[1]"; ShortcutQtyUomOutstd[1])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(1, 1);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-770 #1488';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ShortcutQtyUomOutstd[2]"; ShortcutQtyUomOutstd[2])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(2, 1);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-770 #1488';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("ShortcutQtyUomOutstd[3]"; ShortcutQtyUomOutstd[3])
                // {
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassShortcutUom(3, 1);
                //     DecimalPlaces = 0 : 5;
                //     Description = 'DIT-770 #1488';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Link Sales Document Type"; Rec."Link Sales Document Type")
                // {
                //     Visible = false;
                // }
                // field("Link Sales Document No."; Rec."Link Sales Document No.")
                // {
                //     Visible = false;
                // }
                // field("Building No."; Rec."Building No.")
                // {
                //     Visible = false;
                // }
                // field("Fiscal Representative No."; "Fiscal Representative No.")
                // {
                //     Visible = false;
                // }
                // field("Customer Tax Registration No."; Rec"Customer Tax Registration No.")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Customer Tax Warehouse Ref."; Rec."Customer Tax Warehouse Ref.")
                // {
                //     Visible = false;
                // }
                // field("Job Queue Status"; Rec."Job Queue Status")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the status of a job queue entry or task that handles the posting of sales orders.';
                //     Visible = JobQueueActive;
                // }
                // field("Sundry Customer"; Rec."Sundry Customer")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Last changed User ID"; Rec."Last changed User ID")
                // {
                // }
                // field("Last changed Date/time"; Rec."Last changed Date/time")
                // {
                // }
                //BC UPGRADE SIVA << Drink IT Fields
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            part(Control1902018507; "Customer Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
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
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                //BC UPGRADE SIVA >> Microsoft Removal
                // action(Statistics)
                // {
                //     Caption = 'Statistics';
                //     Image = Statistics;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     ShortCutKey = 'F7';

                //     trigger OnAction();
                //     begin
                //         REc.OpenSalesOrderStatistics;
                //     end;
                // }
                // <<BC UPGRADE SIVA<<
                //BC UPGRADE SIVA>> Added
                action(SalesOrderStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Enabled = Rec."No." <> '';
                    Image = Statistics;
                    ShortCutKey = 'F7';
#if CLEAN26
                    Visible = true;
#else
                    Visible = false;
#endif
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    RunObject = Page "Sales Order Statistics";
                    RunPageOnRec = true;
                }
                //BC UPGRADE SIVA<<Added


                action(Approvals)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");//BC UPGRADE SIVA Microsoft Removed 
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No.");//BC UPGRADE SIVA
                        ApprovalEntries.RUN();
                    end;
                }
                action("Co&mments")
                {
                    ToolTip = 'View or add comments to the document.';
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ApplicationArea = all;
                }
                // <<BC UPGRADE SIVA>> Drink IT Fields
                // action("&Sales comments")
                // {
                //     Caption = '&Sales comments';
                //     Image = ViewComments;
                //     RunObject = Page "Sales Comment Sheet";
                //     RunPageLink = "Document Type" = FIELD("Document Type"),
                //                   "No." = FIELD("No."),
                //                   "Document Line No." = CONST(0),
                //                   "Sales Order" = CONST(true);
                //     ShortCutKey = 'Ctrl+B';
                // }
                // action("Shipping Costs")
                // {
                //     Caption = 'Shipping Costs';
                //     Image = Costs;
                //     RunObject = Page "Document Shipping Cost";
                //     RunPageLink = "Source Type" = CONST(36),
                //                   "Source No." = FIELD("No."),
                //                   "Sub Type" = FIELD("Document Type");
                // }
                // <<BC UPGRADE SIVA<< Drink IT Fields
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("S&hipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View the history of posted sales shipments that have been posted for the document.';
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View the history of posted sales invoices that have been posted for the document.';
                }
                action(PostedSalesPrepmtInvoices)
                {
                    ToolTip = 'View the history of posted prepayment invoices that have been posted for the document.';
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ApplicationArea = all;
                }
                action("Prepayment Credi&t Memos")
                {
                    ToolTip = 'View the history of posted prepayment credit memos that have been posted for the document.';
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ApplicationArea = all;
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Whse. Shipment Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Whse. Shipment Lines';
                    ToolTip = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = all;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    ToolTip = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGoToSalesOrderListInNAV)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order List';
                    Enabled = CRMIntegrationEnabled;
                    Image = "Order";
                    ToolTip = 'Open the Dynamics CRM Sales Order List page in Dynamics NAV';
                    Visible = CRMIntegrationEnabled;

                    trigger OnAction();
                    var
                        CRMSalesorder: Record "CRM Salesorder";
                    begin
                        PAGE.RUN(PAGE::"CRM Sales Order List", CRMSalesorder);
                    end;
                }
            }
        }
        area(processing)
        {
            group(ActionGroup12)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = all;
                    ToolTip = 'Release the document to the next stage of processing.';
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = all;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F10';
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Pla&nning")
                {
                    ToolTip = 'View and manage the planning information for the sales order, such as availability, supply, and demand.';
                    Caption = 'Pla&nning';
                    Image = Planning;
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        SalesOrderPlanningForm: Page "Sales Order Planning";
                    begin
                        SalesOrderPlanningForm.SetSalesOrder(Rec."No.");
                        SalesOrderPlanningForm.RUNMODAL();
                    end;
                }
                action("Order &Promising")
                {
                    ToolTip = 'View the order promising lines for the sales order, such as available inventory and delivery dates.';
                    AccessByPermission = TableData "Order Promising Line" = R;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    ToolTip = 'Send the intercompany sales order confirmation to the related company.';
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                            ICInOutboxMgt.SendSalesDoc(Rec, false);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSalesApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            group(ActionGroup3)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    ToolTip = 'Create an inventory put-away or pick document for the sales order.';
                    AccessByPermission = TableData "Posted Invt. Pick Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
                action("Create &Whse. Shipment")
                {
                    ToolTip = 'Create a warehouse shipment document for the sales order.';
                    AccessByPermission = TableData "Warehouse Shipment Header" = R;
                    Caption = 'Create &Whse. Shipment';
                    Image = NewShipment;
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = all;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction();
                    begin
                        PostSubmit(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = all;
                    Caption = 'Post and Send';
                    Ellipsis = true;
                    Image = PostMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens where you can confirm or select a sending profile.';

                    trigger OnAction();
                    begin
                        PostSubmit(CODEUNIT::"Sales-Post and Send");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = all;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = all;
                    ToolTip = 'Schedule the posting of this document as a background task in the job queue.';
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueActive;

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                action("Preview Posting")
                {
                    ApplicationArea = all;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction();
                    begin
                        ShowPreview();
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                //BC UPGRADE SIVA >> Drink IT code
                // action("Order Confirmation (Packing)")
                // {
                //     Caption = 'Order Confirmation (Packing)';
                //     Image = Print;

                //     trigger OnAction();
                //     begin
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         DocPrint.PrintSalesHeaderPacking(Rec);
                //         // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // }
                //BC UPGRADE SIVA >> Drink IT code
                action("Work Order")
                {
                    ToolTip = 'Print a work order for the sales order.';
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                //BC UPGRADE SIVA >> Drink IT Action
                // action("Pick Instruction")
                // {
                //     ToolTip = 'Print pick instructions for the sales order.';
                //     Caption = 'Pick Instruction';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         SalesHeader: Record "Sales Header";
                //     begin
                //         //DocPrint.PrintSalesOrder(Rec,Usage::"Pick Instruction");
                //         // <<DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
                //         SalesHeader := Rec;
                //         SalesHeader.SETRECFILTER();
                //         SalesHeader.SETRANGE("Shipment Date", Rec."Shipment Date");
                //         DocPrint.PrintSalesOrder(SalesHeader, Usage::"Pick Instruction");
                //         // >>DITW18.00.07 DDR DIT-770 #1488
                //     end;
                // }
                //BC UPGRADE SIVA<<
                separator(Separator1100076002)
                {
                }
                //BC UPGRADE SIVA >> Drink IT code & Report Packing List_2014411
                // action("Packing List")
                // {
                //     ToolTip = 'Print a packing list for the sales order.';
                //     Caption = 'Packing List';
                //     Image = Print;

                //     trigger OnAction();
                //     var
                //         SalesHeaderRecL: Record "Sales Header";
                //     begin
                //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         SalesHeaderRecL.SETRANGE("Document Type", Rec."Document Type");
                //         SalesHeaderRecL.SETRANGE("No.", Rec."No.");
                //REPORT.RUN(REPORT::"Packing List", true, false, SalesHeaderRecL);
                // >>DITW16.00.00.40 DDR DIT-715 #197
                //end;
                // }
                // <<BC UPGRADE SIVA<< Drink IT code
                separator(Separator1100710010)
                {
                }
                //BC UPGRADE SIVA >> Drink IT code
                // action("Test AAD Document")
                // {
                //     Caption = 'Test AAD Document';
                //     Image = Print;

                //     trigger OnAction();
                //     begin
                // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                //         DocPrint.PrintSalesHeaderAAD(Rec);
                // >>DITW16.00.00.40 DDR DIT-715 #197
                //     end;
                // }
                // <<BC UPGRADE SIVA<< Drink IT code
            }
            group("&Order Confirmation")
            {
                Caption = '&Order Confirmation';
                Image = Email;

                action("Email Confirmation")
                {
                    Caption = 'Email Confirmation';
                    Ellipsis = true;
                    Image = Email;
                    ToolTip = 'Send an order confirmation by email. The Send Email window opens prefilled for the customer so you can add or change information before you send the email.';
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        DocPrint.EmailSalesHeader(Rec);
                    end;
                }
                action("Print Confirmation")
                {
                    Caption = 'Print Confirmation';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Print an order confirmation. A report request window opens where you can specify what to include on the print-out.';
                    Visible = NOT IsOfficeAddin;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                ToolTip = 'Run the Sales Reservation Availability report to view the availability of items that are reserved for sales orders.';
                Caption = 'Sales Reservation Avail.';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Reservation Avail.";
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlVisibility();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;
    //BC UPGRADE SIVA>> Drink IT Cpde 
    // trigger OnAfterGetRecord();
    // begin
    // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244 - DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
    //     ShowShortcutUomValue(ShortcutQtyUomBase, ShortcutQtyUomOutstd, 2);  
    // >>DITW16.00.00.40 DDR DIT-715 #244 - DITW18.00.07 DDR DIT-770 #1488
    // end;
    //BC UPGRADE SIVA

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
        SalesSetup: Record "Sales & Receivables Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
    begin
        //BC UPGRADE SIVA >> //Drink IT Code
        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1190
        //IF UserMgt.GetSalesFilter <> '' THEN BEGIN
        // if UserMgt.GetSalesTextFilter <> '' then begin
        //     FILTERGROUP(2);
        //SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
        //     SETFILTER("Responsibility Center", UserMgt.GetSalesTextFilter);
        //     FILTERGROUP(0);
        // end;
        // >>DITW18.00.06 DDR DIT-770 #1190

        // BC Upgrade SHUKLP03 >> Added code.
        //HEI.01>>
        //PATHAA02>>
        if docsubtypecodesetup.GET() then begin
            docsubtypecodesetup.TESTFIELD("Sundry Sales Order Stock");
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Document Subtype Code FND", docsubtypecodesetup."Sundry Sales Order Stock");
            Rec.FILTERGROUP(0);
        end;
        // BC Upgrade SHUKLP03 << Added code.

        Rec.SETRANGE("Date Filter", 0D, WORKDATE() - 1);
        //PATHAA02<<
        //BC UPGRADE SIVA<<

        JobQueueActive := SalesSetup.JobQueueActive();
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        IsOfficeAddin := OfficeMgt.IsAvailable();

        Rec.CopySellToCustomerFilter();
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction",,,,,,,,,,"Order Picking","Picking List","Shipping List","Order Shipment","Combined Picking","Load List","Shipment Specif.","Return Control",,,,,,,,,,,,,,,,,,,,"Pro-forma";
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        SkipLinesWithoutVAT: Boolean;
        DimMgt: Codeunit DimensionManagement;
        ShortcutQtyUomBase: array[3] of Decimal;
        ShortcutQtyUomOutstd: array[3] of Decimal;
        docsubtypecodesetup: Record "Doc Subtype Code Setup FND"; //BC Uprade SHUKLP03

    procedure ShowPreview();
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure PostSubmit(PostingCodeunitID: Integer);
    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        //if ApplicationAreaSetup.IsFoundationEnabled then //BC UPGRADE SIVA>> Microsoft removed this check in the upgraded version
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        CurrPage.UPDATE(false);
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

        exit(CashFlowManagement.GetTaxAmountFromSalesOrder(Rec) <> 0);
    end;
}

