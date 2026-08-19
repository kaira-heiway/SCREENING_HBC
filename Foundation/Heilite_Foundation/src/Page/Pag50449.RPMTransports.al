page 50449 "RPM Transports"
{
    // version HEI.07

    // HEI.01 CHG2095415 IBM BULIMC01 11.03.2021#new page created for Shipping Costs related to Sales Shipments
    // HEI.02 CHG2130188 IBM BULIMC01 13/10/2021 #
    //   #new fields added: "Distribution Type", "Parent Line No.", "Reversed"
    //   #Style property changed for all the fields
    // HEI.03 CHG2132177 BULIMC01 IBM 13/04/2022 # Own fleet: new fields added
    // HEI.04 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //   #new fields added
    // HEI.05 HB2618 - CHG2132177 IBM NASTAA02 12.05.2022 # C2S - Own Fleet Logistic Cost
    //   # Changed the Name for Field 136 from "Distance per Drop Allocation Own Fleet" to "Distance Allocation Own Fleet"
    // HEI.06 CHG2178734 IBM SISU01  14/11/2022 #add to fileter Source Document the vale "Sales Order"
    // HEI.07 CHG2167931 IBM SISUM01 19/11/2022 #add new fields. The ones marked with description HEI.13

    Caption = 'RPM Transports';
    Editable = false;
    PageType = List;
    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<
    SourceTable = "Shipping Cost Allocation FND";
    SourceTableView = sorting("Entry No.")
                      ORDER(Ascending)
                      where("Source Document" = FILTER("Sales Return Order" | "Sales Order"),
                            "Only RPM Transportation" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Distribution Type"; rec."Distribution Type")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Distribution Type field.';
                }
                field("Parent Line No."; rec."Parent Line No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Parent Line No. field.';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Source Document"; rec."Source Document")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Source Document field.';
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Source No. field.';
                }
                field("Source Line No."; rec."Source Line No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Source Line No. field.';
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    StyleExpr = LineStyle;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Destination No."; rec."Destination No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Customer No.';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    TableRelation = Customer."No." where("No." = FIELD("Destination No."));
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Quantity (Base UoM)"; rec."Quantity (Base UoM)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Quantity (Base UoM) field.';
                }
                field("Only RPM Transportation"; rec."Only RPM Transportation")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Only RPM Transportation field.';
                }
                field("Total Shipping Cost Amount"; rec."Total Shipping Cost Amount")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Total Shipping Cost Amount field.';
                }
                field("Net Weight (Kg)"; rec."Net Weight (Kg)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Net Weight (Kg) field.';
                }
                field("Total Net Weight (Kg)"; rec."Total Net Weight (Kg)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Total Net Weight (Kg) field.';
                }
                field("Primary Allocated Amount"; rec."Primary Allocated Amount")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'RPM Primary Allocated Amount';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Net Weight * (Total Shipping Cost Amount/Total Net Weight)';
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Shipping Agent Service Code field.';
                }
                field(Route; rec.Route)
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
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Invoiced Quantity HL';
                    DecimalPlaces = 3 : 3;
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Invoiced Quantity HL field.';
                }
                field(Reversed; rec.Reversed)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Reversed';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Own Fleet"; rec."Own Fleet")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Own Fleet field.';
                }
                field("Period G/L Cost Own Fleet"; rec."Period G/L Cost Own Fleet")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTipML = ENU = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations where C2S Name = Own Fleet.';
                }
                field(Distance; rec.Distance)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTip = 'Value of the field "Distance" related to the field "No." from the Posted Whse. Shipment Header table.';
                }
                field("Period Distance"; rec."Period Distance")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTip = 'Sum of Distance values for the same Period Date where Own Fleet is Yes.';
                }
                field("No. of Drops"; rec."No. of Drops")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTip = 'The count using the field "Destination No." for the same value in the field "No." related to each shipment.';
                }
                field("Period Drop Counts"; rec."Period Drop Counts")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTip = 'Sum of No. Drops values for the same Period Date where Own Fleet is Yes.';
                }
                field("Weight Allocation Own Fleet"; rec."Weight Allocation Own Fleet")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTip = 'Formula: Net Weight[Kg] / Period Net Weight[Kg](Own Fleet) * Net Weight Allocation %[Whse. Cost Alloc. Setup] * Period G/L Own Fleet';
                }
                field("No. of Drops All. Own Fleet"; rec."No. of Drops All. Own Fleet")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTip = 'Formula: No. of drops / Period Drops Count * No. of Drops Allocation %[Whse. Cost Alloc. Setup] * Period G/L Own Fleet';
                }
                field("Distance Allocation Own Fleet"; rec."Distance Allocation Own Fleet")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    ToolTip = 'Formula: Distance / Period Distance * Distance Allocation %[Whse. Cost Alloc. Setup] * Period G/L Own Fleet';
                }
                field("Period Net Weight (Kg)"; rec."Period Net Weight (Kg)")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Description = 'HEI.04';
                    ToolTip = 'Specifies the value of the Period Net Weight (Kg) field.';
                }
                field("Period Picking Factor"; rec."Period Picking Factor")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Description = 'HEI.04';
                    ToolTip = 'Specifies the value of the Period Picking Factor field.';
                }
                field("General Overheads"; rec."General Overheads")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Description = 'HEI.04';
                    ToolTip = 'Specifies the value of the General Overheads field.';
                }
                field("Warehouse Overheads"; rec."Warehouse Overheads")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Description = 'HEI.04';
                    ToolTip = 'Specifies the value of the Warehouse Overheads field.';
                }
                field("Warehouse Handling"; rec."Warehouse Handling")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Description = 'HEI.04';
                    ToolTip = 'Specifies the value of the Warehouse Handling field.';
                }
                field("Period G/L Cost Whse. Handling"; rec."Period G/L Cost Whse. Handling")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Period G/L Cost Whse. Handling field.';
                }
                field("Period G/L Cost Whse. Overhead"; rec."Period G/L Cost Whse. Overhead")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Period G/L Cost Whse. Overhead field.';
                }
                field("Period G/L Cost Gen. Overheads"; rec."Period G/L Cost Gen. Overheads")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Period G/L Cost Gen. Overheads field.';
                }
                field("Processing Date"; rec."Processing Date")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Visible = false;
                    ToolTip = 'Specifies the value of the Processing Date field.';
                }
                field("OVE Prd G/L Whse Hand Cost"; rec."OVE Prd G/L Whse Hand Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OVE Period G/L Cost Whse. Handling field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the OVE Period G/L Cost Whse. Handling field.';

                }
                field("OVE Warehouse Handling"; rec."OVE Warehouse Handling")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OVE Warehouse Handling field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the OVE Warehouse Handling field.';

                }
                field("OVE Unit Cost-Whse. Handl. SO"; rec."OVE Unit Cost-Whse. Handl. SO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OVE Unit Cost-Whse. Handling SO field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the OVE Unit Cost-Whse. Handling SO field.';

                }
                field("TRP Prd G/L Whse Hand Cost"; rec."TRP Prd G/L Whse Hand Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TRP Period G/L Cost Whse. Handling field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the TRP Period G/L Cost Whse. Handling field.';

                }
                field("TRP Warehouse Handling"; rec."TRP Warehouse Handling")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TRP Warehouse Handling field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the TRP Warehouse Handling field.';

                }
                field("TRP Unit Cost-Whse. Handl. SO"; rec."TRP Unit Cost-Whse. Handl. SO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TRP Unit Cost-Whse. Handling SO field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the TRP Unit Cost-Whse. Handling SO field.';

                }
                field("FIX Prd G/L Whse Hand Cost"; rec."FIX Prd G/L Whse Hand Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FIX Period G/L Cost Whse. Handling field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the FIX Period G/L Cost Whse. Handling field.';

                }
                field("FIX Warehouse Handling"; rec."FIX Warehouse Handling")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FIX Warehouse Handling field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the FIX Warehouse Handling field.';

                }
                field("FIX Unit Cost-Whse. Handl. SO"; rec."FIX Unit Cost-Whse. Handl. SO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FIX Unit Cost-Whse. Handling SO field.';
                    // BC Upgrade SHUKLP03 <<                    ToolTip = 'Specifies the value of the FIX Unit Cost-Whse. Handling SO field.';

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
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
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
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
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
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Lot No. Shipping History';
                    Image = LotInfo;
                    ToolTip = 'Executes the Lot No. Shipping History action.';

                    trigger OnAction();
                    begin
                        LotNoShipHistory.GetFilters(rec."Lot No.", rec."Item No.", rec."Posted Source Document");
                        LotNoShipHistory.RUN();
                    end;
                }
                //BC Upgrade Drink it object "Posted Document Shipping Cost"code commented>>
                /*action("Posted Document Shipping Costs")
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
                    begin
                        CLEAR(PostedDocShippCostPage);
                        PostedDocShippCost.SETRANGE("Source No.", rec."No.");
                        PostedDocShippCostPage.SETTABLEVIEW(PostedDocShippCost);
                        PostedDocShippCostPage.LOOKUPMODE(true);
                        if PostedDocShippCostPage.RUNMODAL = ACTION::LookupOK then;
                    end;
            }*/ //BC Upgrade drink it object "Posted Document Shipping Cost" code commented <<
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ChangeStyle();
    end;

    var
        ItemLedgEntry: Record "Item Ledger Entry";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        AllocatedShipCost: Record "Shipping Cost Allocation FND";
        ItemLedgerEntriesPage: Page "Item Ledger Entries";
        LotNoShipHistory: Page "Lot No. Shipping History";
        Text001: Label 'Formula: Net Weight * (Total Shipping Cost Amount/Total Net Weight)';
        Text002: Label 'Formula: Internal Transfer Allocated Amount / Net Weight';
        LineStyle: Text;

    local procedure ChangeStyle();
    begin
        LineStyle := 'standard';

        if rec.Reversed then
            if rec."Distribution Type" = rec."Distribution Type"::Total then
                LineStyle := 'unfavorable'
            else
                LineStyle := 'attention'
        else if rec."Distribution Type" = rec."Distribution Type"::Total then
            LineStyle := 'strong';
    end;
}

