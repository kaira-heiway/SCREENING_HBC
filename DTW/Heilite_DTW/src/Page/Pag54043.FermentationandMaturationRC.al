page 54043 "Fermentation Cue Part"
{

    //BC Upgrade GUNREM01 >> FDD DTW 029 Created new Page to add in cue group in role center page.
    
    PageType = CardPart;
    SourceTable = "Manufacturing Cue";
    ApplicationArea = All;
    Caption = 'Fermentation & Maturation';
    layout
    {
        area(content)
        {
            cuegroup("Fermentation & Maturation")
            {
               // Caption = 'Fermentation & Maturation';
                field("FPPO – Yeast Propagated"; Rec."FPPO - Yeast FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPPO - Yeast Propagated';
                    DrillDownPageId = "FPPO - Yeast";

                }
                field("RPO – Yeast Propagated"; Rec."RPO - Yeast FND")
                {
                    ApplicationArea = all;
                    Caption = 'RPO - Yeast Propagated';
                    DrillDownPageId = "RPO - Yeast";
                }
                field("FPO – Yeast Propagated"; Rec."FPO yeast FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPO - Yeast Propagated';
                    DrillDownPageId = "FPO - Yeast";
                }
                field("FPPO – Green & Mature Beer"; Rec."FPO <> Yeast FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPPO - Green & Mature Beer';
                    DrillDownPageId = "FPO <> Yeast";
                }
                field("RPO – Green & Mature Beer"; Rec."RPO <> Yeast FND")
                {
                    ApplicationArea = all;
                    Caption = 'RPO - Green & Mature Beer';
                    DrillDownPageId = "RPO <> Yeast";
                }
                field("FPO – Green & Mature Beer"; Rec."FPO <> Yeast FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPO - Green & Mature Beer';
                    DrillDownPageId = "FPO <> Yeast";
                }
            }
        }
    }
}