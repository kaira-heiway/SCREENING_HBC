page 54046 "Packaging Cue Part"
{
    //BC Upgrade GUNREM01 >> FDD DTW 029 Created new Page to add in cue group in role center page.
    PageType = CardPart;
    SourceTable = "Manufacturing Cue";
    ApplicationArea = All;
    Caption = 'Packaging';
    layout
    {
        area(content)
        {
            cuegroup("Packaging")
            {
                field("FPPO – Finished Products"; Rec."FPPO - Pack FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPPO - Finished Products';
                    DrillDownPageId = "FPPO - Pack";
                }
                field("RPO – Finished Products"; Rec."RPO - Pack FND")
                {
                    ApplicationArea = all;
                    Caption = 'RPO - Finished Products';
                    DrillDownPageId = "RPO - Pack";
                }
                field("FPO – Finished Products"; Rec."FPO - Pack FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPO - Finished Products';
                    DrillDownPageId = "FPPO - Pack";
                }

            }
        }
    }
}