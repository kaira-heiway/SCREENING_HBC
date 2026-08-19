table 50036 "HeiMatch Export Buffer FND"
{
    // version IBM 10001,HEI.03

    // HEI.01 FDD RTRGAP062 Heilite BASE IBM ISYED01 04/08/2017 HeiMatch Flatfile
    //   # Table created for HeiMatch FlatFile
    // HEI.02 CHG0248106 IBM POENAB02 15.09.2020 # HeiMatch Export Inv. & Balance
    //   # Modified length of the field "Invoice Reference" from 25 characters to 50 characters
    // HEI.03 CHG2236640 IBM YADAVM09 22/08/2024 # Heimatch flatfile data gathering
    //        # Field Entry No is added as primery key.


    fields
    {
        field(10; "Reporting Entity"; Text[7])
        {
            Caption = 'Reporting Entity';
            Description = 'HEI.01';
        }
        field(20; "Invoice Reference"; Text[50])
        {
            Caption = 'Invoice Reference';
            Description = 'HEI.01 ::only Invoice format, HEI.02';
        }
        field(30; "Period Code"; Code[8])
        {
            Caption = 'Period Code';
            Description = 'HEI.01';
        }
        field(40; "Partner Code"; Code[7])
        {
            Caption = 'Partner Code';
            Description = 'HEI.01';
        }
        field(50; "Account No."; Code[20])
        {
            Caption = 'Account';
            Description = 'HEI.01';
        }
        field(60; "Currency Code"; Code[3])
        {
            Caption = 'Transaction Currency Code';
            Description = 'HEI.01';
        }
        field(70; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Transaction Amount';
            Description = 'HEI.01';
        }
        field(80; "Local Currency Code"; Code[3])
        {
            Caption = 'Local Currency Code';
            Description = 'HEI.01';
        }
        field(90; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Local Amount';
            Description = 'HEI.01';
        }
        field(100; "Invoice Comment"; Text[50])
        {
            Caption = 'Invoice Comment';
            Description = 'HEI.01 :: only Invoice format';
        }
        field(101; "Balance Comment"; Code[10])
        {
            Description = 'HEI.01 :: only Balance format';
        }
        field(110; "Invoice Document Date"; Date)
        {
            Caption = 'Invoice Date';
            Description = 'HEI.01 :: only Invoice format';
        }
        field(120; "Local Company Code"; Code[10])
        {
            Caption = 'Local Company Code';
            Description = 'HEI.01 :: only Invoice format';
        }
        field(121; "Remaining Amt. (LCY)"; Decimal)
        {
            Description = 'HEI.01 :: only Invoice format';
        }
        field(122; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "Period Code", "Invoice Reference", "Partner Code", "Account No.", "Currency Code", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

