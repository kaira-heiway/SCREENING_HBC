page 90144 "Return Shipment Header API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Return Shipment Header';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Return Shipment Header';
    EntitySetCaption = 'Return Shipment Header';
    EntityName = 'returnShipmentHeader';
    EntitySetName = 'returnShipmentHeader';
    SourceTable = "Return Shipment Header";
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
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                    Caption = 'Currency Factor';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(returnOrderNo; Rec."Return Order No.")
                {
                    Caption = 'Return Order No.';
                }
                field(sourceCode; Rec."Source Code")
                {
                    Caption = 'Source Code';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
            }
        }
    }
}
