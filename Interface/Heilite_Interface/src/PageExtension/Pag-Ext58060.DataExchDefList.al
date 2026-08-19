pageextension 58060 "Data Exch Def List" extends "Data Exch Def List"
{
    actions
    {
        // // BC Upgrade MISHRS14 >>
        // // Added below code to hide action.
        // modify("Import Data Exchange Definition")
        // {
        //     Visible = false;
        //     Enabled = false;
        // }

        // modify("Export Data Exchange Definition")
        // {
        //     Visible = false;
        //     Enabled = false;
        // }
        // // BC Upgrade MISHRS14 <<

        addbefore("Import Data Exchange Definition")
        {
            action("New Import Data Exchange Def")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'New Import Data Exchange Definition';
                Image = Import;
                ToolTip = 'Import a data exchange definition from a bank file that is located on your computer or network. The file type must match the value of the File Type field.';

                trigger OnAction()
                begin
                    XMLPORT.Run(XMLPORT::"Imp/Exp Data Exch", false, true);
                end;
            }
        }
        // BC Upgrade MISHRS14 >>
        // Adding to check functionality and block Import/Export extra action present
        modify(Category_Category4)
        {
            Visible=false;
        }
        // BC Upgrade MISHRS14 <<

    }
}
