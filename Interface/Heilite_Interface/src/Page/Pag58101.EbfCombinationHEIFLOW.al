page 58101 EbfCombination_HEIFLOW
{
    // version HEI.01

    // HEI.01 CHG2132929 IBM POENAB02 18.03.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50278

    Editable = false;
    PageType = List;
    SourceTable = "Ebf Combination FND";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("GL Account No."; Rec."GL Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general ledger account number associated with the combination.';
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension code associated with the combination.';
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension value code associated with the combination.';
                }
                field("Combination Restriction"; Rec."Combination Restriction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any restrictions applied to the combination.';
                }
            }
        }
    }

    actions
    {
    }
}

