table 58018 "EBM Interface Setup INT"
{
    // Heilite Navision Old Id - 50069
    // version HEI.01

    // HEI.01 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New table for EBM interface

    Caption = 'EBM Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Sales Posting Interface"; Code[20])
        {
            Caption = 'Sales Posting Interface';
            TableRelation = "Interface Setup INT";
        }
        field(3; "Sales Confirmation Interface"; Code[20])
        {
            Caption = 'Sales Confirmation Interface';
            TableRelation = "Interface Setup INT";
        }
        field(4; "Sales Confirmation Response"; Code[20])
        {
            Caption = 'Sales Confirmation Response';
            TableRelation = "Interface Setup INT";
        }
        field(5; "Status Update Interface"; Code[20])
        {
            Caption = 'Status Update Interface';
            TableRelation = "Interface Setup INT";
        }
        field(10; "No. of Confirmation Attempts"; Integer)
        {
            Caption = 'No. of Confirmation Attempts';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

