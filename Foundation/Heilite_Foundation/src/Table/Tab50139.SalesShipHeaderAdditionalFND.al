table 50139 "Sales Ship. Header Add FND"
{
    // version HEI.01

    // HEI.01 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # New Table created to extend Standard Table 120 - Purch. Rcpt. Header

    Caption = 'Sales Ship. Header Additional';

    fields
    {
        field(3; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        FRA = 'N°';
            Editable = false;
        }
        field(50000; "PQ Approver"; Code[50])
        {
            Caption = 'PQ Approver';
            TableRelation = "User Setup";
            //This property is currently not supported
            //TestTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

