report 58040 "WMS - Send all Items/Customers"
{
    //BC Upgrade GUNREM01 Old ID-50417
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        if WMSInterfaceSetup.GET and WMSInterfaceSetup."WMS Integration" then begin
            Flag := false;

            if not CONFIRM(Text003, false) then CurrReport.QUIT;

            vItem.RESET;
            vItem.SETRANGE(Blocked, false);
            vItem.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
            if vItem.FINDFIRST then begin
                repeat
                    WMSManagement.CreateItemOutbound(vItem, 'Update');
                until vItem.NEXT = 0;
                Flag := true;
            end;

            vCustomer.RESET;
            vCustomer.SETRANGE("Flag for Deletion FND", false);
            vCustomer.SETFILTER("Account Group FND", WMSInterfaceSetup."Customer Account Groups");
            if vCustomer.FINDFIRST then begin
                repeat
                    WMSManagement.CreateCustomerOutbound(vCustomer, 'Update');
                until vCustomer.NEXT = 0;
                Flag := true;
            end;

            if Flag then
                MESSAGE(Text002)
            else
                MESSAGE(Text001);
        end;

        CurrReport.QUIT;
    end;

    var
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        Flag: Boolean;
        vItem: Record Item;
        vCustomer: Record Customer;
        WMSManagement: Codeunit "WMS Interface Management";
        Text001: Label 'No item sent!';
        Text002: Label 'Process completed.';
        Text003: Label 'Attention! All items and customers will be sent to Reflex. Do you want to continue?';
}

