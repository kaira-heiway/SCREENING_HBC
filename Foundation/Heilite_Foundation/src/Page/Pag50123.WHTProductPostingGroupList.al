page 50123 "WHT Product Posting Group List"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 FDD-HT671 IBM BULIMC01 18.02.2020 # new function added: "GetSelectionFilter"

    Caption = 'WHT Product Posting Groups';
    PageType = List;
    SourceTable = "WHT Product Posting Group FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1500000)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies a code for the posting group.',
                                ENA = 'Specifies a code for the posting group.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies a description for the WHT Product posting group.',
                                ENA = 'Specifies a description for the WHT Product posting group.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Setup")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = '&Setup',
                            ENA = '&Setup';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "WHT Posting Setup List";
                RunPageLink = "WHT Product Posting Group" = FIELD(Code);
                ToolTip = 'Executes the &Setup action.';
            }
        }
    }

    procedure GetSelectionFilter(): Text;
    var
        WHTProductPostingGroup: Record "WHT Product Posting Group FND";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        RecRefWHTProductPostingGroup: RecordRef;  // BC Upgrade NANDIS03
    begin
        //HEI.02<<
        CurrPage.SETSELECTIONFILTER(WHTProductPostingGroup);
        //exit(SelectionFilterManagement.GetSelectionFilterForWHTProdPostingGr(WHTProductPostingGroup));  // BC Upgrade NANDIS03
        exit(SelectionFilterManagement.GetSelectionFilter(RecRefWHTProductPostingGroup, 1));  // BC Upgrade NANDIS03
        //HEI.02<<
    end;
}

