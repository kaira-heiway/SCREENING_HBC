page 50238 "Local Vendor Types"
{
    // version HEI.01

    // HEI.01 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM LAZARE02 16.10.2018
    //  # New page Created

    Caption = 'Local Vendor Types';
    PageType = List;
    SourceTable = "Local Vendor Type FND";
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
                Visible = false;
            }
            systempart(Control50004; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

