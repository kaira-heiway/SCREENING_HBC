page 90001 "Page metadata"
{
    APIPublisher = 'fivetran';
    DataAccessIntent = ReadOnly;
    APIGroup = 'metadata';
    APIVersion = 'v1.0';
    Editable = false;
    EntityName = 'pageMetadata';
    EntitySetName = 'pageMetadata';
    DelayedInsert = true;
    PageType = API;
    SourceTable = "Page Metadata";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(apiGroup; Rec.APIGroup)
                {
                    Caption = 'APIGroup';
                }
                field(apiPublisher; Rec.APIPublisher)
                {
                    Caption = 'APIPublisher';
                }
                field(apiVersion; Rec.APIVersion)
                {
                    Caption = 'APIVersion';
                }
                field(autoSplitKey; Rec.AutoSplitKey)
                {
                    Caption = 'AutoSplitKey';
                }
                field(caption; Rec.Caption)
                {
                    Caption = 'Caption';
                }
                field(cardPageID; Rec.CardPageID)
                {
                    Caption = 'CardPageID';
                }
                field(changeTrackingAllowed; Rec.ChangeTrackingAllowed)
                {
                    Caption = 'ChangeTrackingAllowed';
                }
                field(dataCaptionExpr; Rec."DataCaptionExpr.")
                {
                    Caption = 'DataCaptionExpr.';
                }
                field(dataCaptionFields; Rec.DataCaptionFields)
                {
                    Caption = 'DataCaptionFields';
                }
                field(delayedInsert; Rec.DelayedInsert)
                {
                    Caption = 'DelayedInsert';
                }
                field(deleteAllowed; Rec.DeleteAllowed)
                {
                    Caption = 'DeleteAllowed';
                }
                field(editable; Rec.Editable)
                {
                    Caption = 'Editable';
                }
                field(entityName; Rec.EntityName)
                {
                    Caption = 'EntityName';
                }
                field(entitySetName; Rec.EntitySetName)
                {
                    Caption = 'EntitySetName';
                }
                field(id; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(insertAllowed; Rec.InsertAllowed)
                {
                    Caption = 'InsertAllowed';
                }
                field(linksAllowed; Rec.LinksAllowed)
                {
                    Caption = 'LinksAllowed';
                }
                field(modifyAllowed; Rec.ModifyAllowed)
                {
                    Caption = 'ModifyAllowed';
                }
                field(multipleNewLines; Rec.MultipleNewLines)
                {
                    Caption = 'MultipleNewLines';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(pageType; Rec.PageType)
                {
                    Caption = 'PageType';
                }
                field(populateAllFields; Rec.PopulateAllFields)
                {
                    Caption = 'PopulateAllFields';
                }
                field(refreshOnActivate; Rec.RefreshOnActivate)
                {
                    Caption = 'RefreshOnActivate';
                }
                field(saveValues; Rec.SaveValues)
                {
                    Caption = 'SaveValues';
                }
                field(showFilter; Rec.ShowFilter)
                {
                    Caption = 'ShowFilter';
                }
                field(sourceTable; Rec.SourceTable)
                {
                    Caption = 'SourceTable';
                }
                field(sourceTableTemporary; Rec.SourceTableTemporary)
                {
                    Caption = 'SourceTableTemporary';
                }
                field(sourceTableView; Rec.SourceTableView)
                {
                    Caption = 'SourceTableView';
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
