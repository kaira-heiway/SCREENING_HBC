codeunit 51011 "Blnkt Purch Ord.toRet. Y/N CBN"
{
    // version NAVW13.00

    TableNo = "Purchase Header";

    trigger OnRun();
    begin
        Rec.TESTFIELD("Document Type", Rec."Document Type"::"Blanket Order");
        if not CONFIRM(Text000, false) then
            exit;

        BlanketPurchOrderToOrder.RUN(Rec);
        BlanketPurchOrderToOrder.GetPurchOrderHeader(PurchOrderHeader);

        MESSAGE(
          Text001,
          PurchOrderHeader."No.", Rec."No.");
    end;

    var
        PurchaseHeader: Record "Purchase Header";
        PurchOrderHeader: Record "Purchase Header";
        BlanketPurchOrderToOrder: Codeunit "Blanket Purch. Order to Return";
        Text000: Label 'Do you want to create a return order from the blanket order?';
        Text001: Label 'Return Order %1 has been created from blanket order %2.';
}

