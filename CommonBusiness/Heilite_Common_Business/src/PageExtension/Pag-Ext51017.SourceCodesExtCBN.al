pageextension 51017 SourceCodesExtCBN extends "Source Codes"
{
    // version NAVW110.0,HEI.03
    // HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New field: Simulation
    //   # Code added in OnInit
    // HEI.03 CHG2160321 IBM SISUM01 25/01/2023 #Add the new field id 50000

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the source code.', FRA = 'Spécifie le code source.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of what the code stands for.', FRA = 'Indique une description de ce que le code représente.';
        }
        addafter(Description)
        {
            // field(Simulation; Simulation)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Enabled = FRLocAction;
            //     ToolTipML = ENU = 'Specifies that entries posted with this source code will be simulation entries.',
            //                 FRA = 'Spécifie que les écritures validées avec ce code journal sont des écritures de simulation.';
            //     Visible = FRLocAction;
            // }  // BC Upgrade NANDIS03
            field("Skip Dimension Control"; Rec."Skip Dimension Control FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Skip Dimension Control field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ToolTip = 'Specifies the value of the Skip Dimension Control field.';

            }
        }

    }
    actions
    {
        modify("&Source")
        {
            CaptionML = ENU = '&Source', FRA = '&Source';
        }
        modify("G/L Registers")
        {
            CaptionML = ENU = 'G/L Registers', FRA = 'Historiques des transactions comptabilité';
            ToolTipML = ENU = 'View posted G/L entries.', FRA = 'Affichez les écritures comptables validées.';

            //Unsupported feature: Change RunPageView on ""G/L Registers"(Action 9)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""G/L Registers"(Action 9)". Please convert manually.

        }
        modify("Item Registers")
        {
            CaptionML = ENU = 'Item Registers', FRA = 'Historiques des transactions article';
            ToolTipML = ENU = 'View posted item entries.', FRA = 'Affichez les écritures articles validées.';

            //Unsupported feature: Change RunPageView on ""Item Registers"(Action 10)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Item Registers"(Action 10)". Please convert manually.

        }
        modify("Resource Registers")
        {
            CaptionML = ENU = 'Resource Registers', FRA = 'Historiques des transactions ressource';
            ToolTipML = ENU = 'View a list of all the resource registers. Every time a resource entry is posted, a register is created. Every register shows the first and last entry numbers of its entries. You can use the information in a resource register to document when entries were posted.', FRA = 'Affiche la liste de tous les historiques des transactions ressource. A chaque fois qu''une écriture ressource est validée, un historique écritures ressources est créé. Chaque historique affiche le premier et le dernier numéro de séquence des écritures qu''il comporte. Vous pouvez utiliser les informations de l''historique écritures ressource pour documenter la validation des écritures.';

            //Unsupported feature: Change RunPageView on ""Resource Registers"(Action 13)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Resource Registers"(Action 13)". Please convert manually.

        }
        modify("Job Registers")
        {
            CaptionML = ENU = 'Job Registers', FRA = 'Historiques des transactions projet';
            ToolTipML = ENU = 'Open the related job registers.', FRA = 'Ouvrez les historiques de transactions projet.';

            //Unsupported feature: Change RunPageView on ""Job Registers"(Action 14)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Job Registers"(Action 14)". Please convert manually.

        }
        modify("FA Registers")
        {
            CaptionML = ENU = 'FA Registers', FRA = 'Historiques des transactions immobilisation';
            ToolTipML = ENU = 'View the fixed asset registers. Every register shows the first and last entry numbers of its entries. An FA register is created when you post a transaction that results in one or more FA entries.', FRA = 'Affichez les historiques des transactions immobilisation. Chaque historique affiche le premier et le dernier numéro de séquence des écritures qu''il comporte. ž chaque fois que vous validez une transaction qui génère une ou plusieurs écritures comptables immobilisation, un historique est créé.';

            //Unsupported feature: Change RunPageView on ""FA Registers"(Action 11)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""FA Registers"(Action 11)". Please convert manually.

        }
        modify("I&nsurance Registers")
        {
            CaptionML = ENU = 'I&nsurance Registers', FRA = 'Historiques des transactions assu&rance';
            ToolTipML = ENU = 'View posted insurance entries.', FRA = 'Affichez les écritures assurance validées.';

            //Unsupported feature: Change RunPageView on ""I&nsurance Registers"(Action 16)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""I&nsurance Registers"(Action 16)". Please convert manually.

        }
        modify("Warehouse Registers")
        {
            CaptionML = ENU = 'Warehouse Registers', FRA = 'Historiques des transactions entrepôt';

            //Unsupported feature: Change RunPageView on ""Warehouse Registers"(Action 7300)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Warehouse Registers"(Action 7300)". Please convert manually.

        }

    }

    var
        CompanyInfo: Record "Company Information";
        FRLocAction: Boolean;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    //HEI.02>>
    FRLocAction := false;
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
        FRLocAction := true;
    //HEI.02<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    // BC Upgrade NANDIS03 >> Code ia available in Oninit trigger
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.02>>
        FRLocAction := FALSE;
        CompanyInfo.GET();
        IF CompanyInfo."Enable French Localization FND" THEN
            FRLocAction := TRUE;
        //HEI.02<<
    end;
    // BC Upgrade NANDIS03 <<
}

