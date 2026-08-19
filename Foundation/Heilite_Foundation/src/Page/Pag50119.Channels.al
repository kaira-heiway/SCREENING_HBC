page 50119 Channels
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created
    // 
    // HEI.02 FDD-HLSRM03 IBM LAZARE02 08.09.2017 # New field Allow Purch. Price Change

    Caption = 'Channels';
    PageType = List;
    SourceTable = "Channel FND";
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
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Type ID"; Rec."Type ID")
                {
                    ToolTip = 'Specifies the value of the Type ID field.';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("Allow Purch. Price Change"; Rec."Allow Purch. Price Change")
                {
                    ToolTip = 'Specifies the value of the Allow Purch. Price Change field.';
                }
            }
        }
    }

    actions
    {
    }
}

