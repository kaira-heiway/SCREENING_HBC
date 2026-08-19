page 58017 "EBM Document Types"
{
    // Heilite Navision Old Id - 50249
    // version HEI.01

    // HEI.01 RW-GAPLOG08 IBM LAZARE02 31.10.2018 # New page for EBM interface

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "EBM Document Type" to "EBM Document Type FND"
    // BC UPGRADE PATELS08 <<

    PageType = List;
    SourceTable = "EBM Document Type FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document Subtype Code"; Rec."Document Subtype Code")
                {
                    ToolTip = 'Specifies the value of the Document Subtype Code field.';
                }
                field("Customer Tax Group Code"; Rec."Customer Tax Group Code")
                {
                    ToolTip = 'Specifies the value of the Customer Tax Group Code field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(ItemCharges)
            {
                Caption = 'Item Charges';
                Image = CheckRulesSyntax;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "EBM Item Charges";
                ToolTip = 'Executes the Item Charges action.';
                // RunPageLink = "Document Type" = FIELD("Document Type"),
                //               "Document Subtype Code" = FIELD("Document Subtype Code"),
                //               "Customer Tax Group Code" = FIELD("Customer Tax Group Code");  // BC Upgrade NANDIS03 - Blocked as dependent on Aptean
            }
        }
    }
}

