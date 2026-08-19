page 58003 "Interface Log Comp. Details"
{
    // Heilite Navision Old Id - 50018
    // version HEI.01

    Caption = 'Interface Log Component Details';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Log Comp. Detail INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Field ID"; Rec."Field ID")
                {
                    ToolTip = 'Specifies the value of the Field ID field.';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the value of the Field Caption field.';
                }
                field("Incoming Value"; Rec."Incoming Value")
                {
                    ToolTip = 'Specifies the value of the Incoming Value field.';
                }
                field(Value; Rec.Value)
                {
                    ToolTip = 'Specifies the value of the Value field.';
                }
            }
        }
    }

    actions
    {
    }
}

