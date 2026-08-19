page 50221 "Gate Entry List"
{
    // version HEI.04

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"
    // HEI.03 Bugfixing RW IBM NASTAA02 22.10.2018 # Bugfixing Gate Entry RW
    //   # "Weight Difference" should be compared with setup as percentage
    // HEI.04 Defect #4775 IBM NASTAA02 23.10.2019 # Not possible to open Gate Entry Card
    //   # Changed code on Page Action "Card"

    CaptionML = ENU = 'Gate Entry List',
                FRA = 'Gate Entry List';
    Editable = false;
    PageType = List;
    SourceTable = "Gate Entry Header FND";
    SourceTableView = sorting("Gate Entry Document No.");
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Registered field.';
                }
                field("Gate Entry Document No."; Rec."Gate Entry Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Gate Entry Document No. field.';
                }
                field("Gate Entry Type"; Rec."Gate Entry Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Gate Entry Type field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Zone Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Gate Keeper ID"; Rec."Gate Keeper ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Gate Keeper ID field.';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Driver Code field.';
                }
                field("Date In"; Rec."Date In")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Date In field.';
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Time In field.';
                }
                field("Date Out"; Rec."Date Out")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Date Out field.';
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Time Out field.';
                }
                field(WeightDifference2; Rec."Weight Difference")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = WeightDifferenceStyle;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Weight Difference field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1100710001; Links)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            systempart(Control1100710000; Notes)
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Gate Entry")
            {
                Caption = 'Gate Entry';
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    ToolTip = 'Executes the Card action.';

                    trigger OnAction();
                    begin
                        //HEI.04>>
                        //BC UPGRADE KUMARR78 FDD-MTC-007--

                        // if (Rec."Gate Entry Type" = rec."Gate Entry Type"::Inbound) and (rec.Registered = false) then
                        //     PAGE.RUNMODAL(50224, Rec);
                        // if (rec."Gate Entry Type" = rec."Gate Entry Type"::Inbound) and (rec.Registered = true) then
                        //     PAGE.RUNMODAL(50222, Rec);
                        // if (rec."Gate Entry Type" = rec."Gate Entry Type"::Outbound) and (rec.Registered = false) then
                        //     PAGE.RUNMODAL(50225, Rec);
                        // if (rec."Gate Entry Type" = rec."Gate Entry Type"::Outbound) and (rec.Registered = true) then
                        //     PAGE.RUNMODAL(50222, Rec);
                        // if (rec."Gate Entry Type" = rec."Gate Entry Type"::Service) and (rec.Registered = false) then
                        //     PAGE.RUNMODAL(50226, Rec);
                        // if (rec."Gate Entry Type" = rec."Gate Entry Type"::Service) and (rec.Registered = true) then
                        //     PAGE.RUNMODAL(50222, Rec);
                        // if (rec."Gate Entry Type" = rec."Gate Entry Type"::Stay) and (rec.Registered = false) then
                        //     PAGE.RUNMODAL(50227, Rec);
                        // if (rec."Gate Entry Type" = rec."Gate Entry Type"::Stay) and (rec.Registered = true) then
                        //     PAGE.RUNMODAL(50222, Rec);
                        //BC UPGRADE KUMARR78 FDD-MTC-007--

                        //HEI.04<<
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        WarehouseSetup.GET();
        //IF "Weight Difference" <= WarehouseSetup."Gate Entry Weight Tolerance %" THEN //HEI.03
        if rec.CheckTolerance() then //HEI.03
            WeightDifferenceStyle := FavorableStyle
        else
            WeightDifferenceStyle := UnFavorableStyle;
    end;

    var

        FavorableStyle: Label 'Favorable';
        UnFavorableStyle: Label 'Unfavorable';
        WeightDifferenceStyle: Text;
}

