pageextension 54011 RoutingVersionExt extends "Routing Version"
{
    // version NAVW110.0

    // HEI.01 RFC-CHG0257267 IBM.AB 15.10.2018
    // # New field Active created
    //***************************************
    //BC UPGRADE PATHAA02 06.01.26   

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Version Code")
        {
            ToolTipML = ENU = 'Specifies the version code of the routing.', FRA = 'Spécifie le code version de la gamme.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description for the routing version.', FRA = 'Indique une description de la version gamme.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies in which order operations in the routing are performed.', FRA = 'Spécifie l''ordre dans lequel les opérations de la gamme sont exécutées.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of this routing version.', FRA = 'Spécifie le statut de cette version gamme.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the starting date for this routing version.', FRA = 'Indique la date de début de cette version gamme.';
        }
        addafter("Starting Date")
        {
            field(Active; Rec."Active FND")
            {
                ApplicationArea = All;//BC UPGRADE PATHAA02
            }
        }
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        //modify("Copy Routing &Header")//BC UPGRADE PATHAA02
        modify("CopyRouting")//BC UPGRADE PATHAA02
        {
            CaptionML = ENU = 'Copy Routing &Header', FRA = 'Copier &en-tête gamme';
        }
        modify("Copy Routing &Version")
        {
            CaptionML = ENU = 'Copy Routing &Version', FRA = 'Copier &version gamme';
        }
    }


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Copy from routing header?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Copy from routing header?;FRA=Souhaitez-vous effectuer la copie à partir de l'en-tête gamme ?;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

