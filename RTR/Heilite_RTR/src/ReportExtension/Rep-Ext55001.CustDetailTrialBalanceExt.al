reportextension 55001 CustDetailTrialBalance extends "Customer - Detail Trial Bal."
{   // BC UPGRADE KAIRAR01 
    // DITW17.10.03 MSF 28/03/2014 DIT-715 #340 Added Filter "Customer posting Group"
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
    }
}