report 52007 "Delete Preview Posted Document"
{
    // version HEI.03

    // HEI.01 CHG2226487 CC-INC4901484 IBM MAJUMS03 07.11.2023 # series no. for invoicing
    //   # This report is only used to Delete the Posted Purchase Invoice No. '***' from the system. Posting Preview functionality is not working due to an Error for
    //   the existance of the Posted Purchase Invoice# '***' in the system.
    // 
    // HEI.02 CHG2226487 CC-INC4901484 IBM MAJUMS03 08.11.2023 # series no. for invoicing
    //   # Renaming of Object as "Delete Preview Posted Document". "Posting Date" is added as ReqFilterFields in "Purch. Inv. Header" DataItem. DataFields are removed
    // HEI.03 CHG2233710 IBM SRIVAS07 02.01.2024 # We can’t preview the posting on PO Purchase invoice and Purchase invoice
    //    # This report is used to Delete the Posted Purchase Invoice No. '***' from the system and update the respective Posted Docuemnts. Posting Preview functionality is not working due to an Error for
    //      the existance of the Posted Purchase Invoice# '***' in the system.

    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in report and requestpage field.
    // 2. Change NoSeriesmanagement to "No. Series".
    // 3. Old Report ID - 50563
    // BC Upgrade BHARDA11 <<

    // BC Upgrade MISHRS14 >>
    // Added HEI.04 Tag in whole report
    // HEI.04 CHG2343884 IBM SAHAL01 13.03.2026 Preview posting blocked on the production
    // # Added Code
    // BC Upgrade MISHRS14 <<

    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Permissions = TableData "G/L Entry" = rimd,
                  TableData "Vendor Ledger Entry" = rimd,
                  TableData "Purch. Inv. Header" = rimd,
                  TableData "Purch. Inv. Line" = rimd,
                  TableData "VAT Entry" = rimd,
                  TableData "Detailed Vendor Ledg. Entry" = rimd,
                  TableData "Value Entry" = rimd,
                  TableData "Purchase Additional Fields FND" = rimd,
                  TableData "WHT Entry FND" = rimd,
                  TableData "Purch. Inv. Header Add FND" = rimd;
    ProcessingOnly = true;
    Caption = 'Delete Preview Posted Document';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                //HEI.03>>
                // HEI.04
                //PurchasesPayablesSetup.GET;
                // HEI.04

                IF Countonly = TRUE THEN BEGIN
                    MESSAGE('%1 Purch. Inv. Header', "Purch. Inv. Header".COUNT);

                    PIL.SETFILTER(PIL."Document No.", '=%1', '***');
                    IF PIL.FINDFIRST THEN
                        MESSAGE('%1 Purch. Inv. Line', PIL.COUNT);

                    PIHadd.SETFILTER(PIHadd."No.", '=%1', '***');
                    IF PIHadd.FINDFIRST THEN
                        MESSAGE('%1 Purch. Inv. Header additional', PIHadd.COUNT);

                    NewNo := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Posted Invoice Nos.", "Purch. Inv. Header"."Posting Date", FALSE);//not to modify no series last used
                    MESSAGE(NewNo);
                    Countledger;
                END
                ELSE BEGIN
                    NewNo := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Posted Invoice Nos.", "Purch. Inv. Header"."Posting Date", TRUE);
                    Updateledger;

                    PIHadd.SETFILTER(PIHadd."No.", '=%1', '***');
                    IF PIHadd.FINDFIRST THEN BEGIN
                        NewPIHadd.INIT;
                        NewPIHadd."No." := NewNo;
                        NewPIHadd.TRANSFERFIELDS(PIHadd);
                        NewPIHadd."No." := NewNo;
                        NewPIHadd.INSERT(FALSE);
                        PIHadd.DELETE(TRUE);
                    END;

                    PIL.SETFILTER(PIL."Document No.", '=%1', '***');
                    IF PIL.FINDFIRST THEN BEGIN
                        REPEAT
                            NewPIL.INIT;
                            NewPIL."Document No." := NewNo;
                            NewPIL.TRANSFERFIELDS(PIL);
                            NewPIL."Document No." := NewNo;
                            NewPIL.INSERT(FALSE);
                            PIL.DELETE(TRUE);
                        UNTIL PIL.NEXT = 0;
                    END;

                    NewPIH.INIT;
                    NewPIH."No." := NewNo;
                    NewPIH.TRANSFERFIELDS("Purch. Inv. Header");
                    NewPIH."No." := NewNo;
                    NewPIH.INSERT(FALSE);
                    "Purch. Inv. Header".DELETE(TRUE);

                END;

                /*
                //>>HEI.01
                IF "Purch. Inv. Header"."No." <> '***' THEN BEGIN
                  CurrReport.SKIP;
                END ELSE BEGIN
                  "Purch. Inv. Header".DELETE(TRUE);
                END;
                //<<HEI.01
                */
                //HEI.03<<

            end;

            trigger OnPreDataItem()
            begin
                //HEI.04>>
                IF ExecutedFor <> ExecutedFor::"Posted Invoice" THEN
                CurrReport.BREAK;
                SETFILTER("Purch. Inv. Header"."No.", '=%1', '***');
                //HEI.04>>
                IF (PIHPostingDate <> PostingDate) AND (PostingDate <> 0D) AND GUIALLOWED THEN
                IF NOT CONFIRM(Text003,TRUE,PostingDate,TABLECAPTION,FIELDCAPTION("Posting Date"),PIHPostingDate) THEN
                    ERROR('');
                IF (VendInvNo <> ExternalDocNo) AND (ExternalDocNo <> '') AND GUIALLOWED THEN
                IF NOT CONFIRM(Text004,TRUE,ExternalDocNo,TABLECAPTION,FIELDCAPTION("Vendor Invoice No."),VendInvNo) THEN
                    ERROR('');
                //HEI.04<<
            end;
        }
        //HEI.04>>
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);

            trigger OnPreDataItem()
            begin
                if ExecutedFor <> ExecutedFor::"Posted Cr. Memo" then
                    CurrReport.Break();

                SetFilter("No.", '=%1', '***');

                if (PCrMHPostingDate <> PostingDate) and
                (PostingDate <> 0D) and GuiAllowed then
                    if not Confirm(
                        Text003,
                        true,
                        PostingDate,
                        TableCaption,
                        FieldCaption("Posting Date"),
                        PCrMHPostingDate)
                    then
                        Error('');

                if (VendCrMemoNo <> ExternalDocNo) and
                (ExternalDocNo <> '') and GuiAllowed then
                    if not Confirm(
                        Text004,
                        true,
                        ExternalDocNo,
                        TableCaption,
                        FieldCaption("Vendor Cr. Memo No."),
                        VendCrMemoNo)
                    then
                        Error('');
            end;

            trigger OnAfterGetRecord()
            begin
                if Countonly then begin

                    Message('%1 %2', Count, TableCaption);

                    PurchCrMemoLineL.SetFilter("Document No.", '=%1', '***');
                    if PurchCrMemoLineL.FindFirst() then
                        Message('%1 %2',
                                PurchCrMemoLineL.Count,
                                PurchCrMemoLineL.TableCaption);

                    PurchCrMemoHdrAddL.SetFilter("No.", '=%1', '***');
                    if PurchCrMemoHdrAddL.FindFirst() then
                        Message('%1 %2',
                                PurchCrMemoHdrAddL.Count,
                                PurchCrMemoHdrAddL.TableCaption);

                    NewNo := NoSeriesManagement.GetNextNo(
                        PurchasesPayablesSetup."Posted Credit Memo Nos.",
                        "Posting Date",
                        false);

                    Message(NewNo);

                    CountCrMemoLedger();

                end else begin

                    NewNo := NoSeriesManagement.GetNextNo(
                        PurchasesPayablesSetup."Posted Credit Memo Nos.",
                        "Posting Date",
                        true);

                    UpdateCrMemoLedger();

                    PurchCrMemoHdrAddL.SetFilter("No.", '=%1', '***');

                    if PurchCrMemoHdrAddL.FindFirst() then begin
                        NewPurchCrMemoHdrAddL.Init();
                        NewPurchCrMemoHdrAddL."No." := NewNo;
                        NewPurchCrMemoHdrAddL.TransferFields(PurchCrMemoHdrAddL);
                        NewPurchCrMemoHdrAddL."No." := NewNo;
                        NewPurchCrMemoHdrAddL.Insert(false);
                        PurchCrMemoHdrAddL.Delete(true);
                    end;

                    PurchCrMemoLineL.SetFilter("Document No.", '=%1', '***');

                    if PurchCrMemoLineL.FindSet(true) then
                        repeat
                            NewPurchCrMemoLineL.Init();
                            NewPurchCrMemoLineL."Document No." := NewNo;
                            NewPurchCrMemoLineL.TransferFields(PurchCrMemoLineL);
                            NewPurchCrMemoLineL."Document No." := NewNo;
                            NewPurchCrMemoLineL.Insert(false);
                            PurchCrMemoLineL.Delete(true);
                        until PurchCrMemoLineL.Next() = 0;

                    NewPurchCrMemoHdrL.Init();
                    NewPurchCrMemoHdrL."No." := NewNo;
                    NewPurchCrMemoHdrL.TransferFields("Purch. Cr. Memo Hdr.");
                    NewPurchCrMemoHdrL."No." := NewNo;
                    NewPurchCrMemoHdrL.Insert(false);

                    Delete(true);
                end;
            end;
        }
        //HEI.04<<
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Countonly; Countonly)
                {
                    ApplicationArea = All;
                    Caption = 'Count Only';
                }

                //HEI.04>>
                field(ExecutedFor; ExecutedFor)
                {
                    ApplicationArea = All;
                }

                field(PostingDate; PostingDate)
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                }

                field(ExternalDocNo; ExternalDocNo)
                {
                    ApplicationArea = All;
                    Caption = 'External Document No.';
                }
                //HEI.04<<
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        g: Record "Purch. Inv. Header";
        GLEntry: Record "G/L Entry";
        VATEntry: Record "VAT Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        WHTEntry: Record "WHT Entry FND";
        ValueEntry: Record "Value Entry";
        NewNo: Code[20];
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit "No. Series";
        Countonly: Boolean;
        PIL: Record "Purch. Inv. Line";
        PIHadd: Record "Purch. Inv. Header Add FND";
        NewPIH: Record "Purch. Inv. Header";
        NewPIL: Record "Purch. Inv. Line";
        NewPIHadd: Record "Purch. Inv. Header Add FND";
        PurchaseAdditionalFields: Record "Purchase Additional Fields FND";

        //HEI.04>>
        FALedgerEntryL: Record "FA Ledger Entry";
        ExecutedFor: Option " ","Posted Invoice","Posted Cr. Memo";
        PIHPostingDate: Date;
        VendInvNo: Code[35];
        PostingDate: Date;
        ExternalDocNo: Code[35];
        Text000: Label 'FA Ledger Entry';
        Text002: Label 'Executed For must be %1 or %2.';
        Text003: Label 'Selected Posting Date %1 does not match %2 %3. Actual value is %4. Continue?';
        Text004: Label 'Selected External Document No. %1 does not match %2 %3. Actual value is %4. Continue?';
        //HEI.04<<
        //HEI.04>>
        PurchCrMemoLineL: Record "Purch. Cr. Memo Line";
        PurchCrMemoHdrAddL: Record "Purch. Cr. Memo Hdr. Add FND";

        NewPurchCrMemoHdrL: Record "Purch. Cr. Memo Hdr.";
        NewPurchCrMemoLineL: Record "Purch. Cr. Memo Line";
        NewPurchCrMemoHdrAddL: Record "Purch. Cr. Memo Hdr. Add FND";

        PCrMHPostingDate: Date;
        VendCrMemoNo: Code[35];
        //HEI.04<<

    //HEI.04>>
    trigger OnPreReport()
    begin
        if ExecutedFor = ExecutedFor::" " then
            Error(
            Text002,
            ExecutedFor::"Posted Invoice",
            ExecutedFor::"Posted Cr. Memo");

        PurchasesPayablesSetup.Get();
    end;
    //HEI.04<<

    local procedure Updateledger()
    begin

        //HEI.04>>
        if ExecutedFor <> ExecutedFor::"Posted Invoice" then
            exit;
        //HEI.04<<

        //HEI.03>>
        PurchaseAdditionalFields.SETFILTER(PurchaseAdditionalFields."Document No.", '=%1', '***');
        //HEI.04>>
        PurchaseAdditionalFields.SETRANGE(TableID,DATABASE::"Purch. Inv. Header");
        PurchaseAdditionalFields.SETRANGE("Document Type",PurchaseAdditionalFields."Document Type"::"Posted Invoice");
        //HEI.04<<
        IF PurchaseAdditionalFields.FINDFIRST THEN

        //HEI.04>>
            //PurchaseAdditionalFields.DELETEALL;
            PurchaseAdditionalFields.RENAME(PurchaseAdditionalFields.TableID,PurchaseAdditionalFields."Document Type",NewNo);
            //HEI.04<<

        GLEntry.SETFILTER(GLEntry."Document No.", '=%1', '***');
        //HEI.04>>
            GLEntry.SETFILTER("Document Type",'<>%1',GLEntry."Document Type"::"Credit Memo");
            IF PostingDate <> 0D THEN
            GLEntry.SETRANGE("Posting Date",PostingDate);
            IF ExternalDocNo <> '' THEN
            GLEntry.SETRANGE("External Document No.",ExternalDocNo);
            //HEI.04<<
        IF GLEntry.FINDFIRST THEN
            GLEntry.MODIFYALL("Document No.", NewNo);

        VATEntry.SETFILTER(VATEntry."Document No.", '=%1', '***');
        //HEI.04>>
        VATEntry.SETFILTER("Document Type",'<>%1',VATEntry."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        VATEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        VATEntry.SETRANGE("External Document No.",ExternalDocNo);
        //HEI.04<<
        IF VATEntry.FINDFIRST THEN
            VATEntry.MODIFYALL("Document No.", NewNo);


        VendorLedgerEntry.SETFILTER(VendorLedgerEntry."Document No.", '=%1', '***');
        //HEI.04>>
        VendorLedgerEntry.SETFILTER("Document Type",'<>%1',VendorLedgerEntry."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        VendorLedgerEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        VendorLedgerEntry.SETRANGE("External Document No.",ExternalDocNo);
        //HEI.04<<
        IF VendorLedgerEntry.FINDFIRST THEN
            VendorLedgerEntry.MODIFYALL("Document No.", NewNo);


        DetailedVendorLedgEntry.SETFILTER(DetailedVendorLedgEntry."Document No.", '=%1', '***');
        //HEI.04>>
        DetailedVendorLedgEntry.SETFILTER("Document Type",'<>%1',DetailedVendorLedgEntry."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        DetailedVendorLedgEntry.SETRANGE("Posting Date",PostingDate);
        //HEI.04<<
        IF DetailedVendorLedgEntry.FINDFIRST THEN
            DetailedVendorLedgEntry.MODIFYALL("Document No.", NewNo);


        WHTEntry.SETFILTER(WHTEntry."Document No.", '=%1', '***');
        //HEI.04>>
        WHTEntry.SETFILTER("Document Type",'<>%1',WHTEntry."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        WHTEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        WHTEntry.SETRANGE("External Document No.",ExternalDocNo);
        //HEI.04<<
        IF WHTEntry.FINDFIRST THEN
            WHTEntry.MODIFYALL("Document No.", NewNo);


        ValueEntry.SETFILTER(ValueEntry."Document No.", '=%1', '***');
        //HEI.04>>
         ValueEntry.SETFILTER("Document Type",'<>%1',ValueEntry."Document Type"::"Purchase Credit Memo");
        IF PostingDate <> 0D THEN
        ValueEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        ValueEntry.SETRANGE("External Document No.",ExternalDocNo);
        //HEI.04<<
        IF ValueEntry.FINDFIRST THEN
            ValueEntry.MODIFYALL("Document No.", NewNo);
        //HEI.03<<

        //HEI.04>>
        FALedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        FALedgerEntryL.SETFILTER("Document No.",'=%1','***');
        FALedgerEntryL.SETFILTER("Document Type",'<>%1',FALedgerEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        FALedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        FALedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF FALedgerEntryL.FINDSET(TRUE) THEN
        FALedgerEntryL.MODIFYALL("Document No.",NewNo);
        //HEI.04<<
    end;

    local procedure Countledger()
    begin
        //HEI.04>>
        IF ExecutedFor <> ExecutedFor::"Posted Invoice" THEN
        EXIT;
        //HEI.04<<
        //HEI.03>>
        PurchaseAdditionalFields.SETFILTER(PurchaseAdditionalFields."Document No.", '=%1', '***');
        //HEI.04>>
        PurchaseAdditionalFields.SETRANGE(TableID,DATABASE::"Purch. Inv. Header");
        PurchaseAdditionalFields.SETRANGE("Document Type",PurchaseAdditionalFields."Document Type"::"Posted Invoice");
        //HEI.04<<
        IF PurchaseAdditionalFields.FINDFIRST THEN
            MESSAGE('%1 PurchaseAdditionalFields', PurchaseAdditionalFields.COUNT);

        GLEntry.SETFILTER(GLEntry."Document No.", '=%1', '***');
        //HEI.04>>
        GLEntry.SETFILTER("Document Type",'<>%1',GLEntry."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        GLEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        GLEntry.SETRANGE("External Document No.",ExternalDocNo);
        //HEI.04<<
        IF GLEntry.FINDFIRST THEN
            MESSAGE('%1 GLEntry', GLEntry.COUNT);

        VATEntry.SETFILTER(VATEntry."Document No.", '=%1', '***');
        //HEI.04>>
        VATEntry.SETFILTER("Document Type",'<>%1',VATEntry."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        VATEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        VATEntry.SETRANGE("External Document No.",ExternalDocNo);
        //HEI.04<<
        IF VATEntry.FINDFIRST THEN
            MESSAGE('%1 vatentry', VATEntry.COUNT);

        VendorLedgerEntry.SETFILTER(VendorLedgerEntry."Document No.", '=%1', '***');
        //HEI.04>>
        VendorLedgerEntry.SETFILTER("Document Type",'<>%1',VendorLedgerEntry."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        VendorLedgerEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        VendorLedgerEntry.SETRANGE("External Document No.",ExternalDocNo);
        //HEI.04<<
        IF VendorLedgerEntry.FINDFIRST THEN
            MESSAGE('%1 VendorLedgerEntry', VendorLedgerEntry.COUNT);

        DetailedVendorLedgEntry.SETFILTER(DetailedVendorLedgEntry."Document No.", '=%1', '***');
        //HEI.04>>
        DetailedVendorLedgEntry.SETFILTER("Document Type",'<>%1',DetailedVendorLedgEntry."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        DetailedVendorLedgEntry.SETRANGE("Posting Date",PostingDate);
        //HEI.04<<
        IF DetailedVendorLedgEntry.FINDFIRST THEN
            MESSAGE('%1 DetailedVendorLedgEntry', DetailedVendorLedgEntry.COUNT);

        WHTEntry.SETFILTER(WHTEntry."Document No.", '=%1', '***');
        //HEI.04>>
        WHTEntry.SETFILTER("Document Type",'<>%1',WHTEntry."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        WHTEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        WHTEntry.SETRANGE("External Document No.",ExternalDocNo);
        //HEI.04<<
        IF WHTEntry.FINDFIRST THEN
            MESSAGE('%1 WHTEntry', WHTEntry.COUNT);

        ValueEntry.SETFILTER(ValueEntry."Document No.", '=%1', '***');
        //HEI.04>>
        ValueEntry.SETFILTER("Document Type",'<>%1',ValueEntry."Document Type"::"Purchase Credit Memo");
        IF PostingDate <> 0D THEN
        ValueEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        ValueEntry.SETRANGE("External Document No.",ExternalDocNo);
        //HEI.04<<
        IF ValueEntry.FINDFIRST THEN
            MESSAGE('%1 value', ValueEntry.COUNT);
        //HEI.03<<
        //HEI.04>>
        FALedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        FALedgerEntryL.SETFILTER("Document No.",'=%1','***');
        FALedgerEntryL.SETFILTER("Document Type",'<>%1',FALedgerEntryL."Document Type"::"Credit Memo");
        IF PostingDate <> 0D THEN
        FALedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        FALedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF FALedgerEntryL.FINDSET(FALSE) THEN
        MESSAGE('%1 %2',FALedgerEntryL.COUNT,Text000);
        //HEI.04<<
    end;
    //HEI.04>>
    local procedure CountCrMemoLedger()
    begin
        //HEI.04>>
        IF ExecutedFor <> ExecutedFor::"Posted Cr. Memo" THEN
        EXIT;

        PurchaseAdditionalFields.SETCURRENTKEY("Document No.",TableID,"Document Type");
        PurchaseAdditionalFields.SETFILTER("Document No.",'=%1','***');
        PurchaseAdditionalFields.SETRANGE(TableID,DATABASE::"Purch. Cr. Memo Hdr.");
        PurchaseAdditionalFields.SETRANGE("Document Type",PurchaseAdditionalFields."Document Type"::"Posted Cr. Memo");
        IF PurchaseAdditionalFields.FINDFIRST THEN
        MESSAGE('%1 %2',PurchaseAdditionalFields.COUNT,PurchaseAdditionalFields.TABLECAPTION);

        GLEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        GLEntry.SETFILTER("Document No.",'=%1','***');
        GLEntry.SETFILTER("Document Type",'<>%1',GLEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        GLEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        GLEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF GLEntry.FINDSET(FALSE) THEN
        MESSAGE('%1 %2',GLEntry.COUNT,GLEntry.TABLECAPTION);

        VATEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VATEntry.SETFILTER("Document No.",'=%1','***');
        VATEntry.SETFILTER("Document Type",'<>%1',VATEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        VATEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        VATEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF VATEntry.FINDSET(FALSE) THEN
        MESSAGE('%1 %2',VATEntry.COUNT,VATEntry.TABLECAPTION);

        VendorLedgerEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VendorLedgerEntry.SETFILTER("Document No.",'=%1','***');
        VendorLedgerEntry.SETFILTER("Document Type",'<>%1',VendorLedgerEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        VendorLedgerEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        VendorLedgerEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF VendorLedgerEntry.FINDSET(FALSE) THEN
        MESSAGE('%1 %2',VendorLedgerEntry.COUNT,VendorLedgerEntry.TABLECAPTION);

        DetailedVendorLedgEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date");
        DetailedVendorLedgEntry.SETFILTER("Document No.",'=%1','***');
        DetailedVendorLedgEntry.SETFILTER("Document Type",'<>%1',DetailedVendorLedgEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        DetailedVendorLedgEntry.SETRANGE("Posting Date",PostingDate);
        IF DetailedVendorLedgEntry.FINDSET(FALSE) THEN
        MESSAGE('%1 %2',DetailedVendorLedgEntry.COUNT,DetailedVendorLedgEntry.TABLECAPTION);

        WHTEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        WHTEntry.SETFILTER("Document No.",'=%1','***');
        WHTEntry.SETFILTER("Document Type",'<>%1',WHTEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        WHTEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        WHTEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF WHTEntry.FINDSET(FALSE) THEN
        MESSAGE('%1 %2',WHTEntry.COUNT,WHTEntry.TABLECAPTION);

        ValueEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        ValueEntry.SETFILTER("Document No.",'=%1','***');
        ValueEntry.SETFILTER("Document Type",'<>%1',ValueEntry."Document Type"::"Purchase Invoice");
        IF PostingDate <> 0D THEN
        ValueEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        ValueEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF ValueEntry.FINDSET(FALSE) THEN
        MESSAGE('%1 %2',ValueEntry.COUNT,ValueEntry.TABLECAPTION);

        FALedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        FALedgerEntryL.SETFILTER("Document No.",'=%1','***');
        FALedgerEntryL.SETFILTER("Document Type",'<>%1',FALedgerEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        FALedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        FALedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF FALedgerEntryL.FINDSET(FALSE) THEN
        MESSAGE('%1 %2',FALedgerEntryL.COUNT,Text000);
        //HEI.04<<
    end;
    //HEI.04<<

    //HEI.04>>
    local procedure UpdateCrMemoLedger()
    begin
        //HEI.04>>
        IF ExecutedFor <> ExecutedFor::"Posted Cr. Memo" THEN
        EXIT;

        PurchaseAdditionalFields.SETCURRENTKEY("Document No.",TableID,"Document Type");
        PurchaseAdditionalFields.SETFILTER("Document No.",'=%1','***');
        PurchaseAdditionalFields.SETRANGE(TableID,DATABASE::"Purch. Cr. Memo Hdr.");
        PurchaseAdditionalFields.SETRANGE("Document Type",PurchaseAdditionalFields."Document Type"::"Posted Cr. Memo");
        IF PurchaseAdditionalFields.FINDFIRST THEN
        PurchaseAdditionalFields.RENAME(PurchaseAdditionalFields.TableID,PurchaseAdditionalFields."Document Type",NewNo);

        GLEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        GLEntry.SETFILTER("Document No.",'=%1','***');
        GLEntry.SETFILTER("Document Type",'<>%1',GLEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        GLEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        GLEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF GLEntry.FINDSET(TRUE) THEN
        GLEntry.MODIFYALL("Document No.",NewNo);

        VATEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VATEntry.SETFILTER("Document No.",'=%1','***');
        VATEntry.SETFILTER("Document Type",'<>%1',VATEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        VATEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        VATEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF VATEntry.FINDSET(TRUE) THEN
        VATEntry.MODIFYALL("Document No.",NewNo);

        VendorLedgerEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        VendorLedgerEntry.SETFILTER("Document No.",'=%1','***');
        VendorLedgerEntry.SETFILTER("Document Type",'<>%1',VendorLedgerEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        VendorLedgerEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        VendorLedgerEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF VendorLedgerEntry.FINDSET(TRUE) THEN
        VendorLedgerEntry.MODIFYALL("Document No.",NewNo);

        DetailedVendorLedgEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date");
        DetailedVendorLedgEntry.SETFILTER("Document No.",'=%1','***');
        DetailedVendorLedgEntry.SETFILTER("Document Type",'<>%1',DetailedVendorLedgEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        DetailedVendorLedgEntry.SETRANGE("Posting Date",PostingDate);
        IF DetailedVendorLedgEntry.FINDSET(TRUE) THEN
        DetailedVendorLedgEntry.MODIFYALL("Document No.",NewNo);

        WHTEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        WHTEntry.SETFILTER("Document No.",'=%1','***');
        WHTEntry.SETFILTER("Document Type",'<>%1',WHTEntry."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        WHTEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        WHTEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF WHTEntry.FINDSET(TRUE) THEN
        WHTEntry.MODIFYALL("Document No.",NewNo);

        ValueEntry.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        ValueEntry.SETFILTER("Document No.",'=%1','***');
        ValueEntry.SETFILTER("Document Type",'<>%1',ValueEntry."Document Type"::"Purchase Invoice");
        IF PostingDate <> 0D THEN
        ValueEntry.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        ValueEntry.SETRANGE("External Document No.",ExternalDocNo);
        IF ValueEntry.FINDSET(TRUE) THEN
        ValueEntry.MODIFYALL("Document No.",NewNo);

        FALedgerEntryL.SETCURRENTKEY("Document No.","Document Type","Posting Date","External Document No.");
        FALedgerEntryL.SETFILTER("Document No.",'=%1','***');
        FALedgerEntryL.SETFILTER("Document Type",'<>%1',FALedgerEntryL."Document Type"::Invoice);
        IF PostingDate <> 0D THEN
        FALedgerEntryL.SETRANGE("Posting Date",PostingDate);
        IF ExternalDocNo <> '' THEN
        FALedgerEntryL.SETRANGE("External Document No.",ExternalDocNo);
        IF FALedgerEntryL.FINDSET(TRUE) THEN
        FALedgerEntryL.MODIFYALL("Document No.",NewNo);
        //HEI.04<<
    end;
    //HEI.04<<
}

