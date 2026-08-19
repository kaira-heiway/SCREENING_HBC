pageextension 51046 FAPostingGroupsExtCBN extends "FA Posting Groups"
{
    // HEI.01 FDD RTRGAP071 24.04.2018 IBM POSTOI01
    // Added following fields
    //  # 50003 Accum. Dep. Account Offset Code20
    //  # 50004 Dep. Expense Account Offset Code20
    //  # 50005 Acqi.Cost Acc. Disposal offset Code20
    //  # 50006 Gains Acc. on disposal Offset Code20
    //  # 50007 Sales bal.Acc. on disp. offset Code20
    //  # 50008 Accu.Dep. on Dis. acc offset Code20
    //  # 50009 Losses Acc. on Disp. Offset Code20
    // HEI.02 FDD CHG2003709 IBM ISYED01 03.18.2019
    //   #New field  to add in FA Posting group table “Description”
    // HEI.03 FDD-HT584 IBM NASTAA02 26.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Added Fields: "Derogatory Account", "Derogatory Acc. (Decrease)", "Derog. Bal. Acc. (Decrease)", "Derogatory Expense Account", "Allocated Derogatory %"
    // HEI.04 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in OnOpenPage()
    //   # Changed "Derogatory Account", "Derogatory Acc. (Decrease)", "Derog. Bal. Acc. (Decrease)", "Derogatory Expense Account", "Allocated Derogatory %"
    //     properties: Visible and Enabled
    // version NAVW110.0,HEI.01

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a fixed asset posting group code.', FRA = 'Spécifie un code groupe comptabilisation immobilisation.';
        }
        modify("Acquisition Cost Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post acquisition cost for fixed assets to in this posting group.', FRA = 'Spécifie le numéro du compte général dans lequel valider le coût d''acquisition pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Accum. Depreciation Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post accumulated depreciation to when you post depreciation for fixed assets.', FRA = 'Spécifie le numéro du compte général dans lequel valider l''amortissement cumulé lorsque vous validez des amortissements pour les immobilisations.';
        }
        modify("Write-Down Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post any write-downs for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider toutes les dépréciations pour les immobilisations de ce groupe comptabilisation.';
        }
        modify("Appreciation Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post appreciation transactions for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les transactions de réévaluation pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Custom 1 Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post Custom-1 transactions for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les transactions Param. 1 pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Custom 2 Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post Custom-2 transactions for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les transactions Param. 2 pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Acq. Cost Acc. on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post acquisition cost to when you dispose of fixed assets in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider le coût d''acquisition lorsque vous cédez des immobilisations de ce groupe comptabilisation.';
        }
        modify("Accum. Depr. Acc. on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post accumulated depreciation to when you dispose of fixed assets in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider l''amortissement cumulé lorsque vous cédez des immobilisations de ce groupe comptabilisation.';
        }
        modify("Write-Down Acc. on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post write-downs of fixed assets to when you dispose of fixed assets in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les dépréciations lorsque vous cédez des immobilisations de ce groupe comptabilisation.';
        }
        modify("Appreciation Acc. on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post appreciation to when you dispose of fixed assets in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les réévaluations lorsque vous cédez des immobilisations de ce groupe comptabilisation.';
        }
        modify("Custom 1 Account on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post Custom-1 transactions to when you dispose of fixed assets in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les transactions Param. 1 lorsque vous cédez des immobilisations de ce groupe comptabilisation.';
        }
        modify("Custom 2 Account on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post Custom-2 transactions to when you dispose of fixed assets in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les transactions Param. 2 lorsque vous cédez des immobilisations de ce groupe comptabilisation.';
        }
        modify("Gains Acc. on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post any gains to when you dispose of fixed assets in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les gains lorsque vous cédez des immobilisations de ce groupe comptabilisation.';
        }
        modify("Losses Acc. on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post any losses to when you dispose of fixed assets in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les pertes lorsque vous cédez des immobilisations de ce groupe comptabilisation.';
        }
        modify("Book Val. Acc. on Disp. (Gain)")
        {
            ToolTipML = ENU = 'Specifies the G/L account number you want the program to post assets'' book value to when you dispose of fixed assets at a gain on book value.', FRA = 'Spécifie le numéro du compte général dans lequel vous souhaitez que le programme valide la valeur comptable des éléments actifs lorsque vous cédez des immobilisations à un gain sur la valeur comptable.';
        }
        modify("Book Val. Acc. on Disp. (Loss)")
        {
            ToolTipML = ENU = 'Specifies the G/L account number to which to post assets'' book value, when you dispose of fixed assets at a loss on book value.', FRA = 'Spécifie le numéro de compte général dans lequel valider la valeur comptable des éléments actifs, lorsque vous cédez des immobilisations à une perte sur la valeur comptable.';
        }
        modify("Sales Acc. on Disp. (Gain)")
        {
            ToolTipML = ENU = 'Specifies the G/L account number you want to post sales to when you dispose of fixed assets at a gain on book value.', FRA = 'Spécifie le numéro de compte général dans lequel valider les ventes lorsque vous cédez des immobilisations à un gain sur la valeur comptable.';
        }
        modify("Sales Acc. on Disp. (Loss)")
        {
            ToolTipML = ENU = 'Specifies the G/L account number to which you want to post sales, when you dispose of fixed assets at a loss on book value.', FRA = 'Spécifie le numéro de compte général dans lequel valider les ventes, lorsque vous cédez des immobilisations à une perte sur la valeur comptable.';
        }
        modify("Write-Down Bal. Acc. on Disp.")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post write-downs of fixed assets to when you dispose of fixed assets.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les dépréciations lorsque vous cédez des immobilisations.';
        }
        modify("Apprec. Bal. Acc. on Disp.")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post appreciation transactions of fixed assets to when you dispose of fixed assets.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les transactions de réévaluation des immobilisations lorsque vous cédez des immobilisations.';
        }
        modify("Custom 1 Bal. Acc. on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post custom-1 transactions of fixed assets to when you dispose of fixed assets.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les transactions Param. 1 des immobilisations lorsque vous cédez des immobilisations.';
        }
        modify("Custom 2 Bal. Acc. on Disposal")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post custom-2 transactions of fixed assets to when you dispose of fixed assets.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les transactions Param. 2 des immobilisations lorsque vous cédez des immobilisations.';
        }
        modify("Maintenance Expense Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post maintenance expenses for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les coûts de maintenance pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Maintenance Bal. Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post maintenance expenses for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les coûts de maintenance pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Acquisition Cost Bal. Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post acquisition cost for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider le coût d''acquisition pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Depreciation Expense Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post depreciation expense for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les frais d''amortissement pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Write-Down Expense Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post write-downs for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les dépréciations pour les immobilisations de ce groupe comptabilisation.';
        }
        modify("Appreciation Bal. Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post appreciation for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les réévaluations pour les immobilisations de ce groupe comptabilisation.';
        }
        modify("Custom 1 Expense Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post custom-1 transactions for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les transactions Param. 1 pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Custom 2 Expense Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post custom-2 transactions for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les transactions Param. 2 pour les immobilisations dans ce groupe comptabilisation.';
        }
        modify("Sales Bal. Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account to post sales when you dispose of fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les ventes lorsque vous cédez des immobilisations dans ce groupe comptabilisation.';
        }
        modify("Allocated Acquisition Cost %")
        {
            ToolTipML = ENU = 'Specifies the total percentage of acquisition cost that can be allocated when acquisition cost is posted.', FRA = 'Spécifie le pourcentage total des coûts d''acquisition qui peut être ventilé lorsque le coût d''acquisition est validé.';
        }
        modify("Allocated Depreciation %")
        {
            ToolTipML = ENU = 'Specifies the total percentage of depreciation that can be allocated when depreciation is posted.', FRA = 'Spécifie le pourcentage total d''amortissement qui peut être ventilé lorsque l''amortissement est validé.';
        }
        modify("Allocated Write-Down %")
        {
            ToolTipML = ENU = 'Specifies the total percentage for write-down transactions that can be allocated when write-down transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions de dépréciation qui peut être ventilé lorsque les transactions de dépréciation sont validées.';
        }
        modify("Allocated Appreciation %")
        {
            ToolTipML = ENU = 'Specifies the total percentage for appreciation transactions that can be allocated when appreciation transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions de réévaluation qui peut être ventilé lorsque les transactions de réévaluation sont validées.';
        }
        modify("Allocated Custom 1 %")
        {
            ToolTipML = ENU = 'Specifies the total percentage for custom-1 transactions that can be allocated when custom-1 transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions Param. 1 qui peut être ventilé lorsque les transactions Param. 1 sont validées.';
        }
        modify("Allocated Custom 2 %")
        {
            ToolTipML = ENU = 'Specifies the total percentage for custom-2 transactions that can be allocated when custom-2 transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions Param. 2 qui peut être ventilé lorsque les transactions Param. 2 sont validées.';
        }
        modify("Allocated Sales Price %")
        {
            ToolTipML = ENU = 'Specifies the total percentage of sales price that can be allocated when sales are posted.', FRA = 'Spécifie le pourcentage total du prix de vente qui peut être ventilé lorsque les ventes sont validées.';
        }
        modify("Allocated Maintenance %")
        {
            ToolTipML = ENU = 'Specifies the total percentage for maintenance transactions that can be allocated when maintenance transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions de maintenance qui peut être ventilé lorsque les transactions de maintenance sont validées.';
        }
        addafter("Code")
        {
            field(Description; Rec."Description FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field.';
            }
        }
        // BC Upgrade NANDIS03 - Blocked as these are FR localization fields >>
        // addafter("Custom 2 Account")
        // {
        //     field("Derogatory Account"; Rec."Derogatory Account")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        //     field("Derogatory Acc. (Decrease)"; Rec."Derogatory Acc. (Decrease)")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        //     field("Derogatory Expense Account"; Rec."Derogatory Expense Account")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        //     field("Derog. Bal. Acc. (Decrease)"; Rec."Derog. Bal. Acc. (Decrease)")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        // }
        // BC Upgrade NANDIS03 - Blocked as these are FR localization fields <<
        addafter("Allocated Maintenance %")
        {
            // BC Upgrade NANDIS03 - Blocked as these are FR localization fields >>
            // field("Allocated Derogatory %"; Rec."Allocated Derogatory %")
            // {
            //     Enabled = FRLocAction;
            //     Visible = FRLocAction;
            // }
            // BC Upgrade NANDIS03 - Blocked as these are FR localization fields <<
            field("Accum. Dep. Account Offset"; Rec."Accum. Dep. Account Offset FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Accum. Depr Acc. Offset field.';

            }
            field("Dep. Expense Account Offset"; Rec."Dep. Expense Acc Offset FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Depreciation Exp. Acc. Offset field.';

            }
            field("Acqi.Cost Acc. Disposal Offset"; Rec."Acqi.CostAcc.Dsposl Offset FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Acq. Cost On Disposal Offset field.';

            }
            field("Gains Acc. on Disposal Offset"; Rec."GainAcc.on Disposal Offset FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Gains Acc. on Disposal Offset field.';

            }
            field("Sales Bal.Acc. on Disp. Offset"; Rec."SaleBal.Acc.on Disp.Offset FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Sales Bal.Acc. on Disp. Offset field.';

            }
            field("Accum.Dep. on Disp. Acc Offset"; Rec."Accum.Dep.onDisp.AccOffset FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Accum.Depr.Acc.Disposal Offset field.';

            }
            field("Losses Acc. on Disp. Offset"; Rec."Losses Acc. on Disp. Off FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Losses Acc. on Disposal Offset field.';

            }
        }
    }
    actions
    {
        modify("P&osting Gr.")
        {
            CaptionML = ENU = 'P&osting Gr.', FRA = '&Gpe cpta';
        }
        modify(Allocations)
        {
            CaptionML = ENU = 'Allocations', FRA = 'Ventilations';
        }
        //BC Upgrade KAPOOV01>>
        // modify(Acquisition)
        // {
        //     CaptionML = ENU = '&Acquisition', FRA = '&Acquisition';
        //     ToolTipML = ENU = 'View or edit the FA allocation that apply to acquisitions.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux acquisitions.';

        //     //Unsupported feature: Change RunPageLink on "Acquisition(Action 73)". Please convert manually.

        // }
        addfirst(Allocations)
        {
            action(Acquisition)
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = '&Acquisition', FRA = '&Acquisition';
                ToolTipML = ENU = 'View or edit the FA allocation that apply to acquisitions.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux acquisitions.';
                Image = Allocate;
                Promoted = False;
                Visible = true;
                RunObject = Page "FA Allocations";
                RunPageLink = Code = FIELD(Code), "Allocation Type" = CONST(Acquisition);

            }
        }
        //BC Upgrade KAPOOV01<<

        modify(Depreciation)
        {
            CaptionML = ENU = '&Depreciation', FRA = 'A&mortissement';
            ToolTipML = ENU = 'View or edit the FA allocation that apply to depreciations.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux amortissements.';

            //Unsupported feature: Change RunPageLink on "Depreciation(Action 79)". Please convert manually.

        }
        modify(WriteDown)
        {
            CaptionML = ENU = '&Write-Down', FRA = '&Dépréciation';
            ToolTipML = ENU = 'View or edit the FA allocation that apply to write-downs.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux dépréciations.';

            //Unsupported feature: Change RunPageLink on "WriteDown(Action 80)". Please convert manually.

        }
        modify(Appreciation)
        {
            CaptionML = ENU = 'Appr&eciation', FRA = '&Réévaluation';
            ToolTipML = ENU = 'View or edit the FA allocations that apply to appreciations.', FRA = 'Affichez ou modifiez les affectations d''immobilisation qui s''appliquent aux réévaluations.';

            //Unsupported feature: Change RunPageLink on "Appreciation(Action 74)". Please convert manually.

        }
        modify(Custom1)
        {
            CaptionML = ENU = '&Custom 1', FRA = '&Param. 1';
            ToolTipML = ENU = 'View or edit the FA allocation that apply to custom values.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux valeurs personnalisées.';

            //Unsupported feature: Change RunPageLink on "Custom1(Action 81)". Please convert manually.

        }
        modify(Custom2)
        {
            CaptionML = ENU = 'C&ustom 2', FRA = 'P&aram. 2';
            ToolTipML = ENU = 'View or edit the FA allocation that apply to custom values.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux valeurs personnalisées.';

            //Unsupported feature: Change RunPageLink on "Custom2(Action 82)". Please convert manually.

        }
        //BC Upgrade KAPOOV01>>
        // modify(Disposal)
        // {
        //     CaptionML = ENU = 'Disp&osal', FRA = 'Cessi&on';
        //     ToolTipML = ENU = 'View or edit the FA allocation that apply to disposals.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux cessions.';

        //     //Unsupported feature: Change RunPageLink on "Disposal(Action 83)". Please convert manually.

        // }
        addafter(Custom2)
        {
            action(Disposal)
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Disp&osal', FRA = 'Cessi&on';
                ToolTipML = ENU = 'View or edit the FA allocation that apply to disposals.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux cessions.';
                Image = Allocate;
                Promoted = False;
                Visible = true;
                RunObject = Page "FA Allocations";
                RunPageLink = Code = FIELD(Code), "Allocation Type" = CONST(Disposal);

            }
        }
        //BC Upgrade KAPOOV01<<

        modify(Maintenance)
        {
            CaptionML = ENU = 'Maintenance', FRA = 'Maintenance';
            ToolTipML = ENU = 'View or edit the FA allocations that apply to maintenance.', FRA = 'Affichez ou modifiez les affectations d''immobilisation qui s''appliquent à la maintenance.';

            //Unsupported feature: Change RunPageLink on "Maintenance(Action 96)". Please convert manually.

        }
        modify(Gain)
        {
            CaptionML = ENU = 'Gain', FRA = 'Gain';
            ToolTipML = ENU = 'View or edit the FA allocations that apply to gains.', FRA = 'Affichez ou modifiez les affectations d''immobilisation qui s''appliquent aux gains.';

            //Unsupported feature: Change RunPageLink on "Gain(Action 97)". Please convert manually.

        }
        modify(Loss)
        {
            CaptionML = ENU = 'Loss', FRA = 'Perte';
            ToolTipML = ENU = 'View or edit the FA allocations that apply to losses.', FRA = 'Affichez ou modifiez les affectations d''immobilisation qui s''appliquent aux pertes.';

            //Unsupported feature: Change RunPageLink on "Loss(Action 98)". Please convert manually.

        }
        //BC Upgrade KAPOOV01>>
        // modify(BookValueGain)
        // {
        //     CaptionML = ENU = 'Book Value (Gain)', FRA = 'Valeur comptable (gain)';
        //     ToolTipML = ENU = 'View or edit the FA allocations that apply to book value gains.', FRA = 'Affichez ou modifiez les affectations d''immobilisations qui s''appliquent aux gains sur les valeurs comptables.';

        //     //Unsupported feature: Change RunPageLink on "BookValueGain(Action 99)". Please convert manually.

        // }
        // modify(BookValueLoss)
        // {
        //     CaptionML = ENU = 'Book &Value (Loss)', FRA = 'Valeur &comptable (perte)';
        //     ToolTipML = ENU = 'View or edit the FA allocations that apply to book value losses.', FRA = 'Affichez ou modifiez les affectations d''immobilisations qui s''appliquent aux pertes sur les valeurs comptables.';

        //     //Unsupported feature: Change RunPageLink on "BookValueLoss(Action 100)". Please convert manually.

        // }
        addafter(Loss)
        {
            action(BookValueGain)
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Book Value (Gain)', FRA = 'Valeur comptable (gain)';
                ToolTipML = ENU = 'View or edit the FA allocations that apply to book value gains.', FRA = 'Affichez ou modifiez les affectations d''immobilisations qui s''appliquent aux gains sur les valeurs comptables.';
                Image = Allocate;
                Promoted = False;
                Visible = true;
                RunObject = Page "FA Allocations";
                RunPageLink = Code = FIELD(Code), "Allocation Type" = CONST("Book Value (Gain)");

            }

            action(BookValueLoss)
            {
                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Book &Value (Loss)', FRA = 'Valeur &comptable (perte)';
                ToolTipML = ENU = 'View or edit the FA allocations that apply to book value losses.', FRA = 'Affichez ou modifiez les affectations d''immobilisations qui s''appliquent aux pertes sur les valeurs comptables.';
                Image = Allocate;
                Promoted = False;
                Visible = true;
                RunObject = Page "FA Allocations";
                RunPageLink = Code = FIELD(Code), "Allocation Type" = CONST("Book Value (Loss)");

            }
        }

        //BC Upgrade KAPOOV01<<

    }

    var
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //HEI.04>>
    CompanyInfo.GET;
    FRLocAction := false;
    if CompanyInfo."Enable French Localization" then
      FRLocAction := true;
    //HEI.04<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    //BC Upgrade KAPOOV01>>

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.04>>
        CompanyInfo.GET();
        FRLocAction := FALSE;
        // IF CompanyInfo."Enable French Localization" THEN
        //     FRLocAction := TRUE;
        //HEI.04<<
    end;
    //BC Upgrade KAPOOV01<<

}

