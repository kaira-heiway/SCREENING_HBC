page 53007 "Registered Gate Entry"
{
    // version HEI.03
    //BC Upgrade GUNREM01 -Old page ID 50222

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"
    // HEI.03 Bugfixing RW IBM NASTAA02 22.10.2018 # Bugfixing Gate Entry RW
    //   # "Weight Difference" should be compared with setup as percentage

    CaptionML = ENU = 'Registered Gate Entry',
                FRA = 'Registered Gate Entry';
    Editable = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Gate Entry Header FND";
    SourceTableView = SORTING("Gate Entry Document No.")
                      ORDER(Ascending)
                      WHERE(Registered = CONST(true));
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Gate Entry Document No."; Rec."Gate Entry Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Gate Entry Document No. field.';
                }
                field("Gate Keeper ID"; Rec."Gate Keeper ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Gate Keeper ID field.';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Driver Code field.';
                }
                field("Gate Entry Type"; Rec."Gate Entry Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Gate Entry Type field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Zone Code field.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the No. Printed field.';
                }
                field("Linked Gate Entry No."; Rec."Linked Gate Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Linked Gate Entry No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    MultiLine = true;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Date In"; Rec."Date In")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Date In field.';
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Time In field.';
                }
                field("Date Out"; Rec."Date Out")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Date Out field.';
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Time Out field.';
                }
                field("Total Weight on Arrival"; Rec."Total Weight on Arrival")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Total Weight on Arrival field.';
                }
                field("Total Weight on Departure"; Rec."Total Weight on Departure")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Total Weight on Departure field.';
                }
                field("Posted Weight Inbound"; Rec."Posted Weight Inbound")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Posted Weight Inbound field.';
                }
                field("Posted Weight Outbound"; Rec."Posted Weight Outbound")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Posted Weight Outbound field.';
                }
                field("Weight Difference"; Rec."Weight Difference")
                {
                    StyleExpr = WeightDifferenceStyle;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Weight Difference field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            part(GateEntryLine; "Gate Entry Subform")
            {
                SubPageLink = "Gate Entry Document No." = FIELD("Gate Entry Document No.");
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
                action(Statistics)
                {
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = all;
                    ToolTip = 'Executes the Statistics action.';

                    trigger OnAction();
                    begin
                        Rec.FillGateEntryBuffer();
                    end;
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Gate Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Gate Entry Type"),
                                  "No." = FIELD("Gate Entry Document No."),
                                  "Document Line No." = CONST(0);
                    RunPageView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                  ORDER(Ascending);
                    ApplicationArea = all;
                    ToolTip = 'Executes the Co&mments action.';
                }
            }
        }
        area(processing)
        {
            group("&Print")
            {
                Caption = '&Print';
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    ApplicationArea = all;
                    ToolTip = 'Executes the Print action.';

                    trigger OnAction();
                    begin
                        Rec.PrintDocument();
                    end;
                }
            }
            action("&Navigate")
            {
                CaptionML = ENU = '&Navigate',
                            FRA = 'Na&viguer';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                ToolTip = 'Executes the &Navigate action.';

                trigger OnAction();
                begin
                    Rec.Navigate();
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        WarehouseSetup.GET();
        //IF "Weight Difference" <= WarehouseSetup."Gate Entry Weight Tolerance %" THEN //HEI.03
        if Rec.CheckTolerance() then //HEI.03
            WeightDifferenceStyle := FavorableStyle
        else
            WeightDifferenceStyle := UnFavorableStyle;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Gate Entry Type" := Rec."Gate Entry Type"::Inbound;
    end;

    var
        //[InDataSet]
        WeightDifferenceStyle: Text;
        FavorableStyle: Label 'Favorable';
        UnFavorableStyle: Label 'Unfavorable';

    local procedure WeightDifferenceOnFormat();
    begin
        if Rec.CheckTolerance() = true then;
    end;
}

