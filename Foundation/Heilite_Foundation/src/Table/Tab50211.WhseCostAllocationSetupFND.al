table 50211 "Whse. Cost Alloc Setup FND"
{
    // version HEI.05,HEI.08

    // HEI.01 CHG2095415 IBM BULIMC01 01.04.2021# new table created
    // HEI.02 CHG2130188 IBM BULIMC01 13/10/2021 #new field added: "Distribution Type","Shipping Charge No. Filter"
    // HEI.03 CHG2132177 BULIMC01 IBM 29/11/2021 #Own Fleet allocation
    //   #new option ("Own Fleet") added to the field "C2S Name"
    //   #new fields added: "Distance Allocation %", "No. of Drops Allocation %", "Net Weight Allocation %"
    // HEI.04 FDD-HB2761 BULIMC01 IBM 14/02/2022#table name and caption change to 'C2S Mapping SCOA&CC'
    // HEI.05 CHG2132177 BULIMC01 IBM 07/04/2022#change table name back to "Whse. Cost Alloc Setup FND" and keep the caption'C2S Mapping SCOA&CC'
    // HEI.06 IBM CHG2132673 BULIMC01 13/04/2022#Primary key changed to be Entry No. and lenght changed for CCC Dim filter to 100
    // HEI.07 CHG2167931 SISUM01 19/11/2022 #Add to "CS Name" the following options:
    //   #Whse Hand. Costs (Variable) OVE
    //   #Whse Hand. Costs (Variable) Transp. Exp.
    //   #Whse Hand. Costs (Variable) Fixed Exp.
    // HEI.08 CHG2190306 IBM SISUM01 08/02/2023 #Add Export2Excel function

    Caption = 'C2S Mapping SCOA & CC';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(2; "G/L Account Range"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(3; "CCC Dim. Filter"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            //TableRelation = "Dimension Value".Code WHERE ("Dimension Code"=FILTER(CCC));  //BC Upgrade NANDIS03 - blocked as hardcode
            //This property is currently not supported
            //TestTableRelation = false;
            //ValidateTableRelation = false;  //BC Upgrade NANDIS03 - blocked as hardcode
        }
        field(4; "C2S Name"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
            OptionMembers = " ","Warehouse Handling Costs (Variable)","Warehouse Overhead Costs (Fixed)","General Overhead Costs (Fixed)","Delivery To Customers","Own Fleet","Whse Hand. Costs (Variable) OVE","Whse Hand. Costs (Variable) Transp. Exp.","Whse Hand. Costs (Variable) Fixed Exp.";
        }
        field(5; "Allocation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Picking Factor","Net Weight (Kg)";

            trigger OnValidate();
            begin
                //CheckAllocationType;
            end;
        }
        field(6; Name; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Period Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Distribution Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            OptionMembers = Primary,Secondary;
        }
        field(9; "Shipping Charge No. Filter"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            //TableRelation = "Item Charge" where("Item Charge Type" = FILTER(ShippingCost));  // BC NANDIS03 - blocked as dependency on DIT
            //ValidateTableRelation = false;  // BC NANDIS03 - blocked as dependency on DIT

            trigger OnValidate();
            begin
                //HEI.02>>
                if "Allocation Type" <> "Allocation Type"::" " then
                    ERROR(Text002);
                //HEI.02<<
            end;
        }
        field(10; "Distance Allocation %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(11; "No. of Drops Allocation %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(12; "Net Weight Allocation %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "C2S Name", "Distribution Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        WhseCostAllocSetup: Record "Whse. Cost Alloc Setup FND";
        Text001: Label 'Allocation Type for %1 is %2. You are not allowed to change it for %3.';
        Text002: Label 'The Allocation type must be blank. Shipping Charge No. filter must not be used for overheads and handling costs.';

    local procedure CheckAllocationType();
    var
        WhseCostAllocSetup: Record "Whse. Cost Alloc Setup FND";
        Text001: Label 'Allocation Type for %1 cannot be different than %2.';
    begin
        WhseCostAllocSetup.RESET();
        WhseCostAllocSetup.SETCURRENTKEY("C2S Name");
        WhseCostAllocSetup.SETRANGE("C2S Name", Rec."C2S Name");
        WhseCostAllocSetup.SETFILTER("Allocation Type", '<>%1', Rec."Allocation Type");
        if WhseCostAllocSetup.FINDFIRST() then
            ERROR(Text001, Rec."C2S Name", WhseCostAllocSetup."Allocation Type");
    end;

    procedure Export2Excel(ServerFileName: Text; FilePath: Text);
    var
        TmpExcelBuffer: Record "Excel Buffer" temporary;
        lWhsCostAllocSetup: Record "Whse. Cost Alloc Setup FND";
        FileMgt: Codeunit "File Management";
        CCCDim: array[200] of Code[20];
        GLAcc: array[200] of Code[20];
        Window: Dialog;
        CountCCCDimSeparator: Integer;
        Counter: Integer;
        CountGLSeparator: Integer;
        i: Integer;
        j: Integer;
        LenghtCCCDim: Integer;
        LenghtGLAcc: Integer;
        NoOfProgresed: Integer;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        C2SName: Label 'C2S Name';
        CCCDimFilter: Label 'CCC Dim. Filter';
        CCCDimOperator: Label '?';
        DistribType: Label 'Distribution Type';
        ExportMessage: Label 'Excel file is created to %1.';
        GLAccRange: Label 'G/L Account Range';
        GLOperator: Label '*';
        SepValues: Label '|';
        SheetName: Label 'SCOA';
        Txt: Label 'Export records       @1@@@@@@@@@@@';
        ClientFileName: Text;
        DirectoryName: Text;
        CCCDimTxt: Text[250];
        FileName: Text[250];
        GLAccTxt: Text[250];
        TimeProgress: Time;
    begin
        //HEI.08>>
        if GUIALLOWED then begin
            Window.OPEN(Txt);
            NoOfRecords := lWhsCostAllocSetup.COUNT;
            NoOfRecProgress := NoOfRecords div 100;
            Counter := 0;
            NoOfProgresed := 0;
            TimeProgress := TIME;
        end;

        TmpExcelBuffer.RESET();
        TmpExcelBuffer.DELETEALL();

        //header
        TmpExcelBuffer.NewRow();
        TmpExcelBuffer.AddColumn(GLAccRange, false, '', true, false, false, '', TmpExcelBuffer."Cell Type"::Text);
        TmpExcelBuffer.AddColumn(CCCDimFilter, false, '', true, false, false, '', TmpExcelBuffer."Cell Type"::Text);
        TmpExcelBuffer.AddColumn(C2SName, false, '', true, false, false, '', TmpExcelBuffer."Cell Type"::Text);
        TmpExcelBuffer.AddColumn(DistribType, false, '', true, false, false, '', TmpExcelBuffer."Cell Type"::Text);

        //body
        if lWhsCostAllocSetup.FINDFIRST() then
            repeat

                if GUIALLOWED then begin //HEI.07<<
                    Counter += 1;
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        Window.UPDATE(1, ROUND(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := TIME;
                    end;
                end;

                CLEAR(GLAcc);
                CLEAR(CCCDim);
                LenghtGLAcc := STRLEN(lWhsCostAllocSetup."G/L Account Range");
                LenghtCCCDim := STRLEN(lWhsCostAllocSetup."CCC Dim. Filter");
                GLAccTxt := lWhsCostAllocSetup."G/L Account Range";
                CCCDimTxt := lWhsCostAllocSetup."CCC Dim. Filter";
                CountGLSeparator := STRLEN(lWhsCostAllocSetup."G/L Account Range") - STRLEN(DELCHR(lWhsCostAllocSetup."G/L Account Range", '=', SepValues));
                CountCCCDimSeparator := STRLEN(lWhsCostAllocSetup."CCC Dim. Filter") - STRLEN(DELCHR(lWhsCostAllocSetup."CCC Dim. Filter", '=', SepValues));

                for i := 1 to CountGLSeparator + 1 do begin
                    if (i = CountGLSeparator + 1) then
                        GLAcc[i] := DELCHR(GLAccTxt, '=', GLOperator)
                    else begin
                        GLAcc[i] := DELCHR(COPYSTR(GLAccTxt, 1, STRPOS(GLAccTxt, SepValues) - 1), '=', GLOperator);
                        GLAccTxt := COPYSTR(GLAccTxt, STRPOS(GLAccTxt, SepValues) + 1);
                    end;
                end;

                for i := 1 to CountCCCDimSeparator + 1 do begin
                    if (i = CountCCCDimSeparator + 1) then
                        CCCDim[i] := DELCHR(CCCDimTxt, '=', CCCDimOperator)
                    else begin
                        CCCDim[i] := DELCHR(COPYSTR(CCCDimTxt, 1, STRPOS(CCCDimTxt, SepValues) - 1), '=', CCCDimOperator);
                        CCCDimTxt := COPYSTR(CCCDimTxt, STRPOS(CCCDimTxt, SepValues) + 1);
                    end;
                end;

                for i := 1 to CountGLSeparator + 1 do
                    for j := 1 to CountCCCDimSeparator + 1 do begin
                        TmpExcelBuffer.NewRow();
                        TmpExcelBuffer.AddColumn(GLAcc[i], false, '', false, false, false, '', TmpExcelBuffer."Cell Type"::Text);
                        TmpExcelBuffer.AddColumn(CCCDim[j], false, '', false, false, false, '', TmpExcelBuffer."Cell Type"::Text);
                        TmpExcelBuffer.AddColumn(lWhsCostAllocSetup."C2S Name", false, '', false, false, false, '', TmpExcelBuffer."Cell Type"::Text);
                        TmpExcelBuffer.AddColumn(lWhsCostAllocSetup."Distribution Type", false, '', false, false, false, '', TmpExcelBuffer."Cell Type"::Text);
                    end;
            until lWhsCostAllocSetup.NEXT() = 0;

        if GUIALLOWED then
            Window.CLOSE();

        // //create excel
        // TmpExcelBuffer.CreateBook(ServerFileName, 'SCOA');
        // TmpExcelBuffer.WriteSheet('SCOA Mapping', COMPANYNAME, USERID);
        // TmpExcelBuffer.CloseBook;
        // ClientFileName := FileMgt.DownloadTempFile(ServerFileName);
        // DirectoryName := FileMgt.GetDirectoryName(FilePath);
        // FileName := DELCHR(COPYSTR(FilePath, STRLEN(DirectoryName) + 1), '=', '\');
        // FileMgt.MoveAndRenameClientFile(ClientFileName, FileName, DirectoryName);
        // MESSAGE(ExportMessage, FilePath);  // BC Upgrade NANDIS03 - whole block of excel code blocked as standard BC functionality to be used later
        // //HEI.08<<
    end;
}

