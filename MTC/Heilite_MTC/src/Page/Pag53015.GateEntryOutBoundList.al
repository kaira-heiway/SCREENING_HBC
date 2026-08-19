page 53015 "Gate Entry Outbound List"
{
    // version HEI.04
    //BC Upgrade GUNREM01 old page ID-50234
    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"
    // HEI.03 Bugfixing RW IBM NASTAA02 22.10.2018 # Bugfixing Gate Entry RW
    //   # "Weight Difference" should be compared with setup as percentage
    // HEI.04 CHG2260099 COSTES04 16.10.2024 Automatic Archiving of Gate Entry Outbound While Undoing Sales Shipment.
    //   # New field added Blocked

    //BC Upgrade GUNREM01 - in action(Card) calling pages are not there

    CaptionML = ENU = 'Gate Entry Outbound',
                FRA = 'Gate Entry Outbound';
    CardPageID = "Gate Entry Outbound";
    Editable = false;
    PageType = List;
    SourceTable = "Gate Entry Header FND";
    SourceTableView = SORTING("Gate Entry Document No.")
                      WHERE("Gate Entry Type" = FILTER(Outbound),
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
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = all;
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
    //                     if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Inbound) and (Rec.Registered = false) then
    //                         PAGE.RUNMODAL(80053, Rec)
    //                     if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Inbound) and (Rec.Registered = true) then
    //                         PAGE.RUNMODAL(80051, Rec);
    //                     if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Outbound) and (Rec.Registered = false) then
    //                         PAGE.RUNMODAL(80054, Rec);
    //                     if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Outbound) and (Rec.Registered = true) then
    //                         PAGE.RUNMODAL(80051, Rec);
    //                     if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Service) and (Rec.Registered = false) then
    //                         PAGE.RUNMODAL(80055, Rec);
    //                     if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Service) and (Rec.Registered = true) then
    //                         PAGE.RUNMODAL(80051, Rec);
    //                     if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Stay) and (Rec.Registered = false) then
    //                         PAGE.RUNMODAL(80056, Rec);
    //                     if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Stay) and (Rec.Registered = true) then
    //                         PAGE.RUNMODAL(80051, Rec);
    //                 end;
    //             }
    //         }
    //    }
    //}
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

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        rec.FILTERGROUP(2);
    end;

    var
        //   [InDataSet]
        WeightDifferenceStyle: Text;
        FavorableStyle: Label 'Favorable';
        UnFavorableStyle: Label 'Unfavorable';
}

