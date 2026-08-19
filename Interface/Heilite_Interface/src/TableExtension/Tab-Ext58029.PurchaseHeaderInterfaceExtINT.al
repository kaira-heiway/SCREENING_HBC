namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Purchases.Document;

tableextension 58029 "PurchaseHeaderInterfaceExt_INT" extends "Purchase Header"
{
    // HEI.48 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New flowfield created: 50046 - LSR Order No
    // HEI.52 CHG2103752 IBM BHATTA09 07.09.2021
    //   # New Option PendClose added in Maximo Status field

    fields
    {
        // BC Upgrade SHUKLP03 >>
        field(50043; "Maximo Status INT"; Option)
        {
            CalcFormula = Lookup("Purchase Header Additional FND"."Maximo Status INT" WHERE("Document Type" = FIELD("Document Type"),
                                                                                     "No." = FIELD("No.")));
            Caption = 'Maximo Status';
            Description = 'HEI.39,HEI.52';
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = " ",Approved,Canceled,Closed,"Waiting on Approval",PendClose;
        }
        field(50046; "LSR Order No. INT"; Code[20])
        {
            Caption = 'LSR Order No.';
            CalcFormula = Lookup("Purchase Header Additional FND"."LSR Order No INT" WHERE("Document Type" = FIELD("Document Type"),
                                                                                    "No." = FIELD("No.")));
            Description = 'HEI.48';
            Editable = false;
            FieldClass = FlowField;
        }
        // BC Upgrade SHUKLP03 <<
    }
}
