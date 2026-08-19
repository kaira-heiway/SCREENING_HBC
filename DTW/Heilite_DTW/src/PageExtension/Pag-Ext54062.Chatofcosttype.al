pageextension 54062 ChartofcosttypesExt extends "Chart of Cost Types"
{
    // version NAVW17.00

    //BC Upgrade GUNREM01 Old ID-50046 
    //BC Upgrade GUNREM01 -FDD-BPMGAP BRD HB398 
    layout
    {

        //Unsupported feature: Change ImplicitType on ""G/L Account Range"(Control 30)". Please convert manually.

        addafter("G/L Account Range")
        {
            field("Dimension Filter 1 Code"; Rec."Dimension Filter 1 Code FND")
            {
                ApplicationArea = all;
            }
            field("Dimension Filter 1 Value Code"; rec."Dim Filter 1 Value Code FND")
            {
                ApplicationArea = all;
            }
            field("Dimension Filter 2 Code"; Rec."Dimension Filter 2 Code FND")
            {
                ApplicationArea = all;
            }
            field("Dimension Filter 2 Value Code"; Rec."Dim Filter 2 Value Code FND")
            {
                ApplicationArea = all;
            }
        }
        addafter("Balance at Date")
        {
            field("Cost Allocation Key"; Rec."Cost Allocation Key FND")
            {
                ApplicationArea = all;
            }
            field("Source Shipping Cost"; Rec."Source Shipping Cost FND")
            {
                Editable = SourceShippingEditable;
                Enabled = SourceShippingEditable;
                ApplicationArea = all;
            }
            field("COGS Variable Item Cat Code"; Rec."COGS Var Item Cat Code FND")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify("&Cost Type")
        {
            CaptionML = ENU = '&Cost Type', FRA = 'Type &coût';
        }
        modify("Cost E&ntries")
        {
            CaptionML = ENU = 'Cost E&ntries', FRA = 'É&critures coûts';
        }
        modify(CorrespondingGLAccounts)
        {
            CaptionML = ENU = 'Corresponding &G/L Accounts', FRA = '&Comptes généraux correspondants';
        }
        modify("&Balance")
        {
            CaptionML = ENU = '&Balance', FRA = 'Sol&de';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(IndentCostType)
        {
            CaptionML = ENU = 'I&ndent Cost Types', FRA = 'I&ndenter les types de coûts';
        }
        modify(GetCostTypesFromChartOfAccounts)
        {
            CaptionML = ENU = 'Get Cost Types from &Chart of Accounts', FRA = 'Obtenir les types de coûts à partir du &plan comptable';
        }
        modify(RegCostTypeInChartOfCostType)
        {
            CaptionML = ENU = '&Register Cost Types in Chart of Accounts', FRA = '&Enregistrer les types de coûts dans le plan comptable';
        }
        modify("Cost Registers")
        {
            CaptionML = ENU = 'Cost Registers', FRA = 'Registres des coûts';
        }
        modify("G/L Account")
        {
            CaptionML = ENU = 'G/L Account', FRA = 'Compte général';
        }
        modify("Cost Acctg. P/L Statement")
        {
            CaptionML = ENU = 'Cost Acctg. P/L Statement', FRA = 'Rapport pertes/profits de comptabilité analytique';
        }
        modify("Cost Acctg. P/L Statement per Period")
        {
            CaptionML = ENU = 'Cost Acctg. P/L Statement per Period', FRA = 'Rapport pertes/profits de comptabilité analytique par période';
        }
        modify("Cost Acctg. P/L Statement with Budget")
        {
            CaptionML = ENU = 'Cost Acctg. P/L Statement with Budget', FRA = 'Rapport pertes/profits de comptabilité analytique avec budget';
        }
        modify("Cost Acctg. Analysis")
        {
            CaptionML = ENU = 'Cost Acctg. Analysis', FRA = 'Analyse comptabilité analytique';
        }
        modify("Account Details")
        {
            CaptionML = ENU = 'Account Details', FRA = 'Détails du compte';
        }
    }

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        //  [InDataSet]
        SourceShippingEditable: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    trigger OnAfterGetCurrRecord();
    begin

        SetSourceShippingEditable; //HEI.02 /BC upgrade GUNREM01 Uncommented 

    end;

    trigger OnAfterGetRecord();
    begin

        SetSourceShippingEditable; //HEI.02 //BC upgrade GUNREM01 Uncommented 

    end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetEmphasis;
    SetIndent;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetEmphasis;
    SetIndent;
    SetSourceShippingEditable; //HEI.02
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    trigger OnOpenPage();
    begin

        SetSourceShippingEditable; //HEI.02 /BC upgrade GUNREM01 Uncommented 

    end;

    local procedure SetSourceShippingEditable();
    begin
        //HEI.02<<
        GeneralLedgerSetup.GET;

        if (Rec.Type = Rec.Type::"Cost Type") and (rec."G/L Account Range" <> '') and
          (rec."Cost Allocation Key FND" = rec."Cost Allocation Key FND"::"Quantity(HL)") and
          (rec."Dimension Filter 1 Code FND" = GeneralLedgerSetup."Cost Center Dimension Code FND") and
          (rec."Dim Filter 1 Value Code FND" <> '') then
            SourceShippingEditable := true
        else
            SourceShippingEditable := false;
        //HEI.02>>
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

