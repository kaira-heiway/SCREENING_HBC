table 58095 "Currency Symbol Mapping INT"
{
    Caption = 'Currency Symbol Mapping';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Symbol"; Text[10])
        {
            Caption = 'Symbol';
        }
        field(3; "HTML Code"; Text[20])
        {
            Caption = 'HTML Code';
        }
        field(4; "Description"; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "Entry No") { Clustered = true; }
    }
}