pageextension 52029 PostedReturnShipmentExt extends "Posted Return Shipment"
{
    // version NAVW110.0,DITW110.00.09,HEI.05,HEI.06

    //     DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                     21/10/2008 Deleted field2013722 Duty Tax Type
    //                                Added fields "Vendor DTax Group Code" into Invoicing tab
    // DITW15.00.00.28 DDR 24/11/2008 Added fields "Fiscal Representative No."
    //                                Converted Print Button to MenuButton
    //                                Added menu "AAD Document" into Print Button
    // DITW15.00.00.34 DDR 05/06/2009 Added menu "Shipment (invoice)" into Print Button
    // DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    // DITW15.00.00.38 DDR 30/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added 'Submit e-AAD Request' menu 'Functions' button
    //                     08/10/2010            Added 'Send e-Cancelling Request' menu 'Functions' button
    //                 DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields "Journey Time"
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab

    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added 'Shipping Agent' tab
    //                                           Added fields (Shipping Agent tab)
    //                                             "Shipping Agent Code","Shipping Agent Service Code"
    //                                             "Truck Code","Driver Code","Distance","Delivery Sequence"
    //                                             "Shipment Method Code"
    //                     22/12/2011 DIT-715 issue 187 Added 'Comments - Transport Mode' menu into 'Return Shipment' button
    //                                                  Added fields into 'Foreign Trade' tab
    //                                                    "Transport Mode","Transport Mode Comment"
    //                                                  Added 'Cancellation Reason Comment' menu into 'Line' button
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  call function SetDisableRefreshLines() before each report
    //                                                  (don't use the <RunObject> property)
    // DITW16.00.00.43 DDR 23/08/2013 DIT-715 #720 Added 'AAD Document (EMCS)' menu into 'Print' button

    // DITW17.00.02 DDR 19/07/2013 DIT-770 #110 Added codeunit check for EMCS UK (old DIT-715 #512)
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #110
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Physical Location Group Code"
    // DITW18.00.07 MVN 24/02/2016 DIT-770 #1397 Added Field 2014300 "Submission Type" (Shipping)
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB
    // DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 03/02/2017 NRQ#20678 hide 'Return Shipment (invoice)' print button as no longer used
    // DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields

    // HEI.01 HLSRM02-05 IBM LAZARE02 31.07.2017
    //   #New fields for SRM integration added to SRM tab
    // HEI.02 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field added: "Gate Entry No."
    // HEI.03 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Created new Page Action "Purchase Additional"
    // HEI.04 CHG2024557 FDD-HT821 IBM SHANKJ03
    //   # Created new field "Maximo Status"
    // HEI.05 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.06 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus

    //Bc upgrade YADAVM09 Drink it field and action Blocked.
    //Bc Upgrade YADAVM09 interface fields added in interface extension.


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        //Bc Upgrade YADAVM09>>
        modify("Buy-from Address")
        {
            Editable = false;
        }

        modify("Buy-from Address 2")
        {
            Editable = false;
        }
        modify("Buy-from City")
        {
            Editable = false;
        }
        modify("Pay-to Address")
        {
            Editable = false;
        }
        modify("Pay-to Address 2")
        {
            Editable = false;
        }
        modify("Pay-to City")
        {
            Editable = false;
        }
        modify("Ship-to Address")
        {
            Editable = false;
        }
        modify("Ship-to Address 2")
        {
            Editable = false;
        }
        modify("Ship-to City")
        {
            Editable = false;
        }

        //Bc Upgrade YADAVM09<<

        //Unsupported feature: Change ImplicitType on ""Buy-from Address"(Control 53)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Buy-from Address 2"(Control 55)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Buy-from City"(Control 57)". Please convert manually.

        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }

        //Unsupported feature: Change ImplicitType on ""Pay-to Address"(Control 26)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Pay-to Address 2"(Control 28)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Pay-to City"(Control 30)". Please convert manually.

        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }

        //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 36)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 38)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 40)". Please convert manually.

        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }

        // addafter("Document Date")
        // {
        //     field("Tax Date"; Rec."Tax Date")
        //     {
        //         Editable = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        addafter("No. Printed")
        {
            // field("Document Shipping Costs"; Rec."Document Shipping Costs")
            // {
            // } //Bc Upgrade YADAVM09 Drink it field<<
            field("Gate Entry No."; Rec."Gate Entry No. FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
            // field("Maximo Status"; Rec."Maximo Status")
            // {
            //     ApplicationArea = All;//Bc Upgrade YADAVM09<<
            // }//Bc Upgrade YADAVM09 fields added in interface Extension<<
        }

        // addafter("Applies-to Doc. No.")
        // {
        //     field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
        //     {
        //         Editable = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<

        // addafter("Ship-to Contact")
        // {
        //     field("Physical Location Group Code"; Rec."Physical Location Group Code")
        //     {
        //         Editable = false;
        //         Importance = Additional;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        // addafter("Location Code")
        // {
        //     field("Truck Code"; rec."Truck Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Driver Code"; Rec."Driver Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Fiscal Representative No."; Rec."Fiscal Representative No.")
        //     {
        //         Editable = false;
        //     }
        //     field("Tax Office Code"; Rec."Tax Office Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Journey Time"; Rec."Journey Time")
        //     {
        //         Editable = false;
        //     }
        //     field("Transport Mode"; Rec."Transport Mode")
        //     {
        //         Description = 'DIT715 #187';
        //     }
        //     field("Submission Type"; Rec."Submission Type")
        //     {
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        addafter("Foreign Trade")
        {
            group("Shipping Agent")
            {
                CaptionML = ENU = 'Shipping Agent',
                            FRA = 'Transporteur';
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Editable = false;
                    ApplicationArea = All;//Bc Upgrade YADAVM09<<
                }
                // field("Shipping Agent Code"; Rec."Shipping Agent Code")
                // {
                //     Editable = false;
                // }
                // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                // {
                //     Editable = false;
                // }
                // field(Distance; Rec.Distance)
                // {
                //     Editable = false;
                // }
                // field("Truck Code2"; Rec."Truck Code")
                // {
                //     Editable = false;
                // }
                // field("Driver Code2"; Rec."Driver Code")
                // {
                //     Editable = false;
                // }
                // field("Delivery Sequence"; Rec."Delivery Sequence")
                // {
                //     Editable = false;
                // }//Bc Upgrade YADAVM09 Drink it field<<
            }
            // group(SRM)
            // {
            //     Caption = 'SRM';
            //     field("SRM Contract No."; Rec."SRM Contract No.")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field("SRM Contract Name"; Rec."SRM Contract Name")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field("SRM Contract Type"; Rec."SRM Contract Type")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field("Valid From"; Rec."Valid From")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field("Valid To"; Rec."Valid To")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field(Channel; Rec.Channel)
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field("Shipment Method Location"; Rec."Shipment Method Location")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field("Contract Closed"; Rec."Contract Closed")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field("SRM Order No."; Rec."SRM Order No.")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field("Target Value Currency"; Rec."Target Value Currency")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     field("Target Value Amount"; Rec."Target Value Amount")
            //     {
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            // }//Bc Upgrade YADAVM09 fields added in interface extension<<
            // group("Zycus Interface")
            // {
            //     Caption = 'Zycus Interface';
            //     Visible = VisibleZycusInterface;
            //     field("Zycus Order No."; Rec."Zycus Order No.")
            //     {
            //         Editable = false;
            //         ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //     }
            //     group("Zycus PO Interface")
            //     {
            //         Caption = 'Zycus PO Interface';
            //         field("PO Transaction Interface Zycus"; Rec."PO Transaction Interface Zycus")
            //         {
            //             Editable = false;
            //             ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //         }
            //         field("Processed PO Transaction Zycus"; Rec."Processed PO Transaction Zycus")
            //         {
            //             Editable = false;
            //             ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //         }
            //     }
            //     group("Zycus GR Interface")
            //     {
            //         Caption = 'Zycus GR Interface';
            //         field("Zycus GR UUID"; Rec."Zycus GR UUID")
            //         {
            //             Editable = false;
            //             ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //         }
            //         field("Zycus GR Cancel UUID"; Rec."Zycus GR Cancel UUID")
            //         {
            //             Editable = false;
            //             ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //         }
            //         field("GR Transaction Interface Zycus"; Rec."GR Transaction Interface Zycus")
            //         {
            //             Editable = false;
            //             ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //         }
            //         field("Processed GR Transaction Zycus"; Rec."Processed GR Transaction Zycus")
            //         {
            //             Editable = false;
            //             ApplicationArea = All;//Bc Upgrade YADAVM09<<
            //         }
            //     }
            // }
        }
    }
    actions
    {
        modify("&Return Shpt.")
        {
            CaptionML = ENU = '&Return Shpt.', FRA = 'E&xpéd. retour';
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
        modify(CertificateOfSupplyDetails)
        {
            CaptionML = ENU = 'Certificate of Supply Details', FRA = 'Détails certificat d''approvisionnement';
        }


        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
        }


        //Unsupported feature: PropertyDeletion on "PrintCertificateofSupply(Action 82)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "PrintCertificateofSupply(Action 82)". Please convert manually.

        modify("&Print")
        {
            Visible = false;
        }

        //Unsupported feature: PropertyDeletion on ""&Print"(Action 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Print"(Action 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Print"(Action 48)". Please convert manually.

        // addafter("Co&mments")
        // {
        //     action("Comments - Transport Mode")
        //     {
        //         CaptionML = ENU = 'Comments - Transport Mode',
        //                     FRA = 'Commantaires - Mode de transport';
        //         Description = 'DIT715 #187';
        //         Image = ViewComments;
        //         RunObject = Page "EMCS Comment Sheet";
        //         RunPageLink = "Table ID" = CONST(6650),
        //                       "Document Type" = CONST(0),
        //                       "Document No." = FIELD("No."),
        //                       "Document Line No." = CONST(0),
        //                       "Field ID" = CONST(2014277);
        //     }
        // }//Bc Upgrade YADAVM09 Drink it action<<
        // addafter(CertificateOfSupplyDetails)
        // {
        //     action(PrintCertificateofSupply)
        //     {
        //         Caption = 'Print Certificate of Supply';
        //         Image = PrintReport;
        //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         //PromotedCategory = Process;

        //         trigger OnAction();
        //         var
        //             CertificateOfSupply: Record "Certificate of Supply";
        //         begin
        //             CertificateOfSupply.SETRANGE("Document Type", CertificateOfSupply."Document Type"::"Return Shipment");
        //             CertificateOfSupply.SETRANGE("Document No.", Rec."No.");
        //             CertificateOfSupply.Print;
        //         end;
        //     }//Bc Upgrade YADAVM09 SAction already exist in base page<<
        // action("Shipping Costs")
        // {
        //     CaptionML = ENU = 'Shipping Costs',
        //                 FRA = 'Coûts transport';
        //     Image = Costs;
        //     RunObject = Page "Posted Document Shipping Cost";
        //     RunPageLink = "Source Type" = CONST(6650),
        //                   "Source No." = FIELD("No.");
        // }//Bc Upgrade YADAVM09 dependency on drink it page<<
        //     action("Purchase Additional")
        //     {
        //         Caption = 'Purchase Additional';
        //         Image = Purchase;
        //         RunObject = Page "Sales Shipment Additional";
        //         RunPageLink = "No." = FIELD("No.");
        //     }//Bc Upgrade YADAVM09 dependency on drink it page<<
        //}
        // addfirst(PrintCertificateofSupply)
        // {
        //     separator(Separator1100083016)
        //     {
        //     }
        //     action("Send e-AAD Request")
        //     {
        //         CaptionML = ENU = 'Send e-AAD Request',
        //                     FRA = 'Envoyer requête e-DAA';
        //         Image = SendElectronicDocument;

        //         trigger OnAction();
        //         var
        //             EMCSExport: Codeunit "EMCS EDI-IE815 Outbox";
        //         begin
        //             // <<DITW15.00.00.38 DDR 03/09/2010 #1217
        //             // <<DITW17.00.02 DDR 18/07/2013 DIT-770 #101
        //             //<<DITW17.00.02 DDR 28/08/2013 DIT-770 #178
        //             EMCSExport.CreateOutboxReturnShipment(Rec);
        //             //>>DITW17.00.02 DDR 28/08/2013 DIT-770 #178
        //             // >>DITW17.00.02 DDR DIT-770 #101
        //             // >>DITW15.00.00.38 DDR
        //         end;
        //     }
        //     action("Send e-Cancelling Request")
        //     {
        //         CaptionML = ENU = 'Send e-Cancelling Request',
        //                     FRA = 'Envoyer e-Annulation requête';
        //         Image = SendElectronicDocument;

        //         trigger OnAction();
        //         var
        //             EMCSExport: Codeunit "EMCS EDI-IE810 Outbox";
        //         begin
        //             // <<DITW15.00.00.38 DDR 08/10/2010 #1217
        //             // <<DITW17.00.02 DDR 18/07/2013 DIT-770 #101
        //             //<<DITW17.00.02 DDR 28/08/2013 DIT-770 #178
        //             if EMCSExport.CheckReturnShipmentUndo(Rec) then
        //                 EMCSExport.CreateOutboxReturnShipment(Rec);
        //             //>>DITW17.00.02 DDR 28/08/2013 DIT-770 #178
        //             // >>DITW17.00.02 DDR DIT-770 #101
        //             // >>DITW15.00.00.38 DDR
        //         end;
        //     }

        // }//Bc Upgrade YADAVM09 drink it Action<<
        // addfirst("&Print")
        // {
        //     action("&Return Shipment")
        //     {
        //         CaptionML = ENU = '&Return Shipment',
        //                     FRA = 'E&xpédition retour';
        //         Ellipsis = true;
        //         Image = Print;

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.ReturnShptLines.PAGE.SetDisableRefreshLines(true);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //             //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        //             ReturnShptHeader := Rec;
        //             //>> DITW18.00.07 AKH DIT-770 #1508
        //             CurrPage.SETSELECTIONFILTER(ReturnShptHeader);
        //             ReturnShptHeader.PrintRecords(true);
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.ReturnShptLines.PAGE.SetDisableRefreshLines(false);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //         end;
        //     }
        //     action("Return Shipment (&Invoice)")
        //     {
        //         CaptionML = ENU = 'Return Shipment (&Invoice)',
        //                     FRA = 'Expédition Retour (&Facture)';
        //         Description = 'NRQ#20678';
        //         Enabled = false;
        //         Image = Print;
        //         Visible = false;

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.ReturnShptLines.PAGE.SetDisableRefreshLines(true);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //             // <<DITW15.00.00.34 DDR 05/06/2009
        //             DocPrint.PrintReturnShptHeaderInv(Rec, false);
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.ReturnShptLines.PAGE.SetDisableRefreshLines(false);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //         end;
        //     }
        //     action("&AAD Document")
        //     {
        //         CaptionML = ENU = '&AAD Document',
        //                     FRA = 'Document D&AA';
        //         Image = Print;

        //         trigger OnAction();
        //         begin
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.ReturnShptLines.PAGE.SetDisableRefreshLines(true);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //             // <<DITW15.00.00.28 DDR 26/11/2008
        //             DocPrint.PrintReturnShptHeaderAAD(Rec, false);
        //             // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        //             CurrPage.ReturnShptLines.PAGE.SetDisableRefreshLines(false);
        //             // >>DITW16.00.00.40 DDR DIT-715 #197
        //         end;
        //     }
        //}//Bc Upgrade YADAVM09 Drink it action<<

    }

    var
        DocPrint: Codeunit "Document-Print";
        // EdiDataSetup: Record "EDI Data Setup";//Bc Upgrade YADAVM09 Drink it object<<
        VisibleZycusInterface: Boolean;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    var
    // ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";//Bc upgrade YADAVM09 Added in interface extension<<
    //begin
    /*
    //HEI.05>>
    if ZycusInterfaceSetupL.GET and ZycusInterfaceSetupL."Enabled Zycus Integration" then
      VisibleZycusInterface := true;
    //HEI.05<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

