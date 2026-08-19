page 58133 "Prod. Order Outbound to LP"
{
    // version HEI.01

    // HEI.01 CHG2129985 IBM.LS      23.02.2022
    //   # Added New Page: 50485 - Prod. Order Outbound to LP

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Page ID-50485
    //BC Upgrade KAPOOV01  <<

    Caption = 'Prod. Order Outbound to Logopak';
    Editable = false;
    PageType = List;
    SourceTable = "Prod. Order Outbound to LP INT";
    ApplicationArea = All;   //BC Upgrade KAPOOV01
    UsageCategory = Lists;  //BC Upgrade KAPOOV01

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Prod. Order Interface"; Rec."Prod. Order Interface")
                {
                }
                field("Interface Status"; Rec."Interface Status")
                {
                }
                field("Sync. Date-Time"; Rec."Sync. Date-Time")
                {
                }
                field("Archive Date-Time"; Rec."Archive Date-Time")
                {
                }
                field("Error Message"; Rec."Error Message")
                {
                }
                field("Ready for LogoPak"; Rec."Ready for LogoPak")
                {
                }
                field("Prod. Order Status"; Rec."Prod. Order Status")
                {
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field("Planned Quantity"; Rec."Planned Quantity")
                {
                }
                field("Quantity (Full Pallet)"; Rec."Quantity (Full Pallet)")
                {
                }
                field(EAN; Rec.EAN)
                {
                }
                field("Ccc Code"; Rec."Ccc Code")
                {
                }
                field("Gross Weight of Pallet in KG"; Rec."Gross Weight of Pallet in KG")
                {
                }
                field("Shelf Life"; Rec."Shelf Life")
                {
                }
                field("Last Modified Date-Time"; Rec."Last Modified Date-Time")
                {
                }
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

