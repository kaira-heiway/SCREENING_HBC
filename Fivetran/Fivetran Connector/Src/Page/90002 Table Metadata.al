page 90002 "Table Metadata"
{
    APIGroup = 'metadata';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'tableMetadata';
    DelayedInsert = true;
    EntityName = 'tableMetadata';
    EntitySetName = 'tableMetadata';
    PageType = API;
    SourceTable = "Table Metadata";
    Editable = false;
    DataAccessIntent = ReadOnly;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(caption; Rec.Caption)
                {
                    Caption = 'Caption';
                }
                field(compressionType; Rec.CompressionType)
                {
                    Caption = 'CompressionType';
                }
                field(dataCaptionFields; Rec.DataCaptionFields)
                {
                    Caption = 'DataCaptionFields';
                }
                field("dataClassification"; Rec."DataClassification")
                {
                    Caption = 'DataClassification';
                }
                field(dataIsExternal; Rec.DataIsExternal)
                {
                    Caption = 'DataIsExternal';
                }
                field(dataPerCompany; Rec.DataPerCompany)
                {
                    Caption = 'DataPerCompany';
                }
                field(drillDownPageId; Rec.DrillDownPageId)
                {
                    Caption = 'DrillDownPageId';
                }
                field(externalName; Rec.ExternalName)
                {
                    Caption = 'ExternalName';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(linkedObject; Rec.LinkedObject)
                {
                    Caption = 'LinkedObject';
                }
                field(lookupPageID; Rec.LookupPageID)
                {
                    Caption = 'LookupPageID';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(obsoleteReason; Rec.ObsoleteReason)
                {
                    Caption = 'ObsoleteReason';
                }
                field(obsoleteState; Rec.ObsoleteState)
                {
                    Caption = 'ObsoleteState';
                }
                field(pasteIsValid; Rec.PasteIsValid)
                {
                    Caption = 'PasteIsValid';
                }
                field(replicateData; Rec.ReplicateData)
                {
                    Caption = 'ReplicateData';
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
                field(tableType; Rec.TableType)
                {
                    Caption = 'TableType';
                }
            }
        }
    }
}
