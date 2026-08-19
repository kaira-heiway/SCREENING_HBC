page 50081 "SRM Contract Types"
{
    // version HEI.01

    // HEI.01 HLSRM02 IBM LAZARE02 31.07.2017 # New page

    Caption = 'SRM Contract Types';
    PageType = List;
    SourceTable = "SRM Contract Type FND";
    ApplicationArea = All;  // BC Upgrade SHARMP16
    UsageCategory = Lists;  // BC Upgrade SHARMP16
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
                field("Allow Over Consumption on Qty."; Rec."Allow Over Consumption on Qty.")
                {
                    ToolTip = 'Specifies the value of the Allow Over Consumption on Quantity field.';
                }
                field("Allow Over Consumption on Amt."; Rec."Allow Over Consumption on Amt.")
                {
                    ToolTip = 'Specifies the value of the Allow Over Consumption on Amount field.';
                }
            }
        }
    }

    actions
    {
    }
}

