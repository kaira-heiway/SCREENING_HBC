page 52025 "PO/NPO/EXP PurchCMArch Subform"
{
    // version NAVW110.0,HEI.02

    // HEI.01 FDD PTPGAP081 IBM POSTOI01 07.05.2018
    //   #change name of the page : PO/NPO/EXP PurchCMArch Lines
    // HEI.02 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added - "TIN No."

    // BC Upgrade KUMARR78 >>
    //
    // Old Page ID and Name:
    //     50055 "PO/NPO/EXP PurchCMArch Subform"
    //
    // 1. Added ApplicationArea property at page level.
    //    Old:
    //         - ApplicationArea property was not defined at page level.
    //    New:
    //         - ApplicationArea = All;
    //
    // 2. Modified layout fields to use Rec explicitly.
    //    Old:
    //         - Fields in repeater were defined without explicit Rec reference.
    //           Example:
    //               field("No."; "No.")
    //    New:
    //         - All layout fields updated to use Rec reference.
    //           Example:
    //               field("No."; Rec."No.")
    //
    // 3. Removed "Cross-Reference No." field from layout.
    //    Old:
    //         - Field present in layout:
    //               field("Cross-Reference No."; "Cross-Reference No.")
    //               {
    //                   Visible = false;
    //               }
    //    New:
    //         - Field commented and blocked as it is not available in Business Central.
    // BC Upgrade KUMARR78 <<

    Caption = 'Deleted Purch CM Archive Lines';
    Editable = false;
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Purchase Line Archive";
    SourceTableView = where("Document Type" = const("Credit Memo"));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                //BC UPGRADE KUMARR78 >> Blocking As Field Removed
                // field("Cross-Reference No."; Rec."Cross-Reference No.")
                // {
                //     Visible = false;
                // }
                //BC UPGRADE KUMARR78 << Blocking As Field Removed
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Visible = false;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    Visible = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    Visible = false;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    BlankZero = true;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    BlankZero = true;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    BlankZero = true;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Visible = false;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Visible = false;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                }
                field("Order Date"; Rec."Order Date")
                {
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Visible = false;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Visible = false;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    Visible = false;
                }
                field(Finished; Rec.Finished)
                {
                    Visible = false;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("TIN No."; Rec."TIN No. FND")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = tabledata Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction();
                    begin
                        Rec.ShowLineComments();
                    end;
                }
                action(DeferralSchedule)
                {
                    Caption = 'Deferral Schedule';
                    Image = PaymentPeriod;

                    trigger OnAction();
                    begin
                        Rec.ShowDeferrals();
                    end;
                }
            }
        }
    }
}

