report 50034 "Auto Batch No. Generation_FPOP"
{
    // version HEI.01 IBM

    // HEI.01 FDD-PRDGAP004 - Automatic Batch Number Generation , 10.09.2017 IBM.NAIKH01
    //   #Created a new Report to generate new Batch Numbers
    //  HEI.02 CHG0270593 - IBM ISYED01 2.15.2019
    //   # if Batch Number Policy"::"Finished Product Own Produced" then julian date will be calculated  based on posting date
    // 

    ProcessingOnly = true;
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

                BinCode1 := "Bin Code";

                /// Bin
                if Bin.GET("Location Code", "Bin Code") then begin
                    Bin.TESTFIELD("Batch Production Resource FND");
                    ProductionResource := Bin."Batch Production Resource FND";
                end;

                case Item."Batch Number Policy FND" of

                    //Finished Product Own Produced -- 09  --> Done
                    Item."Batch Number Policy FND"::"Finished Product Own Produced":
                        GenBatchFPOP(ProductionResource, "Item Journal Line"."Posting Date");

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
                field("Shift/Hours Indicator"; ShiftIndicator)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ShiftIndicator field.';
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
        ShiftIndicator := '0';
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

    local procedure GenBatchFPOP(ProductionResource1: Code[4]; Postingdate: Date);
    var
        EUDirective: Code[1];
    begin
        //Finished Product Own Produced
        NewBatchNumer := '';

        EUDirective := 'L';    //1 (1)
        //$$
        //Year := COPYSTR(FORMAT(TODAY,0,'<Day,2><Month,2><Year4>'),8,1);  //2 (1) //oldsyed
        if Postingdate <> 0D then
            Year := COPYSTR(FORMAT(Postingdate, 0, '<Day,2><Month,2><Year4>'), 8, 1);  //2 (1)

        //>>Julian Day

        //intYear := DATE2DMY(TODAY, 3);//old
        if Postingdate <> 0D then
            intYear := DATE2DMY(Postingdate, 3);
        //JulianDay := FORMAT( TODAY - DMY2DATE(1, 1, intYear));  //3 (3)
        if Postingdate <> 0D then
            JulianDay := FORMAT(Postingdate - DMY2DATE(1, 1, intYear));  //3 (3)
        //$$<<
        JulianDay := INCSTR(JulianDay);
        Len := STRLEN(JulianDay);
        if Len = 2 then
            JulianDay := '0' + JulianDay;
        if Len = 1 then
            JulianDay := '00' + JulianDay;
        //<<Julian Day

        //Country_Dailing_Code;   //4 (3)
        PackingLines := ProductionResource1; //5 (1)
        Len2 := STRLEN(PackingLines);
        if Len2 > 1 then
            ERROR(Err003, BinCode1);
        //ShiftIndicator ;  //6 (1)

        NewBatchNumer := EUDirective + Year + JulianDay + Country_Dailing_Code + PackingLines + ShiftIndicator;
    end;

    procedure RetrieveBatchNo(): Code[20];
    begin
        exit(NewBatchNumer);
    end;
}

