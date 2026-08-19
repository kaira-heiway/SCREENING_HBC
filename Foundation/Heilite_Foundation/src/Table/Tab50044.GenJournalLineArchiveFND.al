table 50044 "Gen. Journal Line Archive FND"
{
    // version NAVW110.0.00.16996,FINXL10.01,DITW110.00.10,HEI.06

    // HEI.04 PTPGAP068 IBM COSTES02 18.08.2017 Payment Proposal grouping/archiving
    //   # New table created based on standard table Gen Journal Line
    // HEI.05 FDD-KDD0TC002 IBM HORTOC01 04.10.2017 - new option on "Document type" field - "Interest Rate Credit"
    // HEI.06 PTPGAP083 IBM NASTAA02 05.03.2018 # Mark Reversed Rejected Payments
    //   # New Field created: 50029 - Reversed
    // HEI.07 PTPGAP077 - IBM HORTOC01 23.03.2018
    //   #new fields

    //SHIKHD02>>
    //1.Updated FlowField "Vendor Name" length from Text[50] to Text[100] to remove warning
    //2.Updated FlowField "Vendor Bank Acc. Name" length from Text[50] to Text[100] to remove warning
    //SHIKHD02<<


    Caption = 'Gen. Journal Line Archive';
    Permissions = TableData "Data Exch. Field" = rimd;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            /*
            TableRelation = IF ("Account Type"=CONST("G/L Account")) "G/L Account" WHERE ("Account Type"=CONST(Posting),
                                                                                          Blocked=CONST(false),
                                                                                          "DIT Sub-Contract Posting Type"=FIELD("DIT Sub-Contr.Pst. Type Filter"))
                                                                                          else IF ("Account Type"=CONST(Customer)) Customer
                                                                                          else IF ("Account Type"=CONST(Vendor)) Vendor
                                                                                          else IF ("Account Type"=CONST("Bank Account")) "Bank Account"
                                                                                          else IF ("Account Type"=CONST("Fixed Asset")) "Fixed Asset" WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contr.Pst. Type Filter"))
                                                                                          else IF ("Account Type"=CONST("IC Partner")) "IC Partner";*/  // BC Upgrade NANDIS03 
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
        }
        field(6; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Description = 'HEI.05';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss,FFE Security Payment"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back","Purchase Receipt","Interest Rate Credit","RPM Damage or Loss","FFE Security Payment";

            trigger OnValidate();
            var
                Cust: Record Customer;
                Vend: Record Vendor;
            begin
            end;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(11; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" where("Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            else IF ("Bal. Account Type" = CONST(Customer)) Customer
            else IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            else IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            else IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            else IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate();
            var
                BankAcc: Record "Bank Account";
            begin
            end;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(14; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
        }
        field(15; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(17; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            Editable = false;
        }
        field(18; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(19; "Sales/Purch. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales/Purch. (LCY)';
        }
        field(20; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Profit (LCY)';
        }
        field(21; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
        }
        field(22; "Bill-to/Pay-to No."; Code[20])
        {
            Caption = 'Bill-to/Pay-to No.';
            Editable = false;
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer
            else IF ("Bal. Account Type" = CONST(Customer)) Customer
            else IF ("Account Type" = CONST(Vendor)) Vendor
            else IF ("Bal. Account Type" = CONST(Vendor)) Vendor;
        }
        field(23; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = true;
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group"
            else IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group"
            else IF ("Account Type" = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(1));
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(2));
        }
        field(26; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(30; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(34; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(35; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back";
        }
        field(36; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup();
            var
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
                AccNo: Code[20];
                AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
            begin
            end;

            trigger OnValidate();
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                TempGenJnlLine: Record "Gen. Journal Line" temporary;
                VendLedgEntry: Record "Vendor Ledger Entry";
            begin
            end;
        }
        field(38; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(39; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(40; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(42; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(43; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(44; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(45; "VAT Posting"; Option)
        {
            Caption = 'VAT Posting';
            Editable = false;
            OptionCaption = 'Automatic VAT Entry,Manual VAT Entry';
            OptionMembers = "Automatic VAT Entry","Manual VAT Entry";
        }
        field(47; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(48; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';
        }
        field(50; "Business Unit Code"; Code[10])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
        }
        field(51; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(52; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(53; "Recurring Method"; Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method';
            OptionCaption = '" ,F  Fixed,V  Variable,B  Balance,RF Reversing Fixed,RV Reversing Variable,RB Reversing Balance"';
            OptionMembers = " ","F  Fixed","V  Variable","B  Balance","RF Reversing Fixed","RV Reversing Variable","RB Reversing Balance";
        }
        field(54; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(55; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
        }
        field(56; "Allocated Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Gen. Jnl. Allocation".Amount where("Journal Template Name" = FIELD("Journal Template Name"),
                                                                   "Journal Batch Name" = FIELD("Journal Batch Name"),
                                                                   "Journal Line No." = FIELD("Line No.")));
            Caption = 'Allocated Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = '" ,Purchase,Sale,Settlement"';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(58; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(59; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(60; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(61; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
            Editable = false;
        }
        field(62; "Allow Application"; Boolean)
        {
            Caption = 'Allow Application';
            InitValue = true;
        }
        field(63; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(64; "Bal. Gen. Posting Type"; Option)
        {
            Caption = 'Bal. Gen. Posting Type';
            OptionCaption = '" ,Purchase,Sale,Settlement"';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(65; "Bal. Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Bal. Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(66; "Bal. Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Bal. Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(67; "Bal. VAT Calculation Type"; Option)
        {
            Caption = 'Bal. VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(68; "Bal. VAT %"; Decimal)
        {
            Caption = 'Bal. VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(69; "Bal. VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount';
        }
        field(70; "Bank Payment Type"; Option)
        {
            AccessByPermission = TableData "Bank Account" = R;
            Caption = 'Bank Payment Type';
            OptionCaption = '" ,Computer Check,Manual Check"';
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(71; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
        }
        field(72; "Bal. VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount';
        }
        field(73; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(75; "Check Printed"; Boolean)
        {
            AccessByPermission = TableData "Check Ledger Entry" = R;
            Caption = 'Check Printed';
            Editable = false;
        }
        field(76; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
        }
        field(77; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(78; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = '" ,Customer,Vendor,Bank Account,Fixed Asset"';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(79; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            else IF ("Source Type" = CONST(Vendor)) Vendor
            else IF ("Source Type" = CONST("Bank Account")) "Bank Account"
            else IF ("Source Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(80; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(82; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(83; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(84; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(85; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(86; "Bal. Tax Area Code"; Code[20])
        {
            Caption = 'Bal. Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(87; "Bal. Tax Liable"; Boolean)
        {
            Caption = 'Bal. Tax Liable';
        }
        field(88; "Bal. Tax Group Code"; Code[10])
        {
            Caption = 'Bal. Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(89; "Bal. Use Tax"; Boolean)
        {
            Caption = 'Bal. Use Tax';
        }
        field(90; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(91; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(92; "Bal. VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'Bal. VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(93; "Bal. VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'Bal. VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(95; "Additional-Currency Posting"; Option)
        {
            Caption = 'Additional-Currency Posting';
            Editable = false;
            OptionCaption = 'None,Amount Only,Additional-Currency Amount Only';
            OptionMembers = "None","Amount Only","Additional-Currency Amount Only";
        }
        field(98; "FA Add.-Currency Factor"; Decimal)
        {
            Caption = 'FA Add.-Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(99; "Source Currency Code"; Code[10])
        {
            Caption = 'Source Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(100; "Source Currency Amount"; Decimal)
        {
            AccessByPermission = TableData Currency = R;
            AutoFormatType = 1;
            Caption = 'Source Currency Amount';
            Editable = false;
        }
        field(101; "Source Curr. VAT Base Amount"; Decimal)
        {
            AccessByPermission = TableData Currency = R;
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Base Amount';
            Editable = false;
        }
        field(102; "Source Curr. VAT Amount"; Decimal)
        {
            AccessByPermission = TableData Currency = R;
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Amount';
            Editable = false;
        }
        field(103; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(104; "VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Amount (LCY)';
            Editable = false;
        }
        field(105; "VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Base Amount (LCY)';
            Editable = false;
        }
        field(106; "Bal. VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount (LCY)';
            Editable = false;
        }
        field(107; "Bal. VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount (LCY)';
            Editable = false;
        }
        field(108; "Reversing Entry"; Boolean)
        {
            Caption = 'Reversing Entry';
            Editable = false;
        }
        field(109; "Allow Zero-Amount Posting"; Boolean)
        {
            Caption = 'Allow Zero-Amount Posting';
            Editable = false;
        }
        field(110; "Ship-to/Order Address Code"; Code[10])
        {
            Caption = 'Ship-to/Order Address Code';
            TableRelation = IF ("Account Type" = CONST(Customer)) "Ship-to Address".Code where("Customer No." = FIELD("Bill-to/Pay-to No."))
            else IF ("Account Type" = CONST(Vendor)) "Order Address".Code where("Vendor No." = FIELD("Bill-to/Pay-to No."))
            else IF ("Bal. Account Type" = CONST(Customer)) "Ship-to Address".Code where("Customer No." = FIELD("Bill-to/Pay-to No."))
            else IF ("Bal. Account Type" = CONST(Vendor)) "Order Address".Code where("Vendor No." = FIELD("Bill-to/Pay-to No."));
        }
        field(111; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(112; "Bal. VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Difference';
            Editable = false;
        }
        field(113; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(114; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(116; "IC Partner G/L Acc. No."; Code[20])
        {
            Caption = 'IC Partner G/L Acc. No.';
            TableRelation = "IC G/L Account";

            trigger OnValidate();
            var
                ICGLAccount: Record "IC G/L Account";
            begin
            end;
        }
        field(117; "IC Partner Transaction No."; Integer)
        {
            Caption = 'IC Partner Transaction No.';
            Editable = false;
        }
        field(118; "Sell-to/Buy-from No."; Code[20])
        {
            Caption = 'Sell-to/Buy-from No.';
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer
            else IF ("Bal. Account Type" = CONST(Customer)) Customer
            else IF ("Account Type" = CONST(Vendor)) Vendor
            else IF ("Bal. Account Type" = CONST(Vendor)) Vendor;
        }
        field(119; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate();
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
            end;
        }
        field(120; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(121; Prepayment; Boolean)
        {
            Caption = 'Prepayment';
        }
        field(122; "Financial Void"; Boolean)
        {
            Caption = 'Financial Void';
            Editable = false;
        }
        field(165; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            TableRelation = "Incoming Document";

            trigger OnValidate();
            var
                IncomingDocument: Record "Incoming Document";
            begin
            end;
        }
        field(170; "Creditor No."; Code[20])
        {
            Caption = 'Creditor No.';
            Numeric = true;
        }
        field(171; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference';
            Numeric = true;
        }
        field(172; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(173; "Applies-to Ext. Doc. No."; Code[35])
        {
            Caption = 'Applies-to Ext. Doc. No.';
        }
        field(288; "Recipient Bank Account"; Code[10])
        {
            Caption = 'Recipient Bank Account';
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Bank Account".Code where("Customer No." = FIELD("Account No."))
            else IF ("Account Type" = CONST(Vendor)) "Vendor Bank Account".Code where("Vendor No." = FIELD("Account No."))
            else IF ("Bal. Account Type" = CONST(Customer)) "Customer Bank Account".Code where("Customer No." = FIELD("Bal. Account No."))
            else IF ("Bal. Account Type" = CONST(Vendor)) "Vendor Bank Account".Code where("Vendor No." = FIELD("Bal. Account No."));
        }
        field(289; "Message to Recipient"; Text[140])
        {
            Caption = 'Message to Recipient';
        }
        field(290; "Exported to Payment File"; Boolean)
        {
            Caption = 'Exported to Payment File';
            Editable = false;
        }
        field(291; "Has Payment Export Error"; Boolean)
        {
            CalcFormula = Exist("Payment Jnl. Export Error Text" where("Journal Template Name" = FIELD("Journal Template Name"),
                                                                        "Journal Batch Name" = FIELD("Journal Batch Name"),
                                                                        "Journal Line No." = FIELD("Line No.")));
            Caption = 'Has Payment Export Error';
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(827; "Credit Card No."; Code[20])
        {
            Caption = 'Credit Card No.';
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = FIELD("Job No."));
        }
        field(1002; "Job Unit Price (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 2;
            Caption = 'Job Unit Price (LCY)';
            Editable = false;
        }
        field(1003; "Job Total Price (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 1;
            Caption = 'Job Total Price (LCY)';
            Editable = false;
        }
        field(1004; "Job Quantity"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            Caption = 'Job Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(1005; "Job Unit Cost (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 2;
            Caption = 'Job Unit Cost (LCY)';
            Editable = false;
        }
        field(1006; "Job Line Discount %"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 1;
            Caption = 'Job Line Discount %';
        }
        field(1007; "Job Line Disc. Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Job Line Disc. Amount (LCY)';
            Editable = false;
        }
        field(1008; "Job Unit Of Measure Code"; Code[10])
        {
            Caption = 'Job Unit Of Measure Code';
            TableRelation = "Unit of Measure";
        }
        field(1009; "Job Line Type"; Option)
        {
            AccessByPermission = TableData Job = R;
            Caption = 'Job Line Type';
            OptionCaption = '" ,Budget,Billable,Both Budget and Billable"';
            OptionMembers = " ",Budget,Billable,"Both Budget and Billable";
        }
        field(1010; "Job Unit Price"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 2;
            Caption = 'Job Unit Price';
        }
        field(1011; "Job Total Price"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Total Price';
            Editable = false;
        }
        field(1012; "Job Unit Cost"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 2;
            Caption = 'Job Unit Cost';
            Editable = false;
        }
        field(1013; "Job Total Cost"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Total Cost';
            Editable = false;
        }
        field(1014; "Job Line Discount Amount"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Line Discount Amount';
        }
        field(1015; "Job Line Amount"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Line Amount';
        }
        field(1016; "Job Total Cost (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 1;
            Caption = 'Job Total Cost (LCY)';
            Editable = false;
        }
        field(1017; "Job Line Amount (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 1;
            Caption = 'Job Line Amount (LCY)';
            Editable = false;
        }
        field(1018; "Job Currency Factor"; Decimal)
        {
            Caption = 'Job Currency Factor';
        }
        field(1019; "Job Currency Code"; Code[10])
        {
            Caption = 'Job Currency Code';
        }
        field(1020; "Job Planning Line No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            BlankZero = true;
            Caption = 'Job Planning Line No.';

            trigger OnLookup();
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;

            trigger OnValidate();
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;
        }
        field(1030; "Job Remaining Qty."; Decimal)
        {
            AccessByPermission = TableData Job = R;
            Caption = 'Job Remaining Qty.';
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;
        }
        field(1200; "Direct Debit Mandate ID"; Code[35])
        {
            Caption = 'Direct Debit Mandate ID';
            TableRelation = IF ("Account Type" = CONST(Customer)) "SEPA Direct Debit Mandate" where("Customer No." = FIELD("Account No."));

            trigger OnValidate();
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            begin
            end;
        }
        field(1220; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.';
            Editable = false;
            TableRelation = "Data Exch.";
        }
        field(1221; "Payer Information"; Text[50])
        {
            Caption = 'Payer Information';
        }
        field(1222; "Transaction Information"; Text[100])
        {
            Caption = 'Transaction Information';
        }
        field(1223; "Data Exch. Line No."; Integer)
        {
            Caption = 'Data Exch. Line No.';
            Editable = false;
        }
        field(1224; "Applied Automatically"; Boolean)
        {
            Caption = 'Applied Automatically';
        }
        field(1700; "Deferral Code"; Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";

            trigger OnValidate();
            var
                DeferralUtilities: Codeunit "Deferral Utilities";
            begin
            end;
        }
        field(1701; "Deferral Line No."; Integer)
        {
            Caption = 'Deferral Line No.';
        }
        field(5044; "Time Archived"; Time)
        {
            Caption = 'Time Archived';
            Description = 'HEI.04';
        }
        field(5045; "Date Archived"; Date)
        {
            Caption = 'Date Archived';
            Description = 'HEI.04';
        }
        field(5046; "Archived By"; Code[50])
        {
            Caption = 'Archived By';
            Description = 'HEI.04';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup();
            var
                //UserMgt: Codeunit "User Management";  // BC Upgrade NANDIS03
                UserSelection: Codeunit "User Selection";  // BC Upgrade NANDIS03
            begin
                //UserMgt.LookupUserID("Archived By");  // BC Upgrade NANDIS03

            end;
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
            Description = 'HEI.04';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
        }
        field(5400; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Editable = false;
        }
        field(5600; "FA Posting Date"; Date)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Posting Date';
        }
        field(5601; "FA Posting Type"; Option)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Posting Type';
            OptionCaption = '" ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance"';
            OptionMembers = " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";

            trigger OnValidate();
            var
                FADeprBook: Record "FA Depreciation Book";
            begin
            end;
        }
        field(5603; "Salvage Value"; Decimal)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            AutoFormatType = 1;
            Caption = 'Salvage Value';
        }
        field(5604; "No. of Depreciation Days"; Integer)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            BlankZero = true;
            Caption = 'No. of Depreciation Days';
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'Depr. until FA Posting Date';
        }
        field(5606; "Depr. Acquisition Cost"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'Depr. Acquisition Cost';
        }
        field(5609; "Maintenance Code"; Code[10])
        {
            Caption = 'Maintenance Code';
            TableRelation = Maintenance;
        }
        field(5610; "Insurance No."; Code[20])
        {
            Caption = 'Insurance No.';
            TableRelation = Insurance;
        }
        field(5611; "Budgeted FA No."; Code[20])
        {
            Caption = 'Budgeted FA No.';
            TableRelation = "Fixed Asset";

            trigger OnValidate();
            var
                FA: Record "Fixed Asset";
            begin
            end;
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'Use Duplication List';
        }
        field(5614; "FA Reclassification Entry"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Reclassification Entry';
        }
        field(5615; "FA Error Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'FA Error Entry No.';
            TableRelation = "FA Ledger Entry";
        }
        field(5616; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
        }
        field(5617; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
        }
        field(5618; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(50000; "CV Detailed Entry No."; Integer)
        {
            Description = 'HEI.01';
        }
        field(50001; "Vendor Bank Account"; Code[10])
        {
            Caption = 'Vendor Bank Account';
            Description = 'HEI.02 PTPGAP066';
            TableRelation = IF ("Account Type" = FILTER(Vendor)) "Vendor Bank Account".Code where("Vendor No." = FIELD("Account No."));
        }
        field(50002; "Adj. Exchange Rate Type"; Option)
        {
            Description = 'HEI.01';
            OptionMembers = " ",Bank,Customer,Vendor;
        }
        field(50003; "Batch payment name"; Code[30])
        {
            Description = 'HEI.03';
        }
        field(50004; "Tree Level"; Integer)
        {
            Caption = 'Tree Level';
            Description = 'HEI.04';
        }
        field(50005; "Archive Document No."; Code[20])
        {
            Caption = 'Archive Document No.';
            Description = 'HEI.04';
        }
        field(50006; "Parent Line No."; Integer)
        {
            Description = 'HEI.04';
        }
        field(50029; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Description = 'HEI.06';
            Editable = false;
        }
        //SHIKHD02>>
        //Updated FlowField "Vendor Name" length from Text[50] to Text[100] to remove warning
        field(50034; "Vendor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name where("No." = FIELD("Account No.")));
            Caption = 'Vendor Name';
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        //SHIKHD02<<

        //SHIKHD02>>
        //Updated FlowField "Vendor Bank Acc. Name" length from Text[50] to Text[100] to remove warning
        field(50035; "Vendor Bank Acc. Name"; Text[100])
        {
            CalcFormula = Lookup("Vendor Bank Account".Name where(Code = FIELD("Vendor Bank Account"),
                                                                   "Vendor No." = FIELD("Account No.")));
            Caption = 'Vendor Bank Acc. Name';
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        //SHIKHD02<<
        field(50036; "Vendor Bank Acc. Branch No."; Text[20])
        {
            CalcFormula = Lookup("Vendor Bank Account"."Bank Branch No." where("Vendor No." = FIELD("Account No."),
                                                                                Code = FIELD("Vendor Bank Account")));
            Caption = 'Vendor Bank Acc. Branch No.';
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        field(50037; "Vendor Bank Acc. No."; Text[30])
        {
            CalcFormula = Lookup("Vendor Bank Account"."Bank Account No." where("Vendor No." = FIELD("Account No."),
                                                                                 Code = FIELD("Vendor Bank Account")));
            Caption = 'Vendor Bank Acc. No.';
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        field(50038; "Vandor Bank Acc. Swift Code"; Code[20])
        {
            CalcFormula = Lookup("Vendor Bank Account"."SWIFT Code" where("Vendor No." = FIELD("Account No."),
                                                                           Code = FIELD("Vendor Bank Account")));
            Caption = 'Vandor Bank Acc. Swift Code';
            Description = 'HEI.07';
            FieldClass = FlowField;
        }
        field(50043; "HNK Bank Account"; Code[20])
        {
            Description = 'HEI.08';
            TableRelation = "Bank Account";
        }
        field(50044; "HNK Check No."; Code[20])
        {
            Description = 'HEI.08';
        }
        // field(2013610; "Cust/Vendor Deposit Group Code"; Code[10])
        // {
        //     Caption = 'Cust/Vend DepositChrg.Gr. Code';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code where("Source Type" = FIELD("Source Type"));
        // }
        // field(2013611; "Deposit Amount"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     Caption = 'Deposit Amount';
        //     Description = 'DITW16.00.00.43 DIT-715 #678';
        // }
        // field(2013612; "Deposit Amount (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Deposit Amount (LCY)';
        //     Description = 'DITW16.00.00.43 DIT-715 #678';
        // }
        // field(2013667; "Cust/Vendor DTax Group Code"; Code[10])
        // {
        //     Caption = 'Cust/Vendor Tax Group Code';
        //     Description = 'DITW15.00.00.01';
        //     //TableRelation = "Drink Tax Group".Code where("Source Type" = FIELD("Source Type"));   // BC Upgrade NANDIS03
        // }
        // field(2013695; "Item Charge Type"; Option)
        // {
        //     Caption = 'Item Charge Type';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     OptionCaption = '" ,,Deposit"';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013726; "Cust/Vend Tax Registration No."; Text[20])
        // {
        //     Caption = 'Cust/Vendor Tax Registration No.';
        //     Description = 'DITW15.00.00.38 #1221';
        // }
        // field(2013783; "Applies-to D/P Line No."; Integer)
        // {
        //     Caption = 'Applies-to D/P Line No.';
        //     Description = 'DITW15.00.00.01';
        //     //TableRelation = "Sales Disc. & Promo. Worksheet"."Line No." where("Entry Type" = FIELD("Applies-to D/P Line Type"));  // BC Upgrade NANDIS03
        // }
        // field(2013784; "Applies-to D/P Line Type"; Option)
        // {
        //     Caption = 'Applies-to D/P Line Type';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaption = '" ,Discount,Promotion"';
        //     OptionMembers = " ",Discount,Promotion;
        //     //TableRelation = "Sales Disc. & Promo. Worksheet"."Entry Type";  // BC Upgrade NANDIS03
        // }
        // field(2013822; "Applies-to D/P Source Table"; Option)
        // {
        //     Caption = 'Applies-to D/P Source Table';
        //     Description = 'DITW15.00.00.34';
        //     OptionCaption = '" ,Sales,Purchase"';
        //     OptionMembers = " ",Sales,Purchase;
        // }
        // field(2013969; "Pos System-Created Entry"; Boolean)
        // {
        //     Caption = 'POS System-Created Entry';
        //     Description = 'DITW15.00.00.39 #1328';
        //     Editable = false;
        // }
        // field(2014077; "Truck Code"; Code[10])
        // {
        //     Caption = 'Truck Code';
        //     Description = 'DITW15.00.00.25';
        //     //TableRelation = "Whse. Shipping Truck";  // BC Upgrade NANDIS03
        // }
        // field(2014078; "Driver Code"; Code[10])
        // {
        //     Caption = 'Driver Code';
        //     Description = 'DITW15.00.00.25';
        //     //TableRelation = "Whse. Shipping Driver";  // BC Upgrade NANDIS03
        // }
        // field(2014271; "Cust/Vend Tax Warehouse Ref."; Text[20])
        // {
        //     Caption = 'Cust/Vendor Tax Warehouse Reference';
        //     Description = 'DITW15.00.00.38 #1221';
        // }
        // field(2014310; "Service Contract Line No."; Integer)
        // {
        //     Caption = 'Contract Line No.';
        //     Description = 'DIT-715 #392';
        // }
        // field(2014312; "DIT Sub-Contr.Pst. Type Filter"; Option)
        // {
        //     Caption = 'Financial Contract Posting Type Filter';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     FieldClass = FlowFilter;
        //     OptionCaption = '" ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All"';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        // }
        // field(2014313; "DIT Sub-Contract Type Filter"; Option)
        // {
        //     Caption = 'DIT Sub-Contract Type Filter';
        //     Description = 'DITW16.00.00.43 DIT-715 #641';
        //     FieldClass = FlowFilter;
        //     OptionCaption = '" ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All"';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        // }
        // field(2014314; "Source Type Filter"; Option)
        // {
        //     Caption = 'Source Type Filter';
        //     Description = 'DITW16.00.00.43 DIT-715 #641';
        //     FieldClass = FlowFilter;
        //     OptionCaption = '" ,Customer,Vendor,Bank Account,Fixed Asset"';
        //     OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
        // }
        // field(2014315; "Source No. Filter"; Code[20])
        // {
        //     Caption = 'Source No. Filter';
        //     Description = 'DITW16.00.00.43 DIT-715 #641';
        //     FieldClass = FlowFilter;
        //     TableRelation = IF ("Source Type" = CONST(Customer)) Customer
        //     else IF ("Source Type" = CONST(Vendor)) Vendor
        //     else IF ("Source Type" = CONST("Bank Account")) "Bank Account"
        //     else IF ("Source Type" = CONST("Fixed Asset")) "Fixed Asset";
        //     ValidateTableRelation = false;
        // }
        // field(2014316; "Payment Type"; Option)
        // {
        //     Caption = 'Payment Type';
        //     OptionCaption = '" ,collection,,,direct debiting"';
        //     OptionMembers = " ",collection,,,"direct debiting";
        // }
        // field(2014317; "Create from Financial Contract"; Boolean)
        // {
        //     Caption = 'Create from Financial Contract';
        //     Description = 'DITW17.10.05 - DIT-770 #756';
        // }
        // field(2014318; "Contract Posting Date"; Date)
        // {
        //     Caption = 'Contract Posting Date';
        //     Description = 'DITW17.10.05 - DIT-770 #756';
        // }
        // field(2014319; "Financial Contract No."; Code[20])
        // {
        //     Caption = 'Financial Contract No.';
        //     Description = 'DITW18.00.06 DIT-770 #1368';
        //     /*TableRelation = IF ("DIT Sub-Contract Type" = CONST(" ")) "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract))
        //     else IF ("DIT Sub-Contract Type" = FILTER(<> " ")) "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                                                                       "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));*/  // BC Upgrade NANDIS03

        //     trigger OnValidate();
        //     var
        //         FA2: Record "Fixed Asset";
        //     begin
        //     end;
        // }
        // field(2014497; "Invoice List Document No."; Code[20])
        // {
        //     Caption = 'Invoice List Document No.';
        //     Description = 'DITW18.10.07 DIT-770 #1723';
        //     Editable = false;
        //     //TableRelation = "Invoice List";  // BC Upgrade NANDIS03
        // }
        // field(2029610; OGM; Text[30])
        // {
        //     Caption = 'OGM';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029611; "Auto. Acc. Group"; Code[10])
        // {
        //     Caption = 'Auto. Acc. Group';
        //     Description = 'FINXL7.00';
        //     //TableRelation = "Automatic Acc. Header";  // BC Upgrade NANDIS03

        //     trigger OnValidate();
        //     var
        //         lrecGeneralLedgerSetup: Record "General Ledger Setup";
        //     begin
        //     end;
        // }
        // field(2034840; "Building No."; Code[20])
        // {
        //     Caption = 'Building No.';
        //     Description = 'DITW15.00.00.37';
        //     //TableRelation = Building;  
        // }
        // field(2034850; "DIT Sub-Contract Type"; Option)
        // {
        //     Caption = 'Sub Contract Type';
        //     Description = 'DITW15.00.00.35- DIT-715 #297';
        //     OptionCaption = '" ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance"';
        //     OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance;

        //     trigger OnValidate();
        //     var
        //         TempGenJnlLine: Record "Gen. Journal Line";
        //         GLAcc: Record "G/L Account";
        //         Cust: Record Customer;
        //         Vend: Record Vendor;
        //         FA: Record "Fixed Asset";
        //     begin
        //     end;
        // }
        // field(2034872; "Contract Group Code"; Code[10])
        // {
        //     Caption = 'Contract Group Code';
        //     Description = 'DITW15.00.00.35-.37';
        //     TableRelation = IF ("Contract Type" = CONST(Service),
        //                         "DIT Sub-Contract Type" = FILTER(<> " ")) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     else IF ("Contract Type" = CONST(Service),
        //                                  "DIT Sub-Contract Type" = CONST(" ")) "Contract Group".Code
        //     else IF ("Contract Type" = CONST(Financial),
        //                                           "DIT Sub-Contract Type" = FILTER(<> " ")) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
        //     else IF ("Contract Type" = CONST(Financial),
        //                                                    "DIT Sub-Contract Type" = CONST(" ")) "Financial Contract Group".Code;

        //     trigger OnValidate();
        //     var
        //         GLAcc: Record "G/L Account";
        //         Cust: Record Customer;
        //         Vend: Record Vendor;
        //         FA: Record "Fixed Asset";
        //     begin
        //     end;
        // }
        // field(2034915; "Service Contract No."; Code[20])
        // {
        //     Caption = 'Service Contract No.';
        //     Description = 'DITW15.00.00.35 -DIT-770 #1368';
        //     TableRelation = IF ("Contract Type" = CONST(Service),
        //                         "Source Type" = CONST(Customer)) "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                                                        "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type Filter"),
        //                                                                                                        "Customer No." = FIELD("Source No. Filter"),
        //                                                                                                        Status = FILTER(Signed))
        //     else IF ("Contract Type" = CONST(Service),
        //                                                                                                                 "Source Type" = CONST(Vendor)) "Service Purch. Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
        //                                                                                                                                                                                                     "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type Filter"),
        //                                                                                                                                                                                                     "Vendor No." = FIELD("Source No. Filter"),
        //                                                                                                                                                                                                     Status = FILTER(Signed));

        //     trigger OnValidate();
        //     var
        //         FA2: Record "Fixed Asset";
        //     begin
        //     end;
        // }
        // field(2035393; "Contract Type"; Option)
        // {
        //     Caption = 'Contract Type';
        //     Description = 'DIT-715 #392 - DIT-770 690 - DIT-770 #1368';
        //     OptionCaption = '" ,Service,Financial"';
        //     OptionMembers = " ",Service,Financial;
        // }  // BC Upgrade NANDIS03
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Archive Document No.", "Version No.", "Line No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Balance (LCY)";
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.")
        {
            MaintainSQLIndex = false;
        }
        key(Key3; "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.")
        {
        }
        key(Key4; "Document No.")
        {
            MaintainSQLIndex = false;
        }
        key(Key5; "Incoming Document Entry No.")
        {
        }
        // key(Key6; "Applies-to D/P Source Table", "Applies-to D/P Line Type", "Applies-to D/P Line No.")
        // {
        // }
        // key(Key7; "Journal Template Name", "Journal Batch Name", "Driver Code", "Truck Code", "Document No.", "Document Date")
        // {
        //     SumIndexFields = "Amount (LCY)";
        // }  // BC Upgrade NANDIS03
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
    //lrShippingDtldJnlLine: Record "Shipping Dtld. Jnl. Line";  // BC Upgrade NANDIS03
    begin
    end;

    var
        //DiscPromoPostLine: Codeunit "Sales Disc. & Promo.-Post Line";  // BC Upgrade NANDIS03
        //PurchDiscPromoPostLine: Codeunit "Purch.Disc. & Promo.-Post Line";  // BC Upgrade NANDIS03
        //ServPostJnl: Codeunit "Serv-Posting Journals Mgt."; // BC Upgrade NANDIS03
        //ServPurchPostJnl: Codeunit "Serv Purch.-Post Journals Mgt.";  // BC Upgrade NANDIS03
        ContractGroup: Record "Contract Group";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GLSetup: Record "General Ledger Setup";
        Job: Record Job;
        TempJobJnlLine: Record "Job Journal Line" temporary;
        PaymentTerms: Record "Payment Terms";
        //Building: Record Building;  // BC Upgrade NANDIS03
        //DITServMgtSetup: Record "Property Service Mgt. Setup";  // BC Upgrade NANDIS03
        //DITPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup";  // BC Upgrade NANDIS03
        ServContract: Record "Service Contract Header";
        SourceCodeSetup: Record "Source Code Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        VendLedgEntry: Record "Vendor Ledger Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        DeferralUtilities: Codeunit "Deferral Utilities";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlShowCTEntries: Codeunit "Gen. Jnl.-Show CT Entries";
        //recFinXLSetup: Record "Finance XL Setup";  // BC Upgrade NANDIS03
        //PurchasesUtils: Codeunit "Purchases-Utils";  // BC Upgrade NANDIS03 - No Use
        HeinekenGlobal: Codeunit "Heineken Global";
        //DimMgt: Codeunit DimensionManagement;  //  BC Upgrade NANDIS03
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        //rPropertyServiceMgtSetup: Record "Property Service Mgt. Setup";  // BC Upgrade NANDIS03
        //rPropertyPurchServMgtSetup: Record "Property Purch Serv Mgt. Setup";  // BC Upgrade NANDIS03
        blnCalledFromValidate: Boolean;
        GLSetupRead: Boolean;
        HideValidationDialog: Boolean;
        TemplateFound: Boolean;
        CurrencyCode: Code[10];
        FromCurrencyCode: Code[10];
        ToCurrencyCode: Code[10];
        CurrencyDate: Date;
        Window: Dialog;
        AccTypeNotSupportedErr: Label 'You cannot specify a deferral code for this type of account.';
        CalcPostDateMsg: Label 'Processing payment journal lines #1##########';
        CheckConstant: Label 'INCLUDED IN PAYMENT PROPOSAL';
        DocNoFilterErr: Label 'The document numbers cannot be renumbered while there is an active filter on the Document No. field.';
        DueDateMsg: Label 'This posting date will cause an overdue payment.';
        ExportAgainQst: Label 'One or more of the selected lines have already been exported. Do you want to export them again?';
        NothingToExportErr: Label 'There is nothing to export.';
        Text001: Label 'You must not specify %1 when %2 is %3.';
        Text002: Label 'cannot be specified without %1';
        Text005: Label 'The update has been interrupted to respect the warning.';
        Text006: Label 'The %1 option can only be used internally in the system.';
        Text008: Label '" must be 0 when %1 is %2."';
        Text009: Label 'LCY';
        Text010: Label '%1 must be %2 or %3.';
        Text011: Label '%1 must be negative.';
        Text012: Label '%1 must be positive.';
        Text013: Label 'The %1 must not be more than %2.';
        Text015: Label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.';
        Text016: Label '%1 must be G/L Account or Bank Account.';
        Text018: Label '%1 can only be set when %2 is set.';
        Text019: Label '%1 cannot be changed when %2 is set.';
        //ContractDIT: Record "Financial Contract Header";  // BC Upgrade NANDIS03
        //ContractGroupDIT: Record "Financial Contract Group";  // BC Upgrade NANDIS03
        Text2034840: Label 'You may not change the Posting group if the Sub Contract type is filled.';
        Text2034841: Label 'You may not change %1 when %2 is filled';
        DeferralDocType: Option Purchase,Sales,"G/L";
        NotExistErr: TextConst Comment = '%1=Document number', ENU = 'Document number %1 does not exist or is already closed.';
        Text000: TextConst Comment = '%1=Account Type,%2=Balance Account Type', ENU = '%1 or %2 must be a G/L Account or Bank Account.';
        Text003: TextConst Comment = '%1=Caption of Currency Code field, %2=Caption of table Gen Journal, %3=FromCurrencyCode, %4=ToCurrencyCode', ENU = 'The %1 in the %2 will be changed from %3 to %4.\\Do you want to continue?';
        Text007: TextConst Comment = '%1=Account Type,%2=Balance Account Type', ENU = '%1 or %2 must be a bank account.';
        Text014: TextConst Comment = '%1=Caption of Table Customer, %2=Customer No, %3=Caption of field Bill-to Customer No, %4=Value of Bill-to customer no.', ENU = 'The %1 %2 has a %3 %4.\\Do you still want to use %1 %2 in this journal line?';

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
        // DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");  // BC Upgrade NANDIS03
        ShortcutDimCode[1] := "Shortcut Dimension 1 Code";
        ShortcutDimCode[2] := "Shortcut Dimension 2 Code";
        //DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);  // BC Upgrade NANDIS03
    end;

    procedure ShowDimensions();
    begin
        /*"Dimension Set ID" := 
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1 %2 %3', "Journal Template Name", "Journal Batch Name", "Line No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");*/ // BC Upgrade NANDIS03
        // "Dimension Set ID" :=
        //   DimMgt.EditDimensionSet(
        //     "Dimension Set ID", STRSUBSTNO('%1 %2 %3', "Journal Template Name", "Journal Batch Name", "Line No."),
        //     "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code"); // BC Upgrade NANDIS03

    end;
}

