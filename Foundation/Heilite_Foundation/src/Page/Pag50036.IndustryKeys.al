page 50036 "Industry Keys"
{
    // version HEI.01

    // HEI.01 FDD–PURGAP05 IBM LAZARE02 08.07.2017 # New page used for MDM data

    Caption = 'Industry Keys';
    PageType = List;
    SourceTable = "Industry Key FND";
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control50005; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control50004; Notes)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

