namespace fivetran.fivetran;

using Microsoft.Inventory.Analysis;

page 90078 "Item Analysis View API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Item Analysis View API';
    DelayedInsert = true;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;
    EntityName = 'itemAnalysisView';
    EntitySetName = 'itemAnalysisView';
    PageType = API;
    SourceTable = "Item Analysis View";

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
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(lastEntryNo; Rec."Last Entry No.")
                {
                    Caption = 'Last Entry No.';
                }
                field(lastBudgetEntryNo; Rec."Last Budget Entry No.")
                {
                    Caption = 'Last Budget Entry No.';
                }
                field(lastDateUpdated; Rec."Last Date Updated")
                {
                    Caption = 'Last Date Updated';
                }
                field(updateOnPosting; Rec."Update on Posting")
                {
                    Caption = 'Update on Posting';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(itemFilter; Rec."Item Filter")
                {
                    Caption = 'Item Filter';
                }
                field(locationFilter; Rec."Location Filter")
                {
                    Caption = 'Location Filter';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
                field(dateCompression; Rec."Date Compression")
                {
                    Caption = 'Date Compression';
                }
                field(dimension1Code; Rec."Dimension 1 Code")
                {
                    Caption = 'Dimension 1 Code';
                }
                field(dimension2Code; Rec."Dimension 2 Code")
                {
                    Caption = 'Dimension 2 Code';
                }
                field(dimension3Code; Rec."Dimension 3 Code")
                {
                    Caption = 'Dimension 3 Code';
                }
                field(includeBudgets; Rec."Include Budgets")
                {
                    Caption = 'Include Budgets';
                }
                field(refreshWhenUnblocked; Rec."Refresh When Unblocked")
                {
                    Caption = 'Refresh When Unblocked';
                }
                field(lineExtDimCodInclInBRANDFND; Rec."LineExt.DimCodIncl.inBRAND FND")
                {
                    Caption = 'Line Extension Dimensson Code Incl. in BRAND';
                }
                field(lineExtDimensionCodeFND; Rec."Line Ext. Dimension Code FND")
                {
                    Caption = 'Line Ext. Dimension Code FND';
                }
                field(includeMarketTypeFND; Rec."Include Market Type FND")
                {
                    Caption = 'Include Market Type';
                }
                field(includeAdditCustDim1FND; Rec."Include Addit. Cust. Dim.1 FND")
                {
                    Caption = 'Include Additional Customer Dimension 1';
                }
                field(addCustDim1CodeFND; Rec."Add. Cust. Dim.1 Code FND")
                {
                    Caption = 'Additional Customer Dimension 1 Code';
                }
                field(includeAdditCustDim2FND; Rec."Include Addit. Cust. Dim.2 FND")
                {
                    Caption = 'Include Additional Customer Dimension 2';
                }
                field(addCustDim2CodeFND; Rec."Add. Cust. Dim.2 Code FND")
                {
                    Caption = 'Additional Customer Dimension 2 Code';
                }
                field(includeProductTypeFND; Rec."Include Product Type FND")
                {
                    Caption = 'Include Product Type';
                }
                field(includeProductTypeR1FND; Rec."Include Product Type R1 FND")
                {
                    Caption = 'Include Product Type R1';
                }
                field(useAltCountryCustomerFND; Rec."Use Alt. Country Customer FND")
                {
                    Caption = 'Use Alt. Country Customer FND';
                }
                field(productTypeDimenCodeFND; Rec."Product Type Dimen. Code FND")
                {
                    Caption = 'Product Type Dimension Code';
                }
                field(shortcut1CodeFND; Rec."Shortcut 1 Code FND")
                {
                    Caption = 'Shortcut 1 Code';
                }
                field(shortcut2CodeFND; Rec."Shortcut 2 Code FND")
                {
                    Caption = 'Shortcut 2 Code';
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
