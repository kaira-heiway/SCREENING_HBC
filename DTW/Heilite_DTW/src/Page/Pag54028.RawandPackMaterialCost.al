page 54028 "Raw and Pack Material Cost"
{
    // version HEI.01

    // HEI.01 FDD-BPMGAP BRD HB398 IBM NASTAA02 19.04.2019 # Actual Product Costing
    //   # New Page created to store Actual Product Costs
    // HEI.02 CHG2117540 BULIMC01 IBM 07/07/2021 # Error when drilling down on Actual Cost
    // BC Upgrade KUMARS145 Nav ID Page 50317 "Raw and Pack Material Cost"   
    Caption = 'Raw and Packaging Material Cost';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Actual Product Cost DTW";
    SourceTableView = WHERE(Archived = FILTER(false),
                            "Product Type" = FILTER("Raw and Packaging Material Cost"));
    ApplicationArea = All;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Starting Date" DTW Ext Imformation';
                    Editable = false;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Ending Date" DTW Ext Imformation';
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    ToolTip = '"Item No." Containes  DTW Ext Imformation';
                    Editable = false;
                }
                field(Description; Item.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes Item.Description DTW Ext Imformation';
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Location Code" DTW Ext Imformation';
                    Editable = false;
                }
                field("Period Actual Quantity"; Rec."Period Actual Quantity")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Period Actual Quantity" DTW Ext Imformation';
                    Editable = false;

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
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Total Actual Quantity" DTW Ext Imformation';
                    Editable = false;

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
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Base Unit of Measure" DTW Ext Imformation';
                    Editable = false;
                }
                field("Period Actual Cost"; Rec."Period Actual Cost")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Period Actual Cost" DTW Ext Imformation';
                    Editable = false;

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
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Total Actual Cost" DTW Ext Imformation';
                    Editable = false;

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
                field("Total Std Cost"; Rec."Total Std Cost")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Total Std Cost" DTW Ext Imformation';
                    Editable = false;
                }
                field("Total Variance"; Rec."Total Variance")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Total Variance" DTW Ext Imformation';
                    Editable = false;
                }
                field("As % of Std Cost"; Rec."As % of Std Cost")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "As % of Std Cost" DTW Ext Imformation';
                    Caption = 'Total Variance as % of Std. Cost';
                    Editable = false;
                }
                field("Price Variance"; Rec."Price Variance")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Price Variance" DTW Ext Imformation';
                    Editable = false;
                }
                field("As % of Price"; Rec."As % of Price")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "As % of Price" DTW Ext Imformation';
                    Caption = 'Price Variance as % of Std. Cost';
                    Editable = false;
                }
                field("Actual Cost BUoM"; Rec."Actual Cost BUoM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Actual Cost BUoM" DTW Ext Imformation';
                    Editable = false;
                }
                field("Std Cost BUoM"; Rec."Std Cost BUoM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Std Cost BUoM" DTW Ext Imformation';
                    Editable = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Item Category Code" DTW Ext Imformation';
                    Editable = false;
                }
                field("Use Std Cost SKU"; Rec."Use Std Cost SKU")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Use Std Cost SKU" DTW Ext Imformation';
                }
                field("Calculation Corrected"; Rec."Calculation Corrected")
                {
                    ApplicationArea = all;
                    ToolTip = 'Containes  "Calculation Corrected" DTW Ext Imformation';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // Caption = 'Actions';
            action(ResetItemActualCost)
            {
                ApplicationArea = all;
                ToolTip = 'Containes  DTW Ext Imformation';
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
                    if ActualProductCost.FINDFIRST() then
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

