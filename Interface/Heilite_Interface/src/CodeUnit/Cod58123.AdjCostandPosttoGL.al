codeunit 58123 "Adj Cost and Post to G/L"
{
    // HEI.01 CHG2098896 IBM POENAB02 18.02.2021 Skip/step over error messages during running an batch job (adjust cost and post cost to G/L)
    //   # Object created
    //Bc Upgrade YADAVM09 old id is-50152.

    TableNo = Item;

    trigger OnRun();
    begin
        Item.SETFILTER("No.", Rec."No.");
        if Item.FINDFIRST then
            repeat
                AdjustCostItemEntriesHL.InitializeRequest(Item."No.", '');
                AdjustCostItemEntriesHL.RUN;
            until Item.NEXT = 0;
    end;

    var
        AdjustCostItemEntriesHL: Report "Adjust Cost - Item Entries HL";
        Item: Record Item;
        RunOk: Boolean;
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        GenJournalLine: Record "Gen. Journal Line";
}

