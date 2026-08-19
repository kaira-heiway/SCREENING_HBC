report 54049 "Fix Bin Content Zone"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    trigger OnPostReport()
    var
        BinContent: Record "Bin Content";
        Bin: Record Bin;
    begin
        BinContent.SetRange("Zone Code", '');
        if BinContent.FindSet() then
            repeat
                BinContent.CalcFields("Quantity (Base)");
                if BinContent."Quantity (Base)" = 0 then
                    BinContent.Delete()
                else begin
                    if Bin.Get(BinContent."Location Code", BinContent."Bin Code") then begin
                        BinContent.Validate("Zone Code", Bin."Zone Code");
                        BinContent.Modify(true);
                    end;
                end;
            until BinContent.Next() = 0;
    end;
}