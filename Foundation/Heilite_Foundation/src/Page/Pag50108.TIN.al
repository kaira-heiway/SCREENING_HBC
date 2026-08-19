page 50108 TIN
{
    // version HEI.01

    // HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Page created

    Caption = 'TIN';
    PageType = List;
    SourceTable = "TIN FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("TIN Code"; Rec."TIN Code")
                {
                    ToolTip = 'Specifies the value of the TIN Code field.';
                }
                field("TIN No."; Rec."TIN No.")
                {
                    ToolTip = 'Specifies the value of the TIN No. field.';
                }
            }
        }
    }

    actions
    {
    }
}

