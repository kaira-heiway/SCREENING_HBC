pageextension 50095 ZoneListExt extends "Zone List"
{
    //     HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added Fields "Use As In-Transit"
    // HEI.02 FDD-PURGAPINT002 IBM LAZARE02 08.11.2017 # New field "Default Receipt Bin Code"
    // HEI.03 FDDPRDGAP055 ISBM ISYED01 11.05.2018
    //   # NEW FUNCTION FOR Zone

    layout
    {
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code of the zone.', FRA = 'Spécifie le code du magasin de la zone.';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone.', FRA = 'Spécifie le code de la zone.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the zone.', FRA = 'Spécifie la description de la zone.';
        }
        modify("Bin Type Code")
        {
            ToolTipML = ENU = 'Specifies the bin type code for the zone. The bin type determines the inbound and outbound flow of items.', FRA = 'Spécifie le code type d''emplacement pour la zone. Le type d''emplacement détermine la manière dont le programme utilise l''emplacement dans un flux entrant ou sortant d''articles.';
        }
        modify("Warehouse Class Code")
        {
            ToolTipML = ENU = 'Specifies the warehouse class code of the zone. You can store items with the same warehouse class code in this zone.', FRA = 'Spécifie le code classe de l''entrepôt de la zone. Vous pouvez y stocker les articles avec le même code classe entrepôt.';
        }
        modify("Special Equipment Code")
        {
            ToolTipML = ENU = 'Specifies the code of the special equipment to be used when you work in this zone.', FRA = 'Spécifie le code de l''équipement spécial à utiliser lorsque vous travaillez dans cette zone.';
        }
        modify("Zone Ranking")
        {
            CaptionML = ENU = 'Zone Ranking', FRA = 'Priorité zone';
            ToolTipML = ENU = 'Specifies the ranking of the zone, which is copied to all bins created within the zone.', FRA = 'Spécifie le niveau de priorité de la zone qui est copié dans tous les emplacements créés à l''intérieur de la zone.';
        }
        addafter("Zone Ranking")
        {
            field("Use As In-Transit"; Rec."Use As In-Transit FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Use As In-Transit field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Use As In-Transit field.';

            }
            field("Default Receipt Bin Code"; Rec."Default Receipt Bin Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Receipt Bin Code field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Default Receipt Bin Code field.';

            }
        }
    }
    actions
    {
        modify("&Zone")
        {
            CaptionML = ENU = '&Zone', FRA = '&Zone';
        }
        modify("&Bins")
        {
            CaptionML = ENU = '&Bins', FRA = '&Emplacements';
        }
    }
    //BC Upgrade KAMNAY01>> 
    procedure GetSelectionFilter(): Text;
    var
        Zone: Record Zone;
        CU_HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.03>>
        CurrPage.SETSELECTIONFILTER(Zone);
        exit(CU_HeinekenBCUpgrade.GetSelectionFilterForZone(Zone));
        //HEI.03<<
    end;
    //BC Upgrade KAMNAY01<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

