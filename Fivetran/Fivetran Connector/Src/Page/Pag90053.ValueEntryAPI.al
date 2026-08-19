namespace INTERFACES.INTERFACES;

using Microsoft.Inventory.Ledger;

page 90053 "Value Entry"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    Editable = false;
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Value Entry API';
    DelayedInsert = true;
    EntityName = 'valueEntry';
    EntitySetName = 'valueEntry';
    PageType = API;
    SourceTable = "Value Entry";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(itemLedgerEntryType; Rec."Item Ledger Entry Type")
                {
                    Caption = 'Item Ledger Entry Type';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                    Caption = 'Inventory Posting Group';
                }
                field(sourcePostingGroup; Rec."Source Posting Group")
                {
                    Caption = 'Source Posting Group';
                }
                field(itemLedgerEntryNo; Rec."Item Ledger Entry No.")
                {
                    Caption = 'Item Ledger Entry No.';
                }
                field(valuedQuantity; Rec."Valued Quantity")
                {
                    Caption = 'Valued Quantity';
                }
                field(itemLedgerEntryQuantity; Rec."Item Ledger Entry Quantity")
                {
                    Caption = 'Item Ledger Entry Quantity';
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                    Caption = 'Invoiced Quantity';
                }
                field(costPerUnit; Rec."Cost per Unit")
                {
                    Caption = 'Cost per Unit';
                }
                field(salesAmountActual; Rec."Sales Amount (Actual)")
                {
                    Caption = 'Sales Amount (Actual)';
                }
                field(salespersPurchCode; Rec."Salespers./Purch. Code")
                {
                    Caption = 'Salespers./Purch. Code';
                }
                field(discountAmount; Rec."Discount Amount")
                {
                    Caption = 'Discount Amount';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(appliesToEntry; Rec."Applies-to Entry")
                {
                    Caption = 'Applies-to Entry';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(costAmountActual; Rec."Cost Amount (Actual)")
                {
                    Caption = 'Cost Amount (Actual)';
                }
                field(costPostedToGL; Rec."Cost Posted to G/L")
                {
                    Caption = 'Cost Posted to G/L';
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
                }
                field(dropShipment; Rec."Drop Shipment")
                {
                    Caption = 'Drop Shipment';
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(costAmountActualACY; Rec."Cost Amount (Actual) (ACY)")
                {
                    Caption = 'Cost Amount (Actual) (ACY)';
                }
                field(costPostedToGLACY; Rec."Cost Posted to G/L (ACY)")
                {
                    Caption = 'Cost Posted to G/L (ACY)';
                }
                field(costPerUnitACY; Rec."Cost per Unit (ACY)")
                {
                    Caption = 'Cost per Unit (ACY)';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentLineNo; Rec."Document Line No.")
                {
                    Caption = 'Document Line No.';
                }
                field(orderType; Rec."Order Type")
                {
                    Caption = 'Order Type';
                }
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                    Caption = 'Order Line No.';
                }
                field(expectedCost; Rec."Expected Cost")
                {
                    Caption = 'Expected Cost';
                }
                field(itemChargeNo; Rec."Item Charge No.")
                {
                    Caption = 'Item Charge No.';
                }
                field(valuedByAverageCost; Rec."Valued By Average Cost")
                {
                    Caption = 'Valued By Average Cost';
                }
                field(partialRevaluation; Rec."Partial Revaluation")
                {
                    Caption = 'Partial Revaluation';
                }
                field(inventoriable; Rec.Inventoriable)
                {
                    Caption = 'Inventoriable';
                }
                field(valuationDate; Rec."Valuation Date")
                {
                    Caption = 'Valuation Date';
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(varianceType; Rec."Variance Type")
                {
                    Caption = 'Variance Type';
                }
                field(purchaseAmountActual; Rec."Purchase Amount (Actual)")
                {
                    Caption = 'Purchase Amount (Actual)';
                }
                field(purchaseAmountExpected; Rec."Purchase Amount (Expected)")
                {
                    Caption = 'Purchase Amount (Expected)';
                }
                field(salesAmountExpected; Rec."Sales Amount (Expected)")
                {
                    Caption = 'Sales Amount (Expected)';
                }
                field(costAmountExpected; Rec."Cost Amount (Expected)")
                {
                    Caption = 'Cost Amount (Expected)';
                }
                field(costAmountNonInvtbl; Rec."Cost Amount (Non-Invtbl.)")
                {
                    Caption = 'Cost Amount (Non-Invtbl.)';
                }
                field(costAmountExpectedACY; Rec."Cost Amount (Expected) (ACY)")
                {
                    Caption = 'Cost Amount (Expected) (ACY)';
                }
                field(costAmountNonInvtblACY; Rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    Caption = 'Cost Amount (Non-Invtbl.)(ACY)';
                }
                field(expectedCostPostedToGL; Rec."Expected Cost Posted to G/L")
                {
                    Caption = 'Expected Cost Posted to G/L';
                }
                field(expCostPostedToGLACY; Rec."Exp. Cost Posted to G/L (ACY)")
                {
                    Caption = 'Exp. Cost Posted to G/L (ACY)';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Project No.';
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'Project Task No.';
                }
                field(jobLedgerEntryNo; Rec."Job Ledger Entry No.")
                {
                    Caption = 'Project Ledger Entry No.';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(adjustment; Rec.Adjustment)
                {
                    Caption = 'Adjustment';
                }
                field(averageCostException; Rec."Average Cost Exception")
                {
                    Caption = 'Average Cost Exception';
                }
                field(capacityLedgerEntryNo; Rec."Capacity Ledger Entry No.")
                {
                    Caption = 'Capacity Ledger Entry No.';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code';
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
                field(costAmountPurchaseFND; Rec."Cost Amount (Purchase) FND")
                {
                    Caption = 'Cost Amount (Purchase)';
                }
                field(sourceSystemIdentifierFND; Rec."Source System Identifier FND")
                {
                    Caption = 'Source System Identifier';
                }
                field(zoneCodeFND; Rec."Zone Code FND")
                {
                    Caption = 'Zone Code';
                }
                field(binCodeFND; Rec."Bin Code FND")
                {
                    Caption = 'Bin Code';
                }
                field(revJnlErrorLogFND; Rec."Rev. Jnl. Error Log FND")
                {
                    Caption = 'Rev. Jnl. Error Log';
                }
                field(journalTemplateNameFND; Rec."Journal Template Name FND")
                {
                    Caption = 'Journal Template Name';
                }
                field(lineNoFND; Rec."Line No. FND")
                {
                    Caption = 'Line No.';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
            }
        }
    }
}
