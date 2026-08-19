page 90038 "Sales Shipment Header"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Sales Shipment Header';
    EntitySetCaption = 'Sales Shipment Headers';
    ODataKeyFields = SystemId;
    EntityName = 'salesShipmentHeader';
    EntitySetName = 'salesShipmentHeaders';
    SourceTable = "Sales Shipment Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                    Caption = 'Allow Line Disc.';
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type';
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area';
                }
                //Bc Upgrade SAIA01 >>
                field(actual_delivery_date; Rec."Actual Delivery Date FND")
                {
                    Caption = 'Actual Delivery Date';
                }
                //Bc Upgrade SAIA01 <<
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                }
                field(billToAddress; Rec."Bill-to Address")
                {
                    Caption = 'Bill-to Address';
                }
                field(billToAddress2; Rec."Bill-to Address 2")
                {
                    Caption = 'Bill-to Address 2';
                }
                field(billToCity; Rec."Bill-to City")
                {
                    Caption = 'Bill-to City';
                }
                field(billToContact; Rec."Bill-to Contact")
                {
                    Caption = 'Bill-to Contact';
                }
                field(billToContactNo; Rec."Bill-to Contact No.")
                {
                    Caption = 'Bill-to Contact No.';
                }
                field(billToCountryRegionCode; Rec."Bill-to Country/Region Code")
                {
                    Caption = 'Bill-to Country/Region Code';
                }
                field(billToCounty; Rec."Bill-to County")
                {
                    Caption = 'Bill-to County';
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                }
                field(billToName; Rec."Bill-to Name")
                {
                    Caption = 'Bill-to Name';
                }
                field(billToName2; Rec."Bill-to Name 2")
                {
                    Caption = 'Bill-to Name 2';
                }
                field(billToPostCode; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code';
                }
                // field(cfdiCancellationID; Rec."CFDI Cancellation ID")
                // {
                //     Caption = 'CFDI Cancellation ID';
                // }
                // field(cfdiCancellationReasonCode; Rec."CFDI Cancellation Reason Code")
                // {
                //     Caption = 'CFDI Cancellation Reason';
                // }
                // field(cfdiExportCode; Rec."CFDI Export Code")
                // {
                //     Caption = 'CFDI Export Code';
                // }
                field(campaignNo; Rec."Campaign No.")
                {
                    Caption = 'Campaign No.';
                }
                // field(certificateSerialNo; Rec."Certificate Serial No.")
                // {
                //     Caption = 'Certificate Serial No.';
                // }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(companyBankAccountCode; Rec."Company Bank Account Code")
                {
                    Caption = 'Company Bank Account Code';
                }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                    Caption = 'Currency Factor';
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group';
                }
                field(customerPostingGroup; Rec."Customer Posting Group")
                {
                    Caption = 'Customer Posting Group';
                }
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                    Caption = 'Customer Price Group';
                }
                // field(dateTimeCancelSent; Rec."Date/Time Cancel Sent")
                // {
                //     Caption = 'Date/Time Cancel Sent';
                // }
                // field(dateTimeCanceled; Rec."Date/Time Canceled")
                // {
                //     Caption = 'Date/Time Canceled';
                // }
                // field(dateTimeFirstReqSent; Rec."Date/Time First Req. Sent")
                // {
                //     Caption = 'Date/Time First Req. Sent';
                // }
                // field(dateTimeStampReceived; Rec."Date/Time Stamp Received")
                // {
                //     Caption = 'Date/Time Stamp Received';
                // }
                // field(dateTimeStamped; Rec."Date/Time Stamped")
                // {
                //     Caption = 'Date/Time Stamped';
                // }
                // field(digitalStampPAC; Rec."Digital Stamp PAC")
                // {
                //     Caption = 'Digital Stamp PAC';
                // }
                // field(digitalStampSAT; Rec."Digital Stamp SAT")
                // {
                //     Caption = 'Digital Stamp SAT';
                // }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(eu3PartyTrade; Rec."EU 3-Party Trade")
                {
                    Caption = 'EU 3-Party Trade';
                }
                // field(electronicDocumentStatus; Rec."Electronic Document Status")
                // {
                //     Caption = 'Electronic Document Status';
                // }
                // field(errorCode; Rec."Error Code")
                // {
                //     Caption = 'Error Code';
                // }
                // field(errorDescription; Rec."Error Description")
                // {
                //     Caption = 'Error Description';
                // }
                field(exitPoint; Rec."Exit Point")
                {
                    Caption = 'Exit Point';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                // field(fiscalInvoiceNumberPAC; Rec."Fiscal Invoice Number PAC")
                // {
                //     Caption = 'Fiscal Invoice Number PAC';
                // }
                // field(foreignTrade; Rec."Foreign Trade")
                // {
                //     Caption = 'Foreign Trade';
                // }
                field(formatRegion; Rec."Format Region")
                {
                    Caption = 'Format Region';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                // field(insurerName; Rec."Insurer Name")
                // {
                //     Caption = 'Insurer Name';
                // }
                // field(insurerPolicyNumber; Rec."Insurer Policy Number")
                // {
                //     Caption = 'Insurer Policy Number';
                // }
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
                // field(markedAsCanceled; Rec."Marked as Canceled")
                // {
                //     Caption = 'Marked as Canceled';
                // }
                // field(medicalInsPolicyNumber; Rec."Medical Ins. Policy Number")
                // {
                //     Caption = 'Medical Ins. Policy Number';
                // }
                // field(medicalInsurerName; Rec."Medical Insurer Name")
                // {
                //     Caption = 'Medical Insurer Name';
                // }
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
                field(opportunityNo; Rec."Opportunity No.")
                {
                    Caption = 'Opportunity No.';
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
                // field(originalDocumentXML; Rec."Original Document XML")
                // {
                //     Caption = 'Original Document XML';
                // }
                // field(originalString; Rec."Original String")
                // {
                //     Caption = 'Original String';
                // }
                field(outboundWhseHandlingTime; Rec."Outbound Whse. Handling Time")
                {
                    Caption = 'Outbound Whse. Handling Time';
                }
                // field(pacWebServiceName; Rec."PAC Web Service Name")
                // {
                //     Caption = 'PAC Web Service Name';
                // }
                field(paymentDiscount; Rec."Payment Discount %")
                {
                    Caption = 'Payment Discount %';
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code';
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
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                    Caption = 'Prices Including VAT';
                }
                field(promisedDeliveryDate; Rec."Promised Delivery Date")
                {
                    Caption = 'Promised Delivery Date';
                }
                // field(qrCode; Rec."QR Code")
                // {
                //     Caption = 'QR Code';
                // }
                field(quoteNo; Rec."Quote No.")
                {
                    Caption = 'Quote No.';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(requestedDeliveryDate; Rec."Requested Delivery Date")
                {
                    Caption = 'Requested Delivery Date';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                // field(satAddressID; Rec."SAT Address ID")
                // {
                //     Caption = 'SAT Address ID';
                // }
                // field(satWeightUnitOfMeasure; Rec."SAT Weight Unit Of Measure")
                // {
                //     Caption = 'SAT Weight Unit Of Measure';
                // }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(sellToAddress; Rec."Sell-to Address")
                {
                    Caption = 'Sell-to Address';
                }
                field(sellToAddress2; Rec."Sell-to Address 2")
                {
                    Caption = 'Sell-to Address 2';
                }
                field(sellToCity; Rec."Sell-to City")
                {
                    Caption = 'Sell-to City';
                }
                field(sellToContact; Rec."Sell-to Contact")
                {
                    Caption = 'Sell-to Contact';
                }
                field(sellToContactNo; Rec."Sell-to Contact No.")
                {
                    Caption = 'Sell-to Contact No.';
                }
                field(sellToCountryRegionCode; Rec."Sell-to Country/Region Code")
                {
                    Caption = 'Sell-to Country/Region Code';
                }
                field(sellToCounty; Rec."Sell-to County")
                {
                    Caption = 'Sell-to County';
                }
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                }
                field(sellToCustomerName2; Rec."Sell-to Customer Name 2")
                {
                    Caption = 'Sell-to Customer Name 2';
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(sellToEMail; Rec."Sell-to E-Mail")
                {
                    Caption = 'Email';
                }
                field(sellToPhoneNo; Rec."Sell-to Phone No.")
                {
                    Caption = 'Sell-to Phone No.';
                }
                field(sellToPostCode; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code';
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
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code';
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code';
                }
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                    Caption = 'Shipping Agent Service Code';
                }
                field(shippingTime; Rec."Shipping Time")
                {
                    Caption = 'Shipping Time';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                // field(signedDocumentXML; Rec."Signed Document XML")
                // {
                //     Caption = 'Signed Document XML';
                // }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                // field(substitutionDocumentNo; Rec."Substitution Document No.")
                // {
                //     Caption = 'Substitution Document No.';
                // }
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
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                // field(trailer1; Rec."Trailer 1")
                // {
                //     Caption = 'Trailer 1';
                // }
                // field(trailer2; Rec."Trailer 2")
                // {
                //     Caption = 'Trailer 2';
                // }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                }
                field("transactionType"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                // field(transitDistance; Rec."Transit Distance")
                // {
                //     Caption = 'Transit Distance';
                // }
                // field(transitHours; Rec."Transit Hours")
                // {
                //     Caption = 'Transit Hours';
                // }
                // field(transitFromDateTime; Rec."Transit-from Date/Time")
                // {
                //     Caption = 'Transit-from Date/Time';
                // }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method';
                }
                // field(transportOperators; Rec."Transport Operators")
                // {
                //     Caption = 'Transport Operators';
                // }
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
                // field(vehicleCode; Rec."Vehicle Code")
                // {
                //     Caption = 'Vehicle Code';
                // }
                field(workDescription; Rec."Work Description")
                {
                    Caption = 'Work Description';
                }
                field(yourReference; Rec."Your Reference")
                {
                    Caption = 'Your Reference';
                }
                field(route; Rec."Route 107FDW")
                {
                    Caption = 'Route';
                }
                field(route_planning_no_; Rec."Route Planning No. 107FDW")
                {
                    Caption = 'Route Planning No.';
                }
                field(truckCode; Rec."Vehicle Code 101FDW")
                {
                    Caption = 'Truck Code';
                }
            }
        }
    }
}
