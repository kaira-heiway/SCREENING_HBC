table 50420 "NAV BC Field Mapping FND"
{
    Caption = 'NAV to BC Field Mapping';
    DataClassification = SystemMetadata;
    DataPerCompany = false;

    Description = 'Stores the mapping between Microsoft Dynamics NAV fields and Business Central fields for upgrade and migration purposes.';

    fields
    {
        field(1; "NAV Table ID"; Integer)
        {
            Caption = 'NAV Table ID';
            Description = 'Specifies the source Microsoft Dynamics NAV table ID.';
        }

        field(2; "NAV Table Name"; Text[100])
        {
            Caption = 'NAV Table Name';
            Description = 'Specifies the name of the source NAV table.';
        }

        field(3; "NAV Field ID"; Integer)
        {
            Caption = 'NAV Field ID';
            Description = 'Specifies the source NAV field ID.';
        }

        field(4; "NAV Field Name"; Text[100])
        {
            Caption = 'NAV Field Name';
            Description = 'Specifies the name of the source NAV field.';
        }

        field(5; "BC Table ID"; Integer)
        {
            Caption = 'BC Table ID';
            Description = 'Specifies the destination Business Central table ID.';
        }

        field(6; "BC Table Name"; Text[100])
        {
            Caption = 'BC Table Name';
            Description = 'Specifies the name of the destination Business Central table.';
        }

        field(7; "BC Field ID"; Integer)
        {
            Caption = 'BC Field ID';
            Description = 'Specifies the ID of the mapped Business Central field.';
        }

        field(8; "BC Field Name"; Text[100])
        {
            Caption = 'BC Field Name';
            Description = 'Specifies the name of the mapped Business Central field.';
        }

        field(9; "Previous BC Table ID"; Integer)
        {
            Caption = 'Previous BC Table ID';
            Description = 'Specifies the previously assigned Business Central table ID.';
        }

        field(10; "Previous BC Field ID"; Integer)
        {
            Caption = 'Previous BC Field ID';
        }
    }

    keys
    {
        key(NAVMapping; "NAV Table ID", "NAV Field ID")
        {
            Clustered = true;
        }

        key(BCMapping; "BC Table ID", "BC Field ID")
        {
        }
    }


    trigger OnModify()
    begin
        if ("BC Table ID" <> xRec."BC Table ID") then
            "Previous BC Table ID" := xRec."BC Table ID";
  
        if ("BC Field ID" <> xRec."BC Field ID") then 
            "Previous BC Field ID" := xRec."BC Field ID";
    end;
}