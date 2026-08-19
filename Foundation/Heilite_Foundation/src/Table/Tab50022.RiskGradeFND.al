table 50022 "Risk Grade FND"
{
    // version HEI.02

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP015a IBM ISYED01 11/07/2017
    //   #Added new table Risk Grade
    // HEI.02 FDD-OTCGAP075 IBM NASTAA02 15.05.2018 # No dependency between respective credit risk Master Date fields in the system
    //   # New Fields created 5 - "Lower Margin"
    //                        6 - "Upper Margin"
    //   # User should not be allowed to create new records, added error message on 'OnInsert' trigger
    //   # Should not be possible to have overlaps between different grades, created function CheckRiskGradesMargins


    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'HEI.01';
        }
        field(2; Description; Text[50])
        {
            Description = 'HEI.01';
        }
        field(5; "Lower Margin"; Integer)
        {
            Description = 'HEI.02';
            MaxValue = 101;
            MinValue = 0;

            trigger OnValidate();
            begin
                //HEI.02>>
                CheckRiskGradesMargins("Lower Margin", Code);
                if ("Lower Margin" > "Upper Margin") and
                   ("Upper Margin" > 0)
                then
                    ERROR(LowerMgCntExceedUpperMgErr, FIELDCAPTION("Lower Margin"), "Lower Margin", FIELDCAPTION("Upper Margin"), "Upper Margin");
                //HEI.02<<
            end;
        }
        field(6; "Upper Margin"; Integer)
        {
            Description = 'HEI.02';
            MaxValue = 101;
            MinValue = 0;

            trigger OnValidate();
            begin
                //HEI.02>>
                CheckRiskGradesMargins("Upper Margin", Code);
                if ("Lower Margin" > "Upper Margin") then
                    ERROR(LowerMgCntExceedUpperMgErr, FIELDCAPTION("Lower Margin"), "Lower Margin", FIELDCAPTION("Upper Margin"), "Upper Margin");
                //HEI.02<<
            end;
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Lower Margin", "Upper Margin")
        {
        }
    }

    var
        LowerMgCntExceedUpperMgErr: Label '%1 %2 cannot be greater than %3 %4.';
        MarginExistsErr: Label '%3 %1 overlaps with Risk Grade %2. Please specify a different margin.';
        NewRecordsNotAllowedErr: Label 'Creating a new %1 is not allowed.';

    local procedure CheckRiskGradesMargins(Margin: Integer; RiskGradeCode: Code[20]);
    var
        RiskGrade: Record "Risk Grade FND";
    begin
        //HEI.02>>
        if RiskGrade.findset() then
            repeat
                if (Margin >= RiskGrade."Lower Margin") and
                   (Margin <= RiskGrade."Upper Margin") and
                   (Margin > 0) and
                   (RiskGradeCode <> RiskGrade.Code)
                then
                    ERROR(MarginExistsErr, RiskGradeCode, RiskGrade.Code, Rec.TABLECAPTION);
            until RiskGrade.NEXT() = 0;
        //HEI.02<<
    end;
}

