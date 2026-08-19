page 53017 "Gate Entry Stay List"
{
    // version HEI.03
    //BC Upgrade GUNREM01 old page ID-50236
    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"
    // HEI.03 Bugfixing RW IBM NASTAA02 22.10.2018 # Bugfixing Gate Entry RW
    //   # "Weight Difference" should be compared with setup as percentage

    //BC Upgrade GUNREM01 - in action(Card) calling pages are not there

    CaptionML = ENU = 'Gate Entry Stay',
                FRA = 'Gate Entry Stay';
    CardPageID = "Gate Entry Stay";
    Editable = false;
    PageType = List;
    SourceTable = "Gate Entry Header FND";
    SourceTableView = SORTING("Gate Entry Document No.")
                      WHERE("Gate Entry Type" = FILTER(Stay),
                            Registered = FILTER(false));
    ApplicationArea = all;
    UsageCategory = Lists;//BC UPGRADE KUMARR78 FDD-MTC-007


    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = all;
                }
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
                    ApplicationArea = all;
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
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
                    Visible = false;
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date In"; Rec."Date In")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date Out"; Rec."Date Out")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Weight Difference"; Rec."Weight Difference")
                {
                    ApplicationArea = all;
                    StyleExpr = WeightDifferenceStyle;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1100710001; Links)
            {
                Visible = false;
            }
            systempart(Control1100710000; Notes)
            {
                Visible = true;
            }
        }
    }
    //BC Upgrade GUNREM01 >> these pages are not there
    // actions
    // {
    //     area(navigation)
    //     {
    //         group("Gate Entry")
    //         {
    //             Caption = 'Gate Entry';
    //             action(Card)
    //             {
    //                 Caption = 'Card';
    //                 Image = EditLines;

    //                 trigger OnAction();
    //                 begin
    //                     if ("Gate Entry Type" = "Gate Entry Type"::Inbound) and (Registered = false) then
    //                         PAGE.RUNMODAL(80053, Rec);
    //                     if ("Gate Entry Type" = "Gate Entry Type"::Inbound) and (Registered = true) then
    //                         PAGE.RUNMODAL(80051, Rec);
    //                     if ("Gate Entry Type" = "Gate Entry Type"::Outbound) and (Registered = false) then
    //                         PAGE.RUNMODAL(80054, Rec);
    //                     if ("Gate Entry Type" = "Gate Entry Type"::Outbound) and (Registered = true) then
    //                         PAGE.RUNMODAL(80051, Rec);
    //                     if ("Gate Entry Type" = "Gate Entry Type"::Service) and (Registered = false) then
    //                         PAGE.RUNMODAL(80055, Rec);
    //                     if ("Gate Entry Type" = "Gate Entry Type"::Service) and (Registered = true) then
    //                         PAGE.RUNMODAL(80051, Rec);
    //                     if ("Gate Entry Type" = "Gate Entry Type"::Stay) and (Registered = false) then
    //                         PAGE.RUNMODAL(80056, Rec);
    //                     if ("Gate Entry Type" = "Gate Entry Type"::Stay) and (Registered = true) then
    //                         PAGE.RUNMODAL(80051, Rec);
    //                 end;
    //             }
    //         }
    //     }
    // }
    //BC Upgrade GUNREM01 << these pages are not there
    trigger OnAfterGetRecord();
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        WarehouseSetup.GET;
        //IF "Weight Difference" <= WarehouseSetup."Gate Entry Weight Tolerance %" THEN //HEI.03
        if Rec.CheckTolerance then //HEI.03
            WeightDifferenceStyle := FavorableStyle
        else
            WeightDifferenceStyle := UnFavorableStyle;
    end;

    var
        // [InDataSet]
        WeightDifferenceStyle: Text;
        FavorableStyle: Label 'Favorable';
        UnFavorableStyle: Label 'Unfavorable';
}

