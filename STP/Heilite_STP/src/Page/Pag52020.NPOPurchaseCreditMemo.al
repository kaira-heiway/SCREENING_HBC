page 52020 "NPO Purchase Credit Memo"
{
    // version NAVW110.0.00.15140,FINXL10.00,DITW110.00.09,HEI.09

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
    // HEI.01 FDD PTPGAP081 IBM POSTOI01 11.05.2018
    //   # Action "Archive Document" , Properties , Enabled = false
    // 
    // HEI.02 defect #2234 IBM POSTOI01 05.06.2018
    //   # modify Editable property from TRUE to FALSE for field Document Subtype Code
    // 
    // HEI.03 CHG0255417 IBM.LS 15.10.2018
    //   # Code added to restrict the field modification.
    // HEI.04 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # Made Field "Vendor Posting Group" non-editable
    // HEI.05 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # VAT Centime - part 2 - Purchases
    //   # New Page Action created "Purchase Additional"
    // HEI.06 CHG2170293 HB3102 IBM MAJUMS03 18.10.2022 - Payment Method Code to be populated from Master Data during Credit Memo Processing
    //   # Editable" property of "Payment Method Code" field is modified as FALSE.
    // HEI.07 CHG2204474 IBM SRIVAS07 19.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    // HEI.08 CHG2204474 IBM SRIVAS07 26.09.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    //   # Added code in PostAndPrint Action.
    // HEI.09 CHG2204474 IBM SRIVAS07 16.10.23 - Error message displayed when document date is in the future in all invoice processing pages
    //   # Added code in Post Action.
    //   # Added code in PostAndPrint Action.
    //BC Upgrade SHARMP16 -- Old Id 50050 replace with new Id -52020

    // BC Upgrade MISHRS14 >>
    // This attribute is blocked and not further used in Business Central - [InDataSet] present in global var declaration
    // BC Upgrade MISHRS14 <<

    //BC UPGRADE ATHUKUS01 FDD_STP008>>
    //1.Added code in Release action & Base code for release action.
    //2.Added Base code for Reopen action.
    //3.Document stataus is made non editable.
    //BC UPGRADE ATHUKUS01 FDD_STP008<<

    Caption = 'NPO Purchase Credit Memo';
    PageType = Document;
    // PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER("Credit Memo"));
    ApplicationArea = All;
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
                        if rec.AssistEdit(xRec) then
                            CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Importance = Promoted;
                    QuickEntry = false;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the vendor who sends the items.';

                    trigger OnValidate();
                    var
                        ApplicationAreaSetup: Record "Application Area Setup";
                    begin
                        if rec."No." = '' then
                            rec.InitRecord;

                        if rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
                            if rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                                rec.SETRANGE("Buy-from Vendor No.");

                        //if ApplicationAreaSetup.IsFoundationEnabled then
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.UPDATE;

                        // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
                        // COMMIT;
                        // StdVendPurchCode.AutoInsertPurchLines(Rec);
                        // // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)

                        // //<<FINXL7.00 RBE 06/08/2013
                        // if recFinXLSetup.READPERMISSION then
                        //     UpdateAfterChangingHeader;
                        // //>>FINXL7.00 RBE 06/08/2013//BC upgrade SHARMP16--DR
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
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    Description = 'FINXL7.00.001';
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
                // field("Tax Date"; Rec."Tax Date")
                // {
                // }//Bc upgrade SHARMp16--DRINK-It fields
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields.';

                    trigger OnValidate();
                    begin
                        //HEI.03>>
                        UserSetup.GET(USERID);
                        if (rec."Due Date" <> xRec."Due Date") and (xRec."Due Date" <> 0D) then begin
                            ERROR(Text0001, rec.FIELDCAPTION("Due Date"));
                        end;
                        //HEI.03<<
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
                        PurchaserCodeOnAfterValidate;
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
                // field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
                // {
                // }//c Upgrade SHARMP16--DRINK-IT fields
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies whether the record is open, is waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';

                    trigger OnValidate();
                    begin
                        StatusOnValidate;
                        StatusOnAfterValidate;
                    end;
                }
                // field("Creation Date/Time"; Rec."Creation Date/Time")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                // field("Created By"; Rec."Created By")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // }
                // field("Linked Customer No."; Rec."Linked Customer No.")
                // {
                //     Importance = Additional;
                //BC UPGRADE FDD STP007 ATHUKS01<<
                // }//BC Upgrade SHARMP16--DRINK-IT fields
                // field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT")
                // {
                //     Description = 'FINXL7.00.001';
                // }
                // field("Doc. Amount VAT"; Rec."Doc. Amount VAT")
                // {
                //     Description = 'FINXL7.00.001';
                // }


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
                //BC UPGRADE FDD STP007 ATHUKS01>>
            }
            part(PurchLines; "NPO Purch. Cr. Memo Subform")
            {
                ApplicationArea = Basic, Suite;
                Editable = rec."Buy-from Vendor No." <> '';
                Enabled = rec."Buy-from Vendor No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
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
                        if rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", WORKDATE);
                        if ChangeExchangeRate.RUNMODAL = ACTION::OK then begin
                            rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.';

                    trigger OnValidate();
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.';

                    trigger OnValidate();
                    var
                        ApplicationAreaSetup: Record "Application Area Setup";
                    begin
                        // if ApplicationAreaSetup.IsFoundationEnabled then
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Editable = false;
                }
                // BC Upgrade VAMSIU01 - Added field >>
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade VAMSIU01 - Added field <<
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.';

                    trigger OnValidate();
                    begin
                        //HEI.03>>
                        UserSetup.GET(USERID);
                        if (rec."Payment Terms Code" <> xRec."Payment Terms Code") and (xRec."Payment Terms Code" <> '') then begin
                            ERROR(Text0001, rec.FIELDCAPTION("Payment Terms Code"));
                        end;
                        //HEI.03<<
                    end;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Editable = false;

                    trigger OnValidate();
                    begin
                        //HEI.03>>
                        UserSetup.GET(USERID);
                        if (rec."Payment Method Code" <> xRec."Payment Method Code") and (xRec."Payment Method Code" <> '') then begin
                            ERROR(Text0001, rec.FIELDCAPTION("Payment Method Code"));
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
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV;
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
                // }//BC Upgrade SHARMP16--DRINK-IT fields
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                // field("Truck Code"; Rec."Truck Code")
                // {
                // }
                // field("Driver Code"; Rec."Driver Code")
                // {
                // }//BC Upgrade SHARMP16--DRINK-iT fields
                field("Reason Code"; Rec."Reason Code")
                {
                }
                field("On Hold"; Rec."On Hold")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies if the posted invoice will be included in the payment suggestion.';
                }
                field("On Hold UserID"; Rec."On Hold UserID FND")
                {
                }
                field("On Hold Date"; Rec."On Hold Date FND")
                {
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
                        var
                            ApplicationAreaSetup: Record "Application Area Setup";
                        begin
                            //HEI.03>>
                            UserSetup.GET(USERID);
                            if (rec."Pay-to Name" <> xRec."Pay-to Name") and (xRec."Pay-to Name" <> '') then begin
                                ERROR(Text0001, rec.FIELDCAPTION("Pay-to Name"));
                            end;
                            //HEI.03<<
                            if rec.GETFILTER("Pay-to Vendor No.") = xRec."Pay-to Vendor No." then
                                if rec."Pay-to Vendor No." <> xRec."Pay-to Vendor No." then
                                    rec.SETRANGE("Pay-to Vendor No.");

                            //if ApplicationAreaSetup.IsFoundationEnabled then
                            PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

                            CurrPage.UPDATE;
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
                        //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
                        // VendLedgEntry.SETCURRENTKEY("Document No.");
                        // VendLedgEntry.SETRANGE("Contract Type", "Contract Type");
                        // VendLedgEntry.SETRANGE("DIT Sub-Contract Type", "DIT Sub-Contract Type");
                        // //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                        // case "Contract Type" of
                        //     "Contract Type"::Service:
                        //         VendLedgEntry.SETRANGE("Service Contract No.", "Service Contract No.");
                        //     "Contract Type"::Financial:
                        //         VendLedgEntry.SETRANGE("Financial Contract No.", "Financial Contract No.");
                        // end;
                        // //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                        // VendLedgEntry.SETRANGE("Contract Group Code", "Contract Group Code");
                        // VendLedgEntry.SETRANGE("Vendor Posting Group", "Vendor Posting Group");
                        // PAGE.RUN(0, VendLedgEntry);
                        // //>>DITW17.10.03 TEC1 DIT-770 #340//BC Upgrade SHARMP16--DRINK-IT fields
                    end;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                }
            }
            // group("Service/Contract")
            // {
            //     Caption = 'Service/Contract';
            //     field("Contract Type"; Rec."Contract Type")
            //     {
            //         Editable = false;
            //     }
            // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            // {
            // }
            // field("Service Contract No."; Rec."Service Contract No.")
            // {
            // }
            // field("Financial Contract No."; Rec."Financial Contract No.")
            // {
            // }
            // field("Contract Group Code"; Rec."Contract Group Code")
            // {
            // }
            //     }//BC Upgrade SHARMP16--DRINK-IT fields
        }
        area(factboxes)
        {
            //BC UPGRADE ATHUKUS01 FDDSTP_008>>
            part("Attached Documents List"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Purchase Header"),
                              "Document Type" = field("Document Type"),
                              "No." = field("No.");
                Visible = true;
            }
            part("Dimensions FactBox"; "Dimensions FactBox")
            {
                ApplicationArea = All;
                Provider = PurchLines;
                Caption = 'G/L Account Mandatory Dimensions';
                SubPageView = WHERE("Table ID" = CONST(15), "Value Posting" = CONST("Code Mandatory"));
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            //BC UPGRADE ATHUKUS01 FDDSTP_008<<
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
            // part("G/L Account Mandatory Dimensions"; "Dimensions FactBox")
            // {
            //     Caption = 'G/L Account Mandatory Dimensions';
            //     Description = 'FINXL9.00.000.01';
            //     Provider = PurchLines;
            //     SubPageLink = "No." = FIELD("No.");
            //     SubPageView = WHERE("Table ID" = CONST(15),
            //                         "Value Posting" = CONST("Code Mandatory"));
            // }
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }

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
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = NOT IsOfficeAddin;
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
            group("&Credit Memo")
            {
                Caption = '&Credit Memo';
                Image = CreditMemo;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Enabled = rec."No." <> '';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
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
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", rec."Document Type", rec."No.");
                        ApprovalEntries.RUN;
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
                }
                action("Purchase Additional")
                {
                    Caption = 'Purchase Additional';
                    Image = Purchase;
                    RunObject = Page "Purchase Additional";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                }
            }

        }
        area(Promoted)
        {
            // group(Category_Process)
            // {
            //     Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

            group(Category_Category6)
            {
                Caption = 'Posting', Comment = 'Generated from the PromotedActionCategories property index 5.';
                // ShowAs = SplitButton;

                actionref(Post_Promoted; Post_Cust)
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
                // ShowAs = SplitButton;

                actionref("Re&lease_Promoted"; Release)
                {
                }
                actionref(Reopen_Promoted; Reopen)
                {
                }
            }
            // }
            group(Category_Prepare)
            {
                Caption = 'Prepare';

                actionref(CopyDocument_Promoted; "Copy Document")
                {
                }
                // actionref(GetRecurringPurchaseLines_Promoted; GetRecurringPurchaseLines)
                // {
                // }
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
                    // actionref(IncomingDocEmailAttachment_Promoted; IncomingDocEmailAttachment)
                    // {
                    // }
                }
                actionref(CalculateInvoiceDiscount_Promoted; CalculateInvoiceDiscount)
                {
                }
                actionref(MoveNegativeLines_Promoted; "Move Negative Lines")
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
                Caption = 'Credit Memo', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref(Statistics_Promoted; Statistics) { }

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

                // actionref(PurchaseStatistics_Promoted; PurchaseStatistics)
                // {
                // }
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
                actionref(purchAseAdd_Promoted; "Purchase Additional") { }
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
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    // Promoted = true;
                    // PromotedCategory = Category4;
                    // PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    // Promoted = true;
                    // PromotedCategory = Category4;
                    // PromotedIsBig = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    // Promoted = true;
                    // PromotedCategory = Category4;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    // Promoted = true;
                    // PromotedCategory = Category4;
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
            group(ActionGroup9)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";

                    begin
                        // <<DITW15.00.00.36 DDR 07/12/2009
                        // CurrPage.UPDATE(true);
                        // // >>DITW15.00.00.36 DDR
                        // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                        // //ReleasePurchDoc.PerformManualRelease(Rec);
                        // ReleasePurchDoc.DocStatusRelease(xRec, Rec);
                        // CurrPage.UPDATE;//BC Upgrade SHARMP16--DRINK-IT code
                        // >>DITW15.00.00.39 DDR #1330 #1407
                        ReleasePurchDoc.PerformManualRelease(Rec);//BC Upgrade ATHUKUS01 FDDSTP_008<<
                        //CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = rec.Status <> rec.Status::Open;
                    Image = ReOpen;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                        //ReleasePurchDoc.PerformManualReopen(Rec);
                        // ReleasePurchDoc.DocStatusOpen(xRec, Rec);
                        // CurrPage.UPDATE;
                        // >>DITW15.00.00.39 DDR #1330 #1407
                        ReleasePurchDoc.PerformManualReopen(Rec); //BC Upgrade ATHUKUS01 FDDSTP_008<<
                        //CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Enabled = false;
                    Image = Archive;

                    trigger OnAction();
                    begin
                        //HEI.02>>
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(false);
                        //HEI.02<<
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;

                    trigger OnAction();
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount for the entire document.';

                    trigger OnAction();
                    begin
                        ApproveCalcInvDisc;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                separator(Separator128)
                {
                }
                action(ApplyEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    ShortCutKey = 'Shift+F11';
                    ToolTip = 'Apply open entries for the relevant account type.';

                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Purchase Header Apply", Rec);
                    end;
                }
                separator(Separator129)
                {
                }
                action(GetPostedDocumentLinesToReverse)
                {
                    Caption = 'Get Posted Doc&ument Lines to Reverse';
                    Ellipsis = true;
                    Image = ReverseLines;
                    ToolTip = 'Copy one or more posted purchase document lines in order to reverse the original order.';

                    trigger OnAction();
                    begin
                        //   rec.GetPstdDocLinesToRevere;
                    end;
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    // Promoted = true;
                    // PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                        if rec.GET(rec."Document Type", rec."No.") then;
                    end;
                }
                separator(Separator131)
                {
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction();
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                separator(Separator132)
                {
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCardFromEntryNo(rec."Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData "Incoming Document" = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Select Incoming Document';
                        Image = SelectLineToApply;
                        ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(rec."Incoming Document Entry No.", rec.RECORDID));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        Enabled = CreateIncomingDocumentEnabled;
                        Image = Attach;
                        ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';

                        trigger OnAction();
                        var
                            IncomingDocumentAttachment: Record "Incoming Document Attachment";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Remove Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        ToolTip = 'Remove an external document that has been recorded, manually or automatically, and attached as a file to a document or ledger entry.';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            if IncomingDocument.GET(rec."Incoming Document Entry No.") then
                                IncomingDocument.RemoveLinkToRelatedRecord;
                            rec."Incoming Document Entry No." := 0;
                            rec.MODIFY(true);
                        end;
                    }
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = Approval;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    // Promoted = true;
                    // PromotedCategory = Category5;
                    // PromotedIsBig = true;
                    // PromotedOnly = true;
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
                    // Promoted = true;
                    // PromotedCategory = Category5;
                    // PromotedIsBig = true;
                    // PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
                separator(Separator144)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post_Cust)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction();
                    var
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                    begin
                        rec.TESTFIELD("Document Date");//HEI.09
                                                       //HEI.07>>
                        if CALCDATE('-3M', rec."Posting Date") > rec."Document Date" then
                            //HEI.08>>
                            if not CONFIRM(BeforeLimit, false, rec."Document Date", rec."Posting Date") then
                                exit;
                        //ERROR(BeforeLimit);

                        //IF CALCDATE('3M',"Posting Date") < "Document Date" THEN
                        if rec."Document Date" > rec."Posting Date" then
                            ERROR(AfterLimit);
                        //IF "Posting Date" = "Document Date" THEN
                        //ERROR(EqualDate);
                        //HEI.08<<
                        //HEI.07<<
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                    Visible = NOT IsOfficeAddin;

                    trigger OnAction();
                    var
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                        AfterLimit: Label 'Document date should not be more than the Posting date.';
                    begin
                        rec.TESTFIELD("Document Date"); //HEI.09
                        //HEI.08>>
                        if CALCDATE('-3M', rec."Posting Date") > rec."Document Date" then
                            if not CONFIRM(BeforeLimit, false, rec."Document Date", rec."Posting Date") then
                                exit;

                        if rec."Document Date" > rec."Posting Date" then
                            ERROR(AfterLimit);
                        //HEI.08<<
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueVisible;

                    trigger OnAction();
                    begin
                        rec.CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        // SETFILTER("Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // // >>DITW18.00.06 DDR DIT-770 #1191
        // // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        // CALCFIELDS("Disc.Promo. Order Calculated");//BC Upgrade SHARMP16--DRINK-IT code
        // >>DITW15.00.00.34 DDR

        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(rec.RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(rec.RECORDID);
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SAVERECORD;
        exit(rec.ConfirmDeletion);
    end;

    trigger OnInit();
    begin
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        rec."Responsibility Center" := UserMgt.GetPurchasesFilter;

        if (not DocNoVisible) and (rec."No." = '') then
            rec.SetBuyFromVendorFromFilter;

        //HEI.01>>
        PurchasesPayablesSetup.GET;
        PurchasesPayablesSetup.TESTFIELD(PurchasesPayablesSetup."NPO Subtype Code FND");
        Rec."Document Subtype Code FND" := PurchasesPayablesSetup."NPO Subtype Code FND";//BC Upgrade VAMSIU01 added >>
        //HEI.01<<
    end;

    trigger OnOpenPage();
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        //<<FINXL7.00 RBE 20/03/2013
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
        // end;//BC Upgrade SHARMP16--DRINK-IT code
        //>>FINXL7.00 RBE 20/03/2013

        SetDocNoVisible;
        IsOfficeAddin := OfficeMgt.IsAvailable;

        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
        //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        // if UserMgt.GetPurchasesTextFilter <> '' then begin
        //     FILTERGROUP(2);
        //     //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
        //     SETFILTER("Responsibility Center", UserMgt.GetPurchasesTextFilter);
        //     FILTERGROUP(0);
        // end;//BC Upgrade SHARMP16--DRINK-IT code
        // >>DITW18.00.06 DDR DIT-770 #1191
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if not DocumentIsPosted then
            exit(Rec.ConfirmCloseUnposted);
    end;

    var
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        ChangeExchangeRate: Page "Change Exchange Rate";

        // BC Upgrade MISHRS14 >>
        // This attribute is blocked and not further used in Business Central 
        //[InDataSet]
        // BC Upgrade MISHRS14 <<

        JobQueueVisible: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorCreditMemoNoMandatory: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedPurchCrMemoQst: Label 'The credit memo has been posted and archived.\\Do you want to open the posted credit memo from the Posted Purchase Credit Memos window?';
        CreateIncomingDocumentEnabled: Boolean;
        Text2014411: Label 'Do you want to cancel the approval request for %1 %2?';
        StdVendPurchCode: Record "Standard Vendor Purchase Code";
        Text2014412: Label 'Do you want to send the approval request for %1 %2?';
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        recPurchSetup: Record "Purchases & Payables Setup";
        recGenJournalTemplate: Record "Gen. Journal Template";
        txtTemplateName: Text;
        blnJnlSelected: Boolean;
        // cduSingleInstaceFunctions: Codeunit "Single Instance Functions";
        cduReleasePurchDoc: Codeunit "Release Purchase Document";
        // recFinXLSetup: Record "Finance XL Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        ArchiveManagement: Codeunit ArchiveManagement;
        Text0001: Label '"You cannot modify the field- ''%1''. "';
        UserSetup: Record "User Setup";

    local procedure Post(PostingCodeunitID: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        ApplicationAreaSetup: Record "Application Area Setup";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        //if ApplicationAreaSetup.IsFoundationEnabled then
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        rec.SendToPosting(PostingCodeunitID);

        DocumentIsPosted := not PurchaseHeader.GET(rec."Document Type", rec."No.");

        if rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.CLOSE;
        CurrPage.UPDATE(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        if IsOfficeAddin then begin
            PurchCrMemoHdr.SETRANGE("Pre-Assigned No.", rec."No.");
            if PurchCrMemoHdr.FINDFIRST then
                PAGE.RUN(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
        end else
            if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
                ShowPostedConfirmationMessage;
    end;

    local procedure ApproveCalcInvDisc();
    begin
        // CurrPage.PurchLines.PAGE.rApproveCalcInvDisc;
    end;

    local procedure PurchaserCodeOnAfterValidate();
    begin
        //  CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.UPDATE;
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
          END;
        END;
        //>>FINXL7.00 RBE 06/08/2013
        */

    end;

    local procedure SetDocNoVisible();
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::"Credit Memo", rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.GET;
        VendorCreditMemoNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (rec."No." <> '');
        SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RECORDID);
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        PurchCrMemoHdr.SETRANGE("Pre-Assigned No.", Rec."No.");
        if PurchCrMemoHdr.FINDFIRST then
            if InstructionMgt.ShowConfirm(OpenPostedPurchCrMemoQst, InstructionMgt.ShowPostedConfirmationMessageCode) then
                PAGE.RUN(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
    end;

    local procedure StatusOnAfterValidate();
    begin
        // <<DITW15.00.00.34 DDR 17/06/2009
        CurrPage.UPDATE(false);
    end;

    local procedure StatusOnValidate();
    begin
        // <<DITW15.00.00.34 DDR 17/06/2009
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
        // end;//BC Upgrade SHARMP16--DRINK-IT code
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
          END;
        END;
        //>>FINXL7.00 RBE 06/08/2013
        */

    end;

}



//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = All;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of purchase document, or if the Manual Nos. field is selected for the number series.';
//                     Visible = DocNoVisible;

//                     trigger OnAssistEdit();
//                     begin
//                         if rec.AssistEdit(xRec) then
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Vendor';
//                     Importance = Promoted;
//                     QuickEntry = false;
//                     ShowMandatory = true;
//                     ToolTip = 'Specifies the name of the vendor who sends the items.';

//                     trigger OnValidate();
//                     var
//                         ApplicationAreaSetup: Record "Application Area Setup";
//                     begin
//                         if rec."No." = '' then
//                             rec.InitRecord;

//                         if rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
//                             if rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
//                                 rec.SETRANGE("Buy-from Vendor No.");

//                         //if ApplicationAreaSetup.IsFoundationEnabled then
//                         PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

//                         CurrPage.UPDATE;

//                         // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
//                         // COMMIT;
//                         // StdVendPurchCode.AutoInsertPurchLines(Rec);
//                         // // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)

//                         // //<<FINXL7.00 RBE 06/08/2013
//                         // if recFinXLSetup.READPERMISSION then
//                         //     UpdateAfterChangingHeader;
//                         // //>>FINXL7.00 RBE 06/08/2013//BC upgrade SHARMP16--DR
//                     end;
//                 }
//                 group("Buy-from")
//                 {
//                     Caption = 'Buy-from';
//                     field("Buy-from Address"; Rec."Buy-from Address")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Address';
//                         Importance = Additional;
//                         ToolTip = 'Specifies the address of the vendor who ships the items.';
//                     }
//                     field("Buy-from Address 2"; Rec."Buy-from Address 2")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Address 2';
//                         Importance = Additional;
//                         ToolTip = 'Specifies additional address information.';
//                     }
//                     field("Buy-from Post Code"; Rec."Buy-from Post Code")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Post Code';
//                         Importance = Additional;
//                         ToolTip = 'Specifies the postal code.';
//                     }
//                     field("Buy-from City"; Rec."Buy-from City")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'City';
//                         Importance = Additional;
//                         QuickEntry = false;
//                         ToolTip = 'Specifies the city of the vendor who ships the items.';
//                     }
//                     field("Buy-from Contact No."; Rec."Buy-from Contact No.")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Contact No.';
//                         Importance = Additional;
//                         QuickEntry = false;
//                         ToolTip = 'Specifies the number of your contact at the vendor.';
//                     }
//                 }
//                 field("Buy-from Contact"; Rec."Buy-from Contact")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Contact';
//                     ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
//                 }
//                 field("Your Reference"; Rec."Your Reference")
//                 {
//                     Description = 'FINXL7.00.001';
//                 }
//                 field("Posting Description"; Rec."Posting Description")
//                 {
//                     Description = 'FINXL7.00.001';
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     QuickEntry = false;
//                     ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     QuickEntry = false;
//                     ToolTip = 'Specifies the date on which the vendor created the purchase document.';
//                 }
//                 // field("Tax Date"; Rec."Tax Date")
//                 // {
//                 // }//Bc upgrade SHARMp16--DRINK-It fields
//                 field("Due Date"; Rec."Due Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields.';

//                     trigger OnValidate();
//                     begin
//                         //HEI.03>>
//                         UserSetup.GET(USERID);
//                         if (rec."Due Date" <> xRec."Due Date") and (xRec."Due Date" <> 0D) then begin
//                             ERROR(Text0001, rec.FIELDCAPTION("Due Date"));
//                         end;
//                         //HEI.03<<
//                     end;
//                 }
//                 field("Expected Receipt Date"; Rec."Expected Receipt Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the date you expect to receive the items on the purchase document.';
//                 }
//                 field("Vendor Authorization No."; Rec."Vendor Authorization No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the identification number of a compensation agreement.';
//                 }
//                 field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
//                 {
//                     ToolTip = 'Specifies the number of the incoming document that this purchase document is created for.';
//                     Visible = false;
//                 }
//                 field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ShowMandatory = VendorCreditMemoNoMandatory;
//                     ToolTip = 'Specifies the number that the vendor uses for the credit memo you are creating in this purchase credit memo header.';
//                 }
//                 field("Order Address Code"; Rec."Order Address Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
//                 }
//                 field("Purchaser Code"; Rec."Purchaser Code")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies which purchaser is assigned to the vendor.';

//                     trigger OnValidate();
//                     begin
//                         PurchaserCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Campaign No."; Rec."Campaign No.")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies the campaign number the document is linked to.';
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
//                 }
//                 field("Assigned User ID"; Rec."Assigned User ID")
//                 {
//                     Importance = Additional;
//                     QuickEntry = false;
//                     ToolTip = 'Specifies the ID of the user who is responsible for the document.';
//                 }
//                 field("Job Queue Status"; Rec."Job Queue Status")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
//                 }
//                 // field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
//                 // {
//                 // }//c Upgrade SHARMP16--DRINK-IT fields
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                     Importance = Promoted;
//                     QuickEntry = false;
//                     ToolTip = 'Specifies whether the record is open, is waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';

//                     trigger OnValidate();
//                     begin
//                         StatusOnValidate;
//                         StatusOnAfterValidate;
//                     end;
//                 }
//                 // field("Creation Date/Time"; Rec."Creation Date/Time")
//                 // {
//                 //     Description = 'DITW18.00.07 DIT-770 #1282';
//                 //     Importance = Additional;
//                 // }
//                 // field("Created By"; Rec."Created By")
//                 // {
//                 //     Description = 'DITW18.00.07 DIT-770 #1282';
//                 //     Importance = Additional;
//                 // }
//                 // field("Linked Customer No."; Rec."Linked Customer No.")
//                 // {
//                 //     Importance = Additional;
//                 //BC UPGRADE FDD STP007 ATHUKS01<<
//                 // }//BC Upgrade SHARMP16--DRINK-IT fields
//                 // field("Doc. Amount Incl. VAT"; Rec."Doc. Amount Incl. VAT")
//                 // {
//                 //     Description = 'FINXL7.00.001';
//                 // }
//                 // field("Doc. Amount VAT"; Rec."Doc. Amount VAT")
//                 // {
//                 //     Description = 'FINXL7.00.001';
//                 // }


//                 field("Doc. Amount Incl. VAT IBM"; Rec."Doc. Amount Incl. VAT IBM")
//                 {
//                     Caption = 'Doc. Amount Incl. VAT';
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Doc. Amount Incl. VAT field.';

//                 }
//                 field("Doc. Amount VAT IBM"; Rec."Doc. Amount VAT IBM")
//                 {
//                     Caption = 'Doc. Amount VAT';
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Doc. Amount VAT field.';
//                 }
//                 //BC UPGRADE FDD STP007 ATHUKS01>>
//             }
//             part(PurchLines; "NPO Purch. Cr. Memo Subform")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Editable = rec."Buy-from Vendor No." <> '';
//                 Enabled = rec."Buy-from Vendor No." <> '';
//                 SubPageLink = "Document No." = FIELD("No.");
//                 UpdatePropagation = Both;
//             }
//             group("Invoice Details")
//             {
//                 Caption = 'Invoice Details';
//                 field("Currency Code"; Rec."Currency Code")
//                 {
//                     ApplicationArea = Suite;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the currency code for amounts on the purchase lines.';

//                     trigger OnAssistEdit();
//                     begin
//                         CLEAR(ChangeExchangeRate);
//                         if rec."Posting Date" <> 0D then
//                             ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", rec."Posting Date")
//                         else
//                             ChangeExchangeRate.SetParameter(rec."Currency Code", rec."Currency Factor", WORKDATE);
//                         if ChangeExchangeRate.RUNMODAL = ACTION::OK then begin
//                             rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
//                             CurrPage.UPDATE;
//                         end;
//                         CLEAR(ChangeExchangeRate);
//                     end;

//                     trigger OnValidate();
//                     begin
//                         CurrPage.UPDATE;
//                         PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
//                     end;
//                 }
//                 field("Prices Including VAT"; Rec."Prices Including VAT")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.';

//                     trigger OnValidate();
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.';

//                     trigger OnValidate();
//                     var
//                         ApplicationAreaSetup: Record "Application Area Setup";
//                     begin
//                         // if ApplicationAreaSetup.IsFoundationEnabled then
//                         PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
//                     end;
//                 }
//                 field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
//                 {
//                 }
//                 field("Vendor Posting Group"; Rec."Vendor Posting Group")
//                 {
//                     Editable = false;
//                 }
//                 // BC Upgrade VAMSIU01 - Added field >>
//                 field("Document Subtype Code"; Rec."Document Subtype Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 // BC Upgrade VAMSIU01 - Added field <<
//                 field("Payment Terms Code"; Rec."Payment Terms Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the purchase document.';

//                     trigger OnValidate();
//                     begin
//                         //HEI.03>>
//                         UserSetup.GET(USERID);
//                         if (rec."Payment Terms Code" <> xRec."Payment Terms Code") and (xRec."Payment Terms Code" <> '') then begin
//                             ERROR(Text0001, rec.FIELDCAPTION("Payment Terms Code"));
//                         end;
//                         //HEI.03<<
//                     end;
//                 }
//                 field("Payment Method Code"; Rec."Payment Method Code")
//                 {
//                     Editable = false;

//                     trigger OnValidate();
//                     begin
//                         //HEI.03>>
//                         UserSetup.GET(USERID);
//                         if (rec."Payment Method Code" <> xRec."Payment Method Code") and (xRec."Payment Method Code" <> '') then begin
//                             ERROR(Text0001, rec.FIELDCAPTION("Payment Method Code"));
//                         end;
//                         //HEI.03<<
//                     end;
//                 }
//                 field("Transaction Type"; Rec."Transaction Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the number for the transaction type, for the purpose of reporting to Intrastat.';
//                 }
//                 field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the code for Shortcut Dimension 1.';

//                     trigger OnValidate();
//                     begin
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }
//                 field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
//                 {
//                     ApplicationArea = Suite;
//                     ToolTip = 'Specifies the code for Shortcut Dimension 2.';

//                     trigger OnValidate();
//                     begin
//                         ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field("Payment Discount %"; Rec."Payment Discount %")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the payment discount percent that will be given if you pay for the purchase on or before the date in the Pmt. Discount Date field.';
//                 }
//                 field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                     ToolTip = 'Specifies the last date on which you can pay the invoice and still receive a payment discount.';
//                 }
//                 // field("Physical Location Group Code"; Rec."Physical Location Group Code")
//                 // {
//                 //     Importance = Additional;
//                 //     QuickEntry = false;

//                 //     trigger OnValidate();
//                 //     begin
//                 //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
//                 //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
//                 //             CurrPage.UPDATE(true);
//                 //         // >>DITW18.00.06 DDR DIT-770 #1191
//                 //     end;
//                 // }//BC Upgrade SHARMP16--DRINK-IT fields
//                 field("Location Code"; Rec."Location Code")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
//                 }
//                 // field("Truck Code"; Rec."Truck Code")
//                 // {
//                 // }
//                 // field("Driver Code"; Rec."Driver Code")
//                 // {
//                 // }//BC Upgrade SHARMP16--DRINK-iT fields
//                 field("Reason Code"; Rec."Reason Code")
//                 {
//                 }
//                 field("On Hold"; Rec."On Hold")
//                 {
//                     Importance = Additional;
//                     ToolTip = 'Specifies if the posted invoice will be included in the payment suggestion.';
//                 }
//                 field("On Hold UserID"; Rec."On Hold UserID")
//                 {
//                 }
//                 field("On Hold Date"; Rec."On Hold Date")
//                 {
//                 }
//             }
//             group("Shipping and Payment")
//             {
//                 Caption = 'Shipping and Payment';
//                 group("Ship-to")
//                 {
//                     Caption = 'Ship-to';
//                     field("Ship-to Name"; Rec."Ship-to Name")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Name';
//                         ToolTip = 'Specifies the name of the company at the address to which you want the items in the purchase order to be shipped.';
//                     }
//                     field("Ship-to Address"; Rec."Ship-to Address")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Address';
//                         ToolTip = 'Specifies the address that you want the items in the purchase order to be shipped to.';
//                     }
//                     field("Ship-to Address 2"; Rec."Ship-to Address 2")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Address 2';
//                         ToolTip = 'Specifies additional address information.';
//                     }
//                     field("Ship-to Post Code"; Rec."Ship-to Post Code")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Post Code';
//                         ToolTip = 'Specifies the postal code.';
//                     }
//                     field("Ship-to City"; Rec."Ship-to City")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'City';
//                         ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
//                     }
//                     field("Ship-to Contact"; Rec."Ship-to Contact")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Contact';
//                         ToolTip = 'Specifies the name of a contact person for the address where the items in the purchase order should be shipped.';
//                     }
//                 }
//                 group("Pay-to")
//                 {
//                     Caption = 'Pay-to';
//                     field("Pay-to Name"; Rec."Pay-to Name")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Name';
//                         Importance = Promoted;
//                         ToolTip = 'Specifies the vendor who is sending the invoice.';

//                         trigger OnValidate();
//                         var
//                             ApplicationAreaSetup: Record "Application Area Setup";
//                         begin
//                             //HEI.03>>
//                             UserSetup.GET(USERID);
//                             if (rec."Pay-to Name" <> xRec."Pay-to Name") and (xRec."Pay-to Name" <> '') then begin
//                                 ERROR(Text0001, rec.FIELDCAPTION("Pay-to Name"));
//                             end;
//                             //HEI.03<<
//                             if rec.GETFILTER("Pay-to Vendor No.") = xRec."Pay-to Vendor No." then
//                                 if rec."Pay-to Vendor No." <> xRec."Pay-to Vendor No." then
//                                     rec.SETRANGE("Pay-to Vendor No.");

//                             //if ApplicationAreaSetup.IsFoundationEnabled then
//                             PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

//                             CurrPage.UPDATE;
//                         end;
//                     }
//                     field("Pay-to Address"; Rec."Pay-to Address")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Address';
//                         Importance = Additional;
//                         ToolTip = 'Specifies the address of the vendor sending the invoice.';
//                     }
//                     field("Pay-to Address 2"; Rec."Pay-to Address 2")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Address 2';
//                         Importance = Additional;
//                         ToolTip = 'Specifies additional address information.';
//                     }
//                     field("Pay-to Post Code"; Rec."Pay-to Post Code")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Post Code';
//                         Importance = Additional;
//                         ToolTip = 'Specifies the postal code.';
//                     }
//                     field("Pay-to City"; Rec."Pay-to City")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'City';
//                         Importance = Additional;
//                         ToolTip = 'Specifies the city of the vendor sending the invoice.';
//                     }
//                     field("Pay-to Contact No."; Rec."Pay-to Contact No.")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Contact No.';
//                         Importance = Additional;
//                         ToolTip = 'Specifies the number of the contact who sends the invoice.';
//                     }
//                     field("Pay-to Contact"; Rec."Pay-to Contact")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Contact';
//                         ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
//                     }
//                     field("Vendor Bank Account"; Rec."Vendor Bank Account")
//                     {
//                     }
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 field("Transaction Specification"; Rec."Transaction Specification")
//                 {
//                     ToolTip = 'Specifies a code for the purchase header''s transaction specification here.';
//                 }
//                 field("Transport Method"; Rec."Transport Method")
//                 {
//                     ToolTip = 'Specifies the code for the transport method to be used with this purchase header.';
//                 }
//                 field("Entry Point"; Rec."Entry Point")
//                 {
//                     ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region.';
//                 }
//                 field("Area"; Rec.Area)
//                 {
//                     ToolTip = 'Specifies the code for the area of the vendor''s address.';
//                 }
//             }
//             group(Application)
//             {
//                 Caption = 'Application';
//                 field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
//                 }
//                 field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';

//                     trigger OnDrillDown();
//                     var
//                         VendLedgEntry: Record "Vendor Ledger Entry";
//                     begin
//                         //<<DITW17.10.03 TEC1 05/02/2014 DIT-770 #340
//                         // VendLedgEntry.SETCURRENTKEY("Document No.");
//                         // VendLedgEntry.SETRANGE("Contract Type", "Contract Type");
//                         // VendLedgEntry.SETRANGE("DIT Sub-Contract Type", "DIT Sub-Contract Type");
//                         // //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
//                         // case "Contract Type" of
//                         //     "Contract Type"::Service:
//                         //         VendLedgEntry.SETRANGE("Service Contract No.", "Service Contract No.");
//                         //     "Contract Type"::Financial:
//                         //         VendLedgEntry.SETRANGE("Financial Contract No.", "Financial Contract No.");
//                         // end;
//                         // //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
//                         // VendLedgEntry.SETRANGE("Contract Group Code", "Contract Group Code");
//                         // VendLedgEntry.SETRANGE("Vendor Posting Group", "Vendor Posting Group");
//                         // PAGE.RUN(0, VendLedgEntry);
//                         // //>>DITW17.10.03 TEC1 DIT-770 #340//BC Upgrade SHARMP16--DRINK-IT fields
//                     end;
//                 }
//                 field("Applies-to ID"; Rec."Applies-to ID")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
//                 }
//             }
//             // group("Service/Contract")
//             // {
//             //     Caption = 'Service/Contract';
//             //     field("Contract Type"; Rec."Contract Type")
//             //     {
//             //         Editable = false;
//             //     }
//             // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
//             // {
//             // }
//             // field("Service Contract No."; Rec."Service Contract No.")
//             // {
//             // }
//             // field("Financial Contract No."; Rec."Financial Contract No.")
//             // {
//             // }
//             // field("Contract Group Code"; Rec."Contract Group Code")
//             // {
//             // }
//             //     }//BC Upgrade SHARMP16--DRINK-IT fields
//         }
//         area(factboxes)
//         {
//             // 31March2026
//             part("Dimensions FactBox"; "Dimensions FactBox")
//             {
//                 ApplicationArea = All;
//                 Provider = PurchLines;
//                 Caption = 'G/L Account Mandatory Dimensions';
//                 SubPageView = WHERE("Table ID" = CONST(15), "Value Posting" = CONST("Code Mandatory"));
//                 SubPageLink = "No." = FIELD("No.");
//             }
//             // 31March2026
//             part(Control15; "Pending Approval FactBox")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "Table ID" = CONST(38),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = OpenApprovalEntriesExistForCurrUser;
//             }
//             part(ApprovalFactBox; "Approval FactBox")
//             {
//                 Visible = false;
//             }
//             part("G/L Account Mandatory Dimensions"; "Dimensions FactBox")
//             {
//                 Caption = 'G/L Account Mandatory Dimensions';
//                 Description = 'FINXL9.00.000.01';
//                 Provider = PurchLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 SubPageView = WHERE("Table ID" = CONST(15),
//                                     "Value Posting" = CONST("Code Mandatory"));
//             }
//             part(Control1901138007; "Vendor Details FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No.");
//                 Visible = false;
//             }

//             part(Control1904651607; "Vendor Statistics FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Pay-to Vendor No.");
//             }
//             part(Control1903435607; "Vendor Hist. Buy-from FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No.");
//             }
//             part(Control1906949207; "Vendor Hist. Pay-to FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Pay-to Vendor No.");
//                 Visible = false;
//             }
//             part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
//             {
//                 ShowFilter = false;
//                 Visible = NOT IsOfficeAddin;
//             }
//             part(WorkflowStatus; "Workflow Status FactBox")
//             {
//                 ApplicationArea = All;
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//             }
//             systempart(Control1900383207; Links)
//             {
//                 Visible = false;
//             }
//             systempart(Control1905767507; Notes)
//             {
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Credit Memo")
//             {
//                 Caption = '&Credit Memo';
//                 Image = CreditMemo;
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     // Promoted = true;
//                     // PromotedCategory = Process;
//                     ShortCutKey = 'F7';

//                     trigger OnAction();
//                     begin
//                         Rec.CalcInvDiscForHeader;
//                         COMMIT;
//                         PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action(Vendor)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Vendor';
//                     Image = Vendor;
//                     RunObject = Page "Vendor Card";
//                     RunPageLink = "No." = FIELD("Buy-from Vendor No.");
//                     ShortCutKey = 'Shift+F7';
//                     ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData Dimension = R;
//                     ApplicationArea = Suite;
//                     Caption = 'Dimensions';
//                     Enabled = rec."No." <> '';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';
//                     ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

//                     trigger OnAction();
//                     begin
//                         rec.ShowDocDim;
//                         CurrPage.SAVERECORD;
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     AccessByPermission = TableData "Approval Entry" = R;
//                     ApplicationArea = Suite;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

//                     trigger OnAction();
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                     begin
//                         ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", rec."Document Type", rec."No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page "Purch. Comment Sheet";
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "No." = FIELD("No."),
//                                   "Document Line No." = CONST(0);
//                 }
//                 action("Purchase Additional")
//                 {
//                     Caption = 'Purchase Additional';
//                     Image = Purchase;
//                     RunObject = Page "Purchase Additional";
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "No." = FIELD("No.");
//                 }
//             }

//         }
//         area(Promoted)
//         {
//             group(Category_Category5)
//             {
//                 Caption = 'Credit Memo', Comment = 'Generated from the PromotedActionCategories property index 4.';

//                 actionref(Dimensions_Promoted; Dimensions)
//                 {
//                 }

//                 // BC Upgrade MISHRS14 >>
//                 // Blocked the below action reference as action -Statistics is blocked above.
//                 // #if not CLEAN26
//                 //                 actionref(Statistics_Promoted; Statistics)
//                 //                 {
//                 //                     ObsoleteReason = 'The statistics action will be replaced with the PurchaseStatistics action. The new action uses RunObject and does not run the action trigger. Use a page extension to modify the behaviour.';
//                 //                     ObsoleteState = Pending;
//                 //                     ObsoleteTag = '26.0';
//                 //                 }
//                 // #else
//                 // BC Upgrade MISHRS14 <<

//                 // actionref(PurchaseStatistics_Promoted; PurchaseStatistics)
//                 // {
//                 // }
//                 // #endif
//                 actionref("Co&mments_Promoted"; "Co&mments")
//                 {
//                 }
//                 // actionref(DocAttach_Promoted; DocAttach)
//                 // {
//                 // }
//                 actionref(Approvals_Promoted; Approvals)
//                 {
//                 }
//                 separator(Navigate_Separator)
//                 {
//                 }
//                 actionref(Vendor_Promoted; Vendor)
//                 {
//                 }
//                 actionref(purchAseAdd_Promoted; "Purchase Additional") { }
//             }
//         }
//         area(processing)
//         {
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Approve';
//                     Image = Approve;
//                     // Promoted = true;
//                     // PromotedCategory = Category4;
//                     // PromotedIsBig = true;
//                     ToolTip = 'Approve the requested changes.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RECORDID);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Reject';
//                     Image = Reject;
//                     // Promoted = true;
//                     // PromotedCategory = Category4;
//                     // PromotedIsBig = true;
//                     ToolTip = 'Reject the approval request.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.RejectRecordApprovalRequest(rec.RECORDID);
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     // Promoted = true;
//                     // PromotedCategory = Category4;
//                     ToolTip = 'Delegate the approval to a substitute approver.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RECORDID);
//                     end;
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     // Promoted = true;
//                     // PromotedCategory = Category4;
//                     ToolTip = 'View or add comments.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.GetApprovalComment(Rec);
//                     end;
//                 }
//             }
//             group(ActionGroup9)
//             {
//                 Caption = 'Release';
//                 Image = ReleaseDoc;
//                 action(Release)
//                 {
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     // Promoted = true;
//                     // PromotedCategory = Process;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction();
//                     var
//                         ReleasePurchDoc: Codeunit "Release Purchase Document";
//                     begin
//                         // <<DITW15.00.00.36 DDR 07/12/2009
//                         // CurrPage.UPDATE(true);
//                         // // >>DITW15.00.00.36 DDR
//                         // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
//                         // //ReleasePurchDoc.PerformManualRelease(Rec);
//                         // ReleasePurchDoc.DocStatusRelease(xRec, Rec);
//                         // CurrPage.UPDATE;//BC Upgrade SHARMP16--DRINK-IT code
//                         // >>DITW15.00.00.39 DDR #1330 #1407
//                     end;
//                 }
//                 action(Reopen)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Re&open';
//                     Enabled = rec.Status <> rec.Status::Open;
//                     Image = ReOpen;
//                     // Promoted = true;
//                     // PromotedCategory = Process;
//                     ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

//                     trigger OnAction();
//                     var
//                         ReleasePurchDoc: Codeunit "Release Purchase Document";
//                     begin
//                         // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
//                         //ReleasePurchDoc.PerformManualReopen(Rec);
//                         // ReleasePurchDoc.DocStatusOpen(xRec, Rec);
//                         // CurrPage.UPDATE;
//                         // >>DITW15.00.00.39 DDR #1330 #1407
//                     end;
//                 }
//                 action("Archive Document")
//                 {
//                     Caption = 'Archi&ve Document';
//                     Enabled = false;
//                     Image = Archive;

//                     trigger OnAction();
//                     begin
//                         //HEI.02>>
//                         ArchiveManagement.ArchivePurchDocument(Rec);
//                         CurrPage.UPDATE(false);
//                         //HEI.02<<
//                     end;
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("Get St&d. Vend. Purchase Codes")
//                 {
//                     Caption = 'Get St&d. Vend. Purchase Codes';
//                     Ellipsis = true;
//                     Image = VendorCode;

//                     trigger OnAction();
//                     var
//                         StdVendPurchCode: Record "Standard Vendor Purchase Code";
//                     begin
//                         StdVendPurchCode.InsertPurchLines(Rec);
//                     end;
//                 }
//                 action(CalculateInvoiceDiscount)
//                 {
//                     AccessByPermission = TableData "Vendor Invoice Disc." = R;
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;
//                     ToolTip = 'Calculate the invoice discount for the entire document.';

//                     trigger OnAction();
//                     begin
//                         ApproveCalcInvDisc;
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 separator(Separator128)
//                 {
//                 }
//                 action(ApplyEntries)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Apply Entries';
//                     Ellipsis = true;
//                     Image = ApplyEntries;
//                     // Promoted = true;
//                     // PromotedCategory = Process;
//                     ShortCutKey = 'Shift+F11';
//                     ToolTip = 'Apply open entries for the relevant account type.';

//                     trigger OnAction();
//                     begin
//                         CODEUNIT.RUN(CODEUNIT::"Purchase Header Apply", Rec);
//                     end;
//                 }
//                 separator(Separator129)
//                 {
//                 }
//                 action(GetPostedDocumentLinesToReverse)
//                 {
//                     Caption = 'Get Posted Doc&ument Lines to Reverse';
//                     Ellipsis = true;
//                     Image = ReverseLines;
//                     ToolTip = 'Copy one or more posted purchase document lines in order to reverse the original order.';

//                     trigger OnAction();
//                     begin
//                         //   rec.GetPstdDocLinesToRevere;
//                     end;
//                 }
//                 action("Copy Document")
//                 {
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     // Promoted = true;
//                     // PromotedCategory = Process;

//                     trigger OnAction();
//                     begin
//                         CopyPurchDoc.SetPurchHeader(Rec);
//                         CopyPurchDoc.RUNMODAL;
//                         CLEAR(CopyPurchDoc);
//                         if rec.GET(rec."Document Type", rec."No.") then;
//                     end;
//                 }
//                 separator(Separator131)
//                 {
//                 }
//                 action("Move Negative Lines")
//                 {
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;

//                     trigger OnAction();
//                     begin
//                         CLEAR(MoveNegPurchLines);
//                         MoveNegPurchLines.SetPurchHeader(Rec);
//                         MoveNegPurchLines.RUNMODAL;
//                         MoveNegPurchLines.ShowDocument;
//                     end;
//                 }
//                 separator(Separator132)
//                 {
//                 }
//                 group(IncomingDocument)
//                 {
//                     Caption = 'Incoming Document';
//                     Image = Documents;
//                     action(IncomingDocCard)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'View Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = ViewOrder;
//                         ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

//                         trigger OnAction();
//                         var
//                             IncomingDocument: Record "Incoming Document";
//                         begin
//                             IncomingDocument.ShowCardFromEntryNo(rec."Incoming Document Entry No.");
//                         end;
//                     }
//                     action(SelectIncomingDoc)
//                     {
//                         AccessByPermission = TableData "Incoming Document" = R;
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Select Incoming Document';
//                         Image = SelectLineToApply;
//                         ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

//                         trigger OnAction();
//                         var
//                             IncomingDocument: Record "Incoming Document";
//                         begin
//                             rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(rec."Incoming Document Entry No.", rec.RECORDID));
//                         end;
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Create Incoming Document from File';
//                         Ellipsis = true;
//                         Enabled = CreateIncomingDocumentEnabled;
//                         Image = Attach;
//                         ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';

//                         trigger OnAction();
//                         var
//                             IncomingDocumentAttachment: Record "Incoming Document Attachment";
//                         begin
//                             IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
//                         end;
//                     }
//                     action(RemoveIncomingDoc)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Remove Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = RemoveLine;
//                         ToolTip = 'Remove an external document that has been recorded, manually or automatically, and attached as a file to a document or ledger entry.';

//                         trigger OnAction();
//                         var
//                             IncomingDocument: Record "Incoming Document";
//                         begin
//                             if IncomingDocument.GET(rec."Incoming Document Entry No.") then
//                                 IncomingDocument.RemoveLinkToRelatedRecord;
//                             rec."Incoming Document Entry No." := 0;
//                             rec.MODIFY(true);
//                         end;
//                     }
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 Image = Approval;
//                 action(SendApprovalRequest)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     // Promoted = true;
//                     // PromotedCategory = Category5;
//                     // PromotedIsBig = true;
//                     // PromotedOnly = true;
//                     ToolTip = 'Send an approval request.';

//                     trigger OnAction();
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
//                             ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = CanCancelApprovalForRecord;
//                     Image = CancelApprovalRequest;
//                     // Promoted = true;
//                     // PromotedCategory = Category5;
//                     // PromotedIsBig = true;
//                     // PromotedOnly = true;
//                     ToolTip = 'Cancel the approval request.';

//                     trigger OnAction();
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
//                     end;
//                 }
//                 separator(Separator144)
//                 {
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(Post_Cust)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'P&ost';
//                     Image = PostOrder;
//                     // Promoted = true;
//                     // PromotedCategory = Process;
//                     // PromotedIsBig = true;
//                     ShortCutKey = 'F9';
//                     ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

//                     trigger OnAction();
//                     var
//                         BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
//                         AfterLimit: Label 'Document date should not be more than the Posting date.';
//                     begin
//                         rec.TESTFIELD("Document Date");//HEI.09
//                                                        //HEI.07>>
//                         if CALCDATE('-3M', rec."Posting Date") > rec."Document Date" then
//                             //HEI.08>>
//                             if not CONFIRM(BeforeLimit, false, rec."Document Date", rec."Posting Date") then
//                                 exit;
//                         //ERROR(BeforeLimit);

//                         //IF CALCDATE('3M',"Posting Date") < "Document Date" THEN
//                         if rec."Document Date" > rec."Posting Date" then
//                             ERROR(AfterLimit);
//                         //IF "Posting Date" = "Document Date" THEN
//                         //ERROR(EqualDate);
//                         //HEI.08<<
//                         //HEI.07<<
//                         Post(CODEUNIT::"Purch.-Post (Yes/No)");
//                     end;
//                 }
//                 action(Preview)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;
//                     ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

//                     trigger OnAction();
//                     var
//                         PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
//                     begin
//                         PurchPostYesNo.Preview(Rec);
//                     end;
//                 }
//                 action(TestReport)
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;
//                     ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

//                     trigger OnAction();
//                     begin
//                         ReportPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action(PostAndPrint)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Post and &Print';
//                     Image = PostPrint;
//                     // Promoted = true;
//                     // PromotedCategory = Process;
//                     // PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';
//                     ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
//                     Visible = NOT IsOfficeAddin;

//                     trigger OnAction();
//                     var
//                         BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
//                         AfterLimit: Label 'Document date should not be more than the Posting date.';
//                     begin
//                         rec.TESTFIELD("Document Date"); //HEI.09
//                         //HEI.08>>
//                         if CALCDATE('-3M', rec."Posting Date") > rec."Document Date" then
//                             if not CONFIRM(BeforeLimit, false, rec."Document Date", rec."Posting Date") then
//                                 exit;

//                         if rec."Document Date" > rec."Posting Date" then
//                             ERROR(AfterLimit);
//                         //HEI.08<<
//                         Post(CODEUNIT::"Purch.-Post + Print");
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     ToolTip = 'Remove the scheduled processing of this record from the job queue.';
//                     Visible = JobQueueVisible;

//                     trigger OnAction();
//                     begin
//                         rec.CancelBackgroundPosting;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord();
//     begin
//         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
//         // SETFILTER("Resp. Center Table Filter",
//         //   UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
//         // SETFILTER("Phys. Location Table Filter",
//         //   UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
//         // SETFILTER("Location Table Filter",
//         //   UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
//         // // >>DITW18.00.06 DDR DIT-770 #1191
//         // // <<DITW15.00.00.39 DDR 27/07/2011 #1407
//         // CALCFIELDS("Disc.Promo. Order Calculated");//BC Upgrade SHARMP16--DRINK-IT code
//         // >>DITW15.00.00.34 DDR

//         SetControlAppearance;
//         CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
//         CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(rec.RECORDID);
//         ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(rec.RECORDID);
//     end;

//     trigger OnDeleteRecord(): Boolean;
//     begin
//         CurrPage.SAVERECORD;
//         exit(rec.ConfirmDeletion);
//     end;

//     trigger OnInit();
//     begin
//         SetExtDocNoMandatoryCondition;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean);
//     begin
//         rec."Responsibility Center" := UserMgt.GetPurchasesFilter;

//         if (not DocNoVisible) and (rec."No." = '') then
//             rec.SetBuyFromVendorFromFilter;

//         //HEI.01>>
//         PurchasesPayablesSetup.GET;
//         PurchasesPayablesSetup.TESTFIELD(PurchasesPayablesSetup."NPO Subtype Code");
//         Rec."Document Subtype Code" := PurchasesPayablesSetup."NPO Subtype Code";//BC Upgrade VAMSIU01 added >>
//         //HEI.01<<
//     end;

//     trigger OnOpenPage();
//     var
//         OfficeMgt: Codeunit "Office Management";
//     begin
//         //<<FINXL7.00 RBE 20/03/2013
//         // if recFinXLSetup.READPERMISSION then begin
//         //     recPurchSetup.GET;
//         //     txtTemplateName := '';
//         //     if cduSingleInstaceFunctions.fctGetPurchCrMemoPages > 0 then begin
//         //         txtTemplateName := cduSingleInstaceFunctions.fctGetPurchCrMemoTemplate;
//         //         cduSingleInstaceFunctions.fctTrackPurchCrMemoPage(false, txtTemplateName);
//         //     end
//         //     else
//         //         if recPurchSetup."Show Jnl. Template Selection" then begin
//         //             recGenJournalTemplate.RESET;
//         //             recGenJournalTemplate.SETRANGE(Type, recGenJournalTemplate.Type::Purchases);
//         //             recGenJournalTemplate.SETRANGE("Credit Memo", true);

//         //             if recGenJournalTemplate.COUNT > 1 then begin
//         //                 blnJnlSelected := PAGE.RUNMODAL(0, recGenJournalTemplate) = ACTION::LookupOK;

//         //                 if not blnJnlSelected then
//         //                     ERROR('');
//         //             end else
//         //                 recGenJournalTemplate.FINDFIRST;
//         //             txtTemplateName := recGenJournalTemplate.Name;
//         //             cduSingleInstaceFunctions.fctTrackPurchCrMemoPage(false, txtTemplateName);
//         //         end;
//         // end;//BC Upgrade SHARMP16--DRINK-IT code
//         //>>FINXL7.00 RBE 20/03/2013

//         SetDocNoVisible;
//         IsOfficeAddin := OfficeMgt.IsAvailable;

//         // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
//         //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
//         // if UserMgt.GetPurchasesTextFilter <> '' then begin
//         //     FILTERGROUP(2);
//         //     //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
//         //     SETFILTER("Responsibility Center", UserMgt.GetPurchasesTextFilter);
//         //     FILTERGROUP(0);
//         // end;//BC Upgrade SHARMP16--DRINK-IT code
//         // >>DITW18.00.06 DDR DIT-770 #1191
//     end;

//     trigger OnQueryClosePage(CloseAction: Action): Boolean;
//     begin
//         if not DocumentIsPosted then
//             exit(Rec.ConfirmCloseUnposted);
//     end;

//     var
//         CopyPurchDoc: Report "Copy Purchase Document";
//         MoveNegPurchLines: Report "Move Negative Purchase Lines";
//         ReportPrint: Codeunit "Test Report-Print";
//         UserMgt: Codeunit "User Setup Management";
//         PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
//         LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
//         ChangeExchangeRate: Page "Change Exchange Rate";

//         // BC Upgrade MISHRS14 >>
//         // This attribute is blocked and not further used in Business Central 
//         //[InDataSet]
//         // BC Upgrade MISHRS14 <<

//         JobQueueVisible: Boolean;
//         HasIncomingDocument: Boolean;
//         DocNoVisible: Boolean;
//         VendorCreditMemoNoMandatory: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         ShowWorkflowStatus: Boolean;
//         IsOfficeAddin: Boolean;
//         CanCancelApprovalForRecord: Boolean;
//         DocumentIsPosted: Boolean;
//         OpenPostedPurchCrMemoQst: Label 'The credit memo has been posted and archived.\\Do you want to open the posted credit memo from the Posted Purchase Credit Memos window?';
//         CreateIncomingDocumentEnabled: Boolean;
//         Text2014411: Label 'Do you want to cancel the approval request for %1 %2?';
//         StdVendPurchCode: Record "Standard Vendor Purchase Code";
//         Text2014412: Label 'Do you want to send the approval request for %1 %2?';
//         ReleasePurchDoc: Codeunit "Release Purchase Document";
//         recPurchSetup: Record "Purchases & Payables Setup";
//         recGenJournalTemplate: Record "Gen. Journal Template";
//         txtTemplateName: Text;
//         blnJnlSelected: Boolean;
//         // cduSingleInstaceFunctions: Codeunit "Single Instance Functions";
//         cduReleasePurchDoc: Codeunit "Release Purchase Document";
//         // recFinXLSetup: Record "Finance XL Setup";
//         PurchasesPayablesSetup: Record "Purchases & Payables Setup";
//         ArchiveManagement: Codeunit ArchiveManagement;
//         Text0001: Label '"You cannot modify the field- ''%1''. "';
//         UserSetup: Record "User Setup";

//     local procedure Post(PostingCodeunitID: Integer);
//     var
//         PurchaseHeader: Record "Purchase Header";
//         PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
//         ApplicationAreaSetup: Record "Application Area Setup";
//         InstructionMgt: Codeunit "Instruction Mgt.";
//     begin
//         //if ApplicationAreaSetup.IsFoundationEnabled then
//         LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

//         rec.SendToPosting(PostingCodeunitID);

//         DocumentIsPosted := not PurchaseHeader.GET(rec."Document Type", rec."No.");

//         if rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting" then
//             CurrPage.CLOSE;
//         CurrPage.UPDATE(false);

//         if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
//             exit;

//         if IsOfficeAddin then begin
//             PurchCrMemoHdr.SETRANGE("Pre-Assigned No.", rec."No.");
//             if PurchCrMemoHdr.FINDFIRST then
//                 PAGE.RUN(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
//         end else
//             if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
//                 ShowPostedConfirmationMessage;
//     end;

//     local procedure ApproveCalcInvDisc();
//     begin
//         // CurrPage.PurchLines.PAGE.rApproveCalcInvDisc;
//     end;

//     local procedure PurchaserCodeOnAfterValidate();
//     begin
//         //  CurrPage.PurchLines.PAGE.UpdateForm(true);
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV();
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV();
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure PricesIncludingVATOnAfterValid();
//     begin
//         /*
//         CurrPage.UPDATE;
//         //<<FINXL7.00 RBE 06/08/2013
//         IF recFinXLSetup.READPERMISSION THEN BEGIN
//           IF recPurchSetup."Check Totals on Purch. Inv./CM" THEN BEGIN
//             cduReleasePurchDoc.fctSetParameters(TRUE,FALSE);
//             cduReleasePurchDoc.RUN(Rec);
//             CurrPage.PurchLines.PAGE.MakeTotals;
//           END;
//         END;
//         //>>FINXL7.00 RBE 06/08/2013
//         */

//     end;

//     local procedure SetDocNoVisible();
//     var
//         DocumentNoVisibility: Codeunit DocumentNoVisibility;
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     begin
//         DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::"Credit Memo", rec."No.");
//     end;

//     local procedure SetExtDocNoMandatoryCondition();
//     var
//         PurchasesPayablesSetup: Record "Purchases & Payables Setup";
//     begin
//         PurchasesPayablesSetup.GET;
//         VendorCreditMemoNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
//     end;

//     local procedure SetControlAppearance();
//     var
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         JobQueueVisible := rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting";
//         HasIncomingDocument := rec."Incoming Document Entry No." <> 0;
//         CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (rec."No." <> '');
//         SetExtDocNoMandatoryCondition;

//         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);

//         CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RECORDID);
//     end;

//     local procedure ShowPostedConfirmationMessage();
//     var
//         PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
//         InstructionMgt: Codeunit "Instruction Mgt.";
//     begin
//         PurchCrMemoHdr.SETRANGE("Pre-Assigned No.", Rec."No.");
//         if PurchCrMemoHdr.FINDFIRST then
//             if InstructionMgt.ShowConfirm(OpenPostedPurchCrMemoQst, InstructionMgt.ShowPostedConfirmationMessageCode) then
//                 PAGE.RUN(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
//     end;

//     local procedure StatusOnAfterValidate();
//     begin
//         // <<DITW15.00.00.34 DDR 17/06/2009
//         CurrPage.UPDATE(false);
//     end;

//     local procedure StatusOnValidate();
//     begin
//         // <<DITW15.00.00.34 DDR 17/06/2009
//         // if xRec.Status = Status then
//         //     exit;

//         // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
//         // if (xRec.Status = Status::Open) or (Status = Status::Released) then
//         //     ReleasePurchDoc.DocStatusRelease(xRec, Rec)
//         // else begin
//         //     if Status = Status::Open then
//         //         ReleasePurchDoc.DocStatusOpen(xRec, Rec)
//         //     else
//         //         // >>DITW15.00.00.39 DDR #1330 #1407
//         //         TESTFIELD(Status, xRec.Status);
//         // end;//BC Upgrade SHARMP16--DRINK-IT code
//     end;

//     local procedure UpdateAfterChangingHeader();
//     var
//         PurchLine: Record "Purchase Line";
//     begin
//         /*
//         //<<FINXL7.00 RBE 06/08/2013
//         IF recPurchSetup."Check Totals on Purch. Inv./CM" THEN BEGIN
//           PurchLine.SETRANGE("Document Type","Document Type");
//           PurchLine.SETRANGE("Document No.","No.");
//           PurchLine.SETFILTER(Type,'<>%1',PurchLine.Type::" ");
//           PurchLine.SETFILTER(Quantity,'<>0');
//           IF PurchLine.FIND('-') THEN BEGIN
//             cduReleasePurchDoc.fctSetParameters(TRUE,FALSE);
//             cduReleasePurchDoc.RUN(Rec);
//             CurrPage.PurchLines.PAGE.MakeTotals;
//           END;
//         END;
//         //>>FINXL7.00 RBE 06/08/2013
//         */

//     end;
// }

