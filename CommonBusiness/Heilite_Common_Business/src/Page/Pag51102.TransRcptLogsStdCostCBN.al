page 51102 "Trans.Rcpt.Logs(Std.Cost)CBN"
{
    // version HEI.01

    // HEI.01 CHG2253923 IBM POENAB02 04.12.2024 HB3943 Stock in transit - enablement of updating standard cost
    //   # Object created

    Caption = 'Trans. Rcpt. Logs (Std. Cost)';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    Permissions = TableData "Trans Rcpt Logs (Std Cost) FND" = rimd;
    SourceTable = "Trans Rcpt Logs (Std Cost) FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Qty."; Rec."Qty.")
                {
                    ToolTip = 'Specifies the value of the Qty. field.';
                }
                field("Receiving Location"; Rec."Receiving Location")
                {
                    ToolTip = 'Specifies the value of the Receiving Location field.';
                }
                field("Unit Cost (Receipt)"; Rec."Unit Cost (Receipt)")
                {
                    ToolTip = 'Specifies the value of the Unit Cost (Receipt) field.';
                }
                field("Standatd Cost (Item)"; Rec."Standatd Cost (Item)")
                {
                    ToolTip = 'Specifies the value of the Standatd Cost (Item) field.';
                }
                field("Difference (Per Unit)"; Rec."Difference (Per Unit)")
                {
                    ToolTip = 'Specifies the value of the Difference (Per Unit) field.';
                }
                field("Total Difference"; Rec."Total Difference")
                {
                    ToolTip = 'Specifies the value of the Total Difference field.';
                }
            }
        }
    }

    actions
    {
    }
}

