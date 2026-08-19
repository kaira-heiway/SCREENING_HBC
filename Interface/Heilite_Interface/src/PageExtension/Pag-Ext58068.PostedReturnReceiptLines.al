pageextension 58068 PostedReturnReceiptLinesIntExt extends "Posted Return Receipt Lines"
{
    // HEI.01 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - Zycus Order Line No.
    // HEI.02 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Field - Zycus Movement Type

    //Bc Upgrade YADAVM09 Interface field added.

    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                Visible = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                Visible = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                Visible = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}