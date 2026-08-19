page 90043 "Purchase Invoice Header"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'purchaseInvoiceHeader';
    DelayedInsert = true;
    EntityName = 'purchaseInvoiceHeader';
    EntitySetName = 'purchaseInvoiceHeaders';
    PageType = API;
    SourceTable = "Purch. Inv. Header";
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                }
                field(document_subtype_code; Rec."Document Subtype Code FND")
                {
                    Caption = 'Document Subtype Code';
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area';
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(buyFromAddress; Rec."Buy-from Address")
                {
                    Caption = 'Buy-from Address';
                }
                field(buyFromAddress2; Rec."Buy-from Address 2")
                {
                    Caption = 'Buy-from Address 2';
                }
                field(buyFromCity; Rec."Buy-from City")
                {
                    Caption = 'Buy-from City';
                }
                field(buyFromContact; Rec."Buy-from Contact")
                {
                    Caption = 'Buy-from Contact';
                }
                field(buyFromContactNo; Rec."Buy-from Contact No.")
                {
                    Caption = 'Buy-from Contact No.';
                }
                field(buyFromCountryRegionCode; Rec."Buy-from Country/Region Code")
                {
                    Caption = 'Buy-from Country/Region Code';
                }
                field(buyFromCounty; Rec."Buy-from County")
                {
                    Caption = 'Buy-from County';
                }
                field(buyFromPostCode; Rec."Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code';
                }
                field(buyFromVendorName; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Buy-from Vendor Name';
                }
                field(buyFromVendorName2; Rec."Buy-from Vendor Name 2")
                {
                    Caption = 'Buy-from Vendor Name 2';
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(campaignNo; Rec."Campaign No.")
                {
                    Caption = 'Campaign No.';
                }
                field(cancelled; Rec.Cancelled)
                {
                    Caption = 'Cancelled';
                }
                field(closed; Rec.Closed)
                {
                    Caption = 'Closed';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction';
                }
                field(corrective; Rec.Corrective)
                {
                    Caption = 'Corrective';
                }
                field(creditorNo; Rec."Creditor No.")
                {
                    Caption = 'Creditor No.';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                    Caption = 'Currency Factor';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(draftInvoiceSystemId; Rec."Draft Invoice SystemId")
                {
                    Caption = 'Draft Invoice SystemId';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(entryPoint; Rec."Entry Point")
                {
                    Caption = 'Entry Point';
                }
                field(expectedReceiptDate; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
                }
                // field(fiscalInvoiceNumberPAC; Rec."Fiscal Invoice Number PAC")
                // {
                //     Caption = 'Fiscal Invoice Number PAC';
                // }
                field(formatRegion; Rec."Format Region")
                {
                    Caption = 'Format Region';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }

                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    Caption = 'Invoice Disc. Code';
                }
                field(invoiceDiscountAmount; Rec."Invoice Discount Amount")
                {
                    Caption = 'Invoice Discount Amount';
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(noPrinted; Rec."No. Printed")
                {
                    Caption = 'No. Printed';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(onHold; Rec."On Hold")
                {
                    Caption = 'On Hold';
                }
                field(orderAddressCode; Rec."Order Address Code")
                {
                    Caption = 'Order Address Code';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field(orderNoSeries; Rec."Order No. Series")
                {
                    Caption = 'Order No. Series';
                }
                field(payToAddress; Rec."Pay-to Address")
                {
                    Caption = 'Pay-to Address';
                }
                field(payToAddress2; Rec."Pay-to Address 2")
                {
                    Caption = 'Pay-to Address 2';
                }
                field(payToCity; Rec."Pay-to City")
                {
                    Caption = 'Pay-to City';
                }
                field(payToContact; Rec."Pay-to Contact")
                {
                    Caption = 'Pay-to Contact';
                }
                field(payToContactNo; Rec."Pay-to Contact No.")
                {
                    Caption = 'Pay-to Contact No.';
                }
                field(payToCountryRegionCode; Rec."Pay-to Country/Region Code")
                {
                    Caption = 'Pay-to Country/Region Code';
                }
                field(payToCounty; Rec."Pay-to County")
                {
                    Caption = 'Pay-to County';
                }
                field(payToName; Rec."Pay-to Name")
                {
                    Caption = 'Pay-to Name';
                }
                field(payToName2; Rec."Pay-to Name 2")
                {
                    Caption = 'Pay-to Name 2';
                }
                field(payToPostCode; Rec."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code';
                }
                field(payToVendorNo; Rec."Pay-to Vendor No.")
                {
                    Caption = 'Pay-to Vendor No.';
                }
                field(paymentDiscount; Rec."Payment Discount %")
                {
                    Caption = 'Payment Discount %';
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
                }
                field(paymentReference; Rec."Payment Reference")
                {
                    Caption = 'Payment Reference';
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(postingDescription; Rec."Posting Description")
                {
                    Caption = 'Posting Description';
                }
                field(preAssignedNo; Rec."Pre-Assigned No.")
                {
                    Caption = 'Pre-Assigned No.';
                }
                field(preAssignedNoSeries; Rec."Pre-Assigned No. Series")
                {
                    Caption = 'Pre-Assigned No. Series';
                }
                field(prepaymentInvoice; Rec."Prepayment Invoice")
                {
                    Caption = 'Prepayment Invoice';
                }
                field(prepaymentNoSeries; Rec."Prepayment No. Series")
                {
                    Caption = 'Prepayment No. Series';
                }
                field(prepaymentOrderNo; Rec."Prepayment Order No.")
                {
                    Caption = 'Prepayment Order No.';
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                    Caption = 'Prices Including VAT';
                }
                // field(provincialTaxAreaCode; Rec."Provincial Tax Area Code")
                // {
                //     Caption = 'Provincial Tax Area Code';
                // }
                field(purchaserCode; Rec."Purchaser Code")
                {
                    Caption = 'Purchaser Code';
                }
                field(quoteNo; Rec."Quote No.")
                {
                    Caption = 'Quote No.';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(remainingAmount; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                }
                field(remitToCode; Rec."Remit-to Code")
                {
                    Caption = 'Remit-to Code';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                // field(steTransactionID; Rec."STE Transaction ID")
                // {
                //     Caption = 'STE Transaction ID';
                // }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(shipToAddress; Rec."Ship-to Address")
                {
                    Caption = 'Ship-to Address';
                }
                field(shipToAddress2; Rec."Ship-to Address 2")
                {
                    Caption = 'Ship-to Address 2';
                }
                field(shipToCity; Rec."Ship-to City")
                {
                    Caption = 'Ship-to City';
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact';
                }
                field(shipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    Caption = 'Ship-to Country/Region Code';
                }
                field(shipToCounty; Rec."Ship-to County")
                {
                    Caption = 'Ship-to County';
                }
                field(shipToName; Rec."Ship-to Name")
                {
                    Caption = 'Ship-to Name';
                }
                field(shipToName2; Rec."Ship-to Name 2")
                {
                    Caption = 'Ship-to Name 2';
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code';
                }
                // field(shipToUPSZone; Rec."Ship-to UPS Zone")
                // {
                //     Caption = 'Ship-to UPS Zone';
                // }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                // field(taxExemptionNo; Rec."Tax Exemption No.")
                // {
                //     Caption = 'Tax Exemption No.';
                // }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                }
                field("transactionType"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(vatBaseDiscount; Rec."VAT Base Discount %")
                {
                    Caption = 'VAT Base Discount %';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatCountryRegionCode; Rec."VAT Country/Region Code")
                {
                    Caption = 'VAT Country/Region Code';
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                    Caption = 'VAT Date';
                }
                field(vendorInvoiceNo; Rec."Vendor Invoice No.")
                {
                    Caption = 'Vendor Invoice No.';
                }
                field(vendorLedgerEntryNo; Rec."Vendor Ledger Entry No.")
                {
                    Caption = 'Vendor Ledger Entry No.';
                }
                field(vendorOrderNo; Rec."Vendor Order No.")
                {
                    Caption = 'Vendor Order No.';
                }
                field(vendorPostingGroup; Rec."Vendor Posting Group")
                {
                    Caption = 'Vendor Posting Group';
                }
                field(yourReference; Rec."Your Reference")
                {
                    Caption = 'Your Reference';
                }
                field(vendorBankAccount; Rec."Vendor Bank Account FND")
                {
                    Caption = 'Vendor Bank Account';
                }
                field(paymentUserFND; Rec."Payment User FND")
                {
                    Caption = 'Payment User';
                }
                field(paymentStatusFND; Rec."Payment Status FND")
                {
                    Caption = 'Payment Status';
                }
                field(statusDateFND; Rec."Status Date FND")
                {
                    Caption = 'Status Date';
                }
                field(srmContractNoFND; Rec."SRM Contract No. FND")
                {
                    Caption = 'SRM Contract No.';
                }
                field(srmContractNameFND; Rec."SRM Contract Name FND")
                {
                    Caption = 'SRM Contract Name';
                }
                field(srmContractTypeFND; Rec."SRM Contract Type FND")
                {
                    Caption = 'SRM Contract Type';
                }
                field(validFromFND; Rec."Valid From FND")
                {
                    Caption = 'Valid From';
                }
                field(validToFND; Rec."Valid To FND")
                {
                    Caption = 'Valid To';
                }
                field(channelFND; Rec."Channel FND")
                {
                    Caption = 'Channel';
                }
                field(shipmentMethodLocationFND; Rec."Shipment Method Location FND")
                {
                    Caption = 'Shipment Method Location';
                }
                field(contractClosedFND; Rec."Contract Closed FND")
                {
                    Caption = 'Contract Closed';
                }
                field(sRMOrderNoFND; Rec."SRM Order No. FND")
                {
                    Caption = 'SRM Order No.';
                }
                field(srmVersionNoFND; Rec."SRM Version No. FND")
                {
                    Caption = 'SRM Version No.';
                }
                field(rUID; Rec."RUID FND")
                {
                    Caption = 'RUID';
                }
                field(targetValueCurrencyFND; Rec."Target Value Currency FND")
                {
                    Caption = 'Target Value Currency';
                }
                field(targetValueAmountFND; Rec."Target Value Amount FND")
                {
                    Caption = 'Target Value Amount';
                }
                field(blanketOrderNoFND; Rec."Blanket Order No. FND")
                {
                    Caption = 'Blanket Order No.';
                }
                field(wHTBusinessPostingGroupFND; Rec."WHT Business Posting Group FND")
                {
                    Caption = 'WHT Business Posting Group';
                }
                field(actualVendorNoFND; Rec."Actual Vendor No. FND")
                {
                    Caption = 'Actual Vendor No.';
                }
                field(maximoRequisitionNoFND; Rec."Maximo Requisition No. FND")
                {
                    Caption = 'Maximo Requisition No.';
                }
                field(fixedAssetAcquisitionFND; Rec."Fixed Asset Acquisition FND")
                {
                    Caption = 'Fixed Asset Acquisition';
                }
                field(licenseCodeFND; Rec."License Code FND")
                {
                    Caption = 'License Code';
                }

            }
        }
    }
}
