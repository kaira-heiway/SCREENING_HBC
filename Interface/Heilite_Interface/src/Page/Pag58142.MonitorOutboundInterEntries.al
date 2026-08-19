page 58142 "Monitor Outbound Inter Entries"
{
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework
    // HEI.02 CHG2021537 IBM HORTOC01 17.09.2019 # new page based on standard page for local interfaces

    // BC Upgrade KUMARR78 >>
    //
    // Page Name  : Monitor Outbound Inter Entries
    // Page ID    : 50406
    //
    // 1. Added Business Central visibility property.
    //    Old:
    //         - ApplicationArea property not defined at page level (NAV).
    //    New:
    //         - ApplicationArea = All added at page level.
    //         - Ensures page visibility and searchability in BC SaaS.
    //
    // 2. Standardized field bindings using Rec.
    //    Old:
    //         - Direct field binding without explicit Rec. reference (NAV style).
    //    New:
    //         - All fields explicitly referenced using Rec."Field Name".
    //         - Ensures AL best practice compliance and avoids ambiguity.
    //
    // 3. Updated SourceTableView syntax for AL compliance.
    //    Old:
    //         - NAV style SORTING/WHERE formatting.
    //    New:
    //         - SORTING(Direction, Status)
    //           WHERE(Direction = CONST(Outbound),
    //                 Status = FILTER(Pending | Processed));
    //         - Verified compatibility with BC AL syntax.
    //
    // 4. Replaced hardcoded NAV Page IDs with named page references.
    //    Old:
    //         - RunObject = Page 50009;
    //    New:
    //         - RunObject = Page "Interface Entry Lines";
    //         - Prevents dependency on legacy numeric object IDs.
    //         - SaaS-safe object referencing.
    //
    // 5. Standardized action method call.
    //    Old:
    //         - Rec.ProcessManually;
    //    New:
    //         - Rec.ProcessManually();
    //         - Ensures proper method invocation syntax in AL.
    //
    // 6. Updated variable declaration to object name.
    //    Old:
    //         - InterfaceSetup: Record 50000;
    //    New:
    //         - InterfaceSetup: Record "Interface Setup INT";
    //         - Removes numeric object dependency for SaaS compatibility.
    //
    // BC Upgrade KUMARR78 <<

    Caption = 'Monitor Outbound Interface Entries';
    Editable = false;
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
    PageType = List;
    SourceTable = "Interface Entry Header INT";
    SourceTableView = SORTING(Direction, Status)
                      WHERE(Direction = CONST(Outbound),
                            Status = FILTER(Pending | Processed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the entry number.';
                }
                field("Interface Code"; Rec."Interface Code")
                {
                    ToolTip = 'Specifies the interface code.';
                }
                field(Direction; Rec.Direction)
                {
                    ToolTip = 'Specifies the direction.';
                }
                field("Sync. Date"; Rec."Sync. Date")
                {
                    ToolTip = 'Specifies the synchronization date.';
                }
                field("Archive Date"; Rec."Archive Date")
                {
                    ToolTip = 'Specifies the archive date.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status.';
                }
                field("Error Message"; Rec."Error Message")
                {
                    ToolTip = 'Specifies the error message.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the source type.';
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                    ToolTip = 'Specifies the source subtype.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the source number.';
                }
                field("Source Status"; Rec."Source Status")
                {
                    ToolTip = 'Specifies the source status.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the document date.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the buy-from vendor number.';
                }
                field("Global No."; Rec."Global No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the global number.';
                }
                field(Name; Rec.Name)
                {
                    Visible = false;
                    ToolTip = 'Specifies the name.';
                }
                field(Address; Rec.Address)
                {
                    Visible = false;
                    ToolTip = 'Specifies the address.';
                }
                field(City; Rec.City)
                {
                    Visible = false;
                    ToolTip = 'Specifies the city.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the country/region code.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ToolTip = 'Specifies the salespers./purch. code.';
                }
                field("Purchasing Organisation"; Rec."Purchasing Organisation")
                {
                    ToolTip = 'Specifies the purchasing organisation.';
                }
                field("Shipment Method"; Rec."Shipment Method")
                {
                    ToolTip = 'Specifies the shipment method.';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location")
                {
                    ToolTip = 'Specifies the shipment method location.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the payment terms code.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the language code.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the e-mail.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the currency code.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the currency factor.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the amount.';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ToolTip = 'Specifies the VAT amount.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the amount including VAT.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the requested receipt date.';
                }
                field("Delete Record"; Rec."Delete Record")
                {
                    ToolTip = 'Specifies whether to delete the record.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies whether the record is blocked.';
                }
                field("Action Code"; Rec."Action Code")
                {
                    ToolTip = 'Specifies the action code.';
                }
                field("External Contract No."; Rec."External Contract No.")
                {
                    ToolTip = 'Specifies the external contract number.';
                }
                field("External Contract Name"; Rec."External Contract Name")
                {
                    ToolTip = 'Specifies the external contract name.';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the contract type.';
                }
                field("Valid From"; Rec."Valid From")
                {
                    ToolTip = 'Specifies the valid from date.';
                }
                field("Valid To"; Rec."Valid To")
                {
                    ToolTip = 'Specifies the valid to date.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies whether the record is closed.';
                }
                field(Channel; Rec.Channel)
                {
                    ToolTip = 'Specifies the channel.';
                }
                field("External Requisition No."; Rec."External Requisition No.")
                {
                    ToolTip = 'Specifies the external requisition number.';
                }
                field("External Order No."; Rec."External Order No.")
                {
                    ToolTip = 'Specifies the external order number.';
                }
                field("Version No."; Rec."Version No.")
                {
                    ToolTip = 'Specifies the version number.';
                }
                field("Type ID"; Rec."Type ID")
                {
                    ToolTip = 'Specifies the type ID.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the shipping agent code.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies the shipping agent service code.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies your reference.';
                }
                field("Legal Entity"; Rec."Legal Entity")
                {
                    ToolTip = 'Specifies the legal entity.';
                }
                field("Message Name"; Rec."Message Name")
                {
                    ToolTip = 'Specifies the message name.';
                }
                field("Message ID"; Rec."Message ID")
                {
                    ToolTip = 'Specifies the message ID.';
                }
                field("Message Creation DateTime"; Rec."Message Creation DateTime")
                {
                    ToolTip = 'Specifies the message creation date and time.';
                }
                field("Msg. Sender Business System ID"; Rec."Msg. Sender Business System ID")
                {
                    ToolTip = 'Specifies the message sender business system ID.';
                }
                field("Msg. Recv. Business System ID"; Rec."Msg. Recv. Business System ID")
                {
                    ToolTip = 'Specifies the message receiver business system ID.';
                }
                field("Source System ID"; Rec."Source System ID")
                {
                    ToolTip = 'Specifies the source system ID.';
                }
                field("Company Code ID"; Rec."Company Code ID")
                {
                    ToolTip = 'Specifies the company code ID.';
                }
                field("Severity Code"; Rec."Severity Code")
                {
                    ToolTip = 'Specifies the severity code.';
                }
                field("Log Message"; Rec."Log Message")
                {
                    ToolTip = 'Specifies the log message.';
                }
                field("Message Code"; Rec."Message Code")
                {
                    ToolTip = 'Specifies the message code.';
                }
                field("Message Type"; Rec."Message Type")
                {
                    ToolTip = 'Specifies the message type.';
                }
                field("Message Class"; Rec."Message Class")
                {
                    ToolTip = 'Specifies the message class.';
                }
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the object type.';
                }
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {
                    ToolTip = 'Specifies the data exchange entry number.';
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
                    PromotedIsBig = true;
                    // RunObject = page 50009; BC UPGRDAE KUMARR78 Blocking As old NAV Page ID.
                    RunObject = page "Interface Entry Lines";//BC UPGRDAE KUMARR78 Replacing old NAV Page ID with Variable("Interface Entry Lines")
                    RunPageLink = "Header Entry No." = FIELD("Entry No.");
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
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.SETRANGE("Pepperi Interface", TRUE);//HEI.02
    end;

    var
        // InterfaceSetup: Record 50000;  //BC UPGRADE KUMARR78 Replacing Variable with ("Interface Setup")
        InterfaceSetup: Record "Interface Setup INT"; //BC UPGRADE KUMARR78 Replacing Variable From(50000 Old Nav Id)

}

