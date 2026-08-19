page 54044 "Wort Must Cue Part"
{
    //BC Upgrade GUNREM01 >> FDD DTW 029 Created new Page to add in cue group in role center page.
    PageType = CardPart;
    SourceTable = "Manufacturing Cue";
    ApplicationArea = all;
    Caption = 'Wort/Must Production';

    layout
    {
        area(content)
        {
            cuegroup("Wort/Must Production")
            {
            //    Caption = 'Wort/Must Production';
                field("FPPO – Wort & Must"; Rec."Firm Plan. PO - Brewing FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPPO - Wort & Must';
                    DrillDownPageId = "Firm Planned Prod. Orders - CU";

                }
                field("RPO – Wort & Must"; Rec."Released PO - Brewing FND")
                {
                    ApplicationArea = all;
                    Caption = 'RPO - Wort & Must';
                    DrillDownPageId = "Released Production Orders C";

                }
                field("FPO – Wort & Must"; Rec."Finished PO - Brewing FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPO - Wort & Must';
                    DrillDownPageId = "Finished Production Orders- CU";

                }

            }
        }
    }
}