page 54045 "Filtration Cue Part"
{
    //BC Upgrade GUNREM01 >> FDD DTW 029 Created new Page to add in cue group in role center page.
    PageType = CardPart;
    SourceTable = "Manufacturing Cue";
      ApplicationArea = all;
    Caption = 'Filtration & Mixing';
    layout
    {
        area(content)
        {
            cuegroup("Filtration & Mixing")
            {
              //  Caption = 'Filtration & Mixing';
                field("FPPO – Filtration Capacity"; Rec."FPPO - Filtration Capacity FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPPO - Filtration Capacity';
                    DrillDownPageId = "FPPO - Filtration Capacity";
                }
                field("RPO – Filtration Capacity"; Rec."RPO - Filtration Capacity FND")
                {
                    ApplicationArea = all;
                    Caption = 'RPO - Filtration Capacity';
                    DrillDownPageId = "RPO - Filtration Capacity";
                }
                field("FPO – Filtration Capacity"; Rec."FPO - Filtration Capacity FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPO - Filtration Capacity';
                    DrillDownPageId = "FPO - Filtration Capacity";
                }
                field("FPPO – Bright Beverages"; Rec."FPPO <> Filtration Capacit FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPPO - Bright Beverages';
                    DrillDownPageId = "FPPO Filtration Capacity";
                }
                field("RPO – Bright Beverages"; Rec."RPO <> Filtration Capacity FND")
                {
                    ApplicationArea = all;
                    Caption = 'RPO - Bright Beverages';
                    DrillDownPageId = "RPO Filtration Capacity";
                }
                field("FPO – Bright Beverages"; Rec."FPO <> Filtration Capacity FND")
                {
                    ApplicationArea = all;
                    Caption = 'FPO - Bright Beverages';
                    DrillDownPageId = "FPO Filtration Capacity";

                }
            }
        }
    }
}