tableextension 50117 UserSetupExtFND extends "User Setup"
{
    // version NAVW110.0,FINXL10.00,DITW110.00.11,HEI.26

    // DITW15.00.00.26 DDR 28/10/2008 Added Drink-It fields
    //                                  2013800 Sales Amount Discount Limit
    //                                  2013801 Unlimited Sales Discount
    //                                  2013806 Sales Amount Promotion Limit
    //                                  2013807 Unlimited Sales Promotion
    //                                  2013808 Cost Amount Promotion Limit
    //                                  2013809 Unlimited Cost Promotion
    //                                  2013812 Delayed Approver ID
    // DITW15.00.00.28,HLW15.00.01.01 DDR 28/11/2008 Added fields
    //                                                 2035340 Allow Hidden Vendor Item No.
    //                                               Added functions
    //                                                 AllowHiddenVendorItemNo(),
    //                                                 EncriptHiddenVendorItemNo(),
    //                                                 DecriptHiddenVendorItemNo()
    //                                               Added text constant Text2035340
    // DITW15.00.00.29 DDR 15/12/2008 Added fields
    //                                  2013813 Delayed Substitute
    // DITW15.00.00.31 DDR 19/02/2009 Removed fields (not used)
    //                                  2035340 Allow Hidden Vendor Item No.
    //                                Removed functions
    //                                  AllowHiddenVendorItemNo(),
    //                                  EncriptHiddenVendorItemNo(),
    //                                  DecriptHiddenVendorItemNo()
    //                                Removed text constant Text2035340
    // DITW15.00.00.32 DDR 02/04/2009 Bad captions field "Delayed Approver ID" & "Delayed Substitute"
    //                                Customer Credit Limit and user permissions
    //                                Added fields
    //                                  2014448 Max. Credit Limit Customer
    //                                  2014449 Exceed Credit Limit Customer
    //                                  2014450 Unlimited Cr. Limit Customer
    // DITW15.00.00.34 DDR 05/06/2009 Bugfix to set 0 field "Cost Amt. Delayed Promo Limit" when click "Unlimited Cost Delayed Promo"
    //                     09/06/2009 Added fields
    //                                  2013816 Purch. Amt. Delayed Disc. Lmt.
    //                                  2013817 Unlimited Purch Delayed Disc.
    //                                  2013818 Purch. Amt. Delayed Promo Lmt.
    //                                  2013819 Unlimited Purch Delayed Promo
    //                                  2013820 P.Cost Amt. Delayed Promo Lmt.
    //                                  2013821 Unlimited Cost Delayed Promo
    // DITW15.00.00.35 DDR 18/08/2009 issue 769
    //                                Bugfix don't clear the field "Max. Credit Limit Customer" when "Unlimited Cr. Limit Customer"
    //                                Modified captions fields "Exceed Credit Limit Customer","Unlimited Cr. Limit Customer"
    //                                Added fields
    //                                  2014452 Credit Limit Approver ID
    // DITW16.00.00.41 DDR 18/09/2012 DIT-715 #436 Plant Maintenance functionnality
    //                                Added fields
    //                                  2034955 PM. Customer Filter"
    // DITW16.00.00.42 KSW 26/10/2012 DIT-715 #435 Plant Maintenance functionality
    //                                Added field
    //                                  2034987 "Printer For Attachments"

    // FINXL7.00.001 RBE 20/03/2013 : Created field 2029610 "Allow Modify G/L Entry"
    // FINXL8.00.001 BSA 27/05/2015 #183 : Created field 2029613 "Receive Other Pay-to Vendor"
    // FINXL8.00.001 BSA 27/05/2015 #184 : Created field 2029614 "Ship Other Bill-to Customer"

    // DITW17.00.02 SR 10/09/2013 DIT-770 #143 : New Field "2034640,2034641,2034642" Added
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0010.1
    //                             Added Fields
    //                             2014470 Product Posting Group
    //                             2014471 Dimension Fiter
    //                             2014472 Location Filter
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             Added field 2014430 Purchase Tolerance Limit %
    // DITW18.00.06 MSF 17/02/2015 DIT-770 #1181 Added fields 2014410 "Production Resp. Ctr. Filter"
    //                                                        2014411 "Assembly Resp. Ctr. Filter"
    //                                                        Added function CheckResponsabilityCenteremployee;
    // DITW18.00.06 MSF 19/02/2015 DIT-770 #1181  Added fields 2014412  "Invenotry Responsibility Center"
    //                                            Added Option Inventory to local variable function CheckResponsabilityCenteremployee
    // DITW18.00.06 MSF 24/02/2015 DIT-770 #1191 Added Field  2014413 "Quality Resp. Ctr. Filter"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 BCE 12/08/2015 DIT-770 #1535 Added table filter Plant Maintenance Plant=CONST(Yes) for field PM. Customer Filter.
    // DITW18.00.06 MVN 22/09/2015 DIT-770 #1524 Added Fields 2013610 Max. Deposit Limit Customer
    //                                                        2013611 Exceed Deposit Limit Customer
    //                                                        2013612 Unlimited Deposit Limit Cust.
    //                                                        2013613 Deposit Limit Approver ID
    //                                                        2013614 Deposit Substitute
    // DITW18.00.06 MVN 23/09/2015 DIT-770 #1593 Added Field 2014431 Overdue Grace Period (DateFormula)
    // DITW18.00.06A DDR 23/11/2015 DIT-770 #1714 Added fields 2014432 Overdue Approver ID
    //                                                         2014433 Overdue Substitute
    //                                                         2014434 Overdue Amount Approval Limit
    //                                                         2014435 Unlimited Overdue Approval
    //                                            Added functions InitDefaults()
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.001 ACH 26/07/2016 : set propriety ValidateTableRelation and testTableRelation to false on the field "User ID"
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL9.00.000.01 AKH 11/01/2017 Added new field 2029615 "Change VAT Bus Group on Inv"
    // FINXL10.00 AKH 02/03/2017 NRQ#25695: Restored standard values of ValidateTableRelation & TestTableRelation properties for fields "User ID" & "Salespers./Purch. Code"
    // DITW110.00.11 MSF 28/12/2017 NRQ#9570 Remove Fields : Overdue Amount Approval Limit

    // HEI.01 FDD-GAPID001 : IBM.NAIKH01
    //   #Added a new Fiels "Allow Partial Output"
    // HEI.02 FDD RTRGAP057 IBM HORTOC01 27.07.2017
    //   # Add new field "Allow Change FA"
    // HEI.03 RTRGAP038 IBM.CHAUHB01 02/08/17
    //   #Added field 50002
    // HEI.04 FDD-GAPLOG006 IBM ISYED01 29.09.2017 # Algerai Local
    //   # Added Fileds "Release Fixed assets".
    // HEI.05 FDD-OTCGAP01 IBM ISYED01 28.11.2017
    //   #Added fileds Fiscal Printer Active,Default Printer Station Id,Default Printer Id to table
    // HEI.06 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Field created: 50007 - "Release Request Order"
    // HEI.07 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50008 - Allow Gate Entry Register
    // HEI.08 FDD-IC-PRODGAP BRD HT417 IBM ISYED01 04/10/2019 # PO IC Layout
    //   # New Field created: Procurement Service Manager
    // HEI.09 V1.05 HT84 IBM POENAB02 07.05.2019
    //   # New field:
    //     # 50010 Allow to Reexport Payment WS
    // HEI.10 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field created: 50011 - Allow Change Interface Flag
    // HEI.11 FDD-Ethiopia_Prepayment HT628 IBM POSTOI01 01.07.2019
    //   # New fields 50012Modify Prepay.Condt. on BOBooleanHEI.11
    // HEI.12 FDD-HT620 IBM BULIMC01 02.08.2019 #new field added "Consump. Tolerance Warning"
    // HEI.13 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New code added
    // HEI.14 CHG2026978 IBM.LS      15.11.2019
    //   # New Field created: 50014 - Freeze/Unfreeze Phys Invt Jnl.
    // HEI.15 CHG2022325 FDD-HT630 IBM.GUNERE01 18.11.2019 # "Edit PO Tol. Received Over" field added
    // HEI.16 CHG2020184 IBM POENAB02 26.06.2019
    //   # New field for Bank Connectivity CAMT053: 50016 "Allow to Reprocess CAMT053 WS"
    // HEI.17 FDD-HT664 IBM SURYAS01 02-jan-2020
    //   #Created New Field -"55000"
    // HEI.18 FDD-HB1341 CHG2065548 IBM SHANKJ03  10.08.2020
    //   # Created new field Allow Delete/Archieve PQ
    // HEI.19 CHG2069321 GAVANM01 IBM 13.10.2020 #PowerApps Integration
    //   # New field created: 50018 - "Approve in PowerApps Approval App"
    // HEI.20 HT2139 CHG2105037 IBM NANDIS01 30-04-2021 - Brasco Congo: HT2139 - PO Form Layout
    //   # New field added - Electronic Signature(ID - 50020) - BLOB Type
    // HEI.21 CHG2115759 IBM.AB 08-Jun-2021
    //   # New field added - Allow Delete/Archive PO/Return(ID - 50021)
    // HEI.22 CHG2126534 IBM.AB 15-Sep-2021
    //   # New field added: 50022-Allow Bypass WHT Validation
    // HEI.23 CHG2155847 HB2821 IBM NANDIS01 03.08.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # New field created - Allow deletion ASTRO Whs Rcpt(ID - 50023 - Boolean)
    // HEI.24 CHG2202558 IBM BHANDS01 04.05.2023 - MtC Astro changes for reopening/deletion of SO/SRO/TO
    //   # New field created ID - 50024Allow Deletion Astro SO/SRO/TOBoolean
    // HEI.25 CHG2227390 HB3558 SRIVAS07 IBM 19.12.2023 # Role-StP call off handler not to create PO from PQ.
    //   # New field created ID - 50025 - "Make PQ to PO"
    // HEI.26 CHG2231326 HB3599 YADAVM09 IBM 07.02.2024 # Restrict users to connect or disconnect RTR journal templates from the Workflow approval on Opco level.
    //   # New field created ID - 50026 - "Restrict RtR Workflow Users"
    // HEI.27 CHG2277569 SAHAL01 29.01.2025 Not able to apply Entries
    //   # Created New Field: 50030 - Allow to Reopen G/L Entry
    // HEI.29 CHG2336029 SS40 17.03.2026 # Workflow Approval Functionality for Stock Adjustments
    //   # Created New Field: 50032 - Unlimited Journal Approval
    //   # Created New Field: 50033 - Journal Amount Approval Limit
    //   # Added Code : Unlimited Journal Approval - OnValidate()
    //   # Added Code : Journal Amount Approval Limit - OnValidate()
    //   # Added Code : CreateApprovalUserSetup
    //   # Added Code : InitDefaults
    //   # Created function : GetDefaultJournalAmountApprovalLimit

    // BC UPGRADE PATELS08 >>
    // # Added Tag HEI.29 to the documentation and related code. 
    // # Code in  CreateApprovalUserSetup could not be added as suitable Event was not found.
    // # Function InitDefaults was not persent so added it and added the HEI.29 related code in it.
    // BC UPGRADE PATELS08 <<  

    fields
    {
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Allow Posting From")
        {
            CaptionML = ENU = 'Allow Posting From', FRA = 'Début période validation';
            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                // //HEI.13>>
                // CompanyInfo.GET;
                // IF CompanyInfo."Enable French Localization" THEN
                //     GLSetup.CheckPostingRange("Allow Posting From", FIELDCAPTION("Allow Posting From"));
                // //HEI.13<<
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Allow Posting To")
        {
            CaptionML = ENU = 'Allow Posting To', FRA = 'Fin période validation';

            // BC Upgrade NANDIS03 >>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                // //HEI.13>>
                // CompanyInfo.GET;
                // IF CompanyInfo."Enable French Localization" THEN
                //     GLSetup.CheckPostingRange("Allow Posting To", FIELDCAPTION("Allow Posting To"));
                //HEI.13<<
            end;
            // BC Upgrade NANDIS03 <<
        }
        modify("Register Time")
        {
            CaptionML = ENU = 'Register Time', FRA = 'Registre temps';
        }
        modify("Salespers./Purch. Code")
        {

            //Unsupported feature: Change TableRelation on ""Salespers./Purch. Code"(Field 10)". Please convert manually.

            CaptionML = ENU = 'Salespers./Purch. Code', FRA = 'Code vendeur/acheteur';
        }
        modify("Approver ID")
        {
            CaptionML = ENU = 'Approver ID', FRA = 'ID approbateur';
        }
        modify("Sales Amount Approval Limit")
        {
            CaptionML = ENU = 'Sales Amount Approval Limit', FRA = 'Montant maximal vente autorisé';
        }
        modify("Purchase Amount Approval Limit")
        {
            CaptionML = ENU = 'Purchase Amount Approval Limit', FRA = 'Montant maximal achat autorisé';
        }
        modify("Unlimited Sales Approval")
        {
            CaptionML = ENU = 'Unlimited Sales Approval', FRA = 'Montant illimité de vente autorisé';
        }
        modify("Unlimited Purchase Approval")
        {
            CaptionML = ENU = 'Unlimited Purchase Approval', FRA = 'Montant illimité d''achat autorisé';
        }
        modify(Substitute)
        {
            CaptionML = ENU = 'Substitute', FRA = 'Remplaçant';
        }
        modify("E-Mail")
        {
            CaptionML = ENU = 'E-Mail', FRA = 'E-mail';
        }
        modify("Request Amount Approval Limit")
        {
            CaptionML = ENU = 'Request Amount Approval Limit', FRA = 'Montant maximal demande achat autorisé';
        }
        modify("Unlimited Request Approval")
        {
            CaptionML = ENU = 'Unlimited Request Approval', FRA = 'Montant illimité de demande d''achat autorisé';
        }
        modify("Approval Administrator")
        {
            CaptionML = ENU = 'Approval Administrator', FRA = 'Administrateur approbation';
        }
        modify("License Type")
        {

            //Unsupported feature: Change CalcFormula on ""License Type"(Field 31)". Please convert manually.

            CaptionML = ENU = 'License Type', FRA = 'Type licence';
            OptionCaptionML = ENU = 'Full User,Limited User,Device Only User,Windows Group,External User', FRA = 'Utilisateur complet,Utilisateur limité,Utilisateur avec périphérique uniquement,Groupe Windows,Utilisateur externe';
        }
        modify("Time Sheet Admin.")
        {
            CaptionML = ENU = 'Time Sheet Admin.', FRA = 'Admin. feuille de temps';
        }
        modify("Allow FA Posting From")
        {
            CaptionML = ENU = 'Allow FA Posting From', FRA = 'Date début validation immo.';
        }
        modify("Allow FA Posting To")
        {
            CaptionML = ENU = 'Allow FA Posting To', FRA = 'Date fin validation immo.';
        }
        modify("Sales Resp. Ctr. Filter")
        {
            CaptionML = ENU = 'Sales Resp. Ctr. Filter', FRA = 'Filtre centre gestion vente';
        }
        modify("Purchase Resp. Ctr. Filter")
        {
            CaptionML = ENU = 'Purchase Resp. Ctr. Filter', FRA = 'Filtre centre gestion achat';
        }
        modify("Service Resp. Ctr. Filter")
        {
            CaptionML = ENU = 'Service Resp. Ctr. Filter', FRA = 'Filtre centre gestion service';
        }

        //Unsupported feature: CodeInsertion on ""Allow Posting From"(Field 2)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.13>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          GLSetup.CheckPostingRange("Allow Posting From",FIELDCAPTION("Allow Posting From"));
        //HEI.13<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Allow Posting To"(Field 3)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.13>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          GLSetup.CheckPostingRange("Allow Posting To",FIELDCAPTION("Allow Posting To"));
        //HEI.13<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Salespers./Purch. Code"(Field 10).OnValidate". Please convert manually.

        //trigger /Purch();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Salespers./Purch. Code" <> '' THEN BEGIN
          UserSetup.SETCURRENTKEY("Salespers./Purch. Code");
          UserSetup.SETRANGE("Salespers./Purch. Code","Salespers./Purch. Code");
          IF UserSetup.FINDFIRST THEN
            ERROR(Text001,"Salespers./Purch. Code",UserSetup."User ID");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Salespers./Purch. Code" <> '' then begin
          UserSetup.SETCURRENTKEY("Salespers./Purch. Code");
          UserSetup.SETRANGE("Salespers./Purch. Code","Salespers./Purch. Code");
          if UserSetup.FINDFIRST then
            ERROR(Text001,"Salespers./Purch. Code",UserSetup."User ID");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Approver ID"(Field 11).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UserSetup.SETFILTER("User ID",'<>%1',"User ID");
        IF PAGE.RUNMODAL(PAGE::"Approval User Setup",UserSetup) = ACTION::LookupOK THEN
          VALIDATE("Approver ID",UserSetup."User ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UserSetup.SETFILTER("User ID",'<>%1',"User ID");
        if PAGE.RUNMODAL(PAGE::"Approval User Setup",UserSetup) = ACTION::LookupOK then
          VALIDATE("Approver ID",UserSetup."User ID");
        */
        //end;


        //Unsupported feature: CodeModification on ""Approver ID"(Field 11).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Approver ID" = "User ID" THEN
          FIELDERROR("Approver ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Approver ID" = "User ID" then
          FIELDERROR("Approver ID");
        */
        //end;


        //Unsupported feature: CodeModification on ""Sales Amount Approval Limit"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unlimited Sales Approval" AND ("Sales Amount Approval Limit" <> 0) THEN
          ERROR(Text003,FIELDCAPTION("Sales Amount Approval Limit"),FIELDCAPTION("Unlimited Sales Approval"));
        IF "Sales Amount Approval Limit" < 0 THEN
          ERROR(Text005);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Unlimited Sales Approval" and ("Sales Amount Approval Limit" <> 0) then
          ERROR(Text003,FIELDCAPTION("Sales Amount Approval Limit"),FIELDCAPTION("Unlimited Sales Approval"));
        if "Sales Amount Approval Limit" < 0 then
          ERROR(Text005);
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchase Amount Approval Limit"(Field 13).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unlimited Purchase Approval" AND ("Purchase Amount Approval Limit" <> 0) THEN
          ERROR(Text003,FIELDCAPTION("Purchase Amount Approval Limit"),FIELDCAPTION("Unlimited Purchase Approval"));
        IF "Purchase Amount Approval Limit" < 0 THEN
          ERROR(Text005);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Unlimited Purchase Approval" and ("Purchase Amount Approval Limit" <> 0) then
          ERROR(Text003,FIELDCAPTION("Purchase Amount Approval Limit"),FIELDCAPTION("Unlimited Purchase Approval"));
        if "Purchase Amount Approval Limit" < 0 then
          ERROR(Text005);
        */
        //end;


        //Unsupported feature: CodeModification on ""Unlimited Sales Approval"(Field 14).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unlimited Sales Approval" THEN
          "Sales Amount Approval Limit" := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Unlimited Sales Approval" then
          "Sales Amount Approval Limit" := 0;
        */
        //end;


        //Unsupported feature: CodeModification on ""Unlimited Purchase Approval"(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unlimited Purchase Approval" THEN
          "Purchase Amount Approval Limit" := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Unlimited Purchase Approval" then
          "Purchase Amount Approval Limit" := 0;
        */
        //end;


        //Unsupported feature: CodeModification on "Substitute(Field 16).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UserSetup.SETFILTER("User ID",'<>%1',"User ID");
        IF PAGE.RUNMODAL(PAGE::"Approval User Setup",UserSetup) = ACTION::LookupOK THEN
          VALIDATE(Substitute,UserSetup."User ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UserSetup.SETFILTER("User ID",'<>%1',"User ID");
        if PAGE.RUNMODAL(PAGE::"Approval User Setup",UserSetup) = ACTION::LookupOK then
          VALIDATE(Substitute,UserSetup."User ID");
        */
        //end;


        //Unsupported feature: CodeModification on "Substitute(Field 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Substitute = "User ID" THEN
          FIELDERROR(Substitute);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Substitute = "User ID" then
          FIELDERROR(Substitute);
        */
        //end;


        //Unsupported feature: CodeModification on ""Request Amount Approval Limit"(Field 19).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unlimited Request Approval" AND ("Request Amount Approval Limit" <> 0) THEN
          ERROR(Text003,FIELDCAPTION("Request Amount Approval Limit"),FIELDCAPTION("Unlimited Request Approval"));
        IF "Request Amount Approval Limit" < 0 THEN
          ERROR(Text005);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Unlimited Request Approval" and ("Request Amount Approval Limit" <> 0) then
          ERROR(Text003,FIELDCAPTION("Request Amount Approval Limit"),FIELDCAPTION("Unlimited Request Approval"));
        if "Request Amount Approval Limit" < 0 then
          ERROR(Text005);
        */
        //end;


        //Unsupported feature: CodeModification on ""Unlimited Request Approval"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unlimited Request Approval" THEN
          "Request Amount Approval Limit" := 0;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Unlimited Request Approval" then
          "Request Amount Approval Limit" := 0;
        */
        //end;


        //Unsupported feature: CodeModification on ""Approval Administrator"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Approval Administrator" THEN BEGIN
          UserSetup.SETRANGE("Approval Administrator",TRUE);
          IF NOT UserSetup.ISEMPTY THEN
            FIELDERROR("Approval Administrator");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Approval Administrator" then begin
          UserSetup.SETRANGE("Approval Administrator",true);
          if not UserSetup.ISEMPTY then
            FIELDERROR("Approval Administrator");
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Sales Resp. Ctr. Filter"(Field 5700)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW18.00.06 MSF 24/02/2015 DIT-770 #1181
        if (Rec."Sales Resp. Ctr. Filter" <> xRec."Sales Resp. Ctr. Filter") and (Rec."Sales Resp. Ctr. Filter" <>'') then
          CheckResponsabilityCenteremployee(0);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Purchase Resp. Ctr. Filter"(Field 5701)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW18.00.06 MSF 24/02/2015 DIT-770 #1181
        if (Rec."Purchase Resp. Ctr. Filter" <> xRec."Purchase Resp. Ctr. Filter") and (Rec."Purchase Resp. Ctr. Filter" <>'') then
          CheckResponsabilityCenteremployee(1);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Service Resp. Ctr. Filter"(Field 5900)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW18.00.06 MSF 24/02/2015 DIT-770 #1181
        if (Rec."Service Resp. Ctr. Filter" <> xRec."Service Resp. Ctr. Filter") and (Rec."Service Resp. Ctr. Filter" <>'') then
          CheckResponsabilityCenteremployee(2);
        */
        //end;
        field(50000; "Allow Partial Output FND"; Boolean)
        {
            caption ='Allow Partial Output';
            Description = 'FDD-GAPID001';
        }
        field(50001; "Allow Change FA FND"; Boolean)
        {
            Caption = 'Allow Modify FA';
            Description = 'HEI.02';
        }
        field(50002; "Allowed Change App. Mode FND"; Boolean)
        {
            caption ='Allowed Change App. Mode';
            Description = 'RTRGAP038';
        }
        field(50003; "Release Fixed assets FND"; Boolean)
        {
            CaptionML = ENU = 'Release Fixed assets',
                        FRA = 'Lancer Immobilisations';
            Description = 'HEI.04';
        }
        field(50004; "Fiscal Printer Active FND"; Boolean)
        {
            caption ='Fiscal Printer Active';
            Description = 'HEI.05';
        }
        field(50005; "Default Printer Station Id FND"; Text[2])
        {
            caption ='Default Printer Station Id';
            Description = 'HEI.05';
        }
        field(50006; "Default Printer Id FND"; Text[2])
        {
            caption ='Default Printer Id';
            Description = 'HEI.05';
        }
        field(50007; "Release Request Order FND"; Boolean)
        {
            caption ='Release Request Order';
            Description = 'HEI.06';
        }
        field(50008; "Allow Gate Entry Register FND"; Boolean)
        {
            caption ='Allow Gate Entry Register';
            Description = 'HEI.07';
        }
        field(50009; "Procurement Serv Manager FND"; Boolean)
        {
            caption ='Procurement Serv Manager';
            Description = 'HEI.08';

            trigger OnValidate();
            var
                UserSetup: Record "User Setup";
            begin
                //HEI.08>>
                if "Procurement Serv Manager FND" then begin
                    UserSetup.SETRANGE("Procurement Serv Manager FND", true);
                    if not UserSetup.ISEMPTY then
                        FIELDERROR("Procurement Serv Manager FND");
                end;
                //HEI.08<<
            end;
        }
        field(50010; "Allow to Reexport Pay WS FND"; Boolean)
        {
            Caption = 'Allow to Reexport Payment File to WS';
            Description = 'HEI.09';
        }
        field(50011; "Allow Change Inter Flag FND"; Boolean)
        {
            caption ='Allow Change Inter Flag';
            Description = 'HEI.10';
        }
        field(50012; "Allow Mod Prepay.Condt. BO FND"; Boolean)
        {
            Caption = 'Allow Modify Prepayment Conditions on Blanket Order';
            Description = 'HEI.11';
        }
        field(50013; "Consump. Tolerance Warning FND"; Boolean)
        {
            Caption = 'Consump. Tolerance Warning';
            Description = 'HEI.12';
        }
        field(50014; "Freeze/Unfreez PhysInvtJnl.FND"; Boolean)
        {
            caption ='Freeze/Unfreeze Phys Invt Jnl.';
            Description = 'HEI.14';
        }
        field(50015; "Edit PO Tol. Received Over FND"; Boolean)
        {
            caption ='Edit PO Tol. Received Over';
            Description = 'HEI.15';
        }
        field(50016; "Allow to Rep CAMT053 WS FND"; Boolean)
        {
            Caption = 'Allow to Reprocess CAMT053 WS';
            Description = 'HEI.16';
        }
        field(50017; "Allow Delete/Archieve PQ FND"; Boolean)
        {
            caption ='Allow Delete/Archieve PQ';
            Description = 'HEI.18';
        }
        field(50018; "Approve in PowerApps FND"; Boolean)
        {
            Caption = 'Approve in PowerApps Approval App';
            Description = 'HEI.19';
        }
        field(50020; "Electronic Signature FND"; BLOB)
        {
            caption ='Electronic Signature';
            DataClassification = ToBeClassified;
            Description = 'HEI.20';
            SubType = Bitmap;
        }
        field(50021; "Allow Delete/Arc PO/Return FND"; Boolean)
        {
            caption ='Allow Delete/Arc PO/Return';
            DataClassification = ToBeClassified;
        }
        field(50022; "Allow Bypass WHT Valid FND"; Boolean)
        {
            caption ='Allow Bypass WHT Valid';
            DataClassification = ToBeClassified;
            Description = 'HEI.22';
        }
        field(50023; "Allow del ASTRO Whs Rcpt FND"; Boolean)
        {
            Caption = 'Allow Deletion of ASTRO Warehouse Receipt';
            DataClassification = ToBeClassified;
            Description = 'HEI.23';
        }
        field(50024; "Allow Del Astro SO/SRO/TO FND"; Boolean)
        {
            Caption = 'Allow Deletion Astro SO/SRO/TO';
            DataClassification = ToBeClassified;
            Description = 'HEI.24';
        }
        field(50025; "Make PQ to PO FND"; Boolean)
        {
            Caption = 'Make PQ to PO';
            DataClassification = ToBeClassified;
            Description = 'HEI.25';
        }
        field(50026; "Restrict RtR Work Users FND"; Boolean)
        {
            caption ='Restrict RtR Work Users';
            DataClassification = ToBeClassified;
            Description = 'HEI.26';
        }
        field(55000; "Payment Slip-Display Path FND"; Boolean)
        {
            caption ='Payment Slip-Display Path';
            Description = 'HEI.17';
        }
        //BC Upgrade KAMNAY01>> New Field Added: This table is already compiled, but this field, which is defined in the documentation, is not present here, so I added this field manually.
        field(50030; "Allow to Reopen G/L Entry FND"; Boolean)
        {
            caption ='Allow to Reopen G/L Entry';
            Description = 'HEI.27';
        }
        field(50031; "Allow to send to EBMS FND"; Boolean)
        {
            Caption = 'Allow to send to EBMS';
            Description = 'HEI.28';
        }
        //BC Upgrade GUNREM01 >> Added DIT field 

        field(50032; "Release Item FND"; Boolean)
        {
            CaptionML = ENU = 'Release Item',
                        FRA = 'Lancer article';
            Description = 'DITW17.00.02 SR DIT-770 #143';
        }

        // BC UPGRADE PATELS08 >>
        field(50033; "Unlimited Journ.Approval FND"; Boolean)
        {
            CaptionML = ENU = 'Unlimited Journal Approval';
            DataClassification = ToBeClassified;
            Description = 'HEI.29';

            trigger OnValidate();
            begin
                //HEI.29>>
                IF "Unlimited Journ.Approval FND" THEN
                    "Journal Amt Approval Limit FND" := 0;
                //HEI.29<<
            end;
        }

        // BC UPGRADE PATELS08 <<

        field(50034; "Journal Amt Approval Limit FND"; Decimal)
        {
            CaptionML = ENU = 'Journal Amount Approval Limit';
            DataClassification = ToBeClassified;
            Description = 'HEI.29';

            trigger OnValidate();
            begin
                //HEI.29>>
                IF "Unlimited Journ.Approval FND" AND ("Journal Amt Approval Limit FND" <> 0) THEN
                    ERROR(Text003,FIELDCAPTION("Journal Amt Approval Limit FND"),FIELDCAPTION("Unlimited Journ.Approval FND"));
                IF "Journal Amt Approval Limit FND" < 0 THEN
                    ERROR(Text005);
                //HEI.29<<
            end;
        }
        //BC Upgrade GUNREM01 << Added DIT field 
        //BC Upgrade KAMNAY01>> New Field Added: This table is already compiled, but this field, which is defined in the documentation, is not present here, so I added this field manually.
        // field(2013610; "Max. Deposit Limit Customer"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Max. Deposit Limit Customer (LCY)',
        //                 FRA = 'Max. Limite de consigne client DS';
        //     Description = 'DIT-770 #1524';
        //     MinValue = 0;
        // }
        // field(2013611; "Exceed Deposit Limit Customer"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Exceed Deposit Limit Customer (LCY)',
        //                 FRA = 'Excéder la limite de consigne client DS';
        //     Description = 'DIT-770 #1524';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         //<<DITW18.00.06 MVN 22/09/2015 DIT-770 #1524
        //         if "Unlimited Deposit Limit Cust." and ("Exceed Deposit Limit Customer" <> 0) then
        //             ERROR(Text003, FIELDCAPTION("Exceed Deposit Limit Customer"), FIELDCAPTION("Unlimited Deposit Limit Cust."));
        //         //>>DITW18.00.06 MVN 22/09/2015 DIT-770 #1524
        //     end;
        // }
        // field(2013612; "Unlimited Deposit Limit Cust."; Boolean)
        // {
        //     CaptionML = ENU = 'Unlimited Exceed Deposit Limit Customer',
        //                 FRA = 'Limite Illimité de consigne client';
        //     Description = 'DIT-770 #1524';

        //     trigger OnValidate();
        //     begin
        //         //<<DITW18.00.06 MVN 22/09/2015 DIT-770 #1524
        //         if "Unlimited Deposit Limit Cust." then begin
        //             "Exceed Deposit Limit Customer" := 0;
        //         end;
        //         //>>DITW18.00.06 MVN 22/09/2015 DIT-770 #1524
        //     end;
        // }
        // field(2013613; "Deposit Limit Approver ID"; Code[50])
        // {
        //     CaptionML = ENU = 'Approver ID (Deposit Limit)',
        //                 FRA = 'ID approbateur (limite consigne)';
        //     Description = 'DIT-770 #1524';
        //     TableRelation = "User Setup"."User ID";
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;
        // }
        // field(2013614; "Deposit Substitute"; Code[50])
        // {
        //     CaptionML = ENU = 'Substitute (Deposit)',
        //                 FRA = 'Remplaçant (consigne)';
        //     Description = 'DIT-770 #1524';
        //     TableRelation = "User Setup";
        // }
        // field(2013800; "Sales Amt. Delayed Disc. Limit"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Sales Amount Discount  Limit',
        //                 FRA = 'Limite montant remise vente';
        //     Description = 'DITW15.00.00.26';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008
        //         if "Unlimited Sales Delayed Disc." and ("Sales Amt. Delayed Disc. Limit" <> 0) then
        //             ERROR(Text003, FIELDCAPTION("Sales Amt. Delayed Disc. Limit"), FIELDCAPTION("Unlimited Sales Delayed Disc."));
        //         if "Sales Amt. Delayed Disc. Limit" < 0 then
        //             ERROR(Text005);
        //     end;
        // }
        // field(2013801; "Unlimited Sales Delayed Disc."; Boolean)
        // {
        //     CaptionML = ENU = 'Unlimited Sales Discount',
        //                 FRA = 'Montant illimité remise vente autorisé';
        //     Description = 'DITW15.00.00.26';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008
        //         if "Unlimited Sales Delayed Disc." then
        //             "Sales Amt. Delayed Disc. Limit" := 0;
        //     end;
        // }
        // field(2013806; "Sales Amt. Delayed Promo Limit"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Sales Amount Promotion Limit',
        //                 FRA = 'Limite coût vente promotion';
        //     Description = 'DITW15.00.00.26';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008
        //         if "Unlimited Sales Delayed Promo" and ("Sales Amt. Delayed Promo Limit" <> 0) then
        //             ERROR(Text003, FIELDCAPTION("Sales Amt. Delayed Promo Limit"), FIELDCAPTION("Unlimited Sales Delayed Promo"));
        //         if "Sales Amt. Delayed Promo Limit" < 0 then
        //             ERROR(Text005);
        //     end;
        // }
        // field(2013807; "Unlimited Sales Delayed Promo"; Boolean)
        // {
        //     CaptionML = ENU = 'Unlimited Sales Promotion',
        //                 FRA = 'Montant illimité promotion vente autorisé';
        //     Description = 'DITW15.00.00.26';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008
        //         if "Unlimited Sales Delayed Promo" then
        //             "Sales Amt. Delayed Promo Limit" := 0;
        //     end;
        // }
        // field(2013808; "Cost Amt. Delayed Promo Limit"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Cost Amount Promotion Limit',
        //                 FRA = 'Limite coût promotion';
        //     Description = 'DITW15.00.00.26';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008 - DITW15.00.00.34 DDR 05/06/2009
        //         if "Unlimited Cost Delayed Promo" and ("Cost Amt. Delayed Promo Limit" <> 0) then
        //             ERROR(Text003, FIELDCAPTION("Cost Amt. Delayed Promo Limit"), FIELDCAPTION("Unlimited Cost Delayed Promo"));
        //         if "Cost Amt. Delayed Promo Limit" < 0 then
        //             ERROR(Text005);
        //     end;
        // }
        // field(2013809; "Unlimited Cost Delayed Promo"; Boolean)
        // {
        //     CaptionML = ENU = 'Unlimited Cost Promotion',
        //                 FRA = 'Coût promotion illimité autorisé';
        //     Description = 'DITW15.00.00.26';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008 - DITW15.00.00.34 DDR 05/06/2009
        //         if "Unlimited Cost Delayed Promo" then
        //             "Cost Amt. Delayed Promo Limit" := 0;
        //     end;
        // }
        // field(2013812; "Delayed Approver ID"; Code[50])
        // {
        //     CaptionML = ENU = 'Approver ID (Discounts/Promotions)',
        //                 FRA = 'ID approbateur (Remises/Promotions)';
        //     Description = 'DITW15.00.00.26';
        //     TableRelation = "User Setup"."User ID";
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;
        // }
        // field(2013813; "Delayed Substitute"; Code[50])
        // {
        //     CaptionML = ENU = 'Substitute (Discounts/Promotions)',
        //                 FRA = 'Remplaçant (Remises/Promotions)';
        //     Description = 'DITW15.00.00.29';
        //     TableRelation = "User Setup"."User ID";
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;
        // }
        // field(2013816; "Purch. Amt. Delayed Disc. Lmt."; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Purchase Amount Discount  Limit',
        //                 FRA = 'Limite montant remise achat';
        //     Description = 'DITW15.00.00.34';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008
        //         if "Unlimited Purch. Delayed Disc." and ("Purch. Amt. Delayed Disc. Lmt." <> 0) then
        //             ERROR(Text003, FIELDCAPTION("Purch. Amt. Delayed Disc. Lmt."), FIELDCAPTION("Unlimited Purch. Delayed Disc."));
        //         if "Purch. Amt. Delayed Disc. Lmt." < 0 then
        //             ERROR(Text005);
        //     end;
        // }
        // field(2013817; "Unlimited Purch. Delayed Disc."; Boolean)
        // {
        //     CaptionML = ENU = 'Unlimited Purchase Discount',
        //                 FRA = 'Montant illimité remise achat autorisé';
        //     Description = 'DITW15.00.00.34';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008
        //         if "Unlimited Purch. Delayed Disc." then
        //             "Purch. Amt. Delayed Disc. Lmt." := 0;
        //     end;
        // }
        // field(2013818; "Purch. Amt. Delayed Promo Lmt."; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Purchase Amount Promotion Limit',
        //                 FRA = 'Limite coût achat promotion';
        //     Description = 'DITW15.00.00.34';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008
        //         if "Unlimited Purch. Delayed Promo" and ("Purch. Amt. Delayed Promo Lmt." <> 0) then
        //             ERROR(Text003, FIELDCAPTION("Purch. Amt. Delayed Promo Lmt."), FIELDCAPTION("Unlimited Purch. Delayed Promo"));
        //         if "Purch. Amt. Delayed Promo Lmt." < 0 then
        //             ERROR(Text005);
        //     end;
        // }
        // field(2013819; "Unlimited Purch. Delayed Promo"; Boolean)
        // {
        //     CaptionML = ENU = 'Unlimited Purchase Promotion',
        //                 FRA = 'Montant illimité promotion achat autorisé';
        //     Description = 'DITW15.00.00.34';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008
        //         if "Unlimited Purch. Delayed Promo" then
        //             "Purch. Amt. Delayed Promo Lmt." := 0;
        //     end;
        // }
        // field(2013820; "P.Cost Amt. Delayed Promo Lmt."; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Purchase Cost Amount Promotion Limit',
        //                 FRA = 'Limite coût promotion achat';
        //     Description = 'DITW15.00.00.34';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008 - DITW15.00.00.34 DDR 05/06/2009
        //         if "Unlimited P.Cost Delayed Promo" and ("P.Cost Amt. Delayed Promo Lmt." <> 0) then
        //             ERROR(Text003, FIELDCAPTION("P.Cost Amt. Delayed Promo Lmt."), FIELDCAPTION("Unlimited P.Cost Delayed Promo"));
        //         if "P.Cost Amt. Delayed Promo Lmt." < 0 then
        //             ERROR(Text005);
        //     end;
        // }
        // field(2013821; "Unlimited P.Cost Delayed Promo"; Boolean)
        // {
        //     CaptionML = ENU = 'Unlimited Purchase Cost Promotion',
        //                 FRA = 'Coût promotion illimité achat autorisé';
        //     Description = 'DITW15.00.00.34';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.26 DDR 28/10/2008 - DITW15.00.00.34 DDR 05/06/2009
        //         if "Unlimited P.Cost Delayed Promo" then
        //             "P.Cost Amt. Delayed Promo Lmt." := 0;
        //     end;
        // }
        // field(2014410; "Production Resp. Ctr. Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Production Resp. Ctr. Filter',
        //                 FRA = 'Filtre centre gestion vente production';
        //     Description = 'DITW18.00.06 MSF 17/02/2015 DIT-770 #1181';
        //     TableRelation = "Responsibility Center".Code;

        //     trigger OnValidate();
        //     begin
        //         //<<DITW18.00.06 MSF 24/02/2015 DIT-770 #1181
        //         if (Rec."Production Resp. Ctr. Filter" <> xRec."Production Resp. Ctr. Filter") and (Rec."Production Resp. Ctr. Filter" <> '') then
        //             CheckResponsabilityCenteremployee(3);
        //     end;
        // }
        // field(2014411; "Assembly Resp. Ctr. Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Assembly Resp. Ctr. Filter',
        //                 FRA = 'Filtre centre gestion vente assemblage';
        //     Description = 'DITW18.00.06 MSF 17/02/2015 DIT-770 #1181';
        //     TableRelation = "Responsibility Center";

        //     trigger OnValidate();
        //     begin
        //         //<<DITW18.00.06 MSF 24/02/2015 DIT-770 #1181
        //         if (Rec."Assembly Resp. Ctr. Filter" <> xRec."Assembly Resp. Ctr. Filter") and (Rec."Assembly Resp. Ctr. Filter" <> '') then
        //             CheckResponsabilityCenteremployee(4);
        //     end;
        // }
        // field(2014412; "Inventory Resp. Ctr. Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Inventory Resp. Ctr. Filter',
        //                 FRA = 'Filtre Centre de gestion Inventaire';
        //     Description = 'DITW18.00.06 MSF 19/02/2015 DIT-770 #1181';
        //     TableRelation = "Responsibility Center";

        //     trigger OnValidate();
        //     begin
        //         //<<DITW18.00.06 MSF 24/02/2015 DIT-770 #1181
        //         if (Rec."Inventory Resp. Ctr. Filter" <> xRec."Inventory Resp. Ctr. Filter") and (Rec."Inventory Resp. Ctr. Filter" <> '') then
        //             CheckResponsabilityCenteremployee(5);
        //     end;
        // }
        // field(2014413; "Quality Resp. Ctr. Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Quality Resp. Ctr. Filter',
        //                 FRA = 'Filtre Centre de gestion Qualité';
        //     Description = 'DITW18.00.06 MSF 23/02/2015 DIT-770 #1181';
        //     TableRelation = "Responsibility Center";

        //     trigger OnValidate();
        //     begin
        //         //<<DITW18.00.06 MSF 24/02/2015 DIT-770 #1193
        //         if (Rec."Quality Resp. Ctr. Filter" <> xRec."Quality Resp. Ctr. Filter") and (Rec."Quality Resp. Ctr. Filter" <> '') then
        //             CheckResponsabilityCenteremployee(6);
        //     end;
        // }
        // field(2014430; "Purchase Tolerance Limit %"; Decimal)
        // {
        //     CaptionML = ENU = 'Purchase Tolerance Limit %',
        //                 FRA = '% Tolérance limite d''achat';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        // }
        // field(2014431; "Overdue Grace Period"; DateFormula)
        // {
        //     CaptionML = ENU = 'Overdue Grace Period',
        //                 FRA = 'Période de carence échu';
        //     Description = 'DIT-770 #1593';

        //     trigger OnValidate();
        //     begin
        //         //<<DITW110.00.11 MSF 28/12/2017 NRQ#9570
        //         if "Unlimited Overdue Approval" and ("Overdue Grace Period" <> EmptyDateFormula) then
        //             ERROR(Text003, FIELDCAPTION("Overdue Grace Period"), FIELDCAPTION("Unlimited Overdue Approval"));
        //     end;
        // }
        // field(2014432; "Overdue Approver ID"; Code[50])
        // {
        //     CaptionML = ENU = 'Approver ID (Overdue)',
        //                 FRA = 'ID approbateur (échus)';
        //     Description = 'DIT-770 #1714';
        //     TableRelation = "User Setup"."User ID";
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;
        // }
        // field(2014433; "Overdue Substitute"; Code[50])
        // {
        //     CaptionML = ENU = 'Substitute (Overdue)',
        //                 FRA = 'Sbstitue (échus)';
        //     Description = 'DIT-770 #1714';
        //     TableRelation = "User Setup";
        // }
        // field(2014434; "Overdue Amount Approval Limit"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Overdue Amount Approval Limit',
        //                 FRA = 'Limite Monant Echus Approbation';
        //     Description = 'DIT-770 #1714';

        //     trigger OnValidate();
        //     begin
        //         if "Unlimited Overdue Approval" and ("Overdue Amount Approval Limit" <> 0) then
        //             ERROR(Text003, FIELDCAPTION("Overdue Amount Approval Limit"), FIELDCAPTION("Unlimited Overdue Approval"));
        //         if "Overdue Amount Approval Limit" < 0 then
        //             ERROR(Text005);
        //     end;
        // }
        // field(2014435; "Unlimited Overdue Approval"; Boolean)
        // {
        //     CaptionML = ENU = 'Unlimited Overdue Approval',
        //                 FRA = 'Approbation Echus Illimité';
        //     Description = 'DIT-770 #1714';

        //     trigger OnValidate();
        //     begin
        //         if "Unlimited Overdue Approval" then
        //             //<< DITW110.00.11 MSF 28/12/2017 NRQ#9570
        //             "Overdue Grace Period" := EmptyDateFormula;
        //         //>>DITW110.00.11 MSF 28/12/2017 NRQ#9570
        //     end;
        // }
        // field(2014448; "Max. Credit Limit Customer"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Max. Credit Limit Customer (LCY)',
        //                 FRA = 'Limite crédit client max. DS';
        //     Description = 'DITW15.00.00.32';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.32 DDR 20/03/2009 - DITW15.00.00.35 DDR 18/08/2009
        //         if "Max. Credit Limit Customer" < 0 then
        //             ERROR(Text005);
        //     end;
        // }
        // field(2014449; "Exceed Credit Limit Customer"; Decimal)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Exceed Credit Limit Customer (LCY)',
        //                 FRA = 'Alerte client crédit dépassement DS';
        //     Description = 'DITW15.00.00.32';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.32 DDR 20/03/2009
        //         if "Unlimited Cr. Limit Customer" and ("Exceed Credit Limit Customer" <> 0) then
        //             ERROR(Text003, FIELDCAPTION("Exceed Credit Limit Customer"), FIELDCAPTION("Unlimited Cr. Limit Customer"));
        //         if "Exceed Credit Limit Customer" < 0 then
        //             ERROR(Text005);
        //     end;
        // }
        // field(2014450; "Unlimited Cr. Limit Customer"; Boolean)
        // {
        //     CaptionML = ENU = 'Unlimited Exceed Credit Limit Customer',
        //                 FRA = 'Limite crédit dépassement illimité client autorisé';
        //     Description = 'DITW15.00.00.32';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.32 DDR 20/03/2009 - DITW15.00.00.35 DDR 18/08/2009
        //         if "Unlimited Cr. Limit Customer" then begin
        //             "Exceed Credit Limit Customer" := 0;
        //         end;
        //     end;
        // }
        // field(2014452; "Credit Limit Approver ID"; Code[50])
        // {
        //     CaptionML = ENU = 'Approver ID (Credit Limit)',
        //                 FRA = 'ID approbateur (Limite crédit)';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "User Setup"."User ID";
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;
        // }
        // field(2014470; "Product Posting Group Filter"; Text[250])
        // {
        //     CaptionML = ENU = 'Product Posting Group Filter',
        //                 FRA = 'Filtre groupe compta produit';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        // }
        // field(2014471; "Dimension Fiter"; Boolean)
        // {
        //     CalcFormula = Exist("User Dimension Filter" where("User ID" = FIELD("User ID")));
        //     CaptionML = ENU = 'Dimension Filter',
        //                 FRA = 'Filtre Dimension';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014472; "Location Filter"; Text[250])
        // {
        //     CaptionML = ENU = 'Location Filter',
        //                 FRA = 'Filtre magasin';
        //     Description = 'DITW17.00.02 DIT-770 #144';
        // }
        // field(2029610; "Allow Modify G/L Entry"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Modify G/L Entry',
        //                 FRA = 'Écritures comptables autorisé à changer';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029611; TEST; Integer)
        // {
        //     Caption = 'TEST';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029612; "TEST NAME"; Code[10])
        // {
        //     Caption = 'Nom test';
        //     Description = 'FINXL7.00.001';
        // }
        // field(2029613; "Receive Other Pay-to Vendor"; Boolean)
        // {
        //     CaptionML = ENU = 'Receive From Different Pay-to Vendor',
        //                 FRA = 'Recevoir à partir de Different Fournisseurs à payer';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029614; "Ship Other Bill-to Customer"; Boolean)
        // {
        //     CaptionML = ENU = 'Ship Other Bill-to Customer',
        //                 FRA = 'Livrer Autre Client Facturé';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029615; "Change VAT Bus Group on Inv"; Boolean)
        // {
        //     Caption = 'Change VAT Bus. Posting Group on Invoice';
        //     Description = 'FINXL9.00.000.01';
        // }
        // field(2034640; "Release Customer"; Boolean)
        // {
        //     CaptionML = ENU = 'Release Customer',
        //                 FRA = 'Lancer client';
        //     Description = 'DITW17.00.02 SR DIT-770 #143';
        // }
        // field(2034641; "Release Vendor"; Boolean)
        // {
        //     CaptionML = ENU = 'Release Vendor',
        //                 FRA = 'Lancer fournisseur';
        //     Description = 'DITW17.00.02 SR DIT-770 #143';
        // }
        // field(2034642; "Release Item"; Boolean)
        // {
        //     CaptionML = ENU = 'Release Item',
        //                 FRA = 'Lancer article';
        //     Description = 'DITW17.00.02 SR DIT-770 #143';
        // }
        // field(2034955; "PM. Customer Filter"; Code[20])
        // {
        //     CaptionML = ENU = 'Plant Filter',
        //                 FRA = 'Filtre Usine';
        //     Description = 'DITW16.00.00.41 DIT-715 #436';
        //     TableRelation = Customer where("Plant Maintenance Plant" = CONST(true));
        //     ValidateTableRelation = true;

        //     trigger OnValidate();
        //     var
        //         DefaultDim: Record "Default Dimension";
        //     begin
        //     end;
        // }
        // field(2034987; "Printer For Attachments"; Text[250])
        // {
        //     CaptionML = ENU = 'Printer for attachments',
        //                 FRA = 'Imprimant pour attachments';
        //     Description = 'DITW16.00.00.42 DIT-715 #435';
        //     TableRelation = Printer;
        // }
        // field(2036301; "Default Routing Link Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Default Routing Link Code',
        //                 FRA = 'Code lien gamme par défaut';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = "Routing Link";
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NotificationSetup.SETRANGE("User ID","User ID");
    NotificationSetup.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    NotificationSetup.SETRANGE("User ID","User ID");
    NotificationSetup.DELETEALL(true);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text001(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=The %1 Salesperson/Purchaser code is already assigned to another User ID %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=The %1 Salesperson/Purchaser code is already assigned to another User ID %2.;FRA=Le code vendeur/acheteur %1 est déjà attribué à un autre code utilisateur %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU="You cannot have both a %1 and %2. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU="You cannot have both a %1 and %2. ";FRA="Vous ne pouvez pas avoir à la fois un %1 et un %2. ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You cannot have approval limits less than zero.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot have approval limits less than zero.;FRA=Vous ne pouvez pas avoir de limite d'approbation inférieure à zéro.;
    //Variable type has not been exported.

    procedure InitDefaults()
    begin
        // <<DITW18.00.06A DDR 23/11/2015 DIT-770 #1714
        INIT;
        // general
        // BC Upgrade PATELS08 >> # Blocked DIT FIELDS
        // "Release Customer" := TRUE; 
        // "Release Vendor" := TRUE;
        // BC Upgrade PATELS08 <<
        "Release Item FND" := TRUE;

        // approval
        "Unlimited Sales Approval" := TRUE;
        "Unlimited Purchase Approval" := TRUE;
        //HEI.29>>
        "Unlimited Journ.Approval FND" := TRUE;
        //HEI.29<<
        "Unlimited Request Approval" := TRUE;

        // BC Upgrade PATELS08 >> # Blocked DIT FIELDS
        // "Unlimited Deposit Limit Cust." := TRUE; DIT
        // "Unlimited Sales Delayed Disc." := TRUE;
        // "Unlimited Sales Delayed Promo" := TRUE;
        // "Unlimited Cost Delayed Promo" := TRUE;
        // "Unlimited Purch. Delayed Disc." := TRUE;
        // "Unlimited Purch. Delayed Promo" := TRUE;
        // "Unlimited P.Cost Delayed Promo" := TRUE;
        // "Unlimited Overdue Approval" := TRUE;
        // "Unlimited Cr. Limit Customer" := TRUE; DIT
        // "Deposit Limit Approver ID" := USERID; DIT
        // "Delayed Approver ID" := USERID;
        // "Overdue Approver ID" := USERID;
        // "Credit Limit Approver ID" := USERID; DIT
        // BC Upgrade PATELS08 <<

        "Approver ID" := USERID;
    end;

    // BC UPGRADE PATELS08 >> HEI.29
    procedure GetDefaultJournalAmountApprovalLimit() : Integer
    var
        UserSetup: Record "User Setup";
        DefaultApprovalLimit: Integer;
        LimitedApprovers: Integer;
    begin
        //HEI.29>>
        UserSetup.SETRANGE("Unlimited Journ.Approval FND",FALSE);
        IF UserSetup.FINDFIRST THEN BEGIN
        DefaultApprovalLimit := UserSetup."Journal Amt Approval Limit FND";
        LimitedApprovers := UserSetup.COUNT;
        UserSetup.SETRANGE("Journal Amt Approval Limit FND",DefaultApprovalLimit);
        IF LimitedApprovers = UserSetup.COUNT THEN
            EXIT(DefaultApprovalLimit);
        END;
        // Return 0 if no user setup exists or no default value is found
        EXIT(0);
        //HEI.29<<
    end;
    // BC UPGRADE PATELS08 <<

    var
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        EmptyDateFormula: DateFormula;
        Text2014410: TextConst ENU = 'You should delete values from %1 for type %2 first', FRA = 'Vous devez supprimer les valeurs de %1 pour le type %2 premier';

        // BC UPGRADE PATELS08 >> HEI.29
        Text003: Label 'You cannot have both a %1 and %2.';
        Text005: Label 'You cannot have approval limits less than zero.';
        Text001: Label 'The %1 Salesperson/Purchaser code is already assigned to another User ID %2.';
        // BC UPGRADE PATELS08 <<
}

