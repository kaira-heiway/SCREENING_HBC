page 53018 "Standard Sales Return Order"
{
    // version HEI.01
    //BC UPGRADE SIVA Old Page ID 50138
    // DITW15.00.00.24 DDR 07/10/2008 Added columns
    //                                 Status,"Duty Tax Type","Disc.Promo. Order Calculated",
    //                                 "Shipping Charge Per","Total Weight","Total Cubage",Distance,
    //                                 "Link Sales Document Type","Link Sales Document No."
    // DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    // DITW15.00.00.35 DDR 13/10/2009 Added columns "Building No."
    // DITW15.00.00.38 DDR 17/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added columns
    //                                    "Customer Tax Registration No.","Fiscal Representative No.",
    //                                    "Customer Tax Warehouse Ref."
    // DITW16.00.00.40 DDR 20/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    //                     20/02/2012 DIT-715 #244 Added/Moved columns
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Customer"
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Add Action to Shipping Cost Page + Removed old Shipping Costs fields
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Updated ShowShortcutUomValue function
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // 
    // HEI.01 IBM PATHAA02 FDD-OTCGAP051 18.01.18
    // # New list Page created from Standard
    // # Code written on Onopenpage to filter
    // HEI.02 CHG2046145 IBM.GAVANM01 16.03.2020 # Sales Order Status Addition
    //   # New field added : 50051 - "Approval Status"
    //************************************************//
    // BC UPGRADE SIVA 16/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 Commented Code related to Drink IT T2014473.
    //2.HEI.02 no changes while converting to BC page as field "Approval Status" is already present in BC page & Application Area ALL inheritance from Page property.
    //3.Drink IT Fields/Actions/Code are commented
    //4.Area Navigateion >> Group &Return Order >> Action Statistics is commented as it is Microsoft removal reason is SalesOrderStatistics added.

    //************************************************//

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added

    Caption = 'Standard Sales Return Order';
    CardPageID = "Sales Return Order";
    ApplicationArea = All;
    UsageCategory = Lists;
    DataCaptionFields = "Document Type", "Sell-to Customer No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST("Return Order"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    Visible = false;
                }
                //BC UPGRADE SHUKLP03 >> Field Added
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                //BC UPGRADE SHUKLP03 << Field Added
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ToolTip = 'First line of the sell-to customer''s address.';
                    Visible = false;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ToolTip = 'Second line of the sell-to customer''s address.';
                    Visible = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Visible = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ToolTip = 'City of the sell-to customer.';
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
                        // DimMgt.LookupDimValueCodeNoUpdate(1); //BC UPGRADE SIVA
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
                        //DimMgt.LookupDimValueCodeNoUpdate(2); //BC UPGRADE SIVA
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the responsibility center for the sales return order.';
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
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Approval Status"; Rec."Approval Status FND")
                {
                    ToolTip = 'Indicates the approval status of the sales return order.';
                }
                //BC UPGRADE SIVA >> Drink IT Fields
                // field("Shipment status"; Rec."Shipment status")
                // {
                // }
                // field("Disc.Promo. Order Calculated"; Rec."Disc.Promo. Order Calculated")
                // {
                //     Visible = false;
                // }
                // field("Shipment Method Code"; Rec."Shipment Method Code")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Shipping Agent Code"; Rec."Shipping Agent Code")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                //BC UPGRADE SIVA << Drink IT Fields
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Visible = false;
                }
                //BC UPGRADE SIVA >> Drink IT Fields
                // field("Shipping Advice"; Rec."Shipping Advice")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
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
                // field("ShortcutQtyUomBase[1]"; ShortcutQtyUomBase[1])
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
                // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
                // {
                //     Visible = false;
                // }
                // field("Customer Tax Registration No."; Rec."Customer Tax Registration No.")
                // {
                //     Description = 'DIT-715 #244';
                //     Visible = false;
                // }
                // field("Customer Tax Warehouse Ref."; Rec."Customer Tax Warehouse Ref.")
                // {
                //     Visible = false;
                // }
                //BC UPGRADE SIVA << Drink IT Fields
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Visible = false;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the type of document to which the sales return order applies.';
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Visible = JobQueueActive;
                }
                //BC UPGRADE SIVA >> Drink IT Field
                // field("Sundry Customer"; Rec."Sundry Customer")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                //BC UPGRADE SIVA << Drink IT Field
            }
        }
        area(factboxes)
        {
            part(Control1902018507; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Return Order")
            {
                Caption = '&Return Order';
                Image = Return;
                //BC UPGRADE SIVA >> Microsoft Removal
                // action(Statistics)
                // {
                //     ToolTip = 'View statistics for the sales return order, such as amounts, weights, and volumes.';
                //     Caption = 'Statistics';
                //     Image = Statistics;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     ShortCutKey = 'F7';

                //     trigger OnAction();
                //     begin
                //         Rec.OpenSalesOrderStatistics();
                //     end;
                // }
                //BC UPGRADE SIVA >> Microsoft Removal
                // <<BC UPGRADE SIVA<< Added
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
                // <<BC UPGRADE SIVA<< Added
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = false;
                    ApplicationArea = all;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ApplicationArea = all;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No."); //BC UPGRADE SIVA Function name change in BC
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No."); //BC UPGRADE SIVA
                        ApprovalEntries.RUN();
                    end;
                }
                action("Co&mments")
                {
                    ToolTip = 'View or add comments to the sales return order.';
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = false;
                    ApplicationArea = all;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Return Order"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                //BC UPGRADE SIVA >> Drink IT Page "Document Shipping Cost" 
                // action("Shipping Costs")
                // {
                //     ToolTip = 'View or edit shipping costs for the sales return order.';
                //     Caption = 'Shipping Costs';
                //     Image = Costs;
                //     RunObject = Page "Document Shipping Cost";
                //     RunPageLink = "Source Type" = CONST(36),
                //                   "Source No." = FIELD("No."),
                //                   "Sub Type" = FIELD("Document Type");
                // }
                //BC UPGRADE SIVA<< Drink IT Page
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("Return Receipts")
                {
                    ToolTip = 'View posted return receipts created from this sales return order.';
                    Caption = 'Return Receipts';
                    Image = ReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                    ApplicationArea = all;
                }
                action("Cred&it Memos")
                {
                    ToolTip = 'View posted credit memos created from this sales return order.';
                    Caption = 'Cred&it Memos';
                    Image = CreditMemo;
                    ApplicationArea = all;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("In&vt. Put-away/Pick Lines")
                {
                    ToolTip = 'View inventory put-away and pick lines created from this sales return order.';
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    ApplicationArea = all;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Return Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                action("Whse. Receipt Lines")
                {
                    ToolTip = 'View warehouse receipt lines created from this sales return order.';
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    ApplicationArea = all;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ToolTip = 'Print the sales return order.';
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
            group(ActionGroup7)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ToolTip = 'Release the sales return order.';
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    trigger OnAction();
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ToolTip = 'Reopen the sales return order.';
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ShortCutKey = 'Ctrl+F10';
                    ApplicationArea = all;

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
                //BC UPGRADE SIVA >> GetPstdDocLinesToRevere Not find in page
                // action("Get Posted Doc&ument Lines to Reverse")
                // {
                //     ToolTip = 'Get the posted document lines to reverse for this sales return order.';
                //     Caption = 'Get Posted Doc&ument Lines to Reverse';
                //     Ellipsis = true;
                //     Image = ReverseLines;

                //     trigger OnAction();
                //     begin
                //         GetPstdDocLinesToRevere;
                //     end;
                // }
                //BC UPGRADE SIVA >> GetPstdDocLinesToRevere Not find in page
                separator(Separator1102601021)
                {
                }
                action("Send IC Return Order Cnfmn.")
                {
                    ToolTip = 'Send the intercompany return order confirmation to the related company.';
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Return Order Cnfmn.';
                    Image = IntercompanyOrder;
                    ApplicationArea = all;
                    trigger OnAction();
                    var
                        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckSales(Rec) then
                            ICInboxOutboxMgt.SendSalesDoc(Rec, false);
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
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send an approval request.';

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
            group(ActionGroup8)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create Inventor&y Put-away/Pick")
                {
                    ToolTip = 'Create inventory put-away and pick for this sales return order.';
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreatePutawayPick;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();
                    end;
                }
                action("Create &Whse. Receipt")
                {
                    ToolTip = 'Create a warehouse receipt for this sales return order.';
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromSalesReturnOrder(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = all;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action(Post)
                {
                    ToolTip = 'Post the sales return order.';
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Rec.SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Preview Posting")
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';
                    ApplicationArea = all;
                    trigger OnAction();
                    var
                        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
                    begin
                        SalesPostYesNo.Preview(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    ToolTip = 'Post the sales return order and print the posted document.';
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        Rec.SendToPosting(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post and Email")
                {
                    ToolTip = 'Post the sales return order and send it by email to the customer.';
                    Caption = 'Post and Email';
                    Ellipsis = true;
                    Image = PostMail;
                    ApplicationArea = all;
                    trigger OnAction();
                    var
                        SalesPostPrint: Codeunit "Sales-Post + Print";
                    begin
                        SalesPostPrint.PostAndEmail(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ToolTip = 'Post the sales return order as a background job in the job queue.';
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Return Orders", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ToolTip = 'Remove the sales return order from the job queue.';
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueActive;
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord();
    begin
        //BC UPGRADE SIVA >> Drink IT code
        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244 - DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
        // Rec.ShowShortcutUomValue(ShortcutQtyUomBase, ShortcutQtyUomOutstd, 2); 
        // >>DITW16.00.00.40 DDR DIT-715 #244 - DITW18.00.07 DDR DIT-770 #1488
        //BC UPGRADE SIVA <<Drink IT code
    end;

    trigger OnOpenPage();
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        JobQueueActive := SalesSetup.JobQueueActive();

        Rec.CopySellToCustomerFilter();
        //BC UPGRDE SHUKLP03 >> Field added
        //HEI.01 PATHAA02>>
        if docsubtypecodesetup.GET() then begin
            docsubtypecodesetup.TESTFIELD(docsubtypecodesetup."Standard Sales Return Order");
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Document Subtype Code FND", docsubtypecodesetup."Standard Sales Return Order");
            Rec.FILTERGROUP(0);
        end;
        //PATHAA02<<
        //BC UPGRDE SHUKLP03 << Field added
    end;

    var
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DimMgt: Codeunit DimensionManagement;
        ShortcutQtyUomBase: array[3] of Decimal;
        ShortcutQtyUomOutstd: array[3] of Decimal;
        docsubtypecodesetup: Record "Doc Subtype Code Setup FND"; //BC UPGRADE SHUKLP03

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;
}

