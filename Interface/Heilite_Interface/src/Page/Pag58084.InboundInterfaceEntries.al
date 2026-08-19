page 58084 "Inbound Interface Entries"
{
    // Heilite Navision Old Id - 50007

    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework
    // HEI.02 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # New Field added: "Processing Flag"
    // HEI.03 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added below fields:50044, 50045, 50045 & 50447 in Page
    //BC UPGRADE ATHUKS01 Added RefreshOnActivate property for Data refresh.

    Caption = 'Inbound Interface Entries';
    Editable = false;
    ModifyAllowed = false;
    RefreshOnActivate = true; //BC UPGRADE ATHUKUS01
    PageType = List;
    SourceTable = "Interface Entry Header INT";
    ApplicationArea = All;// BC Upgrade VAMSIU01
    UsageCategory = Lists;// BC Upgrade VAMSIU01
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

                }
                field("Interface Code"; Rec."Interface Code")
                {

                }
                field(Direction; Rec.Direction)
                {

                }
                field("Sync. Date"; Rec."Sync. Date")
                {

                }
                field("Archive Date"; Rec."Archive Date")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field("Processing Flag"; Rec."Processing Flag")
                {

                }
                field("Error Message"; Rec."Error Message")
                {

                }
                field("Source Type"; Rec."Source Type")
                {

                }
                field("Source Subtype"; Rec."Source Subtype")
                {

                }
                field("Source No."; Rec."Source No.")
                {

                }
                field("Source Status"; Rec."Source Status")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Document Date"; Rec."Document Date")
                {

                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {

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

                }
                field("Purchasing Organisation"; Rec."Purchasing Organisation")
                {

                }
                field("Shipment Method"; Rec."Shipment Method")
                {

                }
                field("Shipment Method Location"; Rec."Shipment Method Location")
                {

                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {

                }
                field("Language Code"; Rec."Language Code")
                {

                }
                field("E-Mail"; Rec."E-Mail")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Currency Factor"; Rec."Currency Factor")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field("VAT Amount"; Rec."VAT Amount")
                {

                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {

                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {

                }
                field("Delete Record"; Rec."Delete Record")
                {

                }
                field(Blocked; Rec.Blocked)
                {

                }
                field("Action Code"; Rec."Action Code")
                {

                }
                field("External Contract No."; Rec."External Contract No.")
                {

                }
                field("External Contract Name"; Rec."External Contract Name")
                {

                }
                field("Contract Type"; Rec."Contract Type")
                {

                }
                field("Valid From"; Rec."Valid From")
                {

                }
                field("Valid To"; Rec."Valid To")
                {

                }
                field(Closed; Rec.Closed)
                {

                }
                field(Channel; Rec.Channel)
                {

                }
                field("External Requisition No."; Rec."External Requisition No.")
                {

                }
                field("External Order No."; Rec."External Order No.")
                {

                }
                field("Version No."; Rec."Version No.")
                {

                }
                field("Type ID"; Rec."Type ID")
                {

                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {

                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Your Reference"; Rec."Your Reference")
                {

                }
                field("Legal Entity"; Rec."Legal Entity")
                {

                }
                field("Message Name"; Rec."Message Name")
                {

                }
                field("Message ID"; Rec."Message ID")
                {

                }
                field("Message Creation DateTime"; Rec."Message Creation DateTime")
                {

                }
                field("Msg. Sender Business System ID"; Rec."Msg. Sender Business System ID")
                {

                }
                field("Msg. Recv. Business System ID"; Rec."Msg. Recv. Business System ID")
                {

                }
                field("Source System ID"; Rec."Source System ID")
                {

                }
                field("Company Code ID"; Rec."Company Code ID")
                {

                }
                field("Severity Code"; Rec."Severity Code")
                {

                }
                field("Log Message"; Rec."Log Message")
                {

                }
                field("Message Code"; Rec."Message Code")
                {

                }
                field("Message Type"; Rec."Message Type")
                {

                }
                field("Message Class"; Rec."Message Class")
                {

                }
                field("Object Type"; Rec."Object Type")
                {

                }
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {

                }
                field("Start Execution"; Rec."Start Execution")
                {

                }
                field("End Execution"; Rec."End Execution")
                {

                }
                field("Send Request"; Rec."Send Request")
                {

                }
                field("Get Response"; Rec."Get Response")
                {

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
                    Caption = 'Lines';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = New;//BC Upgrade VAMSIU01 - Added
                    PromotedIsBig = true;
                    RunObject = Page "Interface Entry Lines";
                    RunPageLink = "Header Entry No." = FIELD("Entry No.");
                }
                action(ShowDescription)
                {
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
                action(MoveToLog)
                {
                    Caption = 'Move To Log';
                    Image = Log;
                    Promoted = true;
                    PromotedCategory = New;//BC Upgrade VAMSIU01 - Added
                    PromotedIsBig = true;
                    ToolTip = 'Move entry to log.';
                    Visible = true;

                    trigger OnAction();
                    var
                        InterfaceEntryHeader: Record "Interface Entry Header INT";
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
                    begin
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.LogErrorInterfaceEntries(InterfaceEntryHeader);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Manual Master Data")
                {
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
                    Caption = 'Manual Entries';
                    Image = ExtendedDataEntry;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Manual Interface Entries";//BC Upgrade VAMSIU01 - Commented before due to page availablity now it is available so uncommented.
                    ToolTip = 'Insert SRM related data manually';
                }
            }
        }
    }
}

