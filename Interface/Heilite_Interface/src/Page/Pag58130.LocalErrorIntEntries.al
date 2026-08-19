page 58130 "Local Error Int. Entries"
{
    // version HEI.01

    // HEI.01 CHG2026335 IBM GAVANM01 09.01.2020 # new page
    // BC Upgrade BHARAD11 >>
    // 1. Old Page ID - 50379.
    // 2. Add ApplicationArea Property in Page, Fields and Actions.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Local Error Interface Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Entry Header INT";
    SourceTableView = SORTING(Direction, Status)
                      WHERE(Status = CONST(Error));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Interface Code"; Rec."Interface Code")
                {
                    ApplicationArea = All;
                }
                field(Direction; Rec.Direction)
                {
                    ApplicationArea = All;
                }
                field("Sync. Date"; Rec."Sync. Date")
                {
                    ApplicationArea = All;
                }
                field("Archive Date"; Rec."Archive Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Status"; Rec."Source Status")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Global No."; Rec."Global No.")
                {
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    Visible = false;
                }
                field(City; Rec.City)
                {
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                }
                field("Purchasing Organisation"; Rec."Purchasing Organisation")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method"; Rec."Shipment Method")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Location"; Rec."Shipment Method Location")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Delete Record"; Rec."Delete Record")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Action Code"; Rec."Action Code")
                {
                    ApplicationArea = All;
                }
                field("External Contract No."; Rec."External Contract No.")
                {
                    ApplicationArea = All;
                }
                field("External Contract Name"; Rec."External Contract Name")
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field("Valid From"; Rec."Valid From")
                {
                    ApplicationArea = All;
                }
                field("Valid To"; Rec."Valid To")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field(Channel; Rec.Channel)
                {
                    ApplicationArea = All;
                }
                field("External Requisition No."; Rec."External Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("External Order No."; Rec."External Order No.")
                {
                    ApplicationArea = All;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                }
                field("Type ID"; Rec."Type ID")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Legal Entity"; Rec."Legal Entity")
                {
                    ApplicationArea = All;
                }
                field("Message Name"; Rec."Message Name")
                {
                    ApplicationArea = All;
                }
                field("Message ID"; Rec."Message ID")
                {
                    ApplicationArea = All;
                }
                field("Message Creation DateTime"; Rec."Message Creation DateTime")
                {
                    ApplicationArea = All;
                }
                field("Msg. Sender Business System ID"; Rec."Msg. Sender Business System ID")
                {
                    ApplicationArea = All;
                }
                field("Msg. Recv. Business System ID"; Rec."Msg. Recv. Business System ID")
                {
                    ApplicationArea = All;
                }
                field("Source System ID"; Rec."Source System ID")
                {
                    ApplicationArea = All;
                }
                field("Company Code ID"; Rec."Company Code ID")
                {
                    ApplicationArea = All;
                }
                field("Severity Code"; Rec."Severity Code")
                {
                    ApplicationArea = All;
                }
                field("Log Message"; Rec."Log Message")
                {
                    ApplicationArea = All;
                }
                field("Message Code"; Rec."Message Code")
                {
                    ApplicationArea = All;
                }
                field("Message Type"; Rec."Message Type")
                {
                    ApplicationArea = All;
                }
                field("Message Class"; Rec."Message Class")
                {
                    ApplicationArea = All;
                }
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                }
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control50026; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control50027; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Header)
            {
                Caption = 'Header';
                Image = "Action";
                action(Lines)
                {
                    ApplicationArea = All;
                    Caption = 'Lines';
                    Image = AllLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Interface Entry Lines";
                    RunPageLink = "Header Entry No." = FIELD("Entry No.");
                }
                action(ShowErrorMessage)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Error Message';
                    Image = Error;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Show the error message that has stopped the entry.';

                    trigger OnAction();
                    begin
                        Rec.ShowErrorMessage;
                    end;
                }
                action(ClearError)
                {
                    ApplicationArea = All;
                    Caption = 'Clear Error';
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Reset the status of the selected entry in order to reprocess it.';

                    trigger OnAction();
                    var
                        InterfaceEntryHeader: Record "Interface Entry Header INT";
                    begin
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeader);
                        InterfaceEntryHeader.MARKEDONLY(true);
                        if InterfaceEntryHeader.FINDSET then
                            repeat
                                InterfaceEntryHeader.ClearError;
                            until InterfaceEntryHeader.NEXT = 0;
                        CurrPage.UPDATE;
                    end;
                }
                action(Process)
                {
                    ApplicationArea = All;
                    Caption = 'Process';
                    Image = Process;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Process manually the selected entry.';

                    trigger OnAction();
                    begin
                        Rec.ProcessErrorEntry;
                    end;
                }
                action(MoveToLog)
                {
                    ApplicationArea = All;
                    Caption = 'Move To Log';
                    Image = Log;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Move entry to log.';

                    trigger OnAction();
                    var
                        InterfaceEntryHeader: Record "Interface Entry Header INT";
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
                    begin
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.LogErrorInterfaceEntries(InterfaceEntryHeader);
                    end;
                }
                action(ShowDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Show Description';
                    Image = Description;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        Rec.ShowNotes;
                    end;
                }
                action(ShowXML)
                {
                    ApplicationArea = All;
                    Caption = 'Show XML';
                    Image = XMLFile;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        Rec.ShowXmlDocument;
                    end;
                }
                action(ForceSalesOrderCreation)
                {
                    ApplicationArea = All;
                    Caption = 'Force Sales Order creation';
                    Enabled = false;
                    Image = Sales;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction();
                    var
                        InterfaceEntryHeader: Record "Interface Entry Header INT";
                        EDIInterfaceManagement: Codeunit "EDI Interface Mgmt.";
                        EDIInterfaceSetup: Record "EDI Interface Setup INT";
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
                        Text001: Label 'Select one record.';
                        SalesHeader: Record "Sales Header";
                        SalesOrderPage: Page "Sales Order";
                        Customer: Record Customer;
                    begin
                        CLEAR(InterfaceEntryHeader);
                        EDIInterfaceSetup.GET;
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeader);
                        if InterfaceEntryHeader.COUNT <> 1 then
                            ERROR(Text001);

                        if InterfaceEntryHeader.FINDFIRST then
                            if InterfaceEntryHeader."Interface Code" = EDIInterfaceSetup."SO/SRO Interface Request" then begin
                                EDIInterfaceManagement.ProcessSalesOrder(InterfaceEntryHeader, true);
                                InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
                                InterfaceFrameworkMgt.LogErrorInterfaceEntries(InterfaceEntryHeader);
                                CLEAR(SalesHeader);
                                CLEAR(SalesOrderPage);
                                CLEAR(Customer);
                                Customer.SETRANGE(GLN, InterfaceEntryHeader."Bill-to Customer No.");
                                if Customer.FINDFIRST then begin
                                    SalesHeader.SETRANGE("External Document No.", InterfaceEntryHeader."External Document No.");
                                    SalesHeader.SETRANGE("Sell-to Customer No.", Customer."No.");
                                    if SalesHeader.FINDFIRST then begin
                                        SalesOrderPage.SETTABLEVIEW(SalesHeader);
                                        SalesOrderPage.SETRECORD(SalesHeader);
                                        SalesOrderPage.RUN;
                                    end;
                                end;
                            end;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        GeneralInterfaceSetup.GET;
        Rec.FILTERGROUP(2);
        if GeneralInterfaceSetup."Local Interfaces" <> '' then
            Rec.SETFILTER("Interface Code", GeneralInterfaceSetup."Local Interfaces")
        else
            Rec.SETFILTER("Interface Code", '=%1', '');
        Rec.FILTERGROUP(0);
    end;

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
}

