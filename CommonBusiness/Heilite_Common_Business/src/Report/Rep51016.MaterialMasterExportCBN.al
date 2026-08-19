report 51016 "Material Master Export CBN"
{
    // version HEI.01

    // HEI:EDD068:1:1 19/11/14 TECTURA-HKH
    // SOICAD01 migrated from NAV 2013

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

                //Material Number Char (15)
                if STRLEN(Item."No.") > 15 then
                    ERROR(Text009);
                FleRecord := COPYSTR(Item."No.", 1, 15) + Text50000;

                //Material Description Char (60)
                FleRecord += Item.Description + Text50000;

                //Product heirarchy code Char (15)
                FleRecord += '' + Text50000;

                FleRecord += '' + Text50000;
                FleRecord += '' + Text50000;
                FleRecord += '' + Text50000;
                FleRecord += '' + Text50000;

                //unit of measure 1
                FleRecord += 'HL' + Text50000;

                //Conversion factor 1: conversion between unit of measure 2 and base unit of measure (0.0000)
                // BC Upgrade BHARDA11 >> ---- Drink IT Fields
                // if Item."Unit Volume HL" <> 0 then
                //     FleRecord += FORMAT(ROUND(Item."Unit Volume HL", 0.0001)) + Text50000
                // else
                //     FleRecord += FORMAT('') + Text50000;
                // BC Upgrade BHARDA11 <<   ---- Drink IT Fields

                //Base Unit of measure Char (15)
                FleRecord += Item."Base Unit of Measure" + Text50000;

                //Conversion factor 2: conversion between unit of measure 3 and base unit of measure (0.0000)
                if Item."Unit Volume FPL FND" <> 0 then
                    FleRecord += FORMAT(Item."Unit Volume FPL FND") + Text50000
                else
                    FleRecord += FORMAT('') + Text50000;

                //Fixed Value (Unit of measure 3) Char(6)
                FleRecord += 'FPL' + Text50000;

                FleRecord += '' + Text50000;
                FleRecord += '' + Text50000;
                FleRecord += '' + Text50000;

                //Status Code Char(15)
                FleRecord += '' + Text50000;

                //Primary Pack Type Char(15)
                FleRecord += '' + Text50000;

                //Secondary Pack Type (BT) Char(15)
                FleRecord += '' + Text50000;

                //Content primary pack type (B4) Char(15)
                FleRecord += '' + Text50000;

                //Returnable / One way indication (33C) Char(15)
                FleRecord += '' + Text50000;

                //Origin (Procurement Type)(N) Char(15)
                FleRecord += '' + Text50000;

                //Marketing Type (Standard or Promotional Product)(''/E/F/X/STA) Char(15)
                FleRecord += '' + Text50000;

                Cnt += 1;
                // BC Upgrade BHARDA11 >>
                // BC Upgrade BHARDA11: Write to OutStream instead of File.Write
                OutStr.WriteText(FleRecord);
                OutStr.WriteText();
                // BC Upgrade BHARDA11 <<
                // FleCIL1.WRITE(FleRecord); // BC Upgrade BHARDA11
            end;

            trigger OnPreDataItem();
            begin
                Item.SETFILTER("Item Category Code", ItemCategoryFilter);
                if ItemFilter <> '' then
                    Item.SETFILTER("No.", ItemFilter);
                // BC Upgrade BHARDA11 >>
                // BC Upgrade BHARDA11: Removed File.Create and TEXTMODE - using TempBlob initialized in OnPreReport
                // CLEAR(FleCIL1);
                // FromFile := CommonDialogMgt1.ServerTempFileName('txt');
                // FleCIL1.CREATE(FromFile);
                // FleCIL1.TEXTMODE(true);
                // BC Upgrade BHARDA11 <<
            end;
        }
    }

    requestpage
    {

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
                    //     //Filename := CommonDialogMgt1.OpenFileDialog(Text002,Filename,'');
                    //     Filename := CommonDialogMgt1.SaveFileDialog(Text002, Filename, '*.*|*.txt*');
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
            }
        }

        actions
        {
        }
        //BC Upgrade BHARDA11 >>
        trigger OnOpenPage()
        begin
            // BC Upgrade BHARDA11: Auto-generate filename with timestamp
            if Filename = '' then
                Filename := 'MaterialMaster_' + Format(Today, 0, '<Year4><Month,2><Day,2>') + '.txt';
        end;
        //BC Upgrade BHARDA11 <<
    }

    labels
    {
    }

    trigger OnPostReport();
    var
        InStr: InStream; //BC Upgrade BHARDA11
    begin
        // BC Upgrade BHARDA11 >>
        // Replaced FleCIL1.Close and DownloadToFile with DownloadFromStream
        // FleCIL1.CLOSE;
        // CommonDialogMgt1.DownloadToFile(FromFile, Filename);
        if Cnt <> 0 then begin
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, 'Export to File', '', 'Text Files (*.txt)|*.txt', Filename);
            MESSAGE(Text005, Cnt);
        end else begin
            // BC Upgrade BHARDA11: Removed DeleteClientFile - not applicable in BC
            // CommonDialogMgt1.DeleteClientFile(Filename); //BC Upgrade BHARDA11
            MESSAGE(Text008);
        end;
    end;

    trigger OnPreReport();
    begin
        if Filename = '' then
            ERROR(Text001);
        // BC Upgrade BHARDA11 >>
        // Removed file existence check and overwrite confirmation - handled by DownloadFromStream
        // Initialize TempBlob and OutStream instead of File object
        TempBlob.CreateOutStream(OutStr);
        Cnt := 0;
        // if EXISTS(Filename) then
        //     if CONFIRM(Text003, false) then ERASE(Filename);
        // BC Upgrade BHARDA11 <<
    end;

    var
        recItem: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        CommonDialogMgt1: Codeunit "File Management";
        // BC Upgrade BHARDA11 >>
        TempBlob: Codeunit "Temp Blob";
        ItemCategoryFilter: Code[10];
        ItemFilter: Code[20];
        FleCIL1: File;
        Cnt: Integer;
        Text001: Label 'No filename specified';
        Text003: Label 'File already exisits. Overwrite file?';
        Text004: Label 'Period is not valid for this period type';
        Text005: Label 'File created succesfully with %1 lines.';
        Text006: Label 'Budget filter only allowed for Budget Amounts';
        Text008: Label 'Nothing to Create.';
        Text009: Label 'Invalid Product Code. Length should be less than 15 characters.';
        Text50000: Label '";"';
        OutStr: OutStream;
        OutStreamObj: OutStream;
        // BC Upgrade BHARDA11 <<
        Filename: Text[1024];
        FleRecord: Text[1024];
        FromFile: Text[1024];
        Text000: TextConst ENU = 'You can only export Actual amounts and Budgeted amounts.\Please change the option in the Show field.', FRA = 'Vous pouvez uniquement exporter les montants réalisés et budgétés.\Modifiez l''option dans le champ Afficher.';
        Text002: TextConst ENU = 'Export to', FRA = 'Exporter vers';
}

