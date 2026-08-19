pageextension 51045 FAPostingGroupCardExtCBN extends "FA Posting Group Card"
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
    //   #New field  to add in FA Posting group  “Description”
    // HEI.03 FDD-HT584 IBM NASTAA02 26.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Added Fields: "Derogatory Account", "Derogatory Acc. (Decrease)", "Derog. Bal. Acc. (Decrease)", "Derogatory Expense Account", "Allocated Derogatory %"
    // HEI.04 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in OnOpenPage()
    //   # Changed "Derogatory Account", "Derogatory Acc. (Decrease)", "Derog. Bal. Acc. (Decrease)", "Derogatory Expense Account", "Allocated Derogatory %"
    //     properties: Visible and Enabled
    // version NAVW110.0,HEI.01

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
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
        modify("Maintenance Expense Account")
        {
            ToolTipML = ENU = 'Specifies the general ledger account number to post maintenance expenses for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte général dans lequel valider les coûts de maintenance pour les immobilisations dans ce groupe comptabilisation.';
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
        modify("Balancing Account")
        {
            CaptionML = ENU = 'Balancing Account', FRA = 'Compte contrepartie';
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
        modify("Maintenance Bal. Acc.")
        {
            ToolTipML = ENU = 'Specifies the general ledger balancing account number to post maintenance expenses for fixed assets to in this posting group.', FRA = 'Spécifie le numéro de compte de contrepartie général dans lequel valider les coûts de maintenance pour les immobilisations dans ce groupe comptabilisation.';
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
        modify("Gross Disposal")
        {
            CaptionML = ENU = 'Gross Disposal', FRA = 'Cession brute';
        }
        modify("Sales Acc. on Disposal")
        {
            CaptionML = ENU = 'Sales Acc. on Disposal', FRA = 'Compte produits des cessions d''élts d''actif';
        }
        modify("Sales Acc. on Disp. (Gain)")
        {
            CaptionML = ENU = 'Gain Account', FRA = 'Compte gains';
            ToolTipML = ENU = 'Specifies the G/L account number you want to post sales to when you dispose of fixed assets at a gain on book value.', FRA = 'Spécifie le numéro de compte général dans lequel valider les ventes lorsque vous cédez des immobilisations à un gain sur la valeur comptable.';
        }
        modify("Sales Acc. on Disp. (Loss)")
        {
            CaptionML = ENU = 'Loss Account', FRA = 'Compte pertes';
            ToolTipML = ENU = 'Specifies the G/L account number to which you want to post sales, when you dispose of fixed assets at a loss on book value.', FRA = 'Spécifie le numéro de compte général dans lequel valider les ventes, lorsque vous cédez des immobilisations à une perte sur la valeur comptable.';
        }
        modify("Book Value Acc. on Disposal")
        {
            CaptionML = ENU = 'Book Value Acc. on Disposal', FRA = 'Compte valeurs des élts d''actif cédés';
        }
        modify("Book Val. Acc. on Disp. (Gain)")
        {
            CaptionML = ENU = 'Gain Account', FRA = 'Compte gains';
            ToolTipML = ENU = 'Specifies the G/L account number you want the program to post assets'' book value to when you dispose of fixed assets at a gain on book value.', FRA = 'Spécifie le numéro du compte général dans lequel vous souhaitez que le programme valide la valeur comptable des éléments actifs lorsque vous cédez des immobilisations à un gain sur la valeur comptable.';
        }
        modify("Book Val. Acc. on Disp. (Loss)")
        {
            CaptionML = ENU = 'Loss Account', FRA = 'Compte pertes';
            ToolTipML = ENU = 'Specifies the G/L account number to which to post assets'' book value, when you dispose of fixed assets at a loss on book value.', FRA = 'Spécifie le numéro de compte général dans lequel valider la valeur comptable des éléments actifs, lorsque vous cédez des immobilisations à une perte sur la valeur comptable.';
        }
        modify(Allocation)
        {
            CaptionML = ENU = 'Allocation', FRA = 'Ventilation';
        }
        modify("Allocated Acquisition Cost %")
        {
            CaptionML = ENU = 'Acquisition Cost', FRA = 'Coût acquisition';
            ToolTipML = ENU = 'Specifies the total percentage of acquisition cost that can be allocated when acquisition cost is posted.', FRA = 'Spécifie le pourcentage total des coûts d''acquisition qui peut être ventilé lorsque le coût d''acquisition est validé.';
        }
        modify("Allocated Depreciation %")
        {
            CaptionML = ENU = 'Depreciation', FRA = 'Amortissement';
            ToolTipML = ENU = 'Specifies the total percentage of depreciation that can be allocated when depreciation is posted.', FRA = 'Spécifie le pourcentage total d''amortissement qui peut être ventilé lorsque l''amortissement est validé.';
        }
        modify("Allocated Write-Down %")
        {
            CaptionML = ENU = 'Write-Down', FRA = 'Dépréciation';
            ToolTipML = ENU = 'Specifies the total percentage for write-down transactions that can be allocated when write-down transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions de dépréciation qui peut être ventilé lorsque les transactions de dépréciation sont validées.';
        }
        modify("Allocated Appreciation %")
        {
            CaptionML = ENU = 'Appreciation', FRA = 'Réévaluation';
            ToolTipML = ENU = 'Specifies the total percentage for appreciation transactions that can be allocated when appreciation transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions de réévaluation qui peut être ventilé lorsque les transactions de réévaluation sont validées.';
        }
        modify("Allocated Custom 1 %")
        {
            CaptionML = ENU = 'Custom 1', FRA = 'Param. 1';
            ToolTipML = ENU = 'Specifies the total percentage for custom-1 transactions that can be allocated when custom-1 transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions Param. 1 qui peut être ventilé lorsque les transactions Param. 1 sont validées.';
        }
        modify("Allocated Custom 2 %")
        {
            CaptionML = ENU = 'Custom 2', FRA = 'Param. 2';
            ToolTipML = ENU = 'Specifies the total percentage for custom-2 transactions that can be allocated when custom-2 transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions Param. 2 qui peut être ventilé lorsque les transactions Param. 2 sont validées.';
        }
        modify("Allocated Maintenance %")
        {
            CaptionML = ENU = 'Maintenance', FRA = 'Maintenance';
            ToolTipML = ENU = 'Specifies the total percentage for maintenance transactions that can be allocated when maintenance transactions are posted.', FRA = 'Spécifie le pourcentage total de transactions de maintenance qui peut être ventilé lorsque les transactions de maintenance sont validées.';
        }
        modify("Allocated Gain %")
        {
            CaptionML = ENU = 'Gain', FRA = 'Gain';
            ToolTipML = ENU = 'Specifies the total percentage of gains on fixed assets that can be allocated, when gains are involved in the disposal of fixed assets.', FRA = 'Spécifie le pourcentage total de gains sur immobilisations qui peut être ventilé, lorsque des gains sont impliqués dans la cession des immobilisations.';
        }
        modify("Allocated Loss %")
        {
            CaptionML = ENU = 'Loss', FRA = 'Perte';
            ToolTipML = ENU = 'Specifies the total percentage for losses on fixed assets that can be allocated when losses are involved in the disposal of fixed assets.', FRA = 'Spécifie le pourcentage total de pertes sur immobilisations qui peut être ventilé, lorsque des pertes sont impliquées dans la cession des immobilisations.';
        }
        modify("Allocated Book Value % (Gain)")
        {
            CaptionML = ENU = 'Book Value (Gain)', FRA = 'Valeur comptable (gain)';
            ToolTipML = ENU = 'Specifies the sum that applies to book value gains.', FRA = 'Spécifie la somme qui s''applique aux gains sur les valeurs comptables.';
        }
        modify("Allocated Book Value % (Loss)")
        {
            CaptionML = ENU = 'Book Value (Loss)', FRA = 'Valeur comptable (perte)';
            ToolTipML = ENU = 'Specifies the sum that applies to book value gains.', FRA = 'Spécifie la somme qui s''applique aux gains sur les valeurs comptables.';
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
        // addafter("Maintenance Expense Account")
        // {
        //     field("Derogatory Account"; Rec."Derogatory Account")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        // }
        // addafter("Losses Acc. on Disposal")
        // {
        //     field("Derogatory Acc. (Decrease)"; Rec."Derogatory Acc. (Decrease)")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        // }
        // addafter("Maintenance Bal. Acc.")
        // {
        //     field("Derogatory Expense Account"; Rec."Derogatory Expense Account")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        // }
        // addafter("Custom 2 Bal. Acc. on Disposal")
        // {
        //     field("Derog. Bal. Acc. (Decrease)"; Rec."Derog. Bal. Acc. (Decrease)")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        // }
        // addafter("Allocated Maintenance %")
        // {
        //     field("Allocated Derogatory %"; Rec."Allocated Derogatory %")
        //     {
        //         Enabled = FRLocAction;
        //         Visible = FRLocAction;
        //     }
        // }
        // BC Upgrade NANDIS03 - Blocked as these are FR localization fields <<
        addafter(Allocation)
        {
            group(Offset)
            {
                Caption = 'Offset';
                field("Dep. Expense Account Offset"; Rec."Dep. Expense Acc Offset FND")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Depreciation Exp. Acc. Offset field.';
                }
                field("Accum. Dep. Account Offset"; Rec."Accum. Dep. Account Offset FND")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Accum. Depr Acc. Offset field.';

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
        //     CaptionML = ENU = 'Acquisition', FRA = 'Acquisition';
        //     ToolTipML = ENU = 'Specifies the total percentage of acquisition cost that can be allocated when acquisition cost is posted.', FRA = 'Spécifie le pourcentage total des coûts d''acquisition qui peut être ventilé lorsque le coût d''acquisition est validé.';

        //     //Unsupported feature: Change RunPageLink on "Acquisition(Action 65)". Please convert manually.

        // }
        addfirst(Allocations)
        {
            action(Acquisition)
            {

                ApplicationArea = FixedAssets;
                CaptionML = ENU = 'Acquisition', FRA = 'Acquisition';
                ToolTipML = ENU = 'Specifies the total percentage of acquisition cost that can be allocated when acquisition cost is posted.';
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
            CaptionML = ENU = 'Depreciation', FRA = 'Amortissement';
            ToolTipML = ENU = 'Specifies whether depreciation entries posted to this depreciation book are posted both to the general ledger and the FA ledger.', FRA = 'Indique si les écritures d''amortissement validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';

            //Unsupported feature: Change RunPageLink on "Depreciation(Action 66)". Please convert manually.

        }
        modify(WriteDown)
        {
            CaptionML = ENU = 'Write-Down', FRA = 'Dépréciation';
            ToolTipML = ENU = 'Specifies whether write-down entries posted to this depreciation book should be posted to the general ledger and the FA ledger.', FRA = 'Indique si les écritures dépréciation validées sur cette loi d''amortissement doivent être validées en comptabilité et sur les écritures comptables immobilisation.';

            //Unsupported feature: Change RunPageLink on "WriteDown(Action 85)". Please convert manually.

        }
        modify(Appreciation)
        {
            CaptionML = ENU = 'Appr&eciation', FRA = '&Réévaluation';
            ToolTipML = ENU = 'View or edit the FA allocations that apply to appreciations.', FRA = 'Affichez ou modifiez les affectations d''immobilisation qui s''appliquent aux réévaluations.';

            //Unsupported feature: Change RunPageLink on "Appreciation(Action 86)". Please convert manually.

        }
        modify(Custom1)
        {
            CaptionML = ENU = 'Custom 1', FRA = 'Param. 1';
            ToolTipML = ENU = 'Specifies whether custom 1 entries posted to this depreciation book are posted to the general ledger and the FA ledger.', FRA = 'Indique si les écritures Param. 1 validées sur cette loi d''amortissement sont validées en comptabilité et sur les écritures comptables immobilisation.';

            //Unsupported feature: Change RunPageLink on "Custom1(Action 87)". Please convert manually.

        }
        modify(Custom2)
        {
            CaptionML = ENU = 'C&ustom 2', FRA = 'P&aram. 2';
            ToolTipML = ENU = 'View or edit the FA allocation that apply to custom values.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux valeurs personnalisées.';

            //Unsupported feature: Change RunPageLink on "Custom2(Action 88)". Please convert manually.

        }
        //BC Upgrade KAPOOV01>>
        //         modify(Disposal)
        // {
        //     CaptionML = ENU = 'Disp&osal', FRA = 'Cessi&on';
        //     ToolTipML = ENU = 'View or edit the FA allocation that apply to disposals.', FRA = 'Affichez ou modifiez l''affectation d''immobilisations qui s''applique aux cessions.';

        //     //Unsupported feature: Change RunPageLink on "Disposal(Action 89)". Please convert manually.

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

            //Unsupported feature: Change RunPageLink on "Maintenance(Action 90)". Please convert manually.

        }
        modify(Gain)
        {
            CaptionML = ENU = 'Gain', FRA = 'Gain';
            ToolTipML = ENU = 'View or edit the FA allocations that apply to gains.', FRA = 'Affichez ou modifiez les affectations d''immobilisation qui s''appliquent aux gains.';

            //Unsupported feature: Change RunPageLink on "Gain(Action 91)". Please convert manually.

        }
        modify(Loss)
        {
            CaptionML = ENU = 'Loss', FRA = 'Perte';
            ToolTipML = ENU = 'View or edit the FA allocations that apply to losses.', FRA = 'Affichez ou modifiez les affectations d''immobilisation qui s''appliquent aux pertes.';

            //Unsupported feature: Change RunPageLink on "Loss(Action 92)". Please convert manually.

        }
        //BC Upgrade KAPOOV01>>

        // modify(BookValueGain)
        // {
        //     CaptionML = ENU = 'Book Value (Gain)', FRA = 'Valeur comptable (gain)';
        //     ToolTipML = ENU = 'View or edit the FA allocations that apply to book value gains.', FRA = 'Affichez ou modifiez les affectations d''immobilisations qui s''appliquent aux gains sur les valeurs comptables.';

        //     //Unsupported feature: Change RunPageLink on "BookValueGain(Action 93)". Please convert manually.

        // }
        // modify(BookValueLoss)
        // {
        //     CaptionML = ENU = 'Book &Value (Loss)', FRA = 'Valeur &comptable (perte)';
        //     ToolTipML = ENU = 'View or edit the FA allocations that apply to book value losses.', FRA = 'Affichez ou modifiez les affectations d''immobilisations qui s''appliquent aux pertes sur les valeurs comptables.';

        //     //Unsupported feature: Change RunPageLink on "BookValueLoss(Action 67)". Please convert manually.

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


    //Unsupported feature: PropertyModification on "Text19064976(Variable 19028229)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text19064976 : ENU=Allocated %;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text19064976 : ENU=Allocated %;FRA=% ventilé;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text19080001(Variable 19069732)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text19080001 : ENU=Allocated %;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text19080001 : ENU=Allocated %;FRA=% ventilé;
    //Variable type has not been exported.

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

}

