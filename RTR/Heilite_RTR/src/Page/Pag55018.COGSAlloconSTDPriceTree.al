page 55018 "COGS Alloc on STD Price Tree"
{
    // version HEI.01

    // HEI.01 HB2605 - CHG2132673 IBM BULIMC01 06.04.2022 # COGS Allocation - new page created in order to see the tree of all BOM lines

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Page ID-50490
    //BC Upgrade KAPOOV01  <<

    Caption = 'COGS Alloc on STD Price Tree';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "COGS Alloc STD Price Line FND";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending);

    ApplicationArea = All;   //BC Upgrade KAPOOV01
    UsageCategory = Lists;  //BC Upgrade KAPOOV01

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = Rec."BOM Level";
                ShowAsTree = true;
                field("Entry No."; Rec."Entry No.")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("COGS Allocation"; Rec."COGS Allocation")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    Visible = false;
                }
                field(Company; Rec.Company)
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Period Number"; Rec."Period Number")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("BOM Level"; Rec."BOM Level")
                {
                }
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Sub-Parent Item No."; Rec."Sub-Parent Item No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field(Description; Rec.Description)
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                }
                field("Routing No."; Rec."Routing No.")
                {
                }
                field("Prod. BOM Header UoM"; Rec."Prod. BOM Header UoM")
                {
                }
                field("Prod. BOM Qty. per BUoM"; Rec."Prod. BOM Qty. per BUoM")
                {
                }
                field("Prod. BOM Header in HL"; Rec."Prod. BOM Header in HL")
                {
                }
                field("Item UoM"; Rec."Item UoM")
                {
                }
                field("Qty. per HL of FG"; Rec."Qty. per HL of FG")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Unit Volume HL"; Rec."Unit Volume HL")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Quantity HL"; Rec."Quantity HL")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Quantity per"; Rec."Quantity per")
                {
                }
                field("Scrap %"; Rec."Scrap %")
                {
                }
                field("Qty. Including Scrap"; Rec."Qty. Including Scrap")
                {
                }
                field("Unit Cost Raw&Pack"; Rec."Unit Cost Raw&Pack")
                {
                }
                field("Unit Cost of Work Center"; Rec."Unit Cost of Work Center")
                {
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                }
                field("Setup Time"; Rec."Setup Time")
                {
                }
                field("Run Time"; Rec."Run Time")
                {
                }
                field("Batch Size"; Rec."Batch Size")
                {
                }
                field("Lot Size"; Rec."Lot Size")
                {
                }
                field("Cost Raw or Pack Mat."; Rec."Cost Raw or Pack Mat.")
                {
                    ToolTip = 'Formula: Qty. per 1 HL of Finished Good * Unit Cost Raw&Pack.';
                }
                field("Cost Prod. Fix. Exp. BuOM"; Rec."Cost Prod. Fix. Exp. BuOM")
                {
                    ToolTip = 'Formula: (Setup time * Unit cost of the Work center)/ Batch size + (Run time/ Lot size * Unit cost of the Work center) / Batch size';
                }
                field("Cost. Prod. Fix. per HL of FG"; Rec."Cost. Prod. Fix. per HL of FG")
                {
                    ToolTipML = ENU = 'Formula: If Parent Item No. = Item No. then Cost Prod. Fix. Exp. (COGS) per BuOM / Unit Volume HL else Cost Prod. Fix. Exp.(COGS) per BuOM * Qty. per 1 HL of Finished Good * Unit Cost of Work Center';
                }
                field("Cost Energy & Water"; Rec."Cost Energy & Water")
                {
                }
                field("Cost Other Variable Exp."; Rec."Cost Other Variable Exp.")
                {
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

