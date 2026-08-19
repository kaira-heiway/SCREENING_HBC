pageextension 51115 VATStatementPreviewLineExtCBN extends "VAT Statement Preview Line"
{
    // version NAVW110.0,DITW110.00.08
    //     DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 10/01/2008 Added DrillDown Amount Column
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.24 DDR 24/09/2008 Drink-It Tax Specification/Tariff functionnalities
    //                                Added columns "Tax Specification Code"
    //                                Updated drill-down when "Tax specification" exists

    //                                Remove all specific global variables
    //                                Added new columns
    //                                Modify column "Amount" trigger DrillDown
    // DITW15.00.00.31 DDR 18/02/2009 Added columns "Return Reason Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in ColumnValue - OnDrillDown()
    //*****************************************************************************
    //BC UPGRADE PATHAA02 04.11.25 
    //1.DIT Fields, variable with Page-2013688("TAX Statement Preview Line")-commented
    //2. HEI.01 will not be in scope due to French Localisation(Custom code on "column value"- Omdrilldown trigger), we can drop this Page Extension

    layout
    {
        modify("Row No.")
        {
            ToolTipML = ENU = 'Specifies a number that identifies this row.', FRA = 'Spécifie un numéro qui identifie cette ligne.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the VAT statement line.', FRA = 'Spécifie une description de la ligne de déclaration de TVA.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies what the VAT statement line will include.', FRA = 'Spécifie ce qui est inclus dans la ligne déclaration de TVA.';
        }
        modify("Amount Type")
        {
            ToolTipML = ENU = 'Specifies if the VAT statement line shows the VAT amounts, or the base amounts on which the VAT is calculated.', FRA = 'Spécifie si la ligne déclaration de TVA affiche les montants de TVA ou les montants de base pour le calcul de la TVA.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a VAT business posting group code for the VAT statement.', FRA = 'Spécifie un code groupe comptabilisation marché TVA pour la déclaration de TVA.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a VAT product posting group code for the VAT Statement.', FRA = 'Spécifie un code groupe comptabilisation produit TVA pour la déclaration de TVA.';
        }
        modify("Tax Jurisdiction Code")
        {
            ToolTipML = ENU = 'Specifies a tax jurisdiction code for the statement.', FRA = 'Spécifie un code autorités de recouvrement pour la déclaration.';
        }
        modify("Use Tax")
        {
            ToolTipML = ENU = 'Specifies whether to use only entries from the VAT Entry table that are marked as Use Tax to be totaled on this line.', FRA = 'Spécifie s''il convient d''utiliser uniquement des écritures de la table Écriture TVA qui sont marquées comme Use Tax à totaliser sur cette ligne.';
        }
        modify(ColumnValue)
        {
            CaptionML = ENU = 'Column Amount', FRA = 'Montant colonne';
            ToolTipML = ENU = 'Specifies the type of entries that will be included in the amounts in columns.', FRA = 'Spécifie le type des écritures à inclure dans les montants des colonnes.';


        }

        //Unsupported feature: CodeInsertion on "ColumnValue(Control 17).OnDrillDown". Please convert manually.

        //trigger (Variable: VATStmtName)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on "ColumnValue(Control 17).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        case Type of
          Type::"Account Totaling":
            begin
              GLEntry.SETFILTER("G/L Account No.","Account Totaling");
              COPYFILTER("Date Filter",GLEntry."Posting Date");
              PAGE.RUN(PAGE::"General Ledger Entries",GLEntry);
            end;
        #8..36
          Type::"Row Totaling",
          Type::Description:
            ERROR(Text000,FIELDCAPTION(Type),Type);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
              //HEI.01>>
              CompanyInfo.GET;
              if CompanyInfo."Enable French Localization" then
                GLEntry.SETRANGE("Entry Type",GLEntry."Entry Type"::Definitive);
              //HEI.01<<
        #5..39

          Type::"Tax Value Entry Totaling":
            begin
              CLEAR(lFrmTaxStatmtPrevLine);
              lFrmTaxStatmtPrevLine.InitForm(VATStmtName,Selection,PeriodSelection,UseAmtsInAddCurr);
              lFrmTaxStatmtPrevLine.SETRECORD(Rec);
              lFrmTaxStatmtPrevLine.SETTABLEVIEW(Rec);
              lFrmTaxStatmtPrevLine.DrillDownAmount(true);
            end;
        end;
        */
        //end;
        addafter("Amount Type")
        {
            //BC UPGRADE PATHAA02-DIT>>
            //     field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            //     {
            //         Visible = false;
            //     }
            //     field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            //     {
            //         Visible = false;
            //     }
            // }
            // addafter("Use Tax")
            // {
            //     field("Src. DTax Group Code"; Rec."Src. DTax Group Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Item DTax Group Code"; Rec."Item DTax Group Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Value Entry Type Filter"; Rec."Value Entry Type Filter")
            //     {
            //         Visible = false;
            //     }
            //     field("Item Ledger Entry Type Filter"; Rec."Item Ledger Entry Type Filter")
            //     {
            //         Visible = false;
            //     }
            //     field("Return Reason Code"; Rec."Return Reason Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Location Group Type"; Rec."Location Group Type")
            //     {
            //         Visible = false;
            //     }
            //     field("Location Code"; Rec."Location Code")
            //     {
            //         Visible = false;
            //     }
            //     field("Item Charge No. Filter"; Rec."Item Charge No. Filter")
            //     {
            //         Visible = false;
            //     }
            //     field("Tax Specification Code"; Rec."Tax Specification Code")
            //     {
            //         Visible = false;
            //     }
            //BC UPGRADE PATHAA02-DIT<<

            field("Row Totaling"; Rec."Row Totaling")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies a row-number interval or a series of row numbers.';
            }
        }
    }

    var
        VATStmtName: Record "VAT Statement Name";
    //lFrmTaxStatmtPrevLine: Page "TAX Statement Preview Line"; //BC UPGRADE PATHAA02-DIT


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Drilldown is not possible when %1 is %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Drilldown is not possible when %1 is %2.;FRA=Vue détaillée impossible quand %1 est %2.;
    //Variable type has not been exported.

    var
        CompanyInfo: Record "Company Information";

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

