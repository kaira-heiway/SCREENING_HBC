pageextension 53042 PostedReturnReceiptExt extends "Posted Return Receipt"
{
    // version NAVW110.0,DITW110.00.09,HEI.04,HEI.05

    //     DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                     21/10/2008 Deleted field2013722 Duty Tax Type
    //                                Added fields "Customer DTax Group Code" into Invoicing tab
    // DITW15.00.00.28 DDR 24/11/2008 Added fields "Fiscal Representative No."
    // DITW15.00.00.35 DDR 14/10/2009 issue 788 Added Form property DeleteAllowed = No
    //                     13/10/2009 Added "Building No." into General tab
    // DITW15.00.00.38 DDR 05/10/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added 'Unsatisfactory Comment' menu button in 'Line' button
    //                                           Added functions ShowLineUnstatisfactoryCmts()
    //                                           Added 'Send Report Receipt Request' menus in 'Functions' buttons
    //                 DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields "Journey Time"
    //                     04/08/2011 issue 1353 Remove fields "Journey Time"
    //                     19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    // DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  call function SetDisableRefreshLines() before each report
    //                                                  (don't use the <RunObject> property)

    // DITW17.00.02 DDR 19/07/2013 DIT-770 #110 Added codeunit check for EMCS UK (old DIT-715 #512)
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #110
    // DITW17.00.02 SR 10/16/2013 DIT-770 #155 : New Action "Register Shipment Entries" Added
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Added fields "Physical Location Group Code"
    // DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add Flowfield "Document Shipping Costs" to General TAB
    // DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    // DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code
    // DITW19.00.08 MSF 27/09/2016 BL #10366 (DIT-770 #1160)  EMCS (NL): 813 - request change of destination by Consignor  (Outbound + inbpound message)
    //                                                        Added Action set 813 request
    // DITW19.00.08 MSF 28/09/2016 BL #10366 (DIT-770 #1160)  EMCS (NL): 813
    //                                                        Rename "Action Send (813) Request" to "Send Change of Destination request"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field added: "Gate Entry No."
    // HEI.02 FDD RPM Breakages IBM ISYED01 03.18.2019
    //   # added new action on meanu and added code for the same.
    // HEI.35 FDD-HT658 IBM.GUNERE01 01.10.2019 # Shipping Agent Service Code field added
    //                               07.10.2019 # "Shipping Agent Service Code" editable false
    // HEI.36 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Added field "Source System Identifier"
    // HEI.03 FDD-HB1880 CHG2089830 IBM NASTAA02 23.12.2020 # Fix Invoice Creation Date
    //   # Added field "Creation Date/Time"
    // HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.05 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus


    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }

        //Unsupported feature: Change Level on ""No."(Control 2)". Please convert manually.


        //Unsupported feature: Change Level on ""Sell-to Customer No."(Control 6)". Please convert manually.


        //Unsupported feature: Change Level on ""Sell-to Contact No."(Control 87)". Please convert manually.


        //Unsupported feature: Change Level on ""Sell-to Customer Name"(Control 52)". Please convert manually.


        //Unsupported feature: Change Level on ""Sell-to Address"(Control 54)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Sell-to Address"(Control 54)". Please convert manually.


        //Unsupported feature: Change Level on ""Sell-to Address 2"(Control 56)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Sell-to Address 2"(Control 56)". Please convert manually.


        //Unsupported feature: Change Level on ""Sell-to Post Code"(Control 8)". Please convert manually.


        //Unsupported feature: Change Level on ""Sell-to City"(Control 58)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Sell-to City"(Control 58)". Please convert manually.


        //Unsupported feature: Change Level on ""Sell-to Contact"(Control 60)". Please convert manually.


        //Unsupported feature: Change Level on ""Posting Date"(Control 14)". Please convert manually.


        //Unsupported feature: Change Level on ""Document Date"(Control 27)". Please convert manually.


        //Unsupported feature: Change Level on ""Return Order No."(Control 4)". Please convert manually.


        //Unsupported feature: Change Level on ""External Document No."(Control 72)". Please convert manually.


        //Unsupported feature: Change Level on ""Salesperson Code"(Control 12)". Please convert manually.

        modify("Responsibility Center")
        {

            //Unsupported feature: Change Level on ""Responsibility Center"(Control 82)". Please convert manually.

            Importance = Additional;
        }

        //Unsupported feature: Change Level on ""No. Printed"(Control 16)". Please convert manually.

        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }

        //Unsupported feature: Change ImplicitType on ""Bill-to Address"(Control 22)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Bill-to Address 2"(Control 24)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Bill-to City"(Control 26)". Please convert manually.

        modify(Shipping)
        {
            CaptionML = ENU = 'Shipping', FRA = 'Livraison';
        }

        //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 34)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 36)". Please convert manually.


        //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 38)". Please convert manually.

        modify("Shipment Method")
        {
            CaptionML = ENU = 'Shipment Method', FRA = 'Conditions de livraison';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Agent', FRA = 'Agent';
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';
        }
        addfirst(General)
        {
            group(Control1100710909)
            {
            }
        }

        addafter("No. Printed")
        {
            group(Control1100710902)
            {
            }
        }
        // addfirst("Document Date")
        // {
        //     field("Tax Date"; Rec."Tax Date")
        //     {
        //         Editable = false;
        //     }
        // }
        // addfirst("External Document No.")
        // {
        //     field("Building No."; Rec."Building No.")
        //     {
        //         Editable = false;
        //         Importance = Additional;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field
        addafter("Responsibility Center")
        {
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Importance = Additional;
            // }
            // field("Document Shipping Costs"; Rec."Document Shipping Costs")
            // {
            // }//Bc Upgrade YADAVM09 Drink it field
            field("Gate Entry No."; Rec."Gate Entry No. FND")
            {
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }

            // field("Creation Date/Time"; Rec."Creation Date/Time")
            // {
            // }//Bc Upgrade YADAVM09 Drink it field<<
        }

        // addafter("Shortcut Dimension 2 Code")
        // {
        //     field("Customer DTax Group Code"; Rec."Customer DTax Group Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Invoice List Customer No."; Rec."Invoice List Customer No.")
        //     {
        //         Description = 'DITW17.10.05 DIT-715 #761';
        //         Editable = false;
        //     }
        // }

        // addafter("Ship-to Contact")
        // {
        //     field("Fiscal Representative No."; Rec."Fiscal Representative No.")
        //     {
        //         Editable = false;
        //     }
        //     field("Tax Office Code"; Rec."Tax Office Code")
        //     {
        //         Editable = false;
        //     }
        // }//Bc Upgrade YADAVM09 Drink it field<<
        addafter("Shipping Agent Code")
        {
            field("Shipping Agent Service Code"; Rec."Ship Agent Service Code FND")
            {
                Editable = false;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<
            }
        }
        addafter("Shipment Date")
        {
            //     field(Distance; Rec.Distance)
            //     {
            //         Editable = false;
            //     }
            //     field("Truck Code"; Rec."Truck Code")
            //     {
            //         Editable = false;
            //     }
            //     field("Driver Code"; Rec."Driver Code")
            //     {
            //         Editable = false;
            //     }
            //     field(Route; Rec.Route)
            //     {
            //         Editable = false;
            //     }
            //     field("Delivery Sequence"; Rec."Delivery Sequence")
            //     {
            //         Editable = false;
            //     }
            //     field("Shipping Charge Per"; Rec."Shipping Charge Per")
            //     {
            //         Editable = false;
            //     }
            //     field("Maximum Weight"; Rec."Maximum Weight")
            //     {
            //         Editable = false;
            //     }
            //     field("Maximum Cubage"; Rec."Maximum Cubage")
            //     {
            //         Editable = false;
            //     }
            //     field("Total Weight"; Rec."Total Weight")
            //     {
            //         Editable = false;
            //         Visible = false;
            //     }
            //     field("Total Cubage"; Rec."Total Cubage")
            //     {
            //         Editable = false;
            //         Visible = false;
            //     }//Bc Upgrade YADAVM09 Drink it field<<
            // group("Zycus Interface")
            // {
            //     Caption = 'Zycus Interface';
            //     Visible = VisibleZycusInterface;
            //     field("Zycus Order No."; Rec."Zycus Order No.")
            //     {
            //         Editable = false;
            //     }
            //     group("Zycus PO Interface")
            //     {
            //         Caption = 'Zycus PO Interface';
            //         field("PO Transaction Interface Zycus"; Rec."PO Transaction Interface Zycus")
            //         {
            //             Editable = false;
            //         }
            //         field("Processed PO Transaction Zycus"; Rec."Processed PO Transaction Zycus")
            //         {
            //             Editable = false;
            //         }
            //     }
            //     group("Zycus GR Interface")
            //     {
            //         Caption = 'Zycus GR Interface';
            //         field("Zycus GR UUID"; Rec."Zycus GR UUID")
            //         {
            //             Editable = false;
            //         }
            //         field("Zycus GR Cancel UUID"; Rec."Zycus GR Cancel UUID")
            //         {
            //             Editable = false;
            //         }
            //         field("GR Transaction Interface Zycus"; Rec."GR Transaction Interface Zycus")
            //         {
            //             Editable = false;
            //         }
            //         field("Processed GR Transaction Zycus"; Rec."Processed GR Transaction Zycus")
            //         {
            //             Editable = false;
            //         }
            //     }
            // }//Bc Upgrade YADAVM09 Added in Interface Extension page<<
        }
        moveafter("Sell-to Contact"; "No. Printed")
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
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
        }


        //Unsupported feature: CodeModification on ""&Print"(Action 49).OnAction". Please convert manually.

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
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.ReturnRcptLines.PAGE.SetDisableRefreshLines(true);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        ReturnRcptHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(ReturnRcptHeader);
        ReturnRcptHeader.PrintRecords(true);
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.ReturnRcptLines.PAGE.SetDisableRefreshLines(false);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;
        addafter(Approvals)
        {
            // action("Shipping Costs")
            // {
            //     CaptionML = ENU = 'Shipping Costs',
            //                 FRA = 'Coûts transport';
            //     Image = Costs;
            //     RunObject = Page "Posted Document Shipping Cost";
            //     RunPageLink = "Source Type" = CONST(6660),
            //                   "Source No." = FIELD("No.");
            // }//Bc Upgrade YADAVM09 Drink it Action<<
            action("Posted Customer Diff (RPM) CBN")
            {
                Caption = 'Posted Customer Diff (RPM)';
                Image = PostedReceipt;
                ApplicationArea = All;//Bc Upgrade YADAVM09<<

                trigger OnAction();
                var
                    PostedCustomerDiffRPMRec: Record "Posted Customer Diff RPM FND";
                    PostedCustomerDiffRPMPage: Page "Posted Customer Diff (RPM) CBN";
                begin
                    //HEI.02>>
                    PostedCustomerDiffRPMRec.RESET;
                    PostedCustomerDiffRPMRec.SETFILTER("Sales return order no.", Rec."Return Order No.");
                    if PostedCustomerDiffRPMRec.FINDSET then begin
                    end
                    else
                        if PostedCustomerDiffRPMRec.ISEMPTY then begin
                            PostedCustomerDiffRPMRec.SETFILTER("Sales return order no.", '');
                            if PostedCustomerDiffRPMRec.FINDSET then begin
                            end
                        end;

                    PostedCustomerDiffRPMPage.SETTABLEVIEW(PostedCustomerDiffRPMRec);
                    PostedCustomerDiffRPMPage.SETRECORD(PostedCustomerDiffRPMRec);
                    PostedCustomerDiffRPMPage.RUN;
                    //HEI.02<<
                end;
            }
        }
        // addfirst(ActionContainer1900000004)
        // {
        //     group("F&unctions")
        //     {
        //         CaptionML = ENU = 'F&unctions',
        //                     FRA = 'Fonction&s';
        //         separator(Separator1100083326)
        //         {
        //         }
        //         action("Send Report Receipt Request")
        //         {
        //             CaptionML = ENU = 'Send Report Receipt Request',
        //                         FRA = 'Envoyer le rapport requête recéption';
        //             Image = SendElectronicDocument;

        //             trigger OnAction();
        //             var
        //                 EMCSExport: Codeunit "EMCS EDI-IE818 Outbox";
        //             begin
        //                 // <<DITW15.00.00.38 DDR 05/10/2010
        //                 // <<DITW17.00.02 DDR 18/07/2013 DIT-770 #101
        //                 //<<DITW17.00.02 DDR 28/08/2013 DIT-770 #178
        //                 EMCSExport.CreateOutboxReturnReceipt(Rec);
        //                 //>>DITW17.00.02 DDR 28/08/2013 DIT-770 #178
        //                 // >>DITW17.00.02 DDR DIT-770 #101
        //                 // >>DITW15.00.00.38 DDR
        //             end;
        //         }
        //     action("Send Change of Destination request")
        //     {
        //         CaptionML = ENU = 'Send Change of Destination request',
        //                     FRA = 'Envoyer demande changement de destination';
        //         Description = 'HIT0668.1-HIT0668.2';
        //         Image = SendElectronicDocument;

        //         trigger OnAction();
        //         var
        //             EMCSExport: Codeunit "EMCS EDI-IE813 Outbox";
        //         begin
        //             //<<HIT0668.1 MSF 27/09/2016 PND-NL-999-FY16 #59
        //             EMCSExport.CreateOutboxReturnReceipt(Rec);
        //         end;
        //     }
        // }
        //}//BC Upgrade YADAVM09 Drink it ACtion<<
    }

    var
        VisibleZycusInterface: Boolean;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    var
    //ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";//Bc Upgrade YADAVM09 Interface object<<
    //begin
    /*
    //HEI.04>>
    if ZycusInterfaceSetupL.GET and ZycusInterfaceSetupL."Enabled Zycus Integration" then
      VisibleZycusInterface := true;
    //HEI.04<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyDeletion. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

