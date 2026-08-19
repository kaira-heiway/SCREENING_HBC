report 51009 "Duplicate Vend No. CBN"
{
    // version HEI.01

    // HNK.01 FDD PTPGAP030 IBM.NAIKH01 12.01.2018
    //    # Created a New report.
    // 
    // DEFECT #1472 12.02.18 IBM.NAIKH01
    //   # Created a New Report
    // 
    // HEI.02 CHG2007917 IBM.AB 20.03.2019
    //    # Bug fixed for Vendor Names
    // BC Upgrade BHARDA11 >>
    // 1. Add layout path and change layout extension rdlc to rdl.
    // 2. Remove Drink-IT Field ("Document Subtype Code").
    // 3  Add ApplicationArea to Report and Requestpage fields.
    // BC Upgrade BHARDA11 <<
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Duplicate Vend No..rdl'; // BC Upgrade BHARDA11 ---Add Path and change extension rdlc to rdl

    Permissions = TableData "Vendor Ledger Entry" = rimd;
    ProcessingOnly = false;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);
            UseTemporary = false;
            column(EntryNo; tempVLE1."Closed by Entry No.")
            {
            }
            column(VendorNo; tempVLE1."Vendor No.")
            {
            }
            column(PostingDate; tempVLE1."Posting Date")
            {
            }
            column(DocumentType; tempVLE1."Document Type")
            {
            }
            column(DocumentNo; tempVLE1."Document No.")
            {
            }
            column(DocumentSubtypeCode; tempVLE1."Document Subtype Code FND") // BC Upgrade SHUKLP03
            {
            }
            column(ExternalDocumentNo; tempVLE1."External Document No.")
            {
            }
            column(Description; tempVLE1.Description)
            {
            }
            column(CurrencyCode; tempVLE1."Currency Code")
            {
            }
            column(Amount; tempVLE1."Closed by Amount")
            {
            }
            column(RemainingAmount; tempVLE1."Remaining Amount")
            {
            }
            column(RemainingAmtLCY; tempVLE1."Remaining Amt. (LCY)")
            {
            }
            column(VendorPostingGroup; tempVLE1."Vendor Posting Group")
            {
            }
            column(DuplicateEntryNo; tempVLE1."Duplicate Entry No. FND")
            {
            }
            column(vendorname; vendorname)
            {
            }
            column(DocumentDate; tempVLE1."Document Date")
            {
            }

            trigger OnAfterGetRecord();
            begin
                //>>HEI.02
                //IF Vend.GET(tempVLE1."Vendor No.") THEN
                //vendorname := Vend.Name;
                //<<HEI.02
                IF Number = 1 THEN
                    tempVLE1.FINDFIRST
                ELSE
                    tempVLE1.NEXT;

                //>>HEI.02
                IF Vend.GET(tempVLE1."Vendor No.") THEN
                    vendorname := Vend.Name;
                //<<HEI.02
            end;

            trigger OnPreDataItem();
            begin

                SETRANGE(Number, 1, tempVLE1.COUNT);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field("Posting Date"; ParPostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        EntryNolbl = 'Entry No'; VendorNolbl = 'Vendor No'; PostingDatelbl = 'Posting Date'; DocumentTypelbl = 'Document Type'; DocumentNolbl = 'Document No'; DocumentSubtypeCodelbl = 'Document Subtype Code'; ExternalDocumentNolbl = 'External Document No'; Descriptionlbl = 'Description'; CurrencyCodelbl = 'Curr Code'; Amountlbl = 'Amount'; RemainingAmountlbl = 'Remaining Amount'; AmountLCYlbl = 'Amount (LCY)'; RemainingAmtLCYlbl = 'Remaining Amt. LCY'; VendorPostingGrouplbl = 'Vendor Posting Group'; DuplicateEntryNlbl = 'Duplicate Entry No'; VendorNamelbl = 'Vendor Name'; DocDate = 'Document Date';
    }

    trigger OnInitReport();
    begin

        InitializeValues;
    end;

    trigger OnPreReport();
    begin
        IF ParPostingDate = 0D THEN
            ERROR(Error01);
        //below fn updates duplicate entry no in VLE;
        ClearDuplicateVendNo;

        ToDatePosting := CALCDATE('<1Y>', TODAY);

        VendorLedgerEntry.RESET;
        VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
        VendorLedgerEntry.SETFILTER("Posting Date", '%1..%2', ParPostingDate, ToDatePosting);
        IF VendorLedgerEntry.FINDSET THEN
            REPEAT
                VendorLedgerEntry.CALCFIELDS(Amount);
                GlobalUpdateVLE(VendorLedgerEntry);

            UNTIL VendorLedgerEntry.NEXT = 0;


        VendorLedgerEntry.RESET;
        VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::Invoice);
        VendorLedgerEntry.SETFILTER("Posting Date", '%1..%2', ParPostingDate, ToDatePosting);
        IF VendorLedgerEntry.FINDSET THEN
            REPEAT
                tempVLE.RESET;
                tempVLE.SETRANGE("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                tempVLE.SETRANGE("Message to Recipient", 'VD');
                IF tempVLE.FINDFIRST THEN
                    InsertToTemptbl(tempVLE);

                tempVLE.RESET;
                tempVLE.SETRANGE("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                tempVLE.SETRANGE("Message to Recipient", 'VA');
                IF tempVLE.FINDFIRST THEN
                    InsertToTemptbl(tempVLE);

                tempVLE.RESET;
                tempVLE.SETRANGE("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                tempVLE.SETRANGE("Message to Recipient", 'VI');
                IF tempVLE.FINDFIRST THEN
                    InsertToTemptbl(tempVLE);

                tempVLE.RESET;
                tempVLE.SETRANGE("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                tempVLE.SETRANGE("Message to Recipient", 'DI');
                IF tempVLE.FINDFIRST THEN
                    InsertToTemptbl(tempVLE);

                tempVLE.RESET;
                tempVLE.SETRANGE("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                tempVLE.SETRANGE("Message to Recipient", 'DA');
                IF tempVLE.FINDFIRST THEN
                    InsertToTemptbl(tempVLE);

                tempVLE.RESET;
                tempVLE.SETRANGE("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                tempVLE.SETRANGE("Message to Recipient", 'IA');
                IF tempVLE.FINDFIRST THEN
                    InsertToTemptbl(tempVLE);

            UNTIL VendorLedgerEntry.NEXT = 0;

        IF tempVLE1.FINDSET THEN BEGIN
            REPEAT

                IF tempVLE1."Message to Recipient" = 'VD' THEN BEGIN
                    IF (IncrementInt_VD1 = tempVLE1."Duplicate Entry No. FND") OR (Str_VD = tempVLE1."Duplicate Entry No. FND") THEN BEGIN
                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_VD1;
                        tempVLE1.MODIFY;
                    END ELSE BEGIN
                        IncrementInt_VD1 := INCSTR(IncrementInt_VD1);
                        Str_VD := tempVLE1."Duplicate Entry No. FND";

                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_VD1;
                        tempVLE1.MODIFY;
                    END;
                END;

                IF tempVLE1."Message to Recipient" = 'VA' THEN BEGIN
                    IF (IncrementInt_VA1 = tempVLE1."Duplicate Entry No. FND") OR (Str_VA = tempVLE1."Duplicate Entry No. FND") THEN BEGIN
                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_VA1;
                        tempVLE1.MODIFY;
                    END ELSE BEGIN
                        IncrementInt_VA1 := INCSTR(IncrementInt_VA1);
                        Str_VA := tempVLE1."Duplicate Entry No. FND";

                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_VA1;
                        tempVLE1.MODIFY;
                    END;
                END;

                IF tempVLE1."Message to Recipient" = 'VI' THEN BEGIN
                    IF (IncrementInt_VI1 = tempVLE1."Duplicate Entry No. FND") OR (Str_VI = tempVLE1."Duplicate Entry No. FND") THEN BEGIN
                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_VI1;
                        tempVLE1.MODIFY;
                    END ELSE BEGIN
                        IncrementInt_VI1 := INCSTR(IncrementInt_VI1);
                        Str_VI := tempVLE1."Duplicate Entry No. FND";

                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_VI1;
                        tempVLE1.MODIFY;
                    END;
                END;

                IF tempVLE1."Message to Recipient" = 'DI' THEN BEGIN
                    IF (IncrementInt_DI1 = tempVLE1."Duplicate Entry No. FND") OR (Str_DI = tempVLE1."Duplicate Entry No. FND") THEN BEGIN
                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_DI1;
                        tempVLE1.MODIFY;
                    END ELSE BEGIN
                        IncrementInt_DI1 := INCSTR(IncrementInt_DI1);
                        Str_DI := tempVLE1."Duplicate Entry No. FND";

                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_DI1;
                        tempVLE1.MODIFY;
                    END;
                END;

                IF tempVLE1."Message to Recipient" = 'DA' THEN BEGIN
                    IF (IncrementInt_DA1 = tempVLE1."Duplicate Entry No. FND") OR (Str_DA = tempVLE1."Duplicate Entry No. FND") THEN BEGIN
                        //InsertToTemptbl(tempVLE,Inc_DA)
                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_DA1;
                        tempVLE1.MODIFY;
                    END ELSE BEGIN
                        IncrementInt_DA1 := INCSTR(IncrementInt_DA1);
                        Str_DA := tempVLE1."Duplicate Entry No. FND";

                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_DA1;
                        tempVLE1.MODIFY;
                    END;
                END;

                IF tempVLE1."Message to Recipient" = 'IA' THEN BEGIN
                    IF (IncrementInt_IA1 = tempVLE1."Duplicate Entry No. FND") OR (Str_IA = tempVLE1."Duplicate Entry No. FND") THEN BEGIN
                        //InsertToTemptbl(tempVLE,Inc_DA)
                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_IA1;
                        tempVLE1.MODIFY;
                    END ELSE BEGIN
                        IncrementInt_IA1 := INCSTR(IncrementInt_IA1);
                        Str_IA := tempVLE1."Duplicate Entry No. FND";

                        tempVLE1."Duplicate Entry No. FND" := IncrementInt_IA1;
                        tempVLE1.MODIFY;
                    END;
                END;

            UNTIL tempVLE1.NEXT = 0;
        END;
    end;

    var
        Cnt1: Integer;
        VLE: Record "Vendor Ledger Entry";
        ParPostingDate: Date;
        Error01: Label 'Posting Date is Required to process data';
        Vend: Record Vendor;
        vendorname: Text[50];
        IncrementInt_VD: Text;
        IncrementInt_VI: Text;
        IncrementInt_VA: Text;
        IncrementInt_DI: Text;
        IncrementInt_DA: Text;
        IncrementInt_IA: Text;
        tempVLE: Record "Vendor Ledger Entry" temporary;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        EntryNo: Integer;
        tempVLE1: Record "Vendor Ledger Entry" temporary;
        IncrementInt_VD1: Text;
        IncrementInt_VI1: Text;
        IncrementInt_VA1: Text;
        IncrementInt_DI1: Text;
        IncrementInt_DA1: Text;
        IncrementInt_IA1: Text;
        Str_VD: Text;
        Str_VI: Text;
        Str_VA: Text;
        Str_DI: Text;
        Str_DA: Text;
        Str_IA: Text;
        ToDatePosting: Date;

    local procedure GlobalUpdateVLE(VendorLedgerEntry_L: Record "Vendor Ledger Entry");
    var
        IncrementInt: Integer;
    begin
        //Vendor / invoice date= VD
        Cnt1 := 0;
        VLE.RESET;
        VLE.SETCURRENTKEY("Vendor No.", "Document Date");
        VLE.SETRANGE("Vendor No.", VendorLedgerEntry_L."Vendor No.");
        VLE.SETRANGE("Document Date", VendorLedgerEntry_L."Document Date");
        VLE.SETRANGE("Document Type", VendorLedgerEntry_L."Document Type"::Invoice);
        //VLE.SETRANGE("Duplicate Entry No.",'');
        VLE.SETFILTER("Posting Date", '%1..%2', ParPostingDate, ToDatePosting);
        IF VLE.FINDSET THEN BEGIN
            Cnt1 := VLE.COUNT;
            REPEAT

                IF Cnt1 > 1 THEN BEGIN

                    VLE.CALCFIELDS(Amount);
                    tempVLE.INIT;
                    tempVLE."Entry No." := EntryNo;
                    tempVLE."Vendor No." := VLE."Vendor No.";
                    tempVLE."Document Date" := VLE."Document Date";
                    tempVLE."Posting Date" := VLE."Posting Date";
                    tempVLE."Document Type" := VLE."Document Type";
                    tempVLE."External Document No." := VLE."External Document No.";
                    tempVLE."Closed by Amount" := VLE.Amount;
                    tempVLE."Duplicate Entry No. FND" := IncrementInt_VD;
                    tempVLE."Closed by Entry No." := VLE."Entry No.";
                    tempVLE."Document No." := VLE."Document No.";
                    tempVLE."Message to Recipient" := 'VD';
                    tempVLE.INSERT;

                    EntryNo := EntryNo + 1;

                END;

            UNTIL VLE.NEXT = 0;


            IF Cnt1 > 1 THEN
                IncrementInt_VD := INCSTR(IncrementInt_VD);

        END;

        // Start Vendor / invoice amount = VA

        VendorLedgerEntry_L.CALCFIELDS(Amount);
        Cnt1 := 0;
        VLE.RESET;
        VLE.SETCURRENTKEY("Vendor No.", Amount);
        VLE.SETRANGE("Vendor No.", VendorLedgerEntry_L."Vendor No.");
        VLE.SETRANGE(Amount, VendorLedgerEntry_L.Amount);
        VLE.SETRANGE("Document Type", VendorLedgerEntry_L."Document Type"::Invoice);
        VLE.SETFILTER("Posting Date", '%1..%2', ParPostingDate, ToDatePosting);
        IF VLE.FINDSET THEN BEGIN
            Cnt1 := VLE.COUNT;
            REPEAT

                IF Cnt1 > 1 THEN BEGIN

                    VLE.CALCFIELDS(Amount);
                    tempVLE.INIT;
                    tempVLE."Entry No." := EntryNo;
                    tempVLE."Vendor No." := VLE."Vendor No.";
                    tempVLE."Document Date" := VLE."Document Date";
                    tempVLE."Posting Date" := VLE."Posting Date";
                    tempVLE."Document Type" := VLE."Document Type";
                    tempVLE."External Document No." := VLE."External Document No.";
                    tempVLE."Closed by Amount" := VLE.Amount;
                    tempVLE."Duplicate Entry No. FND" := IncrementInt_VA;
                    tempVLE."Closed by Entry No." := VLE."Entry No.";
                    tempVLE."Document No." := VLE."Document No.";
                    tempVLE."Message to Recipient" := 'VA';
                    tempVLE.INSERT;

                    EntryNo := EntryNo + 1;

                END;

            UNTIL VLE.NEXT = 0;

            IF Cnt1 > 1 THEN
                IncrementInt_VA := INCSTR(IncrementInt_VA);

        END;
        // End  Vendor / invoice amount = VA

        // Start  Vendor / invoice No.(Exter Doc No.) = VI
        Cnt1 := 0;
        VLE.RESET;
        VLE.SETRANGE("Vendor No.", VendorLedgerEntry_L."Vendor No.");
        VLE.SETRANGE("External Document No.", VendorLedgerEntry_L."External Document No.");
        VLE.SETRANGE("Document Type", VendorLedgerEntry_L."Document Type"::Invoice);
        VLE.SETFILTER("Posting Date", '%1..%2', ParPostingDate, ToDatePosting);
        IF VLE.FINDSET THEN BEGIN
            Cnt1 := VLE.COUNT;
            REPEAT

                IF Cnt1 > 1 THEN BEGIN

                    VLE.CALCFIELDS(Amount);
                    tempVLE.INIT;
                    tempVLE."Entry No." := EntryNo;
                    tempVLE."Vendor No." := VLE."Vendor No.";
                    tempVLE."Document Date" := VLE."Document Date";
                    tempVLE."Posting Date" := VLE."Posting Date";
                    tempVLE."Document Type" := VLE."Document Type";
                    tempVLE."External Document No." := VLE."External Document No.";
                    tempVLE."Closed by Amount" := VLE.Amount;
                    tempVLE."Duplicate Entry No. FND" := IncrementInt_VI;
                    tempVLE."Closed by Entry No." := VLE."Entry No.";
                    tempVLE."Document No." := VLE."Document No.";
                    tempVLE."Message to Recipient" := 'VI';
                    tempVLE.INSERT;

                    EntryNo := EntryNo + 1;

                END;

            UNTIL VLE.NEXT = 0;

            IF Cnt1 > 1 THEN
                IncrementInt_VI := INCSTR(IncrementInt_VI);

        END;

        // END  Vendor / invoice No.(Exter Doc No.) = VI

        // Start  Document Date / invoice No.(Exter Doc No.) = DI
        Cnt1 := 0;
        VLE.RESET;
        VLE.SETRANGE("Document Date", VendorLedgerEntry_L."Document Date");
        VLE.SETRANGE("External Document No.", VendorLedgerEntry_L."External Document No.");
        VLE.SETRANGE("Document Type", VendorLedgerEntry_L."Document Type"::Invoice);
        VLE.SETFILTER("Posting Date", '%1..%2', ParPostingDate, ToDatePosting);
        IF VLE.FINDSET THEN BEGIN
            Cnt1 := VLE.COUNT;
            REPEAT

                IF Cnt1 > 1 THEN BEGIN

                    VLE.CALCFIELDS(Amount);
                    tempVLE.INIT;
                    tempVLE."Entry No." := EntryNo;
                    tempVLE."Vendor No." := VLE."Vendor No.";
                    tempVLE."Document Date" := VLE."Document Date";
                    tempVLE."Posting Date" := VLE."Posting Date";
                    tempVLE."Document Type" := VLE."Document Type";
                    tempVLE."External Document No." := VLE."External Document No.";
                    tempVLE."Closed by Amount" := VLE.Amount;
                    tempVLE."Duplicate Entry No. FND" := IncrementInt_DI;
                    tempVLE."Closed by Entry No." := VLE."Entry No.";
                    tempVLE."Document No." := VLE."Document No.";
                    tempVLE."Message to Recipient" := 'DI';
                    tempVLE.INSERT;

                    EntryNo := EntryNo + 1;

                END;

            UNTIL VLE.NEXT = 0;

            IF Cnt1 > 1 THEN
                IncrementInt_DI := INCSTR(IncrementInt_DI);

        END;
        // END  Document Date / invoice No.(Exter Doc No.) = DI

        // Start  Document Date / invoice amount = DA
        VendorLedgerEntry_L.CALCFIELDS(Amount);
        Cnt1 := 0;
        VLE.RESET;
        //VLE.SETCURRENTKEY("Vendor No.",Amount);
        VLE.SETRANGE("Document Date", VendorLedgerEntry_L."Document Date");
        VLE.SETRANGE(Amount, VendorLedgerEntry_L.Amount);
        VLE.SETRANGE("Document Type", VendorLedgerEntry_L."Document Type"::Invoice);
        VLE.SETFILTER("Posting Date", '%1..%2', ParPostingDate, ToDatePosting);
        IF VLE.FINDSET THEN BEGIN
            Cnt1 := VLE.COUNT;
            REPEAT

                IF Cnt1 > 1 THEN BEGIN

                    VLE.CALCFIELDS(Amount);
                    tempVLE.INIT;
                    tempVLE."Entry No." := EntryNo;
                    tempVLE."Vendor No." := VLE."Vendor No.";
                    tempVLE."Document Date" := VLE."Document Date";
                    tempVLE."Posting Date" := VLE."Posting Date";
                    tempVLE."Document Type" := VLE."Document Type";
                    tempVLE."External Document No." := VLE."External Document No.";
                    tempVLE."Closed by Amount" := VLE.Amount;
                    tempVLE."Duplicate Entry No. FND" := IncrementInt_DA;
                    tempVLE."Closed by Entry No." := VLE."Entry No.";
                    tempVLE."Document No." := VLE."Document No.";
                    tempVLE."Message to Recipient" := 'DA';
                    tempVLE.INSERT;

                    EntryNo := EntryNo + 1;

                END;

            UNTIL VLE.NEXT = 0;

            IF Cnt1 > 1 THEN
                IncrementInt_DA := INCSTR(IncrementInt_DA);

        END;
        // END  Document Date / invoice amount = DA

        // Start  Invoice No.(External Doc No)/ invoice amount = IA
        VendorLedgerEntry_L.CALCFIELDS(Amount);
        Cnt1 := 0;
        VLE.RESET;
        //VLE.SETCURRENTKEY("Vendor No.",Amount);
        VLE.SETRANGE("External Document No.", VendorLedgerEntry_L."External Document No.");
        VLE.SETRANGE(Amount, VendorLedgerEntry_L.Amount);
        VLE.SETRANGE("Document Type", VendorLedgerEntry_L."Document Type"::Invoice);
        VLE.SETFILTER("Posting Date", '%1..%2', ParPostingDate, ToDatePosting);
        IF VLE.FINDSET THEN BEGIN
            Cnt1 := VLE.COUNT;
            REPEAT

                IF Cnt1 > 1 THEN BEGIN

                    VLE.CALCFIELDS(Amount);
                    tempVLE.INIT;
                    tempVLE."Entry No." := EntryNo;
                    tempVLE."Vendor No." := VLE."Vendor No.";
                    tempVLE."Document Date" := VLE."Document Date";
                    tempVLE."Posting Date" := VLE."Posting Date";
                    tempVLE."Document Type" := VLE."Document Type";
                    tempVLE."External Document No." := VLE."External Document No.";
                    tempVLE."Closed by Amount" := VLE.Amount;
                    tempVLE."Duplicate Entry No. FND" := IncrementInt_IA;
                    tempVLE."Closed by Entry No." := VLE."Entry No.";
                    tempVLE."Document No." := VLE."Document No.";
                    tempVLE."Message to Recipient" := 'IA';
                    tempVLE.INSERT;

                    EntryNo := EntryNo + 1;

                END;

            UNTIL VLE.NEXT = 0;

            IF Cnt1 > 1 THEN
                IncrementInt_IA := INCSTR(IncrementInt_IA);

        END;
        // END  Invoice No.(External Doc No)/ invoice amount = IA
    end;

    local procedure ClearDuplicateVendNo();
    var
        VLE_L: Record "Vendor Ledger Entry";
    begin
        /*VLE_L.RESET;
        IF VLE_L.FINDSET THEN BEGIN
          REPEAT
            VLE_L."Duplicate Entry No." :='';
            VLE_L.MODIFY;
            UNTIL VLE_L.NEXT =0;
        END;
        */
        VLE_L.RESET;
        IF VLE_L.FINDLAST THEN
            EntryNo := VLE_L."Entry No.";

        EntryNo := EntryNo + 2;

    end;

    local procedure InsertToTemptbl(tempVLE: Record "Vendor Ledger Entry");
    begin
        tempVLE1.INIT;
        tempVLE1."Entry No." := tempVLE."Entry No.";
        tempVLE1."Vendor No." := tempVLE."Vendor No.";
        tempVLE1."Document Date" := tempVLE."Document Date";
        tempVLE1."Posting Date" := tempVLE."Posting Date";
        tempVLE1."Document Type" := tempVLE."Document Type";
        tempVLE1."External Document No." := tempVLE."External Document No.";
        tempVLE1."Closed by Amount" := tempVLE."Closed by Amount";
        tempVLE1."Duplicate Entry No. FND" := tempVLE."Duplicate Entry No. FND";
        tempVLE1."Closed by Entry No." := tempVLE."Closed by Entry No.";
        tempVLE1."Document No." := tempVLE."Document No.";
        tempVLE1."Message to Recipient" := tempVLE."Message to Recipient";
        tempVLE1.INSERT;
    end;

    local procedure InitializeValues();
    begin
        IncrementInt_VD := 'VD01';
        IncrementInt_VA := 'VA01';
        IncrementInt_VI := 'VI01';
        IncrementInt_DI := 'DI01';
        IncrementInt_DA := 'DA01';
        IncrementInt_IA := 'IA01';

        IncrementInt_VD1 := 'VD01';
        IncrementInt_VA1 := 'VA01';
        IncrementInt_VI1 := 'VI01';
        IncrementInt_DI1 := 'DI01';
        IncrementInt_DA1 := 'DA01';
        IncrementInt_IA1 := 'IA01';
    end;
}

