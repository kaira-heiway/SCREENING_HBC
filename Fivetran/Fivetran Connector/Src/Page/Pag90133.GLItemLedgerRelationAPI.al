page 90133 "G/L Item Ledger Relation API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    ApplicationArea = All;
    Caption = 'G/L - Item Ledger Relation';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'G/L - Item Ledger Relation';
    EntitySetCaption = 'G/L - Item Ledger Relation';
    EntityName = 'GLItemLedgerRelation';
    EntitySetName = 'GLItemLedgerRelation';
    SourceTable = "G/L - Item Ledger Relation";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(glEntryNo; Rec."G/L Entry No.")
                {
                    Caption = 'G/L Entry No.';
                }
                field(valueEntryNo; Rec."Value Entry No.")
                {
                    Caption = 'Value Entry No.';
                }
                field(glRegisterNo; Rec."G/L Register No.")
                {
                    Caption = 'G/L Register No.';
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