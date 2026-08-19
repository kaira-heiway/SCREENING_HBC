pageextension 54016 ProductionJournalExt extends "Production Journal"
{
    //   DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009 License problem
    // DITW15.00.00.30-PRODW14.00.00.09 DDR 21/01/2009 merge PRODW14.00.00.08.05A
    // DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //                                issue 768 Added to set non-editable fields
    //                                  "Gen. Bus. Posting Group","Gen. Prod. Posting Group","Inventory Posting Group"
    // DITW15.00.00.37 DDR 19/01/2010 Added Item charges (expand/collapse)
    //                                Added 'Functions' buttons
    //                     29/01/2010 issue 1054 Added fields
    //                                  "AAD No. Series","ADD No.",
    //                                  "Tariff No.","item DTax Group Code","Company Tax Registration No."
    //                     20/05/2010 issue 1081 Added fields "Physical Location Group Code"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    //                                  Rename global variable PostingDate -> PostingDateFilter
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    //                 DDR 20/01/2011 DIT-715 #50 RTC bugfix trigger OnModifyTrigger' test to call function ActionInsertAutoBlankLine()
    // DITW15.00.00.38 DDR 26/11/2010 issue 1139 SSCC Functionnalities
    //                                  Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW15.00.00.38-PRODW14.00.00.17 DDR 14/12/2010 issue 1127 Bugfix don't show Lot column if item tracking line is not required (Produ
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                             Modified "Item Charge No." as non-editable (function UpdateFields)
    //                                             Removed/Moved CaptionML control49/55
    // DITW16.00.00.38 DDR 03/02/2011 DIT-715 #59 RTC Page functionnalities
    //                                             Removed the OnLookup Trigger field "Item No."
    //                     02/03/2011 DIT-715 #50 RTC Page functionnalities
    //                                             Added/Moved OnNewRecord trigger into TriggerOnNewRecord() function
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                             Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                             Modified order position RTC buttons
    //                                               contol1102601008 RTCDeleteLine
    //                                               contol1102601009 RTCDleteAllLines
    // DITW16.00.00.39 PRODW14.00.00.08.18 DDR 19/07/2011 DIT-715 #73
    //                                            License: Modified OnFormat() column "LotNo"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                                              Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 DDR 26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                           Added menuitem "Automatic FEFO Tracking" in menu Line & Functions
    //                                           Moved functions CreateFEFOTracking(),CreateFEFOTrackingJournal() into table83
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.03 DDR 07/04/2014 DIT-770 #559 (old DIT-770 214) Bugfix standard Expand-Collapse (ShowAsTree property) workaround
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1189 Multisite - Added field "Responsibility Center"
    // DITW18.00.06 MVN 27/10/2015 DIT-770 #805 CheckQualitySetup.READPERMISSION
    // DITW18.00.07 DAT 11/03/2016 DIT-770 #1370 Permission problem on lookup "Lot No."
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Look&Feel minor correction
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    //                                                      Removed ShowAsTree property
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Bugfix Expand-Collapse ribbon button position
    //                                      Added fields "Exist Loss Breakdown"
    //                                      Allow "Scrap Code","Scrap Quantity" on Consumption
    //                                      Bugfix NAV2016: new OptionCaptionML property in "Type" field (include blank option value)
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed 'Editable' property for fields "strength Spec. Value","vol-strength Spec. Value"
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // HEI.03 FDD HNK HILITE BASE  PRDGAP018 ISYED01 13/06/17
    //   #Added A new field “Actual Posted Consumption / Output” show the quantity that has already been posted for the item specified on the line

    // HEI.02 FDD HNK GAPID001 IBM NAIKH01 16/06/2017
    //   # Added new code on the page action of "POST" and Action57

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #new fields Zone Code
    // 20170622 PRDGAP018 : PRDGAP018- Seeing the Actual posted consumption quantity

    // HEI.04 FDD PRDGAP040 Heilite BASE IBM ISYED01 17/07/2017
    //  #If on the Item journal line the Flushing method is (Backward flushing), then the Consumption qQuantity field on the Production order journal should be set to non-editable.

    // HEI.05 FDD-PRDGAP044 - Stocks from Heaven (over consumption) IBM.NAIKH01 05/08/2017
    //   # Added new code on the page action of "POST"

    // HEI.06 FDD- PRDGAPID003-One Component Splite Into Multiple lots , IBM.NAIKH01 14.08.2017
    //   # Changed the "SourceTableView = SORTING(Entry Type,Item No.,Variant Code,Location Code,Bin Code,Posting Date) ORDER(Ascending)" in the page property

    // HEI.07 FDD- PRDGAP027 - NO Lot No.,BinCode in RPO,FPO,Production Journal, IBM.NAIKH01 22.08.2017
    //   # Added new Code on Trigger "OnAfterGetRecord()".
    //   # Added new code on "Bin Code - OnValidate()"
    //   # Added new Code on "LotNo - OnLookup"
    //   # Added new Code on Page Action "ItemTrackingLines - OnAction()";
    //   # Created a new Function "DeleteLotNo";
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 check based on Outstanding Qty
    // HEI.08 PRDGAP045 - IBM ISYED01 02.04.2018
    //   # Added code to validate the Negative Consumption at production journal
    //   # Added code to On post button
    // HEI.09 FDD_CHG2003754 IBM ISYED01 03.19.2019
    // HEI.10 INC2099374 IBM NASTAA02 15.04.2019 # Was able to Post to Bin without Batch Number
    //   # Added filter on Source Subtype = Output in function "DeleteLotNo"
    // HEI.11 INC2142955 IBM Isyed01
    //   # Added code Users cannot post “Yeast Harvested” in production
    // DITW114.00.15 DDR 17/01/2020 NRQ#133083 Fix missing Refresh on "Posting Date","Operation No.","No."
    // HEI.12 CC-CHG2069946 IBM.LS 30.06.2020
    //   # Code added to fix the incorrect Error messages during Negative Consumption posting.
    // HEI.13 Defect #6183 - CHG2107029 IBM NASTAA02 30.03.2021 # Component line dissapears from the Production JHournal when trying to change the Source Zone/BIN
    //   # Added 'CurrPgae.UPDATE' on 'OnValidate' trigger of 'Zone Code'
    // DITW110.00.12 MSF 04/05/2018 NRQ#55899 Resp. centre with Phys. Location group and Location code gives conflict - part 3
    // version NAVW110.0,QXL9.00.001,DITW110.00.08,HEI.02,GAP026

    //------------------------------------------------------------------------------------------------------

    //BC Upgrade KAPOOV01 01.12.2025 #Added Code on Trigger-OnAfterGetRecord() to take HEI Customization on OnAfterGetRecord() trigger of Base Page-5510
    //BC Upgrade KAPOOV01 04.12.2025 #Added code on trigger "Bin Code"-OnAfterValidate()-HEI.07 Tag
    //BC Upgrade KAPOOV01 05.12.2025 #Added code on trigger LotNo-OnLookup -HEI.07 Tag
    //BC Upgrade KAPOOV01 09.12.2025 #Created new local procedure DeleteLotNo(Rec: Record 83)-HEI.07,HEI.10
    //BC Upgrade KAPOOV01 10.12.2025 #Added Code on Trigger ItemTrackingLines - OnAction()-HEI.07
    //BC Upgrade KAPOOV01 10.12.2025 #Added new action-Split Prod. Journal lines-HEI.09
    //BC Upgrade KAPOOV01 11.12.2025 #Added new action-Split Prod. Journal lines1-HEI.09
    //BC Upgrade KAPOOV01 11.12.2025 #Hide standard Post action and created new Post action-Post_HNK to take HEI cutomization.
    //BC Upgrade KAPOOV01 11.12.2025 #Hide standard Post and &Print action and created new Post action-Post and &Print_HNK to take HEI cutomization.
    //BC Upgrade KAPOOV01 11.12.2025 #Inside Moveafter functions replaced Control by actual field names to remove compilation error at 10 places.
    //BC Upgrade KAPOOV01 11.12.2025 #Renamed action-Split Prod. Journal lines to Split Prod. Journal lines1 as it is defined twice as part of HNK customization.
    //BC Upgrade KAPOOV01 01.01.2026 #Added Code on Trigger-OnAfterGetCurrRecord() to take HEI.04 Tag Customization inside function-ControlsMngt().
    //BC Upgrade KAPOOV01 01.01.2026 #Added Code on Trigger-OnOpenPage()to take HEI.06 Tag modification where SourceTableView property of Base page is modified to -> "SourceTableView = SORTING(Entry Type,Item No.,Variant Code,Location Code,Bin Code,Posting Date) ORDER(Ascending)".
    //************************************************************************************************************
    //HEI.14 BC UPGRADE PATHAA02 11.03.26 FDD-DTW002 # Functionality- "Production jnl. flushing"  
    //Field "Production jnl. flushing" added after Description.

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify(PostingDate)
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
            ToolTipML = ENU = 'Specifies a posting date that will apply to all the lines in the production journal.', FRA = 'Spécifie une date comptabilisation s''appliquant à toutes les lignes de la feuille production.';
        }
        modify(FlushingFilter)
        {
            CaptionML = ENU = 'Flushing Method Filter', FRA = 'Filtre méthode consommation';
            ToolTipML = ENU = 'Specifies which components to view and handle in the journal, according to their flushing method.', FRA = 'Spécifie les composants à afficher et à gérer dans la feuille en fonction de leur méthode de consommation.';
            //OptionCaptionML = ENU = 'Manual,Forward,Backward,Pick + Forward,Pick + Backward,All Methods', FRA = 'Manuel,En aval,En amont,Prélèvement + En aval,Prélèvement + En amont,Toutes les méthodes';
        }
        modify("Entry Type")
        {
            ToolTipML = ENU = 'Specifies the type of transaction that will be posted from the item journal line.', FRA = 'Spécifie le type de transaction qui sera validé depuis la ligne feuille article.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the order that created the entry.', FRA = 'Spécifie le numéro de ligne ayant créé l''écriture.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number for the journal line.', FRA = 'Spécifie le numéro de document de la ligne feuille.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item on the journal line.', FRA = 'Spécifie le numéro de l''article de la ligne feuille.';

            //Unsupported feature: Change Editable on ""Item No."(Control 14)". Please convert manually.

        }
        modify("Operation No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production operation on the item journal line when the journal functions as an output journal.', FRA = 'Spécifie le numéro de l''opération de production de la ligne feuille article lorsque la feuille fonctionne comme une feuille production.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the journal type, which is either Work Center or Machine Center.', FRA = 'Indique le type de feuille, à savoir Centre de charge ou Poste de charge.';
            //OptionCaptionML = ENU = 'Work Center,Machine Center, ', FRA = 'Centre de charge,Poste de charge, ';

            //Unsupported feature: Change Name on "Type(Control 80)". Please convert manually.

        }
        modify("Flushing Method")
        {
            ToolTipML = ENU = 'Manages the Flushing Method Filter field in the Production Journal window.', FRA = 'Gère le champ Filtre méthode consommation dans la fenêtre Feuille production.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of a work center or a machine center, depending on the entry in the Type field.', FRA = 'Indique le numéro du poste de charge ou du centre de charge correspondant à l''écriture du champ Type.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a variant code for the item.', FRA = 'Spécifie un code variante pour l''article.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item on the journal line.', FRA = 'Spécifie une description de l''article sur la ligne feuille.';
            Editable = false;  //BC Upgrade KAPOOV01 field made non-editable on table level.
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Consumption Quantity', FRA = 'Quantité consommée';
            ToolTipML = ENU = 'Specifies the quantity of the component that will be posted as consumed.', FRA = 'Spécifie la quantité du composant qui sera validée comme étant consommée.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the code if you have filled in the Sales Unit of Measure field on the item card.', FRA = 'Spécifie le code si vous avez renseigné le champ Unité de vente de la fiche article.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the inventory location where the item on the journal line will be registered.', FRA = 'Spécifie le code du magasin où l''article de la ligne feuille sera enregistré.';
        }
        modify("Bin Code")
        {
            //ToolTipML = ENU = 'Specifies a bin code for the item.', FRA = 'Spécifie un code emplacement pour l''article.';
            //BC Upgrade KAPOOV01>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //<< HEI.07
                LineNo1 := 1;
                LineNo2 := 0;
                SelectedItemTracking := FALSE;
                //>> HEI.07
            end;
            //BC Upgrade KAPOOV01<<
        }
        modify("Work Shift Code")
        {
            ToolTipML = ENU = 'Specifies the work shift code for this Journal line.', FRA = 'Contient le code équipe de cette ligne feuille.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the item journal line is linked to.', FRA = 'Spécifie le code section analytique qui est lié à cette ligne feuille article.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general business posting group that will be used when you post the entry on the item journal line.', FRA = 'Spécifie le code du groupe comptabilisation marché utilisé lorsque vous validez l''écriture sur la ligne feuille article.';

            //Unsupported feature: Change Editable on ""Gen. Bus. Posting Group"(Control 10)". Please convert manually.

        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies the code of the general product posting group that will be used for this item when you post the entry on the item journal line.', FRA = 'Spécifie le code groupe comptabilisation produit qui est utilisé pour cet article lorsque vous validez l''écriture de la ligne feuille article.';

            //Unsupported feature: Change Editable on ""Gen. Prod. Posting Group"(Control 12)". Please convert manually.

        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the item journal line is linked to.', FRA = 'Spécifie le code section analytique qui est lié à cette ligne feuille article.';
        }

        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.


        //Unsupported feature: Change TableRelation on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.

        modify("Starting Time")
        {
            ToolTipML = ENU = 'Specifies the starting time of the operation on the item journal line.', FRA = 'Spécifie l''heure de début de l''opération de la ligne feuille article.';
        }
        modify("Ending Time")
        {
            ToolTipML = ENU = 'Specifies the ending time of the operation on the item journal line.', FRA = 'Spécifie l''heure de fin de l''opération de la ligne feuille article.';
        }
        modify("Concurrent Capacity")
        {
            ToolTipML = ENU = 'Specifies the concurrent capacity.', FRA = 'Spécifie la capacité simultanée.';
        }
        modify("Setup Time")
        {
            ToolTipML = ENU = 'Specifies the time required to set up the machines for this journal line.', FRA = 'Indique le temps nécessaire pour préparer les machines pour cette ligne feuille.';
        }
        modify("Run Time")
        {
            ToolTipML = ENU = 'Specifies the run time of the operations represented by this journal line.', FRA = 'Affiche le temps d''exécution des opérations représentées par cette ligne feuille.';
        }
        modify("Cap. Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code for the capacity usage.', FRA = 'Spécifie le code unité de la capacité.';
        }
        modify("Scrap Code")
        {
            ToolTipML = ENU = 'Specifies the scrap code.', FRA = 'Spécifie le code rebut.';
            //CaptionClass = GetQtyCaptionClass(FIELDNO("Scrap Code"), 12);//BC Upgrade KAPOOV01
        }
        modify("Output Quantity")
        {
            ToolTipML = ENU = 'Specifies the quantity of the produced item that can be posted as output on the journal line.', FRA = 'Spécifie la quantité produite de l''article pouvant être validée en production dans la ligne feuille.';
        }
        modify("Scrap Quantity")
        {
            ToolTipML = ENU = 'Specifies the number of units produced incorrectly, and therefore cannot be used.', FRA = 'Indique le nombre d''unités produites qui comportent des défauts et qui ne peuvent donc pas être utilisées.';
            //CaptionClass = GetQtyCaptionClass(FIELDNO("Scrap Code"), 2);//BC Upgrade KAPOOV01
        }
        modify(Finished)
        {
            ToolTipML = ENU = 'Specifies that the operation represented by the output journal line is finished.', FRA = 'Spécifie que l''opération représentée par la ligne feuille production est terminée.';
        }
        modify("Applies-to Entry")
        {
            ToolTipML = ENU = 'Specifies if the quantity in the item journal line should be applied to an already-posted document.', FRA = 'Spécifie si la quantité dans la ligne feuille article doit être lettrée dans un document déjà validé.';
        }
        modify("Applies-from Entry")
        {
            ToolTipML = ENU = 'Specifies the number of the outbound item ledger entry, whose cost is forwarded to the inbound item ledger entry.', FRA = 'Spécifie le numéro de l''écriture comptable article sortant, dont le coût est transmis à l''écriture comptable article entrant.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the item journal line.', FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille article.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number referring to the customer or vendor numbering system with whom you are trading items on this journal line.', FRA = 'Spécifie un numéro de document qui se réfère au programme de numérotation du client ou du fournisseur avec lequel vous traitez pour les articles de cette ligne feuille.';
        }
        modify(Actual)
        {
            CaptionML = ENU = 'Actual', FRA = 'Réel';
        }
        modify("Consump. Qty.")
        {
            CaptionML = ENU = 'Consump. Qty.', FRA = 'Quantité consommée';
        }
        modify(ActualConsumpQty)
        {
            //ShowCaption = No; //BC Upgrade KAPOOV01 Commented
            ShowCaption = false; //BC Upgrade KAPOOV01
            CaptionML = ENU = 'Consump. Qty.', FRA = 'Quantité consommée';
        }
        modify(Control1901741901)
        {
            CaptionML = ENU = 'Setup Time', FRA = 'Temps de préparation';
        }
        modify(ActualSetupTime)
        {
            CaptionML = ENU = 'Setup Time', FRA = 'Temps de préparation';
        }
        modify(Control1902759401)
        {
            CaptionML = ENU = 'Run Time', FRA = 'Temps d''exécution';
        }
        modify(ActualRunTime)
        {
            CaptionML = ENU = 'Run Time', FRA = 'Temps d''exécution';
        }
        modify("Output Qty.")
        {
            CaptionML = ENU = 'Output Qty.', FRA = 'Quantité produite';
        }
        modify(ActualOutputQty)
        {
            CaptionML = ENU = 'Output Qty.', FRA = 'Quantité produite';
        }
        modify("Scrap Qty.")
        {
            CaptionML = ENU = 'Scrap Qty.', FRA = 'Quantité perte';
        }
        modify(ActualScrapQty)
        {
            CaptionML = ENU = 'Scrap Qty.', FRA = 'Quantité perte';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "General(Control 61)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "PostingDate(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "PostingDate(Control 48)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "FlushingFilter(Control 60)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "FlushingFilter(Control 60)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: CodeInsertion on "Control 43". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        EntryTypeOnAfterValidate;
        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        IF "Entry Type" <> xRec."Entry Type" THEN
          CurrPage.UPDATE(TRUE);
        // >>DITW18.00.06 DDR DIT-770 #1189
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 43)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 43)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 38". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        PostingDateOnAfterValidate;
        // <<DITW114.00.15 DDR 17/01/2020 NRQ#133083
        IF "Posting Date" <> xRec."Posting Date" THEN
          CurrPage.UPDATE(TRUE);
        // >>DITW114.00.15 DDR NRQ#133083
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 38)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Order Line No."(Control 16)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Order Line No."(Control 16)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 2". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        DocumentNoOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Document No."(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document No."(Control 2)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 14". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
        IF AssistEditItemTreeview("Item No.") THEN BEGIN
          // validate trigger
          // aftervalidate trigger
          CurrPage.UPDATE(TRUE);
        END ELSE
          CurrPage.UPDATE(FALSE);
        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
        */
        //end;


        //Unsupported feature: CodeModification on ""Item No."(Control 14).OnLookup". Please convert manually.

        //trigger "(Control 14)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Item.GET("Item No.") then
          PAGE.RUNMODAL(PAGE::"Item List",Item);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF Item.GET("Item No.") THEN
          PAGE.RUNMODAL(PAGE::"Item List",Item);
        */
        //end;


        //Unsupported feature: CodeInsertion on "Control 14". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ItemNoOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Item No."(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 14)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 64". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW114.00.15 DDR 17/01/2020 NRQ#133083
        IF "Operation No." <> xRec."Operation No." THEN
          CurrPage.UPDATE(TRUE);
        // >>DITW114.00.15 DDR NRQ#133083
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Operation No."(Control 64)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Operation No."(Control 64)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 80)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 80)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Flushing Method"(Control 39)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Flushing Method"(Control 39)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 82". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW114.00.15 DDR 17/01/2020 NRQ#133083
        IF "No." <> xRec."No." THEN
          CurrPage.UPDATE(TRUE);
        // >>DITW114.00.15 DDR NRQ#133083
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""No."(Control 82)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 82)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 5". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 84)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 84)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 23". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        QuantityOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on "Quantity(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 23)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 26". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitofMeasureCodeOnAfterValida;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 26)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 100". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        IF "Location Code" <> xRec."Location Code" THEN
          CurrPage.UPDATE(TRUE);
        // >>DITW18.00.06 DDR DIT-770 #1189
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 100)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 100)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 28". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        BinCodeOnAfterValidate;
        //<< HEI.07
        LineNo1 := 1;
        LineNo2 :=0;
        SelectedItemTracking := FALSE;
        //>> HEI.07
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Bin Code"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bin Code"(Control 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Work Shift Code"(Control 114)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Work Shift Code"(Control 114)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 118)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 1 Code"(Control 118)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Bus. Posting Group"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Bus. Posting Group"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Prod. Posting Group"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Gen. Prod. Posting Group"(Control 12)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 120)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Shortcut Dimension 2 Code"(Control 120)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[3]"(Control 300)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[4]"(Control 302)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[5]"(Control 304)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[6]"(Control 306)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[7]"(Control 308)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""ShortcutDimCode[8]"(Control 310)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Starting Time"(Control 94)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Starting Time"(Control 94)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ending Time"(Control 96)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ending Time"(Control 96)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Concurrent Capacity"(Control 98)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Concurrent Capacity"(Control 98)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Setup Time"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Setup Time"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Run Time"(Control 86)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Run Time"(Control 86)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 3". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        CapUnitofMeasureCodeOnAfterVal;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Cap. Unit of Measure Code"(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Cap. Unit of Measure Code"(Control 3)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 112". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ScrapCodeOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Scrap Code"(Control 112)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Scrap Code"(Control 112)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 126". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        OutputQuantityOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Output Quantity"(Control 126)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Output Quantity"(Control 126)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 128". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        IF "Entry Type" = "Entry Type"::Output THEN BEGIN
          OpenLossBreakdownLines;
          CurrPage.UPDATE;
        END;
        // >>DITW19.00.08 DDR BL#10443
        */
        //end;


        //Unsupported feature: CodeInsertion on "Control 128". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ScrapQuantityOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Scrap Quantity"(Control 128)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Scrap Quantity"(Control 128)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Finished(Control 122)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Finished(Control 122)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Entry"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-to Entry"(Control 33)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-from Entry"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Applies-from Entry"(Control 32)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 134". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        DocumentDateOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 134)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document Date"(Control 134)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 136)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""External Document No."(Control 136)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Actual(Control 73)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1902114901(Control 1902114901)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Consump. Qty."(Control 1901742001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActualConsumpQty(Control 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActualConsumpQty(Control 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1901741901(Control 1901741901)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActualSetupTime(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActualSetupTime(Control 50)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1902759401(Control 1902759401)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActualRunTime(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActualRunTime(Control 52)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Output Qty."(Control 1900205801)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 54". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ActualOutputQtyOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on "ActualOutputQty(Control 54)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActualOutputQty(Control 54)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Scrap Qty."(Control 1900205901)". Please convert manually.



        //Unsupported feature: CodeInsertion on "Control 58". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ActualScrapQtyOnAfterValidate;
        */
        //end;

        //Unsupported feature: PropertyDeletion on "ActualScrapQty(Control 58)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActualScrapQty(Control 58)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.


        addafter(Description)
        {
            field("Production jnl. flushing"; Rec."Production jnl. flushing FND")
            {
                ApplicationArea = All;
                Description = 'HEI.14';
            }
        }

        // addafter(Description)
        // {
        //     field("Production jnl. flushing"; "Production jnl. flushing")
        //     {
        //     }
        // }//BC Upgrade KAPOOV01 Drink-IT
        addafter("Output Quantity")
        {
            field("Actual Posted Cons/Output"; ActualConOutput)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    CurrPage.UPDATE; //HEI.13
                end;
            }
        }
        addafter("Bin Code")
        {
            field(LotNo; LotNoText)
            {
                CaptionML = ENU = 'Lot No.',
                            FRA = 'N° lot';
                Editable = false;
                Style = Attention;
                StyleExpr = LotNocolor;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    //BC Upgrade KAPOOV01 Drink-IT>>
                    //<<QXL9.00.001 DAT 23/03/2016
                    //Rec.OpenItemTrackingLines(FALSE); 
                    //<<DITW18.00.06 MVN 27/10/2015 DIT-770 #805
                    //IF QualitySetup.READPERMISSION AND ("Item Charge No." = '') THEN BEGIN
                    //>>DITW18.00.06 MVN 27/10/2015 DIT-770 #805
                    //LotNo := QualityManagement.GetItemJnlLineLotNo(Rec);
                    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                    //CurrPage.UPDATE;
                    // >>DITW19.00.08 DDR BL#10443
                    //<<DITW18.00.06 MVN 27/10/2015 DIT-770 #805
                    //END;//BC Upgrade KAPOOV01 Drink-IT
                    //>>DITW18.00.06 MVN 27/10/2015 DIT-770 #805
                    //>>QXL9.00.001 DAT 23/03/2016
                    //BC Upgrade KAPOOV01 Drink-IT<<
                    SelectedItemTracking := TRUE; //HEI.07
                end;
            }
        }
        addafter("Posting Date")
        {//BC Upgrade KAPOOV01 Drink-IT>>
            // field(Collapse; Collapse)
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW15.00.00.37 DDR 19/01/2010
            //         CurrPage.UPDATE(TRUE);
            //         // >>DITW15.00.00.37 DDR
            //     end;
            // }
            //BC Upgrade KAPOOV01 Drink-IT<<
        }
        addafter("Document No.")
        {
            // field("Has Item Charge"; "Has Item Charge")
            // {
            //     BlankZero = true;
            // }//BC Upgrade KAPOOV01 Drink-IT
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Order Line No.")
        {
            field("Item Charge No."; Rec."Item Charge No.")
            {
                Editable = "Item Charge No.Editable";
                Enabled = "Item Charge No.Enable";
                Visible = false;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    //ItemChargeNoOnAfterValidate; //BC Upgrade KAPOOV01 Drink-IT
                end;
            }
        }
        addafter("Variant Code")
        {
            //BC Upgrade KAPOOV01 Drink-IT>>
            // field("Responsibility Center"; "Responsibility Center")
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
            //         IF "Responsibility Center" <> xRec."Responsibility Center" THEN
            //             CurrPage.UPDATE(TRUE);
            //         // >>DITW18.00.06 DDR DIT-770 #1189
            //     end;
            // }
            // field("Physical Location Group Code"; "Physical Location Group Code")
            // {
            //     Visible = false;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
            //         IF "Physical Location Group Code" <> xRec."Physical Location Group Code" THEN
            //             CurrPage.UPDATE(TRUE);
            //         // >>DITW18.00.06 DDR DIT-770 #1189
            //     end;
            // }
            //BC Upgrade KAPOOV01 Drink-IT<<
        }
        addafter("Scrap Code")
        {
            //BC Upgrade KAPOOV01 Drink-IT>>
            // field("Exist Loss Breakdown"; "Exist Loss Breakdown")
            // {
            //     Visible = false;
            // }
            //BC Upgrade KAPOOV01 Drink-IT<<
        }
        addafter("Scrap Quantity")
        {
            field(SerialNo; SerialNoText)
            {
                CaptionML = ENU = 'Serial No.',
                            FRA = 'N° de série';
                Editable = false;
                Style = Attention;
                StyleExpr = LotNocolor;
                ApplicationArea = All;
                //BC Upgrade KAPOOV01 Drink-IT>>
                // trigger OnLookup(Text: Text): Boolean;
                // begin
                //     //<<QXL9.00.001 DAT 23/03/2016
                //     OpenItemTrackingLines(FALSE);
                //     IF "Item Charge No." = '' THEN BEGIN
                //         SerialNo := QualityManagement.GetItemJnlLineSerialNo(Rec);
                //     END;
                //     //>>QXL9.00.001 DAT 23/03/2016
                // end;
                //BC Upgrade KAPOOV01 Drink-IT<<
            }
        }
        addafter("Applies-from Entry")
        {
            //BC Upgrade KAPOOV01 Drink-IT>>
            // field("Due Tax"; "Due Tax")
            // {
            //     Visible = false;
            // }
            // field("Duty Suspended"; "Duty Suspended")
            // {
            //     Visible = false;
            // }
            // field("Item DTax Group Code"; "Item DTax Group Code")
            // {
            //     Editable = "Item DTax Group CodeEditable";
            //     Visible = false;
            // }
            // field("Company Tax Registration No."; "Company Tax Registration No.")
            // {
            //     Editable = CompanyTaxRegistrationNoEditab;
            //     Visible = false;
            // }
            // field("Strength Spec. Code"; "Strength Spec. Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }

            // field(AverageStrengthReserv(FIELDNO("Strength Spec. Value")); AverageStrengthReserv(FIELDNO("Strength Spec. Value")))
            // {
            //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
            //     AutoFormatType = 2013664;
            //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Strength Spec. Value"));
            //     CaptionML = ENU = 'Strength Spec. Value',
            //                 FRA = 'Valeur contrainte spécification';
            //     Editable = false;
            //     Visible = false;

            //     trigger OnDrillDown();
            //     begin
            //         // <<DITW19.00.08 DDR 20/10/2016 BL#10443
            //         DrilldownReservEntryVS(FIELDNO("Strength Spec. Value"));
            //     end;
            // }
            // field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field(SumVolStrengthReserv(FIELDNO("Vol-Strength Spec. Value")); SumVolStrengthReserv(FIELDNO("Vol-Strength Spec. Value")))
            // {
            //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
            //     AutoFormatType = 2013664;
            //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Vol-Strength Spec. Value"));
            //     CaptionML = ENU = 'Vol-Strength Spec. Value',
            //                 FRA = 'Valeur spécification contrainte volume';
            //     Editable = false;
            //     Visible = false;

            //     trigger OnDrillDown();
            //     begin
            //         // <<DITW19.00.08 DDR 20/10/2016 BL#10443
            //         DrilldownReservEntryVS(FIELDNO("Vol-Strength Spec. Value"));
            //     end;
            // }
            // field("Unit Volume HL"; "Unit Volume HL")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Tariff No."; "Tariff No.")
            // {
            //     Editable = "Tariff No.Editable";
            //     Visible = false;
            // }
            // field("AAD No. Series"; "AAD No. Series")
            // {
            //     Editable = "AAD No. SeriesEditable";
            //     Visible = false;
            // }
            // field("AAD No."; "AAD No.")
            // {
            //     Editable = "AAD No.Editable";
            //     Visible = false;
            // }
            //BC Upgrade KAPOOV01 Drink-IT<<
        }
        addafter("External Document No.")
        {
            //BC Upgrade KAPOOV01 Drink-IT>>
            // field(RTCTotalLine; GetTotalingLine(1, Rec.FIELDNO(Amount), TRUE))
            // {
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionML = ENU = 'Total Amount',
            //                 FRA = 'Montant total';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     Editable = false;
            //     QuickEntry = false;
            // }
            //BC Upgrade KAPOOV01 Drink-IT<<
        }
        //BC Upgrade KAPOOV01 Inside Moveafter functions replaced Control by actual field names to remove compilation error at 10 places.>>
        // moveafter("Control 43"; "Item No.")
        // moveafter("Control 14"; Description)
        // moveafter("Control 84"; "Unit of Measure Code")
        // moveafter("Control 26"; Quantity)
        // moveafter("Control 23"; "Output Quantity")
        // moveafter("Control 126"; "Bin Code")
        // moveafter("Control 28"; "Run Time")
        // moveafter("Control 86"; "Setup Time")
        // moveafter("Control 38"; "Location Code")
        // moveafter("Control 100"; "Document No.")

        moveafter("Entry Type"; "Item No.")
        moveafter("Item No."; Description)
        moveafter(Description; "Unit of Measure Code")
        moveafter("Unit of Measure Code"; Quantity)
        moveafter("Quantity"; "Output Quantity")
        moveafter("Output Quantity"; "Bin Code")
        moveafter("Bin Code"; "Run Time")
        moveafter("Run Time"; "Setup Time")
        moveafter("Posting Date"; "Location Code")
        moveafter("Location Code"; "Document No.")
        //BC Upgrade KAPOOV01 Inside Moveafter functions replaced Control by actual field names to remove compilation error at 10 places.<<
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {

            //Unsupported feature: Change AccessByPermission on "Dimensions(Action 44)". Please convert manually.

            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(ItemTrackingLines)
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
            //BC Upgrade KAPOOV01>>
            trigger OnAfterAction()
            begin
                SelectedItemTracking := TRUE; //<< HEI.07
            end;
            //BC Upgrade KAPOOV01<<
        }
        modify("Bin Contents")
        {
            CaptionML = ENU = 'Bin Contents', FRA = 'Contenu emplacement';

            //Unsupported feature: Change RunObject on ""Bin Contents"(Action 46)". Please convert manually.


            //Unsupported feature: Change RunPageView on ""Bin Contents"(Action 46)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Bin Contents"(Action 46)". Please convert manually.

        }
        modify("Pro&d. Order")
        {
            CaptionML = ENU = 'Pro&d. Order', FRA = '&O.F.';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';

            //Unsupported feature: Change RunObject on "Card(Action 19)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Card(Action 19)". Please convert manually.

        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
        }
        modify("Item Ledger E&ntries")
        {
            CaptionML = ENU = 'Item Ledger E&ntries', FRA = 'É&critures comptables article';

            //Unsupported feature: Change RunObject on ""Item Ledger E&ntries"(Action 21)". Please convert manually.


            //Unsupported feature: Change RunPageView on ""Item Ledger E&ntries"(Action 21)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Item Ledger E&ntries"(Action 21)". Please convert manually.

        }
        modify("Capacity Ledger Entries")
        {
            CaptionML = ENU = 'Capacity Ledger Entries', FRA = 'Écritures comptables capacité';

            //Unsupported feature: Change RunObject on ""Capacity Ledger Entries"(Action 22)". Please convert manually.


            //Unsupported feature: Change RunPageView on ""Capacity Ledger Entries"(Action 22)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Capacity Ledger Entries"(Action 22)". Please convert manually.

        }
        modify("Value Entries")
        {
            CaptionML = ENU = 'Value Entries', FRA = 'Écritures valeur';

            //Unsupported feature: Change RunObject on ""Value Entries"(Action 25)". Please convert manually.


            //Unsupported feature: Change RunPageView on ""Value Entries"(Action 25)". Please convert manually.


            //Unsupported feature: Change RunPageLink on ""Value Entries"(Action 25)". Please convert manually.

        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify("Test Report")
        {

            //Unsupported feature: Change Ellipsis on ""Test Report"(Action 41)". Please convert manually.

            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            //BC Upgrade KAPOOV01>>
            //Promoted = Yes;
            //PromotedIsBig = Yes;
            Promoted = true;
            PromotedIsBig = true;
            Visible = false; //BC Upgrade KAPOOV01 Hide standard Post action and created new Post action-Post_HNK to take HEI cutomization.

            //BC Upgrade KAPOOV01<<
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            //BC Upgrade KAPOOV01>>
            //Promoted = Yes;
            //PromotedIsBig = Yes;
            Promoted = true;
            PromotedIsBig = true;
            Visible = false; //BC Upgrade KAPOOV01 Hide standard Post and &Print action and created new Post action-Post and &Print_HNK to take HEI cutomization.
            //BC Upgrade KAPOOV01<<
        }
        modify("&Print")
        {

            //Unsupported feature: Change Ellipsis on ""&Print"(Action 31)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            //Promoted = Yes;//BC Upgrade KAPOOV01
            Promoted = true;//BC Upgrade KAPOOV01
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Line"(Action 35)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Dimensions(Action 44)". Please convert manually.



        //Unsupported feature: CodeModification on "ItemTrackingLines(Action 45).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OpenItemTrackingLines(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        OpenItemTrackingLines(FALSE);
        SelectedItemTracking := TRUE; //<< HEI.07
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Bin Contents"(Action 46)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Pro&d. Order"(Action 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Card(Action 19)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Ledger E&ntries"(Action 20)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item Ledger E&ntries"(Action 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Capacity Ledger Entries"(Action 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Value Entries"(Action 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""P&osting"(Action 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Test Report"(Action 41)". Please convert manually.



        //Unsupported feature: CodeModification on "Post(Action 56).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DeleteRecTemp;

        PostingItemJnlFromProduction(false);

        InsertTempRec;

        SetFilterGroup;
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HeinekenGlobal.ValidateNegativeConsumptionQty(Rec);  // HEI.05 NAIKH01   //DEFECT 1931
        //HEI.12>>
        //HEI.11>>
        //AllowJNLPosting := HeinekenGlobal.CheckToallowJNLPosting4CatCodes(Rec);
        //IF NOT AllowJNLPosting THEN BEGIN
          //HeinekenGlobal.ValidateNegativeConsumptionQty_New(Rec);  //DEFECT 1931
          //HEI.08>>
          //HeinekenGlobal.NegativeConsumptionCatgryCode(Rec);
          //HEI.08<<
        //END;
        //HEI.11<<
        HeinekenGlobal.NegativeConsumptionCatgryCodeNew(Rec);
        //HEI.12<<
        Proceed := AllowPartialOutput;   // HEI.02 NAIKH01 GAPID001
        IF Proceed THEN BEGIN   //HEI.02 NAIKH01 GAPID001
          DeleteRecTemp;
          PostingItemJnlFromProduction(FALSE);
          InsertTempRec;
          SetFilterGroup;
          CurrPage.UPDATE(FALSE);
        END; //NAIKH01 GAPID001
        */
        //end;


        //Unsupported feature: CodeModification on ""Post and &Print"(Action 57).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DeleteRecTemp;

        PostingItemJnlFromProduction(true);

        InsertTempRec;

        SetFilterGroup;
        CurrPage.UPDATE(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Proceed := AllowPartialOutput;   //NAIKH01 GAPID001 HEI.02
        IF Proceed THEN BEGIN   //NAIKH01 GAPID001 HEI.02
          DeleteRecTemp;
          PostingItemJnlFromProduction(TRUE);
          InsertTempRec;
          SetFilterGroup;
          CurrPage.UPDATE(FALSE);
        END; //NAIKH01 GAPID001
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Post and &Print"(Action 57)". Please convert manually.



        //Unsupported feature: CodeModification on ""&Print"(Action 31).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemJnlLine.COPY(Rec);
        ItemJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
        ItemJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
        REPORT.RUNMODAL(REPORT::"Inventory Movement",true,true,ItemJnlLine);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        REPORT.RUNMODAL(REPORT::"Inventory Movement",TRUE,TRUE,ItemJnlLine);
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""&Print"(Action 31)". Please convert manually.

        //BC Upgrade KAPOOV01 Drink-IT>>
        // addafter(ItemTrackingLines)
        // {
        //     action("&Automatic FEFO Tracking")
        //     {
        //         CaptionML = ENU = '&Automatic FEFO Tracking',
        //                     FRA = 'Traçabilité Automatique FEFO';
        //         Description = '#1331';
        //         Image = ItemTracking;
        //         ShortCutKey = 'Shift+Ctrl+T';
        //         ApplicationArea = All;

        //         trigger OnAction();
        //         begin
        //             //BC Upgrade KAPOOV01 Drink-IT>>
        //             // <<DITW16.00.00.40 DDR 03/02/2012 #1331
        //             // CurrPage.SAVERECORD;
        //             // COMMIT;
        //             // Rec.CreateFEFOTracking(FALSE);
        //             // CurrPage.UPDATE(FALSE);
        //             //BC Upgrade KAPOOV01 Drink-IT<<
        //         end;
        //     }
        //     action("SSCC Tracking Lines")
        //     {
        //         CaptionML = ENU = 'SSCC Tracking Lines',
        //                     FRA = 'Lignes Traçabilité SSCC';
        //         Image = ItemTrackingLines;
        //         ApplicationArea = All;

        //         trigger OnAction();
        //         begin
        //             // <<DITW15.00.00.38 DDR 26/11/2010 #1139
        //             //OpenSSCCTrackingLines(FALSE);//BC Upgrade KAPOOV01 Drink-IT

        //         end;
        //     }
        // }
        // addafter("Bin Contents")
        // {
        //     action("&Losses")
        //     {
        //         CaptionML = ENU = '&Losses',
        //                     FRA = '&Pertes';
        //         Image = GainLossEntries;
        //         ApplicationArea = All;

        //         trigger OnAction();
        //         begin
        //             // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //             //OpenLossBreakdownLines;//BC Upgrade KAPOOV01 Drink-IT
        //             CurrPage.UPDATE;
        //             // >>DITW19.00.08 DDR BL#10443
        //         end;
        //     }
        // action("Quality Tests")
        // {
        //     CaptionML = ENU = 'Quality Tests',
        //                 FRA = 'Tests qualité';
        //     Image = TaskQualityMeasure;

        // RunObject = Page 2035112;
        // RunPageLink = Source Type=CONST(83),
        //               Source Subtype=FIELD(Entry Type),
        //               Source ID=FIELD(Journal Template Name),
        //               Source Batch Name=FIELD(Journal Batch Name),
        //               Source Ref. No.=FIELD(Line No.),
        //               Item No.=FIELD(Item No.);
        // RunPageView = SORTING(Source ID,Source Type,Source Subtype,Source Batch Name,Source Prod. Order Line,Source Ref. No.);
        //}
        //}
        //BC Upgrade KAPOOV01 Drink-IT<<

        //addfirst(ActionContainer1900000004) //BC Upgrade KAPOOV01
        addfirst(processing) //BC Upgrade KAPOOV01 renamed actioncontainer name.
        {
            //group()//BC Upgrade KAPOOV01 
            group(Line)//BC Upgrade KAPOOV01 
            {
                action("Split Prod. Journal lines")
                {
                    CaptionML = ENU = 'Split Prod. Journal lines', FRA = 'Valider et i&mprimer';
                    Image = Splitlines;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        HeinekenGlobal: Codeunit "Heineken Global";
                    begin
                        //HEI.09>>
                        HeinekenGlobal.SplitPordOrderItemJNL(Rec, xRec);
                        //HEI.09<<
                    end;
                }

                //BC Upgrade KAPOOV01 Drink-IT>>
                // action("+ Expand")
                // {
                //     CaptionML = ENU = '+ Expand',
                //                 FRA = '+ Développer';
                //     Enabled = (NOT ExpandLines);
                //     Image = ViewDetails;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     Visible = (NOT ExpandLines) OR ShowButtonsCE;
                //     ApplicationArea = All;

                //     trigger OnAction();
                //     begin
                //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                //         ExpandLines := TRUE;
                //         CurrPage.UPDATE(TRUE);
                //         // >>DITW17.10.03 DDR DIT-770 #541
                //     end;
                // }
                // action("- Collapse")
                // {
                //     CaptionML = ENU = '- Collapse',
                //                 FRA = '- Réduire';
                //     Enabled = ExpandLines;
                //     Image = ViewDetails;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     Visible = ExpandLines OR ShowButtonsCE;
                //     ApplicationArea = All;

                //     trigger OnAction();
                //     begin
                //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                //         ExpandLines := FALSE;
                //         CurrPage.UPDATE(TRUE);
                //         // >>DITW17.10.03 DDR DIT-770 #541
                //     end;
                // }
                //BC Upgrade KAPOOV01 Drink-IT<<

            }
        }
        addafter("&Print")
        {
            //BC Upgrade KAPOOV01 Drink-IT>>
            // group("F&unctions")
            // {
            //     CaptionML = ENU = 'F&unctions',
            //                 FRA = 'Fonction&s';
            //     separator()
            //     {
            //     }
            //     action("&Insert Item Charges")
            //     {
            //         CaptionML = ENU = '&Insert Item Charges',
            //                     FRA = '&Inserer Frais Annexes';
            //         Image = TaxSetup;
            //         ShortCutKey = 'Ctrl+Y';

            //         trigger OnAction();
            //         begin
            //             // <<DITW15.00.00.37 DDR 19/01/2010
            //             InsertExtendedCharges(TRUE);
            //         end;
            //     }
            //     separator()
            //     {
            //     }
            //     action("&Automatic FEFO Tracking for journal")
            //     {
            //         CaptionML = ENU = '&Automatic FEFO Tracking for journal',
            //                     FRA = 'Traçabilité Automatique pour Feuille';
            //         Description = '#1331';
            //         Image = ItemTracking;
            //         ShortCutKey = 'Shift+Ctrl+F';

            //         trigger OnAction();
            //         begin
            //             // <<DITW16.00.00.40 DDR 03/02/2012 #1331
            //             CurrPage.SAVERECORD;
            //             COMMIT;
            //             //Rec.CreateFEFOTrackingJournal(FALSE);//BC Upgrade KAPOOV01 Drink-IT
            //             CurrPage.UPDATE(FALSE);
            //         end;
            //     }
            // }
            //BC Upgrade KAPOOV01 Drink-IT<<
        }
        addafter("Post and &Print")
        {
            //action("Split Prod. Journal lines")  //BC Upgrade KAPOOV01 commented her and defined below with name-Split Prod. Journal lines1.
            action("Split Prod. Journal lines1")   //BC Upgrade KAPOOV01 Renamed action-Split Prod. Journal lines to Split Prod. Journal lines1 as it is defined twice as part of HNK customization.

            {
                CaptionML = ENU = 'Split Prod. Journal lines',
                            FRA = 'Valider et i&mprimer';
                Image = Splitlines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //HEI.09>>
                    IF Rec."Entry Type" <> Rec."Entry Type"::Output THEN
                        HeinekenGlobal.SplitPordOrderItemJNL(Rec, xRec)
                    ELSE
                        ERROR(Error01);
                    //HEI.09<<
                end;
            }
        }
        //BC Upgrade KAPOOV01 Created new actions Post_HNK & Post and &Print_HNK>>
        addbefore("Split Prod. Journal lines")
        {
            action(Post_HNK)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'P&ost', FRA = '&Valider';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    //HeinekenGlobal.ValidateNegativeConsumptionQty(Rec);  // HEI.05 NAIKH01   //DEFECT 1931
                    //HEI.12>>
                    //HEI.11>>
                    //AllowJNLPosting := HeinekenGlobal.CheckToallowJNLPosting4CatCodes(Rec);
                    //IF NOT AllowJNLPosting THEN BEGIN
                    //HeinekenGlobal.ValidateNegativeConsumptionQty_New(Rec);  //DEFECT 1931
                    //HEI.08>>
                    //HeinekenGlobal.NegativeConsumptionCatgryCode(Rec);
                    //HEI.08<<
                    //END;
                    //HEI.11<<
                    HeinekenGlobal.NegativeConsumptionCatgryCodeNew(Rec);
                    //HEI.12<<
                    Proceed := Rec.AllowPartialOutput;   // HEI.02 NAIKH01 GAPID001
                    IF Proceed THEN BEGIN   //HEI.02 NAIKH01 GAPID001
                        DeleteTempRec();

                        Rec.PostingItemJnlFromProduction(false);

                        InsertTempRec();

                        SetFilterGroup();
                        CurrPage.Update(false);
                    end;
                END; //NAIKH01 GAPID001
            }

            action("Post and &Print_HNK")
            {
                ApplicationArea = Manufacturing;
                CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
                Promoted = true;
                PromotedIsBig = true;
                Image = PostPrint;
                ShortCutKey = 'Shift+F9';
                ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    Proceed := Rec.AllowPartialOutput;   //NAIKH01 GAPID001 HEI.02
                    IF Proceed THEN BEGIN   //NAIKH01 GAPID001 HEI.02
                        DeleteTempRec();

                        Rec.PostingItemJnlFromProduction(true);

                        InsertTempRec();

                        SetFilterGroup();
                        CurrPage.Update(false);
                    END; //NAIKH01 GAPID001
                end;
            }


        }
        //BC Upgrade KAPOOV01 Created new actions Post_HNK & Post and &Print_HNK<<


        //moveafter("Action 1900000004"; "&Print")//BC Upgrade KAPOOV01 commented this line as Actin-Action 1900000004 doesnot exit in BC Standard so it is giving compilation error.



        //Unsupported feature: PropertyModification on ""&Print"(Action 31).OnAction.ItemJnlLine(Variable 1001)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //"&Print" : "Item Journal Line";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"&Print" : 83;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "OnDeleteRecord.ReserveItemJnlLine(Variable 1000)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //OnDeleteRecord.ReserveItemJnlLine : "Item Jnl. Line-Reserve";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //OnDeleteRecord.ReserveItemJnlLine : 99000835;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "GetCaption(PROCEDURE 3).ObjTransl(Variable 1000)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //GetCaption : "Object Translation";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //GetCaption : 377;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "Item(Variable 1019)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //Item : Item;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Item : 27;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "ProdOrder(Variable 1009)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //ProdOrder : "Production Order";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ProdOrder : 5405;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "ProdOrderLine(Variable 1012)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //ProdOrderLine : "Prod. Order Line";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ProdOrderLine : 5406;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "ProdOrderComp(Variable 1017)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //ProdOrderComp : "Prod. Order Component";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ProdOrderComp : 5407;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "TempItemJrnlLine(Variable 1002)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //TempItemJrnlLine : "Item Journal Line";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //TempItemJrnlLine : 83;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "CostCalcMgt(Variable 1021)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //CostCalcMgt : "Cost Calculation Management";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CostCalcMgt : 5836;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "ReportPrint(Variable 1001)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //ReportPrint : "Test Report-Print";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ReportPrint : 228;
        //Variable type has not been exported.


        //Unsupported feature: PropertyModification on "FlushingFilter(Variable 1003)". Please convert manually.

        //var
        //>>>> ORIGINAL VALUE:
        //FlushingFilter : Manual,Forward,Backward,"Pick + Forward","Pick + Backward","All Methods";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //FlushingFilter : Manual,Forward,Backward,Pick + Forward,Pick + Backward,All Methods;
        //Variable type has not been exported.
    }
    var
        //QualityManagement : Codeunit "2035090";//BC Upgrade KAPOOV01 Drink-IT
        LotNo: Code[20];
        //QualitySetup: Record "2035095";//BC Upgrade KAPOOV01 Drink-IT

        ManufacturingSetup: Record 99000765;
        xRecRef: RecordRef;
        GenBusPostingGroupEditable: Boolean;
        GenProdPostingGroupEditable: Boolean;
        LotNocolor: Boolean;
        LotNoText: Text[1024];
        SerialNo: Code[20];
        SerialNocolor: Boolean;
        SerialNoText: Text[1024];
        "Item No.Editable": Boolean;
        "Item Charge No.Editable": Boolean;
        "AAD No.Editable": Boolean;
        "AAD No. SeriesEditable": Boolean;
        "Item DTax Group CodeEditable": Boolean;
        CompanyTaxRegistrationNoEditab: Boolean;
        "Tariff No.Editable": Boolean;
        "Item Charge No.Enable": Boolean;
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserSetupMgt: Codeunit 5700;
        GlobalTax1ValueEditable: Boolean;
        GlobalTax2ValueEditable: Boolean;
        ItemJnlLine: Record 83;
        WorkCenter: Record 99000754;
        UserSetup: Record 91;
        TEXT001: Text;
        ActualConOutput: Decimal;
        ItemledgEntry: Record 32;
        Proceed: Boolean;
        SetConsmptQty2NonEditable: Boolean;
        HeinekenGlobal: Codeunit 50015;
        LineNo1: Integer;
        LineNo2: Integer;
        ReservEntry: Record 337;
        ItemJnlLine1: Record 83;
        SelectedItemTracking: Boolean;
        AllowJNLPosting: Boolean;
        Error01: Label 'Entry type should be Consumption.';


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetActTimeAndQtyBase;

    ControlsMngt;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
    SETFILTER("Resp. Center Table Filter",
      UserSetupMgt.GetRespCenterFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserSetupMgt.GetRespPhysLocationFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserSetupMgt.GetRespLocationFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1189

    #1..3

    // <<DITW15.00.00.37 DDR 19/01/2010
    UpdateFields();
    // >>DITW15.00.00.37 DDR
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ActualScrapQtyHideValue := false;
    ActualOutputQtyHideValue := false;
    ActualRunTimeHideValue := false;
    ActualSetupTimeHideValue := false;
    ActualConsumpQtyHideValue := false;
    ScrapQuantityHideValue := false;
    OutputQuantityHideValue := false;
    RunTimeHideValue := false;
    SetupTimeHideValue := false;
    QuantityHideValue := false;
    DescriptionIndent := 0;
    ShowShortcutDimCode(ShortcutDimCode);
    DescriptionOnFormat;
    QuantityOnFormat;
    SetupTimeOnFormat;
    RunTimeOnFormat;
    OutputQuantityOnFormat;
    ScrapQuantityOnFormat;
    ActualConsumpQtyOnFormat;
    ActualSetupTimeOnFormat;
    ActualRunTimeOnFormat;
    ActualOutputQtyOnFormat;
    ActualScrapQtyOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    ActualScrapQtyHideValue := FALSE;
    ActualOutputQtyHideValue := FALSE;
    ActualRunTimeHideValue := FALSE;
    ActualSetupTimeHideValue := FALSE;
    ActualConsumpQtyHideValue := FALSE;
    ScrapQuantityHideValue := FALSE;
    OutputQuantityHideValue := FALSE;
    RunTimeHideValue := FALSE;
    SetupTimeHideValue := FALSE;
    QuantityHideValue := FALSE;
    #11..23
    //<<QXL9.00.001 DAT 23/03/2016
    IF QualitySetup.READPERMISSION AND ("Item Charge No." = '') THEN BEGIN
      LotNo := QualityManagement.GetItemJnlLineLotNo(Rec);
      SerialNo := QualityManagement.GetItemJnlLineSerialNo(Rec);
    END ELSE BEGIN
      LotNo := '';
      SerialNo := '';
    END;
    LotNoText := FORMAT(LotNo);
    LotNoTextOnFormat(LotNoText);
    SerialNoText := FORMAT(SerialNo);
    SerialNoTextOnFormat(SerialNoText);
    //>>QXL9.00.001 DAT 23/03/2016

    //<<HEI.07
    IF NOT SelectedItemTracking THEN BEGIN
      IF (LineNo1 = 1) OR (LineNo2 = "Line No.") THEN BEGIN
        ItemJnlLine1.RESET;
        ItemJnlLine1.SETRANGE("Document No.",Rec."Document No.");
        ItemJnlLine1.SETRANGE("Item No.","Item No.");
        ItemJnlLine1.SETRANGE("Location Code","Location Code");
        ItemJnlLine1.SETRANGE("Line No.","Line No.");
          IF ItemJnlLine1.FINDFIRST THEN BEGIN
            LineNo1 :=0;
            LineNo2 := "Line No.";
              IF LotNo <> '' THEN BEGIN
                LotNo := 'REQUIRED';
                LotNoText := FORMAT(LotNo);
                LotNoTextOnFormat(LotNoText);

                DeleteLotNo(Rec);
              END;
          END;
      END;
    END;
    //>> HEI.07
    //HEI.02>>
    ActualConOutput :=0;
    ItemledgEntry.RESET;
    ItemledgEntry.SETRANGE("Item No.",Rec."Item No.");
    ItemledgEntry.SETRANGE("Order No.",Rec."Document No.");
    ItemledgEntry.SETRANGE("Prod. Order Comp. Line No.",Rec."Prod. Order Comp. Line No.");

    //IF "Entry Type" = "Entry Type"::Consumption THEN
      //ItemledgEntry.SETRANGE("Lot No.",Rec."Lot No.");

    IF ItemledgEntry.FINDSET THEN
      REPEAT
        BEGIN
          IF "Entry Type" = "Entry Type"::Output THEN
            ActualConOutput += ItemledgEntry.Quantity
          ELSE
            ActualConOutput += -ItemledgEntry.Quantity;
        END;
      UNTIL ItemledgEntry.NEXT=0;
    //HEI.02<<
    //HEI.04>>
    IF "Flushing Method" = "Flushing Method"::Backward THEN
      QuantityEditable := FALSE;
    //HEI.0041<<
    */
    //end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    COMMIT;
    if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
      exit(false);
    ReserveItemJnlLine.DeleteLine(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW16.00.00.37 DDR 20/07/2010
    //COMMIT;
    //IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
    //  EXIT(FALSE);
    //ReserveItemJnlLine.DeleteLine(Rec);
    // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    EXIT(TriggerOnDeleteRecord());
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    EXIT(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AppliesFromEntryEditable := true;
    QuantityEditable := true;
    OutputQuantityEditable := true;
    ScrapQuantityEditable := true;
    ScrapCodeEditable := true;
    FinishedEditable := true;
    WorkShiftCodeEditable := true;
    RunTimeEditable := true;
    SetupTimeEditable := true;
    CapUnitofMeasureCodeEditable := true;
    ConcurrentCapacityEditable := true;
    EndingTimeEditable := true;
    StartingTimeEditable := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    AppliesFromEntryEditable := TRUE;
    QuantityEditable := TRUE;
    OutputQuantityEditable := TRUE;
    ScrapQuantityEditable := TRUE;
    ScrapCodeEditable := TRUE;
    FinishedEditable := TRUE;
    WorkShiftCodeEditable := TRUE;
    RunTimeEditable := TRUE;
    SetupTimeEditable := TRUE;
    CapUnitofMeasureCodeEditable := TRUE;
    ConcurrentCapacityEditable := TRUE;
    EndingTimeEditable := TRUE;
    StartingTimeEditable := TRUE;
    // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    "Item Charge No.Enable" := TRUE;
    "Tariff No.Editable" := TRUE;
    CompanyTaxRegistrationNoEditab := TRUE;
    "Item DTax Group CodeEditable" := TRUE;
    "AAD No.Editable" := TRUE;
    ScrapQuantityEditable := TRUE;
    OutputQuantityEditable := TRUE;
    "Item Charge No.Editable" := TRUE;
    GenProdPostingGroupEditable := TRUE;
    GenBusPostingGroupEditable := TRUE;
    // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    GlobalTax1ValueEditable := TRUE;
    GlobalTax2ValueEditable := TRUE;
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeModification on "OnModifyRecord". Please convert manually.

    //trigger OnModifyRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Changed by User" := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Changed by User" := TRUE;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    IndentLine := 0;
    IF NOT ISEMPTY THEN
      InitLineNo(ExpandLines,BelowxRec);
    // >>DITW17.10.03 DDR DIT-770 #541
    // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    // Move to function TriggerOnNewRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    TriggerOnNewRecord(BelowxRec);
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNextRecord". Please convert manually.

    //trigger OnNextRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    EXIT(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetFilterGroup;

    if ProdOrderLineNo <> 0 then
      ProdOrderLine.GET(ProdOrder.Status,ProdOrder."No.",ProdOrderLineNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    ManufacturingSetup.GET();
    GenBusPostingGroupEditable := ManufacturingSetup."Editable Item Posting Groups";
    GenProdPostingGroupEditable := GenBusPostingGroupEditable;
    // >>DITW15.00.00.35 PRODW14.00.00.08.14

    SetFilterGroup;

    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189-DITW110.00.12 MSF 04/05/2018 NRQ#55899
    FILTERGROUP(2);
    SETFILTER("Responsibility Center",UserSetupMgt.GetProductionTextFilter);
    FILTERGROUP(0);
    // >>DITW18.00.06 DDR DIT-770 #1189-DITW110.00.12 MSF 04/05/2018 NRQ#55899

    IF ProdOrderLineNo <> 0 THEN
      ProdOrderLine.GET(ProdOrder.Status,ProdOrder."No.",ProdOrderLineNo);
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := FALSE;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeModification on "Setup(PROCEDURE 2)". Please convert manually.

    //procedure Setup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ToTemplateName := TemplateName;
    ToBatchName := BatchName;
    ProdOrder := ProductionOrder;
    ProdOrderLineNo := ProdLineNo;
    PostingDate := PostDate;
    xPostingDate := PostingDate;

    FlushingFilter := FlushingFilter::Manual;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    //HEI.04>>
    //FlushingFilter := FlushingFilter::Manual;//OLD
    FlushingFilter := FlushingFilter::"All Methods";
    //HEI.04<<
    */
    //end;


    //Unsupported feature: CodeModification on "GetActTimeAndQtyBase(PROCEDURE 4)". Please convert manually.

    //procedure GetActTimeAndQtyBase();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ActualSetupTime := 0;
    ActualRunTime := 0;
    ActualOutputQty := 0;
    ActualScrapQty := 0;
    ActualConsumpQty := 0;

    if "Qty. per Unit of Measure" = 0 then
      "Qty. per Unit of Measure" := 1;
    if "Qty. per Cap. Unit of Measure" = 0 then
      "Qty. per Cap. Unit of Measure" := 1;

    if Item.GET("Item No.") then
      case "Entry Type" of
        "Entry Type"::Consumption:
          if ProdOrderComp.GET(
               ProdOrder.Status,
               "Order No.",
               "Order Line No.",
               "Prod. Order Comp. Line No.")
          then begin
            ProdOrderComp.CALCFIELDS("Act. Consumption (Qty)"); // Base Unit
            ActualConsumpQty :=
              ProdOrderComp."Act. Consumption (Qty)" / "Qty. per Unit of Measure";
            if Item."Rounding Precision" > 0 then
              ActualConsumpQty := ROUND(ActualConsumpQty,Item."Rounding Precision",'>')
            else
              ActualConsumpQty := ROUND(ActualConsumpQty,0.00001);
          end;
        "Entry Type"::Output:
          begin
            if ProdOrderLineNo = 0 then
              if not ProdOrderLine.GET(ProdOrder.Status,ProdOrder."No.","Order Line No.") then
                CLEAR(ProdOrderLine);
            if ProdOrderLine."Prod. Order No." <> '' then begin
              CostCalcMgt.CalcActTimeAndQtyBase(
                ProdOrderLine,"Operation No.",ActualRunTime,ActualSetupTime,ActualOutputQty,ActualScrapQty);
              ActualSetupTime :=
                ROUND(ActualSetupTime / "Qty. per Cap. Unit of Measure",0.00001);
              ActualRunTime :=
                ROUND(ActualRunTime / "Qty. per Cap. Unit of Measure",0.00001);

              ActualOutputQty := ActualOutputQty / "Qty. per Unit of Measure";
              ActualScrapQty := ActualScrapQty / "Qty. per Unit of Measure";
              if Item."Rounding Precision" > 0 then begin
                ActualOutputQty := ROUND(ActualOutputQty,Item."Rounding Precision",'>');
                ActualScrapQty := ROUND(ActualScrapQty,Item."Rounding Precision",'>');
              end else begin
                ActualOutputQty := ROUND(ActualOutputQty,0.00001);
                ActualScrapQty := ROUND(ActualScrapQty,0.00001);
              end;
            end;
          end;
      end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    IF "Qty. per Unit of Measure" = 0 THEN
      "Qty. per Unit of Measure" := 1;
    IF "Qty. per Cap. Unit of Measure" = 0 THEN
      "Qty. per Cap. Unit of Measure" := 1;

    IF Item.GET("Item No.") THEN
      CASE "Entry Type" OF
        "Entry Type"::Consumption:
          IF ProdOrderComp.GET(
    #16..19
          THEN BEGIN
    #21..23
            IF Item."Rounding Precision" > 0 THEN
              ActualConsumpQty := ROUND(ActualConsumpQty,Item."Rounding Precision",'>')
            ELSE
              ActualConsumpQty := ROUND(ActualConsumpQty,0.00001);
          END;
        "Entry Type"::Output:
          BEGIN
            IF ProdOrderLineNo = 0 THEN
              IF NOT ProdOrderLine.GET(ProdOrder.Status,ProdOrder."No.","Order Line No.") THEN
                CLEAR(ProdOrderLine);
            IF ProdOrderLine."Prod. Order No." <> '' THEN BEGIN
    #35..43
              IF Item."Rounding Precision" > 0 THEN BEGIN
                ActualOutputQty := ROUND(ActualOutputQty,Item."Rounding Precision",'>');
                ActualScrapQty := ROUND(ActualScrapQty,Item."Rounding Precision",'>');
              END ELSE BEGIN
                ActualOutputQty := ROUND(ActualOutputQty,0.00001);
                ActualScrapQty := ROUND(ActualScrapQty,0.00001);
              END;
            END;
          END;
      END;
    */
    //end;


    //Unsupported feature: CodeModification on "ControlsMngt(PROCEDURE 1)". Please convert manually.

    //procedure ControlsMngt();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ("Entry Type" = "Entry Type"::Output) and
       ("Operation No." <> '')
    then
      OperationExist := true
    else
      OperationExist := false;

    StartingTimeEditable := OperationExist;
    EndingTimeEditable := OperationExist;
    #10..13
    WorkShiftCodeEditable := OperationExist;

    FinishedEditable := "Entry Type" = "Entry Type"::Output;
    ScrapCodeEditable := "Entry Type" = "Entry Type"::Output;
    ScrapQuantityEditable := "Entry Type" = "Entry Type"::Output;
    OutputQuantityEditable := "Entry Type" = "Entry Type"::Output;

    QuantityEditable := "Entry Type" = "Entry Type"::Consumption;
    AppliesFromEntryEditable := "Entry Type" = "Entry Type"::Consumption;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ("Entry Type" = "Entry Type"::Output) AND
       ("Operation No." <> '')
    THEN
      OperationExist := TRUE
    ELSE
      OperationExist := FALSE;
    #7..16
    // <<DITW19.00.08 DDR 29/09/2016 BL#10443
    //"Scrap CodeEditable" := "Entry Type" = "Entry Type"::Output;
    //"Scrap QuantityEditable" := "Entry Type" = "Entry Type"::Output;
    // >>DITW19.00.08 DDR BL#10443
    OutputQuantityEditable := "Entry Type" = "Entry Type"::Output;

    //HEI.04>>
    IF "Flushing Method" <> "Flushing Method"::Backward THEN
    //HEI.04<<
    QuantityEditable := "Entry Type" = "Entry Type"::Consumption;
    AppliesFromEntryEditable := "Entry Type" = "Entry Type"::Consumption;
    */
    //end;


    //Unsupported feature: CodeModification on "DeleteRecTemp(PROCEDURE 6)". Please convert manually.

    //procedure DeleteRecTemp();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TempItemJrnlLine.DELETEALL;

    if FIND('-') then
      repeat
        case "Entry Type" of
          "Entry Type"::Consumption:
            if "Quantity (Base)" = 0 then begin
              TempItemJrnlLine := Rec;
              TempItemJrnlLine.INSERT;

              DELETE;
            end;
          "Entry Type"::Output:
            if TimeIsEmpty and
               ("Output Quantity (Base)" = 0) and ("Scrap Quantity (Base)" = 0)
            then begin
              TempItemJrnlLine := Rec;
              TempItemJrnlLine.INSERT;

              DELETE;
            end;
        end;
      until NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TempItemJrnlLine.DELETEALL;

    IF FIND('-') THEN
      REPEAT
        CASE "Entry Type" OF
          "Entry Type"::Consumption:
            IF "Quantity (Base)" = 0 THEN BEGIN
    #8..11
            END;
          "Entry Type"::Output:
            IF TimeIsEmpty AND
               ("Output Quantity (Base)" = 0) AND ("Scrap Quantity (Base)" = 0)
            THEN BEGIN
    #17..20
            END;
        END;
      UNTIL NEXT = 0;
    */
    //end;


    //Unsupported feature: CodeModification on "InsertTempRec(PROCEDURE 7)". Please convert manually.

    //procedure InsertTempRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if TempItemJrnlLine.FIND('-') then
      repeat
        Rec := TempItemJrnlLine;
        "Changed by User" := false;
        INSERT;
      until TempItemJrnlLine.NEXT = 0;
    TempItemJrnlLine.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF TempItemJrnlLine.FIND('-') THEN
      REPEAT
        Rec := TempItemJrnlLine;
        "Changed by User" := FALSE;
        INSERT;
      UNTIL TempItemJrnlLine.NEXT = 0;
    TempItemJrnlLine.DELETEALL;
    */
    //end;


    //Unsupported feature: CodeModification on "SetFilterGroup(PROCEDURE 5)". Please convert manually.

    //procedure SetFilterGroup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FILTERGROUP(2);
    SETRANGE("Journal Template Name",ToTemplateName);
    SETRANGE("Journal Batch Name",ToBatchName);
    SETRANGE("Order Type","Order Type"::Production);
    SETRANGE("Order No.",ProdOrder."No.");
    if ProdOrderLineNo <> 0 then
      SETRANGE("Order Line No.",ProdOrderLineNo);
    SetFlushingFilter;
    FILTERGROUP(0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    IF ProdOrderLineNo <> 0 THEN
    #7..9
    */
    //end;


    //Unsupported feature: CodeModification on "SetFlushingFilter(PROCEDURE 8)". Please convert manually.

    //procedure SetFlushingFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if FlushingFilter <> FlushingFilter::"All Methods" then
      SETRANGE("Flushing Method",FlushingFilter)
    else
      SETRANGE("Flushing Method");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.04>>
    CASE FlushingFilter OF
      FlushingFilter::"All Methods":
        SETRANGE("Flushing Method");
      FlushingFilter::Backward:
        //SETRANGE("Flushing Method",FlushingFilter::Forward);//old
        SETRANGE("Flushing Method",FlushingFilter::Backward);
      FlushingFilter::Forward:
        //SETRANGE("Flushing Method",FlushingFilter::Manual);//old
        SETRANGE("Flushing Method",FlushingFilter::Forward);
      FlushingFilter::Manual:
          //SETRANGE("Flushing Method",FlushingFilter::"All Methods");//old code
        SETRANGE("Flushing Method",FlushingFilter::Manual);
      FlushingFilter::"Pick + Backward":
          //SETRANGE("Flushing Method",FlushingFilter::"Pick + Forward");//old
          SETRANGE("Flushing Method",FlushingFilter::"Pick + Backward");
      FlushingFilter::"Pick + Forward":
          //SETRANGE("Flushing Method",FlushingFilter::Backward);//old
          SETRANGE("Flushing Method",FlushingFilter::"Pick + Forward");
      END;
        {//OLD changes
      IF FlushingFilter <> FlushingFilter::"All Methods" THEN
        SETRANGE("Flushing Method")
      ELSE
        SETRANGE("Flushing Method",FlushingFilter);}
    //HEI.04>>
    */
    //end;


    //Unsupported feature: CodeModification on "GetCaption(PROCEDURE 3)". Please convert manually.

    //procedure GetCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,5405);
    if ProdOrderLineNo <> 0 then
      Descrip := ProdOrderLine.Description
    else
      Descrip := ProdOrder.Description;

    exit(STRSUBSTNO('%1 %2 %3',SourceTableName,ProdOrder."No.",Descrip));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table,5405);
    IF ProdOrderLineNo <> 0 THEN
      Descrip := ProdOrderLine.Description
    ELSE
      Descrip := ProdOrder.Description;

    EXIT(STRSUBSTNO('%1 %2 %3',SourceTableName,ProdOrder."No.",Descrip));
    */
    //end;


    //Unsupported feature: CodeModification on "PostingDateOnAfterValidate(PROCEDURE 19003005)". Please convert manually.

    //procedure PostingDateOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if PostingDate = 0D then
      PostingDate := xPostingDate;

    if PostingDate <> xPostingDate then begin
      MODIFYALL("Posting Date",PostingDate);
      xPostingDate := PostingDate;
      CurrPage.UPDATE(false);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF PostingDate = 0D THEN
      PostingDate := xPostingDate;

    IF PostingDate <> xPostingDate THEN BEGIN
      MODIFYALL("Posting Date",PostingDate);
      xPostingDate := PostingDate;
      CurrPage.UPDATE(FALSE);
    END;
    */
    //end;


    //Unsupported feature: CodeModification on "FlushingFilterOnAfterValidate(PROCEDURE 19064520)". Please convert manually.

    //procedure FlushingFilterOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetFilterGroup;
    CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetFilterGroup;
    CurrPage.UPDATE(FALSE);
    */
    //end;


    //Unsupported feature: CodeModification on "DescriptionOnFormat(PROCEDURE 19023855)". Please convert manually.

    //procedure DescriptionOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DescriptionIndent := Level;
    if "Entry Type" = "Entry Type"::Output then
      DescriptionEmphasize := 'Strong'
    else
      DescriptionEmphasize := '';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DescriptionIndent := Level;
    IF "Entry Type" = "Entry Type"::Output THEN
      DescriptionEmphasize := 'Strong'
    ELSE
      DescriptionEmphasize := '';
    */
    //end;


    //Unsupported feature: CodeModification on "QuantityOnFormat(PROCEDURE 19071269)". Please convert manually.

    //procedure QuantityOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Entry Type" = "Entry Type"::Output then
      QuantityHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Entry Type" = "Entry Type"::Output THEN
      QuantityHideValue := TRUE;
    */
    //end;


    //Unsupported feature: CodeModification on "SetupTimeOnFormat(PROCEDURE 19007490)". Please convert manually.

    //procedure SetupTimeOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ("Entry Type" = "Entry Type"::Consumption) or
       ("Operation No." = '')
    then
      SetupTimeHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ("Entry Type" = "Entry Type"::Consumption) OR
       ("Operation No." = '')
    THEN
      SetupTimeHideValue := TRUE;
    */
    //end;


    //Unsupported feature: CodeModification on "RunTimeOnFormat(PROCEDURE 19059514)". Please convert manually.

    //procedure RunTimeOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ("Entry Type" = "Entry Type"::Consumption) or
       ("Operation No." = '')
    then
      RunTimeHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ("Entry Type" = "Entry Type"::Consumption) OR
       ("Operation No." = '')
    THEN
      RunTimeHideValue := TRUE;
    */
    //end;


    //Unsupported feature: CodeModification on "OutputQuantityOnFormat(PROCEDURE 19003029)". Please convert manually.

    //procedure OutputQuantityOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Entry Type" = "Entry Type"::Consumption then
      OutputQuantityHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Entry Type" = "Entry Type"::Consumption THEN
      OutputQuantityHideValue := TRUE;
    */
    //end;


    //Unsupported feature: CodeModification on "ScrapQuantityOnFormat(PROCEDURE 19017313)". Please convert manually.

    //procedure ScrapQuantityOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Entry Type" = "Entry Type"::Consumption then
      ScrapQuantityHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW19.00.08 DDR 29/09/2016 BL#10443
    //IF "Entry Type" = "Entry Type"::Consumption THEN
    //  ScrapQuantityHideValue := TRUE;
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeModification on "ActualConsumpQtyOnFormat(PROCEDURE 19012702)". Please convert manually.

    //procedure ActualConsumpQtyOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Entry Type" = "Entry Type"::Output then
      ActualConsumpQtyHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Entry Type" = "Entry Type"::Output THEN
      ActualConsumpQtyHideValue := TRUE;
    */
    //end;


    //Unsupported feature: CodeModification on "ActualSetupTimeOnFormat(PROCEDURE 19031665)". Please convert manually.

    //procedure ActualSetupTimeOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ("Entry Type" = "Entry Type"::Consumption) or
       ("Operation No." = '')
    then
      ActualSetupTimeHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ("Entry Type" = "Entry Type"::Consumption) OR
       ("Operation No." = '')
    THEN
      ActualSetupTimeHideValue := TRUE;
    */
    //end;


    //Unsupported feature: CodeModification on "ActualRunTimeOnFormat(PROCEDURE 19024131)". Please convert manually.

    //procedure ActualRunTimeOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ("Entry Type" = "Entry Type"::Consumption) or
       ("Operation No." = '')
    then
      ActualRunTimeHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ("Entry Type" = "Entry Type"::Consumption) OR
       ("Operation No." = '')
    THEN
      ActualRunTimeHideValue := TRUE;
    */
    //end;


    //Unsupported feature: CodeModification on "ActualOutputQtyOnFormat(PROCEDURE 19059076)". Please convert manually.

    //procedure ActualOutputQtyOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Entry Type" = "Entry Type"::Consumption then
      ActualOutputQtyHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Entry Type" = "Entry Type"::Consumption THEN
      ActualOutputQtyHideValue := TRUE;
    */
    //end;


    //Unsupported feature: CodeModification on "ActualScrapQtyOnFormat(PROCEDURE 19036240)". Please convert manually.

    //procedure ActualScrapQtyOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Entry Type" = "Entry Type"::Consumption then
      ActualScrapQtyHideValue := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW19.00.08 DDR 29/09/2016 BL#10443
    //IF "Entry Type" = "Entry Type"::Consumption THEN
    //  ActualScrapQtyHideValue := TRUE;
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;
    //BC Upgrade KAPOOV01 Drink-IT>>
    // local procedure DocumentNoOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure ItemNoOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure ItemChargeNoOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure VariantCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure QuantityOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure UnitofMeasureCodeOnAfterValida();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure LocationCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure BinCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure CapUnitofMeasureCodeOnAfterVal();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure ScrapCodeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure OutputQuantityOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure ScrapQuantityOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure DocumentDateOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.25 DDR 24/10/2008
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.25 DDR
    // end;

    // local procedure ActualOutputQtyOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure ActualScrapQtyOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF Rec."Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // procedure InsertExtendedCharges(FromHeader: Boolean);
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     //IF Rec.InsertChargeLines(FromHeader) THEN //BC Upgrade KAPOOV01 Drink-IT
    //     CurrPage.UPDATE(TRUE);
    // end;

    // local procedure UpdateFields();
    // var
    //     CollapsedLine: Boolean;
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010 - DITW15.00.00.38 DDR 16/07/2010 #1194
    //     // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    //     CollapsedLine := NOT ExpandLines;
    //     // >>DITW17.10.03 DDR DIT-770 #541
    //     "Item No.Editable" := FormEditableField(FIELDNO("Item No."));
    //     // <<DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 - DITW17.00.01 DDR 10/12/2012 DIT-770 #001
    //     "Item Charge No.Editable" := FALSE;
    //     "Item Charge No.Enable" := FALSE;
    //     // >>DITW16.00.00.38 DDR DIT-715 #1
    //     OutputQuantityEditable := FormEditableField(FIELDNO("Output Quantity"));
    //     ScrapQuantityEditable := FormEditableField(FIELDNO("Scrap Quantity"));
    //     // <<DITW15.00.00.37 DDR 29/01/2010
    //     "AAD No.Editable" := FormEditableField(FIELDNO("AAD No."));
    //     "AAD No. SeriesEditable" := FormEditableField(FIELDNO("AAD No. Series"));
    //     "Item DTax Group CodeEditable" := FormEditableField(FIELDNO("Item DTax Group Code"));
    //     CompanyTaxRegistrationNoEditab := FormEditableField(FIELDNO("Company Tax Registration No."));
    //     "Tariff No.Editable" := FormEditableField(FIELDNO("Tariff No."));
    //     // >>DITW15.00.00.37 DDR
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code") AND NOT "Is Item Charge";
    //     GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code") AND NOT "Is Item Charge";
    //     // >>DITW19.00.08 DDR BL#10443
    // end;

    // local procedure TriggerOnDeleteRecord(): Boolean;
    // var
    // //ReserveItemJnlLine : Codeunit "99000835";//BC Upgrade KAPOOV01 Codeunit
    // begin
    //     // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
    //     COMMIT;
    //     IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
    //         EXIT(FALSE);
    //     // <<QXL9.00.001 DAT 23/03/2016
    //     IF QualitySetup.READPERMISSION THEN BEGIN
    //         IF NOT QualityManagement.DeleteItemJnlLineConfirm(Rec) THEN
    //             EXIT(FALSE);
    //     END;
    //     // >>QXL9.00.001 DAT 23/03/2016
    //     ReserveItemJnlLine.DeleteLine(Rec);
    //     // <<QXL9.00.001 DAT 23/03/2016
    //     IF QualitySetup.READPERMISSION THEN
    //         QualityManagement.DeleteItemJnlLine(Rec);
    //     // >>QXL9.00.001 DAT 23/03/2016

    //     EXIT(TRUE);
    // end;

    // procedure TriggerOnNewRecord(BelowxRec: Boolean): Boolean;
    // begin
    //     // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    //     INIT;
    //     // >>DITW16.00.00.38 DDR DIT-715 #50
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     LotNoText := '';
    //     // >>DITW19.00.08 DDR BL#10443
    //     // <<DITW15.00.00.35 DDR 19/10/2009
    //     FILTERGROUP(2);
    //     IF GETFILTER("Journal Template Name") <> '' THEN
    //         "Journal Template Name" := GETFILTER("Journal Template Name");
    //     IF GETFILTER("Journal Batch Name") <> '' THEN
    //         "Journal Batch Name" := GETFILTER("Journal Batch Name");
    //     FILTERGROUP(0);
    //     // >>DITW15.00.00.35 DDR

    //     SetUpNewLine(xRec);
    //     VALIDATE("Entry Type", "Entry Type"::Output);
    //     CLEAR(ShortcutDimCode);
    //     // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
    //     LotNo := '';
    //     // >>DITW15.00.00.22 PRODW14.00.00.08 DDR

    //     // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    //     EXIT(TRUE);
    //     // >>DITW16.00.00.38 DDR DIT-715 #50
    // end;

    // local procedure EntryTypeOnAfterValidate();
    // begin
    //     // <<DITW15.00.00.37 DDR 19/01/2010
    //     IF "Line No." <> 0 THEN
    //         CurrPage.UPDATE(TRUE);
    //     // >>DITW15.00.00.37 DDR
    // end;

    // local procedure LotNoTextOnFormat(var Text: Text[1024]);
    // begin
    //     // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    //     IF ((Quantity = 0) AND ("Output Quantity" = 0)) OR ("Item Charge No." <> '') OR ("Item No." = '') THEN BEGIN
    //         LotNocolor := FALSE;
    //         Text := '';
    //         EXIT;
    //     END;
    //     // >>DITW19.00.08 DDR BL#10443
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     IF QualitySetup.READPERMISSION AND ("Item Charge No." = '') THEN BEGIN
    //         CALCFIELDS("Lot Reserved Qty. (Base)");
    //         //<<DITW111.00.13 MSF 13/12/2018 NRQ#94671
    //         LotNocolor := QualityManagement.IsRequired(Text) OR ((ABS("Quantity (Base)") - ABS("Lot Reserved Qty. (Base)") > 0) AND ("Lot Reserved Qty. (Base)" <> 0));
    //         //>>DITW111.00.13 MSF 06/12/2018 NRQ#94671-DITW111.00.13 MSF 13/12/2018 NRQ#94671
    //     END;
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // local procedure SerialNoTextOnFormat(var Text: Text[1024]);
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     IF QualitySetup.READPERMISSION AND ("Item Charge No." = '') THEN BEGIN
    //         SerialNocolor := QualityManagement.IsRequired(Text);
    //     END;
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;
    //BC Upgrade KAPOOV01 Drink-IT<<
    local procedure DeleteLotNo(Rec: Record 83);
    begin
        //<<HEI.07
        ReservEntry.RESET;
        ReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Item No.", "Source Batch Name", "Location Code", "Source Type", "Source Subtype");
        ReservEntry.SETRANGE("Source ID", Rec."Journal Template Name");
        ReservEntry.SETRANGE("Source Ref. No.", Rec."Line No.");
        ReservEntry.SETRANGE("Item No.", Rec."Item No.");
        ReservEntry.SETRANGE("Source Batch Name", Rec."Journal Batch Name");
        ReservEntry.SETRANGE("Location Code", Rec."Location Code");
        ReservEntry.SETRANGE("Source Type", 83);
        //HEI.10>>
        //ReservEntry.SETRANGE("Source Subtype",5);
        ReservEntry.SETFILTER("Source Subtype", '%1|%2', 5, 6);
        //HEI.10<<
        IF ReservEntry.FINDSET THEN
            REPEAT
                ReservEntry.DELETE;
            UNTIL ReservEntry.NEXT = 0;

        //>> HEI.07
    end;
    //BC Upgrade KAPOOV01>>
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        //<<HEI.07
        IF NOT SelectedItemTracking THEN BEGIN
            IF (LineNo1 = 1) OR (LineNo2 = Rec."Line No.") THEN BEGIN
                ItemJnlLine1.RESET;
                ItemJnlLine1.SETRANGE("Document No.", Rec."Document No.");
                ItemJnlLine1.SETRANGE("Item No.", Rec."Item No.");
                ItemJnlLine1.SETRANGE("Location Code", Rec."Location Code");
                ItemJnlLine1.SETRANGE("Line No.", Rec."Line No.");
                IF ItemJnlLine1.FINDFIRST THEN BEGIN
                    LineNo1 := 0;
                    LineNo2 := Rec."Line No.";
                    IF LotNo <> '' THEN BEGIN
                        LotNo := 'REQUIRED';
                        LotNoText := FORMAT(LotNo);
                        //LotNoTextOnFormat(LotNoText);//BC Upgrade KAPOOV01 Drink-IT

                        DeleteLotNo(Rec);
                    END;
                END;
            END;
        END;
        //>> HEI.07
        //HEI.02>>
        ActualConOutput := 0;
        ItemledgEntry.RESET;
        ItemledgEntry.SETRANGE("Item No.", Rec."Item No.");
        ItemledgEntry.SETRANGE("Order No.", Rec."Document No.");
        ItemledgEntry.SETRANGE("Prod. Order Comp. Line No.", Rec."Prod. Order Comp. Line No.");

        //IF "Entry Type" = "Entry Type"::Consumption THEN
        //ItemledgEntry.SETRANGE("Lot No.",Rec."Lot No.");

        IF ItemledgEntry.FINDSET THEN
            REPEAT
            BEGIN
                IF Rec."Entry Type" = Rec."Entry Type"::Output THEN
                    ActualConOutput += ItemledgEntry.Quantity
                ELSE
                    ActualConOutput += -ItemledgEntry.Quantity;
            END;
            UNTIL ItemledgEntry.NEXT = 0;
        //HEI.02<<
        //HEI.04>>
        IF Rec."Flushing Method" = "Flushing Method"::Backward THEN
            QuantityEditable := FALSE;
        //HEI.0041<<
    end;
    //BC Upgrade KAPOOV01<<

    //BC Upgrade KAPOOV01 Added Code on Trigger-OnAfterGetCurrRecord() to take HEI.04 Tag Customization inside function-ControlsMngt()>>
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        //HEI.04>>
        IF Rec."Flushing Method" <> "Flushing Method"::Backward THEN
            //HEI.04<<
            QuantityEditable := Rec."Entry Type" = Rec."Entry Type"::Consumption; //BC Upgrade KAPOOV01 
    end;
    //BC Upgrade KAPOOV01 Added Code on Trigger-OnAfterGetCurrRecord() to take HEI.04 Tag Customization inside function-ControlsMngt()<<

    //BC Upgrade KAPOOV01>>
    trigger OnOpenPage()
    var
    begin
        Rec.SetCurrentKey("Entry Type", "Item No.", "Variant Code", "Location Code", "Bin Code", "Posting Date"); //BC Upgrade KAPOOV01 to take HEI.06 Tag modification where SourceTableView property of Base page is modified to -> "SourceTableView = SORTING(Entry Type,Item No.,Variant Code,Location Code,Bin Code,Posting Date) ORDER(Ascending)".
        Rec.Ascending(true); //BC Upgrade KAPOOV01 set sorting order - Ascending as SourceTableView property is modified in Base Page under Tag-HEI.06.
    end;

    //BC Upgrade KAPOOV01<<


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

