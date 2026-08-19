page 50070 "Issued Cash Collections List"
{
    // version NAVW110.0,HEI.01

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order
    // # Issue 452 HEILITE BASE IBM ISYED01 10/10/2017
    //   # added "User Id" to the page.

    // BC Upgrade PATELP08 >> 
    // # Changes Image type - "cash" to "Currency" in Action-"Issued Cash Collection" as it is not valid and giving warning.
    // BC Upgrade PATELP08 <<

    Caption = 'Issued Cash Collections List';
    CardPageID = "Issued Cash Collections";
    DataCaptionFields = "Customer No.";
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Issue Cash Collection Head FND";
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
                    ToolTip = 'Specifies the issued reminder number.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the customer number the reminder is for.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the customer the reminder is for.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the issued reminder.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    DrillDown = false;
                    ToolTip = 'Specifies the total of the remaining amounts on the reminder lines.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the reminder has been printed.';
                    Visible = false;
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
                    ToolTip = 'Specifies the dimension value code associated with the reminder.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code associated with the reminder.';
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
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
            group("&Issued Cash Collection")
            {
                Caption = '&Issued Cash Collection';
                // BC Upgrade PATELP08 >> Changes Image type - "cash" to "Currency" as it is not valid and giving warning.
                //Image = Cash;
                // BC Upgrade PATELP08 <<
                Image = Currency;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Cash Collection Comment Sheet";
                    RunPageLink = Type = CONST("Cash Collection"),
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
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction();
                var
                    IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND";
                begin
                    CurrPage.SETSELECTIONFILTER(IssuedCashCollectionHeader);
                    // IssuedCashCollectionHeader.PrintRecords(true, false, false);//BC UPGRADE KUMARR78 --01-07-2026
                    IssuedCashCollectionHeader.NewPrintRecords(true, false, false);//BC UPGRADE KUMARR78 ++01-07-2026

                end;
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';

                trigger OnAction();
                begin
                    Rec.Navigate();
                end;
            }
        }
    }
}

