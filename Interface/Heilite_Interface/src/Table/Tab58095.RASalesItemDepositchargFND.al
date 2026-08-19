table 58096 "RA Sales Item Depos charge INT"
{
    // BC Upgrade SHUKLP03 >> Created table for sales item charge deposit page webservice. Restuctured code according to new table and field.

    Caption = 'RA Sales Item Deposit charge';
    fields
    {
        field(1; "Item No."; Code[20]) { }
        field(2; "Empty Goods Code"; Code[20]) { }
        field(3; "Qty. Per Base UOM"; Decimal) { }
        field(4; "Last Date Modified"; Date) { }
    }

    keys
    {
        key(PK; "Item No.", "Empty Goods Code")
        {
            Clustered = true;
        }
    }
}

