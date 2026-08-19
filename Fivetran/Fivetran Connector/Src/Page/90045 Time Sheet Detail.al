page 90045 "Time Sheet Detail"
{
    APIGroup = 'standardEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'timeSheetDetail';
    DelayedInsert = true;
    EntityName = 'timeSheetDetail';
    EntitySetName = 'timeSheetDetails';
    PageType = API;
    SourceTable = "Time Sheet Detail";

    ODataKeyFields = SystemId;
    Editable = false;
    DataAccessIntent = ReadOnly;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(assemblyOrderLineNo; Rec."Assembly Order Line No.")
                {
                    Caption = 'Assembly Order Line No.';
                }
                field(assemblyOrderNo; Rec."Assembly Order No.")
                {
                    Caption = 'Assembly Order No.';
                }
                field(causeOfAbsenceCode; Rec."Cause of Absence Code")
                {
                    Caption = 'Cause of Absence Code';
                }
                field("date"; Rec."Date")
                {
                    Caption = 'Date';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(jobId; Rec."Job Id")
                {
                    Caption = 'Job Id';
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'Job Task No.';
                }
                field(lastModifiedDateTime; Rec."Last Modified DateTime")
                {
                    Caption = 'Last Modified DateTime';
                }
                field(posted; Rec.Posted)
                {
                    Caption = 'Posted';
                }
                field(postedQuantity; Rec."Posted Quantity")
                {
                    Caption = 'Posted Quantity';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(resourceNo; Rec."Resource No.")
                {
                    Caption = 'Resource No.';
                }
                field(serviceOrderLineNo; Rec."Service Order Line No.")
                {
                    Caption = 'Service Order Line No.';
                }
                field(serviceOrderNo; Rec."Service Order No.")
                {
                    Caption = 'Service Order No.';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
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
                field(timeSheetLineNo; Rec."Time Sheet Line No.")
                {
                    Caption = 'Time Sheet Line No.';
                }
                field(timeSheetNo; Rec."Time Sheet No.")
                {
                    Caption = 'Time Sheet No.';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
            }
        }
    }
}
