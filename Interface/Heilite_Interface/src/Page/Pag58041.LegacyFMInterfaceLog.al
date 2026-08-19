page 58041 "Legacy FM Interface Log"
{
    // Heilite Navision Old Id - 50377

    // version HEI.01

    // HEI.01 FDD-HT610 IBM NASTAA02 06.03.2020 # La Reunion Futur Master
    //   # New Page created to store Legacy FuturMaster Interface Log
    // HEI.02 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # New Field added: "Processing Flag"

    Caption = 'FM Interface Log';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Log Header INT";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending)
                      WHERE("Interface Code" = FILTER('LEG-FM-CLMASTER-REQ' | 'LEG-FM-CLMASTER-RES' | 'LEG-FM-CUST-DISC-REQ' | 'LEG-FM-DAILYEXP-REQ' | 'LEG-FM-DAILYEXP-RES' | 'LEG-FM-DRPSTOCK-REQ' | 'LEG-FM-DRPSTOCK-RES'
                                        | 'LEG-FM-GLPROD-REQ' | 'LEG-FM-GLPROD-RES' | 'LEG-FM-MONTHLEXP-REQ' | 'LEG-FM-MONTHLEXP-RES' | 'LEG-FM-MPSSTOCK-REQ' | 'LEG-FM-MPSSTOCK-RES' | 'LEG-FM-MRPSTOCK-REQ'
                                        | 'LEG-FM-MRPSTOCK-RES' | 'LEG-FM-PO-REQ' | 'LEG-FM-PO-RES' | 'LEG-FM-WEEKLYEXP-REQ' | 'LEG-FM-WEEKLYEXP-RES'));
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Interface Code"; Rec."Interface Code")
                {
                    ToolTip = 'Specifies the value of the Interface Code field.';
                }
                field(Direction; Rec.Direction)
                {
                    ToolTip = 'Specifies the value of the Direction field.';
                }
                field("Sync. Date"; Rec."Sync. Date")
                {
                    ToolTip = 'Specifies the value of the Synchronize Date field.';
                }
                field("Archive Date"; Rec."Archive Date")
                {
                    ToolTip = 'Specifies the value of the Archive Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Processing Flag"; Rec."Processing Flag")
                {
                    ToolTip = 'Specifies the value of the Processing Flag field.';
                }
                field("Error Message"; Rec."Error Message")
                {
                    ToolTip = 'Specifies the value of the Error Message field.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the value of the Source Type field.';
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                    ToolTip = 'Specifies the value of the Source Subtype field.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the value of the Source No. field.';
                }
                field("Source Status"; Rec."Source Status")
                {
                    ToolTip = 'Specifies the value of the Source Status field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Buy-from Vendor No. field.';
                }
                field("Global No."; Rec."Global No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global No. field.';
                }
                field(Name; Rec.Name)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Address; Rec.Address)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(City; Rec.City)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ToolTip = 'Specifies the value of the Salespers./Purch. Code field.';
                }
                field("Purchasing Organisation"; Rec."Purchasing Organisation")
                {
                    ToolTip = 'Specifies the value of the Purchasing Organisation field.';
                }
                field("Shipment Method"; Rec."Shipment Method")
                {
                    ToolTip = 'Specifies the value of the Shipment Method field.';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location")
                {
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the value of the Language Code field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Amount field.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the value of the Requested Receipt Date field.';
                }
                field("Delete Record"; Rec."Delete Record")
                {
                    ToolTip = 'Specifies the value of the Delete Record field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Action Code"; Rec."Action Code")
                {
                    ToolTip = 'Specifies the value of the Action Code field.';
                }
                field("External Contract No."; Rec."External Contract No.")
                {
                    ToolTip = 'Specifies the value of the External Contract No. field.';
                }
                field("External Contract Name"; Rec."External Contract Name")
                {
                    ToolTip = 'Specifies the value of the External Contract Name field.';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("Valid From"; Rec."Valid From")
                {
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To")
                {
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(Channel; Rec.Channel)
                {
                    ToolTip = 'Specifies the value of the Channel field.';
                }
                field("External Requisition No."; Rec."External Requisition No.")
                {
                    ToolTip = 'Specifies the value of the External Requisition No. field.';
                }
                field("External Order No."; Rec."External Order No.")
                {
                    ToolTip = 'Specifies the value of the External Order No. field.';
                }
                field("Version No."; Rec."Version No.")
                {
                    ToolTip = 'Specifies the value of the Version No. field.';
                }
                field("Type ID"; Rec."Type ID")
                {
                    ToolTip = 'Specifies the value of the Type ID field.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the value of the Your Reference field.';
                }
                field("Legal Entity"; Rec."Legal Entity")
                {
                    ToolTip = 'Specifies the value of the Legal Entity field.';
                }
                field("Message Name"; Rec."Message Name")
                {
                    ToolTip = 'Specifies the value of the Message Name field.';
                }
                field("Message ID"; Rec."Message ID")
                {
                    ToolTip = 'Specifies the value of the Message ID field.';
                }
                field("Message Creation DateTime"; Rec."Message Creation DateTime")
                {
                    ToolTip = 'Specifies the value of the Message Creation DateTime field.';
                }
                field("Msg. Sender Business System ID"; Rec."Msg. Sender Business System ID")
                {
                    ToolTip = 'Specifies the value of the Sender Business System ID field.';
                }
                field("Msg. Recv. Business System ID"; Rec."Msg. Recv. Business System ID")
                {
                    ToolTip = 'Specifies the value of the Receiver Business System ID field.';
                }
                field("Source System ID"; Rec."Source System ID")
                {
                    ToolTip = 'Specifies the value of the Source System ID field.';
                }
                field("Company Code ID"; Rec."Company Code ID")
                {
                    ToolTip = 'Specifies the value of the Company Code ID field.';
                }
                field("Severity Code"; Rec."Severity Code")
                {
                    ToolTip = 'Specifies the value of the Severity Code field.';
                }
                field("Log Message"; Rec."Log Message")
                {
                    ToolTip = 'Specifies the value of the Log Message field.';
                }
                field("Message Code"; Rec."Message Code")
                {
                    ToolTip = 'Specifies the value of the Message Code field.';
                }
                field("Message Type"; Rec."Message Type")
                {
                    ToolTip = 'Specifies the value of the Message Type field.';
                }
                field("Message Class"; Rec."Message Class")
                {
                    ToolTip = 'Specifies the value of the Message Class field.';
                }
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                }
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {
                    ToolTip = 'Specifies the value of the Data Exch. Entry No. field.';
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
                    ToolTip = 'Executes the Lines action.';
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
                        Rec.OpenRecord();
                    end;
                }
                action(ShowDescription)
                {
                    Caption = 'Show Description';
                    Image = Description;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Show Description action.';

                    trigger OnAction();
                    begin
                        Rec.ShowNotes();
                    end;
                }
                action(ShowXML)
                {
                    Caption = 'Show XML';
                    Image = XMLFile;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Show XML action.';

                    trigger OnAction();
                    begin
                        Rec.ShowXmlDocument();
                    end;
                }
                action(ReprocessEntry)
                {
                    Caption = 'Move to Outbound';
                    Image = OutboundEntry;
                    Promoted = true;
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
            }
        }
    }

    var
        BlobIsEmpty: Label 'The entry does not contain any description data.';
        ReprocessError: Label 'You cannot reprocess inbounds entries!';
}

