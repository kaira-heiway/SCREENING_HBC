pageextension 58067 PostedReturnReceiptsIntExt extends "Posted Return Receipts"
{
    // HEI.01 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - Zycus Order Line No.
    // HEI.02 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Field - Zycus Movement Type
    //Bc Upgrade YADAVM09 Interface fields Added.
    layout
    {
        addafter("Shipment Date")
        {
            // field("Source System Identifier INT"; Rec."Source System Identifier INT")
            // {
            //     ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            // }
            field("Zycus Order No."; Rec."Zycus Order No. INT")
            {
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }

            field("PO Transaction Interface Zycus"; Rec."PO Transaction IntF. Zycus INT")
            {
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            field("Processed PO Transaction Zycus"; Rec."Processed PO Trans. Zycus INT")
            {
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            field("Zycus GR UUID"; Rec."Zycus GR UUID INT")
            {
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            field("Zycus GR Cancel UUID"; Rec."Zycus GR Cancel UUID INT")
            {
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            field("GR Transaction Interface Zycus"; Rec."GR Transaction Intf. Zycus INT")
            {
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            field("Processed GR Transaction Zycus"; Rec."Processed GR Trans. Zycus INT")
            {
                Visible = false;
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
        }
        addafter("Responsibility Center")
        {
            field("Source System Identifier INT"; Rec."Source System Identifier INT")
            {
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                Caption = 'Created Date/Time';
                ApplicationArea = ALL;
                Editable = false;
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