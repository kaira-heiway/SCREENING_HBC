page 52007 "Purchase Order Overdue Entries"
{
    // version HEI.02

    // HEI.01 CHG2241988 SAHAL01 13.05.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Created New Page: 50605 - Purchase Order Overdue Entries
    // HEI.02 CHG2241988 SAHAL01 05.07.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Added New Fields - Delivery Finalized
    //                      - Last Execution Date-Time
    //                      - Last Executed By
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea Property in Page and fields.
    // 2. Remove this field  "Maximo Requisition No." and add into Interface Extension.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Purchase Order Overdue Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Purch Order Overdue Entry FND";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name 2"; Rec."Buy-from Vendor Name 2")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Document Subtype Code"; Rec."Document Subtype Code")
                {
                    ApplicationArea = All;
                }
                field("Requester ID"; Rec."Requester ID")
                {
                    ApplicationArea = All;
                }
                field("PQ Approver"; Rec."PQ Approver")
                {
                    ApplicationArea = All;
                }
                field("Email To User ID"; Rec."Email To User ID")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Shopping Card No."; Rec."Shopping Card No.")
                {
                    ApplicationArea = All;
                }
                field(Overdue; Rec.Overdue)
                {
                    ApplicationArea = All;
                }
                field("Soon To Be Overdue"; Rec."Soon To Be Overdue")
                {
                    ApplicationArea = All;
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ApplicationArea = All;
                }
                field("Delivery Finalized"; Rec."Delivery Finalized")
                {
                    ApplicationArea = All;
                }
                field("Last Execution Date-Time"; Rec."Last Execution Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Last Executed By"; Rec."Last Executed By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

