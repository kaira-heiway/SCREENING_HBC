page 58001 "Interface Log Lines"
{
    // Heilite Navision Old Id - 50012
    // version HEI.02

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework
    // HEI.02 CHG2162715 HB3020 KOROLA04 28.11.2022
    //   # Reference - field added

    Caption = 'Interface Log Lines';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Log Line INT";
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
                field("Source Line No."; Rec."Source Line No.")
                {
                    ToolTip = 'Specifies the value of the Source Line No. field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Global No."; Rec."Global No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ToolTip = 'Specifies the value of the Zone Code field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ToolTip = 'Specifies the value of the Unit Amount field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ToolTip = 'Specifies the value of the VAT % field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the value of the Requested Receipt Date field.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the value of the Expected Receipt Date field.';
                }
                field("Cross Reference No."; Rec."Cross Reference No.")
                {
                    ToolTip = 'Specifies the value of the Cross Reference No. field.';
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ToolTip = 'Specifies the value of the Blanket Order No. field.';
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Blanket Order Line No. field.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Order Line No. field.';
                }
                field("External Requisition No."; Rec."External Requisition No.")
                {
                    ToolTip = 'Specifies the value of the External Requisition No. field.';
                }
                field("External Requisition Line No."; Rec."External Requisition Line No.")
                {
                    ToolTip = 'Specifies the value of the External Requisition Line No. field.';
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
                field("External Contract Line No."; Rec."External Contract Line No.")
                {
                    ToolTip = 'Specifies the value of the External Contract Line No. field.';
                }
                field("Type ID"; Rec."Type ID")
                {
                    ToolTip = 'Specifies the value of the Type ID field.';
                }
                field(Locked; Rec.Locked)
                {
                    ToolTip = 'Specifies the value of the Locked field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("Last Changed Date/Time"; Rec."Last Changed Date/Time")
                {
                    ToolTip = 'Specifies the value of the Last Changed Date/Time field.';
                }
                field("CMG Code"; Rec."CMG Code")
                {
                    ToolTip = 'Specifies the value of the CMG Code field.';
                }
                field("Over Percent"; Rec."Over Percent")
                {
                    ToolTip = 'Specifies the value of the Over Percent field.';
                }
                field("Under Percent"; Rec."Under Percent")
                {
                    ToolTip = 'Specifies the value of the Under Percent field.';
                }
                field("Over Percent Indicator"; Rec."Over Percent Indicator")
                {
                    ToolTip = 'Specifies the value of the Over Percent Indicator field.';
                }
                field("Direct Unit Cost Multiplier"; Rec."Direct Unit Cost Multiplier")
                {
                    ToolTip = 'Specifies the value of the Direct Unit Cost Multiplier field.';
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ToolTip = 'Specifies the value of the Cancelled field.';
                }
                field("Delivery Finalized"; Rec."Delivery Finalized")
                {
                    ToolTip = 'Specifies the value of the Delivery Finalized field.';
                }
                field("External Order No."; Rec."External Order No.")
                {
                    ToolTip = 'Specifies the value of the External Order No. field.';
                }
                field("External Order Line No."; Rec."External Order Line No.")
                {
                    ToolTip = 'Specifies the value of the External Order Line No. field.';
                }
                field("Movement Type"; Rec."Movement Type")
                {
                    ToolTip = 'Specifies the value of the Movement Type field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Direct Cost Per Multiplier"; Rec."Direct Cost Per Multiplier")
                {
                    ToolTip = 'Specifies the value of the Direct Cost Per Multiplier field.';
                }
                field("Purchasing Organisation"; Rec."Purchasing Organisation")
                {
                    ToolTip = 'Specifies the value of the Purchasing Organisation field.';
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ToolTip = 'Specifies the value of the Cost Center Code field.';
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'Specifies the value of the Project Code field.';
                }
                field("Item Segmentation"; Rec."Item Segmentation")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Item Segmentation field.';
                }
                field("Certification Required"; Rec."Certification Required")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Certification Required field.';
                }
                field("Rotating Item"; Rec."Rotating Item")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Rotating Item field.';
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Item Tracking Code field.';
                }
                field("Machine Reference No."; Rec."Machine Reference No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Machine Reference No. field.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name field.';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address field.';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address 2 field.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the value of the Ship-to City field.';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Post Code field.';
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Country/Region Code field.';
                }
                field("Message ID"; Rec."Message ID")
                {
                    ToolTip = 'Specifies the value of the Message ID field.';
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
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {
                    ToolTip = 'Specifies the value of the Data Exch. Entry No. field.';
                }
                field("SalesPers./Purch. Code"; Rec."SalesPers./Purch. Code")
                {
                    ToolTip = 'Specifies the value of the SalesPers./Purch. Code field.';
                }
                field("Truck Code"; Rec."Truck Code")
                {
                    ToolTip = 'Specifies the value of the Truck Code field.';
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ToolTip = 'Specifies the value of the Driver Code field.';
                }
                field(Reference; Rec.Reference)
                {
                    ToolTip = 'Specifies the value of the Reference field.';
                }
                // BC Upgrade BHARDA11 >> April2026
                field("Header Entry No."; Rec."Header Entry No.")
                {
                    ApplicationArea = All;
                }
                // BC Upgrade BHARDA11 << 27April2026
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Line)
            {
                Caption = 'Line';
                Image = "Action";
                action(Components)
                {
                    Caption = 'Components';
                    Image = AllLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Interface Log Components";
                    RunPageLink = "Header Entry No." = FIELD("Header Entry No."),
                                  "Line Entry No." = FIELD("Entry No.");
                    ToolTip = 'Executes the Components action.';
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
            }
        }
    }

    var
        BlobIsEmpty: Label 'The entry does not contain any description data.';
}

