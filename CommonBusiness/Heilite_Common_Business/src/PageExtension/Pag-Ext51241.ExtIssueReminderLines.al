namespace J_Common_Business_QUA.J_Common_Business_QUA;
using Microsoft.Sales.Reminder;

pageextension 51241 "Ext Issue Reminder Lines" extends "Issued Reminder Lines"
{
    layout
    {
        addafter(Amount)
        {
            field("Disputed FND"; Rec."Disputed FND")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field("Disputed Reason code FND"; Rec."Disputed Reason code FND")
            {
                ApplicationArea = all;
                Visible = true;
            }

        }
    }

}
