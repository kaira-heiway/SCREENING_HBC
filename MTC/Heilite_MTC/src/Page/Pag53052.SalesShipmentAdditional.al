page 53052 "Sales Shipment Additional"
{
    // version HEI.01

    // HEI.01 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # New Page created to store Purchase Additional Fields
    // BC Upgrade BHARDA11 >>
    // 1. OLD Page ID - 50338.
    // 2. Add ApplicationArea Property in Page and field.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    Caption = 'Sales Shipment Additional';
    PageType = Card;
    SourceTable = "Sales Ship. Header Add FND";

    layout
    {
        area(content)
        {
            // Caption = '<Control55001>';
            group(General)
            {
            }
            field("PQ Approver"; Rec."PQ Approver")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

