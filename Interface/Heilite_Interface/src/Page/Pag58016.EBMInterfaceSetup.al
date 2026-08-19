page 58016 "EBM Interface Setup"
{
    // Heilite Navision Old Id - 50246

    // version HEI.01

    // HEI.01 RW-GAPLOG08 IBM LAZARE02 23.10.2018 # New page for EBM interface

    SourceTable = "EBM Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Sales Posting Interface"; Rec."Sales Posting Interface")
                {
                    ToolTip = 'Specifies the value of the Sales Posting Interface field.';
                }
                field("Sales Confirmation Interface"; Rec."Sales Confirmation Interface")
                {
                    ToolTip = 'Specifies the value of the Sales Confirmation Interface field.';
                }
                field("Sales Confirmation Response"; Rec."Sales Confirmation Response")
                {
                    ToolTip = 'Specifies the value of the Sales Confirmation Response field.';
                }
                field("Status Update Interface"; Rec."Status Update Interface")
                {
                    ToolTip = 'Specifies the value of the Status Update Interface field.';
                }
                field("No. of Confirmation Attempts"; Rec."No. of Confirmation Attempts")
                {
                    ToolTip = 'Specifies the value of the No. of Confirmation Attempts field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(DocumentTypes)
            {
                Caption = 'Document Types';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "EBM Document Types";
                ToolTip = 'Executes the Document Types action.';
            }
        }
    }
}

