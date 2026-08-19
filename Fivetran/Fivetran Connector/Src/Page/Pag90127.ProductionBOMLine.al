namespace fivetran.fivetran;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Manufacturing.ProductionBOM;

page 90127 "Production BOM Line API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Production BOM Line';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Production BOM Line';
    EntitySetCaption = 'Production BOM Line';
    EntityName = 'productionBOMLine';
    EntitySetName = 'productionBOMLine';
    SourceTable = "Production BOM Line";
    ODataKeyFields = SystemID;

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
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(quantityPer; Rec."Quantity per")
                {
                    Caption = 'Quantity per';
                }
                field(scrap; Rec."Scrap %")
                {
                    Caption = 'Scrap %';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(versionCode; Rec."Version Code")
                {
                    Caption = 'Version Code';
                }
                field(productionJnlFlushing; Rec."Production jnl. flushing FND")
                {
                    Caption = 'Production Jnl. Flushing';
                }
            }
        }
    }
}
