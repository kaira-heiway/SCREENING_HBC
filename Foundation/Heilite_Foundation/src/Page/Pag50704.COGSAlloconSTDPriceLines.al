page 50704 "COGS Alloc on STD Price Lines"
{
    // version HEI.01,HEI.02

    // HEI.01 HB2605 - CHG2132673 IBM NASTAA02 15.03.2022 # COGS Allocation
    //   # New Page created
    // HEI.02 HB2605 - CHG2132673 IBM BULIMC01 06.04.2022 # COGS Allocation - new changes
    // HEI.03 CHG2135085 SAHAL01      24.03.2022
    //   # Added New Fields - Cost Energy & Water
    //                      - Cost Other Variable Exp.

    // BC Upgrade KUMARS145 Nav ID Page 50489 "COGS Alloc on STD Price Lines"

    //PATHAA02- 04.04.26 #FDD-COGS-[PID803,FDD-DTW-022,IBM GAP DTW54]
    // Application Area and Usage Category added to check data flow

    Caption = 'COGS Allocation on STD Price Lines';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "COGS Alloc STD Price Line FND";
    SourceTableView = sorting("Entry No.") order(ascending);
    //UsageCategory = None;
    ApplicationArea = all; //PATHAA02 04.04.26
    UsageCategory = Lists; //PATHAA02 04.04.26

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Unique identifier for the record entry.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("COGS Allocation"; Rec."COGS Allocation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Allocation of Cost of Goods Sold for this item.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Date when the record was processed.';
                    Visible = false;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = all;
                    ToolTip = 'Company associated with the record.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                    ApplicationArea = all;
                    ToolTip = 'Financial year for which the data applies.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Period Number"; Rec."Period Number")
                {
                    ApplicationArea = all;
                    ToolTip = 'Accounting period within the fiscal year.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("BOM Level"; Rec."BOM Level")
                {
                    ApplicationArea = all;
                    ToolTip = 'Level of the Bill of Materials hierarchy.';
                }
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Item number of the parent product.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Sub-Parent Item No."; Rec."Sub-Parent Item No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Item number of the sub-parent product.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Unique identifier for the item.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Description of the item.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Category code assigned to the item.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Production Bill of Materials number.';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Routing number for production operations.';
                }
                field("Prod. BOM Header UoM"; Rec."Prod. BOM Header UoM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Unit of measure for the production BOM header.';
                }
                field("Prod. BOM Qty. per BUoM"; Rec."Prod. BOM Qty. per BUoM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Quantity per base unit of measure in the production BOM.';
                }
                field("Prod. BOM Header in HL"; Rec."Prod. BOM Header in HL")
                {
                    ApplicationArea = all;
                    ToolTip = 'Production BOM header quantity expressed in hectoliters.';
                }
                field("Item UoM"; Rec."Item UoM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Unit of measure for the item.';
                }
                field("Qty. per HL of FG"; Rec."Qty. per HL of FG")
                {
                    ApplicationArea = all;
                    ToolTip = 'Quantity per hectoliter of finished goods.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Total quantity of the item.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Unit Volume HL"; Rec."Unit Volume HL")
                {
                    ApplicationArea = all;
                    ToolTip = 'Volume per unit in hectoliters.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Quantity HL"; Rec."Quantity HL")
                {
                    ApplicationArea = all;
                    ToolTip = 'Total quantity expressed in hectoliters.';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = all;
                    ToolTip = 'Quantity per specified unit.';
                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ApplicationArea = all;
                    ToolTip = 'Percentage of scrap expected during production.';
                }
                field("Qty. Including Scrap"; Rec."Qty. Including Scrap")
                {
                    ApplicationArea = all;
                    ToolTip = 'Quantity including scrap allowance.';
                }
                field("Unit Cost Raw&Pack"; Rec."Unit Cost Raw&Pack")
                {
                    ApplicationArea = all;
                    ToolTip = 'Cost per unit for raw and packaging materials.';
                }
                field("Unit Cost of Work Center"; Rec."Unit Cost of Work Center")
                {
                    ApplicationArea = all;
                    ToolTip = 'Cost per unit for work center operations.';
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Identifier for the work center.';
                }
                field("Setup Time"; Rec."Setup Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Time required to set up the work center.';
                }
                field("Run Time"; Rec."Run Time")
                {
                    ApplicationArea = all;
                    ToolTip = 'Time required to execute production operations.';
                }
                field("Batch Size"; Rec."Batch Size")
                {
                    ApplicationArea = all;
                    ToolTip = 'Size of each production batch.';
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = all;
                    ToolTip = 'Size of each production lot.';
                }
                field("Cost Raw or Pack Mat."; Rec."Cost Raw or Pack Mat.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Formula: Qty. per 1 HL of Finished Good * Unit Cost Raw&Pack.';
                }
                field("Cost Prod. Fix. Exp. BuOM"; Rec."Cost Prod. Fix. Exp. BuOM")
                {
                    ApplicationArea = all;
                    ToolTip = 'Formula: (Setup time * Unit cost of the Work center)/ Batch size + (Run time/ Lot size * Unit cost of the Work center) / Batch size';
                }
                field("Cost. Prod. Fix. per HL of FG"; Rec."Cost. Prod. Fix. per HL of FG")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Formula: If Parent Item No. = Item No. then Cost Prod. Fix. Exp. (COGS) per BuOM / Unit Volume HL else Cost Prod. Fix. Exp.(COGS) per BuOM * Qty. per 1 HL of Finished Good * Unit Cost of Work Center';
                }
                field("Cost Energy & Water"; Rec."Cost Energy & Water")
                {
                    ApplicationArea = all;
                    ToolTip = 'Cost incurred for energy and water usage.';
                }
                field("Cost Other Variable Exp."; Rec."Cost Other Variable Exp.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Other variable expenses related to production.';
                }
            }
        }
    }

    actions
    {
    }

    local procedure ViewSubParents();
    var
        COGSAllocLinesPage: Page "COGS Alloc on STD Price Lines";
        COGSAllocLineRec: Record "COGS Alloc STD Price Line FND";
    begin
        //HEI.02>>
        COGSAllocLineRec.SETRANGE(Company, Rec.Company);
        COGSAllocLineRec.SETRANGE("Fiscal Year", Rec."Fiscal Year");
        COGSAllocLineRec.SETRANGE("Period Number", Rec."Period Number");
        COGSAllocLineRec.SETRANGE("Parent Item No.", Rec."Parent Item No.");
        COGSAllocLineRec.SETRANGE("Sub-Parent Item No.", Rec."Item No.");

        CLEAR(COGSAllocLinesPage);
        COGSAllocLinesPage.SETTABLEVIEW(COGSAllocLineRec);
        COGSAllocLinesPage.LOOKUPMODE(true);
        COGSAllocLinesPage.RUNMODAL();
        //HEI.02<<
    end;
}

