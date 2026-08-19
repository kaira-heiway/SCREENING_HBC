reportextension 53000 CreateDirectDebitCollectionExt extends "Create Direct Debit Collection"
{
    /* 
     HEI.01 FDD-OTCGAP059 IBM.NAIKH01 10/07/2017-Line items to be marked as processed by DD to avoid doubled proposals.
        # Added Code in Trigger "OnAfterGetRecord()".
        # Added "Dispute Case=CONST(No)" in DataItemTableview property of Cust. Ledger Entry DataItem.
    }
     */
    // BC Upgrade BHARDA11 >>
    // 1. The work that was previously done using the DataItemTableView property has now been implemented by writing code in the OnPreDataItem trigger, since the property cannot be modified.
    // BC Upgrade BHARDA11 <<
    dataset
    {
        modify(Customer)
        {
            trigger OnBeforeAfterGetRecord()
            begin
                //<< HEI.01 NAIKH01
                BlockedReason.RESET;
                BlockedReason.SETRANGE(BlockedReason.Code, Customer."Blocked Reason Code FND");
                BlockedReason.SETRANGE(BlockedReason.Type, BlockedReason.Type::Litigation);
                IF BlockedReason.FINDFIRST THEN
                    CurrReport.SKIP;
                //>> HEI.01 NAIKH01
            end;
        }
        modify("Cust. Ledger Entry")
        {
            trigger OnBeforePreDataItem()
            begin
                SetRange("Dispute Case FND", false); // BC Upgrade BHARAD11 ----This fillter is set in DataItemTableView property
            end;
        }
    }
    var
        BlockedReason: Record "Blocked Reason FND";
        Report76767: Report "Calc. Consumption";
}
