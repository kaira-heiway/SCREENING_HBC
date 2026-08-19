tableextension 50264 SalesdeliveryDateExtFND extends "Sales delivery Date FND"
{
    // version HEI.01

    // HEI.01 FDD-HNK LOGGAP002 03/12/2018 IBM.CHAUHB01 Peperri Export
    //   #New Table to record sales exported data

    // BC Upgrade KUMARS145 TableExt Created.
    // BC Upgrade KUMARS145 this direction was in table "Sales delivery Date FND" now moved here in Extension


    fields
    {
        field(50000; "Direction FND"; Option)
        {
            caption = 'Direction';
            OptionCaption = '" ,Outbound,Inbound"';
            OptionMembers = " ",Outbound,Inbound;
        }
    }

}

