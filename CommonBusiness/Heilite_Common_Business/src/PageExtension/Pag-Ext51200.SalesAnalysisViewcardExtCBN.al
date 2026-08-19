pageextension 51200 "SalesAnalysisViewCardExtCBN" extends "Sales Analysis View Card"
{
    // version NAVW110.0,HEI.01
    //  HEI.01 Defect #1328 #1329 IBM NASTAA02 19.12.2017 # Missing fields in file creation
    //     # Added new group 'CIL' and fields
    //   HEI.02 FDD-HB1425 BULIMC01 IBM 03.06.2020 #new fields added to CIL tab: "Shortcut 1 Code", "Shortcut 2 Code"


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code for the analysis view.', FRA = 'Spécifie un code pour la vue d''analyse.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the analysis view.', FRA = 'Spécifie le nom de la vue d''analyse.';
        }
        modify("Item Filter")
        {
            ToolTipML = ENU = 'Specifies a filter to specify the items that will be included in an analysis view.', FRA = 'Spécifie un filtre permettant d''indiquer les articles qui seront inclus dans une vue d''analyse.';
        }
        modify("Location Filter")
        {
            ToolTipML = ENU = 'Specifies a location filter to specify that only entries posted to a particular location are to be included in an analysis view.', FRA = 'Spécifie un filtre magasin permettant d''indiquer que seules les écritures validées dans un magasin donné doivent être ajoutées à une vue d''analyse.';
        }
        modify("Date Compression")
        {
            ToolTipML = ENU = 'Specifies the period that the program will combine entries for, in order to create a single entry for that time period.', FRA = 'Spécifie la période pour laquelle l''application combine des écritures afin de créer une écriture unique.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the date from which item ledger entries will be included in an analysis view.', FRA = 'Spécifie la date à partir de laquelle les écritures comptables article sont ajoutées à une vue d''analyse.';
        }
        modify("Last Date Updated")
        {
            ToolTipML = ENU = 'Specifies the date on which the analysis view was last updated.', FRA = 'Spécifie la date de la dernière mise à jour de la vue d''analyse.';
        }
        modify("Last Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the last item ledger entry you posted, prior to updating the analysis view.', FRA = 'Spécifie le numéro de la dernière écriture comptable article que vous avez validée avant de mettre à jour la vue d''analyse.';
        }
        modify("Last Budget Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the last item budget entry you entered prior to updating the analysis view.', FRA = 'Spécifie le numéro de la dernière écriture budget article que vous avez saisie avant de mettre à jour la vue d''analyse.';
        }
        modify("Update on Posting")
        {
            ToolTipML = ENU = 'Specifies if the analysis view is updated every time that you post an item ledger entry, for example from a sales invoice.', FRA = 'Indique si la vue d''analyse est mise à jour à chaque fois que vous validez une écriture comptable article, par exemple à partir d''une facture vente.';
        }
        modify("Include Budgets")
        {
            ToolTipML = ENU = 'Specifies whether to include an update of analysis view budget entries, when updating an analysis view.', FRA = 'Indique s''il faut inclure une mise à jour des écritures budget vue d''analyse lors de la mise à jour d''une vue d''analyse.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies if the analysis view is blocked so that it cannot be updated.', FRA = 'Indique si la vue d''analyse est bloquée afin qu''elle ne puisse pas être mise à jour.';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        }
        modify("Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies one of the three dimensions that you can include in an analysis view.', FRA = 'Spécifie l''un des trois axes pouvant être inclus dans une vue d''analyse.';
        }
        modify("Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies one of the three dimensions that you can include in an analysis view.', FRA = 'Spécifie l''un des trois axes pouvant être inclus dans une vue d''analyse.';
        }
        modify("Dimension 3 Code")
        {
            ToolTipML = ENU = 'Specifies one of the three dimensions that you can include in an analysis view.', FRA = 'Spécifie l''un des trois axes pouvant être inclus dans une vue d''analyse.';
        }
        //BC Upgrade GUNREM01 >> Added fields
        addafter(Dimensions)
        {
            group(CIL)
            {
                Caption = 'CIL';
                field("Include Market Type"; Rec."Include Market Type FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Include Market Type field.';
                }
                field("Include Product Type"; Rec."Include Product Type FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Include Product Type field.';
                }
                field("Product Type Dimension Code"; Rec."Product Type Dimen. Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Type Dimension Code field.';
                }
                field("Include Addit. Cust. Dim.1"; Rec."Include Addit. Cust. Dim.1 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Include Addit. Cust. Dim.1 field.';
                }
                field("Include Addit. Cust. Dim.2"; Rec."Include Addit. Cust. Dim.2 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Include Addit. Cust. Dim.2 field.';
                }
                field("Add. Cust. Dim.1 Code"; Rec."Add. Cust. Dim.1 Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Add. Cust. Dim.1 Code field.';
                }
                field("Add. Cust. Dim.2 Code"; Rec."Add. Cust. Dim.2 Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Add. Cust. Dim.2 Code field.';
                }
                field("Use Alt. Country Customer"; Rec."Use Alt. Country Customer FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Use Alt. Country Customer field.';
                }
                field("Line Extension Dimension Code"; Rec."Line Ext. Dimension Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line Extension Dimension Code field.';
                }
                field("Include Product Type R1"; Rec."Include Product Type R1 FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Include Product Type R1 field.';
                }
                field("LineExt.Dim Code incl.in BRAND"; Rec."LineExt.DimCodIncl.inBRAND FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LineExt.Dim Code incl.in BRAND field.';
                }
                field("Shortcut 1 Code"; Rec."Shortcut 1 Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut 1 Code field.';
                }
                field("Shortcut 2 Code"; Rec."Shortcut 2 Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut 2 Code field.';
                }
            }
        }
        //BC Upgrade GUNREM01 << Added fields
    }
    actions
    {
        modify("&Analysis")
        {
            CaptionML = ENU = '&Analysis', FRA = '&Analyse';
        }
        modify("Filter")
        {
            CaptionML = ENU = 'Filter', FRA = 'Filtre';
        }
        modify("&Update")
        {
            CaptionML = ENU = '&Update', FRA = '&Mettre à jour';
        }
        modify("Enable Update on Posting")
        {
            CaptionML = ENU = 'Enable Update on Posting', FRA = 'Activer Mise à jour à la validation';
        }
        modify("Disable Update on Posting")
        {
            CaptionML = ENU = 'Disable Update on Posting', FRA = 'Désactiver Mise à jour à la validation';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

