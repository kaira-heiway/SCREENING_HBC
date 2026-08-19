page 58047 "LSR Transfers Email Id Setup"
{
    // Heilite Navision Old Id - 50390

    // version HEI.01

    // HEI.01 CHG2216722 IBM SISUM01 03.10.2023  Request for email functionality for Transfer Order Creation
    //   # New object created

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "LSR Transfers Email Id Setup" to "LSR Transfer Email Setup FND".
    // BC UPGRADE PATELS08 <<

    Caption = 'LSR Transfers Email Id Setup';
    PageType = List;
    SourceTable = "LSR Transfer Email Setup FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transfer To Location"; Rec."Transfer To Location")
                {
                    ToolTip = 'Specifies the value of the Transfer To Location field.';
                }
                field("Create Email Id"; Rec."Create Email Id")
                {
                    ToolTip = 'Specifies the value of the Create Email Id field.';
                }
                field("Shipped Email Id"; Rec."Shipped Email Id")
                {
                    ToolTip = 'Specifies the value of the Shipped Email Id field.';
                }
            }
        }
    }

    actions
    {
    }
}

