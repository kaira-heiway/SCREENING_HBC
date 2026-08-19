table 50376 "SEM Cust Inc/Exc FND"
{
    // Heilite Navision Old Id - 50216
    // version HEI.01

    // HEI.01 CHG2115040 HB2342 IBM GAVANM01 16.08.2021 #SEM Customer Integration
    //   # New Table created for SEM Interface

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interfaces to Foundation Layer.
    // # Table name changed from "SEM Customer Included/Excluded" to "SEM Customer Included
    // BC UPGRADE PATELS08 <<

    DataCaptionFields = "Code";

    fields
    {
        field(5; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate();
            begin
                if Customer.GET(Code) then
                    VALIDATE(Description, Customer.Name);
            end;
        }
        field(10; Description; Text[50])
        {
            Editable = false;
        }
        field(15; Included; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                Excluded := not Included;
            end;
        }
        field(20; Excluded; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;

            trigger OnValidate();
            begin
                Included := not Excluded
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        Customer: Record Customer;
        Vendor: Record Vendor;
}

