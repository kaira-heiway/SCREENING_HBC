page 58087 "Interface Log"
{
    // Heilite Navision Old Id - 50011

    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework
    // HEI:CHG2007229:1:1 13/03/19 IBM.AS
    //   HEI.02 IBM HORTOC01 06.03.2019 - #fix to reprocess log entries
    // HEI.03 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # New Field added: "Processing Flag"
    // HEI.04 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added below fields:50044, 50045, 50045 & 50447 in Page

    Caption = 'Interface Log';
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Interface Log Header INT";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

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
        area(factboxes)
        {
            systempart(Control50025; Links)
            {
            }
            systempart(Control50026; Notes)
            {
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
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Interface Log Lines";
                    RunPageLink = "Header Entry No." = FIELD("Entry No.");
                }
                action("Open Record")
                {
                    Caption = 'Open Record';
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Open the related record from the database.';

                    trigger OnAction();
                    begin
                        Rec.OpenRecord;
                    end;
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
                action(ReprocessEntry)
                {
                    Caption = 'Move to Outbound';
                    Image = OutboundEntry;
                    Promoted = true;
                    PromotedCategory = New;//BC Upgrade VAMSIU01 - Added
                    PromotedIsBig = true;
                    ToolTip = 'Move entry to outbound';

                    trigger OnAction();
                    var
                        InterfaceLogHeader: Record "Interface Log Header INT";
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
                    begin
                        //HEI.02>>
                        if Rec.Direction = Rec.Direction::Inbound then
                            ERROR(ReprocessError);
                        CurrPage.SETSELECTIONFILTER(InterfaceLogHeader);
                        InterfaceFrameworkMgt.ReprocessLogInterfaceEntries(InterfaceLogHeader);
                        MESSAGE('Done');
                        //HEI.02<<
                    end;
                }
                action(ReprocessInboundEntry)
                {
                    Caption = 'Move to Inbound';
                    Image = OutboundEntry;
                    Promoted = true;
                    PromotedCategory = New;//BC Upgrade VAMSIU01 - Added
                    PromotedIsBig = true;
                    ToolTip = 'Move entry to Inbound';
                    Visible = true;

                    trigger OnAction();
                    var
                        InterfaceLogHeader: Record "Interface Log Header INT";
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
                    begin
                        //HEI.02>>
                        if Rec.Direction = Rec.Direction::Outbound then
                            ERROR(ReprocessError);
                        CurrPage.SETSELECTIONFILTER(InterfaceLogHeader);
                        InterfaceFrameworkMgt.ReprocessLogInterfaceEntries(InterfaceLogHeader);
                        MESSAGE('Done');
                        //HEI.02<<
                    end;
                }
            }
        }
    }

    var
        BlobIsEmpty: Label 'The entry does not contain any description data.';
        ReprocessError: Label 'You cannot reprocess inbounds entries!';
}

