namespace fivetran.fivetran;

using Microsoft.Inventory.BOM;

page 90066 "BOM Component"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'BOM Component API';
    DelayedInsert = true;
    EntityName = 'bomComponent';
    EntitySetName = 'bomComponents';
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    PageType = API;
    SourceTable = "BOM Component";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(parentItemNo; Rec."Parent Item No.")
                {
                    Caption = 'Parent Item No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(quantityPer; Rec."Quantity per")
                {
                    Caption = 'Quantity per';
                }
                field(position; Rec.Position)
                {
                    Caption = 'Position';
                }
                field(position2; Rec."Position 2")
                {
                    Caption = 'Position 2';
                }
                field(position3; Rec."Position 3")
                {
                    Caption = 'Position 3';
                }
                field(machineNo; Rec."Machine No.")
                {
                    Caption = 'Machine No.';
                }
                field(leadTimeOffset; Rec."Lead-Time Offset")
                {
                    Caption = 'Lead-Time Offset';
                }
                field(resourceUsageType; Rec."Resource Usage Type")
                {
                    Caption = 'Resource Usage Type';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(installedInLineNo; Rec."Installed in Line No.")
                {
                    Caption = 'Installed in Line No.';
                }
                field(installedInItemNo; Rec."Installed in Item No.")
                {
                    Caption = 'Installed in Item No.';
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
