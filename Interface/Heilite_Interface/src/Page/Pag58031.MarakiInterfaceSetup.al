page 58031 "Maraki Interface Setup"
{
    // Heilite Navision Old Id - 50339

    // version HEI.01

    // HEI.01 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Page created for Maraki Interface Setup

    Caption = 'Maraki Interface Setup';
    PageType = Card;
    SourceTable = "Maraki Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03 

    layout
    {
        area(content)
        {
            group(Interfaces)
            {
                Caption = 'Maraki Interfaces';
                field("Sales Posting Interface"; Rec."Sales Posting Interface")
                {
                    ToolTip = 'Specifies the value of the Sales Posting Interface field.';
                }
                field("Sales Confirmation Response"; Rec."Sales Confirmation Response")
                {
                    ToolTip = 'Specifies the value of the Sales Confirmation Response field.';
                }
                field("Status Update Interface"; Rec."Status Update Interface")
                {
                    ToolTip = 'Specifies the value of the Sales Update Interface field.';
                }
                field("No. Of Conf Attempts"; Rec."No. Of Conf Attempts")
                {
                    ToolTip = 'Specifies the value of the No. Of Confirmation Attempts field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup55008)
            {
                action("Supress Values")
                {
                    Caption = 'Supress Values';
                    Image = StepOver;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Maraki Supress Values";
                    ToolTip = 'Executes the Supress Values action.';
                }
            }
        }
    }
}

