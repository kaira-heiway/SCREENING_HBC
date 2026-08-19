pageextension 51072 DimensionsExtCBN extends Dimensions
{
    //HEI.01 BPMGAP015 IBM SOICAD01 11.07.2017 EBF Matrix & Movement Type
    //   #new action Ebf Matrix
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 24.08.2017 # MDM Customer Card
    //   # New field: Mandatory Customer
    // HEI.03 CHG2171687 IBM SISUM01 06/03/2023 #change the page for EBF Matrix Setup: old page used was Ebf Combination, new page used EBF Matrix
    // HEI.04 CHG2171687 IBM SISUM01 19/05/2023 HB3907 EBF Matrix
    //   #test if New EBF version is enable

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension.', FRA = 'Indique le code pour l''axe analytique.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the dimension code.', FRA = 'Spécifie le nom du code axe.';
        }
        modify("Code Caption")
        {
            ToolTipML = ENU = 'Specifies the caption of the dimension code. This is displayed as the name of dimension code fields.', FRA = 'Spécifie la légende du code axe. Il apparaît comme le nom des champs des codes axe.';
        }
        modify("Filter Caption")
        {
            ToolTipML = ENU = 'Specifies the caption of the dimension code when used as a filter. This is displayed as the name of dimension filter fields.', FRA = 'Spécifie la légende du code axe lorsqu''il est utilisé comme filtre. Il apparaît comme le nom des champs des filtres axe.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the dimension code.', FRA = 'Indique une description du code axe.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies that entries with this dimension cannot be posted.', FRA = 'Spécifie que les écritures ayant cet axe analytique ne peuvent pas être validées.';
        }
        modify("Map-to IC Dimension Code")
        {
            ToolTipML = ENU = 'Specifies which intercompany dimension corresponds to the dimension on the line.', FRA = 'Spécifie quelle dimension intersociété correspond à la dimension sur la ligne.';
        }
        modify("Consolidation Code")
        {
            ToolTipML = ENU = 'Specifies the code that is used for consolidation.', FRA = 'Spécifie le code utilisé pour la consolidation.';
        }
        //---BC Upgrade KAMNAY01<<
        addafter("Consolidation Code")
        {
            field("Mandatory Customer"; Rec."Mandatory Customer FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Mandatory Customer field.';
            }
        }
        //---BC Upgrade KAMNAY01>>
    }
    actions
    {
        modify("&Dimension")
        {
            CaptionML = ENU = '&Dimension', FRA = 'A&xe analytique';
        }
        modify("Dimension &Values")
        {
            CaptionML = ENU = 'Dimension &Values', FRA = 'S&ections analytiques';
            ToolTipML = ENU = 'View or edit the dimension values for the current dimension.', FRA = 'Affichez ou modifiez les sections analytiques de la dimension actuelle.';

            //Unsupported feature: Change RunPageLink on ""Dimension &Values"(Action 20)". Please convert manually.

        }
        modify("Account Type De&fault Dim.")
        {
            CaptionML = ENU = 'Account Type De&fault Dim.', FRA = 'A&ffectations par type compte';
            ToolTipML = ENU = 'Specify default dimension settings for the relevant account types such as customers, vendors, or items. For example, you can make a dimension required.', FRA = 'Spécifie les paramètres des dimensions par défaut pour les types de comptes pertinents, comme les clients, les fournisseurs ou les articles. Par exemple, vous pouvez exiger qu''une dimension soit renseignée.';

            //Unsupported feature: Change RunPageLink on ""Account Type De&fault Dim."(Action 21)". Please convert manually.

        }
        modify(Translations)
        {
            CaptionML = ENU = 'Translations', FRA = 'Traductions';
            ToolTipML = ENU = 'View or edit translated dimensions. Translated item descriptions are automatically inserted on documents according to the language code.', FRA = 'Affichez ou modifiez les axes analytiques traduits. Les descriptions d''articles traduites sont automatiquement insérées dans les documents en fonction du code de langue.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(MapToICDimWithSameCode)
        {
            CaptionML = ENU = 'Map to IC Dim. with Same Code', FRA = 'Faire correspondre à l''axe IC ayant le même code';
        }


        //Unsupported feature: CodeModification on "MapToICDimWithSameCode(Action 29).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(Dimension);
        IF Dimension.FIND('-') AND CONFIRM(Text000) THEN
          REPEAT
            ICMapping.MapOutgoingICDimensions(Dimension);
          UNTIL Dimension.NEXT = 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(Dimension);
        if Dimension.FIND('-') and CONFIRM(Text000) then
          repeat
            ICMapping.MapOutgoingICDimensions(Dimension);
          until Dimension.NEXT = 0;
        */
        //end;
        addafter(MapToICDimWithSameCode)
        {
            action(SetupEbf)
            {
                Caption = 'Ebf Matrix';
                Image = MapAccounts;
                ApplicationArea = all;
                ToolTip = 'Executes the Ebf Matrix action.';
                trigger OnAction();
                var
                    EBFMatrix: Record "Ebf Combination FND";
                    EbfCombinations: Page "Ebf Combinations CBN";
                    EbfCombinationNewVers: Page "EBF Matrix CBN";
                begin
                    if not EBFMatrix.CheckNewEBFMatrixIsActive() then begin //HEI.04
                        //HEI.01 BPMGAP015>>
                        EbfCombinations.SetDimCode(Rec.Code);
                        EbfCombinations.RunModal();
                        //HEI.01 BPMGAP015<<

                        //HEI.04>>
                    end else begin
                        EbfCombinationNewVers.SetDimCode(Rec.Code);
                        EbfCombinationNewVers.RUNMODAL();
                    end;
                    //HEI.04<<
                end;
            }
            action(SourceCodeDim)
            {
                Caption = 'Source Code Dimension';
                Image = AnalysisViewDimension;
                ApplicationArea = all;
                ToolTip = 'Executes the Source Code Dimension action.';
                trigger OnAction();
                var
                    SrcCodeDim: Page "Source Code Dimension CBN";
                begin
                    //HEI.01 BPMGAP015>>
                    SrcCodeDim.SetDimCode(Rec.Code);
                    SrcCodeDim.RUNMODAL();
                    //HEI.01 BPMGAP015<<
                end;
            }
        }
    }


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Are you sure you want to map the selected lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Are you sure you want to map the selected lines?;FRA=Voulez-vous faire correspondre les lignes sélectionnées ?;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

