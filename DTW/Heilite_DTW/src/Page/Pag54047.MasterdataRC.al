page 54047 "Master Data Cue Part"
{
    //BC Upgrade GUNREM01 >> FDD DTW 029 Created new Page to add in cue group in role center page.
    PageType = CardPart;
    SourceTable = "Manufacturing Cue";
    ApplicationArea = All;
    Caption = 'Master Data';
    layout
    {
        area(content)
        {
            cuegroup("Master Data")
            {
                //  Caption = 'Master Data';
                field(Items; Rec."Items FND")
                {
                    ApplicationArea = all;
                }
                field(SKU; Rec."SKU FND")
                {
                    ApplicationArea = All;
                    Caption = 'SKUs';
                }
                field(WorkCenter; Rec."WorkCenter FND")
                {
                    ApplicationArea = All;
                    Caption = 'Work Centers';
                }
                field(Routings; Rec."Routings FND")
                {
                    ApplicationArea = All;
                }
                field("Routing Links"; Rec."Routing Links FND")
                {
                    ApplicationArea = All;
                    Caption = 'Routing Link Codes';
                }
                field(BOM; Rec."BOM FND")
                {
                    Caption = 'BOMs';
                    ApplicationArea = All;
                }
            }
        }
    }
}