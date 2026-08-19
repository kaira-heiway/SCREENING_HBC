codeunit 58033 "HeiFlow Interface Management"
{
    // version HEI.03

    // HEI.01 CHG2132929 IBM POENAB02 09.08.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Object created
    //   #Object was created on 05.05.2022, but for DevOps deployment the date was changed
    // HEI.02 CHG2144425 IBM POENAB02 28.07.2022 HeiLite Vendor Invoice Status| Automation for Caribbean OpCo™s SSC
    //   #New function: ProcessVendorInvRequest
    // HEI.03 CHG2173936 IBM POENAB02 20.09.2022 HeiFlow GL Posting - Add a new dimension MDV to the GL template for Haiti
    //   #Modified functions OnRun, ProcessJournalLines

    // BC Upgrade POENAB02: Original (HeiLite) codeunit id 50214

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "HeiFlow-Vend.Inv.Status Setup" to "HeiFlow Vend Inv Status FND".
    // BC UPGRADE PATELS08 <<

    TableNo = "Interface Entry Line INT";

    trigger OnRun();
    var
        lInterfaceEntryHeader: Record "Interface Entry Header INT";
        LGenJournalLineTMP: Record "Gen. Journal Line" temporary;
        LText50000: Label 'Combination of Journal Template %1 with Journal Batch %2 does not exist!';
        LText50001: Label 'Value %1 is not valid for field %2!';
        DimAdded: Boolean;
        lDocNo: Code[20];

    begin
        GetGLSetup();

        lInterfaceEntryHeader.Get(Rec."Header Entry No.");

        if not GenJournalBatch.Get(Rec."Unit of Measure Code", Rec."Zone Code") then
            Error(LText50000, Rec."Unit of Measure Code", Rec."Zone Code");

        LGenJournalLineTMP."Journal Template Name" := Rec."Unit of Measure Code";
        LGenJournalLineTMP."Journal Batch Name" := Rec."Zone Code";
        // BC Upgrade POENAB02>>
        // commented, as "Entry No." is part of French localization
        // LGenJournalLineTMP."Entry No." := EntryNo;
        // BC Upgrade POENAB02<<
        LGenJournalLineTMP.Insert(true);
        if GenJournalTemplate.Get(Rec."Unit of Measure Code") then
            LGenJournalLineTMP."Source Code" := GenJournalTemplate."Source Code";
        LGenJournalLineTMP.Validate("Posting Date", Rec."Posting Date");
        case UpperCase(Rec.Description) of
            'PAYMENT':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::Payment);
            '', ' ':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::" ");
            'INVOICE':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::Invoice);
            'CREDIT MEMO':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::"Credit Memo");
            'FINANCE CHARGE MEMO':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::"Finance Charge Memo");
            'REMINDER':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::Reminder);
            'REFUND':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::Refund);
            // BC Upgrade POENAB02 >>
            // Code commented, as it has dependency with Aptean developments                
            /*
            'BANK REVERSE':
                LGenJournalLineTMP.VALIDATE("Document Type", LGenJournalLineTMP."Document Type"::"Bank Reverse");
            'BANK CHARGE':
                LGenJournalLineTMP.VALIDATE("Document Type", LGenJournalLineTMP."Document Type"::"Bank Charge");
            'LOAN PAY OUT':
                LGenJournalLineTMP.VALIDATE("Document Type", LGenJournalLineTMP."Document Type"::"Loan Pay Out");
            'LOAN PAY BACK':
                LGenJournalLineTMP.VALIDATE("Document Type", LGenJournalLineTMP."Document Type"::"Loan Pay Back");
            */
            // BC Upgrade POENAB02 <<    
            'PURCHASE RECEIPT':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::"Purchase Receipt");
            'INTEREST RATE CREDIT':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::"Interest Rate Credit");
            'RPM DAMAGE OR LOSS':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::"RPM Damage or Loss");
            'FFE SECURITY PAYMENT':
                LGenJournalLineTMP.Validate("Document Type", LGenJournalLineTMP."Document Type"::"FFE Security Payment");
            else
                Error(LText50001, Rec.Description, LGenJournalLineTMP.FieldCaption("Document Type"));
        end;
        LGenJournalLineTMP.Validate("Document Date", Rec."Document Date");

        //LGenJournalLineTMP.VALIDATE("Document No.","No.");
        if Rec."No." <> '' then
            LGenJournalLineTMP.Validate("Document No.", Rec."No.")
        else begin
            lDocNo := GetDocNo(Rec."Unit of Measure Code", Rec."Zone Code", Rec."Posting Date");
            LGenJournalLineTMP.Validate("Document No.", lDocNo);
        end;

        LGenJournalLineTMP.Validate("External Document No.", Rec."Order No.");
        case UpperCase(Rec."Global No.") of
            'G/L ACCOUNT':
                LGenJournalLineTMP.Validate("Account Type", LGenJournalLineTMP."Account Type"::"G/L Account");
            'CUSTOMER':
                LGenJournalLineTMP.Validate("Account Type", LGenJournalLineTMP."Account Type"::Customer);
            'VENDOR':
                LGenJournalLineTMP.Validate("Account Type", LGenJournalLineTMP."Account Type"::Vendor);
            'BANK ACCOUNT':
                LGenJournalLineTMP.Validate("Account Type", LGenJournalLineTMP."Account Type"::"Bank Account");
            'FIXED ASSET':
                LGenJournalLineTMP.Validate("Account Type", LGenJournalLineTMP."Account Type"::"Fixed Asset");
            'IC PARTNER':
                LGenJournalLineTMP.Validate("Account Type", LGenJournalLineTMP."Account Type"::"IC Partner");
            else
                Error(LText50001, Rec."Global No.", LGenJournalLineTMP.FieldCaption("Account Type"));
        end;

        LGenJournalLineTMP.Validate("Account No.", Rec."Buy-from Vendor No.");
        LGenJournalLineTMP.Validate(Description, Rec."Description 2");
        LGenJournalLineTMP.Validate("Currency Code", Rec."Currency Code");
        LGenJournalLineTMP.Validate(Amount, Rec."Unit Amount");

        if ((UpperCase(Rec."Action Code") = '1') or (UpperCase(Rec."Action Code") = 'TRUE')) then //Apply Currency Factor
          begin
            LGenJournalLineTMP."Currency Factor" := 1 / Rec."VAT %";
            LGenJournalLineTMP.Validate("Currency Factor");
        end;

        case UpperCase(Rec."Cross Reference No.") of
            'G/L ACCOUNT':
                LGenJournalLineTMP.Validate("Bal. Account Type", LGenJournalLineTMP."Bal. Account Type"::"G/L Account");
            'CUSTOMER':
                LGenJournalLineTMP.Validate("Bal. Account Type", LGenJournalLineTMP."Bal. Account Type"::Customer);
            'VENDOR':
                LGenJournalLineTMP.Validate("Bal. Account Type", LGenJournalLineTMP."Bal. Account Type"::Vendor);
            'BANK ACCOUNT':
                LGenJournalLineTMP.Validate("Bal. Account Type", LGenJournalLineTMP."Bal. Account Type"::"Bank Account");
            'FIXED ASSET':
                LGenJournalLineTMP.Validate("Bal. Account Type", LGenJournalLineTMP."Bal. Account Type"::"Fixed Asset");
            'IC PARTNER':
                LGenJournalLineTMP.Validate("Bal. Account Type", LGenJournalLineTMP."Bal. Account Type"::"IC Partner");
            else
                //ERROR(LText50001,"Cross Reference No.",LGenJournalLineTMP.FIELDCAPTION("Bal. Account Type"));
                LGenJournalLineTMP.Validate("Bal. Account Type", LGenJournalLineTMP."Bal. Account Type"::"G/L Account");
        end;
        LGenJournalLineTMP.Validate("Bal. Account No.", Rec."External Document No.");

        DimSetEntryTmp.DeleteAll();
        DimAdded := false;

        //BRAND
        if Rec."Shortcut Dimension 1 Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Shortcut Dimension 1 Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //CCC
        if Rec."Shortcut Dimension 2 Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Shortcut Dimension 2 Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //MVMT
        if Rec."Blanket Order No." <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 3 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Blanket Order No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //
        if Rec."Cost Center Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 4 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Cost Center Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //CMG
        if Rec."CMG Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 5 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."CMG Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //LINE_EXT
        if Rec."Project Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 6 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Project Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //TRD_PART
        if Rec."Ship-to Post Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 7 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Ship-to Post Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //CAPEX
        if Rec."External Requisition No." <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Capex Dimension Code FND");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."External Requisition No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //INV_LEV
        if Rec."Message Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Mass Upload Dimension 14 FND");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Message Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //SKU
        if Rec."Message Type" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Mass Upload Dimension 9 FND");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Message Type");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //P_PCK_TYPE
        if Rec."Message Class" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Primary Pack Type Dim FND");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Message Class");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //BUSS_SEG
        if Rec."Bill-to Customer No." <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Business Type Dim Code FND");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Bill-to Customer No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //AUTO_CUST
        if Rec."Sell-to Customer No." <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Customer Dimension Code FND");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Sell-to Customer No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //AUTO_VEND
        if ((Rec.Reference <> '') and (GeneralLedgerSetup."Mass Upload Dimension 11 FND" <> '')) then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Mass Upload Dimension 11 FND");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec.Reference);
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //CONCAT
        if ((Rec."Account No." <> '') and (GeneralLedgerSetup."Mass Upload Dimension 10 FND" <> '')) then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Mass Upload Dimension 10 FND");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Account No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //HEI.03>>
        //MDV
        if ((Rec."Vendor Posting Group" <> '') and (GeneralLedgerSetup."Maison des Vins Dim. Code FND" <> '')) then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Maison des Vins Dim. Code FND");
            DimSetEntryTmp.Validate("Dimension Value Code", Rec."Vendor Posting Group");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;
        //HEI.03<<

        if DimAdded then begin
            LGenJournalLineTMP."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
            LGenJournalLineTMP.Modify(true);
        end;

        LGenJournalLineTMP.Validate("VAT Bus. Posting Group", Rec."New Location Code");
        LGenJournalLineTMP.Validate("VAT Prod. Posting Group", Rec."New Zone Code");
        LGenJournalLineTMP.Validate("Bal. VAT Bus. Posting Group", Rec."Legal Entity");
        LGenJournalLineTMP.Validate("Bal. VAT Prod. Posting Group", Rec."Language Code");
        LGenJournalLineTMP.Validate("WHT Business Posting Group FND", Rec."Sales Unit of Measure");
        LGenJournalLineTMP.Validate("WHT Product Posting Group FND", Rec."Purch. Unit of Measure");
        LGenJournalLineTMP.Validate("Reason Code", Rec."External Contract No.");
        case UpperCase(Rec."External Contract Line No.") of
            ' ', '':
                LGenJournalLineTMP.Validate("Gen. Posting Type", LGenJournalLineTMP."Gen. Posting Type"::" ");
            'Purchase':
                LGenJournalLineTMP.Validate("Gen. Posting Type", LGenJournalLineTMP."Gen. Posting Type"::Purchase);
            'Sale':
                LGenJournalLineTMP.Validate("Gen. Posting Type", LGenJournalLineTMP."Gen. Posting Type"::Sale);
            'Settlement':
                LGenJournalLineTMP.Validate("Gen. Posting Type", LGenJournalLineTMP."Gen. Posting Type"::Settlement);
            else
                Error(LText50001, Rec."External Contract Line No.", LGenJournalLineTMP.FIELDCAPTION("Gen. Posting Type"));
        end;
        LGenJournalLineTMP.Validate("Gen. Bus. Posting Group", Rec."Type ID");
        LGenJournalLineTMP.Validate("Gen. Prod. Posting Group", Rec."Movement Type");

        case UpperCase(Rec.Status) of
            ' ', '':
                LGenJournalLineTMP.Validate("Bal. Gen. Posting Type", LGenJournalLineTMP."Bal. Gen. Posting Type"::" ");
            'Purchase':
                LGenJournalLineTMP.Validate("Bal. Gen. Posting Type", LGenJournalLineTMP."Bal. Gen. Posting Type"::Purchase);
            'Sale':
                LGenJournalLineTMP.Validate("Bal. Gen. Posting Type", LGenJournalLineTMP."Bal. Gen. Posting Type"::Sale);
            'Settlement':
                LGenJournalLineTMP.Validate("Bal. Gen. Posting Type", LGenJournalLineTMP."Bal. Gen. Posting Type"::Settlement);
            else
                Error(LText50001, Rec.Status, LGenJournalLineTMP.FieldCaption("Bal. Gen. Posting Type"));
        end;

        LGenJournalLineTMP.Validate("Bal. Gen. Bus. Posting Group", Rec."Purchasing Organisation");
        LGenJournalLineTMP.Validate("Bal. Gen. Prod. Posting Group", Rec."External Order No.");
        LGenJournalLineTMP.Validate("FA Posting Date", Rec."Expected Delivery Date");

        case UpperCase(Rec."Phone No.") of
            '', ' ':
                LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::" ");
            'ACQUISITION COST':
                LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::"Acquisition Cost");
            'DEPRECIATION':
                LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::Depreciation);
            'WRITE-DOWN':
                LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::"Write-Down");
            'APPRECIATION':
                LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::Appreciation);
            'CUSTOM 1':
                LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::"Custom 1");
            'CUSTOM 2':
                LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::"Custom 2");
            'DISPOSAL':
                LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::Disposal);
            'MAINTENANCE':
                LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::Maintenance);
            // BC Upgrade POENAB02>>
            // commented, as "Derogatory" option is part of French localization
            // La Reunion FA Derogatory Depreciation
            //'DEROGATORY':
            //    LGenJournalLineTMP.Validate("FA Posting Type", LGenJournalLineTMP."FA Posting Type"::Derogatory);
            // BC Upgrade POENAB02<<
            else
                Error(LText50001, Rec."Phone No.", LGenJournalLineTMP.FieldCaption("FA Posting Type"));
        end;

        LGenJournalLineTMP.Validate("Depreciation Book Code", Rec."External Order Line No.");
        LGenJournalLineTMP.Validate("No. of Depreciation Days", Rec."Blanket Order Line No.");
        LGenJournalLineTMP.Validate("Depr. until FA Posting Date", Rec.Blocked); //boolean
        LGenJournalLineTMP.Validate("Depr. Acquisition Cost", Rec.Locked); //boolean
        LGenJournalLineTMP.Validate("Use Duplication List", Rec.Closed); //boolean
        LGenJournalLineTMP.Validate("FA Reclassification Entry", Rec."Over Percent Indicator"); //boolean
        //LGenJournalLineTMP.Validate(Auto_Cust,"Sell-to Customer No.");

        LGenJournalLineTMP.Modify();

        LGenJournalLineTMP.DeleteAll();

        EntryNo += 10000;
    end;

    var
        HeiFLOWInterfaceSetup: Record "HeiFLOW Interface Setup INT";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatchTMP: Record "Gen. Journal Batch" temporary;
        GenJournalBatch: Record "Gen. Journal Batch";
        DimSetEntryTmp: Record "Dimension Set Entry" temporary;
        GGenJournalLineTMP: Record "Gen. Journal Line" temporary;
        GeneralLedgerSetup: Record "General Ledger Setup";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        DimMgt: Codeunit DimensionManagement;
        EntryNo: Integer;
        GeneralLedgerSetupRead: Boolean;
        gStartLineNo: Integer;
        HeiFlowInterfaceSetupRead: Boolean;

    procedure CreateJournalConfirmationResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; InterfaceCode: Code[20]; ErrorOccurred: Boolean; ErrorMessage: Text);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        lText50000: Label 'Line processed successfully';
        LHeiFlowInterfaceManagement: Codeunit "HeiFlow Interface Management";
        LError: Boolean;
        LEntryNo: Integer;
        LGenJournalLine: Record "Gen. Journal Line";
        LLineNo: Integer;
    begin
        GetHeiFlowSetup();
        LError := false;
        EntryNo := 10000;
        InterfaceEntryHeader."E-Mail" := 'SUCCESS';
        InterfaceSetup.Get(InterfaceCode);
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        Clear(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TransferFields(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut."Interface Code" := InterfaceCode;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeader.Direction::Outbound;
        if ErrorOccurred then
            InterfaceEntryHeaderOut."Log Message" := CopyStr(ErrorMessage, 1, MaxStrLen(InterfaceEntryHeader."Log Message"));

        InterfaceEntryHeaderOut."Message ID" := InterfaceEntryHeader."Message ID";
        InterfaceEntryHeaderOut."Message Creation DateTime" := CurrentDateTime();
        InterfaceEntryHeaderOut.Insert(true);
        InterfaceEntryLine.SetRange("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FindSet(false) then
            repeat
                Clear(InterfaceEntryLineOut);
                Commit();

                InterfaceEntryLineOut.TransferFields(InterfaceEntryLine, false);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                InterfaceEntryLineOut."Source No." := InterfaceEntryHeader."Source No.";

                ClearLastError();
                if LHeiFlowInterfaceManagement.Run(InterfaceEntryLineOut) then;
                if GetLastErrorText <> '' then begin
                    InterfaceEntryLineOut."Log Message" := CopyStr(GetLastErrorText, 1, 200);
                    InterfaceEntryLineOut."E-Mail" := 'FAILED';
                    LError := true;
                end
                else begin
                    InterfaceEntryLineOut."Log Message" := lText50000;
                    InterfaceEntryLineOut."E-Mail" := 'SUCCESS';
                end;

                InterfaceEntryLineOut.Insert(true);
            until InterfaceEntryLine.Next() = 0;

        if not LError then begin
            InterfaceEntryLine.Reset();
            InterfaceEntryLine.SetRange("Header Entry No.", InterfaceEntryHeader."Entry No.");
            if InterfaceEntryLine.FindSet(false) then
                repeat
                    GenJournalBatchTMP.Reset();
                    if not GenJournalBatchTMP.Get(InterfaceEntryLine."Unit of Measure Code", InterfaceEntryLine."Zone Code") then begin
                        GenJournalBatchTMP."Journal Template Name" := InterfaceEntryLine."Unit of Measure Code";
                        GenJournalBatchTMP.Name := InterfaceEntryLine."Zone Code";
                        if GenJournalBatchTMP.Insert() then;
                    end;
                until InterfaceEntryLine.Next() = 0;

            GenJournalBatchTMP.Reset();
            if GenJournalBatchTMP.FindSet(false) then
                repeat
                    //delete journal existing entries
                    if UpperCase(InterfaceEntryHeader."Legal Entity") = 'TRUE' then begin
                        LGenJournalLine.Reset();
                        LGenJournalLine.SetRange("Journal Template Name", GenJournalBatchTMP."Journal Template Name");
                        LGenJournalLine.SetRange("Journal Batch Name", GenJournalBatchTMP.Name);
                        LGenJournalLine.DeleteAll(true);
                    end;

                    LLineNo := 10000;
                    LGenJournalLine.Reset();
                    LGenJournalLine.SetRange("Journal Template Name", GenJournalBatchTMP."Journal Template Name");
                    LGenJournalLine.SetRange("Journal Batch Name", GenJournalBatchTMP.Name);
                    if LGenJournalLine.FindLast() then
                        LLineNo := LGenJournalLine."Line No." + 10000;

                    gStartLineNo := LLineNo;

                    InterfaceEntryLine.Reset();
                    InterfaceEntryLine.SetRange("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    InterfaceEntryLine.SetRange("Unit of Measure Code", GenJournalBatchTMP."Journal Template Name");
                    InterfaceEntryLine.SetRange("Zone Code", GenJournalBatchTMP.Name);
                    if InterfaceEntryLine.FindSet(false) then
                        repeat
                            ProcessJournalLines(InterfaceEntryLine, LLineNo);
                            LLineNo += 10000;
                        until InterfaceEntryLine.Next() = 0;
                    //create reversal entries
                    if UpperCase(InterfaceEntryHeader."House Number") = 'TRUE' then
                        CreateExtourneAutoLine(GenJournalBatchTMP."Journal Template Name", GenJournalBatchTMP.Name, gStartLineNo, InterfaceEntryHeader."Posting Date");
                until GenJournalBatchTMP.Next() = 0;
        end;

        if LError then
            InterfaceEntryHeaderOut."E-Mail" := 'FAILED';
        InterfaceEntryHeaderOut.Modify();

        GenJournalBatchTMP.DeleteAll();
        DimSetEntryTmp.DeleteAll();
        GGenJournalLineTMP.DeleteAll();
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    local procedure GetHeiFlowSetup();
    begin
        if not HeiFlowInterfaceSetupRead then
            HeiFLOWInterfaceSetup.GET();
        HeiFlowInterfaceSetupRead := true;
    end;

    procedure ProcessJournalLines(var InterfaceEntryLine: Record "Interface Entry Line INT"; pEntryNo: Integer);
    var
        DimAdded: Boolean;
        LText50001: Label 'Value %1 is not valid for field %2!';
        LGenJournalLine: Record "Gen. Journal Line";
        lDocNo: Code[20];
    begin
        GetGLSetup();
        LGenJournalLine.Init();
        LGenJournalLine."Journal Template Name" := InterfaceEntryLine."Unit of Measure Code";
        LGenJournalLine."Journal Batch Name" := InterfaceEntryLine."Zone Code";
        LGenJournalLine."Line No." := pEntryNo;
        LGenJournalLine.Insert(true);
        if GenJournalTemplate.Get(InterfaceEntryLine."Unit of Measure Code") then
            LGenJournalLine."Source Code" := GenJournalTemplate."Source Code";

        LGenJournalLine.Validate("Posting Date", InterfaceEntryLine."Posting Date");
        case UpperCase(InterfaceEntryLine.Description) of
            'PAYMENT':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::Payment);
            '', ' ':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::" ");
            'INVOICE':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::Invoice);
            'CREDIT MEMO':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::"Credit Memo");
            'FINANCE CHARGE MEMO':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::"Finance Charge Memo");
            'REMINDER':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::Reminder);
            'REFUND':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::Refund);
            // BC Upgrade POENAB02 >>
            // Code commented, as it has dependency with Aptean developments                
            /*                
            'BANK REVERSE':
                LGenJournalLine.VALIDATE("Document Type", LGenJournalLine."Document Type"::"Bank Reverse");
            'BANK CHARGE':
                LGenJournalLine.VALIDATE("Document Type", LGenJournalLine."Document Type"::"Bank Charge");
            'LOAN PAY OUT':
                LGenJournalLine.VALIDATE("Document Type", LGenJournalLine."Document Type"::"Loan Pay Out");
            'LOAN PAY BACK':
                LGenJournalLine.VALIDATE("Document Type", LGenJournalLine."Document Type"::"Loan Pay Back");
            */
            // BC Upgrade POENAB02 <<
            'PURCHASE RECEIPT':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::"Purchase Receipt");
            'INTEREST RATE CREDIT':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::"Interest Rate Credit");
            'RPM DAMAGE OR LOSS':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::"RPM Damage or Loss");
            'FFE SECURITY PAYMENT':
                LGenJournalLine.Validate("Document Type", LGenJournalLine."Document Type"::"FFE Security Payment");
            else
                Error(LText50001, InterfaceEntryLine.Description, LGenJournalLine.FieldCaption("Document Type"));
        end;
        LGenJournalLine.Validate("Document Date", InterfaceEntryLine."Document Date");
        //LGenJournalLine.VALIDATE("Document No.",InterfaceEntryLine."No.");
        if InterfaceEntryLine."No." <> '' then
            LGenJournalLine.Validate("Document No.", InterfaceEntryLine."No.")
        else begin
            lDocNo := GetDocNo(InterfaceEntryLine."Unit of Measure Code", InterfaceEntryLine."Zone Code", InterfaceEntryLine."Posting Date");
            LGenJournalLine.Validate("Document No.", lDocNo);
        end;

        LGenJournalLine.Validate("External Document No.", InterfaceEntryLine."Order No.");
        case UpperCase(InterfaceEntryLine."Global No.") of
            'G/L ACCOUNT':
                LGenJournalLine.Validate("Account Type", LGenJournalLine."Account Type"::"G/L Account");
            'CUSTOMER':
                LGenJournalLine.Validate("Account Type", LGenJournalLine."Account Type"::Customer);
            'VENDOR':
                LGenJournalLine.Validate("Account Type", LGenJournalLine."Account Type"::Vendor);
            'BANK ACCOUNT':
                LGenJournalLine.Validate("Account Type", LGenJournalLine."Account Type"::"Bank Account");
            'FIXED ASSET':
                LGenJournalLine.Validate("Account Type", LGenJournalLine."Account Type"::"Fixed Asset");
            'IC PARTNER':
                LGenJournalLine.Validate("Account Type", LGenJournalLine."Account Type"::"IC Partner");
            else
                Error(LText50001, InterfaceEntryLine."Global No.", LGenJournalLine.FIELDCAPTION("Account Type"));
        end;

        LGenJournalLine.Validate("Account No.", InterfaceEntryLine."Buy-from Vendor No.");
        LGenJournalLine.Validate(Description, InterfaceEntryLine."Description 2");
        LGenJournalLine.Validate("Currency Code", InterfaceEntryLine."Currency Code");
        LGenJournalLine.Validate(Amount, InterfaceEntryLine."Unit Amount");

        if ((UpperCase(InterfaceEntryLine."Action Code") = '1') or (UpperCase(InterfaceEntryLine."Action Code") = 'TRUE')) then //Apply Currency Factor
          begin
            LGenJournalLine."Currency Factor" := 1 / InterfaceEntryLine."VAT %";
            LGenJournalLine.Validate("Currency Factor");
        end;

        case UpperCase(InterfaceEntryLine."Cross Reference No.") of
            'G/L ACCOUNT':
                LGenJournalLine.Validate("Bal. Account Type", LGenJournalLine."Bal. Account Type"::"G/L Account");
            'CUSTOMER':
                LGenJournalLine.Validate("Bal. Account Type", LGenJournalLine."Bal. Account Type"::Customer);
            'VENDOR':
                LGenJournalLine.Validate("Bal. Account Type", LGenJournalLine."Bal. Account Type"::Vendor);
            'BANK ACCOUNT':
                LGenJournalLine.Validate("Bal. Account Type", LGenJournalLine."Bal. Account Type"::"Bank Account");
            'FIXED ASSET':
                LGenJournalLine.Validate("Bal. Account Type", LGenJournalLine."Bal. Account Type"::"Fixed Asset");
            'IC PARTNER':
                LGenJournalLine.Validate("Bal. Account Type", LGenJournalLine."Bal. Account Type"::"IC Partner");
            else
                //ERROR(LText50001,InterfaceEntryLine."Cross Reference No.",LGenJournalLine.FIELDCAPTION("Bal. Account Type"));
                LGenJournalLine.Validate("Bal. Account Type", LGenJournalLine."Bal. Account Type"::"G/L Account");
        end;
        LGenJournalLine.Validate("Bal. Account No.", InterfaceEntryLine."External Document No.");

        DimSetEntryTmp.DeleteAll();
        DimAdded := false;

        //BRAND
        if InterfaceEntryLine."Shortcut Dimension 1 Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //CCC
        if InterfaceEntryLine."Shortcut Dimension 2 Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Shortcut Dimension 2 Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //MVMT
        if InterfaceEntryLine."Blanket Order No." <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 3 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Blanket Order No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //CHANNEL
        if InterfaceEntryLine."Cost Center Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 4 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Cost Center Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //CMG
        if InterfaceEntryLine."CMG Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 5 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."CMG Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //LINE_EXT
        if InterfaceEntryLine."Project Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 6 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Project Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //TRD_PART
        if InterfaceEntryLine."Ship-to Post Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 7 Code");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Ship-to Post Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //CAPEX
        if InterfaceEntryLine."External Requisition No." <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Capex Dimension Code FND");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."External Requisition No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //INV_LEV
        if InterfaceEntryLine."Message Code" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Mass Upload Dimension 14 FND");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Message Code");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //SKU
        if InterfaceEntryLine."Message Type" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Mass Upload Dimension 9 FND");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Message Type");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //P_PCK_TYPE
        if InterfaceEntryLine."Message Class" <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Primary Pack Type Dim FND");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Message Class");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //BUSS_SEG
        if InterfaceEntryLine."Bill-to Customer No." <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Business Type Dim Code FND");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Bill-to Customer No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //AUTO_CUST
        if InterfaceEntryLine."Sell-to Customer No." <> '' then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Customer Dimension Code FND");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Sell-to Customer No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //AUTO_VEND
        if ((InterfaceEntryLine.Reference <> '') and (GeneralLedgerSetup."Mass Upload Dimension 11 FND" <> '')) then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Mass Upload Dimension 11 FND");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine.Reference);
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //CONCAT
        if ((InterfaceEntryLine."Account No." <> '') and (GeneralLedgerSetup."Mass Upload Dimension 10 FND" <> '')) then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Mass Upload Dimension 10 FND");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Account No.");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;

        //HEI.03>>
        //MDV
        if ((InterfaceEntryLine."Vendor Posting Group" <> '') and (GeneralLedgerSetup."Maison des Vins Dim. Code FND" <> '')) then begin
            DimSetEntryTmp.Validate("Dimension Code", GeneralLedgerSetup."Maison des Vins Dim. Code FND");
            DimSetEntryTmp.Validate("Dimension Value Code", InterfaceEntryLine."Vendor Posting Group");
            if DimSetEntryTmp.Insert(true) then;
            DimAdded := true;
        end;
        //HEI.03<<

        if DimAdded then begin
            LGenJournalLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
            LGenJournalLine.Modify(true);
        end;

        LGenJournalLine.Validate("VAT Bus. Posting Group", InterfaceEntryLine."New Location Code");
        LGenJournalLine.Validate("VAT Prod. Posting Group", InterfaceEntryLine."New Zone Code");
        LGenJournalLine.Validate("Bal. VAT Bus. Posting Group", InterfaceEntryLine."Legal Entity");
        LGenJournalLine.Validate("Bal. VAT Prod. Posting Group", InterfaceEntryLine."Language Code");
        LGenJournalLine.Validate("WHT Business Posting Group FND", InterfaceEntryLine."Sales Unit of Measure");
        LGenJournalLine.Validate("WHT Product Posting Group FND", InterfaceEntryLine."Purch. Unit of Measure");
        LGenJournalLine.Validate("Reason Code", InterfaceEntryLine."External Contract No.");
        case UpperCase(InterfaceEntryLine."External Contract Line No.") of
            ' ', '':
                LGenJournalLine.Validate("Gen. Posting Type", LGenJournalLine."Gen. Posting Type"::" ");
            'Purchase':
                LGenJournalLine.Validate("Gen. Posting Type", LGenJournalLine."Gen. Posting Type"::Purchase);
            'Sale':
                LGenJournalLine.Validate("Gen. Posting Type", LGenJournalLine."Gen. Posting Type"::Sale);
            'Settlement':
                LGenJournalLine.Validate("Gen. Posting Type", LGenJournalLine."Gen. Posting Type"::Settlement);
            else
                Error(LText50001, InterfaceEntryLine."External Contract Line No.", LGenJournalLine.FIELDCAPTION("Gen. Posting Type"));
        end;
        LGenJournalLine.Validate("Gen. Bus. Posting Group", InterfaceEntryLine."Type ID");
        LGenJournalLine.Validate("Gen. Prod. Posting Group", InterfaceEntryLine."Movement Type");

        case UpperCase(InterfaceEntryLine.Status) of
            ' ', '':
                LGenJournalLine.Validate("Bal. Gen. Posting Type", LGenJournalLine."Bal. Gen. Posting Type"::" ");
            'Purchase':
                LGenJournalLine.Validate("Bal. Gen. Posting Type", LGenJournalLine."Bal. Gen. Posting Type"::Purchase);
            'Sale':
                LGenJournalLine.Validate("Bal. Gen. Posting Type", LGenJournalLine."Bal. Gen. Posting Type"::Sale);
            'Settlement':
                LGenJournalLine.Validate("Bal. Gen. Posting Type", LGenJournalLine."Bal. Gen. Posting Type"::Settlement);
            else
                Error(LText50001, InterfaceEntryLine.Status, LGenJournalLine.FieldCaption("Bal. Gen. Posting Type"));
        end;

        LGenJournalLine.Validate("Bal. Gen. Bus. Posting Group", InterfaceEntryLine."Purchasing Organisation");
        LGenJournalLine.Validate("Bal. Gen. Prod. Posting Group", InterfaceEntryLine."External Order No.");
        LGenJournalLine.Validate("FA Posting Date", InterfaceEntryLine."Expected Delivery Date");

        case UpperCase(InterfaceEntryLine."Phone No.") of
            '', ' ':
                LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::" ");
            'ACQUISITION COST':
                LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::"Acquisition Cost");
            'DEPRECIATION':
                LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::Depreciation);
            'WRITE-DOWN':
                LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::"Write-Down");
            'APPRECIATION':
                LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::Appreciation);
            'CUSTOM 1':
                LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::"Custom 1");
            'CUSTOM 2':
                LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::"Custom 2");
            'DISPOSAL':
                LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::Disposal);
            'MAINTENANCE':
                LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::Maintenance);
            // BC Upgrade POENAB02>>
            // commented, as "Derogatory" option is part of French localization
            // La Reunion FA Derogatory Depreciation                
            //'DEROGATORY':
            //    LGenJournalLine.Validate("FA Posting Type", LGenJournalLine."FA Posting Type"::Derogatory);
            // BC Upgrade POENAB02<<
            else
                Error(LText50001, InterfaceEntryLine."Phone No.", LGenJournalLine.FieldCaption("FA Posting Type"));
        end;

        LGenJournalLine.Validate("Depreciation Book Code", InterfaceEntryLine."External Order Line No.");
        LGenJournalLine.Validate("No. of Depreciation Days", InterfaceEntryLine."Blanket Order Line No.");
        LGenJournalLine.Validate("Depr. until FA Posting Date", InterfaceEntryLine.Blocked); //boolean
        LGenJournalLine.Validate("Depr. Acquisition Cost", InterfaceEntryLine.Locked); //boolean
        LGenJournalLine.Validate("Use Duplication List", InterfaceEntryLine.Closed); //boolean
        LGenJournalLine.Validate("FA Reclassification Entry", InterfaceEntryLine."Over Percent Indicator"); //boolean
        //LGenJournalLine.Validate(Auto_Cust,InterfaceEntryLine."Sell-to Customer No.");

        LGenJournalLine.Modify();
    end;

    local procedure GetGLSetup();
    begin
        if not GeneralLedgerSetupRead then
            GeneralLedgerSetup.Get();
        GeneralLedgerSetupRead := true;
    end;

    procedure ProcessVendorInvRequest(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        lVendorLedgerEntry: Record "Vendor Ledger Entry";
        HeiFlowVendInvStatusSetup: Record "HeiFlow Vend Inv Status FND";
        HeiFlowVendInvStatusSetup2: Record "HeiFlow Vend Inv Status FND";
        lVendorLedgerEntry1: Record "Vendor Ledger Entry";
        lBlank: Label '''''';
        lNotBlank: Label '<>''''';
        lErrorFound: Boolean;
        lText50000: Label '" - Vendor is wrong"';
        lText50001: Label '" - Amount is wrong"';
    begin
        //HEI.02>>
        GetHeiFlowSetup();
        InterfaceSetup.Get(HeiFLOWInterfaceSetup."HeiFlow Vend. Inv. Response");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        Clear(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CurrentDateTime();
        InterfaceEntryHeaderOut."Source No." := InterfaceEntryHeader."Source No.";
        InterfaceEntryHeaderOut."Interface Code" := HeiFLOWInterfaceSetup."HeiFlow Vend. Inv. Response";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut.Insert(true);


        InterfaceEntryLine.SetRange("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FindSet() then
            repeat
                Clear(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                InterfaceEntryLineOut."Buy-from Vendor No." := InterfaceEntryLine."Buy-from Vendor No."; //Vendor

                HeiFlowVendInvStatusSetup.Reset();

                if InterfaceEntryLine."Global No." <> '' then begin
                    lVendorLedgerEntry.Reset();
                    lVendorLedgerEntry.SetCurrentKey("External Document No.");
                    lVendorLedgerEntry.SetRange("External Document No.", InterfaceEntryLine."Global No.");
                    lVendorLedgerEntry.SetRange("Vendor No.", InterfaceEntryLine."Buy-from Vendor No.");
                    lVendorLedgerEntry.SetRange("Document Type", lVendorLedgerEntry."Document Type"::Invoice);
                    lVendorLedgerEntry.CalcFields(Amount);
                    lVendorLedgerEntry.SetRange(Amount, -InterfaceEntryLine."Amount Incl. VAT");
                    if lVendorLedgerEntry.FindSet(false) then
                        repeat
                            InterfaceEntryLineOut."Global No." := InterfaceEntryLine."Global No."; //InvoiceReferenceNumber
                            InterfaceEntryLineOut."Amount Incl. VAT" := InterfaceEntryLine."Amount Incl. VAT"; //Amount (or from VLE."Amount; or from VLE."Amount (LCY)")

                            HeiFlowVendInvStatusSetup.Reset();
                            HeiFlowVendInvStatusSetup.SetFilter("Status ID", '>=%1', 1);
                            HeiFlowVendInvStatusSetup.SetRange("Payment Status", lVendorLedgerEntry."Payment Status FND");
                            HeiFlowVendInvStatusSetup.SetRange("Document Type", lVendorLedgerEntry."Document Type");
                            HeiFlowVendInvStatusSetup.SetRange(Open, lVendorLedgerEntry.Open);
                            if lVendorLedgerEntry."Batch payment name FND" <> '' then
                                HeiFlowVendInvStatusSetup.SetFilter("Batch Payment Name", '%1', lNotBlank)
                            else
                                HeiFlowVendInvStatusSetup.SetFilter("Batch Payment Name", '%1', lBlank);
                            if lVendorLedgerEntry."On Hold" <> '' then
                                HeiFlowVendInvStatusSetup.SetFilter("On Hold", '%1', lNotBlank)
                            else
                                HeiFlowVendInvStatusSetup.SetFilter("On Hold", '%1', lBlank);
                            if lVendorLedgerEntry."Closed by Entry No." <> 0 then
                                HeiFlowVendInvStatusSetup.SetFilter("Closed by Entry No.", lNotBlank)
                            else
                                HeiFlowVendInvStatusSetup.SetFilter("Closed by Entry No.", '%1', lBlank);
                            if HeiFlowVendInvStatusSetup.FindFirst() then begin
                                InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup."Status ID"); //StatusID
                                InterfaceEntryLineOut."Log Message" := HeiFlowVendInvStatusSetup.Description; //StatusDescription
                                InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                InterfaceEntryLineOut."E-Mail 2" := Format(HeiFlowVendInvStatusSetup."Payment Status"); //PaymentStatus
                                if lVendorLedgerEntry.Open then //Open
                                    InterfaceEntryLineOut."Movement Type" := 'Yes'
                                else
                                    InterfaceEntryLineOut."Movement Type" := 'No';

                                InterfaceEntryLineOut."Cross Reference No." := Format(HeiFlowVendInvStatusSetup."Document Type"); //DocType
                                InterfaceEntryLineOut."Blanket Order No." := lVendorLedgerEntry."Batch payment name FND"; //BatchNo
                                InterfaceEntryLineOut.Status := lVendorLedgerEntry."On Hold"; //OnHold
                                InterfaceEntryLineOut."External Requisition Line No." := lVendorLedgerEntry."Closed by Entry No.";//ClosedByEntryNo
                            end
                            else begin
                                HeiFlowVendInvStatusSetup2.Reset();
                                HeiFlowVendInvStatusSetup2.SetRange("Status ID", 0);
                                if HeiFlowVendInvStatusSetup2.FindFirst() then begin
                                    InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup2."Status ID"); //StatusID
                                    InterfaceEntryLineOut."Log Message" := HeiFlowVendInvStatusSetup2.Description; //StatusDescription
                                    InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                end;
                            end;
                        until lVendorLedgerEntry.Next() = 0
                    else begin
                        lErrorFound := false;
                        lVendorLedgerEntry1.Reset();
                        lVendorLedgerEntry1.SetCurrentKey("External Document No.");
                        lVendorLedgerEntry1.SetRange("External Document No.", InterfaceEntryLine."Global No.");
                        if not lVendorLedgerEntry1.FindFirst() then begin
                            lErrorFound := true;
                            HeiFlowVendInvStatusSetup.Reset();
                            HeiFlowVendInvStatusSetup.SetRange("Status ID", 0);
                            if HeiFlowVendInvStatusSetup.FindFirst() then begin
                                InterfaceEntryLineOut."Global No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup."Status ID"); //StatusID
                                InterfaceEntryLineOut."Log Message" := HeiFlowVendInvStatusSetup.Description; //StatusDescription
                                InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                                                                                                  //InterfaceEntryLineOut."E-Mail 2" := '';//PaymentStatus
                                                                                                                  //InterfaceEntryLineOut."Movement Type" := ''; //Open
                                                                                                                  //InterfaceEntryLineOut."Cross Reference No." := '';//DocType
                                                                                                                  //InterfaceEntryLineOut."Blanket Order No." := '';//BatchNo
                                                                                                                  //InterfaceEntryLineOut.Status := '';//OnHold
                                                                                                                  //InterfaceEntryLineOut."External Requisition Line No." := 0;//ClosedByEntryNo
                            end;
                        end;

                        if lErrorFound = false then begin
                            lVendorLedgerEntry1.Reset();
                            lVendorLedgerEntry1.SetCurrentKey("External Document No.");
                            lVendorLedgerEntry1.SetRange("External Document No.", InterfaceEntryLine."Global No.");
                            lVendorLedgerEntry1.SetRange("Vendor No.", InterfaceEntryLine."Buy-from Vendor No.");
                            if not lVendorLedgerEntry1.FindFirst() then begin
                                lErrorFound := true;
                                HeiFlowVendInvStatusSetup.Reset();
                                HeiFlowVendInvStatusSetup.SetRange("Status ID", 0);
                                if HeiFlowVendInvStatusSetup.FindFirst() then begin
                                    InterfaceEntryLineOut."Global No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                    InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup."Status ID"); //StatusID
                                    InterfaceEntryLineOut."Log Message" := CopyStr(HeiFlowVendInvStatusSetup.Description + lText50000, 1, 200); //StatusDescription
                                    InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                                                                                                      //InterfaceEntryLineOut."E-Mail 2" := '';//PaymentStatus
                                                                                                                      //InterfaceEntryLineOut."Movement Type" := ''; //Open
                                                                                                                      //InterfaceEntryLineOut."Cross Reference No." := '';//DocType
                                                                                                                      //InterfaceEntryLineOut."Blanket Order No." := '';//BatchNo
                                                                                                                      //InterfaceEntryLineOut.Status := '';//OnHold
                                                                                                                      //InterfaceEntryLineOut."External Requisition Line No." := 0;//ClosedByEntryNo
                                end;
                            end;
                        end;

                        if lErrorFound = false then begin
                            lVendorLedgerEntry1.Reset();
                            lVendorLedgerEntry1.SetCurrentKey("External Document No.");
                            lVendorLedgerEntry1.SetRange("External Document No.", InterfaceEntryLine."Global No.");
                            lVendorLedgerEntry1.SetRange("Vendor No.", InterfaceEntryLine."Buy-from Vendor No.");
                            lVendorLedgerEntry1.SetRange("Document Type", lVendorLedgerEntry."Document Type"::Invoice);
                            lVendorLedgerEntry1.CalcFields(Amount);
                            lVendorLedgerEntry1.SetRange(Amount, -InterfaceEntryLine."Amount Incl. VAT");
                            if not lVendorLedgerEntry1.FindFirst() then begin
                                lErrorFound := true;
                                HeiFlowVendInvStatusSetup.Reset();
                                HeiFlowVendInvStatusSetup.SetRange("Status ID", 0);
                                if HeiFlowVendInvStatusSetup.FindFirst() then begin
                                    InterfaceEntryLineOut."Global No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                    InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup."Status ID"); //StatusID
                                    InterfaceEntryLineOut."Log Message" := CopyStr(HeiFlowVendInvStatusSetup.Description + lText50001, 1, 200); //StatusDescription
                                    InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                                                                                                      //InterfaceEntryLineOut."E-Mail 2" := '';//PaymentStatus
                                                                                                                      //InterfaceEntryLineOut."Movement Type" := ''; //Open
                                                                                                                      //InterfaceEntryLineOut."Cross Reference No." := '';//DocType
                                                                                                                      //InterfaceEntryLineOut."Blanket Order No." := '';//BatchNo
                                                                                                                      //InterfaceEntryLineOut.Status := '';//OnHold
                                                                                                                      //InterfaceEntryLineOut."External Requisition Line No." := 0;//ClosedByEntryNo
                                end;
                            end;
                        end;


                        if lErrorFound = false then begin
                            HeiFlowVendInvStatusSetup.Reset();
                            HeiFlowVendInvStatusSetup.SetRange("Status ID", 0);
                            if HeiFlowVendInvStatusSetup.FindFirst() then begin
                                InterfaceEntryLineOut."Global No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup."Status ID"); //StatusID
                                InterfaceEntryLineOut."Log Message" := HeiFlowVendInvStatusSetup.Description; //StatusDescription
                                InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                                                                                                  //InterfaceEntryLineOut."E-Mail 2" := '';//PaymentStatus
                                                                                                                  //InterfaceEntryLineOut."Movement Type" := ''; //Open
                                                                                                                  //InterfaceEntryLineOut."Cross Reference No." := '';//DocType
                                                                                                                  //InterfaceEntryLineOut."Blanket Order No." := '';//BatchNo
                                                                                                                  //InterfaceEntryLineOut.Status := '';//OnHold
                                                                                                                  //InterfaceEntryLineOut."External Requisition Line No." := 0;//ClosedByEntryNo
                            end;
                        end;
                    end;
                end
                else begin
                    lErrorFound := false;

                    lErrorFound := false;
                    lVendorLedgerEntry1.Reset();
                    lVendorLedgerEntry1.SetCurrentKey("External Document No.");
                    lVendorLedgerEntry1.SetRange("External Document No.", InterfaceEntryLine."Global No.");
                    if not lVendorLedgerEntry1.FindFirst() then begin
                        lErrorFound := true;
                        HeiFlowVendInvStatusSetup.Reset();
                        HeiFlowVendInvStatusSetup.SetRange("Status ID", 0);
                        if HeiFlowVendInvStatusSetup.FindFirst() then begin
                            InterfaceEntryLineOut."Global No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                            InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup."Status ID"); //StatusID
                            InterfaceEntryLineOut."Log Message" := HeiFlowVendInvStatusSetup.Description; //StatusDescription
                            InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                                                                                              //InterfaceEntryLineOut."E-Mail 2" := '';//PaymentStatus
                                                                                                              //InterfaceEntryLineOut."Movement Type" := ''; //Open
                                                                                                              //InterfaceEntryLineOut."Cross Reference No." := '';//DocType
                                                                                                              //InterfaceEntryLineOut."Blanket Order No." := '';//BatchNo
                                                                                                              //InterfaceEntryLineOut.Status := '';//OnHold
                                                                                                              //InterfaceEntryLineOut."External Requisition Line No." := 0;//ClosedByEntryNo
                        end;
                    end;

                    if lErrorFound = false then begin
                        lVendorLedgerEntry1.Reset();
                        lVendorLedgerEntry1.SetCurrentKey("External Document No.");
                        lVendorLedgerEntry1.SetRange("External Document No.", InterfaceEntryLine."Global No.");
                        lVendorLedgerEntry1.SetRange("Vendor No.", InterfaceEntryLine."Buy-from Vendor No.");
                        if not lVendorLedgerEntry1.FindFirst() then begin
                            lErrorFound := true;
                            HeiFlowVendInvStatusSetup.Reset();
                            HeiFlowVendInvStatusSetup.SetRange("Status ID", 0);
                            if HeiFlowVendInvStatusSetup.FindFirst() then begin
                                InterfaceEntryLineOut."Global No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup."Status ID"); //StatusID
                                InterfaceEntryLineOut."Log Message" := CopyStr(HeiFlowVendInvStatusSetup.Description + lText50000, 1, 200); //StatusDescription
                                InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                                                                                                  //InterfaceEntryLineOut."E-Mail 2" := '';//PaymentStatus
                                                                                                                  //InterfaceEntryLineOut."Movement Type" := ''; //Open
                                                                                                                  //InterfaceEntryLineOut."Cross Reference No." := '';//DocType
                                                                                                                  //InterfaceEntryLineOut."Blanket Order No." := '';//BatchNo
                                                                                                                  //InterfaceEntryLineOut.Status := '';//OnHold
                                                                                                                  //InterfaceEntryLineOut."External Requisition Line No." := 0;//ClosedByEntryNo
                            end;
                        end;
                    end;

                    if lErrorFound = false then begin
                        lVendorLedgerEntry1.Reset();
                        lVendorLedgerEntry1.SetCurrentKey("External Document No.");
                        lVendorLedgerEntry1.SetRange("External Document No.", InterfaceEntryLine."Global No.");
                        lVendorLedgerEntry1.SetRange("Vendor No.", InterfaceEntryLine."Buy-from Vendor No.");
                        lVendorLedgerEntry1.SetRange("Document Type", lVendorLedgerEntry."Document Type"::Invoice);
                        lVendorLedgerEntry1.CalcFields(Amount);
                        lVendorLedgerEntry1.SetRange(Amount, -InterfaceEntryLine."Amount Incl. VAT");
                        if not lVendorLedgerEntry1.FindFirst() then begin
                            lErrorFound := true;
                            HeiFlowVendInvStatusSetup.Reset();
                            HeiFlowVendInvStatusSetup.SetRange("Status ID", 0);
                            if HeiFlowVendInvStatusSetup.FindFirst() then begin
                                InterfaceEntryLineOut."Global No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup."Status ID"); //StatusID
                                InterfaceEntryLineOut."Log Message" := CopyStr(HeiFlowVendInvStatusSetup.Description + lText50001, 1, 200); //StatusDescription
                                InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                                                                                                  //InterfaceEntryLineOut."E-Mail 2" := '';//PaymentStatus
                                                                                                                  //InterfaceEntryLineOut."Movement Type" := ''; //Open
                                                                                                                  //InterfaceEntryLineOut."Cross Reference No." := '';//DocType
                                                                                                                  //InterfaceEntryLineOut."Blanket Order No." := '';//BatchNo
                                                                                                                  //InterfaceEntryLineOut.Status := '';//OnHold
                                                                                                                  //InterfaceEntryLineOut."External Requisition Line No." := 0;//ClosedByEntryNo
                            end;
                        end;
                    end;

                    if lErrorFound = false then begin
                        HeiFlowVendInvStatusSetup.Reset();
                        HeiFlowVendInvStatusSetup.SetRange("Status ID", 0);
                        if HeiFlowVendInvStatusSetup.FindFirst() then begin
                            InterfaceEntryLineOut."Global No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                            InterfaceEntryLineOut."External Requisition No." := Format(HeiFlowVendInvStatusSetup."Status ID"); //StatusID
                            InterfaceEntryLineOut."Log Message" := HeiFlowVendInvStatusSetup.Description; //StatusDescription
                            InterfaceEntryLineOut."External Document No." := InterfaceEntryLine."Global No."; //ExternalDocumentNo
                                                                                                              //InterfaceEntryLineOut."E-Mail 2" := '';//PaymentStatus
                                                                                                              //InterfaceEntryLineOut."Movement Type" := ''; //Open
                                                                                                              //InterfaceEntryLineOut."Cross Reference No." := '';//DocType
                                                                                                              //InterfaceEntryLineOut."Blanket Order No." := '';//BatchNo
                                                                                                              //InterfaceEntryLineOut.Status := '';//OnHold
                                                                                                              //InterfaceEntryLineOut."External Requisition Line No." := 0;//ClosedByEntryNo
                        end;
                    end;
                end;
                InterfaceEntryLineOut.Insert(true);
            until InterfaceEntryLine.Next() = 0;
        //HEI.02<<
    end;

    procedure GetDocNo(_JournalTemplate: Code[20]; _JournalBatch: Code[20]; _PostingDate: Date): Code[20];
    var
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlBatch: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit "No. Series";
        BatchPostingNoSeries: Code[20];
        _DocNo: Code[20];
    begin
        //function logic copied from report 50442 Mass Upload
        GenJnlBatch.Reset();
        GenJnlBatch.SetFilter(GenJnlBatch."Journal Template Name", _JournalTemplate);
        GenJnlBatch.SetFilter(GenJnlBatch.Name, _JournalBatch);
        if (GenJnlBatch.FindFirst()) then begin
            if (GenJnlBatch."Posting No. Series" <> '') then
                BatchPostingNoSeries := GenJnlBatch."Posting No. Series"
            else if (GenJnlBatch."No. Series" <> '') then
                BatchPostingNoSeries := GenJnlBatch."No. Series"
            else if (GenJnlBatch."Posting No. Series" = '') and (GenJnlBatch."No. Series" = '') then
                _DocNo := '';
            // BC Upgrade POENAB02 >>            
            //if (GenJnlBatch."Posting No. Series" <> '') or (GenJnlBatch."No. Series" <> '') then
            //    _DocNo := NoSeriesMgt.TryGetNextNo(BatchPostingNoSeries, _PostingDate);
            if (GenJnlBatch."Posting No. Series" <> '') or (GenJnlBatch."No. Series" <> '') then
                _DocNo := NoSeriesMgt.GetNextNo(BatchPostingNoSeries, _PostingDate);
            // BC Upgrade POENAB02 <<
            /*
           IF  (GenJnlBatch."Posting No. Series" <> '') AND (GenJnlBatch."No. Series" = '') THEN
            GenJournalLineRecL."Posting No. Series" := BatchPostingNoSeries;
            */
            exit(_DocNo);
        end else
            exit('');

    end;

    procedure CreateExtourneAutoLine(pJournalTemplateName: Code[10]; pJournalBatchName: Code[10]; pLineNo: Integer; pReversalDate: Date);
    var
        GenJnlExtLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        lLineNo: Integer;
    begin
        lLineNo := 10000;
        GenJnlLine2.Reset();
        GenJnlLine2.SetRange("Journal Template Name", pJournalTemplateName);
        GenJnlLine2.SetRange("Journal Batch Name", pJournalBatchName);
        if GenJnlLine2.FindLast() then
            lLineNo := GenJnlLine2."Line No.";

        GenJnlLine2.Reset();
        GenJnlLine2.SetRange("Journal Template Name", pJournalTemplateName);
        GenJnlLine2.SetRange("Journal Batch Name", pJournalBatchName);
        GenJnlLine2.SetFilter("Line No.", '>=%1&<=%2', pLineNo, lLineNo);
        if GenJnlLine2.FindSet(false) then
            repeat
                lLineNo += 10000;
                GenJnlExtLine.TransferFields(GenJnlLine2);
                if pReversalDate <> 0D then
                    GenJnlExtLine.Validate("Posting Date", pReversalDate);
                if GenJnlLine2."Credit Amount" <> 0 then
                    GenJnlExtLine.Validate("Debit Amount", GenJnlLine2."Credit Amount");
                if GenJnlLine2."Debit Amount" <> 0 then
                    GenJnlExtLine.Validate("Credit Amount", GenJnlLine2."Debit Amount");
                GenJnlExtLine."Line No." := lLineNo;
                GenJnlExtLine.Insert();
            until GenJnlLine2.Next() = 0;
    end;
}

