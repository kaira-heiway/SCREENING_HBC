page 51005 "User Gen. Journal Setup CBN"
{
    // version HEI.01

    // HEI.01 FDD-GAPLOG012 IBM.NAIKH01 14/06/2017
    //   # Created a new Page "User Gen. Journal Setup"

    PageType = List;
    SourceTable = "User Gen. Journal Setup FND";
    ApplicationArea = All;  // BC Upgrade Priya
    UsageCategory = Lists;  // BC Upgrade Priya
    Caption = 'User Gen. Journal Setup';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Journal Type"; Rec."Journal Type")
                {
                    ToolTip = 'Specifies the value of the Journal Type field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Gen. Journal Template Name"; Rec."Gen. Journal Template Name")
                {
                    ToolTip = 'Specifies the value of the Gen. Journal Template Name field.';
                }
            }
        }
    }

    actions
    {
    }
}

