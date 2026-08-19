tableextension 50028 VendorExtFND extends Vendor
{
    // version NAVW110.0.00.16996,FINXL10.01,QXL9.00.001,IPLXL9.00.001,DITW110.00.11,HEI.24,SB
    //     DITW15.00.00.01 DDR 21/12/2007 added fields
    //                                  2034647 Drink Tax Group Code
    // DITW15.00.00.01 DDR 02/01/2008 rename field
    //                                  2034647 Vendor DTax Group Code + Filter to the source table
    // DITW15.00.00.01 DDR 03/01/2008 addded fields
    //                                  2013610 Item DDeposit Group Code
    // DITW15.00.00.01 DDR 07/01/2008 caption field "Vendor DDeposit Group Code"
    // DITW15.00.00.01 DDR 21/01/2008 added fields
    //                                 2013762 No. of Drink Disc. Groups
    //                                 2013765 No. of Promotion Groups
    // DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                Added fields
    //                                  2034690 Price Incl. Reversing Calc.
    // DITW15.00.00.01 DDR 27/02/2008 Remove field
    //                                  2034690 Price Incl. Reversing Calc.
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.23 DDR 01/08/2008 Added Drink-it groups to delete when a vendor is deleted
    // DITW15.00.00.24 DDR 07/10/2008 Added fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.25 DDR 21/10/2008 Deleted fields
    //                                  2013722 Duty Tax Type
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013726 Tax Registration No.
    //                                  2013730 Fiscal Representative No.
    // DITW15.00.00.32 DDR 06/04/2009 Added fields
    //                                  2013753 AAD Std. Text (Area 23) Code
    // DITW15.00.00.33 DDR 08/05/2009 Added text contant Text2013660
    //                                Added functions
    //                                  IsNeedTaxReg(),TestMsgTaxRegistration()
    //                     11/05/2009 Removed field "AAD Std. Text (Area 23) Code" into Drink-It tab
    //                     12/05/2009 Correct function TestMsgTaxRegistration()
    // DITW15.00.00.34 DDR 09/07/2009 Added warning when select a Vendor Drink Tax Group within Tax registration mandatory
    // DITW15.00.00.35 DDR 17/08/2009 Added fields
    //                                  2013823 Gen. Bus. Posting Free Group
    //                                  2013825 Free Item Posting Type
    //                     09/10/2009 issue 848 Copy "Gen. Prod. Posting Group" by default while empty "Gen. Prod. Posting Free Group"
    //                     26/10/2009 issue 924 Rename captions + optioncaptions
    //                                  "Free Item Posting Type" -> "Calculate Price on Free"
    //                                    ' ,Price,Amount' -> 'Full Amount,Price 0,Discount 100%'
    //                     09/09/2009 Added fields
    //                                  2034873 Contract Cust. Posting Group
    //                                  2034905 Contract Gain/Loss Amount
    //                                  2034906 Order Address Filter
    //                                  2034907 Outstanding Serv. Orders (LCY)
    //                                  2034908 Serv Shipped Not Invoiced(LCY)
    //                     23/09/2009 issue 814 Split Vendor posting group per contract type (+ copy default value)
    //                                  Added fields
    //                                    2034910 Contract Vend. Post. Gr. Rent
    //                                    2034911 Contract Vend. Post. Gr. Loan
    //                                    2034912 Contract Vend. Post. Gr. LoanU
    //                                    2034913 Contract Vend. Post. Gr. Maint
    //                                    2034914 Contract Vend. Post. Gr. Other
    //                                  Rename field2034873 Contract Vend. Posting Group -> Contract Vend. Post. Gr. Stand
    //                                  Added functions
    //                                    GetContractPostingGr(),TestContractPostingGr()
    //                      01/10/2009 issue 859 Wrong TableRelation on fields 2034910 to 2034914
    // DITW15.00.00.37 DDR 27/01/2010 issue 1036 Add function GetFieldCaptionContractPostingGr()
    //                     02/04/2010 issue 1110 Added fields
    //                                  2014101 Transport Time
    //                     01/06/2010 issue 857 Added fields
    //                                            2034850 DIT Sub-Contract Type Filter
    //                                            2034872 Contract Group Filter
    //                                          Added TableRelation for field2034872
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014271 Tax Warehouse Reference
    //                                    2014487 Transaction Type
    //                                    2014488 Transport Method
    //                                    2014489 Transaction Specification
    //                                    2014490 Entry Point  (= Exit Point)
    //                                    2014491 Area Code
    //                                    2014492 Vendor Template Code
    //                                    2014075 Shipping Agent Code
    //                                    2014076 Shipping Agent Service Code
    //                                    2014087 Distance
    //                                  Added functions TestMandatoryFieldTemplate()
    //                     17/09/2010   Added fields
    //                                    2014460 Tax Office Code
    //                     04/01/2011 issue 1217 (DIT711 105) Modified to check the Tax Registration no.
    //                     27/01/2011 issue 1217 (DIT711 137) Modified Caption field2013730 "Fiscal Representative No."
    //                     01/02/2011 issue 941 Modified OptionCaption property field2013825 "Free Item Posting Type"
    //                 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     27/07/2011 issue 1407
    //                                  Added fields
    //                                   2013666 Autom. Item Charge
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    //                     16/08/2011 issue 1407 Added optionstring field2013666 Autom. Item Charge
    //                     29/08/2011 issue 1396 Item Exclusivity functionnality
    //                                  Added fields
    //                                    2014423 No. of Exclusivity Groups
    //                     30/08/2011 issue 1397 Modified Calcformula, added "DIT Sub-Contract Type Filter" flowfilter
    //                                             field58 "Balance"
    //                                             field59 "Balance (LCY)"
    //                                             field60 "Net Change"
    //                                             field61 "Net Change (LCY)"
    //                                             field66 "Balance Due"
    //                                             field67 "Balance Due (LCY)"
    //                     28/10/2011 issue 1457 Modified many ML captions
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                             Added 'PlantMaintenance' option field2034850 "DIT Sub-Contract Type Filter"
    //                 AHU 03/08/2012 DIT-715 #327 Added fields
    //                                               2034850 DIT Sub-Contract Type Filter
    //                                               2034915 Contract DIT Filter
    //                                               2014312 DIT Sub-Contract Posting Type
    //                                             Modified 'CalcFormula' property fields
    //                                               field58 "Balance"
    //                                               field59 "Balance (LCY)"
    //                                               field60 "Net Change"
    //                                               field61 "Net Change (LCY)"
    //                                               field66 "Balance Due"
    //                                               field67 "Balance Due (LCY)"
    // DITW16.00.00.41 AHU 07/08/2012 DIT-715 #327 Added functions DrillDownContractBalanceLCY(),CalcContractBalanceLCY()
    //                                             Modified function DrillDownContractBalanceLCY() open Ledger entry form
    //                 AHU 13/08/2012 DIT-715 #327 Renamed Captions all Contract Vend. Post. Gr. fields
    //                                             Added to transfer all Contract Posting Group fields from vendor Template record
    //                 AHU 06/11/2012 DIT-715 #327 Bugfix to transfer template fields into vendor (after renaming)
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields
    //                                               2013630 Deposit Vendor Posting Group
    //                                               2013631 Deposit Payment Terms Code
    //                                               2013632 Deposit Payment Method Code
    //                                               2013636 Split Deposit on Invoice
    //                                               2013637 Deposit Vend. Balance (LCY)
    //                                               2013695 Item Charge Type Filter
    //                                             Added keys
    //                                               "Vendor DDeposit Group Code"
    //                                               "Vendor DTax Group Code"
    //                     11/12/2012 DIT-715 #370 Added to copy default "Payment Terms Code","Payment Method Code" when split deposit

    // FINXL7.00.001 RBE 20/03/2013 : Added check for VAT Validation
    // FINXL7.00.001 WSA 15/07/2014 #88 : Removed fct check for VAT Validation
    // FINXL8.00.001 BSA 05/06/2015 #182 : Added Field "Allow Emergency Orders"

    // DITW17.00.02 DDR 04/07/2013 DIT-770 #99 Added fields
    //                                           2014560 GWC Country/Region Code
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99
    // DITW17.00.02 SR 10/09/2013 DIT-770 #143 : block on changes
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "2035390" Added
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 27/11/2013 DIT-770 #187 : New Code Addde to Comment Blocking.
    // DITW17.00.02 AT  17/12/2013 DIT-770 #163 : Added fields
    //                                   2034851 Loan Interest Vend. Post. Grp.
    //                                   2034852 Bank Charge Vend. Post. Grp.
    //                                   2034943 Vendor Posting Group Filter
    // DITW17.10.03 AT  05/02/2014 DIT-770 #340 : Correction in TableRelation of
    //                                   2034851 Loan Interest Vend. Post. Grp.
    //                                   2034852 Bank Charge Vend. Post. Grp.
    // DIT17.10.03 MSF  06/04/2014 DIT-770 #340 : Added Filter "Vendor Posting Group"  on FlowField
    // DITW17.10.03 MSF 08/04/2014 DIT-770 #340 : DIT-770 340 Variable customer posting group
    //                                            Copy fields from Vendor template to  Vendor
    //                                            Remove field 2034852 "Bank Charge Vend. Post. Grp." (Point 12)
    // DITW17.10.03 MSF 08/05/2014 DIT-770 #340 : Copy default vendor posting group
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.05 MSF 24/07/14 DIT-770 #723 : Error message while modifying customer template code in customer card
    // DITW17.10.05 WSA 21/08/2014 DIT-770 #723 Modified confirmation message and copying from vendor template
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename Table "Contract Header DIT" to "Financial Contract Header"
    // DITW18.00.06 DDR 07/08/2015 DIT-770 #1368 Various adjustments
    // DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Added field 2014422 "Sundry Vendor"
    // DITW18.00.07 VSC 16/02/2016 DIT-770 #1755 Missing customer's licence check
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Fixed caption for field "Sundry Vendor"
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    // FINXL8.00.001 IMI 10/06/2015: Added key GLN
    //               IMI 11/08/2015: Added field "Interface Partner"
    // DITW18.00.07 AKH 20/04/2016 DIT-770 #1941 Added fields 2014120 "Buy-from/Pay-to DTax Gr. Calc."
    //                                                        2014429 "Buy-from/Pay-to Prices Calc."
    //                                           Added functions GetVendNoCalcPrices() & GetVendNoCalcTaxes()
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field 2014060 "Vendor Delivery Type"
    // DITW18.00.07 VSC 12/05/2016 DIT-770 #1971 Synch Order limits sales to purchase (in order and Route Planning)
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977 Default & Mandatory Route setup + Route default values + shipment date calculation
    // DITW18.00.07 VSC 26/05/2016 DIT-770 #1976 -> #1002 Added Fields "Minimum Cubage" and "Minimum Weight"
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.08 AKH 16/12/2016 BL#9797 (DIT-770 #1679) Added new validation rules for Route, Location and Responsibility Center

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // IPLXL9.00.001 IMI 10/06/2015: Added GLN key
    // IPLXL9.00.001 IMI 11/08/2015: Added field "Interface Partner"
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // FINXL10.01 AKH 19/07/2017 NRQ#33089 Added code to autocreate vendor dimension
    // FINXL10.01 AKH 28/07/2017 NRQ#33089 Fixed bug on renaming vendors
    //                                     Changed "Value Posting" of the inserted dimension to blanck
    // DITW110.00.11 ASA 19/10/2017 NRQ#14403 Fixed bug on "Deposit Vend. Balance (LCY)" change Flowfield Formula based on Detailed Vendor Entries
    // DITW110.00.11 MSF 07/11/2017 NRQ#13577 Autoblock Customer, Item, Vendor card based on setup
    // DITW110.00.11 MSF 08/11/2017 NRQ#13577 Several Adjustment
    //                                  Modify text Caption  Text2014412 'ENU=Operation not allowed' --> 'ENU=You are not allowed to release a Vendor (user setup)';
    // DITW110.00.11 MSF 15/11/2017 NRQ#39758 Added fields :
    //                                                       Balance (LCY) (INV.)
    //                                                       Balance (LCY) (CM/PMT)
    // DITW110.00.11 MSF 15/11/2017 NRQ#39758 Filter on Initial Document type instead of Document type

    // HEI.01 FDD-* IBM LAZARE02 29.06.2017 # New field Blocked Reason Code
    // HEI.02 FDD–PURGAP05 IBM LAZARE02 30.06.2017
    //   # Change caption of field E-mail to Email Procurement
    //   # New fields for MDM integration
    //   # Extended length of City to 35; Extend fields Address and Address 2 to 60 characters; Added option Order to field Blocked
    //   # Call function OnCheckBlockedVendOnDocs
    // HEI.03 FDD-SLSGAP001 IBM POENAB01 17.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    //   HEI.04 FDD-PTPGAP007 IBM PATHAA02
    //   # Code written on "Preferred Bank account"-OnValidate to block the Vendor for missing bank details---removed-05.10.17
    //   # Code written on "Payment Method Code" to validate if there is atleast one bank
    //   # Code written on "Payment Method Code"-OnValidate to check all the banks for mandatory fields-05.10.17
    //   # Preferred Bank Account Code field made noneditable //05.10.17
    //   # Removed code On Insert 'MBD'-051017
    //   # Code Added Blocked-OnValidate
    //   # Code Added "Blocked Reason Code"-OnValidate
    // HEI.05 FDD-PURGAP05 IBM LAZARE02 09.08.2017 # Add logic for Global Delete = Yes

    // HEI.07 RFC257- IBM PATHAA02 25.01.18
    // # Commented the code which blocks the vendor if payment method has "mandatory bank details" checked
    //   and also missing bank details
    // HEI.08 FDD PTPGAP084 IBM POSTOI01 05.04.2018
    //   # rename field 50003 from Sensitive Block into Sensitive Payment Block
    //   # create new field 50053 Sensitive Workflow Blocksame as Sensitive Payment Block
    //   # modify function CheckBlockedVendOnJnls
    // HEI.09 SOICAD new field Purchase Concept
    // HEI.10 CHG0245208 IBM LAZARE02 09.07.2018 - new field Send to Maximo

    // HEI.11 IBM.NAIKH01 , 16.10.2018, FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 and BRD V4.02 25-07-2018_Local Vendor type-Vendor Category and label Vendor
    //   # Added a new field 50057-"Local Vendor Type"

    // HEI.12 FDDPTPGAPLOG01 IBM ISYED01 Remittance advaice.
    //   #added new filed "Remittance emial" to vendor
    // HEI.13 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01
    //   # new key : Blocked
    // HEI.14 FDD-PURGAP033 IBM BULIMC01 27.02.2019 - the Vendor Category field type changed and related to Vendor Category table.
    // HEI.16 FDD-HT658 IBM.GUNERE01 23.09.2019 # "No. of Shipping Agent Rel." field added
    // HEI.17 FDD-HT545 IBM POSTOI01 08.10.2019
    //   # create new field 50059 Self-Billing Boolean type
    // HEI.18 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields added
    //     # 10860Payment in progress (LCY)
    // HEI.19 CHG2019432 IBM SHANKJ03  03.23.2021
    //  # Removed Remittence email field (50056)
    // DITW110.00.11 ASA 13/11/2017 NRQ#18375 Disable Code OnValidate Route & "Responsibility Center"
    // HEI.20 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # Default SPL Code - field created
    // HEI.21 CHG2162715 HB3020 NORRIQ KOROLA04 14.11.2022
    //   # Default SPL Code - field changed
    // HEI.22 HEI.02 CHG2210794 MAJUMS03 22.01.2024 Zycus - BASE HL Integration Master Vendor and GL Account. (*RLPPD)
    //   # New Function "UpdateLocaltimestamp" is added.
    //   # Code added.
    // HEI.23 CHG2210794 MAJUMS03 13.05.2024 Zycus - BASE HL Integration - Vendor GL Account Development Rework.
    //   # Code added.
    // HEI.24 CHG2210794 MAJUMS03 04.09.2024 Zycus - BASE HL Integration - Vendor GL Account Development Finetuning.
    //   # Code added.
    //   # New Function "CheckZycusEnable" is added
    // HEI.25 CHG2317685 SAHAL01 17.10.2025 Block Functionality Enhancement for Vendors
    //   # Commented Code

    // BC Upgrade SHUKLP03 >>
    // Procedure UpdateLocaltimestamp() and CheckZycusEnable() added in Interface extension.
    // OnInsert, OnModify, OnDelete, OnRename code is added in Interface extension.
    // BC Upgrade SHUKLP03 <<


    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Search Name")
        {
            CaptionML = ENU = 'Search Name', FRA = 'Nom de recherche';
        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {

            //Unsupported feature: Change Data type on "Address(Field 5)". Please convert manually.

            CaptionML = ENU = 'Address', FRA = 'Adresse';

            //Unsupported feature: Change Description on "Address(Field 5)". Please convert manually.

        }
        modify("Address 2")
        {

            //Unsupported feature: Change Data type on ""Address 2"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Street 2', FRA = 'Adresse (2ème ligne)';

            //Unsupported feature: Change Description on ""Address 2"(Field 6)". Please convert manually.

        }
        modify(City)
        {

            //Unsupported feature: Change Data type on "City(Field 7)". Please convert manually.


            //Unsupported feature: Change TableRelation on "City(Field 7)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change Description on "City(Field 7)". Please convert manually.

        }
        modify(Contact)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Phone No.")
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone';
        }
        modify("Telex No.")
        {
            CaptionML = ENU = 'Telex No.', FRA = 'N° télex';
        }
        modify("Our Account No.")
        {
            CaptionML = ENU = 'Our Account No.', FRA = 'Notre n° cpte/fourn.';
        }
        modify("Territory Code")
        {
            CaptionML = ENU = 'Territory Code', FRA = 'Code secteur';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Budgeted Amount")
        {
            CaptionML = ENU = 'Budgeted Amount', FRA = 'Montant budgété';
        }
        modify("Vendor Posting Group")
        {
            CaptionML = ENU = 'Vendor Posting Group', FRA = 'Groupe compta. fournisseur';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Statistics Group")
        {
            CaptionML = ENU = 'Statistics Group', FRA = 'Groupe statistiques';
        }
        modify("Payment Terms Code")
        {
            CaptionML = ENU = 'Payment Terms Code', FRA = 'Code condition paiement';
        }
        modify("Fin. Charge Terms Code")
        {
            CaptionML = ENU = 'Fin. Charge Terms Code', FRA = 'Code condition intérêts';
        }
        modify("Purchaser Code")
        {

            //Unsupported feature: Change TableRelation on ""Purchaser Code"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Purchaser Code', FRA = 'Code acheteur';
        }
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Invoice Disc. Code")
        {
            CaptionML = ENU = 'Invoice Disc. Code', FRA = 'Code remise facture';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 35)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 38)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
            // OptionCaptionML = ENU = ' ,Payment,All,,,,Order', FRA = ' ,Règlement,Tous,,,,Order';

            //Unsupported feature: Change OptionString on "Blocked(Field 39)". Please convert manually.

        }
        modify("Pay-to Vendor No.")
        {
            CaptionML = ENU = 'Pay-to Vendor No.', FRA = 'N° fournisseur à payer';
        }
        modify(Priority)
        {
            CaptionML = ENU = 'Priority', FRA = 'Priorité';
        }
        modify("Payment Method Code")
        {
            CaptionML = ENU = 'Payment Method Code', FRA = 'Code mode de règlement';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Global Dimension 1 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Filter"(Field 56)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Filter', FRA = 'Filtre axe principal 1';
        }
        modify("Global Dimension 2 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Filter"(Field 57)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Filter', FRA = 'Filtre axe principal 2';
        }
        modify(Balance)
        {

            //Unsupported feature: Change CalcFormula on "Balance(Field 58)". Please convert manually.

            CaptionML = ENU = 'Balance', FRA = 'Solde';

            //Unsupported feature: Change Description on "Balance(Field 58)". Please convert manually.

        }
        modify("Balance (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Balance (LCY)"(Field 59)". Please convert manually.

            CaptionML = ENU = 'Balance (LCY)', FRA = 'Solde DS';

            //Unsupported feature: Change Description on ""Balance (LCY)"(Field 59)". Please convert manually.

        }
        modify("Net Change")
        {

            //Unsupported feature: Change CalcFormula on ""Net Change"(Field 60)". Please convert manually.

            CaptionML = ENU = 'Net Change', FRA = 'Solde période';

            //Unsupported feature: Change Description on ""Net Change"(Field 60)". Please convert manually.

        }
        modify("Net Change (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Net Change (LCY)"(Field 61)". Please convert manually.

            CaptionML = ENU = 'Net Change (LCY)', FRA = 'Solde période DS';

            //Unsupported feature: Change Description on ""Net Change (LCY)"(Field 61)". Please convert manually.

        }
        modify("Purchases (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Purchases (LCY)"(Field 62)". Please convert manually.

            CaptionML = ENU = 'Purchases (LCY)', FRA = 'Achats DS';

            //Unsupported feature: Change Description on ""Purchases (LCY)"(Field 62)". Please convert manually.

        }
        modify("Inv. Discounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Inv. Discounts (LCY)"(Field 64)". Please convert manually.

            CaptionML = ENU = 'Inv. Discounts (LCY)', FRA = 'Remises facture DS';

            //Unsupported feature: Change Description on ""Inv. Discounts (LCY)"(Field 64)". Please convert manually.

        }
        modify("Pmt. Discounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Pmt. Discounts (LCY)"(Field 65)". Please convert manually.

            CaptionML = ENU = 'Pmt. Discounts (LCY)', FRA = 'Escomptes DS';

            //Unsupported feature: Change Description on ""Pmt. Discounts (LCY)"(Field 65)". Please convert manually.

        }
        modify("Balance Due")
        {

            //Unsupported feature: Change CalcFormula on ""Balance Due"(Field 66)". Please convert manually.

            CaptionML = ENU = 'Balance Due', FRA = 'Solde dû';

            //Unsupported feature: Change Description on ""Balance Due"(Field 66)". Please convert manually.

        }
        modify("Balance Due (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Balance Due (LCY)"(Field 67)". Please convert manually.

            CaptionML = ENU = 'Balance Due (LCY)', FRA = 'Solde dû DS';

            //Unsupported feature: Change Description on ""Balance Due (LCY)"(Field 67)". Please convert manually.

        }
        modify(Payments)
        {

            //Unsupported feature: Change CalcFormula on "Payments(Field 69)". Please convert manually.

            CaptionML = ENU = 'Payments', FRA = 'Paiements';

            //Unsupported feature: Change Description on "Payments(Field 69)". Please convert manually.

        }
        modify("Invoice Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Invoice Amounts"(Field 70)". Please convert manually.

            CaptionML = ENU = 'Invoice Amounts', FRA = 'Montants factures';

            //Unsupported feature: Change Description on ""Invoice Amounts"(Field 70)". Please convert manually.

        }
        modify("Cr. Memo Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Cr. Memo Amounts"(Field 71)". Please convert manually.

            CaptionML = ENU = 'Cr. Memo Amounts', FRA = 'Montants avoirs';

            //Unsupported feature: Change Description on ""Cr. Memo Amounts"(Field 71)". Please convert manually.

        }
        modify("Finance Charge Memo Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Finance Charge Memo Amounts"(Field 72)". Please convert manually.

            CaptionML = ENU = 'Finance Charge Memo Amounts', FRA = 'Montants intérêts de retard';

            //Unsupported feature: Change Description on ""Finance Charge Memo Amounts"(Field 72)". Please convert manually.

        }
        modify("Payments (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Payments (LCY)"(Field 74)". Please convert manually.

            CaptionML = ENU = 'Payments (LCY)', FRA = 'Paiements DS';

            //Unsupported feature: Change Description on ""Payments (LCY)"(Field 74)". Please convert manually.

        }
        modify("Inv. Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Inv. Amounts (LCY)"(Field 75)". Please convert manually.

            CaptionML = ENU = 'Inv. Amounts (LCY)', FRA = 'Montants factures DS';

            //Unsupported feature: Change Description on ""Inv. Amounts (LCY)"(Field 75)". Please convert manually.

        }
        modify("Cr. Memo Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Cr. Memo Amounts (LCY)"(Field 76)". Please convert manually.

            CaptionML = ENU = 'Cr. Memo Amounts (LCY)', FRA = 'Montants avoirs DS';

            //Unsupported feature: Change Description on ""Cr. Memo Amounts (LCY)"(Field 76)". Please convert manually.

        }
        modify("Fin. Charge Memo Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Fin. Charge Memo Amounts (LCY)"(Field 77)". Please convert manually.

            CaptionML = ENU = 'Fin. Charge Memo Amounts (LCY)', FRA = 'Montants int. retard DS';

            //Unsupported feature: Change Description on ""Fin. Charge Memo Amounts (LCY)"(Field 77)". Please convert manually.

        }
        modify("Outstanding Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Orders"(Field 78)". Please convert manually.

            CaptionML = ENU = 'Outstanding Orders', FRA = 'Commandes ouvertes';
        }
        modify("Amt. Rcd. Not Invoiced")
        {

            //Unsupported feature: Change CalcFormula on ""Amt. Rcd. Not Invoiced"(Field 79)". Please convert manually.

            CaptionML = ENU = 'Amt. Rcd. Not Invoiced', FRA = 'Montant reçu non facturé';
        }
        modify("Application Method")
        {
            CaptionML = ENU = 'Application Method', FRA = 'Mode de lettrage';
            //OptionCaptionML = ENU = 'Manual,Apply to Oldest', FRA = 'Manuel,Au plus ancien';
        }
        modify("Prices Including VAT")
        {
            CaptionML = ENU = 'Prices Including VAT', FRA = 'Prix TTC';
        }
        modify("Fax No.")
        {
            CaptionML = ENU = 'Fax No.', FRA = 'N° télécopie';
        }
        modify("Telex Answer Back")
        {
            CaptionML = ENU = 'Telex Answer Back', FRA = 'Télex retour';
        }
        modify("VAT Registration No.")
        {
            CaptionML = ENU = 'VAT Registration No.', FRA = 'N° identif. intracomm.';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        // modify(Picture)
        // {
        //     CaptionML = ENU = 'Picture', FRA = 'illustration';
        // }//sharmp16 replaced by image field
        modify(GLN)
        {
            CaptionML = ENU = 'GLN', FRA = 'GLN';
        }
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 91)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("Debit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Debit Amount"(Field 97)". Please convert manually.

            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';

            //Unsupported feature: Change Description on ""Debit Amount"(Field 97)". Please convert manually.

        }
        modify("Credit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount"(Field 98)". Please convert manually.

            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';

            //Unsupported feature: Change Description on ""Credit Amount"(Field 98)". Please convert manually.

        }
        modify("Debit Amount (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Debit Amount (LCY)"(Field 99)". Please convert manually.

            CaptionML = ENU = 'Debit Amount (LCY)', FRA = 'Montant débit DS';

            //Unsupported feature: Change Description on ""Debit Amount (LCY)"(Field 99)". Please convert manually.

        }
        modify("Credit Amount (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount (LCY)"(Field 100)". Please convert manually.

            CaptionML = ENU = 'Credit Amount (LCY)', FRA = 'Montant crédit DS';

            //Unsupported feature: Change Description on ""Credit Amount (LCY)"(Field 100)". Please convert manually.

        }
        modify("E-Mail")
        {
            CaptionML = ENU = 'Email Procurement', FRA = 'Adresse e-mail';
        }
        modify("Home Page")
        {
            CaptionML = ENU = 'Home Page', FRA = 'Page d''accueil';
        }
        modify("Reminder Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Reminder Amounts"(Field 104)". Please convert manually.

            CaptionML = ENU = 'Reminder Amounts', FRA = 'Montants relances';

            //Unsupported feature: Change Description on ""Reminder Amounts"(Field 104)". Please convert manually.

        }
        modify("Reminder Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Reminder Amounts (LCY)"(Field 105)". Please convert manually.

            CaptionML = ENU = 'Reminder Amounts (LCY)', FRA = 'Montants relances DS';

            //Unsupported feature: Change Description on ""Reminder Amounts (LCY)"(Field 105)". Please convert manually.

        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("Currency Filter")
        {
            CaptionML = ENU = 'Currency Filter', FRA = 'Filtre devise';
        }
        modify("Outstanding Orders (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Orders (LCY)"(Field 113)". Please convert manually.

            CaptionML = ENU = 'Outstanding Orders (LCY)', FRA = 'Commandes ouvertes DS';
        }
        modify("Amt. Rcd. Not Invoiced (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Amt. Rcd. Not Invoiced (LCY)"(Field 114)". Please convert manually.

            CaptionML = ENU = 'Amt. Rcd. Not Invoiced (LCY)', FRA = 'Montant reçu non fact. DS';
        }
        modify("Block Payment Tolerance")
        {
            CaptionML = ENU = 'Block Payment Tolerance', FRA = 'Bloquer écart de règlement';
        }
        modify("Pmt. Disc. Tolerance (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Pmt. Disc. Tolerance (LCY)"(Field 117)". Please convert manually.

            CaptionML = ENU = 'Pmt. Disc. Tolerance (LCY)', FRA = 'Validation écart d''escompte DS';

            //Unsupported feature: Change Description on ""Pmt. Disc. Tolerance (LCY)"(Field 117)". Please convert manually.

        }
        modify("Pmt. Tolerance (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Pmt. Tolerance (LCY)"(Field 118)". Please convert manually.

            CaptionML = ENU = 'Pmt. Tolerance (LCY)', FRA = 'Écart de règlement DS';

            //Unsupported feature: Change Description on ""Pmt. Tolerance (LCY)"(Field 118)". Please convert manually.

        }
        modify("IC Partner Code")
        {
            CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        }
        modify(Refunds)
        {

            //Unsupported feature: Change CalcFormula on "Refunds(Field 120)". Please convert manually.

            CaptionML = ENU = 'Refunds', FRA = 'Remboursements';

            //Unsupported feature: Change Description on "Refunds(Field 120)". Please convert manually.

        }
        modify("Refunds (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Refunds (LCY)"(Field 121)". Please convert manually.

            CaptionML = ENU = 'Refunds (LCY)', FRA = 'Remboursements DS';

            //Unsupported feature: Change Description on ""Refunds (LCY)"(Field 121)". Please convert manually.

        }
        modify("Other Amounts")
        {

            //Unsupported feature: Change CalcFormula on ""Other Amounts"(Field 122)". Please convert manually.

            CaptionML = ENU = 'Other Amounts', FRA = 'Autres montants';

            //Unsupported feature: Change Description on ""Other Amounts"(Field 122)". Please convert manually.

        }
        modify("Other Amounts (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Other Amounts (LCY)"(Field 123)". Please convert manually.

            CaptionML = ENU = 'Other Amounts (LCY)', FRA = 'Autres montants DS';

            //Unsupported feature: Change Description on ""Other Amounts (LCY)"(Field 123)". Please convert manually.

        }
        modify("Prepayment %")
        {
            CaptionML = ENU = 'Prepayment %', FRA = '% acompte';
        }
        modify("Outstanding Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Invoices"(Field 125)". Please convert manually.

            CaptionML = ENU = 'Outstanding Invoices', FRA = 'Factures en attente';
        }
        modify("Outstanding Invoices (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Outstanding Invoices (LCY)"(Field 126)". Please convert manually.

            CaptionML = ENU = 'Outstanding Invoices (LCY)', FRA = 'Factures en attente DS';
        }
        modify("Pay-to No. Of Archived Doc.")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. Of Archived Doc."(Field 130)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. Of Archived Doc.', FRA = 'Paiement - Nbre de doc. archivés';
        }
        modify("Buy-from No. Of Archived Doc.")
        {

            //Unsupported feature: Change CalcFormula on ""Buy-from No. Of Archived Doc."(Field 131)". Please convert manually.

            CaptionML = ENU = 'Buy-from No. Of Archived Doc.', FRA = 'Achat - Nbre de doc. archivés';
        }
        modify("Partner Type")
        {
            CaptionML = ENU = 'Partner Type', FRA = 'Type partenaire';
            // OptionCaptionML = ENU = ' ,Company,Person', FRA = ' ,Société,Personne';
        }
        modify(Image)
        {
            CaptionML = ENU = 'Image', FRA = 'Image';
        }
        modify("Creditor No.")
        {
            CaptionML = ENU = 'Creditor No.', FRA = 'N° créditeur';
        }
        modify("Preferred Bank Account Code")
        {

            //Unsupported feature: Change TableRelation on ""Preferred Bank Account Code"(Field 288)". Please convert manually.

            CaptionML = ENU = 'Preferred Bank Account Code', FRA = 'Code de compte bancaire préféré';

            //Unsupported feature: Change Editable on ""Preferred Bank Account Code"(Field 288)". Please convert manually.

        }
        modify("Cash Flow Payment Terms Code")
        {
            CaptionML = ENU = 'Cash Flow Payment Terms Code', FRA = 'Code modalités de paiement de trésorerie';
        }
        modify("Primary Contact No.")
        {
            CaptionML = ENU = 'Primary Contact No.', FRA = 'N° contact principal';
        }
        modify("Responsibility Center")
        {
            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 5701)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Lead Time Calculation")
        {
            CaptionML = ENU = 'Lead Time Calculation', FRA = 'Délai de réappro.';
        }
        modify("No. of Pstd. Receipts")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Pstd. Receipts"(Field 7177)". Please convert manually.

            CaptionML = ENU = 'No. of Pstd. Receipts', FRA = 'Nbre réceptions enreg.';
        }
        modify("No. of Pstd. Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Pstd. Invoices"(Field 7178)". Please convert manually.

            CaptionML = ENU = 'No. of Pstd. Invoices', FRA = 'Nbre de factures enregistrées';
        }
        modify("No. of Pstd. Return Shipments")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Pstd. Return Shipments"(Field 7179)". Please convert manually.

            CaptionML = ENU = 'No. of Pstd. Return Shipments', FRA = 'Nbre expéditions retour enreg.';
        }
        modify("No. of Pstd. Credit Memos")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Pstd. Credit Memos"(Field 7180)". Please convert manually.

            CaptionML = ENU = 'No. of Pstd. Credit Memos', FRA = 'Nbre d''avoirs enregistrés';
        }
        modify("Pay-to No. of Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Orders"(Field 7181)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Orders', FRA = 'Paiement - Nbre de commandes';
        }
        modify("Pay-to No. of Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Invoices"(Field 7182)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Invoices', FRA = 'Paiement - Nbre de factures';
        }
        modify("Pay-to No. of Return Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Return Orders"(Field 7183)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Return Orders', FRA = 'Paiement - Nbre de retours';
        }
        modify("Pay-to No. of Credit Memos")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Credit Memos"(Field 7184)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Credit Memos', FRA = 'Paiement - Nbre d''avoirs';
        }
        modify("Pay-to No. of Pstd. Receipts")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Pstd. Receipts"(Field 7185)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Pstd. Receipts', FRA = 'Paiement - Nbre de réceptions enreg.';
        }
        modify("Pay-to No. of Pstd. Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Pstd. Invoices"(Field 7186)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Pstd. Invoices', FRA = 'Paiement - Nbre de factures enreg.';
        }
        modify("Pay-to No. of Pstd. Return S.")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Pstd. Return S."(Field 7187)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Pstd. Return S.', FRA = 'Paiement - Nbre d''exp. retour enreg.';
        }
        modify("Pay-to No. of Pstd. Cr. Memos")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Pstd. Cr. Memos"(Field 7188)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Pstd. Cr. Memos', FRA = 'Paiement - Nbre d''avoirs enreg.';
        }
        modify("No. of Quotes")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Quotes"(Field 7189)". Please convert manually.

            CaptionML = ENU = 'No. of Quotes', FRA = 'Nbre de devis';
        }
        modify("No. of Blanket Orders")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Blanket Orders"(Field 7190)". Please convert manually.

            CaptionML = ENU = 'No. of Blanket Orders', FRA = 'Nbre de commandes ouvertes';
        }
        modify("No. of Orders")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Orders"(Field 7191)". Please convert manually.

            CaptionML = ENU = 'No. of Orders', FRA = 'Nbre de commandes';
        }
        modify("No. of Invoices")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Invoices"(Field 7192)". Please convert manually.

            CaptionML = ENU = 'No. of Invoices', FRA = 'Nbre de factures';
        }
        modify("No. of Return Orders")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Return Orders"(Field 7193)". Please convert manually.

            CaptionML = ENU = 'No. of Return Orders', FRA = 'Nbre de retours';
        }
        modify("No. of Credit Memos")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Credit Memos"(Field 7194)". Please convert manually.

            CaptionML = ENU = 'No. of Credit Memos', FRA = 'Nbre d''avoirs';
        }
        modify("No. of Order Addresses")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Order Addresses"(Field 7195)". Please convert manually.

            CaptionML = ENU = 'No. of Order Addresses', FRA = 'Nbre d''adresses de commande';
        }
        modify("Pay-to No. of Quotes")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Quotes"(Field 7196)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Quotes', FRA = 'Paiement - Nbre de devis';
        }
        modify("Pay-to No. of Blanket Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Pay-to No. of Blanket Orders"(Field 7197)". Please convert manually.

            CaptionML = ENU = 'Pay-to No. of Blanket Orders', FRA = 'Paiement - Nbre de commandes ouvertes';
        }
        modify("Base Calendar Code")
        {
            CaptionML = ENU = 'Base Calendar Code', FRA = 'Code calendrier principal';
        }
        modify("Document Sending Profile")
        {
            CaptionML = ENU = 'Document Sending Profile', FRA = 'Profil d''envoi de documents';
        }
        modify(SystemId)//sharmp16 replaced id by system id
        {
            CaptionML = ENU = 'Id', FRA = 'Id';
        }

        //Unsupported feature: CodeModification on ""No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          PurchSetup.GET;
          NoSeriesMgt.TestManual(PurchSetup."Vendor Nos.");
          "No. Series" := '';
        end;
        IF "Invoice Disc. Code" = '' THEN
          "Invoice Disc. Code" := "No.";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
        #2..4
        end;
        if "Invoice Disc. Code" = '' then
          "Invoice Disc. Code" := "No.";
        */
        //end;


        //Unsupported feature: CodeModification on "Name(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
          "Search Name" := Name;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Search Name" = UPPERCASE(xRec.Name)) or ("Search Name" = '') then
          "Search Name" := Name;

        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
        if (Name <> xRec.Name) then begin
          PurchSetup.GET;
          if (PurchSetup."Vendor Auto Dimension Code" <> '') then begin
            txtDimName := DimMgt.fctGetDimNameFromSource(Name,"Name 2");
            if rDimValue.GET(PurchSetup."Vendor Auto Dimension Code","No.") and (rDimValue.Name <> txtDimName) then begin
              rDimValue.Name := txtDimName;
              rDimValue.MODIFY;
            end;
          end;
        end;
        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Name 2"(Field 4)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
        if ("Name 2" <> xRec."Name 2") then begin
          PurchSetup.GET;
          if (PurchSetup."Vendor Auto Dimension Code" <> '') then begin
            txtDimName := DimMgt.fctGetDimNameFromSource(Name,"Name 2");
            if rDimValue.GET(PurchSetup."Vendor Auto Dimension Code","No.") and (rDimValue.Name <> txtDimName) then begin
              rDimValue.Name := txtDimName;
              rDimValue.MODIFY;
            end;
          end;
        end;
        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
        */
        //end;


        //Unsupported feature: CodeModification on "City(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on "Contact(Field 8).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ContactBusinessRelation.SETCURRENTKEY("Link to Table","No.");
        ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Vendor);
        ContactBusinessRelation.SETRANGE("No.","No.");
        IF ContactBusinessRelation.FINDFIRST THEN
          Cont.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
        else
          Cont.SETRANGE("Company No.",'');

        IF "Primary Contact No." <> '' THEN
          IF Cont.GET("Primary Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN
          VALIDATE("Primary Contact No.",Cont."No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if ContactBusinessRelation.FINDFIRST then
          Cont.SETRANGE("Company No.",ContactBusinessRelation."Contact No.")
        else
          Cont.SETRANGE("Company No.",'');

        if "Primary Contact No." <> '' then
          if Cont.GET("Primary Contact No.") then ;
        if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then
          VALIDATE("Primary Contact No.",Cont."No.");
        */
        //end;


        //Unsupported feature: CodeModification on "Contact(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF RMSetup.GET THEN
          IF RMSetup."Bus. Rel. Code for Vendors" <> '' THEN BEGIN
            IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') AND (Contact <> '') THEN BEGIN
              MODIFY;
              UpdateContFromVend.OnModify(Rec);
              UpdateContFromVend.InsertNewContactPerson(Rec,FALSE);
              MODIFY(TRUE);
            end;
            EXIT;
          end;

        IF Cont.GET("Primary Contact No.") THEN
          IF Cont.Name = Contact THEN
            EXIT;

        VALIDATE("Primary Contact No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if RMSetup.GET then
          if RMSetup."Bus. Rel. Code for Vendors" <> '' then begin
            if (xRec.Contact = '') and (xRec."Primary Contact No." = '') and (Contact <> '') then begin
              MODIFY;
              UpdateContFromVend.OnModify(Rec);
              UpdateContFromVend.InsertNewContactPerson(Rec,false);
              MODIFY(true);
            end;
            exit;
          end;

        if Cont.GET("Primary Contact No.") then
          if Cont.Name = Contact then
            exit;

        VALIDATE("Primary Contact No.",'');
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Vendor Posting Group"(Field 21)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     FinancialContractHeader: Record "Financial Contract Header";
        //     DrinkDepositGroup: Record "Drink Deposit Group";
        //begin
        /*
        //<<DITW18.00.07 VSC 16/02/2016 DIT-770 #1755
        if FinancialContractHeader.READPERMISSION then begin
          // <<DITW15.00.00.35 DDR 23/09/2009
          if "Contract Vend. Post. Gr. Stand" = '' then
            "Contract Vend. Post. Gr. Stand" := "Vendor Posting Group";
          if "Contract Vend. Post. Gr. Rent" = '' then
            "Contract Vend. Post. Gr. Rent" := "Vendor Posting Group";
          if "Contract Vend. Post. Gr. Loan" = '' then
            "Contract Vend. Post. Gr. Loan" := "Vendor Posting Group";
          if "Contract Vend. Post. Gr. LoanU" = '' then
            "Contract Vend. Post. Gr. LoanU" := "Vendor Posting Group";
          if "Contract Vend. Post. Gr. Maint" = '' then
            "Contract Vend. Post. Gr. Maint" := "Vendor Posting Group";
          if "Contract Vend. Post. Gr. Other" = '' then
            "Contract Vend. Post. Gr. Other" := "Vendor Posting Group";
          // >>DITW15.00.00.35 DDR
          //<<DITW17.10.03 MSF 08/05/2014 DIT-770 #340
          if "Loan Interest Vend. Post. Grp." = '' then
            "Loan Interest Vend. Post. Grp." := "Vendor Posting Group";
          //>>DITW17.10.03 MSF 08/05/2014 DIT-770 #340
        end;

        if DrinkDepositGroup.READPERMISSION then begin
          // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
          if ("Deposit Vendor Posting Group" = '') and "Split Deposit on Invoice" then
            "Deposit Vendor Posting Group" := "Vendor Posting Group";
          // >>DITW16.00.00.42 DDR DIT-715 #370
        end;
        //>>DITW18.00.07 VSC DIT-770 #1755
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Payment Terms Code"(Field 27)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW16.00.00.42 DDR 11/12/2012 DIT-715 #370
        if ("Deposit Payment Terms Code" = '') and "Split Deposit on Invoice" then
          VALIDATE("Deposit Payment Terms Code","Payment Terms Code");
        // >>DITW16.00.00.42 DDR DIT-715 #370
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shipping Agent Code"(Field 31)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.38 DDR 11/08/2010 #1217
        if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
          VALIDATE("Shipping Agent Service Code",'');
        // >>DITW15.00.00.38 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on "Blocked(Field 39)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     Lbln_Allowed: Boolean;
        //     Lrec_UserSetup: Record "User Setup";
        //     Pass: Boolean;
        //begin
        /*
        //<<DITW17.00.02 SR 10/09/2013 DIT-770 #143
        Lbln_Allowed := false;
        if Blocked <> xRec.Blocked then
          if Lrec_UserSetup.GET(USERID) then
            if Lrec_UserSetup."Release Vendor" then Lbln_Allowed := true;
        //<<DITW110.00.11 MSF 08/11/2017 NRQ#13577
        if (Blocked <> xRec.Blocked ) and (Rec.Blocked = Rec.Blocked::" ")then
          if not Lbln_Allowed then ERROR(Text2014412);
        //>>DITW17.00.02 SR DIT-770 #143 - DITW110.00.11 MSF 08/11/2017 NRQ#13577
        // <<DITW110.00.11 MSF 08/11/2017 NRQ#13577
        if (xRec.Blocked <> Rec.Blocked) and (Rec.Blocked = Rec.Blocked::" ") then
        TestMsgTaxRegistration();
        // >>DITW110.00.11 MSF 08/11/2017 NRQ#13577

        { //HEI.07 RFC257-250118
        //HEI.04 PATHAA02 041017>>
        //VALIDATE("Payment Method Code");
        //PATHAA02 041017<<
        IF "Payment Method Code" <> '' THEN BEGIN
         IF PaymentMethod.GET(Rec."Payment Method Code") THEN BEGIN
          IF PaymentMethod."Mandatory Bank details" THEN BEGIN
            VendorBankAccount.RESET;
            VendorBankAccount.SETRANGE("Vendor No.","No.");
             //IF VendorBankAccount.ISEMPTY THEN
               // ERROR(Text50000);
             IF VendorBankAccount.findset THEN BEGIN
                REPEAT
                  Pass := HeinekenGlobal.CheckBankDetails("No.",VendorBankAccount.Code);
                  IF NOT Pass THEN BEGIN
                    PurchasesPayablesSetup.GET;
                    Rec.Blocked := Rec.Blocked::All;
                    Rec."Blocked Reason Code" := PurchasesPayablesSetup."Missing BankDetails ReasonCode";
                    Rec.MODIFY;
                    ERROR(Text50001);
                    EXIT;
                  end;
                UNTIL VendorBankAccount.NEXT=0;
               end;
           end;
         end;
        end;
        //end;
        //HEI.04<<
        //PATHAA02 041017<<
        } //HEI.07 RFC257-250118
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Payment Method Code"(Field 47)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     Pass: Boolean;
        //begin
        /*
        // <<DITW16.00.00.42 DDR 11/12/2012 DIT-715 #370
        if ("Deposit Payment Method Code" = '') and "Split Deposit on Invoice" then
          VALIDATE("Deposit Payment Method Code","Payment Method Code");
        // >>DITW16.00.00.42 DDR DIT-715 #370

        {//commented-04.10.17
        //>>HEI.04 FDD-PTPGAP007 IBM PATHAA02>>
        IF "Payment Method Code" <> '' THEN
        //IF PaymentMethod.GET("Payment Method Code") THEN
         IF PaymentMethod."Mandatory Bank details" THEN BEGIN
          VendorBankAccount.RESET;
          VendorBankAccount.SETRANGE("Vendor No.","No.");
          IF VendorBankAccount.ISEMPTY THEN
            ERROR(Text50000);
         end;
        //<<HEI.04 FDD-PTPGAP007 IBM PATHAA02<<
        }//commented-04.10.17

        { //HEI.07 RFC257-250118
        //HEI.04>>
        IF "Payment Method Code" <> '' THEN BEGIN
         IF PaymentMethod.GET("Payment Method Code") THEN BEGIN
          IF PaymentMethod."Mandatory Bank details" THEN BEGIN
            VendorBankAccount.RESET;
            VendorBankAccount.SETRANGE("Vendor No.","No.");
             //IF VendorBankAccount.ISEMPTY THEN
              //  ERROR(Text50000);
             IF VendorBankAccount.findset THEN BEGIN
                REPEAT
                  Pass := HeinekenGlobal.CheckBankDetails("No.",VendorBankAccount.Code);
                  IF NOT Pass THEN BEGIN
                    PurchasesPayablesSetup.GET;
                    Rec.Blocked := Rec.Blocked::All;
                    Rec."Blocked Reason Code" := PurchasesPayablesSetup."Missing BankDetails ReasonCode";
                    Rec.MODIFY;
                    //MESSAGE(Text50001);
                    //ERROR(Text50001);
                    EXIT;
                  end else BEGIN
                    Rec.Blocked := Rec.Blocked::" ";
                    Rec."Blocked Reason Code" := '';
                    Rec.MODIFY;
                  end;
                UNTIL VendorBankAccount.NEXT=0;
               end;
          end else BEGIN
            Rec.Blocked := Rec.Blocked::" ";
            Rec."Blocked Reason Code" := '';
            Rec.MODIFY;
          end;
         end;
        end;
        //HEI.04<<
        } //HEI.07 RFC257-250118
        */
        //end;


        //Unsupported feature: CodeModification on ""Prices Including VAT"(Field 82).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PurchPrice.SETCURRENTKEY("Vendor No.");
        PurchPrice.SETRANGE("Vendor No.","No.");
        IF PurchPrice.FIND('-') THEN BEGIN
          IF VATPostingSetup.GET('','') THEN;
          IF CONFIRM(
               STRSUBSTNO(
                 Text002,
                 FIELDCAPTION("Prices Including VAT"),"Prices Including VAT",PurchPrice.TABLECAPTION),TRUE)
          THEN
            REPEAT
              IF PurchPrice."Item No." <> Item."No." THEN
                Item.GET(PurchPrice."Item No.");
              IF ("VAT Bus. Posting Group" <> VATPostingSetup."VAT Bus. Posting Group") OR
                 (Item."VAT Prod. Posting Group" <> VATPostingSetup."VAT Prod. Posting Group")
              THEN
                VATPostingSetup.GET("VAT Bus. Posting Group",Item."VAT Prod. Posting Group");
              IF PurchPrice."Currency Code" = '' THEN
                Currency.InitRoundingPrecision
              else
                IF PurchPrice."Currency Code" <> Currency.Code THEN
                  Currency.GET(PurchPrice."Currency Code");
              IF VATPostingSetup."VAT %" <> 0 THEN BEGIN
                IF "Prices Including VAT" THEN
                  PurchPrice."Direct Unit Cost" :=
                    ROUND(
                      PurchPrice."Direct Unit Cost" * (1 + VATPostingSetup."VAT %" / 100),
                      Currency."Unit-Amount Rounding Precision")
                else
                  PurchPrice."Direct Unit Cost" :=
                    ROUND(
                      PurchPrice."Direct Unit Cost" / (1 + VATPostingSetup."VAT %" / 100),
                      Currency."Unit-Amount Rounding Precision");
                PurchPrice.MODIFY;
              end;
            UNTIL PurchPrice.NEXT = 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PurchPrice.SETCURRENTKEY("Vendor No.");
        PurchPrice.SETRANGE("Vendor No.","No.");
        if PurchPrice.FIND('-') then begin
          if VATPostingSetup.GET('','') then;
          if CONFIRM(
               STRSUBSTNO(
                 Text002,
                 FIELDCAPTION("Prices Including VAT"),"Prices Including VAT",PurchPrice.TABLECAPTION),true)
          then
            repeat
              if PurchPrice."Item No." <> Item."No." then
                Item.GET(PurchPrice."Item No.");
              if ("VAT Bus. Posting Group" <> VATPostingSetup."VAT Bus. Posting Group") or
                 (Item."VAT Prod. Posting Group" <> VATPostingSetup."VAT Prod. Posting Group")
              then
                VATPostingSetup.GET("VAT Bus. Posting Group",Item."VAT Prod. Posting Group");
              if PurchPrice."Currency Code" = '' then
                Currency.InitRoundingPrecision
              else
                if PurchPrice."Currency Code" <> Currency.Code then
                  Currency.GET(PurchPrice."Currency Code");
              if VATPostingSetup."VAT %" <> 0 then begin
                if "Prices Including VAT" then
        #24..27
                else
        #29..33
              end;
            until PurchPrice.NEXT = 0;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Registration No."(Field 86).OnValidate". Please convert manually.

        //trigger "(Field 86)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Vendor) THEN
          IF "VAT Registration No." <> xRec."VAT Registration No." THEN
            VATRegistrationLogMgt.LogVendor(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Vendor) then
          if "VAT Registration No." <> xRec."VAT Registration No." then
            VATRegistrationLogMgt.LogVendor(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Bus. Posting Group"(Field 88).OnValidate". Please convert manually.

        //trigger  Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
          IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");

        // <<DITW15.00.00.35 DDR 09/10/2009
        if (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") and
          ("Gen. Bus. Posting Free Group" = '') and
          ("Gen. Bus. Posting Group" <> '')
        then
          VALIDATE("Gen. Bus. Posting Free Group","Gen. Bus. Posting Group");
        // >>DITW15.00.00.35 DDR
        */
        //end;


        //Unsupported feature: CodeModification on "GLN(Field 90).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF GLN <> '' THEN
          GLNCalculator.AssertValidCheckDigit13(GLN);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if GLN <> '' then
          GLNCalculator.AssertValidCheckDigit13(GLN);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 91).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Partner Code"(Field 119).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."IC Partner Code" <> "IC Partner Code" THEN BEGIN
          IF NOT VendLedgEntry.SETCURRENTKEY("Vendor No.",Open) THEN
            VendLedgEntry.SETCURRENTKEY("Vendor No.");
          VendLedgEntry.SETRANGE("Vendor No.","No.");
          VendLedgEntry.SETRANGE(Open,TRUE);
          IF VendLedgEntry.FINDLAST THEN
            ERROR(Text010,FIELDCAPTION("IC Partner Code"),TABLECAPTION);

          VendLedgEntry.RESET;
          VendLedgEntry.SETCURRENTKEY("Vendor No.","Posting Date");
          VendLedgEntry.SETRANGE("Vendor No.","No.");
          AccountingPeriod.SETRANGE(Closed,FALSE);
          IF AccountingPeriod.FINDFIRST THEN BEGIN
            VendLedgEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
            IF VendLedgEntry.FINDFIRST THEN
              IF NOT CONFIRM(Text009,FALSE,TABLECAPTION) THEN
                "IC Partner Code" := xRec."IC Partner Code";
          end;
        end;

        IF "IC Partner Code" <> '' THEN BEGIN
          ICPartner.GET("IC Partner Code");
          IF (ICPartner."Vendor No." <> '') AND (ICPartner."Vendor No." <> "No.") THEN
            ERROR(Text008,FIELDCAPTION("IC Partner Code"),"IC Partner Code",TABLECAPTION,ICPartner."Vendor No.");
          ICPartner."Vendor No." := "No.";
          ICPartner.MODIFY;
        end;

        IF (xRec."IC Partner Code" <> "IC Partner Code") AND ICPartner.GET(xRec."IC Partner Code") THEN BEGIN
          ICPartner."Vendor No." := '';
          ICPartner.MODIFY;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."IC Partner Code" <> "IC Partner Code" then begin
          if not VendLedgEntry.SETCURRENTKEY("Vendor No.",Open) then
            VendLedgEntry.SETCURRENTKEY("Vendor No.");
          VendLedgEntry.SETRANGE("Vendor No.","No.");
          VendLedgEntry.SETRANGE(Open,true);
          if VendLedgEntry.FINDLAST then
        #7..11
          AccountingPeriod.SETRANGE(Closed,false);
          if AccountingPeriod.FINDFIRST then begin
            VendLedgEntry.SETFILTER("Posting Date",'>=%1',AccountingPeriod."Starting Date");
            if VendLedgEntry.FINDFIRST then
              if not CONFIRM(Text009,false,TABLECAPTION) then
                "IC Partner Code" := xRec."IC Partner Code";
          end;
        end;

        if "IC Partner Code" <> '' then begin
          ICPartner.GET("IC Partner Code");
          if (ICPartner."Vendor No." <> '') and (ICPartner."Vendor No." <> "No.") then
        #24..26
        end;

        if (xRec."IC Partner Code" <> "IC Partner Code") and ICPartner.GET(xRec."IC Partner Code") then begin
          ICPartner."Vendor No." := '';
          ICPartner.MODIFY;
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Preferred Bank Account Code"(Field 288)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        {//HEI.04 FDD-PTPGAP007 IBM PATHAA02 >>
        IF PaymentMethod.GET(Rec."Payment Method Code") THEN BEGIN
         IF PaymentMethod."Mandatory Bank details" THEN BEGIN
           TESTFIELD("Preferred Bank Account Code");
           IF "Preferred Bank Account Code"<>'' THEN BEGIN
             IF HeinekenGlobal.CheckBankDetails("No.","Preferred Bank Account Code") THEN BEGIN
               Blocked := Blocked :: " ";
               "Blocked Reason Code":='';
             end else BEGIN
               Blocked := Blocked :: All;
               "Blocked Reason Code":='MBD';
               MESSAGE(Text50001,"Preferred Bank Account Code");
             end;
            MODIFY(TRUE);
           end;
         end;
        end;
        //HEI.04 FDD-PTPGAP007 IBM PATHAA02<<
        }
        */
        //end;


        //Unsupported feature: CodeModification on ""Primary Contact No."(Field 5049).OnLookup". Please convert manually.

        //trigger "(Field 5049)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ContBusRel.SETCURRENTKEY("Link to Table","No.");
        ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
        ContBusRel.SETRANGE("No.","No.");
        IF ContBusRel.FINDFIRST THEN
          Cont.SETRANGE("Company No.",ContBusRel."Contact No.")
        else
          Cont.SETRANGE("No.",'');

        IF "Primary Contact No." <> '' THEN
          IF Cont.GET("Primary Contact No.") THEN ;
        IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
          TempVend.COPY(Rec);
          FIND;
          TRANSFERFIELDS(TempVend,FALSE);
          VALIDATE("Primary Contact No.",Cont."No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if ContBusRel.FINDFIRST then
          Cont.SETRANGE("Company No.",ContBusRel."Contact No.")
        else
          Cont.SETRANGE("No.",'');

        if "Primary Contact No." <> '' then
          if Cont.GET("Primary Contact No.") then ;
        if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then begin
          TempVend.COPY(Rec);
          FIND;
          TRANSFERFIELDS(TempVend,false);
          VALIDATE("Primary Contact No.",Cont."No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Primary Contact No."(Field 5049).OnValidate". Please convert manually.

        //trigger "(Field 5049)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Contact := '';
        IF "Primary Contact No." <> '' THEN BEGIN
          Cont.GET("Primary Contact No.");

          ContBusRel.SETCURRENTKEY("Link to Table","No.");
          ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
          ContBusRel.SETRANGE("No.","No.");
          ContBusRel.FINDFIRST;

          IF Cont."Company No." <> ContBusRel."Contact No." THEN
            ERROR(Text004,Cont."No.",Cont.Name,"No.",Name);

          IF Cont.Type = Cont.Type::Person THEN
            Contact := Cont.Name
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Contact := '';
        if "Primary Contact No." <> '' then begin
        #3..9
          if Cont."Company No." <> ContBusRel."Contact No." then
            ERROR(Text004,Cont."No.",Cont.Name,"No.",Name);

          if Cont.Type = Cont.Type::Person then
            Contact := Cont.Name
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Responsibility Center"(Field 5700)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     CurrentRoute: Record Route;
        //     Confirmed: Boolean;
        //     CurrentRespCenter: Record "Responsibility Center";
        //     CurrentLocation: Record Location;
        //begin
        /*
        /// DITW19.00.08 AKH 16/12/2016 BL#9797 - DITW110.00.11 ASA 13/11/2017 NRQ#18375
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Field 5701)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< DITW19.00.08 AKH 16/12/2016 BL#9797
        if ("Location Code" <> xRec."Location Code") and ("Location Code" <> '') and (CurrFieldNo <> FIELDNO("Location Code")) then
          UserMgt.CheckResponsiblityCenterLocation("Location Code","Responsibility Center");
        //>> DITW19.00.08 AKH BL#9797
        */
        //end;
        //BC UpgradeSHARMP16 begin>> French localisation fields
        // field(10860; "Payment in progress (LCY)";
        // Decimal)
        // {
        //     // CalcFormula = Sum("Payment Line"."Amount (LCY)" where("Account Type" = CONST(Vendor),
        //     //                                                        "Account No." = FIELD("No."),
        //     //                                                        "Copied To Line" = CONST(0),
        //     //                                                        "Payment in Progress" = CONST(true)));//sharmp16 paymentline table has link with multiple tables
        //     CaptionML = ENU = 'Payment in progress (LCY)',
        //                 FRA = 'Règlement en cours DS';
        //     Description = 'HEI.18';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(11620; ABN; Text[11])
        // {
        //     Caption = 'ABN';
        //     Numeric = true;

        //     trigger OnValidate();
        //     begin
        //         if "WHT Business Posting Group" <> '' then
        //             ERROR(Text15000, FIELDCAPTION("WHT Business Posting Group FND"));
        //     end;
        // }
        // field(11621; Registered; Boolean)
        // {
        //     Caption = 'Registered';

        //     trigger OnValidate();
        //     begin
        //         if Registered then
        //             TESTFIELD(ABN);
        //     end;
        // }
        // field(11622; "ABN Division Part No."; Text[3])
        // {
        //     Caption = 'ABN Division Part No.';
        //     Numeric = true;

        //     trigger OnValidate();
        //     begin
        //         if "WHT Business Posting Group" <> '' then
        //             ERROR(Text15000, FIELDCAPTION("WHT Business Posting Group"));
        //     end;
        // }
        // field(11623; "Foreign Vend"; Boolean)
        // {
        //     Caption = 'Foreign Vend';

        //     trigger OnValidate();
        //     begin
        //         if "Foreign Vend" then begin
        //             ABN := '';
        //             "ABN Division Part No." := '';
        //         end;
        //     end;
        // }
        // field(11624; "EFT Payment"; Boolean)
        // {
        //     Caption = 'EFT Payment';
        // }
        // field(11625; "EFT Bank Account No."; Code[10])
        // {
        //     Caption = 'EFT Bank Account No.';
        //     TableRelation = "Vendor Bank Account".Code where("Vendor No." = FIELD("No."));
        // }
        // field(17100; "IRD No."; Text[30])
        // {
        //     Caption = 'IRD No.';
        // }
        //BC UpgradeSHARMP16 end<< French localisation fields
        field(50000; "Blocked Reason Code FND"; Code[20])
        {
            Caption = 'Blocked Reason Code';
            Description = 'HEI.01';
            TableRelation = "Blocked Reason FND".Code;//sharmp16 table added.

            trigger OnValidate();
            var
                Pass: Boolean;
            begin
                /* //HEI.07 RFC257-250118
                //HEI.04 PATHAA02 041017>>
                //VALIDATE("Payment Method Code");
                //IF xRec."Blocked Reason Code"<> Rec."Blocked Reason Code" THEN BEGIN
                IF "Payment Method Code" <> '' THEN BEGIN
                 IF PaymentMethod.GET(Rec."Payment Method Code") THEN BEGIN
                  IF PaymentMethod."Mandatory Bank details" THEN BEGIN
                    VendorBankAccount.RESET;
                    VendorBankAccount.SETRANGE("Vendor No.","No.");
                     //IF VendorBankAccount.ISEMPTY THEN
                      //  ERROR(Text50000);
                     IF VendorBankAccount.findset THEN BEGIN
                        REPEAT
                          Pass := HeinekenGlobal.CheckBankDetails("No.",VendorBankAccount.Code);
                          IF NOT Pass THEN BEGIN
                            PurchasesPayablesSetup.GET;
                            Rec.Blocked := Rec.Blocked::All;
                            Rec."Blocked Reason Code" := PurchasesPayablesSetup."Missing BankDetails ReasonCode";
                            Rec.MODIFY;
                            ERROR(Text50001);
                            EXIT;
                          end;
                        UNTIL VendorBankAccount.NEXT=0;
                       end;
                   end;
                 end;
                end;
                //end;
                //HEI.04<<
                //PATHAA02 041017<<
                
                */ //HEI.07 RFC257-250118

            end;
        }
        field(50001; "E-Mail 2 FND"; Text[80])
        {
            Caption = 'Email Finance';
            Description = 'HEI.02';
            ExtendedDatatype = EMail;
        }
        field(50003; "Sensitive Payment Block FND"; Boolean)
        {
            Caption = 'Sensitive Payment Block';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50004; "Supplying Plant of Vendor FND"; Boolean)
        {
            CalcFormula = Exist("Order Address" where("Supplying Plant Vndor Num. FND" = FIELD("No.")));
            Caption = 'Supplying Plant of Vendor';
            Description = 'HEI.02';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Global Vendor Number FND"; Code[20])
        {
            Caption = 'Global Vendor Number';
            Description = 'HEI.02';
        }
        field(50007; "Global Delete FND"; Boolean)
        {
            Caption = 'Global Flag for Deletion Indicator';
            Description = 'HEI.02';

            trigger OnValidate();
            begin
                //HEI.05>>
                if "Global Delete FND" and ("Global Delete FND" <> xRec."Global Delete FND") then begin
                    CALCFIELDS("Outstanding Orders", "Outstanding Invoices");
                    if "Outstanding Orders" = 0 then
                        if "Outstanding Invoices" > 0 then
                            VALIDATE(Blocked, Blocked::order) //sharmp16 enum exten
                        else
                            VALIDATE(Blocked, Blocked::All);
                end;
                //HEI.05<<
            end;
        }
        field(50008; "Vendor Type FND"; Code[10])
        {
            Caption = 'Vendor Type';
            Description = 'HEI.02';
            TableRelation = "Vendor Type FND";
        }
        field(50009; "Stndrd Carrier Access Code FND"; Code[10])
        {
            Caption = 'Standard Carrier Access Code';
            Description = 'HEI.02';
        }
        field(50011; "Reference Code IC & Plant FND"; Code[20])
        {
            Caption = 'Reference Code IC and Plant';
            Description = 'HEI.02';
        }
        field(50012; "Duns Number FND"; Code[9])
        {
            Caption = 'Duns Number';
            Description = 'HEI.02';
        }
        field(50013; "Industry Key FND"; Code[10])
        {
            Caption = 'Industry Key';
            Description = 'HEI.02';
            TableRelation = "Industry Key FND";
        }
        field(50014; "Corporate Vendor Group FND"; Code[10])
        {
            Caption = 'Corporate Vendor Group';
            Description = 'HEI.02';
            TableRelation = "Corporate Vendor Group FND";
        }
        field(50015; "Name 3 FND"; Text[40])
        {
            Caption = 'Name 3';
            Description = 'HEI.02';
        }
        field(50016; "Name 4 FND"; Text[40])
        {
            Caption = 'Name 4';
            Description = 'HEI.02';
        }
        field(50018; "C/O Name FND"; Text[40])
        {
            Caption = 'C/O Name';
            Description = 'HEI.02';
        }
        field(50021; "Street 3 FND"; Text[40])
        {
            Caption = 'Street 3';
            Description = 'HEI.02';
        }
        field(50022; "Street 4 FND"; Text[40])
        {
            Caption = 'Street 4';
            Description = 'HEI.02';
        }
        field(50023; "Street 5 FND"; Text[40])
        {
            Caption = 'Street 5';
            Description = 'HEI.02';
        }
        field(50024; "House Number FND"; Code[10])
        {
            Caption = 'House Number';
            Description = 'HEI.02';
        }
        field(50025; "House Number Supplement FND"; Code[10])
        {
            Caption = 'House Number Supplement';
            Description = 'HEI.02';
        }
        field(50026; "District FND"; Text[35])
        {
            Caption = 'District';
            Description = 'HEI.02';
        }
        field(50027; "Different City FND"; Text[40])
        {
            Caption = 'Different City';
            Description = 'HEI.02';
        }
        field(50029; "P.O. Box FND"; Code[10])
        {
            Caption = 'P.O. Box';
            Description = 'HEI.02';
        }
        field(50030; "P.O. Box Postal Code FND"; Code[10])
        {
            Caption = 'P.O. Box Postal Code';
            Description = 'HEI.02';
        }
        field(50031; "P.O. Box Without No. FND"; Boolean)
        {
            Caption = 'P.O. Box Without No.';
            Description = 'HEI.02';
        }
        field(50032; "Other City FND"; Text[40])
        {
            Caption = 'Other City';
            Description = 'HEI.02';
        }
        field(50033; "Other Country FND"; Code[10])
        {
            Caption = 'Other Country';
            Description = 'HEI.02';
            TableRelation = "Country/Region";
        }
        field(50034; "Other Region FND"; Code[10])
        {
            Caption = 'Other Region';
            Description = 'HEI.02';
        }
        field(50035; "Company Postal Code FND"; Code[10])
        {
            Caption = 'Company Postal Code';
            Description = 'HEI.02';
        }
        field(50036; "Type of Delivery FND"; Code[10])
        {
            Caption = 'Type of Delivery';
            Description = 'HEI.02';
            TableRelation = "Type of Delivery FND";
        }
        field(50037; "Number of Delivery Service FND"; Code[10])
        {
            Caption = 'Number of Delivery Service';
            Description = 'HEI.02';
        }
        field(50038; "Tax Number 2 FND"; Code[11])
        {
            Caption = 'Tax Number 2';
            Description = 'HEI.02';
        }
        field(50039; "Tax Number 3 FND"; Code[18])
        {
            Caption = 'Tax Number 3';
            Description = 'HEI.02';
        }
        field(50040; "Tax Number 4 FND"; Code[18])
        {
            Caption = 'Tax Number 4';
            Description = 'HEI.02';
        }
        field(50041; "Tax Jurisdiction FND"; Code[10])
        {
            Caption = 'Tax Jurisdiction';
            Description = 'HEI.02';
            TableRelation = "Tax Jurisdiction";
        }
        field(50043; "Date of Birth FND"; Date)
        {
            Caption = 'Date of Birth';
            Description = 'HEI.02';
        }
        field(50044; "Place of Birth FND"; Text[40])
        {
            Caption = 'Place of Birth';
            Description = 'HEI.02';
        }
        field(50045; "Profession FND"; Text[40])
        {
            Caption = 'Profession';
            Description = 'HEI.02';
        }
        field(50047; "Employee FND"; Boolean)
        {
            Caption = 'Employee';
            Description = 'HEI.02';
        }
        field(50048; "Shipment Method Location FND"; Text[30])
        {
            Caption = 'Shipment Method Location';
            Description = 'HEI.02';
        }
        field(50049; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            TableRelation = "WHT Business Posting Group FND";

            // trigger OnValidate();
            // begin
            //     if (ABN <> '') or ("ABN Division Part No." <> '') then
            //         ERROR(Text15000, FIELDCAPTION(ABN));
            // end;//BC UPgrade SHARMP16 FrenchLocalization Fields used
        }
        field(50050; "WHT Payable Amount (LCY) FND"; Decimal)
        {
            CalcFormula = Sum("WHT Entry FND"."Unrealized Amount (LCY)" where("Currency Code" = FIELD("No."),
                                                                           "Remaining Unrealized Amount" = CONST(1)));
            Caption = 'WHT Payable Amount (LCY)';
            FieldClass = FlowField;
        }
        field(50051; "WHT Registration ID FND"; Text[20])
        {
            Caption = 'WHT Registration ID';
        }
        field(50052; "ID No. FND"; Text[20])
        {
            Caption = 'ID No.';
        }
        field(50053; "Sensitive Workflow Block FND"; Boolean)
        {
            Caption = 'Sensitive Workflow Block';
            Description = 'HEI.08';
            Editable = true;
        }
        field(50054; "Vendor Category FND"; Code[20])
        {
            Description = 'HEI.14';
            Caption = 'Vendor Category';
            TableRelation = "Vendor Category FND".Code;
        }
        field(50055; "Send To Maximo FND"; Boolean)
        {
            Caption = 'Send To Maximo';
            Description = 'HEI.10';
        }
        field(50057; "Local Vendor Type FND"; Code[10])
        {
            Description = 'HEI.11';
            Caption = 'Local Vendor Type';
            TableRelation = "Local Vendor Type FND";
        }
        field(50058; "No. of Shipping Agent Rel. FND"; Integer)
        {
            // CalcFormula = Count("Shipping Agent Serv. Relation" where(Type = CONST(Vendor),
            //                                                            "No." = FIELD("No.")));//sharmp16 drinkit
            Caption = 'No. of Shipping Agent Service Relations';
            Description = 'HEI.16';
            Editable = false;
            // FieldClass = FlowField;//sharmp16--PurchaseProcesstestchange
        }
        field(50059; "Self-Billing FND"; Boolean)
        {
            Description = 'HEI.17';
            Caption = 'Self-Billing';
        }
        field(50060; "Default SPL Code FND"; Code[20])
        {
            CalcFormula = Lookup("Vendor SPL Relation FND"."SPL Code" where("Vendor No." = FIELD("No."),
                                                                         Default = CONST(true),
                                                                         "Marked for Deletion" = CONST(false),
                                                                         Blocked = CONST(false)));
            Description = 'HEI.21';
            Caption = 'Default SPL Code';
            FieldClass = FlowField;
        }
        //sharmp16 drinkitfields begin >>
        // field(2013610; "Vendor DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Deposit Group Code',
        //                 FRA = 'Code groupe consigne fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     //    TableRelation = "Drink Deposit Group".Code where("Source Type" = CONST(Vendor));//sharmp16 drink-it field
        // }
        // field(2013630; "Deposit Vendor Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Deposit - Vendor Posting Group',
        //                 FRA = 'Consigne - Groupe compta. fournisseur';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2013631; "Deposit Payment Terms Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Deposit - Payment Terms Code',
        //                 FRA = 'Consigne - Code conditions paiement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Terms";
        // }
        // field(2013632; "Deposit Payment Method Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Deposit - Payment Method Code',
        //                 FRA = 'Consigne - Code mode de règlement';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     TableRelation = "Payment Method";
        // }
        // field(2013636; "Split Deposit on Invoice"; Boolean)
        // {
        //     CaptionML = ENU = 'Split Deposit on Invoice (Entries)',
        //                 FRA = 'Diviser consigne sur facture (écritures)';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.42 DDR 30/11/2012 11/12/2012 DIT-715 #370
        //         if "Split Deposit on Invoice" then begin
        //             if "Deposit Vendor Posting Group" = '' then
        //                 VALIDATE("Deposit Vendor Posting Group", "Vendor Posting Group");
        //             if "Deposit Payment Terms Code" = '' then
        //                 VALIDATE("Deposit Payment Terms Code", "Payment Terms Code");
        //             if "Deposit Payment Method Code" = '' then
        //                 VALIDATE("Deposit Payment Method Code", "Payment Method Code");
        //         end;
        //         // >>DITW16.00.00.42 DDR DIT-715 #370
        //     end;
        // }
        // field(2013637; "Deposit Vend. Balance (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = FIELD("No."),
        //                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
        //                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
        //                                                                           "Currency Code" = FIELD("Currency Filter"),
        //                                                                           "Item Charge Type" = CONST(Deposit)));
        //     CaptionML = ENU = 'Deposit Balance (LCY)',
        //                 FRA = 'Solde consigne DS';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013666; "Autom. Item Charge"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Item Charges',
        //                 FRA = 'Calculer Frais annexes';
        //     Description = 'DITW15.00.00.39 #1407';
        //     OptionCaptionML = ENU = 'Direct,Release,Posting,Posting (Excl. Item)',
        //                       FRA = 'Direct,Lancé,Validation,Validation (Excl. Article)';
        //     OptionMembers = " ",Release,Posting,PostingExclItem;
        // }
        // field(2013667; "Vendor DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Tax Group Code',
        //                 FRA = 'Code groupe taxe fournisseur';
        //     Description = 'DITW15.00.00.01';
        //     //   TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Vendor));//sharmp16 --drink-it

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.33 DDR 08/05/2009 - DITW15.00.00.34 DDR 09/07/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.33 DDR
        //     end;
        // }
        // field(2013668; "Pay-to/Buy-from DTax Gr. Calc."; Option)
        // {
        //     CaptionML = ENU = 'Pay-to/Buy-from Tax Calculation',
        //                 FRA = 'Calcul Taxes Paiement/Fournisseur';
        //     Description = 'DITW18.00.07 DIT-770 #1941';
        //     OptionCaptionML = ENU = ' ,Pay-to,Buy-from',
        //                       FRA = ' ,Paiment,Fournisseur';
        //     OptionMembers = " ","Pay-to","Buy-from";
        // }
        // field(2013695; "Item Charge Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type Filter',
        //                 FRA = 'Filtre type frais article';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        // }
        // field(2013726; "Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Tax Registration No.',
        //                 FRA = 'N° Registration Taxe';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.33 DDR 08/05/2009 - DITW15.00.00.34 DDR 09/07/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.34 DDR
        //     end;
        // }
        // field(2013730; "Fiscal Representative No."; Code[20])
        // {
        //     CaptionML = ENU = 'Fiscal Representative / Customs Agent No.',
        //                 FRA = 'N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW15.00.00.28-.38 #1217';
        //     TableRelation = "Fiscal Representative";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.33 DDR 08/05/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.33 DDR
        //     end;
        // }
        // field(2013762; "No. of Drink Disc. Groups"; Integer)
        // {
        //     // CalcFormula = Count("Drink Discount Relation" where("Source Type" = CONST(Vendor),
        //     //                                                      "Source No." = FIELD("No.")));//sharmp16
        //     CaptionML = ENU = 'No. of Drink-It Disc. Groups',
        //                 FRA = 'Nombre de Drink-It Groupes remises';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013765; "No. of Promotion Groups"; Integer)
        // {
        //     CalcFormula = Count("Drink Promotion Relation" where("Source Type" = CONST(Vendor),
        //                                                           "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'No. of Promotion Groups',
        //                 FRA = 'Nombre de Groupes promotions';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013823; "Gen. Bus. Posting Free Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Gen. Bus. Posting Group Free item',
        //                 FRA = 'Groupe article gratuit compta. marché';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Business Posting Group";

        //     trigger OnValidate();
        //     begin
        //         if "Gen. Bus. Posting Free Group" = '' then
        //             "Free Item Posting Type" := "Free Item Posting Type"::" ";
        //     end;
        // }
        // field(2013825; "Free Item Posting Type"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Price on Free',
        //                 FRA = 'Calculer Prix sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
        //                       FRA = ' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;

        //     trigger OnValidate();
        //     begin
        //         if "Free Item Posting Type" = "Free Item Posting Type"::" " then
        //             "Gen. Bus. Posting Free Group" := '';
        //     end;
        // }
        // field(2013942; "Min HL Volume"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClassHL(FIELDNO("Min HL Volume"));
        //     CaptionML = ENU = 'Min. Volume',
        //                 FRA = 'Volume Min.';
        //     Description = 'DITW18.00.07 DIT-770 #1971 - #1976';
        // }
        // field(2013943; "Min. Eq. UOM quantity"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClassEqUom(FIELDNO("Min. Eq. UOM quantity"));
        //     CaptionML = ENU = 'Min. Eq. UOM Quantity',
        //                 FRA = 'Quantité Min Eq. UOM';
        //     Description = 'DITW18.00.07 DIT-770 #1971 - #1976';
        // }
        // field(2014060; "Vendor Delivery Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Delivery Type',
        //                 FRA = 'Type Livraison Fournisseur';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code where(Type = CONST(Vendor));
        // }
        // field(2014061; "Truck Zone"; Option)
        // {
        //     CaptionML = ENU = 'Truck Zone',
        //                 FRA = 'Zone de camion';
        //     Description = 'DITW18.00.07 #1968 - #1977';
        //     OptionCaptionML = ENU = ' ,Right,Left',
        //                       FRA = ' ,Droite,Gauche';
        //     OptionMembers = " ",Right,Left;
        // }
        // field(2014063; "Require 2 Drivers"; Boolean)
        // {
        //     CaptionML = ENU = 'Require 2 Drivers',
        //                 FRA = 'Demande 2 chauffeurs';
        //     Description = 'DITW18.00.07 #1968 - #1977';
        // }
        // field(2014076; "Shipping Agent Service Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipping Agent Service Code',
        //                 FRA = 'Code prestation transporteur';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.38';
        //     MinValue = 0;
        // }
        // field(2014101; "Transport Time Text"; Text[50])
        // {
        //     CaptionML = ENU = 'Transport Time (AAD)',
        //                 FRA = 'Temps de transport (DAA)';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2014107; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW18.00.07 #1968 - #1977 - DITW19.00.08 BL#9797';
        //     TableRelation = IF ("Responsibility Center" = CONST('')) Route
        //     else IF ("Responsibility Center" = FILTER(<> '')) Route where("Responsibility Center" = FIELD("Resp. Center Table Filter"));

        //     trigger OnValidate();
        //     var
        //         lrRouteCombination: Record "Route Combination";
        //         CurrentRoute: Record Route;
        //         Confirmed: Boolean;
        //     begin
        //         //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977
        //         /// DITW19.00.08 AKH 16/12/2016 BL#9797 - DITW110.00.11 ASA 13/11/2017 NRQ#18375
        //         lrRouteCombination.RESET;
        //         //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977
        //         lrRouteCombination.SETRANGE("Source Type", lrRouteCombination."Source Type"::Vendor);
        //         //>> DITW18.00.07 VSC DIT-770 #1968 - #1977
        //         lrRouteCombination.SETRANGE("No.", "No.");
        //         lrRouteCombination.SETRANGE(Code, Route);
        //         if not lrRouteCombination.FINDFIRST then begin
        //             lrRouteCombination.INIT;
        //             //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977
        //             lrRouteCombination."Source Type" := lrRouteCombination."Source Type"::Vendor;
        //             //>> DITW18.00.07 VSC DIT-770 #1968 - #1977
        //             lrRouteCombination."No." := "No.";
        //             lrRouteCombination.Code := Route;
        //             lrRouteCombination.INSERT;
        //         end;
        //     end;
        // }
        // field(2014108; "Minimum Cubage"; Decimal)
        // {
        //     CaptionML = ENU = 'Minimum Volume (Cubage)',
        //                 FRA = 'Volume (cubage) minimum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW18.00.07 DIT-770 #1976';
        //     MinValue = 0;
        // }
        // field(2014109; "Minimum Weight"; Decimal)
        // {
        //     CaptionML = ENU = 'Minimum Weight',
        //                 FRA = 'Poids minimum';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW18.00.07 DIT-770 #1976';
        //     MinValue = 0;
        // }
        // field(2014271; "Tax Warehouse Reference"; Text[20])
        // {
        //     CaptionML = ENU = 'Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014290; "Journey Time"; DateFormula)
        // {
        //     CaptionML = ENU = 'Journey Time (EMCS)',
        //                 FRA = 'Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';
        // }
        // field(2014422; "Sundry Vendor"; Boolean)
        // {
        //     CaptionML = ENU = 'Sundry Vendor',
        //                 FRA = 'Fournisseur Divers';
        //     Description = 'DITW18.00.07 DIT-770 #1804';
        // }
        // field(2014423; "No. of Exclusivity Groups"; Integer)
        // {
        //     CalcFormula = Count("Item Exclusivity Relation" where("Source Type" = CONST(Vendor),
        //                                                            "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'No. of Exclusivity Groups',
        //                 FRA = 'Nombre de Groupes exclusivité';
        //     Description = 'DITW15.00.00.39';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014424; "Resp. Center Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Resp. Center Table Filter',
        //                 FRA = 'Filtre Centre de gestion (table)';
        //     Description = 'DITW19.00.08 BL#9797';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014429; "Pay-to/Buy-from Prices Calc."; Option)
        // {
        //     CaptionML = ENU = 'Pay-to/Buy-from Prices Calculation',
        //                 FRA = 'Calcul Prix Paiment/Fournisseur';
        //     Description = 'DITW18.00.07 DIT-770 #1941';
        //     OptionCaptionML = ENU = ' ,Pay-to,Buy-from',
        //                       FRA = ' ,Paiment,Fournisseur';
        //     OptionMembers = " ","Pay-to","Buy-from";
        // }
        // field(2014430; "Calculate Payment Terms From"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Payment Terms From',
        //                 FRA = 'Cacluler Code conditions paiement';
        //     Description = 'DITW18.00.07 DIT-770 #1941';
        //     OptionCaptionML = ENU = 'Pay-to Vendor,Buy-from Vendor',
        //                       FRA = 'Fournisseur à Payer,Frounisseur';
        //     OptionMembers = "Pay-to Vendor","Buy-from Vendor";
        // }
        // field(2014431; "Calculate Payment Method From"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Payment Method From',
        //                 FRA = 'Calculer méthode de paiement';
        //     Description = 'DITW18.00.07 DIT-770 #1941';
        //     OptionCaptionML = ENU = 'Pay-to Vendor,Buy-from Vendor',
        //                       FRA = 'Fournisseur à Payer,Frounisseur';
        //     OptionMembers = "Pay-to Vendor","Buy-from Vendor";
        // }
        // field(2014460; "Tax Office Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Office Code',
        //                 FRA = 'Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014464; "Transaction Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Transaction Type',
        //                 FRA = 'Type de transaction';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Transaction Type";
        // }
        // field(2014465; "Transport Method"; Code[10])
        // {
        //     CaptionML = ENU = 'Transport Method',
        //                 FRA = 'Mode de transport';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Transport Method";
        // }
        // field(2014466; "Transaction Specification"; Code[10])
        // {
        //     CaptionML = ENU = 'Transaction Specification',
        //                 FRA = 'Régime';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Transaction Specification";
        // }
        // field(2014467; "Entry Point"; Code[10])
        // {
        //     CaptionML = ENU = 'Entry Point',
        //                 FRA = 'Pays provenance';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Entry/Exit Point";
        // }
        // field(2014470; "Area"; Code[10])
        // {
        //     CaptionML = ENU = 'Area',
        //                 FRA = 'Dépt destination/provenance';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = Area;
        // }
        // field(2014473; "Vendor Template Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Template Code',
        //                 FRA = 'Code Modèle fournisseur';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Vendor Templ.";//sharmp16 table name change in bc

        //     trigger OnValidate();
        //     var
        //         // DDiscGrRelation2: Record "Drink Discount Relation";
        //         // DPromoGrRelation2: Record "Drink Promotion Relation";
        //         DefaultDim: Record "Default Dimension";
        //         DimMgt: Codeunit DimensionManagement;//sharmp16
        //     begin
        //         TESTFIELD("No.");
        //         //sharmp16 begin drink-itcode
        //         // if "Vendor Template Code" <> '' then begin
        //         //     if ((Name <> '') or
        //         //       ("Gen. Bus. Posting Group" <> '') or
        //         //       ("VAT Bus. Posting Group" <> '') or
        //         //       ("Vendor Posting Group" <> '') or
        //         //       ("Location Code" <> '') or
        //         //       ("Responsibility Center" <> '') or
        //         //       ("VAT Registration No." <> '')) and GUIALLOWED and (CurrFieldNo <> 0)
        //         //     then begin
        //         //         if CONFIRM(Text2014410, false, "No.", "Vendor Template Code") then begin
        //         //             VendTemplate.Code := "Vendor Template Code";
        //         //             "Vendor Template Code" := VendTemplate.Code;
        //         //             DDiscGrRelation2.RESET;
        //         //             DDiscGrRelation2.SETRANGE("Source Type", DDiscGrRelation."Source Type"::Vendor);
        //         //             DDiscGrRelation2.SETRANGE("Source No.", "No.");
        //         //             DDiscGrRelation2.DELETEALL;
        //         //             DPromoGrRelation2.RESET;
        //         //             DPromoGrRelation2.SETRANGE("Source Type", DPromoGrRelation."Source Type"::Vendor);
        //         //             DPromoGrRelation2.SETRANGE("Source No.", "No.");
        //         //             DPromoGrRelation2.DELETEALL;
        //         //             //<<DITW17.10.05 MSF 24/07/14 DIT-770 #723
        //         //             DefaultDim.SETRANGE("Table ID", DATABASE::Vendor);
        //         //             DefaultDim.SETRANGE("No.", "No.");
        //         //             DefaultDim.DELETEALL;
        //         //             //>>DITW17.10.05 MSF 24/07/14 DIT-770 #723
        //         //         end else begin
        //         //             "Vendor Template Code" := xRec."Vendor Template Code";
        //         //             exit;
        //         //         end;
        //         //     end;
        //         //sharmp16 end drink-itcode<<

        //         VendTemplate.GET("Vendor Template Code");
        //         //<<DITW17.10.05 WSA 21/08/2014 DIT-770 #723
        //         if VendTemplate."Territory Code" <> '' then
        //             VALIDATE("Territory Code", VendTemplate."Territory Code");
        //         if VendTemplate."Currency Code" <> '' then
        //             VALIDATE("Currency Code", VendTemplate."Currency Code");
        //         if VendTemplate."Country/Region Code" <> '' then
        //             VALIDATE("Country/Region Code", VendTemplate."Country/Region Code");
        //         if VendTemplate."Vendor Posting Group" <> '' then
        //             VALIDATE("Vendor Posting Group", VendTemplate."Vendor Posting Group");
        //         if VendTemplate."Invoice Disc. Code" <> '' then
        //             VALIDATE("Invoice Disc. Code", VendTemplate."Invoice Disc. Code");
        //         if VendTemplate."Gen. Bus. Posting Group" <> '' then
        //             VALIDATE("Gen. Bus. Posting Group", VendTemplate."Gen. Bus. Posting Group");
        //         if VendTemplate."VAT Bus. Posting Group" <> '' then
        //             VALIDATE("VAT Bus. Posting Group", VendTemplate."VAT Bus. Posting Group");
        //         if VendTemplate."Payment Terms Code" <> '' then
        //             VALIDATE("Payment Terms Code", VendTemplate."Payment Terms Code");
        //         if VendTemplate."Payment Method Code" <> '' then
        //             VALIDATE("Payment Method Code", VendTemplate."Payment Method Code");
        //         if VendTemplate."Shipment Method Code" <> '' then
        //             VALIDATE("Shipment Method Code", VendTemplate."Shipment Method Code");
        //         if VendTemplate."DDeposit Group Code" <> '' then
        //             VALIDATE("Vendor DDeposit Group Code", VendTemplate."DDeposit Group Code");
        //         if VendTemplate."DTax Group Code" <> '' then
        //             VALIDATE("Vendor DTax Group Code", VendTemplate."DTax Group Code");
        //         if VendTemplate."Shipping Agent Code" <> '' then
        //             VALIDATE("Shipping Agent Code", VendTemplate."Shipping Agent Code");
        //         if VendTemplate."Shipping Agent Service Code" <> '' then
        //             VALIDATE("Shipping Agent Service Code", VendTemplate."Shipping Agent Service Code");
        //         if VendTemplate."Responsibility Center" <> '' then
        //             VALIDATE("Responsibility Center", VendTemplate."Responsibility Center");
        //         if VendTemplate."Location Code" <> '' then
        //             VALIDATE("Location Code", VendTemplate."Location Code");
        //         if VendTemplate."Base Calendar Code" <> '' then
        //             VALIDATE("Base Calendar Code", VendTemplate."Base Calendar Code");
        //         if VendTemplate.Distance <> 0 then
        //             VALIDATE(Distance, VendTemplate.Distance);
        //         VALIDATE("Application Method", VendTemplate."Application Method");
        //         if VendTemplate."Contract Vend. Post. Gr. Rent" <> '' then
        //             VALIDATE("Contract Vend. Post. Gr. Rent", VendTemplate."Contract Vend. Post. Gr. Rent");
        //         if VendTemplate."Contract Vend. Post. Gr. Loan" <> '' then
        //             VALIDATE("Contract Vend. Post. Gr. Loan", VendTemplate."Contract Vend. Post. Gr. Loan");
        //         if VendTemplate."Contract Vend. Post. Gr. LoanU" <> '' then
        //             VALIDATE("Contract Vend. Post. Gr. LoanU", VendTemplate."Contract Vend. Post. Gr. LoanU");
        //         if VendTemplate."Contract Vend. Post. Gr. Maint" <> '' then
        //             VALIDATE("Contract Vend. Post. Gr. Maint", VendTemplate."Contract Vend. Post. Gr. Maint");
        //         if VendTemplate."Contract Vend. Post. Gr. Other" <> '' then
        //             VALIDATE("Contract Vend. Post. Gr. Other", VendTemplate."Contract Vend. Post. Gr. Other");
        //         VALIDATE("Loan Interest Vend. Post. Grp.", VendTemplate."Loan Interest Vend. Post. Grp.");
        //         if VendTemplate."Vendor Posting Group" <> '' then
        //             VALIDATE("Vendor Posting Group", VendTemplate."Vendor Posting Group");
        //         if VendTemplate."Loan Interest Vend. Post. Grp." <> '' then
        //             VALIDATE("Loan Interest Vend. Post. Grp.", VendTemplate."Loan Interest Vend. Post. Grp.");
        //         // >>DITW17.10.05 WSA 21/08/2014 DIT-770 #723

        //         //sharmp16 begin drink-itcode>>
        //         //  DDiscGrRelation.RESET;
        //         //     DDiscGrRelation.SETRANGE("Source Type", DDiscGrRelation."Source Type"::TVendor);
        //         //     DDiscGrRelation.SETRANGE("Source No.", VendTemplate.Code);
        //         //     if DDiscGrRelation.findset then
        //         //         repeat
        //         //             DDiscGrRelation2 := DDiscGrRelation;
        //         //             DDiscGrRelation2."Source Type" := DDiscGrRelation2."Source Type"::Vendor;
        //         //             DDiscGrRelation2."Source No." := "No.";
        //         //             if DDiscGrRelation2.INSERT then;
        //         //         until DDiscGrRelation.NEXT = 0;

        //         //     DPromoGrRelation.RESET;
        //         //     DPromoGrRelation.SETRANGE("Source Type", DPromoGrRelation."Source Type"::TVendor);
        //         //     DPromoGrRelation.SETRANGE("Source No.", VendTemplate.Code);
        //         //     if DPromoGrRelation.findset then
        //         //         repeat
        //         //             DPromoGrRelation2 := DPromoGrRelation;
        //         //             DPromoGrRelation2."Source Type" := DPromoGrRelation2."Source Type"::Vendor;
        //         //             DPromoGrRelation2."Source No." := "No.";
        //         //             if DPromoGrRelation2.INSERT then;
        //         //         until DPromoGrRelation.NEXT = 0;
        //         //sharmp16 end drink-itcode<<

        //         DefaultDim.SETRANGE("Table ID", DATABASE::"Vendor Templ.");//sharmp16 
        //         DefaultDim.SETRANGE("No.", VendTemplate.Code);
        //         DimMgt.MoveDefaultDimToDefaultDim(DefaultDim, DATABASE::Vendor, "No.");
        //         DimMgt.UpdateDefaultDim(
        //           DATABASE::Vendor, "No.",
        //           "Global Dimension 1 Code", "Global Dimension 2 Code");
        //         ///DITW110.00.11 MSF 08/11/2017 NRQ#13577
        //         MODIFY(true);
        //     end;
        //     end;
        // }
        // field(2014495; "Delivery Sequence"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Delivery Sequence',
        //                 FRA = 'Séquence de livraison';
        //     Description = 'DITW18.00.07 #1968 - #1977';
        //     MinValue = 0;
        // }
        // field(2029610; "Allow Emergency Orders"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Emergency Orders',
        //                 FRA = 'Autoriser les commandes Urgentes';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2029611; "Shortcut Property 1 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,1/23';
        //     CaptionML = ENU = 'Shortcut Property 1 Code',
        //                 FRA = 'Code raccourci propriété 1';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(1));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 1 Code" := fctValidateShortcutPropertyCode(1, "Shortcut Property 1 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029612; "Shortcut Property 2 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,2/23';
        //     CaptionML = ENU = 'Shortcut Property 2 Code',
        //                 FRA = 'Code raccourci propriété 2';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(2));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 2 Code" := fctValidateShortcutPropertyCode(2, "Shortcut Property 2 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029613; "Shortcut Property 3 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,3/23';
        //     CaptionML = ENU = 'Shortcut Property 3 Code',
        //                 FRA = 'Code raccourci propriété 3';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(3));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 3 Code" := fctValidateShortcutPropertyCode(3, "Shortcut Property 3 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029614; "Shortcut Property 4 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,4/23';
        //     CaptionML = ENU = 'Shortcut Property 4 Code',
        //                 FRA = 'Code raccourci propriété 4';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(4));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 4 Code" := fctValidateShortcutPropertyCode(4, "Shortcut Property 4 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029615; "Shortcut Property 5 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,5/23';
        //     CaptionML = ENU = 'Shortcut Property 5 Code',
        //                 FRA = 'Code raccourci propriété 5';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(5));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 5 Code" := fctValidateShortcutPropertyCode(5, "Shortcut Property 5 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029616; "Shortcut Property 6 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,6/23';
        //     CaptionML = ENU = 'Shortcut Property 6 Code',
        //                 FRA = 'Code raccourci propriété 6';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(6));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 6 Code" := fctValidateShortcutPropertyCode(6, "Shortcut Property 6 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029617; "Shortcut Property 7 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,7/23';
        //     CaptionML = ENU = 'Shortcut Property 7 Code',
        //                 FRA = 'Code raccourci propriété 7';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(7));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 7 Code" := fctValidateShortcutPropertyCode(7, "Shortcut Property 7 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029618; "Shortcut Property 8 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,8/23';
        //     CaptionML = ENU = 'Shortcut Property 8 Code',
        //                 FRA = 'Code raccourci propriété 8';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(8));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 8 Code" := fctValidateShortcutPropertyCode(8, "Shortcut Property 8 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029619; "Shortcut Property 9 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,9/23';
        //     CaptionML = ENU = 'Shortcut Property 9 Code',
        //                 FRA = 'Code raccourci propriété 9';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(9));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 9 Code" := fctValidateShortcutPropertyCode(9, "Shortcut Property 9 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029620; "Shortcut Property 10 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,10/23';
        //     CaptionML = ENU = 'Shortcut Property 10 Code',
        //                 FRA = 'Code raccourci propriété 10';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(23),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(10));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 10 Code" := fctValidateShortcutPropertyCode(10, "Shortcut Property 10 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2030011; "Interface Partner"; Code[50])
        // {
        //     CaptionML = ENU = 'Interface Partner',
        //                 FRA = 'Interface Partenaire';
        //     Description = 'IPLXL9.00.001';
        //     TableRelation = "Interface Partner";
        // }
        // field(2034850; "DIT Sub-Contract Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type Filter',
        //                 FRA = 'Filtre sous type contrat';
        //     Description = 'DITW15.00.00.37- DIT-715 #297';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034851; "Loan Interest Vend. Post. Grp."; Code[10])
        // {
        //     CaptionML = ENU = 'Loan Interest Vend. Post. Grp.',
        //                 FRA = 'Groupe Compta. Prêt Interêt Fournisseur';
        //     Description = 'DITW17.00.02 DIT-770 #163';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2034872; "Contract Group Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Contract Group Filter',
        //                 FRA = 'Filtre groupe contrat';
        //     Description = 'DITW15.00.00.37';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Contract Group" where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type Filter"));
        // }
        // field(2034873; "Contract Vend. Post. Gr. Stand"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Posting Group (Service)',
        //                 FRA = 'Groupe compta. fournisseur (Service)';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2034905; "Contract Gain/Loss Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Contract Purch Gain/Loss Entry".Amount where("Vendor No." = FIELD("No."),
        //                                                                      "Order Address Code" = FIELD("Order Address Filter"),
        //                                                                      "Change Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'Contract Gain/Loss Amount',
        //                 FRA = 'Montant gain/perte contrat';
        //     Description = 'DITW15.00.00.35';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2034906; "Order Address Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Order Address Filter',
        //                 FRA = 'Filtre Adresse commande';
        //     Description = 'DITW15.00.00.35';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Order Address".Code where("Vendor No." = FIELD("No."));
        // }
        // field(2034907; "Outstanding Serv. Orders (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Service Purchase Line"."Outstanding Amount (LCY)" where("Document Type" = CONST(Order),
        //                                                                                 "Pay-to Vendor No." = FIELD("No."),
        //                                                                                 "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                                 "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                                 "Currency Code" = FIELD("Currency Filter")));
        //     CaptionML = ENU = 'Outstanding Serv. Orders (LCY)',
        //                 FRA = 'Commandes serv. ouvertes DS';
        //     Description = 'DITW15.00.00.35';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2034908; "Serv Received NotInvoiced(LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Service Purchase Line"."Received Not Invoiced (LCY)" where("Document Type" = CONST(Order),
        //                                                                                    "Pay-to Vendor No." = FIELD("No."),
        //                                                                                    "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                                    "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                                    "Currency Code" = FIELD("Currency Filter")));
        //     CaptionML = ENU = 'Serv Recveived Not Invoiced (LCY)',
        //                 FRA = 'Serv. reçu non facturé DS';
        //     Description = 'DITW15.00.00.35';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2034910; "Contract Vend. Post. Gr. Rent"; Code[10])
        // {
        //     CaptionML = ENU = 'Rent - Vendor Posting Group',
        //                 FRA = 'Location - Groupe compta. fournisseur';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2034911; "Contract Vend. Post. Gr. Loan"; Code[10])
        // {
        //     CaptionML = ENU = 'Loan - Vendor Posting Group',
        //                 FRA = 'Prêt - Groupe compta. fournisseur';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2034912; "Contract Vend. Post. Gr. LoanU"; Code[10])
        // {
        //     CaptionML = ENU = 'Loan in Use - Vendor Posting Group',
        //                 FRA = 'Prêt à usage - Groupe compta. fournisseur';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2034913; "Contract Vend. Post. Gr. Maint"; Code[10])
        // {
        //     CaptionML = ENU = 'Maintenance - Vendor Posting Group',
        //                 FRA = 'Maintenance - Groupe compta. fournisseur';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2034914; "Contract Vend. Post. Gr. Other"; Code[10])
        // {
        //     CaptionML = ENU = 'Other - Vendor Posting Group',
        //                 FRA = 'Autre - Groupe compta. fournisseur';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2034915; "Service Contract No. Filter"; Code[20])
        // {
        //     CaptionML = ENU = 'Financial Contract No. Filter',
        //                 FRA = 'Filtre N° contrat financier';
        //     Description = 'DITW16.00.00.41 DIT-715 #327';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract));
        // }
        // field(2034943; "Vendor Posting Group Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Vendor Posting Group Filter',
        //                 FRA = 'Filtre Groupe compta. fournisseur';
        //     Description = 'DITW17.00.02 SR DIT-770 #163';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Vendor Posting Group";
        // }
        // field(2035090; "No. of Quality Tests"; Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" where("Source Vendor No." = FIELD("No."),
        //                                                      "Document Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'No. of Quality Tests',
        //                 FRA = '<Nbre de Tests Qualité>';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035390; "Linked Customer No."; Code[20])
        // {
        //     CaptionML = ENU = 'Linked Customer No.',
        //                 FRA = 'N° Cilent Lié';
        //     Description = 'DITW17.00.02 DIT-770 #153';
        //     TableRelation = Customer."No.";
        // }
        // field(2035391; "Balance (LCY) (INV.)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = FIELD("No."),
        //                                                                            "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
        //                                                                            "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
        //                                                                            "Currency Code" = FIELD("Currency Filter"),
        //                                                                            "Posting Date" = FIELD("Date Filter"),
        //                                                                            "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type Filter"),
        //                                                                            "Service Contract No." = FIELD("Service Contract No. Filter"),
        //                                                                            "Item Charge Type" = FIELD("Item Charge Type Filter"),
        //                                                                            "Vendor Posting Group" = FIELD("Vendor Posting Group Filter"),
        //                                                                            "Initial Document Type" = FILTER('Invoice|')));
        //     Caption = 'Balance (LCY) (INV.)';
        //     Description = 'NRQ#39758';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035392; "Balance (LCY) (CM/PMT.)"; Decimal)
        // {

        //     AutoFormatType = 1;
        //     CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = FIELD("No."),
        //                                                                            "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
        //                                                                            "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
        //                                                                            "Currency Code" = FIELD("Currency Filter"),
        //                                                                            "Posting Date" = FIELD("Date Filter"),
        //                                                                            "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type Filter"),
        //                                                                            "Service Contract No." = FIELD("Service Contract No. Filter"),
        //                                                                            "Item Charge Type" = FIELD("Item Charge Type Filter"),
        //                                                                            "Vendor Posting Group" = FIELD("Vendor Posting Group Filter"),
        //                                                                            "Initial Document Type" = FILTER('Credit Memo|Payment')));
        //     Caption = 'Balance (LCY) (CM/PMT.)';
        //     Description = 'NRQ#39758';
        //     Editable = false;
        //     FieldClass = FlowField;

        // }
        //BCUpgradesharmp16 drinkitfields end <<
    }
    keys
    {
        //BCUpgradesharmp16 drinkit keys>>
        // key(Key1; "Vendor DDeposit Group Code")
        // {
        // }
        // key(Key2; "Vendor DTax Group Code")
        // {
        // }
        //BCUpgrade sharmp16 drinkit keys<<
        key(Key17; GLN)
        {
        }
        // key(Key18; ABN, "ABN Division Part No.")
        // {
        // }//BC UPgrade SHARMP16 FrenchLocalization Fields used in Keys
        // key(Key5; Blocked)
        // {
        // }//sharmp16 already defined in BC
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: PurchTaxItemCharge)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec);

    MoveEntries.MoveVendorEntries(Rec);
    #4..22
      PurchOrderLine."Document Type"::Order,
      PurchOrderLine."Document Type"::"Return Order");
    PurchOrderLine.SETRANGE("Pay-to Vendor No.","No.");
    IF PurchOrderLine.FINDFIRST THEN
      ERROR(
        Text000,
        TABLECAPTION,"No.",
        PurchOrderLine."Document Type");

    PurchOrderLine.SETRANGE("Pay-to Vendor No.");
    PurchOrderLine.SETRANGE("Buy-from Vendor No.","No.");
    IF NOT PurchOrderLine.ISEMPTY THEN
      ERROR(
        Text000,
        TABLECAPTION,"No.");
    #38..43
    ServiceItem.MODIFYALL("Vendor No.",'');

    ItemVendor.SETRANGE("Vendor No.","No.");
    ItemVendor.DELETEALL(TRUE);

    IF NOT SocialListeningSearchTopic.ISEMPTY THEN BEGIN
      SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Vendor,"No.");
      SocialListeningSearchTopic.DELETEALL;
    end;

    PurchPrice.SETCURRENTKEY("Vendor No.");
    PurchPrice.SETRANGE("Vendor No.","No.");
    PurchPrice.DELETEALL(TRUE);

    PurchLineDiscount.SETCURRENTKEY("Vendor No.");
    PurchLineDiscount.SETRANGE("Vendor No.","No.");
    PurchLineDiscount.DELETEALL(TRUE);

    CustomReportSelection.SETRANGE("Source Type",DATABASE::Vendor);
    CustomReportSelection.SETRANGE("Source No.","No.");
    CustomReportSelection.DELETEALL;

    PurchPrepmtPct.SETCURRENTKEY("Vendor No.");
    PurchPrepmtPct.SETRANGE("Vendor No.","No.");
    PurchPrepmtPct.DELETEALL(TRUE);

    VATRegistrationLogMgt.DeleteVendorLog(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..25
    if PurchOrderLine.FINDFIRST then
    #27..33
    if not PurchOrderLine.ISEMPTY then
    #35..46
    ItemVendor.DELETEALL(true);

    if not SocialListeningSearchTopic.ISEMPTY then begin
      SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Vendor,"No.");
      SocialListeningSearchTopic.DELETEALL;
    end;
    #53..55
    PurchPrice.DELETEALL(true);
    #57..59
    PurchLineDiscount.DELETEALL(true);
    #61..67
    PurchPrepmtPct.DELETEALL(true);

    // <<DITW15.00.00.23 DDR 01/08/2008
    PurchTaxItemCharge.SETRANGE("Purchase Type",PurchTaxItemCharge."Purchase Type"::Vendor);
    PurchTaxItemCharge.SETRANGE("Purchase Code","No.");
    PurchTaxItemCharge.DELETEALL;

    PurchDepositItemCharge.SETRANGE("Purchase Type",PurchDepositItemCharge."Purchase Type"::Vendor);
    PurchDepositItemCharge.SETRANGE("Purchase Code","No.");
    PurchDepositItemCharge.DELETEALL;

    PurchDiscountItemCharge.SETRANGE("Purchase Type",PurchDiscountItemCharge."Purchase Type"::Vendor);
    PurchDiscountItemCharge.SETRANGE("Purchase Code","No.");
    PurchDiscountItemCharge.DELETEALL;

    PurchPromotionItemCharge.SETRANGE("Purchase Type",PurchPromotionItemCharge."Purchase Type"::Vendor);
    PurchPromotionItemCharge.SETRANGE("Purchase Code","No.");
    PurchPromotionItemCharge.DELETEALL;

    DrinkDiscountRelation.SETRANGE("Source Type",DrinkDiscountRelation."Source Type"::Vendor);
    DrinkDiscountRelation.SETRANGE("Source No.","No.");
    DrinkDiscountRelation.DELETEALL;

    DrinkPromotionRelaton.SETRANGE("Source Type",DrinkPromotionRelaton."Source Type"::Vendor);
    DrinkPromotionRelaton.SETRANGE("Source No.","No.");
    DrinkPromotionRelaton.DELETEALL;
    // >>DITW15.00.00.23 DDR

    VATRegistrationLogMgt.DeleteVendorLog(Rec);

    //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
    PurchSetup.GET;
    if (PurchSetup."Vendor Auto Dimension Code" <> '') then begin
      if rDimValue.GET(PurchSetup."Vendor Auto Dimension Code","No.") then
        rDimValue.DELETE(true);
    end;
    //>> FINXL10.01 AKH 19/07/2017 NRQ#33089

    //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor,"No.",TRUE); //HEI.22 //HEI.23
    if CheckZycusEnable then //HEI.24
      ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor,"No.",true,"Global Delete"); //HEI.23
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      PurchSetup.GET;
      PurchSetup.TESTFIELD("Vendor Nos.");
      NoSeriesMgt.InitSeries(PurchSetup."Vendor Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    IF "Invoice Disc. Code" = '' THEN
      "Invoice Disc. Code" := "No.";

    IF NOT (InsertFromContact OR (InsertFromTemplate AND (Contact <> ''))) THEN
      UpdateContFromVend.OnInsert(Rec);

    DimMgt.UpdateDefaultDim(
      DATABASE::Vendor,"No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if "No." = '' then begin
    #2..4
    end;

    if "Invoice Disc. Code" = '' then
      "Invoice Disc. Code" := "No.";

    if not (InsertFromContact or (InsertFromTemplate and (Contact <> ''))) then
    #11..15

    //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
    PurchSetup.GET;
    if PurchSetup."Vendor Auto Dimension Code" <> '' then begin
      txtDimName := DimMgt.fctGetDimNameFromSource(Name,"Name 2");
      DimMgt.fctUpdateSetupAnyDimValueCode(
        PurchSetup."Vendor Auto Dimension Code","No.",txtDimName,false);
      DimMgt.fctSaveAnyDefaultDimOnInsert(
        DATABASE::Vendor,"No.",PurchSetup."Vendor Auto Dimension Code","No.",
        //<< FINXL10.01 AKH 28/07/2017 NRQ#33089
        rDefaultDim."Value Posting"::" ");
        //>> FINXL10.01 AKH 28/07/2017 NRQ#33089
    end;
    //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
    ///DITW110.00.11 MSF 07/11/2017 NRQ#13577


    //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor,"No.",FALSE); //HEI.22 //HEI.23
    if CheckZycusEnable then//HEI.24
      ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor,"No.",false,"Global Delete"); //HEI.23
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF (Name <> xRec.Name) OR
       ("Search Name" <> xRec."Search Name") OR
       ("Name 2" <> xRec."Name 2") OR
       (Address <> xRec.Address) OR
       ("Address 2" <> xRec."Address 2") OR
       (City <> xRec.City) OR
       ("Phone No." <> xRec."Phone No.") OR
       ("Telex No." <> xRec."Telex No.") OR
       ("Territory Code" <> xRec."Territory Code") OR
       ("Currency Code" <> xRec."Currency Code") OR
       ("Language Code" <> xRec."Language Code") OR
       ("Purchaser Code" <> xRec."Purchaser Code") OR
       ("Country/Region Code" <> xRec."Country/Region Code") OR
       ("Fax No." <> xRec."Fax No.") OR
       ("Telex Answer Back" <> xRec."Telex Answer Back") OR
       ("VAT Registration No." <> xRec."VAT Registration No.") OR
       ("Post Code" <> xRec."Post Code") OR
       (County <> xRec.County) OR
       ("E-Mail" <> xRec."E-Mail") OR
       ("Home Page" <> xRec."Home Page")
    THEN BEGIN
      MODIFY;
      UpdateContFromVend.OnModify(Rec);
      IF NOT FIND THEN BEGIN
        RESET;
        IF FIND THEN;
      end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    if (Name <> xRec.Name) or
       ("Search Name" <> xRec."Search Name") or
       ("Name 2" <> xRec."Name 2") or
       (Address <> xRec.Address) or
       ("Address 2" <> xRec."Address 2") or
       (City <> xRec.City) or
       ("Phone No." <> xRec."Phone No.") or
       ("Telex No." <> xRec."Telex No.") or
       ("Territory Code" <> xRec."Territory Code") or
       ("Currency Code" <> xRec."Currency Code") or
       ("Language Code" <> xRec."Language Code") or
       ("Purchaser Code" <> xRec."Purchaser Code") or
       ("Country/Region Code" <> xRec."Country/Region Code") or
       ("Fax No." <> xRec."Fax No.") or
       ("Telex Answer Back" <> xRec."Telex Answer Back") or
       ("VAT Registration No." <> xRec."VAT Registration No.") or
       ("Post Code" <> xRec."Post Code") or
       (County <> xRec.County) or
       ("E-Mail" <> xRec."E-Mail") or
       ("Home Page" <> xRec."Home Page")
    then begin
      MODIFY;
      UpdateContFromVend.OnModify(Rec);
      if not FIND then begin
        RESET;
        if FIND then;
      end;
    end;
    ///DITW110.00.11 MSF 08/11/2017 NRQ#13577 - DITW15.00.00.33 DDR 08/05/2009
    if CheckZycusEnable then //HEI.24
      UpdateLocaltimestamp; //HEI.22
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnRename". Please convert manually.

    //trigger (Variable: lcodNewNo)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
    "Last Date Modified" := TODAY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
    //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
    PurchSetup.GET;
    if (PurchSetup."Vendor Auto Dimension Code" <> '') then begin
      txtDimName := DimMgt.fctGetDimNameFromSource(Name,"Name 2");
      DimMgt.fctRenameSetupAnyDimValueCode(
        PurchSetup."Vendor Auto Dimension Code",xRec."No.","No.",txtDimName);
      //<< FINXL10.01 AKH 28/07/2017 NRQ#33089
      lcodNewNo := "No.";
      GET(xRec."No.");
      "No." := lcodNewNo;
      //>> FINXL10.01 AKH 28/07/2017 NRQ#33089
    end;
    //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
    "Last Date Modified" := TODAY;

    //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor,"No.",FALSE); //HEI.22 //HEI.23
    if CheckZycusEnable then //HEI.24
      ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::Vendor,"No.",false,"Global Delete"); //HEI.23
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    // PurchTaxItemCharge: Record "Purchase Tax Item Charge";
    // PurchDepositItemCharge: Record "Purchase Deposit Item Charge";
    // PurchDiscountItemCharge: Record "Purchase Discount Item Charge";
    // PurchPromotionItemCharge: Record "Purchase Promotion Item Charge";
    // DrinkDiscountRelation: Record "Drink Discount Relation";
    // DrinkPromotionRelaton: Record "Drink Promotion Relation";

    var
        lcodNewNo: Code[20];


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.;FRA=Vous ne pouvez pas supprimer %1 %2 car il existe encore au moins une %3 achat ouverte pour ce fournisseur.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You have set %1 to %2. Do you want to update the %3 price list accordingly?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You have set %1 to %2. Do you want to update the %3 price list accordingly?;FRA=Vous avez paramétré %1 sur %2. Souhaitez-vous mettre à jour la liste des prix %3 en conséquence ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Do you wish to create a contact for %1 %2?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Do you wish to create a contact for %1 %2?;FRA=Souhaitez-vous créer un contact pour %1 %2 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Contact %1 %2 is not related to vendor %3 %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Contact %1 %2 is not related to vendor %3 %4.;FRA=Le contact %1 %2 n'est pas associé au fournisseur %3 %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=post;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=post;FRA=valider;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=create;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=create;FRA=créer;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot %1 this type of document when Vendor %2 is blocked with type %3;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot %1 this type of document when Vendor %2 is blocked with type %3;FRA=Vous ne pouvez pas %1 ce type de document lorsque le fournisseur %2 est bloqué avec le type %3;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1025)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.;FRA=La valeur %1 %2 a été affectée à %3 %4.\La même valeur %1 ne peut pas être entrée sur plus d'un/une %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1027)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?;FRA=Le rapprochement des transactions IC risque de poser problème si vous modifiez le code partenaire IC car ce/cette %1 comporte des écritures comptables appartenant à un exercice comptable qui n'a pas encore été clôturé.\ Souhaitez-vous quand même modifier le code partenaire IC ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1026)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.;FRA=Vous ne pouvez pas modifier la valeur du champ %1 car ce/cette %2 comporte une ou plusieurs écritures comptables ouvertes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;FRA=Avant de pouvoir utiliser Online Map, vous devez compléter la fenêtre Configuration Online Map.\Consultez la section Configuration d'Online Map dans l'Aide.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SelectVendorErr(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SelectVendorErr : ENU=You must select an existing vendor.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectVendorErr : ENU=You must select an existing vendor.;FRA=Vous devez sélectionner un fournisseur existant.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateNewVendTxt(Variable 1129)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateNewVendTxt : @@@="%1 is the name to be used to create the customer. ";ENU=Create a new vendor card for %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateNewVendTxt : @@@="%1 is the name to be used to create the customer. ";ENU=Create a new vendor card for %1.;FRA=Créez une fiche fournisseur pour %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "VendNotRegisteredTxt(Variable 1128)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //VendNotRegisteredTxt : ENU=This vendor is not registered. To continue, choose one of the following options:;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VendNotRegisteredTxt : ENU=This vendor is not registered. To continue, choose one of the following options:;FRA=Ce fournisseur n'est pas enregistré. Pour continuer, sélectionnez l'une des options suivantes :;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SelectVendTxt(Variable 1118)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SelectVendTxt : ENU=Select an existing vendor.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectVendTxt : ENU=Select an existing vendor.;FRA=Sélectionnez un fournisseur existant.;
    //Variable type has not been exported.


    var
        BankAccount: Record "Bank Account";
        rDefaultDim: Record "Default Dimension";
        //PurchasesUtils: Codeunit "Purchases-Utils";//BCUpgrade sharmp16
        rDim: Record Dimension;
        rDimValue: Record "Dimension Value";
        //ZycusMasterTimestamp: Record "Zycus Master Timestamp FND"; // BC Upgrade SHUKLP03 <<
        PaymentMethod: Record "Payment Method";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        VendorBankAccount: Record "Vendor Bank Account";
        VendTemplate: Record "Vendor Templ.";
        HeinekenGlobal: Codeunit "Heineken Global";//BCUpgrade sharmp16
        UserMgt: Codeunit "User Setup Management";//BCUpgrade sharmp16
        Text15000: Label 'The field %1 must be blank.';
        Text50000: Label 'There should be atleast one bank linked to this Vendor.';
        Text50001: Label 'Bank Details are missing';
        Text50002: Label 'You cannot create this type of document when sensitive payment block is enable for Vendor %1';
        Text2029611: Label '%1 is not valid';
        Text2029612: Label '%1 is valid\Name: %2\Address: %3';
        txtDimName: Text;
        Text2013660: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        Text2014410: TextConst ENU = 'Do you want to replace the existing vendor %1 data using the vendor template %2?', FRA = 'Voulez vous remplacer les données existantes du fournisseur %1 en utilisant le modéle de fournisseur %2 ?';
        Text2014411: TextConst ENU = 'Do you want to clear all fields before?', FRA = 'Souhaitez-vous effacer tous les champs avant?';
        // DDiscGrRelation: Record "Drink Discount Relation";  // BC Upgrade SHUKLP03 <<
        // DPromoGrRelation: Record "Drink Promotion Relation"; // BC Upgrade SHUKLP03 <<
        Text2014412: TextConst ENU = 'You are not allowed to release a Vendor (user setup)', FRA = 'Opération non autorisée';
        Text2014413: TextConst ENU = 'Do you want to replace the existing %1 with the one from this %2?', FRA = 'Voulez vous remplacer le %1 existant par celui de ce %2?';

}

