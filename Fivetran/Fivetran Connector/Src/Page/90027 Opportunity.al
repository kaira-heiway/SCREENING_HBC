page 90027 "Opportunity"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Opportunity';
    EntitySetCaption = 'Opportunities';
    ODataKeyFields = SystemId;
    EntityName = 'opportunity';
    EntitySetName = 'opportunities';
    SourceTable = Opportunity;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(activateFirstStage; Rec."Activate First Stage")
                {
                    Caption = 'Activate First Stage';
                }
                field(calcdCurrentValueLCY; Rec."Calcd. Current Value (LCY)")
                {
                    Caption = 'Calcd. Current Value (LCY)';
                }
                field(campaignDescription; Rec."Campaign Description")
                {
                    Caption = 'Campaign Description';
                }
                field(campaignNo; Rec."Campaign No.")
                {
                    Caption = 'Campaign No.';
                }
                field(chancesOfSuccess; Rec."Chances of Success %")
                {
                    Caption = 'Chances of Success %';
                }
                field(closed; Rec.Closed)
                {
                    Caption = 'Closed';
                }
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(completed; Rec."Completed %")
                {
                    Caption = 'Completed %';
                }
                field(contactCompanyName; Rec."Contact Company Name")
                {
                    Caption = 'Contact Company Name';
                }
                field(contactCompanyNo; Rec."Contact Company No.")
                {
                    Caption = 'Contact Company No.';
                }
                field(contactName; Rec."Contact Name")
                {
                    Caption = 'Contact Name';
                }
                field(contactNo; Rec."Contact No.")
                {
                    Caption = 'Contact No.';
                }
                field(coupledToDataverse; Rec."Coupled to Dataverse")
                {
                    Caption = 'Coupled to Dynamics 365 Sales';
                }
                field(creationDate; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                }
                field(currentSalesCycleStage; Rec."Current Sales Cycle Stage")
                {
                    Caption = 'Current Sales Cycle Stage';
                }
                field(dateClosed; Rec."Date Closed")
                {
                    Caption = 'Date Closed';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(estimatedClosingDate; Rec."Estimated Closing Date")
                {
                    Caption = 'Estimated Closing Date';
                }
                field(estimatedValueLCY; Rec."Estimated Value (LCY)")
                {
                    Caption = 'Estimated Value (LCY)';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(noOfInteractions; Rec."No. of Interactions")
                {
                    Caption = 'No. of Interactions';
                }
                field(priority; Rec.Priority)
                {
                    Caption = 'Priority';
                }
                field(probability; Rec."Probability %")
                {
                    Caption = 'Probability %';
                }
                field(salesCycleCode; Rec."Sales Cycle Code")
                {
                    Caption = 'Sales Cycle Code';
                }
                field(salesDocumentNo; Rec."Sales Document No.")
                {
                    Caption = 'Sales Document No.';
                }
                field(salesDocumentType; Rec."Sales Document Type")
                {
                    Caption = 'Sales Document Type';
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                }
                field(salespersonName; Rec."Salesperson Name")
                {
                    Caption = 'Salesperson Name';
                }
                field(segmentDescription; Rec."Segment Description")
                {
                    Caption = 'Segment Description';
                }
                field(segmentNo; Rec."Segment No.")
                {
                    Caption = 'Segment No.';
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
                field(wizardCampaignDescription; Rec."Wizard Campaign Description")
                {
                    Caption = 'Wizard Campaign Description';
                }
                field(wizardChancesOfSuccess; Rec."Wizard Chances of Success %")
                {
                    Caption = 'Wizard Chances of Success %';
                }
                field(wizardContactName; Rec."Wizard Contact Name")
                {
                    Caption = 'Wizard Contact Name';
                }
                field(wizardEstimatedClosingDate; Rec."Wizard Estimated Closing Date")
                {
                    Caption = 'Wizard Estimated Closing Date';
                }
                field(wizardEstimatedValueLCY; Rec."Wizard Estimated Value (LCY)")
                {
                    Caption = 'Wizard Estimated Value (LCY)';
                }
                field(wizardStep; Rec."Wizard Step")
                {
                    Caption = 'Wizard Step';
                }
            }
        }
    }
}
