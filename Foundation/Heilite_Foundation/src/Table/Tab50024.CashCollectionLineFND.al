table 50024 "Cash Collection Line FND"
{
    // version NAVW110.0,DITW110.00.08

    // DITW17.10.05 AKH 10/02/2015 DIT-770 #1224 Updated Option Field "Document Type"
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // 
    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP030 IBM ISYED01 04/07/2017
    //   # added code to update reason code on reminder lines on entry no trigger.
    // 
    // HEI.02 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    // BC Upgrade PATELP08 >>
    // # Changed field "VAT Calculation Type" from Option to Enum data type to align with the "VAT Calculation Type" (Enum) field in the VAT Posting Setup table.
    // # Changed field "Applies-to Document Type" from Option to Enum data type to align with the "Document Type" (Enum) field in the Cust. Ledger Entry.
    // # Replaced integer comparison with explicit enum value comparison to remove implicit conversion warning in OnLookup, OnValidate triggers of 'Applies-to Document No.' field
    // BC Upgrade PATELP08 <<
    //BC UPGRADE KUMARR78 >>
    // Changing for (FDD OTC 091)
    //Adding Table Relation for Vehical and Driver Code. 
    //Changing OptionMembers and Correcting Name.
    //BC UPGARDE KUMARR78 <<

    Caption = 'Cash Collection Line';

    fields
    {
        field(1; "Cash Collection No."; Code[20])
        {
            Caption = 'Reminder No.';
            Description = 'HEI.02';
            TableRelation = "Cash Collection Header FND";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HEI.02';
            NotBlank = true;
        }
        field(3; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "Cash Collection Line FND"."Line No." where("Cash Collection No." = FIELD("Cash Collection No."));
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            Description = 'HEI.02';
            // OptionCaption = '" ,Customer Ledger Entry"';//BC UPGRADE KUMARR78 Blocking to Rename Caption.
            OptionCaption = ' ,Customer Ledger Entry'; //BC UPGRADE KUMARR78 Adding.
            OptionMembers = " ","Customer Ledger Entry";

            trigger OnValidate();
            var
                CustPostingGr: Record "Customer Posting Group";
            begin
                //HEI.02>>
                if Type <> xRec.Type then begin
                    CashCollectionLine := Rec;
                    INIT();
                    Type := CashCollectionLine.Type;
                    GetReminderHeader();
                    /* IF Type = Type::"3" THEN BEGIN
                       "Line Type" := "Line Type"::"Line Fee";
                       CustPostingGr.GET(CashCollectionHeader."Customer Posting Group");
                       IF CustPostingGr."Add. Fee per Line Account" <> '' THEN
                         VALIDATE("No.",CustPostingGr."Add. Fee per Line Account");
                     end;*/
                end;
                //HEI.02<<

            end;
        }
        field(5; "Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Entry No.';
            Description = 'HEI.02';
            TableRelation = "Cust. Ledger Entry";

            trigger OnLookup();
            begin
                if Type <> Type::"Customer Ledger Entry" then
                    exit;
                SetCustLedgEntryView();
                if CustLedgEntry.GET("Entry No.") then;
                LookupCustLedgEntry();
            end;

            trigger OnValidate();
            begin
                //HEI.02>>
                TESTFIELD(Type, Type::"Customer Ledger Entry");
                GetReminderHeader();
                CustLedgEntry.GET("Entry No.");
                CustLedgEntry.TESTFIELD(Open, true);
                CustLedgEntry.TESTFIELD("Customer No.", CashCollectionHeader."Customer No.");
                if CustLedgEntry."Currency Code" <> CashCollectionHeader."Currency Code" then
                    ERROR(
                      MustBeSameErr,
                      CashCollectionHeader.FIELDCAPTION("Currency Code"),
                      CashCollectionHeader.TABLECAPTION, CustLedgEntry.TABLECAPTION);
                "Posting Date" := CustLedgEntry."Posting Date";
                "Document Date" := CustLedgEntry."Document Date";
                "Due Date" := CustLedgEntry."Due Date";
                // "Document Type" := CustLedgEntry."Document Type"; //BC UPGRADE KUMARR78 --Blocking
                //BC UPGRADE KUMARR78 >> Adding Document Type filter
                if CustLedgEntry."Document Type" = CustLedgEntry."Document Type"::Invoice then
                    "Document Type" := "Document Type"::Invoice
                else
                    "Document Type" := CustLedgEntry."Document Type".AsInteger();
                //BC UPGRADE KUMARR78 << Adding Document Type filter
                "Document No." := CustLedgEntry."Document No.";
                Description := CustLedgEntry.Description;
                CustLedgEntry.CALCFIELDS(Amount, "Remaining Amount");
                "Original Amount" := CustLedgEntry.Amount;
                "Remaining Amount" := CustLedgEntry."Remaining Amount";
                "No. of Reminders" := GetNoOfReminderForCustLedgEntry("Entry No.");
                Amount := "Remaining Amount";

                //HEI.01>>
                DisputeCase.SETRANGE(DisputeCase."Cust. Ledger Entry No.", "Entry No.");
                DisputeCase.SETRANGE(DisputeCase.Status, DisputeCase.Status::Open);
                if DisputeCase.FINDFIRST() then
                    "Disputed Reason code" := DisputeCase."Reason Code";
                //HEI.01>>

                CalcFinChrg();
                Amount := "Remaining Amount";
                //HEI.02<<
            end;
        }
        field(6; "No. of Reminders"; Integer)
        {
            Caption = 'No. of Reminders';
            Description = 'HEI.02';

            trigger OnValidate();
            begin
                /*IF Type = Type::"3" THEN
                  VALIDATE("Applies-to Document No.");*/

            end;
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Description = 'HEI.02';
            Editable = false;
        }
        field(8; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Description = 'HEI.02';
            Editable = false;
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Description = 'HEI.02';
            Editable = false;
        }
        field(10; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Description = 'HEI.02';
            // OptionCaption = '" ,,Invoice"';//BC UPGRADE KUMARR78 Blocking to Rename Caption.
            OptionCaption = ' ,Invoice';//BC UPGRADE KUMARR78 

            // OptionMembers = " ",,Invoice;//BC UPGRADE KUMARR78 Blocking Remove (,)
            OptionMembers = " ",Invoice; //BC UPGRADE KUMARR78 Adding

            trigger OnValidate();
            begin
                TESTFIELD(Type, Type::"Customer Ledger Entry");
                //VALIDATE("Document No.");
            end;
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Description = 'HEI.02';

            trigger OnLookup();
            begin
                if Type <> Type::"Customer Ledger Entry" then
                    exit;
                SetCustLedgEntryView();
                if "Document Type" <> 0 then
                    CustLedgEntry.SETRANGE("Document Type", "Document Type");
                if "Document No." <> '' then
                    CustLedgEntry.SETRANGE("Document No.", "Document No.");
                if CustLedgEntry.FINDFIRST() then;
                CustLedgEntry.SETRANGE("Document Type");
                CustLedgEntry.SETRANGE("Document No.");
                CustLedgEntry.SETRANGE("Currency Code", CashCollectionHeader."Currency Code");

                LookupCustLedgEntry();
            end;

            trigger OnValidate();
            begin
                TESTFIELD(Type, Type::"Customer Ledger Entry");
                "Entry No." := 0;
                if "Document No." <> '' then begin
                    SetCustLedgEntryView();
                    if "Document Type" <> 0 then
                        CustLedgEntry.SETRANGE("Document Type", "Document Type");
                    CustLedgEntry.SETRANGE("Document No.", "Document No.");
                    if CustLedgEntry.FINDFIRST() then
                        VALIDATE("Entry No.", CustLedgEntry."Entry No.")
                    else
                        ERROR(NoOpenEntriesErr, FORMAT(Type), FIELDCAPTION("Document No."), "Document No.");
                end;
            end;
        }
        field(12; Description; Text[100])
        {
            Caption = 'Description';
            Description = 'HEI.02';
        }
        field(13; "Original Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCodeFromHeader();
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Original Amount';
            Description = 'HEI.02';
            Editable = false;
        }
        field(14; "Remaining Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCodeFromHeader();
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Remaining Amount';
            Description = 'HEI.02';
            Editable = false;
        }
        field(15; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'HEI.02';
            TableRelation = IF (Type = CONST(" ")) "Standard Text";

            trigger OnValidate();
            begin
                //HEI.02>>
                if "No." <> '' then
                    case Type of
                        Type::" ":
                            begin
                                StdTxt.GET("No.");
                                Description := StdTxt.Description;
                            end;
                        Type::"Customer Ledger Entry":
                            begin
                                CashCollectionLine.Type := CashCollectionLine.Type::" ";
                                CashCollectionLine2.Type := CashCollectionLine2.Type::"Customer Ledger Entry";
                                ERROR(
                                  MustBeErr,
                                  FIELDCAPTION(Type), CashCollectionLine.Type, CashCollectionLine2.Type);
                            end;
                    /*Type::"Customer Ledger Entry":
                      FillLineWithGLAccountData("No.");
                    Type::"3":
                      FillLineWithGLAccountData("No.");*/
                    end;
                //HEI.02<<

            end;
        }
        field(16; Amount; Decimal)
        {
            AutoFormatExpression = GetCurrencyCodeFromHeader();
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Amount';
            Description = 'HEI.02';

            trigger OnValidate();
            begin
                //HEI.02>>
                /*IF Type = Type::" " THEN BEGIN
                  //CashCollectionLine.Type := CashCollectionLine.Type::"Customer Ledger Entry";
                  CashCollectionLine2.Type := CashCollectionLine.Type::"Customer Ledger Entry";
                  ERROR(
                    MustBeErr,
                    FIELDCAPTION(Type),CashCollectionLine.Type,CashCollectionLine2.Type);
                end;
                {IF (Type = Type::"3") AND (Amount < 0) THEN
                  ERROR(MustBePositiveErr,FIELDCAPTION(Amount));}
                
                GetReminderHeader;
                //Amount := ROUND(Amount,Currency."Amount Rounding Precision");
                CASE "VAT Calculation Type" OF
                  "VAT Calculation Type"::"Normal VAT",
                  "VAT Calculation Type"::"Reverse Charge VAT",
                  "VAT Calculation Type"::"Full VAT":
                    "VAT Amount" := Amount * ("VAT %" / 100);
                  "VAT Calculation Type"::"Sales Tax":
                    BEGIN
                      "VAT Amount" :=
                        SalesTaxCalculate.CalculateTax(
                          CashCollectionHeader."Tax Area Code","Tax Group Code",CashCollectionHeader."Tax Liable",
                          CashCollectionHeader."Posting Date",Amount,0,0);
                      IF Amount - "VAT Amount" <> 0 THEN
                        "VAT %" := ROUND(100 * "VAT Amount" / Amount,0.00001)
                      else
                        "VAT %" := 0;
                    end;
                  "VAT Calculation Type"::"4":
                    BEGIN
                      "VAT Amount" := 0;
                      "VAT %" := 0;
                    end;
                end;
                "VAT Amount" := ROUND("VAT Amount",Currency."Amount Rounding Precision");*/
                //HEI.02<<

            end;
        }
        field(17; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate();
            begin
                TESTFIELD(Type, Type::"Customer Ledger Entry");
                TESTFIELD("Entry No.");
                CalcFinChrg();
            end;
        }
        field(18; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            Description = 'HEI.02';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate();
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        VALIDATE("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(19; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.02';
            Editable = false;
        }
        // BC Upgrade PATELP08 >> # Changed field type from Option to Enum data type to align with the "Tax Calculation Type" (Enum) field in the VAT Posting Setup table.
        // field(20; "VAT Calculation Type"; Option)
        // {
        //     Caption = 'VAT Calculation Type';
        //     Description = 'HEI.02';
        //     Editable = false;
        //     OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
        //     OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        // }
        field(20; "VAT Calculation Type"; Enum "Tax Calculation Type")
        {
            Caption = 'VAT Calculation Type';
            Description = 'HEI.02';
            Editable = false;
        }
        // BC Upgrade PATELP08 <<

        field(21; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCodeFromHeader();
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'VAT Amount';
            Description = 'HEI.02';
            Editable = false;
        }
        field(22; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            Description = 'HEI.02';
            TableRelation = "Tax Group";

            trigger OnValidate();
            begin
                VALIDATE("VAT Prod. Posting Group");
            end;
        }
        field(23; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            Description = 'HEI.02';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate();
            begin
                //HEI.02>>
                GetReminderHeader();
                VATPostingSetup.GET(CashCollectionHeader."VAT Bus. Posting Group", "VAT Prod. Posting Group");
                "VAT %" := VATPostingSetup."VAT %";
                "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                "VAT Identifier" := VATPostingSetup."VAT Identifier";
                "VAT Clause Code" := VATPostingSetup."VAT Clause Code";
                case "VAT Calculation Type" of
                    "VAT Calculation Type"::"Reverse Charge VAT":
                        "VAT %" := 0;
                    "VAT Calculation Type"::"Full VAT":
                        begin
                            TESTFIELD(Type, Type::"Customer Ledger Entry");
                            VATPostingSetup.TESTFIELD("Sales VAT Account");
                            TESTFIELD("No.", VATPostingSetup."Sales VAT Account");
                        end;
                    "VAT Calculation Type"::"Sales Tax":
                        begin
                            "VAT Amount" :=
                              SalesTaxCalculate.CalculateTax(
                                CashCollectionHeader."Tax Area Code", "Tax Group Code", CashCollectionHeader."Tax Liable",
                                CashCollectionHeader."Posting Date", Amount, 0, 0);
                            if Amount - "VAT Amount" <> 0 then
                                "VAT %" := ROUND(100 * "VAT Amount" / Amount, 0.00001)
                            else
                                "VAT %" := 0;
                            "VAT Amount" := ROUND("VAT Amount", Currency."Amount Rounding Precision");
                        end;
                end;
                VALIDATE(Amount);
                //HEI.02<<
            end;
        }
        field(24; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Description = 'HEI.02';
            Editable = false;
        }
        field(25; "Line Type"; Option)
        {
            Caption = 'Line Type';
            Description = 'HEI.02';
            OptionCaption = 'Cash Collection Line,Not Due,Beginning Text,Ending Text,Rounding,On Hold,Additional Fee,Line Fee';
            OptionMembers = "Cash Collection Line","Not Due","Beginning Text","Ending Text",Rounding,"On Hold","Additional Fee","Line Fee";
        }
        field(26; "VAT Clause Code"; Code[10])
        {
            Caption = 'VAT Clause Code';
            Description = 'HEI.02';
            TableRelation = "VAT Clause";
        }

        // BC Upgrade PATELP08 >>  # Changed field type from Option to Enum data type to align with the "Document Type" (Enum) field in the Cust. Ledger Entry.
        // field(27; "Applies-to Document Type"; Option)
        // {
        //     Caption = 'Applies-to Document Type';
        //     Description = 'HEI.02';
        //     OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund"';
        //     OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;

        //     trigger OnValidate();
        //     begin
        //         VALIDATE("Applies-to Document No.");
        //     end;
        // }

        field(27; "Applies-to Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Document Type';
            Description = 'HEI.02';
            trigger OnValidate();
            begin
                VALIDATE("Applies-to Document No.");
            end;
        }
        // BC Upgrade PATELP08 <<
        field(28; "Applies-to Document No."; Code[20])
        {
            Caption = 'Applies-to Document No.';
            Description = 'HEI.02';

            trigger OnLookup();
            begin
                //IF Type <> Type::"3" THEN
                // EXIT;
                SetCustLedgEntryView();
                // BC Upgrade PATELP08 >> # Replaced integer comparison with explicit enum value comparison to remove implicit conversion warning.
                // if "Applies-to Document Type" <> 0 then
                if "Applies-to Document Type" <> "Applies-to Document Type"::" " then
                    // BC Upgrade PATELP08 <<

                    CustLedgEntry.SETRANGE("Document Type", "Applies-to Document Type");
                if "Applies-to Document No." <> '' then
                    CustLedgEntry.SETRANGE("Document No.", "Applies-to Document No.");
                if CustLedgEntry.FINDFIRST() then;
                CustLedgEntry.SETRANGE("Document Type");
                CustLedgEntry.SETRANGE("Document No.");
                LookupCustLedgEntry();
            end;

            trigger OnValidate();
            var
                NextLineFeeLevel: Integer;
            begin
                //HEI.02>>
                "Entry No." := 0;
                if "Applies-to Document No." <> '' then begin
                    SetCustLedgEntryView();
                    // BC Upgrade PATELP08 >> # Replaced integer comparison with explicit enum value comparison to remove implicit conversion warning.
                    // if "Applies-to Document Type" <> 0 then
                    if "Applies-to Document Type" <> "Applies-to Document Type"::" " then
                        // BC Upgrade PATELP08 <<
                        CustLedgEntry.SETRANGE("Document Type", "Applies-to Document Type");
                    CustLedgEntry.SETRANGE("Document No.", "Applies-to Document No.");
                    if not CustLedgEntry.FINDFIRST() then
                        ERROR(NoOpenEntriesErr, CustLedgEntry.TABLENAME, FIELDCAPTION("Document No."), "Applies-to Document No.");
                    "Applies-to Document Type" := CustLedgEntry."Document Type";

                    if CustLedgEntry."Due Date" >= CashCollectionHeader."Document Date" then
                        ERROR(EntryNotOverdueErr, CustLedgEntry.FIELDCAPTION("Document No."), "Applies-to Document No.", CustLedgEntry.TABLENAME);

                    if "No. of Reminders" <> 0 then
                        NextLineFeeLevel := "No. of Reminders"
                    else
                        NextLineFeeLevel := GetNoOfReminderForCustLedgEntry(CustLedgEntry."Entry No.");

                    if LineFeeIssuedForReminderLevel(CustLedgEntry, NextLineFeeLevel) then
                        ERROR(LineFeeAlreadyIssuedErr, "Applies-to Document Type", "Applies-to Document No.", NextLineFeeLevel);

                    GetReminderHeader();
                    if CustLedgEntry."Currency Code" <> CashCollectionHeader."Currency Code" then
                        ERROR(
                          MustBeSameErr,
                          CashCollectionHeader.FIELDCAPTION("Currency Code"),
                          CashCollectionHeader.TABLECAPTION, CustLedgEntry.TABLECAPTION);


                    "Posting Date" := CashCollectionHeader."Posting Date";
                    "Document Date" := CashCollectionHeader."Document Date";
                    "Due Date" := CashCollectionHeader."Due Date";
                    "No. of Reminders" := NextLineFeeLevel;

                    CustLedgEntry.CALCFIELDS("Remaining Amount");

                    Description := '';
                    if (Amount <> 0) then
                        Description := STRSUBSTNO('',
                            "Cash Collection No.",
                            "No. of Reminders",
                            "Document Date",
                            "Posting Date",
                            "No.",
                            Amount,
                            "Applies-to Document Type",
                            "Applies-to Document No.",
                            '')
                    else
                        if GLAcc.GET("No.") then
                            Description := GLAcc.Name;
                end;
                //HEI.02<<
            end;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Description = 'HEI.02';
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
            Editable = false;
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

    trigger OnDelete();
    begin
        //HEI.02>>
        CashCollectionLine.SETRANGE("Cash Collection No.", "Cash Collection No.");
        CashCollectionLine.SETRANGE("Attached to Line No.", "Line No.");
        CashCollectionLine.DELETEALL();
        //HEI.02<<
    end;

    trigger OnInsert();
    begin
        //HEI.02>>
        CashCollectionHeader.GET("Cash Collection No.");
        "Attached to Line No." := 0;


        //HEI.02<<
    end;

    trigger OnModify();
    begin
        TESTFIELD("System-Created Entry", false);
    end;

    var
        CashCollectionHeader: Record "Cash Collection Header FND";
        CashCollectionLine: Record "Cash Collection Line FND";
        CashCollectionLine2: Record "Cash Collection Line FND";
        Currency: Record Currency;
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustPostingGr: Record "Customer Posting Group";
        DisputeCase: Record "Dispute Case FND";
        FinChrgTerms: Record "Finance Charge Terms";
        GLAcc: Record "G/L Account";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        ReminderEntry: Record "Reminder/Fin. Charge Entry";
        StdTxt: Record "Standard Text";
        VATPostingSetup: Record "VAT Posting Setup";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        CalcInterest: Boolean;
        InterestCalcDate: Date;
        MustBeErr: Label '%1 must be %2 or %3.';
        MustBePositiveErr: Label '%1 must be positive.';
        MustBeSameErr: Label 'The %1 on the %2 and the %3 must be the same.';
        EntryNotOverdueErr: TextConst Comment = '%1 = Document Type, %2 = Document No., %3 = Table name', ENU = '%1 %2 in %3 is not overdue.';
        LineFeeAlreadyIssuedErr: TextConst Comment = '%1 = Document TYpe, %2 = Document No, %3 = Level number', ENU = 'The line fee for %1 %2 on reminder level %3 has already been issued.';
        NoOpenEntriesErr: TextConst Comment = '%1 = Table name, %2 = Document Type, %3 = Document No.', ENU = 'There is no open %1 with %2 %3.';

    local procedure CalcFinChrg();
    var
        DtldCLE: Record "Detailed Cust. Ledg. Entry";
        IssuedCashCollectionHeader: Record "Issue Cash Collection Head FND";
        InterestStartDate: Date;
        LineFee: Decimal;
    begin
        //HEI.02>>
        GetReminderHeader();
        "Interest Rate" := 0;
        Amount := 0;
        "VAT Amount" := 0;
        "VAT Calculation Type" := "VAT Calculation Type"::"Normal VAT";
        "Gen. Prod. Posting Group" := '';
        "VAT Prod. Posting Group" := '';
        CustLedgEntry.GET("Entry No.");
        if (CustLedgEntry."On Hold" <> '') or ("Due Date" >= CashCollectionHeader."Document Date") then
            exit;

        if Amount <> 0 then begin
            CustPostingGr.GET(CashCollectionHeader."Customer Posting Group");
            CustPostingGr.TESTFIELD("Interest Account");
            GLAcc.GET(CustPostingGr."Interest Account");
            GLAcc.TESTFIELD("Gen. Prod. Posting Group");
            VALIDATE("Gen. Prod. Posting Group", GLAcc."Gen. Prod. Posting Group");
            VALIDATE("VAT Prod. Posting Group", GLAcc."VAT Prod. Posting Group");
        end;
        //HEI.02<<
    end;

    local procedure SetCustLedgEntryView();
    begin
        //HEI.02>>
        GetReminderHeader();
        CustLedgEntry.SETCURRENTKEY("Customer No.", Open);
        CustLedgEntry.SETRANGE("Customer No.", CashCollectionHeader."Customer No.");
        CustLedgEntry.SETRANGE(Open, true);
        //HEI.02<<
    end;

    local procedure LookupCustLedgEntry();
    begin
        if PAGE.RUNMODAL(0, CustLedgEntry) = ACTION::LookupOK then
            /* IF Type = Type::"3" THEN BEGIN
               VALIDATE("Applies-to Document Type",CustLedgEntry."Document Type");
               VALIDATE("Applies-to Document No.",CustLedgEntry."Document No.");
             end else*/
            VALIDATE("Entry No.", CustLedgEntry."Entry No.");

    end;

    local procedure GetReminderHeader();
    begin
        //HEI.02>>
        if "Cash Collection No." <> CashCollectionHeader."No." then begin
            CashCollectionHeader.GET("Cash Collection No.");
            ProcessReminderHeader();
        end;
        //HEI.02<<
    end;

    local procedure ProcessReminderHeader();
    begin
        //HEI.02>>
        CashCollectionHeader.TESTFIELD("Customer No.");
        CashCollectionHeader.TESTFIELD("Document Date");
        CashCollectionHeader.TESTFIELD("Customer Posting Group");
        //CashCollectionHeader.TESTFIELD("Cash Collection Terms Code");
        if CashCollectionHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.GET(CashCollectionHeader."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        end;
        //HEI.02<<
    end;

    procedure GetCurrencyCodeFromHeader(): Code[10];
    var
        CashCollectionHeader: Record "Cash Collection Header FND";
    begin
        //HEI.02>>
        if "Cash Collection No." = CashCollectionHeader."No." then
            exit(CashCollectionHeader."Currency Code");

        if CashCollectionHeader.GET("Cash Collection No.") then
            exit(CashCollectionHeader."Currency Code");

        exit('');
        //HEI.02<<
    end;

    local procedure FillLineWithGLAccountData(GLAccountNo: Code[20]);
    begin
        GLAcc.GET(GLAccountNo);
        GLAcc.CheckGLAcc();
        if not "System-Created Entry" then
            GLAcc.TESTFIELD("Direct Posting", true);
        GLAcc.TESTFIELD("Gen. Prod. Posting Group");
        if Description = '' then
            Description := GLAcc.Name;
        GetReminderHeader();
        "Tax Group Code" := GLAcc."Tax Group Code";
        VALIDATE("Gen. Prod. Posting Group", GLAcc."Gen. Prod. Posting Group");
        VALIDATE("VAT Prod. Posting Group", GLAcc."VAT Prod. Posting Group");
    end;

    local procedure GetNoOfReminderForCustLedgEntry(EntryNo: Integer): Integer;
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        NoOfReminders: Integer;
    begin
        CustLedgerEntry.GET(EntryNo);
        NoOfReminders := 0;
        ReminderEntry.RESET();
        ReminderEntry.SETCURRENTKEY("Customer Entry No.");
        ReminderEntry.SETRANGE("Customer Entry No.", EntryNo);
        ReminderEntry.SETRANGE(Type, ReminderEntry.Type::Reminder);
        if ReminderEntry.FINDLAST() then
            NoOfReminders := ReminderEntry."Reminder Level";
        if (CustLedgerEntry."On Hold" = '') and (CustLedgerEntry."Due Date" < CashCollectionHeader."Document Date") then
            NoOfReminders := NoOfReminders + 1;

        exit(NoOfReminders);
    end;

    local procedure LineFeeIssuedForReminderLevel(var CustLedgEntry: Record "Cust. Ledger Entry"; IssuedNoOfReminders: Integer): Boolean;
    var
        IssuedCashCollectionLine: Record "Issue Cash Collection Line FND";
    begin
        //HEI.02>>
        IssuedCashCollectionLine.SETRANGE("Applies-To Document Type", CustLedgEntry."Document Type");
        IssuedCashCollectionLine.SETRANGE("Applies-To Document No.", CustLedgEntry."Document No.");
        IssuedCashCollectionLine.SETRANGE(Type, IssuedCashCollectionLine.Type::" ");
        IssuedCashCollectionLine.SETRANGE("No. of Reminders", IssuedNoOfReminders);
        exit(IssuedCashCollectionLine.FINDFIRST());
        //HEI.02<<
    end;

    local procedure GetReminderLevel(LevelStart: Integer; LevelEnd: Integer);
    begin
    end;
}

