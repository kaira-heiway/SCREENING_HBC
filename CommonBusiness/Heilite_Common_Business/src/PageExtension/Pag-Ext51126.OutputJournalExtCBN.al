pageextension 51126 OutputJournalExtCBN extends "Output Journal"
{
    // version NAVW110.0,FINXL7.00,QXL9.00.001,DITW110.00.09,HEI.01

    //     DITW14.00.00.8 PROD: BrewIt & Quality
    // DITW15.00.00.31-PRODW14.00.00.08.10 DLE 13/02/2009 License problem
    // DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //                                issue 768 Added to set non-editable fields
    //                                  "Gen. Bus. Posting Group","Gen. Prod. Posting Group","Inventory Posting Group"
    // DITW15.00.00.37 DDR 19/01/2010 Added Item charges (expand/collapse)
    //                     29/01/2010 issue 1054 Added fields
    //                                  "AAD No. Series","ADD No.",
    //                                  "Tariff No.","item DTax Group Code","Company Tax Registration No."
    //                     20/05/2010 issue 1081 Added fields "Physical Location Group Code"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.38 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 CEL 13/08/2010           Modification RTC buttons
    //                 DDR 17/08/2010           Remove OnFormat() field "Item No."
    //                 DDR 20/01/2011 DIT-715 #50 RTC bugfix trigger OnModifyTrigger' test to call function ActionInsertAutoBlankLine()
    // DITW15.00.00.38-PRODW14.00.00.17 DDR 14/12/2010 issue 1127 Bugfix don't show Lot column if item tracking line is not required (Produ
    //                                                            Replaced static text Lot required by call function IsRequired()
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                             Modified "Item Charge No." as non-editable (function UpdateFields)
    //                     02/03/2011 DIT-715 #50 RTC Page functionnalities
    //                                             Added/Moved OnNewRecord trigger into TriggerOnNewRecord() function
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                             Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                             Modified order position RTC buttons
    //                                               contol1102601007 RTCNewLine
    //                                               contol1102601008 RTCDeleteLine
    //                                               contol1102601009 RTCDleteAllLines
    // DITW16.00.00.39 PRODW14.00.00.08.18 DDR 19/07/2011 DIT-715 #73
    //                                            License: Modified OnFormat() column "LotNo"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                              Added to insert first line automatically
    //                                              Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 DDR 26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194 Bugfix to insert the first <blank> line while opening the empty journal
    //                                             Bugfix RTC to call the c/al when OpenedFromBatch variable is true
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."
    //                     12/06/2012 DIT-715 #310 Added to keep the Document No. on new record (line)
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 12/07/2013 DIT-770 #105 Bugfix lost Template/Batch filters while opening page
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.03 DDR 07/04/2014 DIT-770 #559 (old DIT-770 214) Bugfix standard Expand-Collapse (ShowAsTree property) workaround
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1189 Multisite - Added field "Responsibility Center"
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Look&Feel minor correction
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Added fields "Exist Loss Breakdown"
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed 'Editable' property for fields "strength Spec. Value","vol-strength Spec. Value"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #Add field "Zone Code"
    // DITW110.00.12 MSF 04/05/2018 NRQ#55899 Resp. centre with Phys. Location group and Location code gives conflict - part 3
    // HEI.02 CHG2129985 IBM.LS      21.02.2022
    //   # Added Field - Expiration Date

    layout
    {
        modify(CurrentJnlBatchName)
        {
            CaptionML = ENU = 'Batch Name', FRA = 'Nom de la feuille';
            ToolTipML = ENU = 'Specifies the name of the journal batch of the output journal.', FRA = 'Spécifie le nom de la feuille sortie.';
        }

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date for the entry.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("Order No.")
        {
            ToolTipML = ENU = 'Specifies the number of the order that created the entry.', FRA = 'Spécifie le numéro de la commande qui a créé l''écriture.';
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
        modify("Order Line No.")
        {
            ToolTipML = ENU = 'Specifies the line number of the order that created the entry.', FRA = 'Spécifie le numéro de ligne ayant créé l''écriture.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the journal type, which is either Work Center or Machine Center.', FRA = 'Indique le type de feuille, à savoir Centre de charge ou Poste de charge.';
            //OptionCaptionML = ENU = 'Work Center,Machine Center', FRA = 'Centre de charge,Poste de charge';
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
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the item on the line.', FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';

            //Unsupported feature: Change Editable on ""Unit Cost"(Control 88)". Please convert manually.

        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the inventory location where the item on the journal line will be registered.', FRA = 'Spécifie le code du magasin où l''article de la ligne feuille sera enregistré.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies a bin code for the item.', FRA = 'Spécifie un code emplacement pour l''article.';
        }
        modify("Scrap Code")
        {
            ToolTipML = ENU = 'Specifies the scrap code.', FRA = 'Spécifie le code rebut.';

            //Unsupported feature: Change Editable on ""Scrap Code"(Control 112)". Please convert manually.

        }
        modify("Output Quantity")
        {
            ToolTipML = ENU = 'Specifies the quantity of the produced item that can be posted as output on the journal line.', FRA = 'Spécifie la quantité produite de l''article pouvant être validée en production dans la ligne feuille.';

            //Unsupported feature: Change Editable on ""Output Quantity"(Control 126)". Please convert manually.

        }
        modify("Scrap Quantity")
        {
            ToolTipML = ENU = 'Specifies the number of units produced incorrectly, and therefore cannot be used.', FRA = 'Indique le nombre d''unités produites qui comportent des défauts et qui ne peuvent donc pas être utilisées.';

            //Unsupported feature: Change Visible on ""Scrap Quantity"(Control 128)". Please convert manually.


            //Unsupported feature: Change Editable on ""Scrap Quantity"(Control 128)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the code if you have filled in the Sales Unit of Measure field on the item card.', FRA = 'Spécifie le code si vous avez renseigné le champ Unité de vente de la fiche article.';
        }
        modify(Finished)
        {
            ToolTipML = ENU = 'Specifies that the operation represented by the output journal line is finished.', FRA = 'Spécifie que l''opération représentée par la ligne feuille production est terminée.';
        }
        modify("Applies-to Entry")
        {
            ToolTipML = ENU = 'Specifies if the quantity in the item journal line should be applied to an already-posted document.', FRA = 'Spécifie si la quantité dans la ligne feuille article doit être lettrée dans un document déjà validé.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date on the document that provides the basis for the entry on the item journal line.', FRA = 'Spécifie la date du document qui est utilisé comme document de base pour l''écriture de la ligne feuille article.';
        }
        modify("External Document No.")
        {
            ToolTipML = ENU = 'Specifies a document number referring to the customer or vendor numbering system with whom you are trading items on this journal line.', FRA = 'Spécifie un numéro de document qui se réfère au programme de numérotation du client ou du fournisseur avec lequel vous traitez pour les articles de cette ligne feuille.';
        }
        modify("Prod. Order Name")
        {
            CaptionML = ENU = 'Prod. Order Name', FRA = 'Nom O.F.';
        }
        modify(Operation)
        {
            CaptionML = ENU = 'Operation', FRA = 'Opération';
        }
        modify(OperationName)
        {
            CaptionML = ENU = 'Operation', FRA = 'Opération';
            ToolTipML = ENU = 'Specifies the abbreviated task description.', FRA = 'Spécifie la description de tâche abrégée.';
        }

        //Unsupported feature: CodeInsertion on ""Posting Date"(Control 66)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        PostingDateOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Document No."(Control 2)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        DocumentNoOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Item No."(Control 14)". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
        if AssistEditItemTreeview("Item No.") then begin
          // validate trigger
          ShowShortcutDimCode(ShortcutDimCode);
          // aftervalidate trigger
          CurrPage.UPDATE(true);
        end else
          CurrPage.UPDATE(false);
        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
        */
        //end;


        //Unsupported feature: CodeModification on ""Item No."(Control 14).OnLookup". Please convert manually.

        //trigger "(Control 14)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        LookupItemNo;
        ShowShortcutDimCode(ShortcutDimCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        LookupItemNo;
        ShowShortcutDimCode(ShortcutDimCode);
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Item No." <> '' then
          CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Item No."(Control 14).OnValidate". Please convert manually.

        //trigger "(Control 14)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        ItemNoOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Variant Code"(Control 5)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        VariantCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Cap. Unit of Measure Code"(Control 3)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        CapUnitofMeasureCodeOnAfterVal;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit Cost"(Control 88)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitCostOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 100)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        LocationCodeOnAfterValidate;
        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 DDR DIT-770 #1189
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Bin Code"(Control 28)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        BinCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Scrap Code"(Control 112)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ScrapCodeOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Output Quantity"(Control 126)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        OutputQuantityOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Scrap Quantity"(Control 128)". Please convert manually.

        //trigger OnAssistEdit();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        OpenLossBreakdownLines;
        CurrPage.UPDATE;
        // >>DITW19.00.08 DDR BL#10443
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Scrap Quantity"(Control 128)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        ScrapQuantityOnAfterValidate;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit of Measure Code"(Control 26)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        UnitofMeasureCodeOnAfterValida;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Document Date"(Control 134)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        DocumentDateOnAfterValidate;
        */
        //end;

        addfirst(Control1)
        {
            /* //Bc Upgrade YADAVM09 Drink it field Commented>>
            field("Has Item Charge";"Has Item Charge")
            {
                BlankZero = true;
            }
            field(Collapse;Collapse)
            {
                Visible = false;

                trigger OnValidate();
                begin
                    // <<DITW15.00.00.37 DDR 19/01/2010
                    CurrPage.UPDATE(true);
                    // >>DITW15.00.00.37 DDR
                end;
            }
            */ //Bc Upgrade YADAVM09 Drink ir field Commented>>
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the journal line.';
            }
        }
        addafter("Posting Date")
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
        }
        /* //Bc Upgrade YADAVM09 Drink it field Commented>>
        addafter("Item No.")
        {
            field("Item Charge No."; Rec."Item Charge No.")
            {
                Editable = "Item Charge No.Editable";
                Enabled = "Item Charge No.Enable";
                Visible = false;

                trigger OnValidate();
                begin
                    ItemChargeNoOnAfterValidate;
                end;
            }
        }
        
      addafter("Unit Cost")
      {
          field("Responsibility Center"; "Responsibility Center")
          {
              Visible = false;

              trigger OnValidate();
              begin
                  // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
                  if "Responsibility Center" <> xRec."Responsibility Center" then
                      CurrPage.UPDATE(true);
                  // >>DITW18.00.06 DDR DIT-770 #1189
              end;
          }
          field("Physical Location Group Code"; "Physical Location Group Code")
          {
              Visible = false;

              trigger OnValidate();
              begin
                  // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
                  if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                      CurrPage.UPDATE(true);
                  // >>DITW18.00.06 DDR DIT-770 #1189
              end;
          }
      }
      */ //Bc Upgrade YADAVM09 Drink it field Commented<<
        addafter("Location Code")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
        }
        /* Bc Upgrade YADAVM09 Drink it field Commented>>
        addafter("Scrap Quantity")
        {
            field("Exist Loss Breakdown"; "Exist Loss Breakdown")
            {
                Visible = false;
            }
        }
        
        addafter("Output Quantity")
        {
            field(LotNo; LotNoText)
            {
                CaptionML = ENU = 'Lot No.',
                            FRA = 'N° lot';
                Editable = false;
                Style = Attention;
                StyleExpr = LotNocolor;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    //<<QXL9.00.001 DAT 23/03/2016
                    OpenItemTrackingLines(false);
                    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                    if QualitySetup.READPERMISSION and ("Item Charge No." = '') then begin
                        // >>DITW19.00.08 DDR BL#10443
                        LotNo := QualityManagement.GetItemJnlLineLotNo(Rec);
                        //>>QXL9.00.001 DAT 23/03/2016
                        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                        CurrPage.UPDATE;
                    end;
                    // >>DITW19.00.08 DDR BL#10443
                end;
            }
        }
        addafter(Finished)
        {
            field(RTCTotalLine; GetTotalingLine(1, FIELDNO(Amount), true))
            {
                AutoFormatType = 1;
                BlankZero = true;
                CaptionML = ENU = 'Total Amount',
                            FRA = 'Montant total';
                Description = 'DITW17.10.02B DIT-770 #541';
                Editable = false;
                QuickEntry = false;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field Commented<<
        addafter("Applies-to Entry")
        {
            /* //Bc Upgrade YADAVM09 Drink it field Commented>>
           field("Due Tax"; Rec."Due Tax")
           {
               Visible = false;
           }
           field("Duty Suspended"; "Duty Suspended")
           {
               Visible = false;
           }
           field("Item DTax Group Code"; "Item DTax Group Code")
           {
               Editable = "Item DTax Group CodeEditable";
               Visible = false;
           }
           field("Company Tax Registration No."; "Company Tax Registration No.")
           {
               Editable = CompanyTaxRegistrationNoEditab;
               Visible = false;
           }
           field("Strength Spec. Code"; "Strength Spec. Code")
           {
               Editable = false;
           }
           field("AverageStrengthReserv(FIELDNO(""Strength Spec. Value""))"; AverageStrengthReserv(FIELDNO("Strength Spec. Value")))
           {
               AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
               AutoFormatType = 2013664;
               CaptionClass = GetTaxSpecCaption(1, FIELDNO("Strength Spec. Value"));
               CaptionML = ENU = 'Strength Spec. Value',
                           FRA = 'Valeur contrainte spécification';
               Editable = false;
               Visible = false;

               trigger OnDrillDown();
               begin
                   // <<DITW19.00.08 DDR 20/10/2016 BL#10443
                   DrilldownReservEntryVS(FIELDNO("Strength Spec. Value"));
               end;
           }
           field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
           {
               Editable = false;
               Visible = false;
           }
           field("SumVolStrengthReserv(FIELDNO(""Vol-Strength Spec. Value""))"; SumVolStrengthReserv(FIELDNO("Vol-Strength Spec. Value")))
           {
               AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
               AutoFormatType = 2013664;
               CaptionClass = GetTaxSpecCaption(1, FIELDNO("Vol-Strength Spec. Value"));
               CaptionML = ENU = 'Vol-Strength Spec. Value',
                           FRA = 'Valeur spécification contrainte volume';
               Editable = false;
               Visible = false;

               trigger OnDrillDown();
               begin
                   // <<DITW19.00.08 DDR 20/10/2016 BL#10443
                   DrilldownReservEntryVS(FIELDNO("Vol-Strength Spec. Value"));
               end;
           }
           field("Unit Volume HL"; "Unit Volume HL")
           {
               Editable = false;
               Visible = false;
           }
           field("Tariff No."; "Tariff No.")
           {
               Editable = "Tariff No.Editable";
               Visible = false;
           }
           field("AAD No. Series"; "AAD No. Series")
           {
               Editable = "AAD No. SeriesEditable";
               Visible = false;
           }
           field("AAD No."; "AAD No.")
           {
               Editable = "AAD No.Editable";
               Visible = false;
           }
            

            field("Expiration Date"; Rec."Expiration Date")
            {
            }
            */ //Bc Upgrade YADAVM09 Drink it field Commented<<

        }

        moveafter("Scrap Code"; "Scrap Quantity")
        moveafter(Finished; "Document Date")
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
        modify("Bin Contents")
        {
            CaptionML = ENU = 'Bin Contents', FRA = 'Contenu emplacement';
            Promoted = true;
            PromotedCategory = Process;
        }
        modify("Pro&d. Order")
        {
            CaptionML = ENU = 'Pro&d. Order', FRA = '&O.F.';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';
        }
        modify("Ledger E&ntries")
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';
        }
        modify("Item Ledger E&ntries")
        {
            CaptionML = ENU = 'Item Ledger E&ntries', FRA = 'É&critures comptables article';
        }
        modify("Capacity Ledger Entries")
        {
            CaptionML = ENU = 'Capacity Ledger Entries', FRA = 'Écritures comptables capacité';
        }
        modify("Value Entries")
        {
            CaptionML = ENU = 'Value Entries', FRA = 'Écritures valeur';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Explode &Routing")
        {
            CaptionML = ENU = 'Explode &Routing', FRA = '&Eclater gamme';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        /* //Bc Upgrade YADAVM09 Drink it field Commented>>
        addfirst("&Line")
        {
            separator(Separator1100083204)
            {
            }
        }
       
                addafter("Bin Contents")
                {

                    action("&Losses")
                    {
                        CaptionML = ENU = '&Losses',
                                    FRA = '&Pertes';
                        Image = GainLossEntries;

                        trigger OnAction();
                        begin
                            // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                            OpenLossBreakdownLines;
                            CurrPage.UPDATE;
                            // >>DITW19.00.08 DDR BL#10443
                        end;
                    }

                    action("Quality Tests")
                    {
                        CaptionML = ENU = 'Quality Tests',
                                    FRA = 'Tests qualité';
                        Image = TaskQualityMeasure;
                        RunObject = Page "Quality Test List";
                        RunPageLink = "Source Type" = CONST(83),
                                      "Source Subtype" = FIELD("Entry Type"),
                                      "Source ID" = FIELD("Journal Template Name"),
                                      "Source Batch Name" = FIELD("Journal Batch Name"),
                                      "Source Ref. No." = FIELD("Line No."),
                                      "Item No." = FIELD("Item No.");
                        RunPageView = sorting("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                    }
                    separator(Separator1100066001)
                    {
                    }
                    action("<Action1161021002>")
                    {
                        CaptionML = ENU = 'Show N-owm activities',
                                    FRA = 'Afficher activitées N-omw';
                        Description = 'DIT-715 #806';

                        trigger OnAction();
                        var
                            OWMUtils: Codeunit "N-owm Utils";
                        begin
                            OWMUtils.ShowActivityStatus(OWMUtils.ActProdOutput, "Document No.", "Location Code");
                            //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                        end;
                    }
                }
                
        addfirst(ActionContainer1900000004)
        {
            group(ActionGroup1100910008)
            {
                action("+ Expand")
                {
                    CaptionML = ENU = '+ Expand',
                                FRA = '+ Etendre';
                    Enabled = (NOT ExpandLines);
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = (NOT ExpandLines) OR ShowButtonsCE;

                    trigger OnAction();
                    begin
                        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                        ExpandLines := true;
                        CurrPage.UPDATE(true);
                        // >>DITW17.10.03 DDR DIT-770 #541
                    end;
                }
                
                action("- Collapse")
                {
                    CaptionML = ENU = '- Collapse',
                                FRA = '- Réduire';
                    Enabled = ExpandLines;
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = ExpandLines OR ShowButtonsCE;

                    trigger OnAction();
                    begin
                        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                        ExpandLines := false;
                        CurrPage.UPDATE(true);
                        // >>DITW17.10.03 DDR DIT-770 #541
                    end;
                }
              
            }
              
    }
        
        addafter("Explode &Routing")
        {
            separator(Separator1100083008)
            {
            }
            action("&Insert Item Charges")
            {
                CaptionML = ENU = '&Insert Item Charges',
                            FRA = '&Insérer Frais annexes';
                Image = TaxSetup;
                ShortCutKey = 'Ctrl+Y';

                trigger OnAction();
                begin
                    // <<DITW15.00.00.37 DDR 19/01/2010
                    InsertExtendedCharges(true);
                end;
            }
           
    }
     */ //Bc Upgrade YADAVM09 Drink it field Commented<<
    }

    var
        //QualitySetup: Record "Quality Setup";//Bc Upgrade YADAVM09 Drink it Table
        ManufacturingSetup: Record "Manufacturing Setup";
        UserSetupMgt: Codeunit "User Setup Management";
        xRecRef: RecordRef;

        "AAD No.Editable": Boolean;

        "AAD No. SeriesEditable": Boolean;

        CompanyTaxRegistrationNoEditab: Boolean;

        ExpandLines: Boolean;

        GenBusPostingGroupEditable: Boolean;

        GenProdPostingGroupEditable: Boolean;

        GlobalTax1ValueEditable: Boolean;

        GlobalTax2ValueEditable: Boolean;

        "Item Charge No.Editable": Boolean;

        "Item Charge No.Enable": Boolean;

        "Item DTax Group CodeEditable": Boolean;

        "Item No.Editable": Boolean;

        LotNocolor: Boolean;

        "Output QuantityEditable": Boolean;

        "Scrap CodeEditable": Boolean;

        "Scrap QuantityEditable": Boolean;

        ShowButtonsCE: Boolean;

        "Tariff No.Editable": Boolean;

        "Unit CostEditable": Boolean;
        //QualityManagement: Codeunit "Quality Management";//Bc Upgrade YADAVM09 Drink it Table
        LotNo: Code[20];
        IndentLine: Integer;

        LotNoText: Text[1024];


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemJnlMgt.GetOutput(Rec,ProdOrderDescription,OperationName);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemJnlMgt.GetOutput(Rec,ProdOrderDescription,OperationName);
    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189
    SETFILTER("Resp. Center Table Filter",
      UserSetupMgt.GetRespCenterFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",
      UserSetupMgt.GetRespPhysLocationFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",
      UserSetupMgt.GetRespLocationFilter(EntryTypeToRespID,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 DDR DIT-770 #1189
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
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541
    ShowShortcutDimCode(ShortcutDimCode);
    //<<QXL9.00.001 DAT 23/03/2016
    if QualitySetup.READPERMISSION and ("Item Charge No." = '') then
      LotNo := QualityManagement.GetItemJnlLineLotNo(Rec)
    else
      LotNo := '';
    LotNoText := FORMAT(LotNo);
    LotNoTextOnFormat(LotNoText);
    //>>QXL9.00.001 DAT 23/03/2016
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
    exit(TriggerOnDeleteRecord());
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 DIT-715 #1
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(FIND(Which));
    exit(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    // >>DITW16.00.00.37 DIT-715 #1
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW16.00.00.37 DIT-715 #1
    "Item Charge No.Enable" := true;
    "Tariff No.Editable" := true;
    CompanyTaxRegistrationNoEditab := true;
    "Item DTax Group CodeEditable" := true;
    "AAD No.Editable" := true;
    "Unit CostEditable" := true;
    // <<DITW19.00.08 DDR 29/09/2016 BL#10443
    "Scrap CodeEditable" := true;
    // >>DITW19.00.08 DDR BL#10443
    "Scrap QuantityEditable" := true;
    "Output QuantityEditable" := true;
    "Item Charge No.Editable" := true;
    "Item No.Editable" := true;
    GenProdPostingGroupEditable := true;
    GenBusPostingGroupEditable := true;
    // >>DITW16.00.00.37 DIT-715 #1
    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    GlobalTax1ValueEditable := true;
    GlobalTax2ValueEditable := true;
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetUpNewLine(xRec);
    VALIDATE("Entry Type","Entry Type"::Output);
    CLEAR(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    IndentLine := 0;
    if not ISEMPTY then
      InitLineNo(ExpandLines,BelowxRec);
    // >>DITW17.10.03 DDR DIT-770 #541
    // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
    //SetUpNewLine(xRec);
    //VALIDATE("Entry Type","Entry Type"::Output);
    //CLEAR(ShortcutDimCode);
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
    // <<DITW16.00.00.37 DIT-715 #1
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //EXIT(NEXT(Steps));
    exit(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    // >>DITW16.00.00.37 DIT-715 #1
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsOpenedFromBatch then begin
      CurrentJnlBatchName := "Journal Batch Name";
      ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
      exit;
    end;
    ItemJnlMgt.TemplateSelection(PAGE::"Output Journal",5,false,Rec,JnlSelected);
    if not JnlSelected then
      ERROR('');
    ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
      // to run all custom C/AL into this trigger
      //EXIT;
    //end;
    end else begin
    // >>DITW16.00.00.40 DDR DIT-715 #194
      ItemJnlMgt.TemplateSelection(PAGE::"Output Journal",5,false,Rec,JnlSelected);
      if not JnlSelected then
        ERROR('');
      ItemJnlMgt.OpenJnl(CurrentJnlBatchName,Rec);
    // <<DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194
    end;
    // >>DITW16.00.00.40 DDR DIT-715 #194

    // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1189-DITW110.00.12 MSF 04/05/2018 NRQ#55899
    FILTERGROUP(2);
    SETFILTER("Responsibility Center",UserSetupMgt.GetProductionTextFilter);
    FILTERGROUP(0);
    // >>DITW18.00.06 DDR DIT-770 #1189-DITW110.00.12 MSF 04/05/2018 NRQ#55899

    // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    if ManufacturingSetup.GET() then begin
      GenBusPostingGroupEditable := ManufacturingSetup."Editable Item Posting Groups";
      GenProdPostingGroupEditable := GenBusPostingGroupEditable;
    end;
    // >>DITW15.00.00.35 PRODW14.00.00.08.14
    // <<DITW17.00.01 DDR 12/03/2013 DIT-770 #001
    if "Journal Template Name" = '' then
      "Journal Template Name" := GETRANGEMAX("Journal Template Name");
    if "Journal Batch Name" = '' then
      "Journal Batch Name" := GETRANGEMAX("Journal Batch Name");
    // >>DITW17.00.01 DDR DIT-770 #001
    // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
    if not ISEMPTY then
      FINDLAST;
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := false;
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;

    /* //Bc Upgrade YADAVM09 Drink it function commented>>
        procedure InsertExtendedCharges(FromHeader: Boolean);
        begin
            // <<DITW15.00.00.37 DDR 19/01/2010
            if InsertChargeLines(FromHeader) then
                CurrPage.UPDATE(true);
        end;
        

    local procedure UpdateFields();
    var
        CollapsedLine: Boolean;
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010 - DITW15.00.00.38 DDR 16/07/2010 #1194
        // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
        CollapsedLine := not ExpandLines;
        // >>DITW17.10.03 DDR DIT-770 #541
        "Item No.Editable" := FormEditableField(FIELDNO("Item No."));
        // <<DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 - DITW17.00.01 DDR 10/12/2012 DIT-770 #001
        "Item Charge No.Editable" := false;
        "Item Charge No.Enable" := false;
        // >>DITW16.00.00.38 DDR DIT-715 #1
        "Output QuantityEditable" := FormEditableField(FIELDNO("Output Quantity"));
        // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        "Scrap CodeEditable" := FormEditableField(FIELDNO("Scrap Code"));
        ;
        // >>DITW19.00.08 DDR BL#10443
        "Scrap QuantityEditable" := FormEditableField(FIELDNO("Scrap Quantity"));
        "Unit CostEditable" := FormEditableField(FIELDNO("Unit Cost")) and not CollapsedLine;
        // <<DITW15.00.00.37 DDR 29/01/2010
        "AAD No.Editable" := FormEditableField(FIELDNO("AAD No."));
        "AAD No. SeriesEditable" := FormEditableField(FIELDNO("AAD No. Series"));
        "Item DTax Group CodeEditable" := FormEditableField(FIELDNO("Item DTax Group Code"));
        CompanyTaxRegistrationNoEditab := FormEditableField(FIELDNO("Company Tax Registration No."));
        "Tariff No.Editable" := FormEditableField(FIELDNO("Tariff No."));
        // >>DITW15.00.00.37 DDR
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code") and not "Is Item Charge";
        GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code") and not "Is Item Charge";
        // >>DITW19.00.08 DDR BL#10443
    end;

    procedure TriggerOnDeleteRecord(): Boolean;
    var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
        COMMIT;
        if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
            exit(false);
        // <<DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010
        if QualitySetup.READPERMISSION then begin
            if not QualityManagement.DeleteItemJnlLineConfirm(Rec) then
                exit(false);
        end;
        // >>DITW15.00.00.37 PRODW14.00.00.16 DDR
        ReserveItemJnlLine.DeleteLine(Rec);
        // <<DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010
        if QualitySetup.READPERMISSION then
            QualityManagement.DeleteItemJnlLine(Rec);
        // >>DITW15.00.00.37 PRODW14.00.00.16 DDR

        exit(true);
    end;

    procedure TriggerOnNewRecord(BelowxRec: Boolean): Boolean;
    begin
        // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
        INIT;
        // >>DITW16.00.00.38 DDR DIT-715 #50
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        LotNoText := '';
        // >>DITW19.00.08 DDR BL#10443
        // <<DITW15.00.00.35 DDR 19/10/2009
        FILTERGROUP(2);
        if GETFILTER("Journal Template Name") <> '' then
            "Journal Template Name" := GETFILTER("Journal Template Name");
        if GETFILTER("Journal Batch Name") <> '' then
            "Journal Batch Name" := GETFILTER("Journal Batch Name");
        // <<DITW16.00.00.40 DDR 12/06/2012 DIT-715 #310
        if GETFILTER("Document No.") <> '' then
            EVALUATE("Document No.", GETFILTER("Document No."));
        // >>DITW16.00.00.40 DDR DIT-715 #310
        FILTERGROUP(0);
        // >>DITW15.00.00.35 DDR
        SetUpNewLine(xRec);
        // <<DITW16.00.00.40 DDR 12/06/2012 DIT-715 #310
        if "Document No." = '' then
            "Document No." := xRec."Document No.";
        // >>DITW16.00.00.40 DDR DIT-715 #310
        VALIDATE("Entry Type", "Entry Type"::Output);
        CLEAR(ShortcutDimCode);
        // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
        LotNo := '';
        // >>DITW15.00.00.22 PRODW14.00.00.08 DDR

        // <<DITW16.00.00.38 DDR 02/03/2011 DIT-715 #50
        exit(true);
        // >>DITW16.00.00.38 DDR DIT-715 #50
    end;

    local procedure PostingDateOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure DocumentNoOnAfterValidate();
    begin
        // <<DITW15.00.00.25 DDR 24/10/2008
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.25 DDR
    end;

    local procedure ItemNoOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure ItemChargeNoOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure VariantCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure CapUnitofMeasureCodeOnAfterVal();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure UnitCostOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if xRec."Unit Cost" <> "Unit Cost" then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure LocationCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure BinCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure ScrapCodeOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure OutputQuantityOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure ScrapQuantityOnAfterValidate();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure UnitofMeasureCodeOnAfterValida();
    begin
        // <<DITW15.00.00.37 DDR 19/01/2010
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.37 DDR
    end;

    local procedure DocumentDateOnAfterValidate();
    begin
        // <<DITW15.00.00.25 DDR 24/10/2008
        if "Line No." <> 0 then
            CurrPage.UPDATE(true);
        // >>DITW15.00.00.25 DDR
    end;

    local procedure LotNoTextOnFormat(var Text: Text[1024]);
    begin
        // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        if ((Quantity = 0) and ("Output Quantity" = 0)) or ("Item Charge No." <> '') or ("Item No." = '') then begin
            LotNocolor := false;
            Text := '';
            exit;
        end;
        // >>DITW19.00.08 DDR BL#10443
        //<<QXL9.00.001 DAT 23/03/2016
        if QualitySetup.READPERMISSION and ("Item Charge No." = '') then begin
            LotNocolor := QualityManagement.IsRequired(Text);
        end;
        //>>QXL9.00.001 DAT 23/03/2016
    end;
    */ //Bc Upgrade YADAVM09 Drink it function commented<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

