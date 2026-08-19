report 55015 "Allocate COGS Job Queue"
{
    // version HEI.02

    // HEI.01 RITM3055469 IBM NASTAA02 07/06/2022 # Split C2S / COGS Allocation Job Queue
    //   # New Report created to automatically run the COGS Allocations via Job Queue
    // HEI.02 CHG2169207 IBM SISUM01 26/08/2022 # Add permissions for T50208, T5021, T50238, T50241

    // BC Upgrade POENAB02: Original (HeiLite) report id 50531

    Caption = 'Allocate COGS Job Queue';
    Permissions = TableData "Shipping Cost Allocation FND" = rimd,
                  TableData "RPM - SKU Relationship FND" = rimd,
                  TableData "COGS Alloc on STD Price FND" = rimd,
                  TableData "COGS Alloc STD Price Line FND" = rimd;
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        //HEI.01>>
        //Running for Manual date
        C2SRunningCalendar.Reset();
        C2SRunningCalendar.SetRange("Manual Run Date", WorkDate());
        if C2SRunningCalendar.FindSet(false) then
            repeat
                Clear(AllocateCOGSCosts);
                AllocateCOGSCosts.GetDates(C2SRunningCalendar."Starting Date", C2SRunningCalendar."Ending Date");
                AllocateCOGSCosts.JobQueueRun(true, C2SRunningCalendar);
                AllocateCOGSCosts.RunModal();
            until C2SRunningCalendar.Next() = 0;

        //Running for Pre-Close Date
        C2SRunningCalendar.Reset();
        C2SRunningCalendar.SetRange("Automatic Run Pre-Close Date", WorkDate());
        if C2SRunningCalendar.FindSet(false) then
            repeat
                Clear(AllocateCOGSCosts);
                AllocateCOGSCosts.GetDates(C2SRunningCalendar."Starting Date", C2SRunningCalendar."Ending Date");
                AllocateCOGSCosts.JobQueueRun(true, C2SRunningCalendar);
                AllocateCOGSCosts.RunModal();
            until C2SRunningCalendar.Next() = 0;
        //Running for Close Date
        C2SRunningCalendar.Reset();
        C2SRunningCalendar.SetRange("Automatic Run Close Date", WorkDate());
        if C2SRunningCalendar.FindSet(false) then
            repeat
                Clear(AllocateCOGSCosts);
                AllocateCOGSCosts.GetDates(C2SRunningCalendar."Starting Date", C2SRunningCalendar."Ending Date");
                AllocateCOGSCosts.JobQueueRun(true, C2SRunningCalendar);
                AllocateCOGSCosts.RunModal();
            until C2SRunningCalendar.Next() = 0;
        //HEI.01<<
    end;

    var
        Text001: Label '%1 must not be blank.';
        Text002: Label 'Starting Date';
        Text003: Label 'Ending Date';
        Text004: TextConst ENU = 'Whse. Cost Allocation Setup       @1@@@@@@@@@@@ \', FRA = 'Traitement des fournisseurs             #1##########';
        Text005: Label 'The shipping costs have been successfully allocated.';
        Text006: Label 'Shipping costs are already allocated for this period! Please select another date.';
        Text008: Label 'Allocate RPM costs         @2@@@@@@@@@@@ \';
        Text009: Label 'Allocate Warehouse costs         @3@@@@@@@@@@@ \';
        Text010: Label 'Calculate Internal Transfers       @4@@@@@@@@@@@ \';
        Text011: Label 'Calculate Delivery to Customers     @5@@@@@@@@@@@ \';
        C2SRunningCalendar: Record "C2S/COGS Running Calendar FND";
        AllocateCOGSCosts: Report "Allocate COGS Costs";
}

