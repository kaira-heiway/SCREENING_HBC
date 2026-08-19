page 51049 "Expense Claim CBN"
{
    // version NAVW110.0.00.15140,FINXL10.00,DITW110.00.09,HEI.11

    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                New calling functions to insert (item) charges
    // DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.21 DDR 25/06/2008 Added menu "Get Shipping agent documents" into button "Function"
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                                Added fields "Vendor DTax Group Code" into Invoicing tab
    // DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    // DITW15.00.00.34 DDR 17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                Changed Editable "Status" field
    //                                Added functions DocStatusRelease(),DocStatusOpen(),
    // DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW15.00.00.39 DDR 27/04/2011 issue 1323 NAVBE5.00 (SP1) functionnality to insert Customer Std. Sales Codes automatically
    //                                Added to call function StdVendPurchCode.AutoInsertPurchLines()
    //                                  from OnAfterValidate trigger field "Sell-to Customer No."
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
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1191 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //                                          TEMP Disabled Call function UpdateVATAmounts()
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // 
    // FINXL7.00 RBE 20/03/2013 : Added field "Your Reference","Posting Description" on page
    //                                "Currency Code" and "On Hold" moved to the first group
    //                                "Jnl Template Selection" when opening form
    // FINXL7.00 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    // FINXL7.00 KLU 03/10/2013 : Check for existing template name
    // FINXL8.00.001 RBE 01/12/2014: Hide factbox: "Purch. Inv./Cr.M. Info"
    // FINXL8.00.001 BSA 16/06/2015 #124 : Added Field "OGM"
    // 
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // DITW19.00.07 MVN 25/01/2016 DIT-770 #1740 Upgrade
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code" under "Invoicing" tab
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL9.00.000.01 ACH 05/01/2016 : Added factbox to show mandatory Dimensions for G/L account
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // 
    // HEI.01 FDD PTPGAP014 - No POGR lines in NPO invoice , IBM NAIKH01 27-06-2017
    //   # Created  a new page that is the Replica of Page 51 - "Purchase Invoice" to show the Purchase Invoice with Document SubType 'NPO'

    // HEI.02 PTPGAP066 IBM SOICAD01 26.07.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account
    //   # code added on action "Archive Document".

    // HEI.03 FDD PTPGAP014 - No POGR lines in NPO invoice , IBM NAIKH01 14.08.2017
    //   # code in the trigger "OnNewRecord" blocked due to DrinkIT field "Document Subtype Code" is used in code.
    //   # Changed the SourceTableView of the page Property

    // HEI.04 FDD-PTPGAP013/Defect309 28.09.2017>>
    //   # "Payment Status" Default value to be Pending Review.
    //   # Aligned Payment Status field on page

    // HEI.05 CHG0255417 IBM.LS 15.10.2018
    //   # Code added on fields "Due Date", "Payment Status", "Payment Terms Code", "Pay-to Name" to restrict the field modification.

    // HEI.06 CHG0255417 IBM.LS 30.10.2018
    //   # Code added to restrict the field-"Payment Method Code" modification.

    // HEI.08 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # Made Field "Vendor Posting Group" non-editable
    // HEI.09 CHG2204474 IBM SRIVAS07 19.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    // HEI.10 CHG2204474 IBM SRIVAS07 26.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    //   # Added code in PostAndPrint Action.
    // HEI.11 CHG2204474 IBM SRIVAS07 16.10.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    //   # Added code in PostAndPrint Action.

    //  IsFoundationArea() condition is not required anymore in business central Saas so blocked that condition.

    // DrinkIT code and fields are blocked.

    //BC UPGRADE SHIKHD02>>
    //In area(processing) -> group(Release) Blocked Image = Release and added Image = ReleaseDoc 
    //BC UPGRADE SHIKHD02<<

    // BC Upgrade SHUKLP03 >> "Document Subtype Code" code added.

    Caption = 'Expense Claim';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Invoice,Posting,View,Request Approval,Incoming Document';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = sorting("Document Type", "No.")
                      where("Document Type" = FILTER(Invoice));

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
                    ApplicationArea = All;
                    Caption = 'Vendor';
                    Importance = Promoted;
                    NotBlank = true;
                    ShowMandatory = true;
                    TableRelation = Vendor where("Employee FND" = CONST(true));
                    ToolTip = 'Specifies the name of the vendor who sends the items. The field is filled automatically when you fill the Buy-from Vendor No. field.';

                    trigger OnValidate();
                    begin
                        if Rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
                            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                                Rec.SETRANGE("Buy-from Vendor No.");

                        //IF ApplicationAreaSetup.IsFoundationEnabled THEN // BC Upgrade SHUKLP03 << Blocked becaue no need of this condition.
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                        CurrPage.UPDATE();

                        //BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
                        // // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
                        // COMMIT;
                        // StdVendPurchCode.AutoInsertPurchLines(Rec);
                        // // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)
                        //BC Upgrade SHUKLP03 << DrinkIT code is blocked.
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
                        ToolTip = 'Specifies the city of the vendor who ships the items.';
                    }
                    field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                    {
                        Caption = 'Contact No.';
                        Importance = Additional;
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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date on which the vendor created the purchase document.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
                // field("Tax Date"; Rec."Tax Date")
                // {
                // } // BC Upgrade SHUKLP03 << DrinkIT field is blocked.
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
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
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the incoming document that this purchase document is created for.';
                    Visible = false;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = VendorInvoiceNoMandatory;
                    ToolTip = 'Specifies the number that the vendor uses on the invoice that they sent to you.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
                // field(OGM; Rec.OGM)
                // {
                // }
                // BC Upgrade SHUKLP03 << DrinkIT field is blocked.
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
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
                // field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
                // {
                // } // BC Upgrade SHUKLP03 << DrinkIT field is blocked.
                field(Status; Rec.Status)
                {
                    Editable = true;
                    Importance = Promoted;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';

                    trigger OnValidate();
                    begin
                        StatusOnValidate();
                        StatusOnAfterValidate();
                    end;
                }
                // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
                // field("Linked Customer No."; Rec."Linked Customer No.")
                // {
                //     Importance = Additional;
                // }
                field("Doc. Amount Incl. VAT IBM"; Rec."Doc. Amount Incl. VAT IBM FND")
                {
                    ApplicationArea = all;
                    Caption = 'Doc. Amount Incl. VAT';

                }//BC Upgrade SHARMP16--PID853
                field("Doc. Amount VAT IBM"; Rec."Doc. Amount VAT IBM FND")
                {
                    ApplicationArea = all;
                    Caption = 'Doc. Amount VAT';
                    Description = 'FINXL7.00.001';
                } ///BC Upgrade SHARMP16--PID853
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                    Visible = JobQueuesUsed;
                }
            }
            part(PurchLines; "Expense Claim Subform CBN")
            {
                ApplicationArea = Basic, Suite;
                Editable = Rec."Buy-from Vendor No." <> '';
                Enabled = Rec."Buy-from Vendor No." <> '';
                SubPageLink = "Document No." = FIELD("No."), "Document Type" = field("Document Type");//BC Upgrade SHARMP16--PID853
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
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect to receive the items on the purchase document.';
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
                        CurrPage.UPDATE();
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
                // // BC Upgrade SHUKLP03 >> DrinkIT field is blocked.
                // BC Upgrade SHUKLP03 >> Added Document Subtype Code
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade SHUKLP03 << Added Document Subtype Code
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
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.';

                    trigger OnValidate();
                    begin
                        //HEI.05>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Terms Code" <> xRec."Payment Terms Code") and (xRec."Payment Terms Code" <> '') then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Terms Code"));
                        end;
                        //HEI.05<<
                        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
                        // //<<FINXL7.00 RBE 06/08/2013
                        // if recFinXLSetup.READPERMISSION then
                        //     if recPurchSetup."Check Totals on Purch. Inv./CM" then begin
                        //         UpdateAfterChangingVATDisc();
                        //         //   CurrPage.PurchLines.PAGE.MakeTotals;
                        //     end;
                        // //>>FINXL7.00 RBE 06/08/2013
                        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
                    end;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how payment for the purchase document must be submitted, such as bank transfer or check.';

                    trigger OnValidate();
                    begin
                        //HEI.06>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Method Code" <> xRec."Payment Method Code") and (xRec."Payment Method Code" <> '') then begin
                            ERROR(Text0001, Rec.FIELDCAPTION("Payment Method Code"));
                        end;
                        //HEI.06<<
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the number for the transaction type, for the purpose of reporting to INTRASTAT.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the purchase header.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';

                    trigger OnValidate();
                    begin
                        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
                        // //<<FINXL7.00 RBE 06/08/2013
                        // if recFinXLSetup.READPERMISSION then
                        //     if recPurchSetup."Check Totals on Purch. Inv./CM" then begin
                        //         UpdateAfterChangingVATDisc();
                        //         //CurrPage.PurchLines.PAGE.MakeTotals;
                        //     end;
                        // //>>FINXL7.00 RBE 06/08/2013
                        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
                    end;
                }
                field("VAT Base Discount %"; Rec."VAT Base Discount %")
                {
                    ToolTip = 'Specifies the value of the VAT Base Discount % field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
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
                // } // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the code that represents the shipment method for this purchase.';
                }
                // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
                // field("Truck Code"; Rec."Truck Code")
                // {
                // }
                // field("Driver Code"; Rec."Driver Code")
                // {
                // } // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
                field("Payment Reference"; Rec."Payment Reference")
                {
                    Importance = Additional;
                    ToolTip = 'Identifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    Importance = Additional;
                    ToolTip = 'Identifies the vendor who sent the purchase invoice.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the document.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    Editable = false;
                    Importance = Additional;
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
                    field("Order Address Code"; Rec."Order Address Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
                    }
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Name';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.';
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        ToolTip = 'Specifies the address that you want the items in the purchase order to be shipped to.';
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Importance = Additional;
                        ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        Importance = Additional;
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
                        NotBlank = true;
                        ToolTip = 'Specifies the name of the vendor sending the invoice.';

                        trigger OnValidate();
                        var
                        begin
                            //HEI.05>>
                            UserSetup.GET(USERID);
                            if (Rec."Pay-to Name" <> xRec."Pay-to Name") and (xRec."Pay-to Name" <> '') then begin
                                ERROR(Text0001, Rec.FIELDCAPTION("Pay-to Name"));
                            end;
                            //HEI.05<<
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
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact who sends the invoice.';
                    }
                    field("Pay-to Contact"; Rec."Pay-to Contact")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    }
                    field("Vendor Bank Account"; Rec."Vendor Bank Account FND")  // << HEI.02
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
            // BC Upgrade SHUKLP03 >> DrinkIT created group and fields are blocked.
            // group("Service/Contract")
            // {
            //     Caption = 'Service/Contract';
            //     field("Contract Type"; Rec."Contract Type")
            //     {
            //     }
            //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            //     {
            //     }
            //     field("Service Contract No."; Rec."Service Contract No.")
            //     {
            //     }
            //     field("Financial Contract No."; Rec."Financial Contract No.")
            //     {
            //     }
            //     field("Contract Group Code"; Rec."Contract Group Code")
            //     {
            //     }
            // } // BC Upgrade SHUKLP03 << DrinkIT created group and fields are blocked.
        }
        area(factboxes)
        {
            part(Control27; "Pending Approval FactBox")
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
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            // BC Upgrade SHUKLP03 >> DrinkIT page is used as a Part page.
            // part(Control1907232107; "Purchase Line FactBox2")
            // {
            //     Provider = PurchLines;
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                   "Document No." = FIELD("Document No."),
            //                   "Line No." = FIELD("Line No.");
            //     Visible = false;
            // } // BC Upgrade SHUKLP03 << DrinkIT page is used as a Part page.
            part("G/L Account Mandatory Dimensions"; "Dimensions FactBox")
            {
                Caption = 'G/L Account Mandatory Dimensions';
                Description = 'FINXL9.00.000.01';
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                SubPageView = where("Table ID" = CONST(15),
                                    "Value Posting" = CONST("Code Mandatory"));
            }
            // part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            // {
            //     ApplicationArea = Basic, Suite;
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
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part(Control3; "Purchase Line FactBox")
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
            // BC Upgrade SHUKLP03 >> DrinkIT page is used as a Part page.
            // part(Control2029614; "Purch. Inv./Cr.M. Info")
            // {
            //     Description = 'FINXL7.00.001';
            //     Provider = PurchLines;
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                   "Document No." = FIELD("Document No."),
            //                   "Line No." = FIELD("Line No.");
            //     Visible = false;
            // } // BC Upgrade SHUKLP03 >> DrinkIT page is used as a Part page.
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader();
                        COMMIT();
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                }
                action("Co&mments")
                {
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'Executes the Co&mments action.';
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Promoted = true;
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
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Visible = false;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'View';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        Promoted = true;
                        PromotedCategory = Category9;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

                        trigger OnAction();
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
                        Promoted = true;
                        PromotedCategory = Category9;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            Rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RECORDID));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create from File';
                        Ellipsis = true;
                        Enabled = CreateIncomingDocumentEnabled;
                        Image = Attach;
                        Promoted = true;
                        PromotedCategory = Category9;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';
                        Visible = CreateIncomingDocumentVisible;

                        trigger OnAction();
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
                        Promoted = true;
                        PromotedCategory = Category9;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Create an incoming document record by selecting an attachment from outlook email, and then link the incoming document record to the entry or document.';
                        Visible = CreateIncomingDocFromEmailAttachment;

                        trigger OnAction();
                        var
                            OfficeMgt: Codeunit "Office Management";
                        begin
                            if not Rec.INSERT(true) then
                                Rec.MODIFY(true);
                            OfficeMgt.InitiateSendToIncomingDocumentsWithPurchaseHeaderLink(Rec, Rec."Buy-from Vendor No.");
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Remove';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        Promoted = true;
                        PromotedCategory = Category9;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Remove an external document that has been recorded, manually or automatically, and attached as a file to a document or ledger entry.';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            if IncomingDocument.GET(Rec."Incoming Document Entry No.") then
                                IncomingDocument.RemoveLinkToRelatedRecord();
                            Rec."Incoming Document Entry No." := 0;
                            Rec.MODIFY(true);
                        end;
                    }
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Description = 'DITW18.00.06 GVC 19/05/2015  DIT-770  #1335';
                Image = Approval;
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID)
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID)
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID)
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View or add comments.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Release)
            {   //BC UPGRADE SHIKHD02>>
                //Blocked Image = Release and added Image = ReleaseDoc as Release was not a valid here
                Caption = 'Release';
                //Image = Release;
                Image = ReleaseDoc;
                //BC UPGRADE SHIKHD02<<
                action("Re&lease")
                {
                    ApplicationArea = all;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Re&lease action.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //BC UPGRADE SHARMP16>>
                        ReleasePurchDoc.PerformManualRelease(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                        //BC UPGRADE SHARMP16<<
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = all;
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
                // action(Reopen)
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Re&open';
                //     Enabled = Rec.Status <> Rec.Status::Open;
                //     Image = ReOpen;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     PromotedOnly = true;
                //     ShortCutKey = 'Ctrl+F10';
                //     ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                //     trigger OnAction();
                //     var
                //         ReleasePurchDoc: Codeunit "Release Purchase Document";
                //     begin
                //         //BC Upgrade SHUKLP03 >> Blocked due to DrinkIT created function DocStatusOpen() is called. 
                //         // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                //         ReleasePurchDoc.PerformManualReopen(Rec);
                //         //ReleasePurchDoc.DocStatusOpen(xRec, Rec);
                //         CurrPage.UPDATE;
                //         // // >>DITW15.00.00.39 DDR #1330 #1407
                //         //BC Upgrade SHUKLP03 >> Blocked due to DrinkIT created function DocStatusOpen() is called. 
                //     end;
                // }
                action(Reopen)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //BC UPGRADE SHARMP16>>//BC Upgrade SHARMP16--PID853
                        ReleasePurchDoc.PerformManualReopen(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                        //BC UPGRADE SHARMP16<<//BC Upgrade SHARMP16--PID853
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

                    trigger OnAction();
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
                    Image = CopyDocument;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    Promoted = true;//BC Upgrade SHARMP16--PID853
                    PromotedCategory = Category5;//BC Upgrade SHARMP16--PID853
                    PromotedIsBig = true;
                    PromotedOnly = true;//BC Upgrade SHARMP16--PID853
                    ToolTip = 'Copy document lines and header information from another purchase document to this document. You can copy a posted purchase invoice into a new purchase invoice to quickly create a similar document.';

                    trigger OnAction();
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount for the entire purchase invoice.';

                    trigger OnAction();
                    begin
                        ApproveCalcInvDisc();
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                separator(Separator136)
                {
                }
                action("Copy Document")
                {
                    ApplicationArea = all;//BC Upgrade SHARMP16--PID853
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ToolTip = 'Executes the Copy Document action.';

                    trigger OnAction();
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                        if Rec.GET(Rec."Document Type", Rec."No.") then;
                    end;
                }
                separator(Separator137)
                {
                }
                action(MoveNegativeLines)
                {
                    Promoted = true;//BC Upgrade SHARMP16--PID853
                    PromotedCategory = Category5;//BC Upgrade SHARMP16--PID853
                    PromotedIsBig = true;//BC Upgrade SHARMP16--PID853
                    PromotedOnly = true;//BC Upgrade SHARMP16--PID853
                    ApplicationArea = all;//BC Upgrade SHARMP16--PID853
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ToolTip = 'Executes the Move Negative Lines action.';

                    trigger OnAction();
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL();
                        MoveNegPurchLines.ShowDocument();
                    end;
                }
            }
            group(ActionGroup47)
            {
                Caption = 'Request Approval';
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;//BC Upgrade SHARMP16--PID853
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN();
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category8;
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
                    PromotedCategory = Category8;
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
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction();
                    var
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                    begin
                        Rec.TESTFIELD("Document Date");//HEI.11
                        //HEI.09>>
                        if CALCDATE('-3M', Rec."Posting Date") > Rec."Document Date" then
                            //HEI.10>>
                            if not CONFIRM(BeforeLimit, false, Rec."Document Date", Rec."Posting Date") then
                                exit;
                        //ERROR(BeforeLimit);

                        //IF CALCDATE('3M',"Posting Date") < "Document Date" THEN
                        if Rec."Document Date" > Rec."Posting Date" then
                            ERROR(AfterLimit);
                        //IF "Posting Date" = "Document Date" THEN
                        //ERROR(EqualDate);
                        //HEI.10<<
                        //HEI.09<<
                        VerifyTotal();
                        Post1(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Basic, Suite;
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
                action(TestReport)
                {
                    ApplicationArea = all;//BC Upgrade SHARMP16--PID853
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = all;//BC Upgrade SHARMP16--PID853
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = NOT IsOfficeAddin;
                    ToolTip = 'Executes the Post and &Print action.';

                    trigger OnAction();
                    var
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                    begin
                        Rec.TESTFIELD("Document Date"); //HEI.11
                        //HEI.10>>
                        if CALCDATE('-3M', Rec."Posting Date") > Rec."Document Date" then
                            if not CONFIRM(BeforeLimit, false, Rec."Document Date", Rec."Posting Date") then
                                exit;

                        if Rec."Document Date" > Rec."Posting Date" then
                            ERROR(AfterLimit);
                        //HEI.10<<
                        VerifyTotal();
                        Post1(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    ApplicationArea = all;//BC Upgrade SHARMP16--PID853
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ToolTip = 'Executes the Post &Batch action.';

                    trigger OnAction();
                    begin
                        VerifyTotal();
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled For Posting";

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

        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);//BC Upgrade SHARMP16
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);
        SetControlAppearance();
    end;

    trigger OnClosePage();
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
        // //<<FINXL7.00 RBE 20/03/2013
        // if recFinXLSetup.READPERMISSION then
        //     if recPurchSetup."Show Jnl. Template Selection" then
        //         cduSingleInstaceFunctions.fctTrackPurchInvoicePage(true, txtTemplateName);
        // //>>FINXL7.00 RBE 20/03/2013
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SAVERECORD();
        exit(rec.ConfirmDeletion());
    end;

    trigger OnInit();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        SetExtDocNoMandatoryCondition();
        JobQueuesUsed := PurchasesPayablesSetup."Post & Print with Job Queue";
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetBuyFromVendorFromFilter();

        // BC Upgrade SHUKLP03 >> Added Document Subtype Code
        //HEI.03>> NAIKH01
        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD(PurchasesPayablesSetup."Expense Claim Subdoc. Type FND");
        Rec."Document Subtype Code FND" := PurchasesPayablesSetup."Expense Claim Subdoc. Type FND";
        //HEI.03<<
        // BC Upgrade SHUKLP03 << Added Document Subtype Code

        //HEI.04 IBM PATHAA02 28.09.17>>
        Rec."Payment Status FND" := Rec."Payment Status FND"::"Pending Review";
        //HEI.04 IBM PATHAA02 28.09.17<<
    end;

    trigger OnOpenPage();
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked
        // //<<FINXL7.00 RBE 20/03/2013
        // if recFinXLSetup.READPERMISSION then begin
        //     recPurchSetup.GET;
        //     txtTemplateName := '';
        //     if cduSingleInstaceFunctions.fctGetPurchInvoicePages > 0 then begin
        //         txtTemplateName := cduSingleInstaceFunctions.fctGetPurchInvoiceTemplate;
        //         cduSingleInstaceFunctions.fctTrackPurchInvoicePage(false, txtTemplateName);
        //     end
        //     else
        //         if recPurchSetup."Show Jnl. Template Selection" then begin
        //             recGenJournalTemplate.RESET;
        //             recGenJournalTemplate.SETRANGE(Type, recGenJournalTemplate.Type::Purchases);
        //             recGenJournalTemplate.SETRANGE("Credit Memo", false);

        //             if recGenJournalTemplate.COUNT > 1 then begin
        //                 blnJnlSelected := PAGE.RUNMODAL(0, recGenJournalTemplate) = ACTION::LookupOK;

        //                 if not blnJnlSelected then
        //                     ERROR('');
        //             end else
        //                 recGenJournalTemplate.FINDFIRST;

        //             txtTemplateName := recGenJournalTemplate.Name;

        //             cduSingleInstaceFunctions.fctTrackPurchInvoicePage(false, txtTemplateName);
        //         end;
        // end;
        // //>>FINXL7.00 RBE 20/03/2013
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked

        SetDocNoVisible();
        IsOfficeAddin := OfficeMgt.IsAvailable();
        CreateIncomingDocFromEmailAttachment := OfficeMgt.OCRAvailable();
        CreateIncomingDocumentVisible := not OfficeMgt.IsOutlookMobileApp();

        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked
        // // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
        // //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        // if UserMgt.GetPurchasesTextFilter <> '' then begin
        //     FILTERGROUP(2);
        //     //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
        //     SETFILTER("Responsibility Center", UserMgt.GetPurchasesTextFilter);
        //     FILTERGROUP(0);
        // end;
        // // >>DITW18.00.06 DDR DIT-770 #1191
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked

        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD("Expense Claim Subdoc. Type FND");
        PurchasesPayablesSetup.TESTFIELD("NPO Prepayment inv.subtype FND");
        PurchasesPayablesSetup.TESTFIELD("NPO Prepayment req.subtype FND");
        PurchasesPayablesSetup.TESTFIELD("NPOPrepaymentCrdMemosubtyp FND");
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if not DocumentIsPosted then
            exit(Rec.ConfirmCloseUnposted());
    end;

    var
        recGenJournalTemplate: Record "Gen. Journal Template";
        //recFinXLSetup: Record "Finance XL Setup"; // BC Upgrade SHUKLP03 >> DrinkIT codeunit.
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        recPurchSetup: Record "Purchases & Payables Setup";
        StdVendPurchCode: Record "Standard Vendor Purchase Code";
        UserSetup: Record "User Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ArchiveManagement: Codeunit ArchiveManagement;
        OfficeMgt: Codeunit "Office Management";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        //cduSingleInstaceFunctions: Codeunit "Single Instance Functions"; // BC Upgrade SHUKLP03 >> DrinkIT codeunit.
        cduReleasePurchDoc: Codeunit "Release Purchase Document";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        blnJnlSelected: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CreateIncomingDocFromEmailAttachment: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        CreateIncomingDocumentVisible: Boolean;
        DocNoVisible: Boolean;
        DocumentIsPosted: Boolean;
        HasIncomingDocument: Boolean;
        IncomingDocEmailAttachmentEnabled: Boolean;
        IsOfficeAddin: Boolean;
        JobQueuesUsed: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;

        PayToCommentBtnVisible: Boolean;

        PayToCommentPictVisible: Boolean;

        PurchHistoryBtn1Visible: Boolean;

        PurchHistoryBtnVisible: Boolean;
        ShowWorkflowStatus: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenPostedPurchaseInvQst: Label 'The invoice has been posted and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?';
        Text0001: Label '"You cannot modify the field- ''%1''. "';
        Text2014411: Label 'Do you want to cancel the approval request for %1 %2?';
        Text2014412: Label 'Do you want to send the approval request for %1 %2?';
        TotalsMismatchErr: Label 'The invoice cannot be posted because the total is different from the total on the related incoming document.';
        txtTemplateName: Text;

    procedure LineModified();
    begin
    end;

    local procedure Post1(PostingCodeunitID: Integer);
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
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
            PurchInvHeader.SETRANGE("Pre-Assigned No.", Rec."No.");
            PurchInvHeader.SETRANGE("Order No.", '');
            if PurchInvHeader.FINDFIRST() then
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end else
            if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                ShowPostedConfirmationMessage();
    end;

    local procedure VerifyTotal();
    begin
        if not Rec.IsTotalValid() then
            ERROR(TotalsMismatchErr);
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
        CurrPage.UPDATE();
        Rec.CALCFIELDS("Invoice Discount Amount");
    end;

    local procedure SetDocNoVisible();
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.GET();
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');
        SetExtDocNoMandatoryCondition();

        IncomingDocEmailAttachmentEnabled := OfficeMgt.EmailHasAttachments();
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        PurchInvHeader.SETRANGE("Pre-Assigned No.", Rec."No.");
        PurchInvHeader.SETRANGE("Order No.", '');
        if PurchInvHeader.FINDFIRST() then
            if InstructionMgt.ShowConfirm(OpenPostedPurchaseInvQst, InstructionMgt.ShowPostedConfirmationMessageCode()) then
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
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
        // if xRec.Status = Status then
        //     exit;

        // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        // if (xRec.Status = Status::Open) or (Status = Status::Released) then
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

    local procedure UpdateAfterChangingVATDisc();
    var
        PurchLine: Record "Purchase Line";
    begin
        // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
        // //<<FINXL7.00 RBE 06/08/2013
        // PurchLine.SETRANGE("Document Type", "Document Type");
        // PurchLine.SETRANGE("Document No.", "No.");
        // PurchLine.SETFILTER(Type, '<>%1', PurchLine.Type::" ");
        // PurchLine.SETFILTER(Quantity, '<>0');
        // PurchLine.LOCKTABLE;
        // if PurchLine.FIND('-') then
        //     repeat
        //         PurchLine.Amount := 0;
        //         PurchLine."Amount Including VAT" := 0;
        //         PurchLine."VAT Base Amount" := 0;
        //         PurchLine.MODIFY;
        //     until PurchLine.NEXT = 0;

        // // <<DITW17.10.04 DDR 07/08/2014 DIT-770 #654
        // //IF PurchLine.FIND('-') THEN
        // //  REPEAT
        // //    PurchLine.UpdateVATAmounts;
        // //    PurchLine.MODIFY;
        // //  UNTIL PurchLine.NEXT = 0;
        // // >>DITW17.10.04 DDR 07/08/2014 DIT-770 #654

        // //>>FINXL7.00 RBE 06/08/2013
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
    end;
}

