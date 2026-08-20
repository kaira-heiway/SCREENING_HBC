codeunit 50002 "Calendar Management HeiLite"
{
    procedure CalcNextWorkingDate(DateFormula: DateFormula; OrgDate: Date; CalendarCode: Code[10]): Date
    var
        CompanyInfo: Record "Company Information";
        NegDateFormula: DateFormula;
        LoopFactor: Integer;
        NewDate: Date;
        Ok: Boolean;
        LoopCounter: Integer;
        Nonworking: Boolean;
        TempDesc: Text[100];
        LoopTerminator: Boolean;
        CalConvTimeFrame: Integer;
    begin
        Evaluate(NegDateFormula, '<-0D>');
        if OrgDate = 0D then
            OrgDate := WorkDate();
        if (CalcDate(DateFormula, OrgDate) >= OrgDate) and (DateFormula <> NegDateFormula) then
            LoopFactor := 1
        else
            LoopFactor := -1;
        if CompanyInfo.Get() then
            CalConvTimeFrame := CalcDate(CompanyInfo."Cal. Convergence Time Frame", WorkDate()) - WorkDate();

        NewDate := OrgDate;

        if CalcDate(DateFormula, OrgDate) <> OrgDate then
            repeat
                NewDate := NewDate + LoopFactor;
                Ok := NOT CheckCustomizedDateStatus(DATABASE::"Company Information", '', '', CalendarCode, NewDate, TempDesc);
                if Ok then
                    LoopCounter := LoopCounter + 1;
                if NewDate >= OrgDate + CalConvTimeFrame then
                    LoopCounter := Abs(CalcDate(DateFormula, OrgDate) - OrgDate);
            until LoopCounter = Abs(CalcDate(DateFormula, OrgDate) - OrgDate);

        LoopCounter := 0;

        repeat
            LoopCounter := LoopCounter + 1;
            Nonworking :=
              CheckCustomizedDateStatus(DATABASE::"Company Information", '', '', CalendarCode, NewDate, TempDesc);
            if Nonworking then
                NewDate := NewDate + LoopFactor
            else
                exit(NewDate);
            if LoopCounter >= CalConvTimeFrame then
                LoopTerminator := true;
        until LoopTerminator = true;

        exit(NewDate);
    end;

    procedure CheckCustomizedDateStatus(SourceType: Option Company,Customer,Vendor,Location,"Shipping Agent",Service; SourceCode: Code[20]; AdditionalSourceCode: Code[20]; CalendarCode: Code[10]; TargetDate: Date; VAR Description: Text[50]): Boolean
    var
        TempFreqDate: Date;
        CountAddDays: Integer;
    begin
        SourceSubType := 0;
        CombineChanges(SourceType, SourceCode, AdditionalSourceCode, CalendarCode);
        TempCustChange.Reset();
        TempCustChange.SetCurrentKey("Entry No.");
        if TempCustChange.FindSet() then
            repeat
                TempFreqDate := TargetDate;
                if Format(TempCustChange."Recurring Frequency FND") <> '' then
                    if (TempCustChange.Date = 0D) and
                      (TempCustChange."Starting Date FND" <= TargetDate) AND
                      ((TempCustChange."Ending Date FND" >= TargetDate) OR
                      (TempCustChange."Ending Date FND" = 0D))
                    then begin
                        if TempCustChange."Starting Date FND" <> 0D then
                            TempFreqDate := TempCustChange."Starting Date FND";

                        CountAddDays := fctCalcWeekdayDiff(Date2DWY(TempFreqDate, 1), TempCustChange.Day);

                        if CountAddDays <> 0 then
                            TempFreqDate := CalcDate('<' + Format(Abs(CountAddDays)) + 'D>', TempFreqDate);

                        while TempFreqDate < TargetDate do
                            TempFreqDate := CalcDate(TempCustChange."Recurring Frequency FND", TempFreqDate);
                    end;
                LastTempCustChange := TempCustChange;

                case TempCustChange."Recurring System" of
                    TempCustChange."Recurring System"::" ":
                        if TargetDate = TempCustChange.Date then
                            if (TempCustChange."Starting Date FND" <= TargetDate) and
                              ((TempCustChange."Ending Date FND" >= TargetDate) or (TempCustChange."Ending Date FND" = 0D)) and
                              (TempFreqDate = TargetDate)
                            then begin
                                Description := TempCustChange.Description;
                                exit(TempCustChange.Nonworking);
                            end;
                    TempCustChange."Recurring System"::"Weekly Recurring":
                        if Date2DWY(TargetDate, 1) = TempCustChange.Day then begin
                            Description := TempCustChange.Description;
                            exit(TempCustChange.Nonworking);
                        end;
                    TempCustChange."Recurring System"::"Annual Recurring":
                        if (TempCustChange.Date <> 0D) AND (TempFreqDate = TargetDate) then
                            if (Date2DMY(TargetDate, 2) = Date2DMY(TempCustChange.Date, 2)) AND
                               (Date2DMY(TargetDate, 1) = Date2DMY(TempCustChange.Date, 1))
                            then begin
                                Description := TempCustChange.Description;
                                exit(TempCustChange.Nonworking);
                            end;
                end;
            until TempCustChange.Next() = 0;
        Description := '';
    end;

    local procedure CombineChanges(SourceType: Option Company,Customer,Vendor,Location,"Shipping Agent",Service; SourceCode: Code[20]; AdditionalSourceCode: Code[20]; CalendarCode: Code[10])
    begin
        IF (SourceType = OldSourceType) AND
           (SourceCode = OldSourceCode) AND (AdditionalSourceCode = OldAdditionalSourceCode) AND (CalendarCode = OldCalendarCode)
        THEN
            EXIT;

        TempCustChange.Reset();
        TempCustChange.DeleteAll();

        TempCounter := 0;
        CustCalChange.Reset();
        CustCalChange.SetRange("Source Type", SourceType);
        CustCalChange.SetRange("Source Code", SourceCode);
        CustCalChange.SetRange("Base Calendar Code", CalendarCode);
        CustCalChange.SetRange("Additional Source Code", AdditionalSourceCode);
        CASE SourceSubType OF
            SourceSubType::Calling:
                CustCalChange.SetRange("Calling FND", TRUE);
            SourceSubType::Shipment:
                CustCalChange.SetRange("Shipment FND", TRUE);
            SourceSubType::Delivery:
                CustCalChange.SetRange("Promised Delivery FND", TRUE);
        END;
        if CustCalChange.FindSet() then
            repeat
                IF (SourceSubType IN [SourceSubType::" ", SourceSubType::Calling, SourceSubType::Shipment, SourceSubType::Delivery]) OR
                  ((SourceSubType = SourceSubType::Both) AND
                   (CustCalChange."Calling FND" OR CustCalChange."Shipment FND" OR CustCalChange."Promised Delivery FND"))
                then begin
                    TempCounter := TempCounter + 1;
                    TempCustChange.Init();
                    TempCustChange."Source Type" := CustCalChange."Source Type";
                    TempCustChange."Source Code" := CustCalChange."Source Code";
                    TempCustChange."Base Calendar Code" := CustCalChange."Base Calendar Code";
                    TempCustChange."Additional Source Code" := CustCalChange."Additional Source Code";
                    TempCustChange.Date := CustCalChange.Date;
                    TempCustChange.Description := CustCalChange.Description;
                    TempCustChange.Day := CustCalChange.Day;
                    TempCustChange.Nonworking := CustCalChange.Nonworking;
                    TempCustChange."Recurring System" := CustCalChange."Recurring System";
                    TempCustChange."Entry No." := TempCounter;
                    TempCustChange."Shipment FND" := CustCalChange."Shipment FND";
                    TempCustChange."Shipment Day FND" := CustCalChange."Shipment Day FND";
                    TempCustChange."Shipment Time FND" := CustCalChange."Shipment Time FND";
                    TempCustChange."Promised Delivery FND" := CustCalChange."Promised Delivery FND";
                    TempCustChange."Promised Delivery Day FND" := CustCalChange."Promised Delivery Day FND";
                    TempCustChange."Promised Delivery Time FND" := CustCalChange."Promised Delivery Time FND";
                    TempCustChange."Starting Date FND" := CustCalChange."Starting Date FND";
                    TempCustChange."Ending Date FND" := CustCalChange."Ending Date FND";
                    TempCustChange."Recurring Frequency FND" := CustCalChange."Recurring Frequency FND";
                    TempCustChange."Calling FND" := CustCalChange."Calling FND";
                    TempCustChange."Calling Day FND" := CustCalChange."Calling Day FND";
                    TempCustChange."Calling Time FND" := CustCalChange."Calling Time FND";
                    IF (TempCustChange.Date <> 0D) AND
                      (TempCustChange."Calling FND" OR TempCustChange."Shipment FND" OR TempCustChange."Promised Delivery FND") AND
                      (SourceType = SourceType::Company)
                    THEN
                        TempCustChange.Description := '';
                    TempCustChange.Insert();
                end;
            until CustCalChange.Next() = 0;

        CLEAR(TempCustChange);
        BaseCalChange.Reset();
        BaseCalChange.SetRange("Base Calendar Code", CalendarCode);
        if BaseCalChange.FindSet() then
            repeat
                TempCounter := TempCounter + 1;
                TempCustChange.Init();
                TempCustChange."Entry No." := TempCounter;
                TempCustChange."Source Type" := SourceType;
                TempCustChange."Source Code" := SourceCode;
                TempCustChange."Base Calendar Code" := BaseCalChange."Base Calendar Code";
                TempCustChange.Date := BaseCalChange.Date;
                TempCustChange.Description := BaseCalChange.Description;
                TempCustChange.Day := BaseCalChange.Day;
                TempCustChange.Nonworking := BaseCalChange.Nonworking;
                TempCustChange."Recurring System" := BaseCalChange."Recurring System";
                TempCustChange.Insert();
            until BaseCalChange.Next() = 0;

        OldSourceType := SourceType;
        OldSourceCode := SourceCode;
        OldAdditionalSourceCode := AdditionalSourceCode;
        OldCalendarCode := CalendarCode;
    end;

    procedure fctCalcWeekdayDiff(pintWeekDayFrom: Integer; pintWeekDayTo: Integer): Integer
    begin
        CASE TRUE OF
            pintWeekDayFrom < pintWeekDayTo:
                EXIT(pintWeekDayTo - pintWeekDayFrom);
            pintWeekDayFrom > pintWeekDayTo:
                EXIT(7 - pintWeekDayFrom + pintWeekDayTo);
            ELSE
                EXIT(0);
        END;
    end;

    var
        TempCustChange: Record "Customized Calendar Change" temporary;
        LastTempCustChange: Record "Customized Calendar Change" temporary;
        CustCalChange: Record "Customized Calendar Change";
        BaseCalChange: Record "Base Calendar Change";
        OldSourceType: Integer;
        OldSourceCode: Code[20];
        OldAdditionalSourceCode: Code[20];
        OldCalendarCode: Code[10];
        TempCounter: Integer;
        SourceSubType: Option " ",Calling,Shipment,Delivery,Both;
}
