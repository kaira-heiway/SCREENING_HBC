page 90023 "Item Ledger Entry"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Item Ledger Entry';
    EntitySetCaption = 'Item Ledger Entries';
    ODataKeyFields = SystemId;
    EntityName = 'itemLedgerEntry';
    EntitySetName = 'itemLedgerEntries';
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(appliedEntryToAdjust; Rec."Applied Entry to Adjust")
                {
                    Caption = 'Applied Entry to Adjust';
                }
                field(appliesToEntry; Rec."Applies-to Entry")
                {
                    Caption = 'Applies-to Entry';
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area';
                }
                field(assembleToOrder; Rec."Assemble to Order")
                {
                    Caption = 'Assemble to Order';
                }
                field(completelyInvoiced; Rec."Completely Invoiced")
                {
                    Caption = 'Completely Invoiced';
                }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction';
                }
                field(costAmountActual; Rec."Cost Amount (Actual)")
                {
                    Caption = 'Cost Amount (Actual)';
                }
                field(costAmountActualACY; Rec."Cost Amount (Actual) (ACY)")
                {
                    Caption = 'Cost Amount (Actual) (ACY)';
                }
                field(costAmountExpected; Rec."Cost Amount (Expected)")
                {
                    Caption = 'Cost Amount (Expected)';
                }
                field(costAmountExpectedACY; Rec."Cost Amount (Expected) (ACY)")
                {
                    Caption = 'Cost Amount (Expected) (ACY)';
                }
                field(costAmountNonInvtbl; Rec."Cost Amount (Non-Invtbl.)")
                {
                    Caption = 'Cost Amount (Non-Invtbl.)';
                }
                field(costAmountNonInvtblACY; Rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    Caption = 'Cost Amount (Non-Invtbl.)(ACY)';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(derivedFromBlanketOrder; Rec."Derived from Blanket Order")
                {
                    Caption = 'Derived from Blanket Order';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(documentLineNo; Rec."Document Line No.")
                {
                    Caption = 'Document Line No.';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(dropShipment; Rec."Drop Shipment")
                {
                    Caption = 'Drop Shipment';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(entryExitPoint; Rec."Entry/Exit Point")
                {
                    Caption = 'Entry/Exit Point';
                }
                field(expirationDate; Rec."Expiration Date")
                {
                    Caption = 'Expiration Date';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                    Caption = 'Invoiced Quantity';
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(itemReferenceNo; Rec."Item Reference No.")
                {
                    Caption = 'Item Reference No.';
                }
                field(itemTracking; Rec."Item Tracking")
                {
                    Caption = 'Item Tracking';
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field(jobPurchase; Rec."Job Purchase")
                {
                    Caption = 'Job Purchase';
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'Job Task No.';
                }
                field(lastInvoiceDate; Rec."Last Invoice Date")
                {
                    Caption = 'Last Invoice Date';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(lotNo; Rec."Lot No.")
                {
                    Caption = 'Lot No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(nonstock; Rec.Nonstock)
                {
                    Caption = 'Catalog';
                }
                field(open; Rec.Open)
                {
                    Caption = 'Open';
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                    Caption = 'Order Line No.';
                }
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field(orderType; Rec."Order Type")
                {
                    Caption = 'Order Type';
                }
                field(originallyOrderedNo; Rec."Originally Ordered No.")
                {
                    Caption = 'Originally Ordered No.';
                }
                field(originallyOrderedVarCode; Rec."Originally Ordered Var. Code")
                {
                    Caption = 'Originally Ordered Var. Code';
                }
                field(outOfStockSubstitution; Rec."Out-of-Stock Substitution")
                {
                    Caption = 'Out-of-Stock Substitution';
                }
                field(packageNo; Rec."Package No.")
                {
                    Caption = 'Package No.';
                }
                field(positive; Rec.Positive)
                {
                    Caption = 'Positive';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(prodOrderCompLineNo; Rec."Prod. Order Comp. Line No.")
                {
                    Caption = 'Prod. Order Comp. Line No.';
                }
                field(purchaseAmountActual; Rec."Purchase Amount (Actual)")
                {
                    Caption = 'Purchase Amount (Actual)';
                }
                field(purchaseAmountExpected; Rec."Purchase Amount (Expected)")
                {
                    Caption = 'Purchase Amount (Expected)';
                }
                field(purchasingCode; Rec."Purchasing Code")
                {
                    Caption = 'Purchasing Code';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity';
                }
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                    Caption = 'Reserved Quantity';
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code';
                }
                field(salesAmountActual; Rec."Sales Amount (Actual)")
                {
                    Caption = 'Sales Amount (Actual)';
                }
                field(salesAmountExpected; Rec."Sales Amount (Expected)")
                {
                    Caption = 'Sales Amount (Expected)';
                }
                field(serialNo; Rec."Serial No.")
                {
                    Caption = 'Serial No.';
                }
                field(shippedQtyNotReturned; Rec."Shipped Qty. Not Returned")
                {
                    Caption = 'Shipped Qty. Not Returned';
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                    Caption = 'Shortcut Dimension 5 Code';
                }
                field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                {
                    Caption = 'Shortcut Dimension 6 Code';
                }
                field(shortcutDimension7Code; Rec."Shortcut Dimension 7 Code")
                {
                    Caption = 'Shortcut Dimension 7 Code';
                }
                field(shortcutDimension8Code; Rec."Shortcut Dimension 8 Code")
                {
                    Caption = 'Shortcut Dimension 8 Code';
                }
                field(shptMethodCode; Rec."Shpt. Method Code")
                {
                    Caption = 'Shpt. Method Code';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
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
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(warrantyDate; Rec."Warranty Date")
                {
                    Caption = 'Warranty Date';
                }
                field(qualityStatusFND; Rec."Quality Status FND")
                {
                    Caption = 'Quality Status';
                }

                field(rpmSolutionFND; Rec."RPM Solution FND")
                {
                    Caption = 'RPM Solution';
                }

                field(rpmTypeFND; Rec."RPM Type FND")
                {
                    Caption = 'RPM Type';
                }

                field(itemTypeFND; Rec."Item Type FND")
                {
                    Caption = 'Item Type';
                }

                field(projectCodeFND; Rec."Project Code FND")
                {
                    Caption = 'Project Code';
                }

                field(interfaceCodeINT; Rec."Interface Code INT")
                {
                    Caption = 'Interface Code';
                }

                field(cpVendorInvoiceNoINT; Rec."CP Vendor Invoice No. INT")
                {
                    Caption = 'CP Vendor Invoice No.';
                }

                field(sourceSystemIdentifierFND; Rec."Source System Identifier FND")
                {
                    Caption = 'Source System Identifier';
                }

                field(zoneCodeFND; Rec."Zone Code FND")
                {
                    Caption = 'Zone Code';
                }

                field(vendorNoFND; Rec."Vendor No. FND")
                {
                    Caption = 'Vendor No.';
                }

                field(vendorNameFND; Rec."Vendor Name FND")
                {
                    Caption = 'Vendor Name';
                }

                field(unitVolumeHLFND; Rec."Unit Volume HL FND")
                {
                    Caption = 'Unit Volume HL';
                }

                field(scrapCodeFND; Rec."Scrap code FND")
                {
                    Caption = 'Scrap code';
                }

                field(yourReferenceFND; Rec."Your Reference FND")
                {
                    Caption = 'Your Reference';
                }

                field(reportingTypeFND; Rec."Reporting Type FND")
                {
                    Caption = 'Reporting Type';
                }
                //BC UPGRADE KUMARR78 <<
            }
        }
    }
}
