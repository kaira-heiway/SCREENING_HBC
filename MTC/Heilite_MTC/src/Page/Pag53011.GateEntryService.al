page 53011 "Gate Entry Service"
{
    // version HEI.04
    //BC Upgrade GUNREM01 -old page ID 50226

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"
    // HEI.03 Defect #3271 IBM NASTAA02 17.10.2018 # Error when creating a new Gate entry inbound
    //   # Location Code and Zone Code should be mandatory
    // HEI.04 Bugfixing RW IBM NASTAA02 22.10.2018 # Bugfixing Gate Entry RW
    //   # "Weight Difference" should be compared with setup as percentage
    //   # "Register" Button should be on Actions ribbon not on Navigate
    //   # "Zone Code" should be non-editable when Status is 'Released'
    // HEI.05 CHG2011091 IBM GAVANM01 23.05.2019
    //   # Setup the report Gate Entry Document in Report Selection
    //   # New global var "WhseDocPrint"
    //   # new code in Page Actions

    //BC Upgrade GUNREM01 Created new var to call the function from Codeunit(HeinekenBCUpgrageCU)

    // BC Upgrade PATELS08 >>
    // # Changed procedure name OnAfterGetCurrRecord to OnAfterGetCurrRecordProcedure as 'OnAfterGetCurrRecord' is used for trigger's name
    // # Updated the OnAfterGetCurrRecord calls to OnAfterGetCurrRecordProcedure in triggers OnAfterGetRecord and OnNewRecord
    // BC Upgrade PATELS08 <<


    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Gate Entry Header FND";
    SourceTableView = WHERE("Gate Entry Type" = FILTER(Service),
                            Registered = FILTER(false));

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
                }
                field("Gate Keeper ID"; Rec."Gate Keeper ID")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    Editable = "Vehicle No.Editable";
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ApplicationArea = all;
                    Editable = "Driver CodeEditable";
                }
                field("Gate Entry Type"; Rec."Gate Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = "Document No.Editable";
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = "Location CodeEditable";
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = all;
                    Editable = ZoneCodeEditable;
                }
                field("Linked Gate Entry No."; Rec."Linked Gate Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    Visible = RemarksVisible;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = DescriptionEditable;
                }
                field("Date In"; Rec."Date In")
                {
                    ApplicationArea = all;
                    Editable = "Date InEditable";
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = all;
                    Editable = "Time InEditable";
                }
                field("Date Out"; Rec."Date Out")
                {
                    ApplicationArea = all;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = all;
                }
                field("Total Weight on Arrival"; Rec."Total Weight on Arrival")
                {
                    ApplicationArea = all;
                    Editable = TotalWeightonArrivalEditable;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Total Weight on Departure"; Rec."Total Weight on Departure")
                {
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Posted Weight Inbound"; Rec."Posted Weight Inbound")
                {
                    ApplicationArea = all;
                }
                field("Posted Weight Outbound"; Rec."Posted Weight Outbound")
                {
                    ApplicationArea = all;
                }
                field("Weight Difference"; Rec."Weight Difference")
                {
                    ApplicationArea = all;
                    StyleExpr = WeightDifferenceStyle;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
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
                action(Statistics)
                {
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Rec.FillGateEntryBuffer;
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
                }
            }
        }
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        //HEI.03>>
                        Rec.TESTFIELD("Location Code");
                        Rec.TESTFIELD("Zone Code");
                        //HEI.03<<
                        Rec.ReleaseGateEntry;
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        Rec.OpenGateEntry;
                    end;
                }
            }
            group("&Register")
            {
                Caption = '&Register';
                action(Register)
                {
                    Caption = 'Register';
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    trigger OnAction();
                    begin
                        Rec.Register;
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    ApplicationArea = all;

                    trigger OnAction();
                    var
                        HeinekenBCUpgrageCU: Codeunit "Heineken BC Upgrade";
                    begin
                        //PrintDocument; commented by HEI.05
                        //HEI.05>>
                        HeinekenBCUpgrageCU.PrintGateEntryDocument(Rec); //BC Upgrade GUNREM01 added

                        //WhseDocPrint.PrintGateEntryDocument(Rec); //BC Upgrade GUNREM01 commented. IN bc we created this function in  "Heineken BC Upgrade" Codeunit.
                        //HEI.05<<
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

                trigger OnAction();
                begin
                    Rec.Navigate;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        UserSetup.GET(USERID);
        if UserSetup."Allow Gate Entry Register FND" then
            RemarksVisible := true
        else
            RemarksVisible := false;
        // BC Upgrade PATELS08 >> # Procedure Renamed to OnAfterGetCurrRecordProcedure
        // OnAfterGetCurrRecord;
        OnAfterGetCurrRecordProcedure();
        // BC Upgrade PATELS08 <<

        WarehouseSetup.GET;
        //IF "Weight Difference" <= WarehouseSetup."Gate Entry Weight Tolerance %" THEN //HEI.04
        if Rec.CheckTolerance then //HEI.04
            WeightDifferenceStyle := FavorableStyle
        else
            WeightDifferenceStyle := UnFavorableStyle;
    end;

    trigger OnInit();
    begin
        TotalWeightonArrivalEditable := true;
        "Time InEditable" := true;
        "Date InEditable" := true;
        DescriptionEditable := true;
        "Location CodeEditable" := true;
        "Document No.Editable" := true;
        "Document TypeEditable" := true;
        "Driver CodeEditable" := true;
        "Vehicle No.Editable" := true;
        RemarksVisible := true;
        ZoneCodeEditable := true; //HEI.04
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Gate Entry Type" := Rec."Gate Entry Type"::Service;
        Rec."Date In" := WORKDATE;
        Rec."Time In" := TIME;
        // BC Upgrade PATELS08 >> # Procedure Renamed to OnAfterGetCurrRecordProcedure
        // OnAfterGetCurrRecord;
        OnAfterGetCurrRecordProcedure();
        // BC Upgrade PATELS08 <<
    end;

    trigger OnOpenPage();
    begin
        UserSetup.GET(USERID);
        if UserSetup."Allow Gate Entry Register FND" then
            RemarksVisible := true
        else
            RemarksVisible := false;

        Rec.InsertPostedWeight; //HEI.04
    end;

    var
        UserSetup: Record "User Setup";
        //[InDataSet]
        RemarksVisible: Boolean;
        //[InDataSet]
        "Vehicle No.Editable": Boolean;
        //[InDataSet]
        "Driver CodeEditable": Boolean;
        //[InDataSet]
        "Document TypeEditable": Boolean;
        //[InDataSet]
        "Document No.Editable": Boolean;
        //[InDataSet]
        "Location CodeEditable": Boolean;
        //[InDataSet]
        DescriptionEditable: Boolean;
        //[InDataSet]
        "Date InEditable": Boolean;
        //[InDataSet]
        "Time InEditable": Boolean;
        //[InDataSet]
        TotalWeightonArrivalEditable: Boolean;
        //[InDataSet]
        WeightDifferenceStyle: Text;
        FavorableStyle: Label 'Favorable';
        UnFavorableStyle: Label 'Unfavorable';
        ZoneCodeEditable: Boolean;
        WhseDocPrint: Codeunit "Warehouse Document-Print";

    procedure UpdateEditableField();
    begin
        if Rec.Status = Rec.Status::Released then begin
            "Vehicle No.Editable" := false;
            "Driver CodeEditable" := false;
            "Document TypeEditable" := false;
            "Document No.Editable" := false;
            "Location CodeEditable" := false;
            DescriptionEditable := false;
            "Date InEditable" := false;
            "Time InEditable" := false;
            TotalWeightonArrivalEditable := false;
            ZoneCodeEditable := false; //HEI.04
        end else begin
            "Vehicle No.Editable" := true;
            "Driver CodeEditable" := true;
            "Document TypeEditable" := true;
            "Document No.Editable" := true;
            "Location CodeEditable" := true;
            DescriptionEditable := true;
            "Date InEditable" := true;
            "Time InEditable" := true;
            TotalWeightonArrivalEditable := true;
            ZoneCodeEditable := true; //HEI.04
        end;
    end;

    // BC Upgrade PATELS08 >> # Changed procedure name to OnAfterGetCurrRecordProcedure as OnAfterGetCurrRecord is used for triggers
    // local procedure OnAfterGetCurrRecord();
    local procedure OnAfterGetCurrRecordProcedure();
    // BC Upgrade PATELS08 <<
    begin
        xRec := Rec;
        UpdateEditableField
    end;

    local procedure WeightDifferenceOnFormat();
    begin
        if Rec.CheckTolerance = true then;
    end;
}

