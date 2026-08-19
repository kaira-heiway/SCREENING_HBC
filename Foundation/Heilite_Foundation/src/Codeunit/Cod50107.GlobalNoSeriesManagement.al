codeunit 50107 GlobalNoSeriesManagement
{
    // version HEI.01

    // HEI.01 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # Codeunit created
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # Codeunit created

    Permissions = TableData "No. Series Line" = rimd;

    trigger OnRun();
    begin
        TryGlobalNo := GetNextGlobalNo(TryGlobalNoSeriesCode, TryGlobalSeriesDate, false);
    end;

    var
        GlobalNoSeries: Record "Global No. Series FND";
        LastGlobalNoSeriesLine: Record "Global No. Series Line FND";
        GlobalNoSeriesCode: Code[10];
        GlobalWarningNoSeriesCode: Code[10];
        TryGlobalNoSeriesCode: Code[10];
        TryGlobalNo: Code[20];
        TryGlobalSeriesDate: Date;
        Text000: TextConst ENU = 'You may not enter numbers manually. ', FRA = 'Vous ne souhaitez peut-être pas entrer les numéros manuellement. ';
        Text001: TextConst ENU = 'If you want to enter numbers manually, please activate %1 in %2 %3.', FRA = 'Si vous souhaitez entrer les numéros manuellement, vous devez activer %1 dans %2 %3.';
        Text002: TextConst ENU = 'It is not possible to assign numbers automatically. ', FRA = 'Il n''est pas possible d''attribuer automatiquement des numéros. ';
        Text003: TextConst ENU = 'If you want the program to assign numbers automatically, please activate %1 in %2 %3.', FRA = 'Si vous souhaitez que le programme attribue automatiquement des numéros, vous devez activer %1 %2 dans %3.';
        Text004: TextConst ENU = 'You cannot assign new numbers from the number series %1 on %2.', FRA = 'Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1 dans %2.';
        Text005: TextConst ENU = 'You cannot assign new numbers from the number series %1.', FRA = 'Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1.';
        Text006: TextConst ENU = 'You cannot assign new numbers from the number series %1 on a date before %2.', FRA = 'Vous ne pouvez pas attribuer de nouveaux numéros à partir de la souche de numéros %1 pour une date antérieure au %2.';
        Text007: TextConst ENU = 'You cannot assign numbers greater than %1 from the number series %2.', FRA = 'Vous ne pouvez pas attribuer de numéros supérieurs à %1 à partir de la souche de numéros %2.';
        Text009: TextConst ENU = 'The number format in %1 must be the same as the number format in %2.', FRA = 'Le format de numéro dans %1 doit être identique à celui de %2.';
        Text010: TextConst ENU = 'The number %1 cannot be extended to more than 20 characters.', FRA = 'Le numéro %1 ne peut pas être étendu à plus de 20 caractères.';

    procedure TestManual(DefaultNoSeriesCode: Code[10]);
    begin
        if DefaultNoSeriesCode <> '' then begin
            GlobalNoSeries.GET(DefaultNoSeriesCode);
            if not GlobalNoSeries."Manual Nos." then
                ERROR(
                  Text000 +
                  Text001,
                  GlobalNoSeries.FIELDCAPTION("Manual Nos."), GlobalNoSeries.TABLECAPTION, GlobalNoSeries.Code);
        end;
    end;

    procedure InitGlobalSeries(DefaultGlobalNoSeriesCode: Code[10]; GlobalOldNoSeriesCode: Code[10]; NewDate: Date; var NewNo: Code[20]; var NewNoSeriesCode: Code[10]);
    begin
        if NewNo = '' then begin
            GlobalNoSeries.GET(DefaultGlobalNoSeriesCode);
            if not GlobalNoSeries."Default Nos." then
                ERROR(
                  Text002 +
                  Text003,
                  GlobalNoSeries.FIELDCAPTION("Default Nos."), GlobalNoSeries.TABLECAPTION, GlobalNoSeries.Code);
            if GlobalOldNoSeriesCode <> '' then begin
                GlobalNoSeriesCode := DefaultGlobalNoSeriesCode;
                FilterGlobalSeries();
                GlobalNoSeries.Code := GlobalOldNoSeriesCode;
                if not GlobalNoSeries.FIND() then
                    GlobalNoSeries.GET(DefaultGlobalNoSeriesCode);
            end;
            NewNo := GetNextGlobalNo(GlobalNoSeries.Code, NewDate, true);
            NewNoSeriesCode := GlobalNoSeries.Code;
        end else
            TestManual(DefaultGlobalNoSeriesCode);
    end;

    procedure SetDefaultGlobalSeries(var NewGlobalNoSeriesCode: Code[10]; GlobalNoSeriesCode: Code[10]);
    begin
        if GlobalNoSeriesCode <> '' then begin
            GlobalNoSeries.GET(GlobalNoSeriesCode);
            if GlobalNoSeries."Default Nos." then
                NewGlobalNoSeriesCode := GlobalNoSeries.Code;
        end;
    end;

    procedure SelectGlobalSeries(DefaultGlobalNoSeriesCode: Code[10]; OldGlobalNoSeriesCode: Code[10]; var NewGlobalNoSeriesCode: Code[10]): Boolean;
    begin
        GlobalNoSeriesCode := DefaultGlobalNoSeriesCode;
        FilterGlobalSeries();
        if NewGlobalNoSeriesCode = '' then begin
            if OldGlobalNoSeriesCode <> '' then
                GlobalNoSeries.Code := OldGlobalNoSeriesCode;
        end else
            GlobalNoSeries.Code := NewGlobalNoSeriesCode;
        if PAGE.RUNMODAL(0, GlobalNoSeries) = ACTION::LookupOK then begin
            NewGlobalNoSeriesCode := GlobalNoSeries.Code;
            exit(true);
        end;
    end;

    procedure LookupGlobalSeries(DefaultGlobalNoSeriesCode: Code[10]; var NewGlobalNoSeriesCode: Code[10]): Boolean;
    begin
        exit(SelectGlobalSeries(DefaultGlobalNoSeriesCode, NewGlobalNoSeriesCode, NewGlobalNoSeriesCode));
    end;

    procedure TestGlobalSeries(DefaultGlobalNoSeriesCode: Code[10]; NewGlobalNoSeriesCode: Code[10]);
    begin
        GlobalNoSeriesCode := DefaultGlobalNoSeriesCode;
        FilterGlobalSeries();
        GlobalNoSeries.Code := NewGlobalNoSeriesCode;
        GlobalNoSeries.FIND();
    end;

    procedure SetGlobalSeries(var NewGlobalNo: Code[20]);
    var
        GlobalNoSeriesCode2: Code[10];
    begin
        GlobalNoSeriesCode2 := GlobalNoSeries.Code;
        FilterGlobalSeries();
        GlobalNoSeries.Code := GlobalNoSeriesCode2;
        GlobalNoSeries.FIND();
        NewGlobalNo := GetNextGlobalNo(GlobalNoSeries.Code, 0D, true);
    end;

    local procedure FilterGlobalSeries();
    var
        NoSeriesRelationship: Record "No. Series Relationship";
    begin
        GlobalNoSeries.RESET();
        GlobalNoSeries.GET(GlobalNoSeriesCode);
        GlobalNoSeries.MARK := true;
        GlobalNoSeries.MARKEDONLY := true;
    end;

    procedure GetNextGlobalNo(GlobalNoSeriesCode: Code[10]; GlobalSeriesDate: Date; ModifySeries: Boolean): Code[20];
    begin
        exit(GetNextGlobalNo3(GlobalNoSeriesCode, GlobalSeriesDate, ModifySeries, false));
    end;

    procedure GetNextGlobalNo3(GlobalNoSeriesCode: Code[10]; GlobalSeriesDate: Date; ModifySeries: Boolean; NoErrorsOrWarnings: Boolean): Code[20];
    var
        GlobalNoSeriesLine: Record "Global No. Series Line FND";
    begin
        if GlobalSeriesDate = 0D then
            GlobalSeriesDate := WORKDATE();

        if ModifySeries or (LastGlobalNoSeriesLine."Series Code" = '') then begin
            if ModifySeries then
                GlobalNoSeriesLine.LOCKTABLE();
            GlobalNoSeries.GET(GlobalNoSeriesCode);
            SetGlobalNoSeriesLineFilter(GlobalNoSeriesLine, GlobalNoSeriesCode, GlobalSeriesDate);
            if not GlobalNoSeriesLine.FINDFIRST() then begin
                if NoErrorsOrWarnings then
                    exit('');
                GlobalNoSeriesLine.SETRANGE("Starting Date");
                if not GlobalNoSeriesLine.ISEMPTY then
                    ERROR(
                      Text004,
                      GlobalNoSeriesCode, GlobalSeriesDate);
                ERROR(
                  Text005,
                  GlobalNoSeriesCode);
            end;
        end else
            GlobalNoSeriesLine := LastGlobalNoSeriesLine;

        if GlobalNoSeries."Date Order" and (GlobalSeriesDate < GlobalNoSeriesLine."Last Date Used") then begin
            if NoErrorsOrWarnings then
                exit('');
            ERROR(
              Text006,
              GlobalNoSeries.Code, GlobalNoSeriesLine."Last Date Used");
        end;
        GlobalNoSeriesLine."Last Date Used" := GlobalSeriesDate;
        if GlobalNoSeriesLine."Last No. Used" = '' then begin
            if NoErrorsOrWarnings and (GlobalNoSeriesLine."Starting No." = '') then
                exit('');
            GlobalNoSeriesLine.TESTFIELD("Starting No.");
            GlobalNoSeriesLine."Last No. Used" := GlobalNoSeriesLine."Starting No.";
        end else
            if GlobalNoSeriesLine."Increment-by No." <= 1 then
                GlobalNoSeriesLine."Last No. Used" := INCSTR(GlobalNoSeriesLine."Last No. Used")
            else
                IncrementGlobalNoText(GlobalNoSeriesLine."Last No. Used", GlobalNoSeriesLine."Increment-by No.");
        if (GlobalNoSeriesLine."Ending No." <> '') and
           (GlobalNoSeriesLine."Last No. Used" > GlobalNoSeriesLine."Ending No.")
        then begin
            if NoErrorsOrWarnings then
                exit('');
            ERROR(
              Text007,
              GlobalNoSeriesLine."Ending No.", GlobalNoSeriesCode);
        end;
        if (GlobalNoSeriesLine."Ending No." <> '') and
           (GlobalNoSeriesLine."Warning No." <> '') and
           (GlobalNoSeriesLine."Last No. Used" >= GlobalNoSeriesLine."Warning No.") and
           (GlobalNoSeriesCode <> GlobalWarningNoSeriesCode) and
           (TryGlobalNoSeriesCode = '')
        then begin
            if NoErrorsOrWarnings then
                exit('');
            GlobalWarningNoSeriesCode := GlobalNoSeriesCode;
            MESSAGE(
              Text007,
              GlobalNoSeriesLine."Ending No.", GlobalNoSeriesCode);
        end;
        GlobalNoSeriesLine.VALIDATE(Open);

        if ModifySeries then
            GlobalNoSeriesLine.MODIFY()
        else
            LastGlobalNoSeriesLine := GlobalNoSeriesLine;
        exit(GlobalNoSeriesLine."Last No. Used");
    end;

    procedure TryGetNextGlobalNo(GlobalNoSeriesCode: Code[10]; GlobalSeriesDate: Date): Code[20];
    var
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked
        NoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDIS03 - Added
    begin
        // <<DITW15.00.00.15 DDR 25/03/2008
        // MSP.M1.0 DDE 121000
        // removed the NoSeriesMgt variable
        // and run() call
        // NoSeriesMgt.GetNextNo1(NoSeriesCode,SeriesDate);
        // IF NoSeriesMgt.RUN THEN
        //   EXIT(NoSeriesMgt.GetNextNo2);

        GetNextGlobalNo1(GlobalNoSeriesCode, GlobalSeriesDate);
        TryGlobalNo := GetNextGlobalNo(TryGlobalNoSeriesCode, TryGlobalSeriesDate, false);
        exit(GetNextGlobalNo2());
    end;

    procedure GetNextGlobalNo1(GlobalNoSeriesCode: Code[10]; GlobalSeriesDate: Date);
    begin
        TryGlobalNoSeriesCode := GlobalNoSeriesCode;
        TryGlobalSeriesDate := GlobalSeriesDate;
    end;

    procedure GetNextGlobalNo2(): Code[20];
    begin
        exit(TryGlobalNo);
    end;

    procedure SaveGlobalNoSeries();
    begin
        if LastGlobalNoSeriesLine."Series Code" <> '' then
            LastGlobalNoSeriesLine.MODIFY();
    end;

    procedure SetGlobalNoSeriesLineFilter(var GlobalNoSeriesLine: Record "Global No. Series Line FND"; GlobalNoSeriesCode: Code[10]; StartDate: Date);
    begin
        if StartDate = 0D then
            StartDate := WORKDATE();
        GlobalNoSeriesLine.RESET();
        GlobalNoSeriesLine.SETCURRENTKEY("Series Code", "Starting Date");
        GlobalNoSeriesLine.SETRANGE("Series Code", GlobalNoSeriesCode);
        GlobalNoSeriesLine.SETRANGE("Starting Date", 0D, StartDate);
        if GlobalNoSeriesLine.FINDLAST() then begin
            GlobalNoSeriesLine.SETRANGE("Starting Date", GlobalNoSeriesLine."Starting Date");
            GlobalNoSeriesLine.SETRANGE(Open, true);
        end;
    end;

    procedure IncrementGlobalNoText(var GlobalNo: Code[20]; IncrementByNo: Decimal);
    var
        BigIntIncByNo: BigInteger;
        BigIntNo: BigInteger;
        EndPos: Integer;
        StartPos: Integer;
        NewNo: Text[30];
    begin
        GetIntegerPos(GlobalNo, StartPos, EndPos);
        EVALUATE(BigIntNo, COPYSTR(GlobalNo, StartPos, EndPos - StartPos + 1));
        BigIntIncByNo := IncrementByNo;
        NewNo := FORMAT(BigIntNo + BigIntIncByNo, 0, 1);
        ReplaceGlobalNoText(GlobalNo, NewNo, 0, StartPos, EndPos);
    end;

    procedure UpdateGlobalNoSeriesLine(var GlobalNoSeriesLine: Record "Global No. Series Line FND"; NewGlobalNo: Code[20]; NewFieldName: Text[100]);
    var
        GlobalNoSeriesLine2: Record "Global No. Series Line FND";
        //TextManagement: Codeunit TextManagement;  // BC Upgrade NANDIS03
        Length: Integer;
    begin
        if NewGlobalNo <> '' then begin
            //TextManagement.EvaluateIncStr(NewGlobalNo,NewFieldName); // BC Upgrade NANDIS03  
            GlobalNoSeriesLine2 := GlobalNoSeriesLine;
            if NewGlobalNo = GetGlobalNoText(NewGlobalNo) then
                Length := 0
            else begin
                Length := STRLEN(GetGlobalNoText(NewGlobalNo));
                UpdateLength(GlobalNoSeriesLine."Starting No.", Length);
                UpdateLength(GlobalNoSeriesLine."Ending No.", Length);
                UpdateLength(GlobalNoSeriesLine."Last No. Used", Length);
                UpdateLength(GlobalNoSeriesLine."Warning No.", Length);
            end;
            UpdateGlobalNo(GlobalNoSeriesLine."Starting No.", NewGlobalNo, Length);
            UpdateGlobalNo(GlobalNoSeriesLine."Ending No.", NewGlobalNo, Length);
            UpdateGlobalNo(GlobalNoSeriesLine."Last No. Used", NewGlobalNo, Length);
            UpdateGlobalNo(GlobalNoSeriesLine."Warning No.", NewGlobalNo, Length);
            if (NewFieldName <> GlobalNoSeriesLine.FIELDCAPTION("Last No. Used")) and
               (GlobalNoSeriesLine."Last No. Used" <> GlobalNoSeriesLine2."Last No. Used")
            then
                ERROR(
                  Text009,
                  NewFieldName, GlobalNoSeriesLine.FIELDCAPTION("Last No. Used"));
        end;
    end;

    local procedure UpdateLength(GlobalNo: Code[20]; var MaxLength: Integer);
    var
        Length: Integer;
    begin
        if GlobalNo <> '' then begin
            Length := STRLEN(DELCHR(GetGlobalNoText(GlobalNo), '<', '0'));
            if Length > MaxLength then
                MaxLength := Length;
        end;
    end;

    local procedure UpdateGlobalNo(var GlobalNo: Code[20]; NewGlobalNo: Code[20]; Length: Integer);
    var
        TempGlobalNo: Code[20];
        EndPos: Integer;
        StartPos: Integer;
    begin
        if GlobalNo <> '' then begin
            if Length <> 0 then begin
                GlobalNo := DELCHR(GetGlobalNoText(GlobalNo), '<', '0');
                TempGlobalNo := GlobalNo;
                GlobalNo := NewGlobalNo;
                NewGlobalNo := TempGlobalNo;
                GetIntegerPos(GlobalNo, StartPos, EndPos);
                ReplaceGlobalNoText(GlobalNo, NewGlobalNo, Length, StartPos, EndPos);
            end;
        end;
    end;

    local procedure ReplaceGlobalNoText(var GlobalNo: Code[20]; NewGlobalNo: Code[20]; FixedLength: Integer; StartPos: Integer; EndPos: Integer);
    var
        GlobalEndNo: Code[20];
        GlobalStartNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
    begin
        if StartPos > 1 then
            GlobalStartNo := COPYSTR(GlobalNo, 1, StartPos - 1);
        if EndPos < STRLEN(GlobalNo) then
            GlobalEndNo := COPYSTR(GlobalNo, EndPos + 1);
        NewLength := STRLEN(NewGlobalNo);
        OldLength := EndPos - StartPos + 1;
        if FixedLength > OldLength then
            OldLength := FixedLength;
        if OldLength > NewLength then
            ZeroNo := PADSTR('', OldLength - NewLength, '0');
        if STRLEN(GlobalStartNo) + STRLEN(ZeroNo) + STRLEN(NewGlobalNo) + STRLEN(GlobalEndNo) > 20 then
            ERROR(
              Text010,
              GlobalNo);
        GlobalNo := GlobalStartNo + ZeroNo + NewGlobalNo + GlobalEndNo;
    end;

    local procedure GetGlobalNoText(GlobalNo: Code[20]): Code[20];
    var
        EndPos: Integer;
        StartPos: Integer;
    begin
        GetIntegerPos(GlobalNo, StartPos, EndPos);
        if StartPos <> 0 then
            exit(COPYSTR(GlobalNo, StartPos, EndPos - StartPos + 1));
    end;

    local procedure GetIntegerPos(GlobalNo: Code[20]; var StartPos: Integer; var EndPos: Integer);
    var
        IsDigit: Boolean;
        i: Integer;
    begin
        StartPos := 0;
        EndPos := 0;
        if GlobalNo <> '' then begin
            i := STRLEN(GlobalNo);
            repeat
                IsDigit := GlobalNo[i] in ['0' .. '9'];
                if IsDigit then begin
                    if EndPos = 0 then
                        EndPos := i;
                    StartPos := i;
                end;
                i := i - 1;
            until (i = 0) or (StartPos <> 0) and not IsDigit;
        end;
    end;

    procedure GetGlobalNoSeriesWithCheck(NewGlobalNoSeriesCode: Code[10]; SelectGlobalNoSeriesAllowed: Boolean; CurrentGlobalNoSeriesCode: Code[10]): Code[10];
    var
        CurrGlobalNoSeries: Record "Global No. Series FND";
    begin
        if not SelectGlobalNoSeriesAllowed then
            exit(NewGlobalNoSeriesCode);

        CurrGlobalNoSeries.GET(NewGlobalNoSeriesCode);
        if CurrGlobalNoSeries."Default Nos." then
            exit(NewGlobalNoSeriesCode);

        if SeriesHasRelations(NewGlobalNoSeriesCode) then begin
            if SelectGlobalSeries(NewGlobalNoSeriesCode, '', CurrentGlobalNoSeriesCode) then
                exit(CurrentGlobalNoSeriesCode);
            CLEAR(GlobalNoSeries);
        end;

        exit(NewGlobalNoSeriesCode);
    end;

    procedure SeriesHasRelations(DefaultNoSeriesCode: Code[10]): Boolean;
    var
        NoSeriesRelationship: Record "No. Series Relationship";
    begin
        NoSeriesRelationship.RESET();
        NoSeriesRelationship.SETRANGE(Code, DefaultNoSeriesCode);
        exit(not NoSeriesRelationship.ISEMPTY);
    end;

    procedure IsGlobalSeriesSelected(): Boolean;
    begin
        exit(GlobalNoSeries.Code <> '');
    end;
}

