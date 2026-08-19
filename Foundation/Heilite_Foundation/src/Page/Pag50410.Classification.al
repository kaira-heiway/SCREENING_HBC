page 50410 Classification
{
    // HEI.01 FDD-HT587 IBM BULIMC01 14/10/2019 #new page created

    Caption = 'Classification';
    PageType = List;
    PopulateAllFields = false;
    SourceTable = ClassificationFND;
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

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
    }
}

