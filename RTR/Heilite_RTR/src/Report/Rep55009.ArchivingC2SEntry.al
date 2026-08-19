report 55009 "Archiving C2S Entry"
{
    // version HEI.01

    // HEI.01 CHG2162842 IBM SAMANR01 20/06/202022 #C2S optimazation & archiving
    //   # New Report created to Archiving the C2s Entry via Job Queue

    // BC Upgrade POENAB02: Original (HeiLite) report id 50547

    Caption = 'Archiving C2S Entry';
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
        C2SRunningCalendar.SetRange("Automatic Run Archive Date", WorkDate());
        if C2SRunningCalendar.FindSet(false) then
            repeat
                CLEAR(InsertShippingCosts);
                InsertShippingCosts.MoveToArchive_New(C2SRunningCalendar."Starting Date", C2SRunningCalendar."Ending Date");
            until C2SRunningCalendar.Next() = 0;
    end;

    var
        C2SRunningCalendar: Record "C2S/COGS Running Calendar FND";
        AllocateCOGSCosts: Report "Allocate COGS Costs";
        InsertShippingCosts: Report "Insert Shipping Costs";
}

