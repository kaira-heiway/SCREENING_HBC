page 58034 "Inbound Interface Entries VIP"
{
    // Heilite Navision Old Id - 50366
    // version HEI.07

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Page created
    // HEI.02 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added below fields:50001, 50002, 50003 & 50004 in Page
    // HEI.03 CHG2149734 SAHAL01 01.11.2022
    //   # Added New Fields: 130 - Prod. Order Item No.
    //                       131 - Prod. Order Line No.
    //                       132 - Zone Code
    //                       133 - Bin Code
    //                       135 - Starting Date
    //                       136 - Starting Time
    //                       137 - Starting Date-Time
    //                       138 - EAN
    //                       140 - Quantity
    //   # Added Fields:      15 - Source Status
    //                        28 - Location Code
    //                        26 - External Document No.
    //                        69 - Type ID
    //                       505 - Inbound Interface Entry No.
    // HEI.04 CHG2147859 SAHAL01 02.09.2022
    //   # Added New Fields: 8 - Last Parked Date (Local)
    //                       9 - Last Parked Time (Local)
    // HEI.05 CHG2194603 SISUM01 14.11.2023 HB3289-Electronic invoice interface Panama
    //   # add new field id - 700 - URL
    // HEI.06 CHG2210794 SAHAL01 07.12.2023 Zycus - BASE HL Integration Master Dimension
    //   # Added Field: 19 - Sell-to Customer No.
    // HEI.07 CHG2210794 SAHAL01 19.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Added New Fields: 50 - Action Code
    //                       53 - External Order No.
    //                       54 - External Order Line No.
    //                       56 - Shipment Method Location
    //                       57 - Salesperson/Purchaser Code
    //                       58 - Contact

    Caption = 'Inbound Interface Entries VIP';
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Interface Entry Header VIP INT";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending)
                      WHERE(Direction = CONST(Inbound),
                            Status = FILTER(Pending | Processed));
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
                field("Error Message"; Rec."Error Message")
                {
                    ToolTip = 'Specifies the value of the Error Message field.';
                }
                field("Last Parked Date (Local)"; Rec."Last Parked Date (Local)")
                {
                    ToolTip = 'Specifies the value of the Last Parked Date (Local) field.';
                }
                field("Last Parked Time (Local)"; Rec."Last Parked Time (Local)")
                {
                    ToolTip = 'Specifies the value of the Last Parked Time (Local) field.';
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
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
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
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
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
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
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
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {
                    ToolTip = 'Specifies the value of the Data Exch. Entry No. field.';
                }
                field("Start Execution"; Rec."Start Execution")
                {
                    ToolTip = 'Specifies the value of the Start Execution field.';
                }
                field("End Execution"; Rec."End Execution")
                {
                    ToolTip = 'Specifies the value of the End Execution field.';
                }
                field("Send Request"; Rec."Send Request")
                {
                    ToolTip = 'Specifies the value of the Send Request field.';
                }
                field("Get Response"; Rec."Get Response")
                {
                    ToolTip = 'Specifies the value of the Get Response field.';
                }
                field("Prod. Order Item No."; Rec."Prod. Order Item No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Item No. field.';
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Line No. field.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ToolTip = 'Specifies the value of the Zone Code field.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ToolTip = 'Specifies the value of the Starting Time field.';
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ToolTip = 'Specifies the value of the Starting Date-Time field.';
                }
                field(EAN; Rec.EAN)
                {
                    ToolTip = 'Specifies the value of the EAN field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Type ID"; Rec."Type ID")
                {
                    ToolTip = 'Specifies the value of the Type ID field.';
                }
                field("Inbound Interface Entry No."; Rec."Inbound Interface Entry No.")
                {
                    ToolTip = 'Specifies the value of the Inbound Interface Entry No. field.';
                }
                field(URL; Rec.URL)
                {
                    ExtendedDatatype = URL;
                    Visible = false;
                    ToolTip = 'Specifies the value of the URL field.';
                }
                field("Action Code"; Rec."Action Code")
                {
                    ToolTip = 'Specifies the value of the Action Code field.';
                }
                field("External Order No."; Rec."External Order No.")
                {
                    ToolTip = 'Specifies the value of the External Order No. field.';
                }
                field("External Order Line No."; Rec."External Order Line No.")
                {
                    ToolTip = 'Specifies the value of the External Order Line No. field.';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location")
                {
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field("Salesperson/Purchaser Code"; Rec."Salesperson/Purchaser Code")
                {
                    ToolTip = 'Specifies the value of the Salesperson/Purchaser Code field.';
                }
                field(Contact; Rec.Contact)
                {
                    ToolTip = 'Specifies the value of the Contact field.';
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
                    RunObject = Page "Interface Entry Lines VIP";
                    RunPageLink = "Header Entry No." = FIELD("Entry No.");
                    ToolTip = 'Executes the Lines action.';
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
                        Rec.ProcessManually();
                    end;
                }
                action(MoveToLog)
                {
                    Caption = 'Move to Log';
                    Image = Log;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Move to Log action.';

                    trigger OnAction();
                    var
                        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
                        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
                    begin
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeaderVIP);
                        InterfaceFrameworkMgtVIP.LogErrorInterfaceEntries(InterfaceEntryHeaderVIP);
                    end;
                }
            }
        }
    }
}

