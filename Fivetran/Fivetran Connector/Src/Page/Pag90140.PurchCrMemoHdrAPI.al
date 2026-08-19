page 90140 "Purch. Cr. Memo Hdr. API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Purch. Cr. Memo Hdr.';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Purch. Cr. Memo Hdr.';
    EntitySetCaption = 'Purch. Cr. Memo Hdr.';
    EntityName = 'PurchCrMemoHdr';
    EntitySetName = 'PurchCrMemoHdr';
    SourceTable = "Purch. Cr. Memo Hdr.";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(actualVendorNo; Rec."Actual Vendor No. FND")
                {
                    Caption = 'Actual Vendor No.';
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                }
                field(area_; Rec."Area")
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
                field(blanketOrderNo; Rec."Blanket Order No. FND")
                {
                    Caption = 'Blanket Order No.';
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
                field(channel; Rec."Channel FND")
                {
                    Caption = 'Channel';
                }
                field(contractClosed; Rec."Contract Closed FND")
                {
                    Caption = 'Contract Closed';
                }
                field(correction; Rec."Correction")
                {
                    Caption = 'Correction';
                }
                field(createdBy; Rec."Created By IBM FND")
                {
                    Caption = 'Created By';
                }
                field(creationDateTime; Rec."Creation Date/Time IBM FND")
                {
                    Caption = 'Creation Date/Time';
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
                field(documentSubtypeCode; Rec."Document Subtype Code FND")
                {
                    Caption = 'Document Subtype Code';
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
                field(fixedAssetAcquisition; Rec."Fixed Asset Acquisition FND")
                {
                    Caption = 'Fixed Asset Acquisition';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    Caption = 'Invoice Disc. Code';
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(maximoRequisitionNo; Rec."Maximo Requisition No. FND")
                {
                    Caption = 'Maximo Requisition No.';
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
                field(payToAddress; Rec."Pay-to Address")
                {
                    Caption = 'Pay-to Address';
                }
                field(payToAddress2; Rec."Pay-to Address 2")
                {
                    Caption = 'Pay-to Address 2';
                }
                field(payToPostCode; Rec."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code';
                }
                field(payToVendorNo; Rec."Pay-to Vendor No.")
                {
                    Caption = 'Pay-to Vendor No.';
                }
                field(paymentDiscountPct; Rec."Payment Discount %")
                {
                    Caption = 'Payment Discount %';
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
                }
                field(paymentStatus; Rec."Payment Status FND")
                {
                    Caption = 'Payment Status';
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field(paymentUser; Rec."Payment User FND")
                {
                    Caption = 'Payment User';
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
                field(prepaymentCreditMemo; Rec."Prepayment Credit Memo")
                {
                    Caption = 'Prepayment Credit Memo';
                }
                field(prepaymentOrderNo; Rec."Prepayment Order No.")
                {
                    Caption = 'Prepayment Order No.';
                }
                field(preptCrMemoNoSeries; Rec."Prepmt. Cr. Memo No. Series")
                {
                    Caption = 'Prepmt. Cr. Memo No. Series';
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                    Caption = 'Prices Including VAT';
                }
                field(purchaserCode; Rec."Purchaser Code")
                {
                    Caption = 'Purchaser Code';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(returnOrderNo; Rec."Return Order No.")
                {
                    Caption = 'Return Order No.';
                }
                field(returnOrderNoSeries; Rec."Return Order No. Series")
                {
                    Caption = 'Return Order No. Series';
                }
                field(ruid; Rec."RUID FND")
                {
                    Caption = 'RUID';
                }
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
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(shipmentMethodLocation; Rec."Shipment Method Location FND")
                {
                    Caption = 'Shipment Method Location';
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
                field(srmContractName; Rec."SRM Contract Name FND")
                {
                    Caption = 'SRM Contract Name';
                }
                field(srmContractNo; Rec."SRM Contract No. FND")
                {
                    Caption = 'SRM Contract No.';
                }
                field(srmContractType; Rec."SRM Contract Type FND")
                {
                    Caption = 'SRM Contract Type';
                }
                field(srmOrderNo; Rec."SRM Order No. FND")
                {
                    Caption = 'SRM Order No.';
                }
                field(srmVersionNo; Rec."SRM Version No. FND")
                {
                    Caption = 'SRM Version No.';
                }
                field(statusDate; Rec."Status Date FND")
                {
                    Caption = 'Status Date';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(targetValueAmount; Rec."Target Value Amount FND")
                {
                    Caption = 'Target Value Amount';
                }
                field(targetValueCurrency; Rec."Target Value Currency FND")
                {
                    Caption = 'Target Value Currency';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }

                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                }
                field(transactionType; Rec."Transaction Type")
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
                field(validFrom; Rec."Valid From FND")
                {
                    Caption = 'Valid From';
                }
                field(validTo; Rec."Valid To FND")
                {
                    Caption = 'Valid To';
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
                field(vendorBankAccount; Rec."Vendor Bank Account FND")
                {
                    Caption = 'Vendor Bank Account';
                }
                field(vendorCrMemoNo; Rec."Vendor Cr. Memo No.")
                {
                    Caption = 'Vendor Cr. Memo No.';
                }
                field(vendorLedgerEntryNo; Rec."Vendor Ledger Entry No.")
                {
                    Caption = 'Vendor Ledger Entry No.';
                }
                field(vendorPostingGroup; Rec."Vendor Posting Group")
                {
                    Caption = 'Vendor Posting Group';
                }
                field(whtBusinessPostingGroup; Rec."WHT Business Posting Group FND")
                {
                    Caption = 'WHT Business Posting Group';
                }
                field(yourReference; Rec."Your Reference")
                {
                    Caption = 'Your Reference';
                }
            }
        }
    }
}
