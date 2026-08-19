pageextension 58079 GLAccountCard extends "G/L Account Card"
{
    //BC Upgrade SHARMP16--- Interface changes
    actions
    {
        addafter("Receivables-Payables")
        {
            action(ZycusTimeStamp)
            {
                ApplicationArea = all;
                Caption = 'ZycusTime Stamp';
                Image = Timesheet;
                RunObject = Page "Zycus Master Timestamp";
                RunPageLink = Code = FIELD("No.");
                RunPageView = sorting("Table ID", Code)
                              ORDER(Ascending)
                              where("Table ID" = CONST(15));
            }  // BC Upgrade SHARMP16 - To be moved to InterfaceFramework extension
        }
        addafter("Receivables-Payables_Promoted")
        {
            actionref(ZycusTimestamp_Promoted; ZycusTimeStamp)
            {
            }
        }
    }



    var

}//BC Upgrade SHARMP16 10April2026