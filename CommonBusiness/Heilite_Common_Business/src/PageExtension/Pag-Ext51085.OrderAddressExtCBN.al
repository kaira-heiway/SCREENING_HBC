pageextension 51085 OrderAddressExtCBN extends "Order Address"
{
    // version NAVW110.0,IPLXL9.00.001,DITW110.00.08,HEI.01
    //DITW15.00.00.25 DDR 21/10/2008 Added tab "Drink-It"
    //                                Added filed "Vendor DTax Group Code"
    //                                Added button Purchases for Item charge Tax groups
    //DITW15.00.00.28 DDR 24/11/2008 Added fields "Tax Registration No.","Fiscal Representative No." into tab Drink-It
    //DITW15.00.00.37 DDR 02/04/2010 issue 1110 Added field "Transport Time" into Drink-It tab
    //DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                Added fields
    //                                    (Foreign Trade) "Transaction Type","Transport Method","Transaction Specification",
    //                                    "Exit Point","Area Code"
    //                    13/09/2010     (Drink-it) "Tax Warehouse Reference"
    //                    06/12/2010 issue 1217 (DIT711 97)
    //                                    (Drink-It) "Tax Office Code"
    //DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added field "Journey Time" (Drink-It)
    //DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    //DITW18.00.07 AKH 10/05/2016 DIT-770 #1346 Added new tab Receiving with field "Vendor Delivery Type"
    //DITW18.00.07 VSC 11/05/2016 DIT-770 #1968 New Page Link to Delivery Times where "Source Type" = Vendor
    //DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977 Default & Mandatory Route setup + Route default values + shipment date calculation

    //DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //IPLXL9.00.001 IMI 10/06/2015: Added field GLN

    //HEI.01 FDD PURGAP05 IBM LAZARE02 03.07.2017 # New field Supplying Plant Vendor Number


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies an order-from address code.', FRA = 'Spécifie un code pour l''adresse de commande.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the company name for the order address.', FRA = 'Spécifie le nom de la société pour l''adresse commande.';
        }
        modify(Address)
        {
            ToolTipML = ENU = 'Specifies the order address.', FRA = 'Spécifie l''adresse commande.';
        }
        modify("Address 2")
        {
            ToolTipML = ENU = 'Specifies another line of the order address.', FRA = 'Spécifie une autre ligne de l''adresse commande.';
        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the post code of the order address.', FRA = 'Spécifie le code postal de l''adresse commande.';
        }
        modify(City)
        {
            ToolTipML = ENU = 'Specifies the city of the order address.', FRA = 'Spécifie la ville de l''adresse commande.';

            //Unsupported feature: Change ImplicitType on "City(Control 10)". Please convert manually.

        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the telephone number that is associated with the order address.', FRA = 'Spécifie le numéro de téléphone qui est associé à l''adresse de commande.';
        }
        modify(Contact)
        {
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact when you do business with this vendor at this address.', FRA = 'Spécifie le nom de la personne que vous contactez habituellement lorsque vous commercez avec ce fournisseur à cette adresse.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when this order address was last modified.', FRA = 'Spécifie la date de la dernière modification de l''adresse de cette commande.';
        }
        modify(Communication)
        {
            CaptionML = ENU = 'Communication', FRA = 'Communication';
        }
        //BC Upgrade Priya>>
        //modify("Phone No.2") //Field not found in Base table also not in extension table.
        //{
        //    ToolTipML = ENU = 'Specifies the telephone number that is associated with the order address.', FRA = 'Spécifie le numéro de téléphone qui est associé à l''adresse de commande.';
        //} //BC Upgrade Priya<<
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the fax number associated with the order address.', FRA = 'Spécifie le numéro de télécopie qui est associé à l''adresse de commande.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies the email address associated with the order address.', FRA = 'Spécifie l''adresse e-mail qui est associée à l''adresse de commande.';
        }
        modify("Home Page")
        {
            ToolTipML = ENU = 'Specifies the home page address associated with the order address.', FRA = 'Spécifie la page d''accueil associée à l''adresse de commande.';
        }
        addafter("Last Date Modified")
        {
            //BC Upgrade Priya>>
            //field(GLN;GLN)
            //{
            //    Description = 'IPLXL9.00.001';
            //}  //BC Upgrade Priya<<
            field("Supplying Plant Vendor Number FND"; Rec."Supplying Plant Vndor Num. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplying Plant Vendor Number field.';
            }
        }
        addafter(Communication)
        {
            //BC Upgrade Priya>> Drink IT
            //group(Receiving)
            //{
            //    CaptionML = ENU='Receiving',
            //                FRA='Recéption';
            //    field(Distance;Distance)
            //    {
            //    }
            //    field("Delivery Sequence";"Delivery Sequence")
            //    {
            //        Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
            //    }
            //    field(Route;Route)
            //    {
            //        Description = '#1002';

            //        trigger OnDrillDown();
            //        var
            //            lrRouteCombination : Record "Route Combination";
            //            lpRouteCombination : Page "Route Combinations";
            //        begin
            //<< DITW18.00.07 VSC 11/05/2016 DIT-770 #1968
            //            lrRouteCombination.RESET;
            //            FILTERGROUP(2);
            //            lrRouteCombination.SETRANGE("Source Type",lrRouteCombination."Source Type"::Vendor);
            //            lrRouteCombination.SETRANGE("No.","Vendor No.");
            //            lrRouteCombination.SETRANGE("Address Code",Code);
            //            lrRouteCombination.SETRANGE(Code,Route);
            //            FILTERGROUP(2);
            //            lpRouteCombination.SETTABLEVIEW(lrRouteCombination);
            //            lpRouteCombination.RUNMODAL;
            //            //>> DITW18.00.07 VSC DIT-770 #1968
            //        end;
            //    }
            //    field("Shipping Agent Code";"Shipping Agent Code")
            //    {
            //    }
            //    field("Shipping Agent Service Code";"Shipping Agent Service Code")
            //    {
            //    }
            //    field("Truck Zone";"Truck Zone")
            //    {
            //    }
            //    field("Require 2 Drivers";"Require 2 Drivers")
            //    {
            //    }
            //    field("Vendor Delivery Type";"Vendor Delivery Type")
            //    {
            //    }
            //}  
            //group("Foreign Trade")
            //{
            //    CaptionML = ENU='Foreign Trade',
            //                FRA='International';
            //    field("Transaction Type";"Transaction Type")
            //    {
            //    }
            //    field("Transport Method";"Transport Method")
            //    {
            //    }
            //    field("Transaction Specification";"Transaction Specification")
            //    {
            //    }
            //    field("Entry Point";"Entry Point")
            //    {
            //    }
            //    field("Area";Area)
            //    {
            //    }
            //}
            //group("Drink-It")
            //{
            //    CaptionML = ENU='Drink-It',
            //                FRA='Drink-It';
            //    field("Vendor DTax Group Code";"Vendor DTax Group Code")
            //    {
            //    }
            //    field("Tax Registration No.";"Tax Registration No.")
            //    {
            //    }
            //    field("Tax Warehouse Reference";"Tax Warehouse Reference")
            //    {
            //    }
            //    field("Fiscal Representative No.";"Fiscal Representative No.")
            //    {
            //    }
            //    field("Journey Time";"Journey Time")
            //    {
            //    }
            //    field("Transport time";"Transport time")
            //    {
            //    }
            //    field("Tax Office Code";"Tax Office Code")
            //    {
            //    }
            //}  //BC Upgrade Priya<<
        }
    }
    actions
    {
        modify("&Address")
        {
            CaptionML = ENU = '&Address', FRA = 'A&dresse';
        }
        modify("Online Map")
        {
            CaptionML = ENU = 'Online Map', FRA = 'Online Map';
            ToolTipML = ENU = 'View the address on an online map.', FRA = 'Affichez l''adresse sur une carte en ligne.';
        }
        addafter("&Address")
        {
            group("&Purchases")
            {
                CaptionML = ENU = '&Purchases',
                            FRA = 'Ac&hats';
                //BC Upgrade Priya>>
                //action("Ta&x Charges")
                //{
                //    CaptionML = ENU='Ta&x Charges',
                //                FRA='Taxe d''impôt';
                //    Description = 'DITW15.00.00.01';
                //    Image = VATLedger;
                //    Promoted = true;
                //    PromotedCategory = Process;
                //    RunObject = Page "Purchase Tax Item Charges";
                //                    RunPageLink = "Purchase Type" = CONST("Vendor Tax Group"),
                //                  "Purchase Code" = FIELD("Vendor DTax Group Code");
                //}
                //action("Delivery Times")
                //{
                //    CaptionML = ENU='Delivery Times',
                //                FRA='Délais de livraison';
                //    RunObject = Page "Delivery Times";
                //                    RunPageLink = "No." = FIELD("Vendor No."),
                //                  "Address Code" = FIELD(Code);
                //                    RunPageView = sorting("No.", "Address Code")
                //                  where("Source Type" = CONST(Vendor));
                //}  //BC Upgrade Priya<<
            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

