namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.Archive;

tableextension 58033 "PurchaseHeaderArchiveExt_INT" extends "Purchase Header Archive"
{
    // HEI.07  CHG2024557 FDD-HT821 IBM SHANKJ03 10.02.2020
    //   # New field added Maximo status

    fields
    {
        // BC Upgrade SHUKLP03 >>
        field(50043; "Maximo Status INT"; Option)
        {
            CalcFormula = Lookup("Purchase Header Arch Addit FND"."Maximo Status INT" WHERE("Document Type" = FIELD("Document Type"),
                                                                                        "No." = FIELD("No.")));
            Caption = 'Maximo Status';
            Description = 'HEI.07';
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval";
        }
        // BC Upgrade SHUKLP03 <<
    }
}
