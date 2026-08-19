namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Manufacturing.Capacity;

pageextension 54053 "CapacityLedgerEntriesExt_DTW" extends "Capacity Ledger Entries"
{//BC Upgrade Kamnay01  Created this page extension to add the field  for "Output quantity (HL)","Quantity (HL)" and "Unit Volume HL" in Capacity Ledger Entries page. This is required for FDD-DTW 0018
    layout
    {
        addafter("Output quantity")
        {
            field("Output quantity (HL)"; Rec."Output quantity (HL) FND")
            {
                ApplicationArea = All;
                Caption = 'Output quantity (HL)';
            }

        }
        addafter(Quantity)
        {
            field("Quantity (HL)"; Rec."Quantity (HL) FND")
            {
                ApplicationArea = All;
                Caption = 'Quantity (HL)';
            }
            field("Unit Volume HL"; Rec."Unit Volume HL FND")
            {
                ApplicationArea = All;
                Caption = 'Unit Volume HL';
            }

        }

    }
}
