page 54032 "Actual Product Cost Tree"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 09.05.2019 # Actual Product Costing
    //   # New Page created to store Actual Product Cost Structure
    //   # Copied Standard Page 5870 - BOM Structure
    // HEI.02 FDD-398 IBM BULIMC01 07/02/2020# new changes
    // HEI.03 CHG2117540 BULIMC01 IBM 07/07/2021 # Error when drilling down on Actual Cost
    //*******************************************************************************************
    //BC UPGRADE PATHAA02 05.01.26
    //ApplicationArea added to fields

    Caption = 'Actual Product Cost Tree';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Actual Product Cost Struct DTW";
    SourceTableView = WHERE(Archived = FILTER(false));
    ApplicationArea = All; //BC UPGRADE PATHAA02

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                CaptionML = ENU = 'Lines',
                            FRA = 'Lignes';
                Editable = false;
                IndentationColumn = Rec."Tree Level";
                ShowAsTree = true;
                field("Starting Date"; Rec."Starting Date")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = IsParentExpr;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field(Description; Description)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TotalLine;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Period Actual Quantity"; Rec."Period Actual Quantity")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02

                    trigger OnDrillDown();
                    var
                        ItemLedgerEntry: Record "Item Ledger Entry";
                        ValueEntry: Record "Value Entry";
                        TempILE: Record "Item Ledger Entry" temporary;
                    begin
                        //Open Item Ledger Entry page with filters
                        ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
                        ItemLedgerEntry.SETRANGE("Location Code", Rec."Location Code");
                        //HEI.02

                        if Rec."Is Child" then begin
                            ItemLedgerEntry.SETRANGE("Value Entry Source No. FND", Rec."Parent Item No.");
                            ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
                        end;
                        //HEI.02<<
                        if Rec."Period Actual Quantity" = Rec."Total Actual Quantity" then
                            ItemLedgerEntry.SETRANGE("Posting Date", 0D, Rec."Ending Date")
                        else
                            ItemLedgerEntry.SETRANGE("Posting Date", Rec."Starting Date", Rec."Ending Date");
                        //IF "Product Type" = "Product Type"::"Semi-Finished Goods Cost" THEN
                        //ItemLedgerEntry.SETRANGE("Entry Type",ItemLedgerEntry."Entry Type"::Output);

                        PAGE.RUNMODAL(38, ItemLedgerEntry);
                    end;
                }
                field("Total Actual Quantity"; Rec."Total Actual Quantity")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02

                    trigger OnDrillDown();
                    var
                        ItemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        //Open Item Ledger Entry page with filters
                        ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
                        ItemLedgerEntry.SETRANGE("Location Code", Rec."Location Code");
                        ItemLedgerEntry.SETRANGE("Posting Date", 0D, Rec."Ending Date");
                        //HEI.02<<
                        if Rec."Is Child" then begin
                            ItemLedgerEntry.SETRANGE("Value Entry Source No. FND", Rec."Parent Item No.");
                            ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
                        end;
                        //HEI.02>>
                        //IF "Product Type" = "Product Type"::"Semi-Finished Goods Cost" THEN
                        //ItemLedgerEntry.SETRANGE("Entry Type",ItemLedgerEntry."Entry Type"::Output);
                        PAGE.RUNMODAL(38, ItemLedgerEntry);
                    end;
                }
                field("Period Expected Quantity"; Rec."Period Expected Quantity")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Total Actual Qty in PUM"; Rec."Total Actual Qty in PUM")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Total Actual Qty in HL"; Rec."Total Actual Qty in HL")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Period Actual Cost"; Rec."Period Actual Cost")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02

                    trigger OnDrillDown();
                    var
                        ActualCostCalculation: Record "Actual Cost Calculation DTW";
                        ActualCostCalculation2: Record "Actual Cost Calculation DTW";
                    begin
                        //Open Actual Product Cost Calculations Page
                        //ActualCostCalculation.SETRANGE("Item No.","Item No."); //commented hei.02
                        //HEI.02<<
                        ActualCostCalculation.SETRANGE("Item No.", Rec."Parent Item No.");
                        if Rec."Is Child" then
                            ActualCostCalculation.SETRANGE("Item No. of Source No.", Rec."Item No.");
                        if Rec."Is Parent" or Rec."Capacity Cost Line" or Rec."Variable Cost Line" then
                            ActualCostCalculation.SETRANGE("Subtotal Consumption", false);
                        if Rec."Capacity Cost Line" then
                            ActualCostCalculation.SETRANGE("Calculation Type", ActualCostCalculation."Calculation Type"::"Production Orders Not Consumption VE");
                        if Rec."Variable Cost Line" then
                            ActualCostCalculation.SETRANGE("Calculation Type", ActualCostCalculation."Calculation Type"::"Production Orders Conspumtion VE");
                        //HEI.02>>
                        ActualCostCalculation.SETRANGE("Location Code", Rec."Location Code");
                        if Rec."Period Actual Quantity" = Rec."Total Actual Quantity" then
                            ActualCostCalculation.SETRANGE("Ending Date", 0D, Rec."Ending Date")
                        else begin
                            ActualCostCalculation.SETRANGE("Starting Date", Rec."Starting Date");
                            ActualCostCalculation.SETRANGE("Ending Date", Rec."Ending Date");
                        end;

                        //PAGE.RUNMODAL(50303,ActualCostCalculation); //HEI.03 commented
                        PAGE.RUNMODAL(PAGE::"Actual Cost Calculations", ActualCostCalculation); //HEI.03
                    end;
                }
                field("Total Actual Cost"; Rec."Total Actual Cost")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02

                    trigger OnDrillDown();
                    var
                        ActualCostCalculation: Record "Actual Cost Calculation DTW";
                    begin
                        //Open Actual Product Cost Calculations Page
                        //ActualCostCalculation.SETRANGE("Item No.","Item No."); //commented hei.02
                        //HEI.02<<
                        ActualCostCalculation.SETRANGE("Item No.", Rec."Parent Item No.");
                        if Rec."Is Child" then
                            ActualCostCalculation.SETRANGE("Item No. of Source No.", Rec."Item No.");
                        if Rec."Is Parent" or Rec."Capacity Cost Line" or Rec."Variable Cost Line" then
                            ActualCostCalculation.SETRANGE("Subtotal Consumption", false);
                        if Rec."Capacity Cost Line" then
                            ActualCostCalculation.SETRANGE("Calculation Type", ActualCostCalculation."Calculation Type"::"Production Orders Not Consumption VE");
                        if Rec."Variable Cost Line" then
                            ActualCostCalculation.SETRANGE("Calculation Type", ActualCostCalculation."Calculation Type"::"Production Orders Conspumtion VE");
                        //HEI.02>>
                        ActualCostCalculation.SETRANGE("Location Code", Rec."Location Code");
                        //HEI.02<<
                        //ActualCostCalculation.SETRANGE("Ending Date",0D,"Ending Date"); //commented
                        ActualCostCalculation.SETRANGE("Starting Date", Rec."Starting Date");
                        ActualCostCalculation.SETRANGE("Ending Date", Rec."Ending Date");
                        //HEI.02>>
                        //ActualCostCalculation.SETFILTER("Posting Date",'<>%1',0D);

                        //PAGE.RUNMODAL(50303,ActualCostCalculation); //HEI.03 commented
                        PAGE.RUNMODAL(PAGE::"Actual Cost Calculations", ActualCostCalculation); //HEI.03
                    end;
                }
                field("Total Expected Cost"; Rec."Total Expected Cost")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Total Std Cost"; Rec."Total Std Cost")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Total Variance"; Rec."Total Variance")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("As % of Std Cost"; Rec."As % of Std Cost")
                {
                    Caption = 'Total Variance as % of Std. Cost';
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Price Variance"; Rec."Price Variance")
                {
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("As % of Price"; Rec."As % of Price")
                {
                    Caption = 'Price Variance as % of Std. Cost';
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Consumption Variance"; Rec."Consumption Variance")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("As % of Std Consumption"; Rec."As % of Std Consumption")
                {
                    Caption = 'Consumption Variance as % of Std. Cost';
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Actual Cost BUoM"; Rec."Actual Cost BUoM")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Actual Cost PUM"; Rec."Actual Cost PUM")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Actual Cost HL"; Rec."Actual Cost HL")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Exp Cost BUoM"; Rec."Exp Cost BUoM")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Exp Cost PUM"; Rec."Exp Cost PUM")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Exp Cost HL"; Rec."Exp Cost HL")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Std Cost BUoM"; Rec."Std Cost BUoM")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Std Cost PUM"; Rec."Std Cost PUM")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Std Cost HL"; Rec."Std Cost HL")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Is Parent"; Rec."Is Parent")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Is Child"; Rec."Is Child")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Parent Line No."; Rec."Parent Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Use Std Cost SKU"; Rec."Use Std Cost SKU")
                {
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Calculation Corrected"; Rec."Calculation Corrected")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ResetItemActualCost)
            {
                Caption = 'Reset Item Actual Cost';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    ActualProductCost: Record "Actual Product Cost DTW";
                begin
                    ActualProductCost.SETRANGE("Item No.", Rec."Item No.");
                    ActualProductCost.SETRANGE("Location Code", Rec."Location Code");
                    ActualProductCost.SETRANGE("Ending Date", Rec."Ending Date");
                    if ActualProductCost.FINDFIRST then
                        REPORT.RUNMODAL(50301, true, false, ActualProductCost);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IsParentExpr := (Rec."Parent Line No." = 0) or ((Rec."Parent Line No." <> 0) and Rec."Is Parent");
        TotalLine := Rec."Variable Cost Line" or Rec."Capacity Cost Line";
        if Item.GET(Rec."Item No.") then
            Description := Item.Description
        else begin
            if Rec."Variable Cost Line" then begin
                if ActualProductCostStructure.GET(Rec."Parent Line No.") then begin
                    if Item2.GET(ActualProductCostStructure."Item No.") then
                        Description := 'Total Variable Cost for Item: ' + Item2."No."
                end else
                    Description := 'Total Variable Cost';
            end;
            if Rec."Capacity Cost Line" then begin
                if ActualProductCostStructure.GET(Rec."Parent Line No.") then begin
                    if Item2.GET(ActualProductCostStructure."Item No.") then
                        Description := 'Capacity Cost for Item: ' + Item2."No."
                end else
                    Description := 'Capacity Cost';
            end;
        end;
    end;

    var
        Item: Record Item;
        Text000: TextConst ENU = 'Could not find items with BOM levels.', FRA = 'Impossible de trouver des articles avec des niveaux de nomenclature.';
        Text001: TextConst ENU = 'There are no warnings.', FRA = 'Il n''y a pas d''alerte.';
        Item2: Record Item;
        StockkeepingUnit: Record "Stockkeeping Unit";
        ActualProductCostStructure: Record "Actual Product Cost Struct DTW";
        Description: Text[50];
        IsParentExpr: Boolean;
        TotalLine: Boolean;
}

