tableextension 50278 CostingAccountSetupExtFND extends "Cost Accounting Setup"
{
    // version NAVW17.00

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Starting Date for G/L Transfer")
        {
            CaptionML = ENU = 'Starting Date for G/L Transfer', FRA = 'Date début pour transfert comptabilité';
        }
        modify("Align G/L Account")
        {
            CaptionML = ENU = 'Align G/L Account', FRA = 'Aligner compte général';
            OptionCaptionML = ENU = 'No Alignment,Automatic,Prompt', FRA = 'Pas d''alignement,Automatique,Invite';
        }
        modify("Align Cost Center Dimension")
        {
            CaptionML = ENU = 'Align Cost Center Dimension', FRA = 'Aligner axe centre de coûts';
            OptionCaptionML = ENU = 'No Alignment,Automatic,Prompt', FRA = 'Pas d''alignement,Automatique,Invite';
        }
        modify("Align Cost Object Dimension")
        {
            CaptionML = ENU = 'Align Cost Object Dimension', FRA = 'Aligner axe objet de coûts';
            OptionCaptionML = ENU = 'No Alignment,Automatic,Prompt', FRA = 'Pas d''alignement,Automatique,Invite';
        }
        modify("Last Allocation ID")
        {
            CaptionML = ENU = 'Last Allocation ID', FRA = 'ID dernière ventilation';
        }
        modify("Last Allocation Doc. No.")
        {
            CaptionML = ENU = 'Last Allocation Doc. No.', FRA = 'N° doc. dernière ventilation';
        }
        modify("Auto Transfer from G/L")
        {
            CaptionML = ENU = 'Auto Transfer from G/L', FRA = 'Transférer automatiquement à partir de la compta';
        }
        modify("Check G/L Postings")
        {
            CaptionML = ENU = 'Check G/L Postings', FRA = 'Vérifier validations compta';
        }
        modify("Cost Center Dimension")
        {
            CaptionML = ENU = 'Cost Center Dimension', FRA = 'Axe centre de coûts';
        }
        modify("Cost Object Dimension")
        {
            CaptionML = ENU = 'Cost Object Dimension', FRA = 'Axe objet de coûts';
        }
        field(50000; "Shortcut Dimension 1 Code FND"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code FND';
            TableRelation = Dimension;
        }
        field(50001; "Shortcut Dimension 2 Cod FNDe"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = Dimension;
        }
        field(50002; "Shortcut Dimension 3 Code FND"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = Dimension;
        }
        field(50003; "Shortcut Dimension 4 Code FND"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = Dimension;
        }
        field(50004; "Shortcut Dimension 5 Code FND"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = Dimension;
        }
        field(50005; "Shortcut Dimension 6 Code FND"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = Dimension;
        }
        field(50006; "Shortcut Dimension 7 Code FND"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = Dimension;
        }
        field(50007; "Shortcut Dimension 8 Code FND"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = Dimension;
        }
        field(50008; "Shortcut Dimension 9 Code FND"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(50009; "Shortcut Dimension 10 Code FND"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(50010; "Shortcut Dimension 11 Code FND"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(50011; "Shortcut Dimension 12 Code FND"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(50012; "Shortcut Dimension 13 Code FND"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(50013; "Shortcut Dimension 14 Code FND"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(50014; "Shortcut Dimension 15 Code FND"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(50015; "Shortcut Dimension 16 Code FND"; Code[20])
        {
            TableRelation = Dimension;
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=The starting date can no longer be defined. According to Register No. %1, general ledger entries have already been transferred to Cost Accounting.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=The starting date can no longer be defined. According to Register No. %1, general ledger entries have already been transferred to Cost Accounting.;FRA=La date début ne peut plus être définie. En fonction du n° hist. transaction %1, les écritures comptables ont déjà été transférées vers la comptabilité analytique.;
    //Variable type has not been exported.
}

