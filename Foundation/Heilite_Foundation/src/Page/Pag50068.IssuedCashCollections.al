page 50068 "Issued Cash Collections"
{
    // version NAVW110.0,DITW110.00.08,HEI.01

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order
    // # Issue 452 HEILITE BASE IBM ISYED01 10/10/2017
    //   # added "User Id" to the page.

    //BC UPGRADE SHIKHD02>>
    // Blocked Image = Cash and updated to Image = CashFlow as Cash is not supported in Business Central
    //BC UPGRADE SHIKHD02<<

    Caption = 'Issued Cash Collections';
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "Issue Cash Collection Head FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
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
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the address of the customer the reminder is for.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city name of the customer the reminder is for.';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the name of the person you regularly contact when you communicate with the customer the reminder is for.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date that the reminder was issued on.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the document date on which the reminder was created.';
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ToolTip = 'Specifies the number of the reminder from which the issued reminder was created.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies how many times the reminder has been printed.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
            }
            part("Issued cash collection line"; "Issued Cash Collection Lines")
            {
                Editable = false;
                SubPageLink = "Cash Collection No." = FIELD("No.");
            }
            group(Posting)
            {
                Caption = 'Posting';
                Editable = false;
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the date when payment of the amount on the reminder is due.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code of the issued reminder.';

                    trigger OnAssistEdit();
                    begin
                        ChangeExchangeRate.SetParameter(
                          Rec."Currency Code",
                          CurrExchRate.ExchangeRate(Rec."Posting Date", Rec."Currency Code"),
                          Rec."Posting Date");
                        ChangeExchangeRate.EDITABLE(false);
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Editable = false;
                //Code commented by Manisha due drink it object
                // field("Truck Code";"Truck Code")
                // {
                // }
                // field("Driver Code";"Driver Code")
                // {
                // }
                //Code commented by Manisha due drink it object
                //BC UPGRADE KUMARR78 >>
                field("Truck Code"; Rec."Truck Code")
                {
                    ApplicationArea = all;
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ApplicationArea = all;
                }
                //BC UPGRADE KUMARR78 <<
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
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
                //BC UPGRADE SHIKHD02>> // Blocked Image = Cash and used Image = CashFlow as Cash is not supported in Business Central
                //Image = Cash;
                Image = CashFlow;
                //BC UPGRADE SHIKHD02<<
                action(List)
                {
                    Caption = 'List';
                    Image = OpportunitiesList;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ToolTip = 'Executes the List action.';

                    trigger OnAction();
                    begin
                        IssuedCashCollectionHeader.COPY(Rec);
                        if PAGE.RUNMODAL(0, IssuedCashCollectionHeader) = ACTION::LookupOK then
                            Rec := IssuedCashCollectionHeader;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Cash Collection Comment Sheet";
                    RunPageLink = Type = CONST("Issued Cash Collection"),
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
                separator(Separator6)
                {
                }
                action("Page Issued Cash Collection Stats")
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Issued Cash Collection Stats";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';
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
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction();
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

    var
        CurrExchRate: Record "Currency Exchange Rate";
        IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND";
        ChangeExchangeRate: Page "Change Exchange Rate";
}

