tableextension 50080 FAGLPostingBufferExtFND extends "FA G/L Posting Buffer"
{
    // HEI.01 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //   # New field added - Id - 50000 -"Additional Description"
    // version NAVW17.00

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Account No.")
        {
            CaptionML = ENU = 'Account No.', FRA = 'N° compte';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("FA Entry Type")
        {
            CaptionML = ENU = 'FA Entry Type', FRA = 'Type écriture immo.';
            OptionCaptionML = ENU = ' ,Fixed Asset,Maintenance', FRA = ' ,Immobilisation,Maintenance';
        }
        modify("FA Entry No.")
        {
            CaptionML = ENU = 'FA Entry No.', FRA = 'N° séquence immo.';
        }
        modify("Automatic Entry")
        {
            CaptionML = ENU = 'Automatic Entry', FRA = 'Ecriture automatique';
        }
        modify("FA Posting Group")
        {
            CaptionML = ENU = 'FA Posting Group', FRA = 'Groupe compta. immo.';
        }
        modify("FA Allocation Type")
        {
            CaptionML = ENU = 'FA Allocation Type', FRA = 'Type ventilation immo.';
            // OptionCaptionML = ENU = 'Acquisition,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance,Gain,Loss,Book Value', FRA = 'Acquisition,Amortissement,Dépréciation,Réévaluation,Param. 1,Param. 2,Cession,Maintenance,Gain,Perte,Valeur comptable';
        }
        modify("FA Allocation Line No.")
        {
            CaptionML = ENU = 'FA Allocation Line No.', FRA = 'N° ligne ventilation immo.';
        }
        modify("Original General Journal Line")
        {
            CaptionML = ENU = 'Original General Journal Line', FRA = 'Ligne feuille compta. initiale';
        }
        modify("Net Disposal")
        {
            CaptionML = ENU = 'Net Disposal', FRA = 'Cession nette';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        field(50000; "Additional Description FND"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            Caption = 'Additional Description';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

