tableextension 50049 CurrencyExtFND extends Currency
{
    // version NAVW110.0,DITW110.00.08,HEI.02
    // DITW15.00.00.24 DDR 22/09/2008 Drink-It Tax rounding functionnalities
    //                                Added fields
    //                                  2013716 Amount Decimal Places
    //                                  2013717 Unit-Amount Decimal Places
    //                                  2013718 Amount Rounding Precision
    //                                  2013719 Unit-Amount Rounding Precision
    //                                Added functions
    //                                  CheckTaAmountRoundingPrecision()
    // DITW15.00.00.28,HLW15.00.01.01 28/11/2008 Added fields
    //                                             2035340 Our Bank No.
    // DITW15.00.00.32 DDR 08/04/2009 Added functions
    //                                  SetRoundingPrecisionDrink(useTaxRnd)
    //                                Renamed function
    //                                  CheckTaAmountRoundingPrecision() -> CheckAmountRoundingPrecDrink()
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 V1.05 HT84 IBM POENAB02 01.04.2019
    //   # Fields added: 50000 "ISO Currency Code", 50001 "BC (LCY) - Send Without Dec."
    // HEI.02 CHG2225264 IBM SISUM01 16.01.2024 HB3640_BRD_GT_FX on Working capital payables & receivables (excluding derivatives)
    //   # Add new fields marked with HEI.02 in description
    //   # Create new function:  GetGainLossAccountFX
    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Last Date Adjusted")
        {
            CaptionML = ENU = 'Last Date Adjusted', FRA = 'Date dern. ajust. automatique';
        }
        modify("Unrealized Gains Acc.")
        {
            CaptionML = ENU = 'Unrealized Gains Acc.', FRA = 'Compte gains prévus';
        }
        modify("Realized Gains Acc.")
        {
            CaptionML = ENU = 'Realized Gains Acc.', FRA = 'Compte gains constatés';
        }
        modify("Unrealized Losses Acc.")
        {
            CaptionML = ENU = 'Unrealized Losses Acc.', FRA = 'Compte pertes prévues';
        }
        modify("Realized Losses Acc.")
        {
            CaptionML = ENU = 'Realized Losses Acc.', FRA = 'Compte pertes constatées';
        }
        modify("Invoice Rounding Precision")
        {
            CaptionML = ENU = 'Invoice Rounding Precision', FRA = 'Précision arrondi facture';
        }
        modify("Invoice Rounding Type")
        {
            CaptionML = ENU = 'Invoice Rounding Type', FRA = 'Type arrondi facture';
            OptionCaptionML = ENU = 'Nearest,Up,Down', FRA = 'Au plus près,Par excès,Par défaut';
        }
        modify("Amount Rounding Precision")
        {
            CaptionML = ENU = 'Amount Rounding Precision', FRA = 'Précision arrondi montant';
        }
        modify("Unit-Amount Rounding Precision")
        {
            CaptionML = ENU = 'Unit-Amount Rounding Precision', FRA = 'Précis. arrondi montant unité';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Amount Decimal Places")
        {
            CaptionML = ENU = 'Amount Decimal Places', FRA = 'Nombre décimales montant';
        }
        modify("Unit-Amount Decimal Places")
        {
            CaptionML = ENU = 'Unit-Amount Decimal Places', FRA = 'Nombre décimales montant unit.';
        }
        modify("Customer Filter")
        {
            CaptionML = ENU = 'Customer Filter', FRA = 'Filtre client';
        }
        modify("Vendor Filter")
        {
            CaptionML = ENU = 'Vendor Filter', FRA = 'Filtre fournisseur';
        }
        modify("Global Dimension 1 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Filter"(Field 21)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Filter', FRA = 'Filtre axe principal 1';
        }
        modify("Global Dimension 2 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Filter"(Field 22)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Filter', FRA = 'Filtre axe principal 2';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Cust. Ledg. Entries in Filter")
        {

            //Unsupported feature: Change CalcFormula on ""Cust. Ledg. Entries in Filter"(Field 24)". Please convert manually.

            CaptionML = ENU = 'Cust. Ledg. Entries in Filter', FRA = 'Écritures comptables client dans filtre';
        }
        modify("Customer Balance")
        {

            //Unsupported feature: Change CalcFormula on ""Customer Balance"(Field 25)". Please convert manually.

            CaptionML = ENU = 'Customer Balance', FRA = 'Solde client';
        }
        modify("Customer Outstanding Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Customer Outstanding Orders"(Field 26)". Please convert manually.

            CaptionML = ENU = 'Customer Outstanding Orders', FRA = 'Commandes ouvertes client';
        }
        modify("Customer Shipped Not Invoiced")
        {

            //Unsupported feature: Change CalcFormula on ""Customer Shipped Not Invoiced"(Field 27)". Please convert manually.

            CaptionML = ENU = 'Customer Shipped Not Invoiced', FRA = 'Livré non facturé client';
        }
        modify("Customer Balance Due")
        {

            //Unsupported feature: Change CalcFormula on ""Customer Balance Due"(Field 28)". Please convert manually.

            CaptionML = ENU = 'Customer Balance Due', FRA = 'Solde dû client';
        }
        modify("Vendor Ledg. Entries in Filter")
        {

            //Unsupported feature: Change CalcFormula on ""Vendor Ledg. Entries in Filter"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Vendor Ledg. Entries in Filter', FRA = 'Écritures comptables fourn. dans filtre';
        }
        modify("Vendor Balance")
        {

            //Unsupported feature: Change CalcFormula on ""Vendor Balance"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Vendor Balance', FRA = 'Solde fournisseur';
        }
        modify("Vendor Outstanding Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Vendor Outstanding Orders"(Field 31)". Please convert manually.

            CaptionML = ENU = 'Vendor Outstanding Orders', FRA = 'Commandes ouvertes fournisseur';
        }
        modify("Vendor Amt. Rcd. Not Invoiced")
        {

            //Unsupported feature: Change CalcFormula on ""Vendor Amt. Rcd. Not Invoiced"(Field 32)". Please convert manually.

            CaptionML = ENU = 'Vendor Amt. Rcd. Not Invoiced', FRA = 'Montant reçu non fact. fourn.';
        }
        modify("Vendor Balance Due")
        {

            //Unsupported feature: Change CalcFormula on ""Vendor Balance Due"(Field 33)". Please convert manually.

            CaptionML = ENU = 'Vendor Balance Due', FRA = 'Solde dû fournisseur';
        }
        modify("Customer Balance (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Customer Balance (LCY)"(Field 34)". Please convert manually.

            CaptionML = ENU = 'Customer Balance (LCY)', FRA = 'Solde client DS';
        }
        modify("Vendor Balance (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Vendor Balance (LCY)"(Field 35)". Please convert manually.

            CaptionML = ENU = 'Vendor Balance (LCY)', FRA = 'Solde fournisseur DS';
        }
        modify("Realized G/L Gains Account")
        {
            CaptionML = ENU = 'Realized G/L Gains Account', FRA = 'Cpte gains constatés report';
        }
        modify("Realized G/L Losses Account")
        {
            CaptionML = ENU = 'Realized G/L Losses Account', FRA = 'Cpte pertes constatées report';
        }
        modify("Appln. Rounding Precision")
        {
            CaptionML = ENU = 'Appln. Rounding Precision', FRA = 'Précision arrondi lettrage';
        }
        modify("EMU Currency")
        {
            CaptionML = ENU = 'EMU Currency', FRA = 'Devise U.M.E.';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Residual Gains Account")
        {
            CaptionML = ENU = 'Residual Gains Account', FRA = 'Compte gains résiduels DR';
        }
        modify("Residual Losses Account")
        {
            CaptionML = ENU = 'Residual Losses Account', FRA = 'Compte pertes résiduelles DR';
        }
        modify("Conv. LCY Rndg. Debit Acc.")
        {
            CaptionML = ENU = 'Conv. LCY Rndg. Debit Acc.', FRA = 'Compte débit arrondi DS';
        }
        modify("Conv. LCY Rndg. Credit Acc.")
        {
            CaptionML = ENU = 'Conv. LCY Rndg. Credit Acc.', FRA = 'Compte crédit arrondi DS';
        }
        modify("Max. VAT Difference Allowed")
        {
            CaptionML = ENU = 'Max. VAT Difference Allowed', FRA = 'Différence TVA max. autorisée';
        }
        modify("VAT Rounding Type")
        {
            CaptionML = ENU = 'VAT Rounding Type', FRA = 'Type arrondi TVA';
            OptionCaptionML = ENU = 'Nearest,Up,Down', FRA = 'Au plus près,Par excès,Par défaut';
        }
        modify("Payment Tolerance %")
        {
            CaptionML = ENU = 'Payment Tolerance %', FRA = '% écart de règlement';
        }
        modify("Max. Payment Tolerance Amount")
        {
            CaptionML = ENU = 'Max. Payment Tolerance Amount', FRA = 'Montant écart règlement max.';
        }
        modify(Symbol)
        {
            CaptionML = ENU = 'Symbol', FRA = 'Symbole';
        }

        //Unsupported feature: CodeModification on "Code(Field 1).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Symbol = '' THEN
          Symbol := ResolveCurrencySymbol(Code);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Symbol = '' then
          Symbol := ResolveCurrencySymbol(Code);
        */
        //end;


        //Unsupported feature: CodeModification on ""Invoice Rounding Precision"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Amount Rounding Precision" <> 0 THEN
          IF "Invoice Rounding Precision" <> ROUND("Invoice Rounding Precision","Amount Rounding Precision") THEN
            FIELDERROR(
              "Invoice Rounding Precision",
              STRSUBSTNO(Text000,"Amount Rounding Precision"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Amount Rounding Precision" <> 0 then
          if "Invoice Rounding Precision" <> ROUND("Invoice Rounding Precision","Amount Rounding Precision") then
        #3..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Amount Rounding Precision"(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Amount Rounding Precision" <> 0 THEN BEGIN
          "Invoice Rounding Precision" := ROUND("Invoice Rounding Precision","Amount Rounding Precision");
          IF "Amount Rounding Precision" > "Invoice Rounding Precision" THEN
            "Invoice Rounding Precision" := "Amount Rounding Precision";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Amount Rounding Precision" <> 0 then begin
          "Invoice Rounding Precision" := ROUND("Invoice Rounding Precision","Amount Rounding Precision");
          if "Amount Rounding Precision" > "Invoice Rounding Precision" then
            "Invoice Rounding Precision" := "Amount Rounding Precision";
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Max. VAT Difference Allowed"(Field 52).OnValidate". Please convert manually.

        //trigger  VAT Difference Allowed"(Field 52)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Max. VAT Difference Allowed" <> ROUND("Max. VAT Difference Allowed","Amount Rounding Precision") THEN
          ERROR(
            Text001,
            FIELDCAPTION("Max. VAT Difference Allowed"),"Amount Rounding Precision");

        "Max. VAT Difference Allowed" := ABS("Max. VAT Difference Allowed");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Max. VAT Difference Allowed" <> ROUND("Max. VAT Difference Allowed","Amount Rounding Precision") then
        #2..6
        */
        //end;
        field(50000; "ISO Currency Code FND"; Code[3])
        {
            CaptionML = ENU = 'ISO Currency Code',
                        FRB = 'Code devise ISO',
                        NLB = 'ISO-valutacode';
            Description = 'HEI.01';
        }
        field(50001; "BC - Send Without Decimals FND"; Boolean)
        {
            Caption = 'BC - Send Without Decimals';
            Description = 'HEI.01';
        }
        field(50002; "Unrealized GainAcc.Payable FND"; Code[20])
        {
            Caption = 'Unrealized Gain Acc. (WC Payable)';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(50003; "Unrealized LossAcc.Payable FND"; Code[20])
        {
            Caption = 'Unrealized Loss Acc. (WC Payable)';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(50004; "Realized Loss Acc. Payable FND"; Code[20])
        {
            Caption = 'Realized Loss Acc. (WC Payable)';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(50005; "Realized Gain Acc. Payable FND"; Code[20])
        {
            Caption = 'Realized Gain Acc. (WC Payable)';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(50006; "Unrealized GainAcc.Receiv. FND"; Code[20])
        {
            Caption = 'Unrealized Gain Acc. (WC Receivable)';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(50007; "Unrealized LossAcc.Receiv. FND"; Code[20])
        {
            Caption = 'Unrealized Loss Acc. (WC Receivable)';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(50008; "Realized Loss Acc. Receiv. FND"; Code[20])
        {
            Caption = 'Realized Loss Acc. (WC Receivable)';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        field(50009; "Realized Gain Acc. Receiv. FND"; Code[20])
        {
            Caption = 'Realized Gain Acc. (WC Receivable)';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            TableRelation = "G/L Account";
        }
        // BC Upgrade BHARDA11 >> --FDD STP 004
        field(50010; "Tax Amount Rounding Prec.1 FND"; Decimal)
        {
            Caption = 'Tax Amount Rounding Prec.';
            DataClassification = ToBeClassified;
        }
        field(50011; "Tax UnitAmt Rounding Prec1 FND"; Decimal)
        {
            Caption = 'Tax Unit-Amount Rounding Prec.';
            DataClassification = ToBeClassified;
        }
        // BC Upgrade BHARDA11 << --FDD STP 004
        // field(2013716; "Tax Amount Decimal Places"; Text[5])
        // {
        //     CaptionML = ENU = 'Amount Decimal Places (Tax)',
        //                 FRA = 'Nombre décimales montant (Taxe)';
        //     Description = 'DITW15.00.00.24';
        //     InitValue = '2:2';

        //     trigger OnValidate();
        //     begin
        //         GLSetup.CheckDecimalPlacesFormat("Tax Amount Decimal Places");
        //     end;
        // }
        // field(2013717; "Tax Unit-Amount Decimal Places"; Text[5])
        // {
        //     CaptionML = ENU = 'Unit-Amount Decimal Places (Tax)',
        //                 FRA = 'Nombre décimales montant unit. (Taxe)';
        //     Description = 'DITW15.00.00.24';
        //     InitValue = '2:5';

        //     trigger OnValidate();
        //     begin
        //         GLSetup.CheckDecimalPlacesFormat("Tax Unit-Amount Decimal Places");
        //     end;
        // }
        // field(2013718; "Tax Amount Rounding Prec."; Decimal)
        // {
        //     CaptionML = ENU = 'Amount Rounding Precision (Tax)',
        //                 FRA = 'Précision arrondi montant (Taxe)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
        //     InitValue = 0.01;
        // }
        // field(2013719; "Tax Unit-Amount Rounding Prec."; Decimal)
        // {
        //     CaptionML = ENU = 'Unit-Amount Rounding Precision (Tax)',
        //                 FRA = 'Précis. arrondi montant unité (Taxe)';
        //     DecimalPlaces = 0 : 9;
        //     Description = 'DITW15.00.00.24';
        //     InitValue = 0.00001;
        // }
        // field(2035340; "Our Bank No."; Code[20])
        // {
        //     CaptionML = ENU = 'Our Bank No.',
        //                 FRA = 'Notre n° compte bancaire';
        //     Description = 'FAY,HLW15.00.01.01';
        //     TableRelation = "Bank Account"."No.";
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustLedgEntry.SETRANGE(Open,TRUE);
    CustLedgEntry.SETRANGE("Currency Code",Code);
    IF NOT CustLedgEntry.ISEMPTY THEN
      ERROR(Text002,CustLedgEntry.TABLECAPTION,TABLECAPTION,Code);

    VendLedgEntry.SETRANGE(Open,TRUE);
    VendLedgEntry.SETRANGE("Currency Code",Code);
    IF NOT VendLedgEntry.ISEMPTY THEN
      ERROR(Text002,VendLedgEntry.TABLECAPTION,TABLECAPTION,Code);

    CurrExchRate.SETRANGE("Currency Code",Code);
    CurrExchRate.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CustLedgEntry.SETRANGE(Open,true);
    CustLedgEntry.SETRANGE("Currency Code",Code);
    if not CustLedgEntry.ISEMPTY then
      ERROR(Text002,CustLedgEntry.TABLECAPTION,TABLECAPTION,Code);

    VendLedgEntry.SETRANGE(Open,true);
    VendLedgEntry.SETRANGE("Currency Code",Code);
    if not VendLedgEntry.ISEMPTY then
    #9..12
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        GLAccNo: Code[20];


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=must be rounded to the nearest %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=must be rounded to the nearest %1;FRA=doit être arrondi au %1 le plus proche;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=%1 must be rounded to the nearest %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=%1 must be rounded to the nearest %2.;FRA=%1 doit être arrondi au %2 le plus proche.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : @@@=1 either customer or vendor ledger entry table 2 name co currency table 3 currencency code;ENU=There is one or more opened entries in the %1 table using %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : @@@=1 either customer or vendor ledger entry table 2 name co currency table 3 currencency code;ENU=There is one or more opened entries in the %1 table using %2 %3.;FRA=Il existe une ou plusieurs écritures ouvertes dans la table %1 utilisant %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "IncorrectEntryTypeErr(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IncorrectEntryTypeErr : ENU=Incorrect Entry Type %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IncorrectEntryTypeErr : ENU=Incorrect Entry Type %1.;FRA=Type d'écriture incorrect %1.;
    //Variable type has not been exported.

    var
        IncorrectSourceTypeErr: Label 'Incorrect Source Type %1.';
        IncorrectEntryTypeErr: TextConst ENU = 'Incorrect Entry Type %1.';

    procedure GetGainLossAccountFX(DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; SourceType: Option " ",Customer,Vendor): Code[20]
    var
        myInt: Integer;
    begin
        //HEI.02>>
        IF SourceType = SourceType::" " THEN
            ERROR(IncorrectSourceTypeErr, SourceType);

        CASE DtldCVLedgEntryBuf."Entry Type" OF
            DtldCVLedgEntryBuf."Entry Type"::"Unrealized Loss":
                BEGIN
                    CASE SourceType OF
                        SourceType::Customer:
                            BEGIN
                                TESTFIELD("Unrealized LossAcc.Receiv. FND");
                                EXIT("Unrealized LossAcc.Receiv. FND");
                            end;
                        SourceType::Vendor:
                            BEGIN
                                TESTFIELD("Unrealized LossAcc.Payable FND");
                                EXIT("Unrealized LossAcc.Payable FND");
                            end;
                    end;
                end;
            DtldCVLedgEntryBuf."Entry Type"::"Unrealized Gain":
                BEGIN
                    CASE SourceType OF
                        SourceType::Customer:
                            BEGIN
                                TESTFIELD("Unrealized GainAcc.Receiv. FND");
                                EXIT("Unrealized GainAcc.Receiv. FND");
                            end;
                        SourceType::Vendor:
                            BEGIN
                                TESTFIELD("Unrealized GainAcc.Payable FND");
                                EXIT("Unrealized GainAcc.Payable FND");
                            end;
                    end;
                end;
            DtldCVLedgEntryBuf."Entry Type"::"Realized Loss":
                BEGIN
                    CASE SourceType OF
                        SourceType::Customer:
                            BEGIN
                                TESTFIELD("Realized Loss Acc. Receiv. FND");
                                EXIT("Realized Loss Acc. Receiv. FND");
                            end;
                        SourceType::Vendor:
                            BEGIN
                                TESTFIELD("Realized Loss Acc. Payable FND");
                                EXIT("Realized Loss Acc. Payable FND");
                            end;
                    end;
                end;
            DtldCVLedgEntryBuf."Entry Type"::"Realized Gain":
                BEGIN
                    CASE SourceType OF
                        SourceType::Customer:
                            BEGIN
                                TESTFIELD("Realized Gain Acc. Receiv. FND");
                                EXIT("Realized Gain Acc. Receiv. FND");
                            end;
                        SourceType::Vendor:
                            BEGIN
                                TESTFIELD("Realized Gain Acc. Payable FND");
                                EXIT("Realized Gain Acc. Payable FND");
                            end;
                    end;
                end;
            else
                ERROR(IncorrectEntryTypeErr, DtldCVLedgEntryBuf."Entry Type");
        end;
        //HEI.02<<
    end;
}

