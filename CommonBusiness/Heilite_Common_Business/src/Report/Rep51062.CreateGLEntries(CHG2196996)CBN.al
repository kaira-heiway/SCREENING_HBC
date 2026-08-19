report 51062 "CreateGLEntriesCHG2196996CBN"
{
    // version HEI.02

    // HEI.01 CHG2196996 IBM POENAB02 27.03.2023 Ethiopia - There is huge figure on foreign exchange Profit/Loss - Realized DP account (51307001).
    //   # Object created
    // HEI.02 CHG2215543 IBM POENAB02 12.10.2023 Reversal of Payment (Hotel Tivoli) - SELLCO SB MZN - PMT0003751.
    //   # Modified trigger "Detailed Vendor Ledg. Entry - OnAfterGetRecord" to increment the last Transaction No. used in GL Entry

    //BC Upgrade KAPOOV01 >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    //BC Upgrade KAPOOV01 <<

    Caption = 'Create GL Entries (CHG2196996)';
    Permissions = TableData "G/L Entry" = rimd,
                  TableData "Detailed Vendor Ledg. Entry" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry Type" = FILTER("Unrealized Loss" | "Unrealized Gain"), "Unapplied by Entry No." = FILTER(0));
            RequestFilterFields = "Entry No.";

            trigger OnAfterGetRecord();
            var
                lEntryNo: Integer;
                lDebitLineCanBeCreated: Boolean;
                lCreditLineCanBeCreated: Boolean;
                lGLEntry2: Record "G/L Entry";
            begin
                VendLedEntry.RESET();

                //HEI.02>>
                TransactionNo := 1;
                lGLEntry2.RESET();
                lGLEntry2.SETCURRENTKEY("Entry No.");
                if lGLEntry2.FINDLAST() then
                    TransactionNo := lGLEntry2."Transaction No." + 1;
                //HEI.02<<
                VendLedEntry.GET("Vendor Ledger Entry No.");
                //HEI.02>>
                VendLedEntry.CALCFIELDS("Remaining Amt. (LCY)", "Remaining Amount");
                //IF ((VendLedEntry."Remaining Amt. (LCY)" = 0) AND (VendLedEntry.Open = FALSE)) THEN
                if ((VendLedEntry."Remaining Amt. (LCY)" <> 0) and (VendLedEntry.Open = false) and (VendLedEntry."Remaining Amount" = 0) and (VendLedEntry.Reversed = false)) then
                //HEI.02<<
                  begin
                    DetVendLedEntry.RESET();
                    DetVendLedEntry_EntryNo := 1;
                    if DetVendLedEntry.FINDLAST() then
                        DetVendLedEntry_EntryNo := DetVendLedEntry."Entry No." + 1;

                    DetVendLedEntry.RESET();
                    DetVendLedEntry.INIT();
                    DetVendLedEntry.TRANSFERFIELDS("Detailed Vendor Ledg. Entry");
                    DetVendLedEntry."Entry No." := DetVendLedEntry_EntryNo;
                    //HEI.02>>
                    if (ReversalPostingDate <> 0D) then
                        DetVendLedEntry."Posting Date" := ReversalPostingDate;
                    //HEI.02<<
                    DetVendLedEntry."Amount (LCY)" := -"Amount (LCY)";
                    if ("Debit Amount (LCY)" <> 0) then begin
                        DetVendLedEntry."Credit Amount (LCY)" := DetVendLedEntry."Amount (LCY)";
                        DetVendLedEntry."Debit Amount (LCY)" := 0;
                    end;
                    if ("Credit Amount (LCY)" <> 0) then begin
                        DetVendLedEntry."Debit Amount (LCY)" := DetVendLedEntry."Amount (LCY)";
                        DetVendLedEntry."Credit Amount (LCY)" := 0;
                    end;
                    DetVendLedEntry."Unapplied by Entry No." := "Entry No.";
                    //HEI.02>>
                    DetVendLedEntry.Unapplied := true;
                    DetVendLedEntry."Transaction No." := TransactionNo;
                    DetVendLedEntry."User ID" := USERID;
                    //HEI.02<<
                    DetVendLedEntry.INSERT();
                    j += 1;


                    GLEntry.RESET();
                    GLEntry_EntryNo := 1;
                    if GLEntry.FINDLAST() then
                        GLEntry_EntryNo := GLEntry."Entry No." + 1;

                    GLEntry.RESET();
                    GLEntry.SETCURRENTKEY("CV Detailed Entry No. FND");
                    GLEntry.SETRANGE("CV Detailed Entry No. FND", "Detailed Vendor Ledg. Entry"."Entry No.");
                    if GLEntry.FINDSET(false) then
                        repeat
                            GLEntry2.RESET();
                            GLEntry2.TRANSFERFIELDS(GLEntry);
                            GLEntry2."Entry No." := GLEntry_EntryNo;
                            //HEI.02>>
                            if (ReversalPostingDate <> 0D) then
                                GLEntry2."Posting Date" := ReversalPostingDate;
                            //HEI.02<<
                            GLEntry2.Amount := -GLEntry.Amount;

                            GLEntry2."Debit Amount" := GLEntry."Credit Amount";
                            GLEntry2."Credit Amount" := GLEntry."Debit Amount";

                            GLEntry2."CV Detailed Entry No. FND" := DetVendLedEntry_EntryNo;
                            GLEntry2."Remaining Amount FND" := GLEntry2.Amount;
                            //HEI.02>>
                            GLEntry2."Transaction No." := TransactionNo;
                            GLEntry2."Creation Date FND" := TODAY;
                            GLEntry2."User ID" := USERID;
                            //HEI.02<<
                            GLEntry2.INSERT();
                            k += 1;
                            GLEntry_EntryNo += 1;
                        until GLEntry.NEXT() = 0;
                    //HEI.02>>
                    if not GLEntry.FINDFIRST() then
                        ERROR(Text50005, "Detailed Vendor Ledg. Entry"."Entry No.");
                    //HEI.02<<
                    Unapplied := true; //HEI.02
                    "Unapplied by Entry No." := DetVendLedEntry_EntryNo;
                    MODIFY();
                end;
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
        i := 0;
        j := 0;
        k := 0;
        CLEAR(ReversalPostingDate); //HEI.02
    end;

    trigger OnPostReport();
    begin
        DimSetEntryTmp.DELETEALL();

        MESSAGE(Text50002, j, k);
    end;

    trigger OnPreReport();
    begin
        GLSetup.GET();

        //HEI.02>>
        if ("Detailed Vendor Ledg. Entry".GETFILTERS = '') then
            ERROR(Text50006);
        //HEI.02<<
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
        Text50000: Label 'Adjmt. of %1 %2';
        GLDescription: Text[50];
        Text50001: Label '%1 GL Entries were created!';
        DetVendLedEntry: Record "Detailed Vendor Ledg. Entry";
        DetVendLedEntry_EntryNo: Integer;
        GLEntry_EntryNo: Integer;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        Text50002: Label '%1 Detailed Vend lines were created! %2 GL Entries were created!';
        j: Integer;
        k: Integer;
        TransactionNo: Integer;
        ReversalPostingDate: Date;
        Text50003: Label 'For Detailed Vend. Ledgr. Entry %1 GL Entries does not exists! Please run report "Create GL Entries (CHG2197067)"!';
        Text50004: Label 'You cannot add the report without filters!';
        Text50005: Label 'For Detailed Vend. Ledgr. Entry %1 GL Entries does not exists!';
        Text50006: Label 'You cannot run the report without Entry No.';
}

