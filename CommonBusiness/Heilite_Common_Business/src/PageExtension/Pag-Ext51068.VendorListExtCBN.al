pageextension 51068 VendorListExtCBN extends "Vendor List"
{
    // DITW15.00.00.01 DDR 26/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 09/01/2008 Remove key sorting for Tax/Depoist Item charges menu
    // DITW15.00.00.01 DDR 21/01/2008 Added Drink-it Disc.& Promotion functionalities
    //                                added menu into Vendor, Sales & Purchases
    // DITW15.00.00.01 DDR 05/02/2008 Change captions menu (Drink-it)
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.21 DDR 27/06/2008 Added menu "Shipping Agents" into Vendor button
    // DITW15.00.00.32 DDR 03/04/2009 Correct Captions (menu 'Deposit Charges' into Purchase button)
    // DITW15.00.00.35 DDR 09/09/2009 Added columns
    //                                  "Contract Vend. Posting Group"
    //                     23/09/2009 issue 814 Added columns (all fields) contract cust. posting groups (non-visible)
    // DITW15.00.00.38 DDR 19/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Entries' into 'Purchase' menu button
    // DITW16.00.00.38 DDR 04/03/2011 DIT-715 #65 RTC Upgrade & Performances
    //                                  Added menu (button) to synchronize with the card
    //                                    Vendor\Empty Goods Tracking
    //                                    Vendor\Service contracts
    //                                    Vendor\Service contract lines
    //                                    Vendor\Service items
    //                                    Vendor\Quality tests
    //                     29/08/2011 issue 1396 Added fields "No. of Exclusivity Groups" into 'Drink-it' tab
    //                                           Added 'Exclusivity Groups' menu into 'Vendor' button
    //                                           Added 'Item Exclusivity' menu into 'Purchases' button

    // FINXL7.00.001 RBE 20/03/2013 : Added fields Address,"Address 2","VAT Registration No.","Balance (LCY)" and
    //                                "Net Change (LCY)" on page
    // FINXL8.00.001 DAT 20/08/2015 : Modified actions "Purchase Quote", "Purchase Invoice", "Purchase Order" and "Purchase Credit Memo"

    // DITW17.00.02 DDR 09/08/2013 DIT-770 #102 Added 'Tax Groups' Action into 'Relation' button
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal
    //                                          Added menu to "Vendor Exception Tax Groups"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 look & feel design/functional issues: part 1: ribbons
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Vendor"
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 Add Action Page Link to page "Delivery Times"
    // DITW19.00.07 MSF 04/07/2016 DIT-770 #1965  Item and Item list/ customer and Customer List - navigate ribbon
    //                                            Check And fix  Ribbon

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // FINXL9.00.001 ACH 11/08/2016 : Update action "Purchase Order"
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // FINXL9.00.001 ACH 29/09/2016 : Update actions
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.11 SFI 12/12/2017 NRQ#10509 Sales and purchase gross net prices

    // HEI.01 FDD–PURGAP05 IBM LAZARE02 03.10.2017
    //   # Added fields: Global vendor ID, Vendor type, Industry Key, Name 2, Name 3, Name 4, Global Delete
    // HEI.02 FDD-HT520 IBM.GUNERE01 26.08.2019
    //   # Added Report Vendor Trial Balance FR, Report Vendor Det Trial Balance FR to Financial Management section
    // HEI.03 CHG2056550 FDD-HT1134 IBM.PANDES01 16.04.2020
    //   # Added Field Blocked Reason Code.
    // HEI.04 FDD-HT1146 IBM SURYAS01 20/04/2020
    //     in Page Actions
    // HEI.05 FDD-HB2482 CHG2123206 IBM NANDIS01 03.11.2021 - Improvement of multiple HeiLite reports for StP  Procurement users
    //   # Added Email and Email2 fields in the page
    // HEI.06 CHG2162715 HB3020 NORRIQ KOROLA04 14.11.2022
    //   # SPL Code - button added

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.', FRA = 'Spécifie le numéro du fournisseur. Le champ est renseigné automatiquement à partir d''une souche de numéros définie, ou vous saisissez manuellement le numéro car vous avez activé la saisie manuelle de numéro dans le paramétrage de la souche de numéros.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the vendor''s name. You can enter a maximum of 30 characters, both numbers and letters.', FRA = 'Spécifie le nom du fournisseur. Vous pouvez entrer au maximum 30 caractères, des chiffres et des lettres.';
        }
        modify("Responsibility Center")
        {
            ToolTipML = ENU = 'Specifies the code for the responsibility center that will administer this vendor by default.', FRA = 'Spécifie le code du centre de gestion qui gère ce fournisseur par défaut.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the warehouse location where items from the vendor must be received by default.', FRA = 'Spécifie l''entrepôt où les articles du fournisseur doivent être reçus par défaut.';
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
            ToolTipML = ENU = 'Specifies the vendor''s telephone number.', FRA = 'Spécifie le numéro de téléphone du fournisseur.';
        }
        modify("Fax No.")
        {
            ToolTipML = ENU = 'Specifies the vendor''s fax number.', FRA = 'Spécifie le numéro de télécopie du fournisseur.';
        }
        modify("IC Partner Code")
        {
            ToolTipML = ENU = 'Specifies the vendor''s IC partner code, if the vendor is one of your intercompany partners.', FRA = 'Spécifie le code de partenaire IC du fournisseur si ce dernier est l''un de vos partenaires intersociétés.';
        }
        modify(Contact)
        {
            ToolTipML = ENU = 'Specifies the name of the person you regularly contact when you do business with this vendor.', FRA = 'Spécifie le nom de la personne que vous contactez régulièrement lorsque vous traitez avec ce fournisseur.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies a code to specify the purchaser who normally handles this vendor''s account.', FRA = 'Spécifie un code pour préciser l''acheteur qui s''occupe habituellement du compte de ce fournisseur.';
        }
        modify("Vendor Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s market type to link business transactions made for the vendor with the appropriate account in the general ledger.', FRA = 'Spécifie le type de marché du fournisseur pour lier les transactions commerciales effectuées pour le fournisseur au compte approprié dans la comptabilité.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s trade type to link transactions made for this vendor with the appropriate general ledger account according to the general posting setup.', FRA = 'Spécifie le type commercial du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de validation généraux.';
        }
        modify("VAT Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the vendor''s VAT specification to link transactions made for this vendor with the appropriate general ledger account according to the VAT posting setup.', FRA = 'Spécifie le détail TVA du fournisseur pour lier les transactions effectuées pour ce fournisseur au compte général approprié en fonction des paramètres de comptabilisation TVA.';
        }
        modify("Payment Terms Code")
        {
            ToolTipML = ENU = 'Specifies a code that indicates the payment terms that the vendor usually requires.', FRA = 'Spécifie un code qui indique les conditions de paiement que le fournisseur exige habituellement.';
        }
        modify("Fin. Charge Terms Code")
        {
            ToolTipML = ENU = 'Specifies how the vendor calculates finance charges.', FRA = 'Spécifie la manière dont le fournisseur calcule les intérêts de retard.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the currency code that is inserted by default when you create purchase documents or journal lines for the vendor.', FRA = 'Spécifie le code devise qui est inséré par défaut lorsque vous créez des documents achat ou des lignes feuille pour le fournisseur.';
        }
        modify("Language Code")
        {
            ToolTipML = ENU = 'Specifies the language on printouts for this vendor.', FRA = 'Indique la langue des documents imprimés pour ce fournisseur.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies a search name.', FRA = 'Spécifie un nom de recherche.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies which transactions with the vendor that cannot be posted.', FRA = 'Spécifie les transactions avec le fournisseur qui ne peuvent pas être validées.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the vendor card was last modified.', FRA = 'Spécifie la date à laquelle la fiche fournisseur a été modifiée pour la dernière fois.';
        }
        modify("Application Method")
        {
            ToolTipML = ENU = 'Specifies how to apply payments to entries for this vendor.', FRA = 'Spécifie la manière de lettrer des paiements avec des écritures pour ce fournisseur.';
        }
        modify("Location Code2")
        {
            ToolTipML = ENU = 'Specifies the warehouse location where items from the vendor must be received by default.', FRA = 'Spécifie l''entrepôt où les articles du fournisseur doivent être reçus par défaut.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies how the vendor must ship items to you.', FRA = 'Spécifie de quelle manière le fournisseur doit vous expédier les articles.';
        }
        modify("Lead Time Calculation")
        {
            ToolTipML = ENU = 'Specifies a date formula for the amount of time that it takes to replenish the item.', FRA = 'Spécifie une formule date pour le délai nécessaire au réapprovisionnement de l''article.';
        }
        modify("Base Calendar Code")
        {
            ToolTipML = ENU = 'Specifies the code for the vendor''s customizable calendar.', FRA = 'Spécifie le code du calendrier personnalisable du fournisseur.';
        }
        modify("Balance (LCY)")
        {
            ToolTipML = ENU = 'Specifies the total value of your completed purchases from the vendor in the current fiscal year. It is calculated from amounts excluding VAT on all completed purchase invoices and credit memos.', FRA = 'Spécifie la valeur totale de vos achats terminés auprès du fournisseur au cours de l''exercice comptable en cours. Il est calculé à partir des montants HT sur toutes les factures achat et avoirs terminés.';
        }
        modify("Balance Due (LCY)")
        {
            ToolTipML = ENU = 'Specifies the total value of your unpaid purchases from the vendor in the current fiscal year. It is calculated from amounts excluding VAT on all open purchase invoices and credit memos.', FRA = 'Spécifie la valeur totale de vos achats impayés auprès du fournisseur au cours de l''exercice comptable en cours. Il est calculé à partir des montants HT sur toutes les factures achat et avoirs ouverts.';
        }
        modify("Name 2")
        {
            Visible = true;
        }
        addafter("No.")
        {
            field("Global Vendor Number"; Rec."Global Vendor Number FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Global Vendor Number field.';
            }
            field("Vendor Type"; Rec."Vendor Type FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Vendor Type field.';
            }
            field("Industry Key"; Rec."Industry Key FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Industry Key field.';
            }
        }
        addafter(Name)
        {
            // field("Name 2"; Rec."Name 2")
            // {
            // }//BC Upgrade already available in BC 
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
            field("Global Delete"; Rec."Global Delete FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Global Flag for Deletion Indicator field.';
            }
        }
        // BC Upgrade NANDIS03 - Blocked as DIT part >>
        // addafter("Location Code")
        // {
        //     field(Address; Rec.Address)
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Description = 'FINXL7.00.001';
        //     }
        //     field("Address 2"; Rec."Address 2")
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Description = 'FINXL7.00.001';
        //     }
        // }
        // BC Upgrade NANDIS03 - Blocked as DIT part <<
        addafter(Contact)
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = Basic, Suite;
                Description = 'FINXL7.00.001';
                ToolTip = 'Specifies the vendor''s VAT registration number.';
            }
        }
        addafter("Location Code")
        {
            // field(Address; Rec.Address)
            // {
            //     ApplicationArea = All;
            // }
            field("Street 3"; Rec."Street 3 FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Street 3 field.';
            }
        }
        // addafter("Vendor Posting Group")
        // {
        //     field("Contract Vend. Post. Gr. Stand"; Rec."Contract Vend. Post. Gr. Stand")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Vend. Post. Gr. Rent"; Rec."Contract Vend. Post. Gr. Rent")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Vend. Post. Gr. Loan"; Rec."Contract Vend. Post. Gr. Loan")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Vend. Post. Gr. LoanU"; Rec."Contract Vend. Post. Gr. LoanU")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Vend. Post. Gr. Maint"; Rec."Contract Vend. Post. Gr. Maint")
        //     {
        //         Visible = false;
        //     }
        //     field("Contract Vend. Post. Gr. Other"; Rec."Contract Vend. Post. Gr. Other")
        //     {
        //         Visible = false;
        //     }
        // }//BC Upgrade SHARMP16 drink-it fields
        addafter("Balance Due (LCY)")
        {
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = Basic, Suite;
                Description = 'FINXL7.00.001';
                ToolTip = 'Specifies the value of the Net Change (LCY) field.';
            }
        }
        addafter("Base Calendar Code")
        {
            // field("Sundry Vendor"; Rec."Sundry Vendor")
            // {
            //     Editable = false;
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
            // }//BC Upgrade SHARMP16 drink-it fields
            field("Blocked Reason Code"; Rec."Blocked Reason Code FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Blocked Reason Code field.';
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the vendor''s email address.';
            }
            field("E-Mail 2"; Rec."E-Mail 2 FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Email Finance field.';
            }
        }
        moveafter("Search Name"; "Balance (LCY)")
    }
    actions
    {


        addafter(Resync)
        {

            action("Payment Journal_Action")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
                ToolTip = 'View or edit the payment journal where you can register payments to vendors.';
            }

            action("Ledger E&ntries_Action")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Suite;
                Caption = 'Ledger E&ntries';
                Image = VendorLedger;
                RunObject = Page "Vendor Ledger Entries";
                RunPageLink = "Vendor No." = field("No.");
                RunPageView = sorting("Vendor No.")
                                  order(descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
            }
            action(Statistics_Action)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Suite;
                Caption = 'Statistics';
                Image = Statistics;
                RunObject = Page "Vendor Statistics";
                RunPageLink = "No." = field("No."),
                                  "Date Filter" = field("Date Filter"),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                ShortCutKey = 'F7';
                ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
            }
            action("Service &Items_Action")

            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Service &Items',
                                    FRA = 'Ar&ticles de service';
                Image = ServiceItem;
                // Promoted = true;
                // PromotedCategory = Process;
                RunObject = Page "Service Items";
                RunPageLink = "Vendor No." = FIELD("No.");
                ToolTip = 'Executes the Service &Items_Action action.';
            }
            action("Item Refe&rences_Action")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                AccessByPermission = TableData "Item Reference" = R;
                ApplicationArea = All;
                Caption = 'Cross Refe&rences';
                Image = Change;
                RunObject = Page "Item References";
                RunPageLink = "Reference Type" = const(Vendor),
                                  "Reference Type No." = field("No.");
                RunPageView = sorting("Reference Type", "Reference Type No.");
                ToolTip = 'Set up a customer''s or vendor''s own identification of the selected item. references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.';
            }

        }

        addlast("Ven&dor")
        {
            action(VendorSPL)
            {
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor SPL';
                Image = ListPage;
                RunObject = Page "Vendor SPL List";
                RunPageLink = "Vendor No." = FIELD("No.");
                ToolTip = 'Executes the Vendor SPL action.';
            }
        }
        modify("Ven&dor")
        {
            CaptionML = ENU = 'Ven&dor', FRA = 'Fo&urnisseur';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
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
        }
        modify("C&ontact")
        {
            CaptionML = ENU = 'C&ontact', FRA = 'C&ontact';
        }
        modify(OrderAddresses)
        {
            CaptionML = ENU = 'Order &Addresses', FRA = '&Adresses de commande';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        // modify("Cross Re&ferences")
        // {
        //     CaptionML = ENU = 'Cross Re&ferences', FRA = '&Références externes';
        // }//BC Upgrade SHARMP16 action not available in BC need to create new
        modify(ApprovalEntries)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
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
        // }//BC Upgrade SHARMP16 action not available in BC need to create new
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
        modify(Statistics)
        {

            //Unsupported feature: Change Level on "Statistics(Action 18)". Please convert manually.

            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';

            //Unsupported feature: Change Name on "Statistics(Action 18)". Please convert manually.

        }
        modify(Purchases)
        {

            //Unsupported feature: Change Level on "Purchases(Action 21)". Please convert manually.

            CaptionML = ENU = 'Purchases', FRA = 'Achats';
        }
        modify("Entry Statistics")
        {

            //Unsupported feature: Change Level on ""Entry Statistics"(Action 19)". Please convert manually.

            CaptionML = ENU = 'Entry Statistics', FRA = 'Statistiques écritures';
        }
        modify("Statistics by C&urrencies")
        {

            //Unsupported feature: Change Level on ""Statistics by C&urrencies"(Action 57)". Please convert manually.

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
        modify("Payment Journal")
        {
            CaptionML = ENU = 'Payment Journal', FRA = 'Feuille paiement';
        }
        modify("Purchase Journal")
        {
            CaptionML = ENU = 'Purchase Journal', FRA = 'Feuille achat';
            Promoted = true;
        }
        modify(OCR)
        {
            CaptionML = ENU = 'OCR', FRA = 'OCR';
        }
        modify(Resync)
        {
            CaptionML = ENU = 'Resync all Vendors', FRA = 'Resync all Vendors';
            ToolTipML = ENU = 'Synchronize vendors and vendor bank accounts with the OCR service.', FRA = 'Synchronize vendors and vendor bank accounts with the OCR service.';
        }
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Vendor - List")
        {
            CaptionML = ENU = 'Vendor - List', FRA = 'Fourn. : Liste';
        }
        modify("Vendor Register")
        {
            CaptionML = ENU = 'Vendor Register', FRA = 'Historique des transactions fournisseur';
        }
        modify("Vendor Item Catalog")
        {
            CaptionML = ENU = 'Vendor Item Catalog', FRA = 'Fourn. : Catalogue articles';
            ToolTipML = ENU = 'View a list of the items that your vendors supply.', FRA = 'Affichez une liste des articles que vos fournisseurs proposent.';
        }
        modify("Vendor - Labels")
        {
            CaptionML = ENU = 'Vendor - Labels', FRA = 'Fourn. : Étiquettes';
        }
        modify("Vendor - Top 10 List")
        {
            CaptionML = ENU = 'Vendor - Top 10 List', FRA = 'Fourn. : Palmarès';
            ToolTipML = ENU = 'View a list of the top vendors by balances or purchases.', FRA = 'Affichez une liste des principaux fournisseurs par soldes ou achats.';
        }
        modify(Action5)
        {
            CaptionML = ENU = 'Orders', FRA = 'Commandes';
        }
        modify("Vendor - Order Summary")
        {
            CaptionML = ENU = 'Vendor - Order Summary', FRA = 'Fourn. : Liste des commandes';
        }
        modify("Vendor - Order Detail")
        {
            CaptionML = ENU = 'Vendor - Order Detail', FRA = 'Fourn. : Détail des commandes';
        }
        modify(Purchase)
        {
            CaptionML = ENU = 'Purchase', FRA = 'Achats';
        }
        modify("Vendor - Purchase List")
        {
            CaptionML = ENU = 'Vendor - Purchase List', FRA = 'Fourn. : Liste des achats';
            ToolTipML = ENU = 'View a list of vendor purchases for a selected period.', FRA = 'Affichez une liste d''achats fournisseur pour une période sélectionnée.';
        }
        modify("Vendor/Item Purchases")
        {
            CaptionML = ENU = 'Vendor/Item Purchases', FRA = 'Achats d''articles par fournisseur';
            ToolTipML = ENU = 'View a list of item entries for each vendor in a selected period.', FRA = 'Affichez une liste des écritures article de chaque fournisseur durant une période sélectionnée.';
        }
        modify("Purchase Statistics")
        {
            CaptionML = ENU = 'Purchase Statistics', FRA = 'Statistiques achat';
            ToolTipML = ENU = 'View a list of amounts for purchases, invoice discount and payment discount in $ for each vendor.', FRA = 'Affichez une liste des montants des achats, des remises facture et des escomptes en devise société pour chaque fournisseur.';
        }
        modify("Financial Management")
        {
            CaptionML = ENU = 'Financial Management', FRA = 'Gestion financière';
        }
        modify("Payments on Hold")
        {
            CaptionML = ENU = 'Payments on Hold', FRA = 'Paiements en attente';
            ToolTipML = ENU = 'View a list of all vendor ledger entries on which the On Hold field is marked.', FRA = 'Affichez une liste de toutes les écritures comptables fournisseur sur lesquelles le champ En attente est marqué.';
        }
        modify("Vendor - Summary Aging")
        {
            CaptionML = ENU = 'Vendor - Summary Aging', FRA = 'Fourn. : Échéancier';
            ToolTipML = ENU = 'View, print, or save a summary of the payables owed to each vendor, divided into three time periods.', FRA = 'Affichez, imprimez ou enregistrez un résumé des soldes dus à chaque fournisseur, divisé en trois périodes.';
        }
        modify("Aged Accounts Payable")
        {
            CaptionML = ENU = 'Aged Accounts Payable', FRA = 'Comptabilité fournisseur âgée';
            ToolTipML = ENU = 'View a list of aged remaining balances for each vendor.', FRA = 'Affichez une liste des soldes restants âgés pour chaque fournisseur.';
        }
        modify("Vendor - Balance to Date")
        {
            CaptionML = ENU = 'Vendor - Balance to Date', FRA = 'Fourn. : Détail écr. ouvertes';
            ToolTipML = ENU = 'View, print, or save a detail balance to date for selected vendors.', FRA = 'Affichez, imprimez ou enregistrez un Grand livre ouvert pour les fournisseurs sélectionnés.';
        }
        modify("Vendor - Trial Balance")
        {
            CaptionML = ENU = 'Vendor - Trial Balance', FRA = 'Fourn. : Balance';
            ToolTipML = ENU = 'View a detail balance for selected vendors.', FRA = 'Affichez un Grand livre pour les fournisseurs sélectionnés.';
        }
        modify("Vendor - Detail Trial Balance")
        {
            CaptionML = ENU = 'Vendor - Detail Trial Balance', FRA = 'Fourn. : Grand livre fourn.';
            ToolTipML = ENU = 'View a detail trial balance for selected vendors.', FRA = 'Affichez un grand livre pour les fournisseurs sélectionnés.';
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

        addafter("C&ontact")
        {
            action("Sh&ipping Agents")
            {
                CaptionML = ENU = 'Sh&ipping Agents',
                            FRA = '&Transporteurs';
                Image = Shipment;
                RunObject = Page "Shipping Agents";
                ApplicationArea = All;
                ToolTip = 'Executes the Sh&ipping Agents action.';
                //RunPageLink = "Vendor No." = FIELD("No.");  // BC Upgrade SHARMP16 - Dependencies on Aptean
                //RunPageView = sorting("Vendor No.", "Contact No.");  // BC Upgrade SHARMP16 - Dependencies on Aptean
            }//BC Upgrade SHARMP16 drink-it
        }
        addafter(Action55)
        {
            action("Online Map")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Online Map',
                            FRA = 'Online Map';
                Image = Map;
                ToolTip = 'Executes the Online Map action.';

                trigger OnAction();
                begin
                    Rec.DisplayMap();
                end;
            }
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
                //action("Promotion G&roups")
                // {
                //     CaptionML = ENU = 'Promotion G&roups',
                //                 FRA = 'Groupes &Promotion';
                //     Image = Relationship;
                //     RunObject = Page "Relation Promotion Groups";
                //     RunPageLink = "Source Type" = CONST(Vendor),
                //                   "Source No." = FIELD("No.");
                // }//BC Upgrade SHARMP16 drink-it fields
                // action("&Exclusivity Groups")
                // {
                //     CaptionML = ENU = '&Exclusivity Groups',
                //                 FRA = 'Groupes &Exculisivité';
                //     Image = Relationship;
                //     RunObject = Page "Relation Exclusivity Groups";
                //     RunPageLink = "Source Type" = CONST(Vendor),
                //                   "Source No." = FIELD("No.");
                // }//BC Upgrade SHARMP16 drink-it fields
                // action("Delivery Time")
                // {
                //     CaptionML = ENU = 'Delivery Time',
                //                 FRA = 'Heure de Livraison';
                //     Image = Relationship;
                //     RunObject = Page "Delivery Times";
                //     RunPageLink = "No." = FIELD("No.");
                //     RunPageView = sorting("No.", "Address Code")
                //                   where("Source Type" = CONST(Vendor));
                // }//BC Upgrade SHARMP16 drink-it fields
            }

            // action("Quality Tests")
            // {
            //     CaptionML = ENU = 'Quality Tests',
            //                 FRA = 'Testes qualité';
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
        }
        addafter(ApprovalEntries)
        {
            // group(Statistics)
            // {
            //     CaptionML = ENU = 'Statistics',
            //                 FRA = 'Statistiques';
            //     Image = Statistics;
            // }
        }
        addafter("Statistics by C&urrencies")
        {
            group("Tracking Entries")
            {
                CaptionML = ENU = 'Tracking Entries',
                            FRA = 'Ecritures traçablité';
                Image = ItemTrackingLedger;
                //     action("Empty Goods Trac&king")
                //     {
                //         CaptionML = ENU = 'Empty Goods Trac&king',
                //                     FRA = 'Traçabilité article vidange';
                //         Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
                //         Image = ItemTrackingLines;
                //         Promoted = false;
                //         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //         //PromotedCategory = "Report";
                //         RunObject = Page "Empty Goods Tracking Overview";
                //         RunPageLink = "Source Type Filter" = CONST(Vendor),
                //                       "Source No. Filter" = FIELD("No."),
                //                       "Date Filter" = FIELD("Date Filter"),
                //                       "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                //                       "Global Dimension 2 Filter" = FIELD("Global Dimension 1 Filter");
                //     }
                // }Empty Goods Tracking Overview
            }
            // action("SSCC Tracking Entries")
            // {
            //     CaptionML = ENU = 'SSCC Tracking Entries',
            //                 FRA = 'Ecritures traçablité SSCC';
            //     Image = ItemTrackingLedger;

            //     trigger OnAction();
            //     var
            //         SSCCTrackingMgt: Codeunit "SSCC Tracking Management";
            //     begin
            //         // <<DITW15.00.00.38 DDR 19/11/2010 #1139
            //         SSCCTrackingMgt.CallSSCCTrackingEntryForm(2, "No.", '', '', '', '', '', 0);
            //     end;
            // }//BC Upgrade SHARMP16 drink-it fields
        }
        addafter("Line Discounts")
        {
            // action("Dis&count Charges")
            // {
            //     CaptionML = ENU = 'Dis&count Charges',
            //                 FRA = '&Frais de remise';
            //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
            //     Image = TaxSetup;
            //     RunObject = Page "Purchase Discount Item Charges";
            //     RunPageLink = "Purchase Type" = CONST(Vendor),
            //                   "Purchase Code" = FIELD("No.");
            // }//BC Upgrade SHARMP16 drink-it fields
            // action("Promotio&n Charges")
            // {
            //     CaptionML = ENU = 'Promotio&n Charges',
            //                 FRA = 'Frais de promotion';
            //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
            //     Image = TaxSetup;
            //     RunObject = Page "Purch. Promotion Item Charges";
            //     RunPageLink = "Purchase Type" = CONST(Vendor),
            //                   "Purchase Code" = FIELD("No.");
            // }//BC Upgrade SHARMP16 drink-it fields
            // group("Drink-IT Charges")
            // {
            //     CaptionML = ENU = 'Drink-IT Charges',
            //                 FRA = 'Frais Drink-IT';
            //     Description = 'DITW18.00.06 GVC 19/05/2015 DIT-770 #1335 ';
            //     Image = TaxSetup;
            //     action("Ta&x Charges")
            //     {
            //         CaptionML = ENU = 'Ta&x Charges',
            //                     FRA = 'Taxe d''impôt';
            //         Description = 'DITW15.00.00.01';
            //         Image = TaxSetup;
            //         RunObject = Page "Purchase Tax Item Charges";
            //         RunPageLink = "Purchase Type" = CONST(Vendor),
            //                       "Purchase Code" = FIELD("No.");
            //     }
            //     action("Exception Tax Groups")
            //     {
            //         CaptionML = ENU = 'Exception Tax Groups',
            //                     FRA = 'Groupes taxe excéption';
            //         Description = 'DIT-770 #698';
            //         Image = TaxSetup;
            //         RunObject = Page "Vendor Exception Tax Group";
            //         RunPageLink = "Exception DTax Group Code" = FIELD("Vendor DTax Group Code");
            //     }
            //     action("D&eposit Charges")
            //     {
            //         CaptionML = ENU = 'D&eposit Charges',
            //                     FRA = 'Friais de dépôt';
            //         Description = 'DITW15.00.00.01';
            //         Image = TaxSetup;
            //         RunObject = Page "Purchase Deposit Item Charges";
            //         RunPageLink = "Purchase Type" = CONST(Vendor),
            //                       "Purchase Code" = FIELD("No.");
            //     }
            //     action(Action1100710040)
            //     {
            //         CaptionML = ENU = 'Dis&count Charges',
            //                     FRA = '&Frais de remise';
            //         Image = TaxSetup;
            //         RunObject = Page "Purchase Discount Item Charges";
            //         RunPageLink = "Purchase Type" = CONST(Vendor),
            //                       "Purchase Code" = FIELD("No.");
            //     }
            //     action(Action1100710039)
            //     {
            //         CaptionML = ENU = 'Promotio&n Charges',
            //                     FRA = 'Frais de promotion';
            //         Image = TaxSetup;
            //         RunObject = Page "Purch. Promotion Item Charges";
            //         RunPageLink = "Purchase Type" = CONST(Vendor),
            //                       "Purchase Code" = FIELD("No.");
            //     }
            // }//BC Upgrade SHARMP16 drink-it 
            // group(Others)
            // {
            //     CaptionML = ENU = 'Others',
            //                 FRA = 'Autres';
            //     Image = Item;
            //     action("Items &Exclusivity")
            //     {
            //         CaptionML = ENU = 'Items &Exclusivity',
            //                     FRA = 'Articles &Exclusivité';
            //         Image = Item;
            //         RunObject = Page "Purchase Items Exclusivity";
            //         RunPageLink = "Purchase Type" = CONST(Vendor),
            //                       "Purchase Code" = FIELD("No.");
            //     }
            // }//BC Upgrade SHARMP16 drink-it 
        }
        addafter(Documents)
        {
            separator(Separator1100710026)
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
                        RunObject = Page "Change Log Entries";
                        RunPageLink = "Table No." = FILTER(23),
                                      "Primary Key Field 1 Value" = FIELD("No.");
                        ToolTip = 'Executes the <Action1000000002> action.';
                    }
                    action("<Action1000000003>")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'by Default Dimension',
                                    FRA = 'Affectation analytique';
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
                    // }//BC Upgrade SHARMP16 drink-it fields
                    // action("Service Contract Lines")
                    // {
                    //     CaptionML = ENU = 'Service Contract Lines',
                    //                 FRA = 'Lignes contrat de service';
                    //     Image = ServiceLedger;
                    //     Promoted = true;
                    //     PromotedCategory = Process;
                    //     RunObject = Page "Vend. Service Contract Lines";
                    //     RunPageLink = "Vendor No." = FIELD("No.");
                    // }//BC Upgrade SHARMP16 drink-it fields
                    action("Service &Items")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Service &Items',
                                    FRA = 'Ar&ticles de service';
                        Image = ServiceItem;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Service Items";
                        RunPageLink = "Vendor No." = FIELD("No.");
                        ToolTip = 'Executes the Service &Items action.';
                    }
                }
                separator(Separator1100710015)
                {
                }
            }
        }
        addafter("Request Approval")
        {
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                Image = "Action";
                action("Apply Template")
                {
                    ApplicationArea = all;

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
            }
        }
        addafter("Purchase Statistics")
        {
            // action("Purchase Gross-net Price report")
            // {
            //     CaptionML = DEU = 'EK Brutto-Netto Preise SOLL (XLS)',
            //                 ENU = 'Purchase Gross-net Price report';
            //     Image = "Report";

            //     trigger OnAction();
            //     var
            //         lrVendor: Record Vendor;
            //         lrptPurchaseGrossNetPrice: Report "Purchase Gross-net Price";
            //     begin
            //         // << DITW110.00.11 SFI 12/12/2017 BL#XXXXX
            //         CurrPage.SETSELECTIONFILTER(lrVendor);
            //         lrptPurchaseGrossNetPrice.SETTABLEVIEW(lrVendor);
            //         lrptPurchaseGrossNetPrice.RUN;
            //         // >> DITW110.00.11 SFI BL#XXXXX
            //     end;
            // }//BC Upgrade SHARMP16 drink-it Report
            // action("Purchase Price Analysis")
            // {
            //     CaptionML = DEU = 'EK Brutto-Netto Preise IST (XLS)',
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
        addafter("Vendor - Trial Balance")
        {
            action("Vendor Trial Balance FR")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Vendor Trial Balance FR',
                            FRA = 'Balance fournisseurs FR';
                Image = "Report";
                ToolTip = 'Executes the Vendor Trial Balance FR action.';
                RunObject = Report "Vendor Trial Balance LR CBN";//BC UPgrade SHARMP16 uncomment this later after the compilation of this report
            }
        }
        addafter("Vendor - Detail Trial Balance")
        {
            // Move to RTR 30April2026
            // action("Vendor Detail Trial Balance FR")
            // {
            //     ApplicationArea = all;
            //     CaptionML = ENU = 'Vendor Detail Trial Balance FR',
            //                 FRA = 'Grand livre fournisseurs FR';
            //     Image = "Report";
            //     ToolTip = 'Executes the Vendor Detail Trial Balance FR action.';
            //     //  RunObject = Report "Vendor Detail Trial Balance LR";//BC UPgrade SHARMP16 uncomment this later after the compilation of this report
            // }
            // Move to STP 30April2026 >>
            // action("<Vendor Trial Balance DRC>")
            // {
            //     ApplicationArea = all;
            //     CaptionML = ENU = 'Vendor Trial Balance - DRC',
            //                 FRA = 'Balance fournisseurs DRC';
            //     Image = "Report";
            //     ToolTip = 'Executes the <Vendor Trial Balance DRC> action.';
            //     // RunObject = Report "Vendor Trial Balance - DRC";//BC UPgrade SHARMP16 uncomment this later after the compilation of this report
            // }
            //Move to STP 30April2026 >>
            // action("<Vendor Detail Trial Bala DRC>")
            // {
            //     ApplicationArea = all;
            //     CaptionML = ENU = 'Vendor Detail Trial Balance - DRC',
            //                 FRA = 'Grand livre fournisseurs DRC';
            //     Image = "Report";
            //     ToolTip = 'Executes the <Vendor Detail Trial Bala DRC> action.';
            //     // RunObject = Report "Vendor Detail Trial Bal - DRC";//BC UPgrade SHARMP16 uncomment this later after the compilation of this report
            // }

        }

        //BC UPgrade SHARMP16 begin
        addafter("Co&mments")
        {
            // action("Cross Re&ferences")
            // {
            //     CaptionML = ENU = 'Cross Re&ferences';
            //     ApplicationArea = Basic, Suite;
            //     Image = Change;
            //     Promoted = true;
            //     PromotedCategory = Category5;
            //     PromotedOnly = true;

            // }//BC Upgrade SHARMP16 --Item cross refernce table used for the linked page
        }
    }

    var
    // MasterDataHook: Codeunit "MasterData Hook";
    // recFINXLSetup: Record "Finance XL Setup";

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

