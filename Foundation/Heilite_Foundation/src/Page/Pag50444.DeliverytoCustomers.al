page 50444 "Delivery to Customers"
{
    // version HEI.07

    // HEI.01 CHG2095415 IBM BULIMC01 11.03.2021#new page created for Shipping Costs related to Sales Shipments
    // HEI.02 CHG2130188 IBM BULIMC01 13/10/2021 #
    //   #new fields added: "Distribution Type", "Parent Line No.", "Reversed"
    //   #Style property changed for all the fields
    //   #DecimalsPlaces property changed for fields "Period RPM Unit Cost Customer","Period RPM Unit Cost Transfer"
    // HEI.03 CHG2132177 BULIMC01 IBM 13/04/2022# new fields added
    // HEI.04 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //   #new fields added
    // HEI.05 HB2618 - CHG2132177 IBM NASTAA02 12.05.2022 # C2S - Own Fleet Logistic Cost
    //   # Changed the Name for Field 136 from "Distance per Drop Allocation Own Fleet" to "Distance Allocation Own Fleet"
    // HEI.06 CHG2177487 IBM SISUM01 07/11/2022 # Add "Processing Date"
    // HEI.07 CHG2167931 IBM SISUM01 19/11/2022 #add new fields. The ones marked with description HEI.13 in T50208

    Caption = 'Delivery to Customers';
    Editable = false;
    PageType = List;
    SourceTable = "Shipping Cost Allocation FND";
    SourceTableView = sorting("Entry No.")
                      ORDER(Ascending)
                      where("Posted Source Document" = FILTER("Posted Shipment" | "Posted Sales Credit Memo" | "Posted Sales Invoice" | "Posted Return Receipt"),
                            "Only RPM Transportation" = CONST(false));
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
                    ToolTip = 'Specifies the value of the Source Document field.';
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
                field("Lot No."; rec."Lot No.")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Lot No. field.';

                    trigger OnDrillDown();
                    begin
                        LotNoShipHistory.GetFilters(rec."Lot No.", rec."Item No.", rec."Posted Source Document");
                        LotNoShipHistory.RUN();
                    end;
                }
                field("Destination No."; rec."Destination No.")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    TableRelation = Customer."No." where("No." = FIELD("No."));
                    ToolTip = 'Specifies the value of the Destination No. field.';
                }
                field("Location Code"; rec."Location Code")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Location Code field.';
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
                    ToolTip = 'Value taken from page Posted Document Shipping Costs for the same Source No.';
                }
                field("Primary Allocated Amount"; rec."Primary Allocated Amount")
                {
                    Caption = 'Delivery to Customer';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Net Weight * (Total Shipping Cost Amount/Total Net Weight)';
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
                    Caption = 'Invoiced Quantity HL';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = '"Volume sold in HL "';
                }
                field("Initial Origin SO"; rec."Initial Origin SO")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Initial Origin field.';
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
                    Visible = false;
                    ToolTip = 'Specifies the value of the Period Date field.';
                }
                field("Period Picking Factor"; rec."Period Picking Factor")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Sum of Picking Factor values for the same Period Date.';
                }
                field("Period Net Weight (Kg)"; rec."Period Net Weight (Kg)")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Sum of Net Weight (Kg) values for the same Period Date.';
                }
                field("Unit Cost-General Overheads SO"; rec."Unit Cost-General Overheads SO")
                {
                    Caption = 'Cumulative Unit Cost-General Overheads SO';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Value of the field Cumulative Unit Cost-General Overheads ST from Internal Transfer Allocation page for the same Item No. and Lot & Destination No.';
                }
                field("<Unit Cost-Whse. Overhead SO>"; rec."Unit Cost-Whse. Overhead SO")
                {
                    Caption = 'Cumulative Unit Cost-Whse. Overhead SO';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Value of the field Cumulative Unit Cost-Warehouse Overhead ST from Internal Transfer Allocation page for the same Item No. and Lot & Destination No.';
                }
                field("Unit Cost-Whse. Handling SO"; rec."Unit Cost-Whse. Handling SO")
                {
                    Caption = 'Cumulative Unit Cost-Whse. Handling SO';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Value of the field Cumulative Unit Cost-Warehouse Handling ST from Internal Transfer Allocation page for the same Item No. and Lot & Destination No.';
                }
                field("Unit Cost-Internal Transfer SO"; rec."Unit Cost-Internal Transfer SO")
                {
                    Caption = 'Cumulative Unit Cost-Internal Transfer SO';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Cumulative Unit Cost-Internal Transfer SO field.';
                }
                field("General Overheads ST"; rec."General Overheads ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Cumulative Unit Cost-General Overheads ST * Net Weight (Kg)';
                }
                field("Warehouse Overheads ST"; rec."Warehouse Overheads ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Cumulative Unit Cost-Warehouse Overhead ST * Net Weight (Kg)';
                }
                field("Warehouse Handling ST"; rec."Warehouse Handling ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Cumulative Unit Cost-Warehouse Handling ST * Picking Factor';
                }
                field("Internal Transfer ST"; rec."Internal Transfer ST")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Cumulative Unit Cost-Internal Transfer ST * Net Weight(Kg)';
                }
                field("Warehouse Overheads"; rec."Warehouse Overheads")
                {
                    Caption = 'Warehouse Overheads';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Net Weight (Kg) * Period GL Cost Whse. Overheads / Period Net Weight (Kg)';
                }
                field("General Overheads"; rec."General Overheads")
                {
                    Caption = 'General Overheads';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Net Weight (Kg) * Period GL Cost Gen. Overheads / Period Net Weight (Kg)';
                }
                field("Warehouse Handling"; rec."Warehouse Handling")
                {
                    Caption = 'Warehouse Handling';
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Picking Factor * Period GL Cost Whse. Handling / Period Picking Factor';
                }
                field("Period G/L Cost Gen. Overheads"; rec."Period G/L Cost Gen. Overheads")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations.';
                    Visible = false;
                }
                field("Period G/L Cost Whse. Overhead"; rec."Period G/L Cost Whse. Overhead")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations.';
                    Visible = false;
                }
                field("Period G/L Cost Whse. Handling"; rec."Period G/L Cost Whse. Handling")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations';
                    Visible = false;
                }
                field("Period G/L Cost Delivery Cust."; rec."Period G/L Cost Delivery Cust.")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations.';
                    Visible = false;
                }
                field("Period RPM Unit Cost Customer"; rec."Period RPM Unit Cost Customer")
                {
                    DecimalPlaces = 5 : 5;
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTipML = ENU = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Destination No. = Customer No. and Item No. = Linked Item No. ';
                }
                field("Period RPM Unit Cost Transfer"; rec."Period RPM Unit Cost Transfer")
                {
                    DecimalPlaces = 5 : 5;
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTipML = ENU = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("Period Net Weight SKU/Lot"; rec."Period Net Weight SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the Period Net Weight per SKU/Lot No. in Location/Destination field.';
                }
                field("ST Period Net Weight SKU/Lot"; rec."ST Period Net Weight SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the ST Period Net Weight per SKU/Lot No. from ST Destination field.';
                }
                field("ST Period Pick. Factor SKU/Lot"; rec."ST Period Pick. Factor SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the ST Period Picking Factor per SKU/Lot No. from ST Destination field.';
                }
                field("ST Transfers per SKU/Lot"; rec."ST Transfers per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the "ST Period Internal Transfers per SKU/Lot No. " field.';
                }
                field("ST Gen. Overh. per SKU/Lot"; rec."ST Gen. Overh. per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the "ST Period General Overheads per SKU/Lot No. " field.';
                }
                field("ST Whse. Overh. per SKU/Lot"; rec."ST Whse. Overh. per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the "ST Period Warehouse Overheads per SKU/Lot No. " field.';
                }
                field("ST Whse. Hand. per SKU/Lot"; rec."ST Whse. Hand. per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Specifies the value of the "ST Period Warehouse Handling per SKU/Lot No. " field.';
                }
                field(Reversed; rec.Reversed)
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
                field("RPM SO"; rec."RPM SO")
                {
                    DecimalPlaces = 2 : 5;
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: "Net Weight (Kg)" * "Period RPM Unit Cost per Linked Item No.&Customer No."';
                }
                field("RPM ST"; rec."RPM ST")
                {
                    DecimalPlaces = 2 : 5;
                    Style = Strong;
                    StyleExpr = rec."Distribution Type" = rec."Distribution Type"::Total;
                    ToolTip = 'Formula: "Net Weight (Kg)" * "Period RPM Unit Cost per Linked Item No.-Internal Transfers"';
                }
                field("Period RPM Gen. Overh. Cust."; rec."Period RPM Gen. Overh. Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Specifies the value of the Period RPM Gen. Overheads Unit Cost per Linked Item No. & Customer No. field.';
                }
                field("Period RPM Gen. Overh. IT"; rec."Period RPM Gen. Overh. IT")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Specifies the value of the Period RPM Gen. Overheads Unit Cost per Linked Item No._Internal Transfers field.';
                }
                field("Period RPM Whse. Overh. Cust."; rec."Period RPM Whse. Overh. Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Specifies the value of the Period RPM Whse Overheads Unit Cost per Linked Item No. & Customer No. field.';
                }
                field("Period RPM Whse. Overh. IT"; rec."Period RPM Whse. Overh. IT")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Specifies the value of the Period RPM Whse Overheads Unit Cost per Linked Item No._Internal Transfers field.';
                }
                field("Period RPM Whse. Handl. Cust."; rec."Period RPM Whse. Handl. Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Specifies the value of the Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No. field.';
                }
                field("Period RPM Whse. Handl. IT"; rec."Period RPM Whse. Handl. IT")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Specifies the value of the Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers field.';
                }
                field("Gen. Overheads RPM SO"; rec."Gen. Overheads RPM SO")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Net weight [kg]"" * ""Period RPM Gen.Overheads Unit Cost per Linked Item No.& Customer No."""';
                }
                field("Gen. Overheads RPM ST"; rec."Gen. Overheads RPM ST")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Net weight [kg]"" * ""Period RPM Gen.Overheads Unit Cost per Linked Item No._Internal Transfers"""';
                }
                field("Whse. Overheads RPM SO"; rec."Whse. Overheads RPM SO")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Net weight [kg]"" * ""Period RPM Whse Overheads Unit Cost per Linked Item No.& Customer No."" "';
                }
                field("Whse. Overheads RPM ST"; rec."Whse. Overheads RPM ST")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Net weight [kg]""  * ""Period RPM Whse Overheads Unit Cost per Linked Item No._Internal Transfers"""';
                }
                field("Whse. Handling RPM SO"; rec."Whse. Handling RPM SO")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Picking Factor"" * ""Period RPM Whse Handling Unit Cost per Linked Item No.& Customer No."""';
                }
                field("Whse. Handling RPM ST"; rec."Whse. Handling RPM ST")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = '"""Picking Factor"" * ""Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers"" "';
                }
                field("Processing Date"; rec."Processing Date")
                {
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
                field("OVE Unit Cost-Whse. Handl. SO"; rec."OVE Unit Cost-Whse. Handl. SO")
                {
                    ToolTip = 'Specifies the value of the OVE Unit Cost-Whse. Handling SO field.';
                }
                field("OVE Prd. RPM Whse. Handl. Cust"; rec."OVE Prd. RPM Whse. Handl. Cust")
                {
                    ToolTip = 'Specifies the value of the OVE Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No. field.';
                }
                field("OVE Prd. RPM Whse. Handl. IT"; rec."OVE Prd. RPM Whse. Handl. IT")
                {
                    ToolTip = 'Specifies the value of the OVE Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers field.';
                }
                field("OVE ST Whse. Hand. SKU/Lot"; rec."OVE ST Whse. Hand. SKU/Lot")
                {
                    ToolTip = 'Specifies the value of the OVE ST Period Warehouse Handling per SKU/Lot No. field.';
                }
                field("OVE Whse. Handling RPM SO"; rec."OVE Whse. Handling RPM SO")
                {
                    ToolTip = 'Specifies the value of the OVE Whse. Handling RPM SO field.';
                }
                field("OVE Whse. Handling RPM ST"; rec."OVE Whse. Handling RPM ST")
                {
                    ToolTip = 'Specifies the value of the OVE Whse. Handling RPM ST field.';
                }
                field("OVE Whse. Hand. ST"; rec."OVE Whse. Hand. ST")
                {
                    ToolTip = 'Specifies the value of the OVE Warehouse Handling ST field.';
                }
                field("TRP Prd G/L Whse Hand Cost"; rec."TRP Prd G/L Whse Hand Cost")
                {
                    ToolTip = 'Specifies the value of the TRP Period G/L Cost Whse. Handling field.';
                }
                field("TRP Warehouse Handling"; rec."TRP Warehouse Handling")
                {
                    ToolTip = 'Specifies the value of the TRP Warehouse Handling field.';
                }
                field("TRP Unit Cost-Whse. Handl. SO"; rec."TRP Unit Cost-Whse. Handl. SO")
                {
                    ToolTip = 'Specifies the value of the TRP Unit Cost-Whse. Handling SO field.';
                }
                field("TRP Prd. RPM Whse. Handl. Cust"; rec."TRP Prd. RPM Whse. Handl. Cust")
                {
                    ToolTip = 'Specifies the value of the TRP Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No. field.';
                }
                field("TRP Prd. RPM Whse. Handl. IT"; rec."TRP Prd. RPM Whse. Handl. IT")
                {
                    ToolTip = 'Specifies the value of the TRP Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers field.';
                }
                field("TRP ST Whse. Hand. SKU/Lot"; rec."TRP ST Whse. Hand. SKU/Lot")
                {
                    ToolTip = 'Specifies the value of the TRP ST Period Warehouse Handling per SKU/Lot No. field.';
                }
                field("TRP Whse. Handling RPM SO"; rec."TRP Whse. Handling RPM SO")
                {
                    ToolTip = 'Specifies the value of the TRP Whse. Handling RPM SO field.';
                }
                field("TRP Whse. Handling RPM ST"; rec."TRP Whse. Handling RPM ST")
                {
                    ToolTip = 'Specifies the value of the TRP Whse. Handling RPM ST field.';
                }
                field("TRP Whse. Hand. ST"; rec."TRP Whse. Hand. ST")
                {
                    ToolTip = 'Specifies the value of the TRP Warehouse Handling ST field.';
                }
                field("FIX Prd G/L Whse Hand Cost"; rec."FIX Prd G/L Whse Hand Cost")
                {
                    ToolTip = 'Specifies the value of the FIX Period G/L Cost Whse. Handling field.';
                }
                field("FIX Warehouse Handling"; rec."FIX Warehouse Handling")
                {
                    ToolTip = 'Specifies the value of the FIX Warehouse Handling field.';
                }
                field("FIX Unit Cost-Whse. Handl. SO"; rec."FIX Unit Cost-Whse. Handl. SO")
                {
                    ToolTip = 'Specifies the value of the FIX Unit Cost-Whse. Handling SO field.';
                }
                field("FIX Prd. RPM Whse. Handl. Cust"; rec."FIX Prd. RPM Whse. Handl. Cust")
                {
                    ToolTip = 'Specifies the value of the FIX Period RPM Whse Handling Unit Cost per Linked Item No. & Customer No. field.';
                }
                field("FIX Prd. RPM Whse. Handl. IT"; rec."FIX Prd. RPM Whse. Handl. IT")
                {
                    ToolTip = 'Specifies the value of the FIX Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers field.';
                }
                field("FIX ST Whse. Hand. SKU/Lot"; rec."FIX ST Whse. Hand. SKU/Lot")
                {
                    ToolTip = 'Specifies the value of the FIX ST Period Warehouse Handling per SKU/Lot No field.';
                }
                field("FIX Whse. Handling RPM SO"; rec."FIX Whse. Handling RPM SO")
                {
                    ToolTip = 'Specifies the value of the FIX Whse. Handling RPM SO field.';
                }
                field("FIX Whse. Handling RPM ST"; rec."FIX Whse. Handling RPM ST")
                {
                    ToolTip = 'Specifies the value of the FIX Whse. Handling RPM ST field.';
                }
                field("FIX Whse. Hand. ST"; rec."FIX Whse. Hand. ST")
                {
                    ToolTip = 'Specifies the value of the FIX Warehouse Handling ST field.';
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
                /* // BC Upgrade Manisha Deint it page 'Posted Document Shipping Cost' missing code commented
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
                    begin
                        CLEAR(PostedDocShippCostPage);
                        PostedDocShippCost.SETRANGE("Source No.", "No.");
                        PostedDocShippCostPage.SETTABLEVIEW(PostedDocShippCost);
                        PostedDocShippCostPage.LOOKUPMODE(true);
                        if PostedDocShippCostPage.RUNMODAL = ACTION::LookupOK then;
                    end;
                }
                */ // BC Upgrade Manisha Deint it page 'Posted Document Shipping Cost' missing code commented
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ChangeStyle(); //HEI.02
    end;

    var
        InventorySetup: Record "Inventory Setup";
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgerEntriesPage: Page "Item Ledger Entries";
        LotNoShipHistory: Page "Lot No. Shipping History";
        MarkTotals: Boolean;
        Text001: Label 'Formula: Net Weight * (Total Shipping Cost Amount/Total Net Weight)';
        Text002: Label 'Formula: Internal Transfer Allocated Amount / Net Weight';
        LineStyle: Text;

    local procedure ChangeStyle();
    begin
        //HEI.02>>
        LineStyle := 'standard';

        if rec.Reversed then
            if rec."Distribution Type" = rec."Distribution Type"::Total then
                LineStyle := 'unfavorable'
            else
                LineStyle := 'attention'
        else if rec."Distribution Type" = rec."Distribution Type"::Total then
            LineStyle := 'strong';
        //HEI.02<<
    end;
}

