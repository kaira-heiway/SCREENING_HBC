page 90150 "GL COGS Allocation Setup API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'customEndpoints';
    ApplicationArea = All;
    Caption = 'G/L COGS Allocation Setup';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'G/L COGS Allocation Setup';
    EntitySetCaption = 'G/L COGS Allocation Setup';
    EntityName = 'glCOGSAllocationSetup';
    EntitySetName = 'glCOGSAllocationSetup';
    SourceTable = "G/L COGS Allocation Setup FND";
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
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(gLAccountRangeForSCOAL3; Rec."G/L Account Range for SCOA L3")
                {
                    Caption = 'G/L Account Range for SCOA L3';
                }
                field(cccCodeDimFilter; Rec."Ccc Code Dim. Filter")
                {
                    Caption = 'Ccc Code Dim. Filter';
                }
                field(cogsAllocation; Rec."COGS Allocation")
                {
                    Caption = 'COGS Allocation';
                }
                field(periodCost; Rec."Period Cost")
                {
                    Caption = 'Period Cost';
                }
            }
        }
    }
}
