pageextension 51043 FixedAssetSetupExtCBN extends "Fixed Asset Setup"
{
    // HEI.01 FDD-RTRGAP056 IBM HORTOC01 25.08.2017
    //   # Add fields "Payable Acc. Purchase Receipt","Post GL on Purchase Receive"
    // HEI.02 FDD-HB2373 CHG2187935 IBM SRIVAS07 09-02-2023 - Development - CMG mandatory on FA
    //   # Added field Excluded CMG Dim. Values
    // HEI.03 FDD-HB2311 CHG2200648 IBM NANDIS01 12-06-2023 #Correct posting flow FA invoicing (credit notes)
    //   # New fields "Post GL on Purchase Return" and "Payable Acc. Purchase Return" shown in page
    // version NAVW110.0,HEI.03

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Default Depr. Book")
        {
            ToolTipML = ENU = 'Specifies the default depreciation book on journal lines and purchase lines and when you run batch jobs and reports.', FRA = 'Indique la loi d''amortissement par défaut sur les lignes feuille, les lignes achat et lorsque vous exécutez des traitements par lots et imprimez des états.';
        }
        modify("Allow Posting to Main Assets")
        {
            ToolTipML = ENU = 'Specifies whether you have split your fixed assets into main assets and components, and you want to be able to post directly to main assets.', FRA = 'Spécifie si vous avez divisé vos immobilisations en immobilisations principales et en composants et que vous souhaitez pouvoir valider directement sur les immobilisations principales.';
        }
        modify("Allow FA Posting From")
        {
            ToolTipML = ENU = 'Specifies the earliest date when posting to the fixed assets is allowed.', FRA = 'Spécifie la première date à laquelle la validation des immobilisations est autorisée.';
        }
        modify("Allow FA Posting To")
        {
            ToolTipML = ENU = 'Specifies the latest date when posting to the fixed assets is allowed.', FRA = 'Spécifie la dernière date à laquelle la validation des immobilisations est autorisée.';
        }
        modify("Insurance Depr. Book")
        {
            ToolTipML = ENU = 'Specifies a depreciation book code. If you use the insurance facilities, you must enter a code to post insurance coverage ledger entries.', FRA = 'Spécifie un code loi amortissement. Si vous utilisez les options d''assurance, vous devez saisir un code pour pouvoir valider les écritures comptables couverture assurance.';
        }
        modify("Automatic Insurance Posting")
        {
            ToolTipML = ENU = 'Specifies you want to post insurance coverage ledger entries when you post acquisition cost entries with the Insurance No. field filled in.', FRA = 'Indique si vous voulez valider des écritures comptables couverture assurance lorsque vous validez des écritures coût acquisition dont le champ Numéro assurance est renseigné.';
        }
        modify(Numbering)
        {
            CaptionML = ENU = 'Numbering', FRA = 'Numérotation';
        }
        modify("Fixed Asset Nos.")
        {
            ToolTipML = ENU = 'Specifies the code for the number series that will be used to assign numbers to fixed assets.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux immobilisations.';
        }
        modify("Insurance Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code that will be used to assign numbers to insurance policies.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée pour affecter des numéros aux polices d''assurance.';
        }
        addafter("Allow FA Posting From")
        {
            field("Excluded CMG Dim. Values"; Rec."Excluded CMG Dim. Values FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Importance = Promoted;
                ToolTip = 'Specifies the value of the Excluded CMG Dim. Values field.';
            }
        }
        addafter(Numbering)
        {
            //group(Posting)
            group(Posting_Heilite)//BC Upgrade KAPOOV01  same name(Posting) for page group control and page action.
            {
                Caption = 'Posting';
                field("Payable Acc. Purchase Receipt"; Rec."Payable Acc.Purch. Receipt FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payable Acc. Purchase Receipt field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Payable Acc. Purchase Receipt field.';

                }
                field("Post GL on Purchase Receive"; Rec."Post GL on Purch. Receive FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post GL on Purchase Receive field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Post GL on Purchase Receive field.';

                }
                field("Post GL on Purchase Return"; Rec."Post GL on Purchase Return FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post GL on Purchase Return field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Post GL on Purchase Return field.';

                }
                field("Payable Acc. Purchase Return"; Rec."Payable Acc. Purch. Return FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payable Acc. Purchase Return field.';
                    // BC Upgrade NANDIS03                    ToolTip = 'Specifies the value of the Payable Acc. Purchase Return field.';

                }
            }
        }
    }
    actions
    {
        modify("Depreciation Books")
        {
            CaptionML = ENU = 'Depreciation Books', FRA = 'Lois d''amortissement';
            ToolTipML = ENU = 'Set up depreciation books for various depreciation purposes, such as tax and financial statements.', FRA = 'Paramétrez des lois d''amortissement pour divers types d''amortissement, par exemple les états financiers.';
        }
        modify("Depreciation Tables")
        {
            CaptionML = ENU = 'Depreciation Tables', FRA = 'Tables d''amortissement';
            ToolTipML = ENU = 'Set up the different depreciation methods that you will use to depreciate fixed assets.', FRA = 'Paramétrez les différentes méthodes d''amortissement permettant d''amortir des immobilisations.';
        }
        modify("FA Classes")
        {
            CaptionML = ENU = 'FA Classes', FRA = 'Classes immo.';
            ToolTipML = ENU = 'Set up different asset classes, such as Tangible Assets and Intangible Assets, to group your fixed assets by categories.', FRA = 'Paramétrez les différentes classes d''immobilisations, par exemple les immobilisations corporelles et incorporelles, afin de regrouper vos immobilisations par catégories.';
        }
        modify("FA Subclasses")
        {
            CaptionML = ENU = 'FA Subclasses', FRA = 'Sous-classes immo.';
            ToolTipML = ENU = 'Set up different asset subclasses, such as Plant and Property and Machinery and Equipment, that you can assign to fixed assets and insurance policies.', FRA = 'Paramétrez les différentes sous-classes d''immobilisations, par exemple machine et voiture, que vous pouvez affecter aux immobilisations et polices d''assurance.';
        }
        modify("FA Locations")
        {
            CaptionML = ENU = 'FA Locations', FRA = 'Emplacements immo.';
            ToolTipML = ENU = 'Set up different locations, such as a warehouse or a location within a warehouse, that you can assign to fixed assets.', FRA = 'Paramétrez différents emplacements, par exemple un entrepôt ou un emplacement dans un entrepôt, que vous pouvez affecter aux immobilisations.';
        }
        modify(Posting)
        {
            CaptionML = ENU = 'Posting', FRA = 'Validation';
        }
        modify("FA Posting Type Setup")
        {
            CaptionML = ENU = 'FA Posting Type Setup', FRA = 'Type paramètre compta. immo.';
            ToolTipML = ENU = 'Define how to handle the Write-Down, Appreciation, Custom 1, and Custom 2 posting types that you use when posting to fixed assets.', FRA = 'Définissez comment gérer les types validation Dépréciation, Réévaluation, Param. 1 et Param. 2 que vous utilisez lors de la validation sur des immobilisations.';
        }
        modify("FA Posting Groups")
        {
            CaptionML = ENU = 'FA Posting Groups', FRA = 'Groupes compta. immo.';
            ToolTipML = ENU = 'Set up the accounts to which transactions are posted for fixed assets for each posting group, so that you can assign them to the relevant fixed assets.', FRA = 'Paramétrez les comptes sur lesquels les transactions sont validées pour les immobilisations de chaque groupe comptabilisation, de façon à pouvoir les affecter aux immobilisations appropriées.';
        }
        modify("FA Journal Templates")
        {
            CaptionML = ENU = 'FA Journal Templates', FRA = 'Modèles feuille immo.';
            ToolTipML = ENU = 'Set up number series and reason codes in the journals that you use for fixed asset posting. By using different templates you can design windows with different layouts and you can assign trace codes, number series, and reports to each template.', FRA = 'Paramétrez des souches de numéros et des codes motif dans les feuilles que vous utilisez pour la validation des immobilisations. En utilisant différents modèles, vous pouvez créer des fenêtres d''aspects différents et vous pouvez affecter des codes suivi, des souches de numéros et des états à chaque modèle.';
        }
        modify("FA Reclass. Journal Templates")
        {
            CaptionML = ENU = 'FA Reclass. Journal Templates', FRA = 'Modèles feuille reclass. immo';
            ToolTipML = ENU = 'Set up number series and reason codes in the journal that you use to reclassify fixed assets. By using different templates you can design windows with different layouts and you can assign trace codes, number series, and reports to each template.', FRA = 'Paramétrez des souches de numéros et des codes motif dans la feuille que vous utilisez pour reclasser les immobilisations. En utilisant différents modèles, vous pouvez créer des fenêtres d''aspects différents et vous pouvez affecter des codes suivi, des souches de numéros et des états à chaque modèle.';
        }
    }


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

