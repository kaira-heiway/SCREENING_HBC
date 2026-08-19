pageextension 51195 ReminderTermsListExtCBN extends "Reminder Terms List"

//Bc Upgrade YADAVM09 Created page extension to add field "Note About Line Fee on Report" for FAT Issue
{
    layout
    {
        addafter("Minimum Amount (LCY)")
        {
            field("Note About Line Fee on Report"; Rec."Note About Line Fee on Report")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies that any notes about line fees will be added to the reminder.';
            }

        }
    }
}