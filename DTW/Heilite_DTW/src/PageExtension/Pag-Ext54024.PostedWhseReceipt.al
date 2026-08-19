pageextension 54024 PostedWhseReceiptExt extends "Posted Whse. Receipt"
{
    // version NAVW110.0,DITW110.00.12
    //     DITW15.00.00.21 DDR 18/06/2008 added fields "Shipping Charge Type","Shipping Charge No."
    //                                added property's Form: CalcFields
    // DITW15.00.00.25 DDR 10/10/2008 Added field "Driver Code","Truck Code","Shipping unit cost","shipping cost amount"
    //                                  "Shipping Quantity Invoiced","Shipping Qty. Not Invd."
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields "Shipping Currency Code"
    //                 DLE 06/09/2009 issue 516 Added field "Physical Location Group Code"
    // DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
    // DITW16.00.00.37 DDR 21/01/2011 DIT-715 #1 #53 RTC Page functionnalities & Nav SQL performances
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added AAD/ARC functionnality
    //                                           Added 'Unsatisfactory Comment' menu button in 'Line' button
    //                                           Added functions ShowLineUnstatisfactoryCmts()
    //                                           Added 'Send Report Receipt Request' menus in 'Functions' buttons

    // DITW17.00.02 DDR 19/07/2013 DIT-770 #110 Added codeunit check for EMCS UK (old DIT-715 #512)
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #101
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Removed old Shipping Costs fields from Shipping Tab
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                "Trailer Code"
    //                                "Route Planning No."
    //                                 Route
    // DITW110.00.12 MSF 23/03/2018 NRQ#64208 Return registration & Control û part 4 û Report driver differences
    //                                        Added Action Posted Return Register Control
    // HEI.01 FDD LOGGAP08 IBM POSTOI01, 29.05.2018
    //   # add new buton to print Posted Unloading Note
    // HEI.04 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New fields added in General tab: LSR Order No, LSR Receipt No

    // BC Upgrade SHUKLP03 >> HEI.04 moved in interface ext.


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the posted warehouse receipt.', FRA = 'Indique le numéro de réception entrepôt validée.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code of the location where the items were received.', FRA = 'Spécifie le code du magasin où les articles ont été reçus.';
        }
        modify("Zone Code")
        {
            ToolTipML = ENU = 'Specifies the code of the zone on this posted receipt header.', FRA = 'Spécifie le code de la zone qui figure sur cet en-tête réception enregistré.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the code of the bin on the posted receipt header.', FRA = 'Spécifie le code de l''emplacement qui figure sur l''en-tête réception enregistré.';
        }
        modify("Document Status")
        {
            ToolTipML = ENU = 'Specifies the status of the posted warehouse receipt.', FRA = 'Indique le statut de réception entrepôt validée.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of the receipt.', FRA = 'Spécifie la date comptabilisation de la réception.';
        }
        modify("Vendor Shipment No.")
        {
            ToolTipML = ENU = 'Specifies the vendor shipment no. of the posted warehouse receipt.', FRA = 'Spécifie le numéro bon de livraison du fournisseur de la réception entrepôt enregistrée.';
        }
        modify("Whse. Receipt No.")
        {
            ToolTipML = ENU = 'Specifies the number of the warehouse receipt that the posted warehouse receipt concerns.', FRA = 'Spécifie le numéro réception entrepôt relatif à la réception entrepôt enregistrée.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify("Assignment Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the receipt was assigned to the user.', FRA = 'Spécifie la date à laquelle la réception a été affectée à l''utilisateur.';
        }
        modify("Assignment Time")
        {
            ToolTipML = ENU = 'Specifies the time that the document was assigned to the user.', FRA = 'Spécifie l''heure à laquelle le document a été affecté à l''utilisateur.';
        }
        // BC Upgrade SHUKLP03 >> Moved in the interface ext.
        // addafter("Assignment Time")
        // {
        //     field("LSR Order No."; "LSR Order No.")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("LSR Receipt No."; "LSR Receipt No.")
        //     {
        //         ApplicationArea = All;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Moved in the interface ext.

    }
    actions
    {
        modify("&Receipt")
        {
            CaptionML = ENU = '&Receipt', FRA = '&Réception';
        }
        modify(List)
        {
            CaptionML = ENU = 'List', FRA = 'Lister';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("Put-away Lines")
        {
            CaptionML = ENU = 'Put-away Lines', FRA = 'Lignes rangement';
        }
        modify("Registered Put-away Lines")
        {
            CaptionML = ENU = 'Registered Put-away Lines', FRA = 'Lignes rangement enreg.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Create Put-away")
        {
            CaptionML = ENU = 'Create Put-away', FRA = 'Créer rangement';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify("Put-away List")
        {
            CaptionML = ENU = 'Put-away List', FRA = 'Liste des rangements';
        }
        addafter("&Print")
        {
            action("Print Posted &Unloading Note") // BC Upgrade SHUKLP03 <<
            {
                Caption = 'Print Posted &Unloading Note';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    PostedRcptHeader: Record "Posted Whse. Receipt Header";
                begin
                    //HEI.01>>
                    PostedRcptHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Posted Unoading Note", true, false, PostedRcptHeader);
                    //HEI.01<<
                end;
            }
        }
    }


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

