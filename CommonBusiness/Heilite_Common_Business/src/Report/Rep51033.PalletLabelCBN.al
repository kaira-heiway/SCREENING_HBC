report 51033 "Pallet Label CBN"
{
    // HEI.01 FDDPallet Label IBM ISYED01 1.24.2019
    //   #Added new report for pallet lable.


    // BC Upgrade SHUKLP03 >>
    // Some part of OnAfterGetRecored() and procedure GenerateLotNo code is blocked because of Drink-IT fields.
    // BC Upgrade SHUKLP03 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Pallet Label.rdl';
    ApplicationArea = All;


    dataset
    {
        dataitem("Integer"; "Integer")
        {
            MaxIteration = 1;
            PrintOnlyIfDetail = false;
            column(LotNo; LotNoGenerated)
            {
            }
            column(Item_Desc; ItemDesc)
            {
            }
            column(Item_No; ItemFiltering)
            {
            }
            column(PalletQuality; FORMAT(PalletQuality) + ' ' + UOMDesc)
            {
            }
            column(ExpirationDate; FORMAT(ExpirationDate))
            {
            }
            column(ProductionDate; FORMAT(Productiondate))
            {
            }
            column(ShelfLifeDays; ShelfLifeDays)
            {
            }
            column(ManualInput; ManualInput)
            {
            }
            column(Extended; Extended)
            {
            }
            column(OutputNo; OutputNo)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if ItemFiltering <> '' then
                    ItemRec.GET(ItemFiltering);

                ItemDesc := ItemRec.Description;
                ItemRecExpCalcu := FORMAT(ItemRec."Expiration Calculation");
                if InventorySetup.GET() then
                    ItemUnitofMeasure.RESET();
                ItemUnitofMeasure.SETRANGE("Item No.", ItemRec."No.");
                // ItemUnitofMeasure.SETRANGE(Code, ItemRec."Inventory Unit of Measure");  // BC Upgrade SHUKLP03 Drink-IT <<
                if ItemUnitofMeasure.FINDFIRST() then begin
                    ItemUOMqty := ItemUnitofMeasure."Qty. per Unit of Measure";
                    if UnitofMeasure.GET(ItemUnitofMeasure.Code) then
                        UOMDesc := UnitofMeasure.Description;
                end;

                ItemUnitofMeasure.RESET();
                ItemUnitofMeasure.SETRANGE("Item No.", ItemRec."No.");
                //ItemUnitofMeasure.SETRANGE(Code, InventorySetup.Pallet); // BC Upgrade SHUKLP03 Drink-IT <<
                if ItemUnitofMeasure.FINDFIRST() then
                    ItemPalQty := ItemUnitofMeasure."Qty. per Unit of Measure";

                if (ItemUOMqty > 1) and (ItemPalQty > 1) then begin
                    if ItemUOMqty > ItemPalQty then
                        PalletQuality := ItemUOMqty / ItemPalQty
                    else if ItemPalQty > ItemUOMqty then
                        PalletQuality := ItemPalQty / ItemUOMqty;
                end;



                if not ManualInput then begin
                    ItemLedgerEntry.RESET();
                    ItemLedgerEntry.SETRANGE(Open, true);
                    ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Output);
                    ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
                    ItemLedgerEntry.SETFILTER("Item No.", ItemFiltering);
                    ItemLedgerEntry.SETFILTER("Lot No.", LotFiltering);
                    if ItemLedgerEntry.FINDFIRST() then begin
                        ExpirationDate := ItemLedgerEntry."Expiration Date";
                        Productiondate := ItemLedgerEntry."Posting Date";
                        ExpirationCalc := FORMAT(ItemRec."Expiration Calculation");
                    end;
                end
                else begin
                    ExpirationDate := CALCDATE(ItemRec."Expiration Calculation", Productiondatefilter);
                    Productiondate := Productiondatefilter;
                end;

                if ManualInput then
                    LotNoGenerated := GenerateLotNo(ItemFiltering, OverWriteLNProposalFilter, Productiondatefilter)
                else
                    LotNoGenerated := LotFiltering;

                ShelfLifeDays := DELCHR(FORMAT(ItemRec."Expiration Calculation"), '=', 'D');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Manual; ManualInput)
                {
                    Caption = 'Manual';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manual field.';

                    trigger OnValidate();
                    begin
                        if ManualInput then begin
                            EnableProddate := false;
                            EnableQtyManual := true;
                        end
                        else begin
                            EnableProddate := true;
                            EnableQtyManual := false;
                        end;
                    end;
                }
                field(Item; ItemFiltering)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ItemFiltering field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        ItemRec.RESET();
                        ItemRec.SETRANGE("Item Category Code", '01');
                        if PAGE.RUNMODAL(0, ItemRec) = ACTION::LookupOK then
                            ItemFiltering := ItemRec."No.";
                    end;
                }
                field("Lot No"; LotFiltering)
                {
                    Editable = EnableProddate;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LotFiltering field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LotNumberInfoRec.SETFILTER(LotNumberInfoRec."Item No.", ItemFiltering);

                        if PAGE.RUNMODAL(0, LotNumberInfoRec) = ACTION::LookupOK then
                            LotFiltering := LotNumberInfoRec."Lot No.";
                    end;
                }
                field("Last two digits of Lot to print"; OverWriteLNProposalFilter)
                {
                    Editable = EnableQtyManual;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OverWriteLNProposalFilter field.';
                }
                field(Extended; Extended)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Extended field.';
                }
                field("Production Date"; Productiondatefilter)
                {
                    Editable = EnableQtyManual;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Productiondatefilter field.';
                }
            }
        }

        actions
        {
            area(processing)
            {
                //Caption = 'Generate Lot.';
                action(test)
                {
                    ApplicationArea = All;
                    ToolTip = 'Executes the test action.';
                }
            }
        }
    }

    labels
    {
        Reportlabel = 'Pallet label'; ItemNumberlbl = 'Item Number'; ItemDescriptionlbl = 'Item Description'; Quantitylbl = 'Quantity'; ExpirationDatelbl = 'Expiration Date'; ProductionDatelbl = 'Production Date'; ShelfLifeDayslbl = 'Shelf Life Days'; Lotnolbl = 'Lot Number';
    }

    trigger OnInitReport();
    begin
        EnableProddate := true;
        EnableQtyManual := false;
    end;

    trigger OnPreReport();
    begin
        if ManualInput then
            if Productiondatefilter = 0D then
                ERROR(Err001);
    end;

    var
        bin: Record Bin;
        CompanyInformation: Record "Company Information";
        CountryRegion: Record "Country/Region";
        InventorySetup: Record "Inventory Setup";
        ItemRec: Record Item;
        ILE: Record "Item Ledger Entry" temporary;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        LocationRec: Record Location;
        LotNumberInfoRec: Record "Lot No. Information";
        UnitofMeasure: Record "Unit of Measure";

        EnableProddate: Boolean;

        EnableQtyManual: Boolean;
        Extended: Boolean;
        ManualInput: Boolean;
        JulianDay: Code[3];
        PackingLines: Code[4];
        BinCode: Code[20];
        Country_Dailing_Code: Code[20];
        Country_region: Code[20];
        ItemFiltering: Code[100];
        LotFiltering: Code[100];
        ExpirationDate: Date;
        Productiondate: Date;
        Productiondatefilter: Date;
        ItemPalQty: Decimal;
        ItemUOMqty: Decimal;
        intYear: Integer;
        Len: Integer;
        Len2: Integer;
        OutputNo: Integer;
        PalletQuality: Integer;
        QtyFilter: Integer;
        Err001: Label 'If Manual is selected Manual production date cannot be Empty';
        Err003: Label 'The Length of the field "Batch Production Resource" for the Bin Code "%1" should be 1 Character';
        Err006: Label 'The Length of String Country Dailing Code should be 3';
        ExpirationCalc: Text;
        ItemRecExpCalcu: Text;
        OverWriteLNProposalFilter: Text;
        Day: Text[2];
        Month: Text[2];
        Year: Text[2];
        ShiftIndicator: Text[3];
        ItemDesc: Text[50];
        LotNoGenerated: Text[50];
        ProductionResource: Text[50];
        ShelfLifeDays: Text[50];
        UOMDesc: Text[50];

    local procedure GenerateLotNo(ItemNo: Code[100]; "OverWritePL&ShiftIndicator": Text; Productiondatefilter: Date) NewBatchNumer: Text[20];
    var
        EUDirective: Code[1];
    begin

        CompanyInformation.GET();
        ItemRec.GET(ItemNo);

        Country_region := CompanyInformation."Country/Region Code";
        CountryRegion.GET(Country_region);

        if ItemRec."Batch Number Policy FND" = ItemRec."Batch Number Policy FND"::"Finished Product Own Produced" then
            CountryRegion.TESTFIELD("Country Dialing code FND");

        Country_Dailing_Code := CountryRegion."Country Dialing code FND";
        Len := STRLEN(Country_Dailing_Code);
        if Len < 3 then
            ERROR(Err006);

        /// Bin

        // BC Upgrade SHUKLP03 >> code blocked because of Drink-IT field "Location Code".
        // if bin.GET(ItemRec."Location Code") then begin
        //   bin.TESTFIELD("Batch Production Resource");
        //    //Country_Dailing_Code;   //4 (3)
        //    PackingLines := bin."Batch Production Resource";
        // CompanyInformation.GET();
        // ItemRec.GET(ItemNo);

        // Country_region := CompanyInformation."Country/Region Code";
        // CountryRegion.GET(Country_region);

        //    Len2 := STRLEN(PackingLines);
        // if Len2 > 1 then
        //   ERROR(Err003,bin.Code);
        // end;
        // BC Upgrade SHUKLP03 << code blocked because of Drink-IT field "Location Code".

        //Finished Product Own Produced
        CLEAR(NewBatchNumer);

        EUDirective := 'L';    //1 (1)
        //Year := COPYSTR(FORMAT(TODAY,0,'<Day,2><Month,2><Year4>'),8,1);  //2 (1)
        Year := COPYSTR(FORMAT(Productiondatefilter, 0, '<Day,2><Month,2><Year4>'), 8, 1);  //2 (1)
        //>>Julian Day
        //intYear := DATE2DMY(TODAY, 3);
        intYear := DATE2DMY(Productiondatefilter, 3);
        //JulianDay := FORMAT( TODAY - DMY2DATE(1, 1, intYear));  //3 (3)
        JulianDay := FORMAT(Productiondatefilter - DMY2DATE(1, 1, intYear));  //3 (3)
        JulianDay := INCSTR(JulianDay);
        Len := STRLEN(JulianDay);
        if Len = 2 then
            JulianDay := '0' + JulianDay;
        if Len = 1 then
            JulianDay := '00' + JulianDay;
        //<<Julian Day

        ShiftIndicator := '0';

        if "OverWritePL&ShiftIndicator" <> '' then
            NewBatchNumer := EUDirective + Year + JulianDay + Country_Dailing_Code + "OverWritePL&ShiftIndicator"
        else
            NewBatchNumer := EUDirective + Year + JulianDay + Country_Dailing_Code + PackingLines + ShiftIndicator;
        ;
    end;

    procedure SetCalculationParameter(ItemNo: Text; LotNo: Text; ManualInputPar: Boolean);
    begin
        ItemFiltering := ItemNo;
        LotFiltering := LotNo;
        ManualInput := ManualInputPar;
        EnableProddate := ManualInputPar;
        EnableQtyManual := ManualInputPar;
    end;
}

