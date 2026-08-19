pageextension 51229 "G/LBudgetNamesExtCBN" extends "G/L Budget Names"
{
    // BC Upgrade POENAB02, 26.02.2026, gap/fit "BPM045-Plan Version upload and maintenance"
    layout
    {
        addlast(Control1)
        {
            field("Data Version Refrence"; Rec."Data Version Refrence FND")
            {
                ApplicationArea = All;
                Caption = 'Data Version Reference';
                ToolTip = 'Reference to the data version.';
            }
            field("Check When Posting Purch Doc"; Rec."Chk. When Pstg. Purch Doc FND")
            {
                ApplicationArea = All;
                Caption = 'Check When Posting Purch Doc';
                ToolTip = 'Indicates whether to perform a check when posting purchase documents.';
            }
        }
    }

}
