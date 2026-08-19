reportextension 55002 AgedAccountsReceivableExt extends "Aged Accounts Receivable"
{   // BC UPGRADE KAIRAR01 
    // DITW17.00.02 AT 22/01/2014 DIT-770 #163 : Setting a Customer Posting Group Filter does not influence the result
    dataset
    {
        modify("Cust. Ledger Entry")
        {
            trigger OnBeforePreDataItem()
            var
            begin
                //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                Customer.COPYFILTER("Customer Posting Group", "Customer Posting Group");
                //>>DITW17.00.02 AT DIT-770 #163
            end;
        }
        modify(OpenCustLedgEntry)
        {
            trigger OnBeforePreDataItem()
            var
            begin
                //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                Customer.COPYFILTER("Customer Posting Group", "Customer Posting Group");
                //>>DITW17.00.02 AT DIT-770 #163
            end;
        }
    }
}