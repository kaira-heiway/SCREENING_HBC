pageextension 51238 "CustomerTemplateCardExtCBN" extends "Customer Templ. Card"
{
    layout
    {
        addafter("No. Series")
        {
            field("Account Group"; Rec."Account Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Value of Account Group';
            }
        }
    }
}
