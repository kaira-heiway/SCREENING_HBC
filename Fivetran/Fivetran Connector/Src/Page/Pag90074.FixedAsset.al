namespace fivetran.fivetran;

using Microsoft.FixedAssets.FixedAsset;

page 90074 "Fixed Asset API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Fixed Asset API';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityName = 'fixedAsset';
    EntitySetName = 'fixedAssets';
    PageType = API;
    SourceTable = "Fixed Asset";
    // BC Upgrade PATELP08 >>
    // ADDED NEW FIELD faTemplateCode
    // BC Upgrade PATELP08<<
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(searchDescription; Rec."Search Description")
                {
                    Caption = 'Search Description';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(faClassCode; Rec."FA Class Code")
                {
                    Caption = 'FA Class Code';
                }
                field(faSubclassCode; Rec."FA Subclass Code")
                {
                    Caption = 'FA Subclass Code';
                }
                // BC Upgrade PATELP08 >> added new field
                field(faTemplateCode; Rec."FA Template APS")
                {
                    Caption = 'FA Template Code';
                }
                // BC Upgrade PATELP08 <<
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(faLocationCode; Rec."FA Location Code")
                {
                    Caption = 'FA Location Code';
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field(mainAssetComponent; Rec."Main Asset/Component")
                {
                    Caption = 'Main Asset/Component';
                }
                field(componentOfMainAsset; Rec."Component of Main Asset")
                {
                    Caption = 'Component of Main Asset';
                }
                field(budgetedAsset; Rec."Budgeted Asset")
                {
                    Caption = 'Budgeted Asset';
                }
                field(warrantyDate; Rec."Warranty Date")
                {
                    Caption = 'Warranty Date';
                }
                field(responsibleEmployee; Rec."Responsible Employee")
                {
                    Caption = 'Responsible Employee';
                }
                field(serialNo; Rec."Serial No.")
                {
                    Caption = 'Serial No.';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(maintenanceVendorNo; Rec."Maintenance Vendor No.")
                {
                    Caption = 'Maintenance Vendor No.';
                }
                field(underMaintenance; Rec."Under Maintenance")
                {
                    Caption = 'Under Maintenance';
                }
                field(nextServiceDate; Rec."Next Service Date")
                {
                    Caption = 'Next Service Date';
                }
                field(inactive; Rec.Inactive)
                {
                    Caption = 'Inactive';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(faPostingGroup; Rec."FA Posting Group")
                {
                    Caption = 'FA Posting Group';
                }
                field(image; Rec.Image)
                {
                    Caption = 'Image';
                }
                field(customer_no_; Rec."Customer No. 114FDW")
                {
                    Caption = 'Customer No.';
                }
                field(assetIndicatorFND; Rec."Asset Indicator FND")
                {
                    Caption = 'Asset Indicator';
                }
                field(whtProductPostingGroupFND; Rec."WHT Product Posting Group FND")
                {
                    Caption = 'WHT Product Posting Group';
                }
                field(quantityFND; Rec."Quantity FND")
                {
                    Caption = 'Quantity';
                }
                field(tagNoFND; Rec."Tag No FND")
                {
                    Caption = 'Tag No.';
                }
                field(cmgCodeFND; Rec."CMG code FND")
                {
                    Caption = 'CMG Code';
                }
                field(hSLevyTaxPostingGroupFND; Rec."H&S Levy Tax Posting Group FND")
                {
                    Caption = 'H&S Levy Tax Posting Group';
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
                field(faTemplateAPS; Rec."FA Template APS")
                {
                    Caption = 'FA Template Code';
                }
                field(financialContractNo; Rec."Cust. Contract No. 114FDW")
                {
                    Caption = 'Financial Contract No.';
                }
                field(serviceItemNo; Rec."Service Item No. APS")
                {
                    Caption = 'Service Item No.';
                }
            }
        }
    }
}
