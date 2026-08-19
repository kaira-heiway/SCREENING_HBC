page 55014 "COGS Allocation on STD Price"
{
    // version HEI.01,HEI.04

    // HEI.01 CHG2132673 IBM.LS      01.03.2022
    //   # Created New Page - COGS Allocation on STD Price
    // HEI.02 CHG2132673 IBM BULIMC01 23.03.2022 - COGS Allocation on STD Price #new changes
    // HEI.03 CHG2172818 PRASAA03 31.01.2023 EPM COGS Allocation: Average items enhancement
    //   # Fields "Cost Posted to G/L" and "Valued Quantity HL" Added in Front End
    // HEI.04 CHG2172818 PRASAA03 29.11.2023 EPM COGS Allocation: Average items enhancement
    //   # Visible Property for Fields "Cost Posted to G/L" and "Valued Quantity HL" Changed.

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Page ID-50488
    //BC Upgrade KAPOOV01  <<

    Caption = 'COGS Allocation on STD Price';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "COGS Alloc on STD Price FND";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    ApplicationArea = All;   //BC Upgrade KAPOOV01
    UsageCategory = Lists;  //BC Upgrade KAPOOV01

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    Visible = false;
                }
                field(Company; Rec.Company)
                {
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                }
                field("Period Number"; Rec."Period Number")
                {
                }
                field("SKU of Sold Products"; Rec."SKU of Sold Products")
                {

                    trigger OnDrillDown();
                    var
                        COGSAllocSTDPriceTreePage: Page "COGS Alloc on STD Price Tree";
                        COGSAllocSTDPriceLine: Record "COGS Alloc STD Price Line FND";
                    begin
                        //HEI.02<<
                        CLEAR(COGSAllocSTDPriceTreePage);

                        COGSAllocSTDPriceLine.RESET();
                        COGSAllocSTDPriceLine.SETCURRENTKEY(Company, "Fiscal Year", "Period Number", "Parent Item No.");
                        COGSAllocSTDPriceLine.SETRANGE(Company, Rec.Company);
                        COGSAllocSTDPriceLine.SETRANGE("Fiscal Year", Rec."Fiscal Year");
                        COGSAllocSTDPriceLine.SETRANGE("Period Number", Rec."Period Number");
                        COGSAllocSTDPriceLine.SETRANGE("Parent Item No.", Rec."SKU of Sold Products");

                        COGSAllocSTDPriceTreePage.SETTABLEVIEW(COGSAllocSTDPriceLine);
                        COGSAllocSTDPriceTreePage.LOOKUPMODE(true);
                        COGSAllocSTDPriceTreePage.RUNMODAL();
                        //HEI.02>>
                    end;
                }
                field(Brand; Rec.Brand)
                {
                }
                field("Line Extension"; Rec."Line Extension")
                {
                }
                field("Pack Type"; Rec."Pack Type")
                {
                }
                field("Costing Method"; Rec."Costing Method")
                {
                }
                field("Volumes Sold HL"; Rec."Volumes Sold HL")
                {
                }
                field("Raw Materials_HL"; Rec."Raw Materials_HL")
                {
                }
                field("Packaging Materials_HL"; Rec."Packaging Materials_HL")
                {
                }
                field("Energy & Water_Prod_HL"; Rec."Energy & Water_Prod_HL")
                {
                }
                field("Other Variable Expenses_HL"; Rec."Other Variable Expenses_HL")
                {
                }
                field("Prod Fix Exp_COGS_HL"; Rec."Prod Fix Exp_COGS_HL")
                {
                }
                field("Total Standard Cost/HL"; Rec."Total Standard Cost/HL")
                {
                    ToolTip = 'Formula: Raw Material HL+ Packing Material HL + Prod. Fix. Exp. (COGS) HL';
                }
                field("Prod Bought_Resale Avg Cost_HL"; Rec."Prod Bought_Resale Avg Cost_HL")
                {
                }
                field("Raw Materials"; Rec."Raw Materials")
                {
                    ToolTip = 'Formula: Volume Sold HL * Raw Materials HL';
                }
                field("Packaging Materials"; Rec."Packaging Materials")
                {
                    ToolTip = 'Formula: Volume Sold HL * Packaging Materials HL';
                }
                field("Energy & Water_Prod"; Rec."Energy & Water_Prod")
                {
                }
                field("Other Variable Expenses"; Rec."Other Variable Expenses")
                {
                }
                field("Prod Fix Exp_COGS"; Rec."Prod Fix Exp_COGS")
                {
                    ToolTip = 'Formula: Volume Sold HL * Prod. Fix. Exp. (COGS) HL';
                }
                field("Total Standard Cost"; Rec."Total Standard Cost")
                {
                    ToolTip = 'Formula: Volume Sold HL * Total Standard Cost HL';
                }
                field("Prod Bought_Resale Avg Cost"; Rec."Prod Bought_Resale Avg Cost")
                {
                    ToolTip = 'Formula: Volume Sold HL * Products Bought in for Resale Average Cost HL';
                }
                field(Unallocated; Rec.Unallocated)
                {
                    ToolTip = 'Formula: Total Standard Cost + Products Bought in for Resale Average Cost - Period Costs';
                }
                field("Period G/L Cost Raw Materials"; Rec."Period G/L Cost Raw Materials")
                {
                }
                field("Period G/L Cost Pack Materials"; Rec."Period G/L Cost Pack Materials")
                {
                }
                field("Period G/L Cost Energy & Water"; Rec."Period G/L Cost Energy & Water")
                {
                }
                field("Period G/L Cost Other Var Exp"; Rec."Period G/L Cost Other Var Exp")
                {
                }
                field("Period G/L Cost InvMovVarProEx"; Rec."Period G/L Cost InvMovVarProEx")
                {
                }
                field("Period G/L Cost Prod Fix Exp"; Rec."Period G/L Cost Prod Fix Exp")
                {
                }
                field("Period G/L Cost ProdBghtResale"; Rec."Period G/L Cost ProdBghtResale")
                {
                }
                field("Cost Posted to G/L"; Rec."Cost Posted to G/L")
                {
                    Visible = false;
                }
                field("Valued Quantity HL"; Rec."Valued Quantity HL")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup55037)
            {
                action("Show Item")
                {
                    Caption = 'Show Item';
                    Image = Item;

                    trigger OnAction();
                    var
                        Item: Record Item;
                    begin
                        //HEI.02>>
                        Item.GET(Rec."SKU of Sold Products");
                        PAGE.RUNMODAL(PAGE::"Item Card", Item);
                        //HEI.02<<
                    end;
                }
            }
        }
    }
}

