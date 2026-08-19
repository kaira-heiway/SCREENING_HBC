namespace J_Common_Business_QUA.J_Common_Business_QUA;

using Microsoft.Sales.Customer;

pageextension 51242 "Extends Customer Lookup" extends "Customer Lookup"
{
    layout
    {
        //BC UPGRADE KUMARR78 ++30-06-2026
        addafter("Responsibility Center")
        {
            field("Account Group FND"; Rec."Account Group FND")
            {
                ApplicationArea = all;
            }
        }
        //BC UPGRADE KUMARR78 ++30-06-2026
    }
}

