
pageextension 53024 SalesReturnOrderExt extends "Sales Return Order"
{
    // version NAVW110.0.00.16585,DITW110.00.11,HEI.18
    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    //   DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //   DITW15.00.00.01 DDR 17/01/2008 some Captions
    //                                  New calling functions to insert (item) charges
    //   DITW15.00.00.01 DDR 21/01/2008 Remove unused textconst
    //   DITW15.00.00.01 DDR 27/02/2008 Drink-it Return Deposit functionnalities
    //                                  Added menu "&Orders" into "Ret.Order" button
    //                                  Added field "Link Sales Document Type","Link Sales Document No." into general tab
    //   DITW15.00.00.01 DDR 11/03/2008 Hide "Link Sales Document Type" when no link document
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    //   DITW15.00.00.25 DDR 16/10/2008 Added "Truck Code","Driver Code" into "Shipping" tab
    //                       21/10/2008 Deleted field2013722 Duty Tax Type
    //                                  Added fields "Customer DTax Group Code" into Invoicing tab
    //   DITW15.00.00.28 DDR 24/11/2008 Added "Fiscal Representative No." into Shipping tab
    //                       02/12/2008 Added "Shipping Agent" tab + fields
    //                                  Added function FormatMaximumControls()
    //                       19/12/2008 Added field "Ship-to Code" into Shipping tab
    //   DITW15.00.00.33 DDR 07/05/2009 Move field "Customer DTax Group Code" into 'General' tab
    //   DITW15.00.00.34 DDR 16/06/2009 Added auto-release document into menu 'Create Whse. shipment'
    //                       17/06/2009 Added shortcut key CTRL+F10 to switch status 'open' the current document
    //                                  Changed Editable "Status" field
    //                                  Added functions DocStatusRelease(),DocStatusOpen(),
    //   DITW15.00.00.36 DDR 07/12/2009 issue 981 Bugfix Save/Refresh before release function
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   CEL 13/08/2010           Modification RTC buttons
    //   DITW15.00.00.38 DDR 30/09/2010 issue 1217 Added 'Get EMCS ARC No. to Apply' menu into 'Functions' menu
    //                   DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                    Added menu 'SSCC Tracking Lines' in 'Line' buttton
    //                   DDR 27/01/2011 issue 1217 (DIT711 137) Added fields "Tax Office Code" into 'Shipping' tab
    //   DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                             Added parameter line function RTCActionNewLine() into RTCNewLine button
    //   DITW15.00.00.39 DDR 10/05/2011 issue 1330 Upgrade editable Status to work with Approval requests
    //                                             Remove 'ShowConfirmMsg' parameter function DocStatusOpen();
    //                                             Modified functions DocStatusOpen(),DocStatusRelease()
    //                                             Modified validate trigger field "Status"
    //                       27/07/2011 issue 1407 Added flowfields "Disc.Promo. Order Calculated" (see "Zoom view)
    //                                             Moved/Deleted functions into codeunit414 Release Sales Document
    //                                               DocStatusRelease(),DocStatusOpen()
    //   DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                                Added to insert first line automatically
    //                       19/08/2011 issue 1363 Added fields "Tax Date" into 'General' tab
    //   DITW16.00.00.40 DDR 11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                    call function SetDisableRefreshLines() before each report
    //                                                    (don't use the <RunObject> property)
    //   DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392 Added 'Service/Contract' tab
    //                                               Added fields into 'Service/Contract' tab
    //                                                 "DIT Sub-Contract Type","Contract Group Code","Service Contract No."
    //                                               Moved "Building No." into 'Service/Contract' tab

    //   FINXL7.00.001 KLU 25/09/2013 : Added actions for approve/reject (same functionality as approval entries form)
    //   DITW17.00.02 AT  12/09/2013 DIT-770 #154
    //                               Repositioned Shipment Method before Shipping Agent
    //                               Added fields
    //                               2014094 Sell-to Invoice Method
    //                               2014095 Sell-to Invoice Period
    //                               2014096 Picking Type
    //   DITW17.00.02 SR 10/16/2013 DIT-770 #155 : New Action "Change Shipping status" Added
    //                                           : Change the Editable Propert False in "Shipment status" field.
    //                                           : New Action "Register Shipment Entries" Added
    //   DITW17.00.02 SR 10/25/2013 DIT-770 #159 : New Field Added in General Tab
    //   DITW17.00.02 AT  14/11/2013 DIT-770 #154
    //                               Added fields
    //                               2014110 Delivery Time 1 From
    //                               2014111 Delivery Time 1 To
    //                               2014112 Delivery Time 2 From
    //                               2014113 Delivery Time 2 To
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW18.00.06 DDR 19/02/2015 DIT-770 #1190 Multisite - Added fields "Physical Location Group Code"
    //   DITW18.00.06 DDR 25/02/2015 DIT-770 #1190 Multisite - Modified Resp. Center Filter OnOpenPage trigger
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.05 DDR 07/10/2014 DIT-770 #935 Editable "Building No."
    //   DITW17.10.04 AKH 24/11/2014 DIT-770 #1001 Added Action "Print and Mail"
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 14/05/2015 DIT-770 #1035 Added field "Trailer Code"
    //   DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214 Added Drill Down to field route
    //   DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Filter on "Resp. Center Table Filter 2"
    //   DITW18.00.06 MSF 09/07/2015 DIT-770 1421 Make Field Status Not editable in page 43 , 44 and 6630 like Std
    //   DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                             Rename Field Service contract Type => Contract Type
    //   DITW19.00.07 MVN 25/01/2016 DIT-770 #1740: DISABLED Approval
    //   DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Sundry Customer
    //   DITW18.00.07 VSC 10/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    //   DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 Add HasDocumentShippingCosts to General TAB
    //   DITW18.00.07 WSA 23/03/2016 DIT-770 #1723 Added Field Invoice List Customer No.
    //   DITW18.00.07 AKH 28/03/2016 DIT-770 #1409 Added "ShowMandatory" property for "External Document No." field
    //   DITW18.00.07 AKH 30/03/2016 DIT-770 #1409 Adjustment
    //   DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    //   DITW18.00.07 AKH 09/05/2016 DIT-770 #1804 Adjustment
    //   DITW18.00.07 AKH 13/05/2016 DIT-770 #1409 Restored standard code for check on "External Document No."
    //   DITW18.00.07 VSC 28/06/2016 DIT-770 #1282 Added Fields "Creation Date/Time","Created By" Importance Additional
    //   DITW18.00.07 VSC 01/07/2016 DIT-770 #1282 Set fields to visible "Creation Date/Time","Created By"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   DITW110.00.09 DDR 20/04/2017 NRQ#13107 Add all country code fields
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   DITW110.00.10 MSF 07/07/2017 NRQ#16224 Return Registration part 3
    //                                Added Action Returned Items
    //                                             Suggest Return Item
    //   DITW110.00.10 MSF 14/07/2017 NRQ#16224 Added fields : Several Adjustment
    //   DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added fields  Multiple Route Order
    //                                Editable Field IF not Multiple Route ORder
    //   DITW110.00.11 MSF 30/11/2017 NRQ#16082 Remove Condition EditableMultipleRouteOrder  on SOme fields
    //   HEI.01 FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
    //     # Code added on OnOpenPage, OnNewRecord, OnInsertRecord
    //   HEI.02 FDD-AL-GAPLOG05 IBM NASTAA02 29.09.2017 # Unloading Note template for Algeria
    //     # New Action Button created to print the Unloading Note
    //   HEI.03 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
    //     # Code added on Post Action
    //   HEI.04 FDD-KDD0TC005 IBM NASTAA02 09.11.2017 # RPM Billing and Reporting
    //     # New page action created to run the report RPM Balance Accounting
    //   HEI.06 INC2109750 IBM NASTAA02 16.04.2019 # Promotion Group Dimensions
    //     # New function created "UpdateFreeReasonCodeDimensions" to update the Free Reason Code Dimension for Group Promotions
    //   DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                                 Added Field "Disable DIT Disc. Prom."
    //   HEI.07 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    //   HEI.08 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //     # New Field added: "Suppress POS Interface"
    //     # Code added to enable editing of Field "Supress POS Interface"
    //   HEI.10 FDD-HT88 IBM BULIMC01 26/11/2019
    //       #changes for action "Customer Differences (RPM)" : moved to Actions tab - Functions, visibility property changed to YES
    //   DITW111.00.13A DDR 01/07/2019 NRQ#103938 Added visibility for Action Send Approval
    //   FINXL11.00 HBA 03/05/2018 NRQ#69018 : Added Action "Auto. Send IC Return Order"
    //   HEI.11 CHG2046145 IBM.COSTES02 20.02.2020 # Sales Order Status Addition
    //     # Mew field added : 50051 - "Approval Status"
    //   HEI.12 CHG2053242 HB1215 IBM GAVANM01 31.03.2020 Sales Order fixes
    //     # the field Shipment Date appears twice. Remove it from Shipping and Billing tab
    //   FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    //   HEI.13 CHG2065153 IBM KUMARN15 23.06.2020
    //     # Added field "Source System Identifier"
    //   HEI.14 CHG2062340 HB1378 IBM GAVANM01 29.07.2020 #Retrofitting the Brewco Æ Sellco
    //     # for the action "Auto Send IC Return Order": delete Visible property, add Enabled property
    //   HEI.15 CHG2073467 HB1369 IBM GAVANM01 17.08.2020  Enhancements to the Intercompany automation functionality
    //     # new field added: IC Order No.
    //     # hide action "Send IC Return Order Cnfmn."
    //     # Properties changed for action Auto. Send IC Return Order: Promoted=yes, PromotedCategory=Process, PromotedIsBig=yes
    //   HEI.16 CHG2073468 HB1369 IBM GAVANM01 04.01.2021 Enhancements to Intercompany Part 3
    //     # New field added, Special Order
    //   HEI.17 FDD-HB899 - CHG2093015 IBM NASTAA02  19.01.2021 # LSR - Sales And Payments
    //     # Code added on "Create &Whse. Receipt" Action
    //   HEI.18 CHG2165967 DEBUSD01 26.10.2022 HL block tax and VAT modification in sales order
    //     # change editable field "Customer DTax Group Code", "VAT Bus. Posting Group"

    //*******************************************//
    //BC UPGRADE SIVA 20/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 Logic is depend on Drink IT fields hence code is commented.
    //2.HEI.02 No changes
    //3.HEI.03 Added prodcedure InsertFAGLJnlLinesForRPMDamageLooss(Rec) on after post action 
    //4.HEI.06 Added Prodcedure UpdateFreeReasonCodeDimensions on after release action.
    //5.HEI.07 & HEI.08 Moved interface fields to interface app.
    //6.HEI.10 Moved  InsertRPMCustomerDifferences procedure from Customer Differences (RPM) action  General app CU Heineken Global to MTC app CUHeineken BC Upgrade MTC  .
    //7.HEI.11 Added new field.
    //8.HEI.12 Commented Logic due to depend on drink it field(Item Charge Type"::Promotion F2013695).
    //9.HEI.13 Added Source System Identifier field.
    //10.HEI.14 Commented Action "Auto Send IC Return Order" due to Drink it code.
    //11.HEI.15 IC Order No. added and hide action "Send IC Return Order Cnfmn.
    //12.HEI.16 Commented field due to Ethiopia Intercompany Automation.
    //13.HEI.17 Commented Drinkt IT code Create &Whse. Receipt on action, action will work as standard application.
    //14.HEI.18 Commenented Drink it field (Customer DTax Group Code), Commeneted Field VAT Bus. Posting Group because standard app already there.   
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Sell-to Customer Name")
        {
            CaptionML = ENU = 'Customer', FRA = 'Client';
            //BC UPGRADE KUMARR78 ++ 08-04-2026
            trigger OnBeforeValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.Get(Rec."Sell-to Customer No.") then begin
                    if Rec."Document Type" in [Rec."Document Type"::"Return Order"] then begin
                        CustomerRec.TestField("Avail.for Sales/ReturnOrd. FND", true);
                    end;
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::"Return Order" then begin
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);
                    if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then
                        Rec.Validate("Sell-to Customer No.", CustomerRec."No.");
                    CurrPage.Update();
                end;

            end;

            trigger OnDrillDown()
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::"Return Order" then
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);

                if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then begin
                    Rec.Validate("Sell-to Customer No.", CustomerRec."No.");
                end;
                CurrPage.Update();
            end;

        }
        //BC UPGRADE KUMARR78 ++ General Work 08-04-2026
        //BC UPGRADE KUMARR78 ++ General Work 08-04-2026
        modify("Sell-to Customer No.")
        {
            trigger OnBeforeValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.Get(Rec."Sell-to Customer No.") then begin
                    if Rec."Document Type" in [Rec."Document Type"::"Return Order"] then begin
                        CustomerRec.TestField("Avail.for Sales/ReturnOrd. FND", true);
                    end;
                end;
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::"Return Order" then begin
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);
                    if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then
                        Rec.Validate("Sell-to Customer Name", CustomerRec.Name);
                    CurrPage.Update();
                end;
            end;

            trigger OnDrillDown()
            var
                CustomerRec: Record Customer;
            begin
                CustomerRec.Reset();
                if Rec."Document Type" = Rec."Document Type"::"Return Order" then
                    CustomerRec.SetRange("Avail.for Sales/ReturnOrd. FND", true);

                if Page.RunModal(Page::"Customer Lookup", CustomerRec) = Action::LookupOK then begin
                    Rec.Validate("Sell-to Customer Name", CustomerRec.Name);
                end;
                CurrPage.Update();
            end;
        }
        //BC UPGRADE KUMARR78 ++08-04-2026
        modify("Sell-to")
        {
            CaptionML = ENU = 'Sell-to', FRA = 'Donneur d''ordre';
        }
        modify("Sell-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change ImplicitType on ""Sell-to Address"(Control 65)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Sell-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Sell-to Address 2"(Control 67)". Please convert manually.

            QuickEntry = FALSE;
        }
        modify("Sell-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
            QuickEntry = FALSE;
        }
        modify("Sell-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Sell-to City"(Control 69)". Please convert manually.

        }
        // BC Upgrade SHUKLP03 >> Added on page
        addafter(Status)
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Created Date/Time';
            }
            field(SystemCreatedBy; Rec.SystemCreatedBy)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Created By';
            }
        }
        moveafter("Order Date"; "Route 107FDW")
        moveafter("Route 107FDW"; "Route Planning No. 107FDW")
        // BC Upgrade SHUKLP03 << Added on page

        modify("Sell-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            QuickEntry = FALSE;
        }
        modify("Sell-to Contact")
        {

            //Unsupported feature: Change Level on ""Sell-to Contact"(Control 8)". Please convert manually.

            CaptionML = ENU = 'Contact', FRA = 'Contact';
            Importance = Additional;
            QuickEntry = FALSE;
        }
        modify("Document Date")
        {

            //Unsupported feature: Change Level on ""Document Date"(Control 39)". Please convert manually.

            Importance = Additional;
        }

        //Unsupported feature: Change Level on ""Posting Date"(Control 12)". Please convert manually.


        //Unsupported feature: Change Description on ""Posting Date"(Control 12)". Please convert manually.


        //Unsupported feature: Change Level on ""Order Date"(Control 125)". Please convert manually.

        modify("External Document No.")
        {

            //Unsupported feature: Change Level on ""External Document No."(Control 58)". Please convert manually.

            ShowMandatory = ExternalDocNoMandatory;
            QuickEntry = FALSE;
        }
        modify("No. of Archived Versions")
        {

            //Unsupported feature: Change Level on ""No. of Archived Versions"(Control 147)". Please convert manually.

            Importance = Additional;
        }
        modify("Salesperson Code")
        {

            //Unsupported feature: Change Level on ""Salesperson Code"(Control 10)". Please convert manually.

            Importance = Additional;
        }
        modify("Campaign No.")
        {
            Importance = Promoted;
        }
        modify("Responsibility Center")
        {

            //Unsupported feature: Change Level on ""Responsibility Center"(Control 107)". Please convert manually.

            Importance = Additional;
            QuickEntry = FALSE;
        }
        modify("Assigned User ID")
        {

            //Unsupported feature: Change Level on ""Assigned User ID"(Control 141)". Please convert manually.

            Importance = Additional;
            QuickEntry = FALSE;
        }

        //Unsupported feature: Change Level on ""Job Queue Status"(Control 5)". Please convert manually.


        //Unsupported feature: Change Level on "Status(Control 110)". Please convert manually.


        //Unsupported feature: Change Description on "Status(Control 110)". Please convert manually.

        modify("Invoice Details")
        {
            CaptionML = ENU = 'Invoice Details', FRA = 'Détails facture';
        }

        //Unsupported feature: Change Editable on ""VAT Bus. Posting Group"(Control 137)". Please convert manually.

        modify("Shipping and Billing")
        {
            CaptionML = ENU = 'Shipping and Billing', FRA = 'Expédition et facturation';
        }
        modify("Shipment Method")
        {
            CaptionML = ENU = 'Shipment Method', FRA = 'Conditions de livraison';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Agent', FRA = 'Agent';
            ToolTipML = ENU = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Agent Service', FRA = 'Service agent';
            ToolTipML = ENU = 'Specifies which shipping agent service is used to transport the items on the sales document to the customer.', FRA = 'Spécifie le transporteur utilisé pour expédier au client les articles figurant sur le document vente.';
        }
        modify("Package Tracking No.")
        {
            ToolTipML = ENU = 'Specifies the shipping agent''s package number.', FRA = 'Spécifie le numéro récépissé du transporteur.';
        }

        modify("Ship-to")
        {
            CaptionML = ENU = 'Ship-to', FRA = 'Destinataire';
        }

        //Unsupported feature: Change Name on ""Ship-to"(Control 18)". Please convert manually.


        modify("Location Code")
        {
            CaptionML = ENU = 'Location', FRA = 'Emplacement';
        }
        modify("Ship-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Ship-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address"(Control 34)". Please convert manually.

        }
        modify("Ship-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Ship-to Address 2"(Control 36)". Please convert manually.

        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Ship-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Ship-to City"(Control 38)". Please convert manually.

        }
        modify("Ship-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Bill-to")
        {
            CaptionML = ENU = 'Bill-to', FRA = 'Facturation';
        }
        modify("Bill-to Name")
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Bill-to Address")
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change ImplicitType on ""Bill-to Address"(Control 22)". Please convert manually.

        }
        modify("Bill-to Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change ImplicitType on ""Bill-to Address 2"(Control 24)". Please convert manually.

        }
        modify("Bill-to Post Code")
        {
            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify("Bill-to City")
        {
            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change ImplicitType on ""Bill-to City"(Control 26)". Please convert manually.

        }
        modify("Bill-to Contact No.")
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
        }
        modify("Bill-to Contact")
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }

        //Unsupported feature: CodeModification on ""Sell-to Customer Name"(Control 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." then
          if "Sell-to Customer No." <> xRec."Sell-to Customer No." then
            SETRANGE("Sell-to Customer No.");

        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5

        //<< DITW18.00.07 AKH 09/05/2016 DIT-770 #1804
        if "Sundry Customer" then
          ShowCustomerSundryInfo();
        //>> DITW18.00.07 AKH DIT-770 #1804
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Responsibility Center"(Control 107)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        if "Responsibility Center" <> xRec."Responsibility Center" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1190
        */
        //end;


        //Unsupported feature: CodeInsertion on "Status(Control 110)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        StatusOnValidate;
        StatusOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeModification on ""Currency Code"(Control 91).OnAssistEdit". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Posting Date" <> 0D then
          ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date")
        else
        #4..6
          CurrPage.UPDATE;
        end;
        CLEAR(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CLEAR(ChangeExchangeRate);
        #1..9
        */
        //end;
        modify("Shipment Date")
        {
            Visible = false;
        }


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 50)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1190
        */
        //end;
        addafter("Sell-to Customer Name")
        {
            //BC UPGRADE VAMSIU01 -Added >>
            field("Document Subtype Code"; rec."Document Subtype Code FND")
            {
                ApplicationArea = All;
            }
            //BC UPGRADE VAMSIU01 -Added <<
        }
        addafter("Sell-to City")
        {
            //BC UPGRADE SIVA >>  In base layout already filed is existed               
            // field("Sell-to Country/Region Code"; rec."Sell-to Country/Region Code")
            // {
            //     CaptionML = ENU = 'Country/Region',
            //                 FRA = 'Pays/région';
            //     Importance = Additional;
            // }
            //BC UPGRADE SIVA <<
        }
        addafter("Sell-to Contact")
        {
            group("Ship to")
            {
                CaptionML = ENU = 'Ship-to',
                            FRA = 'Destinataire';
                field("SShip-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Code',
                                FRA = 'Code';
                }
                field("SShip-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Name',
                                FRA = 'Nom destinataire';
                    QuickEntry = false;
                }
                field("SShip-to Address"; rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Address',
                                FRA = 'Destinataire';
                    Importance = Additional;
                    QuickEntry = false;
                }
                field("SShip-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Post Code',
                                FRA = 'Code Postale destinataire';
                    Importance = Additional;
                    QuickEntry = false;
                }
                field("SShip-to City"; rec."Ship-to City")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'City',
                                FRA = 'Ville destinataire';
                    Importance = Additional;
                    QuickEntry = false;
                }
                field("SShip-to Country/Region Code>"; rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Country/Region',
                                FRA = 'Pays/région';
                    Importance = Additional;
                }
            }
            group(Control1100710919)
            {
            }
        }
        addafter("Document Date")
        {
            //BC UPGRADE SIVA >>
            // field("Tax Date"; rec."Tax Date")
            // {
            //     Importance = Additional;
            //     QuickEntry = false;
            // }
            //BC UPGRADE SIVA <<
            group(Control1100710902)
            {
                ShowCaption = false; // BC Upgrade SHUKLP03 <<
                //BC UPGRADE SIVA >>
                // field(RouteNew; rec.Route)
                // {

                //     trigger OnDrillDown();
                //     begin
                //         // <<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                //         DrillDownRouteCombinaison;
                //         // >>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                //     end;
                // }
                // field(RoutePlanningNew; rec."Route Planning No.")
                // {
                //     Editable = false;
                // }
                // field("Multiple Order Route"; rec."Multiple Order Route")
                // {
                //     Description = 'NRQ#16082';
                //     Editable = false;
                // }
                //BC UPGRADE SIVA <<
                field(ShipmentDateNew; rec."Shipment Date")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
            }
        }
        // BC UPGRADE SIVA >>
        // addfirst("Job Queue Status")
        // {
        //     field("Link Sales Document Type"; rec."Link Sales Document Type")
        //     {
        //         Editable = false;
        //         HideValue = LinkSalesDocumentTypeHideValue;
        //         Importance = Additional;
        //         QuickEntry = false;
        //         Visible = false;
        //     }
        //     field("Link Sales Document No."; rec."Link Sales Document No.")
        //     {
        //         Editable = false;
        //         QuickEntry = false;
        //     }
        //     field("Suggested Return Item"; rec."Suggested Return Item")
        //     {
        //         Importance = Additional;

        //         trigger OnValidate();
        //         begin
        //             //<<DITW110.00.10 MSF 07/07/2017 NRQ#16224
        //             SuggestedReturnItemAfterValidate;
        //         end;
        //     }
        //     group(Control1100710920)
        //     {
        //     }
        // }


        // addfirst("Salesperson Code")
        // {
        //     field("Building No."; rec."Building No.")
        //     {
        //         Description = '<DITW15.00.00.35>- DIT-770 #354';
        //         Editable = false;
        //         Importance = Additional;
        //         QuickEntry = false;
        //     }
        //     field("Customer DTax Group Code"; rec."Customer DTax Group Code")
        //     {
        //         Description = '<DITW15.00.00.01>- DITW18.00.06 MSF 07/09/2015 DIT-770 #1517';
        //         Editable = false;
        //         QuickEntry = false;
        //     }
        // }
        //BC UPGRADE SIVA <<
        addafter("Assigned User ID")
        {
            //BC UPGRADE SIVA >>
            // field(PickingTypeNew; Rec."Picking Type")
            // {
            //     CaptionML = ENU = 'Picking Type',
            //                 FRA = 'Type de prélèvement';
            //     Importance = Additional;
            //     QuickEntry = false;
            // }
            //BC UPGRADE SIVA <<
            field(ShippingAdviceNew; Rec."Shipping Advice")
            {
                ApplicationArea = all;
                Importance = Additional;
                QuickEntry = false;
            }
            //BC UPGRADE SIVA >>
            // field("Document Shipping Costs"; rec.HasDocumentShippingCosts)
            // {
            //     CaptionML = ENU = 'Document Shipping Costs',
            //                 FRA = 'Document Frais livraison';

            //     trigger OnDrillDown();
            //     begin
            //         //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
            //         OpenDocumentShippingCosts;
            //         //>> DITW18.00.07 VSC DIT-770 #1066
            //     end;
            // }
            // field("Shipment status"; Rec."Shipment status")
            // {
            //     QuickEntry = false;
            // }
            //BC UPGRADE SIVA <<
        }

        addafter(Status)
        {
            field("Approval Status"; Rec."Approval Status FND")
            {
                ApplicationArea = all;
                ToolTip = 'Approval Status';

            }
            //BC UPGRADE SIVA >> Drink It Fields 
            // field("Creation Date/Time"; rec."Creation Date/Time")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1282';
            //     Importance = Additional;
            // }
            // field("Created By"; "Created By")
            // {
            //     Description = 'DITW18.00.07 DIT-770 #1282';
            //     Importance = Additional;
            // }
            //BC UPGRADE SIVA >>Drink It Fields
            //BC UPGRADE SIVA << Interface Field
            // field("Suppress POS Interface"; rec."Suppress POS Interface")
            // {
            //     ApplicationArea = all;
            //     ToolTip ='Suppress POS Interface';
            //     Editable = SuppressPOSInterfaceEditable;
            // }
            //BC UPGRADE SIVA >> Interface Field
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = all;
                ToolTip = 'Source System Identifier';

            }
            //BC UPGRADE SIVA>> //---Ethiopia Intercompany Automation
            // field("Special Order"; rec."Special Order")
            // {
            //     ApplicationArea = all;
            //     ToolTip ='Special Order';

            // }
            //BC UPGRADE SIVA<<  //---Ethiopia Intercompany Automation

            field("IC Order No."; rec."IC Order No. FND")
            {
                Description = 'HEI.15';
                ApplicationArea = all;
                ToolTip = 'IC Order No.';
            }
        }
        //BC UPGRADE SIVA <<

        // addafter("VAT Bus. Posting Group")
        //{
        //BC UPGRADE SIVA >>In base layout already filed is existed   
        // field("Customer Posting Group"; rec."Customer Posting Group")
        // {
        // }
        //BC UPGRADE SIVA << In base layout already filed is existed

        //BC UPGRADE SIVA >> Drink IT fields 
        // field("Sundry Customer";Rec. "Sundry Customer")
        // {
        //     Editable = false;
        // }
        // field("Invoice Method"; rec."Invoice Method")
        // {

        //     trigger OnValidate();
        //     begin
        //         //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
        //         if (("Invoice Method" <> "Invoice Method"::"Combine Shipments") and
        //            ("Invoice Method" <> "Invoice Method"::"Combine Shipments Per Sell-to")) then
        //             bInvPeriodEdit := false
        //         else
        //             bInvPeriodEdit := true;
        //         //>>DITW17.00.02 TEC1 DIT-770 #154
        //     end;
        // }
        // field("Invoice Period"; rec."Invoice Period")
        // {
        //     Editable = bInvPeriodEdit;
        // }
        // field("Invoice List Customer No."; rec."Invoice List Customer No.")
        // {
        //     Description = 'DITW17.10.05 DIT-715 #761,DITW18.00.07 DIT-770 #1723';
        // }
        // field("Disable DIT Disc. Prom."; rec."Disable DIT Disc. Prom.")
        // {
        //     Importance = Additional;
        // }

        //}


        // addfirst("Ship-to")
        // {
        //     field("Physical Location Group Code"; rec."Physical Location Group Code")
        //     {
        //         Importance = Additional;
        //         QuickEntry = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //                 CurrPage.UPDATE(true);
        //             // >>DITW18.00.06 DDR DIT-770 #1190
        //         end;
        //     }
        // }
        //BC UPGRADE SIVA << Drink IT fields

        addafter("Location Code")
        {
            field("Ship-to Code"; rec."Ship-to Code")
            {
                ApplicationArea = all;
                QuickEntry = false;
            }
        }
        //BC UPGRADE SIVA >> In base layout already fields is existed
        // addafter("Ship-to City")
        // {
        //     field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
        //     {
        //         CaptionML = ENU = 'Country/Region',
        //                     FRA = 'Pays/région';
        //         Importance = Additional;
        //     }
        // }

        // addafter("Bill-to City")
        // {
        //     field("Bill-to Country/Region Code"; rec."Bill-to Country/Region Code")
        //     {
        //         CaptionML = ENU = 'Country/Region',
        //                     FRA = 'Pays/région';
        //         Importance = Additional;
        //     }
        // }
        //BC UPGRADE SIVA >> In base layout already fields is existed

        //BC UPGRADE SIVA << Drink IT Fields   
        // addafter("Bill-to")
        // {
        //     field("Fiscal Representative No."; Rec."Fiscal Representative No.")
        //     {
        //         Description = '<DITW15.00.00.28-.38 #1217>-DIT-770 #354';
        //         Importance = Additional;
        //     }
        //     field("Tax Office Code"; Rec."Tax Office Code")
        //     {
        //         Description = '<DITW15.00.00.38 #1217>- DTI-770 #354';
        //         Importance = Additional;
        //     }
        //     field("Shipment Date Formula"; Rec."Shipment Date Formula")
        //     {
        //         Description = 'DITW17.00.02 DIT-770 #146 DTI - 770 #354';
        //         Importance = Additional;
        //     }
        //     field("Shipment Time"; rec."Shipment Time")
        //     {
        //         Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
        //     }
        //     field("Shipping Advice"; Rec."Shipping Advice")
        //     {
        //         Importance = Promoted;
        //     }
        //     field("Copy Shipment Method Code"; Rec."Shipment Method Code")
        //     {
        //         Description = 'NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field("Picking Type"; rec."Picking Type")
        //     {
        //     }
        //     field(Distance; rec.Distance)
        //     {
        //         Description = '<DITW15.00.00.24>-NRQ#16082';
        //     }
        //     field("Truck Code"; rec."Truck Code")
        //     {
        //         Description = '<DITW15.00.00.25 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;

        //         trigger OnValidate();
        //         begin
        //             //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //             if xRec."Truck Code" <> Rec."Truck Code" then
        //                 CurrPage.UPDATE(true)
        //             //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         end;
        //     }
        //     field("Trailer Code"; rec."Trailer Code")
        //     {
        //         Description = 'DITW18.00.06 MSF 14/05/2015 DIT-770 #1035-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;

        //         trigger OnValidate();
        //         begin
        //             //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //             if xRec."Trailer Code" <> Rec."Trailer Code" then
        //                 CurrPage.UPDATE(true)
        //             //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         end;
        //     }
        //     field("Truck Zone"; rec."Truck Zone")
        //     {
        //     }
        //     field("Driver Code"; rec."Driver Code")
        //     {
        //         Description = '<DITW15.00.00.25 - DITW18.00.06 MSF 07/07/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;

        //         trigger OnValidate();
        //         begin
        //             //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //             if xRec."Driver Code" <> Rec."Driver Code" then
        //                 CurrPage.UPDATE(true)
        //             //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         end;
        //     }
        //     field("Require 2 Drivers"; rec."Require 2 Drivers")
        //     {
        //         Description = '<DITW17.00.02 DIT-770 #154>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;
        //     }
        //     field("Driver 2 Code"; rec."Driver 2 Code")
        //     {
        //         Description = '<DITW17.00.02 DIT-770 #154 - DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
        //         Editable = EditableMultipleRouteOrder;

        //         trigger OnValidate();
        //         begin
        //             //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //             if xRec."Driver 2 Code" <> Rec."Driver 2 Code" then
        //                 CurrPage.UPDATE(true)
        //             //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        //         end;
        //     }
        //     field("Ship-to Address Key No."; rec."Ship-to Address Key No.")
        //     {
        //     }
        //     field(Route; rec.Route)
        //     {
        //         Description = '<DITW16.00.00.40 #1002> - DITW18.00.06 MSF 13/05/2015 DIT-770 #1212 #1213 #1214';

        //         trigger OnDrillDown();
        //         begin
        //             // <<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
        //             DrillDownRouteCombinaison;
        //             // >>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
        //         end;
        //     }
        //     field("Route Planning No."; rec."Route Planning No.")
        //     {
        //         Editable = false;
        //     }
        //     field("Delivery Sequence"; rec."Delivery Sequence")
        //     {
        //         Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
        //     }
        //     field("Shipping Charge Per"; Rec."Shipping Charge Per")
        //     {
        //         Description = '<DITW15.00.00.21> DTI - 770 #354';
        //         Editable = false;
        //         Importance = Additional;
        //     }
        //     field("Maximum Weight"; rec."Maximum Weight")
        //     {
        //         Editable = false;
        //         Style = Strong;
        //         StyleExpr = "Maximum WeightEmphasize";
        //         Visible = "Maximum WeightVisible";
        //     }
        //     field("Maximum Cubage"; rec."Maximum Cubage")
        //     {
        //         Editable = false;
        //         Style = Strong;
        //         StyleExpr = "Maximum CubageEmphasize";
        //         Visible = "Maximum CubageVisible";
        //     }
        //     field("Total Weight (Base)"; rec."Total Weight (Base)")
        //     {
        //         Importance = Additional;
        //     }
        //     field("Total Weight"; rec."Total Weight")
        //     {
        //     }
        //     field("Total Cubage (Base)"; rec."Total Cubage (Base)")
        //     {
        //         Importance = Additional;
        //     }
        //     field("Total Cubage"; rec."Total Cubage")
        //     {
        //     }
        //     field("Total HL Cubage"; rec."Total HL Cubage")
        //     {
        //     }
        //     field("Total Eq. UOM Quantity"; rec."Total Eq. UOM Quantity")
        //     {
        //         Importance = Additional;
        //     }
        //     field("Delivery Time 1 From"; rec."Delivery Time 1 From")
        //     {
        //     }
        //     field("Delivery Time 1 To"; rec."Delivery Time 1 To")
        //     {
        //     }
        //     field("Delivery Time 2 From"; rec."Delivery Time 2 From")
        //     {
        //     }
        //     field("Delivery Time 2 To"; rec."Delivery Time 2 To")
        //     {
        //     }
        //BC UPGRADE SIVA >> Drink IT Fields

        //BC UPGRADE SIVA << Moved Interface App
        //     field("Load No."; rec."Load No.")
        //     {
        //         Description = 'HEi.07';
        //         Visible = false;
        //     }
        //     field("Sequence No."; rec."Sequence No.")
        //     {
        //         Description = 'HEi.07';
        //         Visible = false;
        //     }
        // }
        //BC UPGRADE SIVA >> Moved Interface App
        addafter("Foreign Trade")
        {
            group(Marketing)
            {
                CaptionML = ENU = 'Marketing',
                            FRA = 'Marketing';
            }
        }

        //BC UPGRADE SIVA >> Drink It fields 
        // addafter("Foreign Trade")
        // {
        //     group("Service/Contract")
        //     {
        //         CaptionML = ENU = 'Service/Contract',
        //                     FRA = 'Service/ Contrat';
        //         field("Contract Type"; rec."Contract Type")
        //         {
        //             Editable = false;
        //         }
        //         field("DIT Sub-Contract Type"; rec."DIT Sub-Contract Type")
        //         {
        //         }
        //         field("Service Contract No."; rec."Service Contract No.")
        //         {
        //         }
        //         field("Financial Contract No."; rec."Financial Contract No.")
        //         {
        //         }
        //         field("Contract Group Code"; rec."Contract Group Code")
        //         {
        //         }
        //     }
        // }
        //BC UPGRADE SIVA << Drink It fields

        moveafter("Sell-to City"; "Sell-to Contact")
        moveafter("Sell-to Contact No."; "Posting Date")
        moveafter("No. of Archived Versions"; "Job Queue Status")
        moveafter("Salesperson Code"; "Responsibility Center")
        moveafter("Assigned User ID"; Status)
        moveafter("Invoice Details"; "Shortcut Dimension 1 Code")
        moveafter("Applies-to ID"; "Prices Including VAT")
        moveafter("VAT Bus. Posting Group"; "Shipping and Billing")
        moveafter("Bill-to City"; "Bill-to Contact")
        moveafter("Bill-to Contact"; "Bill-to Contact No.")
        moveafter("Bill-to Contact No."; "Foreign Trade")
        moveafter("Foreign Trade"; "Currency Code")
        moveafter("Currency Code"; "EU 3-Party Trade")
        moveafter("EU 3-Party Trade"; "Transaction Type")
        moveafter("Transaction Type"; "Transaction Specification")
    }
    actions
    {
        modify("&Return Order")
        {
            CaptionML = ENU = '&Return Order', FRA = '&Retour';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        //BC UPGRADE SIVA >>
        // modify(Card)
        // {
        //     CaptionML = ENU = 'Card', FRA = 'Fiche';
        // }
        //BC UPGRADE SIVA <<

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
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify("Return Receipts")
        {
            CaptionML = ENU = 'Return Receipts', FRA = 'Réceptions retour';
        }
        modify("Cred&it Memos")
        {
            CaptionML = ENU = 'Cred&it Memos', FRA = 'A&voirs';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            CaptionML = ENU = 'In&vt. Put-away/Pick Lines', FRA = 'Lignes prélè&v./rangement stock';
        }
        modify("Whse. Receipt Lines")
        {
            CaptionML = ENU = 'Whse. Receipt Lines', FRA = 'Lignes réception entrep.';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify(Action7)
        {
            CaptionML = ENU = 'Release', FRA = 'Lancer';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
            trigger OnAfterAction()
            begin
                //BC UPGRADE SIVA >>
                //ReleaseSalesDoc.PerformManualRelease(Rec);
                //ReleaseSalesDoc.DocStatusRelease(xRec,Rec); //BC UPGRADE DRINK IT CODE 
                Rec.UpdateFreeReasonCodeDimensions(); //HEI.0
                //BC UPGRADE SIVA <<
            end;
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'Rou&vrir';
            ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed', FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';
            //ShortCutKey = Ctrl+F10;
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(CalculateInvoiceDiscount)
        {
            CaptionML = ENU = 'Calculate &Invoice Discount', FRA = 'C&alculer remise facture';
        }
        modify("Apply Entries")
        {
            CaptionML = ENU = 'Apply Entries', FRA = 'Lettrer écritures';
        }
        modify("Create Return-Related &Documents")
        {
            CaptionML = ENU = 'Create Return-Related &Documents', FRA = 'Créer documents ass&ociés retour';
        }
        modify(CopyDocument)
        {
            CaptionML = ENU = 'Copy Document', FRA = 'Copier document';
        }
        modify(MoveNegativeLines)
        {
            CaptionML = ENU = 'Move Negative Lines', FRA = 'Déplacer lignes négatives';
        }
        modify(GetPostedDocumentLinesToReverse)
        {
            CaptionML = ENU = 'Get Posted Doc&ument Lines to Reverse', FRA = 'Extraire lignes doc&ument enreg. à contrepasser';
        }
        modify("Archive Document")
        {
            CaptionML = ENU = 'Archive Document', FRA = 'Archiver document';
        }
        modify("Send IC Return Order Cnfmn.")
        {
            CaptionML = ENU = 'Send IC Return Order Cnfmn.', FRA = 'Confirmation envoi retour IC';
            Visible = false;//HEI.15 BC UPGRADE SIVA
            //Unsupported feature: Change Description on ""Send IC Return Order Cnfmn."(Action 31)". Please convert manually.


            //Unsupported feature: Change Visible on ""Send IC Return Order Cnfmn."(Action 31)". Please convert manually.

        }
        modify(Action13)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Create &Whse. Receipt")
        {
            CaptionML = ENU = 'Create &Whse. Receipt', FRA = 'Créer &réception entrepôt';
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away/Pick', FRA = 'Créer prélèv./rangement stoc&k';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            trigger OnAfterAction()
            begin
                //BC UPGRADE SIVA >>
                Rec.InsertFAGLJnlLinesForRPMDamageLoss(Rec); //HEI.03
                //BC UPGRADE SIVA <<
            end;
        }
        modify("Preview Posting")
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify("Post &Batch")
        {
            CaptionML = ENU = 'Post &Batch', FRA = 'Valider par l&ot';
        }
        modify("Remove From Job Queue")
        {
            CaptionML = ENU = 'Remove From Job Queue', FRA = 'Supprimer de la file d''attente des travaux';
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';

            //Unsupported feature: Change Description on "SendApprovalRequest(Action 142)". Please convert manually.


            //Unsupported feature: Change Visible on "SendApprovalRequest(Action 142)". Please convert manually.

        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
        }


        //Unsupported feature: CodeModification on "Release(Action 112).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleaseSalesDoc.PerformManualRelease(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.36 DDR 07/12/2009
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.36 DDR
        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleaseSalesDoc.PerformManualRelease(Rec);
        ReleaseSalesDoc.DocStatusRelease(xRec,Rec);
        CurrPage.UPDATE;
        // >>DITW15.00.00.39 DDR #1330 #1407

        UpdateFreeReasonCodeDimensions; //HEI.06
        */
        //end;


        //Unsupported feature: CodeModification on "Reopen(Action 113).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleaseSalesDoc.PerformManualReopen(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        //ReleaseSalesDoc.PerformManualReopen(Rec);
        ReleaseSalesDoc.DocStatusOpen(xRec,Rec);
        CurrPage.UPDATE;
        // >>DITW15.00.00.39 DDR #1330 #1407
        */
        //end;


        //Unsupported feature: CodeModification on ""Create &Whse. Receipt"(Action 122).OnAction". Please convert manually.

        //trigger  Receipt"(Action 122)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSourceDocInbound.CreateFromSalesReturnOrder(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.34 DDR 16/06/2009
        SalesSetup.GET();
        if SalesSetup."Auto.Release Document on Whse."then begin
          // <<DITW15.00.00.39 DDR 27/07/2011 #1407
          ReleaseSalesDoc.DocStatusRelease(xRec,Rec);
          // >>DITW15.00.00.39 DDR #1407
          if (xRec.Status <> Status) and (Status = Status::Released) then
            MESSAGE(Text2014410,"Document Type","No.");
        end;
        // >>DITW15.00.00.34 DDR

        GetSourceDocInbound.CreateFromSalesReturnOrder(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on "Post(Action 61).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)");
        InsertFAGLJnlLinesForRPMDamageLoss(Rec); //HEI.03
        */
        //end;


        //Unsupported feature: CodeModification on ""Test Report"(Action 60).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReportPrint.PrintSalesHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.SalesLines.PAGE.SetDisableRefreshLines(true);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        DocPrint.PrintSalesHeader(Rec);
        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
        CurrPage.SalesLines.PAGE.SetDisableRefreshLines(false);
        // >>DITW16.00.00.40 DDR DIT-715 #197
        */
        //end;
        //BC UPGRADE SIVA>> Drink IT Code
        //addafter("Co&mments")
        //{
        //BC UPGRADE SIVA >> Drink it Page Document Shipping Cost code commented
        // action("Shipping Costs")
        // {
        //     CaptionML = ENU = 'Shipping Costs',
        //                 FRA = 'Coûts transport';
        //     Image = Costs;
        //     RunObject = Page "Document Shipping Cost";
        //     RunPageLink = "Source Type" = CONST(36),
        //                   "Source No." = FIELD("No."),
        //                   "Sub Type" = FIELD("Document Type");
        // }

        //}
        //addafter("Cred&it Memos")
        //{
        // action("&Orders")
        // {
        //     ApplicationArea =all;
        //     ToolTip = 'Orders';
        //     CaptionML = ENU = '&Orders',
        //                 FRA = '&Commandes';
        //     Image = Document;
        //     RunObject = Page "Sales Order List";
        //     RunPageLink = "Document Type" = FIELD("Link Sales Document Type"),
        //                   "No." = FIELD("Link Sales Document No.");
        // }
        //}
        //BC UPGRADE SIVA>>
        addafter("&Print")
        {
            action(PrintUnloadingNote)
            {
                ApplicationArea = All;
                ToolTip = 'Print Unloading Note';
                CaptionML = ENU = 'Print Unloading Note',
                            FRA = 'Imprimer Bon de Depot';
                Enabled = UnloadingNoteVisible;
                Image = PrintReport;
                Visible = UnloadingNoteVisible;

                trigger OnAction();
                begin
                    //>>HEI.03
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(GeneralOpCoSetup."Unloading Note Report ID", true, false, Rec);
                    //<<HEI.03
                end;
            }
            action("RPM Balance Accounting")
            {
                ApplicationArea = all;
                ToolTip = 'RPM Balance Accounting';
                Caption = 'RPM Balance Accounting';
                Image = "Report";

                trigger OnAction();
                begin
                    //HEI.04>>
                    Customer.SETRANGE("No.", Rec."Sell-to Customer No.");
                    REPORT.RUNMODAL(REPORT::"RPM Balance Accounting CBN", true, true, Customer);
                    //HEI.04<<
                end;
            }
        }
        addafter(CalculateInvoiceDiscount)
        {
            // action("Change Sundry customer fields")
            // {
            //     CaptionML = ENU = 'Change Sundry customer fields',
            //                 FRA = 'champs client divers';
            //     Image = ChangeCustomer;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     Visible = "Sundry Customer";

            //     trigger OnAction();
            //     begin
            //         //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
            //         ShowCustomerSundryInfo();
            //         //>> DITW18.00.07 DIT-770 #1804
            //     end;
            // }
        }
        addafter("Send IC Return Order Cnfmn.")
        {
            // action(AutoSendICReturnOrder)
            // {
            //     Caption = 'Auto. Send IC Return Order';
            //     Description = 'NRQ69018-FINXL14.00.15 MSF 13/05/2020 NRQ#117628';
            //     Enabled = NOT VisibleSendIC;
            //     Image = Intercompany;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;

            //     trigger OnAction();
            //     var
            //         SH: Record "Sales Header";
            //     begin
            //         //<<FINXL11.00 HBA 03/05/2018 NRQ#69018
            //         cduICWebservice.fctCopyICDocument("Document Type", "No.", 'SALES');
            //         //>>FINXL11.00 HBA 03/05/2018 NRQ#69018
            //     end;
            // }
            // action("Returned Items")
            // {
            //     Caption = 'Returned Items';
            //     Image = ReturnShipment;
            //     ShortCutKey = 'Ctrl+Alt+R';

            //     trigger OnAction();
            //     var
            //         ReturnRegistrationMgt: Codeunit "Return Registration Mgt.";
            //     begin
            //         //<<DITW110.00.10 MSF 07/07/2017 NRQ#16224
            //         TESTFIELD("Route Planning No.");
            //         ReturnRegistrationMgt.LoadReturnedItemsPage("Route Planning No.", "No.", 36, 5);
            //     end;
            // }
            // action("Suggest Return Items")
            // {
            //     Caption = 'Suggest Return Items';
            //     Description = 'NRQ#16224';
            //     Image = SuggestLines;

            //     trigger OnAction();
            //     var
            //         SuggestReturnItems: Report "Suggest Return Items";
            //         SalesHeader: Record "Sales Header";
            //     begin
            //         //<<DITW110.00.10 MSF 07/07/2017 NRQ#16224
            //         SalesHeader.SETRANGE("Document Type", "Document Type");
            //         SalesHeader.SETRANGE("No.", "No.");
            //         //<<DITW110.00.10 MSF 14/07/2017 NRQ#16224
            //         SalesHeader.SETRANGE("Suggested Return Item", false);
            //         //>>DITW110.00.10 MSF 14/07/2017 NRQ#16224
            //         SuggestReturnItems.SETTABLEVIEW(SalesHeader);
            //         SuggestReturnItems.RUN;
            //     end;
            // }

            action("Customer Differences (RPM) CBN")
            {
                ApplicationArea = all;
                ToolTip = 'Customer Differences (RPM)';
                Caption = 'Customer Differences (RPM)';
                Visible = true;


                trigger OnAction();
                var
                    SalesLine: Record "Sales Line";

                begin
                    //HEI.05>>
                    SalesLine.SETRANGE("Document No.", Rec."No.");
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order"); //HEI.10
                    if SalesLine.ISEMPTY then begin
                        CustomerDifferencesRPM.RESET();
                        CustomerDifferencesRPM.SETRANGE("Sales return order no.", Rec."No.");
                        if CustomerDifferencesRPM.FINDFIRST() then begin
                            CustomerDifferencesRPMPage.SETTABLEVIEW(CustomerDifferencesRPM);
                            CustomerDifferencesRPMPage.SETRECORD(CustomerDifferencesRPM);
                            CustomerDifferencesRPMPage.RUN();
                        end else begin
                            CustomerDifferencesRPMPage.SETTABLEVIEW(CustomerDifferencesRPM);
                            CustomerDifferencesRPMPage.RUN();
                        end;
                    end else begin
                        SalesLine.SETRANGE("Document No.", Rec."No.");
                        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order"); //HEI.10
                        if SalesLine.FINDSET() then begin
                            //HeinekenGlobal.InsertRPMCustomerDifferences(Rec);//BC UPGRADE SIVA
                            HeinekenBCUpgradeMTC.InsertRPMCustomerDifferences(SalesLine);//BC UPGRADE SIVA
                        end;
                    end;
                    // HEI.05>>
                end;

            }
        }

        //BC UPGRADE SIVA>> Drink IT Code
        // addafter(Separator30)
        //{
        // action("Change Shipping Status")
        // {
        //     CaptionML = ENU = 'Change Shipping Status',
        //                 FRA = 'Modifier satut expédition';
        //     Image = ReleaseDoc;
        //     ShortCutKey = 'Shift+Ctrl+F9';

        //     trigger OnAction();
        //     begin
        //         //<<DITW17.00.02 SR 10/16/2013 DIT-770 #155 - DITW18.00.07 DDR 25/02/2016 DIT-770 #1488
        //         ChangeShipmentStatus();
        //         //>>DITW17.00.02 SR 10/16/2013 DIT-770 #155 - DITW18.00.07 DDR DIT-770 #1488
        //     end;
        // }
        //}
        //BC UPGRADE SIVA<<
    }

    var
        //ReleaseSalesDoc: Codeunit "Release Sales Document";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";

        //var
        UserSetup2: Record "User Setup";


        //Unsupported feature: PropertyModification on "OpenPostedSalesReturnOrderQst(Variable 1016)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //OpenPostedSalesReturnOrderQst : ENU=The return order has been posted and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //OpenPostedSalesReturnOrderQst : ENU=The return order has been posted and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?;FRA=Le retour vente a été enregistré et déplacé dans la fenêtre Avoirs vente enregistrés.\\Voulez-vous ouvrir l'avoir enregistré ?;
        //Variable type has not been exported.

        // var
        Text2014410: TextConst ENU = '%1 %2 has been automatically released.', FRA = 'Le/la %1 %2 a été automatiquement lancé(e).';
        Text2014411: TextConst ENU = 'Do you want to cancel the approval request for %1 %2?', FRA = 'Souhaitez vous annuler la demande d''approbation du/de la %1 %2?';
        Text2014412: TextConst ENU = 'Do you want to send the approval request for %1 %2?', FRA = 'Souhaitez vous envoyer la demande d''approbation du/de la %1 %2?';
        ReleaseSalesDoc: Codeunit "Release Sales Document";

        LinkSalesDocumentTypeHideValue: Boolean;

        "Maximum CubageVisible": Boolean;

        "Maximum WeightVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum CubageEmphasize": Boolean;
        SalesSetup: Record "Sales & Receivables Setup";

        bInvPeriodEdit: Boolean;
        ExternalDocNoMandatory: Boolean;
        EditableMultipleRouteOrder: Boolean;
        docsubtypecodesetup: Record "Doc Subtype Code Setup FND";//BC UPGRADE VAMSIU01 -Added >>
        DocSubtypeCode: Code[20];
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        UnloadingNoteVisible: Boolean;
        Customer: Record Customer;
        PostedCustomerDiffRPMPage: Page "Customer Differences (RPM) CBN";
        PostedCustomerDiffRPM: Record "Customer Differences RPM FND";
        SuppressPOSInterfaceEditable: Boolean;
        DocSubtypeEditable: Boolean;
        HeinekenGlobal: Codeunit "Heineken Global";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
        HeinekenBCUpgradeMTC: Codeunit "Heineken BC Upgrade MTC";
        VisibleSendApproval: Boolean;
        CustomerDifferencesRPM: Record "Customer Differences RPM FND";
        CustomerDifferencesRPMPage: Page "Customer Differences (RPM) CBN";
        // cduICWebservice: Codeunit "IC Web Service";//BC UPGRADE SIVA
        VisibleSendIC: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(RECORDID);

    // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
    SETFILTER("Resp. Center Table Filter",
      UserMgt.GetRespCenterFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",

      UserMgt.GetRespPhysLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserMgt.GetRespLocationFilter(0,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1190
    //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
    SETFILTER("Resp. Center Table Filter 2",'%1|%2','',"Responsibility Center");
    //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
    // <<DITW15.00.00.39 DDR 27/07/2011 #1407
    CALCFIELDS("Disc.Promo. Order Calculated");
    // >>DITW15.00.00.34 DDR
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
    if "Multiple Order Route" then
      EditableMultipleRouteOrder := false
    else
      EditableMultipleRouteOrder := true;
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082

    //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    VisibleSendIC := not IsAutoSendDocEnabled ;
    //>>FINXL14.00.15 MSF 13/05/2020 NRQ#117628

    //>>HEI.03
    if GeneralOpCoSetup.GET then
      if GeneralOpCoSetup."Unloading Note Report ID" <> 0 then
        UnloadingNoteVisible := true;
    //<<HEI.03
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger (Variable: UserSetup2)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlAppearance;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetControlAppearance;
    // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    LinkSalesDocumentTypeHideValue := false;
    LinkSalesDocumentTypeOnFormat;
    MaximumCubageOnFormat;
    MaximumWeightOnFormat;
    // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
    SetExtDocNoMandatoryCondition();
    //>> DITW18.00.07 AKH DIT-770 #1409
    ///DITW110.00.10 MSF 12/07/2017 NRQ#16224

    //HEI.08>>
    UserSetup2.GET(USERID);
    SuppressPOSInterfaceEditable := UserSetup2."Allow Change Interface Flag";
    //HEI.08<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    JobQueueUsed := SalesReceivablesSetup.JobQueueActive;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.25 DDR 09/10/2008
    "Maximum WeightVisible" := true;
    "Maximum CubageVisible" := true;
    // >>DITW15.00.00.25 DDR 09/10/2008
    //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
    SetExtDocNoMandatoryCondition();
    //>> DITW18.00.07 AKH DIT-770 #1409
    JobQueueUsed := SalesReceivablesSetup.JobQueueActive;
    //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
    EditableMultipleRouteOrder := true;
    //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
    //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    VisibleSendIC := true
    //>>FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsertRecord". Please convert manually.

    //trigger OnInsertRecord(BelowxRec : Boolean) : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if DocNoVisible then
      CheckCreditMaxBeforeInsert;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if DocNoVisible then
      CheckCreditMaxBeforeInsert;
    //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
    if docsubtypecodesetup.GET then
     VALIDATE("Document Subtype Code",DocSubtypeCode);
    //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
    */
    //end;

    // BC Upgrade VAMSIU01 - Added>>
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
        if docsubtypecodesetup.GET then
            Rec.VALIDATE("Document Subtype Code FND", DocSubtypeCode);
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<  
    end;
    // BC Upgrade VAMSIU01 - Added<<


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Responsibility Center" := UserMgt.GetSalesFilter;
    if (not DocNoVisible) and ("No." = '') then
      SetSellToCustomerFromFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3


    //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
    if docsubtypecodesetup.GET then
     VALIDATE("Document Subtype Code",DocSubtypeCode);
    //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
    */
    //end;

    // BC Upgrade VAMSIU01 - Added>>
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>
        if docsubtypecodesetup.GET then
            Rec.VALIDATE("Document Subtype Code FND", DocSubtypeCode);
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
    end;
    // BC Upgrade VAMSIU01 - Added<<

    // BC Upgrade VAMSIU01 - Added>>
    trigger OnOpenPage()
    begin
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>>>
        DocSubtypeCode := Rec."Document Subtype Code FND";
        //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<
    end;
    // BC Upgrade VAMSIU01 - Added<<


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if UserMgt.GetSalesFilter <> '' then begin
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
      FILTERGROUP(0);
    end;

    SetDocNoVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<DITW111.00.13A DDR 01/07/2019 NRQ#103938
    SalesSetup.GET;
    //>>DITW111.00.13A DDR 01/07/2019 NRQ#103938
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1190
    //IF UserMgt.GetSalesFilter <> '' THEN BEGIN
    if UserMgt.GetSalesTextFilter <> '' then begin
      FILTERGROUP(2);
      //SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
      SETFILTER("Responsibility Center",UserMgt.GetSalesTextFilter);
      FILTERGROUP(0);
    end;
    // >>DITW18.00.06 DDR DIT-770 #1190

    //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
    if (("Invoice Method" <> "Invoice Method"::"Combine Shipments") and
       ("Invoice Method" <> "Invoice Method"::"Combine Shipments Per Sell-to")) then
       bInvPeriodEdit := false
    else
      bInvPeriodEdit := true;
    //>>DITW17.00.02 TEC1 DIT-770 #154

    //FDD-PTPGAP013 IBM PATHAA02 29.09.2017>>>>
    DocSubtypeCode := "Document Subtype Code";
    //FDD-PTPGAP013 IBM PATHAA02 29.09.2017<<


    SetDocNoVisible;


    //<<DITW111.00.13A DDR 01/07/2019 NRQ#103938
    VisibleSendApproval := not SalesSetup."Automatic Document Approval";
    //>>DITW111.00.13A DDR 01/07/2019 NRQ#103938
    */
    //end;
    //BC UPGRADE SIVA >> Drink IT code
    // procedure FormatMaximumControls(pFieldNo: Integer; pMaxValue: Decimal; pTotalValue: Decimal);
    // var
    //     lblnBold: Boolean;
    //     lcolor: Integer;
    // begin
    //     // <<DIT15.00.00.21 DDR 19/06/2008 - DITW15.00.00.28 DDR 02/12/2008
    //     lcolor := 0;
    //     lblnBold := false;

    //     if pMaxValue < pTotalValue then
    //         lcolor := 255;

    //     lblnBold := lcolor <> 0;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := false;
    //     "Maximum WeightVisible" := false;
    //     // >>DITW15.00.00.25 DDR

    //     case pFieldNo of
    //         Rec.FIELDNO(Rec."Maximum Weight"):
    //             begin
    //                 "Maximum WeightEmphasize" := lblnBold;
    //             end;
    //         Rec.FIELDNO("Maximum Cubage"):
    //             begin
    //                 "Maximum CubageEmphasize" := lblnBold;
    //             end;
    //     end;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := true;
    //     "Maximum WeightVisible" := true;
    //     // >>DITW15.00.00.25 DDR
    // end;


    // local procedure StatusOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     CurrPage.UPDATE(false);
    // end;
    //BC UPGRADE SIVA << 
    //BC UPGRADE SIVA>> Drink IT code 
    // local procedure StatusOnValidate();
    // begin
    //     // <<DITW15.00.00.34 DDR 17/06/2009
    //     if xRec.Status = rec.Status then
    //         exit;

    //     // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
    //     if (xRec.Status = rec.Status::Open) or (xRec.Status = rec.Status::Released) then
    //         ReleaseSalesDoc.DocStatusRelease(xRec, Rec)
    //     else begin
    //         if Status = Status::Open then
    //             ReleaseSalesDoc.DocStatusOpen(xRec, Rec)
    //         else
    //             // >>DITW15.00.00.39 DDR #1330 #1407
    //             TESTFIELD(Status, xRec.Status);
    //     end;
    // end;
    // local procedure LinkSalesDocumentTypeOnFormat();
    // begin
    //     // <<DITW15.00.00.01 DDR 11/03/2008
    //     if "Link Sales Document No." = '' then
    //         LinkSalesDocumentTypeHideValue := true;
    //     // >>DITW15.00.00.01 DDR
    // end;
    //BC UPGRADE SIVA<<
    //BC UPGRADE SIVA >> Drink IT code
    // local procedure MaximumCubageOnFormat();
    // begin
    //     Rec.CALCFIELDS("Total Cubage");
    //     FormatMaximumControls(Field.FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage");
    // end;

    // local procedure MaximumWeightOnFormat();
    // begin
    //     CALCFIELDS("Total Weight");
    //     FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight");
    // end;

    // local procedure SetExtDocNoMandatoryCondition();
    // var
    //     Customer: Record Customer;
    //     SalesReceivablesSetup: Record "Sales & Receivables Setup";
    // begin
    //     //<< DITW18.00.07 AKH 28/03/2016 - 13/05/2016 DIT-770 #1409
    //     SalesReceivablesSetup.GET;
    //     ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory";
    //     if Customer.GET(Rec."Sell-to Customer No.") then
    //         ExternalDocNoMandatory := Customer.ShowExtDocMandatory(); // DITW18.00.07 AKH 30/03/2016 DIT-770 #1409
    // end;
    //BC UPGRADE SIVA<< Drink IT code.
    trigger OnAfterGetCurrRecord()
    begin
        //>>HEI.03
        IF GeneralOpCoSetup.GET() THEN
            IF GeneralOpCoSetup."Unloading Note Report ID" <> 0 THEN
                UnloadingNoteVisible := TRUE;
        //<<HEI.03
    end;

    local procedure SuggestedReturnItemAfterValidate();
    begin
        CurrPage.UPDATE();
    end;
    //BC UPGRADE SIVA>>   Logic is depend on Drink it field //Item Charge Type"::Promotion F2013695
    // local procedure UpdateFreeReasonCodeDimensions();
    // var
    //     SalesLine: Record "Sales Line";
    //     SalesLine2: Record "Sales Line";
    //     DefaultDimension: Record "Default Dimension";
    //     TempDimSetEntry: Record "Dimension Set Entry" temporary;
    //     DimMgt: Codeunit DimensionManagement;
    // begin
    //     //HEI.12>>
    //     SalesLine.SETRANGE("Document No.", Rec."No.");
    //     SalesLine.SETRANGE("Document Type", Rec."Document Type");
    //     SalesLine.SETRANGE("Item Charge Type", SalesLine."Item Charge Type"::Promotion);
    //     if SalesLine.FINDSET then
    //         repeat
    //             DefaultDimension.SETRANGE("Table ID", DATABASE::"Free Reason Code");
    //             DefaultDimension.SETRANGE("No.", SalesLine."Free Reason Code");
    //             if DefaultDimension.FINDSET then begin
    //                 SalesLine2.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
    //                 DimMgt.GetDimensionSet(TempDimSetEntry, SalesLine2."Dimension Set ID");
    //                 repeat
    //                     UpdateDimSet(TempDimSetEntry, DefaultDimension."Dimension Code", DefaultDimension."Dimension Value Code");
    //                 until DefaultDimension.NEXT = 0;
    //                 SalesLine2.VALIDATE("Dimension Set ID", DimMgt.GetDimensionSetID(TempDimSetEntry));
    //                 SalesLine2.MODIFY(true);
    //             end;
    //         until SalesLine.NEXT() = 0;
    //     //HEI.12
    // end;
    //BC UPGRADE SIVA<< Logic is depend on Drink it field

    // Procedure already there in SalesHeaderExt table - 50073
    // procedure UpdateDimSet(var TempDimSetEntry: Record "Dimension Set Entry" temporary; DimCode: Code[20]; DimValueCode: Code[20]);
    // var
    //     DimVal: Record "Dimension Value";
    // begin
    //     //HEI.12>>
    //     if DimCode = '' then
    //         exit;
    //     if TempDimSetEntry.GET(Rec."Dimension Set ID", DimCode) then
    //         TempDimSetEntry.DELETE();
    //     if DimValueCode = '' then
    //         DimVal.INIT()
    //     else
    //         DimVal.GET(DimCode, DimValueCode);
    //     TempDimSetEntry."Dimension Code" := DimCode;
    //     TempDimSetEntry."Dimension Value Code" := DimValueCode;
    //     TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
    //     if TempDimSetEntry.INSERT() then;
    //     //HEI.12<<
    // end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

