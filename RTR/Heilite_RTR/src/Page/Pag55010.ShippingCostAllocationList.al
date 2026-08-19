page 55010 "Shipping Cost Allocation List"
{
    // version HEI.01

    // HEI.01 CHG2175297 IBM SISUM01 25/04/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #new object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50484
    // "Posted Document Shipping Costs" action is commented, as it is part of Aptean developments
    // Route and "Route Planning No." fields are commented, as they are part of Aptean developments

    Caption = 'Shipping Cost Allocation';
    Editable = false;
    PageType = List;
    SourceTable = "Shipping Cost Allocation FND";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Ascending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Unique number identifying the shipping cost allocation entry.';
                }
                field("Distribution Type"; Rec."Distribution Type")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Indicates whether the line is a detail line or a total line.';
                }
                field("Parent Line No."; Rec."Parent Line No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Indicates the line number of the total line to which the detail line belongs.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Date when the shipping cost allocation entry was posted.';
                }
                field("No."; Rec."No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Shipment document number from which the shipping cost allocation entry was created.';
                }
                field("Line No."; Rec."Line No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Line number in the shipment document from which the shipping cost allocation entry was created.';
                }
                field("Source Document"; Rec."Source Document")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Type of document from which the shipping cost allocation entry was created.';
                }
                field("Item No."; Rec."Item No.")
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Item number for which the shipping cost allocation entry was created.';
                }
                field(Description; Rec.Description)
                {
                    StyleExpr = LineStyle;
                    ToolTip = 'Item description for which the shipping cost allocation entry was created.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Item Category Code of the Item No.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Lot Number of the Item No.';

                    trigger OnDrillDown();
                    begin
                        LotNoShipHistory.GetFilters(Rec."Lot No.", Rec."Item No.", Rec."Posted Source Document");
                        LotNoShipHistory.Run();
                    end;
                }
                field("Destination No."; Rec."Destination No.")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    TableRelation = Customer."No." where("No." = field("Destination No."));
                    ToolTip = 'Customer number to which the item was shipped.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Warehouse code from which the item was shipped.';
                }
                field("Quantity (Base UoM)"; Rec."Quantity (Base UoM)")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Quantity shipped in base unit of measure.';
                }
                field("Net Weight (Kg)"; Rec."Net Weight (Kg)")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Net weight of the shipped quantity in kilograms.';
                }
                field("Total Net Weight (Kg)"; Rec."Total Net Weight (Kg)")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value taken from page Posted Document Shipping Costs for the same Source No.';
                }
                field("Total Shipping Cost Amount"; Rec."Total Shipping Cost Amount")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value taken from page Posted Document Shipping Costs for the same Source No.';
                }
                field("Primary Allocated Amount"; Rec."Primary Allocated Amount")
                {
                    Caption = 'Delivery to Customer';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Net Weight * (Total Shipping Cost Amount/Total Net Weight)';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Shipping Agent Code from the Posted Whse. Shipment Header related to the field "No."';
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Shipping Agent Service Code from the Posted Whse. Shipment Header related to the field "No."';
                }
                // BC Upgrade POENAB02 >>
                // Route and "Route Planning No." are commented, as they are part of Aptean developments
                /*
                field(Route; Rec.Route)
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Route from the Posted Whse. Shipment Header related to the field "No."';
                }
                field("Route Planning No."; Rec."Route Planning No.")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Route Planning No. from the Posted Whse. Shipment Header related to the field "No."';
                }
                */
                // BC Upgrade POENAB02 <<
                field("Quantity HL"; Rec."Quantity HL")
                {
                    Caption = 'Invoiced Quantity HL';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Volume sold in HL';
                }
                field("Initial Origin SO"; Rec."Initial Origin SO")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value taken from the Initial Origin SO field in the Internal Transfer Allocation page for the same Item No. and Lot & Destination No.';
                }
                field("No. of Pallets"; Rec."No. of Pallets")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Number of pallets shipped.';
                }
                field("Picking Factor"; Rec."Picking Factor")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value taken from the Picking Factor field in the Internal Transfer Allocation page for the same Item No. and Lot & Destination No.';
                }
                field("Period Date"; Rec."Period Date")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    Visible = false;
                    ToolTip = 'Period Date related to the shipping cost allocation entry.';
                }
                field("Period Picking Factor"; Rec."Period Picking Factor")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Sum of Picking Factor values for the same Period Date.';
                }
                field("Period Net Weight (Kg)"; Rec."Period Net Weight (Kg)")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Sum of Net Weight (Kg) values for the same Period Date.';
                }
                field("Unit Cost-General Overheads SO"; Rec."Unit Cost-General Overheads SO")
                {
                    Caption = 'Cumulative Unit Cost-General Overheads SO';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value of the field Cumulative Unit Cost-General Overheads ST from Internal Transfer Allocation page for the same Item No. and Lot & Destination No.';
                }
                field("<Unit Cost-Whse. Overhead SO>"; Rec."Unit Cost-Whse. Overhead SO")
                {
                    Caption = 'Cumulative Unit Cost-Whse. Overhead SO';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value of the field Cumulative Unit Cost-Warehouse Overhead ST from Internal Transfer Allocation page for the same Item No. and Lot & Destination No.';
                }
                field("Unit Cost-Whse. Handling SO"; Rec."Unit Cost-Whse. Handling SO")
                {
                    Caption = 'Cumulative Unit Cost-Whse. Handling SO';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value of the field Cumulative Unit Cost-Warehouse Handling ST from Internal Transfer Allocation page for the same Item No. and Lot & Destination No.';
                }
                field("Unit Cost-Internal Transfer SO"; Rec."Unit Cost-Internal Transfer SO")
                {
                    Caption = 'Cumulative Unit Cost-Internal Transfer SO';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value of the field Cumulative Unit Cost-Internal Transfer ST from Internal Transfer Allocation page for the same Item No. and Lot & Destination No.';
                }
                field("General Overheads ST"; Rec."General Overheads ST")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Cumulative Unit Cost-General Overheads ST * Net Weight (Kg)';
                }
                field("Warehouse Overheads ST"; Rec."Warehouse Overheads ST")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Cumulative Unit Cost-Warehouse Overhead ST * Net Weight (Kg)';
                }
                field("Warehouse Handling ST"; Rec."Warehouse Handling ST")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Cumulative Unit Cost-Warehouse Handling ST * Picking Factor';
                }
                field("Internal Transfer ST"; Rec."Internal Transfer ST")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Cumulative Unit Cost-Internal Transfer ST * Net Weight(Kg)';
                }
                field("Warehouse Overheads"; Rec."Warehouse Overheads")
                {
                    Caption = 'Warehouse Overheads';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Net Weight (Kg) * Period GL Cost Whse. Overheads / Period Net Weight (Kg)';
                }
                field("General Overheads"; Rec."General Overheads")
                {
                    Caption = 'General Overheads';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Net Weight (Kg) * Period GL Cost Gen. Overheads / Period Net Weight (Kg)';
                }
                field("Warehouse Handling"; Rec."Warehouse Handling")
                {
                    Caption = 'Warehouse Handling';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Picking Factor * Period GL Cost Whse. Handling / Period Picking Factor';
                }
                field("Period G/L Cost Gen. Overheads"; Rec."Period G/L Cost Gen. Overheads")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations.';
                    Visible = false;
                }
                field("Period G/L Cost Whse. Overhead"; Rec."Period G/L Cost Whse. Overhead")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations.';
                    Visible = false;
                }
                field("Period G/L Cost Whse. Handling"; Rec."Period G/L Cost Whse. Handling")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations';
                    Visible = false;
                }
                field("Period G/L Cost Delivery Cust."; Rec."Period G/L Cost Delivery Cust.")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations.';
                    Visible = false;
                }
                field("Period RPM Unit Cost Customer"; Rec."Period RPM Unit Cost Customer")
                {
                    DecimalPlaces = 5 : 5;
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Destination No. = Customer No. and Item No. = Linked Item No. ';
                }
                field("Period RPM Unit Cost Transfer"; Rec."Period RPM Unit Cost Transfer")
                {
                    DecimalPlaces = 5 : 5;
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("Period Net Weight SKU/Lot"; Rec."Period Net Weight SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Sum of Net Weight (Kg) values for the same Period Date where Item No. and Lot No. are the same.';
                }
                field("ST Period Net Weight SKU/Lot"; Rec."ST Period Net Weight SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Sum of Net Weight (Kg) values for the same Period Date where Item No. and Lot No. are the same for Internal Transfers.';
                }
                field("ST Period Pick. Factor SKU/Lot"; Rec."ST Period Pick. Factor SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Sum of Picking Factor values for the same Period Date where Item No. and Lot No. are the same for Internal Transfers.';
                }
                field("ST Transfers per SKU/Lot"; Rec."ST Transfers per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Internal Transfer Allocated Amount / Net Weight';
                }
                field("ST Gen. Overh. per SKU/Lot"; Rec."ST Gen. Overh. per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Internal Transfer General Overhead Allocated Amount / Net Weight';
                }
                field("ST Whse. Overh. per SKU/Lot"; Rec."ST Whse. Overh. per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Internal Transfer Warehouse Overhead Allocated Amount / Net Weight';
                }
                field("ST Whse. Hand. per SKU/Lot"; Rec."ST Whse. Hand. per SKU/Lot")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field(Reversed; Rec.Reversed)
                {
                    Caption = 'Reversed';
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Indicates whether the shipping cost allocation entry has been reversed.';
                }
                field("Own Fleet"; Rec."Own Fleet")
                {
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Indicates whether the shipment was made using the company''s own fleet.';
                }
                field("Period G/L Cost Own Fleet"; Rec."Period G/L Cost Own Fleet")
                {
                    ToolTip = 'Sum of General Ledger Entries amounts for Period Date according to SCOA/CCC dim. combinations where C2S Name = Own Fleet.';
                }
                field(Distance; Rec.Distance)
                {
                    ToolTip = 'Value of the field "Distance" related to the field "No." from the Posted Whse. Shipment Header table.';
                }
                field("Period Distance"; Rec."Period Distance")
                {
                    ToolTip = 'Sum of Distance values for the same Period Date where Own Fleet is Yes.';
                }
                field("No. of Drops"; Rec."No. of Drops")
                {
                    ToolTip = 'The count using the field "Destination No." for the same value in the field "No." related to each shipment.';
                }
                field("Period Drop Counts"; Rec."Period Drop Counts")
                {
                    ToolTip = 'Sum of No. Drops values for the same Period Date where Own Fleet is Yes.';
                }
                field("Weight Allocation Own Fleet"; Rec."Weight Allocation Own Fleet")
                {
                    ToolTip = 'Formula: Net Weight[Kg] / Period Net Weight[Kg](Own Fleet) * Net Weight Allocation %[Whse. Cost Alloc. Setup] * Period G/L Own Fleet';
                }
                field("No. of Drops All. Own Fleet"; Rec."No. of Drops All. Own Fleet")
                {
                    ToolTip = 'Formula: No. of drops / Period Drops Count * No. of Drops Allocation %[Whse. Cost Alloc. Setup] * Period G/L Own Fleet';
                }
                field("Distance Allocation Own Fleet"; Rec."Distance Allocation Own Fleet")
                {
                    ToolTip = 'Formula: Distance / Period Distance * Distance Allocation %[Whse. Cost Alloc. Setup] * Period G/L Own Fleet';
                }
                field("RPM SO"; Rec."RPM SO")
                {
                    DecimalPlaces = 2 : 5;
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: "Net Weight (Kg)" * "Period RPM Unit Cost per Linked Item No.&Customer No."';
                }
                field("RPM ST"; Rec."RPM ST")
                {
                    DecimalPlaces = 2 : 5;
                    Style = Strong;
                    StyleExpr = Rec."Distribution Type" = Rec."Distribution Type"::Total;
                    ToolTip = 'Formula: "Net Weight (Kg)" * "Period RPM Unit Cost per Linked Item No.-Internal Transfers"';
                }
                field("Period RPM Gen. Overh. Cust."; Rec."Period RPM Gen. Overh. Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Destination No. = Customer No. and Item No. = Linked Item No. ';
                }
                field("Period RPM Gen. Overh. IT"; Rec."Period RPM Gen. Overh. IT")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("Period RPM Whse. Overh. Cust."; Rec."Period RPM Whse. Overh. Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Destination No. = Customer No. and Item No. = Linked Item No. ';
                }
                field("Period RPM Whse. Overh. IT"; Rec."Period RPM Whse. Overh. IT")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("Period RPM Whse. Handl. Cust."; Rec."Period RPM Whse. Handl. Cust.")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Destination No. = Customer No. and Item No. = Linked Item No. ';
                }
                field("Period RPM Whse. Handl. IT"; Rec."Period RPM Whse. Handl. IT")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("Gen. Overheads RPM SO"; Rec."Gen. Overheads RPM SO")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Net weight [kg] * Period RPM Gen.Overheads Unit Cost per Linked Item No.& Customer No.';
                }
                field("Gen. Overheads RPM ST"; Rec."Gen. Overheads RPM ST")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Net weight [kg] * Period RPM Gen.Overheads Unit Cost per Linked Item No._Internal Transfers';
                }
                field("Whse. Overheads RPM SO"; Rec."Whse. Overheads RPM SO")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Net weight [kg] * Period RPM Whse Overheads Unit Cost per Linked Item No.& Customer No.';
                }
                field("Whse. Overheads RPM ST"; Rec."Whse. Overheads RPM ST")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Net weight [kg] * Period RPM Whse Overheads Unit Cost per Linked Item No._Internal Transfers';
                }
                field("Whse. Handling RPM SO"; Rec."Whse. Handling RPM SO")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Picking Factor * Period RPM Whse Handling Unit Cost per Linked Item No.& Customer No.';
                }
                field("Whse. Handling RPM ST"; Rec."Whse. Handling RPM ST")
                {
                    DecimalPlaces = 2 : 5;
                    ToolTip = 'Picking Factor * Period RPM Whse Handling Unit Cost per Linked Item No._Internal Transfers';
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    ToolTip = 'Date when the shipping cost allocation entry was processed.';
                }
                field("OVE Prd G/L Whse Hand Cost"; Rec."OVE Prd G/L Whse Hand Cost")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Overhead Allocated Amount / Net Weight';
                }
                field("OVE Warehouse Handling"; Rec."OVE Warehouse Handling")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("OVE Unit Cost-Whse. Handl. SO"; Rec."OVE Unit Cost-Whse. Handl. SO")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("OVE Prd. RPM Whse. Handl. Cust"; Rec."OVE Prd. RPM Whse. Handl. Cust")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("OVE Prd. RPM Whse. Handl. IT"; Rec."OVE Prd. RPM Whse. Handl. IT")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("OVE ST Whse. Hand. SKU/Lot"; Rec."OVE ST Whse. Hand. SKU/Lot")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("OVE Whse. Handling RPM SO"; Rec."OVE Whse. Handling RPM SO")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("OVE Whse. Handling RPM ST"; Rec."OVE Whse. Handling RPM ST")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("OVE Whse. Hand. ST"; Rec."OVE Whse. Hand. ST")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("TRP Prd G/L Whse Hand Cost"; Rec."TRP Prd G/L Whse Hand Cost")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Overhead Allocated Amount / Net Weight';
                }
                field("TRP Warehouse Handling"; Rec."TRP Warehouse Handling")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("TRP Unit Cost-Whse. Handl. SO"; Rec."TRP Unit Cost-Whse. Handl. SO")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("TRP Prd. RPM Whse. Handl. Cust"; Rec."TRP Prd. RPM Whse. Handl. Cust")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("TRP Prd. RPM Whse. Handl. IT"; Rec."TRP Prd. RPM Whse. Handl. IT")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("TRP ST Whse. Hand. SKU/Lot"; Rec."TRP ST Whse. Hand. SKU/Lot")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("TRP Whse. Handling RPM SO"; Rec."TRP Whse. Handling RPM SO")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("TRP Whse. Handling RPM ST"; Rec."TRP Whse. Handling RPM ST")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("TRP Whse. Hand. ST"; Rec."TRP Whse. Hand. ST")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("FIX Prd G/L Whse Hand Cost"; Rec."FIX Prd G/L Whse Hand Cost")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Overhead Allocated Amount / Net Weight';
                }
                field("FIX Warehouse Handling"; Rec."FIX Warehouse Handling")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("FIX Unit Cost-Whse. Handl. SO"; Rec."FIX Unit Cost-Whse. Handl. SO")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("FIX Prd. RPM Whse. Handl. Cust"; Rec."FIX Prd. RPM Whse. Handl. Cust")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("FIX Prd. RPM Whse. Handl. IT"; Rec."FIX Prd. RPM Whse. Handl. IT")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("FIX ST Whse. Hand. SKU/Lot"; Rec."FIX ST Whse. Hand. SKU/Lot")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                field("FIX Whse. Handling RPM SO"; Rec."FIX Whse. Handling RPM SO")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("FIX Whse. Handling RPM ST"; Rec."FIX Whse. Handling RPM ST")
                {
                    ToolTip = 'Value coming from the RPM - SKU Relationship (C2S) table for the same period date where Item No. = Linked Item No.';
                }
                field("FIX Whse. Hand. ST"; Rec."FIX Whse. Hand. ST")
                {
                    ToolTip = 'Formula: Internal Transfer Warehouse Handling Allocated Amount / Picking Factor';
                }
                //POENAB02, 06.08.2026, BCUP0-247>>
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ToolTip = 'Cost Center Code from the Posted Document.';
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
                Caption = '&Line';
                Image = Line;
                action("Show Document")
                {
                    Caption = 'Show Document';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View the document associated with the shipping cost allocation entry.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocument();
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit the dimensions for the current record.';

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SaveRecord();
                    end;
                }
                action("Lot No. Shipping History")
                {
                    Caption = 'Lot No. Shipping History';
                    Image = LotInfo;
                    ToolTip = 'View the shipping history for the lot number associated with the shipping cost allocation entry.';

                    trigger OnAction();
                    begin
                        LotNoShipHistory.GetFilters(Rec."Lot No.", Rec."Item No.", Rec."Posted Source Document");
                        LotNoShipHistory.Run();
                    end;
                }
                // BC Upgrade POENAB02 >>
                // Commented out as this action is part of Aptean developments
                /*
                action("Posted Document Shipping Costs")
                {
                    Caption = 'Posted Document Shipping Costs';
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        PostedDocShippCostPage : Page "Posted Document Shipping Cost";
                        PostedDocShippCost : Record "Posted Document Shipping Cost";
                    begin
                        CLEAR(PostedDocShippCostPage);
                        PostedDocShippCost.SETRANGE("Source No.","No.");
                        PostedDocShippCostPage.SETTABLEVIEW(PostedDocShippCost);
                        PostedDocShippCostPage.LOOKUPMODE(true);
                        if PostedDocShippCostPage.RUNMODAL = ACTION::LookupOK then;
                    end;
                }       
                */
                // BC Upgrade POENAB02 <<         
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ChangeStyle(); //HEI.02
    end;

    var
        LotNoShipHistory: Page "Lot No. Shipping History";
        ItemLedgerEntriesPage: Page "Item Ledger Entries";
        Text001Lbl: Label 'Formula: Net Weight * (Total Shipping Cost Amount/Total Net Weight)';
        Text002Lbl: Label 'Formula: Internal Transfer Allocated Amount / Net Weight';
        ItemLedgEntry: Record "Item Ledger Entry";
        InventorySetup: Record "Inventory Setup";
        MarkTotals: Boolean;
        LineStyle: Text;

    local procedure ChangeStyle();
    begin
        LineStyle := 'standard';

        if Rec.Reversed then
            if Rec."Distribution Type" = Rec."Distribution Type"::Total then
                LineStyle := 'unfavorable'
            else
                LineStyle := 'attention'
        else
            if Rec."Distribution Type" = Rec."Distribution Type"::Total then
                LineStyle := 'strong';
    end;
}
