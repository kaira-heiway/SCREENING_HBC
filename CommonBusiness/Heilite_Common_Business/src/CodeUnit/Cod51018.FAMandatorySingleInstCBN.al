codeunit 51018 "FA Mandatory Single Inst. CBN"
{
    // version HEI.02

    // 
    // HEI.01  YADAVM05 10.03.2023 CHG2187935_HB3211 code added to skip CMG Mandatory check on report
    // HEI.02  YADAVM05 29.03.2023 Changing Documentation from CHG2187935_HB3211 to CHG2198032_HB3211

    SingleInstance = true;

    trigger OnRun();
    begin
    end;

    var
        FAReport: Report "Fixed Asset - Book Value 01";
        Flag: Boolean;

    procedure InitalizeFA(var IntializeValue: Boolean);
    begin
        Flag := IntializeValue;
    end;

    procedure AssignFAvalue(): Boolean;
    begin
        exit(Flag);
    end;
}

