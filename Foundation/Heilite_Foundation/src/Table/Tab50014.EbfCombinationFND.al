table 50014 "Ebf Combination FND"
{
    // version HEI.04

    // HEI.01 BPMGAP015 IBM SOICAD01 11.07.2017 EBF Matrix & Movement Type
    //   #new table created
    // HEI.02 CHG2171687 IBM SISUM01 20/03/2023 #change the lenght for fieldid 3 - from 20 to 100
    //   #for FiledId 1 and 3 - change the ValidateTableRelation and TestTableRelation properties from Yes to No
    //   #add function CheckDimValue and CheckGLAccount
    // HEI.03 CHG2171687 IBM SISUM01 19/05/2023 HB3907 EBF Matrix
    //   #test if new version is active
    //   #create new global function CheckNewEBFMatrixIsActive
    // HEI.04 CHG2171687 IBM SISUM01 22/11/2023 HB3907 EBF Matrix
    //   #test if validate dimension value is active
    //   #create new global function CheckValidationDimValueIsActive


    fields
    {
        field(1; "GL Account No."; Code[20])
        {
            Caption = 'G/L Account Range for SCOA L3';
            TableRelation = "G/L Account"."No." where("Account Type" = FILTER(Posting));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                if CheckNewEBFMatrixIsActive() then begin //HEI.03
                    //HEI.02>>
                    FinancialUtils.GetEBFFilterPattern(StartPosNoDigits, FilterOperator);
                    CheckGLAccount("GL Account No.");
                    //HEI.02<<
                end; //HEI.03
            end;
        }
        field(2; "Dimension Code"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(3; "Dimension Value Code"; Code[50])
        {
            Caption = 'Dimension Filter';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                if CheckNewEBFMatrixIsActive() then //HEI.03
                                                    //HEI.02>>
                    CheckDimFilter("GL Account No.", "Dimension Code", "Dimension Value Code");
                //HEI.02<<
            end;
        }
        field(4; "Combination Restriction"; Option)
        {
            OptionMembers = " ","Not Allowed","Allowed with Warn";
        }
    }

    keys
    {
        key(Key1; "GL Account No.", "Dimension Code", "Dimension Value Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if CheckNewEBFMatrixIsActive() then begin //HEI.03
                                                  //HEI.02>>
            FinancialUtils.GetEBFFilterPattern(StartPosNoDigits, FilterOperator);
            if ("Dimension Code" = '') then
                ERROR(Text003);
            CheckGLAccount("GL Account No.");
            CheckDimFilter("GL Account No.", "Dimension Code", "Dimension Value Code");
            //HEI.02<<
            //HEI.03>>
        end else begin
            if (not GLAccount.GET("GL Account No.")) then
                ERROR(Text005);
            if (not DimValue.GET("Dimension Code", "Dimension Value Code")) then
                ERROR(Text006);
        end;
        //HEI.03<<
    end;

    var
        DimValue: Record "Dimension Value";
        GLAccount: Record "G/L Account";
        FinancialUtils: Codeunit "Financial-Utils";
        StartPosNoDigits: array[4] of Integer;
        Text001: Label 'Account range %1 is not allowed to be defined if Financial Statement is not %2';
        Text002: Label 'Dimension Filter %1 already exist for Account %2';
        Text003: Label 'Dimension Code must not be blank';
        Text004: Label 'Dimension code value must have the following pattern: %1';
        Text005: Label 'Account is not found in Chart of Accounts.';
        Text006: Label 'Dimension value is not found';
        FilterOperator: Text;

    local procedure CheckGLAccount(GLAccountNo: Code[20]);
    var
        GLAccount: Record "G/L Account";
        WhseSetup: Record "Warehouse Setup";
        CCCDimOperator: Label '?';
        SepValues: Label '|';
    begin
        //HEI.02>>
        WhseSetup.GET();
        GLAccount.SETFILTER("No.", GLAccountNo);
        GLAccount.SETFILTER("Financial Stmt version FND", WhseSetup."SCOA Financial Statement FND");
        GLAccount.SETFILTER("Account Type", '%1', GLAccount."Account Type"::Posting);
        if GLAccount.ISEMPTY then
            ERROR(Text001, GLAccountNo, WhseSetup."SCOA Financial Statement FND");
        //HEI.02<<
    end;

    local procedure CheckDimFilter(GLAccountNo: Code[20]; DimCode: Code[10]; DimFilter: Code[50]);
    var
        lEBFComb: Record "Ebf Combination FND";
        lEBFCombTmp: Record "Ebf Combination FND" temporary;
        FinancialUtils: Codeunit "Financial-Utils";
        CCCDimValueArr: array[200] of Code[20];
        CCCDimValueTxt: Code[50];
        CountCCCDimSeparator: Integer;
        i: Integer;
        LenghtCCCDim: Integer;
        NoOfRec: Integer;
        StartPosNoDigits: array[4] of Integer;
        CCCDimOperator: Label '?';
        SepValues: Label '|';
        FilterOperator: Text;
    begin
        //HEI.02>>
        FinancialUtils.GetEBFFilterPattern(StartPosNoDigits, FilterOperator);

        LenghtCCCDim := STRLEN(DimFilter);
        CCCDimValueTxt := DimFilter;
        CountCCCDimSeparator := STRLEN(DimFilter) - STRLEN(DELCHR(DimFilter, '=', SepValues));


        for i := 1 to CountCCCDimSeparator + 1 do begin
            if (i = CountCCCDimSeparator + 1) then
                CCCDimValueArr[i] := DELCHR(CCCDimValueTxt, '=', CCCDimOperator)
            else begin
                CCCDimValueArr[i] := DELCHR(COPYSTR(CCCDimValueTxt, 1, STRPOS(CCCDimValueTxt, SepValues) - 1), '=', CCCDimOperator);
                CCCDimValueTxt := COPYSTR(CCCDimValueTxt, STRPOS(CCCDimValueTxt, SepValues) + 1);
            end;
            if STRLEN(CCCDimValueArr[i]) <> StartPosNoDigits[4] then
                ERROR(Text004, '??dddd??');
        end;

        lEBFComb.SETFILTER("GL Account No.", GLAccountNo);
        lEBFComb.SETRANGE("Dimension Code", DimCode);
        lEBFComb.SETFILTER("Dimension Value Code", '<>%1', xRec."Dimension Value Code");
        if lEBFComb.findset(false) then
            repeat
                lEBFCombTmp.INIT();
                lEBFCombTmp.TRANSFERFIELDS(lEBFComb);
                lEBFCombTmp.INSERT();
            until lEBFComb.NEXT() = 0;

        for i := 1 to CountCCCDimSeparator + 1 do begin
            lEBFCombTmp.SETFILTER("GL Account No.", GLAccountNo);
            lEBFCombTmp.SETRANGE("Dimension Code", DimCode);
            lEBFCombTmp.SETFILTER("Dimension Value Code", '*' + CCCDimValueArr[i] + '*');
            if (not lEBFCombTmp.ISEMPTY) then
                ERROR(Text002, '??' + CCCDimValueArr[i] + '??', GLAccountNo);
        end;
        //HEI.02<<
    end;

    procedure CheckNewEBFMatrixIsActive(): Boolean;
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
    begin
        //HEI.03>>
        GeneralOpCoSetup.GET();
        exit(GeneralOpCoSetup."Enable New EBF Matrix Version");
        //HEI.03<<
    end;

    procedure CheckValidationDimValueIsActive(): Boolean;
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
    begin
        //HEI.04>>
        GeneralOpCoSetup.GET();
        exit(GeneralOpCoSetup."Validate Dimension Value (EBF)");
        //HEI.04<<
    end;
}

