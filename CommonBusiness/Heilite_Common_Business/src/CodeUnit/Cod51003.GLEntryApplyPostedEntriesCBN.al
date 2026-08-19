codeunit 51003 "GLEntry Apply Posted Entr. CBN"
{
    // version HEI.04

    // HEI:EDD025:1:1 25/09/14 TECTURA.HKH
    //  # G/L Entry Application
    // HEI:EDD564:1:1 01/10/2016 SBS
    // # Automatic Set Applay to ID
    // 
    // HEI:CHG0147132:1:1 09/11/16 IBM
    //   # FDD-HNK-Auto Clear HNK 10/10/16
    //     : Created new functions, listed below:
    //       SetApplyIDWithPremaymentSalesInvoice
    //       SetApplyIDWithPremaymentPurchaseInvoice
    //       SetApplyIDCustomerEntry
    //       SetApplyIDVendorEntry
    //       SetApplyIDWithGR/IRAccountsPayable
    //       SetApplyIDWithGR/IRAccountsReceiveble
    //       SetApplyIDWithSepcialCriteria
    //       GetSalesOrderNo
    //       GetPurchaseOrderNo
    //       GetPreSalesOrderNo
    //       GetPrePurchaseOrderNo
    //       GetDocumentNoCust
    //       GetCustLedEntrySens
    //       GetDocumentNoVend
    //       GetVendLedEntrySens
    // HEI.01 Defect #747 IBM NASTAA02 20.12.2017 # HeiMatch Export Inv. & Balance
    //   # Replaced field "Remaining Amount." with "Remaining Amount"
    // HEI.02 CHG2065276 BULIMC01 IBM 30.09.2020 #new parameter added to the function "SetApplyIDWithSepcialCriteria" - "BComment"
    // HEI.03 CHG2182507 IBM POENAB02 22.11.2022 HB3254 RPA - Application of GL entries with same comment
    //   # Modified function SetApplyIDWithSepcialCriteria
    // HEI.04 CHG2208499 - HB1699 IBM SRIVAS07 03.07.2023 - Enhancement to HB1057 to include FA
    //   # Create new function - SetApplyIDWithGRIRAccountsPayableFA()

    // BC UPGRADE SHIKHD02 >> 
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in procedure Undo(var GLEntry: Record "G/L Entry")
    // BC UPGRADE SHIKHD02 <<



    trigger OnRun();
    begin
    end;

    var
        GLAcc: Record "G/L Account";
        EndpointGLEntry: Record "G/L Entry";
        OldGLEntry: Record "G/L Entry";
        OriginalGLEntry: Record "G/L Entry";
        GLEntryApplID: Code[50];
        AppliedAmount: Decimal;
        TotalAppliedAmount: Decimal;
        TXT50000: Label 'At last one criteria should be selected !';

    procedure Apply(var GLEntry: Record "G/L Entry");
    begin
        OldGLEntry.RESET();

        if GLEntry."Applies-to ID FND" <> '' then begin
            OldGLEntry.SETCURRENTKEY("Applies-to ID FND");
            OldGLEntry.SETRANGE("Applies-to ID FND", GLEntry."Applies-to ID FND");
            OldGLEntry.SETFILTER("Entry No.", '<> %1', GLEntry."Entry No.");
            if OldGLEntry.FIND('-') then begin
                repeat
                    OldGLEntry.TESTFIELD("G/L Account No.", GLEntry."G/L Account No.");
                    OldGLEntry.TESTFIELD("Open FND", true);

                    AppliedAmount := -OldGLEntry."Remaining Amount FND";
                    TotalAppliedAmount := TotalAppliedAmount + AppliedAmount;

                    OldGLEntry."Remaining Amount FND" := 0;
                    OldGLEntry."Open FND" := false;
                    OldGLEntry."Closed by Entry No. FND" := GLEntry."Entry No.";
                    OldGLEntry."Closed at Date FND" := GLEntry."Posting Date";
                    OldGLEntry."Closed by Amount FND" := -AppliedAmount;
                    OldGLEntry."Applies-to ID FND" := '';
                    OldGLEntry.MODIFY();
                until OldGLEntry.NEXT() = 0;
            end else
                exit;
        end;

        GLEntry."Remaining Amount FND" := GLEntry."Remaining Amount FND" - TotalAppliedAmount;
        GLEntry."Open FND":= GLEntry."Remaining Amount FND" <> 0;

        GLEntry.MODIFY();
    end;

    procedure Undo(var GLEntry: Record "G/L Entry");
    begin
        // BC UPGRADE SHIKHD02 >> 
        // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases
        // with GLEntry do begin
        //     RESET();

        //     OriginalGLEntry := GLEntry;

        //     if OriginalGLEntry."Closed by Entry No." <> 0 then begin
        //         EndpointGLEntry.GET(OriginalGLEntry."Closed by Entry No.");
        //         EndpointGLEntry.TESTFIELD("Closed by Entry No.", 0);
        //     end else
        //         EndpointGLEntry := GLEntry;


        //     SETCURRENTKEY("Closed by Entry No.");
        //     SETRANGE("Closed by Entry No.", EndpointGLEntry."Entry No.");
        //     if FIND('-') then
        //         repeat
        //             Open := true;
        //             "Remaining Amount" := "Closed by Amount";
        //             "Closed by Entry No." := 0;
        //             "Closed at Date" := 0D;
        //             "Closed by Amount" := 0;
        //             MODIFY();
        //         until NEXT() = 0;

        //     EndpointGLEntry.Open := true;
        //     EndpointGLEntry."Remaining Amount" := EndpointGLEntry.Amount;
        //     EndpointGLEntry."Closed by Entry No." := 0;
        //     EndpointGLEntry."Closed at Date" := 0D;
        //     EndpointGLEntry."Closed by Amount" := 0;
        //     EndpointGLEntry.MODIFY();

        //     SETCURRENTKEY("Entry No.");
        //     SETRANGE("Closed by Entry No.");
        //     SETRANGE("G/L Account No.", OriginalGLEntry."G/L Account No.");
        // end;
        GLEntry.RESET();

        OriginalGLEntry := GLEntry;

        if OriginalGLEntry."Closed by Entry No. FND" <> 0 then begin
            EndpointGLEntry.GET(OriginalGLEntry."Closed by Entry No. FND");
            EndpointGLEntry.TESTFIELD("Closed by Entry No. FND", 0);
        end else
            EndpointGLEntry := GLEntry;


        GLEntry.SETCURRENTKEY("Closed by Entry No. FND");
        GLEntry.SETRANGE("Closed by Entry No. FND", EndpointGLEntry."Entry No.");
        if GLEntry.FIND('-') then
            repeat
                GLEntry."Open FND" := true;
                GLEntry."Remaining Amount FND" := GLEntry."Closed by Amount FND";
                GLEntry."Closed by Entry No. FND" := 0;
                GLEntry."Closed at Date FND" := 0D;
                GLEntry."Closed by Amount FND" := 0;
                GLEntry.MODIFY();
            until GLEntry.NEXT() = 0;

        EndpointGLEntry."Open FND" := true;
        EndpointGLEntry."Remaining Amount FND" := EndpointGLEntry.Amount;
        EndpointGLEntry."Closed by Entry No. FND" := 0;
        EndpointGLEntry."Closed at Date FND" := 0D;
        EndpointGLEntry."Closed by Amount FND" := 0;
        EndpointGLEntry.MODIFY();

        GLEntry.SETCURRENTKEY("Entry No.");
        GLEntry.SETRANGE("Closed by Entry No. FND");
        GLEntry.SETRANGE("G/L Account No.", OriginalGLEntry."G/L Account No.");
        // BC UPGRADE SHIKHD02 <<
    end;

    procedure SetApplId(var GLEntry: Record "G/L Entry");
    begin
        GLEntry.LOCKTABLE();
        GLEntry.TESTFIELD("Open FND", true);
        if GLEntry.FIND('-') then begin
            // Make Applies-to ID
            if GLEntry."Applies-to ID FND" <> '' then
                GLEntryApplID := ''
            else begin
                GLEntryApplID := USERID;
                if GLEntryApplID = '' then
                    GLEntryApplID := '***';
            end;

            // Set Applies-to ID
            repeat
                GLEntry.TESTFIELD("Open FND", true);
                GLEntry."Applies-to ID FND" := GLEntryApplID;
                GLEntry.MODIFY();
            until GLEntry.NEXT() = 0;

        end;
    end;

    procedure SetApplyIDWithPremaymentSalesInvoice(var GLEntryApplicationBuffer: Record "G/L Entry Application Bffr FND" temporary);
    var
        GLEntryToApply: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToModify: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryFinded: Boolean;
        PositiveAmount: Boolean;
        SalesOrderNo: Code[20];
        NoSeqApplyToID: Integer;
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        NoSeqApplyToID := 0;
        GLEntryApplicationBuffer.SETCURRENTKEY("Applies-to ID");
        GLEntryApplicationBuffer.SETFILTER("Applies-to ID", '''''');
        GLEntryApplicationBuffer.SETRANGE("Document Type", GLEntryApplicationBuffer."Document Type"::Invoice);
        GLEntryApplicationBuffer.SETRANGE(Positive, true);

        if GLEntryApplicationBuffer.FINDFIRST() then begin

            repeat
                //<<FDD-HNK-Auto Clear HNK 25/10/16 1.1
                SalesOrderNo := GetSalesOrderNo(GLEntryApplicationBuffer."Document No.");
                //<<FDD-HNK-Auto Clear HNK 25/10/16 1.1
                if GLEntryApplicationBuffer."Applies-to ID" = '' then begin
                    NoSeqApplyToID += 1;
                    GLEntryToApply.COPY(GLEntryApplicationBuffer, true);
                    GLEntryToApply.SETRANGE(Positive, false);
                    GLEntryToApply.SETFILTER("Entry No.", '<>%1', GLEntryApplicationBuffer."Entry No.");
                    GLEntryToApply.SETRANGE("Document Type", GLEntryToApply."Document Type"::Invoice);
                    if GLEntryToApply.findset() then
                        repeat
                            if SalesOrderNo = GetPreSalesOrderNo(GLEntryToApply."Document No.") then begin

                                GLEntryToModify.COPY(GLEntryApplicationBuffer, true);
                                GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                                GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                GLEntryToModify.MODIFY();

                                GLEntryToApply."Applies-to ID" := FORMAT(GLEntryApplicationBuffer."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                GLEntryToApply.MODIFY();
                            end;
                        until GLEntryToApply.NEXT() = 0;
                end;
            until GLEntryApplicationBuffer.NEXT() = 0;
        end;
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    procedure SetApplyIDWithPremaymentPurchaseInvoice(var GLEntryApplicationBuffer: Record "G/L Entry Application Bffr FND" temporary);
    var
        GLEntryToApply: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToApplyToModify: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToModify: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryFinded: Boolean;
        PositiveAmount: Boolean;
        PurchaseOrderNo: Code[20];
        NoSeqApplyToID: Integer;
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        NoSeqApplyToID := 0;
        GLEntryApplicationBuffer.SETCURRENTKEY("Applies-to ID");
        GLEntryApplicationBuffer.SETFILTER("Applies-to ID", '''''');
        GLEntryApplicationBuffer.SETRANGE("Document Type", GLEntryApplicationBuffer."Document Type"::Invoice);
        GLEntryApplicationBuffer.SETRANGE(Positive, false);
        if GLEntryApplicationBuffer.FINDFIRST() then begin

            repeat
                //<<FDD-HNK-Auto Clear HNK 25/10/16 1.1
                PurchaseOrderNo := GetPurchaseOrderNo(GLEntryApplicationBuffer."Document No.");
                //<<FDD-HNK-Auto Clear HNK 25/10/16 1.1
                if GLEntryApplicationBuffer."Applies-to ID" = '' then begin
                    NoSeqApplyToID += 1;
                    GLEntryToApply.COPY(GLEntryApplicationBuffer, true);
                    GLEntryToApply.SETRANGE(Positive, true);
                    GLEntryToApply.SETFILTER("Entry No.", '<>%1', GLEntryApplicationBuffer."Entry No.");
                    GLEntryToApply.SETRANGE("Document Type", GLEntryToApply."Document Type"::Invoice);
                    if GLEntryToApply.findset() then
                        repeat
                            if PurchaseOrderNo = GetPrePurchaseOrderNo(GLEntryToApply."Document No.") then begin
                                GLEntryToModify.COPY(GLEntryApplicationBuffer, true);
                                GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                                GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                GLEntryToModify.MODIFY();
                                GLEntryToApply."Applies-to ID" := FORMAT(GLEntryApplicationBuffer."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                GLEntryToApply.MODIFY();
                            end;
                        until GLEntryToApply.NEXT() = 0;
                end;
            until GLEntryApplicationBuffer.NEXT() = 0;
        end;
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    procedure SetApplyIDCustomerEntry(var GLEntryApplicationBuffer: Record "G/L Entry Application Bffr FND" temporary);
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        DetailedCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        GLEntryToApply: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToModify: Record "G/L Entry Application Bffr FND" temporary;
        FoundOnce: Boolean;
        GLEntryFinded: Boolean;
        NoSeqApplyToID: Integer;
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        NoSeqApplyToID := 0;
        GLEntryApplicationBuffer.SETCURRENTKEY("Applies-to ID");
        GLEntryApplicationBuffer.SETFILTER("Applies-to ID", '''''');
        if GLEntryApplicationBuffer.FINDFIRST() then
            repeat
                if GLEntryApplicationBuffer."Applies-to ID" = '' then begin
                    CustLedgerEntry.RESET();
                    CustLedgerEntry.SETCURRENTKEY("Document No.");
                    CustLedgerEntry.SETRANGE("Document No.", GLEntryApplicationBuffer."Document No.");
                    CustLedgerEntry.SETRANGE(Positive, GLEntryApplicationBuffer.Positive);
                    if CustLedgerEntry.FINDFIRST() then begin
                        CustLedgerEntry.CALCFIELDS("Remaining Amount", Amount);
                        if CustLedgerEntry."Remaining Amount" <> CustLedgerEntry.Amount then begin
                            DetailedCustLedgEntry2.RESET();
                            DetailedCustLedgEntry2.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            DetailedCustLedgEntry2.SETRANGE("Entry Type", DetailedCustLedgEntry2."Entry Type"::Application);
                            DetailedCustLedgEntry2.SETRANGE(Unapplied, false);
                            DetailedCustLedgEntry2.SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                            //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                            DetailedCustLedgEntry2.SETRANGE("Customer No.", CustLedgerEntry."Customer No.");
                            //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2

                            if DetailedCustLedgEntry2.findset() then begin
                                NoSeqApplyToID += 1;
                                repeat
                                    //<<FDD-HNK-Auto Clear HNK 24/10/16 1.1
                                    FoundOnce := false;
                                    //<<FDD-HNK-Auto Clear HNK 24/10/16 1.1
                                    DetailedCustLedgEntry.RESET();
                                    DetailedCustLedgEntry.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
                                    DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
                                    DetailedCustLedgEntry.SETRANGE(Unapplied, false);
                                    DetailedCustLedgEntry.SETRANGE("Transaction No.", DetailedCustLedgEntry2."Transaction No.");
                                    DetailedCustLedgEntry.SETFILTER("Cust. Ledger Entry No.", '<>%1', CustLedgerEntry."Entry No.");
                                    //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                    DetailedCustLedgEntry.SETRANGE("Customer No.", CustLedgerEntry."Customer No.");
                                    //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                    if DetailedCustLedgEntry.findset() then begin
                                        repeat
                                            GLEntryToApply.COPY(GLEntryApplicationBuffer, true);
                                            GLEntryToApply.SETFILTER("Entry No.", '<>%1', GLEntryApplicationBuffer."Entry No.");
                                            GLEntryToApply.SETRANGE("Document No.", GetDocumentNoCust(DetailedCustLedgEntry."Cust. Ledger Entry No."));
                                            GLEntryToApply.SETRANGE(Positive, GetCustLedEntrySens(DetailedCustLedgEntry."Cust. Ledger Entry No."));
                                            GLEntryToApply.SETFILTER("Applies-to ID", '''''');
                                            if GLEntryToApply.findset() then begin
                                                //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                                GLEntryToApply.MODIFYALL("Applies-to ID", FORMAT(GLEntryToApply."Source No.") + '-' + FORMAT(NoSeqApplyToID));
                                                //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                                //<<FDD-HNK-Auto Clear HNK 24/10/16 1.1
                                                FoundOnce := true;
                                            end;
                                        //<<FDD-HNK-Auto Clear HNK 24/10/16 1.1
                                        until DetailedCustLedgEntry.NEXT() = 0;
                                        //<<FDD-HNK-Auto Clear HNK 24/10/16 1.1
                                        if FoundOnce then begin
                                            //<<FDD-HNK-Auto Clear HNK 24/10/16 1.1
                                            GLEntryToModify.COPY(GLEntryApplicationBuffer, true);
                                            GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                                            //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                            GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."Source No.") + '-' + FORMAT(NoSeqApplyToID);
                                            //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                            GLEntryToModify.MODIFY();
                                            //<<FDD-HNK-Auto Clear HNK 24/10/16 1.1
                                        end;
                                        //<<FDD-HNK-Auto Clear HNK 24/10/16 1.1

                                    end;
                                until DetailedCustLedgEntry2.NEXT() = 0;
                            end;
                        end;
                    end;
                end;
            until GLEntryApplicationBuffer.NEXT() = 0;
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    procedure SetApplyIDVendorEntry(var GLEntryApplicationBuffer: Record "G/L Entry Application Bffr FND" temporary);
    var
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        DetailedVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        GLEntryToApply: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToModify: Record "G/L Entry Application Bffr FND" temporary;
        VendLedgerEntry: Record "Vendor Ledger Entry";
        FoundOnce: Boolean;
        GLEntryFinded: Boolean;
        NoSeqApplyToID: Integer;
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        NoSeqApplyToID := 0;
        GLEntryApplicationBuffer.SETCURRENTKEY("Applies-to ID");
        GLEntryApplicationBuffer.SETFILTER("Applies-to ID", '''''');
        if GLEntryApplicationBuffer.FINDFIRST() then
            repeat
                if GLEntryApplicationBuffer."Applies-to ID" = '' then begin
                    VendLedgerEntry.RESET();
                    VendLedgerEntry.SETCURRENTKEY("Document No.");
                    VendLedgerEntry.SETRANGE("Document No.", GLEntryApplicationBuffer."Document No.");
                    VendLedgerEntry.SETRANGE(Positive, GLEntryApplicationBuffer.Positive);
                    if VendLedgerEntry.FINDFIRST() then begin
                        VendLedgerEntry.CALCFIELDS("Remaining Amount", Amount);
                        if VendLedgerEntry."Remaining Amount" <> VendLedgerEntry.Amount then begin
                            DetailedVendLedgEntry2.RESET();
                            DetailedVendLedgEntry2.SETCURRENTKEY("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                            DetailedVendLedgEntry2.SETRANGE("Entry Type", DetailedVendLedgEntry2."Entry Type"::Application);
                            DetailedVendLedgEntry2.SETRANGE(Unapplied, false);
                            DetailedVendLedgEntry2.SETRANGE("Vendor Ledger Entry No.", VendLedgerEntry."Entry No.");
                            //<<FDD-HNK-Auto Clear HNK 10/10/16 1,2
                            DetailedVendLedgEntry2.SETRANGE("Vendor No.", VendLedgerEntry."Vendor No.");
                            //<<FDD-HNK-Auto Clear HNK 10/10/16 1,2
                            if DetailedVendLedgEntry2.findset() then begin
                                NoSeqApplyToID += 1;
                                repeat
                                    //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1
                                    FoundOnce := false;
                                    //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1
                                    DetailedVendLedgEntry.RESET();
                                    DetailedVendLedgEntry.SETCURRENTKEY("Applied Vend. Ledger Entry No.", "Entry Type");
                                    DetailedVendLedgEntry.SETRANGE("Entry Type", DetailedVendLedgEntry."Entry Type"::Application);
                                    DetailedVendLedgEntry.SETRANGE(Unapplied, false);
                                    DetailedVendLedgEntry.SETRANGE("Transaction No.", DetailedVendLedgEntry2."Transaction No.");
                                    DetailedVendLedgEntry.SETFILTER("Vendor Ledger Entry No.", '<>%1', VendLedgerEntry."Entry No.");
                                    //<<FDD-HNK-Auto Clear HNK 10/10/16 1,2
                                    DetailedVendLedgEntry.SETRANGE("Vendor No.", VendLedgerEntry."Vendor No.");
                                    //<<FDD-HNK-Auto Clear HNK 10/10/16 1,2

                                    if DetailedVendLedgEntry.findset() then begin
                                        repeat
                                            GLEntryToApply.COPY(GLEntryApplicationBuffer, true);
                                            GLEntryToApply.SETFILTER("Entry No.", '<>%1', GLEntryApplicationBuffer."Entry No.");
                                            GLEntryToApply.SETRANGE("Document No.", GetDocumentNoVend(DetailedVendLedgEntry."Vendor Ledger Entry No."));
                                            GLEntryToApply.SETRANGE(Positive, GetVendLedEntrySens(DetailedVendLedgEntry."Vendor Ledger Entry No."));
                                            GLEntryToApply.SETFILTER("Applies-to ID", '''''');
                                            if GLEntryToApply.findset() then begin
                                                //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                                GLEntryToApply.MODIFYALL("Applies-to ID", FORMAT(GLEntryToApply."Source No.") + '-' + FORMAT(NoSeqApplyToID));
                                                //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                                //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1
                                                FoundOnce := true;
                                            end;
                                        //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1
                                        until DetailedVendLedgEntry.NEXT() = 0;
                                        //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1
                                        if FoundOnce then begin
                                            //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1
                                            GLEntryToModify.COPY(GLEntryApplicationBuffer, true);
                                            GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                                            //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                            GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."Source No.") + '-' + FORMAT(NoSeqApplyToID);
                                            //<<FDD-HNK-Auto Clear HNK 27/10/16 1.2
                                            GLEntryToModify.MODIFY();
                                            //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1
                                        end;
                                        //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1
                                    end;
                                until DetailedVendLedgEntry2.NEXT() = 0;
                            end;
                        end;
                    end;
                end;
            until GLEntryApplicationBuffer.NEXT() = 0;
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    procedure "SetApplyIDWithGR/IRAccountsPayable"(var GLEntryApplicationBuffer: Record "G/L Entry Application Bffr FND" temporary);
    var
        GLItemLedgerRelation: Record "G/L - Item Ledger Relation";
        GLEntry2: Record "G/L Entry";
        TempGLEntry: Record "G/L Entry" temporary;
        GLEntryToApply: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToModify: Record "G/L Entry Application Bffr FND" temporary;
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ValueEntry2: Record "Value Entry";
        GLEntryFinded: Boolean;
        PositiveAmount: Boolean;
        lop: Integer;
        lopRelation: Integer;
        NoSeqApplyToID: Integer;
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        NoSeqApplyToID := 0;
        GLEntryApplicationBuffer.SETCURRENTKEY("Applies-to ID");
        GLEntryApplicationBuffer.SETFILTER("Applies-to ID", '''''');
        GLEntryApplicationBuffer.SETRANGE(Positive, true);
        if GLEntryApplicationBuffer.FINDFIRST() then
            repeat
                GLItemLedgerRelation.RESET();
                GLItemLedgerRelation.SETRANGE("G/L Entry No.", GLEntryApplicationBuffer."Entry No.");
                if GLItemLedgerRelation.FINDFIRST() then begin
                    lopRelation += 1;
                    ValueEntry.GET(GLItemLedgerRelation."Value Entry No.");
                    if (ValueEntry."Document Type" = ValueEntry."Document Type"::"Purchase Invoice") then begin
                        ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
                        ValueEntry2.SETCURRENTKEY("Item Ledger Entry No.");
                        ValueEntry2.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                        ValueEntry2.SETRANGE("Expected Cost", true);
                        ValueEntry2.SETFILTER("Entry No.", '<>%1', ValueEntry."Entry No.");
                        if ValueEntry2.findset() then
                            repeat
                                CLEAR(GLItemLedgerRelation);
                                GLItemLedgerRelation.SETCURRENTKEY("Value Entry No.");
                                GLItemLedgerRelation.SETRANGE("Value Entry No.", ValueEntry2."Entry No.");
                                if GLItemLedgerRelation.findset() then
                                    repeat
                                        GLEntryToApply.COPY(GLEntryApplicationBuffer, true);
                                        if (GLEntryApplicationBuffer."Entry No." <> GLItemLedgerRelation."G/L Entry No.") and GLEntryToApply.GET(GLItemLedgerRelation."G/L Entry No.")
                                         //<<FDD-HNK-Auto Clear HNK 25/10/16 1.1
                                         and (GLEntryToApply.Positive = false) and (GLEntryToApply.Open = true) and (GLEntryToApply."Applies-to ID" = '') then begin
                                            //<<FDD-HNK-Auto Clear HNK 25/10/16 1.1
                                            NoSeqApplyToID += 1;
                                            GLEntryToModify.COPY(GLEntryApplicationBuffer, true);
                                            GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                                            GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                            GLEntryToModify.MODIFY();
                                            GLEntryToApply."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                            GLEntryToApply.MODIFY();
                                        end;
                                    until GLItemLedgerRelation.NEXT() = 0;
                            until ValueEntry2.NEXT() = 0;
                    end;
                end;
            until GLEntryApplicationBuffer.NEXT() = 0;
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    procedure "SetApplyIDWithGR/IRAccountsReceiveble"(var GLEntryApplicationBuffer: Record "G/L Entry Application Bffr FND" temporary);
    var
        GLItemLedgerRelation: Record "G/L - Item Ledger Relation";
        GLEntry2: Record "G/L Entry";
        TempGLEntry: Record "G/L Entry" temporary;
        GLEntryToApply: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToModify: Record "G/L Entry Application Bffr FND" temporary;
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ValueEntry2: Record "Value Entry";
        GLEntryFinded: Boolean;
        PositiveAmount: Boolean;
        NoSeqApplyToID: Integer;
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        NoSeqApplyToID := 0;
        GLEntryApplicationBuffer.SETCURRENTKEY("Applies-to ID");
        GLEntryApplicationBuffer.SETFILTER("Applies-to ID", '''''');
        GLEntryApplicationBuffer.SETRANGE(Positive, false);
        if GLEntryApplicationBuffer.FINDFIRST() then
            repeat
                GLItemLedgerRelation.RESET();
                GLItemLedgerRelation.SETRANGE("G/L Entry No.", GLEntryApplicationBuffer."Entry No.");
                if GLItemLedgerRelation.FINDFIRST() then begin
                    ValueEntry.GET(GLItemLedgerRelation."Value Entry No.");
                    if (ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Invoice") then begin
                        ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
                        ValueEntry2.SETCURRENTKEY("Item Ledger Entry No.");
                        ValueEntry2.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                        ValueEntry2.SETRANGE("Expected Cost", true);
                        ValueEntry2.SETFILTER("Entry No.", '<>%1', ValueEntry."Entry No.");
                        if ValueEntry2.findset() then
                            repeat
                                CLEAR(GLItemLedgerRelation);
                                GLItemLedgerRelation.SETCURRENTKEY("Value Entry No.");
                                GLItemLedgerRelation.SETRANGE("Value Entry No.", ValueEntry2."Entry No.");
                                if GLItemLedgerRelation.findset() then
                                    repeat
                                        GLEntryToApply.COPY(GLEntryApplicationBuffer, true);

                                        if (GLEntryApplicationBuffer."Entry No." <> GLItemLedgerRelation."G/L Entry No.") and GLEntryToApply.GET(GLItemLedgerRelation."G/L Entry No.")
                                         //<<FDD-HNK-Auto Clear HNK 25/10/16 1.1
                                         and (GLEntryToApply.Positive = true) and (GLEntryToApply.Open = true) and (GLEntryToApply."Applies-to ID" = '') then begin
                                            //<<FDD-HNK-Auto Clear HNK 25/10/16 1.1

                                            NoSeqApplyToID += 1;

                                            GLEntryToModify.COPY(GLEntryApplicationBuffer, true);
                                            GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                                            GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                            GLEntryToModify.MODIFY();

                                            GLEntryToApply."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                            GLEntryToApply.MODIFY();
                                        end;

                                    until GLItemLedgerRelation.NEXT() = 0;

                            until ValueEntry2.NEXT() = 0;
                    end;
                end;

            until GLEntryApplicationBuffer.NEXT() = 0;
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    procedure SetApplyIDWithSepcialCriteria(var GLEntryApplicationBuffer: Record "G/L Entry Application Bffr FND" temporary; BAmount: Boolean; BRemainingAmount: Boolean; BDocumentNo: Boolean; BExternalDocNo: Boolean; BComment: Boolean);
    var
        GLEntryToApply: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToModify: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryFinded: Boolean;
        PositiveAmount: Boolean;
        NoSeqApplyToID: Integer;
    begin

        //<<FDD-HNK-Auto Clear HNK 10/10/16
        //IF (NOT BAmount) AND (NOT BRemainingAmount) AND (NOT BDocumentNo) AND (NOT BExternalDocNo) THEN //HEI.02 commented
        if (not BAmount) and (not BRemainingAmount) and (not BDocumentNo) and (not BExternalDocNo) and (not BComment) then //HEI.02
            ERROR(TXT50000);
        NoSeqApplyToID := 0;
        GLEntryApplicationBuffer.SETCURRENTKEY("Applies-to ID");
        GLEntryApplicationBuffer.SETFILTER("Applies-to ID", '''''');
        if GLEntryApplicationBuffer.FINDFIRST() then
            repeat
                if GLEntryApplicationBuffer."Applies-to ID" = '' then begin
                    GLEntryFinded := false;
                    GLEntryToApply.COPY(GLEntryApplicationBuffer, true);
                    GLEntryToApply.SETFILTER("Entry No.", '<>%1', GLEntryApplicationBuffer."Entry No.");
                    //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1
                    //OLD IF BAmount OR BRemainingAmount THEN BEGIN
                    //OLD   IF GLEntryApplicationBuffer.Positive THEN
                    //OLD     GLEntryToApply.SETRANGE(Positive,FALSE) // Negative lines
                    //OLD   else
                    //OLD     GLEntryToApply.SETRANGE(Positive,TRUE); // Positive lines
                    //OLD end;
                    if BAmount then begin
                        if GLEntryApplicationBuffer.Positive then
                            GLEntryToApply.SETRANGE(Positive, false) // Negative lines
                        else
                            GLEntryToApply.SETRANGE(Positive, true); // Positive lines
                    end;

                    if BRemainingAmount then begin
                        if GLEntryApplicationBuffer."Remaining Amount" > 0 then
                            GLEntryToApply.SETFILTER("Remaining Amount", '<0') // Negative lines
                        else
                            GLEntryToApply.SETFILTER("Remaining Amount", '>0'); // Positive lines
                    end;
                    //<<FDD-HNK-Auto Clear HNK 10/10/16 1,1

                    //HEI.03>>
                    if BComment then
                        GLEntryToApply.SETFILTER(Comment, '<>%1', '');
                    //HEI.03<<

                    if GLEntryToApply.FINDFIRST() then begin
                        NoSeqApplyToID += 1;
                        repeat
                            if ((BAmount and (ABS(GLEntryApplicationBuffer.Amount) = ABS(GLEntryToApply.Amount))) or (not BAmount))
                             and ((BRemainingAmount and (ABS(GLEntryApplicationBuffer."Remaining Amount") = ABS(GLEntryToApply."Remaining Amount"))) or (not BRemainingAmount))
                             and ((BDocumentNo and (GLEntryApplicationBuffer."Document No." = GLEntryToApply."Document No.")) or (not BDocumentNo))
                             and ((BExternalDocNo and (GLEntryApplicationBuffer."External Document No." = GLEntryToApply."External Document No.") and (GLEntryApplicationBuffer."External Document No." <> '')) or (not BExternalDocNo))
                             and ((BComment and (GLEntryApplicationBuffer.Comment = GLEntryToApply.Comment)) or (not BComment)) then//HEI.02
                              begin
                                GLEntryFinded := true;

                                GLEntryToModify.COPY(GLEntryApplicationBuffer, true);
                                GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                                GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                GLEntryToModify.MODIFY();
                                GLEntryToApply."Applies-to ID" := FORMAT(GLEntryApplicationBuffer."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                GLEntryToApply.MODIFY();
                            end;
                        until (GLEntryFinded = true) or (GLEntryToApply.NEXT() = 0);
                    end;
                end;
            until GLEntryApplicationBuffer.NEXT() = 0;
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    local procedure GetSalesOrderNo(InvoiceNo: Code[20]): Code[20];
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        SalesInvoiceHeader.GET(InvoiceNo);
        exit(SalesInvoiceHeader."Order No.");
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    local procedure GetPurchaseOrderNo(InvoiceNo: Code[20]): Code[20];
    var
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        PurchaseInvoiceHeader.GET(InvoiceNo);
        exit(PurchaseInvoiceHeader."Order No.");
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    local procedure GetPreSalesOrderNo(InvoiceNo: Code[20]): Code[20];
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        SalesInvoiceHeader.GET(InvoiceNo);
        exit(SalesInvoiceHeader."Prepayment Order No.");
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    local procedure GetPrePurchaseOrderNo(InvoiceNo: Code[20]): Code[20];
    var
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        PurchaseInvoiceHeader.GET(InvoiceNo);
        exit(PurchaseInvoiceHeader."Prepayment Order No.");
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    local procedure GetDocumentNoCust(CustEntryNo: Integer): Code[20];
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        if CustLedgEntry.GET(CustEntryNo) then;
        exit(CustLedgEntry."Document No.");
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    local procedure GetCustLedEntrySens(CustLedEntryNo: Integer): Boolean;
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        CustLedgerEntry.RESET();
        CustLedgerEntry.GET(CustLedEntryNo);
        exit(CustLedgerEntry.Positive);
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    local procedure GetDocumentNoVend(VendEntryNo: Integer): Code[20];
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        if VendLedgEntry.GET(VendEntryNo) then;
        exit(VendLedgEntry."Document No.");
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    local procedure GetVendLedEntrySens(VendLedEntryNo: Integer): Boolean;
    var
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        //<<FDD-HNK-Auto Clear HNK 10/10/16
        VendLedgerEntry.RESET();
        VendLedgerEntry.GET(VendLedEntryNo);
        exit(VendLedgerEntry.Positive);
        //<<FDD-HNK-Auto Clear HNK 10/10/16
    end;

    procedure SetApplyIDWithGRIRAccountsPayableFA(var GLEntryApplicationBuffer: Record "G/L Entry Application Bffr FND" temporary);
    var
        GLItemLedgerRelation: Record "G/L - Item Ledger Relation";
        GLEntry2: Record "G/L Entry";
        GLEntry3: Record "G/L Entry";
        TempGLEntry: Record "G/L Entry" temporary;
        G_TempGLEntryBuf: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToApply: Record "G/L Entry Application Bffr FND" temporary;
        GLEntryToModify: Record "G/L Entry Application Bffr FND" temporary;
        ItemLedgEntry: Record "Item Ledger Entry";
        PostedCrPurchaseLine: Record "Purch. Cr. Memo Line";
        PostedPurchaseLine: Record "Purch. Inv. Line";
        ValueEntry: Record "Value Entry";
        ValueEntry2: Record "Value Entry";
        GRIRAutomaticClearing: Codeunit "GR/IR Automatic clearing CBN";
        GLEntryFinded: Boolean;
        PositiveAmount: Boolean;
        i: Integer;
        lop: Integer;
        lopRelation: Integer;
        NoSeqApplyToID: Integer;
        TotalNo: Integer;
    begin
        //HEI.04>>
        NoSeqApplyToID := 0;
        GLEntryApplicationBuffer.SETCURRENTKEY("Applies-to ID");
        GLEntryApplicationBuffer.SETFILTER("Applies-to ID", '''''');
        if GLEntryApplicationBuffer.FINDFIRST() then
            repeat
                case GLEntryApplicationBuffer."Document Type" of
                    GLEntryApplicationBuffer."Document Type"::Invoice:
                        begin
                            NoSeqApplyToID += 1;
                            PostedCrPurchaseLine.RESET();
                            PostedPurchaseLine.SETCURRENTKEY("Document No.", "Line No.");
                            PostedPurchaseLine.SETRANGE("Document No.", GLEntryApplicationBuffer."Document No.");
                            PostedPurchaseLine.SETRANGE(Type, PostedPurchaseLine.Type::"Fixed Asset");
                            PostedPurchaseLine.SETFILTER("No.", '<>%1', '');
                            PostedPurchaseLine.SETFILTER("Receipt No.", '<>%1', '');
                            if PostedPurchaseLine.FINDFIRST() then
                                repeat
                                    GLEntry3.RESET();
                                    GLEntry3.SETCURRENTKEY("Document Type", "Document No.");
                                    GLEntry3.SETRANGE("Document Type", GLEntry3."Document Type"::"Purchase Receipt");
                                    GLEntry3.SETRANGE("Document No.", PostedPurchaseLine."Receipt No.");
                                    GLEntry3.SETRANGE("G/L Account No.", GLEntryApplicationBuffer."G/L Account No.");
                                    GLEntry3.SETRANGE("Open FND", true);
                                    GLEntry3.SETRANGE(Reversed, false);
                                    GLEntry3.SETRANGE("Applies-to ID FND", '');
                                    if GLEntry3.FINDFIRST() then begin
                                        GLEntryToApply.COPY(GLEntryApplicationBuffer, true);
                                        if (GLEntryApplicationBuffer."Entry No." <> GLEntry3."Entry No.") and GLEntryToApply.GET(GLEntry3."Entry No.")
                                        and (GLEntryToApply.Open = true) and (GLEntryToApply."Applies-to ID" = '') then begin
                                            GLEntryToModify.COPY(GLEntryApplicationBuffer, true);
                                            GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                                            GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                            GLEntryToModify.MODIFY();
                                            GLEntryToApply."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                            GLEntryToApply.MODIFY();
                                        end;
                                    end;
                                until PostedPurchaseLine.NEXT() = 0;
                            //Applied Entries
                            G_TempGLEntryBuf.COPY(GLEntryApplicationBuffer, true);
                            GRIRAutomaticClearing.UpdateAllowpartial(true);
                            G_TempGLEntryBuf.RESET();
                            G_TempGLEntryBuf.SETCURRENTKEY("Entry No.");
                            G_TempGLEntryBuf.SETFILTER("Applies-to ID", '<>%1', '');
                            G_TempGLEntryBuf.SETRANGE(Open, true);
                            TotalNo := G_TempGLEntryBuf.COUNT;
                            if G_TempGLEntryBuf.FIND('-') then
                                GRIRAutomaticClearing.Apply(G_TempGLEntryBuf);
                            if TotalNo mod 2 <> 0 then
                                TotalNo += 1;
                            for i := 1 to (TotalNo / 2) do begin
                                G_TempGLEntryBuf.RESET();
                                G_TempGLEntryBuf.SETFILTER("Applies-to ID", '<>%1', '');
                                G_TempGLEntryBuf.SETRANGE(Open, true);
                                if G_TempGLEntryBuf.FIND('-') then
                                    GRIRAutomaticClearing.Apply(G_TempGLEntryBuf);
                            end;
                        end;
                    GLEntryApplicationBuffer."Document Type"::"Credit Memo":
                        begin
                            NoSeqApplyToID += 1;
                            PostedCrPurchaseLine.RESET();
                            PostedCrPurchaseLine.SETCURRENTKEY("Document No.", "Line No.");
                            PostedCrPurchaseLine.SETRANGE("Document No.", GLEntryApplicationBuffer."Document No.");
                            PostedCrPurchaseLine.SETRANGE(Type, PostedPurchaseLine.Type::"Fixed Asset");
                            PostedCrPurchaseLine.SETFILTER("No.", '<>%1', '');
                            PostedCrPurchaseLine.SETFILTER("Return Shipment No.", '<>%1', '');
                            if PostedCrPurchaseLine.FINDFIRST() then
                                repeat
                                    GLEntry3.RESET();
                                    GLEntry3.SETCURRENTKEY("Document Type", "Document No.");
                                    GLEntry3.SETRANGE("Document Type", GLEntry3."Document Type"::"Purchase Shipment");
                                    GLEntry3.SETRANGE("Document No.", PostedCrPurchaseLine."Return Shipment No.");
                                    GLEntry3.SETRANGE("G/L Account No.", GLEntryApplicationBuffer."G/L Account No.");
                                    GLEntry3.SETRANGE("Open FND", true);
                                    GLEntry3.SETRANGE(Reversed, false);
                                    GLEntry3.SETRANGE("Applies-to ID FND", '');
                                    if GLEntry3.FINDFIRST() then begin
                                        GLEntryToApply.COPY(GLEntryApplicationBuffer, true);
                                        if (GLEntryApplicationBuffer."Entry No." <> GLEntry3."Entry No.") and GLEntryToApply.GET(GLEntry3."Entry No.")
                                        and (GLEntryToApply.Open = true) and (GLEntryToApply."Applies-to ID" = '') then begin
                                            GLEntryToModify.COPY(GLEntryApplicationBuffer, true);
                                            GLEntryToModify.GET(GLEntryApplicationBuffer."Entry No.");
                                            GLEntryToModify."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                            GLEntryToModify.MODIFY();
                                            GLEntryToApply."Applies-to ID" := FORMAT(GLEntryToModify."G/L Account No.") + '-' + FORMAT(NoSeqApplyToID);
                                            GLEntryToApply.MODIFY();
                                        end;
                                    end;
                                until PostedCrPurchaseLine.NEXT() = 0;
                            //Applied Entries
                            G_TempGLEntryBuf.COPY(GLEntryApplicationBuffer, true);
                            GRIRAutomaticClearing.UpdateAllowpartial(true);
                            G_TempGLEntryBuf.RESET();
                            G_TempGLEntryBuf.SETCURRENTKEY("Entry No.");
                            G_TempGLEntryBuf.SETFILTER("Applies-to ID", '<>%1', '');
                            G_TempGLEntryBuf.SETRANGE(Open, true);
                            TotalNo := G_TempGLEntryBuf.COUNT;
                            if G_TempGLEntryBuf.FIND('-') then
                                GRIRAutomaticClearing.Apply(G_TempGLEntryBuf);
                            if TotalNo mod 2 <> 0 then
                                TotalNo += 1;
                            for i := 1 to (TotalNo / 2) do begin
                                G_TempGLEntryBuf.RESET();
                                G_TempGLEntryBuf.SETFILTER("Applies-to ID", '<>%1', '');
                                G_TempGLEntryBuf.SETRANGE(Open, true);
                                if G_TempGLEntryBuf.FIND('-') then
                                    GRIRAutomaticClearing.Apply(G_TempGLEntryBuf);
                            end;
                        end;
                end;
            until GLEntryApplicationBuffer.NEXT() = 0;
        //HEI.04<<
    end;
}

