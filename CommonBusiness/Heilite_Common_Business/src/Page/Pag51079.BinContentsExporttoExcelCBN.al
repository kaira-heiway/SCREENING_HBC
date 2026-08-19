page 51079 "BinContentExptoExcelCBN"
{
    // version NAVW110.0,DITW110.00.09,HEI.01

    // HEI.01 CHG2009225 IBM PANDES01 14.08.2019.
    //   # New Page created Bin Contents Report – Export to Excel.
    // HEI.02 IBM.AK CHG2117335 05-07-21
    //  # Factbox-<Lot Numbers by Bin> made Visible(true)

    CaptionML = ENU = 'Bin Contents-Export to Excel',
                FRA = 'Contenu emplacement';
    DataCaptionExpression = DataCaption;
    InsertAllowed = false;
    PageType = List;
    SaveValues = false;
    SourceTable = "Bin Content";
    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists;  // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            group(Options)
            {
                CaptionML = ENU = 'Options',
                            FRA = 'Options';
                field(LocationCode; LocationCode)
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Location Filter',
                                FRA = 'Filtre magasin';
                    ToolTip = 'Specifies the value of the LocationCode field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Location.RESET();
                        Location.SETRANGE("Bin Mandatory", true);
                        if LocationCode <> '' then
                            Location.Code := LocationCode;
                        if PAGE.RUNMODAL(PAGE::"Locations with Warehouse List", Location) = ACTION::LookupOK then begin
                            Location.TESTFIELD("Bin Mandatory", true);
                            LocationCode := Location.Code;
                            DefFilter();
                        end;
                        CurrPage.UPDATE(true);
                    end;

                    trigger OnValidate();
                    begin
                        ZoneCode := '';
                        BinCode := '';
                        if LocationCode <> '' then begin
                            if WMSMgt.LocationIsAllowed(LocationCode) then begin
                                Location.GET(LocationCode);
                                Location.TESTFIELD("Bin Mandatory", true);
                            end else
                                ERROR(Text000, USERID);
                        end;
                        DefFilter();
                        LocationCodeOnAfterValidate();
                    end;
                }
                field(ZoneCode; ZoneCode)
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Zone Filter',
                                FRA = 'Filtre zone';
                    ToolTip = 'Specifies the value of the ZoneCode field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Zone.RESET();
                        if ZoneCode <> '' then
                            Zone.Code := ZoneCode;
                        if LocationCode <> '' then
                            Zone.SETRANGE("Location Code", LocationCode);
                        if PAGE.RUNMODAL(0, Zone) = ACTION::LookupOK then begin
                            ZoneCode := Zone.Code;
                            LocationCode := Zone."Location Code";
                            DefFilter();
                        end;
                        CurrPage.UPDATE(true);
                    end;

                    trigger OnValidate();
                    begin
                        BinCode := '';
                        DefFilter();
                        ZoneCodeOnAfterValidate();
                    end;
                }
                field("<BinCode>"; BinCode)
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    Caption = 'Bin Filter';
                    ToolTip = 'Specifies the value of the Bin Filter field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Bin.RESET();
                        if BinCode <> '' then
                            Bin.Code := BinCode;
                        if LocationCode <> '' then
                            Bin.SETRANGE("Location Code", LocationCode);
                        if ZoneCode <> '' then
                            Bin.SETRANGE("Zone Code", ZoneCode);
                        if PAGE.RUNMODAL(0, Bin) = ACTION::LookupOK then begin
                            BinCode := Bin.Code;
                            LocationCode := Bin."Location Code";
                            ZoneCode := Bin."Zone Code";
                            DefFilter();
                        end;
                        CurrPage.UPDATE(true);
                    end;

                    trigger OnValidate();
                    begin
                        DefFilter();
                        CurrPage.UPDATE(true);
                    end;
                }
                field("<ItemNo>"; ItemNo)
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Item Filter',
                                FRA = 'N° article';
                    ToolTip = 'Specifies the value of the ItemNo field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Item.RESET();
                        if ItemNo <> '' then
                            Item."No." := ItemNo;
                        //IF LocationCode <> '' THEN
                        // Item.SETRANGE("Location Code",LocationCode);
                        if PAGE.RUNMODAL(0, Item) = ACTION::LookupOK then begin
                            ItemNo := Item."No.";
                            //LocationCode := Item."Location Code";
                            DefFilter();
                        end;
                        CurrPage.UPDATE(true);
                    end;

                    trigger OnValidate();
                    begin
                        DefFilter();
                        CurrPage.UPDATE(true);
                    end;
                }
            }
            repeater(Control37)
            {
                Editable = false;
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the location code of the bin.',
                                FRA = 'Spécifie le code du magasin de l''emplacement.';
                    Visible = false;
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the zone code of the bin.',
                                FRA = 'Spécifie le code de la zone de l''emplacement.';
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the bin code.',
                                FRA = 'Spécifie le code de l''emplacement.';

                    trigger OnValidate();
                    begin
                        CheckQty();
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the number of the item that will be stored in the bin.',
                                FRA = 'Spécifie le numéro de l''article à stocker dans cet emplacement.';

                    trigger OnValidate();
                    begin
                        CheckQty();
                    end;
                }
                field("Item Description"; Rec."Item Description FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the Item Description field.';

                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the variant code for the item in the bin.',
                                FRA = 'Spécifie le code variante pour l''article dans l''emplacement.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        CheckQty();
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the unit of measure code of the item in the bin.',
                                FRA = 'Spécifie le code unité de l''article dans l''emplacement.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the number of base units of measure that are in the unit of measure specified for the item in the bin.',
                                FRA = 'Spécifie le nombre d''unités de base qui se trouvent dans l''unité spécifiée pour l''article dans l''emplacement.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        CheckQty();
                    end;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies if the bin is the default bin for the associated item.',
                                FRA = 'Indique si l''emplacement correspond à l''emplacement par défaut de l''article associé.';
                }
                field(Dedicated; Rec.Dedicated)
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies if the bin is used as a dedicated bin, which means that its bin content is available only to certain resources.',
                                FRA = 'Indique si l''emplacement est utilisé comme emplacement dédié, ce qui signifie que son contenu est uniquement disponible à certaines ressources.';
                }
                field("Warehouse Class Code"; Rec."Warehouse Class Code")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the warehouse class code. Only items with the same warehouse class can be stored in this bin.',
                                FRA = 'Spécifie le code classe de l''entrepôt. Seuls les articles ayant la même classe entrepôt peuvent être triés dans cet emplacement.';
                }
                field("Bin Type Code"; Rec."Bin Type Code")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the code of the bin type that was selected for this bin.',
                                FRA = 'Spécifie le code du type emplacement choisi pour cet emplacement.';
                }
                field("Bin Ranking"; Rec."Bin Ranking")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies the bin ranking.',
                                FRA = 'Spécifie le niveau de priorité de l''emplacement.';
                }
                field("Block Movement"; Rec."Block Movement")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how the movement of a particular item, or bin content, into or out of this bin, is blocked.',
                                FRA = 'Spécifie la manière dont le transfert d''un article particulier, ou le contenu de l''emplacement, dans ou en dehors de cet emplacement, est bloqué.';
                }
                field("Min. Qty."; Rec."Min. Qty.")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Indicates the minimum number of units of the item that you want to have in the bin at all times.',
                                FRA = 'Indique le nombre d''unités minimum de cet article que vous souhaitez voir en permanence dans l''emplacement.';
                }
                field("Max. Qty."; Rec."Max. Qty.")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Indicates the maximum number of units of the item that you want to have in the bin.',
                                FRA = 'Indique le nombre maximum d''unités de cet article que vous souhaitez avoir dans l''emplacement.';
                }
                field(CalcQtyUOM; Rec.CalcQtyUOM())
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Quantity',
                                FRA = 'Quantité';
                    DecimalPlaces = 0 : 5;
                    ToolTip = 'Specifies the value of the CalcQtyUOM() field.';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, are stored in the bin.',
                                FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article stockées dans l''emplacement.';
                }
                field("Pick Quantity (Base)"; Rec."Pick Quantity (Base)")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, will be picked from the bin.',
                                FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article prélevées dans l''emplacement.';
                }
                field("ATO Components Pick Qty (Base)"; Rec."ATO Components Pick Qty (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many assemble-to-order units are picked for assembly.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies how many assemble-to-order units are picked for assembly.';

                }
                field("Negative Adjmt. Qty. (Base)"; Rec."Negative Adjmt. Qty. (Base)")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many item units, in the base unit of measure, will be posted on journal lines as negative quantities.',
                                FRA = 'Indique le nombre d''unités d''article, exprimé en unité de base, qui sera validé sur les lignes feuille en tant que quantités négatives.';
                }
                field("Put-away Quantity (Base)"; Rec."Put-away Quantity (Base)")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many units of the item, in the base unit of measure, will be put away in the bin.',
                                FRA = 'Indique le nombre d''unités de mesure de l''article contenues dans une unité de mesure de l''article rangées dans l''emplacement.';
                }
                field("Positive Adjmt. Qty. (Base)"; Rec."Positive Adjmt. Qty. (Base)")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies how many item units, in the base unit of measure, will be posted on journal lines as positive quantities.',
                                FRA = 'Indique le nombre d''unités d''article, exprimé en unité de base, qui sera validé sur les lignes feuille en tant que quantités positives.';
                }
                field(CalcQtyAvailToTakeUOM; Rec.CalcQtyAvailToTakeUOM())
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Available Qty. to Take',
                                FRA = 'Qté disponible pour prélèv.';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the quantity of the item that is available in the bin.',
                                FRA = 'Spécifie la quantité de l''article disponible dans l''emplacement.';
                }
                field("Fixed"; Rec.Fixed)
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies that the item (bin content) has been associated with this bin, and that the bin should normally contain the item.',
                                FRA = 'Indique que l''article (contenu de l''emplacement) a été associé à cet emplacement et que ce dernier doit normalement contenir l''article.';
                }
                field("Cross-Dock Bin"; Rec."Cross-Dock Bin")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Specifies if the bin content is in a cross-dock bin.',
                                FRA = 'Indique si le contenu de l''emplacement est considéré comme étant un emplacement de transbordement.';
                }
                field("Available Inv. (Whse)"; Rec."Available Inv. (Whse) FND")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<   
                    Visible = false;
                    ToolTip = 'Specifies the value of the Available Inv. (Whse) field.';
                }
                field("Quantity Quality Hold (Base)"; Rec."Quantity Unrestrict (Base) FND")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity Quality Hold (Base) field.';
                }
                field("Quantity Unrestricted (Base)"; Rec."Quantity Unrestrict (Base) FND")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity Unrestricted (Base) field.';
                }
                field("Quantity Blocked (Base)"; Rec."Quantity Blocked (Base) FND")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity Blocked (Base) field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Lot Numbers by Bin FactBox")
            {
                ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                SubPageLink = "Item No." = FIELD("Item No."),
                              "Variant Code" = FIELD("Variant Code"),
                              "Location Code" = FIELD("Location Code");
                Visible = true;  //BC Upgrade Kamnay01>> HEI.02
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            FRA = '&Ligne';
                Image = Line;
                action("Warehouse Entries")
                {
                    ApplicationArea = All;  // BC Upgrade SHUKLP03 <<
                    CaptionML = ENU = 'Warehouse Entries',
                                FRA = 'Écritures entrepôt';
                    Image = BinLedger;
                    RunObject = Page "Warehouse Entries";
                    RunPageLink = "Item No." = FIELD("Item No."),
                                  "Location Code" = FIELD("Location Code"),
                                  "Bin Code" = FIELD("Bin Code"),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = sorting("Item No.", "Bin Code", "Location Code", "Variant Code");
                    ToolTip = 'Executes the Warehouse Entries action.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        Rec.GetItemDescr(Rec."Item No.", Rec."Variant Code", ItemDescription);
        DataCaption := STRSUBSTNO('%1 ', Rec."Bin Code");
    end;

    trigger OnOpenPage();
    begin
        ItemDescription := '';
        Rec.GetWhseLocation(LocationCode, ZoneCode);
    end;

    var
        Bin: Record Bin;
        Item: Record Item;
        AdjmtLocation: Record Location;
        Location: Record Location;
        Zone: Record Zone;
        WMSMgt: Codeunit "WMS Management";
        LocationCode: Code[10];
        ZoneCode: Code[10];
        BinCode: Code[20];
        ItemNo: Code[20];
        ItemDescription: Text[50];
        DataCaption: Text[80];
        LocFilter: Text[250];
        Text000: TextConst ENU = 'Location code is not allowed for user %1.', FRA = 'L''utilisateur %1 n''est pas autorisé à utiliser ce code magasin.';

    local procedure DefFilter();
    begin
        Rec.FILTERGROUP := 2;
        if LocationCode <> '' then
            Rec.SETRANGE("Location Code", LocationCode)
        else begin
            CLEAR(LocFilter);
            CLEAR(Location);
            Location.SETRANGE("Bin Mandatory", true);
            if Location.FIND('-') then
                repeat
                    if WMSMgt.LocationIsAllowed(Location.Code) then
                        LocFilter := LocFilter + Location.Code + '|';
                until Location.NEXT() = 0;
            if STRLEN(LocFilter) <> 0 then
                LocFilter := COPYSTR(LocFilter, 1, (STRLEN(LocFilter) - 1));
            Rec.SETFILTER("Location Code", LocFilter);
        end;
        if ZoneCode <> '' then
            Rec.SETRANGE("Zone Code", ZoneCode)
        else
            Rec.SETRANGE("Zone Code");
        if BinCode <> '' then
            Rec.SETRANGE("Bin Code", BinCode)
        else
            Rec.SETRANGE("Bin Code");
        if ItemNo <> '' then
            Rec.SETRANGE("Item No.", ItemNo)
        else
            Rec.SETRANGE("Item No.");
        Rec.FILTERGROUP := 0;
    end;

    local procedure CheckQty();
    begin
        Rec.TESTFIELD(Quantity, 0);
        Rec.TESTFIELD("Pick Qty.", 0);
        Rec.TESTFIELD("Put-away Qty.", 0);
        Rec.TESTFIELD("Pos. Adjmt. Qty.", 0);
        Rec.TESTFIELD("Neg. Adjmt. Qty.", 0);
    end;

    local procedure LocationGet(LocationCode: Code[10]);
    begin
        if AdjmtLocation.Code <> LocationCode then
            AdjmtLocation.GET(LocationCode);
    end;

    local procedure LocationCodeOnAfterValidate();
    begin
        CurrPage.UPDATE(true);
    end;

    local procedure ZoneCodeOnAfterValidate();
    begin
        CurrPage.UPDATE(true);
    end;
}

