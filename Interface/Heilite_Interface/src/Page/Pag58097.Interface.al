page 58097 Interface
{
    // version HEI 0.1

    // HEI.01 IBM SURYAS01 FDD-HT626 10-jan-2010
    //    # New page
    // BC Upgrade SHUKLP03 >> Nav Page Id - 50414

    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Interface table INT";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists;  // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Interface Dimension 1 Code"; Rec."Interface Dimension 1 Code")
                {
                }
                field("Interface Dimension 2 Code"; Rec."Interface Dimension 2 Code")
                {
                }
                field("Interface Type"; Rec."Interface Type")
                {
                }
                field("Export Path"; Rec."Export Path")
                {
                }
                field("Import Path"; Rec."Import Path")
                {
                }
                field("Response Path"; Rec."Response Path")
                {
                }
                field("Error Path"; Rec."Error Path")
                {
                }
                field("Email Error Address"; Rec."Email Error Address")
                {
                }
                field("Email Error Address 2"; Rec."Email Error Address 2")
                {
                }
                field("Email Error Subject"; Rec."Email Error Subject")
                {
                }
                field("Email Availability Address"; Rec."Email Availability Address")
                {
                }
                field("Email Availability Address 2"; Rec."Email Availability Address 2")
                {
                }
                field("Email Availability Subject"; Rec."Email Availability Subject")
                {
                }
            }
        }
    }

    actions
    {
    }
}

