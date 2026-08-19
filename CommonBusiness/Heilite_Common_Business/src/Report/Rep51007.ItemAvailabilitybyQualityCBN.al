report 51007 "Item Availability by Qua CBN"
{
    // version HEI.11

    // HEI.01 FDD PRDGAP055 IBM ISYED01 23.05.2017
    //   # New report for material
    // 09.07.2018 FCE  I have increased the length of the WhseEntryLot from 10 --> 20
    // 01.08.2018 FCE 02 Changed the calculation of the Quantity BASE
    // 01.08.2018 FCE Changed the Findfirst statement into GET and added the HL code based in Inventory Setup
    // 27.08.2018  FCE04 Changed the Calculation of the Inv. Unit of measure quantity
    // HEI.02 RFC-CHG0248455 IBM.LS 03.12.2018
    //   # Code added to populate "Remaining Shelf Life Days".
    //   # Rectified Location Filters defects in the report.
    //   # Enhanced the report based on "Best Before Date" functionality.
    //   # Included the Force "Modification Permission" in report Property.
    // HEI.03 CC CHG2045019 IBM.RS 02.01.2020
    //   # Exclude the Zero Quantity for email report.
    // HEI.05 IBM.AK CHG2072471 15.11.2020
    //  # Change the design layout from A4 to A3 inorder to accomodate below new fields
    //  # Added filter on Request Page-->Extract Relevant & CMG filter
    //  # Added new columns on the Reort-->Item Category Code,CMG Code,CMG Desc, Extra Content & Date of Receipt/production
    //  # commented the code-- updating ile and lot no fuctionality, put qtybased and binmovementstatus1 outside comment
    //  # Update Quality Status Filter added, Code on Prereport trigger-Allowing User to update the Quality status before main report preview.
    // HEI.06 CC-CHG2069954 IBM.LS 18.11.2020
    //   # Code added.
    // HEI.07 CC-CHG2090325 IBM.LS 09.12.2020
    //   # Permission added in report property.
    // HEI.08 CC-CHG2116009 IBM.AK 25.06.21
    //   # 'Rem Shelf Life Days' column not calculated
    // HEI.09 CC-CHG2173831 IBM.AK 22.09.22
    //  # The value of the Extract content to be taken from the last entry registered.
    // HEI.10 CC-CHG2193144/INC4539611 IBM.PRASAA03 17.02.23 Job queue 50085 "Send E-Mail with Attachment" in error
    //  # Condition added to skip not available user setup for organisation role users.
    // HEI.11 CC-CHG2193144/INC4539611 IBM.PRASAA03 24.02.23 Job queue 50085 "Send E-Mail with Attachment" in error
    //  # Commenting the Get Code where it is not required to get the Non-Opco Users.

    // BC Upgrade SHUKLP03 >>
    // Blocked entire procedure InitAutoEmailOnWarningThreshold() because 2C objects is used inside this procedure.
    // Blocked DrinkIT field "Inventory Unit of Measure", "Volume Unit of Measure Code" and "Strength Spec. Value".
    // BC Upgrade SHUKLP03 <<

    //#(FDD PID- 201, FDD DtW 015, IBM GAP DtW 21)-item Availability by Quality Report  PATHAA02 30.03.26 >>
    //** Aptean dependency("Aptean Beverage Foundation Management for Drink-IT Edition" to be added to unlock "Unit of Volume HL" field from DITFoundation Extension.
    //"Volume Unit of Measure Code" field is replaced with "Unit Volume HL"; Usage category added to show on search
    //Quantity_IUoM--> As "Inventory Unit of Measure" is no more DIT and now IBM field, uncomented the code to show in report column

    //PATHAA02 FDD-GAP014_DTW, IBM GAP DTW 43 – Quality and Lot No information
    //#Removed Quality Status Option field and replaced with Inspection Status Code field but values taken from Inventory setup without hardcode


    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Item Availability by Quality.rdl';

    Caption = 'Item Availability by Quality';
    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Warehouse Entry" = rm;
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = CONST(1));
            column(ReportTitle; ReportTitle)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(LocationFilterCp; Text002)
            {
            }
            column(ItemCategoryFilterCp; Text003)
            {
            }
            column(ItemNoFilterCp; Text004)
            {
            }
            column(ZoneFilterCp; Text005)
            {
            }
            column(BinFilterCp; Text006)
            {
            }
            column(LotNoFilterCp; Text007)
            {
            }
            column(QualityStatusFilterCp; Text008)
            {
            }
            column(RemShelfLifeDaysCp; Text009)
            {
            }
            column(RegisteringDateFilterCp; Text011)
            {
            }
            column(ExpirationDateFilterCp; Text012)
            {
            }
            column(LocationFilter; LocationFilter)
            {
            }
            column(ItemCategoryTypology; ItemCategoryFilter)
            {
            }
            column(ItemNoGetfilter; Item.GETFILTER("No."))
            {
            }
            column(ZoneFilter; ZoneFilter)
            {
            }
            column(BinFilter; BinFilter)
            {
            }
            column(LotFiltering; LotFiltering)
            {
            }
            //PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
            // column(QualityFltr; QualityFilter)
            // {
            // }
            column(InspectionStatusFilter; InspectionStatusFilter)
            {
            }
            //PATHAA02 GAP014_DTW, IBM GAP DTW 43 <<

            column(RegisteringDateFilter; Item.GETFILTER("Date Filter"))
            {
            }
            column(ExpirationDateFilter; "Warehouse Entry".GETFILTER("Expiration Date"))
            {
            }
        }
        dataitem(Location; Location)
        {
            DataItemTableView = sorting(Code) ORDER(Ascending);
            column(LocationDescrp; Code + ' : ' + Name + ' ' + "Name 2")
            {
            }
            column(WarningThresholdDaysFlag; STRSUBSTNO(Text010, FIELDCAPTION("Warning Threshold Days FND")) + FORMAT("Warning Threshold Days FND"))
            {
            }
            column(WarningThresholdDays; "Warning Threshold Days FND")
            {
            }
            dataitem(Item; Item)
            {
                RequestFilterFields = "No.", "Item Category Code", "Date Filter";
                column(ItemCode; "No.")
                {
                }
                column(ItemDescription_itm; Description)
                {
                }
                column(UOM; "Inventory Unit of Measure FND") // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Inventory Unit of Measure" is used. //PATHAA02-uncommented 30.03.26
                {
                }
                column(ItemCatCode; "Item Category Code")
                {
                }
                column(DimValueCode1; DimValueCode1)
                {
                }
                column(DimValName1; DimValName1)
                {
                }
                dataitem("Warehouse Entry"; "Warehouse Entry")
                {
                    DataItemLink = "Item No." = FIELD("No.");
                    //DataItemTableView = '';
                    RequestFilterFields = "Expiration Date";
                    column(WeLocation; "Location Code")
                    {
                    }
                    column(WEZone; "Zone Code")
                    {
                    }
                    column(WEBin; "Bin Code")
                    {
                    }
                    column(WeLot; "Lot No.")
                    {
                    }
                    column(WEQuantityBase; "Qty. (Base)")
                    {
                    }
                    //PATHAA02 FDD-GAP014_DTW, IBM GAP DTW 43 >>
                    // column(WeQualityStatus; "Quality Status")
                    // {
                    // }
                    column(WeInspectionStatus; "Inspection Status FND")
                    {

                    }
                    //PATHAA02 FDD-GAP014_DTW, IBM GAP DTW 43 <<
                    column(WEExpiration; "Expiration Date")
                    {
                    }
                    column(WeBinMovementStatus; WeBinMovementStatus)
                    {
                    }
                    column(RemShelfLifeDays; RemShelfLifeDays)
                    {
                    }
                    column(RemShelfLifeDaysValue; RemShelfLifeDaysValue)
                    {
                    }
                    column(SystemDate; FORMAT(TODAY))
                    {
                    }
                    column(BinMovementStatus; BinMovementStatus_1)
                    {
                    }
                    column(StrengthSpecValueactual; StrengthSpecValueactual)
                    {
                    }
                    column(PostingdatePurchOut; PostingdatePurchOut)
                    {
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = CONST(1));
                        column(Quantity_IOUM; Quantity_IOUM)
                        {
                        }
                        column(QuantityBased; QuantityBased)
                        {
                        }
                        column(QuantityHL; QuantityHL)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //HEI.02>>
                            if ApplyWarningThreshold then begin
                                // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field "Inventory Unit of Measure" is used.
                                //PATHAA02 30.03.26>>
                                if ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure FND") then
                                    Quantity_IOUM := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure";
                                //PATHAA02 30.03.26<<

                                CLEAR(ItemUnitofMeasure);
                                //if ItemUnitofMeasure.GET(Item."No.", InventorySetup."Volume Unit of Measure Code") then 
                                //    QuantityHL := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure";
                                // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Volume Unit of Measure Code", "Inventory Unit of Measure" is used.
                                //PATHAA02  30.03.26>>
                                IF ItemUnitofMeasure.GET(Item."No.", DITFoundation."Unit Volume UOM") then
                                    QuantityHL := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure";
                                //PATHAA02 30.03.26<<
                            end;
                            //HEI.02<<
                        end;
                    }

                    trigger OnAfterGetRecord();
                    var
                        lRecBinContent: Record "Bin Content";
                        ItemLedgerEntry: Record "Item Ledger Entry";
                        LotNoInfo: Record "Lot No. Information";
                        ILEEntryType: Option Purchase,Output;
                    begin
                        CLEAR(WeBinMovementStatus);
                        if lRecBinContent.GET("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code") then
                            if lRecBinContent."Block Movement" > 0 then
                                WeBinMovementStatus := Text001;

                        //HEI.02>>//HEI.08<<
                        CLEAR(RemShelfLifeDays);
                        CLEAR(RemShelfLifeDaysValue);
                        //IF InventorySetup."Active Best Before Date" THEN BEGIN //HEI.05
                        if "Expiration Date" <> 0D then begin
                            RemShelfLifeDays := ("Expiration Date" - TODAY);
                            RemShelfLifeDaysValue := FORMAT(RemShelfLifeDays);
                        end else
                            RemShelfLifeDaysValue := '';
                        //HEI.08<<
                        /*
                          IF ApplyWarningThreshold THEN BEGIN
                            IF RemShelfLifeDaysValue <> '' THEN BEGIN
                              IF "Quality Status" = "Quality Status"::Unrestricted THEN BEGIN
                                IF RemShelfLifeDays <= Location."Warning Threshold Days" THEN BEGIN
                                  IF "Expiration Date" <= TODAY THEN BEGIN
                                    LotNoInfo.SETRANGE("Item No.","Item No.");
                                    LotNoInfo.SETRANGE("Variant Code","Variant Code");
                                    LotNoInfo.SETRANGE("Lot No.","Lot No.");
                                    LotNoInfo.SETRANGE("Location Filter","Location Code");
                                    LotNoInfo.SETRANGE("Bin Filter","Bin Code");
                                    IF LotNoInfo.findset THEN BEGIN
                                      REPEAT
                                        LotNoInfo."Quality Status" := "Quality Status"::"Quality Hold";
                                        LotNoInfo.MODIFY(TRUE);
                                      UNTIL LotNoInfo.NEXT = 0;
                                    end;
                        
                                    ItemLedgerEntry.SETRANGE("Item No.","Item No.");
                                    ItemLedgerEntry.SETRANGE("Variant Code","Variant Code");
                                    ItemLedgerEntry.SETRANGE("Lot No.","Lot No.");
                                    ItemLedgerEntry.SETRANGE("Location Code","Location Code");
                                    ItemLedgerEntry.SETRANGE("Bin Code","Bin Code");
                                    IF ItemLedgerEntry.findset THEN BEGIN
                                      REPEAT
                                        ItemLedgerEntry."Quality Status" := "Quality Status"::"Quality Hold";
                                        ItemLedgerEntry.MODIFY(TRUE);
                                      UNTIL ItemLedgerEntry.NEXT = 0;
                                    end;
                        
                                    "Quality Status" := "Quality Status"::"Quality Hold";
                                    MODIFY(TRUE);
                                  end;
                                end else
                                  CurrReport.SKIP;
                              end else BEGIN
                                IF RemShelfLifeDays > Location."Warning Threshold Days" THEN
                                  CurrReport.SKIP;
                              end;
                            end else
                              CurrReport.SKIP;
                        
                        
                          end;
                        end;
                        //HEI.02<<
                        */
                        QuantityBased += "Qty. (Base)";
                        if BinContent.GET("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code") then
                            BinMovementStatus_1 += BinContent."Block Movement";
                        //HEI.05<<

                        //HEI.09>>

                        //HEI.05<<
                        CLEAR(PostingdatePurchOut);
                        ILE.RESET();
                        ILE.SETRANGE("Item No.", "Item No.");
                        ILE.SETRANGE("Lot No.", "Lot No.");
                        if ILE.FINDFIRST() then begin
                            PostingdatePurchOut := ILE."Posting Date";
                            // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Strength Spec. Value" is used.
                            //ILE.CALCFIELDS("Strength Spec. Value");
                            //StrengthSpecValueactual  := ILE."Strength Spec. Value";
                            // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Strength Spec. Value" is used.
                        end;
                        //HEI.05>>

                        CLEAR(StrengthSpecValueactual);
                        RecILE.RESET();
                        RecILE.SETRANGE("Item No.", "Item No.");
                        RecILE.SETRANGE("Lot No.", "Lot No.");
                        if RecILE.FINDLAST() then begin
                            // RecILE.CALCFIELDS("Strength Spec. Value");
                            // StrengthSpecValueactual := RecILE."Strength Spec. Value";
                            StrengthSpecValueactual := RecILE."Strength 3 Value 101FDW"; //BC UPGRADE PATHAA02 03-06-26
                        end;
                        //HEI.09<<

                    end;

                    trigger OnPreDataItem();
                    begin
                        "Warehouse Entry".SETCURRENTKEY("Location Code", "Item No.", "Variant Code", "Zone Code", "Bin Code", "Lot No.");
                        //HEI.02>>
                        //"Warehouse Entry".SETFILTER("Warehouse Entry"."Location Code", Item.GETFILTER(Item."Location Filter"));
                        "Warehouse Entry".SETRANGE("Location Code", Location.Code);
                        //HEI.02<<
                        "Warehouse Entry".SETRANGE("Item No.", Item."No.");
                        "Warehouse Entry".SETFILTER("Zone Code", ZoneFilter);
                        "Warehouse Entry".SETFILTER("Bin Code", BinFilter);
                        "Warehouse Entry".SETFILTER("Lot No.", LotFiltering);
                        //HEI.02>>
                        //"Warehouse Entry".SETFILTER("Registering Date",FORMAT(Item."Date Filter"));
                        SETFILTER("Registering Date", Item.GETFILTER("Date Filter"));
                        //HEI.02<<
                        ////PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
                        //"Warehouse Entry".SETFILTER("Quality Status", FORMAT(QualityFilter)); 
                        if InspectionStatusFilter <> '' then
                            "Warehouse Entry".SETRANGE("Inspection Status FND", InspectionStatusFilter);
                        //PATHAA02 GAP014_DTW, IBM GAP DTW 43
                        //HEI.02>>
                        SETFILTER("Expiration Date", GETFILTER("Expiration Date"));
                        //HEI.02<<
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(QuantityBased);
                    CLEAR(Quantity_IOUM);
                    CLEAR(QuantityHL);
                    CLEAR(BinMovementStatus_1);
                    //HEI.02>>
                    CLEAR(RemShelfLifeDays);
                    CLEAR(RemShelfLifeDaysValue);
                    //IF NOT ApplyWarningThreshold THEN BEGIN // >>HEI.03
                    //HEI.02<<
                    CalcWEBased(Item."No.", QuantityBased, BinMovementStatus_1); //calculates wequantity and binmovemtn
                    if QuantityBased = 0 then
                        CurrReport.SKIP();
                    // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field "Inventory Unit of Measure" is used.
                    //PATHAA02  >>
                    if ItemUnitofMeasure.GET(Item."No.", Item."Inventory Unit of Measure FND") then
                        Quantity_IOUM := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure"; // Quantity_IOUM
                                                                                                       // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Inventory Unit of Measure" is used.      
                                                                                                       //PATHAA02  <<
                                                                                                       //HEI.02>>

                    CLEAR(ItemUnitofMeasure);
                    // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field "Volume Unit of Measure Code" is used.
                    //HEI.02<<
                    //if ItemUnitofMeasure.GET(Item."No.", InventorySetup."Volume Unit of Measure Code") then 
                    // QuantityHL := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure"; // QuantityHL
                    //HEI.02>>
                    // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Volume Unit of Measure Code" is used.
                    //end; // <<HEI.03
                    //HEI.02<<

                    //PATHAA02  30.03.26>>
                    IF ItemUnitofMeasure.GET(Item."No.", DITFoundation."Unit Volume UOM") then
                        QuantityHL := QuantityBased / ItemUnitofMeasure."Qty. per Unit of Measure";
                    //PATHAA02 30.03.26<<

                    //HEI.05>>
                    CLEAR(DimValueCode1);
                    CLEAR(DimValName1);

                    if DefaulltDimension.GET(DATABASE::Item, Item."No.", 'CMG') then
                        DimValueCode1 := DefaulltDimension."Dimension Value Code";

                    if DimensionValue.GET('CMG', DimValueCode1) then
                        DimValName1 := DimensionValue.Name;

                    //HEI.05<<
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02>>
                    SETRANGE("Location Filter", Location.Code);
                    SETFILTER("Item Category Code", ItemCategoryFilter);
                    //HEI.02<<
                    // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field "Strength Spec. Code" is used.
                    // //HEI.05>>
                    // if ExtraRelevantFilter then
                    //     SETFILTER(Item."Strength Spec. Code", '%1', 'EXT.[%w/w]');
                    // //HEI.05<<
                    // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Strength Spec. Code" is used.
                end;
            }

            trigger OnPreDataItem();
            begin
                //HEI.02>>
                SETFILTER(Code, LocationFilter);
                //HEI.02<<
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(GENERAL)
                {
                    field(LocationFilter; LocationFilter)
                    {
                        Caption = 'Location Code Filter';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Location Code Filter field.';

                        trigger OnLookup(var Text: Text): Boolean;
                        var
                            Location: Record Location;
                        begin
                            CLEAR(LocationList);
                            CLEAR(Text);
                            LocationList.LOOKUPMODE := true;
                            if LocationList.RUNMODAL() = ACTION::LookupOK then begin
                                if Text <> '' then
                                    Text := Text + '|';
                                Text := Text + LocationList.GetSelectionFilter();
                                LocationFilter := Text;
                            end;
                            CLEAR(LocationList);
                        end;

                        trigger OnValidate();
                        var
                            Location: Record Location;
                        begin
                            if LocationFilter <> '' then begin
                                ZoneFilter := '';
                                BinFilter := '';
                            end;
                        end;
                    }
                    field(ZoneFilter; ZoneFilter)
                    {
                        Caption = 'Zone Code Filter';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Zone Code Filter field.';

                        trigger OnLookup(var Text: Text): Boolean;
                        var
                            zone: Record Zone;
                        begin
                            if LocationFilter <> '' then begin
                                CLEAR(ZoneList);
                                zone.RESET();
                                zone.SETFILTER(zone."Location Code", LocationFilter);
                                ZoneList.SETTABLEVIEW(zone);
                                ZoneList.LOOKUPMODE := true;
                                if ZoneList.RUNMODAL() = ACTION::LookupOK then begin
                                    Text := ZoneList.GetSelectionFilter();
                                    ZoneFilter := Text;
                                end;
                            end;
                            CLEAR(ZoneList);
                        end;

                        trigger OnValidate();
                        begin
                            if ZoneFilter <> '' then begin
                                BinFilter := '';
                            end;
                        end;
                    }
                    field(BinFilter; BinFilter)
                    {
                        Caption = 'Bin Code Filter';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bin Code Filter field.';

                        trigger OnLookup(var Text: Text): Boolean;
                        var
                            Bin: Record Bin;
                        begin
                            CLEAR(BinFilter);
                            CLEAR(BinList);
                            if (ZoneFilter <> '') or (LocationFilter <> '') then begin
                                Bin.RESET();
                                Bin.SETFILTER(Bin."Zone Code", ZoneFilter);
                                Bin.SETFILTER(Bin."Location Code", LocationFilter);

                                BinList.SETTABLEVIEW(Bin);

                                BinList.LOOKUPMODE := true;
                                if BinList.RUNMODAL() = ACTION::LookupOK then begin
                                    Text := BinList.GetSelectionFilter();
                                    BinFilter := Text;
                                end;
                            end;
                            CLEAR(BinList);
                        end;
                    }
                    field(LotFiltering; LotFiltering)
                    {
                        Caption = 'Lot No. Filter';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Lot No. Filter field.';

                        trigger OnLookup(var Text: Text): Boolean;
                        var
                            LotNumberInfoRec: Record "Lot No. Information";
                        begin
                            LotNumberInfoRec.SETFILTER(LotNumberInfoRec."Item No.", Item.GETFILTER(Item."No."));

                            /*lotNumberList.SETTABLEVIEW(LotNumberInfoRec);
                            lotNumberList.LOOKUPMODE(TRUE);
                            IF lotNumberList.RUNMODAL=ACTION::LookupOK THEN
                            
                            */
                            if PAGE.RUNMODAL(0, LotNumberInfoRec) = ACTION::LookupOK then
                                LotFiltering := LotNumberInfoRec."Lot No.";

                        end;
                    }


                    //PATHAA02 FDD-GAP014_DTW, IBM GAP DTW 43 – Quality and Lot No information
                    // field(QualityFilter; QualityFilter)
                    // {
                    //     Caption = 'Quality Status Filter';
                    //     ApplicationArea = All;
                    //     ToolTip = 'Specifies the value of the Quality Status Filter field.';
                    // }
                    field(InspectionStatusFilter; InspectionStatusFilter)
                    {
                        Caption = 'Inspection Status Filter';
                        ApplicationArea = All;
                        TableRelation = InspectionStatusHeaderFDW.Code;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            InspStatus: Record InspectionStatusHeaderFDW;
                        begin
                            if PAGE.RUNMODAL(PAGE::"InspectionStatusListFDW", InspStatus) = ACTION::LookupOK then
                                InspectionStatusFilter := InspStatus.Code;
                        end;
                    }
                    //FDD-GAP014_DTW, IBM GAP DTW 43 – Quality and Lot No information<<


                    field(ExtraRelevantFilter; ExtraRelevantFilter)
                    {
                        Caption = 'Extract Relevant';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Extract Relevant field.';
                    }
                    field(UpdateQualityStatus; UpdateQualityStatus)
                    {
                        Caption = 'Update Quality Status';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Update Quality Status field.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            if (LocationFilter = '') and (BinFilter = '') and (ZoneFilter = '') then
                UseAsInTransit := true
            else
                UseAsInTransit := false;
        end;
    }

    labels
    {
        lblQuantity = 'Quantity'; lblQuantityHL = 'Quantity HL'; lblExpiryDate = 'Expiry Date'; lblQuantityBase = 'Quantity (Base)'; lbItemNoCpt = 'Item Number'; lbItemDescriptionCpt = 'Description'; lbLotNoCpt = 'Lot Number'; lbQualityStatusCpt = 'Inspection Status'; lbCode = 'Code'; lbZOne = 'Zone Code'; lbBin = 'Bin Code'; lbUoM = 'UOM'; lbLocation = 'Location'; lblPage = 'Page'; lbBinBlocked = 'Partially Blocked'; lblItemCatCode = 'Item Cat. Code'; lblCMGCode = 'CMG Code'; lblCMGDesc = 'CMG Description'; lblExtRelevant = 'Extra Relevant'; lblExtCont = 'Extract Content [%w/w]'; lblDateReceipt = 'Date of Receipt/Production'; //PATHAA02 GAP014_DTW, IBM GAP DTW 43
    }

    trigger OnPreReport();
    begin
        //HEI.05>>
        if UpdateQualityStatus then begin
            REPORT.RUN(50095, false);
            // MESSAGE(Text013);
        end;
        //HEI.05<<

        InventorySetup.GET();
        //HEI.02>>
        CLEAR(ItemCategoryFilter);
        if ApplyWarningThreshold then begin
            if InventorySetup."Active Best Before Date FND" then begin  //activate expiry notification boolean on page
                if InventorySetup."Item Category Typology FND" <> '' then //<Expiry Notification Item Typology on page
                    ItemCategoryFilter := InventorySetup."Item Category Typology FND";
            end;
        end else begin
            if Item.GETFILTER("Item Category Code") <> '' then
                ItemCategoryFilter := Item.GETFILTER("Item Category Code");
        end;
        //HEI.02<<
        DITFoundation.Get();//BC upgrade Pathaa02 // Bug fix Qty HL 
    end;

    local procedure CalcWEBased(ItmCode: Code[20]; var WEQuantity: Decimal; var BinMovement: Integer);
    var
        WarehouseEntries: Record "Warehouse Entry";
    begin
        CLEAR(WEQuantity);
        WarehouseEntries.SETCURRENTKEY("Location Code", "Item No.", "Variant Code", "Zone Code", "Bin Code", "Lot No.");
        //HEI.02>>
        //WarehouseEntries.SETFILTER(WarehouseEntries."Location Code", Item.GETFILTER(Item."Location Filter"));
        WarehouseEntries.SETRANGE("Location Code", Location.Code);
        //HEI.02<<
        WarehouseEntries.SETRANGE(WarehouseEntries."Item No.", ItmCode);
        WarehouseEntries.SETFILTER(WarehouseEntries."Zone Code", ZoneFilter);
        WarehouseEntries.SETFILTER(WarehouseEntries."Bin Code", BinFilter);
        WarehouseEntries.SETFILTER(WarehouseEntries."Lot No.", LotFiltering);
        //HEI.02>>
        //WarehouseEntries.SETFILTER(WarehouseEntries."Registering Date", FORMAT(Item."Date Filter"));
        WarehouseEntries.SETFILTER("Registering Date", Item.GETFILTER("Date Filter"));
        //HEI.02<<
        //PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
        //WarehouseEntries.SETFILTER(WarehouseEntries."Quality Status", FORMAT(QualityFilter));
        if InspectionStatusFilter <> '' then
            WarehouseEntries.SETRANGE("Inspection Status FND", InspectionStatusFilter);
        //PATHAA02 GAP014_DTW, IBM GAP DTW 43 <<
        //HEI.02>>
        WarehouseEntries.SETFILTER("Expiration Date", "Warehouse Entry".GETFILTER("Expiration Date"));
        //HEI.02<<
        if WarehouseEntries.findset() then
            repeat
                WEQuantity += WarehouseEntries."Qty. (Base)";
                if BinContent.GET(WarehouseEntries."Location Code", WarehouseEntries."Bin Code", WarehouseEntries."Item No.", WarehouseEntries."Variant Code", WarehouseEntries."Unit of Measure Code") then
                    BinMovement += BinContent."Block Movement";
            until WarehouseEntries.NEXT() = 0;
        exit;
    end;

    // BC Upgrade SHUKLP03 >> 2C objects code is blocked.
    // procedure InitAutoEmailOnWarningThreshold(ApplyWT: Boolean; SendEmail: Boolean) EmailUsers: Text;
    // var
    //     "2CUserProfileL": Record "2C User Profile";
    //     "2CUserperUserProfileL": Record "2C User per User Profile";
    //     EmailUsersL: Text;
    //     "2CCompanyGroupL": Record "2C Company Group";
    //     "2CUserNameL": Text[100];
    // begin
    //     //HEI.02>>
    //     ApplyWarningThreshold := ApplyWT;
    //     if not SendEmail then
    //         exit
    //     else begin
    //         "2CUserProfileL".SETRANGE("E-mail for Item Availability", true);
    //         //HEI.06>>
    //         "2CUserProfileL".SETRANGE(Status, "2CUserProfileL".Status::Synchronized);
    //         //HEI.06<<
    //         if "2CUserProfileL".findset then begin
    //             repeat
    //                 //IF UserSetup.GET("2CUserProfileL".Responsible) THEN BEGIN //HEI.10//HEI.11
    //                 //UserSetup.GET("2CUserProfileL".Responsible);//HEI.10
    //                 "2CUserperUserProfileL".RESET;
    //                 "2CUserperUserProfileL".SETRANGE("User Profile", "2CUserProfileL"."User Profile");
    //                 //HEI.06>>
    //                 "2CUserperUserProfileL".SETRANGE("User Profile Status", "2CUserperUserProfileL"."User Profile Status"::Synchronized);
    //                 "2CUserperUserProfileL".SETRANGE("Sync Status", "2CUserperUserProfileL"."Sync Status"::Synchronized);
    //                 //HEI.06<<
    //                 if "2CUserperUserProfileL".findset then begin
    //                     repeat
    //                         //HEI.06>>
    //                         CLEAR("2CUserNameL");
    //                         if "2CUserperUserProfileL"."Company (Group)" <> '' then begin
    //                             if "2CUserperUserProfileL"."Company (Group)" = COMPANYNAME then begin
    //                                 "2CCompanyGroupL".RESET;
    //                                 "2CCompanyGroupL".SETRANGE(Type, "2CCompanyGroupL".Type::Company);
    //                                 "2CCompanyGroupL".SETRANGE("Company Group", COMPANYNAME);
    //                                 if "2CCompanyGroupL".FINDFIRST then
    //                                     "2CUserNameL" := "2CUserperUserProfileL"."User Name";
    //                             end;
    //                         end else
    //                             "2CUserNameL" := "2CUserperUserProfileL"."User Name";

    //                         //IF UserSetup.GET("2CUserperUserProfileL"."User Name") THEN BEGIN
    //                         if ("2CUserNameL" <> '') and UserSetup.GET("2CUserNameL") then begin
    //                             //HEI.06<<
    //                             if not UserSetup.MARK then begin
    //                                 if STRPOS(UserSetup."E-Mail", '@') > 0 then begin
    //                                     UserSetup.MARK(true);
    //                                     EmailUsersL += UserSetup."E-Mail" + '; ';
    //                                 end;
    //                             end;
    //                         end;
    //                     until "2CUserperUserProfileL".NEXT = 0;
    //                 end;
    //             //end;//HEI.10//HEI.11
    //             until "2CUserProfileL".NEXT = 0;
    //         end;
    //         EmailUsers := DELCHR(EmailUsersL, '>', '; ');
    //     end;
    //     //HEI.02<<
    // end;
    // BC Upgrade SHUKLP03 << 2C objects code is blocked.


    var
        BinContent: Record "Bin Content";
        DefaulltDimension: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
        InventorySetup: Record "Inventory Setup";
        ILE: Record "Item Ledger Entry";
        RecILE: Record "Item Ledger Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        UserSetup: Record "User Setup";
        BinList: Page "Bin List";
        LocationList: Page "Location List";
        lotNumberList: Page "Lot No. Information List";
        ZoneList: Page "Zone List";
        ApplyWarningThreshold: Boolean;
        ExtraRelevantFilter: Boolean;
        UpdateQualityStatus: Boolean;
        UseAsInTransit: Boolean;
        DimValueCode1: Code[20];
        ItemCatCode: Code[20];
        ItmCode: Code[20];
        StrengthSpecCode: Code[20];
        LotFiltering: Code[100];
        BinFilter: Code[250];
        ItemCategoryFilter: Code[250];
        LocationFilter: Code[250];
        ZoneFilter: Code[250];
        PostingdatePurchOut: Date;
        Quantity_IOUM: Decimal;
        QuantityBased: Decimal;
        QuantityHL: Decimal;
        Quantoty_IOUM: Decimal;
        StrengthSpecValueactual: Decimal;
        BinMovementStatus_1: Integer;
        RemShelfLifeDays: Integer;
        BinCpt: Label 'Bin';
        ItemDescriptionCpt: Label 'Item Description';
        ItemNoCpt: Label 'Item No.';
        LocationCodeCpt: Label 'Location Code';
        LotNoCpt: Label 'Lot No.';
        PageNoCpt: Label 'Page';
        //QualityStatusCpt: Label 'Quality Status';//PATHAA02
        QualityStatusCpt: Label 'InspectionStatus'; //PATHAA02 FDD-GAP014_DTW, IBM GAP DTW 43
        QuantityCpt: Label 'Quantity';
        ReportTitle: Label 'Item Availability by Quality';
        Text001: Label 'BLOCKED';
        Text002: Label '"Location Filter         : "';
        Text003: Label '"Item Category Filter : "';
        Text004: Label '"Item No. Filter         : "';
        Text005: Label '"Zone Filter     : "';
        Text006: Label '"Bin Filter       : "';
        Text007: Label '"Lot No. Filter : "';
        //Text008: Label '"Quality Status Filter     : "'; //PATHAA02 FDD-GAP014_DTW, IBM GAP DTW 43
        Text008: Label '"Inspection Status Filter     : "'; //PATHAA02 FDD-GAP014_DTW, IBM GAP DTW 43
        Text009: Label 'Rem. Shelf Life Days';
        Text010: Label '"%1 : "';
        Text011: Label '"Registering Date Filter : "';
        Text012: Label '"Expiration Date Filter   : "';
        Text013: Label 'Lots & ILE''s are updated';
        UnitOfMeasureCpt: Label 'UOM';
        ZoneCpt: Label '"Zone "';
        // QualityFilter: Option " ","Quality Hold",Unrestricted,Blocked; //PATHAA02 FDD-GAP014_DTW, IBM GAP DTW 43
        // QualityStatusFilter: Option OnHold,Unrestricted,Blocked; //PATHAA02 FDD-GAP014_DTW, IBM GAP DTW 43
        BinMovementStatus: Text;
        RemShelfLifeDaysValue: Text[10];
        WeBinMovementStatus: Text[30];
        DimValName1: Text[50];
        DITFoundation: Record FoundationSetup101FDW;
        InspectionStatusFilter: Code[10];

}

