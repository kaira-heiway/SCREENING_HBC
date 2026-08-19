namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

pageextension 58023 BlanketPurchOrderSubform2Ext extends "Blanket Purch.Ord Subform2 CBN"
{
    // BC Upgrade SHUKLP03 >>
    // HEI.01 HLSRM02 IBM LAZARE02 27.07.2017
    //   # New fields for SRM integration
    //   # New action Prices for SRM integration
    //   # New action Notes for SRM integration
    // BC Upgrade SHUKLP03 <<

    layout
    {
        // addafter("ShortcutDimCode[8]")
        // {
        //     field("SRM Contract No."; Rec."SRM Contract No.")
        //     {
        //         Editable = false;
        //     }
        //     field("SRM Contract Line No."; Rec."SRM Contract Line No.")
        //     {
        //         Editable = false;
        //     }
        //     field("SRM Contract Type"; Rec."SRM Contract Type")
        //     {
        //         Editable = false;
        //     }

        //}

    }
    actions
    {
        addafter("Posted Lines")
        {
            action(Prices)
            {
                Caption = 'Prices';
                Image = Price;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                RunObject = Page "Purchase Line Prices CBN";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("Document No."),
                                  "Document Line No." = FIELD("Line No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Prices action.';
            }
        }
        addafter("Co&mments")
        {
            action(Notes)
            {
                Caption = 'Notes';
                Image = Notes;
                RunObject = Page "Purchase Line Notes CBN";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("Document No."),
                                  "Line No." = FIELD("Line No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Notes action.';
            }
        }

    }
}
