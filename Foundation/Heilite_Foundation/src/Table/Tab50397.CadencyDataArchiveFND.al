table 50397 "Cadency Data Archive FND"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 20.02.2019
    //   # Created new table

    // BC Upgrade KUMARS145 Table Created.

    // BC Upgrade POENAB02
    // changed from RtR extension to Interface extension
    // ID changed from 55010 to 58096

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "Cadency Data Archive" to "Cadency Data Archive FND"
    // BC Upgrade PATELP08<<

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "File Type"; Option)
        {
            OptionMembers = GLBAL,GLTRAN,SLBAL;
        }
        field(3; "Header Info"; Text[50])
        {
        }
        field(4; "Company Name"; Code[20])
        {
        }
        field(5; "G/L Account No."; Code[20])
        {
        }
        field(6; "G/L Account Name"; Text[50])
        {
        }
        field(7; EffectiveDate; Date)
        {
        }
        field(8; Date1; Date)
        {
        }
        field(9; CCY1Code; Code[20])
        {
        }
        field(10; CCY1GLEndBalance; Decimal)
        {
        }
        field(11; CCY1SubLedger; Decimal)
        {
        }
        field(12; CCY2Code; Code[20])
        {
        }
        field(13; CCY2Amount; Decimal)
        {
        }
        field(14; CCY2GLEndBalance; Decimal)
        {
        }
        field(15; CCY2SubLedger; Decimal)
        {
        }
        field(16; CCY3Code; Code[10])
        {
        }
        field(17; CCY3GLEndBalance; Code[50])
        {
        }
        field(18; "Document No."; Code[20])
        {
        }
        field(19; Description; Text[50])
        {
        }
        field(20; "Document Type"; Option)
        {
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back","Purchase Receipt","Interest Rate Credit","RPM Damage or Loss","FFE Security Payment";
        }
        field(21; "External Document No."; Code[35])
        {
        }
        field(22; "Customer No."; Code[20])
        {
        }
        field(23; "User ID"; Code[50])
        {
        }
        field(24; Period; Integer)
        {
        }
        field(25; Year; Integer)
        {
        }
        field(26; CCY1NetDebits; Decimal)
        {
        }
        field(27; CCY2NetDebits; Decimal)
        {
        }
        field(28; CCY3NetDebits; Decimal)
        {
        }
        field(29; CCY1NetCredits; Decimal)
        {
        }
        field(30; CCY2NetCredits; Decimal)
        {
        }
        field(31; CCY3NetCredits; Decimal)
        {
        }
        field(32; CCY1TransCount; Integer)
        {
        }
        field(33; CCY2TransCount; Integer)
        {
        }
        field(34; CCY3TransCount; Integer)
        {
        }
        field(35; "Total Count"; Integer)
        {
        }
        field(36; "Total Amount"; Decimal)
        {
        }
        field(37; "Execution Date"; Date)
        {
        }
        field(38; "Date Archived"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

