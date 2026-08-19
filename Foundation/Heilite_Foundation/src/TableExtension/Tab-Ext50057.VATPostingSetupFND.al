tableextension 50057 VATPostingSetupExtFND extends "VAT Posting Setup"
{
    // FINXL7.00.001 RBE 20/03/2013 : Created fields "Standard Text (Invoice)" and "Standard Text (Cr.Memo)"

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-OTCGAP01 IBM ISYED01 28.11.2017
    //   #added Fiscal Printer Tax Identifier to the table
    // HEI.02 FDD-HB1609 CHG2074002 IBM BULIMC01 26.08.2020 #new field added: 50004- "Free Goods VAT (HNK)"
    // HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Fields created: 50005 - CAD %
    //                         50006- Sales CAD Account

    fields
    {
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("VAT Calculation Type")
        {
            CaptionML = ENU = 'VAT Calculation Type', FRA = 'Mode calcul TVA';
            // OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
        }
        modify("Unrealized VAT Type")
        {
            CaptionML = ENU = 'Unrealized VAT Type', FRA = 'Type TVA sur encaissement';
            OptionCaptionML = ENU = ' ,Percentage,First,Last,First (Fully Paid),Last (Fully Paid)', FRA = ' ,Pourcentage,Premier,Dernier,Premier (payé entièrement),Dernier (payé entièrement)';
        }
        modify("Adjust for Payment Discount")
        {
            CaptionML = ENU = 'Adjust for Payment Discount', FRA = 'Ajuster pour escompte';
        }
        modify("Sales VAT Account")
        {
            CaptionML = ENU = 'Sales VAT Account', FRA = 'Compte TVA vente';
        }
        modify("Sales VAT Unreal. Account")
        {
            CaptionML = ENU = 'Sales VAT Unreal. Account', FRA = 'Cpte TVA/encaissement vente';
        }
        modify("Purchase VAT Account")
        {
            CaptionML = ENU = 'Purchase VAT Account', FRA = 'Compte TVA achat';
        }
        modify("Purch. VAT Unreal. Account")
        {
            CaptionML = ENU = 'Purch. VAT Unreal. Account', FRA = 'Cpte TVA/décaissement achat';
        }
        modify("Reverse Chrg. VAT Acc.")
        {
            CaptionML = ENU = 'Reverse Chrg. VAT Acc.', FRA = 'Compte TVA due intracomm.';
        }
        modify("Reverse Chrg. VAT Unreal. Acc.")
        {
            CaptionML = ENU = 'Reverse Chrg. VAT Unreal. Acc.', FRA = 'Cpte TVA due intra./décaisst';
        }
        modify("VAT Identifier")
        {
            CaptionML = ENU = 'VAT Identifier', FRA = 'Identifiant TVA';
        }
        modify("EU Service")
        {
            CaptionML = ENU = 'EU Service', FRA = 'Service UE';
        }
        modify("VAT Clause Code")
        {
            CaptionML = ENU = 'VAT Clause Code', FRA = 'Code clause TVA';
        }
        modify("Certificate of Supply Required")
        {
            CaptionML = ENU = 'Certificate of Supply Required', FRA = 'Certificat d''approvisionnement requis';
        }
        modify("Tax Category")
        {
            CaptionML = ENU = 'Tax Category', FRA = 'Catégorie de taxe';
        }

        //Unsupported feature: CodeInsertion on ""VAT Calculation Type"(Field 3)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //soicad>>
        if "VAT Calculation Type" <> "VAT Calculation Type"::"Reverse Charge VAT" then
          "Reverse Charge VAT %" := 0;
        //soicad
        */
        //end;


        //Unsupported feature: CodeModification on ""Unrealized VAT Type"(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestNotSalesTax(FIELDCAPTION("Unrealized VAT Type"));

        IF "Unrealized VAT Type" > 0 THEN BEGIN
          GLSetup.GET;
          IF NOT GLSetup."Unrealized VAT" AND NOT GLSetup."Prepayment Unrealized VAT" THEN
            GLSetup.TESTFIELD("Unrealized VAT",TRUE)
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestNotSalesTax(FIELDCAPTION("Unrealized VAT Type"));

        if "Unrealized VAT Type" > 0 then begin
          GLSetup.GET;
          if not GLSetup."Unrealized VAT" and not GLSetup."Prepayment Unrealized VAT" then
            GLSetup.TESTFIELD("Unrealized VAT",true)
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Adjust for Payment Discount"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestNotSalesTax(FIELDCAPTION("Adjust for Payment Discount"));

        IF "Adjust for Payment Discount" THEN BEGIN
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",TRUE);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestNotSalesTax(FIELDCAPTION("Adjust for Payment Discount"));

        if "Adjust for Payment Discount" then begin
          GLSetup.GET;
          GLSetup.TESTFIELD("Adjust for Payment Disc.",true);
        end;
        */
        //end;
        field(50001; "Fiscal PrintTax Identifier FND"; Text[2])
        {
            Description = 'HEI.01';
            Caption = 'Fiscal Printer Tax Identifier';
        }
        field(50002; "Top Gross WHT Deductible FND"; Boolean)
        {
            Description = 'soicad';
            Caption = 'Top Gross WHT Deductible';
        }
        field(50003; "Reverse Charge VAT % FND"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MaxValue = 100;
            MinValue = 0;
            Caption = 'Reverse Charge VAT %';

            trigger OnValidate();
            begin
                //soicad>>
                if "Reverse Charge VAT % FND" <> 0 then
                    TESTFIELD("VAT Calculation Type", "VAT Calculation Type"::"Reverse Charge VAT");
                //soicad<<
            end;
        }
        field(50004; "Free Goods VAT (HNK) FND"; Code[10])
        {
            Description = 'HEI.02';
            Caption = 'Free Goods VAT (HNK)';
            TableRelation = "G/L Account";
        }
        field(50005; "CAD % FND"; Decimal)
        {
            Caption = 'CAD %';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            MinValue = 0;
        }
        field(50006; "Sales CAD Account FND"; Code[20])
        {
            Caption = 'Sales CAD Account';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "G/L Account";
        }
        // BC Upgrade NANDIS03 - DIT fields blocked>>
        // field(2029610; "Create Intrastat Ledg. Entries"; Boolean)
        // {
        //     CaptionML = ENU = 'Create Intrastat Ledg. Entries',
        //                 FRA = 'Période Window';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029611; "Standard Text (Invoice)"; Code[10])
        // {
        //     CaptionML = ENU = 'Standard Text (Invoice)',
        //                 FRA = 'Texte standard (Facture)';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Standard Text".Code;
        // }
        // field(2029612; "Standard Text (Cr.Memo)"; Code[10])
        // {
        //     CaptionML = ENU = 'Standard Text (Cr.Memo)',
        //                 FRA = 'Texte standard (Avoir)';
        //     Description = 'FINXL7.00.001';
        //     TableRelation = "Standard Text".Code;
        // }
        // BC Upgrade NANDIS03 - DIT fields blocked <<
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "VAT %" = 0 THEN
      "VAT %" := GetVATPtc;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if "VAT %" = 0 then
      "VAT %" := GetVATPtc;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=%1 must be entered on the tax jurisdiction line when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=%1 must be entered on the tax jurisdiction line when %2 is %3.;FRA=%1 doit être entré(e) sur la ligne USA autorités recouvrement quand %2 est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU="%1 = %2 has already been used for %3 = %4 in %5 for %6 = %7 and %8 = %9.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU="%1 = %2 has already been used for %3 = %4 in %5 for %6 = %7 and %8 = %9.";FRA="%1 = %2 a déjà été utilisé pour %3 = %4 dans %5, pour %6 = %7 et %8 = %9.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DuplicateEntryErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DuplicateEntryErr : ENU=Another entry with the same %1 in the same %2 has a different %3 assigned. Use the same %3 or remove it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DuplicateEntryErr : ENU=Another entry with the same %1 in the same %2 has a different %3 assigned. Use the same %3 or remove it.;FRA=Une autre écriture portant le même %1 dans le même %2 s'est vue attribuer un %3 différent. Utilisez le même %3 ou supprimez-le.;
    //Variable type has not been exported.
}

