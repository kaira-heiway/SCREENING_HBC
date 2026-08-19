page 50025 "Dispute Reasons"
{
    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP029 IBM ISYED01 28/06/2017
    //   #Created new Page for Dispute Reasons
    // HEI.02 FDD-HB2071 - CHG2099230 IBM NASTAA02 04.05.2021 # Update Dispute Module in HL
    //   # New Field added: "Dispute Category Code"

    PageType = List;
    SourceTable = "Dispute Reason FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dispute Category Code"; Rec."Dispute Category Code")
                {
                    ToolTip = 'Specifies the value of the Dispute Category Code field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}

