namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Sales.Document;
using System.Security.User;

pageextension 58040 SalesInvoiceInterfaceExt extends "Sales Invoice"
{
    // BC Upgrade SHUKLP03 >>
    // HEI.03 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field added: "Suppress POS Interface"
    //   # Code added to enable editing of Field "Supress POS Interface"
    // BC Upgrade SHUKLP03 <<


    layout
    {
        addafter("Job Queue Status")
        {
            field("Suppress POS Interface"; Rec."Suppress POS Interface FND")
            {
                Description = 'HEI.03';
                Editable = SuppressPOSInterfaceEditable;
                ApplicationArea = All;
            }
        }

    }
    trigger OnAfterGetRecord()
    var
    begin
        //HEI.03>>
        UserSetup2.GET(USERID);
        SuppressPOSInterfaceEditable := UserSetup2."Allow Change Inter Flag FND";
        //HEI.03<<
    end;

    var
        UserSetup2: Record "User Setup";
        SuppressPOSInterfaceEditable: Boolean;


}
