// namespace INTERFACES.INTERFACES;

pageextension 58042 PurchOrderOvrdueEntInterfExt extends "Purchase Order Overdue Entries"
{
    // BC Upgrade BHARDA11 >>
    // 1. Move this field STP to interface extension.
    // BC Upgrade BHARAD11 <<

    layout
    {
        addafter(Status)
        {
            field("Maximo Requisition No."; Rec."Maximo Requisition No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
