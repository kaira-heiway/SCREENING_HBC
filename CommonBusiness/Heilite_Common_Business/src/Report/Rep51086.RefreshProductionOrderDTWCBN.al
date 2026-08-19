report 51086 "Refresh Prod Order DTW CBN"
{
    // version TS,DtW|HEI.08
    // BC Upgrade Kamnay01 Original(Heilite) Report id 50540
    // DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009 License problem
    // DITW15.00.00.30-PRODW14.00.00.09 DDR 21/01/2009 merge PRODW14.00.00.08.05A
    // DITW15.00.00.31-PRODW14.00.00.08.10 DLE 13/02/2009 License problem
    // DITW15.00.00.35-PRODW14.00.00.08.14 DDR 12/10/2009 issue 432 Refresh Released Prod.Order does not create Prod.order routing lines
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 AKH 10/02/2015 DIT-770 #1184 Multisite - Production Orders: Consider possible BOM and Routing setup on SKU card
    // DITW18.00.06 MSF 20/10/2015 DIT-770 #805 Renumber CodeUnit ID  2035095 to 2035150
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.12A HBA 22/06/2018 NRQ#68221 Adjusted code to update "Routing No."
    // 
    // HEI.01 FDD – HT938 IBM TUDOSG01 18.12.2019 # Code Modified, add validate on Routin No.
    // HEI.02 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //  # New function: L_UpdateTileCode
    //  # Modified trigger Production Order - OnAfterGetRecord
    // HEI.03 CHG2091922 IBM BASAKB01  22-12-2020 # Code Added - Update Start Date and End Date for Refresh Production Order
    // HEI.04 CHG2102527 IBM.LS      18.03.2021
    //   # Added and Commented Code
    // HEI.05 CHG2103468 IBM.LS      12.04.2021
    //   # Added and Commented Code
    // HEI.05 CHG2117989 IBM.LS      13.07.2021
    //   # Added and Commented Code
    // HEI.06 RITM2817451 IBM.LS      24.09.2021
    //   # Created New Report - 50540 from 99001025-Refresh Production Order
    // HEI.07 CHG2161505 PRASAA03 13/01/2023 Production Plan Interface
    //   # Windows page open control added for background run.
    // HEI.08 CHG2185291 IBM SAXENA03 10.05.2023 # Automation Test Scripts
    //   # Added code for Consolidation of Test Script objects

    //Bc Upgrade YADAVM09 UnitTestingValue variable Blocked will consider testscript related objects in last phase
    //  # Drink it code Commented.
    CaptionML = ENU = 'Refresh Production Order',
                FRA = 'Actualiser O.F.';
    ProcessingOnly = true;
    ApplicationArea = all;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.");
            RequestFilterFields = Status, "No.";

            trigger OnAfterGetRecord();
            var
                Item: Record Item;
                ProdOrderLine: Record "Prod. Order Line";
                ProdOrderRtngLine: Record "Prod. Order Routing Line";
                ProdOrderComp: Record "Prod. Order Component";
                Family: Record Family;
                ProdOrder: Record "Production Order";
                ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
                RoutingNo: Code[20];
                ErrorOccured: Boolean;
                //CompTrackingEntry : Record "Comp. Tracking Entry";//Bc Upgrade YADAVM09 Drink it field commented
                //QualityTestHEader : Record "Quality Test Header";//Bc Upgrade YADAVM09 Drink it field commented
                //BrewingSetup : Record "Production Setup";//Bc Upgrade YADAVM09 Drink it field commented
                //ProductGroup: Record "Product Group";/Bc Upgrade YADAVM09 Variable not used anywhere in the code
                // NoSeriesMgt: Codeunit NoSeriesManagement;
                lrSKU: Record "Stockkeeping Unit";
                RoutingLine: Record "Routing Line";
                ProdOrderLineL: Record "Prod. Order Line";
            begin
                if Status = Status::Finished then
                    CurrReport.SKIP();
                if Direction = Direction::Backward then
                    TESTFIELD("Due Date");

                if CalcLines and IsComponentPicked("Production Order") then
                    if not CONFIRM(STRSUBSTNO(DeletePickedLinesQst, "No.")) then
                        CurrReport.SKIP();

                //HEI.07>>
                IF GUIALLOWED THEN BEGIN
                    Window.UPDATE(1, Status);
                    Window.UPDATE(2, "No.");
                END;
                //HEI.07<<

                /* //Bc Upgrade Drink it code commented>>
                // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                "Actual Quantity" := 0;
                "Original Quantity" := Quantity;
                MODIFY;
                // >>DITW15.00.00.22 PRODW14.00.00. 08 DDR
                */ //Bc Upgrade Drink it code commented>>

                RoutingNo := "Routing No.";
                case "Source Type" of
                    /* //Bc Upgrade YADAVM09 Drink it code commented>>
                        "Source Type"::Item:
                            //<<DITW18.00.06 AKH 10/02/2015 DIT-770 #1184
                            //IF Item.GET("Source No.") THEN
                            //RoutingNo := Item."Routing No.";
                            if Item.GET("Source No.") then begin
                                if lrSKU.GET("Location Code", "Source No.", '') then
                                    RoutingNo := lrSKU."Routing No."
                                else
                                    RoutingNo := Item."Routing No.";
                            end;
                        //>>DITW18.00.06 AKH 10/02/2015 DIT-770 #1184
                        */ //Bc Upgrade YADAVM09 Drink it code commented<<
                    "Source Type"::Family:
                        if Family.GET("Source No.") then
                            RoutingNo := Family."Routing No.";
                end;
                /* //Bc Upgrade YADAVM09 Drink it code commented>>
                                // <<DITW110.00.12A HBA 22/06/2018 NRQ#68221
                                //IF (RoutingNo <> "Routing No.") THEN BEGIN
                                if (RoutingNo <> "Routing No.") and ("Routing No." = '') then begin
                                    // >>DITW110.00.12A HBA NRQ#68221

                                    //HEI.01>>
                                    //"Routing No." := RoutingNo;
                                    VALIDATE("Routing No.", RoutingNo);
                                    //HEI.01<<
                                    MODIFY;
                                end;
                                *///Bc Upgrade YADAVM09 Drink it code commented<<

                ProdOrderLine.LOCKTABLE();

                CheckReservationExist();

                if CalcLines then begin
                    if not CreateProdOrderLines.Copy("Production Order", Direction, '', false) then
                        ErrorOccured := true;
                end else begin
                    ProdOrderLine.SETRANGE(Status, Status);
                    ProdOrderLine.SETRANGE("Prod. Order No.", "No.");
                    if CalcRoutings or CalcComponents then begin
                        if ProdOrderLine.FIND('-') then
                            repeat
                                if CalcRoutings then begin
                                    ProdOrderRtngLine.SETRANGE(Status, Status);
                                    ProdOrderRtngLine.SETRANGE("Prod. Order No.", "No.");
                                    ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
                                    ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
                                    if ProdOrderRtngLine.FINDSET(true) then
                                        repeat
                                            ProdOrderRtngLine.SetSkipUpdateOfCompBinCodes(true);
                                            ProdOrderRtngLine.DELETE(true);
                                        until ProdOrderRtngLine.NEXT() = 0;
                                end;
                                if CalcComponents then begin
                                    ProdOrderComp.SETRANGE(Status, Status);
                                    ProdOrderComp.SETRANGE("Prod. Order No.", "No.");
                                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                    ProdOrderComp.DELETEALL(true);
                                end;
                            until ProdOrderLine.NEXT() = 0;
                        if ProdOrderLine.FIND('-') then
                            repeat
                                if CalcComponents then
                                    CheckProductionBOMStatus(ProdOrderLine."Production BOM No.", ProdOrderLine."Production BOM Version Code");
                                if CalcRoutings then
                                    CheckRoutingStatus(ProdOrderLine."Routing No.", ProdOrderLine."Routing Version Code");
                                ProdOrderLine."Due Date" := "Due Date";
                                if not CalcProdOrder.Calculate(ProdOrderLine, Direction, CalcRoutings, CalcComponents, false, false) then
                                    ErrorOccured := true;
                            until ProdOrderLine.NEXT() = 0;
                    end;
                end;
                if (Direction = Direction::Backward) and
                   ("Source Type" = "Source Type"::Family)
                then begin
                    SetUpdateEndDate();
                    VALIDATE("Due Date", "Due Date");
                end;

                if Status = Status::Released then begin
                    ProdOrderStatusMgt.FlushProdOrder("Production Order", Status, WORKDATE());
                    WhseProdRelease.Release("Production Order");
                    if CreateInbRqst then
                        WhseOutputProdRelease.Release("Production Order");
                    /* //Bc Upgrade YADAVM09 Drink it code commented>>
                //<<QXL9.00.001 DAT 23/03/2016
                if QualitySetup.READPERMISSION then begin
                    QualityTestHEader.RESET;
                    QualityTestHEader.SETRANGE("Source Type", DATABASE::"Production Order");
                    QualityTestHEader.SETRANGE("Source Subtype", Status);
                    QualityTestHEader.SETRANGE("Source ID", "No.");
                    QualityTestHEader.SETFILTER(Status, '<>%1', QualityTestHEader.Status::Quarantine);
                    if QualityTestHEader.FIND('-') then
                        ERROR(Text2035100, "Production Order".TABLENAME, QualityTestHEader.TABLENAME)
                    else begin
                        QualityTestHEader.SETRANGE(Status, QualityTestHEader.Status::Quarantine);
                        QualityTestHEader.DELETEALL;
                        ProdOrderLine.SETRANGE(Status, Status);
                        ProdOrderLine.SETRANGE("Prod. Order No.", "No.");
                        if ProdOrderLine.FIND('-') then
                            repeat
                                ProdOrderRtngLine.SETRANGE(Status, Status);
                                ProdOrderRtngLine.SETRANGE("Prod. Order No.", "No.");
                                ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
                                ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
                                if ProdOrderRtngLine.FIND('-') then
                                    repeat
                                        CreateInProcessTest.RUN(ProdOrderRtngLine);
                                    until ProdOrderRtngLine.NEXT = 0;
                            until ProdOrderLine.NEXT = 0;
                    end;
                end;
                // >>DITW15.00.00.22 PRODW14.00.00.08 DDR - PRODW14.00.00.08.10 DLE

                // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                // <<DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009
                if BrewingSetup.READPERMISSION then begin
                    BrewingManagement.GetProductGroup("Source No.", ProductGroup);
                    if ProductGroup."Gyle No. Mandatory" then begin
                        if "Gyle No." = '' then begin
                            BrewingSetup.GET;
                            BrewingSetup.TESTFIELD("Production Tracking Nos.");
                            NoSeriesMgt.InitSeries(BrewingSetup."Production Tracking Nos.", "Gyle No. Series", TODAY,
                                                   "Gyle No.", "Gyle No. Series");
                        end;
                    end;
                end;
                // >>DITW15.00.00.25.01-PRODW14.00.00.08.05A
            end;

            // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
            // <<DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009
            if CompTrackingEntry.READPERMISSION then begin
                CompTrackingEntry.RESET;
                CompTrackingEntry.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                CompTrackingEntry.SETRANGE("Source Subtype", Status);
                CompTrackingEntry.SETRANGE("Source ID", "No.");
                CompTrackingEntry.DELETEALL;
                ProdOrderComp.SETRANGE(Status, Status);
                ProdOrderComp.SETRANGE("Prod. Order No.", "No.");
                ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                if ProdOrderComp.FIND('-') then
                    ProdOrderComp.MODIFYALL("Calculation Required", false);
                //>>QXL9.00.001 DAT 23/03/2016
                */ //Bc Upgrade YADAVM09 Drink it code commented<<
                end;
                // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
                // >>DITW15.00.00.25.01-PRODW14.00.00.08.05A

                if ErrorOccured then
                    MESSAGE(Text005, ProdOrder.TABLECAPTION, ProdOrderLine.FIELDCAPTION("Bin Code"));
                /* //Bc upgrade YADAVM09 Drink it field "Routing Version Code" is used>>
                                //HEI.01>>
                                RoutingLine.SETRANGE("Routing No.", "Routing No.");
                                RoutingLine.SETRANGE("Version Code", "Routing Version Code");
                                if RoutingLine.FINDFIRST then begin
                                    if (RoutingLine."Zone Code" <> '') then begin
                                        "Zone Code" := RoutingLine."Zone Code";
                                        if RoutingLine."Bin Code" <> '' then
                                            "Bin Code" := RoutingLine."Bin Code";
                                        MODIFY;
                                        ProdOrderLine.SETRANGE(Status, Status);
                                        ProdOrderLine.SETRANGE("Prod. Order No.", "No.");
                                        //HEI.04>>
                                        //IF ProdOrderLine.FINDFIRST THEN
                                        if ProdOrderLine.FIND('-') then
                                            //HEI.04<<
                                            repeat
                                                //HEI.04>>
                                                //IF ("Bin Code" = ProdOrderLine."Bin Code") AND (RoutingLine."Bin Code" = '') THEN
                                                //ProdOrderLine."Bin Code" := RoutingLine."Bin Code"
                                                //ELSE
                                                //HEI.04<<
                                                ProdOrderLine."Bin Code" := "Bin Code";
                                                //HEI.04>>
                                                //ProdOrderLine."Zone Code" := RoutingLine."Zone Code";
                                                ProdOrderLine."Zone Code" := "Zone Code";
                                                //HEI.04<<
                                                ProdOrderLine.MODIFY;
                                            until ProdOrderLine.NEXT = 0;
                                    end;

                                end;
                */ //Bc upgrade YADAVM09 Drink it field "Routing Version Code" is used<<
                   //HEI.05>>
                   // HEI.03 >>
                   //ProdOrderLine.SETRANGE(Status,Status);
                   //ProdOrderLine.SETRANGE("Prod. Order No.","No.");
                   //IF ProdOrderLine.FINDSET THEN REPEAT
                   //  ProdOrderLine.VALIDATE("Ending Date-Time");
                   //  ProdOrderLine.MODIFY;
                   //  "Starting Date" := DT2DATE(ProdOrderLine."Starting Date-Time");
                   //UNTIL ProdOrderLine.NEXT = 0;
                   // HEI.03 <<

                ProdOrderLineL.SETRANGE(Status, Status);
                ProdOrderLineL.SETRANGE("Prod. Order No.", "No.");
                if ProdOrderLineL.FIND('-') then begin
                    repeat
                        ProdOrderLineL.VALIDATE("Ending Date-Time");
                        ProdOrderLineL.MODIFY(true);
                    until ProdOrderLineL.NEXT() = 0;
                    VALIDATE("Ending Date", DT2DATE(ProdOrderLineL."Ending Date-Time"));
                    MODIFY(true);
                end;
                //HEI.05<<

                //HEI.01<<

                //HEI.02>>
                L_UpdateTileCode("Production Order");
                MODIFY();
                //HEI.02<<
            end;

            trigger OnPreDataItem();
            begin
                /* //Bc Upgrade YADAVM09 Drink it code Commented>>
                  // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                  if ProdOrderSet then begin
                      SETRANGE(Status, ProdOrder.Status);
                      SETRANGE("No.", ProdOrder."No.");
                  end;
                  // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
                  */ //Bc Upgrade YADAVM09 Drink it code Commented<<

                IF GUIALLOWED THEN //HEI.07
                    Window.OPEN(
                     Text000 +
                     Text001 +
                      Text002);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(Direction; Direction)
                    {
                        CaptionML = ENU = 'Scheduling direction',
                                    FRA = 'Direction';
                        OptionCaptionML = ENU = 'Forward,Back',
                                          FRA = 'Aval,Amont';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Direction field.';
                    }
                    group(Calculate)
                    {
                        CaptionML = ENU = 'Calculate',
                                    FRA = 'Calculer';
                        field(CalcLines; CalcLines)
                        {
                            CaptionML = ENU = 'Lines',
                                        FRA = 'Lignes';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the CalcLines field.';

                            trigger OnValidate();
                            begin
                                if CalcLines then begin
                                    CalcRoutings := true;
                                    CalcComponents := true;
                                end;
                            end;
                        }
                        field(CalcRoutings; CalcRoutings)
                        {
                            CaptionML = ENU = 'Routings',
                                        FRA = 'Gammes';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the CalcRoutings field.';

                            trigger OnValidate();
                            begin
                                if not CalcRoutings then
                                    if CalcLines then
                                        ERROR(Text003);
                            end;
                        }
                        field(CalcComponents; CalcComponents)
                        {
                            CaptionML = ENU = 'Component Need',
                                        FRA = 'Besoin composant';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the CalcComponents field.';

                            trigger OnValidate();
                            begin
                                if not CalcComponents then
                                    if CalcLines then
                                        ERROR(Text004);
                            end;
                        }
                    }
                    group(Warehouse)
                    {
                        CaptionML = ENU = 'Warehouse',
                                    FRA = 'Entrepôt';
                        field(CreateInbRqst; CreateInbRqst)
                        {
                            CaptionML = ENU = 'Create Inbound Request',
                                        FRA = 'Créer demande d''enlogement';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the CreateInbRqst field.';
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            CalcLines := true;
            CalcRoutings := true;
            CalcComponents := true;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        //HEI.08>>
        // UnitTestingValue.SkipTestScriptExecutionPROD();//Bc Upgrade YADAVM09 test script object will consider it later phase
        //HEI.08<<


        Direction := Direction::Backward;
    end;

    var
        Text000: TextConst ENU = 'Refreshing Production Orders...\\', FRA = 'Actualisation des O.F....\\';
        Text001: TextConst ENU = 'Status         #1##########\', FRA = 'Statut         #1##########\';
        Text002: TextConst ENU = 'No.            #2##########', FRA = 'N°             #2##########';
        Text003: TextConst ENU = 'Routings must be calculated, when lines are calculated.', FRA = 'Lorsque les lignes sont calculées, les gammes doivent l''être aussi.';
        Text004: TextConst ENU = 'Component Need must be calculated, when lines are calculated.', FRA = 'Lorsque les lignes sont calculées, les besoins en composants doivent l''être aussi.';
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        CreateProdOrderLines: Codeunit "Create Prod. Order Lines";
        WhseProdRelease: Codeunit "Whse.-Production Release";
        WhseOutputProdRelease: Codeunit "Whse.-Output Prod. Release";
        Window: Dialog;
        Direction: Option Forward,Backward;
        CalcLines: Boolean;
        CalcRoutings: Boolean;
        CalcComponents: Boolean;
        CreateInbRqst: Boolean;
        Text005: TextConst ENU = 'One or more of the lines on this %1 require special warehouse handling. The %2 for these lines has been set to blank.', FRA = 'Une ou plusieurs lignes de ce %1 requièrent un délai entrepôt spécial. Le %2 pour ces lignes a été défini sur une valeur vide.';
        DeletePickedLinesQst: TextConst Comment = 'Production order no.: Components for production order 101001 have already been picked. Do you want to continue?', ENU = 'Components for production order %1 have already been picked. Do you want to continue?', FRA = 'Des composants pour l''ordre de fabrication %1 ont déjà été prélevés. Voulez-vous continuer ?';
        ProdOrder: Record "Production Order";
        //CreateInProcessTest: Codeunit "Create In Proc. Test";//Bc Upgrade YADAVM09 Drink it object
        //BrewingManagement: Codeunit "Brewing Management";//Bc Upgrade YADAVM09 Drink it object
        ProdOrderSet: Boolean;
        //QualitySetup: Record "Quality Setup";//Bc Upgrade YADAVM09 Drink it object
        //QualityTestHEader: Record "Quality Test Header";//Bc Upgrade YADAVM09 Drink it object
        Text2035100: TextConst ENU = 'You cannot refresh the %1 because there exists at least one %2.', FRA = 'Vous ne pouvez pas rafraîchir le %1 car il existe au moins un %2.';
    // UnitTestingValue: Record "Unit Testing Value FND";//Bc Upgrade YADAVM09 Blocked will consider testscript related objects in later phase

    local procedure CheckReservationExist();
    var
        ProdOrderLine2: Record "Prod. Order Line";
        ProdOrderComp2: Record "Prod. Order Component";
    begin
        // Not allowed to refresh if reservations exist
        if not (CalcLines or CalcComponents) then
            exit;

        ProdOrderLine2.SETRANGE(Status, "Production Order".Status);
        ProdOrderLine2.SETRANGE("Prod. Order No.", "Production Order"."No.");
        if ProdOrderLine2.FIND('-') then
            repeat
                if CalcLines then begin
                    ProdOrderLine2.CALCFIELDS("Reserved Qty. (Base)");
                    if ProdOrderLine2."Reserved Qty. (Base)" <> 0 then
                        if ShouldCheckReservedQty(
                             ProdOrderLine2."Prod. Order No.", 0, DATABASE::"Prod. Order Line",
                             ProdOrderLine2.Status.AsInteger(), ProdOrderLine2."Line No.", DATABASE::"Prod. Order Component")
                        then
                            ProdOrderLine2.TESTFIELD("Reserved Qty. (Base)", 0);
                end;

                if CalcComponents then begin
                    ProdOrderComp2.SETRANGE(Status, ProdOrderLine2.Status);
                    ProdOrderComp2.SETRANGE("Prod. Order No.", ProdOrderLine2."Prod. Order No.");
                    ProdOrderComp2.SETRANGE("Prod. Order Line No.", ProdOrderLine2."Line No.");
                    ProdOrderComp2.SETAUTOCALCFIELDS("Reserved Qty. (Base)");
                    if ProdOrderComp2.FIND('-') then begin
                        repeat
                            if ProdOrderComp2."Reserved Qty. (Base)" <> 0 then
                                if ShouldCheckReservedQty(
                                     ProdOrderComp2."Prod. Order No.", ProdOrderComp2."Line No.",
                                     DATABASE::"Prod. Order Component", ProdOrderComp2.Status.AsInteger(),
                                     ProdOrderComp2."Prod. Order Line No.", DATABASE::"Prod. Order Line")
                                then
                                    ProdOrderComp2.TESTFIELD("Reserved Qty. (Base)", 0);
                        until ProdOrderComp2.NEXT() = 0;
                    end;
                end;
            until ProdOrderLine2.NEXT() = 0;
    end;

    local procedure ShouldCheckReservedQty(ProdOrderNo: Code[20]; LineNo: Integer; SourceType: Integer; Status: Option; ProdOrderLineNo: Integer; SourceType2: Integer): Boolean;
    var
        ReservEntry: Record "Reservation Entry";
    begin
        ReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Reservation Status", ReservEntry."Reservation Status"::Reservation);
        ReservEntry.SETRANGE("Source ID", ProdOrderNo);
        ReservEntry.SETRANGE("Source Ref. No.", LineNo);
        ReservEntry.SETRANGE("Source Type", SourceType);
        ReservEntry.SETRANGE("Source Subtype", Status);
        ReservEntry.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);

        if ReservEntry.FINDFIRST() then begin
            ReservEntry.GET(ReservEntry."Entry No.", not ReservEntry.Positive);
            exit(
              not ((ReservEntry."Source Type" = SourceType2) and
                   (ReservEntry."Source ID" = ProdOrderNo) and (ReservEntry."Source Subtype" = Status)));
        end;

        exit(false);
    end;

    local procedure CheckProductionBOMStatus(ProdBOMNo: Code[20]; ProdBOMVersionNo: Code[20]);
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMVersion: Record "Production BOM Version";
    begin
        if ProdBOMNo = '' then
            exit;

        if ProdBOMVersionNo = '' then begin
            ProductionBOMHeader.GET(ProdBOMNo);
            ProductionBOMHeader.TESTFIELD(Status, ProductionBOMHeader.Status::Certified);
        end else begin
            ProductionBOMVersion.GET(ProdBOMNo, ProdBOMVersionNo);
            ProductionBOMVersion.TESTFIELD(Status, ProductionBOMVersion.Status::Certified);
        end;
    end;

    local procedure CheckRoutingStatus(RoutingNo: Code[20]; RoutingVersionNo: Code[20]);
    var
        RoutingHeader: Record "Routing Header";
        RoutingVersion: Record "Routing Version";
    begin
        if RoutingNo = '' then
            exit;

        if RoutingVersionNo = '' then begin
            RoutingHeader.GET(RoutingNo);
            RoutingHeader.TESTFIELD(Status, RoutingHeader.Status::Certified);
        end else begin
            RoutingVersion.GET(RoutingNo, RoutingVersionNo);
            RoutingVersion.TESTFIELD(Status, RoutingVersion.Status::Certified);
        end;
    end;

    procedure InitializeRequest(Direction2: Option Forward,Backward; CalcLines2: Boolean; CalcRoutings2: Boolean; CalcComponents2: Boolean; CreateInbRqst2: Boolean);
    begin
        Direction := Direction2;
        CalcLines := CalcLines2;
        CalcRoutings := CalcRoutings2;
        CalcComponents := CalcComponents2;
        CreateInbRqst := CreateInbRqst2;
    end;

    local procedure IsComponentPicked(ProdOrder: Record "Production Order"): Boolean;
    var
        ProdOrderComp: Record "Prod. Order Component";
    begin
        ProdOrderComp.SETRANGE(Status, ProdOrder.Status);
        ProdOrderComp.SETRANGE("Prod. Order No.", ProdOrder."No.");
        ProdOrderComp.SETFILTER("Qty. Picked", '<>0');
        exit(not ProdOrderComp.ISEMPTY);
    end;

    procedure SetRequestForm(GUI: Boolean);
    begin
        // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
        CurrReport.USEREQUESTPAGE(GUI);
    end;

    procedure SetProdOrder(NewProdOrder: Record "Production Order");
    begin
        ProdOrder := NewProdOrder;
        ProdOrderSet := true;
    end;

    local procedure L_UpdateTileCode(var pProductionOrder: Record "Production Order");
    var
        lRoleCenterTileSetup: Record "Role Center Tile Setup FND";
        lDimensionSetEntry: Record "Dimension Set Entry";
        lStatus: Enum "Production Order Status";
        lProdOrderNo: Code[20];
        ProductionOrder: Record "Production Order";
        lRoleCentreTileCode: Text[30];
    begin
        //HEI.02>>
        lRoleCentreTileCode := pProductionOrder."Role Centre Tile Code FND";

        pProductionOrder."Role Centre Tile Code FND" := '';
        lStatus := pProductionOrder.Status;
        lProdOrderNo := pProductionOrder."No.";

        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", pProductionOrder."Location Code");
        lRoleCenterTileSetup.SETRANGE("Zone Code", pProductionOrder."Zone Code FND");
        if lRoleCenterTileSetup.FINDFIRST() then
            repeat
                if ((lRoleCenterTileSetup."Dimension Code" = '') and (lRoleCenterTileSetup."Dimension Filter Value" = '')) then
                    pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                if ((lRoleCenterTileSetup."Dimension Code" <> '') or (lRoleCenterTileSetup."Dimension Filter Value" <> '')) then begin
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    if (lRoleCenterTileSetup."Dimension Code" <> '') then
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    if (lRoleCenterTileSetup."Dimension Filter Value" <> '') then
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    if lDimensionSetEntry.FINDFIRST() then
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            until lRoleCenterTileSetup.NEXT() = 0;

        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", pProductionOrder."Location Code");
        lRoleCenterTileSetup.SETRANGE("Zone Code", '');
        if lRoleCenterTileSetup.FINDFIRST() then
            repeat
                if ((lRoleCenterTileSetup."Dimension Code" = '') and (lRoleCenterTileSetup."Dimension Filter Value" = '')) then
                    pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                if ((lRoleCenterTileSetup."Dimension Code" <> '') or (lRoleCenterTileSetup."Dimension Filter Value" <> '')) then begin
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    if (lRoleCenterTileSetup."Dimension Code" <> '') then
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    if (lRoleCenterTileSetup."Dimension Filter Value" <> '') then
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    if lDimensionSetEntry.FINDFIRST() then
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            until lRoleCenterTileSetup.NEXT() = 0;


        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", '');
        lRoleCenterTileSetup.SETRANGE("Zone Code", pProductionOrder."Zone Code FND");
        if lRoleCenterTileSetup.FINDFIRST() then
            repeat
                if ((lRoleCenterTileSetup."Dimension Code" = '') and (lRoleCenterTileSetup."Dimension Filter Value" = '')) then
                    pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                if ((lRoleCenterTileSetup."Dimension Code" <> '') or (lRoleCenterTileSetup."Dimension Filter Value" <> '')) then begin
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    if (lRoleCenterTileSetup."Dimension Code" <> '') then
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    if (lRoleCenterTileSetup."Dimension Filter Value" <> '') then
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    if lDimensionSetEntry.FINDFIRST() then
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            until lRoleCenterTileSetup.NEXT() = 0;

        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", '');
        lRoleCenterTileSetup.SETRANGE("Zone Code", '');
        if lRoleCenterTileSetup.FINDFIRST() then
            repeat
                if ((lRoleCenterTileSetup."Dimension Code" <> '') or (lRoleCenterTileSetup."Dimension Filter Value" <> '')) then begin
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    if (lRoleCenterTileSetup."Dimension Code" <> '') then
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    if (lRoleCenterTileSetup."Dimension Filter Value" <> '') then
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    if lDimensionSetEntry.FINDFIRST() then
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            until lRoleCenterTileSetup.NEXT() = 0;

        if ((pProductionOrder."Role Centre Tile Code FND" = '') and (lRoleCentreTileCode <> '')) then
            pProductionOrder."Role Centre Tile Code FND" := lRoleCentreTileCode;
        //HEI.02<<
    end;

    procedure SetValues(PDirection: Option Forward,Backward; PCalcLines: Boolean; PCalcRoutings: Boolean; PCalcComponents: Boolean);
    begin
        Direction := PDirection;
        CalcLines := PCalcLines;
        CalcRoutings := PCalcRoutings;
        CalcComponents := PCalcComponents;
    end;
}

