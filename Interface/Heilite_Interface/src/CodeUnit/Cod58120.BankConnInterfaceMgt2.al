codeunit 58120 "Bank Conn. Interface Mgt. 2"
{
    // version HEI.38

    // HEI.01 CHG2119688 IBM POENAB02 20.01.2023 HB2428 Panama CITI - bank connectivity payment file
    //   # Object created
    //   # Object initialy created in 2021, but due to some changes under HEI.01, the date was changed.
    // HEI.02 CHG2119046 IBM POENAB02 13.10.2021 HB2184 Ethiopia CBE - bank connectivity payment file
    //   # Modified functions CreateNonSepaPayment, CreateNonSepaContentEthiopiaCBE, ExportTransactionInformationEthiopiaCBE, ExportPaymentInformationEthiopiaCBE
    // HEI.03 CHG2181582 IBM SRIVAS07 16.03.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # Created Function -
    //     -CreateNonSepaContentMZ()
    //     -ExportTransactionInformationMZ()
    //     -ExportPaymentInformationMZ()
    //     -FinishGroupHeaderMZ
    //   # Code Added - CreateNonSepaPayment()
    // HEI.04 CHG2181582 IBM SRIVAS07 20.03.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # Code Added - CreateNonSepaContentMZ()
    // HEI.05 CHG2181582 IBM SRIVAS07 29.03.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # Code Added - ExportTransactionInformationMZ() - Text Length Change
    //   # Code Added -ExportPaymentInformationMZ() - Text Length Change
    //   # Code Added -FinishGroupHeaderMZ - Text Length Change
    // HEI.06 CHG2181582 IBM SRIVAS07 14.04.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # Code Added - ExportTransactionInformationMZ
    // HEI.07 CHG2189683 IBM POENAB02 28.04.2023 HB3090 Ethiopia CBE - bank connectivity payment file
    //   # Code added in CreateNonSepaContentEthiopiaCBE, ExportTransactionInformationEthiopiaCBE
    //   # New function: FinishGroupHeaderEthiopiaCBE
    // HEI.08 CHG2200548 IBM POENAB02 10.05.2023 HB3432 Panama CITI EUR - bank connectivity payment file
    //   # Code added in ExportPaymentInformationPanama, ExportTransactionInformationPanama
    // HEI.09 CHG2181582 IBM SRIVAS07 25.05.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # Code Added - ExportTransactionInformationMZ
    // HEI.10 CHG2190076 HB3104 IBM SRIVAS07 05-06-2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # Created Function -
    //     -Name are -
    //         -FinishGroupHeaderEthiopiaCBE()
    //         -CreateNonSepaContentMZCBE()
    //         -ExportTransactionInformationMZCBE()
    //         -ExportPaymentInformationMZCBE()
    //         -FinishGroupHeaderMZCBE()
    //         -SwiftCodeCheck()
    //         -BankDetailsCheck()
    //   # Code Added - CreateNonSepaPayment()
    //   # Code Added - ExportTransactionInformationMZ()
    //   # Code Added - ExportTransactionInformationMZCBE()
    // HEI.11 CHG2207795 IBM POENAB02 08.06.2023 Panama Bank Connectivity - Special characters to be converted also in Post Code
    //   # Modified functions ExportPaymentInformationPanama, ExportTransactionInformationPanama
    // HEI.12 CHG2200548 IBM POENAB02 08.06.2023 HB3432 Panama CITI EUR - bank connectivity payment file
    //   # Modified function ExportTransactionInformationPanama
    // HEI.13 CHG2200548 IBM POENAB02 16.06.2023 HB3432 Panama CITI EUR - bank connectivity payment file
    //   # Modified function ExportTransactionInformationPanama
    // HEI.14 CHG2200548 IBM POENAB02 20.06.2023 HB3432 Panama CITI EUR - bank connectivity payment file
    //   # Modified function ExportTransactionInformationPanama
    // HEI.15 CHG2200548 IBM POENAB02 26.06.2023 HB3432 Panama CITI EUR - bank connectivity payment file
    //   # Modified function ExportTransactionInformationPanama
    //   # Changed the source for Vendor Invoice No. to table 81
    // HEI.16 CHG2190076 HB3104 IBM SRIVAS07 27/06/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # Code added ExportTransactionInformationMZCBE()
    //   # Code added ExportPaymentInformationMZCBE()
    //   # Code added BankDetailsCheck()
    // HEI.17 CHG2200548 IBM POENAB02 28.06.2023 HB3432 Panama CITI EUR - bank connectivity payment file
    //   # Modified function ExportTransactionInformationPanama
    // HEI.18 CHG2200548 IBM POENAB02 19.07.2023 HB3432 Panama CITI EUR - bank connectivity payment file
    //   # Modified function ValidatePaymentContentPanama
    // HEI.19 CHG2190076 HB3104 IBM SRIVAS07 26/07/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # Code added CreateNonSepaPayment()
    //   # Code added ExportTransactionInformationMZCBE()
    // HEI.20 CHG2190076 HB3104 IBM SRIVAS07 09/08/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # Code added CreateNonSepaPayment()
    //   # Code added BankDetailsCheck()
    // HEI.21 CHG2190076 HB3104 IBM SRIVAS07 16/10/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # Code added CreateNonSepaContentMZCBE()
    //   # Created new function - CheckNewGroupMZCBE()
    //   # Created new function - NewConsolidatedPaymentMZCBE()
    // HEI.22 CHG2190076 HB3104 IBM SRIVAS07 26/10/23 - Mozambique bank connectivity -  outgoing payments (Standard Bank - cross border)
    //   # Code added CreateNonSepaPayment()
    //   # Code added BankDetailsCheck()
    // HEI.23 CHG2241296 IBM SRIVAS07 27/02/2024 # CC Bank Conn Payment File error
    //   # Code added ExportTransactionInformationMZ()
    //   # Code added ExportPaymentInformationMZ()
    // HEI.24 CHG2237440 HB3573 IBM SRIVAS07 17/04/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //   # Code Modified CreateNonSepaPayment()
    //   # New function created
    //       -StartGroupHeaderAlgeriaDFT()
    //       -ValidatePaymentContentAlgeriaDFT()
    //       -CreateNonSepaContentAlgeriaDFT()
    //       -ExportPaymentInformationAlgeriaDFT()
    //       -ExportTransactionInformationAlgeriaDFT()
    //       -FinishGroupHeaderAlgeriaDFT()
    //       -StartGroupHeaderAlgeriaBKT()
    //       -ValidatePaymentContentAlgeriaBKT()
    //       -CreateNonSepaContentAlgeriaBKT()
    //       -ExportPaymentInformationAlgeriaBKT()
    //       -ExportTransactionInformationAlgeriaBKT()
    //       -FinishGroupHeaderAlgeriaBKT()
    // HEI.25 CHG2237440 HB3573 IBM SRIVAS07 13/05/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //   # Code Modified CreateNonSepaContentAlgeriaDFT()
    //   # Code Modified CreateNonSepaContentAlgeriaBKT()
    // HEI.26 CHG2237440 HB3573 IBM SRIVAS07 21/05/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //   # Code Modified ExportPaymentInformationAlgeriaBKT()
    //   # Code Modified ExportPaymentInformationAlgeriaDFT()
    //   # Code Modified ExportTransactionInformationAlgeriaDFT()
    // HEI.27 CHG2237440 HB3573 IBM SRIVAS07 23/05/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //   # Code modified ExportTransactionInformationAlgeriaBKT
    //   # Code modified ExportTransactionInformationAlgeriaDFT
    // HEI.28 CHG2236071 IBM POENAB02 10.06.2024 Bank connectivity Bahamas - Citi Bank
    //   # Modified function: CreateNonSepaPayment
    //   # New functions: CreateNonSepaContentBahamas440, CreateNonSepaContentBahamas441, CreateNonSepaContentBahamas442, ExportTransactionInformationBahamas440,
    //       ExportTransactionInformationBahamas441, ExportTransactionInformationBahamas442, ExportPaymentInformationBahamas440, ExportPaymentInformationBahamas441,
    //       ExportPaymentInformationBahamas442, StartGroupHeaderBahamas440, StartGroupHeaderBahamas441, StartGroupHeaderBahamas442, FinishGroupHeaderBahamas440,
    //       FinishGroupHeaderBahamas441, FinishGroupHeaderBahamas442, ValidatePaymentContentBahamas440, ValidatePaymentContentBahamas441, ValidatePaymentContentBahamas442
    // HEI.29 CHG2237440 HB3573 IBM SRIVAS07 14/06/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //   # Code Modified CreateNonSepaPayment()
    // HEI.30 CHG2236071 IBM POENAB02 28.06.2024 Bank connectivity Bahamas - Citi Bank
    //   # Modified functions: FinishGroupHeaderBahamas440, FinishGroupHeaderBahamas441, FinishGroupHeaderBahamas442, ExportTransactionInformationBahamas441
    // HEI.31 CHG2237440 HB3573 IBM SRIVAS07 11/07/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //   # Code Modified ValidatePaymentContentAlgeria_V3()
    // HEI.32 CHG2237440 HB3573 IBM SRIVAS07 17/07/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //   # Code Modified ExportTransactionInformationAlgeria_V3()
    // HEI.33 CHG2237440 HB3573 IBM SRIVAS07 18/07/2024 # Development-Algeria Bank Connectivity - Citi Bank local payment file development
    //   # Code Modified ExportTransactionInformationAlgeria_V3()
    //   # Code Modified ValidatePaymentContentAlgeria_V3()
    // HEI.34 CHG2236071 IBM POENAB02 23.07.2024 Bank connectivity Bahamas - Citi Bank
    //   # Modified function: ExportTransactionInformationBahamas441
    // HEI.35 CHG2262634 IBM SRIVAS07 05/08/2024 # CC Bank connectivity - spaces in address lines - DFT payment file reconfiguration - Development
    //   # Code Modified ExportTransactionInformationAlgeria_V3()
    // HEI.36 CHG2236071 IBM POENAB02 21.08.2024 Bank connectivity Bahamas - Citi Bank
    //   # Modified function: ExportTransactionInformationBahamas440, ExportTransactionInformationBahamas441, ExportTransactionInformationBahamas442
    // HEI.37 CHG2271685 IBM POENAB02 09.10.2024 Bahamas – bank connectivity – change in the payment files
    //   # Modified functions ExportTransactionInformationBahamas440, ExportTransactionInformationBahamas441, to change the logic of exporting MmbId and BranchId
    // HEI.38 CHG2280201 IBM POENAB02 13.12.2024 Bahamas Bank connectivity_filter remover
    //   # Modified functions ValidatePaymentContentBahamas440, ValidatePaymentContentBahamas441
    // HEI.40 CHG2324109 IBM POENAB02 22.10.2025 HB4446 Name change payment file mapping
    //   # Modified Bahamas payment files
    //   # Modified functions: ExportPaymentInformationBahamas440, ExportPaymentInformationBahamas441, ExportPaymentInformationBahamas442


    //BC UPGRADE KUMARR78 >>
    // Old Codeunit ID 50204 - "Bank Conn. Interface Mgt. 2"
    // Type: Processing Codeunit
    // 1. REMOVED DOTNET DEPENDENCIES
    // ----------------------------------------------------------------------------
    //
    // OLD (NAV OnPrem):
    //   - XMLDomDoc: DotNet System.Xml.XmlDocument
    //   - XMLDomDocLocal: DotNet System.Xml.XmlDocument
    //   - CstmrCdtTrfInitnNode: DotNet XmlNode
    //   - PmtInfNode: DotNet XmlNode
    //   - OwnerDocument.CreateNode()
    //   - CreateAttribute()
    //   - SelectSingleNode()
    //   - ParentNode navigation
    //   - XMLDomDoc.Save()
    //   - XML DOM Management Codeunit
    //   - ServerTempFileName / ClientTempFileName
    //   - RBMgt.DownloadToFile
    //
    // 2. REPLACED WITH NATIVE AL XML
    // ----------------------------------------------------------------------------
    //
    // NEW (Business Central SaaS):
    //    XmlDocument
    //    XmlElement
    //    XmlNode
    //    XmlDeclaration
    //    XmlText
    //    XmlDocument.ReadFrom()
    //    XmlDocument.WriteTo()
    //    XmlElement.Create()
    //    XmlText.Create()
    //    XmlElement.SetAttribute()
    //    XmlNode.AsXmlElement()
    //    Codeunit "Temp Blob"
    //    BLOB OutStream streaming
    //BC UPGRADE KUMARR78 <<


    // BC Upgrade MISHRS14 >>
    // Changed table name to "Non Sepa Response Log FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<


    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Electronic Banking Setup" to "Electronic Banking Setup FND".
    // # Tag HEI.40 Added to documentation and added code related to it in functions ExportPaymentInformationBahamas440,ExportPaymentInformationBahamas441 and ExportPaymentInformationBahamas442
    // BC UPGRADE PATELS08 <<

    //BC UPGRADE ATHUKUS01>>
    //1.Rewrite Main function CreateNonSepaContentMZ and sub functions(ExportTransaction,Paymentinformation,StartHeader and Finishheader) for XML file structure.
    //2.Rewrite Main function CreateNonSepaContentMZCBE and sub functions(ExportTransaction,Paymentinformation,StartHeader and Finishheader) for XML file structure..
    //3.Rewrite Main function CreateNonSepaContentPanama and sub functions(ExportTransaction,Paymentinformation,StartHeader and Finishheader) for XML file structure..
    //4.Rewrite Main function CreateNonSepaContentEthiopiaCBE and sub functions(ExportTransaction,Paymentinformation,StartHeader and Finishheader) for XML file structure..
    //5.Rewrite Main function CreateNonSepaContentAlgeria_V3 and sub functions(ExportTransaction,Paymentinformation,StartHeader and Finishheader) for XML file structure..
    //6.Rewrite Main function CreateNonSepaContentBahamas440 and sub functions(ExportTransaction,Paymentinformation,StartHeader and Finishheader) for XML file structure..
    //7.Rewrite Main function CreateNonSepaContentBahamas441 and sub functions(ExportTransaction,Paymentinformation,StartHeader and Finishheader) for XML file structure..
    //8.Rewrite Main function CreateNonSepaContentBahamas442 and sub functions(ExportTransaction,Paymentinformation,StartHeader and Finishheader) for XML file structure..
    //BC UPGRADE ATHUKUS01<< 



    trigger OnRun();
    begin
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesSetupRead: Boolean;
        BankConnInterfaceSetupRead: Boolean;
        BankConnInterfaceSetup: Record "Bank Conn. Interface Setup INT";
        GeneralInterfaceSetupRead: Boolean;
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        BankExportImportSetupRead: Boolean;
        BankExportImportSetup: Record "Bank Export/Import Setup";
        XMLNodeCurr: XmlNode;

        //BC UPGRADE KUMARR78 >> Blocking DOTNET variables.
        // XMLDomDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // CstmrCdtTrfInitnNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // PmtInfNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking DOTNET variables.

        //BC UPGRADE KUMARR78 >> Adding Replacment for DOTNET variables.
        XMLDomDoc: XmlDocument;
        CstmrCdtTrfInitnNode: XmlNode;
        PmtInfNode: XmlNode;
        //BC UPGRADE KUMARR78 << Adding Replacment for DOTNET variables.

        MessageId: Text[35];
        NumberOfTransactions: Integer;
        CompanyInfo: Record "Company Information";
        Currency: Record Currency;
        VendorBankAcc: Record "Vendor Bank Account";
        Country: Record "Country/Region";
        Vendor: Record Vendor;
        CustomerBankAcc: Record "Customer Bank Account";
        Customer: Record Customer;
        PaymentInformationCounter: Integer;
        BankAcc: Record "Bank Account";
        ConsolidatedPmtMessage: Text[50];
        // XMLDomDocLocal: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; //BC UPGRADE KUMARR78 Variable not in Use.
        SaveToFileName: Text[250];
        RBMgt: Codeunit "File Management";
        FileName: Text[250];
        FullFileName: Text[250];
        SaveToFileNameClient: Text[250];
        ConsolidatedPmtJnlLine: Record "Gen. Journal Line BC FND";
        EBSetup: Record "Electronic Banking Setup FND";
        GMessageId: Code[20];
        GeneralLedgerSetup: Record "General Ledger Setup";
        BankConnReplaceCharacters: Record "Bank Conn.- Replace Char. FND";
        FinalXmlNode: XmlNode;

    procedure CreateNonSepaPayment(GenJournalLine: Record "Gen. Journal Line BC FND");
    var
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        lContent: Text;
        ltext001: Label 'Success!';
        lCreditTransferRegister: Record "Credit Transfer Register";
        lCreditTransferEntry: Record "Credit Transfer Entry";
        BankAccountMZ: Record "Bank Account";
        AccountCount: Label 'Bank Account No should be of 13 digits for Bank - %1';
        BOPError: Label 'BOP Code is mandatory for standard bank International payment and it should not be blank in "Bank Export/Import Setup"';
    begin
        GeneralLedgerSetup.GET;

        CLEAR(InterfaceSetup);
        GetGeneralInterfaceSetup;
        GetBankConnInterfaceSetup;
        CompanyInfo.GET;
        EBSetup.GET;

        GetBankExportImportSetup(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name");

        BankConnInterfaceSetup.TESTFIELD("Non-SEPA Outbound Interface");
        InterfaceSetup.GET(BankConnInterfaceSetup."Non-SEPA Outbound Interface");

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeader);
        InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Outbound;
        InterfaceEntryHeader.Status := InterfaceEntryHeader.Status::Pending;
        InterfaceEntryHeader."Interface Code" := BankConnInterfaceSetup."Non-SEPA Outbound Interface";
        InterfaceEntryHeader."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeader."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeader."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
        InterfaceEntryHeader."Source System ID" := OutboundInterface."Logical System ID";
        InterfaceEntryHeader."Company Code ID" := GeneralInterfaceSetup."Company Code ID";

        BankExportImportSetup.TESTFIELD("MESTYPE FND");
        BankExportImportSetup.TESTFIELD("MESCOD FND");
        BankExportImportSetup.TESTFIELD("MESFCT FND");
        BankConnInterfaceSetup.TESTFIELD(SNDPRN);

        IF BankExportImportSetup."OPCO FND" <> BankExportImportSetup."OPCO FND"::Algeria THEN BEGIN //HEI.24
            CompanyInfo.TESTFIELD("Bank Account No.");
            CompanyInfo.TESTFIELD("Bank Branch No.");
            CompanyInfo.TESTFIELD("Country/Region Code");
        END; //HEI.24

        BankExportImportSetup.TESTFIELD("File Prefix FND");
        BankExportImportSetup.TESTFIELD("Export No. Series FND");

        //MESTYPE
        InterfaceEntryHeader.Name := BankExportImportSetup."MESTYPE FND";

        //MESCOD
        InterfaceEntryHeader.Address := BankExportImportSetup."MESCOD FND";

        //MESFCT
        InterfaceEntryHeader."Address 2" := BankExportImportSetup."MESFCT FND";

        //SNDPRN
        InterfaceEntryHeader.Contact := BankConnInterfaceSetup.SNDPRN;
        //HEI.03>>
        //Mozambique - MZ
        IF BankExportImportSetup."OPCO FND" = BankExportImportSetup."OPCO FND"::MZ THEN BEGIN
            BankExportImportSetup.TESTFIELD("User ID Tag FND");
            GenJournalLine.TESTFIELD("HNK Bank Account");
            BankAccountMZ.GET(GenJournalLine."HNK Bank Account");
            BankAccountMZ.TESTFIELD("Bank Account No.");
            BankAccountMZ.TESTFIELD("Country/Region Code");
            BankAccountMZ.TESTFIELD("SWIFT Code");
            IF STRLEN(BankAccountMZ."Bank Account No.") <> 13 THEN
                ERROR(AccountCount, BankAccountMZ."No.");
            //BankAccountnumber
            InterfaceEntryHeader."External Contract Name" := BankAccountMZ."Bank Account No.";

            //BankKey
            InterfaceEntryHeader.Description := BankAccountMZ."Bank Branch No.";

            //BankCountryKey
            InterfaceEntryHeader."Country/Region Code" := BankAccountMZ."Country/Region Code";

        END ELSE BEGIN
            //HEI.03<<
            //BankAccountnumber
            InterfaceEntryHeader."External Contract Name" := CompanyInfo."Bank Account No.";

            //BankKey
            InterfaceEntryHeader.Description := CompanyInfo."Bank Branch No.";

            //BankCountryKey
            InterfaceEntryHeader."Country/Region Code" := CompanyInfo."Country/Region Code";
        END; //HEI.03
        //FilePrefix
        InterfaceEntryHeader."Source No." := BankExportImportSetup."File Prefix FND";

        InterfaceEntryHeader.INSERT(TRUE);

        CLEAR(InterfaceEntryLine);
        InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryLine."Entry No." := 1;
        InterfaceEntryLine.INSERT;

        //Panama
        IF BankExportImportSetup."OPCO FND" = BankExportImportSetup."OPCO FND"::Panama THEN BEGIN
            ValidatePaymentContentPanama(GenJournalLine);
            CreateNonSepaContentPanama(GenJournalLine, InterfaceEntryLine);
        END;

        //HEI.02>>
        //Ethiopia - CBE
        IF BankExportImportSetup."OPCO FND" = BankExportImportSetup."OPCO FND"::"Ethiopia-CBE" THEN
            CreateNonSepaContentEthiopiaCBE(GenJournalLine, InterfaceEntryLine);
        //HEI.02<<

        //HEI.03>>
        //Mozambique - MZ
        IF BankExportImportSetup."OPCO FND" = BankExportImportSetup."OPCO FND"::MZ THEN
            //HEI.20>>
            // IF (BankAccountMZ."Currency Code" = '') OR (BankAccountMZ."Currency Code"=GeneralLedgerSetup."LCY Code") THEN//HEI.10
            IF NOT BankExportImportSetup."International Payment File FND" THEN
                //HEI.20<<
                CreateNonSepaContentMZ(GenJournalLine, InterfaceEntryLine)
            //HEI.10>>
            ELSE
             //HEI.19>>
             BEGIN
                IF BankExportImportSetup."BOPCode FND" = '' THEN
                    ERROR(BOPError);
                //HEI.19<<
                CreateNonSepaContentMZCBE(GenJournalLine, InterfaceEntryLine);
            END;//HEI.19
        //HEI.10<<
        //HEI.03<<
        //HEI.24>>
        IF BankExportImportSetup."OPCO FND" = BankExportImportSetup."OPCO FND"::Algeria THEN
            CASE BankExportImportSetup."BOPCode FND" OF
                //HEI.29>>
                //'547' :   CreateNonSepaContentAlgeriaBKT(GenJournalLine,InterfaceEntryLine);
                //'574' :   CreateNonSepaContentAlgeriaDFT(GenJournalLine,InterfaceEntryLine);
                '574':
                    BEGIN
                        ValidatePaymentContentAlgeria_V3(GenJournalLine);
                        CreateNonSepaContentAlgeria_V3(GenJournalLine, InterfaceEntryLine);
                    END;
            //HEI.29<<
            END;
        //HEI.24<<

        //HEI.28>>
        IF BankExportImportSetup."OPCO FND" = BankExportImportSetup."OPCO FND"::Bahamas THEN
            CASE BankExportImportSetup."BOPCode FND" OF
                '440':
                    BEGIN
                        ValidatePaymentContentBahamas440(GenJournalLine);//HEI.36
                        CreateNonSepaContentBahamas440(GenJournalLine, InterfaceEntryLine);
                    END;
                '441':
                    BEGIN
                        ValidatePaymentContentBahamas441(GenJournalLine);//HEI.36
                        CreateNonSepaContentBahamas441(GenJournalLine, InterfaceEntryLine);
                    END;
                '442':
                    BEGIN
                        ValidatePaymentContentBahamas442(GenJournalLine);//HEI.36
                        CreateNonSepaContentBahamas442(GenJournalLine, InterfaceEntryLine);
                    END;
            END;
        //HEI.28<<

        InsertNonSepaResponseLog(GenJournalLine, InterfaceEntryHeader, ltext001, FALSE);

        AddInCreditTransferRegister(GenJournalLine, InterfaceEntryHeader, GMessageId);
        AddInCreditTransferEntry(GenJournalLine, InterfaceEntryHeader, GMessageId);
    end;

    procedure ManualSendNonSepaPayments(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        ltext001: Label 'Success!';
    begin
        CLEARLASTERROR;
        COMMIT;
        IF CODEUNIT.RUN(CODEUNIT::"Outbound Interface Processing", InterfaceEntryHeader) THEN BEGIN
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
            InsertNonSepaResponseLog(GenJournalLine, InterfaceEntryHeader, ltext001, FALSE);
        END ELSE BEGIN
            InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GETLASTERRORTEXT);
            InsertNonSepaResponseLog(GenJournalLine, InterfaceEntryHeader, COPYSTR(GETLASTERRORTEXT, 1, 250), TRUE);
        END;
    end;

    local procedure ProcessOutboundJournalEntry(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        COMMIT;
    end;

    local procedure GetBankConnInterfaceSetup();
    begin
        IF NOT BankConnInterfaceSetupRead THEN
            IF BankConnInterfaceSetup.GET THEN;
        BankConnInterfaceSetupRead := TRUE;
    end;

    local procedure GetSalesSetup();
    begin
        IF NOT SalesSetupRead THEN
            SalesSetup.GET;
        SalesSetupRead := TRUE;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        IF NOT GeneralInterfaceSetupRead THEN
            GeneralInterfaceSetup.GET;
        GeneralInterfaceSetupRead := TRUE;
    end;

    local procedure GetBankExportImportSetup(JnlTemplate: Code[10]; JnlBatch: Code[10]);
    begin
        IF NOT BankExportImportSetupRead THEN BEGIN
            BankExportImportSetup.SETRANGE("Journal Template Name FND", JnlTemplate);
            BankExportImportSetup.SETRANGE("Journal Batch Name FND", JnlBatch);
            IF BankExportImportSetup.FINDFIRST THEN;
        END;
        BankExportImportSetupRead := TRUE;
    end;

    local procedure InsertNonSepaResponseLog(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT"; Message: Text[250]; Error: Boolean);
    var
        lNonSepaResponseLog: Record "Non Sepa Response Log FND";
        lEntryNo: Integer;
    begin
        lEntryNo := 1;

        IF lNonSepaResponseLog.FINDLAST THEN
            lEntryNo := lNonSepaResponseLog."Entry No." + 1;

        lNonSepaResponseLog."Entry No." := lEntryNo;
        lNonSepaResponseLog.Date := TODAY;
        lNonSepaResponseLog.Time := TIME;
        lNonSepaResponseLog."Interface Code" := InterfaceEntryHeader."Interface Code";
        lNonSepaResponseLog."Journal Template Name" := GenJournalLine."Journal Template Name";
        lNonSepaResponseLog."Journal Batch Name" := GenJournalLine."Journal Batch Name";
        lNonSepaResponseLog."Journal Line No." := GenJournalLine."Line No.";
        lNonSepaResponseLog."Journal Document No." := GenJournalLine."Document No.";
        lNonSepaResponseLog."Journal Description" := GenJournalLine."Message to Recipient";
        lNonSepaResponseLog.Direction := lNonSepaResponseLog.Direction::Outbound;
        lNonSepaResponseLog."User ID" := USERID;
        lNonSepaResponseLog.Message := Message;
        lNonSepaResponseLog.Error := Error;
        lNonSepaResponseLog."WS MessageID" := GMessageId;
        lNonSepaResponseLog.INSERT;
    end;

    //BC UPGRADE KUMARR78 >> Blocking to Replace Entire Function. 
    // local procedure AddElement(var XMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; NodeName: Text[250]; NodeText: Text[250]; NameSpace: Text[250]; var CreatedXMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"): Boolean;
    // var
    //     NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     NewChildNode := XMLNode.OwnerDocument.CreateNode('element', NodeName, NameSpace);

    //     IF ISNULL(NewChildNode) THEN
    //         EXIT(FALSE);

    //     IF NodeText <> '' THEN
    //         NewChildNode.InnerText := NodeText;
    //     XMLNode.AppendChild(NewChildNode);
    //     CreatedXMLNode := NewChildNode;
    //     EXIT(TRUE);
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Replace Entire Function. 

    //BC UPGRADE KUMARR78 >> Replacing AddElement function Code
    local procedure AddElement(var XMLNode: XmlNode; NodeName: Text[250]; NodeText: Text[250]; NameSpace: Text[250]; var CreatedXMLNode: XmlNode): Boolean
    var
        NewElement: XmlElement;
        NewText: XmlText;
    begin
        if NameSpace <> '' then
            NewElement := XmlElement.Create(NodeName, NameSpace)
        else
            NewElement := XmlElement.Create(NodeName);

        if NodeText <> '' then begin
            NewText := XmlText.Create(NodeText);
            NewElement.Add(NewText);
        end;
        XMLNode.AsXmlElement().Add(NewElement);
        CreatedXMLNode := NewElement.AsXmlNode();
        exit(true);
    end;
    //BC UPGRADE KUMARR78 >> Replacing AddElement function Code

    //BC UPGRADE KUMARR78 << Replacing AddElement function Code

    //BC UPGRADE KUMARR78 >> Blocking to Replace the Code.
    // local procedure StartGroupHeader(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'CreDtTm', Format(CurrentDateTime, 19, 9), '', XMLNewChild);
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Replace the Code.
    //BC UPGRADE KUMARR78 >> Adding Functions Replacment.
    local procedure StartGroupHeader(XMLNodeCurr: XmlNode)
    var
        XMLNewChild: XmlNode;
    begin
        AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'CreDtTm', Format(CurrentDateTime, 0, 9), '', XMLNewChild);
        //BC UPGGRADE ATHKUS01>> 
        Clear(FinalXmlNode);
        FinalXmlNode := XMLNodeCurr;
        //BC UPGGRADE ATHKUS01<<
    end;

    //BC UPGRADE KUMARR78 >> Blocking to Replace Code.
    // procedure FinishGroupHeader();
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     // Insert Number of Transactions and ControlSum in the Group Header
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     XMLNodeCurr := XMLNodeCurr.FirstChild;
    //     XMLNodeCurr := XMLNodeCurr.FirstChild;
    //     AddElement(XMLNodeCurr, 'NbOfTxs', Format(NumberOfTransactions, 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Nm', CompanyInfo.Name, '', XMLNewChild);
    //     AddEnterpriseNo(XMLNodeCurr, CompanyInfo."Enterprise No.");
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Replace Code.


    //BC UPGRADE KUMARR78 >> Adding Replacment code for FinishGroupHeader function.
    procedure FinishGroupHeader()
    var
        GrpHdrNode: XmlNode;
        XMLNewChild: XmlNode;
    begin
        // XMLDomDoc.SelectSingleNode('Document', GrpHdrNode);
        // AddElement(GrpHdrNode, 'NbOfTxs', Format(NumberOfTransactions, 0, 9), '', XMLNewChild);
        // AddElement(GrpHdrNode, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := FinalXmlNode;
        AddElement(XMLNodeCurr, 'NbOfTxs', Format(NumberOfTransactions, 0, 9), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNewChild, 'Nm', CompanyInfo.Name, '', XMLNewChild);
        AddEnterpriseNo(XMLNewChild, CompanyInfo."Enterprise No. FND");
    end;
    //BC UPGRADE KUMARR78 << Adding Replacment code for FinishGroupHeader function.

    //BC UPGRADE KUMARR78 >> Blocking to Replace Code.
    // procedure AddEnterpriseNo(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; EnterpriseNo: Text[50]);
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     if DelChr(EnterpriseNo, '<>') <> '' then begin
    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'OrgId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', EnterpriseNo, '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'Issr', 'KBO-BCE', '', XMLNewChild);
    //     end;
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Replace Code.

    //BC UPGRADE KUMARR78 >> Adding Replacment code for AddEnterpriseNo function.
    procedure AddEnterpriseNo(XMLNodeCurr: XmlNode; EnterpriseNo: Text[50])
    var
        CurrNode: XmlNode;
        XMLNewChild: XmlNode;
    begin
        if DelChr(EnterpriseNo, '<>') <> '' then begin
            AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
            CurrNode := XMLNewChild;
            AddElement(CurrNode, 'OrgId', '', '', XMLNewChild);
            CurrNode := XMLNewChild;
            AddElement(CurrNode, 'Othr', '', '', XMLNewChild);
            CurrNode := XMLNewChild;
            AddElement(CurrNode, 'Id', EnterpriseNo, '', XMLNewChild);
            AddElement(CurrNode, 'Issr', 'KBO-BCE', '', XMLNewChild);
        end;
    end;
    //BC UPGRADE KUMARR78 << Adding Replacment code for AddEnterpriseNo function.

    local procedure CutText(OriginalText: Text[1024]; MaxLength: Integer) Text: Text[1024];
    begin
        Text := OriginalText;
        IF DELCHR(Text, '<>') = '' THEN
            Text := 'NOTPROVIDED';
        AddCutMarker(Text, MaxLength);
    end;

    procedure GetCurrency(CurrencyCode: Code[10]);
    begin
        IF Currency.Code <> CurrencyCode THEN
            IF NOT Currency.GET(CurrencyCode) THEN
                Currency.INIT;
    end;

    // BC UPGRADE KUMARR78 >> Blocking to Replace Code.
    // local procedure AddAttribute(var XMLDomDocParam: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; var XMLDomNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; AttribName: Text[250]; AttribValue: Text[250]): Boolean;
    // var
    //     XMLDomAttribute: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlAttribute";
    // begin
    //     XMLDomAttribute := XMLDomDocParam.CreateAttribute(AttribName);
    //     if ISNULL(XMLDomAttribute) then
    //         exit(false);
    //     if AttribValue <> '' then
    //         XMLDomAttribute.Value := AttribValue;
    //     XMLDomNode.Attributes.SetNamedItem(XMLDomAttribute);
    //     CLEAR(XMLDomAttribute);
    //     exit(true);
    // end;
    // BC UPGRADE KUMARR78 << Blocking to Replace Code.

    //BC UPGRADE KUMARR78 >> Adding Replacment code for ExportTransactionInformation function.
    local procedure AddAttribute(var XmlNodeParam: XmlNode; AttribName: Text; AttribValue: Text): Boolean
    var
        XmlElement: XmlElement;
    begin
        if AttribValue = '' then
            exit;

        XmlElement := XmlNodeParam.AsXmlElement();
        XmlElement.SetAttribute(AttribName, AttribValue);
        exit(true);
    end;
    //BC UPGRADE KUMARR78 << Adding Replacment code for ExportTransactionInformation function.


    procedure GetVendorBankAccount(VendorNo: Code[20]; BankAccCode: Code[10]);
    begin
        IF (VendorNo <> VendorBankAcc."Vendor No.") OR (BankAccCode <> VendorBankAcc.Code) THEN
            IF NOT VendorBankAcc.GET(VendorNo, BankAccCode) THEN
                VendorBankAcc.INIT;
    end;

    procedure GetCountry(CountryCode: Code[10]);
    begin
        IF CountryCode <> Country.Code THEN
            IF NOT Country.GET(CountryCode) THEN
                Country.INIT;
    end;

    procedure GetVendor(VendorNo: Code[20]);
    begin
        IF Vendor."No." <> VendorNo THEN
            IF NOT Vendor.GET(VendorNo) THEN
                Vendor.INIT;
    end;

    procedure GetCustomerBankAccount(CustomerNo: Code[20]; BankAccCode: Code[10]);
    begin
        IF (CustomerNo <> CustomerBankAcc."Customer No.") OR (BankAccCode <> CustomerBankAcc.Code) THEN
            IF NOT CustomerBankAcc.GET(CustomerNo, BankAccCode) THEN
                CustomerBankAcc.INIT;
    end;

    procedure GetCustomer(CustomerNo: Code[20]);
    begin
        IF Customer."No." <> CustomerNo THEN
            IF NOT Customer.GET(CustomerNo) THEN
                Customer.INIT;
    end;

    local procedure AddCutMarker(var Text: Text[1024]; MaxLength: Integer);
    var
        CutMarker: Text[30];
    begin
        CutMarker := '...';
        IF STRLEN(Text) > MaxLength THEN
            Text := COPYSTR(Text, 1, MaxLength - STRLEN(CutMarker)) + CutMarker;
    end;

    procedure GetBankAccount(BankAccCode: Code[20]);
    begin
        IF BankAcc."No." <> BankAccCode THEN
            IF NOT BankAcc.GET(BankAccCode) THEN
                BankAcc.INIT;
    end;

    local procedure GetMessageID(ExportProtocolCode: Code[20]): Text[35];
    var
        ExportProtocol: Record "Export Protocol FND";
        NoSeriesMgt: Codeunit "No. Series";//BC UPGRADE KUMARR78 Replacing "No. Series Managament. to "No. Series". 
    begin
        ExportProtocol.GET(ExportProtocolCode);
        EXIT(NoSeriesMgt.GetNextNo(ExportProtocol."Export No. Series", TODAY, TRUE));
    end;

    local procedure GetExportProtocolCode(var PmtJnlLine: Record "Gen. Journal Line BC FND"): Code[20];
    var
        ExportProtocolCode: Code[20];
    begin
        PmtJnlLine.FILTERGROUP(2);
        ExportProtocolCode := PmtJnlLine."Export Protocol Code";
        PmtJnlLine.FILTERGROUP(0);
        EXIT(ExportProtocolCode);
    end;

    local procedure AddInCreditTransferRegister(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT"; MessageID: Code[20]);
    var
        lCreditTransferRegister: Record "Credit Transfer Register";
        lEntryNo: Integer;
    begin
        lCreditTransferRegister.RESET;
        lEntryNo := 1;
        IF lCreditTransferRegister.FINDLAST THEN
            lEntryNo := lCreditTransferRegister."No." + 1;

        lCreditTransferRegister.RESET;
        lCreditTransferRegister."No." := lEntryNo;
        lCreditTransferRegister.Identifier := GenJournalLine."Document No.";
        lCreditTransferRegister."Created Date-Time" := CREATEDATETIME(TODAY, TIME);
        lCreditTransferRegister."Created by User" := USERID;
        lCreditTransferRegister.Status := lCreditTransferRegister.Status::"File Created";
        lCreditTransferRegister."No. of Transfers" := 1;
        lCreditTransferRegister."From Bank Account No." := GenJournalLine."Bal. Account No.";

        //BC UPGRADE KUMARR78 >> Blocking As Fields not available in BC.
        // lCreditTransferRegister."Interface Log Entry No." := InterfaceEntryHeader."Entry No.";
        // lCreditTransferRegister."Can Be Sent to WS" := TRUE;
        // lCreditTransferRegister."WS Status" := lCreditTransferRegister."WS Status"::"Sent to NAS";
        // lCreditTransferRegister."WS MessageID" := MessageID;
        // lCreditTransferRegister."Exported Multiple Times" := FALSE;
        // lCreditTransferRegister."HNK Bank Account" := GenJournalLine."HNK Bank Account";
        // lCreditTransferRegister."No. of Times Sent to WS" := 1;
        //BC UPGRADE KUMARR78 << Blocking As Fields not available in BC.
        IF lCreditTransferRegister.INSERT THEN;
    end;

    local procedure AddInCreditTransferEntry(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT"; MessageID: Code[20]);
    var
        lCreditTransferEntry: Record "Credit Transfer Entry";
        lCreditTransferRegisterNo: Integer;
    begin
        lCreditTransferEntry.RESET;
        lCreditTransferRegisterNo := 1;
        IF lCreditTransferEntry.FINDLAST THEN
            lCreditTransferRegisterNo := lCreditTransferEntry."Credit Transfer Register No." + 1;

        lCreditTransferEntry.RESET;
        lCreditTransferEntry."Credit Transfer Register No." := lCreditTransferRegisterNo;
        lCreditTransferEntry."Entry No." := 1;
        IF GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer THEN
            lCreditTransferEntry."Account Type" := lCreditTransferEntry."Account Type"::Customer;
        IF GenJournalLine."Account Type" = GenJournalLine."Account Type"::Vendor THEN
            lCreditTransferEntry."Account Type" := lCreditTransferEntry."Account Type"::Vendor;
        lCreditTransferEntry."Account No." := GenJournalLine."Account No.";
        lCreditTransferEntry."Transfer Date" := GenJournalLine."Document Date";
        lCreditTransferEntry."Currency Code" := GenJournalLine."Currency Code";
        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            lCreditTransferEntry."Transfer Amount" := GenJournalLine."Amount (LCY)"
        ELSE
            lCreditTransferEntry."Transfer Amount" := GenJournalLine."Amount (LCY)" - GenJournalLine."WHT Amount (LCY)";
        lCreditTransferEntry."Transaction ID" := COPYSTR(GenJournalLine."Document No.", 1, 35);
        lCreditTransferEntry.Canceled := FALSE;
        lCreditTransferEntry."Recipient Bank Acc. No." := GenJournalLine."Bal. Account No.";
        lCreditTransferEntry."Message to Recipient" := COPYSTR(GenJournalLine."Message to Recipient", 1, 140);

        //BC UPGRADE KUMARR78 >> Blocking As Fields not available in BC.
        // lCreditTransferEntry."Interface Log Entry No." := InterfaceEntryHeader."Entry No.";
        // lCreditTransferEntry."Can Be Sent to WS" := TRUE;
        // lCreditTransferEntry."WS Status" := lCreditTransferEntry."WS Status"::"Sent to NAS";
        // lCreditTransferEntry."WS MessageID" := MessageID;
        // lCreditTransferEntry."Exported Multiple Times" := FALSE;
        // lCreditTransferEntry."HNK Bank Account" := GenJournalLine."HNK Bank Account";
        // lCreditTransferEntry."No. of Times Sent to WS" := 1;
        //BC UPGRADE KUMARR78 << Blocking As Fields not available in BC.

        IF lCreditTransferEntry.INSERT THEN;
    end;

    procedure CheckNewGroup(PmtJnlLine: Record "Gen. Journal Line BC FND"): Boolean;
    begin
        IF EmptyConsolidatedPayment THEN
            EXIT(TRUE);

        EXIT(
  (ConsolidatedPmtJnlLine."HNK Bank Account" <> PmtJnlLine."HNK Bank Account") OR
  (ConsolidatedPmtJnlLine."Currency Code" <> PmtJnlLine."Currency Code") OR
  (ConsolidatedPmtJnlLine."Posting Date" <> PmtJnlLine."Posting Date") OR
  (ConsolidatedPmtJnlLine."Instruction Priority" <> PmtJnlLine."Instruction Priority") OR
  (ConsolidatedPmtJnlLine."Code Expenses" <> PmtJnlLine."Code Expenses"));
    end;

    local procedure EmptyConsolidatedPayment(): Boolean;
    begin
        EXIT(ConsolidatedPmtJnlLine."HNK Bank Account" = '');
    end;

    local procedure NewConsolidatedPayment(PmtJnlLine: Record "Gen. Journal Line BC FND"): Boolean;
    var
        lBeneficiaryBankAccount: Code[30];
        lBeneficiaryBankAccountConsolidated: Code[30];
        lCust: Record Customer;
        CustBankAcc: Record "Customer Bank Account";
        lVend: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
    begin
        IF EmptyConsolidatedPayment THEN
            EXIT(FALSE);

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lBeneficiaryBankAccount := CustBankAcc."Bank Account No.";
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lBeneficiaryBankAccount := VendBankAcc."Bank Account No.";
                    END;
            END
        ELSE BEGIN
            lBeneficiaryBankAccount := '';
        END;

        IF (ConsolidatedPmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE ConsolidatedPmtJnlLine."Account Type" OF
                ConsolidatedPmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(ConsolidatedPmtJnlLine."Account No.");
                        CustBankAcc.GET(ConsolidatedPmtJnlLine."Account No.", ConsolidatedPmtJnlLine."Customer/Vendor Bank");
                        lBeneficiaryBankAccountConsolidated := CustBankAcc."Bank Account No.";
                    END;
                ConsolidatedPmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(ConsolidatedPmtJnlLine."Account No.");
                        VendBankAcc.GET(ConsolidatedPmtJnlLine."Account No.", ConsolidatedPmtJnlLine."Customer/Vendor Bank");
                        lBeneficiaryBankAccountConsolidated := VendBankAcc."Bank Account No.";
                    END;
            END
        ELSE BEGIN
            lBeneficiaryBankAccountConsolidated := '';
        END;

        EXIT(
  CheckNewGroup(PmtJnlLine) OR
  IsPaymentMessageTooLong(PmtJnlLine."Message to Recipient") OR
  (ConsolidatedPmtJnlLine."Account Type" <> PmtJnlLine."Account Type") OR
  (ConsolidatedPmtJnlLine."Account No." <> PmtJnlLine."Account No.") OR
  (lBeneficiaryBankAccountConsolidated <> lBeneficiaryBankAccount));
    end;

    local procedure InitConsolidatedPayment(PmtJnlLine: Record "Gen. Journal Line BC FND");
    begin
        ConsolidatedPmtJnlLine := PmtJnlLine;
        ConsolidatedPmtMessage := ConsolidatedPmtJnlLine."Message to Recipient";
    end;

    local procedure UpdateConsolidatedPayment(PmtJnlLine: Record "Gen. Journal Line BC FND");
    begin
        IF EmptyConsolidatedPayment THEN
            InitConsolidatedPayment(PmtJnlLine)
        ELSE BEGIN
            IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
                ConsolidatedPmtJnlLine.Amount := ConsolidatedPmtJnlLine.Amount + PmtJnlLine.Amount
            ELSE
                ConsolidatedPmtJnlLine.Amount := ConsolidatedPmtJnlLine.Amount + (PmtJnlLine.Amount - PmtJnlLine."WHT Amount");
            UpdateConsolidatedPmtMessage(PmtJnlLine."Message to Recipient");
        END;
    end;

    local procedure IsPaymentMessageTooLong(PaymentMessage: Text[50]): Boolean;
    begin
        IF NOT EBSetup."Cut off Payment Message Texts" THEN
            EXIT(STRLEN(ConcatenatedPmtMessage(PaymentMessage)) > MAXSTRLEN(ConsolidatedPmtMessage));
        EXIT(FALSE);
    end;

    local procedure UpdateConsolidatedPmtMessage(PaymentMessage: Text[50]);
    var
        NewMessage: Text[1024];
    begin
        NewMessage := ConcatenatedPmtMessage(PaymentMessage);
        IF EBSetup."Cut off Payment Message Texts" THEN
            ConsolidatedPmtMessage := COPYSTR(
                CutText(NewMessage, MAXSTRLEN(ConsolidatedPmtMessage)),
                1, MAXSTRLEN(ConsolidatedPmtMessage))
        ELSE
            ConsolidatedPmtMessage := COPYSTR(NewMessage, 1, MAXSTRLEN(ConsolidatedPmtMessage));
    end;

    local procedure ConcatenatedPmtMessage(PaymentMessage: Text[50]): Text[1024];
    begin
        EXIT(ConsolidatedPmtMessage + ' ' + PaymentMessage);
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text): Text;
    var
        NewString: Text;
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;

        EXIT(NewString);
    end;

    local procedure GetMessageIDBankExportImportSetup(): Text[35];
    var
        ExportProtocol: Record "Export Protocol FND";
        NoSeriesMgt: Codeunit "No. Series";//BC UPGRADE KUMARR78 Replacing "No. Series Managament. to "No. Series". 
    begin
        EXIT(NoSeriesMgt.GetNextNo(BankExportImportSetup."Export No. Series FND", TODAY, TRUE));
    end;


    //BC UPGRADE KUMARR78 >> Blocking to Rewrite Function.
    // procedure CreateNonSepaContentPanama(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     lNonSepaContent: Text;
    //     OutStr: OutStream;
    //     inStr: InStream;
    //     MyText: Text;
    //     XMLDOMManagement: Codeunit "XML DOM Management";
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     BigText: BigText;
    //     XMLText: Text;
    //     filRead: File;
    //     intLen: Integer;
    //     txtOneLine: Text;
    //     txtFromFile: Text;
    //     TodayString: Text;
    //     FileName1: Text;
    //     InStream: InStream;
    //     i: Integer;
    //     j: Integer;
    //     k: Integer;
    //     k1: Integer;
    //     k3: Integer;
    //     TxtToAddInComponent: Text[80];
    //     InterfaceEntryComponent: Record "Interface Entry Component INT";
    //     c: Integer;
    //     cString: Text;
    //     NewPaymentGroup: Boolean;
    //     lGenJournalLine: Record "Gen. Journal Line BC FND";
    //     Pos: Integer;
    //     lGenJournalLine81: Record "Gen. Journal Line";
    // begin
    //     //Panama
    //     CompanyInfo.GET;

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     XMLRootElement.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //     GMessageId := MessageId;
    //     StartGroupHeader(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;


    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
    //     IF lGenJournalLine.FINDFIRST THEN
    //         REPEAT
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
    //                 ExportTransactionInformationPanama(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
    //                 InitConsolidatedPayment(lGenJournalLine);
    //             END ELSE
    //                 UpdateConsolidatedPayment(lGenJournalLine);

    //             IF NewPaymentGroup THEN
    //                 ExportPaymentInformationPanama(CstmrCdtTrfInitnNode, lGenJournalLine);
    //         UNTIL lGenJournalLine.NEXT = 0;

    //     IF NOT EmptyConsolidatedPayment THEN
    //         ExportTransactionInformationPanama(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

    //     //Footer
    //     FinishGroupHeader;

    //     IF DATE2DMY(TODAY, 2) < 10 THEN
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
    //     ELSE
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

    //     FileName := SaveToFileNameClient;

    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName, FileName);
    //     FullFileName := FileName;

    //     filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);

    //     intLen := filRead.LEN;
    //     txtFromFile := '';

    //     InterfaceEntryComponent.RESET;
    //     c := 1;
    //     cString := 'C0001';

    //     filRead.CREATEINSTREAM(InStream);
    //     WHILE NOT InStream.EOS DO BEGIN
    //         InStream.READTEXT(txtFromFile);
    //         i := STRLEN(txtFromFile);

    //         k := i DIV 80;
    //         k1 := i MOD 80;

    //         IF k1 <> 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k + 1 DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;

    //         IF k1 = 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;
    //     END;

    //     TxtToAddInComponent := ']]>';
    //     InterfaceEntryComponent.RESET;
    //     InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //     InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //     InterfaceEntryComponent.Code := FORMAT(cString);
    //     InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //     InterfaceEntryComponent.INSERT;
    //     c += 1;
    //     cString := INCSTR(cString);

    //     filRead.CLOSE;

    //     IF EXISTS(SaveToFileName) THEN
    //         IF ERASE(SaveToFileName) THEN;

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.DELETEALL;

    //     lGenJournalLine81.RESET;
    //     lGenJournalLine81.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine81.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine81.SETFILTER("Parent Line No.", '=%1', 0);
    //     lGenJournalLine81.MODIFYALL("WS Posting Allowed FND", TRUE);
    // end;

    //BC UPGRADE KUMARR78 << Blocking to Rewrite Function.
    //BC UPGRADE KUMARR78 >> Rewriting CreatenonSepaContentPanam Function.
    procedure CreateNonSepaContentPanama(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text
    var
        lGenJournalLine81: Record "Gen. Journal Line";
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        TempBlob: Codeunit "Temp Blob";
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XMLNodeCurr: XmlNode;
        NewPaymentGroup: Boolean;
        cString: Code[10];
        InStr: InStream;
        c: Integer;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        Pos: Integer;
        OutStr: OutStream;
        txtOneLine: Text;
        XMLText: Text;
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        TodayString: Text;
        RootNode: XmlElement;
        TxtToAddInComponent: Text[80];
        XMlns: Integer;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        // XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);

        // RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        // XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;
        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeader(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SetFilter("Parent Line No.", '=%1', 0);

        if lGenJournalLine.FindFirst() then
            REPEAT
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                    ExportTransactionInformationPanama(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationPanama(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationPanama(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);


        FinishGroupHeader();

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);
        XMLText := DelStr(XMLText, StrPos(XMLText, 'standalone=" "'), StrLen('standalone=" "'));

        c := 1;
        cString := 'C0001';
        While NOT InStr.EOS DO BEGIN
            if c <> 1 then
                InStr.READTEXT(XMLText);

            i := StrLen(XMLText);
            k := i div 80;
            k1 := i mod 80;
            k3 := 1;

            //for j := 1 to k do begin
            if k1 <> 0 then begin
                k3 := 1;
                for j := 1 to k + 1 do begin
                    txtOneLine := CopyStr(XMLText, k3, 80);
                    k3 += 80;

                    TxtToAddInComponent := txtOneLine;

                    //Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN

                    //  if k1 <> 0 then begin
                    txtOneLine := CopyStr(XMLText, k3, 80);

                    TxtToAddInComponent := txtOneLine;

                    //Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);

        exit(XMLText);
    end;

    local procedure InsertInterfaceComponentLine(
    var InterfaceEntryComponent: Record "Interface Entry Component INT";
    InterfaceEntryLine: Record "Interface Entry Line INT";
    CodeValue: Code[10];
    LineText: Text)
    var
        CleanText: Text[80];
    begin
        CleanText := DelChr(LineText, '<>', ' ');

        InterfaceEntryComponent.Init();
        InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
        InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
        InterfaceEntryComponent.Code := CodeValue;
        InterfaceEntryComponent."Approver Name" := CleanText;
        InterfaceEntryComponent.Insert();
    end;
    //BC UPGRADE KUMARR78 << Rewriting CreatenonSepaContentPanam Function.

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite ExportPaymentInformationPanama Function.
    // local procedure ExportPaymentInformationPanama(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     InstructionPriority: Text[10];
    //     ChargeBearer: Text[4];
    //     BICICIABPos: Integer;
    //     lVendor: Record Vendor;
    //     VendBankAcc: Record "Vendor Bank Account";
    //     BeneficiaryBankAccountNo: Text[30];
    //     lIsEURPayment: Boolean;
    // begin
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;

    //     //HEI.08>>
    //     lIsEURPayment := FALSE;
    //     IF PmtJnlLine."Currency Code" = 'EUR' THEN
    //         lIsEURPayment := TRUE;
    //     //HEI.08<<

    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);

    //     IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN BEGIN
    //         IF lVendor.GET(PmtJnlLine."Account No.") THEN BEGIN
    //             IF lVendor."Payment Method Code" = 'CHEQUE' THEN
    //                 AddElement(XMLNodeCurr, 'PmtMtd', 'CHK', '', XMLNewChild)
    //             ELSE
    //                 AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);
    //         END
    //         ELSE
    //             AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);
    //     END
    //     ELSE
    //         AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'BtchBookg', 'false', '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     CASE PmtJnlLine."Instruction Priority" OF
    //         PmtJnlLine."Instruction Priority"::Normal:
    //             InstructionPriority := 'NORM';
    //         PmtJnlLine."Instruction Priority"::High:
    //             InstructionPriority := 'HIGH';
    //     END;

    //     //AddElement(XMLNodeCurr,'InstrPrty',InstructionPriority,'',XMLNewChild);
    //     AddElement(XMLNodeCurr, 'SvcLvl', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Cd', 'URGP', '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     //HEI.08>>
    //     IF lIsEURPayment THEN BEGIN
    //         AddElement(XMLNodeCurr, 'LclInstrm', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Prtry', 'CITI392', '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     END;
    //     //HEI.08<<

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     CompanyInfo.Name := ReplaceTextCharacters(CompanyInfo.Name);
    //     AddElement(XMLNodeCurr, 'Nm', CompanyInfo.Name, '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetCountry(CompanyInfo."Country/Region Code");

    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //     //AddressLine1 := DELCHR(CompanyInfo.Address,'<>') + ' ' + DELCHR(CompanyInfo."Address 2",'<>');
    //     CompanyInfo.Address := ReplaceTextCharacters(CompanyInfo.Address);
    //     CompanyInfo."Address 2" := ReplaceTextCharacters(CompanyInfo."Address 2");
    //     AddressLine1 := DELCHR(DELCHR(CompanyInfo.Address, '<>', ' ') + ' ' + DELCHR(CompanyInfo."Address 2", '<>', ' '), '<>', ' ');
    //     IF DELCHR(AddressLine1) <> '' THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //     //AddressLine2 := DELCHR(CompanyInfo."Post Code",'<>') + ' ' + DELCHR(CompanyInfo.City,'<>');
    //     CompanyInfo.City := ReplaceTextCharacters(CompanyInfo.City);
    //     CompanyInfo."Post Code" := ReplaceTextCharacters(CompanyInfo."Post Code");//HEI.11
    //     AddressLine2 := DELCHR(DELCHR(CompanyInfo."Post Code", '<>', ' ') + ' ' + DELCHR(CompanyInfo.City, '<>', ' '), '<>', ' ');
    //     IF DELCHR(AddressLine2) <> '' THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");
    //     //AddElement(XMLNodeCurr,'IBAN',COPYSTR(DELCHR(BankAcc.IBAN),1,34),'',XMLNewChild);

    //     /*//CdtrAcct
    //       // If IBAN Transfer then Export IBAN else BBAN
    //       IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region";
    //       IF IBANTransfer THEN
    //         AddElement(XMLNodeCurr,'IBAN',COPYSTR(DELCHR(BeneficiaryIBAN),1,34),'',XMLNewChild)
    //       ELSE BEGIN
    //         AddElement(XMLNodeCurr,'Othr','','',XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr,'Id',BeneficiaryBankAccountNo,'',XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //       END;
    //     */
    //     BeneficiaryBankAccountNo := '';
    //     IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
    //         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

    //     AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     //AddElement(XMLNodeCurr,'Id',BeneficiaryBankAccountNo,'',XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;


    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     CASE PmtJnlLine."Code Expenses" OF
    //         PmtJnlLine."Code Expenses"::" ",
    //       PmtJnlLine."Code Expenses"::SHA:
    //             ChargeBearer := 'SHAR';
    //         PmtJnlLine."Code Expenses"::BEN:
    //             ChargeBearer := 'CRED';
    //         PmtJnlLine."Code Expenses"::OUR:
    //             ChargeBearer := 'DEBT';
    //     END;

    //     //AddElement(XMLNodeCurr,'ChrgBr',ChargeBearer,'',XMLNewChild);

    //     XMLNodeCurr := RootNode;

    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite Function.

    local procedure ExportPaymentInformationPanama(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;
        PmtInfNodeLocal: XmlNode;
        PmtTpInfNode: XmlNode;
        SvcLvlNode: XmlNode;
        LclInstrmNode: XmlNode;
        DbtrNode: XmlNode;
        PstlAdrNode: XmlNode;
        DbtrAcctNode: XmlNode;
        IdNode: XmlNode;
        OthrNode: XmlNode;
        DbtrAgtNode: XmlNode;
        FinInstnIdNode: XmlNode;
        AddressLine1: Text[110];
        AddressLine2: Text[60];
        InstructionPriority: Text[10];
        ChargeBearer: Text[4];
        lVendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        BeneficiaryBankAccountNo: Text[30];
        lIsEURPayment: Boolean;
    begin
        RootNode := XMLNodeCurr;

        PaymentInformationCounter += 1;

        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        PmtInfNodeLocal := XMLNewChild;
        PmtInfNode := XMLNewChild;

        lIsEURPayment := PmtJnlLine."Currency Code" = 'EUR';

        AddElement(PmtInfNodeLocal, 'PmtInfId', MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);

        if PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor then begin
            if lVendor.Get(PmtJnlLine."Account No.") then begin
                if lVendor."Payment Method Code" = 'CHEQUE' then
                    AddElement(PmtInfNodeLocal, 'PmtMtd', 'CHK', '', XMLNewChild)
                else
                    AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);
            end else
                AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);
        end else
            AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'BtchBookg', 'false', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'PmtTpInf', '', '', XMLNewChild);
        PmtTpInfNode := XMLNewChild;

        case PmtJnlLine."Instruction Priority" of
            PmtJnlLine."Instruction Priority"::Normal:
                InstructionPriority := 'NORM';
            PmtJnlLine."Instruction Priority"::High:
                InstructionPriority := 'HIGH';
        end;

        AddElement(PmtTpInfNode, 'SvcLvl', '', '', XMLNewChild);
        SvcLvlNode := XMLNewChild;

        AddElement(SvcLvlNode, 'Cd', 'URGP', '', XMLNewChild);

        if lIsEURPayment then begin
            AddElement(PmtTpInfNode, 'LclInstrm', '', '', XMLNewChild);
            LclInstrmNode := XMLNewChild;
            AddElement(LclInstrmNode, 'Prtry', 'CITI392', '', XMLNewChild);
        end;

        AddElement(PmtInfNodeLocal, 'ReqdExctnDt', Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'Dbtr', '', '', XMLNewChild);
        DbtrNode := XMLNewChild;

        CompanyInfo.Name := ReplaceTextCharacters(CompanyInfo.Name);
        AddElement(DbtrNode, 'Nm', CompanyInfo.Name, '', XMLNewChild);

        AddElement(DbtrNode, 'PstlAdr', '', '', XMLNewChild);
        PstlAdrNode := XMLNewChild;

        GetCountry(CompanyInfo."Country/Region Code");

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(PstlAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

        CompanyInfo.Address := ReplaceTextCharacters(CompanyInfo.Address);
        CompanyInfo."Address 2" := ReplaceTextCharacters(CompanyInfo."Address 2");

        AddressLine1 := DelChr(CompanyInfo.Address + ' ' + CompanyInfo."Address 2", '<>', ' ');

        if AddressLine1 <> '' then
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);

        CompanyInfo.City := ReplaceTextCharacters(CompanyInfo.City);
        CompanyInfo."Post Code" := ReplaceTextCharacters(CompanyInfo."Post Code");

        AddressLine2 := DelChr(CompanyInfo."Post Code" + ' ' + CompanyInfo.City, '<>', ' ');

        if AddressLine2 <> '' then
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAcct', '', '', XMLNewChild);
        DbtrAcctNode := XMLNewChild;

        AddElement(DbtrAcctNode, 'Id', '', '', XMLNewChild);
        IdNode := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        BeneficiaryBankAccountNo := '';

        if VendBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") then
            BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

        AddElement(IdNode, 'Othr', '', '', XMLNewChild);
        OthrNode := XMLNewChild;

        AddElement(OthrNode, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAgt', '', '', XMLNewChild);
        DbtrAgtNode := XMLNewChild;

        AddElement(DbtrAgtNode, 'FinInstnId', '', '', XMLNewChild);
        FinInstnIdNode := XMLNewChild;

        AddElement(FinInstnIdNode, 'BIC', CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

        case PmtJnlLine."Code Expenses" of
            PmtJnlLine."Code Expenses"::" ",
            PmtJnlLine."Code Expenses"::SHA:
                ChargeBearer := 'SHAR';
            PmtJnlLine."Code Expenses"::BEN:
                ChargeBearer := 'CRED';
            PmtJnlLine."Code Expenses"::OUR:
                ChargeBearer := 'DEBT';
        end;
    end;
    //BC UPGRADE KUMARR78 >> Rewritting ExportPaymentInformationPanama Function.

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite Function.
    // procedure ExportTransactionInformationPanama(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    // var
    //     GLSetup: Record "98";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     ISOCurrCode: Text[3];
    //     IBANTransfer: Boolean;
    //     VendorBankAccount: Record "288";
    //     BeneficiaryIBAN: Code[50];
    //     CustomerBankAccount: Record "287";
    //     BeneficiaryBankAccountNo: Code[30];
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     CustBankAcc: Record "287";
    //     VendBankAcc: Record "288";
    //     lSWIFTCode: Code[20];
    //     lBeneficiaryBankAccount: Code[30];
    //     lCust: Record "18";
    //     lVend: Record "23";
    //     CountryIBANCountryRegion: Boolean;
    //     lNewAmountText: Text;
    //     lBankExportImportSetup: Record "1200";
    //     lPosition: Integer;
    //     lCurrency: Record "4";
    //     BICICIABPos: Integer;
    //     CI93Pos: Integer;
    //     lPrtLctnValue: Text[10];
    //     lVend2: Record "23";
    //     lMmbId: Text[20];
    //     lIsDomesticTransfer: Boolean;
    //     lIsIntermediaryBank: Boolean;
    //     lSWIFTCodeIntermediaryBank: Code[20];
    //     lIsEURPayment: Boolean;
    //     lPmtJnlLine: Record "81";
    //     lPurchInvHeader: Record "122";
    //     lTotalExtDocNo: Text;
    //     lVendInvNo: Text;
    //     lText50000: Label '"INVOICE PAYMENT "';
    // begin
    //     WITH PmtJnlLine DO BEGIN
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         //HEI.08>>
    //         lIsEURPayment := FALSE;
    //         IF PmtJnlLine."Currency Code" = 'EUR' THEN
    //             lIsEURPayment := TRUE;
    //         //HEI.08<<

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         //AddElement(XMLNodeCurr,'EndToEndId',CutText(PaymentMessage,35),'',XMLNewChild);
    //         AddElement(XMLNodeCurr, 'EndToEndId', CutText(PmtJnlLine."Document No.", 16), '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         //HEI.08>>
    //         IF lIsEURPayment THEN BEGIN
    //             AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'CtgyPurp', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'Cd', 'SUPP', '', XMLNewChild);
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         END;
    //         //HEI.08<<

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         //AddElement(XMLNodeCurr,'InstdAmt',FORMAT(Amount,0,9),'',XMLNewChild);
    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;


    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);

    //         IF "Currency Code" = '' THEN
    //             //ISOCurrCode := COPYSTR(GLSetup."LCY Code",1,3) //23.11.2022
    //             ISOCurrCode := 'USD' //23.11.2022
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
    //         END;
    //         AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;


    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         lCust.GET("Account No.");
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := CustBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := CustBankAcc.Code;
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         lVend.GET("Account No.");
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := VendBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := VendBankAcc.Code;
    //                     END;
    //             END
    //         ELSE BEGIN
    //             lSWIFTCode := '';
    //             lBeneficiaryBankAccount := '';
    //         END;

    //         lVend2.RESET;
    //         IF "Account Type" = "Account Type"::Vendor THEN
    //             IF lVend2.GET("Account No.") THEN;


    //         lIsDomesticTransfer := FALSE;
    //         IF ("Account Type" = "Account Type"::Vendor) THEN BEGIN
    //             GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //             IF VendorBankAcc."Country/Region Code" = 'PA' THEN
    //                 lIsDomesticTransfer := TRUE;
    //         END;

    //         //IF lVend2."Payment Method Code" = 'CHEQUE' THEN //27.10.2022
    //         IF lIsDomesticTransfer THEN //27.10.2022
    //           BEGIN
    //             lPrtLctnValue := '001';

    //             AddElement(XMLNodeCurr, 'ChqInstr', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;

    //             AddElement(XMLNodeCurr, 'PrtLctn', lPrtLctnValue, '', XMLNewChild);
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         END;

    //         //AddElement(XMLNodeCurr,'ChrgBr','OUR','',XMLNewChild);
    //         //AddElement(XMLNodeCurr,'ChrgBr','DEBT','',XMLNewChild);
    //         IF (lIsDomesticTransfer = FALSE) THEN //27.10.2022
    //             AddElement(XMLNodeCurr, 'ChrgBr', 'DEBT', '', XMLNewChild);

    //         //Intermediary Bank, 07.12.2022
    //         lIsIntermediaryBank := FALSE;
    //         lSWIFTCodeIntermediaryBank := '';

    //         //Intermediary Bank, 21.12.2022
    //         IF VendorBankAcc."Interm. Bank BIC/SWIFT Code" <> '' THEN BEGIN
    //             lIsIntermediaryBank := TRUE;
    //             lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Code";
    //         END;

    //         //Intermediary Bank, 07.12.2022
    //         IF (lIsIntermediaryBank = TRUE) THEN BEGIN
    //             AddElement(XMLNodeCurr, 'IntrmyAgt1', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(lSWIFTCodeIntermediaryBank), 1, 11), '', XMLNewChild);
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         END;

    //         AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);//rrr
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         //AddElement(XMLNodeCurr,'BIC',COPYSTR(DELCHR(lSWIFTCode),1,11),'',XMLNewChild);
    //         IF (lIsDomesticTransfer = FALSE) THEN //27.10.2022
    //             AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(lSWIFTCode), 1, 11), '', XMLNewChild);

    //         CASE "Account Type" OF
    //             "Account Type"::Vendor:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);

    //                     //IF VendorBankAcc."Country/Region Code" = 'US' THEN
    //                     //  BEGIN
    //                     //HEI.08>>
    //                     IF (lIsEURPayment = FALSE) THEN BEGIN
    //                         //HEI.08<<
    //                         AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;
    //                         IF lIsDomesticTransfer THEN BEGIN
    //                             //20.01.2023
    //                             //lMmbId := VendorBankAcc."Domestic - Bank Branch No."
    //                             lMmbId := '';
    //                             IF (VendorBankAcc."Bank Branch No." <> '') THEN
    //                                 lMmbId := COPYSTR(VendorBankAcc."Bank Branch No.", 6, 3);
    //                         END
    //                         ELSE
    //                             lMmbId := VendorBankAcc."Bank Branch No.";
    //                         AddElement(XMLNodeCurr, 'MmbId', lMmbId, '', XMLNewChild);
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                         //HEI.08>>
    //                     END;
    //                     //HEI.08<<
    //                     //  END;
    //                     /*
    //                     IF VendorBankAcc."Bank Branch No." <> '' THEN
    //                       BEGIN
    //                         AddElement(XMLNodeCurr,'ClrSysMmbId','','',XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;
    //                         lMmbId := '';
    //                         lMmbId := VendorBankAcc."Bank Branch No.";
    //                         //lMmbId := VendorBankAcc."Transit No.";
    //                         AddElement(XMLNodeCurr,'MmbId',lMmbId,'',XMLNewChild);
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                       END;
    //                     */

    //                     VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);
    //                     IF (lIsDomesticTransfer = FALSE) THEN //27.10.2022
    //                       BEGIN
    //                         AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     END;
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(VendorBankAcc."Country/Region Code");
    //                     IF ((Country."ISO Country/Region Code" <> '') AND (Country."ISO Country/Region Code" <> 'PA')) THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     VendorBankAcc.Address := ReplaceTextCharacters(VendorBankAcc.Address);
    //                     VendorBankAcc."Address 2" := ReplaceTextCharacters(VendorBankAcc."Address 2");
    //                     AddressLine1 := DELCHR(VendorBankAcc.Address, '<>') + ' ' + DELCHR(VendorBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     VendorBankAcc.City := ReplaceTextCharacters(VendorBankAcc.City);
    //                     VendorBankAcc."Post Code" := ReplaceTextCharacters(VendorBankAcc."Post Code");//HEI.11
    //                     AddressLine2 := DELCHR(VendorBankAcc."Post Code", '<>') + ' ' + DELCHR(VendorBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     //BrnchId will be available only for domestic payments, 20.10.2022
    //                     //IF VendorBankAcc."Country/Region Code" = 'PA' THEN //27.10.2022
    //                     IF lIsDomesticTransfer THEN //27.10.2022
    //                       BEGIN
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                         AddElement(XMLNodeCurr, 'BrnchId', '', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;
    //                         AddElement(XMLNodeCurr, 'Id', '0001', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     END;

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetVendor("Account No.");
    //                     Vendor.Name := ReplaceTextCharacters(Vendor.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Vendor."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     Vendor.Address := ReplaceTextCharacters(Vendor.Address);
    //                     Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
    //                     AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     Vendor.City := ReplaceTextCharacters(Vendor.City);
    //                     Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");//HEI.11
    //                     AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;


    //                     //part to be removed for crossborder payments, 20.10.2022>>
    //                     //IF VendorBankAcc."Country/Region Code" = 'PA' THEN //27.10.2022
    //                     IF lIsDomesticTransfer THEN //27.10.2022
    //                       BEGIN
    //                         //TXID
    //                         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         /*
    //                         AddElement(XMLNodeCurr,'OrgId','','',XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         AddElement(XMLNodeCurr,'Othr','','',XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         //AddElement(XMLNodeCurr,'Id',lVend2."VAT Registration No." + ';' + lVend2."Tax Number 2",'',XMLNewChild);//www
    //                         //AddElement(XMLNodeCurr,'Id',lVend2."Tax Number 2",'',XMLNewChild);//www
    //                         AddElement(XMLNodeCurr,'Id',lVend2."VAT Registration No.",'',XMLNewChild);
    //                         AddElement(XMLNodeCurr,'SchmeNm','','',XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         AddElement(XMLNodeCurr,'Cd','TXID','',XMLNewChild);

    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                         */

    //                         AddElement(XMLNodeCurr, 'PrvtId', '', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         //AddElement(XMLNodeCurr,'Id',lVend2."VAT Registration No." + ';' + lVend2."Tax Number 2",'',XMLNewChild);
    //                         //AddElement(XMLNodeCurr,'Id',lVend2."Tax Number 2",'',XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'Id', lVend2."VAT Registration No.", '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'SchmeNm', '', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         AddElement(XMLNodeCurr, 'Cd', 'TXID', '', XMLNewChild);

    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     END;
    //                     //part to be removed for crossborder payments, 20.10.2022<<

    //                 END;
    //             "Account Type"::Customer:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(CustomerBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCustomer("Account No.");
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Customer."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //         END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;



    //         AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := CustBankAcc.IBAN;
    //                         GetCountry(CustBankAcc."Country/Region Code");
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                     END;
    //             END
    //         ELSE BEGIN
    //             BeneficiaryBankAccountNo := '';
    //             BeneficiaryIBAN := '';
    //             Country."IBAN Country/Region" := FALSE;
    //         END;

    //         // If IBAN Transfer then Export IBAN else BBAN
    //         //HEI.12>>
    //         //IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region";
    //         //HEI.17>>
    //         //IBANTransfer := (BeneficiaryIBAN <> '');
    //         IF lIsEURPayment THEN
    //             IBANTransfer := (BeneficiaryIBAN <> '')
    //         ELSE //is USD payment
    //             IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region";
    //         //HEI.17<<
    //         //HEI.12<<
    //         IF IBANTransfer THEN
    //             AddElement(XMLNodeCurr, 'IBAN', COPYSTR(DELCHR(BeneficiaryIBAN), 1, 34), '', XMLNewChild)
    //         ELSE BEGIN
    //             AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         END;

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         AddElement(XMLNodeCurr, 'Tp', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Cd', 'CACC', '', XMLNewChild);
    //         //AddElement(XMLNodeCurr,'Prtry','CACC','',XMLNewChild);
    //         //AddElement(XMLNodeCurr,'Prtry',BeneficiaryBankAccountNo,'',XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         //IF VendorBankAcc."Country/Region Code" = 'PA' THEN //27.10.2022
    //         IF lIsDomesticTransfer THEN //27.10.2022
    //           BEGIN
    //             AddElement(XMLNodeCurr, 'Purp', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'Prtry', '01', '', XMLNewChild);
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         END;

    //         AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         //HEI.13>>
    //         //AddElement(XMLNodeCurr,'Ustrd',PaymentMessage,'',XMLNewChild);
    //         lTotalExtDocNo := '';
    //         lPmtJnlLine.RESET;
    //         lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
    //         lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
    //         lPmtJnlLine.SETRANGE("Parent Line No.", PmtJnlLine."Line No.");
    //         IF lPmtJnlLine.FINDSET(FALSE, FALSE) THEN
    //             REPEAT
    //                 IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
    //                     IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
    //                         IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
    //                             lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.", STRLEN(lPurchInvHeader."Vendor Invoice No.") - 8, 9)
    //                         ELSE
    //                             lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
    //                         lTotalExtDocNo += lVendInvNo + ',';
    //                     END;
    //             UNTIL lPmtJnlLine.NEXT = 0;
    //         IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
    //             lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
    //             lTotalExtDocNo := lText50000 + lTotalExtDocNo; //HEI.14
    //             IF (STRLEN(lTotalExtDocNo) <= 35) THEN
    //                 AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
    //             IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
    //             END;
    //         END
    //         ELSE
    //             AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);
    //         //HEI.13<<

    //         XMLNodeCurr := RootNode;
    //     END;

    // end;
    //    BC UPGRADE KUMARR78 << Blocking to Replace entire Function. 

    //    BC UPGRADE KUMARR78 >> Rewriting Function ExportTransactionInformationPanama. 

    procedure ExportTransactionInformationPanama(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        GLSetup: Record "General Ledger Setup";
        AddressLine1: Text[110];
        AddressLine2: Text[60];
        ISOCurrCode: Text[3];
        IBANTransfer: Boolean;
        VendorBankAccount: Record "Vendor Bank Account";
        BeneficiaryIBAN: Code[50];
        CustomerBankAccount: Record "Customer Bank Account";
        BeneficiaryBankAccountNo: Code[30];
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        lSWIFTCode: Code[20];
        lBeneficiaryBankAccount: Code[30];
        lCust: Record Customer;
        lVend: Record Vendor;
        CountryIBANCountryRegion: Boolean;
        lNewAmountText: Text;
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lPosition: Integer;
        lCurrency: Record Currency;
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPrtLctnValue: Text[10];
        lVend2: Record Vendor;
        lMmbId: Text[20];
        lIsDomesticTransfer: Boolean;
        lIsIntermediaryBank: Boolean;
        lSWIFTCodeIntermediaryBank: Code[20];
        lIsEURPayment: Boolean;
        lPmtJnlLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        lTotalExtDocNo: Text;
        lVendInvNo: Text;
        lText50000: Label '"INVOICE PAYMENT "';
        AmtNode: XmlNode;
        CdtrAcctNode: XmlNode;
        CdtrNode: XmlNode;
        CdtTrfTxInfNode: XmlNode;
        IdNode: XmlNode;
        PmtIdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        RootNode: XmlNode;
        XMLNewChild: XmlNode;

        PmtTpInfNode: XmlNode;
        CdtrAgtNode: XmlNode;
    begin

        GLSetup.Get;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;

        lIsEURPayment := false;
        if PmtJnlLine."Currency Code" = 'EUR' then
            lIsEURPayment := true;
        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
        AddElement(CdtTrfTxInfNode, 'PmtId', '', '', XMLNewChild);
        AddElement(PmtIdNode, 'EndToEndId', CutText(PmtJnlLine."Document No.", 16), '', XMLNewChild);

        if lIsEURPayment then begin
            AddElement(CdtTrfTxInfNode, 'PmtTpInf', '', '', XMLNewChild);
            AddElement(PmtTpInfNode, 'CtgyPurp', '', '', XMLNewChild);
            AddElement(XMLNewChild, 'Cd', 'SUPP', '', XMLNewChild);
        end;

        AddElement(CdtTrfTxInfNode, 'Amt', '', '', AmtNode);
        //AddElement(XMLNodeCurr,'InstdAmt',FORMAT(Amount,0,9),'',XMLNewChild);
        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;
        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        AddElement(AmtNode, 'InstdAmt', lNewAmountText, '', XMLNewChild);

        if PmtJnlLine."Currency Code" = '' then
            ISOCurrCode := 'USD'
        else begin
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := CopyStr(Currency."ISO Currency Code FND", 1, 3);
        end;

        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);
        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;

        lVend2.RESET;
        IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
            IF lVend2.GET(PmtJnlLine."Account No.") THEN;
        lIsDomesticTransfer := FALSE;
        IF (PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor) THEN BEGIN
            GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
            IF VendorBankAcc."Country/Region Code" = 'PA' THEN
                lIsDomesticTransfer := TRUE;
        END;
        if lIsDomesticTransfer then begin
            lPrtLctnValue := '001';

            AddElement(CdtTrfTxInfNode, 'ChqInstr', '', '', XMLNewChild);
            AddElement(XMLNewChild, 'PrtLctn', lPrtLctnValue, '', XMLNewChild);
        end;
        if not lIsDomesticTransfer then
            AddElement(CdtTrfTxInfNode, 'ChrgBr', 'DEBT', '', XMLNewChild);

        lIsIntermediaryBank := FALSE;
        lSWIFTCodeIntermediaryBank := '';
        //Intermediary Bank, 21.12.2022
        IF VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND" <> '' THEN BEGIN
            lIsIntermediaryBank := TRUE;
            lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND";
        END;

        if lIsIntermediaryBank then begin
            AddElement(CdtTrfTxInfNode, 'IntrmyAgt1', '', '', XMLNewChild);
            AddElement(XMLNewChild, 'FinInstnId', '', '', XMLNewChild);
            AddElement(XMLNewChild, 'BIC', CopyStr(DelChr(lSWIFTCodeIntermediaryBank), 1, 11), '', XMLNewChild);
        end;

        AddElement(CdtTrfTxInfNode, 'CdtrAgt', '', '', CdtrAgtNode);
        AddElement(CdtrAgtNode, 'FinInstnId', '', '', XMLNewChild);

        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    IF (lIsEURPayment = FALSE) THEN BEGIN
                        //HEI.08<<
                        AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
                        XMLNodeCurr := XMLNewChild;
                        IF lIsDomesticTransfer THEN BEGIN
                            //20.01.2023
                            //lMmbId := VendorBankAcc."Domestic - Bank Branch No."
                            lMmbId := '';
                            IF (VendorBankAcc."Bank Branch No." <> '') THEN
                                lMmbId := COPYSTR(VendorBankAcc."Bank Branch No.", 6, 3);
                        END
                        ELSE
                            lMmbId := VendorBankAcc."Bank Branch No.";
                        AddElement(XMLNodeCurr, 'MmbId', lMmbId, '', XMLNewChild);
                        VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);
                        IF (lIsDomesticTransfer = FALSE) THEN
                          //27.10.2022
                          BEGIN
                            AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                        END;
                        XMLNodeCurr := XMLNewChild;

                        GetCountry(VendorBankAcc."Country/Region Code");
                        IF ((Country."ISO Country/Region Code FND" <> '') AND (Country."ISO Country/Region Code FND" <> 'PA')) THEN
                            AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                        VendorBankAcc.Address := ReplaceTextCharacters(VendorBankAcc.Address);
                        VendorBankAcc."Address 2" := ReplaceTextCharacters(VendorBankAcc."Address 2");
                        AddressLine1 := DELCHR(VendorBankAcc.Address, '<>') + ' ' + DELCHR(VendorBankAcc."Address 2", '<>');
                        IF DELCHR(AddressLine1) <> '' THEN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                        VendorBankAcc.City := ReplaceTextCharacters(VendorBankAcc.City);
                        VendorBankAcc."Post Code" := ReplaceTextCharacters(VendorBankAcc."Post Code");//HEI.11
                        AddressLine2 := DELCHR(VendorBankAcc."Post Code", '<>') + ' ' + DELCHR(VendorBankAcc.City, '<>');
                        IF DELCHR(AddressLine2) <> '' THEN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        IF lIsDomesticTransfer THEN
                          //27.10.2022
                          BEGIN
                            AddElement(XMLNodeCurr, 'BrnchId', '', '', XMLNewChild);
                            XMLNodeCurr := XMLNewChild;
                            AddElement(XMLNodeCurr, 'Id', '0001', '', XMLNewChild);
                        END;

                        AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                        XMLNodeCurr := XMLNewChild;

                        GetVendor(PmtJnlLine."Account No.");
                        Vendor.Name := ReplaceTextCharacters(Vendor.Name);
                        AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                        XMLNodeCurr := XMLNewChild;

                        GetCountry(Vendor."Country/Region Code");
                        IF Country."ISO Country/Region Code FND" <> '' THEN
                            AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                        Vendor.Address := ReplaceTextCharacters(Vendor.Address);
                        Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
                        AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');
                        IF DELCHR(AddressLine1) <> '' THEN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                        Vendor.City := ReplaceTextCharacters(Vendor.City);
                        Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");//HEI.11
                        AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
                        IF DELCHR(AddressLine2) <> '' THEN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                        IF lIsDomesticTransfer THEN
                          //27.10.2022
                          BEGIN
                            //TXID
                            AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
                            XMLNodeCurr := XMLNewChild;

                            AddElement(XMLNodeCurr, 'PrvtId', '', '', XMLNewChild);
                            XMLNodeCurr := XMLNewChild;

                            AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
                            XMLNodeCurr := XMLNewChild;
                            AddElement(XMLNodeCurr, 'Id', lVend2."VAT Registration No.", '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'SchmeNm', '', '', XMLNewChild);
                            XMLNodeCurr := XMLNewChild;

                            AddElement(XMLNodeCurr, 'Cd', 'TXID', '', XMLNewChild);

                        END;

                    END;
                    CASE PmtJnlLine."Account Type" OF
                        PmtJnlLine."Account Type"::Customer:
                            BEGIN
                                GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                                AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
                                AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                                XMLNodeCurr := XMLNewChild;

                                GetCountry(CustomerBankAcc."Country/Region Code");
                                IF Country."ISO Country/Region Code FND" <> '' THEN
                                    AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                                AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
                                IF DELCHR(AddressLine1) <> '' THEN
                                    AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                                AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
                                IF DELCHR(AddressLine2) <> '' THEN
                                    AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                                AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                                XMLNodeCurr := XMLNewChild;

                                GetCustomer(PmtJnlLine."Account No.");
                                AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
                                AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                                XMLNodeCurr := XMLNewChild;

                                GetCountry(Customer."Country/Region Code");
                                IF Country."ISO Country/Region Code FND" <> '' THEN
                                    AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                                AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
                                IF DELCHR(AddressLine1) <> '' THEN
                                    AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                                AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
                                IF DELCHR(AddressLine2) <> '' THEN
                                    AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                            END;
                    END;

                    AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);

                    IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
                        CASE PmtJnlLine."Account Type" OF
                            PmtJnlLine."Account Type"::Customer:
                                BEGIN
                                    CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                                    BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                                    BeneficiaryIBAN := CustBankAcc.IBAN;
                                    GetCountry(CustBankAcc."Country/Region Code");
                                END;
                            PmtJnlLine."Account Type"::Vendor:
                                BEGIN
                                    VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                                    BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                                    BeneficiaryIBAN := VendBankAcc.IBAN;
                                    GetCountry(VendBankAcc."Country/Region Code");
                                END;
                        END
                    ELSE BEGIN
                        BeneficiaryBankAccountNo := '';
                        BeneficiaryIBAN := '';
                        Country."IBAN Country/Region FND" := FALSE;
                    END;
                    if lIsEURPayment then
                        IBANTransfer := (BeneficiaryIBAN <> '')
                    else
                        IBANTransfer := (BeneficiaryIBAN <> '') and Country."IBAN Country/Region FND";

                    if IBANTransfer then
                        AddElement(XMLNewChild, 'IBAN', CopyStr(DelChr(BeneficiaryIBAN), 1, 34), '', XMLNewChild)
                    else begin
                        AddElement(XMLNewChild, 'Othr', '', '', XMLNewChild);
                        AddElement(XMLNewChild, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
                    end;

                    AddElement(XMLNodeCurr, 'Tp', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    AddElement(XMLNodeCurr, 'Cd', 'CACC', '', XMLNewChild);
                    IF lIsDomesticTransfer THEN
                      //27.10.2022
                      BEGIN
                        AddElement(XMLNodeCurr, 'Purp', '', '', XMLNewChild);
                        XMLNodeCurr := XMLNewChild;
                        AddElement(XMLNodeCurr, 'Prtry', '01', '', XMLNewChild);
                    END;

                    AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    lTotalExtDocNo := '';
                    lPmtJnlLine.RESET;
                    lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
                    lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
                    lPmtJnlLine.SETRANGE("Parent Line No. FND", PmtJnlLine."Line No.");
                    IF lPmtJnlLine.FINDSET(FALSE) THEN
                        REPEAT
                            IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
                                IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
                                    IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
                                        lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.", STRLEN(lPurchInvHeader."Vendor Invoice No.") - 8, 9)
                                    ELSE
                                        lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
                                    lTotalExtDocNo += lVendInvNo + ',';
                                END;
                        UNTIL lPmtJnlLine.NEXT = 0;
                    IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
                        lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
                        lTotalExtDocNo := lText50000 + lTotalExtDocNo;
                        //HEI.14
                        IF (STRLEN(lTotalExtDocNo) <= 35) THEN
                            AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
                        IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
                            AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                        END;
                        IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
                            AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
                        END;
                        IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
                            AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
                        END;
                    END
                    ELSE
                        AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);
                    XMLNodeCurr := RootNode;
                END;
        end;
    end;
    //    BC UPGRADE KUMARR78 << Rewriting Function ExportTransactionInformationPanama. 


    //BC UPGRADE KUMARR78 >> Blocking to Replace entire Function. 
    // procedure CreateNonSepaContentEthiopiaCBE(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     lNonSepaContent: Text;
    //     OutStr: OutStream;
    //     inStr: InStream;
    //     MyText: Text;
    //     XMLDOMManagement: Codeunit "6224";
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     BigText: BigText;
    //     XMLText: Text;
    //     filRead: File;
    //     intLen: Integer;
    //     txtOneLine: Text;
    //     txtFromFile: Text;
    //     TodayString: Text;
    //     FileName1: Text;
    //     InStream: InStream;
    //     i: Integer;
    //     j: Integer;
    //     k: Integer;
    //     k1: Integer;
    //     k3: Integer;
    //     TxtToAddInComponent: Text[80];
    //     InterfaceEntryComponent: Record "50003";
    //     c: Integer;
    //     cString: Text;
    //     NewPaymentGroup: Boolean;
    //     lGenJournalLine: Record "Gen. Journal Line BC FND";
    //     Pos: Integer;
    //     lGenJournalLine81: Record "81";
    //     lHNKBankAccount: Code[20];
    // begin
    //     //HEI.02>>
    //     //Ethiopia CBE
    //     CompanyInfo.GET;

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     //XMLRootElement.SetAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //     GMessageId := MessageId;
    //     StartGroupHeader(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;


    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
    //     IF lGenJournalLine.FINDFIRST THEN
    //         REPEAT
    //             //HEI.07>>
    //             IF (lGenJournalLine."HNK Bank Account" <> '') THEN
    //                 lHNKBankAccount := lGenJournalLine."HNK Bank Account";
    //             //HEI.07<<
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
    //                 ExportTransactionInformationEthiopiaCBE(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
    //                 InitConsolidatedPayment(lGenJournalLine);
    //             END ELSE
    //                 UpdateConsolidatedPayment(lGenJournalLine);

    //             IF NewPaymentGroup THEN
    //                 ExportPaymentInformationEthiopiaCBE(CstmrCdtTrfInitnNode, lGenJournalLine);
    //         UNTIL lGenJournalLine.NEXT = 0;

    //     IF NOT EmptyConsolidatedPayment THEN
    //         ExportTransactionInformationEthiopiaCBE(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

    //     //Footer
    //     //HEI.07>>
    //     //FinishGroupHeader;
    //     FinishGroupHeaderEthiopiaCBE(lHNKBankAccount);
    //     //HEI.07<<

    //     IF DATE2DMY(TODAY, 2) < 10 THEN
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
    //     ELSE
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

    //     FileName := SaveToFileNameClient;

    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName, FileName);
    //     FullFileName := FileName;

    //     filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);

    //     intLen := filRead.LEN;
    //     txtFromFile := '';

    //     InterfaceEntryComponent.RESET;
    //     c := 1;
    //     cString := 'C0001';

    //     filRead.CREATEINSTREAM(InStream);
    //     WHILE NOT InStream.EOS DO BEGIN
    //         InStream.READTEXT(txtFromFile);
    //         i := STRLEN(txtFromFile);

    //         k := i DIV 80;
    //         k1 := i MOD 80;

    //         IF k1 <> 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k + 1 DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;

    //         IF k1 = 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;
    //     END;

    //     TxtToAddInComponent := ']]>';
    //     InterfaceEntryComponent.RESET;
    //     InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //     InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //     InterfaceEntryComponent.Code := FORMAT(cString);
    //     InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //     InterfaceEntryComponent.INSERT;
    //     c += 1;
    //     cString := INCSTR(cString);

    //     filRead.CLOSE;

    //     IF EXISTS(SaveToFileName) THEN
    //         IF ERASE(SaveToFileName) THEN;

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.DELETEALL;

    //     lGenJournalLine81.RESET;
    //     lGenJournalLine81.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine81.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine81.SETFILTER("Parent Line No.", '=%1', 0);
    //     lGenJournalLine81.MODIFYALL("WS Posting Allowed FND", TRUE);
    //     //HEI.02<<
    // end;
    //BC UPGRADE KUMARR78 >> Blocking to Replace entire Function.

    //BC UPGRADE KUMARR78 >> Replacing entire CreateNonSepaContentEthiopiaCBE Function Code. 
    procedure CreateNonSepaContentEthiopiaCBE(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text;
    var
        TempBlob: Codeunit "Temp Blob";
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XMLNodeCurr: XmlNode;
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lHNKBankAccount: Code[20];
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
        XMlns: Integer;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        //XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);

        // RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;
        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeader(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
        IF lGenJournalLine.FINDFIRST THEN
            REPEAT
                //HEI.07>>
                IF (lGenJournalLine."HNK Bank Account" <> '') THEN
                    lHNKBankAccount := lGenJournalLine."HNK Bank Account";
                //HEI.07<<
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                    ExportTransactionInformationEthiopiaCBE(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationEthiopiaCBE(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationEthiopiaCBE(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

        FinishGroupHeaderEthiopiaCBE(lHNKBankAccount);

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);
        XMLText := DelStr(XMLText, StrPos(XMLText, 'standalone=" "'), StrLen('standalone=" "'));

        c := 1;
        cString := 'C0001';
        While NOT InStr.EOS DO BEGIN
            if c <> 1 then
                InStr.READTEXT(XMLText);

            i := StrLen(XMLText);
            k := i div 80;
            k1 := i mod 80;
            k3 := 1;

            //for j := 1 to k do begin
            if k1 <> 0 then begin
                k3 := 1;
                for j := 1 to k + 1 do begin
                    txtOneLine := CopyStr(XMLText, k3, 80);
                    k3 += 80;

                    TxtToAddInComponent := txtOneLine;

                    //Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;

            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN

                    txtOneLine := CopyStr(XMLText, k3, 80);

                    TxtToAddInComponent := txtOneLine;

                    //Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';
                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);

        exit(XMLText);

    end;
    // BC UPGRADE KUMARR78 >>  Replacing entire CreateNonSepaContentEthiopiaCBE Function Code.

    // // BC UPGRADE KUMARR78 >>  Blocking to Replace entire Function Code.
    // procedure ExportTransactionInformationEthiopiaCBE(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    // var
    //     GLSetup: Record "98";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     ISOCurrCode: Text[3];
    //     IBANTransfer: Boolean;
    //     VendorBankAccount: Record "288";
    //     BeneficiaryIBAN: Code[50];
    //     CustomerBankAccount: Record "287";
    //     BeneficiaryBankAccountNo: Code[30];
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     CustBankAcc: Record "287";
    //     VendBankAcc: Record "288";
    //     lSWIFTCode: Code[20];
    //     lBeneficiaryBankAccount: Code[30];
    //     lCust: Record "18";
    //     lVend: Record "23";
    //     CountryIBANCountryRegion: Boolean;
    //     lNewAmountText: Text;
    //     lBankExportImportSetup: Record "1200";
    //     lPosition: Integer;
    //     lCurrency: Record "4";
    //     BICICIABPos: Integer;
    //     CI93Pos: Integer;
    //     lPrtLctnValue: Text[10];
    //     lVend2: Record "23";
    // begin
    //     //HEI.02>>
    //     WITH PmtJnlLine DO BEGIN
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         //HEI.07>>
    //         //AddElement(XMLNodeCurr,'EndToEndId',CutText(PaymentMessage,35),'',XMLNewChild);
    //         AddElement(XMLNodeCurr, 'EndToEndId', CutText(PmtJnlLine."Document No.", 20), '', XMLNewChild);
    //         //HEI.07<<
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         //AddElement(XMLNodeCurr,'InstdAmt',FORMAT(Amount,0,9),'',XMLNewChild);
    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;


    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);

    //         IF "Currency Code" = '' THEN
    //             ISOCurrCode := COPYSTR(GLSetup."LCY Code", 1, 3)
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
    //         END;
    //         AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         lCust.GET("Account No.");
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := CustBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := CustBankAcc.Code;
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         lVend.GET("Account No.");
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := VendBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := VendBankAcc.Code;
    //                     END;
    //             END
    //         ELSE BEGIN
    //             lSWIFTCode := '';
    //             lBeneficiaryBankAccount := '';
    //         END;

    //         AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(lSWIFTCode), 1, 11), '', XMLNewChild);

    //         CASE "Account Type" OF
    //             "Account Type"::Vendor:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(VendorBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(VendorBankAcc.Address, '<>') + ' ' + DELCHR(VendorBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(VendorBankAcc."Post Code", '<>') + ' ' + DELCHR(VendorBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetVendor("Account No.");
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Vendor."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //             "Account Type"::Customer:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(CustomerBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCustomer("Account No.");
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Customer."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //         END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := CustBankAcc.IBAN;
    //                         CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
    //                         IF CI93Pos <> 0 THEN
    //                             BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

    //                         //BICICIABPos := STRPOS(BankAcc."SWIFT Code",'BICICIAB');
    //                         BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
    //                         IF BICICIABPos <> 0 THEN
    //                             BeneficiaryIBAN := '';
    //                         IF Country.Code <> 'CI' THEN
    //                             BeneficiaryIBAN := '';
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                         CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
    //                         IF CI93Pos <> 0 THEN
    //                             BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

    //                         //BICICIABPos := STRPOS(BankAcc."SWIFT Code",'BICICIAB');
    //                         BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
    //                         IF BICICIABPos <> 0 THEN
    //                             BeneficiaryIBAN := '';
    //                         IF Country.Code <> 'CI' THEN
    //                             BeneficiaryIBAN := '';
    //                     END;
    //             END
    //         ELSE BEGIN
    //             BeneficiaryBankAccountNo := '';
    //             BeneficiaryIBAN := '';
    //             Country."IBAN Country/Region" := FALSE;
    //         END;

    //         // If IBAN Transfer then Export IBAN else BBAN
    //         IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region";
    //         IF IBANTransfer THEN
    //             AddElement(XMLNodeCurr, 'IBAN', COPYSTR(DELCHR(BeneficiaryIBAN), 1, 34), '', XMLNewChild)
    //         ELSE BEGIN
    //             AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);

    //         XMLNodeCurr := RootNode;
    //     END;
    //     //HEI.02<<
    // end;
    // BC UPGRADE KUMARR78 <<  Blocking to Replace entire Function Code.
    // BC UPGRADE KUMARR78 <<  Replacing  entire ExportTransactionInformationEthiopiaCBE Function Code.

    procedure ExportTransactionInformationEthiopiaCBE(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lCurrency: Record Currency;
        lCust: Record Customer;
        CustBankAcc: Record "Customer Bank Account";
        GLSetup: Record "General Ledger Setup";
        lVend: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        IBANTransfer: Boolean;
        lSWIFTCode: Code[20];
        BeneficiaryBankAccountNo: Code[30];
        lBeneficiaryBankAccount: Code[30];
        BeneficiaryIBAN: Code[50];
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPosition: Integer;
        lNewAmountText: Text;
        ISOCurrCode: Text[3];
        AddressLine2: Text[60];
        AddressLine1: Text[110];
        AmtNode: XmlNode;
        CdtrAcctNode: XmlNode;
        CdtrNode: XmlNode;
        CdtTrfTxInfNode: XmlNode;
        IdNode: XmlNode;
        PmtIdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        RootNode: XmlNode;
        XMLNewChild: XmlNode;
    begin
        //HEI.02>>
        GLSetup.GET;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;
        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
        AddElement(CdtTrfTxInfNode, 'PmtId', '', '', XMLNewChild);
        AddElement(PmtIdNode, 'EndToEndId', CutText(PaymentMessage, 35), '', XMLNewChild);
        AddElement(CdtTrfTxInfNode, 'Amt', '', '', XMLNewChild);

        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;


        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);

        IF PmtJnlLine."Currency Code" = '' THEN
            ISOCurrCode := COPYSTR(GLSetup."LCY Code", 1, 3)
        ELSE BEGIN
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
        END;
        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);
        AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;

        AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(lSWIFTCode), 1, 11), '', XMLNewChild);

        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(VendorBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(VendorBankAcc.Address, '<>') + ' ' + DELCHR(VendorBankAcc."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(VendorBankAcc."Post Code", '<>') + ' ' + DELCHR(VendorBankAcc.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetVendor(PmtJnlLine."Account No.");
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Vendor."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                END;
            PmtJnlLine."Account Type"::Customer:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(CustomerBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCustomer(PmtJnlLine."Account No.");
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Customer."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                END;
        END;

        AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                        BeneficiaryIBAN := CustBankAcc.IBAN;
                        CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
                        IF CI93Pos <> 0 THEN
                            BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));
                        //BICICIABPos := STRPOS(BankAcc."SWIFT Code",'BICICIAB');
                        BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
                        IF BICICIABPos <> 0 THEN
                            BeneficiaryIBAN := '';
                        IF Country.Code <> 'CI' THEN
                            BeneficiaryIBAN := '';
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");
                        CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
                        IF CI93Pos <> 0 THEN
                            BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));
                        //BICICIABPos := STRPOS(BankAcc."SWIFT Code",'BICICIAB');
                        BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
                        IF BICICIABPos <> 0 THEN
                            BeneficiaryIBAN := '';
                        IF Country.Code <> 'CI' THEN
                            BeneficiaryIBAN := '';
                    END;
            END
        ELSE BEGIN
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := FALSE;
        END;
        // If IBAN Transfer then Export IBAN else BBAN
        IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region FND";
        IF IBANTransfer THEN
            AddElement(XMLNodeCurr, 'IBAN', COPYSTR(DELCHR(BeneficiaryIBAN), 1, 34), '', XMLNewChild)
        ELSE BEGIN
            AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
            XMLNodeCurr := XMLNewChild;
            AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
        END;
        AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);

        XMLNodeCurr := RootNode;
        //HEI.02<<
    end;
    //BC UPGRADE KUMARR78 << Replacing Entire Function Code

    //BC UPGRADE KUMARR78 >> Blocking Entire Function Code
    // local procedure ExportPaymentInformationEthiopiaCBE(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     InstructionPriority: Text[10];
    //     ChargeBearer: Text[4];
    //     BICICIABPos: Integer;
    //     lVendor: Record "23";
    //     VendBankAcc: Record "288";
    //     BeneficiaryBankAccountNo: Text[30];
    // begin
    //     //HEI.02>>
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;

    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'BtchBookg', 'false', '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     CASE PmtJnlLine."Instruction Priority" OF
    //         PmtJnlLine."Instruction Priority"::Normal:
    //             InstructionPriority := 'NORM';
    //         PmtJnlLine."Instruction Priority"::High:
    //             InstructionPriority := 'HIGH';
    //     END;
    //     AddElement(XMLNodeCurr, 'InstrPrty', InstructionPriority, '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Nm', CompanyInfo.Name, '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetCountry(CompanyInfo."Country/Region Code");

    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //     AddressLine1 := DELCHR(CompanyInfo.Address, '<>') + ' ' + DELCHR(CompanyInfo."Address 2", '<>');
    //     IF DELCHR(AddressLine1) <> '' THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //     AddressLine2 := DELCHR(CompanyInfo."Post Code", '<>') + ' ' + DELCHR(CompanyInfo.City, '<>');
    //     IF DELCHR(AddressLine2) <> '' THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");

    //     AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     CASE PmtJnlLine."Code Expenses" OF
    //         PmtJnlLine."Code Expenses"::" ",
    //       PmtJnlLine."Code Expenses"::SHA:
    //             ChargeBearer := 'SHAR';
    //         PmtJnlLine."Code Expenses"::BEN:
    //             ChargeBearer := 'CRED';
    //         PmtJnlLine."Code Expenses"::OUR:
    //             ChargeBearer := 'DEBT';
    //     END;

    //     AddElement(XMLNodeCurr, 'ChrgBr', ChargeBearer, '', XMLNewChild);

    //     XMLNodeCurr := RootNode;
    //     //HEI.02<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking Function to Rewrite.
    //BC UPGRADE KUMARR78 >> Rewriting ExportPaumentInformationEthiopiaCBE Function.
    local procedure ExportPaymentInformationEthiopiaCBE(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;
        PmtInfNodeLocal: XmlNode;
        PmtTpInfNode: XmlNode;
        DbtrNode: XmlNode;
        PstlAdrNode: XmlNode;
        DbtrAcctNode: XmlNode;
        IdNode: XmlNode;
        OthrNode: XmlNode;
        DbtrAgtNode: XmlNode;
        FinInstnIdNode: XmlNode;

        AddressLine1: Text[110];
        AddressLine2: Text[60];
        InstructionPriority: Text[10];
        ChargeBearer: Text[4];

        lVendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        BeneficiaryBankAccountNo: Text[30];
    begin
        RootNode := XMLNodeCurr;

        PaymentInformationCounter += 1;

        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        PmtInfNodeLocal := XMLNewChild;
        PmtInfNode := XMLNewChild;

        AddElement(PmtInfNodeLocal, 'PmtInfId', MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);
        AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);
        AddElement(PmtInfNodeLocal, 'BtchBookg', 'false', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'PmtTpInf', '', '', XMLNewChild);
        PmtTpInfNode := XMLNewChild;

        case PmtJnlLine."Instruction Priority" of
            PmtJnlLine."Instruction Priority"::Normal:
                InstructionPriority := 'NORM';
            PmtJnlLine."Instruction Priority"::High:
                InstructionPriority := 'HIGH';
        end;

        AddElement(PmtTpInfNode, 'InstrPrty', InstructionPriority, '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'ReqdExctnDt', Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'Dbtr', '', '', XMLNewChild);
        DbtrNode := XMLNewChild;

        AddElement(DbtrNode, 'Nm', CompanyInfo.Name, '', XMLNewChild);

        AddElement(DbtrNode, 'PstlAdr', '', '', XMLNewChild);
        PstlAdrNode := XMLNewChild;

        GetCountry(CompanyInfo."Country/Region Code");

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(PstlAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

        AddressLine1 := DelChr(CompanyInfo.Address, '<>') + ' ' + DelChr(CompanyInfo."Address 2", '<>');
        if DelChr(AddressLine1) <> '' then
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);

        AddressLine2 := DelChr(CompanyInfo."Post Code", '<>') + ' ' + DelChr(CompanyInfo.City, '<>');
        if DelChr(AddressLine2) <> '' then
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAcct', '', '', XMLNewChild);
        DbtrAcctNode := XMLNewChild;

        AddElement(DbtrAcctNode, 'Id', '', '', XMLNewChild);
        IdNode := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        AddElement(IdNode, 'Othr', '', '', XMLNewChild);
        OthrNode := XMLNewChild;

        AddElement(OthrNode, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAgt', '', '', XMLNewChild);
        DbtrAgtNode := XMLNewChild;

        AddElement(DbtrAgtNode, 'FinInstnId', '', '', XMLNewChild);
        FinInstnIdNode := XMLNewChild;

        AddElement(FinInstnIdNode, 'BIC', CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

        case PmtJnlLine."Code Expenses" of
            PmtJnlLine."Code Expenses"::" ",
            PmtJnlLine."Code Expenses"::SHA:
                ChargeBearer := 'SHAR';
            PmtJnlLine."Code Expenses"::BEN:
                ChargeBearer := 'CRED';
            PmtJnlLine."Code Expenses"::OUR:
                ChargeBearer := 'DEBT';
        end;

        AddElement(PmtInfNodeLocal, 'ChrgBr', ChargeBearer, '', XMLNewChild);

        XMLNodeCurr := RootNode;

        //HEI.02<<
    end;
    //BC UPGRADE KUMARR78 << Writing Entire function ExportPaymentInformationEthiopisCBE.

    local procedure ReplaceTextCharacters(TextToBeChanged: Text): Text;
    var
        CurrentText: Text;
    begin
        CurrentText := TextToBeChanged;

        BankConnReplaceCharacters.RESET;
        BankConnReplaceCharacters.SETRANGE("Delete Character", TRUE);
        IF BankConnReplaceCharacters.FINDSET(FALSE) THEN
            REPEAT
                CurrentText := ReplaceString(CurrentText, BankConnReplaceCharacters."Character to be Replaced", '');
            UNTIL BankConnReplaceCharacters.NEXT = 0;

        BankConnReplaceCharacters.RESET;
        BankConnReplaceCharacters.SETRANGE("Delete Character", FALSE);
        IF BankConnReplaceCharacters.FINDSET(FALSE) THEN
            REPEAT
                CurrentText := ReplaceString(CurrentText, BankConnReplaceCharacters."Character to be Replaced", BankConnReplaceCharacters."New Character");
            UNTIL BankConnReplaceCharacters.NEXT = 0;

        EXIT(CurrentText);
    end;

    procedure ValidatePaymentContentPanama(GenJournalLine: Record "Gen. Journal Line BC FND"): Text;
    var
        // TempBlob: Record "99008535" temporary; //BC UPGRADE KUMARR78 Not in use in this function
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        //BC UPGRADE KUMARR78 >> Blocking to Change Variable.
        // XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking to Change Variable.

        //BC UPGRADE KUMARR78 >> Changing Variable.
        XMLRootElement: xmlelement;
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;
        //BC UPGRADE KUMARR78 << Changing Variable.
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lVendor: Record Vendor;
        lCountryRegion: Record "Country/Region";
        lText001: Label 'Company Information Address or Company Information Address 2 must have a value!';
        lText002: Label 'Company Information Post Code or Company Information City must have a value!';
        lBankAccount: Record "Bank Account";
        lCurrency: Record Currency;
        lVendorBankAccount: Record "Vendor Bank Account";
        lText003: Label 'Vendor Address or Vendor Address 2 must have a value for vendor %1!';
        lText004: Label 'Vendor Post Code or Vendor City must have a value for vendor %1!';
        lText005: Label 'Field %1 cannot be empty for %2 %3!';
        lText006: Label 'Field %1 cannot be empty in %2!';
        lText007: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText008: Label 'Panama Bank Routing Code cannot be empty for %2 %3 Vendor %4!';
    begin
        CompanyInfo.GET;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);

        IF lGenJournalLine.FINDSET(FALSE) THEN
            REPEAT
                IF (CompanyInfo.Name = '') THEN
                    ERROR(lText006, CompanyInfo.FIELDCAPTION(Name), CompanyInfo.TABLECAPTION);
                IF (CompanyInfo."Country/Region Code" = '') THEN
                    ERROR(lText006, CompanyInfo.FIELDCAPTION("Country/Region Code"), CompanyInfo.TABLECAPTION);
                IF (lGenJournalLine."Posting Date" = 0D) THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Posting Date"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."HNK Bank Account" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("HNK Bank Account"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Document No." = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Document No."), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Message to Recipient" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Message to Recipient"), lGenJournalLine81.TABLECAPTION);

                IF (CompanyInfo.Address + CompanyInfo."Address 2" = '') THEN
                    ERROR(lText001);
                IF (CompanyInfo."Post Code" + CompanyInfo.City = '') THEN
                    ERROR(lText002);

                IF lCountryRegion.GET(CompanyInfo."Country/Region Code") THEN
                    lCountryRegion.TESTFIELD("ISO Country/Region Code FND");

                IF lVendor.GET(lGenJournalLine."Account No.") THEN BEGIN
                    IF (lVendor.Name = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION(Name), lVendor.TABLECAPTION, lVendor."No.");
                    IF (lVendor."Payment Method Code" = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION("Payment Method Code"), lVendor.TABLECAPTION, lVendor."No.");
                    IF (lVendor."Country/Region Code" = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION("Country/Region Code"), lVendor.TABLECAPTION, lVendor."No.");

                    IF lCountryRegion.GET(lVendor."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendor."Country/Region Code");

                    IF (lVendor.Address + lVendor."Address 2" = '') THEN
                        ERROR(lText003, lVendor."No.");
                    IF (lVendor."Post Code" + lVendor.City = '') THEN
                        ERROR(lText004, lVendor."No.");
                END;

                IF lBankAccount.GET(lGenJournalLine."HNK Bank Account") THEN BEGIN
                    IF (lBankAccount."SWIFT Code" = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("SWIFT Code"), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");

                    IF (lBankAccount."Bank Account No." = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("Bank Account No."), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");
                END;

                IF (lGenJournalLine."Currency Code" <> '') THEN
                    IF lCurrency.GET(lGenJournalLine."Currency Code") THEN
                        IF (lCurrency."ISO Currency Code FND" = '') THEN
                            ERROR(lText005, lCurrency.FIELDCAPTION("ISO Currency Code FND"), lCurrency.TABLECAPTION, lCurrency.Code);

                IF lVendorBankAccount.GET(lGenJournalLine."Account No.", lGenJournalLine."Customer/Vendor Bank") THEN BEGIN
                    IF (lVendorBankAccount.Name = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION(Name), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Country/Region Code" = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Country/Region Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    //HEI.18>>
                    IF lGenJournalLine."Currency Code" = 'EUR' THEN
                        IF (lVendorBankAccount.IBAN = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION(IBAN), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    //HEI.18<<

                    IF lCountryRegion.GET(lVendorBankAccount."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendorBankAccount."Country/Region Code");

                    IF (lVendorBankAccount."Bank Account No." = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Account No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    IF lVendorBankAccount."Country/Region Code" = 'PA' THEN BEGIN
                        //commented on 20.01.2023, as the "Panama Bank Routing Code" (field "Domestic - Bank Branch No.") will be taken from "Bank Branch No."
                        //IF (lVendorBankAccount."Domestic - Bank Branch No." = '') THEN
                        //  ERROR(lText007,lVendorBankAccount.FIELDCAPTION("Domestic - Bank Branch No."),lVendorBankAccount.TABLECAPTION,lVendorBankAccount.Code,lGenJournalLine."Account No.");
                        //added on 20.01.2023
                        IF (lVendorBankAccount."Bank Branch No." = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Branch No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                        IF (COPYSTR(lVendorBankAccount."Bank Branch No.", 6, 3) = '') THEN
                            ERROR(lText008, lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                        IF (lVendor."VAT Registration No." = '') THEN
                            ERROR(lText005, lVendor.FIELDCAPTION("VAT Registration No."), lVendor.TABLECAPTION, lVendor."No.");
                    END
                    ELSE BEGIN
                        IF (lVendorBankAccount."SWIFT Code" = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION("SWIFT Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                        IF (lVendorBankAccount."Bank Branch No." = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Branch No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    END;
                END;
            UNTIL lGenJournalLine.NEXT = 0;
    end;

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite Function.
    // procedure CreateNonSepaContentMZ(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     lNonSepaContent: Text;
    //     OutStr: OutStream;
    //     inStr: InStream;
    //     MyText: Text;
    //     XMLDOMManagement: Codeunit "6224";
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     BigText: BigText;
    //     XMLText: Text;
    //     filRead: File;
    //     intLen: Integer;
    //     txtOneLine: Text;
    //     txtFromFile: Text;
    //     TodayString: Text;
    //     FileName1: Text;
    //     InStream: InStream;
    //     i: Integer;
    //     j: Integer;
    //     k: Integer;
    //     k1: Integer;
    //     k3: Integer;
    //     TxtToAddInComponent: Text[80];
    //     InterfaceEntryComponent: Record "50003";
    //     c: Integer;
    //     cString: Text;
    //     NewPaymentGroup: Boolean;
    //     lGenJournalLine: Record "Gen. Journal Line BC FND";
    //     Pos: Integer;
    //     lGenJournalLine81: Record "81";
    // begin
    //     //HEI.03>>
    //     CompanyInfo.GET;

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //     GMessageId := MessageId;
    //     StartGroupHeader(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;
    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');
    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
    //     IF lGenJournalLine.FINDFIRST THEN
    //         REPEAT
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
    //                 ExportTransactionInformationMZ(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
    //                 InitConsolidatedPayment(lGenJournalLine);
    //             END ELSE
    //                 UpdateConsolidatedPayment(lGenJournalLine);

    //             IF NewPaymentGroup THEN
    //                 ExportPaymentInformationMZ(CstmrCdtTrfInitnNode, lGenJournalLine);
    //         UNTIL lGenJournalLine.NEXT = 0;

    //     IF NOT EmptyConsolidatedPayment THEN
    //         ExportTransactionInformationMZ(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

    //     //Footer
    //     FinishGroupHeaderMZ;

    //     IF DATE2DMY(TODAY, 2) < 10 THEN
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
    //     ELSE
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

    //     FileName := SaveToFileNameClient;

    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName, FileName);
    //     FullFileName := FileName;

    //     filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);

    //     intLen := filRead.LEN;
    //     txtFromFile := '';

    //     InterfaceEntryComponent.RESET;
    //     c := 1;
    //     cString := 'C0001';

    //     filRead.CREATEINSTREAM(InStream);
    //     WHILE NOT InStream.EOS DO BEGIN
    //         InStream.READTEXT(txtFromFile);
    //         i := STRLEN(txtFromFile);

    //         k := i DIV 80;
    //         k1 := i MOD 80;

    //         IF k1 <> 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k + 1 DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     //HEI.04>>
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';
    //                 //TxtToAddInComponent := '[<?xml version="1.0" encoding="UTF-8"?>';
    //                 //HEI.04<<

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;

    //         IF k1 = 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     //HEI.04>>
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';
    //                 //TxtToAddInComponent := '[<?xml version="1.0" encoding="UTF-8"?>';
    //                 //HEI.04<<

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;
    //     END;
    //     //HEI.04>>
    //     TxtToAddInComponent := ']]>';
    //     //TxtToAddInComponent := ']';
    //     //HEI.04<<
    //     InterfaceEntryComponent.RESET;
    //     InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //     InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //     InterfaceEntryComponent.Code := FORMAT(cString);
    //     InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');

    //     InterfaceEntryComponent.INSERT;
    //     c += 1;
    //     cString := INCSTR(cString);

    //     filRead.CLOSE;

    //     IF EXISTS(SaveToFileName) THEN
    //         IF ERASE(SaveToFileName) THEN;

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.DELETEALL;

    //     lGenJournalLine81.RESET;
    //     lGenJournalLine81.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine81.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine81.SETFILTER("Parent Line No.", '=%1', 0);
    //     lGenJournalLine81.MODIFYALL("WS Posting Allowed FND", TRUE);
    //     //HEI.03<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite Function.

    //BC UPGRADE KUMARR78 >> Rewrite Function CreateNonSepaContentMZ
    procedure CreateNonSepaContentMZ(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text;
    var
        TempBlob: Codeunit "Temp Blob";
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XMLNodeCurr: XmlNode;
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lHNKBankAccount: Code[20];
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
        XmlNS: Integer;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        //XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);
        // RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        //XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;

        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeader(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
        IF lGenJournalLine.FINDFIRST THEN
            REPEAT
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                    ExportTransactionInformationMZ(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationMZ(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationMZ(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

        FinishGroupHeaderMZ;

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);
        XMLText := DelStr(XMLText, StrPos(XMLText, 'standalone=" "'), StrLen('standalone=" "'));

        c := 1;
        cString := 'C0001';
        While NOT InStr.EOS DO BEGIN
            if c <> 1 then
                InStr.READTEXT(XMLText);
            i := StrLen(XMLText);
            k := i div 80;
            k1 := i mod 80;
            if k1 <> 0 then begin
                k3 := 1;

                for j := 1 to k + 1 do begin
                    txtOneLine := CopyStr(XMLText, k3, 80);
                    k3 += 80;

                    TxtToAddInComponent := txtOneLine;

                    //Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';
                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;

            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN
                    txtOneLine := CopyStr(XMLText, k3, 80);

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);

        exit(XMLText);
    end;
    //BC UPGRADE KUMARR78 <<Rewrite Function CreateNonSepaContentMZ.

    //BC UPGRADE KUMARR78 >> Blocking to rewrite Function.
    // procedure ExportTransactionInformationMZ(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    // var
    //     GLSetup: Record "98";
    //     AddressLine1: Text[210];
    //     AddressLine2: Text[60];
    //     ISOCurrCode: Text[3];
    //     IBANTransfer: Boolean;
    //     VendorBankAccount: Record "288";
    //     BeneficiaryIBAN: Code[50];
    //     CustomerBankAccount: Record "287";
    //     BeneficiaryBankAccountNo: Code[30];
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     CustBankAcc: Record "287";
    //     VendBankAcc: Record "288";
    //     lSWIFTCode: Code[20];
    //     lBeneficiaryBankAccount: Code[30];
    //     lCust: Record "18";
    //     lVend: Record "23";
    //     CountryIBANCountryRegion: Boolean;
    //     lNewAmountText: Text;
    //     lBankExportImportSetup: Record "1200";
    //     lPosition: Integer;
    //     lCurrency: Record "4";
    //     BICICIABPos: Integer;
    //     CI93Pos: Integer;
    //     lPrtLctnValue: Text[10];
    //     lVend2: Record "23";
    //     Othid: Code[30];
    //     InstdAmt: Label 'InstdAmt';
    //     BICValidation: Label 'For Vendor No %1 and Vendor Bank account %2, SWIFT Code should not be Blank!';
    //     CtryValidation: Label 'For Vendor No %1 and Vendor Bank account %2, Country Code should not be Blank!';
    //     AccountLengthCheck: Label 'For Vendor No %1 and Vendor Bank account %2, Account No should be 21 Digits only!';
    //     AccountValidation: Label 'For Vendor No %1 and Vendor Bank account %2, Account No should not be Blank!';
    //     Ad1: Text[33];
    //     Ad2: Text[33];
    //     Ad3: Text[33];
    // begin
    //     //HEI.03>>
    //     WITH PmtJnlLine DO BEGIN
    //         //HEI.10>>
    //         IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
    //             BankDetailsCheck(BankAcc, VendBankAcc, PmtJnlLine."Currency Code");
    //         //HEI.10<<
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'EndToEndId', PmtJnlLine."Document No.", '', XMLNewChild);

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'InstrPrty', 'NORM', '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;


    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;


    //         AddElement(XMLNodeCurr, InstdAmt, lNewAmountText, '', XMLNewChild);

    //         IF "Currency Code" = '' THEN
    //             ISOCurrCode := COPYSTR(GLSetup."LCY Code", 1, 3)
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
    //         END;
    //         AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         AddElement(XMLNodeCurr, 'ChrgBr', 'DEBT', '', XMLNewChild);

    //         AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         lCust.GET("Account No.");
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := CustBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := CustBankAcc.Code;
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         lVend.GET("Account No.");
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := VendBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := VendBankAcc.Code;
    //                     END;
    //             END
    //         ELSE BEGIN
    //             lSWIFTCode := '';
    //             lBeneficiaryBankAccount := '';
    //         END;
    //         IF lSWIFTCode = '' THEN
    //             ERROR(BICValidation, lVend."No.", VendBankAcc.Code);

    //         AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(lSWIFTCode), 1, 11), '', XMLNewChild);

    //         CASE "Account Type" OF
    //             "Account Type"::Vendor:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     IF VendBankAcc."Country/Region Code" = '' THEN
    //                         ERROR(CtryValidation, lVend."No.", VendBankAcc.Code);

    //                     GetCountry(VendorBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', VendorBankAcc."Country/Region Code", '', XMLNewChild);

    //                     //HEI.09>>
    //                     //AddressLine1 := DELCHR(VendorBankAcc.Address,'<>') + ' ' + DELCHR(VendorBankAcc."Address 2",'<>');
    //                     //IF DELCHR(AddressLine1) <> '' THEN

    //                     //AddressLine2 := DELCHR(VendorBankAcc."Post Code",'<>') + ' ' + DELCHR(VendorBankAcc.City,'<>');
    //                     //IF DELCHR(AddressLine2) <> '' THEN
    //                     //HEI.09<<
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetVendor("Account No.");
    //                     Vendor.Name := ReplaceTextCharacters(Vendor.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Vendor."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Vendor."Country/Region Code", 1, 2), '', XMLNewChild);
    //                     //HEI.23>>
    //                     Ad1 := '';
    //                     Ad2 := '';
    //                     Ad3 := '';
    //                     IF Vendor.Address <> '' THEN
    //                         AddressLine1 := DELCHR(Vendor.Address, '<>');
    //                     IF Vendor."Address 2" <> '' THEN
    //                         AddressLine1 += ' ' + DELCHR(Vendor."Address 2", '<>');
    //                     IF Vendor."Street 3" <> '' THEN
    //                         AddressLine1 += ' ' + DELCHR(Vendor."Street 3", '<>');
    //                     IF Vendor."Street 4" <> '' THEN
    //                         AddressLine1 += ' ' + DELCHR(Vendor."Street 4", '<>');
    //                     IF Vendor."Street 5" <> '' THEN
    //                         AddressLine1 += ' ' + DELCHR(Vendor."Street 5", '<>');

    //                     Ad1 := COPYSTR(ReplaceTextCharacters(AddressLine1), 1, 33);
    //                     Ad2 := COPYSTR(ReplaceTextCharacters(AddressLine1), 34, 66);
    //                     Ad3 := COPYSTR(ReplaceTextCharacters(AddressLine1), 67, 99);
    //                     IF Ad1 <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', Ad1, '', XMLNewChild);
    //                     IF Ad2 <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', Ad2, '', XMLNewChild);
    //                     IF Ad3 <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', Ad3, '', XMLNewChild);
    //                     //HEI.06>>
    //                     //AddressLine1 := DELCHR(Vendor.Address,'<>') + ' ' + DELCHR(Vendor."Address 2",'<>');
    //                     //AddressLine1 := DELCHR(Vendor.Address,'<>') + ' ' + DELCHR(Vendor."Address 2",'<>') +DELCHR(Vendor."Street 3")+' '+DELCHR(Vendor."Street 4")+ ' '+DELCHR(Vendor."Street 5");
    //                     //IF DELCHR(AddressLine1) <> '' THEN
    //                     //IF COPYSTR(ReplaceTextCharacters(AddressLine1),1,33) <> '' THEN
    //                     //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(ReplaceTextCharacters(AddressLine1),1,33),'',XMLNewChild);//HEI.05
    //                     //IF COPYSTR(ReplaceTextCharacters(AddressLine1),34,66) <> '' THEN
    //                     //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(ReplaceTextCharacters(AddressLine1),34,66),'',XMLNewChild);
    //                     //IF COPYSTR(ReplaceTextCharacters(AddressLine1),67,99) <> '' THEN
    //                     //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(ReplaceTextCharacters(AddressLine1),67,99),'',XMLNewChild);
    //                     //HEI.23<<
    //                     AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
    //                     AddressLine2 := ReplaceTextCharacters(AddressLine2); //HEI.23
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 30), '', XMLNewChild);//HEI.23
    //                                                                                                           //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(ReplaceTextCharacters(AddressLine2),1,30),'',XMLNewChild);//HEI.05 //HEI.23
    //                                                                                                           //HEI.06<<
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //             "Account Type"::Customer:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     CustomerBankAcc.Name := ReplaceTextCharacters(CustomerBankAcc.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(CustomerBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 33), '', XMLNewChild);//HEI.05

    //                     AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 33), '', XMLNewChild);//HEI.05
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCustomer("Account No.");
    //                     Customer.Name := ReplaceTextCharacters(Customer.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Customer."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 33), '', XMLNewChild);//HEI.05

    //                     AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 33), '', XMLNewChild);//HEI.05

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //         END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := CustBankAcc.IBAN;
    //                         CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
    //                         IF CI93Pos <> 0 THEN
    //                             BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

    //                         BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
    //                         IF BICICIABPos <> 0 THEN
    //                             BeneficiaryIBAN := '';
    //                         IF Country.Code <> 'CI' THEN
    //                             BeneficiaryIBAN := '';
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         IF COPYSTR(VendBankAcc."SWIFT Code", 1, 6) = 'SBICMZ' THEN
    //                             Othid := VendBankAcc."Bank Account No."
    //                         ELSE
    //                             Othid := VendBankAcc."Bank Account No.";

    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                         CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
    //                         IF CI93Pos <> 0 THEN
    //                             BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

    //                         BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
    //                         IF BICICIABPos <> 0 THEN
    //                             BeneficiaryIBAN := '';
    //                         IF Country.Code <> 'CI' THEN
    //                             BeneficiaryIBAN := '';
    //                     END;
    //             END
    //         ELSE BEGIN
    //             BeneficiaryBankAccountNo := '';
    //             BeneficiaryIBAN := '';
    //             Country."IBAN Country/Region" := FALSE;
    //         END;

    //         // If IBAN Transfer then Export IBAN else BBAN
    //         IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region";

    //         AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF Othid = '' THEN
    //             ERROR(AccountValidation, VendBankAcc."Vendor No.", VendBankAcc.Code)
    //         ELSE
    //             IF STRLEN(Othid) <> 21 THEN
    //                 ERROR(AccountLengthCheck, VendBankAcc."Vendor No.", VendBankAcc.Code);

    //         AddElement(XMLNodeCurr, 'Id', Othid, '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         //END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         PaymentMessage := ReplaceTextCharacters(PaymentMessage);
    //         AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(PaymentMessage, 1, 70), '', XMLNewChild);//HEI.05

    //         XMLNodeCurr := RootNode;
    //     END;
    //     //HEI.03<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite function.
    //BC UPGRADE KUMARR78 >> Rewriting Function ExportTransactioninformationMZ

    procedure ExportTransactionInformationMZ(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        GLSetup: Record "General Ledger Setup";
        AddressLine1: Text[110];
        AddressLine2: Text[60];
        ISOCurrCode: Text[3];
        IBANTransfer: Boolean;
        VendorBankAccount: Record "Vendor Bank Account";
        BeneficiaryIBAN: Code[50];
        CustomerBankAccount: Record "Customer Bank Account";
        BeneficiaryBankAccountNo: Code[30];
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        lSWIFTCode: Code[20];
        lBeneficiaryBankAccount: Code[30];
        lCust: Record Customer;
        lVend: Record Vendor;
        CountryIBANCountryRegion: Boolean;
        lNewAmountText: Text;
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lPosition: Integer;
        lCurrency: Record Currency;
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPrtLctnValue: Text[10];
        lVend2: Record Vendor;
        Othid: Code[30];
        InstdAmt: Label 'InstdAmt';
        BICValidation: Label 'For Vendor No %1 and Vendor Bank account %2, SWIFT Code should not be Blank!';
        CtryValidation: Label 'For Vendor No %1 and Vendor Bank account %2, Country Code should not be Blank!';
        AccountLengthCheck: Label 'For Vendor No %1 and Vendor Bank account %2, Account No should be 21 Digits only!';
        AccountValidation: Label 'For Vendor No %1 and Vendor Bank account %2, Account No should not be Blank!';
        Ad1: Text[33];
        Ad2: Text[33];
        Ad3: Text[33];
        AmtNode: XmlNode;
        CdtrAcctNode: XmlNode;
        CdtrNode: XmlNode;
        CdtTrfTxInfNode: XmlNode;
        IdNode: XmlNode;
        PmtIdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        RootNode: XmlNode;
        XMLNewChild: XmlNode;
        CdtrAgtNode: XmlNode;
        FinInstNode: XmlNode;

    begin
        //HEI.03>>
        //HEI.10>>
        IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
            BankDetailsCheck(BankAcc, VendBankAcc, PmtJnlLine."Currency Code");
        //HEI.10<<
        GLSetup.GET;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;
        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        CdtTrfTxInfNode := XMLNewChild;

        AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
        PmtIdNode := XMLNewChild;
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'EndToEndId', PmtJnlLine."Document No.", '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(CdtTrfTxInfNode, 'PmtTpInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'InstrPrty', 'NORM', '', XMLNewChild);
        XMLNodeCurr := CdtTrfTxInfNode;
        AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;




        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;


        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;


        AddElement(XMLNodeCurr, InstdAmt, lNewAmountText, '', XMLNewChild);

        IF PmtJnlLine."Currency Code" = '' THEN
            ISOCurrCode := COPYSTR(GLSetup."LCY Code", 1, 3)
        ELSE BEGIN
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
        END;

        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);
        XMLNodeCurr := CdtTrfTxInfNode;
        AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;
        IF lSWIFTCode = '' THEN
            ERROR(BICValidation, lVend."No.", VendBankAcc.Code);

        AddElement(XMLNodeCurr, 'BIC', CopyStr(DelChr(lSWIFTCode), 1, 11), '', XMLNewChild);

        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    IF VendBankAcc."Country/Region Code" = '' THEN
                        ERROR(CtryValidation, lVend."No.", VendBankAcc.Code);

                    GetCountry(VendorBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', VendorBankAcc."Country/Region Code", '', XMLNewChild);
                    XMLNodeCurr := CdtTrfTxInfNode;
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetVendor(PmtJnlLine."Account No.");
                    Vendor.Name := ReplaceTextCharacters(Vendor.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Vendor."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Vendor."Country/Region Code", 1, 2), '', XMLNewChild);
                    //HEI.23>>
                    Ad1 := '';
                    Ad2 := '';
                    Ad3 := '';
                    IF Vendor.Address <> '' THEN
                        AddressLine1 := DELCHR(Vendor.Address, '<>');
                    IF Vendor."Address 2" <> '' THEN
                        AddressLine1 += ' ' + DELCHR(Vendor."Address 2", '<>');
                    IF Vendor."Street 3 FND" <> '' THEN
                        AddressLine1 += ' ' + DELCHR(Vendor."Street 3 FND", '<>');
                    IF Vendor."Street 4 FND" <> '' THEN
                        AddressLine1 += ' ' + DELCHR(Vendor."Street 4 FND", '<>');
                    IF Vendor."Street 5 FND" <> '' THEN
                        AddressLine1 += ' ' + DELCHR(Vendor."Street 5 FND", '<>');

                    Ad1 := COPYSTR(ReplaceTextCharacters(AddressLine1), 1, 33);
                    Ad2 := COPYSTR(ReplaceTextCharacters(AddressLine1), 34, 66);
                    Ad3 := COPYSTR(ReplaceTextCharacters(AddressLine1), 67, 99);
                    IF Ad1 <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', Ad1, '', XMLNewChild);
                    IF Ad2 <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', Ad2, '', XMLNewChild);
                    IF Ad3 <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', Ad3, '', XMLNewChild);
                    AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
                    AddressLine2 := ReplaceTextCharacters(AddressLine2);
                    //HEI.23
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 30), '', XMLNewChild);
                END;
            PmtJnlLine."Account Type"::Customer:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    CustomerBankAcc.Name := ReplaceTextCharacters(CustomerBankAcc.Name);
                    AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(CustomerBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 33), '', XMLNewChild);//HEI.05
                    AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 33), '', XMLNewChild);//HEI.05
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCustomer(PmtJnlLine."Account No.");
                    Customer.Name := ReplaceTextCharacters(Customer.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Customer."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 33), '', XMLNewChild);//HEI.05
                    AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 33), '', XMLNewChild);//HEI.05

                END;
        END;
        XMLNodeCurr := CdtTrfTxInfNode;
        AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;


        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                        BeneficiaryIBAN := CustBankAcc.IBAN;
                        CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
                        IF CI93Pos <> 0 THEN
                            BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

                        BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
                        IF BICICIABPos <> 0 THEN
                            BeneficiaryIBAN := '';
                        IF Country.Code <> 'CI' THEN
                            BeneficiaryIBAN := '';
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        IF COPYSTR(VendBankAcc."SWIFT Code", 1, 6) = 'SBICMZ' THEN
                            Othid := VendBankAcc."Bank Account No."
                        ELSE
                            Othid := VendBankAcc."Bank Account No.";

                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");
                        CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
                        IF CI93Pos <> 0 THEN
                            BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

                        BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
                        IF BICICIABPos <> 0 THEN
                            BeneficiaryIBAN := '';
                        IF Country.Code <> 'CI' THEN
                            BeneficiaryIBAN := '';
                    END;
            END
        ELSE BEGIN
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := FALSE;
        END;
        // If IBAN Transfer then Export IBAN else BBAN
        IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region FND";

        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        IF Othid = '' THEN
            ERROR(AccountValidation, VendBankAcc."Vendor No.", VendBankAcc.Code)
        ELSE
            IF STRLEN(Othid) <> 21 THEN
                ERROR(AccountLengthCheck, VendBankAcc."Vendor No.", VendBankAcc.Code);

        AddElement(XMLNodeCurr, 'Id', Othid, '', XMLNewChild);
        XMLNodeCurr := CdtTrfTxInfNode;
        AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        PaymentMessage := ReplaceTextCharacters(PaymentMessage);

        AddElement(XMLNodeCurr, 'Ustrd', CopyStr(PaymentMessage, 1, 70), '', XMLNewChild);

        XMLNodeCurr := RootNode;
    end;
    //BC UPGRADE KUMARR78 << Rewriting Function ExportTransactioninformationMZ

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite Function.
    // local procedure ExportPaymentInformationMZ(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     InstructionPriority: Text[10];
    //     ChargeBearer: Text[4];
    //     BICICIABPos: Integer;
    //     lVendor: Record "23";
    //     VendBankAcc: Record "288";
    //     BeneficiaryBankAccountNo: Text[30];
    //     BankAccount: Record "270";
    //     PaymentMethod: Record "289";
    // begin
    //     //HEI.03>>
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;

    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);
    //     IF PaymentMethod.GET(PmtJnlLine."Payment Method Code") THEN
    //         AddElement(XMLNodeCurr, 'PmtMtd', PaymentMethod."Bank Cnctvty Pmt. Method FND", '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

    //     IF BankExportImportSetup."Batch Booking" THEN
    //         AddElement(XMLNodeCurr, 'BtchBookg', 'true', '', XMLNewChild)//HEI.05
    //     ELSE
    //         AddElement(XMLNodeCurr, 'BtchBookg', 'false', '', XMLNewChild);//HEI.05

    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     CASE PmtJnlLine."Instruction Priority" OF
    //         PmtJnlLine."Instruction Priority"::Normal:
    //             InstructionPriority := 'NORM';
    //         PmtJnlLine."Instruction Priority"::High:
    //             InstructionPriority := 'HIGH';
    //     END;

    //     AddElement(XMLNodeCurr, 'InstrPrty', InstructionPriority, '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'SvcLvl', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     CLEAR(InstructionPriority);
    //     CASE PmtJnlLine."Instruction Priority" OF
    //         PmtJnlLine."Instruction Priority"::Normal:
    //             InstructionPriority := 'NORM';
    //         PmtJnlLine."Instruction Priority"::High:
    //             InstructionPriority := 'URGP';
    //     END;

    //     AddElement(XMLNodeCurr, 'Cd', InstructionPriority, '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     IF PmtJnlLine."HNK Bank Account" <> '' THEN
    //         BankAccount.GET(PmtJnlLine."HNK Bank Account");
    //     BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
    //     AddElement(XMLNodeCurr, 'Nm', BankAccount.Name, '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetCountry(BankAccount."Country/Region Code");

    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

    //     AddressLine1 := DELCHR(BankAccount.Address, '<>') + ' ' + DELCHR(BankAccount."Address 2", '<>');
    //     AddressLine1 := ReplaceTextCharacters(AddressLine1); //HEI.23
    //     IF DELCHR(AddressLine1) <> '' THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 33), '', XMLNewChild); //HEI.23
    //                                                                                            //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(ReplaceTextCharacters(AddressLine1),1,33),'',XMLNewChild); //HEI.05 //HEI.23

    //     AddressLine2 := DELCHR(BankAccount."Post Code", '<>') + ' ' + DELCHR(BankAccount.City, '<>');
    //     AddressLine2 := ReplaceTextCharacters(AddressLine2); //HEI.23
    //     IF DELCHR(AddressLine2) <> '' THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 33), '', XMLNewChild);//HEI.23
    //                                                                                           //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(ReplaceTextCharacters(AddressLine2),1,33),'',XMLNewChild);//HEI.05 //HEI.23

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");

    //     AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     IF BankAcc."Currency Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ccy', BankAcc."Currency Code", '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ccy', GeneralLedgerSetup."LCY Code", '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     CASE PmtJnlLine."Code Expenses" OF
    //         PmtJnlLine."Code Expenses"::" ":
    //             ChargeBearer := 'DEBT';
    //         PmtJnlLine."Code Expenses"::SHA:
    //             ChargeBearer := 'DEBT';
    //         PmtJnlLine."Code Expenses"::BEN:
    //             ChargeBearer := 'DEBT';
    //         PmtJnlLine."Code Expenses"::OUR:
    //             ChargeBearer := 'DEBT';
    //     END;

    //     AddElement(XMLNodeCurr, 'ChrgBr', ChargeBearer, '', XMLNewChild);

    //     XMLNodeCurr := RootNode;
    //     //HEI.03<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking

    local procedure ExportPaymentInformationMZ(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;

        PmtInfNodeLocal: XmlNode;
        PmtTpInfNode: XmlNode;
        SvcLvlNode: XmlNode;
        DbtrNode: XmlNode;
        PstlAdrNode: XmlNode;
        DbtrAcctNode: XmlNode;
        IdNode: XmlNode;
        OthrNode: XmlNode;
        DbtrAgtNode: XmlNode;
        FinInstnIdNode: XmlNode;

        AddressLine1: Text[110];
        AddressLine2: Text[60];
        InstructionPriority: Text[10];
        ChargeBearer: Text[4];

        lVendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        BeneficiaryBankAccountNo: Text[30];
        BankAccount: Record "Bank Account";
        PaymentMethod: Record "Payment Method";
    begin
        //HEI.03>>

        RootNode := XMLNodeCurr;

        PaymentInformationCounter += 1;

        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        PmtInfNodeLocal := XMLNewChild;
        PmtInfNode := XMLNewChild;

        AddElement(PmtInfNodeLocal, 'PmtInfId', MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);

        if PaymentMethod.Get(PmtJnlLine."Payment Method Code") then
            AddElement(PmtInfNodeLocal, 'PmtMtd', PaymentMethod."Bank Cnctvty Pmt. Method FND", '', XMLNewChild)
        else
            AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);

        if BankExportImportSetup."Batch Booking FND" then
            AddElement(PmtInfNodeLocal, 'BtchBookg', 'true', '', XMLNewChild)
        else
            AddElement(PmtInfNodeLocal, 'BtchBookg', 'false', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'PmtTpInf', '', '', XMLNewChild);
        PmtTpInfNode := XMLNewChild;

        case PmtJnlLine."Instruction Priority" of
            PmtJnlLine."Instruction Priority"::Normal:
                InstructionPriority := 'NORM';
            PmtJnlLine."Instruction Priority"::High:
                InstructionPriority := 'HIGH';
        end;

        AddElement(PmtTpInfNode, 'InstrPrty', InstructionPriority, '', XMLNewChild);

        AddElement(PmtTpInfNode, 'SvcLvl', '', '', XMLNewChild);
        SvcLvlNode := XMLNewChild;

        Clear(InstructionPriority);
        case PmtJnlLine."Instruction Priority" of
            PmtJnlLine."Instruction Priority"::Normal:
                InstructionPriority := 'NORM';
            PmtJnlLine."Instruction Priority"::High:
                InstructionPriority := 'URGP';
        end;

        AddElement(SvcLvlNode, 'Cd', InstructionPriority, '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'ReqdExctnDt', Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'Dbtr', '', '', XMLNewChild);
        DbtrNode := XMLNewChild;

        if PmtJnlLine."HNK Bank Account" <> '' then
            BankAccount.Get(PmtJnlLine."HNK Bank Account");

        BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
        AddElement(DbtrNode, 'Nm', BankAccount.Name, '', XMLNewChild);

        AddElement(DbtrNode, 'PstlAdr', '', '', XMLNewChild);
        PstlAdrNode := XMLNewChild;

        GetCountry(BankAccount."Country/Region Code");

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(PstlAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        else
            AddElement(PstlAdrNode, 'Ctry', CopyStr(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

        AddressLine1 := DelChr(BankAccount.Address, '<>') + ' ' + DelChr(BankAccount."Address 2", '<>');
        AddressLine1 := ReplaceTextCharacters(AddressLine1);

        if DelChr(AddressLine1) <> '' then
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 33), '', XMLNewChild);

        AddressLine2 := DelChr(BankAccount."Post Code", '<>') + ' ' + DelChr(BankAccount.City, '<>');
        AddressLine2 := ReplaceTextCharacters(AddressLine2);

        if DelChr(AddressLine2) <> '' then
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 33), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAcct', '', '', XMLNewChild);
        DbtrAcctNode := XMLNewChild;

        AddElement(DbtrAcctNode, 'Id', '', '', XMLNewChild);
        IdNode := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        AddElement(IdNode, 'Othr', '', '', XMLNewChild);
        OthrNode := XMLNewChild;

        AddElement(OthrNode, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        if BankAcc."Currency Code" <> '' then
            AddElement(DbtrAcctNode, 'Ccy', BankAcc."Currency Code", '', XMLNewChild)
        else
            AddElement(DbtrAcctNode, 'Ccy', GeneralLedgerSetup."LCY Code", '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAgt', '', '', XMLNewChild);
        DbtrAgtNode := XMLNewChild;

        AddElement(DbtrAgtNode, 'FinInstnId', '', '', XMLNewChild);
        FinInstnIdNode := XMLNewChild;

        AddElement(FinInstnIdNode, 'BIC', CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

        case PmtJnlLine."Code Expenses" of
            PmtJnlLine."Code Expenses"::" ":
                ChargeBearer := 'DEBT';
            PmtJnlLine."Code Expenses"::SHA:
                ChargeBearer := 'DEBT';
            PmtJnlLine."Code Expenses"::BEN:
                ChargeBearer := 'DEBT';
            PmtJnlLine."Code Expenses"::OUR:
                ChargeBearer := 'DEBT';
        end;

        AddElement(PmtInfNodeLocal, 'ChrgBr', ChargeBearer, '', XMLNewChild);

        XMLNodeCurr := RootNode;
    end;
    //BC UPGRADE KUMARR78 << Rewriting Function ExportTransactionnformationMZ

    procedure FinishGroupHeaderMZ();
    var
        //BC UPGRADE KUMARR78 >> Blocking to Change Dotnet to XML.
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking to Change Dotnet to XML.

        //BC UPGRADE KUMARR78 >> Adding to Change to XML.
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;

        ParentNode: XmlNode;
        RootElement: XmlElement;

    //BC UPGRADE KUMARR78 << Adding to Change to XML.

    begin
        //HEI.03>>
        // Insert Number of Transactions and ControlSum in the Group Header
        // XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document'); //BC UPGRADE KUMARR78 Rewriting.
        // XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr); //BC UPGRADE KUMARR78 Rewriting.
        XMLNodeCurr := FinalXmlNode;
        AddElement(XMLNodeCurr, 'NbOfTxs', FORMAT(NumberOfTransactions, 0, 9), '', XMLNewChild);
        ConsolidatedPmtJnlLine.CALCSUMS(Amount);
        AddElement(XMLNodeCurr, 'CtrlSum', FORMAT(ConsolidatedPmtJnlLine.Amount, 0, 9), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        CompanyInfo.Name := ReplaceTextCharacters(CompanyInfo.Name);
        AddElement(XMLNodeCurr, 'Nm', COPYSTR(CompanyInfo.Name, 1, 35), '', XMLNewChild);//HEI.05
        AddEnterpriseNo(XMLNodeCurr, CompanyInfo."Enterprise No. FND");
        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'OrgId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Id', BankExportImportSetup."User ID Tag FND", '', XMLNewChild);
        //HEI.03<<
    end;

    procedure FinishGroupHeaderEthiopiaCBE(HNKAcc: Code[20]);
    var

        //BC UPGRADE KUMARR78 >> Blocking to Change Dotnet to XML.
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking to Change Dotnet to XML.
        //BC UPGRADE KUMARR78 >> Adding to Change to XML.
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;
        //BC UPGRADE KUMARR78 << Adding to Change to XML.

        lBankAccount: Record "Bank Account";
        lSWIFTCode: Code[20];
    begin
        //HEI.07>>
        // Insert Number of Transactions and ControlSum in the Group Header
        // XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document'); //BC UPGRADE KUMARR78 Rewriting.
        // XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr); //BC UPGRADE KUMARR78 Rewriting.
        // XMLNodeCurr := XMLNodeCurr.FirstChild;//BC UPGRADE KUMARR78 Blocking
        // XMLNodeCurr := XMLNodeCurr.FirstChild; //BC UPGRADE KUMARR78 Blocking
        XMLNodeCurr := FinalXmlNode;

        AddElement(XMLNodeCurr, 'NbOfTxs', FORMAT(NumberOfTransactions, 0, 9), '', XMLNewChild);

        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'Nm', CompanyInfo.Name, '', XMLNewChild);
        AddEnterpriseNo(XMLNodeCurr, CompanyInfo."Enterprise No. FND");

        IF lBankAccount.GET(HNKAcc) THEN
            lSWIFTCode := lBankAccount."SWIFT Code";

        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'OrgId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'BICOrBEI', FORMAT(lSWIFTCode), '', XMLNewChild);
        // XMLNodeCurr := XMLNodeCurr.ParentNode; //BC UPGRADE KUMARR78 Blocking
        // XMLNodeCurr := XMLNodeCurr.ParentNode; //BC UPGRADE KUMARR78 Blocking
        CLEAR(XMLNodeCurr);
        CLEAR(XMLNewChild);
        //HEI.07<<
    end;

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite CreateNonSepaContentMZCBE function.
    // procedure CreateNonSepaContentMZCBE(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     lNonSepaContent: Text;
    //     OutStr: OutStream;
    //     inStr: InStream;
    //     MyText: Text;
    //     XMLDOMManagement: Codeunit "6224";
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     BigText: BigText;
    //     XMLText: Text;
    //     filRead: File;
    //     intLen: Integer;
    //     txtOneLine: Text;
    //     txtFromFile: Text;
    //     TodayString: Text;
    //     FileName1: Text;
    //     InStream: InStream;
    //     i: Integer;
    //     j: Integer;
    //     k: Integer;
    //     k1: Integer;
    //     k3: Integer;
    //     TxtToAddInComponent: Text[80];
    //     InterfaceEntryComponent: Record "50003";
    //     c: Integer;
    //     cString: Text;
    //     NewPaymentGroup: Boolean;
    //     lGenJournalLine: Record "Gen. Journal Line BC FND";
    //     Pos: Integer;
    //     lGenJournalLine81: Record "81";
    // begin
    //     //HEI.10>>
    //     CompanyInfo.GET;

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //     GMessageId := MessageId;
    //     StartGroupHeader(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;


    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
    //     IF lGenJournalLine.FINDFIRST THEN
    //         REPEAT
    //             //HEI.21>>
    //             //NewPaymentGroup := CheckNewGroup(lGenJournalLine);
    //             NewPaymentGroup := CheckNewGroupMZCBE(lGenJournalLine);

    //             //IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
    //             IF NewConsolidatedPaymentMZCBE(lGenJournalLine) THEN BEGIN
    //                 //HEI.21<<
    //                 ExportTransactionInformationMZCBE(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
    //                 InitConsolidatedPayment(lGenJournalLine);
    //             END ELSE
    //                 UpdateConsolidatedPayment(lGenJournalLine);

    //             IF NewPaymentGroup THEN
    //                 ExportPaymentInformationMZCBE(CstmrCdtTrfInitnNode, lGenJournalLine);
    //         UNTIL lGenJournalLine.NEXT = 0;

    //     IF NOT EmptyConsolidatedPayment THEN
    //         ExportTransactionInformationMZCBE(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

    //     //Footer
    //     FinishGroupHeaderMZCBE;

    //     IF DATE2DMY(TODAY, 2) < 10 THEN
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
    //     ELSE
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

    //     FileName := SaveToFileNameClient;

    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName, FileName);
    //     FullFileName := FileName;

    //     filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);

    //     intLen := filRead.LEN;
    //     txtFromFile := '';

    //     InterfaceEntryComponent.RESET;
    //     c := 1;
    //     cString := 'C0001';

    //     filRead.CREATEINSTREAM(InStream);
    //     WHILE NOT InStream.EOS DO BEGIN
    //         InStream.READTEXT(txtFromFile);
    //         i := STRLEN(txtFromFile);

    //         k := i DIV 80;
    //         k1 := i MOD 80;

    //         IF k1 <> 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k + 1 DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;

    //         IF k1 = 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;
    //     END;
    //     TxtToAddInComponent := ']]>';
    //     InterfaceEntryComponent.RESET;
    //     InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //     InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //     InterfaceEntryComponent.Code := FORMAT(cString);
    //     InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');

    //     InterfaceEntryComponent.INSERT;
    //     c += 1;
    //     cString := INCSTR(cString);

    //     filRead.CLOSE;

    //     IF EXISTS(SaveToFileName) THEN
    //         IF ERASE(SaveToFileName) THEN;

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.DELETEALL;

    //     lGenJournalLine81.RESET;
    //     lGenJournalLine81.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine81.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine81.SETFILTER("Parent Line No.", '=%1', 0);
    //     lGenJournalLine81.MODIFYALL("WS Posting Allowed FND", TRUE);
    //     CLEAR(XMLRootElement);
    //     CLEAR(XMLNodeCurr);
    //     CLEAR(XMLNewChild);
    //     //HEI.10<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite Function.

    //BC UPGRADE KUMARR78 >> Rewriting Function

    procedure CreateNonSepaContentMZCBE(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text;
    var
        TempBlob: Codeunit "Temp Blob";
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XMLNodeCurr: XmlNode;
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lHNKBankAccount: Code[20];
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
        XmlNS: Integer;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        // XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);

        // RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        // XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;

        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeader(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
        IF lGenJournalLine.FINDFIRST THEN
            REPEAT
                //HEI.21>>
                //NewPaymentGroup := CheckNewGroup(lGenJournalLine);
                NewPaymentGroup := CheckNewGroupMZCBE(lGenJournalLine);

                //IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                IF NewConsolidatedPaymentMZCBE(lGenJournalLine) THEN BEGIN
                    //HEI.21<<
                    ExportTransactionInformationMZCBE(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationMZCBE(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationMZCBE(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

        FinishGroupHeaderMZCBE;

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);
        XMLText := DelStr(XMLText, StrPos(XMLText, 'standalone=" "'), StrLen('standalone=" "'));

        c := 1;
        cString := 'C0001';
        While NOT InStr.EOS DO BEGIN
            if c <> 1 then
                InStr.READTEXT(XMLText);
            i := StrLen(XMLText);
            k := i div 80;
            k1 := i mod 80;
            k3 := 1;

            if k1 <> 0 then begin
                for j := 1 to k + 1 do begin
                    txtOneLine := CopyStr(XMLText, k3, 80);
                    k3 += 80;

                    TxtToAddInComponent := txtOneLine;

                    //Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;

            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN
                    txtOneLine := CopyStr(XMLText, k3, 80);

                    TxtToAddInComponent := txtOneLine;

                    //Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);
        exit(XMLText);
    end;

    //BC UPGRADE KUMARR78 << Rewriting Function.

    //BC UPGRADE KUMARR78 >> Blocking Function To Rewrite.
    // procedure ExportTransactionInformationMZCBE(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    // var
    //     GLSetup: Record "98";
    //     AddressLine1: Text[210];
    //     AddressLine2: Text[60];
    //     ISOCurrCode: Text[3];
    //     IBANTransfer: Boolean;
    //     VendorBankAccount: Record "288";
    //     BeneficiaryIBAN: Code[50];
    //     CustomerBankAccount: Record "287";
    //     BeneficiaryBankAccountNo: Code[30];
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     CustBankAcc: Record "287";
    //     VendBankAcc: Record "288";
    //     lSWIFTCode: Code[20];
    //     lBeneficiaryBankAccount: Code[30];
    //     lCust: Record "18";
    //     lVend: Record "23";
    //     CountryIBANCountryRegion: Boolean;
    //     lNewAmountText: Text;
    //     lBankExportImportSetup: Record "1200";
    //     lPosition: Integer;
    //     lCurrency: Record "4";
    //     BICICIABPos: Integer;
    //     CI93Pos: Integer;
    //     lPrtLctnValue: Text[10];
    //     lVend2: Record "23";
    //     Othid: Code[30];
    //     InstdAmt: Label 'InstdAmt';
    //     BICValidation: Label 'For Vendor No %1 and Vendor Bank account %2, SWIFT Code should not be Blank!';
    //     CtryValidation: Label 'For Vendor No %1 and Vendor Bank account %2, Country Code should not be Blank!';
    //     AccountLengthCheck: Label 'For Vendor No %1 and Vendor Bank account %2, Account No should be 21 Digits only!';
    //     AccountValidation: Label 'For Vendor No %1 and Vendor Bank account %2, Account No should not be Blank!';
    //     VendCtryValidation: Label 'For Vendor No %1, Country Code should not be Blank!';
    // begin
    //     //HEI.10>>
    //     WITH PmtJnlLine DO BEGIN
    //         IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
    //             BankDetailsCheck(BankAcc, VendBankAcc, PmtJnlLine."Currency Code");
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'EndToEndId', PmtJnlLine."Document No.", '', XMLNewChild);

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;


    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;


    //         AddElement(XMLNodeCurr, InstdAmt, lNewAmountText, '', XMLNewChild);

    //         IF "Currency Code" = '' THEN
    //             ISOCurrCode := COPYSTR(GLSetup."LCY Code", 1, 3)
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
    //         END;
    //         AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         AddElement(XMLNodeCurr, 'ChrgBr', 'DEBT', '', XMLNewChild);

    //         AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         lCust.GET("Account No.");
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := CustBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := CustBankAcc.Code;
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         lVend.GET("Account No.");
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := VendBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := VendBankAcc.Code;
    //                     END;
    //             END
    //         ELSE BEGIN
    //             lSWIFTCode := '';
    //             lBeneficiaryBankAccount := '';
    //         END;
    //         IF lSWIFTCode = '' THEN
    //             ERROR(BICValidation, lVend."No.", VendBankAcc.Code);

    //         AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(lSWIFTCode), 1, 11), '', XMLNewChild);

    //         CASE "Account Type" OF
    //             "Account Type"::Vendor:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'Nm', VendBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     IF VendBankAcc."Country/Region Code" = '' THEN
    //                         ERROR(CtryValidation, lVend."No.", VendBankAcc.Code);

    //                     GetCountry(VendorBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', VendorBankAcc."Country/Region Code", '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;


    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetVendor("Account No.");
    //                     Vendor.Name := ReplaceTextCharacters(Vendor.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                     //HEI.16>>
    //                     IF Vendor."Country/Region Code" = '' THEN
    //                         ERROR(VendCtryValidation, Vendor."No.");

    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     //HEI.16<<
    //                     GetCountry(Vendor."Country/Region Code");
    //                     //HEI.16>>
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Vendor."Country/Region Code", 1, 2), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     //HEI.16<<
    //                 END;
    //             "Account Type"::Customer:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     CustomerBankAcc.Name := ReplaceTextCharacters(CustomerBankAcc.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(CustomerBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 33), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 33), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCustomer("Account No.");
    //                     Customer.Name := ReplaceTextCharacters(Customer.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Customer."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 33), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 33), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //         END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := CustBankAcc.IBAN;
    //                         CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
    //                         IF CI93Pos <> 0 THEN
    //                             BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

    //                         BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
    //                         IF BICICIABPos <> 0 THEN
    //                             BeneficiaryIBAN := '';
    //                         IF Country.Code <> 'CI' THEN
    //                             BeneficiaryIBAN := '';
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         IF COPYSTR(VendBankAcc."SWIFT Code", 1, 6) = 'SBICMZ' THEN
    //                             Othid := VendBankAcc."Bank Account No."
    //                         ELSE
    //                             Othid := VendBankAcc."Bank Account No.";

    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                         CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
    //                         IF CI93Pos <> 0 THEN
    //                             BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

    //                         BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
    //                         IF BICICIABPos <> 0 THEN
    //                             BeneficiaryIBAN := '';
    //                         IF Country.Code <> 'CI' THEN
    //                             BeneficiaryIBAN := '';
    //                     END;
    //             END
    //         ELSE BEGIN
    //             BeneficiaryBankAccountNo := '';
    //             BeneficiaryIBAN := '';
    //             Country."IBAN Country/Region" := FALSE;
    //         END;

    //         // If IBAN Transfer then Export IBAN else BBAN
    //         IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region";

    //         AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF Othid = '' THEN
    //             ERROR(AccountValidation, VendBankAcc."Vendor No.", VendBankAcc.Code);
    //         /*ELSE
    //            IF STRLEN(Othid) <> 21 THEN
    //            ERROR(AccountLengthCheck,VendBankAcc."Vendor No.",VendBankAcc.Code);*/

    //         AddElement(XMLNodeCurr, 'Id', Othid, '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         //END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         PaymentMessage := ReplaceTextCharacters(PaymentMessage);
    //         AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(PaymentMessage, 1, 70), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'Ustrd', BankExportImportSetup.BOPCode, '', XMLNewChild);//HEI.19
    //         XMLNodeCurr := RootNode;
    //     END;
    //     CLEAR(XMLNewChild);
    //     CLEAR(RootNode);
    //     //HEI.10<<

    // end;
    //BC UPGRADE KUMARR78 << Blocking toRewrite Function.
    //BC UPGRADE KUMARR78 >> Rewriting Function ExportTransactionInformationMZCBE
    procedure ExportTransactionInformationMZCBE(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        GLSetup: Record "General Ledger Setup";
        AddressLine1: Text[210];
        AddressLine2: Text[60];
        ISOCurrCode: Text[3];
        IBANTransfer: Boolean;
        VendorBankAccount: Record "Vendor Bank Account";
        BeneficiaryIBAN: Code[50];
        CustomerBankAccount: Record "Customer Bank Account";
        BeneficiaryBankAccountNo: Code[30];
        XMLNewChild: XmlNode;
        RootNode: XmlNode;
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        lSWIFTCode: Code[20];
        lBeneficiaryBankAccount: Code[30];
        lCust: Record Customer;
        lVend: Record Vendor;
        CountryIBANCountryRegion: Boolean;
        lNewAmountText: Text;
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lPosition: Integer;
        lCurrency: Record Currency;
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPrtLctnValue: Text[10];
        lVend2: Record Vendor;
        Othid: Code[30];
        InstdAmt: Label 'InstdAmt';
        BICValidation: Label 'For Vendor No %1 and Vendor Bank account %2, SWIFT Code should not be Blank!';
        CtryValidation: Label 'For Vendor No %1 and Vendor Bank account %2, Country Code should not be Blank!';
        AccountLengthCheck: Label 'For Vendor No %1 and Vendor Bank account %2, Account No should be 21 Digits only!';
        AccountValidation: Label 'For Vendor No %1 and Vendor Bank account %2, Account No should not be Blank!';
        VendCtryValidation: Label 'For Vendor No %1, Country Code should not be Blank!';
        AmtNode: XmlNode;
        CdtrAcctNode: XmlNode;
        CdtrNode: XmlNode;
        CdtTrfTxInfNode: XmlNode;
        IdNode: XmlNode;
        PmtIdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        FinInstNode: xmlnode;
        CdtrAgtNode: xmlnode;
    begin
        //HEI.10>>
        IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
            BankDetailsCheck(BankAcc, VendBankAcc, PmtJnlLine."Currency Code");
        GLSetup.GET;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;

        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        CdtTrfTxInfNode := XMLNewChild;
        AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
        PmtIdNode := XMLNewChild;
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'EndToEndId', PmtJnlLine."Document No.", '', XMLNewChild);
        XMLNodeCurr := CdtTrfTxInfNode;
        AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;


        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;


        AddElement(XMLNodeCurr, InstdAmt, lNewAmountText, '', XMLNewChild);

        IF PmtJnlLine."Currency Code" = '' THEN
            ISOCurrCode := COPYSTR(GLSetup."LCY Code", 1, 3)
        ELSE BEGIN
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
        END;
        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);
        XMLNodeCurr := CdtTrfTxInfNode;
        AddElement(XMLNodeCurr, 'ChrgBr', 'DEBT', '', XMLNewChild);
        AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
        ;


        XMLNodeCurr := XMLNewChild;

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;
        IF lSWIFTCode = '' THEN
            ERROR(BICValidation, lVend."No.", VendBankAcc.Code);

        AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(lSWIFTCode), 1, 11), '', XMLNewChild);

        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'Nm', VendBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    IF VendBankAcc."Country/Region Code" = '' THEN
                        ERROR(CtryValidation, lVend."No.", VendBankAcc.Code);

                    GetCountry(VendorBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', VendorBankAcc."Country/Region Code", '', XMLNewChild);
                    XMLNodeCurr := CdtTrfTxInfNode;
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetVendor(PmtJnlLine."Account No.");
                    Vendor.Name := ReplaceTextCharacters(Vendor.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                    //HEI.16>>
                    IF Vendor."Country/Region Code" = '' THEN
                        ERROR(VendCtryValidation, Vendor."No.");

                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    //HEI.16<<
                    GetCountry(Vendor."Country/Region Code");
                    //HEI.16>>
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Vendor."Country/Region Code", 1, 2), '', XMLNewChild);

                END;
            PmtJnlLine."Account Type"::Customer:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    CustomerBankAcc.Name := ReplaceTextCharacters(CustomerBankAcc.Name);
                    AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(CustomerBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 33), '', XMLNewChild);

                    AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 33), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCustomer(PmtJnlLine."Account No.");
                    Customer.Name := ReplaceTextCharacters(Customer.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Customer."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 33), '', XMLNewChild);

                    AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 33), '', XMLNewChild);

                END;
        END;

        XMLNodeCurr := CdtTrfTxInfNode;
        AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                        BeneficiaryIBAN := CustBankAcc.IBAN;
                        CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
                        IF CI93Pos <> 0 THEN
                            BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

                        BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
                        IF BICICIABPos <> 0 THEN
                            BeneficiaryIBAN := '';
                        IF Country.Code <> 'CI' THEN
                            BeneficiaryIBAN := '';
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        IF COPYSTR(VendBankAcc."SWIFT Code", 1, 6) = 'SBICMZ' THEN
                            Othid := VendBankAcc."Bank Account No."
                        ELSE
                            Othid := VendBankAcc."Bank Account No.";

                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");
                        CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
                        IF CI93Pos <> 0 THEN
                            BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

                        BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
                        IF BICICIABPos <> 0 THEN
                            BeneficiaryIBAN := '';
                        IF Country.Code <> 'CI' THEN
                            BeneficiaryIBAN := '';
                    END;
            END
        ELSE BEGIN
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := FALSE;
        END;
        // If IBAN Transfer then Export IBAN else BBAN
        IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region FND";

        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF Othid = '' THEN
            ERROR(AccountValidation, VendBankAcc."Vendor No.", VendBankAcc.Code)
        ELSE
            IF STRLEN(Othid) <> 21 THEN
                ERROR(AccountLengthCheck, VendBankAcc."Vendor No.", VendBankAcc.Code);

        AddElement(XMLNewChild, 'Id', Othid, '', XMLNewChild);

        XMLNodeCurr := CdtTrfTxInfNode;
        AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        PaymentMessage := ReplaceTextCharacters(PaymentMessage);

        AddElement(XMLNodeCurr, 'Ustrd', CopyStr(PaymentMessage, 1, 70), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Ustrd', BankExportImportSetup."BOPCode FND", '', XMLNewChild);

        XMLNodeCurr := RootNode;
        CLEAR(XMLNewChild);
        CLEAR(RootNode);
        //HEI.10<<

    end;


    //BC UPGRADE KUMARR78 >> Blocking to Rewrite Function.
    // local procedure ExportPaymentInformationMZCBE(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     InstructionPriority: Text[10];
    //     ChargeBearer: Text[4];
    //     BICICIABPos: Integer;
    //     lVendor: Record "23";
    //     VendBankAcc: Record "288";
    //     BeneficiaryBankAccountNo: Text[30];
    //     BankAccount: Record "270";
    //     PaymentMethod: Record "289";
    // begin
    //     //HEI.10>>
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;

    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);
    //     //HEI.16>>
    //     IF PaymentMethod.GET(PmtJnlLine."Payment Method Code") THEN
    //         AddElement(XMLNodeCurr, 'PmtMtd', PaymentMethod."Bank Cnctvty Pmt. Method FND", '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

    //     IF BankExportImportSetup."Batch Booking" THEN
    //         AddElement(XMLNodeCurr, 'BtchBookg', 'true', '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'BtchBookg', 'false', '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     CASE PmtJnlLine."Instruction Priority" OF
    //         PmtJnlLine."Instruction Priority"::Normal:
    //             InstructionPriority := 'NORM';
    //         PmtJnlLine."Instruction Priority"::High:
    //             InstructionPriority := 'HIGH';
    //     END;

    //     AddElement(XMLNodeCurr, 'InstrPrty', InstructionPriority, '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'SvcLvl', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     CLEAR(InstructionPriority);
    //     CASE PmtJnlLine."Instruction Priority" OF
    //         PmtJnlLine."Instruction Priority"::Normal:
    //             InstructionPriority := 'NORM';
    //         PmtJnlLine."Instruction Priority"::High:
    //             InstructionPriority := 'URGP';
    //     END;

    //     AddElement(XMLNodeCurr, 'Cd', InstructionPriority, '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     //HEI.16<<

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     IF PmtJnlLine."HNK Bank Account" <> '' THEN
    //         BankAccount.GET(PmtJnlLine."HNK Bank Account");
    //     BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
    //     AddElement(XMLNodeCurr, 'Nm', BankAccount.Name, '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");

    //     AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     IF BankAcc."Currency Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ccy', BankAcc."Currency Code", '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ccy', GeneralLedgerSetup."LCY Code", '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := RootNode;
    //     CLEAR(XMLNewChild);
    //     CLEAR(RootNode);
    //     //HEI.10<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite Function

    //BC UPGRADE KUMARR78> Rewriting Function.
    local procedure ExportPaymentInformationMZCBE(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;

        PmtInfNodeLocal: XmlNode;
        PmtTpInfNode: XmlNode;
        SvcLvlNode: XmlNode;
        DbtrNode: XmlNode;
        DbtrAcctNode: XmlNode;
        IdNode: XmlNode;
        OthrNode: XmlNode;
        DbtrAgtNode: XmlNode;
        FinInstnIdNode: XmlNode;

        InstructionPriority: Text[10];

        BankAccount: Record "Bank Account";
        PaymentMethod: Record "Payment Method";
    begin
        //HEI.10>>

        RootNode := XMLNodeCurr;

        PaymentInformationCounter += 1;

        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        PmtInfNodeLocal := XMLNewChild;
        PmtInfNode := XMLNewChild;

        AddElement(PmtInfNodeLocal, 'PmtInfId', MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);

        //HEI.16>>
        if PaymentMethod.Get(PmtJnlLine."Payment Method Code") then
            AddElement(PmtInfNodeLocal, 'PmtMtd', PaymentMethod."Bank Cnctvty Pmt. Method FND", '', XMLNewChild)
        else
            AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);

        if BankExportImportSetup."Batch Booking FND" then
            AddElement(PmtInfNodeLocal, 'BtchBookg', 'true', '', XMLNewChild)
        else
            AddElement(PmtInfNodeLocal, 'BtchBookg', 'false', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'PmtTpInf', '', '', XMLNewChild);
        PmtTpInfNode := XMLNewChild;

        case PmtJnlLine."Instruction Priority" of
            PmtJnlLine."Instruction Priority"::Normal:
                InstructionPriority := 'NORM';
            PmtJnlLine."Instruction Priority"::High:
                InstructionPriority := 'HIGH';
        end;

        AddElement(PmtTpInfNode, 'InstrPrty', InstructionPriority, '', XMLNewChild);

        AddElement(PmtTpInfNode, 'SvcLvl', '', '', XMLNewChild);
        SvcLvlNode := XMLNewChild;

        Clear(InstructionPriority);
        case PmtJnlLine."Instruction Priority" of
            PmtJnlLine."Instruction Priority"::Normal:
                InstructionPriority := 'NORM';
            PmtJnlLine."Instruction Priority"::High:
                InstructionPriority := 'URGP';
        end;

        AddElement(SvcLvlNode, 'Cd', InstructionPriority, '', XMLNewChild);
        //HEI.16<<

        AddElement(PmtInfNodeLocal, 'ReqdExctnDt', Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'Dbtr', '', '', XMLNewChild);
        DbtrNode := XMLNewChild;

        if PmtJnlLine."HNK Bank Account" <> '' then
            BankAccount.Get(PmtJnlLine."HNK Bank Account");

        BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
        AddElement(DbtrNode, 'Nm', BankAccount.Name, '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAcct', '', '', XMLNewChild);
        DbtrAcctNode := XMLNewChild;

        AddElement(DbtrAcctNode, 'Id', '', '', XMLNewChild);
        IdNode := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        AddElement(IdNode, 'Othr', '', '', XMLNewChild);
        OthrNode := XMLNewChild;

        AddElement(OthrNode, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        if BankAcc."Currency Code" <> '' then
            AddElement(DbtrAcctNode, 'Ccy', BankAcc."Currency Code", '', XMLNewChild)
        else
            AddElement(DbtrAcctNode, 'Ccy', GeneralLedgerSetup."LCY Code", '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAgt', '', '', XMLNewChild);
        DbtrAgtNode := XMLNewChild;

        AddElement(DbtrAgtNode, 'FinInstnId', '', '', XMLNewChild);
        FinInstnIdNode := XMLNewChild;

        AddElement(FinInstnIdNode, 'BIC', CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

        XMLNodeCurr := RootNode;
        Clear(XMLNewChild);
        Clear(RootNode);

        //HEI.10<<
    end;
    //BC UPGRADE KUMARR78 << Rewriting Function.
    procedure FinishGroupHeaderMZCBE();
    var
        //BC UPGRADE KUMARR78 >> Blocking to Replace Variables.
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking to Rewrite Variable
        //BC UPGRADE KUMARR78 >> Adding to Rewrite Variable
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;
    //BC UPGRADE KUMARR78 << Adding to Rewrite Variable
    begin
        //HEI.10>>
        // XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document'); //BC UPGRADE KUMARR78 Rewriting.
        //XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr); //BC UPGRADE KUMARR78 Rewriting.
        XMLNodeCurr := FinalXmlNode;
        AddElement(XMLNodeCurr, 'NbOfTxs', FORMAT(NumberOfTransactions, 0, 9), '', XMLNewChild);
        ConsolidatedPmtJnlLine.CALCSUMS(Amount);
        AddElement(XMLNodeCurr, 'CtrlSum', FORMAT(ConsolidatedPmtJnlLine.Amount, 0, 9), '', XMLNewChild);

        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        CompanyInfo.Name := ReplaceTextCharacters(CompanyInfo.Name);
        AddElement(XMLNodeCurr, 'Nm', COPYSTR(CompanyInfo.Name, 1, 35), '', XMLNewChild);
        AddEnterpriseNo(XMLNodeCurr, CompanyInfo."Enterprise No. FND");
        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'OrgId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Id', BankExportImportSetup."User ID Tag FND", '', XMLNewChild);
        CLEAR(XMLNodeCurr);
        CLEAR(XMLNewChild)
        //HEI.10<<
    end;

    local procedure SwiftCodeCheck(SwiftCode: Code[25]): Boolean;
    begin
        EXIT(COPYSTR(SwiftCode, 5, 2) = 'MZ'); //HEI.10
    end;

    local procedure BankDetailsCheck(HNKBank: Record "Bank Account"; VendorBank: Record "Vendor Bank Account"; LineCurrecyCode: Code[10]);
    var
        SwiftcodeError: Label 'Swift Code %1 should have MZ value in 5th and in 6th position for Bank Account %2';
        CBSwiftcodeError: Label 'Swift Code %1 should not have MZ value in 5th and in 6th position for Bank Account %2';
        VendSwiftcodeError: Label 'Swift Code %1 should have MZ value in 5th and in 6th position for Vendor Bank Account %2';
        VendCBSwiftcodeError: Label 'Swift Code %1 should not have MZ value in 5th and in 6th position for Vendor Bank Account %2';
        CurrencyMismatch: Label 'Currency Code mismatch for Vendor No. %1!';
    begin
        //HEI.20>>
        /*
        //HEI.10>>
        //Domestic
        GeneralLedgerSetup.GET;
        IF HNKBank."Currency Code" IN['',GeneralLedgerSetup."LCY Code"] THEN
        BEGIN
          IF LineCurrecyCode IN['',GeneralLedgerSetup."LCY Code"] THEN
          BEGIN
            VendorBank.TESTFIELD("SWIFT Code");
            HNKBank.TESTFIELD("SWIFT Code");
           IF NOT SwiftCodeCheck(VendorBank."SWIFT Code")  THEN
             ERROR(VendSwiftcodeError,VendorBank."SWIFT Code",VendorBank.Code);
           //HEI.16>>
           //IF NOT SwiftCodeCheck(HNKBank."SWIFT Code") THEN
           //  ERROR(SwiftcodeError,HNKBank."SWIFT Code",HNKBank."No.");
           //HEI.16<<
          END ELSE
             ERROR(CurrencyMismatch,VendorBank."Vendor No.");
        END ELSE
        BEGIN //Cross Border
          IF NOT (LineCurrecyCode IN['',GeneralLedgerSetup."LCY Code"]) THEN
          BEGIN
            VendorBank.TESTFIELD("Currency Code");
            HNKBank.TESTFIELD("Currency Code");
            VendorBank.TESTFIELD("SWIFT Code");
            HNKBank.TESTFIELD("SWIFT Code");
           IF SwiftCodeCheck(VendorBank."SWIFT Code")  THEN
             ERROR(VendCBSwiftcodeError,VendorBank."SWIFT Code",VendorBank.Code);
           //HEI.16>>
           //IF SwiftCodeCheck(HNKBank."SWIFT Code") THEN
           // ERROR(CBSwiftcodeError,HNKBank."SWIFT Code",HNKBank."No.");
           //HEI.16<<
          END
          ELSE
            ERROR(CurrencyMismatch,VendorBank."Vendor No.");
        END;
        //HEI.10<<
        */
        //HEI.20<<

    end;

    procedure CheckNewGroupMZCBE(PmtJnlLine: Record "Gen. Journal Line BC FND"): Boolean;
    begin
        //HEI.21>>
        IF EmptyConsolidatedPayment THEN
            EXIT(TRUE);

        EXIT(
  (ConsolidatedPmtJnlLine."HNK Bank Account" <> PmtJnlLine."HNK Bank Account") OR
  (ConsolidatedPmtJnlLine."Currency Code" <> PmtJnlLine."Currency Code") OR
  (ConsolidatedPmtJnlLine."Posting Date" <> PmtJnlLine."Posting Date") OR
  (ConsolidatedPmtJnlLine."Instruction Priority" <> PmtJnlLine."Instruction Priority") OR
  (ConsolidatedPmtJnlLine."Code Expenses" <> PmtJnlLine."Code Expenses") OR
  (ConsolidatedPmtJnlLine."Account No." <> PmtJnlLine."Account No."));
        //HEI.21<<
    end;

    local procedure NewConsolidatedPaymentMZCBE(PmtJnlLine: Record "Gen. Journal Line BC FND"): Boolean;
    var
        lBeneficiaryBankAccount: Code[30];
        lBeneficiaryBankAccountConsolidated: Code[30];
        lCust: Record Customer;
        CustBankAcc: Record "Customer Bank Account";
        lVend: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
    begin
        //HEI.21>>
        IF EmptyConsolidatedPayment THEN
            EXIT(FALSE);

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lBeneficiaryBankAccount := CustBankAcc."Bank Account No.";
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lBeneficiaryBankAccount := VendBankAcc."Bank Account No.";
                    END;
            END
        ELSE BEGIN
            lBeneficiaryBankAccount := '';
        END;

        IF (ConsolidatedPmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE ConsolidatedPmtJnlLine."Account Type" OF
                ConsolidatedPmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(ConsolidatedPmtJnlLine."Account No.");
                        CustBankAcc.GET(ConsolidatedPmtJnlLine."Account No.", ConsolidatedPmtJnlLine."Customer/Vendor Bank");
                        lBeneficiaryBankAccountConsolidated := CustBankAcc."Bank Account No.";
                    END;
                ConsolidatedPmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(ConsolidatedPmtJnlLine."Account No.");
                        VendBankAcc.GET(ConsolidatedPmtJnlLine."Account No.", ConsolidatedPmtJnlLine."Customer/Vendor Bank");
                        lBeneficiaryBankAccountConsolidated := VendBankAcc."Bank Account No.";
                    END;
            END
        ELSE BEGIN
            lBeneficiaryBankAccountConsolidated := '';
        END;

        EXIT(
  CheckNewGroupMZCBE(PmtJnlLine) OR
  IsPaymentMessageTooLong(PmtJnlLine."Message to Recipient") OR
  (ConsolidatedPmtJnlLine."Account Type" <> PmtJnlLine."Account Type") OR
  (ConsolidatedPmtJnlLine."Account No." <> PmtJnlLine."Account No.") OR
  (lBeneficiaryBankAccountConsolidated <> lBeneficiaryBankAccount));
        //HEI.21<<
    end;

    //BC UPGRADE KUMARR78 >> Blocking to rewrite function.
    // local procedure StartGroupHeaderAlgeriaDFT(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     //HEI.24>>
    //     AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
    //     //HEI.24<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite.

    //BC UPGRADE KUMARR78 >> Rewriting StartGroupHeaderAlgeriaDFT function.
    local procedure StartGroupHeaderAlgeriaDFT(XMLNodeCurr: XmlNode);
    var
        XMLNewChild: XmlNode;
    begin
        AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
        //BC UPGRADE ATHUKS01 Added 
        Clear(FinalXmlNode);
        FinalXmlNode := XMLNodeCurr;
        //BC UPGRADE ATHUKS01 Added.
    end;
    //BC UPGRADE KUMARR78 << Rewriting StartGroupHeaderAlgeriaDFT function.

    procedure ValidatePaymentContentAlgeriaDFT(GenJournalLine: Record "Gen. Journal Line BC FND"): Text;
    var
        // TempBlob: Record "99008535" temporary; //BC UPGRADE KUMARR78 Blocking as not in use.
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        // XMLDOMManagement: Codeunit "6224";//BC UPGRADE KUMARR78 Blocking as not in use.

        //BC UPGRADE KUMARR78 >>Blocking as not in use.
        // XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking as not in use.
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lVendor: Record Vendor;
        lCountryRegion: Record "Country/Region";
        lText001: Label 'Company Information Address or Company Information Address 2 must have a value!';
        lText002: Label 'Company Information Post Code or Company Information City must have a value!';
        lBankAccount: Record "Bank Account";
        lCurrency: Record Currency;
        lVendorBankAccount: Record "Vendor Bank Account";
        lText003: Label 'Vendor Address or Vendor Address 2 must have a value for vendor %1!';
        lText004: Label 'Vendor Post Code or Vendor City must have a value for vendor %1!';
        lText005: Label 'Field %1 cannot be empty for %2 %3!';
        lText006: Label 'Field %1 cannot be empty in %2!';
        lText007: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText008: Label 'Panama Bank Routing Code cannot be empty for %2 %3 Vendor %4!';
    begin
        CompanyInfo.GET;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);

        IF lGenJournalLine.FINDSET(FALSE) THEN
            REPEAT
                IF (CompanyInfo.Name = '') THEN
                    ERROR(lText006, CompanyInfo.FIELDCAPTION(Name), CompanyInfo.TABLECAPTION);
                IF (CompanyInfo."Country/Region Code" = '') THEN
                    ERROR(lText006, CompanyInfo.FIELDCAPTION("Country/Region Code"), CompanyInfo.TABLECAPTION);
                IF (lGenJournalLine."Posting Date" = 0D) THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Posting Date"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."HNK Bank Account" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("HNK Bank Account"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Document No." = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Document No."), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Message to Recipient" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Message to Recipient"), lGenJournalLine81.TABLECAPTION);

                IF (CompanyInfo.Address + CompanyInfo."Address 2" = '') THEN
                    ERROR(lText001);
                IF (CompanyInfo."Post Code" + CompanyInfo.City = '') THEN
                    ERROR(lText002);

                IF lCountryRegion.GET(CompanyInfo."Country/Region Code") THEN
                    lCountryRegion.TESTFIELD("ISO Country/Region Code FND");

                IF lVendor.GET(lGenJournalLine."Account No.") THEN BEGIN
                    IF (lVendor.Name = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION(Name), lVendor.TABLECAPTION, lVendor."No.");
                    IF (lVendor."Payment Method Code" = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION("Payment Method Code"), lVendor.TABLECAPTION, lVendor."No.");
                    IF (lVendor."Country/Region Code" = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION("Country/Region Code"), lVendor.TABLECAPTION, lVendor."No.");

                    IF lCountryRegion.GET(lVendor."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendor."Country/Region Code");

                    IF (lVendor.Address + lVendor."Address 2" = '') THEN
                        ERROR(lText003, lVendor."No.");
                    IF (lVendor."Post Code" + lVendor.City = '') THEN
                        ERROR(lText004, lVendor."No.");
                END;

                IF lBankAccount.GET(lGenJournalLine."HNK Bank Account") THEN BEGIN
                    IF (lBankAccount."SWIFT Code" = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("SWIFT Code"), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");

                    IF (lBankAccount."Bank Account No." = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("Bank Account No."), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");
                END;

                IF (lGenJournalLine."Currency Code" <> '') THEN
                    IF lCurrency.GET(lGenJournalLine."Currency Code") THEN
                        IF (lCurrency."ISO Currency Code FND" = '') THEN
                            ERROR(lText005, lCurrency.FIELDCAPTION("ISO Currency Code FND"), lCurrency.TABLECAPTION, lCurrency.Code);

                IF lVendorBankAccount.GET(lGenJournalLine."Account No.", lGenJournalLine."Customer/Vendor Bank") THEN BEGIN
                    IF (lVendorBankAccount.Name = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION(Name), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Country/Region Code" = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Country/Region Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    //HEI.18>>
                    IF lGenJournalLine."Currency Code" = 'EUR' THEN
                        IF (lVendorBankAccount.IBAN = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION(IBAN), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    //HEI.18<<

                    IF lCountryRegion.GET(lVendorBankAccount."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendorBankAccount."Country/Region Code");

                    IF (lVendorBankAccount."Bank Account No." = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Account No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    IF lVendorBankAccount."Country/Region Code" = 'PA' THEN BEGIN
                        //commented on 20.01.2023, as the "Panama Bank Routing Code" (field "Domestic - Bank Branch No.") will be taken from "Bank Branch No."
                        //IF (lVendorBankAccount."Domestic - Bank Branch No." = '') THEN
                        //  ERROR(lText007,lVendorBankAccount.FIELDCAPTION("Domestic - Bank Branch No."),lVendorBankAccount.TABLECAPTION,lVendorBankAccount.Code,lGenJournalLine."Account No.");
                        //added on 20.01.2023
                        IF (lVendorBankAccount."Bank Branch No." = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Branch No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                        IF (COPYSTR(lVendorBankAccount."Bank Branch No.", 6, 3) = '') THEN
                            ERROR(lText008, lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                        IF (lVendor."VAT Registration No." = '') THEN
                            ERROR(lText005, lVendor.FIELDCAPTION("VAT Registration No."), lVendor.TABLECAPTION, lVendor."No.");
                    END
                    ELSE BEGIN
                        IF (lVendorBankAccount."SWIFT Code" = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION("SWIFT Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                        IF (lVendorBankAccount."Bank Branch No." = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Branch No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    END;
                END;
            UNTIL lGenJournalLine.NEXT = 0;
    end;

    //BC UPGRADE KUMARR78 >> Blocking CreateNonSepaContentAlgeriaDFT Function to Rewrite

    // procedure CreateNonSepaContentAlgeriaDFT(GenJournalLine : Record "Gen. Journal Line BC";InterfaceEntryLine : Record "Interface Entry Line") : Text;
    //     var
    //         TempBlob : Record TempBlob temporary;
    //         lNonSepaContent : Text;
    //         OutStr : OutStream;
    //         inStr : InStream;
    //         MyText : Text;
    //         XMLDOMManagement : Codeunit "XML DOM Management";
    //         XMLRootElement : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //         XMLNodeCurr : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //         XMLNewChild : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //         BigText : BigText;
    //         XMLText : Text;
    //         filRead : File;
    //         intLen : Integer;
    //         txtOneLine : Text;
    //         txtFromFile : Text;
    //         TodayString : Text;
    //         FileName1 : Text;
    //         InStream : InStream;
    //         i : Integer;
    //         j : Integer;
    //         k : Integer;
    //         k1 : Integer;
    //         k3 : Integer;
    //         TxtToAddInComponent : Text[80];
    //         InterfaceEntryComponent : Record "Interface Entry Component INT";
    //         c : Integer;
    //         cString : Text;
    //         NewPaymentGroup : Boolean;
    //         lGenJournalLine : Record "Gen. Journal Line BC FND";
    //         Pos : Integer;
    //         lGenJournalLine81 : Record "Gen. Journal Line";
    //     begin
    //         //HEI.24>>
    //         //Algeria
    //         CompanyInfo.GET;

    //         //Header
    //         XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>',XMLDomDoc);
    //         XMLRootElement := XMLDomDoc.DocumentElement;
    //         //XMLRootElement.SetAttribute('xmlns','urn:iso:std:iso:20022:tech:xsd:pain.001.001.03'); //HEI.25
    //         XMLRootElement.SetAttribute('xmlns','urn:iso:std:iso:20022:tech:xsd:pain.001.001.02'); //HEI.25
    //         XMLRootElement.SetAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
    //         XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //         AddElement(XMLNodeCurr,'pain.001.001.02','','',XMLNewChild);
    //         CstmrCdtTrfInitnNode := XMLNewChild;
    //         MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //         GMessageId := MessageId;
    //         StartGroupHeaderAlgeriaDFT(XMLNewChild);
    //         PaymentInformationCounter := 0;
    //         NumberOfTransactions := 0;


    //         SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //         SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //         lGenJournalLine.RESET;
    //         lGenJournalLine.SETRANGE("Journal Template Name",GenJournalLine."Journal Template Name");
    //         lGenJournalLine.SETRANGE("Journal Batch Name",GenJournalLine."Journal Batch Name");
    //         lGenJournalLine.SETFILTER("Parent Line No.",'=%1',0);
    //         if lGenJournalLine.FINDFIRST then
    //           repeat
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             if NewConsolidatedPayment(lGenJournalLine) then begin
    //               ExportTransactionInformationAlgeriaDFT(PmtInfNode,ConsolidatedPmtJnlLine,ConsolidatedPmtMessage);
    //               InitConsolidatedPayment(lGenJournalLine);
    //             end else
    //               UpdateConsolidatedPayment(lGenJournalLine);

    //             if NewPaymentGroup then
    //               ExportPaymentInformationAlgeriaDFT(CstmrCdtTrfInitnNode,lGenJournalLine);
    //           until lGenJournalLine.NEXT = 0;

    //         if not EmptyConsolidatedPayment then
    //           ExportTransactionInformationAlgeriaDFT(PmtInfNode,ConsolidatedPmtJnlLine,ConsolidatedPmtMessage);

    //         //Footer
    //         FinishGroupHeaderAlgeriaDFT;

    //         if DATE2DMY(TODAY, 2) < 10 then
    //           TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0'+ FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                             FORMAT(TIME,0,'<hours24><minutes,2><seconds,2>')
    //         else
    //           TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                             FORMAT(TIME,0,'<hours24><minutes,2><seconds,2>');

    //         FileName := SaveToFileNameClient;

    //         XMLDomDoc.Save(SaveToFileName);
    //         RBMgt.DownloadToFile(SaveToFileName,FileName);
    //         FullFileName := FileName;

    //         filRead.OPEN(SaveToFileName,TEXTENCODING::UTF8);

    //         intLen := filRead.LEN;
    //         txtFromFile := '';

    //         InterfaceEntryComponent.RESET;
    //         c := 1;
    //         cString := 'C0001';

    //         filRead.CREATEINSTREAM(InStream);
    //         while not InStream.EOS do begin
    //           InStream.READTEXT(txtFromFile);
    //           i := STRLEN(txtFromFile);

    //           k := i div 80;
    //           k1 := i mod 80;

    //           if k1 <> 0 then
    //             begin
    //               k3 := 1;
    //               for j := 1 to k + 1 do
    //                 begin
    //                   txtOneLine := COPYSTR(txtFromFile,k3,80);
    //                   k3 += 80;
    //                   TxtToAddInComponent := txtOneLine;
    //                   InterfaceEntryComponent.RESET;
    //                   InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                   InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                   InterfaceEntryComponent.Code := FORMAT(cString);

    //                   Pos := STRPOS(TxtToAddInComponent,'<?xml version="1.0" encoding="UTF-8"?>');
    //                   if Pos <> 0 then
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                   InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent,'<>',' ');
    //                   InterfaceEntryComponent.INSERT;
    //                   c += 1;
    //                   cString := INCSTR(cString);
    //                 end;
    //             end;

    //           if k1 = 0 then
    //             begin
    //               k3 := 1;
    //               for j := 1 to k do
    //                 begin
    //                   txtOneLine := COPYSTR(txtFromFile,k3,80);
    //                   k3 += 80;
    //                   TxtToAddInComponent := txtOneLine;
    //                   InterfaceEntryComponent.RESET;
    //                   InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                   InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                   InterfaceEntryComponent.Code := FORMAT(cString);

    //                   Pos := STRPOS(TxtToAddInComponent,'<?xml version="1.0" encoding="UTF-8"?>');
    //                   if Pos <> 0 then
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                   InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent,'<>',' ');
    //                   InterfaceEntryComponent.INSERT;
    //                   c += 1;
    //                   cString := INCSTR(cString);
    //                 end;
    //             end;
    //         end;

    //         TxtToAddInComponent := ']]>';
    //         InterfaceEntryComponent.RESET;
    //         InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //         InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //         InterfaceEntryComponent.Code := FORMAT(cString);
    //         InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent,'<>',' ');
    //         InterfaceEntryComponent.INSERT;
    //         c += 1;
    //         cString := INCSTR(cString);

    //         filRead.CLOSE;

    //         if EXISTS(SaveToFileName) then
    //           if ERASE(SaveToFileName) then;

    //         lGenJournalLine.RESET;
    //         lGenJournalLine.SETRANGE("Journal Template Name",GenJournalLine."Journal Template Name");
    //         lGenJournalLine.SETRANGE("Journal Batch Name",GenJournalLine."Journal Batch Name");
    //         lGenJournalLine.DELETEALL;

    //         lGenJournalLine81.RESET;
    //         lGenJournalLine81.SETRANGE("Journal Template Name",GenJournalLine."Journal Template Name");
    //         lGenJournalLine81.SETRANGE("Journal Batch Name",GenJournalLine."Journal Batch Name");
    //         lGenJournalLine81.SETFILTER("Parent Line No.",'=%1',0);
    //         lGenJournalLine81.MODIFYALL("WS Posting Allowed FND",true);
    //         //HEI.24<<
    //     end;

    //BC UPGRADE KUMARR78 << Blocking to Rewrite CreateNonSepaContentAlgeriaDFT Function.
    procedure CreateNonSepaContentAlgeriaDFT(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text;
    var

        TempBlob: Codeunit "Temp Blob";
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XMLNodeCurr: XmlNode;
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
        XMlns: Integer;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        //XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);
        // RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.02');
        // RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        // XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'pain.001.001.02', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;

        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeaderAlgeriaDFT(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
        IF lGenJournalLine.FINDFIRST THEN
            REPEAT
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                    ExportTransactionInformationAlgeriaDFT(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationAlgeriaDFT(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationAlgeriaDFT(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

        FinishGroupHeaderAlgeriaDFT;

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);
        XMLText := DelStr(XMLText, StrPos(XMLText, 'standalone=" "'), StrLen('standalone=" "'));

        c := 1;
        cString := 'C0001';
        While NOT InStr.EOS DO BEGIN
            if c <> 1 then
                InStr.READTEXT(XMLText);
            i := StrLen(XMLText);
            k := i div 80;
            k1 := i mod 80;
            k3 := 1;

            if k1 <> 0 then begin
                k3 := 1;
                for j := 1 to k + 1 do begin

                    txtOneLine := CopyStr(XMLText, k3, 80);
                    k3 += 80;

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';



                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;

            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN
                    txtOneLine := CopyStr(XMLText, k3, 80);

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';
                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';


                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);
        exit(XMLText);
    end;

    //BC UPGRADE KUMARR78 >> Blocking
    // local procedure ExportPaymentInformationAlgeriaDFT(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     AddressLine3: Text[110];
    //     AddressLine4: Text[60];
    //     ChargeBearer: Text[4];
    //     BICICIABPos: Integer;
    //     lVendor: Record "23";
    //     VendBankAcc: Record "288";
    //     BeneficiaryBankAccountNo: Text[30];
    //     lIsEURPayment: Boolean;
    //     InstructionPriority: Code[10];
    //     BankAccount: Record "270";
    // begin
    //     //HEI.24>>
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;

    //     lIsEURPayment := FALSE;
    //     IF PmtJnlLine."Currency Code" = 'EUR' THEN
    //         lIsEURPayment := TRUE;

    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);

    //     IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
    //         IF lVendor.GET(PmtJnlLine."Account No.") THEN
    //             AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'ClrChanl', 'MPNS', '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'LclInstrm', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Prtry', BankExportImportSetup.BOPCode, '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     IF PmtJnlLine."HNK Bank Account" <> '' THEN
    //         BankAccount.GET(PmtJnlLine."HNK Bank Account");
    //     BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
    //     AddElement(XMLNodeCurr, 'Nm', COPYSTR(BankAccount.Name, 1, 70), '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetCountry(BankAccount."Country/Region Code");
    //     //HEI.26>>
    //     /*IF Country."ISO Country/Region Code" <> '' THEN
    //       AddElement(XMLNodeCurr,'Ctry',COPYSTR(Country."ISO Country/Region Code",1,2),'',XMLNewChild)
    //       ELSE
    //        AddElement(XMLNodeCurr,'Ctry',COPYSTR(BankAccount."Country/Region Code",1,2),'',XMLNewChild);*/
    //     //HEI.26<<

    //     AddressLine1 := DELCHR(BankAccount.Address, '<>') + ' ' + DELCHR(BankAccount."Address 2", '<>');
    //     AddressLine1 := ReplaceTextCharacters(AddressLine1);
    //     //
    //     IF (STRLEN(AddressLine1) <= 35) THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

    //     IF ((STRLEN(AddressLine1) > 35) AND (STRLEN(AddressLine1) <= 70)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //     END;
    //     IF ((STRLEN(AddressLine1) > 70) AND (STRLEN(AddressLine1) <= 105)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //     END;
    //     IF ((STRLEN(AddressLine1) > 105)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 106, 35), '', XMLNewChild);
    //     END;
    //     //

    //     AddressLine2 := DELCHR(BankAccount."Post Code", '<>') + ' ' + DELCHR(BankAccount.City, '<>');
    //     AddressLine2 := ReplaceTextCharacters(AddressLine2);
    //     //
    //     IF (STRLEN(AddressLine2) <= 35) THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', AddressLine2, '', XMLNewChild);

    //     IF ((STRLEN(AddressLine2) > 35) AND (STRLEN(AddressLine2) <= 70)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //     END;
    //     IF ((STRLEN(AddressLine2) > 70) AND (STRLEN(AddressLine2) <= 105)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //     END;
    //     IF ((STRLEN(AddressLine2) > 105)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 106, 35), '', XMLNewChild);
    //     END;
    //     //HEI.26>>
    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);
    //     //HEI.26<<
    //     //
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");

    //     BeneficiaryBankAccountNo := '';
    //     IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
    //         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

    //     AddElement(XMLNodeCurr, 'PrtryAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;


    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'CmbndId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := RootNode;
    //     //HEI.24<<

    // end;
    //BC UPGRADE KUMARR78 << blocking

    //BC UPGRADE KUMARR78 >> Replacing Code of function ExportPaymentInformationAlgeriaDFT.
    local procedure ExportPaymentInformationAlgeriaDFT(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;

        PmtInfNodeLocal: XmlNode;
        PmtTpInfNode: XmlNode;
        LclInstrmNode: XmlNode;
        DbtrNode: XmlNode;
        PstlAdrNode: XmlNode;
        DbtrAcctNode: XmlNode;
        IdNode: XmlNode;
        PrtryAcctNode: XmlNode;
        DbtrAgtNode: XmlNode;
        FinInstnIdNode: XmlNode;
        CmbndIdNode: XmlNode;

        AddressLine1: Text[110];
        AddressLine2: Text[60];
        ChargeBearer: Text[4];

        lVendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        BeneficiaryBankAccountNo: Text[30];
        lIsEURPayment: Boolean;
        InstructionPriority: Code[10];
        BankAccount: Record "Bank Account";
    begin
        //HEI.24>>

        RootNode := XMLNodeCurr;

        PaymentInformationCounter += 1;

        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        PmtInfNodeLocal := XMLNewChild;
        PmtInfNode := XMLNewChild;

        lIsEURPayment := false;
        if PmtJnlLine."Currency Code" = 'EUR' then
            lIsEURPayment := true;

        AddElement(PmtInfNodeLocal, 'PmtInfId', MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);

        if PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor then
            if lVendor.Get(PmtJnlLine."Account No.") then
                AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'PmtTpInf', '', '', XMLNewChild);
        PmtTpInfNode := XMLNewChild;

        AddElement(PmtTpInfNode, 'ClrChanl', 'MPNS', '', XMLNewChild);

        AddElement(PmtTpInfNode, 'LclInstrm', '', '', XMLNewChild);
        LclInstrmNode := XMLNewChild;

        AddElement(LclInstrmNode, 'Prtry', BankExportImportSetup."BOPCode FND", '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'ReqdExctnDt', Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'Dbtr', '', '', XMLNewChild);
        DbtrNode := XMLNewChild;

        if PmtJnlLine."HNK Bank Account" <> '' then
            BankAccount.Get(PmtJnlLine."HNK Bank Account");

        BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
        AddElement(DbtrNode, 'Nm', CopyStr(BankAccount.Name, 1, 70), '', XMLNewChild);

        AddElement(DbtrNode, 'PstlAdr', '', '', XMLNewChild);
        PstlAdrNode := XMLNewChild;

        GetCountry(BankAccount."Country/Region Code");

        AddressLine1 := DelChr(BankAccount.Address, '<>') + ' ' + DelChr(BankAccount."Address 2", '<>');
        AddressLine1 := ReplaceTextCharacters(AddressLine1);

        if StrLen(AddressLine1) <= 35 then
            AddElement(PstlAdrNode, 'AdrLine', AddressLine1, '', XMLNewChild);

        if (StrLen(AddressLine1) > 35) and (StrLen(AddressLine1) <= 70) then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 36, 35), '', XMLNewChild);
        end;

        if (StrLen(AddressLine1) > 70) and (StrLen(AddressLine1) <= 105) then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 36, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 71, 35), '', XMLNewChild);
        end;

        if StrLen(AddressLine1) > 105 then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 36, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 71, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 106, 35), '', XMLNewChild);
        end;

        AddressLine2 := DelChr(BankAccount."Post Code", '<>') + ' ' + DelChr(BankAccount.City, '<>');
        AddressLine2 := ReplaceTextCharacters(AddressLine2);

        if StrLen(AddressLine2) <= 35 then
            AddElement(PstlAdrNode, 'AdrLine', AddressLine2, '', XMLNewChild);

        if (StrLen(AddressLine2) > 35) and (StrLen(AddressLine2) <= 70) then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 36, 35), '', XMLNewChild);
        end;

        if (StrLen(AddressLine2) > 70) and (StrLen(AddressLine2) <= 105) then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 36, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 71, 35), '', XMLNewChild);
        end;

        if StrLen(AddressLine2) > 105 then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 36, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 71, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 106, 35), '', XMLNewChild);
        end;

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(PstlAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        else
            AddElement(PstlAdrNode, 'Ctry', CopyStr(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAcct', '', '', XMLNewChild);
        DbtrAcctNode := XMLNewChild;

        AddElement(DbtrAcctNode, 'Id', '', '', XMLNewChild);
        IdNode := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        BeneficiaryBankAccountNo := '';
        if VendBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") then
            BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

        AddElement(IdNode, 'PrtryAcct', '', '', XMLNewChild);
        PrtryAcctNode := XMLNewChild;

        AddElement(PrtryAcctNode, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAgt', '', '', XMLNewChild);
        DbtrAgtNode := XMLNewChild;

        AddElement(DbtrAgtNode, 'FinInstnId', '', '', XMLNewChild);
        FinInstnIdNode := XMLNewChild;

        AddElement(FinInstnIdNode, 'CmbndId', '', '', XMLNewChild);
        CmbndIdNode := XMLNewChild;

        AddElement(CmbndIdNode, 'BIC', CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

        XMLNodeCurr := RootNode;
        //HEI.24<<
    end;
    //BC UPGRADE KUMARR78 << Replacing Function  ExportPaymentInformationAlgeriaDFT Code.

    //BC UPGRADE KUMARR78 >> blocking
    // procedure ExportTransactionInformationAlgeriaDFT(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    // var
    //     GLSetup: Record "98";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     AddressLine3: Text[110];
    //     AddressLine4: Text[60];
    //     ISOCurrCode: Text[3];
    //     IBANTransfer: Boolean;
    //     VendorBankAccount: Record "288";
    //     BeneficiaryIBAN: Code[50];
    //     CustomerBankAccount: Record "287";
    //     BeneficiaryBankAccountNo: Code[30];
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     CustBankAcc: Record "287";
    //     VendBankAcc: Record "288";
    //     lSWIFTCode: Code[20];
    //     lBeneficiaryBankAccount: Code[30];
    //     lCust: Record "18";
    //     lVend: Record "23";
    //     CountryIBANCountryRegion: Boolean;
    //     lNewAmountText: Text;
    //     lBankExportImportSetup: Record "1200";
    //     lPosition: Integer;
    //     lCurrency: Record "4";
    //     BICICIABPos: Integer;
    //     CI93Pos: Integer;
    //     lPrtLctnValue: Text[10];
    //     lVend2: Record "23";
    //     lMmbId: Text[20];
    //     lIsDomesticTransfer: Boolean;
    //     lIsIntermediaryBank: Boolean;
    //     lSWIFTCodeIntermediaryBank: Code[20];
    //     lIsEURPayment: Boolean;
    //     lPmtJnlLine: Record "81";
    //     lPurchInvHeader: Record "122";
    //     lTotalExtDocNo: Text;
    //     lVendInvNo: Text;
    //     lText50000: Label '"INVOICE PAYMENT "';
    //     ChargeBearer: Text[4];
    //     IText50001: Label 'For DFT Payment file, Vendor''s Bank Account No should be of 20 Characters for Vendor No %1 and Vendor Bank Account Code %2';
    // begin
    //     //HEI.24>>
    //     WITH PmtJnlLine DO BEGIN
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         lIsEURPayment := FALSE;
    //         IF PmtJnlLine."Currency Code" = 'EUR' THEN
    //             lIsEURPayment := TRUE;

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'EndToEndId', CutText(PmtJnlLine."Document No.", 16), '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;


    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);
    //         GeneralLedgerSetup.GET;

    //         IF "Currency Code" = '' THEN
    //             ISOCurrCode := GeneralLedgerSetup."LCY Code"
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
    //         END;

    //         AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;


    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         lCust.GET("Account No.");
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := CustBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := CustBankAcc.Code;
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         lVend.GET("Account No.");
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := VendBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := VendBankAcc.Code;
    //                     END;
    //             END
    //         ELSE BEGIN
    //             lSWIFTCode := '';
    //             lBeneficiaryBankAccount := '';
    //         END;

    //         lVend2.RESET;
    //         IF "Account Type" = "Account Type"::Vendor THEN
    //             IF lVend2.GET("Account No.") THEN;


    //         lIsDomesticTransfer := FALSE;
    //         IF ("Account Type" = "Account Type"::Vendor) THEN BEGIN
    //             GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //             IF VendorBankAcc."Country/Region Code" = 'PA' THEN
    //                 lIsDomesticTransfer := TRUE;
    //         END;

    //         CASE PmtJnlLine."Code Expenses" OF
    //             PmtJnlLine."Code Expenses"::" ":
    //                 ChargeBearer := 'DEBT';
    //             PmtJnlLine."Code Expenses"::SHA:
    //                 ChargeBearer := 'SHAR';
    //             PmtJnlLine."Code Expenses"::BEN:
    //                 ChargeBearer := 'CRED';
    //             PmtJnlLine."Code Expenses"::OUR:
    //                 ChargeBearer := 'DEBT';
    //         END;

    //         AddElement(XMLNodeCurr, 'ChrgBr', ChargeBearer, '', XMLNewChild);

    //         lIsIntermediaryBank := FALSE;
    //         lSWIFTCodeIntermediaryBank := '';

    //         IF VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND" <> '' THEN BEGIN
    //             lIsIntermediaryBank := TRUE;
    //             lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND";
    //         END;

    //         AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;


    //         CASE "Account Type" OF
    //             "Account Type"::Vendor:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);

    //                     AddElement(XMLNodeCurr, 'CmbndId', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     lMmbId := VendorBankAcc."Bank Branch No.";
    //                     AddElement(XMLNodeCurr, 'Id', lMmbId, '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;


    //                     VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);

    //                     AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);
    //                     //HEI.26>>
    //                     AddressLine1 := '';
    //                     AddressLine2 := '';

    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     AddressLine1 := DELCHR(VendorBankAcc.Address, '<>') + ' ' + DELCHR(VendorBankAcc."Address 2", '<>');
    //                     AddressLine1 := ReplaceTextCharacters(AddressLine1);
    //                     //
    //                     IF (STRLEN(AddressLine1) <= 35) THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

    //                     IF ((STRLEN(AddressLine1) > 35) AND (STRLEN(AddressLine1) <= 70)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine1) > 70) AND (STRLEN(AddressLine1) <= 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine1) > 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 106, 35), '', XMLNewChild);
    //                     END;
    //                     //

    //                     AddressLine2 := DELCHR(VendorBankAcc."Post Code", '<>') + ' ' + DELCHR(VendorBankAcc.City, '<>');
    //                     AddressLine2 := ReplaceTextCharacters(AddressLine2);
    //                     //
    //                     IF (STRLEN(AddressLine2) <= 35) THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', AddressLine2, '', XMLNewChild);

    //                     IF ((STRLEN(AddressLine2) > 35) AND (STRLEN(AddressLine2) <= 70)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine2) > 70) AND (STRLEN(AddressLine2) <= 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine2) > 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 106, 35), '', XMLNewChild);
    //                     END;

    //                     GetCountry(VendorBankAcc."Country/Region Code");

    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(VendorBankAcc."Country/Region Code", 1, 2), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     AddressLine1 := '';
    //                     AddressLine2 := '';
    //                     //HEI.26<<


    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetVendor("Account No.");
    //                     Vendor.Name := ReplaceTextCharacters(Vendor.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Vendor."Country/Region Code");


    //                     Vendor.Address := ReplaceTextCharacters(Vendor.Address);
    //                     Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
    //                     AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');
    //                     //
    //                     IF (STRLEN(AddressLine1) <= 35) THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

    //                     IF ((STRLEN(AddressLine1) > 35) AND (STRLEN(AddressLine1) <= 70)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine1) > 70) AND (STRLEN(AddressLine1) <= 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine1) > 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 106, 35), '', XMLNewChild);
    //                     END;
    //                     //

    //                     Vendor.City := ReplaceTextCharacters(Vendor.City);
    //                     Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
    //                     AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
    //                     //
    //                     IF (STRLEN(AddressLine2) <= 35) THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', AddressLine2, '', XMLNewChild);

    //                     IF ((STRLEN(AddressLine2) > 35) AND (STRLEN(AddressLine2) <= 70)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine2) > 70) AND (STRLEN(AddressLine2) <= 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine2) > 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 106, 35), '', XMLNewChild);
    //                     END;

    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                 END;
    //             "Account Type"::Customer:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(CustomerBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCustomer("Account No.");
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Customer."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //         END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;


    //         AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := CustBankAcc.IBAN;
    //                         GetCountry(CustBankAcc."Country/Region Code");
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                     END;
    //             END
    //         ELSE BEGIN
    //             BeneficiaryBankAccountNo := '';
    //             BeneficiaryIBAN := '';
    //             Country."IBAN Country/Region" := FALSE;
    //         END;

    //         IF lIsEURPayment THEN
    //             IBANTransfer := (BeneficiaryIBAN <> '')
    //         ELSE //is USD payment
    //             IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region";

    //         AddElement(XMLNodeCurr, 'PrtryAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         //HEI.26>>
    //         IF STRLEN(BeneficiaryBankAccountNo) <> 20 THEN
    //             ERROR(IText50001, VendBankAcc."Vendor No.", VendBankAcc.Code);
    //         //HEI.26<<
    //         AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         lTotalExtDocNo := '';
    //         lPmtJnlLine.RESET;
    //         lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
    //         lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
    //         lPmtJnlLine.SETRANGE("Parent Line No.", PmtJnlLine."Line No.");
    //         IF lPmtJnlLine.FINDSET(FALSE, FALSE) THEN
    //             REPEAT
    //                 IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
    //                     IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
    //                         IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
    //                             lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.", STRLEN(lPurchInvHeader."Vendor Invoice No.") - 8, 9)
    //                         ELSE
    //                             lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
    //                         lTotalExtDocNo += lVendInvNo + ',';
    //                     END;
    //             UNTIL lPmtJnlLine.NEXT = 0;
    //         IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
    //             lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
    //             lTotalExtDocNo := lText50000 + lTotalExtDocNo; //HEI.14
    //             IF (STRLEN(lTotalExtDocNo) <= 35) THEN
    //                 AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
    //             IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
    //             END;
    //         END
    //         ELSE
    //             AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);

    //         XMLNodeCurr := RootNode;
    //     END;
    //     //HEI.24<<
    // end;

    //BC UPGRADE KUMARR78 << blocking

    //BC UPGRADE KUMARR67 >>

    procedure ExportTransactionInformationAlgeriaDFT(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        GLSetup: Record "General Ledger Setup";
        AddressLine1: Text[110];
        AddressLine2: Text[60];
        AddressLine3: Text[110];
        AddressLine4: Text[60];
        ISOCurrCode: Text[3];
        IBANTransfer: Boolean;
        VendorBankAccount: Record "Vendor Bank Account";
        BeneficiaryIBAN: Code[50];
        CustomerBankAccount: Record "Customer Bank Account";
        BeneficiaryBankAccountNo: Code[30];
        XMLNewChild: XmlNode;
        RootNode: XmlNode;
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        lSWIFTCode: Code[20];
        lBeneficiaryBankAccount: Code[30];
        lCust: Record Customer;
        lVend: Record Vendor;
        CountryIBANCountryRegion: Boolean;
        lNewAmountText: Text;
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lPosition: Integer;
        lCurrency: Record Currency;
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPrtLctnValue: Text[10];
        lVend2: Record Vendor;
        lMmbId: Text[20];
        lIsDomesticTransfer: Boolean;
        lIsIntermediaryBank: Boolean;
        lSWIFTCodeIntermediaryBank: Code[20];
        lIsEURPayment: Boolean;
        lPmtJnlLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        lTotalExtDocNo: Text;
        lVendInvNo: Text;
        lText50000: Label '"INVOICE PAYMENT "';
        ChargeBearer: Text[4];
        IText50001: Label 'For DFT Payment file, Vendor''s Bank Account No should be of 20 Characters for Vendor No %1 and Vendor Bank Account Code %2';
        FinInstNode: xmlnode;
        CdtrAgtNode: xmlnode;
        PmtIdNode: xmlnode;
        AmtNode: xmlnode;
        IdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        CdtrAcctNode: XmlNode;
    begin
        //HEI.24>>
        GLSetup.GET;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;

        lIsEURPayment := FALSE;
        IF PmtJnlLine."Currency Code" = 'EUR' THEN
            lIsEURPayment := TRUE;

        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'PmtId', '', '', PmtIdNode);
        AddElement(PmtIdNode, 'EndToEndId', PmtJnlLine."Document No.", '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Amt', '', '', AmtNode);
        XMLNodeCurr := XMLNewChild;

        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;


        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);

        GeneralLedgerSetup.GET;

        IF PmtJnlLine."Currency Code" = '' THEN
            ISOCurrCode := GeneralLedgerSetup."LCY Code"
        ELSE BEGIN
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
        END;

        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;

        lVend2.RESET;
        IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
            IF lVend2.GET(PmtJnlLine."Account No.") THEN;


        lIsDomesticTransfer := FALSE;
        IF (PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor) THEN BEGIN
            GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
            IF VendorBankAcc."Country/Region Code" = 'PA' THEN
                lIsDomesticTransfer := TRUE;
        END;

        CASE PmtJnlLine."Code Expenses" OF
            PmtJnlLine."Code Expenses"::" ":
                ChargeBearer := 'DEBT';
            PmtJnlLine."Code Expenses"::SHA:
                ChargeBearer := 'SHAR';
            PmtJnlLine."Code Expenses"::BEN:
                ChargeBearer := 'CRED';
            PmtJnlLine."Code Expenses"::OUR:
                ChargeBearer := 'DEBT';
        END;

        AddElement(XMLNodeCurr, 'ChrgBr', ChargeBearer, '', XMLNewChild);

        lIsIntermediaryBank := FALSE;
        lSWIFTCodeIntermediaryBank := '';

        IF VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND" <> '' THEN BEGIN
            lIsIntermediaryBank := TRUE;
            lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND";
        END;

        AddElement(XMLNodeCurr, 'CdtrAgt', '', '', CdtrAgtNode);
        AddElement(CdtrAgtNode, 'FinInstnId', '', '', FinInstNode);

        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);

                    AddElement(XMLNodeCurr, 'CmbndId', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    lMmbId := VendorBankAcc."Bank Branch No.";
                    AddElement(XMLNodeCurr, 'Id', lMmbId, '', XMLNewChild);
                    VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);

                    AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);
                    //HEI.26>>
                    AddressLine1 := '';
                    AddressLine2 := '';

                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    AddressLine1 := DELCHR(VendorBankAcc.Address, '<>') + ' ' + DELCHR(VendorBankAcc."Address 2", '<>');
                    AddressLine1 := ReplaceTextCharacters(AddressLine1);
                    //
                    IF (STRLEN(AddressLine1) <= 35) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

                    IF ((STRLEN(AddressLine1) > 35) AND (STRLEN(AddressLine1) <= 70)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine1) > 70) AND (STRLEN(AddressLine1) <= 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine1) > 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 106, 35), '', XMLNewChild);
                    END;
                    //
                    AddressLine2 := DELCHR(VendorBankAcc."Post Code", '<>') + ' ' + DELCHR(VendorBankAcc.City, '<>');
                    AddressLine2 := ReplaceTextCharacters(AddressLine2);
                    //
                    IF (STRLEN(AddressLine2) <= 35) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', AddressLine2, '', XMLNewChild);

                    IF ((STRLEN(AddressLine2) > 35) AND (STRLEN(AddressLine2) <= 70)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine2) > 70) AND (STRLEN(AddressLine2) <= 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine2) > 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 106, 35), '', XMLNewChild);
                    END;

                    GetCountry(VendorBankAcc."Country/Region Code");

                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(VendorBankAcc."Country/Region Code", 1, 2), '', XMLNewChild);

                    AddressLine1 := '';
                    AddressLine2 := '';
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetVendor(PmtJnlLine."Account No.");
                    Vendor.Name := ReplaceTextCharacters(Vendor.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Vendor."Country/Region Code");


                    Vendor.Address := ReplaceTextCharacters(Vendor.Address);
                    Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
                    AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');
                    //
                    IF (STRLEN(AddressLine1) <= 35) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

                    IF ((STRLEN(AddressLine1) > 35) AND (STRLEN(AddressLine1) <= 70)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine1) > 70) AND (STRLEN(AddressLine1) <= 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine1) > 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 106, 35), '', XMLNewChild);
                    END;
                    //
                    Vendor.City := ReplaceTextCharacters(Vendor.City);
                    Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
                    AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
                    //
                    IF (STRLEN(AddressLine2) <= 35) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', AddressLine2, '', XMLNewChild);

                    IF ((STRLEN(AddressLine2) > 35) AND (STRLEN(AddressLine2) <= 70)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine2) > 70) AND (STRLEN(AddressLine2) <= 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine2) > 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 106, 35), '', XMLNewChild);
                    END;

                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

                END;
            PmtJnlLine."Account Type"::Customer:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(CustomerBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCustomer(PmtJnlLine."Account No.");
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Customer."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);


                END;
        END;

        AddElement(XMLNodeCurr, 'CdtrAcct', '', '', CdtrAcctNode);
        AddElement(CdtrAcctNode, 'Id', '', '', IdNode);


        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                        BeneficiaryIBAN := CustBankAcc.IBAN;
                        GetCountry(CustBankAcc."Country/Region Code");
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");
                    END;
            END
        ELSE BEGIN
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := FALSE;
        END;

        IF lIsEURPayment THEN
            IBANTransfer := (BeneficiaryIBAN <> '')
        ELSE
        //is USD payment
            IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region FND";

        AddElement(XMLNodeCurr, 'PrtryAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        //HEI.26>>
        IF STRLEN(BeneficiaryBankAccountNo) <> 20 THEN
            ERROR(IText50001, VendBankAcc."Vendor No.", VendBankAcc.Code);
        AddElement(XMLNewChild, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'RmtInf', '', '', RmtInfNode);
        lTotalExtDocNo := '';
        lPmtJnlLine.RESET;
        lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
        lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
        lPmtJnlLine.SETRANGE("Parent Line No. FND", PmtJnlLine."Line No.");
        IF lPmtJnlLine.FINDSET(FALSE) THEN
            REPEAT
                IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
                    IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
                        IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
                            lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.", STRLEN(lPurchInvHeader."Vendor Invoice No.") - 8, 9)
                        ELSE
                            lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
                        lTotalExtDocNo += lVendInvNo + ',';
                    END;
            UNTIL lPmtJnlLine.NEXT = 0;
        IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
            lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
            lTotalExtDocNo := lText50000 + lTotalExtDocNo;
            //HEI.14
            IF (STRLEN(lTotalExtDocNo) <= 35) THEN
                AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
            IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
            END;
        END
        ELSE
            AddElement(RmtInfNode, 'Ustrd', CopyStr(PaymentMessage, 1, 70), '', XMLNewChild);

        XMLNodeCurr := RootNode;
        //HEI.24<<
    end;
    //BC UPGRADE KUMARR78 << Replacing ExportTransactionInformationAlgeriaDFT function.

    procedure FinishGroupHeaderAlgeriaDFT();
    var
        //BC UPGRADE KUMARR78 >> Replacing Variable
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 >> Replacing Variable
        XMLNodeCurr: xmlnode;
        XMLNewChild: xmlnode;
    begin
        //HEI.24>>
        // Insert Number of Transactions and ControlSum in the Group Header
        // XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document'); //BC UPGRADE KUMARR78 Rewriting.
        //XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr); //BC UPGRADE KUMARR78 Rewriting.
        XMLNodeCurr := FinalXmlNode;
        AddElement(XMLNodeCurr, 'NbOfTxs', FORMAT(NumberOfTransactions, 0, 9), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Grpg', 'MIXD', '', XMLNewChild);

        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        CompanyInfo.Name := ReplaceTextCharacters(CompanyInfo.Name);
        AddElement(XMLNodeCurr, 'Nm', COPYSTR(CompanyInfo.Name, 1, 35), '', XMLNewChild);
        //HEI.24<<
    end;

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite
    // local procedure StartGroupHeaderAlgeriaBKT(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     //HEI.24>>
    //     AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
    //     AddElement\(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
    //     //HEI.24<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite
    local procedure StartGroupHeaderAlgeriaBKT(XMLNodeCurr: XmlNode);
    var
        XMLNewChild: XmlNode;
    begin
        AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
    end;

    procedure ValidatePaymentContentAlgeriaBKT(GenJournalLine: Record "Gen. Journal Line BC FND"): Text;
    var
        // TempBlob: Record "99008535" temporary; //BC UPGRADE KUMARR78 Blocking
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        //BC UPGRADE KUMARR78 >> Blocking
        // XMLDOMManagement: Codeunit "6224";
        // XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lVendor: Record Vendor;
        lCountryRegion: Record "Country/Region";
        lText001: Label 'Company Information Address or Company Information Address 2 must have a value!';
        lText002: Label 'Company Information Post Code or Company Information City must have a value!';
        lBankAccount: Record "Bank Account";
        lCurrency: Record Currency;
        lVendorBankAccount: Record "Vendor Bank Account";
        lText003: Label 'Vendor Address or Vendor Address 2 must have a value for vendor %1!';
        lText004: Label 'Vendor Post Code or Vendor City must have a value for vendor %1!';
        lText005: Label 'Field %1 cannot be empty for %2 %3!';
        lText006: Label 'Field %1 cannot be empty in %2!';
        lText007: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText008: Label 'Panama Bank Routing Code cannot be empty for %2 %3 Vendor %4!';
    begin
        CompanyInfo.GET;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);

        IF lGenJournalLine.FINDSET(FALSE) THEN
            REPEAT
                IF (CompanyInfo.Name = '') THEN
                    ERROR(lText006, CompanyInfo.FIELDCAPTION(Name), CompanyInfo.TABLECAPTION);
                IF (CompanyInfo."Country/Region Code" = '') THEN
                    ERROR(lText006, CompanyInfo.FIELDCAPTION("Country/Region Code"), CompanyInfo.TABLECAPTION);
                IF (lGenJournalLine."Posting Date" = 0D) THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Posting Date"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."HNK Bank Account" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("HNK Bank Account"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Document No." = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Document No."), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Message to Recipient" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Message to Recipient"), lGenJournalLine81.TABLECAPTION);

                IF (CompanyInfo.Address + CompanyInfo."Address 2" = '') THEN
                    ERROR(lText001);
                IF (CompanyInfo."Post Code" + CompanyInfo.City = '') THEN
                    ERROR(lText002);

                IF lCountryRegion.GET(CompanyInfo."Country/Region Code") THEN
                    lCountryRegion.TESTFIELD("ISO Country/Region Code FND");

                IF lVendor.GET(lGenJournalLine."Account No.") THEN BEGIN
                    IF (lVendor.Name = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION(Name), lVendor.TABLECAPTION, lVendor."No.");
                    IF (lVendor."Payment Method Code" = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION("Payment Method Code"), lVendor.TABLECAPTION, lVendor."No.");
                    IF (lVendor."Country/Region Code" = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION("Country/Region Code"), lVendor.TABLECAPTION, lVendor."No.");

                    IF lCountryRegion.GET(lVendor."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendor."Country/Region Code");

                    IF (lVendor.Address + lVendor."Address 2" = '') THEN
                        ERROR(lText003, lVendor."No.");
                    IF (lVendor."Post Code" + lVendor.City = '') THEN
                        ERROR(lText004, lVendor."No.");
                END;

                IF lBankAccount.GET(lGenJournalLine."HNK Bank Account") THEN BEGIN
                    IF (lBankAccount."SWIFT Code" = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("SWIFT Code"), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");

                    IF (lBankAccount."Bank Account No." = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("Bank Account No."), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");
                END;

                IF (lGenJournalLine."Currency Code" <> '') THEN
                    IF lCurrency.GET(lGenJournalLine."Currency Code") THEN
                        IF (lCurrency."ISO Currency Code FND" = '') THEN
                            ERROR(lText005, lCurrency.FIELDCAPTION("ISO Currency Code FND"), lCurrency.TABLECAPTION, lCurrency.Code);

                IF lVendorBankAccount.GET(lGenJournalLine."Account No.", lGenJournalLine."Customer/Vendor Bank") THEN BEGIN
                    IF (lVendorBankAccount.Name = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION(Name), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Country/Region Code" = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Country/Region Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    //HEI.18>>
                    IF lGenJournalLine."Currency Code" = 'EUR' THEN
                        IF (lVendorBankAccount.IBAN = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION(IBAN), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    //HEI.18<<

                    IF lCountryRegion.GET(lVendorBankAccount."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendorBankAccount."Country/Region Code");

                    IF (lVendorBankAccount."Bank Account No." = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Account No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    IF lVendorBankAccount."Country/Region Code" = 'PA' THEN BEGIN
                        //commented on 20.01.2023, as the "Panama Bank Routing Code" (field "Domestic - Bank Branch No.") will be taken from "Bank Branch No."
                        //IF (lVendorBankAccount."Domestic - Bank Branch No." = '') THEN
                        //  ERROR(lText007,lVendorBankAccount.FIELDCAPTION("Domestic - Bank Branch No."),lVendorBankAccount.TABLECAPTION,lVendorBankAccount.Code,lGenJournalLine."Account No.");
                        //added on 20.01.2023
                        IF (lVendorBankAccount."Bank Branch No." = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Branch No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                        IF (COPYSTR(lVendorBankAccount."Bank Branch No.", 6, 3) = '') THEN
                            ERROR(lText008, lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                        IF (lVendor."VAT Registration No." = '') THEN
                            ERROR(lText005, lVendor.FIELDCAPTION("VAT Registration No."), lVendor.TABLECAPTION, lVendor."No.");
                    END
                    ELSE BEGIN
                        IF (lVendorBankAccount."SWIFT Code" = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION("SWIFT Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                        IF (lVendorBankAccount."Bank Branch No." = '') THEN
                            ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Branch No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    END;
                END;
            UNTIL lGenJournalLine.NEXT = 0;
    end;

    //BC UPGRADE KUMARR78 >> Blocking
    // procedure CreateNonSepaContentAlgeriaBKT(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     lNonSepaContent: Text;
    //     OutStr: OutStream;
    //     inStr: InStream;
    //     MyText: Text;
    //     XMLDOMManagement: Codeunit "6224";
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     BigText: BigText;
    //     XMLText: Text;
    //     filRead: File;
    //     intLen: Integer;
    //     txtOneLine: Text;
    //     txtFromFile: Text;
    //     TodayString: Text;
    //     FileName1: Text;
    //     InStream: InStream;
    //     i: Integer;
    //     j: Integer;
    //     k: Integer;
    //     k1: Integer;
    //     k3: Integer;
    //     TxtToAddInComponent: Text[80];
    //     InterfaceEntryComponent: Record "50003";
    //     c: Integer;
    //     cString: Text;
    //     NewPaymentGroup: Boolean;
    //     lGenJournalLine: Record "Gen. Journal Line BC FND";
    //     Pos: Integer;
    //     lGenJournalLine81: Record "81";
    // begin
    //     //HEI.24>>
    //     //Algeria
    //     CompanyInfo.GET;

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     //XMLRootElement.SetAttribute('xmlns','urn:iso:std:iso:20022:tech:xsd:pain.001.001.03'); //HEI.25
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.02'); //HEI.25
    //     XMLRootElement.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'pain.001.001.02', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //     GMessageId := MessageId;
    //     StartGroupHeaderAlgeriaBKT(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;


    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
    //     IF lGenJournalLine.FINDFIRST THEN
    //         REPEAT
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
    //                 ExportTransactionInformationAlgeriaBKT(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
    //                 InitConsolidatedPayment(lGenJournalLine);
    //             END ELSE
    //                 UpdateConsolidatedPayment(lGenJournalLine);

    //             IF NewPaymentGroup THEN
    //                 ExportPaymentInformationAlgeriaBKT(CstmrCdtTrfInitnNode, lGenJournalLine);
    //         UNTIL lGenJournalLine.NEXT = 0;

    //     IF NOT EmptyConsolidatedPayment THEN
    //         ExportTransactionInformationAlgeriaBKT(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

    //     //Footer
    //     FinishGroupHeaderAlgeriaBKT;

    //     IF DATE2DMY(TODAY, 2) < 10 THEN
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
    //     ELSE
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

    //     FileName := SaveToFileNameClient;

    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName, FileName);
    //     FullFileName := FileName;

    //     filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);

    //     intLen := filRead.LEN;
    //     txtFromFile := '';

    //     InterfaceEntryComponent.RESET;
    //     c := 1;
    //     cString := 'C0001';

    //     filRead.CREATEINSTREAM(InStream);
    //     WHILE NOT InStream.EOS DO BEGIN
    //         InStream.READTEXT(txtFromFile);
    //         i := STRLEN(txtFromFile);

    //         k := i DIV 80;
    //         k1 := i MOD 80;

    //         IF k1 <> 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k + 1 DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;

    //         IF k1 = 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;
    //     END;

    //     TxtToAddInComponent := ']]>';
    //     InterfaceEntryComponent.RESET;
    //     InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //     InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //     InterfaceEntryComponent.Code := FORMAT(cString);
    //     InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //     InterfaceEntryComponent.INSERT;
    //     c += 1;
    //     cString := INCSTR(cString);

    //     filRead.CLOSE;

    //     IF EXISTS(SaveToFileName) THEN
    //         IF ERASE(SaveToFileName) THEN;

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.DELETEALL;

    //     lGenJournalLine81.RESET;
    //     lGenJournalLine81.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine81.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine81.SETFILTER("Parent Line No.", '=%1', 0);
    //     lGenJournalLine81.MODIFYALL("WS Posting Allowed FND", TRUE);
    //     //HEI.24<<
    // end;
    //BC UPGRADE KUMARR78 >> Blocking

    procedure CreateNonSepaContentAlgeriaBKT(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text;
    var
        TempBlob: Codeunit "Temp Blob";
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XMLNodeCurr: XmlNode;
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XmlDecl);

        RootNode := XmlElement.Create('Document');
        RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.02');
        RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'pain.001.001.02', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;
        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeaderAlgeriaBKT(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
        IF lGenJournalLine.FINDFIRST THEN
            REPEAT
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                    ExportTransactionInformationAlgeriaBKT(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationAlgeriaBKT(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationAlgeriaBKT(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

        FinishGroupHeaderAlgeriaBKT;

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);

        c := 1;
        cString := 'C0001';

        i := StrLen(XMLText);
        k := i div 80;
        k1 := i mod 80;
        k3 := 1;

        for j := 1 to k do begin
            txtOneLine := CopyStr(XMLText, k3, 80);
            k3 += 80;

            TxtToAddInComponent := txtOneLine;

            Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
            if Pos <> 0 then
                TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

            InsertInterfaceComponentLine(
                InterfaceEntryComponent,
                InterfaceEntryLine,
                cString,
                TxtToAddInComponent);

            c += 1;
            cString := IncStr(cString);
        end;

        if k1 <> 0 then begin
            txtOneLine := CopyStr(XMLText, k3, 80);

            TxtToAddInComponent := txtOneLine;

            Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
            if Pos <> 0 then
                TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

            InsertInterfaceComponentLine(
                InterfaceEntryComponent,
                InterfaceEntryLine,
                cString,
                TxtToAddInComponent);

            c += 1;
            cString := IncStr(cString);
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);

        exit(XMLText);

    end;

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite.
    // local procedure ExportPaymentInformationAlgeriaBKT(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     AddressLine3: Text[110];
    //     AddressLine4: Text[60];
    //     ChargeBearer: Text[4];
    //     BICICIABPos: Integer;
    //     lVendor: Record "23";
    //     VendBankAcc: Record "288";
    //     BeneficiaryBankAccountNo: Text[30];
    //     lIsEURPayment: Boolean;
    //     InstructionPriority: Code[10];
    //     BankAccount: Record "270";
    // begin
    //     //HEI.24>>
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;

    //     lIsEURPayment := FALSE;
    //     IF PmtJnlLine."Currency Code" = 'EUR' THEN
    //         lIsEURPayment := TRUE;

    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);

    //     IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
    //         IF lVendor.GET(PmtJnlLine."Account No.") THEN
    //             AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'ClrChanl', 'BOOK', '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'LclInstrm', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Prtry', BankExportImportSetup.BOPCode, '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     IF PmtJnlLine."HNK Bank Account" <> '' THEN
    //         BankAccount.GET(PmtJnlLine."HNK Bank Account");
    //     BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
    //     AddElement(XMLNodeCurr, 'Nm', COPYSTR(BankAccount.Name, 1, 70), '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetCountry(BankAccount."Country/Region Code");
    //     //HEI.26>>
    //     /*IF Country."ISO Country/Region Code" <> '' THEN
    //       AddElement(XMLNodeCurr,'Ctry',COPYSTR(Country."ISO Country/Region Code",1,2),'',XMLNewChild)
    //       ELSE
    //        AddElement(XMLNodeCurr,'Ctry',COPYSTR(BankAccount."Country/Region Code",1,2),'',XMLNewChild);*/
    //     //HEI.26<<

    //     AddressLine1 := DELCHR(BankAccount.Address, '<>') + ' ' + DELCHR(BankAccount."Address 2", '<>');
    //     AddressLine1 := ReplaceTextCharacters(AddressLine1);
    //     //
    //     IF (STRLEN(AddressLine1) <= 35) THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

    //     IF ((STRLEN(AddressLine1) > 35) AND (STRLEN(AddressLine1) <= 70)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //     END;
    //     IF ((STRLEN(AddressLine1) > 70) AND (STRLEN(AddressLine1) <= 105)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //     END;
    //     IF ((STRLEN(AddressLine1) > 105)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 106, 35), '', XMLNewChild);
    //     END;
    //     //

    //     AddressLine2 := DELCHR(BankAccount."Post Code", '<>') + ' ' + DELCHR(BankAccount.City, '<>');
    //     AddressLine2 := ReplaceTextCharacters(AddressLine2);
    //     //
    //     IF (STRLEN(AddressLine2) <= 35) THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', AddressLine2, '', XMLNewChild);

    //     IF ((STRLEN(AddressLine2) > 35) AND (STRLEN(AddressLine2) <= 70)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //     END;
    //     IF ((STRLEN(AddressLine2) > 70) AND (STRLEN(AddressLine2) <= 105)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //     END;
    //     IF ((STRLEN(AddressLine2) > 105)) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 106, 35), '', XMLNewChild);
    //     END;
    //     //HEI.26>>
    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);
    //     //HEI.26
    //     //
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");

    //     BeneficiaryBankAccountNo := '';
    //     IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
    //         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

    //     AddElement(XMLNodeCurr, 'PrtryAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;


    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'CmbndId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := RootNode;
    //     //HEI.24<<

    // end;
    //BC UPGRADE KUMARR78 >> Blocking

    //BC UPGRADE KUMARR78 >> Rewriting
    local procedure ExportPaymentInformationAlgeriaBKT(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;

        PmtInfNodeLocal: XmlNode;
        PmtTpInfNode: XmlNode;
        LclInstrmNode: XmlNode;
        DbtrNode: XmlNode;
        PstlAdrNode: XmlNode;
        DbtrAcctNode: XmlNode;
        IdNode: XmlNode;
        PrtryAcctNode: XmlNode;
        DbtrAgtNode: XmlNode;
        FinInstnIdNode: XmlNode;
        CmbndIdNode: XmlNode;

        AddressLine1: Text[110];
        AddressLine2: Text[60];
        BeneficiaryBankAccountNo: Text[30];

        lIsEURPayment: Boolean;

        VendorRec: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        BankAccount: Record "Bank Account";
    begin
        //HEI.24>>

        RootNode := XMLNodeCurr;

        PaymentInformationCounter += 1;

        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        PmtInfNodeLocal := XMLNewChild;
        PmtInfNode := XMLNewChild;

        lIsEURPayment := false;
        if PmtJnlLine."Currency Code" = 'EUR' then
            lIsEURPayment := true;

        AddElement(PmtInfNodeLocal, 'PmtInfId', MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);

        if PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor then
            if VendorRec.Get(PmtJnlLine."Account No.") then
                AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'PmtTpInf', '', '', XMLNewChild);
        PmtTpInfNode := XMLNewChild;

        AddElement(PmtTpInfNode, 'ClrChanl', 'BOOK', '', XMLNewChild);

        AddElement(PmtTpInfNode, 'LclInstrm', '', '', XMLNewChild);
        LclInstrmNode := XMLNewChild;

        AddElement(LclInstrmNode, 'Prtry', BankExportImportSetup."BOPCode FND", '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'ReqdExctnDt', Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'Dbtr', '', '', XMLNewChild);
        DbtrNode := XMLNewChild;

        if PmtJnlLine."HNK Bank Account" <> '' then
            BankAccount.Get(PmtJnlLine."HNK Bank Account");

        BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);

        AddElement(DbtrNode, 'Nm', CopyStr(BankAccount.Name, 1, 70), '', XMLNewChild);

        AddElement(DbtrNode, 'PstlAdr', '', '', XMLNewChild);
        PstlAdrNode := XMLNewChild;

        GetCountry(BankAccount."Country/Region Code");

        AddressLine1 := DelChr(BankAccount.Address, '<>') + ' ' + DelChr(BankAccount."Address 2", '<>');
        AddressLine1 := ReplaceTextCharacters(AddressLine1);

        if StrLen(AddressLine1) <= 35 then
            AddElement(PstlAdrNode, 'AdrLine', AddressLine1, '', XMLNewChild);

        if (StrLen(AddressLine1) > 35) and (StrLen(AddressLine1) <= 70) then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 36, 35), '', XMLNewChild);
        end;

        if (StrLen(AddressLine1) > 70) and (StrLen(AddressLine1) <= 105) then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 36, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 71, 35), '', XMLNewChild);
        end;

        if StrLen(AddressLine1) > 105 then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 36, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 71, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 106, 35), '', XMLNewChild);
        end;

        AddressLine2 := DelChr(BankAccount."Post Code", '<>') + ' ' + DelChr(BankAccount.City, '<>');
        AddressLine2 := ReplaceTextCharacters(AddressLine2);

        if StrLen(AddressLine2) <= 35 then
            AddElement(PstlAdrNode, 'AdrLine', AddressLine2, '', XMLNewChild);

        if (StrLen(AddressLine2) > 35) and (StrLen(AddressLine2) <= 70) then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 36, 35), '', XMLNewChild);
        end;

        if (StrLen(AddressLine2) > 70) and (StrLen(AddressLine2) <= 105) then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 36, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 71, 35), '', XMLNewChild);
        end;

        if StrLen(AddressLine2) > 105 then begin
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 36, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 71, 35), '', XMLNewChild);
            AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 106, 35), '', XMLNewChild);
        end;

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(PstlAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        else
            AddElement(PstlAdrNode, 'Ctry', CopyStr(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAcct', '', '', XMLNewChild);
        DbtrAcctNode := XMLNewChild;

        AddElement(DbtrAcctNode, 'Id', '', '', XMLNewChild);
        IdNode := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        BeneficiaryBankAccountNo := '';

        if VendBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") then
            BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

        AddElement(IdNode, 'PrtryAcct', '', '', XMLNewChild);
        PrtryAcctNode := XMLNewChild;

        AddElement(PrtryAcctNode, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAgt', '', '', XMLNewChild);
        DbtrAgtNode := XMLNewChild;

        AddElement(DbtrAgtNode, 'FinInstnId', '', '', XMLNewChild);
        FinInstnIdNode := XMLNewChild;

        AddElement(FinInstnIdNode, 'CmbndId', '', '', XMLNewChild);
        CmbndIdNode := XMLNewChild;

        AddElement(CmbndIdNode, 'BIC', CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

        XMLNodeCurr := RootNode;

        //HEI.24<<
    end;
    //BC UPGRADE KUMARR78 << Rewriting


    //BC UPGRADE KUMARR78 >> Blocking
    // procedure ExportTransactionInformationAlgeriaBKT(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    // var
    //     GLSetup: Record "98";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     AddressLine3: Text[110];
    //     AddressLine4: Text[60];
    //     ISOCurrCode: Text[3];
    //     IBANTransfer: Boolean;
    //     VendorBankAccount: Record "288";
    //     BeneficiaryIBAN: Code[50];
    //     CustomerBankAccount: Record "287";
    //     BeneficiaryBankAccountNo: Code[30];
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     CustBankAcc: Record "287";
    //     VendBankAcc: Record "288";
    //     lSWIFTCode: Code[20];
    //     lBeneficiaryBankAccount: Code[30];
    //     lCust: Record "18";
    //     lVend: Record "23";
    //     CountryIBANCountryRegion: Boolean;
    //     lNewAmountText: Text;
    //     lBankExportImportSetup: Record "1200";
    //     lPosition: Integer;
    //     lCurrency: Record "4";
    //     BICICIABPos: Integer;
    //     CI93Pos: Integer;
    //     lPrtLctnValue: Text[10];
    //     lVend2: Record "23";
    //     lMmbId: Text[20];
    //     lIsDomesticTransfer: Boolean;
    //     lIsIntermediaryBank: Boolean;
    //     lSWIFTCodeIntermediaryBank: Code[20];
    //     lIsEURPayment: Boolean;
    //     lPmtJnlLine: Record "81";
    //     lPurchInvHeader: Record "122";
    //     lTotalExtDocNo: Text;
    //     lVendInvNo: Text;
    //     lText50000: Label '"INVOICE PAYMENT "';
    //     IText50001: Label 'For BKT Payment file, Vendor''s Bank Account No should not be greater than 10 Characters for Vendor No %1 and Vendor Bank Account Code %2';
    // begin
    //     //HEI.24>>
    //     WITH PmtJnlLine DO BEGIN
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         lIsEURPayment := FALSE;
    //         IF PmtJnlLine."Currency Code" = 'EUR' THEN
    //             lIsEURPayment := TRUE;

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'EndToEndId', CutText(PmtJnlLine."Document No.", 16), '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         //AddElement(XMLNodeCurr,'EqvtAmt','','',XMLNewChild); //HEI.27
    //         //XMLNodeCurr := XMLNewChild; //HEI.27
    //         GeneralLedgerSetup.GET;
    //         //AddAttribute(XMLDomDoc,XMLNewChild,'Ccy',GeneralLedgerSetup."LCY Code"); //HEI.27

    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;


    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;
    //         //HEI.27>>
    //         //AddElement(XMLNodeCurr,'Amt',lNewAmountText,'',XMLNewChild); //todo
    //         AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);
    //         //HEI.27<<
    //         GeneralLedgerSetup.GET;

    //         IF "Currency Code" = '' THEN
    //             ISOCurrCode := GeneralLedgerSetup."LCY Code"
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             IF Currency."ISO Currency Code FND" <> '' THEN
    //                 ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3)
    //             ELSE
    //                 ISOCurrCode := GeneralLedgerSetup."LCY Code";
    //         END;

    //         AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //         //AddElement(XMLNodeCurr,'CcyOfTrf','','',XMLNewChild); //HEI.27
    //         //XMLNodeCurr := XMLNodeCurr.ParentNode; //HEI.27
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         lCust.GET("Account No.");
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := CustBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := CustBankAcc.Code;
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         lVend.GET("Account No.");
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := VendBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := VendBankAcc.Code;
    //                     END;
    //             END
    //         ELSE BEGIN
    //             lSWIFTCode := '';
    //             lBeneficiaryBankAccount := '';
    //         END;

    //         lVend2.RESET;
    //         IF "Account Type" = "Account Type"::Vendor THEN
    //             IF lVend2.GET("Account No.") THEN;


    //         lIsDomesticTransfer := FALSE;
    //         IF ("Account Type" = "Account Type"::Vendor) THEN BEGIN
    //             GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //             IF VendorBankAcc."Country/Region Code" = 'PA' THEN
    //                 lIsDomesticTransfer := TRUE;
    //         END;

    //         lIsIntermediaryBank := FALSE;
    //         lSWIFTCodeIntermediaryBank := '';

    //         IF VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND" <> '' THEN BEGIN
    //             lIsIntermediaryBank := TRUE;
    //             lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND";
    //         END;

    //         AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         CASE "Account Type" OF
    //             "Account Type"::Vendor:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);


    //                     AddElement(XMLNodeCurr, 'BrnchId', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     lMmbId := VendorBankAcc."Bank Branch No.";
    //                     AddElement(XMLNodeCurr, 'Id', lMmbId, '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetVendor("Account No.");
    //                     Vendor.Name := ReplaceTextCharacters(Vendor.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Vendor."Country/Region Code");

    //                     Vendor.Address := ReplaceTextCharacters(Vendor.Address);
    //                     Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
    //                     AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');

    //                     IF (STRLEN(AddressLine1) <= 35) THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

    //                     IF ((STRLEN(AddressLine1) > 35) AND (STRLEN(AddressLine1) <= 70)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine1) > 70) AND (STRLEN(AddressLine1) <= 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine1) > 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 106, 35), '', XMLNewChild);
    //                     END;

    //                     Vendor.City := ReplaceTextCharacters(Vendor.City);
    //                     Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
    //                     AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');

    //                     IF (STRLEN(AddressLine2) <= 35) THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', AddressLine2, '', XMLNewChild);

    //                     IF ((STRLEN(AddressLine2) > 35) AND (STRLEN(AddressLine2) <= 70)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine2) > 70) AND (STRLEN(AddressLine2) <= 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //                     END;
    //                     IF ((STRLEN(AddressLine2) > 105)) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 106, 35), '', XMLNewChild);
    //                     END;

    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                 END;
    //             "Account Type"::Customer:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(CustomerBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCustomer("Account No.");
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Customer."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //         END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := CustBankAcc.IBAN;
    //                         GetCountry(CustBankAcc."Country/Region Code");
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                     END;
    //             END
    //         ELSE BEGIN
    //             BeneficiaryBankAccountNo := '';
    //             BeneficiaryIBAN := '';
    //             Country."IBAN Country/Region" := FALSE;
    //         END;

    //         IF lIsEURPayment THEN
    //             IBANTransfer := (BeneficiaryIBAN <> '')
    //         ELSE //is USD payment
    //             IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region";

    //         AddElement(XMLNodeCurr, 'PrtryAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         //HEI.26>>
    //         //IF STRLEN(BeneficiaryBankAccountNo) <> 20 THEN //HEI.27
    //         IF STRLEN(BeneficiaryBankAccountNo) > 10 THEN //HEI.27
    //             ERROR(IText50001, VendBankAcc."Vendor No.", VendBankAcc.Code);
    //         //HEI.26<<
    //         AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'InstrForDbtrAgt', 'CONFIDENTIAL', '', XMLNewChild);

    //         AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         lTotalExtDocNo := '';
    //         lPmtJnlLine.RESET;
    //         lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
    //         lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
    //         lPmtJnlLine.SETRANGE("Parent Line No.", PmtJnlLine."Line No.");
    //         IF lPmtJnlLine.FINDSET(FALSE, FALSE) THEN
    //             REPEAT
    //                 IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
    //                     IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
    //                         IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
    //                             lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.", STRLEN(lPurchInvHeader."Vendor Invoice No.") - 8, 9)
    //                         ELSE
    //                             lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
    //                         lTotalExtDocNo += lVendInvNo + ',';
    //                     END;
    //             UNTIL lPmtJnlLine.NEXT = 0;
    //         IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
    //             lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
    //             lTotalExtDocNo := lText50000 + lTotalExtDocNo; //HEI.14
    //             IF (STRLEN(lTotalExtDocNo) <= 35) THEN
    //                 AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
    //             IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
    //             END;
    //         END
    //         ELSE
    //             AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);

    //         XMLNodeCurr := RootNode;
    //     END;
    //     //HEI.24<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking

    //BC UPGRADE KUMARR78 >>
    //BC UPGRADE KUMARR78 >> Rewriting

    procedure ExportTransactionInformationAlgeriaBKT(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        GLSetup: Record "General Ledger Setup";
        AddressLine1: Text[110];
        AddressLine2: Text[60];
        AddressLine3: Text[110];
        AddressLine4: Text[60];
        ISOCurrCode: Text[3];
        IBANTransfer: Boolean;
        VendorBankAccount: Record "Vendor Bank Account";
        BeneficiaryIBAN: Code[50];
        CustomerBankAccount: Record "Customer Bank Account";
        BeneficiaryBankAccountNo: Code[30];
        XMLNewChild: XmlNode;
        RootNode: XmlNode;
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        lSWIFTCode: Code[20];
        lBeneficiaryBankAccount: Code[30];
        lCust: Record Customer;
        lVend: Record Vendor;
        CountryIBANCountryRegion: Boolean;
        lNewAmountText: Text;
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lPosition: Integer;
        lCurrency: Record Currency;
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPrtLctnValue: Text[10];
        lVend2: Record Vendor;
        lMmbId: Text[20];
        lIsDomesticTransfer: Boolean;
        lIsIntermediaryBank: Boolean;
        lSWIFTCodeIntermediaryBank: Code[20];
        lIsEURPayment: Boolean;
        lPmtJnlLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        lTotalExtDocNo: Text;
        lVendInvNo: Text;
        lText50000: Label '"INVOICE PAYMENT "';
        IText50001: Label 'For BKT Payment file, Vendor''s Bank Account No should not be greater than 10 Characters for Vendor No %1 and Vendor Bank Account Code %2';
        FinInstNode: xmlnode;
        CdtrAgtNode: xmlnode;
        PmtIdNode: xmlnode;
        AmtNode: xmlnode;
        IdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        CdtrAcctNode: XmlNode;
    begin
        //HEI.24>>
        GLSetup.GET;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;

        lIsEURPayment := FALSE;
        IF PmtJnlLine."Currency Code" = 'EUR' THEN
            lIsEURPayment := TRUE;

        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'PmtId', '', '', PmtIdNode);
        AddElement(PmtIdNode, 'EndToEndId', PmtJnlLine."Document No.", '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Amt', '', '', AmtNode);

        XMLNodeCurr := XMLNewChild;
        GeneralLedgerSetup.GET;

        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;


        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;
        //HEI.27>>
        //AddElement(XMLNodeCurr,'Amt',lNewAmountText,'',XMLNewChild); //todo
        AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);
        //HEI.27<<
        GeneralLedgerSetup.GET;

        IF PmtJnlLine."Currency Code" = '' THEN
            ISOCurrCode := GeneralLedgerSetup."LCY Code"
        ELSE BEGIN
            GetCurrency(PmtJnlLine."Currency Code");
            IF Currency."ISO Currency Code FND" <> '' THEN
                ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3)
            ELSE
                ISOCurrCode := GeneralLedgerSetup."LCY Code";
        END;

        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);
        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;

        lVend2.RESET;
        IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
            IF lVend2.GET(PmtJnlLine."Account No.") THEN;

        lIsDomesticTransfer := FALSE;
        IF (PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor) THEN BEGIN
            GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
            IF VendorBankAcc."Country/Region Code" = 'PA' THEN
                lIsDomesticTransfer := TRUE;
        END;

        lIsIntermediaryBank := FALSE;
        lSWIFTCodeIntermediaryBank := '';

        IF VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND" <> '' THEN BEGIN
            lIsIntermediaryBank := TRUE;
            lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND";
        END;

        AddElement(XMLNodeCurr, 'CdtrAgt', '', '', CdtrAgtNode);

        XMLNodeCurr := XMLNewChild;

        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);


                    AddElement(XMLNodeCurr, 'BrnchId', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    lMmbId := VendorBankAcc."Bank Branch No.";
                    AddElement(XMLNodeCurr, 'Id', lMmbId, '', XMLNewChild);
                    VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetVendor(PmtJnlLine."Account No.");
                    Vendor.Name := ReplaceTextCharacters(Vendor.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Vendor."Country/Region Code");

                    Vendor.Address := ReplaceTextCharacters(Vendor.Address);
                    Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
                    AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');

                    IF (STRLEN(AddressLine1) <= 35) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

                    IF ((STRLEN(AddressLine1) > 35) AND (STRLEN(AddressLine1) <= 70)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine1) > 70) AND (STRLEN(AddressLine1) <= 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine1) > 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 71, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 106, 35), '', XMLNewChild);
                    END;

                    Vendor.City := ReplaceTextCharacters(Vendor.City);
                    Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
                    AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');

                    IF (STRLEN(AddressLine2) <= 35) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', AddressLine2, '', XMLNewChild);

                    IF ((STRLEN(AddressLine2) > 35) AND (STRLEN(AddressLine2) <= 70)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine2) > 70) AND (STRLEN(AddressLine2) <= 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
                    END;
                    IF ((STRLEN(AddressLine2) > 105)) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 36, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 71, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 106, 35), '', XMLNewChild);
                    END;

                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

                END;
            PmtJnlLine."Account Type"::Customer:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(CustomerBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCustomer(PmtJnlLine."Account No.");
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Customer."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                END;
        END;

        AddElement(XMLNodeCurr, 'CdtrAcct', '', '', CdtrAcctNode);
        AddElement(CdtrAcctNode, 'Id', '', '', IdNode);



        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                        BeneficiaryIBAN := CustBankAcc.IBAN;
                        GetCountry(CustBankAcc."Country/Region Code");
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");
                    END;
            END
        ELSE BEGIN
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := FALSE;
        END;

        IF lIsEURPayment THEN
            IBANTransfer := (BeneficiaryIBAN <> '')
        ELSE
        //is USD payment
            IBANTransfer := (BeneficiaryIBAN <> '') AND Country."IBAN Country/Region FND";

        AddElement(XMLNodeCurr, 'PrtryAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        //HEI.26>>
        //IF STRLEN(BeneficiaryBankAccountNo) <> 20 THEN //HEI.27
        IF STRLEN(BeneficiaryBankAccountNo) > 10 THEN
        //HEI.27
            ERROR(IText50001, VendBankAcc."Vendor No.", VendBankAcc.Code);
        //HEI.26<<
        AddElement(XMLNewChild, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);

        AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'InstrForDbtrAgt', 'CONFIDENTIAL', '', XMLNewChild);

        AddElement(XMLNodeCurr, 'RmtInf', '', '', RmtInfNode);
        XMLNodeCurr := XMLNewChild;

        lTotalExtDocNo := '';
        lPmtJnlLine.RESET;
        lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
        lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
        lPmtJnlLine.SETRANGE("Parent Line No. FND", PmtJnlLine."Line No.");
        IF lPmtJnlLine.FINDSET(FALSE) THEN
            REPEAT
                IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
                    IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
                        IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
                            lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.", STRLEN(lPurchInvHeader."Vendor Invoice No.") - 8, 9)
                        ELSE
                            lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
                        lTotalExtDocNo += lVendInvNo + ',';
                    END;
            UNTIL lPmtJnlLine.NEXT = 0;
        IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
            lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
            lTotalExtDocNo := lText50000 + lTotalExtDocNo;
            //HEI.14
            IF (STRLEN(lTotalExtDocNo) <= 35) THEN
                AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
            IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
            END;
        END
        ELSE
            AddElement(RmtInfNode, 'Ustrd', CopyStr(PaymentMessage, 1, 70), '', XMLNewChild);

        XMLNodeCurr := RootNode;
        //HEI.24<<
    end;
    //BC UPGRADE KUMARR78 << Rewriting
    procedure FinishGroupHeaderAlgeriaBKT();
    var
        //BC UPGRADE KUMARR78 >> Blocking
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 >> Blocking
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;

    begin
        //HEI.24>>
        // Insert Number of Transactions and ControlSum in the Group Header
        // XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document'); //BC UPGRADE KUMARR78 Blocking to Rewrite.
        XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'NbOfTxs', FORMAT(NumberOfTransactions, 0, 9), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Grpg', 'MIXD', '', XMLNewChild);

        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        CompanyInfo.Name := ReplaceTextCharacters(CompanyInfo.Name);
        AddElement(XMLNodeCurr, 'Nm', COPYSTR(CompanyInfo.Name, 1, 35), '', XMLNewChild);
        //HEI.24<<
    end;

    //BC UPGRADE KUMARR78 >> Blocking CreateNonsepaContentBahamas440 Function.
    // procedure CreateNonSepaContentBahamas440(GenJournalLine : Record "Gen. Journal Line BC";InterfaceEntryLine : Record "Interface Entry Line") : Text;
    //     var
    //         TempBlob : Record TempBlob temporary;
    //         lNonSepaContent : Text;
    //         OutStr : OutStream;
    //         inStr : InStream;
    //         MyText : Text;
    //         XMLDOMManagement : Codeunit "XML DOM Management";
    //         XMLRootElement : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //         XMLNodeCurr : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //         XMLNewChild : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //         BigText : BigText;
    //         XMLText : Text;
    //         filRead : File;
    //         intLen : Integer;
    //         txtOneLine : Text;
    //         txtFromFile : Text;
    //         TodayString : Text;
    //         FileName1 : Text;
    //         InStream : InStream;
    //         i : Integer;
    //         j : Integer;
    //         k : Integer;
    //         k1 : Integer;
    //         k3 : Integer;
    //         TxtToAddInComponent : Text[80];
    //         InterfaceEntryComponent : Record "Interface Entry Component INT";
    //         c : Integer;
    //         cString : Text;
    //         NewPaymentGroup : Boolean;
    //         lGenJournalLine : Record "Gen. Journal Line BC FND";
    //         Pos : Integer;
    //         lGenJournalLine81 : Record "Gen. Journal Line";
    //         lTotalAmtOnJournal : Decimal;
    //     begin
    //         //HEI.28>>
    //         CompanyInfo.GET;

    //         //Header
    //         XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>',XMLDomDoc);
    //         XMLRootElement := XMLDomDoc.DocumentElement;
    //         XMLRootElement.SetAttribute('xmlns','urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //         XMLRootElement.SetAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
    //         XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //         AddElement(XMLNodeCurr,'CstmrCdtTrfInitn','','',XMLNewChild);
    //         CstmrCdtTrfInitnNode := XMLNewChild;
    //         MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //         GMessageId := MessageId;
    //         StartGroupHeaderBahamas440(XMLNewChild);
    //         PaymentInformationCounter := 0;
    //         NumberOfTransactions := 0;
    //         lTotalAmtOnJournal := 0;

    //         SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //         SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //         lGenJournalLine.RESET;
    //         lGenJournalLine.SETRANGE("Journal Template Name",GenJournalLine."Journal Template Name");
    //         lGenJournalLine.SETRANGE("Journal Batch Name",GenJournalLine."Journal Batch Name");
    //         lGenJournalLine.SETFILTER("Parent Line No.",'=%1',0);
    //         if lGenJournalLine.FINDFIRST then
    //           repeat
    //             lTotalAmtOnJournal += lGenJournalLine.Amount;
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             if NewConsolidatedPayment(lGenJournalLine) then begin
    //               ExportTransactionInformationBahamas440(PmtInfNode,ConsolidatedPmtJnlLine,ConsolidatedPmtMessage);
    //               InitConsolidatedPayment(lGenJournalLine);
    //             end else
    //               UpdateConsolidatedPayment(lGenJournalLine);

    //             if NewPaymentGroup then
    //               ExportPaymentInformationBahamas440(CstmrCdtTrfInitnNode,lGenJournalLine);
    //           until lGenJournalLine.NEXT = 0;

    //         if not EmptyConsolidatedPayment then
    //           ExportTransactionInformationBahamas440(PmtInfNode,ConsolidatedPmtJnlLine,ConsolidatedPmtMessage);

    //         //Footer
    //         FinishGroupHeaderBahamas440(lTotalAmtOnJournal);

    //         if DATE2DMY(TODAY, 2) < 10 then
    //           TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0'+ FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                             FORMAT(TIME,0,'<hours24><minutes,2><seconds,2>')
    //         else
    //           TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                             FORMAT(TIME,0,'<hours24><minutes,2><seconds,2>');

    //         FileName := SaveToFileNameClient;

    //         XMLDomDoc.Save(SaveToFileName);
    //         RBMgt.DownloadToFile(SaveToFileName,FileName);
    //         FullFileName := FileName;

    //         filRead.OPEN(SaveToFileName,TEXTENCODING::UTF8);

    //         intLen := filRead.LEN;
    //         txtFromFile := '';

    //         InterfaceEntryComponent.RESET;
    //         c := 1;
    //         cString := 'C0001';

    //         filRead.CREATEINSTREAM(InStream);
    //         while not InStream.EOS do begin
    //           InStream.READTEXT(txtFromFile);
    //           i := STRLEN(txtFromFile);

    //           k := i div 80;
    //           k1 := i mod 80;

    //           if k1 <> 0 then
    //             begin
    //               k3 := 1;
    //               for j := 1 to k + 1 do
    //                 begin
    //                   txtOneLine := COPYSTR(txtFromFile,k3,80);
    //                   k3 += 80;
    //                   TxtToAddInComponent := txtOneLine;
    //                   InterfaceEntryComponent.RESET;
    //                   InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                   InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                   InterfaceEntryComponent.Code := FORMAT(cString);

    //                   Pos := STRPOS(TxtToAddInComponent,'<?xml version="1.0" encoding="UTF-8"?>');
    //                   if Pos <> 0 then
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                   InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent,'<>',' ');
    //                   InterfaceEntryComponent.INSERT;
    //                   c += 1;
    //                   cString := INCSTR(cString);
    //                 end;
    //             end;

    //           if k1 = 0 then
    //             begin
    //               k3 := 1;
    //               for j := 1 to k do
    //                 begin
    //                   txtOneLine := COPYSTR(txtFromFile,k3,80);
    //                   k3 += 80;
    //                   TxtToAddInComponent := txtOneLine;
    //                   InterfaceEntryComponent.RESET;
    //                   InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                   InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                   InterfaceEntryComponent.Code := FORMAT(cString);

    //                   Pos := STRPOS(TxtToAddInComponent,'<?xml version="1.0" encoding="UTF-8"?>');
    //                   if Pos <> 0 then
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                   InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent,'<>',' ');
    //                   InterfaceEntryComponent.INSERT;
    //                   c += 1;
    //                   cString := INCSTR(cString);
    //                 end;
    //             end;
    //         end;

    //         TxtToAddInComponent := ']]>';
    //         InterfaceEntryComponent.RESET;
    //         InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //         InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //         InterfaceEntryComponent.Code := FORMAT(cString);
    //         InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent,'<>',' ');
    //         InterfaceEntryComponent.INSERT;
    //         c += 1;
    //         cString := INCSTR(cString);

    //         filRead.CLOSE;

    //         if EXISTS(SaveToFileName) then
    //           if ERASE(SaveToFileName) then;

    //         lGenJournalLine.RESET;
    //         lGenJournalLine.SETRANGE("Journal Template Name",GenJournalLine."Journal Template Name");
    //         lGenJournalLine.SETRANGE("Journal Batch Name",GenJournalLine."Journal Batch Name");
    //         lGenJournalLine.DELETEALL;

    //         lGenJournalLine81.RESET;
    //         lGenJournalLine81.SETRANGE("Journal Template Name",GenJournalLine."Journal Template Name");
    //         lGenJournalLine81.SETRANGE("Journal Batch Name",GenJournalLine."Journal Batch Name");
    //         lGenJournalLine81.SETFILTER("Parent Line No.",'=%1',0);
    //         lGenJournalLine81.MODIFYALL("WS Posting Allowed FND",true);
    //         //HEI.28<<
    //     end;


    //BC UPGRADE KUMARR78 << Blocking CreateNonsepaContentBahamas440

    procedure CreateNonSepaContentBahamas440(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text;
    var
        TempBlob: Codeunit "Temp Blob";
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lTotalAmtOnJournal: Decimal;
        XMlns: Integer;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);
        // RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        // XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;
        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeaderBahamas440(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        lTotalAmtOnJournal := 0;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
        IF lGenJournalLine.FINDFIRST THEN
            REPEAT
                lTotalAmtOnJournal += lGenJournalLine.Amount;
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                    ExportTransactionInformationBahamas440(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationBahamas440(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationBahamas440(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

        FinishGroupHeaderBahamas440(lTotalAmtOnJournal);

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);
        XMLText := DelStr(XMLText, StrPos(XMLText, 'standalone=" "'), StrLen('standalone=" "'));

        c := 1;
        cString := 'C0001';
        While NOT InStr.EOS DO BEGIN
            if c <> 1 then
                InStr.READTEXT(XMLText);

            i := StrLen(XMLText);
            k := i div 80;
            k1 := i mod 80;
            k3 := 1;

            if k1 <> 0 then begin
                k3 := 1;
                for j := 1 to k + 1 do begin
                    txtOneLine := CopyStr(XMLText, k3, 80);
                    k3 += 80;

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;

            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN
                    txtOneLine := CopyStr(XMLText, k3, 80);

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);

        exit(XMLText);

    end;


    //BC UPGRADE KUMARR78 >> Blocking
    // procedure CreateNonSepaContentBahamas441(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     lNonSepaContent: Text;
    //     OutStr: OutStream;
    //     inStr: InStream;
    //     MyText: Text;
    //     XMLDOMManagement: Codeunit "6224";
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     BigText: BigText;
    //     XMLText: Text;
    //     filRead: File;
    //     intLen: Integer;
    //     txtOneLine: Text;
    //     txtFromFile: Text;
    //     TodayString: Text;
    //     FileName1: Text;
    //     InStream: InStream;
    //     i: Integer;
    //     j: Integer;
    //     k: Integer;
    //     k1: Integer;
    //     k3: Integer;
    //     TxtToAddInComponent: Text[80];
    //     InterfaceEntryComponent: Record "50003";
    //     c: Integer;
    //     cString: Text;
    //     NewPaymentGroup: Boolean;
    //     lGenJournalLine: Record "Gen. Journal Line BC FND";
    //     Pos: Integer;
    //     lGenJournalLine81: Record "81";
    //     lTotalAmtOnJournal: Decimal;
    // begin
    //     //HEI.28>>
    //     CompanyInfo.GET;

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     XMLRootElement.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //     GMessageId := MessageId;
    //     StartGroupHeaderBahamas441(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;
    //     lTotalAmtOnJournal := 0;

    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
    //     IF lGenJournalLine.FINDFIRST THEN
    //         REPEAT
    //             lTotalAmtOnJournal += lGenJournalLine.Amount;
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
    //                 ExportTransactionInformationBahamas441(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
    //                 InitConsolidatedPayment(lGenJournalLine);
    //             END ELSE
    //                 UpdateConsolidatedPayment(lGenJournalLine);

    //             IF NewPaymentGroup THEN
    //                 ExportPaymentInformationBahamas441(CstmrCdtTrfInitnNode, lGenJournalLine);
    //         UNTIL lGenJournalLine.NEXT = 0;

    //     IF NOT EmptyConsolidatedPayment THEN
    //         ExportTransactionInformationBahamas441(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

    //     //Footer
    //     FinishGroupHeaderBahamas441(lTotalAmtOnJournal);

    //     IF DATE2DMY(TODAY, 2) < 10 THEN
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
    //     ELSE
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

    //     FileName := SaveToFileNameClient;

    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName, FileName);
    //     FullFileName := FileName;

    //     filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);

    //     intLen := filRead.LEN;
    //     txtFromFile := '';

    //     InterfaceEntryComponent.RESET;
    //     c := 1;
    //     cString := 'C0001';

    //     filRead.CREATEINSTREAM(InStream);
    //     WHILE NOT InStream.EOS DO BEGIN
    //         InStream.READTEXT(txtFromFile);
    //         i := STRLEN(txtFromFile);

    //         k := i DIV 80;
    //         k1 := i MOD 80;

    //         IF k1 <> 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k + 1 DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;

    //         IF k1 = 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;
    //     END;

    //     TxtToAddInComponent := ']]>';
    //     InterfaceEntryComponent.RESET;
    //     InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //     InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //     InterfaceEntryComponent.Code := FORMAT(cString);
    //     InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //     InterfaceEntryComponent.INSERT;
    //     c += 1;
    //     cString := INCSTR(cString);

    //     filRead.CLOSE;

    //     IF EXISTS(SaveToFileName) THEN
    //         IF ERASE(SaveToFileName) THEN;

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.DELETEALL;

    //     lGenJournalLine81.RESET;
    //     lGenJournalLine81.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine81.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine81.SETFILTER("Parent Line No.", '=%1', 0);
    //     lGenJournalLine81.MODIFYALL("WS Posting Allowed FND", TRUE);
    //     //HEI.28<<
    // end;
    //BC UPGRADE KUMARR78 >> Blocking

    //BC UPGRADE KUMARR78 >> Rewriting CreateNonSepaContentBahamas441 Function.
    procedure CreateNonSepaContentBahamas441(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text;
    var
        TempBlob: Codeunit "Temp Blob";
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XMLNodeCurr: XmlNode;
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lTotalAmtOnJournal: Decimal;
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
        XMlns: Integer;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        //XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;
        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeaderBahamas441(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        lTotalAmtOnJournal := 0;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
        IF lGenJournalLine.FINDFIRST THEN
            REPEAT
                lTotalAmtOnJournal += lGenJournalLine.Amount;
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                    ExportTransactionInformationBahamas441(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationBahamas441(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationBahamas441(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

        FinishGroupHeaderBahamas441(lTotalAmtOnJournal);

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);
        XMLText := DelStr(XMLText, StrPos(XMLText, 'standalone=" "'), StrLen('standalone=" "'));

        c := 1;
        cString := 'C0001';
        While NOT InStr.EOS DO BEGIN
            if c <> 1 then
                InStr.READTEXT(XMLText);
            i := StrLen(XMLText);
            k := i div 80;
            k1 := i mod 80;
            k3 := 1;

            if k1 <> 0 then begin
                k3 := 1;
                for j := 1 to k + 1 do begin
                    txtOneLine := CopyStr(XMLText, k3, 80);
                    k3 += 80;

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';



                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;

            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN
                    txtOneLine := CopyStr(XMLText, k3, 80);

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);

        exit(XMLText);

    end;
    //BC UPGRADE KUMARR78 << Rewriting Function


    //BC UPGRADE KUMARR78 >> Blocking for Rewriting Function
    // procedure CreateNonSepaContentBahamas442(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     lNonSepaContent: Text;
    //     OutStr: OutStream;
    //     inStr: InStream;
    //     MyText: Text;
    //     XMLDOMManagement: Codeunit "6224";
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     BigText: BigText;
    //     XMLText: Text;
    //     filRead: File;
    //     intLen: Integer;
    //     txtOneLine: Text;
    //     txtFromFile: Text;
    //     TodayString: Text;
    //     FileName1: Text;
    //     InStream: InStream;
    //     i: Integer;
    //     j: Integer;
    //     k: Integer;
    //     k1: Integer;
    //     k3: Integer;
    //     TxtToAddInComponent: Text[80];
    //     InterfaceEntryComponent: Record "50003";
    //     c: Integer;
    //     cString: Text;
    //     NewPaymentGroup: Boolean;
    //     lGenJournalLine: Record "Gen. Journal Line BC FND";
    //     Pos: Integer;
    //     lGenJournalLine81: Record "81";
    //     lTotalAmtOnJournal: Decimal;
    // begin
    //     //HEI.28>>
    //     CompanyInfo.GET;

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     XMLRootElement.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //     GMessageId := MessageId;
    //     StartGroupHeaderBahamas442(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;
    //     lTotalAmtOnJournal := 0;

    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
    //     IF lGenJournalLine.FINDFIRST THEN
    //         REPEAT
    //             lTotalAmtOnJournal += lGenJournalLine.Amount;
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
    //                 ExportTransactionInformationBahamas442(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
    //                 InitConsolidatedPayment(lGenJournalLine);
    //             END ELSE
    //                 UpdateConsolidatedPayment(lGenJournalLine);

    //             IF NewPaymentGroup THEN
    //                 ExportPaymentInformationBahamas442(CstmrCdtTrfInitnNode, lGenJournalLine);
    //         UNTIL lGenJournalLine.NEXT = 0;

    //     IF NOT EmptyConsolidatedPayment THEN
    //         ExportTransactionInformationBahamas442(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

    //     //Footer
    //     FinishGroupHeaderBahamas442(lTotalAmtOnJournal);

    //     IF DATE2DMY(TODAY, 2) < 10 THEN
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
    //     ELSE
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

    //     FileName := SaveToFileNameClient;

    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName, FileName);
    //     FullFileName := FileName;

    //     filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);

    //     intLen := filRead.LEN;
    //     txtFromFile := '';

    //     InterfaceEntryComponent.RESET;
    //     c := 1;
    //     cString := 'C0001';

    //     filRead.CREATEINSTREAM(InStream);
    //     WHILE NOT InStream.EOS DO BEGIN
    //         InStream.READTEXT(txtFromFile);
    //         i := STRLEN(txtFromFile);

    //         k := i DIV 80;
    //         k1 := i MOD 80;

    //         IF k1 <> 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k + 1 DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;

    //         IF k1 = 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;
    //     END;

    //     TxtToAddInComponent := ']]>';
    //     InterfaceEntryComponent.RESET;
    //     InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //     InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //     InterfaceEntryComponent.Code := FORMAT(cString);
    //     InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //     InterfaceEntryComponent.INSERT;
    //     c += 1;
    //     cString := INCSTR(cString);

    //     filRead.CLOSE;

    //     IF EXISTS(SaveToFileName) THEN
    //         IF ERASE(SaveToFileName) THEN;

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.DELETEALL;

    //     lGenJournalLine81.RESET;
    //     lGenJournalLine81.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine81.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine81.SETFILTER("Parent Line No.", '=%1', 0);
    //     lGenJournalLine81.MODIFYALL("WS Posting Allowed FND", TRUE);
    //     //HEI.28<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking for Rewriting Function


    //BC UPGRADE KUMARR78 >> Rewriting CreateNonSepaContentBahamas442 Function
    procedure CreateNonSepaContentBahamas442(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text;
    var
        TempBlob: Codeunit "Temp Blob";
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XMLNodeCurr: XmlNode;
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lTotalAmtOnJournal: Decimal;
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
        XMlns: Integer;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);

        // RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        //XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;

        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeaderBahamas442(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        lTotalAmtOnJournal := 0;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
        IF lGenJournalLine.FINDFIRST THEN
            REPEAT
                lTotalAmtOnJournal += lGenJournalLine.Amount;
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                    ExportTransactionInformationBahamas442(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationBahamas442(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationBahamas442(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);


        FinishGroupHeaderBahamas442(lTotalAmtOnJournal);

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);
        XMLText := DelStr(XMLText, StrPos(XMLText, 'standalone=" "'), StrLen('standalone=" "'));

        c := 1;
        cString := 'C0001';
        While NOT InStr.EOS DO BEGIN
            if c <> 1 then
                InStr.READTEXT(XMLText);

            i := StrLen(XMLText);
            k := i div 80;
            k1 := i mod 80;
            k3 := 1;

            if k1 <> 0 then begin
                k3 := 1;
                for j := 1 to k + 1 do begin
                    txtOneLine := CopyStr(XMLText, k3, 80);
                    k3 += 80;

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;

            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN
                    txtOneLine := CopyStr(XMLText, k3, 80);

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';


                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);

        exit(XMLText);

    end;
    //BC UPGRADE KUMARR78 << Rewriting CreateNonSepaContentBahamas442 Function

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite Code.
    // procedure ExportTransactionInformationBahamas440(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    // var
    //     GLSetup: Record "98";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     AddressLine3: Text[110];
    //     AddressLine4: Text[60];
    //     ISOCurrCode: Text[3];
    //     IBANTransfer: Boolean;
    //     VendorBankAccount: Record "288";
    //     BeneficiaryIBAN: Code[50];
    //     CustomerBankAccount: Record "287";
    //     BeneficiaryBankAccountNo: Code[30];
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     CustBankAcc: Record "287";
    //     VendBankAcc: Record "288";
    //     lSWIFTCode: Code[20];
    //     lBeneficiaryBankAccount: Code[30];
    //     lCust: Record "18";
    //     lVend: Record "23";
    //     CountryIBANCountryRegion: Boolean;
    //     lNewAmountText: Text;
    //     lBankExportImportSetup: Record "1200";
    //     lPosition: Integer;
    //     lCurrency: Record "4";
    //     BICICIABPos: Integer;
    //     CI93Pos: Integer;
    //     lPrtLctnValue: Text[10];
    //     lVend2: Record "23";
    //     lMmbId: Text[20];
    //     lIsDomesticTransfer: Boolean;
    //     lIsIntermediaryBank: Boolean;
    //     lSWIFTCodeIntermediaryBank: Code[20];
    //     lIsEURPayment: Boolean;
    //     lPmtJnlLine: Record "81";
    //     lPurchInvHeader: Record "122";
    //     lTotalExtDocNo: Text;
    //     lVendInvNo: Text;
    //     lText50000: Label '/PMDH/';
    //     ChargeBearer: Text[4];
    // begin
    //     //HEI.28>>
    //     WITH PmtJnlLine DO BEGIN
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'EndToEndId', CutText(PmtJnlLine."Document No.", 16), '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);
    //         GeneralLedgerSetup.GET;

    //         IF "Currency Code" = '' THEN
    //             ISOCurrCode := GeneralLedgerSetup."LCY Code"
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
    //         END;

    //         AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         lCust.GET("Account No.");
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := CustBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := CustBankAcc.Code;
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         lVend.GET("Account No.");
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := VendBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := VendBankAcc.Code;
    //                     END;
    //             END
    //         ELSE BEGIN
    //             lSWIFTCode := '';
    //             lBeneficiaryBankAccount := '';
    //         END;

    //         lVend2.RESET;
    //         IF "Account Type" = "Account Type"::Vendor THEN
    //             IF lVend2.GET("Account No.") THEN;

    //         AddElement(XMLNodeCurr, 'ChqInstr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PrtLctn', '050', '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         //HEI.30>>
    //         AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         //HEI.30<<

    //         CASE "Account Type" OF
    //             "Account Type"::Vendor:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);

    //                     //HEI.30>>
    //                     //AddElement(XMLNodeCurr,'BIC',FORMAT(VendorBankAcc."SWIFT Code"),'',XMLNewChild);//HEI.36

    //                     AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     lMmbId := VendorBankAcc."Bank Branch No.";
    //                     //HEI.37>>
    //                     //AddElement(XMLNodeCurr,'MmbId',lMmbId,'',XMLNewChild);
    //                     lMmbId := COPYSTR(lMmbId, 6, 3) + COPYSTR(lMmbId, 1, 5);
    //                     AddElement(XMLNodeCurr, 'MmbId', lMmbId, '', XMLNewChild);
    //                     //HEI.37<<
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);

    //                     AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);

    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     //HEI.30<<

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetVendor("Account No.");
    //                     Vendor.Name := ReplaceTextCharacters(Vendor.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Vendor."Country/Region Code");

    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

    //                     Vendor.Address := ReplaceTextCharacters(Vendor.Address);
    //                     Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
    //                     AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');

    //                     //HEI.36>>
    //                     Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
    //                     Vendor.City := ReplaceTextCharacters(Vendor.City);
    //                     AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
    //                     //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(AddressLine1,1,70),'',XMLNewChild);
    //                     IF (STRLEN(DELCHR(AddressLine1, '<>')) <= 70) THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
    //                     IF (STRLEN(DELCHR(AddressLine1, '<>')) > 70) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 71, 70), '', XMLNewChild);
    //                     END;

    //                     IF (STRLEN(DELCHR(AddressLine2, '<>')) <> 0) THEN BEGIN
    //                         IF (STRLEN(DELCHR(AddressLine2, '<>')) <= 70) THEN
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
    //                         IF (STRLEN(DELCHR(AddressLine2, '<>')) > 70) THEN BEGIN
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 71, 70), '', XMLNewChild);
    //                         END;
    //                     END;
    //                     //HEI.36<<

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     AddElement(XMLNodeCurr, 'OrgId', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     AddElement(XMLNodeCurr, 'Id', FORMAT(Vendor."VAT Registration No."), '', XMLNewChild);

    //                     AddElement(XMLNodeCurr, 'SchmeNm', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     AddElement(XMLNodeCurr, 'Cd', 'TXID', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     //XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     //XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //             "Account Type"::Customer:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(CustomerBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCustomer("Account No.");
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Customer."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //         END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;


    //         AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := CustBankAcc.IBAN;
    //                         GetCountry(CustBankAcc."Country/Region Code");
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                     END;
    //             END
    //         ELSE BEGIN
    //             BeneficiaryBankAccountNo := '';
    //             BeneficiaryIBAN := '';
    //             Country."IBAN Country/Region" := FALSE;
    //         END;

    //         AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Purp', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Prtry', '01', '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         lTotalExtDocNo := '';
    //         lPmtJnlLine.RESET;
    //         lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
    //         lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
    //         lPmtJnlLine.SETRANGE("Parent Line No.", PmtJnlLine."Line No.");
    //         IF lPmtJnlLine.FINDSET(FALSE, FALSE) THEN
    //             REPEAT
    //                 IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
    //                     IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
    //                         //HEI.36>>
    //                         /*
    //                         IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
    //                           lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.",STRLEN(lPurchInvHeader."Vendor Invoice No.")-8,9)
    //                           ELSE
    //                         */
    //                         //HEI.36<<
    //                         lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
    //                         lTotalExtDocNo += lVendInvNo + ',';
    //                     END;
    //             UNTIL lPmtJnlLine.NEXT = 0;
    //         lTotalExtDocNo := ReplaceTextCharacters(lTotalExtDocNo);//HEI.36
    //         IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
    //             lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
    //             lTotalExtDocNo := lText50000 + lTotalExtDocNo;
    //             IF (STRLEN(lTotalExtDocNo) <= 35) THEN
    //                 AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
    //             IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
    //             END;
    //         END
    //         ELSE
    //             AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);

    //         XMLNodeCurr := RootNode;
    //     END;
    //     //HEI.28<<

    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite Code.

    //BC UPGRADE KUMARR78 >> Replacing ExportTransactionInformationBahamas440 Function Code.
    procedure ExportTransactionInformationBahamas440(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        GLSetup: Record "General Ledger Setup";
        AddressLine1: Text[110];
        AddressLine2: Text[60];
        AddressLine3: Text[110];
        AddressLine4: Text[60];
        ISOCurrCode: Text[3];
        IBANTransfer: Boolean;
        VendorBankAccount: Record "Vendor Bank Account";
        BeneficiaryIBAN: Code[50];
        CustomerBankAccount: Record "Customer Bank Account";
        BeneficiaryBankAccountNo: Code[30];
        AmtNode: XmlNode;
        CdtrAcctNode: XmlNode;
        CdtrNode: XmlNode;
        CdtTrfTxInfNode: XmlNode;
        IdNode: XmlNode;
        PmtIdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        RootNode: XmlNode;
        XMLNewChild: XmlNode;
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        lSWIFTCode: Code[20];
        lBeneficiaryBankAccount: Code[30];
        lCust: Record Customer;
        lVend: Record Vendor;
        CountryIBANCountryRegion: Boolean;
        lNewAmountText: Text;
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lPosition: Integer;
        lCurrency: Record Currency;
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPrtLctnValue: Text[10];
        lVend2: Record Vendor;
        lMmbId: Text[20];
        lIsDomesticTransfer: Boolean;
        lIsIntermediaryBank: Boolean;
        lSWIFTCodeIntermediaryBank: Code[20];
        lIsEURPayment: Boolean;
        lPmtJnlLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        lTotalExtDocNo: Text;
        lVendInvNo: Text;
        lText50000: Label '/PMDH/';
        ChargeBearer: Text[4];

        FinInstNode: xmlnode;
        CdtrAgtNode: xmlnode;
    begin
        //HEI.28>>
        GLSetup.GET;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;
        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNodeCurr);

        AddElement(XMLNodeCurr, 'PmtId', '', '', PmtIdNode);
        AddElement(PmtIdNode, 'EndToEndId', PmtJnlLine."Document No.", '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Amt', '', '', AmtNode);


        XMLNodeCurr := XMLNewChild;

        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);
        GeneralLedgerSetup.GET;

        IF PmtJnlLine."Currency Code" = '' THEN
            ISOCurrCode := GeneralLedgerSetup."LCY Code"
        ELSE BEGIN
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
        END;

        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;

        lVend2.RESET;
        IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
            IF lVend2.GET(PmtJnlLine."Account No.") THEN;

        AddElement(XMLNodeCurr, 'ChqInstr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'PrtLctn', '050', '', XMLNewChild);
        //HEI.30>>
        AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        //HEI.30<<
        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    //HEI.30>>
                    //AddElement(XMLNodeCurr,'BIC',FORMAT(VendorBankAcc."SWIFT Code"),'',XMLNewChild);//HEI.36
                    AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    lMmbId := VendorBankAcc."Bank Branch No.";
                    //HEI.37>>
                    //AddElement(XMLNodeCurr,'MmbId',lMmbId,'',XMLNewChild);
                    lMmbId := COPYSTR(lMmbId, 6, 3) + COPYSTR(lMmbId, 1, 5);
                    AddElement(XMLNodeCurr, 'MmbId', lMmbId, '', XMLNewChild);

                    VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);

                    AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetVendor(PmtJnlLine."Account No.");
                    Vendor.Name := ReplaceTextCharacters(Vendor.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Vendor."Country/Region Code");

                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

                    Vendor.Address := ReplaceTextCharacters(Vendor.Address);
                    Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
                    AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');
                    //HEI.36>>
                    Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
                    Vendor.City := ReplaceTextCharacters(Vendor.City);
                    AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
                    //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(AddressLine1,1,70),'',XMLNewChild);
                    IF (STRLEN(DELCHR(AddressLine1, '<>')) <= 70) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
                    IF (STRLEN(DELCHR(AddressLine1, '<>')) > 70) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 71, 70), '', XMLNewChild);
                    END;

                    IF (STRLEN(DELCHR(AddressLine2, '<>')) <> 0) THEN BEGIN
                        IF (STRLEN(DELCHR(AddressLine2, '<>')) <= 70) THEN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
                        IF (STRLEN(DELCHR(AddressLine2, '<>')) > 70) THEN BEGIN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 71, 70), '', XMLNewChild);
                        END;
                    END;
                    AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    AddElement(XMLNodeCurr, 'OrgId', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    AddElement(XMLNodeCurr, 'Id', FORMAT(Vendor."VAT Registration No."), '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'SchmeNm', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    AddElement(XMLNodeCurr, 'Cd', 'TXID', '', XMLNewChild);

                END;
            PmtJnlLine."Account Type"::Customer:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(CustomerBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCustomer(PmtJnlLine."Account No.");
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Customer."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                END;
        END;
        AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                        BeneficiaryIBAN := CustBankAcc.IBAN;
                        GetCountry(CustBankAcc."Country/Region Code");
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");
                    END;
            END
        ELSE BEGIN
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := FALSE;
        END;

        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Purp', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Prtry', '01', '', XMLNewChild);
        AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        lTotalExtDocNo := '';
        lPmtJnlLine.RESET;
        lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
        lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
        lPmtJnlLine.SETRANGE("Parent Line No. FND", PmtJnlLine."Line No.");
        IF lPmtJnlLine.FINDSET(FALSE) THEN
            REPEAT
                IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
                    IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
                        //HEI.36>>
                        /*
                        IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
                          lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.",STRLEN(lPurchInvHeader."Vendor Invoice No.")-8,9)
                          ELSE
                        */
                        //HEI.36<<
                        lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
                        lTotalExtDocNo += lVendInvNo + ',';
                    END;
            UNTIL lPmtJnlLine.NEXT = 0;
        lTotalExtDocNo := ReplaceTextCharacters(lTotalExtDocNo);//HEI.36
        IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
            lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
            lTotalExtDocNo := lText50000 + lTotalExtDocNo;
            IF (STRLEN(lTotalExtDocNo) <= 35) THEN
                AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
            IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
            END;
        END
        ELSE
            AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);

        XMLNodeCurr := RootNode;
        //HEI.28<<

    end;
    //BC UPGRADE KUMARR78 << Replacing ExportTransactionInformationBahamas440  Function Code.


    //BC UPGRADE KUMARR78 >> Blocking ExportTransactionInformationBahamas441 Function Code.
    // procedure ExportTransactionInformationBahamas441(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    // var
    //     GLSetup: Record "98";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     AddressLine3: Text[110];
    //     AddressLine4: Text[60];
    //     ISOCurrCode: Text[3];
    //     IBANTransfer: Boolean;
    //     VendorBankAccount: Record "288";
    //     BeneficiaryIBAN: Code[50];
    //     CustomerBankAccount: Record "287";
    //     BeneficiaryBankAccountNo: Code[30];
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     CustBankAcc: Record "287";
    //     VendBankAcc: Record "288";
    //     lSWIFTCode: Code[20];
    //     lBeneficiaryBankAccount: Code[30];
    //     lCust: Record "18";
    //     lVend: Record "23";
    //     CountryIBANCountryRegion: Boolean;
    //     lNewAmountText: Text;
    //     lBankExportImportSetup: Record "1200";
    //     lPosition: Integer;
    //     lCurrency: Record "4";
    //     BICICIABPos: Integer;
    //     CI93Pos: Integer;
    //     lPrtLctnValue: Text[10];
    //     lVend2: Record "23";
    //     lMmbId: Text[20];
    //     lIsDomesticTransfer: Boolean;
    //     lIsIntermediaryBank: Boolean;
    //     lSWIFTCodeIntermediaryBank: Code[20];
    //     lIsEURPayment: Boolean;
    //     lPmtJnlLine: Record "81";
    //     lPurchInvHeader: Record "122";
    //     lTotalExtDocNo: Text;
    //     lVendInvNo: Text;
    //     lText50000: Label '/PMDH/';
    //     ChargeBearer: Text[4];
    // begin
    //     //HEI.28>>
    //     WITH PmtJnlLine DO BEGIN
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'EndToEndId', CutText(PmtJnlLine."Document No.", 16), '', XMLNewChild);

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;


    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);
    //         GeneralLedgerSetup.GET;

    //         IF "Currency Code" = '' THEN
    //             ISOCurrCode := GeneralLedgerSetup."LCY Code"
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
    //         END;

    //         AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         lCust.GET("Account No.");
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := CustBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := CustBankAcc.Code;
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         lVend.GET("Account No.");
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := VendBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := VendBankAcc.Code;
    //                     END;
    //             END
    //         ELSE BEGIN
    //             lSWIFTCode := '';
    //             lBeneficiaryBankAccount := '';
    //         END;

    //         lVend2.RESET;
    //         IF "Account Type" = "Account Type"::Vendor THEN
    //             IF lVend2.GET("Account No.") THEN;

    //         CASE PmtJnlLine."Code Expenses" OF
    //             PmtJnlLine."Code Expenses"::" ":
    //                 ChargeBearer := 'DEBT';
    //             PmtJnlLine."Code Expenses"::SHA:
    //                 ChargeBearer := 'SHAR';
    //             PmtJnlLine."Code Expenses"::BEN:
    //                 ChargeBearer := 'CRED';
    //             PmtJnlLine."Code Expenses"::OUR:
    //                 ChargeBearer := 'DEBT';
    //         END;

    //         //AddElement(XMLNodeCurr,'ChrgBr',ChargeBearer,'',XMLNewChild);
    //         AddElement(XMLNodeCurr, 'ChqInstr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'PrtLctn', '050', '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         lIsIntermediaryBank := FALSE;
    //         lSWIFTCodeIntermediaryBank := '';

    //         IF VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND" <> '' THEN BEGIN
    //             lIsIntermediaryBank := TRUE;
    //             lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND";
    //         END;

    //         AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         CASE "Account Type" OF
    //             "Account Type"::Vendor:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);

    //                     //AddElement(XMLNodeCurr,'BIC',FORMAT(VendorBankAcc."SWIFT Code"),'',XMLNewChild); //HEI.36

    //                     AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     lMmbId := VendorBankAcc."Bank Branch No.";
    //                     //HEI.36>>
    //                     //AddElement(XMLNodeCurr,'MmbId',lMmbId,'',XMLNewChild);
    //                     IF ((lMmbId <> '') AND (STRLEN(lMmbId) >= 3)) THEN
    //                         //AddElement(XMLNodeCurr,'MmbId',FORMAT(COPYSTR(lMmbId,1,3)),'',XMLNewChild)//HEI.37
    //                         AddElement(XMLNodeCurr, 'MmbId', FORMAT(COPYSTR(lMmbId, 6, 3)), '', XMLNewChild)//HEI.37
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Id', FORMAT(lMmbId), '', XMLNewChild);
    //                     //HEI.36<<
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);

    //                     AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);

    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     //HEI.36>>
    //                     AddElement(XMLNodeCurr, 'BrnchId', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;
    //                     //AddElement(XMLNodeCurr,'Id',FORMAT(COPYSTR(VendorBankAcc."Bank Branch No.",4,5)),'',XMLNewChild);//HEI.37
    //                     AddElement(XMLNodeCurr, 'Id', FORMAT(COPYSTR(VendorBankAcc."Bank Branch No.", 1, 5)), '', XMLNewChild);//HEI.37
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     //HEI.36<<
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     //XMLNodeCurr := XMLNodeCurr.ParentNode; //HEI.30

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetVendor("Account No.");
    //                     Vendor.Name := ReplaceTextCharacters(Vendor.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Vendor."Country/Region Code");

    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

    //                     Vendor.Address := ReplaceTextCharacters(Vendor.Address);
    //                     Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
    //                     AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');

    //                     //HEI.36>>
    //                     Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
    //                     Vendor.City := ReplaceTextCharacters(Vendor.City);
    //                     AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
    //                     //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(AddressLine1,1,70),'',XMLNewChild);
    //                     IF (STRLEN(DELCHR(AddressLine1, '<>')) <= 70) THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
    //                     IF (STRLEN(DELCHR(AddressLine1, '<>')) > 70) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 71, 70), '', XMLNewChild);
    //                     END;

    //                     IF (STRLEN(DELCHR(AddressLine2, '<>')) <> 0) THEN BEGIN
    //                         IF (STRLEN(DELCHR(AddressLine2, '<>')) <= 70) THEN
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
    //                         IF (STRLEN(DELCHR(AddressLine2, '<>')) > 70) THEN BEGIN
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 71, 70), '', XMLNewChild);
    //                         END;
    //                     END;
    //                     //HEI.36<<

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                 END;
    //             "Account Type"::Customer:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(CustomerBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCustomer("Account No.");
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Customer."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //         END;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'OrgId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         //HEI.34>>
    //         //AddElement(XMLNodeCurr,'Id',FORMAT(VendorBankAcc."Bank Account No."),'',XMLNewChild);
    //         //HEI.36>>
    //         /*
    //         IF ((VendorBankAcc."Bank Branch No." <> '') AND (STRLEN(VendorBankAcc."Bank Branch No.") >= 3)) THEN
    //           AddElement(XMLNodeCurr,'Id',FORMAT(COPYSTR(VendorBankAcc."Bank Branch No.",1,3)),'',XMLNewChild)
    //         ELSE
    //           AddElement(XMLNodeCurr,'Id',FORMAT(VendorBankAcc."Bank Branch No."),'',XMLNewChild);
    //         */
    //         AddElement(XMLNodeCurr, 'Id', FORMAT(VendorBankAcc."Bank Account No."), '', XMLNewChild);
    //         //HEI.36<<
    //         //HEI.34<<
    //         AddElement(XMLNodeCurr, 'SchmeNm', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Cd', 'TXID', '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := CustBankAcc.IBAN;
    //                         GetCountry(CustBankAcc."Country/Region Code");
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                     END;
    //             END
    //         ELSE BEGIN
    //             BeneficiaryBankAccountNo := '';
    //             BeneficiaryIBAN := '';
    //             Country."IBAN Country/Region FND" := FALSE;
    //         END;

    //         AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Purp', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Prtry', '01', '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         lTotalExtDocNo := '';
    //         lPmtJnlLine.RESET;
    //         lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
    //         lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
    //         lPmtJnlLine.SETRANGE("Parent Line No.", PmtJnlLine."Line No.");
    //         IF lPmtJnlLine.FINDSET(FALSE, FALSE) THEN
    //             REPEAT
    //                 IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
    //                     IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
    //                         //HEI.36>>
    //                         /*
    //                         IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
    //                           lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.",STRLEN(lPurchInvHeader."Vendor Invoice No.")-8,9)
    //                           ELSE
    //                         */
    //                         //HEI.36<<
    //                         lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
    //                         lTotalExtDocNo += lVendInvNo + ',';
    //                     END;
    //             UNTIL lPmtJnlLine.NEXT = 0;
    //         lTotalExtDocNo := ReplaceTextCharacters(lTotalExtDocNo); //HEI.36
    //         IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
    //             lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
    //             lTotalExtDocNo := lText50000 + lTotalExtDocNo;
    //             IF (STRLEN(lTotalExtDocNo) <= 35) THEN
    //                 AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
    //             IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
    //             END;
    //         END
    //         ELSE
    //             AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);

    //         XMLNodeCurr := RootNode;
    //     END;
    //     //HEI.28<<

    // end;
    //BC UPGRADE KUMARR78 << Blocking ExportTransactionInformationBahamas441 Function Code.

    //BC UPGRADE KUMARR78 >> Rewriting Function ExportTransactionInformationBahamas441

    procedure ExportTransactionInformationBahamas441(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        GLSetup: Record "General Ledger Setup";
        AddressLine1: Text[110];
        AddressLine2: Text[60];
        AddressLine3: Text[110];
        AddressLine4: Text[60];
        ISOCurrCode: Text[3];
        IBANTransfer: Boolean;
        VendorBankAccount: Record "Vendor Bank Account";
        BeneficiaryIBAN: Code[50];
        CustomerBankAccount: Record "Customer Bank Account";
        BeneficiaryBankAccountNo: Code[30];
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        lSWIFTCode: Code[20];
        lBeneficiaryBankAccount: Code[30];
        lCust: Record Customer;
        lVend: Record Vendor;
        CountryIBANCountryRegion: Boolean;
        lNewAmountText: Text;
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lPosition: Integer;
        lCurrency: Record Currency;
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPrtLctnValue: Text[10];
        lVend2: Record Vendor;
        lMmbId: Text[20];
        lIsDomesticTransfer: Boolean;
        lIsIntermediaryBank: Boolean;
        lSWIFTCodeIntermediaryBank: Code[20];
        lIsEURPayment: Boolean;
        lPmtJnlLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        lTotalExtDocNo: Text;
        lVendInvNo: Text;
        lText50000: Label '/PMDH/';
        ChargeBearer: Text[4];
        AmtNode: XmlNode;
        CdtrAcctNode: XmlNode;
        CdtrNode: XmlNode;
        CdtTrfTxInfNode: XmlNode;
        IdNode: XmlNode;
        PmtIdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        RootNode: XmlNode;
        XMLNewChild: XmlNode;
    begin
        //HEI.28>>
        GLSetup.GET;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;

        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'PmtId', '', '', PmtIdNode);
        AddElement(PmtIdNode, 'EndToEndId', PmtJnlLine."Document No.", '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Amt', '', '', AmtNode);
        XMLNodeCurr := XMLNewChild;

        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;


        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);
        GeneralLedgerSetup.GET;

        IF PmtJnlLine."Currency Code" = '' THEN
            ISOCurrCode := GeneralLedgerSetup."LCY Code"
        ELSE BEGIN
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
        END;

        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);
        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;

        lVend2.RESET;
        IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
            IF lVend2.GET(PmtJnlLine."Account No.") THEN;

        CASE PmtJnlLine."Code Expenses" OF
            PmtJnlLine."Code Expenses"::" ":
                ChargeBearer := 'DEBT';
            PmtJnlLine."Code Expenses"::SHA:
                ChargeBearer := 'SHAR';
            PmtJnlLine."Code Expenses"::BEN:
                ChargeBearer := 'CRED';
            PmtJnlLine."Code Expenses"::OUR:
                ChargeBearer := 'DEBT';
        END;
        //AddElement(XMLNodeCurr,'ChrgBr',ChargeBearer,'',XMLNewChild);
        AddElement(XMLNodeCurr, 'ChqInstr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'PrtLctn', '050', '', XMLNewChild);

        lIsIntermediaryBank := FALSE;
        lSWIFTCodeIntermediaryBank := '';

        IF VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND" <> '' THEN BEGIN
            lIsIntermediaryBank := TRUE;
            lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND";
        END;

        AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    //AddElement(XMLNodeCurr,'BIC',FORMAT(VendorBankAcc."SWIFT Code"),'',XMLNewChild); //HEI.36
                    AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    lMmbId := VendorBankAcc."Bank Branch No.";
                    //HEI.36>>
                    //AddElement(XMLNodeCurr,'MmbId',lMmbId,'',XMLNewChild);
                    IF ((lMmbId <> '') AND (STRLEN(lMmbId) >= 3)) THEN
                        //AddElement(XMLNodeCurr,'MmbId',FORMAT(COPYSTR(lMmbId,1,3)),'',XMLNewChild)//HEI.37
                        AddElement(XMLNodeCurr, 'MmbId', FORMAT(COPYSTR(lMmbId, 6, 3)), '', XMLNewChild)//HEI.37
                    ELSE
                        AddElement(XMLNodeCurr, 'Id', FORMAT(lMmbId), '', XMLNewChild);

                    VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);

                    AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'BrnchId', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;
                    //AddElement(XMLNodeCurr,'Id',FORMAT(COPYSTR(VendorBankAcc."Bank Branch No.",4,5)),'',XMLNewChild);//HEI.37
                    AddElement(XMLNodeCurr, 'Id', FORMAT(COPYSTR(VendorBankAcc."Bank Branch No.", 1, 5)), '', XMLNewChild);//HEI.37
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetVendor(PmtJnlLine."Account No.");
                    Vendor.Name := ReplaceTextCharacters(Vendor.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Vendor."Country/Region Code");

                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

                    Vendor.Address := ReplaceTextCharacters(Vendor.Address);
                    Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
                    AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');
                    //HEI.36>>
                    Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
                    Vendor.City := ReplaceTextCharacters(Vendor.City);
                    AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
                    //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(AddressLine1,1,70),'',XMLNewChild);
                    IF (STRLEN(DELCHR(AddressLine1, '<>')) <= 70) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
                    IF (STRLEN(DELCHR(AddressLine1, '<>')) > 70) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 71, 70), '', XMLNewChild);
                    END;

                    IF (STRLEN(DELCHR(AddressLine2, '<>')) <> 0) THEN BEGIN
                        IF (STRLEN(DELCHR(AddressLine2, '<>')) <= 70) THEN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
                        IF (STRLEN(DELCHR(AddressLine2, '<>')) > 70) THEN BEGIN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 71, 70), '', XMLNewChild);
                        END;
                    END;
                END;
            PmtJnlLine."Account Type"::Customer:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(CustomerBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCustomer(PmtJnlLine."Account No.");
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Customer."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                END;
        END;

        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'OrgId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Id', FORMAT(VendorBankAcc."Bank Account No."), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'SchmeNm', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Cd', 'TXID', '', XMLNewChild);

        AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                        BeneficiaryIBAN := CustBankAcc.IBAN;
                        GetCountry(CustBankAcc."Country/Region Code");
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");
                    END;
            END
        ELSE BEGIN
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := FALSE;
        END;

        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);

        AddElement(XMLNodeCurr, 'Purp', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Prtry', '01', '', XMLNewChild);

        AddElement(XMLNodeCurr, 'RmtInf', '', '', RmtInfNode);
        XMLNodeCurr := XMLNewChild;

        lTotalExtDocNo := '';
        lPmtJnlLine.RESET;
        lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
        lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
        lPmtJnlLine.SETRANGE("Parent Line No. FND", PmtJnlLine."Line No.");
        IF lPmtJnlLine.FINDSET(FALSE) THEN
            REPEAT
                IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
                    IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
                        //HEI.36>>
                        /*
                        IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
                          lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.",STRLEN(lPurchInvHeader."Vendor Invoice No.")-8,9)
                          ELSE
                        */
                        //HEI.36<<
                        lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
                        lTotalExtDocNo += lVendInvNo + ',';
                    END;
            UNTIL lPmtJnlLine.NEXT = 0;
        lTotalExtDocNo := ReplaceTextCharacters(lTotalExtDocNo);
        //HEI.36
        IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
            lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
            lTotalExtDocNo := lText50000 + lTotalExtDocNo;
            IF (STRLEN(lTotalExtDocNo) <= 35) THEN
                AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
            IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
            END;
        END
        ELSE
            AddElement(RmtInfNode, 'Ustrd', CopyStr(PaymentMessage, 1, 70), '', XMLNewChild);

        XMLNodeCurr := RootNode;
        //HEI.28<<

    end;
    //BC UPGRADE KUMARR78 << Rewriting Function ExportTransactionInformationBahamas441

    //BC UPGRADE KUMARR78 >> Blocking Function ExportTransactionInformationBahamas442
    // procedure ExportTransactionInformationBahamas442(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    // var
    //     GLSetup: Record "98";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     AddressLine3: Text[110];
    //     AddressLine4: Text[60];
    //     ISOCurrCode: Text[3];
    //     IBANTransfer: Boolean;
    //     VendorBankAccount: Record "288";
    //     BeneficiaryIBAN: Code[50];
    //     CustomerBankAccount: Record "287";
    //     BeneficiaryBankAccountNo: Code[30];
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     CustBankAcc: Record "287";
    //     VendBankAcc: Record "288";
    //     lSWIFTCode: Code[20];
    //     lBeneficiaryBankAccount: Code[30];
    //     lCust: Record "18";
    //     lVend: Record "23";
    //     CountryIBANCountryRegion: Boolean;
    //     lNewAmountText: Text;
    //     lBankExportImportSetup: Record "1200";
    //     lPosition: Integer;
    //     lCurrency: Record "4";
    //     BICICIABPos: Integer;
    //     CI93Pos: Integer;
    //     lPrtLctnValue: Text[10];
    //     lVend2: Record "23";
    //     lMmbId: Text[20];
    //     lIsDomesticTransfer: Boolean;
    //     lIsIntermediaryBank: Boolean;
    //     lSWIFTCodeIntermediaryBank: Code[20];
    //     lIsEURPayment: Boolean;
    //     lPmtJnlLine: Record "81";
    //     lPurchInvHeader: Record "122";
    //     lTotalExtDocNo: Text;
    //     lVendInvNo: Text;
    //     lText50000: Label '/PMDH/';
    //     ChargeBearer: Text[4];
    // begin
    //     //HEI.28>>
    //     WITH PmtJnlLine DO BEGIN
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'EndToEndId', CutText(PmtJnlLine."Document No.", 16), '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;


    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         IF GeneralLedgerSetup."Enable WHT" THEN
    //             IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                 lBankExportImportSetup.RESET;
    //                 lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                 lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                 lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
    //                 IF lBankExportImportSetup.FINDFIRST THEN
    //                     IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);
    //         GeneralLedgerSetup.GET;

    //         IF "Currency Code" = '' THEN
    //             ISOCurrCode := GeneralLedgerSetup."LCY Code"
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
    //         END;

    //         AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         lCust.GET("Account No.");
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := CustBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := CustBankAcc.Code;
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         lVend.GET("Account No.");
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         lSWIFTCode := VendBankAcc."SWIFT Code";
    //                         lBeneficiaryBankAccount := VendBankAcc.Code;
    //                     END;
    //             END
    //         ELSE BEGIN
    //             lSWIFTCode := '';
    //             lBeneficiaryBankAccount := '';
    //         END;

    //         lVend2.RESET;
    //         IF "Account Type" = "Account Type"::Vendor THEN
    //             IF lVend2.GET("Account No.") THEN;

    //         CASE PmtJnlLine."Code Expenses" OF
    //             PmtJnlLine."Code Expenses"::" ":
    //                 ChargeBearer := 'DEBT';
    //             PmtJnlLine."Code Expenses"::SHA:
    //                 ChargeBearer := 'SHAR';
    //             PmtJnlLine."Code Expenses"::BEN:
    //                 ChargeBearer := 'CRED';
    //             PmtJnlLine."Code Expenses"::OUR:
    //                 ChargeBearer := 'DEBT';
    //         END;

    //         AddElement(XMLNodeCurr, 'ChrgBr', 'DEBT', '', XMLNewChild);

    //         AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         CASE "Account Type" OF
    //             "Account Type"::Vendor:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);

    //                     AddElement(XMLNodeCurr, 'BIC', FORMAT(VendorBankAcc."SWIFT Code"), '', XMLNewChild);

    //                     VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);

    //                     AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);

    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Vendor."Country/Region Code");

    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetVendor("Account No.");
    //                     Vendor.Name := ReplaceTextCharacters(Vendor.Name);
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Vendor."Country/Region Code");

    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                     ELSE
    //                         AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

    //                     Vendor.Address := ReplaceTextCharacters(Vendor.Address);
    //                     Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
    //                     AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');

    //                     //HEI.36>>
    //                     Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
    //                     Vendor.City := ReplaceTextCharacters(Vendor.City);
    //                     AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
    //                     //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(AddressLine1,1,70),'',XMLNewChild);
    //                     IF (STRLEN(DELCHR(AddressLine1, '<>')) <= 70) THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
    //                     IF (STRLEN(DELCHR(AddressLine1, '<>')) > 70) THEN BEGIN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 71, 70), '', XMLNewChild);
    //                     END;

    //                     IF (STRLEN(DELCHR(AddressLine2, '<>')) <> 0) THEN BEGIN
    //                         IF (STRLEN(DELCHR(AddressLine2, '<>')) <= 70) THEN
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
    //                         IF (STRLEN(DELCHR(AddressLine2, '<>')) > 70) THEN BEGIN
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 71, 70), '', XMLNewChild);
    //                         END;
    //                     END;
    //                     //HEI.36<<


    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //             "Account Type"::Customer:
    //                 BEGIN
    //                     GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                     AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(CustomerBankAcc."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                     AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCustomer("Account No.");
    //                     AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                     XMLNodeCurr := XMLNewChild;

    //                     GetCountry(Customer."Country/Region Code");
    //                     IF Country."ISO Country/Region Code" <> '' THEN
    //                         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //                     AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
    //                     IF DELCHR(AddressLine1) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

    //                     AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
    //                     IF DELCHR(AddressLine2) <> '' THEN
    //                         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                 END;
    //         END;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF ("Customer/Vendor Bank" <> '') THEN
    //             CASE "Account Type" OF
    //                 "Account Type"::Customer:
    //                     BEGIN
    //                         CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := CustBankAcc.IBAN;
    //                         GetCountry(CustBankAcc."Country/Region Code");
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                     END;
    //             END
    //         ELSE BEGIN
    //             BeneficiaryBankAccountNo := '';
    //             BeneficiaryIBAN := '';
    //             Country."IBAN Country/Region" := FALSE;
    //         END;

    //         AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         lTotalExtDocNo := '';
    //         lPmtJnlLine.RESET;
    //         lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
    //         lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
    //         lPmtJnlLine.SETRANGE("Parent Line No.", PmtJnlLine."Line No.");
    //         IF lPmtJnlLine.FINDSET(FALSE, FALSE) THEN
    //             REPEAT
    //                 IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
    //                     IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
    //                         //HEI.36>>
    //                         /*
    //                         IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
    //                           lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.",STRLEN(lPurchInvHeader."Vendor Invoice No.")-8,9)
    //                           ELSE
    //                         */
    //                         //HEI.36<<
    //                         lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
    //                         lTotalExtDocNo += lVendInvNo + ',';
    //                     END;
    //             UNTIL lPmtJnlLine.NEXT = 0;
    //         lTotalExtDocNo := ReplaceTextCharacters(lTotalExtDocNo);//HEI.36
    //         IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
    //             lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
    //             lTotalExtDocNo := lText50000 + lTotalExtDocNo;
    //             IF (STRLEN(lTotalExtDocNo) <= 35) THEN
    //                 AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
    //             IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //             END;
    //             IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
    //             END;
    //         END
    //         ELSE
    //             AddElement(XMLNodeCurr, 'Ustrd', PaymentMessage, '', XMLNewChild);

    //         XMLNodeCurr := RootNode;
    //     END;
    //     //HEI.28<<

    // end;
    //BC UPGRADE KUMARR78 << Blocking Function ExportTransactionInformationBahamas442
    //BC UPGRADE KUMARR78 >> Rewriting Function 

    procedure ExportTransactionInformationBahamas442(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        GLSetup: Record "General Ledger Setup";
        AddressLine1: Text[110];
        AddressLine2: Text[60];
        AddressLine3: Text[110];
        AddressLine4: Text[60];
        ISOCurrCode: Text[3];
        IBANTransfer: Boolean;
        VendorBankAccount: Record "Vendor Bank Account";
        BeneficiaryIBAN: Code[50];
        CustomerBankAccount: Record "Customer Bank Account";
        BeneficiaryBankAccountNo: Code[30];
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        lSWIFTCode: Code[20];
        lBeneficiaryBankAccount: Code[30];
        lCust: Record Customer;
        lVend: Record Vendor;
        CountryIBANCountryRegion: Boolean;
        lNewAmountText: Text;
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lPosition: Integer;
        lCurrency: Record Currency;
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPrtLctnValue: Text[10];
        lVend2: Record Vendor;
        lMmbId: Text[20];
        lIsDomesticTransfer: Boolean;
        lIsIntermediaryBank: Boolean;
        lSWIFTCodeIntermediaryBank: Code[20];
        lIsEURPayment: Boolean;
        lPmtJnlLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        lTotalExtDocNo: Text;
        lVendInvNo: Text;
        lText50000: Label '/PMDH/';
        ChargeBearer: Text[4];
        AmtNode: XmlNode;
        CdtrAcctNode: XmlNode;
        CdtrNode: XmlNode;
        CdtTrfTxInfNode: XmlNode;
        IdNode: XmlNode;
        PmtIdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        RootNode: XmlNode;
        XMLNewChild: XmlNode;
    begin
        //HEI.28>>
        GLSetup.GET;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;

        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNodeCurr);
        AddElement(PmtIdNode, 'EndToEndId', PmtJnlLine."Document No.", '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Amt', '', '', XMLNodeCurr);
        XMLNodeCurr := XMLNewChild;
        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;


        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt. 2");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);
        GeneralLedgerSetup.GET;

        IF PmtJnlLine."Currency Code" = '' THEN
            ISOCurrCode := GeneralLedgerSetup."LCY Code"
        ELSE BEGIN
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
        END;

        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;

        lVend2.RESET;
        IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
            IF lVend2.GET(PmtJnlLine."Account No.") THEN;

        CASE PmtJnlLine."Code Expenses" OF
            PmtJnlLine."Code Expenses"::" ":
                ChargeBearer := 'DEBT';
            PmtJnlLine."Code Expenses"::SHA:
                ChargeBearer := 'SHAR';
            PmtJnlLine."Code Expenses"::BEN:
                ChargeBearer := 'CRED';
            PmtJnlLine."Code Expenses"::OUR:
                ChargeBearer := 'DEBT';
        END;

        AddElement(XMLNodeCurr, 'ChrgBr', 'DEBT', '', XMLNewChild);

        AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);

                    AddElement(XMLNodeCurr, 'BIC', FORMAT(VendorBankAcc."SWIFT Code"), '', XMLNewChild);

                    VendorBankAcc.Name := ReplaceTextCharacters(VendorBankAcc.Name);

                    AddElement(XMLNodeCurr, 'Nm', VendorBankAcc.Name, '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Vendor."Country/Region Code");

                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetVendor(PmtJnlLine."Account No.");
                    Vendor.Name := ReplaceTextCharacters(Vendor.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Vendor."Country/Region Code");

                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

                    Vendor.Address := ReplaceTextCharacters(Vendor.Address);
                    Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
                    AddressLine1 := DELCHR(Vendor.Address, '<>') + ' ' + DELCHR(Vendor."Address 2", '<>');
                    //HEI.36>>
                    Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
                    Vendor.City := ReplaceTextCharacters(Vendor.City);
                    AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');
                    //AddElement(XMLNodeCurr,'AdrLine',COPYSTR(AddressLine1,1,70),'',XMLNewChild);
                    IF (STRLEN(DELCHR(AddressLine1, '<>')) <= 70) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
                    IF (STRLEN(DELCHR(AddressLine1, '<>')) > 70) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 1, 70), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine1, '<>'), 71, 70), '', XMLNewChild);
                    END;

                    IF (STRLEN(DELCHR(AddressLine2, '<>')) <> 0) THEN BEGIN
                        IF (STRLEN(DELCHR(AddressLine2, '<>')) <= 70) THEN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
                        IF (STRLEN(DELCHR(AddressLine2, '<>')) > 70) THEN BEGIN
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 1, 70), '', XMLNewChild);
                            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(DELCHR(AddressLine2, '<>'), 71, 70), '', XMLNewChild);
                        END;
                    END;
                END;
            PmtJnlLine."Account Type"::Customer:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'Nm', CustomerBankAcc.Name, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(CustomerBankAcc."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(CustomerBankAcc.Address, '<>') + ' ' + DELCHR(CustomerBankAcc."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(CustomerBankAcc."Post Code", '<>') + ' ' + DELCHR(CustomerBankAcc.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCustomer(PmtJnlLine."Account No.");
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Customer.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Customer."Country/Region Code");
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DELCHR(Customer.Address, '<>') + ' ' + DELCHR(Customer."Address 2", '<>');
                    IF DELCHR(AddressLine1) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DELCHR(Customer."Post Code", '<>') + ' ' + DELCHR(Customer.City, '<>');
                    IF DELCHR(AddressLine2) <> '' THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

                END;
        END;

        AddElement(XMLNodeCurr, 'CdtrAcct', '', '', CdtrAcctNode);
        AddElement(CdtrAcctNode, 'Id', '', '', IdNode);

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                        BeneficiaryIBAN := CustBankAcc.IBAN;
                        GetCountry(CustBankAcc."Country/Region Code");
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");
                    END;
            END
        ELSE BEGIN
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := FALSE;
        END;

        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNewChild, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'RmtInf', '', '', RmtInfNode);


        XMLNodeCurr := XMLNewChild;

        lTotalExtDocNo := '';
        lPmtJnlLine.RESET;
        lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
        lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
        lPmtJnlLine.SETRANGE("Parent Line No. FND", PmtJnlLine."Line No.");
        IF lPmtJnlLine.FINDSET(FALSE) THEN
            REPEAT
                IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
                    IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
                        //HEI.36>>
                        /*
                        IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
                          lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.",STRLEN(lPurchInvHeader."Vendor Invoice No.")-8,9)
                          ELSE
                        */
                        //HEI.36<<
                        lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
                        lTotalExtDocNo += lVendInvNo + ',';
                    END;
            UNTIL lPmtJnlLine.NEXT = 0;
        lTotalExtDocNo := ReplaceTextCharacters(lTotalExtDocNo);//HEI.36
        IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
            lTotalExtDocNo := COPYSTR(lTotalExtDocNo, 1, STRLEN(lTotalExtDocNo) - 1);
            lTotalExtDocNo := lText50000 + lTotalExtDocNo;
            IF (STRLEN(lTotalExtDocNo) <= 35) THEN
                AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
            IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
            END;
        END
        ELSE
            AddElement(RmtInfNode, 'Ustrd', CopyStr(PaymentMessage, 1, 70), '', XMLNewChild);

        XMLNodeCurr := RootNode;
        //HEI.28<<

    end;
    //BC UPGRADE KUMARR78 << Rewriting Function ExportTransactionInformationBahamas442


    //     //BC UPGRADE KUMARR78 >> Blocking Function ExportPaymentInformationBahamas440
    //     local procedure ExportPaymentInformationBahamas440(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    //     var
    //         XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //         RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //         AddressLine1: Text[110];
    //         AddressLine2: Text[60];
    //         AddressLine3: Text[110];
    //         AddressLine4: Text[60];
    //         ChargeBearer: Text[4];
    //         BICICIABPos: Integer;
    //         lVendor: Record "23";
    //         VendBankAcc: Record "288";
    //         BeneficiaryBankAccountNo: Text[30];
    //         lIsEURPayment: Boolean;
    //         InstructionPriority: Code[10];
    //         BankAccount: Record "270";
    //     begin
    //         //HEI.28>>
    //         RootNode := XMLNodeCurr;
    //         PaymentInformationCounter := PaymentInformationCounter + 1;
    //         AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         PmtInfNode := XMLNodeCurr;

    //         AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);

    //         IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
    //             IF lVendor.GET(PmtJnlLine."Account No.") THEN;

    //         AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

    //         AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'SvcLvl', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Cd', 'BKTR', '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         IF PmtJnlLine."HNK Bank Account" <> '' THEN
    //             BankAccount.GET(PmtJnlLine."HNK Bank Account");
    //         BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
    //         AddElement(XMLNodeCurr, 'Nm', COPYSTR(BankAccount.Name, 1, 70), '', XMLNewChild);

    //         AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         GetCountry(BankAccount."Country/Region Code");

    //         AddressLine1 := DELCHR(BankAccount.Address, '<>') + ' ' + DELCHR(BankAccount."Address 2", '<>');
    //         AddressLine1 := ReplaceTextCharacters(AddressLine1);

    //         AddElement(XMLNodeCurr, 'StrtNm', COPYSTR(AddressLine1, 1, 70), '', XMLNewChild);

    //         IF Country."ISO Country/Region Code" <> '' THEN
    //             AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //         ELSE
    //             AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         GetBankAccount(PmtJnlLine."HNK Bank Account");

    //         BeneficiaryBankAccountNo := '';
    //         IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
    //             BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

    //         AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         AddElement(XMLNodeCurr, 'Ccy', COPYSTR(GeneralLedgerSetup."LCY Code", 1, 3), '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;
    //         IF Country."ISO Country/Region Code" <> '' THEN
    //             AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //         ELSE
    //             AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //         XMLNodeCurr := RootNode;
    //         //HEI.28<<
    //     end;
    // //BC UPGRADE KUMARR78 << Blocking Function ExportPaymentInformationBahamas440

    //BC UPGRADE KUMARR78 >> Rewriting Function ExportPaymentInformationBahamas440
    local procedure ExportPaymentInformationBahamas440(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;

        PmtInfNodeLocal: XmlNode;
        PmtTpInfNode: XmlNode;
        SvcLvlNode: XmlNode;
        DbtrNode: XmlNode;
        PstlAdrNode: XmlNode;
        DbtrAcctNode: XmlNode;
        IdNode: XmlNode;
        OthrNode: XmlNode;
        DbtrAgtNode: XmlNode;
        FinInstnIdNode: XmlNode;
        AgentAdrNode: XmlNode;

        AddressLine1: Text[110];
        BeneficiaryBankAccountNo: Text[30];

        VendorRec: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        BankAccount: Record "Bank Account";
    begin
        //HEI.28>>

        RootNode := XMLNodeCurr;

        PaymentInformationCounter += 1;

        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        PmtInfNodeLocal := XMLNewChild;
        PmtInfNode := XMLNewChild;

        AddElement(PmtInfNodeLocal, 'PmtInfId', MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);

        if PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor then
            if VendorRec.Get(PmtJnlLine."Account No.") then;

        AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'PmtTpInf', '', '', XMLNewChild);
        PmtTpInfNode := XMLNewChild;

        AddElement(PmtTpInfNode, 'SvcLvl', '', '', XMLNewChild);
        SvcLvlNode := XMLNewChild;

        AddElement(SvcLvlNode, 'Cd', 'BKTR', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'ReqdExctnDt', Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'Dbtr', '', '', XMLNewChild);
        DbtrNode := XMLNewChild;

        if PmtJnlLine."HNK Bank Account" <> '' then
            BankAccount.Get(PmtJnlLine."HNK Bank Account");

        BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);

        // BC UPGRADE PATELS08 >>
        //HEI.40>>
        // AddElement(DbtrNode, 'Nm', CopyStr(BankAccount.Name, 1, 70), '', XMLNewChild);
        AddElement(DbtrNode, 'Nm', ReplaceTextCharacters(CompanyInfo.Name), '', XMLNewChild);
        //HEI.40<<
        // BC UPGRADE PATELS08 <<

        AddElement(DbtrNode, 'PstlAdr', '', '', XMLNewChild);
        PstlAdrNode := XMLNewChild;

        GetCountry(BankAccount."Country/Region Code");

        AddressLine1 := DelChr(BankAccount.Address, '<>') + ' ' + DelChr(BankAccount."Address 2", '<>');
        AddressLine1 := ReplaceTextCharacters(AddressLine1);

        AddElement(PstlAdrNode, 'StrtNm', CopyStr(AddressLine1, 1, 70), '', XMLNewChild);

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(PstlAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        else
            AddElement(PstlAdrNode, 'Ctry', CopyStr(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAcct', '', '', XMLNewChild);
        DbtrAcctNode := XMLNewChild;

        AddElement(DbtrAcctNode, 'Id', '', '', XMLNewChild);
        IdNode := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        BeneficiaryBankAccountNo := '';
        if VendBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") then
            BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

        AddElement(IdNode, 'Othr', '', '', XMLNewChild);
        OthrNode := XMLNewChild;

        AddElement(OthrNode, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        AddElement(DbtrAcctNode, 'Ccy', CopyStr(GeneralLedgerSetup."LCY Code", 1, 3), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAgt', '', '', XMLNewChild);
        DbtrAgtNode := XMLNewChild;

        AddElement(DbtrAgtNode, 'FinInstnId', '', '', XMLNewChild);
        FinInstnIdNode := XMLNewChild;

        AddElement(FinInstnIdNode, 'BIC', CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

        AddElement(FinInstnIdNode, 'PstlAdr', '', '', XMLNewChild);
        AgentAdrNode := XMLNewChild;

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(AgentAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        else
            AddElement(AgentAdrNode, 'Ctry', CopyStr(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

        XMLNodeCurr := RootNode;

        //HEI.28<<
    end;
    //BC UPGRADE KUMARR78 << Rewriting Function ExportPaymentInformationBahamas440

    //BC UPGRADE KUMARR78 >> Blocking Function ExportPaymentInformationBahamas441
    // local procedure ExportPaymentInformationBahamas441(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     AddressLine3: Text[110];
    //     AddressLine4: Text[60];
    //     ChargeBearer: Text[4];
    //     BICICIABPos: Integer;
    //     lVendor: Record "23";
    //     VendBankAcc: Record "288";
    //     BeneficiaryBankAccountNo: Text[30];
    //     lIsEURPayment: Boolean;
    //     InstructionPriority: Code[10];
    //     BankAccount: Record "270";
    // begin
    //     //HEI.28>>
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;

    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);

    //     IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
    //         IF lVendor.GET(PmtJnlLine."Account No.") THEN;

    //     AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'SvcLvl', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Cd', 'NURG', '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     IF PmtJnlLine."HNK Bank Account" <> '' THEN
    //         BankAccount.GET(PmtJnlLine."HNK Bank Account");
    //     BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
    //     AddElement(XMLNodeCurr, 'Nm', COPYSTR(BankAccount.Name, 1, 70), '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetCountry(BankAccount."Country/Region Code");

    //     AddressLine1 := DELCHR(BankAccount.Address, '<>') + ' ' + DELCHR(BankAccount."Address 2", '<>');
    //     AddressLine1 := ReplaceTextCharacters(AddressLine1);

    //     AddElement(XMLNodeCurr, 'StrtNm', COPYSTR(AddressLine1, 1, 70), '', XMLNewChild);

    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");

    //     BeneficiaryBankAccountNo := '';
    //     IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
    //         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

    //     AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'Ccy', COPYSTR(GeneralLedgerSetup."LCY Code", 1, 3), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := RootNode;
    //     //HEI.28<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking Function ExportPaymentInformationBahamas441

    //BC UPGRADE KUMARR78 >> Rewriting Function ExportPaymentInformationBahamas441
    //BC UPGRADE KUMARR78 >>
    local procedure ExportPaymentInformationBahamas441(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;

        PmtInfNodeLocal: XmlNode;
        PmtTpInfNode: XmlNode;
        SvcLvlNode: XmlNode;
        DbtrNode: XmlNode;
        PstlAdrNode: XmlNode;
        DbtrAcctNode: XmlNode;
        IdNode: XmlNode;
        OthrNode: XmlNode;
        DbtrAgtNode: XmlNode;
        FinInstnIdNode: XmlNode;
        AgentAdrNode: XmlNode;

        AddressLine1: Text[110];
        BeneficiaryBankAccountNo: Text[30];

        VendorRec: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        BankAccount: Record "Bank Account";
    begin
        //HEI.28>>

        RootNode := XMLNodeCurr;

        PaymentInformationCounter += 1;

        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        PmtInfNodeLocal := XMLNewChild;
        PmtInfNode := XMLNewChild;

        AddElement(PmtInfNodeLocal, 'PmtInfId', MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);

        if PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor then
            if VendorRec.Get(PmtJnlLine."Account No.") then;

        AddElement(PmtInfNodeLocal, 'PmtMtd', 'TRF', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'PmtTpInf', '', '', XMLNewChild);
        PmtTpInfNode := XMLNewChild;

        AddElement(PmtTpInfNode, 'SvcLvl', '', '', XMLNewChild);
        SvcLvlNode := XMLNewChild;

        AddElement(SvcLvlNode, 'Cd', 'NURG', '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'ReqdExctnDt', Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'Dbtr', '', '', XMLNewChild);
        DbtrNode := XMLNewChild;

        if PmtJnlLine."HNK Bank Account" <> '' then
            BankAccount.Get(PmtJnlLine."HNK Bank Account");

        BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);

        // BC UPGRADE PATELS08 >>
        //HEI.40>>
        // AddElement(DbtrNode, 'Nm', CopyStr(BankAccount.Name, 1, 70), '', XMLNewChild);
        AddElement(DbtrNode, 'Nm', ReplaceTextCharacters(CompanyInfo.Name), '', XMLNewChild);
        //HEI.40<<
        // BC UPGRADE PATELS08 <<

        AddElement(DbtrNode, 'PstlAdr', '', '', XMLNewChild);
        PstlAdrNode := XMLNewChild;

        GetCountry(BankAccount."Country/Region Code");

        AddressLine1 := DelChr(BankAccount.Address, '<>') + ' ' + DelChr(BankAccount."Address 2", '<>');
        AddressLine1 := ReplaceTextCharacters(AddressLine1);

        AddElement(PstlAdrNode, 'StrtNm', CopyStr(AddressLine1, 1, 70), '', XMLNewChild);

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(PstlAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        else
            AddElement(PstlAdrNode, 'Ctry', CopyStr(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAcct', '', '', XMLNewChild);
        DbtrAcctNode := XMLNewChild;

        AddElement(DbtrAcctNode, 'Id', '', '', XMLNewChild);
        IdNode := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        BeneficiaryBankAccountNo := '';
        if VendBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") then
            BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

        AddElement(IdNode, 'Othr', '', '', XMLNewChild);
        OthrNode := XMLNewChild;

        AddElement(OthrNode, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        AddElement(DbtrAcctNode, 'Ccy', CopyStr(GeneralLedgerSetup."LCY Code", 1, 3), '', XMLNewChild);

        AddElement(PmtInfNodeLocal, 'DbtrAgt', '', '', XMLNewChild);
        DbtrAgtNode := XMLNewChild;

        AddElement(DbtrAgtNode, 'FinInstnId', '', '', XMLNewChild);
        FinInstnIdNode := XMLNewChild;

        AddElement(FinInstnIdNode, 'BIC', CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

        AddElement(FinInstnIdNode, 'PstlAdr', '', '', XMLNewChild);
        AgentAdrNode := XMLNewChild;

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(AgentAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        else
            AddElement(AgentAdrNode, 'Ctry', CopyStr(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

        XMLNodeCurr := RootNode;

        //HEI.28<<
    end;
    //BC UPGRADE KUMARR78 << Rewriting Function ExportPaymentInformationBahamas441

    //BC UPGRADE KUMARR78 >> Blocking Function ExportPaymentInformationBahamas442
    // local procedure ExportPaymentInformationBahamas442(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     AddressLine1: Text[110];
    //     AddressLine2: Text[60];
    //     AddressLine3: Text[110];
    //     AddressLine4: Text[60];
    //     ChargeBearer: Text[4];
    //     BICICIABPos: Integer;
    //     lVendor: Record "23";
    //     VendBankAcc: Record "288";
    //     BeneficiaryBankAccountNo: Text[30];
    //     lIsEURPayment: Boolean;
    //     InstructionPriority: Code[10];
    //     BankAccount: Record "270";
    // begin
    //     //HEI.28>>
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;

    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);

    //     IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
    //         IF lVendor.GET(PmtJnlLine."Account No.") THEN;

    //     AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'SvcLvl', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Cd', 'URGP', '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     IF PmtJnlLine."HNK Bank Account" <> '' THEN
    //         BankAccount.GET(PmtJnlLine."HNK Bank Account");
    //     BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);
    //     AddElement(XMLNodeCurr, 'Nm', COPYSTR(BankAccount.Name, 1, 70), '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetCountry(BankAccount."Country/Region Code");

    //     AddressLine1 := DELCHR(BankAccount.Address, '<>') + ' ' + DELCHR(BankAccount."Address 2", '<>');
    //     AddressLine1 := ReplaceTextCharacters(AddressLine1);

    //     AddElement(XMLNodeCurr, 'StrtNm', COPYSTR(AddressLine1, 1, 70), '', XMLNewChild);

    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");

    //     BeneficiaryBankAccountNo := '';
    //     IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
    //         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

    //     AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'Ccy', COPYSTR(GeneralLedgerSetup."LCY Code", 1, 3), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := RootNode;
    //     //HEI.28<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking Function ExportPaymentInformationBahamas442

    //BC UPGRADE KUMARR78 >> Blocking Function ExportPaymentInformationBahamas441
    local procedure ExportPaymentInformationBahamas442(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND");
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;
        AddressLine1: Text[110];
        AddressLine2: Text[60];
        AddressLine3: Text[110];
        AddressLine4: Text[60];
        ChargeBearer: Text[4];
        BICICIABPos: Integer;
        lVendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        BeneficiaryBankAccountNo: Text[30];
        lIsEURPayment: Boolean;
        InstructionPriority: Code[10];
        BankAccount: Record "Bank Account";
        DbtrNode: XmlNode;
        PstlAdrNode: XmlNode;        
    begin
        //HEI.28>>
        RootNode := XMLNodeCurr;
        PaymentInformationCounter := PaymentInformationCounter + 1;
        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        PmtInfNode := XMLNodeCurr;

        AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);

        IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
            IF lVendor.GET(PmtJnlLine."Account No.") THEN;

        AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

        AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;  

        AddElement(XMLNodeCurr, 'SvcLvl', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Cd', 'URGP', '', XMLNewChild);
        AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
        // XMLNodeCurr := XMLNewChild;
        DbtrNode := XMLNewChild;

        IF PmtJnlLine."HNK Bank Account" <> '' THEN
            BankAccount.GET(PmtJnlLine."HNK Bank Account");
        BankAccount.Name := ReplaceTextCharacters(BankAccount.Name);

        // BC UPGRADE PATELS08 >>
        //HEI.40>>
        // AddElement(XMLNodeCurr,'Nm',COPYSTR(BankAccount.Name,1,70),'',XMLNewChild);
        AddElement(DbtrNode,'Nm',ReplaceTextCharacters(CompanyInfo.Name),'',XMLNewChild);
        //HEI.40<<
        // BC UPGRADE PATELS08 <<

        AddElement(DbtrNode, 'PstlAdr', '', '', XMLNewChild);
        // XMLNodeCurr := XMLNewChild;
        PstlAdrNode := XMLNewChild;

        GetCountry(BankAccount."Country/Region Code");

        AddressLine1 := DELCHR(BankAccount.Address, '<>') + ' ' + DELCHR(BankAccount."Address 2", '<>');
        AddressLine1 := ReplaceTextCharacters(AddressLine1);

        AddElement(PstlAdrNode, 'StrtNm', COPYSTR(AddressLine1, 1, 70), '', XMLNewChild);

        IF Country."ISO Country/Region Code FND" <> '' THEN
            AddElement(PstlAdrNode, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        ELSE
            AddElement(PstlAdrNode, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);

        AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        BeneficiaryBankAccountNo := '';
        IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
            BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        AddElement(XMLNodeCurr, 'Ccy', COPYSTR(GeneralLedgerSetup."LCY Code", 1, 3), '', XMLNewChild);

        AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF Country."ISO Country/Region Code FND" <> '' THEN
            AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        ELSE
            AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAccount."Country/Region Code", 1, 2), '', XMLNewChild);
        XMLNodeCurr := RootNode;
        //HEI.28<<
    end;
    //BC UPGRADE KUMARR78 << Rewriting Function ExportPaymentInformationBahamas442

    //BC UPGRADE KUMARR78 >> Blocking for Rewriting
    // local procedure StartGroupHeaderBahamas440(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     //HEI.28>>
    //     AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
    //     //HEI.28<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking for Rewriting

    //BC UPGRADE KUMARR78 >> Rewriting StartGroupHeaderBahamas440 Function.
    local procedure StartGroupHeaderBahamas440(XMLNodeCurr: XmlNode);
    var
        XMLNewChild: XmlNode;
    begin
        AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
        //BC UPGRADE ATHUKS01 Added 
        Clear(FinalXmlNode);
        FinalXmlNode := XMLNodeCurr;
        //BC UPGRADE ATHUKS01 Added.
    end;
    //BC UPGRADE KUMARR78 << Rewriting StartGroupHeaderBahamas440 Function.


    //BC UPGRADE KUMARR78 >> Blocking for Rewriting
    // local procedure StartGroupHeaderBahamas441(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     //HEI.28>>
    //     AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
    //     //HEI.28<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking for Rewriting

    //BC UPGRADE KUMARR78 >> Rewriting StartGroupHeaderBahamas441 Function.
    local procedure StartGroupHeaderBahamas441(XMLNodeCurr: XmlNode);
    var
        XMLNewChild: XmlNode;
    begin
        AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
        //BC UPGRADE ATHUKS01 Added 
        Clear(FinalXmlNode);
        FinalXmlNode := XMLNodeCurr;
        //BC UPGRADE ATHUKS01 Added.
    end;
    //BC UPGRADE KUMARR78 << Rewriting StartGroupHeaderBahamas441 Function.


    //BC UPGRADE KUMARR78 >> Blocking for Rewriting
    // local procedure StartGroupHeaderBahamas442(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     //HEI.28>>
    //     AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
    //     //HEI.28<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking for Rewriting

    //BC UPGRADE KUMARR78 >> Rewriting StartGroupHeaderBahamas442 Function.
    local procedure StartGroupHeaderBahamas442(XMLNodeCurr: XmlNode);
    var
        XMLNewChild: XmlNode;
    begin
        //HEI.28>>
        AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
        //HEI.28<<
        //BC UPGRADE ATHUKS01 Added 
        Clear(FinalXmlNode);
        FinalXmlNode := XMLNodeCurr;
        //BC UPGRADE ATHUKS01 Added.
    end;
    //BC UPGRADE KUMARR78 >> Rewriting StartGroupHeaderBahamas442 Function.


    procedure FinishGroupHeaderBahamas440(JournalAmt: Decimal);
    var
        //BC UPGRADE KUMARR78 >> Blocking to Replace Variable
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking to Replace Variable
        //BC UPGRADE KUMARR78 >> Adding With Replace Variable
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;
    //BC UPGRADE KUMARR78 << Adding With Replace Variable

    begin
        //HEI.28>>
        // Insert Number of Transactions and ControlSum in the Group Header
        // XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document'); //BC UPGRADE Rewriting
        //XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        XMLNodeCurr := FinalXmlNode;
        AddElement(XMLNodeCurr, 'NbOfTxs', FORMAT(NumberOfTransactions, 0, 9), '', XMLNewChild);
        //HEI.30>>
        //AddElement(XMLNodeCurr,'CtrlSum',FORMAT(JournalAmt),'',XMLNewChild);
        AddElement(XMLNodeCurr, 'CtrlSum', FORMAT(JournalAmt, 0, '<Precision,2:2><Standard Format,2>'), '', XMLNewChild);
        //HEI.30<<

        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        CompanyInfo.Name := ReplaceTextCharacters(CompanyInfo.Name);
        AddElement(XMLNodeCurr, 'Nm', COPYSTR(CompanyInfo.Name, 1, 35), '', XMLNewChild);
        //HEI.28<<
    end;

    procedure FinishGroupHeaderBahamas441(JournalAmt: Decimal);
    var
        //BC UPGRADE KUMARR78 >> Blocking to Replace Variable
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking to Replace Variable
        //BC UPGRADE KUMARR78 >> Adding With Replace Variable
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;
    //BC UPGRADE KUMARR78 << Adding With Replace Variable
    begin
        //HEI.28>>
        // Insert Number of Transactions and ControlSum in the Group Header
        // XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document'); //BC UPGRADE Rewriting
        //  XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        XMLNodeCurr := FinalXmlNode;

        AddElement(XMLNodeCurr, 'NbOfTxs', FORMAT(NumberOfTransactions, 0, 9), '', XMLNewChild);
        //HEI.30>>
        //AddElement(XMLNodeCurr,'CtrlSum',FORMAT(JournalAmt),'',XMLNewChild);
        AddElement(XMLNodeCurr, 'CtrlSum', FORMAT(JournalAmt, 0, '<Precision,2:2><Standard Format,2>'), '', XMLNewChild);
        //HEI.30<<

        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        CompanyInfo.Name := ReplaceTextCharacters(CompanyInfo.Name);
        AddElement(XMLNodeCurr, 'Nm', COPYSTR(CompanyInfo.Name, 1, 35), '', XMLNewChild);
        //HEI.28<<
    end;

    procedure FinishGroupHeaderBahamas442(JournalAmt: Decimal);
    var
        //BC UPGRADE KUMARR78 >> Blocking to Replace Variable
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking to Replace Variable
        //BC UPGRADE KUMARR78 >> Adding With Replace Variable
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;
    //BC UPGRADE KUMARR78 << Adding With Replace Variable
    begin
        //HEI.28>>
        // Insert Number of Transactions and ControlSum in the Group Header
        // XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document'); //BC UPGRADE Rewriting
        //   XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        XMLNodeCurr := FinalXmlNode;

        AddElement(XMLNodeCurr, 'NbOfTxs', FORMAT(NumberOfTransactions, 0, 9), '', XMLNewChild);
        //HEI.30>>
        //AddElement(XMLNodeCurr,'CtrlSum',FORMAT(JournalAmt),'',XMLNewChild);
        AddElement(XMLNodeCurr, 'CtrlSum', FORMAT(JournalAmt, 0, '<Precision,2:2><Standard Format,2>'), '', XMLNewChild);
        //HEI.30<<

        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        CompanyInfo.Name := ReplaceTextCharacters(CompanyInfo.Name);
        AddElement(XMLNodeCurr, 'Nm', COPYSTR(CompanyInfo.Name, 1, 35), '', XMLNewChild);
        //HEI.28<<
    end;

    procedure ValidatePaymentContentBahamas440(GenJournalLine: Record "Gen. Journal Line BC FND"): Text;
    var
        // TempBlob: Record "99008535" temporary; //BC UPGRADE KUMARR78 Blocking
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        //BC UPGRADE KUMARR78 >> Blocking
        // XMLDOMManagement: Codeunit "6224";
        // XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lVendor: Record Vendor;
        lCountryRegion: Record "Country/Region";
        lText001: Label 'Company Information Address or Company Information Address 2 must have a value!';
        lText002: Label 'Company Information Post Code or Company Information City must have a value!';
        lBankAccount: Record "Bank Account";
        lCurrency: Record Currency;
        lVendorBankAccount: Record "Vendor Bank Account";
        lText003: Label 'Vendor Address or Vendor Address 2 must have a value for vendor %1!';
        lText004: Label 'Vendor Post Code or Vendor City must have a value for vendor %1!';
        lText005: Label 'Field %1 cannot be empty for %2 %3!';
        lText006: Label 'Field %1 cannot be empty in %2!';
        lText007: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText008: Label 'Panama Bank Routing Code cannot be empty for %2 %3 Vendor %4!';
        lText011: Label 'Address or Address 2 must have a value for Vendor %1 Vendor Bank Account %2!';
        lText009: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText010: Label 'SWIFT Code %1 must belong to Country Code %2!';
    begin
        //HEI.28>>
        CompanyInfo.GET;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);

        IF lGenJournalLine.FINDSET(FALSE) THEN
            REPEAT
                IF (CompanyInfo.Name = '') THEN
                    ERROR(lText006, CompanyInfo.FIELDCAPTION(Name), CompanyInfo.TABLECAPTION);
                //HEI.36>>
                /*
                IF (CompanyInfo."Country/Region Code" = '') THEN
                  ERROR(lText006,CompanyInfo.FIELDCAPTION("Country/Region Code"),CompanyInfo.TABLECAPTION);
                */
                //HEI.36>>
                IF (lGenJournalLine."Posting Date" = 0D) THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Posting Date"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."HNK Bank Account" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("HNK Bank Account"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Document No." = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Document No."), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Message to Recipient" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Message to Recipient"), lGenJournalLine81.TABLECAPTION);

                //HEI.36>>
                /*
                IF (CompanyInfo.Address + CompanyInfo."Address 2" = '') THEN
                  ERROR(lText001);
                IF (CompanyInfo."Post Code" + CompanyInfo.City = '') THEN
                  ERROR(lText002);
                */
                //HEI.36<<

                IF lCountryRegion.GET(CompanyInfo."Country/Region Code") THEN
                    lCountryRegion.TESTFIELD("ISO Country/Region Code FND");

                IF lVendor.GET(lGenJournalLine."Account No.") THEN BEGIN
                    IF (lVendor.Name = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION(Name), lVendor.TABLECAPTION, lVendor."No.");
                    //HEI.36>>
                    /*
                    IF (lVendor."Payment Method Code" = '') THEN
                      ERROR(lText005,lVendor.FIELDCAPTION("Payment Method Code"),lVendor.TABLECAPTION,lVendor."No.");
                    IF (lVendor."Country/Region Code" = '') THEN
                      ERROR(lText005,lVendor.FIELDCAPTION("Country/Region Code"),lVendor.TABLECAPTION,lVendor."No.");
                    */
                    //HEI.36<<
                    IF lCountryRegion.GET(lVendor."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendor."Country/Region Code");

                    IF (lVendor.Address + lVendor."Address 2" = '') THEN
                        ERROR(lText003, lVendor."No.");
                    //HEI.36>>
                    /*
                    IF (lVendor."Post Code" + lVendor.City = '') THEN
                      ERROR(lText004,lVendor."No.");
                    */
                    IF (lVendor."VAT Registration No." = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION("VAT Registration No."), lVendor.TABLECAPTION, lVendor."No.");
                    //HEI.36<<
                END;

                //HEI.36>>
                /*
                IF lBankAccount.GET(lGenJournalLine."HNK Bank Account") THEN
                  BEGIN
                    IF (lBankAccount."SWIFT Code" = '') THEN
                      ERROR(lText005,lBankAccount.FIELDCAPTION("SWIFT Code"),lBankAccount.TABLECAPTION,lGenJournalLine."HNK Bank Account");

                    IF (lBankAccount."Bank Account No." = '') THEN
                      ERROR(lText005,lBankAccount.FIELDCAPTION("Bank Account No."),lBankAccount.TABLECAPTION,lGenJournalLine."HNK Bank Account");
                  END;
                */
                //HEI.36<<

                IF (lGenJournalLine."Currency Code" <> '') THEN
                    IF lCurrency.GET(lGenJournalLine."Currency Code") THEN
                        IF (lCurrency."ISO Currency Code FND" = '') THEN
                            ERROR(lText005, lCurrency.FIELDCAPTION("ISO Currency Code FND"), lCurrency.TABLECAPTION, lCurrency.Code);

                IF lVendorBankAccount.GET(lGenJournalLine."Account No.", lGenJournalLine."Customer/Vendor Bank") THEN BEGIN
                    IF (lVendorBankAccount.Name = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION(Name), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Country/Region Code" = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Country/Region Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    IF lCountryRegion.GET(lVendorBankAccount."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendorBankAccount."Country/Region Code");
                    //HEI.36>>
                    /*
                    IF (lVendorBankAccount."Bank Account No." = '') THEN
                      ERROR(lText007,lVendorBankAccount.FIELDCAPTION("Bank Account No."),lVendorBankAccount.TABLECAPTION,lVendorBankAccount.Code,lGenJournalLine."Account No.");
                    */
                    //HEI.36<<
                    IF (lVendorBankAccount."SWIFT Code" = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("SWIFT Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Bank Branch No." = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Branch No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    //HEI.36>>
                    //HEI.38>>
                    /*
                    IF (lVendorBankAccount.Address + lVendorBankAccount."Address 2" = '') THEN
                      ERROR(lText011,lGenJournalLine."Account No.",lVendorBankAccount.Code);
                    */
                    //HEI.38<<
                    IF (lVendorBankAccount."Country/Region Code" = '') THEN
                        ERROR(lText009, lVendorBankAccount.FIELDCAPTION("Country/Region Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Country/Region Code" <> COPYSTR(lVendorBankAccount."SWIFT Code", 5, 2)) THEN
                        ERROR(lText010, lVendorBankAccount."SWIFT Code", lVendorBankAccount."Country/Region Code");
                    //HEI.36<<
                END;
            UNTIL lGenJournalLine.NEXT = 0;
        //HEI.28<<

    end;

    procedure ValidatePaymentContentBahamas441(GenJournalLine: Record "Gen. Journal Line BC FND"): Text;
    var
        // TempBlob: Record "99008535" temporary;//BC UPGRADE KUMARR78 Blocking
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        //BC UPGRADE KUMARR78 >> Blocking
        // XMLDOMManagement: Codeunit "6224";
        // XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lVendor: Record Vendor;
        lCountryRegion: Record "Country/Region";
        lText001: Label 'Company Information Address or Company Information Address 2 must have a value!';
        lText002: Label 'Company Information Post Code or Company Information City must have a value!';
        lBankAccount: Record "Bank Account";
        lCurrency: Record Currency;
        lVendorBankAccount: Record "Vendor Bank Account";
        lText003: Label 'Vendor Address or Vendor Address 2 must have a value for vendor %1!';
        lText004: Label 'Vendor Post Code or Vendor City must have a value for vendor %1!';
        lText005: Label 'Field %1 cannot be empty for %2 %3!';
        lText006: Label 'Field %1 cannot be empty in %2!';
        lText007: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText008: Label 'Panama Bank Routing Code cannot be empty for %2 %3 Vendor %4!';
        lText011: Label 'Address or Address 2 must have a value for Vendor %1 Vendor Bank Account %2!';
        lText009: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText010: Label 'SWIFT Code %1 must belong to Country Code %2!';
    begin
        //HEI.28>>
        CompanyInfo.GET;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);

        IF lGenJournalLine.FINDSET(FALSE) THEN
            REPEAT
                IF (CompanyInfo.Name = '') THEN
                    ERROR(lText006, CompanyInfo.FIELDCAPTION(Name), CompanyInfo.TABLECAPTION);
                //HEI.36>>
                /*
                IF (CompanyInfo."Country/Region Code" = '') THEN
                  ERROR(lText006,CompanyInfo.FIELDCAPTION("Country/Region Code"),CompanyInfo.TABLECAPTION);
                */
                //HEI.36<<
                IF (lGenJournalLine."Posting Date" = 0D) THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Posting Date"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."HNK Bank Account" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("HNK Bank Account"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Document No." = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Document No."), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Message to Recipient" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Message to Recipient"), lGenJournalLine81.TABLECAPTION);

                //HEI.36>>
                /*
                IF (CompanyInfo.Address + CompanyInfo."Address 2" = '') THEN
                  ERROR(lText001);
                IF (CompanyInfo."Post Code" + CompanyInfo.City = '') THEN
                  ERROR(lText002);
                */
                //HEI.36<<

                IF lCountryRegion.GET(CompanyInfo."Country/Region Code") THEN
                    lCountryRegion.TESTFIELD("ISO Country/Region Code FND");

                IF lVendor.GET(lGenJournalLine."Account No.") THEN BEGIN
                    IF (lVendor.Name = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION(Name), lVendor.TABLECAPTION, lVendor."No.");
                    //HEI.36>>
                    /*
                    IF (lVendor."Payment Method Code" = '') THEN
                      ERROR(lText005,lVendor.FIELDCAPTION("Payment Method Code"),lVendor.TABLECAPTION,lVendor."No.");
                    IF (lVendor."Country/Region Code" = '') THEN
                      ERROR(lText005,lVendor.FIELDCAPTION("Country/Region Code"),lVendor.TABLECAPTION,lVendor."No.");
                    */
                    //HEI.36<<

                    IF lCountryRegion.GET(lVendor."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendor."Country/Region Code");

                    IF (lVendor.Address + lVendor."Address 2" = '') THEN
                        ERROR(lText003, lVendor."No.");
                    //HEI.36>>
                    /*
                    IF (lVendor."Post Code" + lVendor.City = '') THEN
                      ERROR(lText004,lVendor."No.");
                    */
                    //HEI.36<<
                END;

                //HEI.36>>
                /*
                IF lBankAccount.GET(lGenJournalLine."HNK Bank Account") THEN
                  BEGIN
                    IF (lBankAccount."SWIFT Code" = '') THEN
                      ERROR(lText005,lBankAccount.FIELDCAPTION("SWIFT Code"),lBankAccount.TABLECAPTION,lGenJournalLine."HNK Bank Account");

                    IF (lBankAccount."Bank Account No." = '') THEN
                      ERROR(lText005,lBankAccount.FIELDCAPTION("Bank Account No."),lBankAccount.TABLECAPTION,lGenJournalLine."HNK Bank Account");
                  END;
                */
                //HEI.36<<

                IF (lGenJournalLine."Currency Code" <> '') THEN
                    IF lCurrency.GET(lGenJournalLine."Currency Code") THEN
                        IF (lCurrency."ISO Currency Code FND" = '') THEN
                            ERROR(lText005, lCurrency.FIELDCAPTION("ISO Currency Code FND"), lCurrency.TABLECAPTION, lCurrency.Code);

                IF lVendorBankAccount.GET(lGenJournalLine."Account No.", lGenJournalLine."Customer/Vendor Bank") THEN BEGIN
                    IF (lVendorBankAccount.Name = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION(Name), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Country/Region Code" = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Country/Region Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    IF lCountryRegion.GET(lVendorBankAccount."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendorBankAccount."Country/Region Code");
                    //HEI.36>>
                    /*
                    IF (lVendorBankAccount."Bank Account No." = '') THEN
                      ERROR(lText007,lVendorBankAccount.FIELDCAPTION("Bank Account No."),lVendorBankAccount.TABLECAPTION,lVendorBankAccount.Code,lGenJournalLine."Account No.");
                    */
                    //HEI.36<<
                    IF (lVendorBankAccount."SWIFT Code" = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("SWIFT Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Bank Branch No." = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Branch No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    //HEI.36>>
                    //HEI.38>>
                    /*
                    IF (lVendorBankAccount.Address + lVendorBankAccount."Address 2" = '') THEN
                      ERROR(lText011,lGenJournalLine."Account No.",lVendorBankAccount.Code);
                    */
                    //HEI.38<<
                    IF (lVendorBankAccount."Country/Region Code" = '') THEN
                        ERROR(lText009, lVendorBankAccount.FIELDCAPTION("Country/Region Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Country/Region Code" <> COPYSTR(lVendorBankAccount."SWIFT Code", 5, 2)) THEN
                        ERROR(lText010, lVendorBankAccount."SWIFT Code", lVendorBankAccount."Country/Region Code");
                    //HEI.36<<
                END;
            UNTIL lGenJournalLine.NEXT = 0;
        //HEI.28<<

    end;

    procedure ValidatePaymentContentBahamas442(GenJournalLine: Record "Gen. Journal Line BC FND"): Text;
    var
        // TempBlob: Record "99008535" temporary;//BC UPGRADE KUMARR78 Blocking
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        //BC UPGRADE KUMARR78 >> Blocking
        // XMLDOMManagement: Codeunit "6224";
        // XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lVendor: Record Vendor;
        lCountryRegion: Record "Country/Region";
        lText001: Label 'Company Information Address or Company Information Address 2 must have a value!';
        lText002: Label 'Company Information Post Code or Company Information City must have a value!';
        lBankAccount: Record "Bank Account";
        lCurrency: Record Currency;
        lVendorBankAccount: Record "Vendor Bank Account";
        lText003: Label 'Vendor Address or Vendor Address 2 must have a value for vendor %1!';
        lText004: Label 'Vendor Post Code or Vendor City must have a value for vendor %1!';
        lText005: Label 'Field %1 cannot be empty for %2 %3!';
        lText006: Label 'Field %1 cannot be empty in %2!';
        lText007: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText008: Label 'Panama Bank Routing Code cannot be empty for %2 %3 Vendor %4!';
        lText009: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText010: Label 'SWIFT Code %1 must belong to Country Code %2!';
        lText011: Label 'Address or Address 2 must have a value for Vendor %1 Vendor Bank Account %2!';
    begin
        //HEI.28>>
        CompanyInfo.GET;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);

        IF lGenJournalLine.FINDSET(FALSE) THEN
            REPEAT
                IF (CompanyInfo.Name = '') THEN
                    ERROR(lText006, CompanyInfo.FIELDCAPTION(Name), CompanyInfo.TABLECAPTION);
                //HEI.36>>
                /*
                IF (CompanyInfo."Country/Region Code" = '') THEN
                  ERROR(lText006,CompanyInfo.FIELDCAPTION("Country/Region Code"),CompanyInfo.TABLECAPTION);
                */
                //HEI.36<<
                IF (lGenJournalLine."Posting Date" = 0D) THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Posting Date"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."HNK Bank Account" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("HNK Bank Account"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Document No." = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Document No."), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Message to Recipient" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Message to Recipient"), lGenJournalLine81.TABLECAPTION);

                //HEI.36>>
                /*
                IF (CompanyInfo.Address + CompanyInfo."Address 2" = '') THEN
                  ERROR(lText001);
                IF (CompanyInfo."Post Code" + CompanyInfo.City = '') THEN
                  ERROR(lText002);
                */
                //HEI.36<<

                IF lCountryRegion.GET(CompanyInfo."Country/Region Code") THEN
                    lCountryRegion.TESTFIELD("ISO Country/Region Code FND");

                IF lVendor.GET(lGenJournalLine."Account No.") THEN BEGIN
                    IF (lVendor.Name = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION(Name), lVendor.TABLECAPTION, lVendor."No.");
                    //HEI.36>>
                    /*
                    IF (lVendor."Payment Method Code" = '') THEN
                      ERROR(lText005,lVendor.FIELDCAPTION("Payment Method Code"),lVendor.TABLECAPTION,lVendor."No.");
                    IF (lVendor."Country/Region Code" = '') THEN
                      ERROR(lText005,lVendor.FIELDCAPTION("Country/Region Code"),lVendor.TABLECAPTION,lVendor."No.");
                    */
                    //HEI.36<<

                    IF lCountryRegion.GET(lVendor."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendor."Country/Region Code");

                    IF (lVendor.Address + lVendor."Address 2" = '') THEN
                        ERROR(lText003, lVendor."No.");
                    //HEI.36>>
                    /*
                    IF (lVendor."Post Code" + lVendor.City = '') THEN
                      ERROR(lText004,lVendor."No.");
                    IF (lVendor."VAT Registration No." = '') THEN
                      ERROR(lText005,lVendor.FIELDCAPTION("VAT Registration No."),lVendor.TABLECAPTION,lVendor."No.");
                    */
                    //HEI.36<<
                END;

                IF lBankAccount.GET(lGenJournalLine."HNK Bank Account") THEN BEGIN
                    IF (lBankAccount."SWIFT Code" = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("SWIFT Code"), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");

                    IF (lBankAccount."Bank Account No." = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("Bank Account No."), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");
                END;

                IF (lGenJournalLine."Currency Code" <> '') THEN
                    IF lCurrency.GET(lGenJournalLine."Currency Code") THEN
                        IF (lCurrency."ISO Currency Code FND" = '') THEN
                            ERROR(lText005, lCurrency.FIELDCAPTION("ISO Currency Code FND"), lCurrency.TABLECAPTION, lCurrency.Code);

                IF lVendorBankAccount.GET(lGenJournalLine."Account No.", lGenJournalLine."Customer/Vendor Bank") THEN BEGIN
                    IF (lVendorBankAccount.Name = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION(Name), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Country/Region Code" = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Country/Region Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    IF lCountryRegion.GET(lVendorBankAccount."Country/Region Code") THEN
                        IF (lCountryRegion."ISO Country/Region Code FND" = '') THEN
                            ERROR(lText005, lCountryRegion.FIELDCAPTION("ISO Country/Region Code FND"), lCountryRegion.TABLECAPTION, lVendorBankAccount."Country/Region Code");

                    IF (lVendorBankAccount."Bank Account No." = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Account No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    IF (lVendorBankAccount."SWIFT Code" = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("SWIFT Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Bank Branch No." = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Branch No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    //HEI.36>>
                    IF (lVendorBankAccount.Address + lVendorBankAccount."Address 2" = '') THEN
                        ERROR(lText011, lGenJournalLine."Account No.", lVendorBankAccount.Code);
                    IF (lVendorBankAccount."Country/Region Code" = '') THEN
                        ERROR(lText009, lVendorBankAccount.FIELDCAPTION("Country/Region Code"), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");
                    IF (lVendorBankAccount."Country/Region Code" <> COPYSTR(lVendorBankAccount."SWIFT Code", 5, 2)) THEN
                        ERROR(lText010, lVendorBankAccount."SWIFT Code", lVendorBankAccount."Country/Region Code");
                    //HEI.36<<
                END;
            UNTIL lGenJournalLine.NEXT = 0;
        //HEI.28<<

    end;

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite Function.
    // local procedure CreateNonSepaContentAlgeria_V3(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary; 
    //     lNonSepaContent: Text;
    //     OutStr: OutStream;
    //     inStr: InStream;
    //     MyText: Text;
    //     XMLDOMManagement: Codeunit "6224";
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     BigText: BigText;
    //     XMLText: Text;
    //     filRead: File;
    //     intLen: Integer;
    //     txtOneLine: Text;
    //     txtFromFile: Text;
    //     TodayString: Text;
    //     FileName1: Text;
    //     InStream: InStream;
    //     i: Integer;
    //     j: Integer;
    //     k: Integer;
    //     k1: Integer;
    //     k3: Integer;
    //     TxtToAddInComponent: Text[80];
    //     InterfaceEntryComponent: Record "Interface Entry Component INT";
    //     c: Integer;
    //     cString: Text;
    //     NewPaymentGroup: Boolean;
    //     lGenJournalLine: Record "Gen. Journal Line BC FND";
    //     Pos: Integer;
    //     lGenJournalLine81: Record "Gen. Journal Line";
    // begin
    //     //HEI.29>>
    //     CompanyInfo.GET;

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     XMLRootElement.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := FORMAT(GetMessageIDBankExportImportSetup);
    //     GMessageId := MessageId;
    //     StartGroupHeaderAlgeria_V3(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;
    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
    //     IF lGenJournalLine.FINDFIRST THEN
    //         REPEAT
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
    //                 ExportTransactionInformationAlgeria_V3(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
    //                 InitConsolidatedPayment(lGenJournalLine);
    //             END ELSE
    //                 UpdateConsolidatedPayment(lGenJournalLine);

    //             IF NewPaymentGroup THEN
    //                 ExportPaymentInformationAlgeria_V3(CstmrCdtTrfInitnNode, lGenJournalLine);
    //         UNTIL lGenJournalLine.NEXT = 0;

    //     IF NOT EmptyConsolidatedPayment THEN
    //         ExportTransactionInformationAlgeria_V3(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

    //     //Footer
    //     FinishGroupHeaderAlgeria_V3;

    //     IF DATE2DMY(TODAY, 2) < 10 THEN
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
    //     ELSE
    //         TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
    //                           FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

    //     FileName := SaveToFileNameClient;

    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName, FileName);
    //     FullFileName := FileName;

    //     filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);

    //     intLen := filRead.LEN;
    //     txtFromFile := '';

    //     InterfaceEntryComponent.RESET;
    //     c := 1;
    //     cString := 'C0001';

    //     filRead.CREATEINSTREAM(InStream);
    //     WHILE NOT InStream.EOS DO BEGIN
    //         InStream.READTEXT(txtFromFile);
    //         i := STRLEN(txtFromFile);

    //         k := i DIV 80;
    //         k1 := i MOD 80;

    //         IF k1 <> 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k + 1 DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;

    //         IF k1 = 0 THEN BEGIN
    //             k3 := 1;
    //             FOR j := 1 TO k DO BEGIN
    //                 txtOneLine := COPYSTR(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.RESET;
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := FORMAT(cString);

    //                 Pos := STRPOS(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 IF Pos <> 0 THEN
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

    //                 InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.INSERT;
    //                 c += 1;
    //                 cString := INCSTR(cString);
    //             END;
    //         END;
    //     END;

    //     TxtToAddInComponent := ']]>';
    //     InterfaceEntryComponent.RESET;
    //     InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //     InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //     InterfaceEntryComponent.Code := FORMAT(cString);
    //     InterfaceEntryComponent."Approver Name" := DELCHR(TxtToAddInComponent, '<>', ' ');
    //     InterfaceEntryComponent.INSERT;
    //     c += 1;
    //     cString := INCSTR(cString);

    //     filRead.CLOSE;

    //     IF EXISTS(SaveToFileName) THEN
    //         IF ERASE(SaveToFileName) THEN;

    //     lGenJournalLine.RESET;
    //     lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.DELETEALL;

    //     lGenJournalLine81.RESET;
    //     lGenJournalLine81.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine81.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine81.SETFILTER("Parent Line No.", '=%1', 0);
    //     lGenJournalLine81.MODIFYALL("WS Posting Allowed FND", TRUE);
    //     //HEI.29<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite Function.

    //BC UPGRADE KUMARR78 >> Rewriting CreateNonSepaContentAlgeria_V3 Function.

    local procedure CreateNonSepaContentAlgeria_V3(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text;
    var
        TempBlob: Codeunit "Temp Blob";
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XMLNodeCurr: XmlNode;
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
        XMlns: Integer;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);

        // RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // RootNode.SetAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();
        //XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;

        MessageId := FORMAT(GetMessageIDBankExportImportSetup);
        GMessageId := MessageId;
        StartGroupHeaderAlgeria_V3(XMLNewChild);
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;


        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);
        IF lGenJournalLine.FINDFIRST THEN
            REPEAT
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                IF NewConsolidatedPayment(lGenJournalLine) THEN BEGIN
                    ExportTransactionInformationAlgeria_V3(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                END ELSE
                    UpdateConsolidatedPayment(lGenJournalLine);

                IF NewPaymentGroup THEN
                    ExportPaymentInformationAlgeria_V3(CstmrCdtTrfInitnNode, lGenJournalLine);
            UNTIL lGenJournalLine.NEXT = 0;

        IF NOT EmptyConsolidatedPayment THEN
            ExportTransactionInformationAlgeria_V3(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

        FinishGroupHeaderAlgeria_V3;

        IF DATE2DMY(TODAY, 2) < 10 THEN
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + '0' + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>')
        ELSE
            TodayString := FORMAT(DATE2DMY(TODAY, 3)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 1)) +
                              FORMAT(TIME, 0, '<hours24><minutes,2><seconds,2>');

        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);

        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        InStr.ReadText(XMLText);
        XMLText := DelStr(XMLText, StrPos(XMLText, 'standalone=" "'), StrLen('standalone=" "'));

        c := 1;
        cString := 'C0001';
        While NOT InStr.EOS DO BEGIN
            if c <> 1 then
                InStr.READTEXT(XMLText);
            i := StrLen(XMLText);
            k := i div 80;
            k1 := i mod 80;
            k3 := 1;

            if k1 <> 0 then begin
                k3 := 1;
                for j := 1 to k + 1 do begin

                    txtOneLine := CopyStr(XMLText, k3, 80);
                    k3 += 80;

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';

                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;

            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN
                    txtOneLine := CopyStr(XMLText, k3, 80);

                    TxtToAddInComponent := txtOneLine;

                    Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8" ?>');
                    if Pos <> 0 then
                        TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';
                    XMlns := strpos(TxtToAddInComponent, '<CstmrCdtTrfInitn xmlns="">');
                    if XMlns <> 0 then
                        TxtToAddInComponent := '<CstmrCdtTrfInitn>';

                    InsertInterfaceComponentLine(
                        InterfaceEntryComponent,
                        InterfaceEntryLine,
                        cString,
                        TxtToAddInComponent);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;
        end;

        TxtToAddInComponent := ']]>';

        InsertInterfaceComponentLine(
            InterfaceEntryComponent,
            InterfaceEntryLine,
            cString,
            TxtToAddInComponent);

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.DeleteAll();

        lGenJournalLine81.Reset();
        lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine81.SetFilter("Parent Line No. FND", '=%1', 0);
        lGenJournalLine81.ModifyAll("WS Posting Allowed FND", true);

        exit(XMLText);

    end;
    //BC UPGRADE KUMARR78 >> Rewriting CreateNonSepaContentAlgeria_V3 Function.
    local procedure ValidatePaymentContentAlgeria_V3(GenJournalLine: Record "Gen. Journal Line BC FND"): Text;
    var
        // TempBlob: Record "99008535" temporary; //BC UPGRADE KUMARR78 Blocking
        lNonSepaContent: Text;
        OutStr: OutStream;
        inStr: InStream;
        MyText: Text;
        //BC UPGRADE KUMARR78 >> Blocking
        // XMLDOMManagement: Codeunit "6224";
        // XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking
        BigText: BigText;
        XMLText: Text;
        filRead: File;
        intLen: Integer;
        txtOneLine: Text;
        txtFromFile: Text;
        TodayString: Text;
        FileName1: Text;
        InStream: InStream;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        TxtToAddInComponent: Text[80];
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        c: Integer;
        cString: Text;
        NewPaymentGroup: Boolean;
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        Pos: Integer;
        lGenJournalLine81: Record "Gen. Journal Line";
        lVendor: Record Vendor;
        lCountryRegion: Record "Country/Region";
        lText001: Label 'Company Information Address or Company Information Address 2 must have a value!';
        lText002: Label 'Company Information Post Code or Company Information City must have a value!';
        lBankAccount: Record "Bank Account";
        lCurrency: Record Currency;
        lVendorBankAccount: Record "Vendor Bank Account";
        lText003: Label 'Vendor Address or Vendor Address 2 must have a value for vendor %1!';
        lText004: Label 'Vendor Post Code or Vendor City must have a value for vendor %1!';
        lText005: Label 'Field %1 cannot be empty for %2 %3!';
        lText006: Label 'Field %1 cannot be empty in %2!';
        lText007: Label 'Field %1 cannot be empty for %2 %3 Vendor %4!';
        lText008: Label 'Algeria Bank Routing Code cannot be empty for %2 %3 Vendor %4!';
        lText009: Label 'HNK Bank Account No %1 should always be of %2 Character';
        lText010: Label 'Backdated File is not acceptable by Bank so please check Posting date on all lines and try again.';
        lText011: Label 'Vendor Bank Account No %1 of Vendor %2 should always be of %3 Character';
        lText012: Label 'Vendor Bank Branch No %1 of Vendor %2 should always be of %3 Character';
    begin
        //HEI.29>>
        CompanyInfo.GET;

        lGenJournalLine.RESET;
        lGenJournalLine.SETRANGE("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SETRANGE("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SETFILTER("Parent Line No.", '=%1', 0);

        IF lGenJournalLine.FINDSET(FALSE) THEN
            REPEAT
                //HEI.31>>
                //IF lGenJournalLine."Posting Date" < TODAY THEN
                //  ERROR(lText010);
                //HEI.31<<
                IF (lGenJournalLine."HNK Bank Account" = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("HNK Bank Account"), lGenJournalLine81.TABLECAPTION);
                IF (lGenJournalLine."Document No." = '') THEN
                    ERROR(lText006, lGenJournalLine.FIELDCAPTION("Document No."), lGenJournalLine81.TABLECAPTION);
                //IF (lGenJournalLine."Message to Recipient" = '') THEN //HEI.33
                //ERROR(lText006,lGenJournalLine.FIELDCAPTION("Message to Recipient"),lGenJournalLine81.TABLECAPTION); //HEI.33

                IF lVendor.GET(lGenJournalLine."Account No.") THEN BEGIN
                    IF (lVendor.Name = '') THEN
                        ERROR(lText005, lVendor.FIELDCAPTION(Name), lVendor.TABLECAPTION, lVendor."No.");
                END;

                IF lBankAccount.GET(lGenJournalLine."HNK Bank Account") THEN BEGIN
                    IF (lBankAccount."SWIFT Code" = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("SWIFT Code"), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");

                    IF (lBankAccount."Bank Account No." = '') THEN
                        ERROR(lText005, lBankAccount.FIELDCAPTION("Bank Account No."), lBankAccount.TABLECAPTION, lGenJournalLine."HNK Bank Account");

                    IF BankExportImportSetup."Debtor Bank Acc. Char FND" <> 0 THEN
                        IF STRLEN(lBankAccount."Bank Account No.") <> BankExportImportSetup."Debtor Bank Acc. Char FND" THEN
                            ERROR(lText009, lBankAccount."Bank Account No.", BankExportImportSetup."Debtor Bank Acc. Char FND");
                END;
                IF lVendorBankAccount.GET(lGenJournalLine."Account No.", lGenJournalLine."Customer/Vendor Bank") THEN BEGIN
                    IF (lVendorBankAccount.Name = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION(Name), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    IF (lVendorBankAccount."Bank Account No." = '') THEN
                        ERROR(lText007, lVendorBankAccount.FIELDCAPTION("Bank Account No."), lVendorBankAccount.TABLECAPTION, lVendorBankAccount.Code, lGenJournalLine."Account No.");

                    IF BankExportImportSetup."Creditor Bank Acc. Char FND" <> 0 THEN
                        IF STRLEN(lVendorBankAccount."Bank Account No.") <> BankExportImportSetup."Creditor Bank Acc. Char FND" THEN
                            ERROR(lText011, lVendorBankAccount.Code, lVendorBankAccount."Vendor No.", BankExportImportSetup."Creditor Bank Acc. Char FND");


                    /* IF (lVendorBankAccount."Bank Branch No." = '') THEN
                       ERROR(lText007,lVendorBankAccount.FIELDCAPTION("Bank Branch No."),lVendorBankAccount.TABLECAPTION,lVendorBankAccount.Code,lGenJournalLine."Account No.");

                     IF BankExportImportSetup."Creditor Bank Branch Char" <> 0 THEN
                       IF STRLEN(lVendorBankAccount."Bank Branch No.")<> BankExportImportSetup."Creditor Bank Branch Char" THEN
                           ERROR(lText012,lVendorBankAccount."Bank Branch No.",lVendorBankAccount."Vendor No.",BankExportImportSetup."Creditor Bank Branch Char");*/

                END;
            UNTIL lGenJournalLine.NEXT = 0;
        //HEI.29<<

    end;

    // //BC UPGRADE KUMARR78 >> Blocking ExportTransactionInformationAlgeria_V3 Function
    //     local procedure ExportTransactionInformationAlgeria_V3(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    //     var
    //         GLSetup: Record "98";
    //         AddressLine1: Text[140];
    //         AddressLine2: Text[140];
    //         ISOCurrCode: Text[3];
    //         IBANTransfer: Boolean;
    //         VendorBankAccount: Record "288";
    //         BeneficiaryIBAN: Code[50];
    //         CustomerBankAccount: Record "287";
    //         BeneficiaryBankAccountNo: Code[30];
    //         XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //         RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //         CustBankAcc: Record "287";
    //         VendBankAcc: Record "288";
    //         lSWIFTCode: Code[20];
    //         lBeneficiaryBankAccount: Code[30];
    //         lCust: Record "18";
    //         lVend: Record "23";
    //         CountryIBANCountryRegion: Boolean;
    //         lNewAmountText: Text;
    //         lBankExportImportSetup: Record "1200";
    //         lPosition: Integer;
    //         lCurrency: Record "4";
    //         BICICIABPos: Integer;
    //         CI93Pos: Integer;
    //         lPrtLctnValue: Text[10];
    //         lVend2: Record "23";
    //         lMmbId: Text[20];
    //         lIsDomesticTransfer: Boolean;
    //         lIsIntermediaryBank: Boolean;
    //         lSWIFTCodeIntermediaryBank: Code[20];
    //         lIsEURPayment: Boolean;
    //         lPmtJnlLine: Record "81";
    //         lPurchInvHeader: Record "122";
    //         lTotalExtDocNo: Text;
    //         lVendInvNo: Text;
    //         lText50000: Label '"INVOICE "';
    //         FirstFound: Boolean;
    //         PaymentInvoiceTxt: Text;
    //     begin
    //         //HEI.29>>
    //         WITH PmtJnlLine DO BEGIN
    //             GLSetup.GET;
    //             RootNode := XMLNodeCurr;
    //             NumberOfTransactions += 1;

    //             lIsEURPayment := FALSE;

    //             AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;

    //             AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;

    //             AddElement(XMLNodeCurr, 'EndToEndId', CutText(PmtJnlLine."Document No.", 16), '', XMLNewChild);
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;


    //             AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'CtgyPurp', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'Cd', 'SUPP', '', XMLNewChild);
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;

    //             AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;

    //             //AddElement(XMLNodeCurr,'InstdAmt',FORMAT(Amount,0,9),'',XMLNewChild);
    //             IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //                 lNewAmountText := FORMAT(Amount, 0, 9);
    //                 IF PmtJnlLine."Currency Code" <> '' THEN
    //                     IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                         IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                             lNewAmountText := FORMAT(Amount, 0, 9);
    //                             lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                             lPosition := STRPOS(lNewAmountText, '.');
    //                             IF lPosition <> 0 THEN
    //                                 lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                         END;
    //             END;

    //             IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //                 lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                 IF PmtJnlLine."Currency Code" <> '' THEN
    //                     IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                         IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
    //                             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                             lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                             lPosition := STRPOS(lNewAmountText, '.');
    //                             IF lPosition <> 0 THEN
    //                                 lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                         END;
    //             END;


    //             IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //                 IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                     lBankExportImportSetup.RESET;
    //                     lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                     lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                     lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                     IF lBankExportImportSetup.FINDFIRST THEN
    //                         IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                             lNewAmountText := FORMAT(Amount, 0, 9);
    //                             lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                             lPosition := STRPOS(lNewAmountText, '.');
    //                             IF lPosition <> 0 THEN
    //                                 lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                         END;
    //                 END;

    //             IF GeneralLedgerSetup."Enable WHT" THEN
    //                 IF PmtJnlLine."Currency Code" = '' THEN BEGIN
    //                     lBankExportImportSetup.RESET;
    //                     lBankExportImportSetup.SETRANGE("Journal Template Name", "Journal Template Name");
    //                     lBankExportImportSetup.SETRANGE("Journal Batch Name", "Journal Batch Name");
    //                     lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
    //                     IF lBankExportImportSetup.FINDFIRST THEN
    //                         IF lBankExportImportSetup."BC (LCY) - Send Without Dec." = TRUE THEN BEGIN
    //                             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                             lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                             lPosition := STRPOS(lNewAmountText, '.');
    //                             IF lPosition <> 0 THEN
    //                                 lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                         END;
    //                 END;

    //             AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);

    //             IF "Currency Code" = '' THEN
    //                 //ISOCurrCode := COPYSTR(GLSetup."LCY Code",1,3) //23.11.2022
    //                 ISOCurrCode := 'DZD' //23.11.2022
    //             ELSE BEGIN
    //                 GetCurrency("Currency Code");
    //                 ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
    //             END;
    //             AddAttribute(XMLDomDoc, XMLNewChild, 'Ccy', ISOCurrCode);
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;


    //             IF ("Customer/Vendor Bank" <> '') THEN
    //                 CASE "Account Type" OF
    //                     "Account Type"::Customer:
    //                         BEGIN
    //                             lCust.GET("Account No.");
    //                             CustBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                             lSWIFTCode := CustBankAcc."SWIFT Code";
    //                             lBeneficiaryBankAccount := CustBankAcc.Code;
    //                         END;
    //                     "Account Type"::Vendor:
    //                         BEGIN
    //                             lVend.GET("Account No.");
    //                             VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                             lSWIFTCode := VendBankAcc."SWIFT Code";
    //                             lBeneficiaryBankAccount := VendBankAcc.Code;
    //                         END;
    //                 END
    //             ELSE BEGIN
    //                 lSWIFTCode := '';
    //                 lBeneficiaryBankAccount := '';
    //             END;

    //             lVend2.RESET;
    //             IF "Account Type" = "Account Type"::Vendor THEN
    //                 IF lVend2.GET("Account No.") THEN;


    //             lIsDomesticTransfer := FALSE;
    //             IF ("Account Type" = "Account Type"::Vendor) THEN BEGIN
    //                 GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);

    //             END;

    //             AddElement(XMLNodeCurr, 'ChrgBr', 'DEBT', '', XMLNewChild);

    //             lSWIFTCodeIntermediaryBank := '';

    //             IF VendorBankAcc."Interm. Bank BIC/SWIFT Code" <> '' THEN BEGIN

    //                 lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Code";
    //             END;

    //             AddElement(XMLNodeCurr, 'CdtrAgt', '', '', XMLNewChild);//rrr
    //             XMLNodeCurr := XMLNewChild;

    //             AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;

    //             CASE "Account Type" OF
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         GetVendorBankAccount("Account No.", lBeneficiaryBankAccount);
    //                         AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         lMmbId := '';

    //                         IF BankExportImportSetup."Creditor Bank Branch Char" <> 0 THEN
    //                             lMmbId := COPYSTR(VendorBankAcc."Bank Account No.", 1, BankExportImportSetup."Creditor Bank Branch Char")
    //                         ELSE
    //                             lMmbId := VendorBankAcc."Bank Branch No.";

    //                         AddElement(XMLNodeCurr, 'MmbId', lMmbId, '', XMLNewChild);
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //                         AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         GetVendor("Account No.");
    //                         Vendor.Name := ReplaceTextCharacters(Vendor.Name);
    //                         AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
    //                         AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //                         XMLNodeCurr := XMLNewChild;

    //                         GetCountry(Vendor."Country/Region Code");

    //                         Vendor.Address := ReplaceTextCharacters(Vendor.Address);
    //                         Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
    //                         //HEI.35>>
    //                         CLEAR(AddressLine1);
    //                         IF DELCHR(Vendor.Address, '<>') <> '' THEN
    //                             AddressLine1 := DELCHR(Vendor.Address, '<>');

    //                         IF DELCHR(Vendor."Address 2", '<>') <> '' THEN BEGIN
    //                             IF AddressLine1 <> '' THEN
    //                                 AddressLine1 += ' ' + DELCHR(Vendor."Address 2", '<>')
    //                             ELSE
    //                                 AddressLine1 := DELCHR(Vendor."Address 2", '<>');
    //                         END;
    //                         //AddressLine1 := DELCHR(Vendor.Address,'<>')+ ' '+ DELCHR(Vendor."Address 2",'<>');
    //                         //HEI.35<<
    //                         IF Country."ISO Country/Region Code" <> '' THEN
    //                             AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //                         ELSE
    //                             AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

    //                         IF (STRLEN(AddressLine1) <= 35) AND (STRLEN(AddressLine1) > 1) THEN
    //                             AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

    //                         IF (STRLEN(AddressLine1) > 35) THEN BEGIN
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //                         END;

    //                         Vendor.City := ReplaceTextCharacters(Vendor.City);
    //                         Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
    //                         AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');

    //                         IF (STRLEN(AddressLine2) > 1) THEN
    //                             AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //                         XMLNodeCurr := XMLNodeCurr.ParentNode;
    //                     END;
    //             END;
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;

    //             AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;

    //             AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;

    //             IF ("Customer/Vendor Bank" <> '') THEN
    //                 CASE "Account Type" OF
    //                     "Account Type"::Vendor:
    //                         BEGIN
    //                             VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                             BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                             BeneficiaryIBAN := VendBankAcc.IBAN;
    //                             GetCountry(VendBankAcc."Country/Region Code");
    //                         END;
    //                 END
    //             ELSE BEGIN
    //                 BeneficiaryBankAccountNo := '';
    //                 BeneficiaryIBAN := '';
    //                 Country."IBAN Country/Region" := FALSE;
    //             END;


    //             AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             AddElement(XMLNodeCurr, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);

    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;
    //             XMLNodeCurr := XMLNodeCurr.ParentNode;

    //             AddElement(XMLNodeCurr, 'RmtInf', '', '', XMLNewChild);
    //             XMLNodeCurr := XMLNewChild;
    //             FirstFound := TRUE; //HEI.33
    //             lTotalExtDocNo := '';
    //             lPmtJnlLine.RESET;
    //             lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
    //             lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
    //             lPmtJnlLine.SETRANGE("Parent Line No.", PmtJnlLine."Line No.");
    //             IF lPmtJnlLine.FINDSET(FALSE, FALSE) THEN
    //                 REPEAT
    //                     PaymentInvoiceTxt := ''; //HEI.33
    //                     IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
    //                         IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
    //                             //HEI.33>>
    //                             PaymentInvoiceTxt := ReplaceTextCharacters(lPurchInvHeader."Vendor Invoice No.");
    //                             IF FirstFound THEN BEGIN
    //                                 IF STRLEN(PaymentInvoiceTxt) < 27 THEN
    //                                     lTotalExtDocNo := lText50000 + PaymentInvoiceTxt
    //                                 ELSE
    //                                     lTotalExtDocNo := PaymentInvoiceTxt;
    //                             END ELSE
    //                                 lTotalExtDocNo += ',' + PaymentInvoiceTxt;

    //                             FirstFound := FALSE;
    //                             /*IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
    //                               lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.",STRLEN(lPurchInvHeader."Vendor Invoice No.")-8,9)
    //                               ELSE
    //                                 lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
    //                             lTotalExtDocNo += lVendInvNo+',';*/
    //                             //HEI.33<<
    //                         END;
    //                 UNTIL lPmtJnlLine.NEXT = 0;
    //             IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
    //                 //lTotalExtDocNo := COPYSTR(lTotalExtDocNo,1,STRLEN(lTotalExtDocNo)-1); //HEI.33
    //                 //lTotalExtDocNo := lText50000 + lTotalExtDocNo; //HEI.33
    //                 lTotalExtDocNo := ReplaceTextCharacters(lTotalExtDocNo); //HEI.32
    //                 PaymentMessage := ReplaceTextCharacters(PaymentMessage); //HEI.32
    //                 IF (STRLEN(lTotalExtDocNo) <= 35) THEN
    //                     AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
    //                 IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
    //                     AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                 END;
    //                 IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
    //                     AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //                 END;
    //                 IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
    //                     AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
    //                     AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
    //                 END;
    //             END
    //             ELSE
    //                 AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(PaymentMessage, 1, 35), '', XMLNewChild); //HEI.33
    //                                                                                                    //AddElement(XMLNodeCurr,'Ustrd',PaymentMessage,'',XMLNewChild); //HEI.33

    //             XMLNodeCurr := RootNode;
    //         END;
    //         //HEI.29<<

    //     end;
    //     //BC UPGRADE KUMARR78 >> Blocking ExportTransactionInformationAlgeria_V3 Function

    //BC UPGRADE KUMARR78 >> Blocking ExportTransactionInformationAlgeria_V3 Function
    local procedure ExportTransactionInformationAlgeria_V3(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);
    var
        GLSetup: Record "General Ledger Setup";
        AddressLine1: Text[140];
        AddressLine2: Text[140];
        ISOCurrCode: Text[3];
        IBANTransfer: Boolean;
        VendorBankAccount: Record "Vendor Bank Account";
        BeneficiaryIBAN: Code[50];
        CustomerBankAccount: Record "Customer Bank Account";
        BeneficiaryBankAccountNo: Code[30];
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        lSWIFTCode: Code[20];
        lBeneficiaryBankAccount: Code[30];
        lCust: Record Customer;
        lVend: Record Vendor;
        CountryIBANCountryRegion: Boolean;
        lNewAmountText: Text;
        lBankExportImportSetup: Record "Bank Export/Import Setup";
        lPosition: Integer;
        lCurrency: Record Currency;
        BICICIABPos: Integer;
        CI93Pos: Integer;
        lPrtLctnValue: Text[10];
        lVend2: Record Vendor;
        lMmbId: Text[20];
        lIsDomesticTransfer: Boolean;
        lIsIntermediaryBank: Boolean;
        lSWIFTCodeIntermediaryBank: Code[20];
        lIsEURPayment: Boolean;
        lPmtJnlLine: Record "Gen. Journal Line";
        lPurchInvHeader: Record "Purch. Inv. Header";
        lTotalExtDocNo: Text;
        lVendInvNo: Text;
        lText50000: Label '"INVOICE "';
        FirstFound: Boolean;
        PaymentInvoiceTxt: Text;
        CdtrAcctNode: XmlNode;
        CdtrNode: XmlNode;
        CdtTrfTxInfNode: XmlNode;
        IdNode: XmlNode;
        PmtIdNode: XmlNode;
        PstlAdrNode: XmlNode;
        RmtInfNode: XmlNode;
        RootNode: XmlNode;
        XMLNewChild: XmlNode;
        AmtNode: XmlNode;
        FinInstNode: xmlnode;
        CdtrAgtNode: xmlnode;
    begin
        //HEI.29>>
        GLSetup.GET;
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;

        lIsEURPayment := FALSE;
        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNodeCurr);
        AddElement(XMLNodeCurr, 'PmtId', '', '', PmtIdNode);
        AddElement(PmtIdNode, 'EndToEndId', CutText(PmtJnlLine."Document No.", 16), '', XMLNewChild);
        AddElement(XMLNewChild, 'PmtTpInf', '', '', XMLNewChild);
        AddElement(XMLNodeCurr, 'CtgyPurp', '', '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Cd', 'SUPP', '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Amt', '', '', AmtNode);
        XMLNodeCurr := XMLNewChild;
        //AddElement(XMLNodeCurr,'InstdAmt',FORMAT(Amount,0,9),'',XMLNewChild);
        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN BEGIN
            lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
            IF PmtJnlLine."Currency Code" <> '' THEN
                IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
                    IF lCurrency."BC - Send Without Decimals FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
        END;


        IF NOT GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount, 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        IF GeneralLedgerSetup."Enable WHT FND" THEN
            IF PmtJnlLine."Currency Code" = '' THEN BEGIN
                lBankExportImportSetup.RESET;
                lBankExportImportSetup.SETRANGE("Journal Template Name FND", PmtJnlLine."Journal Template Name");
                lBankExportImportSetup.SETRANGE("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
                lBankExportImportSetup.SETRANGE("Processing Codeunit ID", CODEUNIT::"Bank Conn. Interface Mgt.");
                IF lBankExportImportSetup.FINDFIRST THEN
                    IF lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = TRUE THEN BEGIN
                        lNewAmountText := FORMAT(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);
                        lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
                        lPosition := STRPOS(lNewAmountText, '.');
                        IF lPosition <> 0 THEN
                            lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
                    END;
            END;

        AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);

        IF PmtJnlLine."Currency Code" = '' THEN
            //ISOCurrCode := COPYSTR(GLSetup."LCY Code",1,3) //23.11.2022
            ISOCurrCode := 'DZD'
            //23.11.2022
        ELSE BEGIN
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := COPYSTR(Currency."ISO Currency Code FND", 1, 3);
        END;
        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Customer:
                    BEGIN
                        lCust.GET(PmtJnlLine."Account No.");
                        CustBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    END;
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        lVend.GET(PmtJnlLine."Account No.");
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    END;
            END
        ELSE BEGIN
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        END;

        lVend2.RESET;
        IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN
            IF lVend2.GET(PmtJnlLine."Account No.") THEN;


        lIsDomesticTransfer := FALSE;
        IF (PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor) THEN BEGIN
            GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);

        END;

        AddElement(XMLNodeCurr, 'ChrgBr', 'DEBT', '', XMLNewChild);
        lSWIFTCodeIntermediaryBank := '';

        IF VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND" <> '' THEN BEGIN

            lSWIFTCodeIntermediaryBank := VendorBankAcc."Interm. Bank BIC/SWIFT Cod FND";

        END;

        AddElement(XMLNodeCurr, 'CdtrAgt', '', '', CdtrAgtNode);
        AddElement(CdtrAgtNode, 'FinInstnId', '', '', FinInstNode);

        CASE PmtJnlLine."Account Type" OF
            PmtJnlLine."Account Type"::Vendor:
                BEGIN
                    GetVendorBankAccount(PmtJnlLine."Account No.", lBeneficiaryBankAccount);
                    AddElement(XMLNodeCurr, 'ClrSysMmbId', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    lMmbId := '';

                    IF BankExportImportSetup."Creditor Bank Branch Char FND" <> 0 THEN
                        lMmbId := COPYSTR(VendorBankAcc."Bank Account No.", 1, BankExportImportSetup."Creditor Bank Branch Char FND")
                    ELSE
                        lMmbId := VendorBankAcc."Bank Branch No.";

                    AddElement(XMLNodeCurr, 'MmbId', lMmbId, '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'Cdtr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetVendor(PmtJnlLine."Account No.");
                    Vendor.Name := ReplaceTextCharacters(Vendor.Name);
                    AddElement(XMLNodeCurr, 'Nm', COPYSTR(Vendor.Name, 1, 70), '', XMLNewChild);
                    AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
                    XMLNodeCurr := XMLNewChild;

                    GetCountry(Vendor."Country/Region Code");

                    Vendor.Address := ReplaceTextCharacters(Vendor.Address);
                    Vendor."Address 2" := ReplaceTextCharacters(Vendor."Address 2");
                    //HEI.35>>
                    CLEAR(AddressLine1);
                    IF DELCHR(Vendor.Address, '<>') <> '' THEN
                        AddressLine1 := DELCHR(Vendor.Address, '<>');

                    IF DELCHR(Vendor."Address 2", '<>') <> '' THEN BEGIN
                        IF AddressLine1 <> '' THEN
                            AddressLine1 += ' ' + DELCHR(Vendor."Address 2", '<>')
                        ELSE
                            AddressLine1 := DELCHR(Vendor."Address 2", '<>');
                    END;
                    //AddressLine1 := DELCHR(Vendor.Address,'<>')+ ' '+ DELCHR(Vendor."Address 2",'<>');
                    //HEI.35<<
                    IF Country."ISO Country/Region Code FND" <> '' THEN
                        AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
                    ELSE
                        AddElement(XMLNodeCurr, 'Ctry', Country.Code, '', XMLNewChild);

                    IF (STRLEN(AddressLine1) <= 35) AND (STRLEN(AddressLine1) > 1) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

                    IF (STRLEN(AddressLine1) > 35) THEN BEGIN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
                    END;

                    Vendor.City := ReplaceTextCharacters(Vendor.City);
                    Vendor."Post Code" := ReplaceTextCharacters(Vendor."Post Code");
                    AddressLine2 := DELCHR(Vendor."Post Code", '<>') + ' ' + DELCHR(Vendor.City, '<>');

                    IF (STRLEN(AddressLine2) > 1) THEN
                        AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);
                END;
        END;
        AddElement(XMLNodeCurr, 'CdtrAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF (PmtJnlLine."Customer/Vendor Bank" <> '') THEN
            CASE PmtJnlLine."Account Type" OF
                PmtJnlLine."Account Type"::Vendor:
                    BEGIN
                        VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");
                    END;
            END
        ELSE BEGIN
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := FALSE;
        END;
        AddElement(IdNode, 'Othr', '', '', XMLNewChild);
        AddElement(XMLNewChild, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'RmtInf', '', '', RmtInfNode);
        XMLNodeCurr := XMLNewChild;
        FirstFound := TRUE;
        //HEI.33
        lTotalExtDocNo := '';
        lPmtJnlLine.RESET;
        lPmtJnlLine.SETRANGE("Journal Template Name", PmtJnlLine."Journal Template Name");
        lPmtJnlLine.SETRANGE("Journal Batch Name", PmtJnlLine."Journal Batch Name");
        lPmtJnlLine.SETRANGE("Parent Line No. FND", PmtJnlLine."Line No.");
        IF lPmtJnlLine.FINDSET(FALSE) THEN
            REPEAT
                PaymentInvoiceTxt := '';
                //HEI.33
                IF lPurchInvHeader.GET(lPmtJnlLine."Applies-to Doc. No.") THEN
                    IF lPurchInvHeader."Vendor Invoice No." <> '' THEN BEGIN
                        //HEI.33>>
                        PaymentInvoiceTxt := ReplaceTextCharacters(lPurchInvHeader."Vendor Invoice No.");
                        IF FirstFound THEN BEGIN
                            IF STRLEN(PaymentInvoiceTxt) < 27 THEN
                                lTotalExtDocNo := lText50000 + PaymentInvoiceTxt
                            ELSE
                                lTotalExtDocNo := PaymentInvoiceTxt;
                        END ELSE
                            lTotalExtDocNo += ',' + PaymentInvoiceTxt;

                        FirstFound := FALSE;
                        /*IF STRLEN(lPurchInvHeader."Vendor Invoice No.") > 9 THEN
                          lVendInvNo := COPYSTR(lPurchInvHeader."Vendor Invoice No.",STRLEN(lPurchInvHeader."Vendor Invoice No.")-8,9)
                          ELSE
                            lVendInvNo := lPurchInvHeader."Vendor Invoice No.";
                        lTotalExtDocNo += lVendInvNo+',';*/
                        //HEI.33<<
                    END;
            UNTIL lPmtJnlLine.NEXT = 0;
        IF (STRLEN(lTotalExtDocNo) <> 0) THEN BEGIN
            //lTotalExtDocNo := COPYSTR(lTotalExtDocNo,1,STRLEN(lTotalExtDocNo)-1); //HEI.33
            //lTotalExtDocNo := lText50000 + lTotalExtDocNo; //HEI.33
            lTotalExtDocNo := ReplaceTextCharacters(lTotalExtDocNo);
            //HEI.32
            PaymentMessage := ReplaceTextCharacters(PaymentMessage);
            //HEI.32
            IF (STRLEN(lTotalExtDocNo) <= 35) THEN
                AddElement(XMLNodeCurr, 'Ustrd', lTotalExtDocNo, '', XMLNewChild);
            IF ((STRLEN(lTotalExtDocNo) > 35) AND (STRLEN(lTotalExtDocNo) <= 70)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 70) AND (STRLEN(lTotalExtDocNo) <= 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
            END;
            IF ((STRLEN(lTotalExtDocNo) > 105)) THEN BEGIN
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 1, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 36, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 71, 35), '', XMLNewChild);
                AddElement(XMLNodeCurr, 'Ustrd', COPYSTR(lTotalExtDocNo, 106, 35), '', XMLNewChild);
            END;
        END
        ELSE
            AddElement(RmtInfNode, 'Ustrd', CopyStr(PaymentMessage, 1, 70), '', XMLNewChild);
        XMLNodeCurr := RootNode;
    end;
    //BC UPGRADE KUMARR78 << Rewritin ExportTransactionInformationAlgeria_V3 Function

    // //BC UPGRADE KUMARR78 >> Blocking ExportTransactionInformationAlgeria_V3 Function

    // local procedure ExportPaymentInformationAlgeria_V3(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     AddressLine1: Text[140];
    //     AddressLine2: Text[140];
    //     InstructionPriority: Text[10];
    //     ChargeBearer: Text[4];
    //     BICICIABPos: Integer;
    //     lVendor: Record "23";
    //     VendBankAcc: Record "288";
    //     BeneficiaryBankAccountNo: Text[30];
    //     lIsEURPayment: Boolean;
    //     PaymentMethod: Record "289";
    // begin
    //     //HEI.29>>
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;


    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);

    //     IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN BEGIN
    //         IF lVendor.GET(PmtJnlLine."Account No.") THEN BEGIN
    //             IF PaymentMethod.GET(PmtJnlLine."Payment Method Code") THEN
    //                 AddElement(XMLNodeCurr, 'PmtMtd', PaymentMethod."Bank Cnctvty Pmt. Method FND", '', XMLNewChild)
    //             ELSE
    //                 AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);
    //         END;
    //     END
    //     ELSE
    //         AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'SvcLvl', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Cd', 'NURG', '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     IF PmtJnlLine."HNK Bank Account" <> '' THEN
    //         GetBankAccount(PmtJnlLine."HNK Bank Account");
    //     BankAcc.GET(PmtJnlLine."HNK Bank Account");
    //     BankAcc.Name := ReplaceTextCharacters(BankAcc.Name);
    //     AddElement(XMLNodeCurr, 'Nm', COPYSTR(BankAcc.Name, 1, 70), '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetCountry(BankAcc."Country/Region Code");
    //     IF Country."ISO Country/Region Code" <> '' THEN
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild)
    //     ELSE
    //         AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAcc."Country/Region Code", 1, 2), '', XMLNewChild);

    //     AddressLine1 := DELCHR(BankAcc.Address, '<>') + ' ' + DELCHR(BankAcc."Address 2", '<>');
    //     AddressLine1 := ReplaceTextCharacters(AddressLine1);

    //     IF (STRLEN(AddressLine1) <= 35) AND (STRLEN(AddressLine1) > 1) THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

    //     IF (STRLEN(AddressLine1) > 35) THEN BEGIN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
    //     END;

    //     AddressLine2 := DELCHR(BankAcc."Post Code", '<>') + ' ' + DELCHR(BankAcc.City, '<>');
    //     AddressLine2 := ReplaceTextCharacters(AddressLine2);

    //     IF (STRLEN(AddressLine2) > 1) THEN
    //         AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;


    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");

    //     BeneficiaryBankAccountNo := '';
    //     IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
    //         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

    //     AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;


    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     XMLNodeCurr := RootNode;
    //     //HEI.29<<
    // end;
    // //BC UPGRADE KUMARR78 >> Blocking ExportTransactionInformationAlgeria_V3 Function

    //BC UPGRADE KUMARR78 << Rewriting ExportPaymentInformationAlgeria_V3 Function
    local procedure ExportPaymentInformationAlgeria_V3(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND");
    var
        XMLNewChild: XmlNode;
        RootNode: XmlNode;
        AddressLine1: Text[140];
        AddressLine2: Text[140];
        InstructionPriority: Text[10];
        ChargeBearer: Text[4];
        BICICIABPos: Integer;
        lVendor: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        BeneficiaryBankAccountNo: Text[30];
        lIsEURPayment: Boolean;
        PaymentMethod: Record "Payment Method";
    begin
        //HEI.29>>
        RootNode := XMLNodeCurr;
        PaymentInformationCounter := PaymentInformationCounter + 1;
        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        PmtInfNode := XMLNodeCurr;


        AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + FORMAT(PaymentInformationCounter), '', XMLNewChild);

        IF PmtJnlLine."Account Type" = PmtJnlLine."Account Type"::Vendor THEN BEGIN
            IF lVendor.GET(PmtJnlLine."Account No.") THEN BEGIN
                IF PaymentMethod.GET(PmtJnlLine."Payment Method Code") THEN
                    AddElement(XMLNodeCurr, 'PmtMtd', PaymentMethod."Bank Cnctvty Pmt. Method FND", '', XMLNewChild)
                ELSE
                    AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);
            END;
        END
        ELSE
            AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);

        AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'SvcLvl', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Cd', 'NURG', '', XMLNewChild);
        AddElement(XMLNodeCurr, 'ReqdExctnDt', FORMAT(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
        AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        IF PmtJnlLine."HNK Bank Account" <> '' THEN
            GetBankAccount(PmtJnlLine."HNK Bank Account");
        BankAcc.GET(PmtJnlLine."HNK Bank Account");
        BankAcc.Name := ReplaceTextCharacters(BankAcc.Name);
        AddElement(XMLNodeCurr, 'Nm', COPYSTR(BankAcc.Name, 1, 70), '', XMLNewChild);

        AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        GetCountry(BankAcc."Country/Region Code");
        IF Country."ISO Country/Region Code FND" <> '' THEN
            AddElement(XMLNodeCurr, 'Ctry', COPYSTR(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild)
        ELSE
            AddElement(XMLNodeCurr, 'Ctry', COPYSTR(BankAcc."Country/Region Code", 1, 2), '', XMLNewChild);

        AddressLine1 := DELCHR(BankAcc.Address, '<>') + ' ' + DELCHR(BankAcc."Address 2", '<>');
        AddressLine1 := ReplaceTextCharacters(AddressLine1);

        IF (STRLEN(AddressLine1) <= 35) AND (STRLEN(AddressLine1) > 1) THEN
            AddElement(XMLNodeCurr, 'AdrLine', AddressLine1, '', XMLNewChild);

        IF (STRLEN(AddressLine1) > 35) THEN BEGIN
            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 1, 35), '', XMLNewChild);
            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine1, 36, 35), '', XMLNewChild);
        END;

        AddressLine2 := DELCHR(BankAcc."Post Code", '<>') + ' ' + DELCHR(BankAcc.City, '<>');
        AddressLine2 := ReplaceTextCharacters(AddressLine2);

        IF (STRLEN(AddressLine2) > 1) THEN
            AddElement(XMLNodeCurr, 'AdrLine', COPYSTR(AddressLine2, 1, 35), '', XMLNewChild);

        AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        BeneficiaryBankAccountNo := '';
        IF VendBankAcc.GET(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank") THEN
            BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";

        AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;
        AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);

        AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'BIC', COPYSTR(DELCHR(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);

        XMLNodeCurr := RootNode;
        //HEI.29<<
    end;
    //BC UPGRADE KUMARR78 << Rewriting ExportPaymentInformationAlgeria_V3 Function

    //BC UPGRADE KUMARR78 >> Blocking to Replace Code
    // local procedure StartGroupHeaderAlgeria_V3(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // var
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     //HEI.29>>
    //     AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
    //     //HEI.29<<
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Replace Code

    //BC UPGRADE KUMARR78 >> Replacing StartGroupHeaderAlgeria_V3 Code

    local procedure StartGroupHeaderAlgeria_V3(XMLNodeCurr: XmlNode);
    var
        XMLNewChild: XmlNode;
    begin
        //HEI.29>>
        AddElement(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
        AddElement(XMLNodeCurr, 'CreDtTm', FORMAT(CURRENTDATETIME, 19, 9), '', XMLNewChild);
        //HEI.29<<
        //BC UPGRADE ATHUKS01 Added 
        Clear(FinalXmlNode);
        FinalXmlNode := XMLNodeCurr;
        //BC UPGRADE ATHUKS01 Added.
    end;
    //BC UPGRADE KUMARR78 << Replacing StartGroupHeaderAlgeria_V3 Code


    local procedure FinishGroupHeaderAlgeria_V3();
    var
        //BC UPGRADE KUMARR78 >> Blocking to Change Dotnet to XML.
        // XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        //BC UPGRADE KUMARR78 << Blocking to Change Dotnet to XML.

        //BC UPGRADE KUMARR78 >> Adding to Change to XML.
        XMLNodeCurr: XmlNode;
        XMLNewChild: XmlNode;

    //BC UPGRADE KUMARR78 << Adding to Change to XML.

    begin
        //HEI.03>>
        // Insert Number of Transactions and ControlSum in the Group Header
        // XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document'); //BC UPGRADE KUMARR78 Rewriting.
        // XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr); //BC UPGRADE KUMARR78 Rewriting.

        XMLNodeCurr := FinalXmlNode;
        AddElement(XMLNodeCurr, 'NbOfTxs', FORMAT(NumberOfTransactions, 0, 9), '', XMLNewChild);

        AddElement(XMLNodeCurr, 'InitgPty', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElement(XMLNodeCurr, 'Nm', CompanyInfo.Name, '', XMLNewChild);
        AddEnterpriseNo(XMLNodeCurr, CompanyInfo."Enterprise No. FND");
        //HEI.29<<
    end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDoc(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDocLocal(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDocLocal(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDocLocal(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDocLocal(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDocLocal(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;

    //event XMLDomDocLocal(sender : Variant;e : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeChangedEventArgs");
    //begin
    /*
    */
    //end;
}

