codeunit 58118 "Import Bank Statement CAMT053"
{
    // version BC

    // HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New codeunit for Bank Connectivity interface

    //BC UPGRADE KUMARR78 >>
    // Old Codeunit Id 50088 - "Import Bank Statement CAMT053"
    //
    // Upgrade Summary (OnPrem → SaaS BC27):
    //
    // 1. Removed all DotNet XML dependencies.
    //    - Old: System.Xml.XmlNode (DotNet)
    //    - Old: XmlAttributeCollection (DotNet)
    //    - Old: XmlNodeList (DotNet)
    //    - Old: XmlNodeType (DotNet)
    //
    // 2. Replaced DotNet XML handling with native AL XML types.
    //    - New: XmlNode
    //    - New: XmlElement
    //    - New: XmlText
    //    - New: XmlAttributeCollection
    //    - New: XmlNodeList
    //
    // 3. Replaced:
    //    XMLDOMManagement.LoadXMLNodeFromInStream(XMLStream, XmlNode);
    //    With custom SaaS-safe wrapper:
    //    LoadXMLNodeFromInStream(XMLStream, XmlNode);
    //
    // 4. Rewrote entire Parse() procedure for SaaS compatibility:
    //    - Removed:
    //         XMLNode.NodeType
    //         XMLNode.Attributes (DotNet style)
    //         XMLNode.ChildNodes
    //         XMLAttributeCollection.Item()
    //    - Implemented:
    //         XMLNode.IsXmlElement
    //         XMLNode.IsXmlText
    //         XmlElement.Attributes
    //         XmlElement.GetChildElements()
    //         XmlAttributeCollection.Get(Index, XmlAttribute)
    //
    // 5. Implemented Namespace validation using native XmlElement.NamespaceUri.
    //
    // 6. Added helper functions:
    //      - LoadXMLNodeFromInStream()
    //      - LoadXMLDocumentFromInStream()
    //      - ValidateNamespace()
    //
    // Functional Flow:
    //   OnRun()
    //     → Reads XML from Rec."File Content" (BLOB)
    //     → Loads XML into XmlNode
    //     → Retrieves Data Exchange Line Definition
    //     → Calls recursive Parse()
    //     → Parse() processes:
    //           - Elements
    //           - Attributes
    //           - Text nodes
    //     → InsertColumn() inserts parsed values into Data Exch. Field table
    //
    // Business Purpose:
    //   Imports CAMT053 Bank Statement XML files using Data Exchange Framework
    //   and maps XML nodes dynamically based on Data Exchange Definitions.
    //BC UPGRADE KUMARR78 <<

    Permissions = tabledata "Data Exch. Field" = rimd;
    TableNo = "Data Exch.";

    trigger OnRun();
    var
        DataExchLineDef: Record "Data Exch. Line Def";
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMLStream: InStream;
        LineNo: Integer;
        //XmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";  //BC UPGRADE KUMARR78 --
        XmlNode: XmlNode;  //BC UPGRADE KUMARR78 ++
    begin
        //HEI.01>>
        Rec."File Content".CreateInStream(XMLStream);
        // XMLDOMManagement.LoadXMLNodeFromInStream(XMLStream, XmlNode); //BC UPGRADE KUMARR78 --
        LoadXMLNodeFromInStream(XMLStream, XmlNode); //BC UPGRADE KUMARR78 ++

        DataExchLineDef.Get(Rec."Data Exch. Def Code", Rec."Data Exch. Line Def Code");//BC UPGRADE KUMARR78 Adding Rec. in Get Statement.

        Parse(DataExchLineDef, Rec."Entry No.", XmlNode, '', '', LineNo, LineNo);
        //HEI.01<<
    end;

    var
        ProgressWindow: Dialog;
        ProgressMsg: TextConst ENU = 'Preparing line number #1#######', FRA = 'Préparation du numéro de ligne #1#######';

    //BC UPGRADE KUMARR78 >> Blockng and Replacing Function.
    // local procedure Parse(DataExchLineDef: Record "Data Exch. Line Def"; EntryNo: Integer; XMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; ParentPath: Text; NodeId: Text[250]; var LastGivenLineNo: Integer; CurrentLineNo: Integer);
    // var
    //     CurrentDataExchLineDef: Record "Data Exch. Line Def";
    //     XMLAttributeCollection: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlAttributeCollection";
    //     XMLNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
    //     XMLNodeType: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeType";
    //     i: Integer;
    // begin
    //     //HEI.01>>
    //     CurrentDataExchLineDef.SETRANGE("Data Line Tag", ParentPath + '/' + XMLNode.LocalName);
    //     CurrentDataExchLineDef.SetRange("Data Exch. Def Code", DataExchLineDef."Data Exch. Def Code");
    //     if CurrentDataExchLineDef.FindFirst() then begin
    //         DataExchLineDef := CurrentDataExchLineDef;
    //         LastGivenLineNo += 1;
    //         CurrentLineNo := LastGivenLineNo;
    //         DataExchLineDef.ValidateNamespace(XMLNode);
    //     end;
    //     if XMLNode.NodeType.Equals(XMLNodeType.Text) or XMLNode.NodeType.Equals(XMLNodeType.CDATA) then
    //         InsertColumn(ParentPath, CurrentLineNo, NodeId, XMLNode.Value, DataExchLineDef, EntryNo);
    //     if not ISNULL(XMLNode.Attributes) then begin
    //         XMLAttributeCollection := XMLNode.Attributes;
    //         for i := 1 to XMLAttributeCollection.Count do
    //             InsertColumn(ParentPath + '/' + XMLNode.LocalName + '[@' + XMLAttributeCollection.Item(i - 1).Name + ']',
    //               CurrentLineNo, NodeId, XMLAttributeCollection.Item(i - 1).Value, DataExchLineDef, EntryNo);
    //     end;
    //     if XMLNode.HasChildNodes then begin
    //         XMLNodeList := XMLNode.ChildNodes;
    //         for i := 1 to XMLNodeList.Count do
    //             Parse(DataExchLineDef, EntryNo, XMLNodeList.Item(i - 1), ParentPath + '/' + XMLNode.LocalName,
    //               NodeId + Format(i, 0, '<Integer,4><Filler Char,0>'), LastGivenLineNo, CurrentLineNo);
    //     end;
    //     //HEI.01<<
    // end;
    //BC UPGRADE KUMARR78 << Blockng and Replacing Function.

    //BC UPGRADE KUMARR78 >> Rewritting Entire Function For SAAS.
    local procedure Parse(DataExchLineDef: Record "Data Exch. Line Def"; EntryNo: Integer; XMLNode: XmlNode; ParentPath: Text; NodeId: Text[250]; var LastGivenLineNo: Integer; CurrentLineNo: Integer)
    var
        CurrentDataExchLineDef: Record "Data Exch. Line Def";
        i: Integer;
        ElementName: Text;
        XMLAttribute: XmlAttribute;
        XMLAttributeCollection: XmlAttributeCollection;
        XmlElement: XmlElement;
        ChildNode: XmlNode;
        XMLNodeList: XmlNodeList;
        XmlText: XmlText;
    begin
        if XMLNode.IsXmlElement then begin
            XmlElement := XMLNode.AsXmlElement();
            ElementName := XmlElement.Name;

            CurrentDataExchLineDef.SetRange("Data Line Tag", ParentPath + '/' + ElementName);
            CurrentDataExchLineDef.SetRange("Data Exch. Def Code", DataExchLineDef."Data Exch. Def Code");

            if CurrentDataExchLineDef.FindFirst() then begin
                DataExchLineDef := CurrentDataExchLineDef;
                LastGivenLineNo += 1;
                CurrentLineNo := LastGivenLineNo;
                ValidateNamespace(XMLNode, DataExchLineDef);
            end;

            if XmlElement.HasAttributes then begin
                XMLAttributeCollection := XmlElement.Attributes();
                for i := 0 to XMLAttributeCollection.Count - 1 do begin
                    XMLAttributeCollection.Get(i, XMLAttribute);
                    InsertColumn(
                        ParentPath + '/' + ElementName + '[@' + XMLAttribute.Name + ']',
                        CurrentLineNo,
                        NodeId,
                        XMLAttribute.Value,
                        DataExchLineDef,
                        EntryNo);
                end;
            end;

            XMLNodeList := XmlElement.GetChildElements();

            for i := 0 to XMLNodeList.Count - 1 do begin
                XMLNodeList.Get(i, ChildNode);

                Parse(
                    DataExchLineDef,
                    EntryNo,
                    ChildNode,
                    ParentPath + '/' + ElementName,
                    NodeId + Format(i + 1, 0, '<Integer,4><Filler Char,0>'),
                    LastGivenLineNo,
                    CurrentLineNo);
            end;
        end;

        if XMLNode.IsXmlText then begin
            XmlText := XMLNode.AsXmlText();
            InsertColumn(
                ParentPath,
                CurrentLineNo,
                NodeId,
                XmlText.Value,
                DataExchLineDef,
                EntryNo);
        end;
    end;

    //BC UPGRADE KUMARR78 << Rewritting Entire Function For SAAS.
    local procedure InsertColumn(Path: Text; LineNo: Integer; NodeId: Text[250]; Value: Text; var DataExchLineDef: Record "Data Exch. Line Def"; EntryNo: Integer);
    var
        DataExchColumnDef: Record "Data Exch. Column Def";
        DataExchField: Record "Data Exch. Field";
    begin
        //HEI.01>>
        // Note: The Data Exch. variable is passed by reference only to improve performance.
        DataExchColumnDef.SetRange("Data Exch. Def Code", DataExchLineDef."Data Exch. Def Code");
        DataExchColumnDef.SetRange("Data Exch. Line Def Code", DataExchLineDef.Code);
        DataExchColumnDef.SetRange(Path, Path);

        if DataExchColumnDef.FindFirst() then begin
            ProgressWindow.Update(1, LineNo);
            DataExchField.InsertRecXMLField(EntryNo, LineNo, DataExchColumnDef."Column No.", NodeId, Value,
              DataExchLineDef.Code);
        end;
        //HEI.01<<
    end;

    //BC UPGRADE KUMARR78 >> Adding Functions
    procedure LoadXMLNodeFromInStream(pInStream: InStream; var pXMLNode: XmlNode)
    var
        lXmlDocument: XmlDocument;
    begin
        LoadXMLDocumentFromInStream(pInStream, lXmlDocument);
        pXMLNode := lXmlDocument.AsXmlNode();
    end;

    procedure LoadXMLDocumentFromInStream(pInStream: InStream; var pXMLDocument: XmlDocument)
    begin
        XmlDocument.ReadFrom(pInStream, pXMLDocument);
    end;

    procedure ValidateNamespace(XMLNode: XmlNode; Rec: Record "Data Exch. Line Def")
    var
        IncorrectNamespaceErr: Label 'The imported file contains unsupported namespace "%1". The supported namespace is ''%2''.', Comment = '%1=file namespace,%2=supported namespace';
        NamespaceURI: Text;
        XmlElement: XmlElement;

    begin
        if Rec.Namespace <> '' then
            if XMLNode.IsXmlElement then begin
                XmlElement := XMLNode.AsXmlElement();
                NamespaceURI := XmlElement.NamespaceUri;

                if NamespaceURI <> Rec.Namespace then
                    Error(IncorrectNamespaceErr, NamespaceURI, Rec.Namespace);
            end;
    end;
    //BC UPGRADE KUMARR78 << Adding Functions
}

