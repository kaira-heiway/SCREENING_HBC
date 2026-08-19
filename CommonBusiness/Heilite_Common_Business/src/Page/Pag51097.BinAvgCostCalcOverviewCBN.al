page 51097 "BinAvgCostCalcOverviewCBN"
{
    // version NAVW110.0

    // HEI.01 HT1615 BULIMC01 IBM 27.10.2020 #new page created for Bin Content Analysis report

    CaptionML = ENU = 'Average Cost Calc. Overview',
                FRA = 'Aperçu calc. coût moyen';
    DataCaptionExpression = ItemName;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Average Cost Calc. Overview";
    SourceTableTemporary = true;
    SourceTableView = sorting("Attached to Valuation Date", "Attached to Entry No.", Type);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = TypeIndent;
                IndentationControls = Type;
                ShowAsTree = true;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = 'Strong';
                    ToolTipML = ENU = 'Specifies either that the entry is a summary entry, Closing Entry, or the type that was used in the calculation of the average cost of the item.',
                                FRA = 'Indique que l''écriture est soit une écriture récapitulative (écriture clôture), soit une écriture du type de celle utilisée dans le calcul du coût moyen de l''article.';
                }
                field("Valuation Date"; Rec."Valuation Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = 'Strong';
                    ToolTipML = ENU = 'Specifies the valuation date associated with the average cost calculation.',
                                FRA = 'Spécifie la date d''évaluation associée au calcul du coût moyen.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the number of the item associated with the entry.',
                                FRA = 'Spécifie le numéro de l''article associé à l''écriture.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the location code associated with the entry.',
                                FRA = 'Spécifie le code magasin associé à l''écriture.';
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the variant of the item on the line.',
                                FRA = 'Indique la variante de l''article sur la ligne.';
                    Visible = false;
                }
                field(AverageCostCntrl; Rec.CalculateAverageCost())
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 2;
                    CaptionML = ENU = 'Unit Cost',
                                FRA = 'Coût unitaire';
                    Editable = false;
                    StyleExpr = 'Strong';
                    ToolTipML = ENU = 'Specifies the average cost for this entry.',
                                FRA = 'Spécifie le coût moyen de cette écriture.';
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies whether the cost is adjusted for the entry.',
                                FRA = 'Spécifie si le coût est ajusté ou non pour l''écriture.';
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    HideValue = ItemLedgerEntryNoHideValue;
                    ToolTipML = ENU = 'Specifies the number of the item ledger entry that this entry is linked to.',
                                FRA = 'Spécifie le numéro de l''écriture comptable article auquel cette écriture est liée.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the posting date for the entry.',
                                FRA = 'Spécifie la date comptabilisation de l''écriture.';
                    Visible = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    HideValue = EntryTypeHideValue;
                    ToolTipML = ENU = 'Specifies which type of transaction that the entry is created from.',
                                FRA = 'Spécifie le type de transaction à partir duquel l''écriture est créée.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies the type of document that the average cost applies to.',
                                FRA = 'Spécifie le type de document auquel le coût moyen s''applique.';
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTipML = ENU = 'Specifies a document number for the entry.',
                                FRA = 'Spécifie un numéro de document pour l''écriture.';
                    Visible = false;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    Editable = false;
                    HideValue = DocumentLineNoHideValue;
                    ToolTipML = ENU = 'Specifies the document line that the comment applies to.',
                                FRA = 'Indique la ligne du document à laquelle le commentaire s''applique.';
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = 'Strong';
                    ToolTipML = ENU = 'Specifies the quantity associated with the entry.',
                                FRA = 'Spécifie la quantité associée à l''écriture.';
                }
                field("Cost Amount (Expected)"; Rec."Cost Amount (Expected)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = 'Strong';
                    ToolTipML = ENU = 'Specifies the expected cost in LCY of the quantity posting.',
                                FRA = 'Spécifie le coût prévu, en devise société, de la validation de quantité.';
                }
                field("Cost Amount (Actual)"; Rec."Cost Amount (Actual)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = 'Strong';
                    ToolTipML = ENU = 'Specifies the adjusted cost in LCY of the quantity posting.',
                                FRA = 'Spécifie le coût ajusté, en devise société, de la validation de quantité.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            FRA = '&Ligne';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                    trigger OnAction();
                    begin
                        if ItemLedgEntry.GET(Rec."Entry No.") then
                            ItemLedgEntry.ShowDimensions();
                    end;
                }
                action("&Value Entries")
                {
                    CaptionML = ENU = '&Value Entries',
                                FRA = 'Écritures &valeur';
                    Image = ValueLedger;
                    RunObject = Page "Value Entries";
                    RunPageLink = "Item Ledger Entry No." = FIELD("Item Ledger Entry No."),
                                  "Valuation Date" = FIELD("Valuation Date");
                    RunPageView = sorting("Item Ledger Entry No.");
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'Executes the &Value Entries action.';
                }
            }
            group("&Application")
            {
                CaptionML = ENU = '&Application',
                            FRA = '&Lettrage';
                Image = Apply;
                action("Applied E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Applied E&ntries',
                                FRA = 'É&critures lettrées';
                    Image = Approve;
                    ToolTipML = ENU = 'View the ledger entries that have been applied to this record.',
                                FRA = 'Affichez les écritures comptables qui ont été lettrées avec cet enregistrement.';

                    trigger OnAction();
                    var
                        ItemLedgEntry: Record "Item Ledger Entry";
                    begin
                        if ItemLedgEntry.GET(Rec."Item Ledger Entry No.") then
                            CODEUNIT.RUN(CODEUNIT::"Show Applied Entries", ItemLedgEntry);
                    end;
                }
                action("Reservation Entries")
                {
                    AccessByPermission = TableData Item = R;
                    CaptionML = ENU = 'Reservation Entries',
                                FRA = 'Écritures réservation';
                    Image = ReservationLedger;
                    ToolTip = 'Executes the Reservation Entries action.';

                    trigger OnAction();
                    var
                        ItemLedgEntry: Record "Item Ledger Entry";
                    begin
                        ItemLedgEntry.GET(Rec."Item Ledger Entry No.");
                        ItemLedgEntry.ShowReservationEntries(true);
                    end;
                }
            }
        }
        area(navigation)
        {
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = '&Navigate',
                            FRA = 'Na&viguer';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.',
                            FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';

                trigger OnAction();
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN();
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        DocumentLineNoHideValue := false;
        EntryTypeHideValue := false;
        ItemLedgerEntryNoHideValue := false;
        TypeIndent := 0;
        SetExpansionStatus();
        if Rec.Type = Rec.Type::"Closing Entry" then begin
            Rec.Quantity := Rec.CalculateRemainingQty();
            Rec."Cost Amount (Expected)" := Rec.CalculateCostAmt(false);
            Rec."Cost Amount (Actual)" := Rec.CalculateCostAmt(true);
        end;
        TypeOnFormat();
        ItemLedgerEntryNoOnFormat();
        EntryTypeOnFormat();
        DocumentLineNoOnFormat();
    end;

    trigger OnOpenPage();
    begin
        InitTempTable();
        ExpandAll(AvgCostCalcOverview);

        SetRecFilters();
        CurrPage.UPDATE(false);

        ItemName := STRSUBSTNO('%1  %2', Item."No.", Item.Description);
    end;

    var
        AvgCostCalcOverview: Record "Average Cost Calc. Overview" temporary;
        Item: Record Item;
        ItemLedgEntry: Record "Item Ledger Entry";
        GetAvgCostCalcOverview: Codeunit "Get Average Cost Calc Overview";
        Navigate: Page Navigate;

        DocumentLineNoHideValue: Boolean;

        EntryTypeHideValue: Boolean;

        ItemLedgerEntryNoHideValue: Boolean;
        ActualExpansionStatus: Integer;

        TypeIndent: Integer;
        ItemName: Text[250];

    procedure SetExpansionStatus();
    begin
        case true of
            IsExpanded(Rec):
                ActualExpansionStatus := 1;
            HasChildren(Rec):
                ActualExpansionStatus := 0
            else
                ActualExpansionStatus := 2;
        end;
    end;

    procedure InitTempTable();
    var
        AvgCostCalcOverviewFilters: Record "Average Cost Calc. Overview";
    begin
        AvgCostCalcOverview."Item No." := Item."No.";
        AvgCostCalcOverview.SETRANGE("Valuation Date", 0D, Rec."Valuation Date");
        AvgCostCalcOverview.SETFILTER("Location Code", Rec."Location Code");
        AvgCostCalcOverview.SETFILTER("Variant Code", Rec."Variant Code");
        AvgCostCalcOverview.SETRANGE(Type, AvgCostCalcOverview.Type::"Closing Entry");
        AvgCostCalcOverview.SETRANGE("Cost is Adjusted", true);
        AvgCostCalcOverview.SETFILTER(Quantity, '<>%1', 0);

        GetAvgCostCalcOverview.RUN(AvgCostCalcOverview);
        AvgCostCalcOverview.RESET();
        AvgCostCalcOverviewFilters.COPYFILTERS(Rec);
        Rec.RESET();
        Rec.DELETEALL();
        if AvgCostCalcOverview.FIND('-') then
            repeat
                if AvgCostCalcOverview.Level = 0 then begin
                    Rec := AvgCostCalcOverview;
                    Rec.INSERT();
                end;
            until AvgCostCalcOverview.NEXT() = 0;
        Rec.COPYFILTERS(AvgCostCalcOverviewFilters);
    end;

    procedure ExpandAll(var AvgCostCalcOverview: Record "Average Cost Calc. Overview");
    var
        AvgCostCalcOverviewFilters: Record "Average Cost Calc. Overview";
    begin
        AvgCostCalcOverview."Item No." := Item."No.";
        AvgCostCalcOverview.SETRANGE("Valuation Date", 0D, Rec."Valuation Date");
        AvgCostCalcOverview.SETFILTER("Location Code", Rec."Location Code");
        AvgCostCalcOverview.SETFILTER("Variant Code", Rec."Variant Code");
        AvgCostCalcOverview.SETRANGE(Type, AvgCostCalcOverview.Type::"Closing Entry");
        AvgCostCalcOverview.SETRANGE("Cost is Adjusted", true);
        AvgCostCalcOverview.SETFILTER(Quantity, '<>%1', 0);

        GetAvgCostCalcOverview.RUN(AvgCostCalcOverview);
        AvgCostCalcOverviewFilters.COPYFILTERS(Rec);
        Rec.RESET();
        Rec.DELETEALL();

        if AvgCostCalcOverview.FIND('+') then
            repeat
                Rec := AvgCostCalcOverview;
                GetAvgCostCalcOverview.Calculate(AvgCostCalcOverview);
                AvgCostCalcOverview.RESET();
                AvgCostCalcOverview := Rec;
            until AvgCostCalcOverview.NEXT(-1) = 0;

        if AvgCostCalcOverview.FIND('+') then
            repeat
                Rec := AvgCostCalcOverview;
                Rec.INSERT();
            until AvgCostCalcOverview.NEXT(-1) = 0;

        Rec.COPYFILTERS(AvgCostCalcOverviewFilters);
    end;

    local procedure IsExpanded(ActualAvgCostCalcOverview: Record "Average Cost Calc. Overview"): Boolean;
    var
        xAvgCostCalcOverview: Record "Average Cost Calc. Overview" temporary;
        Found: Boolean;
    begin
        xAvgCostCalcOverview := Rec;
        Rec.SETCURRENTKEY("Attached to Valuation Date", "Attached to Entry No.", Type);
        Rec := ActualAvgCostCalcOverview;
        Found := (Rec.NEXT(GetDirection()) <> 0);
        if Found then
            Found := (Rec.Level > ActualAvgCostCalcOverview.Level);
        Rec := xAvgCostCalcOverview;
        exit(Found);
    end;

    local procedure HasChildren(var ActualAvgCostCalcOverview: Record "Average Cost Calc. Overview"): Boolean;
    begin
        AvgCostCalcOverview := ActualAvgCostCalcOverview;
        if Rec.Type = Rec.Type::"Closing Entry" then
            exit(GetAvgCostCalcOverview.EntriesExist(AvgCostCalcOverview));
        exit(false);
    end;

    local procedure GetDirection(): Integer;
    begin
        if Rec.ASCendING then
            exit(1);
        exit(-1);
    end;

    procedure SetRecFilters();
    begin
        Rec.RESET();
        Rec.SETCURRENTKEY("Attached to Valuation Date", "Attached to Entry No.", Type);
        CurrPage.UPDATE(false);
    end;

    procedure SetItem(var Item2: Record Item);
    begin
        Item.COPY(Item2);
    end;

    local procedure TypeOnFormat();
    begin
        if Rec.Type <> Rec.Type::"Closing Entry" then
            TypeIndent := 1;
    end;

    local procedure ItemLedgerEntryNoOnFormat();
    begin
        if Rec.Type = Rec.Type::"Closing Entry" then
            ItemLedgerEntryNoHideValue := true;
    end;

    local procedure EntryTypeOnFormat();
    begin
        if Rec.Type = Rec.Type::"Closing Entry" then
            EntryTypeHideValue := true;
    end;

    local procedure DocumentLineNoOnFormat();
    begin
        if Rec.Type = Rec.Type::"Closing Entry" then
            DocumentLineNoHideValue := true;
    end;

    procedure SetBinAnalysisFilters(var Item2: Record Item; NewLocationCode: Code[10]; NewValuationDate: Date; NewVariantCode: Code[20]);
    begin
        Item.COPY(Item2);
        Rec."Location Code" := NewLocationCode;
        Rec."Valuation Date" := NewValuationDate;
        Rec."Variant Code" := NewVariantCode;
    end;
}

