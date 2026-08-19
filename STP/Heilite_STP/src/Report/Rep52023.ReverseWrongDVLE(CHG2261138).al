report 52023 "Reverse Wrong DVLE(CHG2261138)"
{
    // version HEI.01

    // HEI.01 CHG2261138 CC-INC5196086 MAJUMS03 03.09.2024 Vendor Ledger entry 14971423 to be unapplied.
    //   # Created New Report 50614 to create and rectify the Detailed Vendor Ledg. Entries which are not created during Reversal of Payment and Vendor
    //   Ledger Entry is also retified from Open = FALSE to Open = TRUE. This process will fix the Detailed Vendor Ledger Entry and Vendor Ledg. Entry
    //   to do the Payment against the Invoices which are affected due to improper Reversal of Payment. This report is based on Report 50401 (Create
    //   GL Entries (CHG2196996).

    //BC Upgrade KAPOOV01  >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    // 2. Old Report ID- 50614.
    //BC Upgrade KAPOOV01  <<

    Caption = 'Reverse Wrong DVLE(CHG2261138)';
    Permissions = TableData "G/L Entry" = rimd,
                  TableData "Vendor Ledger Entry" = rimd,
                  TableData "Detailed Vendor Ledg. Entry" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry Type" = FILTER(<> "Initial Entry"), "Unapplied by Entry No." = FILTER(0));
            RequestFilterFields = "Entry No.";

            trigger OnAfterGetRecord();
            var
                lEntryNo: Integer;
                lDebitLineCanBeCreated: Boolean;
                lCreditLineCanBeCreated: Boolean;
                lGLEntry2: Record "G/L Entry";
            begin
                //HEI.01>>
                VendLedEntry.RESET();
                VendLedEntry.GET("Vendor Ledger Entry No.");
                VendLedEntry.CALCFIELDS("Remaining Amt. (LCY)", "Remaining Amount");
                DetVendLedEntry.RESET();
                DetVendLedEntry_EntryNo := 1;
                if DetVendLedEntry.FINDLAST() then
                    DetVendLedEntry_EntryNo := DetVendLedEntry."Entry No." + 1;
                DetVendLedEntry.RESET();
                DetVendLedEntry.INIT();
                DetVendLedEntry.TRANSFERFIELDS("Detailed Vendor Ledg. Entry");
                DetVendLedEntry."Entry No." := DetVendLedEntry_EntryNo;
                if (ReversalPostingDate <> 0D) then
                    DetVendLedEntry."Posting Date" := ReversalPostingDate
                else
                    DetVendLedEntry."Posting Date" := "Detailed Vendor Ledg. Entry"."Posting Date";
                DetVendLedEntry."Amount (LCY)" := -"Amount (LCY)";
                DetVendLedEntry.Amount := -Amount;
                if ("Debit Amount (LCY)" <> 0) then begin
                    DetVendLedEntry."Credit Amount (LCY)" := DetVendLedEntry."Amount (LCY)";
                    DetVendLedEntry."Debit Amount (LCY)" := 0;
                end;
                if ("Credit Amount (LCY)" <> 0) then begin
                    DetVendLedEntry."Debit Amount (LCY)" := DetVendLedEntry."Amount (LCY)";
                    DetVendLedEntry."Credit Amount (LCY)" := 0;
                end;
                if ("Debit Amount" <> 0) then begin
                    DetVendLedEntry."Credit Amount" := DetVendLedEntry.Amount;
                    DetVendLedEntry."Debit Amount" := 0;
                end;
                if ("Credit Amount" <> 0) then begin
                    DetVendLedEntry."Debit Amount" := DetVendLedEntry.Amount;
                    DetVendLedEntry."Credit Amount" := 0;
                end;
                DetVendLedEntry."Unapplied by Entry No." := "Entry No.";
                DetVendLedEntry.Unapplied := true;
                DetVendLedEntry."User ID" := USERID;
                DetVendLedEntry.INSERT();
                j += 1;
                Unapplied := true;
                "Unapplied by Entry No." := DetVendLedEntry_EntryNo;
                MODIFY();
                VendLedEntry.GET("Vendor Ledger Entry No.");
                VendLedEntry.CALCFIELDS("Remaining Amt. (LCY)", "Remaining Amount");
                if ((VendLedEntry."Remaining Amount" <> 0) or (VendLedEntry."Remaining Amt. (LCY)" <> 0)) then begin
                    VendLedEntry.Open := true;
                    VendLedEntry.MODIFY();
                end;
                //HEI.01<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ReversalPostingDate; ReversalPostingDate)
                {
                    Caption = 'Reversal Posting Date';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    var
        lGLEntry: Record "G/L Entry";
    begin
        //HEI.01>>
        i := 0;
        j := 0;
        k := 0;
        CLEAR(ReversalPostingDate);
        //HEI.01<<
    end;

    trigger OnPostReport();
    begin
        //HEI.01>>
        DimSetEntryTmp.DELETEALL();
        if GUIALLOWED then
            MESSAGE(Text50001, j, k);
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        GLSetup.GET();
        if ("Detailed Vendor Ledg. Entry".GETFILTERS = '') then
            ERROR(Text50002);
        //HEI.01<<
    end;

    var
        GLEntry: Record "G/L Entry";
        i: Integer;
        GLEntry2: Record "G/L Entry";
        VendLedEntry: Record "Vendor Ledger Entry";
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
        DebitAccount: Code[20];
        CreditAccount: Code[20];
        Currency: Record Currency;
        VLE_DimSetID: Integer;
        DimSetEntryTmp: Record "Dimension Set Entry" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        GlobalDim1Code: Code[20];
        GlobalDim2Code: Code[20];
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        GLDescription: Text[50];
        DetVendLedEntry: Record "Detailed Vendor Ledg. Entry";
        DetVendLedEntry_EntryNo: Integer;
        GLEntry_EntryNo: Integer;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        Text50001: Label '%1 Detailed Vend lines were created! %2 GL Entries were created!';
        j: Integer;
        k: Integer;
        TransactionNo: Integer;
        ReversalPostingDate: Date;
        Text50002: Label 'You cannot run the report without Entry No.';
}

