page 58143 "Monitor Error Interf Entries"
{
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework
    // HEI.02 CHG2021537 IBM HORTOC01 17.09.2019 # new page based on standard page for local interfaces

    // BC Upgrade KUMARR78 >>
    //
    // Page Name  : Monitor Error Interf Entries
    // Page ID    : 50407
    //
    // 1. Added Business Central visibility property.
    //    Old:
    //         - ApplicationArea property not defined at page level (NAV).
    //    New:
    //         - ApplicationArea = All added at page level.
    //         - Ensures page visibility and searchability in BC.
    //
    // 2. Added ApplicationArea to all page fields and system parts.
    //    Old:
    //         - Fields without ApplicationArea property.
    //    New:
    //         - ApplicationArea = All added to all fields.
    //         - Added ApplicationArea = All to Links and Notes system parts.
    //         - Complies with BC UI visibility standards.
    //
    // 3. Updated SourceTableView syntax for AL compliance.
    //    Old:
    //         - NAV style sorting/where syntax.
    //    New:
    //         - sorting(Direction, Status)
    //           where(Status = const(Error));
    //         - Verified AL compatible syntax.
    //
    // 4. Replaced legacy NAV object IDs with named object references.
    //    Old:
    //         - RunObject = Page 50009;
    //         - Record 50001;
    //         - Codeunit 50000;
    //         - Record 50000;
    //    New:
    //         - RunObject = Page "Interface Entry Lines";
    //         - Record "Interface Entry Header INT";
    //         - Codeunit "Interface Framework Mgt.";
    //         - Record "Interface Setup INT";
    //         - Removes dependency on numeric object IDs.
    //         - SaaS safe and upgrade compliant.
    //
    // 5. Updated method invocation syntax.
    //    Old:
    //         - Rec.ProcessErrorEntry;
    //         - Rec.ShowErrorMessage;
    //         - Rec.ShowNotes;
    //         - Rec.ShowXmlDocument;
    //    New:
    //         - Rec.ProcessErrorEntry();
    //         - Rec.ShowErrorMessage();
    //         - Rec.ShowNotes();
    //         - Rec.ShowXmlDocument();
    //         - Ensures proper AL method execution.
    //
    // 6. Implemented multi-selection processing using SetSelectionFilter.
    //    Old:
    //         - Direct record reference processing (NAV style).
    //    New:
    //         - CurrPage.SetSelectionFilter(InterfaceEntryHeader);
    //         - InterfaceEntryHeader.MarkedOnly(true);
    //         - Enables multi-record error clearing and log movement.
    //         - BC compliant record handling.
    //
    // 7. Maintained pragma suppression for AA0218.
    //    Old:
    //         - Implicit behavior without explicit suppression.
    //    New:
    //         - #pragma warning disable/restore AA0218 used.
    //         - Prevents compiler warnings for legacy table design during upgrade.
    //
    // BC Upgrade KUMARR78 <<

    Caption = 'Monitor Error Interface Entries';
    Editable = false;
    PageType = List;
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
    SourceTable = "Interface Entry Header INT";
    SourceTableView = sorting(Direction, Status)
                      where(Status = const(Error));

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
                field("Expected Delivery Date"; Rec."Expected Delivery Date") { ApplicationArea = All; }
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
#pragma warning restore AA0218
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                    Image = AllLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    // RunObject = page 50009; BC UPGRDAE KUMARR78 Blocking As old NAV Page ID.
                    RunObject = page "Interface Entry Lines";//BC UPGRDAE KUMARR78 Replacing old NAV Page ID with Variable("Interface Entry Lines")
                    RunPageLink = "Header Entry No." = field("Entry No.");
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
                        Rec.ShowErrorMessage();
                    end;
                }
                action(ClearError)
                {
                    Caption = 'Clear Error';
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Reset the status of the selected entry in order to reprocess it.';

                    trigger OnAction();
                    var
                        // InterfaceEntryHeader: Record "50001"; //BC UPGRDAE KUMARR78 Blocking As Old NAV Record ID Used and Replaced with Latest Object.
                        InterfaceEntryHeader: Record "Interface Entry Header INT"; //BC UPGRDAE KUMARR78 Replacing 50001 Table id.

                    begin
                        CurrPage.SetSelectionFilter(InterfaceEntryHeader);
                        InterfaceEntryHeader.MarkedOnly(true);
                        if InterfaceEntryHeader.FindSet() then
                            repeat
                                InterfaceEntryHeader.ClearError();
                            until InterfaceEntryHeader.Next() = 0;
                        CurrPage.Update();
                    end;
                }
                action(Process)
                {
                    Caption = 'Process';
                    Image = Process;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Process manually the selected entry.';

                    trigger OnAction();
                    begin
                        Rec.ProcessErrorEntry();
                    end;
                }
                action(MoveToLog)
                {
                    Caption = 'Move To Log';
                    Image = Log;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Move entry to log.';

                    trigger OnAction();
                    var
                        // InterfaceEntryHeader: Record "50001"; //BC UPGRDAE KUMARR78 Blocking As Old NAV Record ID Used and Replaced with Latest Object.
                        InterfaceEntryHeader: Record "Interface Entry Header INT"; //BC UPGRDAE KUMARR78 Replacing 50001 Table id.

                        // InterfaceFrameworkMgt: Codeunit "50000";//BC UPGRDAE KUMARR78 Blocking As Old NAV Codeunit ID Used and Replaced with Latest Object.
                        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";//BC UPGRDAE KUMARR78 Replacing 50001 Table id.
                    begin
                        CurrPage.SetSelectionFilter(InterfaceEntryHeader);
                        InterfaceFrameworkMgt.LogErrorInterfaceEntries(InterfaceEntryHeader);
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

                    trigger OnAction();
                    begin
                        Rec.ShowXmlDocument();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.SetRange("Pepperi Interface", true);//HEI.02
    end;

    var
        // InterfaceSetup: Record "50000"; //BC UPGRDAE KUMARR78 Blocking As Old NAV Record ID Used and Replaced with Latest Object.
        InterfaceSetup: Record "Interface Setup INT"; //BC UPGRDAE KUMARR78 Replacing 50000 Table id.

}

