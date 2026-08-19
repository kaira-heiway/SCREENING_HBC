page 58149 "Cadency Data Archive"
{
    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 ,08.03.2019
    //   # Created new Page

    // BC Upgrade POENAB02: Original (HeiLite) page id 50316

    // BC Upgrade PATELP08>>
    // Changed name of table from "Cadency Data Archive" to "Cadency Data Archive FND"
    // BC Upgrade PATELP08<<
    
    PageType = List;
    SourceTable = "Cadency Data Archive FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Type"; Rec."File Type")
                {
                    ToolTip = 'Type of the file generated for Cadency, such as Trial Balance, Subledger Detail, etc.';
                }
                field("Header Info"; Rec."Header Info")
                {
                    ToolTip = 'Additional information about the file, such as the period or other relevant details.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Name of the company for which the data was archived.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'Number of the general ledger account.';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ToolTip = 'Name of the general ledger account.';
                }
                field(EffectiveDate; Rec.EffectiveDate)
                {
                    ToolTip = 'The date when the data became effective.';
                }
                field(Date1; Rec.Date1)
                {
                    ToolTip = 'The first date field for the record';
                }
                field(CCY1Code; Rec.CCY1Code)
                {
                    ToolTip = 'The code of the first currency used in the record.';
                }
                field(CCY1GLEndBalance; Rec.CCY1GLEndBalance)
                {
                    ToolTip = 'The ending balance in the general ledger for the first currency.';
                }
                field(CCY1SubLedger; Rec.CCY1SubLedger)
                {
                    ToolTip = 'The subledger information for the first currency.';
                }
                field(CCY2Code; Rec.CCY2Code)
                {
                    ToolTip = 'The code of the second currency used in the record.';
                }
                field(CCY2Amount; Rec.CCY2Amount)
                {
                    ToolTip = 'The amount in the second currency for the record.';
                }
                field(CCY2GLEndBalance; Rec.CCY2GLEndBalance)
                {
                    ToolTip = 'The ending balance in the general ledger for the second currency.';
                }
                field(CCY2SubLedger; Rec.CCY2SubLedger)
                {
                    ToolTip = 'The subledger information for the second currency.';
                }
                field(CCY3Code; Rec.CCY3Code)
                {
                    ToolTip = 'The code of the third currency used in the record.';
                }
                field(CCY3GLEndBalance; Rec.CCY3GLEndBalance)
                {
                    ToolTip = 'The ending balance in the general ledger for the third currency.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'The number of the document associated with the record.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description of the record.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'The type of the document associated with the record.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'The external document number associated with the record.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'The number of the customer associated with the record.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'The ID of the user who created or modified the record.';
                }
                field(Period; Rec.Period)
                {
                    ToolTip = 'The period for which the data is relevant, such as a fiscal period.';
                }
                field(Year; Rec.Year)
                {
                    ToolTip = 'The year for which the data is relevant.';
                }
                field(CCY1NetDebits; Rec.CCY1NetDebits)
                {
                    ToolTip = 'The net debits in the first currency for the record.';
                }
                field(CCY2NetDebits; Rec.CCY2NetDebits)
                {
                    ToolTip = 'The net debits in the second currency for the record.';
                }
                field(CCY3NetDebits; Rec.CCY3NetDebits)
                {
                    ToolTip = 'The net debits in the third currency for the record.';
                }
                field(CCY1NetCredits; Rec.CCY1NetCredits)
                {
                    ToolTip = 'The net credits in the first currency for the record.';
                }
                field(CCY2NetCredits; Rec.CCY2NetCredits)
                {
                    ToolTip = 'The net credits in the second currency for the record.';
                }
                field(CCY3NetCredits; Rec.CCY3NetCredits)
                {
                    ToolTip = 'The net credits in the third currency for the record.';
                }
                field(CCY1TransCount; Rec.CCY1TransCount)
                {
                    ToolTip = 'The transaction count in the first currency for the record.';
                }
                field(CCY2TransCount; Rec.CCY2TransCount)
                {
                    ToolTip = 'The transaction count in the second currency for the record.';
                }
                field(CCY3TransCount; Rec.CCY3TransCount)
                {
                    ToolTip = 'The transaction count in the third currency for the record.';
                }
                field("Total Count"; Rec."Total Count")
                {
                    ToolTip = 'The total transaction count for the record.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'The total amount for the record.';
                }
                field("Execution Date"; Rec."Execution Date")
                {
                    ToolTip = 'The date when the data was executed or generated.';
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ToolTip = 'The date when the data was archived.';
                }
            }
        }
    }

    actions
    {
    }
}

