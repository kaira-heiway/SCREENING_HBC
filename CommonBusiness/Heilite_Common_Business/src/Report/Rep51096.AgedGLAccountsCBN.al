report 51096 "Aged G/L Accounts CBN"
{
    //BC Upgrade GUNREM01 Old ID-50410

    // HEI.01 FDD-HT1147 IBM SURYAS01
    //   #Created New Report
    // HEI.02 Defect 5626 IBM BULIMC01 04/08/2020
    //   #new range added: G/L Entry 8 and added new code
    //   #new adjustments on the report

    //BC upgrade GUNREM01 - Created New fucntion "GetRecordFiltersWithCaptions" Cashmanagement codeunit was removed.
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Aged GL Accounts.rdl';

    CaptionML = ENU = 'Aged G/L Accounts',
                FRA = 'Comptabilité G/L âgée';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(GLAccoutnNo; "G/L Account"."No.")
            {
            }
            column(GLName; "G/L Account".Name)
            {
            }
            column(GLNoCaption; FIELDCAPTION("No."))
            {
            }
            column(GLNameCaption; FIELDCAPTION(Name))
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(DocumentNoCaption; DocumentNoCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DocumentTypeCaption; DocumentTypeCaptionLbl)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(AgedAcctPayableCaption; AgedAcctPayableCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(AgesAsOfEndingDate; STRSUBSTNO(Text006, FORMAT(AgedDate, 0, 4)))
            {
            }
            column(SelectAgeByDuePostngDocDt; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(AgingBy; AgingBy)
            {
            }
            column(NewPagePerGL; "NewPagePerG/L")
            {
            }
            column(CaptionGLFilter; TABLECAPTION + ': ' + GLFilter)
            {
            }
            column(SelctAgeByDuePostngDocDt1; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(AgingDate1; AgingDate[1])
            {
            }
            column(AgingDate2; AgingDate[2])
            {
            }
            column(AgingDate3; AgingDate[3])
            {
            }
            column(AgingDate4; AgingDate[4])
            {
            }
            column(AgingDate5; AgingDate[5])
            {
            }
            column(AgingDate6; AgingDate[6])
            {
            }
            column(AgingDate7; AgingDate[7])
            {
            }
            column(AgingDate8; AgingDate[8])
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.") WHERE("Remaining Amount FND" = FILTER(<> 0));
                column(OneMonthAmt; OneMonthAmt)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    OneMonthAmt := "G/L Entry"."Remaining Amount FND";
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02 commented begin<<
                    /*ConvertStartDate := '';
                    Var_StartDate1 :=0D;
                    Rec_AgingSetup.RESET;
                    Rec_AgingSetup.SETRANGE("No.",10000);
                    IF Rec_AgingSetup.FINDFIRST THEN BEGIN
                      ConvertStartDate := '-'+FORMAT(Rec_AgingSetup."Ending Date");
                      Var_StartDate1 :=CALCDATE(ConvertStartDate,EndingDate);
                    END; */
                    //HEI.02 commented end>>

                    //HEI.02<<
                    if AgingBy = AgingBy::"Document Date" then
                        "G/L Entry".SETRANGE("Document Date", StartingDate[1], EndingDate[1])
                    else if AgingBy = AgingBy::"Posting Date" then
                        "G/L Entry".SETRANGE("Posting Date", StartingDate[1], EndingDate[1]);
                    //HEI.02>>

                    OneMonthAmt := 0;

                end;
            }
            dataitem(GLEntry2; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.") WHERE("Remaining Amount FND" = FILTER(<> 0));
                column(twoMonthAmt; TwoMonthAmt)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    TwoMonthAmt := GLEntry2."Remaining Amount FND";
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02 commented begin<<
                    /*ConvertStartDate2 := '';
                    ConvertEndDate2 := '';
                    Var_StartDate2 := 0D;
                    Var_EndDate2 := 0D;
                    Rec_AgingSetup.RESET;
                    Rec_AgingSetup.SETRANGE("No.",20000);
                    IF Rec_AgingSetup.FINDFIRST THEN BEGIN
                      ConvertStartDate2 := '-'+FORMAT(Rec_AgingSetup."Ending Date");
                      ConvertEndDate2 := '-'+FORMAT(Rec_AgingSetup."Starting Date");
                      Var_StartDate2 :=CALCDATE(ConvertStartDate2,EndingDate);
                      Var_EndDate2 :=CALCDATE(ConvertEndDate2 ,EndingDate);
                    END;
                    
                    IF AgingBy = AgingBy::"Document Date" THEN
                      GLEntry2.SETRANGE("Document Date",Var_StartDate2,Var_EndDate2)
                    ELSE IF AgingBy = AgingBy::"Posting Date" THEN
                      GLEntry2.SETRANGE("Posting Date",Var_StartDate2,Var_EndDate2);*/
                    //HEI.02 commented end>>

                    //HEI.02<<
                    if AgingBy = AgingBy::"Document Date" then
                        GLEntry2.SETRANGE("Document Date", StartingDate[2], EndingDate[2])
                    else if AgingBy = AgingBy::"Posting Date" then
                        GLEntry2.SETRANGE("Posting Date", StartingDate[2], EndingDate[2]);
                    //HEI.02>>

                    TwoMonthAmt := 0;

                end;
            }
            dataitem("G/L Entry3"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");
                column(threeMonthAmt; threeMonthAmt)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    threeMonthAmt := "G/L Entry3"."Remaining Amount FND";
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02 commented begin<<
                    /*ConvertStartDate3 := '';
                    ConvertEndDate3 := '';
                    Var_StartDate3 := 0D;
                    Var_EndDate3 := 0D;
                    Rec_AgingSetup.RESET;
                    Rec_AgingSetup.SETRANGE("No.",30000);
                    IF Rec_AgingSetup.FINDFIRST THEN BEGIN
                      ConvertStartDate3 := '-'+FORMAT(Rec_AgingSetup."Ending Date");
                      ConvertEndDate3 := '-'+FORMAT(Rec_AgingSetup."Starting Date");
                      Var_StartDate3 :=CALCDATE(ConvertStartDate3,EndingDate);
                      Var_EndDate3 :=CALCDATE(ConvertEndDate3,EndingDate);
                    END;
                    IF AgingBy = AgingBy::"Document Date" THEN
                      "G/L Entry3".SETRANGE("Document Date",Var_StartDate3,Var_EndDate3)
                    ELSE IF AgingBy = AgingBy::"Posting Date" THEN
                      "G/L Entry3".SETRANGE("Posting Date",Var_StartDate3,Var_EndDate3); */
                    //HEI.02 commented end>>

                    //HEI.02<<
                    if AgingBy = AgingBy::"Document Date" then
                        "G/L Entry3".SETRANGE("Document Date", StartingDate[3], EndingDate[3])
                    else if AgingBy = AgingBy::"Posting Date" then
                        "G/L Entry3".SETRANGE("Posting Date", StartingDate[3], EndingDate[3]);
                    //HEI.02>>
                    threeMonthAmt := 0;

                end;
            }
            dataitem("G/L Entry4"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");
                column(fourMonthAmt; fourMonthAmt)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    fourMonthAmt := "G/L Entry4"."Remaining Amount FND";
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02 commented begin<<
                    /*Var_StartDate4 := 0D;
                    Var_EndDate4 := 0D;
                    ConvertStartDate4 := '';
                    ConvertEndDate4 := '';
                    Rec_AgingSetup.RESET;
                    Rec_AgingSetup.SETRANGE("No.",40000);
                    IF Rec_AgingSetup.FINDFIRST THEN BEGIN
                      ConvertStartDate4 := '-'+FORMAT(Rec_AgingSetup."Ending Date");
                      ConvertEndDate4 := '-'+FORMAT(Rec_AgingSetup."Starting Date");
                      Var_StartDate4 :=CALCDATE(ConvertStartDate4,EndingDate);
                      Var_EndDate4 :=CALCDATE(ConvertEndDate4,EndingDate);
                    
                    END;
                    IF AgingBy = AgingBy::"Document Date" THEN
                      "G/L Entry4".SETRANGE("Document Date",Var_StartDate4,Var_EndDate4)
                    ELSE IF AgingBy = AgingBy::"Posting Date" THEN
                      "G/L Entry4".SETRANGE("Posting Date",Var_StartDate4,Var_EndDate4);*/
                    //HEI.02 commented end>>

                    //HEI.02<<
                    if AgingBy = AgingBy::"Document Date" then
                        "G/L Entry4".SETRANGE("Document Date", StartingDate[4], EndingDate[4])
                    else if AgingBy = AgingBy::"Posting Date" then
                        "G/L Entry4".SETRANGE("Posting Date", StartingDate[4], EndingDate[4]);
                    //HEI.02>>

                    fourMonthAmt := 0;

                end;
            }
            dataitem("G/L Entry5"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");
                column(fiveMonthAmt; fiveMonthAmt)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    fiveMonthAmt := "G/L Entry5"."Remaining Amount FND";
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02 commented begin<<
                    /*ConvertStartDate5 := '';
                    ConvertEndDate5 := '';
                    Var_StartDate5 := 0D;
                    Var_EndDate5 := 0D;
                    Rec_AgingSetup.RESET;
                    Rec_AgingSetup.SETRANGE("No.",50000);
                    IF Rec_AgingSetup.FINDFIRST THEN BEGIN
                      ConvertStartDate5 := '-'+FORMAT(Rec_AgingSetup."Ending Date");
                      ConvertEndDate5 := '-'+FORMAT(Rec_AgingSetup."Starting Date");
                      Var_StartDate5 :=CALCDATE(ConvertStartDate5,EndingDate);
                      Var_EndDate5 :=CALCDATE(ConvertEndDate5,EndingDate);
                    END;
                    IF AgingBy = AgingBy::"Document Date" THEN
                      "G/L Entry5".SETRANGE("Document Date",Var_StartDate5,Var_EndDate5)
                    ELSE IF AgingBy = AgingBy::"Posting Date" THEN
                      "G/L Entry5".SETRANGE("Posting Date",Var_StartDate5,Var_EndDate5); */
                    //HEI.02 commented end>>

                    //HEI.02<<
                    if AgingBy = AgingBy::"Document Date" then
                        "G/L Entry5".SETRANGE("Document Date", StartingDate[5], EndingDate[5])
                    else if AgingBy = AgingBy::"Posting Date" then
                        "G/L Entry5".SETRANGE("Posting Date", StartingDate[5], EndingDate[5]);
                    //HEI.02>>
                    fiveMonthAmt := 0;

                end;
            }
            dataitem("G/L Entry6"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");
                column(sixMonthAmt; sixMonthAmt)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    sixMonthAmt := "G/L Entry6"."Remaining Amount FND";
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02 commented begin<<
                    /*Var_StartDate6 := 0D;
                    Var_EndDate6 := 0D;
                    ConvertStartDate6 := '';
                    ConvertEndDate6 := '';
                    Rec_AgingSetup.RESET;
                    Rec_AgingSetup.SETRANGE("No.",60000);
                    IF Rec_AgingSetup.FINDFIRST THEN BEGIN
                      ConvertStartDate6 := '-'+FORMAT(Rec_AgingSetup."Ending Date");
                      ConvertEndDate6 := '-'+FORMAT(Rec_AgingSetup."Starting Date");
                      Var_StartDate6 :=CALCDATE(ConvertStartDate6,EndingDate);
                      Var_EndDate6 :=CALCDATE(ConvertEndDate6,EndingDate);
                    END;
                    IF AgingBy = AgingBy::"Document Date" THEN
                      "G/L Entry6".SETRANGE("Document Date",Var_StartDate6,Var_EndDate6)
                    ELSE IF AgingBy = AgingBy::"Posting Date" THEN
                      "G/L Entry6".SETRANGE("Posting Date",Var_StartDate6,Var_EndDate6); */
                    //HEI.02 commented end>>

                    //HEI.02<<
                    if AgingBy = AgingBy::"Document Date" then
                        "G/L Entry6".SETRANGE("Document Date", StartingDate[6], EndingDate[6])
                    else if AgingBy = AgingBy::"Posting Date" then
                        "G/L Entry6".SETRANGE("Posting Date", StartingDate[6], EndingDate[6]);
                    //HEI.02>>
                    sixMonthAmt := 0;

                end;
            }
            dataitem("G/L Entry7"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");
                column(sevenMonthAmt; sevenMonthAmt)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    sevenMonthAmt := "G/L Entry7"."Remaining Amount FND";
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02 commented begin<<
                    /*Var_StartDate7 := 0D;
                    Var_EndDate7 := 0D;
                    ConvertStartDate7 := '';
                    ConvertEndDate7 := '';
                    //HEI.02>>
                    Rec_AgingSetup.RESET;
                    Rec_AgingSetup.SETRANGE("No.",70000);
                    IF Rec_AgingSetup.FINDFIRST THEN BEGIN
                      ConvertEndDate7 := '-'+FORMAT(Rec_AgingSetup."Starting Date");
                      Var_StartDate7 :=CALCDATE(ConvertStartDate7,EndingDate);
                    END;
                    IF AgingBy = AgingBy::"Document Date" THEN
                      "G/L Entry7".SETRANGE("Document Date",Var_StartDate7,EndingDate)
                    ELSE IF AgingBy = AgingBy::"Posting Date" THEN
                      "G/L Entry7".SETRANGE("Posting Date",0D,Var_StartDate7);*/
                    //HEI.02 commented end>>

                    //HEI.02<<
                    if AgingBy = AgingBy::"Document Date" then
                        "G/L Entry7".SETRANGE("Document Date", StartingDate[7], EndingDate[7])
                    else if AgingBy = AgingBy::"Posting Date" then
                        "G/L Entry7".SETRANGE("Posting Date", StartingDate[7], EndingDate[7]);
                    //HEI.02>>
                    sevenMonthAmt := 0;

                end;
            }
            dataitem("G/L Entry8"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");
                column(eightMonthAmt; eightMonthAmt)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    eightMonthAmt := "G/L Entry8"."Remaining Amount FND";
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.02 commented begin<<
                    /*ConvertStartDate8 := '';
                    ConvertEndDate8 := '';
                    Var_StartDate8 := 0D;
                    Var_EndDate8 := 0D;
                    Rec_AgingSetup.RESET;
                    Rec_AgingSetup.SETRANGE("No.",80000);
                    IF Rec_AgingSetup.FINDFIRST THEN BEGIN
                      ConvertEndDate8 := '-'+FORMAT(Rec_AgingSetup."Starting Date");
                      Var_StartDate8 :=CALCDATE(ConvertEndDate8,EndingDate);
                    END;
                    
                    IF AgingBy = AgingBy::"Document Date" THEN
                      "G/L Entry8".SETRANGE("Document Date",Var_StartDate8,EndingDate)
                    ELSE IF AgingBy = AgingBy::"Posting Date" THEN
                      "G/L Entry8".SETRANGE("Posting Date",0D,Var_StartDate8); */
                    //HEI.02 commented end>>

                    //HEI.02<<
                    if AgingBy = AgingBy::"Document Date" then
                        "G/L Entry8".SETRANGE("Document Date", 0D, EndingDate[8])
                    else if AgingBy = AgingBy::"Posting Date" then
                        "G/L Entry8".SETRANGE("Posting Date", 0D, EndingDate[8]);

                    eightMonthAmt := 0;
                    //HEI.02>>

                end;
            }

            trigger OnAfterGetRecord();
            begin
                if "NewPagePerG/L" then
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem();
            begin
                PageGroupNo := 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(AgedDate; AgedDate)
                    {
                        Caption = 'Aged as Of:';
                        ApplicationArea = All;
                    }
                    field(AgingBy; AgingBy)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Aging by',
                                    FRA = 'Agée par';
                        OptionCaptionML = ENU = 'Posting Date,Document Date',
                                          FRA = 'Date de comptabilisation,Date de document';
                        ToolTipML = ENU = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.',
                                    FRA = 'Indique si le cumul date est calculé à partir de la date d''échéance, la date comptabilisation ou la date document.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Period Length',
                                    FRA = 'Base période';
                        Editable = true;
                        ToolTipML = ENU = 'Specifies the length of each period, for example, enter "1M" for one month.',
                                    FRA = 'Spécifie la longueur de chacune des périodes ; par exemple, saisissez « 1M » pour un mois.';
                        Visible = false;

                        trigger OnValidate();
                        begin
                            if FORMAT(PeriodLength) <> '' then
                                ERROR('Period length should be blank');
                        end;
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Heading Type',
                                    FRA = 'Type titre';
                        OptionCaptionML = ENU = 'Date Interval,Number of Days',
                                          FRA = 'Intervalle de dates,Nombre de jours';
                        ToolTipML = ENU = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.',
                                    FRA = 'Indique si l''en-tête de colonne pour les trois périodes doit indiquer un intervalle de date ou le nombre de jours échus.';
                        Visible = false;
                    }
                    field("NewPagePerG/L"; "NewPagePerG/L")
                    {
                        Caption = 'New Page Per G/L Account';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            if AgedDate = 0D then
                AgedDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    var
    // CaptionManagement: Codeunit CaptionManagement;
    begin
    end;

    trigger OnPreReport();
    var
    //  CaptionManagement: Codeunit CaptionManagement;
    begin
        // GLFilter := CaptionManagement.GetRecordFiltersWithCaptions("G/L Account");
        GLFilter := GetRecordFiltersWithCaptions("G/L Account"); //BC Upgrade GUNREM01

        CalcDates;
    end;

    local procedure GetRecordFiltersWithCaptions(Recvariant: Variant) Filters: Text
    var

        RecRef: RecordRef;
        FieldRef: FieldRef;
        FieldFilter: Text;
        Name: Text;
        Cap: Text;
        Pos: Integer;
        i: Integer;
    begin
        RecRef.GETTABLE(RecVariant);
        Filters := RecRef.GETFILTERS;
        IF Filters = '' THEN
            EXIT;

        FOR i := 1 TO RecRef.FIELDCOUNT DO BEGIN
            FieldRef := RecRef.FIELDINDEX(i);
            FieldFilter := FieldRef.GETFILTER;
            IF FieldFilter <> '' THEN BEGIN
                Name := STRSUBSTNO('%1: ', FieldRef.NAME);
                Cap := STRSUBSTNO('%1: ', FieldRef.CAPTION);
                Pos := STRPOS(Filters, Name);
                IF Pos <> 0 THEN
                    Filters := INSSTR(DELSTR(Filters, Pos, STRLEN(Name)), Cap, Pos);
            END;
        END;

    end;

    var
        ConvertStartDate: Text;
        ConvertEndDate: Text;
        ConvertStartDate2: Text;
        ConvertEndDate2: Text;
        ConvertStartDate3: Text;
        ConvertEndDate3: Text;
        ConvertStartDate4: Text;
        ConvertEndDate4: Text;
        ConvertStartDate5: Text;
        ConvertEndDate5: Text;
        ConvertStartDate6: Text;
        ConvertEndDate6: Text;
        GLFilter: Text;
        "NewPagePerG/L": Boolean;
        PageGroupNo: Integer;
        OneMonthAmt: Decimal;
        Rec_AgingSetup: Record "Aging Setup FND";
        Var_StartDate1: Date;
        Var_EndDate1: Date;
        Var_StartDate2: Date;
        Var_EndDate2: Date;
        Var_StartDate3: Date;
        Var_EndDate3: Date;
        Var_StartDate4: Date;
        Var_EndDate4: Date;
        Var_StartDate5: Date;
        Var_EndDate5: Date;
        Var_StartDate6: Date;
        Var_EndDate6: Date;
        TwoMonthAmt: Decimal;
        threeMonthAmt: Decimal;
        fourMonthAmt: Decimal;
        fiveMonthAmt: Decimal;
        sixMonthAmt: Decimal;
        AgedDate: Date;
        AgingBy: Option "Posting Date","Document Date";
        PeriodLength: DateFormula;
        HeadingType: Option "Date Interval","Number of Days";
        HeaderText: array[50] of Text[30];
        AgingDate: array[8] of Text;
        AgingSetup: Record "Aging Setup FND";
        i: Integer;
        Text000: TextConst ENU = 'Not Due', FRA = 'Non échu';
        Text001: TextConst ENU = 'Before', FRA = 'Avant';
        Text002: TextConst ENU = 'days', FRA = 'jours';
        Text003: TextConst ENU = 'More than', FRA = 'Plus de';
        Text004: TextConst ENU = 'Aged by %1', FRA = 'Agée par %1';
        Text005: TextConst ENU = 'Total for %1', FRA = 'Total de %1';
        Text006: TextConst ENU = 'Aged as of %1', FRA = 'Agée en date du %1';
        Text007: TextConst ENU = 'Aged by %1', FRA = 'Agée par %1';
        Text009: TextConst ENU = 'Posting Date,Document Date', FRA = 'date de comptabilisation,date de document';
        Text010: TextConst ENU = 'The Date Formula %1 cannot be used. Try to restate it, for example, by using 1M+CM instead of CM+1M.', FRA = 'La formule date %1 ne peut pas être utilisée. Veuillez la redéfinir en utilisant, par exemple, 1M+CM au lieu de CM+1M.';
        EnterDateFormulaErr: TextConst ENU = 'Enter a date formula in the Period Length field.', FRA = 'Entrez une formule de date dans le champ Base période.';
        Text027: TextConst Comment = 'Negating the period length: %1 is the period length', ENU = '-%1', FRA = '-%1';
        AgedAcctPayableCaptionLbl: TextConst ENU = 'Aged G/L Accounts', FRA = 'Comptabilité G/L âgée';
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        AllAmtsinLCYCaptionLbl: TextConst ENU = 'All Amounts in LCY', FRA = 'Tous les montants DS';
        AgedOverdueAmsCaptionLbl: TextConst ENU = 'Aged Overdue Amounts', FRA = 'Montants échus âgés';
        GrandTotalVLE5RemAmtLCYCaptionLbl: TextConst ENU = 'Balance', FRA = 'Solde';
        AmountLCYCaptionLbl: TextConst ENU = 'Original Amount', FRA = 'Montant initial';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        DocumentNoCaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        PostingDateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        DocumentTypeCaptionLbl: TextConst ENU = 'Document Type', FRA = 'Type document';
        CurrencyCaptionLbl: TextConst ENU = 'Currency Code    AgedOverdueAmsCaptionLbl', FRA = 'Code devise';
        TotalLCYCaptionLbl: TextConst ENU = 'Total (LCY)', FRA = 'Total DS';
        CurrencySpecificationCaptionLbl: TextConst ENU = 'Currency Specification   ', FRA = 'Détail devise';
        ConvertStartDate8: Text;
        ConvertEndDate8: Text;
        eightMonthAmt: Decimal;
        Var_StartDate8: Date;
        Var_EndDate8: Date;
        ConvertStartDate7: Text;
        ConvertEndDate7: Text;
        sevenMonthAmt: Decimal;
        Var_StartDate7: Date;
        Var_EndDate7: Date;
        GLDates: array[8] of Date;
        StartingDate: array[8] of Date;
        EndingDate: array[8] of Date;
        test1: Text;
        test2: Text;
        Var_StartDate: array[8] of Date;
        Var_EndDate: array[8] of Date;
        Period: array[8] of Integer;

    local procedure CalcDates();
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        //HEI.02 commented begin<<
        /*i := 1;
        AgingSetup.RESET;
        AgingSetup.SETCURRENTKEY("No.");
        IF AgingSetup.FINDSET THEN
        REPEAT
          AgingDate[i] := DELCHR(FORMAT(AgingSetup."Starting Date"),'=','-')+'-'+ DELCHR(FORMAT(AgingSetup."Ending Date"),'=','-');
          //AgingDate[i] := DELCHR(FORMAT(AgingSetup."Starting Date"),'=','-')+'-'+ DELCHR(FORMAT(AgingSetup."Ending Date"),'=','-');
          i := i+1;
        UNTIL AgingSetup.NEXT=0;*/
        //DELCHR(FileName,'=',';');
        //HEI.02 commented end>>

        //HEI.02<<
        CLEAR(AgingDate);
        CLEAR(StartingDate);
        CLEAR(EndingDate);

        StartingDate[1] := CALCDATE('<-CM>', AgedDate);
        EndingDate[1] := CALCDATE('<CM>', AgedDate);

        StartingDate[2] := CALCDATE('<-1M-CM>', AgedDate);
        EndingDate[2] := CALCDATE('<-1M+CM>', AgedDate);

        StartingDate[3] := CALCDATE('<-2M-CM>', AgedDate);
        EndingDate[3] := CALCDATE('<-2M+CM>', AgedDate);

        StartingDate[4] := CALCDATE('<-3M-CM>', AgedDate);
        EndingDate[4] := CALCDATE('<-3M+CM>', AgedDate);

        StartingDate[5] := CALCDATE('<-4M-CM>', AgedDate);
        EndingDate[5] := CALCDATE('<-4M+CM>', AgedDate);

        StartingDate[6] := CALCDATE('<-5M-CM>', AgedDate);
        EndingDate[6] := CALCDATE('<-5M+CM>', AgedDate);

        StartingDate[7] := CALCDATE('<-11M-CM>', AgedDate);
        EndingDate[7] := CALCDATE('<-6M+CM>', AgedDate);

        EndingDate[8] := CALCDATE('<-12M+CM>', AgedDate);

        for i := 1 to 7 do
            AgingDate[i] := FORMAT(EndingDate[i]) + '-' + FORMAT(StartingDate[i]);
        AgingDate[8] := '<' + FORMAT(EndingDate[8]);
        //HEI.02>>

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
}

