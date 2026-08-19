page 58129 "Local Inbound Int. Entries"
{
    // version HEI.01

    // HEI.01 CHG2026335 IBM GAVANM01 09.01.2020 # new page
    // BC Upgrade BHARAD11 >>
    // 1. Old Page ID- 50378.
    // 2. Add ApplicationArea property in Page , fields and Actions.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Local Inbound Interface Entries';
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Interface Entry Header INT";
    SourceTableView = SORTING(Direction, Status)
                      WHERE(Direction = CONST(Inbound),
                            Status = FILTER(Pending | Processed));

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
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
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
                action(Process)
                {
                    ApplicationArea = All;
                    Caption = 'Process';
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Process manually the selected entry.';

                    trigger OnAction();
                    begin
                        Rec.ProcessManually;
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Manual Master Data")
                {
                    ApplicationArea = All;
                    Caption = 'Manual Master Data';
                    Image = DataEntry;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Interface Manual Master Data";
                    ToolTip = 'Insert Mendix related data manually';
                }
                action("Manual Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Manual Entries';
                    Image = ExtendedDataEntry;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Manual Interface Entries";
                    ToolTip = 'Insert SRM related data manually';
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

