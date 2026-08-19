report 51022 "Actual Sales Weekly Export CBN"
{
    // version HEI.01

    // HEI:EDD068:1:1 19/11/14 TECTURA-HKH
    // SOICAD01 migrated from NAV 2013

    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Changes:
    // 1. Replaced File object with TempBlob and OutStream for file handling
    // 2. Removed CommonDialogMgt codeunit - replaced with DownloadFromStream
    // 3. Comment Drink IT Fields and Related Code
    // 4. Added ApplicationArea  properties to all fields
    // 5. Removed server-side file operations (CREATE, WRITE, CLOSE, TEXTMODE)
    // 6. Removed OnAssistEdit trigger (SaveFileDialog not supported in BC)
    // 7. Removed file existence check (handled by DownloadFromStream)
    // 8. Remove Product Group Table Related code
    // 9. Comment Item Product Group Field Code -- Functional Query Required
    // BC Upgrade BHARDA11 <<

    ProcessingOnly = true;
    ApplicationArea = All; // BC Upgrade BHARDA11
    UsageCategory = ReportsAndAnalysis; // BC Upgrade BHARDA11


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
                        // BC Upgrade BHARDA11 >> ----Drink IT Fields "Quantity in HL"
                        // TempILE.RESET;
                        // TempILE.SETRANGE("Global Dimension 1 Code", TempChannelDimValue.Code);
                        // if TempILE.findset then
                        //     repeat
                        //         Stock += TempILE."Quantity in HL";
                        //     until TempILE.NEXT = 0;
                        // BC Upgrade BHARDA11 <<  ----Drink IT Fields "Quantity in HL"
                        Stock := ROUND(Stock, 0.001);

                        if Stock <> 0 then begin
                            //Material Number Char (15)
                            if STRLEN(Item."No.") > 15 then
                                ERROR(Text009);
                            FleRecord := COPYSTR(Item."No.", 1, 15) + Text004;

                            //Aggregation Field 1
                            // FleRecord += Item."Item Category Code" + Item."Product Group Code" + TempChannelDimValue.Code + Text004; // BC Upgrade BHARDA11 ---Fnctional Query Required 

                            //Aggregation Field 2
                            if STRLEN(PhysicalLocGrpCode) > 4 then
                                ERROR(Text010);
                            FleRecord += COPYSTR(PhysicalLocGrpCode, 1, 4) + Text004;

                            //Week Number Char (6)
                            FleRecord += FORMAT(StartingDate, 0, '<Year4><Week,2>') + Text004;

                            //Stock Char (13)
                            FleRecord += FORMAT(Stock, 0, '<Sign><Integer><Decimals,4>');

                            Cnt += 1;
                            // BC Upgrade BHARDA11 >>
                            // FleCIL1.WRITE(FleRecord);
                            OutStr.WriteText(FleRecord);
                            OutStr.WriteText();
                            // BC Upgrade BHARDA11 <<
                        end;
                    until TempChannelDimValue.NEXT() = 0;
            end;

            trigger OnPreDataItem();
            begin

                Item.SETFILTER("Item Category Code", ItemCategoryFilter);
                // Item.SETFILTER("Product Group Code", ProdGroupFilter); // BC Upgrade BHARDA11 ----Functional Query
                if ItemFilter <> '' then
                    Item.SETFILTER("No.", ItemFilter);
                // BC Upgrade BHARDA11 >>
                // FromFile := CommonDialogMgt.ServerTempFileName('txt');
                // FleCIL1.CREATE(FromFile);
                // FleCIL1.TEXTMODE := true;
                // Now using TempBlob initialized in OnPreReport
                // BC Upgrade BHARDA11 <<
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
                    // BC Upgrade BHARDA11 >>
                    // trigger OnAssistEdit();
                    // begin
                    //     //Filename := CommonDialogMgt.OpenFileDialog(Text002,Filename,'');
                    //     Filename := CommonDialogMgt.SaveFileDialog(Text002, Filename, '*.*|*.txt*');
                    // end;
                    // BC Upgrade BHARDA11 <<
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

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        // BC Upgrade BHARDA11 >> --Functional Query Required => Record "Product Group" is obsolete in BC 
                        // ProdGroup.RESET;
                        // ProdGroup.SETRANGE("Item Category Code", ItemCategoryFilter);
                        // if ProdGroup.FINDFIRST then begin
                        //     if PAGE.RUNMODAL(0, ProdGroup) = ACTION::LookupOK then begin
                        //         ProdGroupFilter := ProdGroup.Code;
                        //     end;
                        // end;
                        // BC Upgrade BHARDA11 << --Functional Query Required => Record "Product Group" is obsolete in BC 
                    end;
                }
                field(ItemFilter; ItemFilter)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Item No.',
                                FRA = 'Item No.';
                    ToolTip = 'Specifies the value of the ItemFilter field.';

                    trigger OnLookup(Var Text: Text): Boolean;
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
                field(Year; Year)
                {
                    ApplicationArea = All;
                    Caption = 'Year';
                    ToolTip = 'Specifies the value of the Year field.';
                }
                field(Week; Week)
                {
                    ApplicationArea = All;
                    Caption = 'Week';
                    ToolTip = 'Specifies the value of the Week field.';
                }
                field(ChannelDim; ChannelDim)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Channel',
                                FRA = 'Channel';
                    TableRelation = Dimension;
                    ToolTip = 'Specifies the value of the ChannelDim field.';
                }
                field(ChannelDimFilter; ChannelDimFilter)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Channel Filter',
                                FRA = 'Channel Filter';
                    ToolTip = 'Specifies the value of the ChannelDimFilter field.';

                    trigger OnLookup(Var Text: Text): Boolean;
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
                    ApplicationArea = All;
                    Caption = 'FM Plant Code';
                    ToolTip = 'Specifies the value of the FM Plant Code field.';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin

            Year := DATE2DWY(TODAY, 3);
            Week := DATE2DWY(TODAY, 2);
            // BC Upgrade BHARDA11 >>
            // BC Upgrade BHARDA11: Auto-generate filename with year and week
            if Filename = '' then
                Filename := 'ActualSalesWeekly_' + Format(Year) + '_W' + Format(Week) + '.txt';
            // BC Upgrade BHARDA11 <<
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
        // if Cnt <> 0 then begin
        //     MESSAGE(Text005, Cnt);
        // end else begin
        //     CommonDialogMgt.DeleteClientFile(Filename);
        //     MESSAGE(Text008);
        // end;

        // New: Using DownloadFromStream
        if Cnt <> 0 then begin
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, 'Export to File', '', 'Text Files (*.txt)|*.txt', Filename);
            Message(Text005, Cnt);
        end else begin
            // DeleteClientFile not applicable in BC
            Message(Text008);
        end;
        // BC Upgrade BHARDA11 <<
    end;

    trigger OnPreReport();
    begin

        if Filename = '' then
            ERROR(Text001);
        // BC Upgrade BHARDA11 >>
        // if EXISTS(Filename) then
        //     if CONFIRM(Text003, false) then
        //         ERASE(Filename)
        //     else
        //         CurrReport.QUIT;
        // Now handled automatically by DownloadFromStream
        // BC Upgrade BHARDA11 <<

        if Week > 52 then
            ERROR(Text007);

        StartingDate := DWY2DATE(1, Week, Year);

        EndingDate := CALCDATE('<+6D>', StartingDate);
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
        // BC Upgrade BHARDA11 <<
        CommonDialogMgt: Codeunit "File Management";
        // BC Upgrade BHARDA11 >>
        TempBlob: Codeunit "Temp Blob";
        PhysicalLocGrpCode: Code[4];
        ItemCategoryFilter: Code[10];
        PhysicalLocGrpFilter: Code[10];
        // ProdGroup: Record "Product Group"; // BC Upgrade BHARDA11 --Functional Query Required
        ProdGroupFilter: Code[10];
        ChannelDim: Code[20];
        ChannelDimFilter: Code[20];
        ItemFilter: Code[20];
        EndingDate: Date;
        StartingDate: Date;
        Stock: Decimal;
        FleCIL1: File;
        Cnt: Integer;
        Week: Integer;
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
        OutStr: OutStream;
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
        // TempILE."Quantity in HL" := p_ItemLedEntry."Quantity in HL"; // BC Upgrade BHARDA11 ----Drink IT Fields
        LedEntryDim.RESET();
        //LedEntryDim.SETRANGE("Table ID",DATABASE::"Item Ledger Entry");
        LedEntryDim.SETRANGE("Dimension Set ID", p_ItemLedEntry."Dimension Set ID");
        LedEntryDim.SETRANGE("Dimension Code", ChannelDim);
        if LedEntryDim.FINDFIRST() then
            TempILE."Global Dimension 1 Code" := LedEntryDim."Dimension Value Code";
        TempILE.INSERT();
    end;
}

