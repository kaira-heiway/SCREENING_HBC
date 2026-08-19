page 58107 "Error Interface Entries VIP"
{
    //BC Upgrade VAMSIU01 - NAV Old ID - 50368 - Only added Rec to fields and in Action triggers .

    // version HEI.08

    // HEI.01 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Page created
    // HEI.02 HT1010 IBM NASTAA02 02.12.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # Changed code on Page Actions to use the new VIP table created
    // HEI.03 CHG2112261 IBM SAXENA03 20.05.2021
    //   # Interface Logging processing Execution Time and Webservices Response Times
    //   # Added below fields:50001, 50002, 50003 & 50004 in Page
    // HEI.04 CHG2149734 SAHAL01 01.11.2022
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
    // HEI.05 CHG2147859 SAHAL01 02.09.2022
    //   # Added New Fields: 8 - Last Parked Date (Local)
    //                       9 - Last Parked Time (Local)
    // HEI.06 CHG2194603 SISUM01 14.11.2023 HB3289-Electronic invoice interface Panama
    //   # add new field id - 700 - URL
    // HEI.07 CHG2210794 SAHAL01 07.12.2023 Zycus - BASE HL Integration Master Dimension
    //   # Added Field: 19 - Sell-to Customer No.
    // HEI.08 CHG2210794 SAHAL01 19.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Added New Fields: 50 - Action Code
    //                       53 - External Order No.
    //                       54 - External Order Line No.
    //                       56 - Shipment Method Location
    //                       57 - Salesperson/Purchaser Code
    //                       58 - Contact

    Caption = 'Error Interface Entries VIP';
    Editable = false;
    PageType = List;
    ApplicationArea = All;//BC Upgrade VAMSIU01<<
    UsageCategory = Lists;//BC Upgrade VAMSIU01<<
    SourceTable = "Interface Entry Header VIP INT";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending)
                      WHERE(Status = CONST(Error));

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
                field("Error Message"; Rec."Error Message")
                {
                }
                field("Last Parked Date (Local)"; Rec."Last Parked Date (Local)")
                {
                }
                field("Last Parked Time (Local)"; Rec."Last Parked Time (Local)")
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
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
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
                field(Closed; Rec.Closed)
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
                field("Prod. Order Item No."; Rec."Prod. Order Item No.")
                {
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                }
                field("Zone Code"; Rec."Zone Code")
                {
                }
                field("Bin Code"; Rec."Bin Code")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Starting Time"; Rec."Starting Time")
                {
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                }
                field(EAN; Rec.EAN)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("Type ID"; Rec."Type ID")
                {
                }
                field("Inbound Interface Entry No."; Rec."Inbound Interface Entry No.")
                {
                }
                field(URL; Rec.URL)
                {
                    ExtendedDatatype = URL;
                    Visible = false;
                }
                field("Action Code"; Rec."Action Code")
                {
                }
                field("External Order No."; Rec."External Order No.")
                {
                }
                field("External Order Line No."; Rec."External Order Line No.")
                {
                }
                field("Shipment Method Location"; Rec."Shipment Method Location")
                {
                }
                field("Salesperson/Purchaser Code"; Rec."Salesperson/Purchaser Code")
                {
                }
                field(Contact; Rec.Contact)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control50026; Links)
            {
            }
            systempart(Control50027; Notes)
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
                    PromotedCategory = New;//BC Upgrade VAMSIU01
                    ApplicationArea = All;//BC Upgrade VAMSIU01
                    PromotedIsBig = true;
                    RunObject = Page "Interface Entry Lines VIP";
                    RunPageLink = "Header Entry No." = FIELD("Entry No.");
                }
                action(ShowErrorMessage)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Error Message';
                    Image = Error;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = New;//BC Upgrade VAMSIU01
                    ToolTip = 'Show the error message that has stopped the entry.';

                    trigger OnAction();
                    begin
                        Rec.ShowErrorMessage;
                    end;
                }
                action(ClearError)
                {
                    Caption = 'Clear Error';
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = New;//BC Upgrade VAMSIU01
                    ApplicationArea = All;//BC Upgrade VAMSIU01
                    ToolTip = 'Reset the status of the selected entry in order to reprocess it.';

                    trigger OnAction();
                    var
                        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
                    begin
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeaderVIP); //HEI.02
                        InterfaceEntryHeaderVIP.MARKEDONLY(true);
                        if InterfaceEntryHeaderVIP.FINDSET then
                            repeat
                                InterfaceEntryHeaderVIP.ClearError;
                            until InterfaceEntryHeaderVIP.NEXT = 0;
                        CurrPage.UPDATE;
                    end;
                }
                action(Process)
                {
                    Caption = 'Process';
                    Image = Process;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = New;//BC Upgrade VAMSIU01
                    ApplicationArea = All;//BC Upgrade VAMSIU01
                    ToolTip = 'Process manually the selected entry.';

                    trigger OnAction();
                    begin
                        Rec.ProcessErrorEntry;
                    end;
                }
                action(MoveToLog)
                {
                    Caption = 'Move To Log';
                    Image = Log;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = New;//BC Upgrade VAMSIU01
                    ApplicationArea = All;//BC Upgrade VAMSIU01
                    ToolTip = 'Move entry to log.';

                    trigger OnAction();
                    var
                        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
                        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
                    begin
                        CurrPage.SETSELECTIONFILTER(InterfaceEntryHeaderVIP); //HEI.02
                        InterfaceFrameworkMgtVIP.LogErrorInterfaceEntries(InterfaceEntryHeaderVIP);
                    end;
                }
                action(ShowDescription)
                {
                    Caption = 'Show Description';
                    Image = Description;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;//BC Upgrade VAMSIU01

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
                    ApplicationArea = All;//BC Upgrade VAMSIU01

                    trigger OnAction();
                    begin
                        Rec.ShowXmlDocument;
                    end;
                }
            }
        }
    }
}

