pageextension 51006 LocationListExtCBN extends "Location List"
{
    // version NAVW110.0,FINXL10.00,DITW110.00.08,HEI.07
    // DITW15.00.00.01 DDR 26/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.25 DDR 21/10/2008 Remove field "Use As Duty"
    // DITW15.00.00.29 DDR 22/12/2008 Added fields "Location Group Code"
    //                                Added menu "Internal Ta&x Item Charges" + Group into "Location" button
    // DITW15.00.00.35 DDR 06/10/2009 Added "Physical Location Group Code" + Group into "Location" button
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151
    //                                                   Added fields "Auto.Create QualityTest Method"
    //                                                   Hidden field "Physical location group code","Location Group Code"
    //                                                   Restore default layout form
    // DITW15.00.00.38 DDR 17/12/2010 issue 458 Added menu Sales/Purchase Tax per Location group
    // DITW16.00.00.37 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Bugfix RunPageLink menus Tax Charges (sales/purchase)
    // DITW15.00.00.39 DDR 19/08/2011 issue 1366 Added field "Use As Quarantine"
    //                     15/09/2011 issue 1343 Modified Caption for "Location Group Code" field
    //                     15/09/2011 issue 1365 Added field "No. of Location Relationships"
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added fields "Work Order Mandatory"
    // DITW16.00.00.43 DDR 02/09/2013 DIT-715 #733 Added fields "Exclude from EMCS "

    // DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added fields "Name 2"
    //              DDR 04/09/2013 DIT-715 #733 merge
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW18.00.07 AKH 29/02/2016 DIT-770 #1425 Automatic Drop Shipments and Special orders: Added field "Purchasing Code"
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer

    // FINXL10.00 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1 Changed PromotedCategory of "Properties" button
    // HEI.01 RFC-CHG0248455 IBM.LS 03.12.2018
    //   # New Field added: "Warning Threshold Days"
    // HEI.02 CHG2008448 IBM.LS 12.12.2019
    //   # New Fields added: "Print Invoice for W/h Ship."
    //                     : "Print DN for W/h Ship."
    //                     : "Print Load Note for W/h Ship."
    // HEI.03 CHG2010375 IBM.LS 22.01.2020
    //   # New Fields added: "Printer Name"
    // HEI.04 FDD-HB503 IBM NASTAA02 30.01.2019 # Post & Print
    //   # New Field added: "Print DN (Sales Inv)"
    // HEI.05 CHG2010375 IBM.LS 12.02.2020
    //   # New Field added: "Logistics E-Mail"
    // HEI.06 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field added: Store
    // HEI.07 CHG2149734 SAHAL01 24.03.2023 Astro - I/F Production - ProductionOrderSync
    //   # Added New Field - Allow to Astro

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a location code for the warehouse or distribution center where your items are handled and stored before being sold.', FRA = 'Spécifie un code magasin pour l''entrepôt ou le centre de distribution gérant et stockant les articles avant leur vente.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name or address of the location.', FRA = 'Spécifie le nom ou l''adresse du magasin.';
        }
        addafter(Name)
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = false;
                ToolTip = 'Specifies the value of the Name 2 field.';
            }
            // field("Location Group Code"; Rec."Location Group Code")
            // {
            //     Visible = false;
            // }
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Visible = false;
            // }
            // field("No. of Location Relationships"; Rec."No. of Location Relationships")
            // {
            //     Visible = false;
            // }  // BC Upgrade NANDIS03
            field("Use As In-Transit"; Rec."Use As In-Transit")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = false;
                ToolTip = 'Specifies that this location is an in-transit location.';
            }
            // field("Use As Finished Goods"; Rec."Use As Finished Goods")
            // {
            //     Visible = false;
            // }
            // field("Use As Quarantine"; Rec."Use As Quarantine")
            // {
            //     Visible = false;
            // }  // BC Upgrade NANDIS03
            field("Require Put-away"; Rec."Require Put-away")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = false;
                ToolTip = 'Specifies if the location requires a dedicated warehouse activity when putting items away.';
            }
            field("Require Pick"; Rec."Require Pick")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = false;
                ToolTip = 'Specifies if the location requires a dedicated warehouse activity when picking items.';
            }
            field("Use Cross-Docking"; Rec."Use Cross-Docking")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = false;
                ToolTip = 'Specifies if the location supports movement of items directly from the receiving dock to the shipping dock.';
            }
            field("Require Receive"; Rec."Require Receive")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = false;
                ToolTip = 'Specifies if the location requires a receipt document when receiving items.';
            }
            field("Require Shipment"; Rec."Require Shipment")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = false;
                ToolTip = 'Specifies if the location requires a shipment document when shipping items.';
            }
            field("Use ADCS"; Rec."Use ADCS")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = false;
                ToolTip = 'Specifies the automatic data capture system that warehouse employees must use to keep track of items within the warehouse.';
            }
            // field("Auto.Create QualityTest Method"; Rec."Auto.Create QualityTest Method")
            // {
            //     Visible = false;
            // }
            // field("Work Order Mandatory"; Rec."Work Order Mandatory")
            // {
            //     Description = 'DIT-715 #457';
            //     Visible = false;
            // }
            // field("Purchasing Code"; Rec."Purchasing Code")
            // {
            //     Visible = false;
            // }
            // field("Exclude from EMCS"; Rec."Exclude from EMCS")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 1 Code"; Rec."Shortcut Property 1 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 2 Code"; Rec."Shortcut Property 2 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 3 Code"; Rec."Shortcut Property 3 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 4 Code"; Rec."Shortcut Property 4 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 5 Code"; Rec."Shortcut Property 5 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 6 Code"; Rec."Shortcut Property 6 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 7 Code"; Rec."Shortcut Property 7 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 8 Code"; Rec."Shortcut Property 8 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 9 Code"; Rec."Shortcut Property 9 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 10 Code"; Rec."Shortcut Property 10 Code")
            // {
            //     Visible = false;
            // }  // BC Upgrade NANDIS03
            field("Van Sales Route"; Rec."Van Sales Route FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Van Sales Route field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ToolTip = 'Specifies the value of the Van Sales Route field.';

            }
            field("Warning Threshold Days"; Rec."Warning Threshold Days FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Expiry Warning Threshold Days field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Expiry Warning Threshold Days field.';

            }
            field("Print Invoice"; Rec."Print Invoice FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print Invoice field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Print Invoice field.';

            }
            field("Print DN (Sales Ship)"; Rec."Print DN (Sales Ship) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print Delivery Note (Sales Shipment) field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Print Delivery Note (Sales Shipment) field.';

            }
            field("Print DN (Whse Ship)"; Rec."Print DN (Whse Ship) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print Delivery Note (Whse Shipment) field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Print Delivery Note (Whse Shipment) field.';

            }
            field("Print Loading Note"; Rec."Print Loading Note FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Print Loading Note field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Print Loading Note field.';

            }
            field("Printer Name"; Rec."Printer Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Printer Name field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Printer Name field.';

            }
            field("Logistics E-Mail"; Rec."Logistics E-Mail FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Logistics E-Mail field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Logistics E-Mail field.';

            }
            field(Store; Rec."Store FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the STORE field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the STORE field.';

            }
            field("Allow to Astro"; Rec."Allow to Astro FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow to Astro field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Allow to Astro field.';

            }
        }
    }
    actions
    {
        modify("&Location")
        {
            CaptionML = ENU = '&Location', FRA = '&Magasin';
        }
        modify("&Resource Locations")
        {
            CaptionML = ENU = '&Resource Locations', FRA = '&Magasins ressource';

            //Unsupported feature: Change RunPageLink on ""&Resource Locations"(Action 10)". Please convert manually.

        }
        modify("&Zones")
        {
            CaptionML = ENU = '&Zones', FRA = '&Zones';

            //Unsupported feature: Change RunPageLink on ""&Zones"(Action 7300)". Please convert manually.

        }
        modify("&Bins")
        {
            CaptionML = ENU = '&Bins', FRA = '&Emplacements';

            //Unsupported feature: Change RunPageLink on ""&Bins"(Action 11)". Please convert manually.

        }
        modify("Transfer Order")
        {
            CaptionML = ENU = 'Transfer Order', FRA = 'Ordre de transfert';
        }
        modify("Create Warehouse location")
        {
            CaptionML = ENU = 'Create Warehouse location', FRA = 'Création entrepôt';
        }
        modify("Inventory - Inbound Transfer")
        {
            CaptionML = ENU = 'Inventory - Inbound Transfer', FRA = 'Stocks : Enlogement transfert';
        }
        modify(Action1907283206)
        {
            CaptionML = ENU = 'Transfer Order', FRA = 'Ordre de transfert';
        }
        modify("Transfer Shipment")
        {
            CaptionML = ENU = 'Transfer Shipment', FRA = 'Expédition transfert';
        }
        modify("Transfer Receipt")
        {
            CaptionML = ENU = 'Transfer Receipt', FRA = 'Réception transfert';
        }
        // modify("Check on Negative Inventory")
        // {
        //     CaptionML = ENU = 'Check on Negative Inventory', FRA = 'Vérifiez l''inventaire négatif';
        // }  // BC Upgrade NANDIS03
        addafter("&Bins")
        {
            separator(Separator1101000001)
            {
            }
            // action(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     Description = 'FINXL9.00';
            //     Image = Category;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "Master Data Properties";
            //     RunPageLink = "Table ID" = CONST(14),
            //                   Code = FIELD(Code);
            // }  // BC Upgrade NANDIS03
            separator(Separator1100083017)
            {
            }
            // action("Location &Relationships")
            // {
            //     CaptionML = ENU = 'Location &Relationships',
            //                 FRA = 'Magasin &Relations';
            //     Image = Relationship;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "Location Relationships";
            //     RunPageLink = Code = FIELD(Code);
            // }
            // action("Location Tax Groups")
            // {
            //     CaptionML = ENU = 'Location Tax Groups',
            //                 FRA = 'Groupes magasin taxe';
            //     Image = TaxDetail;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "Location Groups";
            // }
            // action("Physical Location Groups")
            // {
            //     CaptionML = ENU = 'Physical Location Groups',
            //                 FRA = 'Groupes magasins réels';
            //     Image = PhysicalInventory;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     RunObject = Page "Physical Location Groups";
            // }
            // separator(Separator1100083033)
            // {
            // }
            // action("&Tax Charges (Sales)")
            // {
            //     CaptionML = ENU = '&Tax Charges (Sales)',
            //                 FRA = '&Charges d''impôt (Vente)';
            //     Image = TaxSetup;
            //     RunObject = Page "Sales Tax Item Charges";
            //     RunPageLink = "Location Code" = FIELD(Code),
            //                   "Location From Type" = CONST(Location);
            // }
            // action("T&ax Charges (Purchase)")
            // {
            //     CaptionML = ENU = 'T&ax Charges (Purchase)',
            //                 FRA = '&Charges d''impôt (Achat)';
            //     Image = TaxSetup;
            //     RunObject = Page "Purchase Tax Item Charges";
            //     RunPageLink = "Location Code" = FIELD(Code),
            //                   "Location From Type" = CONST(Location);
            // }
            // action("Internal Ta&x Item Charges")
            // {
            //     CaptionML = ENU = 'Internal Ta&x Item Charges',
            //                 FRA = 'Frais anne&xes interne';
            //     Image = TaxSetup;
            //     RunObject = Page "Internal Tax Item Charges";
            //     RunPageLink = "Location From Type" = CONST(Location),
            //                   "Location From Code" = FIELD(Code);
            // }
            // separator(Separator1100083039)
            // {
            // }
            // action("Tax Charges (Sales) - Group")
            // {
            //     CaptionML = ENU = 'Tax Charges (Sales) - Group',
            //                 FRA = 'Charges d''impôt (Vente) - Groupe';
            //     Image = TaxSetup;
            //     RunObject = Page "Sales Tax Item Charges";
            //     RunPageLink = "Location From Type" = CONST("Location Group"),
            //                   "Location Code" = FIELD("Location Group Code");
            // }
            // action("Tax Charges (Purchase) - Group")
            // {
            //     CaptionML = ENU = 'Tax Charges (Purchase) - Group',
            //                 FRA = '&Charges d''impôt (Achat) - Groupe';
            //     Image = TaxSetup;
            //     RunObject = Page "Purchase Tax Item Charges";
            //     RunPageLink = "Location From Type" = CONST("Location Group"),
            //                   "Location Code" = FIELD("Location Group Code");
            // }
            // action("Internal Tax Item Charges - Group")
            // {
            //     CaptionML = ENU = 'Internal Tax Item Charges - Group',
            //                 FRA = 'Frais anne&xes interne - Groupe';
            //     Image = TaxSetup;
            //     RunObject = Page "Internal Tax Item Charges";
            //     RunPageLink = "Location From Type" = CONST("Location Group"),
            //                   "Location From Code" = FIELD("Location Group Code");
            // }
            // separator(Separator1100083020)
            // {
            // }
            // action("&Deposit Charges (Sales)")
            // {
            //     CaptionML = ENU = '&Deposit Charges (Sales)',
            //                 FRA = '&Frais consignet (Vente)';
            //     Image = TaxSetup;
            //     RunObject = Page "Sales Deposit Item Charges";
            //     RunPageLink = "Location Code" = FIELD(Code);
            // }
            // action("D&eposit Charges (Purchase)")
            // {
            //     CaptionML = ENU = 'D&eposit Charges (Purchase)',
            //                 FRA = '&Frais de dépôt (Achat)';
            //     Image = TaxSetup;
            //     RunObject = Page "Purchase Deposit Item Charges";
            //     RunPageLink = "Location Code" = FIELD(Code);
            // }
            // separator(Separator1100083016)
            // {
            // }
            // action("D&iscount Charges (Sales)")
            // {
            //     CaptionML = ENU = 'D&iscount Charges (Sales)',
            //                 FRA = '&Frais de remise (Vente)';
            //     Image = Discount;
            //     RunObject = Page "Sales Discount Item Charges";
            //     RunPageLink = "Location Code" = FIELD(Code);
            // }
            // action("Di&scount Charges (Purchase)")
            // {
            //     CaptionML = ENU = 'Di&scount Charges (Purchase)',
            //                 FRA = '&Frais de remise (Achat)';
            //     Image = Discount;
            //     RunObject = Page "Purchase Discount Item Charges";
            //     RunPageLink = "Location Code" = FIELD(Code);
            // }
            // separator(Separator1100083025)
            // {
            // }
            // action("&Promotion Charges (Sales)")
            // {
            //     CaptionML = ENU = '&Promotion Charges (Sales)',
            //                 FRA = 'Frais de &Promotion (Vente)';
            //     Image = TaxSetup;
            //     RunObject = Page "Sales Promotion Item Charges";
            //     RunPageLink = "Location Code" = FIELD(Code);
            // }
            // action("Pr&omotion Charges (Purchase)")
            // {
            //     CaptionML = ENU = 'Pr&omotion Charges (Purchase)',
            //                 FRA = 'Frais de &Promotion (Achat)';
            //     Image = TaxSetup;
            //     RunObject = Page "Purch. Promotion Item Charges";
            //     RunPageLink = "Location Code" = FIELD(Code);
            // }
            // action("Delivery Times")
            // {
            //     Caption = 'Delivery Times';
            //     Description = 'DITW110.00.12 NRQ#16026';
            //     Image = Relationship;
            //     RunObject = Page "Delivery Times";
            //     RunPageLink = "No." = FIELD(Code);
            //     RunPageView = sorting("No.", "Address Code")
            //                   where("Source Type" = CONST(Location));
            // }  // BC Upgrade NANDIS03
        }
    }


    //Unsupported feature: CodeModification on "GetSelectionFilter(PROCEDURE 3)". Please convert manually.

    //procedure GetSelectionFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SETSELECTIONFILTER(Loc);
    EXIT(SelectionFilterManagement.GetSelectionFilterForLocation(Loc));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.SETSELECTIONFILTER(Loc);
    exit(SelectionFilterManagement.GetSelectionFilterForLocation(Loc));
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

