page 58055 "PowerApps Interface Setup"
{
    // Heilite Navision Old Id - 50429

    // HEI.01 CHG2069321 GAVANM01 IBM 13.10.2020 #new page created for PowerApps Interface
    // HEI.02 CHG2094470 HB1870 IBM.GUNERE01 18.06.2021 # "PO Approval Interface Request", "PO Approval Interface Response" fields added

    PageType = Card;
    SourceTable = "PowerApps Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Enable PowerApps Integration"; Rec."Enable PowerApps Integration")
                {
                    ToolTip = 'Specifies the value of the Enable PowerApps Integration field.';
                }
                field("Approval Interface Request"; Rec."Approval Interface Request")
                {
                    ToolTip = 'Specifies the value of the Approval Interface Request field.';
                }
                field("Approval Interface Response"; Rec."Approval Interface Response")
                {
                    ToolTip = 'Specifies the value of the Approval Interface Response field.';
                }
            }
            group("PO Integration")
            {
                Caption = 'PO Integration';
                field("Enable PowerApps PO Intg."; Rec."Enable PowerApps PO Intg.")
                {
                    ToolTip = 'Specifies the value of the Enable PowerApps PO Integration field.';
                }
                field("PO Approval Interface Request"; Rec."PO Approval Interface Request")
                {
                    ToolTip = 'Specifies the value of the PO Approval Interface Request field.';
                }
                field("PO Approval Interface Response"; Rec."PO Approval Interface Response")
                {
                    ToolTip = 'Specifies the value of the PO Approval Interface Response field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.GET() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
    end;
}

