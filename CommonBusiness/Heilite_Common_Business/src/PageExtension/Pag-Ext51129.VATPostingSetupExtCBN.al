pageextension 51129 VATPostingSetupExtCBN extends "VAT Posting Setup"
{
    // FINXL7.00.001 RBE 20/03/2013 : Intrastat on G/L Accounts
    //                                Added fields  "Standard Text (Invoice)" and "Standard Text (Cr.Memo)"

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HB1609 CHG2074002 IBM BULIMC01 26.08.2020 #new field added:"Free Goods VAT"
    // HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Fields added: "CAD %", "Sales CAD Account"

    layout
    {
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a VAT business posting group code.', FRA = 'Spécifie un code groupe comptabilisation marché TVA.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a VAT product posting group code.', FRA = 'Spécifie un code groupe comptabilisation produit TVA.';
        }
        modify("VAT Identifier")
        {
            ToolTipML = ENU = 'Specifies a code to group various VAT posting setups with similar attributes, for example VAT percentage.', FRA = 'Spécifie un code pour regrouper divers paramètres validation TVA dotés d''attributs similaires, par exemple le pourcentage TVA.';
        }
        modify("VAT %")
        {
            ToolTipML = ENU = 'Specifies the relevant VAT rate for the particular combination of VAT business posting group and VAT product posting group. Do not enter the percent sign, only the number. For example, if the VAT rate is 25 %, enter 25 in this field.', FRA = 'Spécifie le taux de TVA correspondant à cette combinaison spécifique de groupe comptabilisation marché TVA et de groupe comptabilisation produit TVA. Ne saisissez pas le signe pourcentage mais uniquement le nombre. Par exemple, si la TVA est de 25 %, saisissez 25 dans ce champ.';
        }
        modify("VAT Calculation Type")
        {
            ToolTipML = ENU = 'Specifies how VAT will be calculated for purchases or sales of items with this particular combination of VAT business posting group and VAT product posting group.', FRA = 'Spécifie la manière dont la TVA est calculée pour l''achat ou la vente d''articles présentant cette combinaison particulière de code groupe comptabilisation marché TVA et de code groupe comptabilisation produit TVA.';
        }
        modify("Unrealized VAT Type")
        {
            ToolTipML = ENU = 'Specifies how to handle unrealized VAT, which is VAT that is calculated but not due until the invoice is paid.', FRA = 'Spécifie comment gérer une TVA prévue, qui est une TVA qui est calculée mais pas due tant que la facture n''est pas réglée.';
        }
        modify("Adjust for Payment Discount")
        {
            ToolTipML = ENU = 'Specifies whether to recalculate VAT amounts when you post payments that trigger payment discounts.', FRA = 'Spécifie si vous souhaitez recalculer les montants de TVA lorsque vous validez des paiements qui entraînent des escomptes.';
        }
        modify("Sales VAT Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post sales VAT for the particular combination of VAT business posting group and VAT product posting group.', FRA = 'Spécifie le numéro du compte général sur lequel valider la TVA ventes pour cette combinaison particulière de groupe comptabilisation marché TVA et de groupe comptabilisation produit TVA.';
        }
        modify("Sales VAT Unreal. Account")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger account to post unrealized sales VAT to.', FRA = 'Spécifie le numéro du compte général sur lequel valider la TVA ventes prévue.';
        }
        modify("Purchase VAT Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which to post purchase VAT for the particular combination of business group and product group.', FRA = 'Spécifie le numéro du compte général sur lequel valider la TVA achats présentant cette combinaison particulière de groupe comptabilisation marché et de groupe comptabilisation produit.';
        }
        modify("Purch. VAT Unreal. Account")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger account to post unrealized purchase VAT to.', FRA = 'Spécifie le numéro du compte général sur lequel valider la TVA achats prévue.';
        }
        modify("Reverse Chrg. VAT Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to which you want to post reverse charge VAT (purchase VAT) for this combination of VAT business posting group and VAT product posting group, if you have selected the Reverse Charge VAT option in the VAT Calculation Type field.', FRA = 'Si vous avez sélectionné l''option Déductible dans le champ Mode calcul TVA, spécifiez le numéro du compte général sur lequel vous souhaitez valider la TVA déductible (TVA achats) pour cette combinaison de groupe comptabilisation marché TVA et de groupe comptabilisation produit TVA.';
        }
        modify("Reverse Chrg. VAT Unreal. Acc.")
        {
            ToolTipML = ENU = 'Specifies the number of the general ledger account to post amounts for unrealized reverse charge VAT to.', FRA = 'Spécifie le numéro du compte général sur lequel valider des montants pour la TVA déductible prévue.';
        }
        modify("VAT Clause Code")
        {
            ToolTipML = ENU = 'Specifies the VAT Clause Code that is associated with the VAT Posting Setup.', FRA = 'Spécifie le code clause TVA qui est associé aux paramètres compta. TVA.';
        }
        modify("EU Service")
        {
            ToolTipML = ENU = 'Specifies if this combination of VAT business posting group and VAT product posting group are to be reported as services in the periodic VAT reports.', FRA = 'Spécifie si cette combinaison de groupe comptabilisation marché TVA et de groupe comptabilisation produit TVA doit être rapportée en tant que services dans les déclarations de TVA périodiques.';
        }
        modify("Tax Category")
        {
            ToolTipML = ENU = 'Specifies the VAT category in connection with electronic document sending. For example, when you send sales documents through the PEPPOL service, the value in this field is used to populate the TaxApplied element in the Supplier group. The number is based on the UNCL5305 standard.', FRA = 'Spécifie la catégorie TVA en relation avec l''envoi de documents électroniques. Par exemple, lorsque vous envoyez des documents vente via le service PEPPOL, la valeur dans ce champ est utilisée pour renseigner l''élément TaxApplied dans le groupe Fournisseur. Le numéro est basé sur la norme UNCL5305.';
        }
        //BC Upgrade ADHIKG01>>
        // modify("VAT Bus. Posting Group2")
        // {
        //     ToolTipML = ENU='Specifies a VAT business posting group code.',FRA='Spécifie un code groupe comptabilisation marché TVA.';
        // }
        // modify("VAT Prod. Posting Group2")
        // {
        //     ToolTipML = ENU='Specifies a VAT product posting group code.',FRA='Spécifie un code groupe comptabilisation produit TVA.';
        // }
        //BC Upgrade ADHIKG01<<
        addafter("VAT %")
        {
            field("Reverse Charge VAT %"; Rec."Reverse Charge VAT % FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reverse Charge VAT % field.';
            }
            field("Top Gross WHT Deductible"; Rec."Top Gross WHT Deductible FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Top Gross WHT Deductible field.';
            }
        }
        //BC Upgrade Kamnay01>> DITW Fields 
        // addafter("Certificate of Supply Required")
        // {
        //     field("Create Intrastat Ledg. Entries";Rec."Create Intrastat Ledg. Entries")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Standard Text (Invoice)";Rec."Standard Text (Invoice)")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Standard Text (Cr.Memo)";Rec."Standard Text (Cr.Memo)")
        //     {
        //         Description = 'FINXL7.00.001';
        //     }
        // }
        //BC Upgrade Kamnay01<< DITW Fields
        addafter("Tax Category")
        {
            field("Fiscal Printer Tax Identifier"; Rec."Fiscal PrintTax Identifier FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fiscal Printer Tax Identifier field.';
            }
            field("Free Goods VAT (HNK)"; Rec."Free Goods VAT (HNK) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Free Goods VAT (HNK) field.';
            }
            field("CAD %"; Rec."CAD % FND")
            {
                Visible = EnableCAD;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CAD % field.';
            }
            field("Sales CAD Account"; Rec."Sales CAD Account FND")
            {
                Visible = EnableCAD;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales CAD Account field.';
            }
        }
    }
    actions
    {
        modify(Copy)
        {
            CaptionML = ENU = '&Copy', FRA = '&Copier';
            ToolTipML = ENU = 'Copy a record with selected fields or all fields from the Tax posting setup to a new record. Before you start to copy you have to create the new record.', FRA = 'Copiez un enregistrement qui comporte des champs sélectionnés ou tous les champs des Paramètres compta. TVA vers un nouvel enregistrement. Avant de commencer à copier, vous devez créer un enregistrement.';
        }
    }

    var
        EnableCAD: Boolean;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //var

    //BC Upgrade kamnay01>> HEI.02 Onopen page code added
    trigger OnOpenPage()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.02>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.02<<
    end;
    //BC Upgrade kamnay01<< HEI.02 Onopen page code added
    //begin
    /*
    //HEI.02>>
    GeneralLedgerSetup.GET;
    EnableCAD := GeneralLedgerSetup."Enable CAD";
    //HEI.02<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

