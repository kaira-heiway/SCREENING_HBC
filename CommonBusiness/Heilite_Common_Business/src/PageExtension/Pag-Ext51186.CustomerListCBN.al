pageextension 51186 CustomerListExtCBN extends "Customer List"
{
    //     DITW15.00.00.01 DDR 26/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 09/01/2008 Remove key sorting for Tax/Depoist Item charges menu
    // DITW15.00.00.01 DDR 21/01/2008 Added Drink-it Disc.& Promotion functionalities
    //                                added menu into Customer, Sales & Purchases
    // DITW15.00.00.01 DDR 05/02/2008 Change captions menu (Drink-it)
    // DITW15.00.00.01 DDR 19/03/2008 Added menu Deposit Limits into Sales button
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.35 DDR 10/04/2009 Added menu Buildings into Customer button
    //                                Added columns
    //                                  "Building No.","Building Employment Date","Building Last Inactive Date"
    //                                  "Contract Cust. Posting Group"
    //                     23/09/2009 issue 814 Added columns (all fields) contract cust. posting groups (non-visible)
    //                 DDR 18/06/2010 issue 1028 added menu "additional credit limit" on Sales button
    // DITW15.00.00.38 DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Entries' into 'Sales' menu button
    // DITW16.00.00.38 DDR 04/03/2011 DIT-715 #65 RTC Upgrade & Performances
    //                                  Added menu (button) to synchronize with the card
    //                                    Customer\Empty Goods Tracking
    //                                    Customer\Service contract lines
    //                                  Added button Print\Empty Goods statement
    // DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                  Added fields "Telesales Level Group Code","Telesales Level Based" into 'Telesales' tab
    //                     22/04/2011   Added 'Customized Calendar' menu into 'Customer' button
    //                     15/07/2011 issue 1230 Added 'Telesales Overview' menu into 'Customer' button
    //                     29/08/2011 issue 1396 Added fields "No. of Exclusivity Groups" into 'Drink-it' tab
    //                                           Added 'Exclusivity Groups' menu into 'Customer' button
    //                                           Added 'Item Exclusivity' menu into 'Sales' button
    // DITW16.00.00.40 PRODW14.00.00.08.19 DDR 20/12/2011 issue 1466 Added menu 'Sales\Quality Standards'
    //                     06/04/2012 DIT-715 #243 Loyalty functionnality
    //                                  Added fields "Loyalty Warnings" into 'Drink-it' tab
    //                                  Added 'Item Loyalty Statistics' menu into 'Customer' button
    //                                  Added 'Loyalty Groups' menu into 'Customer' button
    //                                  Added 'Item Loyalty' menu into 'Sales' button
    //                                  Added 'Loyalty Statement' menu into 'Print' button
    //                     29/06/2012 DIT-715 #243 Modified Loyalty Captions
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                  Added fields "Contract Cust. Post. Gr. Plant"
    //                                  Added 'Plant' menu button
    // DITW16.00.00.42 AHU 18/12/2012 DIT-715 #327 Added 'Blanket Contracts';'DIT Contracts' menu into 'Customer' buttonj
    // DITW16.00.00.43 DDR 13/05/2013 DIT-715 #604 Added fields "Default Ship-to Code" (shipping tab)
    //                 AHU 12/06/2013 DIT-715 #617 Added factbox2035463 <Cust DContract Stats. FactBox>
    //                 AHU 12/06/2013 DIT-715 #617 Modified Captions Blanket Contracts
    //                                             Added 'DIT Contract Volumes' menu 'Cust' button
    //                 AHU 20/06/2013 DIT-715 #617 Modified 'DIT Contract Volumes' menu properties

    // FINXL7.00.001 RBE 20/03/2013 : Added fields Address,"Address 2","VAT Registration No.","Balance (LCY)" and
    //                                "Net Change (LCY)" on page

    // DITW17.00.02 DDR 13/05/2013 DIT-715 #604
    //                  17/06/2013 DIT-715 #617 merge
    //                  21/06/2013 DIT-715 #617 merge
    //              DDR 09/08/2013 DIT-770 #102 Added 'Tax Groups' Action into 'Relation' button
    // DITW17.00.02 SR 06/09/2013 DIT-770 #134 : Add menuitem 'Fixed Asset List' (group 'Related Items')
    // DITW17.00.02 AT  26/09/2013 DIT-770 #182
    //                             Added menuitem Delayed Promotions in Sales Menu
    // DITW17.00.02 SR 10/10/2013 DIT-770 #205 : New Action "Telesales Call Update" Added
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 SR 12/05/2013 DIT-770 #151 : New Field Added "Starting Date" etc.
    // DITW17.00.03 DDR 13/02/2014 DIT-770 #389 Sales Conditions Report
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #623 New Customer Exception Tax Group functionality
    //                                          Added menu to "Customer Exception Tax Groups"
    // DITW17.10.03 DDR 13/06/14 DIT-770 #392 Item Quota Management Functionality
    //                                        Added menu "Quota Group","Item Quota Group"
    // DITW17.10.05 WSA 04/08/14 DIT-770 #761 Added Action Invoice List
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Added Action Customer responsibility center relations
    // DITW18.00.06 MSF 16/07/2015 DIT-770 #1410 Added field "Our Account No."
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368  Modify Rename Caption DIT Contracts to Financial Contracts
    //                                                   Rename Caption DIT Contracts (Customer Volume) to Financial Contracts (Customer Volume)
    // DITW18.00.06A DDR 24/11/2015 DIT-770 #1701 Added fields "Credit Limit","Deposit Limit","Deposit Limit (LCY)","Deposit Cust. Balance (LCY)"
    // DITW18.00.07 KJB 18/02/2016 DIT-770 #1042 Add shortcut 'Ctrl+B' to comments menu button
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Customer"
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 Removed shortcut 'Ctrl+B' from comments menu button
    // DITW18.00.07 VSC 04/05/2016 DIT-770 #1968 Add Action Page Link "Delivery Times" where "Source Type" = Customer
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.07 MSF 04/07/2016 DIT-770 #1965  Item and Item list/ customer and Customer List - navigate ribbon
    //                                            Check And fix  Ribbon

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.11 SFI 12/12/2017 NRQ#10509 Sales and purchase gross net prices

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Added fields: Account Group, Business Segment, Business OrganizationalSegment, Customer Type, Customer Sub-Type, Local Customer Sub-Type
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 24.08.2017 # MDM Customer Card
    //   # Added page action "New Customer (Using Template)"
    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 14.09.2017 # MDM Customer Card
    //   # Deleted not needed Page Action "New Customer (Using Template)"
    // HEI.04 Issue#465 Heilite Base Isyed01 13.10.2017
    //  Added feild to list page "Netting Agreement","Vendor No."
    // HEI.05 FDD Indirect Customer Master IBM.NAIKH01 01.10.2018
    //   # Added a new field "Customer Relationship Type"
    // HEI.06 RFC-CHG0255777 IBM.LS 17.12.2018
    //   # New Fields added: "Min. Order Value Limit"
    //                       "Min. Order Value Limit Type"
    // HEI.07 INC2095982 IBM.LS 01.04.2019
    //   # Field added: City
    // HEI.08 FDD-BA-SLSGAP02 IBM NASTAA02 08.01.2018 # County Code
    //   # Added Field "County"
    // HEI.09 FDD-SR_HT464-ORTEC IBM HORTOC01 # new action created "Handling Time & Trucks" & new fields added "Longitude Coordinate" + "Latitude Coordinate"
    // HEI.11 FDD-CHG2015566 IBM PATHAA02 17.06.2019
    //   # Added new Fields 'Blocked Reason Code', 'Territory Code', 'Service Zone Code'
    // HEI.12 FDD-HT520 IBM.GUNERE01 26.08.2019
    //   # Added Report Customer Trial Balance FR, Report Customer Det. Trial Balance FR to Finance section
    //     in Page Actions
    // HEI.13 FDD-HT587 IBM BULIMC01 14/10/2019 - new flowfield displayed:"Classification"
    // HEI.14 CHG2043964 IBM GAVANM01 23.01.2020
    //   # Column "E-mail" is added
    // HEI.15 FDD-HT1146 IBM SURYAS01 20/04/2020
    //   #Added Report "Customer Trial Balance DRC","Cust. Detail Trial Balan DRC" to Finance section
    //     in Page Actions


    // version NAVW110.0.00.16585,FINXL10.00,DITW111.00.13,NRQ#101918,HEI.06
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields.
    // 2. Remove Drink-IT Actions.
    // 3. Remove Drink-IT RElated code.
    // 4. REmove Drink-IT Groups.
    // 5. Add ApplicationArea property in all Fields and Actions.
    // 6. Remove Duplicate Actions. 
    // 7. 
    // BC Upgrade BHARDA11 <<

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.', FRA = 'Spécifie le numéro du client. Le champ est renseigné automatiquement à partir d''une souche de numéros définie, ou vous saisissez manuellement le numéro, car vous avez activé la saisie manuelle de numéro dans le paramétrage de la souche de numéros.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the customer''s name. This name will appear on all sales documents for the customer. You can enter a maximum of 50 characters, both numbers and letters.', FRA = 'Spécifie le nom du client. Ce nom apparaîtra sur tous les documents vente destinés au client. Vous pouvez entrer au maximum 50 caractères, des chiffres et des lettres.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code for the responsibility center that will administer this customer by default.', FRA = 'Spécifie le code du centre de gestion qui gère ce client par défaut.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies from which location sales to this customer will be processed by default.', FRA = 'Spécifie à partir de quel magasin les ventes à ce client seront traitées par défaut.';
        }
        modify("Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code.', FRA = 'Spécifie le code postal.';
        }
        modify("Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region of the address.', FRA = 'Spécifie le pays/la région de l''adresse.';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the customer''s telephone number.', FRA = 'Spécifie le numéro de téléphone du client.';
        }
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the customer''s IC partner code, if the customer is one of your intercompany partners.', FRA = 'Spécifie le code de partenaire IC du client si ce dernier est l''un de vos partenaires intersociétés.';
        }
        modify(Contact)
        {
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact when you do business with this customer.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement lorsque vous traitez avec ce client.';
        }
        modify("Salesperson Code")
        {
            ToolTipML = ENU = 'Specifies a code for the salesperson who normally handles this customer''s account.', FRA = 'Spécifie un code pour le vendeur qui s''occupe habituellement du compte de ce client.';
        }
        modify("Customer Posting Group")
        {
            ToolTipML = ENU = 'Specifies the customer''s market type to link business transactions to.', FRA = 'Spécifie le type de marché du client auquel associer des transactions commerciales.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the customer''s trade type to link transactions made for this customer with the appropriate general ledger account according to the general posting setup.', FRA = 'Spécifie le type commercial du client pour lier les transactions effectuées pour ce client au compte général approprié en fonction des paramètres de validation généraux.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the customer''s VAT specification to link transactions made for this customer to.', FRA = 'Spécifie le détail TVA du client auquel associer des transactions faites pour ce client.';
        }
        modify("Customer Price Group")
        {
            ToolTipML = ENU = 'Specifies the customer price group code, which you can use to set up special sales prices in the Sales Prices window.', FRA = 'Spécifie le code groupe prix client que vous pouvez utiliser pour configurer des prix spécifiques dans la fenêtre Prix vente.';
        }
        modify("Customer Disc. Group")
        {
            ToolTipML = ENU = 'Specifies the customer discount group code, which you can use as a criterion to set up special discounts in the Sales Line Discounts window.', FRA = 'Spécifie le code groupe remises client que vous pouvez utiliser comme critère pour configurer des remises spécifiques dans la fenêtre Remises ligne vente.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a code that indicates the payment terms that you require of the customer.', FRA = 'Spécifie un code qui indique les conditions de paiement que vous exigez du client.';
        }
        modify("Reminder Terms Code")
        {
            ToolTipML = ENU = 'Specifies how reminders about late payments are handled for this customer.', FRA = 'Spécifie la manière dont les relances concernant les retards de paiement sont traitées pour ce client.';
        }
        modify("Fin. Charge Terms Code")
        {
            ToolTipML = ENU = 'Specifies finance charges are calculated for the customer.', FRA = 'Spécifie les intérêts calculés pour le client.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the default currency for the customer.', FRA = 'Spécifie la devise par défaut pour le client.';
        }
        modify("Language Code")
        {
            ToolTipML = ENU = 'Specifies the language to be used on printouts for this customer.', FRA = 'Spécifie la langue à utiliser sur des impressions destinées à ce client.';
        }
        modify("Search Name")
        {
            Importance = Promoted;
            ToolTipML = ENU = 'Specifies an alternate name that you can use to search for a customer when you cannot remember the value in the Name field.', FRA = 'Spécifie un autre nom que vous pouvez utiliser pour rechercher un client lorsque vous ne vous souvenez plus de la valeur dans le champ Nom.';
        }
        modify("Credit Limit (LCY)")
        {
            ToolTipML = ENU = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.', FRA = 'Spécifie le montant maximal selon lequel vous autorisez au client à dépasser le solde de paiement avant que des alertes ne soient émises.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies which transactions with the customer that cannot be blocked, for example, because the customer is declared insolvent.', FRA = 'Spécifie les transactions avec le client qui ne peuvent pas être bloquées, par exemple, parce que le client est déclaré insolvable.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the customer card was last modified.', FRA = 'Indique la date à laquelle la fiche client a été modifiée pour la dernière fois.';
        }
        modify("Application Method")
        {
            ToolTipML = ENU = 'Specifies how to apply payments to entries for this customer.', FRA = 'Spécifie la manière de lettrer des paiements avec des écritures pour ce client.';
        }
        modify("Combine Shipments")
        {
            ToolTipML = ENU = 'Specifies if several orders delivered to the customer can appear on the same sales invoice.', FRA = 'Spécifie si plusieurs commandes livrées au client peuvent se trouver sur la même facture vente.';
        }
        modify(Reserve)
        {
            ToolTipML = ENU = 'Specifies whether items will never, automatically (Always), or optionally be reserved for this customer. Optional means that you must manually reserve items for this customer.', FRA = 'Spécifie si des articles ne seront jamais, automatiquement (toujours) ou éventuellement réservés pour ce client. En option signifie que vous devez réserver manuellement des articles pour ce client.';
        }
        modify("Shipping Advice")
        {
            ToolTipML = ENU = 'Specifies if the customer accepts partial shipment of orders.', FRA = 'Spécifie si le client accepte l''expédition partielle des commandes.';
        }
        modify("Shipping Agent Code")
        {
            ToolTipML = ENU = 'Specifies which shipping company is used when you ship items to the customer.', FRA = 'Spécifie le transporteur utilisé lorsque vous livrez des articles à ce client.';
        }
        modify("Base Calendar Code")
        {
            ToolTipML = ENU = 'Specifies a customizable calendar for shipment planning that includes the customer''s working days and holidays.', FRA = 'Spécifie un calendrier personnalisable pour la planification d''expédition qui inclut les vacances et jours ouvrés du client.';
        }
        modify("Balance (LCY)")
        {
            ToolTipML = ENU = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.', FRA = 'Spécifie le montant règlement que le client doit régler pour les ventes terminées. Cette valeur est également appelée le solde du client.';
        }
        modify("Balance Due (LCY)")
        {
            ToolTipML = ENU = 'Specifies payments from the customer that are overdue per today''s date.', FRA = 'Spécifie les paiements effectués par le client échus pour la date du jour.';
        }
        moveafter("Balance (LCY)"; "Balance Due (LCY)")
        modify("Sales (LCY)")
        {
            ToolTipML = ENU = 'Specifies the total net amount of sales to the customer in LCY.', FRA = 'Spécifie le montant net total des ventes à ce client en devise société.';
        }
        moveafter("Balance Due (LCY)"; "Sales (LCY)")
        addafter("No.")
        {
            field("Account Group"; Rec."Account Group FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Account Group field.';
            }
        }
        addafter("Location Code")
        {
            // field(Address; Rec.Address)
            // {
            //     Description = 'FINXL7.00.001';
            // }
            // field("Address 2"; Rec."Address 2")
            // {
            //     Description = 'FINXL7.00.001';
            // }
        }
        addafter("IC Partner Code")
        {
            // field("Our Account No."; Rec."Our Account No.")
            // {
            //     Description = 'DITW18.00.06 MSF 16/07/2015 DIT-770 #1410';
            //     Visible = false;
            // }
        }
        addafter(Contact)
        {
            // field("Caller-ID"; Rec."Caller-ID")
            // {
            //     Visible = false;
            // }
            // field("Sell-to Contact No."; Rec."Sell-to Contact No.")
            // {
            //     Visible = false;
            // }
            // field("Ship-to Code"; Rec."Ship-to Code")
            // {
            // }
            // field("VAT Registration No."; Rec."VAT Registration No.")
            // {
            //     Description = 'FINXL7.00.001';
            // }
        }
        moveafter(Contact; "Ship-to Code")
        addafter("Customer Posting Group")
        {
            // BC Upgrade BHARDA11 >> ---- Drink-IT Fields
            // field("Contract Cust. Post. Gr. Stand"; Rec."Contract Cust. Post. Gr. Stand")
            // {
            //     Visible = false;
            // }
            // field("Contract Cust. Post. Gr. Rent"; Rec."Contract Cust. Post. Gr. Rent")
            // {
            //     Visible = false;
            // }
            // field("Contract Cust. Post. Gr. Loan"; Rec."Contract Cust. Post. Gr. Loan")
            // {
            //     Visible = false;
            // }
            // field("Contract Cust. Post. Gr. LoanU"; Rec."Contract Cust. Post. Gr. LoanU")
            // {
            //     Visible = false;
            // }
            // field("Contract Cust. Post. Gr. Maint"; Rec."Contract Cust. Post. Gr. Maint")
            // {
            //     Visible = false;
            // }
            // field("Contract Cust. Post. Gr. Other"; Rec."Contract Cust. Post. Gr. Other")
            // {
            //     Visible = false;
            // }
            // field("Contract Cust. Post. Gr. Plant"; Rec."Contract Cust. Post. Gr. Plant")
            // {
            //     Description = 'DIT-715 #297';
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ---- Drink-IT Fields
        }
        addafter("Search Name")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Field "Credit Limit"
            // field("Credit Limit"; Rec."Credit Limit")
            // {
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field "Credit Limit"

        }
        addafter("Balance (LCY)")
        {
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Change (LCY) field.';
                //Description = 'FINXL7.00.001';BC Upgrade YADAVM09
            }
        }
        addafter("Sales (LCY)")
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Fields
            // field("Building No."; Rec."Building No.")
            // {
            // }
            // field("Building Employment Date"; Rec."Building Employment Date")
            // {
            //     Visible = false;
            // }
            // field("Building Last Inactive Date"; Rec."Building Last Inactive Date")
            // {
            //     Visible = false;
            // }
            // field("Deposit Limit"; Rec."Deposit Limit")
            // {
            //     Visible = false;
            // }
            // field("Deposit Limit (LCY)"; Rec."Deposit Limit (LCY)")
            // {
            //     Visible = false;
            // }
            // field("Deposit Cust. Balance (LCY)"; Rec."Deposit Cust. Balance (LCY)")
            // {
            //     Visible = false;
            // }
            // field("Sundry Customer"; Rec."Sundry Customer")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 1 Code"; Rec."Shortcut Property 1 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 2 Code"; Rec."Shortcut Property 2 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 3 Code"; Rec."Shortcut Property 3 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 4 Code"; Rec."Shortcut Property 4 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 5 Code"; Rec."Shortcut Property 5 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 6 Code"; Rec."Shortcut Property 6 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 7 Code"; Rec."Shortcut Property 7 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 8 Code"; Rec."Shortcut Property 8 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 9 Code"; Rec."Shortcut Property 9 Code")
            // {
            //     Visible = false;
            // }
            // field("Shortcut Property 10 Code"; Rec."Shortcut Property 10 Code")
            // {
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Fields
            field("Business Segment"; Rec."Business Segment FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Business Segment field.';
            }
            field("Business OrganizationalSegment"; Rec."Business Org. Segment FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Business Organizational Segment field.';
            }
            field("Customer Type"; Rec."Customer Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Type field.';
            }
            field("Customer Sub-Type"; Rec."Customer Sub-Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Sub-Type field.';
            }
            field("Local Customer Sub-Type"; Rec."Local Customer Sub-Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Local Customer Sub-Type field.';
            }
            field("Netting Agreement"; Rec."Netting Agreement FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Netting Agreement field.';
            }
            field("Vendor No."; Rec."Vendor No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.';
            }
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
            }
            field("Sales Routes"; Rec."Sales Routes FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Routes field.';
            }
            field("Contract Type"; Rec."Contract Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contract Type field.';
            }
            field("Min. Order Value Limit"; Rec."Min. Order Value Limit FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Min. Order Value Limit field.';
            }
            field("Min. Order Value Limit Type"; Rec."Min. Ord. Value Limit Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Min. Order Value Limit Type field.';
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the City field.';
            }
            field(County; Rec.County)
            {
                ApplicationArea = All;
                Description = 'HEI.08';
                ToolTip = 'Specifies the value of the County field.';
            }
            field("Latitude Coordinate"; Rec."Latitude Coordinate FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Latitude Coordinate field.';
            }
            field("Longitude Coordinate"; Rec."Longitude Coordinate FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Longitude Coordinate field.';
            }
            field("Blocked Reason Code"; Rec."Blocked Reason Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Blocked Reason Code field.';
            }
            field("Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Territory Code field.';
            }
            field("Service Zone Code"; Rec."Service Zone Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the service zone that is assigned to the customer.';
            }
            field(Classification; Rec."Classification FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Classification field.';
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Email field.';
            }
        }
        addafter(Control1902613707)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Page ("Cust DContract Stats. FactBox")
            // part(Control1100086003; "Cust DContract Stats. FactBox")
            // {
            //     SubPageLink = "No." = FIELD("No.");
            //     Visible = false;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Page ("Cust DContract Stats. FactBox")

        }
        moveafter("Credit Limit (LCY)"; "Balance (LCY)")
    }
    actions
    {
        modify("&Customer")
        {
            CaptionML = ENU = '&Customer', FRA = '&Client';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';

            //Unsupported feature: Change Name on "Dimensions(Action 66)". Please convert manually.

        }
        modify(DimensionsSingle)
        {
            CaptionML = ENU = 'Dimensions-Single', FRA = 'Affectations - Simples';
            ToolTipML = ENU = 'View or edit the single set of dimensions that are set up for the selected record.', FRA = 'Affichez ou modifiez l''ensemble unique de dimensions paramétrées pour l''enregistrement sélectionné.';
        }
        modify(DimensionsMultiple)
        {
            CaptionML = ENU = 'Dimensions-&Multiple', FRA = 'Affectations - &Multiples';
            ToolTipML = ENU = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.', FRA = 'Affichez ou modifiez les axes analytiques pour un groupe d''enregistrements. Vous pouvez affecter des codes axe aux transactions dans le but de répartir les coûts et d''analyser les informations d''historique.';
        }
        modify("Bank Accounts")
        {
            CaptionML = ENU = 'Bank Accounts', FRA = 'Comptes bancaires';
            ToolTipML = ENU = 'View or set up the customer''s bank accounts. You can set up any number of bank accounts for each customer.', FRA = 'Affichez ou configurez les comptes bancaires de votre client. Vous pouvez configurer autant de comptes bancaires que vous le souhaitez pour chaque client.';

            //Unsupported feature: Change Name on ""Bank Accounts"(Action 58)". Please convert manually.

        }
        modify("Direct Debit Mandates")
        {
            CaptionML = ENU = 'Direct Debit Mandates', FRA = 'Mandats de domiciliation européenne';
            ToolTipML = ENU = 'View the direct-debit mandates that reflect agreements with customers to collect invoice payments from their bank account.', FRA = 'Affichez les mandats de prélèvement que vous définissez afin de refléter les accords passés avec les clients pour le recouvrement des paiements des factures sur leur compte bancaire.';
        }
        modify(ShipToAddresses)
        {
            CaptionML = ENU = 'Ship-&to Addresses', FRA = '&Adresses destinataire';
            ToolTipML = ENU = 'View or edit alternate shipping addresses where the customer wants items delivered if different from the regular address.', FRA = 'Affichez ou modifiez les autres adresses de livraison où le client souhaite faire livrer les articles, si elles sont différentes de l''adresse habituelle.';
        }
        modify("C&ontact")
        {
            Promoted = true;
            PromotedCategory = Report;
            CaptionML = ENU = 'C&ontact', FRA = 'C&ontact';
            ToolTipML = ENU = 'View or edit detailed information about the contact person at the customer.', FRA = 'Affichez ou modifiez des informations détaillées concernant la personne à contacter chez le client.';

            //Unsupported feature: Change Name on ""C&ontact"(Action 60)". Please convert manually.

        }
        // BC Upgrade BHARAD11 >> ---- "Cross Re&ferences" Not found
        // modify("Cross Re&ferences")
        // {
        //     CaptionML = ENU = 'Cross Re&ferences', FRA = '&Références externes';
        //     ToolTipML = ENU = 'Set up the customer''s own identification of items that you sell to the customer. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.', FRA = 'Configurez la manière dont le client identifie les articles que vous lui vendez. Les références externes au numéro d''article du client impliquent que le numéro d''article est automatiquement affiché sur les documents vente au lieu du numéro que vous utilisez.';
        // }
        // BC Upgrade BHARAD11 << ---- "Cross Re&ferences" Not found

        modify(OnlineMap)
        {
            CaptionML = ENU = 'Online Map', FRA = 'Online Map';
            ToolTipML = ENU = 'View the address on an online map.', FRA = 'Affichez l''adresse sur une carte en ligne.';
        }
        modify(ApprovalEntries)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify(ActionGroupCRM)
        {
            CaptionML = ENU = 'Dynamics CRM', FRA = 'Dynamics CRM';
        }
        modify(CRMGotoAccount)
        {
            CaptionML = ENU = 'Account', FRA = 'Compte';
            ToolTipML = ENU = 'Open the coupled Microsoft Dynamics CRM account.', FRA = 'Ouvrez le compte Microsoft Dynamics CRM couplé.';
        }

        modify(CRMSynchronizeNow)
        {
            CaptionML = ENU = 'Synchronize Now', FRA = 'Synchroniser maintenant';
            ToolTipML = ENU = 'Send or get updated data to or from Microsoft Dynamics CRM.', FRA = 'Envoyez/recevez des données mises à jour à/de Microsoft Dynamics CRM.';
        }
        modify(UpdateStatisticsInCRM)
        {
            CaptionML = ENU = 'Update Account Statistics', FRA = 'Mettre à jour les statistiques compte';
            ToolTipML = ENU = 'Send customer statistics data to Dynamics CRM to update the Account Statistics FactBox.', FRA = 'Envoyez les données statistiques client à Dynamics CRM pour mettre à jour le récapitulatif Statistiques compte';
        }

        modify(Coupling)
        {
            CaptionML = comment = 'Coupling is a noun', ENU = 'Coupling', FRA = 'Couplage';
            ToolTipML = ENU = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.', FRA = 'Créez, modifiez ou supprimez un couplage entre l''enregistrement Microsoft Dynamics NAV et un enregistrement Microsoft Dynamics CRM.';
        }
        modify(ManageCRMCoupling)
        {
            CaptionML = ENU = 'Set Up Coupling', FRA = 'Configurer le couplage';
            ToolTipML = ENU = 'Create or modify the coupling to a Microsoft Dynamics CRM account.', FRA = 'Créez ou modifiez le couplage avec un compte Microsoft Dynamics CRM.';
        }
        modify(DeleteCRMCoupling)
        {
            CaptionML = ENU = 'Delete Coupling', FRA = 'Supprimer le couplage';
            ToolTipML = ENU = 'Delete the coupling to a Microsoft Dynamics CRM account.', FRA = 'Supprimez le couplage avec un compte Microsoft Dynamics CRM.';
        }
        modify(Create)
        {
            CaptionML = ENU = 'Create', FRA = 'Créer';
        }
        modify(CreateInCRM)
        {
            CaptionML = ENU = 'Create Account in Dynamics CRM', FRA = 'Créer un compte dans Dynamics CRM';
            ToolTipML = ENU = 'Generate the account in the coupled Microsoft Dynamics CRM account.', FRA = 'Générez le compte dans le compte Microsoft Dynamics CRM couplé.';
        }
        modify(CreateFromCRM)
        {
            CaptionML = ENU = 'Create Customer in Dynamics NAV', FRA = 'Créer un client dans Dynamics NAV';
            ToolTipML = ENU = 'Generate the customer in the coupled Microsoft Dynamics CRM account.', FRA = 'Générez le client dans le compte Microsoft Dynamics CRM couplé.';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }

        modify(Statistics)
        {

            //Unsupported feature: Change Level on "Statistics(Action 18)". Please convert manually.

            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';

            //Unsupported feature: Change Name on "Statistics(Action 18)". Please convert manually.

        }
        modify("S&ales")
        {

            //Unsupported feature: Change Level on ""S&ales"(Action 21)". Please convert manually.

            CaptionML = ENU = 'S&ales', FRA = '&Ventes';
        }
        modify("Entry Statistics")
        {

            //Unsupported feature: Change Level on ""Entry Statistics"(Action 19)". Please convert manually.

            CaptionML = ENU = 'Entry Statistics', FRA = 'Statistiques écritures';
        }
        modify("Statistics by C&urrencies")
        {

            //Unsupported feature: Change Level on ""Statistics by C&urrencies"(Action 63)". Please convert manually.

            CaptionML = ENU = 'Statistics by C&urrencies', FRA = 'Statistiques par &devise';
        }
        modify("Item &Tracking Entries")
        {

            //Unsupported feature: Change Level on ""Item &Tracking Entries"(Action 6500)". Please convert manually.

            CaptionML = ENU = 'Item &Tracking Entries', FRA = '&Ecritures traçabilité';
        }

        modify("Sales_InvoiceDiscounts")
        {
            CaptionML = ENU = 'Invoice &Discounts', FRA = 'Remises &facture';
            ToolTipML = ENU = 'Set up different discounts that are applied to invoices for the customer. An invoice discount is automatically granted to the customer when the total on a sales invoice exceeds a certain amount.', FRA = 'Configurez des remises différentes qui seront appliquées aux factures client. Une remise facture est automatiquement accordée au client lorsque le total sur la facture vente dépasse un certain montant.';
        }
        // BC Upgrade BHARDA11 >> ----Actions Not Found
        // modify("Sales_Prices")
        // {
        //     CaptionML = ENU = 'Prices', FRA = 'Prix';
        //     ToolTipML = ENU = 'View or set up different prices for items that you sell to the customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Affichez ou paramétrez des prix différents pour les articles que vous vendez au client. Un prix article est automatiquement affecté sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        // }
        // modify("Sales_LineDiscounts")
        // {
        //     CaptionML = ENU = 'Line Discounts', FRA = 'Remises ligne';
        //     ToolTipML = ENU = 'Set up different discounts for items that you sell to the customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Paramétrez des remises différentes pour les articles que vous vendez au client. Une remise article est automatiquement affectée sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        // }
        // BC Upgrade BHARDA11 >> ----Actions Not Found

        modify("Prepa&yment Percentages")
        {
            CaptionML = ENU = 'Prepa&yment Percentages', FRA = 'Pourcentages acom&pte';
        }
        // BC Upgrade BHARDA11 >> Action not found
        // modify("S&td. Cust. Sales Codes")
        // {
        //     CaptionML = ENU = 'S&td. Cust. Sales Codes', FRA = 'Codes &vente std client';
        // }
        // BC Upgrade BHARDA11 << Action not found

        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify(Quotes)
        {
            CaptionML = ENU = 'Quotes', FRA = 'Devis';

            //Unsupported feature: Change RunPageView on "Quotes(Action 27)". Please convert manually.

        }
        modify(Orders)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';

            //Unsupported feature: Change RunPageView on "Orders(Action 28)". Please convert manually.

        }
        modify("Return Orders")
        {
            CaptionML = ENU = 'Return Orders', FRA = 'Retours';

            //Unsupported feature: Change RunPageView on ""Return Orders"(Action 70)". Please convert manually.

        }
        modify("Issued Documents")
        {
            CaptionML = ENU = 'Issued Documents', FRA = 'Documents émis';
        }
        modify("Issued &Reminders")
        {
            CaptionML = ENU = 'Issued &Reminders', FRA = '&Relances émises';
        }
        modify("Issued &Finance Charge Memos")
        {
            CaptionML = ENU = 'Issued &Finance Charge Memos', FRA = 'Fact&ures d''intérêts émises';
        }
        modify("Blanket Orders")
        {
            CaptionML = ENU = 'Blanket Orders', FRA = 'Commandes ouvertes';
        }
        modify(Service)
        {
            CaptionML = ENU = 'Service', FRA = 'Service';
        }
        modify("Service Orders")
        {

            //Unsupported feature: Change Level on ""Service Orders"(Action 81)". Please convert manually.

            CaptionML = ENU = 'Service Orders', FRA = 'Commandes service';
        }
        modify("Ser&vice Contracts")
        {

            //Unsupported feature: Change Level on ""Ser&vice Contracts"(Action 68)". Please convert manually.

            CaptionML = ENU = 'Ser&vice Contracts', FRA = '&Contrats de service';
        }
        modify("Service &Items")
        {

            //Unsupported feature: Change Level on ""Service &Items"(Action 69)". Please convert manually.

            CaptionML = ENU = 'Service &Items', FRA = 'Ar&ticles de service';
        }
        modify(NewSalesBlanketOrder)
        {
            CaptionML = ENU = 'Blanket Sales Order', FRA = 'Commande ouverte vente';
        }
        modify(NewSalesQuote)
        {
            CaptionML = ENU = 'Sales Quote', FRA = 'Devis';
            ToolTipML = ENU = 'Create a new sales quote where you offer items or services to a customer.', FRA = 'Créez un devis proposant des articles ou des services à un client.';
            Promoted = false;
        }
        modify(NewSalesInvoice)
        {
            CaptionML = ENU = 'Sales Invoice', FRA = 'Facture vente';
            ToolTipML = ENU = 'Create a sales invoice for the customer.', FRA = 'Créez une facture vente pour le client.';
        }
        modify(NewSalesOrder)
        {
            CaptionML = ENU = 'Sales Order', FRA = 'Commande vente';
            ToolTipML = ENU = 'Create a sales order for the customer.', FRA = 'Créez une commande vente pour le client.';
        }
        modify(NewSalesCrMemo)
        {
            CaptionML = ENU = 'Sales Credit Memo', FRA = 'Avoir vente';
            ToolTipML = ENU = 'Create a new sales credit memo to revert a posted sales invoice.', FRA = 'Créez un avoir vente pour annuler une facture vente validée.';
        }
        modify(NewSalesReturnOrder)
        {
            CaptionML = ENU = 'Sales Return Order', FRA = 'Retour vente';
        }
        modify(NewServiceQuote)
        {
            CaptionML = ENU = 'Service Quote', FRA = 'Devis service';
        }
        modify(NewServiceInvoice)
        {
            CaptionML = ENU = 'Service Invoice', FRA = 'Facture service';
        }
        modify(NewServiceOrder)
        {
            CaptionML = ENU = 'Service Order', FRA = 'Commande service';
        }
        modify(NewServiceCrMemo)
        {
            CaptionML = ENU = 'Service Credit Memo', FRA = 'Avoir service';
        }
        modify(NewReminder)
        {
            CaptionML = ENU = 'Reminder', FRA = 'Relance';

            //Unsupported feature: Change Description on "NewReminder(Action 1903839805)". Please convert manually.


            //Unsupported feature: Change Visible on "NewReminder(Action 1903839805)". Please convert manually.

        }
        modify(NewFinChargeMemo)
        {
            CaptionML = ENU = 'Finance Charge Memo', FRA = 'Facture d''intérêts';
        }

        modify(CustomerLedgerEntries)
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
            ToolTipML = ENU = 'View the history of transactions that have been posted for the selected record.', FRA = 'Affichez l''historique des transactions qui ont été validées pour l''enregistrement sélectionné.';
        }
        modify(PricesAndDiscounts)
        {
            CaptionML = ENU = 'Prices and Discounts', FRA = 'Prix et remises';
        }
        modify("Prices_InvoiceDiscounts")
        {
            CaptionML = ENU = 'Invoice &Discounts', FRA = 'Remises &facture';
            ToolTipML = ENU = 'Set up different discounts applied to invoices for the selected customer. An invoice discount is automatically granted to the customer when the total on a sales invoice exceeds a certain amount.', FRA = 'Configurez des remises différentes qui seront lettrées aux factures pour le client sélectionné. Une remise facture est automatiquement accordée au client lorsque le total sur la facture vente dépasse un certain montant.';
        }
        // BC Upgrade BHARDA11 >> ---- Action not found
        // modify("Prices_Prices")
        // {
        //     CaptionML = ENU = 'Prices', FRA = 'Prix';
        //     ToolTipML = ENU = 'View or set up different prices for items that you sell to the selected customer. An item price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Affichez ou paramétrez des prix différents pour les articles que vous vendez au client sélectionné. Un prix article est automatiquement affecté sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        // }
        // modify("Prices_LineDiscounts")
        // {
        //     CaptionML = ENU = 'Line Discounts', FRA = 'Remises ligne';
        //     ToolTipML = ENU = 'Set up different discounts for items that you sell to the selected customer. An item discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.', FRA = 'Paramétrez des remises différentes pour les articles que vous vendez au client sélectionné. Une remise article est automatiquement affectée sur les lignes facture lorsque les critères spécifiés sont satisfaits, par exemple le client, la quantité ou la date de fin.';
        // }
        // BC Upgrade BHARDA11 << ---- Action not found
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
        modify(Workflow)
        {
            CaptionML = ENU = 'Workflow', FRA = 'Flux de travail';

            //Unsupported feature: Change Description on "Workflow(Action 85)". Please convert manually.


            //Unsupported feature: Change Visible on "Workflow(Action 85)". Please convert manually.

        }
        modify(CreateApprovalWorkflow)
        {
            CaptionML = ENU = 'Create Approval Workflow', FRA = 'Créer flux de travail approbation';
            ToolTipML = ENU = 'Set up an approval workflow for creating or changing customers, by going through a few pages that will guide you.', FRA = 'Configurez un flux de travail approbation pour créer ou modifier des clients, en consultant quelques pages qui vous guideront.';
        }
        modify(ManageApprovalWorkflows)
        {
            CaptionML = ENU = 'Manage Approval Workflows', FRA = 'Gérer les flux de travail approbation';
            ToolTipML = ENU = 'View or edit existing approval workflows for creating or changing customers.', FRA = 'Affichez ou modifiez des flux de travail approbation existants pour créer ou modifier des clients.';

            //Unsupported feature: Change Description on "ManageApprovalWorkflows(Action 13)". Please convert manually.


            //Unsupported feature: Change Visible on "ManageApprovalWorkflows(Action 13)". Please convert manually.

        }
        modify("Cash Receipt Journal")
        {
            Promoted = true;
            PromotedCategory = Process;
            CaptionML = ENU = 'Cash Receipt Journal', FRA = 'Feuille règlement';
        }
        modify("Sales Journal")
        {
            Promoted = true;
            PromotedCategory = Process;
            CaptionML = ENU = 'Sales Journal', FRA = 'Feuille vente';
        }
        modify(Reports)
        {
            CaptionML = ENU = 'Reports', FRA = 'États';
        }
        modify(SalesReports)
        {
            CaptionML = ENU = 'Sales Reports', FRA = 'États vente';
        }
        modify(ReportCustomerTop10List)
        {
            CaptionML = ENU = 'Customer - Top 10 List', FRA = 'Clients : Palmarès';
            ToolTipML = ENU = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.', FRA = 'Affichez les clients qui achètent le plus ou qui doivent le plus d''argent au cours d''une période sélectionnée. Seuls les clients qui ont des achats pour cette période ou un solde à la fin de la période seront inclus.';
        }
        modify(ReportCustomerSalesList)
        {
            CaptionML = ENU = 'Customer - Sales List', FRA = 'Clients : Liste des ventes';
            ToolTipML = ENU = 'View customer sales in a period, for example, to report sales activity to customs and tax authorities.', FRA = 'Affichez les ventes client au cours d''une période, par exemple, pour signaler une activité vente aux autorités douanières et fiscales.';
        }
        modify(ReportSalesStatistics)
        {
            CaptionML = ENU = 'Sales Statistics', FRA = 'Statistiques vente';
            ToolTipML = ENU = 'View customers'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.', FRA = 'Affichez les coûts totaux, les ventes et la marge à long terme des clients, par exemple, pour analyser les tendances bénéficiaires. L''état affiche les montants des coûts originaux et ajustés, des ventes, de la marge, de la remise facture et de l''escompte, ainsi que le pourcentage marge sur vente au cours de trois périodes sélectionnables.';
        }
        modify(FinanceReports)
        {
            CaptionML = ENU = 'Finance Reports', FRA = 'États financiers';
        }
        modify(Statement)
        {
            CaptionML = ENU = 'Statement', FRA = 'Relevé';
            ToolTipML = ENU = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.', FRA = 'Affichez une liste des transactions d''un client pour une période sélectionnée, par exemple, à envoyer au client à la clôture d''une période comptable. Vous pouvez choisir d''afficher tous les soldes échus, sans tenir compte de la période spécifiée, ou d''inclure un cumul date.';
        }
        modify(ReportCustomerBalanceToDate)
        {
            CaptionML = ENU = 'Customer - Balance to Date', FRA = 'Clients : Écritures ouvertes';
            ToolTipML = ENU = 'View, print, or save a customer''s balance on a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.', FRA = 'Affichez, imprimez ou enregistrez un solde de client à une certaine date. Vous pouvez utiliser l''état pour extraire vos revenus de vente totaux à la clôture d''une période ou d''un exercice comptable.';
        }
        modify(ReportCustomerTrialBalance)
        {
            CaptionML = ENU = 'Customer - Trial Balance', FRA = 'Clients : Balance';
            ToolTipML = ENU = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.', FRA = 'Affichez le solde d''ouverture et final pour les clients présentant des écritures au cours d''une période spécifiée. L''état peut être utilisé pour vérifier que le solde pour un groupe comptabilisation client est égal à celui du compte général correspondant à une certaine date.';
        }
        modify(ReportCustomerDetailTrial)
        {
            CaptionML = ENU = 'Customer - Detail Trial Bal.', FRA = 'Clients : Grand livre client';
            ToolTipML = ENU = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.', FRA = 'Affichez le solde des clients présentant des soldes à une date donnée. L''état peut être utilisé à la clôture d''une période comptable, par exemple, ou pour un audit.';
        }
        modify(ReportCustomerSummaryAging)
        {
            CaptionML = ENU = 'Customer - Summary Aging', FRA = 'Clients : Échéancier';
            ToolTipML = ENU = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.', FRA = 'Affichez, imprimez ou enregistrez un résumé des totaux dus de chaque client, divisé en trois périodes. Cet état sert à décider quand émettre des relances, à évaluer la solvabilité d''un client ou à préparer des analyses de liquidités.';
        }
        modify(ReportCustomerDetailedAging)
        {
            CaptionML = ENU = 'Customer - Detailed Aging', FRA = 'Client - Écritures échues';
            ToolTipML = ENU = 'View, print, or save a detailed list of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.', FRA = 'Affichez, imprimez ou enregistrez une liste détaillée des totaux dus de chaque client, divisée en trois périodes. Cet état sert à décider quand émettre des relances, à évaluer la solvabilité d''un client ou à préparer des analyses de liquidités.';
        }
        modify(ReportAgedAccountsReceivable)
        {
            CaptionML = ENU = 'Aged Accounts Receivable', FRA = 'Comptabilité client âgée';
            ToolTipML = ENU = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.', FRA = 'Affichez un aperçu des dates d''échéance des paiements dus au client, divisé en quatre périodes. Vous devez spécifier la date à partir de laquelle vous souhaitez que le cumul soit calculé et la durée de la période pour laquelle chaque colonne contiendra des données.';
        }
        modify(ReportCustomerPaymentReceipt)
        {
            CaptionML = ENU = 'Customer - Payment Receipt', FRA = 'Reçu paiement client';
            ToolTipML = ENU = 'View a document showing which customer ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the customer.', FRA = 'Affichez un document présentant les écritures comptables client avec lesquelles un paiement a été lettré. Cet état peut être utilisé comme reçu de paiement à envoyer au client.';
        }
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Customer List")
        {
            CaptionML = ENU = 'Customer List', FRA = 'Liste des clients';
        }
        modify("Customer Register")
        {
            CaptionML = ENU = 'Customer Register', FRA = 'Historique des transactions client';
        }
        modify("Customer - Top 10 List")
        {
            CaptionML = ENU = 'Customer - Top 10 List', FRA = 'Clients : Palmarès';
        }
        modify(Sales)
        {
            CaptionML = ENU = 'Sales', FRA = 'Ventes';
        }
        modify("Customer - Order Summary")
        {
            CaptionML = ENU = 'Customer - Order Summary', FRA = 'Clients : Liste des commandes';
        }
        modify("Customer - Order Detail")
        {
            CaptionML = ENU = 'Customer - Order Detail', FRA = 'Clients : Détail des commandes';
        }
        modify("Customer - Sales List")
        {
            CaptionML = ENU = 'Customer - Sales List', FRA = 'Clients : Liste des ventes';
        }
        modify("Sales Statistics")
        {
            CaptionML = ENU = 'Sales Statistics', FRA = 'Statistiques vente';
        }
        modify("Customer/Item Sales")
        {
            CaptionML = ENU = 'Customer/Item Sales', FRA = 'Ventes d''articles par client';
        }
        // BC Upgrade BHARDA11 >> ----Actions Not found
        // modify(Finance)
        // {
        //     CaptionML = ENU = 'Finance', FRA = 'Finance';
        // }
        // modify("Customer - Detail Trial Bal.")
        // {
        //     CaptionML = ENU = 'Customer - Detail Trial Bal.', FRA = 'Clients : Grand livre client';
        // }
        // modify("Customer - Summary Aging")
        // {
        //     CaptionML = ENU = 'Customer - Summary Aging', FRA = 'Clients : Échéancier';
        // }
        // modify("Customer Detailed Aging")
        // {
        //     CaptionML = ENU = 'Customer Detailed Aging', FRA = 'Écritures client ouvertes';
        // }
        // BC Upgrade BHARDA11 << ----Actions Not found
        modify(Reminder)
        {
            CaptionML = ENU = 'Reminder', FRA = 'Relance';
        }
        // BC Upgrade BHARDA11 >> ----Actions Not found
        // modify("Aged Accounts Receivable")
        // {
        //     CaptionML = ENU = 'Aged Accounts Receivable', FRA = 'Comptabilité client âgée';
        // }
        // modify("Customer - Balance to Date")
        // {
        //     CaptionML = ENU = 'Customer - Balance to Date', FRA = 'Clients : Écritures ouvertes';
        // }
        // modify("Customer - Trial Balance")
        // {
        //     CaptionML = ENU = 'Customer - Trial Balance', FRA = 'Clients : Balance';
        // }
        // modify("Customer - Payment Receipt")
        // {
        //     CaptionML = ENU = 'Customer - Payment Receipt', FRA = 'Reçu paiement client';
        // }
        // BC Upgrade BHARDA11 << ----Actions Not found
        addfirst("&Customer")
        {
            group(BTPlant)
            {
                CaptionML = ENU = '&Plant',
                            FRA = '&Usine';
                Visible = BTPlantVisible;
                action(Dimensions1)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(18),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions1 action.';
                }
                action("Bank Accounts1")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Bank Accounts',
                                FRA = 'Comptes bancaires';
                    Image = BankAccount;
                    RunObject = Page "Customer Bank Account List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'Executes the Bank Accounts1 action.';
                }
                action("Ship-&to Addresses")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Ship-&to Addresses',
                                FRA = '&Adresses destinataire';
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'Executes the Ship-&to Addresses action.';
                }
                action("C&ontact1")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'C&ontact',
                                FRA = 'C&ontact';
                    ToolTip = 'Executes the C&ontact1 action.';

                    trigger OnAction();
                    begin
                        REc.ShowContact();
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Action
                // action("Customized Calendar")
                // {
                //     CaptionML = ENU = 'Customized Calendar',
                //                 FRA = 'Calendrier personnalisé';
                //     Description = 'DITW15.00.00.39 DDR 22/04/2011 #1230';
                //     Ellipsis = true;

                //     trigger OnAction();
                //     begin
                //         // <<DITW15.00.00.39 DDR 22/04/2011 #1230
                //         CurrPage.SAVERECORD;
                //         Rec.TESTFIELD("Base Calendar Code");
                //         CalendarMgmt.ShowCustomizedCalendar(CustomizedCalEntry."Source Type"::Customer, "No.", '', "Base Calendar Code");
                //     end;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Action

                action("Co&mments ")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Ctrl+B';
                    ToolTip = 'Executes the Co&mments  action.';
                }
                separator(Separator1100710125)
                {
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Pages ( "Service Contract List PM","Cust. Serv. Contract Lines PM","Service Items List PM")
                // action("&Plant Maintenances")
                // {
                //     CaptionML = ENU = '&Plant Maintenances',
                //                 FRA = '&Maintenance Usine';
                //     RunObject = Page "Service Contract List PM";
                //     RunPageLink = "Customer No." = FIELD("No.");
                //     RunPageView = SORTING("Customer No.", "Ship-to Code");
                // }
                // action("Plant Maintenance Lines")
                // {
                //     CaptionML = ENU = 'Plant Maintenance Lines',
                //                 FRA = 'Lignes maintenance usine';
                //     RunObject = Page "Cust. Serv. Contract Lines PM";
                //     RunPageLink = "Customer No." = FIELD("No.");
                //     RunPageView = SORTING("Customer No.", "Ship-to Code");
                // }
                // action("Equ&ipments")
                // {
                //     CaptionML = ENU = 'Equ&ipments',
                //                 FRA = 'Equ&ipements';
                //     RunObject = Page "Service Items List PM";
                //     RunPageLink = "Customer No." = FIELD("No.");
                //     RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Pages ( "Service Contract List PM","Cust. Serv. Contract Lines PM","Service Items List PM")
                separator(Separator1100710121)
                {
                }
                action("Online Map")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Online Map',
                                FRA = 'Online Map';
                    ToolTip = 'Executes the Online Map action.';

                    trigger OnAction()
                    begin
                        Rec.DisplayMap();
                    end;
                }
            }
            group(BTCust)
            {
                CaptionML = ENU = '&Customer',
                            FRA = '&Client';
                Image = Customer;
                Visible = BTCustVisible;
            }
        }
        addfirst("&Customer")
        {
            action("Handling Time & Trucks")
            {
                Caption = 'Handling Time & Trucks';
                ApplicationArea = All; // BC Upgrade BHARDA11 <<
                Image = Timeline;
                RunObject = Page "CustHandlingTimeTruck CBN";
                RunPageLink = "Customer No." = FIELD("No.");
                ToolTip = 'Executes the Handling Time & Trucks action.';
            }
        }
        addafter("C&ontact")
        {
            action(Action1100710111)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Co&mments',
                            FRA = 'Co&mmentaires';
                Image = ViewComments;
                RunObject = Page "Comment Sheet";
                RunPageLink = "Table Name" = CONST(Customer),
                              "No." = FIELD("No.");
                ToolTip = 'Executes the Action1100710111 action.';
            }
        }
        addafter(OnlineMap)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT 
            // action(Action1100710113)
            // {
            //     CaptionML = ENU = 'Customized Calendar',
            //                 FRA = 'Calendrier personnalisé';
            //     Description = 'DITW15.00.00.39 DDR 22/04/2011 #1230';
            //     Ellipsis = true;
            //     Image = CalendarChanged;

            //     trigger OnAction();
            //     begin
            //         // <<DITW15.00.00.39 DDR 22/04/2011 #1230
            //         CurrPage.SAVERECORD;
            //         TESTFIELD("Base Calendar Code");
            //         CalendarMgmt.ShowCustomizedCalendar(CustomizedCalEntry."Source Type"::Customer, "No.", '', "Base Calendar Code");
            //     end;
            // }
            // BC Upgrade BHARDA11 >> ----Drink-IT Page ("Cust.- resp. center relations")
            // action("Cust.- resp. center relation")
            // {
            //     CaptionML = ENU = 'Responsibility Center Relations',
            //                 FRA = 'Relations centre de gestion client';
            //     Description = 'DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214';
            //     Image = Responsibility;
            //     RunObject = Page "Cust.- resp. center relations";
            //     RunPageLink = "Customer No." = FIELD("No.");
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Page ("Cust.- resp. center relations")
            group("Relation Groups")
            {
                CaptionML = ENU = 'Relation Groups',
                            FRA = 'Groupes de relations';
                Image = Relationship;
                // BC Upgrade BHARDA11 >> ----Drink-IT Pages
                // action("Tax Groups")
                // {
                //     CaptionML = ENU = 'Tax Groups',
                //                 FRA = 'Groupes taxes';
                //     Image = Relationship;
                //     RunObject = Page "Drink Customer Tax Groups";
                //     RunPageLink = "Source Type" = CONST(Customer);
                //     RunPageView = WHERE("Source Type" = CONST(Customer));
                // }
                // action("Exception Tax Groups")
                // {
                //     CaptionML = ENU = 'Exception Tax Groups',
                //                 FRA = 'Groupes taxe excéption';
                //     Image = Relationship;
                //     RunObject = Page "Customer Exception Tax Groups";
                // }
                // action("Deposit Groups")
                // {
                //     CaptionML = ENU = 'Deposit Groups',
                //                 FRA = 'Groupes consignes';
                //     Image = Relationship;
                //     RunObject = Page "Drink Deposit Groups";
                //     RunPageLink = "Source Type" = CONST(Customer);
                //     RunPageView = WHERE("Source Type" = CONST(Customer));
                // }
                // action("Discount &Groups (Drink-It)")
                // {
                //     CaptionML = ENU = 'Discount &Groups (Drink-It)',
                //                 FRA = 'Groupes &Remise (Drink-It)';
                //     Image = Relationship;
                //     RunObject = Page "Relation Drink Discount Groups";
                //     RunPageLink = "Source Type" = CONST(Customer),
                //                   "Source No." = FIELD("No.");
                // }
                // action("Promotion Grou&ps")
                // {
                //     CaptionML = ENU = 'Promotion Grou&ps',
                //                 FRA = 'Grou&pes Promotion';
                //     Image = Relationship;
                //     RunObject = Page "Relation Promotion Groups";
                //     RunPageLink = "Source Type" = CONST(Customer),
                //                   "Source No." = FIELD("No.");
                // }
                // action("&Exclusivity Groups")
                // {
                //     CaptionML = ENU = '&Exclusivity Groups',
                //                 FRA = 'Groupes &Exculisivité';
                //     Image = Relationship;
                //     RunObject = Page "Relation Exclusivity Groups";
                //     RunPageLink = "Source Type" = CONST(Customer),
                //                   "Source No." = FIELD("No.");
                // }
                // action("Loyalty Groups")
                // {
                //     CaptionML = ENU = 'Loyalty Groups',
                //                 FRA = 'Groupes Fidélité';
                //     Description = 'DIT715 #243';
                //     Image = Relationship;
                //     RunObject = Page "Relation Loyalty Groups";
                //     RunPageLink = "Source Type" = CONST(Customer),
                //                   "Source No." = FIELD("No.");
                // }
                // action("&Quota Groups")
                // {
                //     CaptionML = ENU = '&Quota Groups',
                //                 FRA = 'Groupes &Devis';
                //     Image = Relationship;
                //     RunObject = Page "Relation Quota Groups";
                //     RunPageLink = "Source Type" = CONST(Customer),
                //                   "Source No." = FIELD("No.");
                // }
                // action("Delivery Time")
                // {
                //     CaptionML = ENU = 'Delivery Time',
                //                 FRA = 'Heure de Livraison';
                //     Image = Relationship;
                //     RunObject = Page "Delivery Times";
                //     RunPageLink = "No." = FIELD("No.");
                //     RunPageView = SORTING("No.", "Address Code")
                //                   WHERE("Source Type" = CONST(Customer));
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Pages
            }
            // BC Upgrade BHARDA11 >> ----Drik-IT Page
            // action(Properties)
            // {
            //     CaptionML = ENU = 'Properties',
            //                 FRA = 'Propriétés';
            //     Description = 'FINXL9.00';
            //     Image = Process;
            //     RunObject = Page "Master Data Properties";
            //     RunPageLink = "Table ID" = CONST(18),
            //                   Code = FIELD("No.");
            // }
            // BC Upgrade BHARDA11 << ----Drik-IT Page

        }
        addafter(CustomerLedgerEntries)
        {
            // BC Upgrade BHARDA11 >> ----Drink-IT Page
            // action("Telesales Overview (Entries)")
            // {
            //     CaptionML = ENU = 'Telesales Overview (Entries)',
            //                 FRA = 'Détails televente (Ecritures)';
            //     Image = Entries;
            //     RunObject = Page "Telesales Entries";
            //     RunPageLink = "Customer No." = FIELD("No."),
            //                   "Calling Date" = FIELD("Date Filter"),
            //                   "Ship-to Code" = FIELD("Ship-to Filter"),
            //                   "Call Status" = FIELD("Call Status Filter"),
            //                   Closed = FIELD("Call Closed Filter");
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Page

            // group(Statistics)
            // {
            //     CaptionML = ENU = 'Statistics',
            //                 FRA = 'Statistiques';
            //     Image = Statistics;
            // }
        }
        // BC Upgrade BHARDA11 >> Drink-IT Customize
        // addfirst("Statistics by C&urrencies")
        // {
        //     action("Loyalty Statistics")
        //     {
        //         CaptionML = ENU = 'Loyalty Statistics',
        //                     FRA = 'Statistiques fidélités';
        //         Description = 'DIT715 #243';
        //         Image = Statistics;
        //         RunObject = Page "Customer Loyalty by Item";
        //         RunPageLink = "No." = FIELD("No.");
        //     }
        //     group("Tracking Entries")
        //     {
        //         CaptionML = ENU = 'Tracking Entries',
        //                     FRA = 'Ecritures traçablité';
        //         Image = ItemTrackingLedger;
        //         action("Empty Goods Trac&king")
        //         {
        //             CaptionML = ENU = 'Empty Goods Trac&king',
        //                         FRA = 'Traçabilité article vidange';
        //             Description = 'DITW18.00.06 GVC 19/05/2015  DIT-770  #1335';
        //             Image = ItemTrackingLines;
        //             Promoted = false;
        //             //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //             //PromotedCategory = "Report";
        //             RunObject = Page "Empty Goods Tracking Overview";
        //             RunPageLink = "Source Type Filter" = CONST(Customer),
        //                           "Source No. Filter" = FIELD("No."),
        //                           "Date Filter" = FIELD("Date Filter"),
        //                           "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
        //                           "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter");
        //         }
        //     }
        // }
        // BC Upgrade BHARDA11 << Drink-IT Customize

        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // addfirst("Item &Tracking Entries")
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
        //             SSCCTrackingMgt.CallSSCCTrackingEntryForm(1, "No.", '', '', '', '', '', 0);
        //         end;
        //     }
        //     separator(Separator1100710083)
        //     {
        //     }
        // }

        // addafter("Sales_LineDiscounts")
        // {
        //     action("D&iscount Charges")
        //     {
        //         CaptionML = ENU = 'D&iscount Charges',
        //                     FRA = 'Frais de remise';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = TaxSetup;
        //         RunObject = Page "Sales Discount Item Charges";
        //         RunPageLink = "Sales Type" = CONST(Customer),
        //                       "Sales Code" = FIELD("No.");
        //     }
        //     action("Promotio&n Charges")
        //     {
        //         CaptionML = ENU = 'Promotio&n Charges',
        //                     FRA = 'Frais de promotion';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = TaxSetup;
        //         RunObject = Page "Sales Promotion Item Charges";
        //         RunPageLink = "Sales Type" = CONST(Customer),
        //                       "Sales Code" = FIELD("No.");
        //     }
        //     group("Drink-It Charges")
        //     {
        //         CaptionML = ENU = 'Drink-It Charges',
        //                     FRA = 'Frais Drink-IT';
        //         Image = TaxSetup;
        //         action("Ta&x Charges")
        //         {
        //             CaptionML = ENU = 'Ta&x Charges',
        //                         FRA = 'Taxe d''impôt';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Tax Item Charges";
        //             RunPageLink = "Sales Type" = CONST(Customer),
        //                           "Sales Code" = FIELD("No.");
        //         }
        //         action(Action1100710075)
        //         {
        //             CaptionML = ENU = 'Exception Tax Groups',
        //                         FRA = 'Groupes taxe excéption';
        //             Image = TaxSetup;
        //             RunObject = Page "Customer Exception Tax Groups";
        //             RunPageLink = "Exception DTax Group Code" = FIELD("Customer DTax Group Code");
        //         }
        //         action("D&eposit Charges")
        //         {
        //             CaptionML = ENU = 'D&eposit Charges',
        //                         FRA = 'Friais de dépôt';
        //             Description = 'DITW15.00.00.01';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Deposit Item Charges";
        //             RunPageLink = "Sales Type" = CONST(Customer),
        //                           "Sales Code" = FIELD("No.");
        //         }
        //         action(Action1100710073)
        //         {
        //             CaptionML = ENU = 'D&iscount Charges',
        //                         FRA = 'Frais de remise';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Discount Item Charges";
        //             RunPageLink = "Sales Type" = CONST(Customer),
        //                           "Sales Code" = FIELD("No.");
        //         }
        //         action(Action1100710072)
        //         {
        //             CaptionML = ENU = 'Promotio&n Charges',
        //                         FRA = 'Frais de promotion';
        //             Image = TaxSetup;
        //             RunObject = Page "Sales Promotion Item Charges";
        //             RunPageLink = "Sales Type" = CONST(Customer),
        //                           "Sales Code" = FIELD("No.");
        //         }
        //     }
        // }

        // addafter("S&td. Cust. Sales Codes")
        // {
        //     group("Credit Limits")
        //     {
        //         CaptionML = ENU = 'Credit Limits',
        //                     FRA = 'Limite crédit';
        //         Image = LimitedCredit;
        //         action("Deposit Li&mits")
        //         {
        //             CaptionML = ENU = 'Deposit Li&mits',
        //                         FRA = 'Limite dépôt';
        //             Image = LimitedCredit;
        //             RunObject = Page "Sales Deposit Limits";
        //             RunPageLink = "Sales Type" = CONST(Customer),
        //                           "Sales Code" = FIELD("No.");
        //             RunPageView = SORTING("Sales Type", "Sales Code");
        //         }
        //         action("Additional Credit Limits")
        //         {
        //             CaptionML = ENU = 'Additional Credit Limits',
        //                         FRA = 'Limites crédit complémentaires';
        //             Image = LimitedCredit;
        //             RunObject = Page "Additional Credit Limits";
        //             RunPageLink = "Customer No." = FIELD("No.");
        //         }
        //     }
        //     group(Others)
        //     {
        //         CaptionML = ENU = 'Others',
        //                     FRA = 'Autres';
        //         Image = Item;
        //         action("Items &Exclusivity")
        //         {
        //             CaptionML = ENU = 'Items &Exclusivity',
        //                         FRA = 'Articles &Exclusivité';
        //             Image = Item;
        //             RunObject = Page "Sales Items Exclusivity";
        //             RunPageLink = "Sales Type" = CONST(Customer),
        //                           "Sales Code" = FIELD("No.");
        //         }
        //         action("Items Loyalty")
        //         {
        //             CaptionML = ENU = 'Items Loyalty',
        //                         FRA = 'Articles fidelité';
        //             Description = 'DIT715 #243';
        //             Image = Item;
        //             RunObject = Page "Sales Loyalty Points & Amounts";
        //             RunPageLink = "Sales Type" = CONST(Customer),
        //                           "Sales Code" = FIELD("No.");
        //         }
        //         action("Items &Quota")
        //         {
        //             CaptionML = ENU = 'Items &Quota',
        //                         FRA = 'Articles &Quota';
        //             Image = Item;
        //             RunObject = Page "Sales Items Quota";
        //             RunPageLink = "Sales Type" = CONST(Customer),
        //                           "Sales Code" = FIELD("No.");
        //         }
        //         action("Delayed Promotions")
        //         {
        //             CaptionML = ENU = 'Delayed Promotions',
        //                         FRA = 'Promotions retardé';
        //             RunObject = Page "Delayed Disc.& Promo. Worksht.";
        //             RunPageLink = "Entry Type" = FILTER(Promotion),
        //                           "Status Customer No." = FIELD("No.");
        //         }
        //         action("Quality Standards")
        //         {
        //             CaptionML = ENU = 'Quality Standards',
        //                         FRA = 'Standards de qualité';
        //             Image = TaskQualityMeasure;
        //             //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //             //PromotedCategory = Process;
        //             RunObject = Page "Sales Standards";
        //             RunPageLink = "Sales Type" = CONST(Customer),
        //                           "Sales Code" = FIELD("No.");
        //             RunPageView = SORTING("Sales Type", "Sales Code", "Item No.", "Starting Date", "Variant Code", "Qlty. Measure Code");
        //         }
        //     }
        //     separator(Separator1100710059)
        //     {
        //     }
        // }
        // addafter("Return Orders")
        // {
        //     action("Invoice List")
        //     {
        //         CaptionML = ENU = 'Invoice List',
        //                     FRA = 'Liste des factures';
        //         Description = 'DITW17.10.05  DIT-770 #761';
        //         Image = List;
        //         Promoted = true;
        //         PromotedCategory = Category7;
        //         RunObject = Page "Invoice List";
        //         RunPageLink = "Customer No." = FIELD("No.");
        //     }
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
        addafter("Blanket Orders")
        {
            action("&Jobs")
            {
                ApplicationArea = All;
                CaptionML = ENU = '&Jobs',
                            FRA = '&Projets';
                Image = Job;
                RunObject = Page "Job List";
                RunPageLink = "Bill-to Customer No." = FIELD("No.");
                RunPageView = SORTING("Bill-to Customer No.");
                ToolTip = 'Executes the &Jobs action.';
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Action
            // action("<Action1100066010>")
            // {
            //     CaptionML = ENU = 'Fixed Asset List',
            //                 FRA = 'Liste des immobilisations';
            //     Image = FixedAssets;

            //     trigger OnAction();
            //     begin
            //         //<< DITW17.00.02 SR 06/09/2013 DIT-770 #134
            //         // fctShowDITContractFAList;  // BC Upgrade BHARDA11 ----Drink-IT Function
            //         //>>DITW17.00.02 SR DIT-770 #134
            //     end;
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Action

            group("Change Log")
            {
                CaptionML = ENU = 'Change Log',
                            FRA = 'Journal Modification';
                Image = Log;
                // BC Upgrade BHARDA11 >> ----Drink-IT Customize 
                // group("Change Log Entries")
                // {
                //     CaptionML = ENU = 'Change Log Entries',
                //                 FRA = 'Journal Modification';
                //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
                //     Image = Log;
                //     action("<Action1000000002>")
                //     {
                //         CaptionML = ENU = 'by Customer',
                //                     FRA = 'Client';
                //         RunObject = Page "Change Log Entries";
                //         RunPageLink = "Table No." = FILTER(18),
                //                       "Primary Key Field 1 Value" = FIELD("No.");
                //     }
                //     action("by Default dimension")
                //     {
                //         CaptionML = ENU = 'by Default dimension',
                //                     FRA = 'Affectation analytique';
                //         RunObject = Page "Change Log Entries";
                //         RunPageLink = "Table No." = FILTER(352),
                //                       "Primary Key Field 1 Value" = FILTER(18),
                //                       "Primary Key Field 2 Value" = FIELD("No.");
                //     }
                //     action("by Bank Account")
                //     {
                //         CaptionML = ENU = 'by Bank Account',
                //                     FRA = 'Compte bancaire client';
                //         RunObject = Page "Change Log Entries";
                //         RunPageLink = "Table No." = FILTER(287),
                //                       "Primary Key Field 1 Value" = FIELD("No.");
                //     }
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customize 

            }
        }
        // addfirst(Service)
        // {
        //     group(ActionGroup1100710037)
        //     {
        //         CaptionML = ENU = 'Service',
        //                     FRA = 'Service';
        //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
        //         Image = ServiceItem;
        //     }
        // }
        // BC Upgrade BHARDA11 >> ----Drink-IT Pages
        // addfirst("Service &Items")
        // {
        //     action("Service Contract Lines")
        //     {
        //         CaptionML = ENU = 'Service Contract Lines',
        //                     FRA = 'Lignes contrat de service';
        //         Image = ServiceLedger;
        //         RunObject = Page "Cust. Service Contract Lines";
        //         RunPageLink = "Customer No." = FIELD("No.");
        //         RunPageView = SORTING("Customer No.", "Ship-to Code");
        //     }
        //     action(Buildings)
        //     {
        //         CaptionML = ENU = 'Buildings',
        //                     FRA = 'Immeubles';
        //         Image = Zones;
        //         Promoted = true;
        //         PromotedCategory = Category7;
        //         RunObject = Page "Relation Buildings";
        //         RunPageLink = "Customer No." = FIELD("No.");
        //     }
        //     action("Blanket Financial Contracts")
        //     {
        //         CaptionML = ENU = 'Blanket Financial Contracts',
        //                     FRA = 'Contrats financier ouverts';
        //         Image = ServiceAgreement;
        //         RunObject = Page "Blanket Contract List";
        //         RunPageLink = "Contract Type" = CONST(Blanket),
        //                       "Customer No." = FIELD("No.");
        //     }
        //     action("Financial Contracts")
        //     {
        //         CaptionML = ENU = 'Financial Contracts',
        //                     FRA = 'Contrats financiers';
        //         Image = ServiceAgreement;
        //         RunObject = Page "Financial Contract List";
        //         RunPageLink = "Contract Type" = CONST(Contract),
        //                       "Customer No." = FIELD("No.");
        //     }
        //     action("Financial Contracts (Customer Volume)")
        //     {
        //         CaptionML = ENU = 'Financial Contracts (Customer Volume)',
        //                     FRA = 'Contrat financier (Volume client)';
        //         RunObject = Page "Financial Contract List";
        //         RunPageLink = "Contract Type" = CONST(Contract),
        //                       "Volume Customer No." = FIELD("No.");
        //     }
        // }
        // BC Upgrade BHARDA11 << ----Drink-IT Pages

        addafter("Sales Journal")
        {
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                Image = "Action";
                action("Apply Template")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Apply Template',
                                FRA = 'Appliquer modèle';
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Apply Template action.';

                    trigger OnAction();
                    var
                        ConfigTemplateMgt: Codeunit "Config. Template Management";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        ConfigTemplateMgt.UpdateFromTemplateSelection(RecRef);
                    end;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Customize
                // group(Telesales)
                // {
                //     CaptionML = ENU = 'Telesales',
                //                 FRA = 'Télévente';
                //     Image = Calls;
                //     action("Telesales Call Update")
                //     {
                //         CaptionML = ENU = 'Telesales Call Update',
                //                     FRA = 'Mettre à jour appels Télévente';
                //         Image = ExecuteBatch;

                //         trigger OnAction();
                //         var
                //             ReCustomer: Record Customer;
                //             RepTelesalesCallUpdate: Report "Telesales Call Update";
                //         begin
                //             //DITW17.00.02 SR 10/10/2013 DIT-770 #205
                //             RepTelesalesCallUpdate.GetCustFilter("No.", "Ship-to Code");
                //             RepTelesalesCallUpdate.RUNMODAL;
                //             CurrPage.UPDATE(false);
                //             //>>DITW17.00.02 SR DIT-770 #205
                //         end;
                //     }
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customize

            }
        }
        addafter(ReportCustomerDetailTrial)
        {
            action("Customer Detail Trial Balance FR")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Customer Detail Trial Balance FR',
                            FRA = 'Grand livre clients FR';
                Image = "Report";
                RunObject = Report "Cust Detail Trial Bal LR CBN";
                ToolTip = 'Executes the Customer Detail Trial Balance FR action.';
                // Report 50314                ToolTip = 'Executes the Customer Detail Trial Balance FR action.';

            }
        }
        addafter(ReportCustomerTrialBalance)
        {
            action("Customer Trial Balance FR")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Customer Trial Balance FR',
                            FRA = 'Balance clients FR';
                Image = "Report";
                RunObject = Report "Customer Trial Bal LR CBN";
                ToolTip = 'Executes the Customer Trial Balance FR action.';
                // REport 50315                ToolTip = 'Executes the Customer Trial Balance FR action.';

            }
        }
        addafter(ReportCustomerPaymentReceipt)
        {
            action("<Customer Trial Balance DRC")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Customer Trial Balance - DRC',
                            FRA = 'Balance clients DRC';
                Image = "Report";
                RunObject = Report "CustomerTrialBalanceDRC CBN";
                ToolTip = 'Executes the <Customer Trial Balance DRC action.';
                // Report 50426                ToolTip = 'Executes the <Customer Trial Balance DRC action.';

            }
            action("<Cust. Detail Trial Balan DRC")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Customer Detail Trial Balance - DRC',
                            FRA = 'Grand livre clients DRC';
                Image = "Report";
                RunObject = Report "Cust.DetailTrialBal DRC CBN";
                ToolTip = 'Executes the <Cust. Detail Trial Balan DRC action.';
                // Report 50425                ToolTip = 'Executes the <Cust. Detail Trial Balan DRC action.';

            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Reports
            // group(ActionGroup1100710008)
            // {
            //     CaptionML = ENU = 'Sales',
            //                 FRA = 'Ventes';
            //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
            //     action("Empty Goods Statement")
            //     {
            //         CaptionML = ENU = 'Empty Goods Statement',
            //                     FRA = 'Relevé vidanges';
            //         Image = "Report";
            //         Promoted = false;
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = "Report";

            //         trigger OnAction();
            //         var
            //             lcduDrinkDoc: Codeunit "Drink Document-Print";
            //         begin
            //             // <<DITW15.00.00.28 DDR 02/12/2008
            //             lcduDrinkDoc.PrintEmptyGoodStatmtCust(Rec);
            //         end;
            //     }
            //     action("Loyalty Statement")
            //     {
            //         CaptionML = ENU = 'Loyalty Statement',
            //                     FRA = 'Relevé Fidélité';
            //         Image = "report";
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = "Report";

            //         trigger OnAction();
            //         var
            //             lcduDrinkDoc: Codeunit "Drink Document-Print";
            //         begin
            //             // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
            //             lcduDrinkDoc.PrintLoyaltyStatmtCust(Rec);
            //         end;
            //     }
            //     action("Sales Gross-net Price report")
            //     {
            //         CaptionML = DEU = 'VK Brutto-Netto Preise (XLS)',
            //                     ENU = 'Sales Gross-net Price report';
            //         Image = "Report";

            //         trigger OnAction();
            //         var
            //             lrptSalesGrossNetPrice: Report "Sales Gross-net Price";
            //             lrCustomer: Record Customer;
            //         begin
            //             // << DITW110.00.11 SFI 12/12/2017 BL#XXXXX
            //             CurrPage.SETSELECTIONFILTER(lrCustomer);
            //             lrptSalesGrossNetPrice.SETTABLEVIEW(lrCustomer);
            //             lrptSalesGrossNetPrice.RUN;
            //             // >> DITW110.00.11 SFI BL#XXXXX
            //         end;
            //     }
            //     action("Customer Sales Conditions (Landscape)")
            //     {
            //         CaptionML = ENU = 'Customer Sales Conditions (Landscape)',
            //                     FRA = 'Conditions ventes client (Paysage)';
            //         Description = 'DITW18.00.06 GVC 07/05/2015  DIT-770  #1335';
            //         Image = "report";
            //         Promoted = false;
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = "Report";

            //         trigger OnAction();
            //         var
            //             CustSalesCond1_lRep: Report "Cust Sales Cond Landscape";
            //             tmpCust_lRec: Record Customer;
            //         begin
            //             CurrPage.SETSELECTIONFILTER(tmpCust_lRec);
            //             CustSalesCond1_lRep.SETTABLEVIEW(tmpCust_lRec);
            //             CustSalesCond1_lRep.RUN;
            //         end;
            //     }
            //     action("Customer Sales Conditions (Portrait)")
            //     {
            //         CaptionML = ENU = 'Customer Sales Conditions (Portrait)',
            //                     FRA = 'Conditions ventes client (Portrait)';
            //         Description = 'DITW18.00.06 GVC 07/05/2015  DIT-770  #1335';
            //         Image = "report";
            //         Promoted = false;
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = "Report";

            //         trigger OnAction();
            //         var
            //             CustSalesCond_lRep: Report "Cust Sales Cond Portrait";
            //             tmpCust_lRec: Record Customer;
            //         begin
            //             CurrPage.SETSELECTIONFILTER(tmpCust_lRec);
            //             CustSalesCond_lRep.SETTABLEVIEW(tmpCust_lRec);
            //             CustSalesCond_lRep.RUN;
            //         end;
            //     }
            // }
            // BC Upgrade BHARDA11 << ----Drik-IT Reports
            // BC Upgrade BHARDA11 >> ----Drink-IT Customize  Group
            // group("Financial Management")
            // {
            //     CaptionML = ENU = 'Financial Management',
            //                 FRA = 'Gestion financière';
            //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335';
            //     action(Action1100710002)
            //     {
            //         CaptionML = ENU = 'Customer Detailed Aging',
            //                     FRA = 'Écritures clients échues';
            //         Image = "Report";
            //         Promoted = false;
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = "Report";
            //         RunObject = Report "Customer Detailed Aging";
            //     }
            //     action("Customer - Labels")
            //     {
            //         CaptionML = ENU = 'Customer - Labels',
            //                     FRA = 'Clients : Étiquettes';
            //         Image = "Report";
            //         Promoted = false;
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = "Report";
            //         RunObject = Report "Customer - Labels";
            //     }
            //     action(Action1100710000)
            //     {
            //         CaptionML = ENU = 'Customer - Balance to Date',
            //                     FRA = 'Clients : Écritures ouvertes';
            //         Image = "Report";
            //         Promoted = false;
            //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedCategory = "Report";
            //         RunObject = Report "Customer - Balance to Date";
            //     }
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Customize  Group
        }
        // moveafter("Cross Re&ferences"; ApprovalEntries)
        // moveafter(ActionGroup24; "Sales_Prices")
        moveafter(NewSalesQuote; NewSalesOrder)
    }

    var
        Text2014310_0: TextConst ENU = 'Plant List', FRA = 'Liste usine';
        RunModeCaptionPM: Boolean;
        BTCustVisible: Boolean;
        BTPlantVisible: Boolean;
        CalendarMgmt: Codeunit "Calendar Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;

    SetWorkflowManagementEnabledState;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297
    RunModeCaptionPM := SetCaptionClassPM();
    if RunModeCaptionPM then begin
      CurrPage.CAPTION := Text2014310_0;
    end;
    FILTERGROUP(0);
    BTCustVisible := not RunModeCaptionPM;
    BTPlantVisible := RunModeCaptionPM;
    // >>DITW16.00.00.41 DDR DIT-715 #297

    #1..3
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

