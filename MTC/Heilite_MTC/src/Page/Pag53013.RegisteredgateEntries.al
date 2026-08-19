page 53013 "Registered Gate Entries"
{
    // version HEI.02
    //BC Upgrade GUNREM01 Old page ID-50232
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"
    // HEI.03 FDD-CHG2024489 Gate Control IBM SAXENS01  06.11.2019
    //   # Added new Action "Print Registered Gate Report"

    CardPageID = "Registered Gate Entry";
    Editable = false;
    PageType = List;
    SourceTable = "Gate Entry Header FND";
    SourceTableView = SORTING("Gate Entry Document No.")
                      ORDER(Ascending)
                      WHERE(Registered = CONST(true));
    ApplicationArea = all;
    UsageCategory = Lists;//BC UPGRADE KUMARR78 FDD-MTC-007

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Gate Entry Document No."; Rec."Gate Entry Document No.")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry Type"; Rec."Gate Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Date Out"; Rec."Date Out")
                {
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }
                field("Gate Keeper ID"; Rec."Gate Keeper ID")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ApplicationArea = all;
                }
                field("Date In"; Rec."Date In")
                {
                    ApplicationArea = all;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = all;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Gate)
            {
                CaptionML = ENU = 'Gate',
                            FRA = 'Gate';
                action("Print Registered Gate Report")
                {
                    Caption = 'Print Registered Gate Report';
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        GateEntryHeader: Record "Gate Entry Header FND";
                    begin
                        //HEI.03
                        GateEntryHeader.FINDFIRST;
                        GateEntryHeader.SETRANGE(GateEntryHeader.Registered, true);
                        REPORT.RUN(REPORT::"Gate Entry Detail", true, false, GateEntryHeader);
                        //HEI.03
                    end;
                }
            }
        }
    }
}

