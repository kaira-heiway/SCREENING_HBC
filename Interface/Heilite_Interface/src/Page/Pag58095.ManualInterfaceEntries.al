page 58095 "Manual Interface Entries"
{
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework
    // BC Upgrade SHUKLP03 >> Nav Page Id - 50090

    Caption = 'Inbound Interface Entries';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Interface Entry Header INT";
    SourceTableView = WHERE(Status = CONST("Manual Entry"));
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    //UsageCategory = Lists; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interface Code"; Rec."Interface Code")
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
                field("Currency Code"; Rec."Currency Code")
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
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
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
                field("External Order No."; Rec."External Order No.")
                {
                }
                field("Type ID"; Rec."Type ID")
                {
                }
                field("Purchasing Organisation"; Rec."Purchasing Organisation")
                {
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
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
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Notes; Rec.Notes)
                {
                }
                field("Your Reference"; Rec."Your Reference")
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
                field("Object Type"; Rec."Object Type")
                {
                }
            }
            part(Lines; "Manual Interf. Entries Subform")
            {
                SubPageLink = "Header Entry No." = FIELD("Entry No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Interface Entry")
            {
                Caption = 'Interface Entry';
                Image = CheckList;
                action(ResetStatus)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Set Status to Pending';
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Create inbound interface entries and set the status to pending';

                    trigger OnAction();
                    begin
                        Rec.SaveManualEntry;
                        CurrPage.UPDATE();
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec.Status := Rec.Status::"Manual Entry";
    end;

    trigger OnOpenPage();
    begin
        Rec.FILTERGROUP(6);
        Rec.SETRANGE(Status, Rec.Status::"Manual Entry");
        Rec.FILTERGROUP(0);
    end;

    var
        TempInterfaceEntryLine: Record "Interface Entry Line INT" temporary;
}

