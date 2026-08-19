page 58100 DefaultDim_HEIFLOW
{
    // version HEI.01

    // HEI.01 CHG2132929 IBM POENAB02 18.03.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50277

    Editable = false;
    PageType = List;
    SourceTable = "Default Dimension";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the table associated with the default dimension.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique number of the default dimension entry.';
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension code associated with the default dimension.';
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension value code associated with the default dimension.';
                }
                field("Value Posting"; Rec."Value Posting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether value posting is enabled for the default dimension.';
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the caption of the table associated with the default dimension.';
                }
                field("Multi Selection Action"; Rec."Multi Selection Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the action to be taken for multi-selection of dimension values.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budgeted amount for the default dimension.';
                }
            }
        }
    }

    actions
    {
    }
}

