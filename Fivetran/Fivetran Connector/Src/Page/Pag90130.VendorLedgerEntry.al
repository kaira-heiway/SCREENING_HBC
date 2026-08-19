page 90130 "Vendor Ledger Entry API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'Vendor Ledger Entry';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Vendor Ledger Entry';
    EntitySetCaption = 'Vendor Ledger Entry';
    EntityName = 'vendorLedgerEntry';
    EntitySetName = 'vendorLedgerEntry';
    SourceTable = "Vendor Ledger Entry";
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
                field(amountToApply; Rec."Amount to Apply")
                {
                    Caption = 'Amount to Apply';
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(closedAtDate; Rec."Closed at Date")
                {
                    Caption = 'Closed at Date';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(open; Rec.Open)
                {
                    Caption = 'Open';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field(vendorPostingGroup; Rec."Vendor Posting Group")
                {
                    Caption = 'Vendor Posting Group';
                }
            }
        }
    }
}
