pageextension 51081 DepreciationBookListExtCBN extends "Depreciation Book List"
{
    //   #HEI.01 FDD RTRGAP057 IBM HORTOC01 29.07.2017
    //   # Add new field "Default Depr. Book"
    // version NAVW110.0,HEI.01

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code that identifies the depreciation book.', FRA = 'Indique un code qui identifie la loi d''amortissement.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the purpose of the depreciation book.', FRA = 'Indique l''objet de la loi d''amortissement.';
        }
        addafter(Description)
        {
            field("Default Depr. Book"; Rec."Default Depr. Book FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Depr. Book field.';
            }
        }
    }
    actions
    {
        modify("&Depr. Book")
        {
            CaptionML = ENU = '&Depr. Book', FRA = '&Lois amort.';
        }
        modify("FA Posting Type Setup")
        {
            CaptionML = ENU = 'FA Posting Type Setup', FRA = 'Type paramètre compta. immo.';
            ToolTipML = ENU = 'Set up how to handle the write-down, appreciation, custom 1, and custom 2 posting types that you use when posting to fixed assets.', FRA = 'Définissez comment gérer les types validation Dépréciation, Réévaluation, Param. 1 et Param. 2 que vous utilisez lors de la validation sur des immobilisations.';
        }
        modify("FA &Journal Setup")
        {
            CaptionML = ENU = 'FA &Journal Setup', FRA = 'Param. feuille i&mmo.';
            ToolTipML = ENU = 'Set up the FA general ledger journal, the FA journal, and the insurance journal templates and batches to use when duplicating depreciation entries and acquisition-cost entries and when calculating depreciation or indexing fixed assets.', FRA = 'Paramétrez les modèles et les noms feuille comptabilité immobilisation, feuille immobilisation et feuille assurance à utiliser lors de la duplication des écritures d''amortissement et des écritures de coût d''acquisition et lors du calcul de l''amortissement ou de la réévaluation des immobilisations.';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

