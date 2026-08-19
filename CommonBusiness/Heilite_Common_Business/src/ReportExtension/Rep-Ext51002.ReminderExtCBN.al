namespace Heilite_General_MTC.Heilite_General_MTC;

using Microsoft.Sales.Reminder;

reportextension 51002 ReminderExtCBN extends Reminder
{
    //     HEI.01 Defect #4051 CHG2010806 IBM GAVANM01 25.07.2019
    //   # Enlarge the space for 'Posting date' caption in the header
    // HEI.02 Defect4817 BULIMC01 IBM 01/11/2019 
    //      #captions translated into French for the following labels: Dispute, Dispute Reason Code, Description
    //      #language changed

    // BC Upgrade SHUKLP03 >>
    // Added columns 'Disputed' and 'Disputed Reason code' from "Issued Reminder Line" table to dataset and added a new layout for the report.
    // Added custom labels from nav.
    // Added fields to the report layout.
    // HEI.01 and HEI.02 changes are not added.
    // BC Upgrade SHUKLP03 <<

    dataset
    {
        add("Issued Reminder Line")
        {
            column(Disputed; "Disputed FND")
            {
            }
            column(Disputed_ReasonCode; "Disputed Reason code FND")
            {
            }
        }
    }
    rendering
    {
        //HEI.01>>
        layout(RDLC_Cust)
        {
            Type = RDLC;
            LayoutFile = '.\src\ReportsLayout\Sales Issued Reminder.rdl';
        }
        //HEI.01<<
    }
    labels
    {
        DisputedCase = 'Disputed';
        DisputedResonCode = 'Disputed Reason Code';
        Description = 'Description';

    }

}
