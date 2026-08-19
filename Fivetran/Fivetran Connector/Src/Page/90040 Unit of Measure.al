page 90040 "Unit of Measure"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Unit of Measure';
    EntitySetCaption = 'Units of Measure';
    ODataKeyFields = SystemId;
    EntityName = 'unitOfMeasure';
    EntitySetName = 'unitsOfMeasure';
    SourceTable = "Unit of Measure";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(coupledToDataverse; Rec."Coupled to Dataverse")
                {
                    Caption = 'Coupled to Dynamics 365 Sales';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(internationalStandardCode; Rec."International Standard Code")
                {
                    Caption = 'International Standard Code';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                // field(satCustomsUnit; Rec."SAT Customs Unit")
                // {
                //     Caption = 'SAT Customs Unit';
                // }
                // field(satUofMClassification; Rec."SAT UofM Classification")
                // {
                //     Caption = 'SAT UofM Classification';
                // }
                field(symbol; Rec.Symbol)
                {
                    Caption = 'Symbol';
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
