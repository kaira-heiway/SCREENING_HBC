codeunit 50162 "Truck Movement Process"
{
    // HEI.01 IBM.AK CHG2096760 (HT-1296,Haiti) 12.03.21
    //  # New single Instance Codeunit called from T5766-warehouse activity header

    SingleInstance = true;

    trigger OnRun();
    begin
    end;

    var
        TruckMove: Boolean;

    procedure IsTruckMovTrue(var TruckBool: Boolean);
    begin
        TruckMove := TruckBool;
    end;

    procedure TruckMovTrue(): Boolean;
    var
        TruckMove2: Boolean;
    begin
        TruckMove2 := TruckMove;
        CLEAR(TruckMove);
        exit(TruckMove2);
    end;
}

