pageextension 55002 AnalysisbyDimensionsMatrixExt extends "Analysis by Dimensions Matrix"
{
    // version NAVW110.0,HEI.01

    //Bc Upgrade YADAVM09 Action Added Export to CIL3,Export to CIL3 EBF

    // POENAB02, 19.03.2026, Gap "BPM051-Create CAPEX budget", new object
    //Bc Upgrade YADAVM09,28.04.26 PID-475, PID-503, PID-504, PID-505, PID-535, PID-536, PID-537, PID-758GAP ID: IBM GAP RTR 09.
    //Bc Upgrade YADAVM09 Bug fix BCUP0-140.
    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code of the record.', FRA = 'Spécifie le code de l''enregistrement.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the record.', FRA = 'Spécifie le nom de l''enregistrement.';
        }
        modify(TotalAmount)
        {
            CaptionML = ENU = 'Total Amount', FRA = 'Montant total';
        }
        //POENAB02, 19.03.2026>>
        addafter(TotalAmount)
        {
            field("Volume 1"; rec."Volume 1 FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Total Volume 1', FRA = 'Volume total 1';
                ToolTipML = ENU = 'Specifies the total volume 1 of the record.', FRA = 'Spécifie le volume total 1 de l''enregistrement.';
            }
            field("Volume 2"; rec."Volume 2 FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Total Volume 2', FRA = 'Volume total 2';
                ToolTipML = ENU = 'Specifies the total volume 2 of the record.', FRA = 'Spécifie le volume total 2 de l''enregistrement.';
            }
        }
        //POENAB02, 19.03.2026<<        
    }
    actions
    {
        modify("&Actions")
        {
            CaptionML = ENU = '&Actions', FRA = '&Actions';
        }

        addafter(ExportToExcel)
        {
            separator(Separator1000000002)
            {
            }
            action("Export to CIL3")
            {
                Caption = 'Export to CIL3';
                ApplicationArea = ALL;
                ToolTip = 'Executes the Export to CIL3 action.';

                trigger OnAction();
                var
                    Lrep_CIL3Export: Report "Export CIL3 RTR";//Bc Upgrade YADAVM09,28.04.26<<
                    AnalysisViewCode: Code[10];
                    ShowActualBudg: Option "Actual Amounts","Budgeted Amounts",Variance,"Variance%","Index%",Amounts;
                    BudgetFilter: Text;
                    AccountFilter: Text;
                begin
                    // >>HEI:EDD072:1:1
                    CLEAR(Lrep_CIL3Export);
                    //Bc Upgrade YADAVM09 BCUP0-140>>
                    clear(AnalysisViewCode);
                    Clear(AccountFilter);
                    AnalysisViewCode := GSingleInstance.getAnalysisViewCode();
                    AccountFilter := GSingleInstance.GetValueforGLaccountCil3();
                    //Bc Upgrade YADAVM09 BCUP0-140<<
                    Lrep_CIL3Export.Setdefaults(AnalysisViewCode,
                                                ShowActualBudg,
                                                BudgetFilter,
                                                AccountFilter);//Bc Upgrade YADAVM09 BCUP0-140<<
                    Lrep_CIL3Export.RUNMODAL();
                    //<<HEI:EDD072:1:1
                end;
            }
            action("Export to CIL3 EBF")
            {
                Caption = 'Export to CIL3 EBF';
                ApplicationArea = All;
                ToolTip = 'Executes the Export to CIL3 EBF action.';

                trigger OnAction()
                var
                    Lrep_CIL3Export: Report "CIL3 Export - EBF RTR";//Bc Upgrade YADAVM09,28.04.26<<
                    AnalysisViewCode: Code[10];
                    ShowActualBudg: Option "Actual Amounts","Budgeted Amounts",Variance,"Variance%","Index%",Amounts;
                    BudgetFilter: Text;
                    AccountFilter: Text;
                begin
                    //     //>>HEI:EDD072:1:1
                    CLEAR(Lrep_CIL3Export);
                    //Bc Upgrade YADAVM09 BCUP0-140>>
                    clear(AnalysisViewCode);
                    Clear(AccountFilter);
                    AnalysisViewCode := GSingleInstance.getAnalysisViewCode();
                    AccountFilter := GSingleInstance.GetValueforGLaccountCil3();
                    //Bc Upgrade YADAVM09 BCUP0-140<<
                    Lrep_CIL3Export.Setdefaults(AnalysisViewCode,
                                                ShowActualBudg,
                                                BudgetFilter,
                                                AccountFilter);//Bc Upgrade YADAVM09 BCUP0-140<<
                    Lrep_CIL3Export.RUNMODAL();
                    //<<HEI:EDD072:1:1
                end;
            }
        }
    }
    var
        GSingleInstance: codeunit "Levy Preview Custom RTR";//Bc upgrade YADAVM09<<

    //Unsupported feature: PropertyModification on "Text000(Variable 1080)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Period;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Period;FRA=Période;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1082)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You have not yet defined an analysis view.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You have not yet defined an analysis view.;FRA=Vous n'avez pas encore défini de vue analytique.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Unsupported Account Source %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Unsupported Account Source %1.;FRA=Source du compte %1 non pris en charge.;
    //Variable type has not been exported.

    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

