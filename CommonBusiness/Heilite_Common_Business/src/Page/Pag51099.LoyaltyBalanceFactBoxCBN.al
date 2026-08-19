page 51099 "Loyalty Balance FactBox CBN"
{
    // version NRQ151359

    // HEI.01 CHG2059200 IBM SAMANR01 04.22.2020
    //   # Object Created
    // NRQ151359 AKH 17/07/2020 Loyalty enhancement
    //                          Changed type of variable LoyaltyPoint Integer -> Decimal

    // BC Upgrade SHUKLP03 << Blocked procedure UpdateFactBox() because dependency on DIT object "Free Reason Code" and "Loyalty Ledger Entry".

    Caption = 'Loyalty Balance';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Loyalty Free Reason Buffer FND";
    SourceTableView = WHERE(Type = CONST(Loyalty));
    ApplicationArea = ALL;

    layout
    {
        area(content)
        {
            repeater(Control55001)
            {
                field("Free Reason Code"; Rec."Free Reason Code")
                {
                    ApplicationArea = ALL;

                }
                field("Free Reason Description"; Rec."Free Reason Description")
                {
                    ApplicationArea = ALL;

                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = ALL;

                }
                field(Points; Rec.Points)
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }

    actions
    {
    }

    var
        Value: Decimal;
        //FreeReasonCode : Record "Free Reason Code"; // BC Upgrade SHUKLP03 << Blocked as per excel comment "dependency on Aptean".
        Customer: Record Customer;
    //LoyaltyLedgerEntry : Record "Loyalty Ledger Entry"; // BC Upgrade SHUKLP03 << DIT

    local procedure GetCust(pCustomer: Record Customer);
    begin
        Customer := pCustomer;
    end;

    // BC Upgrade SHUKLP03 >> Blocked because dependency on DIT object "Free Reason Code" and "Loyalty Ledger Entry".
    // procedure UpdateFactBox(pCustCode : Code[20]);
    // var
    //     // FreeReasonCode : Record "Free Reason Code"; // BC Upgrade SHUKLP03 << DIT
    //     // LoyaltyLedgerEntry : Record "Loyalty Ledger Entry"; // BC Upgrade SHUKLP03 << Blocked as per excel comment "dependency on Aptean".
    //     LoyaltyFreeReasonBuffer : Record "Loyalty Free Reason Buffer FND";
    //     LoyaltyAmt : Decimal;
    //     LoyaltyPoint : Decimal;
    // begin
    //     //HEI.01>>
    //     LoyaltyFreeReasonBuffer.DELETEALL;
    //     FreeReasonCode.RESET;
    //     FreeReasonCode.SETRANGE(FreeReasonCode.Type,FreeReasonCode.Type::Loyalty);
    //     if FreeReasonCode.FINDSET then repeat
    //       LoyaltyAmt := 0;
    //       LoyaltyPoint := 0;
    //       LoyaltyLedgerEntry.RESET;
    //       LoyaltyLedgerEntry.SETCURRENTKEY("Source Type","Source No.","Free Reason Code","Loyalty Type");
    //       LoyaltyLedgerEntry.SETRANGE("Source Type",LoyaltyLedgerEntry."Source Type"::Customer);
    //       LoyaltyLedgerEntry.SETRANGE("Source No.",pCustCode);
    //       LoyaltyLedgerEntry.SETRANGE("Free Reason Code",FreeReasonCode.Code);
    //       if LoyaltyLedgerEntry.FINDSET then repeat
    //         if LoyaltyLedgerEntry."Loyalty Type" = LoyaltyLedgerEntry."Loyalty Type"::Point then
    //           LoyaltyPoint += LoyaltyLedgerEntry."Point Amount (Actual)";
    //         if LoyaltyLedgerEntry."Loyalty Type" = LoyaltyLedgerEntry."Loyalty Type"::Amount then
    //           LoyaltyAmt += LoyaltyLedgerEntry."Sales Amount (Actual)";
    //       until LoyaltyLedgerEntry.NEXT=0;
    //       LoyaltyFreeReasonBuffer.INIT;
    //       LoyaltyFreeReasonBuffer."Customer No." := pCustCode;
    //       LoyaltyFreeReasonBuffer."Free Reason Code" := FreeReasonCode.Code;
    //       LoyaltyFreeReasonBuffer."Free Reason Description" := FreeReasonCode.Description;
    //       LoyaltyFreeReasonBuffer.Amount := LoyaltyAmt;
    //       LoyaltyFreeReasonBuffer.Points := LoyaltyPoint;
    //       LoyaltyFreeReasonBuffer.Type := FreeReasonCode.Type;
    //       LoyaltyFreeReasonBuffer.INSERT;
    //     until FreeReasonCode.NEXT=0;
    //     //HEI.01<<
    // end;
    // BC Upgrade SHUKLP03 << Blocked because dependency on DIT object "Free Reason Code" and "Loyalty Ledger Entry".
}

