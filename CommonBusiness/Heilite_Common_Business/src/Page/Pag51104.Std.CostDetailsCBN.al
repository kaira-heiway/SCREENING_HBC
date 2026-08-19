page 51104 "Std. Cost Details CBN"
{
    // version HEI.03

    // HEI.01 CHG2157335 HB2876 NORRIQ KOROLA04 8/4/2022
    //   #Page has been created
    // HEI.02 CHG2157335 HB2876 NORRIQ KOROLA04 18.08.2022
    //   #SetSTDCostLineDetails() - modified
    // HEI.03 CHG2157335 HB2876 NORRIQ KOROLA04 26.08.2022
    //   #SetSTDCostLineDetails(),SetSourceData(),SetSRTCostRootItem() - modofied

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Page ID-50496
    //BC Upgrade KAPOOV01  <<

    //FDD DTW 16 Std Cost Details list page.

    Caption = 'Std. Cost Details';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "COGS Alloc STD Price Line FND";
    SourceTableTemporary = true;
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
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                    Visible = false;
                }
                field("COGS Allocation"; Rec."COGS Allocation")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                    Visible = false;
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    Visible = false;
                }
                field(Company; Rec.Company)
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                    Visible = false;
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                    Visible = false;
                }
                field("Period Number"; Rec."Period Number")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                    Visible = false;
                }
                field("BOM Level"; Rec."BOM Level")
                {
                }
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                    Visible = false;
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
                field("Item UoM"; Rec."Item UoM")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Qty. per BUOM of Parent Good';
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                }
                field("Unit Volume HL"; Rec."Unit Volume HL")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                    Visible = false;
                }
                field("Quantity HL"; Rec."Quantity HL")
                {
                    Style = Strong;
                    StyleExpr = Rec."COGS Allocation" = Rec."COGS Allocation"::"Finished Goods";
                    Visible = false;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    Visible = false;
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
                field("Cost Raw or Pack Mat."; Rec."Cost Raw or Pack Mat.")
                {
                    Caption = 'Cost of BOM';
                    ToolTip = 'Formula: Qty. per 1 HL of Finished Good * Unit Cost Raw&Pack.';
                }
                field("Cost. Prod. Fix. per HL of FG"; Rec."Cost. Prod. Fix. per HL of FG")
                {
                    Caption = 'Cost of BUOM';
                    DecimalPlaces = 2 : 5;
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
                field("Cost Prod. Fix. Exp. BuOM"; Rec."Cost Prod. Fix. Exp. BuOM")
                {
                    Caption = 'Processing Cost per BuOM';
                    ToolTip = 'Formula: (Setup time * Unit cost of the Work center)/ Batch size + (Run time/ Lot size * Unit cost of the Work center) / Batch size';
                }
                field("Cost Energy & Water"; Rec."Cost Energy & Water")
                {
                    Visible = false;
                }
                field("Cost Other Variable Exp."; Rec."Cost Other Variable Exp.")
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
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        SetSourceData();
    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        InventorySetup: Record "Inventory Setup";
        GlobalStdCostWS: Record "Standard Cost Worksheet";
        LastLineNo: Integer;

    local procedure SetSourceData();
    var
        //SKU: Record "Stockkeeping Unit"; //BC UPGRADE PATHAA02 FDD DTW 16
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
        CompItem: Record Item;
        ItemUOM: Record "Item Unit of Measure";
    begin
        if not Rec.ISTEMPORARY then ERROR('');
        if GlobalStdCostWS.Type <> GlobalStdCostWS.Type::Item then ERROR('');
        if GlobalStdCostWS."No." = '' then ERROR('');

        InventorySetup.GET;
        StartingDate := WORKDATE;
        EndingDate := WORKDATE;

        Rec.RESET;
        if not Rec.ISEMPTY then
            Rec.DELETEALL;
        //BC UPGRADE PATHAA02 FDD DTW 16>>
        //SKU.GET(GlobalStdCostWS."Location Code", GlobalStdCostWS."No.", '');  //BC Upgrade KAPOOV01 Drink-IT
        //ProdBOMHeader.GET(SKU."Production BOM No.");
        CompItem.GET(GlobalStdCostWS."No.");
        ProdBOMHeader.GET(CompItem."Production BOM No.");
        //BC UPGRADE PATHAA02 FDD DTW 16<<    

        SetSRTCostRootItem;
        //HEI.03>>
        ItemUOM.GET(Rec."Item No.", Rec."Prod. BOM Header UoM");
        //HEI.03<<

        //BC UPGRADE PATHAA02 FDD DTW 16>>
        //ProdBOMLine.SETRANGE("Production BOM No.", SKU."Production BOM No.");
        ProdBOMLine.setrange("Production BOM No.", Compitem."Production BOM No.");
        //BC UPGRADE PATHAA02 FDD DTW 16<<
        ProdBOMLine.SETRANGE("Version Code", '');
        ProdBOMLine.SETFILTER("Starting Date", '%1|..%2', 0D, StartingDate);
        ProdBOMLine.SETFILTER("Ending Date", '%1|%2..', 0D, EndingDate);
        if ProdBOMLine.FINDSET then
            repeat
                SetSTDCostLineDetails(GlobalStdCostWS."No.", 1, ProdBOMLine);
                //HEI.03>>
                if ItemUOM."Qty. per Unit of Measure" <> 0 then begin
                    Rec."Cost. Prod. Fix. per HL of FG" := Rec."Cost Raw or Pack Mat." / ItemUOM."Qty. per Unit of Measure";
                    Rec.MODIFY;
                end;
            //HEI.03<<
            until ProdBOMLine.NEXT = 0;
    end;

    local procedure SetSRTCostRootItem();
    var
        //SKU: Record "Stockkeeping Unit"; //BC UPGRADE PA
        ProdBOMHeader: Record "Production BOM Header";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
    begin
        //SKU.GET(GlobalStdCostWS."Location Code", GlobalStdCostWS."No.", '');
        Item.GET(GlobalStdCostWS."No."); //BC UPGRADE PATHAA02 FDD DTW 16

        CLEAR(Rec);
        Rec."Processing Date" := WORKDATE;
        Rec.Company := COMPANYNAME;
        Rec."Fiscal Year" := DATE2DMY(EndingDate, 3);
        Rec."Period Number" := DATE2DMY(EndingDate, 2);
        Rec."Parent Item No." := GlobalStdCostWS."No.";
        Rec."Item No." := GlobalStdCostWS."No.";
        Rec."BOM Level" := 0;
        Rec.Quantity := 1;
        Rec."Qty. Including Scrap" := 1;
        Rec."Quantity HL" := 1;
        Rec."COGS Allocation" := Rec."COGS Allocation"::"Finished Goods";
        //BC UPGARDE PATHAA02 FDD DTW 16>>
        // Rec."Production BOM No." := SKU."Production BOM No.";
        // Rec."Routing No." := SKU."Routing No.";
        Rec."Production BOM No." := Item."Production BOM No.";
        Rec."Routing No." := Item."Routing No.";
        //BC UPGARDE PATHAA02 FDD DTW 16<<

        Item.GET(Rec."Item No.");
        Rec.Description := Item.Description;
        //Rec."Unit Volume HL" := Item."Unit Volume HL";  //BC Upgrade KAPOOV01 Drink-IT
        Rec."Unit Volume HL" := Item."Unit Volume"; //BC UPGRADE PATHAA02
        Rec."Item Category Code" := Item."Item Category Code";
        Rec."Qty. per HL of FG" := 1;

        //convert Item UoM to HL
        ProdBOMHeader.RESET;
        if ProdBOMHeader.GET(Rec."Production BOM No.") then
            Rec."Prod. BOM Header UoM" := ProdBOMHeader."Unit of Measure Code";
        ItemUnitofMeasure.RESET;
        if ItemUnitofMeasure.GET(Rec."Item No.", Rec."Prod. BOM Header UoM") then
            Rec."Prod. BOM Qty. per BUoM" := ItemUnitofMeasure."Qty. per Unit of Measure";
        Rec."Prod. BOM Header in HL" := Rec."Prod. BOM Qty. per BUoM" * Rec."Unit Volume HL";

        //Routing info
        RoutingLine.RESET;
        RoutingLine.SETRANGE("Routing No.", Rec."Routing No.");
        RoutingLine.SETRANGE("Version Code", '');
        if RoutingLine.FINDFIRST then begin
            Rec."Work Center No." := RoutingLine."Work Center No.";
            if RoutingLine."Setup Time" <> 0 then
                Rec."Setup Time" := RoutingLine."Setup Time"
            else
                Rec."Setup Time" := 1;
            if RoutingLine."Run Time" <> 0 then
                Rec."Run Time" := RoutingLine."Run Time"
            else
                Rec."Run Time" := 1;
            if RoutingLine."Batch Size FND" <> 0 then
                Rec."Batch Size" := RoutingLine."Batch Size FND"
            else
                Rec."Batch Size" := 1;
            if RoutingLine."Lot Size" <> 0 then
                Rec."Lot Size" := RoutingLine."Lot Size"
            else
                Rec."Lot Size" := 1;
        end;

        //Unit Cost for both Raw&Pack and Prod Fix Exp
        if Rec."Work Center No." <> '' then begin
            WorkCenter.GET(Rec."Work Center No.");
            Rec."Unit Cost of Work Center" := WorkCenter."Direct Unit Cost";
        end;

        if Rec."Work Center No." <> '' then begin
            if Rec."Setup Time" <> 1 then
                Rec."Cost Prod. Fix. Exp. BuOM" := Rec."Setup Time" * Rec."Unit Cost of Work Center" / Rec."Batch Size"
            else
                Rec."Cost Prod. Fix. Exp. BuOM" += (Rec."Run Time" / Rec."Lot Size" * Rec."Unit Cost of Work Center") / Rec."Batch Size";
        end;

        //HEI.03>>
        //IF Rec."Unit Volume HL" <> 0 THEN
        //  Rec."Cost. Prod. Fix. per HL of FG" := Rec."Cost Prod. Fix. Exp. BuOM" / Rec."Unit Volume HL";
        Rec."Cost. Prod. Fix. per HL of FG" := 0;
        //HEI.03<<

        if WorkCenter."Direct Unit Cost" <> 0 then begin
            Rec."Cost Energy & Water" := ((WorkCenter."Estimated Energy FND" + WorkCenter."Estimated Water Consmp. FND") / WorkCenter."Direct Unit Cost") * Rec."Cost. Prod. Fix. per HL of FG";
            Rec."Cost Other Variable Exp." := (WorkCenter."Other Variable Expenses FND" / WorkCenter."Direct Unit Cost") * Rec."Cost. Prod. Fix. per HL of FG";
            Rec."Cost. Prod. Fix. per HL of FG" := (WorkCenter."Production Fix Expenses FND" / WorkCenter."Direct Unit Cost") * Rec."Cost. Prod. Fix. per HL of FG";
        end;

        Rec.INSERT;
    end;

    local procedure SetSTDCostLineDetails(SubParentNo: Code[20]; Level: Integer; ProdBOMLine: Record "Production BOM Line");
    var
        //SKU: Record "Stockkeeping Unit"; //BC UPGRADE PATHAA02 FDD DTW 16
        ProdBOMHeader: Record "Production BOM Header";
        CurrentBOMLevel: Integer;
        BasePriceSTDCost: Record "Base Price STD Cost Calc. FND";
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
        Item: Record Item;
        Item2: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        BasePriceSTDCostCalc: Record "Base Price STD Cost Calc. FND";
        StdCostWS: Record "Standard Cost Worksheet";
    begin
        CLEAR(Rec);
        Rec."Entry No." := GetNextEntryNo;
        Rec."Processing Date" := WORKDATE;
        Rec."Fiscal Year" := DATE2DMY(EndingDate, 3);
        Rec."Period Number" := DATE2DMY(EndingDate, 2);
        Rec."Parent Item No." := SubParentNo;
        Rec."Sub-Parent Item No." := SubParentNo;
        Rec."Item No." := ProdBOMLine."No.";
        Rec."Item UoM" := ProdBOMLine."Unit of Measure Code";
        Rec."BOM Level" := Level;
        Rec.Quantity := ProdBOMLine.Quantity;
        Rec."Quantity per" := ProdBOMLine."Quantity per";
        Rec."Scrap %" := ProdBOMLine."Scrap %";
        if Rec."Scrap %" <> 0 then
            Rec."Qty. Including Scrap" := Rec.Quantity + (Rec."Scrap %" / 100) * Rec.Quantity
        else
            Rec."Qty. Including Scrap" := Rec.Quantity;

        Item.GET(Rec."Item No.");
        Rec.Description := Item.Description;
        //BC Upgrade KAPOOV01 Drink-IT >>
        // Rec."Unit Volume HL" := Item."Unit Volume HL";
        // Rec."Quantity HL" := Rec.Quantity * Item."Unit Volume HL";
        //BC Upgrade KAPOOV01 Drink-IT <<
        Rec."Item Category Code" := Item."Item Category Code";

        Item2.RESET;
        Item2.SETRANGE("No.", Rec."Item No.");
        Item2.SETFILTER("Item Category Code", InventorySetup."Raw Materials Item CatCode FND");//BC Upgrade Kamnay01 //Bug fix 
        if Item2.FINDFIRST then
            Rec."COGS Allocation" := Rec."COGS Allocation"::"Raw Materials"
        else begin
            Item2.RESET;
            Item2.SETRANGE("No.", Rec."Item No.");
            Item2.SETFILTER("Item Category Code", InventorySetup."Pack. Material ItemCatCode FND");//BC Upgrade Kamnay01 //Bug fix 
            if Item2.FINDFIRST then
                Rec."COGS Allocation" := Rec."COGS Allocation"::"Packaging Materials"
            else
                Rec."COGS Allocation" := Rec."COGS Allocation"::"Prod Fix Exp";
        end;

        //Unit cost only for Raw&Pack
        if (Rec."COGS Allocation" = Rec."COGS Allocation"::"Packaging Materials") or (Rec."COGS Allocation" = Rec."COGS Allocation"::"Raw Materials") then begin
            BasePriceSTDCostCalc.RESET;
            BasePriceSTDCostCalc.SETRANGE("Item No.", Rec."Item No.");
            BasePriceSTDCostCalc.SETFILTER("Starting Date", '%1|..%2', 0D, StartingDate);
            BasePriceSTDCostCalc.SETFILTER("Ending Date", '%1|%2..', 0D, EndingDate);
            BasePriceSTDCostCalc.SETRANGE("Unit of Measure Code", Rec."Item UoM");
            if BasePriceSTDCostCalc.FINDFIRST then begin
                Rec."Unit Cost Raw&Pack" := BasePriceSTDCostCalc."Direct Unit Cost";
                Rec."Cost Raw or Pack Mat." := Rec."Qty. Including Scrap" * Rec."Unit Cost Raw&Pack";
            end;
        end;

        //HEI.02>>
        StdCostWS.SETRANGE("Standard Cost Worksheet Name", GlobalStdCostWS."Standard Cost Worksheet Name");
        StdCostWS.SETRANGE("No.", Rec."Item No.");
        //StdCostWS.SETRANGE("Location Code", GlobalStdCostWS."Location Code"); //BC Upgrade KAPOOV01 Drink-IT
        if StdCostWS.FINDFIRST then
            //HEI.03>>
            //"Cost Raw or Pack Mat." := StdCostWS."New Standard Cost";
            Rec."Cost Raw or Pack Mat." := StdCostWS."New Standard Cost" * Rec."Qty. Including Scrap";
        //HEI.03<<
        //HEI.02<<

        CalcQtyperHL(Rec);
        Rec.INSERT;
    end;

    procedure SetContextRecord(var StdCostWS: Record "Standard Cost Worksheet");
    begin
        GlobalStdCostWS.COPY(StdCostWS);
    end;

    local procedure GetNextEntryNo(): Integer;
    begin
        LastLineNo += 1;
        exit(LastLineNo);
    end;

    local procedure CalcQtyperHL(var COGSAllocSTDPriceLine: Record "COGS Alloc STD Price Line FND");
    var
        COGSAlloconSTDPriceLine2: Record "COGS Alloc STD Price Line FND";
    begin
        if COGSAllocSTDPriceLine."BOM Level" = 0 then
            COGSAllocSTDPriceLine."Qty. per HL of FG" := 1
        else begin
            COGSAlloconSTDPriceLine2.RESET;
            COGSAlloconSTDPriceLine2.SETCURRENTKEY(Company, "Fiscal Year", "Period Number", "Parent Item No.");
            COGSAlloconSTDPriceLine2.SETRANGE(Company, COGSAllocSTDPriceLine.Company);
            COGSAlloconSTDPriceLine2.SETRANGE("Fiscal Year", COGSAllocSTDPriceLine."Fiscal Year");
            COGSAlloconSTDPriceLine2.SETRANGE("Period Number", COGSAllocSTDPriceLine."Period Number");
            COGSAlloconSTDPriceLine2.SETRANGE("Parent Item No.", COGSAllocSTDPriceLine."Parent Item No.");
            COGSAlloconSTDPriceLine2.SETRANGE("Item No.", COGSAllocSTDPriceLine."Sub-Parent Item No.");
            COGSAlloconSTDPriceLine2.SETRANGE("BOM Level", COGSAllocSTDPriceLine."BOM Level" - 1);
            if COGSAlloconSTDPriceLine2.FINDFIRST then begin
                if COGSAlloconSTDPriceLine2."Prod. BOM Header in HL" <> 0 then
                    COGSAllocSTDPriceLine."Qty. per HL of FG" := COGSAllocSTDPriceLine."Qty. Including Scrap" * COGSAlloconSTDPriceLine2."Qty. per HL of FG" / COGSAlloconSTDPriceLine2."Prod. BOM Header in HL"
                else
                    COGSAllocSTDPriceLine."Qty. per HL of FG" := COGSAllocSTDPriceLine."Qty. Including Scrap" * COGSAlloconSTDPriceLine2."Qty. per HL of FG"
            end;
        end;
    end;
}

