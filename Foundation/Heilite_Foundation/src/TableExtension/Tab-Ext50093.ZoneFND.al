tableextension 50093 ZoneExtFND extends Zone
{
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added FIELDS Use As In-Transit
    //   #Changed Lookup Page ID with Zone List WH

    // HEI.02 FDD-PURGAPINT002 IBM LAZARE02 08.11.2017 # New field "Default Receipt Bin Code", "Use As Technical Zone"
    // HEI.03 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50003 - Purchase Gate Entry Mandatory
    //                        50004 - Sales Gate Entry Mandatory
    //                        50005 - Transfer Gate Entry Mandatory
    //                        50006 - Gate Weighing Mandatory
    // HEI.05 FDD_CHG2030239 FA Master Data IBM  SAXENS01 17.09.2019
    //   # New Field created: 50007 - Inbound Automatic Registration
    // version NAVW18.00,HEI.02

    fields
    {
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Bin Type Code")
        {
            CaptionML = ENU = 'Bin Type Code', FRA = 'Code type emplacement';
        }
        modify("Warehouse Class Code")
        {
            CaptionML = ENU = 'Warehouse Class Code', FRA = 'Code classe entrepôt';
        }
        modify("Special Equipment Code")
        {
            CaptionML = ENU = 'Special Equipment Code', FRA = 'Code équipement spécial';
        }
        modify("Zone Ranking")
        {
            CaptionML = ENU = 'Zone Ranking', FRA = 'Priorité zone';
        }
        modify("Cross-Dock Bin Zone")
        {
            CaptionML = ENU = 'Cross-Dock Bin Zone', FRA = 'Transborder zone emplacement';
        }
        field(50000; "Use As In-Transit FND"; Boolean)
        {
            Description = 'HEI.01 PRDGAP024';
            Caption = 'Use As In-Transit';
        }
        field(50001; "Default Receipt Bin Code FND"; Code[20])
        {
            Caption = 'Default Receipt Bin Code';
            Description = 'HEI.02';
            TableRelation = Bin.Code where("Location Code" = FIELD("Location Code"),
                                            "Zone Code" = FIELD(Code));

            trigger OnValidate();
            var
                Bin: Record Bin;
            begin
            end;
        }
        field(50002; "Use As Technical Zone FND"; Boolean)
        {
            Caption = 'Use As Technical Zone';
            Description = 'HEI.02';
        }
        field(50003; "Purch. GateEntry Mandatory FND"; Boolean)
        {
            Caption = 'Purchase Gate Entry Mandatory';
            Description = 'HEI.03';
        }
        field(50004; "Sales Gate Entry Mandatory FND"; Boolean)
        {
            Caption = 'Sales Gate Entry Mandatory';
            Description = 'HEI.03';
        }
        field(50005; "Transf.Gate EntryMandatory FND"; Boolean)
        {
            Description = 'HEI.03';
            Caption = 'Transfer Gate Entry Mandatory';
        }
        field(50006; "Gate Weighing Mandatory FND"; Boolean)
        {
            Caption = 'Gate Weighing Mandatory';
            Description = 'HEI.03';
        }
        field(50007; "Inbound Auto. Registration FND"; Boolean)
        {
            Caption = 'Inbound Automatic Registration';
            Description = 'HEI.05';

            trigger OnValidate();
            begin
                //HEI.05
                if "Gate Weighing Mandatory FND" then
                    ERROR('Inbound automatic Registration can not be enabled with');
                //HEI.05
            end;
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Bin.SETCURRENTKEY("Location Code","Zone Code");
    Bin.SETRANGE("Location Code","Location Code");
    Bin.SETRANGE("Zone Code",Code);
    Bin.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    Bin.DELETEALL(true);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: InsertAfter on "(FieldGroup: DropDown)". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

