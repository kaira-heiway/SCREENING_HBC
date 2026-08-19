page 54021 "Released Production Orders MRC"
{
    // version NAVW110.0,MANXL10.01,DITW110.00.12A,HEI.02
    //BC Upgrade Kamnay01 Original(Heilite) page id 50431
    // HEI.01 CHG2089898 IBM POENAB02 15.12.2020 Role Centre Production Bottling Role Centre
    //  # Object created
    // HEI.02 CHG2098891 IBM.LS      19.07.2021
    //   # Added Field - Blocked (Caption: Admin. Completed)
    //   # Moved Field - Blocked after No.

    //Bc Upgrade YADAVM09 Caption added for field Blocked.
    //Bc Upgrade YADAVM09 Drink it field and code commented.
    //Bc Upgrade YADAVM09 AutoFormatExpression property adjusted as per AL.
    //Bc Upgrade YADAVM09 Lot No Property AutoFormatExpression is Blocked as this property can be used for the decimal type field.
    //Bc Upgrade YADAVM09 Caption ML change for page.

    //CaptionML = ENU = 'Released Production Orders',
    // FRA = 'O.F. lancés';//Bc Upgrade YADAVM09 
    CaptionML = ENU = 'Released Production Orders MRC',//Bc Upgrade YADAVM09 
                FRA = 'O.F. lancés';
    CardPageID = "Released Production Order";
    Editable = false;
    ApplicationArea = all;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Released));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Lookup = false;
                    ToolTipML = ENU = 'Specifies the number of the production order.',
                                FRA = 'Spécifie le numéro de l''ordre de fabrication.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = all;
                    Caption = 'Admin. Completed';
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Gyle No."; "Gyle No.")
                {
                    CaptionML = ENU = 'Ref No.',
                                FRA = 'Gyle N°';
                }
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the source number of the production order.',
                                FRA = 'Spécifie le numéro origine de l''ordre de fabrication.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the description of the production order.',
                                FRA = 'Spécifie la description de l''ordre de fabrication.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies how many units of the item or the family to produce (production quantity).',
                                FRA = 'Spécifie le nombre d''unités de l''article ou de la famille produits à produire (quantité de production).';
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                }
                field("Quantity HL"; "Quantity HL")
                {
                }
                field(decPlannedQty; decPlannedQty)
                {
                    CaptionML = ENU = 'Planned Quantity',
                                FRA = 'Quantité planifiée';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                }
                 */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field("Bin Code"; Rec."Bin Code")
                {
                    TableRelation = "Bin".Code WHERE("Location Code" = FIELD("Location Code"), "Zone Code" = FIELD("Zone Code FND"));

                    ToolTipML = ENU = 'Specifies a bin to which you want to post the finished items.',
                                FRA = 'Spécifie un emplacement sur lequel vous souhaitez valider les articles terminés.';

                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("<decFinishedQty>"; decFinishedQty)
                {
                    Caption = 'Finished Quantity';
                    DecimalPlaces = 0 : 5;
                    Description = 'NRQ#72678';
                    Editable = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field("EXT.[%w/w] (Actual)"; ILEStrengthSpecValue)
                {
                    ApplicationArea = all;
                }
                field("Lot Not"; LotNo)
                {
                    //AutoFormatExpression = 1;//Bc Upgrade YADAVM09 Block as this property can be used for the decimal type.
                    AutoFormatType = 1;
                    Width = 15;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the routing number used for this production order.',
                                FRA = 'Spécifie le numéro gamme utilisé pour cet ordre de fabrication.';
                    Visible = false;
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Routing Version Code"; Rec."Routing Version Code")
                {
                }
                field("Routing Version Description"; Rec."Routing Version Description")
                {
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    Visible = false;
                }
                field("Production BOM Version Code"; Rec."Production BOM Version Code")
                {
                }
                field("Production BOM Version Desc."; Rec."Production BOM Version Desc.")
                {
                }
                */ // Bc Upgrade YADAVM09 Drink it field commented<<
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTipML = ENU = 'Specifies the code for the dimension associated with the production order.',
                                FRA = 'Spécifie le code de la section analytique associée à l''ordre de fabrication.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTipML = ENU = 'Specifies the code for the dimension associated with the production order.',
                                FRA = 'Spécifie le code de la section analytique associée à l''ordre de fabrication.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTipML = ENU = 'Specifies the location code to which you want to post the finished product from this production order.',
                                FRA = 'Spécifie le code magasin sur lequel le produit fini doit être validé à partir de cet ordre de fabrication.';
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the starting date of the production order.',
                                FRA = 'Spécifie la date de début de l''ordre de fabrication.';
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the starting time of the production order.',
                                FRA = 'Spécifie l''heure de début de l''ordre de fabrication.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the ending date of the production order.',
                                FRA = 'Spécifie la date de fin de l''ordre de fabrication.';
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the ending time of the production order.',
                                FRA = 'Spécifie l''heure de fin de l''ordre de fabrication.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the due date of the production order.',
                                FRA = 'Spécifie la date d''échéance de l''ordre de fabrication.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.',
                                FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the actual finishing date of a finished production order.',
                                FRA = 'Spécifie la date de réalisation réelle d''un ordre de fabrication terminé.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the status of the production order.',
                                FRA = 'Spécifie le statut de l''ordre de fabrication.';
                    Visible = false;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the search description.',
                                FRA = 'Spécifie la description de recherche.';
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies when the production order card was last modified.',
                                FRA = 'Indique la date à laquelle la fiche ordre de fabrication a été modifiée pour la dernière fois.';
                    Visible = false;
                }
                field("Zone Code"; Rec."Zone Code FND")
                {
                    Visible = false;
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field(decActualVsPlannedQty; decActualVsPlannedQty)
                {
                    CaptionML = ENU = 'Actual Produced Quantity',
                                FRA = 'Quantité actuelle';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTipML = ENU = 'Actual Produced Quantity',
                                FRA = 'Quantité actuelle';
                    Visible = false;
                }
                field(decPlannedOperations; decPlannedOperations)
                {
                    CaptionML = ENU = 'Planned Operations',
                                FRA = 'Opérations plannifiés';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                    Visible = false;
                }
                field(decActualVsPlannedOperations; decActualVsPlannedOperations)
                {
                    CaptionML = ENU = 'Actual Executed Operations',
                                FRA = 'Opérations actuelles';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTipML = ENU = 'Actual Executed Operations',
                                FRA = 'Opérations actuelles';
                    Visible = false;
                }
                field(decPlannedHours; decPlannedHours)
                {
                    CaptionML = ENU = 'Planned Operation Hours',
                                FRA = 'Heures d''opérations plannifiées';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                    Visible = false;
                }
                field(decActualVsPlannedHours; decActualVsPlannedHours)
                {
                    CaptionML = ENU = 'Actual Consumed Hours',
                                FRA = 'Heures d''opérations actuelles';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTipML = ENU = 'Actual Consumed Hours',
                                FRA = 'Heures d''opérations actuelles';
                    Visible = false;
                }
                field(decPlannedSubcontract; decPlannedSubcontract)
                {
                    CaptionML = ENU = 'Planned Subcontractor Tasks',
                                FRA = 'Tâches du sous-traitant plannifiées';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                    Visible = false;
                }
                field(decActualVsPlannedSubcontract; decActualVsPlannedSubcontract)
                {
                    CaptionML = ENU = 'Ordered Subcontractor Tasks',
                                FRA = 'Tâches du sous-traitant ordonnées';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTipML = ENU = 'Ordered Subcontractor Tasks',
                                FRA = 'Tâches du sous-traitant ordonnées';
                    Visible = false;
                }
                field(decPlannedCritical; decPlannedCritical)
                {
                    CaptionML = ENU = 'Planned Critical Components',
                                FRA = 'Composants critique plannifiés';
                    DecimalPlaces = 0 : 5;
                    Description = 'MANXL7.00.001';
                    Editable = false;
                    Visible = false;
                }
                field(decActualVsPlannedCritical; decActualVsPlannedCritical)
                {
                    CaptionML = ENU = 'Critical Components Available',
                                FRA = 'Composants critique disponibles';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTipML = ENU = 'Critical Components Available',
                                FRA = 'Composants critique disponibles';
                    Visible = false;
                }
                field(decExpectedVsActualCost; decExpectedVsActualCost)
                {
                    CaptionML = ENU = 'Expected Cost vs Actual Cost',
                                FRA = 'Coût prévu vs coût réel';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTipML = ENU = 'Expected Cost vs Actual Cost',
                                FRA = 'Coût prévu vs coût réel';
                    Visible = false;
                }
                field(decStandardVsExpectedCost; decStandardVsExpectedCost)
                {
                    CaptionML = ENU = 'Standard Cost vs Expected Cost',
                                FRA = 'Coût standard vs coût prévu';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTipML = ENU = 'Standard Cost vs Expected Cost',
                                FRA = 'Coût standard vs coût prévu';
                    Visible = false;
                }
                field(decStandardVsActualCost; decStandardVsActualCost)
                {
                    CaptionML = ENU = 'Standard Cost vs Actual Cost',
                                FRA = 'Coût standard vs coût réel';
                    Description = 'MANXL7.00.001';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                    MinValue = 0;
                    ToolTipML = ENU = 'Standard Cost vs Actual Cost',
                                FRA = 'Coût standard vs coût réel';
                    Visible = false;
                }
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
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field("Created By"; Rec."Created By FND")
                {
                    ApplicationArea = all;
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
                /* //Bc Upgrade YADAVM09 Drink it action commented>>
                
                separator(Separator1100910002)
                {
                }
                action(Losses)
                {
                    CaptionML = ENU = 'Losses',
                                FRA = 'Pertes';
                    Image = GainLossEntries;

                    trigger OnAction();
                    var
                        CapacityLedgerEntry: Record "Capacity Ledger Entry";
                        BrewingLosses: Page "Brewing Losses";
                    begin
                        // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                        // <<DITW17.00.01 KCO 18/03/2013 DIT-770 #001
                        CapacityLedgerEntry.SETRANGE("Order Type", CapacityLedgerEntry."Order Type"::Production);
                        CapacityLedgerEntry.SETRANGE("Order No.", "No.");
                        // >>DITW17.00.01 KCO DIT-770 #001
                        BrewingLosses.SETTABLEVIEW(CapacityLedgerEntry);
                        BrewingLosses.RUNMODAL;
                        // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
                    end;
                }*/ //Bc Upgrade YADAVM09 Drink it action commented<<
            }

        }
        area(processing)
        {
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                Image = "Action";
                action("Change &Status")
                {
                    CaptionML = ENU = 'Change &Status',
                                FRA = 'Changer &statut';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Prod. Order Status Management";
                }
                action("&Update Unit Cost")
                {
                    CaptionML = ENU = '&Update Unit Cost',
                                FRA = '&Mise à jour coût unitaire';
                    Ellipsis = true;
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, Rec.Status);
                        ProdOrder.SETRANGE("No.", Rec."No.");

                        REPORT.RUNMODAL(REPORT::"Update Unit Cost", true, true, ProdOrder);
                    end;
                }
                action("Create Inventor&y Put-away/Pick/Movement")
                {
                    CaptionML = ENU = 'Create Inventor&y Put-away/Pick/Movement',
                                FRA = 'Créer rangement/prélèvement/mouvement stoc&k';
                    Ellipsis = true;
                    Image = CreatePutAway;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();
                    end;
                }
                /* //Bc Upgrade YADAVM09 Drink it action>>
                action("Print SSCC")
                {
                    CaptionML = ENU = 'Print SSCC',
                                FRA = 'Imprimer SSCC';

                    trigger OnAction();
                    var
                        lfrmPrintLabels: Page "Print Labels";
                    begin
                        // <<DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                        lfrmPrintLabels.SetProdOrder(Rec);
                        lfrmPrintLabels.RUNMODAL();
                        // >>DITW16.00.00.43 RBE DIT-715 #806
                    end;
                }
                separator(Separator1100910001)
                {
                }
                action("Register Loss Strength Journal")
                {
                    CaptionML = ENU = 'Register Loss Strength Journal',
                                FRA = 'Valider journal perte contrainte';
                    Ellipsis = true;
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        // <<DITW19.00.08 DDR 20/10/2016 BL#10443
                        OpenLossOutputJournal;
                    end;
                }
                */ //Bc Upgrade YADAVM09 Drink it action<<
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
                PromotedCategory = "Report";
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
                    //  REPORT.RUN(50003, true, true, ProductionOrder);
                    Report.Run(report::"Process Order Goods Movement", true, true, ProductionOrder);

                    //HEI.01<<
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        /* //Bc Upgrade YADAVM09 Drink it code commented>>
        if rMANXLSetup.READPERMISSION then begin

            decActualVsPlannedQty := fctCalcQuantityPlannedVsAct(decPlannedQty, decFinishedQty);

            decActualVsPlannedOperations := fctCalcOperationsPlannedVsAct(decPlannedOperations);
            decActualVsPlannedHours := fctCalcHoursPlannedVsAct(decPlannedHours);
            decActualVsPlannedSubcontract := fctCalcSubcontrPlannedVsAct(decPlannedSubcontract);
            decActualVsPlannedCritical := fctCalcCriticalPlannedVsAct(decPlannedCritical);
            fctCalcStatisticalInfo(decActualCost, decStandardCost, decExpectedCost, decStandardVsActualCost, decStandardVsExpectedCost,
                                   decExpectedVsActualCost);

        end;
        */ //Bc Upgrade YADAVM09 Drink it code commented<<
        LotNo := HeinekenGlobal.GetLotItemTracking(Rec."No.");

        //ILEStrengthSpecValue := HeinekenGlobal.GetStrengthSpecValue("No.");/* Bc Upgrade YADAVM09 Dependency in drink it field
    end;

    /* //Bc Upgrade YADAVM09 Drink it code>>
        trigger OnNewRecord(BelowxRec: Boolean);
        begin
            if rMANXLSetup.READPERMISSION then begin
                decActualVsPlannedQty := 0;
                decPlannedQty := 0;
                decFinishedQty := 0;
                decActualVsPlannedOperations := 0;
                decPlannedOperations := 0;
                decActualVsPlannedHours := 0;
                decPlannedHours := 0;
                decActualVsPlannedSubcontract := 0;
                decPlannedSubcontract := 0;
                decActualVsPlannedCritical := 0;
                decPlannedCritical := 0;
                decActualCost := 0;
                decStandardCost := 0;
                decExpectedCost := 0;
                decStandardVsActualCost := 0;
                decStandardVsExpectedCost := 0;
                decExpectedVsActualCost := 0;
            end;
        end;
        */ //Bc Upgrade YADAVM09 Drink it code<<

    trigger OnOpenPage();
    begin
        //Rec.SetSecurityFilterOnRespCenter();//Bc Upgrade YADAVM09 Drink it function

        TileRespCenterFilter := Rec.GETFILTER("Role Centre Tile Code FND");
        if TileRespCenterFilter <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Role Centre Tile Code FND", TileRespCenterFilter);
            Rec.FILTERGROUP(0);
        end;
    end;

    var
        UserMgt: Codeunit "User Setup Management";
        decPlannedQty: Decimal;
        decFinishedQty: Decimal;
        decActualVsPlannedQty: Decimal;
        decPlannedOperations: Decimal;
        decActualVsPlannedOperations: Decimal;
        decPlannedHours: Decimal;
        decActualVsPlannedHours: Decimal;
        decPlannedSubcontract: Decimal;
        decActualVsPlannedSubcontract: Decimal;
        decPlannedCritical: Decimal;
        decActualVsPlannedCritical: Decimal;
        decActualCost: Decimal;
        decStandardCost: Decimal;
        decExpectedCost: Decimal;
        decStandardVsActualCost: Decimal;
        decStandardVsExpectedCost: Decimal;
        decExpectedVsActualCost: Decimal;
        //rMANXLSetup: Record "Manufacturing XL Setup";//Bc Upgrade YADAVM09 Drink it object
        ManuPrintReport: Codeunit "Manu. Print Report";
        LotNo: Text[50];
        HeinekenGlobal: Codeunit "Heineken Global";
        TileRespCenterFilter: Text;
        ILEStrengthSpecValue: Code[10];
}

