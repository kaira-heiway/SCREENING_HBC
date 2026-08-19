table 50404 "Cadency Value Buffer FND"
{
    // version HEI.01

    // BC Upgrade POENAB02: Original (HeiLite) table id 50087

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interfaces to Foundation Layer.
    // # Table name changed from "Cadency Value Buffer" to "Cadency Value Buffer FND".
    // BC UPGRADE PATELS08 <<

    fields
    {
        field(1; "G/L Account"; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; "Net Change"; Decimal)
        {
        }
        field(4; "Net Change (LCY)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "G/L Account")
        {
        }
    }

    fieldgroups
    {
    }
}

