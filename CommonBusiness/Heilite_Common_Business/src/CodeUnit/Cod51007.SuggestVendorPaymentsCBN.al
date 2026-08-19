codeunit 51007 "Suggest Vendor Payments CBN"
{
    // version HEI.01

    // HEI.01 PTPGAP077 - IBM HORTOC01 23.03.2018
    //  #new codeunit to be able to display the filters used on suggestion
    // HEI.02 CHG2040699 IBM POSTOI01 14.01.2020 Ivory Coast - WHT at the moment of payment
    //   # new boolean global CalledFromPaymentJournalTreeWHT
    //   # new function SetCalledFromPaymentJournalTreeWHT
    //   # new code in RunReportRequestPage, new local variable SuggestVendorPaymentsWHT
    /**********************************************/
    //BC UPGRADE ATHUKS01>>
    //1.Commneted WHT code & Handling code Non WHT.
    //2.if condition is removed to WHT Pending.
    //BC UPGRADE ATHUKS01<<

    TableNo = "Gen. Journal Batch";

    trigger OnRun();
    begin
        RunReportRequestPage(Rec, ShowReportParam);
    end;

    var
        GeneralJournalLine: Record "Gen. Journal Line";
        CalledFromPaymentJournalTree: Boolean;
        CalledFromPaymentJournalTreeWHT: Boolean;
        ShowReportParam: Boolean;

    procedure GetReportParameters(GenJournalBatch: Record "Gen. Journal Batch"): Text;
    var
        InStr: InStream;
        Params: Text;
    begin
        GenJournalBatch.CALCFIELDS(GenJournalBatch."Suggest Payment Param FND");
        if GenJournalBatch."Suggest Payment Param FND".HASVALUE then begin
            GenJournalBatch."Suggest Payment Param FND".CREATEINSTREAM(InStr, TEXTENCODING::UTF8);
            InStr.READ(Params);
        end;

        exit(Params);
    end;

    procedure SetReportParameters(Params: Text; GenJournalBatch: Record "Gen. Journal Batch");
    var
        OutStr: OutStream;
    begin

        CLEAR(GenJournalBatch."Suggest Payment Param FND");
        if Params <> '' then begin
            GenJournalBatch."Suggest Payment Param FND".CREATEOUTSTREAM(OutStr, TEXTENCODING::UTF8);
            OutStr.WRITE(Params);
        end;
        GenJournalBatch.MODIFY(); // Necessary because the following function does a CALCFIELDS(XML)
    end;

    procedure RunReportRequestPage(GenJournalBatch: Record "Gen. Journal Batch"; ShowParam: Boolean);
    var
        SuggestVendorPayments: Report "Suggest Vendor Payments Hei";
        SuggestVendorPaymentsWHT: Report "Suggest Vendor Payments WHT";
        Params: Text;
    begin
        //     //HEI.02>>
        if CalledFromPaymentJournalTreeWHT then begin
            SuggestVendorPaymentsWHT.SetGenJnlLine(GeneralJournalLine);
            SuggestVendorPaymentsWHT.SetShowParam(ShowParam);
            SuggestVendorPaymentsWHT.SetCalledFromPaymentJournalTree(CalledFromPaymentJournalTree);
            Params := SuggestVendorPaymentsWHT.RUNREQUESTPAGE(GetReportParameters(GenJournalBatch));
            if Params <> '' then
                SetReportParameters(Params, GenJournalBatch);

            if not ShowReportParam then begin
                CLEAR(SuggestVendorPaymentsWHT);
                SuggestVendorPaymentsWHT.SetGenJnlLine(GeneralJournalLine);
                SuggestVendorPaymentsWHT.SetCalledFromPaymentJournalTree(CalledFromPaymentJournalTree);
                SuggestVendorPaymentsWHT.SetShowParam(true);
                SuggestVendorPaymentsWHT.EXECUTE(Params);
            end;
        end else begin
            //HEI.02<<
            SuggestVendorPayments.SetGenJnlLine(GeneralJournalLine);
            SuggestVendorPayments.SetShowParam(ShowParam);
            SuggestVendorPayments.SetCalledFromPaymentJournalTree(CalledFromPaymentJournalTree);
            Params := SuggestVendorPayments.RUNREQUESTPAGE(GetReportParameters(GenJournalBatch));
            if Params <> '' then
                SetReportParameters(Params, GenJournalBatch);
            if not ShowReportParam then begin
                CLEAR(SuggestVendorPayments);
                SuggestVendorPayments.SetGenJnlLine(GeneralJournalLine);
                SuggestVendorPayments.SetCalledFromPaymentJournalTree(CalledFromPaymentJournalTree);
                SuggestVendorPayments.SetShowParam(true);
                SuggestVendorPayments.EXECUTE(Params);
            end;
        end; //HEI.02  // BC Upgrade NANDIS03
        //BC UPGRADE ATHUKS01>>  
        //if not CalledFromPaymentJournalTreeWHT then begin
        // SuggestVendorPayments.SetGenJnlLine(GeneralJournalLine);
        // SuggestVendorPayments.SetShowParam(ShowParam);
        // SuggestVendorPayments.SetCalledFromPaymentJournalTree(CalledFromPaymentJournalTree);
        // Params := SuggestVendorPayments.RUNREQUESTPAGE(GetReportParameters(GenJournalBatch));
        // if Params <> '' then
        //     SetReportParameters(Params, GenJournalBatch);
        // if not ShowReportParam then begin
        //     CLEAR(SuggestVendorPayments);
        //     SuggestVendorPayments.SetGenJnlLine(GeneralJournalLine);
        //     SuggestVendorPayments.SetCalledFromPaymentJournalTree(CalledFromPaymentJournalTree);
        //     SuggestVendorPayments.SetShowParam(true);
        //     SuggestVendorPayments.EXECUTE(Params);
        // end;
        //end;
        //BC UPGRADE ATHUKS01<<
    end;

    procedure ShowParam(ShowParameters: Boolean);
    begin
        ShowReportParam := ShowParameters;
    end;

    procedure SetRec(GenJournalLine: Record "Gen. Journal Line");
    begin
        GeneralJournalLine := GenJournalLine;
    end;

    procedure SetCalledFromPaymentJournalTree(pCalledFromPaymentJournalTree: Boolean);
    begin
        CalledFromPaymentJournalTree := pCalledFromPaymentJournalTree;
    end;

    procedure SetCalledFromPaymentJournalTreeWHT(pCalledFromPaymentJournalTreeWHT: Boolean);
    begin
        //HEI.02>>
        CalledFromPaymentJournalTreeWHT := pCalledFromPaymentJournalTreeWHT;
        //HEI.02<<
    end;
}

