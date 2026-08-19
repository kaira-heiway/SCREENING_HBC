table 50118 "Bank Conn.- Replace Char. FND"
{
    //version HEI.01
    //HEI.01 CHG2119688 IBM POENAB02 19.10.2022 HB2428 Panama CITI - bank connectivity payment file
    // # Object created
    //BC UPGRADE ATHUKS01>>
    //1.Adde AutoIncrement property to Entry No. field.
    //BC UPGRADE ATHUKS01<<

    Caption = 'Bank Conn.- Replace Char.';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Character to be Replaced"; Text[30])
        {
            Caption = 'Character to be Replaced';
        }
        field(3; "New Character"; Text[30])
        {
            Caption = 'New Character';
        }
        field(4; "Delete Character"; Boolean)
        {
            Caption = 'Delete Character';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
