page 58148 "Cadency Data_SLBAL"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 21.02.2019
    //   # Created new Page

    // BC Upgrade POENAB02: Original (HeiLite) page id 50309

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Cadency Data FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Editable = false;
    PageType = List;
    SourceTable = "Cadency Data FND";
    SourceTableView = WHERE("File Type" = FILTER(SLBAL));
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
                    ToolTip = 'Entry No. in the file provided by Trintech.';
                }
                field("File Type"; Rec."File Type")
                {
                    ToolTip = 'File Type in the file provided by Trintech.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Company Name in the file provided by Trintech.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'G/L Account No. in the file provided by Trintech.';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ToolTip = 'G/L Account Name in the file provided by Trintech.';
                }
                field(CCY1Code; Rec.CCY1Code)
                {
                    ToolTip = 'CCY1 Code in the file provided by Trintech.';
                }
                field(CCY1SubLedger; Rec.CCY1SubLedger)
                {
                    ToolTip = 'CCY1 SubLedger in the file provided by Trintech.';
                }
                field(CCY2Code; Rec.CCY2Code)
                {
                    ToolTip = 'CCY2 Code in the file provided by Trintech.';
                }
                field(CCY2SubLedger; Rec.CCY2SubLedger)
                {
                    ToolTip = 'CCY2 SubLedger in the file provided by Trintech.';
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'Period in the file provided by Trintech.';
                }
                field(Year; Rec.Year)
                {
                    ToolTip = 'Year in the file provided by Trintech.';
                }
                field("Total Count"; Rec."Total Count")
                {
                    ToolTip = 'Total Count in the file provided by Trintech.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Total Amount in the file provided by Trintech.';
                }
            }
        }
    }

    actions
    {
    }
}

