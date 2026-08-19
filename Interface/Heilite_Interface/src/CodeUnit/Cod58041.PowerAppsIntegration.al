codeunit 58041 "PowerApps Integration"
{
    // version HEI.02
    //BC Upgrade GUNREM01 -Old ID 50118
    // HEI.01 CHG2061421 IBM NASTAA02 02.06.2020 # PowerApps Indicator
    //   # New Codeunit created for PowerApps Indicator
    // HEI.02 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables
    //BC Upgrade GUNREM01 reaplaced DotNet varibales with XML variable due to deprecation of DotNet in BC
    //  # Commented the DotNet variables
    // And added code based on the new XmlDocument variable methods. But we have to check the fucntionality becuase there are some changes in methods.

    trigger OnRun();
    var
        //  XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        XMLDoc: XmlDocument; //BC Upgrade GUNREM01 
    begin
    end;

    var
        CurrentElementName: Text;
        UserIDString: Text;
        UserIDString2: Text;

    procedure ProcessPowerAppsRequest(var Request: BigText);
    var
        OutputStream: OutStream;
        OutputStream2: OutStream;
        InputStream: InStream;
        //    XmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        XmlDoc: XmlDocument; //BC Upgrade GUNREM01
        //XMLRootNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLRootNode: XmlNode; //BC Upgrade GUNREM01
                              // XMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLNode: XmlNode; //BC Upgrade GUNREM01
                          //    XMLNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        XMLNodeList: XmlNodeList; //BC Upgrade GUNREM01

        //  DOMNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        DOMNode: XmlNode; //BC Upgrade GUNREM01
        i: Integer;
        InterfaceEntryHeaderBuffer: Record "Interface Entry Header INT" temporary;
        User: Record User;
        //  ResponseXMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXMLDoc: XmlDocument; //BC Upgrade GUNREM01
        OutputStream3: OutStream;
        InputStream3: InStream;
        // TempBlob: Record TempBlob;
        TempBlob: Codeunit "Temp Blob"; //BC Upgrade GUNREM01

    begin
        //Add XML file to temp Record
        CLEAR(InterfaceEntryHeaderBuffer);
        InterfaceEntryHeaderBuffer.INIT;
        InterfaceEntryHeaderBuffer."Entry No." := 1;
        InterfaceEntryHeaderBuffer.INSERT;
        InterfaceEntryHeaderBuffer.Notes.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        InterfaceEntryHeaderBuffer.MODIFY;

        //Parse the XML to search the UserID
        InterfaceEntryHeaderBuffer.CALCFIELDS(Notes);
        InterfaceEntryHeaderBuffer.Notes.CREATEINSTREAM(InputStream);
        //BC Upgrade GUNREM01 commented for replacement becuase of XmlDocument deprecation >>
        // XmlDoc := XmlDoc.XmlDocument;
        // XmlDoc.Load(InputStream);
        // XMLNodeList := XmlDoc.ChildNodes;
        // UserIDString := '';

        // for i := 0 to XMLNodeList.Count - 1 do begin
        //     DOMNode := XMLNodeList.Item(i);
        //     ParseForUserID(DOMNode);
        // end;
        //BC Upgrade GUNREM01 commented for replacement becuase of XmlDocument deprecation <<
        //BC Upgrade GUNREM01 replacement >>
        XmlDocument.ReadFrom(InputStream, XmlDoc);
        XMLNodeList := XmlDoc.GetChildNodes();
        UserIDString := '';
        for i := 0 to XMLNodeList.Count() - 1 do begin
            if XMLNodeList.Get(i, DOMNode) then
                ParseForUserID(DOMNode);
        end;
        //BC Upgrade GUNREM01 replacement <<
        //Check if User has permissions & create response
        if UserIDString <> '' then begin
            UserIDString2 := 'heiway\' + DELSTR(UserIDString, 9);
            User.SETRANGE("User Name", UserIDString2);
            User.SETRANGE(State, User.State::Enabled);
            if User.FINDFIRST then
                CreatePowerAppsResponse(ResponseXMLDoc, true)
            else
                CreatePowerAppsResponse(ResponseXMLDoc, false);
        end;

        //Send Response
        //BC Upgrade GUNREM01 Commeneted becuase Blob fucntion is not available in Temp Blob codeunit >>
        // TempBlob.Blob.CREATEOUTSTREAM(OutputStream3);
        // ResponseXMLDoc.Save(OutputStream3);
        // TempBlob.Blob.CREATEINSTREAM(InputStream3);
        //BC Upgrade GUNREM01 commented becuase Blob fucntion is not available in Temp Blob codeunit <<

        //BC Upgrade GUNREM01 Added replacement for Blob fucntion in Temp Blob codeunit >>
        TempBlob.CreateOutStream(OutputStream3);
        ResponseXMLDoc.WriteTo(OutputStream3);
        TempBlob.CreateInStream(InputStream3);
        //BC Upgrade GUNREM01 Added replacement for Blob fucntion in Temp Blob codeunit <<
        CLEAR(Request);
        Request.READ(InputStream3);

        //HEI.02>>
        CLEAR(OutputStream);
        CLEAR(OutputStream3);
        CLEAR(InputStream);
        CLEAR(InputStream3);
        CLEAR(XmlDoc);
        CLEAR(XMLNodeList);
        CLEAR(DOMNode);
        CLEAR(ResponseXMLDoc);
        //HEI.02<<
    end;
    //BC Upgrade GUNREM01 commented for replacement becuase of XmlDocument deprecation >>
    //  local procedure ParseForUserID(CurrentXMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    //  local procedure ParseForUserID(CurrentXMLNode: XmlNode);//BC Upgrade GUNREM01

    //   var
    //       //   TempXMLNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
    //       TempXMLNodeList: XmlNodeList; //BC Upgrade GUNREM01
    //                                     //  TempXMLAttributeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlAttributeCollection";
    //       TempXMLAttributeList: XmlAttributeCollection; //BC Upgrade GUNREM01
    //       j: Integer;
    //       k: Integer;
    //       // CurrentXMLNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //       CurrentXMLNode2: XmlNode; //BC Upgrade GUNREM01
    //       XMLnode: XmlNode; //BC Upgrade GUNREM01
    //       xmlElement: XmlElement; //BC Upgrade GUNREM01
    //       XMLattribute: XmlAttribute; //BC Upgrade GUNREM01
    //       M: Integer;
    //       tempxmlattribute: XmlAttribute; //BC Upgrade GUNREM01
    //   begin
    //       CurrentXMLNode2 := CurrentXMLNode;
    //     case FORMAT(CurrentXMLNode2.NodeType) of
    //       'Element': // Element
    //         begin
    //           CurrentElementName := CurrentXMLNode2.Name;

    //           // If the element has attributes, then browse through those.
    //           TempXMLAttributeList := CurrentXMLNode2.Attributes;
    //           for k := 0 to TempXMLAttributeList.Count - 1 do
    //             ParseForUserID(TempXMLAttributeList.Item(k));

    //           // Process Child nodes
    //           TempXMLNodeList := CurrentXMLNode2.ChildNodes;
    //           for j := 0 to TempXMLNodeList.Count - 1 do
    //             ParseForUserID(TempXMLNodeList.Item(j));
    //         end;

    //       'Text': //Values
    //         if CurrentElementName = 'UserID' then
    //           UserIDString := CurrentXMLNode2.Value;
    //     end;

    //     //HEI.02>>
    //     CLEAR(TempXMLNodeList);
    //     CLEAR(TempXMLAttributeList);
    //     CLEAR(CurrentXMLNode2);
    //     //HEI.02<<
    // end;
    //BC Upgrade GUNREM01 commented for replacement becuase of XmlDocument deprecation <<

    //BC Upgrade GUNREM01 created procedure of ParseForUserID using Xml Variables >>
    local procedure ParseForUserID(CurrentXMLNode: XmlNode)
    var
        TempXMLNodeList: XmlNodeList;
        TempXMLAttributeList: XmlAttributeCollection;
        XmlAttr: XmlAttribute;
        XmlElem: XmlElement;
        XmlTxt: XmlText;
        ChildNode: XmlNode;
        Y: Integer;
        k: Integer;
        CurrentXMLNode2: XmlNode;
    begin
        if CurrentXMLNode.IsXmlElement() then begin
            XmlElem := CurrentXMLNode.AsXmlElement();
            CurrentElementName := XmlElem.Name();

            TempXMLAttributeList := XmlElem.Attributes();
            for k := 0 to TempXMLAttributeList.Count() - 1 do begin
                if TempXMLAttributeList.Get(k, XmlAttr) then begin
                    if XmlAttr.Name() = 'UserID' then
                        UserIDString := XmlAttr.Value();
                end;
            end;
            XmlElem.SelectNodes('*', TempXMLNodeList);
            for Y := 0 to TempXMLNodeList.Count() - 1 do begin
                if TempXMLNodeList.Get(Y, ChildNode) then
                    ParseForUserID(ChildNode);
            end;
        end else if CurrentXMLNode.IsXmlText() then begin
            XmlTxt := CurrentXMLNode.AsXmlText();

            if CurrentElementName = 'UserID' then
                UserIDString := XmlTxt.Value();
        end;
        //HEI.02>>
        CLEAR(TempXMLNodeList);
        CLEAR(TempXMLAttributeList);
        CLEAR(CurrentXMLNode2);
        //HEI.02<<
    end;
    //BC Upgrade GUNREM01 created procedure of ParseForUserID using Xml Variables <<


    // local procedure CreatePowerAppsResponse(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; UserFound: Boolean);
    local procedure CreatePowerAppsResponse(var XMLDoc: XmlDocument; UserFound: Boolean)//BC Upgrade GUNREM01
    var
        //XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLCurrNode2: XmlNode; //BC Upgrade GUNREM01
        //  ProcessingInstruction: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlProcessingInstruction";
        ProcessingInstruction: XmlProcessingInstruction; //BC Upgrade GUNREM01
        XMLDOMMgt: Codeunit "XML DOM Management";
        //  XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        XMLCurrNode: XmlNode; //BC Upgrade GUNREM01
        // NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        NewChildNode: XmlNode; //BC Upgrade GUNREM01
        //  NewChildNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        NewChildNode2: XmlNode; //BC Upgrade GUNREM01
        NoOfUsers: Integer;
        NoOfDBLocks: Integer;
        NoOfOrdersLastHour: Integer;
        NoOfOrdersSinceMorning: Integer;
        NoOfInvoicesLastHour: Integer;
        NoOfInvoicesSinceMorning: Integer;
        ActiveSession: Record "Active Session";
        DatabaseLocks: Record "Database Locks";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Duration: BigInteger;
        IntHours: Integer;
        IntMin: Integer;
        DurationInv: BigInteger;
        IntHoursInv: Integer;
        InterfaceEntryHeaderBuffer: Record "Interface Entry Header INT" temporary;
        OutputStream: OutStream;
        InputStream: InStream;
        //  TempBlob: Record TempBlob temporary;
        TempBlob: Codeunit "Temp Blob"; //BC Upgrade GUNREM01
        FileManagement: Codeunit "File Management";
        XMLElement: XmlElement; //BC Upgrade GUNREM01
        RootNode: XmlElement;
        Declaration: XmlDeclaration; //BC Upgrade GUNREM01

    begin
        // XMLDoc := XMLDoc.XmlDocument;

        //XMLCurrNode2 := XMLDoc.CreateElement('ReadMultiple_Result');
        //XMLDoc.AppendChild(XMLCurrNode2);

        // XMLCurrNode := XMLDoc.CreateElement('PowerApps');

        // XMLDoc.AppendChild(XMLCurrNode);

        XMLDoc.GetRoot(XMLElement);
        XMLCurrNode := XMLElement.AsXmlNode();
        //XMLCurrNode2.AppendChild(XMLCurrNode);

        // ProcessingInstruction := XMLDoc.CreateProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"?'); //BC Upgrade GUNREM01
        //BC Upgrade GUNREM01 replaced above line >>
        XmlDoc := XmlDocument.Create();
        Declaration := XmlDeclaration.Create('1.0', 'utf-8', 'yes');
        XmlDoc.SetDeclaration(Declaration);
        //BC Upgrade GUNREM01 replaced above line <<


        NoOfUsers := 0;
        NoOfDBLocks := 0;
        NoOfOrdersLastHour := 0;
        NoOfOrdersSinceMorning := 0;
        NoOfInvoicesLastHour := 0;
        NoOfInvoicesSinceMorning := 0;

        ActiveSession.RESET;
        if ActiveSession.FINDSET then
            NoOfUsers := ActiveSession.COUNT;

        DatabaseLocks.RESET;
        if DatabaseLocks.FINDSET then
            NoOfDBLocks := DatabaseLocks.COUNT;

        SalesShipmentHeader.RESET;
        SalesShipmentHeader.SETRANGE("Posting Date", TODAY);
        if SalesShipmentHeader.FINDSET then
            repeat
                CLEAR(Duration);
                IntHours := 0;
                //  Duration := CURRENTDATETIME - SalesShipmentHeader."Creation Date/Time"; //BC Upgrade GUNREM01 -"Creation Date/Time" field is DIT
                IntHours := Duration div (60 * 60 * 1000);
                if IntHours < 1 then
                    NoOfOrdersLastHour += 1;
                if IntHours <= 24 then
                    NoOfOrdersSinceMorning += 1;
            until SalesShipmentHeader.NEXT = 0;

        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("Posting Date", TODAY);
        if SalesInvoiceHeader.FINDSET then
            repeat
                CLEAR(DurationInv);
                IntHoursInv := 0;
                //     DurationInv := CURRENTDATETIME - SalesInvoiceHeader."Creation Date/Time"; //BC Upgrade GUNREM01 -"Creation Date/Time" field is DIT
                IntHoursInv := DurationInv div (60 * 60 * 1000);
                if IntHoursInv < 1 then
                    NoOfInvoicesLastHour += 1;
                if IntHours <= 24 then
                    NoOfInvoicesSinceMorning += 1;
            until SalesInvoiceHeader.NEXT = 0;

        if UserFound then begin
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoofUsers', FORMAT(NoOfUsers), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoOfDBBlocks', FORMAT(NoOfDBLocks), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoOfOrderslasthr', FORMAT(NoOfOrdersLastHour), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoOfOrderssincemorning', FORMAT(NoOfOrdersSinceMorning), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoOfInvoicelasthr', FORMAT(NoOfInvoicesLastHour), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoOfInvoicesincemorning', FORMAT(NoOfInvoicesSinceMorning), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'UserID', FORMAT(UserIDString2), '', NewChildNode);
        end else begin
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoofUsers', FORMAT(0), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoOfDBBlocks', FORMAT(0), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoOfOrderslasthr', FORMAT(0), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoOfOrderssincemorning', FORMAT(0), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'NoOfInvoicelasthr', FORMAT(0), '', NewChildNode);
            XMLDOMMgt.AddElement(XMLCurrNode, 'UserID', '', '', NewChildNode);
        end;

        //HEI.02>>
        CLEAR(ProcessingInstruction);
        CLEAR(XMLDOMMgt);
        CLEAR(XMLCurrNode);
        CLEAR(NewChildNode);
        //HEI.02<<
    end;
}

