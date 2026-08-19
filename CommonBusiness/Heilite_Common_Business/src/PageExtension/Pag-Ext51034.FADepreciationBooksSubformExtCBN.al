pageextension 51034 FADepBooksSubformExtCBN extends "FA Depreciation Books Subform"
{
    // HEI.01 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # New Field added: "Derogatory"
    // version NAVW110.0

    //Bc Upgrade YADAVM09 Drink it field blocked - Derogatory.

    layout
    {
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the depreciation book that is assigned to the fixed asset.', FRA = 'Spécifie la loi d''amortissement affectée à l''immobilisation.';
        }
        //BC Upgrade KAPOOV01>>
        //modify(GetAddCurrCode)
        modify(AddCurrCode)
        //BC Upgrade KAPOOV01 field name GetAddCurrCode changed to AddCurrCode.<<
        {
            CaptionML = ENU = 'FA Add.-Currency Code', FRA = 'Code DR immo.';
            ToolTipML = ENU = 'Specifies an additional currency to be used when posting.', FRA = 'Spécifie une devise supplémentaire à utiliser lors de la validation.';
        }
        modify("FA Posting Group")
        {
            ToolTipML = ENU = 'Specifies which posting group is used for the depreciation book when posting fixed asset transactions.', FRA = 'Spécifie le groupe comptabilisation utilisé pour la loi d''amortissement lors de la validation des transactions d''immobilisation.';
        }
        modify("Depreciation Method")
        {
            ToolTipML = ENU = 'Specifies how depreciation is calculated for the depreciation book.', FRA = 'Spécifie comment l''amortissement est calculé pour la loi d''amortissement.';
        }
        modify("Depreciation Starting Date")
        {
            ToolTipML = ENU = 'Specifies the date on which depreciation of the fixed asset starts.', FRA = 'Spécifie la date à laquelle l''amortissement de l''immobilisation commence.';
        }
        modify("No. of Depreciation Years")
        {
            ToolTipML = ENU = 'Specifies the length of the depreciation period, expressed in years.', FRA = 'Spécifie la durée de la période d''amortissement, exprimée en années.';
        }
        modify("Depreciation Ending Date")
        {
            ToolTipML = ENU = 'Specifies the date on which depreciation of the fixed asset ends.', FRA = 'Spécifie la date à laquelle l''amortissement de l''immobilisation finit.';
        }
        modify("No. of Depreciation Months")
        {
            ToolTipML = ENU = 'Specifies the length of the depreciation period, expressed in months.', FRA = 'Spécifie la durée de la période d''amortissement, exprimée en mois.';
        }
        modify("Straight-Line %")
        {
            ToolTipML = ENU = 'Specifies the percentage to depreciate the fixed asset by the straight-line principle, but with a fixed yearly percentage.', FRA = 'Spécifie le pourcentage pour amortir l''immobilisation selon la méthode linéaire mais en utilisant un pourcentage annuel fixe.';
        }
        modify("Fixed Depr. Amount")
        {
            ToolTipML = ENU = 'Specifies an amount to depreciate the fixed asset, by a fixed yearly amount.', FRA = 'Spécifie un montant pour amortir l''immobilisation selon un montant annuel fixe.';
        }
        modify("Declining-Balance %")
        {
            ToolTipML = ENU = 'Specifies the percentage to depreciate the fixed asset by the declining-balance principle, but with a fixed yearly percentage.', FRA = 'Spécifie le pourcentage pour amortir l''immobilisation selon la méthode Dégressif mais en utilisant un pourcentage annuel fixe.';
        }
        modify("First User-Defined Depr. Date")
        {
            ToolTipML = ENU = 'Specifies the starting date for the user-defined depreciation table if you have entered a code in the Depreciation Table Code field.', FRA = 'Spécifie la date début de la table amortissement paramétrable si vous avez saisi un code dans le champ Code table amortissement.';
        }
        modify("""Disposal Date"" > 0D")
        {
            CaptionML = ENU = 'Disposed Of', FRA = 'Cédé';
            ToolTipML = ENU = 'Specifies whether the fixed asset has been disposed of.', FRA = 'Spécifie si l''immobilisation a été cédée.';
        }
        //BC Upgrade KAPOOV01>>
        //modify("Book Value")
        modify(BookValue)
        //BC Upgrade KAPOOV01 Field name Book Value changed to BookValue in BC

        {
            ToolTipML = ENU = 'Specifies the book value for the fixed asset as a FlowField.', FRA = 'Spécifie la valeur comptable de l''immobilisation en tant que FlowField.';
        }
        modify("Depreciation Table Code")
        {
            ToolTipML = ENU = 'Specifies the code of the depreciation table to use if you have selected the User-Defined option in the Depreciation Method field.', FRA = 'Spécifie le code de la table amortissement à utiliser si vous avez sélectionné l''option Paramétrable dans le champ Méthode amortissement.';
        }
        modify("Final Rounding Amount")
        {
            ToolTipML = ENU = 'Specifies the final rounding amount to use.', FRA = 'Indique le montant final arrondi à utiliser.';
        }
        modify("Ending Book Value")
        {
            ToolTipML = ENU = 'Specifies the amount to use as the ending book value.', FRA = 'Indique le montant à utiliser comme valeur comptable finale.';
        }
        modify("Ignore Def. Ending Book Value")
        {
            ToolTipML = ENU = 'Specifies that the default ending book value is ignored, and the value in the Ending Book Value is used.', FRA = 'Spécifie que la valeur comptable finale par défaut est ignorée et que la valeur de la Valeur comptable finale est utilisée.';
        }
        modify("FA Exchange Rate")
        {
            ToolTipML = ENU = 'Specifies a decimal number, which will be used as an exchange rate when duplicating journal lines to this depreciation book.', FRA = 'Spécifie un nombre décimal, qui sera utilisé comme taux de change lors de la copie des lignes feuille vers cette loi d''amortissement.';
        }
        modify("Use FA Ledger Check")
        {
            ToolTipML = ENU = 'Specifies which checks to perform before posting a journal line.', FRA = 'Spécifie quelles vérifications effectuer avant de valider une ligne feuille.';
        }
        modify("Depr. below Zero %")
        {
            ToolTipML = ENU = 'Specifies a percentage if you have selected the Allow Depr. below Zero field in the depreciation book.', FRA = 'Indique un pourcentage si vous avez sélectionné le champ Autoriser amort. négatifs de la loi d''amortissement.';
        }
        modify("Fixed Depr. Amount below Zero")
        {
            ToolTipML = ENU = 'Specifies a positive amount if you have selected the Allow Depr. below Zero field in the depreciation book.', FRA = 'Indique un montant positif si vous avez sélectionné le champ Autoriser amort. négatifs de la loi d''amortissement.';
        }
        modify("Projected Disposal Date")
        {
            ToolTipML = ENU = 'Specifies the date on which you want to dispose of the fixed asset.', FRA = 'Spécifie la date à laquelle vous souhaitez céder l''immobilisation.';
        }
        modify("Projected Proceeds on Disposal")
        {
            ToolTipML = ENU = 'Specifies the expected proceeds from disposal of the fixed asset.', FRA = 'Spécifie les gains prévus sur la cession de l''immobilisation.';
        }
        modify("Depr. Starting Date (Custom 1)")
        {
            ToolTipML = ENU = 'Specifies the starting date for depreciation of custom 1 entries.', FRA = 'Spécifie la date de début pour l''amortissement des écritures Param. 1.';
        }
        modify("Depr. Ending Date (Custom 1)")
        {
            ToolTipML = ENU = 'Specifies the ending date for depreciation of custom 1 entries.', FRA = 'Spécifie la date de fin pour l''amortissement des écritures Param. 1.';
        }
        modify("Accum. Depr. % (Custom 1)")
        {
            ToolTipML = ENU = 'Specifies the total percentage for depreciation of custom 1 entries.', FRA = 'Spécifie le pourcentage total pour l''amortissement des écritures Param. 1.';
        }
        modify("Depr. This Year % (Custom 1)")
        {
            ToolTipML = ENU = 'Specifies the percentage for depreciation of custom 1 entries for the current year.', FRA = 'Spécifie le pourcentage pour l''amortissement des écritures Param. 1 pour l''année en cours.';
        }
        modify("Property Class (Custom 1)")
        {
            ToolTipML = ENU = 'Specifies the property class of the asset.', FRA = 'Spécifie la classe propriété de l''actif.';
        }
        modify("Use Half-Year Convention")
        {
            ToolTipML = ENU = 'Specifies that the Half-Year Convention is to be applied to the selected depreciation method.', FRA = 'Indique que la règle de la demi-année doit être appliquée à la méthode d''amortissement sélectionnée.';
        }
        modify("Use DB% First Fiscal Year")
        {
            ToolTipML = ENU = 'Specifies that the depreciation methods DB1/SL and DB2/SL use the declining balance depreciation amount in the first fiscal year.', FRA = 'Indique que les méthodes d''amortissement DB1/SL et DB2/SL utilisent le montant d''amortissement dégressif au cours du premier exercice comptable.';
        }
        modify("Temp. Ending Date")
        {
            ToolTipML = ENU = 'Specifies the ending date of the period during which a temporary fixed depreciation amount will be used.', FRA = 'Spécifie la date de fin de la période d''utilisation d''un montant d''annuité d''amortissement temporaire.';
        }
        modify("Temp. Fixed Depr. Amount")
        {
            ToolTipML = ENU = 'Specifies a temporary fixed depreciation amount.', FRA = 'Spécifie un montant d''annuité d''amortissement temporaire.';
        }

        //Unsupported feature: CodeModification on "GetAddCurrCode(Control 67).OnAssistEdit". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameterFA("FA Add.-Currency Factor",GetAddCurrCode,WORKDATE);
        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
          "FA Add.-Currency Factor" := ChangeExchangeRate.GetParameter;

        CLEAR(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameterFA("FA Add.-Currency Factor",GetAddCurrCode,WORKDATE);
        if ChangeExchangeRate.RUNMODAL = ACTION::OK then
        #3..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Book Value"(Control 2).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Disposal Date" > 0D THEN
          ShowBookValueAfterDisposal
        else BEGIN
          SetBookValueFiltersOnFALedgerEntry(FALedgEntry);
          PAGE.RUN(0,FALedgEntry);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Disposal Date" > 0D then
          ShowBookValueAfterDisposal
        else begin
          SetBookValueFiltersOnFALedgerEntry(FALedgEntry);
          PAGE.RUN(0,FALedgEntry);
        end;
        */
        //end;
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("Temp. Fixed Depr. Amount")
        {
            field(Derogatory; Rec.Derogatory)
            {
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
    }
    actions
    {
        modify("&Depr. Book")
        {
            CaptionML = ENU = '&Depr. Book', FRA = '&Plans amort.';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the ledger entries for the fixed asset.', FRA = 'Affichez les écritures comptables de l''immobilisation.';
        }
        modify("Error Ledger Entries")
        {
            CaptionML = ENU = 'Error Ledger Entries', FRA = 'Erreur écritures comptables';
            ToolTipML = ENU = 'View the entries that have been posted as a result of you using the Cancel function to cancel an entry.', FRA = 'Affichez les écritures qui ont été validées en tant que résultat de l''annulation d''une écriture.';
        }
        modify("Maintenance Ledger Entries")
        {
            CaptionML = ENU = 'Maintenance Ledger Entries', FRA = 'Écritures comptables maintenance';
            ToolTipML = ENU = 'View the maintenance ledger entries for the fixed asset.', FRA = 'Affichez les écritures comptables maintenance de l''immobilisation.';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
            ToolTipML = ENU = 'View detailed historical information about the fixed asset.', FRA = 'Affichez des informations d''historique détaillées sur l''immobilisation.';
        }
        modify("Main &Asset Statistics")
        {
            CaptionML = ENU = 'Main &Asset Statistics', FRA = 'Statistiques i&mmo. princ.';
            ToolTipML = ENU = 'View statistics for all the components that make up the main asset for the selected book. ', FRA = 'Affichez les statistiques de tous les composants de l''immobilisation pour la loi d''amortissement sélectionnée. ';
        }
    }


    //Unsupported feature: CodeModification on "GetAddCurrCode(PROCEDURE 1)". Please convert manually.

    //procedure GetAddCurrCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT AddCurrCodeIsFound THEN
      GLSetup.GET;
    EXIT(GLSetup."Additional Reporting Currency");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if not AddCurrCodeIsFound then
      GLSetup.GET;
    exit(GLSetup."Additional Reporting Currency");
    */
    //end;


    //Unsupported feature: CodeModification on "ShowFALedgEntries(PROCEDURE 2)". Please convert manually.

    //procedure ShowFALedgEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DepreciationCalc.SetFAFilter(FALedgEntry,"FA No.","Depreciation Book Code",FALSE);
    PAGE.RUN(PAGE::"FA Ledger Entries",FALedgEntry);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DepreciationCalc.SetFAFilter(FALedgEntry,"FA No.","Depreciation Book Code",false);
    PAGE.RUN(PAGE::"FA Ledger Entries",FALedgEntry);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

