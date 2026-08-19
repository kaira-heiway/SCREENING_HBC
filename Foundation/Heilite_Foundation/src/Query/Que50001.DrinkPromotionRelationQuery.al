namespace HEILITE_MTC_.HEILITE_MTC_;

query 50001 "Drink Promotion Relation Query"
{
    // BC Upgrade SHUKLP03 >> Restructured code according to new ways of working.

    Caption = 'Drink Promotion Relation Query';
    QueryType = Normal;


    elements
    {
        dataitem(GroupRelation; GroupRelation105FDW)
        {
            column(Source_Type; Type)
            {
                Caption = 'Source Type';
            }
            column(Source_No; "No.")
            {
                Caption = 'Source No';
            }
            column(Code; "Group Code")
            {
                Caption = 'Code';
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
