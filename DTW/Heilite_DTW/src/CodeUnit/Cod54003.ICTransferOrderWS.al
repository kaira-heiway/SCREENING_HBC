codeunit 54003 "IC Transfer Order WS"
{
    // version HEI.07

    // HEI.01 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Codeunit created for IC Transfer Order Interface
    // HEI.02 FDD-HT1304 IBM NASTAA02 21.10.2020 # IC Transfer Order Automation
    //   # Shipping information should not be copied from Source to Target
    // HEI.03 INC3205302IBM NASTAA02 09.12.2020 #Bralima opco, difference between the time and date of inter-company transfer
    //   # Format the nubmers as strings before adding them to the XML
    // HEI.04 CHG2131272 IBM.LS      04.01.2022
    //   # Added Code for Reporting Type
    // HEI.05 INC4028874 - CHG2152251 IBM NASTAA02 25.03.2022 # DRC I.C. transfer issues
    //   # If SKU doesn't exist Unit Amount will be taken from Item
    // HEI.06 INC4083000 - CHG2156647 IBM NASTAA02 03.05.2022 # NAS Service consuming high memory
    //   # CLear variables after Webservice call
    // HEI.07 INC4107281 - CHG2158843 IBM NASTAA02 18.05.2022 # High memory consumption
    //   # CLear DotNet variables

    // BC Upgrade KUMARS145 Codeunit Created. Old Obeject ID - Codeunit	50131	"IC Transfer Order WS"

    trigger OnRun();
    begin
    end;

    var
        ICWebServiceNotFoundErr: Label 'IC Web Service Setup doesn''t exist for Mapping Code %1, IC Location %2.';
        CurrentElementName: Text;
        FromCompany: Text[50];
        FromTransferOrderNo: Code[20];
        CreatedTransferOrderNo: Code[20];
        CreatedTransferOrderNo2: Code[20];
        FromLocation: Code[10];
        ToLocation: Code[10];
        PostingDate: Date;
        ICDocument: Boolean;
        TransferRcptNo: Code[20];
        TransferRcptPostingDate: Date;
        InTransitCode: Code[10];
        RouteCode: Code[20];
        ShipAgCode: Code[20];
        ShipAgServCode: Code[20];
        TruckCode: Code[20];
        DriverCode: Code[20];
        DriverCode2: Code[20];
        LineNo: Integer;
        ItemLineNo: Integer;
        ItemNo: Code[20];
        BinCode: Code[20];
        UnitAmount: Decimal;
        TransferQuantity: Decimal;
        UoMCode: Code[10];
        LotBaseQty: Decimal;
        LotNo: Code[20];
        LotExpirationDate: Date;
        LotStrengthSpecCode: Code[20];
        LotStrengthSpecValue: Decimal;
        QtyPerUoM: Decimal;
        DimensionSetEntryNo: Integer;
        NewDimensionSetEntryNo: Integer;
        LineDimensionSetEntryNo: Integer;
        NewLineDimensionSetEntryNo: Integer;
        DimensionCode: Code[20];
        DimensionValueCode: Code[20];
        LineDimensionCode: Code[20];
        LineDimensionValue: Code[20];
        CDataHeader: Text;
        CDataDimensionH: Text;
        CDataLine: Text;
        CDataTrackingSpec: Text;
        CDataDimensionL: Text;
        CDataRequest: Text;
        CDataRequest2: Text;
        PositiveAdjustmentPosted: Boolean;
        LastErrorMsg: Text[250];
        ResponseText: Text[20];
        ErrorMsg: Text[250];
        ProcessingWindowMsg: TextConst ENU = 'Please wait while the server is processing your request.\This may take several minutes.', FRA = 'Veuillez patienter pendant que le serveur traite votre demande.\Cette opération peut prendre plusieurs minutes.';

    procedure ImportTransferOrderIC(var Request: BigText);
    var
        TempBlob: Codeunit "Temp Blob";// Record TempBlob temporary;
        TempBlob2: Codeunit "Temp Blob";// Record TempBlob temporary;
        OutputStream: OutStream;
        OutputStream2: OutStream;
        InputStream: InStream;
        InputStream2: InStream;
        // XmlDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; // BC Upgrade KUMARS145 DotNet Variables are commented.
        // XMLNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";// BC Upgrade KUMARS145 DotNet Variables are commented.
        // DOMNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables are commented.
        i: Integer;
        TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW";
    // ResponseXMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";// BC Upgrade KUMARS145 DotNet Variables are commented.
    begin
        TempBlob.CreateOutStream(OutputStream);// .Blob.CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TempBlob.CreateInStream(InputStream);

        // .Blob.CREATEINSTREAM(InputStream);
        // BC Upgrade KUMARS145 DotNet Variables code....>>
        // XmlDoc := XmlDoc.XmlDocument;
        // XmlDoc.Load(InputStream);
        // XMLNodeList := XmlDoc.ChildNodes;

        // for i := 0 to XMLNodeList.Count - 1 do begin
        //     DOMNode := XMLNodeList.Item(i);
        //     ParseXMLForDocumentNo(DOMNode);
        // end;
        // BC Upgrade KUMARS145 DotNet Variables code....<<

        if (CreatedTransferOrderNo <> '') or (ErrorMsg <> '') then begin
            TransferOrderICLogEntry.Reset();
            TransferOrderICLogEntry.SetRange("Source Type", TransferOrderICLogEntry."Source Type"::Transfer);
            TransferOrderICLogEntry.SetRange("Document Type", TransferOrderICLogEntry."Document Type"::"Transfer Order");
            TransferOrderICLogEntry.SetRange("From Company", CompanyName);
            TransferOrderICLogEntry.SetRange("Document No.", FromTransferOrderNo);
            TransferOrderICLogEntry.SetRange("Created Document No.", '');
            if TransferOrderICLogEntry.FindFirst() then
                if CreatedTransferOrderNo <> '' then begin
                    TransferOrderICLogEntry."Created Document No." := CreatedTransferOrderNo;
                    TransferOrderICLogEntry.Status := TransferOrderICLogEntry.Status::Done;
                    if TransferOrderICLogEntry."Last Error" <> '' then
                        TransferOrderICLogEntry."Last Error" := '';
                end else
                    if ErrorMsg <> '' then
                        TransferOrderICLogEntry."Last Error" := ErrorMsg;

            TransferOrderICLogEntry.Modify(true);

        end else// begin
            if FromCompany <> '' then begin
                CreateTransferOrderICLogEntryReceive(Request, TransferOrderICLogEntry);

                COMMIT();
                CLear(LastErrorMsg);
                CLear(CreatedTransferOrderNo2);

                if not CODEUNIT.RUN(50132, TransferOrderICLogEntry) then begin
                    LastErrorMsg := GetLastErrorText();
                    TransferOrderICLogEntry."Last Error" := LastErrorMsg;
                end else begin
                    CreatedTransferOrderNo2 := TransferOrderICLogEntry."Created Document No.";
                    TransferOrderICLogEntry.Status := TransferOrderICLogEntry.Status::"Posting info. Exported";
                end;
                TransferOrderICLogEntry.Modify();

                //Create Response XML and Send it in sync call
                // CreateResponseXML(ResponseXMLDoc); // BC Upgrade KUMARS145 DotNet Variables code commented.

                TempBlob2.CreateOutStream(OutputStream2);//  .Blob.CREATEOUTSTREAM(OutputStream2);
                // ResponseXMLDoc.Save(OutputStream2); // BC Upgrade KUMARS145 DotNet Variables code commented.
                TempBlob2.CreateInStream(InputStream2);// .Blob.CREATEINSTREAM(InputStream2);
                CLear(Request);
                Request.READ(InputStream2);
            end;
        // end;

        //HEI.06>>
        // CLear(XmlDoc); // BC Upgrade KUMARS145 DotNet Variables code commented.
        // CLear(XMLNodeList); // BC Upgrade KUMARS145 DotNet Variables code commented.
        // CLear(DOMNode); // BC Upgrade KUMARS145 DotNet Variables code commented.
        // CLear(ResponseXMLDoc); // BC Upgrade KUMARS145 DotNet Variables code commented.
        //HEI.06<<
        //HEI.07>>
        CLear(OutputStream);
        CLear(OutputStream2);
        CLear(InputStream);
        CLear(InputStream2);
        //HEI.07<<
    end;

    [TryFunction]
    procedure ExportTransferOrderIC(WarehouseShipmentLineBuffer: Record "Warehouse Shipment Line" temporary);
    var
        // ICWebServiceSetup: Record "IC Web Service Setup"; // BC Upgrade KUMARS145 Drinkit Variables commented.
        TempTransferHeaderBuffer: Record "Transfer Header" temporary;
        TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW";
    // XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; // BC Upgrade KUMARS145 DotNet Variables commented.
    // XMLResponse: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; // BC Upgrade KUMARS145 DotNet Variables commented.
    begin
        // CheckICWebServiceSetup(WarehouseShipmentLineBuffer, ICWebServiceSetup);// BC Upgrade KUMARS145 DotNet Variables code commented.
        CreateTransferOrderXMLBuffer(WarehouseShipmentLineBuffer, TempTransferHeaderBuffer);
        // CreateTransferOrderICLogEntry(WarehouseShipmentLineBuffer, ICWebServiceSetup, TransferOrderICLogEntry);// BC Upgrade KUMARS145 DotNet Variables code commented.
        PostTransferOrderReceipt(WarehouseShipmentLineBuffer);
        // ProcessNegativeStockAdjustment(WarehouseShipmentLineBuffer."Source No.", ICWebServiceSetup);// BC Upgrade KUMARS145 DotNet Variables code commented.

        // CreateRequestMessage(WarehouseShipmentLineBuffer, ICWebServiceSetup, TempTransferHeaderBuffer, XMLDoc);// BC Upgrade KUMARS145 DotNet Variables code commented.
        // UpdateRequestXMLTransferOrderICLogEntry(XMLDoc, TransferOrderICLogEntry);// BC Upgrade KUMARS145 DotNet Variables code commented.
        // CreateRequestAPI(XMLDoc, TransferOrderICLogEntry);// BC Upgrade KUMARS145 DotNet Variables code commented.

        //SaveRequestToDirectory(ICWebServiceSetup,TransferOrderICLogEntry,FileName);

        // XMLResponse := XMLResponse.XmlDocument;// BC Upgrade KUMARS145 DotNet Variables code commented.
        // ProcessRequestAPI(XMLDoc, XMLResponse, TransferOrderICLogEntry, ICWebServiceSetup);// BC Upgrade KUMARS145 DotNet Variables code commented.

        //HEI.06>>
        // CLear(XMLDoc);// BC Upgrade KUMARS145 DotNet Variables code commented.
        // CLear(XMLResponse);// BC Upgrade KUMARS145 DotNet Variables code commented.
        //HEI.06<<
    end;

    // BC Upgrade KUMARS145 DotNet Variables code commented.....>>
    // local procedure ParseXMLForDocumentNo(CurrentXMLNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode");
    // var
    // TempXMLNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList";// BC Upgrade KUMARS145 DotNet Variables commented.
    // TempXMLAttributeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlAttributeCollection";// BC Upgrade KUMARS145 DotNet Variables commented.
    // j: Integer;
    // k: Integer;
    // CurrentXMLNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables commented.
    // begin
    // CurrentXMLNode2 := CurrentXMLNode;
    // case FORMAT(CurrentXMLNode2.NodeType) of
    //     'Element': // Element
    //         begin
    //             CurrentElementName := CurrentXMLNode2.Name;

    //             // If the element has attributes, then browse through those.
    //             TempXMLAttributeList := CurrentXMLNode2.Attributes;
    //             for k := 0 to TempXMLAttributeList.Count - 1 do
    //                 ParseXMLForDocumentNo(TempXMLAttributeList.Item(k));

    //             // Process Child nodes
    //             TempXMLNodeList := CurrentXMLNode2.ChildNodes;
    //             for j := 0 to TempXMLNodeList.Count - 1 do
    //                 ParseXMLForDocumentNo(TempXMLNodeList.Item(j));
    //         end;

    //     'Text': //Values
    //         begin
    //             if CurrentElementName = 'FromCompany' then
    //                 FromCompany := CurrentXMLNode2.Value;

    //             if CurrentElementName = 'TransferOrderNo' then
    //                 FromTransferOrderNo := CurrentXMLNode2.Value;

    //             if CurrentElementName = 'request' then
    //                 ResponseText := CurrentXMLNode2.Value;

    //             if CurrentElementName = 'CreatedTransferOrderNo' then
    //                 CreatedTransferOrderNo := CurrentXMLNode2.Value;

    //             if CurrentElementName = 'ErrorMsg' then
    //                 ErrorMsg := CurrentXMLNode2.Value;
    //         end;
    // end;
    // end;
    // BC Upgrade KUMARS145 DotNet Variables code commented....<<

    local procedure CreateRequestMessage(
        WarehouseShipmentLineBuffer: Record "Warehouse Shipment Line" temporary;
        // ICWebServiceSetup: Record "IC Web Service Setup";// BC Upgrade KUMARS145 Drinkit Variables commented.
        TempTransferHeaderBuffer: Record "Transfer Header" temporary
        // var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";// BC Upgrade KUMARS145 DotNet Variables commented.
        );
    var
        // ProcessingInstruction: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlProcessingInstruction";// BC Upgrade KUMARS145 DotNet Variables commented.
        // XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables commented.
        // XMLCurrNode2: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables commented.
        // XMLCurrNode3: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables commented.
        // XMLCurrNode4: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables commented.
        // XMLCurrNode5: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables commented.
        XMLDOMMgt: Codeunit "XML DOM Management";
        // NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables commented.
        TransferReceiptHeader: Record "Transfer Receipt Header";
        TransferReceiptLine: Record "Transfer Receipt Line";
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgerEntry: Record "Item Ledger Entry";
        DimensionSetEntry: Record "Dimension Set Entry";
        Dimension: Record Dimension;
        DimensionValue: Record "Dimension Value";
        DimCode: Code[20];
        DimValue: Code[20];
        SKU: Record "Stockkeeping Unit";
        QuantityString: Text;
        UnitAmountString: Text;
        BaseQtyString: Text;
        Item: Record Item;
    begin
        CLear(CDataRequest);
        CLear(CDataHeader);
        CLear(CDataDimensionH);
        CLear(CDataLine);
        CLear(CDataTrackingSpec);
        CLear(CDataDimensionL);

        TransferReceiptHeader.SetRange("Transfer Order No.", WarehouseShipmentLineBuffer."Source No.");
        TransferReceiptHeader.FindFirst();

        //// BC Upgrade KUMARS145 DotNet code commented......>>
        // XMLDoc := XMLDoc.XmlDocument;
        // XMLCurrNode := XMLDoc.CreateElement('TransferOrder');
        // XMLDoc.AppendChild(XMLCurrNode);

        // ProcessingInstruction := XMLDoc.CreateProcessingInstruction('?xml', 'version="1.0" encoding="UTF-8"?');

        // //Transfer Order Header
        // XMLDOMMgt.AddElement(XMLCurrNode, 'FromCompany', CompanyName, '', NewChildNode);
        // XMLDOMMgt.AddElement(XMLCurrNode, 'ToCompany', ICWebServiceSetup."To Database", '', NewChildNode);
        // XMLDOMMgt.AddElement(XMLCurrNode, 'TransferOrderNo', TempTransferHeaderBuffer."No.", '', NewChildNode);
        // XMLDOMMgt.AddElement(XMLCurrNode, 'FromLocation', ICWebServiceSetup."IC Main Location", '', NewChildNode);
        // XMLDOMMgt.AddElement(XMLCurrNode, 'ToLocation', ICWebServiceSetup."IC Location From", '', NewChildNode);
        // XMLDOMMgt.AddElement(XMLCurrNode, 'PostingDate', FORMAT(TempTransferHeaderBuffer."Posting Date", 0, '<Month,2>/<Day,2>/<Year4>'), '', NewChildNode);
        // XMLDOMMgt.AddElement(XMLCurrNode, 'ICDocument', FORMAT(TempTransferHeaderBuffer."IC Document"), '', NewChildNode);
        // XMLDOMMgt.AddElement(XMLCurrNode, 'TransferReceiptNo', TransferReceiptHeader."No.", '', NewChildNode);
        // XMLDOMMgt.AddElement(XMLCurrNode, 'TransferRcptPostingDate', FORMAT(TransferReceiptHeader."Posting Date", 0, '<Month,2>/<Day,2>/<Year4>'), '', NewChildNode);
        // XMLDOMMgt.AddElement(XMLCurrNode, 'In-Transit', TempTransferHeaderBuffer."In-Transit Code", '', NewChildNode);
        // //HEI.02>>
        // //XMLDOMMgt.AddElement(XMLCurrNode,'Route',TempTransferHeaderBuffer.Route,'',NewChildNode);
        // //XMLDOMMgt.AddElement(XMLCurrNode,'ShipAgCode',TempTransferHeaderBuffer."Shipping Agent Code",'',NewChildNode);
        // //XMLDOMMgt.AddElement(XMLCurrNode,'ShipAgServCode',TempTransferHeaderBuffer."Shipping Agent Service Code",'',NewChildNode);
        // //XMLDOMMgt.AddElement(XMLCurrNode,'Driver',TempTransferHeaderBuffer."Driver Code",'',NewChildNode);
        // //XMLDOMMgt.AddElement(XMLCurrNode,'Driver2',TempTransferHeaderBuffer."Driver 2 Code",'',NewChildNode);
        // //XMLDOMMgt.AddElement(XMLCurrNode,'Truck',TempTransferHeaderBuffer."Truck Code",'',NewChildNode);
        // //HEI.02<<
        // XMLDOMMgt.AddElement(XMLCurrNode, 'BPG', ICWebServiceSetup.BPG, '', NewChildNode);

        // CDataHeader := '<TransferOrder><FromCompany>' + CompanyName + '</FromCompany><ToCompany>' + ICWebServiceSetup."To Database" + '</ToCompany><TransferOrderNo>' + TempTransferHeaderBuffer."No." +
        //   '</TransferOrderNo><FromLocation>' + ICWebServiceSetup."IC Main Location" + '</FromLocation><ToLocation>' + ICWebServiceSetup."IC Location From" +
        //   '</ToLocation><PostingDate>' + FORMAT(TempTransferHeaderBuffer."Posting Date", 0, '<Month,2>/<Day,2>/<Year4>') + '</PostingDate><ICDocument>' + FORMAT(TempTransferHeaderBuffer."IC Document") +
        //   '</ICDocument><TransferReceiptNo>' + TransferReceiptHeader."No." + '</TransferReceiptNo><TransferRcptPostingDate>' + FORMAT(TransferReceiptHeader."Posting Date", 0, '<Month,2>/<Day,2>/<Year4>') +
        //   '</TransferRcptPostingDate><In-Transit>' + TempTransferHeaderBuffer."In-Transit Code" +
        //   //HEI.02>>
        //   //'</In-Transit><Route>' + TempTransferHeaderBuffer.Route + '</Route><ShipAgCode>' + TempTransferHeaderBuffer."Shipping Agent Code" + '</ShipAgCode><ShipAgServCode>' + TempTransferHeaderBuffer."Shipping Agent Service Code" +
        //   //'</ShipAgServCode><Driver>' + TempTransferHeaderBuffer."Driver Code" + '</Driver><Driver2>' + TempTransferHeaderBuffer."Driver 2 Code" +
        //   //'</Driver2><Truck>' + TempTransferHeaderBuffer."Truck Code" + '</Truck><BPG>' + ICWebServiceSetup.BPG + '</BPG>';
        //   '</In-Transit><BPG>' + ICWebServiceSetup.BPG + '</BPG>';
        // //HEI.02<<
        //// BC Upgrade KUMARS145 DotNet code commented......<<

        //Header Dimensions
        if TransferReceiptHeader."Dimension Set ID" <> 0 then begin
            DimensionSetEntry.Reset();
            DimensionSetEntry.SetRange("Dimension Set ID", TransferReceiptHeader."Dimension Set ID");
            if DimensionSetEntry.FINDSET() then
                repeat
                    Dimension.Reset();
                    DimensionValue.Reset();
                    CLear(DimCode);
                    CLear(DimValue);

                    Dimension.SetRange(Code, DimensionSetEntry."Dimension Code");
                    Dimension.SETFILTER("Map-to IC Dimension Code", '<>%1', '');
                    if Dimension.FindFirst() then begin
                        DimensionValue.SetRange("Dimension Code", DimensionSetEntry."Dimension Code");
                        DimensionValue.SetRange(Code, DimensionSetEntry."Dimension Value Code");
                        DimensionValue.SetRange("Map-to IC Dimension Code", Dimension."Map-to IC Dimension Code");
                        DimensionValue.SETFILTER("Map-to IC Dimension Value Code", '<>%1', '');
                        if DimensionValue.FindFirst() then begin
                            DimCode := DimensionValue."Map-to IC Dimension Code";
                            DimValue := DimensionValue."Map-to IC Dimension Value Code";
                        end;
                    end;

                    if (DimCode = '') and (DimValue = '') then begin
                        DimCode := DimensionSetEntry."Dimension Code";
                        DimValue := DimensionSetEntry."Dimension Value Code";
                    end;
                    //// BC Upgrade KUMARS145 DotNet code commented......>>
                    // XMLCurrNode2 := XMLDoc.CreateElement('HeaderDimensions');
                    // XMLCurrNode.AppendChild(XMLCurrNode2);

                    // XMLDOMMgt.AddElement(XMLCurrNode2, 'DimensionCode', DimCode, '', NewChildNode);
                    // XMLDOMMgt.AddElement(XMLCurrNode2, 'DimensionValue', DimValue, '', NewChildNode);
                    //// BC Upgrade KUMARS145 DotNet code commented......<<

                    CDataDimensionH += '<HeaderDimensions><DimensionCode>' + DimCode + '</DimensionCode><DimensionValue>' + DimValue + '</DimensionValue></HeaderDimensions>';
                until DimensionSetEntry.NEXT() = 0;
        end;

        CDataRequest := CDataHeader + CDataDimensionH;

        //Transfer Order Lines
        TransferReceiptLine.SetRange("Document No.", TransferReceiptHeader."No.");
        if TransferReceiptLine.FindSet() then
            repeat
                CLear(CDataLine);
                CLear(CDataTrackingSpec);
                CLear(CDataDimensionL);
                CLear(SKU); //HEI.05
                if SKU.GET(TempTransferHeaderBuffer."Transfer-from Code", TransferReceiptLine."Item No.", TransferReceiptLine."Variant Code") then;
                //HEI.03>>
                CLear(QuantityString);
                CLear(UnitAmountString);
                QuantityString := CheckNumberFormat(FORMAT(TransferReceiptLine.Quantity));
                if SKU."Unit Cost" <> 0 then //HEI.05
                    UnitAmountString := CheckNumberFormat(FORMAT(SKU."Unit Cost"))
                //HEI.05>>
                else begin
                    Item.GET(TransferReceiptLine."Item No.");
                    UnitAmountString := CheckNumberFormat(FORMAT(Item."Unit Cost"));
                end;
                //HEI.05<<
                //HEI.03<<

                //// BC Upgrade KUMARS145 DotNet code commented......>>
                // XMLCurrNode3 := XMLDoc.CreateElement('TransferOrderLine');
                // XMLCurrNode.AppendChild(XMLCurrNode3);

                // XMLDOMMgt.AddElement(XMLCurrNode3, 'SourceLineNo', FORMAT(TransferReceiptLine."Line No."), '', NewChildNode);
                // XMLDOMMgt.AddElement(XMLCurrNode3, 'ItemNo', FORMAT(TransferReceiptLine."Item No."), '', NewChildNode);
                // //HEI.03>>
                // //XMLDOMMgt.AddElement(XMLCurrNode3,'Quantity',FORMAT(TransferReceiptLine.Quantity,0,'<Standard Format,3>'),'',NewChildNode);
                // XMLDOMMgt.AddElement(XMLCurrNode3, 'Quantity', QuantityString, '', NewChildNode);
                // //HEI.03<<
                // XMLDOMMgt.AddElement(XMLCurrNode3, 'UoMCode', TransferReceiptLine."Unit of Measure Code", '', NewChildNode);
                // //HEI.03>>
                // //XMLDOMMgt.AddElement(XMLCurrNode3,'UnitAmount',FORMAT(SKU."Unit Cost",0,'<Standard Format,3>'),'',NewChildNode);
                // XMLDOMMgt.AddElement(XMLCurrNode3, 'UnitAmount', UnitAmountString, '', NewChildNode);
                // //HEI.03<<
                // XMLDOMMgt.AddElement(XMLCurrNode3, 'BinCode', WarehouseShipmentLineBuffer."Bin Code", '', NewChildNode);
                //// BC Upgrade KUMARS145 DotNet code commented......<<

                CDataLine += '<TransferOrderLine><SourceLineNo>' + FORMAT(TransferReceiptLine."Line No.") + '</SourceLineNo><ItemNo>' + FORMAT(TransferReceiptLine."Item No.") +
                  //HEI.03>>
                  //'</ItemNo><Quantity>' + FORMAT(TransferReceiptLine.Quantity,0,'<Standard Format,3>') + '</Quantity><UoMCode>' + TransferReceiptLine."Unit of Measure Code" +
                  //'</UoMCode><UnitAmount>' + FORMAT(SKU."Unit Cost",0,'<Standard Format,3>') + '</UnitAmount><BinCode>' + WarehouseShipmentLineBuffer."Bin Code" + '</BinCode>';
                  '</ItemNo><Quantity>' + QuantityString + '</Quantity><UoMCode>' + TransferReceiptLine."Unit of Measure Code" +
                  '</UoMCode><UnitAmount>' + UnitAmountString + '</UnitAmount><BinCode>' + WarehouseShipmentLineBuffer."Bin Code" + '</BinCode>';
                //HEI.03<<

                CDataRequest += CDataLine;

                //Item Tracking - Receipt
                ItemEntryRelation.Reset();
                ItemLedgerEntry.Reset();
                ItemEntryRelation.SetRange("Source Type", DATABASE::"Transfer Receipt Line");
                ItemEntryRelation.SetRange("Source ID", TransferReceiptLine."Document No.");
                ItemEntryRelation.SetRange("Source Ref. No.", TransferReceiptLine."Line No.");
                if ItemEntryRelation.FindSet() then
                    repeat
                        ItemLedgerEntry.GET(ItemEntryRelation."Item Entry No.");
                        //HEI.03>>
                        CLear(BaseQtyString);
                        BaseQtyString := CheckNumberFormat(FORMAT(ItemLedgerEntry.Quantity));
                    //HEI.03<<

                    //// BC Upgrade KUMARS145 DotNet code commented......>>
                    // XMLCurrNode4 := XMLDoc.CreateElement('TrackingSpecification');
                    // XMLCurrNode3.AppendChild(XMLCurrNode4);

                    // XMLDOMMgt.AddElement(XMLCurrNode4, 'LotNo', ItemLedgerEntry."Lot No.", '', NewChildNode);
                    // XMLDOMMgt.AddElement(XMLCurrNode4, 'ExpirationDate', FORMAT(ItemLedgerEntry."Expiration Date", 0, '<Month,2>/<Day,2>/<Year4>'), '', NewChildNode);
                    // //HEI.03>>
                    // //XMLDOMMgt.AddElement(XMLCurrNode4,'BaseQty',FORMAT(ItemLedgerEntry.Quantity,0,'<Standard Format,3>'),'',NewChildNode);
                    // XMLDOMMgt.AddElement(XMLCurrNode4, 'BaseQty', BaseQtyString, '', NewChildNode);
                    // //HEI.03<<
                    // XMLDOMMgt.AddElement(XMLCurrNode4, 'StrengthSpecCode', ItemLedgerEntry."Strength Spec. Code", '', NewChildNode);
                    // XMLDOMMgt.AddElement(XMLCurrNode4, 'StrengthSpecValue', FORMAT(ItemLedgerEntry."Strength Spec. Value"), '', NewChildNode);

                    // CDataTrackingSpec += '<TrackingSpecification><LotNo>' + ItemLedgerEntry."Lot No." + '</LotNo><ExpirationDate>' + FORMAT(ItemLedgerEntry."Expiration Date", 0, '<Month,2>/<Day,2>/<Year4>') +
                    //   //HEI.03>>
                    //   //'</ExpirationDate><BaseQty>' + FORMAT(ItemLedgerEntry.Quantity,0,'<Standard Format,3>') + '</BaseQty><StrengthSpecCode>' + ItemLedgerEntry."Strength Spec. Code" +
                    //   '</ExpirationDate><BaseQty>' + BaseQtyString + '</BaseQty><StrengthSpecCode>' + ItemLedgerEntry."Strength Spec. Code" +
                    //   //HEI.03<<
                    //   '</StrengthSpecCode><StrengthSpecValue>' + FORMAT(ItemLedgerEntry."Strength Spec. Value") + '</StrengthSpecValue></TrackingSpecification>';
                    //// BC Upgrade KUMARS145 DotNet code commented......<<

                    until ItemEntryRelation.NEXT() = 0;

                CDataRequest += CDataTrackingSpec;

                //Line Dimensions
                if TransferReceiptLine."Dimension Set ID" <> 0 then begin
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", TransferReceiptLine."Dimension Set ID");
                    if DimensionSetEntry.FindSet() then
                        repeat
                            Dimension.Reset();
                            DimensionValue.Reset();
                            CLear(DimCode);
                            CLear(DimValue);

                            Dimension.SetRange(Code, DimensionSetEntry."Dimension Code");
                            Dimension.SETFILTER("Map-to IC Dimension Code", '<>%1', '');
                            if Dimension.FindFirst() then begin
                                DimensionValue.SetRange("Dimension Code", DimensionSetEntry."Dimension Code");
                                DimensionValue.SetRange(Code, DimensionSetEntry."Dimension Value Code");
                                DimensionValue.SetRange("Map-to IC Dimension Code", Dimension."Map-to IC Dimension Code");
                                DimensionValue.SETFILTER("Map-to IC Dimension Value Code", '<>%1', '');
                                if DimensionValue.FindFirst() then begin
                                    DimCode := DimensionValue."Map-to IC Dimension Code";
                                    DimValue := DimensionValue."Map-to IC Dimension Value Code";
                                end;
                            end;

                            if (DimCode = '') and (DimValue = '') then begin
                                DimCode := DimensionSetEntry."Dimension Code";
                                DimValue := DimensionSetEntry."Dimension Value Code";
                            end;

                            //// BC Upgrade KUMARS145 DotNet code commented......>>
                            // XMLCurrNode5 := XMLDoc.CreateElement('LineDimensions');
                            // XMLCurrNode3.AppendChild(XMLCurrNode5);

                            // XMLDOMMgt.AddElement(XMLCurrNode5, 'LineDimensionCode', DimCode, '', NewChildNode);
                            // XMLDOMMgt.AddElement(XMLCurrNode5, 'LineDimensionValue', DimValue, '', NewChildNode);
                            //// BC Upgrade KUMARS145 DotNet code commented......<<

                            CDataDimensionL += '<LineDimensions><LineDimensionCode>' + DimCode + '</LineDimensionCode><LineDimensionValue>' + DimValue + '</LineDimensionValue></LineDimensions>';

                        until DimensionSetEntry.NEXT() = 0;
                end;

                CDataDimensionL += '</TransferOrderLine>';
                CDataRequest += CDataDimensionL;
            until TransferReceiptLine.NEXT() = 0;

    end;

    // BC Upgrade KUMARS145 DotNet code commented.........>>
    // local procedure CreateRequestAPI(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";

    // var
    //     TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW");
    // var
    //     XMLDOMMgt: Codeunit "XML DOM Management";
    //     // XMLEnvelopeNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet variable commented.
    //     // XMLHeaderNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet variable commented.
    //     // XMLBodyNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet variable commented.
    //     // XMLTONode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet variable commented.
    //     // XMLRequestNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet variable commented.
    //     StrXmlNodeValue: Text;
    //     // XMLCDataNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet code commented.
    //     OutputStream: OutStream;
    // begin
    //     XMLDoc := XMLDoc.XmlDocument;

    //     XMLDOMMgt.AddRootElementWithPrefix(XMLDoc, 'Envelope', 'soapenv', 'http://schemas.xmlsoap.org/soap/envelope/', XMLEnvelopeNode);
    //     XMLDOMMgt.AddAttribute(XMLEnvelopeNode, 'xmlns:ict', 'urn:microsoft-dynamics-schemas/codeunit/ICTransferOrderWS');
    //     XMLDOMMgt.AddElementWithPrefix(XMLEnvelopeNode, 'Header', '', 'soapenv', 'http://schemas.xmlsoap.org/soap/envelope/', XMLHeaderNode);
    //     XMLDOMMgt.AddElementWithPrefix(XMLEnvelopeNode, 'Body', '', 'soapenv', 'http://schemas.xmlsoap.org/soap/envelope/', XMLBodyNode);
    //     XMLDOMMgt.AddElementWithPrefix(XMLBodyNode, 'ImportTransferOrderIC', '', 'ict', 'urn:microsoft-dynamics-schemas/codeunit/ICTransferOrderWS', XMLTONode);

    //     if CDataRequest2 <> '' then
    //         StrXmlNodeValue := CDataRequest2
    //     else
    //         StrXmlNodeValue := CDataRequest + '</TransferOrder>';

    //     XMLCDataNode := XMLDoc.CreateCDataSection(StrXmlNodeValue);

    //     XMLDOMMgt.AddElementWithPrefix(XMLTONode, 'request', '', 'ict', 'urn:microsoft-dynamics-schemas/codeunit/ICTransferOrderWS', XMLRequestNode);
    //     XMLRequestNode.AppendChild(XMLCDataNode);

    //     //Save Request message for re-send
    //     TransferOrderICLogEntry.CALCFIELDS("Request Message");
    //     TransferOrderICLogEntry."Request Message".CREATEOUTSTREAM(OutputStream);
    //     XMLDoc.Save(OutputStream);
    //     TransferOrderICLogEntry.Modify(true);
    // end;
    procedure ProcessRequestAPI(
    // var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; // BC Upgrade KUMARS145 DotNet variable commented.
    // XMLResponse: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument"; // BC Upgrade KUMARS145 DotNet variable commented.
    var TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW")
    // ICWebServiceSetup: Record "IC Web Service Setup"); // BC Upgrade KUMARS145 Drinkit variable commented.
    var
        // XMLNodeList: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNodeList"; // BC Upgrade KUMARS145 DotNet variable commented.
        // DOMNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode"; // BC Upgrade KUMARS145 DotNet variable commented.
        i: Integer;
    begin
        // BC Upgrade KUMARS145 DotNet code commented.....>>
        // if not SendAPIRequest(XMLDoc, XMLResponse, ICWebServiceSetup."Web Service URL", ICWebServiceSetup."Web Service Name", ICWebServiceSetup.Login, ICWebServiceSetup.Password) then begin
        //     TransferOrderICLogEntry."Last Error" := GETLASTERRORTEXT();
        //     TransferOrderICLogEntry.Modify(true);
        // end else begin
        //     TransferOrderICLogEntry.Status := TransferOrderICLogEntry.Status::"Transfer Posted";

        //     //Process Response Message
        //     XMLNodeList := XMLResponse.ChildNodes;

        //     for i := 0 to XMLNodeList.Count - 1 do begin
        //         DOMNode := XMLNodeList.Item(i);
        //         // ParseXMLForDocumentNo(DOMNode);// BC Upgrade KUMARS145 DotNet code commented.
        //     end;
        // BC Upgrade KUMARS145 DotNet code commented.....<<

        if ResponseText <> '' then begin
            if STRPOS(ResponseText, '<CreatedTransferOrderNo>') > 0 then begin
                ResponseText := DELSTR(ResponseText, 1, 37);
                if STRPOS(ResponseText, '</CreatedTransferOrderNo>') > 0 then
                    ResponseText := DELSTR(ResponseText, STRLEN(ResponseText) - 36);

                TransferOrderICLogEntry."Created Document No." := ResponseText;
                TransferOrderICLogEntry.Status := TransferOrderICLogEntry.Status::Done;
                if TransferOrderICLogEntry."Last Error" <> '' then
                    TransferOrderICLogEntry."Last Error" := '';
            end else
                if STRPOS(ResponseText, '<ErrorMsg') > 0 then begin
                    ResponseText := DELSTR(ResponseText, 1, 23);
                    if STRPOS(ResponseText, '</ErrorMsg>') > 0 then
                        ResponseText := DELSTR(ResponseText, STRLEN(ResponseText) - 22);
                    TransferOrderICLogEntry."Last Error" := ResponseText;
                end;

            TransferOrderICLogEntry.Modify(true);
        end;
        // end; // BC Upgrade KUMARS145 DotNet code commented.

        //HEI.06>>
        // CLear(XMLNodeList);// BC Upgrade KUMARS145 DotNet code commented.
        // CLear(DOMNode);// BC Upgrade KUMARS145 DotNet code commented.
        //HEI.06<<
    end;
    // BC Upgrade KUMARS145 DotNet code commented.........>>
    // local procedure CreateResponseXML(var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument");
    // var
    //     XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    //     XMLDOMMgt: Codeunit "XML DOM Management";
    //     NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";
    // begin
    //     CLear(CDataRequest2);

    //     XMLDoc := XMLDoc.XmlDocument;
    //     XMLCurrNode := XMLDoc.CreateElement('Response');
    //     XMLDoc.AppendChild(XMLCurrNode);

    //     if CreatedTransferOrderNo2 <> '' then begin
    //         XMLDOMMgt.AddElement(XMLCurrNode, 'CreatedTransferOrderNo', CreatedTransferOrderNo2, '', NewChildNode);
    //         CDataRequest2 := '<Response><CreatedTransferOrderNo>' + CreatedTransferOrderNo2 + '</CreatedTransferOrderNo></Response>';
    //     end else begin
    //         XMLDOMMgt.AddElement(XMLCurrNode, 'ErrorMsg', LastErrorMsg, '', NewChildNode);
    //         CDataRequest2 := '<Response><ErrorMsg>' + LastErrorMsg + '</ErrorMsg></Response>';
    //     end;

    //     //HEI.06>>
    //     CLear(XMLCurrNode);
    //     CLear(NewChildNode);
    //     //HEI.06<<
    // end;
    // BC Upgrade KUMARS145 DotNet code commented.........<<

    [TryFunction]
    // BC Upgrade KUMARS145 DotNet code commented.........>>
    // local procedure SendAPIRequest(
    // // var XMLRequest: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";// BC Upgrade KUMARS145 DotNet Variables are commented.
    // // var XMLResponse: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";// BC Upgrade KUMARS145 DotNet Variables are commented.
    //     ServiceURL: Text;
    //     SoapAction: Text;
    //     UserName: Text;
    //     PasswordKey: Text);
    // var
    //     // HttpWebRequest: DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.HttpWebRequest";// BC Upgrade KUMARS145 DotNet Variables are commented.
    //     // HttpWebResponse: DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.HttpWebResponse";// BC Upgrade KUMARS145 DotNet Variables are commented.
    //     // Credentials: DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.NetworkCredential";// BC Upgrade KUMARS145 DotNet Variables are commented.
    //       GeneralInterfaceSetup: Record "General Interface Setup INT";// BC Upgrade KUMARS145 crated in INTERFACES Extension.
    //     // ServicePointMgr: DotNet "'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Net.ServicePointManager";// BC Upgrade KUMARS145 DotNet Variables are commented.
    //     ProcessingWindow: Dialog;
    // begin
    //     GeneralInterfaceSetup.GET;
    //     if GeneralInterfaceSetup."Use TLS1.1 TLS1.2" then
    //         ServicePointMgr.SecurityProtocol := 48 + 192 + 768 + 3072 //48 - Ssl3, 192 - Tls, Tls11 - 768, Tls2 - 3072
    //     else
    //         ServicePointMgr.SecurityProtocol := 48 + 192; //48 - Ssl3, 192 - Tls (DEFAULT - DotNET 4.5.2)

    //     ProcessingWindow.OPEN(ProcessingWindowMsg);

    //     HttpWebRequest := HttpWebRequest.Create(ServiceURL);
    //     HttpWebRequest.Method := 'POST';
    //     HttpWebRequest.KeepAlive := true;
    //     HttpWebRequest.AllowAutoRedirect := true;
    //     HttpWebRequest.UseDefaultCredentials := false;
    //     HttpWebRequest.KeepAlive := false;
    //     Credentials := Credentials.NetworkCredential(UserName, PasswordKey);
    //     HttpWebRequest.Credentials := Credentials;
    //     HttpWebRequest.Headers.Add('SOAPAction', SoapAction);
    //     HttpWebRequest.ContentType := 'text/xml;charset=utf-8';
    //     HttpWebRequest.Timeout := 600000;
    //     XMLRequest.Save(HttpWebRequest.GetRequestStream);

    //     HttpWebResponse := HttpWebRequest.GetResponse;
    //     XMLResponse.Load(HttpWebResponse.GetResponseStream);

    //     ProcessingWindow.CLOSE();

    //     //HEI.06>>
    //     CLear(HttpWebRequest);
    //     CLear(HttpWebResponse);
    //     CLear(Credentials);
    //     CLear(ServicePointMgr);
    //     //HEI.06<<
    // end;
    // BC Upgrade KUMARS145 DotNet code commented.........<<

    // BC Upgrade KUMARS145 DotNet code commented........>>
    // local procedure CreateResponseRequestXML(
    //     // var XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";// BC Upgrade KUMARS145 DotNet Variables are commented.
    //     DocumentNo: Code[20]);
    // var
    //     // XMLCurrNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables are commented.
    //     XMLDOMMgt: Codeunit "XML DOM Management";
    // // NewChildNode: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlNode";// BC Upgrade KUMARS145 DotNet Variables are commented.
    // begin
    //     CLear(CDataRequest2);

    //     XMLDoc := XMLDoc.XmlDocument;
    //     XMLCurrNode := XMLDoc.CreateElement('Response');
    //     XMLDoc.AppendChild(XMLCurrNode);

    //     XMLDOMMgt.AddElement(XMLCurrNode, 'TransferOrderNo', DocumentNo, '', NewChildNode);
    //     CDataRequest2 := '<Response><TransferOrderNo>' + DocumentNo + '</TransferOrderNo>';

    //     if CreatedTransferOrderNo2 <> '' then begin
    //         XMLDOMMgt.AddElement(XMLCurrNode, 'CreatedTransferOrderNo', CreatedTransferOrderNo2, '', NewChildNode);
    //         CDataRequest2 += '<CreatedTransferOrderNo>' + CreatedTransferOrderNo2 + '</CreatedTransferOrderNo></Response>';
    //     end else begin
    //         XMLDOMMgt.AddElement(XMLCurrNode, 'ErrorMsg', LastErrorMsg, '', NewChildNode);
    //         CDataRequest2 += '<ErrorMsg>' + LastErrorMsg + '</ErrorMsg></Response>';
    //     end;

    //     //HEI.06>>
    //     CLear(XMLCurrNode);
    //     CLear(NewChildNode);
    //     //HEI.06<<
    // end;
    // BC Upgrade KUMARS145 DotNet code commented.........<<

    // BC Upgrade KUMARS145 DotNet code commented.........>>
    procedure SendAPIResponse(var TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW");
    var
    // // XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";// BC Upgrade KUMARS145 DotNet Variables are commented.
    // // XMLResponse: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";// BC Upgrade KUMARS145 DotNet Variables are commented.
    // // ICWebServiceSetup: Record "IC Web Service Setup";// BC Upgrade KUMARS145 Drinkit Variables are commented.
    begin
        //     CLear(LastErrorMsg);
        //     CLear(CreatedTransferOrderNo2);

        //     //ICWebServiceSetup.SetRange("Mapping Code",'TRANSFER');
        //     ICWebServiceSetup.SetRange("Sending Type", ICWebServiceSetup."Sending Type"::Transfer);
        //     ICWebServiceSetup.SetRange("To Database", TransferOrderICLogEntry."From Company");
        //     ICWebServiceSetup.FindFirst();

        //     LastErrorMsg := TransferOrderICLogEntry."Last Error";
        //     CreatedTransferOrderNo2 := TransferOrderICLogEntry."Created Document No.";

        //     CreateResponseRequestXML(XMLDoc, TransferOrderICLogEntry."Document No.");
        //     CreateRequestAPI(XMLDoc, TransferOrderICLogEntry);

        //     XMLResponse := XMLResponse.XmlDocument;

        //     if not SendAPIRequest(XMLDoc, XMLResponse, ICWebServiceSetup."Web Service URL", ICWebServiceSetup."Web Service Name", ICWebServiceSetup.Login, ICWebServiceSetup.Password) then begin
        //         TransferOrderICLogEntry."Last Error" := GETLASTERRORTEXT;
        //         TransferOrderICLogEntry.Modify(true);
        //     end else begin
        //         TransferOrderICLogEntry.Status := TransferOrderICLogEntry.Status::"Posting info. Exported";
        //         if CreatedTransferOrderNo2 <> '' then
        //             if TransferOrderICLogEntry."Last Error" <> '' then
        //                 TransferOrderICLogEntry."Last Error" := '';
        //         TransferOrderICLogEntry.Modify(true);
        //     end;

        //     //HEI.06>>
        //     CLear(XMLDoc);
        //     CLear(XMLResponse);
        //     //HEI.06<<
    end;
    // BC Upgrade KUMARS145 DotNet code commented.........<<

    // BC Upgrade KUMARS145 dependent on Drinkit table commented.....>>
    // local procedure CheckICWebServiceSetup(
    //     WarehouseShipmentLineBuffer: Record "Warehouse Shipment Line" temporary;
    //     var ICWebServiceSetup: Record "IC Web Service Setup");
    // var
    //     Location: Record Location;
    //     TransferHeader: Record "Transfer Header";
    // begin
    //     //Check IC WebService Setup
    //     if TransferHeader.GET(WarehouseShipmentLineBuffer."Source No.") then
    //         Location.GET(TransferHeader."Transfer-to Code");

    //     //ICWebServiceSetup.SetRange("Mapping Code",'TRANSFER');
    //     ICWebServiceSetup.SetRange("Sending Type", ICWebServiceSetup."Sending Type"::Transfer);
    //     ICWebServiceSetup.SetRange("IC Location", Location.Code);
    //     if not ICWebServiceSetup.FindFirst() then
    //         ERROR(ICWebServiceNotFoundErr, 'TRANSFER', Location."IC Partner Code");

    //     //Check Interface Setup
    //     ICWebServiceSetup.TESTFIELD("Web Service URL");
    //     ICWebServiceSetup.TESTFIELD(Login);
    //     ICWebServiceSetup.TESTFIELD(Password);
    // end;
    // BC Upgrade KUMARS145 dependent on Drinkit table commented.....<<

    local procedure PostTransferOrderReceipt(WarehouseShipmentLineBuffer: Record "Warehouse Shipment Line" temporary);
    var
        TransferHeader: Record "Transfer Header";
        TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt";
    begin
        TransferHeader.GET(WarehouseShipmentLineBuffer."Source No.");
        TransferOrderPostReceipt.RUN(TransferHeader);
    end;

    local procedure CreateTransferOrderICLogEntry(
        WarehouseShipmentLineBuffer: Record "Warehouse Shipment Line" temporary;
        // ICWebServiceSetup: Record "IC Web Service Setup"; // BC Upgrade KUMARS145 Drinkit Variable commented.
        var TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW");
    begin
        TransferOrderICLogEntry.Init();
        TransferOrderICLogEntry."Source Type" := TransferOrderICLogEntry."Source Type"::Transfer;
        TransferOrderICLogEntry."Document Type" := TransferOrderICLogEntry."Document Type"::"Transfer Order";
        TransferOrderICLogEntry."Document No." := WarehouseShipmentLineBuffer."Source No.";
        TransferOrderICLogEntry."From Company" := CompanyName;
        // TransferOrderICLogEntry."To Company" := ICWebServiceSetup."To Database";// BC Upgrade KUMARS145 Drinkit code commented.
        TransferOrderICLogEntry.Insert();
        TransferOrderICLogEntry."Created Document Type" := TransferOrderICLogEntry."Created Document Type"::"Transfer Order";
        TransferOrderICLogEntry."Creation Date" := WorkDate();
        TransferOrderICLogEntry."Creation Time" := TIME;
        TransferOrderICLogEntry."User ID" := UserId;
        TransferOrderICLogEntry.Status := TransferOrderICLogEntry.Status::"Transfer Exported";
        TransferOrderICLogEntry.Modify(true);
    end;

    local procedure UpdateRequestXMLTransferOrderICLogEntry(
    // XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";// BC Upgrade KUMARS145 DotNet Variables are commented.
    var TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW");
    var
        OutputStream: OutStream;
    begin
        TransferOrderICLogEntry.CALCFIELDS("Request File");
        TransferOrderICLogEntry."Request File".CREATEOUTSTREAM(OutputStream);
        // XMLDoc.Save(OutputStream);// BC Upgrade KUMARS145 DotNet code commented.
        TransferOrderICLogEntry.Modify(true);
    end;

    local procedure CreateTransferOrderICLogEntryReceive(Request: BigText; var TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW");
    var
        OutputStream: OutStream;
    begin
        TransferOrderICLogEntry.Init();
        TransferOrderICLogEntry."Source Type" := TransferOrderICLogEntry."Source Type"::Transfer;
        TransferOrderICLogEntry."Document Type" := TransferOrderICLogEntry."Document Type"::"Transfer Order";
        TransferOrderICLogEntry."Document No." := FromTransferOrderNo;
        TransferOrderICLogEntry."From Company" := FromCompany;
        TransferOrderICLogEntry.Insert();
        TransferOrderICLogEntry."Created Document Type" := TransferOrderICLogEntry."Created Document Type"::"Transfer Order";
        TransferOrderICLogEntry."Creation Date" := WorkDate();
        TransferOrderICLogEntry."Creation Time" := TIME;
        TransferOrderICLogEntry."User ID" := UserId;
        TransferOrderICLogEntry.Status := TransferOrderICLogEntry.Status::"Transfer Imported";
        TransferOrderICLogEntry."To Company" := CompanyName;
        TransferOrderICLogEntry."Created Document Type" := TransferOrderICLogEntry."Created Document Type"::"Transfer Order";

        TransferOrderICLogEntry."Request File".CREATEOUTSTREAM(OutputStream);
        Request.WRITE(OutputStream);
        TransferOrderICLogEntry.Modify(true);
    end;

    local procedure CreateTransferOrderXMLBuffer(WarehouseShipmentLineBuffer: Record "Warehouse Shipment Line" temporary; var TempTransferHeaderBuffer: Record "Transfer Header" temporary);
    var
        TransferHeader: Record "Transfer Header";
    begin
        if TransferHeader.GET(WarehouseShipmentLineBuffer."Source No.") then begin
            TempTransferHeaderBuffer.Init();
            TempTransferHeaderBuffer := TransferHeader;
            TempTransferHeaderBuffer.Insert();
        end;
    end;

    local procedure ProcessNegativeStockAdjustment(
        SourceNo: Code[20]//;
    // ICWebServiceSetup: Record "IC Web Service Setup"// BC Upgrade KUMARS145 Dependent on Drinkit table commented.
    );
    var
        // GeneralInterfaceSetup: Record "General Interface Setup INT";// BC Upgrade KUMARS145 Dependent on Drinkit table commented.
        TransferReceiptHeader: Record "Transfer Receipt Header";
        TransferReceiptLine: Record "Transfer Receipt Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine2: Record "Item Journal Line";
        ItemJournalLine3: Record "Item Journal Line";
        ItemJournalBatch: Record "Item Journal Batch";
        LineNo2: Integer;
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        // GeneralInterfaceSetup.Get();// BC Upgrade KUMARS145 Dependent on Drinkit table commented.
        // ItemJournalBatch.GET(GeneralInterfaceSetup."IC Item Jnl Template", GeneralInterfaceSetup."IC Item Jnl Batch");// BC Upgrade KUMARS145 Dependent on Drinkit table commented.

        TransferReceiptHeader.SetRange("Transfer Order No.", SourceNo);
        if TransferReceiptHeader.FindFirst() then begin
            CLear(ItemJournalLine);

            TransferReceiptLine.SetRange("Document No.", TransferReceiptHeader."No.");
            if TransferReceiptLine.FindSet() then
                repeat
                    //Delete existing empty lines
                    // ItemJournalLine3.SetRange("Journal Template Name", GeneralInterfaceSetup."IC Item Jnl Template");// BC Upgrade KUMARS145 Dependent on Drinkit table commented.
                    // ItemJournalLine3.SetRange("Journal Batch Name", GeneralInterfaceSetup."IC Item Jnl Batch");// BC Upgrade KUMARS145 Dependent on Drinkit table commented.
                    ItemJournalLine3.SetRange("Item No.", '');
                    if ItemJournalLine3.FindFirst() then
                        ItemJournalLine3.DeleteAll();

                    ItemJournalLine.Init();
                    // ItemJournalLine.Validate("Journal Template Name", GeneralInterfaceSetup."IC Item Jnl Template");// BC Upgrade KUMARS145 Dependent on Drinkit table commented.
                    // ItemJournalLine.Validate("Journal Batch Name", GeneralInterfaceSetup."IC Item Jnl Batch");// BC Upgrade KUMARS145 Dependent on Drinkit table commented.

                    ItemJournalLine2.Reset();
                    // ItemJournalLine2.SetRange("Journal Template Name", GeneralInterfaceSetup."IC Item Jnl Template");// BC Upgrade KUMARS145 Dependent on Drinkit table commented.
                    // ItemJournalLine2.SetRange("Journal Batch Name", GeneralInterfaceSetup."IC Item Jnl Batch");// BC Upgrade KUMARS145 Dependent on Drinkit table commented.
                    if ItemJournalLine2.FindLast() then
                        LineNo2 := ItemJournalLine2."Line No." + 10000
                    else
                        LineNo2 := 10000;
                    ItemJournalLine.Validate("Line No.", LineNo2);
                    ItemJournalLine.Insert(true);
                    // ItemJournalLine.Validate("Gen. Bus. Posting Group", ICWebServiceSetup.BPG);// BC Upgrade KUMARS145 Dependent on Drinkit table commented.
                    ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::Sale);
                    ItemJournalLine.Validate("Posting Date", TransferReceiptHeader."Posting Date");
                    ItemJournalLine.Validate("Document No.", TransferReceiptHeader."Transfer Order No.");
                    ItemJournalLine.Validate("Item No.", TransferReceiptLine."Item No.");
                    ItemJournalLine.Validate("Location Code", TransferReceiptHeader."Transfer-to Code");
                    ItemJournalLine.Validate(Quantity, TransferReceiptLine.Quantity);
                    ItemJournalLine.Validate("Unit of Measure Code", TransferReceiptLine."Unit of Measure Code");
                    //HEI.04>>
                    ItemJournalLine."Reporting Type FND" := ItemJournalLine."Reporting Type FND"::"Interregional Transfer Outbound";
                    //HEI.04<<

                    //Reservation Entries
                    ItemEntryRelation.Reset();
                    ItemLedgerEntry.Reset();
                    ItemEntryRelation.SetRange("Source Type", DATABASE::"Transfer Receipt Line");
                    ItemEntryRelation.SetRange("Source ID", TransferReceiptLine."Document No.");
                    ItemEntryRelation.SetRange("Source Ref. No.", TransferReceiptLine."Line No.");
                    if ItemEntryRelation.FindSet() then
                        repeat
                            ItemLedgerEntry.GET(ItemEntryRelation."Item Entry No.");
                        // BC Upgrade KUMARS145 Dependent on Drinkit field commented......>>
                        // CreateReservationEntry(ItemLedgerEntry.Quantity, ItemLedgerEntry."Qty. per Unit of Measure", DATABASE::"Item Journal Line", ItemJournalLine."Entry Type",
                        //   ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name", ItemJournalLine."Line No.", ItemJournalLine."Item No.", ItemJournalLine."Location Code",
                        //   ItemJournalLine."Bin Code", ItemLedgerEntry."Lot No.", ItemLedgerEntry."Expiration Date", ItemLedgerEntry."Strength Spec. Code", ItemLedgerEntry."Strength Spec. Value");
                        // BC Upgrade KUMARS145 Dependent on Drinkit table commented.......<<
                        until ItemEntryRelation.NEXT() = 0;
                    ItemJournalLine.Modify(true);

                    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJournalLine);

                until TransferReceiptLine.NEXT() = 0;
        end;
    end;

    local procedure CreateReservationEntry(SourceBaseQty: Decimal; SourceQtyPerUoM: Decimal; SourceType: Integer; SourceSubtype: Option "0","1","2","3","4","5","6","7","8","9","10"; SourceID: Code[20]; SourceBatch: Code[10]; SourceLineNo: Integer; SourceIntemNo: Code[20]; SourceLocationCode: Code[10]; SourceBin: Code[10]; SourceLotNo: Code[20]; ExpirationDate: Date; StrengthSpecCode: Code[20]; StrengthSpecValue: Decimal);
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        LotNoInformation: Record "Lot No. Information";
        NewLot: Boolean;
    begin
        LotNoInformation.Reset();
        LotNoInformation.SetRange("Lot No.", SourceLotNo);
        LotNoInformation.SetRange("Item No.", SourceIntemNo);
        NewLot := not LotNoInformation.FindFirst();

        ReservationEntry.Reset();
        ReservationEntry.Init();
        if ReservationEntry2.FindLast() then
            ReservationEntry.Validate("Entry No.", ReservationEntry2."Entry No." + 1);

        ReservationEntry."Source Type" := SourceType;
        ReservationEntry."Source Subtype" := SourceSubtype;
        ReservationEntry."Source ID" := SourceID;
        ReservationEntry."Source Batch Name" := SourceBatch;
        ReservationEntry."Source Ref. No." := SourceLineNo;
        ReservationEntry."Creation Date" := WorkDate();
        ReservationEntry."Created By" := UserId;
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        ReservationEntry.Validate("Item No.", SourceIntemNo);
        ReservationEntry.Validate("Location Code", SourceLocationCode);
        // ReservationEntry.Validate("Bin Code", SourceBin);  // BC Upgrade KUMARS145 Dependent on Drinkit field commented.
        ReservationEntry.Validate("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
        ReservationEntry.Validate("Lot No.", SourceLotNo);
        if NewLot then
            ReservationEntry.Validate("Expiration Date", ExpirationDate);
        ReservationEntry.Validate(Quantity, -SourceBaseQty / SourceQtyPerUoM);
        ReservationEntry.Validate("Quantity (Base)", -SourceBaseQty);
        ReservationEntry.Validate("Qty. to Handle (Base)", ReservationEntry."Quantity (Base)");
        ReservationEntry.Positive := ReservationEntry.Quantity > 0;
        // ReservationEntry."Strength Spec. Code" := StrengthSpecCode;// BC Upgrade KUMARS145 Dependent on Drinkit field commented.
        // ReservationEntry."Strength Spec. Value" := StrengthSpecValue;// BC Upgrade KUMARS145 Dependent on Drinkit field commented.
        ReservationEntry.Insert(true);
    end;
    // BC Upgrade KUMARS145 Dependent on Drinkit table commented....>>
    // local procedure SaveRequestToDirectory(
    // ICWebServiceSetup: Record "IC Web Service Setup"; // BC Upgrade KUMARS145 Dependent on Drinkit table commented.
    //     TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW";
    //      var FileName: Text);
    // var
    //     InputStream: InStream;
    //     OutputStream: OutStream;
    //     FileManagement: Codeunit "File Management";
    //     TempBlob: Codeunit "Temp Blob";// Record TempBlob temporary;
    // begin
    //     if TransferOrderICLogEntry."Request File".HASVALUE then begin
    //         CheckDirectory(ICWebServiceSetup."XML Save Location" + '\' + ICWebServiceSetup."To Database");
    //         FileName := ICWebServiceSetup."XML Save Location" + '\' + ICWebServiceSetup."To Database" + '\Request' + '_' + TransferOrderICLogEntry."Document No.";
    //         TransferOrderICLogEntry.CALCFIELDS("Request File");
    //         TransferOrderICLogEntry."Request File".CREATEINSTREAM(InputStream);
    //     end;

    //     TempBlob.CreateOutStream(OutputStream);// .Blob.CREATEOUTSTREAM(OutputStream);
    //     COPYSTREAM(OutputStream, InputStream);
    //     FileManagement.BLOBExportToServerFile(TempBlob, FileName + '.xml');
    // end;
    // BC Upgrade KUMARS145 Dependent on Drinkit table commented......<<

    // BC Upgrade KUMARS145 DotNet code commented.....>>
    // local procedure CheckDirectory(PathName: Text): Boolean;
    // var
    // // SystemIODirectory: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.Directory";// BC Upgrade KUMARS145 DotNet Variable commented.
    // begin
    //     if SystemIODirectory.Exists(PathName) then
    //         exit(true)
    //     else begin
    //         SystemIODirectory.CreateDirectory(PathName);
    //         exit(true);
    //     end;
    // end;
    // BC Upgrade KUMARS145 DotNet code commented.....>>

    local procedure CheckNumberFormat(ValueToConvert: Text) ValueConverted: Text;
    var
        ValueConverted2: Text;
        DefaultDecimalSeparator: Text;
    begin
        //HEI.03>>
        DefaultDecimalSeparator := COPYSTR(FORMAT(1 / 2), 2, 1);

        if DefaultDecimalSeparator = '.' then
            ValueConverted := ValueToConvert
        else
            if DefaultDecimalSeparator = ',' then begin
                ValueConverted2 := CONVERTSTR(ValueToConvert, ',', '.');
                ValueConverted := DELCHR(ValueConverted2, '=', DELCHR(ValueConverted2, '=', '1234567890.'));
            end;
        //HEI.03<<
    end;
}

