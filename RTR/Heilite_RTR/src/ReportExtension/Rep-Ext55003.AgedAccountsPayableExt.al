
reportextension 55003 AgedAccountsPayableExt extends "Aged Accounts Payable"
{   // BC UPGRADE KAIRAR01 
    //DITW17.00.02 AT 22/01/2014 DIT-770 #163 : Setting a Vendor Posting Group Filter does not influence the result
    dataset
    {
        modify("Vendor Ledger Entry")
        {
            trigger OnBeforePreDataItem()
            begin
                //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                Vendor.COPYFILTER("Vendor Posting Group", "Vendor Posting Group");
                //>>DITW17.00.02 AT DIT-770 #163
            end;
        }
        modify(OpenVendorLedgEntry)
        {
            trigger OnBeforePreDataItem()
            begin
                //<<DITW17.00.02 AT 22/01/2014 DIT-770 #163
                Vendor.COPYFILTER("Vendor Posting Group", "Vendor Posting Group");
                //>>DITW17.00.02 AT DIT-770 #163
            end;
        }
    }
}