page 58147 "Cadency Data_GLBAL"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 21.02.2019
    //   # Created new Page

    // BC Upgrade POENAB02: Original (HeiLite) page id 50308

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Cadency Data FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Editable = false;
    PageType = List;
    SourceTable = "Cadency Data FND";
    SourceTableView = WHERE("File Type" = FILTER(GLBAL));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    ToolTip = 'Entry No. is the unique identifier for each record and cannot be modified.';
                }
                field("File Type"; Rec."File Type")
                {
                    Editable = false;
                    ToolTip = 'File Type indicates the type of data and cannot be modified.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    Editable = false;
                    ToolTip = 'Company Name indicates the name of the company associated with the record and cannot be modified.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Editable = false;
                    ToolTip = 'G/L Account No. is the general ledger account number and cannot be modified.';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    Editable = false;
                    ToolTip = 'G/L Account Name is the name of the general ledger account and cannot be modified.';
                }
                field(CCY1Code; Rec.CCY1Code)
                {
                    Editable = false;
                    ToolTip = 'CCY1 Code is the currency code for the first currency and cannot be modified.';
                }
                field(CCY1GLEndBalance; Rec.CCY1GLEndBalance)
                {
                    Editable = false;
                    ToolTip = 'CCY1 GL End Balance is the ending balance in the first currency and cannot be modified.';
                }
                field(CCY2Code; Rec.CCY2Code)
                {
                    Editable = false;
                    ToolTip = 'CCY2 Code is the currency code for the second currency and cannot be modified.';
                }
                field(CCY2GLEndBalance; Rec.CCY2GLEndBalance)
                {
                    Editable = false;
                    ToolTip = 'CCY2 GL End Balance is the ending balance in the second currency and cannot be modified.';
                }
                field(CCY3Code; Rec.CCY3Code)
                {
                    Editable = false;
                    ToolTip = 'CCY3 Code is the currency code for the third currency and cannot be modified.';
                }
                field(CCY3GLEndBalance; Rec.CCY3GLEndBalance)
                {
                    Editable = false;
                    ToolTip = 'CCY3 GL End Balance is the ending balance in the third currency and cannot be modified.';
                }
                field(Period; Rec.Period)
                {
                    Editable = false;
                    ToolTip = 'Period indicates the period for the record and cannot be modified.';
                }
                field(Year; Rec.Year)
                {
                    Editable = false;
                    ToolTip = 'Year indicates the year for the record and cannot be modified.';
                }
                field(CCY1NetDebits; Rec.CCY1NetDebits)
                {
                    Editable = false;
                    ToolTip = 'CCY1 Net Debits is the net debit amount in the first currency and cannot be modified.';
                }
                field(CCY2NetDebits; Rec.CCY2NetDebits)
                {
                    Editable = false;
                    ToolTip = 'CCY2 Net Debits is the net debit amount in the second currency and cannot be modified.';
                }
                field(CCY3NetDebits; Rec.CCY3NetDebits)
                {
                    Editable = false;
                    ToolTip = 'CCY3 Net Debits is the net debit amount in the third currency and cannot be modified.';
                }
                field(CCY1NetCredits; Rec.CCY1NetCredits)
                {
                    Editable = false;
                    ToolTip = 'CCY1 Net Credits is the net credit amount in the first currency and cannot be modified.';
                }
                field(CCY2NetCredits; Rec.CCY2NetCredits)
                {
                    Editable = false;
                    ToolTip = 'CCY2 Net Credits is the net credit amount in the second currency and cannot be modified.';
                }
                field(CCY3NetCredits; Rec.CCY3NetCredits)
                {
                    Editable = false;
                    ToolTip = 'CCY3 Net Credits is the net credit amount in the third currency and cannot be modified.';
                }
                field(CCY1TransCount; Rec.CCY1TransCount)
                {
                    Editable = false;
                    ToolTip = 'CCY1 Trans Count is the transaction count in the first currency and cannot be modified.';
                }
                field(CCY2TransCount; Rec.CCY2TransCount)
                {
                    Editable = false;
                    ToolTip = 'CCY2 Trans Count is the transaction count in the second currency and cannot be modified.';
                }
                field(CCY3TransCount; Rec.CCY3TransCount)
                {
                    Editable = false;
                    ToolTip = 'CCY3 Trans Count is the transaction count in the third currency and cannot be modified.';
                }
            }
        }
    }

    actions
    {
    }
}

