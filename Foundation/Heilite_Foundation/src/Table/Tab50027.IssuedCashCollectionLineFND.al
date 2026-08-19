table 50027 "Issue Cash Collection Line FND"
{
    // version NAVW19.00,DITW18.00,HEI.02

    // DITW17.10.05 AKH 10/02/2015 DIT-770 #1224 Updated Option Field "Document Type
    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order
    // 
    // HEI.02 FDD OTCGAP022 Heilite BASE IBM ISYED01 17/08/2017
    //   # changed cal formula for feild Disputed (50001).

    Caption = 'Issued Cash Collection Line';

    fields
    {
        field(1; "Cash Collection No."; Code[20])
        {
            Caption = 'Cash Collection No.';
            Description = 'HEI.01';
            TableRelation = "Issue Cash Collection Head FND";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HEI.01';
        }
        field(3; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Description = 'HEI.01';
            TableRelation = "Issue Cash Collection Line FND"."Line No." where("Cash Collection No." = FIELD("Cash Collection No."));
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            Description = 'HEI.01';
            OptionCaption = '" ,Customer Ledger Entry"';
            OptionMembers = " ","Customer Ledger Entry";
        }
        field(5; "Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Entry No.';
            Description = 'HEI.01';
            TableRelation = "Cust. Ledger Entry";

            trigger OnLookup();
            begin
                //HEI.01>>
                if Type <> Type::"Customer Ledger Entry" then
                    exit;
                IssuedCashCollectionHeader.GET("Cash Collection No.");
                CustLedgEntry.SETCURRENTKEY("Customer No.");
                CustLedgEntry.SETRANGE("Customer No.", IssuedCashCollectionHeader."Customer No.");
                if CustLedgEntry.GET("Entry No.") then;
                PAGE.RUNMODAL(0, CustLedgEntry);
                //HEI.01<<
            end;
        }
        field(6; "No. of Reminders"; Integer)
        {
            Caption = 'No. of Reminders';
            Description = 'HEI.01';
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Description = 'HEI.01';
        }
        field(8; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Description = 'HEI.01';
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Description = 'HEI.01';
        }
        field(10; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Description = 'HEI.01';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back";
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Description = 'HEI.01';

            trigger OnLookup();
            begin
                //HEI.01>>
                if Type <> Type::"Customer Ledger Entry" then
                    exit;
                IssuedCashCollectionHeader.GET("Cash Collection No.");
                CustLedgEntry.SETCURRENTKEY("Customer No.");
                CustLedgEntry.SETRANGE("Customer No.", IssuedCashCollectionHeader."Customer No.");
                CustLedgEntry.SETRANGE("Currency Code", IssuedCashCollectionHeader."Currency Code");
                if CustLedgEntry.GET("Entry No.") then;
                PAGE.RUNMODAL(0, CustLedgEntry);
                //HEI.01<<
            end;
        }
        field(12; Description; Text[100])
        {
            Caption = 'Description';
            Description = 'HEI.01';
        }
        field(13; "Original Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCodeFromHeader();
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Original Amount';
            Description = 'HEI.01';
        }
        field(14; "Remaining Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCodeFromHeader();
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Remaining Amount';
            Description = 'HEI.01';
        }
        field(15; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'HEI.01';
            TableRelation = IF (Type = CONST(" ")) "Standard Text";
        }
        field(16; Amount; Decimal)
        {
            AutoFormatExpression = GetCurrencyCodeFromHeader();
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Amount';
            Description = 'HEI.01';
        }
        field(17; "Interest Rate"; Decimal)
        {
            BlankZero = true;
            Caption = 'Interest Rate';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
        }
        field(18; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            Description = 'HEI.01';
            TableRelation = "Gen. Product Posting Group";
        }
        field(19; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
        }
        field(20; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Description = 'HEI.01';
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(21; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCodeFromHeader();
            AutoFormatType = 1;
            Caption = 'VAT Amount';
            Description = 'HEI.01';
        }
        field(22; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            Description = 'HEI.01';
            TableRelation = "Tax Group";
        }
        field(23; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            Description = 'HEI.01';
            TableRelation = "VAT Product Posting Group";
        }
        field(24; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Description = 'HEI.01';
            Editable = false;
        }
        field(25; "Line Type"; Option)
        {
            Caption = 'Line Type';
            Description = 'HEI.01';
            OptionCaption = 'Cash Collection Line,Not Due,Beginning Text,Ending Text,Rounding,On Hold,Additional Fee,Line Fee';
            OptionMembers = "Cash Collection Line","Not Due","Beginning Text","Ending Text",Rounding,"On Hold","Additional Fee","Line Fee";
        }
        field(26; "VAT Clause Code"; Code[10])
        {
            Caption = 'VAT Clause Code';
            Description = 'HEI.01';
            TableRelation = "VAT Clause";
        }
        field(27; "Applies-To Document Type"; Option)
        {
            Caption = 'Applies-To Document Type';
            Description = 'HEI.01';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(28; "Applies-To Document No."; Code[20])
        {
            Caption = 'Applies-To Document No.';
            Description = 'HEI.01';

            trigger OnLookup();
            begin
                //HEI.01>>
                if Type <> Type::"Customer Ledger Entry" then
                    exit;
                IssuedCashCollectionHeader.GET("Cash Collection No.");
                CustLedgEntry.SETCURRENTKEY("Customer No.");
                CustLedgEntry.SETRANGE("Customer No.", IssuedCashCollectionHeader."Customer No.");
                CustLedgEntry.SETRANGE("Document Type", "Applies-To Document Type");
                CustLedgEntry.SETRANGE("Document No.", "Applies-To Document No.");
                if CustLedgEntry.FINDLAST() then;
                PAGE.RUNMODAL(0, CustLedgEntry);
                //HEI.01<<
            end;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50001; Disputed; Boolean)
        {
            CalcFormula = Exist("Dispute Case FND" where("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                      Status = CONST(Open)));
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Disputed Reason code"; Code[10])
        {
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "Cash Collection No.", "Line No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "VAT Amount", "Remaining Amount";
        }
        key(Key2; "Cash Collection No.", Type, "Line Type")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = Amount, "VAT Amount", "Remaining Amount";
        }
    }

    fieldgroups
    {
    }

    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND";
        DisputeCase: Record "Dispute Case FND";

    procedure GetCurrencyCodeFromHeader(): Code[10];
    var
        IssuedReminderHeader: Record "Issued Reminder Header";
    begin
        //HEI.01>>
        if "Cash Collection No." = IssuedCashCollectionHeader."No." then
            exit(IssuedCashCollectionHeader."Currency Code");

        if IssuedCashCollectionHeader.GET("Cash Collection No.") then
            exit(IssuedCashCollectionHeader."Currency Code");

        exit('');
        //HEI.01<<
    end;
}

