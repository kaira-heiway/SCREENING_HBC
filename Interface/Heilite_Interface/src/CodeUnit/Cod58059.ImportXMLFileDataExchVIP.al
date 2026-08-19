codeunit 58059 "Import XMLFile Data Exch VIP"
{
    //BC Upgrade VAMSIU01- Navision Old Id - 50156

    // version NAVW110.0.00.15052,HEI.01

    // HEI.01 HLSRM05 IBM LAZARE02 30.08.2017 # Call LoadXMLDocumentFromInStreamWithEncoding if Encoding is not blank on data exchange
    // HEI.02 CHG2095187 IBM SAXENA03 18.02.2021
    //   # Code written for Paraller Request
    //   # Created New object Codeunit Import XML file Data Exch VIP , replica of 1203.

    //BC Upgrade VAMSIU01 - Added New Functions ParseParentChildDocumentCloud,ParseParentChildLineCloud,IsAlphanumeric.

    Permissions = TableData "Data Exch. Field" = rimd;
    TableNo = "Data Exch. VIP INT";

    trigger OnRun();
    begin
        StartTime := CURRENTDATETIME;
        UpdateProgressWindow(0);

        //ParseParentChildDocument(Rec);  //BC Upgrade VAMSIU01
        ParseParentChildDocumentCloud(Rec); //BC Upgrade VAMSIU01

        if WindowOpen then
            ProgressWindow.CLOSE;
    end;

    var
        ProgressMsg: TextConst ENU = 'Preparing line number #1#######', FRA = 'Préparation du numéro de ligne #1#######';
        ProgressWindow: Dialog;
        WindowOpen: Boolean;
        StartTime: DateTime;
    //BC Upgrade VAMSIU01 - Start
    //     local procedure ParseParentChildDocument(DataExchVIP: Record "Data Exch. VIP INT");
    //     var
    //         DataExchDef: Record "Data Exch. Def";
    //         DataExchLineDef: Record "Data Exch. Line Def";
    //         XMLDOMManagement: Codeunit "XML DOM Management";
    //         XmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
    //         XmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
    //         XmlNamespaceManager: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNamespaceManager";
    //         XmlStream: InStream;
    //         CurrentLineNo: Integer;
    //         NodeID: Text[250];
    //         I: Integer;
    //         NodeCount: Integer;
    //         MyXmlText: Text;//BC Upgrade VAMSIU01
    //         XmlRoot: XmlElement;//BC Upgrade VAMSIU01
    //         XmlNode: XmlNode;
    //     begin
    //         DataExchDef.GET(DataExchVIP."Data Exch. Def Code");
    //         DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchDef.Code);
    //         DataExchLineDef.SETRANGE("Parent Code", '');
    //         if not DataExchLineDef.FINDSET then
    //             exit;

    //         DataExchVIP."File Content".CREATEINSTREAM(XmlStream);
    //         //HEI.01>>
    //         //XMLDOMManagement.LoadXMLDocumentFromInStream(XmlStream,XmlDocument);
    //         if DataExchVIP."File Encoding" = '' then
    //             XMLDOMManagement.LoadXMLDocumentFromInStream(XmlStream, XmlDocument)
    //         else
    //             XMLDOMManagement.LoadXMLDocumentFromInStreamWithEncoding(XmlStream, XmlDocument, DataExchVIP."File Encoding"); //BC Upgrade VAMSIU01
    //                                                                                                                            // //HEI.01<<
    //         DataExchLineDef.ValidateNamespace(XmlDocument.DocumentElement);
    //         XMLDOMManagement.AddNamespaces(XmlNamespaceManager, XmlDocument);

    //         repeat
    //             XMLDOMManagement.FindNodesWithNamespaceManager(
    //    XmlDocument, EscapeMissingNamespacePrefix(DataExchLineDef."Data Line Tag"), XmlNamespaceManager, XmlNodeList);
    //             CurrentLineNo := 1;
    //             NodeCount := XmlNodeList.Count;
    //             for I := 1 to NodeCount do begin
    //                 if XmlNodeList.Get(I, XmlNode) then
    //                     NodeID := IncreaseNodeID('', CurrentLineNo);
    //                 ParseParentChildLine(
    //                   XmlNodeList.ItemOf(I - 1), NodeID, '', CurrentLineNo, DataExchLineDef, DataExchVIP."Entry No.", XmlNamespaceManager);
    //                 CurrentLineNo += 1;
    //             end;
    //         until DataExchLineDef.NEXT = 0;
    //     end;


    //     local procedure ParseParentChildLine(CurrentXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; NodeID: Text[250]; ParentNodeID: Text[250]; CurrentLineNo: Integer; CurrentDataExchLineDef: Record "Data Exch. Line Def"; EntryNo: Integer; XmlNamespaceManager: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNamespaceManager");
    //     var
    //         DataExchColumnDef: Record "Data Exch. Column Def";
    //         DataExchLineDef: Record "Data Exch. Line Def";
    //         DataExchFieldVIP: Record "Data Exch. Field VIP INT";
    //         XMLDOMManagement: Codeunit "XML DOM Management";
    //         // XmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
    //         XmlNodelist: XmlNodeList;//BC Upgrade VAMSIU01
    //         CurrentIndex: Integer;
    //         CurrentNodeID: Text[250];
    //         LastLineNo: Integer;
    //         I: Integer;
    //         NodeCount: Integer;
    //     begin
    //         DataExchFieldVIP.InsertRecXMLFieldDefinition(EntryNo, CurrentLineNo, NodeID, ParentNodeID, '', CurrentDataExchLineDef.Code);

    //         // Insert Attributes and values
    //         DataExchColumnDef.SETRANGE("Data Exch. Def Code", CurrentDataExchLineDef."Data Exch. Def Code");
    //         DataExchColumnDef.SETRANGE("Data Exch. Line Def Code", CurrentDataExchLineDef.Code);
    //         DataExchColumnDef.SETFILTER(Path, '<>%1', '');

    //         CurrentIndex := 1;

    //         if DataExchColumnDef.FINDSET then
    //             repeat
    //                 XMLDOMManagement.FindNodesWithNamespaceManager(
    //                   CurrentXmlNode,
    //                   GetRelativePath(DataExchColumnDef.Path, CurrentDataExchLineDef."Data Line Tag"),
    //                   XmlNamespaceManager,
    //                   XmlNodeList);

    //                 NodeCount := XmlNodeList.Count;
    //                 for I := 1 to NodeCount do begin
    //                     CurrentNodeID := IncreaseNodeID(NodeID, CurrentIndex);
    //                     CurrentIndex += 1;
    //                     InsertColumn(
    //                       DataExchColumnDef.Path, CurrentLineNo, CurrentNodeID, ParentNodeID, XmlNodeList.ItemOf(I - 1).InnerText,
    //                       CurrentDataExchLineDef, EntryNo);
    //                 end;
    //             until DataExchColumnDef.NEXT = 0;

    //         // insert Constant values
    //         DataExchColumnDef.SETFILTER(Path, '%1', '');
    //         DataExchColumnDef.SETFILTER(Constant, '<>%1', '');
    //         if DataExchColumnDef.FINDSET then
    //             repeat
    //                 CurrentNodeID := IncreaseNodeID(NodeID, CurrentIndex);
    //                 CurrentIndex += 1;
    //                 DataExchFieldVIP.InsertRecXMLFieldWithParentNodeID(EntryNo, CurrentLineNo, DataExchColumnDef."Column No.",
    //                   CurrentNodeID, ParentNodeID, DataExchColumnDef.Constant, CurrentDataExchLineDef.Code);
    //             until DataExchColumnDef.NEXT = 0;

    //         // Insert Children
    //         DataExchLineDef.SETRANGE("Data Exch. Def Code", CurrentDataExchLineDef."Data Exch. Def Code");
    //         DataExchLineDef.SETRANGE("Parent Code", CurrentDataExchLineDef.Code);

    //         if DataExchLineDef.FINDSET then
    //             repeat
    //                 XMLDOMManagement.FindNodesWithNamespaceManager(
    //                   CurrentXmlNode,
    //                   GetRelativePath(DataExchLineDef."Data Line Tag", CurrentDataExchLineDef."Data Line Tag"),
    //                   XmlNamespaceManager,
    //                   XmlNodeList);

    //                 DataExchFieldVIP.SETRANGE("Data Exch. No.", EntryNo);
    //                 DataExchFieldVIP.SETRANGE("Data Exch. Line Def Code", DataExchLineDef.Code);
    //                 LastLineNo := 1;
    //                 if DataExchFieldVIP.FINDLAST then
    //                     LastLineNo := DataExchFieldVIP."Line No." + 1;

    //                 NodeCount := XmlNodeList.Count;
    //                 for I := 1 to NodeCount do begin
    //                     CurrentNodeID := IncreaseNodeID(NodeID, CurrentIndex);
    //                     ParseParentChildLine(
    //                       XmlNodeList.ItemOf(I - 1), CurrentNodeID, NodeID, LastLineNo, DataExchLineDef, EntryNo, XmlNamespaceManager);
    //                     CurrentIndex += 1;
    //                     LastLineNo += 1;
    //                 end;
    //             until DataExchLineDef.NEXT = 0;
    //     end;
    //BC Upgrade VAMSIU01 - end

    local procedure InsertColumn(Path: Text; LineNo: Integer; NodeId: Text[250]; ParentNodeId: Text[250]; Value: Text; var DataExchLineDef: Record "Data Exch. Line Def"; EntryNo: Integer);
    var
        DataExchColumnDef: Record "Data Exch. Column Def";
        DataExchFieldVIP: Record "Data Exch. Field VIP INT";
    begin
        // Note: The Data Exch. variable is passed by reference only to improve performance.
        DataExchColumnDef.SETRANGE("Data Exch. Def Code", DataExchLineDef."Data Exch. Def Code");
        DataExchColumnDef.SETRANGE("Data Exch. Line Def Code", DataExchLineDef.Code);
        DataExchColumnDef.SETRANGE(Path, Path);

        if DataExchColumnDef.FINDFIRST then begin
            UpdateProgressWindow(LineNo);
            DataExchFieldVIP.InsertRecXMLFieldWithParentNodeID(EntryNo, LineNo, DataExchColumnDef."Column No.", NodeId, ParentNodeId, Value,
              DataExchLineDef.Code);
        end;
    end;

    local procedure GetRelativePath(ChildPath: Text[250]; ParentPath: Text[250]): Text;
    var
        XMLDOMManagement: Codeunit "XML DOM Management";
    begin
        exit(EscapeMissingNamespacePrefix(XMLDOMManagement.GetRelativePath(ChildPath, ParentPath)));
    end;

    local procedure IncreaseNodeID(NodeID: Text[250]; Seed: Integer): Text[250];
    begin
        exit(NodeID + FORMAT(Seed, 0, '<Integer,4><Filler Char,0>'))
    end;

    procedure EscapeMissingNamespacePrefix(XPath: Text): Text;
    var
        TypeHelper: Codeunit "Type Helper";
        PositionOfFirstSlash: Integer;
        FirstXPathElement: Text;
        RestOfXPath: Text;
    begin
        // we will let the user define XPaths without the required namespace prefix
        // however, if he does that, we will only consider the XPath element as a local name
        // for example, we will turn XPath /Invoice/cac:InvoiceLine into /*[local-name() = 'Invoice']/cac:InvoiceLine
        PositionOfFirstSlash := STRPOS(XPath, '/');
        case PositionOfFirstSlash of
            1:
                exit('/' + EscapeMissingNamespacePrefix(COPYSTR(XPath, 2)));
            0:
                begin
                    // if (XPath = '') or (not TypeHelper.IsAlphanumeric(XPath)) then//BC Upgrade VAMSIU01
                    //     exit(XPath);//BC Upgrade VAMSIU01
                    if (XPath = '') or (not IsAlphanumeric(XPath)) then   //BC Upgrade VAMSIU01
                        exit(STRSUBSTNO('*[local-name() = ''%1'']', XPath));
                end;
            else begin
                FirstXPathElement := DELSTR(XPath, PositionOfFirstSlash);
                RestOfXPath := COPYSTR(XPath, PositionOfFirstSlash);
                exit(EscapeMissingNamespacePrefix(FirstXPathElement) + EscapeMissingNamespacePrefix(RestOfXPath));
            end;
        end;
    end;

    local procedure UpdateProgressWindow(LineNo: Integer);
    var
        PopupDelay: Integer;
    begin
        PopupDelay := 1000;
        if CURRENTDATETIME - StartTime < PopupDelay then
            exit;

        StartTime := CURRENTDATETIME; // only update every PopupDelay ms

        if not WindowOpen then begin
            ProgressWindow.OPEN(ProgressMsg);
            WindowOpen := true;
        end;

        ProgressWindow.UPDATE(1, LineNo);
    end;

    //BC Upgrade VAMSIU01 -Start New Functions

    local procedure ParseParentChildDocumentCloud(DataExchVIP: Record "Data Exch. VIP INT");
    var
        DataExchDef: Record "Data Exch. Def";
        DataExchLineDef: Record "Data Exch. Line Def";
        XMLDOMManagement: Codeunit "XML DOM Management";
        XMlDocument: XmlDocument;
        XmlNodeList: XmlNodeList;
        HeinekenintBCupgrade: Codeunit "Heineken Interface BC Upgrade";
        XmlStream: InStream;
        CurrentLineNo: Integer;
        NodeID: Text[250];
        I: Integer;
        NodeCount: Integer;
        XmlRoot: XmlElement;
        XmlNode: XmlNode;
        XmlNsMgr: XmlNamespaceManager;
        TempBlob: Codeunit "Temp Blob";
    begin
        DataExchDef.GET(DataExchVIP."Data Exch. Def Code");
        DataExchLineDef.SETRANGE("Data Exch. Def Code", DataExchDef.Code);
        DataExchLineDef.SETRANGE("Parent Code", '');
        if not DataExchLineDef.FINDSET then
            exit;

        DataExchVIP."File Content".CREATEINSTREAM(XmlStream);
        if DataExchVIP."File Encoding" = '' then
            LoadXmlFromStream(XmlStream, XMlDocument)
        else
            HeinekenintBCupgrade.LoadXMLDocumentFromInStreamSaaS(XmlStream, XMlDocument);

        XMlDocument.GetRoot(XmlRoot);
        XmlNsMgr.AddNamespace('ns', XmlRoot.NamespaceUri());

        repeat

            XMLDOMManagement.FindNodesWithNamespaceManager(
              XmlRoot.AsXmlNode(), EscapeMissingNamespacePrefix(DataExchLineDef."Data Line Tag"), XmlNsMgr, XmlNodeList);
            CurrentLineNo := 1;
            NodeCount := XmlNodeList.Count;
            for I := 1 to NodeCount do begin
                if not XmlNodeList.Get(I, XmlNode) then
                    Error('XML node could not be read at index %1.', I);
                NodeID := IncreaseNodeID('', CurrentLineNo);
                ParseParentChildLineCloud(XmlRoot.AsXmlNode(), NodeID, '', CurrentLineNo, DataExchLineDef, DataExchVIP."Entry No.", XmlNsMgr);
                CurrentLineNo += 1;
            end;
        until DataExchLineDef.NEXT = 0;
    end;

    local procedure ParseParentChildLineCloud(CurrentXmlNode: XmlNode; NodeID: Text[250]; ParentNodeID: Text[250]; CurrentLineNo: Integer; CurrentDataExchLineDef: Record "Data Exch. Line Def"; EntryNo: Integer; XmlNamespaceMgr: XmlNamespaceManager)
    var
        DataExchColumnDef: Record "Data Exch. Column Def";
        DataExchLineDef: Record "Data Exch. Line Def";
        DataExchFieldVIP: Record "Data Exch. Field VIP INT";
        XMLDOMManagement: Codeunit "XML DOM Management";
        XmlNodelist: XmlNodeList;
        CurrentIndex: Integer;
        CurrentNodeID: Text[250];
        LastLineNo: Integer;
        I: Integer;
        NodeCount: Integer;
        XmlChildNode: XmlNode;
        XmlElement: XmlElement;
    begin
        DataExchFieldVIP.InsertRecXMLFieldDefinition(EntryNo, CurrentLineNo, NodeID, ParentNodeID, '', CurrentDataExchLineDef.Code);

        // Insert Attributes and values
        DataExchColumnDef.SETRANGE("Data Exch. Def Code", CurrentDataExchLineDef."Data Exch. Def Code");
        DataExchColumnDef.SETRANGE("Data Exch. Line Def Code", CurrentDataExchLineDef.Code);
        DataExchColumnDef.SETFILTER(Path, '<>%1', '');

        CurrentIndex := 1;

        if DataExchColumnDef.FINDSET then
            repeat
                XMLDOMManagement.FindNodesWithNamespaceManager(
                  CurrentXmlNode,
                  GetRelativePath(DataExchColumnDef.Path, CurrentDataExchLineDef."Data Line Tag"),
                  XmlNamespaceMgr,
                  XmlNodeList);

                NodeCount := XmlNodeList.Count;
                for I := 1 to NodeCount do begin
                    if XmlNodeList.Get(I, XmlChildNode) then begin
                        if XmlChildNode.IsXmlElement() then
                            XmlElement := XmlChildNode.AsXmlElement()
                        else
                            XmlElement := XmlChildNode.AsXmlElement();
                        CurrentNodeID := IncreaseNodeID(NodeID, CurrentIndex);
                        CurrentIndex += 1;
                        InsertColumn(
                          DataExchColumnDef.Path, CurrentLineNo, CurrentNodeID, ParentNodeID, XmlElement.InnerText(),
                          CurrentDataExchLineDef, EntryNo);
                    end;
                end;
            until DataExchColumnDef.NEXT = 0;

        // insert Constant values
        DataExchColumnDef.SETFILTER(Path, '%1', '');
        DataExchColumnDef.SETFILTER(Constant, '<>%1', '');
        if DataExchColumnDef.FINDSET then
            repeat
                CurrentNodeID := IncreaseNodeID(NodeID, CurrentIndex);
                CurrentIndex += 1;
                DataExchFieldVIP.InsertRecXMLFieldWithParentNodeID(EntryNo, CurrentLineNo, DataExchColumnDef."Column No.",
                  CurrentNodeID, ParentNodeID, DataExchColumnDef.Constant, CurrentDataExchLineDef.Code);
            until DataExchColumnDef.NEXT = 0;

        // Insert Children
        DataExchLineDef.SETRANGE("Data Exch. Def Code", CurrentDataExchLineDef."Data Exch. Def Code");
        DataExchLineDef.SETRANGE("Parent Code", CurrentDataExchLineDef.Code);

        if DataExchLineDef.FINDSET then
            repeat
                XMLDOMManagement.FindNodesWithNamespaceManager(
                  CurrentXmlNode,
                  GetRelativePath(DataExchLineDef."Data Line Tag", CurrentDataExchLineDef."Data Line Tag"),
                  XmlNamespaceMgr,
                  XmlNodeList);

                DataExchFieldVIP.SETRANGE("Data Exch. No.", EntryNo);
                DataExchFieldVIP.SETRANGE("Data Exch. Line Def Code", DataExchLineDef.Code);
                LastLineNo := 1;
                if DataExchFieldVIP.FINDLAST then
                    LastLineNo := DataExchFieldVIP."Line No." + 1;

                NodeCount := XmlNodeList.Count;
                for I := 1 to NodeCount do begin
                    if XmlNodeList.Get(I, XmlChildNode) then begin
                        CurrentNodeID := IncreaseNodeID(NodeID, CurrentIndex);
                        ParseParentChildLineCloud(
                          XmlChildNode, CurrentNodeID, NodeID, LastLineNo, DataExchLineDef, EntryNo, XmlNamespaceMgr);
                        CurrentIndex += 1;
                        LastLineNo += 1;
                    end;
                end;
            until DataExchLineDef.NEXT = 0;
    end;

    local procedure IsAlphanumeric(TextValue: Text): Boolean
    var
        i: Integer;
    begin
        for i := 1 to StrLen(TextValue) do
            if not ((TextValue[i] >= 'a') and (TextValue[i] <= 'z') or
                    (TextValue[i] >= 'A') and (TextValue[i] <= 'Z') or
                    (TextValue[i] >= '0') and (TextValue[i] <= '9')) then
                exit(false);
        exit(true);
    end;

    local procedure LoadXmlFromStream(XmlStream: InStream; XmlDoc: XmlDocument)
    begin
        XmlDocument.ReadFrom(XmlStream, XmlDoc);
    end;

    //BC Upgrade VAMSIU01 -End New Functions


}

