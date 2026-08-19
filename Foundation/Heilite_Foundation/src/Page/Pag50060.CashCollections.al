page 50060 "Cash Collections"
{
    // version NAVW110.0.00.15052

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    // BC Upgrade PATELS08 >>
    // # IN group(&Cash Collection), Cash Collection is not a vaild image, so changed it to Currency
    // BC Upgrade PATELS08 <<


    Caption = 'Cash Collections';
    PageType = Document;
    SourceTable = "Cash Collection Header FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Administration;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the reminder document.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit();
                    begin
                        //HEI.01>>
                        if rec.AssistEdit(xRec) then
                            CurrPage.UPDATE();
                        //HEI.01<<
                    end;
                }
                field("Customer No."; rec."Customer No.")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the number of the customer you want to post a reminder for.';
                }
                field(Name; rec.Name)
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the name of the customer the reminder is for.';
                }
                field(Address; rec.Address)
                {
                    ToolTip = 'Specifies the address of the customer the reminder is for.';
                }
                field("Address 2"; rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Post Code"; rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address.';
                }
                field(City; rec.City)
                {
                    ToolTip = 'Specifies the city name of the customer the reminder is for.';
                }
                field(Contact; rec.Contact)
                {
                    ToolTip = 'Specifies the name of the person you regularly contact when you communicate with the customer the reminder is for.';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the reminder should be issued.';
                }
                field("Document Date"; rec."Document Date")
                {
                    ToolTip = 'Specifies the date on which you create the reminder.';
                }
            }
            part("Cash Collection lines"; "Cash Collection Lines")
            {
                SubPageLink = "Cash Collection No." = FIELD("No.");
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Due Date"; rec."Due Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies when payment of the amount on the reminder is due.';
                }
                field("Currency Code"; rec."Currency Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the currency code of the reminder.';

                    trigger OnAssistEdit();
                    begin
                        //HEI.01>>
                        rec.TESTFIELD("Posting Date");
                        ChangeExchangeRate.SetParameter(
                          CurrExchRate."Currency Code",
                          CurrExchRate.ExchangeRate(rec."Posting Date", rec."Currency Code"),
                          rec."Posting Date");
                        ChangeExchangeRate.EDITABLE(false);
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then;
                        CLEAR(ChangeExchangeRate);
                        //HEI.01<<
                    end;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Truck Code"; rec."Truck Code")
                {
                    ToolTip = 'Specifies the value of the Truck Code field.';
                }
                field("Driver Code"; rec."Driver Code")
                {
                    ToolTip = 'Specifies the value of the Driver Code field.';
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
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
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Cash Collection")
            {
                Caption = '&Cash Collection';
                // BC Upgrade PATELS08 >> # Cash Collection is not a vaild image, changed it to Currency
                // Image = "Cash collection";
                Image = Currency;
                // BC Upgrade PATELS08 <<
                action(List)
                {
                    Caption = 'List';
                    Image = OpportunitiesList;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ToolTip = 'Executes the List action.';

                    trigger OnAction();
                    begin
                        CashCollectionHeader.COPY(Rec);
                        if PAGE.RUNMODAL(0, CashCollectionHeader) = ACTION::LookupOK then
                            Rec := CashCollectionHeader;
                    end;
                }
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
                separator(Separator32)
                {
                }
                action("<Page Cash Collection Statistics>")
                {
                    Caption = 'Cash Collection Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Cash Collection Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Cash Collection Statistics action.';
                }
            }
        }
        area(processing)
        {
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
                        rec.TESTFIELD("Truck Code");
                        rec.TESTFIELD("Driver Code");
                        REPORT.RUNMODAL(REPORT::"Issue Cash Collection", true, true, CashCollectionHeader);
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        //HEI.01>>
        CurrPage.SAVERECORD();
        exit(rec.ConfirmDeletion());
        //HEI.01<<
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        //HEI.01>>
        if (not DocNoVisible) and (rec."No." = '') then
            rec.SetCustomerFromFilter();
        //HEI.01<<
    end;

    trigger OnOpenPage();
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        //HEI.01>>
        //SetDocNoVisible;
        IsOfficeAddin := OfficeMgt.IsAvailable();
        //HEI.01<<
    end;

    var
        CashCollectionHeader: Record "Cash Collection Header FND";
        CurrExchRate: Record "Currency Exchange Rate";
        CashCollectionList: Page "Cash Collections List";
        ChangeExchangeRate: Page "Change Exchange Rate";
        DocNoVisible: Boolean;
        IsOfficeAddin: Boolean;
}

