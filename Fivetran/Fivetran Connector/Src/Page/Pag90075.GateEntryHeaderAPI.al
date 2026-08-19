namespace fivetran.fivetran;

page 90075 "Gate Entry Header API"
{
    APIGroup = 'customEndpoints';
    APIPublisher = 'fivetran';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'Gate Entry Header API';
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityName = 'gateEntryHeader';
    EntitySetName = 'gateEntryHeader';
    PageType = API;
    SourceTable = "Gate Entry Header FND";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(gateEntryDocumentNo; Rec."Gate Entry Document No.")
                {
                    Caption = 'Gate Entry Document No.';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(gateKeeperID; Rec."Gate Keeper ID")
                {
                    Caption = 'Gate Keeper ID';
                }
                field(vehicleNo; Rec."Vehicle No.")
                {
                    Caption = 'Vehicle No.';
                }
                field(driverCode; Rec."Driver Code")
                {
                    Caption = 'Driver Code';
                }
                field(gateEntryType; Rec."Gate Entry Type")
                {
                    Caption = 'Gate Entry Type';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(dateIn; Rec."Date In")
                {
                    Caption = 'Date In';
                }
                field(timeIn; Rec."Time In")
                {
                    Caption = 'Time In';
                }
                field(dateOut; Rec."Date Out")
                {
                    Caption = 'Date Out';
                }
                field(timeOut; Rec."Time Out")
                {
                    Caption = 'Time Out';
                }
                field(totalWeightOnArrival; Rec."Total Weight on Arrival")
                {
                    Caption = 'Total Weight on Arrival';
                }
                field(totalWeightOnDeparture; Rec."Total Weight on Departure")
                {
                    Caption = 'Total Weight on Departure';
                }
                field(postedWeightInbound; Rec."Posted Weight Inbound")
                {
                    Caption = 'Posted Weight Inbound';
                }
                field(postedWeightOutbound; Rec."Posted Weight Outbound")
                {
                    Caption = 'Posted Weight Outbound';
                }
                field(weightDifference; Rec."Weight Difference")
                {
                    Caption = 'Weight Difference';
                }
                field(linkedGateEntryNo; Rec."Linked Gate Entry No.")
                {
                    Caption = 'Linked Gate Entry No.';
                }
                field(noPrinted; Rec."No. Printed")
                {
                    Caption = 'No. Printed';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(registered; Rec.Registered)
                {
                    Caption = 'Registered';
                }
                field(assigned; Rec.Assigned)
                {
                    Caption = 'Assigned';
                }
                field(referenceDocument; Rec."Reference Document")
                {
                    Caption = 'Reference Document';
                }
                field(referenceNo; Rec."Reference No.")
                {
                    Caption = 'Reference No.';
                }
                field(automaticRegistration; Rec."Automatic Registration")
                {
                    Caption = 'Automatic Registration';
                }
                field(groupedControl; Rec."Grouped Control")
                {
                    Caption = 'Grouped Control';
                }
                field(zoneCode; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                }
                field(remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
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
