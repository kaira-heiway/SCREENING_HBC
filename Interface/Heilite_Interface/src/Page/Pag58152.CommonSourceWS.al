page 58152 "Common Source WS"
{
    // HEI.05 FDD-HT1398 CHG2065738 IBM.GUNERE01 16.07.2020 # new Page created
    //Bc Upgrade YADAVM09 Field property Added.
    //Bc Upgrade YADAVM09 Old ID is 50372.

    PageType = List;
    SourceTable = "Global Shared Source FND";
    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field("Global ID"; Rec."Global ID")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field("Local ID"; Rec."Local ID")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field("Company ID"; Rec."Company ID")
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = ALL;//Bc Upgrade YADAVM09<<
                }
            }
        }
    }

    actions
    {
    }
}

