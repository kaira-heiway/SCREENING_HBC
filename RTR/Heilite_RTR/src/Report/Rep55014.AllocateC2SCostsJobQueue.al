report 55014 "Allocate C2S Costs Job Queue"
{
    // version HEI.04

    // HEI.01 CHG2141694 IBM BULIMC01 13/04/2022#new report created to run Shipping Costs via Job Queue
    // HEI.02 CHG2132673 IBM BULIMC01 26/04/2022#code added to run COGS Allocation via Job Queue
    // HEI.03 RITM3055469 IBM NASTAA02 07/06/2022 # Split C2S / COGS Allocation Job Queue
    //   # COGS Allocations move to new Report
    // HEI.04 CHG2169207 IBM SISUM01 26/08/2022 # Add permissions for T50208 and T50215

    // BC Upgrade POENAB02: Original (HeiLite) report id 50524

    Caption = 'Allocate C2S Costs Job Queue';
    Permissions = TableData "Shipping Cost Allocation FND" = rimd,
                  TableData "RPM - SKU Relationship FND" = rimd;
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
        //Running for Manual date
        C2SRunningCalendar.Reset();
        C2SRunningCalendar.SetRange("Manual Run Date", WorkDate());
        if C2SRunningCalendar.FindSet(false) then //HEI.03
            repeat
                //for C2S allocation //HEI.02
                Clear(AllocateShippingCosts);
                AllocateShippingCosts.GetDates(C2SRunningCalendar."Starting Date", C2SRunningCalendar."Ending Date");
                AllocateShippingCosts.JobQueueRun(true, C2SRunningCalendar);
                AllocateShippingCosts.RunModal();
            //HEI.02>>
            //for COGS Allocation
            //HEI.03>>
            //CLEAR(AllocateCOGSCosts);
            //AllocateCOGSCosts.GetDates(C2SRunningCalendar."Starting Date",C2SRunningCalendar."Ending Date");
            //AllocateCOGSCosts.JobQueueRun(TRUE,C2SRunningCalendar);
            //AllocateCOGSCosts.RUNMODAL;
            //HEI.03<<
            //HEI.02<<
            until C2SRunningCalendar.Next() = 0;

        //Running for Pre-Close Date
        C2SRunningCalendar.Reset();
        C2SRunningCalendar.SetRange("Automatic Run Pre-Close Date", WorkDate());
        if C2SRunningCalendar.FindSet(false) then //HEI.03
            repeat
                Clear(AllocateShippingCosts);
                AllocateShippingCosts.GetDates(C2SRunningCalendar."Starting Date", C2SRunningCalendar."Ending Date");
                AllocateShippingCosts.JobQueueRun(true, C2SRunningCalendar);
                AllocateShippingCosts.RunModal();
            //HEI.02>>
            //for COGS Allocation
            //HEI.03>>
            //CLEAR(AllocateCOGSCosts);
            //AllocateCOGSCosts.GetDates(C2SRunningCalendar."Starting Date",C2SRunningCalendar."Ending Date");
            //AllocateCOGSCosts.JobQueueRun(TRUE,C2SRunningCalendar);
            //AllocateCOGSCosts.RUNMODAL;
            //HEI.03<<
            //HEI.02<<
            until C2SRunningCalendar.Next() = 0;

        //Running for Close Date
        C2SRunningCalendar.Reset();
        C2SRunningCalendar.SetRange("Automatic Run Close Date", WorkDate());
        if C2SRunningCalendar.FindSet(false) then //HEI.03
            repeat
                Clear(AllocateShippingCosts);
                AllocateShippingCosts.GetDates(C2SRunningCalendar."Starting Date", C2SRunningCalendar."Ending Date");
                AllocateShippingCosts.JobQueueRun(true, C2SRunningCalendar);
                AllocateShippingCosts.RunModal();
            //HEI.02>>
            //for COGS Allocation
            //HEI.03>>
            //CLEAR(AllocateCOGSCosts);
            //AllocateCOGSCosts.GetDates(C2SRunningCalendar."Starting Date",C2SRunningCalendar."Ending Date");
            //AllocateCOGSCosts.JobQueueRun(TRUE,C2SRunningCalendar);
            //AllocateCOGSCosts.RUNMODAL;
            //HEI.03<<
            //HEI.02<<
            until C2SRunningCalendar.Next() = 0;
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
        AllocateShippingCosts: Report "Allocate Shipping Costs";
        Generated: Boolean;
        AllocateCOGSCosts: Report "Allocate COGS Costs";
}

