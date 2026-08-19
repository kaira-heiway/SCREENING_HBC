tableextension 50107 ItemChargeExtFND extends "Item Charge"
{
    // version NAVW110.0.00.15601,DITW110.00.11,HEI.08

    //DITW15.00.00.01 DDR 27/12/2007 added fields
    //                                  2034675 Type (+ key)
    // DITW15.00.00.01 DDR 02/01/2008 added fields
    //                                  2034650 Sales Tax (LCY)
    //                                  2034660 Purchases Tax (LCY)
    //                                added flowfilters
    //                                  2034684 Date Filter
    //                                  2034685 Global Dimension 1 Filter
    //                                  2034686 Global Dimension 2 Filter
    //                                  2034687 Location Filter
    // DITW15.00.00.01 DDR 02/01/2008 added functions
    //                                  ShowSalesItemChargeForm()
    //                                  ShowPurchItemChargeForm()
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                change optionstring values of fields "Item Charge Type"
    //                                change functions ShowSalesItemChargeForm;ShowPurchItemChargeForm
    //                                Added field
    //                                  2014410 Collapse + Default Yes (except " ",Discount,Promotion)
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.21 DDR 19/06/2008 Collapse default yes when only Item charge type <> blank
    //                                 (remove property Default value of field Collapse)
    //                               Updated field "Item Charge Type" + optionstring "ShippingCost"
    // DITW15.00.00.24 DDR 22/09/2008 Added fields
    //                                 2013715 Tax Formula
    //                                Added function LookupTaxSpecSearchCode()
    // DITW15.00.00.25 DDR 27/10/2008 Changed property AutoFormatType=2013661 for fields
    //                                  "Salse Tax (LCY)","Purchases Tax (LCY)"
    // DITW15.00.00.32 DDR 09/04/2009 Increase local variable lTempCode into function LookupTaxSpecSearchCode
    // DITW15.00.00.35 DDR 27/07/2009 Added fields
    //                                  2013827 Free Calculation Type
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 issue 172 Added fields
    //                                      2013824 Gen. Prod. Posting Free Group
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                               2013636 Split Deposit on Invoice
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 24/05/2013 DIT-770 #99 Added fields
    //                                           2014560 UK VAT Prod. Posting Group
    //                  04/06/2013 DIT-770 #99 Modified 'Caption' property field 2014560
    // DITW17.00.02 KSW 18/07/2013 DIT-715 #712 Added fields
    //                                           2014562 Tax UK Report Unit of Measure
    //                                           2014563 Tax UK Duty Rate Spec. Code
    //                                           2014564 Tax UK Recommend Retail Price
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.10.03 DDR 22/04/2014 DIT-770 #570 Added 'Dropdown' field Group
    // DITW18.00.06 MSF 15/05/2015 DIT-770 #1009 Extend Variable lTempCode Code[10] --> Code[20]  function LookupTaxSpecSearchCode
    // DITW18.00.07 DDR 20/02/2016 DIT-770 #1836 Added mandatory posting group values without item charge type value
    //                                           Bugfix check/clear DIT fields without item charge type or shipping Cost
    // DITW18.00.07 DDR 09/05/2016 DIT-770 #1836 Bugfix mandatory posting groups checking too early
    //                                           Remove Local property function TestPostingGroups()
    // DITW18.00.07 VSC 24/06/2016 DIT-770 #1836 Remove test on insert. User has no change to setup new record. due to this check
    // DITW18.00.07 VSC 24/06/2016 DIT-770 #1836 restore
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) New field 2014411 "Allow Invoice Disc."
    //                                                       New function "SetupNewRec"

    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 Added new field 2035390 "Show Item charge on Invoice"
    //                                        Added checks on the field's value depending on "Item Charge Type"
    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.02 CHG2055075 HT1156 IBM GAVANM0101 03.08.2020 # Sales Documents DRC
    //   # New fields for Sales Documents DRC: 50001, 50002, 50003, 50004
    // HEI.03 HB1868 - CHG2089493 IBM NASTAA02  17.11.2020 # Free Goods allow VAT calculation on item charge
    //   # # New Field created: 50005 - Allow VAT Calculation on Free
    // HEI.04 CHG2085435 IBM GAVANM01 25.11.2020 - HT1773 Sales documents layout
    //   # new fields added: 50006-Hide Item charge on printout and 50007-Show free amount on printout
    // HEI.05 CHG2107646 IBM SAMANR01 23.04.2021 - Defect # 6236
    //   # allow to change the "show item charge on invoice" option for item charges with Type=BLANK.
    // HEI.06 CHG2105027 HT1226 IBM GAVANM01 12.05.2021 #Sales Documents Brasco
    //   # new fields created: 50008 - ASDI, 50009 - TSB
    // NRQ#177003 DDR 29/03/2021 Add field 2013668 Tax Due Posting to G/L
    // HEI.08 CHG2344763 HB4566 COSTES04 26.02.2026 Ethiopia to Disaster Fund Risk Response
    //   # New field: Excld. Item Charge on Subtotal

    // BC Upgrade PATELS08 >>
    // # Tags is documentaion was missing - Added all the tags to documentation.
    // # Code related to the HEI.01 to HEI.06 was already there. Code related to HEI.08 was also partially present.
    // # Addeda new Feild 'Excld. Item Charge on Subtotal' - "Excld.ItemChargeOnSubtotal FND"
    // BC Upgrade PATELS08 <<

    // BC Upgrade SHUKLP03 >> Bug ID- BCUPO-193
    // # Added new field "Exclude/ Include in Print"
    // BC Upgrade SHUKLP03 << Bug ID- BCUPO-193

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Search Description")
        {
            CaptionML = ENU = 'Search Description', FRA = 'Désignation de recherche';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }

        //Unsupported feature: CodeModification on "Description(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Search Description" = UPPERCASE(xRec.Description)) OR ("Search Description" = '') THEN
          "Search Description" := Description;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Search Description" = UPPERCASE(xRec.Description)) or ("Search Description" = '') then
          "Search Description" := Description;
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Prod. Posting Group"(Field 3).OnValidate". Please convert manually.

        //trigger  Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN
          IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<DITW18.00.07 DDR 20/02/2016 09/05/2016 DIT-770 #1836
        if "Item Charge Type" = "Item Charge Type"::" " then
          TESTFIELD("Gen. Prod. Posting Group");
        // >>DITW18.00.07 DDR DIT-770 #1836
        if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
          if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") then
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;


        //Unsupported feature: CodeInsertion on ""VAT Prod. Posting Group"(Field 5)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW18.00.07 DDR 20/02/2016 09/05/2016 DIT-770 #1836
        if ("Item Charge Type" = "Item Charge Type"::" ") and (CurrFieldNo <> FIELDNO("Gen. Prod. Posting Group")) then
          TESTFIELD("VAT Prod. Posting Group");
        // >>DITW18.00.07 DDR DIT-770 #1836
        */
        //end;
        field(50000; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.01';
            TableRelation = "WHT Product Posting Group FND".Code;

        }
        field(50001; "FPI FND"; Boolean)
        {
            CaptionML = ENU = 'FPI',
                        FRA = 'FPI';
            Description = 'HEI.02';

            trigger OnValidate();
            begin
                //HEI.02>>
                if "FPI FND" then begin
                    //   TESTFIELD("Item Charge Type","Item Charge Type"::Tax); //<<BC Upgrade Priya
                    TESTFIELD("Excise Duties FND", false);
                    TESTFIELD("Consumption tax FND", false);
                end;
                //HEI.02<<
            end;
        }
        field(50002; "Excise Duties FND"; Boolean)
        {
            CaptionML = ENU = 'Excise Duties',
                        FRA = 'Droits d''accises';
            Description = 'HEI.02';

            trigger OnValidate();
            begin
                //HEI.02>>
                if "Excise Duties FND" then begin
                    // TESTFIELD("Item Charge Type","Item Charge Type"::Tax); //<<BC Upgrade Priya
                    TESTFIELD("FPI FND", false);
                    TESTFIELD("Consumption tax FND", false);
                end;
                //HEI.02<<
            end;
        }
        field(50003; "Consumption tax FND"; Boolean)
        {
            CaptionML = ENU = 'Consumption tax',
                        FRA = 'Taxe de consommation';
            Description = 'HEI.02';

            trigger OnValidate();
            begin
                //HEI.02>>
                if "Consumption tax FND" then begin
                    // TESTFIELD("Item Charge Type","Item Charge Type"::Tax); //<<BC Upgrade Priya
                    TESTFIELD("Excise Duties FND", false);
                    TESTFIELD("FPI FND", false);
                end;
                //HEI.02<<
            end;
        }
        field(50004; "Transport/Shipping Cost FND"; Boolean)
        {
            CaptionML = ENU = 'Incl. in Transport/Shipping Cost',
                        FRA = 'Frais de transport/expédition';
            Description = 'HEI.02';

            trigger OnValidate();
            begin
                //>>BC Upgrade Priya 
                /*
                //HEI.02>>
                if "Transport/Shipping Cost" then
                  TESTFIELD("Item Charge Type","Item Charge Type"::Discount); 
                //HEI.02<<
                */  //<<BC Upgrade Priya
            end;
        }
        field(50005; "Allow VAT Calc. on Free FND"; Boolean)
        {
            Caption = 'Allow VAT Calculation on Free';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(50006; "Hide Item chrg on printout FND"; Boolean)
        {
            caption = 'Hide Item chrg on printout';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50007; "Show free amt on printout FND"; Boolean)
        {
            caption = 'Show free amt on printout';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(50008; "ASDI FND"; Boolean)
        {
            caption = 'ASDI';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(50009; "TSB FND"; Boolean)
        {
            caption = 'TSB';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }

        // BC Upgrade SHUKLP03 >> Bug ID- BCUPO-193
        field(50013; "Exclude/ Include in Print FND"; option)
        {
            Caption = 'Exclude/ Include in Print';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Free_VAT,Free_DISC;
            OptionCaption = ' ,EXP_VAT,Free_DISC';
        }
        // BC Upgrade SHUKLP03 << Bug ID- BCUPO-193

        //BC UPGRADE KUMARR78 FDD-MTC-008 >> Adding Field with New ID
        field(50094; "Show Item charge on Inv. FND"; Option)
        {
            Caption = 'Show Item charge on Invoice';
            OptionCaption = ' ,Under item line,Include in item price,Order total';
            OptionMembers = " ","Under item line","Include in item price","Order total";
        }

        // BC Upgrade PATELS08 >>
        field(50095; "Excld.Item Chrg OnSubtotal FND"; Boolean)
        {
            Caption = 'Exclude Item Charge on Subtotal';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        // BC Upgrade PATELS08 <<
        //#BCUP0-RTR-BPM Item Charges BC Upgrade KAIRAR01 >>
        field(50096; "Shipping Cost BPM FND"; Boolean)
        {
            Caption = 'Shipping Cost BPM';
            DataClassification = ToBeClassified;
        }
        //#BCUP0-RTR-BPM Item Charges BC Upgrade KAIRAR01 <<

        //BC UPGRADE KUMARR78 FDD-MTC-008 << Adding Field with New ID
        //>>BC Upgrade Priya 
        /*field(2013636;"Split Deposit on Invoice";Boolean)
        {
            CaptionML = ENU='Split Deposit on Invoice (Entries)',
                        FRA='Diviser consigne sur facture (écritures)';
            Description = 'DITW16.00.00.42 DIT-715 #370';

            trigger OnValidate();
            begin
                // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                if "Split Deposit on Invoice" then
                  TESTFIELD("Item Charge Type","Item Charge Type"::Deposit);
                // >>DITW16.00.00.42 DDR DIT-715 #370
            end;
        }
        field(2013640;"Sales Deposit (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Deposit Amount (Actual)" WHERE ("Item Ledger Entry Type"=CONST(Sale),
                                                                                   "Item Charge No."=FIELD("No."),
                                                                                   "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                                   "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                                   "Location Code"=FIELD("Location Filter"),
                                                                                   "Posting Date"=FIELD("Date Filter")));
            CaptionML = ENU='Sales Deposit (LCY)',
                        FRA='Consigne vente DS';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013650;"Purchases Deposit (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Purchase Deposit Amt. (Actual)" WHERE ("Item Ledger Entry Type"=CONST(Purchase),
                                                                                    "Item Charge No."=FIELD("No."),
                                                                                    "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                                    "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                                    "Location Code"=FIELD("Location Filter"),
                                                                                    "Posting Date"=FIELD("Date Filter")));
            CaptionML = ENU='Purchases Deposit (LCY)',
                        FRA='Consigne achat DS';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013668;"Tax Due Posting to G/L";Boolean)
        {
            AutoFormatType = 2013661;
            Caption = 'Tax Due Posting to G/L';
            DataClassification = ToBeClassified;
            Description = 'NRQ#177003';

            trigger OnValidate();
            begin
                //<<NRQ#177003 DDR 29/03/2021
                if "Tax Due Posting to G/L" then
                  TESTFIELD("Item Charge Type","Item Charge Type"::Discount);
                //>>NRQ#177003 DDR 29/03/2021
            end;
        }
        field(2013670;"Sales Tax (LCY)";Decimal)
        {
            AutoFormatType = 2013661;
            CalcFormula = Sum("Value Entry"."Sales Tax Amount (Actual)" WHERE ("Item Ledger Entry Type"=CONST(Sale),
                                                                               "Item Charge No."=FIELD("No."),
                                                                               "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                               "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                               "Location Code"=FIELD("Location Filter"),
                                                                               "Posting Date"=FIELD("Date Filter")));
            CaptionML = ENU='Sales Tax (LCY)',
                        FRA='Taxe vente DS';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013680;"Purchases Tax (LCY)";Decimal)
        {
            AutoFormatType = 2013661;
            CalcFormula = Sum("Value Entry"."Purchase Tax Amount (Actual)" WHERE ("Item Ledger Entry Type"=CONST(Purchase),
                                                                                  "Item Charge No."=FIELD("No."),
                                                                                  "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                                  "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                                  "Location Code"=FIELD("Location Filter"),
                                                                                  "Posting Date"=FIELD("Date Filter")));
            CaptionML = ENU='Purchases Tax (LCY)',
                        FRA='Taxe achat DS';
            Description = 'DITW15.00.00.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013695;"Item Charge Type";Option)
        {
            CaptionML = ENU='Type',
                        FRA='Type';
            Description = 'DITW15.00.00.01';
            OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                              FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;

            trigger OnValidate();
            begin
                // <<DITW15.00.00.01 DDR 23/01/2008 - DITW15.00.00.21 DDR 19/06/2008
                case "Item Charge Type" of
                  "Item Charge Type"::" ",
                  "Item Charge Type"::Discount,
                  "Item Charge Type"::Promotion,
                  "Item Charge Type"::ShippingCost:
                    Collapse := false;
                  else
                    Collapse := true;
                end;
                // >>DITW15.00.00.21 DDR

                // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
                if "Item Charge Type" in  ["Item Charge Type"::" ","Item Charge Type"::ShippingCost] then begin
                  CLEAR("Gen. Prod. Posting Free Group");
                  CLEAR("Free Calculation Type");
                  CLEAR(Collapse);
                end;
                // >>DITW18.00.07 DDR DIT-770 #1836

                // <<DITW15.00.00.24 DDR 22/09/2008
                if "Item Charge Type" <> "Item Charge Type"::Tax then begin
                  // <<DITW17.00.01 DDR 18/03/2013 DIT-770 #001
                  CLEAR("Tax Group Code");
                  // >>DITW17.00.01 DDR DIT-770 #001
                  CLEAR("Tax Formula");
                end;
                // >>DITW15.00.00.24 DDR
                // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                if "Item Charge Type" <> "Item Charge Type"::Deposit then
                  CLEAR("Split Deposit on Invoice");
                // >>DITW16.00.00.42 DDR DIT-715 #370
                //<< DITW110.00.11 AKH 02/11/2017 NRQ#43605
                case "Item Charge Type" of
                "Item Charge Type"::Tax:
                  "Show Item charge on Invoice" := "Show Item charge on Invoice"::"Include in item price";
                 "Item Charge Type"::Deposit:
                  "Show Item charge on Invoice" := "Show Item charge on Invoice"::"Order total";
                 "Item Charge Type"::Discount:
                  "Show Item charge on Invoice" := "Show Item charge on Invoice"::"Include in item price";
                 "Item Charge Type"::" ","Item Charge Type"::ShippingCost:
                   "Show Item charge on Invoice" := "Show Item charge on Invoice"::" ";
                end;
                //>> DITW110.00.11 AKH NRQ#43605
            end;
        }
        field(2013704;"Date Filter";Date)
        {
            CaptionML = ENU='Date Filter',
                        FRA='Filtre date';
            Description = 'DITW15.00.00.01';
            FieldClass = FlowFilter;
        }
        field(2013705;"Global Dimension 1 Filter";Code[20])
        {
            CaptionClass = '1,3,1';
            CaptionML = ENU='Global Dimension 1 Filter',
                        FRA='Filtre axe principal 1';
            Description = 'DITW15.00.00.01';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));
        }
        field(2013706;"Global Dimension 2 Filter";Code[20])
        {
            CaptionClass = '1,3,2';
            CaptionML = ENU='Global Dimension 2 Filter',
                        FRA='Filtre axe principal 2';
            Description = 'DITW15.00.00.01';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));
        }
        field(2013707;"Location Filter";Code[10])
        {
            CaptionML = ENU='Location Filter',
                        FRA='Filtre magasin';
            Description = 'DITW15.00.00.01';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(2013715;"Tax Formula";Code[80])
        {
            CaptionML = ENU='Tax Formula',
                        FRA='Formule taxe';
            Description = 'DITW15.00.00.24';

            trigger OnValidate();
            begin
                if "Tax Formula" <> '' then
                  TESTFIELD("Item Charge Type","Item Charge Type"::Tax);

                TaxSpecCalcMgt.CheckFormula("Tax Formula");
            end;
        }
        field(2013824;"Gen. Prod. Posting Free Group";Code[10])
        {
            CaptionML = ENU='Gen. Prod. Posting Group Free Item',
                        FRA='Groupe article gratuit compta. produit';
            Description = 'DITW16.00.00.40 DDR DIT-715 #172';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
                if "Gen. Prod. Posting Group" <> '' then
                  TESTFIELD("Item Charge Type");
                // >>DITW18.00.07 DDR DIT-770 #1836
            end;
        }
        field(2013827;"Free Calculation Type";Option)
        {
            CaptionML = ENU='Free Calculation Type',
                        FRA='Calculer sur gratuit';
            Description = 'DITW15.00.00.35';
            OptionCaptionML = ENU='None,Discount 100%,All',
                              FRA='Aucun,Remise 100%,Montant';
            OptionMembers = "None","Discount 100%",All;

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
                if "Free Calculation Type" <> "Free Calculation Type"::None then
                  TESTFIELD("Item Charge Type");
                // >>DITW18.00.07 DDR DIT-770 #1836
            end;
        }
        field(2014410;Collapse;Boolean)
        {
            CaptionML = ENU='Collapse',
                        FRA='Réduire';
            Description = 'DITW15.00.00.01';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
                if Collapse then
                  TESTFIELD("Item Charge Type");
                // >>DITW18.00.07 DDR DIT-770 #1836
            end;
        }
        field(2014411;"Allow Invoice Disc.";Boolean)
        {
            CaptionML = ENU='Allow Invoice Disc.',
                        FRA='Autoriser remise ligne';
            Description = 'DITW19.00.08 BL#10868';
        }
        field(2035390;"Show Item charge on Invoice";Option)
        {
            Caption = 'Show Item charge on Invoice';
            Description = 'DITW110.00.11 NRQ#43605';
            OptionCaption = '" ,Under item line,Include in item price,Order total"';
            OptionMembers = " ","Under item line","Include in item price","Order total";

            trigger OnValidate();
            begin
                
                //<< DITW110.00.11 AKH 02/11/2017 NRQ#43605
                if (("Item Charge Type" = "Item Charge Type"::Tax) and (not("Show Item charge on Invoice" in ["Show Item charge on Invoice"::"Include in item price","Show Item charge on Invoice"::" ","Show Item charge on Invoice"::"Under item line"]))) or
                   (("Item Charge Type" = "Item Charge Type"::Deposit) and ("Show Item charge on Invoice" <> "Show Item charge on Invoice"::"Order total")) or
                   (("Item Charge Type" in ["Item Charge Type"::ShippingCost]) and ("Show Item charge on Invoice" <> "Show Item charge on Invoice"::" ")) then
                      FIELDERROR("Show Item charge on Invoice");
                //>> DITW110.00.11 AKH NRQ#43605
                
            end;
    }*/  //<<BC Upgrade Priya
    }
    keys
    {
        //>>BC Upgrade Priya 
        /* key(Key1;"Item Charge Type") 
         {
         }
         */  //<<BC Upgrade Priya
    }


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
    TestPostingGroups;
    // >>DITW18.00.07 DDR DIT-770 #1836
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DimMgt.UpdateDefaultDim(
      DATABASE::"Item Charge","No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
    TestPostingGroups;
    // >>DITW18.00.07 DDR DIT-770 #1836
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: InsertAfter on "(FieldGroup: DropDown)". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        GLSetup: Record "General Ledger Setup";
        //>>BC Upgrade Priya   
        /* SalesTaxItemCharge : Record "Sales Tax Item Charge";
         PurchTaxItemCharge : Record "Purchase Tax Item Charge";
         SalesDepositItemCharge : Record "Sales Deposit Item Charge";
         PurchDepositItemCharge : Record "Purchase Deposit Item Charge";
         SalesDiscountItemCharge : Record "Sales Discount Item Charge";
         PurchDiscountItemCharge : Record "Purchase Discount Item Charge";
         TaxSpecMgt : Codeunit "Tax Spec. Management";
         TaxSpecCalcMgt : Codeunit "Tax Spec. Formula Mgt.";
         */ //<<BC Upgrade PRIYA
        Text2014562: TextConst ENU = 'An item charge cannot contain a value for %1 and %2.', FRA = 'Un article ne peut peut pas avoir la valeur pour %1 et %2';
}

