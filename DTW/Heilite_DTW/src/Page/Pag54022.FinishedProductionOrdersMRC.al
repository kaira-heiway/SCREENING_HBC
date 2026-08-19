page 54022 "Finished Production Orders MRC"
{
    // version NAVW110.0,DITW110.00.12A,HEI.01
    //BC Upgrade Kamnay01 Original(Heilite) page id 50432
    // HEI.01 CHG2089898 IBM POENAB02 15.12.2020 Role Centre Production Bottling Role Centre
    //  # Object created
    // HEI.02 CHG2098891 IBM.LS      19.07.2021
    //   # Added Field - Blocked (Caption: Admin. Completed)
    //   # Moved Field - Blocked after No.

    //Bc Upgrade YADAVM09 Blocked caption added.
    //Bc Upgrade YADAVM09 Drink it field and code blocked.
    //Bc Upgrade YADAVM09 Promoted property changes false to true.
    // #Prod. Order - Detail Calc.
    // #Prod. Order - Precalc. Time
    // #Production Order - Picking List
    // #Production Order Job Card


    CaptionML = ENU = 'Finished Production Orders',
                FRA = 'O.F. terminés';
    CardPageID = "Finished Production Order";
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Finished));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    Lookup = false;
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the number of the production order.',
                                FRA = 'Spécifie le numéro de l''ordre de fabrication.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Admin. Completed';
                    ApplicationArea = All;
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Gyle No.";"Gyle No.")
                {
                    CaptionML = ENU='Ref No.',
                                FRA='Gyle N°';
                }
                 */ //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = ALl;
                    ToolTipML = ENU = 'Specifies the source number of the production order.',
                                FRA = 'Spécifie le numéro origine de l''ordre de fabrication.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the description of the production order.',
                                FRA = 'Spécifie la description de l''ordre de fabrication.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies how many units of the item or the family to produce (production quantity).',
                                FRA = 'Spécifie le nombre d''unités de l''article ou de la famille produits à produire (quantité de production).';
                }
                field("EXT.[%w/w] (Actual)"; ILEStrengthSpecValue)
                {
                    ApplicationArea = All;
                }
                /* //Bc Upgrade YADAVM09 Drink it fields>>
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                }
                field("Quantity HL"; "Quantity HL")
                {
                }
                */ //Bc Upgrade YADAVM09 Drink it fields<<
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies a bin to which you want to post the finished items.',
                                FRA = 'Spécifie un emplacement sur lequel vous souhaitez valider les articles terminés.';
                }
                /* // Bc Upgrade YADAVM09 Drink it field commented>>
                field("<decFinishedQty>"; decFinishedQty)
                {
                    Caption = 'Finished Quantity';
                    DecimalPlaces = 0 : 5;
                    Description = 'NRQ#84282';
                    Editable = false;
                }
                 */ // Bc Upgrade YADAVM09 Drink it field commented<<
                field("Lot No"; LotNo)
                {
                    ApplicationArea = ALl;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the routing number used for this production order.',
                                FRA = 'Spécifie le numéro gamme utilisé pour cet ordre de fabrication.';
                    Visible = false;
                }
                /* //Bc Upgrade YADAVM09 Drink it field Commented>>
                field("Routing Version Code"; Rec."Routing Version Code")
                {
                }
                field("Routing Version Description"; Rec."Routing Version Description")
                {
                }
                field("Production BOM No."; "Production BOM No.")
                {
                    Visible = false;
                }
                field("Production BOM Version Code"; "Production BOM Version Code")
                {
                }
                field("Production BOM Version Desc."; "Production BOM Version Desc.")
                {
                }
                 */ //Bc Upgrade YADAVM09 Drink it field Commented<<
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the code for the dimension associated with the production order.',
                                FRA = 'Spécifie le code de la section analytique associée à l''ordre de fabrication.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the code for the dimension associated with the production order.',
                                FRA = 'Spécifie le code de la section analytique associée à l''ordre de fabrication.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the location code to which you want to post the finished product from this production order.',
                                FRA = 'Spécifie le code magasin sur lequel le produit fini doit être validé à partir de cet ordre de fabrication.';
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the starting date of the production order.',
                                FRA = 'Spécifie la date de début de l''ordre de fabrication.';
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the starting time of the production order.',
                                FRA = 'Spécifie l''heure de début de l''ordre de fabrication.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the ending date of the production order.',
                                FRA = 'Spécifie la date de fin de l''ordre de fabrication.';
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the ending time of the production order.',
                                FRA = 'Spécifie l''heure de fin de l''ordre de fabrication.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the due date of the production order.',
                                FRA = 'Spécifie la date d''échéance de l''ordre de fabrication.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.',
                                FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the actual finishing date of a finished production order.',
                                FRA = 'Spécifie la date de réalisation réelle d''un ordre de fabrication terminé.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the status of the production order.',
                                FRA = 'Spécifie le statut de l''ordre de fabrication.';
                    Visible = false;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the search description.',
                                FRA = 'Spécifie la description de recherche.';
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies when the production order card was last modified.',
                                FRA = 'Indique la date à laquelle la fiche ordre de fabrication a été modifiée pour la dernière fois.';
                    Visible = false;
                }
                field("Zone Code"; Rec."Zone Code FND")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Responsibility Center"; "Responsibility Center")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    Visible = false;
                }
                field("Physical Location Group Code"; "Physical Location Group Code")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    Visible = false;
                }
                 */ //Bc Upgrade YADAVM09 Drink it field commented
                field("Created By"; Rec."Created By FND")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Pro&d. Order")
            {
                CaptionML = ENU = 'Pro&d. Order',
                            FRA = '&O.F.';
                Image = "Order";
                group("E&ntries")
                {
                    CaptionML = ENU = 'E&ntries',
                                FRA = 'É&critures';
                    Image = Entries;
                    action("Item Ledger E&ntries")
                    {
                        CaptionML = ENU = 'Item Ledger E&ntries',
                                    FRA = 'É&critures comptables article';
                        Image = ItemLedger;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("Capacity Ledger Entries")
                    {
                        CaptionML = ENU = 'Capacity Ledger Entries',
                                    FRA = 'Écritures comptables capacité';
                        Image = CapacityLedger;
                        RunObject = Page "Capacity Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("Value Entries")
                    {
                        CaptionML = ENU = 'Value Entries',
                                    FRA = 'Écritures valeur';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                    }
                    action("&Warehouse Entries")
                    {
                        CaptionML = ENU = '&Warehouse Entries',
                                    FRA = 'Écritures &entrepôt';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Source Type" = FILTER(83 | 5407),
                                      "Source Subtype" = FILTER(3 | 4 | 5),
                                      "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.");
                    }
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status = FIELD(Status),
                                  "Prod. Order No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                separator(Separator31)
                {
                }
                action(Statistics)
                {
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Production Order Statistics";
                    RunPageLink = Status = FIELD(Status),
                                  "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'F7';
                }
            }
        }
        area(reporting)
        {
            action("Prod. Order - Detail Calc.")
            {
                CaptionML = ENU = 'Prod. Order - Detail Calc.',
                            FRA = 'O. F. - Calc. détail';
                Image = "Report";
                //Promoted = false;//Bc Upgrade YADAVM09
                Promoted = true;//Bc Upgrade YADAVM09
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Detailed Calc.";
            }
            action("Prod. Order - Precalc. Time")
            {
                CaptionML = ENU = 'Prod. Order - Precalc. Time',
                            FRA = 'O.F. - Temps théoriques';
                Image = "Report";
                //Promoted = false;//Bc Upgrade YADAVM09
                Promoted = true;//Bc Upgrade YADAVM09
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Precalc. Time";
            }
            action("Production Order - Comp. and Routing")
            {
                CaptionML = ENU = 'Production Order - Comp. and Routing',
                            FRA = 'Ordre de fabrication - Composant et gamme';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order Comp. and Routing";
            }
            action(ProdOrderJobCard)
            {
                CaptionML = ENU = 'Production Order Job Card',
                            FRA = 'Ordre de fabrication - fiche suiveuse';
                Image = "Report";
                //Promoted = false;//Bc Upgrade YADAVM09
                Promoted = true;//Bc Upgrade YADAVM09
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                PromotedCategory = "Report";

                trigger OnAction();
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 0);
                end;
            }
            action("Production Order - Picking List")
            {
                CaptionML = ENU = 'Production Order - Picking List',
                            FRA = 'Ordre de fabrication - Liste des prélèvements';
                Image = "Report";
                //Promoted = false;//Bc Upgrade YADAVM09
                Promoted = true;//Bc Upgrade YADAVM09
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Picking List";
            }
            action(ProdOrderMaterialRequisition)
            {
                CaptionML = ENU = 'Production Order - Material Requisition',
                            FRA = 'Ordre de fabrication - Besoin matière';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction();
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 1);
                end;
            }
            action("Production Order List")
            {
                CaptionML = ENU = 'Production Order List',
                            FRA = 'Liste des O.F.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order - List";
            }
            action(ProdOrderShortageList)
            {
                CaptionML = ENU = 'Production Order - Shortage List',
                            FRA = 'Ordre de fabrication - Liste des ruptures';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction();
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 2);
                end;
            }
            action("Production Order Statistics")
            {
                CaptionML = ENU = 'Production Order Statistics',
                            FRA = 'Statistiques O.F.';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Production Order Statistics";
            }
            action(ProcessOrderGoodsMovement)
            {
                Caption = 'Process Order Goods Movement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction();
                var
                    ProductionOrder: Record "Production Order";
                begin
                    //HEI.01>>
                    ProductionOrder.RESET();
                    ProductionOrder.SETRANGE(ProductionOrder.Status, Rec.Status);
                    ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
                    // REPORT.RUN(50003, true, true, ProductionOrder);
                    Report.Run(report::"Process Order Goods Movement", true, true, ProductionOrder);

                    //HEI.01<<
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        LotNo := HeinekenGlobal.GetLotItemTracking(Rec."No.");

        //decFinishedQty := fctCalcQuantityFinished();//Bc Upgrade YADAVM09 Drink it function

        //ILEStrengthSpecValue := HeinekenGlobal.GetStrengthSpecValue("No.");//Bc Upgrade YADAVM09 Dependency on Drink it field
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        decFinishedQty := 0;
    end;

    trigger OnOpenPage();
    begin
        //SetSecurityFilterOnRespCenter();//Bc Upgrade Drink it function

        TileRespCenterFilter := Rec.GETFILTER("Role Centre Tile Code FND");
        if TileRespCenterFilter <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Role Centre Tile Code FND", TileRespCenterFilter);
            Rec.FILTERGROUP(0);
        end;
    end;

    var
        ManuPrintReport: Codeunit "Manu. Print Report";
        UserMgt: Codeunit "User Setup Management";
        decFinishedQty: Decimal;
        LotNo: Text[50];
        HeinekenGlobal: Codeunit "Heineken Global";
        TileRespCenterFilter: Text;
        ILEStrengthSpecValue: Code[10];
}

