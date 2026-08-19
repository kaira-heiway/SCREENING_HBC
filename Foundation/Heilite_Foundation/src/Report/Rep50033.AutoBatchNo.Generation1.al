report 50033 "Auto Batch No. Generation1"
{
    // version HEI.01 IBM

    // HEI.01 FDD-PRDGAP004 - Automatic Batch Number Generation , 10.09.2017 IBM.NAIKH01
    //   #Created a new Report to generate new Batch Numbers
    //   # Report Used for "Batch Number Policy" : "Propagated Yeast" and "Harvested Yeast".

    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Journal Line"; "Item Journal Line")
        {

            trigger OnAfterGetRecord();
            begin
                Item.GET("Item No.");
                BinCode1 := "Bin Code";
                //Location
                if Location.GET("Location Code") then begin
                    Location.TESTFIELD("Plant ID FND");
                    locationPlantId := Location."Plant ID FND";
                end;
                // Bin
                if Bin.GET("Location Code", "Bin Code") then begin
                    Bin.TESTFIELD("Batch Production Resource FND");
                    ProductionResource := Bin."Batch Production Resource FND";
                end;

                case Item."Batch Number Policy FND" of
                    //Harvested Yeast   -- 06   --> Done
                    Item."Batch Number Policy FND"::"Harvested Yeast":
                        GenBatchHY(locationPlantId, ProductionResource, BatchSequentialNo);

                    //Propagated Yeast  -- 04   --> Done
                    Item."Batch Number Policy FND"::"Propagated Yeast":
                        GenBatchPY(locationPlantId, ProductionResource, BatchSequentialNo);
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Propogation Number"; PropogationNumber)
                {
                    Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PropogationNumber field.';
                }
                field("Generation Number"; GenerationNumber)
                {
                    Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GenerationNumber field.';
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

    trigger OnInitReport();
    begin

        PropogationNumber := '00';
    end;

    trigger OnPreReport();
    begin

        if GenerationNumber = '' then
            ERROR('Generation Number cant be blank');

        Len := STRLEN(PropogationNumber);
        if Len < 2 then
            ERROR('Propogation Number should be 2 Character');

        if PropogationNumber = '' then
            ERROR('Propogation Number cant be blank');
    end;

    var
        Bin: Record Bin;
        CompanyInformation: Record "Company Information";
        CountryRegion: Record "Country/Region";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        Location: Record Location;
        NoSeriesLine: Record "No. Series Line";
        WarehouseEntry: Record "Warehouse Entry";
        WorkCenter: Record "Work Center";
        ItemTrackingLines: Page "Item Tracking Lines";
        GenerationNumber: Code[1];
        ShiftIndicator: Code[1];
        PropogationNumber: Code[2];
        Country_Dailing_Code: Code[3];
        JulianDay: Code[3];
        BatchSequentialNo: Code[4];
        PackingLines: Code[4];
        SeqNum_BulkProdRelatedMaterial: Code[4];
        Bin_BatchSequentialNo: Code[10];
        Country_region: Code[10];
        location_BatchSequentialNo: Code[10];
        NewBatchNumer: Code[10];
        BinCode1: Code[20];
        i: Integer;
        increment_no: Integer;
        intYear: Integer;
        Len: Integer;
        Len2: Integer;
        testint: Integer;
        WarehouseCount: Integer;
        Err001: Label 'The Length of the field "Batch Production Resource" for the Bin Code "%1" should be 4 Character';
        Err002: Label 'The Length of the string for the No Series: "%1" in the "Batch Sequential Number" for Location "%2" should be 3';
        Err003: Label 'The Length of the field "Batch Production Resource" for the Bin Code "%1" should be 1 Character';
        Err004: Label 'The Length of the string for the No Series: "%1" in the "Batch Sequential Number" for Work Center "%2" should be 4';
        Err005: Label 'The Length of the string for the No Series: "%1" in the "Batch Sequential Number" for Bin "%2" should be 4';
        Err006: Label 'The Length of String Country Dailing Code should be 3';
        locationPlantId: Text[1];
        Day: Text[2];
        Month: Text[2];
        Year: Text[2];
        ProductionResource: Text[4];
        WorkCenterBatchSeqNum: Text[4];

    local procedure GenBatchHY(locationPlantId: Text[1]; ProductionResource: Code[4]; BatchSequentialNo: Code[10]);
    var
        BatchSequentialNo1: Code[10];
        ProductionResource1: Code[10];
        locationPlantId1: Text[20];
    begin
        //Harvested Yeast
        NewBatchNumer := '';

        locationPlantId1 := locationPlantId;
        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 8, 1);
        ProductionResource1 := ProductionResource;

        Len2 := STRLEN(ProductionResource1);
        if Len2 < 4 then
            ERROR(Err001, BinCode1);

        NewBatchNumer := locationPlantId1 + Year + PropogationNumber + GenerationNumber + ProductionResource1 + '0';
    end;

    local procedure GenBatchPY(locationPlantId: Text[20]; ProductionResource: Code[4]; BatchSequentialNo: Code[10]);
    var
        BatchSequentialNo1: Code[10];
        ProductionResource1: Code[10];
        locationPlantId1: Text[20];
    begin
        //Propagated Yeast

        NewBatchNumer := '';

        locationPlantId1 := locationPlantId;
        Year := COPYSTR(FORMAT(TODAY, 0, '<Day,2><Month,2><Year4>'), 8, 1);
        ProductionResource1 := ProductionResource;
        Len2 := STRLEN(ProductionResource1);
        if Len2 < 4 then
            ERROR(Err001, BinCode1);

        NewBatchNumer := locationPlantId1 + Year + PropogationNumber + GenerationNumber + ProductionResource1 + '0';
    end;

    procedure RetrieveBatchNo(): Code[20];
    begin
        exit(NewBatchNumer);
    end;
}

