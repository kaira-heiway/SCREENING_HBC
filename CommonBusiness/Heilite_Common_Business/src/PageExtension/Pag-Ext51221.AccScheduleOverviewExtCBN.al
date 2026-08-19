pageextension 51221 AccScheduleOverviewExtCBN extends "Acc. Schedule Overview"
{
    // version NAVW110.0,HEI.03

    //  HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La R‚union_France Fiscal Year Closing
    //     # Added code in OnInit(), OnOpenPage()
    //     # New field in General gorup: IncludeSimulation
    //     # Modified function CurrentSchedNameOnAfterValidate
    //   HEI.02 CHG2200302 IBM POENAB02 17.05.2023 P&L by Nature in Heilite Base
    //     # Added FinancialStFilter in General Group
    //     # Code added in OnOpenPage, FinancialStFilter - OnValidate
    //     # New field added - 50001 CIL account
    //   HEI.03 CHG2215009 IBM POENAB02 04.10.2023 HB3349 Enhancement of HB3349 To add column for L3 in main view
    //     # New field added - 50002 L3 Account
    //***********************************************************//
    //BC UPGRADE SIVA //
    //1.HEI.01 Oninit()Commented FrenchLocalization code & Added OnOpenPage() code. CurrentSchedNameOnAfterValidate Function based on
    //FrenchLocalization
    //2.HEI.02 Added FinancialStFilter & code
    //3.HEI.03 Added field.

    // POENAB02 25.02.2026 gap/fit fixes for P&L by Nature

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify(CurrentSchedName)
        {
            CaptionML = ENU = 'Account Schedule Name', FRA = 'Nom tableau d''analyse';
            ToolTipML = ENU = 'Specifies the name of the account schedule to be shown in the window.', FRA = 'Spécifie le nom du tableau d''analyse qui doit être affiché dans la fenêtre.';
        }
        modify(CurrentColumnName)
        {
            CaptionML = ENU = 'Column Layout Name', FRA = 'Nom présentation colonne';
            ToolTipML = ENU = 'Specifies the name of the column layout that you want to use in the window.', FRA = 'Spécifie le nom de la présentation colonne que vous souhaitez utiliser dans cette fenêtre.';
        }
        modify(UseAmtsInAddCurr)
        {
            CaptionML = ENU = 'Show Amounts in Add. Reporting Currency', FRA = 'Afficher montants en devise report';
            ToolTipML = ENU = 'Specifies that the Account Schedule Overview window shows amounts in the additional reporting currency.', FRA = 'Spécifie que la fenêtre Aperçu du tableau d''analyse affiche des montants dans la devise report supplémentaire.';
        }
        modify(PeriodType)
        {
            CaptionML = ENU = 'View by', FRA = 'Afficher par';
            ToolTipML = ENU = 'Specifies by which period amounts are displayed.', FRA = 'Indique selon quelle périodicité les montants sont affichés.';
            // BC Upgrade MISHRS14 >>
            // Below its enum not option
            //OptionCaptionML = ENU = 'Day,Week,Month,Quarter,Year,Accounting Period', FRA = 'Jour,Semaine,Mois,Trimestre,Année,Période comptable';
            // BC Upgrade MISHRS14 <<
        }
        modify(DateFilter)
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
            ToolTipML = ENU = 'Specifies the dates that will be used to filter the amounts in the window.', FRA = 'Indique les dates qui sont utilisées pour filtrer les montants dans la fenêtre.';
        }
        modify("Dimension Filters")
        {
            CaptionML = ENU = 'Dimension Filters', FRA = 'Filtres axe';
        }
        modify(Dim1Filter)
        {
            CaptionML = ENU = 'Dimension 1 Filter', FRA = 'Filtre axe 1';
            ToolTipML = ENU = 'Specifies a filter for the Dimension 1 for which entries will be shown in the matrix window.', FRA = 'Spécifie un filtre pour l''Axe analytique 1 pour lequel des entrées seront affichées dans la fenêtre de matrice.';
        }
        modify(Dim2Filter)
        {
            CaptionML = ENU = 'Dimension 2 Filter', FRA = 'Filtre axe 2';
            ToolTipML = ENU = 'Specifies a filter for the Dimension 2 for which entries will be shown in the matrix window.', FRA = 'Spécifie un filtre pour l''Axe analytique 2 en fonction duquel des entrées seront affichées dans la fenêtre de matrice.';
        }
        modify(Dim3Filter)
        {
            CaptionML = ENU = 'Dimension 3 Filter', FRA = 'Filtre axe 3';
            ToolTipML = ENU = 'Specifies a filter for the Dimension 3 for which entries will be shown in the matrix window.', FRA = 'Spécifie un filtre pour l''Axe analytique 3 pour lequel des entrées seront affichées dans la fenêtre de matrice.';
        }
        modify(Dim4Filter)
        {
            CaptionML = ENU = 'Dimension 4 Filter', FRA = 'Filtre axe 4';
            ToolTipML = ENU = 'Specifies a filter for the Dimension 4 for which entries will be shown in the matrix window.', FRA = 'Spécifie un filtre pour l''Axe analytique 4 pour lequel des entrées seront affichées dans la fenêtre de matrice.';
        }
        modify(CostCenterFilter)
        {
            CaptionML = ENU = 'Cost Center Filter', FRA = 'Filtre centre de coûts';
        }
        modify(CostObjectFilter)
        {
            CaptionML = ENU = 'Cost Object Filter', FRA = 'Filtre objet de coûts';
        }
        modify(CashFlowFilter)
        {
            CaptionML = ENU = 'Cash Flow Filter', FRA = 'Filtre de trésorerie';
        }
        modify("G/LBudgetFilter")
        {
            CaptionML = ENU = 'G/L Budget Filter', FRA = 'Filtre budget comptable';
            ToolTipML = ENU = 'Specifies a code for a general ledger budget that the account schedule line will be filtered on.', FRA = 'Affiche un code pour un budget comptabilité selon lequel la ligne tableau d''analyse sera filtrée.';
        }
        modify(CostBudgetFilter)
        {
            CaptionML = ENU = 'Cost Budget Filter', FRA = 'Filtre de budget des coûts';
            ToolTipML = ENU = 'Specifies a code for a cost budget that the account schedule line will be filtered on.', FRA = 'Affiche un code pour un budget des coûts selon lequel la ligne tableau d''analyse sera filtrée.';
        }
        modify("Row No.")
        {
            ToolTipML = ENU = 'Specifies a number for the account schedule line.', FRA = 'Spécifie un numéro pour la ligne tableau d''analyse.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies text that will appear on the account schedule line.', FRA = 'Spécifie le texte qui figure sur la ligne du tableau d''analyse.';
        }
        addafter(CurrentColumnName)
        {
            field(IncludeSimulation; IncludeSimulation)
            {
                ApplicationArea = Suite;
                CaptionML = ENU = 'Include Simulation',
                            FRA = 'Inclure simulation';
                ToolTip = 'Include Simulation';
                Editable = IncludeSimulationEditable;
                Enabled = FRLocAction;
                Visible = FRLocAction;

                trigger OnValidate();
                begin
                    CurrPage.UPDATE();
                end;
            }
        }
        addafter(DateFilter)
        {
            field(FinancialStFilter; FinancialStFilter)
            {
                ApplicationArea = all;
                ToolTip = 'Financial St. Ver. to Exclude';
                Caption = 'Financial St. Ver. to Exclude';
                Enabled = FinancialStFilterEnable;
                Importance = Promoted;
                Visible = FinancialStFilterEnable;

                trigger OnValidate();
                var
                    lTextFilter: Text;
                    lPos: Integer;
                    lNoOfUsedFilters: Integer;
                begin
                    //HEI.02>>
                    if FinancialStFilter = '' then
                        Rec.SETRANGE("Finan. St. Ver. to Exclude FND")
                    else
                        Rec.SETFILTER("Finan. St. Ver. to Exclude FND", FinancialStFilter);
                    CurrPage.UPDATE();

                    lTextFilter := FinancialStFilter;
                    if lTextFilter <> '' then begin
                        lNoOfUsedFilters := 0;
                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'BLANK');
                        if lPos <> 0 then
                            lNoOfUsedFilters += 1;
                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'LOCAL');
                        if lPos <> 0 then
                            lNoOfUsedFilters += 1;
                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'HEINEKEN');
                        if lPos <> 0 then
                            lNoOfUsedFilters += 1;
                        lPos := STRPOS(UPPERCASE(FinancialStFilter), 'COMMON');
                        if lPos <> 0 then
                            lNoOfUsedFilters += 1;
                        if lNoOfUsedFilters = 0 then
                            MESSAGE(Text50000);
                    end;
                    //HEI.02<<
                end;
            }
        }
        addafter("Row No.")
        {
            field("CIL account"; Rec."CIL account FND")
            {
                ApplicationArea = all;
                ToolTip = 'CIL account';
                Editable = false;
                Visible = ShowCILAcc;
            }
            field("L3 Account"; Rec."L3 Account FND")
            {
                ApplicationArea = all;
                ToolTip = 'L3 Account';
                Editable = false;
                Visible = ShowCILAcc;
            }
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(Print)
        {
            CaptionML = ENU = 'Print', FRA = 'Imprimer';
            ToolTipML = ENU = 'Print the information in the window. A print request window opens where you can specify what to include on the print-out.', FRA = 'Imprimez les informations dans la fenêtre. Une fenêtre de demande d''impression s''ouvre et vous permet d''indiquer les éléments à imprimer.';
        }
        modify(PreviousColumn)
        {
            CaptionML = ENU = 'Previous Column', FRA = 'Colonne précédente';
            ToolTipML = ENU = 'Go to the previous column.', FRA = 'Accédez à la colonne précédente.';
        }
        modify(NextPeriod)
        {
            CaptionML = ENU = 'Next Period', FRA = 'Période suivante';
            ToolTipML = ENU = 'Show the information based on the next period. If you set the View by field to Day, the date filter changes to the day before.', FRA = 'Affichez les informations en fonction de la période suivante. Si vous définissez le champ Afficher par, le filtre date passe sur le jour précédent.';
        }
        modify(PreviousPeriod)
        {
            CaptionML = ENU = 'Previous Period', FRA = 'Période précédente';
            ToolTipML = ENU = 'Show the information based on the previous period. If you set the View by field to Day, the date filter changes to the day before.', FRA = 'Affichez les informations en fonction de la période précédente. Si vous définissez le champ Afficher par, le filtre date passe sur le jour précédent.';
        }
        modify(NextColumn)
        {
            CaptionML = ENU = 'Next Column', FRA = 'Colonne suivante';
            ToolTipML = ENU = 'Show the account schedule based on the next column.', FRA = 'Affichez le tableau d''analyse en fonction de la colonne suivante.';
        }
        modify(Recalculate)
        {
            CaptionML = ENU = 'Recalculate', FRA = 'Recalculer';
            ToolTipML = ENU = 'Update the account schedule overview based on recent changes.', FRA = 'Mettez à jour l''aperçu du tableau d''analyse en fonction de modifications récentes.';
        }
        modify(Excel)
        {
            CaptionML = ENU = 'Excel', FRA = 'Excel';
        }
        modify("Export to Excel")
        {
            CaptionML = ENU = 'Export to Excel', FRA = 'Exporter vers Excel';
        }
        modify("Create New Document")
        {
            CaptionML = ENU = 'Create New Document', FRA = 'Créer un document';
            ToolTipML = ENU = 'Open the account schedule overview in a new Excel workbook. This creates an Excel workbook on your device.', FRA = 'Ouvrez l''aperçu du tableau d''analyse dans un nouveau classeur Excel. Cela crée un classeur Excel sur votre appareil.';
        }
        modify("Update Existing Document")
        {
            CaptionML = ENU = 'Update Existing Document', FRA = 'Mettre à jour le document existant';
            ToolTipML = ENU = 'Refresh the data in an existing Excel workbook. You must specify the workbook that you want to update.', FRA = 'Actualisez les données dans un classeur Excel existant. Vous devez spécifier le classeur que vous voulez mettre à jour.';
        }
    }

    trigger OnOpenPage()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        // BC Upgrade POENAB02 25.02.2026 >>
        // gap/fit fixes for P&L by Nature
        GLSetup.Get();
        NewCurrentSchedName := TempFinancialReport.Name; // BC Upgrade POENAB02 25.02.2026, gap/fit fixes for P&L by Nature
        // BC Upgrade POENAB02 25.02.2026 <<
        //HEI.02>>
        FinancialStFilterEnable := FALSE;
        ShowCILAcc := FALSE;
        if NewCurrentSchedName <> '' then // BC Upgrade POENAB02
            IF GLSetup."P&L by Nature code FND" = NewCurrentSchedName THEN BEGIN
                FinancialStFilterEnable := TRUE;
                FinancialStFilter := 'Local';
                Rec.SETFILTER("Finan. St. Ver. to Exclude FND", FinancialStFilter);
                ShowCILAcc := TRUE;
            END;
        //HEI.02<<
    END;



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=DEFAULT;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=DEFAULT;FRA=DEFAUT;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=1,6,,Dimension %1 Filter;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=1,6,,Dimension %1 Filter;FRA=1,6,,Filtre axe analytique %1;
    //Variable type has not been exported.

    var
        IncludeSimulation: Boolean;
        CompanyInfo: Record "Company Information";
        IncludeSimulationEditable: Boolean;
        FRLocAction: Boolean;
        FinancialStFilter: Text;
        FinancialStFilterEnable: Boolean;
        Text50000: Label 'Please check the filters for "Financial St. Ver. to Exclude"! No filter is applied for "Financial St. Ver. to Exclude"!';
        ShowCILAcc: Boolean;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Dim4FilterEnable := true;
    Dim3FilterEnable := true;
    Dim2FilterEnable := true;
    Dim1FilterEnable := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    //HEI.01>>
    FRLocAction := false;
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      begin
        IncludeSimulationEditable := true;
        FRLocAction := true;
      end;
    //HEI.01<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLSetup.GET;
    UseAmtsInAddCurrVisible := GLSetup."Additional Reporting Currency" <> '';
    if NewCurrentSchedName <> '' then
      CurrentSchedName := NewCurrentSchedName;
    if CurrentSchedName = '' then
      CurrentSchedName := Text000;
    if NewCurrentColumnName <> '' then
      CurrentColumnName := NewCurrentColumnName;
    if CurrentColumnName = '' then
    #10..37
    SETRANGE("G/L Budget Filter");
    UpdateDimFilterControls;
    DateFilter := GETFILTER("Date Filter");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    //HEI.01>>
    if CompanyInfo."Enable French Localization" then
      begin
        IncludeSimulation := false;
        if AccSchedName.GET(CurrentSchedName) then
          if AccSchedName."Analysis View Name" <> '' then begin
            IncludeSimulationEditable := false;
            if AnalysisView.GET(AccSchedName."Analysis View Name") then
              IncludeSimulation := false;
          end else
            IncludeSimulationEditable := true;
      end;
    //HEI.01<<
    #7..40

    //HEI.02>>
    FinancialStFilterEnable := false;
    ShowCILAcc := false;
    if GLSetup."P&L by Nature code" = CurrentSchedName then
      begin
        FinancialStFilterEnable := true;
        FinancialStFilter := 'Local';
        SETFILTER("Financial St. Ver. to Exclude",FinancialStFilter);
        ShowCILAcc := true;
      end;
    //HEI.02<<
    */
    //end;


    //Unsupported feature: CodeModification on "CurrentSchedNameOnAfterValidate(PROCEDURE 19053875)". Please convert manually.

    //procedure CurrentSchedNameOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SAVERECORD;
    AccSchedManagement.SetName(CurrentSchedName,Rec);
    if AccSchedName.GET(CurrentSchedName) then
      if (AccSchedName."Default Column Layout" <> '') and
         (CurrentColumnName <> AccSchedName."Default Column Layout")
      then begin
        CurrentColumnName := AccSchedName."Default Column Layout";
        AccSchedManagement.CopyColumnsToTemp(CurrentColumnName,TempColumnLayout);
        AccSchedManagement.SetColumnName(CurrentColumnName,TempColumnLayout);
      end;
    AccSchedManagement.CheckAnalysisView(CurrentSchedName,CurrentColumnName,true);

    if AccSchedName."Analysis View Name" <> AnalysisView.Code then begin
      PrevAnalysisView := AnalysisView;
      if AccSchedName."Analysis View Name" <> '' then
        AnalysisView.GET(AccSchedName."Analysis View Name")
      else begin
        CLEAR(AnalysisView);
        AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
        AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
      end;
      if PrevAnalysisView."Dimension 1 Code" <> AnalysisView."Dimension 1 Code" then
        SETRANGE("Dimension 1 Filter");
      if PrevAnalysisView."Dimension 2 Code" <> AnalysisView."Dimension 2 Code" then
        SETRANGE("Dimension 2 Filter");
      if PrevAnalysisView."Dimension 3 Code" <> AnalysisView."Dimension 3 Code" then
        SETRANGE("Dimension 3 Filter");
      if PrevAnalysisView."Dimension 4 Code" <> AnalysisView."Dimension 4 Code" then
        SETRANGE("Dimension 4 Filter");
    end;
    UpdateDimFilterControls;

    CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CompanyInfo.GET;//HEI.01
    IncludeSimulation := false;//HEI.01
    CurrPage.SAVERECORD;
    AccSchedManagement.SetName(CurrentSchedName,Rec);
    //HEI.01>>
    if not CompanyInfo."Enable French Localization" then
      begin
    //HEI.01<<
        if AccSchedName.GET(CurrentSchedName) then
          if (AccSchedName."Default Column Layout" <> '') and
             (CurrentColumnName <> AccSchedName."Default Column Layout")
          then begin
            CurrentColumnName := AccSchedName."Default Column Layout";
            AccSchedManagement.CopyColumnsToTemp(CurrentColumnName,TempColumnLayout);
            AccSchedManagement.SetColumnName(CurrentColumnName,TempColumnLayout);
          end;
      //HEI.01>>
      end;
      //HEI.01<<

    //HEI.01>>
    if CompanyInfo."Enable French Localization" then
      begin
        if AccSchedName.GET(CurrentSchedName) then
          if AccSchedName."Analysis View Name" <> '' then begin
            IncludeSimulationEditable := false;
            if AnalysisView.GET(AccSchedName."Analysis View Name") then
              IncludeSimulation := true;
          end else
            IncludeSimulationEditable := true;
        if (AccSchedName."Default Column Layout" <> '') and
           (CurrentColumnName <> AccSchedName."Default Column Layout")
        then begin
          CurrentColumnName := AccSchedName."Default Column Layout";
          AccSchedManagement.CopyColumnsToTemp(CurrentColumnName,TempColumnLayout);
          AccSchedManagement.SetColumnName(CurrentColumnName,TempColumnLayout);
        end;
      end;
    //HEI.01<<

    #11..33
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

