namespace fivetran.fivetran;

using Microsoft.Inventory.Analysis;

page 90080 "Item Analysis View Entry API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Item Analysis View Entry API';
    DelayedInsert = true;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    EntityName = 'itemAnalysisViewEntry';
    EntitySetName = 'itemAnalysisViewEntries';
    PageType = API;
    SourceTable = "Item Analysis View Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(analysisArea; Rec."Analysis Area")
                {
                    Caption = 'Analysis Area';
                }
                field(analysisViewCode; Rec."Analysis View Code")
                {
                    Caption = 'Analysis View Code';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(itemLedgerEntryType; Rec."Item Ledger Entry Type")
                {
                    Caption = 'Item Ledger Entry Type';
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(dimension1ValueCode; Rec."Dimension 1 Value Code")
                {
                    Caption = 'Dimension 1 Value Code';
                }
                field(dimension2ValueCode; Rec."Dimension 2 Value Code")
                {
                    Caption = 'Dimension 2 Value Code';
                }
                field(dimension3ValueCode; Rec."Dimension 3 Value Code")
                {
                    Caption = 'Dimension 3 Value Code';
                }
                field(shortcut1ValueCodeFND; Rec."Shortcut 1 Value Code FND")
                {
                    Caption = 'Shortcut 1 Value Code FND';
                }
                field(shortcut2ValueCodeFND; Rec."Shortcut 2 Value Code FND")
                {
                    Caption = 'Shortcut 2 Value Code FND';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                    Caption = 'Invoiced Quantity';
                }
                field(salesAmountActual; Rec."Sales Amount (Actual)")
                {
                    Caption = 'Sales Amount (Actual)';
                }
                field(costAmountActual; Rec."Cost Amount (Actual)")
                {
                    Caption = 'Cost Amount (Actual)';
                }
                field(costAmountNonInvtbl; Rec."Cost Amount (Non-Invtbl.)")
                {
                    Caption = 'Cost Amount (Non-Invtbl.)';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(salesAmountExpected; Rec."Sales Amount (Expected)")
                {
                    Caption = 'Sales Amount (Expected)';
                }
                field(costAmountExpected; Rec."Cost Amount (Expected)")
                {
                    Caption = 'Cost Amount (Expected)';
                }
                field(addMarketTypeBPGFND; Rec."Add. Market type (BPG) FND")
                {
                    Caption = 'Additional Market Type (BPG)';
                }
                field(addProductTypePPGFND; Rec."Add. Product type (PPG) FND")
                {
                    Caption = 'Additional Product Type (PPG)';
                }
                field(addCustDim1FND; Rec."Add. Cust. Dim.1 FND")
                {
                    Caption = 'Additional Customer Dimension 1';
                }
                field(addCustDim2FND; Rec."Add. Cust. Dim.2 FND")
                {
                    Caption = 'Additional Customer Dimension 2';
                }
                field(addProductTypeR1PPGFND; Rec."Add. Product type R1 (PPG) FND")
                {
                    Caption = 'Additional Product Type R1 (PPG)';
                }
                field(lineExtDimValueCodeFND; Rec."Line Ext. Dim. Value Code FND")
                {
                    Caption = 'Line Ext. Dim. Value Code FND';
                }
                field(reportingTypeFND; Rec."Reporting Type FND")
                {
                    Caption = 'Reporting Type';
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
