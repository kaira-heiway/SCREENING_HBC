page 90141 "Purch. Cr. Memo Line API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Purch. Cr. Memo Line';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Purch. Cr. Memo Line';
    EntitySetCaption = 'Purch. Cr. Memo Line';
    EntityName = 'PurchCrMemoLine';
    EntitySetName = 'PurchCrMemoLine';
    SourceTable = "Purch. Cr. Memo Line";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(additionalDescription; Rec."Additional Description FND")
                {
                    Caption = 'Additional Description';
                }
                field(allowInvoiceDisc; Rec."Allow Invoice Disc.")
                {
                    Caption = 'Allow Invoice Disc.';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(applToItemEntry; Rec."Appl.-to Item Entry")
                {
                    Caption = 'Appl.-to Item Entry';
                }
                field(area_; Rec."Area")
                {
                    Caption = 'Area';
                }
                field(attachedToLineNo; Rec."Attached to Line No.")
                {
                    Caption = 'Attached to Line No.';
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(blanketOrderLineNo; Rec."Blanket Order Line No.")
                {
                    Caption = 'Blanket Order Line No.';
                }
                field(blanketOrderNo; Rec."Blanket Order No.")
                {
                    Caption = 'Blanket Order No.';
                }
                field(blockLineOrdering; Rec."Block Line Ordering FND")
                {
                    Caption = 'Block Line Ordering';
                }
                field(budgetedFANo; Rec."Budgeted FA No.")
                {
                    Caption = 'Budgeted FA No.';
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(cadAmount; Rec."CAD Amount FND")
                {
                    Caption = 'CAD Amount';
                }
                field(cadAttachedToLineNo; Rec."CAD Attached to Line No. FND")
                {
                    Caption = 'CAD Attached to Line No.';
                }

                field(cancelled; Rec."Cancelled FND")
                {
                    Caption = 'Cancelled';
                }
                field(cmgCode; Rec."CMG Code FND")
                {
                    Caption = 'CMG Code';
                }

                field(consumptionLocationCode; Rec."Consumption Location Code FND")
                {
                    Caption = 'Consumption Location Code';
                }
                field(consumptionSPLCode; Rec."Consumption SPL Code FND")
                {
                    Caption = 'Consumption SPL Code';
                }
                field(deferralCode; Rec."Deferral Code")
                {
                    Caption = 'Deferral Code';
                }
                field(deliveryFinalized; Rec."Delivery Finalized FND")
                {
                    Caption = 'Delivery Finalized';
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code';
                }
                field(deprAcquisitionCost; Rec."Depr. Acquisition Cost")
                {
                    Caption = 'Depr. Acquisition Cost';
                }
                field(deprUntilFAPostingDate; Rec."Depr. until FA Posting Date")
                {
                    Caption = 'Depr. until FA Posting Date';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost';
                }

                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(duplicateInDepreciationBook; Rec."Duplicate in Depreciation Book")
                {
                    Caption = 'Duplicate in Depreciation Book';
                }
                field(entryPoint; Rec."Entry Point")
                {
                    Caption = 'Entry Point';
                }
                field(expectedReceiptDate; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
                }
                field(faPostingDate; Rec."FA Posting Date")
                {
                    Caption = 'FA Posting Date';
                }
                field(faPostingType; Rec."FA Posting Type")
                {
                    Caption = 'FA Posting Type';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(grossWeight; Rec."Gross Weight")
                {
                    Caption = 'Gross Weight';
                }
                field(hSLevyTaxAmount; Rec."H&S Levy Tax Amount FND")
                {
                    Caption = 'H&S Levy Tax Amount';
                }
                field(hSLevyTaxPct; Rec."H&S Levy Tax % FND")
                {
                    Caption = 'H&S Levy Tax %';
                }
                field(hsPostingGroup; Rec."HS Posting Group FND")
                {
                    Caption = 'HS Posting Group';
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code';
                }
                field(icPartnerRefType; Rec."IC Partner Ref. Type")
                {
                    Caption = 'IC Partner Ref. Type';
                }
                field(icPartnerReference; Rec."IC Partner Reference")
                {
                    Caption = 'IC Partner Reference';
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %';
                }
                field(initialQuantity; Rec."Initial Quantity FND")
                {
                    Caption = 'Initial Quantity';
                }
                field(insuranceNo; Rec."Insurance No.")
                {
                    Caption = 'Insurance No.';
                }
                field(invDiscountAmount; Rec."Inv. Discount Amount")
                {
                    Caption = 'Inv. Discount Amount';
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(itemReferenceNo; Rec."Item Reference No.")
                {
                    Caption = 'Item Reference No.';
                }
                field(itemReferenceType; Rec."Item Reference Type")
                {
                    Caption = 'Item Reference Type';
                }
                field(itemReferenceTypeNo; Rec."Item Reference Type No.")
                {
                    Caption = 'Item Reference Type No.';
                }
                field(itemReferenceUnitOfMeasure; Rec."Item Reference Unit of Measure")
                {
                    Caption = 'Item Reference Unit of Measure';
                }
                field(jobCurrencyCode; Rec."Job Currency Code")
                {
                    Caption = 'Job Currency Code';
                }
                field(jobCurrencyFactor; Rec."Job Currency Factor")
                {
                    Caption = 'Job Currency Factor';
                }
                field(jobLineAmount; Rec."Job Line Amount")
                {
                    Caption = 'Job Line Amount';
                }
                field(jobLineAmountLCY; Rec."Job Line Amount (LCY)")
                {
                    Caption = 'Job Line Amount (LCY)';
                }
                field(jobLineDiscAmountLCY; Rec."Job Line Disc. Amount (LCY)")
                {
                    Caption = 'Job Line Disc. Amount (LCY)';
                }
                field(jobLineDiscountAmount; Rec."Job Line Discount Amount")
                {
                    Caption = 'Job Line Discount Amount';
                }
                field(jobLineDiscountPct; Rec."Job Line Discount %")
                {
                    Caption = 'Job Line Discount %';
                }
                field(jobLineType; Rec."Job Line Type")
                {
                    Caption = 'Job Line Type';
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'Job Task No.';
                }
                field(jobTotalPrice; Rec."Job Total Price")
                {
                    Caption = 'Job Total Price';
                }
                field(jobTotalPriceLCY; Rec."Job Total Price (LCY)")
                {
                    Caption = 'Job Total Price (LCY)';
                }
                field(jobUnitPrice; Rec."Job Unit Price")
                {
                    Caption = 'Job Unit Price';
                }
                field(jobUnitPriceLCY; Rec."Job Unit Price (LCY)")
                {
                    Caption = 'Job Unit Price (LCY)';
                }
                field(lineAmount; Rec."Line Amount")
                {
                    Caption = 'Line Amount';
                }
                field(lineDiscountAmount; Rec."Line Discount Amount")
                {
                    Caption = 'Line Discount Amount';
                }
                field(lineDiscountPct; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(lineType; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(maintenanceCode; Rec."Maintenance Code")
                {
                    Caption = 'Maintenance Code';
                }
                field(maximoRequisitionLineNo; Rec."Maximo Requis. Line No. FND")
                {
                    Caption = 'Maximo Requisition Line No.';
                }
                field(maximoRequisitionNo; Rec."Maximo Requisition No. FND")
                {
                    Caption = 'Maximo Requisition No.';
                }
                field(netWeight; Rec."Net Weight")
                {
                    Caption = 'Net Weight';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(nonstock; Rec.Nonstock)
                {
                    Caption = 'Nonstock';
                }
                field(payToVendorNo; Rec."Pay-to Vendor No.")
                {
                    Caption = 'Pay-to Vendor No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(postingGroup; Rec."Posting Group")
                {
                    Caption = 'Posting Group';
                }
                field(prepaymentLine; Rec."Prepayment Line")
                {
                    Caption = 'Prepayment Line';
                }
                field(purchasingCode; Rec."Purchasing Code")
                {
                    Caption = 'Purchasing Code';
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code';
                }
                field(returnShipmentLineNo; Rec."Return Shipment Line No.")
                {
                    Caption = 'Return Shipment Line No.';
                }
                field(returnShipmentNo; Rec."Return Shipment No.")
                {
                    Caption = 'Return Shipment No.';
                }
                field(salvageValue; Rec."Salvage Value")
                {
                    Caption = 'Salvage Value';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(splCode; Rec."SPL Code FND")
                {
                    Caption = 'SPL Code';
                }
                field(splName; Rec."SPL Name FND")
                {
                    Caption = 'SPL Name';
                }
                field(srmContractLineNo; Rec."SRM Contract Line No. FND")
                {
                    Caption = 'SRM Contract Line No.';
                }
                field(srmContractNo; Rec."SRM Contract No. FND")
                {
                    Caption = 'SRM Contract No.';
                }
                field(srmOrderLineNo; Rec."SRM Order Line No. FND")
                {
                    Caption = 'SRM Order Line No.';
                }
                field(srmOrderNo; Rec."SRM Order No. FND")
                {
                    Caption = 'SRM Order No.';
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                    Caption = 'System-Created Entry';
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
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(tinNo; Rec."TIN No. FND")
                {
                    Caption = 'TIN No.';
                }
                field(toleranceReceivedOverPct; Rec."Tolerance Received Over % FND")
                {
                    Caption = 'Tolerance Received Over %';
                }
                field(toleranceReceivedUnderPct; Rec."Tolerance Received Under % FND")
                {
                    Caption = 'Tolerance Received Under %';
                }
                field(totalAmountExclVATHS; Rec."Total Amount Excl VAT/H&S FND")
                {
                    Caption = 'Total Amount Excl VAT/H&S';
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
                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(typeID; Rec."Type ID FND")
                {
                    Caption = 'Type ID';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(unitPriceLCY; Rec."Unit Price (LCY)")
                {
                    Caption = 'Unit Price (LCY)';
                }
                field(unitVolume; Rec."Unit Volume")
                {
                    Caption = 'Unit Volume';
                }
                field(unitsPerParcel; Rec."Units per Parcel")
                {
                    Caption = 'Units per Parcel';
                }
                field(useDuplicationList; Rec."Use Duplication List")
                {
                    Caption = 'Use Duplication List';
                }
                field(useTax; Rec."Use Tax")
                {
                    Caption = 'Use Tax';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(vatBaseAmount; Rec."VAT Base Amount")
                {
                    Caption = 'VAT Base Amount';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatCalculationType; Rec."VAT Calculation Type")
                {
                    Caption = 'VAT Calculation Type';
                }
                field(vatDifference; Rec."VAT Difference")
                {
                    Caption = 'VAT Difference';
                }
                field(vatIdentifier; Rec."VAT Identifier")
                {
                    Caption = 'VAT Identifier';
                }
                field(vatPct; Rec."VAT %")
                {
                    Caption = 'VAT %';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(vendorItemNo; Rec."Vendor Item No.")
                {
                    Caption = 'Vendor Item No.';
                }
                field(whtAbsorbBase; Rec."WHT Absorb Base FND")
                {
                    Caption = 'WHT Absorb Base';
                }
                field(whtBusinessPostingGroup; Rec."WHT Business Posting Group FND")
                {
                    Caption = 'WHT Business Posting Group';
                }
                field(whtProductPostingGroup; Rec."WHT Product Posting Group FND")
                {
                    Caption = 'WHT Product Posting Group';
                }
                field(zycusMovementType; Rec."Zycus Movement Type FND")
                {
                    Caption = 'Zycus Movement Type';
                }
                field(zycusOrderLineNo; Rec."Zycus Order Line No. FND")
                {
                    Caption = 'Zycus Order Line No.';
                }
                field(zycusOrderNo; Rec."Zycus Order No. FND")
                {
                    Caption = 'Zycus Order No.';
                }
                field(zycusPOLineTypeCode; Rec."Zycus PO Line Type Code FND")
                {
                    Caption = 'Zycus PO Line Type Code';
                }
                field(zycusPOLineValidated; Rec."Zycus PO Line Validated FND")
                {
                    Caption = 'Zycus PO Line Validated';
                }
                field(zycusPOTypeCode; Rec."Zycus PO Type Code FND")
                {
                    Caption = 'Zycus PO Type Code';
                }
                field(zycusPRReferenceNo; Rec."Zycus PR Reference No. FND")
                {
                    Caption = 'Zycus PR Reference No.';
                }
            }
        }
    }
}
