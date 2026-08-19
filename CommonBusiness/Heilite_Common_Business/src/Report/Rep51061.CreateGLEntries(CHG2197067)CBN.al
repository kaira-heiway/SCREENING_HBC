report 51061 "Create GL EntriesCH2197067 CBN"
{
    // version HEI.01

    // HEI.01 CHG2197067 IBM POENAB02 16.03.2023 There's variance with the GL (14501001) and SL revaluation (0030000627) during September Fx revaluation for document noPR-000570
    //   # Object created

    //BC Upgrade KAPOOV01 >>
    // 1. Add ApplicationArea and UsageCategory property in Report.
    //BC Upgrade KAPOOV01 <<

    Caption = 'Create GL Entries (CHG2197067)';
    Permissions = TableData "G/L Entry" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry Type" = FILTER("Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain"));
            RequestFilterFields = "Entry No.", "Posting Date";

            trigger OnAfterGetRecord();
            var
                lEntryNo: Integer;
                lDebitLineCanBeCreated: Boolean;
                lCreditLineCanBeCreated: Boolean;
            begin
                VLE_DimSetID := 0;
                GLDescription := '';

                GLEntry.RESET();
                GLEntry.SETCURRENTKEY("CV Detailed Entry No. FND");
                GLEntry.SETRANGE("CV Detailed Entry No. FND", "Entry No.");
                if not GLEntry.FINDFIRST() then begin
                    GLEntry2.RESET();
                    lEntryNo := 1;
                    if GLEntry2.FINDLAST() then
                        lEntryNo := GLEntry2."Entry No." + 1;

                    lDebitLineCanBeCreated := false;
                    lCreditLineCanBeCreated := false;
                    if VendorLedgerEntry.GET("Vendor Ledger Entry No.") then begin
                        VLE_DimSetID := VendorLedgerEntry."Dimension Set ID";
                        VendorLedgerEntry.CALCFIELDS(Amount);
                        GLDescription := COPYSTR(STRSUBSTNO(Text50000, VendorLedgerEntry."Currency Code", FORMAT(VendorLedgerEntry.Amount)), 1, 50);
                        if Vendor.GET(VendorLedgerEntry."Vendor No.") then
                            if VendorPostingGroup.GET(Vendor."Vendor Posting Group") then
                                if VendorPostingGroup."Payables Account" <> '' then begin
                                    lDebitLineCanBeCreated := true;
                                    DebitAccount := VendorPostingGroup."Payables Account";
                                end;

                        if VendorLedgerEntry."Currency Code" <> '' then begin
                            if Currency.GET(VendorLedgerEntry."Currency Code") then begin
                                case "Entry Type" of
                                    "Entry Type"::"Unrealized Loss":
                                        begin
                                            if (Currency."Unrealized Losses Acc." <> '') then begin
                                                lCreditLineCanBeCreated := true;
                                                CreditAccount := Currency."Unrealized Losses Acc.";
                                            end;
                                        end;
                                    "Entry Type"::"Unrealized Gain":
                                        begin
                                            if (Currency."Unrealized Gains Acc." <> '') then begin
                                                lCreditLineCanBeCreated := true;
                                                CreditAccount := Currency."Unrealized Gains Acc.";
                                            end;
                                        end;
                                    "Entry Type"::"Realized Loss":
                                        begin
                                            if (Currency."Realized Losses Acc." <> '') then begin
                                                lCreditLineCanBeCreated := true;
                                                CreditAccount := Currency."Realized Losses Acc.";
                                            end;
                                        end;
                                    "Entry Type"::"Realized Gain":
                                        begin
                                            if (Currency."Realized Gains Acc." <> '') then begin
                                                lCreditLineCanBeCreated := true;
                                                CreditAccount := Currency."Realized Gains Acc.";
                                            end;
                                        end;
                                end;
                            end;
                        end
                        else begin
                            if Currency.GET(GLSetup."LCY Code") then begin
                                case "Entry Type" of
                                    "Entry Type"::"Unrealized Loss":
                                        begin
                                            if (Currency."Unrealized Losses Acc." <> '') then begin
                                                lCreditLineCanBeCreated := true;
                                                CreditAccount := Currency."Unrealized Losses Acc.";
                                            end;
                                        end;
                                    "Entry Type"::"Unrealized Gain":
                                        begin
                                            if (Currency."Unrealized Gains Acc." <> '') then begin
                                                lCreditLineCanBeCreated := true;
                                                CreditAccount := Currency."Unrealized Gains Acc.";
                                            end;
                                        end;
                                    "Entry Type"::"Realized Loss":
                                        begin
                                            if (Currency."Realized Losses Acc." <> '') then begin
                                                lCreditLineCanBeCreated := true;
                                                CreditAccount := Currency."Realized Losses Acc.";
                                            end;
                                        end;
                                    "Entry Type"::"Realized Gain":
                                        begin
                                            if (Currency."Realized Gains Acc." <> '') then begin
                                                lCreditLineCanBeCreated := true;
                                                CreditAccount := Currency."Realized Gains Acc.";
                                            end;
                                        end;
                                end;
                            end;
                        end;
                    end;

                    if (lCreditLineCanBeCreated and lDebitLineCanBeCreated) then
                        CreateGLEntries("Entry No.", DebitAccount, CreditAccount, VLE_DimSetID, GLDescription);
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
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
    end;

    trigger OnPostReport();
    begin
        DimSetEntryTmp.DELETEALL();

        MESSAGE(Text50001, i);
    end;

    trigger OnPreReport();
    begin
        GLSetup.GET();
    end;

    var
        GLEntry: Record "G/L Entry";
        i: Integer;
        GLEntry2: Record "G/L Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
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

    local procedure CreateGLEntries(DVLEEntryNo: Integer; DebitAcc: Code[20]; CreditAcc: Code[20]; DimSetID: Integer; GLDesc: Text[50]);
    var
        LDVLE: Record "Detailed Vendor Ledg. Entry";
        LGLAcc: Record "G/L Account";
        LGLEntry: Record "G/L Entry";
        LEntryNo: Integer;
        AddCCC: Boolean;
    begin
        LDVLE.GET(DVLEEntryNo);
        LGLEntry.RESET();

        GlobalDim1Code := '';
        GlobalDim2Code := '';

        LEntryNo := 1;
        if LGLEntry.FINDLAST() then
            LEntryNo := LGLEntry."Entry No." + 1;

        AddCCC := true;
        DimSetEntryTmp.DELETEALL();
        DimSetEntry.RESET();
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        if DimSetEntry.FINDSET() then
            repeat
                DimSetEntryTmp.TRANSFERFIELDS(DimSetEntry);
                DimSetEntryTmp.INSERT(true);
                if (DimSetEntry."Dimension Code" = GLSetup."Global Dimension 1 Code") then
                    GlobalDim1Code := DimSetEntry."Dimension Value Code";
                if (DimSetEntry."Dimension Code" = GLSetup."Global Dimension 2 Code") then begin
                    GlobalDim2Code := DimSetEntry."Dimension Value Code";
                    AddCCC := false;
                end;
            until DimSetEntry.NEXT() = 0;

        if (AddCCC = true) then begin
            DimSetEntryTmp.VALIDATE("Dimension Code", GLSetup."Global Dimension 2 Code");
            DimSetEntryTmp.VALIDATE("Dimension Value Code", '40110001');
            DimSetEntryTmp.INSERT(true);
        end;

        LGLEntry.RESET();
        LGLEntry."Entry No." := LEntryNo;
        LGLEntry."Document Type" := LGLEntry."Document Type"::" ";
        LGLEntry."G/L Account No." := DebitAcc;
        LGLEntry."Posting Date" := LDVLE."Posting Date";
        LGLEntry."Document No." := LDVLE."Document No.";
        LGLEntry.Description := GLDesc;
        LGLEntry.Amount := LDVLE."Amount (LCY)";
        LGLEntry."Global Dimension 1 Code" := GlobalDim1Code;
        LGLEntry."Global Dimension 2 Code" := GlobalDim2Code;
        LGLEntry."User ID" := LDVLE."User ID";
        LGLEntry."Source Code" := LDVLE."Source Code";
        LGLEntry."System-Created Entry" := true;
        LGLEntry."Transaction No." := LDVLE."Transaction No.";
        LGLEntry."Debit Amount" := LDVLE."Amount (LCY)";
        LGLEntry."Document Date" := LDVLE."Posting Date";
        LGLEntry."Dimension Set ID" := DimSetID;
        LGLEntry."CV Detailed Entry No. FND" := LDVLE."Entry No.";
        LGLEntry."Open FND" := true;
        LGLEntry."Remaining Amount FND" := LDVLE."Amount (LCY)";
        LGLEntry."Creation Date FND" := LDVLE."Posting Date";
        ;
        LGLEntry."Source Type" := LGLEntry."Source Type"::" ";
        LGLEntry."Source No." := '';
        LGLEntry."No. Series" := '';
        LGLEntry."External Document No." := '';
        LGLEntry."Debit Amount" := 0;
        LGLEntry."Credit Amount" := -LDVLE."Amount (LCY)";
        LGLEntry.INSERT();
        i += 1;

        LEntryNo += 1;
        LGLEntry.RESET();
        LGLEntry."Entry No." := LEntryNo;
        LGLEntry."Document Type" := LGLEntry."Document Type"::" ";
        LGLEntry."G/L Account No." := CreditAcc;
        LGLEntry."Posting Date" := LDVLE."Posting Date";
        LGLEntry."Document No." := LDVLE."Document No.";
        LGLEntry.Description := GLDesc;
        LGLEntry.Amount := -LDVLE."Amount (LCY)";
        LGLEntry."Global Dimension 1 Code" := GlobalDim1Code;
        LGLEntry."Global Dimension 2 Code" := GlobalDim2Code;
        LGLEntry."User ID" := LDVLE."User ID";
        LGLEntry."Source Code" := LDVLE."Source Code";
        LGLEntry."System-Created Entry" := true;
        LGLEntry."Transaction No." := LDVLE."Transaction No.";
        LGLEntry."Credit Amount" := -LDVLE."Amount (LCY)";
        LGLEntry."Document Date" := LDVLE."Posting Date";
        LGLEntry."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
        LGLEntry."CV Detailed Entry No. FND" := LDVLE."Entry No.";
        LGLEntry."Open FND" := true;
        LGLEntry."Remaining Amount FND" := -LDVLE."Amount (LCY)";
        LGLEntry."Creation Date FND" := LDVLE."Posting Date";
        LGLEntry."Source Type" := LGLEntry."Source Type"::" ";
        LGLEntry."Source No." := '';
        LGLEntry."No. Series" := '';
        LGLEntry."External Document No." := '';
        LGLEntry."Credit Amount" := 0;
        LGLEntry."Debit Amount" := -LDVLE."Amount (LCY)";
        LGLEntry.INSERT();
        i += 1;
    end;
}

