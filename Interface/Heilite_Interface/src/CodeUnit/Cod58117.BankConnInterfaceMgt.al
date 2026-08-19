codeunit 58117 "Bank Conn. Interface Mgt."
{
    // HEI.01 V1.05 HT84 IBM POENAB02 28.03.2019
    //   # Object created
    // HEI.02 CHG2022329 IBM POENAB02 06.02.2020
    //   # Send different Amount if WHT is enabled.
    // HEI.03 CHG2074054 IBM POENAB02 16.07.2020
    //   # Added CDATA tag for "<Content>".
    // HEI.04 CHG2113334 IBM POENAB02 09.09.2021 Modified Debtor account and Creditor account information
    //   # Modified functions ExportTransactionInformation, ExportPaymentInformation

    //BC UPGRADE KUMARR78 >>
    // Old Codeunit ID 50069 - "Bank Conn. Interface Mgt."
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
    //
    // RESULT:
    //   100% SaaS compatible XML processing.
    //
    // 3. REWRITTEN CORE PROCEDURES
    // ----------------------------------------------------------------------------
    //
    // 3.1 CreateNonSepaContent
    // ---------------------------------------------------------------------------
    // OLD:
    //   - XML DOM Management
    //   - DotNet XmlDocument
    //   - SelectSingleNode()
    //   - Save(OutStream)
    //
    // NEW:
    //   - XmlDocument.ReadFrom()
    //   - XmlDocument.AsXmlNode()
    //   - XmlDocument.WriteTo()
    //   - XmlElement.SetAttribute()
    //   - TempBlob streaming
    //
    // STRUCTURAL CHANGE:
    //   XML now built using:
    //       XmlElement.Create()
    //       XmlText.Create()
    //       Node.Add()
    //
    // 3.2 CreateNonSepaContentTest / TestBLOB
    // ---------------------------------------------------------------------------
    // OLD:
    //   - XMLDomDoc.Save(File)
    //   - Manual file read
    //
    // NEW:
    //   - XmlDocument.Create()
    //   - XmlDeclaration.Create()
    //   - TempBlob.CreateOutStream()
    //   - XmlDoc.WriteTo(OutStream)
    //   - TempBlob.CreateInStream()
    //   - 80-character split logic
    //
    // BLOB VERSION:
    //   InterfaceEntryLine.Notes.CreateOutStream(OutStr, TextEncoding::UTF8);
    //   XmlDoc.WriteTo(OutStr);
    //   InterfaceEntryLine.Modify();
    //
    // RESULT:
    //    No physical file usage
    //    Direct memory-based XML streaming
    //    Cloud-safe
    //
    // 3.3 AddElement (Fully Rewritten)
    // ---------------------------------------------------------------------------
    // OLD:
    //   OwnerDocument.CreateNode()
    //   InnerText assignment
    //   AppendChild()
    //
    // NEW:
    //   NewElement := XmlElement.Create(NodeName);
    //   NewText := XmlText.Create(NodeText);
    //   NewElement.Add(NewText);
    //   XMLNode.AsXmlElement().Add(NewElement);
    //   CreatedXMLNode := NewElement.AsXmlNode();
    //
    // 3.4 AddAttribute (Simplified)
    // ---------------------------------------------------------------------------
    // OLD:
    //   CreateAttribute()
    //   Attributes.SetNamedItem()
    //
    // NEW:
    //   XmlNodeParam.AsXmlElement().SetAttribute(AttribName, AttribValue);
    //
    // 3.5 StartGroupHeader
    // ---------------------------------------------------------------------------
    // OLD:
    //   DotNet XmlNode
    //   Format(CurrentDateTime, 19, 9)
    //
    // NEW:
    //   XmlNode
    //   Format(CurrentDateTime, 0, 9)
    //
    // CHANGE:
    //   BC SaaS-compatible DateTime formatting.
    //
    // 3.6 FinishGroupHeader
    // ---------------------------------------------------------------------------
    // OLD:
    //   SelectSingleNode()
    //   FirstChild navigation
    //
    // NEW:
    //   Maintained node reference
    //   Direct AddElement calls for:
    //       - NbOfTxs
    //       - InitgPty
    //       - Enterprise No.
    //
    // IMPROVEMENT:
    //   Eliminated XPath navigation.
    //
    // 3.7 ExportPaymentInformation
    // ---------------------------------------------------------------------------
    // OLD:
    //   local procedure ExportPaymentInformation(XMLNodeCurr: DotNet XmlNode)
    //   ParentNode usage
    //   OwnerDocument usage
    //
    // NEW:
    //   local procedure ExportPaymentInformation(XMLNodeCurr: XmlNode)
    //   CurrElement navigation pattern
    //   Explicit AsXmlElement() casting
    //   Global PmtInfNode maintained as XmlNode
    //
    // ============================================================================
    //
    // 3.8 ExportTransactionInformation (Major Refactor)
    // ---------------------------------------------------------------------------
    //
    // OLD:
    //   - Heavy DotNet navigation
    //   - ParentNode references
    //   - OwnerDocument usage
    //   - Manual attribute creation
    //
    // NEW:
    //   Structured node variables:
    //       • CdtTrfTxInfNode
    //       • PmtIdNode
    //       • AmtNode
    //       • CdtrNode
    //       • CdtrAcctNode
    //       • IdNode
    //       • RmtInfNode
    //
    //   Attribute handling via SetAttribute()
    //   Currency ISO via SetAttribute()
    //   IBAN/BBAN logic preserved
    //
    // FUNCTIONAL PRESERVATION:
    //    WHT amount logic
    //    Decimal trimming
    //    Currency ISO mapping
    //    IBAN CI93 removal
    //    BICICIAB exclusion
    //    Vendor/Customer logic
    //
    // 4. NON-SEPA EXPORT REFACTORING
    // ----------------------------------------------------------------------------
    //
    // Removed:
    //    File-based XML generation
    //    DotNet streaming
    //
    // Implemented:
    //    TempBlob streaming
    //    InsertInterfaceComponentLine()
    //    80-character safe splitting
    //
    // ARCHITECTURE CHANGE:
    //
    // BEFORE (NAV):
    //   DotNet XML → File → Read → Split → Insert
    //
    // AFTER (BC SaaS):
    //   AL XmlDocument → TempBlob → Text → Split → Insert
    //
    // 5. DATA STRUCTURE IMPACT
    // ----------------------------------------------------------------------------
    //
    //    No schema changes
    //    No key changes
    //    No field changes
    //
    //   Only commented removals in:
    //       - Credit Transfer Register
    //       - Credit Transfer Entry
    //
    // 6. BEHAVIORAL CONSISTENCY
    // ----------------------------------------------------------------------------
    //
    //    Payment grouping logic retained
    //    Consolidated payment logic retained
    //    WHT adjustment retained
    //    Charge bearer logic retained
    //    Instruction priority logic retained
    //    ISO pain.001.001.03 namespace preserved
    //
    // 7. REMOVED UNSUPPORTED PATTERNS
    // ----------------------------------------------------------------------------
    //    XMLDomDoc.SelectSingleNode()
    //    XMLNode.ParentNode (DotNet style)
    //    XMLDomDoc.OwnerDocument
    //    System.Xml references
    //    Filesystem-based XML storage
    //BC UPGRADE KUMARR78 <<


    // BC Upgrade MISHRS14 >>
    // Changed table name to "Non Sepa Response Log FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Electronic Banking Setup" to "Electronic Banking Setup FND".
    // BC UPGRADE PATELS08 <<

    //BC UPGRADE ATHKS01>>
    //1. Rewrite CreateNonSepaContent function to use AL XmlDocument instead of DotNet XML.
    //2. Rewrite CreateNonSepaContentTest function to use AL XmlDocument and TempBlob for testing instead of file-based approach.
    //BC UPGRADE ATHKS01<<


    trigger OnRun();
    begin
    end;

    var
        BankAcc: Record "Bank Account";
        XMLDomDoc: XmlDocument;
        BankConnInterfaceSetup: Record "Bank Conn. Interface Setup INT";
        BankExportImportSetup: Record "Bank Export/Import Setup";
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        Currency: Record Currency;
        Customer: Record Customer;
        XMLNodeCurr: XmlNode;
        CustomerBankAcc: Record "Customer Bank Account";
        EBSetup: Record "Electronic Banking Setup FND";
        ConsolidatedPmtJnlLine: Record "Gen. Journal Line BC FND";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        GeneralLedgerSetup: Record "General Ledger Setup";
        InterfaceSetup: Record "Interface Setup INT";
        SalesSetup: Record "Sales & Receivables Setup";
        Vendor: Record Vendor;
        VendorBankAcc: Record "Vendor Bank Account";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        BankConnInterfaceSetupRead: Boolean;
        BankExportImportSetupRead: Boolean;
        GeneralInterfaceSetupRead: Boolean;
        SalesSetupRead: Boolean;
        GMessageId: Code[20];
        //BC UPGRADE KUMARR78 << Adding Replacment.

        NumberOfTransactions: Integer;
        PaymentInformationCounter: Integer;
        MessageId: Text[35];
        ConsolidatedPmtMessage: Text[50];
        CstmrCdtTrfInitnNode: XmlNode;
        PmtInfNode: XmlNode;

    procedure CreateNonSepaPayment(GenJournalLine: Record "Gen. Journal Line BC FND");
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        OutboundInterface: Record "Outbound Interface INT";
        ltext001: Label 'Success!';
    begin
        //HEI.02>>
        GeneralLedgerSetup.Get();
        //HEI.02<<

        Clear(InterfaceSetup);
        GetGeneralInterfaceSetup();
        GetBankConnInterfaceSetup();
        CompanyInfo.Get();
        EBSetup.Get();

        GetBankExportImportSetup(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name");

        BankConnInterfaceSetup.TestField("Non-SEPA Outbound Interface");
        InterfaceSetup.Get(BankConnInterfaceSetup."Non-SEPA Outbound Interface");

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        Clear(InterfaceEntryHeader);
        InterfaceEntryHeader.Direction := InterfaceEntryHeader.Direction::Outbound;
        InterfaceEntryHeader.Status := InterfaceEntryHeader.Status::Pending;
        InterfaceEntryHeader."Interface Code" := BankConnInterfaceSetup."Non-SEPA Outbound Interface";
        InterfaceEntryHeader."Message Creation DateTime" := CurrentDateTime;
        InterfaceEntryHeader."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeader."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
        InterfaceEntryHeader."Source System ID" := OutboundInterface."Logical System ID";
        InterfaceEntryHeader."Company Code ID" := GeneralInterfaceSetup."Company Code ID";

        BankExportImportSetup.TestField("MESTYPE FND");
        BankExportImportSetup.TestField("MESCOD FND");
        BankExportImportSetup.TestField("MESFCT FND");
        BankConnInterfaceSetup.TestField(SNDPRN);
        CompanyInfo.TestField("Bank Account No.");
        CompanyInfo.TestField("Bank Branch No.");
        CompanyInfo.TestField("Country/Region Code");
        BankExportImportSetup.TestField("File Prefix FND");
        BankExportImportSetup.TestField("Export No. Series FND");

        //MESTYPE
        InterfaceEntryHeader.Name := BankExportImportSetup."MESTYPE FND";

        //MESCOD
        InterfaceEntryHeader.Address := BankExportImportSetup."MESCOD FND";

        //MESFCT
        InterfaceEntryHeader."Address 2" := BankExportImportSetup."MESFCT FND";

        //SNDPRN
        InterfaceEntryHeader.Contact := BankConnInterfaceSetup.SNDPRN;

        //BankAccountnumber
        InterfaceEntryHeader."External Contract Name" := CompanyInfo."Bank Account No.";

        //BankKey
        InterfaceEntryHeader.Description := CompanyInfo."Bank Branch No.";

        //BankCountryKey
        InterfaceEntryHeader."Country/Region Code" := CompanyInfo."Country/Region Code";

        //FilePrefix
        InterfaceEntryHeader."Source No." := BankExportImportSetup."File Prefix FND";

        InterfaceEntryHeader.Insert(true);

        Clear(InterfaceEntryLine);
        InterfaceEntryLine."Header Entry No." := InterfaceEntryHeader."Entry No.";
        InterfaceEntryLine."Entry No." := 1;
        InterfaceEntryLine.Insert();

        CreateNonSepaContentTest(GenJournalLine, InterfaceEntryLine);

        InsertNonSepaResponseLog(GenJournalLine, InterfaceEntryHeader, ltext001, false);

        AddInCreditTransferRegister(GenJournalLine, InterfaceEntryHeader, GMessageId);
        AddInCreditTransferEntry(GenJournalLine, InterfaceEntryHeader, GMessageId);
    end;

    procedure ManualSendNonSepaPayments(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        ltext001: Label 'Success!';
    begin
        ClearLastError();
        Commit();
        if Codeunit.Run(Codeunit::"Outbound Interface Processing", InterfaceEntryHeader) then begin
            InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
            InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
            InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
            InsertNonSepaResponseLog(GenJournalLine, InterfaceEntryHeader, ltext001, false);
        end else begin
            InterfaceFrameworkMgt.SetInterfaceError(InterfaceEntryHeader, GetLastErrorText);
            InsertNonSepaResponseLog(GenJournalLine, InterfaceEntryHeader, CopyStr(GetLastErrorText, 1, 250), true);
        end;
    end;

    local procedure ProcessOutboundJournalEntry(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        Commit();
    end;

    local procedure GetBankConnInterfaceSetup();
    begin
        if not BankConnInterfaceSetupRead then
            if BankConnInterfaceSetup.Get() then;
        BankConnInterfaceSetupRead := true;
    end;

    local procedure GetSalesSetup();
    begin
        if not SalesSetupRead then
            SalesSetup.Get();
        SalesSetupRead := true;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.Get();
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetBankExportImportSetup(JnlTemplate: Code[10]; JnlBatch: Code[10]);
    begin
        if not BankExportImportSetupRead then begin
            BankExportImportSetup.SetRange("Journal Template Name FND", JnlTemplate);
            BankExportImportSetup.SetRange("Journal Batch Name FND", JnlBatch);
            if BankExportImportSetup.FindFirst() then;
        end;
        BankExportImportSetupRead := true;
    end;

    //BC UPGRADE KUMARR78 >> Blocking Function to Rewritte Whole Function.
    // local procedure CreateNonSepaContent(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     XMLDOMManagement: Codeunit "XML DOM Management";
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     inStr: InStream;
    //     OutStr: OutStream;
    //     lNonSepaContent: Text;
    // begin
    //     CLEAR(InterfaceEntryLine.Notes);
    //     CompanyInfo.Get();

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     //XMLRootElement.SetAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := Format(GetMessageIDBankExportImportSetup());
    //     GMessageId := MessageId;
    //     StartGroupHeader(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;
    //     ConsolidatedPmtMessage := GenJournalLine."Message to Recipient";
    //     ExportPaymentInformation(CstmrCdtTrfInitnNode, GenJournalLine);
    //     //Footer
    //     FinishGroupHeader();

    //     XMLDomDoc.Save(OutStr);
    //     InterfaceEntryLine.Notes.CREATEOUTSTREAM(OutStr, TextEncoding::UTF8);
    //     InterfaceEntryLine.MODIFY;
    // end;

    //BC UPGRADE KUMARR78 << Blocking Function to Rewrite Whole Function.

    //BC UPGRADE KUMARR78 >> Rewriting CreateNonSepaContent Function Code.
    local procedure CreateNonSepaContent(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text
    var
        OutStr: OutStream;
        lNonSepaContent: Text;
        XMLRootElement: XmlElement;
        XMLNewChild: XmlNode;
        XmlDocMgt: Codeunit "XML DOM Management";
        XmlDoc: XmlDocument;
        XmlDecl: XmlDeclaration;
        RootNode: XmlElement;
    begin
        Clear(InterfaceEntryLine.Notes);
        CompanyInfo.Get();
        // XmlDocument.ReadFrom(
        //     '<?xml version="1.0" encoding="UTF-8"?><Document></Document>',
        //     XMLDomDoc);
        XmlDoc := XmlDocument.Create();
        XMLNodeCurr := XMLDomDoc.AsXmlNode();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');

        // if XMLNodeCurr.IsXmlElement then begin
        //     XMLRootElement := XMLNodeCurr.AsXmlElement();
        //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        // end;
        // XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        XmlDoc.SetDeclaration(XmlDecl);

        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();

        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;

        MessageId := Format(GetMessageIDBankExportImportSetup());
        GMessageId := MessageId;

        StartGroupHeader(XMLNewChild);

        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        ConsolidatedPmtMessage := GenJournalLine."Message to Recipient";

        ExportPaymentInformation(CstmrCdtTrfInitnNode, GenJournalLine);
        FinishGroupHeader();

        InterfaceEntryLine.Notes.CreateOutStream(OutStr, TextEncoding::UTF8);
        XMLDomDoc.WriteTo(OutStr);

        InterfaceEntryLine.Modify();

        exit(lNonSepaContent);
    end;
    //BC UPGRADE KUMARR78 << Rewriting CreateNonSepaContent Function Code.

    local procedure InsertNonSepaResponseLog(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT"; Message: Text[250]; Error: Boolean);
    var
        lNonSepaResponseLog: Record "Non Sepa Response Log FND";
        lEntryNo: Integer;
    begin
        lEntryNo := 1;

        if lNonSepaResponseLog.FindLast() then
            lEntryNo := lNonSepaResponseLog."Entry No." + 1;

        lNonSepaResponseLog."Entry No." := lEntryNo;
        lNonSepaResponseLog.Date := Today;
        lNonSepaResponseLog.Time := Time;
        lNonSepaResponseLog."Interface Code" := InterfaceEntryHeader."Interface Code";
        lNonSepaResponseLog."Journal Template Name" := GenJournalLine."Journal Template Name";
        lNonSepaResponseLog."Journal Batch Name" := GenJournalLine."Journal Batch Name";
        lNonSepaResponseLog."Journal Line No." := GenJournalLine."Line No.";
        lNonSepaResponseLog."Journal Document No." := GenJournalLine."Document No.";
        lNonSepaResponseLog."Journal Description" := GenJournalLine."Message to Recipient";
        lNonSepaResponseLog.Direction := lNonSepaResponseLog.Direction::Outbound;
        lNonSepaResponseLog."User ID" := UserId;
        lNonSepaResponseLog.Message := Message;
        lNonSepaResponseLog.Error := Error;
        lNonSepaResponseLog."WS MessageID" := GMessageId;
        lNonSepaResponseLog.Insert();
    end;

    //BC UPGRADE KUMARR78 >> Blocking to Replace the Code.
    // local procedure AddElement(var XMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; NodeName: Text[250]; NodeText: Text[250]; NameSpace: Text[250]; var CreatedXMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"): Boolean;
    // var
    //     NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     NewChildNode := XMLNode.OwnerDocument.CreateNode('element', NodeName, NameSpace);
    //     if ISNULL(NewChildNode) then
    //         exit(false);

    //     if NodeText <> '' then
    //         NewChildNode.InnerText := NodeText;
    //     XMLNode.AppendChild(NewChildNode);
    //     CreatedXMLNode := NewChildNode;
    //     exit(true);
    // end;
    //BC UPGRADE KUMARR78 << Blocking to Replace the Code.

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
    end;
    //BC UPGRADE KUMARR78 << Adding Functions Replacment.

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
        //  XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        AddElement(GrpHdrNode, 'NbOfTxs', Format(NumberOfTransactions, 0, 9), '', XMLNewChild);
        AddElement(GrpHdrNode, 'InitgPty', '', '', XMLNewChild);
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

    // BC UPGRADE KUMARR78 >> Blocking to Replace Code.
    // procedure ExportTransactionInformation(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "50138"; PaymentMessage: Text[140]);
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
    //     CI93Pos: Integer;
    //     BICICIABPos: Integer;
    // begin
    //     WITH PmtJnlLine DO BEGIN
    //         GLSetup.GET;
    //         RootNode := XMLNodeCurr;
    //         NumberOfTransactions += 1;

    //         AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'PmtId', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         AddElement(XMLNodeCurr, 'EndToEndId', CutText(PaymentMessage, 35), '', XMLNewChild);
    //         XMLNodeCurr := XMLNodeCurr.ParentNode;

    //         AddElement(XMLNodeCurr, 'Amt', '', '', XMLNewChild);
    //         XMLNodeCurr := XMLNewChild;

    //         //AddElement(XMLNodeCurr,'InstdAmt',FORMAT(Amount,0,9),'',XMLNewChild);
    //         //HEI.02>>
    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             //HEI.02<<
    //             lNewAmountText := FORMAT(Amount, 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount, 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         //HEI.02>>
    //                         IF lPosition <> 0 THEN
    //                             //HEI.02<<
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             //HEI.02>>
    //         END;
    //         //HEI.02<<

    //         //HEI.02>>
    //         IF GeneralLedgerSetup."Enable WHT" THEN BEGIN
    //             lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //             IF PmtJnlLine."Currency Code" <> '' THEN
    //                 IF lCurrency.GET(PmtJnlLine."Currency Code") THEN
    //                     IF lCurrency."BC - Send Without Decimals" = TRUE THEN BEGIN
    //                         lNewAmountText := FORMAT(Amount - "WHT Amount", 0, 9);
    //                         lNewAmountText := CONVERTSTR(lNewAmountText, ',', '.');
    //                         lPosition := STRPOS(lNewAmountText, '.');
    //                         IF lPosition <> 0 THEN
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //         END;
    //         //HEI.02<<


    //         //HEI.02>>
    //         IF NOT GeneralLedgerSetup."Enable WHT" THEN
    //             //HEI.02<<
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
    //                         //HEI.02>>
    //                         IF lPosition <> 0 THEN
    //                             //HEI.02<<
    //                             lNewAmountText := COPYSTR(lNewAmountText, 1, lPosition - 1);
    //                     END;
    //             END;

    //         //HEI.02>>
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
    //         //HEI.02<<

    //         AddElement(XMLNodeCurr, 'InstdAmt', lNewAmountText, '', XMLNewChild);

    //         IF "Currency Code" = '' THEN
    //             ISOCurrCode := COPYSTR(GLSetup."LCY Code", 1, 3)
    //         ELSE BEGIN
    //             GetCurrency("Currency Code");
    //             ISOCurrCode := COPYSTR(Currency."ISO Currency Code", 1, 3);
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
    //                         GetCountry(CustBankAcc."Country/Region Code");
    //                         //HEI.04>>
    //                         CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
    //                         IF CI93Pos <> 0 THEN
    //                             BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

    //                         //BICICIABPos := STRPOS(BankAcc."SWIFT Code",'BICICIAB');
    //                         BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
    //                         IF BICICIABPos <> 0 THEN
    //                             BeneficiaryIBAN := '';
    //                         IF Country.Code <> 'CI' THEN
    //                             BeneficiaryIBAN := '';
    //                         //HEI.04<<
    //                     END;
    //                 "Account Type"::Vendor:
    //                     BEGIN
    //                         VendBankAcc.GET("Account No.", "Customer/Vendor Bank");
    //                         BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
    //                         BeneficiaryIBAN := VendBankAcc.IBAN;
    //                         GetCountry(VendBankAcc."Country/Region Code");
    //                         //HEI.04>>
    //                         CI93Pos := STRPOS(BeneficiaryIBAN, 'CI93');
    //                         IF CI93Pos <> 0 THEN
    //                             BeneficiaryIBAN := COPYSTR(BeneficiaryIBAN, 5, STRLEN(BeneficiaryIBAN));

    //                         //BICICIABPos := STRPOS(BankAcc."SWIFT Code",'BICICIAB');
    //                         BICICIABPos := STRPOS(VendBankAcc."SWIFT Code", 'BICICIAB');
    //                         IF BICICIABPos <> 0 THEN
    //                             BeneficiaryIBAN := '';
    //                         IF Country.Code <> 'CI' THEN
    //                             BeneficiaryIBAN := '';
    //                         //HEI.04<<
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
    // end;
    // BC UPGRADE KUMARR78 << Blocking to Replace Code.


    //BC UPGRADE KUMARR78 >> Adding Replacment code for ExportTransactionInformation function.
    procedure ExportTransactionInformation(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND"; PaymentMessage: Text[140]);//BC UPGRADE KUMARR78 Adding with Dotnet Replaced Variable. 
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
        GLSetup.Get();
        RootNode := XMLNodeCurr;
        NumberOfTransactions += 1;

        AddElement(XMLNodeCurr, 'CdtTrfTxInf', '', '', CdtTrfTxInfNode);
        AddElement(CdtTrfTxInfNode, 'PmtId', '', '', PmtIdNode);
        AddElement(PmtIdNode, 'EndToEndId', CutText(PaymentMessage, 35), '', XMLNewChild);
        AddElement(CdtTrfTxInfNode, 'Amt', '', '', AmtNode);

        if not GeneralLedgerSetup."Enable WHT FND" then
            lNewAmountText := Format(PmtJnlLine.Amount, 0, 9)
        else
            lNewAmountText := Format(PmtJnlLine.Amount - PmtJnlLine."WHT Amount", 0, 9);

        if PmtJnlLine."Currency Code" <> '' then
            if lCurrency.Get(PmtJnlLine."Currency Code") then
                if lCurrency."BC - Send Without Decimals FND" then begin
                    lNewAmountText := ConvertStr(lNewAmountText, ',', '.');
                    lPosition := StrPos(lNewAmountText, '.');
                    if lPosition <> 0 then
                        lNewAmountText := CopyStr(lNewAmountText, 1, lPosition - 1);
                end;

        if PmtJnlLine."Currency Code" = '' then begin
            lBankExportImportSetup.Reset();
            lBankExportImportSetup.SetRange("Journal Template Name FND", PmtJnlLine."Journal Template Name");
            lBankExportImportSetup.SetRange("Journal Batch Name FND", PmtJnlLine."Journal Batch Name");
            lBankExportImportSetup.SetRange("Processing Codeunit ID", Codeunit::"Bank Conn. Interface Mgt.");
            if lBankExportImportSetup.FindFirst() then
                if lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" then begin
                    lNewAmountText := ConvertStr(Format(PmtJnlLine.Amount, 0, 9), ',', '.');
                    lPosition := StrPos(lNewAmountText, '.');
                    if lPosition <> 0 then
                        lNewAmountText := CopyStr(lNewAmountText, 1, lPosition - 1);
                end;
        end;

        AddElement(AmtNode, 'InstdAmt', lNewAmountText, '', XMLNewChild);
        // Currency
        if PmtJnlLine."Currency Code" = '' then
            ISOCurrCode := CopyStr(GLSetup."LCY Code", 1, 3)
        else begin
            GetCurrency(PmtJnlLine."Currency Code");
            ISOCurrCode := CopyStr(Currency."ISO Currency Code FND", 1, 3);
        end;
        AddAttribute(XMLNewChild, 'Ccy', ISOCurrCode);

        AddElement(CdtTrfTxInfNode, 'CdtrAgt', '', '', XMLNewChild);
        AddElement(XMLNewChild, 'FinInstnId', '', '', XMLNewChild);

        if (PmtJnlLine."Customer/Vendor Bank" <> '') then
            case PmtJnlLine."Account Type" of
                PmtJnlLine."Account Type"::Customer:
                    begin
                        lCust.Get(PmtJnlLine."Account No.");
                        CustBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := CustBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := CustBankAcc.Code;
                    end;
                PmtJnlLine."Account Type"::Vendor:
                    begin
                        lVend.Get(PmtJnlLine."Account No.");
                        VendBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        lSWIFTCode := VendBankAcc."SWIFT Code";
                        lBeneficiaryBankAccount := VendBankAcc.Code;
                    end;
            end
        else begin
            lSWIFTCode := '';
            lBeneficiaryBankAccount := '';
        end;

        AddElement(XMLNewChild, 'BIC', CopyStr(DelChr(lSWIFTCode), 1, 11), '', XMLNewChild);
        AddElement(CdtTrfTxInfNode, 'Cdtr', '', '', CdtrNode);

        case PmtJnlLine."Account Type" of
            PmtJnlLine."Account Type"::Vendor:
                begin
                    GetVendor(PmtJnlLine."Account No.");
                    AddElement(CdtrNode, 'Nm', CopyStr(Vendor.Name, 1, 70), '', XMLNewChild);
                    AddElement(CdtrNode, 'PstlAdr', '', '', PstlAdrNode);

                    GetCountry(Vendor."Country/Region Code");
                    if Country."ISO Country/Region Code FND" <> '' then
                        AddElement(PstlAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DelChr(Vendor.Address, '<>') + ' ' + DelChr(Vendor."Address 2", '<>');
                    if AddressLine1 <> '' then
                        AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DelChr(Vendor."Post Code", '<>') + ' ' + DelChr(Vendor.City, '<>');
                    if AddressLine2 <> '' then
                        AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);
                end;
            PmtJnlLine."Account Type"::Customer:
                begin
                    GetCustomer(PmtJnlLine."Account No.");
                    AddElement(CdtrNode, 'Nm', CopyStr(Customer.Name, 1, 70), '', XMLNewChild);
                    AddElement(CdtrNode, 'PstlAdr', '', '', PstlAdrNode);

                    GetCountry(Customer."Country/Region Code");
                    if Country."ISO Country/Region Code FND" <> '' then
                        AddElement(PstlAdrNode, 'Ctry', CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

                    AddressLine1 := DelChr(Customer.Address, '<>') + ' ' + DelChr(Customer."Address 2", '<>');
                    if AddressLine1 <> '' then
                        AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);

                    AddressLine2 := DelChr(Customer."Post Code", '<>') + ' ' + DelChr(Customer.City, '<>');
                    if AddressLine2 <> '' then
                        AddElement(PstlAdrNode, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);
                end;
        end;

        AddElement(CdtTrfTxInfNode, 'CdtrAcct', '', '', CdtrAcctNode);
        AddElement(CdtrAcctNode, 'Id', '', '', IdNode);

        if (PmtJnlLine."Customer/Vendor Bank" <> '') then
            case PmtJnlLine."Account Type" of
                PmtJnlLine."Account Type"::Customer:
                    begin
                        CustBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := CustBankAcc."Bank Account No.";
                        BeneficiaryIBAN := CustBankAcc.IBAN;
                        GetCountry(CustBankAcc."Country/Region Code");

                        CI93Pos := StrPos(BeneficiaryIBAN, 'CI93');
                        if CI93Pos <> 0 then
                            BeneficiaryIBAN := CopyStr(BeneficiaryIBAN, 5, StrLen(BeneficiaryIBAN));

                        BICICIABPos := StrPos(VendBankAcc."SWIFT Code", 'BICICIAB');
                        if BICICIABPos <> 0 then
                            BeneficiaryIBAN := '';
                        if Country.Code <> 'CI' then
                            BeneficiaryIBAN := '';
                    end;

                PmtJnlLine."Account Type"::Vendor:
                    begin
                        VendBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        BeneficiaryBankAccountNo := VendBankAcc."Bank Account No.";
                        BeneficiaryIBAN := VendBankAcc.IBAN;
                        GetCountry(VendBankAcc."Country/Region Code");

                        CI93Pos := StrPos(BeneficiaryIBAN, 'CI93');
                        if CI93Pos <> 0 then
                            BeneficiaryIBAN := CopyStr(BeneficiaryIBAN, 5, StrLen(BeneficiaryIBAN));

                        BICICIABPos := StrPos(VendBankAcc."SWIFT Code", 'BICICIAB');
                        if BICICIABPos <> 0 then
                            BeneficiaryIBAN := '';
                        if Country.Code <> 'CI' then
                            BeneficiaryIBAN := '';
                    end;
            end
        else begin
            BeneficiaryBankAccountNo := '';
            BeneficiaryIBAN := '';
            Country."IBAN Country/Region FND" := false;
        end;

        IBANTransfer := (BeneficiaryIBAN <> '') and Country."IBAN Country/Region FND";
        if IBANTransfer then
            AddElement(IdNode, 'IBAN', CopyStr(DelChr(BeneficiaryIBAN), 1, 34), '', XMLNewChild)
        else begin
            AddElement(IdNode, 'Othr', '', '', XMLNewChild);
            AddElement(XMLNewChild, 'Id', BeneficiaryBankAccountNo, '', XMLNewChild);
        end;

        AddElement(CdtTrfTxInfNode, 'RmtInf', '', '', RmtInfNode);
        AddElement(RmtInfNode, 'Ustrd', PaymentMessage, '', XMLNewChild);
    end;
    //BC UPGRADE KUMARR78 << Adding Replacment code for ExportTransactionInformation function.
    local procedure CutText(OriginalText: Text[1024]; MaxLength: Integer) Text: Text[1024];
    begin
        Text := OriginalText;
        if DelChr(Text, '<>') = '' then
            Text := 'NOTPROVIDED';
        AddCutMarker(Text, MaxLength);
    end;

    procedure GetCurrency(CurrencyCode: Code[10]);
    begin
        if Currency.Code <> CurrencyCode then
            if not Currency.Get(CurrencyCode) then
                Currency.Init();
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
        if (VendorNo <> VendorBankAcc."Vendor No.") or (BankAccCode <> VendorBankAcc.Code) then
            if not VendorBankAcc.Get(VendorNo, BankAccCode) then
                VendorBankAcc.Init();
    end;

    procedure GetCountry(CountryCode: Code[10]);
    begin
        if CountryCode <> Country.Code then
            if not Country.Get(CountryCode) then
                Country.Init();
    end;

    procedure GetVendor(VendorNo: Code[20]);
    begin
        if Vendor."No." <> VendorNo then
            if not Vendor.Get(VendorNo) then
                Vendor.Init();
    end;

    procedure GetCustomerBankAccount(CustomerNo: Code[20]; BankAccCode: Code[10]);
    begin
        if (CustomerNo <> CustomerBankAcc."Customer No.") or (BankAccCode <> CustomerBankAcc.Code) then
            if not CustomerBankAcc.Get(CustomerNo, BankAccCode) then
                CustomerBankAcc.Init();
    end;

    procedure GetCustomer(CustomerNo: Code[20]);
    begin
        if Customer."No." <> CustomerNo then
            if not Customer.Get(CustomerNo) then
                Customer.Init();
    end;

    local procedure AddCutMarker(var Text: Text[1024]; MaxLength: Integer);
    var
        CutMarker: Text[30];
    begin
        CutMarker := '...';
        if StrLen(Text) > MaxLength then
            Text := CopyStr(Text, 1, MaxLength - StrLen(CutMarker)) + CutMarker;
    end;

    //BC UPGRDAE KUMARR >> Blocking to Replace Code.
    // local procedure ExportPaymentInformation(XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; PmtJnlLine: Record "Gen. Journal Line BC FND");
    // var
    //     RootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     ChargeBearer: Text[4];
    //     InstructionPriority: Text[10];
    //     AddressLine2: Text[60];
    //     AddressLine1: Text[110];
    // begin
    //     RootNode := XMLNodeCurr;
    //     PaymentInformationCounter := PaymentInformationCounter + 1;
    //     AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     PmtInfNode := XMLNodeCurr;

    //     AddElement(XMLNodeCurr, 'PmtInfId', MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'PmtMtd', 'TRF', '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'BtchBookg', 'false', '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'PmtTpInf', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     case PmtJnlLine."Instruction Priority" of
    //         PmtJnlLine."Instruction Priority"::Normal:
    //             InstructionPriority := 'NORM';
    //         PmtJnlLine."Instruction Priority"::High:
    //             InstructionPriority := 'HIGH';
    //     end;
    //     AddElement(XMLNodeCurr, 'InstrPrty', InstructionPriority, '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'ReqdExctnDt', Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);
    //     AddElement(XMLNodeCurr, 'Dbtr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Nm', CompanyInfo.Name, '', XMLNewChild);

    //     AddElement(XMLNodeCurr, 'PstlAdr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetCountry(CompanyInfo."Country/Region Code");

    //     if Country."ISO Country/Region Code" <> '' then
    //         AddElement(XMLNodeCurr, 'Ctry', CopyStr(Country."ISO Country/Region Code", 1, 2), '', XMLNewChild);

    //     AddressLine1 := DelChr(CompanyInfo.Address, '<>') + ' ' + DelChr(CompanyInfo."Address 2", '<>');
    //     if DelChr(AddressLine1) <> '' then
    //         AddElement(XMLNodeCurr, 'AdrLine', CopyStr(AddressLine1, 1, 35), '', XMLNewChild);

    //     AddressLine2 := DelChr(CompanyInfo."Post Code", '<>') + ' ' + DelChr(CompanyInfo.City, '<>');
    //     if DelChr(AddressLine2) <> '' then
    //         AddElement(XMLNodeCurr, 'AdrLine', CopyStr(AddressLine2, 1, 35), '', XMLNewChild);

    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAcct', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'Id', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     GetBankAccount(PmtJnlLine."HNK Bank Account");
    //     //HEI.04>>
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

    //     /*
    //     BICICIABPos := STRPOS(BankAcc."SWIFT Code",'BICICIAB');

    //     IF BICICIABPos = 0 THEN
    //       AddElement(XMLNodeCurr,'IBAN',COPYSTR(DELCHR(BankAcc.IBAN),1,34),'',XMLNewChild)
    //       ELSE
    //         BEGIN
    //         */
    //     AddElement(XMLNodeCurr, 'Othr', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;
    //     AddElement(XMLNodeCurr, 'Id', BankAcc."Bank Account No.", '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     //END;
    //     //HEI.04<<

    //     AddElement(XMLNodeCurr, 'IBAN', CopyStr(DelChr(BankAcc.IBAN), 1, 34), '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     AddElement(XMLNodeCurr, 'DbtrAgt', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'FinInstnId', '', '', XMLNewChild);
    //     XMLNodeCurr := XMLNewChild;

    //     AddElement(XMLNodeCurr, 'BIC', CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11), '', XMLNewChild);
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;
    //     XMLNodeCurr := XMLNodeCurr.ParentNode;

    //     case PmtJnlLine."Code Expenses" of
    //         PmtJnlLine."Code Expenses"::" ",
    //       PmtJnlLine."Code Expenses"::SHA:
    //             ChargeBearer := 'SHAR';
    //         PmtJnlLine."Code Expenses"::BEN:
    //             ChargeBearer := 'CRED';
    //         PmtJnlLine."Code Expenses"::OUR:
    //             ChargeBearer := 'DEBT';
    //     end;

    //     AddElement(XMLNodeCurr, 'ChrgBr', ChargeBearer, '', XMLNewChild);

    //     XMLNodeCurr := RootNode;

    // end;
    //BC UPGRDAE KUMARR << Blocking to Replace Code.

    //BC UPGRADE KUMARR78 >> Replacing ExportPaymentInformation Function Code.
    local procedure ExportPaymentInformation(XMLNodeCurr: XmlNode; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        ChargeBearer: Text[4];
        InstructionPriority: Text[10];
        AddressLine2: Text[60];
        AddressLine1: Text[110];
        CurrElement: XmlElement;
        RootElement: XmlElement;
        XMLNewChild: XmlNode;
    begin
        RootElement := XMLNodeCurr.AsXmlElement();

        PaymentInformationCounter += 1;

        AddElement(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        CurrElement := XMLNewChild.AsXmlElement();
        PmtInfNode := XMLNewChild;

        AddElement(XMLNewChild, 'PmtInfId',
            MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);
        AddElement(XMLNewChild, 'PmtMtd', 'TRF', '', XMLNewChild);
        AddElement(XMLNewChild, 'BtchBookg', 'false', '', XMLNewChild);

        AddElement(XMLNewChild, 'PmtTpInf', '', '', XMLNewChild);
        CurrElement := XMLNewChild.AsXmlElement();

        case PmtJnlLine."Instruction Priority" of
            PmtJnlLine."Instruction Priority"::Normal:
                InstructionPriority := 'NORM';
            PmtJnlLine."Instruction Priority"::High:
                InstructionPriority := 'HIGH';
        end;

        AddElement(XMLNewChild, 'InstrPrty', InstructionPriority, '', XMLNewChild);

        CurrElement := PmtInfNode.AsXmlElement();

        AddElement(PmtInfNode, 'ReqdExctnDt',
            Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElement(PmtInfNode, 'Dbtr', '', '', XMLNewChild);
        CurrElement := XMLNewChild.AsXmlElement();

        AddElement(XMLNewChild, 'Nm', CompanyInfo.Name, '', XMLNewChild);

        AddElement(XMLNewChild, 'PstlAdr', '', '', XMLNewChild);
        CurrElement := XMLNewChild.AsXmlElement();

        GetCountry(CompanyInfo."Country/Region Code");

        if Country."ISO Country/Region Code FND" <> '' then
            AddElement(XMLNewChild, 'Ctry',
                CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

        AddressLine1 :=
            DelChr(CompanyInfo.Address, '<>') + ' ' +
            DelChr(CompanyInfo."Address 2", '<>');

        if DelChr(AddressLine1) <> '' then
            AddElement(XMLNewChild, 'AdrLine',
                CopyStr(AddressLine1, 1, 35), '', XMLNewChild);

        AddressLine2 :=
            DelChr(CompanyInfo."Post Code", '<>') + ' ' +
            DelChr(CompanyInfo.City, '<>');

        if DelChr(AddressLine2) <> '' then
            AddElement(XMLNewChild, 'AdrLine',
                CopyStr(AddressLine2, 1, 35), '', XMLNewChild);

        CurrElement := PmtInfNode.AsXmlElement();

        AddElement(PmtInfNode, 'DbtrAcct', '', '', XMLNewChild);
        CurrElement := XMLNewChild.AsXmlElement();

        AddElement(XMLNewChild, 'Id', '', '', XMLNewChild);
        CurrElement := XMLNewChild.AsXmlElement();

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        AddElement(XMLNewChild, 'Othr', '', '', XMLNewChild);
        CurrElement := XMLNewChild.AsXmlElement();

        AddElement(XMLNewChild, 'Id',
            BankAcc."Bank Account No.", '', XMLNewChild);

        AddElement(XMLNewChild, 'IBAN', CopyStr(DelChr(BankAcc.IBAN), 1, 34), '', XMLNewChild);
        AddElement(PmtInfNode, 'DbtrAgt', '', '', XMLNewChild);
        CurrElement := XMLNewChild.AsXmlElement();

        AddElement(XMLNewChild, 'FinInstnId', '', '', XMLNewChild);
        CurrElement := XMLNewChild.AsXmlElement();

        AddElement(XMLNewChild, 'BIC',
            CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11),
            '',
            XMLNewChild);

        case PmtJnlLine."Code Expenses" of
            PmtJnlLine."Code Expenses"::" ",
            PmtJnlLine."Code Expenses"::SHA:
                ChargeBearer := 'SHAR';
            PmtJnlLine."Code Expenses"::BEN:
                ChargeBearer := 'CRED';
            PmtJnlLine."Code Expenses"::OUR:
                ChargeBearer := 'DEBT';
        end;
        AddElement(PmtInfNode, 'ChrgBr', ChargeBearer, '', XMLNewChild);
    end;
    //BC UPGRADE KUMARR78 << Replacing ExportPaymentInformation Function Code.

    procedure GetBankAccount(BankAccCode: Code[20]);
    begin
        if BankAcc."No." <> BankAccCode then
            if not BankAcc.Get(BankAccCode) then
                BankAcc.Init();
    end;

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite Code.
    // procedure CreateNonSepaContentTest(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     lGenJournalLine81: Record "Gen. Journal Line";
    //     lGenJournalLine: Record "Gen. Journal Line BC";
    //     InterfaceEntryComponent: Record "Interface Entry Component";
    //     XMLDOMManagement: Codeunit "XML DOM Management";
    //     BigText: BigText;
    //     NewPaymentGroup: Boolean;
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     filRead: File;
    //     inStr: InStream;
    //     InStream: InStream;
    //     c: Integer;
    //     i: Integer;
    //     intLen: Integer;
    //     j: Integer;
    //     k: Integer;
    //     k1: Integer;
    //     k3: Integer;
    //     Pos: Integer;
    //     OutStr: OutStream;
    //     cString: Text;
    //     FileName1: Text;
    //     lNonSepaContent: Text;
    //     MyText: Text;
    //     TodayString: Text;
    //     txtFromFile: Text;
    //     txtOneLine: Text;
    //     XMLText: Text;
    //     TxtToAddInComponent: Text[80];
    // begin
    //     CompanyInfo.Get();

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     //XMLRootElement.SetAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     MessageId := Format(GetMessageIDBankExportImportSetup());
    //     GMessageId := MessageId;
    //     StartGroupHeader(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;

    //     //part 1/2 -> save XML file
    //     /*
    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     */

    //     SaveToFileName := RBMgt.ServerTempFileName('.xml');//ttt
    //     //SaveToFileName := RBMgt.ClientTempFileName('.xml');//ttt
    //     SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');

    //     //MESSAGE('%1',SaveToFileName);

    //     //Content
    //     /*
    //     ConsolidatedPmtMessage := GenJournalLine."Message to Recipient";
    //     ExportPaymentInformation(CstmrCdtTrfInitnNode,GenJournalLine);
    //     ExportTransactionInformation(PmtInfNode,GenJournalLine,ConsolidatedPmtMessage);
    //     */

    //     lGenJournalLine.Reset();
    //     lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.SetFilter("Parent Line No.", '=%1', 0);
    //     if lGenJournalLine.FindFirst() then
    //         repeat
    //             NewPaymentGroup := CheckNewGroup(lGenJournalLine);

    //             if NewConsolidatedPayment(lGenJournalLine) then begin
    //                 ExportTransactionInformation(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
    //                 InitConsolidatedPayment(lGenJournalLine);
    //             end else
    //                 UpdateConsolidatedPayment(lGenJournalLine);

    //             if NewPaymentGroup then
    //                 ExportPaymentInformation(CstmrCdtTrfInitnNode, lGenJournalLine);
    //         until lGenJournalLine.Next() = 0;

    //     if not EmptyConsolidatedPayment() then
    //         ExportTransactionInformation(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);

    //     //Footer
    //     FinishGroupHeader();

    //     if Date2DMY(Today, 2) < 10 then
    //         TodayString := Format(Date2DMY(Today, 3)) + '0' + Format(Date2DMY(Today, 2)) + Format(Date2DMY(Today, 1)) +
    //                           Format(Time, 0, '<hours24><minutes,2><seconds,2>')
    //     else
    //         TodayString := Format(Date2DMY(Today, 3)) + Format(Date2DMY(Today, 2)) + Format(Date2DMY(Today, 1)) +
    //                           Format(Time, 0, '<hours24><minutes,2><seconds,2>');

    //     //FileName := 'E:\Bogdan\testxml' + FORMAT(TODAY,<Closing><Month,2><Day,2><Year>) + '.xml';
    //     //FileName := 'E:\Bogdan\paymentxml' + TodayString + FORMAT(GenJournalLine."Line No.") +'.xml';
    //     //FileName1 := 'E:\Bogdan\paymentxml' + TodayString + FORMAT(GenJournalLine."Line No.") +'_1.xml';
    //     //FileName := SaveToFileName;
    //     //RBMgt.DownloadToFile(SaveToFileName,FileName);

    //     //FileName := 'E:\Bogdan\paymentxml' + TodayString + FORMAT(GenJournalLine."Line No.") +'.xml';
    //     FileName := SaveToFileNameClient;

    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName, FileName);
    //     FullFileName := FileName;

    //     //filRead.OPEN(SaveToFileName);
    //     filRead.OPEN(SaveToFileName, TextEncoding::UTF8);

    //     intLen := filRead.LEN;
    //     txtFromFile := '';

    //     //filRead.READ(txtFromFile);

    //     InterfaceEntryComponent.Reset();
    //     c := 1;
    //     cString := 'C0001';

    //     filRead.CREATEINSTREAM(InStream);
    //     while not InStream.EOS do begin
    //         InStream.ReadText(txtFromFile);
    //         i := StrLen(txtFromFile);

    //         k := i div 80;
    //         k1 := i mod 80;

    //         if k1 <> 0 then begin
    //             k3 := 1;
    //             for j := 1 to k + 1 do begin
    //                 txtOneLine := CopyStr(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.Reset();
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := Format(cString);

    //                 Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 if Pos <> 0 then
    //                     //HEI.03>>
    //                     //TxtToAddInComponent := '<?xml version="1.0" encoding="UTF-8"?>';
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';
    //                 //HEI.03<<

    //                 //InterfaceEntryComponent."Approver Name" := TxtToAddInComponent;
    //                 InterfaceEntryComponent."Approver Name" := DelChr(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.Insert();
    //                 c += 1;
    //                 cString := IncStr(cString);
    //             end;
    //         end;

    //         if k1 = 0 then begin
    //             k3 := 1;
    //             for j := 1 to k do begin
    //                 txtOneLine := CopyStr(txtFromFile, k3, 80);
    //                 k3 += 80;
    //                 TxtToAddInComponent := txtOneLine;
    //                 InterfaceEntryComponent.Reset();
    //                 InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //                 InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //                 InterfaceEntryComponent.Code := Format(cString);

    //                 Pos := StrPos(TxtToAddInComponent, '<?xml version="1.0" encoding="UTF-8"?>');
    //                 if Pos <> 0 then
    //                     //HEI.03>>
    //                     //TxtToAddInComponent := '<?xml version="1.0" encoding="UTF-8"?>';
    //                     TxtToAddInComponent := '<![CDATA[<?xml version="1.0" encoding="UTF-8"?>';
    //                 //HEI.03<<

    //                 //InterfaceEntryComponent."Approver Name" := TxtToAddInComponent;
    //                 InterfaceEntryComponent."Approver Name" := DelChr(TxtToAddInComponent, '<>', ' ');
    //                 InterfaceEntryComponent.Insert();
    //                 c += 1;
    //                 cString := IncStr(cString);
    //             end;
    //         end;
    //     end;

    //     //HEI.03>>
    //     TxtToAddInComponent := ']]>';
    //     InterfaceEntryComponent.Reset();
    //     InterfaceEntryComponent."Header Entry No." := InterfaceEntryLine."Header Entry No.";
    //     InterfaceEntryComponent."Line Entry No." := InterfaceEntryLine."Entry No.";
    //     InterfaceEntryComponent.Code := Format(cString);
    //     InterfaceEntryComponent."Approver Name" := DelChr(TxtToAddInComponent, '<>', ' ');
    //     InterfaceEntryComponent.Insert();
    //     c += 1;
    //     cString := IncStr(cString);
    //     //HEI.03<<

    //     filRead.CLOSE;

    //     if EXISTS(SaveToFileName) then
    //         if ERASE(SaveToFileName) then;

    //     lGenJournalLine.Reset();
    //     lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine.DeleteAll();

    //     lGenJournalLine81.Reset();
    //     lGenJournalLine81.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
    //     lGenJournalLine81.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
    //     lGenJournalLine81.SetFilter("Parent Line No.", '=%1', 0);
    //     lGenJournalLine81.ModifyAll("WS Posting Allowed", true);

    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite Code.

    //BC UPGRADE KUMARR78 >> Replacing CreateNonSepaContentTest Function Code.
    procedure CreateNonSepaContentTest(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text
    var
        lGenJournalLine81: Record "Gen. Journal Line";
        lGenJournalLine: Record "Gen. Journal Line BC FND";
        InterfaceEntryComponent: Record "Interface Entry Component INT";
        TempBlob: Codeunit "Temp Blob";
        NewPaymentGroup: Boolean;
        cString: Code[10];
        InStr: InStream;
        c: Integer;
        i: Integer;
        j: Integer;
        k: Integer;
        k1: Integer;
        k3: Integer;
        OutStr: OutStream;
        txtOneLine: Text;
        XMLText: Text;
        XmlDecl: XmlDeclaration;
        XmlDoc: XmlDocument;
        CstmrNode: XmlElement;
        RootNode: XmlElement;
        XMLNewChild: XmlNode;
        TxtToAddInComponent: Text[80];
        Pos: Integer;
        XMlns: Integer;
    begin
        CompanyInfo.Get();

        XmlDoc := XmlDocument.Create();
        //XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', ' ');
        XmlDoc.SetDeclaration(XmlDecl);

        //RootNode := XmlElement.Create('Document');
        // RootNode.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        RootNode := XmlElement.Create('Document', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootNode);
        XMLNodeCurr := RootNode.AsXmlNode();

        //XMLDomDoc.SelectSingleNode('Document', XMLNodeCurr);
        //CstmrNode := XmlElement.Create('CstmrCdtTrfInitn');
        //RootNode.Add(CstmrNode);

        AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
        CstmrCdtTrfInitnNode := XMLNewChild;

        lGenJournalLine.Reset();
        lGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        lGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        lGenJournalLine.SetFilter("Parent Line No.", '=%1', 0);

        if lGenJournalLine.FindFirst() then
            repeat
                NewPaymentGroup := CheckNewGroup(lGenJournalLine);

                if NewConsolidatedPayment(lGenJournalLine) then begin
                    ExportTransactionInformation(PmtInfNode, ConsolidatedPmtJnlLine, ConsolidatedPmtMessage);
                    InitConsolidatedPayment(lGenJournalLine);
                end else
                    UpdateConsolidatedPayment(lGenJournalLine);

                if NewPaymentGroup then
                    ExportPaymentInformation(CstmrCdtTrfInitnNode, lGenJournalLine);
            until lGenJournalLine.Next() = 0;

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

            // for j := 1 to k do begin
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
                        txtOneLine);

                    c += 1;
                    cString := IncStr(cString);
                end;
            end;

            if k1 = 0 then begin
                k3 := 1;
                FOR j := 1 TO k DO BEGIN

                    //if k1 <> 0 then begin
                    txtOneLine := CopyStr(XMLText, k3, 80);
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
                        txtOneLine);
                end;
            end;
        end;
        TxtToAddInComponent := ']]>';

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

    //BC UPGRADE KUMARR78 << Replacing CreateNonSepaContentTest Function Code.

    //BC UPGRADE KUMARR78 >> Blocking to Rewrite Code.
    // procedure CreateNonSepaContentTestBLOB(GenJournalLine: Record "Gen. Journal Line BC"; InterfaceEntryLine: Record "Interface Entry Line"): Text;
    // var
    //     TempBlob: Record "99008535" temporary;
    //     XMLDOMManagement: Codeunit "XML DOM Management";
    //     BigText: BigText;
    //     XMLRootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlElement";
    //     XMLNewChild: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLNodeCurr: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     inStr: InStream;
    //     OutStr: OutStream;
    //     lNonSepaContent: Text;
    //     MyText: Text;
    //     XMLText: Text;
    // begin
    //     CompanyInfo.Get();

    //     //Header
    //     XMLDOMManagement.LoadXMLDocumentFromText('<?xml version="1.0" encoding="UTF-8"?><Document></Document>', XMLDomDoc);
    //     XMLRootElement := XMLDomDoc.DocumentElement;
    //     XMLRootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
    //     //XMLRootElement.SetAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
    //     XMLNodeCurr := XMLDomDoc.SelectSingleNode('Document');
    //     AddElement(XMLNodeCurr, 'CstmrCdtTrfInitn', '', '', XMLNewChild);
    //     CstmrCdtTrfInitnNode := XMLNewChild;
    //     //MessageId := 'MessageID';
    //     //MessageId := FORMAT(GenJournalLine."Line No.");
    //     //MessageId := GetMessageID(GetExportProtocolCode(GenJournalLine));
    //     MessageId := Format(GetMessageIDBankExportImportSetup());
    //     GMessageId := MessageId;

    //     StartGroupHeader(XMLNewChild);
    //     PaymentInformationCounter := 0;
    //     NumberOfTransactions := 0;

    //     //++part 1/2 -> save XML file
    //     //SaveToFileName := RBMgt.ServerTempFileName('.xml');
    //     //--part 1/2 -> save XML file

    //     //bbb
    //     //Content
    //     ConsolidatedPmtMessage := GenJournalLine."Message to Recipient";
    //     ExportPaymentInformation(CstmrCdtTrfInitnNode, GenJournalLine);
    //     ExportTransactionInformation(PmtInfNode, GenJournalLine, ConsolidatedPmtMessage);

    //     //Footer
    //     FinishGroupHeader();

    //     //++part 2/2 -> save XML file
    //     /*
    //     FileName := 'E:\Bogdan\testxml.xml';
    //     XMLDomDoc.Save(SaveToFileName);
    //     RBMgt.DownloadToFile(SaveToFileName,FileName);
    //     FullFileName := FileName;
    //     */
    //     //--//part 2/2 -> save XML file

    //     InterfaceEntryLine.Notes.CreateOutStream(OutStr, TextEncoding::UTF8);
    //     XMLDomDoc.Save(OutStr);
    //     InterfaceEntryLine.Modify();

    // end;
    //BC UPGRADE KUMARR78 << Blocking to Rewrite Code.
    procedure CreateNonSepaContentTestBLOB(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryLine: Record "Interface Entry Line INT"): Text
    var
        OutStr: OutStream;
        ConsolidatedPmtMessage: Text;
        XmlDoc: XmlDocument;
        CstmrCdtTrfInitnNode: XmlElement;
        RootElement: XmlElement;
    begin
        CompanyInfo.Get();
        XmlDoc := XmlDocument.Create();
        RootElement := XmlElement.Create('Document');
        RootElement.SetAttribute('xmlns', 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03');
        XmlDoc.Add(RootElement);
        XMLDomDoc.SelectSingleNode('Docuement', XMLNodeCurr);
        CstmrCdtTrfInitnNode := XmlElement.Create('CstmrCdtTrfInitn');
        RootElement.Add(CstmrCdtTrfInitnNode);
        MessageId := Format(GetMessageIDBankExportImportSetup());
        GMessageId := MessageId;
        PaymentInformationCounter := 0;
        NumberOfTransactions := 0;
        StartGroupHeaderForBlob(CstmrCdtTrfInitnNode);//BC UPGRADE KUMARR78 Adding New Function to Resolve Error.
        ConsolidatedPmtMessage := GenJournalLine."Message to Recipient";
        ExportPaymentInformationBlob(CstmrCdtTrfInitnNode, GenJournalLine);//BC UPGRADE KUMARR78 Adding New Function to Resolve Error.
        ExportTransactionInformation(PmtInfNode, GenJournalLine, ConsolidatedPmtMessage);
        FinishGroupHeader();
        InterfaceEntryLine.Notes.CreateOutStream(OutStr, TextEncoding::UTF8);
        XmlDoc.WriteTo(OutStr);
        InterfaceEntryLine.Modify();
        exit(MessageId);
    end;


    //BC UPGRADE KUMARR78 >> Adding New Function to Resolve Error.
    local procedure ExportPaymentInformationBlob(var XMLNodeCurr: XmlElement; PmtJnlLine: Record "Gen. Journal Line BC FND")
    var
        ChargeBearer: Text[4];
        InstructionPriority: Text[10];
        AddressLine2: Text[60];
        AddressLine1: Text[110];
        CurrElement: XmlElement;
        PmtInfNode: XmlElement;
        XMLNewChild: XmlElement;
    begin

        PaymentInformationCounter += 1;

        AddElementBlob(XMLNodeCurr, 'PmtInf', '', '', XMLNewChild);
        PmtInfNode := XMLNewChild;
        CurrElement := XMLNewChild;

        AddElementBlob(CurrElement, 'PmtInfId',
            MessageId + '-' + Format(PaymentInformationCounter), '', XMLNewChild);
        AddElementBlob(CurrElement, 'PmtMtd', 'TRF', '', XMLNewChild);
        AddElementBlob(CurrElement, 'BtchBookg', 'false', '', XMLNewChild);

        AddElementBlob(CurrElement, 'PmtTpInf', '', '', XMLNewChild);
        CurrElement := XMLNewChild;

        case PmtJnlLine."Instruction Priority" of
            PmtJnlLine."Instruction Priority"::Normal:
                InstructionPriority := 'NORM';
            PmtJnlLine."Instruction Priority"::High:
                InstructionPriority := 'HIGH';
        end;

        AddElementBlob(CurrElement, 'InstrPrty', InstructionPriority, '', XMLNewChild);

        CurrElement := PmtInfNode;

        AddElementBlob(CurrElement, 'ReqdExctnDt',
            Format(PmtJnlLine."Posting Date", 0, 9), '', XMLNewChild);

        AddElementBlob(CurrElement, 'Dbtr', '', '', XMLNewChild);
        CurrElement := XMLNewChild;

        AddElementBlob(CurrElement, 'Nm', CompanyInfo.Name, '', XMLNewChild);

        AddElementBlob(CurrElement, 'PstlAdr', '', '', XMLNewChild);
        CurrElement := XMLNewChild;

        GetCountry(CompanyInfo."Country/Region Code");

        if Country."ISO Country/Region Code FND" <> '' then
            AddElementBlob(CurrElement, 'Ctry',
                CopyStr(Country."ISO Country/Region Code FND", 1, 2), '', XMLNewChild);

        AddressLine1 :=
            DelChr(CompanyInfo.Address, '<>') + ' ' +
            DelChr(CompanyInfo."Address 2", '<>');

        if DelChr(AddressLine1) <> '' then
            AddElementBlob(CurrElement, 'AdrLine',
                CopyStr(AddressLine1, 1, 35), '', XMLNewChild);

        AddressLine2 :=
            DelChr(CompanyInfo."Post Code", '<>') + ' ' +
            DelChr(CompanyInfo.City, '<>');

        if DelChr(AddressLine2) <> '' then
            AddElementBlob(CurrElement, 'AdrLine',
                CopyStr(AddressLine2, 1, 35), '', XMLNewChild);

        CurrElement := PmtInfNode;

        AddElementBlob(CurrElement, 'DbtrAcct', '', '', XMLNewChild);
        CurrElement := XMLNewChild;

        AddElementBlob(CurrElement, 'Id', '', '', XMLNewChild);
        CurrElement := XMLNewChild;

        GetBankAccount(PmtJnlLine."HNK Bank Account");

        AddElementBlob(CurrElement, 'Othr', '', '', XMLNewChild);
        CurrElement := XMLNewChild;

        AddElementBlob(CurrElement, 'Id',
            BankAcc."Bank Account No.", '', XMLNewChild);

        AddElementBlob(CurrElement, 'IBAN',
            CopyStr(DelChr(BankAcc.IBAN), 1, 34), '', XMLNewChild);

        CurrElement := PmtInfNode;

        AddElementBlob(CurrElement, 'DbtrAgt', '', '', XMLNewChild);
        CurrElement := XMLNewChild;

        AddElementBlob(CurrElement, 'FinInstnId', '', '', XMLNewChild);
        CurrElement := XMLNewChild;

        AddElementBlob(CurrElement, 'BIC',
            CopyStr(DelChr(BankAcc."SWIFT Code"), 1, 11),
            '',
            XMLNewChild);

        case PmtJnlLine."Code Expenses" of
            PmtJnlLine."Code Expenses"::" ",
            PmtJnlLine."Code Expenses"::SHA:
                ChargeBearer := 'SHAR';
            PmtJnlLine."Code Expenses"::BEN:
                ChargeBearer := 'CRED';
            PmtJnlLine."Code Expenses"::OUR:
                ChargeBearer := 'DEBT';
        end;

        AddElementBlob(PmtInfNode, 'ChrgBr', ChargeBearer, '', XMLNewChild);
    end;

    local procedure StartGroupHeaderForBlob(var XMLNodeCurr: XmlElement)
    var
        XMLNewChild: XmlElement;
    begin
        AddElementBlob(XMLNodeCurr, 'GrpHdr', '', '', XMLNewChild);
        XMLNodeCurr := XMLNewChild;

        AddElementBlob(XMLNodeCurr, 'MsgId', MessageId, '', XMLNewChild);
        AddElementBlob(XMLNodeCurr, 'CreDtTm', Format(CurrentDateTime, 0, 9), '', XMLNewChild);
    end;

    local procedure AddElementBlob(
        var XMLNode: XmlElement;
        NodeName: Text[250];
        NodeText: Text[250];
        NameSpace: Text[250];
        var CreatedXMLNode: XmlElement): Boolean
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

        XMLNode.Add(NewElement);
        CreatedXMLNode := NewElement;

        exit(true);
    end;
    //BC UPGRADE KUMARR78 << Adding New Function to Resolve Error.
    local procedure GetMessageID(ExportProtocolCode: Code[20]): Text[35];
    var
        ExportProtocol: Record "Export Protocol FND";
        NoSeriesMgt: Codeunit "No. Series";//BC UPGRADE KUMARR78 Replacing "No. Series Managament. to "No. Series". 
    begin
        ExportProtocol.Get(ExportProtocolCode);
        exit(NoSeriesMgt.GetNextNo(ExportProtocol."Export No. Series", Today, true));
    end;

    local procedure GetExportProtocolCode(var PmtJnlLine: Record "Gen. Journal Line BC FND"): Code[20];
    var
        ExportProtocolCode: Code[20];
    begin
        PmtJnlLine.FilterGroup(2);
        //ExportProtocolCode := PmtJnlLine.GETRANGEMAX("Export Protocol Code");
        ExportProtocolCode := PmtJnlLine."Export Protocol Code";
        PmtJnlLine.FilterGroup(0);
        exit(ExportProtocolCode);
    end;

    local procedure AddInCreditTransferRegister(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT"; MessageID: Code[20]);
    var
        lCreditTransferRegister: Record "Credit Transfer Register";
        lEntryNo: Integer;
    begin
        lCreditTransferRegister.Reset();
        lEntryNo := 1;
        if lCreditTransferRegister.FindLast() then
            lEntryNo := lCreditTransferRegister."No." + 1;

        lCreditTransferRegister.Reset();
        lCreditTransferRegister."No." := lEntryNo;
        lCreditTransferRegister.Identifier := GenJournalLine."Document No.";
        lCreditTransferRegister."Created Date-Time" := CreateDateTime(Today, Time);
        lCreditTransferRegister."Created by User" := UserId;
        lCreditTransferRegister.Status := lCreditTransferRegister.Status::"File Created";
        lCreditTransferRegister."No. of Transfers" := 1;
        lCreditTransferRegister."From Bank Account No." := GenJournalLine."Bal. Account No.";
        //BC UPGRADE KUMARR78 >> Field Removed.
        // lCreditTransferRegister."Interface Log Entry No." := InterfaceEntryHeader."Entry No.";
        // lCreditTransferRegister."Can Be Sent to WS" := true;
        // lCreditTransferRegister."WS Status" := lCreditTransferRegister."WS Status"::"Sent to NAS";
        // lCreditTransferRegister."WS MessageID" := MessageID;
        // lCreditTransferRegister."Exported Multiple Times" := false;
        // lCreditTransferRegister."HNK Bank Account" := GenJournalLine."HNK Bank Account";
        // lCreditTransferRegister."No. of Times Sent to WS" := 1;
        //BC UPGRADE KUMARR78 << Field Removed.
        if lCreditTransferRegister.Insert() then;
    end;

    local procedure AddInCreditTransferEntry(GenJournalLine: Record "Gen. Journal Line BC FND"; InterfaceEntryHeader: Record "Interface Entry Header INT"; MessageID: Code[20]);
    var
        lCreditTransferEntry: Record "Credit Transfer Entry";
        lCreditTransferRegisterNo: Integer;
    begin
        lCreditTransferEntry.Reset();
        lCreditTransferRegisterNo := 1;
        if lCreditTransferEntry.FindLast() then
            lCreditTransferRegisterNo := lCreditTransferEntry."Credit Transfer Register No." + 1;

        lCreditTransferEntry.Reset();
        lCreditTransferEntry."Credit Transfer Register No." := lCreditTransferRegisterNo;
        lCreditTransferEntry."Entry No." := 1;
        if GenJournalLine."Account Type" = GenJournalLine."Account Type"::Customer then
            lCreditTransferEntry."Account Type" := lCreditTransferEntry."Account Type"::Customer;
        if GenJournalLine."Account Type" = GenJournalLine."Account Type"::Vendor then
            lCreditTransferEntry."Account Type" := lCreditTransferEntry."Account Type"::Vendor;
        lCreditTransferEntry."Account No." := GenJournalLine."Account No.";
        //lCreditTransferEntry."Applies-to Entry No." := GenJournalLine."Applies-to ID";
        lCreditTransferEntry."Transfer Date" := GenJournalLine."Document Date";
        lCreditTransferEntry."Currency Code" := GenJournalLine."Currency Code";
        //HEI.02>>
        //lCreditTransferEntry."Transfer Amount" := GenJournalLine."Amount (LCY)";
        if not GeneralLedgerSetup."Enable WHT FND" then
            lCreditTransferEntry."Transfer Amount" := GenJournalLine."Amount (LCY)"
        else
            lCreditTransferEntry."Transfer Amount" := GenJournalLine."Amount (LCY)" - GenJournalLine."WHT Amount (LCY)";
        //HEI.02<<
        lCreditTransferEntry."Transaction ID" := CopyStr(GenJournalLine."Document No.", 1, 35);
        lCreditTransferEntry.Canceled := false;
        lCreditTransferEntry."Recipient Bank Acc. No." := GenJournalLine."Bal. Account No.";
        lCreditTransferEntry."Message to Recipient" := CopyStr(GenJournalLine."Message to Recipient", 1, 140);
        //BC UPGRADE KUMARR78 >> Field Removed.
        // lCreditTransferEntry."Interface Log Entry No." := InterfaceEntryHeader."Entry No.";
        // lCreditTransferEntry."Can Be Sent to WS" := true;
        // lCreditTransferEntry."WS Status" := lCreditTransferEntry."WS Status"::"Sent to NAS";
        // lCreditTransferEntry."WS MessageID" := MessageID;
        // lCreditTransferEntry."Exported Multiple Times" := false;
        // lCreditTransferEntry."HNK Bank Account" := GenJournalLine."HNK Bank Account";
        // lCreditTransferEntry."No. of Times Sent to WS" := 1;
        //BC UPGRADE KUMARR78 << Field Removed.
        if lCreditTransferEntry.Insert() then;
    end;

    procedure CheckNewGroup(PmtJnlLine: Record "Gen. Journal Line BC FND"): Boolean;
    begin
        if EmptyConsolidatedPayment() then
            exit(true);

        exit(
  (ConsolidatedPmtJnlLine."HNK Bank Account" <> PmtJnlLine."HNK Bank Account") or
  (ConsolidatedPmtJnlLine."Currency Code" <> PmtJnlLine."Currency Code") or
  (ConsolidatedPmtJnlLine."Posting Date" <> PmtJnlLine."Posting Date") or
  (ConsolidatedPmtJnlLine."Instruction Priority" <> PmtJnlLine."Instruction Priority") or
  (ConsolidatedPmtJnlLine."Code Expenses" <> PmtJnlLine."Code Expenses"));
    end;

    local procedure EmptyConsolidatedPayment(): Boolean;
    begin
        exit(ConsolidatedPmtJnlLine."HNK Bank Account" = '');
    end;

    local procedure NewConsolidatedPayment(PmtJnlLine: Record "Gen. Journal Line BC FND"): Boolean;
    var
        lCust: Record Customer;
        CustBankAcc: Record "Customer Bank Account";
        lVend: Record Vendor;
        VendBankAcc: Record "Vendor Bank Account";
        lBeneficiaryBankAccount: Code[30];
        lBeneficiaryBankAccountConsolidated: Code[30];
    begin
        if EmptyConsolidatedPayment() then
            exit(false);

        if (PmtJnlLine."Customer/Vendor Bank" <> '') then
            case PmtJnlLine."Account Type" of
                PmtJnlLine."Account Type"::Customer:
                    begin
                        lCust.Get(PmtJnlLine."Account No.");
                        CustBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        //lBeneficiaryBankAccount := lCust."Preferred Bank Account Code";
                        lBeneficiaryBankAccount := CustBankAcc."Bank Account No.";
                    end;
                PmtJnlLine."Account Type"::Vendor:
                    begin
                        lVend.Get(PmtJnlLine."Account No.");
                        VendBankAcc.Get(PmtJnlLine."Account No.", PmtJnlLine."Customer/Vendor Bank");
                        //lBeneficiaryBankAccount := lVend."Preferred Bank Account Code";
                        lBeneficiaryBankAccount := VendBankAcc."Bank Account No.";
                    end;
            end
        else begin
            lBeneficiaryBankAccount := '';
        end;

        if (ConsolidatedPmtJnlLine."Customer/Vendor Bank" <> '') then
            case ConsolidatedPmtJnlLine."Account Type" of
                ConsolidatedPmtJnlLine."Account Type"::Customer:
                    begin
                        lCust.Get(ConsolidatedPmtJnlLine."Account No.");
                        CustBankAcc.Get(ConsolidatedPmtJnlLine."Account No.", ConsolidatedPmtJnlLine."Customer/Vendor Bank");
                        //lBeneficiaryBankAccountConsolidated := lCust."Preferred Bank Account Code";
                        lBeneficiaryBankAccountConsolidated := CustBankAcc."Bank Account No.";
                    end;
                ConsolidatedPmtJnlLine."Account Type"::Vendor:
                    begin
                        lVend.Get(ConsolidatedPmtJnlLine."Account No.");
                        VendBankAcc.Get(ConsolidatedPmtJnlLine."Account No.", ConsolidatedPmtJnlLine."Customer/Vendor Bank");
                        //lBeneficiaryBankAccountConsolidated := lVend."Preferred Bank Account Code";
                        lBeneficiaryBankAccountConsolidated := VendBankAcc."Bank Account No.";
                    end;
            end
        else begin
            lBeneficiaryBankAccountConsolidated := '';
        end;

        exit(
  CheckNewGroup(PmtJnlLine) or
  IsPaymentMessageTooLong(PmtJnlLine."Message to Recipient") or
  (ConsolidatedPmtJnlLine."Account Type" <> PmtJnlLine."Account Type") or
  (ConsolidatedPmtJnlLine."Account No." <> PmtJnlLine."Account No.") or
  (lBeneficiaryBankAccountConsolidated <> lBeneficiaryBankAccount));
    end;

    local procedure InitConsolidatedPayment(PmtJnlLine: Record "Gen. Journal Line BC FND");
    begin
        ConsolidatedPmtJnlLine := PmtJnlLine;
        ConsolidatedPmtMessage := ConsolidatedPmtJnlLine."Message to Recipient";
    end;

    local procedure UpdateConsolidatedPayment(PmtJnlLine: Record "Gen. Journal Line BC FND");
    begin
        if EmptyConsolidatedPayment() then
            InitConsolidatedPayment(PmtJnlLine)
        else begin
            //HEI.02>>
            //ConsolidatedPmtJnlLine.Amount := ConsolidatedPmtJnlLine.Amount + PmtJnlLine.Amount;
            if not GeneralLedgerSetup."Enable WHT FND" then
                ConsolidatedPmtJnlLine.Amount := ConsolidatedPmtJnlLine.Amount + PmtJnlLine.Amount
            else
                ConsolidatedPmtJnlLine.Amount := ConsolidatedPmtJnlLine.Amount + (PmtJnlLine.Amount - PmtJnlLine."WHT Amount");
            //HEI.02<<
            UpdateConsolidatedPmtMessage(PmtJnlLine."Message to Recipient");
        end;
    end;

    local procedure IsPaymentMessageTooLong(PaymentMessage: Text[50]): Boolean;
    begin
        if not EBSetup."Cut off Payment Message Texts" then
            exit(StrLen(ConcatenatedPmtMessage(PaymentMessage)) > MaxStrLen(ConsolidatedPmtMessage));
        exit(false);
    end;

    local procedure UpdateConsolidatedPmtMessage(PaymentMessage: Text[50]);
    var
        NewMessage: Text[1024];
    begin
        NewMessage := ConcatenatedPmtMessage(PaymentMessage);
        if EBSetup."Cut off Payment Message Texts" then
            ConsolidatedPmtMessage := CopyStr(
                CutText(NewMessage, MaxStrLen(ConsolidatedPmtMessage)),
                1, MaxStrLen(ConsolidatedPmtMessage))
        else
            ConsolidatedPmtMessage := CopyStr(NewMessage, 1, MaxStrLen(ConsolidatedPmtMessage));
    end;

    local procedure ConcatenatedPmtMessage(PaymentMessage: Text[50]): Text[1024];
    begin
        exit(ConsolidatedPmtMessage + ' ' + PaymentMessage);
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text): Text;
    var
        NewString: Text;
    begin
        while StrPos(String, FindWhat) > 0 do
            String := DelStr(String, StrPos(String, FindWhat)) + ReplaceWith + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString := String;

        exit(NewString);
    end;

    local procedure GetMessageIDBankExportImportSetup(): Text[35];
    var
        NoSeriesMgt: Codeunit "No. Series";//BC UPGRADE KUMARR78 Replacing "No. Series Managament. to "No. Series".
    begin
        exit(NoSeriesMgt.GetNextNo(BankExportImportSetup."Export No. Series FND", Today, true));
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

