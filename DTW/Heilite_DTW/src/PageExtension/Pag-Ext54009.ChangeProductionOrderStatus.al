pageextension 54009 ChangeProductionOrderStatusExt extends "Change Production Order Status"
{
    // version NAVW110.0,HEI.01

    // HEI.01 CHG2037014 - IBM TUDOSG01 06.01.2020
    //  #Zone Code filter added
    //  # Added the Caption for Location Code field
    //  # Table relatio added for Location Code field
    //  # Field order changed
    // HEI.02 CHG2098891 IBM.LS      19.07.2021
    //   # Added Field - Blocked (Caption: Admin. Completed)

    //Bc Upgrade YADAVM09 BuildForm function created to handle custom code //HEI.01
    //Bc Upgrade YADAVM09 Added Tooltip for the fields.
    //BC Upgrade YADAVM09 Caption changed for the blocked field.

    //Test cases : BC Upgrade Kamnay01 -We created new duplicate fields because the original ones are standard. In the Heilite report, the date format is changed in the BuildForm function, but since it is a standard function and no event is available, we created a new function and used it in the duplicate fields, while hiding the standard fields.
    //Fields are :ProdOrderStatusL, StartingDateL, EndingDateL


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify(ProdOrderStatus)
        {
            CaptionML = ENU = 'Status Filter', FRA = 'Filtre statut';
            ToolTipML = ENU = 'Specifies the status of the production orders to define a filter on the lines.', FRA = 'Spécifie le statut des ordres de fabrication pour définir le critère de positionnement d''un filtre sur les lignes.';
            OptionCaptionML = ENU = 'Simulated,Planned,Firm Planned,Released', FRA = 'Simulé,Planifié,Planifié ferme,Lancé';
            Visible = false;
        }
        modify(StartingDate)
        {
            Visible = false;
            CaptionML = ENU = 'Starts On and After ', FRA = 'Doit démarrer avant';
            ToolTipML = ENU = 'Specifies a date to define a filter on the lines.', FRA = 'Spécifie une date pour définir un filtre sur les lignes.';
        }
        modify(EndingDate)
        {
            Visible = false;
            CaptionML = ENU = 'Ends On and Before', FRA = 'Terminé avant';
            ToolTipML = ENU = 'Specifies a date to define a filter on the lines.', FRA = 'Spécifie une date pour définir un filtre sur les lignes.';
        }
        addafter(EndingDate)
        {
            // BC Upgrade Kamnay01 >>We created new duplicate fields because the original ones are standard. In the Heilite report, the date format is changed in the BuildForm function, but since it is a standard function and no event is available, we created a new function and used it in the duplicate fields, while hiding the standard fields.
            field(ProdOrderStatusL; ProdOrderStatusL)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Status Filter';
                OptionCaption = 'Simulated,Planned,Firm Planned,Released';
                ToolTip = 'Specifies the status of the production orders to define a filter on the lines.';

                trigger OnValidate()
                begin
                    ProdOrderStatusOnAfterValidate();
                end;
            }
            field(StartingDateL; StartingDateL)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Must Start Before';
                ToolTip = 'Specifies a date to define a filter on the lines.';

                trigger OnValidate()
                begin
                    StartingDateOnAfterValidate();
                end;
            }
            field(EndingDateL; EndingDateL)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Ends Before';
                ToolTip = 'Specifies a date to define a filter on the lines.';

                trigger OnValidate()
                begin
                    EndingDateOnAfterValidate();
                end;
            }
            //BC upgrade Kamnay01<<We created new duplicate fields because the original ones are standard. In the Heilite report, the date format is changed in the BuildForm function, but since it is a standard function and no event is available, we created a new function and used it in the duplicate fields, while hiding the standard fields.

            field(ZoneCode; ZoneCode)
            {
                Caption = 'Zone Code';
                TableRelation = Zone.Code WHERE("Use As In-Transit FND" = FILTER(false));
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    ZoneCodeOnAfterValidate(); //HEI.01
                end;
            }
            field(LocationCode; LocationCode)
            {
                Caption = 'Location Code';
                TableRelation = Location.Code;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    LocationCodeOnAfterValidate(); //HEI.01
                end;
            }

        }
        //Bc Upgrade YADAVM09 ToolTipMLs are updated>>
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production order.',
                            FRA = 'Spécifie le numéro de l''ordre de fabrication.';
        }
        modify("Source No.")
        {
            ToolTipML = ENU = 'Specifies the source number of the production order.',
                            FRA = 'Spécifie le numéro origine de l''ordre de fabrication.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the production order.',
                            FRA = 'Spécifie la description de l''ordre de fabrication.';
        }
        modify("Creation Date")
        {
            ToolTipML = ENU = 'Specifies the date on which you created the production order.',
                            FRA = 'Spécifie la date à laquelle vous avez créé l''ordre de production.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the starting date of the production order.',
                            FRA = 'Spécifie la date de début de l''ordre de fabrication.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies the ending date of the production order.',
                            FRA = 'Spécifie la date de fin de l''ordre de fabrication.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the due date of the production order.',
                            FRA = 'Spécifie la date d''échéance de l''ordre de fabrication.';
        }
        modify("Finished Date")
        {
            ToolTipML = ENU = 'Specifies the actual finishing date of a finished production order.',
                            FRA = 'Spécifie la date de réalisation réelle d''un ordre de fabrication terminé.';
        }

        modify("Source Type")
        {
            ToolTipML = ENU = 'Specifies the source type of the production order.',
                            FRA = 'Spécifie le type origine de l''ordre de fabrication.';
        }
        modify("Starting Time")
        {
            ToolTipML = ENU = 'Specifies the starting time of the production order.',
                            FRA = 'Spécifie l''heure de début de l''ordre de fabrication.';
        }
        modify("Ending Time")
        {
            ToolTipML = ENU = 'Specifies the ending time of the production order.',
                            FRA = 'Spécifie l''heure de fin de l''ordre de fabrication.';
        }
        addafter("Finished Date")
        {
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = all;
                Caption = 'Admin. Completed';//BC Upgrade YADAVM09 either we can use Caption or CaptionML property at one time.
                //   CaptionML = ENU ='Admin. Completed',FRA='Bloqué';//BC Upgrade YADAVM09
            }
        }
        //Bc Upgrade YADAVM09 ToolTipMLs are updated<<

    }
    actions
    {
        modify("Pro&d. Order")
        {
            CaptionML = ENU = 'Pro&d. Order', FRA = '&O.F.';
        }
        modify("E&ntries")
        {
            CaptionML = ENU = 'E&ntries', FRA = 'É&critures';
        }
        modify("Item Ledger E&ntries")
        {
            CaptionML = ENU = 'Item Ledger E&ntries', FRA = 'É&critures comptables article';
        }
        modify("Capacity Ledger Entries")
        {
            CaptionML = ENU = 'Capacity Ledger Entries', FRA = 'Écritures comptables capacité';
        }
        modify("Value Entries")
        {
            CaptionML = ENU = 'Value Entries', FRA = 'Écritures valeur';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Change &Status")
        {
            CaptionML = ENU = 'Change &Status', FRA = 'Changer &statut';
        }
    }


    //Unsupported feature: PropertyModification on ""Change &Status"(Action 41).OnAction.LocalText000(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //"Change &Status" : ENU=Simulated,Planned,Firm Planned,Released,Finished;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Change &Status" : ENU=Simulated,Planned,Firm Planned,Released,Finished;FRA=Simulé,Planifié,Planifié ferme,Lancé,Terminé;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Changing status to %1...\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Changing status to %1...\\;FRA=Passage au statut %1 en cours...\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Prod. Order #1###### @2@@@@@@@@@@@@@;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Prod. Order #1###### @2@@@@@@@@@@@@@;FRA=O.F.  #1###### @2@@@@@@@@@@@@@;
    //Variable type has not been exported.

    var
        ZoneCode: Code[10];
        LocationCode: Code[10];
        StartingDateL: Date;
        EndingDateL: Date;
        ProdOrderStatusL: Option Simulated,Planned,"Firm Planned",Released;



    //Unsupported feature: CodeModification on "BuildForm(PROCEDURE 1)". Please convert manually.

    //procedure BuildForm();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FILTERGROUP(2);
    SETRANGE(Status,ProdOrderStatus);
    FILTERGROUP(0);

    if StartingDate <> 0D then
      SETFILTER("Starting Date",'..%1',StartingDate)
    else
      SETRANGE("Starting Date");

    if EndingDate <> 0D then
      SETFILTER("Ending Date",'..%1',EndingDate)
    else
      SETRANGE("Ending Date");

    CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
      //>>HEI.01
      //SETFILTER("Starting Date",'..%1',StartingDate)
      SETFILTER("Starting Date",'%1..',StartingDate)
      //<<HEI.01
    #7..14
    //>>HEI.01
    if ZoneCode <> '' then
      SETRANGE("Zone Code",ZoneCode)
    else
      SETRANGE("Zone Code");

    if LocationCode <> '' then
      SETRANGE("Location Code",LocationCode)
    else
      SETRANGE("Location Code");
    //<<HEI.01

    CurrPage.UPDATE(false);
    */
    //end;

    local procedure ZoneCodeOnAfterValidate();
    begin
        BuildForm();

    end;

    local procedure ProdOrderStatusOnAfterValidate()
    begin
        BuildForm();
    end;

    local procedure LocationCodeOnAfterValidate();
    begin
        BuildForm();
    end;

    local procedure StartingDateOnAfterValidate()
    begin
        BuildForm();
    end;

    local procedure EndingDateOnAfterValidate()
    begin
        BuildForm();
    end;

    LOCAL procedure BuildForm()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETRANGE(Status, ProdOrderStatusL);
        Rec.FILTERGROUP(0);

        IF StartingDateL <> 0D THEN
            //>>HEI.01
            //SETFILTER("Starting Date",'..%1',StartingDate)
            Rec.SETFILTER("Starting Date", '%1..', StartingDateL)
        //<<HEI.01
        ELSE
            Rec.SETRANGE("Starting Date");

        IF EndingDateL <> 0D THEN
            Rec.SETFILTER("Ending Date", '..%1', EndingDateL)
        ELSE
            Rec.SETRANGE("Ending Date");

        //>>HEI.01
        IF ZoneCode <> '' THEN
            Rec.SETRANGE("Zone Code FND", ZoneCode)
        ELSE
            Rec.SETRANGE("Zone Code FND");

        IF LocationCode <> '' THEN
            Rec.SETRANGE("Location Code", LocationCode)
        ELSE
            Rec.SETRANGE("Location Code");
        //<<HEI.01

        CurrPage.UPDATE(FALSE);
    end;


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

