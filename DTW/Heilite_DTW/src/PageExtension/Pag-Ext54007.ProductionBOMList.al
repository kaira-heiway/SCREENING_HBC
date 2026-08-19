pageextension 54007 ProductionBOMListExt extends "Production BOM List"
{
    //     // version NAVW110.0,HEI.01

    //     HEI.01 FDD-CHG2012344_HB567_Bill-of Materials Reports IBM NANDIS01 19.06.2019
    //   New button "BOM Lines Report" added in the page

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the BOM number.', FRA = 'Spécifie le numéro de nomenclature.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description for the production BOM.', FRA = 'Indique une description de la nomenclature de production.';
        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies an extended description for the BOM if there is not enough space in the Description field.', FRA = 'Spécifie une description étendue pour la nomenclature si l''espace du champ Description n''est pas suffisant.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of the production BOM.', FRA = 'Spécifie le statut de la nomenclature de production.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code to which the BOM refers.', FRA = 'Indique le code unité auquel la nomenclature fait référence.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies a search name.', FRA = 'Spécifie un nom de recherche.';
        }
        modify("Version Nos.")
        {
            ToolTipML = ENU = 'Specifies the version number series that the production BOM versions refer to.', FRA = 'Indique les souches de numéros de version auxquelles les versions de nomenclature font référence.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies the last date that was modified.', FRA = 'Indique la dernière date modifiée.';
        }
    }
    actions
    {
        modify("&Prod. BOM")
        {
            CaptionML = ENU = '&Prod. BOM', FRA = '&Nomenclature';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Versions)
        {
            CaptionML = ENU = 'Versions', FRA = 'Versions';
        }
        /*  modify("Ma&trix per Version")
         {
             CaptionML = ENU = 'Ma&trix per Version', FRA = 'Ma&trice de versions';
         } */
        modify("Where-used")
        {
            CaptionML = ENU = 'Where-used', FRA = 'Cas d''emploi';
        }
        modify("Exchange Production BOM Item")
        {
            CaptionML = ENU = 'Exchange Production BOM Item', FRA = 'Remplacer composant';
        }
        modify("Delete Expired Components")
        {
            CaptionML = ENU = 'Delete Expired Components', FRA = 'Supprimer composants expirés';
        }
        modify("Where-Used (Top Level)")
        {
            CaptionML = ENU = 'Where-Used (Top Level)', FRA = 'Cas d''emploi multi-niveau';
        }
        modify("Quantity Explosion of BOM")
        {
            CaptionML = ENU = 'Quantity Explosion of BOM', FRA = 'Nomenclature multi-niveau';
        }

        addafter("Compare Production Cost Shares")
        {
            action("BOM Lines Report")
            {
                Image = "Report";
                RunObject = Report "BOM Lines";
                ApplicationArea = All;
            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

