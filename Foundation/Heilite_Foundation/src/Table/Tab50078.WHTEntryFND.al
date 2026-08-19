table 50078 "WHT Entry FND"
{
    // version HEI.01,WHT

    // HEI.01 FDD-RTRGAP BRD HT422 - IBM BULIMC01 09/04/2019 # 4 new fields added
    // HEI.02 CHG2057437 IBM POENAB02 28.04.2020 # FDD_HT1104_DRC_WHT functionality enhancement
    //   # New field: 50004 "WHT Bearer"

    // BC Upgrade MISHRS14 >>
    // #Changed length from 50 to 100 and 60 to 100 due to warning in field 50000 and 50001 respectively
    // BC upgrade MISHRS14 <<

    // BC Upgrade PATELP08 >> 
    // Changing Datatype of "Document Type", "Applies-to Doc. Type" from option to Enum, values matched.
    // BC Upgrade PATELP08 <<

    Caption = 'WHT Entry';
    DrillDownPageID = "WHT Entry";
    LookupPageID = "WHT Entry";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.',
                        ENA = 'Entry No.';
            Editable = false;
        }
        field(2; "Gen. Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group',
                        ENA = 'Gen. Bus. Posting Group';
            Editable = false;
            TableRelation = "Gen. Business Posting Group";
        }
        field(3; "Gen. Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group',
                        ENA = 'Gen. Prod. Posting Group';
            Editable = false;
            TableRelation = "Gen. Product Posting Group";
        }
        field(4; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date',
                        ENA = 'Posting Date';
            Editable = false;
        }
        field(5; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        ENA = 'Document No.';
            Editable = false;
        }
        // BC Upgrade PATELP08 >> Changing Datatype of Document Type from option to Enum, values matched.
        // field(6; "Document Type"; Option)
        // {
        //     CaptionML = ENU = 'Document Type',
        //                 ENA = 'Document Type';
        //     Editable = false;
        //     OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund',
        //                       ENA = ' ,Payment,Invoice,CR/Adj Note,Finance Charge Memo,Reminder,Refund';
        //     OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        // }
        field(6; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            Editable = false;
        }
        // BC Upgrade PATELP08 <<
        field(8; Base; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Base',
                        ENA = 'Base';
            Editable = false;
        }
        field(9; Amount; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount',
                        ENA = 'Amount';
            Editable = false;
        }
        field(10; "WHT Calculation Type"; Option)
        {
            CaptionML = ENU = 'WHT Calculation Type',
                        ENA = 'WHT Calculation Type';
            Editable = false;
            OptionCaptionML = ENU = 'Normal WHT,Full WHT',
                              ENA = 'Normal WHT,Full WHT';
            OptionMembers = "Normal WHT","Full WHT";
        }
        field(11; "Currency Code"; Code[10])
        {
            CaptionML = ENU = 'Currency Code',
                        ENA = 'Currency Code';
        }
        field(12; "Bill-to/Pay-to No."; Code[20])
        {
            CaptionML = ENU = 'Bill-to/Pay-to No.',
                        ENA = 'Bill-to/Pay-to No.';
            TableRelation = IF ("Transaction Type" = CONST(Purchase)) Vendor
            else IF ("Transaction Type" = CONST(Sale)) Customer;
        }
        field(14; "User ID"; Code[50])
        {
            CaptionML = ENU = 'User ID',
                        ENA = 'User ID';
            Editable = false;
        }
        field(15; "Source Code"; Code[10])
        {
            CaptionML = ENU = 'Source Code',
                        ENA = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(16; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code',
                        ENA = 'Reason Code';
            Editable = false;
            TableRelation = "Reason Code";
        }
        field(17; "Closed by Entry No."; Integer)
        {
            CaptionML = ENU = 'Closed by Entry No.',
                        ENA = 'Closed by Entry No.';
            Editable = true;
            TableRelation = "WHT Entry FND";
        }
        field(18; Closed; Boolean)
        {
            CaptionML = ENU = 'Closed',
                        ENA = 'Closed';
            Editable = true;
        }
        field(19; "Country/Region Code"; Code[10])
        {
            CaptionML = ENU = 'Country/Region Code',
                        ENA = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate();
            begin
                VALIDATE("Transaction Type");
            end;
        }
        field(21; "Transaction No."; Integer)
        {
            CaptionML = ENU = 'Transaction No.',
                        ENA = 'Transaction No.';
            Editable = false;
        }
        field(22; "Unrealized Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Unrealized Amount',
                        ENA = 'Unrealised Amount';
            Editable = false;
        }
        field(23; "Unrealized Base"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Unrealized Base',
                        ENA = 'Unrealised Base';
            Editable = false;
        }
        field(24; "Remaining Unrealized Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Remaining Unrealized Amount',
                        ENA = 'Remaining Unrealised Amount';
            Editable = false;
        }
        field(25; "Remaining Unrealized Base"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Remaining Unrealized Base',
                        ENA = 'Remaining Unrealised Base';
            Editable = false;
        }
        field(26; "External Document No."; Code[35])
        {
            CaptionML = ENU = 'External Document No.',
                        ENA = 'External Document No.';
            Editable = false;
        }
        field(27; "Transaction Type"; Option)
        {
            CaptionML = ENU = 'Transaction Type',
                        ENA = 'Transaction Type';
            OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement',
                              ENA = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(28; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series',
                        ENA = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(29; "Unrealized WHT Entry No."; Integer)
        {
            CaptionML = ENU = 'Unrealized WHT Entry No.',
                        ENA = 'Unrealised WHT Entry No.';
            Editable = false;
            TableRelation = "WHT Entry FND";
        }
        field(30; "WHT Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'WHT Bus. Posting Group',
                        ENA = 'WHT Bus. Posting Group';
            Editable = false;
            TableRelation = "WHT Business Posting Group FND";
        }
        field(31; "WHT Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'WHT Prod. Posting Group',
                        ENA = 'WHT Prod. Posting Group';
            Editable = false;
            TableRelation = "WHT Product Posting Group FND";
        }
        field(32; "Base (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Base (LCY)',
                        ENA = 'Base (LCY)';
            Editable = false;
        }
        field(33; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount (LCY)',
                        ENA = 'Amount (LCY)';
            Editable = false;
        }
        field(34; "Unrealized Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Unrealized Amount (LCY)',
                        ENA = 'Unrealised Amount (LCY)';
            Editable = false;
        }
        field(35; "Unrealized Base (LCY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Unrealized Base (LCY)',
                        ENA = 'Unrealised Base (LCY)';
            Editable = false;
        }
        field(36; "WHT %"; Decimal)
        {
            CaptionML = ENU = 'WHT %',
                        ENA = 'WHT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(37; "Rem Unrealized Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Rem Unrealized Amount (LCY)',
                        ENA = 'Rem Unrealised Amount (LCY)';
            Editable = false;
        }
        field(38; "Rem Unrealized Base (LCY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CaptionML = ENU = 'Rem Unrealized Base (LCY)',
                        ENA = 'Rem Unrealised Base (LCY)';
            Editable = false;
        }
        field(39; "WHT Difference"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'WHT Difference',
                        ENA = 'WHT Difference';
            Editable = false;
        }
        field(41; "Ship-to/Order Address Code"; Code[10])
        {
            CaptionML = ENU = 'Ship-to/Order Address Code',
                        ENA = 'Ship-to/Order Address Code';
            TableRelation = IF ("Transaction Type" = CONST(Purchase)) "Order Address".Code where("Vendor No." = FIELD("Bill-to/Pay-to No."))
            else IF ("Transaction Type" = CONST(Sale)) "Ship-to Address".Code where("Customer No." = FIELD("Bill-to/Pay-to No."));
        }
        field(42; "Document Date"; Date)
        {
            CaptionML = ENU = 'Document Date',
                        ENA = 'Document Date';
            Editable = false;
        }
        field(44; "Actual Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Actual Vendor No.',
                        ENA = 'Actual Vendor No.';
        }
        field(45; "WHT Certificate No."; Code[20])
        {
            CaptionML = ENU = 'WHT Certificate No.',
                        ENA = 'WHT Certificate No.';
        }
        field(47; "Void Check"; Boolean)
        {
            CaptionML = ENU = 'Void Check',
                        ENA = 'Void Cheque';
        }
        field(48; "Original Document No."; Code[20])
        {
            CaptionML = ENU = 'Original Document No.',
                        ENA = 'Original Document No.';
        }
        field(49; "Void Payment Entry No."; Integer)
        {
            CaptionML = ENU = 'Void Payment Entry No.',
                        ENA = 'Void Payment Entry No.';
        }
        field(50; "WHT Report Line No"; Code[10])
        {
            CaptionML = ENU = 'WHT Report Line No',
                        ENA = 'WHT Report Line No';
        }
        field(51; "WHT Report"; Option)
        {
            CaptionML = ENU = 'WHT Report',
                        ENA = 'WHT Report';
            OptionCaptionML = ENU = ' ,Por Ngor Dor 1,Por Ngor Dor 2,Por Ngor Dor 3,Por Ngor Dor 53,Por Ngor Dor 54',
                              ENA = ' ,Por Ngor Dor 1,Por Ngor Dor 2,Por Ngor Dor 3,Por Ngor Dor 53,Por Ngor Dor 54';
            OptionMembers = " ","Por Ngor Dor 1","Por Ngor Dor 2","Por Ngor Dor 3","Por Ngor Dor 53","Por Ngor Dor 54";
        }
        // BC Upgrade PATELP08 >> Changing Datatype of "Applies-to Doc. Type" from option to Enum, values matched.
        // field(52; "Applies-to Doc. Type"; Option)
        // {
        //     CaptionML = ENU = 'Applies-to Doc. Type',
        //                 ENA = 'Applies-to Doc. Type';
        //     OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund',
        //                       ENA = ' ,Payment,Invoice,CR/Adj Note,Finance Charge Memo,Reminder,Refund';
        //     OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        // }
        field(52; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
        }
        // BC Upgrade PATELP08 <<
        field(53; "Applies-to Doc. No."; Code[20])
        {
            CaptionML = ENU = 'Applies-to Doc. No.',
                        ENA = 'Applies-to Doc. No.';
        }
        field(54; "Applies-to Entry No."; Integer)
        {
            CaptionML = ENU = 'Applies-to Entry No.',
                        ENA = 'Applies-to Entry No.';
        }
        field(55; "WHT Revenue Type"; Code[10])
        {
            CaptionML = ENU = 'WHT Revenue Type',
                        ENA = 'WHT Revenue Type';
            TableRelation = "WHT Revenue Types FND".Code;
        }
        field(56; Settled; Boolean)
        {
            CaptionML = ENU = 'Settled',
                        ENA = 'Settled';
        }
        field(57; "Payment Amount"; Decimal)
        {
            CaptionML = ENU = 'Payment Amount',
                        ENA = 'Payment Amount';
        }
        field(58; "Reversed by Entry No."; Integer)
        {
            CaptionML = ENU = 'Reversed by Entry No.',
                        ENA = 'Reversed by Entry No.';
            TableRelation = "WHT Entry FND"."Entry No.";
        }
        field(59; "Reversed Entry No."; Integer)
        {
            CaptionML = ENU = 'Reversed Entry No.',
                        ENA = 'Reversed Entry No.';
            TableRelation = "WHT Entry FND"."Entry No.";
        }
        field(60; Reversed; Boolean)
        {
            CaptionML = ENU = 'Reversed',
                        ENA = 'Reversed';
        }
        field(61; "Rem Realized Amount"; Decimal)
        {
            CaptionML = ENU = 'Rem Realized Amount',
                        ENA = 'Rem Realised Amount';
            Editable = false;
        }
        field(62; "Rem Realized Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CaptionML = ENU = 'Rem Realized Amount (LCY)',
                        ENA = 'Rem Realised Amount (LCY)';
            Editable = false;
        }
        field(63; "Rem Realized Base"; Decimal)
        {
            CaptionML = ENU = 'Rem Realized Base',
                        ENA = 'Rem Realised Base';
            Editable = false;
        }
        field(64; "Rem Realized Base (LCY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            CaptionML = ENU = 'Rem Realized Base (LCY)',
                        ENA = 'Rem Realised Base (LCY)';
            Editable = false;
        }
        field(65; Prepayment; Boolean)
        {
            CaptionML = ENU = 'Prepayment',
                        ENA = 'Prepayment';
        }
        field(28101; "Pymt. Disc. Diff. Base"; Decimal)
        {
            CaptionML = ENU = 'Pymt. Disc. Diff. Base',
                        ENA = 'Pymt. Disc. Diff. Base';
        }
        field(28102; "Pymt. Disc. Diff. Amount"; Decimal)
        {
            CaptionML = ENU = 'Pymt. Disc. Diff. Amount',
                        ENA = 'Pymt. Disc. Diff. Amount';
        }
        field(50000; "Vendor Name"; Text[100]) // BC Upgrade MISHRS14 >> #Changed length from 50 to 100 due to warning
        {
            CalcFormula = Lookup(Vendor.Name where("No." = FIELD("Bill-to/Pay-to No.")));
            Caption = 'Vendor Name';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Vendor Address"; Text[100]) // BC Upgrade MISHRS14 >> #Changed length from 60 to 100 due to warning
        {
            CalcFormula = Lookup(Vendor.Address where("No." = FIELD("Bill-to/Pay-to No.")));
            Caption = 'Vendor Address';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Vendor Phone Number"; Text[30])
        {
            CalcFormula = Lookup(Vendor."Phone No." where("No." = FIELD("Bill-to/Pay-to No.")));
            Caption = 'Vendor Phone Number';
            Description = 'HEI.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Invoice Payment Date"; Date)
        {
            Caption = 'Invoice Payment Date';
            Description = 'HEI.01';
            Editable = false;
        }
        field(50004; "WHT Bearer"; Option)
        {
            Caption = 'WHT Bearer';
            Description = 'HEI.02';
            Editable = false;
            OptionCaption = 'Vendor,Opco';
            OptionMembers = Vendor,Opco;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Transaction Type", Closed, "WHT Difference", "Amount (LCY)", "Base (LCY)", "Posting Date")
        {
            SumIndexFields = Base, Amount, "Unrealized Amount", "Unrealized Base", "Unrealized Base (LCY)", "Unrealized Amount (LCY)";
        }
        key(Key3; "Transaction Type", "Country/Region Code", "WHT Difference", "Posting Date")
        {
            SumIndexFields = Base;
        }
        key(Key4; "Document No.", "Posting Date")
        {
        }
        key(Key5; "Transaction No.")
        {
        }
        key(Key6; "Amount (LCY)", "Unrealized Amount (LCY)", "Unrealized Base (LCY)", "Base (LCY)", "Posting Date")
        {
        }
        key(Key7; "Document Type", "Document No.")
        {
            SumIndexFields = Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Base (LCY)", "Amount (LCY)", "Unrealized Amount (LCY)", "Unrealized Base (LCY)", "Rem Unrealized Amount (LCY)", "Rem Unrealized Base (LCY)";
        }
        key(Key8; "Transaction Type", "Document No.", "Document Type", "Bill-to/Pay-to No.", Closed)
        {
            SumIndexFields = "Unrealized Base (LCY)";
        }
        key(Key9; "Applies-to Entry No.")
        {
            SumIndexFields = Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Base (LCY)", "Amount (LCY)", "Unrealized Amount (LCY)", "Unrealized Base (LCY)", "Rem Unrealized Amount (LCY)", "Rem Unrealized Base (LCY)";
        }
        key(Key10; "Bill-to/Pay-to No.", "Original Document No.", "WHT Revenue Type")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key11; "Bill-to/Pay-to No.", "WHT Revenue Type", "WHT Prod. Posting Group")
        {
        }
        key(Key12; "Bill-to/Pay-to No.", "WHT Bus. Posting Group", "WHT Revenue Type")
        {
        }
        key(Key13; "Document Type", "Transaction Type", Settled, "WHT Bus. Posting Group", "WHT Prod. Posting Group", "Posting Date")
        {
            SumIndexFields = Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Base (LCY)", "Amount (LCY)", "Unrealized Amount (LCY)", "Unrealized Base (LCY)", "Rem Unrealized Amount (LCY)", "Rem Unrealized Base (LCY)";
        }
        key(Key14; "Posting Date", Settled, "WHT Certificate No.")
        {
            SumIndexFields = Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Base (LCY)", "Amount (LCY)", "Unrealized Amount (LCY)", "Unrealized Base (LCY)", "Rem Unrealized Amount (LCY)", "Rem Unrealized Base (LCY)";
        }
        key(Key15; "Posting Date", "WHT Certificate No.")
        {
            SumIndexFields = Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Base (LCY)", "Amount (LCY)", "Unrealized Amount (LCY)", "Unrealized Base (LCY)", "Rem Unrealized Amount (LCY)", "Rem Unrealized Base (LCY)";
        }
        key(Key16; "Document Type", "Transaction Type", "Bill-to/Pay-to No.", "Transaction No.")
        {
            SumIndexFields = Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Base (LCY)", "Amount (LCY)", "Unrealized Amount (LCY)", "Unrealized Base (LCY)", "Rem Unrealized Amount (LCY)", "Rem Unrealized Base (LCY)";
        }
        key(Key17; "Transaction Type", "Bill-to/Pay-to No.", "Transaction No.")
        {
            SumIndexFields = "Rem Unrealized Amount (LCY)", "Unrealized Base (LCY)";
        }
        key(Key18; "WHT Revenue Type", "Posting Date")
        {
        }
        key(Key19; "Transaction Type", "Bill-to/Pay-to No.")
        {
            SumIndexFields = "Rem Unrealized Amount (LCY)";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Posting Date", "Document No.", Amount)
        {
        }
    }

    var
        GLSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;

    procedure GetCurrencyCode(): Code[10];
    begin
        if not GLSetupRead then begin
            GLSetup.GET();
            GLSetupRead := true;
        end;
        exit(GLSetup."Additional Reporting Currency");
    end;
}

