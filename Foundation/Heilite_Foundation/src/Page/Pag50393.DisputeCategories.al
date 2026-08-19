page 50393 "Dispute Categories"
{
    // version HEI.01

    // HEI.01 FDD-HB2071 - CHG2099230 IBM NASTAA02 04.05.2021 # Update Dispute Module in HL
    //   # New Page created for Dispute Categories

    Caption = 'Dispute Categories';
    PageType = List;
    SourceTable = "Dispute Category FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
        area(creation)
        {
            //Caption = 'Actions';  // BC Upgrade NANDIS03
            action("Dispute Reasons")
            {
                Caption = 'Dispute Reasons';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Dispute Reasons";
                RunPageLink = "Dispute Category Code" = FIELD(Code);
                ToolTip = 'Executes the Dispute Reasons action.';
            }
        }
    }
}

