page 51039 "Base Price STD Cost Calc. CBN"
{
    // version HEI.02

    // HEI.01 CHG2090557 IBM.LS      02.08.2021
    //   # Created New Page: 50148 - Base Price STD Cost Calc.
    //   # Added New Fields - Item No.
    //                      - Variant Code
    //                      - Direct Unit Cost
    //                      - Currency Code
    //                      - Starting Date
    //                      - Ending Date
    //                      - Unit of Measure Code
    //   # Added Code
    // 
    // HEI.02 CHG2176288 IBM.PRASAA03 24.02.2023 "Split in Base price std cost calc for landed costs"
    // # Added 2 new fields "Raw Mat & Pack" and "landed Costs"

    //Bc Upgrade YADAVM09 StartingDateFilter on validate trigger code handeled using filter token codeunit.

    CaptionML = ENU = 'Base Price STD Cost Calc.',
                FRA = 'Prix achat';
    DataCaptionExpression = GetCaption();
    ApplicationArea = All;
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Base Price STD Cost Calc. FND";
    UsageCategory = Lists; //BC UPGRADE PATHAA02

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            FRA = 'Général';
                field(ItemNoFIlterCtrl; ItemNoFilter)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Item No. Filter',
                                FRA = 'Filtre n° article';
                    ToolTipML = ENU = 'Specifies a filter for which Base prices to display.',
                                FRA = 'Spécifie un filtre pour choisir les prix d''achat à afficher.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page "Item List";
                    begin
                        //HEI.01>>
                        ItemList.LOOKUPMODE := true;
                        if ItemList.RUNMODAL() = ACTION::LookupOK then
                            Text := ItemList.GetSelectionFilter()
                        else
                            exit(false);

                        exit(true);
                        //HEI.01<<
                    end;

                    trigger OnValidate();
                    begin
                        //HEI.01>>
                        ItemNoFilterOnAfterValidate();
                        //HEI.01<<
                    end;
                }
                field(StartingDateFilter; StartingDateFilter)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Starting Date Filter',
                                FRA = 'Filtre date début';
                    ToolTipML = ENU = 'Specifies a filter for which Base prices to display.',
                                FRA = 'Spécifie un filtre pour choisir les prix d''achat à afficher.';

                    trigger OnValidate();
                    var
                        //ApplicationMgt: Codeunit ApplicationManagement;//Bc Upgrade YADAVM09
                        FilterTokenCU: Codeunit "Filter Tokens";//BC Upgrade YADAVM09
                    begin
                        //HEI.01>>
                        //if ApplicationMgt.MakeDateFilter(StartingDateFilter) = 0 then;//BC Upgrade YADAVM09
                        FilterTokenCU.MakeDateFilter(StartingDateFilter);//BC Upgrade YADAVM09
                        if StartingDateFilter = '' then; //BC Upgrade YADAVM09
                        StartingDateFilterOnAfterValid();
                        //HEI.01<<
                    end;
                }
            }
            repeater(Control1)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the number of the item that the Base price applies to.',
                                FRA = 'Spécifie le numéro de l''article auquel s''applique le prix d''achat.';
                }
                field("Raw Mat & Pack"; Rec."Raw Mat & Pack")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Raw Mat & Pack field.';
                }
                field("Landed Costs"; Rec."Landed Costs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Landed Costs field.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the cost per unit.',
                                FRA = 'Spécifie le coût par unité.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date from which the Base price is valid.',
                                FRA = 'Spécifie la date de début de validité du prix d''achat.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date to which the Base price is valid.',
                                FRA = 'Spécifie la date limite de validité du prix d''achat.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the unit of measure code that the Base price is valid for.',
                                FRA = 'Spécifie le code unité de mesure valable pour le prix d''achat.';
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
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        //HEI.01>>
        GetRecFilters();
        SetRecFilters();
        IsLookupMode := CurrPage.LOOKUPMODE;
        //HEI.01<<
    end;

    var
        IsLookupMode: Boolean;
        ItemNoFilter: Text;
        StartingDateFilter: Text[30];
        NoDataWithinFilterErr: TextConst Comment = '%1: Field(Code), %2: GetFilter(Code)', ENU = 'There is no %1 within the filter %2.', FRA = 'Il n''y a pas de %1 dans le filtre %2.';

    local procedure GetRecFilters();
    begin
        //HEI.01>>
        if Rec.GETFILTERS <> '' then begin
            ItemNoFilter := Rec.GETFILTER(Rec."Item No.");
            EVALUATE(StartingDateFilter, Rec.GETFILTER(Rec."Starting Date"));
        end;
        //HEI.01<<
    end;

    procedure SetRecFilters();
    begin
        //HEI.01>>
        if StartingDateFilter <> '' then
            Rec.SETFILTER("Starting Date", StartingDateFilter)
        else
            Rec.SETRANGE("Starting Date");

        if ItemNoFilter <> '' then
            Rec.SETFILTER("Item No.", ItemNoFilter)
        else
            Rec.SETRANGE("Item No.");

        CheckFilters(DATABASE::Item, ItemNoFilter);

        CurrPage.UPDATE(false);
        //HEI.01<<
    end;

    local procedure GetCaption(): Text;
    var
        ObjTransl: Record "Object Translation";
        ItemNoFilter2: Code[30];
        StartingDateFilter2: Text[30];
        Description: Text[50];
        SourceTableName: Text[250];
    begin
        //HEI.01>>
        if Rec.GETFILTERS <> '' then begin
            ItemNoFilter2 := Rec.GETFILTER(Rec."Item No.");
            EVALUATE(StartingDateFilter2, Rec.GETFILTER("Starting Date"));
        end;

        if ItemNoFilter2 <> '' then
            SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27)
        else
            SourceTableName := '';
        //HEI.01<<
    end;

    local procedure StartingDateFilterOnAfterValid();
    begin
        //HEI.01>>
        CurrPage.SAVERECORD();
        SetRecFilters();
        //HEI.01<<
    end;

    local procedure ItemNoFilterOnAfterValidate();
    begin
        //HEI.01>>
        CurrPage.SAVERECORD();
        SetRecFilters();
        //HEI.01<<
    end;

    procedure CheckFilters(TableNo: Integer; FilterTxt: Text);
    var
        FilterRecordRef: RecordRef;
        FilterFieldRef: FieldRef;
    begin
        //HEI.01>>
        if FilterTxt = '' then
            exit;
        CLEAR(FilterRecordRef);
        CLEAR(FilterFieldRef);
        FilterRecordRef.OPEN(TableNo);
        FilterFieldRef := FilterRecordRef.FIELD(1);
        FilterFieldRef.SETFILTER(FilterTxt);
        if FilterRecordRef.ISEMPTY then
            ERROR(NoDataWithinFilterErr, FilterRecordRef.CAPTION, FilterTxt);
        //HEI.01<<
    end;
}

