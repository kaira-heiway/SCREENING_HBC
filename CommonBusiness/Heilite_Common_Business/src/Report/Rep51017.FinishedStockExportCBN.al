report 51017 "Finished Stock Export CBN"
{
    // version HEI.01

    // HEI:EDD068:1:1 19/11/14 TECTURA-HKH
    // SOICAD01 migrated from NAV 2013
    // 
    // HEI.01 CHG2171815 HB3141 NORRIQ ZOGHLE01 08.12.2022
    //   # Calculate COGS Allocations based on Inventory Setup with Inventory Posting group instead of costing method
    // BC Upgrade BHARDA11 >>
    // Migration from NAV 2018 to Business Central 26
    // Changes:
    // 1. Replaced File object with TempBlob and OutStream for file handling
    // 2. Removed CommonDialogMgt codeunit - replaced with DownloadFromStream
    // 3. Removed server-side file operations (CREATE, WRITE, CLOSE, TEXTMODE)
    // 4. Removed OnAssistEdit trigger (SaveFileDialog not supported in BC)
    // 5. Removed file existence check (handled by DownloadFromStream)
    // 6. Comment Drink IT Fields
    // 7. Add ApplicationArea & UserCategory Property in Actions Fields and Report
    // 8. Add Auto-generate filename with timestamp
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

                Stock := 0;
                Loc.RESET();
                if Loc.findset() then
                    repeat
                    // BC Upgrade BHARDA11 >> ---Drink IT Field "Quantity in HL"
                    // ItemLedEntry.RESET;
                    // ItemLedEntry.SETCURRENTKEY("Item No.", "Entry Type", "Variant Code", "Drop Shipment",
                    //                             "Location Code", "Posting Date");
                    // ItemLedEntry.SETRANGE("Item No.", Item."No.");
                    // ItemLedEntry.SETRANGE("Entry Type", ItemLedEntry."Entry Type"::Output);
                    // ItemLedEntry.SETRANGE("Location Code", Loc.Code);
                    // ItemLedEntry.SETRANGE("Posting Date", StartingDate, EndingDate);
                    // if ItemLedEntry.findset then
                    //     repeat
                    //         LotNoInfo.RESET;
                    //         if LotNoInfo.GET(ItemLedEntry."Item No.", ItemLedEntry."Variant Code", ItemLedEntry."Lot No.") then begin
                    //             if not LotNoInfo.Blocked then
                    //                 Stock += ItemLedEntry."Quantity in HL";
                    //         end;
                    //     until ItemLedEntry.NEXT = 0;
                    // BC Upgrade BHARDA11 >> ---Drink IT Field "Quantity in HL"
                    until Loc.NEXT() = 0;

                Stock := ROUND(Stock, 0.001);
                if Stock <> 0 then begin
                    //Material Number Char (15)
                    if STRLEN(Item."No.") > 15 then
                        ERROR(Text009);
                    FleRecord := COPYSTR(Item."No.", 1, 15) + Text004;

                    //Plant Code Char (4)
                    //IF STRLEN(PhysicalLocGrp.Code) > 4 THEN
                    //ERROR(Text010);
                    FleRecord += COPYSTR(PhysicalLocGrpCode, 1, 4) + Text004;

                    //Week Number Char (6)
                    FleRecord += FORMAT(StartingDate, 0, '<Year4><Week,2>') + Text004;

                    //Stock Char (13)
                    FleRecord += FORMAT(Stock, 0, '<Sign><Integer><Decimals,4>');

                    Cnt += 1;
                    // BC Upgrade BHARDA11 >>
                    // BC Upgrade BHARDA11: Write to OutStream instead of FleCIL1.Write
                    OutStr.WriteText(FleRecord);
                    OutStr.WriteText();
                    // BC Upgrade BHARDA11 <<
                    // FleCIL1.WRITE(FleRecord); // BC Upgrade BHARDA11
                end;
            end;

            trigger OnPreDataItem();
            begin

                Item.SETFILTER("Item Category Code", ItemCategoryFilter);
                if ItemFilter <> '' then
                    Item.SETFILTER("No.", ItemFilter);
                // BC Upgrade BHARDA11 >>
                // BC Upgrade BHARDA11: Removed FleCIL1.Create and TEXTMODE - using TempBlob initialized in OnPreReport
                // FromFile := CommonDialogMgt.ServerTempFileName('txt');
                // FleCIL1.CREATE(FromFile);
                // FleCIL1.TEXTMODE := true;
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

                    //BC Upgrade BHARDA11 >>
                    // BC Upgrade BHARDA11: Removed OnAssistEdit trigger - SaveFileDialog not supported in BC
                    // trigger OnAssistEdit();
                    // begin
                    //     //Filename := CommonDialogMgt.OpenFileDialog(Text002,Filename,'');
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
            //BC Upgrade BHARDA11 >>
            // BC Upgrade BHARDA11: Auto-generate filename with timestamp
            if Filename = '' then
                Filename := 'FinishedStock__' + Format(Today, 0, '<Year4><Month,2><Day,2>') + '.txt';
            //BC Upgrade BHARDA11 <<
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        InStr: InStream; //BC Upgrade BHARDA11
    begin
        // BC Upgrade BHARDA11 >>
        // Replaced FleCIL1.Close and DownloadToFile with DownloadFromStream
        // FleCIL1.CLOSE;
        // CommonDialogMgt.DownloadToFile(FromFile, Filename);

        if Cnt <> 0 then begin
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, 'Export to File', '', 'Text Files (*.txt)|*.txt', Filename);
            MESSAGE(Text005, Cnt);
        end else begin
            // BC Upgrade BHARDA11: Removed DeleteClientFile - not applicable in BC
            // CommonDialogMgt.DeleteClientFile(Filename);  // BC Upgrade BHARDA11
            MESSAGE(Text008);
        end;
    end;

    trigger OnPreReport();
    begin

        if Filename = '' then
            ERROR(Text001);
        // BC Upgrade BHARDA11 >>
        // Removed file existence check and overwrite confirmation - handled by DownloadFromStream
        // if EXISTS(Filename) then
        //     if CONFIRM(Text003, false) then
        //         ERASE(Filename)
        //     else
        //         CurrReport.QUIT;
        // BC Upgrade BHARDA11 <<

        if ItemCategoryFilter = '' then
            ERROR(Text006);

        if Week > 52 then
            ERROR(Text007);

        StartingDate := DWY2DATE(1, Week, Year);
        EndingDate := CALCDATE('<+6D>', StartingDate);
        // BC Upgrade BHARDA11 >>
        TempBlob.CreateOutStream(OutStr);
        Cnt := 0;
        // BC Upgrade BHARDA11 <<
    end;

    var
        recItem: Record Item;
        ItemLedEntry: Record "Item Ledger Entry";
        Loc: Record Location;
        LotNoInfo: Record "Lot No. Information";
        // BC Upgrade BHARDA11 <<
        CommonDialogMgt: Codeunit "File Management";
        // BC Upgrade BHARDA11 >>
        TempBlob: Codeunit "Temp Blob";
        PhysicalLocGrpCode: Code[4];
        ItemCategoryFilter: Code[10];
        PhysicalLocGrpFilter: Code[10];
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
}

