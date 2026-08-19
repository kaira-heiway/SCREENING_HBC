table 50269 "DDE Customer Included FND"
{
    // version HEI.01

    // HEI.01 CHG2249480 IBM COSTES04 11.06.2024 Burundi-shipment to DDE – sending all distributors related shipments to DDE
    //   # new object created

    //SHIKHD02>>
    //Updated the FlowField "Customer Name" length from Text[50] to Text[100] to match with the source field definition
    //SHIKHD02<<


    fields
    {
        field(1; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }

        //SHIKHD02>>
        //Updated the FlowField "Customer Name" length from Text[50] to Text[100] to match with the source field definition
        field(10; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name where("No." = FIELD("Customer No.")));
            Caption = 'Customer Name';
            Editable = false;
            FieldClass = FlowField;
        }
        //SHIKHD02<<
        field(11; Included; Boolean)
        {
            Caption = 'Included';
        }
    }

    keys
    {
        key(Key1; "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }
}

