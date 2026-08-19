pageextension 51122 PurchaseQuoteArchSubformExt extends "Purchase Quote Archive Subform"
{
    // version NAVW110.0,HEI.02
    //Source Table-Purchase Line Archive
    //     HEI.01 CHG2024349 IBM.GUNERE01 14.08.2020 # "Machine Reference Number" field added
    // HEI.02 CHG2162715 HB3020 NORRIQ KOROLA04 14.11.2022
    //   # SPL Code, SPL Name - fields added
    //**********************************************************************
    //BC UPGRADE 05.11.25-Done (dependency on T5110-Priyanka for compilation)


    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Machine Reference Number"; Rec."Machine Reference Number FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Machine Reference Number field.';
            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Code field.';
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Name field.';
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

