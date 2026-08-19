page 58065 "PFI Approvals"
{
    // Heilite Navision Old Id - 50461

    // version HEI.01

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 07.07.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface

    // BC Upgrade MISHRS14 >>
    // Changed table name to "PFI Approval FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Editable = false;
    PageType = List;
    SourceTable = "PFI Approval FND";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PFI document No."; Rec."PFI document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the PFI document No. field.';
                }
                field("PFI Approval Status"; Rec."PFI Approval Status")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the PFI Approval Status field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field(Rejected; Rec.Rejected)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Rejected field.';
                }
                field(Accepted; Rec.Accepted)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Accepted field.';
                }
                field("Rejected Reason"; Rec."Rejected Reason")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Rejected Reason field.';
                }
                field(Amend; Rec.Amend)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Amend field.';
                }
                field("Amend Reason"; Rec."Amend Reason")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Amend Reason field.';
                }
                field("Mail Sent"; Rec."Mail Sent")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Mail Sent field.';
                }
            }
        }
    }

    actions
    {
    }
}

