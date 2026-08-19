pageextension 58073 PostedReturnReceiptIntExt extends "Posted Return Receipt"
{
    // HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.05 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus

    //Bc Upgrade YADAVM09 Interface Field Added<<
    layout
    {
        addafter("Shipment Date")
        {
            group("Zycus Interface")
            {
                Caption = 'Zycus Interface';
                Visible = VisibleZycusInterface;
                field("Zycus Order No."; Rec."Zycus Order No. INT")
                {
                    Editable = false;
                    ApplicationArea = all;//Bc Upgrade YADAVM09<<
                }
                group("Zycus PO Interface")
                {
                    Caption = 'Zycus PO Interface';
                    field("PO Transaction Interface Zycus"; Rec."PO Transaction IntF. Zycus INT")
                    {
                        Editable = false;
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<
                    }
                    field("Processed PO Transaction Zycus"; Rec."Processed PO Trans. Zycus INT")
                    {
                        Editable = false;
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<
                    }
                }
                group("Zycus GR Interface")
                {
                    Caption = 'Zycus GR Interface';
                    field("Zycus GR UUID"; Rec."Zycus GR UUID INT")
                    {
                        Editable = false;
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<
                    }
                    field("Zycus GR Cancel UUID"; Rec."Zycus GR Cancel UUID INT")
                    {
                        Editable = false;
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<
                    }
                    field("GR Transaction Interface Zycus"; Rec."GR Transaction Intf. Zycus INT")
                    {
                        Editable = false;
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<
                    }
                    field("Processed GR Transaction Zycus"; Rec."Processed GR Trans. Zycus INT")
                    {
                        Editable = false;
                        ApplicationArea = all;//Bc Upgrade YADAVM09<<
                    }
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetCurrRecord()
    Begin
        //HEI.04>>
        IF ZycusInterfaceSetupL.GET AND ZycusInterfaceSetupL."Enabled Zycus Integration" THEN
            VisibleZycusInterface := TRUE;
        //HEI.04<<
    End;

    var
        VisibleZycusInterface: Boolean;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
}