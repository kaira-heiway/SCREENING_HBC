table 50276 "Zycus Master Timestamp FND"
{
    // version HEI.03

    // HEI.01 CHG2210794 MAJUMS03 22.01.2024 Zycus - BASE HL Integration Master Vendor and GL Account (*RLPPD)
    //   # Created New Table: 50651 - Zycus Master Timestamp
    //   # Created New Functions - UpdateZycusMaterTimestamp
    //                           - GetLocalCurrentDateTime_Zycus
    // HEI.02 CHG2210794 MAJUMS03 13.05.2024 Zycus - BASE HL Integration - Vendor GL Account Development Rework.
    //   # Code added.
    // HEI.03 CHG2210794 MAJUMS03 16.05.2024 Zycus - BASE HL Integration - Vendor development finetuning
    //   # New Field added - Last Change Datetime (Field ID. 5) to capture the Current Datetime not the UTC.
    //   # Code added.


    fields
    {
        field(1; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(2; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(3; "Last Local Change Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(4; Deleted; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(5; "Last Change Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "Table ID", "Code")
        {
        }
        key(Key2; "Table ID", Deleted, "Last Local Change Datetime")
        {
        }
    }

    fieldgroups
    {
    }

    procedure UpdateZycusMaterTimestamp(TableIDLP: Integer; CodeLP: Code[20]; DeleteLP: Boolean; GlobalFlagDel: Boolean);
    var
        ZycusMasterTimeStampLV: Record "Zycus Master Timestamp FND";
        ErrorLT001: Label 'Master Table ID. cannot be 0.';
        ErrorLT002: Label 'Master Code cannot be blank.';
    begin
        //HEI.01>>
        if TableIDLP = 0 then
            ERROR(ErrorLT001);
        if CodeLP = '' then
            ERROR(ErrorLT002);
        //HEI.02>>
        if TableIDLP = DATABASE::Vendor then begin
            if GlobalFlagDel then begin
                exit;
            end;
        end;
        //HEI.02<<
        ZycusMasterTimeStampLV.RESET();
        if ZycusMasterTimeStampLV.GET(TableIDLP, CodeLP) then begin
            ZycusMasterTimeStampLV."Last Local Change Datetime" := GetLocalCurrentDateTime_Zycus();
            ZycusMasterTimeStampLV.Deleted := DeleteLP;
            ZycusMasterTimeStampLV."Last Change Datetime" := CURRENTDATETIME; //HEI.03
            ZycusMasterTimeStampLV.MODIFY();
        end else begin
            ZycusMasterTimeStampLV.INIT();
            ZycusMasterTimeStampLV."Table ID" := TableIDLP;
            ZycusMasterTimeStampLV.Code := CodeLP;
            ZycusMasterTimeStampLV."Last Local Change Datetime" := GetLocalCurrentDateTime_Zycus();
            ZycusMasterTimeStampLV.Deleted := DeleteLP;
            ZycusMasterTimeStampLV."Last Change Datetime" := CURRENTDATETIME; //HEI.03
            ZycusMasterTimeStampLV.INSERT();
        end;
        //HEI.01<<
    end;

    local procedure GetLocalCurrentDateTime_Zycus() Now: DateTime;
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
    begin
        //HEI.01>>
        Now := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        //HEI.01<<
    end;
}

