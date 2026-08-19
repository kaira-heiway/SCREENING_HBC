page 50446 "Internal Transfer Allocation"
{
    // version HEI.06

    // HEI.01 CHG2095415 IBM BULIMC01 11.03.2021#new page created for Shipping Costs related to Transfers
    // HEI.02 CHG2130188 IBM BULIMC01 13/10/2021 #
    //   #new fields added: "Distribution Type", "Parent Line No.", "Reversed"
    //   #Style property changed for all the fields
    // HEI.03 CHG2132177 BULIMC01 IBM 13/04/2022# Own fleet: new fields added
    // HEI.04 HB2618 - CHG2132177 IBM NASTAA02 12.05.2022 # C2S - Own Fleet Logistic Cost
    //   # Changed the Name for Field 136 from "Distance per Drop Allocation Own Fleet" to "Distance Allocation Own Fleet"
    // HEI.05 CHG2178734 IBM SISUM01 07/11/2022 #add Lot No.
    // HEI.06 CHG2167931 IBM SISUM01 19/11/2022 #add new fields. The ones marked with description HEI.13

    Caption = 'Internal Transfer Allocation';
    Editable = false;
    PageType = List;
    SourceTable = "Shipping Cost Allocation FND";
    SourceTableView = sorting("Entry No.")
                      ORDER(Ascending)
                      where("Source Document" = FILTER("Outbound Transfer"));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Distribution Type"; rec."Distribution Type")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Distribution Type field.';
                }
                field("Parent Line No."; rec."Parent Line No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Parent Line No. field.';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("No."; rec."No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Line No."; rec."Line No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Source Document"; rec."Source Document")
                {
                    StyleExpr = LineStyle;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Source Document field.';
                }
                field("Destination No."; rec."Destination No.")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Net Weight * (Total Shipping Cost Amount/Total Net Weight)';
                }
                field("Item No."; rec."Item No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; rec.Description)
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Only RPM Transportation"; rec."Only RPM Transportation")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Only RPM Transportation field.';
                }
                field("Lot No."; rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Originial Lot & Location Code"; rec."Originial Lot & Location Code")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Originial Lot & Location Code field.';
                }
                field("Location Code"; rec."Location Code")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Posted Source Document No."; rec."Posted Source Document No.")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Posted Source Document No. field.';

                    trigger OnDrillDown();
                    begin
                        CLEAR(ItemLedgerEntriesPage);

                        ItemLedgEntry.RESET();
                        ItemLedgEntry.SETRANGE("Order No.", rec."Source No.");
                        ItemLedgEntry.SETRANGE("Document Line No.", rec."Source Line No.");
                        ItemLedgEntry.SETRANGE("Lot No.", rec."Lot No.");
                        ItemLedgEntry.SETRANGE("Item No.", rec."Item No.");
                        ItemLedgerEntriesPage.SETTABLEVIEW(ItemLedgEntry);
                        ItemLedgerEntriesPage.LOOKUPMODE(true);
                        if ItemLedgerEntriesPage.RUNMODAL() = ACTION::LookupOK then;
                    end;
                }
                field("Quantity (Base UoM)"; rec."Quantity (Base UoM)")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Quantity (Base UoM) field.';
                }
                field("Net Weight (Kg)"; rec."Net Weight (Kg)")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Net Weight (Kg) field.';
                }
                field("Total Net Weight (Kg)"; rec."Total Net Weight (Kg)")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Total Net Weight (Kg) field.';
                }
                field("Total Shipping Cost Amount"; rec."Total Shipping Cost Amount")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Internal Transfer Allocated Amount / Net Weight';
                }
                field("Primary Allocated Amount"; rec."Primary Allocated Amount")
                {
                    Caption = 'Internal Transfer';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = '"Formula: Net Weight * (Total Shipping Cost Amount/Total Net Weight) "';
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                }
                field(Route; Rec.Route)
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Route field.';
                }
                field("Route Planning No."; rec."Route Planning No.")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Route Planning No. field.';
                }
                field("Quantity HL"; rec."Quantity HL")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Quantity HL field.';
                }
                field("Unit Cost-Internal Transfer ST"; rec."Unit Cost-Internal Transfer ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Cumulative Unit Cost-Internal Transfer field.';
                }
                field("Avg. Cost-Internal Transfer ST"; rec."Avg. Cost-Internal Transfer ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Avg. Cost-Internal Transfer ST field.';
                }
                field("IT Cost-Internal Transfer ST"; rec."IT Cost-Internal Transfer ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the IT Cost-Internal Transfer ST field.';
                }
                field("No. of Pallets"; rec."No. of Pallets")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the No. of Pallets field.';
                }
                field("Picking Factor"; rec."Picking Factor")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Picking Factor field.';
                }
                field("Period Date"; rec."Period Date")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Period Date field.';
                }
                field("Period Picking Factor"; rec."Period Picking Factor")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Period Picking Factor field.';
                }
                field("Period Net Weight (Kg)"; rec."Period Net Weight (Kg)")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Period Net Weight (Kg) field.';
                }
                field("Warehouse Handling"; rec."Warehouse Handling")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Warehouse Handling field.';
                }
                field("Warehouse Overheads"; rec."Warehouse Overheads")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Warehouse Overheads field.';
                }
                field("General Overheads"; rec."General Overheads")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the General Overheads field.';
                }
                field("Period G/L Cost Whse. Handling"; rec."Period G/L Cost Whse. Handling")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Period G/L Cost Whse. Handling field.';
                }
                field("Period G/L Cost Whse. Overhead"; rec."Period G/L Cost Whse. Overhead")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Period G/L Cost Whse. Overhead field.';
                }
                field("Period G/L Cost Gen. Overheads"; rec."Period G/L Cost Gen. Overheads")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Period G/L Cost Gen. Overheads field.';
                }
                field("Avg. Cost-General Overheads ST"; rec."Avg. Cost-General Overheads ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Sum of General Overheads / Sum of Net Weight (Kg) for the same Item No. and Lot No. & Destination No.';
                }
                field("Avg. Cost-Whse. Handling ST"; rec."Avg. Cost-Whse. Handling ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Sum of Warehouse Handling / Sum of Picking Factor for the same Item No. and Lot No. & Destination No.';
                }
                field("Avg. Cost-Whse. Overhead ST"; rec."Avg. Cost-Whse. Overhead ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Sum of Warehouse Overheads / Sum of Net Weight (Kg) for the same Item No. and Lot No. & Destination No.';
                }
                field("IT Cost-General Overheads ST"; rec."IT Cost-General Overheads ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: General Overheads/Net Weight (Kg) for the same Item No. and Original Lot&Location';
                }
                field("IT Cost-Whse. Handling ST"; rec."IT Cost-Whse. Handling ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Warehouse Handling/Picking Factor for the same Item No. and Original Lot&Location';
                }
                field("IT Cost-Whse. Overhead ST"; rec."IT Cost-Whse. Overhead ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTipML = ENU = 'ENU=Formula: Warehouse Overheads/Net Weight (Kg) for the same Item No. and Original Lot&Location';
                }
                field("Unit Cost-General Overheads ST"; rec."Unit Cost-General Overheads ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = '"Formula:  Average Cost-General Overheads ST+ IT Cost-General Overheads ST  "';
                }
                field("Unit Cost-Whse. Handling ST"; rec."Unit Cost-Whse. Handling ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = '"Formula: Average Cost-Warehouse Handling ST + IT Cost-Warehouse Handling ST  "';
                }
                field("Unit Cost-Whse. Overhead ST"; rec."Unit Cost-Whse. Overhead ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Average Cost-Warehouse Overheads ST+ IT Cost-Warehouse Overheads ST';
                }
                field("Period Net Weight SKU/Lot"; rec."Period Net Weight SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Period Net Weight per SKU/Lot No. in Location/Destination field.';
                }
                field("Period Picking Factor SKU/Lot"; rec."Period Picking Factor SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Period Picking Factor per SKU/Lot No. in Location/Destination field.';
                }
                field("Period Transfers per SKU/Lot"; rec."Period Transfers per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the "Period Internal Transfers per SKU/Lot No. " field.';
                }
                field("Period Gen. Overh. per SKU/Lot"; rec."Period Gen. Overh. per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the "Period General Overheads per SKU/Lot No. " field.';
                }
                field("Period Whs. Overh. per SKU/Lot"; rec."Period Whs. Overh. per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the "Period Warehouse Overheads per SKU/Lot No. " field.';
                }
                field("Period Whse. Hand. per SKU/Lot"; rec."Period Whse. Hand. per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the "Period Warehouse Handling per SKU/Lot No. " field.';
                }
                field(Reversed; Reversed)
                {
                    Caption = 'Reversed';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Own Fleet"; rec."Own Fleet")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Own Fleet field.';
                }
                field("Period G/L Cost Own Fleet"; rec."Period G/L Cost Own Fleet")
                {
                    ToolTipML = ENU = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations where C2S Name = Own Fleet.';
                }
                field(Distance; rec.Distance)
                {
                    ToolTip = 'Value of the field "Distance" related to the field "No." from the Posted Whse. Shipment Header table.';
                }
                field("Period Distance"; rec."Period Distance")
                {
                    ToolTip = 'Sum of Distance values for the same Period Date where Own Fleet is Yes.';
                }
                field("No. of Drops"; rec."No. of Drops")
                {
                    ToolTip = 'The count using the field "Destination No." for the same value in the field "No." related to each shipment.';
                }
                field("Period Drop Counts"; rec."Period Drop Counts")
                {
                    ToolTip = 'Sum of No. Drops values for the same Period Date where Own Fleet is Yes.';
                }
                field("Weight Allocation Own Fleet"; rec."Weight Allocation Own Fleet")
                {
                    ToolTip = 'Formula: Net Weight[Kg] / Period Net Weight[Kg](Own Fleet) * Net Weight Allocation %[Whse. Cost Alloc. Setup] * Period G/L Own Fleet';
                }
                field("No. of Drops All. Own Fleet"; rec."No. of Drops All. Own Fleet")
                {
                    ToolTip = 'Formula: No. of drops / Period Drops Count * No. of Drops Allocation %[Whse. Cost Alloc. Setup] * Period G/L Own Fleet';
                }
                field("Distance Allocation Own Fleet"; rec."Distance Allocation Own Fleet")
                {
                    ToolTip = 'Formula: Distance / Period Distance * Distance Allocation %[Whse. Cost Alloc. Setup] * Period G/L Own Fleet';
                }
                field("Processing Date"; rec."Processing Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Processing Date field.';
                }
                field("OVE Prd G/L Whse Hand Cost"; rec."OVE Prd G/L Whse Hand Cost")
                {
                    ToolTip = 'Specifies the value of the OVE Period G/L Cost Whse. Handling field.';
                }
                field("OVE Warehouse Handling"; rec."OVE Warehouse Handling")
                {
                    ToolTip = 'Specifies the value of the OVE Warehouse Handling field.';
                }
                field("OVE Avg. Cost-Whse. Handl. ST"; rec."OVE Avg. Cost-Whse. Handl. ST")
                {
                    ToolTip = 'Specifies the value of the OVE Average Cost-Warehouse Handling ST field.';
                }
                field("OVE IT Cost-Whse. Handling ST"; rec."OVE IT Cost-Whse. Handling ST")
                {
                    ToolTip = 'Specifies the value of the OVE IT Cost-Whse. Handling ST field.';
                }
                field("OVE Unit Cost-Whse. Handl. SO"; rec."OVE Unit Cost-Whse. Handl. SO")
                {
                    ToolTip = 'Specifies the value of the OVE Unit Cost-Whse. Handling SO field.';
                }
                field("OVE Unit Cost-Whse. Handl. ST"; rec."OVE Unit Cost-Whse. Handl. ST")
                {
                    ToolTip = 'Specifies the value of the OVE Cumulative Unit Cost-Warehouse Handling ST field.';
                }
                field("OVE Prd. Whse. Hand. SKU/Lot"; rec."OVE Prd. Whse. Hand. SKU/Lot")
                {
                    ToolTip = 'Specifies the value of the "OVE Period Warehouse Handling per SKU/Lot No. " field.';
                }
                field("TRP Prd G/L Whse Hand Cost"; rec."TRP Prd G/L Whse Hand Cost")
                {
                    ToolTip = 'Specifies the value of the TRP Period G/L Cost Whse. Handling field.';
                }
                field("TRP Warehouse Handling"; rec."TRP Warehouse Handling")
                {
                    ToolTip = 'Specifies the value of the TRP Warehouse Handling field.';
                }
                field("TRP Avg. Cost-Whse. Handl. ST"; rec."TRP Avg. Cost-Whse. Handl. ST")
                {
                    ToolTip = 'Specifies the value of the TRP Average Cost-Warehouse Handling ST field.';
                }
                field("TRP IT Cost-Whse. Handling ST"; rec."TRP IT Cost-Whse. Handling ST")
                {
                    ToolTip = 'Specifies the value of the TRP IT Cost-Whse. Handling ST field.';
                }
                field("TRP Unit Cost-Whse. Handl. SO"; rec."TRP Unit Cost-Whse. Handl. SO")
                {
                    ToolTip = 'Specifies the value of the TRP Unit Cost-Whse. Handling SO field.';
                }
                field("TRP Unit Cost-Whse. Handl. ST"; rec."TRP Unit Cost-Whse. Handl. ST")
                {
                    ToolTip = 'Specifies the value of the TRP Cumulative Unit Cost-Warehouse Handling ST field.';
                }
                field("TRP Prd. Whse. Hand. SKU/Lot"; rec."TRP Prd. Whse. Hand. SKU/Lot")
                {
                    ToolTip = 'Specifies the value of the TRP Period Warehouse Handling per SKU/Lot No. field.';
                }
                field("FIX Prd G/L Whse Hand Cost"; rec."FIX Prd G/L Whse Hand Cost")
                {
                    ToolTip = 'Specifies the value of the FIX Period G/L Cost Whse. Handling field.';
                }
                field("FIX Warehouse Handling"; rec."FIX Warehouse Handling")
                {
                    ToolTip = 'Specifies the value of the FIX Warehouse Handling field.';
                }
                field("FIX Avg. Cost-Whse. Handl. ST"; rec."FIX Avg. Cost-Whse. Handl. ST")
                {
                    ToolTip = 'Specifies the value of the FIX Average Cost-Warehouse Handling ST field.';
                }
                field("FIX IT Cost-Whse. Handling ST"; rec."FIX IT Cost-Whse. Handling ST")
                {
                    ToolTip = 'Specifies the value of the FIX IT Cost-Whse. Handling ST field.';
                }
                field("FIX Unit Cost-Whse. Handl. SO"; rec."FIX Unit Cost-Whse. Handl. SO")
                {
                    ToolTip = 'Specifies the value of the FIX Unit Cost-Whse. Handling SO field.';
                }
                field("FIX Unit Cost-Whse. Handl. ST"; rec."FIX Unit Cost-Whse. Handl. ST")
                {
                    ToolTip = 'Specifies the value of the FIX Cumulative Unit Cost-Warehouse Handling ST field.';
                }
                field("FIX Prd. Whse. Hand. SKU/Lot"; rec."FIX Prd. Whse. Hand. SKU/Lot")
                {
                    ToolTip = 'Specifies the value of the FIX Period Warehouse Handling per SKU/Lot No. field.';
                }
                //POENAB02, 06.08.2026, BCUP0-247>>
                field("Cost Center Code"; rec."Cost Center Code")
                {
                    ToolTip = 'Specifies the value of the Cost Center Code field.';
                }
                //POENAB02, 06.08.2026, BCUP0-247<<                
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            FRA = '&Ligne';
                Image = Line;
                action("Show Document")
                {
                    CaptionML = ENU = 'Show Document',
                                FRA = 'Afficher Document';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Show Document action.';

                    trigger OnAction();
                    begin
                        rec.ShowDocument();
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction();
                    begin
                        rec.ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
                action("Lot No. Shipping History")
                {
                    Caption = 'Lot No. Shipping History';
                    Image = LotInfo;
                    ToolTip = 'Executes the Lot No. Shipping History action.';

                    trigger OnAction();
                    begin
                        LotNoShipHistory.GetFilters(rec."Lot No.", rec."Item No.", rec."Posted Source Document");
                        LotNoShipHistory.RUN();
                    end;
                }
                /* //BCUPGRADE Manisha 'Posted Document Shipping Costs' drint it page code commented
                action("Posted Document Shipping Costs")
                {
                    Caption = 'Posted Document Shipping Costs';
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        PostedDocShippCostPage: Page "Posted Document Shipping Cost";
                        PostedDocShippCost: Record "Posted Document Shipping Cost";
                        TransferShipmentHeader: Record "Transfer Shipment Header";
                        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
                    begin
                        CLEAR(PostedDocShippCostPage);
                        PostedDocShippCost.SETRANGE("Source No.", "No.");
                        if not PostedDocShippCost.FINDFIRST then
                            if TransferShipmentHeader.GET("Posted Source Document No.") then begin
                                PostedWhseReceiptLine.RESET;
                                PostedWhseReceiptLine.SETRANGE("Source No.", TransferShipmentHeader."Transfer Order No.");
                                if PostedWhseReceiptLine.FINDFIRST then
                                    PostedDocShippCost.SETRANGE("Source No.", PostedWhseReceiptLine."No.");
                            end;
                        PostedDocShippCostPage.SETTABLEVIEW(PostedDocShippCost);
                        PostedDocShippCostPage.LOOKUPMODE(true);
                        if PostedDocShippCostPage.RUNMODAL = ACTION::LookupOK then;
                    end;
                }*/ //BCUPGRADE Manisha 'Posted Document Shipping Costs' drint it page code commented
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ChangeStyle(); //HEI.02
    end;

    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
        WhseSetup: Record "Warehouse Setup";
        ItemLedgerEntriesPage: Page "Item Ledger Entries";
        LotNoShipHistory: Page "Lot No. Shipping History";
        BoldReversed: Boolean;
        MarkTotals: Boolean;
        Reversed: Boolean;
        LotNo: Code[10];
        LineStyle: Text;

    local procedure ChangeStyle();
    begin
        //HEI.02>>
        LineStyle := 'standard';

        if Reversed then
            if rec."Distribution Type" = rec."Distribution Type"::Total then
                LineStyle := 'unfavorable'
            else
                LineStyle := 'attention'
        else if rec."Distribution Type" = rec."Distribution Type"::Total then
            LineStyle := 'strong';
        //HEI.02<<
    end;
}

