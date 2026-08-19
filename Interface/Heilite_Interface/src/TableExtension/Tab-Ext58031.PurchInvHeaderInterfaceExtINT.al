namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.History;

tableextension 58031 "PurchInvHeaderInterfaceExt_INT" extends "Purch. Inv. Header"
{
    // HEI.11 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //    # New Field added Maximo status

    fields
    {
        // BC Upgrade SHUKLP03 >>
        field(50043; "Maximo Status INT"; Option)
        {
            CalcFormula = Lookup("Purch. Inv. Header Add FND"."Maximo Status INT" WHERE("No." = FIELD("No.")));
            Caption = 'Maximo Status';
            Description = 'HEI.11';
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        }
        // BC Upgrade SHUKLP03 <<
    }
}
