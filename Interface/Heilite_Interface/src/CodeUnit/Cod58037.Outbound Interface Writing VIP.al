codeunit 58037 "Outbound Interface Writing VIP"
{
    // Heilite Navision Old Id - 50154

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
    // HEI.06 CHG2095187 IBM SAXENA03 27.01.2021
    //   # Code written for Paraller Request
    //   # Created a new Object to Replace Data Exch. Table with Data Exch. VIP, Replica of CodeUnit 50004
    //   # Added RESET, SetCurrentKey & FINDSET(FALSE,FALSE)function in OnRun, CreateXML() & SaveXMLToBLOB.
    //   # Code added to Insert data in TempDataField table and delete.
    //   # Comment delete in function CreateXML().
    //   # Replace Local variable Data Exch. Table with Data Exch. VIP.
    //   # Replace Local variable TempDataExch with TempDataExchVIP.
    //   # Replace Data Exch. Table with Data Exch. VIP in OnRun Function TableNO Property.
    //   # Replace parameter DataExchVIP with DataExch of CreateXML function.
    //   # Replace Parameter DataExchVIP with DataExch of SaveXMLToBLOB function.
    // HEI.07 FDD-HB899 - CHG2093869 IBM NASTAA02 26.02.2021 # LSR - Transfer and Stock
    //   # Code added to export the XML created

    Permissions = TableData "Data Exch." = rimd;
    //BC Upgrade VAMSIU01 >>
    //TableNo = "Data Exch. VIP";
    TableNo = "Data Exch.";
    //BC Upgrade VAMSIU01 <<

    trigger OnRun();
    var
        //BC Upgrade VAMSIU01 >>
        // DataExchVIP: Record "Data Exch. VIP";
        DataExchVIP: Record "Data Exch.";
        //BC Upgrade VAMSIU01 <<
        DataExchDef: Record "Data Exch. Def";
        TempXMLBuffer: Record "XML Buffer" temporary;
        TempGroupElement: Record "Coupling Record Buffer" temporary;
        OutputStream: OutStream;
        "--": Integer;
        InStr: InStream;
        OutStr: OutStream;
        FileManagement: Codeunit "File Management";
        //TempBlob: Record TempBlob temporary;//BC
        TempBlob: Codeunit "Temp Blob";//BC
        //BC Upgrade VAMSIU01 >>
        // TempDataExchVIP: Record "Data Exch. VIP" temporary;
        // DataExchFieldVIP: Record "Data Exch. Field VIP";
        TempDataExchVIP: Record "Data Exch." temporary;
        DataExchFieldVIP: Record "Data Exch. Field";
    //BC Upgrade VAMSIU01 <<
    begin
        DataExchDef.GET(Rec."Data Exch. Def Code");
        //<<HEI.06
        DataExchVIP.RESET;
        DataExchVIP.SETCURRENTKEY("Parent Data Exch. No. FND");

        DataExchVIP.SETRANGE("Parent Data Exch. No. FND", Rec."Entry No.");
        if DataExchVIP.FINDSET then
            //>>HEI.06
            repeat
                CreateXML(DataExchVIP, TempXMLBuffer, TempGroupElement);
                //<<HEI.06
                if not TempDataExchVIP.GET(DataExchVIP."Entry No.") then begin
                    TempDataExchVIP.INIT;
                    TempDataExchVIP."Entry No." := DataExchVIP."Entry No.";
                    TempDataExchVIP.INSERT;
                end;
            //>>HEI.06
            until DataExchVIP.NEXT = 0;

        //<<HEI.06
        if TempDataExchVIP.FINDSET then
            repeat
                DataExchFieldVIP.RESET;
                DataExchFieldVIP.SETCURRENTKEY("Data Exch. No.");
                DataExchFieldVIP.SETRANGE("Data Exch. No.", TempDataExchVIP."Entry No.");
                DataExchFieldVIP.DELETEALL(true);
            until TempDataExchVIP.NEXT = 0;
        TempDataExchVIP.DELETEALL;
        //>>HEI.06

        TempXMLBuffer.RESET;
        TempXMLBuffer.FINDFIRST;

        //SaveXMLToBLOB(Rec, TempXMLBuffer);//BC Upgrade VAMSIU01 - Commentted
        SaveXMLBufferToDataExch(Rec, TempXMLBuffer);//BC Upgrade VAMSIU01 - added

        //HEI.07>>//BC Upgrade VAMSIU01>>
        // Rec.CALCFIELDS("File Content");
        // Rec."File Content".CREATEINSTREAM(InStr);
        // TempBlob.Blob.CREATEOUTSTREAM(OutStr);
        // COPYSTREAM(OutStr, InStr);
        // FileManagement.BLOBExport(TempBlob, '.xml', true);
        //HEI.07<<//BC Upgrade VAMSIU01<<

    end;

    var
        DefaultNamespace: Text;

    //BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch. in CreateXML>>

    local procedure CreateXML(var DataExchVIP: Record "Data Exch."; var TempXMLBuffer: Record "XML Buffer"; var TempGroupElement: Record "Coupling Record Buffer");
    var
        //BC Upgrade VAMSIU01 >>
        // DataExchFieldVIP: Record "Data Exch. Field VIP";
        DataExchFieldVIP: Record "Data Exch. Field";
        //BC Upgrade VAMSIU01<<
        DataExchLineDef: Record "Data Exch. Line Def";
        PathExcludingName: Text;
        ElementName: Text;
        LastSeparatorPos: Integer;
        PrevLineNo: Integer;
    begin
        //<<HEI.06
        DataExchFieldVIP.RESET;
        DataExchFieldVIP.SETCURRENTKEY("Data Exch. No.");
        //DataExchField.SETRANGE("Data Exch. No.",DataExch."Entry No.");
        DataExchFieldVIP.SETRANGE("Data Exch. No.", DataExchVIP."Entry No.");
        //IF DataExchField.FINDSET THEN
        if DataExchFieldVIP.FINDSET(false) then
            //>>HEI.06
            repeat
                DataExchLineDef.GET(DataExchVIP."Data Exch. Def Code", DataExchFieldVIP."Data Exch. Line Def Code");
                LastSeparatorPos := LastSeparatorPosInString(DataExchFieldVIP."XML Node Path FND", '/');
                PathExcludingName := COPYSTR(DataExchFieldVIP."XML Node Path FND", 1, LastSeparatorPos);
                if (DataExchFieldVIP."Line No." <> PrevLineNo) and
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

                ElementName := COPYSTR(DataExchFieldVIP."XML Node Path FND", LastSeparatorPos + 1);
                if not TempGroupElement.GET(PathExcludingName) then
                    ExtractGroupElements(TempXMLBuffer, TempGroupElement, DataExchFieldVIP."XML Node Path FND");

                TempXMLBuffer.RESET;
                //HEI.03>>
                TempXMLBuffer.SETCURRENTKEY(Path);

                //HEI.03<<
                TempXMLBuffer.SETRANGE(Path, PathExcludingName);
                TempXMLBuffer.FINDLAST;
                TempXMLBuffer.RESET;

                if COPYSTR(DELCHR(ElementName, '=', '/'), 1, 1) = '@' then
                    TempXMLBuffer.AddAttribute(COPYSTR(DELCHR(ElementName, '=', '/'), 2), DataExchFieldVIP.Value)
                else
                    TempXMLBuffer.AddElement(DELCHR(ElementName, '=', '/'), DataExchFieldVIP.Value);

                PrevLineNo := DataExchFieldVIP."Line No.";
            until DataExchFieldVIP.NEXT = 0;

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
    procedure SaveXMLToBLOB(var DataExchVIP: Record "Data Exch."; var XMLBuffer: Record "XML Buffer");
    var
        TempXMLBuffer: Record "XML Buffer" temporary;
        TempAttributeXMLBuffer: Record "XML Buffer" temporary;
        XMLDOMManagement: Codeunit "XML DOM Management";
        // XmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; //BC Upgrade VAMSIU01
        // RootElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; //BC Upgrade VAMSIU01
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
        BankConnInterfaceSetup: Record "Bank Conn. Interface Setup INT";
        NonSEPAOutboundInterfaceCode: Code[20];
        SAGEInterfaceSetup: Record "SAGE Interface Setup INT";
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        // TempXMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";//BC Upgrade VAMSIU01
        XMLFileInStream: InStream;
    //TempXMLNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";//BC Upgrade VAMSIU01
    begin
        TempXMLBuffer.CopyImportFrom(XMLBuffer);
        TempXMLBuffer := XMLBuffer;
        TempXMLBuffer.SETCURRENTKEY("Parent Entry No.", Type, "Node Number");

        Header := '<?xml version="1.0" encoding="UTF-8"?>' +
          '<' + TempXMLBuffer.GetElementName + ' ';

        DefaultNamespace := TempXMLBuffer.GetAttributeValue('xmlns');
        if TempXMLBuffer.FindAttributes(TempAttributeXMLBuffer) then
            repeat
                Header += TempAttributeXMLBuffer.Name + '="' + TempAttributeXMLBuffer.Value + '" ';
            until TempAttributeXMLBuffer.NEXT = 0;
        Header += '/>';

        // XMLDOMManagement.LoadXMLDocumentFromText(Header, XmlDocument);
        // RootElement := XmlDocument.DocumentElement;

        // SaveChildElements(TempXMLBuffer, RootElement, XmlDocument);

        //HEI.02>>
        /*NonSEPAOutboundInterfaceCode := '';
        if BankConnInterfaceSetup.GET then
            NonSEPAOutboundInterfaceCode := BankConnInterfaceSetup."Non-SEPA Outbound Interface";

        if (NonSEPAOutboundInterfaceCode <> '') and (DataExchVIP."Data Exch. Def Code" = NonSEPAOutboundInterfaceCode) then begin
            CLEAR(NewXML);
            // SaveToFileName := RBMgt.ServerTempFileName('.xml');
            //SaveToFileNameClient := RBMgt.ClientTempFileName('.xml');
            //FileName := SaveToFileNameClient;
            // XmlDocument.Save(SaveToFileName);
            //RBMgt.DownloadToFile(SaveToFileName,FileName);
            //FullFileName := FileName;
            //filRead.OPEN(SaveToFileName);
            // filRead.OPEN(SaveToFileName, TEXTENCODING::UTF8);
            // filRead.CREATEINSTREAM(InStream);
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
            // if EXISTS(SaveToFileName) then
            //     if ERASE(SaveToFileName) then;
        end;
        //HEI.02<<

        //<<HEI.04
        SAGEInterfaceSetup.RESET;
        if SAGEInterfaceSetup.GET then;
        if (SAGEInterfaceSetup."Cust Direct Debit Interface" <> '') and (DataExchVIP."Data Exch. Def Code" = SAGEInterfaceSetup."Cust Direct Debit Interface") then begin
            //>>HEI.06
            //InterfaceEntryHeader.RESET;
            InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
            ///<<HEI.06
            InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExchVIP."Entry No.");
            InterfaceEntryHeader.FINDLAST;
            InterfaceEntryHeader.CALCFIELDS("XML File to Send");
            InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

            // if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:CUSTOMERDIRECTDEBITPAYMENT', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
            //     XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
            //     TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
            // end;
        end;
        //>>HEI.04

        //<<HEI.05
        SAGEInterfaceSetup.RESET;
        if SAGEInterfaceSetup.GET then;
        if (SAGEInterfaceSetup."Vendor SEPA interface" <> '') and (DataExchVIP."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor SEPA interface") then begin
            //<<HEI.06
            //InterfaceEntryHeader.RESET;
            InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
            //>>HEI.06
            InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExchVIP."Entry No.");
            InterfaceEntryHeader.FINDLAST;
            InterfaceEntryHeader.CALCFIELDS("XML File to Send");
            InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

            // if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORSEPAPAYMENT', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
            //     XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
            //     TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
            // end;
        end;

        if (SAGEInterfaceSetup."Vendor Non-SEPA interface" <> '') and (DataExchVIP."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor Non-SEPA interface") then begin
            //<<HEI.06
            //InterfaceEntryHeader.RESET;
            InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
            //>>HEI.06
            InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExchVIP."Entry No.");
            InterfaceEntryHeader.FINDLAST;
            InterfaceEntryHeader.CALCFIELDS("XML File to Send");
            InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

            // if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORNON-SEPAPAYMENT', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
            //     XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
            //     TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
            // end;
        end;

        if (SAGEInterfaceSetup."Vendor Fixed Asset SEPA IC" <> '') and (DataExchVIP."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor Fixed Asset SEPA IC") then begin
            //<<HEI.06
            //InterfaceEntryHeader.RESET;
            InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
            //>>HEI.06
            InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExchVIP."Entry No.");
            InterfaceEntryHeader.FINDLAST;
            InterfaceEntryHeader.CALCFIELDS("XML File to Send");
            InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

            if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORFIXEDASSETSEPAPAYMENTSIC', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
            end;
        end;

        if (SAGEInterfaceSetup."Vendor Fixed Asset SEPA Interf" <> '') and (DataExchVIP."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor Fixed Asset SEPA Interf") then begin
            ///<<HEI.06
            //InterfaceEntryHeader.RESET;
            InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
            //>>HEI.06
            InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExchVIP."Entry No.");
            InterfaceEntryHeader.FINDLAST;
            InterfaceEntryHeader.CALCFIELDS("XML File to Send");
            InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

            if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORFIXEDASSETSEPAPAYMENTS', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
            end;
        end;

        if (SAGEInterfaceSetup."Vendor SEPA BRED Interface" <> '') and (DataExchVIP."Data Exch. Def Code" = SAGEInterfaceSetup."Vendor SEPA BRED Interface") then begin
            ///<<HEI.06
            //InterfaceEntryHeader.RESET;
            InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
            //>>HEI.06
            InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExchVIP."Entry No.");
            InterfaceEntryHeader.FINDLAST;
            InterfaceEntryHeader.CALCFIELDS("XML File to Send");
            InterfaceEntryHeader."XML File to Send".CREATEINSTREAM(XMLFileInStream);

            if XMLDOMManagement.FindNodeWithNamespace(XmlDocument.DocumentElement, '/wss:VENDORSEPAPAYMENTSBRED', 'wss', 'http://www.boomi.com/connector/wss', TempXMLNode) then begin
                XMLDOMManagement.LoadXMLNodeFromInStream(XMLFileInStream, TempXMLNode2);
                TempXMLNode.InnerXml := TempXMLNode2.OuterXml;
            end;
        end;

        if (SAGEInterfaceSetup."Bank Account Balances" <> '') and (DataExchVIP."Data Exch. Def Code" = SAGEInterfaceSetup."Bank Account Balances") then begin
            ///<<HEI.06
            //InterfaceEntryHeader.RESET;
            InterfaceEntryHeader.SETCURRENTKEY("Data Exch. Entry No.");
            //>>HEI.06
            InterfaceEntryHeader.SETRANGE("Data Exch. Entry No.", DataExchVIP."Entry No.");
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
        DataExchVIP."File Content".CREATEOUTSTREAM(OutputStream, TEXTENCODING::UTF8);
        //XmlDocument.Save(OutputStream);
        if (NonSEPAOutboundInterfaceCode <> '') and (DataExchVIP."Data Exch. Def Code" = NonSEPAOutboundInterfaceCode) then
            NewXML.WRITE(OutputStream)
        else
            //XmlDocument.Save(OutputStream);
            //HEI.02<<
            DataExchVIP.MODIFY;
    end;

    local procedure SaveChildElements(var TempParentElementXMLBuffer: Record "XML Buffer" temporary; var XMLCurrElement: XMLNode; var XmlDocument: XMLDOcument; DefaultNamespace: Text);
    var
        TempElementXMLBuffer: Record "XML Buffer" temporary;
        // ChildElement: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        Namespace: Text;
    begin
        if TempParentElementXMLBuffer.FindChildElements(TempElementXMLBuffer) then
            repeat
                if TempElementXMLBuffer.Namespace = '' then
                    Namespace := DefaultNamespace
                else
                    Namespace := TempElementXMLBuffer.Namespace;
                // ChildElement := XmlDocument.CreateNode('element', TempElementXMLBuffer.GetElementName, Namespace);
                if TempElementXMLBuffer.Value <> '' then;
            // ChildElement.InnerText := TempElementXMLBuffer.Value;
            // XMLCurrElement.AppendChild(ChildElement);
            // SaveAttributes(TempElementXMLBuffer, ChildElement, XmlDocument);
            // SaveChildElements(TempElementXMLBuffer, ChildElement, XmlDocument);
            until TempElementXMLBuffer.NEXT = 0;
    end;

    local procedure SaveAttributes(var TempParentElementXMLBuffer: Record "XML Buffer" temporary; var XMLCurrElement: XMLNode; XmlDocument: XMLDOcument);
    var
        TempAttributeXMLBuffer: Record "XML Buffer" temporary;
    // Attribute: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlAttribute";
    begin
        if TempParentElementXMLBuffer.FindAttributes(TempAttributeXMLBuffer) then
            repeat
            // Attribute := XmlDocument.CreateAttribute(TempAttributeXMLBuffer.Name);
            // Attribute.InnerText := TempAttributeXMLBuffer.Value;
            // XMLCurrElement.Attributes.SetNamedItem(Attribute);
            until TempAttributeXMLBuffer.NEXT = 0;
    end;

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
    //BC Upgrade VAMSIU01 Changed from Data Exch VIP to Data Exch. in SaveXMLBufferToDataExch>>
    procedure SaveXMLBufferToDataExch(var DataExchRecVIP: Record "Data Exch."; var TempXMLBuffer: Record "XML Buffer" temporary)
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

        // Copy TempBlob → Data Exch File Content
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        Clear(DataExchRecVIP."File Content");
        DataExchRecVIP."File Content".CreateOutStream(OutStr, TextEncoding::UTF8);
        CopyStream(OutStr, InStr);

        // Persist changes
        DataExchRecVIP.Modify(true);
    end;

    //BC Upgrade VAMSIU01 end<<
}

