pageextension 51159 PhysicalInventoryJournalExtCBN extends "Phys. Inventory Journal"
{
    /*
        HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
            # new fields Zone Code
        HEI.02 CHG2026978 KUMARN15 14.10.2019
            # Added fields created "Qty. (Calculated) in Inv. UoM", "Qty. (Phys. Inv.) in Inv. UoM", "Quantity in Inv. UoM", "Invent. Unit of Measure Code"
        HEI.03 CHG2026978 IBM.LS      15.11.2019
            # New Field added - Freeze Batch Lines
            # New Buttons created - Freeze Phys. Invt. Jnl.
                                - Unfreeze Phys. Invt. Jnl.
            # Code added to execute the new Buttons.
            # Code added to restrict the deletion of froze batch lines.
            # New Buttons created - Auto Negative Adjmt. Lot Assign
                                - Remove Negative Adjmt. Lot Track
            # Code added to insert Reservation Entry Lines.
            # Code added to remove Reservation Entry Lines.
            # Fields added - Quantity (Base)
                        - Invoiced Qty. (Base)
                        - Reserved Qty. (Base)
                        - Invoiced Quantity
                        - Reserved Quantity

        HEI.05 CHG2050741 IBM.LS 10.02.2020
            # Text Constant (Text003) corrected.
        HEI.06 CHG2049056 IBM.LS      02.03.2021
            # Created New Group - Request Approval
            # Created New Menu - Send Approval Request
                            - Cancel Approval Request
                            - Requests to Approve
            # Added Part Page - Batch Workflows
            # Added New Field - Sent for Approval
            # Added Code
        DITW110.00.12 MSF 04/05/2018 NRQ#55899 Resp. centre with Phys. Location group and Location code gives conflict - part 3

        HEI.07 CHG2219877 PRASAA03 10.10.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
            # Added Code to check Mandatory fields validation and Item tracking lines exists or not.
            # Added ReOpen Action to reopen the lines after approval.

        HEI.08 CHG2219877 PRASAA03 09.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
            # Changed code in checkreservation entry function.

        HEI.09 CHG2219877 PRASAA03 10.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
            # Changed code to validate Applies from Entry No.

        HEI.10 CHG2219877 PRASAA03 14.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
            # Commented code to validate Applies from Entry No.

        HEI.11 CHG2219877 PRASAA03 15.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
            # Commented code to validate Applies from Entry No. and quantity.

        HEI.12 CHG2219877 PRASAA03 17.11.2023 "Workflow approval interface warning messages and link in e-mail notification improvement"
            # Changed code to check approval entries.
    */

    /*
        BC UPGRADE PATELS08 >>
            # Added HEI tags (HEI.01-HEI.12) as compared to NAV object. 
            # Moved declaration of UserSetupL, HeinBCUpgrade variable to Global scope to avoid defining it multiple times in different triggers.
            # In SendApprovalRequestJournalBatch action,  changed ApprovalsMgmt.SendItemJournalBatchApprovalRequest(Rec); to as HeinBCUpgrade.SendItemJournalBatchApprovalRequest(Rec);
            # In CancelApprovalRequestJournalBatch action, changed ApprovalsMgmt.CancelItemJournalBatchApprovalRequest(Rec); to HeinBCUpgrade.CancelItemJournalBatchApprovalRequest(Rec);
            # In SetControlAppearance procedure, changed ApprovalsMgmt.HasAnyOpenItemJournalLineApprovalEntries to HeinBCUpgrade.HasAnyOpenItemJournalLineApprovalEntries.
        BC UPGRADE PATELS08 <<
    */
    //PATHAA02 BUGFIX 10.04.26 "Reason Code" is getting saved on Physical Inv Jnl.Added application area property

    // BC Upgrade MISHRS14 >>
    // Added HEI.13 Tag
    // HEI.13 CHG2336029/CHG2356204 SS40 07.05.2026 # Workflow Approval Functionality for Stock Adjustments
    // # New PageAction added : "Comments"
    // # Made Factbox "RecordLinks" Visible Property to : true
    // # CHG2356204 Added to complete the Workflow functionality, 07.05.2026
    // BC Upgrade MISHRS14 <<

    layout
    {
        //PATHAA02>>
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies a reason code to attach to the entry.', FRA = 'Indique un code motif à associer à l''écriture.';
            ApplicationArea = All;
        }
        //PATHAA02<<

        addafter("Location Code")
        {
            // HEI.01 >>
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
            }
            // HEI.01 <<
        }
        //BC Upgrade GUNREM01 >>
        moveafter("Zone Code"; "Bin Code")    
        modify("Bin Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
            begin
                Rec.LookupBin();
            end;
        }
        //BC Upgrade GUNREM01 <<
        addafter("Item No.")
        {
            // HEI.03 >>
            field("Freeze Batch Lines"; Rec."Freeze Batch Lines FND")
            {
                Visible = false;
                ApplicationArea = All;
            }
            // HEI.03 <<

            // HEI.06 >>
            field("Sent for Approval"; Rec."Sent for Approval FND")
            {
                ApplicationArea = All;
            }
            // HEI.06 <<

            // HEI.02 >>
            field("Invent. Unit of Measure Code"; Rec."Invent. Unit of Measur Cod FND")
            {
                ApplicationArea = All;
            }
            field("Qty. (Calculated) in Inv. UoM"; Rec."Qty. (Calc.) in Inv. UoM FND")
            {
                ApplicationArea = All;
            }
            field("Qty. (Phys. Inv.) in Inv. UoM"; Rec."Qty. Phys. Inv. in Inv.UoM FND")
            {
                ApplicationArea = All;
            }
            field("Quantity in Inv. UoM"; Rec."Quantity in Inv. UoM FND")
            {
                ApplicationArea = All;
            }
            // HEI.02 <<

            // HEI.03 >>
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
            }
            field("Invoiced Quantity"; Rec."Invoiced Quantity")
            {
                ApplicationArea = All;
            }
            field("Invoiced Qty. (Base)"; Rec."Invoiced Qty. (Base)")
            {
                ApplicationArea = All;
            }
            field("Reserved Quantity"; Rec."Reserved Quantity")
            {
                ApplicationArea = All;
            }
            field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
            {
                ApplicationArea = All;
            }
            // HEI.03 <<
        }
        // HEI.06 >>
        addfirst(factboxes)
        {
            // part(WorkflowStatusBatch; "Workflow Status FactBox") //BC Version 28.0 Compatibility Fix
            // {
            //     ApplicationArea = Suite;
            //     CaptionML = ENU = 'Batch Workflows',
            //                 FRA = 'Flux de travail par lots';
            //     Editable = false;
            //     Enabled = false;
            //     ShowFilter = false;
            //     Visible = ShowWorkflowStatusOnBatch;
            // }
            part(WorkflowStatusLine; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                CaptionML = ENU = 'Line Workflows',
                            FRA = 'Flux de travail ligne';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatusOnLine;
            }
        }
        // HEI.06 <<

        // BC Upgrade MISHRS14 >>
        modify(Control1900383207)
        {
            visible = true; // HEI.13 Tag added "RecordLinks" Visible Property to : true
        }
        // BC Upgrade MISHRS14 <<
    }

    actions
    {
        // BC Upgrade MISHRS14 >>
        // HEI.13 Tag added
        addafter("Bin Contents")
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

                ToolTip = 'View or enter comments for the journal batch.';
            }
        }
        // BC Upgrade MISHRS14 <<

        // HEI.06 >>
        modify(CalculateInventory)
        {
            CaptionML = ENU = 'Calculate &Inventory', FRA = 'C&alculer quantité en stock';
            ToolTipML = ENU = 'Start the process of calculating inventory value by importing items into the journal.', FRA = 'Démarrez le processus de calcul de valeur du stock en important des articles dans le journal.';
            trigger OnBeforeAction()
            begin
                IF Rec."Sent for Approval FND" THEN
                    ERROR(Test017);
            end;
        }
        modify(CalculateCountingPeriod)
        {
            CaptionML = ENU = '&Calculate Counting Period', FRA = '&Calculer période inventaire';
            ToolTipML = ENU = 'Show all items that a counting period has been assigned to, according to the counting period, the last counting period update, and the current work date.', FRA = 'Affichez tous les articles auxquels une période d''inventaire a été affectée, en fonction de la période d''inventaire, de la dernière mise à jour de cette période et de la date de travail actuelle.';
            trigger OnBeforeAction()
            begin
                IF Rec."Sent for Approval FND" THEN
                    ERROR(Test017);
            end;
        }

        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            trigger OnBeforeAction()
            var
                ItemJournalBatch: Record "Item Journal Batch";
            begin
                IF Rec."Sent for Approval FND" THEN
                    ValidatePreApproval(Rec)
                else BEGIN
                    ItemJournalBatch.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJournalBatch.SETRANGE(Name, Rec."Journal Batch Name");
                    ItemJournalBatch.SETRANGE("Use in Workflow FND", TRUE);
                    IF ItemJournalBatch.FINDFIRST() THEN
                        ERROR(Test018, Rec."Journal Batch Name");
                end;
            end;

        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
            ToolTipML = ENU = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.', FRA = 'Finalisez et préparez-vous à imprimer le document ou la feuille. Les valeurs et les quantités sont validées en fonction des comptes associés. Une fenêtre de demande d''état où vous pouvez spécifier ce qu''il faut inclure sur l''élément à imprimer.';
            trigger OnBeforeAction()
            var
                ItemJournalBatch: Record "Item Journal Batch";
            begin
                IF Rec."Sent for Approval FND" THEN
                    ValidatePreApproval(Rec)
                else BEGIN
                    ItemJournalBatch.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJournalBatch.SETRANGE(Name, Rec."Journal Batch Name");
                    ItemJournalBatch.SETRANGE("Use in Workflow FND", TRUE);
                    IF ItemJournalBatch.FINDFIRST() THEN
                        ERROR(Test018, Rec."Journal Batch Name");
                end;
            end;
        }
        // HEI.06 <<    

        addafter(CalculateCountingPeriod)
        {
            // HEI.03 >>
            action("Freeze Phys. Invt. Jnl.")
            {
                Image = Close;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ItemJnlLineL: Record "Item Journal Line";
                    UserSetupL: Record "User Setup";
                begin
                    ItemJnlLineL.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLineL.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnlLineL.SETRANGE("Freeze Batch Lines FND", false);
                    if ItemJnlLineL.findset() then begin
                        UserSetupL.GET(USERID);
                        if not UserSetupL."Freeze/Unfreez PhysInvtJnl.FND" then
                            ERROR(Text004);
                        ItemJnlLineL.MODIFYALL("Freeze Batch Lines FND", true);
                        MESSAGE(Text001);
                    end else
                        ERROR(Text006);
                end;
            }
            action("Unfreeze Phys. Invt. Jnl.")
            {
                Image = ReOpen;
                ApplicationArea = All;
                trigger OnAction();
                var
                    ItemJnlLineL: Record "Item Journal Line";
                    UserSetupL: Record "User Setup";
                begin
                    ItemJnlLineL.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLineL.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnlLineL.SETRANGE("Freeze Batch Lines FND", true);
                    if ItemJnlLineL.findset() then begin
                        UserSetupL.GET(USERID);
                        if not UserSetupL."Freeze/Unfreez PhysInvtJnl.FND" then
                            ERROR(Text005);
                        ItemJnlLineL.MODIFYALL("Freeze Batch Lines FND", false);
                        MESSAGE(Text002);
                    end else
                        ERROR(Text007);
                end;
            }
            action("Auto Negative Adjmt. Lot Assign")
            {
                Image = Insert;
                ApplicationArea = All;
                trigger OnAction();
                var
                    ItemJnlLineL: Record "Item Journal Line";
                    ReservationEntryL: Record "Reservation Entry";
                    UserSetupL: Record "User Setup";
                    RECreatedL: Boolean;
                begin

                    ItemJnlLineL.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLineL.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnlLineL.SETRANGE("Entry Type", Rec."Entry Type"::"Negative Adjmt.");
                    ItemJnlLineL.SETFILTER("Qty. (Phys. Inventory)", '<>0');
                    if ItemJnlLineL.ISEMPTY then begin
                        ItemJnlLineL.SETRANGE("Qty. (Phys. Inventory)");
                        ItemJnlLineL.SETFILTER("Qty. Phys. Inv. in Inv.UoM FND", '<>0');
                        if ItemJnlLineL.ISEMPTY then
                            ERROR(Text009);
                    end;
                    if ItemJnlLineL.FIND('-') then begin
                        UserSetupL.GET(USERID);
                        repeat
                            ReservationEntryL.RESET();
                            ReservationEntryL.SETRANGE("Source ID", Rec."Journal Template Name");
                            ReservationEntryL.SETRANGE("Source Batch Name", Rec."Journal Batch Name");
                            ReservationEntryL.SETRANGE("Source Ref. No.", ItemJnlLineL."Line No.");
                            ReservationEntryL.SETRANGE("Source Type", 83);
                            ReservationEntryL.SETRANGE("Source Subtype", ItemJnlLineL."Entry Type");
                            ReservationEntryL.SETRANGE("Reservation Status", ReservationEntryL."Reservation Status"::Prospect);
                            ReservationEntryL.SETRANGE("Source Prod. Order Line", 0);
                            if not ReservationEntryL.FINDFIRST() then begin
                                Rec.CreateReservationEntries(Rec."Journal Template Name", Rec."Journal Batch Name", ItemJnlLineL."Line No.");
                                RECreatedL := true;
                            end;
                        until ItemJnlLineL.NEXT() = 0;
                        if RECreatedL then
                            MESSAGE(Text008)
                        else
                            ERROR(Text012);
                    end;
                end;
            }
            action("Remove Negative Adjmt. Lot Track")
            {
                Image = Delete;
                ApplicationArea = All;
                trigger OnAction();
                var
                    ReservationEntryL: Record "Reservation Entry";
                    UserSetupL: Record "User Setup";
                begin
                    ReservationEntryL.SETRANGE("Source ID", Rec."Journal Template Name");
                    ReservationEntryL.SETRANGE("Source Batch Name", Rec."Journal Batch Name");
                    ReservationEntryL.SETRANGE("Source Ref. No.", Rec."Line No.");
                    ReservationEntryL.SETRANGE("Source Type", 83);
                    ReservationEntryL.SETRANGE("Source Subtype", Rec."Entry Type"::"Negative Adjmt.");
                    ReservationEntryL.SETRANGE("Reservation Status", ReservationEntryL."Reservation Status"::Prospect);
                    ReservationEntryL.SETRANGE("Source Prod. Order Line", 0);
                    if ReservationEntryL.FIND('-') then begin
                        UserSetupL.GET(USERID);
                        repeat
                            ReservationEntryL.DELETE();
                        until ReservationEntryL.NEXT() = 0;
                        MESSAGE(Text010);
                    end else
                        ERROR(Text011);
                end;
            }
            // HEI.03 <<
        }

        addafter("Post and &Print")
        {
            // HEI.06 >>   
            group("Request Approval_") //BC Version 28.0 Compatibility Fix
            {
                CaptionML = ENU = 'Request Approval',
                            FRA = 'Approbation demande achat';
                group(SendApprovalRequest_)  //BC Version 28.0 Compatibility Fix
                {
                    CaptionML = ENU = 'Send Approval Request',
                                FRA = 'Envoyer demande d''approbation';
                    Image = SendApprovalRequest;
                    action(SendApprovalRequestJournalBatch_) //BC Version 28.0 Compatibility Fix
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Journal Batch',
                                    FRA = 'Feuille';
                        Enabled = NOT OpenApprovalEntriesOnBatchOrAnyJnlLineExist;
                        Image = SendApprovalRequest;
                        ToolTipML = ENU = 'Send all journal lines for approval, also those that you may not see because of filters.',
                                    FRA = 'Envoyez toutes les lignes feuilles pour approbation, y compris celles que vous ne voyez peut-être pas à cause de filtres.';

                        trigger OnAction();
                        var
                            Items: Record Item;
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        begin
                            CLEAR(SFA);
                            Rec.SETFILTER(Quantity, '<>0');
                            //HEI.07>>
                            IF Rec.FINDSET(FALSE) THEN BEGIN
                                //SETRANGE(Quantity);//HEI.11
                                IF Rec.FINDSET(FALSE) THEN
                                    REPEAT
                                        CheckMandatoryFields();
                                        //HEI.09>>
                                        //IF Items.GET("Item No.") AND (Items."Item Tracking Code" <> '') THEN
                                        //CheckReservationEntries();
                                        IF Items.GET(Rec."Item No.") THEN
                                            IF (Items."Item Tracking Code" <> '') THEN
                                                CheckReservationEntries()
                                    //HEI.11>>
                                    // {
                                    // ELSE IF "Entry Type" = "Entry Type"::"Positive Adjmt." THEN
                                    // TESTFIELD("Applies-from Entry");
                                    // }
                                    //HEI.11<<
                                    //HEI.09<<
                                    UNTIL Rec.NEXT = 0;
                            END;
                            //HEI.07<<
                            IF Rec.FINDSET() THEN BEGIN
                                Rec.SETRANGE(Quantity);
                                IF Rec.FINDSET() THEN BEGIN
                                    // BC UPGRADE PATELS08 >> # Custom function moved to HeinBCUpgrade
                                    // ApprovalsMgmt.SendItemJournalBatchApprovalRequest(Rec);
                                    HeinBCUpgrade.SendItemJournalBatchApprovalRequest(Rec);
                                    // BC UPGRADE PATELS08 <<
                                    SetControlAppearance();
                                    REPEAT
                                        IsValid(TRUE);
                                        Rec."Sent for Approval FND" := TRUE;
                                        Rec.MODIFY(false);
                                    UNTIL Rec.NEXT() = 0;
                                    SFA := FALSE;
                                END;
                            END ELSE
                                ERROR(Test014);

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
                            CLEAR(SFA);
                            // BC UPGRADE PATELS08 >> # Custom function moved to HeinBCUpgrade
                            //ApprovalsMgmt.CancelItemJournalBatchApprovalRequest(Rec);
                            HeinBCUpgrade.CancelItemJournalBatchApprovalRequest(Rec);
                            // BC UPGRADE PATELS08 <<
                            SetControlAppearance();
                            if Rec.findset() then begin
                                repeat
                                    IsValid(true);
                                    Rec."Sent for Approval FND" := false;
                                    Rec.MODIFY(false);
                                until Rec.NEXT() = 0;
                                SFA := false;
                            end;
                        end;
                    }
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
                        if Rec.FINDFIRST() then
                            RecIDL := STRSUBSTNO(Text001L, Rec."Journal Template Name", Rec."Journal Batch Name");
                        ApprovalEntryL.SETRANGE("Table ID", DATABASE::"Item Journal Batch");
                        ApprovalEntryL.SETFILTER("Record ID to Approve", RecIDL);
                        if ApprovalEntryL.FINDLAST() then
                            PAGE.RUNMODAL(PAGE::"Requests to Approve", ApprovalEntryL);
                    end;
                }

                // HEI.07 >>
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
                // HEI.07 <<
            }
            // HEI.06 <<
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
    }

    trigger OnOpenPage()
    begin
        //HEI.06>>
        SetControlAppearance();
        //HEI.06<<
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        //HEI.06>>
        if not SFA then
            ValidateJournal()
        else
            CLEAR(SFA);
        //HEI.06<<    
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //HEI.03>>
        IF Rec."Freeze Batch Lines FND" THEN BEGIN
            UserSetupL.GET(USERID);
            IF NOT UserSetupL."Freeze/Unfreez PhysInvtJnl.FND" THEN
                ERROR(Text003);
            ERROR(Text013)
        END;
        //HEI.03<<

        //HEI.06>>
        IF Rec."Sent for Approval FND" THEN
            ERROR(Test016);
        //HEI.06<<

        // EXIT(TriggerOnDeleteRecord()); // BC Upgrade PATEL08 - DIT
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //HEI.06>>
        SetControlAppearance();
        //HEI.06<<
    end;

    var
        ItemJournalBatch: Record "Item Journal Batch";
        CalcQtyOnHand: Report "Calculate Inventory";
        PhysInventoryList: Report "Phys. Inventory List";
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: Code[20];
        // BC UPGRADE PATELS08 >> # Blocked - DIT
        // QualitySetup: Record "Quality Setup";
        // QualityManagement :Codeunit "Quality Management"; 
        // BC UPGRADE PATELS08 <<
        LotNo: Code[20];
        LotNocolor: Boolean;
        LotNoText: Text[1024];
        xRecRef: RecordRef;
        NewSessionID: GUID;
        ClearGUID: GUID;
        "Entry TypeEditable": Boolean;
        "Item No.Editable": Boolean;
        "Item Charge No.Editable": Boolean;
        "Qty. (Phys. Inventory)Editable": Boolean;
        "Unit AmountEditable": Boolean;
        AmountEditable: Boolean;
        "Unit CostEditable": Boolean;
        "AAD No.Editable": Boolean;
        "AAD No. SeriesEditable": Boolean;
        "Item DTax Group CodeEditable": Boolean;
        CompanyTaxRegistrationNoEditab: Boolean;
        "Tariff No.Editable": Boolean;
        "Item Charge No.Enabled": Boolean;
        JnlFilterApplied: Record "Item Journal Line";
        ExpandLines: Boolean;
        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        UserSetupMgt: Codeunit "User Setup Management";
        GlobalTax1ValueEditable: Boolean;
        GlobalTax2ValueEditable: Boolean;
        NewLotNocolor: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        SFA: Boolean;

        Text2035100: Label 'Are you sure you want to apply tracking for %1 selected lines?';
        Text2035101: Label 'There is nothing to apply.';
        Text2035102: Label '%1 / %2 Item Tracking lines have been applied.';
        Text2035103: Label 'Applying Data...\';
        Text2035104: Label 'Lot/Serial No.        #1##################\';
        Text2035105: Label 'Line No.              #2##########\';
        Text2035106: Label 'Progress              @3@@@@@@@@@@@@@@@@@@\';
        Text001: Label 'Batch lines are frozen successfully.';
        Text002: Label 'Batch lines are unfrozen successfully.';
        Text003: Label 'You don''t have the permission to delete the batch line.';
        Text004: Label 'You don''t have the permission to freeze batch lines.';
        Text005: Label 'You don''t have the permission to unfreeze batch lines.';
        Text006: Label 'There is nothing to freeze in this batch.';
        Text007: Label 'There is nothing to unfreeze in this batch.';
        Text008: Label 'Negative Adjmt. Lot assigned successfully.';
        Text009: Label 'There is nothing to assign Negative Adjmt. Lot.';
        Text010: Label 'Negative Adjmt. Lot Track removed successfully.';
        Text011: Label 'There is nothing to remove Negative Adjmt. Lot Track.';
        Text012: Label 'Negative Adjmt. Lot already exists. Please remove the Negative Adjmt. Lot Track for recreating.';
        Text013: Label 'Please unfreeze the batch lines before deleting.';
        Test014: Label 'There is no difference in Quantity to send for approval.';
        Test015: Label 'Phys. Inv. Journal cannot be modified while the batch is requested for approval.';
        Test016: Label 'Phys. Inv. Journal cannot be deleted while the batch is requested for approval.';
        Test017: Label 'Phys. Inv. Journal cannot be re-calculated while the batch is requested for approval.';
        Test018: Label 'This Batch - %1 cannot be posted until it is approved.';
        Text014: Label 'Can not reopen when record is in Approval Process.';
        Text015: Label 'Item Tracking for Line no %1 and Item No. %2 is not defined or Tracking is not fully assigned.';

        // BC UPGRADE PATELS08 >> # Moved declaration record variable here to avoid defining it multiple times in different triggers.
        UserSetupL: Record "User Setup";
        HeinBCUpgrade: Codeunit "Heineken BC Upgrade";
    // BC UPGRADE PATELS08 <<

    // HEI.06 >>
    local procedure SetControlAppearance();
    var
        ItemJournalBatch: Record "Item Journal Batch";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    begin
        if ItemJournalBatch.GET(Rec."Journal Template Name", Rec."Journal Batch Name") then begin
            ShowWorkflowStatusOnBatch := CurrPage.WorkflowStatusBatch.PAGE.SetFilterOnWorkflowRecord(ItemJournalBatch.RECORDID);
            OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(ItemJournalBatch.RECORDID);
            OpenApprovalEntriesOnJnlBatchExist := ApprovalsMgmt.HasOpenApprovalEntries(ItemJournalBatch.RECORDID);
        end;
        OpenApprovalEntriesExistForCurrUser := OpenApprovalEntriesExistForCurrUser or
          ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesOnJnlLineExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);

        OpenApprovalEntriesOnBatchOrCurrJnlLineExist := OpenApprovalEntriesOnJnlBatchExist or OpenApprovalEntriesOnJnlLineExist;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist := OpenApprovalEntriesOnJnlBatchExist or
        // BC UPGRADE PATELS08 >> # Custom function moved to HeinBCUpgrade
        //ApprovalsMgmt.HasAnyOpenItemJournalLineApprovalEntries(Rec."Journal Template Name", Rec."Journal Batch Name"); 
        HeinBCUpgrade.HasAnyOpenItemJournalLineApprovalEntries(Rec."Journal Template Name", Rec."Journal Batch Name");
        // BC UPGRADE PATELS08 <<


        ShowWorkflowStatusOnLine := CurrPage.WorkflowStatusLine.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);

        CanCancelApprovalForJnlBatch := ApprovalsMgmt.CanCancelApprovalForRecord(ItemJournalBatch.RECORDID);
        CanCancelApprovalForJnlLine := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure GetCurrentlySelectedLines(VAR ItemJournalLine: Record "Item Journal Line"): Boolean
    begin
        CurrPage.SETSELECTIONFILTER(ItemJournalLine);
        EXIT(ItemJournalLine.FINDSET);
    end;

    local procedure ValidateJournal()
    begin
        IF Rec."Sent for Approval FND" THEN
            ERROR(Test015);
    end;

    local procedure ValidatePreApproval(VAR ItemJournalLine: Record "Item Journal Line")
    var
        ApprovalEntryL: Record "Approval Entry";
        ItemJournalBatch1L: Record "Item Journal Batch";
        ItemJournalBatchL: Record "Item Journal Batch";
        ItemJournalLineL: Record "Item Journal Line";
        RecRefL: RecordRef;
        Test002L: Label 'This Batch - %1 cannot be posted while it is awaiting approval.';
        Text001L: Label 'Item Journal Batch: %1,%2';
        RecIDL: Text[100];
    begin
        IF ItemJournalLine.FINDFIRST() THEN
            RecIDL := STRSUBSTNO(Text001L, ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name");
        ApprovalEntryL.SETRANGE("Table ID", DATABASE::"Item Journal Batch");
        ApprovalEntryL.SETFILTER("Record ID to Approve", RecIDL);
        //HEI.12>>
        //ApprovalEntryL.SETFILTER(Status,'<>%1',ApprovalEntryL.Status::Approved);
        ApprovalEntryL.SETRANGE(Status, ApprovalEntryL.Status::Open);
        //HEI.12<<
        IF ApprovalEntryL.FINDLAST THEN BEGIN
            //IF ApprovalEntryL.Status = ApprovalEntryL.Status::Open THEN //HEI.12
            ERROR(Test002L, ItemJournalLine."Journal Batch Name");
        END;
    end;

    local procedure IsValid(Valid: Boolean)
    begin
        SFA := Valid;
    end;

    // HEI.06 <<

    // HEI.07 >>
    local procedure CheckMandatoryFields();
    var
        ItemJournalBatch: Record "Item Journal Batch";
        // NoSeriesManagement: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - NoSeriesManagement CU is obsolete
        NoSeries: Codeunit "No. Series";  // BC Upgrade NANDIS03 - No Series CU is introduced
    begin
        ItemJournalBatch.RESET();
        ItemJournalBatch.SETCURRENTKEY("Journal Template Name", Name, "Use in Workflow FND");
        ItemJournalBatch.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        ItemJournalBatch.SETRANGE(Name, Rec."Journal Batch Name");
        ItemJournalBatch.SETRANGE("Use in Workflow FND", true);
        if ItemJournalBatch.FINDFIRST() then begin
            Rec.TESTFIELD("Item No.");
            Rec.TESTFIELD("Location Code");
            Rec.TESTFIELD("Zone Code FND");
            Rec.TESTFIELD("Bin Code");
            if ItemJournalBatch."Mand. Global DImension 1 FND" then
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
            if ItemJournalBatch."Mand. Global DImension 2 FND" then
                Rec.TESTFIELD("Shortcut Dimension 2 Code");
            if ItemJournalBatch."No. Series" <> '' then
                // BC Upgrade NANDIS03 >>
                // if Rec."Document No." <> NoSeriesManagement.GetNextNo3(ItemJournalBatch."No. Series", TODAY, false, false) then
                //     ERROR(Text013, ItemJournalBatch."No. Series", NoSeriesManagement.GetNextNo3(ItemJournalBatch."No. Series", TODAY, false, false), Rec."Document No.");
                if Rec."Document No." <> NoSeries.GetNextNo(ItemJournalBatch."No. Series", TODAY, false) then
                    ERROR(Text013, ItemJournalBatch."No. Series", NoSeries.GetNextNo(ItemJournalBatch."No. Series", TODAY, false), Rec."Document No.");
            // BC Upgrade NANDIS03 <<
        end;
    end;

    local procedure CheckandReopen();
    var
        RestrictedRecord: Record "Restricted Record";
    begin
        RestrictedRecord.RESET();
        RestrictedRecord.SETRANGE("Record ID", Rec.RECORDID);
        if RestrictedRecord.FINDFIRST() then
            ERROR(Text014);
        Rec.SETFILTER(Quantity, '<>0');
        if Rec.findset() then begin
            Rec.SETRANGE(Quantity);
            if Rec.findset() then
                repeat
                    Rec."Sent for Approval FND" := false;
                    Rec.MODIFY(true);
                until Rec.NEXT() = 0;
        end;
    end;

    local procedure CheckReservationEntries();
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.RESET();
        ReservationEntry.SETRANGE("Source ID", Rec."Journal Template Name");
        ReservationEntry.SETRANGE("Source Type", 83);
        //HEI.08>>
        if Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt." then
            ReservationEntry.SETRANGE("Source Subtype", 2)
        else
            if Rec."Entry Type" = Rec."Entry Type"::"Negative Adjmt." then
                ReservationEntry.SETRANGE("Source Subtype", 3);
        //HEI.08<<
        ReservationEntry.SETRANGE("Source Batch Name", Rec."Journal Batch Name");
        ReservationEntry.SETRANGE("Source Prod. Order Line", 0);
        ReservationEntry.SETRANGE("Source Ref. No.", Rec."Line No.");
        ReservationEntry.SETRANGE("Item No.", Rec."Item No.");
        ReservationEntry.SETRANGE("Location Code", Rec."Location Code");
        ReservationEntry.SETRANGE("Variant Code", Rec."Variant Code");
        //ReservationEntry.SETRANGE(Rec."Gyle No.", ''); //BC UPGRADE PATHAA02-DIT-F2035172
        if ReservationEntry.findset() then begin
            //HEI.10>>
            /*
            //HEI.09>>
            IF "Entry Type" = "Entry Type"::"Positive Adjmt." THEN
              ReservationEntry.TESTFIELD("Appl.-from Item Entry");
            //HEI.09<<
            */
            //HEI.10<<
            ReservationEntry.CALCSUMS("Qty. to Handle (Base)");
            if ABS(ReservationEntry."Qty. to Handle (Base)") <> Rec."Quantity (Base)" then //HEI.08
                ERROR(Text015, Rec."Line No.", Rec."Item No.");
        end else
            ERROR(Text015, Rec."Line No.", Rec."Item No.");
    end;

    // HEI.07 <<


}


