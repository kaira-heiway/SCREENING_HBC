report 51023 "Actual Sales Monthly Exp CBN"
{
    // version HEI.01

    // HEI:EDD068:1:1 19/11/14 TECTURA-HKH
    // SOICAD01 migrated from NAV 2013
    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Changes:
    // 1. Replaced File object with TempBlob and Streams for file handling
    // 2. Replaced CommonDialogMgt codeunit methods with standard BC functions
    // 3. Added ApplicationArea and UsageCategory properties
    // 4. Replaced DownloadToFile with DownloadFromStream for file download
    // 5. Removed server-side file operations (CREATE, WRITE, CLOSE on File object)
    // 6. Comment Drink IT Fields Code and Tablerelation
    // 7. Comment Product Group Code field for Functional Query
    // 8. Comment Product Group Table code for Functional Query
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All; // BC Upgrade BHARDA11
    UsageCategory = ReportsAndAnalysis; // BC Upgrade BHARDA11


    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                TempILE.RESET();
                if TempILE.findset() then
                    repeat
                        TempILE.DELETE();
                    until TempILE.NEXT() = 0;

                Loc.RESET();
                if Loc.findset() then
                    repeat
                        ItemLedEntry.RESET();
                        ItemLedEntry.SETCURRENTKEY("Item No.", "Entry Type", "Variant Code", "Drop Shipment",
                                                   "Location Code", "Posting Date");
                        ItemLedEntry.SETRANGE("Item No.", Item."No.");
                        ItemLedEntry.SETRANGE("Entry Type", ItemLedEntry."Entry Type"::Sale);
                        ItemLedEntry.SETRANGE("Location Code", Loc.Code);
                        ItemLedEntry.SETRANGE("Posting Date", StartingDate, EndingDate);
                        if ItemLedEntry.findset() then
                            repeat
                                LotNoInfo.RESET();
                                if LotNoInfo.GET(ItemLedEntry."Item No.", ItemLedEntry."Variant Code", ItemLedEntry."Lot No.") then begin
                                    if not LotNoInfo.Blocked then
                                        InsertDataToTemp(ItemLedEntry);
                                end;
                            until ItemLedEntry.NEXT() = 0;
                    until Loc.NEXT() = 0;

                TempChannelDimValue.RESET();
                if TempChannelDimValue.findset() then
                    repeat
                        Stock := 0;
                        // BC Upgrade BHARDA11 >> ---- Drink IT Fields "Quantity in HL"
                        // TempILE.RESET;
                        // TempILE.SETRANGE("Global Dimension 1 Code", TempChannelDimValue.Code);
                        // if TempILE.findset then
                        //     repeat
                        //         Stock += TempILE."Quantity in HL";
                        //     until TempILE.NEXT = 0;
                        // Stock := ROUND(Stock, 0.001);
                        // BC Upgrade BHARDA11 << ---- Drink IT Fields "Quantity in HL"

                        if Stock <> 0 then begin
                            //Material Number Char (15)
                            if STRLEN(Item."No.") > 15 then
                                ERROR(Text009);
                            FleRecord := COPYSTR(Item."No.", 1, 15) + Text004;

                            //Aggregation Field 1
                            // FleRecord += Item."Item Category Code" + Item."Product Group Code" + TempChannelDimValue.Code + Text004; // BC Upgrade BHARDA11 ... Functional Query Pending

                            //Aggregation Field 2 
                            if STRLEN(PhysicalLocGrpCode) > 4 then
                                ERROR(Text010);
                            FleRecord += COPYSTR(PhysicalLocGrpCode, 1, 4) + Text004;

                            //Week Number Char (6)
                            FleRecord += FORMAT(StartingDate, 0, '<Year4><Month,2>') + Text004;

                            //Stock Char (13)
                            FleRecord += FORMAT(Stock, 0, '<Sign><Integer><Decimals,4>');

                            Cnt += 1;
                            // FleCIL1.WRITE(FleRecord);  
                            // BC Upgrade BHARDA11: Write to OutStream instead of File.Write
                            //BC Upgrade BHARDA11 >>
                            OutStr.WriteText(FleRecord); //BC Upgrade BHARDA11
                            OutStr.WriteText();
                            //BC Upgrade BHARDA11 <<
                        end;

                    until TempChannelDimValue.NEXT() = 0;
            end;

            trigger OnPreDataItem();
            begin
                Item.SETFILTER("Item Category Code", ItemCategoryFilter);
                // Item.SETFILTER("Product Group Code", ProdGroupFilter); // BC Upgrade BHARDA11 ... Functional Query Pending
                if ItemFilter <> '' then
                    Item.SETFILTER("No.", ItemFilter);
                // BC Upgrade BHARDA11: Removed File.Create - now using TempBlob initialized in OnPreReport
                //BC Upgrade BHARDA11 >>
                // FromFile := CommonDialogMgt.ServerTempFileName('txt');
                // FleCIL1.CREATE(FromFile);
                // FleCIL1.TEXTMODE := true;
                //BC Upgrade BHARDA11 <<
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
                field(Filename; Filename)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'File Name',
                                FRA = 'Nom du fichier';
                    ToolTip = 'Specifies the value of the Filename field.';
                    //BC Upgrade BHARDA11 >>
                    // BC Upgrade BHARDA11: Removed OnAssistEdit trigger as SaveFileDialog not supported in BC
                    // trigger OnAssistEdit();
                    // begin
                    //     Filename := CommonDialogMgt.SaveFileDialog(Text002, Filename, '*.*|*.txt*');
                    // end;
                    //BC Upgrade BHARDA11 <<
                }
                field(ItemCategoryFilter; ItemCategoryFilter)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Item Category Code',
                                FRA = 'Item Category Code';
                    TableRelation = "Item Category";
                    ToolTip = 'Specifies the value of the ItemCategoryFilter field.';
                }
                field(ProdGroupFilter; ProdGroupFilter)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Product Group',
                                FRA = 'Product Group';
                    ToolTip = 'Specifies the value of the ProdGroupFilter field.';

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        // BC Upgrade BHARDA11 >> ....Functional Query
                        // ProdGroup.RESET;
                        // ProdGroup.SETRANGE("Item Category Code", ItemCategoryFilter);
                        // if ProdGroup.FINDFIRST then begin
                        //     if PAGE.RUNMODAL(0, ProdGroup) = ACTION::LookupOK then begin
                        //         ProdGroupFilter := ProdGroup.Code;
                        //     end;
                        // end;
                        // BC Upgrade BHARDA11 << ....Functional Query
                    end;
                }
                field(ItemFilter; ItemFilter)
                {
                    CaptionML = ENU = 'Item No.',
                                FRA = 'Item No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ItemFilter field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin

                        recItem.RESET();
                        if ItemCategoryFilter <> '' then
                            recItem.SETRANGE("Item Category Code", ItemCategoryFilter);
                        if recItem.FINDFIRST() then begin
                            if PAGE.RUNMODAL(0, recItem) = ACTION::LookupOK then begin
                                ItemFilter := recItem."No.";
                            end;
                        end;
                    end;
                }
                field(PhysicalLocGrpFilter; PhysicalLocGrpFilter)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Physical Location Group Code ',
                                FRA = 'Physical Location Group Code ';
                    ToolTip = 'Specifies the value of the PhysicalLocGrpFilter field.';
                    // TableRelation = "Physical Location Group";  // BC Upgrade BHARDA11 --Drink IT Table
                }
                field(Year; Year)
                {
                    Caption = 'Year';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year field.';
                }
                field(Month; Month)
                {
                    CaptionML = ENU = 'Month',
                                FRA = 'Month';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field(ChannelDim; ChannelDim)
                {
                    CaptionML = ENU = 'Channel',
                                FRA = 'Channel';
                    TableRelation = Dimension;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ChannelDim field.';
                }
                field(ChannelDimFilter; ChannelDimFilter)
                {
                    CaptionML = ENU = 'Channel Filter',
                                FRA = 'Channel Filter';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ChannelDimFilter field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin

                        DimValue.RESET();
                        DimValue.SETRANGE("Dimension Code", ChannelDim);
                        if DimValue.FINDFIRST() then begin
                            if PAGE.RUNMODAL(0, DimValue) = ACTION::LookupOK then begin
                                ChannelDimFilter := DimValue.Code;
                            end;
                        end;
                    end;
                }
                field(PhysicalLocGrpCode; PhysicalLocGrpCode)
                {
                    Caption = 'FM Plant Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FM Plant Code field.';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin

            Year := DATE2DMY(TODAY, 3);
            Month := DATE2DMY(TODAY, 2) - 1;
            //BC Upgrade BHARDA11 >>
            // BC Upgrade NANDIS03: Auto-generate filename with date stamp
            if Filename = '' then
                Filename := 'ActualSales_' + Format(Year) + '_' + Format(Month) + '.txt';
            //BC Upgrade BHARDA11 <<

        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    var
        InStr: InStream; // BC Upgrade BHARDA11
    begin
        // BC Upgrade BHARDA11 >>
        // FleCIL1.CLOSE;
        // CommonDialogMgt.DownloadToFile(FromFile, Filename); 
        // BC Upgrade BHARDA11 <<
        // Replaced FleCIL1.Close and CommonDialogMgt.DownloadToFile with DownloadFromStream


        if Cnt <> 0 then begin
            // BC Upgrade BHARDA11 >> 
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, 'Export to File', '', 'Text Files (*.txt)|*.txt', Filename);
            // BC Upgrade BHARDA11 <<
            MESSAGE(Text005, Cnt);
        end else begin
            // CommonDialogMgt.DeleteClientFile(Filename); // BC Upgrade BHARDA11
            // BC Upgrade BHARDA11: Removed DeleteClientFile as not applicable in BC
            MESSAGE(Text008);
        end;
    end;

    trigger OnPreReport();
    begin

        if Filename = '' then
            ERROR(Text001);
        // BC Upgrade BHARDA11 >>
        // Removed file existence check and overwrite confirmation as BC handles this in DownloadFromStream
        // if EXISTS(Filename) then
        //     if CONFIRM(Text003, false) then
        //         ERASE(Filename)
        //     else
        //         CurrReport.QUIT;
        // BC Upgrade BHARDA11 <<

        StartingDate := DMY2DATE(1, Month + 1, Year);
        if Month = 11 then
            EndingDate := DMY2DATE(31, Month + 1, Year)
        else
            EndingDate := CALCDATE('<-1D>', DMY2DATE(1, Month + 2, Year));


        TempChannelDimValue.DELETEALL();
        if (ChannelDim <> '') then begin
            DimValue.RESET();
            DimValue.SETRANGE("Dimension Code", ChannelDim);
            if (ChannelDimFilter <> '') then
                DimValue.SETFILTER(Code, ChannelDimFilter);
            if DimValue.FINDFIRST() then
                repeat
                    TempChannelDimValue.INIT();
                    TempChannelDimValue."Dimension Code" := DimValue."Dimension Code";
                    TempChannelDimValue.Code := DimValue.Code;
                    TempChannelDimValue.INSERT();
                until DimValue.NEXT() = 0;
        end;
        // BC Upgrade BHARDA11 >>
        // Initialize TempBlob and OutStream instead of File object
        TempBlob.CreateOutStream(OutStr);
        Cnt := 0;
        // BC Upgrade BHARDA11 <<
    end;

    var
        DimValue: Record "Dimension Value";
        TempChannelDimValue: Record "Dimension Value" temporary;
        recItem: Record Item;
        ItemLedEntry: Record "Item Ledger Entry";
        TempILE: Record "Item Ledger Entry" temporary;
        Loc: Record Location;
        LotNoInfo: Record "Lot No. Information";
        //BHARDA11
        CommonDialogMgt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        PhysicalLocGrpCode: Code[4];
        ItemCategoryFilter: Code[10];
        PhysicalLocGrpFilter: Code[10];
        // ProdGroup: Record "Product Group"; // BC Upgrade BHARDA11 .... Functional Query
        ProdGroupFilter: Code[10];
        ChannelDim: Code[20];
        ChannelDimFilter: Code[20];
        ItemFilter: Code[20];
        EndingDate: Date;
        StartingDate: Date;
        Stock: Decimal;
        FleCIL1: File;
        Cnt: Integer;
        Year: Integer;
        Text001: Label 'No filename specified';
        Text003: Label 'File already exisits. Overwrite file?';
        Text004: Label '";"';
        Text005: Label 'File created succesfully with %1 lines.';
        Text006: Label 'Please specify Item Category Code';
        Text007: Label 'Invalid Date';
        Text008: Label 'Nothing to Create.';
        Text009: Label 'Invalid Product Code. Length should be less than 15 characters.';
        Text010: Label 'Invalid Plant Code. Length should be less than 4 characters.';
        Month: Option January,February,March,April,May,June,July,August,September,October,November,December;
        //BHARDA11
        OutStr: OutStream;
        NewLine: Text[2];
        Filename: Text[1024];
        FleRecord: Text[1024];
        FromFile: Text[1024];
        Text002: TextConst ENU = 'Export to', FRA = 'Exporter vers';

    procedure InsertDataToTemp(p_ItemLedEntry: Record "Item Ledger Entry");
    var
        LedEntryDim: Record "Dimension Set Entry";
    begin
        TempILE.INIT();
        TempILE."Entry No." := p_ItemLedEntry."Entry No.";
        // TempILE."Quantity in HL" := p_ItemLedEntry."Quantity in HL"; // BC Upgrade BHARDA11 ---- Drink IT Table
        LedEntryDim.RESET();
        //LedEntryDim.SETRANGE("Table ID",DATABASE::"Item Ledger Entry");
        LedEntryDim.SETRANGE("Dimension Set ID", p_ItemLedEntry."Dimension Set ID");
        LedEntryDim.SETRANGE("Dimension Code", ChannelDim);
        if LedEntryDim.FINDFIRST() then
            TempILE."Global Dimension 1 Code" := LedEntryDim."Dimension Value Code";
        TempILE.INSERT();
    end;
}

