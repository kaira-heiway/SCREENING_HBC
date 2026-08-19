
page 52004 "NPO Purchase Invoice"
{
    //  DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //       DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //       DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                      New calling functions to insert (item) charges
    //       DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    //       DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //       DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //       DITW15.00.00.20 DDR 06/06/2008 Certification rules
    //       DITW15.00.00.21 DDR 25/06/2008 Added menu "Get Shipping agent documents" into button "Function"
    //       DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    //       DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                                      Added fields "Vendor DTax Group Code" into Invoicing tab
    //       DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    //       DITW15.00.00.34 DDR 17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                      Changed Editable "Status" field
    //                                      Added functions DocStatusRelease(),DocStatusOpen(),
    //       DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    //       DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                       CEL 13/08/2010           Modification RTC buttons
    //       DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                                 Added parameter line function RTCActionNewLine() into RTCNewLine button
    //       DITW15.00.00.39 DDR 27/04/2011 issue 1323 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                      Added to call function StdVendPurchCode.AutoInsertPurchLines()
    //                                        from OnAfterValidate trigger field "Sell-to Customer No."
    //       DITW15.00.00.39 DDR 10/05/2011 issue 1330 Upgrade editable Status to work with Approval requests
    //                                                 Remove 'ShowConfirmMsg' parameter function DocStatusOpen();
    //                                                 Modified functions DocStatusOpen(),DocStatusRelease()
    //                                                 Modified validate trigger field "Status"
    //                           27/07/2011 issue 1407 Added flowfields "Disc.Promo. Order Calculated" (see "Zoom view)
    //                                                 Moved/Deleted functions into codeunit414 Release Sales Document
    //                                                   DocStatusRelease(),DocStatusOpen()
    //       DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                                    Added to insert first line automatically
    //                           19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    //       DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                        call function SetDisableRefreshLines() before each report
    //                                                        (don't use the <RunObject> property)
    //       DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                                   Added fields into 'Service/Contract' tab
    //                                                     "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                                   Moved "Building No." into 'Service/Contract' tab
    //       DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                                   Added menu 'SSCC Tracking Lines' in 'Line' buttton
    //       DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    //       DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    //       DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //       DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Added Field "Vendor Posting Group"
    //       DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //       DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    //       DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    //       DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //                                                TEMP Disabled Call function UpdateVATAmounts()
    //       DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    //       FINXL7.00 RBE 20/03/2013 : Added field "Your Reference","Posting Description" on page
    //                                      "Currency Code" and "On Hold" moved to the first group
    //                                      "Jnl Template Selection" when opening form
    //       FINXL7.00 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    //       FINXL7.00 KLU 03/10/2013 : Check for existing template name
    //       FINXL8.00.001 RBE 01/12/2014: Hide factbox: "Purch. Inv./Cr.M. Info"
    //       FINXL8.00.001 BSA 16/06/2015 #124 : Added Field "OGM"

    //       DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    //       DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                                 Rename Field Service contract Type => Contract Type
    //       DITW19.00.07 MVN 25/01/2016 DIT-770 #1740 Upgrade
    //       DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" under "Invoicing" tab

    //       DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //       DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //       FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    //       FINXL9.00.000.01 ACH 05/01/2016 : Added factbox to show mandatory Dimensions for G/L account
    //       FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4

    //       HEI.01 FDD PTPGAP014 - No POGR lines in NPO invoice , IBM NAIKH01 27-06-2017
    //         # Created  a new page that is the Replica of Page 51 - "Purchase Invoice" to show the Purchase Invoice with Document SubType 'NPO'

    //       HEI.02 PTPGAP066 IBM SOICAD01 26.07.2017 Purchase to Pay  Bank account for payment
    //         # New field Vendor Bank Account

    //       HEI.03 FDD PTPGAP014 - No POGR lines in NPO invoice , IBM NAIKH01 14.08.2017
    //         # Added a new code in the trigger "OnNewRecord".
    //         # Changed the SourceTableView of the page Property
    //       HEI.04 FDD-PTPGAP013/Defect309 28.09.2017>>
    //         # "Payment Status" Default value to be Pending Review.
    //         # Aligned Payment Status field on page

    //       HEI.05 CHG0255417 IBM.LS 15.10.2018
    //         # Code added to restrict the field modification.
    //       HEI.06 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //         # Made Field "Vendor Posting Group" non-editable
    //       HEI.07 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # VAT Centime - part 2 - Purchases
    //         # New Page Action created "Purchase Additional"
    //       HEI.08 CHG2204474 IBM SRIVAS07 19.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //         # Added code in Post Action.
    //       HEI.09 CHG2204474 IBM SRIVAS07 26.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //         # Added code in Post Action.
    //         # Added code in PostAndPrint Action.
    //       HEI.10 CHG2204474 IBM SRIVAS07 16.10.23 - Error message displayed when document date is in the future in all invoice processing pages
    //         # Added code in Post Action.
    //         # Added code in PostAndPrint Action.
    //       HEI.11 CHG2221624 HB3614 IBM SRIVAS07 15.07.2024 # Block Payment for Invoices with Price Difference higher than the tolerance
    //         # Code Added to SendApprovalRequest - OnAction()
    //BC Upgrade GUNREM01  >>
    // #Created  a new page that is the Replica of Page 51 - "Purchase Invoice" to show the Purchase Invoice with Document SubType 'NPO'
    // Added HEI related code from NAV.
    // new functions there compare to NAV and BC.

    // BC Upgrade MISHRS14 >>
    // Blocked - part("Attached Documents"; "Document Attachment Factbox") as its marked for removal and has been replaced 
    // Blocked action- Statistics as its marked for removal.
    // Blocked the action- actionref(Statistics_Promoted; Statistics) as action -Statistics is blocked.
    // Created variable - FlowServiceManagement to call -GetPowerAutomatePrivacyNoticeId as it has been moved to new codeunit
    // Remmoved false in IF statement due to warning as method has been depreceted - in action "SendApprovalRequest"
    // BC Upgrade MISHRS14 <<

    //BC UPGRADE ATHUKUS01 FDDSTP_007 <<
    //1.Added Dimensions Factbox in the page.
    //2.Added new fields "Doc. Amount Incl. VAT IBM" and "Doc. Amount VAT IBM" in the page.
    //3.Added application area all in Vendor bank account field.
    //4.Added Post document functions in the page.
    //5.Commented After posting Enum redirection code in the page.. 	
    //6.Added NAV Custome code in Release action & Base code for release action.
    //7.Added Base code for Reopen action.
    //8.Document stataus is made non editable.
    //BC UPGRADE ATHUKUS01 FDD_STP007<<


    //BC UPGRADE ATHUKUS01 FDDSTP_007 >>

    Caption = 'NPO Purchase Invoice';
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = basic, suite;
    SourceTable = "Purchase Header";
    // SourceTableView = where("Document Type" = filter(Invoice)); 
    SourceTableView = sorting("Document Type", "No.") where("Document Type" = filter(Invoice)); //BC Upgrade GUNREM01 Added

    AdditionalSearchTerms = 'Vendor Invoice, Procurement Invoice, Vendor Bill, Purchase Bill, Supplier Invoice, Acquisition Bill, Buying Invoice, Supplier Bill, Invoice Purchase, Merchant Invoice, Trade Invoice';
    // BC Upgrade MISHRS14 >>
    UsageCategory = Documents;
    // BC Upgrade MISHRS14 <<

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
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                    Importance = Additional;
                    NotBlank = true;
                    ToolTip = 'Specifies the number of the vendor who delivers the products.';

                    trigger OnValidate()
                    begin
                        IsPurchaseLinesEditable := Rec.PurchaseLinesEditable();
                        Rec.OnAfterValidateBuyFromVendorNo(Rec, xRec);
                        CurrPage.Update();
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the vendor who delivers the products.';

                    trigger OnValidate()
                    var
                        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
                    begin
                        Rec.OnAfterValidateBuyFromVendorNo(Rec, xRec);

                        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
                            PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.Update();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        exit(Rec.LookupBuyFromVendorName(Text));
                    end;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                    Visible = false;
                }
                group("Buy-from")
                {
                    Caption = 'Buy-from';
                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the address of the vendor who ships the items.';
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the vendor on the purchase document.';
                    }
                    group(Control93)
                    {
                        ShowCaption = false;
                        Visible = IsBuyFromCountyVisible;
                        field("Buy-from County"; Rec."Buy-from County")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'County';
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the state, province or county of the address.';
                        }
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Country/Region';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the country or region of the address.';

                        trigger OnValidate()
                        begin
                            IsBuyFromCountyVisible := FormatAddress.UseCounty(Rec."Buy-from Country/Region Code");
                        end;
                    }
                    field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of your contact at the vendor.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            if not Rec.BuyfromContactLookup() then
                                exit(false);
                            Text := Rec."Buy-from Contact No.";
                            CurrPage.Update();
                            exit(true);
                        end;

                        trigger OnValidate()
                        begin
                            if xRec."Buy-from Contact No." <> Rec."Buy-from Contact No." then
                                CurrPage.Update();
                        end;
                    }
                    field(BuyFromContactPhoneNo; BuyFromContact."Phone No.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Phone No.';
                        Importance = Additional;
                        Editable = false;
                        ExtendedDatatype = PhoneNo;
                        ToolTip = 'Specifies the telephone number of the vendor contact person.';
                    }
                    field(BuyFromContactMobilePhoneNo; BuyFromContact."Mobile Phone No.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Mobile Phone No.';
                        Importance = Additional;
                        Editable = false;
                        ExtendedDatatype = PhoneNo;
                        ToolTip = 'Specifies the mobile telephone number of the vendor contact person.';
                    }
                    field(BuyFromContactEmail; BuyFromContact."E-Mail")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Email';
                        Importance = Additional;
                        Editable = false;
                        ExtendedDatatype = EMail;
                        ToolTip = 'Specifies the email address of the vendor contact person.';
                    }
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contact';
                    Editable = Rec."Buy-from Vendor No." <> '';
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupBuyFromContact();
                        CurrPage.Update();
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Invoice Received Date"; Rec."Invoice Received Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date when the related document was received.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';

                    trigger OnValidate()
                    begin
                        SaveInvoiceDiscountAmount();
                    end;
                }
                field("VAT Reporting Date"; Rec."VAT Reporting Date")
                {
                    ApplicationArea = VAT;
                    Editable = VATDateEnabled;
                    Visible = VATDateEnabled;
                    ToolTip = 'Specifies the date used to include entries on VAT reports in a VAT period. This is either the date that the document was created or posted, depending on your setting on the General Ledger Setup page.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields.';
                    trigger OnValidate();
                    begin
                        //HEI.05>>
                        UserSetup.GET(USERID);
                        if (Rec."Due Date" <> xRec."Due Date") and (xRec."Due Date" <> 0D) then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Due Date"));
                        end;
                        //HEI.05<<
                    end;
                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the incoming document that this purchase document is created for.';
                    Visible = false;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = VendorInvoiceNoMandatory;
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate();
                    end;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the vendor''s order number.';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = RelationshipMgmt;
                    Importance = Additional;
                    ToolTip = 'Specifies the campaign number the document is linked to.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Alternate Vendor Address Code';
                    Importance = Additional;
                    ToolTip = 'Specifies the order address of the related vendor.';
                    Enabled = Rec."Buy-from Vendor No." <> '';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    StyleExpr = StatusStyleTxt;
                    Editable = false;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                //BC UPGRADE ATHUKUS01 FDDSTP_007<< Base fields 
                // field(DocAmount; Rec."Doc. Amount Incl. VAT")
                // {
                //     ApplicationArea = Basic, Suite;
                //     BlankZero = true;
                //     Enabled = DocAmountEnable;
                //     Visible = DocAmountEnable;
                //     ShowMandatory = true;
                //     ToolTip = 'Specifies the value of the Doc. Amount Incl. VAT field.';
                // }
                // field(DocAmountVAT; Rec."Doc. Amount VAT")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Enabled = DocAmountEnable;
                //     Visible = DocAmountEnable;
                //     ToolTip = 'Specifies the value of the Doc. Amount VAT field.';
                // }

                //BC UPGRADE ATHUKUS01 FDDSTP_007>>
                //BC UPGRADE ATHKUS01 FDD STP 007>> IBM Fields  

                field("Doc. Amount Incl. VAT IBM"; Rec."Doc. Amount Incl. VAT IBM FND")
                {
                    Caption = 'Doc. Amount Incl. VAT';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Doc. Amount Incl. VAT field.';

                }
                field("Doc. Amount VAT IBM"; Rec."Doc. Amount VAT IBM FND")
                {
                    Caption = 'Doc. Amount VAT';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Doc. Amount VAT field.';
                }
                //BC UPGRADE ATHKUS01 FDD STP 007>> IBM Fields

                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase invoices.';
                    Visible = JobQueuesUsed;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the language to be used on printouts for this document.';
                    Visible = false;
                }
                field("Format Region"; Rec."Format Region")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the format to be used on printouts for this document.';
                    Visible = false;
                }
            }
            part(PurchLines; "NPO Purch. Invoice Subform")
            {
                ApplicationArea = Basic, Suite;
                Editable = IsPurchaseLinesEditable;
                Enabled = IsPurchaseLinesEditable;
                SubPageLink = "Document No." = field("No.");
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

                    trigger OnAssistEdit()
                    var
                        IsHandled: Boolean;
                    begin
                        IsHandled := false;
                        OnBeforeCurrencyCodeOnAssistEdit(Rec, xRec, IsHandled);
                        if IsHandled then
                            exit;

                        Clear(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate());
                        if ChangeExchangeRate.RunModal() = ACTION::OK then begin
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter());
                            SaveInvoiceDiscountAmount();
                        end;
                        Clear(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect to receive the items on the purchase document.';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = VAT;
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid();
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';

                    trigger OnValidate()
                    var
                        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
                    begin
                        CurrPage.SaveRecord();

                        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
                            PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = IsPostingGroupEditable;
                    Editable = false; //HEI.06 //BC Upgrade GUNREM01 added 
                    Importance = Additional;
                    ToolTip = 'Specifies the vendor''s market type to link business transactions to.';

                }
                // BC Upgrade VAMSIU01 added field >>
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade VAMSIU01 added field <<

                //BC Upgrade GUNREM01 >> added code
                field("Payment Status"; Rec."Payment Status FND")
                {
                    ToolTip = 'Specifies the value of the Payment Status field.';

                    trigger OnValidate();
                    begin
                        //HEI.05>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Status FND" <> xRec."Payment Status FND") then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Status FND"));
                        end;
                        //HEI.05<<
                    end;
                }
                //BC Upgrade GUNREM01 << added code
                //BC Upgrade GUNREM01 >> added code
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                    trigger OnValidate();
                    begin
                        //HEI.05>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Terms Code" <> xRec."Payment Terms Code") and (xRec."Payment Terms Code" <> '') then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Terms Code"));
                        end;
                        //HEI.05<<
                    end;
                }
                //BC Upgrade GUNREM01 << added code
                //BC Upgrade GUNREM01 >> added code
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                    Visible = IsPaymentMethodCodeVisible;
                    trigger OnValidate();
                    begin
                        //HEI.05>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Method Code" <> xRec."Payment Method Code") and (xRec."Payment Method Code" <> '') then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Method Code"));
                        end;
                        //HEI.05<<
                    end;
                }
                //BC Upgrade GUNREM01 << added code
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the document.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Journal Templ. Name"; Rec."Journal Templ. Name")
                {
                    ApplicationArea = BasicBE;
                    ToolTip = 'Specifies the name of the journal template in which the purchase header is to be posted.';
                    Visible = IsJournalTemplNameVisible;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = SalesTax;
                    ToolTip = 'Specifies if the customer or vendor is liable for sales tax.';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = SalesTax;
                    ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';

                    trigger OnValidate()
                    begin
                        CurrPage.PurchLines.PAGE.RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the vendor who sent the purchase invoice.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
            }
            group("Shipping and Payment")
            {
                Caption = 'Shipping and Payment';
                group(Control53)
                {
                    ShowCaption = false;
                    group(Control78)
                    {
                        ShowCaption = false;
                        field(ShippingOptionWithLocation; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Ship-to';
                            HideValue = not ShowShippingOptionsWithLocation and (ShipToOptions = ShipToOptions::Location);
                            OptionCaption = 'Default (Company Address),Location,Custom Address';
                            ToolTip = 'Specifies the address that the products on the purchase document are shipped to. Default (Company Address): The same as the company address specified in the Company Information window. Location: One of the company''s location addresses. Custom Address: Any ship-to address that you specify in the fields below.';

                            trigger OnValidate()
                            begin
                                ValidateShippingOption();
                            end;
                        }
                        group(Control79)
                        {
                            ShowCaption = false;
                            group(Control81)
                            {
                                ShowCaption = false;
                                Visible = ShipToOptions = ShipToOptions::Location;
                                field("Location Code"; Rec."Location Code")
                                {
                                    ApplicationArea = Location;
                                    ToolTip = 'Specifies the location where the items are to be placed when they are received. This field acts as the default location for new lines. You can update the location code for individual lines as needed.';
                                }
                            }
                            field("Ship-to Name"; Rec."Ship-to Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Name';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the name of the company at the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Name 2"; Rec."Ship-to Name 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Name 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies an additional part of the name of the company at the address that you want the items on the purchase document to be shipped to.';
                                QuickEntry = false;
                                Visible = false;
                            }
                            field("Ship-to Address"; Rec."Ship-to Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Address 2"; Rec."Ship-to Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies additional address information.';
                            }
                            field("Ship-to City"; Rec."Ship-to City")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'City';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the city of the address that you want the items on the purchase document to be shipped to.';
                            }
                            group(Control199)
                            {
                                ShowCaption = false;
                                Visible = IsShipToCountyVisible;
                                field("Ship-to County"; Rec."Ship-to County")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'County';
                                    Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                    Importance = Additional;
                                    QuickEntry = false;
                                    ToolTip = 'Specifies the state, province or county of the address.';
                                }
                            }
                            field("Ship-to Post Code"; Rec."Ship-to Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Post Code';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the postal code of the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Country/Region';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the country/region code of the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Phone No."; Rec."Ship-to Phone No.")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Phone No.';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the telephone number of the company''s shipping address.';
                            }
                            field("Ship-to Contact"; Rec."Ship-to Contact")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Contact';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the name of a contact person for the address of the address that you want the items on the purchase document to be shipped to.';
                            }
                            //BC Upgrade GUNREM01>> added field
                            field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
                            {
                                ApplicationArea = All; // BC Upgrade ATHUKUS01 FDD STP 007
                                ToolTip = 'Specifies the value of the Vendor Bank Account field.';
                            }
                            //BC Upgrade GUNREM01>> added field
                        }
                    }
                }
                group(Control56)
                {
                    ShowCaption = false;
                    field(PayToOptions; PayToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pay-to';
                        OptionCaption = 'Default (Vendor),Another Vendor,Custom Address';
                        ToolTip = 'Specifies the vendor that the purchase document will be paid to. Default (Vendor): The same as the vendor on the purchase document. Another Vendor: Any vendor that you specify in the fields below.';

                        trigger OnValidate()
                        begin
                            if PayToOptions = PayToOptions::"Default (Vendor)" then
                                Rec.Validate("Pay-to Vendor No.", Rec."Buy-from Vendor No.");
                        end;
                    }
                    group(Control88)
                    {
                        ShowCaption = false;
                        Visible = not (PayToOptions = PayToOptions::"Default (Vendor)");
                        field("Pay-to Name"; Rec."Pay-to Name")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Name';
                            Editable = PayToOptions = PayToOptions::"Another Vendor";
                            Enabled = PayToOptions = PayToOptions::"Another Vendor";
                            Importance = Promoted;
                            NotBlank = true;
                            ToolTip = 'Specifies the name of the vendor sending the invoice.';

                            trigger OnValidate()
                            var
                                ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
                            begin
                                //BC Upgrade GUNREM01 >> added code 
                                //HEI.05>>
                                UserSetup.GET(USERID);
                                if (Rec."Pay-to Name" <> xRec."Pay-to Name") and (xRec."Pay-to Name" <> '') then begin
                                    ERROR(Text0001, Rec.FIELDCAPTION("Pay-to Name"));
                                end;
                                //HEI.05<<
                                //BC Upgrade GUNREM01 << added code 
                                if Rec.GetFilter("Pay-to Vendor No.") = xRec."Pay-to Vendor No." then
                                    if Rec."Pay-to Vendor No." <> xRec."Pay-to Vendor No." then
                                        Rec.SetRange("Pay-to Vendor No.");

                                //  CurrPage.SaveRecord();
                                if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
                                    PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

                                CurrPage.Update(false);
                            end;
                        }
                        field("Pay-to Address"; Rec."Pay-to Address")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the address of the vendor sending the invoice.';
                        }
                        field("Pay-to Address 2"; Rec."Pay-to Address 2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address 2';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies additional address information.';
                        }
                        field("Pay-to City"; Rec."Pay-to City")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'City';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the city of the vendor on the purchase document.';
                        }
                        group(Control103)
                        {
                            ShowCaption = false;
                            Visible = IsPayToCountyVisible;
                            field("Pay-to County"; Rec."Pay-to County")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'County';
                                Editable = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                                Enabled = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the state, province or county of the address.';
                            }
                        }
                        field("Pay-to Post Code"; Rec."Pay-to Post Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Post Code';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the postal code.';
                        }
                        field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Country/Region';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the country or region of the address.';

                            trigger OnValidate()
                            begin
                                IsPayToCountyVisible := FormatAddress.UseCounty(Rec."Pay-to Country/Region Code");
                            end;
                        }
                        field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact No.';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            ToolTip = 'Specifies the number of the contact who sends the invoice.';
                        }
                        field(PayToContactPhoneNo; PayToContact."Phone No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Phone No.';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = PhoneNo;
                            ToolTip = 'Specifies the telephone number of the vendor contact person.';
                        }
                        field(PayToContactMobilePhoneNo; PayToContact."Mobile Phone No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Mobile Phone No.';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = PhoneNo;
                            ToolTip = 'Specifies the mobile telephone number of the vendor contact person.';
                        }
                        field(PayToContactEmail; PayToContact."E-Mail")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Email';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = Email;
                            ToolTip = 'Specifies the email address of the vendor contact person.';
                        }
                        field("Pay-to Contact"; Rec."Pay-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") or (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                        }

                    }
                }
                group("Remit-to")
                {
                    ShowCaption = false;
                    field("Remit-to Code"; Rec."Remit-to Code")
                    {
                        Editable = Rec."Buy-from Vendor No." <> '';
                        ApplicationArea = Basic, Suite;
                        Importance = Promoted;
                        ToolTip = 'Specifies the code for the vendor''s remit address for this invoice.';

                        trigger OnValidate()
                        begin
                            FillRemitToFields();
                        end;
                    }
                    group("Remit-to information")
                    {
                        ShowCaption = false;
                        Visible = Rec."Remit-to Code" <> '';
                        field("Remit-to Name"; RemitAddressBuffer.Name)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Name';
                            Editable = false;
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the name of the company at the address that you want the invoice to be remitted to.';
                        }
                        field("Remit-to Address"; RemitAddressBuffer.Address)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address';
                            Editable = false;
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the address that you want the items on the purchase document to be remitted to.';
                        }
                        field("Remit-to Address 2"; RemitAddressBuffer."Address 2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address 2';
                            Editable = false;
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies additional address information.';
                        }
                        field("Remit-to City"; RemitAddressBuffer.City)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'City';
                            Editable = false;
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the city of the address that you want the items on the purchase document to be remitted to.';
                        }
                        group("Remit-to County group")
                        {
                            ShowCaption = false;
                            Visible = IsRemitToCountyVisible;
                            field("Remit-to County"; RemitAddressBuffer.County)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'County';
                                Editable = false;
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the state, province or county of the address.';
                            }
                        }
                        field("Remit-to Post Code"; RemitAddressBuffer."Post Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Post Code';
                            Editable = false;
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the postal code of the address that you want the items on the purchase document to be remitted to.';
                        }
                        field("Remit-to Country/Region Code"; RemitAddressBuffer."Country/Region Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Country/Region';
                            Editable = false;
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the country/region code of the address that you want the items on the purchase document to be remitted to.';
                        }
                        field("Remit-to Contact"; RemitAddressBuffer.Contact)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact';
                            Editable = false;
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the name of a contact person for the address that you want the items on the purchase document to be remitted to.';
                        }
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies a specification of the document''s transaction, for the purpose of reporting to INTRASTAT.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies the type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region, for reporting to Intrastat.';
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies the destination country or region for the purpose of Intrastat reporting.';
                }
            }
        }
        area(factboxes)
        {
            //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
            part("Dimensions FactBox"; "Dimensions FactBox")
            {
                ApplicationArea = All;
                Provider = PurchLines;
                Caption = 'G/L Account Mandatory Dimensions';
                SubPageView = WHERE("Table ID" = CONST(15), "Value Posting" = CONST("Code Mandatory"));
                SubPageLink = "No." = FIELD("No.");
            }
            //BC UPGRADE ATHUKUS01 FDDSTP_007 <<

            part(PurchaseDocCheckFactbox; "Purch. Doc. Check Factbox")
            {
                ApplicationArea = All;
                Caption = 'Document Check';
                Visible = PurchaseDocCheckFactboxVisible;
                SubPageLink = "No." = field("No."),
                              "Document Type" = field("Document Type");
            }

            // BC Upgrade MISHRS14 <<
            // Blocked below part as Document Attachment Factbox is replaced and marked for removal

            // #if not CLEAN25
            //             part("Attached Documents"; "Document Attachment Factbox")
            //             {
            //                 ObsoleteTag = '25.0';
            //                 ObsoleteState = Pending;
            //                 ObsoleteReason = 'The "Document Attachment FactBox" has been replaced by "Doc. Attachment List Factbox", which supports multiple files upload.';
            //                 ApplicationArea = All;
            //                 Visible = false;
            //                 Caption = 'Attachments';
            //                 SubPageLink = "Table ID" = const(Database::"Purchase Header"),
            //                               "Document Type" = field("Document Type"),
            //                               "No." = field("No.");
            //             }
            // #endif
            // BC Upgrade MISHRS14 <<

            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Purchase Header"),
                              "Document Type" = field("Document Type"),
                              "No." = field("No.");
            }
            part(Control27; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(38),
                              "Document Type" = field("Document Type"),
                              "Document No." = field("No."),
                              Status = const(Open);
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Buy-from Vendor No."),
                              "Date Filter" = field("Date Filter");
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = not IsOfficeAddin;
            }
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Pay-to Vendor No."),
                              "Date Filter" = field("Date Filter");
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Buy-from Vendor No."),
                              "Date Filter" = field("Date Filter");
                Visible = false;
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = field("Pay-to Vendor No."),
                              "Date Filter" = field("Date Filter");
                Visible = false;
            }
            part(Control3; "Purchase Line FactBox")
            {
                ApplicationArea = Basic, Suite;
                Provider = PurchLines;
                SubPageLink = "Document Type" = field("Document Type"),
                              "Document No." = field("Document No."),
                              "Line No." = field("Line No.");
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
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
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
                //HEI.07- //BC Upgrade GUNREM01 >> Added
                action("Purchase Additional")
                {
                    Caption = 'Purchase Additional';
                    Image = Purchase;
                    RunObject = Page "Purchase Additional";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Purchase Additional action.';
                }
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
                }
            }
        }
        area(processing)
        {
            group(IncomingDocument)
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
                    Visible = CreateIncomingDocumentVisible;

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
                    Enabled = IncomingDocEmailAttachmentEnabled;
                    Image = SendElectronicDocument;
                    ToolTip = 'Create an incoming document record by selecting an attachment from outlook email, and then link the incoming document record to the entry or document.';
                    Visible = CreateIncomingDocFromEmailAttachment;

                    trigger OnAction()
                    begin
                        CurrPage.SaveRecord();
                        OfficeMgt.InitiateSendToIncomingDocumentsWithPurchaseHeaderLink(Rec, Rec."Buy-from Vendor No.");
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
                }
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
                action("Archive Document")
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
                action("Reject IC Purchase Invoice")
                {
                    ApplicationArea = Intercompany;
                    Caption = 'Reject IC Purchase Invoice';
                    Enabled = RejectICPurchaseInvoiceEnabled;
                    Image = Cancel;
                    ToolTip = 'Deletes the invoice and sends the rejection to the company that created it.';

                    trigger OnAction()
                    var
                        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
                    begin
                        if not ICInboxOutboxMgt.IsPurchaseHeaderFromIncomingIC(Rec) then
                            exit;
                        if Confirm(SureToRejectMsg) then
                            ICInboxOutboxMgt.RejectAcceptedPurchaseHeader(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(GetRecurringPurchaseLines)
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
                    begin
                        Rec.CopyDocument();
                        if Rec.Get(Rec."Document Type", Rec."No.") then;
                        CurrPage.PurchLines.Page.ForceTotalsCalculation();
                        CurrPage.Update();
                    end;
                }
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
                    Enabled = not OpenApprovalEntriesExist and CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        PurchasesUtils: Codeunit "Purchases-Utils"; //BC Upgrade GUNREM01 >> added 
                        PurchasesPayablesSetup: Record "Purchases & Payables Setup";//BC Upgrade GUNREM01 >> added 
                        PurchaseLine: Record "Purchase Line";//BC Upgrade GUNREM01 >> added 
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
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord or CanCancelApprovalForFlow;
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
            group(Flow)
            {
                Caption = 'Power Automate';
                Image = Flow;

                customaction(CreateFlowFromTemplate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create approval flow';
                    ToolTip = 'Create a new flow in Power Automate from a list of relevant flow templates.';
                    Visible = IsSaaS and IsPowerAutomatePrivacyNoticeApproved;
                    CustomActionType = FlowTemplateGallery;
                    FlowTemplateCategoryName = 'd365bc_approval_purchaseInvoice';
                }
            }
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
                        //BC Upgrade GUNREM01 >> Added code
                        Rec.TESTFIELD("Document Date"); //HEI.10
                                                        //HEI.08>>
                        if CALCDATE('-3M', Rec."Posting Date") > Rec."Document Date" then
                            //HEI.09>>
                            if not CONFIRM(BeforeLimit, false, Rec."Document Date", Rec."Posting Date") then
                                exit;
                        //ERROR(BeforeLimit);

                        //IF CALCDATE('3M',"Posting Date") < "Document Date" THEN
                        if rec."Document Date" > Rec."Posting Date" then
                            ERROR(AfterLimit);

                        //IF "Posting Date" = "Document Date" THEN
                        //ERROR(EqualDate);
                        //HEI.09<<
                        //HEI.08<<
                        //BC Upgrade GUNREM01 << Added code
                        VerifyTotal();
                        PostDocument(CODEUNIT::"Purch.-Post (Yes/No)");
                        //, Enum::"Navigate After Posting"::"Posted Document");  //BC UPGRADE ATHUKUS01 FDDSTP_007
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
                        //BC Upgrade GUNREM01 >> added
                        Rec.TESTFIELD("Document Date"); //HEI.10
                        //HEI.09>>
                        if CALCDATE('-3M', Rec."Posting Date") > Rec."Document Date" then
                            if not CONFIRM(BeforeLimit, false, Rec."Document Date", Rec."Posting Date") then
                                exit;

                        if rec."Document Date" > Rec."Posting Date" then
                            ERROR(AfterLimit);
                        //HEI.09<<
                        //BC Upgrade GUNREM01 << added
                        VerifyTotal();
                        PostDocument(CODEUNIT::"Purch.-Post + Print", Enum::"Navigate After Posting"::"Do Nothing");
                    end;
                }
                action(PostAndNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and New';
                    Ellipsis = true;
                    Image = PostOrder;
                    ShortCutKey = 'Alt+F9';
                    ToolTip = 'Post the purchase document and create a new, empty one.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", Enum::"Navigate After Posting"::"New Document");
                    end;
                }
                action(PostBatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ToolTip = 'Post several documents at once. A report request window opens where you can specify which documents to post.';

                    trigger OnAction()
                    begin
                        VerifyTotal();
                        REPORT.RunModal(REPORT::"Batch Post Purchase Invoices", true, true, Rec);
                        CurrPage.Update(false);
                    end;
                }
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
                    actionref(PostAndNew_Promoted; PostAndNew)
                    {
                    }
                    actionref(PostAndPrint_Promoted; PostAndPrint)
                    {
                    }
                    actionref(PostBatch_Promoted; PostBatch)
                    {
                    }
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

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        StatusStyleTxt := Rec.GetStatusStyleText();
    end;

    trigger OnAfterGetRecord()
    var
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
    begin
        RejectICPurchaseInvoiceEnabled := ICInboxOutboxMgt.IsPurchaseHeaderFromIncomingIC(Rec);
        CalculateCurrentShippingAndPayToOption();
        BuyFromContact.GetOrClear(Rec."Buy-from Contact No.");
        PayToContact.GetOrClear(Rec."Pay-to Contact No.");
        CurrPage.IncomingDocAttachFactBox.Page.SetCurrentRecordID(Rec.RecordId);

        OnAfterOnAfterGetRecord(Rec);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord();
        exit(Rec.ConfirmDeletion());
    end;

    trigger OnInit()

    // BC Upgrade MISHRS14 >>
    // Created variable - FlowServiceManagement to call -GetPowerAutomatePrivacyNoticeId as it has been moved to new codeunit
    var
        FlowServiceManagement: Codeunit "Flow Service Management";
    // BC Upgrade MISHRS14 <<

    begin
        JobQueuesUsed := PurchSetup.JobQueueActive();
        SetExtDocNoMandatoryCondition();
        ShowShippingOptionsWithLocation := ApplicationAreaMgmtFacade.IsLocationEnabled() or ApplicationAreaMgmtFacade.IsAllDisabled();
        //IsPowerAutomatePrivacyNoticeApproved := PrivacyNotice.GetPrivacyNoticeApprovalState(PrivacyNoticeRegistrations.GetPowerAutomatePrivacyNoticeId()) = "Privacy Notice Approval State"::Agreed;

        // BC Upgrade MISHRS14 >>
        // Blocked the above as it has been replaced with new codeunit - FlowServiceManagement
        IsPowerAutomatePrivacyNoticeApproved := PrivacyNotice.GetPrivacyNoticeApprovalState(FlowServiceManagement.GetPowerAutomatePrivacyNoticeId()) = "Privacy Notice Approval State"::Agreed;
        // BC Upgrade MISHRS14 <<

        DocAmountEnable := PurchSetup."Check Doc. Total Amounts";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

        if (not DocNoVisible) and (Rec."No." = '') then begin
            Rec.SetBuyFromVendorFromFilter();
            Rec.SelectDefaultRemitAddress(Rec);
        end;

        //HEI.03>> NAIKH01
        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD(PurchasesPayablesSetup."NPO Subtype Code FND");
        Rec."Document Subtype Code FND" := PurchasesPayablesSetup."NPO Subtype Code FND"; //BC Upgrade VAMSIU01 - Added code for Document subtype code
        //HEI.03<<

        //HEI.04 IBM PATHAA02 28.09.17>>
        Rec."Payment Status FND" := Rec."Payment Status FND"::"Pending Review";
        //HEI.04 IBM PATHAA02 28.09.17<<

        // CalculateCurrentShippingAndPayToOption(); BC Upgrade GUNREM01 Commented. Becuase this fucntionality is not required as per the customization
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage.Update(false);
    end;

    trigger OnOpenPage()
    var
        PurchaseHeader: Record "Purchase Header";
        EnvironmentInfo: Codeunit "Environment Information";
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
        VATReportingDateMgt: Codeunit "VAT Reporting Date Mgt";
    begin
        SetDocNoVisible();
        IsOfficeAddin := OfficeMgt.IsAvailable();
        CreateIncomingDocFromEmailAttachment := OfficeMgt.OCRAvailable();
        CreateIncomingDocumentVisible := not OfficeMgt.IsOutlookMobileApp();
        IsSaaS := EnvironmentInfo.IsSaaS();

        Rec.SetSecurityFilterOnRespCenter();

        if (Rec."No." <> '') and (Rec."Buy-from Vendor No." = '') then
            DocumentIsPosted := (not Rec.Get(Rec."Document Type", Rec."No."));

        Rec.SetRange("Date Filter", 0D, WorkDate());

        ActivateFields();

        CheckShowBackgrValidationNotification();
        FillRemitToFields();
        RejectICPurchaseInvoiceEnabled := ICInboxOutboxMgt.IsPurchaseHeaderFromIncomingIC(Rec);
        if RejectICPurchaseInvoiceEnabled then begin
            PurchaseHeader.SetRange("IC Direction", PurchaseHeader."IC Direction"::Incoming);
            PurchaseHeader.SetRange("IC Reference Document No.", Rec."Vendor Order No.");
            PurchaseHeader.SetRange("Buy-from IC Partner Code", Rec."Buy-from IC Partner Code");
            PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
            if PurchaseHeader.FindFirst() then
                ICInboxOutboxMgt.ShowDuplicateICDocumentWarning(PurchaseHeader);
            PurchaseHeader.Reset();
            if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, CopyStr(Rec."Your Reference", 1, MaxStrLen(Rec."No."))) then
                if (PurchaseHeader."IC Direction" = PurchaseHeader."IC Direction"::Outgoing) and
                   (PurchaseHeader."Buy-from IC Partner Code" = Rec."Buy-from IC Partner Code") and
                   (PurchaseHeader."IC Status" = PurchaseHeader."IC Status"::Sent) then
                    ICInboxOutboxMgt.ShowDuplicateICDocumentWarning(PurchaseHeader, ICIncomingInvoiceFromOriginalOrderMsg);
        end;
        VATDateEnabled := VATReportingDateMgt.IsVATDateEnabled();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ShowConfirmCloseUnposted: Boolean;
    begin
        ShowConfirmCloseUnposted := not DocumentIsPosted;
        OnQueryClosePageOnAfterCalcShowConfirmCloseUnposted(Rec, ShowConfirmCloseUnposted);
        if ShowConfirmCloseUnposted then
            exit(Rec.ConfirmCloseUnposted());
    end;

    var
        //BC Upgrade GUNREM01 Added var
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        Text0001: Label '"You cannot modify the field- ''%1''. "';

        //BC Upgrade GUNREM01 Added var
        BuyFromContact: Record Contact;
        PayToContact: Record Contact;
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        RemitAddressBuffer: Record "Remit Address Buffer";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        OfficeMgt: Codeunit "Office Management";
        FormatAddress: Codeunit "Format Address";
        PrivacyNotice: Codeunit "Privacy Notice";
        PrivacyNoticeRegistrations: Codeunit "Privacy Notice Registrations";
        ChangeExchangeRate: Page "Change Exchange Rate";
        StatusStyleTxt: Text;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        IsPowerAutomatePrivacyNoticeApproved: Boolean;
        ShowWorkflowStatus: Boolean;
        JobQueuesUsed: Boolean;
        ICIncomingInvoiceFromOriginalOrderMsg: Label 'This invoice was received through intercompany and it''s related to the purchase %1 with no. %2. You can delete that order and post this invoice.', Comment = '%1 - either "order", "invoice", or "posted invoice", %2 - a code';
        SureToRejectMsg: Label 'Rejecting this invoice will remove it from your company and send it back to the partner company.\\ Do you want to continue?';
        OpenPostedPurchaseInvQst: Label 'The invoice is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        CreateIncomingDocumentVisible: Boolean;
        CreateIncomingDocFromEmailAttachment: Boolean;
        TotalsMismatchErr: Label 'The invoice cannot be posted because the total is different from the total on the related incoming document.';
        IncomingDocEmailAttachmentEnabled: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        ShowShippingOptionsWithLocation: Boolean;
        IsSaaS: Boolean;
        IsBuyFromCountyVisible: Boolean;
        IsPayToCountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;
        IsRemitToCountyVisible: Boolean;
        PurchaseDocCheckFactboxVisible: Boolean;
        IsJournalTemplNameVisible: Boolean;
        IsPaymentMethodCodeVisible: Boolean;
        IsPostingGroupEditable: Boolean;
        IsPurchaseLinesEditable: Boolean;
        RejectICPurchaseInvoiceEnabled: Boolean;
        VATDateEnabled: Boolean;
        DocAmountEnable: Boolean;

    protected var
        ShipToOptions: Option "Default (Company Address)",Location,"Custom Address";
        PayToOptions: Option "Default (Vendor)","Another Vendor","Custom Address";

    local procedure ActivateFields()
    begin
        IsBuyFromCountyVisible := FormatAddress.UseCounty(Rec."Buy-from Country/Region Code");
        IsPayToCountyVisible := FormatAddress.UseCounty(Rec."Pay-to Country/Region Code");
        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
        GLSetup.Get();
        IsJournalTemplNameVisible := GLSetup."Journal Templ. Name Mandatory";
        IsPaymentMethodCodeVisible := not GLSetup."Hide Payment Method Code";
        IsPurchaseLinesEditable := Rec.PurchaseLinesEditable();
    end;

    procedure LineModified()
    begin
    end;

    procedure CallPostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    begin
        PostDocument(PostingCodeunitID, Navigate);
    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
    local procedure PostDocument(PostingCodeunitID: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        //  if DummyApplicationAreaSetup.IsFoundationEnabled then
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        rec.SendToPosting(PostingCodeunitID);

        DocumentIsPosted := not PurchaseHeader.GET(rec."Document Type", rec."No.");

        if rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.CLOSE;
        CurrPage.UPDATE(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        if IsOfficeAddin then begin
            PurchInvHeader.SETRANGE("Pre-Assigned No.", rec."No.");
            PurchInvHeader.SETRANGE("Order No.", '');
            if PurchInvHeader.FINDFIRST then
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end;// else
        ShowPostedConfirmationMessage;
        // Error('You can not ');
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        PurchInvHeader1: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        PurchInvHeader1.Reset();
        PurchInvHeader1.SETRANGE("Pre-Assigned No.", rec."No.");
        // PurchInvHeader1.SETRANGE("Order No.", '');
        if PurchInvHeader1.FINDFIRST then begin
            DocumentIsPosted := true;
            if ShowConfirm1(StrSubstNo(OpenPostedPurchaseInvQst, PurchInvHeader1."No."),
                            InstructionMgt.ShowPostedConfirmationMessageCode()) then
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader1);
        end;
    end;

    procedure ShowConfirm1(ConfirmQst: Text; InstructionType: Code[50]): Boolean
    begin
        if GuiAllowed then begin
            Commit();
            exit(Confirm(ConfirmQst));
        end;

        exit(true);
    end;
    // BC Upgrade ATHUKUS01 FDDSTP007 <<
    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
        PreAssignedNo: Code[20];
        xLastPostingNo: Code[20];
        DocumentIsScheduledForPosting: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePostDocument(Rec, xRec, PostingCodeunitID, IsHandled);
        if IsHandled then
            exit;

        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);
        PreAssignedNo := Rec."No.";
        xLastPostingNo := Rec."Last Posting No.";

        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsScheduledForPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        if DocumentIsScheduledForPosting then
            DocumentIsPosted := true
        else begin
            PurchaseHeader.SetRange("Document Type", Rec."Document Type");
            PurchaseHeader.SetRange("No.", Rec."No.");
            DocumentIsPosted := PurchaseHeader.IsEmpty();
        end;

        OnPostDocumentOnAfterCalcDocumentIsScheduledForPosting(Rec, DocumentIsScheduledForPosting, DocumentIsPosted);
        if DocumentIsScheduledForPosting then
            CurrPage.Close();
        CurrPage.Update(false);

        IsHandled := false;
        OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, Navigate, DocumentIsPosted, IsHandled);
        if IsHandled then
            exit;

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        case Navigate of
            Enum::"Navigate After Posting"::"Posted Document":
                if IsOfficeAddin then begin
                    if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
                        PurchInvHeader.SetRange("No.", Rec."Last Posting No.")
                    else
                        PurchInvHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
                    PurchInvHeader.SetRange("Order No.", '');
                    if PurchInvHeader.FindFirst() then
                        PAGE.Run(PAGE::"Posted Purchase Invoice", PurchInvHeader);
                end else
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage(PreAssignedNo, xLastPostingNo);
            Enum::"Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Init();
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Invoice);
                    OnPostDocumentOnBeforePurchaseHeaderInsert(PurchaseHeader);
                    PurchaseHeader.Insert(true);
                    PAGE.Run(PAGE::"Purchase Invoice", PurchaseHeader);
                end;
        end;
    end;

    protected procedure VerifyTotal()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeVerifyTotal(Rec, IsHandled);
        if IsHandled then
            exit;

        if not Rec.IsTotalValid() then
            Error(TotalsMismatchErr);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
    end;

    local procedure SaveInvoiceDiscountAmount()
    var
        DocumentTotals: Codeunit "Document Totals";
    begin
        CurrPage.SaveRecord();
        DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
        CurrPage.Update(false);
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.PurchLines.Page.ForceTotalsCalculation();
        CurrPage.Update();
        Rec.CalcFields("Invoice Discount Amount");
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    begin
        PurchSetup.GetRecordOnce();
        VendorInvoiceNoMandatory := PurchSetup."Ext. Doc. No. Mandatory";
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition();
        SetPostingGroupEditable();

        IncomingDocEmailAttachmentEnabled := OfficeMgt.EmailHasAttachments();
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        if not IsPurchaseLinesEditable then
            IsPurchaseLinesEditable := Rec.PurchaseLinesEditable();

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        PurchaseDocCheckFactboxVisible := DocumentErrorsMgt.BackgroundValidationEnabled();
    end;

    procedure RunBackgroundCheck()
    begin
        CurrPage.PurchaseDocCheckFactbox.Page.CheckErrorsInBackground(Rec);
    end;

    local procedure CheckShowBackgrValidationNotification()
    var
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
    begin
        if DocumentErrorsMgt.CheckShowEnableBackgrValidationNotification() then
            SetControlAppearance();
    end;

    procedure SetPostingGroupEditable()
    var
        PayToVendor: Record Vendor;
    begin
        if PayToVendor.Get(Rec."Pay-to Vendor No.") then
            IsPostingGroupEditable := PayToVendor."Allow Multiple Posting Groups";
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20]; xLastPostingNo: Code[20])
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
            PurchInvHeader.SetRange("No.", Rec."Last Posting No.")
        else
            PurchInvHeader.SetRange("Pre-Assigned No.", PreAssignedNo);

        if PurchInvHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseInvQst, PurchInvHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                InstructionMgt.ShowPostedDocument(PurchInvHeader, Page::"Purchase Invoice");
    end;

    local procedure ValidateShippingOption()
    begin
        OnBeforeValidateShipToOptions(Rec, ShipToOptions);

        case ShipToOptions of
            ShipToOptions::"Default (Company Address)",
          ShipToOptions::"Custom Address":
                Rec.Validate("Location Code", '');
            ShipToOptions::Location:
                Rec.Validate("Location Code");
        end;

        OnAfterValidateShipToOptions(Rec, ShipToOptions);
    end;

    local procedure CalculateCurrentShippingAndPayToOption()
    begin
        if Rec."Location Code" <> '' then
            ShipToOptions := ShipToOptions::Location
        else
            if Rec.ShipToAddressEqualsCompanyShipToAddress() then
                ShipToOptions := ShipToOptions::"Default (Company Address)"
            else
                ShipToOptions := ShipToOptions::"Custom Address";

        case true of
            (Rec."Pay-to Vendor No." = Rec."Buy-from Vendor No.") and Rec.BuyFromAddressEqualsPayToAddress():
                PayToOptions := PayToOptions::"Default (Vendor)";
            (Rec."Pay-to Vendor No." = Rec."Buy-from Vendor No.") and (not Rec.BuyFromAddressEqualsPayToAddress()):
                PayToOptions := PayToOptions::"Custom Address";
            Rec."Pay-to Vendor No." <> Rec."Buy-from Vendor No.":
                PayToOptions := PayToOptions::"Another Vendor";
        end;

        OnAfterCalculateCurrentShippingAndPayToOption(ShipToOptions, PayToOptions, Rec);
    end;

    local procedure FillRemitToFields()
    var
        RemitAddress: Record "Remit Address";
    begin
        RemitAddress.SetRange("Vendor No.", Rec."Buy-from Vendor No.");
        RemitAddress.SetRange(Code, Rec."Remit-to Code");
        if not RemitAddress.IsEmpty() then begin
            RemitAddress.FindFirst();
            FormatAddress.VendorRemitToAddress(RemitAddress, RemitAddressBuffer);
            CurrPage.Update();
        end;
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterOnAfterGetRecord(var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalculateCurrentShippingAndPayToOption(var ShipToOptions: Option "Default (Company Address)",Location,"Custom Address"; var PayToOptions: Option "Default (Vendor)","Another Vendor","Custom Address"; PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostDocumentOnBeforePurchaseHeaderInsert(var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateShipToOptions(var PurchaseHeader: Record "Purchase Header"; ShipToOptions: Option)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforePostDocument(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; PostingCodeunitID: Integer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeVerifyTotal(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShipToOptions(var PurchaseHeader: Record "Purchase Header"; ShipToOptions: Option)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnPostDocumentBeforeNavigateAfterPosting(var PurchaseHeader: Record "Purchase Header"; var PostingCodeunitID: Integer; var Navigate: Enum "Navigate After Posting"; DocumentIsPosted: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnQueryClosePageOnAfterCalcShowConfirmCloseUnposted(var PurchaseHeader: Record "Purchase Header"; var ShowConfirmCloseUnposted: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCurrencyCodeOnAssistEdit(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostDocumentOnAfterCalcDocumentIsScheduledForPosting(var PurchaseHeader: Record "Purchase Header"; var DocumentIsScheduledForPosting: Boolean; var DocumentIsPosted: Boolean)
    begin
    end;
}
