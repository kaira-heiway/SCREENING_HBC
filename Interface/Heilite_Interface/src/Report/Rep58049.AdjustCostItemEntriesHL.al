report 58049 "Adjust Cost - Item Entries HL"
{
    //BC Upgrade GUNREM01 Old ID-50499
    // version NAVW110.0

    // HEI.01 CHG2098896 IBM POENAB02 18.02.2021 Skip/step over error messages during running an batch job (adjust cost and post cost to G/L)
    //   # Object created

    CaptionML = ENU = 'Adjust Cost - Item Entries',
                FRA = 'Ajuster coûts : Ecr. article';
    Permissions = TableData "Item Ledger Entry" = rimd,
                  TableData "Item Application Entry" = r,
                  TableData "Value Entry" = rimd,
                  TableData "Avg. Cost Adjmt. Entry Point" = rimd;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }

        trigger OnInit();
        begin
            FilterItemCategoryEditable := true;
            FilterItemNoEditable := true;
            PostEnable := true;
        end;

        trigger OnOpenPage();
        begin
            InvtSetup.GET;
            //PostToGL := InvtSetup."Automatic Cost Posting";
            PostToGL := true;
            PostEnable := PostToGL;
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ItemApplnEntry: Record "Item Application Entry";
        AvgCostAdjmtEntryPoint: Record "Avg. Cost Adjmt. Entry Point";
        Item: Record Item;
        UpdateItemAnalysisView: Codeunit "Update Item Analysis View";
    begin
        PostToGL := true;
        ItemApplnEntry.LOCKTABLE;
        if not ItemApplnEntry.FINDLAST then
            exit;
        ItemLedgEntry.LOCKTABLE;
        if not ItemLedgEntry.FINDLAST then
            exit;
        AvgCostAdjmtEntryPoint.LOCKTABLE;
        if AvgCostAdjmtEntryPoint.FINDLAST then;
        ValueEntry.LOCKTABLE;
        if not ValueEntry.FINDLAST then
            exit;

        if (ItemNoFilter <> '') and (ItemCategoryFilter <> '') then
            ERROR(Text005);

        if ItemNoFilter <> '' then
            Item.SETFILTER("No.", ItemNoFilter);
        if ItemCategoryFilter <> '' then
            Item.SETFILTER("Item Category Code", ItemCategoryFilter);

        InvtAdjmt.SetProperties(false, PostToGL);
        InvtAdjmt.SetFilterItem(Item);
        InvtAdjmt.MakeMultiLevelAdjmt;

        UpdateItemAnalysisView.UpdateAll(0, true);
    end;

    var
        ResynchronizeInfoMsg: TextConst ENU = 'Your general and item ledgers will no longer be synchronized after running the cost adjustment. You must run the %1 report to synchronize them again.', FRA = 'Les écritures article et les écritures comptables ne seront plus synchronisées après l''ajustement des coûts. Vous devez exécuter l''état %1 pour les synchroniser de nouveau.';
        InvtSetup: Record "Inventory Setup";
        InvtAdjmt: Codeunit "Inventory Adjustment";
        ItemNoFilter: Text[250];
        ItemCategoryFilter: Text[250];
        Text005: TextConst ENU = 'You must not use Item No. Filter and Item Category Filter at the same time.', FRA = 'Vous ne pouvez pas utiliser simultanément le filtre n° article et le filtre catégorie article.';
        PostToGL: Boolean;
        // [InDataSet]
        PostEnable: Boolean;
        // [InDataSet]
        FilterItemNoEditable: Boolean;
        // [InDataSet]
        FilterItemCategoryEditable: Boolean;

    procedure InitializeRequest(NewItemNoFilter: Text[250]; NewItemCategoryFilter: Text[250]);
    begin
        ItemNoFilter := NewItemNoFilter;
        ItemCategoryFilter := NewItemCategoryFilter;
    end;
}

