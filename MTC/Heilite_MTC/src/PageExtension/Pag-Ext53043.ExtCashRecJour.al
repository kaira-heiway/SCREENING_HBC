
pageextension 53043 "Ext Cash Rec. Jour" extends "Cash Receipt Journal"
{
    //BC UPGRADE KUMARR78 >>
    //FDD No.-->   FDD-MTC-009
    //GAP Np. -->  IBM GAP MTC 49
    //Adding Action Button for (Suggest Customer Payments)
    //Making Extension of Cash Reciept Journal Page
    //PID363-PID364(OTC152-OTC153)Suggest Customer Payments
    //BC UPGRADE KUMARR78 <<


    //BC UPGRADE KUMARR78 >> Adding
    actions
    {
        addbefore("Renumber Document Numbers")
        {

            action("Suggest Customer Payments")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                trigger OnAction()
                var
                    SuggestCustomerPayments: Report "Suggest Customer Payments NFR";
                begin
                    //<<DITW110.00.11 MSF 25/08/2017 NRQ#17902
                    CLEAR(SuggestCustomerPayments);
                    SuggestCustomerPayments.SetGenJnlLine(Rec);
                    SuggestCustomerPayments.RUNMODAL();
                    //>>DITW110.00.11 MSF 25/08/2017 NRQ#17902

                end;
            }
        }
    }
    //BC UPGRADE KUMARR78 << Adding
}
