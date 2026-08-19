
reportextension 58001 InsertPriceInfo101FDWExt extends InsertPriceInfo101FDW
{

    // BC Upgrade SHUKLP03 >> Added new procedure to initialize variables and get as per date for price calculation.
    procedure InitVariables()
    begin
        if FORMAT(AsPerDate) = '' then
            AsPerDate := TODAY;
    end;

    procedure GetAsPerDate(): Date
    var
        RunningDate: Date;
    begin
        //HEI.02>>
        RunningDate := AsPerDate;
        //HEI.02<<
    end;
}
