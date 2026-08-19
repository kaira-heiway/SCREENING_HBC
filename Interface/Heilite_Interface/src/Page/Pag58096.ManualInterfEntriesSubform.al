page 58096 "Manual Interf. Entries Subform"
{
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework
    // BC Upgrade SHUKLP03 >> Nav Page Id - 50091

    // BC Upgrade MISHRS14 >>
    // Changed page type from ListPart to ListPlus to remove the warning in action-Components (Promoted = true; PromotedIsBig = true).
    // BC Upgrade MISHRS14 <<


    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart; // BC Upgrade SHUKLP03 <<
    SourceTable = "Interface Entry Line INT";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Line No."; Rec."Source Line No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
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
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
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
                field("Zone Code"; Rec."Zone Code")
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
                field("External Order No."; Rec."External Order No.")
                {
                }
                field("External Order Line No."; Rec."External Order Line No.")
                {
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                }
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Delivery Finalized"; Rec."Delivery Finalized")
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
                    //Promoted = true;
                    //PromotedIsBig = true;
                    RunObject = Page "Interface Entry Components";
                    RunPageLink = "Header Entry No." = FIELD("Header Entry No."),
                                  "Line Entry No." = FIELD("Entry No.");
                }
            }
        }
    }

    var
        HeaderEntryNo: Integer;
}

