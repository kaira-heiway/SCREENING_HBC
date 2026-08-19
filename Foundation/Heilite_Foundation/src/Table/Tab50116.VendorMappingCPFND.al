table 50116 "Vendor Mapping CP FND"
{
    // version HEI.01

    // HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 18.10.2018 # Counterpoint Interface
    //   # New Table created to map Vendors from CP and HL

    // BC Upgrade MISHRS14 >>
    // #Changed length from 50 to 100 due to warning in field 3 - "Heilite Vendor Description"
    // BC upgrade MISHRS14 <<

    Caption = 'Vendor Mapping CP';

    fields
    {
        field(1; "CP Vendor No."; Code[20])
        {
            Description = 'Vendor in CP';
        }
        field(2; "Heilite Vendor No."; Code[20])
        {
            TableRelation = Vendor;
        }
        field(3; "Heilite Vendor Description"; Text[100]) // BC Upgrade MISHRS14 >> #Changed length from 50 to 100 due to warning
        {
            CalcFormula = Lookup(Vendor.Name where("No." = FIELD("Heilite Vendor No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "CP Vendor No.", "Heilite Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }
}

