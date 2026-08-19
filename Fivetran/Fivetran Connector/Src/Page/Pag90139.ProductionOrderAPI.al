page 90139 "Production Order API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Production Order';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Production Order';
    EntitySetCaption = 'Production Order';
    EntityName = 'ProductionOrder';
    EntitySetName = 'ProductionOrder';
    SourceTable = "Production Order";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(assignedUserID; Rec."Assigned User ID")
                {
                    Caption = 'Assigned User ID';
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(costAmount; Rec."Cost Amount")
                {
                    Caption = 'Cost Amount';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                }
                field(creationDate; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }
                field(endingDate; Rec."Ending Date")
                {
                    Caption = 'Ending Date';
                }
                field(endingDateTime; Rec."Ending Date-Time")
                {
                    Caption = 'Ending Date-Time';
                }
                field(endingTime; Rec."Ending Time")
                {
                    Caption = 'Ending Time';
                }
                field(finishedDate; Rec."Finished Date")
                {
                    Caption = 'Finished Date';
                }
                field(firmPlannedOrderNo; Rec."Firm Planned Order No.")
                {
                    Caption = 'Firm Planned Order No.';
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(gyleNo; Rec."Gyle No. FND")
                {
                    Caption = 'Gyle No.';
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                    Caption = 'Inventory Posting Group';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(lowLevelCode; Rec."Low-Level Code")
                {
                    Caption = 'Low-Level Code';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(parkedForLogoPak; Rec."Parked for LogoPak INT")
                {
                    Caption = 'Parked for LogoPak';
                }
                field(parkedFromLogoPak; Rec."Parked from LogoPak INT")
                {
                    Caption = 'Parked from LogoPak';
                }
                field(plannedOrderNo; Rec."Planned Order No.")
                {
                    Caption = 'Planned Order No.';
                }
                field(postedFromLogoPak; Rec."Posted from LogoPak INT")
                {
                    Caption = 'Posted from LogoPak';
                }
                field(prodOrderInterface; Rec."Prod. Order Interface INT")
                {
                    Caption = 'Prod. Order Interface';
                }
                field(prodOrderOutputInterf; Rec."Prod. Order Output Interf INT")
                {
                    Caption = 'Prod. Order Output Interface';
                }
                field(prodBOMNo; Rec."Prod. BOM No. 112FDW")
                {
                    Caption = 'Production BOM No.';
                }
                field(prodBOMVersionCode; Rec."Prod. BOM Vrsn Code 112FDW")
                {
                    Caption = 'Prod. BOM Version Code';
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure FND")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(replanRefNo; Rec."Replan Ref. No.")
                {
                    Caption = 'Replan Ref. No.';
                }
                field(replanRefStatus; Rec."Replan Ref. Status")
                {
                    Caption = 'Replan Ref. Status';
                }
                field(responsibilityCenter; Rec."Responsibility Center APS")
                {
                    Caption = 'Responsibility Center';
                }
                field(roleCentreTileCode; Rec."Role Centre Tile Code FND")
                {
                    Caption = 'Role Centre Tile Code';
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }
                field(routingVersionCode; Rec."Routing Vrsn Code 112FDW")
                {
                    Caption = 'Routing Version Code';
                }
                field(searchDescription; Rec."Search Description")
                {
                    Caption = 'Search Description';
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(simulatedOrderNo; Rec."Simulated Order No.")
                {
                    Caption = 'Simulated Order No.';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                }
                field(startingDateTime; Rec."Starting Date-Time")
                {
                    Caption = 'Starting Date-Time';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code FND")
                {
                    Caption = 'Unit of Measure Code';
                }
                field(zoneCode; Rec."Zone Code FND")
                {
                    Caption = 'Zone Code';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
            }
        }
    }
}