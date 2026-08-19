page 58020 "Bank Conn. Interface Setup"
{
    // Heilite Navision Old Id - 50260

    // version HEI.01

    // HEI.01 V1.05 HT84 IBM POENAB02 19.03.2019 # New page for Bank Connectivity interface
    // HEI.02 CHG2020184 IBM POENAB02 26.06.2019 Bank Connectivity interface
    //   # New fields:
    //     # 4 CAMT053 Inbound Interface
    //     # 5 MT940 Inbound Interface

    SourceTable = "Bank Conn. Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration; // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Non-SEPA Outbound Interface"; Rec."Non-SEPA Outbound Interface")
                {
                    ToolTip = 'Specifies the value of the Non-SEPA Outbound Interface field.';
                }
                field(SNDPRN; REc.SNDPRN)
                {
                    ToolTip = 'Specifies the value of the SNDPRN field.';
                }
                field("CAMT053 Inbound Interface"; Rec."CAMT053 Inbound Interface")
                {
                    ToolTip = 'Specifies the value of the CAMT053 Inbound Interface field.';
                }
                field("MT940 Inbound Interface"; Rec."MT940 Inbound Interface")
                {
                    ToolTip = 'Specifies the value of the MT940 Inbound Interface field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(DocumentTypes)
            {
                Caption = 'Document Types';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "EBM Document Types";
                ToolTip = 'Executes the Document Types action.';
            }
        }
    }
}

