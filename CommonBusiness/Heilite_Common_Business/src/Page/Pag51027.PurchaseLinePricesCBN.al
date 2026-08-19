page 51027 "Purchase Line Prices CBN"
{
    // version HEI.01

    // HEI.01 HLSRM02 IBM LAZARE02 28.07.2017 # New page

    Caption = 'Purchase Line Prices';
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Line Price FND";
    ApplicationArea = ALL; //BC Upgrade Priya <<
    UsageCategory = Lists; //BC Upgrade Priya <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SRM Contract No."; Rec."SRM Contract No.")
                {
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Line No."; Rec."SRM Contract Line No.")
                {
                    ToolTip = 'Specifies the value of the SRM Contract Line No. field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ToolTip = 'Specifies the value of the Minimum Quantity field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Direct Unit Cost Multiplier"; Rec."Direct Unit Cost Multiplier")
                {
                    ToolTip = 'Specifies the value of the Direct Unit Cost Multiplier field.';
                }
                field("Direct Cost Per Multiplier"; Rec."Direct Cost Per Multiplier")
                {
                    ToolTip = 'Specifies the value of the Direct Cost Per Multiplier field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Direct Unit Cost field.';
                }
            }
        }
    }

    actions
    {
    }
}

