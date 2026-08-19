namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Sales.Document;
using System.Security.User;

pageextension 58041 SalesCreditMemoInterfaceExt extends "Sales Credit Memo"
{
    // BC Upgrade SHUKLP03 >>
    // HEI.05 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field added: "Suppress POS Interface"
    //   # Code added to enable editing of Field "Supress POS Interface"
    // BC Upgrade SHUKLP03 <<

    layout
    {
        addafter("Applies-to ID")
        {
            field("Suppress POS Interface"; Rec."Suppress POS Interface FND")
            {
                Editable = SuppressPOSInterfaceEditable;
                ApplicationArea = All;
            }

        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        //HEI.05>>
        UserSetup2.GET(USERID);
        SuppressPOSInterfaceEditable := UserSetup2."Allow Change Inter Flag FND";
        //HEI.05<<
    end;

    var
        SuppressPOSInterfaceEditable: Boolean;
        UserSetup2: Record "User Setup";
}
