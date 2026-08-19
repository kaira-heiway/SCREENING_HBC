page 54033 "Semi Finished Goods Cost"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 19.04.2019 # Actual Product Costing
    //   # New Page created to store Actual Product Costs
    // HEI.02 CHG2117540 BULIMC01 IBM 07/07/2021 # Error when drilling down on Actual Cost
    //*******************************************************************************************
    //BC UPGRADE PATHAA02 05.01.26
    //ApplicationArea added to fields

    Caption = 'Semi-Finished Goods Cost';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Actual Product Cost DTW";
    SourceTableView = WHERE(Archived = FILTER(false),
                            "Product Type" = FILTER("Semi-Finished Goods Cost"));
    ApplicationArea = All; //BC UPGRADE PATHAA02
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field(Description; Item.Description)
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Period Actual Quantity"; Rec."Period Actual Quantity")
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
                        //IF "Product Type" = "Product Type"::"Semi-Finished Goods Cost" THEN
                        //ItemLedgerEntry.SETRANGE("Entry Type",ItemLedgerEntry."Entry Type"::Output);
                        PAGE.RUNMODAL(38, ItemLedgerEntry);
                    end;
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
                    begin
                        //Open Actual Product Cost Calculations Page
                        ActualCostCalculation.SETRANGE("Item No.", Rec."Item No.");
                        ActualCostCalculation.SETRANGE("Location Code", Rec."Location Code");
                        if Rec."Period Actual Quantity" = Rec."Total Actual Quantity" then
                            ActualCostCalculation.SETRANGE("Ending Date", 0D, Rec."Ending Date")
                        else begin
                            ActualCostCalculation.SETRANGE("Starting Date", Rec."Starting Date");
                            ActualCostCalculation.SETRANGE("Ending Date", Rec."Ending Date");
                        end;

                        //PAGE.RUNMODAL(50303,ActualCostCalculation); //HEI.02 commented
                        PAGE.RUNMODAL(PAGE::"Actual Cost Calculations", ActualCostCalculation); //HEI.02
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
                        ActualCostCalculation.SETRANGE("Item No.", Rec."Item No.");
                        ActualCostCalculation.SETRANGE("Location Code", Rec."Location Code");
                        ActualCostCalculation.SETRANGE("Ending Date", 0D, Rec."Ending Date");
                        //ActualCostCalculation.SETFILTER("Posting Date",'<>%1',0D);

                        //PAGE.RUNMODAL(50303,ActualCostCalculation); //HEI.02 commented
                        PAGE.RUNMODAL(PAGE::"Actual Cost Calculations", ActualCostCalculation); //HEI.02
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
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("Price Variance"; Rec."Price Variance")
                {
                    Editable = false;
                    ApplicationArea = All; //BC UPGRADE PATHAA02
                }
                field("As % of Price"; Rec."As % of Price")
                {
                    Caption = 'Price Variance as % of Std. Cost';
                    Editable = false;
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
        Item.GET(Rec."Item No.");
    end;

    var
        Item: Record Item;
}

