page 51062 "Expense Claim CM CBN"
{
    // version NAVW110.0.00.15140,FINXL10.00,DITW110.00.09,HEI.05

    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    // DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    //                                Added fields "Vendor DTax Group Code" into Invoicing tab
    // DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    // DITW15.00.00.34 DDR 17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                Changed Editable "Status" field
    //                                Added functions DocStatusRelease(),DocStatusOpen(),
    // DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    // DITW15.00.00.39 DDR 27/04/2011 issue 1323 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                Added to call function StdVendPurchCode.AutoInsertPurchLines()
    //                                  from OnAfterValidate trigger field "Sell-to Customer No."
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW15.00.00.39 DDR 10/05/2011 issue 1330 Upgrade editable Status to work with Approval requests
    //                                           Remove 'ShowConfirmMsg' parameter function DocStatusOpen();
    //                                           Modified functions DocStatusOpen(),DocStatusRelease()
    //                                           Modified validate trigger field "Status"
    //                     27/07/2011 issue 1407 Added flowfields "Disc.Promo. Order Calculated" (see "Zoom view)
    //                                           Moved/Deleted functions into codeunit414 Release Sales Document
    //                                             DocStatusRelease(),DocStatusOpen()
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  call function SetDisableRefreshLines() before each report
    //                                                  (don't use the <RunObject> property)
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                             Added fields into 'Service/Contract' tab
    //                                               "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                             Moved "Building No." into 'Service/Contract' tab
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Added Field "Vendor Posting Group"
    //                                          : Added code on Drill Down of "Applies-to Doc. No."
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // 
    // FINXL7.00 RBE 20/03/2013 : Added field "Your Reference","Posting Description" on page
    // FINXL7.00 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    // FINXL7.00 KLU 03/10/2013 : Check for existing template name
    // FINXL8.00.001 RBE 01/12/2014: Hide factbox: "Purch. Inv./Cr.M. Info"
    // 
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field 2014319  "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Rename Option DIT Contract,Service Contract by Financial,Service
    //                                           Added blank Option to Contract Type
    // DITW19.00.07 MVN 25/01/2016 DIT-770 #1740 Upgrade
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" under "Invoicing" tab
    // DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    // DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL9.00.000.01 ACH 05/01/2016 : Added factbox to show mandatory Dimensions for G/L account
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // 
    // HEI.01 blocked on trigger OnNewRecord() due to DrinkIT field is "Document Subtype Code" is used in code.

    // HEI.02 CHG0255417 IBM.LS 15.10.2018
    //   # Code added to restrict the field modification.

    // HEI.03 CHG0255417 IBM.LS 30.10.2018
    //   # Code added to restrict the field-"Payment Method Code" modification.
    // HEI.04 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # Made Field "Vendor Posting Group" non-editable
    // HEI.05 CHG2170293 HB3102 IBM MAJUMS03 18.10.2022 - Payment Method Code to be populated from Master Data during Credit Memo Processing
    //   # Editable" property of "Payment Method Code" field is modified as FALSE.

    //  IsFoundationArea() condition is not required anymore in business central Saas so blocked that condition.

    // DrinkIT code and fields "Tax Date", "Creation Date/Time", "Created By", "Linked Customer No.", "Doc. Amount VAT", "Doc. Amount Incl. VAT", 
    // "Document Subtype Code", "Physical Location Group Code", "Vendor DTax Group Code", "Truck Code", "Driver Code" are blocked.

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added.

    Caption = 'Expense Claim Credit Memos';
    PageType = Document;
    // PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = FILTER("Credit Memo"));
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Documents; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit();
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Importance = Promoted;
                    QuickEntry = false;
                    ShowMandatory = true;
                    TableRelation = Vendor where("Employee FND" = FILTER(true));
                    ToolTip = 'Specifies the name of the vendor who sends the items.';

                    trigger OnValidate();
                    var
                        ApplicationAreaSetup: Record "Application Area Setup";
                    begin
                        if Rec."No." = '' then
                            Rec.InitRecord();

                        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
                            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                                Rec.SETRANGE("Buy-from Vendor No.");
                        // IF ApplicationAreaSetup.IsFoundationEnabled THEN // BC Upgrade SHUKLP03 << Blocked becaue no need of this condition.
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.UPDATE();
                        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
                        // // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
                        // COMMIT;
                        // StdVendPurchCode.AutoInsertPurchLines(Rec);
                        // // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)

                        // //<<FINXL7.00 RBE 06/08/2013
                        // if recFinXLSetup.READPERMISSION then
                        //     UpdateAfterChangingHeader;
                        // //>>FINXL7.00 RBE 06/08/2013

                    end;
                }
                group("Buy-from")
                {
                    Caption = 'Buy-from';
                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the address of the vendor who ships the items.';
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the vendor who ships the items.';
                    }
                    field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact No.';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the number of your contact at the vendor.';
                    }
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contact';
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the vendor''s reference.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date on which the vendor created the purchase document.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
                // field("Tax Date"; Rec."Tax Date")
                // {
                // } // BC Upgrade SHUKLP03 << DrinkIT field is blocked.
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        UserSetup.GET(USERID);
                        if (Rec."Due Date" <> xRec."Due Date") and (xRec."Due Date" <> 0D) then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Due Date"));
                        end;
                        //HEI.02<<
                    end;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date you expect to receive the items on the purchase document.';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the identification number of a compensation agreement.';
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ToolTip = 'Specifies the number of the incoming document that this purchase document is created for.';
                    Visible = false;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = VendorCreditMemoNoMandatory;
                    ToolTip = 'Specifies the number that the vendor uses for the credit memo you are creating in this purchase credit memo header.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';

                    trigger OnValidate();
                    begin
                        PurchaserCodeOnAfterValidate();
                    end;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the campaign number the document is linked to.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
                // field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
                // {
                // } // BC Upgrade SHUKLP03 << DrinkIT field is blocked.
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies whether the record is open, is waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';

                    trigger OnValidate();
                    begin
                        StatusOnValidate();
                        StatusOnAfterValidate();
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
                // field("Creation Date/Time"; "Creation Date/Time")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                // field("Created By"; "Created By")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                // field("Linked Customer No."; "Linked Customer No.")
                // {
                //     Importance = Additional;
                // }
                field("Doc. Amount Incl. VAT"; rec."Doc. Amount Incl. VAT IBM FND")
                {
                    ApplicationArea = all;

                }//BC Upgrade SHARMP16--PID854
                field("Doc. Amount VAT"; rec."Doc. Amount VAT IBM FND")
                {
                    ApplicationArea = all;

                } //BC Upgrade SHARMP16--PID854
            }
            part(PurchLines; "Expense Claim CM Subform CBN")
            {
                ApplicationArea = Basic, Suite;
                Editable = Rec."Buy-from Vendor No." <> '';
                Enabled = Rec."Buy-from Vendor No." <> '';
                SubPageLink = "Document No." = FIELD("No."), "Document Type" = field("Document Type");//BC Upgrade SHARMP16--PID854
                UpdatePropagation = Both;
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the currency code for amounts on the purchase lines.';

                    trigger OnAssistEdit();
                    begin
                        CLEAR(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE());
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE();
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.';

                    trigger OnValidate();
                    begin
                        PricesIncludingVATOnAfterValid();
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.';

                    trigger OnValidate();
                    begin
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Editable = false;
                    ToolTip = 'Specifies the vendor''s market type to link business transactions to.';
                }
                // BC Upgrade SHUKLP03 >> Added Document Subtype Code
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                } // BC Upgrade SHUKLP03 << Added Document Subtype Code

                field("Payment Status"; Rec."Payment Status FND")
                {
                    ToolTip = 'Specifies the value of the Payment Status field.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Status FND" <> xRec."Payment Status FND") then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Status FND"));
                        end;
                        //HEI.02<<
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Terms Code" <> xRec."Payment Terms Code") and (xRec."Payment Terms Code" <> '') then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Terms Code"));
                        end;
                        //HEI.02<<
                    end;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies how payment for the purchase document must be submitted.';

                    trigger OnValidate();
                    begin
                        //HEI.03>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Method Code" <> xRec."Payment Method Code") and (xRec."Payment Method Code" <> '') then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Method Code"));
                        end;
                        //HEI.03<<
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number for the transaction type, for the purpose of reporting to Intrastat.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment discount percent that will be given if you pay for the purchase on or before the date in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the last date on which you can pay the invoice and still receive a payment discount.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Importance = Additional;
                //     QuickEntry = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                //             CurrPage.UPDATE(true);
                //         // >>DITW18.00.06 DDR DIT-770 #1191
                //     end;
                // } // BC Upgrade SHUKLP03 << DrinkIT field is blocked.
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
                // field("Truck Code"; Rec."Truck Code")
                // {
                // }
                // field("Driver Code"; Rec."Driver Code")
                // {
                // } // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the document.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    Editable = false;
                    ToolTip = 'Specifies if the posted invoice will be included in the payment suggestion.';
                }
                field("On Hold UserID"; Rec."On Hold UserID FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the On Hold UserID field.';
                }
                field("On Hold Date"; Rec."On Hold Date FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the On Hold Date field.';
                }
            }
            group("Shipping and Payment")
            {
                Caption = 'Shipping and Payment';
                group("Ship-to")
                {
                    Caption = 'Ship-to';
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Name';
                        ToolTip = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.';
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        ToolTip = 'Specifies the address that you want the items in the purchase order to be shipped to.';
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        ToolTip = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.';
                    }
                }
                group("Pay-to")
                {
                    Caption = 'Pay-to';
                    field("Pay-to Name"; Rec."Pay-to Name")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Name';
                        Importance = Promoted;
                        ToolTip = 'Specifies the vendor who is sending the invoice.';

                        trigger OnValidate();
                        begin
                            //HEI.02>>
                            UserSetup.GET(USERID);
                            if (Rec."Pay-to Name" <> xRec."Pay-to Name") and (xRec."Pay-to Name" <> '') then begin
                                ERROR(Text0001, Rec.FIELDCAPTION("Pay-to Name"));
                            end;
                            //HEI.02<<
                            if Rec.GETFILTER("Pay-to Vendor No.") = xRec."Pay-to Vendor No." then
                                if Rec."Pay-to Vendor No." <> xRec."Pay-to Vendor No." then
                                    Rec.SETRANGE("Pay-to Vendor No.");

                            PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

                            CurrPage.UPDATE();
                        end;
                    }
                    field("Pay-to Address"; Rec."Pay-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the address of the vendor sending the invoice.';
                    }
                    field("Pay-to Address 2"; Rec."Pay-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Pay-to Post Code"; Rec."Pay-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Pay-to City"; Rec."Pay-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the vendor sending the invoice.';
                    }
                    field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact who sends the invoice.';
                    }
                    field("Pay-to Contact"; Rec."Pay-to Contact")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    }
                    field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
                    {
                        ToolTip = 'Specifies the value of the Vendor Bank Account field.';
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies a code for the purchase header''s transaction specification here.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the code for the transport method to be used with this purchase header.';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region.';
                }
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Specifies the code for the area of the vendor''s address.';
                }
            }
            group(Application)
            {
                Caption = 'Application';
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';

                    trigger OnDrillDown();
                    var
                        VendLedgEntry: Record "Vendor Ledger Entry";
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
                        // //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
                        // VendLedgEntry.SETCURRENTKEY("Document No.");
                        // VendLedgEntry.SETRANGE("Contract Type","Contract Type");
                        // VendLedgEntry.SETRANGE("DIT Sub-Contract Type","DIT Sub-Contract Type");
                        // //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                        // case "Contract Type" of
                        //   "Contract Type"::Service :
                        //     VendLedgEntry.SETRANGE("Service Contract No.","Service Contract No.");
                        //   "Contract Type"::Financial :
                        //     VendLedgEntry.SETRANGE("Financial Contract No.","Financial Contract No.");
                        // end;
                        // //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                        // VendLedgEntry.SETRANGE("Contract Group Code","Contract Group Code");
                        // VendLedgEntry.SETRANGE("Vendor Posting Group","Vendor Posting Group");
                        // PAGE.RUN(0,VendLedgEntry);
                        // //>>DITW17.10.03 TEC1 DIT-770 #340
                        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
                    end;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                }
            }
            // BC Upgrade SHUKLP03 >> DrinkIT created group "Service/Contract" is blocked.
            // group("Service/Contract")
            // {
            //     Caption = 'Service/Contract';
            //     field("Contract Type";Rec."Contract Type")
            //     {
            //         Editable = false;
            //     }
            //     field("DIT Sub-Contract Type";"DIT Sub-Contract Type")
            //     {
            //     }
            //     field("Service Contract No.";"Service Contract No.")
            //     {
            //     }
            //     field("Financial Contract No.";"Financial Contract No.")
            //     {
            //     }
            //     field("Contract Group Code";"Contract Group Code")
            //     {
            //     }
            // } // BC Upgrade SHUKLP03 << DrinkIT created group "Service/Contract" is blocked.
        }
        area(factboxes)
        {
            part(Control15; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                Visible = false;
            }
            part("G/L Account Mandatory Dimensions"; "Dimensions FactBox")
            {
                Caption = 'G/L Account Mandatory Dimensions';
                Description = 'FINXL9.00.000.01';
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                SubPageView = where("Table ID" = CONST(15),
                                    "Value Posting" = CONST("Code Mandatory"));
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            // BC Upgrade SHUKLP03 >> DrinkIT created page "Purchase Line FactBox2" is blocked.
            // part(Control1907232107;"Purchase Line FactBox2")
            // {
            //     Provider = PurchLines;
            //     SubPageLink = "Document Type"=FIELD("Document Type"),
            //                   "Document No."=FIELD("Document No."),
            //                   "Line No."=FIELD("Line No.");
            //     Visible = false;
            // } // BC Upgrade SHUKLP03 << DrinkIT created page "Purchase Line FactBox2" is blocked.
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            // part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            // {
            //     ShowFilter = false;
            //     Visible = NOT IsOfficeAddin;
            // }//BC Upgrade SHARMP16
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Purchase Header"),
                              "No." = field("No."),
                              "Document Type" = field("Document Type");
            }//BC Upgrade SHARMP16
            part(Control5; "Purchase Line FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            // BC Upgrade SHUKLP03 >> Blocked due to DrinkIT page is used.
            // part(Control2029614; "Purch. Inv./Cr.M. Info")
            // {
            //     Description = 'FINXL7.00.001';
            //     Provider = PurchLines;
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                   "Document No." = FIELD("Document No."),
            //                   "Line No." = FIELD("Line No.");
            //     Visible = false;
            // } // BC Upgrade SHUKLP03 << Blocked due to DrinkIT page is used.
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }


    // actions
    // {
    //     area(navigation)
    //     {
    //         group("&Invoice")
    //         {
    //             Caption = '&Invoice';
    //             Image = Invoice;
    //             action(Statistics1)
    //             {
    //                 ApplicationArea = all;
    //                 Caption = 'Statistics';
    //                 Image = Statistics;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ShortCutKey = 'F7';
    //                 ToolTip = 'Executes the Statistics action.';
    //                 Visible = false;
    //                 trigger OnAction();
    //                 begin
    //                     Rec.CalcInvDiscForHeader();
    //                     COMMIT();
    //                     PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
    //                     PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
    //                 end;
    //             }
    //             action(Vendor1)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Vendor';
    //                 Image = Vendor;
    //                 Promoted = true;
    //                 PromotedCategory = Category5;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 RunObject = Page "Vendor Card";
    //                 RunPageLink = "No." = FIELD("Buy-from Vendor No.");
    //                 ShortCutKey = 'Shift+F7';
    //                 ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
    //             }
    //             action("Co&mments1")
    //             {
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ApplicationArea = all;
    //                 Caption = 'Co&mments';
    //                 Image = ViewComments;
    //                 RunObject = Page "Purch. Comment Sheet";
    //                 RunPageLink = "Document Type" = FIELD("Document Type"),
    //                               "No." = FIELD("No."),
    //                               "Document Line No." = CONST(0);
    //                 ToolTip = 'Executes the Co&mments action.';
    //             }
    //             action(DocAttach11)
    //             {
    //                 ApplicationArea = All;
    //                 Caption = 'Attachments';
    //                 Image = Attach;
    //                 ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 trigger OnAction()
    //                 var
    //                     DocumentAttachmentDetails: Page "Document Attachment Details";
    //                     RecRef: RecordRef;
    //                 begin
    //                     RecRef.GetTable(Rec);
    //                     DocumentAttachmentDetails.OpenForRecRef(RecRef);
    //                     DocumentAttachmentDetails.RunModal();
    //                 end;
    //             }
    //             action(Dimensions1)
    //             {
    //                 AccessByPermission = TableData Dimension = R;
    //                 ApplicationArea = Suite;
    //                 Caption = 'Dimensions';
    //                 Enabled = Rec."No." <> '';
    //                 Image = Dimensions;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ShortCutKey = 'Shift+Ctrl+D';
    //                 ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

    //                 trigger OnAction();
    //                 begin
    //                     Rec.ShowDocDim();
    //                     CurrPage.SAVERECORD();
    //                 end;
    //             }
    //         }
    //         group("&Credit Memo")
    //         {
    //             Caption = '&Credit Memo';
    //             Image = CreditMemo;
    //             action(Statistics)
    //             {
    //                 Caption = 'Statistics';
    //                 Image = Statistics;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ShortCutKey = 'F7';
    //                 ToolTip = 'Executes the Statistics action.';

    //                 trigger OnAction();
    //                 begin
    //                     Rec.CalcInvDiscForHeader();
    //                     COMMIT();
    //                     PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
    //                     PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
    //                 end;
    //             }
    //             action(Vendor)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Vendor';
    //                 Image = Vendor;
    //                 RunObject = Page "Vendor Card";
    //                 RunPageLink = "No." = FIELD("Buy-from Vendor No.");
    //                 ShortCutKey = 'Shift+F7';
    //                 ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
    //             }
    //             action(Dimensions)
    //             {
    //                 AccessByPermission = TableData Dimension = R;
    //                 ApplicationArea = Suite;
    //                 Caption = 'Dimensions';
    //                 Enabled = Rec."No." <> '';
    //                 Image = Dimensions;
    //                 ShortCutKey = 'Shift+Ctrl+D';
    //                 ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

    //                 trigger OnAction();
    //                 begin
    //                     Rec.ShowDocDim();
    //                     CurrPage.SAVERECORD();
    //                 end;
    //             }
    //             action(Approvals)
    //             {
    //                 AccessByPermission = TableData "Approval Entry" = R;
    //                 ApplicationArea = Suite;
    //                 Caption = 'Approvals';
    //                 Image = Approvals;
    //                 ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

    //                 trigger OnAction();
    //                 var
    //                     ApprovalEntries: Page "Approval Entries";
    //                 begin
    //                     ApprovalEntries.SetRecordfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
    //                     ApprovalEntries.RUN();
    //                 end;
    //             }
    //             action("Co&mments")
    //             {
    //                 Caption = 'Co&mments';
    //                 Image = ViewComments;
    //                 RunObject = Page "Purch. Comment Sheet";
    //                 RunPageLink = "Document Type" = FIELD("Document Type"),
    //                               "No." = FIELD("No."),
    //                               "Document Line No." = CONST(0);
    //                 ToolTip = 'Executes the Co&mments action.';
    //             }
    //         }
    //     }
    //     area(processing)
    //     {
    //         group(Approval)
    //         {
    //             Caption = 'Approval';
    //             action(Approve)
    //             {
    //                 ApplicationArea = All;
    //                 Caption = 'Approve';
    //                 Image = Approve;
    //                 Promoted = true;
    //                 PromotedCategory = Category4;
    //                 PromotedIsBig = true;
    //                 ToolTip = 'Approve the requested changes.';
    //                 Visible = OpenApprovalEntriesExistForCurrUser;

    //                 trigger OnAction();
    //                 var
    //                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //                 begin
    //                     ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
    //                 end;
    //             }
    //             action(Reject)
    //             {
    //                 ApplicationArea = All;
    //                 Caption = 'Reject';
    //                 Image = Reject;
    //                 Promoted = true;
    //                 PromotedCategory = Category4;
    //                 PromotedIsBig = true;
    //                 ToolTip = 'Reject the approval request.';
    //                 Visible = OpenApprovalEntriesExistForCurrUser;

    //                 trigger OnAction();
    //                 var
    //                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //                 begin
    //                     ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
    //                 end;
    //             }
    //             action(Delegate)
    //             {
    //                 ApplicationArea = All;
    //                 Caption = 'Delegate';
    //                 Image = Delegate;
    //                 Promoted = true;
    //                 PromotedCategory = Category4;
    //                 ToolTip = 'Delegate the approval to a substitute approver.';
    //                 Visible = OpenApprovalEntriesExistForCurrUser;

    //                 trigger OnAction();
    //                 var
    //                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //                 begin
    //                     ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
    //                 end;
    //             }
    //             action(Comment)
    //             {
    //                 ApplicationArea = All;
    //                 Caption = 'Comments';
    //                 Image = ViewComments;
    //                 Promoted = true;
    //                 PromotedCategory = Category4;
    //                 ToolTip = 'View or add comments.';
    //                 Visible = OpenApprovalEntriesExistForCurrUser;

    //                 trigger OnAction();
    //                 var
    //                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //                 begin
    //                     ApprovalsMgmt.GetApprovalComment(Rec);
    //                 end;
    //             }
    //         }
    //         group(ActionGroup9)
    //         {
    //             Caption = 'Release';
    //             Image = ReleaseDoc;
    //             action(Release)
    //             {
    //                 Caption = 'Re&lease';
    //                 Image = ReleaseDoc;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ShortCutKey = 'Ctrl+F9';
    //                 ToolTip = 'Executes the Re&lease action.';

    //                 trigger OnAction();
    //                 var
    //                     ReleasePurchDoc: Codeunit "Release Purchase Document";
    //                 begin
    //                     //BC Upgrade SHUKLP03 >> Blocked due to DrinkIT created function DocStatusRelease() is called. 
    //                     // // <<DITW15.00.00.36 DDR 07/12/2009
    //                     // CurrPage.UPDATE(true);
    //                     // // >>DITW15.00.00.36 DDR
    //                     // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
    //                     // //ReleasePurchDoc.PerformManualRelease(Rec);
    //                     // ReleasePurchDoc.DocStatusRelease(xRec, Rec);
    //                     // CurrPage.UPDATE;
    //                     // // >>DITW15.00.00.39 DDR #1330 #1407
    //                     //BC Upgrade SHUKLP03 << Blocked due to DrinkIT created function DocStatusRelease() is called. 
    //                     //BC UPGRADE SHARMP16>>
    //                     ReleasePurchDoc.PerformManualRelease(Rec);
    //                     CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
    //                     //BC UPGRADE SHARMP16<<
    //                 end;
    //             }
    //             action(Reopen)
    //             {
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ApplicationArea = Suite;
    //                 Caption = 'Re&open';
    //                 Enabled = Rec.Status <> Rec.Status::Open;
    //                 Image = ReOpen;
    //                 ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

    //                 trigger OnAction()
    //                 var
    //                     ReleasePurchDoc: Codeunit "Release Purchase Document";
    //                 begin
    //                     //BC UPGRADE SHARMP16>>
    //                     ReleasePurchDoc.PerformManualReopen(Rec);
    //                     CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
    //                     //BC UPGRADE SHARMP16<<
    //                 end;
    //             }
    //         }
    //         action("Archive Document")
    //         {
    //             Caption = 'Archi&ve Document';
    //             Image = Archive;
    //             ToolTip = 'Executes the Archi&ve Document action.';

    //             trigger OnAction();
    //             begin
    //                 //HEI.02>>
    //                 ArchiveManagement.ArchivePurchDocument(Rec);
    //                 CurrPage.UPDATE(false);
    //                 //HEI.02<<
    //             end;
    //         }


    //         group("F&unctions")
    //         {
    //             Caption = 'F&unctions';
    //             Image = "Action";
    //             action("Get St&d. Vend. Purchase Codes")
    //             {
    //                 Caption = 'Get St&d. Vend. Purchase Codes';
    //                 Ellipsis = true;
    //                 Image = VendorCode;
    //                 ToolTip = 'Executes the Get St&d. Vend. Purchase Codes action.';

    //                 trigger OnAction();
    //                 var
    //                     StdVendPurchCode: Record "Standard Vendor Purchase Code";
    //                 begin
    //                     StdVendPurchCode.InsertPurchLines(Rec);
    //                 end;
    //             }
    //             action(CalculateInvoiceDiscount)
    //             {
    //                 AccessByPermission = TableData "Vendor Invoice Disc." = R;
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Calculate &Invoice Discount';
    //                 Image = CalculateInvoiceDiscount;
    //                 ToolTip = 'Calculate the invoice discount for the entire document.';

    //                 trigger OnAction();
    //                 begin
    //                     ApproveCalcInvDisc();
    //                     PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
    //                 end;
    //             }
    //             separator(Separator128)
    //             {
    //             }
    //             action(ApplyEntries)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Apply Entries';
    //                 Ellipsis = true;
    //                 Image = ApplyEntries;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ShortCutKey = 'Shift+F11';
    //                 ToolTip = 'Apply open entries for the relevant account type.';

    //                 trigger OnAction();
    //                 begin
    //                     CODEUNIT.RUN(CODEUNIT::"Purchase Header Apply", Rec);
    //                 end;
    //             }
    //             separator(Separator129)
    //             {
    //             }
    //             action(GetPostedDocumentLinesToReverse)
    //             {
    //                 Caption = 'Get Posted Doc&ument Lines to Reverse';
    //                 Ellipsis = true;
    //                 Image = ReverseLines;
    //                 ToolTip = 'Copy one or more posted purchase document lines in order to reverse the original order.';

    //                 trigger OnAction();
    //                 begin
    //                     Rec.GetPstdDocLinesToReverse()
    //                 end;
    //             }
    //             action("Copy Document")
    //             {
    //                 Caption = 'Copy Document';
    //                 Ellipsis = true;
    //                 Image = CopyDocument;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 ToolTip = 'Executes the Copy Document action.';

    //                 trigger OnAction();
    //                 begin
    //                     CopyPurchDoc.SetPurchHeader(Rec);
    //                     CopyPurchDoc.RUNMODAL();
    //                     CLEAR(CopyPurchDoc);
    //                     if Rec.GET(Rec."Document Type", Rec."No.") then;
    //                 end;
    //             }
    //             action(DocAttach)
    //             {
    //                 ApplicationArea = All;
    //                 Caption = 'Attachments';
    //                 Image = Attach;
    //                 ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
    //                 PromotedCategory = Category5;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 Promoted = true;
    //                 Visible = false;
    //                 trigger OnAction()
    //                 var
    //                     DocumentAttachmentDetails: Page "Document Attachment Details";
    //                     RecRef: RecordRef;
    //                 begin
    //                     RecRef.GetTable(Rec);
    //                     DocumentAttachmentDetails.OpenForRecRef(RecRef);
    //                     DocumentAttachmentDetails.RunModal();
    //                 end;
    //             }
    //             separator(Separator131)
    //             {
    //             }
    //             action("Move Negative Lines")
    //             {
    //                 Caption = 'Move Negative Lines';
    //                 Ellipsis = true;
    //                 Image = MoveNegativeLines;
    //                 ToolTip = 'Executes the Move Negative Lines action.';

    //                 trigger OnAction();
    //                 begin
    //                     CLEAR(MoveNegPurchLines);
    //                     MoveNegPurchLines.SetPurchHeader(Rec);
    //                     MoveNegPurchLines.RUNMODAL();
    //                     MoveNegPurchLines.ShowDocument();
    //                 end;
    //             }
    //             separator(Separator132)
    //             {
    //             }
    //             group(IncomingDocument)
    //             {
    //                 Caption = 'Incoming Document';
    //                 Image = Documents;
    //                 action(IncomingDocCard)
    //                 {
    //                     ApplicationArea = Basic, Suite;
    //                     Caption = 'View Incoming Document';
    //                     Enabled = HasIncomingDocument;
    //                     Image = ViewOrder;
    //                     ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

    //                     trigger OnAction();
    //                     var
    //                         IncomingDocument: Record "Incoming Document";
    //                     begin
    //                         IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
    //                     end;
    //                 }
    //                 action(SelectIncomingDoc)
    //                 {
    //                     AccessByPermission = TableData "Incoming Document" = R;
    //                     ApplicationArea = Basic, Suite;
    //                     Caption = 'Select Incoming Document';
    //                     Image = SelectLineToApply;
    //                     ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

    //                     trigger OnAction();
    //                     var
    //                         IncomingDocument: Record "Incoming Document";
    //                     begin
    //                         Rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RECORDID));
    //                     end;
    //                 }
    //                 action(IncomingDocAttachFile)
    //                 {
    //                     ApplicationArea = Basic, Suite;
    //                     Caption = 'Create Incoming Document from File';
    //                     Ellipsis = true;
    //                     Enabled = CreateIncomingDocumentEnabled;
    //                     Image = Attach;
    //                     ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';

    //                     trigger OnAction();
    //                     var
    //                         IncomingDocumentAttachment: Record "Incoming Document Attachment";
    //                     begin
    //                         IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
    //                     end;
    //                 }
    //                 action(RemoveIncomingDoc)
    //                 {
    //                     ApplicationArea = Basic, Suite;
    //                     Caption = 'Remove Incoming Document';
    //                     Enabled = HasIncomingDocument;
    //                     Image = RemoveLine;
    //                     ToolTip = 'Remove an external document that has been recorded, manually or automatically, and attached as a file to a document or ledger entry.';

    //                     trigger OnAction();
    //                     var
    //                         IncomingDocument: Record "Incoming Document";
    //                     begin
    //                         if IncomingDocument.GET(Rec."Incoming Document Entry No.") then
    //                             IncomingDocument.RemoveLinkToRelatedRecord();
    //                         Rec."Incoming Document Entry No." := 0;
    //                         Rec.MODIFY(true);
    //                     end;
    //                 }
    //             }
    //         }
    //         group("Request Approval")
    //         {
    //             Caption = 'Request Approval';
    //             Image = Approval;
    //             action(SendApprovalRequest)
    //             {
    //                 ApplicationArea = Suite;
    //                 Caption = 'Send A&pproval Request';
    //                 Enabled = NOT OpenApprovalEntriesExist;
    //                 Image = SendApprovalRequest;
    //                 Promoted = true;
    //                 PromotedCategory = Category5;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 ToolTip = 'Send an approval request.';

    //                 trigger OnAction();
    //                 var
    //                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //                 begin
    //                     if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
    //                         ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
    //                 end;
    //             }
    //             action(CancelApprovalRequest)
    //             {
    //                 ApplicationArea = Suite;
    //                 Caption = 'Cancel Approval Re&quest';
    //                 Enabled = CanCancelApprovalForRecord;
    //                 Image = CancelApprovalRequest;
    //                 Promoted = true;
    //                 PromotedCategory = Category5;
    //                 PromotedIsBig = true;
    //                 PromotedOnly = true;
    //                 ToolTip = 'Cancel the approval request.';

    //                 trigger OnAction();
    //                 var
    //                     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    //                 begin
    //                     ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
    //                 end;
    //             }
    //             separator(Separator144)
    //             {
    //             }
    //         }
    //         group("P&osting")
    //         {
    //             Caption = 'P&osting';
    //             Image = Post;
    //             action(Post)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'P&ost';
    //                 Image = PostOrder;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 ShortCutKey = 'F9';
    //                 ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

    //                 trigger OnAction();
    //                 begin
    //                     Post1(CODEUNIT::"Purch.-Post (Yes/No)");
    //                 end;
    //             }
    //             action(Preview)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Preview Posting';
    //                 Image = ViewPostedOrder;
    //                 ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

    //                 trigger OnAction();
    //                 var
    //                     PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
    //                 begin
    //                     PurchPostYesNo.Preview(Rec);
    //                 end;
    //             }
    //             action(TestReport)
    //             {
    //                 Caption = 'Test Report';
    //                 Ellipsis = true;
    //                 Image = TestReport;
    //                 ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

    //                 trigger OnAction();
    //                 begin
    //                     ReportPrint.PrintPurchHeader(Rec);
    //                 end;
    //             }
    //             action(PostAndPrint)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Post and &Print';
    //                 Image = PostPrint;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 ShortCutKey = 'Shift+F9';
    //                 ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
    //                 Visible = NOT IsOfficeAddin;

    //                 trigger OnAction();
    //                 begin
    //                     Post1(CODEUNIT::"Purch.-Post + Print");
    //                 end;
    //             }
    //             action("Remove From Job Queue")
    //             {
    //                 ApplicationArea = All;
    //                 Caption = 'Remove From Job Queue';
    //                 Image = RemoveLine;
    //                 ToolTip = 'Remove the scheduled processing of this record from the job queue.';
    //                 Visible = JobQueueVisible;

    //                 trigger OnAction();
    //                 begin
    //                     Rec.CancelBackgroundPosting();
    //                 end;
    //             }
    //         }
    //     }
    // }
    //------------------------------SHARMP16-------------------------
    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;

                // BC Upgrade MISHRS14 >>
                // Blocked action- Statistics as its marked for removal.
                // #if not CLEAN26
                //                 action(Statistics)
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     Caption = 'Statistics';
                //                     Image = Statistics;
                //                     ShortCutKey = 'F7';
                //                     ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                //                     ObsoleteReason = 'The statistics action will be replaced with the PurchaseStatistics action. The new action uses RunObject and does not run the action trigger. Use a page extension to modify the behaviour.';
                //                     ObsoleteState = Pending;
                //                     ObsoleteTag = '26.0';

                //                     trigger OnAction()
                //                     begin
                //                         // Rec.OpenDocumentStatistics();
                //                         CurrPage.PurchLines.Page.ForceTotalsCalculation();
                //                     end;
                //                 }
                // #endif
                // BC Upgrade MISHRS14 <<

                action(PurchaseStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Enabled = Rec."No." <> '';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    // #if CLEAN26
                    //                     Visible = true;
                    // #else
                    //                     Visible = false;
                    // #endif
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    RunObject = Page "Purchase Statistics";
                    RunPageOnRec = true;
                }
                action(Vendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Enabled = Rec."Buy-from Vendor No." <> '';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = field("Buy-from Vendor No."),
                                  "Date Filter" = field("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                }
                action(VendorStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Statistics';
                    Enabled = Rec."Buy-from Vendor No." <> '';
                    Image = Statistics;
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = field("Buy-from Vendor No."),
                                  "Date Filter" = field("Date Filter");
                    ToolTip = 'View statistical information, such as the value of posted entries, for the buy-from vendor on the purchase document.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SaveRecord();
                    end;
                }
                //HEI.07- //BC Upgrade GUNREM01 >> Added//BC Upgrade SHARMP16--PID854
                action("Purchase Additional")
                {
                    Caption = 'Purchase Additional';
                    Image = Purchase;
                    RunObject = Page "Purchase Additional";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Purchase Additional action.';
                }//BC Upgrade SHARMP16--PID854
                //BC Upgrade GUNREM01 << Added
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }//BC Upgrade SHARMP16--PID854
            }
        }
        area(processing)
        {
            group(IncomingDocument)//BC Upgrade SHARMP16--PID854
            {
                Caption = 'Incoming Document';
                action(IncomingDocCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Select';
                    Image = SelectLineToApply;
                    ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create from File';
                    Ellipsis = true;
                    Enabled = (Rec."Incoming Document Entry No." = 0) and (Rec."No." <> '');
                    Image = Attach;
                    ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';
                    //   Visible = CreateIncomingDocumentVisible;

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                    end;
                }
                action(IncomingDocEmailAttachment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create from Attachment';
                    Ellipsis = true;
                    // Enabled = IncomingDocEmailAttachmentEnabled;
                    Image = SendElectronicDocument;
                    ToolTip = 'Create an incoming document record by selecting an attachment from outlook email, and then link the incoming document record to the entry or document.';
                    // Visible = CreateIncomingDocFromEmailAttachment;

                    trigger OnAction()
                    begin
                        CurrPage.SaveRecord();
                        // OfficeMgt.InitiateSendToIncomingDocumentsWithPurchaseHeaderLink(Rec, Rec."Buy-from Vendor No.");
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    ToolTip = 'Remove an external document that has been recorded, manually or automatically, and attached as a file to a document or ledger entry.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        if IncomingDocument.Get(Rec."Incoming Document Entry No.") then
                            IncomingDocument.RemoveLinkToRelatedRecord();
                        Rec."Incoming Document Entry No." := 0;
                        Rec.Modify(true);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }//BC Upgrade SHARMP16--PID854
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Release)
            {
                Caption = 'Release';
                action("Re&lease")
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Enabled = Rec.Status <> Rec.Status::Released;
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //BC UPGRADE ATHUKUS01 FDD_STP007>>
                        ReleasePurchDoc.PerformManualRelease(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                        //BC UPGRADE ATHUKUS01 FDD_STP007<<
                    end;
                }
                //BC Upgrade GUNREM01 >> Added code
                action("Archive Document")//BC Upgrade SHARMP16--PID854
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ToolTip = 'Executes the Archi&ve Document action.';

                    trigger OnAction();
                    begin
                        //HEI.02>>
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(false);
                        //HEI.02<<
                    end;
                }
                //BC Upgrade GUNREM01 >> Added code
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //BC UPGRADE ATHUKUS01 FDD_STP007>>
                        ReleasePurchDoc.PerformManualReopen(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                        //BC UPGRADE ATHUKUS01 FDD_STP007<<
                    end;
                }
                action("Reject IC Purchase Invoice")//BC Upgrade SHARMP16--PID854
                {
                    ApplicationArea = Intercompany;
                    Caption = 'Reject IC Purchase Invoice';
                    //  Enabled = RejectICPurchaseInvoiceEnabled;
                    Image = Cancel;
                    ToolTip = 'Deletes the invoice and sends the rejection to the company that created it.';

                    trigger OnAction()
                    var
                        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        if not ICInboxOutboxMgt.IsPurchaseHeaderFromIncomingIC(Rec) then
                            exit;
                        // if Confirm(SureToRejectMsg) then
                        //     ICInboxOutboxMgt.RejectAcceptedPurchaseHeader(Rec);
                    end;
                }//BC Upgrade SHARMP16--PID854
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(GetRecurringPurchaseLines)//BC Upgrade SHARMP16--PID854
                {
                    ApplicationArea = Suite;
                    Caption = 'Get Recurring Purchase Lines';
                    Ellipsis = true;
                    Image = VendorCode;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ToolTip = 'Insert purchase document lines that you have set up for the vendor as recurring. Recurring purchase lines could be for a monthly replenishment order or a fixed freight expense.';

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Enabled = Rec."No." <> '';
                    Image = CopyDocument;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }//BC Upgrade SHARMP16--PID854
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount for the entire purchase invoice.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc();
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action("Create Tracking Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Tracking Information';
                    Image = ItemTracking;
                    ToolTip = 'Create item tracking information for the entire purchase invoice.';

                    trigger OnAction()
                    var
                        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                    begin
                        ItemTrackingDocMgt.CreateTrackingInfo(DATABASE::"Purchase Header", Rec."Document Type".AsInteger(), Rec."No.");
                    end;
                }
                action(MoveNegativeLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ToolTip = 'Prepare to create a replacement purchase order in a purchase return process.';

                    trigger OnAction()
                    begin
                        Clear(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RunModal();
                        MoveNegPurchLines.ShowDocument();
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalsPurchase(Rec);
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    // Enabled = not OpenApprovalEntriesExist and CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        PurchasesUtils: Codeunit "Purchases-Utils"; //BC Upgrade GUNREM01 >> added //BC Upgrade SHARMP16--PID854
                        PurchasesPayablesSetup: Record "Purchases & Payables Setup";//BC Upgrade GUNREM01 >> added //BC Upgrade SHARMP16--PID854
                        PurchaseLine: Record "Purchase Line";//BC Upgrade GUNREM01 >> added //BC Upgrade SHARMP16--PID854
                    begin
                        //BC Upgrade GUNREM01 >> added code
                        //HEI.11>>
                        PurchasesPayablesSetup.GET();
                        if (Rec."Document Type" = Rec."Document Type"::Invoice) and PurchasesPayablesSetup."Check Tolerance Approval FND" then begin
                            PurchaseLine.RESET();
                            PurchaseLine.SETCURRENTKEY("Document Type", "Document No.", Type, "No.");
                            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                            PurchaseLine.SETRANGE("Document No.", Rec."No.");
                            PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
                            //if PurchaseLine.FINDSET(true, false) then

                            // BC Upgrade MISHRS14 >>
                            // Remmoved false in IF statement due to warning as method has been depreceted - in action "SendApprovalRequest"
                            if PurchaseLine.FINDSET(true) then
                                // BC Upgrade MISHRS14 <<

                                repeat
                                    PurchasesUtils.SupressToleranceWaring();
                                    PurchasesUtils.CheckToleranceForEsker(PurchaseLine);
                                until PurchaseLine.NEXT() = 0;
                            COMMIT();
                        end;
                        //HEI.11<<
                        //BC Upgrade GUNREM01 >> added code
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;//BC Upgrade SHARMP16--PID854
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    //Enabled = CanCancelApprovalForRecord or CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            // group(Flow)
            // {
            //     Caption = 'Power Automate';
            //     Image = Flow;

            //     customaction(CreateFlowFromTemplate)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Create approval flow';
            //         ToolTip = 'Create a new flow in Power Automate from a list of relevant flow templates.';
            //         Visible = IsSaaS and IsPowerAutomatePrivacyNoticeApproved;
            //         CustomActionType = FlowTemplateGallery;
            //         FlowTemplateCategoryName = 'd365bc_approval_purchaseInvoice';
            //     }
            // }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    var
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                    begin
                        //                 trigger OnAction();
                        //                 begin
                        Post1(CODEUNIT::"Purch.-Post (Yes/No)");
                        //                 end; //, Enum::"Navigate After Posting"::"Posted Document");  //BC UPGRADE ATHUKUS01 FDDSTP_007
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ShortCutKey = 'Ctrl+Alt+F9';
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and print the document or journal. The values and quantities are posted to the related accounts.';
                    Visible = not IsOfficeAddin;

                    trigger OnAction()
                    var
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                    begin
                        Post1(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                // action(PostAndNew)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Post and New';
                //     Ellipsis = true;
                //     Image = PostOrder;
                //     ShortCutKey = 'Alt+F9';
                //     ToolTip = 'Post the purchase document and create a new, empty one.';

                //     trigger OnAction()
                //     begin
                //         PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", Enum::"Navigate After Posting"::"New Document");
                //     end;
                // }
                // action(PostBatch)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Post &Batch';
                //     Ellipsis = true;
                //     Image = PostBatch;
                //     ToolTip = 'Post several documents at once. A report request window opens where you can specify which documents to post.';

                //     trigger OnAction()
                //     begin
                //         VerifyTotal();
                //         REPORT.RunModal(REPORT::"Batch Post Purchase Invoices", true, true, Rec);
                //         CurrPage.Update(false);
                //     end;
                // }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled For Posting";

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                group(Category_Category6)
                {
                    Caption = 'Posting', Comment = 'Generated from the PromotedActionCategories property index 5.';
                    ShowAs = SplitButton;

                    actionref(Post_Promoted; Post)
                    {
                    }
                    actionref(Preview_Promoted; Preview)
                    {
                    }
                    // actionref(PostAndNew_Promoted; PostAndNew)
                    // {
                    // }
                    actionref(PostAndPrint_Promoted; PostAndPrint)
                    {
                    }
                    // actionref(PostBatch_Promoted; PostBatch)
                    // {
                    // }
                }
                group(Category_Category10)
                {
                    Caption = 'Release', Comment = 'Generated from the PromotedActionCategories property index 9.';
                    ShowAs = SplitButton;

                    actionref("Re&lease_Promoted"; "Re&lease")
                    {
                    }
                    actionref(Reopen_Promoted; Reopen)
                    {
                    }
                }
            }
            group(Category_Prepare)
            {
                Caption = 'Prepare';

                actionref(CopyDocument_Promoted; CopyDocument)
                {
                }
                actionref(GetRecurringPurchaseLines_Promoted; GetRecurringPurchaseLines)
                {
                }
                group("Category_Incoming Document")
                {
                    Caption = 'Incoming Document';

                    actionref(IncomingDocAttachFile_Promoted; IncomingDocAttachFile)
                    {
                    }
                    actionref(SelectIncomingDoc_Promoted; SelectIncomingDoc)
                    {
                    }
                    actionref(IncomingDocCard_Promoted; IncomingDocCard)
                    {
                    }
                    actionref(RemoveIncomingDoc_Promoted; RemoveIncomingDoc)
                    {
                    }
                    actionref(IncomingDocEmailAttachment_Promoted; IncomingDocEmailAttachment)
                    {
                    }
                }
                actionref(CalculateInvoiceDiscount_Promoted; CalculateInvoiceDiscount)
                {
                }
                actionref(MoveNegativeLines_Promoted; MoveNegativeLines)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Approve', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(Approve_Promoted; Approve)
                {
                }
                actionref(Reject_Promoted; Reject)
                {
                }
                actionref(Comment_Promoted; Comment)
                {
                }
                actionref(Delegate_Promoted; Delegate)
                {
                }
            }
            group(Category_Category8)
            {
                Caption = 'Request Approval', Comment = 'Generated from the PromotedActionCategories property index 7.';

                actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
                {
                }
                actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Invoice', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }

                // BC Upgrade MISHRS14 >>
                // Blocked the below action reference as action -Statistics is blocked above.
                // #if not CLEAN26
                //                 actionref(Statistics_Promoted; Statistics)
                //                 {
                //                     ObsoleteReason = 'The statistics action will be replaced with the PurchaseStatistics action. The new action uses RunObject and does not run the action trigger. Use a page extension to modify the behaviour.';
                //                     ObsoleteState = Pending;
                //                     ObsoleteTag = '26.0';
                //                 }
                // #else
                // BC Upgrade MISHRS14 <<

                actionref(PurchaseStatistics_Promoted; PurchaseStatistics)
                {
                }
                // #endif
                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }
                actionref(DocAttach_Promoted; DocAttach)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
                separator(Navigate_Separator)
                {
                }
                actionref(Vendor_Promoted; Vendor)
                {
                }
            }
            group(Category_Category7)
            {
                Caption = 'View', Comment = 'Generated from the PromotedActionCategories property index 6.';
            }
            group(Category_Category9)
            {
                Caption = 'Incoming Document', Comment = 'Generated from the PromotedActionCategories property index 8.';

            }
            group(Category_Category11)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 10.';
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //  CurrPage.IncomingDocAttachFactBox.Page.SetCurrentRecordID(Rec.RecordId);//BC Upgrade SHARMP16

        //StatusStyleTxt := Rec.GetStatusStyleText();
    end;

    trigger OnAfterGetCurrRecord();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        // SETFILTER("Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // // >>DITW18.00.06 DDR DIT-770 #1191
        // // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        // CALCFIELDS("Disc.Promo. Order Calculated");
        // // >>DITW15.00.00.34 DDR
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.

        SetControlAppearance();
        // CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);//BC Upgrade SHARMP16
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SAVERECORD();
        exit(Rec.ConfirmDeletion());
    end;

    trigger OnInit();
    begin
        SetExtDocNoMandatoryCondition();
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetBuyFromVendorFromFilter();

        // BC Upgrade SHUKLP03 >> Added Document Subtype Code
        //HEI.01>>
        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD(PurchasesPayablesSetup."Expense ClaimCMSubdoc Type FND"
 );
        Rec."Document Subtype Code FND" := PurchasesPayablesSetup."Expense ClaimCMSubdoc Type FND"
 ;
        //HEI.01<<
        // BC Upgrade SHUKLP03 << Added Document Subtype Code
    end;

    trigger OnOpenPage();
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
        // //<<FINXL7.00 RBE 20/03/2013
        // if recFinXLSetup.READPERMISSION then begin
        //     recPurchSetup.GET;
        //     txtTemplateName := '';
        //     if cduSingleInstaceFunctions.fctGetPurchCrMemoPages > 0 then begin
        //         txtTemplateName := cduSingleInstaceFunctions.fctGetPurchCrMemoTemplate;
        //         cduSingleInstaceFunctions.fctTrackPurchCrMemoPage(false, txtTemplateName);
        //     end
        //     else
        //         if recPurchSetup."Show Jnl. Template Selection" then begin
        //             recGenJournalTemplate.RESET;
        //             recGenJournalTemplate.SETRANGE(Type, recGenJournalTemplate.Type::Purchases);
        //             recGenJournalTemplate.SETRANGE("Credit Memo", true);

        //             if recGenJournalTemplate.COUNT > 1 then begin
        //                 blnJnlSelected := PAGE.RUNMODAL(0, recGenJournalTemplate) = ACTION::LookupOK;

        //                 if not blnJnlSelected then
        //                     ERROR('');
        //             end else
        //                 recGenJournalTemplate.FINDFIRST;
        //             txtTemplateName := recGenJournalTemplate.Name;
        //             cduSingleInstaceFunctions.fctTrackPurchCrMemoPage(false, txtTemplateName);
        //         end;
        // end;
        // //>>FINXL7.00 RBE 20/03/2013
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.

        SetDocNoVisible();
        IsOfficeAddin := OfficeMgt.IsAvailable();

        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
        // // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
        // //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        // if UserMgt.GetPurchasesTextFilter <> '' then begin
        //     FILTERGROUP(2);
        //     //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
        //     SETFILTER("Responsibility Center", UserMgt.GetPurchasesTextFilter);
        //     FILTERGROUP(0);
        // end;
        // // >>DITW18.00.06 DDR DIT-770 #1191
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if not DocumentIsPosted then
            exit(Rec.ConfirmCloseUnposted());
    end;

    var
        recGenJournalTemplate: Record "Gen. Journal Template";
        // recFinXLSetup: Record "Finance XL Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        recPurchSetup: Record "Purchases & Payables Setup";
        StdVendPurchCode: Record "Standard Vendor Purchase Code";
        UserSetup: Record "User Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ArchiveManagement: Codeunit ArchiveManagement;
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        // cduSingleInstaceFunctions: Codeunit "Single Instance Functions";
        cduReleasePurchDoc: Codeunit "Release Purchase Document";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        blnJnlSelected: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        DocNoVisible: Boolean;
        DocumentIsPosted: Boolean;
        HasIncomingDocument: Boolean;
        IsOfficeAddin: Boolean;

        JobQueueVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        VendorCreditMemoNoMandatory: Boolean;
        OpenPostedPurchCrMemoQst: Label 'The credit memo has been posted and archived.\\Do you want to open the posted credit memo from the Posted Purchase Credit Memos window?';
        Text0001: Label '"You cannot modify the field- ''%1''. "';
        Text2014411: Label 'Do you want to cancel the approval request for %1 %2?';
        Text2014412: Label 'Do you want to send the approval request for %1 %2?';
        txtTemplateName: Text;

    local procedure Post1(PostingCodeunitID: Integer);
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsPosted := not PurchaseHeader.GET(Rec."Document Type", Rec."No.");

        if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.CLOSE();
        CurrPage.UPDATE(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        if IsOfficeAddin then begin
            PurchCrMemoHdr.SETRANGE("Pre-Assigned No.", Rec."No.");
            if PurchCrMemoHdr.FINDFIRST() then
                PAGE.RUN(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
        end else
            if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                ShowPostedConfirmationMessage();
    end;

    local procedure ApproveCalcInvDisc();
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
    end;

    local procedure PurchaserCodeOnAfterValidate();
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.UPDATE();
    end;

    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.UPDATE();
    end;

    local procedure PricesIncludingVATOnAfterValid();
    begin
        /*
        CurrPage.UPDATE;
        //<<FINXL7.00 RBE 06/08/2013
        IF recFinXLSetup.READPERMISSION THEN BEGIN
          IF recPurchSetup."Check Totals on Purch. Inv./CM" THEN BEGIN
            cduReleasePurchDoc.fctSetParameters(TRUE,FALSE);
            cduReleasePurchDoc.RUN(Rec);
            CurrPage.PurchLines.PAGE.MakeTotals;
          end;
        end;
        //>>FINXL7.00 RBE 06/08/2013
        */

    end;

    local procedure SetDocNoVisible();
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::"Credit Memo", Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.GET();
        VendorCreditMemoNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');
        SetExtDocNoMandatoryCondition();

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        PurchCrMemoHdr.SETRANGE("Pre-Assigned No.", Rec."No.");
        if PurchCrMemoHdr.FINDFIRST() then
            if InstructionMgt.ShowConfirm(OpenPostedPurchCrMemoQst, InstructionMgt.ShowPostedConfirmationMessageCode()) then
                PAGE.RUN(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
    end;

    local procedure StatusOnAfterValidate();
    begin
        // <<DITW15.00.00.34 DDR 17/06/2009
        CurrPage.UPDATE(false);
    end;

    local procedure StatusOnValidate();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
        // // <<DITW15.00.00.34 DDR 17/06/2009
        // if xRec.Status = Rec.Status then
        //     exit;

        // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        // if (xRec.Status = Rec.Status::Open) or (Status = Status::Released) then
        //     ReleasePurchDoc.DocStatusRelease(xRec, Rec)
        // else begin
        //     if Status = Status::Open then
        //         ReleasePurchDoc.DocStatusOpen(xRec, Rec)
        //     else
        //         // >>DITW15.00.00.39 DDR #1330 #1407
        //         TESTFIELD(Status, xRec.Status);
        // end;
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
    end;

    local procedure UpdateAfterChangingHeader();
    var
        PurchLine: Record "Purchase Line";
    begin
        /*
        //<<FINXL7.00 RBE 06/08/2013
        IF recPurchSetup."Check Totals on Purch. Inv./CM" THEN BEGIN
          PurchLine.SETRANGE("Document Type","Document Type");
          PurchLine.SETRANGE("Document No.","No.");
          PurchLine.SETFILTER(Type,'<>%1',PurchLine.Type::" ");
          PurchLine.SETFILTER(Quantity,'<>0');
          IF PurchLine.FIND('-') THEN BEGIN
            cduReleasePurchDoc.fctSetParameters(TRUE,FALSE);
            cduReleasePurchDoc.RUN(Rec);
            CurrPage.PurchLines.PAGE.MakeTotals;
          end;
        end;
        //>>FINXL7.00 RBE 06/08/2013
        */

    end;
}

