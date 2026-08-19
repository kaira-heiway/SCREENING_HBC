page 90036 "Purchase Line"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'purchaseLine';
    DelayedInsert = true;
    EntityName = 'purchaseLine';
    EntitySetName = 'purchaseLines';
    PageType = API;
    SourceTable = "Purchase Line";
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(aRcdNotInvExVATLCY; Rec."A. Rcd. Not Inv. Ex. VAT (LCY)")
                {
                    Caption = 'A. Rcd. Not Inv. Ex. VAT (LCY)';
                }
                field(allocAccModifiedByUser; Rec."Alloc. Acc. Modified by User")
                {
                    Caption = 'Allocation Account Distributions Modified';
                }
                field(allocationAccountNo; Rec."Allocation Account No.")
                {
                    Caption = 'Posting Allocation Account No.';
                }
                field(allowInvoiceDisc; Rec."Allow Invoice Disc.")
                {
                    Caption = 'Allow Invoice Disc.';
                }
                field(allowItemChargeAssignment; Rec."Allow Item Charge Assignment")
                {
                    Caption = 'Allow Item Charge Assignment';
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(amtRcdNotInvoiced; Rec."Amt. Rcd. Not Invoiced")
                {
                    Caption = 'Amt. Rcd. Not Invoiced';
                }
                field(amtRcdNotInvoicedLCY; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    Caption = 'Amt. Rcd. Not Invoiced (LCY)';
                }
                field(applToItemEntry; Rec."Appl.-to Item Entry")
                {
                    Caption = 'Appl.-to Item Entry';
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area';
                }
                field(attachedDocCount; Rec."Attached Doc Count")
                {
                    Caption = 'Attached Doc Count';
                }
                field(attachedLinesCount; Rec."Attached Lines Count")
                {
                    Caption = 'Attached Lines Count';
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
                field(budgetedFANo; Rec."Budgeted FA No.")
                {
                    Caption = 'Budgeted FA No.';
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(completelyReceived; Rec."Completely Received")
                {
                    Caption = 'Completely Received';
                }
                field(copiedFromPostedDoc; Rec."Copied From Posted Doc.")
                {
                    Caption = 'Copied From Posted Doc.';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                //Bc Upgrade SAIA01 >>
                field(cmg_code; Rec."CMG Code FND")
                {
                    Caption = 'CMG Code';
                }
                //Bc Upgrade SAIA01 <<
                field(deferralCode; Rec."Deferral Code")
                {
                    Caption = 'Deferral Code';
                }
                field(deprAcquisitionCost; Rec."Depr. Acquisition Cost")
                {
                    Caption = 'Depr. Acquisition Cost';
                }
                field(deprUntilFAPostingDate; Rec."Depr. until FA Posting Date")
                {
                    Caption = 'Depr. until FA Posting Date';
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                //Bc Upgrade SAIA01 >>
                field(delivery_finalized; Rec."Delivery Finalized FND")
                {
                    Caption = 'Delivery Finalized';
                }
                //Bc Upgrade SAIA01 <<
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
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(dropShipment; Rec."Drop Shipment")
                {
                    Caption = 'Drop Shipment';
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
                field(finished; Rec.Finished)
                {
                    Caption = 'Finished';
                }
                // field(gstHST; Rec."GST/HST")
                // {
                //     Caption = 'GST/HST';
                // }
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
                field(icItemReferenceNo; Rec."IC Item Reference No.")
                {
                    Caption = 'IC Item Reference No.';
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
                field(inboundWhseHandlingTime; Rec."Inbound Whse. Handling Time")
                {
                    Caption = 'Inbound Whse. Handling Time';
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %';
                }
                field(insuranceNo; Rec."Insurance No.")
                {
                    Caption = 'Insurance No.';
                }
                field(invDiscAmountToInvoice; Rec."Inv. Disc. Amount to Invoice")
                {
                    Caption = 'Inv. Disc. Amount to Invoice';
                }
                field(invDiscountAmount; Rec."Inv. Discount Amount")
                {
                    Caption = 'Inv. Discount Amount';
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(itemChargeQtyToHandle; Rec."Item Charge Qty. to Handle")
                {
                    Caption = 'Item Charge Qty. to Handle';
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
                field(jobLineDiscount; Rec."Job Line Discount %")
                {
                    Caption = 'Job Line Discount %';
                }
                field(jobLineDiscountAmount; Rec."Job Line Discount Amount")
                {
                    Caption = 'Job Line Discount Amount';
                }
                field(jobLineType; Rec."Job Line Type")
                {
                    Caption = 'Job Line Type';
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field(jobPlanningLineNo; Rec."Job Planning Line No.")
                {
                    Caption = 'Job Planning Line No.';
                }
                field(jobRemainingQty; Rec."Job Remaining Qty.")
                {
                    Caption = 'Job Remaining Qty.';
                }
                field(jobRemainingQtyBase; Rec."Job Remaining Qty. (Base)")
                {
                    Caption = 'Job Remaining Qty. (Base)';
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
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                    Caption = 'Lead Time Calculation';
                }
                field(lineAmount; Rec."Line Amount")
                {
                    Caption = 'Line Amount';
                }
                field(lineDiscount; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                }
                field(lineDiscountAmount; Rec."Line Discount Amount")
                {
                    Caption = 'Line Discount Amount';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(mpsOrder; Rec."MPS Order")
                {
                    Caption = 'MPS Order';
                }
                field(maintenanceCode; Rec."Maintenance Code")
                {
                    Caption = 'Maintenance Code';
                }
                field(netWeight; Rec."Net Weight")
                {
                    Caption = 'Net Weight';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(nonDeductibleVAT; Rec."Non-Deductible VAT %")
                {
                    Caption = 'Non-Deductible VAT %';
                }
                field(nonDeductibleVATAmount; Rec."Non-Deductible VAT Amount")
                {
                    Caption = 'Non-Deductible VAT Amount';
                }
                field(nonDeductibleVATBase; Rec."Non-Deductible VAT Base")
                {
                    Caption = 'Non-Deductible VAT Base';
                }
                field(nonDeductibleVATDiff; Rec."Non-Deductible VAT Diff.")
                {
                    Caption = 'Non-Deductible VAT Difference';
                }
                field(nonstock; Rec.Nonstock)
                {
                    Caption = 'Catalog';
                }
                field(operationNo; Rec."Operation No.")
                {
                    Caption = 'Operation No.';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                    Caption = 'Order Line No.';
                }
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field(outstandingAmount; Rec."Outstanding Amount")
                {
                    Caption = 'Outstanding Amount';
                }
                field(outstandingAmountLCY; Rec."Outstanding Amount (LCY)")
                {
                    Caption = 'Outstanding Amount (LCY)';
                }
                field(outstandingAmtExVATLCY; Rec."Outstanding Amt. Ex. VAT (LCY)")
                {
                    Caption = 'Outstanding Amt. Ex. VAT (LCY)';
                }
                field(outstandingQtyBase; Rec."Outstanding Qty. (Base)")
                {
                    Caption = 'Outstanding Qty. (Base)';
                }
                field(outstandingQuantity; Rec."Outstanding Quantity")
                {
                    Caption = 'Outstanding Quantity';
                }
                field(overReceiptApprovalStatus; Rec."Over-Receipt Approval Status")
                {
                    Caption = 'Over-Receipt Approval Status';
                }
                field(overReceiptCode; Rec."Over-Receipt Code")
                {
                    Caption = 'Over-Receipt Code';
                }
                field(overReceiptQuantity; Rec."Over-Receipt Quantity")
                {
                    Caption = 'Over-Receipt Quantity';
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                    Caption = 'Overhead Rate';
                }
                field(payToVendorNo; Rec."Pay-to Vendor No.")
                {
                    Caption = 'Pay-to Vendor No.';
                }
                field(plannedReceiptDate; Rec."Planned Receipt Date")
                {
                    Caption = 'Planned Receipt Date';
                }
                field(planningFlexibility; Rec."Planning Flexibility")
                {
                    Caption = 'Planning Flexibility';
                }
                field(pmtDiscountAmount; Rec."Pmt. Discount Amount")
                {
                    Caption = 'Pmt. Discount Amount';
                }
                field(postingGroup; Rec."Posting Group")
                {
                    Caption = 'Posting Group';
                }
                field(prepayment; Rec."Prepayment %")
                {
                    Caption = 'Prepayment %';
                }
                field(prepaymentAmount; Rec."Prepayment Amount")
                {
                    Caption = 'Prepayment Amount';
                }
                field(prepaymentLine; Rec."Prepayment Line")
                {
                    Caption = 'Prepayment Line';
                }
                field(prepaymentTaxAreaCode; Rec."Prepayment Tax Area Code")
                {
                    Caption = 'Prepayment Tax Area Code';
                }
                field(prepaymentTaxGroupCode; Rec."Prepayment Tax Group Code")
                {
                    Caption = 'Prepayment Tax Group Code';
                }
                field(prepaymentTaxLiable; Rec."Prepayment Tax Liable")
                {
                    Caption = 'Prepayment Tax Liable';
                }
                field(prepaymentVAT; Rec."Prepayment VAT %")
                {
                    Caption = 'Prepayment VAT %';
                }
                field(prepaymentVATDifference; Rec."Prepayment VAT Difference")
                {
                    Caption = 'Prepayment VAT Difference';
                }
                field(prepaymentVATIdentifier; Rec."Prepayment VAT Identifier")
                {
                    Caption = 'Prepayment VAT Identifier';
                }
                field(prepmtAmtDeducted; Rec."Prepmt Amt Deducted")
                {
                    Caption = 'Prepmt Amt Deducted';
                }
                field(prepmtAmtToDeduct; Rec."Prepmt Amt to Deduct")
                {
                    Caption = 'Prepmt Amt to Deduct';
                }
                field(prepmtVATDiffDeducted; Rec."Prepmt VAT Diff. Deducted")
                {
                    Caption = 'Prepmt VAT Diff. Deducted';
                }
                field(prepmtVATDiffToDeduct; Rec."Prepmt VAT Diff. to Deduct")
                {
                    Caption = 'Prepmt VAT Diff. to Deduct';
                }
                field(prepmtAmountInvLCY; Rec."Prepmt. Amount Inv. (LCY)")
                {
                    Caption = 'Prepmt. Amount Inv. (LCY)';
                }
                field(prepmtAmountInvInclVAT; Rec."Prepmt. Amount Inv. Incl. VAT")
                {
                    Caption = 'Prepmt. Amount Inv. Incl. VAT';
                }
                field(prepmtAmtInclVAT; Rec."Prepmt. Amt. Incl. VAT")
                {
                    Caption = 'Prepmt. Amt. Incl. VAT';
                }
                field(prepmtAmtInv; Rec."Prepmt. Amt. Inv.")
                {
                    Caption = 'Prepmt. Amt. Inv.';
                }
                field(prepmtLineAmount; Rec."Prepmt. Line Amount")
                {
                    Caption = 'Prepmt. Line Amount';
                }
                field(prepmtNonDeductVATAmount; Rec."Prepmt. Non-Deduct. VAT Amount")
                {
                    Caption = 'Prepmt. on-Deductible VAT Amount';
                }
                field(prepmtNonDeductVATBase; Rec."Prepmt. Non-Deduct. VAT Base")
                {
                    Caption = 'Prepmt.  Non-Deductible VAT Base';
                }
                field(prepmtPmtDiscountAmount; Rec."Prepmt. Pmt. Discount Amount")
                {
                    Caption = 'Prepmt. Pmt. Discount Amount';
                }
                field(prepmtVATAmountInvLCY; Rec."Prepmt. VAT Amount Inv. (LCY)")
                {
                    Caption = 'Prepmt. VAT Amount Inv. (LCY)';
                }
                field(prepmtVATBaseAmt; Rec."Prepmt. VAT Base Amt.")
                {
                    Caption = 'Prepmt. VAT Base Amt.';
                }
                field(prepmtVATCalcType; Rec."Prepmt. VAT Calc. Type")
                {
                    Caption = 'Prepmt. VAT Calc. Type';
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method';
                }
                field(prodOrderLineNo; Rec."Prod. Order Line No.")
                {
                    Caption = 'Prod. Order Line No.';
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.';
                }
                field(profit; Rec."Profit %")
                {
                    Caption = 'Profit %';
                }
                field(promisedReceiptDate; Rec."Promised Receipt Date")
                {
                    Caption = 'Promised Receipt Date';
                }
                // field(provincialTaxAreaCode; Rec."Provincial Tax Area Code")
                // {
                //     Caption = 'Provincial Tax Area Code';
                // }
                field(purchasingCode; Rec."Purchasing Code")
                {
                    Caption = 'Purchasing Code';
                }
                field(qtyAssigned; Rec."Qty. Assigned")
                {
                    Caption = 'Qty. Assigned';
                }
                field(qtyInvoicedBase; Rec."Qty. Invoiced (Base)")
                {
                    Caption = 'Qty. Invoiced (Base)';
                }
                field(qtyRcdNotInvoiced; Rec."Qty. Rcd. Not Invoiced")
                {
                    Caption = 'Qty. Rcd. Not Invoiced';
                }
                field(qtyRcdNotInvoicedBase; Rec."Qty. Rcd. Not Invoiced (Base)")
                {
                    Caption = 'Qty. Rcd. Not Invoiced (Base)';
                }
                field(qtyReceivedBase; Rec."Qty. Received (Base)")
                {
                    Caption = 'Qty. Received (Base)';
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                    Caption = 'Qty. Rounding Precision';
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                    Caption = 'Qty. Rounding Precision (Base)';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(qtyToAssign; Rec."Qty. to Assign")
                {
                    Caption = 'Qty. to Assign';
                }
                field(qtyToInvoice; Rec."Qty. to Invoice")
                {
                    Caption = 'Qty. to Invoice';
                }
                field(qtyToInvoiceBase; Rec."Qty. to Invoice (Base)")
                {
                    Caption = 'Qty. to Invoice (Base)';
                }
                field(qtyToReceive; Rec."Qty. to Receive")
                {
                    Caption = 'Qty. to Receive';
                }
                field(qtyToReceiveBase; Rec."Qty. to Receive (Base)")
                {
                    Caption = 'Qty. to Receive (Base)';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field(quantityInvoiced; Rec."Quantity Invoiced")
                {
                    Caption = 'Quantity Invoiced';
                }
                field(quantityReceived; Rec."Quantity Received")
                {
                    Caption = 'Quantity Received';
                }
                field(recalculateInvoiceDisc; Rec."Recalculate Invoice Disc.")
                {
                    Caption = 'Recalculate Invoice Disc.';
                }
                field(receiptLineNo; Rec."Receipt Line No.")
                {
                    Caption = 'Receipt Line No.';
                }
                field(receiptNo; Rec."Receipt No.")
                {
                    Caption = 'Receipt No.';
                }
                field(requestedReceiptDate; Rec."Requested Receipt Date")
                {
                    Caption = 'Requested Receipt Date';
                }
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                    Caption = 'Reserved Qty. (Base)';
                }
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                    Caption = 'Reserved Quantity';
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field(retQtyShpdNotInvdBase; Rec."Ret. Qty. Shpd Not Invd.(Base)")
                {
                    Caption = 'Ret. Qty. Shpd Not Invd.(Base)';
                }
                field(returnQtyShipped; Rec."Return Qty. Shipped")
                {
                    Caption = 'Return Qty. Shipped';
                }
                field(returnQtyShippedBase; Rec."Return Qty. Shipped (Base)")
                {
                    Caption = 'Return Qty. Shipped (Base)';
                }
                field(returnQtyShippedNotInvd; Rec."Return Qty. Shipped Not Invd.")
                {
                    Caption = 'Return Qty. Shipped Not Invd.';
                }
                field(returnQtyToShip; Rec."Return Qty. to Ship")
                {
                    Caption = 'Return Qty. to Ship';
                }
                field(returnQtyToShipBase; Rec."Return Qty. to Ship (Base)")
                {
                    Caption = 'Return Qty. to Ship (Base)';
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
                field(returnShpdNotInvd; Rec."Return Shpd. Not Invd.")
                {
                    Caption = 'Return Shpd. Not Invd.';
                }
                field(returnShpdNotInvdLCY; Rec."Return Shpd. Not Invd. (LCY)")
                {
                    Caption = 'Return Shpd. Not Invd. (LCY)';
                }
                field(returnsDeferralStartDate; Rec."Returns Deferral Start Date")
                {
                    Caption = 'Returns Deferral Start Date';
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                    Caption = 'Routing Reference No.';
                }
                field(safetyLeadTime; Rec."Safety Lead Time")
                {
                    Caption = 'Safety Lead Time';
                }
                field(salesOrderLineNo; Rec."Sales Order Line No.")
                {
                    Caption = 'Sales Order Line No.';
                }
                field(salesOrderNo; Rec."Sales Order No.")
                {
                    Caption = 'Sales Order No.';
                }
                field(salvageValue; Rec."Salvage Value")
                {
                    Caption = 'Salvage Value';
                }
                field(selectedAllocAccountNo; Rec."Selected Alloc. Account No.")
                {
                    Caption = 'Allocation Account No.';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(specialOrder; Rec."Special Order")
                {
                    Caption = 'Special Order';
                }
                field(specialOrderSalesLineNo; Rec."Special Order Sales Line No.")
                {
                    Caption = 'Special Order Sales Line No.';
                }
                field(specialOrderSalesNo; Rec."Special Order Sales No.")
                {
                    Caption = 'Special Order Sales No.';
                }
                field(subtype; Rec.Subtype)
                {
                    Caption = 'Subtype';
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                    Caption = 'System-Created Entry';
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
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                // field(taxToBeExpensed; Rec."Tax To Be Expensed")
                // {
                //     Caption = 'Tax To Be Expensed';
                // }
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
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                //Bc Upgrade SAIA01 >>
                field(tolerance_received_over__; Rec."Tolerance Received Over % FND")
                {
                    Caption = 'Tolerance Received Over %';
                }
                field(tolerance_received_under__; Rec."Tolerance Received Under % FND")
                {
                    Caption = 'Tolerance Received Under %';
                }
                //Bc Upgrade SAIA01 <<
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                }
                field(unitPriceLCY; Rec."Unit Price (LCY)")
                {
                    Caption = 'Unit Price (LCY)';
                }
                field(unitVolume; Rec."Unit Volume")
                {
                    Caption = 'Unit Volume';
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
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
                field(vat; Rec."VAT %")
                {
                    Caption = 'VAT %';
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
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(vendorItemNo; Rec."Vendor Item No.")
                {
                    Caption = 'Vendor Item No.';
                }
                field(whseOutstandingQtyBase; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Caption = 'Whse. Outstanding Qty. (Base)';
                }
                field(workCenterNo; Rec."Work Center No.")
                {
                    Caption = 'Work Center No.';
                }
                field(documentDate; Rec."Header Document Date FND")
                {
                    Caption = 'Document Date';
                }
            }
        }
    }
}
