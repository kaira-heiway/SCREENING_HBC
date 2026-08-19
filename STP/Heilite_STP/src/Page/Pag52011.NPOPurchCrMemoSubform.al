page 52011 "NPO Purch. Cr. Memo Subform"
{
    // version NAVW110.0,FINXL10.01,QXL9.00.001,DITW110.00.11,HEI.08
    //BC UPGRADE SIVA Old Page ID 50103

    // DITW15.00.00.01 DDR 18/12/2007 Integration VC8 Item Charges add-ons
    // DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Tax Item Charges functionnalities
    // DITW15.00.00.01 DDR 02/01/2007 Added column "Line No." (not editable)
    //                                Bugfix AutoSplitKey process on new record with Collapse/Expand functionnality
    // DITW15.00.00.01 DDR 04/01/2008 Added Drink-it Deposit Item Charges functionnalities
    // DITW15.00.00.01 DDR 10/01/2008 Bugfix using F8 on new line
    //                                Change property HorzAlign=Right for collapsed total fields (line amount)
    //                                Added parameter BlankZero for function UpdateFormatField()
    //                                Remove ProcessTaxItemCharge();ProcessUpdateUnitPrice();InsertTaxItemCharge();
    // DITW15.00.00.01 DDR 23/01/2008 Added Drink-it Discount & Promotion Item Charges functionnalities
    //                                Added field "Collapse"
    //                                Bugfix Refresh columns
    //                                Added function UpdateExpandStatus
    //                                Change function UpdateFields for Discount & Promotion
    // DITW15.00.00.01 DDR 15/02/2008 Added function UpdateFormatField()
    // DITW15.00.00.01 DDR 19/03/2008 move function InsertExtendedCharges()
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 26/03/2008 Remove (move into function) confirm message from function InsertExtendedCharges()
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.23 DDR 29/07/2008 Remove call function InsertExtendedCharges() from trigger OnAfterValidate field "No."
    //                                Updated function into InsertExtendedCharges()
    //                     31/07/2008 Move NewRecord() function into OnNewRecord trigger
    // DITW15.00.00.30 DDR 08/01/2009 Modified function UpdateFormatField()
    // DITW15.00.00.32 DDR 23/03/2009 Added fields  (not editable)
    //                                  "Empty Goods Item No."
    // DITW15.00.00.33 DDR 12/05/2009 Bugfix function UpdateFields()
    // DITW15.00.00.35 DDR 25/06/2009 issue 669 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free item"
    //                     21/08/2009 issue 727 Added HorzAlign property in field "Direct Unit Cost"
    //                 DDR 14/10/2009 issue 893 Removed fields "Gen. Prod. Posting Free Group"
    // DITW15.00.00.36 DDR 04/11/2009 issue 939 Performance SQL
    //                                Added function FormTotalingField()
    // DITW15.00.00.37 DDR 26/01/2009 issue 939 Performance SQL error call function into OnModify() trigger
    // DITW15.00.00.37 DDR 11/05/2010 issue 1061 Added field "Physical Location Group Code"
    //                     01/06/2010 issue 959 Added field "AAD No. Series"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    //                     17/12/2010 issue 703 Replaced "Empty Goods Item No." -> Column "Tracking Item No." (on item charges)
    //                     27/01/2011 issue 1259 Added update() on field "Cross-Reference No."
    //                                           Added non-editable when item is (free) item charge
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #61 RTC Upgrade & Performances
    //                                           Added parameter line function RTCActionNewLine() into RTCNewLine button
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                             Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                             Modified order position RTC buttons
    //                                               contol1102601007 RTCNewLine
    //                                               contol1102601008 RTCDeleteLine
    //                                               contol1102601009 RTCDleteAllLines
    //                     15/03/2011 issue 1217 (DIT711 163) Added EMCS fields
    //                                               "LRN No. Series","SAD No."
    //                     15/03/2011 issue 1291 Modified trigger field "No." activate function InsertExtendedText() other than items
    //                     16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 DDR 26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                     26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added field "Allow VAT Calculation (Free)"
    //                     11/01/2012 DIT-715 issue 197 RTC Bugfixing to print any report while existing expand/collapse lines
    //                                                  Added function SetDisableRefreshLines() to call before/after each report object
    //                                                 (don't use the <RunObject> property)
    //                     03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                             Modified OnAssistEdit trigger field "No."
    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added to call function SetFilterSubContractPostType() on AfterGetCurrRecord();
    //                                             Added to call function SetFilterSubContractPostType2() on OnNewRecord()
    //                                             Added fields "DIT Sub-Contract Type","Service Contract No.""Contract Group Code"
    //                 AHU 06/11/2012 DIT-715 #393 Added "Description 2" field
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added functions OpenSSCCTrackingLines()
    // 
    // FINXL7.00 RBE 20/03/2013: Added fields "Tariff No." & "Net Weight" (not visible)
    //                               Added field: "Auto. Acc. Group"
    // 
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             added approved prod group + approved line amount
    // DITW17.00.02 SR 12/09/2013 DIT-770 #153 : New Field "Linked Customer No." Added
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW17.10.03 DDR 10/06/2014 DIT-770 #541 Modified 'QuickEntry' property fields "Has Item Charge","Collapse"
    //                                          Removed 'IndentationControls' field1 Group Repeater
    // DITW17.10.03 DDR 10/07/2014 DIT-770 #541 Added editable other types than Item
    // DITW18.00.06 DDR 19/02/2015 DIT-770 #1191 Multisite - Added field "Responsibity Center"
    // DITW17.10.05 MSF 17/07/2014 DIT-770 #698 (Customer)Vendor suspended tax determined per document line + internal taxes
    //                                           Added non-editable fields "Vendor DTax Group Code","Item DTax Group Code"
    // DITW17.10.05 DDR 04/12/2014 DIT-770 #988 Added fields "Total Direct Unit Cost"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //                                          TEMP Disabled Call function UpdateVATAmounts()
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.11 AKH 05/10/2017 NRQ#36842 Changed Visible & Editable properties to FALSE for field "Gen. Prod. Posting Group"
    //                                        Removed field "Gen. Bus. Posting Group"
    // FINXL10.01 MTR 16/08/2017 NRQ#30245: Removed old FINXL code related to "Show Totals on Purch. Inv/CM." setup
    // DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix call function CalcBackDirectCostItem()
    // NRQ175506 NLAB 03/11/2021 Added DITW110.00.11 DDR 10/08/2017 NRQ#24875 Fix (Correctice Change no - CHG2102694)
    // 
    // HEI.01 FDD-PRDGAP031 IBM PATHAA02 09.11.2017
    // # Code on OnAfterGetRecord
    // 
    // HEI.02 FDDPTPGAP080 IBM HORTOC01  19.03.2018
    //  #new function to update payment status
    // HEI.04 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added - "TIN No."
    // HEI.05 HT1292 IBM SHANKJ03 04.27.2020
    //   # Field added "WHT Absorb Base"
    // HEI.06 CHG2090912 HB1641 IBM NANDIS01 01.02.2021 General Ledger Entries Description
    //   # Make visible of new field - "Additional Description"
    // HEI.07 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "CAD Amount"
    //   # Code added on 'OnOpenPage' trigger
    // HEI.08 CHG2224401 HB3624 YADAVM09 01.04.2024 Health and Security Levy Tax
    //   #New field Added #"Levy tax Amount"
    //                    #HS Posting Group
    //************************************************//
    // BC UPGRADE SIVA 8/01/2026
    // SUMMARY OF CHANGES:
    // 1. HEI.01,HEI.04,HEI.05,HEI.06,HEI.08 No changes.
    // 2. HEI.07 Commented CAD related code & fields
    // 2. HEI.02 Procedure UpdatePaymentStatus() Drink IT code linked to Field 2014421_"Document Subtype Code"
    // 3. Commented Drink it specific fields and code.
    // 4. Commented Documenttoal codeunit related Logic &  Added BCHNKCustomFunction codeunit variable & Call TotalCADAmount, TotalCADIncAmount.
    // 5.Item Availability group actions(Event,Period,Location,variant,BOM Level) commented due to Method 'ShowItemAvailFromPurchLine' is marked for removal
    //and Replaced by ShowItemAvailabilityFromPurchLine in Purch. Availability Mgt
    // 6.This CAD related field & code are  commented out due to its dependency on CAD functional logic, which is currently not in scope.
    //  ************************************************//

    // BC Upgrade MISHRS14 >>
    // Blocked the procedure as OpenItemTrackingLines and ShowLineComments is already there in standard table Purchase Line with same name
    // Added Rec. in OnAction trigger of action - "Item &Tracking Lines" and also added Rec. in OnAction trigger of action - "Co&mments"
    // BC Upgrade MISHRS14 <<


    AutoSplitKey = true;
    CaptionML = ENU = 'Lines',
                FRA = 'Lignes';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    ApplicationArea = All;
    SourceTableView = WHERE("Document Type" = FILTER("Credit Memo"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                //BC UPGRADE SIVA >> Drink it Fields
                // field("Has Item Charge"; Rec."Has Item Charge")
                // {
                //     BlankZero = true;
                //     QuickEntry = false;
                // }
                // field(Collapse; Rec.Collapse)
                // {
                //     QuickEntry = false;
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW15.00.00.37 DDR 19/01/2010
                //         CurrPage.UPDATE(true);
                //         // >>DITW15.00.00.37 DDR
                //     end;
                // }
                //BC UPGRADE SIVA << Drink it Fields
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Enabled = true;
                    ToolTipML = ENU = 'Specifies the line type.',
                                FRA = 'Spécifie le type de ligne.';


                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                        //BC UPGRADE SIVA>> Drink IT code 
                        // TypeOnAfterValidate();
                        //NoOnAfterValidate();
                        //BC UPGRADE SIVA<< Drink IT code 

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();

                        //HEI.02>>
                        UpdatePaymentStatus(Rec); //BC Upgrade VAMSIU01 - Code added for Document Subtype
                        if (Rec.Type <> Rec.Type::"G/L Account") and (Rec.Type <> Rec.Type::" ") then
                            ERROR(Text001, Rec.Type)
                        //HEI.02<<
                        //BC UPGRADE SIVA<<
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the number of a general ledger account, an item, an additional cost or a fixed asset, depending on what you selected in the Type field.',
                                FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';

                    trigger OnAssistEdit();
                    begin
                        //BC UPGRADE SIVA >> Drink it Code
                        // <<DITW15.00.00.39 DDR 26/08/2011 #1393 - DITW16.00.00.40 DDR 03/05/2012 DIT-715 #276
                        // if Rec.AssistEditItemTreeview("No.") then begin
                        // validate trigger
                        //     Rec.ShowShortcutDimCode(ShortcutDimCode);
                        // aftervalidate trigger
                        //     CurrPage.UPDATE(true);
                        // end else
                        //     CurrPage.UPDATE(false);
                        // >>DITW15.00.00.39 DDR #1393 - DITW16.00.00.40 DDR DIT-715 #276
                        //BC UPGRADE SIVA << Drink it Code
                    end;

                    trigger OnValidate();
                    begin
                        // <<DITW17.10.03 DDR 10/06/2014 DIT-770 #541
                        // if not ("No.Editable" or "No.Enable") then begin
                        //     Rec."No." := xRec."No.";
                        //     exit;
                        // end;
                        // >>DITW17.10.03 DDR DIT-770 #541
                        // Rec.ShowShortcutDimCode(ShortcutDimCode);
                        // NoOnAfterValidate();
                        // UpdateEditableOnRow();

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();

                        //HEI.02>>
                        UpdatePaymentStatus(Rec);//BC Upgrade VAMSIU01 - Code added for Document Subtype
                        if (Rec.Type <> Rec.Type::"G/L Account") and (Rec.Type <> Rec.Type::" ") then
                            ERROR(Text001, Rec.Type)
                        //HEI.02<<
                    end;
                }
                //BC UPGRADE SIVA >>Drink IT field
                // field("Cross-Reference No."; Rec."Cross-Reference No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = "Cross-Reference No.Editable";
                //     ToolTipML = ENU = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.',
                //                 FRA = 'Spécifie le numéro d''article à référence externe. Si vous saisissez une référence externe entre votre numéro d''article et celui de votre fournisseur ou client, ce numéro remplace le numéro d''article standard lorsque vous saisissez le numéro de référence externe sur un document vente ou achat.';
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         Rec.CrossReferenceNoLookUp;
                //         // <<DITW15.00.00.38 DDR 27/01/2011 #1259
                //         //InsertExtendedText(FALSE);
                //         // >>DITW15.00.00.38 DDR #1259
                //         NoOnAfterValidate();
                //         // <<DITW15.00.00.38 DDR 27/01/2011 #1259
                //         CurrPage.UPDATE();
                //         // >>DITW15.00.00.38 DDR #1259
                //     end;

                //     trigger OnValidate();
                //     begin
                //         CrossReferenceNoOnAfterValidat();
                //         NoOnAfterValidate();
                //     end;
                // }
                //BC UPGRADE SIVA<<

                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the IC partner code of the partner to whom you want to distribute the cost of the line.',
                                FRA = 'Spécifie le code du partenaire IC du partenaire auquel vous voulez répartir le coût de la ligne.';
                    Visible = false;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the item or account in your IC partner''s company that corresponds to the item or account on the line.',
                                FRA = 'Spécifie l''article ou le compte de la société de votre partenaire IC correspondant à l''article ou au compte de la ligne.';
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'If the line is being sent to one of your intercompany partners, this field is used together with the IC Partner Ref. Type field to indicate the item or account in your partner''s company that corresponds to the line.',
                                FRA = 'Si la ligne est en cours d''envoi à l''un de vos partenaires intersociétés, ce champ, associé au champ Type de réf. du partenaire IC, permet d''indiquer l''article ou le compte qui correspond à la ligne dans la société de votre partenaire.';
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a variant code for the item.',
                                FRA = 'Spécifie un code variante pour l''article.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        //VariantCodeOnAfterValidate();//BC UPGRADE SIVA
                    end;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies that this item is a nonstock item.',
                                FRA = 'Spécifie que cet article est non stocké.';
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    applicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                    end;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the code for the VAT product posting group of the item or general ledger account on this line.',
                                FRA = 'Spécifie le code du groupe comptabilisation produit TVA de l''article ou du compte général de la ligne.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                //BC UPGRADE SIVA >> Drink it Code 
                // field("GetTrackingItemNo()";GetTrackingItemNo())
                // {
                //     CaptionML = ENU='Tracking Item No. (Item Charge)',
                //                 FRA='N° article traçable (Frais annexes)';
                //     DrillDownPageID = "Item List";
                //     Editable = false;
                //     LookupPageID = "Item List";
                //     TableRelation = IF ("Item Charge Type"=CONST(Tax)) Item WHERE ("No."=FIELD("Tax Item No."))
                //                     ELSE IF ("Item Charge Type"=CONST(Deposit)) Item WHERE ("No."=FIELD("Empty Goods Item No."));
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         // <<DITW15.00.00.38 DDR 17/12/2010 #703
                //         Text := GetTrackingItemNo();
                //         LookupItemNo(Text);
                //         exit(false);
                //     end;
                // }
                //BC UPGRADE SIVA << Drink it Code

                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EditableDesc;
                    ShowMandatory = true;
                    ToolTipML = ENU = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.',
                                FRA = 'Spécifie une description de l''entrée qui est basée sur le contenu des champs Type et N°.';

                    trigger OnValidate();
                    begin
                        //UpdateEditableOnRow(); BC UPGRADE SIVA

                        if Rec."No." = xRec."No." then
                            exit;

                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        //NoOnAfterValidate();BC UPGRADE SIVA

                        if xRec."No." <> '' then
                            RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Additional Description"; Rec."Additional Description FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies additional description information for the purchase line.',
                               FRA = 'Spécifie des informations de description supplémentaires pour la ligne achat.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic, Suite;
                    Description = 'DIT-715 #393';
                    Visible = false;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a code that explains why the item is returned.',
                                FRA = 'Spécifie un code expliquant la raison du renvoi de l''article.';
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the responsibility center for the purchase line.',
                                FRA = 'Spécifie le centre de responsabilité pour la ligne achat.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //BC UPGRADE SIVA >>
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        //if Rec."Responsibility Center" <> xRec."Responsibility Center" then
                        //  CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                        //BC UPGRDE SIVA<<
                    end;
                }
                //BC UPGRADE SIVA >> Drink it field
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                //             CurrPage.UPDATE(true);
                //         // >>DITW18.00.06 DDR DIT-770 #1191
                //     end;
                // }
                //BC UPGRADE SIVA << Drink it field

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the code for the location where the items on the line will be located.',
                                FRA = 'Spécifie le code du magasin où sont stockés les articles de la ligne.';
                    Visible = true;

                    trigger OnValidate();
                    begin
                        //BC UPGRADE SIVA >> Drink IT Code
                        // LocationCodeOnAfterValidate();
                        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        // if xRec."Location Code" <> Rec."Location Code" then
                        //     CurrPage.UPDATE(true);
                        // >>DITW18.00.06 DDR DIT-770 #1191
                        //BC UPGRADE SIVA<<
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a bin code for the item.',
                                FRA = 'Spécifie un code emplacement pour l''article.';
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT RowIsText;
                    Enabled = NOT RowIsText;
                    ShowMandatory = Rec."No." <> '';
                    ToolTipML = ENU = 'Specifies the number of units of the item that will be specified on the line.',
                                FRA = 'Spécifie le nombre d''unités de l''article qui seront spécifiées sur la ligne.';

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                        RedistributeTotalsOnAfterValidate();

                        //QuantityOnAfterValidate();BC UPGRADE SIVA
                    end;
                }
                //BC UPGRADE SIVA >> 
                field("CAD Amount"; Rec."CAD Amount FND")
                {
                    toolTipML = ENU = 'Specifies the amount subject to CAD   for the purchase line.',
                               FRA = 'Spécifie le montant soumis à la CAD  pour la ligne achat.';
                    ApplicationArea = Basic, Suite;
                    Visible = EnableCAD;
                }
                //BC UPGRADE SIVA<<
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = UnitofMeasureCodeIsChangeable;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    ToolTipML = ENU = 'Specifies the unit of measure code that is valid for the purchase line.',
                                FRA = 'Spécifie le code unité valable pour la ligne achat.';

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                        RedistributeTotalsOnAfterValidate();

                        //UnitofMeasureCodeOnAfterValida(); BC UPGRADE SIVA
                    end;
                }

                //BC UPGRADE SIVA >> Drink it (2013729) field
                // field("Tariff No."; Rec."Tariff No.")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Description = 'FINXL7.00';
                //     Visible = false;
                // }
                // field("Net Weight"; Rec."Net Weight")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Description = 'FINXL7.00';
                //     Visible = false;
                //     ToolTipML = ENU = 'Specifies the net weight of the item on the line.',
                //                 FRA = 'Spécifie le poids net de l''article sur la ligne.';
                // }
                //BC UPGRADE SIVA << Drink IT field
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the name of the unit of measure for the item, such as 1 bottle or 1 piece.',
                                FRA = 'Spécifie le nom de l''unité de l''article, par exemple, 1 bouteille ou 1 pièce.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT RowIsText;
                    Enabled = NOT RowIsText;
                    ShowMandatory = Rec."No." <> '';
                    ToolTipML = ENU = 'Specifies the direct unit cost of the item on the line.',
                                FRA = 'Spécifie le coût unitaire direct pour l''article sur la ligne.';

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                        RedistributeTotalsOnAfterValidate();

                        //DirectUnitCostOnAfterValidate(); //BC UPGRADE SIVA
                    end;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the item''s indirect cost percentage.',
                                FRA = 'Spécifie le pourcentage de coût indirect de l''article.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the unit cost of the item on the line.',
                                FRA = 'Spécifie le coût unitaire pour l''article sur la ligne.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        RedistributeTotalsOnAfterValidate();
                    end;
                }
                //BC UPGRADE SIVA >> Drink it field
                // field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Enabled = Rec."Unit Price (LCY)Enable";
                //     ToolTipML = ENU = 'Specifies the price for one unit of the item.',
                //                 FRA = 'Spécifie le prix unitaire de l''article.';
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         RedistributeTotalsOnAfterValidate();
                //     end;
                // }
                //BC UPGRADE SIVA << Drink it field
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT RowIsText;
                    Enabled = NOT RowIsText;
                    ToolTipML = ENU = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.',
                                FRA = 'Spécifie le montant net (avant soustraction du montant remise facture) à payer pour les articles de la ligne.';

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        RedistributeTotalsOnAfterValidate();

                        // LineAmountOnAfterValidate(); //BC UPGRADE SIVA
                    end;
                }
                //BC UPGRADE SIVA >> Drink it Code
                // field("Approved Line Amount"; Rec."Approved Line Amount")
                // {
                //     Description = 'DITW17.00.02 DIT-770 #144';
                //     Visible = false;
                // }

                // field(RTCTotalUnit; GetTotalingLine(2, FIELDNO("Direct Unit Cost"), true))
                // {
                //     AutoFormatExpression = "Currency Code";
                //     AutoFormatType = 2;
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassVar(PageText2014411);
                //     CaptionML = ENU = 'Total Direct Unit Cost',
                //                 FRA = 'Total coût unitaire directe';
                //     Description = 'DITW17.10.05 DIT-770 #988';
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
                // {
                //     AutoFormatExpression = "Currency Code";
                //     AutoFormatType = 1;
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassVar(PageText2014410);
                //     CaptionML = ENU = 'Total Line Amount',
                //                 FRA = 'Montant total ligne';
                //     Description = 'DITW17.10.02B DIT-770 #541';
                //     Editable = false;
                //     QuickEntry = false;
                // }
                //BC UPGRADE SIVA << Drink it Code
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT RowIsText;
                    Enabled = NOT RowIsText;
                    ToolTipML = ENU = 'Specifies the line discount percentage that is valid for the item on the line.',
                                FRA = 'Spécifie le pourcentage de remise ligne valable pour l''article de la ligne.';

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        RedistributeTotalsOnAfterValidate();

                        //LineDiscount37OnAfterValidate();//BC UPGRADE SIVA
                    end;
                }
                field("H&S Levy Tax Amount"; Rec."H&S Levy Tax Amount FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the H&S Levy tax amount for the purchase line.',
                                FRA = 'Spécifie le montant de la taxe sur la santé et la sécurité pour la ligne achat.';
                }
                field("HS Posting Group"; Rec."HS Posting Group FND")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the HS posting group for the purchase line.',
                                FRA = 'Spécifie le groupe de comptabilisation santé et sécurité pour la ligne achat.';

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE(true);//HEI.08
                    end;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT RowIsText;
                    Enabled = NOT RowIsText;
                    ToolTipML = ENU = 'Specifies the amount of the line discount that will be granted on the purchase line.',
                                FRA = 'Spécifie le montant de la remise ligne qui est accordée sur la ligne achat.';

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

                        RedistributeTotalsOnAfterValidate();

                        //LineDiscountAmountOnAfterValid(); //BC UPGRADE SIVA
                    end;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies whether the invoice line is included when the invoice discount is calculated.',
                                FRA = 'Spécifie si la ligne facture est incluse lors du calcul de la remise facture.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                    end;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the invoice discount amount for the line.',
                                FRA = 'Spécifie le montant de la remise facture pour la ligne.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
                    end;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies that you can assign item charges to this line.',
                                FRA = 'Spécifie que vous pouvez affecter des frais annexes à cette ligne.';
                    Visible = false;
                }
                field("Qty. to Assign"; REc."Qty. to Assign")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ToolTipML = ENU = 'Specifies the quantity of the item charge that will be assigned when you post this line.',
                                FRA = 'Spécifie la quantité de frais annexes qui sera affectée lorsque vous validez cette ligne.';

                    trigger OnDrillDown();
                    begin
                        CurrPage.SAVERECORD();
                        rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    ToolTipML = ENU = 'Specifies how much of the item charge that has been assigned.',
                                FRA = 'Spécifie les frais annexes qui ont été affectés.';

                    trigger OnDrillDown();
                    begin
                        CurrPage.SAVERECORD();
                        rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'If you fill in this field and the Job Task No. field, then a job ledger entry will be posted together with the purchase order line.',
                                FRA = 'Si vous renseignez ce champ et le champ N° tâche projet, alors une écriture comptable projet sera validée avec la ligne commande achat.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("WHT Absorb Base"; Rec."WHT Absorb Base FND")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the amount on which WHT tax will be calculated for this line.',
                                FRA = 'Spécifie le montant sur lequel la retenue à la source sera calculée pour cette ligne.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the number of the job task that corresponds to the purchase document (invoice or credit memo).',
                                FRA = 'Spécifie le numéro de la tâche projet qui correspond au document achat (facture ou avoir).';
                    Visible = false;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a Job Planning Line together with the posting of a job ledger entry.',
                                FRA = 'Spécifie une ligne planning projet lors de la validation d''une écriture comptable projet.';
                    Visible = false;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    applicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the sales price per unit that applies to the item or general ledger expense that will be posted.',
                                FRA = 'Spécifie le prix de vente unitaire qui s''applique à l''article ou la dépense générale qui sera validée.';
                    Visible = false;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    ToolTipML = ENU = 'Specifies the net amount of the line that the purchase line applies to.',
                                FRA = 'Spécifie le montant net de la ligne à laquelle la ligne achat s''applique.';
                    Visible = false;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    ToolTipML = ENU = 'Specifies the amount of the discount that the purchase line applies to.',
                                FRA = 'Spécifie le montant de la remise avec laquelle la ligne achat est lettrée.';
                    Visible = false;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    ToolTipML = ENU = 'Specifies the line discount percent that applies to the item or general ledger expense.',
                                FRA = 'Indique le pourcentage remise ligne applicable à la dépense générale ou à l''article.';
                    Visible = false;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    ToolTipML = ENU = 'Specifies the gross amount of the line that the purchase line applies to.',
                                FRA = 'Spécifie le montant brut de la ligne à laquelle la ligne achat s''applique.';
                    Visible = false;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    ToolTipML = ENU = 'Specifies the sales price per unit that applies to the item or general ledger expense that will be posted.',
                                FRA = 'Spécifie le prix de vente unitaire qui s''applique à l''article ou la dépense générale qui sera validée.';
                    Visible = false;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    ToolTipML = ENU = 'Specifies the gross amount of the line, in the local currency.',
                                FRA = 'Spécifie le montant brut de la ligne dans la devise société.';
                    Visible = false;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    ToolTipML = ENU = 'Specifies the net amount of the line that the purchase line applies to.',
                                FRA = 'Spécifie le montant net de la ligne à laquelle la ligne achat s''applique.';
                    Visible = false;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    ToolTipML = ENU = 'Specifies the amount of the discount that the purchase line applies to.',
                                FRA = 'Spécifie le montant de la remise avec laquelle la ligne achat est lettrée.';
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTipML = ENU = 'Specifies the number of the production order that the purchase order was created for.',
                                FRA = 'Spécifie le numéro de l''O.F. pour lequel la commande achat a été créée.';
                    Visible = false;
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ToolTipML = ENU = 'Specifies an insurance number if you have selected the Acquisition Cost option in the FA Posting Type field.',
                                FRA = 'Spécifie un numéro d''assurance si vous avez sélectionné l''option Coût acquisition dans le champ Type compta. immo.';
                    Visible = false;
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.',
                                FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
                    Visible = false;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ToolTipML = ENU = 'Specifies the FA posting type if you have selected Fixed Asset in the Type field for this line.',
                                FRA = 'Spécifie le type comptabilisation immobilisation si vous avez sélectionné Immobilisation dans le champ Type pour cette ligne.';
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ToolTipML = ENU = 'You can use this field if you have selected Fixed Asset in the Type field for this line.',
                                FRA = 'Vous pouvez utiliser ce champ si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
                    Visible = false;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ToolTipML = ENU = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.',
                                FRA = 'Spécifie le code des lois d''amortissement sur lesquelles la ligne sera validée, si vous avez sélectionné Immobilisation dans le champ Type de cette ligne.';
                    Visible = false;
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    ToolTipML = ENU = 'This field is relevant when you post an additional acquisition cost and a possible salvage value to an already acquired asset.',
                                FRA = 'Ce champ est pertinent lorsque vous validez un coût d''acquisition supplémentaire et une valeur résiduelle possible sur une immobilisation déjà acquise.';
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ToolTipML = ENU = 'Specifies the document number of the blanket order from which this purchase line originates.',
                                FRA = 'Spécifie le numéro de document de la commande ouverte qui est à l''origine de cette ligne achat.';
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ToolTipML = ENU = 'Specifies the line number of the blanket order line from which this purchase line originates.',
                                FRA = 'Spécifie le numéro de ligne de la ligne de la commande ouverte qui est à l''origine de cette ligne achat.';
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the item ledger entry number the line should be applied to.',
                                FRA = 'Spécifie le numéro de l''écriture comptable article avec laquelle la ligne doit être lettrée.';
                    Visible = false;
                }
                //BC UPGRADE SIVA >> Drink it field
                // field("Auto. Acc. Group"; Rec."Auto. Acc. Group")
                // {
                //     Description = 'FINXL7.00';
                // }
                //BC UPGRADE SIVA << Drink it field
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = Suite;
                    Enabled = (Rec.Type <> Rec.Type::"Fixed Asset") AND (Rec.Type <> Rec.Type::" ");
                    TableRelation = "Deferral Template"."Deferral Code";
                    ToolTipML = ENU = 'Specifies the deferral template that governs how expenses paid with this purchase document are deferred to the different accounting periods when the expenses were incurred.',
                                FRA = 'Spécifie le modèle d''échelonnement qui régit la manière dont les dépenses payées avec ce document achat sont reportées sur les différentes périodes de comptabilité lorsque des dépenses sont encourues.';
                    Visible = false;
                }
                //BC UPGRADE SIVA >> Drink it fields
                // field("Vendor DTax Group Code"; Rec."Vendor DTax Group Code")
                // {
                //     Description = 'DIT-770 #698';
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("Item DTax Group Code"; Rec."Item DTax Group Code")
                // {
                //     Description = '<DITW15.00.00.01>- DIT-770 #698';
                //     Editable = false;
                //     QuickEntry = false;
                //     Visible = false;
                // }
                // field("AAD No. Series"; Rec."AAD No. Series")
                // {
                //     Visible = false;
                // }
                // field("LRN No. Series"; Rec."LRN No. Series")
                // {
                //     Description = 'DITW15.00.00.38 #1217';
                //     Editable = false;
                //     Visible = false;
                // }
                // field("SAD No."; Rec."SAD No.")
                // {
                //     Visible = false;
                // }
                // field("Packaging Type Code"; Rec."Packaging Type Code")
                // {
                //     Visible = false;
                // }
                // field("Free Item"; Rec."Free Item")
                // {

                //     trigger OnValidate();
                //     begin
                //         FreeItemOnAfterValidate();
                //     end;
                // }
                // field("Allow VAT Calculation (Free)"; Rec."Allow VAT Calculation (Free)")
                // {
                //     Description = 'DITW16.00.00.40 DIT-715 #172';
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         AllowVATCalculationFreeOnAfter();
                //     end;
                // }
                // field("Free Item Posting Type"; Rec."Free Item Posting Type")
                // {
                //     Visible = false;

                //     trigger OnValidate();
                //     begin
                //         FreeItemPostingTypeOnAfterVali();
                //     end;
                // }
                // field("Contract Type"; Rec."Contract Type")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
                // {
                //     Visible = false;
                // }
                // field("Service Contract No."; Rec."Service Contract No.")
                // {
                //     Visible = false;
                // }
                // field("Financial Contract No."; Rec."Financial Contract No.")
                // {
                //     Visible = false;
                // }
                // field("Contract Group Code"; Rec."Contract Group Code")
                // {
                //     Visible = false;
                // }
                // field("Linked Customer No."; Rec."Linked Customer No.")
                // {
                //     Visible = false;
                // }
                //BC UPGRADE SIVA << Drink it fields
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.',
                                FRA = 'Spécifie le code pour Raccourci axe 1.';
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.',
                                FRA = 'Spécifie le code pour Raccourci axe 2.';
                    Visible = DimVisible2;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible3;

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible4;

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 5.',
                                FRA = 'Spécifie le code pour Raccourci axe 5.';
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible5;

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 6.',
                                FRA = 'Spécifie le code pour Raccourci axe 6.';
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible6;

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible7;

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible8;

                    trigger OnValidate();
                    begin
                        ValidateSaveShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    ToolTipML = ENU = 'Specifies the WHT tax business posting group for the vendor.',
                                FRA = 'Spécifie le groupe de comptabilisation entreprise de la retenue à la source pour le fournisseur.';

                }
                field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the WHT tax product posting group for the item.',
                                FRA = 'Spécifie le groupe de comptabilisation article de la retenue à la source pour l''article.';
                }
                field("TIN No."; Rec."TIN No. FND")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Specifies the tax identification number (TIN) for the vendor.',
                                FRA = 'Spécifie le numéro d''identification fiscale (NIF) du fournisseur.';
                }
            }
            group(Control47)
            {
                ShowCaption = false;
                group(Control41)
                {
                    ShowCaption = false;
                    field("Invoice Discount Amount"; TotalPurchaseLine."Inv. Discount Amount")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionML = ENU = 'Invoice Discount Amount',
                                    FRA = 'Montant remise facture';
                        Editable = InvDiscAmountEditable;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTipML = ENU = 'Specifies a discount amount that is deducted from the value in the Total Incl. VAT field. You can enter or change the amount manually.',
                                    FRA = 'Spécifie un montant de remise qui est déduit de la valeur dans le champ Total TTC. Vous pouvez saisir ou modifier le montant manuellement.';

                        trigger OnValidate();
                        var
                            PurchaseHeader: Record "Purchase Header";
                        begin
                            PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
                            PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalPurchaseLine."Inv. Discount Amount", PurchaseHeader);
                            CurrPage.UPDATE(false);
                        end;
                    }
                    field("Invoice Disc. Pct."; PurchCalcDiscByType.GetVendInvoiceDiscountPct(Rec))
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Invoice Discount %',
                                    FRA = '% remise facture';
                        DecimalPlaces = 0 : 2;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTipML = ENU = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.',
                                    FRA = 'Indique un pourcentage de remise qui est accordé si les critères que vous avez paramétrés pour le client sont réunis.';
                    }
                }
                group(Control23)
                {
                    ShowCaption = false;
                    field("Total Amount Excl. VAT"; TotalPurchaseLine.Amount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
                        CaptionML = ENU = 'Total Amount Excl. VAT',
                                    FRA = 'Montant total HT';
                        DrillDown = false;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Excl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.',
                                    FRA = 'Spécifie la somme de la valeur du champ Montant ligne HT sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
                    }
                    field("Total VAT Amount"; VATAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
                        CaptionML = ENU = 'Total VAT',
                                    FRA = 'Total TVA';
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        ToolTipML = ENU = 'Specifies the sum of VAT amounts on all lines in the document.',
                                    FRA = 'Spécifie la somme des montants de TVA sur toutes les lignes du document.';
                    }
                    //BC UPGRADE SIVA>> 
                    field(TotalCADAmount; TotalPurchaseLine."CAD Amount FND")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTipML = ENU = 'Specifies the total CAD amount for the document.',
                                    FRA = 'Spécifie le montant total en CAD pour le document.';
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        //CaptionClass = DocumentTotals.GetTotalCADCaption(TotalPurchaseHeader."Currency Code");//BC UPGRADE SIVA Commented
                        CaptionClass = BCHNKCustomFunction.GetTotalCADCaption(TotalPurchaseHeader."Currency Code");//BC UPGRADE SIVA Added

                        Caption = 'Total CAD Amount';
                        Editable = false;
                        Visible = EnableCAD;
                    }
                    //BC UPGRADE SIVA<<
                    field("Total Amount Incl. VAT"; TotalPurchaseLine."Amount Including VAT")
                    {
                        ApplicationArea = Basic, Suite;
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(PurchHeader."Currency Code");
                        CaptionML = ENU = 'Total Amount Incl. VAT',
                                    FRA = 'Montant total TTC';
                        Editable = false;
                        StyleExpr = TotalAmountStyle;
                        ToolTipML = ENU = 'Specifies the sum of the value in the Line Amount Incl. VAT field on all lines in the document minus any discount amount in the Invoice Discount Amount field.',
                                    FRA = 'Spécifie la somme de la valeur du champ Montant TTC sur toutes les lignes du document, moins l''éventuel montant remise indiqué dans le champ Montant remise facture.';
                    }
                    //BC UPGRADE SIVA<< 
                    field(TotalInclCAD; TotalInclCAD)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTipML = ENU = 'Specifies the total amount including CAD for the document.',
                                    FRA = 'Spécifie le montant total TTC en CAD pour le document.';
                        AutoFormatExpression = TotalPurchaseHeader."Currency Code";
                        //CaptionClass = DocumentTotals.GetTotalInclCADCaption(PurchHeader."Currency Code"); //BC UPGRADE SIVA Commented
                        CaptionClass = BCHNKCustomFunction.GetTotalInclCADCaption(PurchHeader."Currency Code");//BC UPGRADE SIVA Added    
                        Caption = 'Total Incl. CAD';
                        Editable = false;
                        StyleExpr = TotalAmountStyle;
                        Visible = EnableCAD;
                    }
                    //BC UPGRADE SIVA>>
                    field(RefreshTotals; RefreshMessageText)
                    {
                        ApplicationArea = all;
                        DrillDown = true;
                        Editable = false;
                        Enabled = RefreshMessageEnabled;
                        ShowCaption = false;

                        trigger OnDrillDown();
                        begin
                            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
                            DocumentTotals.PurchaseUpdateTotalsControls(Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
                              TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            //BC UPGRADE SIVA >> Drink IT actions   
            // action("+ Expand")
            // {
            //     ApplicationArea = all;
            //     ToolTipML = ENU = 'Expand the purchase lines to show all fields.',
            //                 FRA = 'Développer les lignes achat pour afficher tous les champs.';
            //     CaptionML = ENU = '+ Expand',
            //                 FRA = '+ Développer';
            //     Enabled = (NOT ExpandLines);
            //     Image = ViewDetails;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = Process;
            //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedIsBig = true;
            //     Visible = (NOT ExpandLines) OR ShowButtonsCE;

            //     trigger OnAction();
            //     begin
            //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
            //         ExpandLines := true;
            //         CurrPage.UPDATE(true);
            //         // >>DITW17.10.03 DDR DIT-770 #541
            //     end;
            // }
            // action("- Collapse")
            // {
            //     ApplicationArea = all;
            //     ToolTipML = ENU = 'Collapse the purchase lines to show only the most important fields.',
            //                 FRA = 'Réduire les lignes achat pour n''afficher que les champs les plus importants.';
            //     CaptionML = ENU = '- Collapse',
            //                 FRA = '- Réduire';
            //     Enabled = ExpandLines;
            //     Image = ViewDetails;
            //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedCategory = Process;
            //     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //     //PromotedIsBig = true;
            //     Visible = ExpandLines OR ShowButtonsCE;

            //     trigger OnAction();
            //     begin
            //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
            //         ExpandLines := false;
            //         CurrPage.UPDATE(true);
            //         // >>DITW17.10.03 DDR DIT-770 #541
            //     end;
            // }
            //BC UPGRADE SIVA <<
            action(InsertExtTexts)
            {
                AccessByPermission = TableData "Extended Text Header" = R;
                ApplicationArea = Suite;
                CaptionML = ENU = 'Insert &Ext. Texts',
                            FRA = 'Insérer te&xtes étendus';
                Image = Text;
                ToolTipML = ENU = 'Insert an extended description for the document.',
                            FRA = 'Insérez une description plus longue pour le document.';

                trigger OnAction();
                begin
                    InsertExtendedText(true);
                end;
            }
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = Suite;
                CaptionML = ENU = 'Dimensions',
                            FRA = 'Axes analytiques';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                            FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                trigger OnAction();
                begin
                    Rec.ShowDimensions();
                end;
            }
            action(DeferralSchedule)
            {
                ApplicationArea = Suite;
                CaptionML = ENU = 'Deferral Schedule',
                            FRA = 'Tableau d''échelonnement';
                Enabled = Rec."Deferral Code" <> '';
                Image = PaymentPeriod;
                ToolTipML = ENU = 'View or edit the deferral schedule that governs how expenses paid with this purchase document are deferred to different accounting periods when the document is posted.',
                            FRA = 'Affichez ou modifiez le tableau d''échelonnement qui régit la manière dont les dépenses réalisées à l''aide de ce document achat sont échelonnées sur différentes périodes de comptabilité lorsque le document est validé.';

                trigger OnAction();
                begin
                    PurchHeader.GET(Rec."Document Type", Rec."Document No.");
                    Rec.ShowDeferrals(PurchHeader."Posting Date", PurchHeader."Currency Code");
                end;
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                Image = "Action";
                action("E&xplode BOM")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Explode the bill of materials (BOM) for the item on the purchase line.',
                                FRA = 'Éclater la nomenclature (BOM) pour l''article de la ligne achat.';
                    AccessByPermission = TableData "BOM Component" = R;
                    CaptionML = ENU = 'E&xplode BOM',
                                FRA = '&Eclater nomenclature';
                    Image = ExplodeBOM;

                    trigger OnAction();
                    begin
                        ExplodeBOM();
                    end;
                }
            }
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            FRA = '&Ligne';
                Image = Line;
                group("Item Availability by")
                {
                    CaptionML = ENU = 'Item Availability by',
                                FRA = 'Disponibilité article par';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        ApplicationArea = all;
                        ToolTipML = ENU = 'View item availability based on the event for the purchase line item.',
                                    FRA = 'Afficher la disponibilité article en fonction de l''événement pour l''article de la ligne achat.';
                        CaptionML = ENU = 'Event',
                                    FRA = 'Événement';
                        Image = "Event";

                        trigger OnAction();
                        begin
                            //  ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent)//BC UPGRADE SIVA Commented
                            this.PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::"Event"); //BC UPGRADE SIVA Added
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = all;
                        ToolTipML = ENU = 'View item availability based on the period for the purchase line item.',
                                    FRA = 'Afficher la disponibilité article en fonction de la période pour l''article de la ligne achat.';
                        CaptionML = ENU = 'Period',
                                    FRA = 'Période';
                        Image = Period;

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod)//BC UPGRADE SIVA Commented
                            this.PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Period); //BC UPGRADE SIVA Added
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = all;
                        ToolTipML = ENU = 'View item availability based on the variant for the purchase line item.',
                                    FRA = 'Afficher la disponibilité article en fonction de la variante pour l''article de la ligne achat.';
                        CaptionML = ENU = 'Variant',
                                    FRA = 'Variante';
                        Image = ItemVariant;

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant)//BC UPGRADE SIVA Commented
                            this.PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Variant); //BC UPGRADE SIVA Added
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = all;
                        ToolTipML = ENU = 'View item availability based on the location for the purchase line item.',
                                    FRA = 'Afficher la disponibilité article en fonction du magasin pour l''article de la ligne achat.';
                        AccessByPermission = TableData Location = R;
                        CaptionML = ENU = 'Location',
                                    FRA = 'Magasin';
                        Image = Warehouse;

                        trigger OnAction();
                        begin
                            //ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)//BC UPGRADE SIVA Commented
                            this.PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Location); //BC UPGRADE SIVA Added
                        end;
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = all;
                        ToolTipML = ENU = 'View item availability based on the BOM level for the purchase line item.',
                                    FRA = 'Afficher la disponibilité article en fonction du niveau nomenclature pour l''article de la ligne achat.';
                        CaptionML = ENU = 'BOM Level',
                                    FRA = 'Niveau nomenclature';
                        Image = BOMLevel;

                        trigger OnAction();
                        begin
                            //ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM)//BC UPGRADE SIVA Commented
                            this.PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::BOM); //BC UPGRADE SIVA Added
                        end;
                    }
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'View or add comments for the purchase line.',
                                FRA = 'Afficher ou ajouter des commentaires pour la ligne achat.';
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;

                    // trigger OnAction();
                    // begin
                    //     ShowLineComments();
                    // end;

                    // BC Upgrade MISHRS14 >>
                    // Added Rec in calling of ShowLineComments function
                    trigger OnAction();
                    begin
                        Rec.ShowLineComments();
                    end;
                    // BC Upgrade MISHRS14 <<

                }
                action("Item Charge &Assignment")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'Assign item charges to the purchase line.',
                                FRA = 'Affecter des frais annexes à la ligne achat.';
                    AccessByPermission = TableData "Item Charge" = R;
                    CaptionML = ENU = 'Item Charge &Assignment',
                                FRA = '&Affectation frais annexes';
                    Image = ItemCosts;

                    trigger OnAction();
                    begin
                        ItemChargeAssgnt();
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = all;
                    ToolTipML = ENU = 'View item tracking lines for the purchase line.',
                                FRA = 'Afficher les lignes de traçabilité article pour la ligne achat.';
                    CaptionML = ENU = 'Item &Tracking Lines',
                                FRA = 'Lignes &traçabilité';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    // trigger OnAction();
                    // begin
                    //     Rec.OpenItemTrackingLines();
                    // end;

                    // BC Upgrade MISHRS14 >>
                    // Added Rec in calling of OpenItemTrackingLines function
                    trigger OnAction();
                    begin
                        Rec.OpenItemTrackingLines();
                    end;
                    // BC Upgrade MISHRS14 <<
                }
                //BC UPGRADE SIVA >> Drink IT actions  
                // action("SSCC Tracking Lines")
                // {
                //     ToolTipML = ENU = 'View SSCC tracking lines for the purchase line.',
                //                 FRA = 'Afficher les lignes de traçabilité SSCC pour la ligne achat.';
                //     ApplicationArea = all;
                //     CaptionML = ENU = 'SSCC Tracking Lines',
                //                 FRA = 'Lignes Traçabilité SSCC';
                //     Description = 'DIT-715 #745';
                //     Image = ItemTrackingLines;


                //     trigger OnAction();
                //     begin
                //         //This functionality was copied from page #52. Unsupported part was commented. Please check it.
                //         /*CurrPage.PurchLines.FORM.*/
                //         _OpenSSCCTrackingLines();

                //     end;
                // }
                // action("Insert Item Char&ges")
                // {
                //     ToolTipML = ENU = 'Insert item charges for the purchase line.',
                //                 FRA = 'Insérer des frais annexes pour la ligne achat.';
                //     CaptionML = ENU = 'Insert Item Char&ges',
                //                 FRA = 'Insérer frais annexe';
                //     ShortCutKey = 'Ctrl+Y';
                //     ApplicationArea = all;
                //     Image = InsertTravelFee;

                //     trigger OnAction();
                //     begin
                // <<DITW15.00.00.01 DDR 17/01/2007
                //         //This functionality was copied from page #52. Unsupported part was commented. Please check it.
                //         /*CurrPage.PurchLines.PAGE.*/
                //         _InsertExtendedCharges(true);

                //     end;
                //BC UPGRADE SIVA
            }
        }
    }


    trigger OnAfterGetCurrRecord();
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseLine: Record "Purchase Line";
    begin
        //BC UPGRADE SIVA >> Drink IT code
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        // SETFILTER("Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // >>DITW18.00.06 DDR DIT-770 #1191
        // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
        // Rec.SetFilterSubContractPostType();
        // >>DITW16.00.00.41 AHU DIT-715 #327
        //BC UPGRADE SIVA <<    

        //UpdateEditableOnRow(); BC UPGRADE SIVA

        if PurchHeader.GET(Rec."Document Type", Rec."Document No.") then;

        DocumentTotals.PurchaseUpdateTotalsControls(Rec, TotalPurchaseHeader, TotalPurchaseLine, RefreshMessageEnabled,
          TotalAmountStyle, RefreshMessageText, InvDiscAmountEditable, VATAmount);
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        // <<DITW15.00.00.01 DDR 18/12/2007
        // VIGEO VS 29-12-2005: Toeslag regels mogen niet worden gewijzigd. Dit moet op het hoofdartikel worden gedaan.
        //UpdateFields(); BC UPGRADE SIVA
        // >>DITW15.00.00.01 DDR 18/12/2007

        //BC UPGRADE SIVA<<
        //HEI.07>>
        TotalInclCAD := 0;
        GeneralLedgerSetup.GET();
        if GeneralLedgerSetup."Enable CAD FND" then begin
            if TotalPurchaseLine."CAD Amount FND" <> 0 then begin
                PurchaseLine.RESET();
                PurchaseLine.SETRANGE("Document Type", TotalPurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", TotalPurchaseHeader."No.");
                PurchaseLine.SETFILTER("CAD Attached to Line No. FND", '<>%1', 0);
                if PurchaseLine.FINDFIRST() then
                    TotalInclCAD := TotalPurchaseLine."Amount Including VAT"
                else
                    TotalInclCAD := TotalPurchaseLine."Amount Including VAT" + TotalPurchaseLine."CAD Amount FND";
            end else
                TotalInclCAD := TotalPurchaseLine."Amount Including VAT";
        end;
        //HEI.07<<
        //BC UPGRADE SIVA>>
    end;

    trigger OnAfterGetRecord();
    begin
        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //IndentLine := Rec.IndentRecordDIT(ExpandLines); //BC UPGRADE SIVA >>
        // >>DITW17.10.03 DDR DIT-770 #541
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        CLEAR(DocumentTotals);

        //HEI.01 PATHAA02 07.11.2017>>
        if Rec.Type <> Rec.Type::Item then
            EditableDesc := true
        else
            EditableDesc := false;
        //PATHAA02 07.11.2017<<
    end;


    //BC UPGRADE SIVA >> Drink It code
    //trigger OnDeleteRecord(): Boolean;
    //var
    //  ReservePurchLine: Codeunit "Purch. Line-Reserve";
    //begin
    /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

    // <<DITW16.00.00.37 DDR 20/07/2010
    //IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    //  COMMIT;
    //  IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
    //    EXIT(FALSE);
    //  ReservePurchLine.DeleteLine(Rec);
    //END;
    // Move to function TriggerOnDeleteRecord() to solve RTC Collapse delete records
    // Temporary until next Mirosoft release
    //exit(TriggerOnDeleteRecord());
    //end;

    //trigger OnFindRecord(Which: Text): Boolean;
    //begin
    //BC UPGRADE SIVA >> Drink IT code
    // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    // if DisabledRefreshLines then
    //     exit(false);
    // >>DITW16.00.00.40 DDR DIT-715 #197
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    // exit(Rec.FindRecordDIT(Which, ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    // BC UPGRADE SIVA <<
    //end;

    // trigger OnInit();
    // begin
    //      <<DITW15.00.00.01 DDR 18/12/2007
    //     "Line AmountEnable" := true;
    //     //"Unit Price (LCY)Enable" := true; //BC UPGRADE SIVA >>
    //     QuantityEnable := true;
    //     "No.Enable" := true;
    //     TypeEnable := true;
    //     "Line AmountEditable" := true;
    //     "Direct Unit CostEditable" := true;
    //     QuantityEditable := true;
    //     "Cross-Reference No.Editable" := true;
    //     "No.Editable" := true;
    //     TypeEditable := true;
    //      >>DITW15.00.00.01 DDR 18/12/2007
    // end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    var
        ApplicationAreaSetup: Record "Application Area Setup";
    begin
        //BC UPGRADE SIVA << Blocked becaue no need of this condition.
        // if ApplicationAreaSetup.IsFoundationEnabled then
        //     Type := Type::Item;
        //BC UPGRADE SIVA >>


        //HEI.02>>
        UpdatePaymentStatus(Rec); //BC Upgrade VAMSIU01 - Code added for Document Subtype
        if (Rec.Type <> Rec.Type::"G/L Account") and (Rec.Type <> Rec.Type::" ") then
            ERROR(Text001, Rec.Type)
        //HEI.02<<
    end;
    //BC UPGRADE SIVA <<

    trigger OnModifyRecord(): Boolean;
    begin
        //BC UPGRADE SIVA >>
        //HEI.07>>
        if Rec."CAD Attached to Line No. FND" <> 0 then
            ERROR(CADLineModifyErr);
        //HEI.07<<
        //BC UPGRAD SIVA<<
    end;

    //BC UPGRADE SIVA >> Drink IT code    
    //trigger OnNewRecord(BelowxRec: Boolean);
    //var
    //  ApplicationAreaSetup: Record "Application Area Setup";
    //begin
    // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    // IndentLine := 0;
    // if not ISEMPTY then
    //     InitLineNo(ExpandLines, BelowxRec);
    //  >>DITW17.10.03 DDR DIT-770 #541
    //BC UPGRADE SIVA>> ApplicationAreaSetup.IsFoundationEnabled removed by Microsoft 
    // if ApplicationAreaSetup.IsFoundationEnabled then
    //     Rec.Type := Rec.Type::Item
    // else
    //     Rec.InitType();

    // CLEAR(ShortcutDimCode);
    // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
    //Rec.SetFilterSubContractPostType2(); BC UPGRADE SIVA >>
    // >>DITW16.00.00.41 AHU DIT-715 #327
    //end;

    //trigger OnNextRecord(Steps: Integer): Integer;
    //begin
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    //exit(NextRecordDIT(Steps, ExpandLines)); //BC UPGRADE SIVA >>
    // >>DITW17.10.03 DDR DIT-770 #541
    //end;
    //BC UPGRADE SIVA <<

    trigger OnOpenPage();
    begin
        /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245

        // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
        //BC UPGRADE SIVA >> IsShowButtonsCEDIT variable not exists in Drink IT Code
        // ExpandLines := false;
        // ShowButtonsCE := IsShowButtonsCEDIT();
        // >>DITW17.10.03 DDR DIT-770 #541
        // BC UPGRADE SIVA <<

        //BC UPGRADE SIVA <<
        //HEI.07>>
        GeneralLedgerSetup.GET();
        EnableCAD := GeneralLedgerSetup."Enable CAD FND";
        //HEI.07<<
        //BC UPGRADE SIVA>>
        SetDimensionsVisibility(); //BC UPGRADE ATHUKUS01 FDDSTP_008
    end;

    local procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);
        Clear(DimMgt);
    end;


    var
        TotalPurchaseHeader: Record "Purchase Header";
        TotalPurchaseLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        PurchAvailabilityMgt: Codeunit "Purch. Availability Mgt."; //BC UPGRADE SIVA
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        DocumentTotals: Codeunit "Document Totals";
        BCHNKCustomFunction: Codeunit "Heineken BC Custom Functions";//BC UPGRADE SIVA >>
        ShortcutDimCode: array[8] of Code[20];
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        UpdateAllowedVar: Boolean;
        Text000: TextConst ENU = 'Unable to run this function while in View mode.', FRA = 'Impossible d''exécuter cette fonction en mode Afficher.';
        VATAmount: Decimal;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        RowIsText: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';
        PageText2014411: TextConst ENU = 'Total Direct Unit Cost', FRA = 'Total coût unitaire directe';
        DisabledRefreshLines: Boolean;

        TypeEditable: Boolean;

        "No.Editable": Boolean;

        "Cross-Reference No.Editable": Boolean;

        QuantityEditable: Boolean;

        "Direct Unit CostEditable": Boolean;

        "Line AmountEditable": Boolean;

        TypeEnable: Boolean;

        "No.Enable": Boolean;

        QuantityEnable: Boolean;

        "Line AmountEnable": Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserMgt: Codeunit "User Setup Management";
        PurchLine: Record "Purchase Line";
        //QualitySetup: Record "Quality Setup"; //BC UPGRADE SIVA >> Drink IT TABLE
        //QualityManagement: Codeunit "Quality Management"; //BC UPGRADE SIVA >> Drink IT TABLE
        EditableDesc: Boolean;
        Text001: Label 'You are not allow to insert lines with type %1';
        GeneralLedgerSetup: Record "General Ledger Setup";
        EnableCAD: Boolean;
        CADLineModifyErr: Label 'CAD Line cannot be modified.';
        TotalInclCAD: Decimal;

    procedure ApproveCalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    procedure ExplodeBOM();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    procedure GetReturnShipment();
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Get Return Shipments", Rec);
    end;

    procedure InsertExtendedText(Unconditionally: Boolean);
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SAVERECORD();
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            UpdateForm(true);
    end;

    procedure ItemChargeAssgnt();
    begin
        Rec.ShowItemChargeAssgnt();
    end;

    // BC Upgrade MISHRS14 >>
    // procedure OpenItemTrackingLines();
    // begin
    //     OpenItemTrackingLines;
    // end;
    // BC Upgrade MISHRS14 >>

    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure SetUpdateAllowed(UpdateAllowed: Boolean);
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;

    procedure UpdateAllowed(): Boolean;
    begin
        if UpdateAllowedVar = false then begin
            MESSAGE(Text000);
            exit(false);
        end;
        exit(true);
    end;

    // BC Upgrade MISHRS14 >>
    // procedure ShowLineComments();
    // begin
    //     this.ShowLineComments()
    // end;
    // BC Upgrade MISHRS14 <<

    //BC UPGRADE SIVA >> Drink IT code
    //local procedure NoOnAfterValidate();
    //begin
    // <<DITW15.00.00.36 DDR 25/11/2009 - DITW15.00.00.38 DDR 15/03/2011 #1291
    // if (Rec.Type <> Rec.Type::Item) and not Rec."Is Item Charge" then
    // >>DITW15.00.00.36 DDR - DITW15.00.00.38 DDR #1291
    //     InsertExtendedText(false);
    // if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
    //    (xRec."No." <> '')
    // then
    //     CurrPage.SAVERECORD();

    /// FINXL7.00 RBE 06/08/2013 - FINXL10.01 MTR 16/08/2017 NRQ#30245
    //BC UPGRADE SIVA << Drink IT code 
    // <<DITW15.00.00.23 DDR 30/07/2008
    //CurrPage.UPDATE();
    // >>DITW15.00.00.23 DDR
    // end;

    //   local procedure CrossReferenceNoOnAfterValidat();
    // begin
    // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    //InsertExtendedText(FALSE);
    //   CurrPage.UPDATE();
    // >>DITW15.00.00.38 DDR #1259
    // end;
    //BC UPGRADE SIVA<<  

    local procedure RedistributeTotalsOnAfterValidate();
    begin
        CurrPage.SAVERECORD();

        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        if DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) then
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.UPDATE();
    end;

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD();
    end;

    //BC UPGRADE SIVA >> Drink IT code 
    //local procedure UpdateEditableOnRow();
    //begin
    //CanEditUnitOfMeasureCode variabel not find 
    // RowIsText := (Rec."No." = '') and (Rec.Description <> '');
    // if not RowIsText then
    //     UnitofMeasureCodeIsChangeable := CanEditUnitOfMeasureCode
    // else
    //     UnitofMeasureCodeIsChangeable := false;
    //end;

    //procedure _InsertExtendedCharges(FromHeader: Boolean);
    //begin
    // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    // if Rec.InsertChargeLines(FromHeader) then
    //     UpdateForm(true);
    // >>DITW15.00.00.23 DDR
    //end;

    //procedure InsertExtendedCharges(FromHeader: Boolean);
    //begin
    // <<DITW15.00.00.01 DDR 19/03/2008 - DITW15.00.00.23 DDR 30/07/2008
    // if Rec.InsertChargeLines(FromHeader) then
    //     UpdateForm(true);
    // >>DITW15.00.00.23 DDR
    //end;

    //local procedure UpdateFields();
    //var
    //  CollapsedLine: Boolean;
    //begin
    //BC UPGRADE SIVA >> Drink IT code
    // <<DITW15.00.00.01 DDR 15/02/2008 - DITW15.00.00.33 DDR 12/05/2009 - DITW15.00.00.38 DDR 16/07/2010 #1194
    // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    // CollapsedLine := not ExpandLines;
    // >>DITW17.10.03 DDR DIT-770 #541
    // <<DITW17.10.03 DDR 09/07/2014 DIT-770 #541
    // Rec.CALCFIELDS("Has Item Charge");
    // CollapsedLine := CollapsedLine and "Has Item Charge";
    // >>DITW17.10.03 DDR DIT-770 #541
    // TypeEditable := FormEditableField(FIELDNO(Type));
    // "No.Editable" := FormEditableField(FIELDNO("No."));
    // <<DITW15.00.00.38 DDR 27/01/2011 #1259
    // "Cross-Reference No.Editable" := FormEditableField(FIELDNO("Cross-Reference No."));
    // >>DITW15.00.00.38 DDR #1259

    // QuantityEditable := FormEditableField(FIELDNO(Quantity));
    // "Direct Unit CostEditable" := FormEditableField(FIELDNO("Direct Unit Cost")) and not CollapsedLine;
    // "Line AmountEditable" := FormEditableField(FIELDNO("Line Amount")) and not CollapsedLine;

    // <<DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    // TypeEnable := FormEditableField(FIELDNO(Type));
    // "No.Enable" := FormEditableField(FIELDNO("No."));
    // QuantityEnable := FormEditableField(FIELDNO(Quantity));
    // Rec."Unit Price (LCY)Enable" := FormEditableField(FIELDNO("Unit Price (LCY)"));
    // "Line AmountEnable" := FormEditableField(FIELDNO("Line Amount"));
    // >>DITW16.00.00.37 CEL 13/08/2010 DIT-715 #1
    //BC UPGRADE SIVA << Drink IT code
    //end;

    // procedure NewLine();
    // var
    //     PurchLine: Record "Purchase Line";
    // begin
    // <<DITW16.00.00.37 DIT-715 #1
    // if Rec.FINDLAST() then;
    // PurchLine := Rec;
    // Rec.INIT();
    // Rec."Document Type" := PurchLine."Document Type";
    // Rec."Document No." := PurchLine."Document No.";
    // Rec."Line No." := PurchLine."Line No." + 10000;
    // Rec.INSERT(true);
    // CurrPage.UPDATE(false);
    // >>DITW16.00.00.37 DIT-715 #1
    //end;

    //procedure DeleteLine();
    //begin
    // <<DITW16.00.00.37 DIT-715 #1
    //  Rec.DELETE(true);
    //CurrPage.UPDATE(false);
    // >>DITW16.00.00.37 DIT-715 #1
    //end;

    //procedure _OpenSSCCTrackingLines();
    //begin
    // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //  Rec.OpenSSCCTrackingLines(); 
    //end;

    // procedure OpenSSCCTrackingLines();
    //begin
    // <<DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745
    //Rec.OpenSSCCTrackingLines();
    //end;

    //local procedure TriggerOnDeleteRecord(): Boolean;
    //var
    //  ReservePurchLine: Codeunit "Purch. Line-Reserve";
    //TempRec: Record "Purchase Line" temporary;
    // begin
    // DITW16.00.00.37 DDR 20/07/2010 (moved trigger bugfix RTC collapse page)
    // if (Quantity <> 0) and ItemExists("No.") then begin
    //     COMMIT;
    //     if not ReservePurchLine.DeleteLineConfirm(Rec) then
    //         exit(false);
    // <<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION then begin
    //         if not QualityManagement.DeletePurchLineConfirm(Rec) then
    //             exit(false);
    //     end;
    // >>QXL9.00.001 DAT 23/03/2016
    //     ReservePurchLine.DeleteLine(Rec);
    // <<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION then
    //         QualityManagement.DeletePurchLine(Rec);
    // >>QXL9.00.001 DAT 23/03/2016
    // end;

    // <<DITW15.00.00.36 DDR 23/11/2009
    // if Rec."Is Item Charge" and Rec."ItemCharge Incl. Price" then begin
    //     Rec.DELETE(true);
    //     TempRec := Rec;
    //     TempRec."Direct Unit Cost" := 0;
    //     TempRec."Line Amount" := 0;
    //     TempRec."Line Discount Amount" := 0;
    //<< DITW110.00.11 DDR 10/08/2017 NRQ#24875
    //     TempRec.CalcBackDirectCostItem();
    //>> DITW110.00.11 DDR 10/08/2017 NRQ#24875
    //     exit(false);
    // end;
    // >>DITW15.00.00.01 DDR
    // exit(true);

    //end;

    // procedure SetDisableRefreshLines(NewDisabledRefreshLines: Boolean);
    // begin
    // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
    //     DisabledRefreshLines := NewDisabledRefreshLines;
    // end;

    // local procedure TypeOnAfterValidate();
    // begin
    // <<DITW15.00.00.01 DDR 15/01/2008
    //     if Rec.Type <> xRec.Type then
    //         CurrPage.UPDATE();
    // >>DITW15.00.00.01 DDR
    // end;

    // local procedure VariantCodeOnAfterValidate();
    // begin
    // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //     if (Rec.Type = Rec.Type::Item) and
    //        (xRec."Variant Code" <> Rec."Variant Code")
    //     then
    //         CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    // end;

    //local procedure LocationCodeOnAfterValidate();
    //var
    //begin
    // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //  Not find UpdateIsDone field in Drink IT
    // if (Rec.Type = Rec.Type::Item) and
    //    not Rec.UpdateIsDone
    // then
    //     CurrPage.UPDATE(true);
    //  Not find UpdateIsDone field in Drink IT
    // >>DITW15.00.00.01 DDR
    //end;

    //local procedure QuantityOnAfterValidate();
    //var
    //begin
    // <<DITW15.00.00.01 DDR DDR 15/01/2008
    // Not find UpdateIsDone field in Drink IT
    // if (Rec.Type = Rec.Type::Item) and
    //    (Rec.Quantity <> xRec.Quantity) and
    //    not Rec.UpdateIsDone
    // then
    //     CurrPage.UPDATE(true);
    // Not find UpdateIsDone field in Drink IT
    // >>DITW15.00.00.01 DDR
    //end;

    //   local procedure UnitofMeasureCodeOnAfterValida();
    // var
    // begin
    // <<DITW15.00.00.01 DDR DDR 15/01/2008
    //  Not find UpdateIsDone field in Drink IT
    // if (Rec.Type = Rec.Type::Item) and
    //    not Rec.UpdateIsDone
    // then
    //     CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    //end;

    // local procedure DirectUnitCostOnAfterValidate();
    // begin
    // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Rec.Type = Rec.Type::Item) and
    //        (Rec."Direct Unit Cost" <> xRec."Direct Unit Cost")
    //     then
    //         CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineAmountOnAfterValidate();
    // begin
    // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Rec.Type = Rec.Type::Item) and
    //        (Rec."Line Amount" <> xRec."Line Amount")
    //     then
    //         CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscount37OnAfterValidate();
    // begin
    // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Rec.Type = Rec.Type::Item) and
    //        (Rec."Line Discount %" <> xRec."Line Discount %")
    //     then
    //         CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    // end;

    // local procedure LineDiscountAmountOnAfterValid();
    // begin
    // <<DITW15.00.00.01 DDR 21/12/2007
    //     if (Rec.Type = Rec.Type::Item) and
    //        (Rec."Line Discount Amount" <> xRec."Line Discount Amount")
    //     then
    //         CurrPage.UPDATE(true);
    // >>DITW15.00.00.01 DDR
    // end;

    //local procedure FreeItemOnAfterValidate();
    //begin

    // <<DITW15.00.00.35 DDR 25/06/2009
    // Drink IT Field
    // if (Rec.Type = Rec.Type::Item) and
    //    (xRec."Free Item" <> Rec."Free Item")
    // then
    //     CurrPage.UPDATE(true);<
    // >>DITW15.00.00.35 DDR
    //end;
    // BC UPGRADE SIVA <

    local procedure AllowVATCalculationFreeOnAfter();
    begin
        CurrPage.UPDATE(true);
    end;
    //BC UPGRADE SIVA >> Drink IT code
    // local procedure FreeItemPostingTypeOnAfterVali();
    // begin
    // <<DITW15.00.00.35 DDR 25/06/2009
    //     if Rec.Type = Rec.Type::Item then
    //         CurrPage.UPDATE(true);
    // >>DITW15.00.00.35 DDR
    // end;
    //BC UPGRADE SIVA << Drink IT code

    //BC Upgrade VAMSIU01 - Code added for Document Subtype >>
    local procedure UpdatePaymentStatus(PurchaseLine: Record "Purchase Line");
    var
        PurchaseHeader: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.GET();
        if PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") then
            if PurchaseHeader."Document Subtype Code FND" = PurchasesPayablesSetup."PO Subtype Code FND" then begin
                PurchaseHeader.VALIDATE("Payment Status FND", PurchaseHeader."Payment Status FND"::"Pending Review");
                PurchaseHeader.MODIFY;
            end;
    end;
    //BC Upgrade VAMSIU01 - Code added for Document Subtype <<

}
