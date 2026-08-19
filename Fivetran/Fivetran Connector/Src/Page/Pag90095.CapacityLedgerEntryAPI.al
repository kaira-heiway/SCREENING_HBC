namespace J_Interface_QUA.J_Interface_QUA;

using Microsoft.Manufacturing.Capacity;

page 90095 "Capacity Ledger Entry API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'capacityLedgerEntryAPI';
    DelayedInsert = true;
    EntityName = 'CapacityLedgerEntryapi';
    EntitySetName = 'CapacityLedgerEntryapi';
    PageType = API;
    SourceTable = "Capacity Ledger Entry";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }

                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }

                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }

                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }

                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }

                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }

                field(operationNo; Rec."Operation No.")
                {
                    Caption = 'Operation No.';
                }

                field(workCenterNo; Rec."Work Center No.")
                {
                    Caption = 'Work Center No.';
                }

                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }

                field(setupTime; Rec."Setup Time")
                {
                    Caption = 'Setup Time';
                }

                field(runTime; Rec."Run Time")
                {
                    Caption = 'Run Time';
                }

                field(stopTime; Rec."Stop Time")
                {
                    Caption = 'Stop Time';
                }

                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                    Caption = 'Invoiced Quantity';
                }

                field(outputQuantity; Rec."Output Quantity")
                {
                    Caption = 'Output Quantity';
                }

                field(scrapQuantity; Rec."Scrap Quantity")
                {
                    Caption = 'Scrap Quantity';
                }

                field(concurrentCapacity; Rec."Concurrent Capacity")
                {
                    Caption = 'Concurrent Capacity';
                }

                field(capUnitOfMeasureCode; Rec."Cap. Unit of Measure Code")
                {
                    Caption = 'Cap. Unit of Measure Code';
                }

                field(qtyPerCapUnitOfMeasure; Rec."Qty. per Cap. Unit of Measure")
                {
                    Caption = 'Qty. per Cap. Unit of Measure';
                }

                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }

                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }

                field(lastOutputLine; Rec."Last Output Line")
                {
                    Caption = 'Last Output Line';
                }

                field(completelyInvoiced; Rec."Completely Invoiced")
                {
                    Caption = 'Completely Invoiced';
                }

                field(startingTime; Rec."Starting Time")
                {
                    Caption = 'Starting Time';
                }

                field(endingTime; Rec."Ending Time")
                {
                    Caption = 'Ending Time';
                }

                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }

                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                    Caption = 'Routing Reference No.';
                }

                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }

                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }

                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }

                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }

                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }

                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }

                field(stopCode; Rec."Stop Code")
                {
                    Caption = 'Stop Code';
                }

                field(scrapCode; Rec."Scrap Code")
                {
                    Caption = 'Scrap Code';
                }

                field(workCenterGroupCode; Rec."Work Center Group Code")
                {
                    Caption = 'Work Center Group Code';
                }

                field(workShiftCode; Rec."Work Shift Code")
                {
                    Caption = 'Work Shift Code';
                }

                field(subcontracting; Rec.Subcontracting)
                {
                    Caption = 'Subcontracting';
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

                field(dimensionSetId; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
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
