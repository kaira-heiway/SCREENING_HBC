tableextension 50086 FAPostingGroupBufferExtFND extends "FA Posting Group Buffer"
{
    // version NAVW16.00

    fields
    {
        modify("FA Posting Group")
        {
            CaptionML = ENU = 'FA Posting Group', FRA = 'Groupe compta. immo.';
        }
        modify("Posting Type")
        {
            CaptionML = ENU = 'Posting Type', FRA = 'Type comptabilisation';
            OptionCaptionML = ENU = 'Acq,Depr,WD,Appr,C1,C2,DeprExp,Maint,Disp,GL,BV,DispAcq,DispDepr,DispWD,DispAppr,DispC1,DispC2,BalWD,BalAppr,BalC1,BalC2', FRA = 'Acq,Amort,Depr,Réév,P1,P2,ExpAmort,Maint,Cédé,Cpta,VC,AcqCess,AmortCess,DéprCess,RéévCess,P1Cess,P2Cess,DéprSolde,RéevSolde,P1Solde,P2Solde';
        }
        modify("Account No.")
        {
            CaptionML = ENU = 'Account No.', FRA = 'N° compte';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Account Name")
        {
            CaptionML = ENU = 'Account Name', FRA = 'Nom du compte';
        }
        modify("FA FieldCaption")
        {
            CaptionML = ENU = 'FA FieldCaption', FRA = 'TitreChamp Immo.';
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

