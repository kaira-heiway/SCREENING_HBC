page 58105 Dimension_HEIFLOW
{
    // version HEI.01

    // HEI.01 CHG2132929 IBM POENAB02 18.03.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50275

    Editable = false;
    PageType = List;
    SourceTable = Dimension;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension code.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the dimension.';
                }
                field("Code Caption"; Rec."Code Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the caption for the dimension code.';
                }
                field("Filter Caption"; Rec."Filter Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the caption for the dimension filter.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the dimension.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the dimension is blocked.';
                }
                field("Consolidation Code"; Rec."Consolidation Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the consolidation code for the dimension.';
                }
                field("Map-to IC Dimension Code"; Rec."Map-to IC Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the intercompany dimension code to which this dimension maps.';
                }
                field("Mandatory Customer"; Rec."Mandatory Customer FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the dimension is mandatory for customers.';
                }
            }
        }
    }

    actions
    {
    }
}

