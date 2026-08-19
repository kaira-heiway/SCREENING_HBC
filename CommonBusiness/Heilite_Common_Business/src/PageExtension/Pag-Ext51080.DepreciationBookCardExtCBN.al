pageextension 51080 DepreciationBookCardExtCBN extends "Depreciation Book Card"
{
    //     #HEI.01 FDD RTRGAP057 IBM HORTOC01 29.07.2017
    //   # Add new field "Default Depr. Book"
    // HEI.02 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # New Fields added: "Derogatory Calculation", "Used with Derogatory Book" and "G/L Integration - Derogatory"
    // HEI.03 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in OnOpenPage()
    //   # Changed "Derogatory Calculation", "Used with Derogatory Book" and "G/L Integration - Derogatory" properties: Visible and Enabled
    // version NAVW110.0,HEI.01

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code that identifies the depreciation book.', FRA = 'Indique un code qui identifie la loi d''amortissement.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the purpose of the depreciation book.', FRA = 'Indique l''objet de la loi d''amortissement.';
        }
        modify("Default Final Rounding Amount")
        {
            ToolTipML = ENU = 'Specifies the final rounding amount to use if the Final Rounding Amount field is zero.', FRA = 'Spécifie le montant final arrondi à utiliser si le champ Montant arrondi final est 0.';
        }
        modify("Default Ending Book Value")
        {
            ToolTipML = ENU = 'Specifies the ending book value to use if the Ending Book Value field is zero.', FRA = 'Indique la valeur comptable finale à utiliser si le champ Valeur comptable finale est 0.';
        }
        modify("Disposal Calculation Method")
        {
            ToolTipML = ENU = 'Specifies the disposal method for the current depreciation book.', FRA = 'Indique la méthode de cession pour la loi d''amortissement actuelle.';
        }
        modify("Subtract Disc. in Purch. Inv.")
        {
            ToolTipML = ENU = 'Specifies that the line and invoice discount are subtracted from the acquisition cost posted for the fixed asset.', FRA = 'Indique que la remise ligne et la remise facture sont soustraites du coût d''acquisition validé pour l''immobilisation.';
        }
        modify("Allow Correction of Disposal")
        {
            ToolTipML = ENU = 'Specifies whether to correct fixed ledger entries of the Disposal type.', FRA = 'Spécifie s''il faut ou non corriger les écritures comptables du type Cession.';
        }
        modify("Allow Changes in Depr. Fields")
        {
            ToolTipML = ENU = 'Specifies whether to allow the depreciation fields to be modified.', FRA = 'Spécifie s''il faut autoriser ou non que les champs amortissement soient modifiables.';
        }
        modify("VAT on Net Disposal Entries")
        {
            ToolTipML = ENU = 'Specifies whether you sell a fixed asset with the net disposal method.', FRA = 'Spécifie si vous vendez une immobilisation avec la méthode de cession nette.';
        }
        modify("Allow Identical Document No.")
        {
            ToolTipML = ENU = 'Specifies the check box for this field to allow identical document numbers in the depreciation book.', FRA = 'Activez ce champ pour autoriser les numéros de document identiques dans les lois d''amortissement.';
        }
        modify("Allow Indexation")
        {
            ToolTipML = ENU = 'Specifies whether to allow indexation of FA ledger entries and maintenance ledger entries posted to this book.', FRA = 'Indique s''il faut autoriser l''actualisation des écritures comptables immobilisation et des écritures comptables maintenance validées sur cette loi d''amortissement.';
        }
        modify("Allow more than 360/365 Days")
        {
            ToolTipML = ENU = 'Specifies if the fiscal year has more than 360 depreciation days.', FRA = 'Indique si l''exercice comptable compte plus de 360 jours d''amortissement.';
        }
        modify("Use FA Ledger Check")
        {
            ToolTipML = ENU = 'Specifies which checks to perform before posting a journal line.', FRA = 'Spécifie quelles vérifications effectuer avant de valider une ligne feuille.';
        }
        modify("Use Rounding in Periodic Depr.")
        {
            ToolTipML = ENU = 'Specifies whether the calculated periodic depreciation amounts should be rounded to whole numbers.', FRA = 'Spécifie si les montants amortissement calculés doivent être arrondis à l''entier.';
        }
        modify("Use Same FA+G/L Posting Dates")
        {
            ToolTipML = ENU = 'Specifies whether to indicate that the Posting Date and the FA Posting Date must be the same on a journal line before posting.', FRA = 'Spécifie s''il faut indiquer que la date comptabilisation et la date comptabilisation immobilisation doivent être identiques sur une ligne feuille avant validation.';
        }
        modify("Fiscal Year 365 Days")
        {
            ToolTipML = ENU = 'Specifies that when the Calculate Depreciation batch job calculates depreciations, a standardized year of 360 days, where each month has 30 days, is used.', FRA = 'Spécifie que lorsque le traitement par lots Calculer amortissement calcule les amortissements, il utilise normalement une année de 360 jours, dans laquelle chaque mois comptabilise 30 jours.';
        }
        modify(Integration)
        {
            CaptionML = ENU = 'Integration', FRA = 'Intégration';
        }
        modify("G/L Integration")
        {
            CaptionML = ENU = 'G/L Integration', FRA = 'Intégration compta.';
        }
        modify("G/L Integration - Acq. Cost")
        {
            CaptionML = ENU = 'Acquisition Cost', FRA = 'Coût acquisition';
            ToolTipML = ENU = 'Specifies whether acquisition cost entries posted to this depreciation book are posted both to the general ledger and the FA ledger.', FRA = 'Indique si les écritures coût d''acquisition validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify("G/L Integration - Depreciation")
        {
            CaptionML = ENU = 'Depreciation', FRA = 'Amortissement';
            ToolTipML = ENU = 'Specifies whether depreciation entries posted to this depreciation book are posted both to the general ledger and the FA ledger.', FRA = 'Indique si les écritures d''amortissement validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify("G/L Integration - Write-Down")
        {
            CaptionML = ENU = 'Write-Down', FRA = 'Dépréciation';
            ToolTipML = ENU = 'Specifies whether write-down entries posted to this depreciation book should be posted to the general ledger and the FA ledger.', FRA = 'Indique si les écritures dépréciation validées sur cette loi d''amortissement doivent être validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify("G/L Integration - Appreciation")
        {
            CaptionML = ENU = 'Appreciation', FRA = 'Réévaluation';
            ToolTipML = ENU = 'Specifies whether appreciation entries posted to this depreciation book are posted to the general ledger and the FA ledger.', FRA = 'Indique si les écritures réévaluation validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify("G/L Integration - Custom 1")
        {
            CaptionML = ENU = 'Custom 1', FRA = 'Param. 1';
            ToolTipML = ENU = 'Specifies whether custom 1 entries posted to this depreciation book are posted to the general ledger and the FA ledger.', FRA = 'Indique si les écritures Param. 1 validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify("G/L Integration - Custom 2")
        {
            CaptionML = ENU = 'Custom 2', FRA = 'Param. 2';
            ToolTipML = ENU = 'Specifies whether custom 2 entries posted to this depreciation book are posted to the general ledger and the FA ledger.', FRA = 'Indique si les écritures Param. 2 validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify("G/L Integration - Disposal")
        {
            CaptionML = ENU = 'Disposal', FRA = 'Cession';
            ToolTipML = ENU = 'Specifies whether disposal entries posted to this depreciation book are posted to the general ledger and the FA ledger.', FRA = 'Indique si les écritures de cession nette validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify("G/L Integration - Maintenance")
        {
            CaptionML = ENU = 'Maintenance', FRA = 'Maintenance';
            ToolTipML = ENU = 'Specifies whether maintenance entries that are posted to this depreciation book are posted both to the general ledger and the FA ledger.', FRA = 'Indique si les écritures de maintenance validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify(Duplication)
        {
            CaptionML = ENU = 'Duplication', FRA = 'Duplication';
        }
        modify("Part of Duplication List")
        {
            ToolTipML = ENU = 'Specifies whether to indicate that entries made in another depreciation book should be duplicated to this depreciation book.', FRA = 'Spécifie s''il faut indiquer que les écritures faites dans une autre loi d''amortissement doivent être copiées dans cette loi d''amortissement.';
        }
        modify("Use FA Exch. Rate in Duplic.")
        {
            ToolTipML = ENU = 'Specifies whether to use the FA Exchange Rate field when you duplicate entries from one depreciation book to another.', FRA = 'Indique s''il faut utiliser le champ Taux actualisation immo. lorsque vous copiez les écritures d''une loi d''amortissement à une autre.';
        }
        modify("Default Exchange Rate")
        {
            ToolTipML = ENU = 'Specifies the exchange rate to use if the rate in the FA Exchange Rate field is zero.', FRA = 'Spécifie le taux de change à utiliser si le taux du champ Taux actualisation immo. est 0.';
        }
        modify(Reporting)
        {
            CaptionML = ENU = 'Reporting', FRA = 'Génération d''états';
        }
        modify("Use Add.-Curr Exch. Rate")
        {
            CaptionML = ENU = 'Use Add.-Curr Exch. Rate', FRA = 'Utiliser taux change DR';
        }
        modify("Add-Curr Exch Rate - Acq. Cost")
        {
            CaptionML = ENU = 'Acquisition Cost', FRA = 'Coût acquisition';
            ToolTipML = ENU = 'Specifies whether acquisition cost entries posted to this depreciation book are posted both to the general ledger and the FA ledger.', FRA = 'Indique si les écritures coût d''acquisition validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify("Add.-Curr. Exch. Rate - Depr.")
        {
            CaptionML = ENU = 'Depreciation', FRA = 'Amortissement';
            ToolTipML = ENU = 'Records depreciation transactions in the general ledger in both LCY and any additional reporting currency.', FRA = 'Enregistre les transactions d''amortissement dans le grand livre dans la devise locale ou une autre devise report.';
        }
        modify("Add-Curr Exch Rate -Write-Down")
        {
            CaptionML = ENU = 'Write-Down', FRA = 'Dépréciation';
            ToolTipML = ENU = 'Records write-down transactions in the general ledger in both LCY and any additional reporting currency.', FRA = 'Enregistre les transactions de dépréciation dans le grand livre dans la devise locale ou une autre devise report.';
        }
        modify("Add-Curr. Exch. Rate - Apprec.")
        {
            CaptionML = ENU = 'Appreciation', FRA = 'Réévaluation';
            ToolTipML = ENU = 'Records appreciation transactions in the general ledger in both LCY and any additional reporting currency.', FRA = 'Enregistre les transactions de réévaluation dans le grand livre dans la devise locale ou une autre devise report.';
        }
        modify("Add-Curr. Exch Rate - Custom 1")
        {
            CaptionML = ENU = 'Custom 1', FRA = 'Param. 1';
            ToolTipML = ENU = 'Specifies whether custom 1 entries posted to this depreciation book are posted to the general ledger and the FA ledger.', FRA = 'Indique si les écritures Param. 1 validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';
        }
        modify("Add-Curr. Exch Rate - Custom 2")
        {
            CaptionML = ENU = 'Custom 2', FRA = 'Param. 2';
            ToolTipML = ENU = 'Records custom 2 transactions in the general ledger in both LCY and any additional reporting currency.', FRA = 'Enregistre les transactions Param. 2 dans le grand livre dans la devise locale ou une autre devise report.';
        }
        modify("Add.-Curr. Exch. Rate - Disp.")
        {
            CaptionML = ENU = 'Disposal', FRA = 'Cession';
            ToolTipML = ENU = 'Records disposal transactions in the general ledger in both LCY and any additional reporting currency.', FRA = 'Enregistre les transactions de cession dans le grand livre dans la devise locale ou une autre devise report.';
        }
        modify("Add.-Curr. Exch. Rate - Maint.")
        {
            CaptionML = ENU = 'Maintenance', FRA = 'Maintenance';
            ToolTipML = ENU = 'Records maintenance transactions in the general ledger in both LCY and any additional reporting currency.', FRA = 'Enregistre les transactions de maintenance dans le grand livre dans la devise locale ou une autre devise report.';
        }
        modify("Allow Depr. below Zero")
        {
            Visible = false;
        }
        //BC Upgrade KAPOOV01 French Localization>>
        // addafter("VAT on Net Disposal Entries")
        // {
        //     field("Derogatory Calculation"; Rec."Derogatory Calculation")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        //     field("Used with Derogatory Book"; Rec."Used with Derogatory Book")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        // }
        //BC Upgrade KAPOOV01 French Localization<<
        addafter("Use Rounding in Periodic Depr.")
        {
            field("Allow Acq. Cost below Zero"; Rec."Allow Acq. Cost below Zero")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Acq. Cost below Zero field.';
            }
        }
        addafter("Fiscal Year 365 Days")
        {
            field("Default Depr. Book"; Rec."Default Depr. Book FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Depr. Book field.';
            }
        }
        //BC Upgrade KAPOOV01 French Localization>>
        // addafter("G/L Integration - Maintenance")
        // {
        //     field("G/L Integration - Derogatory"; Rec."G/L Integration - Derogatory")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        // }
        //BC Upgrade KAPOOV01 French Localization<<
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
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Create FA Depreciation Books")
        {
            CaptionML = ENU = 'Create FA Depreciation Books', FRA = 'Créer plan amortissement';
            ToolTipML = ENU = 'Create depreciation books for the fixed asset. You can create empty fixed asset depreciation books, for example for all fixed assets, when you have set up a new depreciation book. You can also use an existing fixed asset depreciation book as the basis for new book.', FRA = 'Créez des lois d''amortissement pour l''immobilisation. Vous pouvez créer des lois d''amortissement vides, par exemple pour toutes les immobilisations, lorsque vous avez défini une nouvelle loi d''amortissement. Vous pouvez aussi utiliser une loi d''amortissement existante pour créer une loi.';
        }
        modify("C&opy Depreciation Book")
        {
            CaptionML = ENU = 'C&opy Depreciation Book', FRA = 'C&opier lois d''amortissement';
            ToolTipML = ENU = 'Copy specified entries from one depreciation book to another. The entries are not posted to the new depreciation book - they are either inserted as lines in a general ledger fixed asset journal or in a fixed asset journal, depending on whether the new depreciation book has activated general ledger integration.', FRA = 'Copiez les écritures spécifiées d''une loi d''amortissement à une autre. Les écritures ne sont pas validées sur cette nouvelle loi d''amortissement ; elles sont insérées sous forme de lignes dans une feuille comptabilisation immobilisation ou dans une feuille immobilisation, en fonction de l''intégration de la nouvelle loi d''amortissement en comptabilité.';
        }
        modify("C&ancel FA Ledger Entries")
        {
            CaptionML = ENU = 'C&ancel FA Ledger Entries', FRA = '&Annuler écritures compta. immo.';
            ToolTipML = ENU = 'Remove one or more fixed asset ledger entries from the FA Ledger Entries window. If you posted erroneous transactions to one or more fixed assets, you can use this function to cancel the fixed asset ledger entries. In the FA Ledger Entries window, select the entry or entries that you want to cancel.', FRA = 'Supprimez une ou plusieurs écritures comptables immobilisation de la fenêtre Écritures comptables immobilisation. Si vous avez validé des transactions erronées sur une ou plusieurs immobilisations, vous pouvez utiliser cette fonction pour annuler les écritures comptables immobilisation. Dans la fenêtre Écritures comptables immobilisation, sélectionnez la ou les écritures à annuler.';
        }
        modify("Co&py FA Entries to G/L Budget")
        {
            CaptionML = ENU = 'Co&py FA Entries to G/L Budget', FRA = 'Co&pier écr. immo. vers budget';
        }
    }

    var
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //HEI.03>>
    CompanyInfo.GET;
    FRLocAction := false;
    if CompanyInfo."Enable French Localization" then
      FRLocAction := true;
    //HEI.03<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

