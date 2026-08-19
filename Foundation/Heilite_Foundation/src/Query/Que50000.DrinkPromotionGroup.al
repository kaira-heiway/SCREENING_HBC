namespace HEILITE_MTC_.HEILITE_MTC_;

query 50000 "Drink Promotion Groups Query"
{
    // BC Upgrade SHUKLP03 >> Restructured code according to new ways of working.

    Caption = 'Drink Promotion Groups Query';
    QueryType = Normal;

    elements
    {
        //HEI.01 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # Object created

        dataitem(Group105FDW; Group105FDW)
        {
            column(Type; Type)
            {
                Caption = 'Source Type';
            }
            column(Code; Code)
            {
                Caption = 'Code';
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
