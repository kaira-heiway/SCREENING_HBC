codeunit 58090 "API Payment Interface Mgmt."
{
    //BC Upgrade GUNREM01 Old ID-50135
    // version HEI.09

    // HEI.01 FDD-HB1268 - CHG2068666 IBM NASTAA02 26.10.2020 # DMS Integration Ivory Coast
    //   # New Codeunit created for API Payment Interface
    // HEI.02 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Code added on function 'ProcessDMSPaymentRequest'
    // HEI.03 HB2300 - CHG2113543 IBM NASTAA02 02.09.2021 # DMS DRC
    //   # Code added to function 'ProcessDMSPaymentRequest'
    // HEI.04 INC3795821 - CHG2132451 IBM NASTAA02 28.10.2021 # Entries in API are unable to be reprocessed with Status=Error and Pending
    //   # Code added to function 'ProcessDMSPaymentRequest'
    // HEI.05 HB2469 - CHG2122312 IBM NASTAA02 17.11.2021 # Payment API with B2B DOT Interface into HL
    //   # Code added to update "Applies-to Doc. No." on Sales Orders
    //   # "Document No." will be updated using the value from the XML
    //   # 3 new tags created: 'GenJournalTemplate', 'GenJournalBatch' and 'BalAccountNo'
    //   # Update Description as Description of Gen. Journal Batch
    // HEI.06 INC4083000 - CHG2156647 IBM NASTAA02 03.05.2022 # NAS Service consuming high memory
    //   # Clear variables after Webservice call
    // HEI.07 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    // HEI.08 CHG2160095 IBM GHOSHS05 20.07.22 -BASE-DDE driver payment integration
    //   # Added code to check for payment batch from new table
    // HEI.09 CHG2160095 DEBUSD01 20.10.2022 driver payment integration
    //   # fix wrong read Payment Method
    //   # fix ignore amount LCY

    //BC Upgrade GUNREM01 
    //# Replaced NoSeriesManagement codeunit with Noseries.
    //# Replaced Dotnet varibales with XML variables
    //# Code updated using xml Variables 

    // BC Upgrade PATELP08>>
    // Changed name of table from "Cash Rcpt Bal G/L Account" to "Cash Rcpt Bal G/L Account FND"
    // BC Upgrade PATELP08<<

    // BC Upgrade MISHRS14 >>
    // Changed name to "DMS Cash Rcpt Bal GL Acc FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    TableNo = "API Interface Log2 INT";

    trigger OnRun();
    begin
        APIInterfaceLog := Rec;
        case APIInterfaceLog.Entity of
            'PAYMENT':
                begin
                    case APIInterfaceLog.Operation of
                        'CREATE':
                            begin
                                ProcessDMSPaymentRequest();
                            end;
                    end;
                end;
        end;
        Rec := APIInterfaceLog;
    end;

    var
        APIInterfaceLog: Record "API Interface Log2 INT";
        MissingNodeErr: Label '%1 node missing from XML';
        TextMissingErr: Label 'Text missing for node %1 in XML';
        GeneralLedgerSetup: Record "General Ledger Setup";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";

    local procedure ProcessDMSPaymentRequest();
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        LineNo: Integer;
        GenJournalBatch: Record "Gen. Journal Batch";
        DocumentNo: Code[20];
        //  NoSeriesManagement: Codeunit NoSeriesManagement;
        NoSeriesManagement: Codeunit "No. Series"; //BC Upgrade GUNREM01 
        RequestInStream: InStream;
        //BC Upgrade GUNREM01 >>
        // RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // PaymentsXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // PaymentXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        RequestXmlDocument: XmlDocument;
        PaymentsXmlNode: XmlNode;
        PaymentXmlNode: XmlNode;
        TempXmlNode: XmlNode;
        //BC Upgrade GUNREM01 <<
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        TempPostingDate: Date;
        TempDocumentType: Integer;
        TempAccountType: Integer;
        TempAmount: Decimal;
        TempAmountLCY: Decimal;
        TempItemChargeType: Integer;
        //  PaymentsXmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        PaymentsXmlNodeList: XmlNodeList; //BC Upgrade GUNREM01
        JournalTemplate: Code[10];
        JournalBatch: Code[10];
        BalAccountNo: Code[20];
        CashRcptBalGLAccount: Record "Cash Rcpt Bal G/L Account FND";
        TempPaymentMethod: Code[10];
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TempLocationCode: Code[10];
        Customer: Record Customer;
        BillToCustomer: Record Customer;
        SourceCodeSetup: Record "Source Code Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        SalesHeader: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesOrderFound: Boolean;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
        RelatedSalesOrderNo: Code[20];
        OpenSalesOrder: Boolean;
        JournalTemplate2: Code[10];
        JournalBatch2: Code[10];
        BalAccountNo2: Code[20];
        CashRcptBalGLAccountDMS: Record "DMS Cash Rcpt Bal GL Acc FND";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Instrm: InStream;
        XMLEle: XmlElement;
        TempSourceSystem: Code[10];
        CustomerCode: Code[20];

    begin
        GeneralLedgerSetup.GET(); //HEI.05
        APIInterfaceSetup.GET();
        APIInterfaceLog."Request File".CREATEINSTREAM(RequestInStream);
        // RequestXmlDocument := RequestXmlDocument.XmlDocument;
        // RequestXmlDocument.Load(RequestInStream);
        RequestXmlDocument := XmlDocument.Create();
        XmlDocument.ReadFrom(RequestInStream, RequestXmlDocument); // SHUKLP03
        //BC Upgrade GUNREM01 <<

        //BC Upgrade GUNREM01 >>
        // PaymentsXmlNode := RequestXmlDocument.SelectSingleNode('/Payments/Payment');
        // if ISNULL(PaymentsXmlNode) then
        //     ERROR(MissingNodeErr, 'Payment');
        if not RequestXmlDocument.SelectSingleNode('/Payments/Payment', PaymentsXmlNode) THEN // SHUKLP03
            Error(MissingNodeErr, 'Payment');

        // PaymentsXmlNodeList := PaymentsXmlNode.SelectNodes('/Payments/Payment');
        // if ISNULL(PaymentsXmlNodeList) then
        //     ERROR(MissingNodeErr, 'Payment');
        if not PaymentsXmlNode.SelectNodes('/Payments/Payment', PaymentsXmlNodeList) then
            Error(MissingNodeErr, 'Payment');
        //BC Upgrade GUNREM01 <<
        foreach PaymentXmlNode in PaymentsXmlNodeList do begin
            GenJournalLine.INIT();
            //HEI.05>>
            GetNodeByXPath('SourceSystemIdentifier', 'SourceSystemIdentifier', PaymentXmlNode, TempXmlNode);
            //BC Upgrade GUNREM01 >>
            // SourceSystemIdentifierAPI.GET(TempXmlNode.InnerText);
            TempSourceSystem := TempXmlNode.AsXmlElement().InnerText();
            SourceSystemIdentifierAPI.GET(TempSourceSystem);
            //BC Upgrade GUNREM01 <<
            //HEI.05<<

            // Get the Posting Date
            GetNodeByXPath('PostingDate', 'PostingDate', PaymentXmlNode, TempXmlNode);
            //BC Upgrade GUNREM01 >>
            // EVALUATE(TempPostingDate, TempXmlNode.InnerText, 9);
            Evaluate(TempPostingDate, TempXmlNode.AsXmlElement().InnerText(), 9);
            //BC Upgrade GUNREM01 <<
            //HEI.02>>
            SourceCodeSetup.GET();
            GenJournalLine.VALIDATE("Source Code", SourceCodeSetup."Cash Receipt Journal");

            // Check if Payment Method exists

            //BC Upgrade GUNREM01 >>
            //HEI.09>>
            // TempXmlNode := PaymentXmlNode.SelectSingleNode('PaymentMethod');
            //HEI.09<<
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         TempPaymentMethod := TempXmlNode.InnerText;


            //Check if Location Code exist
            // TempXmlNode := PaymentXmlNode.SelectSingleNode('LocationCode');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         TempLocationCode := TempXmlNode.InnerText;

            // //HEI.05>>
            // TempXmlNode := PaymentXmlNode.SelectSingleNode('GenJournalTemplate');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         JournalTemplate2 := TempXmlNode.InnerText;

            // TempXmlNode := PaymentXmlNode.SelectSingleNode('GenJournalBatch');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         JournalBatch2 := TempXmlNode.InnerText;

            // TempXmlNode := PaymentXmlNode.SelectSingleNode('BalAccountNo');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         BalAccountNo2 := TempXmlNode.InnerText;

            if PaymentXmlNode.SelectSingleNode('PaymentMethod', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        TempPaymentMethod := TempXmlNode.AsXmlElement().InnerText();

            if PaymentXmlNode.SelectSingleNode('LocationCode', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        TempLocationCode := TempXmlNode.AsXmlElement().InnerText();

            if PaymentXmlNode.SelectSingleNode('GenJournalTemplate', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        JournalTemplate2 := TempXmlNode.AsXmlElement().InnerText();

            if PaymentXmlNode.SelectSingleNode('GenJournalBatch', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        JournalBatch2 := TempXmlNode.AsXmlElement().InnerText();

            if PaymentXmlNode.SelectSingleNode('BalAccountNo', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        BalAccountNo2 := TempXmlNode.AsXmlElement().InnerText();

            //BC Upgrade GUNREM01 <<

            if (JournalTemplate2 <> '') and (JournalBatch2 <> '') and (BalAccountNo2 <> '') then begin
                JournalTemplate := JournalTemplate2;
                JournalBatch := JournalBatch2;
                BalAccountNo := BalAccountNo2;
            end else begin
                //HEI.05<<

                if CashRcptBalGLAccount.GET(TempLocationCode, TempPaymentMethod) then begin
                    JournalTemplate := CashRcptBalGLAccount."Cash Journal Template";
                    JournalBatch := CashRcptBalGLAccount."Cash Journal Batch";
                    BalAccountNo := CashRcptBalGLAccount."Balance G/L Account";
                    GenJournalBatch.GET(CashRcptBalGLAccount."Cash Journal Template", CashRcptBalGLAccount."Cash Journal Batch");
                    //HEI.08>>
                    //END ELSE
                    //HEI.02<<
                end else if CashRcptBalGLAccountDMS.GET(TempLocationCode, TempPaymentMethod) then begin
                    JournalTemplate := CashRcptBalGLAccountDMS."Cash Journal Template";
                    JournalBatch := CashRcptBalGLAccountDMS."Cash Journal Batch";
                    BalAccountNo := CashRcptBalGLAccountDMS."Balance G/L Account";
                    GenJournalBatch.GET(CashRcptBalGLAccountDMS."Cash Journal Template", CashRcptBalGLAccountDMS."Cash Journal Batch");
                end else begin
                    //HEI.08<<
                    JournalTemplate := APIInterfaceSetup."Cash Journal Template";
                    JournalBatch := APIInterfaceSetup."Cash Journal Batch";
                    GenJournalBatch.GET(APIInterfaceSetup."Cash Journal Template", APIInterfaceSetup."Cash Journal Batch");
                    BalAccountNo := GenJournalBatch."Bal. Account No.";
                end; //HEI.02
            end; //HEI.05

            // Generate Document No.
            GenJournalLine2.RESET();
            GenJournalLine2.SETRANGE("Journal Template Name", JournalTemplate);
            GenJournalLine2.SETRANGE("Journal Batch Name", JournalBatch);
            if GenJournalLine2.FINDLAST() then
                LineNo := GenJournalLine2."Line No." + 10000
            //HEI.02>>
            else
                LineNo := 10000;

            //HEI.05>>
            //Use Document No. from XML
            if SourceSystemIdentifierAPI."Disable Default Pay Doc. No." then begin
                //BC Upgrade GUNREM01 >>
                // TempXmlNode := PaymentXmlNode.SelectSingleNode('DocumentNo');
                // if not ISNULL(TempXmlNode) then
                //     if TempXmlNode.InnerText <> '' then
                //         DocumentNo := TempXmlNode.InnerText;
                if PaymentXmlNode.SelectSingleNode('DocumentNo', TempXmlNode) then
                    if TempXmlNode.IsXmlElement then
                        if tempXmlNode.AsXmlElement().InnerText() <> '' then
                            DocumentNo := TempXmlNode.AsXmlElement().InnerText();
                //BC Upgrade GUNREM01 <<
            end else begin
                //HEI.05<<

                if LineNo = 10000 then //HEI.02
                    DocumentNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", TempPostingDate, false)
                //HEI.02<<
                else begin
                    GenJournalLine3.RESET();
                    GenJournalLine3.SETRANGE("Journal Template Name", JournalTemplate);
                    GenJournalLine3.SETRANGE("Journal Batch Name", JournalBatch);
                    GenJournalLine3.SETRANGE("Document No.", DocumentNo);
                    if GenJournalLine3.FINDLAST() then begin
                        if GenJournalLine3."Document No." <> '' then
                            DocumentNo := GenJournalLine3."Document No."
                        else
                            DocumentNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", TempPostingDate, false);
                    end else
                        DocumentNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", TempPostingDate, false);
                end;
                //HEI.02>>
            end; //HEI.05

            // Update fields on API Log
            APIInterfaceLog.FIND();
            APIInterfaceLog."Source No." := DocumentNo;
            //HEI.02>>
            //Check if External Document No. exist and update Message ID
            //BC Upgrade GUNREM01 >>
            // TempXmlNode := PaymentXmlNode.SelectSingleNode('ExternalDocumentNo');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         APIInterfaceLog."Message ID" := UPPERCASE(TempXmlNode.InnerText);

            if PaymentXmlNode.SelectSingleNode('ExternalDocumentNo', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        APIInterfaceLog."Message ID" := UpperCase(TempXmlNode.AsXmlElement().InnerText());
            //BC Upgrade GUNREM01 <<s

            //Check Source System Identifier
            //HEI.05>>
            //TempXmlNode := PaymentXmlNode.SelectSingleNode('SourceSystemIdentifier');
            //IF NOT ISNULL(TempXmlNode) THEN
            //IF TempXmlNode.InnerText <> '' THEN
            //APIInterfaceLog."Source System Identifier" := TempXmlNode.InnerText;
            APIInterfaceLog."Source System Identifier" := SourceSystemIdentifierAPI.Code;
            GenJournalLine.VALIDATE("Source System Identifier FND", SourceSystemIdentifierAPI.Code);
            //HEI.05<<

            //Update Jnl. Template and Batch
            APIInterfaceLog."Payment Jnl Template" := JournalTemplate;
            APIInterfaceLog."Payment Jnl Batch" := JournalBatch;
            //HEI.02<<
            APIInterfaceLog.MODIFY();
            COMMIT();

            GenJournalLine.VALIDATE("Journal Template Name", JournalTemplate);
            GenJournalLine.VALIDATE("Journal Batch Name", JournalBatch);
            GenJournalLine.VALIDATE("Line No.", LineNo);
            GenJournalLine.INSERT(true);
            LineNo += 10000;

            GenJournalLine.VALIDATE("Document No.", DocumentNo);
            GenJournalLine.VALIDATE("Bal. Account No.", BalAccountNo);

            GenJournalLine.VALIDATE("Posting Date", TempPostingDate);

            // TempXmlNode := PaymentXmlNode.SelectSingleNode('DocumentType');
            // if not ISNULL(TempXmlNode) then begin
            //     if TempXmlNode.InnerText <> '' then begin
            //         EVALUATE(TempDocumentType, TempXmlNode.InnerText)
            if PaymentXmlNode.SelectSingleNode('DocumentType', TempXmlNode) then
                if TempXmlNode.IsXmlElement then begin
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then begin
                        Evaluate(TempDocumentType, TempXmlNode.AsXmlElement().InnerText());
                        //BC Upgrade GUNREM01 <<
                        GenJournalLine.VALIDATE("Document Type", TempDocumentType);
                    end else
                        GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);
                end else
                    GenJournalLine.VALIDATE("Document Type", GenJournalLine."Document Type"::Payment);

            GetNodeByXPath('ExternalDocumentNo', 'ExternalDocumentNo', PaymentXmlNode, TempXmlNode);
            //BC Upgrade GUNREM01 >>
            // GenJournalLine.VALIDATE("External Document No.", TempXmlNode.InnerText);
            GenJournalLine.Validate("External Document No.", TempXmlNode.AsXmlElement().InnerText);
            //BC Upgrade GUNREM01 <<
            //BC Upgrade GUNREM01 >>
            // TempXmlNode := PaymentXmlNode.SelectSingleNode('AccountyType');
            // if not ISNULL(TempXmlNode) then begin
            //     if TempXmlNode.InnerText <> '' then begin
            //         EVALUATE(TempAccountType, TempXmlNode.InnerText);

            if PaymentXmlNode.SelectSingleNode('AccountyType', TempXmlNode) then
                if TempXmlNode.IsXmlElement then begin
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then begin
                        Evaluate(TempAccountType, TempXmlNode.AsXmlElement().InnerText());
                        //BC Upgrade GUNREM01 <<
                        GenJournalLine.VALIDATE("Account Type", TempAccountType);
                    end else
                        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);
                end else
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::Customer);

            GenJournalLine.SetHideValidation(true);

            GetNodeByXPath('AccountNo', 'AccountNo', PaymentXmlNode, TempXmlNode);
            //HEI.02>>
            //BC Upgrade GUNREM01 >>
            //  Customer.GET(TempXmlNode.InnerText);
            CustomerCode := TempXmlNode.AsXmlElement().InnerText();
            Customer.GET(CustomerCode);
            //BC Upgrade GUNREM01 <<
            if BillToCustomer.GET(Customer."Bill-to Customer No.") then
                GenJournalLine.VALIDATE("Account No.", BillToCustomer."No.")
            else
                //HEI.02<<
                //BC Upgrade GUNREM01 >>
                // GenJournalLine.VALIDATE("Account No.", TempXmlNode.InnerText);
                GenJournalLine.VALIDATE("Account No.", TempXmlNode.AsXmlElement().InnerText);
            //BC Upgrade GUNREM01 <<
            GenJournalLine.VALIDATE(Description, JournalBatch); //HEI.05

            GetNodeByXPath('Amount', 'Amount', PaymentXmlNode, TempXmlNode);
            //BC Upgrade GUNREM01 >>
            // EVALUATE(TempAmount, TempXmlNode.InnerText);
            EVALUATE(TempAmount, TempXmlNode.AsXmlElement().InnerText);
            //BC Upgrade GUNREM01 <<
            //HEI.02>>
            if GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund then
                GenJournalLine.VALIDATE(Amount, TempAmount)
            else
                //HEI.02<<
                GenJournalLine.VALIDATE(Amount, -TempAmount);

            //HEI.03>>
            // TempXmlNode := PaymentXmlNode.SelectSingleNode('CurrencyCode');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         if GeneralLedgerSetup."LCY Code" <> TempXmlNode.InnerText then //HEI.05
            //             GenJournalLine.VALIDATE("Currency Code", TempXmlNode.InnerText);
            if PaymentXmlNode.SelectSingleNode('CurrencyCode', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        if GeneralLedgerSetup."LCY Code" <> TempXmlNode.AsXmlElement().InnerText then //HEI.05
                            GenJournalLine.VALIDATE("Currency Code", TempXmlNode.AsXmlElement().InnerText);                        //HEI.03<<

            // TempXmlNode := PaymentXmlNode.SelectSingleNode('AmountLCY');
            // //HEI.09>>
            // if not ISNULL(TempXmlNode) and (GenJournalLine."Currency Code" <> '') and (TempAmount = 0) then
            //     //HEI.09<<
            //     if TempXmlNode.InnerText <> '' then begin
            //         EVALUATE(TempAmountLCY, TempXmlNode.InnerText);

            if PaymentXmlNode.SelectSingleNode('AmountLCY', TempXmlNode) then begin // SHUKLP03 <<
                if TempXmlNode.IsXmlElement then begin
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then begin
                        Evaluate(TempAmountLCY, TempXmlNode.AsXmlElement().InnerText());
                        //HEI.02>>
                        //HEI.09>>
                        if GenJournalLine."Currency Code" <> '' then begin
                            Currency.GET(GenJournalLine."Currency Code");
                            TempAmount := ROUND(
                                            CurrExchRate.ExchangeAmtLCYToFCY(
                                              GenJournalLine."Posting Date", GenJournalLine."Currency Code",
                                              TempAmountLCY, GenJournalLine."Currency Factor"),
                                            Currency."Amount Rounding Precision");
                        end else
                            TempAmount := TempAmountLCY;

                        if GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund then
                            GenJournalLine.VALIDATE(Amount, TempAmount)
                        else
                            GenJournalLine.VALIDATE(Amount, -TempAmount);

                        // IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund THEN
                        //  GenJournalLine.VALIDATE("Amount (LCY)",TempAmountLCY)
                        // ELSE
                        // //HEI.02<<
                        //  GenJournalLine.VALIDATE("Amount (LCY)",-TempAmountLCY);
                        //HEI.09<<
                    end;
                end; // BC Upgrade SHUKLP03 <<
            end; // BC Upgrade SHUKLP03 <<
                 //HEI.03>>
                 //TempXmlNode := PaymentXmlNode.SelectSingleNode('CurrencyCode');
                 //IF NOT ISNULL(TempXmlNode) THEN
                 //IF TempXmlNode.InnerText <> '' THEN
                 //GenJournalLine.VALIDATE("Currency Code",TempXmlNode.InnerText);
                 //HEI.03<<

            //BC Upgrade GUNREM01  "Item Charge Type" is DIT Field >>
            // TempXmlNode := PaymentXmlNode.SelectSingleNode('ItemChargeType');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then begin
            //         EVALUATE(TempItemChargeType, TempXmlNode.InnerText);
            //         GenJournalLine.VALIDATE("Item Charge Type", TempItemChargeType);
            //     end;
            //BC Upgrade GUNREM01  "Item Charge Type" is DIT Field <<
            //BC Upgrade GUNREM01 >>
            // TempXmlNode := PaymentXmlNode.SelectSingleNode('PaymentMethod');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         GenJournalLine.VALIDATE("Payment Method Code", TempXmlNode.InnerText);

            if PaymentXmlNode.SelectSingleNode('PaymentMethod', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        GenJournalLine.VALIDATE("Payment Method Code", TempXmlNode.AsXmlElement().InnerText);
            //BC Upgrade GUNREM01 <<

            //BC Upgrade GUNREM01 >>
            // TempXmlNode := PaymentXmlNode.SelectSingleNode('AppliesToID');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> ''
            if PaymentXmlNode.SelectSingleNode('AppliesToID', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then begin //HEI.02
                                                                               //HEI.03>>
                                                                               //BC Upgrade GUNREM01 <<
                        SalesOrderFound := false;
                        OpenSalesOrder := false; //HEI.05
                        GenJournalTemplate.GET(JournalTemplate);
                        //IF GenJournalTemplate."SO Cash Application" THEN BEGIN //HEI.05
                        SalesHeader.RESET();
                        SalesHeaderArchive.RESET();
                        if GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment then begin
                            SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                        end else if GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund then begin
                            SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::"Return Order");
                            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Return Order");
                        end;
                        //  SalesHeaderArchive.SETRANGE("No.", TempXmlNode.InnerText);
                        SalesHeaderArchive.SETRANGE("No.", TempXmlNode.AsXmlElement().InnerText); //BC Upgrade GUNREM01 

                        if SalesHeaderArchive.FINDFIRST() then begin
                            SalesOrderFound := true;
                            if GenJournalTemplate."SO Cash Application FND" then //HEI.05
                                GenJournalLine.VALIDATE("Sales/Archived Order Type FND", GenJournalLine."Sales/Archived Order Type FND"::"Archived Sales Order");
                        end else begin
                            //   SalesHeader.SETRANGE("No.", TempXmlNode.InnerText);
                            SalesHeader.SETRANGE("No.", TempXmlNode.AsXmlElement().InnerText); //BC Upgrade GUNREM01

                            if SalesHeader.FINDFIRST() then begin
                                SalesOrderFound := true;
                                //HEI.05>>
                                OpenSalesOrder := true;
                                if GenJournalTemplate."SO Cash Application FND" then
                                    //HEI.05<<
                                    GenJournalLine.VALIDATE("Sales/Archived Order Type FND", GenJournalLine."Sales/Archived Order Type FND"::"Sales Order");
                            end;
                        end;
                        //HEI.05>>
                        if not SalesOrderFound then begin
                            RelatedSalesOrderNo := '';
                            SalesHeaderArchive.SETRANGE("No.");
                            // SalesHeaderArchive.SETRANGE("External Document No.", TempXmlNode.InnerText);
                            SalesHeaderArchive.SETRANGE("External Document No.", TempXmlNode.AsXmlElement().InnerText);  //BC Upgrade GUNREM01
                            if SalesHeaderArchive.FINDFIRST() then begin
                                SalesOrderFound := true;
                                RelatedSalesOrderNo := SalesHeaderArchive."No.";
                                if GenJournalTemplate."SO Cash Application FND" then
                                    GenJournalLine.VALIDATE("Sales/Archived Order Type FND", GenJournalLine."Sales/Archived Order Type FND"::"Archived Sales Order");
                            end else begin
                                SalesHeader.SETRANGE("No.");
                                // SalesHeader.SETRANGE("External Document No.", TempXmlNode.InnerText);
                                SalesHeader.SETRANGE("External Document No.", TempXmlNode.AsXmlElement().InnerText); //BC Upgrade GUNREM01
                                if SalesHeader.FINDFIRST() then begin
                                    SalesOrderFound := true;
                                    OpenSalesOrder := true;
                                    RelatedSalesOrderNo := SalesHeader."No.";
                                    if GenJournalTemplate."SO Cash Application FND" then
                                        GenJournalLine.VALIDATE("Sales/Archived Order Type FND", GenJournalLine."Sales/Archived Order Type FND"::"Sales Order");
                                end;
                            end;
                        end;
                        //HEI.05<<
                        if SalesOrderFound then begin
                            //HEI.05>>
                            if OpenSalesOrder then begin
                                SalesHeader.VALIDATE("Applies-to Doc. Type", SalesHeader."Applies-to Doc. Type"::Payment);
                                SalesHeader.VALIDATE("Applies-to Doc. No.", GenJournalLine."Document No.");
                                SalesHeader.MODIFY();
                            end;

                            if GenJournalTemplate."SO Cash Application FND" then begin
                                if RelatedSalesOrderNo <> '' then
                                    GenJournalLine.VALIDATE("Related Sales Order FND", RelatedSalesOrderNo)
                                else
                                    //HEI.05<<
                                    // GenJournalLine.VALIDATE("Related Sales Order", TempXmlNode.InnerText);
                                    GenJournalLine.VALIDATE("Related Sales Order FND", TempXmlNode.AsXmlElement().InnerText);

                                //BC Upgrade GUNREM01
                            end;
                            //HEI.05>>
                            //END ELSE BEGIN
                        end;
                        //END;
                        //HEI.05<<
                        //HEI.03<<

                        // GenJournalLine.VALIDATE("Applies-to ID", TempXmlNode.InnerText);
                        GenJournalLine.VALIDATE("Applies-to ID", TempXmlNode.AsXmlElement().InnerText);

                        //BC Upgrade GUNREM01
                        //HEI.02>>
                        if GenJournalLine."Document Type" = GenJournalLine."Document Type"::Payment then begin //HEI.04
                            SalesInvoiceHeader.SETRANGE("External Document No.", GenJournalLine."Applies-to ID");
                            //HEI.05>>
                            //IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                            SalesInvoiceHeader2.SETRANGE("Order No.", GenJournalLine."Applies-to ID");
                            if SalesInvoiceHeader.FINDFIRST() or SalesInvoiceHeader2.FINDFIRST() then begin
                                //HEI.05<<
                                GenJournalLine."Applies-to ID" := '';
                                GenJournalLine.VALIDATE("Applies-to Doc. Type", GenJournalLine."Applies-to Doc. Type"::Invoice);
                                if SalesInvoiceHeader."No." <> '' then //HEI.05
                                    GenJournalLine.VALIDATE("Applies-to Doc. No.", SalesInvoiceHeader."No.")
                                //HEI.05>>
                                else
                                    GenJournalLine.VALIDATE("Applies-to Doc. No.", SalesInvoiceHeader2."No.");
                                //HEI.05<<
                            end;
                        end else if GenJournalLine."Document Type" = GenJournalLine."Document Type"::Refund then begin //HEI.04
                            SalesCrMemoHeader.SETRANGE("External Document No.", GenJournalLine."Applies-to ID");
                            //HEI.05>>
                            //IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                            SalesCrMemoHeader2.SETRANGE("Return Order No.", GenJournalLine."Applies-to ID");
                            if SalesCrMemoHeader.FINDFIRST() or SalesCrMemoHeader2.FINDFIRST() then begin
                                //HEI.05<<
                                GenJournalLine."Applies-to ID" := '';
                                GenJournalLine.VALIDATE("Applies-to Doc. Type", GenJournalLine."Applies-to Doc. Type"::"Credit Memo");
                                if SalesCrMemoHeader."No." <> '' then //HEI.05
                                    GenJournalLine.VALIDATE("Applies-to Doc. No.", SalesCrMemoHeader."No.")
                                //HEI.05>>
                                else
                                    GenJournalLine.VALIDATE("Applies-to Doc. No.", SalesCrMemoHeader2."No.");
                                //HEI.05<<
                            end;
                        end;
                        //HEI.05>>
                        //END; //HEI.03
                        if (GenJournalLine."Applies-to Doc. Type" = GenJournalLine."Applies-to Doc. Type"::" ") and
                           (GenJournalLine."Applies-to Doc. No." = '')
                        then
                            GenJournalLine.VALIDATE("Applies-to ID", '');
                        //HEI.05<<
                    end;
            //HEI.02<<
            GenJournalLine.MODIFY(true);

            //HEI.05>>
            if APIInterfaceLog.Manual then
                APIInterfaceLog.ReprocessPosting(true);
            //HEI.05<<
        end;

        //HEI.06>>
        CLEAR(RequestXmlDocument);
        CLEAR(PaymentsXmlNode);
        CLEAR(PaymentXmlNode);
        CLEAR(TempXmlNode);
        CLEAR(PaymentsXmlNodeList);
        //HEI.06<<
        CLEAR(RequestInStream); //HEI.07
    end;
    // end;
    // local procedure GetNodeByXPath(XPath: Text; NodeName: Text; var ParentXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; var XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    local procedure GetNodeByXPath(XPath: Text; NodeName: Text; var ParentXmlNode: XmlNode; var ResultXmlNode: XmlNode)
    begin

        if ParentXmlNode.SelectSingleNode(XPath, ResultXmlNode) then
            if not ResultXmlNode.IsXmlElement() then
                Error(MissingNodeErr, NodeName);

        if ResultXmlNode.AsXmlElement().InnerText() = '' then
            Error(TextMissingErr, NodeName);
    end;
}

