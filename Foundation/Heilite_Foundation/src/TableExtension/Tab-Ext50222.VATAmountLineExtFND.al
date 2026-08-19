tableextension 50222 VATAmountLineExtFND extends "VAT Amount Line"
{
    // DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    // IPLXL9.00.001 IMI 06/08/2015: Added function fctInsertLineEDI

    // FINXL10.0 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Fields created: 50004 - CAD Amount
    //                         50005 - Amount Incl. VAT and CAD
    //                         50006 - Calculated CAD Amount
    //                         50007 - CAD %
    //   # New functions created: 'UpdateCADAmount', 'GetTotalCADAmount'
    //   # Code added on function "UpdateLines"
    // HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field created: 50008 - Operation Type
    //                        50009 - CAD Difference
    //   # Code added
    // HEI.03 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   #New field created: #H&S Levy Tax %
    //                       #H&S Levy Tax Amount

    fields
    {
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
        }
        modify("VAT Base")
        {
            CaptionML = ENU = 'VAT Base', FRA = 'Base TVA';
        }
        modify("VAT Amount")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
        }
        modify("Amount Including VAT")
        {
            CaptionML = ENU = 'Amount Including VAT', FRA = 'Montant TTC';
        }
        modify("VAT Identifier")
        {
            CaptionML = ENU = 'VAT Identifier', FRA = 'Identifiant TVA';
        }
        modify("Line Amount")
        {
            CaptionML = ENU = 'Line Amount', FRA = 'Montant ligne';
        }
        modify("Inv. Disc. Base Amount")
        {
            CaptionML = ENU = 'Inv. Disc. Base Amount', FRA = 'Montant base remise facture';
        }
        modify("Invoice Discount Amount")
        {
            CaptionML = ENU = 'Invoice Discount Amount', FRA = 'Montant remise facture';
        }
        modify("VAT Calculation Type")
        {
            CaptionML = ENU = 'VAT Calculation Type', FRA = 'Mode calcul TVA';
            // OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify(Modified)
        {
            CaptionML = ENU = 'Modified', FRA = 'Modifié';
        }
        modify("Use Tax")
        {
            CaptionML = ENU = 'Use Tax', FRA = 'Use Tax';
        }
        modify("Calculated VAT Amount")
        {
            CaptionML = ENU = 'Calculated VAT Amount', FRA = 'Montant TVA calculée';
        }
        modify("VAT Difference")
        {
            CaptionML = ENU = 'VAT Difference', FRA = 'Différence TVA';
        }
        modify(Positive)
        {
            CaptionML = ENU = 'Positive', FRA = 'Positif';
        }
        modify("Includes Prepayment")
        {
            CaptionML = ENU = 'Includes Prepayment', FRA = 'Acompte inclus';
        }
        modify("VAT Clause Code")
        {
            CaptionML = ENU = 'VAT Clause Code', FRA = 'Code clause TVA';
        }
        modify("Tax Category")
        {
            CaptionML = ENU = 'Tax Category', FRA = 'Catégorie de taxe';
        }
        field(50003; "Reverse Charge VAT % FND"; Decimal)
        {
            Caption = 'Reverse Charge VAT %';
            DecimalPlaces = 0 : 0;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50004; "CAD Amount FND"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50005; "Amount Incl. VAT and CAD FND"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Incl. VAT and CAD';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50006; "Calculated CAD Amount FND"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Calculated CAD Amount';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50007; "CAD % FND"; Decimal)
        {
            Caption = 'CAD %';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            Editable = false;
        }
        field(50008; "Operation Type FND"; Option)
        {
            Caption = 'Operation Type';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Editable = false;
            OptionCaption = '" ,Sales,Purchase"';
            OptionMembers = " ",Sales,Purchase;
        }
        field(50009; "CAD Difference FND"; Decimal)
        {
            Caption = 'CAD Difference';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Editable = false;
        }
        field(50010; "H&S Levy Tax % FND"; Decimal)
        {
            Caption = 'H&S Levy Tax %';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "H&S Tax Posting Group FND";
        }
        field(50011; "H&S Levy Tax Amount FND"; Decimal)
        {
            Caption = 'H&S Levy Tax Amount';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.





    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=%1% VAT;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=%1% VAT;FRA=TVA %1%;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=VAT Amount;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=VAT Amount;FRA=Montant TVA;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=%1 must not be negative.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=%1 must not be negative.;FRA=%1 ne doit pas être négatif.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "InvoiceDiscAmtIsGreaterThanBaseAmtErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //InvoiceDiscAmtIsGreaterThanBaseAmtErr : @@@=1 Invoice Discount Amount that should be set 2 Maximum Amount that you can assign;ENU=The maximum %1 that you can apply is %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvoiceDiscAmtIsGreaterThanBaseAmtErr : @@@=1 Invoice Discount Amount that should be set 2 Maximum Amount that you can assign;ENU=The maximum %1 that you can apply is %2.;FRA=Le %1 maximal que vous pouvez lettrer est %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU="%1 for %2 must not exceed %3 = %4.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU="%1 for %2 must not exceed %3 = %4.";FRA="La %1 du %2 ne doit pas dépasser la %3 = %4.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU="%1 must not exceed %2 = %3.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU="%1 must not exceed %2 = %3.";FRA="%1 ne doit pas dépasser %2 = %3.";
    //Variable type has not been exported.
    //BC Upgrade SHARMP16 BEGIN>>
    procedure UpdateCADAmount(CADAmount: Decimal; CADPercent: Decimal; OperationType: Integer)
    var
        myInt: Integer;
    begin
        //HEI.01>>
        "CAD Amount FND" := CADAmount;
        "CAD % FND" := CADPercent;
        //HEI.02>>
        //"Calculated CAD Amount" := CADAmount;
        "Operation Type FND" := OperationType;
        //HEI.02<<
        MODIFY();
        //HEI.01<<

    end;

    procedure GetTotalCADAmount(): Decimal
    var
        myInt: Integer;
    begin
        //HEI.01>>
        CALCSUMS("CAD Amount FND");
        EXIT("CAD Amount FND");
        //HEI.01<<
    end;
    //BC upgrade SHARMP16 END<<
    procedure UpdateLevyTaxAmount(HSLevyAmount: Decimal; HSLevyPercent: Decimal)
    var
        myInt: Integer;
    begin
        //HEI.03>>
        "H&S Levy Tax Amount FND" := HSLevyAmount;
        "H&S Levy Tax % FND" := HSLevyPercent;
        MODIFY();
        //HEI.03<<
    end;

    var
        VATPostingSetup: Record "VAT Posting Setup";
}

