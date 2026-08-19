pageextension 53040 PostedReturnReceiptsExt extends "Posted Return Receipts"
{
    // version NAVW110.0,DITW110.00.08,HEI.03,HEI.04

    //     DITW15.00.00.38 DDR 17/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added columns
    //                                    "Vendor Tax Registration No.","Fiscal Representative No.",
    //                                    "Vendor Tax Warehouse Ref."
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW18.00.07 VSC 15/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.02 CHG2200434 IBM COSTES04 19.05.2023 Column Data Availability of WH Shipment & WH Receipt No
    //   # New field added Posted Whse. Receipt No.
    // HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus

    //Bc Upgrade YADAVM09 Field Property Changes.

    //Bc Upgrade YADAVM09 Drink it fields commented.
    //Bc Upgrade YADAVM09  field added in interface extension
    //                      - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus
    //                       - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus

    // BC Upgrade MISHRS14 >>
    // Added HEI.05 Tag
    // HEI.05 CHG2345456-HB4571 IBM ADHIKG01 03.03.2026 Adding Return Order N° Column in Posted Return Receipt Page
    // # Coulumn "Return Order No." added on Posted Return Receipt List Page
    // BC Upgrade MISHRS14 <<

    layout
    {
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.', FRA = 'Spécifie le magasin à partir duquel les articles de stock doivent être expédiés par défaut au client figurant sur le document vente.';

            //Unsupported feature: Change Editable on ""Location Code"(Control 61)". Please convert manually.

        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';
        }
        addafter("Currency Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Editable = false;
                Visible = false;
                ToolTip = 'To check the responsibilty Center';
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            // field("Physical Location Group Code"; "Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it field<<
        }
        // addafter("No. Printed")
        // {
        //     field("Building No."; Rec."Building No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Fiscal Representative No."; Rec."Fiscal Representative No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Customer Tax Registration No."; Rec."Customer Tax Registration No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Customer Tax Warehouse Ref."; Rec."Customer Tax Warehouse Ref.")
        //     {
        //         Visible = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        addafter("Shipment Date")
        {
            // field(Distance; Rec.Distance)
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field(Route; Rec.Route)
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Maximum Weight"; Rec."Maximum Weight")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Maximum Cubage"; Rec."Maximum Cubage")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Total Weight"; Rec."Total Weight")
            // {
            //     Visible = false;
            // }
            // field("Total Cubage"; Rec."Total Cubage")
            // {
            //     Visible = false;
            // }//Bc Upgrade YADAVM09 Drink it fields<<
            // field("Source System Identifier"; Rec."Source System Identifier")
            // {
            //     ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            // } //Bc Upgrade YADAVM09 will be added in interface extension<<
            field("Posted Whse. Receipt No."; Rec."Posted Whse. Receipt No. FND")
            {
                ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            }
            // field("Zycus Order No."; Rec."Zycus Order No.")
            // {
            //     Visible = false;
            //     ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            // }} //Bc Upgrade YADAVM09 will be added in interface extension<<
            // field("PO Transaction Interface Zycus"; Rec."PO Transaction Interface Zycus")
            // {
            //     Visible = false;
            //     //     ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            // }
            // field("Processed PO Transaction Zycus"; Rec."Processed PO Transaction Zycus")
            // {
            //     Visible = false;
            //     //     ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            // }
            // field("Zycus GR UUID"; Rec."Zycus GR UUID")
            // {
            //     Visible = false;
            //     //     ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            // }
            // field("Zycus GR Cancel UUID"; Rec."Zycus GR Cancel UUID")
            // {
            //     Visible = false;
            //     //     ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            // }
            // field("GR Transaction Interface Zycus"; Rec."GR Transaction Interface Zycus")
            // {
            //     Visible = false;
            //     //     ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            // }
            // field("Processed GR Transaction Zycus"; Rec."Processed GR Transaction Zycus")
            // {
            //     Visible = false;
            //     //     ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
            // }//Bc Upgrade YADAVM09 Interface fields<<
            
            // BC Upgrade MISHRS14 >>
            // Added HEI.05 Tag
            field ("Return Order No."; Rec."Return Order No.")
            {
                ApplicationArea = All;
                Caption = 'Return Order No.';
                Visible = true;
            }
            // BC Upgrade MISHRS14 <<
        }
    }
    actions
    {
        modify("&Return Rcpt.")
        {
            CaptionML = ENU = '&Return Rcpt.', FRA = 'Ré&cept. retour';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
        }


        //Unsupported feature: CodeModification on ""&Print"(Action 21).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(ReturnRcptHeader);
        ReturnRcptHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        ReturnRcptHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(ReturnRcptHeader);
        ReturnRcptHeader.PrintRecords(true);
        */
        //end;
        // addafter(Dimensions)
        // {
        //     action("Shipping Costs")
        //     {
        //         CaptionML = ENU = 'Shipping Costs',
        //                     FRA = 'Coûts transport';
        //         Image = Costs;
        //         RunObject = Page "Posted Document Shipping Cost";
        //         RunPageLink = "Source Type" = CONST(6660),
        //                       "Source No." = FIELD("No.");
        //     }
        //}//Bc Upgrade YADAVM09 Drink it fields<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

