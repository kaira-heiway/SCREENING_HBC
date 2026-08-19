pageextension 51239 DataExchDefExtCBN extends "Data Exch Def Card"
{
    layout
    {
        addafter("User Feedback Codeunit")
        {
            field(Interfaces; Rec."Interfaces FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Values of Interfaces True or Not.';
            }
        }
    }
}
