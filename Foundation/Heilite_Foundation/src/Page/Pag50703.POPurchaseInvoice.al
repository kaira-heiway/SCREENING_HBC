// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
// namespace Microsoft.Purchases.Document;

// using Microsoft.CRM.Contact;
// using Microsoft.CRM.Outlook;
// using Microsoft.EServices.EDocument;
// using Microsoft.Finance.Currency;
// using Microsoft.Finance.Dimension;
// using Microsoft.Finance.GeneralLedger.Setup;
// using Microsoft.Finance.VAT.Calculation;
// using Microsoft.Foundation.Address;
// using Microsoft.Foundation.Attachment;
// using Microsoft.Foundation.Enums;
// using Microsoft.Foundation.Reporting;
// using Microsoft.Intercompany;
// using Microsoft.Inventory.Tracking;
// using Microsoft.Purchases.Comment;
// using Microsoft.Purchases.History;
// using Microsoft.Purchases.Payables;
// using Microsoft.Purchases.Posting;
// using Microsoft.Purchases.Remittance;
// using Microsoft.Purchases.Setup;
// using Microsoft.Purchases.Vendor;
// using Microsoft.Utilities;
// using System.Automation;
// using System.Environment;
// using System.Environment.Configuration;
// using System.Privacy;
// using System.Security.User;
// using System.Threading;

//BC UPGRADE ATHUKUS01 FDD_STP007>>
//1.Added NAV Custome code in Release action & Base code for release action.
//2.Added Base code for Reopen action.
//3.Document stataus is made non editable.
//BC UPGRADE ATHUKUS01 FDD_STP007<<
page 50703 "PO Purchase Invoice"
{

    Caption = 'PO Purchase Invoice';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = filter(Invoice));
    AdditionalSearchTerms = 'Vendor Invoice, Procurement Invoice, Vendor Bill, Purchase Bill, Supplier Invoice, Acquisition Bill, Buying Invoice, Supplier Bill, Invoice Purchase, Merchant Invoice, Trade Invoice';

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

                    trigger OnAfterLookup(Selected: RecordRef)
                    var
                        Vendor: Record Vendor;
                    begin
                        Selected.SetTable(Vendor);
                        if Rec."Buy-from Vendor No." <> Vendor."No." then begin
                            Rec.Validate("Buy-from Vendor No.", Vendor."No.");
                            IsPurchaseLinesEditable := Rec.PurchaseLinesEditable();
                            CurrPage.Update();
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        IsPurchaseLinesEditable := Rec.PurchaseLinesEditable();
                        Rec.OnAfterValidateBuyFromVendorNo(Rec, xRec);
                        CurrPage.Update();
                    end;
                }
                field("Buy-from Vendor Name 2"; Rec."Buy-from Vendor Name 2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Name 2';
                    Importance = Additional;
                    QuickEntry = false;
                    Visible = false;
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
                            CaptionClass = '5,1,' + Rec."Buy-from Country/Region Code";
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
                    var
                        UserSetup: Record "User Setup";
                    begin
                        //HEI.08>>
                        UserSetup.GET(USERID);
                        if (rec."Due Date" <> xRec."Due Date") and (xRec."Due Date" <> 0D) then begin
                            ERROR(Text0001, rec.FIELDCAPTION("Due Date"));
                        end;
                        //HEI.08<<
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
                    Editable = false;  //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                    trigger OnValidate();
                    begin
                        //StatusOnValidate;//BC Upgrade Drink-it function
                        // StatusOnAfterValidate;//BC Upgrade Drink-it function
                    end;
                }
                //BC UPGRADE ATHUKUS01 FDD_STP007_GAP 14-16<<
                // field(DocAmount; Rec."Doc. Amount Incl. VAT")
                // {
                //     ApplicationArea = Basic, Suite;
                //     BlankZero = true;
                //     Enabled = DocAmountEnable;
                //     Visible = DocAmountEnable;
                //     Editable = DocAmountsEditable;
                //     ShowMandatory = true;
                // }
                // field(DocAmountVAT; Rec."Doc. Amount VAT")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Enabled = DocAmountEnable;
                //     Visible = DocAmountEnable;
                //     Editable = DocAmountsEditable;
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
                //BC UPGRADE ATHUKUS01 FDD_STP007_GAP 14-16>>

                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase invoices.';
                    Visible = JobQueuesUsed;

                    trigger OnDrillDown()
                    var
                        JobQueueEntry: Record "Job Queue Entry";
                    begin
                        if Rec."Job Queue Status" = Rec."Job Queue Status"::" " then
                            exit;
                        JobQueueEntry.ShowStatusMsg(Rec."Job Queue Entry ID");
                    end;
                }
                field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
                {
                    ApplicationArea = all;
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
                field("License Code"; Rec."License Code FND")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnDrillDown();
                    begin
                        /*
                        // HEI.10 >>
                        OldDimSetId := 0;
                        NewDImSetId := 0;
                        OldDimSetId := Rec."Dimension Set ID";
                          IF Rec.Status = Rec.Status::Open THEN BEGIN
                            GenLedSetRec.RESET;
                            GenLedSetRec.GET;
                            IF GenLedSetRec."License Dimension Code" = '' THEN
                              ERROR(Text000);
                            DimValRec.RESET;
                            DimValRec.SETRANGE("Dimension Code",GenLedSetRec."License Dimension Code");
                            CLEAR(DimValPage);
                            DimValPage.SETRECORD(DimValRec);
                            DimValPage.SETTABLEVIEW(DimValRec);
                            DimValPage.LOOKUPMODE(TRUE);
                            IF DimValPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                              DimValPage.GETRECORD(DimValRec);
                              LicenseCode := DimValRec.Code;
                              PurchaseHeaderAdditional.RESET;
                              IF PurchaseHeaderAdditional.GET(Rec."Document Type",Rec."No.") THEN BEGIN
                                PurchaseHeaderAdditional."License Code" := DimValRec.Code;
                                PurchaseHeaderAdditional.MODIFY;
                              END;

                              DimValRec.GET(GenLedSetRec."License Dimension Code",LicenseCode);
                            DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                            TempDimSetEntry.INIT;
                            TempDimSetEntry.VALIDATE("Dimension Code",GenLedSetRec."License Dimension Code");
                            TempDimSetEntry.VALIDATE("Dimension Value Code",LicenseCode);
                            TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                            TempDimSetEntry."Dimension Set ID" := Rec."Dimension Set ID";
                            IF NOT TempDimSetEntry.INSERT THEN
                              TempDimSetEntry.MODIFY;

                            //TempDimSetEntry.INSERT            (TRUE);

                            Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                            Rec.MODIFY;
                            NewDImSetId := Rec."Dimension Set ID";
                              //VALIDATE("License Code", DimValRec.Code);
                              //Updating All Lines
                            PurchLineRec.RESET;
                            PurchLineRec.SETRANGE("Document Type",Rec."Document Type");
                            PurchLineRec.SETRANGE("Document No.",Rec."No.");
                            IF PurchLineRec.FINDFIRST THEN BEGIN
                              IF NOT GUIALLOWED THEN
                                SetHideValidationDialog(TRUE);
                              COMMIT;
                              UpdateAllLineDimNew(NewDImSetId,OldDimSetId);
                            END;

                            END;
                           END ELSE
                            ERROR(Text003);
                        // HEI.10 <<
                        */

                    end;
                }
            }

            part(PurchLines; "PO Purch. Invoice Subform")
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
                        // CurrPage.SaveRecord(); // BC Upgrade BHARDA11 -- PTP056 Error 

                        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
                            PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = IsPostingGroupEditable;
                    Enabled = false; //BC UPGRADE ATHUKUS01 FDDSTP_007
                    Importance = Additional;
                    ToolTip = 'Specifies the vendor''s market type to link business transactions to.';
                }
                // BC Upgrade VAMSIU01 added field >>
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade VAMSIU01 added field <<
                field("Payment Status"; Rec."Payment Status FND")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        UserSetup: Record "User Setup";
                    begin
                        //HEI.08>>
                        UserSetup.GET(USERID);
                        if (rec."Payment Status FND" <> xRec."Payment Status FND") then begin
                            ERROR(Text0001, rec.FIELDCAPTION("Payment Status FND"));
                        end;
                        //HEI.08<<
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                    trigger OnValidate();
                    var
                        UserSetup: Record "User Setup";
                    begin
                        /*//<<FINXL7.00 RBE 06/08/2013
                        IF recFinXLSetup.READPERMISSION THEN
                          IF recPurchSetup."Show Totals on Purch. Inv./CM." THEN BEGIN
                            UpdateAfterChangingVATDisc();
                            CurrPage.PurchLines.PAGE.MakeTotals;
                          END;
                        //>>FINXL7.00 RBE 06/08/2013
                        *///commented 051217
                        //HEI.08>>
                        UserSetup.GET(USERID);
                        if (rec."Payment Terms Code" <> xRec."Payment Terms Code") and (xRec."Payment Terms Code" <> '') then begin
                            ERROR(Text0001, rec.FIELDCAPTION("Payment Terms Code"));
                        end;
                        //HEI.08<<
                    end;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                    Visible = IsPaymentMethodCodeVisible;
                    trigger OnValidate()
                    var
                        UserSetup: Record "User Setup";
                    begin
                        //HEI.08>>
                        UserSetup.GET(USERID);
                        if (Rec."Payment Method Code" <> xRec."Payment Method Code") and (xRec."Payment Method Code" <> '') then begin
                            ERROR(Text0001, rec.FIELDCAPTION("Payment Method Code"));
                        end;
                        //HEI.08<<
                    end;
                }
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

                        //HEI.04 PATHAA02 PTPGAP071>>
                        if rec."Document Type" = rec."Document Type"::Invoice then begin
                            if xRec."Shortcut Dimension 1 Code" <> Rec."Shortcut Dimension 1 Code" then
                                ERROR(Text50000);
                        end;
                        //HEI.04 PATHAA02 PTPGAP071<<

                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate();
                    begin

                        //HEI.04 PATHAA02 PTPGAP071>>
                        if rec."Document Type" = rec."Document Type"::Invoice then begin
                            if xRec."Shortcut Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code" then
                                ERROR(Text50000);
                        end;
                        //HEI.04 PATHAA02 PTPGAP071<<
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
                                    CaptionClass = '5,1,' + Rec."Ship-to Country/Region Code";
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
                            field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
                            {
                                ApplicationArea = ALL;
                            }
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
                                if Rec.GetFilter("Pay-to Vendor No.") = xRec."Pay-to Vendor No." then
                                    if Rec."Pay-to Vendor No." <> xRec."Pay-to Vendor No." then
                                        Rec.SetRange("Pay-to Vendor No.");

                                CurrPage.SaveRecord();
                                if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
                                    PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);

                                CurrPage.Update(false);
                            end;
                        }
                        field("Pay-to Name 2"; Rec."Pay-to Name 2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Name 2';
                            Editable = PayToOptions = PayToOptions::"Another Vendor";
                            Enabled = PayToOptions = PayToOptions::"Another Vendor";
                            Importance = Additional;
                            QuickEntry = false;
                            Visible = false;
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
                                CaptionClass = '5,1,' + Rec."Pay-to Country/Region Code";
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

#if not CLEAN25
            part("Attached Documents"; "Doc. Attachment List Factbox") //BC Version 28.0 Compatibility Fix
            {
                ObsoleteTag = '25.0';
                ObsoleteState = Pending;
                ObsoleteReason = 'The "Document Attachment FactBox" has been replaced by "Doc. Attachment List Factbox", which supports multiple files upload.';
                ApplicationArea = All;
                Visible = false;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Purchase Header"),
                              "Document Type" = field("Document Type"),
                              "No." = field("No.");
            }
#endif
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
#if not CLEAN26
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    ObsoleteReason = 'The statistics action will be replaced with the PurchaseStatistics action. The new action uses RunObject and does not run the action trigger. Use a page extension to modify the behaviour.';
                    ObsoleteState = Pending;
                    ObsoleteTag = '26.0';

                    // Action is not being run and replaced with action PurchaseOrderStatistics
                    // trigger OnAction()
                    // begin
                    //     Rec.OpenDocumentStatistics();
                    //     CurrPage.PurchLines.Page.ForceTotalsCalculation();
                    // end;
                }
#endif
                action(PurchaseStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Enabled = Rec."No." <> '';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    Visible = true;
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
                action("Purchase Additional")
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Additional';
                    Image = Purchase;
                    RunObject = Page "Purchase Additional";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
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
                //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
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
                //BC UPGRADE ATHUKUS01 FDDSTP_007 <<
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
                        //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
                        //HEI.10 >>
                        GenLedSetRec.RESET();
                        GenLedSetRec.GET();
                        IF GenLedSetRec."License Dimension Code FND" <> '' THEN BEGIN
                            CLEAR(LicenseCodeValue);
                            PurchaseLine.RESET();
                            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                            PurchaseLine.SETRANGE("Document No.", Rec."No.");
                            PurchaseLine.SETFILTER(Type, '%1|%2|%3|%4', PurchaseLine.Type::"Charge (Item)", PurchaseLine.Type::"Fixed Asset", PurchaseLine.Type::"G/L Account", PurchaseLine.Type::Item);
                            IF PurchaseLine.FINDFIRST() THEN BEGIN
                                DimSetEntryRec.RESET();
                                DimSetEntryRec.SETRANGE("Dimension Set ID", PurchaseLine."Dimension Set ID");
                                DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                IF DimSetEntryRec.FINDFIRST() THEN
                                    LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                            END;
                            CLEAR(LicenseCodeValue_1);
                            PurchLineRec.RESET();
                            PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                            PurchLineRec.SETRANGE("Document No.", Rec."No.");
                            PurchLineRec.SETFILTER(Type, '<>%1', 0);
                            IF PurchLineRec.FINDFIRST() THEN BEGIN
                                REPEAT
                                    DimSetEntryRec_1.RESET();
                                    DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                                    DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                    IF DimSetEntryRec_1.FINDFIRST() THEN
                                        LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                                    IF LicenseCodeValue_1 <> '' THEN BEGIN
                                        IF LicenseCodeValue <> LicenseCodeValue_1 THEN
                                            ERROR(Text004);
                                    END;
                                    IF LicenseCodeValue = LicenseCodeValue_1 THEN BEGIN
                                        PurchHdrAddiRec.RESET();
                                        IF PurchHdrAddiRec.GET(Rec."Document Type", Rec."No.") THEN BEGIN
                                            PurchHdrAddiRec."License Code" := LicenseCodeValue_1;
                                            PurchHdrAddiRec.MODIFY();
                                        END;
                                    END;
                                UNTIL PurchLineRec.NEXT() = 0;
                            END;


                            GenLedSetRec.RESET();
                            GenLedSetRec.GET();
                            IF GenLedSetRec."License Dimension Code FND" = '' THEN
                                ERROR(Text000);
                            DimValRec.RESET();
                            DimValRec.GET(GenLedSetRec."License Dimension Code FND", LicenseCodeValue_1);
                            DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                            //>> HEI.12
                            IF NOT TempDimSetEntry.GET(Rec."Dimension Set ID", GenLedSetRec."License Dimension Code FND") THEN BEGIN
                                TempDimSetEntry.INIT();
                                TempDimSetEntry.VALIDATE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                                TempDimSetEntry.INSERT();
                                //    IF NOT TempDimSetEntry.INSERT THEN
                                //      TempDimSetEntry.MODIFY;
                            END ELSE BEGIN
                                IF xRec."License Code FND" <> LicenseCodeValue_1 THEN BEGIN
                                    TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                    TempDimSetEntry.MODIFY();
                                END;
                            END;
                            //<< HEI.12
                            Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                            Rec.MODIFY();
                        END;//HEI.11
                        ReleasePurchDoc.PerformManualRelease(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();

                        //HEI.02>>
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                        //HEI.02<<
                        //BC UPGRADE ATHUKUS01 FDDSTP_007 <<
                    end;
                }
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
                        //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
                        ReleasePurchDoc.PerformManualReopen(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                        //BC UPGRADE ATHUKUS01 FDDSTP_007 <<
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
                action("Archive Document")
                {
                    Caption = 'Archi&ve Document';
                    Enabled = false;
                    Image = Archive;
                    ApplicationArea = All;
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
                action("Copy Document")
                {
                    ApplicationArea = all;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction();
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                        if rec.GET(rec."Document Type", rec."No.") then;
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
                        PurchasesUtils: Codeunit "Purchases-Utils";
                        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
                    begin
                        //HEI.18>>
                        PurchasesPayablesSetup.GET();
                        if (Rec."Document Type" = Rec."Document Type"::Invoice) and PurchasesPayablesSetup."Check Tolerance Approval FND" then begin
                            PurchaseLine.RESET();
                            PurchaseLine.SETCURRENTKEY("Document Type", "Document No.", Type, "No.");
                            PurchaseLine.SETRANGE("Document Type", rec."Document Type");
                            PurchaseLine.SETRANGE("Document No.", rec."No.");
                            PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
                            //if PurchaseLine.FINDSET(true, false) then

                            //if PurchaseLine.FINDSET(false, false) then //HEI.17
                            // BC Upgrade MISHRS14 >>
                            // Removed false from part - if PurchaseLine.FINDSET(false, false) as its depreceted
                            if PurchaseLine.FINDSET(true) then
                                // BC Upgrade MISHRS14 <<

                                repeat
                                    PurchasesUtils.SupressToleranceWaring();
                                    PurchasesUtils.CheckToleranceForEsker(PurchaseLine);
                                until PurchaseLine.NEXT() = 0;
                            COMMIT();
                        end;
                        //HEI.18<<
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
                action(Post_Custom)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction();
                    var
                        BeforeLimit: Label 'Document date %1 in more than 3 months old than the Posting date %2, Do you want to continue ?';
                        AfterLimit: Label 'Document date should not be more than the Posting date.';

                    begin
                        rec.TESTFIELD("Document Date");
                        //Rec.//HEI.16
                        //HEI.14>>
                        if CALCDATE('-3M', rec."Posting Date") > rec."Document Date" then
                            //HEI.15>>
                            if not CONFIRM(BeforeLimit, false, rec."Document Date", rec."Posting Date") then
                                exit;
                        //ERROR(BeforeLimit);

                        //IF CALCDATE('3M',"Posting Date") < "Document Date" THEN
                        if rec."Document Date" > rec."Posting Date" then
                            ERROR(AfterLimit);

                        //IF "Posting Date" = "Document Date" THEN
                        //ERROR(EqualDate);
                        //HEI.15<<
                        //HEI.14<<
                        //HEI.10 >>
                        GenLedSetRec.RESET();
                        GenLedSetRec.GET();
                        if GenLedSetRec."License Dimension Code FND" <> '' then begin
                            CLEAR(LicenseCodeValue);
                            PurchaseLine.RESET();
                            PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                            PurchaseLine.SETRANGE("Document No.", Rec."No.");
                            PurchaseLine.SETFILTER(Type, '%1|%2|%3|%4', PurchaseLine.Type::"Charge (Item)", PurchaseLine.Type::"Fixed Asset", PurchaseLine.Type::"G/L Account", PurchaseLine.Type::Item);
                            //IF PurchaseLine.FINDFIRST THEN BEGIN //HEI.17

                            //if PurchaseLine.FINDSET(false, false) then //HEI.17
                            // BC Upgrade MISHRS14 >>
                            // Removed false from part - if PurchaseLine.FINDSET(false, false) as its depreceted
                            if PurchaseLine.FINDSET(false) then
                                // BC Upgrade MISHRS14 <<

                                repeat
                                    DimSetEntryRec.RESET();
                                    DimSetEntryRec.SETRANGE("Dimension Set ID", PurchaseLine."Dimension Set ID");
                                    DimSetEntryRec.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                    if DimSetEntryRec.FINDFIRST() then
                                        LicenseCodeValue := DimSetEntryRec."Dimension Value Code"
                                //END;Rec. //HEI.17
                                until (PurchaseLine.NEXT() = 0) or (LicenseCodeValue <> ''); //HEI.17
                            CLEAR(LicenseCodeValue_1);
                            PurchLineRec.RESET();
                            PurchLineRec.SETRANGE("Document Type", Rec."Document Type");
                            PurchLineRec.SETRANGE("Document No.", Rec."No.");
                            PurchLineRec.SETFILTER(Type, '<>%1', 0);
                            if PurchLineRec.FINDFIRST() then begin
                                repeat
                                    LicenseCodeValue_1 := ''; //HEI.17
                                    DimSetEntryRec_1.RESET();
                                    DimSetEntryRec_1.SETRANGE("Dimension Set ID", PurchLineRec."Dimension Set ID");
                                    DimSetEntryRec_1.SETRANGE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                    if DimSetEntryRec_1.FINDFIRST() then
                                        LicenseCodeValue_1 := DimSetEntryRec_1."Dimension Value Code";

                                    if LicenseCodeValue_1 <> '' then begin
                                        if LicenseCodeValue <> LicenseCodeValue_1 then
                                            ERROR(Text004);
                                    end;
                                    if LicenseCodeValue = LicenseCodeValue_1 then begin
                                        PurchHdrAddiRec.RESET();
                                        if PurchHdrAddiRec.GET(Rec."Document Type", Rec."No.") then begin
                                            PurchHdrAddiRec."License Code" := LicenseCodeValue_1;
                                            PurchHdrAddiRec.MODIFY();
                                        end;
                                    end;
                                until PurchLineRec.NEXT() = 0;
                                LicenseCodeValue_1 := LicenseCodeValue; //HEI.17

                                if LicenseCodeValue_1 <> '' then begin//HEI.11
                                    GenLedSetRec.RESET();
                                    GenLedSetRec.GET();
                                    if GenLedSetRec."License Dimension Code FND" = '' then
                                        ERROR(Text000);
                                    DimValRec.RESET();
                                    DimValRec.GET(GenLedSetRec."License Dimension Code FND", LicenseCodeValue_1);
                                    DimMgt.GetDimensionSet(TempDimSetEntry, Rec."Dimension Set ID");
                                    //>> HEI.12
                                    if not TempDimSetEntry.GET(Rec."Dimension Set ID", GenLedSetRec."License Dimension Code FND") then begin
                                        TempDimSetEntry.INIT();
                                        TempDimSetEntry.VALIDATE("Dimension Code", GenLedSetRec."License Dimension Code FND");
                                        TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                        TempDimSetEntry."Dimension Value ID" := DimValRec."Dimension Value ID";
                                        TempDimSetEntry.INSERT();
                                        //    IF NOT TempDimSetEntry.INSERT THEN
                                        //      TempDimSetEntry.MODIFY;
                                    end else begin
                                        if xRec."License Code FND" <> LicenseCodeValue_1 then begin
                                            TempDimSetEntry.VALIDATE("Dimension Value Code", LicenseCodeValue_1);
                                            TempDimSetEntry.MODIFY();
                                        end;
                                    end;
                                    //<< HEI.12
                                    Rec."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);

                                    Rec.MODIFY();
                                end;
                            end;//HEI.11
                        end;
                        //HEI.10 <<
                        VerifyTotal();
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
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
                        rec.TESTFIELD("Document Date"); //HEI.16
                        //HEI.15>>
                        if CALCDATE('-3M', rec."Posting Date") > rec."Document Date" then
                            if not CONFIRM(BeforeLimit, false, rec."Document Date", rec."Posting Date") then
                                exit;

                        if rec."Document Date" > rec."Posting Date" then
                            ERROR(AfterLimit);
                        //HEI.15<<
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

                    actionref(Post_Promoted; Post_Custom)
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
#if not CLEAN26
                //actionref(Statistics_Promoted; Statistics)
                actionref(Statistics_Promoted; PurchaseStatistics)
                {
                    ObsoleteReason = 'The statistics action will be replaced with the PurchaseStatistics action. The new action uses RunObject and does not run the action trigger. Use a page extension to modify the behaviour.';
                    ObsoleteState = Pending;
                    ObsoleteTag = '26.0';
                }
#else
                actionref(PurchaseStatistics_Promoted; PurchaseStatistics)
                {
                }
#endif
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
    begin
        JobQueuesUsed := PurchSetup.JobQueueActive();
        SetExtDocNoMandatoryCondition();
        ShowShippingOptionsWithLocation := ApplicationAreaMgmtFacade.IsLocationEnabled() or ApplicationAreaMgmtFacade.IsAllDisabled();
        IsPowerAutomatePrivacyNoticeApproved := PrivacyNotice.GetPrivacyNoticeApprovalState(FlowServiceManagement.GetPowerAutomatePrivacyNoticeId()) = "Privacy Notice Approval State"::Agreed;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

        if (not DocNoVisible) and (Rec."No." = '') then begin
            Rec.SetBuyFromVendorFromFilter();
            Rec.SelectDefaultRemitAddress(Rec);
        end;
        //HEI.02>>
        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD(PurchasesPayablesSetup."PO Subtype Code FND");
        rec."Document Subtype Code FND" := PurchasesPayablesSetup."PO Subtype Code FND"; // BC Upgrade VAMSIU01--code Added
        //HEI.02<<

        //HEI.03 IBM PATHAA02 28.09.17>>
        rec."Payment Status FND" := rec."Payment Status FND"::"Payment Approved";
        //HEI.03 IBM PATHAA02 28.09.17<<

        CalculateCurrentShippingAndPayToOption();
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
        DocAmountEnable := PurchSetup.ShouldDocumentTotalAmountsBeChecked(Rec);
        DocAmountsEditable := PurchSetup.CanDocumentTotalAmountsBeEdited(Rec);
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
        Text000: Label 'Please select the dimension for License Dimension in General Ledger Setup.';

        DimValRec: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        LicenseCodeValue_1: Code[20];
        DimSetEntryRec_1: Record "Dimension Set Entry";
        Text051: TextConst ENU = 'You may have changed a dimension.\\Do you want to update the lines?', FRA = 'Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?';
        Text004: Label 'License Dimension Value should be same for both header and line.';
        PurchLineRec: Record "Purchase Line";
        GenLedSetRec: Record "General Ledger Setup";
        DimValue: Code[10];
        DimValPage: Page "Dimension Values";
        LicenseCodeValue: Code[20];
        DimSetEntryRec: Record "Dimension Set Entry";
        PurchaseLine: Record "Purchase Line";
        PurchHdrAddiRec: Record "Purchase Header Additional FND";
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
        FlowServiceManagement: Codeunit "Flow Service Management";
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
        Text50000: Label 'Dimension changes are not allowed in PO Invoices';
        UserSetup: Record "User Setup";
        Text0001: Label '"You cannot modify the field- ''%1''. "';
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
        IsPurchaseLinesEditable: Boolean;
        RejectICPurchaseInvoiceEnabled: Boolean;
        VATDateEnabled: Boolean;
        DocAmountEnable, DocAmountsEditable : Boolean;
        DummyApplicationAreaSetup: Record "Application Area Setup";
        CopyPurchDoc: Report "Copy Purchase Document";


    protected var
        ShipToOptions: Option "Default (Company Address)",Location,"Custom Address";
        PayToOptions: Option "Default (Vendor)","Another Vendor","Custom Address";
        IsPostingGroupEditable: Boolean;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        ArchiveManagement: Codeunit ArchiveManagement;

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
        DocAmountEnable := PurchSetup.ShouldDocumentTotalAmountsBeChecked(Rec);
        DocAmountsEditable := PurchSetup.CanDocumentTotalAmountsBeEdited(Rec);
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

    local procedure Post(PostingCodeunitID: Integer);
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
            CurrPage.CLOSE();
        CurrPage.UPDATE(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        if IsOfficeAddin then begin
            PurchInvHeader.SETRANGE("Pre-Assigned No.", rec."No.");
            PurchInvHeader.SETRANGE("Order No.", '');
            if PurchInvHeader.FINDFIRST() then
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end;// else // BC Upgrade ATHUKS01 >> -- FDD_STP007
            // if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
        ShowPostedConfirmationMessage();
    end;
    // BC Upgrade ATHUKS01 >> -- FDD_STP007
    local procedure ShowPostedConfirmationMessage();
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        PurchInvHeader.Reset();//BC Upgrade ATHUKS01 >> -- FDD_STP007
        PurchInvHeader.SETRANGE("Pre-Assigned No.", rec."No.");
        // PurchInvHeader.SETRANGE("Order No.", '');
        if PurchInvHeader.FINDFIRST() then
            if ShowConfirm(StrSubstNo(OpenPostedPurchaseInvQst, PurchInvHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode()) then
                PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
    end;

    procedure ShowConfirm(ConfirmQst: Text; InstructionType: Code[50]): Boolean
    begin
        if GuiAllowed then begin
            Commit();
            exit(Confirm(ConfirmQst));
        end;

        exit(true);
    end;
    // BC Upgrade ATHUKS01 << -- FDD_STP007

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
