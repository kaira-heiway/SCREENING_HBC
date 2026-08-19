codeunit 51012 "Auto Release Sales Orders CBN"
{
    // version HEI.02

    // HEI.01 FDD-OTCGAP016C IBM NASTAA02 06.12.2017 # Credit Control Check
    //   # New Codeunit created to be used for scheduling the releasing of the Sales Orders
    // HEI.02 Defect #1413 IBM NASTAA02 22.01.2018 # PCV/FFE block
    //   # Extra checks added when releasing the Sales Orders
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Field("Sundry Customer") and Function (TestSundryMandatoryFields)
    // BC Upgrade BHARDA11 <<

    TableNo = "Sales Header";

    trigger OnRun();
    begin
        //HEI.02>>
        Rec.CheckForLinkSalesDocument(Rec);
        // BC Upgrade BHARDA11 >> ---Drink-IT Field("Sundry Customer") and Function (TestSundryMandatoryFields)
        // IF Rec."Sundry Customer" THEN
        //   Rec.TestSundryMandatoryFields();
        // BC Upgrade BHARDA11 << ---Drink-IT Field("Sundry Customer") and Function (TestSundryMandatoryFields)

        HeinekenGlobal.CheckPCVNBalance(Rec);
        //HEI.02<<
        ReleaseSalesDoc.PerformManualRelease(Rec);
    end;

    var
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        HeinekenGlobal: Codeunit "Heineken Global";
}

