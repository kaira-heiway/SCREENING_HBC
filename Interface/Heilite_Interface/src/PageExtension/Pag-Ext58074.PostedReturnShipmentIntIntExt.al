pageextension 58074 PostedReturnShipmentIntExt extends "Posted Return Shipment"
{
    // HEI.01 HLSRM02-05 IBM LAZARE02 31.07.2017
    //   #New fields for SRM integration added to SRM tab
    // HEI.02 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field added: "Gate Entry No."
    // HEI.03 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Created new Page Action "Purchase Additional"
    // HEI.04 CHG2024557 FDD-HT821 IBM SHANKJ03
    //   # Created new field "Maximo Status"
    // HEI.05 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.06 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus

    layout
    {
        addafter("Gate Entry No.")
        {
            field("Maximo Status INT"; Rec."Maximo Status INT")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }

        addafter("Foreign Trade")
        {

            group(SRM)
            {
                Caption = 'SRM';
                field("SRM Contract No. INT"; Rec."SRM Contract No. INT")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("SRM Contract Name INT"; Rec."SRM Contract Name INT")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("SRM Contract Type INT"; Rec."SRM Contract Type INT")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field(Channel; Rec."Channel FND")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Contract Closed"; Rec."Contract Closed FND")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("SRM Order No. INT"; Rec."SRM Order No. INT")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Target Value Currency"; Rec."Target Value Currency FND")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                field("Target Value Amount"; Rec."Target Value Amount FND")
                {
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
            }

            group("Zycus Interface")
            {
                Caption = 'Zycus Interface';
                Visible = VisibleZycusInterface;
                field("Zycus Order No. INT"; Rec."Zycus Order No. INT")
                {
                    Editable = false;
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                group("Zycus PO Interface")
                {
                    Caption = 'Zycus PO Interface';
                    field("PO Transaction Intf. Zycus INT"; Rec."PO Transaction Intf. Zycus INT")
                    {
                        Editable = false;
                        ApplicationArea = All;//Bc Upgrade YADAVM09<<
                    }
                    field("Processed PO Trans. Zycus INT"; Rec."Processed PO Trans. Zycus INT")
                    {
                        Editable = false;
                        ApplicationArea = All;//Bc Upgrade YADAVM09<<
                    }
                }
                group("Zycus GR Interface")
                {
                    Caption = 'Zycus GR Interface';
                    field("Zycus GR UUID INT"; Rec."Zycus GR UUID INT")
                    {
                        Editable = false;
                        ApplicationArea = All;//Bc Upgrade YADAVM09<<
                    }
                    field("Zycus GR Cancel UUID INT"; Rec."Zycus GR Cancel UUID INT")
                    {
                        Editable = false;
                        ApplicationArea = All;//Bc Upgrade YADAVM09<<
                    }
                    field("GR Transaction Interface Zycus"; Rec."GR Trans Interf. Zycus INT")
                    {
                        Editable = false;
                        ApplicationArea = All;//Bc Upgrade YADAVM09<<
                    }
                    field("Processed GR Trans. Zycus INT"; Rec."Processed GR Trans. Zycus INT")
                    {
                        Editable = false;
                        ApplicationArea = All;//Bc Upgrade YADAVM09<<
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
    var
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
    begin
        //HEI.05>>
        IF ZycusInterfaceSetupL.GET AND ZycusInterfaceSetupL."Enabled Zycus Integration" THEN
            VisibleZycusInterface := TRUE;
        //HEI.05<<
    end;

    var
        VisibleZycusInterface: Boolean;
}