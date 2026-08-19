page 58144 "Monitor Interface Log"
{
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework
    // HEI.02 IBM HORTOC01 06.03.2019 - #fix to reprocess log entries
    // HEI.03 CHG2021537 IBM HORTOC01 17.09.2019 # new page based on standard page for local interfaces

    // BC Upgrade KUMARR78 >>
    //
    // Page Name  : Monitor Interface Log
    // Page ID    : 50408
    //
    // 1. Added Business Central visibility property.
    //    Old:
    //         - ApplicationArea property not defined at page level (NAV).
    //    New:
    //         - ApplicationArea = All ensured at page level.
    //         - Page compliant with BC visibility requirements.
    //
    // 2. Added ApplicationArea to all fields, actions, and system parts.
    //    Old:
    //         - Fields and actions without ApplicationArea property.
    //    New:
    //         - ApplicationArea = All added to all repeater fields.
    //         - ApplicationArea = All added to:
    //              • Lines action
    //              • Open Record action
    //              • Show Description action
    //              • Show XML action
    //              • Move to Outbound (ReprocessEntry) action
    //         - ApplicationArea = All added to Links and Notes system parts.
    //         - Fully aligned with BC UI compliance.
    //
    // 3. Updated SourceTableView for AL syntax.
    //    Old:
    //         - NAV style implementation.
    //    New:
    //         - sorting("Entry No.")
    //           order(descending);
    //         - Verified AL compatible syntax.
    //
    // 4. Replaced legacy NAV object IDs with named object references.
    //    Old:
    //         - RunObject = Page 50012;
    //         - Record 50004;
    //         - Codeunit 50000;
    //    New:
    //         - RunObject = Page "Interface Log Lines";
    //         - Record "Interface Log Header INT";
    //         - Codeunit "Interface Framework Mgt.";
    //         - Removed dependency on numeric IDs.
    //         - SaaS safe and upgrade compliant.
    //
    // 5. Ensured proper AL method invocation syntax.
    //    Old:
    //         - Rec.OpenRecord;
    //         - Rec.ShowNotes;
    //         - Rec.ShowXmlDocument;
    //    New:
    //         - Rec.OpenRecord();
    //         - Rec.ShowNotes();
    //         - Rec.ShowXmlDocument();
    //         - Ensures correct AL execution pattern.
    //
    // 6. Implemented multi-selection handling for reprocessing.
    //    Old:
    //         - Direct record handling (NAV style).
    //    New:
    //         - CurrPage.SetSelectionFilter(InterfaceLogHeader);
    //         - InterfaceFrameworkMgt.ReprocessLogInterfaceEntries(InterfaceLogHeader);
    //         - Supports multiple record reprocessing.
    //         - BC compliant record processing.
    //
    // 7. Added validation for inbound entries during reprocess.
    //    Old:
    //         - No explicit validation before reprocess.
    //    New:
    //         - if Rec.Direction = Rec.Direction::Inbound then
    //               Error(ReprocessError);
    //         - Prevents invalid inbound reprocessing.
    //         - Ensures functional integrity.
    //
    // 8. Maintained compiler warning suppression.
    //    Old:
    //         - No explicit pragma handling.
    //    New:
    //         - #pragma warning disable/restore AA0218 used.
    //         - Prevents compiler warnings during upgrade.
    //
    // BC Upgrade KUMARR78 <<

    Caption = 'Monitor Interface Log';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Log Header INT";
    SourceTableView = sorting("Entry No.")
                      order(descending);

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
#pragma warning disable AA0218
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
                field("Interface Code"; Rec."Interface Code") { ApplicationArea = All; }
                field(Direction; Rec.Direction) { ApplicationArea = All; }
                field("Sync. Date"; Rec."Sync. Date") { ApplicationArea = All; }
                field("Archive Date"; Rec."Archive Date") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field("Error Message"; Rec."Error Message") { ApplicationArea = All; }
                field("Source Type"; Rec."Source Type") { ApplicationArea = All; }
                field("Source Subtype"; Rec."Source Subtype") { ApplicationArea = All; }
                field("Source No."; Rec."Source No.") { ApplicationArea = All; }
                field("Source Status"; Rec."Source Status") { ApplicationArea = All; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
                field("Document Date"; Rec."Document Date") { ApplicationArea = All; }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.") { ApplicationArea = All; }

                field("Global No."; Rec."Global No.") { Visible = false; ApplicationArea = All; }
                field(Name; Rec.Name) { Visible = false; ApplicationArea = All; }
                field(Address; Rec.Address) { Visible = false; ApplicationArea = All; }
                field(City; Rec.City) { Visible = false; ApplicationArea = All; }
                field("Country/Region Code"; Rec."Country/Region Code") { Visible = false; ApplicationArea = All; }

                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code") { ApplicationArea = All; }
                field("Purchasing Organisation"; Rec."Purchasing Organisation") { ApplicationArea = All; }
                field("Shipment Method"; Rec."Shipment Method") { ApplicationArea = All; }
                field("Shipment Method Location"; Rec."Shipment Method Location") { ApplicationArea = All; }
                field("Payment Terms Code"; Rec."Payment Terms Code") { ApplicationArea = All; }
                field("Language Code"; Rec."Language Code") { ApplicationArea = All; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
                field("Currency Factor"; Rec."Currency Factor") { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field("VAT Amount"; Rec."VAT Amount") { ApplicationArea = All; }
                field("Amount Including VAT"; Rec."Amount Including VAT") { ApplicationArea = All; }
                field("Requested Receipt Date"; Rec."Requested Receipt Date") { ApplicationArea = All; }
                field("Delete Record"; Rec."Delete Record") { ApplicationArea = All; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; }
                field("Action Code"; Rec."Action Code") { ApplicationArea = All; }
                field("External Contract No."; Rec."External Contract No.") { ApplicationArea = All; }
                field("External Contract Name"; Rec."External Contract Name") { ApplicationArea = All; }
                field("Contract Type"; Rec."Contract Type") { ApplicationArea = All; }
                field("Valid From"; Rec."Valid From") { ApplicationArea = All; }
                field("Valid To"; Rec."Valid To") { ApplicationArea = All; }
                field(Closed; Rec.Closed) { ApplicationArea = All; }
                field(Channel; Rec.Channel) { ApplicationArea = All; }
                field("External Requisition No."; Rec."External Requisition No.") { ApplicationArea = All; }
                field("External Order No."; Rec."External Order No.") { ApplicationArea = All; }
                field("Version No."; Rec."Version No.") { ApplicationArea = All; }
                field("Type ID"; Rec."Type ID") { ApplicationArea = All; }
                field("Shipping Agent Code"; Rec."Shipping Agent Code") { ApplicationArea = All; }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code") { ApplicationArea = All; }
                field(Description; Rec.Description) { ApplicationArea = All; }
                field("Your Reference"; Rec."Your Reference") { ApplicationArea = All; }
                field("Legal Entity"; Rec."Legal Entity") { ApplicationArea = All; }
                field("Message Name"; Rec."Message Name") { ApplicationArea = All; }
                field("Message ID"; Rec."Message ID") { ApplicationArea = All; }
                field("Message Creation DateTime"; Rec."Message Creation DateTime") { ApplicationArea = All; }
                field("Msg. Sender Business System ID"; Rec."Msg. Sender Business System ID") { ApplicationArea = All; }
                field("Msg. Recv. Business System ID"; Rec."Msg. Recv. Business System ID") { ApplicationArea = All; }
                field("Source System ID"; Rec."Source System ID") { ApplicationArea = All; }
                field("Company Code ID"; Rec."Company Code ID") { ApplicationArea = All; }
                field("Severity Code"; Rec."Severity Code") { ApplicationArea = All; }
                field("Log Message"; Rec."Log Message") { ApplicationArea = All; }
                field("Message Code"; Rec."Message Code") { ApplicationArea = All; }
                field("Message Type"; Rec."Message Type") { ApplicationArea = All; }
                field("Message Class"; Rec."Message Class") { ApplicationArea = All; }
                field("Object Type"; Rec."Object Type") { ApplicationArea = All; }
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.") { ApplicationArea = All; }
            }
#pragma warning restore AA0218
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Header)
            {
                Caption = 'Header';
                Image = "Action";
                action(Lines)
                {
                    Caption = 'Lines';
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // RunObject = page 50012; BC UPGRDAE KUMARR78 Blocking As old NAV Page ID.
                    RunObject = page "Interface Log Lines";//BC UPGRDAE KUMARR78 Replacing old NAV Page ID with Variable("Interface Entry Lines")

                    RunPageLink = "Header Entry No." = field("Entry No.");
                }
                action("Open Record")
                {
                    Caption = 'Open Record';
                    Image = Open;
                    Promoted = true;
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
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
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
                    PromotedCategory = Process;
                    PromotedIsBig = true;

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
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        Rec.ShowXmlDocument();
                    end;
                }
                action(ReprocessEntry)
                {
                    Caption = 'Move to Outbound';
                    Image = OutboundEntry;
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Move entry to outbound';

                    trigger OnAction();
                    var
                        // InterfaceLogHeader: Record "50004";//BC UPGRADE KUMARR78 Blocking OLD NAV Table ID.
                        InterfaceLogHeader: Record "Interface Log Header INT"; //BC UPGRADE KUMARR78 Replacing 50004 ID with Latest Record Object.
                        // InterfaceFrameworkMgt: Codeunit "50000";//BC UPGRADE KUMARR78 Blocking OLD NAV Codeunit ID.
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";//BC UPGRADE KUMARR78 Replacing 50000 ID with Latest codeunit Object.
                    begin
                        //HEI.02>>
                        if Rec.Direction = Rec.Direction::Inbound then
                            Error(ReprocessError);
                        CurrPage.SetSelectionFilter(InterfaceLogHeader);
                        InterfaceFrameworkMgt.ReprocessLogInterfaceEntries(InterfaceLogHeader);
                        Message('Done');
                        //HEI.02<<
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.SetRange("Pepperi Interface", true);//HEI.03
    end;

    var
        BlobIsEmpty: Label 'The entry does not contain any description data.';
        ReprocessError: Label 'You cannot reprocess inbounds entries!';
}

