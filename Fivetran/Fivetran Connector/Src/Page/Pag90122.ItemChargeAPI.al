namespace fivetran.fivetran;

using Microsoft.Inventory.Item;

page 90122 "Item Charge API"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Item Charge API';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityName = 'itemCharges';
    EntitySetName = 'itemCharges';
    PageType = API;
    SourceTable = "Item Charge";

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
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(searchDescription; Rec."Search Description")
                {
                    Caption = 'Search Description';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(whtProductPostingGroupFND; Rec."WHT Product Posting Group FND")
                {
                    Caption = 'WHT Product Posting Group';
                }
                field(fpiFND; Rec."FPI FND")
                {
                    Caption = 'FPI FND';
                }
                field(exciseDutiesFND; Rec."Excise Duties FND")
                {
                    Caption = 'Excise Duties FND';
                }
                field(consumptionTaxFND; Rec."Consumption tax FND")
                {
                    Caption = 'Consumption tax FND';
                }
                field(transportShippingCostFND; Rec."Transport/Shipping Cost FND")
                {
                    Caption = 'Transport/Shipping Cost FND';
                }
                field(allowVATCalcOnFreeFND; Rec."Allow VAT Calc. on Free FND")
                {
                    Caption = 'Allow VAT Calculation on Free';
                }
                field(hideItemChrgOnPrintoutFND; Rec."Hide Item chrg on printout FND")
                {
                    Caption = 'Hide Item chrg on printout';
                }
                field(showFreeAmtOnPrintoutFND; Rec."Show free amt on printout FND")
                {
                    Caption = 'Show free amt on printout';
                }
                field(asdiFND; Rec."ASDI FND")
                {
                    Caption = 'ASDI';
                }
                field(tsbFND; Rec."TSB FND")
                {
                    Caption = 'TSB';
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
            }
        }
    }
}
