pageextension 52019 PostedPurchaseReceiptExt extends "Posted Purchase Receipt"
{
    // version NAVW110.0.00.15052,FINXL10.00,DITW110.00.09,HEI.11

    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 18/06/2008 added new tab "Shipping Agent"
    //                                  added form property CalcFields("Total Weight","Total Cubage")
    //                                  added fields (not editable)
    //                                    "Maximum Weight","Maximum Cubage",
    //                                    "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per",
    //                                    "Total Weight","Total Cubage","Shipping Agent Code","Shipping Agent Service Code"
    //                                    "Shipping Charge Per"
    //   DITW15.00.00.23.04 DDR 16/09/2008 Added fields (not editable)
    //                                      "Shipping Quantity Invoiced","Shipping Qty. Not Invd."
    //                                      "Shipping Unit Cost","Shipping Cost Amount"
    //   DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    //   DITW15.00.00.25 DDR 10/10/2008 Added field "Truck Code","Driver Code" into "Shipping Agent" tab
    //                                  Remove fields "Shipping Charge Type","Shipping Charge No.",
    //                                    "Shipping Unit Cost","Shipping Cost Amount"
    //                                    "Shipping Quantity Invoiced","Shipping Qty. Not Invd."
    //                       21/10/2008 Deleted field2013722 Duty Tax Type
    //                                  Added fields "Vendor DTax Group Code" into Invoicing tab
    //   DITW15.00.00.28 DDR 24/11/2008 Added fields "Fiscal Representative No."
    //   DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
    //   DITW15.00.00.36 DDR 18/12/2009 issue 949 Added "Entry Point" into 'Shipping Agent' tab
    //   DITW15.00.00.38 DDR 05/10/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                             Added 'Unsatisfactory Comment' menu button in 'Line' button
    //                                             Added functions ShowLineUnstatisfactoryCmts()
    //                                             Added 'Send Report Receipt Request' menus in 'Functions' buttons
    //                   DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    //   DITW15.00.00.39 DDR 19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    //   DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields "Delivery Sequence","Distance" (Shipping Agent tab)
    //                       11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    call function SetDisableRefreshLines() before each report
    //                                                    (don't use the <RunObject> property)

    //   FINXL7.00.001 RBE 20/03/2013 : Added field "Your Reference" on page
    //                                  PDF Functionality
    //   DITW17.00.01 VVE 22/03/2013 Check which codeunit to use from setup
    //   DITW17.00.02 DDR 06/06/2013 DIT-770 #99 Added fields "Ship-to Country/Region Code" into 'Shipping' tab
    //                    04/07/2013 DIT-770 #99 Added fields "GWC Country/Region Code" into 'Foreign Trade' tab
    //                    28/08/2013 DIT-770 #178 Remove DIT-770 #99
    //   DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added fields "Physical Location Group Code"
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    //   DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB
    //   DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    //   DITW18.00.07 AKH 21/04/2016 DIT-770 #1508 Removed filter
    //   DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added fields "Vendor Delivery Type" & "Delivery Time (sec.)" under Shipping tab

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    //   DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields

    //   HEI.01 FDD-PTPGAP062 IBM.HORTOC01 11.07.2017
    //     # Display field UserID
    //   HEI.02 HLSRM02-05 IBM LAZARE02 31.07.2017
    //     #New fields for SRM integration added to SRM tab
    //   HEI.03 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //     # New Field added "Gate Entry No."
    //   HEI.04 FDD-PURGAP027 IBM NASTAA02 14.06.2019 # Maximo POs Approval Flow
    //     # Created new Page Action "Purchase Receipt Additional"
    //   HEI.05 CHG2024557 FDD-HT821 IBM SHANKJ03 12.02.2020
    //     # New field added Maximo status

    //   HEI.06 CHG2058828 IBM NANDIS01 20.05.2020 GR IR Writeoff
    //     # New button created "GR/IR WriteOff Invoicing" for the funtionality

    //   HEI.07 CHG2091605 IBM NANDIS01 18.12.2020 invoice reference issue
    //     # Add No Series to be populated at time of creation of PO
    //   HEI.08 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //     # New field added in General tab: LSR Order No
    //     # New global var:PostedPurchReceiptAdditional,  code added
    //   HEI.09 CHG2190299 FDD-HB3316 IBM NANDIS01 24.05.2023 # POSM eshop SRM- HL interface
    //     # New field shown in page - "POSM GR Confirmed" in SRM tab
    //   HEI.10 CHG2201773 HB3442 SRIVAS07 IBM 27/11/23 - Development - Undoing a Goods Receipt for Fixed Asset
    //     # Added new action - GRIR Reversal
    //   HEI.11 CHG2201773 HB3442 SRIVAS07 IBM 06/12/23 - Development - Undoing a Goods Receipt for Fixed Asset
    //     # Change the Caption of Action - GRIR Reversal


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.', FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';
        }
        modify("Buy-from Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor who will delivers the items.', FRA = 'Spécifie le numéro du fournisseur qui livre les articles.';
        }
        modify("Buy-from Vendor Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor who delivered the items.', FRA = 'Spécifie le nom du fournisseur qui a livré les articles.';
        }
        modify("Buy-from Address")
        {
            ToolTipML = ENU = 'Specifies the address of the vendor who delivered the items.', FRA = 'Spécifie l''adresse du fournisseur qui a livré les articles.';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address"(Control 52)". Please convert manually.

        }
        modify("Buy-from Address 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the address of the vendor who delivered the items.', FRA = 'Spécifie un complément à l''adresse du fournisseur qui a livré les articles.';

            //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 54)". Please convert manually.

        }
        modify("Buy-from City")
        {
            ToolTipML = ENU = 'Specifies the city of the vendor who delivered the items.', FRA = 'Spécifie la ville du fournisseur qui a livré les articles.';

            //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 56)". Please convert manually.

        }
        modify("Buy-from Post Code")
        {
            ToolTipML = ENU = 'Specifies the post code of the vendor who delivered the items.', FRA = 'Spécifie le code postal du fournisseur qui a livré les articles.';
        }
        modify("Buy-from Contact")
        {
            ToolTipML = ENU = 'Specifies the contact person at the vendor who delivered the items.', FRA = 'Spécifie la personne à contacter chez le fournisseur qui a livré les articles.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of the record.', FRA = 'Spécifie la date comptabilisation de l''enregistrement.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date when the purchase document was created.', FRA = 'Spécifie la date de création du document achat.';
        }
        modify("Requested Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.', FRA = 'Spécifie la date à laquelle vous souhaitez que le fournisseur livre les articles à l''adresse destinataire. La valeur du champ est utilisée pour calculer la date limite de commande garantissant la livraison des articles à la date de réception demandée. Si vous ne souhaitez pas indiquer une date de livraison, vous pouvez laisser ce champ vide.';
        }
        modify("Vendor Order No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s order number.', FRA = 'Spécifie le numéro de commande du fournisseur.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is associated with the receipt.', FRA = 'Spécifie l''acheteur associé à la réception.';
        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }
        modify("Pay-to Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor that you received the invoice from.', FRA = 'Spécifie le numéro du fournisseur qui vous a fourni la facture.';
        }
        modify("Pay-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor that you received the invoice from.', FRA = 'Spécifie le nom du fournisseur qui vous a fourni la facture.';
        }
        modify("Pay-to Address")
        {
            ToolTipML = ENU = 'Specifies the address of the vendor that you received the invoice from.', FRA = 'Spécifie l''adresse du fournisseur qui vous a fourni la facture.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 22)". Please convert manually.

        }
        modify("Pay-to Address 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the address of the vendor that the invoice was received from.', FRA = 'Spécifie un complément à l''adresse du fournisseur qui a fourni la facture.';

            //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 24)". Please convert manually.

        }
        modify("Pay-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the post code of the vendor that you received the invoice from.', FRA = 'Spécifie le code postal du fournisseur qui vous a fourni la facture.';
        }
        modify("Pay-to City")
        {
            ToolTipML = ENU = 'Specifies the city of the vendor that you received the invoice from.', FRA = 'Spécifie la ville du fournisseur qui vous a fourni la facture.';

            //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 26)". Please convert manually.

        }
        modify("Pay-to Contact")
        {
            ToolTipML = ENU = 'Specifies the contact person at the vendor that you received the invoice from.', FRA = 'Spécifie la personne à contacter chez le fournisseur qui vous a fourni la facture.';
        }
        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }
        modify("Ship-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the customer that items on the purchase order were shipped to, as a drop shipment.', FRA = 'Spécifie le nom du client à qui les articles de la commande achat ont été livrés, en tant que livraison directe.';
        }
        modify("Ship-to Address")
        {
            ToolTipML = ENU = 'Specifies the address that items on the purchase order were shipped to, as a drop shipment..', FRA = 'Spécifie l''adresse à laquelle les articles de la commande achat ont été expédiés, en tant que livraison directe.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 32)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the address that items on the purchase order were shipped to, as a drop shipment.', FRA = 'Spécifie un complément à l''adresse à laquelle les articles de la commande achat ont été expédiés, en tant que livraison directe.';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 34)". Please convert manually.

        }
        modify("Ship-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the post code that items on the purchase order were shipped to, as a drop shipment.', FRA = 'Spécifie le code postal où les articles de la commande achat ont été expédiés, en tant que livraison directe.';
        }
        modify("Ship-to City")
        {
            ToolTipML = ENU = 'Specifies the city that items on the purchase order were shipped to, as a drop shipment.', FRA = 'Spécifie la ville où les articles de la commande achat ont été expédiés, en tant que livraison directe.';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 36)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            ToolTipML = ENU = 'Specifies the contact person at the customer that items on the purchase order were shipped to, as a drop shipment.', FRA = 'Spécifie la personne à contacter chez le client à qui les articles de la commande achat ont été livrés, en tant que livraison directe.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies how the vendor must ship items to you. The shipment method code is copied from this field to purchase documents that you send to the vendor.', FRA = 'Spécifie de quelle manière le fournisseur doit vous expédier les articles. Le code des conditions de livraison est copié depuis ce champ vers les documents achat que vous envoyez au fournisseur.';
        }
        modify("Expected Receipt Date")
        {
            ToolTipML = ENU = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.', FRA = 'Spécifie la date à laquelle les articles doivent être disponibles dans l''entrepôt. Si vous laissez ce champ vide, le calcul est effectué comme suit : Date planifiée de réception + Délai de sécurité + Délai enlogement + Date réception prévue.';
        }
        // addafter("Buy-from City")
        // {
        //     field("Buy-from Country/Region Code"; rec."Buy-from Country/Region Code")
        //     {
        //         Editable = false;
        //         ApplicationArea = all;
        //     }
        // } //BC Upgrade GUNREM01 Commented becuase the field is already there in page

        //BC Upgrade GUNREM01 >> Commented DIT
        // addafter("No. Printed")
        // {
        //     field("Your Reference";"Your Reference")
        //     {
        //         Description = 'FINXL7.00.001';
        //         Editable = false;
        //     }
        // }
        // addafter("Document Date")
        // {
        //     field("Tax Date"; Rec."Tax Date")
        //     {
        //         Editable = false;
        //     }
        // }
        //BC Upgrade GUNREM01 << Commented DIT
        addafter("Responsibility Center")
        {
            //BC Upgrade GUNREM01 >> Commented DIT
            // field("Document Shipping Costs"; rec."Document Shipping Costs")
            // {
            // }  //BC Upgrade GUNREM01 << Commented DIT
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;


            }
            field("Gate Entry No."; Rec."Gate Entry No. FND")
            {
                ApplicationArea = all;
            }
            //BC Upgrade GUNREM01 >> Fields added in Interface
            // field("Maximo Status"; Rec."Maximo Status")
            // {
            //     ApplicationArea = all;
            // }
            // field("PostedPurchReceiptAdditional.""LSR Order No"; PostedPurchReceiptAdditional."LSR Order No")
            // {
            //     ApplicationArea = all;
            // }
            //BC Upgrade GUNREM01 << Fields added in Interface
        }
        addafter("Pay-to City")
        {
            // field("Pay-to Country/Region Code"; rec."Pay-to Country/Region Code")
            // {
            //     Editable = false;
            //     ApplicationArea = all;
            // } //BC Upgrade GUNREM01 commenetd becuase alredy exist in Page
        }
        // addafter("Shortcut Dimension 2 Code")
        // {
        //     field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
        //     {
        //         Editable = false;
        //         ApplicationArea = all;
        //     }
        // } //BC upgrade GUNREM01 DIT
        addafter("Ship-to City")
        {
            // field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
            // {
            //     Editable = false;
            //     ApplicationArea = all;
            // } //BC Uograde GUNREM01 commented becuase already exist in Page
        }
        addafter("Ship-to Contact")
        {
            // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
            // {
            //     Editable = false;
            // }
            // field("Tax Office Code"; Rec."Tax Office Code")
            // {
            //     Editable = false;
            // }
            // field("Physical Location Group Code"; rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // } //BC Upgrade GUNREM01 DIT
        }
        addafter("Expected Receipt Date")
        {
            // field("Vendor Delivery Type"; Rec."Vendor Delivery Type")
            // {
            //     Editable = false;
            // }
            // field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
            // {
            // }  //BC Upgrade GUNREM01 DIT
            group("Foreign Trade")
            {
                CaptionML = ENU = 'Foreign Trade',
                            FRA = 'International';
            }
            group("Shipping Agent")
            {
                CaptionML = ENU = 'Shipping Agent',
                            FRA = 'Transporteur';
                field("Copy Shipment Method Code"; Rec."Shipment Method Code")
                {

                    Editable = false;
                    ApplicationArea = all;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = all;
                }
                //BC Upgrade GUNREM01 << Commenetd DIT
                //   field("Shipping Agent Code"; Rec."Shipping Agent Code")
                //    {
                //        Editable = false;
                //        ApplicationArea = all;
                //    }
                //    field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                //    {
                //        Editable = false;
                //    }
                //    field(Distance; Distance)
                //    {
                //        Editable = false;
                //    }
                //    field("Truck Code"; "Truck Code")
                //    {
                //        Editable = false;
                //    }
                //    field("Driver Code"; "Driver Code")
                //    {
                //        Editable = false;
                //    }
                //    field("Delivery Sequence"; "Delivery Sequence")
                //    {
                //        Editable = false;
                //    }
                //    field("Shipping Charge Per"; "Shipping Charge Per")
                //    {
                //        Editable = false;
                //    }
                //    field("Total Weight"; "Total Weight")
                //    {
                //        Editable = false;
                //    }
                //    field("Total Cubage"; "Total Cubage")
                //    {
                //        Editable = false;
                //    }
                //     //BC Upgrade GUNREM01 << Commenetd DIT
            }
            //BC Upgrade GUNREM01 >> added in interface
            // group(SRM)
            // {
            //     Caption = 'SRM';
            //     field("SRM Contract No."; Rec."SRM Contract No.")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("SRM Contract Name"; Rec."SRM Contract Name")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("SRM Contract Type"; Rec."SRM Contract Type")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("Valid From"; Rec."Valid From")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("Valid To"; Rec."Valid To")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field(Channel; Rec.Channel)
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("Shipment Method Location"; Rec."Shipment Method Location")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field(Closed; Rec.Closed)
            //     {
            //         ApplicationArea = all;
            //     }

            // field("SRM Order No."; Rec."SRM Order No.")
            // {
            //     ApplicationArea = all;
            // }

            //     field("Target Value Currency"; Rec."Target Value Currency")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("Target Value Amount"; Rec."Target Value Amount")
            //     {
            //         ApplicationArea = all;
            //     }
            //     field("POSM GR Confirmed"; Rec."POSM GR Confirmed")
            //     {
            //         ApplicationArea = all;
            //     }
            // }
            //BC Upgrade GUNREM01 << added in interface
        }
        moveafter("Buy-from Address 2"; "Buy-from Post Code")
    }
    actions
    {
        modify("&Receipt")
        {
            CaptionML = ENU = '&Receipt', FRA = '&Réception';
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
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify("&Print")
        {

            //Unsupported feature: Change Level on ""&Print"(Action 47)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
        }


        //Unsupported feature: CodeModification on ""&Print"(Action 47).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
        PurchRcptHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchReceiptLines.PAGE.SetDisableRefreshLines(true);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
        PurchRcptHeader.PrintRecords(true);
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.PurchReceiptLines.PAGE.SetDisableRefreshLines(false);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;
        // addafter(Approvals)
        // {
        //BC Upgrade GUNREM01 >> Commented DIT
        // action("Shipping Costs")
        // {
        //     ApplicationArea = all;
        //     CaptionML = ENU = 'Shipping Costs',
        //                     FRA = 'Coûts transport';
        //     Image = Costs;
        //     RunObject = Page "Posted Document Shipping Cost";
        //     RunObject = page
        //         RunPageLink = "Source Type" = CONST(120),
        //                       "Source No." = FIELD("No.");
        //     }
        //BC Upgrade GUNREM01 << Commented DIT
        //BC Upgrade GUNREM01 >> Added in Interface
        // action("Purchase Receipt Additional")
        // {
        //     ApplicationArea = all;
        //     Caption = 'Purchase Receipt Additional';
        //     Image = Purchase;
        //     RunObject = Page "Purch. Rcpt. Additional";
        //     RunPageLink = "No." = FIELD("No.");
        // }
        //BC Upgrade GUNREM01 << Added in Interface

        //  }
        //  addfirst(ActionContainer1900000004)
        //   addfirst()
        //     {
        addfirst(processing)
        {
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                // separator(Separator1100083326)
                // {
                // }
                // action("Send Report Receipt Request")
                // {
                //     CaptionML = ENU = 'Send Report Receipt Request',
                //                 FRA = 'Envoyer le rapport requête recéption';
                //     Image = SendElectronicDocument;

                //     trigger OnAction();
                //     var
                //         EMCSExport: Codeunit "EMCS EDI-IE818 Outbox";
                //     begin
                //         // <<DITW15.00.00.38 DDR 05/10/2010
                //         //<<DITW17.00.01 VVE 22/03/2013
                //         //<<DITW17.00.02 DDR 28/08/2013 DIT-770 #178
                //         EMCSExport.CreateOutboxPurchaseReceipt(Rec);
                //         //>>DITW17.00.02 DDR 28/08/2013 DIT-770 #178
                //         //>>DITW17.00.01 VVE 22/03/2013
                //         // >>DITW15.00.00.38 DDR
                //     end;
                // }
                action("GRIR Reversal")
                {
                    Caption = 'GRIR Undo Clearing';
                    ToolTip = 'GR/IR reversal after Undo FA Receipt';
                    ApplicationArea = all;


                    trigger OnAction();
                    var
                        UnoReceiptLine: Codeunit "Undo Purchase Receipt Line";
                        PurchRecptLine: Record "Purch. Rcpt. Line";
                        HeinikenBCUpgradeSTP: Codeunit HeinekenBCUpgrade_STP; //BC Upgrade GUNREM01 added
                    begin
                        //HEI.10>>
                        PurchRecptLine.RESET;
                        PurchRecptLine.SETRANGE("Document No.", Rec."No.");
                        PurchRecptLine.SETFILTER(Quantity, '<%1', 0);
                        if PurchRecptLine.FINDFIRST then begin
                            // UnoReceiptLine.UndoGRIRAccountPayable(PurchRecptLine);
                            HeinikenBCUpgradeSTP.UndoGRIRAccountPayable(PurchRecptLine); //BC Upgrade GUNREM01 added 
                        end;
                        //HEI.10<<
                    end;
                }
            }
            // group(Print)
            // {
            //     CaptionML = ENU = 'Print',
            //                 FRA = 'Imprimer';
            //     Description = 'FINXL7.00.001';
            // }
        }
        addafter("&Navigate")
        {
            action("GR/IR WriteOff Invoicing")
            {
                Caption = 'GR/IR WriteOff Invoicing';
                Image = Invoice;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    //HEI.06>>
                    if CONFIRM(Text50002, true) then begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        CreateInvoiceHeader(Rec."Buy-from Vendor No.");
                    end;
                    //HEI.06<<
                end;
            }
        }
    }

    var

        Text50002: Label 'Do you want to create GR/IR invoice?';
        //   NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NoSeries: Record "No. Series";
        grec_purcpayblesetup: Record "Purchases & Payables Setup";
        NewInvNo: Code[10];
        PurchaseHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        grec_PurchRcptLn: Record "Purch. Rcpt. Line";
        NextLineNo: Integer;
        NextLineNo1: Integer;
        WriteoffAmount: Decimal;
        NextLineNo2: Integer;
        PurchLine1: Record "Purchase Line";
        grec_Item: Record Item;
        grec_InventoryPostingSetup: Record "Inventory Posting Setup";
        DelPurchLn: Record "Purchase Line";
        Text50003: Label 'The Item - %1, is not having Inventory Posting group';
        Text50004: Label 'The Writeoff Account is not available for posting group %1 for Item - %2, against doc no - %3';
        Text50005: Label 'Knock off';
        Text50006: Label 'The purchase invoice - %1 successfully created';
        Text50007: Label 'Either there is no Item available in Posted Receipt document %1, OR it has other type except Item OR it is fully invoiced';
        PostedPurchReceiptAdditional: Record "Purch. Rcpt. Header Add FND";

    //BC Upgrade GUNREM01 >> added 
    trigger OnAfterGetRecord();
    begin
        if PostedPurchReceiptAdditional.GET(Rec."No.") then; //HEI.08
    end;
    //BC Upgrade GUNREM01 << added 
    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    if PostedPurchReceiptAdditional.GET("No.") then; //HEI.08
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModifyRecord". Please convert manually.

    //trigger OnModifyRecord() : Boolean;
    //begin
    /*
    // <<DITW15.00.00.36 DDR 17/12/2009
    CODEUNIT.RUN(CODEUNIT::"Receipt Header - Edit",Rec);
    exit(false);
    // >>DITW15.00.00.36 DDR
    */
    //end;

    procedure CreateInvoiceHeader(VendNo: Code[20]);
    begin
        //HEI.06>>
        grec_purcpayblesetup.GET;
        NewInvNo := '';
        grec_purcpayblesetup.TESTFIELD("GR IR Invoice Writeoff No. FND");
        NoSeries.GET(grec_purcpayblesetup."GR IR Invoice Writeoff No. FND");
        // NoSeriesMgt.InitSeries(NoSeries.Code, '', WORKDATE, NewInvNo, "No. Series");//BC Uprade GUNREM01
        NoSeriesMgt.AreRelated(NoSeries.Code, grec_purcpayblesetup."GR IR Invoice Writeoff No. FND");//BC Uprade GUNREM01
        if not GUIALLOWED then
            PurchaseHeader.SetHideValidationDialog(true);
        PurchaseHeader.INIT;
        PurchaseHeader.VALIDATE("Document Type", PurchaseHeader."Document Type"::Invoice);
        PurchaseHeader."No." := NewInvNo;
        PurchaseHeader.INSERT(true);
        PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.", VendNo);
        //HEI.07>>
        PurchaseHeader."No. Series" := grec_purcpayblesetup."GR IR Invoice Writeoff No. FND";
        PurchaseHeader."Posting No. Series" := grec_purcpayblesetup."Posted GRIR Inv. Wrtoff No FND";
        //HEI.07<<
        PurchaseHeader.MODIFY(true);
        CreateInvoiceLines(PurchaseHeader, Rec);
        CLEAR(Rec);
        MESSAGE(Text50006, NewInvNo);
        //HEI.06<<
    end;

    procedure CreateInvoiceLines(PurchHeader: Record "Purchase Header"; var PurchRcptHdr: Record "Purch. Rcpt. Header");
    begin
        //HEI.06>>
        if PurchRcptHdr.FINDSET then
            repeat
                grec_PurchRcptLn.RESET;
                grec_PurchRcptLn.SETRANGE("Document No.", PurchRcptHdr."No.");
                grec_PurchRcptLn.SETRANGE(Type, grec_PurchRcptLn.Type::Item);
                grec_PurchRcptLn.SETFILTER("Qty. Rcd. Not Invoiced", '<>%1', 0);
                if grec_PurchRcptLn.FINDSET then
                    repeat
                        PurchLine.LOCKTABLE;
                        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
                        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
                        PurchLine."Document Type" := PurchHeader."Document Type";
                        PurchLine."Document No." := PurchHeader."No.";
                        grec_PurchRcptLn.InsertInvLineFromRcptLine(PurchLine);
                        grec_PurchRcptLn.SETRANGE("Attached to Line No.");

                        //Insert one more line to knock off
                        PurchLine1.INIT;
                        PurchLine1."Document Type" := PurchHeader."Document Type";
                        PurchLine1."Document No." := PurchHeader."No.";

                        PurchLine1.SETRANGE(PurchLine1."Document No.", PurchHeader."No.");
                        if PurchLine1.FINDLAST then
                            NextLineNo1 := PurchLine1."Line No." + 10000
                        else
                            NextLineNo1 := 10000;
                        PurchLine1."Line No." := NextLineNo1;
                        PurchLine1.INSERT(true);
                        PurchLine1.VALIDATE("Receipt No.", '');
                        PurchLine1.VALIDATE(PurchLine1.Type, PurchLine1.Type::"G/L Account");
                        if grec_Item.GET(PurchLine."No.") then begin
                            if (grec_Item."Inventory Posting Group" <> '') then begin
                                if grec_InventoryPostingSetup.GET(PurchLine."Location Code", grec_Item."Inventory Posting Group") then begin
                                    if (grec_InventoryPostingSetup."WriteOff Account FND" <> '') then
                                        PurchLine1.VALIDATE("No.", grec_InventoryPostingSetup."WriteOff Account FND")
                                    else begin
                                        CLEAR(PurchRcptHdr);
                                        ERROR(Text50004, grec_Item."Inventory Posting Group", PurchLine."No.", grec_PurchRcptLn."Document No.");
                                    end;
                                end;
                            end else
                                ERROR(Text50003, PurchLine."No.");
                        end;
                        PurchLine1."Description 2" := Text50005;
                        PurchLine1.VALIDATE(Quantity, 1);
                        PurchLine1.VALIDATE("Direct Unit Cost", -PurchLine.Amount);
                        PurchLine1.VALIDATE("VAT %", PurchLine."VAT %");
                        PurchLine1.VALIDATE("Amount Including VAT", -PurchLine."Amount Including VAT");
                        PurchLine1.MODIFY(true);
                    //Insert one more line to knock off

                    until (grec_PurchRcptLn.NEXT = 0)
                else begin
                    ERROR(Text50007, PurchRcptHdr."No.");
                end;
            until PurchRcptHdr.NEXT = 0;
        //HEI.06<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

