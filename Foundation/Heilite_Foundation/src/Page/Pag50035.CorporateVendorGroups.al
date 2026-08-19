page 50035 "Corporate Vendor Groups"
{
    // version HEI.01

    // HEI.01 FDD–PURGAP05 IBM LAZARE02 08.07.2017 # New page used for MDM data

    Caption = 'Corporate Vendor Groups';
    PageType = List;
    SourceTable = "Corporate Vendor Group FND";
    ApplicationArea = All;
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

