report 50046 "Auto Batch No. Generation_BPRM"
{
    // version HEI.01 IBM

    // HEI.01 FDD-PRDGAP004 - Automatic Batch Number Generation , 10.09.2017 IBM.NAIKH01
    //   #Created a new Report to generate new Batch Numbers

    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            MaxIteration = 1;
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

    var
        Item: Record Item;
        Location: Record Location;
        locationPlantId: Text[1];
        Bin: Record Bin;
        ProductionResource: Text[4];
        BatchSequentialNo: Code[4];
        NewBatchNumer: Code[10];
        Year: Text[2];
        Month: Text[2];
        Day: Text[2];
        location_BatchSequentialNo: Code[10];
        WarehouseEntry: Record "Warehouse Entry";
        WarehouseCount: Integer;
        SeqNum_BulkProdRelatedMaterial: Code[4];
        Len2: Integer;
        Err001: Label 'The Length of the field "Batch Production Resource" for the Bin Code "%1" should be 4 Character';
        NoSeriesLine: Record "No. Series Line";
        Err002: Label 'The Length of the string for the No Series: "%1" in the "Batch Sequential Number" for Location "%2" should be 3';
        i: Integer;
        increment_no: Integer;
        Err003: Label 'The Length of the field "Batch Production Resource" for the Bin Code "%1" should be 1 Character';
        Err004: Label 'The Length of the string for the No Series: "%1" in the "Batch Sequential Number" for Work Center "%2" should be 4';
        Bin_BatchSequentialNo: Code[10];
        Err005: Label 'The Length of the string for the No Series: "%1" in the "Batch Sequential Number" for Bin "%2" should be 4';
        Err006: Label 'The Length of String Country Dailing Code should be 3';
        Len1: Integer;
        Len: Integer;

    procedure GenBatch(ItemNo: Code[10]; LocationCode: Code[10]; BinCode: Code[20]);
    begin

        Item.GET(ItemNo);

        case Item."Batch Number Policy FND" of

            //Bulk Product Related Materials   -- 01   --> Done
            Item."Batch Number Policy FND"::"Bulk Product Related Materials":
                GenBatchBPRM(ItemNo, LocationCode, BinCode);

            //Discrete Product Related Materials  -- 02   --> Done
            Item."Batch Number Policy FND"::"Discrete Product Related Materials":
                GenBatchDPRM(ItemNo, LocationCode, BinCode);
        end;
    end;

    procedure GenBatchBPRM(ItemNo: Code[10]; LocationCode: Code[10]; BinCode: Code[20]);
    var
        ProductionResource: Text[4];
        locationPlantId: Text[1];
    begin
        //Bulk Product Related Materials
        //Location //
        if Location.GET(LocationCode) then begin
            Location.TESTFIELD("Plant ID FND");
            locationPlantId := Location."Plant ID FND";
        end;
        // ------------------------------------
        /// Bin
        if Bin.GET(LocationCode, BinCode) then begin
            Bin.TESTFIELD("Batch Production Resource FND");
            ProductionResource := Bin."Batch Production Resource FND";

            Len2 := STRLEN(ProductionResource);
            if Len2 < 4 then
                ERROR(Err001, BinCode);
        end;
        //---------------------------------------------------------
        //GENERATE Sequential Number for Bulk Product Related Materials -01
        WarehouseEntry.RESET;
        WarehouseEntry.SETRANGE(WarehouseEntry."Entry Type", WarehouseEntry."Entry Type"::"Positive Adjmt.");
        WarehouseEntry.SETRANGE(WarehouseEntry."Item No.", ItemNo);
        WarehouseEntry.SETRANGE(WarehouseEntry."Location Code", LocationCode);
        WarehouseEntry.SETRANGE(WarehouseEntry."Bin Code", BinCode);
        if WarehouseEntry.FINDSET then begin
            repeat
                WarehouseCount := WarehouseCount + 1;
            until WarehouseEntry.NEXT = 0;
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

        // ---------------------------------------------------
        NewBatchNumer := '';

        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 8, 1);

        NewBatchNumer := locationPlantId + Year + ProductionResource + SeqNum_BulkProdRelatedMaterial;
    end;

    procedure GenBatchDPRM(ItemNo: Code[10]; LocationCode: Code[10]; BinCode: Code[20]);
    var
        BatchSequentialNo: Code[3];
        locationPlantId: Text[1];
    begin
        //Discrete Product Related Materials
        if Location.GET(LocationCode) then begin
            Location.TESTFIELD("Plant ID FND");
            locationPlantId := Location."Plant ID FND";
        end;

        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 7, 2);  //2
        Month := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 3, 2); //2
        Day := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 1, 2);  //2

        Location.TESTFIELD(Location."Batch sequential number FND");
        location_BatchSequentialNo := Location."Batch sequential number FND";

        NoSeriesLine.GET(location_BatchSequentialNo, 10000);
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

            NoSeriesLine.MODIFY;
        end;

        NewBatchNumer := '';

        NewBatchNumer := locationPlantId + Year + Month + Day + location_BatchSequentialNo;
    end;

    procedure RetrieveBatchNo(): Code[20];
    begin
        exit(NewBatchNumer);
    end;
}

