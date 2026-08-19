pageextension 51040 FixedAssetStatisticsExtCBN extends "Fixed Asset Statistics"
{
    // HEI.01 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # New Fields added: "Derogatory" and "Last Derogatory Date"
    // HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in OnOpenPage()
    //   # Changed "Derogatory" and "Last Derogatory Date" properties: Visible and Enabled
    // version NAVW110.0
    //Bc Upgrade YADAVM09 Drink it field blocked- "Derogatory", "Last Derogatory Date".
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Acquisition Date")
        {
            CaptionML = ENU = 'Acquisition Date', FRA = 'Date acquisition';
            ToolTipML = ENU = 'Specifies the FA posting date of the first posted acquisition cost.', FRA = 'Spécifie la date comptabilisation immobilisation du premier coût d''acquisition validé.';
        }
        modify("G/L Acquisition Date")
        {
            CaptionML = ENU = 'G/L Acquisition Date', FRA = 'Date acquisition compta.';
            ToolTipML = ENU = 'Specifies the G/L posting date of the first posted acquisition cost.', FRA = 'Spécifie la date comptabilisation comptable du premier coût d''acquisition validé.';
        }
        modify(Disposed)
        {
            CaptionML = ENU = 'Disposed Of', FRA = 'Cédé';
            ToolTipML = ENU = 'Specifies whether the fixed asset has been disposed of.', FRA = 'Spécifie si l''immobilisation a été cédée.';
        }
        modify("Disposal Date")
        {
            ToolTipML = ENU = 'Specifies the FA posting date of the first posted disposal amount.', FRA = 'Spécifie la date comptabilisation immobilisation du premier montant cession validé.';
        }
        modify("Proceeds on Disposal")
        {
            ToolTipML = ENU = 'Specifies the total proceeds on disposal for the fixed asset as a FlowField.', FRA = 'Spécifie les gains sur cession pour l''immobilisation en tant que FlowField.';
        }
        modify("Gain/Loss")
        {
            ToolTipML = ENU = 'Specifies the total gain (credit) or loss (debit) for the fixed asset as a FlowField.', FRA = 'Spécifie les gains (crédit) ou les pertes (débit) pour l''immobilisation en tant que FlowField.';
        }
        modify(DisposalValue)
        {
            CaptionML = ENU = 'Book Value after Disposal', FRA = 'Valeur comptable après cession';
            ToolTipML = ENU = 'Specifies the total LCY amount of entries posted with the Book Value on Disposal posting type. Entries of this kind are created when you post disposal of a fixed asset to a depreciation book where the Gross method has been selected in the Disposal Calculation Method field.', FRA = 'Spécifie le montant total en devise société des écritures validées avec le type validation Valeur comptable cession. Les écritures de ce type sont créées lorsque vous validez la cession d''une immobilisation sur une loi d''amortissement dans laquelle la méthode Brut a été sélectionnée dans le champ Méthode calcul cession.';
        }
        modify("Last FA Posting Date")
        {
            CaptionML = ENU = 'Last FA Posting Date', FRA = 'Dernière date compta. immo.';
        }
        modify("Last Acquisition Cost Date")
        {
            CaptionML = ENU = 'Acquisition Cost', FRA = 'Coût acquisition';
            ToolTipML = ENU = 'Specifies the total percentage of acquisition cost that can be allocated when acquisition cost is posted.', FRA = 'Spécifie le pourcentage total des coûts d''acquisition qui peut être ventilé lorsque le coût d''acquisition est validé.';
        }
        modify("Last Depreciation Date")
        {
            CaptionML = ENU = 'Depreciation', FRA = 'Amortissement';
            ToolTipML = ENU = 'Specifies the FA posting date of the last posted depreciation.', FRA = 'Spécifie la date comptabilisation immobilisation du dernier amortissement validé.';
        }
        modify("Last Write-Down Date")
        {
            CaptionML = ENU = 'Write-Down', FRA = 'Dépréciation';
            ToolTipML = ENU = 'Specifies the FA posting date of the last posted write-down.', FRA = 'Spécifie la date comptabilisation immobilisation de la dernière dépréciation validée.';
        }
        modify("Last Appreciation Date")
        {
            CaptionML = ENU = 'Appreciation', FRA = 'Réévaluation';
            ToolTipML = ENU = 'Specifies the sum that applies to appreciations.', FRA = 'Spécifie la somme qui s''applique aux réévaluations.';
        }
        modify("Last Custom 1 Date")
        {
            CaptionML = ENU = 'Custom 1', FRA = 'Param. 1';
            ToolTipML = ENU = 'Specifies the FA posting date of the last posted custom 1 entry.', FRA = 'Spécifie la date comptabilisation immobilisation de la dernière écriture Param. 1 validée.';
        }
        // modify("Book Value")
        // {
        //     CaptionML = ENU = 'Book Value', FRA = 'Valeur comptable';
        //     ToolTipML = ENU = 'Specifies the sum that applies to book values.', FRA = 'Spécifie la somme qui s''applique aux valeurs comptables.';
        // }//BC Upgrade KAPOOV01 this field is defined inside Fixed control in base page also for this field control visibilty is false in Navision.
        modify("Last Salvage Value Date")
        {
            CaptionML = ENU = 'Salvage Value', FRA = 'Valeur résiduelle';
            ToolTipML = ENU = 'Specifies if related salvage value entries are included in the batch job .', FRA = 'Indique si les écritures valeur résiduelle associées sont incluses dans le traitement par lots.';
        }
        // modify("Depreciable Basis")
        // {
        //     CaptionML = ENU = 'Depreciable Basis', FRA = 'Base amortissement';
        //     ToolTipML = ENU = 'Specifies the depreciable basis amount for the fixed asset. This is calculated based on the amounts in those FA ledger entries that are included in the depreciable basis.', FRA = 'Spécifie le montant de la base d''amortissement de l''immobilisation. Ce montant est calculé sur la base des montants des écritures comptables immobilisation incluses dans la base d''amortissement.';
        // }//BC Upgrade KAPOOV01 this field is defined inside Fixed control in base page also for this field control visibilty is false in Navision.
        modify("Last Custom 2 Date")
        {
            CaptionML = ENU = 'Custom 2', FRA = 'Param. 2';
            ToolTipML = ENU = 'Specifies the FA posting date of the last posted custom 2 entry.', FRA = 'Spécifie la date comptabilisation immobilisation de la dernière écriture Param. 2 validée.';
        }
        // modify(Maintenance)
        // {
        //     CaptionML = ENU = 'Maintenance', FRA = 'Maintenance';
        //     ToolTipML = ENU = 'Specifies the total maintenance cost for the fixed asset. This is calculated from the maintenance ledger entries.', FRA = 'Spécifie le coût total de maintenance de l''immobilisation. Ce coût est calculé à partir des écritures comptables maintenance.';
        // }//BC Upgrade KAPOOV01 this field is defined inside Fixed control in base page also for this field control visibilty is false in Navision.
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Acquisition Cost")
        {
            ToolTipML = ENU = 'Specifies the total acquisition cost for the fixed asset as a FlowField.', FRA = 'Spécifie le coût d''acquisition total de l''immobilisation en tant que FlowField.';
        }
        modify(Depreciation)
        {
            ToolTipML = ENU = 'Specifies the total depreciation for the fixed asset as a FlowField.', FRA = 'Spécifie l''amortissement total de l''immobilisation en tant que FlowField.';
        }
        modify("Write-Down")
        {
            ToolTipML = ENU = 'Specifies the total LCY amount of write-down entries for the fixed asset as a FlowField.', FRA = 'Spécifie le montant total des écritures dépréciation en devise société pour l''immobilisation en tant que FlowField.';
        }
        modify(Appreciation)
        {
            ToolTipML = ENU = 'Specifies the total appreciation for the fixed asset as a FlowField.', FRA = 'Spécifie le montant total des écritures réévaluation de l''immobilisation en tant que FlowField.';
        }
        modify("Custom 1")
        {
            ToolTipML = ENU = 'Specifies the total LCY amount for custom 1 entries for the fixed asset as a FlowField.', FRA = 'Spécifie le montant total des écritures Param. 1 en devise société pour l''immobilisation en tant que FlowField.';
        }
        modify("Book Value")
        {
            ToolTipML = ENU = 'Specifies the book value for the fixed asset as a FlowField.', FRA = 'Spécifie la valeur comptable de l''immobilisation en tant que FlowField.';
        }
        modify("Salvage Value")
        {
            ToolTipML = ENU = 'Specifies the salvage value for the fixed asset.', FRA = 'Spécifie la valeur résiduelle de l''immobilisation.';
        }
        modify("Depreciable Basis")
        {
            ToolTipML = ENU = 'Specifies the depreciable basis amount for the fixed asset as a FlowField.', FRA = 'Spécifie le montant de la base d''amortissement de l''immobilisation en tant que FlowField.';
        }
        modify("Custom 2")
        {
            ToolTipML = ENU = 'Specifies the total LCY amount for custom 2 entries for the fixed asset as a FlowField.', FRA = 'Spécifie le montant total des écritures Param. 2 en devise société pour l''immobilisation en tant que FlowField.';
        }
        modify(Maintenance)
        {
            ToolTipML = ENU = 'Specifies the total maintenance cost for the fixed asset as a FlowField.', FRA = 'Spécifie le coût total de maintenance de l''immobilisation en tant que FlowField.';
        }// //BC Upgrade KAPOOV01 changed name from Control43 to Maintenance.

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("Last Custom 1 Date")
        {
            field("Last Derogatory Date"; Rec."Last Derogatory Date")
            {
                Enabled = FRLocAction;
                Visible = FRLocAction;
            }
        }
        
        addafter("Custom 1")
        {
            field(Derogatory; Rec.Derogatory)
            {
                Enabled = FRLocAction;
                Visible = FRLocAction;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
    }


    //Unsupported feature: PropertyModification on "Text000(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Placeholder;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Placeholder;FRA=Paramètre substituable;
    //Variable type has not been exported.

    var
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DisposalDateVisible := TRUE;
    GainLossVisible := TRUE;
    ProceedsOnDisposalVisible := TRUE;
    DisposalValueVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DisposalDateVisible := true;
    GainLossVisible := true;
    ProceedsOnDisposalVisible := true;
    DisposalValueVisible := true;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //HEI.02>>
    CompanyInfo.GET;
    FRLocAction := false;
    if CompanyInfo."Enable French Localization" then
      FRLocAction := true;
    //HEI.02<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //BC Upgrade KAPOOV01>>
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CompanyInfo.GET();
        FRLocAction := FALSE;
        IF CompanyInfo."Enable French Localization FND" THEN
            FRLocAction := TRUE;
        //HEI.02<<
    end;
    //BC Upgrade KAPOOV01<<
}

