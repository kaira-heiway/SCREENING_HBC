page 58090 "Interface Entry Comp. Details"
{
    // version HEI.01
    // BC Upgrade SHUKLP03 >> Nav Page Id - 50017
    Caption = 'Interface Entry Component Details';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Entry Comp.DetailINT";
    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<


    layout
    {
        // BC Upgrade SHUKLP03 >>
        area(content)
        {
            repeater(Group)
            {
                field("Field ID"; Rec."Field ID")
                {
                }
                field("Field Caption"; Rec."Field Caption")
                {
                }
                field("Incoming Value"; Rec."Incoming Value")
                {
                }
                field(Value; Rec.Value)
                {
                }
                field("Is Primary Key"; Rec."Is Primary Key")
                {
                }
            }
        }
        // BC Upgrade SHUKLP03 <<
    }

    actions
    {
    }
}

