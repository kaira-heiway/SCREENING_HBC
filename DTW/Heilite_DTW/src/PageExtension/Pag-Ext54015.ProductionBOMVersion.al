pageextension 54015 ProductionBOMVersionExt extends "Production BOM Version"
{
    // version NAVW110.0
    // HEI.01 RFC-CHG0257267 IBM.AB 15.10.2018
    //# New field Active created
    //***************************************
    //BC UPGRADE PATHAA02 08.01.26   

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Version Code")
        {
            ToolTipML = ENU = 'Specifies the version code of the production BOM.', FRA = 'Spécifie le code de version de la nomenclature de production.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description for the production BOM version.', FRA = 'Indique une description de la version nomenclature de production.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure that the production BOM version refers to.', FRA = 'Indique l''unité à laquelle la version nomenclature production fait référence.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of this production BOM version.', FRA = 'Spécifie le statut de cette version nomenclature production.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the starting date for this production BOM version.', FRA = 'Indique la date de début de cette version de nomenclature production.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the production BOM version card was last modified.', FRA = 'Indique la date à laquelle la fiche version nomenclature production a été modifiée pour la dernière fois.';
        }
        addafter("Last Date Modified")
        {
            field(Active; Rec."Active FND")
            {
                ApplicationArea = All; //BC UPGRADE PATHAA02
            }
        }
    }
    actions
    {
        modify("Ve&rsion")
        {
            CaptionML = ENU = 'Ve&rsion', FRA = '&Version';
        }
        modify("Where-Used")
        {
            CaptionML = ENU = 'Where-Used', FRA = 'Cas d''emploi';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        //BC UPGRADE PATHAA02>>
        // modify("Copy BOM &Header")
        // {
        //     CaptionML = ENU = 'Copy BOM &Header', FRA = 'Copier &en-tête nomencl.';
        // }
        //BC UPGRADE PATHAA02<<
        modify("Copy BOM &Version")
        {
            CaptionML = ENU = 'Copy BOM &Version', FRA = 'Copier &version nomencl.';
        }
    }


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Copy from Production BOM?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Copy from Production BOM?;FRA=Copier à partir de la nomenclature ?;
    //Variable type has not been exported.

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.   

}

