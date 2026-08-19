pageextension 58075 PostedReturnShipmentSubfIntExt extends "Posted Return Shipment Subform"
{
    // HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - Zycus Order Line No.
    // HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Field - Zycus Movement Type

    //Bc Upgrade YADAVM09 INterface fields Added.
    layout
    {
        addafter("Consumption SPL Code")
        {
            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                Editable = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                Visible = false;
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }



    var

}