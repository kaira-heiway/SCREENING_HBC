page 51019 "Risk Grades CBN"
{
    // version HEI.02

    // HEI.02 FDD-OTCGAP075 IBM NASTAA02 15.05.2018 # No dependency between respective credit risk Master Date fields in the system
    //   # New Fields added: "Lower Margin" and "Upper Margin"
    //   # User should not be allowed to modify the "Code" and the "Decription" of any Risk Grade
    //   # User should not be allowed to modify the "Lower Margin" and the "Upper Margin" for Risk Code = "YW0"
    //   # User should not be allowed to modify the "Upper Margin" for Risk Code = "YW1"
    //   # User should not be allowed to modify the "Lower Margin" for Risk Code = "YW6"

    PageType = List;
    SourceTable = "Risk Grade FND";
    ApplicationArea = All;  // BC Upgrade Priya
    UsageCategory = Lists;  // BC Upgrade Priya


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Lower Margin"; Rec."Lower Margin")
                {
                    Description = 'HEI.02';
                    Editable = NOT LowerMarginNotEditable;
                    ToolTip = 'Specifies the value of the Lower Margin field.';
                }
                field("Upper Margin"; Rec."Upper Margin")
                {
                    Description = 'HEI.02';
                    Editable = NOT UpperMarginNotEditable;
                    ToolTip = 'Specifies the value of the Upper Margin field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin
        //HEI.02>>
        LowerMarginNotEditable := Rec.Code in ['YW0', 'YW6'];
        UpperMarginNotEditable := Rec.Code in ['YW0', 'YW1'];
        //HEI.02<<
    end;

    var
        LowerMarginNotEditable: Boolean;
        UpperMarginNotEditable: Boolean;
}

