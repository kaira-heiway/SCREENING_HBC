pageextension 58058 "Data Exch Line Def Ext" extends "Data Exch Line Def Part"
{
    layout
    {
        addafter("Parent Code")
        {
            field("Min. Occurs"; Rec."Min. Occurs FND")
            {
                ApplicationArea = All;
            }
            field("Max. Occurs"; Rec."Max. Occurs FND")
            {
                ApplicationArea = All;
            }
        }
    }
}
