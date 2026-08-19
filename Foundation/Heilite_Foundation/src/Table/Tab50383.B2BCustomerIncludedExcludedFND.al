table 50383 "B2B Cust Inc/Exc FND"
{
    // Heilite Navision Old Id - 50206
    // version HEI.01

    // HEI.01 FDD-HB1281 - CHG2056937 IBM NASTAA02 12.04.2021 # B2B Pricing Interface
    //   # New Table created for B2B Pricing Interface
    // HEI.02 INC3510045 - CHG2112803 IBM NASTAA02 02.06.2021 # HeiLite to B2B pricing the file generated is very big and can't be sent via Boomi or Solace
    //   # Deleted Field 20 - Excluded
    //   # Commented code on 'Included' Field

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "B2B Customer Included/Excluded" to "B2B Cust Inc/Exc FND"
    // BC Upgrade PATELP08<<

    Caption = 'B2B Customer Included/Excluded';
    DataCaptionFields = "Code", Description;

    fields
    {
        field(5; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Customer;
            ValidateTableRelation = false;

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
                //Excluded := NOT Included; //HEI.02
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
        Customer: Record Customer;
}

