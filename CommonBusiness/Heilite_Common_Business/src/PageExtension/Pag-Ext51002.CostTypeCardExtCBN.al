pageextension 51002 CostTypeCardExtCBN extends "Cost Type Card"
{
    // version NAVW17.00
    // HEI.01 CHG2068359 BULIMC01 IBM 07.10.2020 #new boolean field displayed in the General tab - "Source Shipping Cost"
    // HEI.02 CHG2117171 IBM.AK 08.07.21 # added field "COGS Variable Item Cat Code"
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }

        //Unsupported feature: Change ImplicitType on ""G/L Account Range"(Control 23)". Please convert manually.

        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        addafter(Type)
        {
            field("Cost Allocation Key"; Rec."Cost Allocation Key FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cost Allocation Key field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Cost Allocation Key field.';

            }
            field("Source Shipping Cost"; Rec."Source Shipping Cost FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Editable = SourceShippingEditable;
                Enabled = SourceShippingEditable;
                ToolTip = 'Specifies the value of the Source Shipping Cost from Value Entries field.';
            }
        }
        addafter(Blocked)
        {
            field("COGS Variable Item Cat Code"; Rec."COGS Var Item Cat Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the COGS Variable Item Category Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the COGS Variable Item Category Code field.';

            }
        }
    }
    actions
    {
        modify("&Cost Type")
        {
            CaptionML = ENU = '&Cost Type', FRA = 'Type &coût';
        }
        modify("E&ntries")
        {
            CaptionML = ENU = 'E&ntries', FRA = 'É&critures';

            //Unsupported feature: Change RunPageView on ""E&ntries"(Action 3)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""E&ntries"(Action 3)". Please convert manually.

        }
        modify("&Balance")
        {
            CaptionML = ENU = '&Balance', FRA = 'Sol&de';

            //Unsupported feature: Change RunPageLink on ""&Balance"(Action 5)". Please convert manually.

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
        SourceShippingEditable: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    SetSourceShippingEditable; //HEI.01
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SETRANGE("No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SETRANGE("No.");
    SetSourceShippingEditable; //HEI.01
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    SetSourceShippingEditable; //HEI.01
    */
    //end;

    local procedure SetSourceShippingEditable();
    begin
        //HEI.01<<
        GeneralLedgerSetup.GET();

        if (Rec.Type = Rec.Type::"Cost Type") and (Rec."G/L Account Range" <> '') and
              (Rec."Cost Allocation Key FND" = Rec."Cost Allocation Key FND"::"Quantity(HL)") and
                  (Rec."Dimension Filter 1 Code FND" = GeneralLedgerSetup."Cost Center Dimension Code FND") and
                      (Rec."Dim Filter 1 Value Code FND" <> '') then
            SourceShippingEditable := true
        else
            SourceShippingEditable := false;
        //HEI.01>>
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

