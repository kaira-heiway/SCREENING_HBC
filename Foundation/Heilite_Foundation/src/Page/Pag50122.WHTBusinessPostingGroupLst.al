page 50122 "WHT Business Posting Group Lst"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 FDD-HT671 IBM BULIMC01 18.02.2020 #new function created "GetSelectionFilter"

    Caption = 'WHT Business Posting Groups';
    PageType = List;
    SourceTable = "WHT Business Posting Group FND";
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
                    ToolTipML = ENU = 'Specifies a code for the group.',
                                ENA = 'Specifies a code for the group.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies a description for the WHT business posting group.',
                                ENA = 'Specifies a description for the WHT business posting group.';
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
                RunPageLink = "WHT Business Posting Group" = FIELD(Code);
                ToolTip = 'Executes the &Setup action.';
            }
        }
    }

    procedure GetSelectionFilter(): Text;
    var
        WHTBusinessPostingGroup: Record "WHT Business Posting Group FND";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        RecRefWHTBusinessPostingGroup: RecordRef;  // BC Upgrade NANDIS03
    begin
        //HEI.02<<
        CurrPage.SETSELECTIONFILTER(WHTBusinessPostingGroup);
        //exit(SelectionFilterManagement.GetSelectionFilterForWHTBusPostingGr(WHTBusinessPostingGroup));  // BC Upgrade NANDIS03
        exit(SelectionFilterManagement.GetSelectionFilter(RecRefWHTBusinessPostingGroup, 1));  // BC Upgrade NANDIS03
        //HEI.02<<
    end;
}

