pageextension 51036 ItemChargesExtCBN extends "Item Charges"
{
    // DITW15.00.00.01 DDR 27/12/2007 added fields
    //                                  2034675 Type
    // DITW15.00.00.01 DDR 03/01/2008 added buttons Sales & Purchases about setup charges
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                Added field "Collapse"
    // DITW15.00.00.01 DDR 19/08/2008 Added default value field "Item Charge Type" with its filter
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.21 DDR 19/06/2008 Updated field "Item Charge Type" + optionstring "ShippingCost"
    // DITW15.00.00.24 DDR 22/09/2008 Added field "Tax Formula"
    // DITW15.00.00.35 DDR 27/07/2009 Added field "Free Calculation Type"
    // DITW15.00.00.37 DDR 19/01/2010 Added form property DataCaptionFields
    // DITW15.00.00.38 DDR 10/12/2010 issue 1220 Moved Item Charge Card to Page2014439
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 issue 172 Added fields "Gen. Prod. Posting Free Group"
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Split Deposit on Invoice" into 'Drink-It' tab

    // DITW17.00.02 DDR 24/05/2013 DIT-770 #99 Added fields "UK VAT Prod. Posting Group"
    // DITW17.00.02 KSW 18/07/2013 DIT-715 #712 Added fields
    //                                            Tax UK Report Unit of Measure
    //                                            Tax UK Duty Rate Spec. Code
    //                                            Tax UK Recommend Retail Price
    //                  08/08/2013 DIT-770 #101 Added fields "Hidden on Report W1"
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99 #101
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW18.00.07 DDR 20/02/2016 DIT-770 #1836 Added mandatory posting group values without item charge type value
    //                                           Added 'DelayedInsert' page property
    // DITW19.00.08 SFI 18/08/2016 BL#10868  (DIT-770 #2141) Added field 2014411 "Allow Invoice Disc."

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 AKH 02/11/2017 NRQ#43605 Added field "Show Item charge on Invoice"
    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New fields for MDM integration: "WHT Product Posting Group"
    // HEI.02 CHG2055075 HT1156 IBM GAVANM0101 03.08.2020 # Sales Documents DRC
    //   # New fields for Sales Documents DRC: Excise Duties, FPI, Consumption Tax, Transport/Shipping Cost
    // HEI.03 HB1868 - CHG2089493 IBM NASTAA02  17.11.2020 # Free Goods allow VAT calculation on item charge
    //   # New Field added: "Allow VAT Calculation on Free"
    // HEI.04 CHG2085435 IBM GAVANM01 25.11.2020 - HT1773 Sales documents layout
    //   # new fields added: "Hide Item charge on printout" and "Show free amount on printout"
    // HEI.05 CHG2105027 HT1226 IBM GAVANM01 12.05.2021 #Sales Documents Brasco
    //   # new fields added: ASDI, TSB
    // HEI.07 CHG2344763 HB4566 COSTES04 26.02.2026 Ethiopia to Disaster Fund Risk Response
    //   # New field: Excld. Item Charge on Subtotal

    //BC UPGRADE KUMARR78 FDD-MTC-008 >>
    //1. Adding Show Item charge on Invoice Field
    //BC UPGRADE KUMARR78 FDD-MTC-008 <<

    // BC UPGRADE PATELS08 >>
    // # Added new field as per Tag HEI.07
    // BC UPGRADE PATELS08 <<

    // BC Upgrade SHUKLP03 >> Bug ID- BCUPO-193
    // # Added new field "Exclude/ Include in Print"
    // BC Upgrade SHUKLP03 << Bug ID- BCUPO-193

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number used for identifying a specific kind of item charge.', FRA = 'Spécifie le numéro utilisé pour identifier des frais annexes spécifiques.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item charge number that you are setting up.', FRA = 'Spécifie la description du numéro de frais annexes que vous paramétrez.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the general product posting group to which this item charge belongs.', FRA = 'Spécifie le groupe comptabilisation produit auquel ces frais annexes appartiennent.';
            ShowMandatory = GenProdPostGrMandatory;
        }
        modify("Tax Group Code")
        {
            ToolTipML = ENU = 'Specifies the sales tax group code that this item charge belongs to.', FRA = 'Indique le code groupe taxes vente par défaut de ces frais annexes.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the VAT product posting group to which this item charge belongs.', FRA = 'Spécifie le groupe comptabilisation produit TVA auquel ces frais annexes appartiennent.';
        }
        modify("Search Description")
        {
            Visible = true;
            ToolTipML = ENU = 'Specifies text to search for when you do not know the number of the item.', FRA = 'Spécifie le texte à rechercher lorsque vous ne connaissez pas le numéro de l''article.';
        }

        addafter(Description)
        {
            //>>BC Upgrade Priya
            /*field("Item Charge Type"; "Item Charge Type")  
            {
                Description = 'DITW15.00.00.15';
                OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,,,Shipping Cost',
                                  FRA = ' ,Taxe,Consigne,Remise,,,Coût Transport';

                trigger OnValidate();
                begin
                    // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
                    ActivateFields;
                    // >>DITW18.00.07 DDR DIT-770 #1836
                end;
            }
            field(Collapse; Collapse)
            {
            }
            field("Free Calculation Type"; "Free Calculation Type")
            {
            }*/  //<<BC Upgrade Priya
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("WHT Product Posting Group"; REC."WHT Product Posting Group FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
            }
            //>>BC Upgrade Priya 
            /*field("Gen. Prod. Posting Free Group"; "Gen. Prod. Posting Free Group")
            {
                ShowMandatory = VatProdPostGrMandatory;
            }*/ //<<BC Upgrade Priya
        }
        addafter("VAT Prod. Posting Group")
        {
            //>>BC Upgrade Priya 
            /*field("Tax Formula"; "Tax Formula")
            {
                Visible = false;

                trigger OnLookup(Text: Text): Boolean;
                begin
                    // <<DITW15.00.00.24 DDR 22/09/2008
                    exit(LookupTaxSpecSearchCode(Text));
                end;
            }
            field("Split Deposit on Invoice"; "Split Deposit on Invoice")
            {
            }*/ //<<BC Upgrade Priya
        }

        addafter("Search Description")
        {
            //>>BC Upgrade Priya 
            /*field("Allow Invoice Disc."; "Allow Invoice Disc.")
            {
            }
            field("Show Item charge on Invoice"; "Show Item charge on Invoice")
            {
            }
            */ //<<BC Upgrade Priya
               //BC UPGRADE KUMARR78 FDD-MTC-008 >>
            field("Show Item charge on Invoice"; Rec."Show Item charge on Inv. FND")
            {
                ApplicationArea = all;
            }
            //BC UPGRADE KUMARR78 FDD-MTC-008 <<
            field(FPI; REC."FPI FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the FPI field.';
            }
            field("Excise Duties"; REC."Excise Duties FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Excise Duties field.';
            }
            field("Consumption tax"; REC."Consumption tax FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Consumption tax field.';
            }
            field("Transport/Shipping Cost"; REC."Transport/Shipping Cost FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Transport/Shipping Cost field.';
            }
            field("Allow VAT Calculation on Free"; REC."Allow VAT Calc. on Free FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Allow VAT Calculation on Free field.';
            }
            field("Hide Item charge on printout"; REC."Hide Item chrg on printout FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Hide Item charge on printout field.';
            }
            field("Show free amount on printout"; REC."Show free amt on printout FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Show free amount on printout field.';
            }
            field(ASDI; REC."ASDI FND")
            {
                ApplicationArea = all;
                Description = 'HEI.05';
                ToolTip = 'Specifies the value of the ASDI field.';
            }
            field(TSB; REC."TSB FND")
            {
                ApplicationArea = all;
                Description = 'HEI.05';
                ToolTip = 'Specifies the value of the TSB field.';
            }
            //>>BC Upgrade Priya 
            /*field("Tax Due Posting to G/L"; "Tax Due Posting to G/L")
            {
            }*/  //<<BC Upgrade Priya

            // BC UPGRADE PATELS08 >>
            field("Excld. Item Charge on Subtotal"; Rec."Excld.Item Chrg OnSubtotal FND")
            {
                ApplicationArea = all;
                Description = 'HEI.07';
            }
            // BC UPGRADE PATELS08 <<
            //#BCUP0-RTR-BPM Item Charges BC Upgrade KAIRAR01 >>
            field("Shipping Cost BPM FND"; Rec."Shipping Cost BPM FND")
            {
                ApplicationArea = All;
                Caption = 'Shipping Cost BPM';
                ToolTip = 'Specifies whether the item charge is a shipping cost for BPM.';
            }
            //#BCUP0-RTR-BPM Item Charges BC Upgrade KAIRAR01 <<
        }
        // BC Upgrade SHUKLP03 >> Bug ID- BCUPO-193
        addafter("Hide Item charge on printout")
        {
            field("Exclude/ Include in Print"; Rec."Exclude/ Include in Print FND")
            {
                ApplicationArea = All;
            }
        }
        // BC Upgrade SHUKLP03 << Bug ID- BCUPO-193
    }
    actions
    {
        modify("&Item Charge")
        {
            CaptionML = ENU = '&Item Charge', FRA = 'F&rais annexes';
        }
        modify("Value E&ntries")
        {
            CaptionML = ENU = 'Value E&ntries', FRA = 'É&critures valeur';

            //Unsupported feature: Change RunPageView on ""Value E&ntries"(Action 17)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Value E&ntries"(Action 17)". Please convert manually.

        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

            //Unsupported feature: Change RunPageLink on "Dimensions(Action 19)". Please convert manually.

        }
        // addafter("&Item Charge")
        // {
        //     //>>BC Upgrade Priya 
        //     group("S&ales")
        //     {
        //         CaptionML = ENU = 'S&ales',
        //                      FRA = '&Ventes';
        //         action("Setup Charges")
        //         {
        //             CaptionML = ENU = 'Setup Charges',
        //                          FRA = 'Paramétrer frais annexes';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;

        //             trigger OnAction();
        //             begin
        //                 ShowSalesItemChargeForm();
        //             end;
        //         }
        //     }
        //     group("&Purchases")
        //     {
        //         CaptionML = ENU = '&Purchases',
        //                      FRA = 'Ac&hats';
        //         action(Action1100083006)
        //         {
        //             CaptionML = ENU = 'Setup Charges',
        //                          FRA = 'Paramétrer frais annexes';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;

        //             trigger OnAction();
        //             begin
        //                 ShowPurchItemChargeForm();
        //             end;
        //         }
        //     }  //<<BC Upgrade Priya
        // }
    }

    var
        GenProdPostGrMandatory: Boolean;
        VatProdPostGrMandatory: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
    ActivateFields;
    // >>DITW18.00.07 DDR DIT-770 #1836
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    // <<DITW15.00.00.01 DDR 19/08/2008
    if not EVALUATE("Item Charge Type",GETFILTER("Item Charge Type")) then
      "Item Charge Type" := xRec."Item Charge Type";
    // >>DITW15.00.00.01 DDR
    // << DITW19.00.08 SFI 18/08/2016 BL#10868
    SetupNewRec();
    // >> DITW19.00.08 SFI 18/08/2016
    */
    //end;

    local procedure ActivateFields();
    begin
        // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
        // GenProdPostGrMandatory := ("Item Charge Type" = "Item Charge Type"::" "); //<<BC Upgrade Priya
        VatProdPostGrMandatory := GenProdPostGrMandatory;
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

