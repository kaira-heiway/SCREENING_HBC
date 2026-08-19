pageextension 51067 VendorCardExtCBN extends "Vendor Card"
{
    // version NAVW110.0.00.15601,FINXL10.00,QXL9.00.001,IPLXL9.00.001,DITW111.00.13,NRQ#101918,HEI.17,SB
    // DITW15.00.00.01 DDR 26/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 21/12/2007 added tab "Drink Tax"
    //                                added fields
    //                                  2034647 Drink Tax Group Code
    //                                added menu item charges into Purchase button
    // DITW15.00.00.01 DDR 03/01/2008 Rename tab "Drink Tax" -> "Drink-It"
    //                                added fields
    //                                  2013610 Item DDeposit Group Code
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 08/01/2008 Added "Empty Goods Tracking" into Vendor menu button
    // DITW15.00.00.01 DDR 09/01/2008 Remove key sorting for Tax/Depoist Item charges menu
    // DITW15.00.00.01 DDR 21/01/2008 Added Drink-it Disc.& Promotion functionalities
    //                                added "No. of Drink Disc. Groups","No. of Promotion Groups"
    //                                added menu into Vendor, Sales & Purchases
    // DITW15.00.00.01 DDR 31/01/2008 Added Drink-it Reversing Calculation (Rounding) functionnalities
    //                                Added column "Price Incl. Reversing Calc."
    // DITW15.00.00.01 DDR 05/02/2008 Change captions menu (Drink-it)
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.21 DDR 27/06/2008 Added menu "Shipping Agents" into Vendor button
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.24 DDR 07/10/2008 Added field2013722 Duty Tax Type into "Drink-It" tab
    // DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    // DITW15.00.00.28 DDR 24/11/2008 Added tab "Drink-It"
    //                                Added fields "Tax Registration No.","Fiscal Representative No." into tab Drink-It
    // DITW15.00.00.32 DDR 06/04/2009 Added field "AAD Std. Text (Area 23) Code" into Drink-It tab
    // DITW15.00.00.33 DDR 11/05/2009 Removed field "AAD Std. Text (Area 23) Code" into Drink-It tab
    // DITW15.00.00.35 DDR 24/06/2009 Added field into Drink-It tab
    //                                  "Gen. Bus. Posting Free Group","Free Item Posting Type"
    //                                issue 772 save record before lookup Drink Discount/Promotion groups
    //                     09/09/2009 Added "Building" tab
    //                                Added field "Contract Cust. Posting Group" into Drink-It tab
    //                                Added menu "service contracts","Service Items","Service Contracts Lines" into "Vendor" button
    //                     23/09/2009 issue 814 Split customer posting group per contract type (+ copy default value)
    //                                  Added 'Contract' tab + fields
    // DITW15.00.00.37 DDR 02/04/2010 issue 1110 Added field "Transport Time" into Drink-It tab
    // DITW16.00.00.37 DDR 13/01/2011 DIT-715 issue 42 RTC Upgrade: Added lookup triggers for flowfields
    //                                             "No. of Drink Disc. Groups","No. of Promotion Groups"
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    (General tab) "Vendor Template Code"
    //                                    (Shipping) "Shipping Agent Code","Shipping Agent Service Code","Distance"
    //                                    (Foreign Trade) "Transaction Type","Transport Method","Transaction Specification",
    //                                      "Exit Point","Area Code"
    //                                  Modified controls for 'LookupFormID' property
    //                                    "Customer DTax Group Code","Customer DDeposit Group Code"
    //                     13/09/2010   Added fields
    //                                    (Drink-it) "Tax Warehouse Reference","Tax Office Code"
    //                     19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Entries' into 'Purchase' menu button
    // DITW15.00.00.38 PRODW14.00.00.17 DDR 08/02/2011 #1271
    //                                  Added menu 'Quality Lot Tests' into 'Vendor' menu button
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added fields "Journey Time" into 'Drink-it' tab
    // DITW16.00.00.39 DDR 25/07/2011 DIT-715 issue 93 merge error: (Receiving tab) fields "Location Code","Base Calendar Code"
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 (Drink-it tab) Added fields "Journey Time"
    //                     27/07/2011 issue 1407 (Drink-it tab) Added fields "Autom. Item Charge"
    //                     29/08/2011 issue 1396 Added fields "No. of Exclusivity Groups" into 'Drink-it' tab
    //                                           Added 'Exclusivity Groups' menu into 'Vendor' button
    //                                           Added 'Item Exclusivity' menu into 'Purchases' button
    //                     30/08/2011 issue 1397 Added local control to calculate the Sub Contract Balance (LCY)
    //                                           Added functions DrillDownContractBalanceLCY(),CalcContractBalanceLCY()
    //                     23/09/2011 issue 1397 Bugfix functions CalcContractBalanceLCY()
    // DITW16.00.00.41 AHU 07/08/2012 DIT-715 #327 Moved functions to table18 Customer
    //                                               DrillDownContractBalanceLCY(),CalcContractBalanceLCY()
    //                 AHU 31/08/2012 DIT-715 #327 Added "Customer Posting Group","Balance (LCY)" into 'Contract' tab
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields into 'Drink-It' tab
    //                                               "Deposit Vendor Posting Group","Deposit Payment Terms Code",
    //                                               "Deposit Payment Method Code",,"Split Deposit on Invoice"
    //                 AHU 18/12/2012 DIT-715 #327 Updated control1100076014
    //                 DDR 10/06/2013 DIT-715 #623 Bugfix Drilldown fields "Loan in Use Balance","Maintenance Balance",

    // FINXL7.00.001 RBE 20/03/2013 : Added VAT Validation
    // FINXL7.00.001 WSA 15/07/2014 #88 : Removed fct fctValidateVAT
    // FINXL8.00.001 BSA 05/06/2015 #182 : Added Field "Allow Emergency Orders"
    // FINXL8.00.001 BSA 23/06/2015 #161 : Apply Template when create New Vendor
    // FINXL8.00.001 BSA 24/06/2015 #63 : Copy Vendor Card, Pucahse prices, Purchase Discounts
    // FINXL8.00.001 DAT 20/08/2015 : Modified actions "Purchase Quote", "Purchase Invoice", "Purchase Order" and "Purchase Credit Memo"

    // DITW17.00.02 DDR 10/06/2013 DIT-715 #623 merge
    //                  04/07/2013 DIT-770 #99 Added 'Tax Report (UK)' tab
    //                                         Added field "GWC Country/Region Code"
    //              DDR 09/08/2013 DIT-770 #102 Modified 'LookupPageID' property field "Drink Tax Group"
    //                                          Added 'Tax Groups' Action into 'Relation' button
    //                  28/08/2013 DIT-770 #178 Remove DIT-770 #99 (Keep #102)
    // DITW17.00.02 SR 10/09/2013 DIT-770 #143 : change log actions
    //                                         : Moved Chnage Log functionality to menuitem Vendor
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added in General Tab
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 AT  17/12/2013 DIT-770 #163 : Added fields
    //                                   2034851 Loan Interest Cust. Post. Grp.
    //                                   2034852 Bank Charge Cust. Post. Grp.
    // DITW17.10.03 MSF 11/04/2014 DIT-770 #340 DIT-770 340  Variable customer posting group  (Point 12 Remove Bank chagre cust. posting group)
    //                                     Remove fields "Bank Charge Vend. Post. Grp."
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal
    //                                          Added menu to "Vendor Exception Tax Groups"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 Displayed field "Sundry Vendor" under Invoicing tab
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Fixed caption for field "Sundry Vendor"
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    // FINXL8.00.001 IMI 10/06/2015: Added field GLN
    //               IMI 04/08/2015: Added field "Interface Partner"
    // DITW18.00.07 AKH 20/04/2016 DIT-770 #1941 Added fields under Invoicing tab
    // DITW18.00.07 AKH 27/04/2016 DIT-770 #1346 Added field "Vendor Delivery Type" under Shipping Drink-It
    // DITW18.00.07 AKH 10/05/2016 DIT-770 #1346 Moved field "Vendor Delivery Type" to Receiving tab
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 Add Action Page Link to page "Delivery Times"
    // DITW18.00.07 VSC 26/05/2016 DIT-770 #1976 -> #1002 Added Fields "Minimum Cubage" and "Minimum Weight"
    // DITW19.00.07 MSF 04/07/2016 DIT-770 #1965  Item and Item list/ customer and Customer List - navigate ribbon
    //                                            Check And fix  Ribbon

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL9.00.001 ACH 11/08/2016 : Update actions "Purchase Quote", "Purchase Invoice", "Purchase Order" and "Purchase Credit Memo"
    // FINXL9.00.001 KSW 29/09/2016 : Update actions "Purchase Quote", "Purchase Invoice", "Purchase Order" and "Purchase Credit Memo"
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // IPLXL9.00.001 FBL 10/01/2017: Add field "Interface Partner"
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.11 MSF 08/11/2017 NRQ#13577 Move Customer Template Under Name 2
    // DITW110.00.11 SFI 12/12/2017 NRQ#10509 Sales and purchase gross net prices

    // HEI.01 FDD–PURGAP05 IBM LAZARE02 25.07.2017
    //   # Added fields County and Tax Area Code in the Address tab
    //   # Added all HEI.02 fields from the Vendor table
    //   # Set visible = false for Properties fasttab
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 17.08.2017 # MDM Customer Card
    //   # Added field "WHT Business Posting Group"
    // HEI.03 FDD-PTPGAP007 IBM PATHAA02 28.08.2017
    //   # Aligned field "Blocked reason Code"
    // HEI.04 FDD PTPGAP084 IBM POSTOI01 05.04.2018
    //   # show new field "Sensitive Workflow Block"
    // HEI.05 CHG0245208 IBM LAZARE02 09.07.2018
    //   # new field Send to Maximo
    // HEI.06 IBM.NAIKH01 , 16.10.2018, FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 and BRD V4.02 25-07-2018_Local Vendor type-Vendor Category and label Vendor
    //   # Added a new field "Local Vendor Type"
    //   # Modified the Caption of field  "Vendor Type" to "Vendor Account Group"
    // HEI.07 FDDPTPGAPLOG01 IBM ISYED01 Remittance advaice.
    //   #added new filed "Remittance emial" to Page vendor card.
    // HEI.08 FDD-HT658 IBM.GUNERE01 23.09.2019 # "No. of Shipping Agent Rel." field added
    // HEI.09 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Added fields in Payments group: "Balance (LCY)", "Payment in progress (LCY)", "Balance (LCY)" - "Payment in progress (LCY)"
    // HEI.10 FDD-HT545 IBM POSTOI01 08.10.2019
    //   # show new field 50059 Self-Billing Boolean type, Invoicing tab
    // HEI.12 CHG2036764 HB969 IBM PANDES01 17/03/2020
    //   # disable Send to Maximo field.
    // HEI.13 CHG2019432 IBM SHANKJ03  03.23.2021
    //   # Removed Remittance Advice Email Field
    // HEI.14 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # Defaul SPL Code - field added
    // HEI.15 CHG2162715 HB3020 NORRIQ KOROLA04 14.11.2022
    //   # SPL Code - button added
    // HEI.16 CHG2162715 HB3020 NORRIQ KOROLA04 30.11.2022
    //   # Defaul SPL Code - field removed
    // HEI.17 CHG2210794 MAJUMS03 21.03.2024 Zycus - BASE HL Integration Master Vendor and GL Account.
    //   # New Page Action ZycusTimeStamp is added to view the related Zycus Time Stamp Entry via Zycus Master Timestamp Page of the
    //   specific Vendor to show when the Last Zycus related record is Inserted or Deleted or Renamed and fields are Modified.

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.', FRA = 'Spécifie le numéro du fournisseur. Le champ est renseigné automatiquement à partir d''une souche de numéros définie, ou vous saisissez manuellement le numéro car vous avez activé la saisie manuelle de numéro dans le paramétrage de la souche de numéros.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the vendor''s name. You can enter a maximum of 30 characters, both numbers and letters.', FRA = 'Spécifie le nom du fournisseur. Vous pouvez entrer au maximum 30 caractères, des chiffres et des lettres.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies which transactions with the vendor that cannot be posted.', FRA = 'Spécifie les transactions avec le fournisseur qui ne peuvent pas être validées.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the vendor card was last modified.', FRA = 'Spécifie la date à laquelle la fiche fournisseur a été modifiée pour la dernière fois.';
        }
        // modify("Balance (LCY)")
        // {
        //     ToolTipML = ENU = 'Specifies the total value of your completed purchases from the vendor in the current fiscal year. It is calculated from amounts excluding VAT on all completed purchase invoices and credit memos.', FRA = 'Spécifie la valeur totale de vos achats terminés auprès du fournisseur au cours de l''exercice comptable en cours. Il est calculé à partir des montants HT sur toutes les factures achat et avoirs terminés.';
        // }
        modify("Balance Due (LCY)")
        {
            ToolTipML = ENU = 'Specifies the total value of your unpaid purchases from the vendor in the current fiscal year. It is calculated from amounts excluding VAT on all open purchase invoices and credit memos.', FRA = 'Spécifie la valeur totale de vos achats impayés auprès du fournisseur au cours de l''exercice comptable en cours. Il est calculé à partir des montants HT sur toutes les factures achat et avoirs ouverts.';
        }
        modify("Document Sending Profile")
        {
            ToolTipML = ENU = 'Specifies the preferred method of sending documents to this vendor, so that you do not have to select a sending option every time that you post and send a document to the vendor. Documents to this vendor will be sent using the specified sending profile and will override the default document sending profile.', FRA = 'Spécifie la méthode préférée d''envoi de documents à ce fournisseur afin que vous n''ayez pas à sélectionner une option d''envoi chaque fois que vous validez et envoyez un document à ce fournisseur. Les documents seront envoyés à ce fournisseur en utilisant le profil d''envoi spécifié et remplaceront le profil d''envoi de document par défaut.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies a search name.', FRA = 'Spécifie un nom de recherche.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies a code to specify the purchaser who normally handles this vendor''s account.', FRA = 'Spécifie un code pour préciser l''acheteur qui s''occupe habituellement du compte de ce fournisseur.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code for the responsibility center that will administer this vendor by default.', FRA = 'Spécifie le code du centre de gestion qui gère ce fournisseur par défaut.';
        }
        modify("Address & Contact")
        {
            CaptionML = ENU = 'Address & Contact', FRA = 'Adresse et contact';
        }
        modify(Address)
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        // modify(Control6)
        // {
        //     ToolTipML = ENU = 'Specifies the vendor''s address.', FRA = 'Spécifie l''adresse du fournisseur.';

        //     //Unsupported feature: Change ImplicitType on "Control6(Control 6)". Please convert manually.

        // }//BC Upgrade SHARMP16 
        modify("Address 2")
        {
            ToolTipML = ENU = 'Specifies additional address information.', FRA = 'Spécifie des informations d''adresse supplémentaires.';

            //Unsupported feature: Change ImplicitType on ""Address 2"(Control 8)". Please convert manually.

        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify(City)
        {
            ToolTipML = ENU = 'Specifies the vendor''s city.', FRA = 'Spécifie la ville du fournisseur.';

            //Unsupported feature: Change ImplicitType on "City(Control 10)". Please convert manually.

        }
        modify(ShowMap)
        {
            ToolTipML = ENU = 'Specifies you can view the customer''s address on your preferred map website.', FRA = 'Spécifie que vous pouvez afficher l''adresse du client sur votre site Web de mappage préféré.';
        }
        modify(Contact)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s telephone number.', FRA = 'Spécifie le numéro de téléphone du fournisseur.';
        }
        modify("E-Mail")
        {
            ToolTipML = ENU = 'Specifies the vendor''s email address.', FRA = 'Spécifie l''adresse de messagerie du fournisseur.';
        }
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the customer''s fax number.', FRA = 'Spécifie le numéro de télécopie du client.';
        }
        modify("Language Code")
        {
            ToolTipML = ENU = 'Specifies the language on printouts for this vendor.', FRA = 'Indique la langue des documents imprimés pour ce fournisseur.';
        }
        modify(Invoicing)
        {
            CaptionML = ENU = 'Invoicing', FRA = 'Facturation';
        }
        modify("VAT Registration No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s VAT registration number.', FRA = 'Spécifie le n° identif. intracomm. du fournisseur.';
        }
        modify(GLN)
        {
            ToolTipML = ENU = 'Specifies the vendor in connection with electronic document receiving.', FRA = 'Spécifie le fournisseur en relation avec la réception de documents électroniques.';
        }
        modify("Pay-to Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of a different vendor whom you pay for products delivered by the vendor on the vendor card.', FRA = 'Spécifie le numéro d''un autre fournisseur à qui vous payez des produits livrés par le fournisseur sur la fiche fournisseur.';
        }
        modify("Invoice Disc. Code")
        {
            ToolTipML = ENU = 'Specifies the vendor''s invoice discount code. When you set up a new vendor card, the number you have entered in the No. field is automatically inserted.', FRA = 'Spécifie le code remise facture du fournisseur. Lorsque vous créez une nouvelle fiche fournisseur, le numéro que vous avez saisi dans le champ N° est inséré automatiquement.';
        }
        modify("Prices Including VAT")
        {
            ToolTipML = ENU = 'Specifies if the Direct Unit Cost and Line Amount fields on the purchase lines and in purchase reports should be shown with or without VAT.', FRA = 'Spécifie si les champs Coût unitaire direct et Montant ligne sur les lignes achat et dans les états des achats doivent être affichés avec ou sans la TVA.';
        }
        modify("Posting Details")
        {
            CaptionML = ENU = 'Posting Details', FRA = 'Détails de validation';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s trade type to link transactions made for this vendor with the appropriate general ledger account according to the general posting setup.', FRA = 'Spécifie le type commercial du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de validation généraux.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.', FRA = 'Spécifie le détail TVA du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de comptabilisation TVA.';
        }
        modify("Vendor Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s market type to link business transactions made for the vendor with the appropriate account in the general ledger.', FRA = 'Spécifie le type de marché du fournisseur pour lier les transactions commerciales effectuées pour le fournisseur au compte approprié dans la comptabilité.';
        }
        modify("Foreign Trade")
        {
            CaptionML = ENU = 'Foreign Trade', FRA = 'International';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code that is inserted by default when you create purchase documents or journal lines for the vendor.', FRA = 'Spécifie le code devise qui est inséré par défaut lorsque vous créez des documents achat ou des lignes feuille pour le fournisseur.';
        }
        modify(Payments)
        {
            CaptionML = ENU = 'Payments', FRA = 'Paiements';
        }
        modify("Application Method")
        {
            ToolTipML = ENU = 'Specifies how to apply payments to entries for this vendor.', FRA = 'Spécifie la manière de lettrer des paiements avec des écritures pour ce fournisseur.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a code that indicates the payment terms that the vendor usually requires.', FRA = 'Spécifie un code qui indique les conditions de paiement que le fournisseur exige habituellement.';
        }
        modify("Payment Method Code")
        {
            ToolTipML = ENU = 'Specifies how the vendor requires you to submit payment, such as bank transfer or check.', FRA = 'Spécifie le mode de paiement exigé par le fournisseur, tel que virement bancaire ou chèque.';
        }
        modify(Priority)
        {
            ToolTipML = ENU = 'Specifies the importance of the vendor when suggesting payments using the Suggest Vendor Payments function.', FRA = 'Spécifie l''importance du fournisseur lors de la proposition de paiements à l''aide de la fonction Proposer paiements fournisseur.';
        }
        modify("Block Payment Tolerance")
        {
            ToolTipML = ENU = 'Specifies if the vendor allows payment tolerance.', FRA = 'Spécifie si le fournisseur autorise un écart de règlement.';
        }
        modify("Preferred Bank Account Code")
        {
            ToolTipML = ENU = 'Specifies the vendor bank account that will be used by default on payment journal lines for export to a payment bank file.', FRA = 'Spécifie le compte bancaire fournisseur utilisé par défaut sur les lignes feuille paiement pour l''exportation vers un fichier de la banque de paiement.';
        }
        modify("Partner Type")
        {
            ToolTipML = ENU = 'Specifies if the vendor is a person or a company.', FRA = 'Spécifie si le fournisseur est une personne ou une société.';
        }
        modify("Cash Flow Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a payment term that will be used for calculating cash flow.', FRA = 'Spécifie les conditions de paiement qui sont utilisées pour le calcul de la trésorerie.';
        }
        modify("Creditor No.")
        {
            ToolTipML = ENU = 'Identifies the vendor who sent the purchase invoice.', FRA = 'Identifie le fournisseur qui a envoyé la facture achat.';
        }
        modify(Receiving)
        {
            CaptionML = ENU = 'Receiving', FRA = 'Réception';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the warehouse location where items from the vendor must be received by default.', FRA = 'Spécifie l''entrepôt où les articles du fournisseur doivent être reçus par défaut.';
        }
        modify("Shipment Method Code")
        {

            //Unsupported feature: Change Level on ""Shipment Method Code"(Control 28)". Please convert manually.

            ToolTipML = ENU = 'Specifies how the vendor must ship items to you.', FRA = 'Spécifie de quelle manière le fournisseur doit vous expédier les articles.';
        }
        modify("Lead Time Calculation")
        {

            //Unsupported feature: Change Level on ""Lead Time Calculation"(Control 96)". Please convert manually.

            ToolTipML = ENU = 'Specifies a date formula for the time that it takes to replenish the item.', FRA = 'Spécifie une formule date pour le délai nécessaire au réapprovisionnement de l''article.';
        }
        modify("Base Calendar Code")
        {

            //Unsupported feature: Change Level on ""Base Calendar Code"(Control 112)". Please convert manually.

            ToolTipML = ENU = 'Specifies the code for the vendor''s customized calendar.', FRA = 'Spécifie le code du calendrier personnalisé du fournisseur.';
        }
        modify("Customized Calendar")
        {

            //Unsupported feature: Change Level on ""Customized Calendar"(Control 121)". Please convert manually.

            CaptionML = ENU = 'Customized Calendar', FRA = 'Calendrier personnalisé';
            ToolTipML = ENU = 'Specifies if you have set up a customized calendar for the vendor.', FRA = 'Spécifie si vous avez configuré un calendrier personnalisé pour le fournisseur.';
        }
        // modify("Country/Region Code")
        // {
        //     Visible = false;
        // }
        modify("Primary Contact No.")
        {
            Visible = false;
        }
        modify(Control16)
        {
            Visible = false;
        }
        modify("Home Page")
        {
            Visible = false;
        }
        modify("Our Account No.")
        {
            Visible = false;
        }
        modify("Name 2")
        {
            Visible = true;
        }
        modify("IC Partner Code")
        {
            Visible = true;
        }
        modify("Balance (LCY)")
        {
            Visible = true;
        }
        modify(County)
        {
            Visible = true;
        }
        addafter("No.")
        {
            // field("Vendor Template Code";Rec."Vendor Template Code")
            // {
            //     Importance = Additional;
            // }//BC Upgrade SHARMP16 drink-it fields
            field("Vendor Type"; Rec."Vendor Type FND")
            {
                Caption = 'Vendor Account Group';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Type field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                               ToolTip = 'Specifies the value of the Vendor Account Group field.';

            }
            field("Global Vendor Number"; Rec."Global Vendor Number FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Vendor Number field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Global Vendor Number field.';

            }


        }

        addafter("Name 2")
        {
            // field("Name 2"; Rec."Name 2")
            // {
            //     ApplicationArea = All;
            // }//BC Upgrade SHARMP16 
            field("Name 3"; Rec."Name 3 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Name 3 field.';
            }
            field("Name 4"; Rec."Name 4 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Name 4 field.';
            }
        }
        addafter("Search Name")
        {
            field("Reference Code IC and Plant"; Rec."Reference Code IC & Plant FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Reference Code IC and Plant field.';
            }
            // field("IC Partner Code"; Rec."IC Partner Code")
            // {
            //     ApplicationArea = All;
            //     Importance = Additional;
        }//BC Upgrade SHARMP16 
         // field("Interface Partner"; Rec."Interface Partner")
         // {
         //     Description = 'IPLXL9.00.001';
         // }//BC Upgrade SHARMP16 drink-it fields

        addafter(Blocked)
        {
            field("Blocked Reason Code"; Rec."Blocked Reason Code FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Blocked Reason Code field.';
            }
            field("Sensitive Payment Block"; Rec."Sensitive Payment Block FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Sensitive Payment Block field.';
            }
            field("Sensitive Workflow Block"; Rec."Sensitive Workflow Block FND")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                ToolTip = 'Specifies the value of the Sensitive Workflow Block field.';
            }
            field("Global Delete"; Rec."Global Delete FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Global Flag for Deletion Indicator field.';
            }
            field(Employee; Rec."Employee FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Employee field.';
            }
            field("Supplying Plant of Vendor"; Rec."Supplying Plant of Vendor FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Supplying Plant of Vendor field.';
            }
            // field("Sundry Vendor"; Rec."Sundry Vendor")
            // {
            // }//BC Upgrade SHARMP16 drink-it fields
        }
        addafter("Balance Due (LCY)")
        {
            // field("Deposit Vend. Balance (LCY)"; Rec."Deposit Vend. Balance (LCY)")
            // {
            // }//BC Upgrade SHARMP16 drink-it fields
            field("Local Vendor Type"; Rec."Local Vendor Type FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Local Vendor Type field.';
            }
        }
        addafter("Address 2")
        {
            field("Street 3"; Rec."Street 3 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Street 3 field.';
            }
            field("Street 4"; Rec."Street 4 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Street 4 field.';
            }
            field("Street 5"; Rec."Street 5 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Street 5 field.';
            }
            field("House Number"; Rec."House Number FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the House Number field.';
            }
            field("House Number Supplement"; Rec."House Number Supplement FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the House Number Supplement field.';
            }
            field(District; Rec."District FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the District field.';
            }
        }
        addafter(City)
        {

            // field("Country/Region Code"; Rec."Country/Region Code")
            // {
            //     ApplicationArea = Basic, Suite;
            //     ToolTip = 'Specifies the country/region of the address.';
            //     Visible = false;
            // }//BC Upgrade SHARMP16 already defined
            field("C/O Name"; Rec."C/O Name FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the C/O Name field.';
            }
            field("P.O. Box"; Rec."P.O. Box FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the P.O. Box field.';
            }
            field("P.O. Box Postal Code"; Rec."P.O. Box Postal Code FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the P.O. Box Postal Code field.';
            }
            field("P.O. Box Without No."; Rec."P.O. Box Without No. FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the P.O. Box Without No. field.';
            }
            field("Different City"; Rec."Different City FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Different City field.';
            }
            field("Other City"; Rec."Other City FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Other City field.';
            }
            field("Other Region"; Rec."Other Region FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Other Region field.';
            }
            field("Other Country"; Rec."Other Country FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Other Country field.';
            }
            // field("Tax Area Code"; Rec."Tax Area Code")
            // {
            // }//BC Upgrade SHARMP16 drink-it fields
            field("Company Postal Code"; Rec."Company Postal Code FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Company Postal Code field.';
            }
            field("Type of Delivery"; Rec."Type of Delivery FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Type of Delivery field.';
            }
            field("Number of Delivery Service"; Rec."Number of Delivery Service FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Number of Delivery Service field.';
            }
        }
        addafter("E-Mail")
        {
            field("E-Mail 2"; Rec."E-Mail 2 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Email Finance field.';
            }
        }
        // addafter(Contact)
        // {
        //     field("Transaction Type"; Rec."Transaction Type")
        //     {
        //     }
        //     field("Transport Method"; Rec."Transport Method")
        //     {
        //     }
        //     field("Transaction Specification"; Rec."Transaction Specification")
        //     {
        //     }
        //     field("Entry Point"; Rec."Entry Point")
        //     {
        //     }
        //     field("Area"; Rec.Area)
        //     {
        //     }
        // }//BC Upgrade SHARMP16 drink-it fields
        addafter("VAT Registration No.")
        {
            field("Tax Number 2"; Rec."Tax Number 2 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Tax Number 2 field.';
            }
            field("Tax Number 3"; Rec."Tax Number 3 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Tax Number 3 field.';
            }
            field("Tax Number 4"; Rec."Tax Number 4 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Tax Number 4 field.';
            }
            field("Tax Jurisdiction"; Rec."Tax Jurisdiction FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Tax Jurisdiction field.';
            }
        }
        addafter("Invoice Disc. Code")
        {
            // field("Pay-to/Buy-from Prices Calc."; Rec."Pay-to/Buy-from Prices Calc.")
            // {
            // }
            // field("Pay-to/Buy-from DTax Gr. Calc."; Rec."Pay-to/Buy-from DTax Gr. Calc.")
            // {
            // }
            // field("Calculate Payment Terms From"; Rec."Calculate Payment Terms From")
            // {
            // }
            // field("Calculate Payment Method From"; Rec."Calculate Payment Method From")
            // {
            // }//BC Upgrade SHARMP16 drink-it fields
            field("Duns Number"; Rec."Duns Number FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Duns Number field.';
            }
            field("Industry Key"; Rec."Industry Key FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Industry Key field.';
            }
            field("Self-Billing"; Rec."Self-Billing FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Self-Billing field.';
            }
            field("Corporate Vendor Group"; Rec."Corporate Vendor Group FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Corporate Vendor Group field.';
            }
        }
        addafter("Prices Including VAT")
        {
            // field("Linked Customer No."; Rec."Linked Customer No.")
            // {
            //     Importance = Additional;
            // }//BC Upgrade SHARMP16 drink-it fields
        }
        addafter("Vendor Posting Group")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
            }
            field("Date of Birth"; Rec."Date of Birth FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Date of Birth field.';
            }
            field("Place of Birth"; Rec."Place of Birth FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Place of Birth field.';
            }
            field(Profession; Rec."Profession FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Profession field.';
            }
        }
        addafter("Currency Code")
        {
            field("Vendor Category"; Rec."Vendor Category FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Vendor Category field.';
            }
        }
        // addafter("Block Payment Tolerance")
        // {
        //     field("Payment Balance (LCY)"; Rec."Balance (LCY)") // BC FR Upgrade KAIRAR01
        //     {
        //         ApplicationArea = Basic, Suite;
        //         ToolTip = 'Specifies the total value of your completed purchases from the vendor in the current fiscal year. It is calculated from amounts including VAT on all completed purchase invoices and credit memos.';

        //         trigger OnDrillDown();
        //         var
        //             DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        //             VendLedgEntry: Record "Vendor Ledger Entry";
        //         begin
        //             //HEI.09>>
        //             DtldVendLedgEntry.SETFILTER("Vendor No.", rec."No.");
        //             rec.COPYFILTER("Global Dimension 1 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 1");
        //             rec.COPYFILTER("Global Dimension 2 Filter", DtldVendLedgEntry."Initial Entry Global Dim. 2");
        //             rec.COPYFILTER("Currency Filter", DtldVendLedgEntry."Currency Code");
        //             VendLedgEntry.DrillDownOnEntries(DtldVendLedgEntry);
        //             //HEI.09<<
        //         end;
        //     }
        //BC UpgradeSHARMP16 begin>> French localisation fields
        // field("Payment in progress (LCY)"; Rec."Payment in progress (LCY)")
        // {
        //     ApplicationArea = Basic, Suite;
        //     ToolTipML = ENU = 'Displays the vendor''s payments in progress.',
        //                 FRA = 'Affiche les paiements du fournisseur en cours.';
        // }
        // field("""Balance (LCY)"" - ""Payment in progress (LCY)"""; Rec."Balance (LCY)" - rec."Payment in progress (LCY)")
        // {
        //     ApplicationArea = Basic, Suite;
        //     CaptionML = ENU = 'Net amount (LCY)',
        //                 FRA = 'Montant net DS';
        //     Editable = false;
        // }
        //BC UpgradeSHARMP16 begin<< French localisation fields
        // }
        addbefore("Phone No.")
        {
            group("Contact Details")
            {

            }
        }
        addafter("Location Code")
        {
            //     group(Routes)
            //     {
            //         CaptionML = ENU = 'Routes',
            //                     FRA = 'Routes';
            //         // field(Route; Rec.Route)
            //         // {

            //         //     trigger OnDrillDown();
            //         //     var
            //         //         lrRouteCombination: Record "Route Combination";
            //         //         lpRouteCombination: Page "Route Combinations";
            //         //     begin
            //         //         //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 -> DIT-770 #154
            //         //         lrRouteCombination.RESET;
            //         //         FILTERGROUP(2);
            //         //         //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968
            //         //         lrRouteCombination.SETRANGE("Source Type", lrRouteCombination."Source Type"::Vendor);
            //         //         //>> DITW18.00.07 VSC DIT-770 #1968
            //         //         lrRouteCombination.SETRANGE("No.", "No.");
            //         //         //lrRouteCombination.SETRANGE(Code,Route);
            //         //         FILTERGROUP(2);
            //         //         lpRouteCombination.SETTABLEVIEW(lrRouteCombination);
            //         //         lpRouteCombination.RUNMODAL;
            //         //         //<< DITW18.00.07 VSC DIT-770 #1968 -> DIT-770 #154
            //         //     end;
            //         // }//BC Upgrade SHARMP16 drink-it fields
            //         // field(Distance; Rec.Distance)
            //         // {
            //         // }
            //         // field("Delivery Sequence"; Rec."Delivery Sequence")
            //         // {
            //         // }
            //         // field("Minimum Cubage"; Rec."Minimum Cubage")
            //         // {
            //         //     Description = 'DITW18.00.07 DIT-770 #1976';
            //         // }
            //         // field("Minimum Weight"; Rec."Minimum Weight")
            //         // {
            //         //     Description = 'DITW18.00.07 DIT-770 #1976';
            //         // }//BC Upgrade SHARMP16 drink-it fields
            //     }
        }
        addafter("Shipment Method Code")
        {
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Shipping Agent Code field.';
            }
            // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
            // {
            // }//BC Upgrade SHARMP16 drink-it fields
            field("No. of Shipping Agent Rel."; Rec."No. of Shipping Agent Rel. FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the No. of Shipping Agent Service Relations field.';
            }
        }
        addafter(Receiving)
        {
            // field("Truck Zone"; Rec."Truck Zone")
            // {
            // }
            // field("Require 2 Drivers"; Rec."Require 2 Drivers")
            // {
            // }
            // field("Vendor Delivery Type"; Rec."Vendor Delivery Type")
            // {
            // }//BC Upgrade SHARMP16 drink-it fields
            // group(Planning)
            // {
            //     CaptionML = ENU = 'Planning',
            //                 FRA = 'Planning';
            //     // field("Allow Emergency Orders"; Rec."Allow Emergency Orders")
            //     // {
            //     // }//BC Upgrade SHARMP16 drink-it fields
            // }
            // group(Quality)
            // {
            //     CaptionML = ENU = 'Quality',
            //                 FRA = 'Qualité';
            //     field("No. of Quality Tests"; Rec."No. of Quality Tests")
            //     {
            //         Description = 'QXL9.00.001';
            //     }
            // }
            // group("Drink-It")
            // {
            //     CaptionML = ENU = 'Drink-It',
            //                 FRA = 'Drink-It';
            //     field("Autom. Item Charge"; Rec."Autom. Item Charge")
            //     {
            //     }
            //     group(Taxes)
            //     {
            //         CaptionML = ENU = 'Taxes',
            //                     FRA = 'Impôts et Taxes';
            //         field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
            //         {
            //             Importance = Promoted;
            //             LookupPageID = "Drink Vendor Tax Groups";
            //         }
            //         field("Tax Registration No."; Rec."Tax Registration No.")
            //         {
            //         }
            //         field("Tax Warehouse Reference"; Rec."Tax Warehouse Reference")
            //         {
            //         }
            //         field("Fiscal Representative No."; Rec."Fiscal Representative No.")
            //         {
            //         }
            //         field("Journey Time"; Rec."Journey Time")
            //         {
            //         }
            //         field("Transport Time Text"; Rec."Transport Time Text")
            //         {
            //         }
            //         field("Tax Office Code"; Rec."Tax Office Code")
            //         {
            //         }
            //     }
            //     group("Deposits & Empty Goods")
            //     {
            //         CaptionML = ENU = 'Deposits & Empty Goods',
            //                     FRA = 'Consignes et articles vidanges';
            //         field("Vendor DDeposit Group Code"; Rec."Vendor DDeposit Group Code")
            //         {
            //             Importance = Promoted;
            //             LookupPageID = "Drink Deposit Groups";
            //         }
            //         field("Split Deposit on Invoice"; Rec."Split Deposit on Invoice")
            //         {
            //         }
            //         field("Deposit Vendor Posting Group"; Rec."Deposit Vendor Posting Group")
            //         {
            //         }
            //         field("Deposit Payment Terms Code"; Rec."Deposit Payment Terms Code")
            //         {
            //         }
            //         field("Deposit Payment Method Code"; Rec."Deposit Payment Method Code")
            //         {
            //         }
            //     }
            //     group(Discounts)
            //     {
            //         CaptionML = ENU = 'Discounts',
            //                     FRA = 'Remises';
            //         field("No. of Drink Disc. Groups"; Rec."No. of Drink Disc. Groups")
            //         {
            //             DrillDown = false;
            //             Importance = Promoted;

            //             trigger OnLookup(Text: Text): Boolean;
            //             var
            //                 DDiscountRel: Record "Drink Discount Relation";
            //             begin
            //                 // <<DITW16.00.00.37 DDR 13/01/2011 DIT-715 #42
            //                 CurrPage.SAVERECORD;
            //                 COMMIT;
            //                 DDiscountRel.FILTERGROUP(2);
            //                 DDiscountRel.SETRANGE("Source Type", DDiscountRel."Source Type"::Vendor);
            //                 DDiscountRel.SETRANGE("Source No.", "No.");
            //                 DDiscountRel.FILTERGROUP(0);
            //                 PAGE.RUNMODAL(0, DDiscountRel);
            //                 CurrPage.UPDATE(false);
            //             end;
            //         }
            //     }
            //     group(Promotions)
            //     {
            //         CaptionML = ENU = 'Promotions',
            //                     FRA = 'Promotions';
            //         field("No. of Promotion Groups"; Rec."No. of Promotion Groups")
            //         {
            //             DrillDown = false;

            //             trigger OnLookup(Text: Text): Boolean;
            //             var
            //                 DPromotionRel: Record "Drink Promotion Relation";
            //             begin
            //                 // <<DITW16.00.00.37 DDR 13/01/2011 DIT-715 #42
            //                 CurrPage.SAVERECORD;
            //                 COMMIT;
            //                 DPromotionRel.FILTERGROUP(2);
            //                 DPromotionRel.SETRANGE("Source Type", DPromotionRel."Source Type"::Vendor);
            //                 DPromotionRel.SETRANGE("Source No.", "No.");
            //                 DPromotionRel.FILTERGROUP(0);
            //                 PAGE.RUNMODAL(0, DPromotionRel);
            //                 CurrPage.UPDATE(false);
            //             end;
            //         }
            //         field("Gen. Bus. Posting Free Group"; Rec."Gen. Bus. Posting Free Group")
            //         {
            //         }
            //         field("Free Item Posting Type"; Rec."Free Item Posting Type")
            //         {
            //         }
            //     }
            //     group(Others)
            //     {
            //         CaptionML = ENU = 'Others',
            //                     FRA = 'Autres';
            //         field("No. of Exclusivity Groups"; Rec."No. of Exclusivity Groups")
            //         {
            //         }
            //     }
            // }//BC Upgrade SHARMP16 drink-it fields
            group(Contract)
            {
                CaptionML = ENU = 'Contract',
                            FRA = 'Contrat';
                // field("Loan Interest Vend. Post. Grp."; Rec."Loan Interest Vend. Post. Grp.")
                // {
                // }//BC Upgrade SHARMP16 drink-it fields
                group(Control1100067001)
                {
                    CaptionML = ENU = 'General',
                                FRA = 'Général';
                    field("Copy Vendor Posting Group"; Rec."Vendor Posting Group")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the vendor''s market type to link business transactions made for the vendor with the appropriate account in the general ledger.';
                    }
                    // field("Copy Balance (LCY)"; Rec."Balance (LCY)")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Importance = Additional;

                    //     trigger OnDrillDown();
                    //     var
                    //         DtldvendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                    //         vendLedgEntry: Record "Vendor Ledger Entry";
                    //     begin
                    //         DtldvendLedgEntry.SETRANGE("Vendor No.", rec."No.");
                    //         rec.COPYFILTER("Global Dimension 1 Filter", DtldvendLedgEntry."Initial Entry Global Dim. 1");
                    //         rec.COPYFILTER("Global Dimension 2 Filter", DtldvendLedgEntry."Initial Entry Global Dim. 2");
                    //         rec.COPYFILTER("Currency Filter", DtldvendLedgEntry."Currency Code");
                    //         // <<DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370
                    //         // rec.COPYFILTER("DIT Sub-Contract Type Filter", DtldvendLedgEntry."DIT Sub-Contract Type");//BC Upgrade SHARMP16 drink-it fields
                    //         // rec.COPYFILTER("Service Contract No. Filter", DtldvendLedgEntry."Service Contract No.");//BC Upgrade SHARMP16 drink-it fields
                    //         // rec.COPYFILTER("Item Charge Type Filter", DtldvendLedgEntry."Item Charge Type");//BC Upgrade SHARMP16 drink-it fields
                    //         // >>DITW16.00.00.42 DDR DIT-715 #370
                    //         vendLedgEntry.DrillDownOnEntries(DtldvendLedgEntry);
                    //     end;
                    // }
                }
                // group("Contract types")
                // {
                //     CaptionML = ENU = 'Contract types',
                //                 FRA = 'Types de contrat';
                //     // field("Contract Vend. Post. Gr. Stand"; Rec."Contract Vend. Post. Gr. Stand")
                //     // {
                //     //     Enabled = false;
                //     //     Importance = Promoted;
                //     //     Visible = false;
                //     // }//BC Upgrade SHARMP16 drink-it fields
                //     // field("BalanceSubContractLCY[1]"; Rec.BalanceSubContractLCY[1])
                //     // {
                //     //     AutoFormatType = 1;
                //     //     CaptionML = ENU = 'No Type - Balance (LCY)',
                //     //                 FRA = 'Non type - Solde DS';
                //     //     Importance = Additional;

                //     //     trigger OnDrillDown();
                //     //     begin
                //     //         DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::" ");
                //     //     end;
                //     // }
                //     // field("Contract Vend. Post. Gr. Rent"; Rec."Contract Vend. Post. Gr. Rent")
                //     // {
                //     //     Importance = Promoted;
                //     // }
                //     // field("BalanceSubContractLCY[2]"; Rec.BalanceSubContractLCY[2])
                //     // {
                //     //     CaptionML = ENU = 'Rent - Balance (LCY)',
                //     //                 FRA = 'Location - Solde DS';
                //     //     Editable = false;
                //     //     Importance = Additional;

                //     //     trigger OnDrillDown();
                //     //     begin
                //     //         DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::Rent);
                //     //     end;
                //     // }
                //     // field("Contract Vend. Post. Gr. Loan"; Rec."Contract Vend. Post. Gr. Loan")
                //     // {
                //     // }
                //     // field("BalanceSubContractLCY[3]"; Rec.BalanceSubContractLCY[3])
                //     // {
                //     //     CaptionML = ENU = 'Loan - Balance (LCY)',
                //     //                 FRA = 'Prêt - Solde DS';
                //     //     Editable = false;
                //     //     Importance = Additional;

                //     //     trigger OnDrillDown();
                //     //     begin
                //     //         DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::Loan);
                //     //     end;
                //     // }
                //     // field("Contract Vend. Post. Gr. LoanU"; Rec."Contract Vend. Post. Gr. LoanU")
                //     // {
                //     // }
                //     // field("BalanceSubContractLCY[4]"; Rec.BalanceSubContractLCY[4])
                //     // {
                //     //     CaptionML = ENU = 'Loan in Use - Balance (LCY)',
                //     //                 FRA = 'Prêt à usage - Solde DS';
                //     //     Editable = false;
                //     //     Importance = Additional;

                //     //     trigger OnDrillDown();
                //     //     begin
                //     //         // <<DITW16.00.00.43 DDR 10/06/2013 DIT-715 #623
                //     //         DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::LoanInUse);
                //     //         // >>DITW16.00.00.43 DDR DIT-715 #623
                //     //     end;
                //     // }
                //     // field("Contract Vend. Post. Gr. Maint"; Rec."Contract Vend. Post. Gr. Maint")
                //     // {
                //     // }
                //     // field("BalanceSubContractLCY[5]"; Rec.BalanceSubContractLCY[5])
                //     // {
                //     //     CaptionML = ENU = 'Maintenance - Balance (LCY)',
                //     //                 FRA = 'Maintenance - Solde DS';
                //     //     Editable = false;
                //     //     Importance = Additional;

                //     //     trigger OnDrillDown();
                //     //     begin
                //     //         // <<DITW16.00.00.43 DDR 10/06/2013 DIT-715 #623
                //     //         DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::Maintenance);
                //     //         // >>DITW16.00.00.43 DDR DIT-715 #623
                //     //     end;
                //     // }
                //     // field("Contract Vend. Post. Gr. Other"; Rec."Contract Vend. Post. Gr. Other")
                //     // {
                //     // }
                //     // field("BalanceSubContractLCY[6]"; Rec.BalanceSubContractLCY[6])
                //     // {
                //     //     CaptionML = ENU = 'Other - Balance (LCY)',
                //     //                 FRA = 'Autre - Solde DS';
                //     //     Editable = false;
                //     //     Importance = Additional;

                //     //     trigger OnDrillDown();
                //     //     begin
                //     //         DrillDownContractBalanceLCY("DIT Sub-Contract Type Filter"::Other);
                //     //     end;
                //     // }//BC Upgrade SHARMP16 drink-it fields
                // }
            }
            // group(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     Visible = false;
            //     // field("Shortcut Property 1 Code"; Rec."Shortcut Property 1 Code")
            //     // {
            //     // }
            //     // field("Shortcut Property 2 Code"; Rec."Shortcut Property 2 Code")
            //     // {
            //     // }
            //     // field("Shortcut Property 3 Code"; Rec."Shortcut Property 3 Code")
            //     // {
            //     // }
            //     // field("Shortcut Property 4 Code"; Rec."Shortcut Property 4 Code")
            //     // {
            //     // }
            //     // field("Shortcut Property 5 Code"; Rec."Shortcut Property 5 Code")
            //     // {
            //     // }
            //     // field("Shortcut Property 6 Code"; Rec."Shortcut Property 6 Code")
            //     // {
            //     // }
            //     // field("Shortcut Property 7 Code"; Rec."Shortcut Property 7 Code")
            //     // {
            //     // }
            //     // field("Shortcut Property 8 Code"; Rec."Shortcut Property 8 Code")
            //     // {
            //     // }
            //     // field("Shortcut Property 9 Code"; Rec."Shortcut Property 9 Code")
            //     // {
            //     // }
            //     // field("Shortcut Property 10 Code"; Rec."Shortcut Property 10 Code")
            //     // {
            //     // }//BC Upgrade SHARMP16 drink-it fields
        }

        addafter(Contract)
        {
            group(Mendix)
            {
                Caption = 'Mendix';
                field("Standard Carrier Access Code"; Rec."Stndrd Carrier Access Code FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Standard Carrier Access Code field.';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field("Send To Maximo"; Rec."Send To Maximo FND")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Send To Maximo field.';
                }
            }
            // BC Upgrade BHARDA11 >> ---FDD STP 002
            group(DrinkIT)
            {
                Caption = 'Drink-it';
                group(Taxes)
                {
                    field("Tax Registration No. 113FDW1"; Rec."Tax Registration No. 113FDW")
                    {
                        Caption = 'Tax Registration No.';
                        ApplicationArea = All;
                    }
                }
                group("Deposits & Empty Goods")
                {
                    field("Business Group 104FDW"; Rec."Business Group 104FDW")
                    {
                        Caption = 'Vendor Deposit Group Code';
                        ApplicationArea = All;
                    }
                    field("Vendor Posting Grp 104FDW"; Rec."Vendor Posting Grp 104FDW")
                    {
                        Caption = 'Deposit - Vendor Posting Group';
                        ApplicationArea = All;
                    }
                    field("Payment Terms Code 104FDW"; Rec."Payment Terms Code 104FDW")
                    {
                        Caption = 'Deposit - Payment Terms Code';
                        ApplicationArea = All;
                    }
                    field("Payment Method Code 104FDW"; Rec."Payment Method Code 104FDW")
                    {
                        Caption = 'Deposit - Payment Method Code';
                        ApplicationArea = All;
                    }
                }
            }
            // BC Upgrade BHARDA11 << ---FDD STP 002
        }
        addafter(WorkflowStatus)
        {
            systempart(Control1900383217; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
        moveafter("Name 4"; "Search Name")
        moveafter(City; County)
        // moveafter("Document Sending Profile"; "Purchaser Code")
        // moveafter(Blocked; "Balance (LCY)")
        // moveafter(Address; "Address 2")
        // moveafter("Phone No."; "Fax No.")
    }
    actions
    {
        // BC Upgrade BHARAD11 >> 
        addafter("Bank Accounts")
        {
            group(ChangeLog)
            {
                Image = Log;
                Caption = ' ENU =Change Log;FRA =Journal Modification';

                group(ChangeLogEntries)
                {
                    Image = Log;
                    Caption = 'ENU=Change Log Entries;FRA=Journal Modification';
                    action(ByVendor)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'by Vendor', FRA = 'Fournisseur';
                        Image = Log;
                        // RunObject = Page "Change Log Entries";
                        // RunPageLink = "Table No." = FILTER(23), "Primary Key Field 1 Value" = FIELD("No.");
                        trigger OnAction()
                        var
                            ChangeLogEntry: Record "Change Log Entry";
                            ChangeLogEntries: Page "Change Log Entries";
                        begin
                            ChangeLogEntry.Reset;
                            ChangeLogEntry.SetRange("Table No.", Database::Vendor);
                            ChangeLogEntry.SetRange("Primary Key Field 1 Value", Rec."No.");
                            ChangeLogEntries.SetTableView(ChangeLogEntry);
                            ChangeLogEntries.Run();
                        end;
                    }
                    action(ByDefaultDimension)
                    {
                        ApplicationArea = All;
                        // Caption = 'by Default dimension';
                        CaptionML = ENU = 'by Default dimension', FRA = 'Affectation analytique';
                        Image = Log;
                        // RunObject = Page "Change Log Entries";
                        // RunPageLink = "Table No." = FILTER(352), "Primary Key Field 1 Value" = FILTER(23), "Primary Key Field 2 Value" = FIELD("No.");
                        trigger OnAction()
                        var
                            ChangeLogEntry: Record "Change Log Entry";
                            ChangeLogEntries: Page "Change Log Entries";
                        begin
                            ChangeLogEntry.Reset;
                            ChangeLogEntry.SetRange("Table No.", Database::"Default Dimension"); // 352
                            ChangeLogEntry.SetRange("Primary Key Field 1 Value", '23'); // Table ID for "Default Dimension" is not directly available, so using the numeric value
                            ChangeLogEntry.SetRange("Primary Key Field 2 Value", Rec."No.");
                            ChangeLogEntries.SetTableView(ChangeLogEntry);
                            ChangeLogEntries.Run();
                        end;
                    }
                    action(byBankAccount)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'by Bank Account', FRA = 'Compte bancaire fournisseur';
                        Image = Log;
                        // RunObject = Page "Change Log Entries";
                        // RunPageLink = "Table No." = FILTER(288), "Primary Key Field 1 Value" = FIELD("No.");
                        trigger OnAction()
                        var
                            ChangeLogEntry: Record "Change Log Entry";
                            ChangeLogEntries: Page "Change Log Entries";
                        begin
                            ChangeLogEntry.Reset;
                            ChangeLogEntry.SetRange("Table No.", Database::"Vendor Bank Account");
                            ChangeLogEntry.SetRange("Primary Key Field 1 Value", Rec."No.");
                            ChangeLogEntries.SetTableView(ChangeLogEntry);
                            ChangeLogEntries.Run();
                        end;
                    }
                }

            }
        }
        addafter("Bank Accounts_Promoted")
        {
            group(ChangeLogEntriess)
            {
                Caption = 'Change Log Entries';
                ShowAs = Standard;
                // group(ChangeLogEn)
                // {
                actionref(ByVendor_Promoted; ByVendor) { }
                actionref(ByDimensionCode_Prmoted; ByDefaultDimension) { }
                actionref(byBankAccount_Prmoted; byBankAccount) { }
                // }

            }
        }
        // BC Upgrade BHARAD11 <<
        addafter("Bank Accounts")
        {

            action(VendorSPL)
            {
                ApplicationArea = all;
                Caption = 'Vendor SPL';
                Image = ListPage;
                RunObject = Page "Vendor SPL List";
                RunPageLink = "Vendor No." = FIELD("No.");
                ToolTip = 'Executes the Vendor SPL action.';

            }
        }
        addafter("Item References_Promoted")
        {
            actionref(VendorSPL_Promoted; VendorSPL)
            {
            }
        }


        addafter(PayVendor_Promoted)
        {
            actionref(PurchaseJournal_Promoted; "Purchase Journal")
            {
                Visible = true;
            }
            actionref(Stastics_Promoted; Statistics)
            {

            }
            actionref(NewPurchaseInvoice1_Promoted; NewPurchaseInvoice)
            {
            }
            actionref(NewPurchaseOrder1_Promoted; NewPurchaseOrder)
            {
            }
            actionref(NewPurchaseCrMemo1_Promoted; NewPurchaseCrMemo)
            {
            }



        }


        addafter(ContactBtn)
        {
            action("Sh&ipping Agents")
            {
                CaptionML = ENU = 'Sh&ipping Agents',
                            FRA = '&Transporteurs';
                Image = Shipment;
                RunObject = Page "Shipping Agents";
                ApplicationArea = All;
                ToolTip = 'Executes the Sh&ipping Agents action.';
                // RunPageLink = "Vendor No." = FIELD("No.");//BC Upgrade SHARMP16 drink-it page link
                // RunPageView = sorting("Vendor No.", "Contact No.");//BC Upgrade SHARMP16 drink-it page link
            }////BC Upgrade SHARMP16 drink-it page link

        }

        addafter(PayVendor)
        {
            action("Service &Items")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Service &Items',
                                    FRA = 'Ar&ticles de service';
                Image = ServiceItem;
                // Promoted = true;
                // PromotedCategory = Process;
                RunObject = Page "Service Items";
                RunPageLink = "Vendor No." = FIELD("No.");
                ToolTip = 'Executes the Service &Items action.';
            }
        }
        addafter(CancelApprovalRequest_Promoted)
        {
            actionref(ApprovalEntries1_Promoted; ApprovalEntries)
            {
            }
        }

        modify("Ven&dor")
        {
            CaptionML = ENU = 'Ven&dor', FRA = 'Fo&urnisseur';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Bank Accounts")
        {
            CaptionML = ENU = 'Bank Accounts', FRA = 'Comptes bancaires';
            ToolTipML = ENU = 'View or set up the vendor''s bank accounts. You can set up any number of bank accounts for each vendor.', FRA = 'Affichez ou configurez les comptes bancaires du fournisseur. Vous pouvez configurer autant de comptes bancaires que vous le souhaitez pour chaque fournisseur.';
        }
        modify(ContactBtn)
        {
            CaptionML = ENU = 'C&ontact', FRA = 'C&ontact';
            ToolTipML = ENU = 'View or edit detailed information about the contact person at the customer.', FRA = 'Affichez ou modifiez des informations détaillées concernant la personne à contacter chez le client.';
        }
        modify(OrderAddresses)
        {
            CaptionML = ENU = 'Order &Addresses', FRA = '&Adresses de commande';
            ToolTipML = ENU = 'View a list of alternate order addresses for the vendor.', FRA = 'Affichez une liste des adresses commande secondaires du fournisseur.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(ApprovalEntries)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        // modify("Cross References")
        // {
        //     CaptionML = ENU = 'Cross References', FRA = 'Références externes';
        // }//BC Upgrade SHARMP16
        modify(VendorReportSelections)
        {
            CaptionML = ENU = 'Document Layouts', FRA = 'Présentations document';
            ToolTipML = ENU = 'Set up a layout for different types of documents such as invoices, quotes, and credit memos.', FRA = 'Configurez une présentation pour différents types de documents tels que des factures, des devis et avoirs.';
        }
        modify("&Purchases")
        {
            CaptionML = ENU = '&Purchases', FRA = 'Ac&hats';
        }
        modify(Items)
        {
            CaptionML = ENU = 'Items', FRA = 'Articles';
        }
        modify("Invoice &Discounts")
        {
            CaptionML = ENU = 'Invoice &Discounts', FRA = 'Remises &facture';
            ToolTipML = ENU = 'View or set up conditions for invoice discounts and service charges for the vendor.', FRA = 'Affichez ou configurez des conditions de remises facture et de frais forfaitaires pour le fournisseur.';
        }
        modify(Prices)
        {
            CaptionML = ENU = 'Prices', FRA = 'Prix';
            ToolTipML = ENU = 'View or set up different prices for items that you buy from the vendor. An item price is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.', FRA = 'Affichez ou paramétrez des prix différents pour les articles que vous achetez au fournisseur. Un prix article est automatiquement affecté sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le fournisseur, la quantité ou la date de fin.';
        }
        modify("Line Discounts")
        {
            CaptionML = ENU = 'Line Discounts', FRA = 'Remises ligne';
            ToolTipML = ENU = 'View or set up purchase line discounts.', FRA = 'Affichez ou configurez des remises ligne achat.';
        }
        modify("Prepa&yment Percentages")
        {
            CaptionML = ENU = 'Prepa&yment Percentages', FRA = 'Pourcentages acom&pte';
        }
        // modify("S&td. Vend. Purchase Codes")
        // {
        //     CaptionML = ENU = 'S&td. Vend. Purchase Codes', FRA = 'Codes achat fourn. s&td';
        // }
        modify("Mapping Text to Account")
        {
            CaptionML = ENU = 'Mapping Text to Account', FRA = 'Correspondance texte et compte';
            ToolTipML = ENU = 'Page mapping text to account', FRA = 'Correspondance de page Texte et compte';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify(Quotes)
        {
            CaptionML = ENU = 'Quotes', FRA = 'Demandes de prix';
        }
        modify(Orders)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';
        }
        modify("Return Orders")
        {
            CaptionML = ENU = 'Return Orders', FRA = 'Retours';
        }
        modify("Blanket Orders")
        {
            CaptionML = ENU = 'Blanket Orders', FRA = 'Commandes ouvertes';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';
        }
        // modify(Statistics)
        // {

        //     //Unsupported feature: Change Level on "Statistics(Action 66)". Please convert manually.

        //     CaptionML = ENU = 'Statistics', FRA = 'Statistiques';

        //     //Unsupported feature: Change Name on "Statistics(Action 66)". Please convert manually.

        // }
        modify(Purchases)
        {

            //Unsupported feature: Change Level on "Purchases(Action 69)". Please convert manually.

            CaptionML = ENU = 'Purchases', FRA = 'Achats';
        }
        modify("Entry Statistics")
        {

            //Unsupported feature: Change Level on ""Entry Statistics"(Action 67)". Please convert manually.

            CaptionML = ENU = 'Entry Statistics', FRA = 'Statistiques écritures';
        }
        modify("Statistics by C&urrencies")
        {

            //Unsupported feature: Change Level on ""Statistics by C&urrencies"(Action 20)". Please convert manually.

            CaptionML = ENU = 'Statistics by C&urrencies', FRA = 'Statistiques par &devise';
        }
        modify("Item &Tracking Entries")
        {

            //Unsupported feature: Change Level on ""Item &Tracking Entries"(Action 6500)". Please convert manually.

            CaptionML = ENU = 'Item &Tracking Entries', FRA = '&Ecritures traçabilité';
        }
        modify(NewBlanketPurchaseOrder)
        {
            CaptionML = ENU = 'Blanket Purchase Order', FRA = 'Commande ouverte achat';
        }
        modify(NewPurchaseQuote)
        {
            CaptionML = ENU = 'Purchase Quote', FRA = 'Demande de prix';

            //Unsupported feature: Change Description on "NewPurchaseQuote(Action 1901469405)". Please convert manually.

        }
        modify(NewPurchaseInvoice)
        {
            CaptionML = ENU = 'Purchase Invoice', FRA = 'Facture achat';
            ToolTipML = ENU = 'Create a new purchase invoice for items or services.', FRA = 'Créez une facture achat pour les articles ou les services.';

            //Unsupported feature: Change Description on "NewPurchaseInvoice(Action 1907709505)". Please convert manually.

        }
        modify(NewPurchaseOrder)
        {
            CaptionML = ENU = 'Purchase Order', FRA = 'Commande achat';
            ToolTipML = ENU = 'Create a new purchase order.', FRA = 'Créez une commande achat.';

            //Unsupported feature: Change Description on "NewPurchaseOrder(Action 1907375405)". Please convert manually.

        }
        modify(NewPurchaseCrMemo)
        {
            CaptionML = ENU = 'Purchase Credit Memo', FRA = 'Avoir achat';
            ToolTipML = ENU = 'Create a new purchase credit memo to revert a posted purchase invoice.', FRA = 'Créez un avoir achat pour contrepasser une facture achat validée.';

            //Unsupported feature: Change Description on "NewPurchaseCrMemo(Action 1905024805)". Please convert manually.

        }
        modify(NewPurchaseReturnOrder)
        {
            CaptionML = ENU = 'Purchase Return Order', FRA = 'Retour achat';
        }
        modify(Approval)
        {
            CaptionML = ENU = 'Approval', FRA = 'Approbation';
        }
        modify(Approve)
        {
            CaptionML = ENU = 'Approve', FRA = 'Approuver';
            ToolTipML = ENU = 'Approve the requested changes.', FRA = 'Approuvez les modifications requises.';
        }
        modify(Reject)
        {
            CaptionML = ENU = 'Reject', FRA = 'Rejeter';
            ToolTipML = ENU = 'Reject the approval request.', FRA = 'Rejetez la demande d''approbation.';
        }
        modify(Delegate)
        {
            CaptionML = ENU = 'Delegate', FRA = 'Déléguer';
            ToolTipML = ENU = 'Delegate the approval to a substitute approver.', FRA = 'Déléguez l''approbation à un approbateur remplaçant.';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
            ToolTipML = ENU = 'View or add comments.', FRA = 'Affichez ou ajoutez des commentaires.';
        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(Templates)
        {
            CaptionML = ENU = 'Templates', FRA = 'Modèles';
            ToolTipML = ENU = 'View or edit vendor templates.', FRA = 'Affichez ou modifiez des modèles fournisseur.';
        }
        modify(ApplyTemplate)
        {
            CaptionML = ENU = 'Apply Template', FRA = 'Appliquer modèle';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify(SaveAsTemplate)
        {
            CaptionML = ENU = 'Save as Template', FRA = 'Sauvegarder comme modèle';
            ToolTipML = ENU = 'Save the vendor card as a template that can be reused to create new vendor cards. Vendor templates contain preset information to help you fill fields on vendor cards.', FRA = 'Enregistrez la fiche fournisseur comme modèle que vous pourrez réutiliser pour créer de nouvelles fiches fournisseur. Les modèles fournisseur contiennent des informations prédéfinies pour vous aider à compléter les fiches fournisseur.';
        }
        modify("Create Payments")
        {
            CaptionML = ENU = 'Create Payments', FRA = 'Créer paiements';
            ToolTipML = ENU = 'View or edit the payment journal where you can register payments to vendors.', FRA = 'Affichez ou modifiez la feuille paiement où vous pouvez enregistrer les paiements aux fournisseurs.';
        }
        modify("Purchase Journal")
        {
            CaptionML = ENU = 'Purchase Journal', FRA = 'Feuille achat';
        }
        modify("Incoming Documents")
        {
            CaptionML = ENU = 'Incoming Documents', FRA = 'Documents entrants';
        }
        modify(SendToIncomingDocuments)
        {
            CaptionML = ENU = 'Send to Incoming Documents', FRA = 'Envoyer vers Documents entrants';
            ToolTipML = ENU = 'Send to Incoming Documents', FRA = 'Envoyer vers Documents entrants';
        }
        modify(SendToOCR)
        {
            CaptionML = ENU = 'Send To OCR', FRA = 'Envoyer à OCR';
            ToolTipML = ENU = 'Send To OCR', FRA = 'Envoyer à OCR';
        }
        modify(SendIncomingDocApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';
        }
        modify("Vendor - Summary Aging")
        {
            CaptionML = ENU = 'Vendor - Summary Aging', FRA = 'Fourn. : Échéancier';
            ToolTipML = ENU = 'View a summary of the payables owed to each vendor, divided into three time periods.', FRA = 'Affichez un résumé des soldes dus à chaque fournisseur, réparti sur trois périodes.';
        }
        modify("Vendor - Labels")
        {
            CaptionML = ENU = 'Vendor - Labels', FRA = 'Fourn. : Étiquettes';
        }
        modify("Vendor - Balance to Date")
        {
            CaptionML = ENU = 'Vendor - Balance to Date', FRA = 'Fourn. : Détail écr. ouvertes';
            ToolTipML = ENU = 'View a detail balance for selected vendors.', FRA = 'Affichez un Grand livre pour les fournisseurs sélectionnés.';
        }


        //Unsupported feature: CodeInsertion on "NewPurchaseQuote(Action 1901469405)". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<FINXL9.00.001 KSW 29/09/2016
        // //<<FINXL9.00.001 ACH 11/08/2016
        // IF recFinXLSetup.READPERMISSION THEN
        //  PurchaseHook.fctInsertPurchaseHeaderFromVendor(1,"No.");
        // //>>FINXL9.00.001 ACH 11/08/2016
        MasterDataHook.fctInsertPurchaseHeaderFromVendor(1,"No.");
        //>>FINXL9.00.001 KSW 29/09/2016
        */
        //end;

        //Unsupported feature: PropertyDeletion on "NewPurchaseQuote(Action 1901469405)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "NewPurchaseQuote(Action 1901469405)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "NewPurchaseQuote(Action 1901469405)". Please convert manually.



        //Unsupported feature: CodeInsertion on "NewPurchaseInvoice(Action 1907709505)". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<FINXL9.00.001 KSW 29/09/2016
        // //<<FINXL9.00.001 ACH 11/08/2016
        // IF recFinXLSetup.READPERMISSION THEN
        //  PurchaseHook.fctInsertPurchaseHeaderFromVendor(3,"No.");
        // //>>FINXL9.00.001 ACH 11/08/2016
        MasterDataHook.fctInsertPurchaseHeaderFromVendor(3,"No.");
        //>>FINXL9.00.001 KSW 29/09/2016
        */
        //end;

        //Unsupported feature: PropertyDeletion on "NewPurchaseInvoice(Action 1907709505)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "NewPurchaseInvoice(Action 1907709505)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "NewPurchaseInvoice(Action 1907709505)". Please convert manually.



        //Unsupported feature: CodeInsertion on "NewPurchaseOrder(Action 1907375405)". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<FINXL9.00.001 KSW 29/09/2016
        // //<<FINXL9.00.001 ACH 11/08/2016
        // IF recFinXLSetup.READPERMISSION THEN
        //  PurchaseHook.fctInsertPurchaseHeaderFromVendor(2,"No.");
        // //>>FINXL9.00.001 ACH 11/08/2016
        MasterDataHook.fctInsertPurchaseHeaderFromVendor(2,"No.");
        //>>FINXL9.00.001 KSW 29/09/2016
        */
        //end;

        //Unsupported feature: PropertyDeletion on "NewPurchaseOrder(Action 1907375405)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "NewPurchaseOrder(Action 1907375405)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "NewPurchaseOrder(Action 1907375405)". Please convert manually.



        //Unsupported feature: CodeInsertion on "NewPurchaseCrMemo(Action 1905024805)". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<FINXL9.00.001 KSW 29/09/2016
        // //<<FINXL9.00.001 ACH 11/08/2016
        // IF recFinXLSetup.READPERMISSION THEN
        //  PurchaseHook.fctInsertPurchaseHeaderFromVendor(4,"No.");
        // //>>FINXL9.00.001 ACH 11/08/2016
        MasterDataHook.fctInsertPurchaseHeaderFromVendor(1,"No.");
        //>>FINXL9.00.001 KSW 29/09/2016
        */
        //end;

        //Unsupported feature: PropertyDeletion on "NewPurchaseCrMemo(Action 1905024805)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "NewPurchaseCrMemo(Action 1905024805)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "NewPurchaseCrMemo(Action 1905024805)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "NewPurchaseCrMemo(Action 1905024805)". Please convert manually.



        addafter(VendorReportSelections)
        {

            group("Relation Groups")
            {
                CaptionML = ENU = 'Relation Groups',
                            FRA = 'Groupes de relations';
                Image = Relationship;
                // action("Tax Groups")
                // {
                //     CaptionML = ENU = 'Tax Groups',
                //                 FRA = 'Groupes taxes';
                //     Image = Relationship;
                //     RunObject = Page "Drink Vendor Tax Groups";
                //     RunPageLink = "Source Type" = CONST(Vendor);
                //     RunPageView = where("Source Type" = CONST(Vendor));
                // }//BC Upgrade SHARMP16 drink-it fields
                // action("Deposit Groups")
                // {
                //     CaptionML = ENU = 'Deposit Groups',
                //                 FRA = 'Groupes consignes';
                //     Image = Relationship;
                //     RunObject = Page "Drink Deposit Groups";
                //     RunPageLink = "Source Type" = CONST(Vendor);
                //     RunPageView = where("Source Type" = CONST(Vendor));
                // }//BC Upgrade SHARMP16 drink-it fields
                // action("Discount &Groups (Drink-It)")
                // {
                //     CaptionML = ENU = 'Discount &Groups (Drink-It)',
                //                 FRA = 'Groupes &Remise (Drink-It)';
                //     Image = Relationship;
                //     RunObject = Page "Relation Drink Discount Groups";
                //     RunPageLink = "Source Type" = CONST(Vendor),
                //                   "Source No." = FIELD("No.");
                // }//BC Upgrade SHARMP16 drink-it fields
                // action("Promotion G&roups")
                // {
                //     CaptionML = ENU = 'Promotion G&roups',
                //                 FRA = 'Groupes &Promotion';
                //     Image = Relationship;
                //     RunObject = Page "Relation Promotion Groups";
                //     RunPageLink = "Source Type" = CONST(Vendor),
                //                   "Source No." = FIELD("No.");
                // }//BC Upgrade SHARMP16 drink-it 
                // action("&Exclusivity Groups")
                // {
                //     CaptionML = ENU = '&Exclusivity Groups',
                //                 FRA = 'Groupes &Exculisivité';
                //     Image = Relationship;
                //     RunObject = Page "Relation Exclusivity Groups";
                //     RunPageLink = "Source Type" = CONST(Vendor),
                //                   "Source No." = FIELD("No.");
                // }//BC Upgrade SHARMP16 drink-it 
                // action("Delivery Time")
                // {
                //     CaptionML = ENU = 'Delivery Time',
                //                 FRA = 'Heure de Livraison';
                //     Image = Relationship;
                //     RunObject = Page "Delivery Times";
                //     RunPageLink = "No." = FIELD("No.");
                //     RunPageView = sorting("No.", "Address Code")
                //                   where("Source Type" = CONST(Vendor));
                // }//BC Upgrade SHARMP16 drink-it 
            }

            // action("Quality Tests")
            // {
            //     CaptionML = ENU = 'Quality Tests',
            //                 FRA = 'Tests qualité';
            //     Description = 'QXL9.00.001';
            //     Image = TaskQualityMeasure;
            //     RunObject = Page "Quality Test List";
            //     RunPageLink = "Source Vendor No." = FIELD("No."),
            //                   "Document Date" = FIELD("Date Filter");
            //     RunPageView = sorting("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
            // }//BC Upgrade SHARMP16 drink-it
            // action(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     Description = 'FINXL9.00';
            //     Image = Category;
            //     RunObject = Page "Master Data Properties";
            //     RunPageLink = "Table ID" = CONST(23),
            //                   Code = FIELD("No.");
            // }//BC Upgrade SHARMP16 drink-it
            // action(ZycusTimeStamp)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'ZycusTime Stamp';
            //     Image = Timesheet;
            //     RunObject = Page "Zycus Master Timestamp";
            //     RunPageLink = Code = FIELD("No.");
            //     RunPageView = sorting("Table ID", Code)
            //                   ORDER(Ascending)
            //                   where("Table ID" = CONST(23));
            // }  // BC Upgrade SHARMP16 - To be moved to InterfaceFramework extension
        }
        // addafter("Ledger E&ntries")
        // {
        modify(Statistics)
        {
            ApplicationArea = Basic, Suite;
            CaptionML = ENU = 'Statistics',
                            FRA = 'Statistiques';
            // Image = Statistics;
        }
        //}
        // addafter("Statistics by C&urrencies")
        // {
        //     // group("Tracking Entries")
        //     // {
        //     //     CaptionML = ENU = 'Tracking Entries',
        //     //                 FRA = 'Ecritures traçablité';
        //     //     Image = ItemTrackingLedger;
        //     //     action("Empty Goods Trac&king")
        //     //     {
        //     //         CaptionML = ENU = 'Empty Goods Trac&king',
        //     //                     FRA = 'Traçabilité article vidange';
        //     //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
        //     //         Image = ItemTrackingLines;
        //     //         Promoted = false;
        //     //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //     //         //PromotedCategory = "Report";
        //     //         RunObject = Page "Empty Goods Tracking Overview";
        //     //         RunPageLink = "Source Type Filter" = CONST(Vendor),
        //     //                       "Source No. Filter" = FIELD("No."),
        //     //                       "Date Filter" = FIELD("Date Filter"),
        //     //                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
        //     //                       "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter");
        //     //     }
        //     // }//BC Upgrade SHARMP16 drink-it
        // }
        // addafter("Item &Tracking Entries")
        // {
        //     action("SSCC Tracking Entries")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Entries',
        //                     FRA = 'Ecritures traçablité SSCC';
        //         Image = ItemTrackingLedger;

        //         trigger OnAction();
        //         var
        //             SSCCTrackingMgt: Codeunit "SSCC Tracking Management";
        //         begin
        //             // <<DITW15.00.00.38 DDR 19/11/2010 #1139
        //             SSCCTrackingMgt.CallSSCCTrackingEntryForm(2, rec."No.", '', '', '', '', '', 0);
        //         end;
        //     }
        // }//BC Upgrade SHARMP16 drink-it
        // addafter("Line Discounts")
        // {
        //     // action("Purchase Net Cost")
        //     // {
        //     //     Caption = 'Purchase Net Cost';
        //     //     Image = Price;
        //     //     RunObject = Page "Purchase Net Cost";
        //     //     RunPageLink = "Vendor No." = FIELD("No.");
        //     // }//BC Upgrade SHARMP16 drink-it
        //     // action("Dis&count Charges")
        //     // {
        //     //     CaptionML = ENU = 'Dis&count Charges',
        //     //                 FRA = '&Frais de remise';
        //     //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
        //     //     Image = TaxSetup;
        //     //     RunObject = Page "Purchase Discount Item Charges";
        //     //     RunPageLink = "Purchase Type" = CONST(Vendor),
        //     //                   "Purchase Code" = FIELD("No.");
        //     // }//BC Upgrade SHARMP16 drink-it
        //     // action("Promotio&n Charges")
        //     // {
        //     //     CaptionML = ENU = 'Promotio&n Charges',
        //     //                 FRA = 'Frais de promotion';
        //     //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
        //     //     Image = TaxSetup;
        //     //     RunObject = Page "Purch. Promotion Item Charges";
        //     //     RunPageLink = "Purchase Type" = CONST(Vendor),
        //     //                   "Purchase Code" = FIELD("No.");
        //     // }//BC Upgrade SHARMP16 drink-it
        //     // group("Drink-IT Charges")
        //     // {
        //     //     CaptionML = ENU = 'Drink-IT Charges',
        //     //                 FRA = 'Frais Drink-IT';
        //     //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
        //     //     Image = TaxSetup;
        //     //     // action("Ta&x Charges")
        //     //     // {
        //     //     //     CaptionML = ENU = 'Ta&x Charges',
        //     //     //                 FRA = 'Taxe d''impôt';
        //     //     //     Description = 'DITW15.00.00.01';
        //     //     //     Image = TaxSetup;
        //     //     //     RunObject = Page "Purchase Tax Item Charges";
        //     //     //     RunPageLink = "Purchase Type" = CONST(Vendor),
        //     //     //                   "Purchase Code" = FIELD("No.");
        //     //     // }//BC Upgrade SHARMP16 drink-it
        //     //     // action("Exception Tax Groups")
        //     //     // {
        //     //     //     CaptionML = ENU = 'Exception Tax Groups',
        //     //     //                 FRA = 'Groupes taxe excéption';
        //     //     //     Description = 'DIT-770 #698';
        //     //     //     Image = TaxSetup;
        //     //     //     RunObject = Page "Vendor Exception Tax Group";
        //     //     //     RunPageLink = "Exception DTax Group Code" = FIELD("Vendor DTax Group Code");
        //     //     // }
        //     //     // action("D&eposit Charges")
        //     //     // {
        //     //     //     CaptionML = ENU = 'D&eposit Charges',
        //     //     //                 FRA = 'Friais de dépôt';
        //     //     //     Description = 'DITW15.00.00.01';
        //     //     //     Image = TaxSetup;
        //     //     //     RunObject = Page "Purchase Deposit Item Charges";
        //     //     //     RunPageLink = "Purchase Type" = CONST(Vendor),
        //     //     //                   "Purchase Code" = FIELD("No.");
        //     //     // }
        //     //     // action(Action1100083011)
        //     //     // {
        //     //     //     CaptionML = ENU = 'Dis&count Charges',
        //     //     //                 FRA = '&Frais de remise';
        //     //     //     Image = TaxSetup;
        //     //     //     RunObject = Page "Purchase Discount Item Charges";
        //     //     //     RunPageLink = "Purchase Type" = CONST(Vendor),
        //     //     //                   "Purchase Code" = FIELD("No.");
        //     //     // }
        //     //     // action(Action1100083012)
        //     //     // {
        //     //     //     CaptionML = ENU = 'Promotio&n Charges',
        //     //     //                 FRA = 'Frais de promotion';
        //     //     //     Image = TaxSetup;
        //     //     //     RunObject = Page "Purch. Promotion Item Charges";
        //     //     //     RunPageLink = "Purchase Type" = CONST(Vendor),
        //     //     //                   "Purchase Code" = FIELD("No.");
        //     //     // }
        //     // }//BC Upgrade SHARMP16 drink-it
        //     group(Others)
        //     {
        //         CaptionML = ENU = 'Others',
        //                     FRA = 'Autres';
        //         Image = Item;
        //         // action("Items &Exclusivity")
        //         // {
        //         //     CaptionML = ENU = 'Items &Exclusivity',
        //         //                 FRA = 'Articles &Exclusivité';
        //         //     Image = Item;
        //         //     RunObject = Page "Purchase Items Exclusivity";
        //         //     RunPageLink = "Purchase Type" = CONST(Vendor),
        //         //                   "Purchase Code" = FIELD("No.");
        //         // }
        //     }
        // }
        addafter(Documents)
        {
            separator(Separator1100710012)
            {
            }
            group("<Action1000000001>")
            {
                CaptionML = ENU = 'Change Log',
                            FRA = 'Journal Modification';
                Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
                Image = Log;
                group("Change Log Entries")
                {
                    CaptionML = ENU = 'Change Log Entries',
                                FRA = 'Journal Modification';
                    Description = 'DITW18.00.06 GVC 07/05/2015  DIT-770  #1335';
                    Image = Log;
                    action("<Action1000000002>")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'by Vendor',
                                    FRA = 'Fournisseur';
                        Image = Log;
                        RunObject = Page "Change Log Entries";
                        RunPageLink = "Table No." = FILTER(23),
                                      "Primary Key Field 1 Value" = FIELD("No.");
                        ToolTip = 'Executes the <Action1000000002> action.';
                    }
                    action("<Action1000000003>")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'by Default dimension',
                                    FRA = 'Affectation analytique';
                        Image = Log;
                        RunObject = Page "Change Log Entries";
                        RunPageLink = "Table No." = FILTER(352),
                                      "Primary Key Field 1 Value" = FILTER(23),
                                      "Primary Key Field 2 Value" = FIELD("No.");
                        ToolTip = 'Executes the <Action1000000003> action.';
                    }
                    action("<Action1000000004>")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'by Bank Account',
                                    FRA = 'Compte bancaire fournisseur';
                        Image = Log;
                        RunObject = Page "Change Log Entries";
                        RunPageLink = "Table No." = FILTER(288),
                                      "Primary Key Field 1 Value" = FIELD("No.");
                        ToolTip = 'Executes the <Action1000000004> action.';
                    }
                }
            }
            group(Service)
            {
                CaptionML = ENU = 'Service',
                            FRA = 'Service';
                Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
                group("&Service")
                {
                    CaptionML = ENU = '&Service',
                                FRA = '&Service';
                    Image = ServiceItem;
                    // action("Ser&vice Contracts")
                    // {
                    //     CaptionML = ENU = 'Ser&vice Contracts',
                    //                 FRA = 'Co&ntrats de service';
                    //     Image = ServiceAgreement;
                    //     Promoted = true;
                    //     PromotedCategory = Process;
                    //     RunObject = Page "Vendor Service Contracts";
                    //     RunPageLink = "Vendor No." = FIELD("No.");
                    // }//BC Upgrade SHARMP16 drink-it
                    // action("Service Contract Lines")
                    // {
                    //     CaptionML = ENU = 'Service Contract Lines',
                    //                 FRA = 'Lignes contrat de service';
                    //     Image = ServiceLedger;
                    //     Promoted = true;
                    //     PromotedCategory = Process;
                    //     RunObject = Page "Vend. Service Contract Lines";
                    //     RunPageLink = "Vendor No." = FIELD("No.");
                    // }//BC Upgrade SHARMP16 drink-it

                }
                separator(Separator1100710006)
                {
                }
            }
        }
        addafter(SaveAsTemplate)
        {
            // action("Copy Vendor From Package")
            // {
            //     CaptionML = ENU = 'Copy Vendor From Package',
            //                 FRA = 'Copier fournisseur à partir du paquet';
            //     Description = 'FINXL8.00.001';
            //     Image = Vendor;
            //     Visible = true;

            //     trigger OnAction();
            //     var
            //         lpgeCopyVendor: Page "Copy Vendor (NORRIQXL)";
            //     begin
            //         //<<FINXL7.00 RBE 17/04/2014
            //         lpgeCopyVendor.fctSetParam("No.", '', '');
            //         lpgeCopyVendor.RUNMODAL();
            //         //>>FINXL7.00 RBE 17/04/2014
            //     end;
            // }//BC Upgrade SHARMP16 drink-it
        }
        addafter("Vendor - Balance to Date")
        {
            // action("Purchase Gross-net Price report")
            // {
            //     CaptionML = DEU = 'EK Brutto-Netto Preise (Soll) (XLS)',
            //                 ENU = 'Purchase Gross-net Price report';
            //     Image = "Report";

            //     trigger OnAction();
            //     var
            //         lrptPurchaseGrossNetPrice: Report "Purchase Gross-net Price";
            //         lrVendor: Record Vendor;
            //     begin
            //         // << DITW110.00.11 SFI 12/12/2017 BL#XXXXX
            //         CurrPage.SETSELECTIONFILTER(lrVendor);
            //         lrptPurchaseGrossNetPrice.SETTABLEVIEW(lrVendor);
            //         lrptPurchaseGrossNetPrice.RUN;
            //         // >> DITW110.00.11 SFI BL#XXXXX
            //     end;
            // }//BC Upgrade SHARMP16 drink-it
            // action("Purchase Price Analysis")
            // {
            //     CaptionML = DEU = 'EK Brutto-Netto Preise Ist (XLS)',
            //                 ENU = 'Purchase Price Analysis';

            //     trigger OnAction();
            //     var
            //         lrVendor: Record Vendor;
            //         lrptPurchasePriceAnalysis: Report "Purchase Price Analysis";
            //     begin
            //         // << DITW110.00.11 SFI 12/12/2017 BL#XXXXX
            //         CurrPage.SETSELECTIONFILTER(lrVendor);
            //         lrptPurchasePriceAnalysis.SETTABLEVIEW(lrVendor);
            //         lrptPurchasePriceAnalysis.RUN;
            //         // >> DITW110.00.11 SFI BL#XXXXX
            //     end;
            // }//BC Upgrade SHARMP16 drink-it
        }
        moveafter(VendorReportSelections; History)
    }


    //Unsupported feature: PropertyModification on "Text001(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Do you want to allow payment tolerance for entries that are currently open?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Do you want to allow payment tolerance for entries that are currently open?;FRA=Souhaitez-vous autoriser les écarts de règlement pour les écritures actuellement ouvertes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Do you want to remove payment tolerance from entries that are currently open?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Do you want to remove payment tolerance from entries that are currently open?;FRA=Souhaitez-vous supprimer les écarts de règlement pour les écritures actuellement ouvertes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowMapLbl(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowMapLbl : ENU=Show on Map;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowMapLbl : ENU=Show on Map;FRA=Afficher sur une carte;
    //Variable type has not been exported.

    var
        // recFinXLSetup: Record "Finance XL Setup";
        // MasterDataHook: Codeunit "MasterData Hook";
        VendorBankAccount: Record "Vendor Bank Account";
        BalanceSubContractLCY: array[6] of Decimal;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CreateVendorFromTemplate;
    ActivateFields;
    OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6

    // <<DITW15.00.00.39 DDR 30/08/2011 #1397 - DITW16.00.00.41 AHU 07/08/2012 DIT-715 #327
    GetCalcContractBalanceLCY(BalanceSubContractLCY);
    // >>DITW15.00.00.39 DDR #1397 - DITW16.00.00.41 AHU DIT-715 #327
    */
    //end;

    local procedure AutomaticApplyTemplate();
    var
        ConfigTemplateHeader: Record "Config. Template Header";
        lrecGeneralLedgerSetup: Record "General Ledger Setup";
        CuConf: Codeunit "Config. Template Management";
        lrecRefVendor: RecordRef;
        RecRef: RecordRef;
        CodePackageID: Code[10];
    begin
        //<<FINXL8.00.001 BSA 23/06/2015 #161
        // lrecGeneralLedgerSetup.GET;
        // if lrecGeneralLedgerSetup."Apply template" then begin
        //     RecRef.GETTABLE(Rec);
        //     ConfigTemplateHeader.SETRANGE("Table ID", RecRef.NUMBER);
        //     if PAGE.RUNMODAL(PAGE::"Config. Template List", ConfigTemplateHeader, ConfigTemplateHeader.Code) = ACTION::LookupOK then begin
        //         lrecRefVendor.GETTABLE(Rec);
        //         CuConf.InsertTemplate2(lrecRefVendor, ConfigTemplateHeader);
        //         lrecRefVendor.SETTABLE(Rec);
        //     end;
        // end;//BC Upgrade SHARMP16 drink-it fields
        //>>FINXL8.00.001 BSA 23/06/2015 #161
    end;

    local procedure NoofDrinkDiscGroupsOnActivate();
    begin
        // <<DITW15.00.00.35 DDR 19/08/2009
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.35 DDR
    end;

    local procedure NoofPromotionGroupsOnActivate();
    begin
        // <<DITW15.00.00.35 DDR 19/08/2009
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.35 DDR
    end;

    local procedure NoofExclusivityGroupsOnActivat();
    begin
        CurrPage.UPDATE(true);
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

