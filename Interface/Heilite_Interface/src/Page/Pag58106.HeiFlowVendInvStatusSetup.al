page 58106 "HeiFlow-Vend.Inv.Status Setup"
{
    // version HEI.01

    // HEI.01 CHG2144425 IBM POENAB02 26.05.2022 HeiLite Vendor Invoice Status| Automation for Caribbean OpCo’s SSC
    //   #Object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50491


    // BC UPGRADE PATELS08 >>
    // # Table name changed from "HeiFlow-Vend.Inv.Status Setup" to "HeiFlow Vend Inv Status FND".
    // BC UPGRADE PATELS08 <<

    Caption = 'HeiFlow - Vend. Inv. Status Setup';
    PageType = List;
    SourceTable = "HeiFlow Vend Inv Status FND";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Status ID"; Rec."Status ID")
                {
                    ToolTip = 'Specifies the unique identifier for the status.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the status.';
                }
                field("External Doc. No."; Rec."External Doc. No.")
                {
                    ToolTip = 'Specifies the external document number associated with the status.';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ToolTip = 'Specifies the payment status of the vendor invoice.';
                }
                field(Open; Rec.Open)
                {
                    ToolTip = 'Indicates whether the vendor invoice is open.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the type of document associated with the vendor invoice.';
                }
                field("Batch Payment Name"; Rec."Batch Payment Name")
                {
                    ToolTip = 'Specifies the name of the batch payment associated with the vendor invoice.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Indicates whether the vendor invoice is on hold.';
                }
                field("Closed by Entry No."; Rec."Closed by Entry No.")
                {
                    ToolTip = 'Specifies the entry number that closed the vendor invoice.';
                }
            }
        }
    }

    actions
    {
    }
}

