page 53010 "Gate Entry Outbound"
{
    // version HEI.07
    //BC Upgrade GUNREM01 -old page ID 50225
    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // 
    // FDD-HNK-BRA-0036 - 06/30/2017 - CiprianH
    //    - add new action
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
    //   # If "Gate Entry" was linked to a Warehouse Shipment then "Document No." should not be filled-in when "Collect Lines"
    // HEI.05 CHG2011091 IBM GAVANM01 23.05.2019
    //   # Setup the report Gate Entry Document in Report Selection
    //   # New global var "WhseDocPrint"
    //   # new code in Page Actions
    // HEI.06 FDD_CHG2030239 FA Master Data IBM  SAXENS01 17.09.2019
    //   added code on Register Action
    // HEI.07 CHG2260099 COSTES04 16.10.2024 Automatic Archiving of Gate Entry Outbound While Undoing Sales Shipment.
    //   # New field added Blocked

    //BC Upgrade GUNREM01 Created new var to call the function from Codeunit(HeinekenBCUpgrageCU)

    // BC Upgrade MISHRS14 >>
    // Changed name from OnAfterGetCurrRecord to OnAfterGetCurrRecordProcedure as that is only valid for trigger name, in procedure name and in OnAfterGetRecord and OnNewRecord triggers.
    // BC Upgrade MISHRS14 <<

    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Gate Entry Header FND";
    SourceTableView = WHERE("Gate Entry Type" = FILTER(Outbound),
                            Registered = FILTER(false));
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
                    Editable = "Vehicle No.Editable";
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    Editable = "Driver CodeEditable";
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
                    Editable = "Document TypeEditable";
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = "Document No.Editable";
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = "Location CodeEditable";
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = all;
                    Editable = ZoneCodeEditable;
                    ToolTip = 'Specifies the value of the Zone Code field.';
                }
                field("Linked Gate Entry No."; Rec."Linked Gate Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Linked Gate Entry No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    Visible = RemarksVisible;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = DescriptionEditable;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Date In"; Rec."Date In")
                {
                    ApplicationArea = all;
                    Editable = "Date InEditable";
                    ToolTip = 'Specifies the value of the Date In field.';
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = all;
                    Editable = "Time InEditable";
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
                    Editable = TotalWeightonArrivalEditable;
                    ToolTip = 'Specifies the value of the Total Weight on Arrival field.';

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE();
                    end;
                }
                field("Total Weight on Departure"; Rec."Total Weight on Departure")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Total Weight on Departure field.';

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE();
                    end;
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
                    ApplicationArea = all;
                    StyleExpr = WeightDifferenceStyle;
                    ToolTip = 'Specifies the value of the Weight Difference field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the No. Printed field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Blocked field.';
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    ApplicationArea = all;
                    ToolTip = 'Executes the Release action.';

                    trigger OnAction();
                    begin
                        //HEI.03>>
                        Rec.TESTFIELD("Location Code");
                        Rec.TESTFIELD("Zone Code");
                        //HEI.03<<
                        Rec.ReleaseGateEntry();
                    end;
                }
                action("Re-Open")
                {
                    Caption = 'Re-Open';
                    ApplicationArea = all;
                    ToolTip = 'Executes the Re-Open action.';
                    trigger OnAction();
                    begin
                        Rec.OpenGateEntry();
                    end;
                }
                action(CollectLines)
                {
                    Caption = 'Collect Lines';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    ToolTip = 'Executes the Collect Lines action.';

                    trigger OnAction();
                    var
                        GateEntryOutIn: Codeunit "Gate Entry In/Out CBN";
                        WhseSetup: Record "Warehouse Setup";
                        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
                        SalesShipmentHeader: Record "Sales Shipment Header";
                        PostedSalesShipmentExist: Boolean;
                        WhseShipmentExist: Boolean;
                    begin
                        //FDD-HNK-BRA-0036>>
                        WhseSetup.GET();
                        if WhseSetup."Allow Collect Lines FND" = true then begin
                            if Rec."Document Type" = Rec."Document Type"::"Warehouse Shipment" then begin
                                //HEI.04>>
                                WarehouseShipmentHeader.SETRANGE("Gate Entry No. FND", Rec."Gate Entry Document No.");
                                WhseShipmentExist := WarehouseShipmentHeader.FINDFIRST();
                                SalesShipmentHeader.SETRANGE("Gate Entry No. FND", Rec."Gate Entry Document No.");
                                PostedSalesShipmentExist := SalesShipmentHeader.FINDFIRST();
                                if WhseShipmentExist then begin
                                    GateEntryOutIn.GetOutboundLines(WarehouseShipmentHeader."No.", Rec."Gate Entry Document No.");
                                    Rec."Document No." := WarehouseShipmentHeader."No.";
                                end else if PostedSalesShipmentExist then begin
                                    GateEntryOutIn.GetOutboundLines(SalesShipmentHeader."Whse. Shipment No. FND", Rec."Gate Entry Document No.");
                                    Rec."Document No." := SalesShipmentHeader."Whse. Shipment No. FND";
                                end else
                                    //HEI.04<<
                                    GateEntryOutIn.GetOutboundLines(Rec."Document No.", Rec."Gate Entry Document No.");
                            end else
                                ERROR('Document type must be Warehouse Shipment!');
                        end else
                            ERROR('No lines collected, check setup!')
                        //FDD-HNK-BRA-0036<<
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
                    ToolTip = 'Executes the Register action.';

                    trigger OnAction();
                    var
                        PostedWarehouseShipmentHeader: Record "Posted Whse. Shipment Header";
                        PostedWarehouseShipmentLines: Record "Posted Whse. Shipment Line";
                        PostedWarehouseShipmentQty: Decimal;
                        PstdWhseItemNo: Text[30];
                        GateEntryLines: Record "Gate Entry Line FND";
                        GateEntryItemNo: Code[20];
                        GateEntryQty: Decimal;
                    begin
                        //HEI.06
                        PostedWarehouseShipmentHeader.SETRANGE("Gate Entry No. FND", Rec."Gate Entry Document No.");

                        //BC Upgrade GUNREM01 >> -DIT fields
                        // PostedWarehouseShipmentHeader.SETRANGE("Truck Code",Rec. "Vehicle No."); 
                        // PostedWarehouseShipmentHeader.SETRANGE("Driver Code", Rec."Driver Code");
                        //BC Upgrade GUNREM01 >> -DIT fields
                        //BC UPGRADE KUMARR78 >> FDD-MTC-007 ++
                        PostedWarehouseShipmentHeader.SETRANGE("Vehicle Code 101FDW", Rec."Vehicle No.");
                        PostedWarehouseShipmentHeader.SETRANGE("Log Driver 107FDW", Rec."Driver Code");
                        //BC UPGRADE KUMARR78 << FDD-MTC-007 ++

                        PostedWarehouseShipmentHeader.SETRANGE("Location Code", Rec."Location Code");
                        PostedWarehouseShipmentHeader.SETRANGE("Zone Code", Rec."Zone Code");
                        if PostedWarehouseShipmentHeader.FINDFIRST() then begin
                            PostedWarehouseShipmentLines.SETRANGE("No.", PostedWarehouseShipmentHeader."No.");
                            if PostedWarehouseShipmentLines.FINDSET() then
                                repeat
                                    if PstdWhseItemNo <> PostedWarehouseShipmentLines."Item No." then begin
                                        PostedWarehouseShipmentQty += PostedWarehouseShipmentLines.Quantity;
                                        PstdWhseItemNo := PostedWarehouseShipmentLines."Item No.";
                                    end else begin
                                        PostedWarehouseShipmentQty += PostedWarehouseShipmentLines.Quantity;
                                        PstdWhseItemNo := PostedWarehouseShipmentLines."Item No.";
                                    end;
                                until PostedWarehouseShipmentLines.NEXT() = 0;
                            GateEntryLines.SETRANGE("Gate Entry Document No.", Rec."Gate Entry Document No.");
                            if GateEntryLines.FINDSET() then
                                repeat
                                    if GateEntryItemNo <> GateEntryLines."No." then begin
                                        GateEntryQty += GateEntryLines."Quantity on Departure";
                                        GateEntryItemNo := GateEntryLines."No."
                                    end else begin
                                        GateEntryQty += GateEntryLines."Quantity on Departure";
                                        GateEntryItemNo := GateEntryLines."No."
                                    end
                                until GateEntryLines.NEXT() = 0;
                        end;

                        if PostedWarehouseShipmentQty <> GateEntryQty then
                            ERROR('Gate Entry %1 is not matching with the posted whse shipment %2', GateEntryLines."Gate Entry Document No.", PostedWarehouseShipmentHeader."No.")
                        else
                            Rec.Register();
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
                    ToolTip = 'Executes the Print action.';

                    trigger OnAction();
                    var
                        HeinekenBCUpgrageCU: Codeunit "Heineken BC Upgrade";

                    begin
                        //PrintDocument; commented by HEI.05
                        //HEI.05>>
                        HeinekenBCUpgrageCU.PrintGateEntryDocument(Rec); //BC Upgrade GUNREM01 added
                        //  WhseDocPrint.PrintGateEntryDocument(Rec); //BC Upgrade GUNREM01 commented. IN bc we created this function in  "Heineken BC Upgrade" Codeunit.
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
        UserSetup.GET(USERID);
        if UserSetup."Allow Gate Entry Register FND" then
            RemarksVisible := true
        else
            RemarksVisible := false;
        //OnAfterGetCurrRecord();

        // BC Upgrade MISHRS14 >>
        // Changed name from OnAfterGetCurrRecord to OnAfterGetCurrRecordProcedure as that is only valid for trigger name.
        OnAfterGetCurrRecordProcedure();
        // BC Upgrade MISHRS14 <<

        Rec.InsertPostedWeight(); //HEI.04

        WarehouseSetup.GET();
        //IF "Weight Difference" <= WarehouseSetup."Gate Entry Weight Tolerance %" THEN //HEI.04
        if Rec.CheckTolerance() then //HEI.04
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
        Rec."Gate Entry Type" := Rec."Gate Entry Type"::Outbound;
        Rec."Date In" := WORKDATE();
        Rec."Time In" := TIME;
        //OnAfterGetCurrRecord();

        // BC Upgrade MISHRS14 >>
        // Changed name from OnAfterGetCurrRecord to OnAfterGetCurrRecordProcedure as that is only valid for trigger name.
        OnAfterGetCurrRecordProcedure();
        // BC Upgrade MISHRS14 <<
    end;

    trigger OnOpenPage();
    begin
        UserSetup.GET(USERID);
        if UserSetup."Allow Gate Entry Register FND" then
            RemarksVisible := true
        else
            RemarksVisible := false;
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
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
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
            ZoneCodeEditable := false; //HEI.04
                                       //HEI.04>>
            SalesShipmentHeader.SETRANGE("Gate Entry No. FND", Rec."Gate Entry Document No.");
            TotalWeightonArrivalEditable := SalesShipmentHeader.FINDFIRST();
            //HEI.04<<
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

    //local procedure OnAfterGetCurrRecord();

    // BC Upgrade MISHRS14 >>
    // Changed name from OnAfterGetCurrRecord to OnAfterGetCurrRecordProcedure as that is only valid for trigger name.
    local procedure OnAfterGetCurrRecordProcedure();
    // BC Upgrade MISHRS14 <<
    begin
        xRec := Rec;
        UpdateEditableField()
    end;

    local procedure WeightDifferenceOnFormat();
    begin
        if Rec.CheckTolerance() = true then;
    end;
}

