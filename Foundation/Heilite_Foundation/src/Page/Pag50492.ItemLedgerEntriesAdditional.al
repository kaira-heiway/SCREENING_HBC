page 50492 "Item Ledger Entries Additional"
{
    // version HEI.01

    // HEI.01 CHG2140470 SAHAL01 08.11.2022 # Created New Page: 50492 - Item Ledger Entries Additional

    Caption = 'Item Ledger Entries Additional';
    PageType = List;
    SourceTable = "Item Ledger Entry Add FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ToolTip = 'Specifies the value of the Item Ledger Entry No. field.';
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ToolTip = 'Specifies the value of the Journal Template Name field.';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';
                }
                field("Actual Posted Consumption"; Rec."Actual Posted Consumption")
                {
                    ToolTip = 'Specifies the value of the Actual Posted Consumption field.';
                }
                field("Actual Posted Lot No."; Rec."Actual Posted Lot No.")
                {
                    ToolTip = 'Specifies the value of the Actual Posted Lot No. field.';
                }
                field("Consumption Suggested"; Rec."Consumption Suggested")
                {
                    ToolTip = 'Specifies the value of the Consumption Suggested field.';
                }
                field("Consumption Allocated"; Rec."Consumption Allocated")
                {
                    ToolTip = 'Specifies the value of the Consumption Allocated field.';
                }
                field("Quantity Allocated"; Rec."Quantity Allocated")
                {
                    ToolTip = 'Specifies the value of the Quantity Allocated field.';
                }
            }
        }
    }

    actions
    {
    }
}

