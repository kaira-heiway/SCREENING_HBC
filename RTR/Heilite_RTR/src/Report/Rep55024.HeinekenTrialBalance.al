report 55024 "Heineken Trial Balance"
{
    // version HT350

    // HEI.01 - New report include additional information and filter by 2 dimension
    // HEI.02 FDD-350 BULIMC01 IBM 09/01/2020
    //     #new adjustments

    // BC Upgrade SHUKLP03 >> Nav old id - 50376

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Heineken Trial Balance.rdl';

    Caption = 'Heineken Trial Balance';
    ApplicationArea = ALL;  // BC Upgrade SHUKLP03 <<
    UsageCategory = ReportsAndAnalysis; // BC Upgrade SHUKLP03 <<

    dataset
    {
        dataitem(GLAccount; "G/L Account")
        {
            RequestFilterFields = "No.", "Account Type";
            column(Acc_Desc; GLAccount.Name)
            {
            }
            column(Acc_No; GLAccount."No.")
            {
            }
            column(Financial_Stat; GLAccount."Financial Stmt version FND")
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(Col1; Col01)
            {
            }
            column(Col2; Col02)
            {
            }
            column(Col3; Col03)
            {
            }
            column(Col4; Col04)
            {
            }
            column(Col5; Col05)
            {
            }
            column(Col6; Col06)
            {
            }
            column(Col7; Col07)
            {
            }
            column(Col8; Col08)
            {
            }
            column(Col9; Col09)
            {
            }
            column(Col10; Col10)
            {
            }
            column(Col11; Col11)
            {
            }
            column(Title; Title)
            {
            }
            column(Period; Period)
            {
            }
            column(Range; STRSUBSTNO('%1 - %2', StartDate, EndDate))
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(IncomeBalance_GLAccount; GLAccount."Income/Balance")
            {
                IncludeCaption = true;
            }
            column(CILaccount_GLAccount; GLAccount."CIL account FND")
            {
                IncludeCaption = true;
            }
            column(CIL3Code_GLAccount; GLAccount."CIL3 Code FND")
            {
                IncludeCaption = true;
            }
            column(EndDate; EndDate)
            {
            }
            column(AccountSubcategoryDescript_GLAccount; GLAccount."Account Subcategory Descript.")
            {
                IncludeCaption = true;
            }
            dataitem(Lines; "Integer")
            {
                column(Cost_Centre; TempGLEntry."Global Dimension 1 Code")
                {
                }
                column(Mov_Type; TempGLEntry."Global Dimension 2 Code")
                {
                }
                column(Open_Balance; TempGLEntry.Amount)
                {
                }
                column(MTD; TempGLEntry.Quantity)
                {
                }
                column(Mov_Debit; TempGLEntry."Debit Amount")
                {
                }
                column(Mov_Credit; TempGLEntry."Credit Amount")
                {
                }
                column(Net_Change_YTD; TempGLEntry."Additional-Currency Amount")
                {
                }
                column(Close_Balance; TempGLEntry."Closed by Amount FND")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if Lines.Number = 1 then begin
                        TempGLEntry.SETRANGE("G/L Account No.", GLAccount."No.");
                        if not TempGLEntry.FINDFIRST then CurrReport.SKIP;
                    end else if TempGLEntry.NEXT = 0 then CurrReport.SKIP;
                end;

                trigger OnPreDataItem();
                begin
                    Lines.SETRANGE(Number, 1, TempGLEntry.COUNT);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                ScrGLEntry.RESET;
                ScrGLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
                ScrGLEntry.SETFILTER("G/L Account No.", GLAccount."No.");
                ScrGLEntry.SETRANGE("Posting Date", StartDate, EndDate);
                if ScrGLEntry.FINDFIRST then
                    repeat
                        if ((STRLEN(CCC) = 0) and (STRLEN(MVMT) = 0)) or
                           ((STRLEN(CCC) = 0) and (MVMT = Get_DimValue(ScrGLEntry."Dimension Set ID", 'MVMT'))) or
                           ((STRLEN(MVMT) = 0) and (CCC = Get_DimValue(ScrGLEntry."Dimension Set ID", 'CCC'))) or
                           ((CCC = Get_DimValue(ScrGLEntry."Dimension Set ID", 'CCC')) and (MVMT = Get_DimValue(ScrGLEntry."Dimension Set ID", 'MVMT'))) then
                            Insert_ToTempGLE(ScrGLEntry, TempGLEntry);
                    until ScrGLEntry.NEXT = 0;
                TempGLEntry.RESET;

                //insert opening balance
                //HEI.02<<
                ScrGLEntry2.RESET;
                ScrGLEntry2.SETCURRENTKEY("G/L Account No.", "Posting Date");
                ScrGLEntry2.SETRANGE("G/L Account No.", GLAccount."No.");
                ScrGLEntry2.SETFILTER("Posting Date", STRSUBSTNO('<%1', StartDate));
                if ScrGLEntry2.FINDFIRST then
                    repeat
                        if ((STRLEN(CCC) = 0) and (STRLEN(MVMT) = 0)) or
                           ((STRLEN(CCC) = 0) and (MVMT = Get_DimValue(ScrGLEntry2."Dimension Set ID", 'MVMT'))) or
                           ((STRLEN(MVMT) = 0) and (CCC = Get_DimValue(ScrGLEntry2."Dimension Set ID", 'CCC'))) or
                           ((CCC = Get_DimValue(ScrGLEntry2."Dimension Set ID", 'CCC')) and (MVMT = Get_DimValue(ScrGLEntry2."Dimension Set ID", 'MVMT'))) then
                            InsertOpeningBalance_ToTempGLE(ScrGLEntry2, TempGLEntry);
                    until ScrGLEntry2.NEXT = 0;
                //HEI.02>>
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
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                ESM = 'Opciones',
                                ENC = 'Options';
                    field(StartDate; StartDate)
                    {
                        CaptionML = ENU = 'Start Date',
                                    ESM = 'Fecha Inicial',
                                    ENC = 'Start Date';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            if EndDate <> 0D then
                                if StartDate > EndDate then ERROR(Err_Date);
                        end;
                    }
                    field(EndDate; EndDate)
                    {
                        CaptionML = ENU = 'End Date',
                                    ESM = 'Fecha Final',
                                    ENC = 'End Date';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            if StartDate <> 0D then
                                if StartDate > EndDate then ERROR(Err_Date);
                        end;
                    }
                    field(MVMT; MVMT)
                    {
                        CaptionML = ENU = 'Movement Type',
                                    ESM = 'Tipo Movimiento',
                                    ENC = 'Movement Type';
                        TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('MVMT'));
                        ApplicationArea = All;
                    }
                    field(CCC; CCC)
                    {
                        CaptionML = ENU = 'Cost Center',
                                    ESM = 'Centro de Costo',
                                    ENC = 'Cost Center';
                        TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CCC'));
                        ApplicationArea = All;
                    }
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

    trigger OnPreReport();
    begin
        CompanyInformation.GET;
    end;

    var
        StartDate: Date;
        EndDate: Date;
        MVMT: Code[20];
        CCC: Code[20];
        TempGLEntry: Record "G/L Entry" temporary;
        ScrGLEntry: Record "G/L Entry";
        DimensionSetIds: Text;
        Col01: TextConst ENU = 'SCOA', ESM = 'SCOA', ENC = 'SCOA';
        Col02: TextConst ENU = 'Description', ESM = 'Descripción', ENC = 'Description';
        Col03: TextConst ENU = 'Cost Centre', ESM = 'Centro Costo', ENC = 'Cost Centre';
        Col04: TextConst ENU = 'Movement Type', ESM = 'Tipo Movimiento', ENC = 'Movement Type';
        Col05: TextConst ENU = 'Opening Balance', ESM = 'Saldo Inicial', ENC = 'Opening Balance';
        Col06: TextConst ENU = 'MTD', ESM = 'MTD', ENC = 'MTD';
        Col07: TextConst ENU = 'Movement Debit', ESM = 'Movimiento Deber', ENC = 'Movement Debit';
        Col08: TextConst ENU = 'Movement Credit', ESM = 'Movimiento Haber', ENC = 'Movement Credit';
        Col09: TextConst ENU = 'Net Change = YTD', ESM = 'Saldo = YTD', ENC = 'Net Change = YTD';
        Col10: TextConst ENU = 'Closed Balance', ESM = 'Saldo Final', ENC = 'Closed Balance';
        Col11: TextConst ENU = 'Financial Statement Version', ESM = 'Versión Declaración Financiera', ENC = 'Financial Statement Version';
        Title: TextConst ENU = 'Trial Balance', ESM = 'Balance General', ENC = 'Trial Balance';
        Period: TextConst ENU = 'Period', ESM = 'Periodo', ENC = 'Period';
        Err_Date: TextConst ENU = 'End date must to be bigger than start date', ESM = 'Fecha inicial no puede mayor a fecha final', ENC = 'End date must to be bigger than start date';
        ScrGLEntry2: Record "G/L Entry";
        CompanyInformation: Record "Company Information";

    local procedure Get_DimensionSetIds(Dim_MVMT: Code[20]; Dim_CCC: Code[20]) DimSetIds: Text;
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimSetEntrt2: Record "Dimension Set Entry";
        SetIDs: Text;
    begin
        //Any
        if (STRLEN(Dim_MVMT) = 0) and (STRLEN(Dim_CCC) = 0) then exit('');

        //Both dimensions
        if (STRLEN(Dim_MVMT) <> 0) and (STRLEN(Dim_CCC) <> 0) then begin
            DimSetEntry.RESET;
            DimSetEntry.SETRANGE("Dimension Code", 'MVMT');
            DimSetEntry.SETFILTER("Dimension Value Code", Dim_MVMT);
            if DimSetEntry.FINDFIRST then
                repeat
                    if DimSetEntrt2.GET(DimSetEntry."Dimension Set ID", 'CCC') then
                        if DimSetEntrt2."Dimension Value Code" = Dim_CCC then begin
                            if STRLEN(SetIDs) = 0 then
                                SetIDs := FORMAT(DimSetEntry."Dimension Set ID")
                            else
                                SetIDs := SetIDs + '|' + FORMAT(DimSetEntry."Dimension Set ID");
                        end;
                until DimSetEntry.NEXT = 0;
            exit(SetIDs);
        end;

        //Just one dimension
        DimSetEntry.RESET;
        if STRLEN(Dim_MVMT) <> 0 then begin
            DimSetEntry.SETRANGE("Dimension Code", 'MVMT');
            DimSetEntry.SETFILTER("Dimension Value Code", Dim_MVMT);
        end;
        if STRLEN(Dim_CCC) <> 0 then begin
            DimSetEntry.SETRANGE("Dimension Code", 'CCC');
            DimSetEntry.SETFILTER("Dimension Value Code", Dim_CCC);
        end;

        if DimSetEntry.FINDFIRST then
            repeat
                if STRLEN(SetIDs) = 0 then
                    SetIDs := FORMAT(DimSetEntry."Dimension Set ID")
                else
                    SetIDs := SetIDs + '|' + FORMAT(DimSetEntry."Dimension Set ID");
            until DimSetEntry.NEXT = 0;
        exit(SetIDs);
    end;

    local procedure Insert_ToTempGLE(SrcGLE: Record "G/L Entry"; var TempGLE: Record "G/L Entry" temporary);
    var
        EntryNo: Integer;
    begin
        TempGLE.RESET;
        TempGLE.SETRANGE("G/L Account No.", SrcGLE."G/L Account No.");

        if TempGLE.FINDFIRST then begin
            //IF "G/L pGLE.Quantity := TempGLE.Quantity + SrcGLE.Amount;
            //IF TempGLE."Dimension Set ID" <> ScrGLEntry."Dimension Set ID" THEN BEGIN
            //TempGLE.Amount := TempGLE.Amount + Get_Balance(SrcGLE."G/L Account No.",STRSUBSTNO('<%1',StartDate),SrcGLE."Dimension Set ID",0,Get_DimValue(SrcGLE."Dimension Set ID",'CCC'),Get_DimValue(SrcGLE."Dimension Set ID",'MVMT'));
            //END;
            TempGLE.MODIFY;
        end else begin
            EntryNo := GetNextEntryNo_TempGLE(TempGLE);
            TempGLE.INIT;
            TempGLE.TRANSFERFIELDS(SrcGLE);
            CLEAR(TempGLE."Global Dimension 1 Code"); //HEI.02
            CLEAR(TempGLE."Global Dimension 2 Code"); //HEi.02
            TempGLE."Entry No." := EntryNo;
            if CCC <> '' then //hei.02
                TempGLE."Global Dimension 1 Code" := Get_DimValue(SrcGLE."Dimension Set ID", 'CCC');
            if MVMT <> '' then //HEI.02
                TempGLE."Global Dimension 2 Code" := Get_DimValue(SrcGLE."Dimension Set ID", 'MVMT');
            TempGLE.Amount := Get_Balance(SrcGLE."G/L Account No.", STRSUBSTNO('<%1', StartDate), SrcGLE."Dimension Set ID", 0, Get_DimValue(SrcGLE."Dimension Set ID", 'CCC'), Get_DimValue(SrcGLE."Dimension Set ID", 'MVMT'));
            //HEI.02<<
            //TempGLE.Quantity                     := ScrGLEntry.Amount; HEI.02
            //debit amount calculated for net change YTD
            TempGLE."Remaining Amount FND" := Get_Balance(SrcGLE."G/L Account No.", STRSUBSTNO('%1..%2', Get_StartYear(StartDate), EndDate), SrcGLE."Dimension Set ID", 1, Get_DimValue(SrcGLE."Dimension Set ID", 'CCC'), //commented HEI.02
                                                                Get_DimValue(SrcGLE."Dimension Set ID", 'MVMT'));
            //debit amount calculated for MTD
            TempGLE."Debit Amount" := Get_Balance(SrcGLE."G/L Account No.", STRSUBSTNO('%1..%2', StartDate, EndDate), SrcGLE."Dimension Set ID", 1, Get_DimValue(SrcGLE."Dimension Set ID", 'CCC'),  //HEI.02
                                                                Get_DimValue(SrcGLE."Dimension Set ID", 'MVMT'));
            //credit amount calculated for net change YTD
            TempGLE."VAT Amount" := Get_Balance(SrcGLE."G/L Account No.", STRSUBSTNO('%1..%2', Get_StartYear(StartDate), EndDate), SrcGLE."Dimension Set ID", 2, Get_DimValue(SrcGLE."Dimension Set ID", 'CCC'), //commented HEI.02
                                                               Get_DimValue(SrcGLE."Dimension Set ID", 'MVMT'));
            // credit amount calculated for MTD
            TempGLE."Credit Amount" := Get_Balance(SrcGLE."G/L Account No.", STRSUBSTNO('%1..%2', StartDate, EndDate), SrcGLE."Dimension Set ID", 2, Get_DimValue(SrcGLE."Dimension Set ID", 'CCC'),  //HEI.02
                                                                Get_DimValue(SrcGLE."Dimension Set ID", 'MVMT'));
            // TempGLE."Additional-Currency Amount" := TempGLE."Debit Amount" - TempGLE."Credit Amount"; //Net Change YTD
            TempGLE."Additional-Currency Amount" := TempGLE."Remaining Amount FND" - TempGLE."VAT Amount";//net change ytd
            TempGLE.Quantity := TempGLE."Debit Amount" - TempGLE."Credit Amount"; //MTD
            TempGLE."Closed by Amount FND" := TempGLE.Amount + TempGLE."Debit Amount" - TempGLE."Credit Amount"; //closed balance
                                                                                                             //HEI.02>>
            TempGLE.INSERT;
        end;
    end;

    local procedure GetNextEntryNo_TempGLE(var TempGLE: Record "G/L Entry" temporary) EntryNo: Integer;
    begin
        TempGLE.RESET;
        if TempGLE.FINDLAST then exit(TempGLE."Entry No." + 1);
        exit(1);
    end;

    local procedure Get_DimValue(DimSetId: Integer; DimenCode: Code[20]) DimValue: Code[20];
    var
        DimSetEntry: Record "Dimension Set Entry";
    begin
        if DimSetEntry.GET(DimSetId, DimenCode) then exit(DimSetEntry."Dimension Value Code");
        exit('');
    end;

    local procedure Get_Balance(AccountNo: Code[20]; AtDate: Text; DimSetId: Integer; Type: Option balance,debit,credit; CCC_: Code[20]; MVMT_: Code[20]) Balance: Decimal;
    var
        GLE: Record "G/L Entry";
        Bal: Decimal;
    begin
        GLE.RESET;
        GLE.SETCURRENTKEY("G/L Account No.", "Posting Date");
        GLE.SETRANGE("G/L Account No.", AccountNo);
        GLE.SETFILTER("Posting Date", AtDate);
        if GLE.FINDFIRST then
            repeat
                case Type of
                    0:
                        begin
                            //HEI.02<<
                            if (MVMT = '') and (CCC = '') then
                                Bal := Bal + GLE.Amount
                            else if (MVMT <> '') and (CCC = '') then
                                if MVMT_ = Get_DimValue(GLE."Dimension Set ID", 'MVMT') then
                                    Bal := Bal + GLE.Amount;
                            if (CCC <> '') and (MVMT = '') then
                                if CCC_ = Get_DimValue(GLE."Dimension Set ID", 'CCC') then
                                    Bal := Bal + GLE.Amount
                                else if (MVMT <> '') and (CCC <> '') then
                                    if (CCC_ = Get_DimValue(GLE."Dimension Set ID", 'CCC')) and (MVMT_ = Get_DimValue(GLE."Dimension Set ID", 'MVMT')) then
                                        Bal := Bal + GLE.Amount;

                            //HEI.02>>
                        end;
                    1:
                        begin
                            //HEI.02<<
                            if (MVMT = '') and (CCC = '') then
                                Bal := Bal + GLE."Debit Amount"
                            else if (MVMT <> '') and (CCC = '') then
                                if MVMT_ = Get_DimValue(GLE."Dimension Set ID", 'MVMT') then
                                    Bal := Bal + GLE."Debit Amount";
                            if (CCC <> '') and (MVMT = '') then
                                if CCC_ = Get_DimValue(GLE."Dimension Set ID", 'CCC') then
                                    Bal := Bal + GLE."Debit Amount"
                                else if (MVMT <> '') and (CCC <> '') then
                                    if (CCC_ = Get_DimValue(GLE."Dimension Set ID", 'CCC')) and (MVMT_ = Get_DimValue(GLE."Dimension Set ID", 'MVMT')) then
                                        Bal := Bal + GLE."Debit Amount";
                            //HEI.02<<
                        end;
                    2:
                        begin
                            //HEI.02<<
                            if (MVMT = '') and (CCC = '') then
                                Bal := Bal + GLE."Credit Amount"
                            else if (MVMT <> '') and (CCC = '') then
                                if MVMT_ = Get_DimValue(GLE."Dimension Set ID", 'MVMT') then
                                    Bal := Bal + GLE."Credit Amount";
                            if (CCC <> '') and (MVMT = '') then
                                if CCC_ = Get_DimValue(GLE."Dimension Set ID", 'CCC') then
                                    Bal := Bal + GLE."Credit Amount"
                                else if (MVMT <> '') and (CCC <> '') then
                                    if (CCC_ = Get_DimValue(GLE."Dimension Set ID", 'CCC')) and (MVMT_ = Get_DimValue(GLE."Dimension Set ID", 'MVMT')) then
                                        Bal := Bal + GLE."Credit Amount";
                            //HEI.02<<
                        end;
                end;
            until GLE.NEXT = 0;
        exit(Bal);
    end;

    local procedure Get_StartYear(RefDate: Date) StartYear: Date;
    var
        YY: Integer;
        NewDate: Date;
    begin
        YY := DATE2DMY(RefDate, 3);
        NewDate := DMY2DATE(1, 1, YY);
        exit(NewDate);
    end;

    local procedure InsertOpeningBalance_ToTempGLE(SrcGLE: Record "G/L Entry"; var TempGLE: Record "G/L Entry" temporary);
    var
        EntryNo: Integer;
    begin
        //HEI.02<<
        TempGLE.RESET;
        TempGLE.SETRANGE("G/L Account No.", SrcGLE."G/L Account No.");
        SrcGLE.RESET;

        if TempGLE.FINDFIRST then begin
            //TempGLE.Quantity := TempGLE.Quantity + SrcGLE.Amount;
            //IF TempGLE."Dimension Set ID" <> ScrGLEntry."Dimension Set ID" THEN BEGIN
            //TempGLE.Amount := TempGLE.Amount + Get_Balance(SrcGLE."G/L Account No.",STRSUBSTNO('<%1',StartDate),SrcGLE."Dimension Set ID",0,Get_DimValue(SrcGLE."Dimension Set ID",'CCC'),Get_DimValue(SrcGLE."Dimension Set ID",'MVMT'));
            //END;
            TempGLE.MODIFY;
        end else begin
            EntryNo := GetNextEntryNo_TempGLE(TempGLE);
            TempGLE.INIT;
            TempGLE.TRANSFERFIELDS(SrcGLE);
            CLEAR(TempGLE."Global Dimension 1 Code");
            CLEAR(TempGLE."Global Dimension 2 Code");
            CLEAR(TempGLE."Debit Amount");
            CLEAR(TempGLE."Credit Amount");
            CLEAR(TempGLE.Quantity);
            CLEAR(TempGLEntry."Remaining Amount FND");
            CLEAR(TempGLEntry."VAT Amount");
            CLEAR(TempGLE."Additional-Currency Amount");
            TempGLE."Entry No." := EntryNo;
            if CCC <> '' then //hei.02
                TempGLE."Global Dimension 1 Code" := Get_DimValue(SrcGLE."Dimension Set ID", 'CCC');
            if MVMT <> '' then //HEI.02
                TempGLE."Global Dimension 2 Code" := Get_DimValue(SrcGLE."Dimension Set ID", 'MVMT');
            TempGLE.Amount := Get_Balance(SrcGLE."G/L Account No.", STRSUBSTNO('<%1', StartDate), SrcGLE."Dimension Set ID", 0, Get_DimValue(SrcGLE."Dimension Set ID", 'CCC'), Get_DimValue(SrcGLE."Dimension Set ID", 'MVMT'));

            TempGLEntry."Closed by Amount FND" := TempGLE.Amount + TempGLE."Debit Amount" - TempGLE."Credit Amount"; //closed balance
            TempGLE.INSERT;
        end;
        //HEi.02>>
    end;
}

