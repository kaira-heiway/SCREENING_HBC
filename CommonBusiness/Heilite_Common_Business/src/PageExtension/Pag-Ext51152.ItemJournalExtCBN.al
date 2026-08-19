pageextension 51152 ItemJournalExtCBN extends "Item Journal"
{
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.24 PRODW14.00.00.08.04 DDR 23/09/2008 Added ClearGUID variable to test
    // DITW15.00.00.24 DDR 25/09/2008 Added Drink-it Tax Item Charges functionnalities
    //                             Added columns
    //                                 "Collapse/Expand","Due Tax",
    //                                 "Line No." (not editable)
    //                                 "Item Charge No." (editale only if internal tax)
    //                             Added menus
    //                                 "Insert Item Charges" into button "Functions"
    //                                 "Exppand/Collapse" into button "Line"
    //                                 "Expand All" into button "Line"
    //                                 "Collapse" into button "Line"
    //                             Added functions
    //                                 InsertExtendedCharges()
    //                                 UpdateFields()
    //                                 DoExpandCollapse()
    //                                 DoExpandAll()
    //                                 DoCollapseAll()
    //                                 UpdateFormatField()
    //                                 UpdateExpandStatus()
    // DITW15.00.00.25 DDR 24/10/2008 Added refresh columns
    //                                 "Document no."
    // DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009 License problem
    // DITW15.00.00.30-PRODW14.00.00.09 DDR 21/01/2009 merge PRODW14.00.00.08.05A
    // DITW15.00.00.33 DDR 08/05/2009 Added field "Duty Suspended"
    // DITW15.00.00.34 DDR 15/06/2009 Changed function UpdateFormatField()
    // DITW15.00.00.35-PRODW14.00.00.14 DDR 18/08/2009 issue 767 Added View & Lookup for LotNo. field
    //                 19/09/2009 issue 775 Bugfix to create new record (lost journal template name?)
    //                 29/01/2010 issue 1054
    //                                 Added fields "AAD No. Series","ADD No.",
    //                                 "Tariff No.","item DTax Group Code","Company Tax Registration No."
    //                                 Added menu function 'Assign New AAD No.' into 'Function' button
    // DITW15.00.00.37 DDR 20/05/2010 issue 1081 Added fields "Physical Location Group Code"
    //                 02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 21/06/2010 issue 1150 Added menu in Line button\"Quality Tests"
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW16.00.00.37 DDR 12/07/2010 issue 1194 RTC Page functionnalities
    //                                         Added global variables
    //                                         ActualExpansionStatusInt,TotalLineAmount
    //                                         Added column 1100076000 TotalLineAmount (non-editable,non-visible)
    //                                         Added IsServiceTier() to disable classic collapse
    //                                         Moved C/AL trigger OnDeleteRecord() into new function
    //                                         Moved C/AL trigger OnNewRecord() into new function
    //                                         Added functions
    //                                         RTCActionNewLine(),RTCActionDeleteLine(),RTCActionDeleteLines()
    //                                         TriggerOnDeleteRecord(),TriggrOnNewRecord()
    //                                         Moved all field.Editable from function UpdateFormatField() into UpdateFields()
    //                                         Upgrade function for return value + new 2nd argument
    //                                         <ActualExpansionStatusInt> := ReadExpansionStatus(ActualExpansionStatus,<isServiceTier>)
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //             DDR 30/07/2010           Remove OnFormat() field "No."
    //             CEL 13/08/2010           Modification RTC buttons
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                 Remove functions FormTotalingField()
    //                                 Rewrite functions UpdateFields(),FormTotalingField()
    //                 04/10/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                 Added EMCS fields
    //                                 Modified fields "Due Tax","Duty suspended" as non-editable
    //                 25/10/2010 issue 1139 SSCC Functionnalities
    //                                 Added menu 'SSCC Tracking Lines' in 'Line' buttton
    // DITW15.00.00.38-PRODW14.00.00.17 DDR 14/12/2010 issue 1127 Bugfix don't show Lot column if item tracking line is not required (Produ
    //                                     08/02/2011 issue 1271 Modified 'RunFormLink' property menu 'Quality Tests' ('Line' Button)
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                         Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                         Modified "Item Charge No." as non-editable (function UpdateFields)
    //                                         Removed/Moved CaptionML control23
    // DITW16.00.00.38 DDR 03/02/2011 DIT-715 #59 RTC Page functionnalities
    //                                         Removed the OnLookup Trigger field "Item No."
    // DITW16.00.00.38 DDR 03/03/2011 DIT-715 #1 RTC Upgrade Page functionnalities
    //                                         Modified function UpdateFields()
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #71 RTC Upgrade Page functionnalities
    //                                         Modified order position RTC buttons
    //                                             contol1102601007 RTCNewLine
    //                                             contol1102601008 RTCDeleteLine
    //                                             contol1102601009 RTCDleteAllLines
    //                 16/03/2011 issue 1217 (DIT711 161) Added field "Packaging Type Code"
    //                 18/03/2011 issue 703 Added field "Tax Item no."
    // DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141 RTC Upgrade
    //                                             Added to insert first line automatically
    //                                             Added/Review Total Line Amount (Collapsed RTC)
    // DITW15.00.00.39 PRODW14.00.00.08.18 DDR 18/08/2011 issue 1410
    //                                         Show all Quality tests, Removed source item ledger entry in flowfield
    //                                         Modified 'RunFormLink' menu "Quality Tests"
    // DITW15.00.00.39 DDR 25/08/2011 issue 1393 Added AssistEdit property for field "Item No."
    //                 26/08/2011 issue 1393 Added AssistEdit property/trigger for field "Item No."
    //                 26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    // DITW16.00.00.40 DDR 13/01/2012 DIT-715 #194 Bugfix to insert the first <blank> line while opening the empty journal
    //                                         Bugfix RTC to call the c/al when OpenedFromBatch variable is true
    //                 03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                         Added menuitem "Automatic FEFO Tracking" in menu Line & Functions
    //                                         Moved functions CreateFEFOTracking(),CreateFEFOTrackingJournal() into table83
    //                 03/05/2012 DIT-715 #276 Reviewed to insert all selected items from item treeview lookup form
    //                                         Modified OnAssistEdit trigger field "No."
    //                 13/06/2012 DIT-715 #338 Added 'Period (Items)' menu into button 'Item\Item Item Availability by'
    //                                         Added 'Items by Period' into button 'Item'
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added fields "Work Order"

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars
    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 24/05/2013 DIT-770 #99 Added item charges including "Reason Code"
    //             DDR 12/07/2013 DIT-770 #105 Bugfix lost Template/Batch filters while opening page
    // DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                         Added field Free Reason Code
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.03 DDR 07/04/2014 DIT-770 #559 (old DIT-770 214) Bugfix standard Expand-Collapse (ShowAsTree property) workaround
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    // DITW18.00.06 DDR 25/02/2015 DIT-770 #1189 Multisite - Added field "Responsibility Center"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                     Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Added fields "Scrap Code"
    //                                     Bugfix Expand-Collapse ribbon button position
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Removed 'Editable' property for fields "strength Spec. Value","vol-strength Spec. Value"
    // DITW19.00.08 DDR 09/12/2016 BL#10443 Added fiels "Scrap Quantity"
    // DITW19.00.08A VSC 23/12/2016 BL#10443 Add New Field Reverse Default Visible False
    // DITW19.00.08A VSC 05/01/2017 BL#10443 Remove Field Reverse. User may not change value in this screen. Validation does set the value
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.10 MSF 14/07/2017 NRQ#16224 Several adjustments
    // DITW110.00.10 MSF 18/07/2017 NRQ#16224 Several adjustments
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New field
    //                                     2013637 Deposit Value
    // DITW110.00.11 VSC 03/10/2017 NRQ#18377 Merge XL NRQ#33079
    // DITW110.00.11 AKH 05/10/2017 NRQ#36842 Removed fields "Gen. Bus. Posting Group" & "Gen. Prod. Posting Group"
    // DITW110.00.11 MSF 06/11/2017 NRQ#43572  Added Field Driver Code
    // DITW110.00.11 MSF 06/11/2017 NRQ#43572 Added fields Source No.
    //                                     Added felds Source Type
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    // DITW111.00.13 MSF 13/12/2018 NRQ#94671 check base on Ouststanding Qty
    // DITW110.00.12 MSF 04/05/2018 NRQ#55899 Resp. centre with Phys. Location group and Location code gives conflict - part 3

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    // #new fields Zone Code,New Zone Code and code for these fields

    // HEI.02 FDD HNK GAPLOG002 IBM ISYED01 20/06/2012
    // # Added new field vendor no, vendror name to the page.

    // HEI.03 CHG2211766 PRASAA03 11/07/2023 Approval buttons to Item Journals
    // # Approval Related code added

    // HEI.04 CHG2211766 PRASAA03 02/08/2023 Approval buttons to Item Journals
    // # Approval Related Validations added.

    // HEI.05 CHG2211766 PRASAA03 16/08/2023 Approval buttons to Item Journals
    // # Approval Related Validations added.

    // HEI.06 CHG2219877 PRASAA03 10.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Added Code to check Mandatory fields validation and Item tracking lines exists or not.
    // # Added ReOpen Action to reopen the lines after approval.
    // HEI.07 CHG2219877 PRASAA03 12.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Added changed in Send for Approval Trigger  and new function added CheckItemAvailablity.
    // HEI.08 CHG2219877 PRASAA03 16.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Changed Error Text in CheckItemAvailablity function.
    // HEI.09 CHG2219877 PRASAA03 25.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Added function to get last no. series used and conditions changed.
    // HEI.10 CHG2219877 PRASAA03 30.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Code changed to get last no. series used.
    // # Inventory checking condition changed
    // # Send for approvals and cancel approval actions enable property changed.
    // HEI.11 CHG2219877 PRASAA03 08.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Code changed to Validate Inventory available.
    // HEI.12 CHG2219877 PRASAA03 09.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Code changed to Validate Inventory available.
    // HEI.13 CHG2219877 PRASAA03 10.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Code changed to Validate Applies from Entry No.
    // HEI.14 CHG2219877 PRASAA03 14.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Code changed to Validate Applies from Entry No.
    // HEI.15 CHG2219877 PRASAA03 17.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Code changed to check open approval entries and inventory validation.
    // HEI.16 CHG2219877 PRASAA03 27.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Validation added for entry type Purchase and Sales for scrap journals.
    // HEI.17 CHG2219877 PRASAA03 29.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Validation code moved to function for entry type Purchase, Sales for scrap journals and scrap code.
    // HEI.18 CHG2219877 PRASAA03 01.12.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
    // # Parameter added to function for entry type Purchase, Sales for scrap journals and scrap code.
    // HEI.19 CHG2336029 SS40 17.03.2026 # Workflow Approval Functionality for Stock Adjustments
    //   # New PageAction added : "Comments"
    //   # Made Factbox "RecordLinks" Visible Property to : true

    // BC Upgrade MISHRS14 >>
    // # Tage HEI.19 added and the code related to it.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade SHUKLP03 >>

    // HEI.06 => DrinIT field "Gyle No." is commented.

    // BC Upgrade SHUKLP03 <<
    // BC Upgrade RD03 - added to code to through warning message when item have zero unit cost

    layout
    {
        modify("Bin Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
            begin
                Rec.LookupBin();//HEI.01
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
            begin
                //HEI.04>>
                InventorySetup.GET();
                IF (InventorySetup."SCRAP Jnl. Template FND" = REC."Journal Template Name") AND ((REC."Entry Type" = REC."Entry Type"::"Negative Adjmt.") OR (REC."Entry Type" = REC."Entry Type"::"Positive Adjmt.")) THEN
                    IF REC."Scrap Code" = '' THEN
                        ERROR(Text011, REC."Document No.", REC."Line No.");
                //HEI.04<<
            end;
        }
        modify("Entry Type")
        {
            trigger OnAfterValidate()
            begin
                //HEI.18>>
                //CheckEntryType();
                CheckEntryTypeC(False);

                //HEI.18<<
            end;
        }
        addafter("Location Code")
        {
            // >> HEI.01
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';

            }

            field("New Zone Code"; Rec."New Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the New Zone Code field.';

            }
            // << HEI.01
            // >> HEI.02
            field("Vendor Name"; Rec."Vendor Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.';

            }
            field("Vendor No."; Rec."Vendor No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor No. field.';

            }
            // << HEI.02
            //BC Upgrade Kamnay01 >> Added new field "Invent. Unit of Measure Code" in Item Journal Line
            field("Invent. Unit of Measure Code"; Rec."Invent. Unit of Measur Cod FND")
            {
                ApplicationArea = All;
            }
            //BC Upgrade Kamnay01 << Added new field "Invent. Unit of Measure Code" in Item Journal Line
        }
        //BC Upgrade GUNREM01 >>
        moveafter("Zone Code"; "Bin Code")
        //BC Upgrade GUNREM01 <<
        // BC Upgrade MISHRS14 >>
        modify(Control1900383207)
        {
            visible = true; // HEI.19 - Made Factbox "RecordLinks" Visible Property to : true
        }
        // BC Upgrade MISHRS14 <<

        // BC Upgrade SHUKLP03 >> Testscript changes.
        addafter("Reason Code")
        {
            field("Scrap Code"; Rec."Scrap Code")
            {
                ApplicationArea = ALL;
            }
        }
        // BC Upgrade SHUKLP03 << Testscript changes.
        //BC Upgrade GUNREM01 >> Added new field "Sent for Approval FND" in Item Journal Line 
        addafter("Item No.")
        {
            field("Sent for Approval FND"; Rec."Sent for Approval FND")
            {
                ApplicationArea = ALL;
            }
        }
        //BC Upgrade GUNREM01 << Added new field "Sent for Approval FND" in Item Journal Line 
        addlast(factboxes)
        {
            // part(WorkflowStatusBatch; "Workflow Status FactBox") //BC Version 28.0 Compatibility Fix
            // {
            //     ApplicationArea = Suite;
            //     Editable = false;
            //     Enabled = false;
            //     CaptionML = ENU = 'Batch Workflows', FRA = 'Flux de travail par lots';
            //     ShowFilter = false;
            //     Visible = ShowWorkflowStatusOnBatch;
            // }
            part(WorkflowStatusLine; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                CaptionML = ENU = 'Batch Workflows', FRA = 'Flux de travail par lots';
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnLine;
            }


        }

    }

    actions
    {
        // BC UPGRADE MISHRS14 >>
        // # HEI.19 >>
        addafter("&Recalculate Unit Amount")
        {
            action("Comment")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Comments', FRA = 'Co&mmentaires';
                Image = ViewComments;
                RunObject = Page "Journ. Comment Sheet CBN";
                RunPageLink =
                "Journal Template Name" = FIELD("Journal Template Name"),
                "Journal Batch Name" = FIELD("Journal Batch Name");

            }
        }
        // # HEI.19 <<
        // BC UPGRADE MISHRS14 <<

        // BC Upgrade RD03 - added to code to through warning message when item have zero unit cost -- >>
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                ItemJnlLine: Record "Item Journal Line";
                InventorySetup: Record "Inventory Setup";
            begin
                CheckAppr(); //BC Upgrade GUNREM01 - Added to check approval before posting.
                InventorySetup.Get();

                if not InventorySetup."Activate UnitCost Warn.Msg FND" then
                    exit;

                ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");

                if ItemJnlLine.FindSet() then
                    repeat
                        if (ItemJnlLine."Unit Cost" = 0) then
                            if not Confirm('Item %1 has Unit Cost 0. Do you want to continue posting?', false, ItemJnlLine."Item No.") then
                                Error('Posting has cancelled');
                    until ItemJnlLine.Next() = 0;
            end;
        }
        // BC Upgrade RD03 - added to code to through warning message when item have zero unit cost -- <<
        //BC Upgrade GUNREM01 >> Added new function to check approval before posting and enable posting only when batch is approved.
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                CheckAppr();
            end;
      }
        addafter("Post and &Print")
        {
            group("Request Approval_")
            {
                CaptionML = ENU = 'Request Approval',
                            FRA = 'Approbation demande achat';
                group(SendApprovalRequest_)
                {
                    CaptionML = ENU = 'Send Approval Request',
                                FRA = 'Envoyer demande d''approbation';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequestJournalBatch_)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Journal Batch',
                                    FRA = 'Feuille';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrAnyJnlLineExist;
                        Image = SendApprovalRequest;
                        ToolTipML = ENU = 'Send all journal lines for approval, also those that you may not see because of filters.',
                                    FRA = 'Envoyez toutes les lignes feuilles pour approbation, y compris celles que vous ne voyez peut-être pas à cause de filtres.';
                        trigger OnAction()
                        var
                            Items: Record Item;
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            //HEI.03>>
                            CLEAR(SFA);
                            Rec.SETFILTER(Quantity, '<>0');
                            //HEI.06>>
                            IF Rec.FINDSET(FALSE) THEN BEGIN
                                Rec.SETRANGE(Quantity);
                                IF Rec.FINDSET(FALSE) THEN
                                    REPEAT
                                        //HEI.18>>
                                        //CheckEntryType();//HEI.17
                                        CheckEntryTypeC(TRUE);
                                        //HEI.18<<
                                        CheckMandatoryFields();
                                        //HEI.13>>
                                        //IF Items.GET("Item No.") AND (Items."Item Tracking Code" <> '') THEN
                                        //CheckReservationEntries()
                                        IF Items.GET(Rec."Item No.") THEN
                                            IF (Items."Item Tracking Code" <> '') THEN
                                                CheckReservationEntries()
                                            ELSE IF (Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt.") AND (Rec."Scrap Code" <> '') THEN //HEI.14
                                                Rec.TESTFIELD(Rec."Applies-from Entry");
                                        //HEI.13<<
                                        CheckItemAvailablity();//HEI.07
                                    UNTIL Rec.NEXT = 0;
                            END;
                            //HEI.06<<
                            IF Rec.FINDSET THEN BEGIN
                                Rec.SETRANGE(Quantity);
                                IF Rec.FINDSET THEN BEGIN
                                    HeinBCUpgrade.SendItemJournalBatchApprovalRequest(Rec);
                                    SetControlAppearance;
                                    REPEAT
                                        IsValid(TRUE);
                                        Rec."Sent for Approval FND" := TRUE;
                                        Rec.MODIFY(false);
                                    UNTIL Rec.NEXT = 0;
                                    SFA := FALSE;
                                END;
                            END ELSE
                                ERROR(Test014);
                            //HEI.03<<
                        end;
                    }

                }
                group(CancelApprovalRequest_) //BC Version 28.0 Compatibility Fix
                {
                    CaptionML = ENU = 'Cancel Approval Request',
                                FRA = 'Annuler demande d''approbation';
                    Image = Cancel;
                    action(CancelApprovalRequestJournalBatch_) //BC Version 28.0 Compatibility Fix
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Journal Batch',
                                    FRA = 'Feuille';
                        Enabled = CanCancelApprovalForJnlBatch;
                        Image = CancelApprovalRequest;
                        ToolTipML = ENU = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.',
                                    FRA = 'Annulez l''envoi de toutes les lignes feuilles pour approbation, y compris celles que vous ne voyez peut-être pas à cause de filtres.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            //HEI.03>>
                            CLEAR(SFA);
                            HeinBCUpgrade.CancelItemJournalBatchApprovalRequest(Rec);
                            SetControlAppearance;
                            IF Rec.FINDSET THEN BEGIN
                                REPEAT
                                    IsValid(TRUE);
                                    Rec."Sent for Approval FND" := FALSE;
                                    Rec.MODIFY(false);
                                UNTIL Rec.NEXT = 0;
                                SFA := FALSE;
                            END;
                            //HEI.03<<
                        end;

                    }
                    action("Requests to Approve")
                    {
                        Image = Approvals;
                        ApplicationArea = All;
                        ToolTip = 'Executes the Requests to Approve action.';

                        trigger OnAction();
                        var
                            ApprovalEntryL: Record "Approval Entry";
                            Text001L: Label 'Item Journal Batch: %1,%2';
                            RecIDL: Text[100];
                        begin
                            //HEI.03>>
                            IF Rec.FINDFIRST THEN
                                RecIDL := STRSUBSTNO(Text001L, Rec."Journal Template Name", Rec."Journal Batch Name");
                            ApprovalEntryL.SETRANGE("Table ID", DATABASE::"Item Journal Batch");
                            ApprovalEntryL.SETFILTER("Record ID to Approve", RecIDL);
                            IF ApprovalEntryL.FINDLAST THEN
                                PAGE.RUNMODAL(PAGE::"Requests to Approve", ApprovalEntryL);
                            //HEI.03<<
                        end;
                    }
                    action(ReOpen)
                    {
                        Image = ReOpen;
                        ApplicationArea = All;
                        ToolTip = 'Executes the ReOpen action.';

                        trigger OnAction();
                        begin
                            CheckandReopen();
                        end;
                    }
                }
            }
        }
        modify(CancelApprovalRequest)  //BC Version 28.0 Compatibility Fix
        {
            Visible = false;
            Enabled = false;
        }
        modify("Request Approval") //BC Version 28.0 Compatibility Fix
        {
            Visible = false;
            Enabled = false;
        }
        //BC Upgrade GUNREM01 <<Added new function to check approval before posting and enable posting only when batch is approved.

    }

    var
        InventorySetup: Record "Inventory Setup";
        Noserires: Record "No. Series";
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        SFA: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        LastNose: Code[20];
        LastNose2: Code[20];
        Test002L: TextConst ENU = 'This Batch - %1 cannot be posted while it is awaiting approval.';
        Test015: TextConst ENU = 'JournalLines  cannot be modified while the batch is requested for approval.';
        Test016: TextConst ENU = 'Journal Lines Journal cannot be deleted while the batch is requested for approval.';
        Test018: TextConst ENU = 'This Batch - %1 cannot be posted until it is approved.';
        Text001L: TextConst ENU = 'Item Journal Batch: %1,%2';
        Text011: TextConst ENU = 'Scrap Code cannot be Blank for the Transaction %1, Line No. %2.';
        Text013: TextConst ENU = 'For No. Series %1 Last Posting No. series is %2 should be same for Document No. %3';
        Text014: TextConst ENU = 'Can not reopen when record is in Approval Process.';
        Text015: TextConst ENU = 'Item Tracking for Line no %1 and Item No. %2 is not fully assigned.';
        Text016: TextConst ENU = 'Select Item Tracking for Line no %1 and Item No. %2.';
        Text017: TextConst ENU = 'Inventory is not sufficient for Line no %1 and Item No. %2. Available Qty is %3 and required quantity is %4';
        Text018: TextConst ENU = 'Inventory not available for Line no %1 and Item No. %2.';
        //BC Upgrade GUNREM01 >>
        HeinBCUpgrade: Codeunit "Heineken BC Upgrade";
        Test014: Label 'There is no difference in Quantity to send for approval.';
    //BC Upgrade GUNREM01 <<
    trigger OnModifyRecord(): Boolean
    var
    begin
        //HEI.04>>
        IF NOT SFA THEN
            ValidateJournal()
        else
            CLEAR(SFA);
        //HEI.04<<
    end;

    trigger OnDeleteRecord(): Boolean
    var
    begin
        //HEI.04>>
        IF Rec."Sent for Approval FND" THEN
            ERROR(Test016);
        //HEI.04<<
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        //HEI.04>>
        SetControlAppearance();
        //HEI.04<<
    end;

    LOCAL procedure SetControlAppearance()
    var
        ItemJournalBatch: Record "Item Journal Batch";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HeinekenBcUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.03>>
        IF ItemJournalBatch.GET(Rec."Journal Template Name", Rec."Journal Batch Name") THEN BEGIN
            ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(ItemJournalBatch.RECORDID);
            OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(ItemJournalBatch.RECORDID);
            OpenApprovalEntriesOnJnlBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(ItemJournalBatch.RECORDID);
        end;
        OpenApprovalEntriesExistForCurrUser := OpenApprovalEntriesExistForCurrUser OR
        ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesOnJnlLineExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        OpenApprovalEntriesOnBatchOrCurrJnlLineExist := OpenApprovalEntriesOnJnlBatchExist OR OpenApprovalEntriesOnJnlLineExist;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist := OpenApprovalEntriesOnJnlBatchExist OR
        HeinekenBcUpgrade.HasAnyOpenItemJournalLineApprovalEntries(Rec."Journal Template Name", Rec."Journal Batch Name");

        ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);

        CanCancelApprovalForJnlBatch := ApprovalsMgmt.CanCancelApprovalForRecord(ItemJournalBatch.RECORDID);
        CanCancelApprovalForJnlLine := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
        //HEI.03<<
    end;

    LOCAL procedure GetCurrentlySelectedLines(VAR ItemJournalLine: Record "Item Journal Line"): Boolean
    begin
        //HEI.03>>
        CurrPage.SETSELECTIONFILTER(ItemJournalLine);
        EXIT(ItemJournalLine.findset());
        //HEI.03<<
    end;

    LOCAL procedure ValidateJournal()
    begin
        //HEI.03>>
        IF Rec."Sent for Approval FND" THEN
            ERROR(Test015);
        //HEI.03<<
    end;

    LOCAL procedure ValidatePreApproval(VAR ItemJournalLine: Record "Item Journal Line")
    var
        ApprovalEntryL: Record "Approval Entry";
        ItemJournalBatch1L: Record "Item Journal Batch";
        ItemJournalBatchL: Record "Item Journal Batch";
        ItemJournalLineL: Record "Item Journal Line";
        RecRefL: RecordRef;
        RecIDL: Text[100];
    begin
        //HEI.03>>
        IF ItemJournalLine.FINDFIRST() THEN
            RecIDL := STRSUBSTNO(Text001L, ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name");
        ApprovalEntryL.SETRANGE("Table ID", DATABASE::"Item Journal Batch");
        ApprovalEntryL.SETFILTER("Record ID to Approve", RecIDL);
        //HEI.15>>
        //ApprovalEntryL.SETFILTER(Status,'<>%1',ApprovalEntryL.Status::Approved);
        ApprovalEntryL.SETRANGE(Status, ApprovalEntryL.Status::Open);
        //HEI.15<<
        IF ApprovalEntryL.FINDLAST() THEN BEGIN
            //IF ApprovalEntryL.Status = ApprovalEntryL.Status::Open THEN //HEI.15
            ERROR(Test002L, ItemJournalLine."Journal Batch Name");
        end;
        //HEI.03<<
    end;

    LOCAL procedure IsValid(Valid: Boolean)
    begin
        //HEI.03>>
        SFA := Valid;
        //HEI.03<<
    end;

    LOCAL procedure CheckAppr()
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        //HEI.05>>
        IF Rec."Sent for Approval FND" THEN
            ValidatePreApproval(Rec)
        else BEGIN
            ItemJournalBatch.RESET();
            ItemJournalBatch.SETCURRENTKEY("Journal Template Name", Name, "Use in Workflow FND");
            ItemJournalBatch.SETRANGE("Journal Template Name", Rec."Journal Template Name");
            ItemJournalBatch.SETRANGE(Name, Rec."Journal Batch Name");
            ItemJournalBatch.SETRANGE("Use in Workflow FND", TRUE);
            IF ItemJournalBatch.FINDFIRST() THEN
                ERROR(Test018, Rec."Journal Batch Name");
        end;
        //HEI.05<<
    end;

    LOCAL procedure CheckMandatoryFields()
    var
        ItemJournalBatch: Record "Item Journal Batch";
        NoSeriesManagement: Codeunit "No. Series";
    begin
        //HEI.06>>
        ItemJournalBatch.RESET();
        ItemJournalBatch.SETCURRENTKEY("Journal Template Name", Name, "Use in Workflow FND");
        ItemJournalBatch.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        ItemJournalBatch.SETRANGE(Name, Rec."Journal Batch Name");
        ItemJournalBatch.SETRANGE("Use in Workflow FND", TRUE);
        IF ItemJournalBatch.FINDFIRST() THEN BEGIN
            Rec.TESTFIELD("Item No.");
            Rec.TESTFIELD("Location Code");
            Rec.TESTFIELD("Zone Code FND");
            Rec.TESTFIELD("Bin Code");
            IF ItemJournalBatch."Mand. Global DImension 1 FND" THEN
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
            IF ItemJournalBatch."Mand. Global DImension 2 FND" THEN
                Rec.TESTFIELD("Shortcut Dimension 2 Code");
            //HEI.09>>
            IF ItemJournalBatch."No. Series" <> '' THEN BEGIN
                LastNose := ItemJournalBatch."No. Series";
                UpdateLine(LastNose2);
                IF Rec."Document No." <> LastNose2 THEN
                    ERROR(Text013, ItemJournalBatch."No. Series", LastNose2, Rec."Document No.");
            end;
            //HEI.09<<
        end;
        //HEI.06<<
    end;

    LOCAL procedure CheckandReopen()
    var
        RestrictedRecord: Record "Restricted Record";
    begin
        //HEI.06>>
        RestrictedRecord.RESET();
        RestrictedRecord.SETRANGE("Record ID", Rec.RECORDID);
        IF RestrictedRecord.FINDFIRST() THEN
            ERROR(Text014);
        Rec.SETFILTER(Quantity, '<>0');
        IF Rec.findset() THEN BEGIN
            Rec.SETRANGE(Quantity);
            IF Rec.findset() THEN
                REPEAT
                    Rec."Sent for Approval FND" := FALSE;
                    Rec.MODIFY(TRUE);
                UNTIL Rec.NEXT() = 0;
        end;
        //HEI.06<<
    end;

    LOCAL procedure CheckReservationEntries()
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        //HEI.06>>
        ReservationEntry.RESET();
        ReservationEntry.SETRANGE("Source ID", Rec."Journal Template Name");
        ReservationEntry.SETRANGE("Source Type", 83);
        //HEI.09>>
        IF Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt." THEN
            ReservationEntry.SETRANGE("Source Subtype", 2)
        else
            IF Rec."Entry Type" = Rec."Entry Type"::"Negative Adjmt." THEN
                ReservationEntry.SETRANGE("Source Subtype", 3);
        //HEI.09<<
        ReservationEntry.SETRANGE("Source Batch Name", Rec."Journal Batch Name");
        ReservationEntry.SETRANGE("Source Prod. Order Line", 0);
        ReservationEntry.SETRANGE("Source Ref. No.", Rec."Line No.");
        ReservationEntry.SETRANGE("Item No.", Rec."Item No.");
        ReservationEntry.SETRANGE("Location Code", Rec."Location Code");
        ReservationEntry.SETRANGE("Variant Code", Rec."Variant Code");
        //ReservationEntry.SETRANGE("Gyle No.", ''); // BC Upgrade SHUKLP03 << DrinIT field "Gyle No." is commented.
        IF ReservationEntry.findset() THEN BEGIN
            //HEI.12>>
            IF (Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt.") AND (Rec."Scrap Code" <> '') THEN //HEI.14
                ReservationEntry.TESTFIELD("Appl.-from Item Entry");
            //HEI.12<<
            ReservationEntry.CALCSUMS("Qty. to Handle (Base)");
            IF ABS(ReservationEntry."Qty. to Handle (Base)") <> Rec."Quantity (Base)" THEN //HEI.07
                ERROR(Text015, Rec."Line No.", Rec."Item No.");
        end else
            ERROR(Text016, Rec."Line No.", Rec."Item No.");//HEI.07
        //HEI.06<<
    end;

    LOCAL procedure CheckItemAvailablity()
    var
        BinContent: Record "Bin Content";
        ItemLedgerEntries: Record "Item Ledger Entry";
    begin
        //HEI.07>>
        //HEI.10>
        IF NOT (Rec."Entry Type" = Rec."Entry Type"::"Negative Adjmt.") THEN
            EXIT;
        //HEI.10<<
        //HEI.11>>
        BinContent.RESET();
        BinContent.SETCURRENTKEY("Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code");
        BinContent.SETRANGE("Location Code", Rec."Location Code");
        BinContent.SETRANGE("Bin Code", Rec."Bin Code");
        BinContent.SETRANGE("Item No.", Rec."Item No.");
        BinContent.SETRANGE("Variant Code", Rec."Variant Code");
        //BinContent.SETRANGE("Unit of Measure Code","Unit of Measure Code");//HEI.15
        IF BinContent.FINDFIRST() THEN BEGIN
            //HEI.15>>
            BinContent.CALCFIELDS("Quantity (Base)");
            IF BinContent."Quantity (Base)" < Rec."Quantity (Base)" THEN
                ERROR(Text017, Rec."Line No.", Rec."Item No.", BinContent."Quantity (Base)", Rec."Quantity (Base)");
            // {
            // BinContent.CALCFIELDS(Quantity);
            //     IF BinContent.Quantity < Quantity THEN
            //         ERROR(Text017, "Line No.", "Item No.", BinContent.Quantity, Quantity);
            // }
            //HEI.15<<
        end else
            ERROR(Text018, Rec."Line No.", Rec."Item No.");//HEI.08
        // {
        // ItemLedgerEntries.RESET;
        // ItemLedgerEntries.SETCURRENTKEY("Item No.","Variant Code","Location Code",Open,"Zone Code","Bin Code");
        // ItemLedgerEntries.SETRANGE("Item No.","Item No.");
        // ItemLedgerEntries.SETRANGE("Variant Code","Variant Code");
        // ItemLedgerEntries.SETRANGE("Location Code","Location Code");
        // ItemLedgerEntries.SETRANGE(Open,TRUE);
        // IF "Zone Code" <> '' THEN
        // ItemLedgerEntries.SETRANGE("Zone Code","Zone Code");
        // IF "Bin Code" <> '' THEN
        // ItemLedgerEntries.SETRANGE("Bin Code","Bin Code");
        // IF ItemLedgerEntries.findset(FALSE,FALSE) THEN BEGIN
        // ItemLedgerEntries.CALCSUMS("Remaining Quantity");
        // IF ItemLedgerEntries."Remaining Quantity" < Quantity THEN
        // ERROR(Text017,"Line No.","Item No.",ItemLedgerEntries."Remaining Quantity",Quantity);
        // end else
        // ERROR(Text018,"Line No.","Item No.");//HEI.08
        // }
        //HEI.11<<
        //HEI.07<<
    end;

    LOCAL PROCEDURE FindNoSeriesLineToShow(VAR NoSeriesLine: Record "No. Series Line")
    var
        NoSeriesMgt: Codeunit "No. Series";
        StartDate: Date;
    BEGIN
        //HEI.09>>
        //NoSeriesMgt.SetNoSeriesLineFilter(NoSeriesLine, LastNose, 0D); // BC Upgrade SHUKLP03 << Blocked this code because procedure SetNoSeriesLineFilter is removed. Instead of procedure event OnSetNoSeriesLineFilter is add to add custom filters.

        // BC Upgrade SHUKLP03 << Added code of procedure SetNoSeriesLineFilter.
        IF StartDate = 0D THEN
            StartDate := WORKDATE();
        NoSeriesLine.RESET();
        NoSeriesLine.SETCURRENTKEY("Series Code", "Starting Date");
        NoSeriesLine.SETRANGE("Series Code", LastNose);
        NoSeriesLine.SETRANGE("Starting Date", 0D, StartDate);
        IF NoSeriesLine.FINDLAST() THEN BEGIN
            NoSeriesLine.SETRANGE("Starting Date", NoSeriesLine."Starting Date");
            NoSeriesLine.SETRANGE(Open, TRUE);
            IF NoSeriesLine.FINDLAST() THEN
                EXIT;
        end;
        // BC Upgrade SHUKLP03 << Added code of procedure SetNoSeriesLineFilter.

        NoSeriesLine.RESET();
        NoSeriesLine.SETRANGE("Series Code", LastNose);
        //HEI.09<<
    end;

    LOCAL PROCEDURE CheckEntryTypeC(CheckScrapCode: Boolean)
    BEGIN
        //HEI.17>>
        //Parameter is added to the function //HEI.18
        InventorySetup.GET();
        IF (InventorySetup."SCRAP Jnl. Template FND" = Rec."Journal Template Name") THEN BEGIN
            IF ((Rec."Entry Type" = Rec."Entry Type"::Sale) OR (Rec."Entry Type" = Rec."Entry Type"::Purchase)) THEN
                ERROR('Entry type %1 is not allowed For Scrap journals.', Rec."Entry Type");
            //IF "Scrap Code" = '' THEN //HEI.18
            IF CheckScrapCode AND (Rec."Scrap Code" = '') THEN //HEI.18
                ERROR(Text011, Rec."Document No.", Rec."Line No.");
        end;
        //HEI.17<<
    end;

    procedure UpdateLine(VAR LastNoUsed: Code[20])
    var
        NoSeriesLine: Record "No. Series Line";
    begin
        //HEI.09>>
        FindNoSeriesLineToShow(NoSeriesLine);
        IF NOT NoSeriesLine.FINDFIRST() THEN
            NoSeriesLine.INIT();
        //LastNoUsed := NoSeriesLine."Last No. Used";//HEI.10
        LastNoUsed := INCSTR(NoSeriesLine."Last No. Used");//HEI.10
        //HEI.09<<
    end;



}


