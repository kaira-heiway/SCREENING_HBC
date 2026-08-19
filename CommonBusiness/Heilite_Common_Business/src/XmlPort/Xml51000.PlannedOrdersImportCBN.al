xmlport 51000 "Planned Orders Import CBN"
{
    // version HEI.01

    // HEI:EDD068:1:1 18/11/14 TECTURA-HKH
    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Changes:
    // 1. Replaced NoSeriesManagement codeunit with "No. Series" codeunit
    // 2. Commented out Drink IT custom fields/table references
    // BC Upgrade BHARDA11 <<

    // BC Upgrade PATELP08 >> 
    // # Removed deprecated with statement and replaced it with explicit record references in procedure -"RefreshProdOrder".
    // BC Upgrade PATELP08 <<
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;
    UseRequestPage = false;


    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement("Production Order"; "Production Order")
            {
                XmlName = 'ProductionOrder';
                SourceTableView = sorting(Status, "No.");
                textelement(Producttxt)
                {
                }
                textelement(Plantxt)
                {
                }
                textelement(WeekNumbertxt)
                {
                }
                textelement(QuantityHLtxt)
                {
                }

                trigger OnAfterInsertRecord();
                begin

                    "Production Order".INIT();
                    "Production Order".Status := "Production Order".Status::Planned;
                    MfgSetup.GET();
                    "Production Order"."No." := NoSeriesMgmt.GetNextNo(MfgSetup."Planned Order Nos.", TODAY, true);
                    "Production Order".VALIDATE("Source Type", "Production Order"."Source Type"::Item);
                    "Production Order".VALIDATE("Source No.", Producttxt);

                    EVALUATE(Week, COPYSTR(WeekNumbertxt, 5, 2));
                    EVALUATE(Year, COPYSTR(WeekNumbertxt, 1, 4));
                    EVALUATE(DecQuantityHl, QuantityHLtxt);
                    DueDate := DWY2DATE(1, Week, Year);
                    "Production Order".VALIDATE("Due Date", DueDate);
                    // BC Upgrade BHARDA11 >> ---Drink IT Fields "Unit Volume HL" "Physical Location Group Code"
                    // Location.RESET;
                    // Location.SETRANGE("Physical Location Group Code", Plantxt);
                    // Location.SETRANGE("Default Physical Location", true);
                    // if Location.FINDFIRST then
                    //     "Production Order".VALIDATE("Location Code", Location.Code)
                    // else
                    //     ERROR(Text001, Plant);

                    // Item.GET(Producttxt);
                    // if Item."Unit Volume HL" <> 0 then
                    //     "Production Order".VALIDATE(Quantity, DecQuantityHl / Item."Unit Volume HL")
                    // else
                    //     currXMLport.SKIP;
                    // BC Upgrade BHARDA11 << ---Drink IT Fields "Physical Location Group Code" "Unit Volume HL"

                    "Production Order".INSERT(true);

                    SetOptions();
                    RefreshProdOrder();
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        Item: Record Item;
        Location: Record Location;
        MfgSetup: Record "Manufacturing Setup";
        // NoSeriesMgmt : Codeunit NoSeriesManagement; // BC Upgrade BHARDA11
        NoSeriesMgmt: Codeunit "No. Series";
        CalcComponents: Boolean;
        CalcLines: Boolean;
        CalcRoutings: Boolean;
        Plant: Code[20];
        Product: Code[20];
        DueDate: Date;
        DecQuantityHl: Decimal;
        QuantityHL: Decimal;
        Week: Integer;
        Year: Integer;
        Text001: Label 'There is no default location for plant %1.';
        Direction: Option Forward,Backward;
        WeekNumber: Text[6];
        txtFileName: Text[1024];

    procedure SetOptions();
    begin
        Direction := Direction::Backward;
        CalcLines := true;
        CalcRoutings := true;
        CalcComponents := true;
    end;

    // BC Upgrade PATELP08 >> # Removed deprecated with statement and replaced it with explicit record references
    procedure RefreshProdOrder();
    var
        Family: Record Family;
        InvSetup: Record "Inventory Setup";
        Item: Record Item;
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        CreateProdOrderLines: Codeunit "Create Prod. Order Lines";
        // CompTrackingEntry: Record "Comp. Tracking Entry"; // BC Upgrade BHARDA11 --Drink IT Table
        RoutingNo: Code[20];
    begin
        // BC Upgrade PATELP08 >> # Removed deprecated with statement and replaced it with explicit record references
        // with "Production Order" do begin

        //     InvSetup.GET();
        //     if InvSetup."Location Mandatory" then
        //         TESTFIELD("Location Code");

        //     if Direction = Direction::Backward then
        //         TESTFIELD("Due Date");
        //     // BC Upgrade BHARDA11 >> Drink IT fields
        //     // "Actual Quantity" := 0;
        //     // "Original Quantity" := Quantity;
        //     // BC Upgrade BHARDA11 << Drink IT fields
        //     MODIFY();

        //     RoutingNo := "Routing No.";
        //     case "Source Type" of
        //         "Source Type"::Item:
        //             if Item.GET("Source No.") then
        //                 RoutingNo := Item."Routing No.";
        //         "Source Type"::Family:
        //             if Family.GET("Source No.") then
        //                 RoutingNo := Family."Routing No.";
        //     end;
        //     if RoutingNo <> "Routing No." then begin
        //         "Routing No." := RoutingNo;
        //         MODIFY();
        //     end;

        //     ProdOrderLine.LOCKTABLE();

        //     CheckReservationExist();

        //     if CalcLines then
        //         CreateProdOrderLines.Copy("Production Order", Direction, '', false)
        //     else begin
        //         ProdOrderLine.SETRANGE(Status, Status);
        //         ProdOrderLine.SETRANGE("Prod. Order No.", "No.");
        //         if CalcRoutings or CalcComponents then begin
        //             if ProdOrderLine.FIND('-') then
        //                 repeat
        //                     if CalcRoutings then begin
        //                         ProdOrderRtngLine.SETRANGE(Status, Status);
        //                         ProdOrderRtngLine.SETRANGE("Prod. Order No.", "No.");
        //                         ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
        //                         ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
        //                         ProdOrderRtngLine.DELETEALL(true);
        //                     end;
        //                     if CalcComponents then begin
        //                         ProdOrderComp.SETRANGE(Status, Status);
        //                         ProdOrderComp.SETRANGE("Prod. Order No.", "No.");
        //                         ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
        //                         ProdOrderComp.DELETEALL(true);
        //                     end;
        //                 until ProdOrderLine.NEXT() = 0;
        //             if ProdOrderLine.FIND('-') then
        //                 repeat
        //                     ProdOrderLine."Due Date" := "Due Date";
        //                     CalcProdOrder.Calculate(ProdOrderLine, Direction, CalcRoutings, CalcComponents, false, false);
        //                 until ProdOrderLine.NEXT() = 0;
        //         end;
        //     end;
        //     // BC Upgrade BHARDA11 >> ----Drink IT Table
        //     // if CompTrackingEntry.READPERMISSION then begin
        //     //     CompTrackingEntry.RESET;
        //     //     CompTrackingEntry.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
        //     //     CompTrackingEntry.SETRANGE("Source Subtype", Status);
        //     //     CompTrackingEntry.SETRANGE("Source ID", "No.");
        //     //     CompTrackingEntry.DELETEALL;
        //     //     ProdOrderComp.SETRANGE(Status, Status);
        //     //     ProdOrderComp.SETRANGE("Prod. Order No.", "No.");
        //     //     ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
        //     //     if ProdOrderComp.FIND('-') then
        //     //         ProdOrderComp.MODIFYALL("Calculation Required", false);
        //     // end;
        //     // BC Upgrade BHARDA11 << ----Drink IT Table
        // end;

        InvSetup.GET();
        if InvSetup."Location Mandatory" then
            "Production Order".TESTFIELD("Production Order"."Location Code");

        if Direction = Direction::Backward then
            "Production Order".TESTFIELD("Production Order"."Due Date");
        // BC Upgrade BHARDA11 >> Drink IT fields
        // "Actual Quantity" := 0;
        // "Original Quantity" := Quantity;
        // BC Upgrade BHARDA11 << Drink IT fields
        "Production Order".MODIFY();

        RoutingNo := "Production Order"."Routing No.";
        case "Production Order"."Source Type" of
            "Production Order"."Source Type"::Item:
                if Item.GET("Production Order"."Source No.") then
                    RoutingNo := Item."Routing No.";
            "Production Order"."Source Type"::Family:
                if Family.GET("Production Order"."Source No.") then
                    RoutingNo := Family."Routing No.";
        end;
        if RoutingNo <> "Production Order"."Routing No." then begin
            "Production Order"."Routing No." := RoutingNo;
            "Production Order".MODIFY();
        end;

        ProdOrderLine.LOCKTABLE();

        CheckReservationExist();

        if CalcLines then
            CreateProdOrderLines.Copy("Production Order", Direction, '', false)
        else begin
            ProdOrderLine.SETRANGE(Status, "Production Order".Status);
            ProdOrderLine.SETRANGE("Prod. Order No.", "Production Order"."No.");
            if CalcRoutings or CalcComponents then begin
                if ProdOrderLine.FIND('-') then
                    repeat
                        if CalcRoutings then begin
                            ProdOrderRtngLine.SETRANGE(Status, "Production Order".Status);
                            ProdOrderRtngLine.SETRANGE("Prod. Order No.", "Production Order"."No.");
                            ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
                            ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
                            ProdOrderRtngLine.DELETEALL(true);
                        end;
                        if CalcComponents then begin
                            ProdOrderComp.SETRANGE(Status, "Production Order".Status);
                            ProdOrderComp.SETRANGE("Prod. Order No.", "Production Order"."No.");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            ProdOrderComp.DELETEALL(true);
                        end;
                    until ProdOrderLine.NEXT() = 0;
                if ProdOrderLine.FIND('-') then
                    repeat
                        ProdOrderLine."Due Date" := "Production Order"."Due Date";
                        CalcProdOrder.Calculate(ProdOrderLine, Direction, CalcRoutings, CalcComponents, false, false);
                    until ProdOrderLine.NEXT() = 0;
            end;
        end;
        // BC Upgrade BHARDA11 >> ----Drink IT Table
        // if CompTrackingEntry.READPERMISSION then begin
        //     CompTrackingEntry.RESET;
        //     CompTrackingEntry.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
        //     CompTrackingEntry.SETRANGE("Source Subtype", Status);
        //     CompTrackingEntry.SETRANGE("Source ID", "No.");
        //     CompTrackingEntry.DELETEALL;
        //     ProdOrderComp.SETRANGE(Status, Status);
        //     ProdOrderComp.SETRANGE("Prod. Order No.", "No.");
        //     ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
        //     if ProdOrderComp.FIND('-') then
        //         ProdOrderComp.MODIFYALL("Calculation Required", false);
        // end;
        // BC Upgrade BHARDA11 << ----Drink IT Table
        // BC Upgrade PATELP08 <<
    end;
    // BC Upgrade PATELP08 <<

    procedure CheckReservationExist();
    var
        ProdOrderComp2: Record "Prod. Order Component";
        ProdOrderLine2: Record "Prod. Order Line";
        ReservEntry: Record "Reservation Entry";
    begin
        if (not CalcLines) or (not CalcComponents) then
            exit;
        ReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Reservation Status", ReservEntry."Reservation Status"::Reservation);

        ProdOrderLine2.SETRANGE(Status, "Production Order".Status);
        ProdOrderLine2.SETRANGE("Prod. Order No.", "Production Order"."No.");
        if ProdOrderLine2.FIND('-') then
            repeat
                if CalcLines then begin
                    ProdOrderLine2.CALCFIELDS("Reserved Qty. (Base)");
                    if ProdOrderLine2."Reserved Qty. (Base)" <> 0 then begin
                        ReservEntry.SETRANGE("Source ID", ProdOrderLine2."Prod. Order No.");
                        ReservEntry.SETRANGE("Source Ref. No.", 0);
                        ReservEntry.SETRANGE("Source Type", DATABASE::"Prod. Order Line");
                        ReservEntry.SETRANGE("Source Subtype", ProdOrderLine2.Status);
                        ReservEntry.SETRANGE("Source Prod. Order Line", ProdOrderLine2."Line No.");
                        if ReservEntry.FIND('-') then begin
                            ReservEntry.GET(ReservEntry."Entry No.", not (ReservEntry.Positive));
                            if not ((ReservEntry."Source Type" = DATABASE::"Prod. Order Component") and
                              (ReservEntry."Source ID" = ProdOrderLine2."Prod. Order No.") and
                              (ReservEntry."Source Subtype" = ProdOrderLine2.Status.AsInteger()))
                            then
                                ProdOrderLine2.TESTFIELD("Reserved Qty. (Base)", 0);
                        end;
                    end;
                end;

                if CalcLines or CalcComponents then begin
                    ProdOrderComp2.SETRANGE(Status, ProdOrderLine2.Status);
                    ProdOrderComp2.SETRANGE("Prod. Order No.", ProdOrderLine2."Prod. Order No.");
                    ProdOrderComp2.SETRANGE("Prod. Order Line No.", ProdOrderLine2."Line No.");
                    if ProdOrderComp2.FIND('-') then
                        repeat
                            ProdOrderComp2.CALCFIELDS("Reserved Qty. (Base)");
                            if ProdOrderComp2."Reserved Qty. (Base)" <> 0 then begin
                                ReservEntry.SETRANGE("Source ID", ProdOrderComp2."Prod. Order No.");
                                ReservEntry.SETRANGE("Source Ref. No.", ProdOrderComp2."Line No.");
                                ReservEntry.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                                ReservEntry.SETRANGE("Source Subtype", ProdOrderComp2.Status);
                                ReservEntry.SETRANGE("Source Prod. Order Line", ProdOrderComp2."Prod. Order Line No.");
                                if ReservEntry.FIND('-') then begin
                                    ReservEntry.GET(ReservEntry."Entry No.", not (ReservEntry.Positive));
                                    if not ((ReservEntry."Source Type" = DATABASE::"Prod. Order Line") and
                                      (ReservEntry."Source ID" = ProdOrderComp2."Prod. Order No.") and
                                      (ReservEntry."Source Subtype" = ProdOrderComp2.Status.AsInteger()))
                                    then
                                        ProdOrderComp2.TESTFIELD("Reserved Qty. (Base)", 0);
                                end;
                            end;
                        until ProdOrderComp2.NEXT() = 0;
                end;
            until ProdOrderLine2.NEXT() = 0;
    end;

    procedure FctSefileName(PfileName: Text[1024]);
    begin
        currXMLport.FILENAME(PfileName);
    end;
}

