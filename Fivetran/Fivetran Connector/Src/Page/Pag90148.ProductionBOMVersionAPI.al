page 90148 "Production BOM Version API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Production BOM Version';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Production BOM Version';
    EntitySetCaption = 'Production BOM Version';
    EntityName = 'productionBOMVersion';
    EntitySetName = 'productionBOMVersion';
    SourceTable = "Production BOM Version";
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
                field(productionBOMNo; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.';
                }
                field(versionCode; Rec."Version Code")
                {
                    Caption = 'Version Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(active; Rec."Active FND")
                {
                    Caption = 'Active';
                }
                field(certifyStatus; Rec."Certify Status FND")
                {
                    Caption = 'Certify Status';
                }
                field(newActive; Rec."New Active FND")
                {
                    Caption = 'New Active';
                }
                field(closeStatus; Rec."Close Status FND")
                {
                    Caption = 'Close Status';
                }
            }
        }
    }
}
