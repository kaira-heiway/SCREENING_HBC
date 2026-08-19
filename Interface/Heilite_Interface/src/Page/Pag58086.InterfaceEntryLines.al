page 58086 "Interface Entry Lines"
{
    // Heilite Navision Old Id - 50009

    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework

    Caption = 'Interface Entry Lines';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Interface Entry Line INT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {

                }
                field("Source Line No."; Rec."Source Line No.")
                {

                }
                field(Type; Rec.Type)
                {

                }
                field("No."; Rec."No.")
                {

                }
                field("Global No."; Rec."Global No.")
                {
                    Visible = false;

                }
                field(Description; Rec.Description)
                {

                }
                field("Description 2"; Rec."Description 2")
                {

                }
                field(Quantity; Rec.Quantity)
                {

                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {

                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {

                }
                field("Location Code"; Rec."Location Code")
                {

                }
                field("Zone Code"; Rec."Zone Code")
                {

                }
                field("Currency Code"; Rec."Currency Code")
                {

                }
                field("Unit Amount"; Rec."Unit Amount")
                {

                }
                field("Line Amount"; Rec."Line Amount")
                {

                }
                field("VAT %"; Rec."VAT %")
                {

                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {

                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {

                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {

                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {

                }
                field("Cross Reference No."; Rec."Cross Reference No.")
                {

                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {

                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {

                }
                field("Order No."; Rec."Order No.")
                {

                }
                field("Order Line No."; Rec."Order Line No.")
                {

                }
                field("External Requisition No."; Rec."External Requisition No.")
                {

                }
                field("External Requisition Line No."; Rec."External Requisition Line No.")
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
                field("External Contract Line No."; Rec."External Contract Line No.")
                {
                }
                field("Type ID"; Rec."Type ID")
                {
                }
                field(Locked; Rec.Locked)
                {
                }
                field(Closed; Rec.Closed)
                {
                }
                field("Last Changed Date/Time"; Rec."Last Changed Date/Time")
                {
                }
                field("CMG Code"; Rec."CMG Code")
                {
                }
                field("Over Percent"; Rec."Over Percent")
                {
                }
                field("Under Percent"; Rec."Under Percent")
                {
                }
                field("Over Percent Indicator"; Rec."Over Percent Indicator")
                {
                }
                field("Direct Unit Cost Multiplier"; Rec."Direct Unit Cost Multiplier")
                {
                }
                field(Cancelled; Rec.Cancelled)
                {
                }
                field("Delivery Finalized"; Rec."Delivery Finalized")
                {
                }
                field("External Order No."; Rec."External Order No.")
                {
                }
                field("External Order Line No."; Rec."External Order Line No.")
                {
                }
                field("Movement Type"; Rec."Movement Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Direct Cost Per Multiplier"; Rec."Direct Cost Per Multiplier")
                {
                }
                field("Purchasing Organisation"; Rec."Purchasing Organisation")
                {
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                }
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Item Segmentation"; Rec."Item Segmentation")
                {
                    Visible = false;
                }
                field("Certification Required"; Rec."Certification Required")
                {
                    Visible = false;
                }
                field("Rotating Item"; Rec."Rotating Item")
                {
                    Visible = false;
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    Visible = false;
                }
                field("Machine Reference No."; Rec."Machine Reference No.")
                {
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                }
                field("Message ID"; Rec."Message ID")
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
                field("Data Exch. Entry No."; Rec."Data Exch. Entry No.")
                {
                }
                field("SalesPers./Purch. Code"; Rec."SalesPers./Purch. Code")
                {
                }
                field("Truck Code"; Rec."Truck Code")
                {
                }
                field("Driver Code"; Rec."Driver Code")
                {
                }
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
                    PromotedCategory = New;//BC Upgrade VAMSIU01 - Added
                    PromotedIsBig = true;
                    RunObject = Page "Interface Entry Components";//BC Upgrade VAMSIU01 Commented before due to page availablity now it is available so uncommented.
                    RunPageLink = "Header Entry No." = FIELD("Header Entry No."),//BC Upgrade VAMSIU01 Commented before due to page availablity now it is available so uncommented.
                    "Line Entry No." = FIELD("Entry No.");//BC Upgrade VAMSIU01 Commented before due to page availablity now it is available so uncommented.



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
            }
        }
    }
}

