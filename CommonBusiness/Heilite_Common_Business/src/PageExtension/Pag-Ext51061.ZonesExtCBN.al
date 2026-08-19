pageextension 51061 ZonesExtCBN extends Zones
{
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added Fields "Use As In-Transit"
    // HEI.02 FDD-PURGAPINT002 IBM LAZARE02 08.11.2017 # New fields "Default Receipt Bin Code", "Use As Technical Zone"
    // HEI.03 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Fields added: "Purchase Gate Entry Mandatory", "Sales Gate Entry Mandatory", "Transfer Gate Entry Mandatory", "Gate Weighing Mandatory"
    // HEI.04 FDD-CHG2024489 Gate Control IBM SAXENS01 17.09.2019
    //   new field added "Inbound Automatic Registration"
    //   code added on "Gate Weighing Mandatory" field validate
    // version NAVW110.0,HEI.03

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
        modify("Cross-Dock Bin Zone")
        {
            ToolTipML = ENU = 'Specifies if this is a cross-dock zone.', FRA = 'Indique s''il s''agit d''une zone de transbordement.';
        }
        addafter("Cross-Dock Bin Zone")
        {
            field("Use As In-Transit"; Rec."Use As In-Transit FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Use As In-Transit field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Use As In-Transit field.';

            }
            field("Default Receipt Bin Code"; Rec."Default Receipt Bin Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Receipt Bin Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Default Receipt Bin Code field.';

            }
            field("Use As Technical Zone"; Rec."Use As Technical Zone FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Use As Technical Zone field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Use As Technical Zone field.';

            }
            field("Purchase Gate Entry Mandatory"; Rec."Purch. GateEntry Mandatory FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Gate Entry Mandatory field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Purchase Gate Entry Mandatory field.';

            }
            field("Sales Gate Entry Mandatory"; Rec."Sales Gate Entry Mandatory FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Gate Entry Mandatory field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Sales Gate Entry Mandatory field.';

            }
            field("Transfer Gate Entry Mandatory"; Rec."Transf.Gate EntryMandatory FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer Gate Entry Mandatory field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Transfer Gate Entry Mandatory field.';

            }
            field("Gate Weighing Mandatory"; Rec."Gate Weighing Mandatory FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gate Weighing Mandatory field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Gate Weighing Mandatory field.';

                trigger OnValidate();
                begin
                    //HEI.04
                    if Rec."Inbound Auto. Registration FND" then
                        ERROR('Gate Weighing Mandatory can not be enabled with');
                    //HEI.04
                end;
            }
            field("Inbound Automatic Registration"; Rec."Inbound Auto. Registration FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inbound Automatic Registration field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Inbound Automatic Registration field.';

                trigger OnValidate();
                begin
                    //HEI.04
                    if Rec."Gate Weighing Mandatory FND" then
                        ERROR('Inbound automatic registration can not be enabled with');
                    //HEI.04
                end;
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

            //Unsupported feature: Change RunPageLink on ""&Bins"(Action 20)". Please convert manually.

        }
    }
    //BC Upgrade KAPOOV01>>
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //HEI.04
        IF Rec."Gate Weighing Mandatory FND" THEN
            Rec."Inbound Auto. Registration FND" := FALSE;
        //HEI.04
    end;
    //BC Upgrade KAPOOV01<<

    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    //HEI.04
    if "Gate Weighing Mandatory" then
      "Inbound Automatic Registration" :=false;
    //HEI.04
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

