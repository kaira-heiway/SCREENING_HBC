table 50181 "Aging Setup FND"
{
    // HEI.01 FDD-HT1147 IBM SURYAS01 06-may-2020
    //  #Created New table "50181"
    // HEI.02 DEFECT#5626 IBM BULIMC01 24/08/2020 #datatype changed to "Date" for Starting date and Ending Date fields


    fields
    {
        field(1; "No."; Integer)
        {

            trigger OnValidate();
            begin
                //HEI.01
                //HEI.02<< commented
                /*IF "No." > 70000 THEN
                  ERROR('More then 7 record is not accepted for Aging G/L Report');*/
                if "No." > 80000 then
                    ERROR('More then 8 records is not accepted for Aging G/L Report');
                //HEI.02>>
                //HEI.01

            end;
        }
        field(2; "Starting Date"; DateFormula)
        {
        }
        field(3; "Ending Date"; DateFormula)
        {
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

