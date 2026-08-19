report 54034 "Mass Update BoM - Versions"
{
    // version HEI.01

    // HEI.01 IBM BULIMC01 23/06/2020 #new report created

    //BC Upgrade GUNREM01 -Old ID 50452 
    //BC Upgrade GUNREM01 - commented DIT field "Production jnl. flushing" and "Location Code". 
    // #Also changed the way of exporting data into excel and uploading file from client to server.
    // #Added progress window during export and import.

    //BC Upgrade Kamnay01 - Added DIT field "Production jnl. flushing" in the report which is added in the table "Production BOM Line".
    //BC Upgrade Kamnay01 - changed in multiple places in the report.
    Caption = 'Mass Update BoM - Versions';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Production BOM Header"; "Production BOM Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Status = CONST(Certified), "Linked Item No. FND" = FILTER(<> ''));

            trigger OnAfterGetRecord();
            begin
                if TransType = TransType::Export then begin
                    if not HeaderPrinted then
                        MakeExcelDataHeader(1);
                    MakeExcelDataBody(1);

                    TempProdBOMHeader.INIT();
                    TempProdBOMHeader.RESET();
                    TempProdBOMHeader."No." := "No.";
                    TempProdBOMHeader.INSERT();

                    Counter += 1;
                    if (Counter >= NoOfRecProgress) then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        Window.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := TIME;
                    end;
                end;
            end;

            /*trigger OnPostDataItem();
            begin
                if TransType = TransType::Export then
                    //   TempExcelBuffer.InsertIntoExcelBook(Text50002, '', COMPANYNAME, USERID, false);
                    //BC Upgrade GUNREM01 - changed the way of inserting data into excel >>
                    TempExcelBuffer.CreateNewBook(Text50000);
                TempExcelBuffer.WriteSheet(Text50000, CompanyName(), UserId());
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.OpenExcel();
                //BC Upgrade GUNREM01 - changed the way of inserting data into excel <<
                //UploadClientFile(ClientFileName,ServerFileName);
            end;*/

            trigger OnPreDataItem();
            begin
                if TransType = TransType::Export then begin
                    if BomNo <> '' then
                        SETFILTER("No.", BomNo);
                    if LocationCode <> '' then
                        SETFILTER("Linked SKU FND", LocationCode);

                    NoOfRecords := COUNT;
                    NoOfRecProgress := NoOfRecords div 100;
                    Counter := 0;
                    NoOfProgresed := 0;
                    TimeProgress := TIME;
                    HeaderPrinted := false;//RD03
                end;
            end;
        }
        dataitem("Production BOM Version"; "Production BOM Version")
        {
            DataItemTableView = SORTING("Production BOM No.", "Version Code") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                if TransType = TransType::Export then begin
                    if not HeaderPrinted then
                        MakeExcelDataHeader(2);

                    CLEAR(TempProdBOMHeader);
                    TempProdBOMHeader.SETRANGE("No.", "Production BOM No.");
                    if TempProdBOMHeader.FINDFIRST() then
                        MakeExcelDataBody(2);

                    Counter2 += 1;
                    if (Counter2 >= NoOfRecProgress2) then begin
                        NoOfProgresed2 := NoOfProgresed2 + Counter2;
                        Window.UPDATE(2, ROUND(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                        Counter2 := 0;
                        TimeProgress2 := TIME;
                    end;
                end;
            end;

            /*trigger OnPostDataItem();
            begin
                if TransType = TransType::Export then
                    //  TempExcelBuffer.InsertIntoExcelBook(Text50001, '', COMPANYNAME, USERID, true);
                    //BC Upgrade GUNREM01 - changed the way of inserting data into excel >>
                    TempExcelBuffer.CreateNewBook(Text50000);
                TempExcelBuffer.WriteSheet(Text50000, CompanyName(), UserId());
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.OpenExcel();
                //BC Upgrade GUNREM01 - changed the way of inserting data into excel <<
            end;*/

            trigger OnPreDataItem();
            begin
                if TransType = TransType::Export then begin
                    if BomNo <> '' then
                        SETFILTER("Production BOM No.", BomNo);

                    NoOfRecords2 := COUNT;
                    NoOfRecProgress2 := NoOfRecords2 div 100;
                    Counter2 := 0;
                    NoOfProgresed2 := 0;
                    TimeProgress2 := TIME;
                    TempExcelBuffer.DELETEALL();
                    HeaderPrinted := false;
                end;
            end;
        }
        dataitem("Production BOM Line"; "Production BOM Line")
        {
            DataItemTableView = SORTING("Production BOM No.", "Version Code", "Line No.") ORDER(Ascending);

            trigger OnAfterGetRecord();
            begin
                if TransType = TransType::Export then begin
                    if not HeaderPrinted then
                        MakeExcelDataHeader(3);

                    CLEAR(TempProdBOMHeader);
                    TempProdBOMHeader.SETRANGE("No.", "Production BOM No.");
                    if TempProdBOMHeader.FINDFIRST() then
                        MakeExcelDataBody(3);
                    Counter3 += 1;
                    if (Counter3 >= NoOfRecProgress3) then begin
                        NoOfProgresed3 := NoOfProgresed3 + Counter3;
                        Window.UPDATE(3, ROUND(NoOfProgresed3 / NoOfRecords3 * 10000, 1));
                        Counter3 := 0;
                        TimeProgress3 := TIME;
                    end;
                end;
            end;

            /*trigger OnPostDataItem();
            begin
                if TransType = TransType::Export then
                    //  TempExcelBuffer.InsertIntoExcelBook(Text50000, '', COMPANYNAME, USERID, true);
                    //BC Upgrade GUNREM01 - changed the way of inserting data into excel >>
               TempExcelBuffer.CreateNewBook(Text50000);
                TempExcelBuffer.WriteSheet(Text50000, CompanyName(), UserId());
                TempExcelBuffer.CloseBook();
                TempExcelBuffer.OpenExcel();
                //BC Upgrade GUNREM01 - changed the way of inserting data into excel <<
                //EXCEL
            end;*/

            trigger OnPreDataItem();
            begin
                if TransType = TransType::Export then begin
                    if BomNo <> '' then
                        SETFILTER("Production BOM No.", BomNo);

                    NoOfRecords3 := COUNT;
                    NoOfRecProgress3 := NoOfRecords3 div 100;
                    Counter3 := 0;
                    NoOfProgresed3 := 0;
                    TimeProgress3 := TIME;
                    TempExcelBuffer.DELETEALL();
                    HeaderPrinted := false;
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
                field(TransType; TransType)
                {
                    Caption = 'Import/Export';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if TransType = TransType::Import then begin
                            ImportOption := true;
                            ExportOption := false;
                        end else begin
                            ImportOption := false;
                            ExportOption := true;
                        end;
                    end;
                }
                field(Control55002; '')
                {
                    ApplicationArea = All;
                }
                field("Import From"; '')
                {
                    Editable = ImportOption;
                    ApplicationArea = All;
                }
                field("WorkBook File Name"; FileName)
                {
                    CaptionML = ENU = 'Workbook File Name',
                                NLD = 'Werkmapbestandsnaam';
                    Editable = ImportOption;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        //BC Upgrade GUNREM01 - changed the way of uploading file from client to server >>
                        // if ImportOption then
                        //     FileName := FileMgt.UploadFile(Text50002, ExcelFileExtensionTok);
                        if ImportOption then
                            UploadIntoStream('Select Excel File', '', ExcelFileExtensionTok, FileName, InStr);


                        //UploadIntoStream(Text50002, '', ExcelFileExtensionTok, FileName, InStr);
                        //TempBlob.CreateOutStream(OutStr);
                        //CopyStream(OutStr, InStr);
                        //BC Upgrade GUNREM01 - changed the way of uploading file from client to server <<
                    end;
                }
                field(Control55007; '')
                {
                    ApplicationArea = All;
                }
                field("Export for:"; '')
                {
                    Caption = 'Export for:';
                    ApplicationArea = All;
                }
                field(BomNo; BomNo)
                {
                    Caption = 'Production BOM No.';
                    Editable = ExportOption;
                    TableRelation = "Production BOM Header"."No." WHERE(Status = CONST(Certified));
                    ApplicationArea = All;
                }
                field(LocationCode; LocationCode)
                {
                    Caption = 'Location Code';
                    Editable = ExportOption;
                    TableRelation = Location.Code;
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            ExportOption := true;
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    var
        ExcelInStream: InStream;
    begin
        if TransType = TransType::Export then begin
            Window.OPEN(Text50008);
            ExportExcel();
            /*TempExcelBuffer.CloseBook;
            TempExcelBuffer.SetFriendlyFilename(GetFileName);
            TempExcelBuffer.OpenExcel;*/
            //  TempExcelBuffer.GiveUserControl; //BC Upgrade GUNREM01 -Removed in BC 

            Window.CLOSE;
        end else begin
            if ImportedVersion = true then begin
                MESSAGE('Import successful!');
                // Window.CLOSE;
            end else
                MESSAGE('No BoM Version No. has been imported!');

        end;
    end;

    trigger OnPreReport();
    var
        BOM_no: Text;
        ProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine: Record "Production BOM Line";
        TempExcelBuffer2: Record "Excel Buffer" temporary;
        IsHeader: Boolean;
    begin
        TempProductionBOMHeaderBuff.DeleteAll();
        TempProductionBOMVersionBuff.DeleteAll();
        TempProductionBOMLineBuff.DeleteAll();
        if TransType = TransType::Export then
            Window.OPEN(Text50003 + Text50004 + Text50005)
        else
            Window.OPEN(Text50005);

        if TransType = TransType::Import then begin


            ReadExcelSheet('Production BOM Version');
            AnalyzeVersionData();


            // UploadIntoStream('Select Excel File', '', ExcelFileExtensionTok, FileName, InStr);


            ReadExcelSheet('Production BOM Line');
            AnalyzeLinesData();

        end;
    end;

    var
        TransType: Option Export,Import;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempProductionBOMHeaderBuff: Record "Excel Buffer" temporary;
        TempProductionBOMVersionBuff: Record "Excel Buffer" temporary;
        TempProductionBOMLineBuff: Record "Excel Buffer" temporary;
        InStr: InStream; //RD03
        TempBlob: Codeunit "Temp Blob";//RD03
        OutStr: OutStream;//RD03
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;//RD03
        FileMgt: Codeunit "File Management";
        ServerFileName: Text;
        ClientFileName: Text;
        SheetName: Text[250];
        Text000: Label 'Analyzing Data...\\';
        Text001: Label 'Filters';
        Text002: Label 'Update Workbook';
        ExcelFileExtensionTok: Label '(*.xlsx)|*.xlsx';
        OverwriteFileQst: Label 'Do you want to overwrite the existing file?';
        RowNo: Integer;
        DateVar: Date;
        IntVar: Integer;
        DecimalVar: Decimal;
        Text50000: Label 'BoM Versions Lines';
        Text50001: Label 'BoM Versions Header';
        FileName: Text;
        Text50002: Label 'BoM Header';
        Text50007: Label 'Import Excel File';
        //   [InDataSet]
        ImportOption: Boolean;
        Text50003: Label 'Exporting to Production BoM Header sheet..  @1@@@@@@@@@@@ \';
        Text50004: Label 'Exporting to BoM Versions Header sheet..  @2@@@@@@@@@@@ \';
        Window: Dialog;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        Text50005: Label 'Exporting to Production BoM Lines sheet..  @3@@@@@@@@@@@ \';
        NoOfRecords2: Integer;
        NoOfRecProgress2: Integer;
        NoOfProgresed2: Integer;
        Counter2: Integer;
        TimeProgress2: Time;
        Text50006: Label '"Opening the excel file.. "';
        HeaderPrinted: Boolean;
        BomNo: Code[20];
        LocationCode: Code[20];
        TempProdBOMHeader: Record "Production BOM Header" temporary;
        NoOfRecords3: Integer;
        NoOfRecProgress3: Integer;
        NoOfProgresed3: Integer;
        Counter3: Integer;
        TimeProgress3: Time;
        NoOfRecords4: Integer;
        NoOfRecProgress4: Integer;
        NoOfProgresed4: Integer;
        Counter4: Integer;
        TimeProgress4: Time;
        Text50008: Label 'Please wait for the excel file to open...';
        Text007: Label 'Analyzing Data...\\';
        Text006: Label 'Import Excel File';
        RecNo: Integer;
        TotalRecNo: Integer;
        Counter1: Integer;
        ImportedVersion: Boolean;
        // [InDataSet]
        ExportOption: Boolean;
        // XlApp: DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.ApplicationClass" RUNONCLIENT;
        // XlWrkBk: DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook" RUNONCLIENT;
        // XlHelper: DotNet "'Microsoft.Dynamics.Nav.Integration.Office, Version=11.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Integration.Office.Excel.ExcelHelper" RUNONCLIENT;
        FileManagement: Codeunit "File Management";
        FileNameClient: Text;
        FileNameServer: Text;
        DateTxt: Text;
        Text50009: Label 'BoM Info Export %1 %2';
        InvalidWindowsChrStringTxt: TextConst ENU = '""#%&*:<>?\/{|}~', FRA = '""#%&*:<>?\/{|}~';
        TimeTxt: Text;

    procedure MakeExcelDataHeader(HeaderFor: Integer);
    begin
        case HeaderFor of
            1:
                begin
                    TempProductionBOMHeaderBuff.NewRow();
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".FIELDCAPTION("No."), false, '', true, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".FIELDCAPTION(Description), false, '', true, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".FIELDCAPTION("Description 2"), false, '', true, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".FIELDCAPTION("Search Name"), false, '', true, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".FIELDCAPTION("Unit of Measure Code"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".FIELDCAPTION(Status), false, '', true, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".FIELDCAPTION("Linked Item No. FND"), false, '', true, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".FIELDCAPTION("Linked SKU FND"), false, '', true, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    HeaderPrinted := true;
                end;
            2:
                begin
                    TempProductionBOMVersionBuff.NewRow();
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version".FIELDCAPTION("Production BOM No."), false, '', true, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version".FIELDCAPTION("Version Code"), false, '', true, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version".FIELDCAPTION(Description), false, '', true, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version".FIELDCAPTION("Unit of Measure Code"), false, '', true, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version".FIELDCAPTION("Starting Date"), false, '', true, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version".FIELDCAPTION(Status), false, '', true, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version".FIELDCAPTION("Active FND"), false, '', true, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    HeaderPrinted := true;
                end;
            3:
                begin
                    TempProductionBOMLineBuff.NewRow();
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Production BOM No."), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Version Code"), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Line No."), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION(Type), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("No."), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION(Description), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Unit of Measure Code"), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Production jnl. flushing FND"), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text); //BC Upgrade Kamnay01 -Added DIT field in table
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Quantity per"), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Scrap %"), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    //  TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Location Code"), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text); //BC Upgrade GUNREM01 -Blocked DIT Field
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Zone Code FND"), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Bin Code FND"), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".FIELDCAPTION("Routing Link Code"), false, '', true, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    HeaderPrinted := true;
                end;
        end;
    end;

    procedure MakeExcelDataBody(BodyFor: Integer);
    begin
        TempExcelBuffer.NewRow;
        case BodyFor of
            1:
                begin
                    TempProductionBOMHeaderBuff.NewRow();
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header"."No.", false, '', false, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".Description, false, '', false, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header"."Description 2", false, '', false, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header"."Search Name", false, '', false, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header"."Unit of Measure Code", false, '', false, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header".Status, false, '', false, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header"."Linked Item No. FND", false, '', false, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                    TempProductionBOMHeaderBuff.AddColumn("Production BOM Header"."Linked SKU FND", false, '', false, false, false, '', TempProductionBOMHeaderBuff."Cell Type"::Text);
                end;
            2:
                begin
                    TempProductionBOMVersionBuff.NewRow();
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version"."Production BOM No.", false, '', false, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version"."Version Code", false, '', false, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version".Description, false, '', false, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version"."Unit of Measure Code", false, '', false, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version"."Starting Date", false, '', false, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version".Status, false, '', false, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                    TempProductionBOMVersionBuff.AddColumn("Production BOM Version"."Active FND", false, '', false, false, false, '', TempProductionBOMVersionBuff."Cell Type"::Text);
                end;
            3:
                begin
                    TempProductionBOMLineBuff.NewRow();
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Production BOM No.", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Version Code", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Line No.", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".Type, false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."No.", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line".Description, false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Unit of Measure Code", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Production jnl. flushing FND", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);//BC Upgrade Kamnay01 -Added DIT field in table
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Quantity per", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn(FORMAT("Production BOM Line"."Scrap %"), false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    //  TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Location Code", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);//BC Upgrade GUNREM01 -Blocked DIT Field
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Zone Code FND", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Bin Code FND", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                    TempProductionBOMLineBuff.AddColumn("Production BOM Line"."Routing Link Code", false, '', false, false, false, '', TempProductionBOMLineBuff."Cell Type"::Text);
                end;
        end;
    end;

    procedure ReadExcelSheet(SheetName: Text)
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();


        TempExcelBuffer.OpenBookStream(InStr, FileName);


        TempExcelBuffer.OpenBookStream(InStr, SheetName);


        TempExcelBuffer.ReadSheet();
    end;


    procedure AnalyzeVersionData();
    var
        HeaderExcelBuffer: Record "Excel Buffer" temporary;
        HeaderRowNo: Integer;
        OldRowNo: Integer;
        ProductionBOMVersion: Record "Production BOM Version";
        PostingDate: Date;
        Amount: Decimal;
        LineNo: Integer;
        ProductionBOMLine: Record "Production BOM Line";
        StartingDate: Date;
        StatusOption: Option New,Certified,"Under Development",Closed;
        BoMNo: Code[20];
        VersionCode: Code[20];
        TypeVersion: Option " ","Item","Production BOM";
        QtyImprted: Decimal;
        Scrap_Var: Decimal;
        Prod_flushing: Boolean;
        StatusImported: Option New,Certified,"Under Development",Closed;
    begin
        HeaderExcelBuffer.DELETEALL;
        Window.OPEN(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);

        TotalRecNo := TempExcelBuffer.COUNT;
        RecNo := 1;
        Counter1 := 0;

        if TempExcelBuffer.FIND('-') then begin
            HeaderExcelBuffer := TempExcelBuffer;


            HeaderRowNo := 1;

            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));

                if (TempExcelBuffer."Row No." > HeaderRowNo) and (HeaderRowNo > 0) then begin
                    if TempExcelBuffer."Row No." <> OldRowNo then begin
                        CLEAR(BoMNo);
                        CLEAR(VersionCode);
                        CLEAR(LineNo);

                        OldRowNo := TempExcelBuffer."Row No.";
                        ProductionBOMVersion.INIT;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 1) then
                            BoMNo := TempExcelBuffer."Cell Value as Text";

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 2) then
                            VersionCode := TempExcelBuffer."Cell Value as Text";

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 6) then
                            EVALUATE(StatusOption, TempExcelBuffer."Cell Value as Text");


                        if not ProductionBOMVersion.GET(BoMNo, VersionCode) and
                           (StatusOption in [StatusOption::New, StatusOption::"Under Development", StatusOption::Certified]) then begin

                            ProductionBOMVersion.VALIDATE("Production BOM No.", BoMNo);
                            ProductionBOMVersion.VALIDATE("Version Code", VersionCode);
                            ProductionBOMVersion.INSERT;

                            ProductionBOMVersion.VALIDATE(Status, StatusOption);

                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 3) then
                                ProductionBOMVersion.VALIDATE(Description, TempExcelBuffer."Cell Value as Text");

                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 4) then
                                ProductionBOMVersion.VALIDATE("Unit of Measure Code", TempExcelBuffer."Cell Value as Text");

                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 5) then begin
                                EVALUATE(StartingDate, TempExcelBuffer."Cell Value as Text");
                                ProductionBOMVersion.VALIDATE("Starting Date", StartingDate);
                            end;

                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 7) then
                                ProductionBOMVersion."Active FND" := false;

                            ImportedVersion := true;
                            ProductionBOMVersion.MODIFY;
                            Counter1 += 1;
                        end;
                    end;
                end;

            until TempExcelBuffer.NEXT = 0;
        end;

        Window.CLOSE;
    end;

    procedure AnalyzeLinesData();
    var
        HeaderExcelBuffer: Record "Excel Buffer" temporary;
        HeaderRowNo: Integer;
        OldRowNo: Integer;
        ProductionBOMVersion: Record "Production BOM Version";
        PostingDate: Date;
        Amount: Decimal;
        LineNo: Integer;
        ProductionBOMLine: Record "Production BOM Line";
        StartingDate: Date;
        StatusOption: Option New,"Under Development",Certified;
        BoMNo: Code[20];
        VersionCode: Code[20];
        TypeVersion: Option " ","Item","Production BOM";
        QtyImprted: Decimal;
        Scrap_Var: Decimal;
        Prod_flushing: Boolean;
    begin
        HeaderExcelBuffer.DELETEALL;
        Window.OPEN(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := TempExcelBuffer.COUNT;
        RecNo := 1;
        Counter1 := 0;

        if TempExcelBuffer.FIND('-') then begin
            HeaderExcelBuffer := TempExcelBuffer;
            HeaderRowNo := RecNo;
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                if (TempExcelBuffer."Row No." > HeaderRowNo) and (HeaderRowNo > 0) then begin
                    if TempExcelBuffer."Row No." <> OldRowNo then begin
                        CLEAR(BoMNo);
                        CLEAR(VersionCode);
                        CLEAR(LineNo);
                        OldRowNo := TempExcelBuffer."Row No.";
                        ProductionBOMLine.INIT;

                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 1) then
                            BoMNo := TempExcelBuffer."Cell Value as Text";
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 2) then
                            VersionCode := TempExcelBuffer."Cell Value as Text";
                        if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 3) then begin
                            EVALUATE(LineNo, TempExcelBuffer."Cell Value as Text");
                            LineNo := LineNo;
                        end;

                        if not ProductionBOMLine.GET(BoMNo, VersionCode, LineNo) then begin
                            ProductionBOMLine.VALIDATE("Production BOM No.", BoMNo);
                            ProductionBOMLine.VALIDATE("Version Code", VersionCode);
                            ProductionBOMLine.VALIDATE("Line No.", LineNo);
                            ProductionBOMLine.INSERT;

                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 4) then begin
                                EVALUATE(TypeVersion, TempExcelBuffer."Cell Value as Text");
                                ProductionBOMLine.VALIDATE(Type, TypeVersion);
                            end;
                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 5) then
                                ProductionBOMLine.VALIDATE("No.", TempExcelBuffer."Cell Value as Text");
                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 6) then
                                ProductionBOMLine.VALIDATE(Description, TempExcelBuffer."Cell Value as Text");
                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 7) then
                                ProductionBOMLine.VALIDATE("Unit of Measure Code", TempExcelBuffer."Cell Value as Text");
                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 8) then begin
                                EVALUATE(Prod_flushing, TempExcelBuffer."Cell Value as Text");
                                ProductionBOMLine.VALIDATE("Production jnl. flushing FND", Prod_flushing); //BC Upgrade Kamnay01 -Added DIT field in table
                            end;
                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 9) then begin
                                EVALUATE(QtyImprted, TempExcelBuffer."Cell Value as Text");
                                ProductionBOMLine.VALIDATE("Quantity per", QtyImprted);
                            end;
                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 10) then begin
                                EVALUATE(Scrap_Var, TempExcelBuffer."Cell Value as Text");
                                ProductionBOMLine.VALIDATE("Scrap %", Scrap_Var);
                            end;
                            // if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 11) then
                            //     ProductionBOMLine.VALIDATE("Location Code", TempExcelBuffer."Cell Value as Text"); //BC Upgrade GUNREM01 -Blocked DIT Field
                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 11) then
                                ProductionBOMLine.VALIDATE("Zone Code FND", TempExcelBuffer."Cell Value as Text");
                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 12) then
                                ProductionBOMLine.VALIDATE("Bin Code FND", TempExcelBuffer."Cell Value as Text");
                            if TempExcelBuffer.GET(TempExcelBuffer."Row No.", 13) then
                                ProductionBOMLine.VALIDATE("Routing Link Code", TempExcelBuffer."Cell Value as Text");
                            ImportedVersion := true;

                            ProductionBOMLine.MODIFY;
                            Counter1 += 1;
                        end;
                    end;
                end;
            until TempExcelBuffer.NEXT = 0;
        end;
        Window.CLOSE;
    end;

    local procedure GetFileName(): Text[250];
    var
        CompanyInformation: Record "Company Information";
        FileName: Text[250];
    begin
        CompanyInformation.GET;
        ClientFileName := 'BoM Info Export ' +
          USERID + ' ' +
          GetFormattedDate(TODAY) + ' ' + GetFormattedTime(TIME);

        exit(DELCHR(ClientFileName, '=', InvalidWindowsChrStringTxt));
    end;

    local procedure GetFormattedDate(ExportDate: Date): Text;
    begin
        if ExportDate <> 0D then
            exit(FORMAT(ExportDate, 10, '<Year4>-<Month,2>-<Day,2>'));
        exit('');
    end;

    local procedure GetFormattedTime(ExportTime: Time): Text;
    begin
        if ExportTime <> 000000T then
            exit(FORMAT(ExportTime, 0, '<Hours12>.<Minutes,2>.<Seconds,2>:<AM/PM>'));
        exit('');
    end;

    local procedure ExportExcel()
    begin
        // Production BOM Header Sheet
        TempExcelBuffer.CreateNewBook('Production BOM Header');

        if TempProductionBOMHeaderBuff.FindSet() then
            repeat
                TempExcelBuffer := TempProductionBOMHeaderBuff;
                TempExcelBuffer.Insert();
            until TempProductionBOMHeaderBuff.Next() = 0;

        TempExcelBuffer.WriteSheet(Text50002, CompanyName, UserId);

        // Production BOM Version Sheet
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.SelectOrAddSheet('Production BOM Version');

        if TempProductionBOMVersionBuff.FindSet() then
            repeat
                TempExcelBuffer := TempProductionBOMVersionBuff;
                TempExcelBuffer.Insert();
            until TempProductionBOMVersionBuff.Next() = 0;

        TempExcelBuffer.WriteSheet(Text50001, CompanyName, UserId);

        // Production BOM Line Sheet
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.SelectOrAddSheet('Production BOM Line');

        if TempProductionBOMLineBuff.FindSet() then
            repeat
                TempExcelBuffer := TempProductionBOMLineBuff;
                TempExcelBuffer.Insert();
            until TempProductionBOMLineBuff.Next() = 0;

        TempExcelBuffer.WriteSheet(Text50000, CompanyName, UserId);

        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Production BOM Export');
        TempExcelBuffer.OpenExcel();
    end;
    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook");
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;Target : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Range");
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;Target : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Range";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;Target : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Range";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant);
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant);
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant);
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;Target : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Range");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";SaveAsUI : Boolean;var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Sh : Variant);
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Wn : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Window");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Wn : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Window");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Wn : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Window");
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;Target : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Hyperlink");
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;Target : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.PivotTable");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Target : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.PivotTable");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Target : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.PivotTable");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";SyncEventType : DotNet "'office, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Core.MsoSyncEventType");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Map : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.XmlMap";Url : Text;IsRefresh : Boolean;var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Map : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.XmlMap";IsRefresh : Boolean;Result : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.XlXmlImportResult");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Map : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.XmlMap";Url : Text;var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Map : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.XmlMap";Url : Text;Result : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.XlXmlExportResult");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Description : Text;Sheet : Text;Success : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp();
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;TargetPivotTable : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.PivotTable";TargetRange : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Range");
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;TargetPivotTable : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.PivotTable";ValueChangeStart : Integer;ValueChangeEnd : Integer;var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;TargetPivotTable : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.PivotTable";ValueChangeStart : Integer;ValueChangeEnd : Integer;var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;TargetPivotTable : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.PivotTable";ValueChangeStart : Integer;ValueChangeEnd : Integer);
    //begin
    /*
    */
    //end;

    //event XlApp(Pvw : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.ProtectedViewWindow");
    //begin
    /*
    */
    //end;

    //event XlApp(Pvw : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.ProtectedViewWindow";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Pvw : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.ProtectedViewWindow";Reason : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.XlProtectedViewCloseReason";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Pvw : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.ProtectedViewWindow");
    //begin
    /*
    */
    //end;

    //event XlApp(Pvw : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.ProtectedViewWindow");
    //begin
    /*
    */
    //end;

    //event XlApp(Pvw : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.ProtectedViewWindow");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Success : Boolean);
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Ch : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Chart");
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant);
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant;Target : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.TableObject");
    //begin
    /*
    */
    //end;

    //event XlApp(Wb : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Workbook";Changes : DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.ModelChanges");
    //begin
    /*
    */
    //end;

    //event XlApp(Sh : Variant);
    //begin
    /*
    */
    //end;
}

