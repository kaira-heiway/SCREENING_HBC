codeunit 58091 "API Stock Image Mgmt."
{
    //BC Upgrade GUNREM01 Old ID-50149
    // version HEI.03

    // HEI.01 FDD-HB899 - CHG2093869 IBM NASTAA02 16.03.2021 # LSR - Transfer and Stock
    //   # New Codeunit created for API Stock Interface
    // HEI.02 INC4083000 - CHG2156647 IBM NASTAA02 03.05.2022 # NAS Service consuming high memory
    //   # Clear variables after Webservice call
    // HEI.03 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # Clear DotNet variables

    //BC Upgrade GUNREM01 12-02-26
    //# Replaced tempblob variable record to codeunit
    //# Replaced dotnet variables to XML variables
    //# Code modified using the xml variables
    //********************************************************************************************************************************
    //HEI.04 BC UPGRADE PATHAA02-16.03.26;CU50112-Legacy FM Interface Mgmt. #InventoryUOM Functionality is added
    //# DIT field "Inventory Unit of Measure" is used in Function-CreateStockResponse

    // BC Upgrade MISHRS14 >>
    // Changed table name to "API Stock Info FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade SHUKLP03 >> Modified some code because child nodes are added under root node in request XML and also modified code to use XML variables instead of DotNet variables as DotNet.

    TableNo = "API Interface Log2 INT";


    trigger OnRun();
    begin
        APIInterfaceLog := Rec;
        case APIInterfaceLog.Entity of
            'STOCK':
                case APIInterfaceLog.Operation of
                    'READ':
                        ProcessStockRequest();
                end;
        end;

        Rec := APIInterfaceLog;
    end;

    var
        APIInterfaceLog: Record "API Interface Log2 INT";
        RootXmlelement: XmlElement; // BC Upgrade SHUKLP03
        MissingNodeErr: Label '%1 node missing from XML';
        // ResponsetXml: Record TempBlob temporary;
        ResponsetXml: Codeunit "Temp Blob";
        // ResponseXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        ResponseXmlDocument: XmlDocument;
        MessageResponseOutStream: OutStream;
        //  RootXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        RootXmlNode: XmlNode;

    local procedure ProcessStockRequest();
    var
        APIInterfaceSetup: Record "API Interface Setup2 INT";
        RequestInStream: InStream;
        //BC Update GUNREM01 replaced variables >>
        // RequestXmlDocument: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
        // StockImageXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // StockXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // StockImageXmlNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";
        RequestXmlDocument: XmlDocument;
        StockImageXmlNode: XmlNode;
        StockXmlNode: XmlNode;
        TempXmlNode: XmlNode;
        StockImageXmlNodeList: XmlNodeList;
        //RootXmlelement: XmlElement;
        //BC Update GUNREM01 replaced variables <<
        TempItem: Text;
        TempLocation: Text;
        TempZone: Text;
        TempItemCategory: Text;
        APIStockImage: Query "API Stock Image";
        APIStockInfo: Record "API Stock Info FND" temporary;
        Requestxml: Codeunit "Temp Blob";

        RequestOutstream: OutStream;
        XmlDoc: XmlDocument;
        RootXmlElement2: XmlElement;
        TempXmlElement: XmlElement;
        MessageResponseOutStream: OutStream;

    begin
        APIInterfaceSetup.GET();
        //Bc Upgrade GUNREM01 >>
        //BC Upgrade SHUKLP03 >>
        // APIInterfaceLog."Request File".CREATEINSTREAM(RequestInStream);
        // Requestxml.CreateInStream(RequestInStream);
        // APIInterfaceLog."Request File".CreateOutStream(RequestOutstream);
        // CopyStream(RequestOutstream, RequestInStream);
        // APIInterfaceLog.Modify();
        // //Bc Upgrade GUNREM01 <<
        //BC Upgrade SHUKLP03 <<

        //Bc Upgrade GUNREM01 >>
        APIInterfaceLog."Request File".CREATEINSTREAM(RequestInStream);//BC Upgrade SHUKLP03
        // RequestXmlDocument := RequestXmlDocument.XmlDocument;
        // RequestXmlDocument.Load(RequestInStream);
        RequestXmlDocument := XmlDocument.Create();
        XmlDocument.ReadFrom(RequestInStream, RequestXmlDocument);
        //Bc Upgrade GUNREM01 <<

        //BC Upgrade GUNREM01 >>
        // StockImageXmlNode := RequestXmlDocument.SelectSingleNode('/StockImage/Stock');
        // if ISNULL(StockImageXmlNode) then
        //     ERROR(MissingNodeErr, 'Stock');
        RequestXmlDocument.SelectSingleNode('/StockImage/Stock', StockImageXmlNode);
        if not StockImageXmlNode.IsXmlElement then
            Error(MissingNodeErr, 'Stock');
        //BC Upgrade GUNREM01 <<

        //BC Upgrade GUNREM01 >>
        // StockImageXmlNodeList := StockImageXmlNode.SelectNodes('/StockImage/Stock');
        // if ISNULL(StockImageXmlNodeList) then
        //     ERROR(MissingNodeErr, 'Stock');
        if not StockImageXmlNode.SelectNodes('/StockImage/Stock', StockImageXmlNodeList) then // SHUKLP03
            Error(MissingNodeErr, 'Stock');
        //BC Upgrade GUNREM01 <<

        foreach StockXmlNode in StockImageXmlNodeList do begin
            //BC Upgrade GUNREM01 >>
            // TempXmlNode := StockImageXmlNode.SelectSingleNode('SKU');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         TempItem := TempXmlNode.InnerText;

            // TempXmlNode := StockImageXmlNode.SelectSingleNode('WarehouseID');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         TempLocation := TempXmlNode.InnerText;

            // TempXmlNode := StockImageXmlNode.SelectSingleNode('ZoneCode');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         TempZone := TempXmlNode.InnerText;

            // TempXmlNode := StockImageXmlNode.SelectSingleNode('ItemCategory');
            // if not ISNULL(TempXmlNode) then
            //     if TempXmlNode.InnerText <> '' then
            //         TempItemCategory := TempXmlNode.InnerText;

            if StockXmlNode.SelectSingleNode('SKU', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        TempItem := TempXmlNode.AsXmlElement().InnerText();

            if StockXmlNode.SelectSingleNode('WarehouseID', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        TempLocation := TempXmlNode.AsXmlElement().InnerText();

            if StockXmlNode.SelectSingleNode('ZoneCode', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        TempZone := TempXmlNode.AsXmlElement().InnerText();

            if StockXmlNode.SelectSingleNode('ItemCategory', TempXmlNode) then
                if TempXmlNode.IsXmlElement then
                    if tempXmlNode.AsXmlElement().InnerText() <> '' then
                        TempItemCategory := TempXmlNode.AsXmlElement().InnerText();
            //BC Upgrade GUNREM01 <<

            if TempZone <> '' then
                APIStockImage.SETFILTER(Zone_Code, TempZone);

            if TempItem <> '' then
                APIStockImage.SETFILTER(Item_No, TempItem);

            if TempLocation <> '' then
                APIStockImage.SETFILTER(Location_Code, TempLocation);

            if TempItemCategory <> '' then
                APIStockImage.SETFILTER(Item_Category_Code, TempItemCategory);

            APIStockImage.OPEN();
            //BC Upgrade GUNREM01 >>
            // ResponseXmlDocument := ResponseXmlDocument.XmlDocument;
            // RootXmlNode := ResponseXmlDocument.CreateElement('StockImage');
            // ResponseXmlDocument.AppendChild(RootXmlNode);
            ResponseXmlDocument := XmlDocument.Create();
            RootXmlelement := XmlElement.Create('StockImage');
            ResponseXmlDocument.Add(RootXmlelement);
            //BC Upgrade GUNREM01 <<

            while APIStockImage.READ() do
                CreateAPIStockInfoBuffer(APIStockImage, APIStockInfo);

            if APIStockInfo.FINDSET() then
                repeat
                    CreateStockResponse(APIStockInfo);
                until APIStockInfo.NEXT() = 0;

            //BC Upgrade GUNREM01 >>
            // ResponsetXml.Blob.CREATEOUTSTREAM(MessageResponseOutStream);
            // ResponseXmlDocument.Save(MessageResponseOutStream);
            // ResponsetXml.CREATEOUTSTREAM(MessageResponseOutStream);
            // ResponseXmlDocument.WriteTo(MessageResponseOutStream);
            //BC Upgrade GUNREM01 <<

            APIInterfaceLog.FIND();
            //BC Upgrade GUNREM01 >>
            // APIInterfaceLog."Response File" := ResponsetXml.Blob;
            // ResponsetXml.CreateOutStream(MessageResponseOutStream);
            // ResponseXmlDocument.WriteTo(MessageResponseOutStream);
            APIInterfaceLog."Response File".CreateOutStream(MessageResponseOutStream); //BC Upgrade SHUKLP03
            ResponseXmlDocument.WriteTo(MessageResponseOutStream); //BC UpgradeSHUKLP03
            //BC Upgrade GUNREM01 <<
            APIInterfaceLog."Response Sync. Date/Time" := CURRENTDATETIME;
            APIInterfaceLog.MODIFY();
        end;

        //HEI.02>>
        CLEAR(ResponseXmlDocument);
        CLEAR(RootXmlNode);
        //HEI.02<<
        //HEI.03>>
        CLEAR(RequestInStream);
        Clear(RootXmlElement);
        Clear(TempXmlElement);
        CLEAR(MessageResponseOutStream);
        //HEI.03<<
    end;

    local procedure CreateStockResponse(APIStockInfo: Record "API Stock Info FND" temporary);
    var
        //BC Upgrade GUNREM01 >>
        // TempXmlNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        // XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
        TempXmlNode: XmlElement;
        XMLCurrNode2: XmlElement;
        RootXMlelement2: XmlElement;
        //BC Upgrade GUNREM01 <<
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        QtyBaseUoMString: Text;
        QtySalesUoMString: Text;
        QtyInvUoMString: Text;
    begin
        QtyBaseUoMString := '';
        QtySalesUoMString := '';
        QtyInvUoMString := '';
        Item.GET(APIStockInfo."Item No.");
        //BC Upgrade GUNREM01 >>
        // XMLCurrNode2 := ResponseXmlDocument.CreateElement('Stock');
        // RootXmlNode.AppendChild(XMLCurrNode2);
        // XMLCurrNode2 := XmlElement.Create('Stock'); //BC Upgrade SHUKLP03
        // RootXMlelement2.Add(XMLCurrNode2);
        //BC Upgrade GUNREM01 <<
        // ResponseXmlDocument := XmlDocument.Create();
        RootXmlelement2 := XmlElement.Create('Stock'); //BC Upgrade SHUKLP03
                                                       // ResponseXmlDocument.Add(RootXmlelement2);

        //BC Upgrade GUNREM01 >>
        //    TempXmlNode := ResponseXmlDocument.CreateElement('SKU');
        //     TempXmlNode.InnerText := APIStockInfo."Item No.";
        //     XMLCurrNode2.AppendChild(TempXmlNode);
        TempXmlNode := XmlElement.Create('SKU');
        TempXmlNode.Add(XmlText.Create(APIStockInfo."Item No."));
        RootXmlelement2.Add(TempXmlNode); // BC Upgrade SHUKLP03
        //BC Upgrade GUNREM01 <<

        //BC Upgrade GUNREM01 >>
        // TempXmlNode := ResponseXmlDocument.CreateElement('WarehouseID');
        // TempXmlNode.InnerText := APIStockInfo."Location Code";
        // XMLCurrNode2.AppendChild(TempXmlNode);
        TempXmlNode := XmlElement.Create('WarehouseID');
        TempXmlNode.Add(XmlText.Create(APIStockInfo."Location Code"));
        RootXmlelement2.Add(TempXmlNode); // BC Upgrade SHUKLP03
        //BC Upgrade GUNREM01 << 

        //BC Upgrade GUNREM01 ??
        // TempXmlNode := ResponseXmlDocument.CreateElement('QuantityBaseUoM');
        TempXmlNode := XmlElement.Create('QuantityBaseUoM');
        QtyBaseUoMString := FORMAT(ROUND(APIStockInfo.Quantity, 1, '='));
        QtyBaseUoMString := DELCHR(QtyBaseUoMString, '=', ',');
        // TempXmlNode.InnerText := QtyBaseUoMString;
        // XMLCurrNode2.AppendChild(TempXmlNode);
        TempXmlNode.Add(XmlText.Create(QtyBaseUoMString));
        RootXmlelement2.add(TempXmlNode); // BC Upgrade SHUKLP03
        //BC Upgrade GUNREM01 <<

        // TempXmlNode := ResponseXmlDocument.CreateElement('QuantitySalesUoM'); //BC Upgrade GUNREM01 
        TempXmlNode := XmlElement.Create('QuantitySalesUoM');//BC Upgrade GUNREM01 

        if Item."Sales Unit of Measure" = Item."Base Unit of Measure" then
            QtySalesUoMString := FORMAT(ROUND(APIStockInfo.Quantity, 1, '='))
        else begin
            ItemUnitofMeasure.SETRANGE("Item No.", Item."No.");
            ItemUnitofMeasure.SETRANGE(Code, Item."Sales Unit of Measure");
            if ItemUnitofMeasure.FINDFIRST() then
                QtySalesUoMString := FORMAT(ROUND(APIStockInfo.Quantity / ItemUnitofMeasure."Qty. per Unit of Measure", 1, '='));
        end;
        QtySalesUoMString := DELCHR(QtySalesUoMString, '=', ',');
        //BC Upgrade GUNREM01 >>
        // TempXmlNode.InnerText := QtySalesUoMString;
        // XMLCurrNode2.AppendChild(TempXmlNode);
        TempXmlNode.Add(XmlText.Create(QtySalesUoMString));
        RootXmlelement2.add(TempXmlNode); // BC Upgrade SHUKLP03
        //BC Upgrade GUNREM01 <<


        //  TempXmlNode := ResponseXmlDocument.CreateElement('QuantityInventoryUoM');
        TempXmlNode := XmlElement.Create('QuantityInventoryUoM');

        //HEI.04 BC UPGRADE PATHAA02 16.03.26>>
        if Item."Inventory Unit of Measure FND" = Item."Base Unit of Measure" then
            QtyInvUoMString := FORMAT(ROUND(APIStockInfo.Quantity, 1, '='))
        else begin
            ItemUnitofMeasure.SETRANGE("Item No.", Item."No.");
            ItemUnitofMeasure.SETRANGE(Code, Item."Inventory Unit of Measure FND");
            if ItemUnitofMeasure.FINDFIRST() then
                QtyInvUoMString := FORMAT(ROUND(APIStockInfo.Quantity / ItemUnitofMeasure."Qty. per Unit of Measure", 1, '='));
        end;
        //HEI.04 BC UPGRADE PATHAA02 16.03.26<<

        QtyInvUoMString := DELCHR(QtyInvUoMString, '=', ',');
        //BC Upgrade GUNREM01 >>
        // TempXmlNode.InnerText := QtyInvUoMString;
        // XMLCurrNode2.AppendChild(TempXmlNode);
        TempXmlNode.Add(XmlText.Create(QtyInvUoMString));
        RootXmlelement2.add(TempXmlNode);  // BC Upgrade SHUKLP03
        //BC Upgrade GUNREM01 <<

        //BC Upgrade GUNREM01>>
        // TempXmlNode := ResponseXmlDocument.CreateElement('MessageDateTime');
        // TempXmlNode.InnerText := FORMAT(CURRENTDATETIME, 0, 9);
        // XMLCurrNode2.AppendChild(TempXmlNode);
        TempXmlNode := XmlElement.Create('MessageDateTime');
        TempXmlNode.Add(XmlText.Create(Format(CURRENTDATETIME, 0, 9)));
        RootXmlelement2.Add(TempXmlNode); // BC Upgrade SHUKLP03
        RootXmlelement.Add(RootXmlelement2); // BC Upgrade SHUKLP03
        //HEI.02>>
        CLEAR(TempXmlNode);
        CLEAR(RootXmlelement2); // BC Upgrade SHUKLP03
        //HEI.02<<
    end;

    local procedure CreateAPIStockInfoBuffer(APIStockImage: Query "API Stock Image"; var APIStockInfo: Record "API Stock Info FND" temporary);
    begin
        if APIStockInfo.GET(APIStockImage.Item_No, APIStockImage.Location_Code) then begin
            APIStockInfo.Quantity += APIStockImage.Sum_Quantity;
            APIStockInfo.MODIFY();
        end else begin
            APIStockInfo.INIT();
            APIStockInfo."Item No." := APIStockImage.Item_No;
            APIStockInfo."Location Code" := APIStockImage.Location_Code;
            APIStockInfo.Quantity := APIStockImage.Sum_Quantity;
            APIStockInfo.INSERT();
        end;
    end;
}

