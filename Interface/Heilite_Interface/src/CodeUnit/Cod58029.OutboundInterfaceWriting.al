codeunit 58029 "Outbound Interface Writing"
{
    // Heilite Navision Old Id - 50004

    // version HEI.06,FM

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New codeunit for Interface Common Framework
    // HEI.02 V1.05 HT84 IBM POENAB02 30.04.2019 # Bank Connectivity interface
    //   # New function: ReplaceString
    //   # Code added in function SaveXMLToBLOB
    // HEI.03 S&OP Core interfaces - optimize the XML creation procedure
    // HEI.04 FDD-HT664 IBM SURYAS01 18-02-2020
    //   # Added code on SaveXMLToBLOB Function
    // HEI.05 FDD-HT626 IBM SURYAS01 22-02-2020
    //   # Added code on SaveXMLToBLOB Function
    // HEI.06 CHG2095189 IBM SAXENA03 27.01.2021
    //   # Code written for Sales Order optimizaiton
    //   # Added RESET, SetCurrentKey & FINDSET(FALSE,FALSE)function in OnRun, CreateXML() & SaveXMLToBLOB.
    //   # Code added to Insert data in TempDataField table and delete.
    //   # Comment delete in function CreateXML().

    // ATHUKS01>> 
    //1.Added new function NonSEPAOutboundInterfaceProcess to handle the specific requirement for Non-SEPA Outbound Interface.
    // ATHUKS01<<


    Permissions = TableData "Data Exch." = rimd;
    TableNo = "Data Exch.";

    trigger OnRun();
    var
        DataExch: Record "Data Exch.";
        DataExchDef: Record "Data Exch. Def";
        TempXMLBuffer: Record "XML Buffer" temporary;
        TempGroupElement: Record "Coupling Record Buffer" temporary;
        OutputStream: OutStream;
        "--": Integer;
        InStr: InStream;
        OutStr: OutStream;
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        TempDataExch: Record "Data Exch." temporary;
        DataExchField: Record "Data Exch. Field";
        InterfaceMan: Codeunit "Interface Framework Mgt.";

    begin
        DataExchDef.GET(Rec."Data Exch. Def Code");
        //<<HEI.06
        DataExch.RESET;
        DataExch.SETCURRENTKEY("Parent Data Exch. No. FND");
        //>>HEI.06
        DataExch.SETRANGE("Parent Data Exch. No. FND", Rec."Entry No.");
        if DataExch.FINDSET then
            repeat
                CreateXML(DataExch, TempXMLBuffer, TempGroupElement);
                //<<HEI.06
                if not TempDataExch.GET(DataExch."Entry No.") then begin
                    TempDataExch.INIT;
                    TempDataExch."Entry No." := DataExch."Entry No.";
                    TempDataExch.INSERT;
                end;
            //>>HEI.06
            until DataExch.NEXT = 0;

        //<<HEI.06
        if TempDataExch.FINDSET then
            repeat
                DataExchField.RESET;
                DataExchField.SETCURRENTKEY("Data Exch. No.");
                DataExchField.SETRANGE("Data Exch. No.", TempDataExch."Entry No.");
                DataExchField.DELETEALL(true);
            until TempDataExch.NEXT = 0;
        TempDataExch.DELETEALL;
        //>>HEI.06

        TempXMLBuffer.RESET;
        TempXMLBuffer.FINDFIRST;

        SaveXMLBufferToDataExch(Rec, TempXMLBuffer);////BC Upgrade VAMSIU01 - added
        //SaveXMLToBLOB(Rec, TempXMLBuffer);//BC Upgrade VAMSIU01 - Commented.


    end;

    var
        DefaultNamespace: Text;

    local procedure CreateXML(var DataExch: Record "Data Exch."; var TempXMLBuffer: Record "XML Buffer"; var TempGroupElement: Record "Coupling Record Buffer");
    var
        DataExchField: Record "Data Exch. Field";
        DataExchLineDef: Record "Data Exch. Line Def";
        PathExcludingName: Text;
        ElementName: Text;
        LastSeparatorPos: Integer;
        PrevLineNo: Integer;
    begin
        //<<HEI.06
        DataExchField.RESET;
        DataExchField.SETCURRENTKEY("Data Exch. No.");
        //>>HEI.06
        DataExchField.SETRANGE("Data Exch. No.", DataExch."Entry No.");
        //<<HEI.06
        //IF DataExchField.FINDSET THEN
        if DataExchField.FINDSET() then
            //>>HEI.06
            repeat
                DataExchLineDef.GET(DataExch."Data Exch. Def Code", DataExchField."Data Exch. Line Def Code");
                LastSeparatorPos := LastSeparatorPosInString(DataExchField."XML Node Path FND", '/');
                PathExcludingName := COPYSTR(DataExchField."XML Node Path FND", 1, LastSeparatorPos);
                if (DataExchField."Line No." <> PrevLineNo) and
                   (PathExcludingName = DataExchLineDef."Data Line Tag") and
                    (DataExchLineDef."Max. Occurs FND" = DataExchLineDef."Max. Occurs FND"::Unbounded)
                then begin
                    TempGroupElement.RESET;
                    //<<HEI.06
                    TempGroupElement.SETCURRENTKEY("NAV Name");
                    //>>HEI.06
                    TempGroupElement.SETFILTER("NAV Name", PathExcludingName + '*');
                    TempGroupElement.DELETEALL;
                end;

                ElementName := COPYSTR(DataExchField."XML Node Path FND", LastSeparatorPos + 1);
                if not TempGroupElement.GET(PathExcludingName) then
                    ExtractGroupElements(TempXMLBuffer, TempGroupElement, DataExchField."XML Node Path FND");

                TempXMLBuffer.RESET;
                //HEI.03>>
                TempXMLBuffer.SETCURRENTKEY(Path);

                //HEI.03<<
                TempXMLBuffer.SETRANGE(Path, PathExcludingName);
                TempXMLBuffer.FINDLAST;

                TempXMLBuffer.RESET;

                if COPYSTR(DELCHR(ElementName, '=', '/'), 1, 1) = '@' then
                    TempXMLBuffer.AddAttribute(COPYSTR(DELCHR(ElementName, '=', '/'), 2), DataExchField.Value)
                else
                    TempXMLBuffer.AddElement(DELCHR(ElementName, '=', '/'), DataExchField.Value);

                PrevLineNo := DataExchField."Line No.";
            until DataExchField.NEXT = 0;

        TempXMLBuffer.RESET;

        //<<HEI.06
        //DataExchField.DELETEALL(TRUE);
        //>>HEI.06
    end;

    local procedure ExtractGroupElements(var TempXMLBuffer: Record "XML Buffer"; var TempGroupElement: Record "Coupling Record Buffer"; PathIncludingName: Text);
    var
        Path: Text;
        ElementName: Text;
        SeparatorPos: Integer;
    begin
        repeat
            SeparatorPos := STRPOS(PathIncludingName, '/');
            if SeparatorPos > 1 then begin
                Path := Path + COPYSTR(PathIncludingName, 1, SeparatorPos);
                if not TempGroupElement.GET(COPYSTR(Path, 1, STRLEN(Path) - 1)) then begin
                    CLEAR(TempGroupElement);
                    TempGroupElement."NAV Name" := COPYSTR(Path, 1, STRLEN(Path) - 1);
                    TempGroupElement.INSERT;
                    ElementName := COPYSTR(PathIncludingName, 1, SeparatorPos - 1);
                    InsertGroupElement(TempXMLBuffer, COPYSTR(Path, 1, STRPOS(Path, '/' + ElementName + '/') - 1), ElementName);
                end;
            end else
                if SeparatorPos = 1 then
                    Path := COPYSTR(PathIncludingName, 1, 1);
            PathIncludingName := COPYSTR(PathIncludingName, SeparatorPos + 1);
        until SeparatorPos = 0;
    end;

    local procedure InsertGroupElement(var TempXMLBuffer: Record "XML Buffer"; PathExcludingName: Text; ElementName: Text);
    begin
        TempXMLBuffer.RESET;
        //HEI.03>>
        TempXMLBuffer.SETCURRENTKEY(Path);
        //HEI.03<<
        TempXMLBuffer.SETRANGE(Path, PathExcludingName);
        if TempXMLBuffer.FINDLAST then;
        TempXMLBuffer.RESET;
        TempXMLBuffer.AddGroupElement(ElementName);
    end;

    local procedure LastSeparatorPosInString(String: Text; Separator: Char): Integer;
    var
        i: Integer;
    begin
        for i := 1 to STRLEN(String) do
            if String[STRLEN(String) + 1 - i] = Separator then
                exit(STRLEN(String) - i);
    end;

    [TryFunction]
    procedure SaveXMLToBLOB(var DataExch: Record "Data Exch."; var XMLBuffer: Record "XML Buffer");
    var
        TempXMLBuffer: Record "XML Buffer" temporary;
        TempAttributeXMLBuffer: Record "XML Buffer" temporary;
        XMLDOMManagement: Codeunit "XML DOM Management";
        //XmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";  // BC Upgrade NANDIS03
        XMLDocument: XmlDocument;  // BC Upgrade NANDIS03
        //RootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";  // BC Upgrade NANDIS03
        RootElement: XmlNode; // BC Upgrade NANDIS03
        Rootelement2: XmlElement;// BC Upgrade VAMSIU01
        Header: Text;
        OutputStream: OutStream;
        NewXML: BigText;
        XMLLineText: Text;
        SaveToFileName: Text;
        FileName: Text;
        SaveToFileNameClient: Text;
        RBMgt: Codeunit "File Management";
        FullFileName: Text;
        filRead: File;
        InStream: InStream;
        txtFromFile: Text;
        txtFromFileToAdd: Text;
        lText50000: Label '<ContentDetail>';
        lText50001: Label '</ContentDetail>';
        txtFromFileToAdd1: Text;
        Pos: Integer;
        Pos1: Integer;
        lText50002: TextConst ENU = '<ns0:MT_PaymentFileMsg xmlns:ns0="http://heineken.com/CommonFormats" xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">';
        //BankConnInterfaceSetup: Record "Bank Conn. Interface Setup INT";
        NonSEPAOutboundInterfaceCode: Code[20];
        //SAGEInterfaceSetup: Record "SAGE Interface Setup INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        //TempXMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";  // BC Upgrade NANDIS03
        TempXMLNode: XmlNode;  // BC Upgrade NANDIS03
        XMLFileInStream: InStream;
        //TempXMLNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";  // BC Upgrade NANDIS03
        TempXMLNode2: XmlNode;  // BC Upgrade NANDIS03
        XMLDOMMgt: Codeunit "XML DOM Mgt.";  // BC Upgrade NANDIS03
        TempXMLBufferReader: Codeunit "XML Buffer Reader";
    begin
        TempXMLBuffer.CopyImportFrom(XMLBuffer);
        TempXMLBuffer := XMLBuffer;
        TempXMLBuffer.SETCURRENTKEY("Parent Entry No.", Type, "Node Number");

        Header := '<?xml version="1.0" encoding="UTF-8"?>' +
          '<' + TempXMLBuffer.GetElementName + ' ';

        DefaultNamespace := TempXMLBuffer.GetAttributeValueAsText('xmlns');//BC Upgrade VAMSIU01- Added
        if TempXMLBuffer.FindAttributes(TempAttributeXMLBuffer) then
            repeat
                Header += TempAttributeXMLBuffer.Name + '="' + TempAttributeXMLBuffer.Value + '" ';
            until TempAttributeXMLBuffer.NEXT = 0;
        Header += '/>';

        //XMLDOMManagement.LoadXMLDocumentFromText(Header, XmlDocument);  // BC Upgrade NANDIS03
        XMLDOMMgt.LoadXMLDocumentFromText(Header, XmlDocument);  // BC Upgrade NANDIS03
        //RootElement := XmlDocument.DocumentElement;  // BC Upgrade NANDIS03
        Rootelement2 := XmlElement.Create('Elements');

        SaveChildElements(TempXMLBuffer, RootElement, XmlDocument, DefaultNamespace);  // BC Upgrade NANDIS03


        /*         //HEI.02>>
                NonSEPAOutboundInterfaceCode := '';
                if BankConnInterfaceSetup.GET then
                    NonSEPAOutboundInterfaceCode := BankConnInterfaceSetup."Non-SEPA Outbound Interface";

                if (NonSEPAOutboundInterfaceCode <> '') and (DataExch."Data Exch. Def Code" = NonSEPAOutboundInterfaceCode) then begin
                    CLEAR(NewXML);
                    SaveToFileName := RBMgt.ServerTempFileName('.xml');
                    //SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');
                    //FileName := SaveToFileNameClient;
                    XmlDocument.Save(SaveToFileName);
                    //RBMgt.DownloadToFile(SaveToFileName,FileName);
                    //FullFileName := FileName;
                    //filRead.OPEN(SaveToFileName);
                    filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);
                    filRead.CREATEINSTREAM(InStream);
                    while not InStream.EOS do begin
                        txtFromFileToAdd := '';
                        InStream.READTEXT(txtFromFile);

                        if STRPOS(txtFromFile, '<Content />') = 0 then begin
                            Pos := STRPOS(txtFromFile, '<ContentDetail>');
                            if Pos <> 0 then begin
                                txtFromFileToAdd := ReplaceString(txtFromFile, '<ContentDetail>', '');
                                txtFromFileToAdd1 := txtFromFileToAdd;

                                txtFromFileToAdd := ReplaceString(txtFromFileToAdd1, '</ContentDetail>', '');
                                //NewXML.ADDTEXT(txtFromFileToAdd);
                                NewXML.ADDTEXT(DELCHR(txtFromFileToAdd, '<>', ' '));
                            end
                            else
                                NewXML.ADDTEXT(txtFromFile);
                        end;
                    end;
                    if EXISTS(SaveToFileName) then
                        if ERASE(SaveToFileName) then;
                end;
                //HEI.02<< */

        /*
                //<<HEI.04
                SAGEInterfaceSetup.RESET;
                if SAGEInterfaceSetup.GET then;
                if (SAGEInterfaceSetup."Cust Direct Debit Interface" <> '') and (DataExch."Data Exch. Def Code" = SAGEInterfaceSetup."Cust Direct Debit Interface") then begin
                    //>>HEI.06
                    //InterfaceEntryHeader.RESET;
                    InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
                    ///<<HEI.06
                    InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExch."Entry No.");
                    InterfaceEntryHeader.FINDLAST;
                    InterfaceEntryHeader.CALCFIELDS("XML File to Send");
                    InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

                    if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:CUSTOMERDIRECTDEBITPAYMENT', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                        XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                        TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
                    end;
                end;
                //>>HEI.04
        */
        /*
                //<<HEI.05
                SAGEInterfaceSetup.RESET;
                if SAGEInterfaceSetup.GET then;
                if (SAGEInterfaceSetup."Vendor SEPA interface" <> '') and (DataExch."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor SEPA interface") then begin
                    ///<<HEI.06
                    //InterfaceEntryHeader.RESET;
                    InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
                    //>>HEI.06
                    InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExch."Entry No.");
                    InterfaceEntryHeader.FINDLAST;
                    InterfaceEntryHeader.CALCFIELDS("XML File to Send");
                    InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

                    if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORSEPAPAYMENT', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                        XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                        TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
                    end;
                end;

                if (SAGEInterfaceSetup."Vendor Non-SEPA interface" <> '') and (DataExch."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor Non-SEPA interface") then begin
                    ///<<HEI.06
                    //InterfaceEntryHeader.RESET;
                    InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
                    //>>HEI.06
                    InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExch."Entry No.");
                    InterfaceEntryHeader.FINDLAST;
                    InterfaceEntryHeader.CALCFIELDS("XML File to Send");
                    InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

                    if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORNON-SEPAPAYMENT', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                        XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                        TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
                    end;
                end;

                if (SAGEInterfaceSetup."Vendor Fixed Asset SEPA IC" <> '') and (DataExch."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor Fixed Asset SEPA IC") then begin
                    ///<<HEI.06
                    //InterfaceEntryHeader.RESET;
                    InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
                    //>>HEI.06
                    InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExch."Entry No.");
                    InterfaceEntryHeader.FINDLAST;
                    InterfaceEntryHeader.CALCFIELDS("XML File to Send");
                    InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

                    if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORFIXEDASSETSEPAPAYMENTSIC', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                        XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                        TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
                    end;
                end;

                if (SAGEInterfaceSetup."Vendor Fixed Asset SEPA Interf" <> '') and (DataExch."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor Fixed Asset SEPA Interf") then begin
                    ///<<HEI.06
                    //InterfaceEntryHeader.RESET;
                    InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
                    //>>HEI.06
                    InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExch."Entry No.");
                    InterfaceEntryHeader.FINDLAST;
                    InterfaceEntryHeader.CALCFIELDS("XML File to Send");
                    InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

                    if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORFIXEDASSETSEPAPAYMENTS', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                        XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                        TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
                    end;
                end;

                if (SAGEInterfaceSetup."Vendor SEPA BRED Interface" <> '') and (DataExch."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor SEPA BRED Interface") then begin
                    ///<<HEI.06
                    //InterfaceEntryHeader.RESET;
                    InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
                    //>>HEI.06
                    InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExch."Entry No.");
                    InterfaceEntryHeader.FINDLAST;
                    InterfaceEntryHeader.CALCFIELDS("XML File to Send");
                    InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

                    if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORSEPAPAYMENTSBRED', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                        XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                        TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
                    end;
                end;

                if (SAGEInterfaceSetup."Bank Account Balances" <> '') and (DataExch."Data Exch. Def Code" = SAGEInterfaceSetup."Bank Account Balances") then begin
                    ///<<HEI.06
                    //InterfaceEntryHeader.RESET;
                    InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
                    //>>HEI.06
                    InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExch."Entry No.");
                    InterfaceEntryHeader.FINDLAST;
                    InterfaceEntryHeader.CALCFIELDS("XML File to Send");
                    InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

                    if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:BankAccountBalances', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                        XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                        TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
                    end;
                end;
                //>>HEI.05
        */
        //HEI.02>>
        //DataExch."File Content".CREATEOUTSTREAM(OutputStream);
        DataExch."File Content".CREATEOUTSTREAM(OutputStream, TEXTENCODING::UTF8);
        //XmlDocument.Save(OutputStream);
        if (NonSEPAOutboundInterfaceCode <> '') and (DataExch."Data Exch. Def Code" = NonSEPAOutboundInterfaceCode) then
            NewXML.WRITE(OutputStream)
        else
            //XmlDocument.Save(OutputStream);  //BC Upgrade NANDIS03
            XmlDocument.WriteTo(OutputStream);  //BC Upgrade NANDIS03
        //HEI.02<<
        DataExch.MODIFY;
    end;


    local procedure SaveChildElements(var TempParentElementXMLBuffer: Record "XML Buffer" temporary; var XMLCurrElement: XMLNode; var XmlDocument: XMLDOcument; DefaultNamespace: Text);  //BC Upgrade
    var
        TempElementXMLBuffer: Record "XML Buffer" temporary;
        //ChildElement: DotNet SystemXMLNode;  //BC Upgrade
        ChildElement: XMLNode;  //BC Upgrade
        XMLNodeList_BC: XmlNodeList;  // BC Upgrade
        XMLDOMMgt: Codeunit "XML DOM Mgt.";  // BC Upgrade
        XMLDOMMgtNew: Codeunit "XML DOM Management";//BC Upgrade VAMSIU01
        Namespace: Text;
        XMLDOC_BC: XmlDocument;
    begin
        if TempParentElementXMLBuffer.FindChildElements(TempElementXMLBuffer) then
            repeat
                if TempElementXMLBuffer.Namespace = '' then
                    Namespace := DefaultNamespace
                else
                    Namespace := TempElementXMLBuffer.Namespace;
                //ChildElement := XmlDocument.CreateNode('element', TempElementXMLBuffer.GetElementName, Namespace);  //BC Upgrade VAMSIU01
                //ChildElement := XMLDOMMgt.AddElementText_BC(XMLCurrElement, 'element', TempElementXMLBuffer.GetElementName, Namespace, XMLCurrElement);  //BC Upgrade VAMSIU01
                XMLDOMMgt.AddElement(XMLCurrElement, 'element', TempElementXMLBuffer.GetElementName, Namespace, ChildElement);//BC Upgrade VAMSIU01 -Commented
                if TempElementXMLBuffer.Value <> '' then
                    //ChildElement.InnerText := TempElementXMLBuffer.Value;  //BC Upgrade
                    XMLDOMMgt.FindNodeText(ChildElement, TempElementXMLBuffer.Value);  //BC Upgrade
                //XMLCurrElement.AppendChild(ChildElement); //BC Upgrade

                SaveAttributes(TempElementXMLBuffer, ChildElement, XmlDocument);
                SaveChildElements(TempElementXMLBuffer, ChildElement, XmlDocument, DefaultNamespace);
            until TempElementXMLBuffer.NEXT = 0;
    end;
    // BC Upgrade NANDIS03 <<

    // BC Upgrade NANDIS03>>
    local procedure SaveAttributes(var TempParentElementXMLBuffer: Record "XML Buffer" temporary; var XMLCurrElement: XMLNode; XmlDocument: XMLDOcument);  // BC Upgrade
    var
        TempAttributeXMLBuffer: Record "XML Buffer" temporary;
        //Attribute: DotNet SystemXMLAttribute; //BC Upgrade VAMSIU01 Commented
        Attribute: XmlAttribute; //BC Upgrade VAMSIU01 added
        AttributeXML: XmlAttribute;  // BC Upgrade
        XMLDOMMgt: Codeunit "XML DOM Mgt.";  // BC Upgrade
    begin
        if TempParentElementXMLBuffer.FindAttributes(TempAttributeXMLBuffer) then
            repeat
                //Attribute := XmlDocument.CreateAttribute(TempAttributeXMLBuffer.Name);  // BC Upgrade VAMSIU01 Commented
                XMLDOMMgt.AddAttribute(XMLCurrElement, TempAttributeXMLBuffer.Name, TempAttributeXMLBuffer.Value);  // BC Upgrade VAMSIU01 

                //Attribute.InnerText := TempAttributeXMLBuffer.Value; //BC Upgrade VAMSIU01.
                //XMLCurrElement.Attributes.SetNamedItem(Attribute);  // BC Upgrade VAMSIU01
                XMLDOMMgt.GetAttributeValue(XMLCurrElement, TempAttributeXMLBuffer.Value);  // BC Upgrade VAMSIU01 
            until TempAttributeXMLBuffer.NEXT = 0;
    end;
    // BC Upgrade NANDIS03 <<
    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text): Text;
    var
        NewString: Text;
    begin
        //HEI.02>>
        while STRPOS(String, FindWhat) > 0 do
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;

        exit(NewString);
        //HEI.02<<
    end;

    //BC Upgrade VAMSIU01 start>>

    procedure SaveXMLBufferToDataExch(var DataExchRec: Record "Data Exch."; var TempXMLBuffer: Record "XML Buffer" temporary)
    var
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
    begin
        if TempXMLBuffer.IsEmpty() then
            exit;

        Clear(TempBlob);

        // Save XML Buffer into TempBlob
        TempXMLBuffer.Save(TempBlob);

        //ATHKS01>>
        if NonSEPAOutboundInterfaceProcess(DataExchRec, TempBlob) then
            exit;
        //ATHKS01<< 

        // Copy TempBlob → Data Exch File Content
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        Clear(DataExchRec."File Content");
        DataExchRec."File Content".CreateOutStream(OutStr, TextEncoding::UTF8);
        CopyStream(OutStr, InStr);

        // Persist changes
        DataExchRec.Modify(true);
    end;

    //BC Upgrade VAMSIU01 end<<
    //BC ATHUKS01>>
    local procedure NonSEPAOutboundInterfaceProcess(var DataExchRec: Record "Data Exch."; TempBlob: Codeunit "Temp Blob"): Boolean
    var
        BankConnInterfaceSetup: Record "Bank Conn. Interface Setup INT";
        NonSEPAOutboundInterfaceCode: Code[20];
        txtFromFile: Text;
        txtFromFileToAdd: Text;
        Pos: Integer;
        txtFromFileToAdd1: Text;
        NewXML: BigText;
        InStr: InStream;
        OutStr: OutStream;

    begin
        //HEI.02>>
        NonSEPAOutboundInterfaceCode := '';
        IF BankConnInterfaceSetup.GET THEN
            NonSEPAOutboundInterfaceCode := BankConnInterfaceSetup."Non-SEPA Outbound Interface";
        IF (NonSEPAOutboundInterfaceCode <> '') AND (DataExchRec."Data Exch. Def Code" = NonSEPAOutboundInterfaceCode) THEN BEGIN
            TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
            while not InStr.EOS do begin
                txtFromFileToAdd := '';
                InStr.READTEXT(txtFromFile);

                if STRPOS(txtFromFile, '<Content />') = 0 then begin
                    Pos := STRPOS(txtFromFile, '<ContentDetail>');
                    if Pos <> 0 then begin
                        txtFromFileToAdd := ReplaceString(txtFromFile, '<ContentDetail>', '');
                        txtFromFileToAdd1 := txtFromFileToAdd;

                        txtFromFileToAdd := ReplaceString(txtFromFileToAdd1, '</ContentDetail>', '');
                        //NewXML.ADDTEXT(txtFromFileToAdd);
                        NewXML.ADDTEXT(DELCHR(txtFromFileToAdd, '<>', ' '));
                    end
                    else
                        NewXML.ADDTEXT(txtFromFile);
                end;
            end;
            // Copy TempBlob → Data Exch File Content
            Clear(DataExchRec."File Content");
            DataExchRec."File Content".CreateOutStream(OutStr, TextEncoding::UTF8);
            NewXML.WRITE(OutStr);
            CopyStream(OutStr, InStr);
            // Persist changes
            if DataExchRec.Modify(true) then
                exit(true);
        end;
    end;
    //BC ATHUKS01<<
}

