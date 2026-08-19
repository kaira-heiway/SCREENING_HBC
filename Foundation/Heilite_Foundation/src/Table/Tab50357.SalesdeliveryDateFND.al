table 50357 "Sales delivery Date FND"
{
    // version HEI.01

    // HEI.01 FDD-HNK LOGGAP002 03/12/2018 IBM.CHAUHB01 Peperri Export
    //   #New Table to record sales exported data

    // BC Upgrade KUMARS145 Nav ID Table 50031 "Sales delivery Date FND"

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Sales Date"; Date)
        {
        }
        field(3; "Sales Shipment Date"; Date)
        {
        }
        field(4; "Execution DateTime"; DateTime)
        {
        }
        // field(55; Direction; Option) // BC Upgrade KUMARS145 Created in Interface Extension (tableextension 58035 SalesdeliveryDateExt extends "Sales delivery Date").
        // {
        //     OptionCaption = '" ,Outbound,Inbound"';
        //     OptionMembers = " ",Outbound,Inbound;
        // }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

