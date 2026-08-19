report 54001 "Import Firm. Prod. Orders"
{
    // version HEI.01

    // HEI.01 FDD-PRDGAP034 IBM HORTOC01 22.06.2017
    //     # new report - import firm. prod. orders from excel
    // HEI.02 RFC-CHG0254802 IBM.LS 16.10.2018
    //   # Added code to add "Routing Version Code" and "Production BoM Version Code"
    //   # Added code to execute the Production Order Import and Refresh process Automatically.
    // HEI.03 RFC-CHG0254802 IBM.LS 15.11.2018
    //   # Added code to update "Starting Date" & "Ending Date" as per "Due Date".
    // HEI.04 CHG2020865 KUMARN15 07.10.2019
    //   # Code changes to incorpoarte Start Date and Start Time columns
    // HEI.05 CHG2020865 MATHEJ01 04.11.2019
    //   #Modified Functions: AnalyzeData
    //     # Local Variable DocDate renamed to DueDate
    //     # New LocalVariables: ProdBoMVer, SKU, Text0001, Text0002, Text0003, Text0004
    // HEI.06 CHG2090873 IBM POENAB02 14.12.2020 Update on Role Tile funtionality
    //   # Modified function AnalyzeData
    // HEI.07 CHG2103273 IBM.LS      18.06.2021
    //   # Added and Commented Code
    //   # SiteId and ZoneId text length changed from 20 to 10.
    // HEI.08 CHG2132155 IBM.LS      26.10.2021
    //   # Added and Commented Code

    // BC Upgrade SHUKLP03 >>
    // HEI.02 => code inside procedure AnalyzeData() Blocked because DrinkIT field "Routing Version Code", "Production BOM Version Code" are used.
    // some part of code inside procedure CreateProductionOrder() is blocked because of DrinkIT dependency.
    // BC Upgrade SHUKLP03 <<
    //BC Upgrade kamnay01 Added drinkit fields , Blocked this code because in find we are running drinkit codeunit and fields so I commented the whole code becuse it lead performance issue and data inconsistency.

    ProcessingOnly = true;
    ApplicationArea = all;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Import From"; '')
                {
                    ApplicationArea = All;
                }
                field("WorkBook File Name"; FileName)
                {
                    CaptionML = ENU = 'Workbook File Name',
                                NLD = 'Werkmapbestandsnaam';
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    var
                        FileMgt: Codeunit "File Management";
                        ExcelFileExtensionTok: Label 'Excel Files (*.xlsm)|*.xlsm';
                    begin
                        //FileName := FileMgt.UploadFile(Text006,ExcelFileExtensionTok); 
                        // BC Upgrade SHUKLP03 >> Added code to upload file.
                        UploadIntoStream(Text006, '', ExcelFileExtensionTok, FileName, InStream);
                        TempBlob.CreateOutStream(OutStream);
                        CopyStream(OutStream, InStream);
                        // BC Upgrade SHUKLP03 << Added code to upload file.
                    end;
                }
                field("Worksheet Name"; SheetName)
                {
                    CaptionML = ENU = 'Worksheet Name',
                                NLD = 'Werkbladnaam';
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        SheetName := ExcelBuf.SelectSheetsNameStream(InStream);
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        //HEI.02>>
        //IF Counter1 <> 0 THEN
        //  MESSAGE(Text008,Counter1);
        if Counter1 <> 0 then begin
            if (Counter1 = 1) and (SkipCount = 1) then
                MESSAGE(Text012, Counter1, Text010, SkipCount, Text010);
            if (Counter1 = 1) and (SkipCount > 1) then
                MESSAGE(Text012, Counter1, Text010, SkipCount, Text011);
            if (Counter1 > 1) and (SkipCount = 1) then
                MESSAGE(Text012, Counter1, Text011, SkipCount, Text010);
            if (Counter1 > 1) and (SkipCount > 1) then
                MESSAGE(Text012, Counter1, Text011, SkipCount, Text011);
            if (Counter1 = 1) and (SkipCount = 0) then
                MESSAGE(Text008, Counter1, Text010);
            if (Counter1 > 1) and (SkipCount = 0) then
                MESSAGE(Text008, Counter1, Text011);
        end else begin
            if SkipCount = 1 then
                MESSAGE(Text013, SkipCount, Text010);
            if SkipCount > 1 then
                MESSAGE(Text013, SkipCount, Text011);
        end;
        //HEI.02<<
    end;

    trigger OnPreReport();
    begin
        ExcelBuf.DELETEALL();
        ReadExcelSheet();
        AnalyzeData();
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        FileName: Text;
        InStream: InStream;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        SheetName: Text;
        Window: Dialog;
        TotalRecNo: Integer;
        RecNo: Integer;
        Counter1: Integer;
        Text000: TextConst ENU = 'Refreshing Production Orders...\\', FRA = 'Actualisation des O.F....\\';
        Text001: TextConst ENU = 'No.         #1##########\', FRA = 'Statut         #1##########\';
        Text002: TextConst ENU = 'Status      #2##########', FRA = 'N°             #2##########';
        Text003: TextConst ENU = 'Routings must be calculated, when lines are calculated.', FRA = 'Lorsque les lignes sont calculées, les gammes doivent l''être aussi.';
        Text004: TextConst ENU = 'Component Need must be calculated, when lines are calculated.', FRA = 'Lorsque les lignes sont calculées, les besoins en composants doivent l''être aussi.';
        Text005: TextConst ENU = 'One or more of the lines on this %1 require special warehouse handling. The %2 for these lines has been set to blank.', FRA = 'Une ou plusieurs lignes de ce %1 requièrent un délai entrepôt spécial. Le %2 pour ces lignes a été défini sur une valeur vide.';
        Text006: Label 'Import Excel File';
        Text007: Label 'Analyzing Data...\\';
        Text008: Label '%1 Firm Prod. %2 been successfully imported.';
        Text009: Label 'You do not have permissions on location code %1, zone code %2';
        Text010: Label 'Order has';
        Text011: Label 'Orders have';
        Text012: Label '%1 Firm Prod. %2 been successfully imported.\%3 Firm Prod. %4 been skipped due to ERROR in file!';
        Text013: Label '%1 Firm Prod. %2 been skipped due to ERROR in file!';
        DeletePickedLinesQty: TextConst Comment = 'Production order no.: Components for production order 101001 have already been picked. Do you want to continue?', ENU = 'Components of Production Order %1 have already been picked. Do you want to continue?', FRA = 'Des composants pour l''ordre de fabrication %1 ont déjà été prélevés. Voulez-vous continuer ?';
        Text2035100: TextConst ENU = 'You cannot refresh the %1 because there exists at least one %2.', FRA = 'Vous ne pouvez pas rafraîchir le %1 car il existe au moins un %2.';
        SkipCount: Integer;
        Text014: Label 'Routing Version Code not be blank for this Item %1 in file.';
        Text015: Label 'There is not any Active Routing / BOM version in Stockkeeping Unit.';
        Text016: Label 'A Certified Routing Version Code %1 does not exist in Routing Version.';

    procedure ReadExcelSheet();
    begin
        ExcelBuf.OpenBookStream(InStream, SheetName);
        ExcelBuf.ReadSheet();
    end;

    procedure AnalyzeData();
    var
        RegelExcelBuf: Record "Excel Buffer";
        HeaderExcelBuffer: Record "Excel Buffer";
        HeaderRowNo: Integer;
        OldRowNo: Integer;
        DueDate: Date;
        ItemNo: Code[20];
        Qty: Decimal;
        ZoneId: Code[10];
        SiteId: Code[10];
        ProdOrder: Record "Production Order";
        WarehouseEmployee: Record "Warehouse Employee";
        RoutingVerCode: Code[20];
        ProdBoMVerCode: Code[20];
        ProdOrderL: Record "Production Order";
        SkipProdOrder: Boolean;
        CreateProdOrder: Record "Production Order";
        StartTime: Time;
        StartDate: Date;
        Text0001: Label 'Either Starting Date & Time or a Due Date should be filled in.';
        Text0002: Label '"Date is missing. "';
        Text0003: Label 'Starting Time is missing.';
        Text0004: Label 'Starting Date is missing.';
        ItemL: Record Item;
        LocationL: Record Location;
        ZoneL: Record Zone;
        SKUL: Record "Stockkeeping Unit";
        RoutingVersionL: Record "Routing Version";
        ProductionBOMVersionL: Record "Production BOM Version";
        //BC Upgrade Kamnay01>> Varible added 
        Rec_Routingline: Record "Routing Line";
        endingdatecalc: Decimal;
        sETDURATION: Duration;
        Customstarttime: Time;

        RoutingLine: Record "Routing Line";
        TotalSetupTime: Decimal;
    //BC Upgrade Kamnay01<< varible added


    begin
        Window.OPEN(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := ExcelBuf.COUNT;
        RecNo := 1;
        Counter1 := 0;

        if ExcelBuf.FIND('-') then begin
            HeaderExcelBuffer := ExcelBuf;             //Store Header Row
            HeaderRowNo := RecNo;                      //Store Header Row Number
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                //HEI.02>>
                //HEI.05>>
                //CLEAR(DocDate);
                CLEAR(DueDate);
                //HEI.05<<
                //<<HEI.04
                CLEAR(StartDate);
                CLEAR(StartTime);
                //>>HEI.04
                CLEAR(ItemNo);
                CLEAR(Qty);
                CLEAR(SiteId);
                CLEAR(ZoneId);
                CLEAR(RoutingVerCode);
                CLEAR(ProdBoMVerCode);
                SkipProdOrder := true;
                //HEI.02<<
                case true of
                    (ExcelBuf."Row No." > HeaderRowNo) and (HeaderRowNo > 0):
                        begin
                            if ExcelBuf."Row No." <> OldRowNo then begin
                                OldRowNo := ExcelBuf."Row No.";

                                //<<HEI.04
                                //            IF ExcelBuf.GET(ExcelBuf."Row No.",1) THEN
                                //              EVALUATE(DocDate,ExcelBuf."Cell Value as Text");
                                //            IF ExcelBuf.GET(ExcelBuf."Row No.",2) THEN
                                //              ItemNo := ExcelBuf."Cell Value as Text";
                                //            IF ExcelBuf.GET(ExcelBuf."Row No.",3) THEN
                                //              EVALUATE(Qty,ExcelBuf."Cell Value as Text");
                                //            IF ExcelBuf.GET(ExcelBuf."Row No.",4) THEN
                                //              SiteId := ExcelBuf."Cell Value as Text";
                                //            IF ExcelBuf.GET(ExcelBuf."Row No.",5) THEN
                                //              ZoneId := ExcelBuf."Cell Value as Text";
                                //            //HEI.02>>
                                //            IF ExcelBuf.GET(ExcelBuf."Row No.",6) THEN
                                //              RoutingVerCode := ExcelBuf."Cell Value as Text";
                                //            IF ExcelBuf.GET(ExcelBuf."Row No.",7) THEN
                                //              ProdBoMVerCode := ExcelBuf."Cell Value as Text";
                                //
                                //            IF (DocDate = 0D) OR (ItemNo = '') OR (Qty = 0) OR (SiteId = '') OR (ZoneId = '') THEN BEGIN
                                //              SkipProdOrder := FALSE;
                                //              SkipCount += 1;
                                //            END;
                                //            IF SkipProdOrder THEN BEGIN
                                //            //HEI.02<<
                                //HEI.05>>
                                //IF ExcelBuf.GET(ExcelBuf."Row No.",1) THEN
                                //  EVALUATE(DocDate,ExcelBuf."Cell Value as Text");
                                //IF ExcelBuf.GET(ExcelBuf."Row No.",2) THEN
                                //  EVALUATE(StartDate,ExcelBuf."Cell Value as Text");
                                //IF ExcelBuf.GET(ExcelBuf."Row No.",3) THEN
                                //  EVALUATE(StartTime,ExcelBuf."Cell Value as Text");
                                if ExcelBuf.GET(ExcelBuf."Row No.", 1) then
                                    EVALUATE(StartDate, ExcelBuf."Cell Value as Text");
                                if ExcelBuf.GET(ExcelBuf."Row No.", 2) then
                                    EVALUATE(StartTime, ExcelBuf."Cell Value as Text");
                                if ExcelBuf.GET(ExcelBuf."Row No.", 3) then
                                    EVALUATE(DueDate, ExcelBuf."Cell Value as Text");
                                //HEI.05<<
                                if ExcelBuf.GET(ExcelBuf."Row No.", 4) then
                                    ItemNo := ExcelBuf."Cell Value as Text";
                                if ExcelBuf.GET(ExcelBuf."Row No.", 5) then
                                    EVALUATE(Qty, ExcelBuf."Cell Value as Text");
                                if ExcelBuf.GET(ExcelBuf."Row No.", 6) then
                                    SiteId := ExcelBuf."Cell Value as Text";
                                if ExcelBuf.GET(ExcelBuf."Row No.", 7) then
                                    ZoneId := ExcelBuf."Cell Value as Text";
                                if ExcelBuf.GET(ExcelBuf."Row No.", 8) then
                                    RoutingVerCode := ExcelBuf."Cell Value as Text";
                                //HEI.07>>
                                //HEI.08>>
                                // IF RoutingVerCode = '' THEN
                                // ERROR(Text014,ItemNo);
                                //HEI.08<<
                                //HEI.07<<
                                if ExcelBuf.GET(ExcelBuf."Row No.", 9) then
                                    ProdBoMVerCode := ExcelBuf."Cell Value as Text";
                                //HEI.07>>
                                CLEAR(ItemL);
                                CLEAR(LocationL);
                                CLEAR(ZoneL);
                                CLEAR(SKUL);
                                ItemL.GET(ItemNo);
                                LocationL.GET(SiteId);
                                ZoneL.GET(SiteId, ZoneId);
                                if not SKUL.GET(SiteId, ItemNo, '') then
                                    ERROR(Text015)
                                else begin
                                    RoutingVersionL.RESET();
                                    RoutingVersionL.SETCURRENTKEY("Routing No.", Status, "Version Code");
                                    RoutingVersionL.SETRANGE("Routing No.", SKUL."Routing No.");
                                    RoutingVersionL.SETRANGE(Status, RoutingVersionL.Status::Certified);
                                    //HEI.08>>
                                    if RoutingVerCode <> '' then
                                        //HEI.08<<
                                        RoutingVersionL.SETRANGE("Version Code", RoutingVerCode);
                                    if not RoutingVersionL.FINDFIRST() then
                                        ERROR(Text016, RoutingVerCode)
                                    //HEI.08>>
                                    else
                                        RoutingVerCode := RoutingVersionL."Version Code";
                                    //HEI.08<<
                                    if ProdBoMVerCode = '' then begin
                                        ProductionBOMVersionL.RESET();
                                        ProductionBOMVersionL.SETCURRENTKEY("Production BOM No.", Status, "Version Code", "Active FND");
                                        ProductionBOMVersionL.SETRANGE("Production BOM No.", SKUL."Production BOM No.");
                                        ProductionBOMVersionL.SETRANGE(Status, ProductionBOMVersionL.Status::Certified);
                                        ProductionBOMVersionL.SETFILTER("Version Code", '<>%1', '');
                                        ProductionBOMVersionL.SETRANGE("Active FND", true);
                                        if ProductionBOMVersionL.FINDFIRST() then
                                            ProdBoMVerCode := ProductionBOMVersionL."Version Code";
                                    end;
                                end;
                                //HEI.07<<
                                //HEI.05>>
                                //IF ((DocDate = 0D) AND ((StartDate = 0D) OR (StartTime = 0T))) OR (ItemNo = '') OR (Qty = 0) OR (SiteId = '') OR (ZoneId = '') THEN BEGIN
                                //SkipProdOrder := FALSE;
                                //SkipCount += 1;
                                //END;
                                //HEI.07>>
                                //IF ProdBoMVerCode = '' THEN BEGIN
                                //  IF SKU.GET(SiteId,ItemNo) THEN BEGIN
                                //    ProdBoMVer.RESET;
                                //    ProdBoMVer.SETRANGE("Production BOM No.",SKU."Production BOM No.");
                                //    ProdBoMVer.SETRANGE(Active,TRUE);
                                //    IF ProdBoMVer.FINDFIRST THEN
                                //      ProdBoMVerCode := ProdBoMVer."Version Code";
                                //  END;
                                //END;
                                //HEI.07<<
                                //HEI.05<<

                                if SkipProdOrder then begin
                                    //>>HEI.04
                                    /*
                                    WarehouseEmployee.RESET;
                                    WarehouseEmployee.SETRANGE(WarehouseEmployee."User ID",USERID);
                                    WarehouseEmployee.SETRANGE(WarehouseEmployee."Location Code",SiteId);
                                    WarehouseEmployee.SETRANGE(WarehouseEmployee."Zone Code",ZoneId);
                                    IF NOT WarehouseEmployee.FINDFIRST THEN
                                      ERROR(Text009,SiteId,ZoneId);
                                    */
                                    //HEI.03>>
                                    // ProdOrder.INIT;
                                    // ProdOrder.VALIDATE(Status,ProdOrder.Status::"Firm Planned");
                                    // ProdOrder."No." := '';
                                    // ProdOrder.INSERT(TRUE);
                                    CreateProdOrder.INIT();
                                    CreateProdOrder.VALIDATE(Status, CreateProdOrder.Status::"Firm Planned");
                                    CreateProdOrder."No." := '';
                                    CreateProdOrder.INSERT(true);
                                    //HEI.07>>
                                    ProdOrder.RESET();
                                    ProdOrder.SETCURRENTKEY("No.", Status);
                                    //HEI.07<<
                                    ProdOrder.SETRANGE("No.", CreateProdOrder."No.");
                                    ProdOrder.SETRANGE(Status, CreateProdOrder.Status);
                                    ProdOrder.FINDFIRST();
                                    //HEI.07>>
                                    ProdOrder.SetUpdateEndDate;
                                    //HEI.07<<
                                    //HEI.03<<
                                    ProdOrder.VALIDATE("Source Type", ProdOrder."Source Type"::Item);
                                    ProdOrder.VALIDATE("Source No.", ItemNo);
                                    ProdOrder.VALIDATE(Quantity, Qty);
                                    //<<HEI.04
                                    //              ProdOrder.VALIDATE("Due Date",DocDate);
                                    //HEI.05>>
                                    //              IF (StartDate <> 0D) AND (StartTime <> 0T) THEN BEGIN
                                    //                ProdOrder.VALIDATE("Starting Date",StartDate);
                                    //                ProdOrder.VALIDATE("Starting Time",StartTime);
                                    //              END ELSE
                                    //                ProdOrder.VALIDATE("Due Date",DocDate);
                                    //HEI.07>>
                                    //IF (DueDate = 0D) AND (StartDate = 0D) AND (StartTime = 0T) THEN
                                    //  ERROR(Text0002)
                                    //ELSE IF(DueDate = 0D) AND (StartDate = 0D) AND (StartTime <> 0T) THEN
                                    //  ERROR(Text0004)
                                    //ELSE IF (DueDate = 0D) AND (StartDate <> 0D) AND (StartTime = 0T) THEN
                                    //  ERROR(Text0003)
                                    //ELSE IF (DueDate <> 0D) AND (StartDate = 0D) AND (StartTime = 0T) THEN
                                    //  ProdOrder.VALIDATE("Due Date",DueDate)
                                    //ELSE IF (DueDate <> 0D) AND (StartDate <> 0D) AND (StartTime = 0T) THEN
                                    //  ERROR(Text0001)
                                    //ELSE IF (DueDate <> 0D) AND (StartDate = 0D) AND (StartTime <> 0T) THEN
                                    //  ERROR(Text0001)
                                    //ELSE IF (DueDate = 0D) AND (StartDate <> 0D) AND (StartTime <> 0T) THEN BEGIN
                                    //  ProdOrder.VALIDATE("Starting Date",StartDate);
                                    //  ProdOrder.VALIDATE("Starting Time",StartTime);
                                    //END ELSE IF (DueDate <> 0D) AND (StartDate <> 0D) AND (StartTime <> 0T)THEN
                                    //  ERROR(Text0001);
                                    //HEI.07<<
                                    //HEI.05<<
                                    //>>HEI.04


                                    ProdOrder.VALIDATE("Location Code", SiteId);
                                    ProdOrder.VALIDATE("Zone Code FND", ZoneId);

                                    //BC upgrade Kamnay01 >>This is Drinkit fields and used this fields by drinkit dependency.
                                    //HEI.02>>
                                    ProdOrder.VALIDATE("Routing Vrsn Code 112FDW", RoutingVerCode);
                                    ProdOrder.VALIDATE("Prod. BOM Vrsn Code 112FDW", ProdBoMVerCode);
                                    // HEI.02<<
                                    //BC upgrade Kamnay01 <<This is Drinkit fields and used this fields by drinkit dependency.
                                    //BC upgrade Kamnay01>> Bug Fix
                                    //HEI.07>>
                                    if (DueDate = 0D) and (StartDate = 0D) and (StartTime = 0T) then
                                        ERROR(Text0002);
                                    if (DueDate = 0D) and (StartDate = 0D) and (StartTime <> 0T) then
                                        ERROR(Text0004);
                                    if (DueDate = 0D) and (StartDate <> 0D) and (StartTime = 0T) then
                                        ERROR(Text0003);
                                    if (DueDate <> 0D) and (StartDate = 0D) and (StartTime = 0T) then begin
                                        ProdOrder.VALIDATE("Ending Date", DueDate);
                                        ProdOrder.VALIDATE("Due Date", DueDate);
                                    end;
                                    if (DueDate <> 0D) and (StartDate <> 0D) and (StartTime = 0T) then
                                        ERROR(Text0001);
                                    if (DueDate <> 0D) and (StartDate = 0D) and (StartTime <> 0T) then
                                        ERROR(Text0001);
                                    if (DueDate = 0D) and (StartDate <> 0D) and (StartTime <> 0T) then begin
                                        ProdOrder.VALIDATE("Starting Date", StartDate);
                                        ProdOrder.VALIDATE("Starting Time", StartTime);
                                        // ProdOrder.VALIDATE("Due Date", ProdOrder."Ending Date");
                                    end;
                                    if (DueDate <> 0D) and (StartDate <> 0D) and (StartTime <> 0T) then
                                        ERROR(Text0001);
                                    //BC upgrade Kamnay01<< Bug Fix

                                    //HEI.07<<
                                    //HEI.06>>
                                    ProdOrder.UpdateTileCode();
                                    //HEI.06<<
                                    ProdOrder.MODIFY(true);
                                    Counter1 += 1;
                                    //HEI.02>>
                                    ProdOrderL.RESET();
                                    //HEI.07>>
                                    ProdOrderL.SETCURRENTKEY("No.", Status);
                                    //HEI.07<<
                                    ProdOrderL.SETRANGE("No.", ProdOrder."No.");
                                    ProdOrderL.SETRANGE(Status, ProdOrder.Status);
                                    if ProdOrderL.FINDFIRST() then begin
                                        //<<HEI.04
                                        //                CreateProductionOrder(ProdOrderL."No.",ProdOrderL.Status,1,TRUE,TRUE,TRUE,FALSE);
                                        if (StartDate <> 0D) and (StartTime <> 0T) then   //BC upgrade Kamnay01 Bug Fix
                                            CreateProductionOrder(ProdOrderL."No.", ProdOrderL.Status.AsInteger(), 0, true, true, true, false)
                                        else
                                            //HEI.07>>
                                            if (DueDate <> 0D) then
                                                //HEI.07<<
                                                CreateProductionOrder(ProdOrderL."No.", ProdOrderL.Status.AsInteger(), 1, true, true, true, false);
                                        //>>HEI.04
                                        //BC Upgrade Kamnay01 >> Code added to update Starting Date-Time and Ending Date-Time as per the setup time and Start Date-Time.

                                        TotalSetupTime := 0;

                                        RoutingLine.Reset();

                                        RoutingLine.SetRange("Routing No.", ProdOrderL."Routing No. 112FDW");
                                        RoutingLine.SetRange("Version Code", ProdOrderL."Routing Vrsn Code 112FDW");

                                        if RoutingLine.FindSet() then
                                            repeat
                                                TotalSetupTime += RoutingLine."Setup Time";
                                            until RoutingLine.Next() = 0;

                                        //BC upgrade Kamnay01>> Bug Fix
                                        // ProdOrderL."Starting Date-Time" := CreateDateTime(StartDate, StartTime);
                                        // ProdOrderL."Ending Date-Time" :=
                                        // ProdOrderL."Starting Date-Time" + (TotalSetupTime * 3600000);
                                        // ProdOrderL."Starting Date" := DT2DATE(ProdOrderL."Starting Date-Time");
                                        // ProdOrderL."Starting Time" := DT2TIME(ProdOrderL."Starting Date-Time");
                                        // ProdOrderL."Ending Date" := DT2DATE(ProdOrderL."Ending Date-Time");
                                        // ProdOrderL."Ending Time" := DT2TIME(ProdOrderL."Ending Date-Time");
                                        // ProdOrderL.Modify(true);
                                        //BC upgrade Kamnay01<< Bug Fix
                                    end;
                                end;
                                //HEI.02<<

                            end;
                        end;
                end;
            until ExcelBuf.NEXT() = 0;
        end;

        Window.CLOSE();

    end;

    procedure CreateProductionOrder(var ProdOrderNo: Code[20]; ProdOrderStatus: Option Simulated,Planned,"Firm Planned",Released,Finished; Direction: Option Forward,Backward; CalcLines: Boolean; CalcRoutings: Boolean; CalcComponents: Boolean; CreateInbRqst: Boolean);
    var
        ProdOrderL: Record "Production Order";
        WindowL: Dialog;
        ItemL: Record Item;
        SKUL: Record "Stockkeeping Unit";
        RoutingNoL: Code[20];
        FamilyL: Record Family;
        ProdOrderLineL: Record "Prod. Order Line";
        CreateProdOrderLinesL: Codeunit "Create Prod. Order Lines";
        ErrorOccuredL: Boolean;
        ProdOrderRtngLineL: Record "Prod. Order Routing Line";
        ProdOrderCompL: Record "Prod. Order Component";
        CalcProdOrderL: Codeunit "Calculate Prod. Order";
        // QualitySetupL : Record "Quality Setup";
        // QualityTestHeaderL : Record "Quality Test Header";
        ProdOrderStatusMgtL: Codeunit "Prod. Order Status Management";
        WhseProdReleaseL: Codeunit "Whse.-Production Release";
        WhseOutputProdReleaseL: Codeunit "Whse.-Output Prod. Release";
    // CreateInProcessTestL : Codeunit "Create In Proc. Test";
    // BrewingSetupL : Record "Production Setup";
    // BrewingManagementL : Codeunit "Brewing Management";
    // ProductGroupL : Record "Product Group";
    // NoSeriesMgtL: Codeunit NoSeriesManagement;
    //CompTrackingEntryL : Record "Comp. Tracking Entry";
    begin
        //HEI.02>>
        if ProdOrderStatus = ProdOrderStatus::Finished then
            CurrReport.SKIP();

        ProdOrderL.RESET();
        //HEI.07>>
        ProdOrderL.SETCURRENTKEY("No.", Status);
        //HEI.07<<
        ProdOrderL.SETRANGE("No.", ProdOrderNo);
        ProdOrderL.SETRANGE(Status, ProdOrderStatus);
        if ProdOrderL.FINDFIRST() then begin
            WindowL.OPEN(Text000 + Text001 + Text002);

            if Direction = Direction::Backward then
                ProdOrderL.TESTFIELD("Due Date");

            if CalcLines and IsComponentPicked(ProdOrderL) then
                if not CONFIRM(STRSUBSTNO(DeletePickedLinesQty, ProdOrderL."No.")) then
                    CurrReport.SKIP();

            WindowL.UPDATE(1, ProdOrderL."No.");
            WindowL.UPDATE(2, ProdOrderL.Status);

            // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field "Actual Quantity", "Original Quantity" are used.
            // ProdOrderL."Actual Quantity" := 0;
            // ProdOrderL."Original Quantity" := ProdOrderL.Quantity;
            // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field "Actual Quantity", "Original Quantity" are used.

            //HEI.07>>
            //ProdOrderL.MODIFY;
            //HEI.07<<
            if ProdOrderL."Routing No. 112FDW" <> '' then
                RoutingNoL := ProdOrderL."Routing No. 112FDW"
            //HEI.07>>
            else begin
                //HEI.07<<
                case ProdOrderL."Source Type" of
                    ProdOrderL."Source Type"::Item:
                        if ItemL.GET(ProdOrderL."Source No.") then begin
                            if SKUL.GET(ProdOrderL."Location Code", ProdOrderL."Source No.", '') then
                                RoutingNoL := SKUL."Routing No."
                            else
                                RoutingNoL := ItemL."Routing No.";
                        end;

                    ProdOrderL."Source Type"::Family:
                        if FamilyL.GET(ProdOrderL."Source No.") then
                            RoutingNoL := FamilyL."Routing No.";
                end;
                //HEI.07>>
                //IF (RoutingNoL <> ProdOrderL."Routing No.") AND (ProdOrderL."Routing No." = '') THEN BEGIN
                //  ProdOrderL."Routing No." := RoutingNoL;
                //  ProdOrderL.MODIFY;
                //END;
                if RoutingNoL <> '' then
                    ProdOrderL.VALIDATE("Routing No. 112FDW", RoutingNoL);
                ProdOrderL.MODIFY();
            end;
            //HEI.07<<
            ProdOrderLineL.LOCKTABLE();
            //HEI.07>>
            //CheckReservationExist(ProdOrderNo,ProdOrderStatus,CalcLines,CalcComponents);
            CheckReservationExist(ProdOrderL."No.", ProdOrderL.Status.AsInteger(), CalcLines, CalcComponents);
            //HEI.07<<

            if CalcLines then begin
                if not CreateProdOrderLinesL.Copy(ProdOrderL, Direction, '', false) then
                    ErrorOccuredL := true;
            end else begin
                ProdOrderLineL.SETRANGE("Prod. Order No.", ProdOrderL."No.");
                ProdOrderLineL.SETRANGE(Status, ProdOrderL.Status);
                if CalcRoutings or CalcComponents then begin
                    if ProdOrderLineL.FIND('-') then begin
                        repeat
                            if CalcRoutings then begin
                                ProdOrderRtngLineL.SETRANGE("Prod. Order No.", ProdOrderL."No.");
                                ProdOrderRtngLineL.SETRANGE(Status, ProdOrderL.Status);
                                ProdOrderRtngLineL.SETRANGE("Routing Reference No.", ProdOrderLineL."Routing Reference No.");
                                ProdOrderRtngLineL.SETRANGE("Routing No.", ProdOrderLineL."Routing No.");
                                if ProdOrderRtngLineL.findset(true) then
                                    repeat
                                        ProdOrderRtngLineL.SetSkipUpdateOfCompBinCodes(true);
                                        ProdOrderRtngLineL.DELETE(true);
                                    until ProdOrderRtngLineL.NEXT() = 0;
                                CheckRoutingStatus(ProdOrderLineL."Routing No.", ProdOrderLineL."Routing Version Code");
                            end;

                            if CalcComponents then begin
                                ProdOrderCompL.SETRANGE("Prod. Order No.", ProdOrderL."No.");
                                ProdOrderCompL.SETRANGE(Status, ProdOrderL.Status);
                                ProdOrderCompL.SETRANGE("Prod. Order Line No.", ProdOrderLineL."Line No.");
                                ProdOrderCompL.DELETEALL(true);
                                CheckProductionBOMStatus(ProdOrderLineL."Production BOM No.", ProdOrderLineL."Production BOM Version Code");
                            end;
                            //HEI.07>>
                            //ProdOrderLineL."Due Date" := ProdOrderL."Due Date";
                            if (Direction = Direction::Backward) and (ProdOrderL."Source Type" = ProdOrderL."Source Type"::Family) then begin
                                ProdOrderLineL.VALIDATE("Due Date", ProdOrderL."Due Date");
                                ProdOrderLineL.MODIFY(true);
                            end;
                            //HEI.07<<
                            if not CalcProdOrderL.Calculate(ProdOrderLineL, Direction, CalcRoutings, CalcComponents, false, false) then
                                ErrorOccuredL := true;
                            ProdOrderL.SetUpdateEndDate();
                            ProdOrderL.MODIFY(TRUE);
                        until ProdOrderLineL.NEXT() = 0;
                    end;
                end;
            end;

            if (Direction = Direction::Backward) and
              (ProdOrderL."Source Type" = ProdOrderL."Source Type"::Family)
            then begin
                ProdOrderL.SetUpdateEndDate();
                ProdOrderL.VALIDATE("Due Date", ProdOrderL."Due Date");
            end;

            if ProdOrderL.Status = ProdOrderL.Status::Released then begin
                ProdOrderStatusMgtL.FlushProdOrder(ProdOrderL, ProdOrderL.Status, WORKDATE());
                WhseProdReleaseL.Release(ProdOrderL);
                if CreateInbRqst then
                    WhseOutputProdReleaseL.Release(ProdOrderL);

                // if QualitySetupL.READPERMISSION then begin
                //     QualityTestHeaderL.RESET;
                //     QualityTestHeaderL.SETRANGE("Source Type", DATABASE::"Production Order");
                //     QualityTestHeaderL.SETRANGE("Source ID", ProdOrderL."No.");
                //     QualityTestHeaderL.SETRANGE("Source Subtype", ProdOrderL.Status);
                //     QualityTestHeaderL.SETFILTER(Status, '<>%1', QualityTestHeaderL.Status::Quarantine);
                //     if QualityTestHeaderL.FIND('-') then
                //         ERROR(Text2035100, ProdOrderL.TABLENAME, QualityTestHeaderL.TABLENAME)
                //     else begin
                //         QualityTestHeaderL.SETRANGE(Status, QualityTestHeaderL.Status::Quarantine);
                //         QualityTestHeaderL.DELETEALL;
                // BC Upgrade SHUKLP03 << Blocked because DrinkIT table QualitySetupL,QualityTestHeaderL is used.

                //BC Upgrade kamnay01 >> Blocked this code because in find we are running drinkit codeunit so I commented the whole code becuse it lead performance issue and data inconsistency.

                // ProdOrderLineL.SETRANGE("Prod. Order No.", ProdOrderL."No.");
                // ProdOrderLineL.SETRANGE(Status, ProdOrderL.Status);
                // if ProdOrderLineL.FIND('-') then
                //     repeat
                //         ProdOrderRtngLineL.SETRANGE("Prod. Order No.", ProdOrderL."No.");
                //         ProdOrderRtngLineL.SETRANGE(Status, ProdOrderL.Status);
                //         ProdOrderRtngLineL.SETRANGE("Routing Reference No.", ProdOrderLineL."Routing Reference No.");
                //         ProdOrderRtngLineL.SETRANGE("Routing No.", ProdOrderLineL."Routing No.");
                //         if ProdOrderRtngLineL.FIND('-') then
                //             repeat
                //             //CreateInProcessTestL.RUN(ProdOrderRtngLineL); // BC Upgrade SHUKLP03 << Blocked because DrinkIT Codeunit "Create In Proc. Test".
                //             until ProdOrderRtngLineL.NEXT() = 0;
                //     until ProdOrderLineL.NEXT() = 0;
                //     end; // BC Upgrade SHUKLP03 << Blocked because DrinkIT table QualitySetupL,QualityTestHeaderL is used.
                // end;   // BC Upgrade SHUKLP03 << Blocked because DrinkIT table QualitySetupL,QualityTestHeaderL is used.

                //BC Upgrade kamnay01 << Blocked this code because in find we are running drinkit codeunit so I commented the whole code becuse it lead performance issue and data inconsistency.

                // BC Upgrade SHUKLP03 >> Blocked because DrinkIT table BrewingSetupL,codeunit BrewingManagementL is used.
                // if BrewingSetupL.READPERMISSION then begin
                //     BrewingManagementL.GetProductGroup(ProdOrderL."Source No.", ProductGroupL);
                //     if ProductGroupL."Gyle No. Mandatory" then begin
                //         if ProdOrderL."Gyle No." = '' then begin
                //             BrewingSetupL.GET;
                //             BrewingSetupL.TESTFIELD("Production Tracking Nos.");
                //             NoSeriesMgtL.InitSeries(BrewingSetupL."Production Tracking Nos.", ProdOrderL."Gyle No. Series", TODAY,
                //                                    ProdOrderL."Gyle No.", ProdOrderL."Gyle No. Series");
                //         end;
                //     end;
                // end;
                // BC Upgrade SHUKLP03 << Blocked because DrinkIT table BrewingSetupL,codeunit BrewingManagementL is used.
            end;

            // BC Upgrade SHUKLP03 >> Blocked because DrinkIT table CompTrackingEntryL is used.
            // if CompTrackingEntryL.READPERMISSION then begin
            //     CompTrackingEntryL.RESET;
            //     CompTrackingEntryL.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
            //     CompTrackingEntryL.SETRANGE("Source ID", ProdOrderL."No.");
            //     CompTrackingEntryL.SETRANGE("Source Subtype", ProdOrderL.Status);
            //     CompTrackingEntryL.DELETEALL;
            // BC Upgrade SHUKLP03 << Blocked because DrinkIT table CompTrackingEntryL is used.


            //BC Upgrade Kamnay01 >>Blocked this code because in findset we are modifiying drinkit field so commented the whole code becuse it lead performance issue and data inconsistency.
            //HEI.07>>
            // ProdOrderLineL.RESET();
            // ProdOrderLineL.SETRANGE(Status, ProdOrderL.Status);
            // ProdOrderLineL.SETRANGE("Prod. Order No.", ProdOrderL."No.");
            // if ProdOrderLineL.FIND('-') then begin
            //     repeat
            //         ProdOrderCompL.RESET();
            //         ProdOrderCompL.SETRANGE(Status, ProdOrderL.Status);
            //         ProdOrderCompL.SETRANGE("Prod. Order No.", ProdOrderL."No.");
            //         ProdOrderCompL.SETRANGE("Prod. Order Line No.", ProdOrderLineL."Line No.");
            //         if ProdOrderCompL.findset() then
            //             // ProdOrderCompL.MODIFYALL("Calculation Required", false); // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Calculation Required". 
            //             ProdOrderLineL.MODIFY();
            //     until ProdOrderLineL.NEXT() = 0;
            // end;
            //HEI.07<<
            //end; // BC Upgrade SHUKLP03 << Blocked because DrinkIT table CompTrackingEntryL is used.
            //BC Upgrade Kamnay01 <<Blocked this code because in findset we are modifiying drinkit field so commented the whole code becuse it lead performance issue and data inconsistency.
            if ErrorOccuredL then
                MESSAGE(Text005, ProdOrderL.TABLECAPTION, ProdOrderLineL.FIELDCAPTION("Bin Code"));

            WindowL.CLOSE();
        end;
        //HEI.02<<
    end;

    local procedure CheckReservationExist(var ProdOrderNo: Code[20]; ProdOrderStatus: Option Simulated,Planned,"Firm Planned",Released,Finished; CalcLines: Boolean; CalcComponents: Boolean);
    var
        ProdOrderLineL: Record "Prod. Order Line";
        ProdOrderCompL: Record "Prod. Order Component";
    begin
        //HEI.02>>
        // Not allowed to refresh if reservations exist
        if not (CalcLines or CalcComponents) then
            exit;

        //HEI.07>>
        ProdOrderLineL.SETCURRENTKEY("Prod. Order No.", Status);
        //HEI.07<<
        ProdOrderLineL.SETRANGE("Prod. Order No.", ProdOrderNo);
        ProdOrderLineL.SETRANGE(Status, ProdOrderStatus);
        if ProdOrderLineL.FIND('-') then
            repeat
                if CalcLines then begin
                    ProdOrderLineL.CALCFIELDS("Reserved Qty. (Base)");
                    if ProdOrderLineL."Reserved Qty. (Base)" <> 0 then
                        if ShouldCheckReservedQty(
                          ProdOrderLineL."Prod. Order No.", 0, DATABASE::"Prod. Order Line",
                          ProdOrderLineL.Status.AsInteger(), ProdOrderLineL."Line No.", DATABASE::"Prod. Order Component")
                        then
                            ProdOrderLineL.TESTFIELD("Reserved Qty. (Base)", 0);
                end;

                if CalcComponents then begin
                    ProdOrderCompL.SETRANGE("Prod. Order No.", ProdOrderLineL."Prod. Order No.");
                    ProdOrderCompL.SETRANGE(Status, ProdOrderLineL.Status);
                    ProdOrderCompL.SETRANGE("Prod. Order Line No.", ProdOrderLineL."Line No.");
                    ProdOrderCompL.SETAUTOCALCFIELDS("Reserved Qty. (Base)");
                    if ProdOrderCompL.FIND('-') then begin
                        repeat
                            if ProdOrderCompL."Reserved Qty. (Base)" <> 0 then
                                if ShouldCheckReservedQty(
                                  ProdOrderCompL."Prod. Order No.", ProdOrderCompL."Line No.",
                                  DATABASE::"Prod. Order Component", ProdOrderCompL.Status.AsInteger(),
                                  ProdOrderCompL."Prod. Order Line No.", DATABASE::"Prod. Order Line")
                                then
                                    ProdOrderCompL.TESTFIELD("Reserved Qty. (Base)", 0);
                        until ProdOrderCompL.NEXT() = 0;
                    end;
                end;
            until ProdOrderLineL.NEXT() = 0;
        //HEI.02<<
    end;

    local procedure ShouldCheckReservedQty(ProdOrderNo: Code[20]; LineNo: Integer; SourceType: Integer; Status: Option; ProdOrderLineNo: Integer; SourceType2: Integer): Boolean;
    var
        ReservEntry: Record "Reservation Entry";
    begin
        //HEI.02>>
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
        //HEI.02<<
    end;

    local procedure CheckProductionBOMStatus(ProdBOMNo: Code[20]; ProdBOMVersionNo: Code[20]);
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMVersion: Record "Production BOM Version";
    begin
        //HEI.02>>
        if ProdBOMNo = '' then
            exit;

        if ProdBOMVersionNo = '' then begin
            ProductionBOMHeader.GET(ProdBOMNo);
            ProductionBOMHeader.TESTFIELD(Status, ProductionBOMHeader.Status::Certified);
        end else begin
            ProductionBOMVersion.GET(ProdBOMNo, ProdBOMVersionNo);
            ProductionBOMVersion.TESTFIELD(Status, ProductionBOMVersion.Status::Certified);
        end;
        //HEI.02<<
    end;

    local procedure CheckRoutingStatus(RoutingNo: Code[20]; RoutingVersionNo: Code[20]);
    var
        RoutingHeader: Record "Routing Header";
        RoutingVersion: Record "Routing Version";
    begin
        //HEI.02>>
        if RoutingNo = '' then
            exit;

        if RoutingVersionNo = '' then begin
            RoutingHeader.GET(RoutingNo);
            RoutingHeader.TESTFIELD(Status, RoutingHeader.Status::Certified);
        end else begin
            RoutingVersion.GET(RoutingNo, RoutingVersionNo);
            RoutingVersion.TESTFIELD(Status, RoutingVersion.Status::Certified);
        end;
        //HEI.02<<
    end;

    local procedure IsComponentPicked(ProdOrder: Record "Production Order"): Boolean;
    var
        ProdOrderComp: Record "Prod. Order Component";
    begin
        //HEI.02>>
        ProdOrderComp.SETRANGE("Prod. Order No.", ProdOrder."No.");
        ProdOrderComp.SETRANGE(Status, ProdOrder.Status);
        ProdOrderComp.SETFILTER("Qty. Picked", '<>0');
        exit(not ProdOrderComp.ISEMPTY);
        //HEI.02<<
    end;
}