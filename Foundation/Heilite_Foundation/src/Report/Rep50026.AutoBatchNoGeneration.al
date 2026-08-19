report 50026 "Auto Batch No. Generation"
{
    // version HEI.05 IBM

    // HEI.01 FDD-PRDGAP004 - Automatic Batch Number Generation , 10.09.2017 IBM.NAIKH01
    //   #Created a new Report to generate new Batch Numbers
    // HEI.02 CHG2150967 SAHAL01      07.04.2022
    //   # Added Permission for No. Series Line in report
    // HEI.03 CHG2211688 PRASAA03   07.06.2023 Brewhouse failed to post Wort Production and Couldn't Open New period
    //   # Code changed to get Open No. series line.
    // HEI.04 CHG2211688 PRASAA03   07.07.2023 Brewhouse failed to post Wort Production and Couldn't Open New period
    //   # Code changed to get Open No. series line.
    // HEI.05 CHG2211688 PRASAA03   10.07.2023 Brewhouse failed to post Wort Production and Couldn't Open New period
    //   # Code changed to get Open No. series line.

    // BC Upgrade SHUKLP03 >>

    // Procedure name change from GetItem() to GetItemR(), because same name procedure is already exist in "Item Journal Line" so it was taking that procedure paramenters.
    // BC Upgrade SHUKLP03 <<

    Permissions = TableData "No. Series Line" = m;
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Journal Line"; "Item Journal Line")
        {

            trigger OnAfterGetRecord();
            begin

                CompanyInformation.GET();
                Item.GET("Item No.");

                Country_region := CompanyInformation."Country/Region Code";
                CountryRegion.GET(Country_region);

                if Item."Batch Number Policy FND" = Item."Batch Number Policy FND"::"Finished Product Own Produced" then
                    CountryRegion.TESTFIELD("Country Dialing code FND");

                Country_Dailing_Code := CountryRegion."Country Dialing code FND";
                Len := STRLEN(Country_Dailing_Code);
                if Len < 3 then
                    ERROR(Err006);

                GetItemR("Item No.", "Location Code", "Item Journal Line", "Bin Code");
                BinCode1 := "Bin Code";

                case Item."Batch Number Policy FND" of

                    //Bulk Product Related Materials   -- 01   --> Done
                    Item."Batch Number Policy FND"::"Bulk Product Related Materials":
                        GenBatchBPRM(locationPlantId, ProductionResource, SeqNum_BulkProdRelatedMaterial);

                    //Discrete Product Related Materials  -- 02   --> Done
                    Item."Batch Number Policy FND"::"Discrete Product Related Materials":
                        GenBatchDPRM(locationPlantId, location_BatchSequentialNo);

                    //Harvested Yeast   -- 06   --> Done
                    Item."Batch Number Policy FND"::"Harvested Yeast":
                        GenBatchHY(locationPlantId, ProductionResource, BatchSequentialNo);

                    //Propagated Yeast  -- 04   --> Done
                    Item."Batch Number Policy FND"::"Propagated Yeast":
                        GenBatchPY(locationPlantId, ProductionResource, BatchSequentialNo);

                    //Finished Product Own Produced -- 09  --> Done
                    Item."Batch Number Policy FND"::"Finished Product Own Produced":
                        GenBatchFPOP(ProductionResource);

                    //Wort/Must  -- 03   --> Done
                    Item."Batch Number Policy FND"::"Wort/Must":
                        GenBatchWM(locationPlantId, ProductionResource, WorkCenterBatchSeqNum);

                    //Filtration Capacity  -- 07  --> Done
                    Item."Batch Number Policy FND"::"Filtration Capacity":
                        GenBatchFC(locationPlantId, ProductionResource, Bin_BatchSequentialNo);

                    //Semi-Finished Beverage -- 05  --> Done
                    Item."Batch Number Policy FND"::"Semi-Finished Beverage":
                        GenBatchSFB(locationPlantId, ProductionResource, WorkCenterBatchSeqNum);

                    //Finished Beverage  -- 08
                    Item."Batch Number Policy FND"::"Finished Beverage":
                        GenBatchFB(locationPlantId, ProductionResource, WorkCenterBatchSeqNum);

                end;
            end;
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

    labels
    {
    }

    trigger OnInitReport();
    begin

        //PropogationNumber := '00';
        //ShiftIndicator :='0';
    end;

    trigger OnPreReport();
    begin


        /*
        IF GenerationNumber = '' THEN
           ERROR('Generation Number cant be blank');
        
        Len := STRLEN(PropogationNumber);
        IF Len< 2 THEN
          ERROR('Propogation Number should be 2 Character');
        
        IF PropogationNumber = '' THEN
           ERROR('Propogation Number cant be blank');
           */

    end;

    var
        CompanyInformation: Record "Company Information";
        CountryRegion: Record "Country/Region";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        Location: Record Location;
        locationPlantId: Text[1];
        Bin: Record Bin;
        ProductionResource: Text[4];
        BatchSequentialNo: Code[4];
        NewBatchNumer: Code[10];
        Year: Text[2];
        Month: Text[2];
        Day: Text[2];
        testint: Integer;
        location_BatchSequentialNo: Code[10];
        Len: Integer;
        ItemTrackingLines: Page "Item Tracking Lines";
        intYear: Integer;
        Country_region: Code[10];
        Country_Dailing_Code: Code[3];
        JulianDay: Code[3];
        PackingLines: Code[4];
        WorkCenter: Record "Work Center";
        WorkCenterBatchSeqNum: Text[10];
        WarehouseEntry: Record "Warehouse Entry";
        WarehouseCount: Integer;
        SeqNum_BulkProdRelatedMaterial: Code[4];
        Len2: Integer;
        Err001: Label 'The Length of the field "Batch Production Resource" for the Bin Code "%1" should be 4 Character';
        BinCode1: Code[20];
        NoSeriesLine: Record "No. Series Line";
        Err002: Label 'The Length of the string for the No Series: "%1" in the "Batch Sequential Number" for Location "%2" should be 3';
        i: Integer;
        increment_no: Integer;
        Err003: Label 'The Length of the field "Batch Production Resource" for the Bin Code "%1" should be 1 Character';
        Err004: Label 'The Length of the string for the No Series: "%1" in the "Batch Sequential Number" for Work Center "%2" should be 4';
        Bin_BatchSequentialNo: Code[10];
        Err005: Label 'The Length of the string for the No Series: "%1" in the "Batch Sequential Number" for Bin "%2" should be 4';
        Err006: Label 'The Length of String Country Dailing Code should be 3';

    local procedure GetItemR(ItemNo: Code[20]; LocationCode: Code[10]; ItemJournalLine: Record "Item Journal Line"; BinCode: Code[20]);
    var
        Len1: Integer;
    begin

        //Location //

        if Location.GET(LocationCode) then begin
            Location.TESTFIELD("Plant ID FND");
            locationPlantId := Location."Plant ID FND";
        end;

        if Item."Batch Number Policy FND" = Item."Batch Number Policy FND"::"Discrete Product Related Materials" then begin
            Location.TESTFIELD(Location."Batch sequential number FND");
            location_BatchSequentialNo := Location."Batch sequential number FND";

            //HEI.03>>
            //NoSeriesLine.GET(location_BatchSequentialNo,10000);
            NoSeriesLine.RESET();
            NoSeriesLine.SETCURRENTKEY("Series Code", Open, "Dummy FND");//HEI.05
            NoSeriesLine.SETRANGE("Series Code", location_BatchSequentialNo);
            NoSeriesLine.SETRANGE(Open, true);
            NoSeriesLine.SETRANGE("Dummy FND", false);//HEI.05
                                                //NoSeriesLine.SETRANGE("Ending No.",'');//HEI.04//HEI.05
            if not NoSeriesLine.FINDLAST() then
                ERROR('No. series does not exists for %1', location_BatchSequentialNo);
            //HEI.03<<
            if NoSeriesLine."Last No. Used" = '' then
                location_BatchSequentialNo := NoSeriesLine."Starting No."
            else begin
                location_BatchSequentialNo := NoSeriesLine."Last No. Used";
                increment_no := NoSeriesLine."Increment-by No.";
                for i := 1 to increment_no do begin
                    location_BatchSequentialNo := INCSTR(location_BatchSequentialNo);
                end;
            end;

            Len := STRLEN(location_BatchSequentialNo);
            if Len <> 3 then
                ERROR(Err002, NoSeriesLine."Series Code", LocationCode)
            else begin
                if NoSeriesLine."Last No. Used" = '' then
                    NoSeriesLine."Last No. Used" := location_BatchSequentialNo
                else
                    NoSeriesLine."Last No. Used" := location_BatchSequentialNo;

                NoSeriesLine.MODIFY();
            end;
        end;

        /// Bin
        if Item."Batch Number Policy FND" <> Item."Batch Number Policy FND"::"Discrete Product Related Materials" then begin
            if Bin.GET(LocationCode, BinCode) then begin
                Bin.TESTFIELD("Batch Production Resource FND");
                ProductionResource := Bin."Batch Production Resource FND";
            end;
        end;

        if Item."Batch Number Policy FND" = Item."Batch Number Policy FND"::"Filtration Capacity" then begin
            Bin.TESTFIELD("Batch sequential number FND");
            Bin_BatchSequentialNo := Bin."Batch sequential number FND";

            //HEI.04>>
            //NoSeriesLine.GET(Bin_BatchSequentialNo,10000);
            NoSeriesLine.RESET();
            NoSeriesLine.SETCURRENTKEY("Series Code", Open, "Dummy FND");//HEI.05
            NoSeriesLine.SETRANGE("Series Code", Bin_BatchSequentialNo);
            NoSeriesLine.SETRANGE(Open, true);
            NoSeriesLine.SETRANGE("Dummy FND", false);//HEI.05
                                                //NoSeriesLine.SETRANGE("Ending No.",'');//HEI.05
            if not NoSeriesLine.FINDLAST() then
                ERROR('No. series does not exists for %1', Bin_BatchSequentialNo);
            //HEI.04<<
            if NoSeriesLine."Last No. Used" = '' then
                Bin_BatchSequentialNo := NoSeriesLine."Starting No."
            else begin
                Bin_BatchSequentialNo := NoSeriesLine."Last No. Used";
                increment_no := NoSeriesLine."Increment-by No.";
                for i := 1 to increment_no do begin
                    Bin_BatchSequentialNo := INCSTR(Bin_BatchSequentialNo);
                end;
            end;

            Len := STRLEN(Bin_BatchSequentialNo);
            if Len <> 4 then
                ERROR(Err005, NoSeriesLine."Series Code", BinCode)
            else begin
                if NoSeriesLine."Last No. Used" = '' then
                    NoSeriesLine."Last No. Used" := Bin_BatchSequentialNo
                else
                    NoSeriesLine."Last No. Used" := Bin_BatchSequentialNo;

                NoSeriesLine.MODIFY();
            end;

        end;

        //Generate Batch Sequential Number for "Wort/Must" and "Semi-Finished Beverage" , Finished Beverage in Work Center
        if (Item."Batch Number Policy FND" = Item."Batch Number Policy FND"::"Wort/Must") or
          (Item."Batch Number Policy FND" = Item."Batch Number Policy FND"::"Semi-Finished Beverage") or
          (Item."Batch Number Policy FND" = Item."Batch Number Policy FND"::"Finished Beverage") then begin


            if "Item Journal Line"."Entry Type" = "Item Journal Line"."Entry Type"::Output then begin
                if "Item Journal Line".Type = "Item Journal Line".Type::"Work Center" then begin

                    "Item Journal Line".TESTFIELD("Item Journal Line"."No.");

                    if WorkCenter.GET("Item Journal Line"."No.") then begin
                        WorkCenter.TESTFIELD(WorkCenter."Batch sequential number FND");
                        WorkCenterBatchSeqNum := WorkCenter."Batch sequential number FND";

                        //HEI.04>>
                        //NoSeriesLine.GET(WorkCenterBatchSeqNum,10000);
                        NoSeriesLine.RESET();
                        NoSeriesLine.SETCURRENTKEY("Series Code", Open, "Dummy FND");//HEI.05
                        NoSeriesLine.SETRANGE("Series Code", WorkCenterBatchSeqNum);
                        NoSeriesLine.SETRANGE(Open, true);
                        NoSeriesLine.SETRANGE("Dummy FND", false);//HEI.05
                                                            //NoSeriesLine.SETRANGE("Ending No.",'');//HEI.05
                        if not NoSeriesLine.FINDLAST() then
                            ERROR('No. series does not exists for %1', WorkCenterBatchSeqNum);
                        //HEI.04<<
                        if NoSeriesLine."Last No. Used" = '' then
                            WorkCenterBatchSeqNum := NoSeriesLine."Starting No."
                        else begin
                            WorkCenterBatchSeqNum := NoSeriesLine."Last No. Used";
                            increment_no := NoSeriesLine."Increment-by No.";
                            for i := 1 to increment_no do begin
                                WorkCenterBatchSeqNum := INCSTR(WorkCenterBatchSeqNum);
                            end;
                        end;

                        Len := STRLEN(WorkCenterBatchSeqNum);
                        if Len <> 4 then
                            ERROR(Err004, NoSeriesLine."Series Code", "Item Journal Line"."No.")
                        else begin
                            if NoSeriesLine."Last No. Used" = '' then
                                NoSeriesLine."Last No. Used" := WorkCenterBatchSeqNum
                            else
                                NoSeriesLine."Last No. Used" := WorkCenterBatchSeqNum;

                            NoSeriesLine.MODIFY();
                        end;

                    end;
                end;
            end;

        end;
        //>>

        //GENERATE Sequential Number for Bulk Product Related Materials -01
        if Item."Batch Number Policy FND" = Item."Batch Number Policy FND"::"Bulk Product Related Materials" then begin
            WarehouseEntry.RESET();
            WarehouseEntry.SETRANGE(WarehouseEntry."Entry Type", WarehouseEntry."Entry Type"::"Positive Adjmt.");
            WarehouseEntry.SETRANGE(WarehouseEntry."Item No.", ItemNo);
            WarehouseEntry.SETRANGE(WarehouseEntry."Location Code", LocationCode);
            WarehouseEntry.SETRANGE(WarehouseEntry."Bin Code", BinCode);
            if WarehouseEntry.FINDSET() then begin
                repeat
                    WarehouseCount := WarehouseCount + 1;
                until WarehouseEntry.NEXT() = 0;
            end else begin
                WarehouseCount := 0;
            end;
            Len1 := STRLEN(FORMAT(WarehouseCount));

            if Len1 = 1 then
                SeqNum_BulkProdRelatedMaterial := '000' + FORMAT(WarehouseCount);
            if Len1 = 2 then
                SeqNum_BulkProdRelatedMaterial := '00' + FORMAT(WarehouseCount);
            if Len1 = 3 then
                SeqNum_BulkProdRelatedMaterial := '0' + FORMAT(WarehouseCount);
            if Len1 = 4 then
                SeqNum_BulkProdRelatedMaterial := FORMAT(WarehouseCount);

        end;
    end;

    local procedure GenBatchBPRM(locationPlantId: Text[1]; ProductionResource: Code[4]; BatchSequentialNo1: Code[4]);
    var
        ProductionResource1: Text[4];
        locationPlantId1: Text[1];
    begin
        //Bulk Product Related Materials

        NewBatchNumer := '';

        locationPlantId1 := locationPlantId;
        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 8, 1);
        ProductionResource1 := ProductionResource;

        Len2 := STRLEN(ProductionResource1);
        if Len2 < 4 then
            ERROR(Err001, BinCode1);

        NewBatchNumer := locationPlantId1 + Year + ProductionResource1 + BatchSequentialNo1;
    end;

    local procedure GenBatchDPRM(locationPlantId: Text[1]; Loc_BatchSequentialNo: Code[3]);
    var
        BatchSequentialNo1: Code[3];
        locationPlantId1: Text[1];
    begin
        //Discrete Product Related Materials
        NewBatchNumer := '';

        locationPlantId1 := locationPlantId;  //1

        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 7, 2);  //2
        Month := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 3, 2); //2
        Day := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 1, 2);  //2

        NewBatchNumer := locationPlantId1 + Year + Month + Day + Loc_BatchSequentialNo;
        //cleard checked on Batch sequential no.
    end;

    local procedure GenBatchHY(locationPlantId: Text[1]; ProductionResource: Code[4]; BatchSequentialNo: Code[10]);
    var
        ProductionResource1: Code[10];
        BatchSequentialNo1: Code[10];
        locationPlantId1: Text[20];
    begin
        //Harvested Yeast
        /*
        NewBatchNumer:='';
        
        locationPlantId1 := locationPlantId;
        Year := COPYSTR(FORMAT(TODAY,0,'<Day,2><Month,2><Year4>'),8,1);
        ProductionResource1 := ProductionResource;
        
        Len2 := STRLEN(ProductionResource1);
        IF Len2 < 4 THEN
          ERROR(Err001,BinCode1);
        
        NewBatchNumer :=locationPlantId1+Year+PropogationNumber+GenerationNumber+ProductionResource1+'0';
        */

    end;

    local procedure GenBatchPY(locationPlantId: Text[20]; ProductionResource: Code[4]; BatchSequentialNo: Code[10]);
    var
        ProductionResource1: Code[10];
        BatchSequentialNo1: Code[10];
        locationPlantId1: Text[20];
    begin
        //Propagated Yeast
        /*
        NewBatchNumer:='';
        
        locationPlantId1 := locationPlantId;
        Year := COPYSTR(FORMAT(TODAY,0,'<Day,2><Month,2><Year4>'),8,1);
        ProductionResource1 := ProductionResource;
        Len2 := STRLEN(ProductionResource1);
        IF Len2 < 4 THEN
          ERROR(Err001,BinCode1);
        
        NewBatchNumer :=locationPlantId1+Year+PropogationNumber+GenerationNumber+ProductionResource1+'0';
        */

    end;

    local procedure GenBatchFPOP(ProductionResource1: Code[4]);
    var
        EUDirective: Code[1];
    begin
        /*
        //Finished Product Own Produced
        NewBatchNumer:='';
        
        EUDirective := 'L';    //1 (1)
        Year := COPYSTR(FORMAT(TODAY,0,'<Day,2><Month,2><Year4>'),8,1);  //2 (1)
        //>>Julian Day
        intYear := DATE2DMY(TODAY, 3);
        JulianDay := FORMAT( TODAY - DMY2DATE(1, 1, intYear));  //3 (3)
        Len := STRLEN(JulianDay);
        IF Len = 2 THEN
          JulianDay := '0'+JulianDay;
        IF Len = 1 THEN
          JulianDay := '00'+JulianDay;
        //<<Julian Day
        
        //Country_Dailing_Code;   //4 (3)
        PackingLines := ProductionResource1; //5 (1)
        Len2 := STRLEN(PackingLines);
        IF Len2 > 1 THEN
          ERROR(Err003,BinCode1);
        //ShiftIndicator ;  //6 (1)
        
        NewBatchNumer :=EUDirective+Year+JulianDay+Country_Dailing_Code+PackingLines+ShiftIndicator;
        */

    end;

    local procedure GenBatchWM(locationPlantId: Text[1]; ProductionResource: Code[4]; BatchSequentialNo: Code[4]);
    var
        ProductionResource1: Code[4];
        BatchSequentialNo1: Code[4];
        locationPlantId1: Text[1];
    begin

        NewBatchNumer := '';

        locationPlantId1 := locationPlantId;   //1 (1)
        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 8, 1);  //2 (1)

        Len2 := STRLEN(ProductionResource);  //3 (4)
        if Len2 < 4 then
            ERROR(Err001, BinCode1);

        Len2 := STRLEN(BatchSequentialNo);  //3 (4)
        if Len2 < 4 then
            ERROR(Err001, BinCode1);

        //BatchSequentialNo; //4 (4)

        NewBatchNumer := locationPlantId1 + Year + ProductionResource + BatchSequentialNo;
    end;

    local procedure GenBatchFC(locationPlantId: Text[1]; ProductionResource: Code[4]; BatchSequentialNo: Code[4]);
    var
        ProductionResource1: Code[4];
        BatchSequentialNo1: Code[4];
        locationPlantId1: Text[1];
    begin
        //Filtration Capacity
        NewBatchNumer := '';

        locationPlantId1 := locationPlantId;   //1 (1)
        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 8, 1);  //2 (1)

        Len2 := STRLEN(ProductionResource);  //3 (4)
        if Len2 < 4 then
            ERROR(Err001, BinCode1);

        //  BatchSequentialNo;  //4 (4)

        NewBatchNumer := locationPlantId1 + Year + ProductionResource + BatchSequentialNo;
    end;

    local procedure GenBatchSFB(locationPlantId: Text[1]; ProductionResource: Code[4]; BatchSequentialNo: Code[4]);
    var
        ProductionResource1: Code[4];
        BatchSequentialNo1: Code[4];
        locationPlantId1: Text[1];
    begin
        //Semi-Finished Beverage
        NewBatchNumer := '';

        locationPlantId1 := locationPlantId;   //1 (1)
        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 8, 1);  //2 (1)

        Len2 := STRLEN(ProductionResource);  //3 (4)
        if Len2 < 4 then
            ERROR(Err001, BinCode1);

        // BatchSequentialNo ;  //4 (4)

        NewBatchNumer := locationPlantId1 + Year + ProductionResource + BatchSequentialNo;
    end;

    local procedure GenBatchFB(locationPlantId: Text[1]; ProductionResource: Code[4]; BatchSequentialNo: Code[4]);
    var
        ProductionResource1: Code[4];
        BatchSequentialNo1: Code[4];
        locationPlantId1: Text[1];
    begin
        //Finished Beverage
        NewBatchNumer := '';

        locationPlantId1 := locationPlantId;   //1 (1)
        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 8, 1);  //2 (1)

        Len2 := STRLEN(ProductionResource);  //3 (4)
        if Len2 < 4 then
            ERROR(Err001, BinCode1);

        //  BatchSequentialNo;  //4 (4)

        NewBatchNumer := locationPlantId1 + Year + ProductionResource + BatchSequentialNo;
    end;

    procedure RetrieveBatchNo(): Code[20];
    begin
        exit(NewBatchNumer);
    end;
}

