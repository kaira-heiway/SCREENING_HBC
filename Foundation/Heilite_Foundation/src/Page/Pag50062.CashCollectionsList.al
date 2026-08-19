page 50062 "Cash Collections List"
{
    // HEI.01

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    Caption = 'Cash Collection List';
    CardPageID = "Cash Collections";
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Cash Collection Header FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the reminder document.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer you want to post a reminder for.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the customer the reminder is for.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the reminder.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    DrillDown = false;
                    ToolTip = 'Specifies the total of the remaining amounts on the reminder lines.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city name of the customer the reminder is for.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the dimension value code linked to the purchase.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the shortcut dimension value code that the reminder is linked to.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Reminder")
            {
                Caption = '&Reminder';
                Image = Reminder;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Reminder Comment Sheet";
                    RunPageLink = Type = CONST(Reminder),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                action("C&ustomer")
                {
                    Caption = 'C&ustomer';
                    Image = Customer;
                    RunObject = Page "Customer List";
                    RunPageLink = "No." = FIELD("Customer No.");
                    ToolTip = 'Executes the C&ustomer action.';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
            }
            group("&Issuing")
            {
                Caption = '&Issuing';
                Image = Add;
                action(Issue)
                {
                    Caption = 'Issue';
                    Ellipsis = true;
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the Issue action.';

                    trigger OnAction();
                    begin
                        CurrPage.SETSELECTIONFILTER(CashCollectionHeader);
                        REPORT.RUNMODAL(REPORT::"Issue Cash Collection", true, true, CashCollectionHeader);
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        exit(Rec.ConfirmDeletion());
    end;

    var
        CashCollectionHeader: Record "Cash Collection Header FND";

    procedure GetSelectionFilter(): Text;
    var
        ReminderHeader: Record "Reminder Header";
        CUHenikenBCCustomFunctions: Codeunit "Heineken BC Custom Functions";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        //HEI.01>>
        CurrPage.SETSELECTIONFILTER(CashCollectionHeader);
        exit(CUHenikenBCCustomFunctions.GetSelectionFilterForIssueCashCollection(CashCollectionHeader));  // BC Upgrdae Manisha
        //HEI.01<<
    end;

}

