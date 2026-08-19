pageextension 51064 FAPostTypesOvervMatrixExtCBN extends "FA Posting Types Overv. Matrix"
{
    // HEI.01 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Code added on Function "MATRIX_OnAfterGetRecord"
    // HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added on Function "MATRIX_OnDrillDown"
    // version NAVW110.0

    layout
    {
        modify("FA No.")
        {
            ToolTipML = ENU = 'Specifies a fixed asset that you have set up.', FRA = 'Spécifie une immobilisation que vous avez définie.';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
            ToolTipML = ENU = 'Specifies a depreciation book to assign to the fixed asset you have entered in the FA No. field.', FRA = 'Spécifie des lois d''amortissement à affecter aux immobilisations entrées dans le champ N° immo.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the value in the Description field on the fixed asset card.', FRA = 'Spécifie la valeur du champ Description sur la fiche immobilisation.';
        }
    }
    actions
    {
        modify("&Related Information")
        {
            CaptionML = ENU = '&Related Information', FRA = 'Info&rmations connexes';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the ledger entries for the selected fixed asset.', FRA = 'Affichez les écritures comptables de l''immobilisation sélectionnée.';
        }
        modify("Error Ledger Entries")
        {
            CaptionML = ENU = 'Error Ledger Entries', FRA = 'Erreur écritures comptables';
            ToolTipML = ENU = 'View the entries that have been posted as a result of you using the cancel function to cancel an entry.', FRA = 'Affichez les écritures qui ont été validées en tant que résultat de l''annulation d''une écriture.';
        }
        modify("Maintenance Ledger Entries")
        {
            CaptionML = ENU = 'Maintenance Ledger Entries', FRA = 'Écritures comptables maintenance';
            ToolTipML = ENU = 'View the maintenance ledger entries for the selected fixed asset.', FRA = 'Affichez les écritures comptables maintenance de l''immobilisation sélectionnée.';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
            ToolTipML = ENU = 'View detailed historical information about the fixed asset.', FRA = 'Affichez des informations d''historique détaillées sur l''immobilisation.';
        }
        modify("Main &Asset Statistics")
        {
            CaptionML = ENU = 'Main &Asset Statistics', FRA = 'Statistiques i&mmo. princ.';
            ToolTipML = ENU = 'View statistics for all the components that make up the main asset for the selected book. The left side of the General FastTab displays the main asset''s book value, depreciable basis and any maintenance expenses posted to the components that comprise the main asset. The right side shows the number of components for the main asset, the first date on which an acquisition and/or disposal entry was posted to one of the assets that comprise the main asset.', FRA = 'Affichez les statistiques de tous les composants de l''immobilisation principale pour la loi d''amortissement sélectionnée. La partie gauche du raccourci Général affiche la valeur comptable de l''immobilisation principale, la base d''amortissement et les frais de maintenance validés sur les composants de l''immobilisation principale. La partie droite affiche le nombre de composants de l''immobilisation principale, la première date à laquelle une écriture d''acquisition et/ou de cession a été validée pour l''une des immobilisations qui forment l''immobilisation principale.';
        }
    }
    var
        CompanyInfo: Record "Company Information";

    var
    // CompanyInfo: Record "Company Information";//BC Upgrade KAPOOV01>>


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MATRIX_CurrentColumnOrdinal := 0;
    WHILE MATRIX_CurrentColumnOrdinal < MATRIX_CurrentNoOfMatrixColumn DO BEGIN
      MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
      MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    MATRIX_CurrentColumnOrdinal := 0;
    while MATRIX_CurrentColumnOrdinal < MATRIX_CurrentNoOfMatrixColumn do begin
      MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
      MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
    end;
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Field32Visible := TRUE;
    Field31Visible := TRUE;
    Field30Visible := TRUE;
    Field29Visible := TRUE;
    Field28Visible := TRUE;
    Field27Visible := TRUE;
    Field26Visible := TRUE;
    Field25Visible := TRUE;
    Field24Visible := TRUE;
    Field23Visible := TRUE;
    Field22Visible := TRUE;
    Field21Visible := TRUE;
    Field20Visible := TRUE;
    Field19Visible := TRUE;
    Field18Visible := TRUE;
    Field17Visible := TRUE;
    Field16Visible := TRUE;
    Field15Visible := TRUE;
    Field14Visible := TRUE;
    Field13Visible := TRUE;
    Field12Visible := TRUE;
    Field11Visible := TRUE;
    Field10Visible := TRUE;
    Field9Visible := TRUE;
    Field8Visible := TRUE;
    Field7Visible := TRUE;
    Field6Visible := TRUE;
    Field5Visible := TRUE;
    Field4Visible := TRUE;
    Field3Visible := TRUE;
    Field2Visible := TRUE;
    Field1Visible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Field32Visible := true;
    Field31Visible := true;
    Field30Visible := true;
    Field29Visible := true;
    Field28Visible := true;
    Field27Visible := true;
    Field26Visible := true;
    Field25Visible := true;
    Field24Visible := true;
    Field23Visible := true;
    Field22Visible := true;
    Field21Visible := true;
    Field20Visible := true;
    Field19Visible := true;
    Field18Visible := true;
    Field17Visible := true;
    Field16Visible := true;
    Field15Visible := true;
    Field14Visible := true;
    Field13Visible := true;
    Field12Visible := true;
    Field11Visible := true;
    Field10Visible := true;
    Field9Visible := true;
    Field8Visible := true;
    Field7Visible := true;
    Field6Visible := true;
    Field5Visible := true;
    Field4Visible := true;
    Field3Visible := true;
    Field2Visible := true;
    Field1Visible := true;
    */
    //end;


    //Unsupported feature: CodeModification on "Load(PROCEDURE 1093)". Please convert manually.

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FOR i := 1 TO CurrentNoOfMatrixColumns DO BEGIN
      MATRIX_CaptionSet[i] := MatrixColumns1[i];
      MatrixRecords[i] := MatrixRecords1[i];
    end;
    MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;
    DateFilter := DateFilterLocal;
    RoundingFactor := RoundingFactorLocal;
    RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    for i := 1 to CurrentNoOfMatrixColumns do begin
      MATRIX_CaptionSet[i] := MatrixColumns1[i];
      MatrixRecords[i] := MatrixRecords1[i];
    end;
    #5..7
    RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,false);
    */
    //end;

    // procedure CompanyInfo();
    // begin
    // end;//BC Upgrade KAPOOV01


    //Unsupported feature: CodeModification on ""MATRIX_OnDrillDown"(PROCEDURE 1094)". Please convert manually.

    //procedure "MATRIX_OnDrillDown"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DP_Book2.SETRANGE("FA No.","FA No.");
    DP_Book2.SETRANGE("Depreciation Book Code","Depreciation Book Code");

    IF DP_Book2.FINDFIRST THEN
      FALedgerEntry.SETRANGE("Depreciation Book Code",DP_Book2."Depreciation Book Code")
    else
      FALedgerEntry.SETRANGE("Depreciation Book Code");
    FALedgerEntry.SETFILTER("FA Posting Date",DateFilter);
    FALedgerEntry.SETRANGE("FA No.","FA No.");

    CASE MatrixRecords[MATRIX_ColumnOrdinal]."Entry No." OF
      1:// 'Book Value'
        BEGIN
          FALedgerEntry.SETRANGE("Part of Book Value",TRUE);
          PAGE.RUN(0,FALedgerEntry);
        end;
      2:// 'Acquisition Cost'
        BEGIN
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Acquisition Cost");
          PAGE.RUN(0,FALedgerEntry);
        end;
      3:// 'Depreciation'
        BEGIN
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::Depreciation);
          PAGE.RUN(0,FALedgerEntry);
        end;
      4:// 'Write-Down'
        BEGIN
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Write-Down");
          PAGE.RUN(0,FALedgerEntry);
        end;
      5:// 'Appreciation'
        BEGIN
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::Appreciation);
          PAGE.RUN(0,FALedgerEntry);
        end;
      6:// 'Custom 1'
        BEGIN
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Custom 1");
          PAGE.RUN(0,FALedgerEntry);
        end;
      7:// 'Custom 2'
        BEGIN
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Custom 2");
          PAGE.RUN(0,FALedgerEntry);
        end;
      8:// 'Proceeds on Disposal'
        BEGIN
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Proceeds on Disposal");
          PAGE.RUN(0,FALedgerEntry);
        end;
      9:// 'Gain/Loss'
        BEGIN
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Gain/Loss");
          PAGE.RUN(0,FALedgerEntry);
        end;
      10:// 'Depreciable Basis'
        BEGIN
          FALedgerEntry.SETRANGE("Part of Depreciable Basis",TRUE);
          PAGE.RUN(0,FALedgerEntry);
        end;
      11:// 'Salvage Value'
        BEGIN
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Salvage Value");
          PAGE.RUN(0,FALedgerEntry);
        end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if DP_Book2.FINDFIRST then
      FALedgerEntry.SETRANGE("Depreciation Book Code",DP_Book2."Depreciation Book Code")
    else
    #7..10
    case MatrixRecords[MATRIX_ColumnOrdinal]."Entry No." of
      1:// 'Book Value'
        begin
          FALedgerEntry.SETRANGE("Part of Book Value",true);
          PAGE.RUN(0,FALedgerEntry);
        end;
      2:// 'Acquisition Cost'
        begin
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Acquisition Cost");
          PAGE.RUN(0,FALedgerEntry);
        end;
      3:// 'Depreciation'
        begin
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::Depreciation);
          PAGE.RUN(0,FALedgerEntry);
        end;
      4:// 'Write-Down'
        begin
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Write-Down");
          PAGE.RUN(0,FALedgerEntry);
        end;
      5:// 'Appreciation'
        begin
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::Appreciation);
          PAGE.RUN(0,FALedgerEntry);
        end;
      6:// 'Custom 1'
        begin
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Custom 1");
          PAGE.RUN(0,FALedgerEntry);
        end;
      7:// 'Custom 2'
        begin
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Custom 2");
          PAGE.RUN(0,FALedgerEntry);
        end;
      8:// 'Proceeds on Disposal'
        begin
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Proceeds on Disposal");
          PAGE.RUN(0,FALedgerEntry);
        end;
      9:// 'Gain/Loss'
        begin
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Gain/Loss");
          PAGE.RUN(0,FALedgerEntry);
        end;
      10:// 'Depreciable Basis'
        begin
          FALedgerEntry.SETRANGE("Part of Depreciable Basis",true);
          PAGE.RUN(0,FALedgerEntry);
        end;
      11:// 'Salvage Value'
        begin
          FALedgerEntry.SETRANGE("FA Posting Type",FALedgerEntry."FA Posting Type"::"Salvage Value");
          PAGE.RUN(0,FALedgerEntry);
        end;
      //HEI.02>>
      12:// 'Derogatory'
        begin
          CompanyInfo.GET;
          if CompanyInfo."Enable French Localization" then begin
            if FINDFIRST then
              CALCFIELDS(Derogatory);
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(Derogatory,RoundingFactor);
          end;
        end;
      //HEI.02<<
    end;
    */
    //end;

    // procedure CompanyInfo();
    // begin
    // end;//BC Upgrade KAPOOV01>>


    //Unsupported feature: CodeModification on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1096)". Please convert manually.

    //procedure "MATRIX_OnAfterGetRecord"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WITH FADeprBook DO BEGIN
      SETFILTER("FA Posting Date Filter",DateFilter);
      SETRANGE("FA No.",Rec."FA No.");
      SETRANGE("Depreciation Book Code",Rec."Depreciation Book Code");
      CASE MatrixRecords[MATRIX_ColumnOrdinal]."Entry No." OF
        1:// 'Book Value'
          BEGIN
            IF FINDFIRST THEN
              CalcBookValue;
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Book Value",RoundingFactor);
          end;
        10:// 'Depreciable Basis'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS("Depreciable Basis");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Depreciable Basis",RoundingFactor);
          end;
        2:// 'Acquisition Cost'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS("Acquisition Cost");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Acquisition Cost",RoundingFactor);
          end;
        3:// 'Depreciation'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS(Depreciation);
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(Depreciation,RoundingFactor);
          end;
        4:// 'Write-Down'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS("Write-Down");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Write-Down",RoundingFactor);
          end;
        5:// 'Appreciation'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS(Appreciation);
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(Appreciation,RoundingFactor);
          end;
        6:// 'Custom 1'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS("Custom 1");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Custom 1",RoundingFactor);
          end;
        7:// 'Custom 2'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS("Custom 2");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Custom 2",RoundingFactor);
          end;
        9:// 'Gain/Loss'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS("Gain/Loss");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Gain/Loss",RoundingFactor);
          end;
        8:// 'Proceeds on Disposal'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS("Proceeds on Disposal");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Proceeds on Disposal",RoundingFactor);
          end;
        11:// 'Salvage Value'
          BEGIN
            IF FINDFIRST THEN
              CALCFIELDS("Salvage Value");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Salvage Value",RoundingFactor);
          end;
      end;
    end;

    SetVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    with FADeprBook do begin
    #2..4
      case MatrixRecords[MATRIX_ColumnOrdinal]."Entry No." of
        1:// 'Book Value'
          begin
            if FINDFIRST then
              CalcBookValue;
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Book Value",RoundingFactor);
          end;
        10:// 'Depreciable Basis'
          begin
            if FINDFIRST then
              CALCFIELDS("Depreciable Basis");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Depreciable Basis",RoundingFactor);
          end;
        2:// 'Acquisition Cost'
          begin
            if FINDFIRST then
              CALCFIELDS("Acquisition Cost");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Acquisition Cost",RoundingFactor);
          end;
        3:// 'Depreciation'
          begin
            if FINDFIRST then
              CALCFIELDS(Depreciation);
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(Depreciation,RoundingFactor);
          end;
        4:// 'Write-Down'
          begin
            if FINDFIRST then
              CALCFIELDS("Write-Down");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Write-Down",RoundingFactor);
          end;
        5:// 'Appreciation'
          begin
            if FINDFIRST then
              CALCFIELDS(Appreciation);
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(Appreciation,RoundingFactor);
          end;
        6:// 'Custom 1'
          begin
            if FINDFIRST then
              CALCFIELDS("Custom 1");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Custom 1",RoundingFactor);
          end;
        7:// 'Custom 2'
          begin
            if FINDFIRST then
              CALCFIELDS("Custom 2");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Custom 2",RoundingFactor);
          end;
        9:// 'Gain/Loss'
          begin
            if FINDFIRST then
              CALCFIELDS("Gain/Loss");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Gain/Loss",RoundingFactor);
          end;
        8:// 'Proceeds on Disposal'
          begin
            if FINDFIRST then
              CALCFIELDS("Proceeds on Disposal");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Proceeds on Disposal",RoundingFactor);
          end;
        11:// 'Salvage Value'
          begin
            if FINDFIRST then
              CALCFIELDS("Salvage Value");
            MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue("Salvage Value",RoundingFactor);
          end;
        //HEI.01>>
        12:// 'Derogatory'
          begin
            CompanyInfo.GET;
            if CompanyInfo."Enable French Localization" then begin
              if FINDFIRST then
                CALCFIELDS(Derogatory);
              MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(Derogatory,RoundingFactor);
            end;
          end;
          //HEI.01<<
      end;
    end;

    SetVisible;
    */
    //end;


    //Unsupported feature: CodeModification on "FormatStr(PROCEDURE 8)". Please convert manually.

    //procedure FormatStr();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    EXIT(RoundingFactorFormatString);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    exit(RoundingFactorFormatString);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

